Return-Path: <netdev+bounces-137808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2E9A9E67
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDA61F23621
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F31991CA;
	Tue, 22 Oct 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="r8nO2EKm"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F2195F17
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588991; cv=none; b=R2w6ximbEl0VJZxlP7sWYROe0HSxjmqd4RuXLZ2wGlwxlcSIJynHaHKLst03HakRS9uwHTo3JzRW9hpSTvRw6aQUY3jAG9s7biFE6nObBAluVuHc4Mqx4GrP+TrGeWRdabKWuAUZtTNbd3uw6zuCtyQW9AAPtY6cODqccWhIy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588991; c=relaxed/simple;
	bh=REiz+H9hyL3x+p8TH6LJ0BhrRGVf6rdU3xIKUrbBPiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvpjfwfPHwlaZiBG8LjtY1k/ovDeaN35JJvwMqmjcdfb240psC+iUTdmelH7qej9gBFYBncbSThMlyBdk8XQrHfQBTB11YbAyvwm45Wt0AhKXrYurBeFZHTqCP3IYtBuuUI9uOjaUYQvsAzMT2CniB8ewp8zNm0fI/ktd41Z7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=r8nO2EKm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CB8A620870;
	Tue, 22 Oct 2024 11:23:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYctZ95rXD-i; Tue, 22 Oct 2024 11:22:59 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C45BD204D9;
	Tue, 22 Oct 2024 11:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C45BD204D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729588979;
	bh=/l6UHeK0EcV6Bt8thRAiQlz8kyD3aGZzXsgKtTVxucA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=r8nO2EKmPtU+pJ5N1zZYprJ/qsY1x6jOb9NIo9cIpLPvR1xcl7fTglLYN+O5HOqsQ
	 5h41XLrG4Bxf5eqUfoboaAme0q+KpbHBdyCZehH8qVyywgmnh6SUTWBdeXqDIcwOYe
	 y647ENPosLmIhJX8y9uoy9vR+kE9BR2EkZGkyP4KfFV3garlIV/n/1AUEGdugBj4dP
	 h4HdZahlZlemYWXvfL+AKxwDUJ6ebxlLYllJ5vkWJvpMnuSdzLGOhXR52+yn1ysDPS
	 st2HKbgAEvXyo8QwFKYGJhLzei+Q82+NdtB7bX8e2PHcguEHt6PgwfDXo8fPHYIPV9
	 4XLlF77GZs9zQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:22:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 11:22:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0AD9B3180BDB; Tue, 22 Oct 2024 11:22:29 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/5] xfrm: extract dst lookup parameters into a struct
Date: Tue, 22 Oct 2024 11:22:22 +0200
Message-ID: <20241022092226.654370-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022092226.654370-1-steffen.klassert@secunet.com>
References: <20241022092226.654370-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Eyal Birger <eyal.birger@gmail.com>

Preparation for adding more fields to dst lookup functions without
changing their signatures.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h      | 26 +++++++++++++-------------
 net/ipv4/xfrm4_policy.c | 38 ++++++++++++++++----------------------
 net/ipv6/xfrm6_policy.c | 28 +++++++++++++---------------
 net/xfrm/xfrm_device.c  | 11 ++++++++---
 net/xfrm/xfrm_policy.c  | 35 +++++++++++++++++++++++------------
 5 files changed, 73 insertions(+), 65 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b6bfdc6416c7..f3ae50372707 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -349,20 +349,23 @@ struct xfrm_if_cb {
 void xfrm_if_register_cb(const struct xfrm_if_cb *ifcb);
 void xfrm_if_unregister_cb(void);
 
+struct xfrm_dst_lookup_params {
+	struct net *net;
+	int tos;
+	int oif;
+	xfrm_address_t *saddr;
+	xfrm_address_t *daddr;
+	u32 mark;
+};
+
 struct net_device;
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
 	struct dst_ops		*dst_ops;
-	struct dst_entry	*(*dst_lookup)(struct net *net,
-					       int tos, int oif,
-					       const xfrm_address_t *saddr,
-					       const xfrm_address_t *daddr,
-					       u32 mark);
-	int			(*get_saddr)(struct net *net, int oif,
-					     xfrm_address_t *saddr,
-					     xfrm_address_t *daddr,
-					     u32 mark);
+	struct dst_entry	*(*dst_lookup)(const struct xfrm_dst_lookup_params *params);
+	int			(*get_saddr)(xfrm_address_t *saddr,
+					     const struct xfrm_dst_lookup_params *params);
 	int			(*fill_dst)(struct xfrm_dst *xdst,
 					    struct net_device *dev,
 					    const struct flowi *fl);
@@ -1764,10 +1767,7 @@ static inline int xfrm_user_policy(struct sock *sk, int optname,
 }
 #endif
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark);
+struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lookup_params *params);
 
 struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 0294fef577fa..ac1a28ef0c56 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -17,47 +17,41 @@
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
-					    int tos, int oif,
-					    const xfrm_address_t *saddr,
-					    const xfrm_address_t *daddr,
-					    u32 mark)
+static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
+					    const struct xfrm_dst_lookup_params *params)
 {
 	struct rtable *rt;
 
 	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = daddr->a4;
-	fl4->flowi4_tos = tos;
-	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl4->flowi4_mark = mark;
-	if (saddr)
-		fl4->saddr = saddr->a4;
-
-	rt = __ip_route_output_key(net, fl4);
+	fl4->daddr = params->daddr->a4;
+	fl4->flowi4_tos = params->tos;
+	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							    params->oif);
+	fl4->flowi4_mark = params->mark;
+	if (params->saddr)
+		fl4->saddr = params->saddr->a4;
+
+	rt = __ip_route_output_key(params->net, fl4);
 	if (!IS_ERR(rt))
 		return &rt->dst;
 
 	return ERR_CAST(rt);
 }
 
