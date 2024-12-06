Return-Path: <netdev+bounces-149849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FD9E7B28
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFE280C32
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A901AAA3A;
	Fri,  6 Dec 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8aSPbvo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AD22C6DC
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521406; cv=none; b=Bq7Ans9cOng3q2TMmzyfMlOdBWlMnib/h/U1tfMLelLOGJoogSKhKNC2ffmYmTJCa+VND3PeY6d7RAoI8v07R6MYzCvZFTMMNSKDQJKqKr1Cf++fth1oFrWAw7GCvf4Uwl0CzS9Z03gf66MUm0hUWKVRJiYFFzHiHK2ltQQQ6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521406; c=relaxed/simple;
	bh=03PJh/ck6Oij4S/+gjwuYJH+/iN5eJyRrxHvrQa3O+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvEY7mm21ddwILcWWp0Sa2a4ouaYp351ZmDvmZUCIiD7cxt+30OpFTMFveBGgW5iqgBajrH+10nsr3V3CNrZP2JyOx9p/XUTtmL0lQorTf9QcqYrFRT1Yxa1+3OUgtH9xQxPet3TcdHRC0oEUAOKr9nJ+BE/C9dPw4kv06/tyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8aSPbvo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733521406; x=1765057406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03PJh/ck6Oij4S/+gjwuYJH+/iN5eJyRrxHvrQa3O+0=;
  b=Z8aSPbvowRxIVIHBOiOOcOSmScv+sZ+WHmKQLW1WXSFqkzOsnWGjpuf9
   BVkGb4Yt1UJ7H82gFiHUQq7XSUDmiuJOTb5YQ/u462tjCjj2sl/136hyS
   9LFBEc6tSgCwWbloTEwT9EPQyOkQONC0RQpCVTtncFc0rL8l4gVgQCBWv
   xgH+AlXntQXw2+CO5ayaapGrz3DDcsU27r/FV2sDEjvgdgQPCo8TdLBsa
   gxwE815YtGK/PEuDsUQV+37ecNRizVIO4Mu3WvpE4gZGpjWsGihxU+5Qr
   UO0NM/AHmoBUSalqfpyjxAQdplKbow0D2pA0TdpGMWWLzd0uIMb0+ZR77
   w==;
X-CSE-ConnectionGUID: 2CivTPJJSv6ZPRw1tbswdw==
X-CSE-MsgGUID: U/bZH5HhS8yrMbkfzza0FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45265266"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45265266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:43:25 -0800
X-CSE-ConnectionGUID: vusUvBAWTNeDb+fheG24pQ==
X-CSE-MsgGUID: Q7HjNLTHTbC5z5ANl21tIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94385064"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Dec 2024 13:43:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJg6Z-0002H3-2X;
	Fri, 06 Dec 2024 21:43:19 +0000
Date: Sat, 7 Dec 2024 05:43:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 08/15] socket: Pass hold_net to sk_alloc().
Message-ID: <202412070526.FhqWmbBo-lkp@intel.com>
References: <20241206075504.24153-9-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206075504.24153-9-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/socket-Un-export-__sock_create/20241206-160139
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241206075504.24153-9-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 08/15] socket: Pass hold_net to sk_alloc().
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241207/202412070526.FhqWmbBo-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070526.FhqWmbBo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070526.FhqWmbBo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/iucv/af_iucv.c:16:
   In file included from include/linux/filter.h:9:
   In file included from include/linux/bpf.h:20:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
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
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/iucv/af_iucv.c:455:59: error: too few arguments to function call, expected 6, have 5
     455 |         sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
         |              ~~~~~~~~                                            ^
   include/net/sock.h:1745:14: note: 'sk_alloc' declared here
    1745 | struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
         |              ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1746 |                       struct proto *prot, bool kern, bool hold_net);
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 1 error generated.


vim +455 net/iucv/af_iucv.c

