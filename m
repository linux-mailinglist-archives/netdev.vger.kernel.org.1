Return-Path: <netdev+bounces-256048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH/2HqRGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:51:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8828D3264
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8083014967
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C01C8626;
	Tue,  3 Feb 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="cnSpm/1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E06217F55
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079771; cv=none; b=qeulmfs/vtZ8UshS+cw8gOpdoa+TvlrNgN97t5xGR78kIktiSeRst3wlHY4byznxeanVPprTrjtvD3tZCpofRlK1lL7cvq0RAOPbml07jOHi9aUkmBJYJxx8fHockIfkz/b0HMmvlW3OLJ+J0AXpmAKQYh0X+2Yr/ehSifguVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079771; c=relaxed/simple;
	bh=dbBfth654D8uFzqbFulF69Z+J6UxfT6O57CazYOtyqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYPJUnsR0LQ4yrqGp4nHP+Yf6gwuCWgwpljS93dqrAsG1aWW4lMRsSpCtVLX0wZCJM9XvNGJzwS5arkc+SNSYeHLc5RIi5C+xe8t7r+VKLTQkZ5Nfsm1Bzb1ZjnWQC4SP3/EeKH+wkU88UTrnXYeGIAdiHQcsI6j8Yv6vmMo5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=cnSpm/1g; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7544889eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079769; x=1770684569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndB7+AGBKGtjyMQUhXmFbtuABmf2BOvto8caMQLC0N4=;
        b=cnSpm/1gSECPE2RXhUxxhokE2+FvOHseVGZL5bbXve1NSv2Anf624Nyqlg2cKl/59y
         QIcPHi+lx5aJ1ZBmN1ohSEPc8qT2tmps9gBRkNxPrQhJTggpo9AwSGxRi5EUELbu5lPj
         1pWO1NHy4+CBmC1PwHKNfGIahjb57igL6LIzD9s1IEhzyWkteeCbh2MNG3JWJCglkXYM
         j9FZk5Le0t41a5iRWITFbpCEf1X79Eds7CFLaDPKO7Fbzjci3ZyOFU0wNVqnY4JcBBNn
         ZITThVYbR06icvH8hE0zlIPiNRrb0rMGE9qLRIaR5YZZbepB1BFwB4fjrVfv2CanQ46F
         1x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079769; x=1770684569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndB7+AGBKGtjyMQUhXmFbtuABmf2BOvto8caMQLC0N4=;
        b=vCa7USR6TuovePaUMRFOv//GdEPZn8o9dKNj4Ctre5+NZ2L/Uo7toPCEtMqNkz34Ij
         wP619gyPPw5MUnnE5eprgaRUgX14atWN3+o045l/YFezRYQDJ+nMkOKFi4PJ1Gkod/MJ
         kwNNKiwTliJIbRi166i9nrDZup7HOzsWrWkk3pmryn4BU4Op8lqiBcK9VsGiD8TlNiKX
         HVBtpwoZFFLCOynsekUpj9XzocX3HZuIIrXgoM8AN9JwdWQ1vuD1ZuoD1qetxTA3GYel
         aPVQpcnh1cv5+1vfXzP+jw8CW8qxdHQvmPxdMwuuJXwiKG5fPK5Dw+3+P5yYPyLXMW2t
         M6cA==
X-Forwarded-Encrypted: i=1; AJvYcCWyJ8ppAHm7I2hS/RtXXfmFmzgJ+ga1GEPnrE9aabumroUWXb7BdVb9gu3ChG7BiA4FEuVxHco=@vger.kernel.org
X-Gm-Message-State: AOJu0YykY5zhLeH3Qo+LL0t+hxK156huzoHiLYOBGt2b94Z794rQEWvh
	SjcGfJY1I2rwaAjz9anbkdskuyOEng0wNC6ji2ht8kRAVO4slEzjMRSFITHyPpPn9A==
X-Gm-Gg: AZuq6aLTMqCIsEPnnhXqzAfqauUydyuZngFjVIsb6FyCQ5W3ETkdnh0qVBDouTch9rN
	ImhtTDMpm0FGvDHDXFO25AiAvrsSOulnJ07S5mPvrVp68C2BvNNFuMdnIjey+EXyXhHsqz7z2n+
	caUYBqGBzgo0RSGI0KqFyaIWagvxk1yJIcG2RUAARcyYh7Yvc3FIrUJ/3A9Az7mGE/2LxWOMLYL
	IphZ6+ebHqsAq9OXQJhPipRMaWIHnDsTRlT3/5RGCL/4kmDrKfqTJKqkxO/PT+kMnNbuafG3kQf
	s4qYJxVl3BP2hKkYVpIaKzaqdzFLifBJ3cpjcs67bLgY9b1iW0j1n6jNIblVzHP/ai7EiRVJW9j
	5lVa7lx7HY17hR5PYGIa54POQ76GQbuqOuQtaPshGfAdK0DHj9PFQrByZRSkGOJbv6PZK5hOmR3
	0FInXJ7+TIUy3ioJsueZYJ+fFCdIdCDidIpXFw+L4x7vuDQVVYljD+qBNr
X-Received: by 2002:a05:7301:3d15:b0:2ae:5a9f:d98c with SMTP id 5a478bee46e88-2b7c89281e2mr4023928eec.33.1770079768504;
        Mon, 02 Feb 2026 16:49:28 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:28 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 06/10] ipv6: Enforce Extension Header ordering
Date: Mon,  2 Feb 2026 16:48:49 -0800
Message-ID: <20260203004853.94438-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256048-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8828D3264
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
index 85f1b65d4c98..b3a66110f03d 100644
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


