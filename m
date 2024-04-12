Return-Path: <netdev+bounces-87267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5038A2622
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E346A286FE7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B3F200D4;
	Fri, 12 Apr 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rdADiw9S"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DB1C68A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901966; cv=none; b=KLx+u0ccRIurw4xmzpC88XFnj326I4jk3AOjesmp6j0wd0LXV5U0MUWEuxA8QlzzGRhxMJWcVOM1xJ+fQFKlYZjM33NcUkDVvSiMlNO6YlIBeTq94CsZtiAVL72zqshZKZ7hDTJzoq9HCrTjG+cWNZQACkvPVSyNC2k3pcq6DBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901966; c=relaxed/simple;
	bh=f0oCvVrodwtAvDr2kH/GSfXb0VcH2LEGQL8DzOq8pX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBIHQW7pXs5tKCqsk5/xVp9pv953XJfyigqchUxQ7eO6whiuqisSrgV/kceXa/CCLJcr6M79k9eMdByTY0FFF4q3iQYng8mGW1YpziwNSrD/oOwg1cFt7gFCRvLCa9XbHARh2yQQrZEzW23KqBpt2R+0+UGfLC+SSsn4Wzzxn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rdADiw9S; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5AEB120897;
	Fri, 12 Apr 2024 08:06:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjBXiSc39UXz; Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9D34C20892;
	Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9D34C20892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712901960;
	bh=fa8rR0uuUn/6J1NfvlqnOQbDTv5Y8IivmRVzSREdCwY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rdADiw9SuJSNffxwjznkC2lgsdMpE76SRplU49ZQutdIuNntGfmusWGh0rE+uHDNN
	 cFl7RSrRKiCHqJFdrHvECWI4DpNmg1dQYaXpHtbpHmlZ8Cz6V6Qlw7BOmo6OKHdpE5
	 lFlZOa2KmpH7tjd5so3J+nDdt96BLXih9Oav6XJWOr07f8VzoYnRYJ79WUEetsLQPd
	 4srjsc/utoBca993cGQ+tfjLZJSuXJUN9SU2kiqusJm9opiTIBImBy30TUZPH9P6Jk
	 OdR+WB1rlN+NQu3+jkd9RMeQBBwRAk/LadwCfEllHRScXs9v4RtXyFliwJ6X/6SW+v
	 8RZzLqCaMTYYw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 9018480004A;
	Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 08:06:00 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 12 Apr
 2024 08:06:00 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DC1523182585; Fri, 12 Apr 2024 08:05:59 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
CC: Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec-next 3/3] xfrm: Add an inbound percpu state cache.
Date: Fri, 12 Apr 2024 08:05:53 +0200
Message-ID: <20240412060553.3483630-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412060553.3483630-1-steffen.klassert@secunet.com>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Now that we can have percpu xfrm states, the number of active
states might increase. To get a better lookup performance,
we add a percpu cache to cache the used inbound xfrm states.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/netns/xfrm.h |  1 +
 include/net/xfrm.h       |  5 ++++
 net/ipv4/esp4_offload.c  |  6 ++---
 net/ipv6/esp6_offload.c  |  6 ++---
 net/xfrm/xfrm_input.c    |  2 +-
 net/xfrm/xfrm_state.c    | 57 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 423b52eca908..177516be776d 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -43,6 +43,7 @@ struct netns_xfrm {
 	struct hlist_head	__rcu *state_bysrc;
 	struct hlist_head	__rcu *state_byspi;
 	struct hlist_head	__rcu *state_byseq;
+	struct hlist_head	__rcu __percpu *state_cache_input;
 	unsigned int		state_hmask;
 	unsigned int		state_num;
 	struct work_struct	state_hash_work;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 49c85bcd9fd9..60c2b129e9e5 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -182,6 +182,7 @@ struct xfrm_state {
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
 	struct hlist_node	state_cache;
+	struct hlist_node	state_cache_input;
 
 	refcount_t		refcnt;
 	spinlock_t		lock;
@@ -1604,6 +1605,10 @@ int xfrm_state_update(struct xfrm_state *x);
 struct xfrm_state *xfrm_state_lookup(struct net *net, u32 mark,
 				     const xfrm_address_t *daddr, __be32 spi,
 				     u8 proto, unsigned short family);
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family);
 struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 					    const xfrm_address_t *daddr,
 					    const xfrm_address_t *saddr,
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index b3271957ad9a..6ccb8d56ad2a 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -53,9 +53,9 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ip_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET);
 		if (!x)
 			goto out_reset;
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 527b7caddbc6..c82ed369e888 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -80,9 +80,9 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		if (sp->len == XFRM_MAX_DEPTH)
 			goto out_reset;
 
