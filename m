Return-Path: <netdev+bounces-251314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40645D3B930
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4101303C802
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21892E0B48;
	Mon, 19 Jan 2026 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="hMvnDb0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D42F7475
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857195; cv=none; b=JoeMrEgiL3JyhTEeHvPGL6E8XW/idH1QP4ojIvHdmlRyAANinlDUmJDpHCssmyNUATMYjV/4uakkeXr4ssCi+x4g3lVd8rXQ7Yldr6dJOfF9lgZC2xg64tzIjEFje0nwalNxaicl8jz8LgvAmQ+qlCUU7C4118LB8cesJxVsIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857195; c=relaxed/simple;
	bh=N0UADbFcgOUAWPlU+TYA1e3qTm3y7uQC88+tFXK2w7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEOd2l1p6QGbE4356djWM+SkJSfXFX8mo24PhERtfaqj5sSF6b842RQw09fCmNfV0L7VlrIOSAyNY7onYLX4kNxkTe8MO9RJMbWDHGDCqsI0OMv0AgmxQlODJJfG3Hh/xPcfF6y0WXzSnfGAVCZniJNlNjr+90XPSeMFcCh99J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=hMvnDb0h; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4805789eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857188; x=1769461988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3rAxO8AFPUtgapey+1QG5iXmw5MbF0AQDYRmmhZbX8=;
        b=hMvnDb0hkyeMF9gfR/hRlxluAMetK+8+YqM/5DlvB3MHjuJsefh0oJRn/JuxcUfeT5
         /igTzZ2sRz9mBuUaGeBlJC8reUodTfZ28BbIxRH2Gyag1QNj0Hc19V0H3fRalqkWDkeR
         VIAA8Hn24hr3QvfoaFPwGX8lV1xW35pK9pvNjxBM/mn1CLUnwCnygF+D/uRpvc+/OWDV
         aVPR4dtWUG93x173iMU4bzT6oyj9NvPGEwk1uhxYB79cax6OOCHAGD2XEqZsw/DRAQNu
         Y/Z0F/5X0e2OebWYduuB97dzE0r/fAU6FA1Ipwk2bgy94/z3e4DhqeYqMqmo68GGt8cV
         lSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857188; x=1769461988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3rAxO8AFPUtgapey+1QG5iXmw5MbF0AQDYRmmhZbX8=;
        b=E5tdxxu2B86kCtV6PUH00vsBWTgUd7cL+veUa2If8eWKsPKn1dLEvB6wl2p8fR7SrT
         6eZgx+z7Kv/rRZHWfY+5BMJs2tVVd3ZJs9kqCUPz/w3XDyTJCz+b1OTOQwyi6vLjf0g/
         k8R/maNl2mes8KFSWM/YzansFzN3w3iPIZrqjr7tAzoHYAUaE4LbHinBFuVCVWCGH28n
         JKaygqr21qYaypkmq0Q28rsCVSZhcxyZd3YTESRKMJaYMVeyI4liW9PuFKU1RS3z/fMX
         K/qlGRvn0Y1Uh9IxqEu8Mp65r1spVUBreJjt8swwgq6uRa4kyr8QFMa8z+a/BNdsrc7g
         HCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxehXgSo99a/42nzfpGAXMWKJg+W7diQOosQWuGigK/de1ngPOSUvpHgAUfd6vwQUuU5wJhq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsbQ9EMMmyrar38EWbQIA7TLknPmqrTk+USQRhXfRSsqyv7FC
	xMUKV3mWu/7sjEpw54+mwEDYJNyR7t89Bi2tonTnJIRJ7x7c+VjITlgJWExtlipt5A==
