Return-Path: <netdev+bounces-102632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F03BF904043
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C9A1F25C42
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836136AF5;
	Tue, 11 Jun 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXNeoU94"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD339855
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120510; cv=none; b=oSoq4auvbd6SGE1uqmtn/OWJhhI1AVatobu8H+AUFbwtPffTXBlG94M2eXWr3xd08Vn5/itu1sQjEn3j5Cfgpxy+uAhOqyq/eLmR/c2qIdWOJwwhwBbgugN45JUh+l5RcZSWSml1W+GhPI78mPQW76bDfNyoubIrrQ2ma60det4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120510; c=relaxed/simple;
	bh=PrYl6WfR6LkOY2fQoaq0gQJfswA9QahjBPXIdVXgxBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEm6tiznyFcPaSM1oPTz6PTxPuzHHwyIL9AwXtgKXf5g4oDRktHboUYXNHtM7ZOWkloB4DrviFOToQQlZs9KkrDBBCWoxKQgdAs6GQ0WLSdMAqNO2LbHqrKF5UzTVgvc623zhrIxibZqB3evfEJJQ2cH1QgEmllW3r1aRoPvupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXNeoU94; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718120508; x=1749656508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrYl6WfR6LkOY2fQoaq0gQJfswA9QahjBPXIdVXgxBE=;
  b=GXNeoU94tSrypVx3hPLHZbemDRxFBvnhklsQoL7wyysOtiTYXHaAVjYD
   0SXFnBv58pU9Wf3SBudPfUBMXlEl5OL+LNoXTfe3FnkSYyh0saS5ZQn3o
   CntjQ0IZknRzbVtnMB7QsRPObTnU8IlRCj36ayIxsMwZzo1znWkTX0OzR
   riQZmEmp3dQEqHFAoDDLWiFSY0OURvQ+m4Xl//UoPHsUWuz1U0fFCyWYV
   /rh8l5T6qItL5L+eLl2m/Fv8rIivtlTbZkPGSA6I6OY6svmjoR4TYNrkV
   QTyfz5UFSzTrBiqSn/zxL2fN9UJIHQ8+1rBQCFce2wrrbtUFCUIrkk9lB
   g==;
X-CSE-ConnectionGUID: 1R6gsRfwTPCFIUTrQkCUwA==
X-CSE-MsgGUID: m3HCn+pGROGs4WlbvWfW7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37360091"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="37360091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:41:48 -0700
X-CSE-ConnectionGUID: aN6ujXOeRo63F0xoKD2QAg==
X-CSE-MsgGUID: N+LWo2yhRTGpfC+TMIg9QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="70658318"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jun 2024 08:41:44 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH3d0-0000bi-1M;
	Tue, 11 Jun 2024 15:41:42 +0000
Date: Tue, 11 Jun 2024 23:41:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a
 select_pcs() implementation
Message-ID: <202406112331.DvtIlhjT-lkp@intel.com>
References: <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-add-select_pcs-platform-method/20240611-024301
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1sGgCN-00Fact-0x%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a select_pcs() implementation
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20240611/202406112331.DvtIlhjT-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406112331.DvtIlhjT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406112331.DvtIlhjT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c: In function 'intel_mgbe_common_data':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:601:9: error: expected expression before '}' token
     601 |         }
         |         ^


vim +601 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c

