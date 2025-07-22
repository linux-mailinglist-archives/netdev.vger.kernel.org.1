Return-Path: <netdev+bounces-208941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB6B0DA70
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D89175673
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18222EA14B;
	Tue, 22 Jul 2025 13:01:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A23B19A;
	Tue, 22 Jul 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189303; cv=none; b=jY+IiyO/cuAQfhXP6DoApklP1zv2hJkxCkeqQzg+1dy7BhbhbNNBFDum2RIUw4Imgo5/wMgERB20QUMgJ0Tve1fj1Qz63GVNyrk88pOOE/JAiX553oKoqpv2AmmLvA0XaAo668+WGqA4EcGRBDbOt96a+S9Pir82xLrgl6oZn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189303; c=relaxed/simple;
	bh=1wpampLwSyhhNNjEQ51ybBwHmLBWHWk7aqDKE+JJjco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJA3CuJ77FDkWPAiyUzLGHQRHU+aFY3bBG9jMwo20jfeiKAju7kXVmpXumfMLUpdGwcDBFbx3bjye5/OunWqgvPqPyfepc/O6/pg4Ujqawn2mNuXwFMmRTb0OKLx5Djs+lugJI9CkhxjXoJwPQvfj4oXf79PSxlBTk8+guQ9U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bmcjB66kbz14LxB;
	Tue, 22 Jul 2025 20:56:46 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 63C2F180B66;
	Tue, 22 Jul 2025 21:01:36 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 21:01:35 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 1/4] net: hns3: fix concurrent setting vlan filter issue
Date: Tue, 22 Jul 2025 20:54:20 +0800
Message-ID: <20250722125423.1270673-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
References: <20250722125423.1270673-1-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

The vport->req_vlan_fltr_en may be changed concurrently by function
hclge_sync_vlan_fltr_state() called in periodic work task and
function hclge_enable_vport_vlan_filter() called by user configuration.
It may cause the user configuration inoperative. Fixes it by protect
the vport->req_vlan_fltr by vport_lock.

Fixes: 2ba306627f59 ("net: hns3: add support for modify VLAN filter state")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v1 -> v2:
  - Fix wrong Fixes tag, suggested by Simon Horman
  v1: https://lore.kernel.org/all/20250702130901.2879031-1-shaojijie@huawei.com/
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 36 +++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a7de67699a01..30bdec1acb57 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9576,33 +9576,36 @@ static bool hclge_need_enable_vport_vlan_filter(struct hclge_vport *vport)
 	return false;
 }
 
-int hclge_enable_vport_vlan_filter(struct hclge_vport *vport, bool request_en)
+static int __hclge_enable_vport_vlan_filter(struct hclge_vport *vport,
+					    bool request_en)
 {
-	struct hclge_dev *hdev = vport->back;
 	bool need_en;
 	int ret;
 
-	mutex_lock(&hdev->vport_lock);
-
-	vport->req_vlan_fltr_en = request_en;
-
 	need_en = hclge_need_enable_vport_vlan_filter(vport);
-	if (need_en == vport->cur_vlan_fltr_en) {
-		mutex_unlock(&hdev->vport_lock);
+	if (need_en == vport->cur_vlan_fltr_en)
 		return 0;
-	}
 
 	ret = hclge_set_vport_vlan_filter(vport, need_en);
-	if (ret) {
-		mutex_unlock(&hdev->vport_lock);
+	if (ret)
 		return ret;
-	}
 
 	vport->cur_vlan_fltr_en = need_en;
 
+	return 0;
+}
+
+int hclge_enable_vport_vlan_filter(struct hclge_vport *vport, bool request_en)
+{
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	mutex_lock(&hdev->vport_lock);
+	vport->req_vlan_fltr_en = request_en;
+	ret = __hclge_enable_vport_vlan_filter(vport, request_en);
 	mutex_unlock(&hdev->vport_lock);
 
-	return 0;
+	return ret;
 }
 
 static int hclge_enable_vlan_filter(struct hnae3_handle *handle, bool enable)
@@ -10623,16 +10626,19 @@ static void hclge_sync_vlan_fltr_state(struct hclge_dev *hdev)
 					&vport->state))
 			continue;
 
-		ret = hclge_enable_vport_vlan_filter(vport,
-						     vport->req_vlan_fltr_en);
+		mutex_lock(&hdev->vport_lock);
+		ret = __hclge_enable_vport_vlan_filter(vport,
+						       vport->req_vlan_fltr_en);
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"failed to sync vlan filter state for vport%u, ret = %d\n",
 				vport->vport_id, ret);
 			set_bit(HCLGE_VPORT_STATE_VLAN_FLTR_CHANGE,
 				&vport->state);
+			mutex_unlock(&hdev->vport_lock);
 			return;
 		}
+		mutex_unlock(&hdev->vport_lock);
 	}
 }
 
-- 
2.33.0


