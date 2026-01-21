Return-Path: <netdev+bounces-252065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LJqGWtKcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7225E4F0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F6665127
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC71423A7B;
	Wed, 21 Jan 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="drQBLWru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AD42B72F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032204; cv=none; b=GXg5ygPTgrXmMlx/VUg2e5a28LQwaqSE5T+aHZhn/19fEbwKB2k6p7l+0u5yi7FbWTbkwATh8qDSgGk/Z7LjEUWjRmtybzJJiBq/CGiMfyyQgQjt2fJeHVwpDz8AMtbNDMdCuZg7zOoiILererFav0d0JwORSVnSspRR/jxLGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032204; c=relaxed/simple;
	bh=YSoHgYN2Ubt3TLHU8nDX8QGRiVpootSQGJ56wmtLrmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOgSbfc7Bh5QcloZezmSekaB07ZySmmowk/G/vkWdRZLpPSsqrIBAoG5H/BjNVmNEPsnTQaPXM5PYPiBrkvNRg7wS5E0fMO0qHYoeVYdwg+M5xbdHVlCSfVyWCgYrM7daRrL+DeyLy0znCZziZkLrOf94lGwM9rEoY5TfEOh1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=drQBLWru; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so326201eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032202; x=1769637002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seaaLWjSDt+kVMhFXr+rPekxa08Ox+V9HjZdpddaj7c=;
        b=drQBLWrubn/0K05mzHZlvbzSNBY3StUaG34PCDXpetoJqnTheIy7rgwXKyAjX5BM0n
         00fQv3z2qf2NARIHv2KZfoErGqzqkop5l+AxJmMhCi/0/qIOVzeo3OdzOvx4kHQh6ZPA
         Zm9+YiKMf0I7MHQq2HfqsT57Vkn/CnSaLVAbK/syyV2aVnGwZhtCKdH8F4trUNj5Bcyn
         vTvy6phguLpXr9HbR4ezhHMw7meMwxbd1Kk0anlKyTwAmcaOkBqAYaMfs8fL487SdD0+
         94ChHnEJxmzzkzlb/ooFA4sL/l/mEfnbW193+DdgDZ6WSKmKg7alLySZCeAtjnB99VIp
         6mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032202; x=1769637002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seaaLWjSDt+kVMhFXr+rPekxa08Ox+V9HjZdpddaj7c=;
        b=pbtjiHH8KMAnpvQpJaEjaBXg3cnx1MAApaqr29ryJF0Fjuc/12/yU+7p0J8r8U2kgJ
         z7dE2qSkWWvH9cfqLnXJQiqiY7NGUMJ4jPHG+arkWx8imBscU1lRl9PTouRvlnLZHlqC
         PA548VTsP4Hjb07Aa3PI5Ua9Ij+PpG3GFRhcqiG68sWWV+v1DuTjA8797LmY2kJd6LqK
         O/OngObcrl1NSe+WSRzRKYrd4B2Jh2q0j4J7dvE3ZlWNAfKsVDywI8v93zb0PDODZo5d
         axYf5CzhWr6e1YkPXn3ZGfIgGYC7orDo4Zv6Rn3K8Am27QeQe8Z1V7iyOcTgOUtdckp0
         YMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSawcyODLS1Zb3G4XGxxMYQ9tWk62l6AhGg0St33WIUbBxTyePT2lk/et9VTt/YXJk0wzV54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywargu2E1Zhk9X9InKdLG8bgXuDF0HV2XnFhLyTdeYaVGmqVQf9
	wRr5b5zk91PnOFYyfEcqT1s5b/w17CYo/pak73r81JZ18KjSEYZHdaCkr7CXHUGkS03ud0d4nap
	r004=
X-Gm-Gg: AZuq6aI8toLscC8lmcNeNZRsX18DjZ1+6Eu8sfV9XNHfgqvXlA3QybQeL4pCedpMNfP
	kz2poVQUdVjnMw+OoWdIxd77c3jq97j/YISIlnwRHekWi9m6cGZnYiZz0Pw7IXjsEeefTxsUCBk
	o75TJeyxyWcqqrFEGiYxkJmpkHKMFwMw5Tw0s2+YUvlPWjbV6SGVtYw5B5/sDDUu6xzpRwbS08t
	z9POtY3q2eUuog9iAgNPROeheEVpEJeIyw4aMJxy9mgra1vQlpVsXlNzPo12NnyMAPwF3DHejNn
	kSsaegYyb5LHc97vdLIbUteeNCTvLKE1cKQj2HWPitZunqqUzNoHdHm7SKQJ1CVKUAecWmFig0s
	72jTD/SpNuE5ShKyW9gRAdatu/xVn00IFwQBdw5aXF6FHA+sawNFLIJKwa6FJP/SVe2dGmOY3wM
	aYtXPne/ZG4lLHGz88urd9ZW25oDHhhv11u01hOnIPbChJIJ0dbYtweb6F
X-Received: by 2002:a05:7300:1496:b0:2ae:601f:f4f7 with SMTP id 5a478bee46e88-2b6fd7e54bfmr3648069eec.40.1769032200911;
        Wed, 21 Jan 2026 13:50:00 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:50:00 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 6/7] ipv6: Enforce Extension Header ordering
Date: Wed, 21 Jan 2026 13:49:24 -0800
Message-ID: <20260121214925.112604-7-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[herbertland.com,reject];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252065-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CD7225E4F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC8200 highly recommends that different Extension Headers be send in
a prescibed order and all Extension Header types occur at most once
in a packet with the expection of Destination Options that may
occur twice. This patch enforces the ordering be folowed in received
packets. It also disregrards Destination Options before the Routing
Header as those are unused in deployment asnd there is a proposal
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
enforcement of xtension Header order. If it is set to zero then
Extension Header order and number of occurences is not checked
in receive processeing (except for Hop-by-Hop Options that
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


