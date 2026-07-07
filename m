Return-Path: <netdev+bounces-305506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnxaLQkWTWpbuwEAu9opvQ
	(envelope-from <netdev+bounces-305506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:06:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F771D02D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cnRmzzV5;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305506-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305506-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A79630239F3
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1D370AD6;
	Tue,  7 Jul 2026 14:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A834B697
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436017; cv=none; b=KCyqyNPY5L1T4lU9SvjjyWQIg8KcBRGP3Yw/tHllSPMwBmjKJZhmu8VA17124/VgvXY6Rl0C3/QwyFpFC07F6WJlcLYTjhogkrVA1c0NBqSPnLalnfKEKP+Hg99RuPwH8DJcPis6pVk2jk7u75YNVuRLR2hwZ2OvJGHWuB1soL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436017; c=relaxed/simple;
	bh=32+O+yeb+989HX4IMehQKV5eIbfdRntun/x+LpCLt5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXOQTRaP+1NfhmT78sdYfM/TMdSkEfjBJyQC21xiGeP2GysiYBm29GegbhzLU0WyLnoydRWHYN7+htzT0AD4nXaTeBgxfXMAT4NA3el1kKQTPTP47aYnN8ShwW09s5a+LFaicMAiBsCF/QHH+Oig2vI2eUwurl74Jtz+EGlsFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnRmzzV5; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92e53b8a302so415254685a.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436014; x=1784040814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcDtvlhCeZjHR6pxrxUBJml89EYFLzFPSdxxO3r9g/0=;
        b=cnRmzzV5fgV5osIU9zcRBGVDt32cAr1jfifgoqHvAHn2WUU4/Q3lGm4aslr8l3sRU2
         Vmngc69455gjasKfC73bgZS1fwhnXerCl881bPzfYNtM6KdfUbSXFz4H8dxZ4pnB46zC
         sD2qjIwpri6JSfxOg85bMZZm8CbAQ+eCRkAlFilQciUgOdPoHoRO7PyBWlWuLhjlIL/V
         JgfL515AtAy1JY1Ci+7wOWianbiC8ZKMhPmELtU2SD0IY+jB7royRzot14Yg5qx34e+7
         GvHVyCI+mq2sGsqtUPo/LNdC6/fbDz80nF+vxwV1ELxXvx53UNVdzmXA0DpGwtQGuw4L
         IcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436014; x=1784040814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcDtvlhCeZjHR6pxrxUBJml89EYFLzFPSdxxO3r9g/0=;
        b=MAguOQgSUHfnOEugaGvnvXSH0qHjVOiilpGxaIfLhFDW8uHn+pecUX8zH1fTbVd8d+
         m3cNxxrM/XUjTpDgElisEewWIy0C5Df9lw2zh6BeZMR+792n8ZvRzaLv5kLjZcwwhGja
         4mrsJH1oxZ/l/TbMVTYTBc76f9+APpcVBldw9Jy/U47S2F3Kfaf9CKtGKrlCYV+nmqtC
         3IxFqbR38fWCTV/C2yZvrGgNbO7cTM5/Rb0Fj4eS7a+/Z/KC6eO4mqWSeAo4IGd0daRi
         f8h3vAhVR8W3DKB0ETdWKb3549t555btV2WOI1P4htqw7G7WFyFjvKAv3eDYZcbnHEOv
         6DSw==
X-Forwarded-Encrypted: i=1; AHgh+RoEixOVi44aCuaImWliA1mM1ZNjihBRmYOQSmx6+DxVLeObidG93DgYuub41/IuUAVrzClE3zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLpS366/6c9GqitAd0VhCp6uBO+/1p0qKGWjnkfzQbZBAMjhB
	rn2idRg1nVrLqnU3uMSkYHuZzRVwx4kQwe2rX/6EywXfybkdbe0Vpdmu7gOC8d66PKK5hcMw9d6
	Y1JEC6ZooFZO1tQ==
X-Received: from qkbbs41.prod.google.com ([2002:a05:620a:4729:b0:92e:754e:227e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40c7:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92ebb575ad4mr639616585a.31.1783436013827;
 Tue, 07 Jul 2026 07:53:33 -0700 (PDT)
Date: Tue,  7 Jul 2026 14:53:28 +0000
In-Reply-To: <20260707145331.3717941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707145331.3717941-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707145331.3717941-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] geneve: pass geneve_config pointer to helper functions
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305506-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A07F771D02D

In preparation for converting geneve->cfg to an RCU-protected pointer,
update helper functions to explicitly accept a const struct geneve_config
pointer instead of dereferencing geneve->cfg directly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 140 +++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 64 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 396e1a113cd49e9a43bfe6c7cd78f15ca8963906..cab38e7de8715f5a1ee0869e1d6c7b7ea9c693c1 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -762,9 +762,10 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
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
@@ -775,7 +776,7 @@ static struct sock *geneve_create_sock(struct net *net,
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
-		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
+		udp_conf.use_udp6_rx_checksums = cfg->use_udp6_rx_checksums;
 		udp_conf.local_ip6 = info->key.u.ipv6.src;
 	} else
 #endif
@@ -991,7 +992,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 /* Create new listen socket if needed */
 static struct geneve_sock *geneve_socket_create(struct net *net,
-						struct geneve_dev *geneve, bool ipv6)
+						struct geneve_dev *geneve,
+						const struct geneve_config *cfg, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct udp_tunnel_sock_cfg tunnel_cfg;
@@ -1003,7 +1005,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sk = geneve_create_sock(net, geneve, ipv6);
+	sk = geneve_create_sock(net, geneve, cfg, ipv6);
 	if (IS_ERR(sk)) {
 		kfree(gs);
 		return ERR_CAST(sk);
@@ -1060,12 +1062,13 @@ static void geneve_sock_release(struct geneve_dev *geneve)
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
 
@@ -1095,7 +1098,8 @@ static struct geneve_sock *geneve_find_sock(struct net *net,
 	return NULL;
 }
 
-static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
+static int geneve_sock_add(struct geneve_dev *geneve,
+			   const struct geneve_config *cfg, bool ipv6)
 {
 	struct net *net = geneve->net;
 	struct geneve_dev_node *node;
@@ -1103,19 +1107,19 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
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
@@ -1128,7 +1132,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	}
 	node->geneve = geneve;
 
-	tunnel_id_to_vni(geneve->cfg.info.key.tun_id, vni);
+	tunnel_id_to_vni(cfg->info.key.tun_id, vni);
 	hash = geneve_net_vni_hash(vni);
 	hlist_add_head_rcu(&node->hlist, &gs->vni_list[hash]);
 	return 0;
@@ -1137,21 +1141,22 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 static int geneve_open(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	bool dualstack = geneve->cfg.dualstack;
-	bool ipv4, ipv6;
+	const struct geneve_config *cfg = &geneve->cfg;
+	bool ipv4, ipv6, dualstack;
 	int ret = 0;
 
-	ipv6 = geneve->cfg.info.mode & IP_TUNNEL_INFO_IPV6 || dualstack;
+	dualstack = cfg->dualstack;
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
 
@@ -1189,6 +1194,7 @@ static void geneve_build_header(struct genevehdr *geneveh,
 }
 
 static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
+				     const struct geneve_config *cfg,
 				     struct sk_buff *skb)
 {
 	struct geneve_skb_cb *cb = GENEVE_SKB_CB(skb);
@@ -1201,7 +1207,7 @@ static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
 	cb->gro_hint_len = 0;
 
 	/* Try to add the GRO hint only in case of double encap. */
-	if (!geneve->cfg.gro_hint || !skb->encapsulation)
+	if (!cfg->gro_hint || !skb->encapsulation)
 		return 0;
 
 	/*
@@ -1262,10 +1268,11 @@ static void geneve_put_gro_hint_opt(struct genevehdr *gnvh, int opt_size,
 
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
@@ -1306,14 +1313,14 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
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
@@ -1323,6 +1330,7 @@ static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
 
 static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
+			   const struct geneve_config *cfg,
 			   const struct ip_tunnel_info *info)
 {
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
@@ -1335,35 +1343,35 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -1397,21 +1405,21 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -1425,13 +1433,13 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -1441,6 +1449,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 #if IS_ENABLED(CONFIG_IPV6)
 static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
+			    const struct geneve_config *cfg,
 			    const struct ip_tunnel_info *info)
 {
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
@@ -1452,35 +1461,35 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -1513,22 +1522,22 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -1539,10 +1548,12 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	struct ip_tunnel_info *info = NULL;
+	const struct ip_tunnel_info *info = NULL;
+	const struct geneve_config *cfg;
 	int err;
 
-	if (geneve->cfg.collect_md) {
+	cfg = &geneve->cfg;
+	if (cfg->collect_md) {
 		info = skb_tunnel_info(skb);
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
 			netdev_dbg(dev, "no tunnel metadata\n");
@@ -1551,16 +1562,16 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_OK;
 		}
 	} else {
-		info = &geneve->cfg.info;
+		info = &cfg->info;
 	}
 
 	rcu_read_lock();
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
@@ -1593,6 +1604,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
+	const struct geneve_config *cfg = &geneve->cfg;
 	__be16 sport;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
@@ -1606,14 +1618,14 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
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
@@ -1633,14 +1645,14 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
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
@@ -1653,7 +1665,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	info->key.tp_src = sport;
-	info->key.tp_dst = geneve->cfg.info.key.tp_dst;
+	info->key.tp_dst = cfg->info.key.tp_dst;
 	return 0;
 }
 
-- 
2.55.0.795.g602f6c329a-goog


