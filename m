Return-Path: <netdev+bounces-211496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E3B196DC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 01:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8C1730E2
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949820102B;
	Sun,  3 Aug 2025 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synclab.org header.i=@synclab.org header.b="fI8AleRE"
X-Original-To: netdev@vger.kernel.org
Received: from m43-13.mailgun.net (m43-13.mailgun.net [69.72.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757086359
	for <netdev@vger.kernel.org>; Sun,  3 Aug 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.43.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265107; cv=none; b=o7fZ/Ms0rhCQBBdfWBk+KK+PNaFbjl/xSuQftOKOYOJ6N8oKWlGuBiPKlXrRq0BodK79JvWOcdv8Bwz/EnhK7aZ1/76ZXLwdfbH+tdK7GhaoFYJRy668XAc7jH9X20p1wKknDyNRnBF4MKEahacYfFFW7Zt1rlwhUbiALLW8h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265107; c=relaxed/simple;
	bh=bl76MyiFjbiW2EETlyWCdkK9zwidyAdNAWP0CHL/rxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ip4qqZwoxiXxdFR2UvXkWRAK7+EGjBsW0/0GKHkWnw88BdRTXsbLUnPjK1I0KsuHMlQNlxAP9b1z8pogZ9NwnNcOU70bSkLgqlRui6jGMzG+XZmtYQ1ZGbq0rMM5bPWXNPxmK9nJcHO/A3WyN0LyRIS1KudOA1BvTbcbMVJdz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=synclab.org; spf=pass smtp.mailfrom=synclab.org; dkim=pass (1024-bit key) header.d=synclab.org header.i=@synclab.org header.b=fI8AleRE; arc=none smtp.client-ip=69.72.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=synclab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synclab.org
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=synclab.org; q=dns/txt; s=mailo; t=1754265104; x=1754272304;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=bl76MyiFjbiW2EETlyWCdkK9zwidyAdNAWP0CHL/rxQ=;
 b=fI8AleRE/1+FCIcQ6yyKatqVURFQ8yXfUGRzb+FuoIzRxATQcgn/C9IuRyX4aQZQ2LrWcgcS+IWzr6MADF+nfOzwZY5gGeASAgrUPgS+MWN/rldbndW6VOCv13nk+PJZD9T1m9O5A3xY7FNUnBB+vXwhxSlssRBGMnsviVNWFAw=
X-Mailgun-Sid: WyJkNWM2YyIsIm5ldGRldkB2Z2VyLmtlcm5lbC5vcmciLCI2M2VhOSJd
Received: from 7cf34de991d5.ant.amazon.com (c-73-53-2-7.hsd1.wa.comcast.net [73.53.2.7])
 by 53ad9ba7482a with SMTP id 688ff610ba99d3f418cc5af9 (version=TLS1.3,
 cipher=TLS_CHACHA20_POLY1305_SHA256); Sun, 03 Aug 2025 23:51:44 GMT
X-Mailgun-Sending-Ip: 69.72.43.13
X-Mailgun-Batch-Id: 688ff610735b722da3f87312
Sender: julien@synclab.org
From: Julien Ridoux <julien@synclab.org>
To: mlichvar@redhat.com
Cc: akiyano@amazon.com,
	aliguori@amazon.com,
	alisaidi@amazon.com,
	amitbern@amazon.com,
	andrew@lunn.ch,
	benh@amazon.com,
	darinzon@amazon.com,
	davem@davemloft.net,
	dwmw2@infradead.org,
	dwmw@amazon.com,
	edumazet@google.com,
	evgenys@amazon.com,
	evostrov@amazon.com,
	joshlev@amazon.com,
	kuba@kernel.org,
	matua@amazon.com,
	msw@amazon.com,
	nafea@amazon.com,
	ndagan@amazon.com,
	netanel@amazon.com,
	netdev@vger.kernel.org,
	ofirt@amazon.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	ridouxj@amazon.com,
	saeedb@amazon.com,
	tglx@linutronix.de,
	zorik@amazon.com
Subject: RE: [RFC PATCH net-next] ptp: Introduce PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Date: Sun,  3 Aug 2025 16:51:42 -0700
Message-Id: <20250803235142.57900-1-julien@synclab.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aIeInmXyglMdIuxE@localhost>
References: <aIeInmXyglMdIuxE@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 7/28/25, 7:28 AM, "Miroslav Lichvar" <mlichvar@redhat.com <mailto:mlichvar@redhat.com>> wrote:
>
> On Thu, Jul 24, 2025 at 02:56:56PM +0300, David Arinzon wrote:
> > The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl offers the
> > same timestamps as the PTP_SYS_OFFSET_EXTENDED ioctl, but extends
> > it with a measurement of the PHC device clock accuracy and the
> > synchronization status. This supports two objectives.
>
>
> I have a slight issue with the naming of this new ioctl. TRUSTED
> implies to me the other supported ioctls are not to be trusted
> for some reason, but that's not the case, right? It's just more
> information provided, i.e. it's extended once again. Would
> PTP_SYS_OFFSET_EXTENDED3 or PTP_SYS_OFFSET_EXTENDED_ATTRS not work
> better?

That's a fair call. The ioctl can be renamed to PTP_SYS_OFFSET_EXTENDED_ATTRS


> It would be nice to have a new variant of the PTP_SYS_OFFSET_PRECISE
> ioctl for the ptp_kvm driver to pass the system clock maxerror and
> status.

Yes, let's add it to the patch.


> > The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl fulfills both
> > objectives by extending each PHC timestamp with two quality
> > indicators:
> >
> > - error_bound: a device-calculated value (in nanoseconds)
> > reflecting the maximum possible deviation of the timestamp from
> > the true time, based on internal clock state.
>
>
> Is this value expected to be changing so rapidly that it needs to be
> provided with each sample of the ioctl? I'd expect a maximum value
> from all samples to be sufficient (together with the worst status).

Yes, the error_bound value may be continuously changing.

It is possible for a device to implement a looser bound on the clock error,
similar to your suggestion (a worse case scenario over a "long" period of time)
for example.

But we want to offer the option to provide a tighter bound, consistent with
every clock read. Under normal conditions the error_bound reflects errors
accumulated upstream, and the maximum error the clock can gain between update.
A possible analogy: this is similar to the dispersion reported by `chronyc tracing`,
whose value is continuously changing.


> > - clock_status: a qualitative state of the clock, with defined
> > values including:
> > 1. Unknown: the clock's synchronization status cannot be
> > reliably determined.
> > 2. Initializing: the clock is acquiring synchronization.
> > 3. Synchronized: The clock is actively being synchronized and
> > maintained accurately by the device.
> > 4. FreeRunning: the clock is drifting and not being
> > synchronized and updated by the device.
> > 5. Unreliable: the clock is known to be unreliable, the
> > error_bound value cannot be trusted.
>
>
> I'd expect a holdover status to be included here.

There is no technical blocker to adding a holdover status to the list, letting
the underlying implementation decide if it needs to use this status or not.

I am, however, not convinced this is desirable. Although holdover is well
defined for timing equipment in a lab, in our experience, this introduces some
confusion and a false sense of security to the applications relying on accurate
time.

Holdover is a free running clock benefitting from some past history to make
corrections, and I see the risk of a semantic that is implementation
dependent. I would prefer that a consumer of this API decides whether to "trust"
the clock based on the clock entering the FreeRunning state, and the value of
the error_bound reported. In a sense, we have an opportunity to not offer a
footgun to the consumer of this API.

But again, adding a holdover value here does not force its use, and it can be
added now (or later) when the need arises.



