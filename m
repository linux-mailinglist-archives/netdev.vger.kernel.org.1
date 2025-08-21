Return-Path: <netdev+bounces-215535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E54B2F076
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89B8179656
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A82EA16B;
	Thu, 21 Aug 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhS/9KHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6D2E9EC8
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763332; cv=none; b=nSmmlkfuPa48WwPODG1tYXox6AJvT/+W1NiaAQb3HN8eOsrflFEQNy6cOEAr1fhUw4/ptuGpJYL46AFoiGFL1L5UOL2sJL9nMJ4Y6lQcBEVXYU4N1n63HmwXQ7TuOEZ6YD/qfIsInYCYzcvQj9nBfN9NflVqRHaXRNCSmSug2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763332; c=relaxed/simple;
	bh=+bHo+mNfaReBmwCY6co3I1TOBfKp7u9tHdDMlSCb2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKyjKBZb8ZaN2sHpsfb6Cab0+YbZIgb32tJg7ykr/y2oRTge5wAmngjd1DQ/ZxPerGmzpIqmQbN2OFWCjtU2kI9ZLC95DGvbUZYDobuvwf2oVl38KhYE3nFK7geqYS/0bMMzuUbNmVI/0sLEQezA/Xo5+/9tfbnCJJ+o1X1rwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhS/9KHv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so371127f8f.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755763329; x=1756368129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ajqgx7Amr++Oe3j8qLtWGfZkpa1mE11u/9OfI91qGpM=;
        b=ZhS/9KHvxCNOU46t9paQdJTeT1kmKXHFFuxyDzQEGBrLl0hghkLUjqXEJH1XFMOiZs
         bKhPWBVp19deHJ21b+iN02r2oMC3Ro+5mx36phMznWReRjVo646nJeysNUJ+wbaUFlMV
         kTBBIdM+gWOt27/Ut3L+fqZmXXKNst4RMuZYmPuJ6JzeMUM4JxvtPNORTP7OlfEfX5aw
         vVjWTlTWMYdpfTwBr7tLsFCVsGgjc6gxXGDXBq0aNdgxIJmncewJHjfSjKqbPTXS5Ayw
         oEEuR+kG2JfvKZAAo0NJzglacKu8FgER5Fqk3JC9zO73xDRqd/ZBYJKa8GeCPEyIJTDU
         16WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763329; x=1756368129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajqgx7Amr++Oe3j8qLtWGfZkpa1mE11u/9OfI91qGpM=;
        b=GGOXiT9GjxFuhAaDx4Cz0koQtBEY1WzSHtWuOnXwQcZC5TFqfvEKGgWt2t7fiH+evb
         UxOiznx65G59Lgphlz9kC8Qq9/ifJkdit3IDaQpdCg1uMVjM5yxaw51ft3EwT02pfBBV
         QfawqgtVzRhP8pPPWOXOOX+K0sm/QkDWrXwTgI7OLfwXJWzXnTavad81KlYfCjXZuuD9
         bKsx+9djUd6wJOONQevIYgYMwr8GxqKOWpGPYUfcUVK60KP0nr1DYTX8du5PJwdEPhAC
         RlIImBAnpBdsceGlMJwuICuFto7pTFYx9Iz/67c5gBCyY5PKiSo9JU/DYXbr209If/8S
         v1PQ==
X-Gm-Message-State: AOJu0Yw+rZcKn2GojuxImOEivAURea4UGwNANyBNV4/l5IEyBe2htz3Q
	k+wcb1fUe6cdm5rCp+ddRjvEryR4mDAgTg1Jhww3s/EK4siQt18nZSu3
X-Gm-Gg: ASbGncshlU5SWPOgevfxme4Mr0VshHn/qy48GuHzkGliWHF1rGMC02vHZZBC6IpWI9h
	BbRtoPaod83URGYKNqPuNcdDGoFfyjnjXCsMfDfQVB8ib+GuImp1bbWYYJbWOo/4o6xiE7h7tGC
	AvuVUGxYN/krRMcsMg4CunF+gJ5xvrksDRvEUQw6Xegwy/r3t9nIin7tt+x6ORZPg52IDjwktS4
	TH4CFDZDJkA2IhfhMMnhiLEEnr1h7QAP1eJhN2XF210wVntXMNrfU7bK340x96xUnr+zXEXrpK4
	e1RUZmhVEpJwQ5RADjiHYn2NePgqfZqtwmR2y49OlDlIqUzxvyGKRlPlpKYmV+M4VIg2AH2jFVz
	+WN1hSaz9anJYwQEEG6S1
X-Google-Smtp-Source: AGHT+IHI2h54iB+SJWo/VzwAvDQstS21tn4zr81Pcy6qnReRSRp0BYJqu6O3eNwyD2r8HKMbZ+S9kw==
X-Received: by 2002:a05:6000:2388:b0:3c4:39cc:34a with SMTP id ffacd0b85a97d-3c49549d819mr1255124f8f.21.1755763328476;
        Thu, 21 Aug 2025 01:02:08 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6b1:2e00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077d4cd67sm10567637f8f.60.2025.08.21.01.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:02:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:02:05 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Ilya A. Evenbach" <ievenbach@aurora.tech>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] [88q2xxx] Add support for handling master/slave in
 forced mode
Message-ID: <20250821080205.GA5542@legfed1>
References: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
 <20250820181143.2288755-1-ievenbach@aurora.tech>
 <20250820181143.2288755-2-ievenbach@aurora.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820181143.2288755-2-ievenbach@aurora.tech>

