Return-Path: <netdev+bounces-148310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA429E1162
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B4283650
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8051016;
	Tue,  3 Dec 2024 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2fDGJjL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE133CFC;
	Tue,  3 Dec 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193322; cv=none; b=kszlaWHi2Ty3WxnhgJ3c47c51w5Ro0Ukw/XeC8Dj2G0aLtQxecqvzewWNZNcBw3/tmP1rev+TQ+H/Uti9i2QGImGQPB53BR8dst1YOpfMZ7tWXFkh8nsk1KZZ0KYKzKslVmref1n5Su3Iy/jyaZVhTjy7s/ydWUDz/Z98LOfgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193322; c=relaxed/simple;
	bh=MD7yN6T570a3dTrpXRkAY3H7sEqAvs1BZRIMz5avi2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTc9Ztr29wo39Pp4q7B8gtHzGdxPh5t5ua0NH/hogl/fAoVouZqlNw/d6d+cEU0mozF48+HOkG9MqQefzVCbBVbnzZr1Fe6NDE016KtkXPUlewxa8EzDPJDtdh8Lt66Ow2s6ZuPifZh7HBfDFPR73MFuvq1HOUL3JIDZb/4maK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2fDGJjL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733193321; x=1764729321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MD7yN6T570a3dTrpXRkAY3H7sEqAvs1BZRIMz5avi2s=;
  b=H2fDGJjLTb/YrE52/JtJIZQIOBmOzjeEqY2XDMoOPY/GpQszJpG++Y3X
   6HURA6akQDbxW2FLxvNw49tJscOFGM1jWCPyQnhS9Qef5F5yLidiuX5qh
   VRNuPwBeryD0Fc24b1IorxNVPcgCN5ZoziXDOldHIU4owdUz2XUnC5uc3
   xXurgioPOsFKQ55qzdy6+MRxysN9RW8FL25/S3+WrD3ClVJOYgGPfgypU
   uwJBG9mTbWZ3E5h4ASgIwxAgu6wH02F6zOYtrhFJLLiAW9ZAzIXPykM5m
   2b/7oumKa8o3xOZYMGwWFeZCV4q8fd1XVxanA8/Xuh3W6DdQVYHwZ+Ldq
   Q==;
X-CSE-ConnectionGUID: tpBdG2xATf2fw6Q7b10v1g==
X-CSE-MsgGUID: cJocUw44SdSWaW6Gp8jVvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32742681"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32742681"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:35:20 -0800
X-CSE-ConnectionGUID: rZ042wZRS4uW9fxR0xbrVg==
X-CSE-MsgGUID: XovcL0hpRNSqVvKhJO9hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="130752458"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Dec 2024 18:35:17 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIks-0003Az-1x;
	Tue, 03 Dec 2024 02:35:14 +0000
Date: Tue, 3 Dec 2024 10:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <202412031010.o6gZQgE3-lkp@intel.com>
References: <20241202171222.62595-17-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-17-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e70140ba0d2b1a30467d4af6bcfe761327b9ec95]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241203-031134
base:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
patch link:    https://lore.kernel.org/r/20241202171222.62595-17-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free space
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241203/202412031010.o6gZQgE3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031010.o6gZQgE3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031010.o6gZQgE3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from include/cxl/cxl.h:8,
                    from drivers/net/ethernet/sfc/efx_cxl.c:12:
   drivers/net/ethernet/sfc/efx_cxl.c: In function 'efx_cxl_init':
>> drivers/net/ethernet/sfc/efx_cxl.c:117:34: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     117 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/linux/pci.h:2694:41: note: in expansion of macro 'dev_err'
    2694 | #define pci_err(pdev, fmt, arg...)      dev_err(&(pdev)->dev, fmt, ##arg)
         |                                         ^~~~~~~
   drivers/net/ethernet/sfc/efx_cxl.c:117:17: note: in expansion of macro 'pci_err'
     117 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                 ^~~~~~~
   drivers/net/ethernet/sfc/efx_cxl.c:117:67: note: format string is defined here
     117 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                                                                ~~~^
         |                                                                   |
         |                                                                   long long unsigned int
         |                                                                %u


vim +117 drivers/net/ethernet/sfc/efx_cxl.c

    20	
    21	int efx_cxl_init(struct efx_probe_data *probe_data)
    22	{
    23		struct efx_nic *efx = &probe_data->efx;
    24		DECLARE_BITMAP(expected, CXL_MAX_CAPS);
    25		DECLARE_BITMAP(found, CXL_MAX_CAPS);
    26		struct pci_dev *pci_dev;
    27		struct efx_cxl *cxl;
    28		struct resource res;
    29		resource_size_t max;
    30		u16 dvsec;
    31		int rc;
    32	
    33		pci_dev = efx->pci_dev;
    34		probe_data->cxl_pio_initialised = false;
    35	
    36		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    37						  CXL_DVSEC_PCIE_DEVICE);
    38		if (!dvsec)
    39			return 0;
    40	
    41		pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
    42	
    43		cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
    44		if (!cxl)
    45			return -ENOMEM;
    46	
    47		cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
    48		if (IS_ERR(cxl->cxlds)) {
    49			pci_err(pci_dev, "CXL accel device state failed");
    50			rc = -ENOMEM;
    51			goto err1;
    52		}
    53	
    54		cxl_set_dvsec(cxl->cxlds, dvsec);
    55		cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
    56	
    57		res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
    58		if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
    59			pci_err(pci_dev, "cxl_set_resource DPA failed\n");
    60			rc = -EINVAL;
    61			goto err2;
    62		}
    63	
    64		res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
    65		if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
    66			pci_err(pci_dev, "cxl_set_resource RAM failed\n");
    67			rc = -EINVAL;
    68			goto err2;
    69		}
    70	
    71		rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
    72		if (rc) {
    73			pci_err(pci_dev, "CXL accel setup regs failed");
    74			goto err2;
    75		}
    76	
    77		bitmap_clear(expected, 0, CXL_MAX_CAPS);
    78		bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
    79		bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
    80	
    81		if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
    82			pci_err(pci_dev,
    83				"CXL device capabilities found(%08lx) not as expected(%08lx)",
    84				*found, *expected);
    85			goto err2;
    86		}
    87	
    88		rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
    89		if (rc) {
    90			pci_err(pci_dev, "CXL request resource failed");
    91			goto err2;
    92		}
    93	
    94		/* We do not have the register about media status. Hardware design
    95		 * implies it is ready.
    96		 */
    97		cxl_set_media_ready(cxl->cxlds);
    98	
    99		cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
   100		if (IS_ERR(cxl->cxlmd)) {
   101			pci_err(pci_dev, "CXL accel memdev creation failed");
   102			rc = PTR_ERR(cxl->cxlmd);
   103			goto err3;
   104		}
   105	
   106		cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
   107						   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
   108						   &max);
   109	
   110		if (IS_ERR(cxl->cxlrd)) {
   111			pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
   112			rc = PTR_ERR(cxl->cxlrd);
   113			goto err3;
   114		}
   115	
   116		if (max < EFX_CTPIO_BUFFER_SIZE) {
 > 117			pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
   118				__func__, max, EFX_CTPIO_BUFFER_SIZE);
   119			rc = -ENOSPC;
   120			goto err3;
   121		}
   122	
   123		probe_data->cxl = cxl;
   124	
   125		return 0;
   126	
   127	err3:
   128		cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
   129	err2:
   130		kfree(cxl->cxlds);
   131	err1:
   132		kfree(cxl);
   133		return rc;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

