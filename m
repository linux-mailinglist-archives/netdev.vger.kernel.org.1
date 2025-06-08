Return-Path: <netdev+bounces-195538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90DAD117A
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DD516A518
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEB1F4727;
	Sun,  8 Jun 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY5/64Yf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9341367
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368593; cv=none; b=ZchNQOg74JJ0JsM9RyILKvz8bFSlvYp+HoUlbTIaVfw9NEo+PFitGm0YGEQKqI6/QG3c0rkuOX+NSkxF2oe00RYTWLm6vG0Beqn+bMZp+gbfZ9tVRWwK8eo7DLU2xGYPztxkekRwB9/NTnCP2xuDrD4xTrC5fD+vkP8ssFIBZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368593; c=relaxed/simple;
	bh=YNkLuN3un2Zu1XtRS23wjqlcQjjdetsCMWApItyJ2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHou4KIKlCESghF7tu6Yb4SqsELH3riHGL5ADa6nEOtRVqy9KO7uKxe4+4UJriiJVrFyilzVvOwlbg97GvJaLxYIo6xIe4XmQbY0Bm0lRcpBLq+MlOI4u4tnVHiiVdAGZUIzn6PVJWFy+H/Jw79dAP7TpUg7DqMh1U9JPG5xzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY5/64Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C5CC4CEF0;
	Sun,  8 Jun 2025 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749368593;
	bh=YNkLuN3un2Zu1XtRS23wjqlcQjjdetsCMWApItyJ2XA=;
	h=From:To:Cc:Subject:Date:From;
	b=CY5/64YfPLK/EwhhY4kiR9DBv23AfAQwCdvxJ6bH4Evjd6XhKHb1G/iDdCpI9lkrp
	 vWB+xSQQOMG4N5nuI9qvIU7TwWgr/JG3vJg4C2yyFfoJbX8rMx4OSpgbJkbZ4AB4ID
	 1NWRcI4lCRPvnBFW+Dkn+HuUoY1QjLA/zf3KazGYEYoX+hWjQx4Lun/s56JUK4F8Zq
	 GpRls+peQVZ+VCpX5SMZUcfqS+ipRCGrGKf71YCEyDyexBNBSl36B5L0c4ZLL7RwGD
	 raxATpA51I1cUG/7Y2J8y3/FZ4pNCEjDLOH4tzTfW4+MIMiAyir8OAzssC0urEYT2K
	 tnwXQd/s9yG3A==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-rc] xfrm: always initialize offload path
Date: Sun,  8 Jun 2025 10:42:53 +0300
Message-ID: <1adfa8a9af9426b34b2fbeefc64fd41c4f4aa1ab.1749368489.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Offload path is used for GRO with SW IPsec, and not just for HW
offload. So initialize it anyway.

Fixes: 585b64f5a620 ("xfrm: delay initialization of offload path till its actually requested")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Closes: https://lore.kernel.org/all/aEGW_5HfPqU1rFjl@krikkit
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 2 +-
 net/xfrm/xfrm_device.c | 1 -
 net/xfrm/xfrm_state.c  | 6 ++----
 net/xfrm/xfrm_user.c   | 1 +
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 06ab2a3d2ebd1..b10fd5095688f 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -463,7 +463,7 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
-void xfrm_set_type_offload(struct xfrm_state *x);
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load);
 static inline void xfrm_unset_type_offload(struct xfrm_state *x)
 {
 	if (!x->type_offload)
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 01dc31111570c..9de5ad24533e1 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -310,7 +310,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	xfrm_set_type_offload(x);
 	if (!x->type_offload) {
 		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
 		dev_put(dev);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 07fe8e5daa32b..e0a1748e8a0ff 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,11 +424,10 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-void xfrm_set_type_offload(struct xfrm_state *x)
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
-	bool try_load = true;
 
 retry:
 	afinfo = xfrm_state_get_afinfo(x->props.family);
@@ -607,6 +606,7 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
+	xfrm_unset_type_offload(x);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -780,8 +780,6 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
-	xfrm_unset_type_offload(x);
-
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 614b58cb26ab7..d17ea437a1587 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -977,6 +977,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	/* override default values from above */
 	xfrm_update_ae_params(x, attrs, 0);
 
+	xfrm_set_type_offload(x, attrs[XFRMA_OFFLOAD_DEV]);
 	/* configure the hardware if offload is requested */
 	if (attrs[XFRMA_OFFLOAD_DEV]) {
 		err = xfrm_dev_state_add(net, x,
-- 
2.49.0


