Return-Path: <netdev+bounces-138991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA69AFB1E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6C81F23751
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832601BB6A0;
	Fri, 25 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b="FpwppJ0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0F19993D
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841456; cv=none; b=UaNz9w/FeroZCrPtxOp0BZyNHfOGmbWXxMAAwSnT9GKNtxQ4q09LQelMmIjguROeUN7w10G1kzO3Mi47O7Q04pkCd7D3auQuytnBWge59fzeHoLst7VSGfdHVZ8SS66dAZE/mHqpG8Yu9qvRSCDUZlmOHlkLBa3dxpI9pI5z5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841456; c=relaxed/simple;
	bh=y7K5tvVsxX963FEHh62X8tjJkmK39Tjw8w+pdgr8d0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z0RGRutvsyKwL0+xS3/y8gknpQRA16pFx/uILs0rRu7jWwgSkDTvzjHPxCxcm6dcxC1+1X5TqVVwtYGqzDdMZz+pBG5Tera/GKl7VnD0rpcNADmE/GeYLSrEdFuFtgqKu+poejbwi7LM7aO/xp3AojmcRNfYKGk03kPmfaWtqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com; spf=pass smtp.mailfrom=menlosecurity.com; dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b=FpwppJ0S; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=menlosecurity.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-5ebc1af8e91so861080eaf.1
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 00:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729841451; x=1730446251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNw/anDqTy0x1e0T/4RKLbEWjr0xDdH8TIxntDgTe/A=;
        b=a2SM4hApd+G1SRJ70NrAzSTwZ5TXCkeGijfv9nD3p3xdVnFo77WnpeWZfvPItxsju7
         fg6l3JXnHYFc3stsfl7+xklFdCqUTVaCEhrkyqJoF7c9sezDLlTkRE6wSJc7pyQ2+xWg
         ZWwMy4iEgQb2n5r1t3tFtiV9xdSnHDC7lmswEdsrKNycnSQz1h2ABRzuKYT/EQboJMYq
         3vWcmwixIWmqWeTYzYH4ct95r9OAr7dMcvEOjmGka2eofrOT/tyd6a3oJL7+fAMDY7KZ
         5vhGBmaO+blPDXOGycXTE5E4G0qXK3LnAJhxoKvY653ehDqgVqf4I3l4yy2uv41DwQgg
         8/zg==
X-Gm-Message-State: AOJu0Yz5y3bB30f6KNgluXGMNSLan0yC2eyF/yyshgit15Erkm8AJEyN
	APYQNS3K9qBbVYVQt6GfkTu762hoylKNUfNH/Pn9RMl+nM254BgfGw6TZvNB9CiwV5z6YV8CEIb
	rlNatGkDSP/z2S+LxZjTrAeg9+8Hda5+/YM/IppkXCoQ=
X-Google-Smtp-Source: AGHT+IEHlK8sH2Xw+16e+46apDTG4SsR2RfPE4b8AHsshMstrIrysZxoC2M7k175DKAHb7B0mp7c3taK8iwN
X-Received: by 2002:a05:6870:1ce:b0:254:7f9f:3f21 with SMTP id 586e51a60fabf-28ced305a1cmr4946927fac.27.1729841451680;
        Fri, 25 Oct 2024 00:30:51 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.177])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29035d1dcedsm19478fac.10.2024.10.25.00.30.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 00:30:51 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-029060369cr-re.menlosecurity.com (34.202.62.178)
    by restore.menlosecurity.com (34.202.62.177)
    with SMTP id 0f3a2c90-92a3-11ef-8799-dd11e1c4dd06;
    Fri, 25 Oct 2024 07:30:51 GMT