eac3731bd04c713 Jennifer Hunt     2007-02-08  448  
8424c284851b97e Kuniyuki Iwashima 2024-12-06  449  static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
8424c284851b97e Kuniyuki Iwashima 2024-12-06  450  				    bool kern, bool hold_net)
eac3731bd04c713 Jennifer Hunt     2007-02-08  451  {
eac3731bd04c713 Jennifer Hunt     2007-02-08  452  	struct sock *sk;
493d3971a65c921 Ursula Braun      2011-08-08  453  	struct iucv_sock *iucv;
eac3731bd04c713 Jennifer Hunt     2007-02-08  454  
11aa9c28b420924 Eric W. Biederman 2015-05-08 @455  	sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
eac3731bd04c713 Jennifer Hunt     2007-02-08  456  	if (!sk)
eac3731bd04c713 Jennifer Hunt     2007-02-08  457  		return NULL;
493d3971a65c921 Ursula Braun      2011-08-08  458  	iucv = iucv_sk(sk);
eac3731bd04c713 Jennifer Hunt     2007-02-08  459  
eac3731bd04c713 Jennifer Hunt     2007-02-08  460  	sock_init_data(sock, sk);
493d3971a65c921 Ursula Braun      2011-08-08  461  	INIT_LIST_HEAD(&iucv->accept_q);
493d3971a65c921 Ursula Braun      2011-08-08  462  	spin_lock_init(&iucv->accept_q_lock);
493d3971a65c921 Ursula Braun      2011-08-08  463  	skb_queue_head_init(&iucv->send_skb_q);
493d3971a65c921 Ursula Braun      2011-08-08  464  	INIT_LIST_HEAD(&iucv->message_q.list);
493d3971a65c921 Ursula Braun      2011-08-08  465  	spin_lock_init(&iucv->message_q.lock);
493d3971a65c921 Ursula Braun      2011-08-08  466  	skb_queue_head_init(&iucv->backlog_skb_q);
493d3971a65c921 Ursula Braun      2011-08-08  467  	iucv->send_tag = 0;
3881ac441f642d5 Ursula Braun      2011-08-08  468  	atomic_set(&iucv->pendings, 0);
493d3971a65c921 Ursula Braun      2011-08-08  469  	iucv->flags = 0;
3881ac441f642d5 Ursula Braun      2011-08-08  470  	iucv->msglimit = 0;
ef6af7bdb9e6c14 Julian Wiedmann   2021-01-28  471  	atomic_set(&iucv->skbs_in_xmit, 0);
3881ac441f642d5 Ursula Braun      2011-08-08  472  	atomic_set(&iucv->msg_sent, 0);
3881ac441f642d5 Ursula Braun      2011-08-08  473  	atomic_set(&iucv->msg_recv, 0);
493d3971a65c921 Ursula Braun      2011-08-08  474  	iucv->path = NULL;
3881ac441f642d5 Ursula Braun      2011-08-08  475  	iucv->sk_txnotify = afiucv_hs_callback_txnotify;
b5d8cf0af167f3a Kees Cook         2021-11-18  476  	memset(&iucv->init, 0, sizeof(iucv->init));
3881ac441f642d5 Ursula Braun      2011-08-08  477  	if (pr_iucv)
3881ac441f642d5 Ursula Braun      2011-08-08  478  		iucv->transport = AF_IUCV_TRANS_IUCV;
3881ac441f642d5 Ursula Braun      2011-08-08  479  	else
3881ac441f642d5 Ursula Braun      2011-08-08  480  		iucv->transport = AF_IUCV_TRANS_HIPER;
eac3731bd04c713 Jennifer Hunt     2007-02-08  481  
eac3731bd04c713 Jennifer Hunt     2007-02-08  482  	sk->sk_destruct = iucv_sock_destruct;
eac3731bd04c713 Jennifer Hunt     2007-02-08  483  	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
eac3731bd04c713 Jennifer Hunt     2007-02-08  484  
eac3731bd04c713 Jennifer Hunt     2007-02-08  485  	sock_reset_flag(sk, SOCK_ZAPPED);
eac3731bd04c713 Jennifer Hunt     2007-02-08  486  
eac3731bd04c713 Jennifer Hunt     2007-02-08  487  	sk->sk_protocol = proto;
eac3731bd04c713 Jennifer Hunt     2007-02-08  488  	sk->sk_state	= IUCV_OPEN;
eac3731bd04c713 Jennifer Hunt     2007-02-08  489  
eac3731bd04c713 Jennifer Hunt     2007-02-08  490  	iucv_sock_link(&iucv_sk_list, sk);
eac3731bd04c713 Jennifer Hunt     2007-02-08  491  	return sk;
eac3731bd04c713 Jennifer Hunt     2007-02-08  492  }
eac3731bd04c713 Jennifer Hunt     2007-02-08  493  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

