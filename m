Return-Path: <netdev+bounces-297769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DQo7GTGQKWqYZgMAu9opvQ
	(envelope-from <netdev+bounces-297769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBB66B745
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:26:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pAs2nIVy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297769-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FFD63084A12
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A130B514;
	Wed, 10 Jun 2026 16:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58F314D1A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:18:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108336; cv=none; b=VAd/wPlQTfY3qEMV7AJLCjeGBvL8GxfT1rZsXDDVR02zNTOCTK07pMQpK+AmO4GeYjgSu3KNBi2FbnyeEA13crfVwnKDsKpWMadckAW3kUJ0EFiCMsXjy8Pl+fyCbXC7qc6HlIQbh28yBGPaDuGYO8dfCj9EL+I/Mxm/fOJYVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108336; c=relaxed/simple;
	bh=mhnzVnUxOFsGDNVJGqdJRiMIABPB9TyWQn1Iv5hOHvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6MjHWjCb5085lTinp/M1uT+DEz8FjlkGDyXz4QqALfEqwDaHNwVE9tCct5IlHUJKXA7g2zF15YcuIVsUg3npycoS7Z2bznZwwDsqU13wggaTrEdsoio7nJ9nSHaavCz7rocZWVjvudf0hgpRexFl41DrJLMG9nRcUrYGg+d92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAs2nIVy; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-915d3261c5cso821106485a.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108334; x=1781713134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xiLPN+P1Ir3rJBmR/6rosfVY6S0Ya5fwcazsLKP+YA=;
        b=pAs2nIVyBUIWg2izBWQZhgIZS3QxBUqAFzyLOGiRKljLRjHJ2AefFcZ4irE+AKb09Q
         v1njKHYF4/yGHBWmvh/CRx9tSOsWVO5iFj3wiLrdiSE0e1W6jGmdCY3ZvdjD2SvXc4aX
         NNIrz/9XLBEEjM8Pr0pTx4fbRA2vl4xGFkVcfZUjxBaeghU7mAQShNbwWy7BQeUQENup
         aAvFswRScGMnWgAiy19uLJnqKOFMl6xK5x13XW1+BQ0djFJhcyrbqJY5AN//X40Q8db9
         p2a3QZqLZ8kcUCXqAXxq45dHjZ4eDRvnR0915K55JTrUaBonb3yQOgb6YTsTEZpvE7Y2
         MY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108334; x=1781713134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xiLPN+P1Ir3rJBmR/6rosfVY6S0Ya5fwcazsLKP+YA=;
        b=ZweQkcJeWmfMgXgBZ/CUMw1srK1AQlS+wDWO1al0yl+Rih9O8g6T1mssif0UpPmqbI
         xWFOCxxSTVGpoBlj7ylIdvWn+qhfWLzIuQyLKczOaHTRnNpbqklujh64qAol+7e13pxt
         VgyCcBe3li2sE2OrhIT4WBjmvQfyYGfblbSPUJpYDigOocRK6mKnWJ98ttcCf4mket87
         0wStSTFamdqFSLYugcqbZsYiCyLk1eMLsosA6d9lhTw68ZqNvAzUUDTx75cM2RBMO6fO
         p4Cx9u16GNlVmfwdI0Y3v8xCR367IzJ0wZb/WmOKb8PrUNsV3drooLgTGBm+0kyxvIvt
         5Jbw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZcgJcVdK4z11+oV5miaXMacbBjlV4QxFbFNEsArLUKc9GmrV+Cru42yrXSxrjE/8rzIBKMdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdMia3EV7GIpkwkVPrfCSnwQLnNsodPA2D37W57mS2BazCCkr
	waak+aj4pIMrMP7QfLOIbswd2/sUm3/BLJm1mvEIMqfNHG+3+Mt9RYl0tCFum04b++7MBhqMTvP
	p8wAI4P6y7Uot0Q==
X-Received: from qkjz24.prod.google.com ([2002:a05:620a:1018:b0:915:9299:fc48])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44c2:b0:914:c226:ecce with SMTP id af79cd13be357-915a9c1367dmr4157925985a.9.1781108334172;
 Wed, 10 Jun 2026 09:18:54 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:35 +0000
In-Reply-To: <20260610161836.1275531-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610161836.1275531-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610161836.1275531-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/5] net: bridge: use atomic ops to read/change
 p->flags (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297769-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15BBB66B745

Use READ_ONCE(p->flags) in br_port_flag_is_set() to keep its ABI.

Use test_bit(), clear_bit(), set_bit() in:

   net/bridge/br_input.c
   net/bridge/br_mrp.c
   net/bridge/br_mrp_netlink.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_if.c          |  2 +-
 net/bridge/br_input.c       | 12 ++++++------
 net/bridge/br_mrp.c         | 20 ++++++++++----------
 net/bridge/br_mrp_netlink.c |  8 ++++----
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 463c3c7083dcdd4f9064b12375792b2961a9b674..7ed19aa8ae59a5d2b10babf91985486ba8889854 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -761,6 +761,6 @@ bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag)
 	if (!p)
 		return false;
 
