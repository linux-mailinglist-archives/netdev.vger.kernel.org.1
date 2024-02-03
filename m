Return-Path: <netdev+bounces-68869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A08848900
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F284C1C222D9
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405912E42;
	Sat,  3 Feb 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArBU46ZB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4F12E4F
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996204; cv=none; b=bP34vNzjCBpu2iON4+LMIfLAc94/gCG6Hg2RcWtaQpm3uwL06iU8PrMjEd+9wPabhsnObBg+IJEgLj3d75YuY7XWBQ1/yuMcNin9TULincW8tnpSovS3fhsVAleWHLVszHaqpwFgt1wC58VsT435cFYJfxAji6Jgnn6x/7IZohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996204; c=relaxed/simple;
	bh=ObK6GFFC+UvoR9g11nygtQo+SWtL356OmJ0KUMDy8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3ZSEByqtF+qT2umeepa3TdMfZYdhSpVOr+3Xe4uKgB5FfMBQln6ewxgdirpfZFZfbc7482yXFE2rqK5RUH11nGiGgPdgBBcSLk8v+OQLUt7a0bEkZb08umCbqkpTHxmTJ8Zo2W99rt0lgemnwOtWGCfvGecDxzxrETuYGQrQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArBU46ZB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706996202; x=1738532202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObK6GFFC+UvoR9g11nygtQo+SWtL356OmJ0KUMDy8S8=;
  b=ArBU46ZB/AO7clJJg8p4QfZYepeMOjgs1lCtdqxMxlOlLB3quxRijtln
   C5TclJcgZpU2U4eB/2S3BXqrR89F1wzs5u+aMYIq/IpnOdIhtjDN/sAh1
   LivCH39ziwuojvBmZNq/v0sf5lRltfB5Nm65dbioOEjYA4LLOiQVCp8gc
   fFo9grz5sIQ8IdmcOctwEnWyXXn6lsFifZbKp7e3QTcLvKzREAIeWnCrC
   Uldf5nNNCS02iXyDjU3b8tRKFfiXbYOc525O36PFU/e7gpRFA+nHm4QGl
   np3rbBmWR3yauRLpGRousgS2PLfzh54KChbY146MApTZtgqNa1f/aheM2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="17755515"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="17755515"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 13:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="5128189"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Feb 2024 13:36:38 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWNgg-0005dU-2u;
	Sat, 03 Feb 2024 21:36:34 +0000
Date: Sun, 4 Feb 2024 05:36:14 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 07/16] af_unix: Detect Strongly Connected
 Components.
Message-ID: <202402040541.rLg7ze2a-lkp@intel.com>
References: <20240203030058.60750-8-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203030058.60750-8-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Add-struct-unix_vertex-in-struct-unix_sock/20240203-110847
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240203030058.60750-8-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 07/16] af_unix: Detect Strongly Connected Components.
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240204/202402040541.rLg7ze2a-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040541.rLg7ze2a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040541.rLg7ze2a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/unix/garbage.c:257:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
     257 |         }
         |         ^
   1 warning generated.


vim +257 net/unix/garbage.c

   227	
   228	static void __unix_walk_scc(struct unix_vertex *vertex)
   229	{
   230		unsigned long index = UNIX_VERTEX_INDEX_START;
   231		LIST_HEAD(vertex_stack);
   232		struct unix_edge *edge;
   233		LIST_HEAD(edge_stack);
   234	
   235	next_vertex:
   236		vertex->index = index;
   237		vertex->lowlink = index;
   238		index++;
   239	
   240		vertex->on_stack = true;
   241		list_move(&vertex->scc_entry, &vertex_stack);
   242	
   243		list_for_each_entry(edge, &vertex->edges, entry) {
   244			if (!edge->successor->out_degree)
   245				continue;
   246	
   247			if (edge->successor->index == UNIX_VERTEX_INDEX_UNVISITED) {
   248				list_add(&edge->stack_entry, &edge_stack);
   249	
   250				vertex = edge->successor;
   251				goto next_vertex;
   252			}
   253	
   254			if (edge->successor->on_stack)
   255				vertex->lowlink = min(vertex->lowlink, edge->successor->index);
   256	next_edge:
 > 257		}
   258	
   259		if (vertex->index == vertex->lowlink) {
   260			LIST_HEAD(scc);
   261	
   262			list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
   263	
   264			list_for_each_entry_reverse(vertex, &scc, scc_entry) {
   265				list_move_tail(&vertex->entry, &unix_visited_vertices);
   266	
   267				vertex->on_stack = false;
   268			}
   269	
   270			list_del(&scc);
   271		}
   272	
   273		if (!list_empty(&edge_stack)) {
   274			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
   275			list_del_init(&edge->stack_entry);
   276	
   277			vertex = edge->predecessor;
   278			vertex->lowlink = min(vertex->lowlink, edge->successor->lowlink);
   279			goto next_edge;
   280		}
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

