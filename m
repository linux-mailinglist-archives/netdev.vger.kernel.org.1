Return-Path: <netdev+bounces-77867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F21873413
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64DE1F2B1F5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFE5FDA3;
	Wed,  6 Mar 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o7/jblwH"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940245F862
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720670; cv=none; b=o+J9SiO6yjkClFyeRDVHJSegX3taVcGqx3BRbZSSEaLcYG6lVfX0aDuO7b3LfdTmXS28izGkrf6Ye8dVOhyJCU/3u1UyAzytYEBjEdim4SqQ9P9EhljRsVtIZgktSOb8b2Ay2yC0LNMCR2/yBwk65cNKGZNkvHm5MV9G3q8KFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720670; c=relaxed/simple;
	bh=aWzKuHl4DKfuISI9C0hQt524zP9/U+JSw2lLkNguU38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1WGZMQkntUviJUMVCB6Du85iXJidovR3ZSC09MkuhgwMaFqc7LEXKYRantvMU7Fvbx3VrDPF/MFxlWl6z8/Bwqh5MovLZpTB4Gc/CA2DNeGZeZCtl26CZDKCvqDAzLkPyQoU2lsnQZWTTzTktDTurv7LQzbivW0X1m/somxTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o7/jblwH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0EF90201E4;
	Wed,  6 Mar 2024 11:24:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t1JXiB7srKC7; Wed,  6 Mar 2024 11:24:26 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 10A13207BB;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 10A13207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709720666;
	bh=dTsVOEdeYlfrvyHAvkbUbrGl0sLYmJmPjPbsRzYKPGA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=o7/jblwHc98S4wxGm8NRmeJH4UjusWEXF0fElL4vRv1B/rsxHpUs4/cs92Mm0Pffa
	 682GpDUvSVZP4CapK4TVD/+iRZMFR/GtPcn5WtxQNDoLwFnbyPWd2XkwZd00Uz/8fm
	 oToOtdMIyqkmhb4/hCD7HBKus3/WFh5koYz+4cCFNdATdH0ZTkA2YqRhcI1glPNMbM
	 4kZg5ep4W+ND5EiktdX9DaPkw0qjTscyOo0yNs0hUWMevRO+NBAsJKL7TI1kryqZmt
	 ZCxP7gSXp6o1Q8Xh8UOJhZC3V9fYybhcSZNzzCZXSzBru0mxAVf6H/86QpquYgKa9U
	 K1XO0qjH0oytQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 050A380004A;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:24:25 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:24:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 30F2731809D6; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/4] xfrm: introduce forwarding of ICMP Error messages
Date: Wed, 6 Mar 2024 11:24:18 +0100
Message-ID: <20240306102421.3963212-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306102421.3963212-1-steffen.klassert@secunet.com>
References: <20240306102421.3963212-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Antony Antony <antony.antony@secunet.com>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


