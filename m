Return-Path: <netdev+bounces-116588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CB94B192
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390D41F2121A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB3145FED;
	Wed,  7 Aug 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3SgN3x+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE5145A1D
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063613; cv=none; b=s8HPTtKPITnc46waykXgy0qt8aMrWMWEYNOJhNzRIl6OEOi93oPvm9SzmbDLrxfbkCsqdLJX97rPkXSiPtVGpbE5kuocu53ItMOQ83Cjz7snS826wb3QUg9eLRgRDgXHk72LxmFOXti4etNgzanNjVyAxi24iuasrEU2+bQ1hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063613; c=relaxed/simple;
	bh=LPGe+4xDjATxjh9iTefGBBR1J/WXWbEMEzjnPpFNqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+liGrq34tuqyBbb/blZCNkczR89U6JXXw+qlySgoSAwHs5i3VnzrstwpkBQlpt7CB0KkaM7+r9/pPxbHJar5TiNdK5y24g7v02RUoXpQKNvL+SK4qtyquLk29UZ9fENnLlRx7Vq2yGOSLcyeBLBfowNyNp0S0HVLIZ0qNfgdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3SgN3x+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723063611; x=1754599611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPGe+4xDjATxjh9iTefGBBR1J/WXWbEMEzjnPpFNqmc=;
  b=R3SgN3x+6OoLH/D41J2hrEXQ+EKmzMM5+0lS/0THu7DZyfCAvBtJr3+F
   LSh1eRxl79WpTu0AlNK1MdGbblqLOQKk93tZFfdhjPYaqq5j1FvHvJ2MU
   ruMxCip/x9VDuezm16eJ4MKAyXC0dRoH5Y6kO1bOUk/1ulDizYTIG04oT
   1zFpFCJxI0MrHGD59CiEjRrf17XCnFHqzVkSjgYcPv++ZtwdFSpupYuWf
   kEgDzUtBqfh79403kQJ+3DVkdosYBTe45bhF2cZb4HAQ8LarYJ6CYuHL4
   EeD05nbdI0Fg9sxeSkvpmtJ+h0xiurD43k3RspdrvSPHMIH9wLzmczk9F
   Q==;
X-CSE-ConnectionGUID: vaJu59+lQlGzZ31vhCOpVQ==
X-CSE-MsgGUID: c8Wv+59LSP6pBJB8iU5oUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38665538"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="38665538"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:46:50 -0700
X-CSE-ConnectionGUID: hKbPJqmOQ7G+bNXEBBxw3g==
X-CSE-MsgGUID: bTZxIMj7RNu1vx6xn6taAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61918545"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 13:46:47 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbnYS-0005i0-2p;
	Wed, 07 Aug 2024 20:46:44 +0000
Date: Thu, 8 Aug 2024 04:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylib: do not disable autoneg for fixed
 speeds >= 1G
Message-ID: <202408080457.vhF74DGf-lkp@intel.com>
References: <E1sbdxI-0024Eo-HE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sbdxI-0024Eo-HE@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-phylib-do-not-disable-autoneg-for-fixed-speeds-1G/20240807-185909
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1sbdxI-0024Eo-HE%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next] net: phylib: do not disable autoneg for fixed speeds >= 1G
config: arc-randconfig-001-20240808 (https://download.01.org/0day-ci/archive/20240808/202408080457.vhF74DGf-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080457.vhF74DGf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080457.vhF74DGf-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/phy/phy_device.c: In function 'genphy_config_advert':
>> drivers/net/phy/phy_device.c:2124:41: warning: passing argument 1 of 'linkmode_adv_to_mii_adv_t' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    2124 |         adv = linkmode_adv_to_mii_adv_t(advert);
         |                                         ^~~~~~
   In file included from include/uapi/linux/mdio.h:15,
                    from include/linux/mdio.h:9,
                    from drivers/net/phy/phy_device.c:23:
   include/linux/mii.h:143:60: note: expected 'long unsigned int *' but argument is of type 'const long unsigned int *'
     143 | static inline u32 linkmode_adv_to_mii_adv_t(unsigned long *advertising)
         |                                             ~~~~~~~~~~~~~~~^~~~~~~~~~~
>> drivers/net/phy/phy_device.c:2147:46: warning: passing argument 1 of 'linkmode_adv_to_mii_ctrl1000_t' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    2147 |         adv = linkmode_adv_to_mii_ctrl1000_t(advert);
         |                                              ^~~~~~
   include/linux/mii.h:218:65: note: expected 'long unsigned int *' but argument is of type 'const long unsigned int *'
     218 | static inline u32 linkmode_adv_to_mii_ctrl1000_t(unsigned long *advertising)
         |                                                  ~~~~~~~~~~~~~~~^~~~~~~~~~~
   drivers/net/phy/phy_device.c: In function '__genphy_config_aneg':
>> drivers/net/phy/phy_device.c:2401:25: error: implicit declaration of function 'linkmode_set'; did you mean 'linkmode_subset'? [-Werror=implicit-function-declaration]
    2401 |                         linkmode_set(set->bit, fixed_advert);
         |                         ^~~~~~~~~~~~
         |                         linkmode_subset
   cc1: some warnings being treated as errors


vim +2401 drivers/net/phy/phy_device.c

  2359	
  2360	/**
  2361	 * __genphy_config_aneg - restart auto-negotiation or write BMCR
  2362	 * @phydev: target phy_device struct
  2363	 * @changed: whether autoneg is requested
  2364	 *
  2365	 * Description: If auto-negotiation is enabled, we configure the
  2366	 *   advertising, and then restart auto-negotiation.  If it is not
  2367	 *   enabled, then we write the BMCR.
  2368	 */
  2369	int __genphy_config_aneg(struct phy_device *phydev, bool changed)
  2370	{
  2371		__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
  2372		const struct phy_setting *set;
  2373		unsigned long *advert;
  2374		int err;
  2375	
  2376		err = genphy_c45_an_config_eee_aneg(phydev);
  2377		if (err < 0)
  2378			return err;
  2379		else if (err)
  2380			changed = true;
  2381	
  2382		err = genphy_setup_master_slave(phydev);
  2383		if (err < 0)
  2384			return err;
  2385		else if (err)
  2386			changed = true;
  2387	
  2388		if (phydev->autoneg == AUTONEG_ENABLE) {
  2389			/* Only allow advertising what this PHY supports */
  2390			linkmode_and(phydev->advertising, phydev->advertising,
  2391				     phydev->supported);
  2392			advert = phydev->advertising;
  2393		} else if (phydev->speed < SPEED_1000) {
  2394			return genphy_setup_forced(phydev);
  2395		} else {
  2396			linkmode_zero(fixed_advert);
  2397	
  2398			set = phy_lookup_setting(phydev->speed, phydev->duplex,
  2399						 phydev->supported, true);
  2400			if (set)
> 2401				linkmode_set(set->bit, fixed_advert);
  2402	
  2403			advert = fixed_advert;
  2404		}
  2405	
  2406		err = genphy_config_advert(phydev, advert);
  2407		if (err < 0) /* error */
  2408			return err;
  2409		else if (err)
  2410			changed = true;
  2411	
  2412		return genphy_check_and_restart_aneg(phydev, changed);
  2413	}
  2414	EXPORT_SYMBOL(__genphy_config_aneg);
  2415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

