Return-Path: <netdev+bounces-192964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E8AC1E01
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850C07B6A7C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3353286D6E;
	Fri, 23 May 2025 07:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3C2857FF
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986989; cv=none; b=Dgx6PZjBFB09w9eNn8sQQDzVmbgPYn6F8m3gJKuQ4F4Kcea3ClwNXXVI4YxHgdvnAzs5b/p7NHmjOZKZlgndwqCbOMwZAoSNB/5wKaon91yuGysMreSc/VCbyrSuRcKZvHNtLZBhRF9hfFBHmQepEtr21WlfB7rjDVJpBC2ifjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986989; c=relaxed/simple;
	bh=qrvnC6KrirJw4ffo1G+1HS1p4pbuArc2RwYfp8uowNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkW31Fi8WFauL69vy5R9CpdDHDHnpaMx7SFv+6IqWRWMZGeJXhajfxEjuIREgBGAORc4llDy4R1288G1SGvNo6+TTfMrsZoVSzhfuoxBxhYIPYLdDJtMaxv10Vg6VmsxF4cFbF1tAjPIDEGprgcohQa3y5fNrxrdK9xlQ0teSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6B6C0208A8;
	Fri, 23 May 2025 09:56:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FkdY90DB58m; Fri, 23 May 2025 09:56:19 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B269D2088E;
	Fri, 23 May 2025 09:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B269D2088E
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:19 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1BFEB3181962; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/12] net/mlx5: Avoid using xso.real_dev unnecessarily
Date: Fri, 23 May 2025 09:56:01 +0200
Message-ID: <20250523075611.3723340-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
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

From: Cosmin Ratiu <cratiu@nvidia.com>

xso.real_dev is the active device of an offloaded xfrm state and is
managed by bonding. As such, it's subject to change when states are
migrated to a new device. Using it in places other than
offloading/unoffloading the states is risky.

This commit saves the device into the driver-specific struct
mlx5e_ipsec_sa_entry and switches mlx5e_ipsec_init_macs() and
mlx5e_ipsec_netevent_event() to make use of it.

Additionally, mlx5e_xfrm_update_stats() used xso.real_dev to validate
that correct net locks are held. But in a bonding config, the net of the
master device is the same as the underlying devices, and the net is
already a local var, so use that instead.

The only remaining references to xso.real_dev are now in the
.xdo_dev_state_add() / .xdo_dev_state_delete() path.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 16 +++++-----------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h |  1 +
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 2dd842aac6fc..626e525c0f0d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -259,8 +259,7 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
-	struct xfrm_state *x = sa_entry->x;
-	struct net_device *netdev;
+	struct net_device *netdev = sa_entry->dev;
 	struct neighbour *n;
 	u8 addr[ETH_ALEN];
 	const void *pkey;
@@ -270,8 +269,6 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
-	netdev = x->xso.real_dev;
-
 	mlx5_query_mac_address(mdev, addr);
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
@@ -713,6 +710,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 		return -ENOMEM;
 
 	sa_entry->x = x;
+	sa_entry->dev = netdev;
 	sa_entry->ipsec = ipsec;
 	/* Check if this SA is originated from acquire flow temporary SA */
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
@@ -855,8 +853,6 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 	struct mlx5e_ipsec_sa_entry *sa_entry;
 	struct mlx5e_ipsec *ipsec;
 	struct neighbour *n = ptr;
-	struct net_device *netdev;
-	struct xfrm_state *x;
 	unsigned long idx;
 
 	if (event != NETEVENT_NEIGH_UPDATE || !(n->nud_state & NUD_VALID))
@@ -876,11 +872,9 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 				continue;
 		}
 
-		x = sa_entry->x;
-		netdev = x->xso.real_dev;
 		data = sa_entry->work->data;
 
-		neigh_ha_snapshot(data->addr, n, netdev);
+		neigh_ha_snapshot(data->addr, n, sa_entry->dev);
 		queue_work(ipsec->wq, &sa_entry->work->work);
 	}
 
@@ -996,8 +990,8 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	size_t headers;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
-		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_state_lock));
+		       lockdep_is_held(&net->xfrm.xfrm_cfg_mutex) ||
+		       lockdep_is_held(&net->xfrm.xfrm_state_lock));
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index a63c2289f8af..ffcd0cdeb775 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -274,6 +274,7 @@ struct mlx5e_ipsec_limits {
 struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_esn_state esn_state;
 	struct xfrm_state *x;
+	struct net_device *dev;
 	struct mlx5e_ipsec *ipsec;
 	struct mlx5_accel_esp_xfrm_attrs attrs;
 	void (*set_iv_op)(struct sk_buff *skb, struct xfrm_state *x,
-- 
2.34.1


