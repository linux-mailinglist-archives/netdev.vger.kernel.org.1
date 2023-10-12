Return-Path: <netdev+bounces-40440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B87C76B5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA15282B1F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB43B2AD;
	Thu, 12 Oct 2023 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjjW2zWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BD3B2AB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32D6C433C9;
	Thu, 12 Oct 2023 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138877;
	bh=UyUC69GfkyVLY7/Svj/h6B3iCboQ5qEHCOxtrgMhtMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjjW2zWdmmRRrn1NATN6OTET1hlVonfEZdFZjYsP3BrQt1I2wDhBlKs8dmVFGoeLa
	 vXo/LXNtnha/CR+OVlqR4OC7zlSiN2BmjgpeV20FhFHRY52j84MyGrKCqmqAkxROhM
	 xDGbgCHJUlFuBGL1hr3ZtXHo21+q61rgpswTMe1hzkxHS2/rMCnhRiMw4ozDK72Uqy
	 3LFCn3HZOmsD9J/oPcDf4y/jbfdSChLhe1iYabH2bE4MiyV1dM3fPGnrr2M9O4LzB3
	 KBO3HQ3c5QoCobyb4qn04hso25YKx8jDzv2qy+VSP4coNJjCMlDOMLs50r+HecVrZh
	 YVvU5ktGmdfRg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next V2 03/15] net/mlx5: Avoid false positive lockdep warning by adding lock_class_key
Date: Thu, 12 Oct 2023 12:27:38 -0700
Message-ID: <20231012192750.124945-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
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


