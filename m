Return-Path: <netdev+bounces-101895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E69007B5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D61F26C03
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409419A296;
	Fri,  7 Jun 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMW+3IuN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74519A286;
	Fri,  7 Jun 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771947; cv=none; b=iG62xQp+k0YC5HTyHT7QqJPpm7JjkOfKs59sCW0fc1Ses37QxZ6BsFPk7/FJQbllbpqJ6Wj5i8aqbpU2GSGARbEGH1zM/lxkSIt4W8KBt8pJr9PiJMYLCCcY7tir61X7jXqvjIaUs8l2DcOpbmJbAZ8MEEUO1+CtbQ96c/dgAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771947; c=relaxed/simple;
	bh=OMgQGpWCIfcLB/7YN1u3KXCXoBIYpa43uuqf3QD8gsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db5D65oS2nAFZKD/TrreLtiZuKbpew6PNkG0bqoLTyi+6WdUKgF4QzJ2nvaJ91ildlIG7xkpHKfFMbFxRClYhqObNq6nrCpzioW60v3e86huzRleytqNDOaSrLt+N11tYLpQ2qShY5VOLZQDKjM8EyJrMSyrbTHPXLvaxaZ2YGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMW+3IuN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717771945; x=1749307945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMgQGpWCIfcLB/7YN1u3KXCXoBIYpa43uuqf3QD8gsY=;
  b=VMW+3IuN3zYA1Jxs66NeMfUs9IUihBUX12HgJbwXNgKm/UsUy1SW1djn
   h/xDnXhF6B+H5r+CL/Z0yor7HnOt3+P+kq4iyrYaBH1UyPcgrRV6X+iRI
   n8QjVyyPuXw8pBUivVLLX6xMhTj1TVmcDT4jggSeDtvt/7vDoiFnfRV6s
   MdRa8y9vf2YWwyfgwzbzoPk4ISsGAS9+e0+tQRKbZzBuSwvvuszVgsIyr
   V6ULJToQf8yRze/cpjR3iw6UFBTM66ZKE7vIU8+qcWGbrt8n2ZFAhSLXt
   0P70QXel5zTYp4ivLjYN9OkctKw/nBDLYkX1dzbMpUr3zhu+PEhb5pzhx
   g==;
X-CSE-ConnectionGUID: 5/FTs6ohStShYFO6WrNnXg==
X-CSE-MsgGUID: R4G10qkpT7SQ+Z1BVPBc/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14614559"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14614559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 07:52:25 -0700
X-CSE-ConnectionGUID: +rbaR/4bRy+zZldqdbxGRQ==
X-CSE-MsgGUID: BKBABKoMTk2MEMi3EGRRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75834739"
Received: from lkp-server01.sh.intel.com (HELO 7b447d911354) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Jun 2024 07:52:21 -0700
Received: from kbuild by 7b447d911354 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFax0-00002y-1E;
	Fri, 07 Jun 2024 14:52:18 +0000
Date: Fri, 7 Jun 2024 22:52:00 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, olteanv@gmail.com,
	linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
Message-ID: <202406072254.05ysEMg1-lkp@intel.com>
References: <20240607103327.438455-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607103327.438455-1-xiaolei.wang@windriver.com>

Hi Xiaolei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/net-stmmac-replace-priv-speed-with-the-portTransmitRate-from-the-tc-cbs-parameters/20240607-183700
base:   net/main
patch link:    https://lore.kernel.org/r/20240607103327.438455-1-xiaolei.wang%40windriver.com
patch subject: [net PATCH] net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240607/202406072254.05ysEMg1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072254.05ysEMg1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072254.05ysEMg1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:7:
   In file included from include/net/pkt_cls.h:7:
   In file included from include/net/sch_generic.h:5:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:347:11: warning: unused variable 'speed_div' [-Wunused-variable]
     347 |         u32 ptr, speed_div;
         |                  ^~~~~~~~~
   2 warnings generated.


vim +/speed_div +347 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

