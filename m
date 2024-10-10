Return-Path: <netdev+bounces-134236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DEC998787
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7991F21CB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FF1C9B93;
	Thu, 10 Oct 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2N2DsUm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FD1C3316;
	Thu, 10 Oct 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566599; cv=none; b=FH0tz9UjoHlbbTaO6K26I5/EKmOfnJ0fuuAkpKhLX+D9YfIezf2NjiUsF7ZKY8eQlseFVMNIffSlW4AU6vLDCqK8h6E3FoiyJGnjwyG+RYpukL+IhnWL/OJyzHgfL+ZYah42vnoCxPl1Tqlmj3arYcFyfiFm4sE28sNXNEjhQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566599; c=relaxed/simple;
	bh=8gkgQpfHiPKDNwXXX6H42EXWbu+1NYnLstaEU40yiVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBRTjOvCAzlGR0sYGbD26bu+7eU146/ho54TLyHuzdndNIaQRhbzyunNDJLo2TU1FH8hbDY7fw9hx+2UC5VUAqumdycFMV1J3oCw2Zr1x+knP4wFTQWQbohAzIdQ07DRFm4/MeZPdgl5BrCO95hhHMpk30bX20VSqqz4ouu++So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2N2DsUm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728566597; x=1760102597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gkgQpfHiPKDNwXXX6H42EXWbu+1NYnLstaEU40yiVg=;
  b=X2N2DsUm4hoDOWEf/CBoVeCLB6MnVwOM2iZ7GEEJeSv9BWKsibUzePlf
   RffRys6rG5MOJUObP3R6tIXFzH2/H0kfOKZSZ48vz9afZ0gmTyoQo2XGk
   di3SQm8USmKdXz6f1NVOZ3PSPprYMiFEXWhtK/xGTO5SebFZoHV4PQFph
   R5AMtBNBDpwwjnb6EQEA/9dWuINeyzT1aieqbCKv0uXbekQDbLdHyeKyG
   +lyX7elteCACyiT8vcqVWx++b3I2ywMp4j/aT6ZehI+VxJPj73PvmnchK
   oq6fLINbPPCPvSPmJab3suSD3oekA1axmbgvcyQTrw5jyk24ePzStmWe0
   A==;
X-CSE-ConnectionGUID: oHdOTM8PR7yPisrudmqb3A==
X-CSE-MsgGUID: oYSPN9VhRaWUI4brDS/Ddg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39288630"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39288630"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:23:16 -0700
X-CSE-ConnectionGUID: 8m+xtbiWRPKjBiHC/Uu+Ag==
X-CSE-MsgGUID: g4DDWm/IRbWUAcw1Dj6xWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76777958"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2024 06:23:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syt8I-000An3-2K;
	Thu, 10 Oct 2024 13:23:10 +0000
Date: Thu, 10 Oct 2024 21:23:01 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <202410102110.ts6N9Ge2-lkp@intel.com>
References: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-intel-xway-add-support-for-PHY-LEDs/20241009-103036
base:   net-next/main
patch link:    https://lore.kernel.org/r/c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel%40makrotopia.org
patch subject: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
config: xtensa-randconfig-r073-20241010 (https://download.01.org/0day-ci/archive/20241010/202410102110.ts6N9Ge2-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410102110.ts6N9Ge2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410102110.ts6N9Ge2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/intel-xway.c: In function 'xway_gphy_led_polarity_set':
>> drivers/net/phy/intel-xway.c:518:22: error: 'PHY_LED_ACTIVE_HIGH' undeclared (first use in this function); did you mean 'PHY_LED_ACTIVE_LOW'?
     518 |                 case PHY_LED_ACTIVE_HIGH:
         |                      ^~~~~~~~~~~~~~~~~~~
         |                      PHY_LED_ACTIVE_LOW
   drivers/net/phy/intel-xway.c:518:22: note: each undeclared identifier is reported only once for each function it appears in


vim +518 drivers/net/phy/intel-xway.c

   503	
   504	static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
   505					      unsigned long modes)
   506	{
   507		bool active_low = false;
   508		u32 mode;
   509	
   510		if (index >= XWAY_GPHY_MAX_LEDS)
   511			return -EINVAL;
   512	
   513		for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
   514			switch (mode) {
   515			case PHY_LED_ACTIVE_LOW:
   516				active_low = true;
   517				break;
 > 518			case PHY_LED_ACTIVE_HIGH:
   519				break;
   520			default:
   521				return -EINVAL;
   522			}
   523		}
   524	
   525		return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
   526				  active_low ? XWAY_GPHY_LED_INV(index) : 0);
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

