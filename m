Return-Path: <netdev+bounces-100227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C88D83D2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA02811A4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B212D745;
	Mon,  3 Jun 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KEveu3xA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42F12C48A;
	Mon,  3 Jun 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421120; cv=none; b=hfhyTNorjApPaqNmlrn2YjFjA3Q7TuslrCa1jhrH66I9NHFvoUxkJuyrDmENGF+0faKplReCPbaeoRSd/EU6HrFP8Bw/Pop6J+vo2DH7BtFl4h3hWpCvpSOe43o75SSApOBOxUrP0XT0/lm72FCgxebrGa/yx72L+sK4v9IAGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421120; c=relaxed/simple;
	bh=bMPPMt40JcCI7qT1Vp8JvvHPnPCsgx0PvHanmVERJPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pesHdVEQRjEXVXTgnfgqTEdcVhlDbNAaersirK2GCnNxhf7quE1+B80yUqEv2+f/GXYFYMXOr+OSbSkuqrOdg4nppOD89hRgWNB8tM3M15nC1WCmuIpS2DIEPnrVf6wKZE5EQWM0ZLgevBbD8iQdJc/NYfFisEcOip0dsePAxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KEveu3xA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tWf90TqEv33tkhaPkxRH0Ei2G5Na7AiQ0T1KjGRgchw=; b=KEveu3xARg02n//HGVdyAS3k0L
	0+OpND2w3tEvWcNfABvyknDo0o4Q3G8SkiWap/eZf6kwJ+ySQmBG9ZX/j3s5aiUwRrTDge/PuDKf3
	JKEvayPNO0SyM13/UbRXnO51WTWvW7FDqovIWEDp0OyYn8kqbL4e9Su8kHXIK2NiyP6TKYfVGKRr1
	VQZSW8WjTL5OHx5X6+TOjBiHSpNEFf5Fp+Y4UFRQgBFxC6/wbJ3hhIgski9LdhdeUEgQf6pyPNMMW
	0IlL2dpuX5/ambYbTQEFw52BvsCWq+Y3KeCUMTWLtL2DA2irbleJ9rTIRye4KE1/OoykgFQHk5Eas
	Pb+GEH2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52102)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE7gL-0002mY-2H;
	Mon, 03 Jun 2024 14:25:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE7gL-0000T6-H9; Mon, 03 Jun 2024 14:25:01 +0100
Date: Mon, 3 Jun 2024 14:25:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 08:18:34PM +0800, Sky Huang wrote:
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware, add appropriate time delay and figure out LED.
> Also, certain control registers will be set to fix link-up issues.

Based on our previous discussion, it may be worth checking in the
.config_init() method whether phydev->interface is one of the
PHY interface modes that this PHY supports. As I understand from one
of your previous emails, the possibilities are XGMII, USXGMII or
INTERNAL. Thus:

> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct pinctrl *pinctrl;
> +	int ret;

	/* Check that the PHY interface type is compatible */
	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL &&
	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
	    phydev->interface != PHY_INTERFACE_MODE_USXGMII)
		return -ENODEV;

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

