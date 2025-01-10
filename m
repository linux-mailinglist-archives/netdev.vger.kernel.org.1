Return-Path: <netdev+bounces-156960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90663A0864A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25353A744C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8115C140;
	Fri, 10 Jan 2025 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqIhtraO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A559290F;
	Fri, 10 Jan 2025 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736484536; cv=none; b=IT1hSN88IdcNnYt/ikRbvS5YYmndcyU44RvNTOeodv2j1eKjmSESFhxkT5ymCe7OHyx2GQS0Wi4sT+GMtSIHkOiyDIy4GVMSZf/KDxPv43QUMgCoWhMoD937PD05k0f+CkYan5kRfdV0pTilff4VWH9cunKo1QhNAVuAJkTlxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736484536; c=relaxed/simple;
	bh=3zkI5LgDvSbJ+KLD1OgbWZlSRH5EJtjzvt9ohL/WQLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RguqVK2/eBXm7Rho6nBorifyofHDA9Fj5y+fBNmjv5bWEjSDLaGnmPOsgRbR/SeVuuG6BV6fAMjF/VOtuP/30sVtLa78D7yYJ8HKI/yUZTkB4R/PwrEUJGGM2612Qe/Qc1CPatJVn7Ni2fQVGcToo/wrqov4DHBw4BPB7QTIy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqIhtraO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736484534; x=1768020534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zkI5LgDvSbJ+KLD1OgbWZlSRH5EJtjzvt9ohL/WQLs=;
  b=fqIhtraOiq+hUdvBv3b6rU26emDdASV413E8aLLf+VlF7fnJgVLdH4aZ
   ZXey8TjHuBYA/1U/D1r+qlAIbKGn8SPYvtHL+VYWFkqbXQR4J7yugd8kF
   C8A7gjKdmfns+noYs0AuYiUiUIzK0fMHrGcwx9JanAnutY3wWfuldRoqM
   gqCPWyb9mpYbgWQ7XAEfju58CL9DZWT1hobCyz7mfKz2S9JNM1twA+5OI
   4FX1zYazDlov08VCcaEeZa2f0GSCge7PXXdC2Emwn60qBOQ1p2rqcTTxj
   H1phHhSaA+cIUGVeSbnc8xivacIpKoXxgHP68tlePWTCA1B598EoofeHO
   A==;
X-CSE-ConnectionGUID: GsJnzq5LTR6CgAO+MCiCxQ==
X-CSE-MsgGUID: 5HM0j1YSQaaGDmgjU2qtnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54186223"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54186223"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 20:48:54 -0800
X-CSE-ConnectionGUID: xUkcqSAMQGWvhTkU8Aopsw==
X-CSE-MsgGUID: PSNQbN1CTpOEvOIV6fFK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104501530"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Jan 2025 20:48:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW6wx-000IYF-2x;
	Fri, 10 Jan 2025 04:48:47 +0000
Date: Fri, 10 Jan 2025 12:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <202501101219.XbI23MZj-lkp@intel.com>
References: <20250109094457.97466-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109094457.97466-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/ethtool-linkstate-migrate-linkstate-functions-to-support-multi-PHY-setups/20250109-174927
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250109094457.97466-3-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY drivers
config: arc-axs101_defconfig (https://download.01.org/0day-ci/archive/20250110/202501101219.XbI23MZj-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501101219.XbI23MZj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501101219.XbI23MZj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy.c:631: warning: expecting prototype for phy_ethtool_get_phy_stats(). Prototype was for __phy_ethtool_get_phy_stats() instead
>> drivers/net/phy/phy.c:650: warning: expecting prototype for phy_ethtool_get_link_ext_stats(). Prototype was for __phy_ethtool_get_link_ext_stats() instead


vim +631 drivers/net/phy/phy.c

   617	
   618	/**
   619	 * phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
   620	 * @phydev: Pointer to the PHY device
   621	 * @phy_stats: Pointer to ethtool_eth_phy_stats structure
   622	 * @phydev_stats: Pointer to ethtool_phy_stats structure
   623	 *
   624	 * Fetches PHY statistics using a kernel-defined interface for consistent
   625	 * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
   626	 * this function enforces a standardized format for better interoperability.
   627	 */
   628	void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
   629					 struct ethtool_eth_phy_stats *phy_stats,
   630					 struct ethtool_phy_stats *phydev_stats)
 > 631	{
   632		if (!phydev->drv || !phydev->drv->get_phy_stats)
   633			return;
   634	
   635		mutex_lock(&phydev->lock);
   636		phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
   637		mutex_unlock(&phydev->lock);
   638	}
   639	
   640	/**
   641	 * phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
   642	 * @phydev: Pointer to the PHY device
   643	 * @link_stats: Pointer to the structure to store extended link statistics
   644	 *
   645	 * Populates the ethtool_link_ext_stats structure with link down event counts
   646	 * and additional driver-specific link statistics, if available.
   647	 */
   648	void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
   649					      struct ethtool_link_ext_stats *link_stats)
 > 650	{
   651		link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
   652	
   653		if (!phydev->drv || !phydev->drv->get_link_stats)
   654			return;
   655	
   656		mutex_lock(&phydev->lock);
   657		phydev->drv->get_link_stats(phydev, link_stats);
   658		mutex_unlock(&phydev->lock);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

