Return-Path: <netdev+bounces-80568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29AC87FD4B
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC36282376
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44397F47F;
	Tue, 19 Mar 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qw+EJriN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20F7F477
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849761; cv=none; b=rSn9BVe+Hq5wgWQS0/3SSA0uJWbIaRxRU9iiILm0uyyiBp19EI//qkISCdJkqzTQa3Tm5rACK1QMpPcLysg1Kfx+DbgeEd4ixO2pu7KYMF3a5Q/CkOgXx5mutZsVnB+FNgWQitOuyYYi+eO3gjiApqXESXo+jWyLNEbuVjQNDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849761; c=relaxed/simple;
	bh=G36qVpZKDsQ8jzApLGueERTTtUn5WKpvTCs6xQTMwUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsfJ5jnHAV13o8wo0X6Y9qZdyDnHCxEFhWiAf2fdd7a/+O12TmVwePtCu61rS9Z3ii6RaOC/0Mn670TQx9RSp24/TN/MpNkvO3vnXgdn73UrqD3hi/CQyrJyEPgeGI00e/F5sjy6PTEJu1zjqrllp9jVBZG2lThRe1rpNASuE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qw+EJriN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UHfk6aSagnHiJ8SaAojcm4k3dNIQBMwVrW+4IHUB0pk=; b=Qw+EJriNllLompD8bB+vFkyL7p
	i8OmGsYonms+13GpJZQyiuyayPK7LOHi5v1jQojPw68kkfBKRIIMPU+K889LjMuWIg1ZMlGRsIpEO
	oRjVYD3idMlua+Fo2dHh8ZFQGBTMCBMhByXDvDCZ1p4Pux+UXrzVWT4iG5hEF/1Brh9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmYAn-00Ah7D-1p; Tue, 19 Mar 2024 13:02:29 +0100
Date: Tue, 19 Mar 2024 13:02:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: don't resume device not in use
Message-ID: <9682d619-4af3-4406-bf99-e85203991120@lunn.ch>
References: <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>

On Fri, Mar 15, 2024 at 07:55:48AM +0000, Jan Petrous (OSS) wrote:
> In the case when an MDIO bus contains PHY device not attached to
> any netdev or is attached to the external netdev, controlled
> by another driver and the driver is disabled, the bus, when PM resume
> occurs, is trying to resume also the unattached phydev.
> 
> /* Synopsys DWMAC built-in driver (stmmac) */
> gmac0: ethernet@4033c000 {
> 	compatible = "snps,dwc-qos-ethernet", "nxp,s32cc-dwmac";
> 
> 	phy-handle = <&gmac0_mdio_c_phy4>;
> 	phy-mode = "rgmii-id";
> 
> 	gmac0_mdio: mdio@0 {
> 		compatible = "snps,dwmac-mdio";
> 
> 		/* AQR107 */
> 		gmac0_mdio_c_phy1: ethernet-phy@1 {
> 			compatible = "ethernet-phy-ieee802.3-c45";
> 			reg = <1>;
> 		};
> 
> 		/* KSZ9031RNX */
> 		gmac0_mdio_c_phy4: ethernet-phy@4 {
> 			reg = <4>;
> 		};
> 	};
> };
> 
> /* PFE controller, loadable driver pfeng.ko */
> pfe: pfe@46000000 {
> 	compatible = "nxp,s32g-pfe";
> 
> 	/* Network interface 'pfe1' */
> 	pfe_netif1: ethernet@11 {
> 		compatible = "nxp,s32g-pfe-netif";
> 
> 		phy-mode = "sgmii";
> 		phy-handle = <&gmac0_mdio_c_phy1>;
> 	};
> };
> 
> Because such device didn't go through attach process, internal
> parameters like phy_dev->interface are set to default values, which
> can be incorrect for some drivers. Ie. Aquantia PHY AQR107 doesn't
> support PHY_INTERFACE_MODE_GMII and trying to use phy_init()
> in mdio_bus_phy_resume ends up with the following error caused
> by initial check of supported interfaces in aqr107_config_init():
> 
> [   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: error -19']
> 
> The fix is intentionally assymetric to support PM suspend of the device.
> 
> Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

