Return-Path: <netdev+bounces-284011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPDoKjvr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A74C2C7C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D725B302EABB
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913943E6DD6;
	Mon,  4 May 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="M3re+V2q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C33E6DE7
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920782; cv=none; b=rd+PgMa11H2DLtCVNTxxvPI9fp1EaIykZ2ty1p0WJGVCPPiRpvzlft0NDqfch5ZeU8mPSrSOEUUaTRbq4nCU/zWeBvbNYJvo8GbgovDthZGKtgNrVUhLkfJvG6Wm5GNY1k1iHdejhfVHgDvjd2L2hXqWTmVzf3nr64a1rTF9nTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920782; c=relaxed/simple;
	bh=L3rJB9sMjx/KiPm+4VHa6kS8iaF30HXh/25f63RXI/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3nZWmWINEbaIDVrR6WllQhnP35P73Xk5NfbacbckurFi7Uroac7HdroicZcOvQtUIA+hyahHVtU2fL/JB/162YXDUsWTp2xV6yCreGmVsWIoekbght7gE8FhJDA+wtMspX8zgSoRDIxuSqefkLQJhfQDgVhpraJfc+kWj3k5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=M3re+V2q; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so3762121eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920780; x=1778525580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ekStu6DX6aZVaTfEWW3e0R+TUv/MBB5Ie/AhvnsMSc=;
        b=M3re+V2qO44Al+RcxDyK6AEXbJkOdzyu7l4BbfmJwpsGhIfuXVL/kivc898aU1HtoM
         MOkPPoY6OEcBO8JLs6LLYxbEkVAEeacCMHL22yEFpVJsBJsSfOaeSPYnzThetDSdT1/2
         zo+cAgheWxOXoZWwweTUzuO21G2OQThnJ7ecNjaUCefzDeFTG3BCJmTwXtdTae3czbwS
         jxf3NsjAuh8rF1uaVH9t0+XrWW2Ct4RbP/+HuLgxy6Y/VswxdPJORUrLNWQXBzxYUFAo
         XlLNzzesOBcQUTLzNbfST8U8Y/1WC3DVV3Lk5Q5N/IgWb7NxZOGA+mh0Wr7IyLwmQ1Nm
         3F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920780; x=1778525580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ekStu6DX6aZVaTfEWW3e0R+TUv/MBB5Ie/AhvnsMSc=;
        b=HCL4YdXdfhG7Dral07T6F6+xJKuL2bMzWFlsxmgw4cN9rIbTKQWSxt3V/xOH5zKCsw
         JOPBT6gxR7g5M4V1TSlWZeIbxdQGBNd42kp/snGP7eaHGmyi3Es39kbP5rEW8jQdKW0c
         SJNPgfz1uXpVZ40bRtPnFMJzs1Y8pTFzYQvdq0ViMCUPSfMY2JETVrA4IQz122anKu00
         1XXBGdBi2Kcoi7sBmplFdLedI9qWV5eyu8RmPSAEKXmWPfiLKkpJex7+ppuj0eZwCG/n
         HheFrS4rgD+2wIs3UdDpd/A0kevISnm6orxDASn5vBU4K9Z10b1JgbbqqzA/o801CEM/
         KuPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iODXg+N4kg+M/pxRsCz8QCg+Pul0NWrnVsunHuFwV3pi5TzOr1HI5BRF1oYBJhoJamBWh+y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRShQobkrYQ3w784yXIcoc6Mxba0qbPIDxWxUlpT9HI1WZRma
	zpQfMkRBt8ulz15mbCmMYDnTsBWJPvgWd7973xmABglVWiP7G2T7266uTo2x5TIGkQ==
X-Gm-Gg: AeBDiesvoGmEAZlOOdfpKOUW0IQBE0vTyuSFLfzwGPaxEGwm92w12ESWFcnJziUzb81
	/ep3FNelqiHq+844dkWVtbSSdrJH+vu+WST6JUN5eWYjASZzQQ/hYJf1Z0xTF/+j+tsB8F9S7UG
	GZUbnAUtzu5Sq1gH1s4nHtw3oFZyNwJKuAfRas1cr9hBhWdaucavRAF9ZHrJ7vi8+iV3yWXgj3G
	KcqT+Vn62IdTS1OrUwqZ77iOz8jp7YHAG+6IL/XKS0IPJTAUvOSGY7K+1EVrTZ/zde2zXrNiJcQ
	EBsnKWf1ibdqX+IRDQHw4kAMKCwOuJ/JAju+hVoQ1kZacwXg8cjW+3ZFoBpfIgVCgwMCOiuttM+
	uCjUTYTAqZytD8HnKJ2/KUkOrY8jbOGcSE2ZbHUEvKtnW7000qx2sX3pQaWaF9DG/TgzgaVtlam
	1ebObfGsKoVCawb/5GIUsJKtyiPXeNCl+3Jp1fF5XbY7U0Gz4tgNSV7aV7UzrDL3KoPX0d3GGq
X-Received: by 2002:a05:7300:fd0a:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-2efb7dc9c89mr5510098eec.3.1777920780095;
        Mon, 04 May 2026 11:53:00 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:59 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v10 06/10] ipv6: Enforce Extension Header ordering
Date: Mon,  4 May 2026 11:51:18 -0700
Message-ID: <20260504185122.50642-7-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 449A74C2C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284011-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

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
index 0a88b376141d..32f68baeb554 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -948,6 +948,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
+	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
 	atomic_set(&net->ipv6.fib6_sernum, 1);
 
 	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index b50f4b3bf59d..ca912e22abf1 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -852,11 +852,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
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


