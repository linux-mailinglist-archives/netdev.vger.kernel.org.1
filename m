Return-Path: <netdev+bounces-213567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4DB25AD0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AC1C23314
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CA221F17;
	Thu, 14 Aug 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcaGQ5Zh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0C224AE0;
	Thu, 14 Aug 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149638; cv=none; b=f4ARoQ3w3vKI3w1hkw1SezhJ7gwrg3LYMFtfT5l9TlCTOefLqiBRlkrKpJM/9vSDZETemn/PECK65YmvfGxlVruLBX0OEv4WTnFYy9X6kLQLp9IsjknWwp40IPuG+6B6P2TvGBiTMwZVUGHW5bFi7GbO9Ues+pifMT/VETYVosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149638; c=relaxed/simple;
	bh=GeJjP+TUdBl5BD2eSSgzz9493+BZmCw5J9EpNaxM8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3iJ6OR1NyzPrxO18RasISG5O/BrOKFICJVZVfv/fUwvA/kV5fscnV7i68GwdXmJURF3kJXm+Cu4rbgsf/wellQZKh+0zvGoi1suz4ju/K0JWQeFHB+3EhnElUkxh82cWDtLOW+EIYRp0HvPOMaqGVHyFPgRZMbClWAbnbVWe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcaGQ5Zh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755149637; x=1786685637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GeJjP+TUdBl5BD2eSSgzz9493+BZmCw5J9EpNaxM8JY=;
  b=NcaGQ5ZhdDDCJbEl8Wwxy/93rAYtX36VfxYDantFIhRDOJCfp9qnpVSu
   KZFgt+mAHzafUHj+4pyN8Psrz1dqMnnSSHQxS1ZInPMPcZdAQDpPnnWeT
   A/wcgsR41SbVQRjJancD6MAtsPz2fjfyBcaGdvszJvQUp5v35CTwJTOl7
   uQLdYqdfBRQy4GjP7BtiSsb5Xppq0Z5+OzenSeAlM55p+YD/b4ONYzN5k
   Vl5PScBpLW5zpYd8Q2pZbqPUoYObKik33LF0sRWUOSd0yXjVcbs+Z115c
   tZeqSbVT9KH9M/+NpKBPLAL6NlR6TQwvSjX1sBqVZ+vhYB45DuhBKhzM7
   g==;
X-CSE-ConnectionGUID: gRRIj8JQRkWYPqJL/mXl1g==
X-CSE-MsgGUID: G2XQkYG2Rr63buW+wD6H9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61078954"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61078954"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 22:33:57 -0700
X-CSE-ConnectionGUID: NQyopVXkR423CP/IURkjuw==
X-CSE-MsgGUID: lvTFe7rCRYGho+E+V6N9bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166657209"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2025 22:33:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umQaz-000Ac4-2X;
	Thu, 14 Aug 2025 05:33:49 +0000
Date: Thu, 14 Aug 2025 13:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 1/9] bng_en: Add initial support for RX and TX rings
Message-ID: <202508141306.LMpg4Jkx-lkp@intel.com>
References: <20250813215603.76526-2-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813215603.76526-2-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Add-initial-support-for-RX-and-TX-rings/20250814-004339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250813215603.76526-2-bhargava.marreddy%40broadcom.com
patch subject: [net-next 1/9] bng_en: Add initial support for RX and TX rings
config: loongarch-randconfig-r073-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141306.LMpg4Jkx-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141306.LMpg4Jkx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141306.LMpg4Jkx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:276:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     276 |         if (!bn->tx_ring_map)
         |             ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:315:9: note: uninitialized use occurs here
     315 |         return rc;
         |                ^~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:276:2: note: remove the 'if' if its condition is always false
     276 |         if (!bn->tx_ring_map)
         |         ^~~~~~~~~~~~~~~~~~~~~
     277 |                 goto err_free_core;
         |                 ~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:270:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     270 |         if (!bn->tx_ring)
         |             ^~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:315:9: note: uninitialized use occurs here
     315 |         return rc;
         |                ^~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:270:2: note: remove the 'if' if its condition is always false
     270 |         if (!bn->tx_ring)
         |         ^~~~~~~~~~~~~~~~~
     271 |                 goto err_free_core;
         |                 ~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:253:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     253 |         if (!bn->rx_ring)
         |             ^~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:315:9: note: uninitialized use occurs here
     315 |         return rc;
         |                ^~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:253:2: note: remove the 'if' if its condition is always false
     253 |         if (!bn->rx_ring)
         |         ^~~~~~~~~~~~~~~~~
     254 |                 goto err_free_core;
         |                 ~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.c:228:14: note: initialize the variable 'rc' to silence this warning
     228 |         int i, j, rc, size, arr_size;
         |                     ^
         |                      = 0
   3 warnings generated.


