Return-Path: <netdev+bounces-194041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B9AC7112
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB41BC7B89
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4028E583;
	Wed, 28 May 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyT4tSJj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456471D6195;
	Wed, 28 May 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457528; cv=none; b=Y7rUPktLuWo9HwbQWmceeb7p10uXNyPVQrsjQuzY1A1jQwyMCy7aug5bY6sLNn6KTRlnFnrzJNKhE0h9ZPbnGznKR7ordticKXTAlsEdHgiHw11XkrfT9VBOMYXocFEUvOhdHjfaWuzCT7iHzQCBX+8aeqI2EIMUi/AH0ND+PYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457528; c=relaxed/simple;
	bh=Vn+l1DcNxMcoVSXL76f6dSgWCLSq/i+dJade3bSRVhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWd9jma4BJU9HHehtJZNxqbdxhfWKyAv3oe5CLvzSbPb+2Xlk2dNr0/STMLm+SyB2ZhBB5kPFiYyZ/0Z53USwR145gsVAXD+AqPPAZHXhuFjWgyVfrDTRTpfcazkXWn73Y84jooNEev1QPV1iVOFzge8k1ZWo+4nRy9TUCwd+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyT4tSJj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748457526; x=1779993526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vn+l1DcNxMcoVSXL76f6dSgWCLSq/i+dJade3bSRVhs=;
  b=jyT4tSJj0aIt8vE5EiPVvgDKxG6YREuocdWUzMEzj4KIhcoAmnkdc8fs
   DhwVbnqCqhYWw6tkV6jTIbrTGshPC+NkNXTOkOY+29i0adnPx7bmBOky6
   hR05VGlZLL3nHNVt+GNXd2HcZBHetwR9fvwa4szX205PTP45zWd07w3QE
   xoikIZUISmmTcGcS/zSojb4zfCiRZMi51by8G2VS6DUoH3CyLsPvEnF7J
   Ls0Y5Z6/WCZhgk29pl/DIbITrvvRNpYs82Q6BVlzLg0PO29QHankHjssg
   8KERlIYIL26qxZv7RjItB8wBlrYNZunVlcKvrbpTiVNSHvv+ZubcHcpMy
   Q==;
X-CSE-ConnectionGUID: Smpz2bfPTJWMT+id0yuZUA==
X-CSE-MsgGUID: xdOhlDawQc600jHSWh7bMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="38124542"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="38124542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 11:38:45 -0700
X-CSE-ConnectionGUID: Wo7OZEVJQ0m05nyK9tmk7A==
X-CSE-MsgGUID: vUbiPWboRQ+rWcII18U+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143317327"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2025 11:38:38 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKLfg-000VyW-1O;
	Wed, 28 May 2025 18:38:36 +0000
Date: Thu, 29 May 2025 02:37:45 +0800
From: kernel test robot <lkp@intel.com>
To: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: Re: [PATCH v2 2/2] =?iso-8859-1?Q?ethernet?=
 =?iso-8859-1?B?OqBlc3dpbjqgQWRkoGVpYzc3MDCgZXRoZXJuZXSgZHJpdmVy?=
Message-ID: <202505290202.daQ8Q8Xq-lkp@intel.com>
References: <20250528041634.912-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528041634.912-1-weishangjuan@eswincomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.15 next-20250528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/weishangjuan-eswincomputing-com/dt-bindings-ethernet-eswin-Document-for-EIC7700-SoC/20250528-121947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250528041634.912-1-weishangjuan%40eswincomputing.com
patch subject: [PATCH v2 2/2] ethernet: eswin: Add eic7700 ethernet driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250529/202505290202.daQ8Q8Xq-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290202.daQ8Q8Xq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290202.daQ8Q8Xq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:210:6: warning: unused variable 'err' [-Wunused-variable]
     210 |         int err;
         |             ^~~
>> drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:369:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     369 |         if (data->probe)
         |             ^~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:371:6: note: uninitialized use occurs here
     371 |         if (ret < 0) {
         |             ^~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:369:2: note: remove the 'if' if its condition is always true
     369 |         if (data->probe)
         |         ^~~~~~~~~~~~~~~~
     370 |                 ret = data->probe(pdev, plat_dat, &stmmac_res);
   drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:343:9: note: initialize the variable 'ret' to silence this warning
     343 |         int ret;
         |                ^
         |                 = 0
   drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c:153:12: warning: unused function 'dwc_qos_probe' [-Wunused-function]
     153 | static int dwc_qos_probe(struct platform_device *pdev,
         |            ^~~~~~~~~~~~~
   3 warnings generated.


vim +/err +210 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

   196	
   197	static int eswin_qos_probe(struct platform_device *pdev,
   198				   struct plat_stmmacenet_data *plat_dat,
   199				   struct stmmac_resources *stmmac_res)
   200	{
   201		struct eswin_qos_priv *dwc_priv;
   202		u32 hsp_aclk_ctrl_offset;
   203		u32 hsp_aclk_ctrl_regset;
   204		u32 hsp_cfg_ctrl_offset;
   205		u32 eth_axi_lp_ctrl_offset;
   206		u32 eth_phy_ctrl_offset;
   207		u32 eth_phy_ctrl_regset;
   208		struct clk *clk_app;
   209		int ret;
 > 210		int err;
   211	
   212		dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
   213		if (!dwc_priv)
   214			return -ENOMEM;
   215	
   216		if (device_property_read_u32(&pdev->dev, "id", &dwc_priv->dev_id))
   217			return dev_err_probe(&pdev->dev, -EINVAL,
   218					"Can not read device id!\n");
   219	
   220		dwc_priv->dev = &pdev->dev;
   221	
   222		ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,phyaddr", 0,
   223						 &dwc_priv->phyaddr);
   224		if (ret)
   225			dev_warn(&pdev->dev, "can't get phyaddr (%d)\n", ret);
   226	
   227		ret = of_property_read_variable_u32_array(pdev->dev.of_node, "eswin,dly_hsp_reg",
   228							  &dwc_priv->dly_hsp_reg[0], 3, 0);
   229		if (ret != 3) {
   230			dev_err(&pdev->dev, "can't get delay hsp reg.ret(%d)\n", ret);
   231			return ret;
   232		}
   233	
   234		ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-1000m",
   235							  &dwc_priv->dly_param_1000m[0], 3, 0);
   236		if (ret != 3) {
   237			dev_err(&pdev->dev, "can't get delay param for 1Gbps mode (%d)\n", ret);
   238			return ret;
   239		}
   240	
   241		ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-100m",
   242							  &dwc_priv->dly_param_100m[0], 3, 0);
   243		if (ret != 3) {
   244			dev_err(&pdev->dev, "can't get delay param for 100Mbps mode (%d)\n", ret);
   245			return ret;
   246		}
   247	
   248		ret = of_property_read_variable_u32_array(pdev->dev.of_node, "dly-param-10m",
   249							  &dwc_priv->dly_param_10m[0], 3, 0);
   250		if (ret != 3) {
   251			dev_err(&pdev->dev, "can't get delay param for 10Mbps mode (%d)\n", ret);
   252			return ret;
   253		}
   254	
   255		dwc_priv->crg_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
   256								       "eswin,syscrg_csr");
   257		if (IS_ERR(dwc_priv->crg_regmap)) {
   258			dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
   259			return 0;
   260		}
   261	
   262		ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 1,
   263						 &hsp_aclk_ctrl_offset);
   264		if (ret)
   265			return dev_err_probe(&pdev->dev, ret, "can't get syscrg_csr 1\n");
   266	
   267		regmap_read(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, &hsp_aclk_ctrl_regset);
   268		hsp_aclk_ctrl_regset |= (HSP_ACLK_CLKEN | HSP_ACLK_DIVSOR);
   269		regmap_write(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, hsp_aclk_ctrl_regset);
   270	
   271		ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 2,
   272						 &hsp_cfg_ctrl_offset);
   273		if (ret)
   274			return dev_err_probe(&pdev->dev, ret, "can't get syscrg_csr 2\n");
   275	
   276		regmap_write(dwc_priv->crg_regmap, hsp_cfg_ctrl_offset, HSP_CFG_CTRL_REGSET);
   277	
   278		dwc_priv->hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
   279								       "eswin,hsp_sp_csr");
   280		if (IS_ERR(dwc_priv->hsp_regmap)) {
   281			dev_dbg(&pdev->dev, "No hsp_sp_csr phandle specified\n");
   282			return 0;
   283		}
   284	
   285		ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 2,
   286						 &eth_phy_ctrl_offset);
   287		if (ret)
   288			return dev_err_probe(&pdev->dev, ret, "can't get hsp_sp_csr 2\n");
   289	
   290		regmap_read(dwc_priv->hsp_regmap,
   291			    eth_phy_ctrl_offset,
   292			    &eth_phy_ctrl_regset);
   293		eth_phy_ctrl_regset |= (ETH_TX_CLK_SEL | ETH_PHY_INTF_SELI);
   294		regmap_write(dwc_priv->hsp_regmap,
   295			     eth_phy_ctrl_offset,
   296			     eth_phy_ctrl_regset);
   297	
   298		ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 3,
   299						 &eth_axi_lp_ctrl_offset);
   300		if (ret)
   301			return dev_err_probe(&pdev->dev, ret,
   302					"can't get hsp_sp_csr 3\n");
   303	
   304		regmap_write(dwc_priv->hsp_regmap,
   305			     eth_axi_lp_ctrl_offset,
   306			     ETH_CSYSREQ_VAL);
   307	
   308		clk_app = devm_clk_get_enabled(&pdev->dev, "app");
   309		if (IS_ERR(clk_app))
   310			return dev_err_probe(&pdev->dev, PTR_ERR(clk_app),
   311					"error getting app clock\n");
   312	
   313		plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
   314		if (IS_ERR(plat_dat->clk_tx_i))
   315			return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
   316					"error getting tx clock\n");
   317	
   318		plat_dat->fix_mac_speed = eswin_qos_fix_speed;
   319		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
   320		plat_dat->bsp_priv = dwc_priv;
   321		plat_dat->phy_addr = PHY_ADDR;
   322	
   323		return 0;
   324	}
   325	
   326	struct dwc_eth_dwmac_data {
   327		int (*probe)(struct platform_device *pdev,
   328			     struct plat_stmmacenet_data *plat_dat,
   329			     struct stmmac_resources *res);
   330		const char *stmmac_clk_name;
   331	};
   332	
   333	static const struct dwc_eth_dwmac_data eswin_qos_data = {
   334		.probe = eswin_qos_probe,
   335		.stmmac_clk_name = "stmmaceth",
   336	};
   337	
   338	static int dwc_eth_dwmac_probe(struct platform_device *pdev)
   339	{
   340		const struct dwc_eth_dwmac_data *data;
   341		struct plat_stmmacenet_data *plat_dat;
   342		struct stmmac_resources stmmac_res;
   343		int ret;
   344	
   345		data = device_get_match_data(&pdev->dev);
   346	
   347		memset(&stmmac_res, 0, sizeof(struct stmmac_resources));
   348	
   349		/**
   350		 * Since stmmac_platform supports name IRQ only, basic platform
   351		 * resource initialization is done in the glue logic.
   352		 */
   353		stmmac_res.irq = platform_get_irq(pdev, 0);
   354		if (stmmac_res.irq < 0)
   355			return stmmac_res.irq;
   356		stmmac_res.wol_irq = stmmac_res.irq;
   357	
   358		stmmac_res.addr = devm_platform_ioremap_resource(pdev, 0);
   359		if (IS_ERR(stmmac_res.addr))
   360			return PTR_ERR(stmmac_res.addr);
   361	
   362		plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
   363		if (IS_ERR(plat_dat))
   364			return PTR_ERR(plat_dat);
   365	
   366		plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
   367							data->stmmac_clk_name);
   368	
 > 369		if (data->probe)
   370			ret = data->probe(pdev, plat_dat, &stmmac_res);
   371		if (ret < 0) {
   372			return dev_err_probe(&pdev->dev, ret,
   373					"failed to probe subdriver\n");
   374		}
   375	
   376		ret = dwc_eth_dwmac_config_dt(pdev, plat_dat);
   377		if (ret)
   378			return dev_err_probe(&pdev->dev, ret,
   379					"Failed to config dt\n");
   380	
   381		ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
   382		if (ret)
   383			return dev_err_probe(&pdev->dev, ret,
   384					"Failed to driver probe\n");
   385	
   386		return ret;
   387	}
   388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

