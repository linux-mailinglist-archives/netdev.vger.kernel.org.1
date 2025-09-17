Return-Path: <netdev+bounces-224004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBDB7DF55
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0907B715E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE172EC0BD;
	Wed, 17 Sep 2025 12:37:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C01DE894;
	Wed, 17 Sep 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112672; cv=none; b=Rn/FWXlMIXu6Ul4Zewulwo1oz4f3nT3aoe1Y6iIU9opaj1P0RxjAz92G8BhB7iNfQ6pggTUiKYEZVRDhaUnHOZCC1WXl5TkpVY2eC0wPss8/maJ3RODSICvHzl4SVCh9/4bSu7MMM2Y16uFIBsG1PEGJn9e8S+dPf+Pf8m9w7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112672; c=relaxed/simple;
	bh=GHFZSOIrjTQAvPdgto6TJ/1BVp3JssameknJQ0DS0pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fgt2bgURwgYS7uXtQRkXcFQuYZ3oclmRgivcrZqlAMPMjqL7g9U35GOVyPXyxhX7GKJGM4ZRTZ7vdz2mMWn5l8eiqyqnLNlsp/eSi2O68SzT225tSGH8fqLQz2rUHbmvUT3CPqA6coQVB+0FBclwLg6WrwXStBqFwq212O81dRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cRdW22DXnz2VRtT;
	Wed, 17 Sep 2025 20:34:22 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 57E591A016C;
	Wed, 17 Sep 2025 20:37:47 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 20:37:46 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<huangdengdui@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/3] net: hns3: return error code when function fails
Date: Wed, 17 Sep 2025 20:29:53 +0800
Message-ID: <20250917122954.1265844-3-shaojijie@huawei.com>
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

Currently, in hclge_mii_ioctl(), the operation to
read the PHY register (SIOCGMIIREG) always returns 0.

This patch changes the return type of hclge_read_phy_reg(),
returning an error code when the function fails.

Fixes: 024712f51e57 ("net: hns3: add ioctl support for imp-controlled PHYs")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 9 ++++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 78b10f2668e5..85f07219b8be 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9455,8 +9455,7 @@ static int hclge_mii_ioctl(struct hclge_dev *hdev, struct ifreq *ifr, int cmd)
 		/* this command reads phy id and register at the same time */
 		fallthrough;
 	case SIOCGMIIREG:
-		data->val_out = hclge_read_phy_reg(hdev, data->reg_num);
-		return 0;
+		return hclge_read_phy_reg(hdev, data->reg_num, &data->val_out);
 
 	case SIOCSMIIREG:
 		return hclge_write_phy_reg(hdev, data->reg_num, data->val_in);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 96553109f44c..cf881108fa57 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -274,7 +274,7 @@ void hclge_mac_stop_phy(struct hclge_dev *hdev)
 	phy_stop(phydev);
 }
 
-u16 hclge_read_phy_reg(struct hclge_dev *hdev, u16 reg_addr)
+int hclge_read_phy_reg(struct hclge_dev *hdev, u16 reg_addr, u16 *val)
 {
 	struct hclge_phy_reg_cmd *req;
 	struct hclge_desc desc;
@@ -286,11 +286,14 @@ u16 hclge_read_phy_reg(struct hclge_dev *hdev, u16 reg_addr)
 	req->reg_addr = cpu_to_le16(reg_addr);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to read phy reg, ret = %d.\n", ret);
+		return ret;
+	}
 
-	return le16_to_cpu(req->reg_val);
+	*val = le16_to_cpu(req->reg_val);
+	return 0;
 }
 
 int hclge_write_phy_reg(struct hclge_dev *hdev, u16 reg_addr, u16 val)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index 4200d0b6d931..21d434c82475 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -13,7 +13,7 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle);
 void hclge_mac_disconnect_phy(struct hnae3_handle *handle);
 void hclge_mac_start_phy(struct hclge_dev *hdev);
 void hclge_mac_stop_phy(struct hclge_dev *hdev);
-u16 hclge_read_phy_reg(struct hclge_dev *hdev, u16 reg_addr);
+int hclge_read_phy_reg(struct hclge_dev *hdev, u16 reg_addr, u16 *val);
 int hclge_write_phy_reg(struct hclge_dev *hdev, u16 reg_addr, u16 val);
 
 #endif
-- 
2.33.0


