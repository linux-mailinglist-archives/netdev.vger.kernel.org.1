Return-Path: <netdev+bounces-201354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA82AE9204
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BF7B702A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2382F433F;
	Wed, 25 Jun 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRLpBRrp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8152F4326;
	Wed, 25 Jun 2025 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893286; cv=none; b=NVGC+T6Bugw5Bzay/md20v/2wRukEkj4QR1eEVMHy91rPOnXQU8WM9vvqkQ+Vd9jebMOwNZuSkuNZZeLrrLQYwysFnH8ETM8Ck2nIndf5g5oGVIwe9B3zrtSZzx8xeSmWHpMRUKvAFYcS4gtQnAXRp9oXBL3Hwpu7riFoAvnlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893286; c=relaxed/simple;
	bh=q+Xgk6gY7XYxDUH0slZtZV1r6bW0xVVA1X7mSXJHpKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr3kUniIxdSTbgLbQJW0P4CSf86/u+QCF860xKsX3hkw89sKfsnVj6PC/0ho/Zhibnt9PT4Ids4iTPiVCNPcSSag90MGdsNzcx4yu4TKWPgPUcC7TuSwsRG5NdBtYTIiUUNGiB+6keIBq6IHlNk8hAU/yKgnG2FKwhI+DfWIZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRLpBRrp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750893284; x=1782429284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+Xgk6gY7XYxDUH0slZtZV1r6bW0xVVA1X7mSXJHpKA=;
  b=jRLpBRrpOFLwacBmxvo8gnb9n+sva/YNn6hHhoBamIAOHVrrZ5IW2zhs
   62EtMI3g6kDuDPg5bioH2qRJ8cuhw/RDDA01QBOimGmh0lVTydPgG64EZ
   nWmUDlptGjqYChLqfWzPiOvcAjPXjNag0G+GJiZ+vuGwSXJZLuJeq5oDt
   57kYmLzjF1c9sL72kO5KAZJYRJAJ6iDhOTBQWuIvYNpne6sYi1dDlvinw
   Mh/6mTOqkH8wo9itzdiJgLp0s3cD2Xnnwv5h8d6FhIP0Paj4S/N6HYjmA
   3er50gSu4B6x7MO1AiUSNV4k0FnKOtY6yqYlF3/vUULOeri0ENkRGMgJ8
   g==;
X-CSE-ConnectionGUID: gS8cdfx3SLq2S9BlQTolug==
X-CSE-MsgGUID: y79klQh9T7+g9wKIXsHIjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64534621"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64534621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 16:14:43 -0700
X-CSE-ConnectionGUID: wzR4hzHxQJWM2Z80q5tYIw==
X-CSE-MsgGUID: nGIuA4g5T4+jfVIKBXXyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="158107202"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2025 16:14:40 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUZKA-000TW6-05;
	Wed, 25 Jun 2025 23:14:38 +0000
Date: Thu, 26 Jun 2025 07:14:01 +0800
From: kernel test robot <lkp@intel.com>
To: Wen Gu <guwen@linux.alibaba.com>, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	guwen@linux.alibaba.com
Subject: Re: [PATCH net-next] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <202506260725.kFmPHRIJ-lkp@intel.com>
References: <20250625132549.93614-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625132549.93614-1-guwen@linux.alibaba.com>

Hi Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/ptp-add-Alibaba-CIPU-PTP-clock-driver/20250625-212835
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250625132549.93614-1-guwen%40linux.alibaba.com
patch subject: [PATCH net-next] ptp: add Alibaba CIPU PTP clock driver
config: x86_64-buildonly-randconfig-002-20250626 (https://download.01.org/0day-ci/archive/20250626/202506260725.kFmPHRIJ-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506260725.kFmPHRIJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506260725.kFmPHRIJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ptp/ptp_cipu.c:775:8: error: call to undeclared function 'pci_request_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     775 |                 rc = pci_request_irq(pdev, i, irq_ctx[i].irq_func, NULL,
         |                      ^
   drivers/ptp/ptp_cipu.c:775:8: note: did you mean 'pci_request_acs'?
   include/linux/pci.h:2570:6: note: 'pci_request_acs' declared here
    2570 | void pci_request_acs(void);
         |      ^
>> drivers/ptp/ptp_cipu.c:784:3: error: call to undeclared function 'pci_free_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     784 |                 pci_free_irq(pdev, i, ptp_ctx);
         |                 ^
>> drivers/ptp/ptp_cipu.c:785:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     785 |         pci_free_irq_vectors(pdev);
         |         ^
   drivers/ptp/ptp_cipu.c:785:2: note: did you mean 'pci_alloc_irq_vectors'?
   include/linux/pci.h:2139:1: note: 'pci_alloc_irq_vectors' declared here
    2139 | pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
         | ^
   drivers/ptp/ptp_cipu.c:796:3: error: call to undeclared function 'pci_free_irq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     796 |                 pci_free_irq(pdev, i, ptp_ctx);
         |                 ^
   drivers/ptp/ptp_cipu.c:797:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     797 |         pci_free_irq_vectors(pdev);
         |         ^
   5 errors generated.


vim +/pci_request_irq +775 drivers/ptp/ptp_cipu.c

   763	
   764	static int ptp_cipu_init_irq(struct ptp_cipu_ctx *ptp_ctx)
   765	{
   766		struct pci_dev *pdev = ptp_ctx->pdev;
   767		int i, rc;
   768	
   769		rc = pci_alloc_irq_vectors(pdev, PTP_CIPU_IRQ_NUM,
   770					   PTP_CIPU_IRQ_NUM, PCI_IRQ_MSIX);
   771		if (rc < 0)
   772			goto out;
   773	
   774		for (i = 0; i < PTP_CIPU_IRQ_NUM; i++) {
 > 775			rc = pci_request_irq(pdev, i, irq_ctx[i].irq_func, NULL,
   776					     ptp_ctx, "ptp-cipu");
   777			if (rc)
   778				goto out_vec;
   779		}
   780		return 0;
   781	
   782	out_vec:
   783		for (i = i - 1; i >= 0; i--)
 > 784			pci_free_irq(pdev, i, ptp_ctx);
 > 785		pci_free_irq_vectors(pdev);
   786	out:
   787		return rc;
   788	}
   789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

