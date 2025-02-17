Return-Path: <netdev+bounces-167096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF8A38D19
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3082F3A905E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D827219A8A;
	Mon, 17 Feb 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2G+qrL5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnMClA1r"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B5149C41;
	Mon, 17 Feb 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823430; cv=none; b=U92gp2wGC5eXxauYhUM87D+3QvTvplub+SrxdgHiim9OLLuyb3Pn2FAu8Y+NQ8HOTNTpsskB3nEPGLNFVjEON3zTYMk40jd+sZDJeUWumVhSN09YGCSjcZbdVxttOHoZdmV+nvB91PiOZi9vLgRdemakG0JeRQQ7slIPG4Rl97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823430; c=relaxed/simple;
	bh=TCMw5TyEQMzsmnCQVdbCbrXXQ8ghdVjjhyoQg11Zb28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPvt+32lgYw/NfIrDpbl4A5p5KgMeJBdBJvOGf8kKJ8kYGMKLpYc538Q52rQgXTRAwYErCLfl6/i/mS2NoO8i/Fep9rzTEEEmaomBcq26kJ11WWbl2xHFFrJ4JRbqkrKkfEFPEIF4wS2cPZ/sRb/XFeSOzYVEsTH9+ZcEuLqSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2G+qrL5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YnMClA1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739823426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4gctRK6JpfUH/NVUrTgQbZEcAERpsDJjOyl4C8mHZk=;
	b=2G+qrL5o2KPh9BiSB32r+cpkG65yGgYM43PiS+I+r+9yB7o//wCXSz+OdgPou7RbjvJz+i
	pvSg8MpUpLnJwFtvFvUOnpGpCh+YjXUs7NAi6HxjqnvkZB3vpT/eTWUo7amE8EbOciDl57
	+NxJSkmtFBgpj79Y9fY+UrCEmbnupUP91upddTt93RFa/bKO4o9jQJw61hOdve4YFk3Fu3
	Gz12ehbWyRy1mpIWB2X4BbS0v1GQvYI2M3hPpnl0L35XJmKWZmf71K9f47HOrxxvbLAZyd
	yOTsfn1vuBZff6Xg7vekwhWNpiT15KPB128NpCMdPrAAPeuej80NNCm1ta/Uxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739823426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4gctRK6JpfUH/NVUrTgQbZEcAERpsDJjOyl4C8mHZk=;
	b=YnMClA1rI9OiiEAFcAxg1oE84Z6NP7HFO8eayFN0SIh7UAjcCndxVweRfMwBuPyaozNBCr
	2PJUn9N3SnPJE1DQ==
To: Chintan Vankar <c-vankar@ti.com>, Jason Reeder <jreeder@ti.com>,
 vigneshr@ti.com, nm@ti.com, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, m-malladi@ti.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
In-Reply-To: <4238ddcc-d6ab-41a3-8725-b948f013a5b9@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
 <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com> <87cyfplg8s.ffs@tglx>
 <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com> <87jz9tjwjk.ffs@tglx>
 <4238ddcc-d6ab-41a3-8725-b948f013a5b9@ti.com>
Date: Mon, 17 Feb 2025 21:17:06 +0100
Message-ID: <87ikp8jph9.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chintan!

On Sat, Feb 15 2025 at 17:19, Chintan Vankar wrote:
> On 14/02/25 04:13, Thomas Gleixner wrote:
>> Two questions:
>> 
>>   1) For the case where no interrupt is involved, how is the routing
>>      configured?
>> 
>>   2) For the case where it routes an input line to an interupt, then how
>>      is this interrupt going to be handled by this interrupt domain which
>>      is not connected to anything and implements an empty disfunctional
>>      interrupt chip?
>> 
>
> For both the cases above the job of Timesync INTR is to map the output
> register with the corresponding input.
>
> As described in section 11.3.2.1 in the TRM at:
> https://www.ti.com/lit/ug/spruiu1d/spruiu1d.pdf,
> the job of the Timesync INTR is to provide a configuration of the
> "output registers which controls the selection". Hence we just have to
> provide configuration APIs in the Timesync INTR which programs output
> registers of the Timesync INTR. About the handling of the interrupts,
> the device which receives an interrupt needs to handle the interrupt.
>
> Could you please explain why we consider these two cases to be
> different?

They are different as

  #1 Routes the signal from one IP block to another IP block

     So there is no notion of an actual interrupt, but still you use the
     interrupt domain mechanism, which requires to allocate a Linux
     interrupt number just to configure that router.

     What's the purpose of this interrupt number and the allocated
     resources behind it?

  #2 Routes the signal from an IP block to an actual interrupt "input"

     Again, this requires to allocate a Linux interrupt number which is
     disfunctional as it is not connected in the interrupt domain
     hierarchy and just provides an interrupt chip with a name and no
     actual functionality behind it.

     So the resulting real interrupt needs yet another interrupt number
     which then maps to something which actually can handle interrupts.

So in some aspect they are not that different because both have nothing
to do with the actual concept of interrupt management in the Linux
kernel.

From the kernel's interrupt handling POV this is a completely
transparent piece of hardware, which is not associated to any interrupt
handling mechanism. Just because the manual mentions INTR in the name of
the IP block does not make it part of the actual kernel interrupt
handling.

I have no idea into which subsystem such a SoC configuration belongs to,
but Greg might have an idea.

Thanks,

        tglx

