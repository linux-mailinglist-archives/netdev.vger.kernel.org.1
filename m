Return-Path: <netdev+bounces-224005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092CB7DF5E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA9A7B7D3F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4AE3074A4;
	Wed, 17 Sep 2025 12:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10F1EF38E;
	Wed, 17 Sep 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112673; cv=none; b=i1Hl9Kq28nMGwHY5b8VmOtvejtAdYICi84wtf0h+x5Low7F6MJHeE8l5M3cNsHgBTcdaXLe4HgG8ZSMZwKyQbW4UapxzsWym5DuJ/ZEevPnRho68MX2/qWh68TLjQuhWs/Ty4LmG0m7ZaRTMGQFdMoekkA3ZEsOef6UdxhOBUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112673; c=relaxed/simple;
	bh=BCDmmcCPqzRL4C0fKJUTiqPgsPHjAxc056gkFnWAOPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP8xMOiEKpxmYxVBUPQt3uWrgVeuLg4P99ZUUgauwfOKqtYrtC8JzotlORvT6sDPVC2yJ0xnJy98LRzuZxvRTN+m8f8T1I0QjhzrXAyVf3Np9DazcGfdf0sOOX2g8vmMT2DfTc30ImADDbzDxawh8S32N7eFNVq+1rONxVi2FVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cRdTf2078zFrpY;
	Wed, 17 Sep 2025 20:33:10 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D4ECD1402EA;
	Wed, 17 Sep 2025 20:37:47 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 20:37:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<huangdengdui@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 3/3] net: hns3: use user configure after hardware reset when using kernel PHY
Date: Wed, 17 Sep 2025 20:29:54 +0800
Message-ID: <20250917122954.1265844-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250917122954.1265844-1-shaojijie@huawei.com>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

When a reset occurring, it's supposed to recover user's configuration.
Consider the case that reset was happened consecutively. During the first
reset, the port info is configured with a temporary value cause the PHY
is reset and looking for best link config. Second reset start and use
previous configuration which is not the user's. Therefore, in this case,
the network port may not link up.

In this patch, saving user configure to req_xxx variable after successful
configuration when using kernel PHY or firmware PHY. And then, use the
req_xxx variable after hardware reset. Compared to the previous commit
"net: hns3: using user configure after hardware reset", it adds handling
for kernel PHY and FIBER.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  26 ++---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 110 +++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 +-
 3 files changed, 95 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d5454e126c85..f7ac84840a2f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -811,12 +811,11 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 }
 
 static int hns3_check_ksettings_param(const struct net_device *netdev,
-				      const struct ethtool_link_ksettings *cmd)
+				      const struct ethtool_link_ksettings *cmd,
+				      u8 media_type)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
-	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
-	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
 	u32 lane_num;
 	u8 autoneg;
 	u32 speed;
@@ -836,9 +835,6 @@ static int hns3_check_ksettings_param(const struct net_device *netdev,
 			return 0;
 	}
 
-	if (ops->get_media_type)
-		ops->get_media_type(handle, &media_type, &module_type);
-
 	if (cmd->base.duplex == DUPLEX_HALF &&
 	    media_type != HNAE3_MEDIA_TYPE_COPPER) {
 		netdev_err(netdev,
@@ -863,6 +859,8 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
 	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
+	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
+	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
 	int ret;
 
 	/* Chip don't support this mode. */
@@ -878,22 +876,20 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
 		  cmd->base.autoneg, cmd->base.speed, cmd->base.duplex,
 		  cmd->lanes);
 
-	/* Only support ksettings_set for netdev with phy attached for now */
-	if (netdev->phydev) {
-		if (cmd->base.speed == SPEED_1000 &&
-		    cmd->base.autoneg == AUTONEG_DISABLE)
-			return -EINVAL;
+	if (!ops->get_media_type)
+		return -EOPNOTSUPP;
+	ops->get_media_type(handle, &media_type, &module_type);
 
-		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
-	} else if (test_bit(HNAE3_DEV_SUPPORT_PHY_IMP_B, ae_dev->caps) &&
-		   ops->set_phy_link_ksettings) {
+	if (media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		if (!ops->set_phy_link_ksettings)
+			return -EOPNOTSUPP;
 		return ops->set_phy_link_ksettings(handle, cmd);
 	}
 
 	if (ae_dev->dev_version < HNAE3_DEVICE_VERSION_V2)
 		return -EOPNOTSUPP;
 
-	ret = hns3_check_ksettings_param(netdev, cmd);
+	ret = hns3_check_ksettings_param(netdev, cmd, media_type);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 85f07219b8be..50150f1cd79c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1574,7 +1574,6 @@ static int hclge_configure(struct hclge_dev *hdev)
 		return ret;
 	}
 	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
-	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
 	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
@@ -2684,6 +2683,7 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
 
 	if (!hdev->hw.mac.support_autoneg) {
 		if (enable) {
@@ -2695,7 +2695,10 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 		}
 	}
 
-	return hclge_set_autoneg_en(hdev, enable);
+	ret = hclge_set_autoneg_en(hdev, enable);
+	if (!ret)
+		hdev->hw.mac.req_autoneg = enable;
+	return ret;
 }
 
 static int hclge_get_autoneg(struct hnae3_handle *handle)
