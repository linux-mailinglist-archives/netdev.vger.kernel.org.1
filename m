Return-Path: <netdev+bounces-123530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224AF965338
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF6E282511
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D481BAEF0;
	Thu, 29 Aug 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vEfOLRsT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BF1BA860
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972119; cv=none; b=lyX8kMOsmAT+AnGaZ0NNFSipuO6APuicXPWtRngx0xpU39qUwAXDqwnlKPN4MKNRU03o9ihi/crKY/gZvAOD+1ThMiawAHMveouVqX6xyF1m0wgfJlxYFRX7hhAvlKrg/mheTsercyZJrBQdnX1vih5kQ2aE6n8jXqgrVI4LN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972119; c=relaxed/simple;
	bh=1ssNnL/k5bFru9h42AxcidaH4ax80+FvxxXdgP44aoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIO9YeaI3cMimGf7KaDZNWrQJQndPI06VklwVOUM+dCxixcBdJnDqW9I9F1GTtAdLs4oahs3l+sk+UoFrGI3keRgYtnrg6VhU5k5P3phgk7HqJABsvP5yedDLJBOpzYSMUiLjqmDXvewwxFeMMPofsGbkruZYfPUOaMKopwmNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vEfOLRsT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724972118; x=1756508118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YHbKDmxWbzWr5hI6s+kAruFeF3UB7hOdkRJaiOEWF6A=;
  b=vEfOLRsTVzkLx7RcPCEiuXr4yizaWZDlj+r8FZb8zq9LnMpCZuS/4OFZ
   tQnQzGQdkBSJPhpGX71CePuTfD+jtDtlC8mpqV0uEI0ElMa4Ua50/Gn8T
   tvSXX3pQej/b8Bet42HlczHN7yvJ+ZOOqJeMfS/oh/f0KrlJKbPHWNy2Q
   g=;
X-IronPort-AV: E=Sophos;i="6.10,186,1719878400"; 
   d="scan'208";a="228566366"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 22:55:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21263]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.174:2525] with esmtp (Farcaster)
 id 88b11d53-6878-4e39-9135-7a0f475443a5; Thu, 29 Aug 2024 22:55:13 +0000 (UTC)
X-Farcaster-Flow-ID: 88b11d53-6878-4e39-9135-7a0f475443a5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 29 Aug 2024 22:55:13 +0000
Received: from 88665a182662.ant.amazon.com (10.142.208.236) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 29 Aug 2024 22:55:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <omid.ehtemamhaghighi@menlosecurity.com>
CC: <adrian.oliver@menlosecurity.com>, <dsahern@gmail.com>,
	<edumazet@google.com>, <idosch@idosch.org>, <netdev@vger.kernel.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH v3] net/ipv6: Fix soft lockups in fib6_select_path under high next hop churn
Date: Thu, 29 Aug 2024 15:55:03 -0700
Message-ID: <20240829225503.48563-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240829222803.448995-1-omid.ehtemamhaghighi@menlosecurity.com>
References: <20240829222803.448995-1-omid.ehtemamhaghighi@menlosecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Date: Thu, 29 Aug 2024 15:28:03 -0700
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
> 
> To fix this issue, I applied RCU primitives in the problematic code
> sections, which successfully resolved the issue within our testing
> parameters and in the production environment where the issue was first
> observed. Additionally, all references to fib6_siblings have been updated
> to annotate or use the RCU APIs.
> 
> A test script that reproduces this issue is included with this patch. The
> script periodically updates the routing table while generating a heavy load
> of outgoing IPv6 traffic through multiple iperf3 clients. I have tested
> this script on various machines, ranging from low to high performance, as
> detailed in the comment section of the test script. It consistently induces
> soft lockups within a minute.
> 
> Kernel log:
> 
>  0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
>  1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
>  2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
>  3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
>  4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
>  5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
>  6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
>  7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
> -- <IRQ stack> --
>  8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
>     [exception RIP: fib6_select_path+299]
>     RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
>     RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
>     RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
>     RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
>     R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
> 10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
> 11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
> 12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
> 13 [ffffbd13003d3a18] ip6_rcv_finish_core.constprop.0 at ffffffff8dd950d0
> 14 [ffffbd13003d3a30] ip6_list_rcv_finish.constprop.0 at ffffffff8dd96274
> 15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
> 16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
> 17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
> 18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
> 19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
> 20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
> 21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
> 22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
> 23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
> 24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
> 25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
> 26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
> 27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
> 28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
> 29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
> 30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Reported-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Tested-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>

Reported-by and Tested-by are redundant.


> Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@idosch.org>
> ---
> v2 -> v3:
> 	* Removed redundant rcu_read_lock()/rcu_read_unlock() pairs
> 	* Revised the test script based on Ido Schimmel's feedback
> 	* Updated the test script to ensure compatibility with the latest iperf3 version
> 	* Fixed new warnings generated with 'C=2' in the previous version
> 	* Other review comments addressed
> 
> v1 -> v2:
> 	* list_del_rcu() is applied exclusively to legacy multipath code
> 	* All occurrences of fib6_siblings have been modified to utilize RCU
> 	  APIs for annotation and usage.
> 	* Additionally, a test script for reproducing the reported
> 	  issue is included
> ---
>  net/ipv6/ip6_fib.c                            |  22 +-
>  net/ipv6/route.c                              |  30 ++-
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../net/ipv6_route_update_soft_lockup.sh      | 226 ++++++++++++++++++
>  4 files changed, 261 insertions(+), 18 deletions(-)
>  create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index eb111d20615c..002cddc5d3b5 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -518,7 +518,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
>  static int fib6_dump_node(struct fib6_walker *w)
>  {
>  	int res;
> -	struct fib6_info *rt;
> +	struct fib6_info *rt, *sibling, *last_sibling;

while at it, reorder variables in reverse xmas tree order.
Same for other places.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs


>  
>  	for_each_fib6_walker_rt(w) {
>  		res = rt6_dump_route(rt, w->args, w->skip_in_node);
> @@ -540,10 +540,14 @@ static int fib6_dump_node(struct fib6_walker *w)
>  		 * last sibling of this route (no need to dump the
>  		 * sibling routes again)
>  		 */
> -		if (rt->fib6_nsiblings)
> -			rt = list_last_entry(&rt->fib6_siblings,
> -					     struct fib6_info,
> -					     fib6_siblings);
> +		if (rt->fib6_nsiblings) {
> +			last_sibling = rt;
> +			list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
> +						fib6_siblings)
> +				last_sibling = sibling;
> +
> +			rt = last_sibling;
> +		}
>  	}
>  	w->leaf = NULL;
>  	return 0;
> @@ -1190,8 +1194,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  		while (sibling) {
>  			if (sibling->fib6_metric == rt->fib6_metric &&
>  			    rt6_qualify_for_ecmp(sibling)) {
> -				list_add_tail(&rt->fib6_siblings,
> -					      &sibling->fib6_siblings);
> +				list_add_tail_rcu(&rt->fib6_siblings,
> +						  &sibling->fib6_siblings);
>  				break;
>  			}
>  			sibling = rcu_dereference_protected(sibling->fib6_next,
> @@ -1252,7 +1256,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  							 fib6_siblings)
>  					sibling->fib6_nsiblings--;
>  				rt->fib6_nsiblings = 0;
> -				list_del_init(&rt->fib6_siblings);
> +				list_del_rcu(&rt->fib6_siblings);
>  				rt6_multipath_rebalance(next_sibling);
>  				return err;
>  			}
> @@ -1970,7 +1974,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
>  					 &rt->fib6_siblings, fib6_siblings)
>  			sibling->fib6_nsiblings--;
>  		rt->fib6_nsiblings = 0;
> -		list_del_init(&rt->fib6_siblings);
> +		list_del_rcu(&rt->fib6_siblings);
>  		rt6_multipath_rebalance(next_sibling);
>  	}
>  
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 219701caba1e..12dc1acb6463 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -413,7 +413,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *sibling, *next_sibling;
> +	struct fib6_info *sibling;
>  	struct fib6_info *match = res->f6i;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -440,8 +440,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
>  		goto out;
>  
> -	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
> -				 fib6_siblings) {
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> +				fib6_siblings) {
>  		const struct fib6_nh *nh = sibling->fib6_nh;
>  		int nh_upper_bound;
>  
> @@ -454,6 +456,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		break;
>  	}
>  
> +	rcu_read_unlock();
> +
>  out:
>  	res->f6i = match;
>  	res->nh = match->fib6_nh;

match could be an rcu_dereference()d object.


> @@ -5195,14 +5199,18 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
>  	 * nexthop. Since sibling routes are always added at the end of
>  	 * the list, find the first sibling of the last route appended
>  	 */
> +	rcu_read_lock();
> +
>  	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
> -		rt = list_first_entry(&rt_last->fib6_siblings,
> -				      struct fib6_info,
> -				      fib6_siblings);
> +		rt = list_first_or_null_rcu(&rt_last->fib6_siblings,
> +					    struct fib6_info,
> +					    fib6_siblings);
>  	}
>  
>  	if (rt)
>  		inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags);
> +
> +	rcu_read_unlock();
>  }
>  
>  static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
> @@ -5547,17 +5555,21 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
>  		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
>  					 &nexthop_len);
>  	} else {
> -		struct fib6_info *sibling, *next_sibling;
> +		struct fib6_info *sibling;
>  		struct fib6_nh *nh = f6i->fib6_nh;
>  
>  		nexthop_len = 0;
>  		if (f6i->fib6_nsiblings) {
>  			rt6_nh_nlmsg_size(nh, &nexthop_len);
>  
> -			list_for_each_entry_safe(sibling, next_sibling,
> -						 &f6i->fib6_siblings, fib6_siblings) {
> +			rcu_read_lock();
> +
> +			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
> +						fib6_siblings) {
>  				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
>  			}
> +
> +			rcu_read_unlock();
>  		}
>  		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
>  	}

