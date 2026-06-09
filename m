Return-Path: <netdev+bounces-296964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uY+wOiTKJ2oH2QIAu9opvQ
	(envelope-from <netdev+bounces-296964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8565D945
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:09:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qMLgxg84;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296964-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BECDC3026268
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4C3E9C2C;
	Tue,  9 Jun 2026 08:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5403EA967
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992532; cv=none; b=e2/vSzJ6cPpBCOLGYk48Ks8bCmVH3/e1xfBm2dPiTtRkGjI9/+Fveh5w4r9iT1ZFL0Y58VZlxI4BQ3fLMaQLXjCPrJtylTLxMPRJUB/KIMK5FJVHYeDrB0Y98wPdRBS/I9OkXP7rJI5t0G8AeQE3us7j2L6LWl/Ho5WFnGpCnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992532; c=relaxed/simple;
	bh=8NpQf21F2R+PDzTHBW/kVT+6QELN+3sMmaSoAvlWoUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KeOJB7ayWQKsFiLPG2J2cTZgn3jK+bQ9M2eFaR1MhX3YarPA8l89XNYMuvINHJh3nU+NX5+DPuftgKGg7YW1qDPLoqeSddOuTMVNUMVZcEAUyyiUCYFbun/0MOrzVc5moaZl5TxXFhMi1TnsTLMKsY/aMGgJxOEVXIAJkZg5tTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMLgxg84; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51771d41426so99426281cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992530; x=1781597330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7PmNSlAFT/u0+7rnT2RgGBq9mFO+DIAOjXC2tVDXkM=;
        b=qMLgxg84aJ5AMKKP6MB9mWsiCvKu2fhn76CDFZEejDPDpuJwcUqZgY9TVqzQSzqMoJ
         EDoWVijRAg0dy+zb9QcC3qyJmOPGyBziS8vgbQZd5ALDQiBviKQSrX4REUzy3zU9greY
         wqSOSJ+8js+UhUqAcWWC5BEsQ2igvx8wHLSIQYkAsb0PGqY535zgnAf9teR5UFI83c+i
         YFhz73JFH3Z8/ZOLE2ssFjVZuizNK7smPPweDf6k4zUab6vxW3l0AQdPwj8EG7YAeLpr
         LlHMADGgU3eK4dh0W14PGBN5LsdwxpLuoV4Sh461+sdWyHIYrFM0+gywAZqLQIaOB5qr
         A3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992530; x=1781597330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7PmNSlAFT/u0+7rnT2RgGBq9mFO+DIAOjXC2tVDXkM=;
        b=QlXdT1/b1q2D7ve1BylXUnRYwYhel3DZ4Cls3oDjavgCoUHlLA8HdhO/J8PG/ivS/c
         ao8mCpwqYp0nr5wDTqtleE205OygoeAxeIk4vs6UZtuFIHUjGzVLhr8QYMj+BTLtx4hf
         A62B80mlfHG9LEUkjy/dypbMJ5ccc6HOkMZtkrZBtWge2QZCTma1XxgykLo4IyCi6bBr
         +VhU9JWoeIT2a0YOURaRP+KVvJlFdO2sc327Zskrwjws9NqdIfw2UwBhNYCJlTdrUXW9
         LDH2ta014KxjB0EAfA7Krnbd3DlRtIUgLoE0+ARhWqvnnworw4Yhoy+FE2WqyuGGlnhm
         ap/w==
X-Forwarded-Encrypted: i=1; AFNElJ8hSLD2ZNQ6cUttRWtWREEU8e4OqnMmD2+N89sUnwvUwjx8TTP2VgsbPwWLEvvYDx/aM/WAEzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdUzoR3XF6aTbqXfxYWilhwDYPbSMIaRnZuhs7SYqCSldYxq1
	/1rkzMZs/XaTNNeY93hv7Db7danXExT4eUSgJqc1SJ9uq8v87AW5yubRmOHH1D/bSHlRSNIS0ob
	71YtgiLF5ct3gHw==
X-Received: from qtay8.prod.google.com ([2002:ac8:5f48:0:b0:517:8d98:f05d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8c7:b0:516:d781:588e with SMTP id d75a77b69052e-51795a4833cmr217020041cf.10.1780992529616;
 Tue, 09 Jun 2026 01:08:49 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:39 +0000
In-Reply-To: <20260609080839.2506801-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] net: bridge: use atomic ops to read/change
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296964-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94F8565D945

Use test_bit(), clear_bit(), set_bit() in:

   net/bridge/br_multicast.c
   net/bridge/br_netlink.c
   net/bridge/br_stp.c
   net/bridge/br_stp_bpdu.c
   net/bridge/br_switchdev.c
   net/bridge/br_vlan_options.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 12850f60bfcb418918508612070a6b0266ffbe6b..928e564e6a3ead46afeff39d772f5b9299cb4b30 100644
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
2.54.0.1064.gd145956f57-goog