-		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
-				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
-				      spi, IPPROTO_ESP, AF_INET6);
+		x = xfrm_input_state_lookup(dev_net(skb->dev), skb->mark,
+					    (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
+					    spi, IPPROTO_ESP, AF_INET6);
 		if (!x)
 			goto out_reset;
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..82dba4673296 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -563,7 +563,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		x = xfrm_state_lookup(net, mark, daddr, spi, nexthdr, family);
+		x = xfrm_input_state_lookup(net, mark, daddr, spi, nexthdr, family);
 		if (x == NULL) {
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOSTATES);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ff2b0fc0b206..86f8dde23ff1 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -717,6 +717,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
 			hlist_del_rcu(&x->byseq);
 		if (!hlist_unhashed(&x->state_cache))
 			hlist_del_rcu(&x->state_cache);
+		if (!hlist_unhashed(&x->state_cache_input))
+			hlist_del_rcu(&x->state_cache_input);
+
 		if (x->id.spi)
 			hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
@@ -1048,6 +1051,52 @@ static struct xfrm_state *__xfrm_state_lookup(struct net *net, u32 mark,
 	return NULL;
 }
 
+struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
+					   const xfrm_address_t *daddr,
+					   __be32 spi, u8 proto,
+					   unsigned short family)
+{
+	struct hlist_head *state_cache_input;
+	struct xfrm_state *x = NULL;
+	int cpu = get_cpu();
+
+	state_cache_input =  per_cpu_ptr(net->xfrm.state_cache_input, cpu);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
+		if (x->props.family != family ||
+		    x->id.spi       != spi ||
+		    x->id.proto     != proto ||
+		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
+			continue;
+
+		if ((mark & x->mark.m) != x->mark.v)
+			continue;
+		if (!xfrm_state_hold_rcu(x))
+			continue;
+		goto out;
+	}
+
+	x = __xfrm_state_lookup(net, mark, daddr, spi, proto, family);
+
+	if (x && x->km.state == XFRM_STATE_VALID) {
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		if (hlist_unhashed(&x->state_cache_input)) {
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		} else {
+			hlist_del_rcu(&x->state_cache_input);
+			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
+		}
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	}
+
+out:
+	rcu_read_unlock();
+	put_cpu();
+	return x;
+}
+EXPORT_SYMBOL(xfrm_input_state_lookup);
+
 static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 						     const xfrm_address_t *daddr,
 						     const xfrm_address_t *saddr,
@@ -2987,6 +3036,11 @@ int __net_init xfrm_state_init(struct net *net)
 	net->xfrm.state_byseq = xfrm_hash_alloc(sz);
 	if (!net->xfrm.state_byseq)
 		goto out_byseq;
+
+	net->xfrm.state_cache_input = alloc_percpu(struct hlist_head);
+	if (!net->xfrm.state_cache_input)
+		goto out_state_cache_input;
+
 	net->xfrm.state_hmask = ((sz / sizeof(struct hlist_head)) - 1);
 
 	net->xfrm.state_num = 0;
@@ -2996,6 +3050,8 @@ int __net_init xfrm_state_init(struct net *net)
 			       &net->xfrm.xfrm_state_lock);
 	return 0;
 
+out_state_cache_input:
+	xfrm_hash_free(net->xfrm.state_byseq, sz);
 out_byseq:
 	xfrm_hash_free(net->xfrm.state_byspi, sz);
 out_byspi:
@@ -3025,6 +3081,7 @@ void xfrm_state_fini(struct net *net)
 	xfrm_hash_free(net->xfrm.state_bysrc, sz);
 	WARN_ON(!hlist_empty(net->xfrm.state_bydst));
 	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	free_percpu(net->xfrm.state_cache_input);
 }
 
 #ifdef CONFIG_AUDITSYSCALL
-- 
2.34.1


