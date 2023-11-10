Return-Path: <netdev+bounces-47056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D131F7E7B09
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8981C20DA2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D514001;
	Fri, 10 Nov 2023 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13A134C5
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:42:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B922B7E9;
	Fri, 10 Nov 2023 01:42:41 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRYf83JGBzMmjt;
	Fri, 10 Nov 2023 17:38:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 17:42:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 7/7] net: hns3: fix VF wrong speed and duplex issue
Date: Fri, 10 Nov 2023 17:37:13 +0800
Message-ID: <20231110093713.1895949-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231110093713.1895949-1-shaojijie@huawei.com>
References: <20231110093713.1895949-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

If PF is down, firmware will returns 10 Mbit/s rate and half-duplex mode
when PF queries the port information from firmware.

After imp reset command is executed, PF status changes to down,
and PF will query link status and updates port information
from firmware in a periodic scheduled task.

However, there is a low probability that port information is updated
when PF is down, and then PF link status changes to up.
In this case, PF synchronizes incorrect rate and duplex mode to VF.

This patch fixes it by updating port information before
PF synchronizes the rate and duplex to the VF
when PF changes to up.

Fixes: 18b6e31f8bf4 ("net: hns3: PF add support for pushing link status to VFs")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c393b4ee4a32..5ea9e59569ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -61,6 +61,7 @@ static void hclge_sync_fd_table(struct hclge_dev *hdev);
 static void hclge_update_fec_stats(struct hclge_dev *hdev);
 static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
 				      int wait_cnt);
+static int hclge_update_port_info(struct hclge_dev *hdev);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -3041,6 +3042,9 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 
 	if (state != hdev->hw.mac.link) {
 		hdev->hw.mac.link = state;
+		if (state == HCLGE_LINK_STATUS_UP)
+			hclge_update_port_info(hdev);
+
 		client->ops->link_status_change(handle, state);
 		hclge_config_mac_tnl_int(hdev, state);
 		if (rclient && rclient->ops->link_status_change)
-- 
2.30.0


