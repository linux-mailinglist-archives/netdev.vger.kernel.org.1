Return-Path: <netdev+bounces-116736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D994B83C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A59D1C2440C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41288188013;
	Thu,  8 Aug 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB2t1GgE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63DF187FFE
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103429; cv=none; b=IcOJDzIUKBZIfcsTyowbqVm/0qgktwCQipv8LHkGCM3EL3TWmA3aY7wBvtN1S4AsIEeuB4pqT6BTj0A+Bt2xc2+PG79SgEZS/JAvqTbYs5Dtzk/pLXwibI5h6DekrPVg/9QpHDzrhxJ/T/JFR7uw3HxxlfrxWnnrbBH6E8Ukjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103429; c=relaxed/simple;
	bh=6mSHNe6mdZ/YCaSJIex1DtiKxZI6nfMm97TqMLdbsY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk/tX1RiXw3hLUgHwCf8rs2ebyR1PCl9hENq+1iFO1j27D1HfJ/ozxeU5uvyfKcNN+i2EoSNZx0ct3gLNHYFGyXjT6qDeJStMNhb7MVdKeI8gTmZgdnFbvd8DOla/rBSo838IhWExsiV4P2qezNT199HQXf+VJr4oaG4Kx4p0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB2t1GgE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103426; x=1754639426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6mSHNe6mdZ/YCaSJIex1DtiKxZI6nfMm97TqMLdbsY4=;
  b=DB2t1GgEQJ7RVB8ukuS1z8fN/Zx4kqU4JnqiDWMgUPfmmQxtufwWz+RV
   VZPYMi/kF/QXSIwYu9O9a71LPHiwDJvCHJI+KBjuKcXNqJFfTI1hVm9yE
   E7t50XLvEf8kfcCNPb/UuBLO5dP4CzLeE3NMIx/ruqYpJO5qL1t3Z4hwa
   xnOvfztqHhIPMbqWLjXZ6aoIUkQ2Z+0Jc7qzCvUsr6WrAEgzqnQlEZ3UP
   W7OTSClpVTVVrelBlIODMYCPG1e/HgQFAuvZh/RLm3hqwOMcGroFPhOFa
   V2twyrJTWHvmBBNg6lX186XC/O7F+AVbhxNBuJWpfbHjn919HGlRPR7Pa
   w==;
X-CSE-ConnectionGUID: Tg4qybYPT5iAe7he6MxL1w==
X-CSE-MsgGUID: rVef8Vu+Q9+7pRsDDI2DEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32618824"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="32618824"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:50:26 -0700
X-CSE-ConnectionGUID: z266mz+NS0OV/sNX1U+5KQ==
X-CSE-MsgGUID: E+pEpVc5TEO+hZ/5zckX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57059515"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 00:50:25 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbxug-00061e-1K;
	Thu, 08 Aug 2024 07:50:22 +0000
Date: Thu, 8 Aug 2024 15:50:13 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: freescale: use devm for alloc_etherdev_mqs
Message-ID: <202408081509.wAxfzXJb-lkp@intel.com>
References: <20240807190556.6817-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807190556.6817-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.11-rc2 next-20240808]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-freescale-use-devm-for-alloc_etherdev_mqs/20240808-060734
base:   net/main
patch link:    https://lore.kernel.org/r/20240807190556.6817-1-rosenp%40gmail.com
patch subject: [PATCH] net: freescale: use devm for alloc_etherdev_mqs
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240808/202408081509.wAxfzXJb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081509.wAxfzXJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408081509.wAxfzXJb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/fec_main.c: In function 'fec_probe':
>> drivers/net/ethernet/freescale/fec_main.c:4562:1: warning: label 'failed_ioremap' defined but not used [-Wunused-label]
    4562 | failed_ioremap:
         | ^~~~~~~~~~~~~~


vim +/failed_ioremap +4562 drivers/net/ethernet/freescale/fec_main.c

baa70a5c48a01e drivers/net/ethernet/freescale/fec.c      Frank Li           2013-01-16  4340  
5bbde4d2ec8061 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-27  4341  	/* Select default pin state */
5bbde4d2ec8061 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-27  4342  	pinctrl_pm_select_default_state(&pdev->dev);
5bbde4d2ec8061 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-27  4343  
4f830a5af7b5b3 drivers/net/ethernet/freescale/fec_main.c YueHaibing         2019-08-21  4344  	fep->hwp = devm_platform_ioremap_resource(pdev, 0);
a1f542e013d953 drivers/net/ethernet/freescale/fec_main.c Rosen Penev        2024-08-07  4345  	if (IS_ERR(fep->hwp))
a1f542e013d953 drivers/net/ethernet/freescale/fec_main.c Rosen Penev        2024-08-07  4346  		return PTR_ERR(fep->hwp);
941e173a538c58 drivers/net/ethernet/freescale/fec_main.c Tushar Behera      2013-06-10  4347  
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4348  	fep->pdev = pdev;
43af940c54d712 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2011-12-05  4349  	fep->dev_id = dev_id++;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4350  
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4351  	platform_set_drvdata(pdev, ndev);
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4352  
29380905565655 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2016-06-03  4353  	if ((of_machine_is_compatible("fsl,imx6q") ||
29380905565655 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2016-06-03  4354  	     of_machine_is_compatible("fsl,imx6dl")) &&
29380905565655 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2016-06-03  4355  	    !of_property_read_bool(np, "fsl,err006687-workaround-present"))
29380905565655 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2016-06-03  4356  		fep->quirks |= FEC_QUIRK_ERR006687;
29380905565655 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2016-06-03  4357  
40c79ce13b035b drivers/net/ethernet/freescale/fec_main.c Wei Fang           2022-09-02  4358  	ret = fec_enet_ipc_handle_init(fep);
40c79ce13b035b drivers/net/ethernet/freescale/fec_main.c Wei Fang           2022-09-02  4359  	if (ret)
40c79ce13b035b drivers/net/ethernet/freescale/fec_main.c Wei Fang           2022-09-02  4360  		goto failed_ipc_init;
40c79ce13b035b drivers/net/ethernet/freescale/fec_main.c Wei Fang           2022-09-02  4361  
1a87e641d8a50c drivers/net/ethernet/freescale/fec_main.c Rob Herring        2023-03-14  4362  	if (of_property_read_bool(np, "fsl,magic-packet"))
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4363  		fep->wol_flag |= FEC_WOL_HAS_MAGIC_PACKET;
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4364  
8a448bf832af53 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2020-05-26  4365  	ret = fec_enet_init_stop_mode(fep, np);
da722186f6549d drivers/net/ethernet/freescale/fec_main.c Martin Fuzzey      2020-04-02  4366  	if (ret)
da722186f6549d drivers/net/ethernet/freescale/fec_main.c Martin Fuzzey      2020-04-02  4367  		goto failed_stop_mode;
da722186f6549d drivers/net/ethernet/freescale/fec_main.c Martin Fuzzey      2020-04-02  4368  
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4369  	phy_node = of_parse_phandle(np, "phy-handle", 0);
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4370  	if (!phy_node && of_phy_is_fixed_link(np)) {
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4371  		ret = of_phy_register_fixed_link(np);
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4372  		if (ret < 0) {
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4373  			dev_err(&pdev->dev,
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4374  				"broken fixed-link specification\n");
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4375  			goto failed_phy;
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4376  		}
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4377  		phy_node = of_node_get(np);
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4378  	}
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4379  	fep->phy_node = phy_node;
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4380  
0c65b2b90d13c1 drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2019-11-04  4381  	ret = of_get_phy_mode(pdev->dev.of_node, &interface);
0c65b2b90d13c1 drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2019-11-04  4382  	if (ret) {
94660ba09079dd drivers/net/ethernet/freescale/fec_main.c Jingoo Han         2013-08-30  4383  		pdata = dev_get_platdata(&pdev->dev);
5eb32bd0593795 drivers/net/fec.c                         Baruch Siach       2010-05-24  4384  		if (pdata)
5eb32bd0593795 drivers/net/fec.c                         Baruch Siach       2010-05-24  4385  			fep->phy_interface = pdata->phy;
ca2cc333920690 drivers/net/fec.c                         Shawn Guo          2011-06-25  4386  		else
ca2cc333920690 drivers/net/fec.c                         Shawn Guo          2011-06-25  4387  			fep->phy_interface = PHY_INTERFACE_MODE_MII;
ca2cc333920690 drivers/net/fec.c                         Shawn Guo          2011-06-25  4388  	} else {
0c65b2b90d13c1 drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2019-11-04  4389  		fep->phy_interface = interface;
ca2cc333920690 drivers/net/fec.c                         Shawn Guo          2011-06-25  4390  	}
ca2cc333920690 drivers/net/fec.c                         Shawn Guo          2011-06-25  4391  
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4392  	ret = fec_enet_parse_rgmii_delay(fep, np);
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4393  	if (ret)
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4394  		goto failed_rgmii_delay;
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4395  
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4396  	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4397  	if (IS_ERR(fep->clk_ipg)) {
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4398  		ret = PTR_ERR(fep->clk_ipg);
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4399  		goto failed_clk;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4400  	}
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4401  
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4402  	fep->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4403  	if (IS_ERR(fep->clk_ahb)) {
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4404  		ret = PTR_ERR(fep->clk_ahb);
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4405  		goto failed_clk;
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4406  	}
f4d40de39a23f0 drivers/net/ethernet/freescale/fec.c      Sascha Hauer       2012-03-07  4407  
d851b47b22fc4c drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2014-09-17  4408  	fep->itr_clk_rate = clk_get_rate(fep->clk_ahb);
d851b47b22fc4c drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2014-09-17  4409  
daa7d392ffe67e drivers/net/ethernet/freescale/fec.c      Wolfram Sang       2013-01-29  4410  	/* enet_out is optional, depends on board */
5ff851b7be752a drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-20  4411  	fep->clk_enet_out = devm_clk_get_optional(&pdev->dev, "enet_out");
5ff851b7be752a drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-20  4412  	if (IS_ERR(fep->clk_enet_out)) {
5ff851b7be752a drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-20  4413  		ret = PTR_ERR(fep->clk_enet_out);
5ff851b7be752a drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-20  4414  		goto failed_clk;
5ff851b7be752a drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-20  4415  	}
daa7d392ffe67e drivers/net/ethernet/freescale/fec.c      Wolfram Sang       2013-01-29  4416  
91c0d987a9788d drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-08-21  4417  	fep->ptp_clk_on = false;
01b825f997ac28 drivers/net/ethernet/freescale/fec_main.c Francesco Dolcini  2022-09-12  4418  	mutex_init(&fep->ptp_clk_mutex);
9b5330edf1f8e2 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2014-09-13  4419  
9b5330edf1f8e2 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2014-09-13  4420  	/* clk_ref is optional, depends on board */
43252ed15f4665 drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-21  4421  	fep->clk_ref = devm_clk_get_optional(&pdev->dev, "enet_clk_ref");
43252ed15f4665 drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-21  4422  	if (IS_ERR(fep->clk_ref)) {
43252ed15f4665 drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-21  4423  		ret = PTR_ERR(fep->clk_ref);
43252ed15f4665 drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-21  4424  		goto failed_clk;
43252ed15f4665 drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2022-05-21  4425  	}
b82f8c3f1409f1 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4426  	fep->clk_ref_rate = clk_get_rate(fep->clk_ref);
9b5330edf1f8e2 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2014-09-13  4427  
fc539459e900a8 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4428  	/* clk_2x_txclk is optional, depends on board */
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4429  	if (fep->rgmii_txc_dly || fep->rgmii_rxc_dly) {
fc539459e900a8 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4430  		fep->clk_2x_txclk = devm_clk_get(&pdev->dev, "enet_2x_txclk");
fc539459e900a8 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4431  		if (IS_ERR(fep->clk_2x_txclk))
fc539459e900a8 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4432  			fep->clk_2x_txclk = NULL;
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4433  	}
fc539459e900a8 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2021-07-28  4434  
6b7e4008389c8c drivers/net/ethernet/freescale/fec_main.c Lothar Waßmann     2014-11-17  4435  	fep->bufdesc_ex = fep->quirks & FEC_QUIRK_HAS_BUFDESC_EX;
6605b730c061f6 drivers/net/ethernet/freescale/fec.c      Frank Li           2012-10-30  4436  	fep->clk_ptp = devm_clk_get(&pdev->dev, "ptp");
6605b730c061f6 drivers/net/ethernet/freescale/fec.c      Frank Li           2012-10-30  4437  	if (IS_ERR(fep->clk_ptp)) {
c29dc2d7714118 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2013-03-18  4438  		fep->clk_ptp = NULL;
217b5844e279c2 drivers/net/ethernet/freescale/fec_main.c Lothar Waßmann     2014-11-17  4439  		fep->bufdesc_ex = false;
6605b730c061f6 drivers/net/ethernet/freescale/fec.c      Frank Li           2012-10-30  4440  	}
6605b730c061f6 drivers/net/ethernet/freescale/fec.c      Frank Li           2012-10-30  4441  
e8fcfcd5684a41 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-20  4442  	ret = fec_enet_clk_enable(ndev, true);
13a097bd35a15b drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-07-21  4443  	if (ret)
13a097bd35a15b drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-07-21  4444  		goto failed_clk;
13a097bd35a15b drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-07-21  4445  
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4446  	ret = clk_prepare_enable(fep->clk_ipg);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4447  	if (ret)
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4448  		goto failed_clk_ipg;
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4449  	ret = clk_prepare_enable(fep->clk_ahb);
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4450  	if (ret)
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4451  		goto failed_clk_ahb;
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4452  
25974d8af1bc51 drivers/net/ethernet/freescale/fec_main.c Stefan Agner       2019-01-21  4453  	fep->reg_phy = devm_regulator_get_optional(&pdev->dev, "phy");
f4e9f3d2fdb141 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4454  	if (!IS_ERR(fep->reg_phy)) {
f4e9f3d2fdb141 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4455  		ret = regulator_enable(fep->reg_phy);
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4456  		if (ret) {
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4457  			dev_err(&pdev->dev,
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4458  				"Failed to enable phy regulator: %d\n", ret);
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4459  			goto failed_regulator;
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4460  		}
f6a4d607b3fdfa drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4461  	} else {
3f38c683033a9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-03  4462  		if (PTR_ERR(fep->reg_phy) == -EPROBE_DEFER) {
3f38c683033a9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-03  4463  			ret = -EPROBE_DEFER;
3f38c683033a9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-03  4464  			goto failed_regulator;
3f38c683033a9a drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-03  4465  		}
f6a4d607b3fdfa drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4466  		fep->reg_phy = NULL;
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4467  	}
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4468  
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4469  	pm_runtime_set_autosuspend_delay(&pdev->dev, FEC_MDIO_PM_TIMEOUT);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4470  	pm_runtime_use_autosuspend(&pdev->dev);
14d2b7c1a96ef3 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2015-08-03  4471  	pm_runtime_get_noresume(&pdev->dev);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4472  	pm_runtime_set_active(&pdev->dev);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4473  	pm_runtime_enable(&pdev->dev);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4474  
9269e5560b261e drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2017-04-11  4475  	ret = fec_reset_phy(pdev);
9269e5560b261e drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2017-04-11  4476  	if (ret)
9269e5560b261e drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2017-04-11  4477  		goto failed_reset;
2ca9b2aa0d5a43 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4478  
4ad1ceec05e491 drivers/net/ethernet/freescale/fec_main.c Troy Kisky         2017-11-03  4479  	irq_cnt = fec_enet_get_irq_cnt(pdev);
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4480  	if (fep->bufdesc_ex)
4ad1ceec05e491 drivers/net/ethernet/freescale/fec_main.c Troy Kisky         2017-11-03  4481  		fec_ptp_init(pdev, irq_cnt);
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4482  
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4483  	ret = fec_enet_init(ndev);
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4484  	if (ret)
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4485  		goto failed_init;
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4486  
4ad1ceec05e491 drivers/net/ethernet/freescale/fec_main.c Troy Kisky         2017-11-03  4487  	for (i = 0; i < irq_cnt; i++) {
3ded9f2b35f02c drivers/net/ethernet/freescale/fec_main.c Arnd Bergmann      2018-05-28  4488  		snprintf(irq_name, sizeof(irq_name), "int%d", i);
3b56be218f65e2 drivers/net/ethernet/freescale/fec_main.c Anson Huang        2019-10-29  4489  		irq = platform_get_irq_byname_optional(pdev, irq_name);
4ad1ceec05e491 drivers/net/ethernet/freescale/fec_main.c Troy Kisky         2017-11-03  4490  		if (irq < 0)
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4491  			irq = platform_get_irq(pdev, i);
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4492  		if (irq < 0) {
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4493  			ret = irq;
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4494  			goto failed_irq;
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4495  		}
0d9b2ab1c3760a drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-07-21  4496  		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
44a272ddfdd7e7 drivers/net/ethernet/freescale/fec_main.c Michael Opdenacker 2013-09-13  4497  				       0, pdev->name, ndev);
0d9b2ab1c3760a drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-07-21  4498  		if (ret)
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4499  			goto failed_irq;
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4500  
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4501  		fep->irq[i] = irq;
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4502  	}
e2f8d555ec04a0 drivers/net/ethernet/freescale/fec.c      Fabio Estevam      2013-02-22  4503  
b7cdc9658ac860 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-12  4504  	/* Decide which interrupt line is wakeup capable */
b7cdc9658ac860 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-12  4505  	fec_enet_get_wakeup_irq(pdev);
b7cdc9658ac860 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-12  4506  
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4507  	ret = fec_enet_mii_init(pdev);
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4508  	if (ret)
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4509  		goto failed_mii_init;
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4510  
03c698c93fc15d drivers/net/fec.c                         Oskar Schirmer     2010-10-07  4511  	/* Carrier starts down, phylib will bring it up */
03c698c93fc15d drivers/net/fec.c                         Oskar Schirmer     2010-10-07  4512  	netif_carrier_off(ndev);
e8fcfcd5684a41 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-20  4513  	fec_enet_clk_enable(ndev, false);
5bbde4d2ec8061 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-27  4514  	pinctrl_pm_select_sleep_state(&pdev->dev);
03c698c93fc15d drivers/net/fec.c                         Oskar Schirmer     2010-10-07  4515  
5919305351475d drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2020-07-11  4516  	ndev->max_mtu = PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN;
5919305351475d drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2020-07-11  4517  
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4518  	ret = register_netdev(ndev);
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4519  	if (ret)
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4520  		goto failed_register;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4521  
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4522  	device_init_wakeup(&ndev->dev, fep->wol_flag &
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4523  			   FEC_WOL_HAS_MAGIC_PACKET);
de40ed31b3c577 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-12-24  4524  
eb1d064058c7c7 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-04-13  4525  	if (fep->bufdesc_ex && fep->ptp_clock)
eb1d064058c7c7 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-04-13  4526  		netdev_info(ndev, "registered PHC device %d\n", fep->dev_id);
eb1d064058c7c7 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-04-13  4527  
36cdc743a320e7 drivers/net/ethernet/freescale/fec_main.c Russell King       2014-07-08  4528  	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4529  
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4530  	pm_runtime_mark_last_busy(&pdev->dev);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4531  	pm_runtime_put_autosuspend(&pdev->dev);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4532  
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4533  	return 0;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4534  
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4535  failed_register:
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4536  	fec_enet_mii_remove(fep);
e6b043d512fa8d drivers/net/fec.c                         Bryan Wu           2010-03-31  4537  failed_mii_init:
7a2bbd8d8e36c4 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4538  failed_irq:
bf0497f53c8535 drivers/net/ethernet/freescale/fec_main.c Xiaolei Wang       2024-05-24  4539  	fec_enet_deinit(ndev);
7a2bbd8d8e36c4 drivers/net/ethernet/freescale/fec_main.c Fabio Estevam      2013-05-27  4540  failed_init:
32cba57ba74be5 drivers/net/ethernet/freescale/fec_main.c Lucas Stach        2015-07-23  4541  	fec_ptp_stop(pdev);
9269e5560b261e drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2017-04-11  4542  failed_reset:
ce8d24f9a5965a drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-05-23  4543  	pm_runtime_put_noidle(&pdev->dev);
9269e5560b261e drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2017-04-11  4544  	pm_runtime_disable(&pdev->dev);
c6165cf0dbb82d drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2020-08-13  4545  	if (fep->reg_phy)
c6165cf0dbb82d drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2020-08-13  4546  		regulator_disable(fep->reg_phy);
5fa9c0fe3ec0a0 drivers/net/ethernet/freescale/fec.c      Shawn Guo          2012-06-27  4547  failed_regulator:
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4548  	clk_disable_unprepare(fep->clk_ahb);
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4549  failed_clk_ahb:
d7c3a206e6338e drivers/net/ethernet/freescale/fec_main.c Andy Duan          2019-04-09  4550  	clk_disable_unprepare(fep->clk_ipg);
8fff755e9f8d0f drivers/net/ethernet/freescale/fec_main.c Andrew Lunn        2015-07-25  4551  failed_clk_ipg:
e8fcfcd5684a41 drivers/net/ethernet/freescale/fec_main.c Nimrod Andy        2014-05-20  4552  	fec_enet_clk_enable(ndev, false);
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4553  failed_clk:
b820c114eba7e1 drivers/net/ethernet/freescale/fec_main.c Joakim Zhang       2021-08-03  4554  failed_rgmii_delay:
82005b1c19b119 drivers/net/ethernet/freescale/fec_main.c Johan Hovold       2016-11-28  4555  	if (of_phy_is_fixed_link(np))
82005b1c19b119 drivers/net/ethernet/freescale/fec_main.c Johan Hovold       2016-11-28  4556  		of_phy_deregister_fixed_link(np);
407066f8f3716c drivers/net/ethernet/freescale/fec_main.c Uwe Kleine-König   2014-08-11  4557  	of_node_put(phy_node);
da722186f6549d drivers/net/ethernet/freescale/fec_main.c Martin Fuzzey      2020-04-02  4558  failed_stop_mode:
40c79ce13b035b drivers/net/ethernet/freescale/fec_main.c Wei Fang           2022-09-02  4559  failed_ipc_init:
d1616f07e8f1a4 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-04  4560  failed_phy:
d1616f07e8f1a4 drivers/net/ethernet/freescale/fec_main.c Fugang Duan        2018-01-04  4561  	dev_id--;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28 @4562  failed_ioremap:
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4563  	free_netdev(ndev);
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4564  
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4565  	return ret;
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4566  }
ead731837d142b drivers/net/fec.c                         Sascha Hauer       2009-01-28  4567  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

