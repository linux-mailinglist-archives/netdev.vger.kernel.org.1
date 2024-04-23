Return-Path: <netdev+bounces-90681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC38AF8A3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82021C24213
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833E143881;
	Tue, 23 Apr 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Q1Ucxxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02495143882
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905652; cv=none; b=EuQrXxQgG3pNH1UWNFUaoAYvpPbx97aAyd6YGDo2NVueST/XmYVUgokujGqc9xaZ3VlUdbReco0iT6BR6co+LiG+h+iEqnprbfhor2obrZXLK7M2Zqa4SEz/tDVe9TdJU4d58oKUP5irpb0Cyg7KIDli4qEVrpXhOf1M8au0yrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905652; c=relaxed/simple;
	bh=cQ5gX2oQLzJ6TZmNRnbMS9MrQsovGMS6X+ll52eyFAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iBGPYtZt+ZIyv9Tkr15gXhNvYA07liF1rZmAFlr1HqKBzHk+pC/0cq/IO9eDGMyqDQ5X7Gw31MZrT8z786t1HdNkzmpEwUwFL+50n45PTGdHRseTyAwA2JzL2SutkSJI2WFKP2ZQdICTsVt4Ze0CugespgG7k7FIO5oSoZVdlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Q1Ucxxp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2abd30f9so100493907b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713905650; x=1714510450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8dLzDFcUtPB2Y+gkT2WWFDuBdOEiiEHlSaeDyA9oHQ0=;
        b=2Q1UcxxpR9YU8d0q750qxx8nP3PKeC5pfnWo+pEc7KGb+/+ks2zDiJDx1G4RnOH1f+
         pZGSPnRMlsvdwjvbKK7l7nXawAgDa1F7sh9PYqNVpR/vFkCHhzE1SeQ1+ebwVpH8aXha
         0b0CqM24tzBUtrfSV7CDYQaKryxQtvtd3Qx+h2JxJQESkCfmbWzjA9tYGQT1/eTLWoGt
         Tj3/BxYyM6y+XYIVHAZ7vXRqq6SA+eTYHTLILEhVBnrRsdJPJEZTYTtXiJQc2A8zgVo1
         W4wN9JVpqF0IVG43/fLu3czlDBqZHbcbu8AsfW3wUc8QhvB5nPtAUly1/s3VSWKE/QNW
         YMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905650; x=1714510450;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dLzDFcUtPB2Y+gkT2WWFDuBdOEiiEHlSaeDyA9oHQ0=;
        b=rF1UbjVO/1b1WrZ8YyryckyBlmSaijFmTh6rMli/hxIRJ/+waoYQfDTR8JvAfQ126H
         oEB+gQZvJWkDrsjVtZDD02G7+FMTQrXUGL2NEGX4+P2+1CPqE1U3LAxmyDQ3UJyZWmLJ
         QAGz94VYwokgLPqKcg0mqlvWhwy6FpAQpVkK5F77xcop7kzaDt/xezqnqZs7MV+IZMZu
         EH9w3lACcUPqx8CCd75ivwTD/+1AdJwlkee/lSzf5gZ73s4BoqoXytRkcasRmfMOBlzI
         /ePIvQmPzfeESZVzy5OFhUTG8rjS5WyvPL5d16VdK1uzEFyxN65OwVsKJQEshZTuPMsM
         0qgA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qNnGwZrc+Re0yqAqeZAeOSZz+UK5DsZ/yD0tf3Ytc+CWUeJLM/PQwjUjytv7n8HeBnF4BqkvVQOppiRF5ZtbFv/fC4oE
X-Gm-Message-State: AOJu0YzJJQ7AJRJPqHasAM/I0etN1ZiTSjEUQVswoJGbKa5q+G5jI3nf
	QgmWtmFlhPeJz+MiRAiUyLM7R8OpWOwqb9NFpAq+sV5gRH6PpeWrNkbJzRt1d5BeICwlK2mkcUu
	SeSdyBdBbFg==
X-Google-Smtp-Source: AGHT+IEULOGWD3BZMe7JTTED0giHDFGavUc9bmP99j8Ou38YS78SVPdUm9/1yeVmpvAU0nZ2XPPTyTx2wewhiA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d509:0:b0:de5:5693:4e8e with SMTP id
 r9-20020a25d509000000b00de556934e8emr78340ybe.11.1713905649954; Tue, 23 Apr
 2024 13:54:09 -0700 (PDT)
Date: Tue, 23 Apr 2024 20:54:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423205408.39632-1-edumazet@google.com>
Subject: [PATCH net-next] net: add two more call_rcu_hurry()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I had failures with pmtu.sh selftests lately,
with netns dismantles firing ref_tracking alerts [1].

After much debugging, I found that some queued
rcu callbacks were delayed by minutes, because
of CONFIG_RCU_LAZY=y option.

