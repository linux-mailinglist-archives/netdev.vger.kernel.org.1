Return-Path: <netdev+bounces-57186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79B81250A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5480B1F21A59
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77CB803;
	Thu, 14 Dec 2023 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5ArYq77"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1C6110
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C5EC433CC;
	Thu, 14 Dec 2023 02:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519729;
	bh=09QQY7G0UQ1opB2nOU0ndukHDhP/0QK0bPUOMMnu8Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5ArYq77xZtf+6/YN0EsbZknXCZkxa5ku9UzfCQXxlcxnYyxAcOQNxSq3OGD34V1b
	 nsO171AzE/pvGFO2qB5tt6yTWtYneOTHRZcou9/gD5jHfmaD6/zdKuEY6vPKtYemex
	 ebI3uNxN8uHWRBM1SBGmVFrSMFF1AaH+j9ju9FlPPQQ93I+gLoMAmSCHufuJLFSQ0B
	 E3sW2xUheHK8YoWy2UXMk5V0fpUbWTgg8UxSZc0vBoR4xvaplsNj2KBR5EKBX8jjFr
	 rniyNgh8EUj4qid8nEJFcey13FCfALpM4veSQfgELntPYUZCg2bjuc7CAF54X9TFzC
	 GOlbdnHTQDFpw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 10/11] net/mlx5: devcom, Add component size getter
Date: Wed, 13 Dec 2023 18:08:31 -0800
Message-ID: <20231214020832.50703-11-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add a getter for the number of participants in a devcom
component (those who share the same component id and key).

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 7 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index e8e50563e956..e7d59cfa8708 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -256,6 +256,13 @@ void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom)
 		devcom_free_comp_dev(devcom);
 }
 
+int mlx5_devcom_comp_get_size(struct mlx5_devcom_comp_dev *devcom)
+{
+	struct mlx5_devcom_comp *comp = devcom->comp;
+
+	return kref_read(&comp->ref);
+}
+
 int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 			   int event, int rollback_event,
 			   void *event_data)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index fc23bbef87b4..ec32b686f586 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -31,6 +31,7 @@ void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
 int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 			   int event, int rollback_event,
 			   void *event_data);
+int mlx5_devcom_comp_get_size(struct mlx5_devcom_comp_dev *devcom);
 
 void mlx5_devcom_comp_set_ready(struct mlx5_devcom_comp_dev *devcom, bool ready);
 bool mlx5_devcom_comp_is_ready(struct mlx5_devcom_comp_dev *devcom);
-- 
2.43.0