@@ -2957,20 +2960,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 
-	if (hdev->hw.mac.support_autoneg) {
-		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
-		if (ret)
-			return ret;
-	}
-
-	if (!hdev->hw.mac.autoneg) {
-		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
-						 hdev->hw.mac.req_duplex,
-						 hdev->hw.mac.lane_num);
-		if (ret)
-			return ret;
-	}
-
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
@@ -3358,8 +3347,8 @@ static int hclge_get_phy_link_ksettings(struct hnae3_handle *handle,
 }
 
 static int
-hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
-			     const struct ethtool_link_ksettings *cmd)
+hclge_ethtool_ksettings_set(struct hnae3_handle *handle,
+			    const struct ethtool_link_ksettings *cmd)
 {
 	struct hclge_desc desc[HCLGE_PHY_LINK_SETTING_BD_NUM];
 	struct hclge_vport *vport = hclge_get_vport(handle);
@@ -3369,12 +3358,6 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 	u32 advertising;
 	int ret;
 
-	if (cmd->base.autoneg == AUTONEG_DISABLE &&
-	    ((cmd->base.speed != SPEED_100 && cmd->base.speed != SPEED_10) ||
-	     (cmd->base.duplex != DUPLEX_HALF &&
-	      cmd->base.duplex != DUPLEX_FULL)))
-		return -EINVAL;
-
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_PHY_LINK_KSETTING,
 				   false);
 	desc[0].flag |= cpu_to_le16(HCLGE_COMM_CMD_FLAG_NEXT);
@@ -3394,6 +3377,33 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 	req1->master_slave_cfg = cmd->base.master_slave_cfg;
 
 	ret = hclge_cmd_send(&hdev->hw, desc, HCLGE_PHY_LINK_SETTING_BD_NUM);
+
+	if (!ret)
+		linkmode_copy(hdev->hw.mac.advertising,
+			      cmd->link_modes.advertising);
+
+	return ret;
+}
+
+static int
+hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
+			     const struct ethtool_link_ksettings *cmd)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	if (cmd->base.autoneg == AUTONEG_DISABLE &&
+	    ((cmd->base.speed != SPEED_100 && cmd->base.speed != SPEED_10) ||
+	     (cmd->base.duplex != DUPLEX_HALF &&
+	      cmd->base.duplex != DUPLEX_FULL)))
+		return -EINVAL;
+
+	if (hnae3_dev_phy_imp_supported(hdev))
+		ret = hclge_ethtool_ksettings_set(handle, cmd);
+	else
+		ret = phy_ethtool_ksettings_set(handle->netdev->phydev, cmd);
+
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to set phy link ksettings, ret = %d.\n", ret);
@@ -3401,9 +3411,10 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 	}
 
 	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
-	hdev->hw.mac.req_speed = cmd->base.speed;
-	hdev->hw.mac.req_duplex = cmd->base.duplex;
-	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
+	if (cmd->base.speed != SPEED_UNKNOWN)
+		hdev->hw.mac.req_speed = cmd->base.speed;
+	if (cmd->base.duplex != DUPLEX_UNKNOWN)
+		hdev->hw.mac.req_duplex = cmd->base.duplex;
 
 	return 0;
 }
@@ -11747,6 +11758,27 @@ static int hclge_set_wol(struct hnae3_handle *handle,
 	return ret;
 }
 
+static int hclge_set_autoneg_speed_dup(struct hclge_dev *hdev)
+{
+	int ret;
+
+	if (hdev->hw.mac.support_autoneg) {
+		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.req_autoneg);
+		if (ret)
+			return ret;
+	}
+
+	if (!hdev->hw.mac.req_autoneg) {
+		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
+						 hdev->hw.mac.req_duplex,
+						 hdev->hw.mac.lane_num);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 {
 	struct pci_dev *pdev = ae_dev->pdev;
@@ -11908,6 +11940,23 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
+	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER)
+		hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
+	else
+		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
+
+	/* When lane_num is 0, the firmware will automatically
+	 * select the appropriate lane_num based on the speed.
+	 */
+	hdev->hw.mac.lane_num = 0;
+
+	ret = hclge_set_autoneg_speed_dup(hdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set autoneg speed duplex, ret = %d\n", ret);
+		goto err_ptp_uninit;
+	}
+
 	INIT_KFIFO(hdev->mac_tnl_log);
 
 	hclge_dcb_ops_set(hdev);
@@ -12238,6 +12287,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	ret = hclge_set_autoneg_speed_dup(hdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to set autoneg speed duplex, ret = %d\n", ret);
+		return ret;
+	}
+
 	ret = hclge_tp_port_init(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init tp port, ret = %d\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 36f2b06fa17d..f650b07bc739 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -285,7 +285,7 @@ struct hclge_mac {
 	u8 duplex;
 	u8 duplex_last;
 	u8 req_duplex;
-	u8 support_autoneg;
+	u8 support_autoneg;	/* for non-copper port */
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u8 lane_num;
 	u32 speed;
-- 
2.33.0