4dbbe8dde8485b Jose Abreu                 2018-05-04  341  
1f705bc61aee5f Jose Abreu                 2018-06-27  342  static int tc_setup_cbs(struct stmmac_priv *priv,
1f705bc61aee5f Jose Abreu                 2018-06-27  343  			struct tc_cbs_qopt_offload *qopt)
1f705bc61aee5f Jose Abreu                 2018-06-27  344  {
1f705bc61aee5f Jose Abreu                 2018-06-27  345  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
1f705bc61aee5f Jose Abreu                 2018-06-27  346  	u32 queue = qopt->queue;
1f705bc61aee5f Jose Abreu                 2018-06-27 @347  	u32 ptr, speed_div;
1f705bc61aee5f Jose Abreu                 2018-06-27  348  	u32 mode_to_use;
1f705bc61aee5f Jose Abreu                 2018-06-27  349  	u64 value;
1f705bc61aee5f Jose Abreu                 2018-06-27  350  	int ret;
09685c7b815a3c Xiaolei Wang               2024-06-07  351  	s64 port_transmit_rate_kbps;
1f705bc61aee5f Jose Abreu                 2018-06-27  352  
1f705bc61aee5f Jose Abreu                 2018-06-27  353  	/* Queue 0 is not AVB capable */
1f705bc61aee5f Jose Abreu                 2018-06-27  354  	if (queue <= 0 || queue >= tx_queues_count)
1f705bc61aee5f Jose Abreu                 2018-06-27  355  		return -EINVAL;
0650d4017f4d2e Jose Abreu                 2019-01-09  356  	if (!priv->dma_cap.av)
0650d4017f4d2e Jose Abreu                 2019-01-09  357  		return -EOPNOTSUPP;
1f705bc61aee5f Jose Abreu                 2018-06-27  358  
09685c7b815a3c Xiaolei Wang               2024-06-07  359  	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
09685c7b815a3c Xiaolei Wang               2024-06-07  360  
24877687b375f2 Song, Yoong Siang          2021-02-18  361  	/* Port Transmit Rate and Speed Divider */
09685c7b815a3c Xiaolei Wang               2024-06-07  362  	switch (div_s64(port_transmit_rate_kbps, 1000)) {
24877687b375f2 Song, Yoong Siang          2021-02-18  363  	case SPEED_10000:
24877687b375f2 Song, Yoong Siang          2021-02-18  364  		ptr = 32;
24877687b375f2 Song, Yoong Siang          2021-02-18  365  		break;
24877687b375f2 Song, Yoong Siang          2021-02-18  366  	case SPEED_5000:
24877687b375f2 Song, Yoong Siang          2021-02-18  367  		ptr = 32;
24877687b375f2 Song, Yoong Siang          2021-02-18  368  		break;
24877687b375f2 Song, Yoong Siang          2021-02-18  369  	case SPEED_2500:
24877687b375f2 Song, Yoong Siang          2021-02-18  370  		ptr = 8;
24877687b375f2 Song, Yoong Siang          2021-02-18  371  		break;
24877687b375f2 Song, Yoong Siang          2021-02-18  372  	case SPEED_1000:
24877687b375f2 Song, Yoong Siang          2021-02-18  373  		ptr = 8;
24877687b375f2 Song, Yoong Siang          2021-02-18  374  		break;
24877687b375f2 Song, Yoong Siang          2021-02-18  375  	case SPEED_100:
24877687b375f2 Song, Yoong Siang          2021-02-18  376  		ptr = 4;
24877687b375f2 Song, Yoong Siang          2021-02-18  377  		break;
24877687b375f2 Song, Yoong Siang          2021-02-18  378  	default:
24877687b375f2 Song, Yoong Siang          2021-02-18  379  		return -EOPNOTSUPP;
24877687b375f2 Song, Yoong Siang          2021-02-18  380  	}
24877687b375f2 Song, Yoong Siang          2021-02-18  381  
1f705bc61aee5f Jose Abreu                 2018-06-27  382  	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
1f705bc61aee5f Jose Abreu                 2018-06-27  383  	if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
1f705bc61aee5f Jose Abreu                 2018-06-27  384  		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
1f705bc61aee5f Jose Abreu                 2018-06-27  385  		if (ret)
1f705bc61aee5f Jose Abreu                 2018-06-27  386  			return ret;
1f705bc61aee5f Jose Abreu                 2018-06-27  387  
1f705bc61aee5f Jose Abreu                 2018-06-27  388  		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
1f705bc61aee5f Jose Abreu                 2018-06-27  389  	} else if (!qopt->enable) {
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  390  		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  391  				       MTL_QUEUE_DCB);
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  392  		if (ret)
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  393  			return ret;
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  394  
f317e2ea8c8873 Mohammad Athari Bin Ismail 2021-02-04  395  		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
1f705bc61aee5f Jose Abreu                 2018-06-27  396  	}
1f705bc61aee5f Jose Abreu                 2018-06-27  397  
09685c7b815a3c Xiaolei Wang               2024-06-07  398  	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
09685c7b815a3c Xiaolei Wang               2024-06-07  399  
1f705bc61aee5f Jose Abreu                 2018-06-27  400  	/* Final adjustments for HW */
09685c7b815a3c Xiaolei Wang               2024-06-07  401  	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
1f705bc61aee5f Jose Abreu                 2018-06-27  402  	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
1f705bc61aee5f Jose Abreu                 2018-06-27  403  
09685c7b815a3c Xiaolei Wang               2024-06-07  404  	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
1f705bc61aee5f Jose Abreu                 2018-06-27  405  	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
1f705bc61aee5f Jose Abreu                 2018-06-27  406  
8f704ef666406f Arnd Bergmann              2018-07-06  407  	value = qopt->hicredit * 1024ll * 8;
1f705bc61aee5f Jose Abreu                 2018-06-27  408  	priv->plat->tx_queues_cfg[queue].high_credit = value & GENMASK(31, 0);
1f705bc61aee5f Jose Abreu                 2018-06-27  409  
8f704ef666406f Arnd Bergmann              2018-07-06  410  	value = qopt->locredit * 1024ll * 8;
1f705bc61aee5f Jose Abreu                 2018-06-27  411  	priv->plat->tx_queues_cfg[queue].low_credit = value & GENMASK(31, 0);
1f705bc61aee5f Jose Abreu                 2018-06-27  412  
1f705bc61aee5f Jose Abreu                 2018-06-27  413  	ret = stmmac_config_cbs(priv, priv->hw,
1f705bc61aee5f Jose Abreu                 2018-06-27  414  				priv->plat->tx_queues_cfg[queue].send_slope,
1f705bc61aee5f Jose Abreu                 2018-06-27  415  				priv->plat->tx_queues_cfg[queue].idle_slope,
1f705bc61aee5f Jose Abreu                 2018-06-27  416  				priv->plat->tx_queues_cfg[queue].high_credit,
1f705bc61aee5f Jose Abreu                 2018-06-27  417  				priv->plat->tx_queues_cfg[queue].low_credit,
1f705bc61aee5f Jose Abreu                 2018-06-27  418  				queue);
1f705bc61aee5f Jose Abreu                 2018-06-27  419  	if (ret)
1f705bc61aee5f Jose Abreu                 2018-06-27  420  		return ret;
1f705bc61aee5f Jose Abreu                 2018-06-27  421  
1f705bc61aee5f Jose Abreu                 2018-06-27  422  	dev_info(priv->device, "CBS queue %d: send %d, idle %d, hi %d, lo %d\n",
1f705bc61aee5f Jose Abreu                 2018-06-27  423  			queue, qopt->sendslope, qopt->idleslope,
1f705bc61aee5f Jose Abreu                 2018-06-27  424  			qopt->hicredit, qopt->locredit);
1f705bc61aee5f Jose Abreu                 2018-06-27  425  	return 0;
1f705bc61aee5f Jose Abreu                 2018-06-27  426  }
1f705bc61aee5f Jose Abreu                 2018-06-27  427  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

