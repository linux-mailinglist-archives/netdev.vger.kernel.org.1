Return-Path: <netdev+bounces-267807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ4/Ow2htWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:55:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064428E461
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5A723088ED5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA233F38B;
	Sat, 14 Mar 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="K0lDNFiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBF33CEA2
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510714; cv=none; b=JNj19tXb7NFWb3C6Mc+N6Q/WiCwPAyCzJ2TqJW4Z/PMYMx/VLBdH1UnqLWE0PvLODCnpIVsDk8WpaxnBu4DJ64PSKC2bXPqjcpurROx0l/D94acDUvV6YME6pKeUqmStIB+yHZb+Uka1tYuV0u2RhlESEVMA+veyj8P2XBWiNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510714; c=relaxed/simple;
	bh=frWgSWG27yonhkZnYVR7Cyo3zFu3CXbaE5aovhFkMh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ly9b91d7RQsFWxeORwZigVg7LnMAu3mN5n5yXspNaadL2H03/7LL8QY/48cvAQuxg5uY9Rnv8Unx35/Q7b5gyEECGQ91ztNXhsdoi4Wzp270XKC9IYULY1kWxtjl2P+/aJdCx1+JjJM5w6jVzlcpP+f4CKIwYJLmK0Zxtpg1gFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=K0lDNFiD; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128ef4dddbfso1095138c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510713; x=1774115513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIKavAffZ1+gxX0cCOwrEUAoSgWiMZHyrxQLW6QzRoY=;
        b=K0lDNFiDDyBecTh9b9ZG7guSYx7CP9yz/5e99YDiiSUtiYXs9GcXdWaxrGi4Gg/lHh
         z+I2THAP8JlFX3CQMNanLBYFTJ4xxHB2fpKM+h+6h1FyyU1Y+P9c8jUTXQq5CAlcr/zR
         XA8z3XuEiqj139DR9xI1u6qDyeqLR7amowsR5I6QtqRWt5pnE4eEmnuUZEOeMgySfYd2
         PmIhZKGteazuDzmrqc9OFQ30zUUDuFQqmg+y9m3htnNBYidqY5s9ZZu8FexM9Ht1aS1j
         qXFajQWUE9tG16qsH2Y31GaSff7/JzqIHGQDiCJ8OeSfRIowxSQSdYjsozqhgiVyO5ht
         4+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510713; x=1774115513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIKavAffZ1+gxX0cCOwrEUAoSgWiMZHyrxQLW6QzRoY=;
        b=oUvMTa/svqACwpIjfu4yZuI1jL3//APoacNtMdtfKhpWm5YCrWnu5XU1D3BAoWKwGV
         e2yBlmZb7un6QVrvjajiqVLUzzofgMbAMnq5Ta+ihw/jpZut3RDGEcmxh6G48dQPkRqL
         EuEqR7W2NbtsM/BhMTaAEs9dmfRmJgtfg+kUDeXXAZzqNGmptDd/RERiZano1IE0bmj3
         zlRCMzuAVwFA2T5f88RXiCUaN1theiIMt7ozli4joLHsJDj2AFaQ55+E4wueZ5FTGim6
         EwjL8a5rqiTDnzKAVfLEiwt5DVF7yG3Qti2Zax4lLVtKF/EFnmH2Vy+PIUoxJaYu6dhV
         7RnA==
X-Forwarded-Encrypted: i=1; AJvYcCVREe36EPNOUp/rNrD65FjtWmaeaD/WkBQDgg0c2l5lJ3IEtPhnvOxaBzjxDAkDzJlod1hCzEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Fj78fDqhKIhkK2aQXHH/FSG56M2puBS3SZMEGoedzEy2su1C
	2wEpBqypa28aLCjXf//9rNhINhXhU6ijexrNjtDC5BmQ9l6oP+SWXBDOcfTmynhAwg==
X-Gm-Gg: ATEYQzyOIvG4JW7cHVzi69Zi7luGPt1WZPlWF+jocv4NI6yb64OGUHbrFQltT+g156c
	U6SQhbD0XxJQp2ZA46+m3F/SBgqf+wHSvodKS8cqkVJ0vZDWfdEniGpHBjr3zRIaH9EXbxS4iR4
	CGjuq12gOXjrPAQtD6iOqo0fkKKVBCWrgE51JCFErL5b68ZnuCYB1TsbbBdJ94pKB5ZPUvUuC7J
	SK+s82viwh51Ppfh89AW651G1s63mlYf/kDCE7iEV8jfd06vUVRVeX7iI8tSrbd19Cs7zF7DedI
	I/NNT61CFzsk6TamKOAEMFvTYUL5domC1ALov18zvR4uRYZJGT5QcnQ5aP/xBEUHAGLyadO8XrT
	2HY2FxF+V9E8nWReAFexN4kfRiU0KsNRTrO+T1sRDmNldELGK0TUwHFzOENAjtdvVpEcfjy1gWX
	mfUkYA0anmyXgB1Xu8RATUX4Dn6xeQXQp59tg57jEUxHegvtQYcoUUjmJP9XqftBzlmArNlQ==
X-Received: by 2002:a05:7022:6292:b0:119:e569:f874 with SMTP id a92af1059eb24-128f3be8d42mr2815301c88.17.1773510712486;
        Sat, 14 Mar 2026 10:51:52 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:52 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v9 06/10] ipv6: Enforce Extension Header ordering
Date: Sat, 14 Mar 2026 10:51:20 -0700
Message-ID: <20260314175124.47010-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267807-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: 7064428E461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 499e4288170f..af14cfa99c01 100644
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
index eb9fff86baa1..c5387c119570 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -953,6 +953,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
+	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
 	atomic_set(&net->ipv6.fib6_sernum, 1);
 
 	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index e61d97621108..a66a8339dc8d 100644
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
index 967b07aeb683..1b22bac9a164 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -395,6 +395,27 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
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
@@ -406,6 +427,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
 	unsigned int nhoff;
+	u32 ext_hdrs = 0;
 	SKB_DR(reason);
 	bool raw;
 
@@ -467,6 +489,26 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
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
index 11f9144bebbe..e17876bf945a 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -420,6 +420,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
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


