Return-Path: <netdev+bounces-140509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8D9B6AA9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD6F2815AD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684F216423;
	Wed, 30 Oct 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JawHfHZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16762170B3
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308043; cv=none; b=l1eroZFVsQbh0agsYjm3ZzIKjdFnOmUlmYf/waB+VYExGqbqMgbseoqgKQ1ZlUSt02yx1RKBVwGhWDK4aW3c7GG6LhLYqejec2OkfFrJecm+DIIL/dNVJpGwpdZtDWGAMdZlMC5OLT+k2VvY9AIIF8HoIIGMzucOUyaFAxFIoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308043; c=relaxed/simple;
	bh=sscV9c36s+nmYEYc5d7ETnwRVHtNENWYWlf4AeFX+zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi/0R84YmCyGW4SiEGcex48pY9Wr/4F5Xa6EWqelxuqHhHUhU2xi4k2Hk3ATjU/vBZoIbBXnncgW0kHJQxDUD2uzCG9kIl1T7Yu1D5dduDE5U56/AnyjKrNnomePs143QKA2LWc//wbYZVOMfkhBm9D/wh6TJGLqvokdkA9dPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JawHfHZc; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-28889dcca4dso8009fac.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730308038; x=1730912838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbWXoubdOFjc0J90dYCjMPhouSyIa4++HhnBIkRskoA=;
        b=JawHfHZcTtKnyld/0z2+jIuBs8ajmXjoINzJSbI48EB1V2zKpWLSYKoG24eMwq1Pxh
         pmo/efce7ublymZepZ5Yp+W5Bi86wC3luMNzEW0SQAnsbm50AkEPpW/9517u+YGB3QVH
         lXk1+o2f99JwpHqeTNm+ltg+PU+MmXRKkyQp7dJ7cDt14mq40AJryBwhdPEIxad1LMBs
         dg0HUNDshOFrpOMkqnsavyZ465zqWKGNlFYEMzc04+LWcq0Ll3E8KOaaSr6OU6rWoFuR
         K/6OhHzdbD5Ne2psH/DSsG/RaiYtQvUdgb1pdzWS6ZLeQ79gvj0mXOD+gXD1FZJZiXbD
         fNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308038; x=1730912838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbWXoubdOFjc0J90dYCjMPhouSyIa4++HhnBIkRskoA=;
        b=iJsCTpRoFgcX3qoTu1aJu9Yg07fhWbSKtBHbB31SlwMgY/K14WRPqjlVugh6mgwQtv
         DjPg3zjCYMHuSdcws3E4PLbD5WOqSQ8zPn5zjbkWkUQyJXR9B4xN7X3bDwp0mYo1Fr0W
         jukLnkfEgALDWOWKg/Zv3M3+cHzcbhlr10ZTql1Bdk2E9AhW4tfi9vAbUCevBiltnV3C
         i5odeaWlC3o+6RSMTiHy53cIlB5ZjDPHgoDSWC2s8Y0d7i3NzedMryMonwg/zsz/m+xQ
         QSx+OtPm4iq1ZXrH46GHdxKTUKw81LMxu7PcvpA2WWBHgE+XyJK3QllnWhMlkFKW3MZT
         PjjA==
X-Forwarded-Encrypted: i=1; AJvYcCV52q/4Q31lpiFMEqkZ6Xiv0/Md0DzdrpYV8cBERjPo+jbVpBJGv/fJ0qbUZG0otGTH5+G4cxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzs/9FN+SgFlSBo3EwL5sIR9mO9XLNC3RFTcgjVvN1rA3mj2un
	8+EYV9QgMCbAr4OMOEShWJ4JoYt3lQ5lipzACqKcw4ASCet3QOtnsIa46bKGhFsKO5Z+7zGl+Ka
	TBCCB13X23+yCekyOglW7Y+9D/vBpbFtts4r4zjY1+wW+esIh
X-Google-Smtp-Source: AGHT+IFZ1ja9hOm6xMDtpK+g/fuGzrKd8ri+RB3+ls3i5NMQT1baHJAWIH9aQoyhyCOGJDr0RPF9+sujZcx7
X-Received: by 2002:a05:6870:b513:b0:27b:56b1:9ded with SMTP id 586e51a60fabf-29051b6d026mr4285823fac.5.1730308038088;
        Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29035d10eccsm264258fac.2.2024.10.30.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:07:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DF5EC3406B0;
	Wed, 30 Oct 2024 11:07:16 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D28C1E40BBB; Wed, 30 Oct 2024 11:06:46 -0600 (MDT)
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
	Parav Pandit <parav@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mlx5: only schedule EQ comp tasklet if necessary
Date: Wed, 30 Oct 2024 11:06:18 -0600
Message-ID: <20241030170619.3126428-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CY8PR12MB7195672F740581A045ADBF8CDC542@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <CY8PR12MB7195672F740581A045ADBF8CDC542@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
whose completions don't need to be processed in tasklet context, this
adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
time spent on the tasklet_trylock() in tasklet_action_common(), with a
smaller amount spent on the atomic operations in tasklet_schedule(),
tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
TCP completions are handled by mlx5e_completion_event(), which schedules
NAPI to poll the queue, so they don't need tasklet processing.

Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
to be processed in tasklet context, so it can schedule the tasklet. CQs
that need tasklet processing have their interrupt comp handler set to
mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
don't need tasklet processing won't schedule the tasklet. To avoid
scheduling the tasklet multiple times during the same interrupt, only
schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
queue was empty before the new CQ was pushed to it.

The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
may add a small cost for the userspace Infiniband CQs whose completions
are processed in tasklet context. But this seems worth it to avoid the
tasklet overhead for CQs that don't need it.

Note that the mlx4 driver works the same way: it schedules the tasklet
in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
index 4caa1b6f40ba..25f3b26db729 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
@@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
 static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
 				   struct mlx5_eqe *eqe)
 {
 	unsigned long flags;
 	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
+	bool schedule_tasklet = false;
 
 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
 	/* When migrating CQs between EQs will be implemented, please note
 	 * that you need to sync this point. It is possible that
 	 * while migrating a CQ, completions on the old EQs could
 	 * still arrive.
 	 */
 	if (list_empty_careful(&cq->tasklet_ctx.list)) {
 		mlx5_cq_hold(cq);
+		schedule_tasklet = list_empty(&tasklet_ctx->list);
 		list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
 	}
 	spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
+
+	if (schedule_tasklet)
+		tasklet_schedule(&tasklet_ctx->task);
 }
 
 /* Callers must verify outbox status in case of err */
 int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 		   u32 *in, int inlen, u32 *out, int outlen)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 859dcf09b770..3fd2091c11c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -112,14 +112,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq_comp *eq_comp =
 		container_of(nb, struct mlx5_eq_comp, irq_nb);
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
-	u32 cqn = -1;
 
 	while ((eqe = next_eqe_sw(eq))) {
 		struct mlx5_core_cq *cq;
+		u32 cqn;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
@@ -142,13 +142,10 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 			break;
 	}
 
 	eq_update_ci(eq, 1);
 
-	if (cqn != -1)
-		tasklet_schedule(&eq_comp->tasklet_ctx.task);
-
 	return 0;
 }
 
 /* Some architectures don't latch interrupts when they are disabled, so using
  * mlx5_eq_poll_irq_disabled could end up losing interrupts while trying to
-- 
2.45.2


