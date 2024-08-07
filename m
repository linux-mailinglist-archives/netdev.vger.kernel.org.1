Return-Path: <netdev+bounces-116623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3394B351
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A196283C44
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE9155333;
	Wed,  7 Aug 2024 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBn/MyOu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4F1487D5;
	Wed,  7 Aug 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071627; cv=none; b=Bj2ADlm/34919gWXTbmAEK32r69ZzuiO9fXR0eA44BXR3RGmJYVz4ZTsSBtCfoIVbajKW/FqFuJO0OxqByz8rHQpNPi3jUz3wFNXlHdVVZH9Jx4C4AjODwWogprt3dVMebXh5yP1qyP1netky2nYvYKyLKhrpjeF2pL+fNQA6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071627; c=relaxed/simple;
	bh=arnnn32Ho+GL6PFkLJOb0kBKaBfwaERy1ak7dEHN3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi2xTSSiCvi1oVxivKwKmchlroKBTKtGAFQCCJf1ikoBW6H8vjLdAJYI6lJd5JD3b7m2VoOuVFblYNZ7A4VMniVU7Z9sPTV2Wp+FeKDlfM8cFmuEHHSrryE5IdP+wpoWV8N93RPgIeEgslkhNxLIKqiqzjw2ad2ISXA/1RQOONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBn/MyOu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723071625; x=1754607625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=arnnn32Ho+GL6PFkLJOb0kBKaBfwaERy1ak7dEHN3YM=;
  b=HBn/MyOuW7s//k32B/8j741qHRF51D/mf34mK/1Ao5WQJ1VD1GH3OyeE
   9H1geUngZIPuwJ2ir2TP5NSgkFZB0MpLfhNk9JmPuzeMm7SdlcDbw957R
   yrqjHAd9ygcc05LSElq9wStWZVpCCqFX2kqhyR6CTHJBer1n6YpdMQyCf
   2jpx/xKF7hrYjhfgNob0kFBOzoOHEORMkV0o75Zqfcofo1eFRR9Bzv4mg
   wZ/+TM7E28CXy5TkWHY/rCnYw3oJfXLGzCxxx2j4JW9klmJk0XbrhHWqr
   TknmM/kgQAzq/SD2owCe5rKVcD5ZEXoaqbKVqnfvZwTuVH9yi2DB+Y6Sz
   w==;
X-CSE-ConnectionGUID: 84wAkBpUQK2VDX05HdTyPA==
X-CSE-MsgGUID: +BAE/1TKSx2YEWc56hc78Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20834981"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="20834981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:00:24 -0700
X-CSE-ConnectionGUID: j+tkh7BuTuGNrCbOXDBslg==
X-CSE-MsgGUID: yB1pGQNXSv2u7/sqCYaIZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87674909"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Aug 2024 16:00:22 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbpdi-0005mO-2i;
	Wed, 07 Aug 2024 23:00:18 +0000
Date: Thu, 8 Aug 2024 07:00:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
Message-ID: <202408080631.rKnoa41D-lkp@intel.com>
References: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/net-ibm-emac-Constify-struct-mii_phy_def/20240807-195146
base:   net-next/main
patch link:    https://lore.kernel.org/r/dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240808/202408080631.rKnoa41D-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080631.rKnoa41D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080631.rKnoa41D-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ibm/emac/core.c: In function 'emac_dt_phy_connect':
>> drivers/net/ethernet/ibm/emac/core.c:2648:30: error: assignment of member 'phy_id' in read-only object
    2648 |         dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
         |                              ^
>> drivers/net/ethernet/ibm/emac/core.c:2649:35: error: assignment of member 'phy_id_mask' in read-only object
    2649 |         dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
         |                                   ^
>> drivers/net/ethernet/ibm/emac/core.c:2650:28: error: assignment of member 'name' in read-only object
    2650 |         dev->phy.def->name = dev->phy_dev->drv->name;
         |                            ^
>> drivers/net/ethernet/ibm/emac/core.c:2651:27: error: assignment of member 'ops' in read-only object
    2651 |         dev->phy.def->ops = &emac_dt_mdio_phy_ops;
         |                           ^
   drivers/net/ethernet/ibm/emac/core.c: In function 'emac_init_phy':
>> drivers/net/ethernet/ibm/emac/core.c:2818:32: error: assignment of member 'features' in read-only object
    2818 |         dev->phy.def->features &= ~dev->phy_feat_exc;
         |                                ^~


vim +/phy_id +2648 drivers/net/ethernet/ibm/emac/core.c

