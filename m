Return-Path: <netdev+bounces-105142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B990FCF6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA5A282395
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586012E631;
	Thu, 20 Jun 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zQ2SdBtE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34D012E78
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866057; cv=none; b=aTgZSvQMl/f2f4Vf26TIDe9yS1SMg9tDrWyzbo+/lMo3q8uVedq8a4wL4xD1hayUrBiGXqhdPqnwvme88yesrBoT7Osw6YitD26Wn78pITg8uM0IGpUTEN1pP8jqy3B/0WG9uJFLm0EgMgGihbd9yCKIIk6a2oUeeNdOq9f1m1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866057; c=relaxed/simple;
	bh=mLr50IOf/Ie09oDWbUwASpD27MHunGsFHRTi+5Pv9iE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lg0x3TFt7UjHzCpPiL4J3ilJArcaKDQcoGjWf8VPxOtbtYOXL1KkdBWVfFO4+Rh26t7SY6GVETUPMWqH/sSCCRlIOwkDTFHjpi/dz49WF7Q8ZVZeGU+G+uYLZiNHzvYG0eA2vW6382W9a95lSLbUqoFpdB+O8yJMFSnR5+5ZT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zQ2SdBtE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 60ECC207AC;
	Thu, 20 Jun 2024 08:47:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9sohFXktxIi; Thu, 20 Jun 2024 08:47:25 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 936832067F;
	Thu, 20 Jun 2024 08:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 936832067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1718866045;
	bh=M12VV0o/eJ9/v3YhFZiXQ4vD4nWHGrOeCy3BLNbxXEE=;
	h=Date:From:To:Subject:From;
	b=zQ2SdBtEopZ2x8Q0Vfdyw+qnrSsYh1wdM6mSVtTv6SyR3pIwgtC2hncfv3YzTY6/Z
	 Haf78wx83Tm4vjp8M7bNYoe4EhTAmvAym0JNiH1C8GYiWC/IrBEyNdxoSBb/uYrV4v
	 YpIwrhqsUjLsnlsGN7ZnG4Mmx+c/rnvYouF5gcdgljW1tGG5zN1NkQ1VRxyU63VdxA
	 uEcxdQIVRBSWbmr3TZHdafjQOiBHxm+uOcZ4Ep1ATIhn6CFevgUlVVEFZmjHKZLWHE
	 0UaIwB9rtchlOzfWYpSUaxcbsSTCaoGnMqyjbQV8G/xCvt5OgQ33oed/pwR9DLmc1u
	 ZtWz3RBdQ/+8A==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 86D5D80004A;
	Thu, 20 Jun 2024 08:47:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 08:47:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:47:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9EE393180390; Thu, 20 Jun 2024 08:47:24 +0200 (CEST)
Date: Thu, 20 Jun 2024 08:47:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 ipsec] xfrm: Fix unregister netdevice hang on hardware
 offload.
Message-ID: <ZnPQfG3qsSkAW2VM@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

When offloading xfrm states to hardware, the offloading
device is attached to the skbs secpath. If a skb is free
is deferred, an unregister netdevice hangs because the
netdevice is still refcounted.

Fix this by removing the netdevice from the xfrm states
when the netdevice is unregistered. To find all xfrm states
that need to be cleared we add another list where skbs
linked to that are unlinked from the lists (deleted)
but not yet freed.

Changes in v2:

- Fix build with CONFIG_XFRM_OFFLOAD disabled.
- Fix two typos in the commit message.

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    | 36 +++++++------------------
 net/xfrm/xfrm_state.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 77ebf5bcf0b9..7d4c2235252c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -178,7 +178,10 @@ struct xfrm_state {
 		struct hlist_node	gclist;
 		struct hlist_node	bydst;
 	};
-	struct hlist_node	bysrc;
+	union {
+		struct hlist_node	dev_gclist;
+		struct hlist_node	bysrc;
+	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
 
@@ -1588,7 +1591,7 @@ void xfrm_state_update_stats(struct net *net);
 static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xso;
-	struct net_device *dev = xdo->dev;
+	struct net_device *dev = READ_ONCE(xdo->dev);
 
 	if (dev && dev->xfrmdev_ops &&
 	    dev->xfrmdev_ops->xdo_dev_state_update_stats)
@@ -1946,13 +1949,16 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 			struct xfrm_user_offload *xuo, u8 dir,
 			struct netlink_ext_ack *extack);
 bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x);
