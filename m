Return-Path: <netdev+bounces-42866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4841B7D06C0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93546B2148F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410B1FB0;
	Fri, 20 Oct 2023 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUQ891g1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCEC13B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F7C433C9;
	Fri, 20 Oct 2023 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771089;
	bh=R8wuU+UMidG/UrbMWjmaWSPZEk6sJ4s4Fy3AJN0wLjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUQ891g1rvJROPVMqtRDGsXev4qIo1vuD/TTLKAeiH4I7McUp8ZEjRA2Joh8D3NBX
	 B/X5sUsOxUQE213f+QVKX0ouKSzKUcff7jnVj9+LjvtntOQoovx0wnOnRSIVcFu+lW
	 3RRIYO1hWzTwWos+SOZU1wpD4HH5GsUX+iFS0x7QR7mWlC0xvF6XW00XeW1PX7HVDB
	 UNwCbNAGFxbuTU0Maa6QaGu2CtNO9VqyTwnMIyoLZtXPYKYmnfeF/jqw4y9JyB/YRH
	 HpVryO97l7PgXEJKi6fOyniuYZHImYHI30zoX9E21Gy5v8xUskgSP662ytob4PzsIG
	 x5YUnZ8WQ4CJA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 15/15] net/mlx5: Allow sync reset flow when BF MGT interface device is present
Date: Thu, 19 Oct 2023 20:04:22 -0700
Message-ID: <20231020030422.67049-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

In sync reset flow, PF is checking that only devices of same device ID
as itself present on the PCIe bridge, otherwise it will NACK the reset.
Since the PCIe bridge connection to NIC card has to be 1 to 1, this is
valid.

However, the BlueField device may also expose another sub-device to the
PCI called management interface, which only provides an ethernet channel
between the host and the smart NIC.

Allow sync reset flow also when management interface sub-device present
when checking devices on the PCIe bridge.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index b568988e92e3..4b8cb120362b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -325,6 +325,25 @@ static void mlx5_fw_live_patch_event(struct work_struct *work)
 		mlx5_core_err(dev, "Failed to reload FW tracer\n");
 }
 
+static const struct pci_device_id mgt_ifc_device_ids[] = {
+	{ PCI_VDEVICE(MELLANOX, 0xc2d2) }, /* BlueField1 MGT interface device ID */
+	{ PCI_VDEVICE(MELLANOX, 0xc2d3) }, /* BlueField2 MGT interface device ID */
+	{ PCI_VDEVICE(MELLANOX, 0xc2d4) }, /* BlueField3-Lx MGT interface device ID */
+	{ PCI_VDEVICE(MELLANOX, 0xc2d5) }, /* BlueField3 MGT interface device ID */
+	{ PCI_VDEVICE(MELLANOX, 0xc2d6) }, /* BlueField4 MGT interface device ID */
+};
+
+static bool mlx5_is_mgt_ifc_pci_device(struct mlx5_core_dev *dev, u16 dev_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mgt_ifc_device_ids); ++i)
+		if (mgt_ifc_device_ids[i].device == dev_id)
+			return true;
+
+	return false;
+}
+
 static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 {
 	struct pci_bus *bridge_bus = dev->pdev->bus;
@@ -339,10 +358,15 @@ static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 		err = pci_read_config_word(sdev, PCI_DEVICE_ID, &sdev_id);
 		if (err)
 			return pcibios_err_to_errno(err);
-		if (sdev_id != dev_id) {
-			mlx5_core_warn(dev, "unrecognized dev_id (0x%x)\n", sdev_id);
-			return -EPERM;
-		}
+
+		if (sdev_id == dev_id)
+			continue;
+
+		if (mlx5_is_mgt_ifc_pci_device(dev, sdev_id))
+			continue;
+
+		mlx5_core_warn(dev, "unrecognized dev_id (0x%x)\n", sdev_id);
+		return -EPERM;
 	}
 	return 0;
 }
-- 
2.41.0


