Return-Path: <netdev+bounces-116585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4994B176
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AF7B21C08
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0369145A07;
	Wed,  7 Aug 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqBP6XIP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9E1411DF
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062988; cv=none; b=nghhAVyYSADMpzArBszewn33Nu3i62W8sbw9HAU33A0+nFTe0JQ3RpGujsTL/usuZoN/pl0hSCb8GNBOFyoOnrEVbF31Xj5DbPbD+er0nngCVOTDmQVDFSxTANHwPJ57yhV2VNSbhNGrCBsaa62fFjvyyJm524qd7knnz7F2jEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062988; c=relaxed/simple;
	bh=bbCc2pCRg3JOqn02+cskHNGVFdHAHz0drvc2iVTuwbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZXQrnrqF5jIxMkkTaowyGrfwn9KvHlPRSeaFleNGIV7Q8hyRnwzLWpQ76WxBijrLHANa+woOSlZP8OOh6fl/5b7A7+zU7SAo8qnZrMeUomTWvU7OEYRfS8DQv6ssgL3DoTH9y7eEJ7cnu7blIsi6wb7eJn3/rUXH2drxeslXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqBP6XIP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723062987; x=1754598987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bbCc2pCRg3JOqn02+cskHNGVFdHAHz0drvc2iVTuwbY=;
  b=YqBP6XIP/3runQSqoxeCe2O8Q+98PnTNCKTUewR0aWGoKSUFxZzfAcZy
   CpxdFgAlkVjARXNJXhQ6EoVVdLbYgNuJqVgfHOQKKYdqbYZTTetIL1vbK
   I8GpkNcInHsdfSiSezwjKR/LGNb5bi9PCSv1zi7b58tirAvL75hBcLsLV
   3JwNWXwvZoafrEkjGRujIINU+77d/Fqmw0dEaML3+UBxU8URjV/3KHME/
   +6m9eCGtJDZes2qiLFuinq8HqwelG2Gv0v1LAMLP8nvY894S/8iJBKvnC
   m1uMVCPkSpn82vHuNWuFc7qV7DuvDY/A34T57DZB+YnZWDZN8xfoEjSow
   Q==;
X-CSE-ConnectionGUID: RzhY7718TpmlBx1b+hg3HQ==
X-CSE-MsgGUID: BhWxQ9tlQQir/dZKgAK4rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21308617"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21308617"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:36:27 -0700
X-CSE-ConnectionGUID: bx5jcwhmTR6NufMHKRgHiQ==
X-CSE-MsgGUID: cGrqd3shSYix0yAqKLfnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56656629"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 07 Aug 2024 13:36:24 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbnOQ-0005hQ-0M;
	Wed, 07 Aug 2024 20:36:22 +0000
Date: Thu, 8 Aug 2024 04:36:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylib: do not disable autoneg for fixed
 speeds >= 1G
Message-ID: <202408080419.a2PXcqh8-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240808 (https://download.01.org/0day-ci/archive/20240808/202408080419.a2PXcqh8-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080419.a2PXcqh8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080419.a2PXcqh8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/phy_device.c:2124:34: error: passing 'const unsigned long *' to parameter of type 'unsigned long *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    2124 |         adv = linkmode_adv_to_mii_adv_t(advert);
         |                                         ^~~~~~
   include/linux/mii.h:143:60: note: passing argument to parameter 'advertising' here
     143 | static inline u32 linkmode_adv_to_mii_adv_t(unsigned long *advertising)
         |                                                            ^
   drivers/net/phy/phy_device.c:2147:39: error: passing 'const unsigned long *' to parameter of type 'unsigned long *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    2147 |         adv = linkmode_adv_to_mii_ctrl1000_t(advert);
         |                                              ^~~~~~
   include/linux/mii.h:218:65: note: passing argument to parameter 'advertising' here
     218 | static inline u32 linkmode_adv_to_mii_ctrl1000_t(unsigned long *advertising)
         |                                                                 ^
>> drivers/net/phy/phy_device.c:2401:4: error: call to undeclared function 'linkmode_set'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2401 |                         linkmode_set(set->bit, fixed_advert);
         |                         ^
   3 errors generated.


vim +2124 drivers/net/phy/phy_device.c

  2107	
  2108	/**
  2109	 * genphy_config_advert - sanitize and advertise auto-negotiation parameters
  2110	 * @phydev: target phy_device struct
  2111	 * @advert: auto-negotiation parameters to advertise
  2112	 *
  2113	 * Description: Writes MII_ADVERTISE with the appropriate values,
  2114	 *   after sanitizing the values to make sure we only advertise
  2115	 *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
  2116	 *   hasn't changed, and > 0 if it has changed.
  2117	 */
  2118	static int genphy_config_advert(struct phy_device *phydev,
  2119					const unsigned long *advert)
  2120	{
  2121		int err, bmsr, changed = 0;
  2122		u32 adv;
  2123	
> 2124		adv = linkmode_adv_to_mii_adv_t(advert);
  2125	
  2126		/* Setup standard advertisement */
  2127		err = phy_modify_changed(phydev, MII_ADVERTISE,
  2128					 ADVERTISE_ALL | ADVERTISE_100BASE4 |
  2129					 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM,
  2130					 adv);
  2131		if (err < 0)
  2132			return err;
  2133		if (err > 0)
  2134			changed = 1;
  2135	
  2136		bmsr = phy_read(phydev, MII_BMSR);
  2137		if (bmsr < 0)
  2138			return bmsr;
  2139	
  2140		/* Per 802.3-2008, Section 22.2.4.2.16 Extended status all
  2141		 * 1000Mbits/sec capable PHYs shall have the BMSR_ESTATEN bit set to a
  2142		 * logical 1.
  2143		 */
  2144		if (!(bmsr & BMSR_ESTATEN))
  2145			return changed;
  2146	
  2147		adv = linkmode_adv_to_mii_ctrl1000_t(advert);
  2148	
  2149		err = phy_modify_changed(phydev, MII_CTRL1000,
  2150					 ADVERTISE_1000FULL | ADVERTISE_1000HALF,
  2151					 adv);
  2152		if (err < 0)
  2153			return err;
  2154		if (err > 0)
  2155			changed = 1;
  2156	
  2157		return changed;
  2158	}
  2159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

