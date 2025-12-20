Return-Path: <netdev+bounces-245584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C47CD3115
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38BF300CB94
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9028726E;
	Sat, 20 Dec 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVoCy6g/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B486323;
	Sat, 20 Dec 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766241974; cv=none; b=LAtOU78934rEon1GOJKMMrjPo1q5qO64OdMQ4XMgiPejDDfjqAio1QFwdPN2cxS1FyUmGDV6s+HCFiNrB3ig5+NY8p4kxbDinvFlmH+xpObk2xGgtmeP57cYc4M2IW28ymCvqz3mKpsibyBFEMgc/kmaiC9HOexWQjvsylD3s1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766241974; c=relaxed/simple;
	bh=UP+3vEUF7U85lh8CDWWnepWIXgzJY4myXiUfJm8zV2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc/DokL6P7uGhWx92b3lkvyDbJok8C7/qXJuIT6nErJeN2rXD63pgRYbYqjOxqeEfmId6Ea3zJQg9KsMkGheWCk6KXcnAfiV96O0PE7NBBpdI+ewXqKkNWAp/E/BkFHn5TzITyQA8S0RXtLh9Kp0LaVkei5zYDZHU01mGQoKJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVoCy6g/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766241973; x=1797777973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UP+3vEUF7U85lh8CDWWnepWIXgzJY4myXiUfJm8zV2s=;
  b=LVoCy6g/5A+3fpRP4FwyCwbrklv5w7VQJTVz6xuxSRorcABD+91jcFHx
   NNyMIXZyIf1tZzQkIcI4jNHL2txRHHXtmxurydErwMKZZLv/ynvqVSKIG
   u/iQlFDNf7XnUbmO73A5HOA9UglKMQzTUGY4UaDhMQK8DQktBVYZGZfvO
   0ppEwpmM0LKoun/MHYTOiuMt089fqntCuEsk/7u53Q6LDgYfyvAPxIs3s
   7viyDrr+k3uMLdvzQb0tlRzAj12CzYx6kn4LDztQJIaXxqjWvxlk1fk4+
   AO5r79taiRIOg9Yz9bXkBTBCEpsU0JiKnMmNZbNZKgsTUMgcneMx4uHry
   w==;
X-CSE-ConnectionGUID: VHxtd1EaTUm2wYgHGOHYHA==
X-CSE-MsgGUID: SgKA70oWSqipfmQmu2RfTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="85760382"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="85760382"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 06:46:12 -0800
X-CSE-ConnectionGUID: yak2GO9KSF2zA4c9hT1E0Q==
X-CSE-MsgGUID: aS4qX4V9Q5a6cE9wDUbTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199024653"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Dec 2025 06:46:09 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyDf-000000004fr-1TO5;
	Sat, 20 Dec 2025 14:46:07 +0000
Date: Sat, 20 Dec 2025 22:45:46 +0800
From: kernel test robot <lkp@intel.com>
To: Weiming Shi <bestswngs@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH v2] net: skbuff: add usercopy region to
 skbuff_fclone_cache
Message-ID: <202512202238.ULq0lvo7-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.19-rc1 next-20251219]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weiming-Shi/net-skbuff-add-usercopy-region-to-skbuff_fclone_cache/20251216-021811
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251215180903.954968-2-bestswngs%40gmail.com
patch subject: [PATCH v2] net: skbuff: add usercopy region to skbuff_fclone_cache
config: i386-randconfig-003-20251216 (https://download.01.org/0day-ci/archive/20251220/202512202238.ULq0lvo7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202238.ULq0lvo7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202238.ULq0lvo7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:386,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/core/skbuff.c:37:
   net/core/skbuff.c: In function 'skb_init':
>> include/linux/stddef.h:8:14: error: passing argument 5 of 'kmem_cache_create_usercopy' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   net/core/skbuff.c:5164:49: note: in expansion of macro 'NULL'
    5164 |                                                 NULL);
         |                                                 ^~~~
   In file included from include/linux/mm.h:34,
                    from net/core/skbuff.c:40:
   include/linux/slab.h:408:41: note: expected 'unsigned int' but argument is of type 'void *'
     408 |                            unsigned int useroffset, unsigned int usersize,
         |                            ~~~~~~~~~~~~~^~~~~~~~~~
>> net/core/skbuff.c:5160:43: error: too few arguments to function 'kmem_cache_create_usercopy'
    5160 |         net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:406:1: note: declared here
     406 | kmem_cache_create_usercopy(const char *name, unsigned int size,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kmem_cache_create_usercopy +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

