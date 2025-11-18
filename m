Return-Path: <netdev+bounces-239652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD9C6AF6C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 313B42BB7A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB62DF6EA;
	Tue, 18 Nov 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sF1CBIw8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581782D193F
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486985; cv=none; b=IXJjyWCTaE6ULBkgfAW6QK8z6wmGp0p0BGnXnRNvhcOEM0HsArAVcAYAIy/+YmXLt71nI79EMt7GLI4BaLWPAJ0KDP+u7mPLLM9uoO942/MzXd1uKUJvTYJVelGt1ag1JagtbKAco3ZRyhYELZpo7qT6KFl7j3QKqQ2Xf/zPSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486985; c=relaxed/simple;
	bh=7PDKC9573DYqDGIWay/kHYswGOGk3GoSaEHE9yY7lAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcX99KqJ3Y8SOgjmBqMYK9LfwU7Yt971pShf1r9OJUUCGljbeSBGagvZ1Yk6t1SmLB+KEOJ/k9zXx12d07xLxJxEW7iPKHToH4jjtXQmR/jaHmZt1NnyLmWGrVmv3M9oD+sPFnFNVOMgQC/EsBE8x/i83aDHK8M8B5crtlByGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sF1CBIw8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pE2e9cU5q22bG1gBEASREs1MePwaMV3jEDxL4AlZc/8=; b=sF1CBIw8DmBGhTOvp5Aay6E7R9
	DVSGW4cQR2UACyHUBXXQfyA4R4nUeTyJ0Sotk+magTioelCADKLx/3RbQ5ATPAfi2Y7bawSors8SL
	e6S25uB7ImJVX28ET0xoRzXydqb+SO+w+ABh+1iaUdRGH29aZtAyTKycYx5xuAX5sCio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLPWM-00ENcj-1x; Tue, 18 Nov 2025 18:29:38 +0100
Date: Tue, 18 Nov 2025 18:29:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
 <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>

> Right. With PRBS you already should know what the link partner is
> configured for. It is usually a manual process on both sides. That is
> why I mentioned the cable/module EEPROM. The cable will indicate the
> number of lanes present and the recommended/maximum frequency and
> modulation it is supposed to be used at.

But i also expect that is standard ksetting_set behaviour. If user
space asks you do a specific link mode, you are going to check if it
is supported and return -EINVAL if it is not. So in the general case,
all this already exists. I call

ethtool -s eth42 autoneg off 20000baseCR2

and it should check if it is supported, and then configure the MAC,
PCS and anything else in the path for that link mode. Or return
-EINVAL if it is not supported.

[I forget the exact ethtool syntax, its not something i use very
often, to set a specific link mode]

> With that you can essentially
> determine what the correct setup would be to test it as this is mostly
> just a long duration cable test. The only imitation is if there is
> something in between such as a PMA/PMD that is configured for 2 lanes
> instead of 4.

And the CR2 indicates you want to use 2 lanes. And you would then run
RPBS on both of them. We could consider additional properties on the
netlink API to run PRBS on a subset. But would you not actually want
them all active to see if there is cross talk noise to deal with?

> Yes. Again most of these settings appear to be per-lane in both the IP
> we have and the IEEE specification. For example it occurs to me that a
> device could be running a 25G or 50G link over a single QSFP cable,
> and still have testing enabled for the unused 2 or 3 lanes on the
> cable potentially assuming the PMA/PMD is a 4 lane link and is only
> using one or two lanes for the link.

So that would be 25000baseCR and 50000baseCR2, for the 25G and 50G,
using 1 lane and 2 lanes, leaving the other 3/2 lanes unused?

	Andrew