Received: from mail-pl1-f200.google.com (209.85.214.200)
    by safemail-prod-029060369cr-re.menlosecurity.com (34.202.62.178)
    with SMTP id 0f3a2c90-92a3-11ef-8799-dd11e1c4dd06;
    Fri, 25 Oct 2024 07:30:51 GMT
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20e6dc85472so17486745ad.3
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google; t=1729841449; x=1730446249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNw/anDqTy0x1e0T/4RKLbEWjr0xDdH8TIxntDgTe/A=;
        b=FpwppJ0S4DEzGi/MD/5Il93Ul2zlzDamT4PPuse8gWmUWByUiBUNMok77JDm7sD+LF
         eUidSg5ifwMHQJVBHhZ2OtzvtZDNLhpi9/2zxsFhrLUdn2P567vj2n7YT3KLJRT8DRMf
         Yp4S+7x5zMHernKfkUuXHXa1UUtAgVwFPG2Wc=
X-Received: by 2002:a17:903:41c3:b0:20c:cccd:17a3 with SMTP id d9443c01a7336-20fb9aa1f44mr54714225ad.46.1729841448722;
        Fri, 25 Oct 2024 00:30:48 -0700 (PDT)
X-Received: by 2002:a17:903:41c3:b0:20c:cccd:17a3 with SMTP id d9443c01a7336-20fb9aa1f44mr54713875ad.46.1729841448207;
        Fri, 25 Oct 2024 00:30:48 -0700 (PDT)
