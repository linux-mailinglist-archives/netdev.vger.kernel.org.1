Return-Path: <netdev+bounces-128031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF397785D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158271F25D23
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D581B12E7;
	Fri, 13 Sep 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3vf5fy2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2417BED3;
	Fri, 13 Sep 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205382; cv=none; b=ljLqPLBHB91Hgfo6+vpuyFAmhDPsJu2TC47tYZLcz0igRHaN/uTpGrVSoMtWl2HO8FDvqg5lfbF8n0HuWCYpSG2NSJkDYsyjWqjPLv2L2KMM+jH+EPwlP1gpIqzpfASbdImKBUqcTCuIgABU0JEsbgeihfcyjJsmbbIBaVlBGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205382; c=relaxed/simple;
	bh=80v5ch7Jk09s6l+BVbrjWkR705j1W08EbcI8sSu/9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCHwwuHw/UX1aQXNa/UZoPidak81QvoqtNYU1oOA2im87C/VC/r6raxTDCD+6OIKpgIDt8keixvP5K5Rzlu2z3VhHGxzXK98AntzbjvC4iHiud296GrIrJ8d39NJTw4byjmL6UOUPmkNPdtuy/Z5cvIyLIKwGplOVfS0Q1ZhXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3vf5fy2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726205380; x=1757741380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80v5ch7Jk09s6l+BVbrjWkR705j1W08EbcI8sSu/9F8=;
  b=U3vf5fy2xJRyrsOhDPI1WDa28VDlCLPJRGTa9rCwcjYFrqSJcS9MhX4i
   blyYwqndMks/kvBbU9yvXn91oaYv/Rs4TDfO1rVF5kvP8A9LfK9W9K559
   SUPXPzALu2ND6p9e849rWkrp9RaFUnhQ8ntLT0Getydiit/jab5iMBjhW
   r3mJMZqtohGWFRxFnWvmG4pROUn7ylp49Lfccwow6LXjOibMVwXMRJhfO
   Bq/AONTrg8Rfl1uFrYxtZfbcpmd7GUIQYIMlbPk7KWENGiK3LTa2d5Cwr
   Y4orKwXZEk7N6DX1cYT1PsUW47hrOkJoj1oJo9KsFtfra4to1Ajf7zmNr
   A==;
X-CSE-ConnectionGUID: 43hHI2wsTPeRhxOh0PzmAQ==
X-CSE-MsgGUID: e+FTPDnCQl6dDJ3pzlhLNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25190268"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25190268"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:29:39 -0700
X-CSE-ConnectionGUID: dGw7irkORmu/2kylREtn/g==
X-CSE-MsgGUID: RvVP3gC/Qze0ht9Is4J6zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72047680"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Sep 2024 22:29:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soys8-00062u-2q;
	Fri, 13 Sep 2024 05:29:32 +0000
Date: Fri, 13 Sep 2024 13:29:13 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 3/7] net: phy: lxt: Mark LXT973 PHYs as having a
 broken isolate mode
Message-ID: <202409131315.SEzdGTvD-lkp@intel.com>
References: <20240911212713.2178943-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911212713.2178943-4-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-allow-isolating-PHY-devices/20240912-053106
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240911212713.2178943-4-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 3/7] net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
config: x86_64-randconfig-121-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131315.SEzdGTvD-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131315.SEzdGTvD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131315.SEzdGTvD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/lxt.c:331:10: sparse: sparse: Initializer entry defined twice
   drivers/net/phy/lxt.c:337:10: sparse:   also defined here
   drivers/net/phy/lxt.c:343:10: sparse: sparse: Initializer entry defined twice
   drivers/net/phy/lxt.c:348:10: sparse:   also defined here

vim +331 drivers/net/phy/lxt.c

