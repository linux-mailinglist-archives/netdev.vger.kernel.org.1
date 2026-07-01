Return-Path: <netdev+bounces-303620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q8TcFY0CRWrx4woAu9opvQ
	(envelope-from <netdev+bounces-303620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:05:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF66ED0C0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=M77Qnen4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303620-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303620-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EF2303CD07
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8480480DCC;
	Wed,  1 Jul 2026 12:05:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65814480954
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:04:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907501; cv=none; b=V1uxzNW6oue9zjxVolnUkGtdaDfDVMJjC5bd6F5RAqvdmZzj1dUxidFNjL+yDc2+shfv4+VpgcLIA0dnWHGH6hD+uZHO8U3y/POTK1P/IdQ6POVNlZmOYfBK3n/sSX/yl2jojyIsok3fOoPwvWgsYWjbK5Lp1LREhRWQL+padh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907501; c=relaxed/simple;
	bh=jPlhSjhG9q8VLp4u33lnjU/pxcz6V1H/H57psfag37s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYiJ9RCSnfgf8XI0APsKkOyBcaEwKTL2dMjZ3qtsa8b4CvZZiEPuZ3lth/erhJikktaKtwXmIPy0F7JwfTXq4ibz2fGJvoxSnJ0GsSwexKIPeB0mJeHA2FtK1AA1eqVW9NbbyxFg9j23PzLEWMTpuoMTXmGSmQnVwPxeW21U2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M77Qnen4; arc=none smtp.client-ip=209.85.217.73
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-738b76cfe03so701416137.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782907498; x=1783512298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9tc1P4UUH8iLk2fMA/oQaXwjtTRWKKfRiaETp32x/w=;
        b=M77Qnen416/P+o7FZpZKjDz/9c6xSHW7Jyb9q2172am9Xdx4VPoJDumWa2ncbaw8je
         3ITCmH5I5rAnoLFTeummx9lcgu6c7+dIu8iqbrlHPdNVhWpa0l0aGQOIW7d8Y8IiYkNB
         YMWJA/ncD5pZyVIc8ZC81ZyUIIjxNkuZWJAaa/gqv2UlzmwElbLgrcP9e6GbBfOMXT5f
         ks8m+w0IBRFUdPlBXA7kStvBKcHNgTjTe5GcHTF0A10fzLgc8/hhBx8X5P2CRNYBivlm
         6AUHlxRMmpwmQTNBeeOE1cngUFeqe8ssu44PrWquapvkMFhm0P5kXme7rP7+hlj8VNyu
         fzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907498; x=1783512298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9tc1P4UUH8iLk2fMA/oQaXwjtTRWKKfRiaETp32x/w=;
        b=bMPdrdm43ILSPMcB7oihsib0qMvCBgM7CFKb61HmFl5MMmI+lTRL1jBe0ESN8kp7Gh
         vib1zuKot8WbpkVtCz5yTE3BuoSarbkqj6BEsFpWQ2zyB9FzMxMAdVzWJeMdm8gl8gIZ
         8ypmlp3/QL6+r1E4OL9pzqZzr3gejGeFIzT6BDNxXZcHl0ta1UJKwyhWwJtuqDJnPI5p
         h+zxjBbNsnIIMxC7WN61kJsBwWeZyvIAkSXxx3OCaos4lKYYHqmhp0JFIGLkXtkPM/0m
         DfxuxyCvt0RR0Xu7B4JhNtoFLQt4/40M5hsPthJp3pSTHFdeIRhTZ4TEwP2OR3Vagbf1
         3tHA==
X-Forwarded-Encrypted: i=1; AHgh+RqgD1c1IIlwCJDISNjltN52iaNYQF07Hwm/A99gIQAFqXMotdEwJo1AVPo95zSH6fmhIfotW/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYlIEw5MKUq59XD6tq1mMeAOwc0jbNehgG6bi7oKY6hGM5jUB
	RtFIffx9cSi3ZSw8cFr9BhfMfyxEY0EQ4GklQulbuImB7o7qlfUrHJaj1+sV42+23Ze74AMQP4L
	eD/7Sf00IlEfOLg==
X-Received: from qvsm10.prod.google.com ([2002:a0c:ee4a:0:b0:8dd:27ec:5810])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5615:b0:738:8022:d750 with SMTP id ada2fe7eead31-73daaac4a98mr422689137.23.1782907497791;
 Wed, 01 Jul 2026 05:04:57 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:04:53 +0000
In-Reply-To: <20260701120454.3533252-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701120454.3533252-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701120454.3533252-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] geneve: convert config to RCU-protected pointer
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303620-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,udp_conf.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0EF66ED0C0

