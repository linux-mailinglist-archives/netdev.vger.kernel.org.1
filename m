Return-Path: <netdev+bounces-96249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39818C4B94
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DAC1C21417
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF1DDBB;
	Tue, 14 May 2024 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b="jHu1216T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26CBE47
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715659707; cv=none; b=RCdfJUODVkt7KDvxG6iSj7Hu5jHbK135p4QW7MNiR5RV10EK0wNihdalHVrNSCvZGX3tDFYzFDy94Cz8G4SnZ3xAjsD4n48qbodA31H/hDYJiZTstqbDJAHqoiDmSPwcMyRoLfgp1L/XKqNhLR3GRd+19CRQJq6f+CopehE172I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715659707; c=relaxed/simple;
	bh=Gkssj7fVV8DWBaS/VSJJY1GpSWJnjm1oZcE2ZAsuAeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZqHFMdbNf8HvsgfJHBVF3kK6xVlkaEVKou819t3dQXp+h15pkbmUTnF+AQR0J1S0PHSdTsix0wD2Ux0wh7psJi/OJyUbaqQJ3T1/aVFEZgI/6TBockcQsMIjCGB0aHChbe3yV1oSvv2OyAcgSeMlGfT7lUNKwOVEcPw7A0LJyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com; spf=pass smtp.mailfrom=menlosecurity.com; dkim=pass (1024-bit key) header.d=menlosecurity.com header.i=@menlosecurity.com header.b=jHu1216T; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=menlosecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=menlosecurity.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-78f043eaee9so346658485a.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715659704; x=1716264504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00pZGSfZvxtd2x6OPcAwxm2rcxM/6aU6eD+HxhDSMGY=;
        b=IgUiMqJ5yyouzN2zRGQBb7Y6tUWG33P7aOPBmdmUpXmtKn0d8Sp7+M3Yt2qVZ36rBn
         IvPpTpInzjoNWYTPxlF3l52Fog+/wHFDqVHFISj3jm5lt9oD8clIz5HygEyo0+OE/37t
         ZA7OqMFUNBx/q2E01O3ceG/X/xLurfXKV1iMzjmnEw95Ytki5JE6O4X9TB+ZRg7+K6qE
         f5tTr5ja9Z5BrtFJ4X3Ejyhyf8p85mMcD9Ttu/Giq/yO1W9ZbkPect0UMvkTEFz5j/3O
         PM/J99+EDXkow1c2NBiy2xmjezEVfPpDcuEMoSYNz9VGI/CnchKba+1rXnbcROGZdOhk
         pCUA==
X-Gm-Message-State: AOJu0Yw8lzqYea50aG53sAflxasZP0OhalISykX9/TIdXiVXHlLEIjDv
	KUAFrcMi5ZZXpkxIAfZyw4+AUNFEzCyPPkPE+YPkmi0IQUIq7iLn5z+WAe6o2BkPlsomXc9yPIw
	4hpMvgOKv8nzUiqhnJn3O/hFE44ZBjSv9cGfgVtMBObI=
X-Google-Smtp-Source: AGHT+IGDGTUv/CwCIwyFdHFpf3XEc3eax/vNbTWKymAorydOk6ICDJzuSlEDb4htx01TWTCj90r5lZttGy9O
X-Received: by 2002:a05:6214:5885:b0:6a0:7d91:8752 with SMTP id 6a1803df08f44-6a16825d75bmr141021856d6.58.1715659704539;
        Mon, 13 May 2024 21:08:24 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.63])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6a15f1ab5c8sm6634786d6.7.2024.05.13.21.08.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 21:08:24 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-029060369cr-re.menlosecurity.com (13.56.32.52)
    by restore.menlosecurity.com (13.56.32.63)
    with SMTP id 9acafe60-11a7-11ef-b5a9-a1c600cc9c19;
    Tue, 14 May 2024 04:08:24 GMT
