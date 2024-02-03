Return-Path: <netdev+bounces-68852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BE8488A3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C45285409
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A75EE80;
	Sat,  3 Feb 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIlnyUTu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38555F561
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990370; cv=none; b=qmnzNvOyMsAU9557+LYK95etR5Gpbhq/ZwId3Ce+/vzBQ8346NAKTq+KYAbp8P48tgIPYde4KG5icDI3C+tiGRom3KQ5Jc+IYRx3JlUSe0ci+DPMTzhizWAkOkM2pNGu19HF5q7UW+gANVelrsvHtorGxKE2g/ytZc+Doc/enI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990370; c=relaxed/simple;
	bh=0Cl0sgbD6FT0nxPUKA/aqwhhXsqtDupISOShia89apY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hydc3d0+rDvqhMB9Yf7OU735SMjxX31Stv8ShjIXg849UBZT6RTxwx726A4EYt4sJ8BKM60VUSNsqCThQ1QvILZtZrTXPeQTJ8B0RoiZCCvFZa3lhDewRnwH4xKbtJf8u0nMS4ZTUvj3/a6BeexWKWD8OyT104P69aBLHzN2FYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIlnyUTu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706990369; x=1738526369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Cl0sgbD6FT0nxPUKA/aqwhhXsqtDupISOShia89apY=;
  b=nIlnyUTuL+AAxMma9PPUB9quXa5AGnD2b3uI60aX2LjjW7Zj6qeNi3kP
   RxVp0MxltBNR1HAH9ma3e4Z8fKpbmUZ8XvQv6OQSsT0YrOUtl62WtTXwl
   VCXqoFP1tPZ8dniBq08HjUoU7NIRz0NrzRl9mZYfY3lmiHQvCsaRJpAtI
   NlRMoCzVdlgo3KfCmrOVvkCk6pGlYCI0MHMiiphj9DyyTH0WiWboXQjpv
   CwDa6qImxcIxRPZJYiOzoLMSGUSrolY2sRXVA4mqGsah1KsT5MQM0ItvH
   cC0FuvTjTt/np9RU+rU6vCf76iXx/A+D6ysRirSoykfbzcBBnMkVEWLvY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="236329"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="236329"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 11:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="577386"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 03 Feb 2024 11:59:26 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWMAe-0005Xs-03;
	Sat, 03 Feb 2024 19:59:24 +0000
Date: Sun, 4 Feb 2024 03:59:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 07/16] af_unix: Detect Strongly Connected
 Components.
Message-ID: <202402040348.uejoTcrq-lkp@intel.com>
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
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240204/202402040348.uejoTcrq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040348.uejoTcrq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040348.uejoTcrq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/unix/garbage.c:257:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
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

