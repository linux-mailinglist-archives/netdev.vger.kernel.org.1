Return-Path: <netdev+bounces-253585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFYFGJ7Fd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B523D8CC5C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17AB300EFB4
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAE287269;
	Mon, 26 Jan 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="INoHXQbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DE28725F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456941; cv=none; b=MJVStBYejjvtaUeZW6kpydlkTm6jok4V299UsyN3CWVyZ69G46QQxtWDc/uAIHCy5AsTxiFQyrBUqe6K54S8mYiE6M5az+aKv2/4OIleyvWTdEEGIp/Bbm2/iCFV0esCEwlopNwnpX9789KZyQxDUbKdhSu9YnUrMFW13tH0pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456941; c=relaxed/simple;
	bh=Xr5ZkveNDouilggOSLHbE0tsn+6QQjBXYUMZcGCeV9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsqR26ggeFwDulAhYEyuFsPs3SJ4TPACXId/ejn6Rfv3Q2Ufo+QHhcs0+GpmgH776O04lyVg7lT0zyzp4KpQEZzUiMY4d/xXbyzzQ4m2jP+ToywxNzAqSMBWoRexXYqEYfd6GnoZcVqV2d/ew84VhE7hKxAdsd6ElnJCbJe8eDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=INoHXQbo; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124877d78a6so2419299c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456939; x=1770061739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjEwUOP6oEW4jX7BWQW+iMbmctWmpD6RyXPK4rdDyFA=;
        b=INoHXQboEGrUfB1VVQhOOmgZkmxkhHVfM+A1bOYHwBt99t7WoQJaU9oBddm2LFfTNZ
         shdb0kBrcu9PGryE5/4uawDtftw73B6bC8sr3w6SlP8U6weABjO/1hApwW8vf6wALYEP
         G6agFvysTABlzv4xHK1tGUPL0G1RJa45O8KJ80hYosNfZW+H4f8gOTuaAAhmJlgS6Wpr
         hM6/UaTyv6GqNSCVvcP5QydNkDnCYB7G7rtU6IxV90t63GENMwTQ88p1oDp8YGHlGiGH
         L/AzvggcRhrOCr2f6131wpVoSYv7n/0RhQCmdpU07p6KNZwXOcHqfNVUKpPW+pbxObds
         F++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456939; x=1770061739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjEwUOP6oEW4jX7BWQW+iMbmctWmpD6RyXPK4rdDyFA=;
        b=NjLkEIIHUzPucf11TlcjQGIZeB1QQjYOhK8g6PRI1nFRa0nxr57/sAg607YQBnIu/+
         CqvIf7dxzfuc+5+qv9LbFTQQqnzwAAfkoAs27yqJSqGGChM7+Ru2ozYQs+9lMdR1yFCD
         0zWjnHvN1F/dBhCxNBWKn+tif4ZeudHJ2UC/abX3SgURY4pCdIWbWEkBnmUy0Pdn5bqN
         v7YtSjqzgFRYNAPlM8nU3n52xCOCT13lVVb0/blAZfwpSlWyYOV6s2qAFm2NMMWjbR75
         gGef67Ci3xWDhKUYcBOeKSaWii7AIFWemdFhmBZtBX22HbRi0G08qhf++aZCxYojazfL
         wofg==
X-Forwarded-Encrypted: i=1; AJvYcCVJi5hUwBaFen5UYhcCSuvpof7bkTE+p1Bt3INNObLI4iJEt/+/nPgi9xyarsI62i6xyhi/O6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDDDFs+4ekHub2Px/lhTjfnJhg81A/N4xcswPF7hrE07opC3f
	Q+ak5YL/rpz7j+dzvJRPYZifJ/Sax2iany2OM82pF6cOV9zkDmHOJhxQ2YaN2c0Q4g==
X-Gm-Gg: AZuq6aL41/baNJsUTOgv9YjxcHGcI8C4HLK85p+G5C47zgmd3E8vFngS6i1sMPmb8Tw
	FKLhvGjXJ5qg5F0luD92dvkkboSgu2G7IkqdZ4++XuCP4LhufE7inlJ+RTh32BKGySKx++C2Dn3
	KXRi9scSPJXz6qvyMpjptytkll/P1fsOgR07A5GtE5SbhPldeBm/Piy6aWs1UiciyUeatkRCzyX
	gnZVzJECEOkOFCZ16aqW0cgSIX2OoybwPk6CYvUyP9aWHHqZ87rcJH4BzMt42bjufInlAWW4GYO
	Lb07HmNKpdeQxQsMfpTlNhdz+MFQbJ0SLR+MJdKs1iDpT2r1WVRE/4MPKRM9TCcZzhZMqzvsg8j
	HMJ2mIr/IYSo4Fw3BC09jthswXsZVwuXgbyUSnlfgbNvxv+k2EJnLSxBZeplvBo/CPHYNIwNE0d
	BmQwwnZxtCE4CsejbAYOvNaklvwppTPWBcnJ7iTyX0l5I8q80v8vXWHvU=
X-Received: by 2002:a05:7022:6197:b0:119:e56c:18a5 with SMTP id a92af1059eb24-1248ebef6ddmr2380953c88.13.1769456938866;
        Mon, 26 Jan 2026 11:48:58 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:58 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
Date: Mon, 26 Jan 2026 11:48:25 -0800
Message-ID: <20260126194826.236075-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194826.236075-1-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253585-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: B523D8CC5C
X-Rspamd-Action: no action

RFC8200 highly recommends that different Extension Headers be send in
a prescibed order and all Extension Header types occur at most once
in a packet with the exception of Destination Options that may
occur twice. This patch enforces the ordering be folowed in received
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

Each Extension Header may be present only once in a packet.

net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
enforcement of xtension Header order. If it is set to zero then
Extension Header order and number of occurences is not checked
in receive processeing (except for Hop-by-Hop Options that
must be the first Extension Header and can only occur once in
a packet.

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
index 6925cfad94d2..4ab94c8cddb9 100644
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
index 168ec07e31cc..ab921c0a94af 100644
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
+	    !(ext_hdrs | IPV6_EXT_HDR_ORDER_DEST))
+		return ext_hdrs;
+
+	/* We have Destination Options before the Routing Header. Set
+	 * the mask of recived extension headers to reflect that. We promote
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


