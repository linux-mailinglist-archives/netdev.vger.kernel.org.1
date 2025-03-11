Return-Path: <netdev+bounces-173998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AEBA5CF10
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4746E17AE76
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF22512D1;
	Tue, 11 Mar 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdPLpmx+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC7224AEF;
	Tue, 11 Mar 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720373; cv=none; b=hQIxVCPXTK73xCQgsUVyGu6sC+bjS+IOihbhVGt6qCcdkSO3HDAJlHlSzhk8kWYd+tNtam4tnyt4LyRzpcA4CQS3tsDvvziF7wHzbjZA6PNtMlfQPhx0zAMhj4+tIV0TOpa/WCPIZNLMWatumIjkoKuU2vtZMFmAOwNoW8gObas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720373; c=relaxed/simple;
	bh=xrRDKOf2+PF6EATz3wS7Q0fED9bKXNaY1L719rEfo0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMNt9+4mPbG1dtM5ohicLI7ig6VLX3Ocf7MLA5c876ktq4IqTBY2PF+6VTnUD5Zf42Jz94XCGRIx2/KZWl/am585gOYIOB+RBrKhuT6NzKFgI1NB09bTZgPqL5863vXALzAvdsVLOXcTd11SehK7zQWfLBDSMvhmmWH7y6e7zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdPLpmx+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741720371; x=1773256371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xrRDKOf2+PF6EATz3wS7Q0fED9bKXNaY1L719rEfo0c=;
  b=SdPLpmx+C7lBkYTdQMN3PRUoQHSlEkHISvSvUUy5FJ96NrZ3KxJDQ6nG
   uvK/wdP84vmjam2yzUccfTXWe9/93zFCNEeK9g17T2LYshYWF1sZP7rQJ
   b4WjdEkFwYD1AdPZFksWFz026q/ESzmV2fHIEiv9G7OtA/Zv/mhkwmWXm
   jrgNK7N+saZWL9x1RMyxLJ2rYAMbkKN3ySBLRdsxrWyNfIWQZSQELjl55
   6bHylH1mg6e9uPb4CtO1JBANr7pIGMP7hUXam58933BpM2r1qdlwMbxSP
   aP17cf2Ti6vRGIKkQOMpRBARJCRdF4u+BoYT4VK2hbd0VsnNawaW7TVw/
   w==;
X-CSE-ConnectionGUID: 2qQL8lX2Q6Oa8GSD+EvS9A==
X-CSE-MsgGUID: fWbPvBuoQeqRcNAo4bAH9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46688935"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46688935"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:12:50 -0700
X-CSE-ConnectionGUID: tz4UNyw6T1iQm4SaMak9zQ==
X-CSE-MsgGUID: xSaGxqUOSry0JVKvRFLkkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="143605116"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2025 12:12:48 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts51x-0007lM-20;
	Tue, 11 Mar 2025 19:12:45 +0000
Date: Wed, 12 Mar 2025 03:12:08 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
Message-ID: <202503120207.vNlP2uB3-lkp@intel.com>
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
config: csky-randconfig-002-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120207.vNlP2uB3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120207.vNlP2uB3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120207.vNlP2uB3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/hdm.c:6:
>> include/cxl/cxl.h:150:22: error: field 'dpa_range' has incomplete type
     150 |         struct range dpa_range;
         |                      ^~~~~~~~~
>> include/cxl/cxl.h:221:30: error: field 'range' has incomplete type
     221 |                 struct range range;
         |                              ^~~~~


vim +/dpa_range +150 include/cxl/cxl.h

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
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  156  enum cxl_partition_mode {
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  157  	CXL_PARTMODE_RAM,
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  158  	CXL_PARTMODE_PMEM,
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  159  };
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  160  
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  161  /**
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  162   * struct cxl_dpa_partition - DPA partition descriptor
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  163   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  164   * @perf: performance attributes of the partition from CDAT
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  165   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  166   */
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  167  struct cxl_dpa_partition {
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  168  	struct resource res;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  169  	struct cxl_dpa_perf perf;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  170  	enum cxl_partition_mode mode;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  171  };
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  172  
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  173  #define CXL_NR_PARTITIONS_MAX 2
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  174  
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  175  /**
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  176   * struct cxl_dev_state - The driver device state
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  177   *
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  178   * cxl_dev_state represents the CXL driver/device state.  It provides an
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  179   * interface to mailbox commands as well as some cached data about the device.
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  180   * Currently only memory devices are represented.
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  181   *
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  182   * @dev: The device associated with this CXL state
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  183   * @cxlmd: The device representing the CXL.mem capabilities of @dev
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  184   * @reg_map: component and ras register mapping parameters
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  185   * @regs: Parsed register blocks
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  186   * @cxl_dvsec: Offset to the PCIe device DVSEC
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  187   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  188   * @media_ready: Indicate whether the device media is usable
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  189   * @dpa_res: Overall DPA resource tree for the device
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  190   * @part: DPA partition array
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  191   * @nr_partitions: Number of DPA partitions
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  192   * @serial: PCIe Device Serial Number
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  193   * @type: Generic Memory Class device or Vendor Specific Memory device
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  194   * @cxl_mbox: CXL mailbox context
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  195   * @cxlfs: CXL features context
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  196   */
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  197  struct cxl_dev_state {
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  198  	struct device *dev;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  199  	struct cxl_memdev *cxlmd;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  200  	struct cxl_register_map reg_map;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  201  	struct cxl_regs regs;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  202  	int cxl_dvsec;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  203  	bool rcd;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  204  	bool media_ready;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  205  	struct resource dpa_res;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  206  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  207  	unsigned int nr_partitions;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  208  	u64 serial;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  209  	enum cxl_devtype type;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  210  	struct cxl_mailbox cxl_mbox;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  211  #ifdef CONFIG_CXL_FEATURES
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  212  	struct cxl_features_state *cxlfs;
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  213  #endif
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  214  };
98e0e4ae7d20491 Alejandro Lucero 2025-03-10  215  
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  216  #define CXL_NR_PARTITIONS_MAX 2
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  217  
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  218  struct cxl_dpa_info {
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  219  	u64 size;
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  220  	struct cxl_dpa_part_info {
fe6f26dd4c64059 Alejandro Lucero 2025-03-10 @221  		struct range range;
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  222  		enum cxl_partition_mode mode;
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  223  	} part[CXL_NR_PARTITIONS_MAX];
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  224  	int nr_partitions;
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  225  };
fe6f26dd4c64059 Alejandro Lucero 2025-03-10  226  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

