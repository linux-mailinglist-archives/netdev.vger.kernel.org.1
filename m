Return-Path: <netdev+bounces-91668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F08B3631
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87621F21D9C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C7144D07;
	Fri, 26 Apr 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Oe7SldBm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E381448E8
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129257; cv=none; b=DrkRKULnYhK6lRmKHBqoOQvCxw5FSFs7GI1NaN+jF34bZfCxF87TFcpkAPyM+nKiIWZVOTBlhQhlSiRDCABrD94EVJWMhWsa2cBJcSAQ9DW2acHx5ES18IDJbq5YMBrTPogTN0kb8t05hCtYnEXwcglDsUYfx7iVBmy7uLXDWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129257; c=relaxed/simple;
	bh=CmrlDavylDDpqbtRus8D6a/nwKMMzWcd+lfPhaJoR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhtkLLo1RTq9AjCg5LuTiTbx54vayKMbHytHHdykHztMaqaoKigawrBvLzlHILYFoptYYHB/YKxZbb7N/YI/DIGl8vpW3MwwW/zHy07N99JSKcGMKN4Ywpw1umOnORf/j8amFo79EtHT5ROX5dBarKhOm8TR8bc5gdX1EADN3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Oe7SldBm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CrSSQOgsOazQGquPNOq2nYvIMsk0ndINFAR2+TzYLjo=; b=Oe7SldBmW3V8T9oNDsVKtzljIw
	oC24BRhmJb0AVpz2zBarLAS8W/FV0AYa1RqHOGQtAUP81svFaPWh7rwOMXdpfFVak1FwQEDVxZYxi
	eMto5UIoe++hyWxkeq07nHNHbxrWXawOujYEo1J0r35t9peNQEQFCeFcKt8Eh7qqQtwnXCkqsBhVf
	nQNAxtmVV2zAkZjocyE4dGjm1pg1NnfO4qNrUaBPqlg98X/b5HzRsWh/7ZE+/uM/GJHRLlfIeaSwB
	4BXLjbW8CZWtWk3r0Eo3deVypKFVGiYF2Q0bUdVZMvBpejfVv9nJeIF3/eois6+qnN4Zbw8i5DEZb
	e9uh3R7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s0JJb-00007u-1y;
	Fri, 26 Apr 2024 12:00:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s0JJZ-0006TV-5L; Fri, 26 Apr 2024 12:00:25 +0100
Date: Fri, 26 Apr 2024 12:00:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 09/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <ZiuJSY5oC8DWFAxk@shell.armlinux.org.uk>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
 <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
 <36afcb40-7e09-4a17-ad12-c27ac50120e1@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36afcb40-7e09-4a17-ad12-c27ac50120e1@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 26, 2024 at 06:16:42PM +0800, Yanteng Si wrote:
> Hi Russell,
> 
> 在 2024/4/25 22:36, Russell King (Oracle) 写道:
> > > The mac_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.
> > No it isn't!
> Ok, that's a typo.
> > 
> > > +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> > You don't touch mac_interface here. Please read the big comment I put
> > in include/linux/stmmac.h above these fields in struct
> > plat_stmmacenet_data to indicate what the difference between
> > mac_interface and phy_interface are, and then correct which-ever
> > of the above needs to be corrected.
> 
> Copy your big comment here:
> 
>     int phy_addr;
>     /* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
>      *       ^                               ^
>      * mac_interface                   phy_interface
>      *
>      * mac_interface is the MAC-side interface, which may be the same
>      * as phy_interface if there is no intervening PCS. If there is a
>      * PCS, then mac_interface describes the interface mode between the
>      * MAC and PCS, and phy_interface describes the interface mode
>      * between the PCS and PHY.
>      */
>     phy_interface_t mac_interface;
>     /* phy_interface is the PHY-side interface - the interface used by
>      * an attached PHY.
>      */
> 
> Our hardware engineer said we don't support pcs, and if I understand
> 
> your comment correctly, our mac_interface and phy_interface should
> 
> be the same, right?

It only matters to the core code if priv->dma_cap.pcs is set true.
If it isn't, then mac_interface doesn't seem to be relevent (it
does get used by a truck load of platform specific code though
which I haven't looked at to answer this.)

I would suggest that if priv->dma_cap.pcs is false, then setting
mac_interface to PHY_INTERFACE_MODE_NA to make it explicit that
it's not used would be a good idea.

While looking at this, however, I've come across the fact that
stmmac manipulates the netif carrier via netif_carrier_off() and
netif_carrier_on(), which is a _big_ no no when using phylink.
Phylink manages the carrier for the driver, and its part of
phylink's state. Fiddling with the carrier totally breaks the
guarantee that phylink will make calls to mac_link_down() and
mac_link_up().

If a driver wants to fiddle with the netif carrier, it must NOT
use phylink. If it wants to use phylink, it must NOT fiddle with
the netif carrier state. The two are mutually exclusive.

stmmac is quickly becoming a driver I don't care about whether my
changes to phylink end up breaking it or not because of abuses
like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