-	return p->flags & flag;
+	return READ_ONCE(p->flags) & flag;
 }
 EXPORT_SYMBOL_GPL(br_port_flag_is_set);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 470615675bdc03ca181b72159a1bcfc7b9d7a6a7..ddb8f002a40e8257db2029a1f7b549c87db52ffd 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -111,7 +111,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
 
-	if (p->flags & BR_PORT_LOCKED) {
+	if (test_bit(BR_PORT_LOCKED_BIT, &p->flags)) {
 		struct net_bridge_fdb_entry *fdb_src =
 			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
 
@@ -119,7 +119,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			/* FDB miss. Create locked FDB entry if MAB is enabled
 			 * and drop the packet.
 			 */
-			if (p->flags & BR_PORT_MAB)
+			if (test_bit(BR_PORT_MAB_BIT, &p->flags))
 				br_fdb_update(br, p, eth_hdr(skb)->h_source,
 					      vid, BIT(BR_FDB_LOCKED));
 			goto drop;
@@ -140,7 +140,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	nbp_switchdev_frame_mark(p, skb);
 
 	/* insert into forwarding database after filtering to avoid spoofing */
-	if (p->flags & BR_LEARNING)
+	if (test_bit(BR_LEARNING_BIT, &p->flags))
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
 	promisc = !!(br->dev->flags & IFF_PROMISC);
@@ -164,7 +164,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	}
 
 	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
-	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
+	BR_INPUT_SKB_CB(skb)->src_port_isolated = test_bit(BR_ISOLATED_BIT, &p->flags);
 
 	if (IS_ENABLED(CONFIG_INET) &&
 	    (skb->protocol == htons(ETH_P_ARP) ||
@@ -248,7 +248,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 	u16 vid = 0;
 
 	/* check if vlan is allowed, to avoid spoofing */
-	if ((p->flags & BR_LEARNING) &&
+	if (test_bit(BR_LEARNING_BIT, &p->flags) &&
 	    nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
 	    br_should_learn(p, skb, &vid))
@@ -359,7 +359,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 	br_tc_skb_miss_set(skb, false);
 
 	p = br_port_get_rcu(skb->dev);
-	if (p->flags & BR_VLAN_TUNNEL)
+	if (test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
 		br_handle_ingress_vlan_tunnel(skb, p, nbp_vlan_group_rcu(p));
 
 	if (unlikely(is_link_local_ether_addr(dest))) {
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index f1aa67f7a0510d9ff8ee7d171eecc048a5554d2f..3f7126a7d72003c3e0a6366506bb0b55da49f0a4 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -454,7 +454,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 		state = netif_running(br->dev) ?
 				BR_STATE_FORWARDING : BR_STATE_DISABLED;
 		p->state = state;
-		p->flags &= ~BR_MRP_AWARE;
+		clear_bit(BR_MRP_AWARE_BIT, &p->flags);
 		spin_unlock_bh(&br->lock);
 		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->p_port, NULL);
@@ -466,7 +466,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 		state = netif_running(br->dev) ?
 				BR_STATE_FORWARDING : BR_STATE_DISABLED;
 		p->state = state;
-		p->flags &= ~BR_MRP_AWARE;
+		clear_bit(BR_MRP_AWARE_BIT, &p->flags);
 		spin_unlock_bh(&br->lock);
 		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->s_port, NULL);
@@ -478,7 +478,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 		state = netif_running(br->dev) ?
 				BR_STATE_FORWARDING : BR_STATE_DISABLED;
 		p->state = state;
-		p->flags &= ~BR_MRP_AWARE;
+		clear_bit(BR_MRP_AWARE_BIT, &p->flags);
 		spin_unlock_bh(&br->lock);
 		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->i_port, NULL);
@@ -526,14 +526,14 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	p = br_mrp_get_port(br, instance->p_ifindex);
 	spin_lock_bh(&br->lock);
 	p->state = BR_STATE_FORWARDING;
-	p->flags |= BR_MRP_AWARE;
+	set_bit(BR_MRP_AWARE_BIT, &p->flags);
 	spin_unlock_bh(&br->lock);
 	rcu_assign_pointer(mrp->p_port, p);
 
 	p = br_mrp_get_port(br, instance->s_ifindex);
 	spin_lock_bh(&br->lock);
 	p->state = BR_STATE_FORWARDING;
-	p->flags |= BR_MRP_AWARE;
+	set_bit(BR_MRP_AWARE_BIT, &p->flags);
 	spin_unlock_bh(&br->lock);
 	rcu_assign_pointer(mrp->s_port, p);
 
@@ -593,7 +593,7 @@ int br_mrp_set_port_state(struct net_bridge_port *p,
 {
 	u32 port_state;
 
-	if (!p || !(p->flags & BR_MRP_AWARE))
+	if (!p || !test_bit(BR_MRP_AWARE_BIT, &p->flags))
 		return -EINVAL;
 
 	spin_lock_bh(&p->br->lock);
@@ -619,7 +619,7 @@ int br_mrp_set_port_role(struct net_bridge_port *p,
 {
 	struct br_mrp *mrp;
 
-	if (!p || !(p->flags & BR_MRP_AWARE))
+	if (!p || !test_bit(BR_MRP_AWARE_BIT, &p->flags))
 		return -EINVAL;
 
 	mrp = br_mrp_find_port(p->br, p);
@@ -784,7 +784,7 @@ int br_mrp_set_in_role(struct net_bridge *br, struct br_mrp_in_role *role)
 		state = netif_running(br->dev) ?
 				BR_STATE_FORWARDING : BR_STATE_DISABLED;
 		p->state = state;
-		p->flags &= ~BR_MRP_AWARE;
+		clear_bit(BR_MRP_AWARE_BIT, &p->flags);
 		spin_unlock_bh(&br->lock);
 		br_mrp_port_switchdev_set_state(p, state);
 		rcu_assign_pointer(mrp->i_port, NULL);
@@ -809,7 +809,7 @@ int br_mrp_set_in_role(struct net_bridge *br, struct br_mrp_in_role *role)
 	p = br_mrp_get_port(br, role->i_ifindex);
 	spin_lock_bh(&br->lock);
 	p->state = BR_STATE_FORWARDING;
-	p->flags |= BR_MRP_AWARE;
+	set_bit(BR_MRP_AWARE_BIT, &p->flags);
 	spin_unlock_bh(&br->lock);
 	rcu_assign_pointer(mrp->i_port, p);
 
@@ -1246,7 +1246,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
 static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	/* If there is no MRP instance do normal forwarding */
-	if (likely(!(p->flags & BR_MRP_AWARE)))
+	if (likely(!test_bit(BR_MRP_AWARE_BIT, &p->flags)))
 		goto out;
 
 	return br_mrp_rcv(p, skb, p->dev);
diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 86f0e75d6e345f8f388ae163860a685279174222..39f07e13fba54ad38198a5f29a4daae2db27d989 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -538,9 +538,9 @@ int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
 	}
 
 	if (loc)
-		p->flags |= BR_MRP_LOST_CONT;
+		set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
 	else
-		p->flags &= ~BR_MRP_LOST_CONT;
+		clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
 
 	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
@@ -560,9 +560,9 @@ int br_mrp_in_port_open(struct net_device *dev, u8 loc)
 	}
 
 	if (loc)
-		p->flags |= BR_MRP_LOST_IN_CONT;
+		set_bit(BR_MRP_LOST_IN_CONT_BIT, &p->flags);
 	else
-		p->flags &= ~BR_MRP_LOST_IN_CONT;
+		clear_bit(BR_MRP_LOST_IN_CONT_BIT, &p->flags);
 
 	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
-- 
2.54.0.1099.g489fc7bff1-goog


