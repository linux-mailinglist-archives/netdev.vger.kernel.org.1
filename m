Return-Path: <netdev+bounces-97046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5748C8EB3
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 01:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A81E1C211C0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2271140E2F;
	Fri, 17 May 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjc3tZjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3BEED3
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990118; cv=none; b=K2xCzvSYnkUziXrYiKo4a2yQR8T13d0HKIdqNkszks7iNlT61kxbsxZs8YMd1nXxfqvzZl9s9+mgJJzdPAfe/ILYy2+bzpWAURQRALgxibbBEctjyTUm0EvdI/8BuZI/0KY05VTQtNduKPAjLic1loDJsDRqCC8KYpMEBYLxqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990118; c=relaxed/simple;
	bh=48h09Q8k8kpxKjct4Gb0FLOSPIYrJyY0emc1Ha6evIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6LkXfN4eYN6gk9TXztfwOhMQ2tzn2gK68gPtxqTQm9zKdddk+e0XrsekrCWuc37G1f90GA1/eSTihT2bnpDUlF7bPzB2NVwQLNxO+sUj4m020SoTiKjaOHJqu5nEkaZXoBYW/kUQGAfDgXkSGV5TcENU9hku8Hqzj1MUv1aHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjc3tZjQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715990116; x=1747526116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=48h09Q8k8kpxKjct4Gb0FLOSPIYrJyY0emc1Ha6evIk=;
  b=Qjc3tZjQs7cidrafIWJY4bSHFzArlNsCky9R4pd/4axgzxVBb3dUNR5q
   E8zyEEqDceGQ81/V1uWfGzP1HCD7h67/bEhuioYnDpm8ts5dCZ/Lz5tsZ
   zWTOUJfzNuL/6uNmMfd48YGSHcLyuS8Cq58rd3tfUIaMNKTYonAbTJgCk
   jYZY+pbqeOCgeCFD2pwEt3BZzkQs/SG/lPeQHrf0hxp9Wwe3jHM1RbM7h
   T4S8EpFDD0zjDYGxJrXqhaIQEc59zna+G245gamI1l0FMrmnmsIm1tHjB
   GEkfSrmZCpJw1Ezjm3Jn26L6d/7t9gqTxHXbqVLLD89ZkoulU/gB0UWkB
   w==;
X-CSE-ConnectionGUID: Tm74LZr4SIigk57vC2o/iw==
X-CSE-MsgGUID: wVE9rMF6R3ilbOLNhA5IhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="34704387"
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="34704387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 16:55:15 -0700
X-CSE-ConnectionGUID: UmqIAfYoRya2/E9moK73HA==
X-CSE-MsgGUID: f9t9PdaPR5+7i+AEcrp8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="32559742"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 May 2024 16:55:13 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s87Pn-0001GU-2H;
	Fri, 17 May 2024 23:55:08 +0000
Date: Sat, 18 May 2024 07:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jitendra.vegiraju@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
Message-ID: <202405180744.BCWHYhmN-lkp@intel.com>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>

Hi Jitendra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9 next-20240517]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jitendra-Vegiraju/net-stmmac-Export-dma_ops-for-reuse-in-glue-drivers/20240511-141147
base:   linus/master
patch link:    https://lore.kernel.org/r/20240510000331.154486-3-jitendra.vegiraju%40broadcom.com
patch subject: [PATCH, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
config: parisc-randconfig-r111-20240518 (https://download.01.org/0day-ci/archive/20240518/202405180744.BCWHYhmN-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240518/202405180744.BCWHYhmN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405180744.BCWHYhmN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c:210:29: sparse: sparse: symbol 'dwxgmac_brcm_dma_ops' was not declared. Should it be static?

vim +/dwxgmac_brcm_dma_ops +210 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

   209	
 > 210	const struct stmmac_dma_ops dwxgmac_brcm_dma_ops = {
   211		.reset = dwxgmac2_dma_reset,
   212		.init = dwxgmac_brcm_dma_init,
   213		.init_chan = dwxgmac2_dma_init_chan,
   214		.init_rx_chan = dwxgmac_brcm_dma_init_rx_chan,
   215		.init_tx_chan = dwxgmac_brcm_dma_init_tx_chan,
   216		.axi = dwxgmac2_dma_axi,
   217		.dump_regs = dwxgmac2_dma_dump_regs,
   218		.dma_rx_mode = dwxgmac2_dma_rx_mode,
   219		.dma_tx_mode = dwxgmac2_dma_tx_mode,
   220		.enable_dma_irq = dwxgmac2_enable_dma_irq,
   221		.disable_dma_irq = dwxgmac2_disable_dma_irq,
   222		.start_tx = dwxgmac2_dma_start_tx,
   223		.stop_tx = dwxgmac2_dma_stop_tx,
   224		.start_rx = dwxgmac2_dma_start_rx,
   225		.stop_rx = dwxgmac2_dma_stop_rx,
   226		.dma_interrupt = dwxgmac2_dma_interrupt,
   227		.get_hw_feature = dwxgmac2_get_hw_feature,
   228		.rx_watchdog = dwxgmac2_rx_watchdog,
   229		.set_rx_ring_len = dwxgmac2_set_rx_ring_len,
   230		.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
   231		.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
   232		.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
   233		.enable_tso = dwxgmac2_enable_tso,
   234		.qmode = dwxgmac2_qmode,
   235		.set_bfsize = dwxgmac2_set_bfsize,
   236		.enable_sph = dwxgmac2_enable_sph,
   237		.enable_tbs = dwxgmac2_enable_tbs,
   238	};
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

