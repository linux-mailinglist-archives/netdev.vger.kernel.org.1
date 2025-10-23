Return-Path: <netdev+bounces-232114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8EC01481
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47E65350BD1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369C314D10;
	Thu, 23 Oct 2025 13:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468F314B9D;
	Thu, 23 Oct 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225239; cv=none; b=OKLsRY9Xjs1ZWiAvXJwB0APdlCa76S/mzY967OLWmMi9zg6SK9WYToJFwTA5FhN8rj0POMy14etaHsHSNDJWzYXCiE10+ObVe+2OfD9gV8KF2VQDql38xfy3972LwIkFn6E6IcHnYcw4K/5/8KYH8vKvEhvVEcg5P/A3TtTI/2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225239; c=relaxed/simple;
	bh=se7ayilkX3IGI98SOo61cqNyGG+A+8VOPFQAqibP+ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/JEcE08z/9r89Ld5oGOOq9RfW8qdllYEdhKDmm6zgf2AF4kI1giDIw5Z4+ATiSDQ/H16ZIw2ARH1QuT1sBgN5D53A1H+yUx2ofz2240hLrZQhyBIq+qnnhnvgjVqaQqyCpq7Bk08/jcajitDVgZ18amtuc2vH8k6tCJ3Hc9PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4csmZK3fqkzxX9B;
	Thu, 23 Oct 2025 21:08:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DAF231402EB;
	Thu, 23 Oct 2025 21:13:54 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 21:13:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 1/2] net: hns3: return error code when function fails
Date: Thu, 23 Oct 2025 21:13:37 +0800
Message-ID: <20251023131338.2642520-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251023131338.2642520-1-shaojijie@huawei.com>
References: <20251023131338.2642520-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index 9d34d28ff168..782bb48c9f3d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9429,8 +9429,7 @@ static int hclge_mii_ioctl(struct hclge_dev *hdev, struct ifreq *ifr, int cmd)
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


