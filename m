Return-Path: <netdev+bounces-256864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJe6EHjOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95942ED1EB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B2C3020027
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19863396B66;
	Wed,  4 Feb 2026 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Dtt7p/p9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7149393DCC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245599; cv=none; b=c8VZC3yHnMXt3Ela71GiFdEX7LiEWaweh+Qt+hweha2ZckbDrcG0SdwlONRaSU5d/JDUbP1YHM0BfAZDOo8dCogfeI6ko75cVbY1jz08wFrOZL4DvCy1nXzlatw3ZLrRD6QfBRSgOAByYYxKwfnGAqfwStaBCtr2X6gUBRRenmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245599; c=relaxed/simple;
	bh=6KP2ToFxtH3sIGuXAc/7v2O7m+JWpx7WllBTaOSCOqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s51Fo9PQTEHHTvxrd4W506M1XGaE39BNta2YULFLJUvrkMQP9LbzeDKRXOj6rbpxlOYmRO4M+CXhHSAHMJCn/LQH1Rm2wZA15hSm6WLsbGf4UgsyVyJAuPIo4vqi8UcOPxvJJvHLveArHmC3ZbwfiLkTgdUjaN0x579ugR4DEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Dtt7p/p9; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b7070acfdcso274041eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245598; x=1770850398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqLW+w/VlgLIRKVOC7i8A7N3zmBEyffxOIi1skwzN5k=;
        b=Dtt7p/p9iCrXeFCQhwgK+BbrrwDGMwH5++V9nFIO8Vl+GZ82aFVEU95OIOWOlX+G1c
         7eOBp4KhYuVv6M0covqhpb7XTD0x/DNwGtfL3t4N5l5Da866kfYh7Z/AurKMWlJ+plNj
         kCdtxcAH7gTulpxvGnfEIGywE8UeQiJRK37E1wTePBMc5GI1u7W1asfnlFkcMFk3tB0D
         hAeJfobmo1MZEWM54pNmLwTGxxyal/dVzrdp/UOVS0PTFziju8zNx8iXFOdBT1Ot/N32
         KXu9lLygMvBB4hIw6PdX78Kn8KKbLtAczRdwT/dIQmBM4GKirbZ0hMtaRZoFUGwRvnoU
         Fzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245598; x=1770850398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqLW+w/VlgLIRKVOC7i8A7N3zmBEyffxOIi1skwzN5k=;
        b=LCjKqzMfKXIM0hZ1+BB/Ukn7rdvokTD54XaYVDwhJuIHmD7F4wBvHUUR1b0vMhXzDE
         t63HIytKcOrs3F+2V8w4xY1gilqoFrv7JCDdfwQjalnwA1nZSp00NCwOtJOKbJqWotLk
         A21zEL++oMulSlpuJg2A2UbgtF0AKBHcxJU/XZVRwCMRuPhLAjZVShVXfmmTknXhceY3
         mxq+z1xsRvNNZzUTi0sWu9Tkt+Pj/on6+xHkV85xKK0EgMmBp/IjESESTypyh0Kq/x+a
         A7un9wD9gFzNmcMia3SKRehviKjyaeuU1uRZbUR+rQjsesnT+EgkFUm/P9bV3wgOwLGn
         kbsA==
X-Forwarded-Encrypted: i=1; AJvYcCUzutC0WAnNUu1ml/pQYFWu/vnDH2ThCSTT26jLDjmXQ+uEiXaXXD9BdhaFQUjzVR7ptVIi2yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYqlJEj2BqyBFPqkZtRdRLVQVolO6ZE59r4bXH72ub5EYdHKa
	rrrbdmnW2oHoS1f5tklWjaEDAw/g/j2KGXyWU+LZeN4ARSQmDzvlEU6iJdjvqFleffqlA3TDN6B
	puNg=
