Return-Path: <netdev+bounces-106678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56D917392
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34850282281
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6485C17DE31;
	Tue, 25 Jun 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xd7xbvHP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fG2hs6PZ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CD17DE17;
	Tue, 25 Jun 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351268; cv=none; b=l3KffkhG9C1bdSNPI1vmC45CchKEs9KaJVMx9xPzPsjjA5HPcxiSgd/CZfuoQ90tnWuF59WxqKFkkiURLosEzQXhHis2v62ksgCGNki25+yVOV8E7Wv02ibg0G6rRSCcy9T1Jh7GmeyeNLCSMiINO1Cq6thiHNIc69WtwJJHbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351268; c=relaxed/simple;
	bh=HfaYGuuRwJRfrYo4iNSGZYDprWu7BbdzxDPdNxmmntI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=aPSnZk+pnVSXd7kL2y3W3e5gsifiUhX8aLxE7+DA/Z98W4UJzWjJby/WPCF5DbBwKtBY4eJ9SRrHo6yiXEgUcOdeHM0u6fK+NNlke3MvDFR5eeGM66aP1iVmw94iizkxhxkxEQkyDVJgMYpVRPmr1HjffqY1tRbBxkSWEcI342o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xd7xbvHP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fG2hs6PZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719351265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=cBD4zAiF08Tny5sO1Gl2HsuBxAKc5MasJfQRkmugnwI=;
	b=xd7xbvHPrn0WWfzg6B74Sg+5WddYaCIiEgHS+QlK6NmVrMF20WaHrkqdQfEMAYH8W0Lebe
	jomz94JOpYib8BIKcjNhQgcCBrkX+NSLbumPeu56wdF4zMiNMJ+lXwB9GfP/L3ZVFt923O
	gDVbv6trHv1Me6PNZWEJvST0AR+biixf/+ieWv0lKZWqvdhSxWCmauQynkfOgfCLuEg8MY
	bwApIHOJDPq3ZzOZf1v5D/aDLePpYqMAV1v5Fl0SCwxw8D9h1lnO3eIUfE5l+utbW5PKc/
	KssfZ8E6EdpbwOiQ9H5qzUCFeD9UW6q7uvCfMGvAM8p6xqZRdVzgPo8LiBTqYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719351265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=cBD4zAiF08Tny5sO1Gl2HsuBxAKc5MasJfQRkmugnwI=;
	b=fG2hs6PZ+vtjj+L3x1f4wBjXlrHsTMYW87osvADsyB7iust7q/iXbfYchPW6bVeSfgjt11
	Kgiu2FLgNLLz/ADQ==
To: David Woodhouse <dwmw2@infradead.org>, Peter Hilber
 <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux,
 Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev, "Luu, Ryan"
 <rluu@amazon.com>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>, Jason Wang
 <jasowang@redhat.com>, John Stultz <jstultz@google.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc
 Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RFC PATCH v2] ptp: Add vDSO-style vmclock support
In-Reply-To: <4a0a240dffc21dde4d69179288547b945142259f.camel@infradead.org>
Date: Tue, 25 Jun 2024 23:34:24 +0200
Message-ID: <87jzic4sgv.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 20:01, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
>
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
>
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.

There is effort underway to expose PTP clocks to user space via
VDSO. Can we please not expose an ad hoc interface for that?

As you might have heard the sad news, I'm not feeling up to the task to
dig deeper into this right now. Give me a couple of days to look at this
with working brain.

Thanks,

        tglx

