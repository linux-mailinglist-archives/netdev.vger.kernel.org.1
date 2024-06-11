Return-Path: <netdev+bounces-102535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6E9039B4
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D4F281BCB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FE179970;
	Tue, 11 Jun 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sakq/FE1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1060179957
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104222; cv=none; b=cEcms1BieuAk0c/a8+PNiEVi8ht5ao8qIxkSAYsRJ3hQbLkv3kopDtn+1VDRKOntox6scBX7Xp/m0dHBlP1GAZALaqTJwITeGXnXx6zV5PBDjvAoVQ4LYe/B/gsdo4ObLiLXNppexd0P6PU5y0bNHziHwn9UWypTWgU/1y68E7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104222; c=relaxed/simple;
	bh=PujIJcgVmAL6tRyDjsLUnk7KbBQJmZ2zRZrUMPPtu74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRutc9uc3XKMHZn818vvY2ouameCsKhA6Xd3KHTCK8OQB/5Ot730JOLEkubcz00FoLYmwRTlMnCL0GB0SsC77GeGBo/yGIrle+p1OggmvyKAYf8jAJ71m/lG/kEFRff2t5kfNyoS0oHPB/aGVSqqSVyr0MkcMe4xR91Ordk2qJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sakq/FE1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718104221; x=1749640221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PujIJcgVmAL6tRyDjsLUnk7KbBQJmZ2zRZrUMPPtu74=;
  b=Sakq/FE13vJoAI85rXrznjMt6En5GBwlm8HwHLxQnMjb6cPkyQNIQ+Dl
   wxr9vcPmeVFZ7qQiJHNOjMwPqnPZCO89qwYRcIL86jMRd/fLGjnG+0YOE
   qw+gJ0DV3U8zkgtyMMQ7h7hX8L+fspfDtQDBEHOSahhEf87aL88hgtfO5
   aAW8XsJY2+jpC3pTCEkU+XtjohcH8LYhDf1mwgXU938nMg3FIvibn1ctS
   vGKIFzNohz4FH++NHt4Znd5gDujqFrbR24PBlU2uZa+gPbmWGlQf2m9Z8
   KlwElUxpg4rNADw+NRiNLlBECuimz9HpgC1ouRN4YVAiGpWNI74n6wkb4
   g==;
X-CSE-ConnectionGUID: rG3xCPw+Qw6qvs98SyaN3g==
X-CSE-MsgGUID: mDhUXGo9TsSKEH8NHCd+KA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18636742"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="18636742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 04:10:20 -0700
X-CSE-ConnectionGUID: wCB1n7uOSKOwcZT+X524rw==
X-CSE-MsgGUID: upC214k9Trejmen9uDz3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="76868190"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 04:10:17 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGzOI-0000LK-10;
	Tue, 11 Jun 2024 11:10:14 +0000