-static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm4_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi4 fl4;
 
-	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
+	return __xfrm4_dst_lookup(&fl4, params);
 }
 
-static int xfrm4_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm4_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct flowi4 fl4;
 
-	dst = __xfrm4_dst_lookup(net, &fl4, 0, oif, NULL, daddr, mark);
+	dst = __xfrm4_dst_lookup(&fl4, params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index b1d81c4270ab..fc3f5eec6898 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -23,23 +23,21 @@
 #include <net/ip6_route.h>
 #include <net/l3mdev.h>
 
-static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
-					  const xfrm_address_t *saddr,
-					  const xfrm_address_t *daddr,
-					  u32 mark)
+static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_params *params)
 {
 	struct flowi6 fl6;
 	struct dst_entry *dst;
 	int err;
 
 	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(net, oif);
-	fl6.flowi6_mark = mark;
-	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
-	if (saddr)
-		memcpy(&fl6.saddr, saddr, sizeof(fl6.saddr));
+	fl6.flowi6_l3mdev = l3mdev_master_ifindex_by_index(params->net,
+							   params->oif);
+	fl6.flowi6_mark = params->mark;
+	memcpy(&fl6.daddr, params->daddr, sizeof(fl6.daddr));
+	if (params->saddr)
+		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
 
-	dst = ip6_route_output(net, NULL, &fl6);
+	dst = ip6_route_output(params->net, NULL, &fl6);
 
 	err = dst->error;
 	if (dst->error) {
@@ -50,15 +48,14 @@ static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int oif,
 	return dst;
 }
 
-static int xfrm6_get_saddr(struct net *net, int oif,
-			   xfrm_address_t *saddr, xfrm_address_t *daddr,
-			   u32 mark)
+static int xfrm6_get_saddr(xfrm_address_t *saddr,
+			   const struct xfrm_dst_lookup_params *params)
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
 
-	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
+	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
@@ -68,7 +65,8 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
+	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+			   &saddr->in6);
 	dst_release(dst);
 	return 0;
 }
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f123b7c9ec82..b33c4591e09a 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -269,6 +269,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
+		struct xfrm_dst_lookup_params params;
+
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
 			saddr = &x->props.saddr;
 			daddr = &x->id.daddr;
@@ -277,9 +279,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 			daddr = &x->props.saddr;
 		}
 
-		dst = __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
-					x->props.family,
-					xfrm_smark_get(0, x));
+		memset(&params, 0, sizeof(params));
+		params.net = net;
+		params.saddr = saddr;
+		params.daddr = daddr;
+		params.mark = xfrm_smark_get(0, x);
+		dst = __xfrm_dst_lookup(x->props.family, &params);
 		if (IS_ERR(dst))
 			return (is_packet_offload) ? -EINVAL : 0;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 914bac03b52a..ec8f2fe13a51 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -270,10 +270,8 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
 	return rcu_dereference(xfrm_if_cb);
 }
 
-struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
-				    const xfrm_address_t *saddr,
-				    const xfrm_address_t *daddr,
-				    int family, u32 mark)
+struct dst_entry *__xfrm_dst_lookup(int family,
+				    const struct xfrm_dst_lookup_params *params)
 {
 	const struct xfrm_policy_afinfo *afinfo;
 	struct dst_entry *dst;
@@ -282,7 +280,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
 	if (unlikely(afinfo == NULL))
 		return ERR_PTR(-EAFNOSUPPORT);
 
-	dst = afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
+	dst = afinfo->dst_lookup(params);
 
 	rcu_read_unlock();
 
@@ -296,6 +294,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
 {
+	struct xfrm_dst_lookup_params params;
 	struct net *net = xs_net(x);
 	xfrm_address_t *saddr = &x->props.saddr;
 	xfrm_address_t *daddr = &x->id.daddr;
@@ -310,7 +309,14 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 		daddr = x->coaddr;
 	}
 
-	dst = __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
+	params.net = net;
+	params.saddr = saddr;
+	params.daddr = daddr;
+	params.tos = tos;
+	params.oif = oif;
+	params.mark = mark;
+
+	dst = __xfrm_dst_lookup(family, &params);
 
 	if (!IS_ERR(dst)) {
 		if (prev_saddr != saddr)
@@ -2432,15 +2438,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const struct sock *osk)
 }
 
 static int
-xfrm_get_saddr(struct net *net, int oif, xfrm_address_t *local,
-	       xfrm_address_t *remote, unsigned short family, u32 mark)
+xfrm_get_saddr(unsigned short family, xfrm_address_t *saddr,
+	       const struct xfrm_dst_lookup_params *params)
 {
 	int err;
 	const struct xfrm_policy_afinfo *afinfo = xfrm_policy_get_afinfo(family);
 
 	if (unlikely(afinfo == NULL))
 		return -EINVAL;
-	err = afinfo->get_saddr(net, oif, local, remote, mark);
+	err = afinfo->get_saddr(saddr, params);
 	rcu_read_unlock();
 	return err;
 }
@@ -2469,9 +2475,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 			remote = &tmpl->id.daddr;
 			local = &tmpl->saddr;
 			if (xfrm_addr_any(local, tmpl->encap_family)) {
-				error = xfrm_get_saddr(net, fl->flowi_oif,
-						       &tmp, remote,
-						       tmpl->encap_family, 0);
+				struct xfrm_dst_lookup_params params;
+
+				memset(&params, 0, sizeof(params));
+				params.net = net;
+				params.oif = fl->flowi_oif;
+				params.daddr = remote;
+				error = xfrm_get_saddr(tmpl->encap_family, &tmp,
+						       &params);
 				if (error)
 					goto fail;
 				local = &tmp;
-- 
2.34.1