Received: from localhost.localdomain ([108.63.133.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e941sm4546105ad.204.2024.10.25.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:30:47 -0700 (PDT)
From: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
To: netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
	Adrian Oliver <kernel@aoliver.ca>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@idosch.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6] ipv6: Fix soft lockups in fib6_select_path under high next hop churn
Date: Fri, 25 Oct 2024 00:30:03 -0700
Message-Id: <20241025073003.2079945-1-omid.ehtemamhaghighi@menlosecurity.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Soft lockups have been observed on a cluster of Linux-based edge routers
located in a highly dynamic environment. Using the `bird` service, these
routers continuously update BGP-advertised routes due to frequently
changing nexthop destinations, while also managing significant IPv6
traffic. The lockups occur during the traversal of the multipath
circular linked-list in the `fib6_select_path` function, particularly
while iterating through the siblings in the list. The issue typically
arises when the nodes of the linked list are unexpectedly deleted
concurrently on a different core—indicated by their 'next' and
'previous' elements pointing back to the node itself and their reference
count dropping to zero. This results in an infinite loop, leading to a
soft lockup that triggers a system panic via the watchdog timer.

Apply RCU primitives in the problematic code sections to resolve the
issue. Where necessary, update the references to fib6_siblings to
annotate or use the RCU APIs.

Include a test script that reproduces the issue. The script
periodically updates the routing table while generating a heavy load
of outgoing IPv6 traffic through multiple iperf3 clients. It
consistently induces infinite soft lockups within a couple of minutes.

Kernel log:

 0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
 1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
 2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
 3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
 4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
 5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
 6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
 7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
-- <IRQ stack> --
 8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
    [exception RIP: fib6_select_path+299]
    RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
    RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
    RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
    RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
    R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
    R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
13 [ffffbd13003d3a18] ip6_rcv_finish_core.constprop.0 at ffffffff8dd950d0
14 [ffffbd13003d3a30] ip6_list_rcv_finish.constprop.0 at ffffffff8dd96274
15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb

Fixes: 66f5d6ce53e6 ("ipv6: replace rwlock with rcu and spinlock in fib6_table")
Reported-by: Adrian Oliver <kernel@aoliver.ca>
Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v5 -> v6:
	* Adjust the comment line lengths in the test script to a maximum of
	  80 characters
	* Change memory allocation in inet6_rt_notify from gfp_any() to GFP_ATOMIC for
	  atomic allocation in non-blocking contexts, as suggested by Ido Schimmel
	* NOTE: I have executed the test script on both bare-metal servers and
	  virtualized environments such as QEMU and vng. In the case of bare-metal, it
	  consistently triggers a soft lockup in under a minute on unpatched kernels.
	  For the virtualized environments, an unpatched kernel compiled with the
	  Ubuntu 24.04 configuration also triggers a soft lockup, though it takes
	  longer; however, it did not trigger a soft lockup on kernels compiled with
	  configurations provided in:

	  https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

	  leading to potential false negatives in the test results.

	  I am curious if this test can be executed on a bare-metal machine within a
	  CI system, if such a setup exists, rather than in a virtualized environment.
	  If that’s not possible, how can I apply a different kernel configuration,
	  such as the one used in Ubuntu 24.04, for this test? Please advise.

v4 -> v5:
	* Addressed review comments from Paolo Abeni.
	* Added additional clarifying comments in the test script.
	* Minor cleanup performed in the test script.

v3 -> v4:
	* Added RCU primitives to rt6_fill_node(). I found that this function is typically
	  called either with a table lock held or within rcu_read_lock/rcu_read_unlock
	  pairs, except in the following call chain, where the protection is unclear:

		rt_fill_node()
		fib6_info_hw_flags_set()
		mlxsw_sp_fib6_offload_failed_flag_set()
		mlxsw_sp_router_fib6_event_work()

	  The last function is initialized as a work item in mlxsw_sp_router_fib_event()
	  and scheduled for deferred execution. I am unsure if the execution context of
	  this work item is protected by any table lock or rcu_read_lock/rcu_read_unlock
	  pair, so I have added the protection. Please let me know if this is redundant.

	* Other review comments addressed

v2 -> v3:
	* Removed redundant rcu_read_lock()/rcu_read_unlock() pairs
	* Revised the test script based on Ido Schimmel's feedback
	* Updated the test script to ensure compatibility with the latest iperf3 version
	* Fixed new warnings generated with 'C=2' in the previous version
	* Other review comments addressed

v1 -> v2:
	* list_del_rcu() is applied exclusively to legacy multipath code
	* All occurrences of fib6_siblings have been modified to utilize RCU
	  APIs for annotation and usage.
	* Additionally, a test script for reproducing the reported
	  issue is included
---
 net/ipv6/ip6_fib.c                            |   8 +-
 net/ipv6/route.c                              |  45 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/ipv6_route_update_soft_lockup.sh      | 262 ++++++++++++++++++
 4 files changed, 297 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..9a1c59275a10 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1190,8 +1190,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		while (sibling) {
 			if (sibling->fib6_metric == rt->fib6_metric &&
 			    rt6_qualify_for_ecmp(sibling)) {
-				list_add_tail(&rt->fib6_siblings,
-					      &sibling->fib6_siblings);
+				list_add_tail_rcu(&rt->fib6_siblings,
+						  &sibling->fib6_siblings);
 				break;
 			}
 			sibling = rcu_dereference_protected(sibling->fib6_next,
@@ -1252,7 +1252,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 							 fib6_siblings)
 					sibling->fib6_nsiblings--;
 				rt->fib6_nsiblings = 0;
-				list_del_init(&rt->fib6_siblings);
+				list_del_rcu(&rt->fib6_siblings);
 				rt6_multipath_rebalance(next_sibling);
 				return err;
 			}
@@ -1970,7 +1970,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 					 &rt->fib6_siblings, fib6_siblings)
 			sibling->fib6_nsiblings--;
 		rt->fib6_nsiblings = 0;
-		list_del_init(&rt->fib6_siblings);
+		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..b9b986bda943 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -413,8 +413,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *sibling, *next_sibling;
 	struct fib6_info *match = res->f6i;
+	struct fib6_info *sibling;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
 		goto out;
@@ -440,8 +440,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
 		goto out;
 
-	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
-				 fib6_siblings) {
+	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
@@ -5195,14 +5195,18 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
 	 * nexthop. Since sibling routes are always added at the end of
 	 * the list, find the first sibling of the last route appended
 	 */
+	rcu_read_lock();
+
 	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
-		rt = list_first_entry(&rt_last->fib6_siblings,
-				      struct fib6_info,
-				      fib6_siblings);
+		rt = list_first_or_null_rcu(&rt_last->fib6_siblings,
+					    struct fib6_info,
+					    fib6_siblings);
 	}
 
 	if (rt)
 		inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags);
