Return-Path: <netdev+bounces-291496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAa7HCb+FGp2SAcAu9opvQ
	(envelope-from <netdev+bounces-291496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D36525CF99C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B6F30480A2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781202DCF52;
	Tue, 26 May 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXYUGGqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E242765E2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760321; cv=none; b=VQ4iFHCV+A6WGG2bGblIxn74HrlhojHY3c4l/VNM4LwdowsBLo6pGEDZC77T2mRG1GkdTl1Mfc501rRvKiqX7CsRM9zBvNwTftVrXdqJclCZKhUUVrDl9VyAuFvoNnztp4k5uHsUpNtn9T542r6omJXOTPPeY0lwb3fbPlpChts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760321; c=relaxed/simple;
	bh=z06ZRRJNm2MVDzWCQnp+a7tF20gQZT0N293UTlc65LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zr4Mde56xYnyzpW+Tqygkl0otXdoi34Lm8jfd25R6Eyd1nSIHhrJlwJDj98WUh9tSXZCL+BcLcA+5sM4J4PFUg42Sz2E8VxH8yZZEl/t+5qxSuLNt1QOwnBQmzYMW28xQgT12gLzgmX08ihZkCgTsAEn2AbktWaWHAtbv19qHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXYUGGqE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba3245a43dso110923485ad.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760319; x=1780365119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ9rIayN1+F9nhujGLENxSphCrKMbUfTuaJqzPLuCsE=;
        b=UXYUGGqEyoVquocDwPxbc7yVyctam7mHs8gPWvSiv1TbeMncHePniufTBh0XEftxye
         7BhI8ZG1Vb05EZDPOfe+RgxgDwwMyKcWinecnMvXyrjftx0vrhytqP+nu6t3ad9SJgya
         Ysc/Kwu65qdPptq4Hl/5FxaZFx9kMrOfUbdNURUUb1bJIU6ufdn/KxBU/VK8jj54Q3hz
         yjECkS/UE7Ho1+MFfUurp28wb4KzwTyehS+0iPdI0Q8FIRpEioKFF43GZe0mWTBHnGrS
         oRfstjnwQECQNnDQuHGH/abtfov1p8N+FydcXDBP+jHVAY93bpyosSY2JubKyoryEP26
         tRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760319; x=1780365119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ9rIayN1+F9nhujGLENxSphCrKMbUfTuaJqzPLuCsE=;
        b=fDXkWcqa2IcoXYQ3zGe28GOEmU/p9LaR43DOwwEyUn/Xf8H2GWJ/4KvZwLe4eZ9C2P
         YRSS2X1+FyOFE6aCn6DnbhuOBo/Ov1iKg+RU0VnWg9ex17OkaTHOPnqv/VDW5S0SBnzL
         8+hHYHqDj5Rj3xzeEsmGnd9Zshs9U0WKbs92yoCvGaWFBLg7K0KZ+2hie/V2jBaOkd7h
         4YNKt5TWhjKx54A9PFhRiWdTliIRgtERgh+SHVbK5N/xcUTWBRRxlraT4xvleJjStMTV
         eBU1BTe/zHuKsLyydLVCJL8M7XuGb0EM+xBtP+Fu7gp0PZx2KyV/o/g0wEKZkSe23Qkr
         /61Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Vny4zv55QtXJNKAM5oC5PFF/FV8X1FrKjuQX/sgWmQ5rsAWAx6y4837Ccq/wJvkJODlnOJLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTxfdbn8Y2dGGRCYjAn7fhitPtlFdmfkwE00zRkEuNPeSBEOh
	XUSyb3WqubziFRsTdl0HjIC0Tt3mKgEqulZX/3/asHb/zPb3YLSVXMO0Q64uFPfV6nUFBSy8ssE
	8ULBIGw==
X-Received: from plhd18.prod.google.com ([2002:a17:903:2312:b0:2bd:7e8e:c799])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2381:b0:2bc:7486:21cf
 with SMTP id d9443c01a7336-2beb06423d4mr167451295ad.36.1779760318634; Mon, 25
 May 2026 18:51:58 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:17 +0000
In-Reply-To: <20260526015152.2409183-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291496-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D36525CF99C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

Let's introduce new options, IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6,
to allow specifying a local IPv4/IPv6 address for the backend UDP
socket.

By default, when collect metadata mode (IFLA_GENEVE_COLLECT_METADATA)
is enabled, both IPv4 and IPv6 sockets are created.  However, if a
source address is specified via the new attributes, only a single
socket corresponding to that specific address family is created.

Accordingly, geneve_find_sock() and geneve_find_dev() are updated to
take the source address into account, ensuring that multiple devices
and sockets configured with different source addresses can coexist
without conflict.

In addition, the source address is validated in geneve_xmit_skb()
and geneve6_xmit_skb(), so the BPF prog must set it in bpf_tunnel_key.

With this change, multiple GENEVE devices can be successfully created
and bound to their respective local IP addresses:

  (*) "local" is the keyword for IFLA_GENEVE_LOCAL / IFLA_GENEVE_LOCAL6

  # for i in $(seq 1 2);
  do
          ip link add geneve4_${i} type geneve local 192.168.0.${i} external
          ip addr add 192.168.0.${i}/24 dev geneve4_${i}
          ip link set geneve4_${i} up

          ip link add geneve6_${i} type geneve local 2001:9292::${i} external
          ip addr add 2001:9292::${i}/64 dev geneve6_${i} nodad
          ip link set geneve6_${i} up
  done

  # ip -d l | grep geneve
  9: geneve4_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 192.168.0.1 ...
  10: geneve6_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 2001:9292::1 ...
  11: geneve4_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 192.168.0.2 ...
  12: geneve6_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 2001:9292::2 ...

  # ss -ua | grep geneve
  UNCONN 0      0         192.168.0.2:geneve      0.0.0.0:*
  UNCONN 0      0         192.168.0.1:geneve      0.0.0.0:*
  UNCONN 0      0      [2001:9292::2]:geneve            *:*
  UNCONN 0      0      [2001:9292::1]:geneve            *:*

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
iproute2 patch is here:
https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/

Changelog:
v3:
  * Use NLA_POLICY_EXACT_LEN() for IFLA_GENEVE_LOCAL6.
  * Mention source address in error messages in geneve_configure().
v2:
  * Move addr_type to if-block for CONFIG_IPV6=n.
  * Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().
---
 drivers/net/geneve.c         | 155 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/if_link.h |   2 +
 2 files changed, 148 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 3a62d132a8c4..20e8012837d8 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -775,9 +775,10 @@ static struct sock *geneve_create_sock(struct net *net,
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
 		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
+		udp_conf.local_ip6 = info->key.u.ipv6.src;
 	} else {
 		udp_conf.family = AF_INET;
-		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
+		udp_conf.local_ip.s_addr = info->key.u.ipv4.src;
 	}
 
 	udp_conf.local_udp_port = info->key.tp_dst;
@@ -1061,6 +1062,16 @@ static struct geneve_sock *geneve_find_sock(struct net *net,
 		if (gs->gro_hint != gro_hint)
 			continue;
 
+		if (family == AF_INET &&
+		    inet_sk(gs->sk)->inet_saddr != info->key.u.ipv4.src)
+			continue;
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (family == AF_INET6 &&
+		    !ipv6_addr_equal(&gs->sk->sk_v6_rcv_saddr, &info->key.u.ipv6.src))
+			continue;
+#endif
+
 		return gs;
 	}
 
@@ -1327,6 +1338,12 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
+	if (geneve->cfg.info.key.u.ipv4.src &&
+	    saddr != geneve->cfg.info.key.u.ipv4.src) {
+		dst_release(&rt->dst);
+		return -EADDRNOTAVAIL;
+	}
+
 	err = skb_tunnel_check_pmtu(skb, &rt->dst,
 				    GENEVE_IPV4_HLEN + info->options_len +
 				    geneve_build_gro_hint_opt(geneve, skb),
@@ -1438,6 +1455,12 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
+	if (!ipv6_addr_any(&geneve->cfg.info.key.u.ipv6.src) &&
+	    !ipv6_addr_equal(&saddr, &geneve->cfg.info.key.u.ipv6.src)) {
+		dst_release(dst);
+		return -EADDRNOTAVAIL;
+	}
+
 	err = skb_tunnel_check_pmtu(skb, dst,
 				    GENEVE_IPV6_HLEN + info->options_len +
 				    geneve_build_gro_hint_opt(geneve, skb),
@@ -1729,6 +1752,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
 	[IFLA_GENEVE_PORT_RANGE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ifla_geneve_port_range)),
 	[IFLA_GENEVE_GRO_HINT]		= { .type = NLA_FLAG },
+	[IFLA_GENEVE_LOCAL]		= { .type = NLA_BE32 },
+	[IFLA_GENEVE_LOCAL6]		= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1788,7 +1813,45 @@ static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+static bool geneve_saddr_wildcard(const struct ip_tunnel_info *info)
+{
+	if (ip_tunnel_info_af(info) == AF_INET) {
+		if (!info->key.u.ipv4.src)
+			return true;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (ipv6_addr_any(&info->key.u.ipv6.src))
+			return true;
+#endif
+	}
+
+	return false;
+}
+
+static bool geneve_saddr_conflict(const struct ip_tunnel_info *a,
+				  const struct ip_tunnel_info *b)
+{
+	if (ip_tunnel_info_af(a) != ip_tunnel_info_af(b))
+		return false;
+
+	if (geneve_saddr_wildcard(a) || geneve_saddr_wildcard(b))
+		return true;
+
+	if (ip_tunnel_info_af(a) == AF_INET) {
+		if (a->key.u.ipv4.src == b->key.u.ipv4.src)
+			return true;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		if (ipv6_addr_equal(&a->key.u.ipv6.src, &b->key.u.ipv6.src))
+			return true;
+#endif
+	}
+
+	return false;
+}
+
 static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
+					  const struct geneve_config *cfg,
 					  const struct ip_tunnel_info *info,
 					  bool *tun_on_same_port,
 					  bool *tun_collect_md)
@@ -1798,8 +1861,10 @@ static struct geneve_dev *geneve_find_dev(struct geneve_net *gn,
 	*tun_on_same_port = false;
 	*tun_collect_md = false;
 	list_for_each_entry(geneve, &gn->geneve_list, next) {
-		if (info->key.tp_dst == geneve->cfg.info.key.tp_dst) {
-			*tun_collect_md = geneve->cfg.collect_md;
+		if (info->key.tp_dst == geneve->cfg.info.key.tp_dst &&
+		    (cfg->dualstack || geneve->cfg.dualstack ||
+		     geneve_saddr_conflict(info, &geneve->cfg.info))) {
+			*tun_collect_md |= geneve->cfg.collect_md;
 			*tun_on_same_port = true;
 		}
 		if (info->key.tun_id == geneve->cfg.info.key.tun_id &&
@@ -1815,7 +1880,12 @@ static bool is_tnl_info_zero(const struct ip_tunnel_info *info)
 	return !(info->key.tun_id || info->key.tos ||
 		 !ip_tunnel_flags_empty(info->key.tun_flags) ||
 		 info->key.ttl || info->key.label || info->key.tp_src ||
-		 memchr_inv(&info->key.u, 0, sizeof(info->key.u)));
+#if IS_ENABLED(CONFIG_IPV6)
+		 (ip_tunnel_info_af(info) == AF_INET6 &&
+		  !ipv6_addr_any(&info->key.u.ipv6.dst)) ||
+#endif
+		 (ip_tunnel_info_af(info) == AF_INET &&
+		  info->key.u.ipv4.dst));
 }
 
 static bool geneve_dst_addr_equal(struct ip_tunnel_info *a,
@@ -1846,7 +1916,7 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 	geneve->net = net;
 	geneve->dev = dev;
 
-	t = geneve_find_dev(gn, info, &tun_on_same_port, &tun_collect_md);
+	t = geneve_find_dev(gn, cfg, info, &tun_on_same_port, &tun_collect_md);
 	if (t)
 		return -EBUSY;
 
@@ -1864,13 +1934,13 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 	if (cfg->collect_md) {
 		if (tun_on_same_port) {
 			NL_SET_ERR_MSG(extack,
-				       "There can be only one externally controlled device on a destination port");
+				       "There can be only one externally controlled device on a destination port and a source address");
 			return -EPERM;
 		}
 	} else {
 		if (tun_collect_md) {
 			NL_SET_ERR_MSG(extack,
-				       "There already exists an externally controlled device on this destination port");
+				       "There already exists an externally controlled device on this destination port and the source address");
 			return -EPERM;
 		}
 	}
@@ -1917,9 +1987,12 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->dualstack = true;
 	}
 
-	if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
+	if ((data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) ||
+	    (data[IFLA_GENEVE_LOCAL] && data[IFLA_GENEVE_LOCAL6]) ||
+	    (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_LOCAL6]) ||
+	    (data[IFLA_GENEVE_REMOTE6] && data[IFLA_GENEVE_LOCAL])) {
 		NL_SET_ERR_MSG(extack,
-			       "Cannot specify both IPv4 and IPv6 Remote addresses");
+			       "Cannot specify both IPv4/IPv6 Remote/Local addresses");
 		return -EINVAL;
 	}
 