Received: from mail-oo1-f70.google.com (209.85.161.70)
    by safemail-prod-029060369cr-re.menlosecurity.com (13.56.32.52)
    with SMTP id 9acafe60-11a7-11ef-b5a9-a1c600cc9c19;
    Tue, 14 May 2024 04:08:23 GMT
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5aa253241ecso8659883eaf.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google; t=1715659701; x=1716264501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00pZGSfZvxtd2x6OPcAwxm2rcxM/6aU6eD+HxhDSMGY=;
        b=jHu1216TH/E/sDlI3G507ghuLEuR9105IfLiPHJkPuXQsWuiWttHmcbiyBAi+Z7as0
         i+Ey5SjdvrQBeTLJ2dkeUwWJyLhBJNYsqS7KGaoxaQi1IgoeQBXnP+bLZEmdCTcxpLcu
         tgF2HUjSlmX3K63MBCI6btWUXIqTDGeq5tbVI=
X-Received: by 2002:a05:6358:2826:b0:18d:f1bc:904a with SMTP id e5c5f4694b2df-193bb518116mr1282544655d.9.1715659701195;
        Mon, 13 May 2024 21:08:21 -0700 (PDT)
X-Received: by 2002:a05:6358:2826:b0:18d:f1bc:904a with SMTP id e5c5f4694b2df-193bb518116mr1282543255d.9.1715659700653;
        Mon, 13 May 2024 21:08:20 -0700 (PDT)
Received: from localhost.localdomain ([108.63.133.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634119041b2sm7353904a12.94.2024.05.13.21.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 21:08:20 -0700 (PDT)
From: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	adrian.oliver@menlosecurity.com,
	Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Subject: [PATCH] net/ipv6: Fix kernel soft lockup in fib6_select_path under high  next hop churn
Date: Mon, 13 May 2024 21:07:57 -0700
Message-Id: <20240514040757.1957761-1-omid.ehtemamhaghighi@menlosecurity.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kernel soft lockups have been observed in clusters of Linux-based edge
routers located in a highly dynamic environment. These routers
consistently update BGP-advertised routes due to frequently changing 
next hop destinations, while managing significant IPv6 traffic. The
lockups occur during the traversal of the multipath circular linked-list
in the fib6_select_path function, particularly while iterating through
siblings in the list. The issue arises when nodes in the linked list are
unexpectedly deleted concurrently on another CPU core—indicated by their
'next' and 'previous' elements pointing back to the node itself and
their reference count dropping to zero. This causes an infinite loop,
leading to a kernel soft lockup that triggers a kernel panic via the
watchdog timer (log attached below).

To reproduce the issue, we set up a test environment designed to simulate
the conditions that lead to soft lockups. This was achieved by periodically
modifying the routing table and generating a heavy load of outgoing IPv6
traffic through four iperf3 clients. This setup consistently triggered
soft lockups in less than a minute.

As a solution, I applied RCU locks in places that are identified as
culprits, which has successfully resolved the issue within our testing
parameters.

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

Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
---
 net/ipv6/ip6_fib.c | 6 +++---
 net/ipv6/route.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index c1f62352a481..b4f3627dd045 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1037,7 +1037,7 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 	fib6_drop_pcpu_from(rt, table);
 
 	if (rt->nh && !list_empty(&rt->nh_list))
-		list_del_init(&rt->nh_list);
+		list_del_rcu(&rt->nh_list);
 
 	if (refcount_read(&rt->fib6_ref) != 1) {
 		/* This route is used as dummy address holder in some split
@@ -1247,7 +1247,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 							 fib6_siblings)
 					sibling->fib6_nsiblings--;
 				rt->fib6_nsiblings = 0;
-				list_del_init(&rt->fib6_siblings);
+				list_del_rcu(&rt->fib6_siblings);
 				rt6_multipath_rebalance(next_sibling);
 				return err;
 			}
@@ -1965,7 +1965,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 					 &rt->fib6_siblings, fib6_siblings)
 			sibling->fib6_nsiblings--;
 		rt->fib6_nsiblings = 0;
-		list_del_init(&rt->fib6_siblings);
+		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1f4b935a0e57..485a14098958 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -414,7 +414,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *sibling, *next_sibling;
+	struct fib6_info *sibling;
 	struct fib6_info *match = res->f6i;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
@@ -441,8 +441,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
 		goto out;
 
-	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
-				 fib6_siblings) {
+	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
-- 
2.34.1


