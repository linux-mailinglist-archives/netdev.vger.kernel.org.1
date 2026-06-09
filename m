Return-Path: <netdev+bounces-296963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ovqB//LJ2qM2QIAu9opvQ
	(envelope-from <netdev+bounces-296963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:17:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF065DA74
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:17:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=itf5Qh3g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296963-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296963-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E35307AE4C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA23E9C0E;
	Tue,  9 Jun 2026 08:08:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652537AA79
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992530; cv=none; b=LE/rE1igt3p+hedJ2rKHyowrja2mr2b3oIS26jBYGgttzMsEndH1OyO3ivZcdBgQerFMSaUx5bvNyhzVQbhENDtsn95rroFjCnnp7Q5aYFlypBtM5C47nrDGaHX3uLnQhUrOjp9vLNZtZqmfpd814rCAgmb7Pu4GKd6oyDD/Bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992530; c=relaxed/simple;
	bh=d7rglJaL66HMbTEOdSWgwT0kdwE1M5wmIr9II1B4TPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OrIxpKCjnDDVGBO9E+Ntobl8Pgc8/MqpVWaujeHsHW8ohU15illW9NVYQTPiXQq/umIa69GEn4wDYFzM293x6X7vzjv99VCDbXXDilghk+JHNJCIU3oplLNqxzq8QQUlYqtUeudfjLkygyII4T9adxAOGO+rwm+LaMNKLT3blvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itf5Qh3g; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-660f12eb8f1so4422047d50.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992527; x=1781597327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LE51duafmfBtaFKIAJjHaFVBxggt3Xj3Jg5FBXmYOo=;
        b=itf5Qh3gK2vZuXRPpmLgOs+jrXvaQLWg5OFX3W1mq+X6aKYjcsjzwUei+COQlySMhs
         Xbtvpb2A4e7ZlPFzvIB09ca4ZNn/z2PDUsleQi3xVmBNtQap1jsEt+c+wjFCwrKFE9qD
         FvflrWtYq8Sy7e+bgpOKJ6fpTqOvOEbgBhwreARl0PhHI9Sk0YGVRpENqz2dD4utURdV
         1lM9WR+9MiZ4lrewWo9vZmpA1mmhMeBs0gxunZTCpm8md0K/vmP/R26gC7xQCBJ/R3IA
         48eqbgIgfBfJtP9pRCuMGPAimLnsguCpO0o2V7eKBPUtnLHHFbJQL2Xnc+K06M4k52U+
         7zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992527; x=1781597327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LE51duafmfBtaFKIAJjHaFVBxggt3Xj3Jg5FBXmYOo=;
        b=AqSwLnKa7Nv8gpSn6nmzh7i1IU+DniIYV4p5CM/7cHUZ1AivYip6x6/DloV59nU8cz
         UVsxbvGTv7rBecCy6iWOkjvkIrHmAfHwj4zwBV+KvrxZ2eyvqMbaQxYpb9lusDwUxkUP
         4coYYsffxImRBDD5ezhJEcIEEUIsv9SqqQE27vY0yPKI+0MswQLerQxHmnDboN6NKk8M
         T3c9z0OlaFqPIvkz4wkCqiR/VZIFp5Fs/YaNRpeNuAeQJYtbfKXaTXAhuZ+Qqnei5lSn
         utvulvxpE2PJm3gUgJLtsSMjpFRjGmhw+oaIEPH6S6QoghVbMqBdGhQebiXlGgJUzAnz
         mNyw==
X-Forwarded-Encrypted: i=1; AFNElJ/5sTP8EDeMrj/qhvyBdlxREkKCFG41NaiFsbxDv5NCxSLGM66vQAVg4FjDrSiHhX3B0TNawug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnRcmpcbqCl1pt4XG74QhgGJBYa2ub2p8NhrIkV1R+dK6aUEN
	FcJSQMZnox3t5Ht9r/8Wt9bwBAmcLAq0RmcJbUiMm9lj4MK0sbgwOcV/NUGruJ270gPkY7VZ0vf
	VYrBn0iiWCpjgog==
X-Received: from yxdd1.prod.google.com ([2002:a05:690e:2441:b0:660:3cf6:3e1d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4148:b0:660:70d7:90c3 with SMTP id 956f58d0204a3-66106de9b12mr17894916d50.12.1780992527369;
 Tue, 09 Jun 2026 01:08:47 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:38 +0000
In-Reply-To: <20260609080839.2506801-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] net: bridge: use atomic ops to read/change
 p->flags (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296963-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AFF065DA74

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
index f1aa67f7a0510d9ff8ee7d171eecc048a5554d2f..485ad6db37922e3882e6bda489bd77e801688a06 100644
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
+	if (likely(!test_bit(BR_MRP_AWARE_BI, &p->flags)))
 		goto out;
 
 	return br_mrp_rcv(p, skb, p->dev);
diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 86f0e75d6e345f8f388ae163860a685279174222..cebd4037744ffa2796c170c1e1ac2f213b315760 100644
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
+		set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
 	else
-		p->flags &= ~BR_MRP_LOST_IN_CONT;
+		clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
 
 	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
-- 
2.54.0.1064.gd145956f57-goog


