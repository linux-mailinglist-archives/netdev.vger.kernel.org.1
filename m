Return-Path: <netdev+bounces-215032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13BB2CC7F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A507B37EA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C431E11F;
	Tue, 19 Aug 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZnOXbnL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DC30BF70;
	Tue, 19 Aug 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629711; cv=none; b=S0PDZysuD0f36wJp4Dlz2OJYYPBgM2lgZqhGoQisXWw61gOsKs8YLimc3Jc1ZgfZ4BmfrJgD/rik4B/VDVDmnL6C1r9tsx5bYipMtofXW9PZACjRR3ooFu0Hp6SKlkupTpWYh4QsO+vloirhI4HIdIAF+bEwJ1a7VlcMNcDrZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629711; c=relaxed/simple;
	bh=RQEfMF96SEP4R1XfTk+9ZcDy1ylx28Z2qlKwpt6Xlw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0r6ez+dU+xPqOhwIBmlXmrw/kHqZTJhkOIua3RyNdCMEvU2g3Yg/NoDrAf1rqUMofCG+kJRoZ4sXL+vRHzKVbcUzvKeJ/G3VQjJ9z+TaQVKlHKx7GIfG2eBnOcD1XXWJwQXnBqBPD/mzwzWyXLpG3LAcspaMOT6AEZKO8BfVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZnOXbnL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755629709; x=1787165709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQEfMF96SEP4R1XfTk+9ZcDy1ylx28Z2qlKwpt6Xlw8=;
  b=NZnOXbnLhs4Gt0qFP+PfmJ87djG7yK/tZvgEUYvylb0YeVlSBFlxMCnv
   wGuPL7X5llfmX6R5tWcts6+4X/G523IZMOCO6sHgSAmQ6Vf9rHzBdkqvJ
   2i1q4MONjZ8LvytHqJUQY6VWh/sBrqCHpkwb+6hGf/VjLz/EZC0y3du7z
   TP8kkDuF/0arwTB+00qlNKTqQnpblR2J9VaOYWCf+bXBi6SMpAXP8ZBG3
   v208PubJYoQwytXywkNk+ZxOyhRrPDSzv6+XxNGqYVKnXlsw42IP61CZX
   ctxgkniSNOZdVkNOLfELIjerNb2IOjC3KuNqzhhiYRLpiH2KrqscNSXKX
   g==;
X-CSE-ConnectionGUID: 0dx242REQ7OLgvG+oJ2OVA==
X-CSE-MsgGUID: YMHTYpsFQ16xSIO9ub3M9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83313090"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83313090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:55:09 -0700
X-CSE-ConnectionGUID: F5C9Nmb8Qq2s9IW34qM2Mg==
X-CSE-MsgGUID: irN8Rn32TdqNENgBbPS4xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198785907"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2025 11:55:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoRU5-000HIR-03;
	Tue, 19 Aug 2025 18:55:01 +0000
Date: Wed, 20 Aug 2025 02:54:39 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <202508200254.WPms5O1T-lkp@intel.com>
References: <56f6b06e22b3b6dbfb45ef04a43bac13a8cb02e5.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f6b06e22b3b6dbfb45ef04a43bac13a8cb02e5.1755564606.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-dsa-lantiq_gswip-deduplicate-dsa_switch_ops/20250819-094007
base:   net-next/main
patch link:    https://lore.kernel.org/r/56f6b06e22b3b6dbfb45ef04a43bac13a8cb02e5.1755564606.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v2 7/8] net: dsa: lantiq_gswip: store switch API version in priv
config: m68k-randconfig-r113-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200254.WPms5O1T-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250820/202508200254.WPms5O1T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200254.WPms5O1T-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/lantiq_gswip.c:1940:25: sparse: sparse: cast to restricted __le16
>> drivers/net/dsa/lantiq_gswip.c:1940:25: sparse: sparse: cast to restricted __le16
>> drivers/net/dsa/lantiq_gswip.c:1940:25: sparse: sparse: cast to restricted __le16
>> drivers/net/dsa/lantiq_gswip.c:1940:25: sparse: sparse: cast to restricted __le16

