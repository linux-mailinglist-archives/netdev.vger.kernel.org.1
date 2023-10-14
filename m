Return-Path: <netdev+bounces-41015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5D7C959F
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D71C20AED
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D821374;
	Sat, 14 Oct 2023 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjkPn7AU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966321105
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5241C433C7;
	Sat, 14 Oct 2023 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303966;
	bh=V2B8wLwmm6AK+umUBZiqDKiSGK6UBpXnqwzxNxdmJag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjkPn7AUdshLYpCWNjMA8Hx58B/FwTh5Xhmj3DXVVl4XPap4EAPWO0pLbUB402OQE
	 qP8KmA3d36fiYvGOrsPvu95L6Ma5MXpvfUT+CUtfmIihOcYITBdg7kyGe9L/zhVjOG
	 0weMb8W5ZUfb0hyFwFTEHeGKuWSR1ntmGBh/ahZiLxhHs64T2ZS6LWhyINnjOIPttV
	 scR+Vf3ITvjo1F745Q3gcxMUWyPCR0obtX69pPhS7KmrGgFLH7Cp9kHtZ7sZxx1LHG
	 z5jbdxKr7d6p5D5yKuZQpvIpMd5ja4ttCeTUMGt+NKgJlk6hQKqO7xTpeRfnSyATtu
	 gAvKjm2KinHMQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 03/15] net/mlx5: Avoid false positive lockdep warning by adding lock_class_key
Date: Sat, 14 Oct 2023 10:18:56 -0700
Message-ID: <20231014171908.290428-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Downstream patch will add devcom component which will be locked in
many places. This can lead to a false positive "possible circular
locking dependency" warning by lockdep, on flows which lock more than
one mlx5 devcom component, such as probing ETH aux device.
Hence, add a lock_class_key per mlx5 device.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 00e67910e3ee..89ac3209277e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -31,6 +31,7 @@ struct mlx5_devcom_comp {
 	struct kref ref;
 	bool ready;
 	struct rw_semaphore sem;
+	struct lock_class_key lock_key;
 };
 
 struct mlx5_devcom_comp_dev {
@@ -119,6 +120,8 @@ mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
 	comp->key = key;
 	comp->handler = handler;
 	init_rwsem(&comp->sem);
+	lockdep_register_key(&comp->lock_key);
+	lockdep_set_class(&comp->sem, &comp->lock_key);
 	kref_init(&comp->ref);
 	INIT_LIST_HEAD(&comp->comp_dev_list_head);
 
@@ -133,6 +136,7 @@ mlx5_devcom_comp_release(struct kref *ref)
 	mutex_lock(&comp_list_lock);
 	list_del(&comp->comp_list);
 	mutex_unlock(&comp_list_lock);
+	lockdep_unregister_key(&comp->lock_key);
 	kfree(comp);
 }
 
-- 
2.41.0