X-Gm-Gg: AZuq6aLI5w87sKSftSmAVTnaen0/9x3YP/xZgtYsgg5q1Nted5kXcj4VOe0Zf8MsllE
	FjwJ2gqsW1Ixy53bv8yKOkrcD6lGDrTnaP+pqLk2K1hh/bJPctqDSvOkiRyb3x1y5QR1HUCvMJ3
	YzUEU44rGCX8eu/W+5HBydbXD+qjx47OAj9YEGlNz6zT5DCceoatUZ5ST272AuKMxmU1tcRIssb
	b+iSzM4vTWn7JCXQXvqtLz3/DoADboI2YDZqR7//29zRCOHWhCZJ6xVUkXzYPTtU0vGWafUsKf9
	wWoqWgFXaCf8e0j17fa6Cxu5fGexE0Ne+Web6ObXkKSI16H8QeczYgITLUzETDMQ4hbuQAX7uFt
	61JUY6q3D2/zroKzC7bWgqwaWybZki6LsWHHClvCXCr5XHu3DdztvTSyDgx1udjNNdfQ6fheAkx
	g585sc8bZ8j0rA3psGYCbOAVOoL7/c7QxFfi5B6rRrbwRef6luhsNb6Cgv
X-Received: by 2002:a05:7300:324d:b0:2b7:fcb:765e with SMTP id 5a478bee46e88-2b8329b1482mr1976066eec.39.1770245597886;
        Wed, 04 Feb 2026 14:53:17 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:17 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v7 06/10] ipv6: Enforce Extension Header ordering
Date: Wed,  4 Feb 2026 14:51:50 -0800
Message-ID: <20260204225154.58245-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256864-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95942ED1EB
X-Rspamd-Action: no action

RFC8200 highly recommends that different Extension Headers be sent in
a prescribed order and all Extension Header types occur at most once
in a packet with the exception of Destination Options that may
occur twice. This patch enforces the ordering be followed in received
packets.

The allowed order of Extension Headers is:

    IPv6 header
    Hop-by-Hop Options header
    Destination Options before the Routing Header
    Routing header
    Fragment header
    Authentication header
    Encapsulating Security Payload header
    Destination Options header
    Upper-Layer header

Each Extension Header may be present only once in a packet expect
for Destination Options that may occur twice.

net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
enforcement of extension Header order. If it is set to zero then
Extension Header order and number of occurrences is not checked
in receive processing (except for Hop-by-Hop Options that
must be the first Extension Header and can only occur once in
a packet).

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/netns/ipv6.h   |  1 +
 include/net/protocol.h     | 14 +++++++++++++
 net/ipv6/af_inet6.c        |  1 +
 net/ipv6/exthdrs.c         |  2 ++
 net/ipv6/ip6_input.c       | 42 ++++++++++++++++++++++++++++++++++++++
 net/ipv6/reassembly.c      |  1 +
 net/ipv6/sysctl_net_ipv6.c |  7 +++++++
 net/ipv6/xfrm6_protocol.c  |  2 ++
 8 files changed, 70 insertions(+)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308e8f..2db56718ea60 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
 	u8 fib_notify_on_flag_change;
 	u8 icmpv6_error_anycast_as_unicast;
 	u8 icmpv6_errors_extension_mask;
