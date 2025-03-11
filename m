Return-Path: <netdev+bounces-174024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E86A5D0A3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E51D3B805C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB82620F9;
	Tue, 11 Mar 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHC0uFHm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BC1CAA87;
	Tue, 11 Mar 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724278; cv=none; b=asyUGsMFpAbWdtXHN1AK4G5Ctc2qhHT6z6AAaktkI//XW4dsIUS06PbUK57QjdxOK0XaM5ida77mnPF9WUPqHIEzc5fBHQT3M+5RYl3E8DAJIeHhxcSS9yAOgAroHJy+a7hhES61SANhMLTegXDdKPOWAY5USwQr+LI1Ilpc/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724278; c=relaxed/simple;
	bh=SJ+r1K/9xVmseIN4+wmfwDwo5gzOyZW7rOa8gJ4OLLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAESLmViz3uzRcLQr35UsOh/KcvurVUhebJfn+wGW8p/M8SS69rDuilq6NzM7/XF4zD9Tvw7YcrjBkkDRvsjmw+i4+R8KLVfznNjOUVvIeIwekT2MJYplGk8a+hGsDw0acXvvnVCC2SOArvjZRNVKeL2UoGZPD3C7ziAoaOB/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHC0uFHm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741724276; x=1773260276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJ+r1K/9xVmseIN4+wmfwDwo5gzOyZW7rOa8gJ4OLLE=;
  b=jHC0uFHm4fN0v/VQWiacZyZ6AOpzbVMI9IqGrDh4wtx4Q5cZvNlDJ98H
   7vu9pZjeMoPY36UYYDemzoNjkTmG9/qhDR7NheHulC4V5O5rI/dbZHse/
   /QyHhH0LbHY7pxhk4ukYmvK+qQl0S4fW4lQmOlc7YCXwoXXePhUkfxcEm
   cl9tq8RXix6u/sq/E6Od3ziGUvVaTpRnHwuVPEXtHnZF5gwewItxpO1dD
   eaONF5Fhf4Rt0UJb6C5Sr5+G+2BHQx3lanJ0jJVu91kNkDJ0P8iJhCIWd
   959Y3yVro6veBu63BJSQrNt0aBm2xCKXdHx+NH/mEtRH2mmYRBKQZN/TU
   w==;
X-CSE-ConnectionGUID: SpAwkmUISy20SSGD5h6BHA==
X-CSE-MsgGUID: bGVl2RFkQumluqQ0NGJYwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46564402"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="46564402"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 13:17:55 -0700
X-CSE-ConnectionGUID: wbetF/2WQCy4tTpvOWNMBA==
X-CSE-MsgGUID: TYVsTxWtQ5GBoKd0yrHxlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125619688"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 11 Mar 2025 13:17:52 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts62w-0007oW-08;
	Tue, 11 Mar 2025 20:17:50 +0000
Date: Wed, 12 Mar 2025 04:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
Message-ID: <202503120331.TSbIvphi-lkp@intel.com>
References: <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a14566be090ca51a32ebdd8a8e21678062dac08]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20250311-050914
base:   0a14566be090ca51a32ebdd8a8e21678062dac08
patch link:    https://lore.kernel.org/r/20250310210340.3234884-14-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v11 13/23] cxl: define a driver interface for DPA allocation
config: arm64-randconfig-001-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120331.TSbIvphi-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120331.TSbIvphi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120331.TSbIvphi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/hdm.c:6:
>> include/cxl/cxl.h:150:15: error: field has incomplete type 'struct range'
     150 |         struct range dpa_range;
         |                      ^
   include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
     247 | struct range arch_get_mappable_range(void);
         |        ^
   In file included from drivers/cxl/core/hdm.c:6:
   include/cxl/cxl.h:221:16: error: field has incomplete type 'struct range'
     221 |                 struct range range;
         |                              ^
   include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
     247 | struct range arch_get_mappable_range(void);
         |        ^
   In file included from drivers/cxl/core/hdm.c:8:
   In file included from drivers/cxl/cxlmem.h:6:
   In file included from include/linux/pci.h:1660:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2224:
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
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 2 errors generated.


vim +150 include/cxl/cxl.h

98e0e4ae7d20491 Alejandro Lucero 2025-03-10  141  
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  142  /**
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  143   * struct cxl_dpa_perf - DPA performance property entry
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  144   * @dpa_range: range for DPA address
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  145   * @coord: QoS performance data (i.e. latency, bandwidth)
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  146   * @cdat_coord: raw QoS performance data from CDAT
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  147   * @qos_class: QoS Class cookies
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  148   */
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  149  struct cxl_dpa_perf {
98e0e4ae7d20491 Alejandro Lucero 2025-03-10 @150  	struct range dpa_range;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  151  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  152  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  153  	int qos_class;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  154  };
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  155  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

