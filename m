Return-Path: <netdev+bounces-110328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D492BE98
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1721C21E77
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CCB19DF4D;
	Tue,  9 Jul 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b="fdXZDTYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C117B425
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539472; cv=none; b=TpbhbpF5LbgnayoIlwsK7wvvRjBv2Vxp7lf3J23s1z8sOGOlZ1HXuqu6LrWUmsy9qqIIK/TbXpcCQKGbxRk3AZ1HGGVya0kbTVi1xVaB0/dvYlsDWs/t8OXk8ryulWwzgxxY9JXDmaRJfV/0NXNVH5VmmJWWbcDAwxyhMQOdx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539472; c=relaxed/simple;
	bh=4yKRx/eFxnC0VPiwgySNhjQl8TVkpgetCSuGeZtkhiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Koa3MLtK9KS0OIlIXR2lsOoBWFsWbr4sJu/ug61OhZkwoH/bdDYz3fg0nRAUgzVEnQc25aXJBHeNc1r8gs0hHZFhhc6hn/IlRaMxuFOnM+qze4/fX/67Ap6mtyddHf2t2kLrV7cYnAAt8FrqhP73eftMzFROTXBiMelECCDI/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com; spf=pass smtp.mailfrom=menlosecurity.com; dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b=fdXZDTYx; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=menlosecurity.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-1fb0d88fd25so35397735ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 08:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539469; x=1721144269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/RTQ3ucxF1wYeXeTCkZ5ExWhRuKhtPnbYb2EgJ8VGY=;
        b=fr7yMApMb+yGTi8yyaffkn+nS8u91Pb4wuytQpXTSVhE+tpgkfZFQsnhr20jcS2jxe
         9e1ScTbl38oQR7lrRqwG1/qI5PmA9J2Cv2s4AZyzSZF6szuqq8/kaBonPC6Uv0uiAJAc
         rYUbge9+5JFBd3V7UXvljHsGVwBG5eFnaWDs40ix/iIYN/qCAU8YvDXF7esWMZxYdz5z
         o3+wgN3YCpUUYwZf9mxTlMPVrZP7ZxVTbjzcr4cJ0oMvkx9v/dAdAL4Z0D6T49WnMg2n
         ewh3WekqaRqu/0L+MhBv1YrOphgVuXc/qt5i0BtlGjoJpvFjobRwOwiye1IgGtkXvECS
         f1kw==
X-Gm-Message-State: AOJu0Yx3cVy0N2ZjU/b6XRHk7DHG9TcAvoEhQyKtxGu2aYCZDhfeBSOX
	K5P97EUnbdtN2e1b22MuJtRYEHEGbpU+z7z9Rvd/PBLI1za907l8lHJnO435EI5UqcL5r4Pqspf
	iLZMitzPy6CEPrPi1cpS4rw8pBDk7EfD6k+IDMWX5QCc=
X-Google-Smtp-Source: AGHT+IENeG9pGsbaSeK+bHR/xqZS0T1AaPjGmHXrr0c12p6jLSL2+4m93Pfapq2ug/5aw0cJjRwaVUICj+Kb
X-Received: by 2002:a17:903:234b:b0:1fb:9cb0:3e46 with SMTP id d9443c01a7336-1fbb7f7a931mr38544755ad.7.1720539469184;
        Tue, 09 Jul 2024 08:37:49 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.190])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-1fbb6a131fbsm472465ad.1.2024.07.09.08.37.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:37:49 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-029060369cr-re.menlosecurity.com (34.202.62.166)
    by restore.menlosecurity.com (34.202.62.190)
    with SMTP id 31c13c70-3e09-11ef-b324-0591338826e4;
    Tue, 09 Jul 2024 15:37:49 GMT
Received: from mail-pl1-f198.google.com (209.85.214.198)
    by safemail-prod-029060369cr-re.menlosecurity.com (34.202.62.166)
    with SMTP id 31c13c70-3e09-11ef-b324-0591338826e4;
    Tue, 09 Jul 2024 15:37:49 GMT
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fb294a0915so45924135ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google; t=1720539467; x=1721144267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/RTQ3ucxF1wYeXeTCkZ5ExWhRuKhtPnbYb2EgJ8VGY=;
        b=fdXZDTYxfIZsKmACUV/5+29qNSJhP/S4F2S9S85tX5dbGH6eI5Z24FneY1P6PybxjJ
         qxkmaz95EEiFe00x2ny8HDEcz3vZWz3mCHUWuOwwh9SlThVml/I2TDckyfxXeOClo7gT
         gJOwJ/WGxnd9mZ50otD2aRCgl/+DLssZukNfQ=
