Return-Path: <netdev+bounces-145654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63689D04C2
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC44B214A9
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE21DA62E;
	Sun, 17 Nov 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcBKTeXK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCA1DA612
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731863589; cv=none; b=AeZj6ly0F7UT3uPEA9SwzddyJXf6otRp1I4SBCNIRnTfLjJShvbADM+GZ2pe/nqCemoDBfrxleirR/iXgxdOFo8aV6PC2TzocmYCOBduwFajMnua8dTNK1zkkV55sxVztl6AkLAbSf3zBGgtsTapjhoLS2KWcLSR0+9/DR6lzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731863589; c=relaxed/simple;
	bh=lbsFeaUaRUJRYWnU0A4T73UMxzZguTkekHdG7GjLD+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1eBVJ+PLABV1Gupjyf12q3HHzRq4mHoBNKFpFAhqV9CnLQwmvZCsCB4W9v1vnJVNYAVafgZdRv1aCFL4WMuwVFrEeP+hgzk7e65VfTOcCKTyT9qpg80A2XNNLt3zfBHlBLdpyvQVdLVhOPBkrLPnww0UPDBlB601FYXbGjUzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcBKTeXK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731863588; x=1763399588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbsFeaUaRUJRYWnU0A4T73UMxzZguTkekHdG7GjLD+8=;
  b=QcBKTeXKi/eCYYAsWXrq4eNgy4wrxpQjddU1EMIyOp8bYvFa7ukDaeCn
   1VMDuyITKM1NOsSpHOQOBHeS1bh358M2TJKa/XTNsseToA9eJTXGwNgYn
   3mrY4n8IojEO3yaZqZAWqu+fe3snCJuoxYQsHnpAOZNmU2j/8H9tFGvRm
   HyLLhUV3tSbqv0aC5bLxRPPsOan1N+AYiqQMd3F9gINyIqvftxzGcu51m
   JpQABjMIyOlTExrpAtWI45ft5qfxx8qSihjuWojv9pKtkgE7D/AzGD118
   XlThYcJQirybczkdyWitsKyA1mIxvsCFeMfkL3EqEVjL4yQgQvXs9wgs3
   w==;
X-CSE-ConnectionGUID: YUQXWZciQjOp3hjYrhhsVg==
X-CSE-MsgGUID: 8Dsj3SdgRUS6xTAI+UBiHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49345815"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="49345815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 09:13:07 -0800
X-CSE-ConnectionGUID: cjAj1H90RvyJBTLZNqa5IA==
X-CSE-MsgGUID: zUIs76UCRVW83V0Sk0drfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="93472966"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Nov 2024 09:13:00 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCipV-0001xl-2O;
	Sun, 17 Nov 2024 17:12:57 +0000
Date: Mon, 18 Nov 2024 01:12:25 +0800
From: kernel test robot <lkp@intel.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?unknown-8bit?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 11/21] scsi: arcmsr: Convert timeouts to
 secs_to_jiffies()
Message-ID: <202411180001.cZ0sTVB8-lkp@intel.com>
References: <20241115-converge-secs-to-jiffies-v2-11-911fb7595e79@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-11-911fb7595e79@linux.microsoft.com>

Hi Easwar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Easwar-Hariharan/netfilter-conntrack-Cleanup-timeout-definitions/20241117-003530
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-11-911fb7595e79%40linux.microsoft.com
patch subject: [PATCH v2 11/21] scsi: arcmsr: Convert timeouts to secs_to_jiffies()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241118/202411180001.cZ0sTVB8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180001.cZ0sTVB8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180001.cZ0sTVB8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/arcmsr/arcmsr_hba.c:56:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/arcmsr/arcmsr_hba.c:1047:42: error: call to undeclared function 'secs_to_jiffies'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1047 |         pacb->refresh_timer.expires = jiffies + secs_to_jiffies(60);
         |                                                 ^
   drivers/scsi/arcmsr/arcmsr_hba.c:1057:34: warning: shift count >= width of type [-Wshift-count-overflow]
    1057 |                     dma_set_mask(&pcidev->dev, DMA_BIT_MASK(64)))
         |                                                ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/scsi/arcmsr/arcmsr_hba.c:1061:43: warning: shift count >= width of type [-Wshift-count-overflow]
    1061 |                 if (dma_set_coherent_mask(&pcidev->dev, DMA_BIT_MASK(64)) ||
         |                                                         ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/scsi/arcmsr/arcmsr_hba.c:1062:47: warning: shift count >= width of type [-Wshift-count-overflow]
    1062 |                     dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64))) {
         |                                                             ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   7 warnings and 1 error generated.


vim +/secs_to_jiffies +1047 drivers/scsi/arcmsr/arcmsr_hba.c

  1043	
  1044	static void arcmsr_init_set_datetime_timer(struct AdapterControlBlock *pacb)
  1045	{
  1046		timer_setup(&pacb->refresh_timer, arcmsr_set_iop_datetime, 0);
> 1047		pacb->refresh_timer.expires = jiffies + secs_to_jiffies(60);
  1048		add_timer(&pacb->refresh_timer);
  1049	}
  1050	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