e13647c158307f Richard Cochran      2010-06-07  307  
d5bf9071e71a4d Christian Hohnstaedt 2012-07-04  308  static struct phy_driver lxt97x_driver[] = {
d5bf9071e71a4d Christian Hohnstaedt 2012-07-04  309  {
600991b003039b Uwe Zeisberger       2006-06-25  310  	.phy_id		= 0x78100000,
00db8189d984d6 Andy Fleming         2005-07-30  311  	.name		= "LXT970",
600991b003039b Uwe Zeisberger       2006-06-25  312  	.phy_id_mask	= 0xfffffff0,
dcdecdcfe1fc39 Heiner Kallweit      2019-04-12  313  	/* PHY_BASIC_FEATURES */
00db8189d984d6 Andy Fleming         2005-07-30  314  	.config_init	= lxt970_config_init,
00db8189d984d6 Andy Fleming         2005-07-30  315  	.config_intr	= lxt970_config_intr,
01c4a00bf34797 Ioana Ciornei        2020-11-13  316  	.handle_interrupt = lxt970_handle_interrupt,
d5bf9071e71a4d Christian Hohnstaedt 2012-07-04  317  }, {
600991b003039b Uwe Zeisberger       2006-06-25  318  	.phy_id		= 0x001378e0,
00db8189d984d6 Andy Fleming         2005-07-30  319  	.name		= "LXT971",
600991b003039b Uwe Zeisberger       2006-06-25  320  	.phy_id_mask	= 0xfffffff0,
dcdecdcfe1fc39 Heiner Kallweit      2019-04-12  321  	/* PHY_BASIC_FEATURES */
00db8189d984d6 Andy Fleming         2005-07-30  322  	.config_intr	= lxt971_config_intr,
01c4a00bf34797 Ioana Ciornei        2020-11-13  323  	.handle_interrupt = lxt971_handle_interrupt,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  324  	.suspend	= genphy_suspend,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  325  	.resume		= genphy_resume,
871d1d6b59802a LEROY Christophe     2012-09-24  326  }, {
871d1d6b59802a LEROY Christophe     2012-09-24  327  	.phy_id		= 0x00137a10,
871d1d6b59802a LEROY Christophe     2012-09-24  328  	.name		= "LXT973-A2",
871d1d6b59802a LEROY Christophe     2012-09-24  329  	.phy_id_mask	= 0xffffffff,
dcdecdcfe1fc39 Heiner Kallweit      2019-04-12  330  	/* PHY_BASIC_FEATURES */
871d1d6b59802a LEROY Christophe     2012-09-24 @331  	.flags		= 0,
871d1d6b59802a LEROY Christophe     2012-09-24  332  	.probe		= lxt973_probe,
871d1d6b59802a LEROY Christophe     2012-09-24  333  	.config_aneg	= lxt973_config_aneg,
871d1d6b59802a LEROY Christophe     2012-09-24  334  	.read_status	= lxt973a2_read_status,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  335  	.suspend	= genphy_suspend,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  336  	.resume		= genphy_resume,
c9dd02714c2f91 Maxime Chevallier    2024-09-11  337  	.flags		= PHY_NO_ISOLATE,
d5bf9071e71a4d Christian Hohnstaedt 2012-07-04  338  }, {
e13647c158307f Richard Cochran      2010-06-07  339  	.phy_id		= 0x00137a10,
e13647c158307f Richard Cochran      2010-06-07  340  	.name		= "LXT973",
e13647c158307f Richard Cochran      2010-06-07  341  	.phy_id_mask	= 0xfffffff0,
dcdecdcfe1fc39 Heiner Kallweit      2019-04-12  342  	/* PHY_BASIC_FEATURES */
e13647c158307f Richard Cochran      2010-06-07  343  	.flags		= 0,
e13647c158307f Richard Cochran      2010-06-07  344  	.probe		= lxt973_probe,
e13647c158307f Richard Cochran      2010-06-07  345  	.config_aneg	= lxt973_config_aneg,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  346  	.suspend	= genphy_suspend,
5556fdb0c2ea3a Christophe Leroy     2019-05-23  347  	.resume		= genphy_resume,
c9dd02714c2f91 Maxime Chevallier    2024-09-11  348  	.flags		= PHY_NO_ISOLATE,
d5bf9071e71a4d Christian Hohnstaedt 2012-07-04  349  } };
e13647c158307f Richard Cochran      2010-06-07  350  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

