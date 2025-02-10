Return-Path: <netdev+bounces-164919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF6A2F9AE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9A11661D2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B867244EA1;
	Mon, 10 Feb 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UltgyHSW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHIU88/9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0A25C703;
	Mon, 10 Feb 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217799; cv=none; b=cYThYtU2Nc8khrWY5kPfIPzS0F9DQaDDKcigGu68SjGjSoDvK9JdlATxJpfXFFY3wpiKaot/GX2CYTteVyzh9gMbrQYGsi0Waj32wqgoyfXgT+4ZZjDmWvG6aXdgVPnhCsUkkFLMBZupyNaq1r+j1QRLg0GZj6eg+jpm72hFAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217799; c=relaxed/simple;
	bh=mFFHb+Q7fRlwtTG8raIJa2CEidV+ZaC7Nq7GpjuMQko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqWF6YwIqRUyNYwKewo0e7MAuKbgmYpnIBfCz/3ASiPdVMF9DrcQ6p5mLloGCIsLu13dcefUHTd3LBOAjMFCGgLr+ROXz9myPkcqJXKREltTyu+RbVTZkoMKo1IIYgW6Q0POoyeYhcJPNZT7wkvYkj5/dwH9Oi3b/B8l/iEKfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UltgyHSW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHIU88/9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739217795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xbmPr3piXj7ADDrvZKLAtAYel1F1qRBX96wVs4gBXU=;
	b=UltgyHSWfuC0zAmpvof5FBVAasvcM+fH3C1Vfrf8UEuntcbh7lTHt4BH9cIx8Z2nzXPfPo
	JPupmxaO4Tr9ruHrN8MCqTvryA/YRds4jgyASYXrjNmUr1LROFvcjvVHMPEUKLckRWBaAM
	+VdsyI4rHMT3fgXUYvkoYIUyCNq5AcMf6+dM06RdOehtzLXJbR1Mu6L8DFmjEUaer4Ueld
	xooOBP0hdSFDmxRPVonyMrbHjQoHlHs7PQrkwHwInoPTNJp2U7fg1wISpMs1v+KALhl1Rc
	7svsW25NKZi0qBSh/sEU0iRYGFESeEoZ1T3jXcocNiTQgnezBxXeeKvIDSh94w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739217795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xbmPr3piXj7ADDrvZKLAtAYel1F1qRBX96wVs4gBXU=;
	b=YHIU88/96u//UWM02Wvx1uBaZvGgspl2FGg/IaJu9YnZ2SGAEDVbi6I2hThV4F7Gn358hi
	5Lk77YN/lSA346AA==
To: "Vankar, Chintan" <c-vankar@ti.com>, Jason Reeder <jreeder@ti.com>,
 vigneshr@ti.com, nm@ti.com, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, m-malladi@ti.com
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
In-Reply-To: <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
 <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com>
Date: Mon, 10 Feb 2025 21:03:15 +0100
Message-ID: <87cyfplg8s.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chintan!

On Sun, Feb 09 2025 at 14:06, Vankar, Chintan wrote:
> On 2/7/2025 2:58 AM, Thomas Gleixner wrote:
>> On Wed, Feb 05 2025 at 21:31, Chintan Vankar wrote:
>>> +static struct irq_chip ts_intr_irq_chip = {
>>> +	.name			= "TIMESYNC_INTRTR",
>>> +};
>> 
>> How is this interrupt chip supposed to work? All it implements is a
>> name.
>> 
>
> Timesync INTR can be used to map input sources with the corresponding
> output, so that we can configure specific functionality for the device
> that is using this output sources either as an interrupt source or to
> synchronize the time.
>
> To implement above Timesync INTR's functionality, I have implemented
> ts_intr_irq_domain_alloc() and ts_intr_irq_domain_free() ops which are
> sufficient. Let me know if they are fine.
>>> +
>>> +	tsr_data.domain = irq_domain_create_tree(&node->fwnode, &ts_intr_irq_domain_ops, &tsr_data);
>> 
>> So this instantiates a interrupt domain which is completely disconnected
>> from the rest of the world.
>>  > How is the output side of this supposed to handle an interrupt which is
>> routed to it?
>> 
>
>                          ________________________
>                         |    Timesync INTR       +---->dma_local_events
>                         |                        |
> Device sync events----->                        +---->pcie_cpts_hw_push
>                         |                        |
>           cpts_genf----->                        +---->cpts_hw_push
>                         |________________________|
>
>
> No it is connected, it is being used to configure the output for
> Timesync INTR as mentioned above.
>
> As seen in the diagram, Timesync INTR has multiple output interfaces and
> we can configure those to map them with the corresponding input as
> required by peripherals which receives the signal. In context of this
> series, CPTS module is utilizing the output signal of cpts_genf as
> Hardware timestamp push event to generate timestamps at 1 seconds

If I understand this correctly, then the interrupt number you need to
allocate for this is never going to be requested. If it would be
requested it just would do nothing and the handler would never be
invoked, right?

The allocation just establishes the routing of a signal between two
arbitrary IP blocks in the SoC.

So the question is what has this to do with interrupts in the first
place?

Thanks,

        tglx

