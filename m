Return-Path: <netdev+bounces-295463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fk87JbEAImrmRQEAu9opvQ
	(envelope-from <netdev+bounces-295463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE06643DBB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="vYktd/Gk";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D09EB304B916
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7F2DEA95;
	Thu,  4 Jun 2026 22:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176D3090D9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613255; cv=none; b=LPnu+YRejMjMS1b997QhRDu169D8sGDJRBfg7GiOMtQXFsj+LyX6O6v4Moc4LGMpGDiXNj7EGPYbEvOaWLXJDS7BVNlyBxqHDhsR6ticUTw7K/WLwXYQv4TOSKC5da+78NIuJ4JzE865SGOiCkgwGPoJ7OUNrceA6nFKdrrvQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613255; c=relaxed/simple;
	bh=Hpr6JW0A/k1snIKGjPfxbJneLTBz5MD7tMD3LDXN3XI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jcY3NyvifEzybOF8iX+FwRmWIkRIKpD2+JYwQpTQ0ZCe6OGMj2fgOjJwqhSMVPzfnm3ccYwEXTJNihJKXXXUb11cNjdbe5oZE3jIkpbgDvWW0jHKfhNRHBQS6zWIpOg5sEtuKVsby4YINA0AiylKX2mlGUvR7eHzAQZwARUe7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYktd/Gk; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a298cd62so874697a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613250; x=1781218050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJNOG8WDvhzdUE8A2eXTBVBzUzQXsdllECy9Y1WzsrU=;
        b=vYktd/Gkw0o2kTwtbxjcqEOgT1qCAGBeL3UCn90nJL1pqUKqvQzgbyQL8gL3JtzOT3
         2coi7YZ+ZlloFbsZTnEcoXWTVhtKfw+11a4KSVyA3VWf2LQDUytc/YpTX3385ipVSh6H
         FUVuImIKlU2U6SWCAY6JFbc77Kb8+uXMi02KEc4jK675C1UuIBCFc1Jtam5HOmbben8y
         lx223duHE6LzqUjoM4JHEnMIDu3SAzp0HoG3oo4KFX3/bZYYAtSjdxA7KceOMG1rO6HB
         b03GsHoFiUkpXfg6qLAf3XiR/BhD4JkN5Shoa0mWje0CHaXM5nLyryaOhCOt5kLQVZgQ
         VX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613250; x=1781218050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJNOG8WDvhzdUE8A2eXTBVBzUzQXsdllECy9Y1WzsrU=;
        b=Sbo6J2Ux9gg149a2yP8pmdoCbBcFuCRp4gVi9rGBpgvdZEa7Vr3EA3T+Ew1FMw+Ihg
         +cSqtfH3LreMmgyymEgNdq7kqAOxd5fpUJJMaz2vWLB+H4zTF/30rtJW5IKD0A6bxqey
         G8i1th2zkYhoF06eKFsts9GiSQEE18g1zFSu5ok/DODmf02iHumQAJpf7wHQ9FMHfOln
         Y+jTo77ROxR4UuiflxUkLKTlDFpLKj8cQRnXq1uVCqZvGADVpFk+Vzx8NoHwyOcHZp1f
         nVuRV9D9CWjiShW1CfbSfMD1bYbLilIk92HQQlqbA69u5m0hErJsQPmBDveZCUoR4Ld5
         ShZA==
X-Forwarded-Encrypted: i=1; AFNElJ+yWRCN+MEYgpJ0nHwgjbjfx9ND9NxVKyofk1PvNPVzUaNgFuN8kf5homF1q2f3LP1HGSlhGJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrm+DzkJAfAiTY1PxXBhRsk074w1E58rhE5OBMvg58ziB6OUNo
	w8dOpeLj9D1Swl5XzSWQYhMH8CTnDmSxAzh27rymxaPGWaHNHofLRxq1PzdoAF2vKTUOZXCKSga
	IrhKOhg==
X-Received: from pfej21.prod.google.com ([2002:aa7:8d15:0:b0:835:2a09:221c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4a:b0:842:5712:c2c2
 with SMTP id d2e1a72fcca58-842b0fb6d60mr547346b3a.41.1780613249911; Thu, 04
 Jun 2026 15:47:29 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:30 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295463-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DE06643DBB

ip6mr_net_ops uses ->exit_batch() to acquire RTNL only once
for dying network namespaces.

ip6mr does not depend on the ordering of ->exit_rtnl() and
->exit_batch() of other pernet_operations (unlike fib_net_ops).

Once ip6mr_free_table() is called and all devices are
queued for destruction in ->exit_rtnl(), later during
NETDEV_UNREGISTER, ip6mr_device_event() will not see anything
in vif table and just do nothing.

Let's convert ip6mr_net_exit_batch() to ->exit_rtnl().

We will remove RTNL and unregister_netdevice_many() in
ip6mr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index f531c4a24ea1..e9560205b547 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -267,18 +267,16 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
-static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
+					     struct list_head *dev_kill_list)
 {
 	struct mr_table *mrt, *next;
-	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
-		ip6mr_free_table(mrt, &dev_kill_list);
+		ip6mr_free_table(mrt, dev_kill_list);
 	}
-
-	unregister_netdevice_many(&dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -342,16 +340,15 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 {
 }
 
-static void __net_exit ip6mr_rules_exit_rtnl(struct net *net)
+static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
+					     struct list_head *dev_kill_list)
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
-	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
-	ip6mr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+	ip6mr_free_table(mrt, dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -1358,6 +1355,9 @@ static void __net_exit ip6mr_notifier_exit(struct net *net)
 /* Setup for IP multicast routing */
 static int __net_init ip6mr_net_init(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
+	LIST_HEAD(dev_kill_list);
+#endif
 	int err;
 
 	err = ip6mr_notifier_init(net);
@@ -1385,7 +1385,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	rtnl_lock();
-	ip6mr_rules_exit_rtnl(net);
+	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 	ip6mr_rules_exit(net);
 #endif
@@ -1404,20 +1405,16 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	ip6mr_notifier_exit(net);
 }
 
-static void __net_exit ip6mr_net_exit_batch(struct list_head *net_list)
+static void __net_exit ip6mr_net_exit_rtnl(struct net *net,
+					   struct list_head *dev_kill_list)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		ip6mr_rules_exit_rtnl(net);
-	rtnl_unlock();
+	ip6mr_rules_exit_rtnl(net, dev_kill_list);
 }
 
 static struct pernet_operations ip6mr_net_ops = {
 	.init = ip6mr_net_init,
 	.exit = ip6mr_net_exit,
-	.exit_batch = ip6mr_net_exit_batch,
+	.exit_rtnl = ip6mr_net_exit_rtnl,
 };
 
 static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
-- 
2.54.0.1032.g2f8565e1d1-goog


