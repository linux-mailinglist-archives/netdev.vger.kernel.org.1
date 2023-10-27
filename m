Return-Path: <netdev+bounces-44669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599637D90E1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745D71C20371
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2FF13ACD;
	Fri, 27 Oct 2023 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A716125CB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:16:43 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BAC1AA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:16:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D5D24207D5;
	Fri, 27 Oct 2023 10:16:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1l_ex9iYdgi; Fri, 27 Oct 2023 10:16:37 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2EFF8205ED;
	Fri, 27 Oct 2023 10:16:37 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 2C27A80004A;
	Fri, 27 Oct 2023 10:16:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 27 Oct 2023 10:16:37 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 10:16:36 +0200
Date: Fri, 27 Oct 2023 10:16:29 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Antony Antony
	<antony.antony@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	<devel@linux-ipsec.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <0cde5ae80fd682dba455cb8b18b46fc36ed69422.1698394516.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This commit aligns with RFC 4301, Section 6, and addresses the
requirement to forward unauthenticated ICMP error messages that do not
match any xfrm policies. It utilizes the ICMP payload as an skb and
performs a reverse lookup. If a policy match is found, forward
the packet.

The ICMP payload typically contains a partial IP packet that is likely
responsible for the error message.

The following error types will be forwarded:
- IPv4 ICMP error types: ICMP_DEST_UNREACH & ICMP_TIME_EXCEEDED
- IPv6 ICMPv6 error types: ICMPV6_DEST_UNREACH, ICMPV6_PKT_TOOBIG,
			   ICMPV6_TIME_EXCEED

To implement this feature, a reverse lookup has been added to the xfrm
forward path, making use of the ICMP payload as the skb.

To enable this functionality from user space, the XFRM_POLICY_ICMP flag
should be added to the outgoing and forward policies, and the
XFRM_STATE_ICMP flag should be set on incoming states.

e.g.
ip xfrm policy add flag icmp tmpl

ip xfrm policy
src 192.0.2.0/24 dst 192.0.1.0/25
	dir out priority 2084302 ptype main flag icmp

ip xfrm state add ...flag icmp

ip xfrm state
root@west:~#ip x s
src 192.1.2.23 dst 192.1.2.45
	proto esp spi 0xa7b76872 reqid 16389 mode tunnel
	replay-window 32 flag icmp af-unspec

Changes since v1:
- Move IPv6 variable declaration inside IS_ENABLED(CONFIG_IPV6)

Changes since RFC:
- Fix calculation of ICMPv6 header length

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_policy.c | 148 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6aea8b2f45e0..0ab6989d5b20 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -29,6 +29,7 @@
 #include <linux/audit.h>
 #include <linux/rhashtable.h>
 #include <linux/if_tunnel.h>
+#include <linux/icmp.h>
 #include <net/dst.h>
 #include <net/flow.h>
 #include <net/inet_ecn.h>
@@ -3484,6 +3485,134 @@ static inline int secpath_has_nontransport(const struct sec_path *sp, int k, int
 	return 0;
 }
 
