Return-Path: <netdev+bounces-15605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B8748B22
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AD5280E9E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5E1428F;
	Wed,  5 Jul 2023 17:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C61429D
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBEC433C9;
	Wed,  5 Jul 2023 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579900;
	bh=z6Qr0atJAKZIac7+ZFFKMXvnWmEQCMoGEElWl+5q/eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lW9186j1Wdef3LjAp9iMHRV2//1yjls3vJ1aApnuXIJvbQrNEJqqZbRVKvZHyNqIS
	 EzO8+Jr9MI7AFfEkqL7B0ktvjefPTmrPJQwYcQ+tQo1R+0WqUIQi8R8/cTE/62pINd
	 PBzuxvrNplkklbtzW0Uuirsomb3mTHe/2F812hOTjHjEdCKGaXcXPwbSCvtVm78V12
	 ZZy1MmUMwxoXpjw47dORi9ZJoj+uQZ1w7LXoWAcDKNv40283Ar2bky7U9gIVXjDJmU
	 fP/Y8ojYw8wo83CwY3u6p8VFqOdkfJyyU7st29Jk1obfm1P+U8X2jGivPyJsKnC7WD
	 g6LM3iIP3r6xA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Sandipan Patra <spatra@nvidia.com>
Subject: [net V2 5/9] net/mlx5: Register a unique thermal zone per device
Date: Wed,  5 Jul 2023 10:57:53 -0700
Message-ID: <20230705175757.284614-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705175757.284614-1-saeed@kernel.org>
References: <20230705175757.284614-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Prior to this patch only one "mlx5" thermal zone could have been
registered regardless of the number of individual mlx5 devices in the
system.

To fix this setup a unique name per device to register its own thermal
zone.

In order to not register a thermal zone for a virtual device (VF/SF) add
a check for PF device type.

The new name is a concatenation between "mlx5_" and "<PCI_DEV_BDF>", which
will also help associating a thermal zone with its PCI device.

$ lspci | grep ConnectX
00:04.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
00:05.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]

$ cat /sys/devices/virtual/thermal/thermal_zone0/type
mlx5_0000:00:04.0
$ cat /sys/devices/virtual/thermal/thermal_zone1/type
mlx5_0000:00:05.0

Fixes: c1fef618d611 ("net/mlx5: Implement thermal zone")
CC: Sandipan Patra <spatra@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/thermal.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
index 20bb5eb266c1..52199d39657e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
@@ -68,14 +68,19 @@ static struct thermal_zone_device_ops mlx5_thermal_ops = {
 
 int mlx5_thermal_init(struct mlx5_core_dev *mdev)
 {
+	char data[THERMAL_NAME_LENGTH];
 	struct mlx5_thermal *thermal;
-	struct thermal_zone_device *tzd;
-	const char *data = "mlx5";
+	int err;
 
-	tzd = thermal_zone_get_zone_by_name(data);
-	if (!IS_ERR(tzd))
+	if (!mlx5_core_is_pf(mdev) && !mlx5_core_is_ecpf(mdev))
 		return 0;
 
+	err = snprintf(data, sizeof(data), "mlx5_%s", dev_name(mdev->device));
+	if (err < 0 || err >= sizeof(data)) {
+		mlx5_core_err(mdev, "Failed to setup thermal zone name, %d\n", err);
+		return -EINVAL;
+	}
+
 	thermal = kzalloc(sizeof(*thermal), GFP_KERNEL);
 	if (!thermal)
 		return -ENOMEM;
@@ -89,10 +94,10 @@ int mlx5_thermal_init(struct mlx5_core_dev *mdev)
 								 &mlx5_thermal_ops,
 								 NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
 	if (IS_ERR(thermal->tzdev)) {
-		dev_err(mdev->device, "Failed to register thermal zone device (%s) %ld\n",
-			data, PTR_ERR(thermal->tzdev));
+		err = PTR_ERR(thermal->tzdev);
+		mlx5_core_err(mdev, "Failed to register thermal zone device (%s) %d\n", data, err);
 		kfree(thermal);
-		return -EINVAL;
+		return err;
 	}
 
 	mdev->thermal = thermal;
-- 
2.41.0


