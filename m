Return-Path: <netdev+bounces-305507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4XTKLR0TTWqcugEAu9opvQ
	(envelope-from <netdev+bounces-305507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:54:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA371CE15
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:54:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pkEuoxy2;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305507-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305507-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D519930090AA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6063769F0;
	Tue,  7 Jul 2026 14:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045A36F8FB
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:53:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436018; cv=none; b=p5hPiPxxldc7jrjRAKmjCQut4pHS0tR0nMuxe2dapMGZFmdWmJpWrJeQ9FNg9dYUFQ2UF7PNteyJJfyodLWGaKA3KVEOvujvFvb0Ybf2Wyw7vm0K59xS89USN79VrkGOwJ2x9yNWIZjqJRvPV9YkQbqWxoA/uzz1ODqq3t4ywMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436018; c=relaxed/simple;
	bh=2ORz+z8FxXn9IKwny3kiGI24mfkFGL27sYdpwgfCR3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gO8Kg9Sw/7W+mzwy9am81Cutt87mK2FNJSQNGXYk6bpO1MXzNdHCQmmpVh+rCAHYlqdp2Wp0xwcBMGzlbUHp4We7npNhH2wgxfk+vjufXTuHnGk2L3Yx6Es83qaS1YjaA0poTesRps/LKFG+UKhkDgN6pKqUw19IPwJ9ElYN0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkEuoxy2; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-664dfdd69bdso5564156d50.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436016; x=1784040816; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSiXT8BgH5gghoHjr6RuM3GYQm/1BRXHKCcUkv22pbA=;
        b=pkEuoxy2jH4wXlrdGzYrfJk5DK7E/Tv3yXVBPhtb9FWpLf1relKPU+ALdpeH4gHo0J
         RrgGocz3ChT8eNzlMrAVdu/fm19guttLlmb5P2kQlXZbNB4Y6E+EpxQ5kufg5ZmFV0Iy
         kQMQ3Wli26X314SFTTs6WKN503AHYhyy8BiXgqN+GeOhV2E17zzrvm9I/Z8v4Ui0gehd
         3J2+Q2wAHE13xOxRk4Ep8uBPWUN9N3Z1WH4T2E8JzNAQyG/ssrMdskPeMyYeRUjJmSG1
         5+iVw4ifAvM8UGSQOA67spXJ6VJrSBQXRPnS3hQ1V3SMw3i/eoQSUS2ULv0vpuukZXpN
         m59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436016; x=1784040816;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSiXT8BgH5gghoHjr6RuM3GYQm/1BRXHKCcUkv22pbA=;
        b=rcTPcYqKQXpXpj1VvMooLvxfq9n6ROmPSWHtCLGJWGR5S4TBraW9dE1eGY/3G+CyJG
         rV5ZvIlvR8+h8hQ0FOeX94cs4fRtC39W8kCRGaRgBNh7tVwmVibmc5B0Sg84qg1ZZhqh
         CVpTexUBL54EXa8MymcixWyTX4uF0Q1/DmN8Q15cKjY68PjaoT7aG6FNLRIT1DQ4ox1+
         R7Ddp+3bPKH57FdZHw6z1lvOlEky43ImUe+3lnQzFaupQ/0JUE/cXv+eYYc/NYV2pAKw
         vbXYxJ1REGWRlXtao8yONR9HWpYj6s64q+l83wljveAn1opUPyAbXR/wOEDsE2FMrs51
         XRmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFZnYk2cEZI1ne3SnaYIhf8GzWakhdhnxkCnYlnIQDH/GyOTV9XUk8GITeEfBd0bP+MapsIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIMLPZ+Z2BFbfvYHUmUXydVXtFzaaLB+1ypjbCD8j7FINBze+
	TmWG6j3KblChAbLg0EoY41yEHnowIMERyqNouVMv4SGPOw1A5LVdl7WnaT8CgknZqp0ux2b3QqP
	eE87DXApZgiqzgg==
X-Received: from yxol18.prod.google.com ([2002:a53:c312:0:b0:662:c6c5:1f35])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:adcf:0:b0:667:8b90:2ecd with SMTP id 956f58d0204a3-6678b9053c4mr1451492d50.108.1783436015316;
 Tue, 07 Jul 2026 07:53:35 -0700 (PDT)
Date: Tue,  7 Jul 2026 14:53:29 +0000
In-Reply-To: <20260707145331.3717941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707145331.3717941-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707145331.3717941-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] geneve: convert config to RCU-protected pointer
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305507-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AEA371CE15

geneve_changelink() currently updates configuration by copying it over
the old one using memcpy() under RTNL, forcing data path pause via
geneve_quiesce() and synchronize_net() to avoid reading torn values.

Convert geneve->cfg to an RCU-protected pointer, allowing lockless
and safe reads under RCU read lock without synchronization overhead.

Key changes:
- Introduced geneve_config_alloc/free() helpers for lifecycle.
- geneve_configure() allocates config and publishes it via RCU.
- Setting dev->priv_destructor = geneve_free_dev handles config cleanup
  if register_netdevice() fails or during netdev unregistration.
- geneve_changelink() performs RCU swap; old config is freed via call_rcu_hurry().
- Allocates new dst_cache during changelink to prevent pcpu sharing.
- Removed geneve_quiesce/unquiesce() and synchronize_net() from changelink.
- Added rcu_barrier() to module exit to wait for pending callbacks.
- Updated data path to use rcu_dereference().
- Updated geneve_fill_info() to use rtnl_dereference() for now.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 213 ++++++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 95 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index cab38e7de8715f5a1ee0869e1d6c7b7ea9c693c1..f14e019f3f3f4d861ebd9e5e81175b8149b9acc2 100644
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
 
