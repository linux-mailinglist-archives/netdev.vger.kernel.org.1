Return-Path: <netdev+bounces-146374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C99D3265
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E2283780
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF701482F2;
	Wed, 20 Nov 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSvg/tTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F815336D
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072311; cv=none; b=KB5ce71oH6NeY/GmhHpa30UwO/UP/sHg0GHr7PNx5fo6QuCkfivRvj1JUV+H39vaFwwDARrEqJGZ8UFJLCb6xfzusgMQ2L0pTe9tqrWYSee9Rxn9EXTyI18suemmNqLmCq9bOmnqDlW2H1SvMJPlEJdI4ejsMoZsYdpY/WKsUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072311; c=relaxed/simple;
	bh=7uwF1bti13yUxEbTLcAEgLWDl1x3UiPvpxzglSm2kZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9BuryDyb59khqtTp9/wH6KS2ZmRxl1Wg39R1+t4Itl/HtrX8mnu+aCup0qzy4lYg5W9bQoK4P2IOw2/2K5pvbc5sRIOjW+hbHUc3YfFCA/ukb480TWBT5hyIie+DKIvALDgSSzgP0iVKEGJ0ahWHh8/UVhgF3md76rvqWnuAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSvg/tTZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732072310; x=1763608310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7uwF1bti13yUxEbTLcAEgLWDl1x3UiPvpxzglSm2kZE=;
  b=NSvg/tTZvEm1/vc41iYf5TypPdu9N2TTVskaiUpGg+NosWHO5i3S+lMN
   n2fjjO31/aqvf4YuahR/K+pFh9JbCGMbflOauTPpb2Va+JrXDWasquCNG
   pFNyBZM29l+gmEp2FDkE01+TLwQ3l+MMqUO4lx8GCT+hulnZXKf/9gYmJ
   XFcSwIh3xiMsmsO8yHzV0BWNPboCXHQP7DUZGJ2EFFML493HnnnWlwbSl
   OlPpYv/YoI2LHDM7p1MBPLkhY46rZWTXVo4Q4KRKK+KdqZYC+giO0ymA4
   AtF42dWBxkj3IRx9rlInDQgcffb1r6/gKvgSDV9MyJLU1+UtDYQUphMcb
   A==;
X-CSE-ConnectionGUID: G+ivhAtyS36NCUjwDQGw5g==
X-CSE-MsgGUID: rMWgfbeNT5KErAe3yZ43rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="49540095"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="49540095"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 19:11:50 -0800
X-CSE-ConnectionGUID: Pi2EIclaRaiGEtEA2cp2pw==
X-CSE-MsgGUID: OiTxjMhjRGa/76YW4Fzxvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="120626539"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.72.197]) ([10.247.72.197])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 19:11:47 -0800
Message-ID: <2422c3c6-7ea4-4551-839b-7cbbdaadf499@linux.intel.com>
Date: Wed, 20 Nov 2024 11:11:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: ensure that
 genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled
To: Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/11/2024 4:52 am, Heiner Kallweit wrote:
> This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
> eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
> (called from genphy_c45_ethtool_set_eee) not seeing the new value of
> phydev->eee_cfg.eee_enabled.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - change second arg of phy_ethtool_set_eee_noneg to pass the old settings
> - reflect argument change in kdoc
> ---
>   drivers/net/phy/phy.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 8876f3673..2ae0e3a67 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1671,7 +1671,7 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
>    * phy_ethtool_set_eee_noneg - Adjusts MAC LPI configuration without PHY
>    *			       renegotiation
>    * @phydev: pointer to the target PHY device structure
> - * @data: pointer to the ethtool_keee structure containing the new EEE settings
> + * @old_cfg: pointer to the eee_config structure containing the old EEE settings
>    *
>    * This function updates the Energy Efficient Ethernet (EEE) configuration
>    * for cases where only the MAC's Low Power Idle (LPI) configuration changes,
> @@ -1682,11 +1682,10 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
>    * configuration.
>    */
>   static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> -				      struct ethtool_keee *data)
> +				      const struct eee_config *old_cfg)
>   {
> -	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
> -	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
> -		eee_to_eeecfg(&phydev->eee_cfg, data);
> +	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
> +	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
>   		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
>   		if (phydev->link) {
>   			phydev->link = false;
> @@ -1706,18 +1705,23 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>    */
>   int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
>   {
> +	struct eee_config old_cfg;
>   	int ret;
>   
>   	if (!phydev->drv)
>   		return -EIO;
>   
>   	mutex_lock(&phydev->lock);
> +
> +	old_cfg = phydev->eee_cfg;
> +	eee_to_eeecfg(&phydev->eee_cfg, data);
> +
>   	ret = genphy_c45_ethtool_set_eee(phydev, data);
> -	if (ret >= 0) {
> -		if (ret == 0)
> -			phy_ethtool_set_eee_noneg(phydev, data);
> -		eee_to_eeecfg(&phydev->eee_cfg, data);
> -	}
> +	if (ret == 0)
> +		phy_ethtool_set_eee_noneg(phydev, &old_cfg);
> +	else if (ret < 0)
> +		phydev->eee_cfg = old_cfg;
> +
>   	mutex_unlock(&phydev->lock);
>   
>   	return ret < 0 ? ret : 0;

Hi Heiner,

I hope this message finds you well.

I noticed that the recent patch you submitted appears to be based on the 
previous work I did in this patch series: 
https://patchwork.kernel.org/project/netdevbpf/cover/20241115111151.183108-1-yong.liang.choong@linux.intel.com/.

Would you mind including my name as "Reported-by" in the commit message? I 
believe this would appropriately acknowledge my role in identifying and 
reporting the issue.

Thank you for your understanding and for the work you have done to improve 
the solution.