a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2632  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2633  static int emac_dt_phy_connect(struct emac_instance *dev,
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2634  			       struct device_node *phy_handle)
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2635  {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2636  	dev->phy.def = devm_kzalloc(&dev->ofdev->dev, sizeof(*dev->phy.def),
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2637  				    GFP_KERNEL);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2638  	if (!dev->phy.def)
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2639  		return -ENOMEM;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2640  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2641  	dev->phy_dev = of_phy_connect(dev->ndev, phy_handle, &emac_adjust_link,
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2642  				      0, dev->phy_mode);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2643  	if (!dev->phy_dev) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2644  		dev_err(&dev->ofdev->dev, "failed to connect to PHY.\n");
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2645  		return -ENODEV;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2646  	}
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2647  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20 @2648  	dev->phy.def->phy_id = dev->phy_dev->drv->phy_id;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20 @2649  	dev->phy.def->phy_id_mask = dev->phy_dev->drv->phy_id_mask;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20 @2650  	dev->phy.def->name = dev->phy_dev->drv->name;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20 @2651  	dev->phy.def->ops = &emac_dt_mdio_phy_ops;
3c1bcc8614db10 drivers/net/ethernet/ibm/emac/core.c Andrew Lunn         2018-11-10  2652  	ethtool_convert_link_mode_to_legacy_u32(&dev->phy.features,
3c1bcc8614db10 drivers/net/ethernet/ibm/emac/core.c Andrew Lunn         2018-11-10  2653  						dev->phy_dev->supported);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2654  	dev->phy.address = dev->phy_dev->mdio.addr;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2655  	dev->phy.mode = dev->phy_dev->interface;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2656  	return 0;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2657  }
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2658  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2659  static int emac_dt_phy_probe(struct emac_instance *dev)
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2660  {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2661  	struct device_node *np = dev->ofdev->dev.of_node;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2662  	struct device_node *phy_handle;
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2663  	int res = 1;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2664  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2665  	phy_handle = of_parse_phandle(np, "phy-handle", 0);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2666  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2667  	if (phy_handle) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2668  		res = emac_dt_mdio_probe(dev);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2669  		if (!res) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2670  			res = emac_dt_phy_connect(dev, phy_handle);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2671  			if (res)
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2672  				mdiobus_unregister(dev->mii_bus);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2673  		}
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2674  	}
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2675  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2676  	of_node_put(phy_handle);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2677  	return res;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2678  }
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2679  
fe17dc1e2bae85 drivers/net/ethernet/ibm/emac/core.c Bill Pemberton      2012-12-03  2680  static int emac_init_phy(struct emac_instance *dev)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2681  {
61c7a080a5a061 drivers/net/ibm_newemac/core.c       Grant Likely        2010-04-13  2682  	struct device_node *np = dev->ofdev->dev.of_node;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2683  	struct net_device *ndev = dev->ndev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2684  	u32 phy_map, adv;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2685  	int i;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2686  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2687  	dev->phy.dev = ndev;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2688  	dev->phy.mode = dev->phy_mode;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2689  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2690  	/* PHY-less configuration. */
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2691  	if ((dev->phy_address == 0xffffffff && dev->phy_map == 0xffffffff) ||
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2692  	    of_phy_is_fixed_link(np)) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2693  		emac_reset(dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2694  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2695  		/* PHY-less configuration. */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2696  		dev->phy.address = -1;
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2697  		dev->phy.features = SUPPORTED_MII;
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2698  		if (emac_phy_supports_gige(dev->phy_mode))
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2699  			dev->phy.features |= SUPPORTED_1000baseT_Full;
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2700  		else
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2701  			dev->phy.features |= SUPPORTED_100baseT_Full;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2702  		dev->phy.pause = 1;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2703  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2704  		if (of_phy_is_fixed_link(np)) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2705  			int res = emac_dt_mdio_probe(dev);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2706  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2707  			if (res)
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2708  				return res;
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2709  
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2710  			res = of_phy_register_fixed_link(np);
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2711  			dev->phy_dev = of_phy_find_device(np);
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2712  			if (res || !dev->phy_dev) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2713  				mdiobus_unregister(dev->mii_bus);
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2714  				return res ? res : -EINVAL;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2715  			}
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2716  			emac_adjust_link(dev->ndev);
08e39982ef64f8 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2018-09-17  2717  			put_device(&dev->phy_dev->mdio.dev);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2718  		}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2719  		return 0;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2720  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2721  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2722  	mutex_lock(&emac_phy_map_lock);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2723  	phy_map = dev->phy_map | busy_phy_map;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2724  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2725  	DBG(dev, "PHY maps %08x %08x" NL, dev->phy_map, busy_phy_map);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2726  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2727  	dev->phy.mdio_read = emac_mdio_read;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2728  	dev->phy.mdio_write = emac_mdio_write;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2729  
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2730  	/* Enable internal clock source */
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2731  #ifdef CONFIG_PPC_DCR_NATIVE
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2732  	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2733  		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS);
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2734  #endif
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2735  	/* PHY clock workaround */
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2736  	emac_rx_clk_tx(dev);
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2737  
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2738  	/* Enable internal clock source on 440GX*/
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2739  #ifdef CONFIG_PPC_DCR_NATIVE
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2740  	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
11121e3008a928 drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2741  		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS);
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2742  #endif
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2743  	/* Configure EMAC with defaults so we can at least use MDIO
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2744  	 * This is needed mostly for 440GX
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2745  	 */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2746  	if (emac_phy_gpcs(dev->phy.mode)) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2747  		/* XXX
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2748  		 * Make GPCS PHY address equal to EMAC index.
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2749  		 * We probably should take into account busy_phy_map
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2750  		 * and/or phy_map here.
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2751  		 *
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2752  		 * Note that the busy_phy_map is currently global
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2753  		 * while it should probably be per-ASIC...
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2754  		 */
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2755  		dev->phy.gpcs_address = dev->gpcs_address;
9e3cb29497561c drivers/net/ibm_newemac/core.c       Victor Gallardo     2008-10-01  2756  		if (dev->phy.gpcs_address == 0xffffffff)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2757  			dev->phy.address = dev->cell_index;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2758  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2759  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2760  	emac_configure(dev);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2761  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2762  	if (emac_has_feature(dev, EMAC_FTR_HAS_RGMII)) {
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2763  		int res = emac_dt_phy_probe(dev);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2764  
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2765  		switch (res) {
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2766  		case 1:
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2767  			/* No phy-handle property configured.
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2768  			 * Continue with the existing phy probe
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2769  			 * and setup code.
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2770  			 */
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2771  			break;
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2772  
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2773  		case 0:
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2774  			mutex_unlock(&emac_phy_map_lock);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2775  			goto init_phy;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2776  
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2777  		default:
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2778  			mutex_unlock(&emac_phy_map_lock);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2779  			dev_err(&dev->ofdev->dev, "failed to attach dt phy (%d).\n",
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2780  				res);
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2781  			return res;
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2782  		}
b793f081674e36 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-03-06  2783  	}
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2784  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2785  	if (dev->phy_address != 0xffffffff)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2786  		phy_map = ~(1 << dev->phy_address);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2787  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2788  	for (i = 0; i < 0x20; phy_map >>= 1, ++i)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2789  		if (!(phy_map & 1)) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2790  			int r;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2791  			busy_phy_map |= 1 << i;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2792  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2793  			/* Quick check if there is a PHY at the address */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2794  			r = emac_mdio_read(dev->ndev, i, MII_BMCR);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2795  			if (r == 0xffff || r < 0)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2796  				continue;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2797  			if (!emac_mii_phy_probe(&dev->phy, i))
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2798  				break;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2799  		}
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2800  
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2801  	/* Enable external clock source */
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2802  #ifdef CONFIG_PPC_DCR_NATIVE
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2803  	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2804  		dcri_clrset(SDR0, SDR0_MFR, SDR0_MFR_ECS, 0);
0925ab5d385b6c drivers/net/ibm_newemac/core.c       Valentine Barshak   2008-04-22  2805  #endif
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2806  	mutex_unlock(&emac_phy_map_lock);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2807  	if (i == 0x20) {
f7ce91038d5278 drivers/net/ethernet/ibm/emac/core.c Rob Herring         2017-07-18  2808  		printk(KERN_WARNING "%pOF: can't find PHY!\n", np);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2809  		return -ENXIO;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2810  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2811  
a577ca6badb526 drivers/net/ethernet/ibm/emac/core.c Christian Lamparter 2017-02-20  2812   init_phy:
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2813  	/* Init PHY */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2814  	if (dev->phy.def->ops->init)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2815  		dev->phy.def->ops->init(&dev->phy);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2816  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2817  	/* Disable any PHY features not supported by the platform */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23 @2818  	dev->phy.def->features &= ~dev->phy_feat_exc;
ae5d33723e3253 drivers/net/ethernet/ibm/emac/core.c Duc Dang            2012-03-05  2819  	dev->phy.features &= ~dev->phy_feat_exc;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2820  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2821  	/* Setup initial link parameters */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2822  	if (dev->phy.features & SUPPORTED_Autoneg) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2823  		adv = dev->phy.features;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2824  		if (!emac_has_feature(dev, EMAC_FTR_NO_FLOW_CONTROL_40x))
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2825  			adv |= ADVERTISED_Pause | ADVERTISED_Asym_Pause;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2826  		/* Restart autonegotiation */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2827  		dev->phy.def->ops->setup_aneg(&dev->phy, adv);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2828  	} else {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2829  		u32 f = dev->phy.def->features;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2830  		int speed = SPEED_10, fd = DUPLEX_HALF;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2831  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2832  		/* Select highest supported speed/duplex */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2833  		if (f & SUPPORTED_1000baseT_Full) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2834  			speed = SPEED_1000;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2835  			fd = DUPLEX_FULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2836  		} else if (f & SUPPORTED_1000baseT_Half)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2837  			speed = SPEED_1000;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2838  		else if (f & SUPPORTED_100baseT_Full) {
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2839  			speed = SPEED_100;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2840  			fd = DUPLEX_FULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2841  		} else if (f & SUPPORTED_100baseT_Half)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2842  			speed = SPEED_100;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2843  		else if (f & SUPPORTED_10baseT_Full)
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2844  			fd = DUPLEX_FULL;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2845  
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2846  		/* Force link parameters */
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2847  		dev->phy.def->ops->setup_forced(&dev->phy, speed, fd);
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2848  	}
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2849  	return 0;
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2850  }
1d3bb996481e11 drivers/net/ibm_newemac/core.c       David Gibson        2007-08-23  2851  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