+void xfrm_dev_state_delete(struct xfrm_state *x);
+void xfrm_dev_state_free(struct xfrm_state *x);
 
 static inline void xfrm_dev_state_advance_esn(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
 
-	if (xso->dev && xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn)
-		xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
+	if (dev && dev->xfrmdev_ops->xdo_dev_state_advance_esn)
+		dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
 }
 
 static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
@@ -1973,28 +1979,6 @@ static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
 	return false;
 }
 
-static inline void xfrm_dev_state_delete(struct xfrm_state *x)
-{
-	struct xfrm_dev_offload *xso = &x->xso;
-
-	if (xso->dev)
-		xso->dev->xfrmdev_ops->xdo_dev_state_delete(x);
-}
-
-static inline void xfrm_dev_state_free(struct xfrm_state *x)
-{
-	struct xfrm_dev_offload *xso = &x->xso;
-	struct net_device *dev = xso->dev;
-
-	if (dev && dev->xfrmdev_ops) {
-		if (dev->xfrmdev_ops->xdo_dev_state_free)
-			dev->xfrmdev_ops->xdo_dev_state_free(x);
-		xso->dev = NULL;
-		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
-		netdev_put(dev, &xso->dev_tracker);
-	}
-}
-
 static inline void xfrm_dev_policy_delete(struct xfrm_policy *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xdo;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0d..d531d2a1fae2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -49,6 +49,7 @@ static struct kmem_cache *xfrm_state_cache __ro_after_init;
 
 static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
 static HLIST_HEAD(xfrm_state_gc_list);
+static HLIST_HEAD(xfrm_state_dev_gc_list);
 
 static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
 {
@@ -214,6 +215,7 @@ static DEFINE_SPINLOCK(xfrm_state_afinfo_lock);
 static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
 
 static DEFINE_SPINLOCK(xfrm_state_gc_lock);
+static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
 
 int __xfrm_state_delete(struct xfrm_state *x);
 
@@ -683,6 +685,40 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 }
 EXPORT_SYMBOL(xfrm_state_alloc);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+void xfrm_dev_state_delete(struct xfrm_state *x)
+{
+	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
+
+	if (dev) {
+		dev->xfrmdev_ops->xdo_dev_state_delete(x);
+		spin_lock_bh(&xfrm_state_dev_gc_lock);
+		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
+		spin_unlock_bh(&xfrm_state_dev_gc_lock);
+	}
+}
+
+void xfrm_dev_state_free(struct xfrm_state *x)
+{
+	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
+
+	if (dev && dev->xfrmdev_ops) {
+		spin_lock_bh(&xfrm_state_dev_gc_lock);
+		if (!hlist_unhashed(&x->dev_gclist))
+			hlist_del(&x->dev_gclist);
+		spin_unlock_bh(&xfrm_state_dev_gc_lock);
+
+		if (dev->xfrmdev_ops->xdo_dev_state_free)
+			dev->xfrmdev_ops->xdo_dev_state_free(x);
+		WRITE_ONCE(xso->dev, NULL);
+		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
+		netdev_put(dev, &xso->dev_tracker);
+	}
+}
+#endif
+
 void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
@@ -848,6 +884,9 @@ EXPORT_SYMBOL(xfrm_state_flush);
 
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid)
 {
+	struct xfrm_state *x;
+	struct hlist_node *tmp;
+	struct xfrm_dev_offload *xso;
 	int i, err = 0, cnt = 0;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -857,8 +896,6 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		struct xfrm_state *x;
-		struct xfrm_dev_offload *xso;
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			xso = &x->xso;
@@ -868,6 +905,8 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 				err = xfrm_state_delete(x);
+				xfrm_dev_state_free(x);
+
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
@@ -884,6 +923,24 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
+	spin_lock_bh(&xfrm_state_dev_gc_lock);
+restart_gc:
+	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
+		xso = &x->xso;
+
+		if (xso->dev == dev) {
+			spin_unlock_bh(&xfrm_state_dev_gc_lock);
+			xfrm_dev_state_free(x);
+			spin_lock_bh(&xfrm_state_dev_gc_lock);
+			goto restart_gc;
+		}
+
+	}
+	spin_unlock_bh(&xfrm_state_dev_gc_lock);
+
+	xfrm_flush_gc();
+
 	return err;
 }
 EXPORT_SYMBOL(xfrm_dev_state_flush);
-- 
2.34.1


