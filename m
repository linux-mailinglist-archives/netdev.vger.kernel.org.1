Return-Path: <netdev+bounces-139941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC59B4C06
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A60F1F21A89
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27282206E7A;
	Tue, 29 Oct 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jj1+odBE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068B206046
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211729; cv=none; b=XHGIgWD/cLGLY/RXttCkVCZ10UDuZlXcGZcOmo85VU+I8fmvueSBP6LP24MLoVIThy+h53fqnHlJZhqJMvx0ok5VbeHhBNGGotqCb+SPWGdbJZ2TtGbcMWR5+KUDBS1Ppy/yLkr0Lqdon2JsVHp1e+87SrMhTabWKVT1abuRKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211729; c=relaxed/simple;
	bh=hoP8lthClCTvY07np8MIZtNFmhg4zCIuure896N0Rr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQTkq5z90Qd7i4p/6maJ6zvnB50dO/YxYDDV8hDCQeQjZv6si009DIoESfOWwjclhuis7vSnDuzBOtOFq1I/iU0YMeV+HXIh6VuunQ5/ezRumE1ALbcBXUE9q6vSrOE5s3V3GtgpT2U7VBzF7dk2pF0f30njaNR4e3LDDqcJUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jj1+odBE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730211726; x=1761747726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoP8lthClCTvY07np8MIZtNFmhg4zCIuure896N0Rr8=;
  b=Jj1+odBEvhC0+QBc/8tzWBIivInnb3UdNR9OBaDzby6Hz3EZiGKhAjap
   83mOBlFrpqRSVJdOWob0XmfZws1aIE3EsePxuJgCTGg08z9sO6jGbAUTM
   BFp4XRmXxNjFwqdLD4vfo0Wl/Jfhq5Cyv/GFQwzL/QJCbDcYdhq+gAdVp
   /lnPsbw5ST3KkTTK4ehP052f79R8DalPzIPGivknWTeTDW0J29BPu3kRO
   j2+eCKkZxaAxWWqw+E278ZiFiccBOwZWtyhi39tAGZffQuuuLe+Bdv2Mn
   RbbCtzB64Cdvb6j5M6z8X1AT7jQtqfUWusgiAHccqo3fx4NIEEaDugbmc
   Q==;
X-CSE-ConnectionGUID: 5ZG06JKmQ2SdBRJPeWpUKw==
X-CSE-MsgGUID: SFEZr+7IQAqgUM1BL27gGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30064402"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="30064402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:22:06 -0700
X-CSE-ConnectionGUID: R8QBtoiFRQO/gRj97Ckz1w==
X-CSE-MsgGUID: +1QDqzUxTpGaxzpoCLWH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105305982"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Oct 2024 07:22:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5n6g-000dlN-1y;
	Tue, 29 Oct 2024 14:22:02 +0000
Date: Tue, 29 Oct 2024 22:21:22 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202410292232.sT4alx5x-lkp@intel.com>
References: <20241028213541.1529-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-13-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241029-095137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241028213541.1529-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241029/202410292232.sT4alx5x-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410292232.sT4alx5x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410292232.sT4alx5x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/homa/homa_pool.c: In function 'homa_pool_init':
>> net/homa/homa_pool.c:55:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      55 |         if (((__u64)region) & ~PAGE_MASK)
         |              ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +55 net/homa/homa_pool.c

