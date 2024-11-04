Return-Path: <netdev+bounces-141562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B919BB68F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94BF1F20F3F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AE70829;
	Mon,  4 Nov 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pu7BHzmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB68224F6;
	Mon,  4 Nov 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727799; cv=none; b=BDmtCZpMFjPekRdl+Q13MP8gBaQh/oxNG7/6Ms3DekaFqdaet5Byv6tYGlyHivWdZHw36rWGjSXucsXPzokF6IEIcPCUOLse9ookkaTsz8vPnq+CfAsocRfGl/UtE70lHA+0WQVheHtigU4lS9N6Svkzz8uH/P5ciVCmbJxCd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727799; c=relaxed/simple;
	bh=pfdLiPHWAnRK8GzYwwj/H0Doi1Poy7yrH+c1hhjKyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoWBdkd6qMkTht7GOcHCd0FTm1STN+S5H08lyjHX2gvvpoSkucdG7ZSbJw0of/0ugQgG3Ov3ErT6sqnUFQx6ak2xBO39Bq9zn3YE9Cjq7eLSikbuRulfNfhlewDNM+O4zpSefaewrNDTohXCiyUTOxJjtU6RUghicBw9JNHUudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pu7BHzmW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730727797; x=1762263797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfdLiPHWAnRK8GzYwwj/H0Doi1Poy7yrH+c1hhjKyKY=;
  b=Pu7BHzmWw09b6iho+waKzqw5GjtM2GXduUPXXxboPG4LI6Z3bPhlT35j
   Dbmq06UZg1AXxgM6JYwz2GkUK4MNDE6ctEFbOF4JN5JemBwMmMoaCAo+Y
   w3Bl00rp3yQ1PWgir21hWA89YaTiIv+YA/3kWW628sTYivrMDULXuMlOd
   Fz77Bu5FtwdarU5oXWqnP67FxA5gKOd7nyLdWlojcxTl2RnytLQPDeSHT
   Sj90luAv/yWQjsmrVmqWc1KuZHE/X4NK0kmwLL6j9nWE7MJ8egfS0J0xL
   +4Cb3DTMh1Rl8V7q6mMP6Uk03B76TeskuhDCdN23Jf+piThHNcV8r3To7
   Q==;
X-CSE-ConnectionGUID: Zs8pT3+FRl+5EP89JTNcgw==
X-CSE-MsgGUID: dl9/WXkeSn2NXvidIJzEhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30277541"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30277541"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:43:17 -0800
X-CSE-ConnectionGUID: oGMnb9OtSJe8Y/GlKwE3PQ==
X-CSE-MsgGUID: jU7S/xEYSwCy9/t5rk1LUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83544510"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2024 05:43:15 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7xMN-000krB-30;
	Mon, 04 Nov 2024 13:43:11 +0000
Date: Mon, 4 Nov 2024 21:42:46 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair23@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@armlinux.org.uk,
	hkallweit1@gmail.com, andrew@lunn.ch, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
Message-ID: <202411042121.OYNPibb0-lkp@intel.com>
References: <20241104070950.502719-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104070950.502719-1-alistair.francis@wdc.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on horms-ipvs/master v6.12-rc6 next-20241104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/include-mdio-Guard-inline-function-with-CONFIG_MDIO/20241104-151211
base:   linus/master
patch link:    https://lore.kernel.org/r/20241104070950.502719-1-alistair.francis%40wdc.com
patch subject: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20241104/202411042121.OYNPibb0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411042121.OYNPibb0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411042121.OYNPibb0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/sfc/falcon/qt202x_phy.c: In function 'qt202x_phy_get_link_ksettings':
>> drivers/net/ethernet/sfc/falcon/qt202x_phy.c:440:9: error: implicit declaration of function 'mdio45_ethtool_ksettings_get' [-Wimplicit-function-declaration]
     440 |         mdio45_ethtool_ksettings_get(&efx->mdio, cmd);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/sfc/falcon/tenxpress.c: In function 'tenxpress_get_link_ksettings':
>> drivers/net/ethernet/sfc/falcon/tenxpress.c:453:9: error: implicit declaration of function 'mdio45_ethtool_ksettings_get_npage' [-Wimplicit-function-declaration]
     453 |         mdio45_ethtool_ksettings_get_npage(&efx->mdio, cmd, adv, lpa);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/sfc/falcon/txc43128_phy.c: In function 'txc43128_get_link_ksettings':
>> drivers/net/ethernet/sfc/falcon/txc43128_phy.c:543:9: error: implicit declaration of function 'mdio45_ethtool_ksettings_get' [-Wimplicit-function-declaration]
     543 |         mdio45_ethtool_ksettings_get(&efx->mdio, cmd);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mdio45_ethtool_ksettings_get +440 drivers/net/ethernet/sfc/falcon/qt202x_phy.c

8ceee660aacb29 drivers/net/sfc/xfp_phy.c                    Ben Hutchings   2008-04-27  436  
e938ed150f1ed9 drivers/net/ethernet/sfc/falcon/qt202x_phy.c Philippe Reynes 2017-01-01  437  static void qt202x_phy_get_link_ksettings(struct ef4_nic *efx,
e938ed150f1ed9 drivers/net/ethernet/sfc/falcon/qt202x_phy.c Philippe Reynes 2017-01-01  438  					  struct ethtool_link_ksettings *cmd)
68e7f45e118f98 drivers/net/sfc/xfp_phy.c                    Ben Hutchings   2009-04-29  439  {
e938ed150f1ed9 drivers/net/ethernet/sfc/falcon/qt202x_phy.c Philippe Reynes 2017-01-01 @440  	mdio45_ethtool_ksettings_get(&efx->mdio, cmd);
68e7f45e118f98 drivers/net/sfc/xfp_phy.c                    Ben Hutchings   2009-04-29  441  }
8ceee660aacb29 drivers/net/sfc/xfp_phy.c                    Ben Hutchings   2008-04-27  442  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