+	u8 enforce_ext_hdr_order;
 };
 
 struct netns_ipv6 {
diff --git a/include/net/protocol.h b/include/net/protocol.h
index b2499f88f8f8..0f1676625570 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -50,6 +50,19 @@ struct net_protocol {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+
+/* Order of extension headers as prescribed in RFC8200. The ordering and
+ * number of extension headers in a packet can be enforced in IPv6 receive
+ * processing.
+ */
+#define IPV6_EXT_HDR_ORDER_HOP			BIT(0)
+#define IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH	BIT(1)
+#define IPV6_EXT_HDR_ORDER_ROUTING		BIT(2)
+#define IPV6_EXT_HDR_ORDER_FRAGMENT		BIT(3)
+#define IPV6_EXT_HDR_ORDER_AUTH			BIT(4)
+#define IPV6_EXT_HDR_ORDER_ESP			BIT(5)
+#define IPV6_EXT_HDR_ORDER_DEST			BIT(6)
+
 struct inet6_protocol {
 	int	(*handler)(struct sk_buff *skb);
 
@@ -61,6 +74,7 @@ struct inet6_protocol {
 
 	unsigned int	flags;	/* INET6_PROTO_xxx */
 	u32		secret;
+	u32		ext_hdr_order;
 };
 
 #define INET6_PROTO_NOPOLICY	0x1
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index bd29840659f3..43097360ce64 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
+	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
 	atomic_set(&net->ipv6.fib6_sernum, 1);
 
 	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index bfce1ddab1c5..ca63bccc76fe 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 static const struct inet6_protocol rthdr_protocol = {
 	.handler	=	ipv6_rthdr_rcv,
 	.flags		=	INET6_PROTO_NOPOLICY,
+	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ROUTING,
 };
 
 static const struct inet6_protocol destopt_protocol = {
 	.handler	=	ipv6_destopt_rcv,
 	.flags		=	INET6_PROTO_NOPOLICY,
+	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_DEST,
 };
 
 static const struct inet6_protocol nodata_protocol = {
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 168ec07e31cc..1eb8e84d98b3 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -355,6 +355,27 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
 		ip6_sublist_rcv(&sublist, curr_dev, curr_net);
 }
 
+static u32 check_dst_opts_before_rh(const struct inet6_protocol *ipprot,
+				    u32 ext_hdrs)
+{
+	/* Check if Destination Options before the Routing Header are
+	 * present.
+	 */
+	if (ipprot->ext_hdr_order != IPV6_EXT_HDR_ORDER_ROUTING ||
+	    !(ext_hdrs & IPV6_EXT_HDR_ORDER_DEST))
+		return ext_hdrs;
+
+	/* We have Destination Options before the Routing Header. Set
+	 * the mask of received extension headers to reflect that. We promote
+	 * the bit from indicating just Destination Options present to
+	 * Destination Options before the Routing Header being present
+	 */
+	ext_hdrs = (ext_hdrs & ~IPV6_EXT_HDR_ORDER_DEST) |
+		IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH;
+
+	return ext_hdrs;
+}
+
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
 
 /*
@@ -366,6 +387,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
 	unsigned int nhoff;
+	u32 ext_hdrs = 0;
 	SKB_DR(reason);
 	bool raw;
 
@@ -427,6 +449,26 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 				goto discard;
 			}
 		}
+
+		if (ipprot->ext_hdr_order &&
+		    READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
+			/* The protocol is an extension header and EH ordering
+			 * is being enforced. Discard packet if we've already
+			 * seen this EH or one that is lower in the order list
+			 */
+			if (ipprot->ext_hdr_order <= ext_hdrs) {
+				/* Check if there's Destination Options
+				 * before the Routing Header
+				 */
+				ext_hdrs = check_dst_opts_before_rh(ipprot,
+								    ext_hdrs);
+				if (ipprot->ext_hdr_order <= ext_hdrs)
+					goto discard;
+			}
+
+			ext_hdrs |= ipprot->ext_hdr_order;
+		}
+
 		if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
 			if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 				SKB_DR_SET(reason, XFRM_POLICY);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..91dba72c5a3c 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 static const struct inet6_protocol frag_protocol = {
 	.handler	=	ipv6_frag_rcv,
 	.flags		=	INET6_PROTO_NOPOLICY,
+	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_FRAGMENT,
 };
 
 #ifdef CONFIG_SYSCTL
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d..543b6acdb11d 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &ioam6_id_wide_max,
 	},
+	{
+		.procname	= "enforce_ext_hdr_order",
+		.data		= &init_net.ipv6.sysctl.enforce_ext_hdr_order,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+	},
 };
 
 static struct ctl_table ipv6_rotable[] = {
diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
index ea2f805d3b01..5826edf67f64 100644
--- a/net/ipv6/xfrm6_protocol.c
+++ b/net/ipv6/xfrm6_protocol.c
@@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol = {
 	.handler	=	xfrm6_esp_rcv,
 	.err_handler	=	xfrm6_esp_err,
 	.flags		=	INET6_PROTO_NOPOLICY,
+	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ESP,
 };
 
 static const struct inet6_protocol ah6_protocol = {
 	.handler	=	xfrm6_ah_rcv,
 	.err_handler	=	xfrm6_ah_err,
 	.flags		=	INET6_PROTO_NOPOLICY,
+	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_AUTH
 };
 
 static const struct inet6_protocol ipcomp6_protocol = {
-- 
2.43.0


