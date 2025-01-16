Return-Path: <netdev+bounces-158906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70160A13B97
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911AC164F3A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F122A809;
	Thu, 16 Jan 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cabSHwaF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291131DE89B;
	Thu, 16 Jan 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036297; cv=none; b=rJp4n0q2zrR8AGFX3K38OihnH3hiZDsT6RGXKfLkZLUKOodnQnMzJTo+KWdd8r7PF0zKc7p53K1qyevMrcVtpzQCY3g6jcf1xx2nfxZe6cvOKCf4yOB8OexzMtfS0+kcK85CNUhhQn01wfB+wXHCKFlehG0ULhFkIssPLoJdMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036297; c=relaxed/simple;
	bh=HFA0q3xAz/S1TQxkXai+x+tmQpoGIi19wGBzzmfvo/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqtha91jyqZaPVzSf9U3KYjk4MKyKA9wP5q5+soYcNpt6bi7adnVm7Na9RiIqmIpH4Vri+iAg1uOPpEzZL8v3quk9yNkGyXp2l6s/KPARE14Ht+Fuah3I4tzugTduuZ+HOdCGAytkcZKNxeqEXY/HNZ4sfWc8gh5L+RChkDvFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cabSHwaF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737036296; x=1768572296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFA0q3xAz/S1TQxkXai+x+tmQpoGIi19wGBzzmfvo/w=;
  b=cabSHwaF8jzRP7bcjmC3yFh0/fGsQfS3bjBXGTPY6Ia0jUYsa7xPtun+
   xXbYtS6QTW5Y41hZU0zMWtbhT/na955obJ29BeiM5r7yRwFCzClDHyc86
   wpE4SgfmTPsXmO/I65JVmNEFctGY+QIufWHDEP/ZgCscfraG4IuFNIh98
   YqvT2HdSLX+SisEYKzWYAob+6UtJ7GaRI5cWkV1CudFWAu/WLrbmuMa/S
   WjOVeuDpKRgMafX+sCYbPy9WS3hs/M03hXLVGsc5N4geLdt145HrgVtNe
   AmbspeiFQOzo0Nfc3jdSJO9Wlfr6/qInERxvnpZj6rYB/JTmSFV6SOFLT
   Q==;
X-CSE-ConnectionGUID: DLA4lcs9ShqgpZcEjRWGAw==
X-CSE-MsgGUID: kKfwk5YXRwa5RsQaF3Av6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48082477"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48082477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:04:16 -0800
X-CSE-ConnectionGUID: hsC7Lo90SwuWAzLfIrpaTQ==
X-CSE-MsgGUID: dmOeFuPSTieqecqH8l4FHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105355341"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 06:04:13 -0800
Date: Thu, 16 Jan 2025 15:00:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: phy: realtek: clear 1000Base-T lpa if link
 is down
Message-ID: <Z4kRFVs6ktqubOJd@mev-dev.igk.intel.com>
References: <cover.1736951652.git.daniel@makrotopia.org>
 <67e38eee4c46b921938fb33f5bc86c8979b9aa33.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e38eee4c46b921938fb33f5bc86c8979b9aa33.1736951652.git.daniel@makrotopia.org>

On Wed, Jan 15, 2025 at 02:43:35PM +0000, Daniel Golle wrote:
> Only read 1000Base-T link partner advertisement if autonegotiation has
> completed and otherwise 1000Base-T link partner advertisement bits.
> 
> This fixes bogus 1000Base-T link partner advertisement after link goes
> down (eg. by disconnecting the wire).
> Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index f65d7f1f348e..26b324ab0f90 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -1023,23 +1023,20 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  {
>  	int ret, val;
>  
> -	ret = genphy_c45_read_status(phydev);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (phydev->autoneg == AUTONEG_DISABLE ||
> -	    !genphy_c45_aneg_done(phydev))
> -		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
> -
>  	/* Vendor register as C45 has no standardized support for 1000BaseT */
> -	if (phydev->autoneg == AUTONEG_ENABLE) {
> +	if (phydev->autoneg == AUTONEG_ENABLE && genphy_c45_aneg_done(phydev)) {
>  		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
>  				   RTL822X_VND2_GANLPAR);
>  		if (val < 0)
>  			return val;
> -
> -		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
> +	} else {
> +		val = 0;
>  	}
> +	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
> +
> +	ret = genphy_c45_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (!phydev->link)
>  		return 0;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.1

