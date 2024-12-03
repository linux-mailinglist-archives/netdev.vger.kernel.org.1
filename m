Return-Path: <netdev+bounces-148426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8049E1824
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2101516667B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22C1E201D;
	Tue,  3 Dec 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fffq2SAs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F891E22E1;
	Tue,  3 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219126; cv=none; b=VhGrhkk1fPxyWX5G8Ey3e2a28kCfGSes3QyTXvKYNc6ASqB/I5vPA0CdMA7VnvcQi+QaC5ZnLDscpM9bARERfmiTkK8sdUENT4AB+vPWrN48O006SJH0vXlGuhgdl1cEiJqTlGOn3LS2FO7OZQaXRjEhgNYx6aKnVqfFsmJvd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219126; c=relaxed/simple;
	bh=zbvoUGnSNfCih1kEhklJgBJLXZz9g/QO4/mn1ZyxObw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9Mx4QNy8AsB01hF5xGx8jtRZKvsEg9rftyCZxBV1kOah3NiD6DKFH6AweuCNsdcTY9JdiA1WT1gXZeEcYop0iuvb9zWq+c/gQxO2iFb27i8gBoWvNHLoMfRBjED4c7KHSRO1z1KzPB10Jna404ZsGKKUYjmHvVSg9XD4EL8OvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fffq2SAs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733219125; x=1764755125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbvoUGnSNfCih1kEhklJgBJLXZz9g/QO4/mn1ZyxObw=;
  b=fffq2SAsU1ECiaypQ5OBBvnkyfdvT9gGI0wvanLn7e1BirhUHjL2qQZ7
   /TMbUqrQr+/0CpFNYEPVzQaEC1v0Gethz9qivhGgvAsTfjCk9ZgbwA97O
   lawdQPqLzE2KxUrWBC3eG6D4QX5v2NLOm8u5XKNUl9ifFi9uN4GIcb/Pa
   cNKWiLWAEG9Zb1DiRKEdO/SYX0Mp/iy9B6GllKwZVQvff8+jsJ4nnR69E
   R3mvvJgTx1Xz2ofno/LcQf+m+l5QiM8IsYB9QtA49s+wM6MG8yP3deQ/+
   OZTbRz/X7LhyhlWL4zGh3t4evD/ihha4f1iO1ewB+E3n2PqoPk5C4UGOe
   g==;
X-CSE-ConnectionGUID: ngNUJoMDSc2pdzJFM8Ux5Q==
X-CSE-MsgGUID: RZg2gOrGRryIVLWdwwOKrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44810932"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44810932"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:45:24 -0800
X-CSE-ConnectionGUID: hfSV4T6JSLqyadMoHxrH7A==
X-CSE-MsgGUID: k6GSCqcASzKLiz2AC487fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="94217652"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Dec 2024 01:45:21 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIPT4-0000Up-2j;
	Tue, 03 Dec 2024 09:45:18 +0000
Date: Tue, 3 Dec 2024 17:44:34 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 15/28] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <202412031722.5L3bVD47-lkp@intel.com>
References: <20241202171222.62595-16-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-16-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e70140ba0d2b1a30467d4af6bcfe761327b9ec95]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241203-031134
base:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
patch link:    https://lore.kernel.org/r/20241202171222.62595-16-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v6 15/28] cxl: define a driver interface for HPA free space enumeration
config: arm-randconfig-001-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031722.5L3bVD47-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031722.5L3bVD47-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031722.5L3bVD47-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/region.c:803: warning: Function parameter or struct member 'cxlmd' not described in 'cxl_get_hpa_freespace'
>> drivers/cxl/core/region.c:803: warning: Excess function parameter 'endpoint' description in 'cxl_get_hpa_freespace'


vim +803 drivers/cxl/core/region.c

   782	
   783	/**
   784	 * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
   785	 * @endpoint: an endpoint that is mapped by the returned decoder
   786	 * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
   787	 * @max_avail_contig: output parameter of max contiguous bytes available in the
   788	 *		      returned decoder
   789	 *
   790	 * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
   791	 * in (@max_avail_contig))' is a point in time snapshot. If by the time the
   792	 * caller goes to use this root decoder's capacity the capacity is reduced then
   793	 * caller needs to loop and retry.
   794	 *
   795	 * The returned root decoder has an elevated reference count that needs to be
   796	 * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
   797	 * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
   798	 * does not race.
   799	 */
   800	struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
   801						       unsigned long flags,
   802						       resource_size_t *max_avail_contig)
 > 803	{
   804		struct cxl_port *endpoint = cxlmd->endpoint;
   805		struct cxlrd_max_context ctx = {
   806			.host_bridge = endpoint->host_bridge,
   807			.flags = flags,
   808		};
   809		struct cxl_port *root_port;
   810		struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
   811	
   812		if (!is_cxl_endpoint(endpoint)) {
   813			dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
   814			return ERR_PTR(-EINVAL);
   815		}
   816	
   817		if (!root) {
   818			dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
   819			return ERR_PTR(-ENXIO);
   820		}
   821	
   822		root_port = &root->port;
   823		down_read(&cxl_region_rwsem);
   824		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
   825		up_read(&cxl_region_rwsem);
   826	
   827		if (!ctx.cxlrd)
   828			return ERR_PTR(-ENOMEM);
   829	
   830		*max_avail_contig = ctx.max_hpa;
   831		return ctx.cxlrd;
   832	}
   833	EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
   834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

