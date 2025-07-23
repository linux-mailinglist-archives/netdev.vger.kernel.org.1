Return-Path: <netdev+bounces-209236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B97B0EC71
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F21C2652C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D446B278156;
	Wed, 23 Jul 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BapOFgMe"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9267277C88
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257272; cv=none; b=bOXquA5hs/CzUWve9D5RkBUjaB7L/Of3+MUUHgWrAGpEZ9KBgnS+2aJfrhJMLPuUcKY14CFLA+QWCuKg50D6M0wiOPzet6pU+DaM0JZoAGuc4Pu5v4Tthblycm/tCUvMf1ABA1JuF0F85yqae2ePKy0Q7wmHPwyFQ7Sxr2NdPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257272; c=relaxed/simple;
	bh=ezbaReaCpIunz/Fl1O+8KN2WKLB3hsk2knIQh9KyXtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlMkqx/9yNVX7RYYpGWJUdj5ovwCAq6unWuXgIOG0sbxhf1MX1sdPEncJor3DKEnuMGHjqMGKU+sfx+cGdoMiCopjJz1loiBuyjmUa3JZ6eMqpeP2D1QSbpZDsxotZxxTg3/oHn+6aVNssDV1lH+V94NvQOrhiM8xZLwWIkJYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BapOFgMe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1A53020892;
	Wed, 23 Jul 2025 09:54:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsPMyXcO1D5w; Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F29B9208A2;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F29B9208A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257261;
	bh=yhbG4yMzYIV9Db+2RhxQslfWvnHKtCTwqNf9uYI9sVM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BapOFgMew7dseYeGJVBqp/7U2/iCviDxYVR3WnJMJ3vNzCs4UfrosAg1LSMY1t5WC
	 oTznscJbpPsP1zK0X7OqIra45iduo9Ef3wVnlapSyY55XuHpsZDtG1CTQMioM8+trV
	 EedLYI7CgITHD46z62pWkt+RtemkapHHNyaRno+Jxu/nwFDD8XHcgrwV9kialrl8EV
	 r+AphdK8RcPPxMFpBkJ+0VzfMr1suerAwWsA/jogZaxJdFhg/tAtkvFpNAT5ZbQZlR
	 nmqb3A7m6L+KBtf1OgoQ5BIperTuZxF3rwbLHlVTABwsDX4joRMmZ+ZEdQPU5wapfq
	 0z1hixrWRqDzw==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id ADA973184253; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/8] xfrm: delete x->tunnel as we delete x
Date: Wed, 23 Jul 2025 09:53:59 +0200
Message-ID: <20250723075417.3432644-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

The ipcomp fallback tunnels currently get deleted (from the various
lists and hashtables) as the last user state that needed that fallback
is destroyed (not deleted). If a reference to that user state still
exists, the fallback state will remain on the hashtables/lists,
triggering the WARN in xfrm_state_fini. Because of those remaining
references, the fix in commit f75a2804da39 ("xfrm: destroy xfrm_state
synchronously on net exit path") is not complete.

We recently fixed one such situation in TCP due to defered freeing of
skbs (commit 9b6412e6979f ("tcp: drop secpath at the same time as we
currently drop dst")). This can also happen due to IP reassembly: skbs
with a secpath remain on the reassembly queue until netns
destruction. If we can't guarantee that the queues are flushed by the
time xfrm_state_fini runs, there may still be references to a (user)
xfrm_state, preventing the timely deletion of the corresponding
fallback state.

Instead of chasing each instance of skbs holding a secpath one by one,
this patch fixes the issue directly within xfrm, by deleting the
fallback state as soon as the last user state depending on it has been
deleted. Destruction will still happen when the final reference is
dropped.

A separate lockdep class for the fallback state is required since
we're going to lock x->tunnel while x is locked.

Fixes: 9d4139c76905 ("netns xfrm: per-netns xfrm_state_all list")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h      |  1 -
 net/ipv4/ipcomp.c       |  2 ++
 net/ipv6/ipcomp6.c      |  2 ++
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/xfrm/xfrm_ipcomp.c  |  1 -
 net/xfrm/xfrm_state.c   | 19 ++++++++-----------
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e45a275fca26..91d52a380e37 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -441,7 +441,6 @@ int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo);
 int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo);
 
 void xfrm_flush_gc(void);
-void xfrm_state_delete_tunnel(struct xfrm_state *x);
 
 struct xfrm_type {
 	struct module		*owner;
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 5a4fb2539b08..9a45aed508d1 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -54,6 +54,7 @@ static int ipcomp4_err(struct sk_buff *skb, u32 info)
 }
 
 /* We always hold one tunnel user reference to indicate a tunnel */
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -62,6 +63,7 @@ static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPIP;
 	t->id.spi = x->props.saddr.a4;
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 72d4858dec18..8607569de34f 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -71,6 +71,7 @@ static int ipcomp6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -79,6 +80,7 @@ static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPV6;
 	t->id.spi = xfrm6_tunnel_alloc_spi(net, (xfrm_address_t *)&x->props.saddr);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index bf140ef781c1..7fd8bc08e6eb 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,8 +334,8 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_flush_gc();
 	xfrm_state_flush(net, 0, false, true);
+	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
 		WARN_ON_ONCE(!hlist_empty(&xfrm6_tn->spi_byaddr[i]));
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a38545413b80..43fdc6ed8dd1 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -313,7 +313,6 @@ void ipcomp_destroy(struct xfrm_state *x)
 	struct ipcomp_data *ipcd = x->data;
 	if (!ipcd)
 		return;
-	xfrm_state_delete_tunnel(x);
 	ipcomp_free_data(ipcd);
 	kfree(ipcd);
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c7e6472c623d..f7110a658897 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -811,6 +811,7 @@ void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
+static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 int __xfrm_state_delete(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -838,6 +839,8 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		xfrm_dev_state_delete(x);
 
+		xfrm_state_delete_tunnel(x);
+
 		/* All xfrm_state objects are created by xfrm_state_alloc.
 		 * The xfrm_state_alloc call gives a reference, and that
 		 * is what we are dropping here.
@@ -941,10 +944,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
 				err = xfrm_state_delete(x);
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
-				if (sync)
-					xfrm_state_put_sync(x);
-				else
-					xfrm_state_put(x);
+				xfrm_state_put(x);
 				if (!err)
 					cnt++;
 
@@ -3068,20 +3068,17 @@ void xfrm_flush_gc(void)
 }
 EXPORT_SYMBOL(xfrm_flush_gc);
 
-/* Temporarily located here until net/xfrm/xfrm_tunnel.c is created */
-void xfrm_state_delete_tunnel(struct xfrm_state *x)
+static void xfrm_state_delete_tunnel(struct xfrm_state *x)
 {
 	if (x->tunnel) {
 		struct xfrm_state *t = x->tunnel;
 
-		if (atomic_read(&t->tunnel_users) == 2)
+		if (atomic_dec_return(&t->tunnel_users) == 1)
 			xfrm_state_delete(t);
-		atomic_dec(&t->tunnel_users);
-		xfrm_state_put_sync(t);
+		xfrm_state_put(t);
 		x->tunnel = NULL;
 	}
 }
-EXPORT_SYMBOL(xfrm_state_delete_tunnel);
 
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 {
@@ -3286,8 +3283,8 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	flush_work(&xfrm_state_gc_work);
 	xfrm_state_flush(net, 0, false, true);
+	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
-- 
2.43.0


