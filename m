Return-Path: <netdev+bounces-53785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6638049E2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6A21F21510
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726E15EB7;
	Tue,  5 Dec 2023 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn9mTBcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81815EAE
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE93BC433C9;
	Tue,  5 Dec 2023 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756831;
	bh=8O9wDMP14dZCYHfHI0CG1sDkCxt6e7Gh27bn5wxi/UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nn9mTBcMW5tfrcO0Gp/QBqsa6cBzl1sVF2OVMwFHmLRgGMfAytFyu2rp5ioRI/zic
	 +z1YWiXB1oRQm4YQZ7V8xbhqGwsCSU/LHYQyP5y8uV8qVz7IOvjym5C+/KeSil0ou+
	 wwCnpGvinS4ay642SsT8MOf0dBuXkNMsB9BRhWwlHtwDLtYVpLvSI+MxhDsVk/pzDB
	 abJL+l386jpbz6P0JX2ASD/d03hgShfsWXNFnO4o/qSqP+dvrFVP5pCT8f5W+ht/I1
	 nnxV9TNcR7v7qUxsafNleVe1MoksbquiJ+qwcvQrexMSBFNB5v87pcei5sYx3NpQdk
	 IU6WgGcPjmUsA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net V2 12/14] net/mlx5: Nack sync reset request when HotPlug is enabled
Date: Mon,  4 Dec 2023 22:13:25 -0800
Message-ID: <20231205061327.44638-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205061327.44638-1-saeed@kernel.org>
References: <20231205061327.44638-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Current sync reset flow is not supported when PCIe bridge connected
directly to mlx5 device has HotPlug interrupt enabled and can be
triggered on link state change event. Return nack on reset request in
such case.

Fixes: 92501fa6e421 ("net/mlx5: Ack on sync_reset_request only if PF can do reset_now")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index b568988e92e3..c4e19d627da2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -325,6 +325,29 @@ static void mlx5_fw_live_patch_event(struct work_struct *work)
 		mlx5_core_err(dev, "Failed to reload FW tracer\n");
 }
 
+#if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
+static int mlx5_check_hotplug_interrupt(struct mlx5_core_dev *dev)
+{
+	struct pci_dev *bridge = dev->pdev->bus->self;
+	u16 reg16;
+	int err;
+
+	if (!bridge)
+		return -EOPNOTSUPP;
+
+	err = pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &reg16);
+	if (err)
+		return err;
+
+	if ((reg16 & PCI_EXP_SLTCTL_HPIE) && (reg16 & PCI_EXP_SLTCTL_DLLSCE)) {
+		mlx5_core_warn(dev, "FW reset is not supported as HotPlug is enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+#endif
+
 static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 {
 	struct pci_bus *bridge_bus = dev->pdev->bus;
@@ -357,6 +380,12 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev)
 		return false;
 	}
 
+#if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
+	err = mlx5_check_hotplug_interrupt(dev);
+	if (err)
+		return false;
+#endif
+
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
 	if (err)
 		return false;
-- 
2.43.0