2076aa7e789765 John Ousterhout 2024-10-28   40  
2076aa7e789765 John Ousterhout 2024-10-28   41  /**
2076aa7e789765 John Ousterhout 2024-10-28   42   * homa_pool_init() - Initialize a homa_pool; any previous contents of the
2076aa7e789765 John Ousterhout 2024-10-28   43   * objects are overwritten.
2076aa7e789765 John Ousterhout 2024-10-28   44   * @hsk:          Socket containing the pool to initialize.
2076aa7e789765 John Ousterhout 2024-10-28   45   * @region:       First byte of the memory region for the pool, allocated
2076aa7e789765 John Ousterhout 2024-10-28   46   *                by the application; must be page-aligned.
2076aa7e789765 John Ousterhout 2024-10-28   47   * @region_size:  Total number of bytes available at @buf_region.
2076aa7e789765 John Ousterhout 2024-10-28   48   * Return: Either zero (for success) or a negative errno for failure.
2076aa7e789765 John Ousterhout 2024-10-28   49   */
2076aa7e789765 John Ousterhout 2024-10-28   50  int homa_pool_init(struct homa_sock *hsk, void *region, __u64 region_size)
2076aa7e789765 John Ousterhout 2024-10-28   51  {
2076aa7e789765 John Ousterhout 2024-10-28   52  	struct homa_pool *pool = hsk->buffer_pool;
2076aa7e789765 John Ousterhout 2024-10-28   53  	int i, result;
2076aa7e789765 John Ousterhout 2024-10-28   54  
2076aa7e789765 John Ousterhout 2024-10-28  @55  	if (((__u64)region) & ~PAGE_MASK)
2076aa7e789765 John Ousterhout 2024-10-28   56  		return -EINVAL;
2076aa7e789765 John Ousterhout 2024-10-28   57  	pool->hsk = hsk;
2076aa7e789765 John Ousterhout 2024-10-28   58  	pool->region = (char *)region;
2076aa7e789765 John Ousterhout 2024-10-28   59  	pool->num_bpages = region_size >> HOMA_BPAGE_SHIFT;
2076aa7e789765 John Ousterhout 2024-10-28   60  	pool->descriptors = NULL;
2076aa7e789765 John Ousterhout 2024-10-28   61  	pool->cores = NULL;
2076aa7e789765 John Ousterhout 2024-10-28   62  	if (pool->num_bpages < MIN_POOL_SIZE) {
2076aa7e789765 John Ousterhout 2024-10-28   63  		result = -EINVAL;
2076aa7e789765 John Ousterhout 2024-10-28   64  		goto error;
2076aa7e789765 John Ousterhout 2024-10-28   65  	}
2076aa7e789765 John Ousterhout 2024-10-28   66  	pool->descriptors = kmalloc_array(pool->num_bpages,
2076aa7e789765 John Ousterhout 2024-10-28   67  					  sizeof(struct homa_bpage), GFP_ATOMIC);
2076aa7e789765 John Ousterhout 2024-10-28   68  	if (!pool->descriptors) {
2076aa7e789765 John Ousterhout 2024-10-28   69  		result = -ENOMEM;
2076aa7e789765 John Ousterhout 2024-10-28   70  		goto error;
2076aa7e789765 John Ousterhout 2024-10-28   71  	}
2076aa7e789765 John Ousterhout 2024-10-28   72  	for (i = 0; i < pool->num_bpages; i++) {
2076aa7e789765 John Ousterhout 2024-10-28   73  		struct homa_bpage *bp = &pool->descriptors[i];
2076aa7e789765 John Ousterhout 2024-10-28   74  
2076aa7e789765 John Ousterhout 2024-10-28   75  		spin_lock_init(&bp->lock);
2076aa7e789765 John Ousterhout 2024-10-28   76  		atomic_set(&bp->refs, 0);
2076aa7e789765 John Ousterhout 2024-10-28   77  		bp->owner = -1;
2076aa7e789765 John Ousterhout 2024-10-28   78  		bp->expiration = 0;
2076aa7e789765 John Ousterhout 2024-10-28   79  	}
2076aa7e789765 John Ousterhout 2024-10-28   80  	atomic_set(&pool->free_bpages, pool->num_bpages);
2076aa7e789765 John Ousterhout 2024-10-28   81  	pool->bpages_needed = INT_MAX;
2076aa7e789765 John Ousterhout 2024-10-28   82  
2076aa7e789765 John Ousterhout 2024-10-28   83  	/* Allocate and initialize core-specific data. */
2076aa7e789765 John Ousterhout 2024-10-28   84  	pool->cores = kmalloc_array(nr_cpu_ids, sizeof(struct homa_pool_core),
2076aa7e789765 John Ousterhout 2024-10-28   85  				    GFP_ATOMIC);
2076aa7e789765 John Ousterhout 2024-10-28   86  	if (!pool->cores) {
2076aa7e789765 John Ousterhout 2024-10-28   87  		result = -ENOMEM;
2076aa7e789765 John Ousterhout 2024-10-28   88  		goto error;
2076aa7e789765 John Ousterhout 2024-10-28   89  	}
2076aa7e789765 John Ousterhout 2024-10-28   90  	pool->num_cores = nr_cpu_ids;
2076aa7e789765 John Ousterhout 2024-10-28   91  	for (i = 0; i < pool->num_cores; i++) {
2076aa7e789765 John Ousterhout 2024-10-28   92  		pool->cores[i].page_hint = 0;
2076aa7e789765 John Ousterhout 2024-10-28   93  		pool->cores[i].allocated = 0;
2076aa7e789765 John Ousterhout 2024-10-28   94  		pool->cores[i].next_candidate = 0;
2076aa7e789765 John Ousterhout 2024-10-28   95  	}
2076aa7e789765 John Ousterhout 2024-10-28   96  	pool->check_waiting_invoked = 0;
2076aa7e789765 John Ousterhout 2024-10-28   97  
2076aa7e789765 John Ousterhout 2024-10-28   98  	return 0;
2076aa7e789765 John Ousterhout 2024-10-28   99  
2076aa7e789765 John Ousterhout 2024-10-28  100  error:
2076aa7e789765 John Ousterhout 2024-10-28  101  	kfree(pool->descriptors);
2076aa7e789765 John Ousterhout 2024-10-28  102  	kfree(pool->cores);
2076aa7e789765 John Ousterhout 2024-10-28  103  	pool->region = NULL;
2076aa7e789765 John Ousterhout 2024-10-28  104  	return result;
2076aa7e789765 John Ousterhout 2024-10-28  105  }
2076aa7e789765 John Ousterhout 2024-10-28  106  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

