Return-Path: <netdev+bounces-249646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D72D1BC7C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B426D301E18E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C6199D8;
	Wed, 14 Jan 2026 00:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD3B652;
	Wed, 14 Jan 2026 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768349488; cv=none; b=VdTFzTcMw3GFO3DhLwRz28azlHONL8Q1UKQcunJVzmmLXbdGhHin6IF57FxP9KPTrtHeuwR9dGy9I9cvm4Uk7wRL25tyJD+Itl/66DxGhq9iTfzc1Shd8J3qT1OM9F7uae+QS2IqgCbdcJmWJkysLWKYd7yCsoc46OPKiqsRzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768349488; c=relaxed/simple;
	bh=iQFIDtQfy5g1VsvfSoeUgroL7nR/6mForoDQpw07o1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ4BYChJyrAhYF4AVsTPKBVqRTiIYP9LCb+KEfY3WoA4Dagp44dnfaj9MKTCY4jYKYGGaXpKfQjqpfNa3/HJMwvp8UTT0x+5NrVLGmF3au0aFcbx9CEVxpbk3D72cawmO3tD8xtb4VKYcrQ8TH2tLhl/XQL2N45iiCktLtCcXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfoTf-00000000730-3gmi;
	Wed, 14 Jan 2026 00:11:11 +0000
Date: Wed, 14 Jan 2026 00:11:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: fix in-band capabilities for
 2.5G PHYs
Message-ID: <aWbfHLOmMMgouDyN@makrotopia.org>
References: <20260113205557.503409-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113205557.503409-1-jan@3e8.eu>

On Tue, Jan 13, 2026 at 09:55:44PM +0100, Jan Hoffmann wrote:
> It looks like the configuration of in-band AN only affects SGMII, and it
> is always disabled for 2500Base-X. Adjust the reported capabilities
> accordingly.
> 
> This is based on testing using OpenWrt on Zyxel XGS1010-12 rev A1 with
> RTL8226-CG, and Zyxel XGS1210-12 rev B1 with RTL8221B-VB-CG. On these
> devices, 2500Base-X in-band AN is known to work with some SFP modules
> (containing an unknown PHY). However, with the built-in Realtek PHYs,
> no auto-negotiation takes place, irrespective of the configuration of
> the PHY.

This observation is aligned with the SFP quirk sfp_quirk_oem_2_5g()
which also disabled in-band AN for those 2.5G copper modules, some are
reportedly containing a RTL8221B-VB-CG PHY (the vendor and device ID
strings do *not* uniquely identify one design in this case,
unfortunately...)

> 
> Fixes: 10fbd71fc5f9b ("net: phy: realtek: implement configuring in-band an")
> Signed-off-by: Jan Hoffmann <jan@3e8.eu>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/realtek/realtek_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 5a7f472bf58e..7b7a48e5082a 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1429,6 +1429,7 @@ static unsigned int rtl822x_inband_caps(struct phy_device *phydev,
>  {
>  	switch (interface) {
>  	case PHY_INTERFACE_MODE_2500BASEX:
> +		return LINK_INBAND_DISABLE;
>  	case PHY_INTERFACE_MODE_SGMII:
>  		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
>  	default:
> -- 
> 2.52.0
> 

