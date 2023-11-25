Return-Path: <netdev+bounces-51016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F027F8938
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 09:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C635F1C20B74
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728B9453;
	Sat, 25 Nov 2023 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KQBYSbI9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BCD7;
	Sat, 25 Nov 2023 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LnkUemW/Vw0dvMf2LUd65BmRZrXY7Oum0dFDnN5qya8=; b=KQBYSbI9QZztfFhSHGvAUeRMYZ
	7jHyQtGiI65lm5ctT6V8610pJW+pqce4qTD1S52beIYZ/U5L66YodxgUPf7qMMJPFuOkJiMi1Sizm
	KFshsjsAT+DrJPN75J+MwXTx5QHTPT9nr9WC8bv4fp2YvIbUTd75Pg/FDogyN5QHY2QU/78tUWRGW
	OcX7D4PjeI66CXO55FPOzX+K4+J2EkZ6m/91h7PacciK5Y/17YZuqGRdlLhiF/29i/Kg0koanREF6
	AqETyop2yBW1YXS8j/rs7CZGwtSxNOoMuWM6C1hwjCP+liE24EjZrEpQmNcaHJWGgZTeZTtvvERx6
	YQy1SD+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r6o1U-0003rI-2A;
	Sat, 25 Nov 2023 08:28:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r6o1U-000875-5m; Sat, 25 Nov 2023 08:28:20 +0000
Date: Sat, 25 Nov 2023 08:28:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: phylink: set phy_state interface when attaching
 SFP
Message-ID: <ZWGwJE0aCC/H3O2A@shell.armlinux.org.uk>
References: <8abed37d01d427bf9d27a157860c54375c994ea1.1700887953.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8abed37d01d427bf9d27a157860c54375c994ea1.1700887953.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 25, 2023 at 04:56:20AM +0000, Daniel Golle wrote:
> Assume 'usxgmii' being set as initial interface mode in DTS. Now plug
> a 2.5GBase-T SFP module with exposed PHY. Currently this results in
> a rather bizare situation:
> 
> RTL8221B-VB-CG 2.5Gbps PHY (C45) i2c:sfp1-wan:11: rtl822x_c45_get_features: supported=00,00000000,00008000,000080ef
> mtk_soc_eth 15100000.ethernet eth2: requesting link mode phy/2500base-x with support 00,00000000,00008000,0000e0ef
> mtk_soc_eth 15100000.ethernet eth2: switched to phy/2500base-x link mode   <<< !!!!!!
> mtk_soc_eth 15100000.ethernet eth2: major config usxgmii    <<< !!!!!!
> mtk_soc_eth 15100000.ethernet eth2: phylink_mac_config: mode=phy/usxgmii/none adv=00,00000000,00000000,00000000 pause=00
> mtk_soc_eth 15100000.ethernet eth2: PHY [i2c:sfp1-wan:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
> mtk_soc_eth 15100000.ethernet eth2: phy: 2500base-x setting supported 00,00000000,00008000,0000e0ef advertising 00,00000000,00008000,0000e0ef
> 
> Then the link seemingly comes up (but is dead) because no subsequent
> call to phylink_major_config actually configured MAC and PCS for
> 2500base-x mode.
> 
> This is because phylink_mac_initial_config() considers
> pl->phy_state.interface if in MLO_AN_PHY mode while
> phylink_sfp_set_config() only sets pl->link_config.interface.
> 
> Also set pl->phy_state.interface in phylink_sfp_set_config().

Does it _actually_ matter?

When the PHY's link comes up, doesn't it get sorted out for the real
mode that will be used?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

