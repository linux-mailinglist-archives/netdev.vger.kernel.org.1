Return-Path: <netdev+bounces-224003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB59B7DF43
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96ACE189C062
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5F2C029C;
	Wed, 17 Sep 2025 12:37:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5C337EB9;
	Wed, 17 Sep 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112672; cv=none; b=iZcN0xxgTAHySyQuRTNdAgHYVzEIFtDe+VLL/lTNC9tiQyWWWlUhnW0k6kzPEHw8uqOp2IYsU5u6JSSc8W53tlRBw7o8330lSCor0XhZ5PssVfj4xws2sRzsA8S+7ypFaFPBT67PaGlMbqXCP92HR7+wVLNr3k6NvhGNNASP7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112672; c=relaxed/simple;
	bh=FUNY+HFEbxcGWEIKfmsg3Wd/fyu3Ba1lSQlGoiQNYI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoPyNfdvEExh7djAHjleuSUVqF9rXxSsdQQb9eTgzUgKa1V7Ahl1ad/6GTjkjk7cUQIFqFaZSQECaG3T3w0OHbqi3hxd5o0fxnzdbavPksuaF0CkOlQfyPgsnhUIa010l8+YMPgi2QV0vWd7piwg8NnfORckfH2CWYavMk0+O3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cRdW15cVWz2VRsq;
	Wed, 17 Sep 2025 20:34:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CC3E8140142;
	Wed, 17 Sep 2025 20:37:46 +0800 (CST)
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
Subject: [PATCH net 1/3] net: hns3: fix loopback test of serdes and phy is failed if duplex is half
Date: Wed, 17 Sep 2025 20:29:52 +0800
Message-ID: <20250917122954.1265844-2-shaojijie@huawei.com>
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

If duplex setting is half, mac and phy can not transmit and receive data
at the same time, loopback test of serdes and phy will be failed, print
message as follow:
hns3 0000:35:00.2 eth2: self test start
hns3 0000:35:00.2 eth2: link down
hns3 0000:35:00.2 eth2: mode 2 recv fail, cnt=0x0, budget=0x1
hns3 0000:35:00.2 eth2: mode 3 recv fail, cnt=0x0, budget=0x1
hns3 0000:35:00.2 eth2: mode 4 recv fail, cnt=0x0, budget=0x1
hns3 0000:35:00.2 eth2: self test end
The test result is FAIL
The test extra info:
External Loopback test     4
App      Loopback test     0
Serdes   serial Loopback test     3
Serdes   parallel Loopback test     3
Phy      Loopback test     3

To fix this problem, duplex setting of mac or phy will be set to
full before serdes and phy starting loopback test, and restore duplex
setting after test is end.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 26 +++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f209a05e2033..78b10f2668e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7844,8 +7844,15 @@ static int hclge_cfg_common_loopback(struct hclge_dev *hdev, bool en,
 static int hclge_set_common_loopback(struct hclge_dev *hdev, bool en,
 				     enum hnae3_loop loop_mode)
 {
+	u8 duplex;
 	int ret;
 
+	duplex = en ? DUPLEX_FULL : hdev->hw.mac.duplex;
+	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed, duplex,
+					 hdev->hw.mac.lane_num);
+	if (ret)
+		return ret;
+
 	ret = hclge_cfg_common_loopback(hdev, en, loop_mode);
 	if (ret)
 		return ret;
@@ -7871,6 +7878,12 @@ static int hclge_enable_phy_loopback(struct hclge_dev *hdev,
 			return ret;
 	}
 
+	hdev->hw.mac.duplex_last = phydev->duplex;
+
+	ret = phy_set_bits(phydev, MII_BMCR, BMCR_FULLDPLX);
+	if (ret)
+		return ret;
+
 	ret = phy_resume(phydev);
 	if (ret)
 		return ret;
@@ -7887,12 +7900,19 @@ static int hclge_disable_phy_loopback(struct hclge_dev *hdev,
 	if (ret)
 		return ret;
 
+	if (hdev->hw.mac.duplex_last == DUPLEX_HALF) {
+		ret = phy_clear_bits(phydev, MII_BMCR, BMCR_FULLDPLX);
+		if (ret)
+			return ret;
+	}
+
 	return phy_suspend(phydev);
 }
 
 static int hclge_set_phy_loopback(struct hclge_dev *hdev, bool en)
 {
 	struct phy_device *phydev = hdev->hw.mac.phydev;
+	u8 duplex;
 	int ret;
 
 	if (!phydev) {
@@ -7902,6 +7922,12 @@ static int hclge_set_phy_loopback(struct hclge_dev *hdev, bool en)
 		return -ENOTSUPP;
 	}
 
+	duplex = en ? DUPLEX_FULL : hdev->hw.mac.duplex;
+	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed, duplex,
+					 hdev->hw.mac.lane_num);
+	if (ret)
+		return ret;
+
 	if (en)
 		ret = hclge_enable_phy_loopback(hdev, phydev);
 	else
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 032b472d2368..36f2b06fa17d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -283,6 +283,7 @@ struct hclge_mac {
 	u8 autoneg;
 	u8 req_autoneg;
 	u8 duplex;
+	u8 duplex_last;
 	u8 req_duplex;
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
-- 
2.33.0