X-Received: by 2002:a17:902:e74d:b0:1f9:ccd0:2aa3 with SMTP id d9443c01a7336-1fbb80813e0mr33319525ad.33.1720539466446;
        Tue, 09 Jul 2024 08:37:46 -0700 (PDT)
X-Received: by 2002:a17:902:e74d:b0:1f9:ccd0:2aa3 with SMTP id d9443c01a7336-1fbb80813e0mr33319225ad.33.1720539465780;
        Tue, 09 Jul 2024 08:37:45 -0700 (PDT)
Received: from localhost.localdomain ([108.63.133.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6c32sm17614635ad.165.2024.07.09.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:37:45 -0700 (PDT)
From: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	adrian.oliver@menlosecurity.com,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Subject: [PATCH v2] net/ipv6: Fix soft lockups in fib6_select_path under high next hop churn
Date: Tue,  9 Jul 2024 08:37:28 -0700
Message-Id: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
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

To fix this issue, I applied RCU primitives in the problematic code
sections, which successfully resolved the issue within our testing
parameters and in the production environment where the issue was first
observed. Additionally, all references to fib6_siblings have been updated
to annotate or use the RCU APIs.

A test script that reproduces this issue is included with this patch. The
script periodically updates the routing table while generating a heavy load
of outgoing IPv6 traffic through multiple iperf3 clients. I have tested
this script on various machines, ranging from low to high performance, as
detailed in the comment section of the test script. It consistently induces
soft lockups within a minute.

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

Reported-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Tested-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
---
v2:
	* list_del_rcu() is applied exclusively to legacy multipath code
	* All occurrences of fib6_siblings have been modified to utilize RCU
	  APIs for annotation and usage.
	* Additionally, a test script for reproducing the reported
	  issue is included
---
 include/net/ip6_fib.h                         |   2 +-
 net/ipv6/ip6_fib.c                            |  24 +-
 net/ipv6/route.c                              |  40 ++--
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/ipv6_route_update_soft_lockup.sh      | 217 ++++++++++++++++++
 5 files changed, 260 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 6cb867ce4878..167ef421bcb0 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -166,7 +166,7 @@ struct fib6_info {
 	 * to speed up lookup.
 	 */
 	union {
-		struct list_head	fib6_siblings;
+		struct list_head __rcu	fib6_siblings;
 		struct list_head	nh_list;
 	};
 	unsigned int			fib6_nsiblings;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 83e4f9855ae1..6202575b2c20 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -518,7 +518,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 static int fib6_dump_node(struct fib6_walker *w)
 {
 	int res;
-	struct fib6_info *rt;
+	struct fib6_info *rt, *sibling, *last_sibling;
 
 	for_each_fib6_walker_rt(w) {
 		res = rt6_dump_route(rt, w->args, w->skip_in_node);
@@ -540,10 +540,16 @@ static int fib6_dump_node(struct fib6_walker *w)
 		 * last sibling of this route (no need to dump the
 		 * sibling routes again)
 		 */
-		if (rt->fib6_nsiblings)
-			rt = list_last_entry(&rt->fib6_siblings,
-					     struct fib6_info,
-					     fib6_siblings);
+		rcu_read_lock();
+		if (rt->fib6_nsiblings) {
+			last_sibling = rt;
+			list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
+						fib6_siblings)
+				last_sibling = sibling;
+
+			rt = last_sibling;
+		}
+		rcu_read_unlock();
 	}
 	w->leaf = NULL;
 	return 0;
@@ -1190,8 +1196,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
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
@@ -1252,7 +1258,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 							 fib6_siblings)
 					sibling->fib6_nsiblings--;
 				rt->fib6_nsiblings = 0;
-				list_del_init(&rt->fib6_siblings);
+				list_del_rcu(&rt->fib6_siblings);
 				rt6_multipath_rebalance(next_sibling);
 				return err;
 			}
@@ -1970,7 +1976,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 					 &rt->fib6_siblings, fib6_siblings)
 			sibling->fib6_nsiblings--;
 		rt->fib6_nsiblings = 0;
