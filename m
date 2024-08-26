Return-Path: <netdev+bounces-122014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F367B95F91F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C451C21DBA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A59194A4C;
	Mon, 26 Aug 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oLNUbH7o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E81991CC
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697888; cv=fail; b=FS/1NhWAzBy6avO3Cw2uOiVbBHp6boT4RdxdZlCSG/O4IMCC9qql2MrxWu6HyYhBSdSPhSaD7cNTlis2NGvgZ7daMIPxUTKJqAPi9YWXSH7wd8HElRNX12BZcpgPGbgGf51AlXwgqDEGAUjzY0HrD9nEfn2g4FRXeaEMIe++mM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697888; c=relaxed/simple;
	bh=xygfFePx6C38dTuDIxq1Ea+gYpmBGE6BYC2sShPAaHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu0nPO40yhpjh16BU1q+ptMAkm1wtjpwTmTO/o72bLG1oAeusdKSTSODTo5mnWjMGnc43qAAHW2xAhG4ChXx16u/GdEw6fCsrcHH89FSZ9wK+6wHDnDZ0Qa5G2e4kPuJ0UeFge2H6Qib56PHNClrsfLsHux9JcZ9txg0lHJ3ung=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oLNUbH7o; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVyPRJFEtppoiUMj+uH+ipdPGbjKMbP74m7IFfg5oPlwyhXqnKs1dUXKr/+nCvhwFZmFaVzRiP3SN/o3oY5Ecn/T8Zum3ehk/esgGtY7XhkjOeJenFP35ZdYIDA0D4jJMUpYlVqqGGdUTp6Zk1xSJL4uydACFKoQHGqYh7TV6eD1WVsYHT9y/79IwIsW6auuYquojdI1zf4Cfd0Gvb32jD6kJcNgUof78AsxbHgypMAA3U7GdxnvYTqW/gHehfu5Zw1ST6RslWCLu53l+qEIG+dvfv5HhDO0uLfHJfPrda9vo497uH3lGksesQ7SNSfZ2Y7xFlf3hlHRl2BAPbUn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+eL95GQjVFHwYMPzNnHcgUwc5a3KthXmWL6tGRm1P0=;
 b=ubluRjTSFRtO+rbEmMVUsyA8HZdBWrGMTQlRi3Cir7+Oy43KNYY02H3mtvdlU7VvMhc3dnacfP6XaQtPA2Yi3JsRVYXfVbj2JuUUlVl54PdT2BtDGQqBvW+xAERocI282QUEK4SkEAoPGZfOixvfowSzwhQZu9e9k863xMNDV9gVIgdI6QfZyMO6/LLXxbd/isXftgjGSTBuQitZNDR+sW4zdPXL/IPHUkgeqgdKhFcXBzwva1zQgUAVpgOinNZ5UNKOPQU0USpEk5+1D7lWx/elBJU+/R+fAgKQA8ksxQmoSPMtGFNEOxPf8XQc4e+q5Z4WJT+Kj0XPJ671X7QBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+eL95GQjVFHwYMPzNnHcgUwc5a3KthXmWL6tGRm1P0=;
 b=oLNUbH7o3ATDfg2I1sKlXgAx5rR3MHxsU61BzOUQNJB9uFDMiXfsRKkn/ZvgLSYCK6GsZMx+SDrCBer/9CjtkMJcJv4uofbJGFPKIxGqA0wq7aKUujJYINhH1WsXm72npZln/RFt4JhYy/Xa0h3jNqJvdBttSY3dQlkbaijCLsk=
Received: from CH0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:610:74::33)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:44:43 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::1f) by CH0PR04CA0088.outlook.office365.com
 (2603:10b6:610:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:39 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 2/5] ionic: rename ionic_xdp_rx_put_bufs