@@ -650,6 +649,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
+	const struct geneve_config *cfg;
 	struct genevehdr *geneveh;
 	struct geneve_dev *geneve;
 	struct geneve_sock *gs;
@@ -675,8 +675,9 @@ static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	inner_proto = geneveh->proto_type;
 
-	if (unlikely((!geneve->cfg.inner_proto_inherit &&
-		      inner_proto != htons(ETH_P_TEB)))) {
+	cfg = rcu_dereference(geneve->cfg);
+	if (unlikely(!cfg || (!cfg->inner_proto_inherit &&
+			      inner_proto != htons(ETH_P_TEB)))) {
 		dev_dstats_rx_dropped(geneve->dev);
 		goto drop;
 	}
@@ -1141,10 +1142,11 @@ static int geneve_sock_add(struct geneve_dev *geneve,
 static int geneve_open(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	const struct geneve_config *cfg = &geneve->cfg;
+	const struct geneve_config *cfg;
 	bool ipv4, ipv6, dualstack;
 	int ret = 0;
 
+	cfg = rtnl_dereference(geneve->cfg);
 	dualstack = cfg->dualstack;
 	ipv6 = cfg->info.mode & IP_TUNNEL_INFO_IPV6 || dualstack;
 	ipv4 = !ipv6 || dualstack;
@@ -1552,20 +1554,21 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 	const struct geneve_config *cfg;
 	int err;
 
-	cfg = &geneve->cfg;
+	rcu_read_lock();
+	cfg = rcu_dereference(geneve->cfg);
 	if (cfg->collect_md) {
 		info = skb_tunnel_info(skb);
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
 			dev_kfree_skb(skb);
 			dev_dstats_tx_dropped(dev);
+			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		}
 	} else {
 		info = &cfg->info;
 	}
 
-	rcu_read_lock();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (info->mode & IP_TUNNEL_INFO_IPV6)
 		err = geneve6_xmit_skb(skb, dev, geneve, cfg, info);
@@ -1604,9 +1607,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
-	const struct geneve_config *cfg = &geneve->cfg;
+	const struct geneve_config *cfg;
 	__be16 sport;
 
+	cfg = rcu_dereference(geneve->cfg);
+	if (unlikely(!cfg))
+		return -ENODEV;
+
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
 		struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
@@ -1721,7 +1728,50 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
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
+	RCU_INIT_POINTER(geneve->cfg, NULL);
+}
+
 static void geneve_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -1729,6 +1779,7 @@ static void geneve_setup(struct net_device *dev)
 	dev->netdev_ops = &geneve_netdev_ops;
 	dev->ethtool_ops = &geneve_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->priv_destructor = geneve_free_dev;
 
 	SET_NETDEV_DEVTYPE(dev, &geneve_type);
 
@@ -1890,15 +1941,17 @@ static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
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
@@ -1934,6 +1987,7 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 	struct geneve_dev *t, *geneve = netdev_priv(dev);
 	const struct ip_tunnel_info *info = &cfg->info;
 	bool tun_collect_md, tun_on_same_port;
+	struct geneve_config *new_cfg;
 	int err, encap_len;
 
 	if (cfg->collect_md && !is_tnl_info_zero(info)) {
@@ -1974,10 +2028,13 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 		}
 	}
 
-	dst_cache_reset(&geneve->cfg.info.dst_cache);
-	memcpy(&geneve->cfg, cfg, sizeof(*cfg));
+	new_cfg = geneve_config_alloc(cfg);
+	if (IS_ERR(new_cfg))
+		return PTR_ERR(new_cfg);
+
+	rcu_assign_pointer(geneve->cfg, new_cfg);
 
-	if (geneve->cfg.inner_proto_inherit) {
+	if (cfg->inner_proto_inherit) {
 		dev->header_ops = NULL;
 		dev->type = ARPHRD_NONE;
 		dev->hard_header_len = 0;
@@ -2335,81 +2392,45 @@ static int geneve_newlink(struct net_device *dev,
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
-
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
-
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
@@ -2444,12 +2465,13 @@ static size_t geneve_get_size(const struct net_device *dev)
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
@@ -2480,17 +2502,17 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
@@ -2503,7 +2525,7 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_be32(skb, IFLA_GENEVE_LABEL, info->key.label))
 		goto nla_put_failure;
 
-	if (nla_put_u8(skb, IFLA_GENEVE_DF, geneve->cfg.df))
+	if (nla_put_u8(skb, IFLA_GENEVE_DF, cfg->df))
 		goto nla_put_failure;
 
 	if (nla_put_be16(skb, IFLA_GENEVE_PORT, info->key.tp_dst))
@@ -2514,21 +2536,21 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
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
 
@@ -2683,6 +2705,7 @@ static void __exit geneve_cleanup_module(void)
 	rtnl_link_unregister(&geneve_link_ops);
 	unregister_netdevice_notifier(&geneve_notifier_block);
 	unregister_pernet_subsys(&geneve_net_ops);
+	rcu_barrier();
 }
 module_exit(geneve_cleanup_module);
 
-- 
2.55.0.795.g602f6c329a-goog