-		list_del_init(&rt->fib6_siblings);
+		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8d72ca0b086d..4bca06dce176 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -415,7 +415,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *sibling, *next_sibling;
+	struct fib6_info *sibling;
 	struct fib6_info *match = res->f6i;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
@@ -442,8 +442,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
 		goto out;
 
-	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
-				 fib6_siblings) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
@@ -455,6 +456,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		match = sibling;
 		break;
 	}
+	rcu_read_unlock();
 
 out:
 	res->f6i = match;
@@ -4711,10 +4713,12 @@ static int rt6_multipath_total_weight(const struct fib6_info *rt)
 	if (!rt6_is_dead(rt))
 		total += rt->fib6_nh->fib_nh_weight;
 
-	list_for_each_entry(iter, &rt->fib6_siblings, fib6_siblings) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(iter, &rt->fib6_siblings, fib6_siblings) {
 		if (!rt6_is_dead(iter))
 			total += iter->fib6_nh->fib_nh_weight;
 	}
+	rcu_read_unlock();
 
 	return total;
 }
@@ -5197,14 +5201,16 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
 	 * nexthop. Since sibling routes are always added at the end of
 	 * the list, find the first sibling of the last route appended
 	 */
+	rcu_read_lock();
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
+	rcu_read_unlock();
 }
 
 static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
@@ -5549,17 +5555,19 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
 					 &nexthop_len);
 	} else {
-		struct fib6_info *sibling, *next_sibling;
+		struct fib6_info *sibling;
 		struct fib6_nh *nh = f6i->fib6_nh;
 
 		nexthop_len = 0;
 		if (f6i->fib6_nsiblings) {
 			rt6_nh_nlmsg_size(nh, &nexthop_len);
 
-			list_for_each_entry_safe(sibling, next_sibling,
-						 &f6i->fib6_siblings, fib6_siblings) {
+			rcu_read_lock();
+			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+						fib6_siblings) {
 				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
 			}
+			rcu_read_unlock();
 		}
 		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
 	}
