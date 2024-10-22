Return-Path: <netdev+bounces-137779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33819A9C34
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C8B21F23
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14717B436;
	Tue, 22 Oct 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcqvT+Xv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9F16132F;
	Tue, 22 Oct 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585169; cv=none; b=XnWe8I8Jfk06TyfTbrntkvMapA034xlgY1TxW6cgO1++vxFn6wUQlITzR3mSdkNiRziBnxZPmpa5XjRfD0nU0HcCi4/H1WPsjjw7Jm0Th5gBpqzSFQ2NIUG1QDlSEntBEYQ+LK9d8udB4Wh0hESGsrys/N00qMPVcQ00MrQa7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585169; c=relaxed/simple;
	bh=rWojlmF9uqY832qw2BFfBjpjd9urFCzse7K42Knm8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwJxghaK3bqT/d28aqcZubhzcXoYGnJxwnJ80RlDaxLChj3ItTzLZPfmfRen87Y+34aI+MwtoVzgPLmZrOlHxsI7UJYQqD03N14cUhQqNDj3RegjDyj9mxWbbQeVA/Du9/pA2eUjECF4iky4UZf23QvYlkJGsccpm7xV4VNGXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcqvT+Xv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729585167; x=1761121167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWojlmF9uqY832qw2BFfBjpjd9urFCzse7K42Knm8sQ=;
  b=dcqvT+XvGdJ/UHuOtiNILstJVXwT96zjDSipFqH9rk4/j3AlR00kD7cG
   Clgt9eObcMr/a3W/XUZllfJG7RXCTgcyvR9lpvFfciuGxSx/H3cbgw6gc
   kSlLEuAidyAl0t/1AX1T+4oWiFQQIYpatYQ2A0tVleIiT5XJVaKBGpQCv
   WzL3VXyRX9/azIoqiu+3G8mXaUD2b/mo7F0iOyWYH5Sf+38ikmdAaBQoJ
   O5P8PxM8f2026thYJ0vumGwzmQSAXMlmjUrrnlz710HvnAhZAw3HVmS81
   7WP4z58u285bvaL2LCdabuM07EBGXA6TH0vY+ZyEiUut6PzPqf31aYiiz
   w==;
X-CSE-ConnectionGUID: LbQ364AGSUqzWZrbhhOwHg==
X-CSE-MsgGUID: ZVmwZ6nOSgWo+Rni9nnABQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40224367"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40224367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:19:27 -0700
X-CSE-ConnectionGUID: CmbChcUrRsuE4QRMaPpOKg==
X-CSE-MsgGUID: JM69lcaGSO6hCXFknq0ezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="117215837"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Oct 2024 01:19:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3A6q-000TIQ-2g;
	Tue, 22 Oct 2024 08:19:20 +0000
Date: Tue, 22 Oct 2024 16:19:04 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Krishna <saikrishnag@marvell.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, lcherian@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Cc: oe-kbuild-all@lists.linux.dev, Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [net-next PATCH 6/6] octeontx2-pf: CN20K mbox implementation
 between PF-VF
Message-ID: <202410221614.07o9QVjo-lkp@intel.com>
References: <20241018203058.3641959-7-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018203058.3641959-7-saikrishnag@marvell.com>

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Krishna/octeontx2-Set-appropriate-PF-VF-masks-and-shifts-based-on-silicon/20241019-043511
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241018203058.3641959-7-saikrishnag%40marvell.com
patch subject: [net-next PATCH 6/6] octeontx2-pf: CN20K mbox implementation between PF-VF
config: alpha-randconfig-r122-20241022 (https://download.01.org/0day-ci/archive/20241022/202410221614.07o9QVjo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20241022/202410221614.07o9QVjo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410221614.07o9QVjo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *hwbase @@     got void * @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24: sparse:     expected void [noderef] __iomem *hwbase
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24: sparse:     got void *
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:620:56: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *hwbase @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35: sparse:     got void *hwbase
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21: sparse:     expected unsigned long long [usertype] *ptr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [usertype] *ptr @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21: sparse:     expected unsigned long long [usertype] *ptr
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: note: in included file (through drivers/net/ethernet/marvell/octeontx2/af/mbox.h, drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h):
>> drivers/net/ethernet/marvell/octeontx2/af/common.h:61:26: sparse: sparse: cast truncates bits from constant value (10000 becomes 0)

vim +611 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

   584	
   585	static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
   586	{
   587		void __iomem *hwbase;
   588		struct mbox *mbox;
   589		int err, vf;
   590		u64 base;
   591	
   592		if (!numvfs)
   593			return -EINVAL;
   594	
   595		pf->mbox_pfvf = devm_kcalloc(&pf->pdev->dev, numvfs,
   596					     sizeof(struct mbox), GFP_KERNEL);
   597		if (!pf->mbox_pfvf)
   598			return -ENOMEM;
   599	
   600		pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
   601						   WQ_UNBOUND | WQ_HIGHPRI |
   602						   WQ_MEM_RECLAIM, 0);
   603		if (!pf->mbox_pfvf_wq)
   604			return -ENOMEM;
   605	
   606		/* For CN20K, PF allocates mbox memory in DRAM and writes PF/VF
   607		 * regions/offsets in RVU_PF_VF_MBOX_ADDR, the RVU_PFX_FUNC_PFAF_MBOX
   608		 * gives the aliased address to access PF/VF mailbox regions.
   609		 */
   610		if (is_cn20k(pf->pdev)) {
 > 611			hwbase = cn20k_pfvf_mbox_alloc(pf, numvfs);
   612		} else {
   613			/* On CN10K platform, PF <-> VF mailbox region follows after
   614			 * PF <-> AF mailbox region.
   615			 */
   616			if (test_bit(CN10K_MBOX, &pf->hw.cap_flag))
   617				base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
   618							  MBOX_SIZE;
   619			else
   620				base = readq((void __iomem *)((u64)pf->reg_base +
   621						      RVU_PF_VF_BAR4_ADDR));
   622	
   623			hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
   624			if (!hwbase) {
   625				err = -ENOMEM;
   626				goto free_wq;
   627			}
   628		}
   629	
   630		mbox = &pf->mbox_pfvf[0];
   631		err = otx2_mbox_init(&mbox->mbox, hwbase, pf->pdev, pf->reg_base,
   632				     MBOX_DIR_PFVF, numvfs);
   633		if (err)
   634			goto free_iomem;
   635	
   636		err = otx2_mbox_init(&mbox->mbox_up, hwbase, pf->pdev, pf->reg_base,
   637				     MBOX_DIR_PFVF_UP, numvfs);
   638		if (err)
   639			goto free_iomem;
   640	
   641		for (vf = 0; vf < numvfs; vf++) {
   642			mbox->pfvf = pf;
   643			INIT_WORK(&mbox->mbox_wrk, otx2_pfvf_mbox_handler);
   644			INIT_WORK(&mbox->mbox_up_wrk, otx2_pfvf_mbox_up_handler);
   645			mbox++;
   646		}
   647	
   648		return 0;
   649	
   650	free_iomem:
   651		if (hwbase && !(is_cn20k(pf->pdev)))
   652			iounmap(hwbase);
   653	free_wq:
   654		destroy_workqueue(pf->mbox_pfvf_wq);
   655		return err;
   656	}
   657	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

