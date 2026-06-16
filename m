Return-Path: <netdev+bounces-299942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0hTUAJegMWpoogUAu9opvQ
	(envelope-from <netdev+bounces-299942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D98694E05
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:14:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=PMBfMETo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299942-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6980306D606
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6313DDDD5;
	Tue, 16 Jun 2026 19:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753F3DD851
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:14:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637252; cv=none; b=WyhR6FAMDer2ZsnSahQWoo4mpe0NVHLJAp9UO2qKQDhpyuOgGW65K/knkiixw1vb4E2Eqk6BkG+HZshw/k3sRviXOYI48kf2XBWJOfsyRkrtThtir8fuzuEiHuj50S6nJqdpf909idSfSyhD8p2FJYn/GW5/WE/OBHt49ATILMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637252; c=relaxed/simple;
	bh=HvYzBGY8Fu0XsIDVGSgIUfcUGZGB2e3797ptX29brc4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o6P+tVHO6HtFKpXTX92PgE5bh9Hirj1CNJAigCiX5PRPjMuLy+HyadDGpRQOC0E2UU1syydUjwWLjkpjbE4xK8ZBfoY/z8oJAS8VVqY3HITrGwnMH8TS/fLB1cmj7K61hiwmpCHgHr/AeqrcEPKlclAtn4/kR7tmDxNJADPyH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMBfMETo; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8424aac207eso4769282b3a.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781637251; x=1782242051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0u/i4ROgGdOCls6xW+Dsj2i/9wDSQ1820usOGMQ0KBY=;
        b=PMBfMETonXZXccEcPyuoaDSg4o+PEuhTDD+ubtTEjs05nYuYiMeaeVWErckmiYmREW
         RwjP28oNI7NfmZRGqQEXBJutBw9JxWNHHqjc/XEdxRkgvMyR6pv3tsWEAB9bkNgS9MoE
         wR6EwB+6LWkCCWGz6cdQtrdyDukY0iJKXr4srp/aCpXxtWd4RynWpTvZ5sFpx1m5JjKV
         Ud4fRHJxRX4m3YsEj0ucMyGSUEN8NnQDpbGc1vvsvu/vz2m4rCiqfKIszSQ1NoIxdYZt
         uO+TyHG6nX4/Ss6hOWT2wkBsojdDqVvZyV1oRqdej1bpbcd4JYLW8dfC2JQdKUInWvXf
         g7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637251; x=1782242051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0u/i4ROgGdOCls6xW+Dsj2i/9wDSQ1820usOGMQ0KBY=;
        b=o3I2EitgCOxCiU0uunGMPTzl7K7HbZ9xihms0C5cmDcef1OnFYClkX9YtC5gtBy5Vf
         knQqDrJ1lZp8skZoJivZcI75nt0FSWpszcvbrOtwXDzPbS1ID7miRIis5dtUlGmaOFBB
         49FDGwb3PS/0Jgd86Al2LzPP7j/N9ES29fJ4+aGNOJj4TpL2ZVAMtaX+7Y74sWeCgj1e
         NorTHBKvS8GTxZ2bZMbfuJ+aizb6igI8na5HhFnDPK5mXpgOTilWpUS3WoV9N7KiFEK9
         WQxf6PmU3/h/ZqUSl2GYy/XIhyWs0jecQV04yqS+OC7bt3Jsn8HJMRIssgpCnxKc+T2s
         PO6w==
X-Forwarded-Encrypted: i=1; AFNElJ8ouK4TTi/H4r6qs//7i4jyNkO+MunYNGkTjDoFRDmd4pyE/pqcAqSMUfaAmp3XJf1ACxu2WVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS46jkyBkRm50WHCqXAK+3JHvObVYXK3NEMzBWLg9L4KeEHPJC
	GH49K/7zeCZS+lmvKoGwsa0hH6lG3s7EQgojio+6uaWf2q6MDrcW3VwNECHgAJsRWQg4LduxLMl
	n8tyzfQ==
X-Received: from pfnd21.prod.google.com ([2002:aa7:8155:0:b0:842:5989:fb63])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1748:b0:842:4612:55f4
 with SMTP id d2e1a72fcca58-84524565b69mr406609b3a.31.1781637250324; Tue, 16
 Jun 2026 12:14:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 19:13:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616191359.4142661-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipv4: fib_rule: Move fib4_rules_exit() to ->exit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56D98694E05

syzbot reported use-after-free of net->ipv4.rules_ops. [0]

It can be reproduced with these commands:

  while true; do
  	ip netns add ns1
  	ip -n ns1 link set dev lo up
  	ip -n ns1 address add 192.0.2.1/24 dev lo
  	ip -n ns1 link add name dummy1 up type dummy
  	ip -n ns1 address add 198.51.100.1/24 dev dummy1
  	ip -n ns1 rule add ipproto tcp sport 12345 table 12345
  	ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198.51.100.2 peer_port 54321
  	ip netns del ns1
  done

The cited commit moved fib4_rules_exit() earlier to ->exit_rtnl(),
but the kernel socket destroyed in ->exit() could eventually reach
__fib_lookup().

I left fib4_rules_exit() in ->exit_rtnl() because fib4_rule_delete()
calls fib_unmerge(), which requires RTNL.

However, when ->delete() is called, ->configure() has already been
called, thus fib_unmerge() in ->delete() has no effect.

Let's remove fib_unmerge() in fib4_rule_delete() and move
fib4_rules_exit() to ->exit().

Many thanks to Ido Schimmel for providing the nice repro very quickly.

Note that we can make fib_rules_ops.delete() return void once
net-next opens.

[0]:
BUG: KASAN: slab-use-after-free in fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
Read of size 8 at addr ffff88804ec4c680 by task kworker/u8:21/12641

CPU: 0 UID: 0 PID: 12641 Comm: kworker/u8:21 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
 __fib_lookup+0x106/0x210 net/ipv4/fib_rules.c:96
 ip_route_output_key_hash_rcu+0x294/0x2720 net/ipv4/route.c:2811
 ip_route_output_key_hash+0x18d/0x2a0 net/ipv4/route.c:2702
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2929
 ip4_datagram_release_cb+0x89d/0xbe0 net/ipv4/datagram.c:118
 release_sock+0x206/0x260 net/core/sock.c:3861
 inet_shutdown+0x2b1/0x390 net/ipv4/af_inet.c:950
 udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
 fou_release net/ipv4/fou_core.c:562 [inline]
 fou_exit_net+0x17d/0x1f0 net/ipv4/fou_core.c:1230
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
 cleanup_net+0x572/0x810 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: 759923cf03b0 ("ipv4: fib: Convert fib_net_exit_batch() to ->exit_rtnl().")
Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a315824.b0403584.28d0ff.0000.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c | 10 ++++++----
 net/ipv4/fib_rules.c    | 11 ++---------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c7d1f31650d7..42212970d735 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1612,10 +1612,6 @@ static void ip_fib_net_exit(struct net *net)
 			fib_free_table(tb);
 		}
 	}
