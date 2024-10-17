Return-Path: <netdev+bounces-136567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099D9A2184
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2FCB21D55
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BEF1DA619;
	Thu, 17 Oct 2024 11:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFBA1D4609;
	Thu, 17 Oct 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166092; cv=none; b=tGlL+DWpJT8CF/aeYzCxeHM1AnsdxzQQcG4jKialoc2ZtX+2Pwa6C76vbBiVeSKqkUfEsVeVJMuYY2OPK6lqv4IvSQbT3vWJRHriTOUIexHHMJa4ndnQ3InqIYGab/6iBK6ofWqVAaPCwt35+yz8YzNrxOjd/bv4oqxbKylv6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166092; c=relaxed/simple;
	bh=zUDRtGDglLYVZ/ngV0bUcZr91ES4WL44E5T08acKDFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhABpR6azBNgVdRD1v3RlpQ1SUIsa8tUiQFXeyiklx4rhwiGo94pQmTo9hL/wkUT8+go73cpJho+dvasGQL/lAkjG9Qz9jO9LFQyjU0fdw9/ipg3KUPoBRuBx1KGH5TlVXIs38357hzoZL9qkG6oW1tVj4DXu/ZGgvIlhOixsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1t1P5S-000000007To-3A7J;
	Thu, 17 Oct 2024 11:54:38 +0000
Date: Thu, 17 Oct 2024 12:54:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Message-ID: <ZxD69GqiPcqOZK2w@makrotopia.org>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>

On Thu, Oct 17, 2024 at 02:54:07PM +1300, Paul Davey wrote:
> Add support for configuring MDI-X state of PHY.
> Add reporting of resolved MDI-X state in status information.

> [...]
> +static int aqr_set_polarity(struct phy_device *phydev, int polarity)

"polarity" is not the right term here. This is not about the polarity
of copper pairs, but rather about pairs being swapped.
Please name the function accordingly, eg. aqr_set_mdix().

> +{
> +	u16 val = 0;
> +
> +	switch (polarity) {
> +	case ETH_TP_MDI:
> +		val = MDIO_AN_RESVD_VEND_PROV_MDIX_MDI;
> +		break;
> +	case ETH_TP_MDI_X:
> +		val = MDIO_AN_RESVD_VEND_PROV_MDIX_MDIX;
> +		break;
> +	case ETH_TP_MDI_AUTO:
> +	case ETH_TP_MDI_INVALID:
> +	default:
> +		val = MDIO_AN_RESVD_VEND_PROV_MDIX_AUTO;
> +		break;
> +	}
> +
> +	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_PROV,
> +				      MDIO_AN_RESVD_VEND_PROV_MDIX_MASK, val);
> +}
> +
>  static int aqr_config_aneg(struct phy_device *phydev)
>  {
>  	bool changed = false;
>  	u16 reg;
>  	int ret;
>  
> +	ret = aqr_set_polarity(phydev, phydev->mdix_ctrl);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
>  	if (phydev->autoneg == AUTONEG_DISABLE)
>  		return genphy_c45_pma_setup_forced(phydev);
>  
> @@ -278,6 +315,14 @@ static int aqr_read_status(struct phy_device *phydev)
>  				 val & MDIO_AN_RX_LP_STAT1_1000BASET_HALF);
>  	}
>  
> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_STATUS1);

According to the datasheet the MDI/MDI-X indication should only be
interpreted when autonegotiation has completed.
Hence this call should be protected by genphy_c45_aneg_done(phydev) and
phydev->mdix set to ETH_TP_MDI_INVALID in case auto-negotiation hasn't
completed.

> +	if (val < 0)
> +		return val;
> +	if (val & MDIO_AN_RESVD_VEND_STATUS1_MDIX)
> +		phydev->mdix = ETH_TP_MDI_X;
> +	else
> +		phydev->mdix = ETH_TP_MDI;
> +
>  	return genphy_c45_read_status(phydev);
>  }
>  
> -- 
> 2.47.0
> 
> 

