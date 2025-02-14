Return-Path: <netdev+bounces-166458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF2A360C1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD03AE6A9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A426561F;
	Fri, 14 Feb 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alpnH9o2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988D72566D9;
	Fri, 14 Feb 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544335; cv=none; b=fBASM+kBw7OWGpvL0lnHvIECWsBUPzEbRo1uoJOfuxD0VqXEGg3LAmCnDK3bKYY7mh8PxQdWuqTpKDlNWjlXnWehA6UFNzAQhyVy14s3GOexdEFiiPYs+fx/R7727lSGfd4Um8VzV2yOdmGh0klgFpRuabZ/5H/yK3xrF9uXrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544335; c=relaxed/simple;
	bh=Ykfmo72lISkSPa3zpie1sR0a60kfyI4PuSZYUX9alk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIGcbx1cMVgIpwWpwHAiotiBCQu7qLg6BKHTnNbAkx9vB/PIP2XmkdSeo34X+DVmreA3CmSHmpCLvM+nu5U0laepP/WhXVSVxO9MsoFRy16Rgjan+NvKO2H+S9qPNUUQkmfzPjz576v2c49t45t4JlK1N8oPtwZ4k+kPcoyfiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alpnH9o2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739544331; x=1771080331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ykfmo72lISkSPa3zpie1sR0a60kfyI4PuSZYUX9alk4=;
  b=alpnH9o2I8RjtmjIlGjLxbcfQbQfybRqAyWHvs7JRM9zbUI+XOGCU9QF
   G6FtKrHuacbxaVOfzDdC28pv58c1wwz+9wjtstTxlokVE5fL0UDv3OVem
   ZXKCSN87lUDQ1AsrqgBo8a+yYrI9wJklxrrSm4vq5O76+CshneDC2o4iu
   hM6lyxZ9gRXXVXJF2BtbUWBVB3VJ8E8xQ0hUB68XUN/ND5kd1TXJLZgKJ
   IbKhqye5i32jqIJVxyaOiUAXzzo1AUuvOjwIrJtCgD6OVNTIIHKNo1Yt+
   C3x3vJXwK7a+OLfiU9R5SMz2216aL57W2EORIw6lc4FFqH10Vjm1vuYlQ
   g==;
X-CSE-ConnectionGUID: 4Wn3qCRmQsmg8dLyAiakhg==
X-CSE-MsgGUID: 91OHrblMRNmNzit30ymkwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="51267638"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="51267638"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:45:30 -0800
X-CSE-ConnectionGUID: IJwlUep2QqqUcsxnOkvtyg==
X-CSE-MsgGUID: PJHsz83yRjGTXSfDo8aDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113992375"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Feb 2025 06:45:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiwwW-0019gR-0N;
	Fri, 14 Feb 2025 14:45:24 +0000
Date: Fri, 14 Feb 2025 22:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, kalesh-anakkur.purayil@broadcom.com
Cc: oe-kbuild-all@lists.linux.dev, Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [net-next PATCH v9 3/6] octeontx2-af: CN20k mbox to support AF
 REQ/ACK functionality
Message-ID: <202502142256.5RFZmK7u-lkp@intel.com>
References: <20250213170504.3892412-4-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213170504.3892412-4-saikrishnag@marvell.com>

Hi Sai,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Krishna/octeontx2-Set-appropriate-PF-VF-masks-and-shifts-based-on-silicon/20250214-013817
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250213170504.3892412-4-saikrishnag%40marvell.com
patch subject: [net-next PATCH v9 3/6] octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
config: alpha-randconfig-r051-20250214 (https://download.01.org/0day-ci/archive/20250214/202502142256.5RFZmK7u-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502142256.5RFZmK7u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502142256.5RFZmK7u-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_free_hw_resources':
>> drivers/net/ethernet/marvell/octeontx2/af/rvu.c:760:25: error: 'RVU_AFPF' undeclared (first use in this function)
     760 |         pfvf = &rvu->pf[RVU_AFPF];
         |                         ^~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:760:25: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c: In function 'rvu_probe':
   drivers/net/ethernet/marvell/octeontx2/af/rvu.c:3494:47: error: 'RVU_AFPF' undeclared (first use in this function)
    3494 |         rvu_alloc_cint_qint_mem(rvu, &rvu->pf[RVU_AFPF], BLKADDR_NIX0,
         |                                               ^~~~~~~~


vim +/RVU_AFPF +760 drivers/net/ethernet/marvell/octeontx2/af/rvu.c

   717	
   718	static void rvu_free_hw_resources(struct rvu *rvu)
   719	{
   720		struct rvu_hwinfo *hw = rvu->hw;
   721		struct rvu_block *block;
   722		struct rvu_pfvf  *pfvf;
   723		int id, max_msix;
   724		u64 cfg;
   725	
   726		rvu_npa_freemem(rvu);
   727		rvu_npc_freemem(rvu);
   728		rvu_nix_freemem(rvu);
   729	
   730		/* Free block LF bitmaps */
   731		for (id = 0; id < BLK_COUNT; id++) {
   732			block = &hw->block[id];
   733			kfree(block->lf.bmap);
   734		}
   735	
   736		/* Free MSIX bitmaps */
   737		for (id = 0; id < hw->total_pfs; id++) {
   738			pfvf = &rvu->pf[id];
   739			kfree(pfvf->msix.bmap);
   740		}
   741	
   742		for (id = 0; id < hw->total_vfs; id++) {
   743			pfvf = &rvu->hwvf[id];
   744			kfree(pfvf->msix.bmap);
   745		}
   746	
   747		/* Unmap MSIX vector base IOVA mapping */
   748		if (!rvu->msix_base_iova)
   749			return;
   750		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_CONST);
   751		max_msix = cfg & 0xFFFFF;
   752		dma_unmap_resource(rvu->dev, rvu->msix_base_iova,
   753				   max_msix * PCI_MSIX_ENTRY_SIZE,
   754				   DMA_BIDIRECTIONAL, 0);
   755	
   756		rvu_reset_msix(rvu);
   757		mutex_destroy(&rvu->rsrc_lock);
   758	
   759		/* Free the QINT/CINt memory */
 > 760		pfvf = &rvu->pf[RVU_AFPF];
   761		qmem_free(rvu->dev, pfvf->nix_qints_ctx);
   762		qmem_free(rvu->dev, pfvf->cq_ints_ctx);
   763	}
   764	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

