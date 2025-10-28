Return-Path: <netdev+bounces-233459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D25C13A37
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5557E561DFD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2E2DC79C;
	Tue, 28 Oct 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fx2SZ9wC"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6D2DC791
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641394; cv=fail; b=jH6Yusl7qg4uDGR6VGDTQS93znKAW0R5AdqFixLaZvlWGNBsvMAAUIZmn8E8JeHnwKay1BSFKIwtve9O9fF8lLykRyLWSe2dRSzzHPWyoF8oZABVkVL/V4CWcs/1W107V/BP39Kc7QDZnHJCA2wbk/2MWCT4jCQewuITQeARU60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641394; c=relaxed/simple;
	bh=VFXmKWOspLICidkfzgIdK1kISUoUzrLrzU9htBtZmvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3J21V8J9FfROxHccXWHyA7Vw2BmqRgsEaUWdiI8vnOGH7MKcFcWDHAyWabNtlZZ64zKZhYqVRPF06z5JkbxVMwTjyusUAkL/I1ZsA2k74HDQdSfBHk1d7/CEZ9Y+zNghTBs0T656j6+dQU8HcpxDS5bxIxfxBgaoXCBtUwRCK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fx2SZ9wC; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw6MikPQjz0ir4n33FPs5LvJJ1soO4ooLzRrSkRFLGKLgh43p7IpYNtbEDHAhcE+7OwMPemcnbAZP6bjBocaO3/fyleKPrurhoIy9HY+bp+qAVr/Xo8PjX/zQyLL4eCzKFG43QnDVxuhhhi7DTQk0rtYp/0/BBGdEH8hm3sc7FKGVtPAnpP+4a/5fLJ6DXVl3E1Dq4kg56f77gTssfXS3pqgiGkg518HO0LW6CDU0U/FHwBfWjobqknayJxmMGoUbzqaXcZDAM/bY4KKQAljkDJJsOlGRI+Il/WF9xuU571WLIyWjMWSc2+xsqpAbaE32xCbO6h+kRJwlBw8T2BD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na/602qQlzgyBSktGunIYWb6LVodo53Tf3f0JvPmRB8=;
 b=tMJ8JLMbJHpBe46Xi1sNM8yU4m5/G75KnuFaN8dovppj7R5tPxQwqM2z2P//cDggTSHcEeO8Fr7PVNyG77aE7BIn8qQWo0fQt/XxS6MwrJHeb5Ug3YLYofdm80oKNrLGlPta2IctPx96xnEcp5MyUssJE4QTNX8ftq3NSsfXNmeuhbs2pGXmYtPFIlW14Yylh8NokYKKFCeRNAHvn2c8GqjutnU1ESOxBGGUCY4RZvyBSbftXUSloDPKFHo+vwJkZnOm1XLHKhVyTow0I5WkRDGo2GjzuppxPkWPIYiDWRIIim032QyPrhm0mU5c+cddPOY2dcksQyhNBKbKbcHmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na/602qQlzgyBSktGunIYWb6LVodo53Tf3f0JvPmRB8=;
 b=Fx2SZ9wCQu9YNko/fKd6qPKQ2K6L+V2rH8UI9jz+Gb5+uGQ+pWwaEbID9Dg3ZKakHfRTb76TE1J8QWXx+yU6lQPREEuddsOFOF8Ge43DkHKLya5hVh8aQgP9mB5LkRlhOUU/l5WzM0A5TEZMYU1xfvDVg8AG1id/UmOoKXB8lHc=
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Tue, 28 Oct
 2025 08:49:48 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::a) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 08:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 08:49:48 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:49:45 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 4/5] amd-xgbe: add ethtool split header selftest
