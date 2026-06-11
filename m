Return-Path: <netdev+bounces-298343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rsncHYAcK2pY2wMAu9opvQ
	(envelope-from <netdev+bounces-298343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C376A67535E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=EIp1oMeB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298343-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD7032E6E23
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48E368D5E;
	Thu, 11 Jun 2026 20:35:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C536AB4D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:35:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210105; cv=none; b=BmKTeT3iObXTBUL6mRt7/pgo5l92R5n5lReFJ9FtlYMoPQXsr6zQGS72DcCEWQLO8CpkI/NuXKQn1vU8LlGMatjYMQNKm+OwPeMXrva0O2qYhfX+09PkxS/erP0QW4z1qWvjEe4CGX/86KYDQQKaHiaabQ1HwfRE02DbdOD8Gkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210105; c=relaxed/simple;
	bh=5aZG9TPfrvsOgFpj/4zxSGvhIXkHde6j+ZwBUuJChxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFUScwpeRgGO0fgcJhv5ArgzkbNfn4o3Ajk4wflHDDhpaO5uCXvuSoEIbR8jD0edVMEHdToqGthm6zCDIl8gR1o4x4hzARDoFL9gSpxFr8YZPD505YOol5CN2ayqkyL6FxF3fb0e6NAlRHr0sEzrseOF7TiP87oO2J4lUdr7lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EIp1oMeB; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915767b341eso29725885a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210103; x=1781814903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDdWudcUIh5DLGDXZNkcyOF930y0GsBnL+hW0SmcsS4=;
        b=EIp1oMeBPFExSxcbRCSYdP2Ip+bUT9ZPu27z+B0ut+KqmSEhocY1EBr0a5oqqOPbc2
         ZI7Vqxoy6SKCet/wHbWcffBBMBq5KVfewbVybTQ7JMsCFFUCikNB1wGrtAzB7Zr45ax4
         0V+k68lUgSVspcx63GisDkWH3rc/AkftbAGOvPCRais2ACk++dm6yP6YHYVBzgzBniph
         mppHZLrdwwnv/ltyGFKjyzlHpoSFctMTfPMsHblWT7qp68b+QNtjVqrRyCdATubhi1dr
         j6XQ0IfTaeMrfpD9TMYLQVmYGjPEf3lM1XxZAFbO6R4+rp8xJ8Nt8F8s38ImyYPdTjj8
         n3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210103; x=1781814903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDdWudcUIh5DLGDXZNkcyOF930y0GsBnL+hW0SmcsS4=;
        b=DczjMsVo+mHKTgx8T2QVsHey4nCR3fQEuw78ysDgixqCjb59dJIZhhSYnCju+19LCx
         fTSt/wUly6S4Ydiy/m/OOXf9P8wTa7zj4M0KgqFO7zOPV8Du5hQYL7Sn3S4nw7XGnhku
         uq6dHcPkLk6+XwNqIL7h0tSTy8RVIyYdyS1lTopsCd24q1Lxe8NDcZfEm2UUQwuy/pUW
         OLExR1k7nL7og76TE8jiTtm06IFhfAkB+L3xWVIrycCjFxy6Pj2b1daJNb0Es5yhgEzc
         T5yt7XKlaR1sm5vY/mTTMEgICvIFNL60eRn62TYK/3aWRv8viqao/FjoU1+pyYfMl+wQ
         05Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/5/GRL2Kj8R9QZL27bdGaEmUj21btTiRWyIIGHfo3U1xY9VeFcuFv2w31xZlwh4C3ex8hm0Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycj4R9orT0zC4sfRRhsOrCDyjJYZQwzQPU4q4+6FeCHvS7jG/g
	xP5uQekt2dBAte36qO0rEALDvbmP9Yx743DKq6fDzIFmcuqt1zZSviBVSDj1bSxt42pfGO8UrEr
	goqZICEhb8gxz8A==
X-Received: from qkjw26.prod.google.com ([2002:a05:620a:149a:b0:915:7402:46e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:d8a:b0:914:bb8e:915c with SMTP id af79cd13be357-9160ab36cb1mr735507185a.22.1781210102847;
 Thu, 11 Jun 2026 13:35:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:53 +0000
In-Reply-To: <20260611203453.3067462-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611203453.3067462-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-6-edumazet@google.com>
Subject: [PATCH v3 net-next 5/5] net: bridge: use atomic ops to read/change
 p->flags (III)
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C376A67535E

Use test_bit(), clear_bit(), set_bit() in:

   net/bridge/br_multicast.c
   net/bridge/br_netlink.c
   net/bridge/br_stp.c
   net/bridge/br_stp_bpdu.c
   net/bridge/br_switchdev.c
   net/bridge/br_vlan_options.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_multicast.c    | 5 +++--
 net/bridge/br_netlink.c      | 2 +-
 net/bridge/br_stp.c          | 4 ++--
 net/bridge/br_stp_bpdu.c     | 2 +-
 net/bridge/br_switchdev.c    | 8 ++++----
 net/bridge/br_vlan_options.c | 2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index c2c93c7404151dcf02e59eb8b868ec3e39dfd5bd..6b3ac473fd228b65d1479963e032a63a9f9210ee 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -281,7 +281,7 @@ static bool br_port_group_equal(struct net_bridge_port_group *p,
 	if (p->key.port != port)
 		return false;
 
-	if (!(port->flags & BR_MULTICAST_TO_UNICAST))
+	if (!test_bit(BR_MULTICAST_TO_UNICAST_BIT, &port->flags))
 		return true;
 
 	return ether_addr_equal(src, p->eth_addr);
@@ -3672,7 +3672,8 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 	if (!mp)
 		goto out;
 
-	if (pmctx && (pmctx->port->flags & BR_MULTICAST_FAST_LEAVE)) {
+	if (pmctx &&
+	    test_bit(BR_MULTICAST_FAST_LEAVE_BIT, &pmctx->port->flags)) {
 		struct net_bridge_port_group __rcu **pp;
 
 		for (pp = &mp->ports;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 2178eb20475c36acc44890cc8384270d376febc3..b2cd4e39326d0634652afee09998b8ad6cef962c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -540,7 +540,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		else
 			err = br_fill_ifvlaninfo(skb, vg);
 
-		if (port && (port->flags & BR_VLAN_TUNNEL))
+		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
 			err = br_fill_vlan_tunnel_info(skb, vg);
 		rcu_read_unlock();
 		if (err)
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index b33eb085d9b6cb4cd4f3aff2aa4793d027bbc0f8..46919d73d42f98ad92ad0c4ddd2396a0cdd90c02 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -39,7 +39,7 @@ void br_set_state(struct net_bridge_port *p, unsigned int state)
 	/* Don't change the state of the ports if they are driven by a different
 	 * protocol.
 	 */
-	if (p->flags & BR_MRP_AWARE)
+	if (test_bit(BR_MRP_AWARE_BIT, &p->flags))
 		return;
 
 	p->state = state;
@@ -179,7 +179,7 @@ static void br_root_selection(struct net_bridge *br)
 		if (!br_should_become_root_port(p, root_port))
 			continue;
 
-		if (p->flags & BR_ROOT_BLOCK)
+		if (test_bit(BR_ROOT_BLOCK_BIT, &p->flags))
 			br_root_port_block(br, p);
 		else
 			root_port = p->port_no;
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 7895489ac6fe7ca47cf001c0fea267d5dcbd4371..74ec42ba1e7d086cbfde608c93f5fa24d6b4ed7b 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -178,7 +178,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 	if (!ether_addr_equal(eth_hdr(skb)->h_dest, br->group_addr))
 		goto out;
 
-	if (p->flags & BR_BPDU_GUARD) {
+	if (test_bit(BR_BPDU_GUARD_BIT, &p->flags)) {
 		br_notice(br, "BPDU received on blocked port %u(%s)\n",
 			  (unsigned int) p->port_no, p->dev->name);
 		br_stp_disable_port(p);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee3ad9dfbab99597ab06d5e6e008519d4e17fd6a..990c6b38fd397ad364297b130b0f3736ac7b13a7 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -20,7 +20,7 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 	if (br_multicast_igmp_type(skb))
 		return false;
 
-	return (p->flags & BR_TX_FWD_OFFLOAD) &&
+	return test_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags) &&
 	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
 }
 
@@ -287,7 +287,7 @@ static int nbp_switchdev_add(struct net_bridge_port *p,
 		return err;
 
 	if (tx_fwd_offload) {
-		p->flags |= BR_TX_FWD_OFFLOAD;
+		set_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags);
 		static_branch_inc(&br_switchdev_tx_fwd_offload);
 	}
 
@@ -307,8 +307,8 @@ static void nbp_switchdev_del(struct net_bridge_port *p)
 	if (p->hwdom)
 		nbp_switchdev_hwdom_put(p);
 
-	if (p->flags & BR_TX_FWD_OFFLOAD) {
-		p->flags &= ~BR_TX_FWD_OFFLOAD;
+	if (test_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags)) {
+		clear_bit(BR_TX_FWD_OFFLOAD_BIT, &p->flags);
 		static_branch_dec(&br_switchdev_tx_fwd_offload);
 	}
 }
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 92af1e558fda886301f167463ddf43f14afd2702..fcc200c3e3da260465f9eb8ab1c8c87e2d3f7588 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -172,7 +172,7 @@ static int br_vlan_modify_tunnel(const struct net_bridge_port *p,
 		NL_SET_ERR_MSG_MOD(extack, "Can't modify tunnel mapping of non-port vlans");
 		return -EINVAL;
 	}
-	if (!(p->flags & BR_VLAN_TUNNEL)) {
+	if (!test_bit(BR_VLAN_TUNNEL_BIT, &p->flags)) {
 		NL_SET_ERR_MSG_MOD(extack, "Port doesn't have tunnel flag set");
 		return -EINVAL;
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog


