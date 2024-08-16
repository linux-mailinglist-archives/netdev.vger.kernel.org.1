Return-Path: <netdev+bounces-119072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802EA953F68
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00813B26752
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152926AC3;
	Fri, 16 Aug 2024 02:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845205028C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774297; cv=none; b=J7VsY6cUWeaoxKFel5L1LlY1OiK7NZ8JHYsOFKl3jFvXAVE6u2Bw5GkYZDZN5cwsh4Y/56Pd4q4vPJyU+poXrHAC4cJkTUgmAjvkBWKfhlhbOUKBVDkD6FgwhXgo07M68C+7lRycXCb2/J5/DLhm8NtIXxcC3CJQcdqu401oyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774297; c=relaxed/simple;
	bh=7vcxT+pUVFnJ77dxkNir746F0h2i2FsWkS0BaTHhGuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eppv96PqHgT/7QnXFTQcEh8Wb6OpO5kjNvCZ4l+sItx96ckEXlernRDTBSL7pVjbNcH2xxgRzmx7nH0TVyxpp6CytrJvRF4W4H3uBKNyC9MT9His1jnHa4P/X+55cS8LYMmTj26uZuOiB87NbExCYLjXQR3Ro93tjWVh6nPimSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WlQNH3J8FzQplD;
	Fri, 16 Aug 2024 10:06:55 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id A46311800A5;
	Fri, 16 Aug 2024 10:11:31 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 10:11:30 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] net: ethernet: ibm: Simpify code with for_each_child_of_node()
Date: Fri, 16 Aug 2024 09:58:37 +0800
Message-ID: <20240816015837.109627-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node can help to iterate through the device_node,
and we don't need to use while loop. No functional change with this
conversion.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 1e29e5c9a2df..c41c3f1cc506 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3063,14 +3063,13 @@ static void ehea_shutdown_single_port(struct ehea_port *port)
 static int ehea_setup_ports(struct ehea_adapter *adapter)
 {
 	struct device_node *lhea_dn;
-	struct device_node *eth_dn = NULL;
+	struct device_node *eth_dn;
 
 	const u32 *dn_log_port_id;
 	int i = 0;
 
 	lhea_dn = adapter->ofdev->dev.of_node;
-	while ((eth_dn = of_get_next_child(lhea_dn, eth_dn))) {
-
+	for_each_child_of_node(lhea_dn, eth_dn) {
 		dn_log_port_id = of_get_property(eth_dn, "ibm,hea-port-no",
 						 NULL);
 		if (!dn_log_port_id) {
@@ -3102,12 +3101,11 @@ static struct device_node *ehea_get_eth_dn(struct ehea_adapter *adapter,
 					   u32 logical_port_id)
 {
 	struct device_node *lhea_dn;
-	struct device_node *eth_dn = NULL;
+	struct device_node *eth_dn;
 	const u32 *dn_log_port_id;
 
 	lhea_dn = adapter->ofdev->dev.of_node;
-	while ((eth_dn = of_get_next_child(lhea_dn, eth_dn))) {
-
+	for_each_child_of_node(lhea_dn, eth_dn) {
 		dn_log_port_id = of_get_property(eth_dn, "ibm,hea-port-no",
 						 NULL);
 		if (dn_log_port_id)
-- 
2.17.1


