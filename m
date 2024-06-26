Return-Path: <netdev+bounces-106909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3829180AE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A071C215D7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F8181324;
	Wed, 26 Jun 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCJeEAc/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD6181317;
	Wed, 26 Jun 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403847; cv=none; b=L3hqYrpiNTnD7lV//tcKUYVM9itGtCqac5N0UDxM6bGWdZGsv+DPoghYWaQTkPYYoyw3lOdXM8S3t9Z8vOxj6GIBlakRPxeW//e7MeD90Iz/BIEds78iuqlhMyB1HYxz0AU7Demf+gRK1J3XZQEU7mo3E9mmgm/aiUWUO4yCsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403847; c=relaxed/simple;
	bh=wF+/iqAUeXCs9/WdDc4uORSkETSDRSBsRdKR8/ULxpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeGFbpJUJ9Y39hRQIY9iO/lZwmVDHhUoQEiwHtarVEFbq9XA6QgFln3i7wk9CYXlLA9c/tTHBneL8CFoHUT9MTMOLE9deOX5x2N8olesrYK0JYyLkU8y/mJfFfgkezf8M72ynl2QbOvopM8D2PF82SeVG4QaxZR5iS5TTgVEzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCJeEAc/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719403844; x=1750939844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wF+/iqAUeXCs9/WdDc4uORSkETSDRSBsRdKR8/ULxpw=;
  b=BCJeEAc/M2iZWKxDsoeESvqrMks36+iqz1DGRy96g8aSTELX2W8SRoWi
   UYDkRfGl4/VNFB5DxT7ZQL8Za2BBMLrS4S/j0PqoH2LZpy0fC4JpRJmmy
   M6SxUi9ki1PxgZV5XHUSEJGH76arBoqQYyqb7GFNeXWJ6Pm+rbkOB9NoK
   9zrGYz95a/DnB4qjD88MemhAYi7wUHzIb0oIdZiuFjyfwmfgu97F763C0
   M1qh+up0Y3oyntOym5KSTypaLSoV9yse9dXBKhmxlUBahNSILZ+O7wDYn
   la9z5L5KGll9pBSKedjaPZS/wqzbdqtzebhff225fpW9HZbViJq3Nry+K
   A==;
X-CSE-ConnectionGUID: DeEVJA/mSSih8AgAT9cSZw==
X-CSE-MsgGUID: rdNgSnTuR/KGqzRkWXSD1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20352109"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="20352109"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:10:43 -0700
X-CSE-ConnectionGUID: lJORABvuQ52G3US0yqQQYA==
X-CSE-MsgGUID: wLaF++V7Qp6J2l5O35HIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="67200665"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2024 05:10:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMRTy-000FFa-10;
	Wed, 26 Jun 2024 12:10:38 +0000
Date: Wed, 26 Jun 2024 20:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <202406261920.l5pzM1rj-lkp@intel.com>
References: <20240624162128.1665620-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624162128.1665620-1-leitao@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on soc/for-next linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/crypto-caam-Depend-on-COMPILE_TEST-also/20240625-223834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240624162128.1665620-1-leitao%40debian.org
patch subject: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240626/202406261920.l5pzM1rj-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261920.l5pzM1rj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261920.l5pzM1rj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3280:12: warning: stack frame size (16664) exceeds limit (2048) in 'dpaa_eth_probe' [-Wframe-larger-than]
    3280 | static int dpaa_eth_probe(struct platform_device *pdev)
         |            ^
   1 warning generated.