Joel Fernandes had a similar issue in the past,
fixed with commit 483c26ff63f4 ("net: Use call_rcu_hurry()
for dst_release()")

In this commit, I make sure nexthop_free_rcu()
and free_fib_info_rcu() are not delayed too much
because they both can release device references.

tools/testing/selftests/net/pmtu.sh no longer fails.

Traces were:

[  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 3/5 users at
                    dst_alloc+0x76/0x160
                    ip6_dst_alloc+0x25/0x80
                    ip6_pol_route+0x2a8/0x450
                    ip6_pol_route_output+0x1f/0x30
                    fib6_rule_lookup+0x163/0x270
                    ip6_route_output_flags+0xda/0x190
                    ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
                    ip6_dst_lookup_flow+0x47/0xa0
                    udp_tunnel6_dst_lookup+0x158/0x210
                    vxlan_xmit_one+0x4c2/0x1550 [vxlan]
                    vxlan_xmit+0x52d/0x14f0 [vxlan]
                    dev_hard_start_xmit+0x7b/0x1e0
                    __dev_queue_xmit+0x20b/0xe40
                    ip6_finish_output2+0x2ea/0x6e0
                    ip6_finish_output+0x143/0x320
                    ip6_output+0x74/0x140

[  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 1/5 users at
                    netdev_get_by_index+0xc0/0xe0
                    fib6_nh_init+0x1a9/0xa90
                    rtm_new_nexthop+0x6fa/0x1580
                    rtnetlink_rcv_msg+0x155/0x3e0
                    netlink_rcv_skb+0x61/0x110
                    rtnetlink_rcv+0x19/0x20
                    netlink_unicast+0x23f/0x380
                    netlink_sendmsg+0x1fc/0x430
                    ____sys_sendmsg+0x2ef/0x320
                    ___sys_sendmsg+0x86/0xd0
                    __sys_sendmsg+0x67/0xc0
                    __x64_sys_sendmsg+0x21/0x30
                    x64_sys_call+0x252/0x2030
                    do_syscall_64+0x6c/0x190
                    entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  968.179860] ref_tracker: veth_A-R1@00000000d0ff3fe2 has 1/5 users at
                    ipv6_add_dev+0x136/0x530
                    addrconf_notify+0x19d/0x770
                    notifier_call_chain+0x65/0xd0
                    raw_notifier_call_chain+0x1a/0x20
                    call_netdevice_notifiers_info+0x54/0x90
                    register_netdevice+0x61e/0x790
                    veth_newlink+0x230/0x440
                    __rtnl_newlink+0x7d2/0xaa0
                    rtnl_newlink+0x4c/0x70
                    rtnetlink_rcv_msg+0x155/0x3e0
                    netlink_rcv_skb+0x61/0x110
                    rtnetlink_rcv+0x19/0x20
                    netlink_unicast+0x23f/0x380
                    netlink_sendmsg+0x1fc/0x430
                    ____sys_sendmsg+0x2ef/0x320
                    ___sys_sendmsg+0x86/0xd0
....
[ 1079.316024]  ? show_regs+0x68/0x80
[ 1079.316087]  ? __warn+0x8c/0x140
[ 1079.316103]  ? ref_tracker_free+0x1a0/0x270
[ 1079.316117]  ? report_bug+0x196/0x1c0
[ 1079.316135]  ? handle_bug+0x42/0x80
[ 1079.316149]  ? exc_invalid_op+0x1c/0x70
[ 1079.316162]  ? asm_exc_invalid_op+0x1f/0x30
[ 1079.316193]  ? ref_tracker_free+0x1a0/0x270
[ 1079.316208]  ? _raw_spin_unlock+0x1a/0x40
[ 1079.316222]  ? free_unref_page+0x126/0x1a0
[ 1079.316239]  ? destroy_large_folio+0x69/0x90
[ 1079.316251]  ? __folio_put+0x99/0xd0
[ 1079.316276]  dst_dev_put+0x69/0xd0
[ 1079.316308]  fib6_nh_release_dsts.part.0+0x3d/0x80
[ 1079.316327]  fib6_nh_release+0x45/0x70
[ 1079.316340]  nexthop_free_rcu+0x131/0x170
[ 1079.316356]  rcu_do_batch+0x1ee/0x820
[ 1079.316370]  ? rcu_do_batch+0x179/0x820
[ 1079.316388]  rcu_core+0x1aa/0x4d0
[ 1079.316405]  rcu_core_si+0x12/0x20
[ 1079.316417]  __do_softirq+0x13a/0x3dc
[ 1079.316435]  __irq_exit_rcu+0xa3/0x110
[ 1079.316449]  irq_exit_rcu+0x12/0x30
[ 1079.316462]  sysvec_apic_timer_interrupt+0x5b/0xe0
[ 1079.316474]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 1079.316569] RIP: 0033:0x7f06b65c63f0

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/net/nexthop.h    | 2 +-
 net/ipv4/fib_semantics.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 7ca315ad500e7f4e8135a964e1c0cf48f0139436..68463aebcc05928468ca776bf207a73b39e836ae 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -267,7 +267,7 @@ static inline bool nexthop_get(struct nexthop *nh)
 static inline void nexthop_put(struct nexthop *nh)
 {
 	if (refcount_dec_and_test(&nh->refcnt))
-		call_rcu(&nh->rcu, nexthop_free_rcu);
+		call_rcu_hurry(&nh->rcu, nexthop_free_rcu);
 }
 
 static inline bool nexthop_cmp(const struct nexthop *nh1,
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 5eb1b8d302bbd1c408c4999636b6cf4b81a0ad7e..f669da98d11d8f2a1182e6e84d98c2b92f774a88 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -254,7 +254,7 @@ void free_fib_info(struct fib_info *fi)
 		return;
 	}
 
-	call_rcu(&fi->rcu, free_fib_info_rcu);
+	call_rcu_hurry(&fi->rcu, free_fib_info_rcu);
 }
 EXPORT_SYMBOL_GPL(free_fib_info);
 
-- 
2.44.0.769.g3c40516874-goog