geneve_changelink() currently updates configuration by copying it over
the old one using memcpy() under RTNL, forcing data path pause via
geneve_quiesce() and synchronize_net() to avoid reading torn values.

Convert geneve->cfg to an RCU-protected pointer, allowing lockless
and safe reads under RCU read lock without synchronization overhead.

Key changes:
- Introduced geneve_config_alloc/free() helpers for lifecycle.
- geneve_configure() allocates config and publishes it via RCU.
- geneve_changelink() performs RCU swap; old config is freed via call_rcu_hurry().
- Allocates new dst_cache during changelink to prevent pcpu sharing.
- Removed geneve_quiesce/unquiesce() and synchronize_net() from changelink.
- Added rcu_barrier() to module exit to wait for pending callbacks.
- Updated data path to use rcu_dereference().
- Updated geneve_fill_info() to use rtnl_dereference() for now.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 366 +++++++++++++++++++++++++------------------
 1 file changed, 210 insertions(+), 156 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 396e1a113cd49e9a43bfe6c7cd78f15ca8963906..c777c1a1fa930d74768a659e16380d719f12a6b2 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -82,6 +82,7 @@ struct geneve_config {
 	u16			port_min;
 	u16			port_max;
 
+	struct rcu_head		rcu;
 	/* Must be last --ends in a flexible-array member. */
 	struct ip_tunnel_info	info;
 };
