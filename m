Return-Path: <netdev+bounces-230687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03601BED4B7
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C3719A620D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB12580F3;
	Sat, 18 Oct 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLagoKNM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E331245008
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807976; cv=none; b=q+klno3XzNTpvxvuK+g40Xg5GCbsNzCzH8Ekhi+XcxOnqEgi+s4IAoemjgMPGkFEedcaGZDoP4Qm3BBTRQljNSiypETRxGKSLH3qjmeFOmEKVsr7KLoR8dSpPM5Fnj5dyj6R3P9+pOsL/I20zc1iVDrnNaOktNtYsiohndkkSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807976; c=relaxed/simple;
	bh=+QKkOCD8HiGgcE3dcF0ky6v8p1BN/QvwbYBrPT7m4qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acNpEXWOb/cBZEtx6tZHh8KelR9xT4YT5Xyiek7Ctw7bbhzi7N9WqPkMwlpev+4cMDsJE6IwrbbnqJDPa4ZM4ayMdSahB+wjlnbA1EW1hxeeo/uPTPgkLuMhU/U0hat8DBcfk5UEhVczXtTqC7ul1wN/V138EP/LfWSI+akg0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLagoKNM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760807973; x=1792343973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QKkOCD8HiGgcE3dcF0ky6v8p1BN/QvwbYBrPT7m4qU=;
  b=NLagoKNMRwyIcTG+FW3UnPhRV7nKYPcK9lbAnKphnh47IGgCXYJyKqqn
   cvjxqM+uWREpVhtsh0qI7NJ/GGuKWbj8+oPGm4BGbO7rmDjiY5Ts9iuxs
   JNnGwhb8xlRKjNoEMVtifIagA4Dcjc7zEP5wfV3dZopkLb74JCqnuoI2S
   7TUp894PkA4jN1/wDl2pTWbkSWgthwAOY9gWpNp84cB1PRoFEDyOavdah
   d/70aJxwhEsNRMmjB7YAPH09B1Y8SuX1tuljkn3t8zHaxgcIVdu5E5+cZ
   aDqE1bCgICVIceyTeH4yacA+guPWg1/Q97VodpCxIiXuCHIYcCGNIrk4f
   Q==;
X-CSE-ConnectionGUID: j99d6eEUS4iYqXATT5RjlA==
X-CSE-MsgGUID: YJbQ2ZavQxy8M1m6Ku8EAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63086351"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63086351"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:19:32 -0700
X-CSE-ConnectionGUID: z0UrEBYGROGKrIj5CQNsiw==
X-CSE-MsgGUID: qB8UpDwBTjavC3poo+c9lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188286438"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2025 10:19:29 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAAaV-0008Rx-1M;
	Sat, 18 Oct 2025 17:19:27 +0000
Date: Sun, 19 Oct 2025 01:19:14 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: stmmac: mdio: use phy_find_first to
 simplify stmmac_mdio_register
Message-ID: <202510190044.J5cuIzfz-lkp@intel.com>
References: <2a4a4138-fe61-48c7-8907-6414f0b471e7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4a4138-fe61-48c7-8907-6414f0b471e7@gmail.com>

Hi Heiner,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/net-stmmac-mdio-use-phy_find_first-to-simplify-stmmac_mdio_register/20251018-094132
base:   net-next/main
patch link:    https://lore.kernel.org/r/2a4a4138-fe61-48c7-8907-6414f0b471e7%40gmail.com
patch subject: [PATCH net-next] net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251019/202510190044.J5cuIzfz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190044.J5cuIzfz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190044.J5cuIzfz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:684:16: warning: variable 'addr' is uninitialized when used here [-Wuninitialized]
     684 |                 new_bus->irq[addr] = mdio_bus_data->probed_phy_irq;
         |                              ^~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:588:10: note: initialize the variable 'addr' to silence this warning
     588 |         int addr, max_addr;
         |                 ^
         |                  = 0
   1 warning generated.


vim +/addr +684 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c

