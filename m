Return-Path: <netdev+bounces-277588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMP+JHVp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F03DCD49
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B97730371B6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688EC3BD25D;
	Fri, 10 Apr 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODoC2fXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248293B2FE5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855874; cv=none; b=hZYvQIpxR1ZBm3qB4KT59kCsz8RiIYcq0IegFOk+YOyonTBczp8SmuFiHMggAHUGca8kT3c4uPLzbGc4BPFdAGp3h8RLzPONM1vl7rI2UC4nsIFFRcnwxmSoJR9TBWchNXd6BcB8KCZ8Q6SWWg4ybL5ugU/I/HXFxY2SgfVhqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855874; c=relaxed/simple;
	bh=YNFys67zQ36hDLDbkti8XEFmK6eQ7F8HXXRfiQdqHkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Toc2QAiYYuPCTrhORcBDZCWZw4kQiPL8vq6D8TE3jQHG+2nnhnVwUMexwzHtJ/z9+ZEYMGfACs2eOw2I8z054vRvIO2iFFRKYw9ktYrRT4wV1SQlcxdFj3Ddt5++XMUg66BAHBv54KctZethP/YFN2YouNU42eLNK/IvUNGjMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODoC2fXj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f0e12d375so680673b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855872; x=1776460672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzO/MII+MksvosZtLKOQ+/kpnpRiACGgBGZWdsEoiFQ=;
        b=ODoC2fXjReXXqHaOWctc4qEAe0yp+S5zL2RzKige2NxDh9Hdc0kxh9kkUXgTMXSFTn
         tf+5PMAzPjTslXzWNrGNs2Miav+oyQibXrCJ+rn55V5v5q1Dl+CqO3a64+ySoL2mifKh
         2bnDsBvF/W2WUnJ9Q8cQ7B9tQpEQMcdDp5yjTZ0EffiFwYa918QxBZmW5hblJgexPeUX
         YUjsaIV4twbZ/ZiAr7e3FHHI0mBufbeBtzKR6AfKJ7CpK4Aim1rNPkGxACzMKe1zgGkH
         Q63H/we8X90IryWMrKOHZHo7HTEB5s/uvnH4JXk9ktZYs3LWX058p0G1IE0/Zdi2KYMQ
         A3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855872; x=1776460672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzO/MII+MksvosZtLKOQ+/kpnpRiACGgBGZWdsEoiFQ=;
        b=q0gVakWjJCkzFtEw8n3CfNdxEXXWHKOL7Nhfx0R2hvamCisFOjscl1FjLGi1w6WWXT
         W7kWBf9b1+COSv1fVGk9bJOpR2YVWUeNs5wZ1ivawR1g6w1baPoYiGEbG8wjCI6TDEJG
         gqUnLLTwoFjqRp5l+TS2LxkIqfQuyOeDezWn/FqazCxZ9W94pch1/TzJflUoXXELCp+f
         OxbVN7hRD3JJdtI+33jDJ3R5KhPu20ROg8DvCU1f35PxHa/VOK0xSS9CwtRkeH7fPmSQ
         IAvSJ/HvJUsEyJTU+CvNMEFz9dbi5ZQKN0pa2KEx0Nr+2tu8AeS/wZie+bX07m0nEeUV
         +lxA==
X-Forwarded-Encrypted: i=1; AJvYcCXyhJ7kDv8o4OdrqeJG1xfxhqgbHx5I0RD+3ot3iya4qkyxbxZbYLPxzB+v6xlE+e0ZnqBmQBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RWYUmtTswOPsnV5iafg9TO+kYe5OwO5OFjMN6zit1/+g9umS
	1kttNicGxWO4sLiVnqaAyrvHFiIZvIv5WnLA6R8/tU7JJb8NR75trTIcX+K5gTNABUUgCyN2Zi8
	RmOVlvg==
X-Received: from pfbdh7.prod.google.com ([2002:a05:6a00:4787:b0:829:7f86:634])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da4:b0:827:3e27:161f
 with SMTP id d2e1a72fcca58-82f0c24e259mr5380246b3a.2.1775855872103; Fri, 10
 Apr 2026 14:17:52 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:08 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/15] ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277588-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 902F03DCD49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6mr_net_ops uses ->exit_batch() to acquire RTNL only once
for dying network namespaces.

ip6mr does not depend on the ordering of ->exit_rtnl() and
->exit_batch() of other pernet_operations (unlike fib_net_ops).

Once ip6mr_free_table() is called and all devices are
queued for destruction in ->exit_rtnl(), later during
NETDEV_UNREGISTER, ip6mr_device_event() will not see anything
in vif table and just do nothing.

Let's convert ip6mr_net_exit_batch() to ->exit_rtnl().

Note that fib_rules_unregister() does not need RTNL and
we will remove RTNL and unregister_netdevice_many() in
ip6mr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index af11fd883831..860fce51819e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -262,18 +262,17 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6mr_rules_exit(struct net *net)
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
 
-	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
@@ -334,16 +333,15 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit ip6mr_rules_exit(struct net *net)
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
@@ -1343,6 +1341,7 @@ static void __net_exit ip6mr_notifier_exit(struct net *net)
 /* Setup for IP multicast routing */
 static int __net_init ip6mr_net_init(struct net *net)
 {
+	LIST_HEAD(dev_kill_list);
 	int err;
 
 	err = ip6mr_notifier_init(net);
@@ -1370,7 +1369,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	rtnl_lock();
-	ip6mr_rules_exit(net);
+	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 #endif
 ip6mr_rules_fail:
@@ -1387,20 +1387,16 @@ static void __net_exit ip6mr_net_exit(struct net *net)
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
-		ip6mr_rules_exit(net);
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
2.53.0.1213.gd9a14994de-goog