+
+	rcu_read_unlock();
 }
 
 static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
@@ -5547,17 +5551,21 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
 					 &nexthop_len);
 	} else {
-		struct fib6_info *sibling, *next_sibling;
 		struct fib6_nh *nh = f6i->fib6_nh;
+		struct fib6_info *sibling;
 
 		nexthop_len = 0;
 		if (f6i->fib6_nsiblings) {
 			rt6_nh_nlmsg_size(nh, &nexthop_len);
 
-			list_for_each_entry_safe(sibling, next_sibling,
-						 &f6i->fib6_siblings, fib6_siblings) {
+			rcu_read_lock();
+
+			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+						fib6_siblings) {
 				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
 			}
+
+			rcu_read_unlock();
 		}
 		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
 	}
@@ -5721,7 +5729,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 		    lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 			goto nla_put_failure;
 	} else if (rt->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+		struct fib6_info *sibling;
 		struct nlattr *mp;
 
 		mp = nla_nest_start_noflag(skb, RTA_MULTIPATH);
@@ -5733,14 +5741,21 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 				    0) < 0)
 			goto nla_put_failure;
 
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &rt->fib6_siblings, fib6_siblings) {
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
+					fib6_siblings) {
 			if (fib_add_nexthop(skb, &sibling->fib6_nh->nh_common,
 					    sibling->fib6_nh->fib_nh_weight,
-					    AF_INET6, 0) < 0)
+					    AF_INET6, 0) < 0) {
+				rcu_read_unlock();
+
 				goto nla_put_failure;
+			}
 		}
 
+		rcu_read_unlock();
+
 		nla_nest_end(skb, mp);
 	} else if (rt->nh) {
 		if (nla_put_u32(skb, RTA_NH_ID, rt->nh->id))
@@ -6177,7 +6192,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 	err = -ENOBUFS;
 	seq = info->nlh ? info->nlh->nlmsg_seq : 0;
 
-	skb = nlmsg_new(rt6_nlmsg_size(rt), gfp_any());
+	skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
@@ -6190,7 +6205,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		goto errout;
 	}
 	rtnl_notify(skb, net, info->portid, RTNLGRP_IPV6_ROUTE,
-		    info->nlh, gfp_any());
+		    info->nlh, GFP_ATOMIC);
 	return;
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 649f1fe0dc46..88cbac27aa10 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -96,6 +96,7 @@ TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
+TEST_PROGS += ipv6_route_update_soft_lockup.sh
 
 # YNL files, must be before "include ..lib.mk"
 EXTRA_CLEAN += $(OUTPUT)/libynl.a
diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
new file mode 100755
index 000000000000..c61a7a8352cf
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
@@ -0,0 +1,262 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing for potential kernel soft lockup during IPv6 routing table
+# refresh under heavy outgoing IPv6 traffic. If a kernel soft lockup
+# occurs, a kernel panic will be triggered to prevent associated issues.
+#
+#
+#                            Test Environment Layout
+#
+# ┌----------------┐                                         ┌----------------┐
+# |     SOURCE_NS  |                                         |     SINK_NS    |
+# |    NAMESPACE   |                                         |    NAMESPACE   |
+# |(iperf3 clients)|                                         |(iperf3 servers)|
+# |                |                                         |                |
+# |                |                                         |                |
+# |    ┌-----------|                             nexthops    |---------┐      |
+# |    |veth_source|<--------------------------------------->|veth_sink|<┐    |
+# |    └-----------|2001:0DB8:1::0:1/96  2001:0DB8:1::1:1/96 |---------┘ |    |
+# |                |         ^           2001:0DB8:1::1:2/96 |           |    |
+# |                |         .                   .           |       fwd |    |
+# |  ┌---------┐   |         .                   .           |           |    |
+# |  |   IPv6  |   |         .                   .           |           V    |
+# |  | routing |   |         .           2001:0DB8:1::1:80/96|        ┌-----┐ |
+# |  |  table  |   |         .                               |        | lo  | |
+# |  | nexthop |   |         .                               └--------┴-----┴-┘
+# |  | update  |   |         ............................> 2001:0DB8:2::1:1/128
+# |  └-------- ┘   |
+# └----------------┘
+#
+# The test script sets up two network namespaces, source_ns and sink_ns,
+# connected via a veth link. Within source_ns, it continuously updates the
+# IPv6 routing table by flushing and inserting IPV6_NEXTHOP_ADDR_COUNT nexthop
+# IPs destined for SINK_LOOPBACK_IP_ADDR in sink_ns. This refresh occurs at a
+# rate of 1/ROUTING_TABLE_REFRESH_PERIOD per second for TEST_DURATION seconds.
+#
+# Simultaneously, multiple iperf3 clients within source_ns generate heavy
+# outgoing IPv6 traffic. Each client is assigned a unique port number starting
+# at 5000 and incrementing sequentially. Each client targets a unique iperf3
+# server running in sink_ns, connected to the SINK_LOOPBACK_IFACE interface
+# using the same port number.
+#
+# The number of iperf3 servers and clients is set to half of the total
+# available cores on each machine.
+#
+# NOTE: We have tested this script on machines with various CPU specifications,
+# ranging from lower to higher performance as listed below. The test script
+# effectively triggered a kernel soft lockup on machines running an unpatched
+# kernel in under a minute:
+#
+# - 1x Intel Xeon E-2278G 8-Core Processor @ 3.40GHz
+# - 1x Intel Xeon E-2378G Processor 8-Core @ 2.80GHz
+# - 1x AMD EPYC 7401P 24-Core Processor @ 2.00GHz
+# - 1x AMD EPYC 7402P 24-Core Processor @ 2.80GHz
+# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
+# - 1x Ampere Altra Q80-30 80-Core Processor @ 3.00GHz
+# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
+# - 2x Intel Xeon Silver 4214 24-Core Processor @ 2.20GHz
+# - 1x AMD EPYC 7502P 32-Core @ 2.50GHz
+# - 1x Intel Xeon Gold 6314U 32-Core Processor @ 2.30GHz
+# - 2x Intel Xeon Gold 6338 32-Core Processor @ 2.00GHz
+#
+# On less performant machines, you may need to increase the TEST_DURATION
+# parameter to enhance the likelihood of encountering a race condition leading
+# to a kernel soft lockup and avoid a false negative result.
+#
+# NOTE: The test may not produce the expected result in virtualized
+# environments (e.g., qemu) due to differences in timing and CPU handling,
+# which can affect the conditions needed to trigger a soft lockup.
+
+source lib.sh
+source net_helper.sh
+
+TEST_DURATION=300
+ROUTING_TABLE_REFRESH_PERIOD=0.01
+
+IPERF3_BITRATE="300m"
+
+
+IPV6_NEXTHOP_ADDR_COUNT="128"
+IPV6_NEXTHOP_ADDR_MASK="96"
+IPV6_NEXTHOP_PREFIX="2001:0DB8:1"
+
+
+SOURCE_TEST_IFACE="veth_source"
+SOURCE_TEST_IP_ADDR="2001:0DB8:1::0:1/96"
+
+SINK_TEST_IFACE="veth_sink"
+# ${SINK_TEST_IFACE} is populated with the following range of IPv6 addresses:
+# 2001:0DB8:1::1:1  to 2001:0DB8:1::1:${IPV6_NEXTHOP_ADDR_COUNT}
+SINK_LOOPBACK_IFACE="lo"
+SINK_LOOPBACK_IP_MASK="128"
+SINK_LOOPBACK_IP_ADDR="2001:0DB8:2::1:1"
+
+nexthop_ip_list=""
+termination_signal=""
+kernel_softlokup_panic_prev_val=""
+
+terminate_ns_processes_by_pattern() {
+	local ns=$1
+	local pattern=$2
+
+	for pid in $(ip netns pids ${ns}); do
+		[ -e /proc/$pid/cmdline ] && grep -qe "${pattern}" /proc/$pid/cmdline && kill -9 $pid
+	done
+}
+
+cleanup() {
+	echo "info: cleaning up namespaces and terminating all processes within them..."
+
+
+	# Terminate iperf3 instances running in the source_ns. To avoid race
+	# conditions, first iterate over the PIDs and terminate those
+	# associated with the bash shells running the
+	# `while true; do iperf3 -c ...; done` loops. In a second iteration,
+	# terminate the individual `iperf3 -c ...` instances.
+	terminate_ns_processes_by_pattern ${source_ns} while
+	terminate_ns_processes_by_pattern ${source_ns} iperf3
+
+	# Repeat the same process for sink_ns
+	terminate_ns_processes_by_pattern ${sink_ns} while
+	terminate_ns_processes_by_pattern ${sink_ns} iperf3
+
+	# Check if any iperf3 instances are still running. This could happen
+	# if a core has entered an infinite loop and the timeout for detecting
+	# the soft lockup has not expired, but either the test interval has
+	# already elapsed or the test was terminated manually (e.g., with ^C)
+	for pid in $(ip netns pids ${source_ns}); do
+		if [ -e /proc/$pid/cmdline ] && grep -qe 'iperf3' /proc/$pid/cmdline; then
+			echo "FAIL: unable to terminate some iperf3 instances. Soft lockup is underway. A kernel panic is on the way!"
+			exit ${ksft_fail}
+		fi
+	done
+
+	if [ "$termination_signal" == "SIGINT" ]; then
+		echo "SKIP: Termination due to ^C (SIGINT)"
+	elif [ "$termination_signal" == "SIGALRM" ]; then
+		echo "PASS: No kernel soft lockup occurred during this ${TEST_DURATION} second test"
+	fi
+
+	cleanup_ns ${source_ns} ${sink_ns}
+
+	sysctl -qw kernel.softlockup_panic=${kernel_softlokup_panic_prev_val}
+}
+
+setup_prepare() {
+	setup_ns source_ns sink_ns
+
+	ip -n ${source_ns} link add name ${SOURCE_TEST_IFACE} type veth peer name ${SINK_TEST_IFACE} netns ${sink_ns}
+
+	# Setting up the Source namespace
+	ip -n ${source_ns} addr add ${SOURCE_TEST_IP_ADDR} dev ${SOURCE_TEST_IFACE}
+	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} qlen 10000
+	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} up
+	ip netns exec ${source_ns} sysctl -qw net.ipv6.fib_multipath_hash_policy=1
+
+	# Setting up the Sink namespace
+	ip -n ${sink_ns} addr add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} dev ${SINK_LOOPBACK_IFACE}
+	ip -n ${sink_ns} link set dev ${SINK_LOOPBACK_IFACE} up
+	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_LOOPBACK_IFACE}.forwarding=1
+
+	ip -n ${sink_ns} link set ${SINK_TEST_IFACE} up
+	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_TEST_IFACE}.forwarding=1
+
+
+	# Populate nexthop IPv6 addresses on the test interface in the sink_ns
+	echo "info: populating ${IPV6_NEXTHOP_ADDR_COUNT} IPv6 addresses on the ${SINK_TEST_IFACE} interface ..."
+	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+		ip -n ${sink_ns} addr add ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" "${IP}")/${IPV6_NEXTHOP_ADDR_MASK} dev ${SINK_TEST_IFACE};
+	done
+
+	# Preparing list of nexthops
+	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+		nexthop_ip_list=$nexthop_ip_list" nexthop via ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" $IP) dev ${SOURCE_TEST_IFACE} weight 1"
+	done
+}
+
+
+test_soft_lockup_during_routing_table_refresh() {
+	# Start num_of_iperf_servers iperf3 servers in the sink_ns namespace,
+	# each listening on ports starting at 5001 and incrementing
+	# sequentially. Since iperf3 instances may terminate unexpectedly, a
+	# while loop is used to automatically restart them in such cases.
+	echo "info: starting ${num_of_iperf_servers} iperf3 servers in the sink_ns namespace ..."
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd="iperf3 --bind ${SINK_LOOPBACK_IP_ADDR} -s -p $(printf '5%03d' ${i}) --rcv-timeout 200 &>/dev/null"
+		ip netns exec ${sink_ns} bash -c "while true; do ${cmd}; done &" &>/dev/null
+	done
+
+	# Wait for the iperf3 servers to be ready
+	for i in $(seq ${num_of_iperf_servers}); do
+		port=$(printf '5%03d' ${i});
+		wait_local_port_listen ${sink_ns} ${port} tcp
+	done
+
+	# Continuously refresh the routing table in the background within
+	# the source_ns namespace
+	ip netns exec ${source_ns} bash -c "
+		while \$(ip netns list | grep -q ${source_ns}); do
+			ip -6 route add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} ${nexthop_ip_list};
+			sleep ${ROUTING_TABLE_REFRESH_PERIOD};
+			ip -6 route delete ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK};
+		done &"
+
+	# Start num_of_iperf_servers iperf3 clients in the source_ns namespace,
+	# each sending TCP traffic on sequential ports starting at 5001.
+	# Since iperf3 instances may terminate unexpectedly (e.g., if the route
+	# to the server is deleted in the background during a route refresh), a
+	# while loop is used to automatically restart them in such cases.
+	echo "info: starting ${num_of_iperf_servers} iperf3 clients in the source_ns namespace ..."
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd="iperf3 -c ${SINK_LOOPBACK_IP_ADDR} -p $(printf '5%03d' ${i}) --length 64 --bitrate ${IPERF3_BITRATE} -t 0 --connect-timeout 150 &>/dev/null"
+		ip netns exec ${source_ns} bash -c "while true; do ${cmd}; done &" &>/dev/null
+	done
+
+	echo "info: IPv6 routing table is being updated at the rate of $(echo "1/${ROUTING_TABLE_REFRESH_PERIOD}" | bc)/s for ${TEST_DURATION} seconds ..."
+	echo "info: A kernel soft lockup, if detected, results in a kernel panic!"
+
+	wait
+}
+
+# Make sure 'iperf3' is installed, skip the test otherwise
+if [ ! -x "$(command -v "iperf3")" ]; then
+	echo "SKIP: 'iperf3' is not installed. Skipping the test."
+	exit ${ksft_skip}
+fi
+
+# Determine the number of cores on the machine
+num_of_iperf_servers=$(( $(nproc)/2 ))
+
+# Check if we are running on a multi-core machine, skip the test otherwise
+if [ "${num_of_iperf_servers}" -eq 0 ]; then
+	echo "SKIP: This test is not valid on a single core machine!"
+	exit ${ksft_skip}
+fi
+
+# Since the kernel soft lockup we're testing causes at least one core to enter
+# an infinite loop, destabilizing the host and likely affecting subsequent
+# tests, we trigger a kernel panic instead of reporting a failure and
+# continuing
+kernel_softlokup_panic_prev_val=$(sysctl -n kernel.softlockup_panic)
+sysctl -qw kernel.softlockup_panic=1
+
+handle_sigint() {
+	termination_signal="SIGINT"
+	cleanup
+	exit ${ksft_skip}
+}
+
+handle_sigalrm() {
+	termination_signal="SIGALRM"
+	cleanup
+	exit ${ksft_pass}
+}
+
+trap handle_sigint SIGINT
+trap handle_sigalrm SIGALRM
+
+(sleep ${TEST_DURATION} && kill -s SIGALRM $$)&
+
+setup_prepare
+test_soft_lockup_during_routing_table_refresh
-- 
2.43.0


