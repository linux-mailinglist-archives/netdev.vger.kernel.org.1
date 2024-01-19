Return-Path: <netdev+bounces-64338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915BE8328C1
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C102855CA
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D113C6BF;
	Fri, 19 Jan 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XqhFcORV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198054CB21
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663693; cv=none; b=MLZ34wkOuiEXnEWQeVEXDHXMN/mU8JSVRjSw/No8OcAB+v8kTHt7LORp45D5DUotbWX42aWJNBS1OFHeG/XRYqIGtzJZdfLJsh5G6AXnYPt6h2d1kUCJbA92AWXALP+2aHrB65toaVD+J6S6yszjmEQA4CPD8RCFt2gFTgE5xSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663693; c=relaxed/simple;
	bh=9fXz7gcy3E3RK44jSOYWo0Q8r1kw3UMTZhB2Ma8XriE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhuGleKwcM0MsVkrb8USWOMsasNk362ZfzTKZanFUUWrq0Jja1iR75xzK8WzsfbUMFnw7GmE/aZeekQ/drOA7d2jXFZh2GD1MTD514YJcaxiwCwZnhmpnYGGaPiviYy+iV61QAZ5Xl9J2tdIINfQbsegtZyL6zWyl3dpFTBuGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XqhFcORV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E815A205E3;
	Fri, 19 Jan 2024 12:28:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5JRUN9Fax3zQ; Fri, 19 Jan 2024 12:28:01 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2864920519;
	Fri, 19 Jan 2024 12:28:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2864920519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1705663681;
	bh=vQ1LHoVsWA05iZQFwdfuVvb9T4uYFK0iFhWMRFPVvTY=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=XqhFcORVX0JO8sfCxyDc61cFuGuXcBAiKeUBAIdfjJ6eRh4V5zOyJlkhlebMtj0t6
	 +ZCgCFqfU/ZyHiE/nEXRuuEikxmO8i7JPt/rV8a/SsV/tCN2x/MsZE6fd2Q13Gsfwd
	 QLbTRIv5W2iOxvAnjGfyb4kxefMMytzYAdogVkI1K35RUjXuyyPqzFW/JPz+eFsheB
	 /WqedqOMJnlytbl/iyQXpYLNC78k/PtkkFEIhEvzNwP/KzaKUTaQyaGHn4VY8UPJ8G
	 piQwJF3hGd6hxWbKC8djbrFBrv8pC07HZKb8VUKKU826kKSjHqFpwSQbAueo/xvR8R
	 qICmrAWv2+AJg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 1C9C880004A;
	Fri, 19 Jan 2024 12:28:01 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 12:28:00 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 12:28:00 +0100
Date: Fri, 19 Jan 2024 12:27:42 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Antony Antony
	<antony.antony@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	<devel@linux-ipsec.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH v6 ipsec-next] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <1199c5a30dd3f73ac02b0ac00775354304b1e692.1705663529.git.antony.antony@secunet.com>
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

Changes since v5:
- fix return values bool->int, feedback from Steffen

Changes since v4:
- split the series to only ICMP erorr forwarding

Changes since v3: no code chage
 - add missing white spaces detected by checkpatch.pl

Changes since v2: reviewed by Steffen Klassert
 - user consume_skb instead of kfree_skb for the inner skb
 - fixed newskb leaks in error paths
 - free the newskb once inner flow is decoded with change due to
   commit 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
 - if xfrm_decode_session_reverse() on inner payload fails ignore.
   do not increment error counter

Changes since v1:
- Move IPv6 variable declaration inside IS_ENABLED(CONFIG_IPV6)

Changes since RFC:
- Fix calculation of ICMPv6 header length

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_policy.c | 142 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 1b7e75159727..b4850a8f14ad 100644
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
@@ -3503,6 +3504,128 @@ static inline int secpath_has_nontransport(const struct sec_path *sp, int k, int
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
+		if (fl6->flowi6_proto == IPPROTO_ICMPV6 &&
+		    (fl6->fl6_icmp_type == ICMPV6_DEST_UNREACH ||
+		    fl6->fl6_icmp_type == ICMPV6_PKT_TOOBIG ||
+		    fl6->fl6_icmp_type == ICMPV6_TIME_EXCEED))
+			return true;
+	}
+#endif
+	return false;
+}
+
+static bool xfrm_icmp_flow_decode(struct sk_buff *skb, unsigned short family,
+				  const struct flowi *fl, struct flowi *fl1)
+{
+	bool ret = true;
+	struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
+	int hl = family == AF_INET ? (sizeof(struct iphdr) +  sizeof(struct icmphdr)) :
+		 (sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));
+
+	if (!newskb)
+		return true;
+
+	if (!pskb_pull(newskb, hl))
+		goto out;
+
+	skb_reset_network_header(newskb);
+
+	if (xfrm_decode_session_reverse(dev_net(skb->dev), newskb, fl1, family) < 0)
+		goto out;
+
+	fl1->flowi_oif = fl->flowi_oif;
+	fl1->flowi_mark = fl->flowi_mark;
+	fl1->flowi_tos = fl->flowi_tos;
+	nf_nat_decode_session(newskb, fl1, family);
+	ret = false;
+
+out:
+	consume_skb(newskb);
+	return ret;
+}
+
+static bool xfrm_selector_inner_icmp_match(struct sk_buff *skb, unsigned short family,
+					   const struct xfrm_selector *sel,
+					   const struct flowi *fl)
+{
+	bool ret = false;
+
+	if (icmp_err_packet(fl, family)) {
+		struct flowi fl1;
+
+		if (xfrm_icmp_flow_decode(skb, family, fl, &fl1))
+			return ret;
+
+		ret = xfrm_selector_match(sel, &fl1, family);
+	}
+
+	return ret;
+}
+
+static inline struct
+xfrm_policy *xfrm_in_fwd_icmp(struct sk_buff *skb,
+			      const struct flowi *fl, unsigned short family,
+			      u32 if_id)
+{
+	struct xfrm_policy *pol = NULL;
+
+	if (icmp_err_packet(fl, family)) {
+		struct flowi fl1;
+		struct net *net = dev_net(skb->dev);
+
+		if (xfrm_icmp_flow_decode(skb, family, fl, &fl1))
+			return pol;
+
+		pol = xfrm_policy_lookup(net, &fl1, family, XFRM_POLICY_FWD, if_id);
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
+
+		if (xfrm_icmp_flow_decode(skb, family, fl, &fl1))
+			return dst;
+
+		dst_hold(dst);
+
+		dst2 = xfrm_lookup(net, dst, &fl1, NULL, (XFRM_LOOKUP_QUEUE | XFRM_LOOKUP_ICMP));
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
@@ -3549,9 +3672,17 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 
 		for (i = sp->len - 1; i >= 0; i--) {
 			struct xfrm_state *x = sp->xvec[i];
+			int ret = 0;
+
 			if (!xfrm_selector_match(&x->sel, &fl, family)) {
-				XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMISMATCH);
-				return 0;
+				ret = 1;
+				if (x->props.flags & XFRM_STATE_ICMP &&
+				    xfrm_selector_inner_icmp_match(skb, family, &x->sel, &fl))
+					ret = 0;
+				if (ret) {
+					XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMISMATCH);
+					return 0;
+				}
 			}
 		}
 	}
@@ -3574,6 +3705,9 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		return 0;
 	}
 
+	if (!pol && dir == XFRM_POLICY_FWD)
+		pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
+
 	if (!pol) {
 		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
@@ -3707,6 +3841,10 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
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