@@ -5818,13 +5826,17 @@ static bool fib6_info_uses_dev(const struct fib6_info *f6i,
 		return true;
 
 	if (f6i->fib6_nsiblings) {
-		struct fib6_info *sibling, *next_sibling;
+		struct fib6_info *sibling;
 
-		list_for_each_entry_safe(sibling, next_sibling,
-					 &f6i->fib6_siblings, fib6_siblings) {
-			if (sibling->fib6_nh->fib_nh_dev == dev)
+		rcu_read_lock();
+		list_for_each_entry_rcu(sibling,
+					&f6i->fib6_siblings, fib6_siblings) {
+			if (sibling->fib6_nh->fib_nh_dev == dev) {
+				rcu_read_unlock();
 				return true;
+			}
 		}
+		rcu_read_unlock();
 	}
 
 	return false;
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index d9393569d03a..35e3687397da 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -93,6 +93,7 @@ TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
+TEST_PROGS += ipv6_route_update_soft_lockup.sh
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
new file mode 100755
index 000000000000..6e2a1e4dd0a6
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
@@ -0,0 +1,217 @@
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
+# ┌-----------------┐                                             ┌------------------┐
+# |     SOURCE_NS   |                                             |     SINK_NS      |
+# |    NAMESPACE    |                                             |    NAMESPACE     |
+# |(iperf3 clients) |                                             | (iperf3 servers) |
+# |                 |                                             |                  |
+# |                 |                                             |                  |
+# |     ┌-----------|                             nexthops        |---------┐        |
+# |     |veth_source|<------------------------------------------->|veth_sink|<-┐     |
+# |     └-----------| 2001:0DB8:1::0:1/96     2001:0DB8:1::1:1/96 |---------┘  |     |
+# |                 |         ^               2001:0DB8:1::1:2/96 |            |     |
+# |                 |         .                       .           |            | fwd |
+# |   ┌---------┐   |         .                       .           |            |     |
+# |   |   IPv6  |   |         .                       .           |            V     |
+# |   | routing |   |         .               2001:0DB8:1::1:90/96|         ┌-----┐  |
+# |   |  table  |   |         .                                   |         | lo  |  |
+# |   | nexthop |   |         .                                   └---------┴-----┴--┘
+# |   | update  |   |         ..................................> 2001:0DB8:2::1:1/128
+# |   └-------- ┘   |
+# └-----------------┘
+#
+# The test script sets up two network namespaces, SOURCE_NS and SINK_NS,
+# connected via a veth link. Within SOURCE_NS, it continuously updates the
+# IPv6 routing table by flushing and inserting IPV6_NEXTHOP_ADDR_COUNT nexthop
+# IPs destined for SINK_LOOPBACK_IP_ADDR in SINK_NS. This refresh occurs at a
+# rate of 1/ROUTING_TABLE_REFRESH_PERIOD per second for TEST_DURATION seconds.
+#
+# Simultaneously, multiple iperf3 clients within SOURCE_NS generate heavy
+# outgoing IPv6 traffic. Each client is assigned a unique port number starting
+# at 5000 and incrementing sequentially. Each client targets a unique iperf3
+# server running in SINK_NS, connected to the SINK_LOOPBACK_IFACE interface
+# using the same port number.
+#
+# The number of iperf3 servers and clients is set to half of the total
+# available cores on each machine.
+#
+# NOTE:  We have tested this script on machines with various CPU specifications,
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
+
+
+TEST_DURATION=120
+export ROUTING_TABLE_REFRESH_PERIOD=0.01
+
+export IPERF3_BITRATE="300m"
+
+
+export IPV6_NEXTHOP_ADDR_COUNT="144"
+export IPV6_NEXTHOP_ADDR_MASK="96"
+export IPV6_NEXTHOP_PREFIX="2001:0DB8:1"
+
+
+export SOURCE_NS="source_ns"
+export SOURCE_TEST_IFACE="veth_source"
+export SOURCE_TEST_IP_ADDR="2001:0DB8:1::0:1/96"
+
+export SINK_NS="sink_ns"
+export SINK_TEST_IFACE="veth_sink"
+# ${SINK_TEST_IFACE} is populated with the following range of IPv6 addresses:
+# 2001:0DB8:1::1:1  to 2001:0DB8:1::1:${IPV6_NEXTHOP_ADDR_COUNT}
+export SINK_LOOPBACK_IFACE="lo"
+export SINK_LOOPBACK_IP_MASK="128"
+export SINK_LOOPBACK_IP_ADDR="2001:0DB8:2::1:1"
+
+nexthop_ip_list=""
+termination_signal=""
+
+cleanup() {
+	echo "info: cleaning up namespaces and terminating all processes within them..."
+
+	kill -9 $(pgrep -f "iperf3")
+
+	# Give some time for processes to terminate
+	sleep 2
+
+	# Check if any iperf3 instances are still running
+	if pgrep -f "iperf3" > /dev/null; then
+		echo "FAIL: unable to terminate some iperf3 instances. Soft lockup is underway. A kernel panic is on the way!"
+		exit 1
+	else
+		if [ "$termination_signal" == "SIGINT" ]; then
+			echo "info: Termination due to ^C (SIGINT)"
+		elif [ "$termination_signal" == "SIGALRM" ]; then
+			echo "PASS: No kernel soft lockup occurred during this ${TEST_DURATION} second test"
+		fi
+	fi
+
+	ip netns delete ${SINK_NS}
+	ip netns delete ${SOURCE_NS}
+}
+
+setup_prepare() {
+	ip netns add ${SOURCE_NS}
+	ip netns add ${SINK_NS}
+
+	ip link add ${SOURCE_TEST_IFACE} type veth peer name ${SINK_TEST_IFACE}
+
+	ip link set ${SOURCE_TEST_IFACE} netns ${SOURCE_NS}
+	ip link set ${SINK_TEST_IFACE}   netns ${SINK_NS}
+
+	# Setting up the Source namespace
+	ip netns exec ${SOURCE_NS} ip addr add ${SOURCE_TEST_IP_ADDR} dev ${SOURCE_TEST_IFACE}
+	ip netns exec ${SOURCE_NS} ip link set dev ${SOURCE_TEST_IFACE} qlen 10000
+	ip netns exec ${SOURCE_NS} ip link set dev ${SOURCE_TEST_IFACE} up
+	ip netns exec ${SOURCE_NS} sysctl -qw net.ipv6.fib_multipath_hash_policy=1
+
+	# Setting up the Sink namespace
+	ip netns exec ${SINK_NS} ip addr add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} dev ${SINK_LOOPBACK_IFACE}
+	ip netns exec ${SINK_NS} ip link set dev ${SINK_LOOPBACK_IFACE} up
+	ip netns exec ${SINK_NS} sysctl -qw net.ipv6.conf.${SINK_LOOPBACK_IFACE}.forwarding=1
+
+	ip netns exec ${SINK_NS} ip link set ${SINK_TEST_IFACE} up
+	ip netns exec ${SINK_NS} sysctl -qw net.ipv6.conf.${SINK_TEST_IFACE}.forwarding=1
+
+
+	# Populating Nexthop IPv6 addresses on the test interface of the SINK_NS namespace
+	echo "info: populating ${IPV6_NEXTHOP_ADDR_COUNT} IPv6 addresses on the ${SINK_TEST_IFACE} interface ..."
+	ip netns exec ${SINK_NS} bash -c '
+		for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+			ip addr add ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" "${IP}")/${IPV6_NEXTHOP_ADDR_MASK} dev ${SINK_TEST_IFACE};
+		done'
+
+	# Preparing list of nexthops
+	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
+		nexthop_ip_list=$nexthop_ip_list" nexthop via ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" $IP) dev ${SOURCE_TEST_IFACE} weight 1"
+	done
+
+	export nexthop_ip_list
+}
+
+
+test_soft_lockup_during_routing_table_refresh() {
+	# Start num_of_iperf_servers iperf3 servers in the SINK_NS namespace, each listening on ports
+	# starting at 5001 and incrementing sequentially.
+	echo "info: starting ${num_of_iperf_servers} iperf3 servers in the ${SINK_NS} namespace ..."
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd="iperf3 --bind ${SINK_LOOPBACK_IP_ADDR} -s -p $(printf '5%03d' ${i}) > /dev/null 2>&1"
+		ip netns exec ${SINK_NS} bash -c "while true; do ${cmd}; done &"
+	done
+
+	# Continuously refresh the routing table in background in the Source namespase
+	ip netns exec ${SOURCE_NS} bash -c '
+		while $(ip netns list | grep -q ${SOURCE_NS}); do
+			ip -6 route add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} ${nexthop_ip_list};
+			sleep ${ROUTING_TABLE_REFRESH_PERIOD};
+			ip -6 route delete ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK};
+		done &'
+
+	# Start num_of_iperf_servers iperf3 clients in the SOURCE_NS namespace, each sending UDP packets on sequential ports starting at 5001
+	echo "info: starting ${num_of_iperf_servers} iperf3 clients in the ${SOURCE_NS} namespace ..."
+	for i in $(seq 1 ${num_of_iperf_servers}); do
+		cmd="iperf3 -c ${SINK_LOOPBACK_IP_ADDR} -p $(printf '5%03d' ${i}) --udp --length 64 --bitrate ${IPERF3_BITRATE} -t 0 > /dev/null 2>&1"
+		ip netns exec ${SOURCE_NS} bash -c "while true; do ${cmd}; done &"
+	done
+
+	echo "info: IPv6 routing table is being updated at the rate of $(echo "1/${ROUTING_TABLE_REFRESH_PERIOD}" | bc)/s for ${TEST_DURATION} seconds ..."
+	echo "info: A kernel soft lockup, if detected, results in a kernel panic!"
+
+	wait
+}
+
+# Determine the number of cores on the machine
+num_of_iperf_servers=$(( $(nproc)/2 ))
+
+# Check if we are running on a multi-core machine, exit otherwise
+if [ "${num_of_iperf_servers}" -eq 0 ]; then
+	echo "FAIL: This test is not valid on a single core machine!"
+	exit 1
+fi
+
+sysctl -qw kernel.softlockup_panic=1
+
+handle_sigint() {
+	termination_signal="SIGINT"
+	cleanup
+	exit 1
+}
+
+handle_sigalrm() {
+	termination_signal="SIGALRM"
+	cleanup
+	exit 0
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
2.34.1


