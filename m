Return-Path: <netdev+bounces-214282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBDB28BE7
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9115EA2650E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AE22D78A;
	Sat, 16 Aug 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTRyKVP0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBE21FF48;
	Sat, 16 Aug 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333361; cv=none; b=eqXdVP7DKACrLELesJ7UWQOWnZqf02PNBLZEnkiTeo2Y0QY2w3e8xZsKPN3ZXRnRtBJkM9GiqDUVKNUnQEYCYSXg9BV/InlnGWt4uY0LKPY+Yyru0IpctZuB/RGphiBXGO+GoTwmLVxGTTBlSayDq7s9Zau2mEt0Ge+wpxTq3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333361; c=relaxed/simple;
	bh=S8EWc+gXTdvua31+K3gBSLSSlCkt94iW3fkFGdY/vVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6pNX39HvETGMMHHfjdhiHYZblE8KuYaVmc6tTP2/+/LGRkk2xe0qYxmNErUgfd3U2MzOPfoxvQ9scw7y4oLR0CaIeXbRnA8mY3KVlPcEY+eAANvDq97DBSupHJU4FMxB52WxaEPfzUKl9P1hs4TcCvrAczXEHlFKSerEqnI0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTRyKVP0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755333359; x=1786869359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8EWc+gXTdvua31+K3gBSLSSlCkt94iW3fkFGdY/vVo=;
  b=RTRyKVP0CsyAeQijoNnxUvT1q4wFsjsOf/M3NwyYN+1Gq8MamtAliRT9
   ElR+VYh14ELb6W4T0BzaX4Pc126xC7L5HI50GSDLKtUGujsB2LEAWScVb
   j3jrsl0rL3OwupAdapxD3gzorysvHgV0Wddr6Ml7eqvHTg9U/4GRnkjfF
   /DqY6osHN6L9lxAxY1L39Z/7Al4MQ54XacEt5O0BOuRb69mJ0xY2/8WQv
   2TSVvRP5o5dUwENedyoAVEZy6865fw/eZMBVBXiUKO29IYadX6NAVCZWP
   rEfU0Tzi8Hw3L2Q6QgZcZZ8WMeCD/SVT01wyuYKDHpX5zZagyEJD2mSHW
   g==;
X-CSE-ConnectionGUID: Xq8HCNxjQsWvPLNfV8poAQ==
X-CSE-MsgGUID: NimgjTdkSlyFFIbfpP9GWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="83067295"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="83067295"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 01:35:58 -0700
X-CSE-ConnectionGUID: 3hMrR6qqS0maGbanPwTd3g==
X-CSE-MsgGUID: BWs6NsjNTWakM19zjvPqUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167996317"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 16 Aug 2025 01:35:56 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unCOI-000Ck8-0M;
	Sat, 16 Aug 2025 08:35:54 +0000
Date: Sat, 16 Aug 2025 16:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Xu Liang <lxu@maxlinear.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: mxl-86110: add basic support for
 MxL86111 PHY
Message-ID: <202508161615.Zd1agg0S-lkp@intel.com>
References: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9hZ6kan3Wlhxkt@pidgin.makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-mxl-86110-add-basic-support-for-MxL86111-PHY/20250816-003534
base:   net-next/main
patch link:    https://lore.kernel.org/r/aJ9hZ6kan3Wlhxkt%40pidgin.makrotopia.org
patch subject: [PATCH net-next 2/2] net: phy: mxl-86110: add basic support for MxL86111 PHY
config: x86_64-buildonly-randconfig-003-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161615.Zd1agg0S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161615.Zd1agg0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161615.Zd1agg0S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/phy/mxl-86110.c: In function 'mxl86111_probe':
>> drivers/net/phy/mxl-86110.c:736:13: warning: variable 'reg_page' set but not used [-Wunused-but-set-variable]
     736 |         u16 reg_page;
         |             ^~~~~~~~


vim +/reg_page +736 drivers/net/phy/mxl-86110.c

   726	
   727	/**
   728	 * mxl86111_probe() - validate bootstrap chip config and set UTP page
   729	 * @phydev: pointer to the phy_device
   730	 *
   731	 * returns 0 or negative errno code
   732	 */
   733	static int mxl86111_probe(struct phy_device *phydev)
   734	{
   735		int chip_config;
 > 736		u16 reg_page;
   737		int ret;
   738	
   739		chip_config = mxl86110_read_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG);
   740		if (chip_config < 0)
   741			return chip_config;
   742	
   743		switch (chip_config & MXL86111_EXT_CHIP_CFG_MODE_SEL_MASK) {
   744		case MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_SGMII:
   745		case MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_RGMII:
   746			phydev->port = PORT_TP;
   747			reg_page = MXL86111_EXT_SMI_SDS_PHYUTP_SPACE;
   748			break;
   749		default:
   750			return -EOPNOTSUPP;
   751		}
   752	
   753		ret = mxl86110_write_extended_reg(phydev,
   754						  MXL86111_EXT_SMI_SDS_PHY_REG,
   755						  MXL86111_EXT_SMI_SDS_PHYUTP_SPACE);
   756		if (ret < 0)
   757			return ret;
   758	
   759		return 0;
   760	}
   761	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

