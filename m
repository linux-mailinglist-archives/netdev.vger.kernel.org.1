Return-Path: <netdev+bounces-138403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533939AD5CB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7434A1C21739
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E121D041B;
	Wed, 23 Oct 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z66+ohz6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B213AA2B
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716704; cv=none; b=ealeLWPFdqENHSKWqXs/jXiKl21+Rwz8mSncLo2hb17C9eJAr5GWj1KJ0v0yAKC9gpDZSGC2Fq1r5q4D6vtFdav59SeIjTP8D00cEqFPaXSX18wfgi8Qz1qgjhCVRhbx5Z9qFmsOgYYIjEam2RFWUfjYmZIWAWZ3okEsLl7G3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716704; c=relaxed/simple;
	bh=K44ATCiMDHxMTMJcyBAwfGkIfgGnFaUTSMZ5dOBioco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSmHk4a9lQnlN5I9T7iLxnnLxn0np5so/pWnRh2X+e1PCBSbBs27JSt55aEngTjZ9SYYv8EIAbrf4hOLxopW8bd9veYCqLe5BolCQojK82WBBt32BZ7idOFGskolOUDt6F23RBJwfH44lNcGm8WXV1qxLTXEt+3Ns2GU15xDruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z66+ohz6; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso39099a91.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729716702; x=1730321502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCyXfoKZLYIrM6bHNOmey4+JbsNLY/BGPRNE02WxQwo=;
        b=Z66+ohz6/PuKBA4Cw1XCx8sMFctDfz66PzgpeffsEO3CzcUL9ZkvouWpft+AHyiX7F
         WuLVkaGqWI+opb2qABPmJHWUwqIYam3XtOhZha+E9Bky+c89a+l7+ePXIW0iZx5sJ9hL
         /LLEDDA5D5td8ppzDr4XLaJJeAq0P67HS/dJazSTASsQH6KN2Dp042ctaXgsHXGN1ioP
         EMKrsZvzlPLwSmjqNA/aGtTFD0Z5mIfX6N5mmfJiwb9RCZyak4N5teZ5kOI6hj67hCb+
         /oZEtVUV3kqej9ga7M5jki2LzyaSe1ai22s5PskBd0KmuXEjb8tt5lL+Za5m1eclkT3G
         oL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716702; x=1730321502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCyXfoKZLYIrM6bHNOmey4+JbsNLY/BGPRNE02WxQwo=;
        b=RWzNLjK7AWCndSvofhh91pX24G7zN6LcZkhqPuXJMmIkfvOqEB6Ebgn7LbcSigxiuk
         RjBb048zJIN6f1B2YNwC097t3VK1MAbESloMTtZitfthnYhEDbQYJ8bj8qHxqaKOyhF3
         gmA3OVGYIgb7TewvcDz5QIi3giWyZkA7m2/wIWBsaiO4OdQrIgg/fxu03TbMXM1RFVCZ
         2xTBujnsZhbDHuQevQZi5v+3QkbRkRNSIxnh2wA0FNAa0WiJWUdGTbS0IeFFdhD5bO79
         RVjiS3K8M79ozkdpbditmpoxTQygcPCylU1OnmHh5Th8SC3BYKuLzDzhXRaiJ4x64fAi
         FApQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJRYuYUBksjApYUiaxFfEMigJ+fTIiwJaHl28bLytP2U7oXsyqDG2awCf6wGP3Uibg14cvRwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHP/k1dGnDgnl9Wb4FaY4O/9fn8UBn9FE6Ece/0GRnGT/tHrf4
	gyRda3eMaw1h8VruFFe9s0jQL+cJrpL/lbiWLuOWwUeYPzbEt+uoJ/B6izbmDBXH9NHmabdDxrb
	B8I0f6qFda00chmo0KH8xD4n14ECmTi9N4zTpJ33aItTw1lBu
X-Google-Smtp-Source: AGHT+IG35rzOCpF6xzICIlXnd2xKWIdeRqdxmgfplqytKRI7gARk7EO/TkF1EVCs0mtdYwpJbkfTYQSa4jYI
X-Received: by 2002:a17:903:32cc:b0:20c:85dc:6630 with SMTP id d9443c01a7336-20fa9deb651mr23890985ad.1.1729716701633;
        Wed, 23 Oct 2024 13:51:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-20e7f0dd5c7sm2620325ad.54.2024.10.23.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:51:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3B88D3400B6;
	Wed, 23 Oct 2024 14:51:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2D9E7E40BE0; Wed, 23 Oct 2024 14:51:40 -0600 (MDT)
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
Subject: [PATCH] mlx5: simplify EQ interrupt polling logic
Date: Wed, 23 Oct 2024 14:51:12 -0600
Message-ID: <20241023205113.255866-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a while loop in mlx5_eq_comp_int() and mlx5_eq_async_int() to
clarify the EQE polling logic. This consolidates the next_eqe_sw() calls
for the first and subequent iterations. It also avoids a goto. Turn the
num_eqes < MLX5_EQ_POLLING_BUDGET check into a break condition.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 22 +++++++-------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 68cb86b37e56..859dcf09b770 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -114,15 +114,11 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 	struct mlx5_eq *eq = &eq_comp->core;
 	struct mlx5_eqe *eqe;
 	int num_eqes = 0;
 	u32 cqn = -1;
 
-	eqe = next_eqe_sw(eq);
-	if (!eqe)
-		goto out;
-
-	do {
+	while ((eqe = next_eqe_sw(eq))) {
 		struct mlx5_core_cq *cq;
 
 		/* Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
@@ -140,13 +136,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
 					    "Completion event for bogus CQ 0x%x\n", cqn);
 		}
 
 		++eq->cons_index;
 
-	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
+		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
+			break;
+	}
 
-out:
 	eq_update_ci(eq, 1);
 
 	if (cqn != -1)
 		tasklet_schedule(&eq_comp->tasklet_ctx.task);
 
@@ -213,15 +210,11 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
 	eqt = dev->priv.eq_table;
 
 	recovery = action == ASYNC_EQ_RECOVER;
 	mlx5_eq_async_int_lock(eq_async, recovery, &flags);
 
-	eqe = next_eqe_sw(eq);
-	if (!eqe)
-		goto out;
-
-	do {
+	while ((eqe = next_eqe_sw(eq))) {
 		/*
 		 * Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
 		 */
 		dma_rmb();
@@ -229,13 +222,14 @@ static int mlx5_eq_async_int(struct notifier_block *nb,
 		atomic_notifier_call_chain(&eqt->nh[eqe->type], eqe->type, eqe);
 		atomic_notifier_call_chain(&eqt->nh[MLX5_EVENT_TYPE_NOTIFY_ANY], eqe->type, eqe);
 
 		++eq->cons_index;
 
-	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe = next_eqe_sw(eq)));
+		if (++num_eqes >= MLX5_EQ_POLLING_BUDGET)
+			break;
+	}
 
-out:
 	eq_update_ci(eq, 1);
 	mlx5_eq_async_int_unlock(eq_async, recovery, &flags);
 
 	return unlikely(recovery) ? num_eqes : 0;
 }
-- 
2.45.2


