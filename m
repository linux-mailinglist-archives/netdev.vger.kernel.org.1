Return-Path: <netdev+bounces-146109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE39D1F31
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCCF282D46
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D9150981;
	Tue, 19 Nov 2024 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q5Jq4elT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E014F9E7
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990331; cv=none; b=KyrQESsPSKjCscafrSuWvVU00FG8PQArI3VHIX5ganNiDS4OohDS4KIrHfvL61sAZhyVWW1F0vzyUSqy2c1EhLtOFeDYyS7vp+Cci2tuPpqoo/sLGdL/cshPJHRuHW8qeZ+w2E9rGUuPU0XgvseBnhfg6+0I1gxGMYCWiEbRK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990331; c=relaxed/simple;
	bh=FJjmKpzIYgDfujopHIkhYFFfJzGJtokItrd50odKjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bp64j/wJYKwKnepEeAU7B53HhUsgflqsLgpbvUTGro8pjUQeq1ysuvc0lweTU0Vqs3XcZZA9mAyOqfDgyVOy1l2839LX/I7bawXYf1vBIdosubyBNYWg4sfHFyujVqmytCr01N+S4iI86dM5EmSXBxz905IVhum/3SJVYAQu0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q5Jq4elT; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-2ea46465d69so172310a91.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 20:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731990329; x=1732595129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3trMWXYzttAOtdIjV6M2XhTs2gOppEYx/zOfIC7UPJ8=;
        b=Q5Jq4elTQE6NzvJyxp4Sq8QsKzEiMNFEQQKtkB63iVO6mL9yNFkHtWr8OIp1xyEb2s
         /RXz76Svba3ki0msM31M69yd9mKp0Jr9o3/gapIjq4fo1ebnRyWTO5ovjYubx69Sm+fU
         vwk0pCdsdCfxdnbvy3Pqph/gtqn46+IvXYsyvc7Kg69e52IaV5e85SLLAiANnoBtQ/4w
         vHRcDhQGGRbdp6h7FReuPHTX9BTs4MNeHm1Jmy9lhQoXi5wFqxel/yoBV1W9XvzxXRg0
         xMJasQiIvyhFoXFeEgmCE8m9uo7VpgMDy9AVyR5h1VGNJamcI5ixq8bFoXYyrImPH3wv
         2hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990329; x=1732595129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3trMWXYzttAOtdIjV6M2XhTs2gOppEYx/zOfIC7UPJ8=;
        b=jWoWi4Ln/KQHZZbR5lKfmohqRPe5ncFqMVujaIqoCjveQoYBwzFK8SDNEUad1BGQDA
         3p64krwE2+8El09lXE3NrOw0S7hrCO2k1VTrLQye/DpCcqmNjkzEjRoNeDa5zLqhgmnr
         kVrzsVO9yuId3iAuhWWcLRw0f8muwgLDReNnBDQupF3GDf2UOti/vSjqNePcPcFuVovw
         s/Eff2ZqODdEQssWFuYTFycwVc5BCjV9Kp2s4NrG6p1rP+xl6ue8djTUnQ5E5iywcgI6
         sFxwqnTqdiSo1PaXJunQHRekgLt6vvSvrvS9hmaAquZpfAAdiIPnhpJoDCGb/kjUQsPr
         P5RA==
X-Forwarded-Encrypted: i=1; AJvYcCVREtMMqTr3HAXfxx8+GAuTMTt67R12om647GyChTHM/kaGR9ICbn5I8YkyxjqnczrcRobuvpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41oSmorJY4+x98pQuU266dkXJO+sknHOa9DY+HoL5O4O1sIZX
	hH9Ii+1Hs3hgHNcM47Ott4zNuDF8dp5+t+YGsgVS4WvIbaKeCc1EFQKvVQfvFDRDj6Ic7txBaxM
	uV7RO6Mi1ChRrroyZSFLQOVPXBf0SCsKU
X-Google-Smtp-Source: AGHT+IHFMNTIlbDoao3VsyR+BDuAcr6gQNxb8Qkp+B5fNRjOApOSdGc0DlUXNezS6aHNNkxf6Vvr6JXjh9oK
X-Received: by 2002:a17:902:d510:b0:20c:8ffa:7dd with SMTP id d9443c01a7336-211d0ec3017mr84205205ad.11.1731990329213;
        Mon, 18 Nov 2024 20:25:29 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-212536a5ab7sm212365ad.108.2024.11.18.20.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:25:29 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BCD93340748;
	Mon, 18 Nov 2024 21:25:28 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B3195E428AF; Mon, 18 Nov 2024 21:24:58 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
Date: Mon, 18 Nov 2024 21:24:44 -0700
Message-ID: <20241119042448.2473694-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The priv field in mlx5_core_cq's tasklet_ctx struct points to the
mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_cq
already stores a pointer to the EQ. Use this eq pointer to get a pointer
to the tasklet_ctx with no additional pointer dereferences and no void *
casts. Remove the now unused priv field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 ++---
 include/linux/mlx5/cq.h                      | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 1fd403713baf..dc5a291f0993 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -68,11 +68,11 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 
 static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 				   struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
-	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
+	struct mlx5_eq_tasklet *tasklet_ctx = &cq->eq->tasklet_ctx;
 	bool schedule_tasklet = false;
 
 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
 	/* When migrating CQs between EQs will be implemented, please note
 	 * that you need to sync this point. It is possible that
@@ -117,18 +117,17 @@ int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		return err;
 
 	cq->cqn = MLX5_GET(create_cq_out, out, cqn);
 	cq->cons_index = 0;
 	cq->arm_sn     = 0;
+	/* assuming CQ will be deleted before the EQ */
 	cq->eq         = eq;
 	cq->uid = MLX5_GET(create_cq_in, in, uid);
 	refcount_set(&cq->refcount, 1);
 	init_completion(&cq->free);
 	if (!cq->comp)
 		cq->comp = mlx5_add_cq_to_tasklet;
-	/* assuming CQ will be deleted before the EQ */
-	cq->tasklet_ctx.priv = &eq->tasklet_ctx;
 	INIT_LIST_HEAD(&cq->tasklet_ctx.list);
 
 	/* Add to comp EQ CQ tree to recv comp events */
 	err = mlx5_eq_add_cq(&eq->core, cq);
 	if (err)
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index 991526039ccb..cd034ea0ee34 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -53,11 +53,10 @@ struct mlx5_core_cq {
 	struct mlx5_rsc_debug	*dbg;
 	int			pid;
 	struct {
 		struct list_head list;
 		void (*comp)(struct mlx5_core_cq *cq, struct mlx5_eqe *eqe);
-		void		*priv;
 	} tasklet_ctx;
 	int			reset_notify_added;
 	struct list_head	reset_notify;
 	struct mlx5_eq_comp	*eq;
 	u16 uid;
-- 
2.45.2