-
-#ifdef CONFIG_IP_MULTIPLE_TABLES
-	fib4_rules_exit(net);
-#endif
 }
 
 static int __net_init fib_net_init(struct net *net)
@@ -1652,6 +1648,9 @@ static int __net_init fib_net_init(struct net *net)
 	ip_fib_net_exit(net);
 	rtnl_net_unlock(net);
 
+#ifdef CONFIG_IP_MULTIPLE_TABLES
+	fib4_rules_exit(net);
+#endif
 	kfree(net->ipv4.fib_table_hash);
 	fib4_notifier_exit(net);
 	goto out;
@@ -1671,6 +1670,9 @@ static void __net_exit fib_net_exit_rtnl(struct net *net,
 
 static void __net_exit fib_net_exit(struct net *net)
 {
+#ifdef CONFIG_IP_MULTIPLE_TABLES
+	fib4_rules_exit(net);
+#endif
 	kfree(net->ipv4.fib_table_hash);
 	fib4_notifier_exit(net);
 	fib4_semantics_exit(net);
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 51f0193092f0..e068a5bace73 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -352,24 +352,17 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 static int fib4_rule_delete(struct fib_rule *rule)
 {
 	struct net *net = rule->fr_net;
-	int err;
-
-	/* split local/main if they are not already split */
-	err = fib_unmerge(net);
-	if (err)
-		goto errout;
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	if (((struct fib4_rule *)rule)->tclassid)
 		atomic_dec(&net->ipv4.fib_num_tclassid_users);
 #endif
-	net->ipv4.fib_has_custom_rules = true;
 
 	if (net->ipv4.fib_rules_require_fldissect &&
 	    fib_rule_requires_fldissect(rule))
 		net->ipv4.fib_rules_require_fldissect--;
-errout:
-	return err;
+
+	return 0;
 }
 
 static int fib4_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
-- 
2.54.0.1136.gdb2ca164c4-goog


