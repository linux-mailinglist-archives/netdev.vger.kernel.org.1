Return-Path: <netdev+bounces-93982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58508BDD0F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606BA1F22F55
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447913C903;
	Tue,  7 May 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OiKHzrIZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECC4087C
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070177; cv=none; b=bzvfNKeR0KHkBWf8yKPofCy/WuFyFrMNOzwRcHnc2pZBPK5Pq6Ri2VyqxSlSYg6hxT3bPe0Uu3bVdTQ9S8rSUe3e1UWlBuIbbPWj/oBGBi1+6HTPSlHCFFYVGXQMfhvwwUDgOoxqBHpb7vMzCEm58czurAVNP0Y1Q6Z8I/cyAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070177; c=relaxed/simple;
	bh=t0g6i201xvN5HfGr3A6XpO5/flqs64hpkLenRc8APSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=filfsBHzus8++b3SOqhWsSQplsK1UHP8v4aCxZmOA8zlWdIeQrYH2ZL6at+uHBZyQVzpY2NV5zrI/jcqF0VXfQWYe9yoP0xdCikov/pcBONToJbCQV+Cf2cbX5zy4gi5eKN3lTFp9vANYxYCIhIcYjQMlch45EcMxD1Q6nhLcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OiKHzrIZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k0gc3vEbLKxgL9xgokL//slSu1TrvVXVBD88SYyM6VU=; b=OiKHzrIZbEKSEcdbx6LgQORLMm
	Fbrt2UHxRQ8eTECoJU0xDCzwilUkscwtdfCdn7fD+kj5lA56JEDOINFfgeAx01o99meFCaRdbJVLQ
	7AqdytvC8C1+u53ls9yuAmZuLUfidS2cAo2eKiD3kIPFQXh6tH2R9F/keE9Yizp68L0azXmFbqwBR
	ufxSaclnDSyiPFGbUu+oKpF2Ey685RKKNA17DzxWHctoSymwFa3+0Te2Ia3k8BFWC9DB4oO9Ch1W7
	b2Rg68HovHLufB7u1xDom8Et74seqJGy9mT3DfvZu1IChv9qZACpV0IK8qOF8DeeJcmGm4P2Baogr
	ow8G2dfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59048)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4G5c-0003R3-0E;
	Tue, 07 May 2024 09:22:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4G5a-0000BG-79; Tue, 07 May 2024 09:22:18 +0100
Date: Tue, 7 May 2024 09:22:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 09/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <ZjnkuhmefxaySh1Z@shell.armlinux.org.uk>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
 <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
 <36afcb40-7e09-4a17-ad12-c27ac50120e1@loongson.cn>
 <ZiuJSY5oC8DWFAxk@shell.armlinux.org.uk>
 <eycodyo57suhzb4jgxjn5fmltzxogo6nszgnkvgak6lqarsw72@lz47ughdxy5r>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eycodyo57suhzb4jgxjn5fmltzxogo6nszgnkvgak6lqarsw72@lz47ughdxy5r>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 04, 2024 at 12:01:42AM +0300, Serge Semin wrote:
> Absolutely correct. Moreover AFAICS from the databooks the PCS module
> is only available for the DW GMACs with the TBI, RTBI and SGMII
> interfaces. So the STMMAC_PCS_RGMII PCS flag seems misleading. The only
> info about the link state that could be runtime detected on the MAC
> side is: link speed, duplex mode and link status. It's done by means
> of the RGMII in-band status signals. That's what is implemented in the
> dwmac1000_rgsmii() method.

... which you've now made me look at, look at the whole
pcs_link/pcs_speed/pcs_duplex and made me wonder why the hell stmmac
is making this so figgin difficult, messing with the carrier behind
phylink's back (which is a no-no), and why it needs to have separate
paths for this.

It doesn't.

Just because it doesn't have something called an official "PCS" does
not mean you _can't_ use a phylink_pcs to represent something that
has PCS-like properties - such as the RGMII in-band status which is
no different to what Cisco SGMII does.

This isn't something new... this is something that mvneta has
supported since before phylink was a thing, and so phylink had to
allow it as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