Date: Tue, 11 Jun 2024 19:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202406111944.wTZ4iEdx-lkp@intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-dwmac-intel-provide-a-select_pcs-implementation/20240610-224406
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1sGgCN-00Fact-0x%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a select_pcs() implementation
config: x86_64-randconfig-013-20240611 (https://download.01.org/0day-ci/archive/20240611/202406111944.wTZ4iEdx-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111944.wTZ4iEdx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111944.wTZ4iEdx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:600:43: error: expected ';' after expression
     600 |                 plat->select_pcs = intel_mgbe_select_pcs,
         |                                                         ^
         |                                                         ;
   1 error generated.


vim +600 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c

   455	
   456	static int intel_mgbe_common_data(struct pci_dev *pdev,
   457					  struct plat_stmmacenet_data *plat)
   458	{
   459		struct fwnode_handle *fwnode;
   460		char clk_name[20];
   461		int ret;
   462		int i;
   463	
   464		plat->pdev = pdev;
   465		plat->phy_addr = -1;
   466		plat->clk_csr = 5;
   467		plat->has_gmac = 0;
   468		plat->has_gmac4 = 1;
   469		plat->force_sf_dma_mode = 0;
   470		plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
   471	
   472		/* Multiplying factor to the clk_eee_i clock time
   473		 * period to make it closer to 100 ns. This value
   474		 * should be programmed such that the clk_eee_time_period *
   475		 * (MULT_FACT_100NS + 1) should be within 80 ns to 120 ns
   476		 * clk_eee frequency is 19.2Mhz
   477		 * clk_eee_time_period is 52ns
   478		 * 52ns * (1 + 1) = 104ns
   479		 * MULT_FACT_100NS = 1
   480		 */
   481		plat->mult_fact_100ns = 1;
   482	
   483		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
   484	
   485		for (i = 0; i < plat->rx_queues_to_use; i++) {
   486			plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   487			plat->rx_queues_cfg[i].chan = i;
   488	
   489			/* Disable Priority config by default */
   490			plat->rx_queues_cfg[i].use_prio = false;
   491	
   492			/* Disable RX queues routing by default */
   493			plat->rx_queues_cfg[i].pkt_route = 0x0;
   494		}
   495	
   496		for (i = 0; i < plat->tx_queues_to_use; i++) {
   497			plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   498	
   499			/* Disable Priority config by default */
   500			plat->tx_queues_cfg[i].use_prio = false;
   501			/* Default TX Q0 to use TSO and rest TXQ for TBS */
   502			if (i > 0)
   503				plat->tx_queues_cfg[i].tbs_en = 1;
   504		}
   505	
   506		/* FIFO size is 4096 bytes for 1 tx/rx queue */
   507		plat->tx_fifo_size = plat->tx_queues_to_use * 4096;
   508		plat->rx_fifo_size = plat->rx_queues_to_use * 4096;
   509	
   510		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
   511		plat->tx_queues_cfg[0].weight = 0x09;
   512		plat->tx_queues_cfg[1].weight = 0x0A;
   513		plat->tx_queues_cfg[2].weight = 0x0B;
   514		plat->tx_queues_cfg[3].weight = 0x0C;
   515		plat->tx_queues_cfg[4].weight = 0x0D;
   516		plat->tx_queues_cfg[5].weight = 0x0E;
   517		plat->tx_queues_cfg[6].weight = 0x0F;
   518		plat->tx_queues_cfg[7].weight = 0x10;
   519	
   520		plat->dma_cfg->pbl = 32;
   521		plat->dma_cfg->pblx8 = true;
   522		plat->dma_cfg->fixed_burst = 0;
   523		plat->dma_cfg->mixed_burst = 0;
   524		plat->dma_cfg->aal = 0;
   525		plat->dma_cfg->dche = true;
   526	
   527		plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
   528					 GFP_KERNEL);
   529		if (!plat->axi)
   530			return -ENOMEM;
   531	
   532		plat->axi->axi_lpi_en = 0;
   533		plat->axi->axi_xit_frm = 0;
   534		plat->axi->axi_wr_osr_lmt = 1;
   535		plat->axi->axi_rd_osr_lmt = 1;
   536		plat->axi->axi_blen[0] = 4;
   537		plat->axi->axi_blen[1] = 8;
   538		plat->axi->axi_blen[2] = 16;
   539	
   540		plat->ptp_max_adj = plat->clk_ptp_rate;
   541		plat->eee_usecs_rate = plat->clk_ptp_rate;
   542	
   543		/* Set system clock */
   544		sprintf(clk_name, "%s-%s", "stmmac", pci_name(pdev));
   545	
   546		plat->stmmac_clk = clk_register_fixed_rate(&pdev->dev,
   547							   clk_name, NULL, 0,
   548							   plat->clk_ptp_rate);
   549	
   550		if (IS_ERR(plat->stmmac_clk)) {
   551			dev_warn(&pdev->dev, "Fail to register stmmac-clk\n");
   552			plat->stmmac_clk = NULL;
   553		}
   554	
   555		ret = clk_prepare_enable(plat->stmmac_clk);
   556		if (ret) {
   557			clk_unregister_fixed_rate(plat->stmmac_clk);
   558			return ret;
   559		}
   560	
   561		plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
   562	
   563		/* Set default value for multicast hash bins */
   564		plat->multicast_filter_bins = HASH_TABLE_SIZE;
   565	
   566		/* Set default value for unicast filter entries */
   567		plat->unicast_filter_entries = 1;
   568	
   569		/* Set the maxmtu to a default of JUMBO_LEN */
   570		plat->maxmtu = JUMBO_LEN;
   571	
   572		plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
   573	
   574		/* Use the last Rx queue */
   575		plat->vlan_fail_q = plat->rx_queues_to_use - 1;
   576	
   577		/* For fixed-link setup, we allow phy-mode setting */
   578		fwnode = dev_fwnode(&pdev->dev);
   579		if (fwnode) {
   580			int phy_mode;
   581	
   582			/* "phy-mode" setting is optional. If it is set,
   583			 *  we allow either sgmii or 1000base-x for now.
   584			 */
   585			phy_mode = fwnode_get_phy_mode(fwnode);
   586			if (phy_mode >= 0) {
   587				if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
   588				    phy_mode == PHY_INTERFACE_MODE_1000BASEX)
   589					plat->phy_interface = phy_mode;
   590				else
   591					dev_warn(&pdev->dev, "Invalid phy-mode\n");
   592			}
   593		}
   594	
   595		/* Intel mgbe SGMII interface uses pcs-xcps */
   596		if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
   597		    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
   598			plat->mdio_bus_data->has_xpcs = true;
   599			plat->mdio_bus_data->default_an_inband = true;
 > 600			plat->select_pcs = intel_mgbe_select_pcs,
   601		}
   602	
   603		/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
   604		plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
   605		plat->mdio_bus_data->phy_mask |= 1 << INTEL_MGBE_XPCS_ADDR;
   606	
   607		plat->int_snapshot_num = AUX_SNAPSHOT1;
   608	
   609		plat->crosststamp = intel_crosststamp;
   610		plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
   611	
   612		/* Setup MSI vector offset specific to Intel mGbE controller */
   613		plat->msi_mac_vec = 29;
   614		plat->msi_lpi_vec = 28;
   615		plat->msi_sfty_ce_vec = 27;
   616		plat->msi_sfty_ue_vec = 26;
   617		plat->msi_rx_base_vec = 0;
   618		plat->msi_tx_base_vec = 1;
   619	
   620		return 0;
   621	}
   622	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