@@ -100,7 +101,7 @@ struct geneve_dev {
 #endif
 	struct list_head   next;	/* geneve's per namespace list */
 	struct gro_cells   gro_cells;
-	struct geneve_config cfg;
+	struct geneve_config __rcu *cfg;
 };
 
 struct geneve_sock {
@@ -182,8 +183,10 @@ static struct geneve_dev *geneve_lookup(struct geneve_sock *gs,
 	hash = geneve_net_vni_hash(vni);
 	vni_list_head = &gs->vni_list[hash];
 	hlist_for_each_entry_rcu(node, vni_list_head, hlist) {
-		if (eq_tun_id_and_vni((u8 *)&node->geneve->cfg.info.key.tun_id, vni) &&
-		    addr == node->geneve->cfg.info.key.u.ipv4.dst)
+		const struct geneve_config *cfg = rcu_dereference(node->geneve->cfg);
+
+		if (eq_tun_id_and_vni((u8 *)&cfg->info.key.tun_id, vni) &&
+		    addr == cfg->info.key.u.ipv4.dst)
 			return node->geneve;
 	}
 	return NULL;
@@ -201,8 +204,10 @@ static struct geneve_dev *geneve6_lookup(struct geneve_sock *gs,
 	hash = geneve_net_vni_hash(vni);
 	vni_list_head = &gs->vni_list[hash];
 	hlist_for_each_entry_rcu(node, vni_list_head, hlist) {
-		if (eq_tun_id_and_vni((u8 *)&node->geneve->cfg.info.key.tun_id, vni) &&
-		    ipv6_addr_equal(&addr6, &node->geneve->cfg.info.key.u.ipv6.dst))
+		const struct geneve_config *cfg = rcu_dereference(node->geneve->cfg);
+
+		if (eq_tun_id_and_vni((u8 *)&cfg->info.key.tun_id, vni) &&
+		    ipv6_addr_equal(&addr6, &cfg->info.key.u.ipv6.dst))
 			return node->geneve;
 	}
 	return NULL;
@@ -386,11 +391,6 @@ static int geneve_init(struct net_device *dev)
 	if (err)
 		return err;
 
-	err = dst_cache_init(&geneve->cfg.info.dst_cache, GFP_KERNEL);
-	if (err) {
-		gro_cells_destroy(&geneve->gro_cells);
-		return err;
-	}
 	netdev_lockdep_set_classes(dev);
 	return 0;
 }
@@ -399,7 +399,6 @@ static void geneve_uninit(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
 
-	dst_cache_destroy(&geneve->cfg.info.dst_cache);
 	gro_cells_destroy(&geneve->gro_cells);
 }
 
@@ -675,10 +674,14 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	inner_proto = geneveh->proto_type;
 
-	if (unlikely((!geneve->cfg.inner_proto_inherit &&
-		      inner_proto != htons(ETH_P_TEB)))) {
-		dev_dstats_rx_dropped(geneve->dev);
-		goto drop;
+	{
+		const struct geneve_config *cfg = rcu_dereference(geneve->cfg);
+
+		if (unlikely(!cfg || (!cfg->inner_proto_inherit &&
+			      inner_proto != htons(ETH_P_TEB)))) {
+			dev_dstats_rx_dropped(geneve->dev);
+			goto drop;
+		}
 	}
 
 	opts_len = geneveh->opt_len * 4;
@@ -762,9 +765,10 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 }
 
 static struct sock *geneve_create_sock(struct net *net,
-				       struct geneve_dev *geneve, bool ipv6)
+				       struct geneve_dev *geneve,
+				       const struct geneve_config *cfg, bool ipv6)
 {
-	struct ip_tunnel_info *info = &geneve->cfg.info;
+	const struct ip_tunnel_info *info = &cfg->info;
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
 	int err;
@@ -775,7 +779,7 @@ static struct sock *geneve_create_sock(struct net *net,
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
-		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
+		udp_conf.use_udp6_rx_checksums = cfg->use_udp6_rx_checksums;
 		udp_conf.local_ip6 = info->key.u.ipv6.src;
 	} else
 #endif
@@ -991,7 +995,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 /* Create new listen socket if needed */
 static struct geneve_sock *geneve_socket_create(struct net *net,
-						struct geneve_dev *geneve, bool ipv6)
+						struct geneve_dev *geneve,
+						const struct geneve_config *cfg, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct udp_tunnel_sock_cfg tunnel_cfg;
@@ -1003,7 +1008,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sk = geneve_create_sock(net, geneve, ipv6);
+	sk = geneve_create_sock(net, geneve, cfg, ipv6);
 	if (IS_ERR(sk)) {
 		kfree(gs);
 		return ERR_CAST(sk);
@@ -1060,12 +1065,13 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 }
 
 static struct geneve_sock *geneve_find_sock(struct net *net,
-					    struct geneve_dev *geneve, bool ipv6)
+					    struct geneve_dev *geneve,
+					    const struct geneve_config *cfg, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
-	struct ip_tunnel_info *info = &geneve->cfg.info;
+	const struct ip_tunnel_info *info = &cfg->info;
 	sa_family_t family = ipv6 ? AF_INET6 : AF_INET;
-	bool gro_hint = geneve->cfg.gro_hint;
+	bool gro_hint = cfg->gro_hint;
 	__be16 dst_port = info->key.tp_dst;
 	struct geneve_sock *gs;
 
@@ -1095,7 +1101,8 @@ static struct geneve_sock *geneve_find_sock(struct net *net,
 	return NULL;
 }
 
-static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
+static int geneve_sock_add(struct geneve_dev *geneve,
+			   const struct geneve_config *cfg, bool ipv6)
 {
 	struct net *net = geneve->net;
 	struct geneve_dev_node *node;
@@ -1103,19 +1110,19 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(net, geneve, ipv6);
+	gs = geneve_find_sock(net, geneve, cfg, ipv6);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
 	}
 
-	gs = geneve_socket_create(net, geneve, ipv6);
+	gs = geneve_socket_create(net, geneve, cfg, ipv6);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
 out:
-	gs->collect_md = geneve->cfg.collect_md;
-	gs->gro_hint = geneve->cfg.gro_hint;
+	gs->collect_md = cfg->collect_md;
+	gs->gro_hint = cfg->gro_hint;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
@@ -1128,7 +1135,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	}
 	node->geneve = geneve;
 
-	tunnel_id_to_vni(geneve->cfg.info.key.tun_id, vni);
+	tunnel_id_to_vni(cfg->info.key.tun_id, vni);
 	hash = geneve_net_vni_hash(vni);
 	hlist_add_head_rcu(&node->hlist, &gs->vni_list[hash]);
 	return 0;
@@ -1137,21 +1144,22 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 static int geneve_open(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	bool dualstack = geneve->cfg.dualstack;
+	const struct geneve_config *cfg = rtnl_dereference(geneve->cfg);
+	bool dualstack = cfg->dualstack;
 	bool ipv4, ipv6;
 	int ret = 0;
 
-	ipv6 = geneve->cfg.info.mode & IP_TUNNEL_INFO_IPV6 || dualstack;
+	ipv6 = cfg->info.mode & IP_TUNNEL_INFO_IPV6 || dualstack;
 	ipv4 = !ipv6 || dualstack;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
-		ret = geneve_sock_add(geneve, true);
+		ret = geneve_sock_add(geneve, cfg, true);
 		if (ret < 0 && ret != -EAFNOSUPPORT)
 			ipv4 = false;
 	}
 #endif
 	if (ipv4)
-		ret = geneve_sock_add(geneve, false);
+		ret = geneve_sock_add(geneve, cfg, false);
 	if (ret < 0)
 		geneve_sock_release(geneve);
 
@@ -1189,6 +1197,7 @@ static void geneve_build_header(struct genevehdr *geneveh,
 }
 
 static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
+				     const struct geneve_config *cfg,
 				     struct sk_buff *skb)
 {
 	struct geneve_skb_cb *cb = GENEVE_SKB_CB(skb);
@@ -1201,7 +1210,7 @@ static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
 	cb->gro_hint_len = 0;
 
 	/* Try to add the GRO hint only in case of double encap. */
-	if (!geneve->cfg.gro_hint || !skb->encapsulation)
+	if (!cfg->gro_hint || !skb->encapsulation)
 		return 0;
 
 	/*
@@ -1262,10 +1271,11 @@ static void geneve_put_gro_hint_opt(struct genevehdr *gnvh, int opt_size,
 
 static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
-			    const struct geneve_dev *geneve, int ip_hdr_len)
+			    const struct geneve_dev *geneve,
+			    const struct geneve_config *cfg, int ip_hdr_len)
 {
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
-	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
+	bool inner_proto_inherit = cfg->inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_skb_cb *cb = GENEVE_SKB_CB(skb);
 	struct genevehdr *gnvh;
@@ -1306,14 +1316,14 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 }
 
 static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
+			     const struct geneve_config *cfg,
 			     const struct ip_tunnel_info *info,
 			     bool *use_cache)
 {
-	struct geneve_dev *geneve = netdev_priv(dev);
 	u8 dsfield;
 
 	dsfield = info->key.tos;
-	if (dsfield == 1 && !geneve->cfg.collect_md) {
+	if (cfg && dsfield == 1 && !cfg->collect_md) {
 		dsfield = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
 		*use_cache = false;
 	}
@@ -1323,6 +1333,7 @@ static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
 
 static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
+			   const struct geneve_config *cfg,
 			   const struct ip_tunnel_info *info)
 {
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
@@ -1335,35 +1346,35 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, cfg->inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
 		return -EIO;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
+	tos = geneve_get_dsfield(skb, dev, cfg, info, &use_cache);
 	sport = udp_flow_src_port(geneve->net, skb,
-				  geneve->cfg.port_min,
-				  geneve->cfg.port_max, true);
+				  cfg->port_min,
+				  cfg->port_max, true);
 
 	rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
 				   &info->key,
-				   sport, geneve->cfg.info.key.tp_dst, tos,
+				   sport, cfg->info.key.tp_dst, tos,
 				   use_cache ?
 				   (struct dst_cache *)&info->dst_cache : NULL);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
-	if (geneve->cfg.info.key.u.ipv4.src &&
-	    saddr != geneve->cfg.info.key.u.ipv4.src) {
+	if (cfg->info.key.u.ipv4.src &&
+	    saddr != cfg->info.key.u.ipv4.src) {
 		dst_release(&rt->dst);
 		return -EADDRNOTAVAIL;
 	}
 
 	err = skb_tunnel_check_pmtu(skb, &rt->dst,
 				    GENEVE_IPV4_HLEN + info->options_len +
-				    geneve_build_gro_hint_opt(geneve, skb),
+				    geneve_build_gro_hint_opt(geneve, cfg, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
 		dst_release(&rt->dst);
@@ -1397,21 +1408,21 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
-	if (geneve->cfg.collect_md) {
+	if (cfg->collect_md) {
 		ttl = key->ttl;
 
 		df = test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags) ?
 		     htons(IP_DF) : 0;
 	} else {
-		if (geneve->cfg.ttl_inherit)
+		if (cfg->ttl_inherit)
 			ttl = ip_tunnel_get_ttl(ip_hdr(skb), skb);
 		else
 			ttl = key->ttl;
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 
-		if (geneve->cfg.df == GENEVE_DF_SET) {
+		if (cfg->df == GENEVE_DF_SET) {
 			df = htons(IP_DF);
-		} else if (geneve->cfg.df == GENEVE_DF_INHERIT) {
+		} else if (cfg->df == GENEVE_DF_INHERIT) {
 			struct ethhdr *eth = skb_eth_hdr(skb);
 
 			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
@@ -1425,13 +1436,13 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	err = geneve_build_skb(&rt->dst, skb, info, geneve,
+	err = geneve_build_skb(&rt->dst, skb, info, geneve, cfg,
 			       sizeof(struct iphdr));
 	if (unlikely(err))
 		return err;
 
 	udp_tunnel_xmit_skb(rt, gs4->sk, skb, saddr, info->key.u.ipv4.dst,
-			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
+			    tos, ttl, df, sport, cfg->info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
@@ -1441,6 +1452,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 #if IS_ENABLED(CONFIG_IPV6)
 static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
+			    const struct geneve_config *cfg,
 			    const struct ip_tunnel_info *info)
 {
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
@@ -1452,35 +1464,35 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, cfg->inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
 		return -EIO;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
+	prio = geneve_get_dsfield(skb, dev, cfg, info, &use_cache);
 	sport = udp_flow_src_port(geneve->net, skb,
-				  geneve->cfg.port_min,
-				  geneve->cfg.port_max, true);
+				  cfg->port_min,
+				  cfg->port_max, true);
 
 	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sk, 0,
 				     &saddr, key, sport,
-				     geneve->cfg.info.key.tp_dst, prio,
+				     cfg->info.key.tp_dst, prio,
 				     use_cache ?
 				     (struct dst_cache *)&info->dst_cache : NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
-	if (!ipv6_addr_any(&geneve->cfg.info.key.u.ipv6.src) &&
-	    !ipv6_addr_equal(&saddr, &geneve->cfg.info.key.u.ipv6.src)) {
+	if (!ipv6_addr_any(&cfg->info.key.u.ipv6.src) &&
+	    !ipv6_addr_equal(&saddr, &cfg->info.key.u.ipv6.src)) {
 		dst_release(dst);
 		return -EADDRNOTAVAIL;
 	}
 
 	err = skb_tunnel_check_pmtu(skb, dst,
 				    GENEVE_IPV6_HLEN + info->options_len +
-				    geneve_build_gro_hint_opt(geneve, skb),
+				    geneve_build_gro_hint_opt(geneve, cfg, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
 		dst_release(dst);
@@ -1513,22 +1525,22 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	prio = ip_tunnel_ecn_encap(prio, ip_hdr(skb), skb);
-	if (geneve->cfg.collect_md) {
+	if (cfg->collect_md) {
 		ttl = key->ttl;
 	} else {
-		if (geneve->cfg.ttl_inherit)
+		if (cfg->ttl_inherit)
 			ttl = ip_tunnel_get_ttl(ip_hdr(skb), skb);
 		else
 			ttl = key->ttl;
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
-	err = geneve_build_skb(dst, skb, info, geneve, sizeof(struct ipv6hdr));
+	err = geneve_build_skb(dst, skb, info, geneve, cfg, sizeof(struct ipv6hdr));
 	if (unlikely(err))
 		return err;
 
 	udp_tunnel6_xmit_skb(dst, gs6->sk, skb, dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
-			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
+			     info->key.label, sport, cfg->info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
@@ -1539,28 +1551,36 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	struct ip_tunnel_info *info = NULL;
+	const struct ip_tunnel_info *info = NULL;
+	const struct geneve_config *cfg;
 	int err;
 
-	if (geneve->cfg.collect_md) {
+	rcu_read_lock();
+	cfg = rcu_dereference(geneve->cfg);
+	if (unlikely(!cfg)) {
+		err = -ENODEV;
+		goto tx_err;
+	}
+
+	if (cfg->collect_md) {
 		info = skb_tunnel_info(skb);
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
 			dev_kfree_skb(skb);
 			dev_dstats_tx_dropped(dev);
+			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		}
 	} else {
-		info = &geneve->cfg.info;
+		info = &cfg->info;
 	}
 
-	rcu_read_lock();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (info->mode & IP_TUNNEL_INFO_IPV6)
-		err = geneve6_xmit_skb(skb, dev, geneve, info);
+		err = geneve6_xmit_skb(skb, dev, geneve, cfg, info);
 	else
 #endif
-		err = geneve_xmit_skb(skb, dev, geneve, info);
+		err = geneve_xmit_skb(skb, dev, geneve, cfg, info);
 	rcu_read_unlock();
 
 	if (likely(!err))
@@ -1576,6 +1596,12 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
+
+tx_err:
+	rcu_read_unlock();
+	dev_kfree_skb(skb);
+	DEV_STATS_INC(dev, tx_errors);
+	return NETDEV_TX_OK;
 }
 
 static int geneve_change_mtu(struct net_device *dev, int new_mtu)
@@ -1593,8 +1619,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
+	const struct geneve_config *cfg;
 	__be16 sport;
 
+	cfg = rcu_dereference(geneve->cfg);
+	if (unlikely(!cfg))
+		return -ENODEV;
+
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
 		struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
@@ -1606,14 +1637,14 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 			return -EIO;
 
 		use_cache = ip_tunnel_dst_cache_usable(skb, info);
-		tos = geneve_get_dsfield(skb, dev, info, &use_cache);
+		tos = geneve_get_dsfield(skb, dev, cfg, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
-					  geneve->cfg.port_min,
-					  geneve->cfg.port_max, true);
+					  cfg->port_min,
+					  cfg->port_max, true);
 
 		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
 					   &info->key,
-					   sport, geneve->cfg.info.key.tp_dst,
+					   sport, cfg->info.key.tp_dst,
 					   tos,
 					   use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(rt))
@@ -1633,14 +1664,14 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 			return -EIO;
 
 		use_cache = ip_tunnel_dst_cache_usable(skb, info);
-		prio = geneve_get_dsfield(skb, dev, info, &use_cache);
+		prio = geneve_get_dsfield(skb, dev, cfg, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
-					  geneve->cfg.port_min,
-					  geneve->cfg.port_max, true);
+					  cfg->port_min,
+					  cfg->port_max, true);
 
 		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sk, 0,
 					     &saddr, &info->key, sport,
-					     geneve->cfg.info.key.tp_dst, prio,
+					     cfg->info.key.tp_dst, prio,
 					     use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
@@ -1653,7 +1684,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	info->key.tp_src = sport;
-	info->key.tp_dst = geneve->cfg.info.key.tp_dst;
+	info->key.tp_dst = cfg->info.key.tp_dst;
 	return 0;
 }
 
@@ -1709,7 +1740,49 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 	}
 }
 
+static struct geneve_config *geneve_config_alloc(const struct geneve_config *src)
+{
+	struct geneve_config *cfg;
+	int err;
+
+	cfg = kmemdup(src, sizeof(*src), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	cfg->info.dst_cache.cache = NULL;
+	err = dst_cache_init(&cfg->info.dst_cache, GFP_KERNEL);
+	if (err) {
+		kfree(cfg);
+		return ERR_PTR(err);
+	}
+
+	return cfg;
+}
+
+static void geneve_config_free(struct geneve_config *cfg)
+{
+	if (cfg) {
+		dst_cache_destroy(&cfg->info.dst_cache);
+		kfree(cfg);
+	}
+}
+
+static void geneve_config_free_rcu(struct rcu_head *head)
+{
+	struct geneve_config *cfg = container_of(head, struct geneve_config, rcu);
+
+	geneve_config_free(cfg);
+}
+
 /* Initialize the device structure. */
+static void geneve_free_dev(struct net_device *dev)
+{
+	struct geneve_dev *geneve = netdev_priv(dev);
+	struct geneve_config *cfg = rcu_dereference_protected(geneve->cfg, 1);
+
+	geneve_config_free(cfg);
+}
+
 static void geneve_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -1717,6 +1790,8 @@ static void geneve_setup(struct net_device *dev)
 	dev->netdev_ops = &geneve_netdev_ops;
 	dev->ethtool_ops = &geneve_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->priv_destructor = geneve_free_dev;
+
 
 	SET_NETDEV_DEVTYPE(dev, &geneve_type);
 
@@ -1878,15 +1953,17 @@ static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
 	*tun_on_same_port = false;
 	*tun_collect_md = false;
 	list_for_each_entry(geneve, &gn->geneve_list, next) {
-		if (info->key.tp_dst == geneve->cfg.info.key.tp_dst &&
-		    (cfg->dualstack || geneve->cfg.dualstack ||
-		     geneve_saddr_conflict(info, &geneve->cfg.info))) {
-			*tun_collect_md |= geneve->cfg.collect_md;
+		const struct geneve_config *gcfg = rtnl_dereference(geneve->cfg);
+
+		if (info->key.tp_dst == gcfg->info.key.tp_dst &&
+		    (cfg->dualstack || gcfg->dualstack ||
+		     geneve_saddr_conflict(info, &gcfg->info))) {
+			*tun_collect_md |= gcfg->collect_md;
 			*tun_on_same_port = true;
 		}
-		if (info->key.tun_id == geneve->cfg.info.key.tun_id &&
-		    info->key.tp_dst == geneve->cfg.info.key.tp_dst &&
-		    !memcmp(&info->key.u, &geneve->cfg.info.key.u, sizeof(info->key.u)))
+		if (info->key.tun_id == gcfg->info.key.tun_id &&
+		    info->key.tp_dst == gcfg->info.key.tp_dst &&
+		    !memcmp(&info->key.u, &gcfg->info.key.u, sizeof(info->key.u)))
 			t = geneve;
 	}
 	return t;
@@ -1922,6 +1999,7 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 	struct geneve_dev *t, *geneve = netdev_priv(dev);
 	const struct ip_tunnel_info *info = &cfg->info;
 	bool tun_collect_md, tun_on_same_port;
+	struct geneve_config *new_cfg;
 	int err, encap_len;
 
 	if (cfg->collect_md && !is_tnl_info_zero(info)) {
@@ -1962,10 +2040,13 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 		}
 	}
 
-	dst_cache_reset(&geneve->cfg.info.dst_cache);
-	memcpy(&geneve->cfg, cfg, sizeof(*cfg));
+	new_cfg = geneve_config_alloc(cfg);
+	if (IS_ERR(new_cfg))
+		return PTR_ERR(new_cfg);
 
-	if (geneve->cfg.inner_proto_inherit) {
+	rcu_assign_pointer(geneve->cfg, new_cfg);
+
+	if (cfg->inner_proto_inherit) {
 		dev->header_ops = NULL;
 		dev->type = ARPHRD_NONE;
 		dev->hard_header_len = 0;
@@ -1975,10 +2056,15 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 
 	err = register_netdevice(dev);
 	if (err)
-		return err;
+		goto err_free_cfg;
 
 	list_add(&geneve->next, &gn->geneve_list);
 	return 0;
+
+err_free_cfg:
+	geneve_config_free(new_cfg);
+	RCU_INIT_POINTER(geneve->cfg, NULL);
+	return err;
 }
 
 static void init_tnl_info(struct ip_tunnel_info *info, __u16 dst_port)
@@ -2323,81 +2409,47 @@ static int geneve_newlink(struct net_device *dev,
 	return 0;
 }
 
-/* Quiesces the geneve device data path for both TX and RX.
- *
- * On transmit geneve checks for non-NULL geneve_sock before it proceeds.
- * So, if we set that socket to NULL under RCU and wait for synchronize_net()
- * to complete for the existing set of in-flight packets to be transmitted,
- * then we would have quiesced the transmit data path. All the future packets
- * will get dropped until we unquiesce the data path.
- *
- * On receive geneve dereference the geneve_sock stashed in the socket. So,
- * if we set that to NULL under RCU and wait for synchronize_net() to
- * complete, then we would have quiesced the receive data path.
+/* Update the device configuration under RTNL.
+ * We use RCU swap to update the configuration atomically, so the data path
+ * (both TX and RX) can continue running without interruption or packet loss.
  */
-static void geneve_quiesce(struct geneve_dev *geneve, struct geneve_sock **gs4,
-			   struct geneve_sock **gs6)
-{
-	*gs4 = rtnl_dereference(geneve->sock4);
-	rcu_assign_pointer(geneve->sock4, NULL);
-	if (*gs4)
-		rcu_assign_sk_user_data((*gs4)->sk, NULL);
-#if IS_ENABLED(CONFIG_IPV6)
-	*gs6 = rtnl_dereference(geneve->sock6);
-	rcu_assign_pointer(geneve->sock6, NULL);
-	if (*gs6)
-		rcu_assign_sk_user_data((*gs6)->sk, NULL);
-#else
-	*gs6 = NULL;
-#endif
-	synchronize_net();
-}
 
-/* Resumes the geneve device data path for both TX and RX. */
-static void geneve_unquiesce(struct geneve_dev *geneve, struct geneve_sock *gs4,
-			     struct geneve_sock __maybe_unused *gs6)
-{
-	rcu_assign_pointer(geneve->sock4, gs4);
-	if (gs4)
-		rcu_assign_sk_user_data(gs4->sk, gs4);
-#if IS_ENABLED(CONFIG_IPV6)
-	rcu_assign_pointer(geneve->sock6, gs6);
-	if (gs6)
-		rcu_assign_sk_user_data(gs6->sk, gs6);
-#endif
-}
 
 static int geneve_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	struct geneve_sock *gs4, *gs6;
-	struct geneve_config cfg;
+	struct geneve_config *old_cfg = rtnl_dereference(geneve->cfg);
+	struct geneve_config *cfg;
 	int err;
 
 	/* If the geneve device is configured for metadata (or externally
 	 * controlled, for example, OVS), then nothing can be changed.
 	 */
-	if (geneve->cfg.collect_md)
+	if (old_cfg->collect_md)
 		return -EOPNOTSUPP;
 
 	/* Start with the existing info. */
-	memcpy(&cfg, &geneve->cfg, sizeof(cfg));
-	err = geneve_nl2info(tb, data, extack, &cfg, true);
+	cfg = geneve_config_alloc(old_cfg);
+	if (IS_ERR(cfg))
+		return PTR_ERR(cfg);
+
+	err = geneve_nl2info(tb, data, extack, cfg, true);
 	if (err)
-		return err;
+		goto err_free_cfg;
 
-	if (!geneve_dst_addr_equal(&geneve->cfg.info, &cfg.info)) {
-		dst_cache_reset(&cfg.info.dst_cache);
-		geneve_link_config(dev, &cfg.info, tb);
-	}
+	if (!geneve_dst_addr_equal(&old_cfg->info, &cfg->info))
+		geneve_link_config(dev, &cfg->info, tb);
 
-	geneve_quiesce(geneve, &gs4, &gs6);
-	memcpy(&geneve->cfg, &cfg, sizeof(cfg));
-	geneve_unquiesce(geneve, gs4, gs6);
+	rcu_assign_pointer(geneve->cfg, cfg);
 
+	call_rcu_hurry(&old_cfg->rcu, geneve_config_free_rcu);
 	return 0;
+
+err_free_cfg:
+	geneve_config_free(cfg);
+	return err;
 }
 
 static void geneve_dellink(struct net_device *dev, struct list_head *head)
@@ -2432,12 +2484,13 @@ static size_t geneve_get_size(const struct net_device *dev)
 static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	struct ip_tunnel_info *info = &geneve->cfg.info;
-	bool ttl_inherit = geneve->cfg.ttl_inherit;
-	bool metadata = geneve->cfg.collect_md;
+	struct geneve_config *cfg = rtnl_dereference(geneve->cfg);
+	struct ip_tunnel_info *info = &cfg->info;
+	bool ttl_inherit = cfg->ttl_inherit;
+	bool metadata = cfg->collect_md;
 	struct ifla_geneve_port_range ports = {
-		.low	= htons(geneve->cfg.port_min),
-		.high	= htons(geneve->cfg.port_max),
+		.low	= htons(cfg->port_min),
+		.high	= htons(cfg->port_max),
 	};
 	__u8 tmp_vni[3];
 	__u32 vni;
@@ -2468,17 +2521,17 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 #endif
 	}
 