+static bool icmp_err_packet(const struct flowi *fl, unsigned short family)
+{
+	const struct flowi4 *fl4 = &fl->u.ip4;
+
+	if (family == AF_INET &&
+	    fl4->flowi4_proto == IPPROTO_ICMP &&
+	    (fl4->fl4_icmp_type == ICMP_DEST_UNREACH ||
+	     fl4->fl4_icmp_type == ICMP_TIME_EXCEEDED))
+		return true;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (family == AF_INET6) {
+		const struct flowi6 *fl6 = &fl->u.ip6;
+
+		if(fl6->flowi6_proto == IPPROTO_ICMPV6 &&
+		   (fl6->fl6_icmp_type == ICMPV6_DEST_UNREACH ||
+		    fl6->fl6_icmp_type == ICMPV6_PKT_TOOBIG ||
+		    fl6->fl6_icmp_type == ICMPV6_TIME_EXCEED))
+			return true;
+	}
+#endif
+	return false;
+}
+
+static struct sk_buff *xfrm_icmp_flow_decode(struct sk_buff *skb,
+					     unsigned short family,
+					     struct flowi *fl,
+					     struct flowi *fl1)
+{
+	struct net *net = dev_net(skb->dev);
+	struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
+	int hl = family == AF_INET ? (sizeof(struct iphdr) +  sizeof(struct icmphdr)) :
+		 (sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));
+	skb_reset_network_header(newskb);
+
+	if (!pskb_pull(newskb, hl))
+		return NULL;
+	skb_reset_network_header(newskb);
+
+	if (xfrm_decode_session_reverse(net, newskb, fl1, family) < 0) {
+		kfree_skb(newskb);
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
+		return NULL;
+	}
+
+	fl1->flowi_oif = fl->flowi_oif;
+	fl1->flowi_mark = fl->flowi_mark;
+	fl1->flowi_tos = fl->flowi_tos;
+	nf_nat_decode_session(newskb, fl1, family);
+
+	return newskb;
+}
+
+static bool xfrm_sa_icmp_flow(struct sk_buff *skb,
+			      unsigned short family, const struct xfrm_selector *sel,
+			      struct flowi *fl)
+{
+	bool ret = false;
+
+	if (icmp_err_packet(fl, family)) {
+		struct flowi fl1;
+		struct sk_buff *newskb = xfrm_icmp_flow_decode(skb, family, fl, &fl1);
+
+		if (!newskb)
+			return ret;
+
+		ret = xfrm_selector_match(sel, &fl1, family);
+		kfree_skb(newskb);
+	}
+
+	return ret;
+}
+
+static inline struct
+xfrm_policy *xfrm_in_fwd_icmp(struct sk_buff *skb,
+			      struct flowi *fl, unsigned short family,
+			      u32 if_id)
+{
+	struct xfrm_policy *pol = NULL;
+
+	if (icmp_err_packet(fl, family)) {
+		struct flowi fl1;
+		struct net *net = dev_net(skb->dev);
+		struct sk_buff *newskb = xfrm_icmp_flow_decode(skb, family, fl, &fl1);
+
+		if (!newskb)
+			return pol;
+		pol = xfrm_policy_lookup(net, &fl1, family, XFRM_POLICY_FWD, if_id);
+
+		kfree_skb(newskb);
+	}
+
+	return pol;
+}
+
+static inline struct
+dst_entry *xfrm_out_fwd_icmp(struct sk_buff *skb, struct flowi *fl,
+			     unsigned short family, struct dst_entry *dst)
+{
+	if (icmp_err_packet(fl, family)) {
+		struct net *net = dev_net(skb->dev);
+		struct dst_entry *dst2;
+		struct flowi fl1;
+		struct sk_buff *newskb = xfrm_icmp_flow_decode(skb, family, fl, &fl1);
+
+		if (!newskb)
+			return dst;
+
+		dst_hold(dst);
+
+		dst2 = xfrm_lookup(net, dst, &fl1, NULL, (XFRM_LOOKUP_QUEUE | XFRM_LOOKUP_ICMP));
+
+		kfree_skb(newskb);
+
+		if (IS_ERR(dst2))
+			return dst;
+
+		if (dst2->xfrm) {
+			dst_release(dst);
+			dst = dst2;
+		} else {
+			dst_release(dst2);
+		}
+	}
+
+	return dst;
+}
+
 int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			unsigned short family)
 {
@@ -3530,9 +3659,17 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 
 		for (i = sp->len - 1; i >= 0; i--) {
 			struct xfrm_state *x = sp->xvec[i];
+			int ret = 0;
+
 			if (!xfrm_selector_match(&x->sel, &fl, family)) {
-				XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMISMATCH);
-				return 0;
+				ret = true;
+				if (x->props.flags & XFRM_STATE_ICMP &&
+				    xfrm_sa_icmp_flow(skb, family, &x->sel, &fl))
+					ret = false;
+				if (ret) {
+					XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMISMATCH);
+					return 0;
+				}
 			}
 		}
 	}
@@ -3555,6 +3692,9 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		return 0;
 	}
 
+	if (!pol && dir == XFRM_POLICY_FWD)
+		pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
+
 	if (!pol) {
 		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
@@ -3688,6 +3828,10 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 		res = 0;
 		dst = NULL;
 	}
+
+	if (dst && !dst->xfrm)
+		dst = xfrm_out_fwd_icmp(skb, &fl, family, dst);
+
 	skb_dst_set(skb, dst);
 	return res;
 }
-- 
2.30.2