178a34a9b7ccb3 Russell King (Oracle       2024-06-10  455) 
58da0cfa6cf120 Voon Weifeng               2020-03-31  456  static int intel_mgbe_common_data(struct pci_dev *pdev,
58da0cfa6cf120 Voon Weifeng               2020-03-31  457  				  struct plat_stmmacenet_data *plat)
58da0cfa6cf120 Voon Weifeng               2020-03-31  458  {
72edaf39fc6511 Ong Boon Leong             2022-06-15  459  	struct fwnode_handle *fwnode;
8eb37ab7cc045e Wong Vee Khee              2021-03-05  460  	char clk_name[20];
09f012e64e4b81 Andy Shevchenko            2020-04-30  461  	int ret;
58da0cfa6cf120 Voon Weifeng               2020-03-31  462  	int i;
58da0cfa6cf120 Voon Weifeng               2020-03-31  463  
20e07e2c3cf310 Wong Vee Khee              2021-02-17  464  	plat->pdev = pdev;
bff6f1db91e330 Voon Weifeng               2020-11-06  465  	plat->phy_addr = -1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  466  	plat->clk_csr = 5;
58da0cfa6cf120 Voon Weifeng               2020-03-31  467  	plat->has_gmac = 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  468  	plat->has_gmac4 = 1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  469  	plat->force_sf_dma_mode = 0;
68861a3bcc1caf Bartosz Golaszewski        2023-07-10  470  	plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
58da0cfa6cf120 Voon Weifeng               2020-03-31  471  
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  472  	/* Multiplying factor to the clk_eee_i clock time
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  473  	 * period to make it closer to 100 ns. This value
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  474  	 * should be programmed such that the clk_eee_time_period *
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  475  	 * (MULT_FACT_100NS + 1) should be within 80 ns to 120 ns
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  476  	 * clk_eee frequency is 19.2Mhz
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  477  	 * clk_eee_time_period is 52ns
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  478  	 * 52ns * (1 + 1) = 104ns
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  479  	 * MULT_FACT_100NS = 1
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  480  	 */
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  481  	plat->mult_fact_100ns = 1;
e80fe71b3ffe1e Michael Sit Wei Hong       2021-05-17  482  
58da0cfa6cf120 Voon Weifeng               2020-03-31  483  	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
58da0cfa6cf120 Voon Weifeng               2020-03-31  484  
58da0cfa6cf120 Voon Weifeng               2020-03-31  485  	for (i = 0; i < plat->rx_queues_to_use; i++) {
58da0cfa6cf120 Voon Weifeng               2020-03-31  486  		plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
58da0cfa6cf120 Voon Weifeng               2020-03-31  487  		plat->rx_queues_cfg[i].chan = i;
58da0cfa6cf120 Voon Weifeng               2020-03-31  488  
58da0cfa6cf120 Voon Weifeng               2020-03-31  489  		/* Disable Priority config by default */
58da0cfa6cf120 Voon Weifeng               2020-03-31  490  		plat->rx_queues_cfg[i].use_prio = false;
58da0cfa6cf120 Voon Weifeng               2020-03-31  491  
58da0cfa6cf120 Voon Weifeng               2020-03-31  492  		/* Disable RX queues routing by default */
58da0cfa6cf120 Voon Weifeng               2020-03-31  493  		plat->rx_queues_cfg[i].pkt_route = 0x0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  494  	}
58da0cfa6cf120 Voon Weifeng               2020-03-31  495  
58da0cfa6cf120 Voon Weifeng               2020-03-31  496  	for (i = 0; i < plat->tx_queues_to_use; i++) {
58da0cfa6cf120 Voon Weifeng               2020-03-31  497  		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
58da0cfa6cf120 Voon Weifeng               2020-03-31  498  
58da0cfa6cf120 Voon Weifeng               2020-03-31  499  		/* Disable Priority config by default */
58da0cfa6cf120 Voon Weifeng               2020-03-31  500  		plat->tx_queues_cfg[i].use_prio = false;
17cb00704c217d Ong Boon Leong             2021-04-21  501  		/* Default TX Q0 to use TSO and rest TXQ for TBS */
17cb00704c217d Ong Boon Leong             2021-04-21  502  		if (i > 0)
17cb00704c217d Ong Boon Leong             2021-04-21  503  			plat->tx_queues_cfg[i].tbs_en = 1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  504  	}
58da0cfa6cf120 Voon Weifeng               2020-03-31  505  
58da0cfa6cf120 Voon Weifeng               2020-03-31  506  	/* FIFO size is 4096 bytes for 1 tx/rx queue */
58da0cfa6cf120 Voon Weifeng               2020-03-31  507  	plat->tx_fifo_size = plat->tx_queues_to_use * 4096;
58da0cfa6cf120 Voon Weifeng               2020-03-31  508  	plat->rx_fifo_size = plat->rx_queues_to_use * 4096;
58da0cfa6cf120 Voon Weifeng               2020-03-31  509  
58da0cfa6cf120 Voon Weifeng               2020-03-31  510  	plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
58da0cfa6cf120 Voon Weifeng               2020-03-31  511  	plat->tx_queues_cfg[0].weight = 0x09;
58da0cfa6cf120 Voon Weifeng               2020-03-31  512  	plat->tx_queues_cfg[1].weight = 0x0A;
58da0cfa6cf120 Voon Weifeng               2020-03-31  513  	plat->tx_queues_cfg[2].weight = 0x0B;
58da0cfa6cf120 Voon Weifeng               2020-03-31  514  	plat->tx_queues_cfg[3].weight = 0x0C;
58da0cfa6cf120 Voon Weifeng               2020-03-31  515  	plat->tx_queues_cfg[4].weight = 0x0D;
58da0cfa6cf120 Voon Weifeng               2020-03-31  516  	plat->tx_queues_cfg[5].weight = 0x0E;
58da0cfa6cf120 Voon Weifeng               2020-03-31  517  	plat->tx_queues_cfg[6].weight = 0x0F;
58da0cfa6cf120 Voon Weifeng               2020-03-31  518  	plat->tx_queues_cfg[7].weight = 0x10;
58da0cfa6cf120 Voon Weifeng               2020-03-31  519  
58da0cfa6cf120 Voon Weifeng               2020-03-31  520  	plat->dma_cfg->pbl = 32;
58da0cfa6cf120 Voon Weifeng               2020-03-31  521  	plat->dma_cfg->pblx8 = true;
58da0cfa6cf120 Voon Weifeng               2020-03-31  522  	plat->dma_cfg->fixed_burst = 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  523  	plat->dma_cfg->mixed_burst = 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  524  	plat->dma_cfg->aal = 0;
676b7ec67d79ae Mohammad Athari Bin Ismail 2021-04-22  525  	plat->dma_cfg->dche = true;
58da0cfa6cf120 Voon Weifeng               2020-03-31  526  
58da0cfa6cf120 Voon Weifeng               2020-03-31  527  	plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
58da0cfa6cf120 Voon Weifeng               2020-03-31  528  				 GFP_KERNEL);
58da0cfa6cf120 Voon Weifeng               2020-03-31  529  	if (!plat->axi)
58da0cfa6cf120 Voon Weifeng               2020-03-31  530  		return -ENOMEM;
58da0cfa6cf120 Voon Weifeng               2020-03-31  531  
58da0cfa6cf120 Voon Weifeng               2020-03-31  532  	plat->axi->axi_lpi_en = 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  533  	plat->axi->axi_xit_frm = 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  534  	plat->axi->axi_wr_osr_lmt = 1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  535  	plat->axi->axi_rd_osr_lmt = 1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  536  	plat->axi->axi_blen[0] = 4;
58da0cfa6cf120 Voon Weifeng               2020-03-31  537  	plat->axi->axi_blen[1] = 8;
58da0cfa6cf120 Voon Weifeng               2020-03-31  538  	plat->axi->axi_blen[2] = 16;
58da0cfa6cf120 Voon Weifeng               2020-03-31  539  
58da0cfa6cf120 Voon Weifeng               2020-03-31  540  	plat->ptp_max_adj = plat->clk_ptp_rate;
b4c5f83ae3f3e2 Rusaimi Amira Ruslan       2020-09-28  541  	plat->eee_usecs_rate = plat->clk_ptp_rate;
58da0cfa6cf120 Voon Weifeng               2020-03-31  542  
58da0cfa6cf120 Voon Weifeng               2020-03-31  543  	/* Set system clock */
8eb37ab7cc045e Wong Vee Khee              2021-03-05  544  	sprintf(clk_name, "%s-%s", "stmmac", pci_name(pdev));
8eb37ab7cc045e Wong Vee Khee              2021-03-05  545  
58da0cfa6cf120 Voon Weifeng               2020-03-31  546  	plat->stmmac_clk = clk_register_fixed_rate(&pdev->dev,
8eb37ab7cc045e Wong Vee Khee              2021-03-05  547  						   clk_name, NULL, 0,
58da0cfa6cf120 Voon Weifeng               2020-03-31  548  						   plat->clk_ptp_rate);
58da0cfa6cf120 Voon Weifeng               2020-03-31  549  
58da0cfa6cf120 Voon Weifeng               2020-03-31  550  	if (IS_ERR(plat->stmmac_clk)) {
58da0cfa6cf120 Voon Weifeng               2020-03-31  551  		dev_warn(&pdev->dev, "Fail to register stmmac-clk\n");
58da0cfa6cf120 Voon Weifeng               2020-03-31  552  		plat->stmmac_clk = NULL;
58da0cfa6cf120 Voon Weifeng               2020-03-31  553  	}
09f012e64e4b81 Andy Shevchenko            2020-04-30  554  
09f012e64e4b81 Andy Shevchenko            2020-04-30  555  	ret = clk_prepare_enable(plat->stmmac_clk);
09f012e64e4b81 Andy Shevchenko            2020-04-30  556  	if (ret) {
09f012e64e4b81 Andy Shevchenko            2020-04-30  557  		clk_unregister_fixed_rate(plat->stmmac_clk);
09f012e64e4b81 Andy Shevchenko            2020-04-30  558  		return ret;
09f012e64e4b81 Andy Shevchenko            2020-04-30  559  	}
58da0cfa6cf120 Voon Weifeng               2020-03-31  560  
76da35dc99afb4 Wong, Vee Khee             2021-03-17  561  	plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
76da35dc99afb4 Wong, Vee Khee             2021-03-17  562  
58da0cfa6cf120 Voon Weifeng               2020-03-31  563  	/* Set default value for multicast hash bins */
58da0cfa6cf120 Voon Weifeng               2020-03-31  564  	plat->multicast_filter_bins = HASH_TABLE_SIZE;
58da0cfa6cf120 Voon Weifeng               2020-03-31  565  
58da0cfa6cf120 Voon Weifeng               2020-03-31  566  	/* Set default value for unicast filter entries */
58da0cfa6cf120 Voon Weifeng               2020-03-31  567  	plat->unicast_filter_entries = 1;
58da0cfa6cf120 Voon Weifeng               2020-03-31  568  
58da0cfa6cf120 Voon Weifeng               2020-03-31  569  	/* Set the maxmtu to a default of JUMBO_LEN */
58da0cfa6cf120 Voon Weifeng               2020-03-31  570  	plat->maxmtu = JUMBO_LEN;
58da0cfa6cf120 Voon Weifeng               2020-03-31  571  
fc02152bdbb28b Bartosz Golaszewski        2023-07-10  572  	plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
e0f9956a3862b3 Chuah, Kim Tatt            2020-09-25  573  
e0f9956a3862b3 Chuah, Kim Tatt            2020-09-25  574  	/* Use the last Rx queue */
e0f9956a3862b3 Chuah, Kim Tatt            2020-09-25  575  	plat->vlan_fail_q = plat->rx_queues_to_use - 1;
e0f9956a3862b3 Chuah, Kim Tatt            2020-09-25  576  
72edaf39fc6511 Ong Boon Leong             2022-06-15  577  	/* For fixed-link setup, we allow phy-mode setting */
72edaf39fc6511 Ong Boon Leong             2022-06-15  578  	fwnode = dev_fwnode(&pdev->dev);
72edaf39fc6511 Ong Boon Leong             2022-06-15  579  	if (fwnode) {
72edaf39fc6511 Ong Boon Leong             2022-06-15  580  		int phy_mode;
72edaf39fc6511 Ong Boon Leong             2022-06-15  581  
72edaf39fc6511 Ong Boon Leong             2022-06-15  582  		/* "phy-mode" setting is optional. If it is set,
72edaf39fc6511 Ong Boon Leong             2022-06-15  583  		 *  we allow either sgmii or 1000base-x for now.
72edaf39fc6511 Ong Boon Leong             2022-06-15  584  		 */
72edaf39fc6511 Ong Boon Leong             2022-06-15  585  		phy_mode = fwnode_get_phy_mode(fwnode);
72edaf39fc6511 Ong Boon Leong             2022-06-15  586  		if (phy_mode >= 0) {
72edaf39fc6511 Ong Boon Leong             2022-06-15  587  			if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
72edaf39fc6511 Ong Boon Leong             2022-06-15  588  			    phy_mode == PHY_INTERFACE_MODE_1000BASEX)
72edaf39fc6511 Ong Boon Leong             2022-06-15  589  				plat->phy_interface = phy_mode;
72edaf39fc6511 Ong Boon Leong             2022-06-15  590  			else
72edaf39fc6511 Ong Boon Leong             2022-06-15  591  				dev_warn(&pdev->dev, "Invalid phy-mode\n");
72edaf39fc6511 Ong Boon Leong             2022-06-15  592  		}
72edaf39fc6511 Ong Boon Leong             2022-06-15  593  	}
72edaf39fc6511 Ong Boon Leong             2022-06-15  594  
7310fe538ea5c9 Ong Boon Leong             2021-03-15  595  	/* Intel mgbe SGMII interface uses pcs-xcps */
c82386310d9572 Ong Boon Leong             2022-06-15  596  	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
c82386310d9572 Ong Boon Leong             2022-06-15  597  	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
7310fe538ea5c9 Ong Boon Leong             2021-03-15  598  		plat->mdio_bus_data->has_xpcs = true;
83f55b01dd9030 Russell King (Oracle       2024-05-29  599) 		plat->mdio_bus_data->default_an_inband = true;
178a34a9b7ccb3 Russell King (Oracle       2024-06-10  600) 		plat->select_pcs = intel_mgbe_select_pcs,
7310fe538ea5c9 Ong Boon Leong             2021-03-15 @601  	}
7310fe538ea5c9 Ong Boon Leong             2021-03-15  602  
7310fe538ea5c9 Ong Boon Leong             2021-03-15  603  	/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
7310fe538ea5c9 Ong Boon Leong             2021-03-15  604  	plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
7310fe538ea5c9 Ong Boon Leong             2021-03-15  605  	plat->mdio_bus_data->phy_mask |= 1 << INTEL_MGBE_XPCS_ADDR;
7310fe538ea5c9 Ong Boon Leong             2021-03-15  606  
341f67e424e572 Tan Tee Min                2021-03-23  607  	plat->int_snapshot_num = AUX_SNAPSHOT1;
341f67e424e572 Tan Tee Min                2021-03-23  608  
341f67e424e572 Tan Tee Min                2021-03-23  609  	plat->crosststamp = intel_crosststamp;
621ba7ad7891b3 Bartosz Golaszewski        2023-07-10  610  	plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
341f67e424e572 Tan Tee Min                2021-03-23  611  
b42446b9b37ba4 Ong Boon Leong             2021-03-26  612  	/* Setup MSI vector offset specific to Intel mGbE controller */
b42446b9b37ba4 Ong Boon Leong             2021-03-26  613  	plat->msi_mac_vec = 29;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  614  	plat->msi_lpi_vec = 28;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  615  	plat->msi_sfty_ce_vec = 27;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  616  	plat->msi_sfty_ue_vec = 26;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  617  	plat->msi_rx_base_vec = 0;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  618  	plat->msi_tx_base_vec = 1;
b42446b9b37ba4 Ong Boon Leong             2021-03-26  619  
58da0cfa6cf120 Voon Weifeng               2020-03-31  620  	return 0;
58da0cfa6cf120 Voon Weifeng               2020-03-31  621  }
58da0cfa6cf120 Voon Weifeng               2020-03-31  622  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

