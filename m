Return-Path: <netdev+bounces-127554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2379975B93
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E5B216A8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D11BC9E4;
	Wed, 11 Sep 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0zyng9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FC1BC08C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085890; cv=none; b=fKWu1JHLnW3EufUHS71C+Lxqv/0MVykbgQvD87q04MpnKSeIZu6w6I049rrxi2FSnVrI46R3kX0ZBnHY5/ggFouM7jNYgtu9TP+6vma6fv9EHX2lEx+1jrYeGDzGeMYktBDBXyReLKcYEwHgAr99t8YDI36hQoBiqaAh/BUJRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085890; c=relaxed/simple;
	bh=jMILBPjBT7Ny8/R1MNZowwNPK2ZFV+S752tvdK7v87o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb+jbiGGXd6Twfv3YBioDsH5YtpiH8CrQdNXUc36peIuNfbIaOn9nBPxMSV4BZphzagC3OxveiA0tkigUz2skMkXH1ifbNtkDBTayoC8B4Ji9WeTfRIGQjeHaC2oG2X8M+DsT16OHGIqmggDJqgXJjlgja3ba2glnpCaEdnk4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0zyng9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B802C4CEC6;
	Wed, 11 Sep 2024 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085890;
	bh=jMILBPjBT7Ny8/R1MNZowwNPK2ZFV+S752tvdK7v87o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0zyng9lcp7654OfV3M+wP5Kmi3Ktn4H4/SNa/G2++tc2HtNp353KJ6O1s3uVK6AB
	 zDfu3OmgDziHHZdvUGzwKLWZK6ybEdBGlZ+rajSTX1OQiCo+ZM0hPorTHJ4yYIAObk
	 Sull/P6Q5KD4oEKZ5L8N9lGsvWO4AoKBoxl1uDPbap2/YcovKyK89cdW+L79p/aF3v
	 skK03lToNYHo/Ym0nvqjXVvQb//ghMZG922tCIIRtOeIym7ZW1WlosNCwpN79dEXsc
	 rj7GfSRhJRIKh0kVF8oOFC8kdEAwdpflpVQ1xXoHu3CXh5mJQ5mx+NoqkgO+t9aziw
	 dMFVw3wr2CKzg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 11/15] net/mlx5: Skip HotPlug check on sync reset using hot reset
Date: Wed, 11 Sep 2024 13:17:53 -0700
Message-ID: <20240911201757.1505453-12-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Sync reset request is nacked by the driver when PCIe bridge connected to
mlx5 device has HotPlug interrupt enabled. However, when using reset
method of hot reset this check can be skipped as Hotplug is supported on
this reset method.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index bda74cb9c975..4f55e55ecb55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -412,7 +412,8 @@ static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 	return 0;
 }
 
-static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev)
+static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
+				      u8 reset_method)
 {
 	u16 dev_id;
 	int err;
@@ -423,9 +424,11 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev)
 	}
 
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
-	err = mlx5_check_hotplug_interrupt(dev);
-	if (err)
-		return false;
+	if (reset_method != MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET) {
+		err = mlx5_check_hotplug_interrupt(dev);
+		if (err)
+			return false;
+	}
 #endif
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
@@ -446,7 +449,7 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
 		mlx5_core_warn(dev, "Failed reading MFRL, err %d\n", err);
 
 	if (err || test_bit(MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST, &fw_reset->reset_flags) ||
-	    !mlx5_is_reset_now_capable(dev)) {
+	    !mlx5_is_reset_now_capable(dev, fw_reset->reset_method)) {
 		err = mlx5_fw_reset_set_reset_sync_nack(dev);
 		mlx5_core_warn(dev, "PCI Sync FW Update Reset Nack %s",
 			       err ? "Failed" : "Sent");
-- 
2.46.0


