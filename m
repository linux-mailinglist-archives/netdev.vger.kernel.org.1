Return-Path: <netdev+bounces-245595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72ACD3283
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467963011EE4
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01272BD597;
	Sat, 20 Dec 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H86VXIe2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848E27E1D7;
	Sat, 20 Dec 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766246245; cv=none; b=JTNzgggbyatAoQUlXthnt0BB+CN2l1/jbmaRcBG+H90JwtJlRCqBV4yGHDLoQJnMWijrP+tVYqroY810X7EIKcCARxJJYvziJ5rxRteFF4OndZ4CcL9HvbaSv/sUfB5BaiJwMpyaDyhA4triY+rTGJkcNjl/D6eIx5jzHee6JG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766246245; c=relaxed/simple;
	bh=WfuXL9MxQrDXB1XrFT8GW1/JYSrUNrkGTTS/9rOpJPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu5PHZL/DXcKVPar+lMcLNVdvLHlosmoEcyE+Uci6zuN6Fln5U4IbSUPnDkExGp/wyjHeHzzfvHo7hERLR4VKF70c2xPlu0fFfZOHS6BklqVoVZRqM2mSMFuV9GtL3U5/HFQ1OzX/zBMFj6SE0Uxc1Mh/AZrv+luBQ+aOZ14SDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H86VXIe2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766246244; x=1797782244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WfuXL9MxQrDXB1XrFT8GW1/JYSrUNrkGTTS/9rOpJPQ=;
  b=H86VXIe27w1omfKpYLyxUkMFCiOSy1J9DG5Z+RTCescdwREvqlP3RHoR
   fKycvTq9HDmaDWSggzUe8TPmata0K6MdtHVonhuzex71rfD6niOXNOCUW
   nu1tddzVMQ3mgT1E+Prf62OsxnBEelsznsC3HI1XorB5HDK6QK+drsIds
   s/YM78JQtRd8YoD+FVYrKbRa9yuaPu+UfKue8AgoSCns44UPmMYqBQOzD
   4zydK5+rOcOVOxvOqGv/F4n3aHzcAARo9jpuMsOR0q6jVtdh0LDG8KGfB
   b6Et9X/QWgr2YOFE2Y3YIWZTG8MJE0xhlJOnpJsYoKb9/9fftDMxzpDF1
   Q==;
X-CSE-ConnectionGUID: xgsOKcWhTsSCToek3/gxUA==
X-CSE-MsgGUID: Uven657OTB6eQf2kd3fFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="70748099"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="70748099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:57:23 -0800
X-CSE-ConnectionGUID: MwGbUAuDQkCUtCZF5ZcgsQ==
X-CSE-MsgGUID: wVRmyF8jSw6V81iZoY1mwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199642890"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Dec 2025 07:57:21 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWzKY-000000004nw-2nil;
	Sat, 20 Dec 2025 15:57:18 +0000
Date: Sat, 20 Dec 2025 23:57:02 +0800
From: kernel test robot <lkp@intel.com>
To: Weiming Shi <bestswngs@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH v2] net: skbuff: add usercopy region to
 skbuff_fclone_cache
Message-ID: <202512202310.PGCBLw9b-lkp@intel.com>
References: <20251215180903.954968-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215180903.954968-2-bestswngs@gmail.com>

Hi Weiming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.19-rc1 next-20251219]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weiming-Shi/net-skbuff-add-usercopy-region-to-skbuff_fclone_cache/20251216-021811
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251215180903.954968-2-bestswngs%40gmail.com
patch subject: [PATCH v2] net: skbuff: add usercopy region to skbuff_fclone_cache
config: arm-randconfig-r073-20251216 (https://download.01.org/0day-ci/archive/20251220/202512202310.PGCBLw9b-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202310.PGCBLw9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202310.PGCBLw9b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:386,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/core/skbuff.c:37:
   net/core/skbuff.c: In function 'skb_init':
>> include/linux/stddef.h:8:14: warning: passing argument 5 of 'kmem_cache_create_usercopy' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   net/core/skbuff.c:5164:7: note: in expansion of macro 'NULL'
    5164 |       NULL);
         |       ^~~~
   In file included from arch/arm/include/asm/pgtable-nommu.h:13,
                    from arch/arm/include/asm/pgtable.h:25,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:31,
                    from net/core/skbuff.c:40:
   include/linux/slab.h:408:20: note: expected 'unsigned int' but argument is of type 'void *'
     408 |       unsigned int useroffset, unsigned int usersize,
         |       ~~~~~~~~~~~~~^~~~~~~~~~
   net/core/skbuff.c:5160:36: error: too few arguments to function 'kmem_cache_create_usercopy'
    5160 |  net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/pgtable-nommu.h:13,
                    from arch/arm/include/asm/pgtable.h:25,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:31,
                    from net/core/skbuff.c:40:
   include/linux/slab.h:406:1: note: declared here
     406 | kmem_cache_create_usercopy(const char *name, unsigned int size,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CAN_DEV
   Depends on [n]: NETDEVICES [=n] && CAN [=y]
   Selected by [y]:
   - CAN [=y] && NET [=y]


vim +/kmem_cache_create_usercopy +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

