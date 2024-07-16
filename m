Return-Path: <netdev+bounces-111634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B96931E31
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3110B21EB8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35D17F7;
	Tue, 16 Jul 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcLeNty4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3A4A32;
	Tue, 16 Jul 2024 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091262; cv=none; b=Q3wrV7PqAX2GCk1+76+SoT+lc+4Vwd0oSfos1Ly60YG3RFQXJ60XMatYJS6HRzNYN9UuTeTbZVaBdW1H2pLt5CAM/lTZQ2YHlhY3D1ql257sLs4AH5+i3CFGYoSIit1lOf5hcWSwwXCfoqWmVvG5724qXSueP/lICy4yH7kLxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091262; c=relaxed/simple;
	bh=AlcLkl3ZckSTetDqtkbewgaIlrmC0fd1HpPyOnPIDOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpVPqVe7iCrlh3YDbvHd+bLgmVEf4hB12qktHNbyUuKaW84O8qkrtS2XxQc3lNXXD6lGoHczOXpfXQYaA+8RXP7kXNgD7OF0hppQnA81Kxbt3A/noe5yJA/BK+8SABhGxi7yOwgoYdIaU7X1dsusI2iXMv4AZd26EKZmHlz3m+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcLeNty4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721091261; x=1752627261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlcLkl3ZckSTetDqtkbewgaIlrmC0fd1HpPyOnPIDOY=;
  b=fcLeNty4gachm/QAf+C34YoA5aWRnQEdXL9M65DlntQxphUR0+uwE+S7
   GBJrFHw6b5W0cYoH7Q8ElXPyUdJmFR8Z10QXaK6M6emWUa0OF7Hv9R86n
   griNzwxMIyQsODnStNbF/KWeR/tzJQVhe16KL3pfcxagRCHZZ82o5o6SJ
   detH0otubmzxRLnTsIG+mcbUg6PaEcILdh7XcoRxGokcPzT4HoXQ4/bxe
   7ctPnTcwIgT/CmndfJ99SE2HfI361EPZxLt2URHyYoB3N36ogWcPPJsxf
   6uKMZvPYcdO2Bn/6T+9UyQkRFTVNkDDL7GOBh/UZBy6hcW/fZiYLiUX1+
   A==;
X-CSE-ConnectionGUID: 93vqPGZLQkyK+1RI9tBqrQ==
X-CSE-MsgGUID: 3Lq3RKmsSFmeiZZqV2jmHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18642260"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18642260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 17:54:20 -0700
X-CSE-ConnectionGUID: lF6M1kDsQcupE5CgB6cnNw==
X-CSE-MsgGUID: EmctZzIbRMavmTAEQvtPpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49900247"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2024 17:54:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTWSM-000eiJ-1i;
	Tue, 16 Jul 2024 00:54:14 +0000
Date: Tue, 16 Jul 2024 08:53:30 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	richard.hughes@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Message-ID: <202407160818.7GrterxM-lkp@intel.com>
References: <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172835.24757-10-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10 next-20240715]
[cannot apply to cxl/next cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20240716-015920
base:   linus/master
patch link:    https://lore.kernel.org/r/20240715172835.24757-10-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v2 09/15] cxl: define a driver interface for HPA free space enumaration
config: i386-buildonly-randconfig-004-20240716 (https://download.01.org/0day-ci/archive/20240716/202407160818.7GrterxM-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407160818.7GrterxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407160818.7GrterxM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/sfc/efx_cxl.c:17:
   drivers/net/ethernet/sfc/efx_cxl.h:11:9: warning: 'EFX_CXL_H' is used as a header guard here, followed by #define of a different macro [-Wheader-guard]
      11 | #ifndef EFX_CXL_H
         |         ^~~~~~~~~
   drivers/net/ethernet/sfc/efx_cxl.h:12:9: note: 'EFX_CLX_H' is defined here; did you mean 'EFX_CXL_H'?
      12 | #define EFX_CLX_H
         |         ^~~~~~~~~
         |         EFX_CXL_H
>> drivers/net/ethernet/sfc/efx_cxl.c:89:7: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
      88 |                 pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
         |                                                                        ~~~~
         |                                                                        %u
      89 |                                   max, EFX_CTPIO_BUFFER_SIZE);
         |                                   ^~~
   include/linux/pci.h:2683:67: note: expanded from macro 'pci_info'
    2683 | #define pci_info(pdev, fmt, arg...)     dev_info(&(pdev)->dev, fmt, ##arg)
         |                                                                ~~~    ^~~
   include/linux/dev_printk.h:160:67: note: expanded from macro 'dev_info'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +89 drivers/net/ethernet/sfc/efx_cxl.c

    15	
    16	#include "net_driver.h"
  > 17	#include "efx_cxl.h"
    18	
    19	#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
    20	
    21	void efx_cxl_init(struct efx_nic *efx)
    22	{
    23		struct pci_dev *pci_dev = efx->pci_dev;
    24		struct efx_cxl *cxl = efx->cxl;
    25		resource_size_t max = 0;
    26		struct resource res;
    27		u16 dvsec;
    28	
    29		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    30						  CXL_DVSEC_PCIE_DEVICE);
    31	
    32		if (!dvsec)
    33			return;
    34	
    35		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
    36	
    37		cxl->cxlds = cxl_accel_state_create(&pci_dev->dev,
    38						    CXL_ACCEL_DRIVER_CAP_HDM);
    39		if (IS_ERR(cxl->cxlds)) {
    40			pci_info(pci_dev, "CXL accel device state failed");
    41			return;
    42		}
    43	
    44		cxl_accel_set_dvsec(cxl->cxlds, dvsec);
    45		cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
    46	
    47		res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
    48		cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
    49	
    50		res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
    51		cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
    52	
    53		if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
    54			pci_info(pci_dev, "CXL accel setup regs failed");
    55			return;
    56		}
    57	
    58		if (cxl_accel_request_resource(cxl->cxlds, true))
    59			pci_info(pci_dev, "CXL accel resource request failed");
    60	
    61		if (!cxl_await_media_ready(cxl->cxlds)) {
    62			cxl_accel_set_media_ready(cxl->cxlds);
    63		} else {
    64			pci_info(pci_dev, "CXL accel media not active");
    65			return;
    66		}
    67	
    68		cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
    69		if (IS_ERR(cxl->cxlmd)) {
    70			pci_info(pci_dev, "CXL accel memdev creation failed");
    71			return;
    72		}
    73	
    74		cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
    75		if (IS_ERR(cxl->endpoint))
    76			pci_info(pci_dev, "CXL accel acquire endpoint failed");
    77	
    78		cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint, 1,
    79						    CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
    80						    &max);
    81	
    82		if (IS_ERR(cxl->cxlrd)) {
    83			pci_info(pci_dev, "CXL accel get HPA failed");
    84			goto out;
    85		}
    86	
    87		if (max < EFX_CTPIO_BUFFER_SIZE)
    88			pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
  > 89					  max, EFX_CTPIO_BUFFER_SIZE);
    90	out:
    91		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