vim +1940 drivers/net/dsa/lantiq_gswip.c

  1869	
  1870	static int gswip_probe(struct platform_device *pdev)
  1871	{
  1872		struct device_node *np, *gphy_fw_np;
  1873		struct device *dev = &pdev->dev;
  1874		struct gswip_priv *priv;
  1875		int err;
  1876		int i;
  1877		u32 version;
  1878	
  1879		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
  1880		if (!priv)
  1881			return -ENOMEM;
  1882	
  1883		priv->gswip = devm_platform_ioremap_resource(pdev, 0);
  1884		if (IS_ERR(priv->gswip))
  1885			return PTR_ERR(priv->gswip);
  1886	
  1887		priv->mdio = devm_platform_ioremap_resource(pdev, 1);
  1888		if (IS_ERR(priv->mdio))
  1889			return PTR_ERR(priv->mdio);
  1890	
  1891		priv->mii = devm_platform_ioremap_resource(pdev, 2);
  1892		if (IS_ERR(priv->mii))
  1893			return PTR_ERR(priv->mii);
  1894	
  1895		priv->hw_info = of_device_get_match_data(dev);
  1896		if (!priv->hw_info)
  1897			return -EINVAL;
  1898	
  1899		priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
  1900		if (!priv->ds)
  1901			return -ENOMEM;
  1902	
  1903		priv->ds->dev = dev;
  1904		priv->ds->num_ports = priv->hw_info->max_ports;
  1905		priv->ds->priv = priv;
  1906		priv->ds->ops = &gswip_switch_ops;
  1907		priv->ds->phylink_mac_ops = &gswip_phylink_mac_ops;
  1908		priv->dev = dev;
  1909		mutex_init(&priv->pce_table_lock);
  1910		version = gswip_switch_r(priv, GSWIP_VERSION);
  1911	
  1912		np = dev->of_node;
  1913		switch (version) {
  1914		case GSWIP_VERSION_2_0:
  1915		case GSWIP_VERSION_2_1:
  1916			if (!of_device_is_compatible(np, "lantiq,xrx200-gswip"))
  1917				return -EINVAL;
  1918			break;
  1919		case GSWIP_VERSION_2_2:
  1920		case GSWIP_VERSION_2_2_ETC:
  1921			if (!of_device_is_compatible(np, "lantiq,xrx300-gswip") &&
  1922			    !of_device_is_compatible(np, "lantiq,xrx330-gswip"))
  1923				return -EINVAL;
  1924			break;
  1925		default:
  1926			return dev_err_probe(dev, -ENOENT,
  1927					     "unknown GSWIP version: 0x%x\n", version);
  1928		}
  1929	
  1930		/* bring up the mdio bus */
  1931		gphy_fw_np = of_get_compatible_child(dev->of_node, "lantiq,gphy-fw");
  1932		if (gphy_fw_np) {
  1933			err = gswip_gphy_fw_list(priv, gphy_fw_np, version);
  1934			of_node_put(gphy_fw_np);
  1935			if (err)
  1936				return dev_err_probe(dev, err,
  1937						     "gphy fw probe failed\n");
  1938		}
  1939	
> 1940		priv->version = le16_to_cpu(version);
  1941	
  1942		/* bring up the mdio bus */
  1943		err = gswip_mdio(priv);
  1944		if (err) {
  1945			dev_err_probe(dev, err, "mdio probe failed\n");
  1946			goto gphy_fw_remove;
  1947		}
  1948	
  1949		err = dsa_register_switch(priv->ds);
  1950		if (err) {
  1951			dev_err_probe(dev, err, "dsa switch registration failed\n");
  1952			goto gphy_fw_remove;
  1953		}
  1954	
  1955		err = gswip_validate_cpu_port(priv->ds);
  1956		if (err)
  1957			goto disable_switch;
  1958	
  1959		platform_set_drvdata(pdev, priv);
  1960	
  1961		dev_info(dev, "probed GSWIP version %lx mod %lx\n",
  1962			 (version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
  1963			 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
  1964		return 0;
  1965	
  1966	disable_switch:
  1967		gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
  1968		dsa_unregister_switch(priv->ds);
  1969	gphy_fw_remove:
  1970		for (i = 0; i < priv->num_gphy_fw; i++)
  1971			gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
  1972		return err;
  1973	}
  1974	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