@@ -1972,6 +2045,55 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 #endif
 	}
 
+	if (data[IFLA_GENEVE_LOCAL]) {
+		if (changelink) {
+			attrtype = IFLA_GENEVE_LOCAL;
+			goto change_notsup;
+		}
+
+		info->key.u.ipv4.src = nla_get_in_addr(data[IFLA_GENEVE_LOCAL]);
+
+		if (ipv4_is_multicast(info->key.u.ipv4.src)) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL],
+					    "Local IPv4 address cannot be Multicast");
+			return -EINVAL;
+		}
+
+		cfg->dualstack = false;
+	}
+
+	if (data[IFLA_GENEVE_LOCAL6]) {
+#if IS_ENABLED(CONFIG_IPV6)
+		int addr_type;
+
+		if (changelink) {
+			attrtype = IFLA_GENEVE_LOCAL6;
+			goto change_notsup;
+		}
+
+		info->mode = IP_TUNNEL_INFO_IPV6;
+		info->key.u.ipv6.src = nla_get_in6_addr(data[IFLA_GENEVE_LOCAL6]);
+
+		addr_type = ipv6_addr_type(&info->key.u.ipv6.src);
+		if (addr_type & IPV6_ADDR_LINKLOCAL) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL6],
+					    "Local IPv6 address cannot be link-local");
+			return -EINVAL;
+		}
+		if (addr_type & IPV6_ADDR_MULTICAST) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL6],
+					    "Local IPv6 address cannot be Multicast");
+			return -EINVAL;
+		}
+
+		cfg->dualstack = false;
+#else
+		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_LOCAL6],
+				    "IPv6 support not enabled in the kernel");
+		return -EPFNOSUPPORT;
+#endif
+	}
+
 	if (data[IFLA_GENEVE_ID]) {
 		__u32 vni;
 		__u8 tvni[3];
@@ -2265,6 +2387,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 {
 	return nla_total_size(sizeof(__u32)) +	/* IFLA_GENEVE_ID */
 		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_REMOTE{6} */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_LOCAL{6} */
 		nla_total_size(sizeof(__u8)) +  /* IFLA_GENEVE_TTL */
 		nla_total_size(sizeof(__u8)) +  /* IFLA_GENEVE_TOS */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_GENEVE_DF */
@@ -2320,6 +2443,20 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 #endif
 	}
 
+	if (!geneve->cfg.dualstack) {
+		if (ip_tunnel_info_af(info) == AF_INET) {
+			if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
+					    info->key.u.ipv4.src))
+				goto nla_put_failure;
+#if IS_ENABLED(CONFIG_IPV6)
+		} else {
+			if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
+					     &info->key.u.ipv6.src))
+				goto nla_put_failure;
+#endif
+		}
+	}
+
 	if (nla_put_u8(skb, IFLA_GENEVE_TTL, info->key.ttl) ||
 	    nla_put_u8(skb, IFLA_GENEVE_TOS, info->key.tos) ||
 	    nla_put_be32(skb, IFLA_GENEVE_LABEL, info->key.label))
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 46413392b402..363526549a01 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1506,6 +1506,8 @@ enum {
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
 	IFLA_GENEVE_PORT_RANGE,
 	IFLA_GENEVE_GRO_HINT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
-- 
2.54.0.746.g67dd491aae-goog