Date: Mon, 26 Aug 2024 11:44:19 -0700
Message-ID: <20240826184422.21895-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240826184422.21895-1-brett.creeley@amd.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 638f10f4-7db7-46c5-633d-08dcc5ff2656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PM2LRtkVZebXV8teWpKbbDYiPT7NWtU9Ygvu0MnHcG16PM8m465fsH5Hha5A?=
 =?us-ascii?Q?GTRx4c4Uf7DGhblg14H5lPZ5TxTuc3zJ9y3bCYOfnKplnJ32VYRbF5C3hta+?=
 =?us-ascii?Q?QSgKYDopV5mtVNP2uxwJkALcAOcEYk5TVjB/MAgScj689rJy1PpIyKjI+C3m?=
 =?us-ascii?Q?G4/qqY/OAvBcEUqJI0IBwK+AjV31KJ3benwc1EnnKCkIP28gNgB9bV/KjSwy?=
 =?us-ascii?Q?V93crFcY8K3XK+6sBdtTbVLhSiWH0gvJz2MkLFPm20grj4KSAf31RfYpIrzh?=
 =?us-ascii?Q?r127y4aFfHL6cmU7Rdfc5QovwCIdOvJvaH5uglPKLRCnYYNQSVXcSEkipuut?=
 =?us-ascii?Q?Op4FvEfo46r0sKrCYNNX0yWHCnZOvtecjovpv0inUMYajXexJp6E7n/sBw1/?=
 =?us-ascii?Q?qYg55ZUzh5GU1v8v8rR+xQu4WwkNnObxbbEvKLrLUVnbPQrIlALWuYVqRUEn?=
 =?us-ascii?Q?jqzvk/KZOxIqSAmGTdLw8xCKt2Z8Md3SERYP+v2ul+K8ZZu62VKiTcJekI+z?=
 =?us-ascii?Q?/N0g7PCWyD123a6uEJo7i0mm5ql6CY2nd9XXGuaIEbch5312zQgJqPkIrEc3?=
 =?us-ascii?Q?GzitiaWcAQ4dW1LWUUAjnG5+FjQ/pP0ZQaFkj3ZF3Ih3AKcBRKEALWiE4/ZD?=
 =?us-ascii?Q?IPHoLcwKsBVBch8mBbFhptdKHO9BhgCb8/wbe/V+7BCEa63MfHXzpgMYXcG9?=
 =?us-ascii?Q?lZ3GN/GMH9ly6SIP55zn+YXfbCl9GjMDgsetjtwVqa2A596DOhW055pSYsRe?=
 =?us-ascii?Q?XVc6cFMKDfZN/iHRtEOXGfLMui6iLx8YE46v0Z8tdYASeVwflWYYkjW4us/J?=
 =?us-ascii?Q?5S6t6+zj819AFsKmfqofPau7ZVoHXQEb47hyEkGV6JqoeG/ML4163a7XezH6?=
 =?us-ascii?Q?28rQDC0kQbLw3b8LPHwpZ1xhnIx/1h+dwBf+Ye3FHKktmBHfgmzWjpLahi4H?=
 =?us-ascii?Q?ki9fsvuIeniEXcckmX3VYMmOauj/kEC+sl4sEaJJGQXVpJ/YBvH+h9xXaErO?=
 =?us-ascii?Q?LVA/5Zk7j7aE/p3rEmlcYoZBjYvV9JyKqAMSLK+Xy9BStBq2iJPWUWsiN3h9?=
 =?us-ascii?Q?ysbSWsl18qWaM03Hay3woBD41pWBcNEotyzNweyBouNp5RqMLQb+O2ftxG1S?=
 =?us-ascii?Q?6XdvrAKxeZv7xNoVR4C9gGmJCVi3/ZMbsKqhDnTvRhaU80Mc2VzbCBXSHTVf?=
 =?us-ascii?Q?b1EBNoxdZ8ub2knDBlXLyrdyAJP4Ym/1xWZIUZdDQWv5NLDqZqxrGXnO4yKe?=
 =?us-ascii?Q?JkS0jSIaXWMlZdjT2dKNzj8CSbl7Dt2Rlko7XVrwt1wYKgVOI9Wqv+T9aqNI?=
 =?us-ascii?Q?Ykhf9KoPk+u4YEHMLr8kbLu+iot9k8lcozCbMG/VDWmqUa9Mx8SEGHy5KnT7?=
 =?us-ascii?Q?t29t6FrWFPyHSt+24T25oqJwAbZ3hlDib9q1MVJ4loLpsGPUxsRKRB87G74t?=
 =?us-ascii?Q?RxlBjuE9cEHEuSIeV7u85y+xGpPtuoaF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:42.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638f10f4-7db7-46c5-633d-08dcc5ff2656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001

From: Shannon Nelson <shannon.nelson@amd.com>

We aren't "putting" buf, we're just unlinking them from our tracking in
order to let the XDP_TX and XDP_REDIRECT tx clean paths take care of the
pages when they are done with them.  This rename clears up the intent.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index ccdc0eefabe4..d62b2b60b133 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -481,9 +481,9 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 	return nxmit;
 }
 
-static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
-				  struct ionic_buf_info *buf_info,
-				  int nbufs)
+static void ionic_xdp_rx_unlink_bufs(struct ionic_queue *q,
+				     struct ionic_buf_info *buf_info,
+				     int nbufs)
 {
 	int i;
 
@@ -600,7 +600,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
 			goto out_xdp_abort;
 		}
-		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
+		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		stats->xdp_tx++;
 
 		/* the Tx completion will free the buffers */
@@ -612,7 +612,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
 			goto out_xdp_abort;
 		}
-		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
+		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		rxq->xdp_flush = true;
 		stats->xdp_redirect++;
 		break;
-- 
2.17.1