--
>> drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:454:12: warning: stack frame size (8264) exceeds limit (2048) in 'dpaa_set_coalesce' [-Wframe-larger-than]
     454 | static int dpaa_set_coalesce(struct net_device *dev,
         |            ^
   1 warning generated.


vim +/dpaa_eth_probe +3280 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c

9ad1a37493338c Madalin Bucur   2016-11-15  3279  
9ad1a37493338c Madalin Bucur   2016-11-15 @3280  static int dpaa_eth_probe(struct platform_device *pdev)
9ad1a37493338c Madalin Bucur   2016-11-15  3281  {
9ad1a37493338c Madalin Bucur   2016-11-15  3282  	struct net_device *net_dev = NULL;
f07f30042f8e0f Madalin Bucur   2019-10-31  3283  	struct dpaa_bp *dpaa_bp = NULL;
9ad1a37493338c Madalin Bucur   2016-11-15  3284  	struct dpaa_fq *dpaa_fq, *tmp;
9ad1a37493338c Madalin Bucur   2016-11-15  3285  	struct dpaa_priv *priv = NULL;
9ad1a37493338c Madalin Bucur   2016-11-15  3286  	struct fm_port_fqs port_fqs;
9ad1a37493338c Madalin Bucur   2016-11-15  3287  	struct mac_device *mac_dev;
f07f30042f8e0f Madalin Bucur   2019-10-31  3288  	int err = 0, channel;
9ad1a37493338c Madalin Bucur   2016-11-15  3289  	struct device *dev;
9ad1a37493338c Madalin Bucur   2016-11-15  3290  
060ad66f97954f Madalin Bucur   2019-10-23  3291  	dev = &pdev->dev;
060ad66f97954f Madalin Bucur   2019-10-23  3292  
5537b329857676 Laurentiu Tudor 2019-10-23  3293  	err = bman_is_probed();
5537b329857676 Laurentiu Tudor 2019-10-23  3294  	if (!err)
5537b329857676 Laurentiu Tudor 2019-10-23  3295  		return -EPROBE_DEFER;
5537b329857676 Laurentiu Tudor 2019-10-23  3296  	if (err < 0) {
060ad66f97954f Madalin Bucur   2019-10-23  3297  		dev_err(dev, "failing probe due to bman probe error\n");
5537b329857676 Laurentiu Tudor 2019-10-23  3298  		return -ENODEV;
5537b329857676 Laurentiu Tudor 2019-10-23  3299  	}
5537b329857676 Laurentiu Tudor 2019-10-23  3300  	err = qman_is_probed();
5537b329857676 Laurentiu Tudor 2019-10-23  3301  	if (!err)
5537b329857676 Laurentiu Tudor 2019-10-23  3302  		return -EPROBE_DEFER;
5537b329857676 Laurentiu Tudor 2019-10-23  3303  	if (err < 0) {
060ad66f97954f Madalin Bucur   2019-10-23  3304  		dev_err(dev, "failing probe due to qman probe error\n");
5537b329857676 Laurentiu Tudor 2019-10-23  3305  		return -ENODEV;
5537b329857676 Laurentiu Tudor 2019-10-23  3306  	}
5537b329857676 Laurentiu Tudor 2019-10-23  3307  	err = bman_portals_probed();
5537b329857676 Laurentiu Tudor 2019-10-23  3308  	if (!err)
5537b329857676 Laurentiu Tudor 2019-10-23  3309  		return -EPROBE_DEFER;
5537b329857676 Laurentiu Tudor 2019-10-23  3310  	if (err < 0) {
060ad66f97954f Madalin Bucur   2019-10-23  3311  		dev_err(dev,
5537b329857676 Laurentiu Tudor 2019-10-23  3312  			"failing probe due to bman portals probe error\n");
5537b329857676 Laurentiu Tudor 2019-10-23  3313  		return -ENODEV;
5537b329857676 Laurentiu Tudor 2019-10-23  3314  	}
5537b329857676 Laurentiu Tudor 2019-10-23  3315  	err = qman_portals_probed();
5537b329857676 Laurentiu Tudor 2019-10-23  3316  	if (!err)
5537b329857676 Laurentiu Tudor 2019-10-23  3317  		return -EPROBE_DEFER;
5537b329857676 Laurentiu Tudor 2019-10-23  3318  	if (err < 0) {
060ad66f97954f Madalin Bucur   2019-10-23  3319  		dev_err(dev,
5537b329857676 Laurentiu Tudor 2019-10-23  3320  			"failing probe due to qman portals probe error\n");
5537b329857676 Laurentiu Tudor 2019-10-23  3321  		return -ENODEV;
5537b329857676 Laurentiu Tudor 2019-10-23  3322  	}
5537b329857676 Laurentiu Tudor 2019-10-23  3323  
9ad1a37493338c Madalin Bucur   2016-11-15  3324  	/* Allocate this early, so we can store relevant information in
9ad1a37493338c Madalin Bucur   2016-11-15  3325  	 * the private area
9ad1a37493338c Madalin Bucur   2016-11-15  3326  	 */
9ad1a37493338c Madalin Bucur   2016-11-15  3327  	net_dev = alloc_etherdev_mq(sizeof(*priv), DPAA_ETH_TXQ_NUM);
9ad1a37493338c Madalin Bucur   2016-11-15  3328  	if (!net_dev) {
9ad1a37493338c Madalin Bucur   2016-11-15  3329  		dev_err(dev, "alloc_etherdev_mq() failed\n");
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3330  		return -ENOMEM;
9ad1a37493338c Madalin Bucur   2016-11-15  3331  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3332  
9ad1a37493338c Madalin Bucur   2016-11-15  3333  	/* Do this here, so we can be verbose early */
5d14c304bfc14b Vladimir Oltean 2020-05-25  3334  	SET_NETDEV_DEV(net_dev, dev->parent);
9ad1a37493338c Madalin Bucur   2016-11-15  3335  	dev_set_drvdata(dev, net_dev);
9ad1a37493338c Madalin Bucur   2016-11-15  3336  
9ad1a37493338c Madalin Bucur   2016-11-15  3337  	priv = netdev_priv(net_dev);
9ad1a37493338c Madalin Bucur   2016-11-15  3338  	priv->net_dev = net_dev;
9ad1a37493338c Madalin Bucur   2016-11-15  3339  
9ad1a37493338c Madalin Bucur   2016-11-15  3340  	priv->msg_enable = netif_msg_init(debug, DPAA_MSG_DEFAULT);
9ad1a37493338c Madalin Bucur   2016-11-15  3341  
9ad1a37493338c Madalin Bucur   2016-11-15  3342  	mac_dev = dpaa_mac_dev_get(pdev);
9ad1a37493338c Madalin Bucur   2016-11-15  3343  	if (IS_ERR(mac_dev)) {
060ad66f97954f Madalin Bucur   2019-10-23  3344  		netdev_err(net_dev, "dpaa_mac_dev_get() failed\n");
9ad1a37493338c Madalin Bucur   2016-11-15  3345  		err = PTR_ERR(mac_dev);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3346  		goto free_netdev;
9ad1a37493338c Madalin Bucur   2016-11-15  3347  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3348  
060ad66f97954f Madalin Bucur   2019-10-23  3349  	/* Devices used for DMA mapping */
060ad66f97954f Madalin Bucur   2019-10-23  3350  	priv->rx_dma_dev = fman_port_get_device(mac_dev->port[RX]);
060ad66f97954f Madalin Bucur   2019-10-23  3351  	priv->tx_dma_dev = fman_port_get_device(mac_dev->port[TX]);
060ad66f97954f Madalin Bucur   2019-10-23  3352  	err = dma_coerce_mask_and_coherent(priv->rx_dma_dev, DMA_BIT_MASK(40));
060ad66f97954f Madalin Bucur   2019-10-23  3353  	if (!err)
060ad66f97954f Madalin Bucur   2019-10-23  3354  		err = dma_coerce_mask_and_coherent(priv->tx_dma_dev,
060ad66f97954f Madalin Bucur   2019-10-23  3355  						   DMA_BIT_MASK(40));
060ad66f97954f Madalin Bucur   2019-10-23  3356  	if (err) {
060ad66f97954f Madalin Bucur   2019-10-23  3357  		netdev_err(net_dev, "dma_coerce_mask_and_coherent() failed\n");
6790711f8ac5fa Liu Jian        2020-07-20  3358  		goto free_netdev;
060ad66f97954f Madalin Bucur   2019-10-23  3359  	}
060ad66f97954f Madalin Bucur   2019-10-23  3360  
9ad1a37493338c Madalin Bucur   2016-11-15  3361  	/* If fsl_fm_max_frm is set to a higher value than the all-common 1500,
9ad1a37493338c Madalin Bucur   2016-11-15  3362  	 * we choose conservatively and let the user explicitly set a higher
9ad1a37493338c Madalin Bucur   2016-11-15  3363  	 * MTU via ifconfig. Otherwise, the user may end up with different MTUs
9ad1a37493338c Madalin Bucur   2016-11-15  3364  	 * in the same LAN.
9ad1a37493338c Madalin Bucur   2016-11-15  3365  	 * If on the other hand fsl_fm_max_frm has been chosen below 1500,
9ad1a37493338c Madalin Bucur   2016-11-15  3366  	 * start with the maximum allowed.
9ad1a37493338c Madalin Bucur   2016-11-15  3367  	 */
9ad1a37493338c Madalin Bucur   2016-11-15  3368  	net_dev->mtu = min(dpaa_get_max_mtu(), ETH_DATA_LEN);
9ad1a37493338c Madalin Bucur   2016-11-15  3369  
9ad1a37493338c Madalin Bucur   2016-11-15  3370  	netdev_dbg(net_dev, "Setting initial MTU on net device: %d\n",
9ad1a37493338c Madalin Bucur   2016-11-15  3371  		   net_dev->mtu);
9ad1a37493338c Madalin Bucur   2016-11-15  3372  
9ad1a37493338c Madalin Bucur   2016-11-15  3373  	priv->buf_layout[RX].priv_data_size = DPAA_RX_PRIV_DATA_SIZE; /* Rx */
9ad1a37493338c Madalin Bucur   2016-11-15  3374  	priv->buf_layout[TX].priv_data_size = DPAA_TX_PRIV_DATA_SIZE; /* Tx */
9ad1a37493338c Madalin Bucur   2016-11-15  3375  
9ad1a37493338c Madalin Bucur   2016-11-15  3376  	/* bp init */
f07f30042f8e0f Madalin Bucur   2019-10-31  3377  	dpaa_bp = dpaa_bp_alloc(dev);
f07f30042f8e0f Madalin Bucur   2019-10-31  3378  	if (IS_ERR(dpaa_bp)) {
f07f30042f8e0f Madalin Bucur   2019-10-31  3379  		err = PTR_ERR(dpaa_bp);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3380  		goto free_dpaa_bps;
29130853fe6dee Wei Yongjun     2017-11-06  3381  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3382  	/* the raw size of the buffers used for reception */
f07f30042f8e0f Madalin Bucur   2019-10-31  3383  	dpaa_bp->raw_size = DPAA_BP_RAW_SIZE;
9ad1a37493338c Madalin Bucur   2016-11-15  3384  	/* avoid runtime computations by keeping the usable size here */
f07f30042f8e0f Madalin Bucur   2019-10-31  3385  	dpaa_bp->size = dpaa_bp_size(dpaa_bp->raw_size);
f07f30042f8e0f Madalin Bucur   2019-10-31  3386  	dpaa_bp->priv = priv;
9ad1a37493338c Madalin Bucur   2016-11-15  3387  
f07f30042f8e0f Madalin Bucur   2019-10-31  3388  	err = dpaa_bp_alloc_pool(dpaa_bp);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3389  	if (err < 0)
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3390  		goto free_dpaa_bps;
f07f30042f8e0f Madalin Bucur   2019-10-31  3391  	priv->dpaa_bp = dpaa_bp;
9ad1a37493338c Madalin Bucur   2016-11-15  3392  
9ad1a37493338c Madalin Bucur   2016-11-15  3393  	INIT_LIST_HEAD(&priv->dpaa_fq_list);
9ad1a37493338c Madalin Bucur   2016-11-15  3394  
9ad1a37493338c Madalin Bucur   2016-11-15  3395  	memset(&port_fqs, 0, sizeof(port_fqs));
9ad1a37493338c Madalin Bucur   2016-11-15  3396  
9ad1a37493338c Madalin Bucur   2016-11-15  3397  	err = dpaa_alloc_all_fqs(dev, &priv->dpaa_fq_list, &port_fqs);
9ad1a37493338c Madalin Bucur   2016-11-15  3398  	if (err < 0) {
9ad1a37493338c Madalin Bucur   2016-11-15  3399  		dev_err(dev, "dpaa_alloc_all_fqs() failed\n");
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3400  		goto free_dpaa_bps;
9ad1a37493338c Madalin Bucur   2016-11-15  3401  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3402  
9ad1a37493338c Madalin Bucur   2016-11-15  3403  	priv->mac_dev = mac_dev;
9ad1a37493338c Madalin Bucur   2016-11-15  3404  
9ad1a37493338c Madalin Bucur   2016-11-15  3405  	channel = dpaa_get_channel();
9ad1a37493338c Madalin Bucur   2016-11-15  3406  	if (channel < 0) {
9ad1a37493338c Madalin Bucur   2016-11-15  3407  		dev_err(dev, "dpaa_get_channel() failed\n");
9ad1a37493338c Madalin Bucur   2016-11-15  3408  		err = channel;
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3409  		goto free_dpaa_bps;
9ad1a37493338c Madalin Bucur   2016-11-15  3410  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3411  
9ad1a37493338c Madalin Bucur   2016-11-15  3412  	priv->channel = (u16)channel;
9ad1a37493338c Madalin Bucur   2016-11-15  3413  
d75de7b6e73714 Jake Moroni     2018-02-12  3414  	/* Walk the CPUs with affine portals
9ad1a37493338c Madalin Bucur   2016-11-15  3415  	 * and add this pool channel to each's dequeue mask.
9ad1a37493338c Madalin Bucur   2016-11-15  3416  	 */
e06eea555b878f Madalin Bucur   2019-10-31  3417  	dpaa_eth_add_channel(priv->channel, &pdev->dev);
9ad1a37493338c Madalin Bucur   2016-11-15  3418  
9ad1a37493338c Madalin Bucur   2016-11-15  3419  	dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
9ad1a37493338c Madalin Bucur   2016-11-15  3420  
9ad1a37493338c Madalin Bucur   2016-11-15  3421  	/* Create a congestion group for this netdev, with
9ad1a37493338c Madalin Bucur   2016-11-15  3422  	 * dynamically-allocated CGR ID.
9ad1a37493338c Madalin Bucur   2016-11-15  3423  	 * Must be executed after probing the MAC, but before
9ad1a37493338c Madalin Bucur   2016-11-15  3424  	 * assigning the egress FQs to the CGRs.
9ad1a37493338c Madalin Bucur   2016-11-15  3425  	 */
9ad1a37493338c Madalin Bucur   2016-11-15  3426  	err = dpaa_eth_cgr_init(priv);
9ad1a37493338c Madalin Bucur   2016-11-15  3427  	if (err < 0) {
9ad1a37493338c Madalin Bucur   2016-11-15  3428  		dev_err(dev, "Error initializing CGR\n");
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3429  		goto free_dpaa_bps;
9ad1a37493338c Madalin Bucur   2016-11-15  3430  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3431  
9ad1a37493338c Madalin Bucur   2016-11-15  3432  	err = dpaa_ingress_cgr_init(priv);
9ad1a37493338c Madalin Bucur   2016-11-15  3433  	if (err < 0) {
9ad1a37493338c Madalin Bucur   2016-11-15  3434  		dev_err(dev, "Error initializing ingress CGR\n");
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3435  		goto delete_egress_cgr;
9ad1a37493338c Madalin Bucur   2016-11-15  3436  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3437  
9ad1a37493338c Madalin Bucur   2016-11-15  3438  	/* Add the FQs to the interface, and make them active */
9ad1a37493338c Madalin Bucur   2016-11-15  3439  	list_for_each_entry_safe(dpaa_fq, tmp, &priv->dpaa_fq_list, list) {
9ad1a37493338c Madalin Bucur   2016-11-15  3440  		err = dpaa_fq_init(dpaa_fq, false);
9ad1a37493338c Madalin Bucur   2016-11-15  3441  		if (err < 0)
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3442  			goto free_dpaa_fqs;
9ad1a37493338c Madalin Bucur   2016-11-15  3443  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3444  
7834e494f42627 Camelia Groza   2020-11-02  3445  	priv->tx_headroom = dpaa_get_headroom(priv->buf_layout, TX);
7834e494f42627 Camelia Groza   2020-11-02  3446  	priv->rx_headroom = dpaa_get_headroom(priv->buf_layout, RX);
9ad1a37493338c Madalin Bucur   2016-11-15  3447  
9ad1a37493338c Madalin Bucur   2016-11-15  3448  	/* All real interfaces need their ports initialized */
f07f30042f8e0f Madalin Bucur   2019-10-31  3449  	err = dpaa_eth_init_ports(mac_dev, dpaa_bp, &port_fqs,
9ad1a37493338c Madalin Bucur   2016-11-15  3450  				  &priv->buf_layout[0], dev);
7f8a6a1b8fa491 Madalin Bucur   2017-02-13  3451  	if (err)
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3452  		goto free_dpaa_fqs;
9ad1a37493338c Madalin Bucur   2016-11-15  3453  
056057e288e707 Madalin Bucur   2017-08-27  3454  	/* Rx traffic distribution based on keygen hashing defaults to on */
056057e288e707 Madalin Bucur   2017-08-27  3455  	priv->keygen_in_use = true;
056057e288e707 Madalin Bucur   2017-08-27  3456  
9ad1a37493338c Madalin Bucur   2016-11-15  3457  	priv->percpu_priv = devm_alloc_percpu(dev, *priv->percpu_priv);
9ad1a37493338c Madalin Bucur   2016-11-15  3458  	if (!priv->percpu_priv) {
9ad1a37493338c Madalin Bucur   2016-11-15  3459  		dev_err(dev, "devm_alloc_percpu() failed\n");
9ad1a37493338c Madalin Bucur   2016-11-15  3460  		err = -ENOMEM;
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3461  		goto free_dpaa_fqs;
9ad1a37493338c Madalin Bucur   2016-11-15  3462  	}
9ad1a37493338c Madalin Bucur   2016-11-15  3463  
c44efa1d75e4c0 Camelia Groza   2016-07-25  3464  	priv->num_tc = 1;
c44efa1d75e4c0 Camelia Groza   2016-07-25  3465  	netif_set_real_num_tx_queues(net_dev, priv->num_tc * DPAA_TC_TXQ_NUM);
c44efa1d75e4c0 Camelia Groza   2016-07-25  3466  
9ad1a37493338c Madalin Bucur   2016-11-15  3467  	/* Initialize NAPI */
9ad1a37493338c Madalin Bucur   2016-11-15  3468  	err = dpaa_napi_add(net_dev);
9ad1a37493338c Madalin Bucur   2016-11-15  3469  	if (err < 0)
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3470  		goto delete_dpaa_napi;
9ad1a37493338c Madalin Bucur   2016-11-15  3471  
9ad1a37493338c Madalin Bucur   2016-11-15  3472  	err = dpaa_netdev_init(net_dev, &dpaa_ops, tx_timeout);
9ad1a37493338c Madalin Bucur   2016-11-15  3473  	if (err < 0)
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3474  		goto delete_dpaa_napi;
9ad1a37493338c Madalin Bucur   2016-11-15  3475  
846a86e20123b0 Madalin Bucur   2016-11-15  3476  	dpaa_eth_sysfs_init(&net_dev->dev);
846a86e20123b0 Madalin Bucur   2016-11-15  3477  
9ad1a37493338c Madalin Bucur   2016-11-15  3478  	netif_info(priv, probe, net_dev, "Probed interface %s\n",
9ad1a37493338c Madalin Bucur   2016-11-15  3479  		   net_dev->name);
9ad1a37493338c Madalin Bucur   2016-11-15  3480  
9ad1a37493338c Madalin Bucur   2016-11-15  3481  	return 0;
9ad1a37493338c Madalin Bucur   2016-11-15  3482  
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3483  delete_dpaa_napi:
9ad1a37493338c Madalin Bucur   2016-11-15  3484  	dpaa_napi_del(net_dev);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3485  free_dpaa_fqs:
9ad1a37493338c Madalin Bucur   2016-11-15  3486  	dpaa_fq_free(dev, &priv->dpaa_fq_list);
9ad1a37493338c Madalin Bucur   2016-11-15  3487  	qman_delete_cgr_safe(&priv->ingress_cgr);
9ad1a37493338c Madalin Bucur   2016-11-15  3488  	qman_release_cgrid(priv->ingress_cgr.cgrid);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3489  delete_egress_cgr:
9ad1a37493338c Madalin Bucur   2016-11-15  3490  	qman_delete_cgr_safe(&priv->cgr_data.cgr);
9ad1a37493338c Madalin Bucur   2016-11-15  3491  	qman_release_cgrid(priv->cgr_data.cgr.cgrid);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3492  free_dpaa_bps:
9ad1a37493338c Madalin Bucur   2016-11-15  3493  	dpaa_bps_free(priv);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3494  free_netdev:
9ad1a37493338c Madalin Bucur   2016-11-15  3495  	dev_set_drvdata(dev, NULL);
9ad1a37493338c Madalin Bucur   2016-11-15  3496  	free_netdev(net_dev);
8b9b5a2c27e1a7 Madalin Bucur   2017-10-16  3497  
9ad1a37493338c Madalin Bucur   2016-11-15  3498  	return err;
9ad1a37493338c Madalin Bucur   2016-11-15  3499  }
9ad1a37493338c Madalin Bucur   2016-11-15  3500  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