Hi Ilya,

Am Wed, Aug 20, 2025 at 11:11:43AM -0700 schrieb Ilya A. Evenbach:
> 88q2xxx PHYs have non-standard way of setting master/slave in
> forced mode.
> This change adds support for changing and reporting this setting
> correctly through ethtool.
> 
> Signed-off-by: Ilya A. Evenbach <ievenbach@aurora.tech>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 106 ++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index f3d83b04c953..b94d574fd9b7 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -118,6 +118,11 @@
>  #define MV88Q2XXX_LED_INDEX_TX_ENABLE			0
>  #define MV88Q2XXX_LED_INDEX_GPIO			1
>  
> +/* Marvell vendor PMA/PMD control for forced master/slave when AN is disabled */
> +#define PMAPMD_MVL_PMAPMD_CTL				0x0834

Already defined, see MDIO_PMA_PMD_BT1_CTRL.

> +#define MASTER_MODE					BIT(14)

Already defines, see MDIO_PMA_PMD_BT1_CTRL_CFG_MST.

> +#define MODE_MASK					BIT(14)
> +
>  struct mv88q2xxx_priv {
>  	bool enable_led0;
>  };
> @@ -377,13 +382,57 @@ static int mv88q2xxx_read_link(struct phy_device *phydev)
>  static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
>  {
>  	int ret;
> +	int adv_l, adv_m, stat, stat2;
> +
> +	/* In forced mode, state and config are controlled via PMAPMD 0x834 */
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_MVL_PMAPMD_CTL);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & MASTER_MODE) {
> +			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
> +			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
> +		} else {
> +			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> +			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
> +		}
> +		return 0;
> +	}
>  
> -	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> -	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
> -	if (ret < 0)
> -		return ret;
>  
> -	if (ret & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
> +	adv_l = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L);
> +	if (adv_l < 0)
> +		return adv_l;
> +	adv_m = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_M);
> +	if (adv_m < 0)
> +		return adv_m;
> +
> +	if (adv_l & MDIO_AN_T1_ADV_L_FORCE_MS)
> +		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
> +	else if (adv_m & MDIO_AN_T1_ADV_M_MST)
> +		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_PREFERRED;
> +	else
> +		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_PREFERRED;
> +
> +	stat = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
> +	if (stat < 0)
> +		return stat;
> +
> +	if (stat & MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT) {
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
> +		return 0;
> +	}
> +
> +	stat2 = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT2);
> +	if (stat2 < 0)
> +		return stat2;
> +	if (!(stat2 & MDIO_MMD_AN_MV_STAT2_AN_RESOLVED)) {
> +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> +		return 0;
> +	}
> +
> +	if (stat & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
>  		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
>  	else
>  		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
> @@ -391,6 +440,34 @@ static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
>  	return 0;
>  }
>  

Is there a issue with the function you are trying to fix ? Seems that
you copied some generic functions into it.

> +static int mv88q2xxx_setup_master_slave_forced(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
> +					     PMAPMD_MVL_PMAPMD_CTL,
> +					     MODE_MASK, MASTER_MODE);
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
> +					     PMAPMD_MVL_PMAPMD_CTL,
> +					     MODE_MASK, 0);
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_UNSUPPORTED:
> +	default:
> +		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

This function does the same as genphy_c45_pma_baset1_setup_master_slave.
Please use the generic function. Besides you are introducing register
PMAPMD_MVL_PMAPMD_CTL which is MDIO_PMA_PMD_BT1_CTRL.

>  static int mv88q2xxx_read_aneg_speed(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -448,6 +525,11 @@ static int mv88q2xxx_read_status(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Populate master/slave status also for forced modes */
> +	ret = mv88q2xxx_read_master_slave_state(phydev);
> +	if (ret < 0 && ret != -EOPNOTSUPP)
> +		return ret;
> +
>  	return genphy_c45_read_pma(phydev);
>  }
>  

Why ? This function is only used in case AUTONEG_ENABLE.

> @@ -478,6 +560,20 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* Configure Base-T1 master/slave per phydev->master_slave_set.
> +	 * For AN disabled, program PMAPMD role directly; otherwise rely on
> +	 * the standard Base-T1 AN advertisement bits.
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		ret = mv88q2xxx_setup_master_slave_forced(phydev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return phydev->drv->soft_reset(phydev);
>  }
>  

I don't see any reason why genphy_c45_config_aneg isn't sufficient here.
In case AUTONEG_DISABLE, genphy_c45_pma_setup_forced is called and calls
genphy_c45_pma_baset1_setup_master_slave which is basically the same as
mv88q2xxx_setup_master_slave_forced.
In case AUTONEG_ENABLE, calling genphy_c45_pma_baset1_setup_master_slave is
wrong, please look how genphy_c45_an_config_aneg is implemented.

Please take other users of the driver into CC, they did a lot of
reviewing and testing in the past. If there is some issue with the
driver, they should know:

"Niklas Söderlund" <niklas.soderlund+renesas@ragnatech.se>
"Gregor Herburger" <gregor.herburger@ew.tq-group.com>
"Stefan Eichenberger" <eichest@gmail.com>
"Geert Uytterhoeven" <geert@linux-m68k.org>

Which device are you using, and why did you need this patch ? Is there
any issue you are trying to fix ? On my side I did a lot of testing with
the different modes and never experienced any problems so far.

Best regards,
Dimitri Fedrau