Date: Tue, 28 Oct 2025 14:19:22 +0530
Message-ID: <20251028084923.1047010-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf489a8-159a-4dfe-8682-08de15fef36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?esIesIaDZoeH/VZ6ZRwf9Xz1kFDqiL4vW2+W+nORbjqWaE7cEi71sy5xlJ2E?=
 =?us-ascii?Q?h9ZJnZt/Bro132cIlvosUPsRzpUATCjbTMnY3TlUtVqm2G5WAZ/asYoDXfDS?=
 =?us-ascii?Q?ya2ellqFwiE3VyBd2i9JyXTwRoe8gWKfs//6KljvQYyIpCDGz2q9wvOm+VvU?=
 =?us-ascii?Q?j+JSVVGaf0ufZAfGD+w7kVAZlcpF3lPD0fiYaiHOt5PlEDm7tQEzNmRQuSh5?=
 =?us-ascii?Q?0hXA0hPVw0S91277yQaiWswZV04cKv9BwE6hLnypE+U6cXy37c0Vsqm5ktGJ?=
 =?us-ascii?Q?kASX+WO1Jhd3F/b0YxHZRvaeewfVFJzZWTeRBxgEJkCTo9Nb2NbkIGJcOa3/?=
 =?us-ascii?Q?q9ZY0bmEd+KqJPseMl2BzquURrpEgJiFr+MYNX4it1QgcESHSavfvD9xl/KL?=
 =?us-ascii?Q?8qtXrRRibJH6gamy6nMARkXF9EfmPBkBKdOwliLWs7QL3Y8uouaDfXW2X7eS?=
 =?us-ascii?Q?z+Iyx38dANyLFbicudZC0oP5fUhj/dLZgx0s9dg3tXdN8rMuoVVxlMuNtBow?=
 =?us-ascii?Q?MAFB0pjITzHfYQYbDJY2Gl8qXToFkXBjhuOifc0d2J5kKSxwSBS+WdPAX0r8?=
 =?us-ascii?Q?EfRp7nryZRLnQBQMkbezs8b1JPpmso/fSzK6OdVAxGzpUo6VzuYZfAdbeJx9?=
 =?us-ascii?Q?8ZwYZ2IxVF8SktsTdYbpCKe6L8bhyBKRcRhgizDY2FHnYueFASKS02RXUKTx?=
 =?us-ascii?Q?V9RTbz8f9bP8kh/NqQtXj87SqWqn2jlwoGNT3YNGzJrDZqVudBxa0wo9msvD?=
 =?us-ascii?Q?ohZcnkEyBglfyVvAjhAmD8YQlqpUmNHh38up/FD94ZFFNL4DJv54sHWoIzqG?=
 =?us-ascii?Q?fGskb85BGRKe7P/+buiQOGT0zAifRGA9rL8SYT+qszBNOqnGzrb0dcLCxu65?=
 =?us-ascii?Q?FE9o06IIaP6wpB0AVohwDIgZuHfCylJe33KCZjDXvmS1jIDwSdmdayAgiV/a?=
 =?us-ascii?Q?279hrjWoCPxEZBCUQcxNzSRIQH9H+zHIgqzaMjpAtppZPLAjQX66HUNDKRg0?=
 =?us-ascii?Q?wce3kDrKsA2+DbhfPG26wbkYNsMzuzxMkItWhiPpsGNZKJs7UXnvMOcxPSAq?=
 =?us-ascii?Q?eIyR1Z6XRMZHK+UjvQHRNur7YJp8+0acscw8afcVQVPKbUdx8S1t9zT71SZ3?=
 =?us-ascii?Q?ivFjpbT5r//N6MLFSjt4RUpxqUNSOyH57F1Cr10/R7xn2A+amza0s/TNywpv?=
 =?us-ascii?Q?I2WZPnTdVq9Hnkkc27lqcUa3YnXB52MS7BQ/7tyOMQFjoBw58VseZfUF2v2H?=
 =?us-ascii?Q?fNub6NfRVNkDF9mZHUQhJEuXpQdic3Iw9TagzeoRUZAauFhOKXIeSK0NSfWb?=
 =?us-ascii?Q?mN/9zT+xLcl6Fe+ZVrk1JiHPLBhnDsc8xGyu+/bz6Pgwg39H5HtvSUmnpcIs?=
 =?us-ascii?Q?QIj5OmBxjmbCM48naRcG9FZeLyBVfMTjNnagNf9YtM5kyZAuLdkZd4/w8XkB?=
 =?us-ascii?Q?zCQUcmfJ6aZjiN5upqFGTRa2C43k82MHtr1Oo1cctq3Wpvy06aEsvfiHzIC8?=
 =?us-ascii?Q?4T5+0jEJQelZSchLPb4YadmSXf95Rolk8rcxh7qg+nA4QVF/wtRAF0BmqQD8?=
 =?us-ascii?Q?JqR4sFTBTINcyl/mlhc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:49:48.1576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf489a8-159a-4dfe-8682-08de15fef36a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 46 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 80071ce816e7..640f882cf035 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -179,6 +179,48 @@ static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
 	return ret;
 }
 
+static int xgbe_test_sph(struct xgbe_prv_data *pdata)
+{
+	unsigned long cnt_end, cnt_start;
+	struct net_packet_attrs attr = {};
+	int ret;
+
+	cnt_start = pdata->ext_stats.rx_split_header_packets;
+
+	if (!pdata->sph) {
+		netdev_err(pdata->netdev, "Split Header not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* UDP test */
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = false;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	/* TCP test */
+	cnt_start = cnt_end;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = true;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -188,6 +230,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "PHY Loopback   ",
 		.lb = XGBE_LOOPBACK_NONE,
 		.fn = xgbe_test_phy_loopback,
+	}, {
+		.name = "Split Header   ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_sph,
 	},
 };
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 4b6001ccd6e4..64a0f2fad2c0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1246,6 +1246,7 @@ struct xgbe_prv_data {
 	int rx_adapt_retries;
 	bool rx_adapt_done;
 	bool mode_set;
+	bool sph;
 };
 
 /* Function prototypes*/
-- 
2.34.1