6717746f33abcd drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Russell King (Oracle  2025-09-04  571) 
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  572  /**
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  573   * stmmac_mdio_register
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  574   * @ndev: net device structure
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  575   * Description: it registers the MII bus
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  576   */
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  577  int stmmac_mdio_register(struct net_device *ndev)
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  578  {
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  579  	int err = 0;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  580  	struct mii_bus *new_bus;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  581  	struct stmmac_priv *priv = netdev_priv(ndev);
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  582  	struct stmmac_mdio_bus_data *mdio_bus_data = priv->plat->mdio_bus_data;
a7657f128c279a drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Giuseppe CAVALLARO    2016-04-01  583  	struct device_node *mdio_node = priv->plat->mdio_node;
fbca164776e438 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Romain Perier         2017-08-10  584  	struct device *dev = ndev->dev.parent;
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  585  	struct fwnode_handle *fixed_node;
e80af2acdef73d drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Russell King (Oracle  2023-08-24  586) 	struct fwnode_handle *fwnode;
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  587  	struct phy_device *phydev;
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  588  	int addr, max_addr;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  589  
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  590  	if (!mdio_bus_data)
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  591  		return 0;
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  592  
661a868937a1cf drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Russell King (Oracle  2025-09-04  593) 	stmmac_mdio_bus_config(priv);
6717746f33abcd drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Russell King (Oracle  2025-09-04  594) 
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  595  	new_bus = mdiobus_alloc();
efd89b60a35d6a drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c LABBE Corentin        2017-02-08  596  	if (!new_bus)
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  597  		return -ENOMEM;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  598  
e7f4dc3536a400 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2016-01-06  599  	if (mdio_bus_data->irqs)
643d60bf575daa drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Marek Vasut           2016-05-26  600  		memcpy(new_bus->irq, mdio_bus_data->irqs, sizeof(new_bus->irq));
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  601  
90b9a5454fd2e6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Alessandro Rubini     2012-01-23  602  	new_bus->name = "stmmac";
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  603  
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  604  	if (priv->plat->has_xgmac) {
5b0a447efff5a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  605  		new_bus->read = &stmmac_xgmac2_mdio_read_c22;
5b0a447efff5a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  606  		new_bus->write = &stmmac_xgmac2_mdio_write_c22;
5b0a447efff5a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  607  		new_bus->read_c45 = &stmmac_xgmac2_mdio_read_c45;
5b0a447efff5a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  608  		new_bus->write_c45 = &stmmac_xgmac2_mdio_write_c45;
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  609  
10857e6779054f drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rohan G Thomas        2023-07-31  610  		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  611  			/* Right now only C22 phys are supported */
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  612  			max_addr = MII_XGMAC_MAX_C22ADDR + 1;
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  613  
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  614  			/* Check if DT specified an unsupported phy addr */
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  615  			if (priv->plat->phy_addr > MII_XGMAC_MAX_C22ADDR)
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  616  				dev_err(dev, "Unsupported phy_addr (max=%d)\n",
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  617  					MII_XGMAC_MAX_C22ADDR);
10857e6779054f drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rohan G Thomas        2023-07-31  618  		} else {
10857e6779054f drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rohan G Thomas        2023-07-31  619  			/* XGMAC version 2.20 onwards support 32 phy addr */
10857e6779054f drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rohan G Thomas        2023-07-31  620  			max_addr = PHY_MAX_ADDR;
10857e6779054f drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rohan G Thomas        2023-07-31  621  		}
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  622  	} else {
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  623  		new_bus->read = &stmmac_mdio_read_c22;
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  624  		new_bus->write = &stmmac_mdio_write_c22;
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  625  		if (priv->plat->has_gmac4) {
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  626  			new_bus->read_c45 = &stmmac_mdio_read_c45;
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  627  			new_bus->write_c45 = &stmmac_mdio_write_c45;
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  628  		}
3c7826d0b1066b drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  629  
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  630  		max_addr = PHY_MAX_ADDR;
6fc21117b791b6 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2018-08-08  631  	}
ac1f74a7fc1976 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Alexandre TORGUE      2016-04-28  632  
1a981c0586c038 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Thierry Reding        2019-07-26  633  	if (mdio_bus_data->needs_reset)
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  634  		new_bus->reset = &stmmac_mdio_reset;
1a981c0586c038 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Thierry Reding        2019-07-26  635  
db8857bf5bd888 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Florian Fainelli      2012-01-09  636  	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s-%x",
d56631a66c0d0c drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Srinivas Kandagatla   2012-08-30  637  		 new_bus->name, priv->plat->bus_id);
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  638  	new_bus->priv = ndev;
351066bad6ade5 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Serge Semin           2024-07-01  639  	new_bus->phy_mask = mdio_bus_data->phy_mask | mdio_bus_data->pcs_mask;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  640  	new_bus->parent = priv->device;
e34d65696d2ef1 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2015-12-14  641  
e34d65696d2ef1 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2015-12-14  642  	err = of_mdiobus_register(new_bus, mdio_node);
e23c0d21ce9234 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Halaney        2023-12-12  643  	if (err == -ENODEV) {
e23c0d21ce9234 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Halaney        2023-12-12  644  		err = 0;
e23c0d21ce9234 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Halaney        2023-12-12  645  		dev_info(dev, "MDIO bus is disabled\n");
e23c0d21ce9234 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Halaney        2023-12-12  646  		goto bus_register_fail;
e23c0d21ce9234 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Halaney        2023-12-12  647  	} else if (err) {
839612d23ffd93 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Rasmus Villemoes      2022-06-02  648  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  649  		goto bus_register_fail;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  650  	}
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  651  
04d1190aca7747 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2019-11-11  652  	/* Looks like we need a dummy read for XGMAC only and C45 PHYs */
04d1190aca7747 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2019-11-11  653  	if (priv->plat->has_xgmac)
5b0a447efff5a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Andrew Lunn           2023-01-12  654  		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
04d1190aca7747 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Jose Abreu            2019-11-11  655  
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  656  	/* If fixed-link is set, skip PHY scanning */
e80af2acdef73d drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Russell King (Oracle  2023-08-24  657) 	fwnode = priv->plat->port_node;
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  658  	if (!fwnode)
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  659  		fwnode = dev_fwnode(priv->device);
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  660  
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  661  	if (fwnode) {
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  662  		fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  663  		if (fixed_node) {
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  664  			fwnode_handle_put(fixed_node);
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  665  			goto bus_register_done;
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  666  		}
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  667  	}
ab21cf920928a7 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Ong Boon Leong        2022-06-15  668  
cc2fa619a738a0 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2016-03-15  669  	if (priv->plat->phy_node || mdio_node)
cc2fa619a738a0 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2016-03-15  670  		goto bus_register_done;
cc2fa619a738a0 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2016-03-15  671  
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  672  	phydev = phy_find_first(new_bus);
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  673  	if (!phydev || phydev->mdio.addr >= max_addr) {
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  674  		dev_warn(dev, "No PHY found\n");
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  675  		err = -ENODEV;
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  676  		goto no_phy_found;
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  677  	}
cc26dc67b69a73 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c LABBE Corentin        2017-02-15  678  
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  679  	/*
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  680  	 * If an IRQ was provided to be assigned after
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  681  	 * the bus probe, do it here.
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  682  	 */
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  683  	if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
cc26dc67b69a73 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c LABBE Corentin        2017-02-15 @684  		new_bus->irq[addr] = mdio_bus_data->probed_phy_irq;
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  685  		phydev->irq = mdio_bus_data->probed_phy_irq;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  686  	}
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  687  
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  688  	/*
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  689  	 * If we're going to bind the MAC to this PHY bus, and no PHY number
e08dc713606b32 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Heiner Kallweit       2025-10-17  690  	 * was provided to the MAC, use the one probed here.
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  691  	 */
d56631a66c0d0c drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Srinivas Kandagatla   2012-08-30  692  	if (priv->plat->phy_addr == -1)
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  693  		priv->plat->phy_addr = addr;
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  694  
fbca164776e438 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Romain Perier         2017-08-10  695  	phy_attached_info(phydev);
4751d2aa321f28 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Vladimir Oltean       2021-05-27  696  
cc2fa619a738a0 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Phil Reid             2016-03-15  697  bus_register_done:
3955b22b9798ae drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Giuseppe CAVALLARO    2013-02-06  698  	priv->mii = new_bus;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  699  
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  700  	return 0;
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  701  
4751d2aa321f28 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Vladimir Oltean       2021-05-27  702  no_phy_found:
4751d2aa321f28 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c Vladimir Oltean       2021-05-27  703  	mdiobus_unregister(new_bus);
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  704  bus_register_fail:
36bcfe7d74782c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe CAVALLARO    2011-07-20  705  	mdiobus_free(new_bus);
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  706  	return err;
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  707  }
47dd7a540b8a0c drivers/net/stmmac/stmmac_mdio.c                  Giuseppe Cavallaro    2009-10-14  708  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

