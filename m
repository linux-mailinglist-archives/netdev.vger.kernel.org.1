Return-Path: <netdev+bounces-109019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1389268A8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CA91C21952
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B8188CA5;
	Wed,  3 Jul 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zlmbb+dJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD6134409
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032995; cv=none; b=pXmyu3uGHvCXetJELMiYzBQWFYPPQwXo+N8dcBO881Egs0/pP4SxVu6DCcxCsKiMSbnJRECc1Gh455eDKnbZyzPB0S77KRruVdN2DLLpjS5cZ5Nyh2qa6ORkEZowdebRr5QmVO5sx9k5Ukb9LfUtkjsELvhNzipBOu32gQ2wmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032995; c=relaxed/simple;
	bh=1Wwa5E9FFH4dSDXlcmk6CY/spc9LJyFRMkHxH2fs90s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl3K8okj813+4n740zmYsXMb4kzP5kg4tzxDmjB7jf339OQNpo162ou5mJPJJgE961B4xHVIbuna3D7E9+mmpI7Q6T49zCoskk+Ggt9SLeKQ1NQu6t+/ndvvk7VoNDXzyGt+geBVkV9J/DCEg14rn5Augwl9ntXuBb1LBklLlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zlmbb+dJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iDlgRTQ2fbT7OyGBiQgLihKbeuSctOBWymvryNwt/Q4=; b=zlmbb+dJufzfJ17W5ut2orcj1V
	DFys82GwAxQfllIWmr15w0VPQAl113UFdRnB9SLDBhwjsXgVaIxTs+p/vrxvMjA32z6lM6Jn9wpeR
	L/cyDvgEpZT6hqONbDyebcnRl8Ad4/SMpah4Oq3KWqygKIMBn0+cc/mpWqrkFp2fzMWigmNzle+Uf
	qgokU9XAAnDVCLF06hq/YatYtVGuw4Wz0XNfecpYojPTabDhct6OrGE7EYd6ahwccvurLF5GK3S9u
	D2h45FwSsJCymd0qyO1A4S9PXK29Tsot0TLW1plSr9JlhD3bxMkiiLwop+u9VC77mrDqmG3KbKgiN
	/qJOWvVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41260)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP59E-00062h-15;
	Wed, 03 Jul 2024 19:56:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP59E-00038p-24; Wed, 03 Jul 2024 19:56:08 +0100
Date: Wed, 3 Jul 2024 19:56:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <ZoWex6T0QbRBmDFE@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
 <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
 <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 07:56:31PM +0300, Serge Semin wrote:
> One another statement in IEEE 802.3 C40 that implies the AN being
> mandatory is that 1000BASE-T PHYs determine their MASTER or SLAVE part
> during the Auto-Negotiation process. The part determines the clock
> source utilized by the PHYs: "The MASTER PHY uses a local clock to
> determine the timing of transmitter operations. The SLAVE PHY recovers
> the clock from the received signal and uses it to determine the timing
> of transmitter operations, i.e.," (40.1.3 Operation of 1000BASE-T)
> 
> So I guess that without Auto-negotiation the link just won't be
> established due to the clocks missconfiguration.

Oh damn, I did a reply, then cocked up sending it (lost it instead!)
So, this is going to be a brief response now.

It seems AN is basically required for 1000base-T.

> > Alternatively, maybe just implement the Marvell Alaska solution
> > to this problem (if the user attempts to disable AN on a PHY
> > supporting only base-T at gigabit speeds, then we silently force
> > AN with SPEED_1000 and DUPLEX_FULL.
> 
> I am not that much knowledgable about the PHY-lib and PHY-link
> internals, but if we get to establish that the standard indeed
> implies the AN being mandatory, then this sounds like the least
> harmful solution from the user-space point of view.

The Atheros PHYs are another PHY where we should not be disabling
AN when wishing to use 1000base-T (so says the datasheet - I did
quote it in my original reply but lost that...)

As has already been mentioned, Marvell Alaska takes an interesting
approach - when BMCR AN enable is cleared but speed is forced to
1000, it internally keeps AN enabled and advertises the appropriate
1G speed + duplex capability bit depending on the BMCR duplex bit.

Rather than erroring out, I think it may be better to just adopt
the Marvell solution to this problem to give consistent behaviour
across all PHYs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

