Return-Path: <netdev+bounces-122537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3419619FC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EF82846ED
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01261D2F6E;
	Tue, 27 Aug 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5KS/wZG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2E84D34
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797403; cv=none; b=mOHzPR4RUqSQ/bCxjXzbhmfK3FsKBq7vxZn3/NXFmkJjKnlp5qs2nnGFsPYOPlHDg0PUo7Savn1XDj3DlgaQitx25y1evcWQM56Pyipd7dXQt1x9l1OctJYxwOBU3HpuO+AYRIkPLuInhbBU4Cp+fFw6FqJ01syey6r8BqW0Pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797403; c=relaxed/simple;
	bh=ItqJNfn3hlKuY1giqmucMmbfP7TZmqrlAw07jjbs07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbus/WaiiKBD2B6HzjjGdM3vmePWcj9+McUkIswuwReUExdQ46fMZdiGFwOVEn5A79tI54cEwZMLmhY9LscY5TWO0xYpfPglXOt+jR/fo44Hzfq9sBN8R69VeS/0Hz7RQixK5WnRTd4c0K39lspu8krz+l4hDCYq0cb1qOVqXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5KS/wZG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724797401; x=1756333401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItqJNfn3hlKuY1giqmucMmbfP7TZmqrlAw07jjbs07Q=;
  b=A5KS/wZGdDG4wPT7ZXHe9rrH0+cJnet6oVrNfelgODLcl1shYk09GJCj
   +hlTUIWdsy/mLmf0H1aebpcZckRRWnWjZ0icGMe0LpZaLCLgqC44/jUc0
   89u8qzdaBKoVQ/hPXPfFRBMItrEblkchr2bo16n8Fi7h3AZLqScQQ7XjR
   aq2mESY+2WI64wBKMYKOM2uLY09KsrVqvBqIZ2COSubkw+kFNCHUnRUwB
   g5VNyFM6mVYo+59nc6f51cki6k4YoFeZiOFXlcPGHapLeT4D7ZmfSJ0dP
   Fw5jUiiCj75FDZjfii9n5g+VCCsnhpNDy2aEGd4IXBD58H4x35zX67j5B
   Q==;
X-CSE-ConnectionGUID: SC/IcXIUS+iI/iJc8O68AA==
X-CSE-MsgGUID: Fwty75bdSHemPAt3pT8k7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22827971"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="22827971"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 15:23:21 -0700
X-CSE-ConnectionGUID: TfXBwgbVROG8c7n2l5+BrA==
X-CSE-MsgGUID: 0ny/6AyhSVKNPQ49kngS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63009612"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2024 15:23:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj4aq-000K8Y-2V;
	Tue, 27 Aug 2024 22:23:16 +0000
Date: Wed, 28 Aug 2024 06:22:53 +0800
From: kernel test robot <lkp@intel.com>
To: Brett Creeley <brett.creeley@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	shannon.nelson@amd.com, brett.creeley@amd.com
Subject: Re: [PATCH v2 net-next 5/5] ionic: convert Rx queue buffers to use
 page_pool
Message-ID: <202408280648.f6Hb9cX3-lkp@intel.com>
References: <20240826184422.21895-6-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826184422.21895-6-brett.creeley@amd.com>

Hi Brett,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Brett-Creeley/ionic-debug-line-for-Tx-completion-errors/20240827-024626
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240826184422.21895-6-brett.creeley%40amd.com
patch subject: [PATCH v2 net-next 5/5] ionic: convert Rx queue buffers to use page_pool
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240828/202408280648.f6Hb9cX3-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280648.f6Hb9cX3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280648.f6Hb9cX3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:4:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/pensando/ionic/ionic_txrx.c:203:30: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     203 |                 frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:28: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         PAGE_SIZE
         |                                                 ^
   arch/powerpc/include/asm/page.h:25:34: note: expanded from macro 'PAGE_SIZE'
      25 | #define PAGE_SIZE               (ASM_CONST(1) << PAGE_SHIFT)
         |                                               ^
   include/linux/minmax.h:213:52: note: expanded from macro 'min_t'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:96:33: note: expanded from macro '__cmp_once'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:31: note: expanded from macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:797:36: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     797 |                 first_frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:28: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         PAGE_SIZE
         |                                                 ^
   arch/powerpc/include/asm/page.h:25:34: note: expanded from macro 'PAGE_SIZE'
      25 | #define PAGE_SIZE               (ASM_CONST(1) << PAGE_SHIFT)
         |                                               ^
   include/linux/minmax.h:213:52: note: expanded from macro 'min_t'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:96:33: note: expanded from macro '__cmp_once'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:31: note: expanded from macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:832:38: warning: implicit conversion from 'unsigned long' to 'u16' (aka 'unsigned short') changes value from 65536 to 0 [-Wconstant-conversion]
     832 |                         frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_dev.h:184:28: note: expanded from macro 'IONIC_PAGE_SIZE'
     184 | #define IONIC_PAGE_SIZE                         PAGE_SIZE
         |                                                 ^
   arch/powerpc/include/asm/page.h:25:34: note: expanded from macro 'PAGE_SIZE'
      25 | #define PAGE_SIZE               (ASM_CONST(1) << PAGE_SHIFT)
         |                                               ^
   include/linux/minmax.h:213:52: note: expanded from macro 'min_t'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   include/linux/minmax.h:96:33: note: expanded from macro '__cmp_once'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:31: note: expanded from macro '__cmp_once_unique'
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                ~~    ^
   7 warnings generated.


vim +203 drivers/net/ethernet/pensando/ionic/ionic_txrx.c

   174	
   175	static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
   176						  struct ionic_rx_desc_info *desc_info,
   177						  unsigned int headroom,
   178						  unsigned int len,
   179						  unsigned int num_sg_elems,
   180						  bool synced)
   181	{
   182		struct ionic_buf_info *buf_info;
   183		struct sk_buff *skb;
   184		unsigned int i;
   185		u16 frag_len;
   186	
   187		buf_info = &desc_info->bufs[0];
   188		prefetchw(buf_info->page);
   189	
   190		skb = napi_get_frags(&q_to_qcq(q)->napi);
   191		if (unlikely(!skb)) {
   192			net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
   193					     dev_name(q->dev), q->name);
   194			q_to_rx_stats(q)->alloc_err++;
   195			return NULL;
   196		}
   197		skb_mark_for_recycle(skb);
   198	
   199		if (headroom)
   200			frag_len = min_t(u16, len,
   201					 IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
   202		else
 > 203			frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
   204	
   205		if (unlikely(!buf_info->page))
   206			goto err_bad_buf_page;
   207		ionic_rx_add_skb_frag(q, skb, buf_info, headroom, frag_len, synced);
   208		len -= frag_len;
   209		buf_info++;
   210	
   211		for (i = 0; i < num_sg_elems; i++, buf_info++) {
   212			if (unlikely(!buf_info->page))
   213				goto err_bad_buf_page;
   214			frag_len = min_t(u16, len, buf_info->len);
   215			ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
   216			len -= frag_len;
   217		}
   218	
   219		return skb;
   220	
   221	err_bad_buf_page:
   222		dev_kfree_skb(skb);
   223		return NULL;
   224	}
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