vim +276 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

   224	
   225	static int bnge_alloc_core(struct bnge_net *bn)
   226	{
   227		struct bnge_dev *bd = bn->bd;
   228		int i, j, rc, size, arr_size;
   229		void *bnapi;
   230	
   231		arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
   232				bd->nq_nr_rings);
   233		size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
   234		bnapi = kzalloc(arr_size + size * bd->nq_nr_rings, GFP_KERNEL);
   235		if (!bnapi)
   236			return -ENOMEM;
   237	
   238		bn->bnapi = bnapi;
   239		bnapi += arr_size;
   240		for (i = 0; i < bd->nq_nr_rings; i++, bnapi += size) {
   241			struct bnge_nq_ring_info *nqr;
   242	
   243			bn->bnapi[i] = bnapi;
   244			bn->bnapi[i]->index = i;
   245			bn->bnapi[i]->bn = bn;
   246			nqr = &bn->bnapi[i]->nq_ring;
   247			nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
   248		}
   249	
   250		bn->rx_ring = kcalloc(bd->rx_nr_rings,
   251				      sizeof(struct bnge_rx_ring_info),
   252				      GFP_KERNEL);
   253		if (!bn->rx_ring)
   254			goto err_free_core;
   255	
   256		for (i = 0; i < bd->rx_nr_rings; i++) {
   257			struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
   258	
   259			rxr->rx_ring_struct.ring_mem.flags =
   260				BNGE_RMEM_RING_PTE_FLAG;
   261			rxr->rx_agg_ring_struct.ring_mem.flags =
   262				BNGE_RMEM_RING_PTE_FLAG;
   263			rxr->bnapi = bn->bnapi[i];
   264			bn->bnapi[i]->rx_ring = &bn->rx_ring[i];
   265		}
   266	
   267		bn->tx_ring = kcalloc(bd->tx_nr_rings,
   268				      sizeof(struct bnge_tx_ring_info),
   269				      GFP_KERNEL);
   270		if (!bn->tx_ring)
   271			goto err_free_core;
   272	
   273		bn->tx_ring_map = kcalloc(bd->tx_nr_rings, sizeof(u16),
   274					  GFP_KERNEL);
   275	
 > 276		if (!bn->tx_ring_map)
   277			goto err_free_core;
   278	
   279		if (bd->flags & BNGE_EN_SHARED_CHNL)
   280			j = 0;
   281		else
   282			j = bd->rx_nr_rings;
   283	
   284		for (i = 0; i < bd->tx_nr_rings; i++) {
   285			struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
   286			struct bnge_napi *bnapi2;
   287			int k;
   288	
   289			txr->tx_ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
   290			bn->tx_ring_map[i] = i;
   291			k = j + BNGE_RING_TO_TC_OFF(bd, i);
   292	
   293			bnapi2 = bn->bnapi[k];
   294			txr->txq_index = i;
   295			txr->tx_napi_idx =
   296				BNGE_RING_TO_TC(bd, txr->txq_index);
   297			bnapi2->tx_ring[txr->tx_napi_idx] = txr;
   298			txr->bnapi = bnapi2;
   299		}
   300	
   301		bnge_init_ring_struct(bn);
   302	
   303		rc = bnge_alloc_rx_rings(bn);
   304		if (rc)
   305			goto err_free_core;
   306	
   307		rc = bnge_alloc_tx_rings(bn);
   308		if (rc)
   309			goto err_free_core;
   310	
   311		return 0;
   312	
   313	err_free_core:
   314		bnge_free_core(bn);
   315		return rc;
   316	}
   317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