-	if (!geneve->cfg.dualstack) {
+	if (!cfg->dualstack) {
 		if (ip_tunnel_info_af(info) == AF_INET) {
 			if ((info->key.u.ipv4.src ||
-			     geneve->cfg.collect_md) &&
+			     metadata) &&
 			    nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
 					    info->key.u.ipv4.src))
 				goto nla_put_failure;
 #if IS_ENABLED(CONFIG_IPV6)
 		} else {
 			if ((!ipv6_addr_any(&info->key.u.ipv6.src) ||
-			     geneve->cfg.collect_md) &&
+			     metadata) &&
 			    nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
 					     &info->key.u.ipv6.src))
 				goto nla_put_failure;
@@ -2491,7 +2544,7 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_be32(skb, IFLA_GENEVE_LABEL, info->key.label))
 		goto nla_put_failure;
 
-	if (nla_put_u8(skb, IFLA_GENEVE_DF, geneve->cfg.df))
+	if (nla_put_u8(skb, IFLA_GENEVE_DF, cfg->df))
 		goto nla_put_failure;
 
 	if (nla_put_be16(skb, IFLA_GENEVE_PORT, info->key.tp_dst))
@@ -2502,21 +2555,21 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, IFLA_GENEVE_UDP_ZERO_CSUM6_RX,
-		       !geneve->cfg.use_udp6_rx_checksums))
+		       !cfg->use_udp6_rx_checksums))
 		goto nla_put_failure;
 #endif
 
 	if (nla_put_u8(skb, IFLA_GENEVE_TTL_INHERIT, ttl_inherit))
 		goto nla_put_failure;
 
-	if (geneve->cfg.inner_proto_inherit &&
+	if (cfg->inner_proto_inherit &&
 	    nla_put_flag(skb, IFLA_GENEVE_INNER_PROTO_INHERIT))
 		goto nla_put_failure;
 
 	if (nla_put(skb, IFLA_GENEVE_PORT_RANGE, sizeof(ports), &ports))
 		goto nla_put_failure;
 
-	if (geneve->cfg.gro_hint &&
+	if (cfg->gro_hint &&
 	    nla_put_flag(skb, IFLA_GENEVE_GRO_HINT))
 		goto nla_put_failure;
 
@@ -2671,6 +2724,7 @@ static void __exit geneve_cleanup_module(void)
 	rtnl_link_unregister(&geneve_link_ops);
 	unregister_netdevice_notifier(&geneve_notifier_block);
 	unregister_pernet_subsys(&geneve_net_ops);
+	rcu_barrier();
 }
 module_exit(geneve_cleanup_module);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