X-Gm-Gg: AZuq6aJNE5SjWoPGDqlouKZRtzOUycGkatUuca+qMuIT52uGAPaibAQQYAMJBhcMPtg
	JYgqF1YHA6CZCN84ansI6pELcqxXrRTXRM5AuFhkVonRFW1tH1nfjfne3DgGn1nlfzhz9zb/IJK
	Q8DYmjmtr178c9UMFeZYNzZb0LOZCAgKhhwEF4NqZBD8OWeDRGRWxXNtZlvuTiveTGLNE1wet+b
	16VunsNyt4atI5C7nW7c9wB5DLHdLr0DQgbjmpKIdj2ISEV7ckH6wS6Rtb7vHsbYafOzjFNL81I
	ULQG5bWZD+DlfvwMRdUfGjDCScPWCevzRFrEL5GWdzpVglg/FkYESN+XjuKizHR2fSTjMDlQbKf
	ugrU61oYMMsz0uoa+AY25qVIw31euF91SSwBrQd/1FgDqgO01vIHoXqNCC/QAvpOcrDEzIoHbeY
	vTKNw28e+CohYrZGVPyCoht5lMJscVAamKmjkWgg+2Tt4Cs55fOtt80jCd
X-Received: by 2002:a05:7300:df4c:b0:2ae:5db9:f32c with SMTP id 5a478bee46e88-2b6b40f34cdmr8238954eec.26.1768857187990;
        Mon, 19 Jan 2026 13:13:07 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:13:07 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 6/7] ipv6: Enforce Extension Header ordering
Date: Mon, 19 Jan 2026 13:12:11 -0800
Message-ID: <20260119211212.55026-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC8200 highly recommends that different Extension Headers be send in
a prescribed order and all Extension Header types occur at most once
in a packet with the exception of Destination Options that may
occur twice. This patch enforces the ordering be followed in received
packets. It also disregards Destination Options before the Routing
Header as those are unused in deployment and there is a proposal
to deprecate them in draft-herbert-deprecate-destops-before-rh.

The allowed order of Extension Headers is:

    IPv6 header
    Hop-by-Hop Options header
    Routing header
    Fragment header
    Authentication header
    Encapsulating Security Payload header
    Destination Options header
    Upper-Layer header

Each Extension Header may be present only once in a packet.

net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
enforcement of Extension Header order. If it is set to zero then
Extension Header order and number of occurrences is not checked
in receive processing (except for Hop-by-Hop Options that
must be the first Extension Header and can only occur once in
a packet.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/netns/ipv6.h   |  1 +
 include/net/protocol.h     | 16 ++++++++++++++++
 net/ipv6/af_inet6.c        |  1 +
 net/ipv6/exthdrs.c         |  2 ++
 net/ipv6/ip6_input.c       | 14 ++++++++++++++
 net/ipv6/reassembly.c      |  1 +
 net/ipv6/sysctl_net_ipv6.c |  7 +++++++
 net/ipv6/xfrm6_protocol.c  |  2 ++
 8 files changed, 44 insertions(+)

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
index b2499f88f8f8..70cc2d0fdc0c 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -50,6 +50,21 @@ struct net_protocol {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+
+/* Order of extension headers as prescribed in RFC8200. The ordering and
+ * number of extension headers in a packet can be enforced in IPv6 receive
+ * processing. Destination Options before the Routing Header is not included
+ * in the list as they are unused in deployment and it has been proposed that
+ * they be deprecated. See:
+ * www.ietf.org/archive/id/draft-herbert-deprecate-destops-before-rh-01.txt
+ */
+#define IPV6_EXT_HDR_ORDER_HOP		BIT(0)
+#define IPV6_EXT_HDR_ORDER_ROUTING	BIT(1)
+#define IPV6_EXT_HDR_ORDER_FRAGMENT	BIT(2)
+#define IPV6_EXT_HDR_ORDER_AUTH		BIT(3)
+#define IPV6_EXT_HDR_ORDER_ESP		BIT(4)
+#define IPV6_EXT_HDR_ORDER_DEST		BIT(5)
+
 struct inet6_protocol {
 	int	(*handler)(struct sk_buff *skb);
 
@@ -61,6 +76,7 @@ struct inet6_protocol {
 
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
index 394e3397e4d4..2af16694db46 100644
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
index 168ec07e31cc..5254ead5c226 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -366,6 +366,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
 	unsigned int nhoff;
+	u32 ext_hdrs = 0;
 	SKB_DR(reason);
 	bool raw;
 
@@ -427,6 +428,19 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
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
+			if (ipprot->ext_hdr_order <= ext_hdrs)
+				goto discard;
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


