Return-Path: <netdev+bounces-210524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64CB13D16
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4401890B29
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70726D4CD;
	Mon, 28 Jul 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKF/eoC9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE6212B3D
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712819; cv=none; b=K8+8qWtTttXgh6j2GYhdhbxjVe8XoJuDcVQhuC4wFsNDAWZjVGtyzUPmOgh5EaPaF07+4Qct14r8KoZ40Ug1qm7DCwh0m60L3G4RgrAy9M7ZqzxTenbDa+TJgi7qFGNgksuVcDIK2ucdadgbbB1miYl4e1K9fwprGbbjDMKDD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712819; c=relaxed/simple;
	bh=YbLwc9gJH+0RpZdRIUsJh2iKcFPVBerkuC301z6u1io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bufcwPPoEUx1nqOexAbkaELealn/Lh2dQQFc+Kb2q+3NxlUrry05zLboqCJMbu05W0cvaomtcyYsCG+iMhP3E0sFLKrszbcp3HvirmIp10kRLdUPlvukKml+ysrsQTmJIAh6qq9421LNMXri6YmC9C4RnnDTdj86Cis9k/iq9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKF/eoC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753712816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhkCi+33EWVOAp2LGQeTVsLlocgjftolf8Kryl00mKk=;
	b=EKF/eoC9ThbtSNlGYcJAewi8UtZ7/3XdJrtgpAsquVWq7kG3W8CeX/9J93RMh+lDJZ2lQj
	PvO8QAW5MRW0dMCf/AEY63tJtbx/+Pz65aB2lcSveLIJjdLmR648tTfPEIOm8WcHWon+4T
	QZAf5/TRGeywjOMaLH53vf8nRIGGpEU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-xG6dAgS9No--2IgM1OakKQ-1; Mon,
 28 Jul 2025 10:26:52 -0400
X-MC-Unique: xG6dAgS9No--2IgM1OakKQ-1
X-Mimecast-MFC-AGG-ID: xG6dAgS9No--2IgM1OakKQ_1753712809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFF5B180034A;
	Mon, 28 Jul 2025 14:26:48 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5E81955F16;
	Mon, 28 Jul 2025 14:26:40 +0000 (UTC)
Date: Mon, 28 Jul 2025 16:26:38 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	Julien Ridoux <ridouxj@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Message-ID: <aIeInmXyglMdIuxE@localhost>
References: <20250724115657.150-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724115657.150-1-darinzon@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jul 24, 2025 at 02:56:56PM +0300, David Arinzon wrote:
> The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl offers the
> same timestamps as the PTP_SYS_OFFSET_EXTENDED ioctl, but extends
> it with a measurement of the PHC device clock accuracy and the
> synchronization status. This supports two objectives.

I have a slight issue with the naming of this new ioctl. TRUSTED
implies to me the other supported ioctls are not to be trusted
for some reason, but that's not the case, right? It's just more
information provided, i.e. it's extended once again. Would
PTP_SYS_OFFSET_EXTENDED3 or PTP_SYS_OFFSET_EXTENDED_ATTRS not work
better?

It would be nice to have a new variant of the PTP_SYS_OFFSET_PRECISE
ioctl for the ptp_kvm driver to pass the system clock maxerror and
status.

> The proposed PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl fulfills both
> objectives by extending each PHC timestamp with two quality
> indicators:
> 
> - error_bound: a device-calculated value (in nanoseconds)
>   reflecting the maximum possible deviation of the timestamp from
>   the true time, based on internal clock state.

Is this value expected to be changing so rapidly that it needs to be
provided with each sample of the ioctl? I'd expect a maximum value
from all samples to be sufficient (together with the worst status).

> - clock_status: a qualitative state of the clock, with defined
>   values including:
>   1. Unknown: the clock's synchronization status cannot be
>      reliably determined.
>   2. Initializing: the clock is acquiring synchronization.
>   3. Synchronized: The clock is actively being synchronized and
>      maintained accurately by the device.
>   4. FreeRunning: the clock is drifting and not being
>      synchronized and updated by the device.
>   5. Unreliable: the clock is known to be unreliable, the
>      error_bound value cannot be trusted.

I'd expect a holdover status to be included here.

-- 
Miroslav Lichvar


