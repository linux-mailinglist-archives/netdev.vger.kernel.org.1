Return-Path: <netdev+bounces-122013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB695F91E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB21C21B9D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC49198830;
	Mon, 26 Aug 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TGs+3CWN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E9194A4C
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697886; cv=fail; b=FSPD9D2xlaivM6iGfaXW29VeGw+WPxuBl57NHw5B78e/Dl3QiND10ds/hMB7SaErjAiqur5UAB7Z2eMjTf3L6yK7ssZ65UYntj49gNm3EFLTbmfxOhRSYZrqiL011efJyLm/UR/ZnoRoqb1+f+y+tdWRR2w/cUYbeMJ4AzA80a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697886; c=relaxed/simple;
	bh=j3CRyk6Y0uBremxXdEIQSJdVQVA5Iabxi3t9ThH6b30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quxFrm8QHag0LAFu8den78Kr3K+1RxWSEMFRY6RHxmoLdfxmHodcC1IvWaTF/n95kcUP2yi9AV/jZGEd+jtJTMFiuvMuudPcxHge2Cr8YxhhuhnDSpljGG5A220uRw9SG1E8HY6ML1xwQiIc3NkJDByZZW0LNncAAKAHg2+5cr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TGs+3CWN; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPWLF1I9tZubYAuKIyqy92muYBEovFpMqFn+S2kLfERwF7jV3Jj88tyzPAxfNWOORuvHyRUUA2vGuZbR9Ca3c25m9ZLOjLk+AFgh6rWnH9gRX0wmhW8Tm2V2eeT4QF1wDIKt6hWzqb183u22haYxqpOsx2HsT1mwidk6RCtY+63AlV2Na82MT5TMfc7J9QqKp5Bws8XXNLhQl3+Zb1RKJFACmUsJTFTt1RlyvbFV2R+8JcKja9rSP+7RdtBkMj+54zeZDIxdJh1N+ho3m7JwGCea8ABWMrMTPxiH5YDsVxZZCADQI8ylc+OvctjvGhAvTxbMmUj01u3nbcExZ2/wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydGgXlmc6O+3iLJTFB/BCjqDr+bSvPG4muJH5tyCb50=;
 b=Ch8vGXzLfPvV4vFkzychVCBsqejifxRp4P2cBDwgm0ClutjMJ05XnI99izRw5Y11w20Vtw8qbVz62tSH0Hu4kFjAZtRRtUZvjuTCfRQ23TJAOQGjCkT7RXXaYhVPFOSDbJFTdS6fcv3tFYY9FoOnkU85WMC3alSz1W0IGFZ4AagUgwHMaDI8utXifU52MEn4FxRYJ2j0CknasZS4LHG1ZuMswyMzwYLuk4QPsWhnmFMwyx2dIrpFKqouus2ApNqxJChQ2pm0x/VzCYaO8pBLWg0sSQOcbT5em4d/jKfegOBjQVjOYOeoRld32LO8OPgT5dObzaeqZIoEex+F/JXGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydGgXlmc6O+3iLJTFB/BCjqDr+bSvPG4muJH5tyCb50=;
 b=TGs+3CWNpJa3WBm6AQ29bO44aHfDrnc8j8yToUUBH81OKP3eTyN5i/fk+Hj35PBoZGzpgDIs/CrREobkZ2x8WrTTlCDg/jOeMcRm5co40SRLBCFUXGPmeWXbTnogObygIyGqUltoyP0MsX1czkxNvsC7vNVYZ8o8OD2oz9+KX1k=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 18:44:41 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::48) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:38 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 1/5] ionic: debug line for Tx completion errors
Date: Mon, 26 Aug 2024 11:44:18 -0700
Message-ID: <20240826184422.21895-2-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8988fddf-06d6-47b9-e998-08dcc5ff24f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKHFtlaHvCBBlGHjtwRBVttVeVEoJfOljaM995c3PkPlkUD2oiDhmuaQHRIW?=
 =?us-ascii?Q?Y23ONYnYjKQlC+k0njcKXYKw+SgGeUTfydFPAsh0eL9/y6OGzWBhk48xmuRw?=
 =?us-ascii?Q?lNbhJUkq7j4TCBnmvcNg6AbXwxEaPtK7TNJcMMA67NpasaYW6O8jHOy60x8+?=
 =?us-ascii?Q?9gerLL63YX1isSfribEIjIpUUeruyoqf7FtUJ8g5Z7vYFw9PVSnBkje9SM86?=
 =?us-ascii?Q?ZKR1OmymSN8c8MIfMqGwz/mLZq5ODdDQkrb3j2vy4osHYdDvyRvk5g7FbiVX?=
 =?us-ascii?Q?8hdcc9M3FsgMfrQq5E/ggf2+dv/NCyuBl59mGu/4B/ozPlc2BTt0j0vpL2Pb?=
 =?us-ascii?Q?ULrXHvywaOliBVdhmROquUuJwcOQr4ZiW7attIyHD+/BAVI2Ay/JMAHeboyV?=
 =?us-ascii?Q?foHBPqCDHbAQ0D+hF2tQMHh0CuD9a2Z9wajflb6S5cs65HeoSCxDnmlQYMAC?=
 =?us-ascii?Q?ixp7QsnN7LZoJQohbk9Bp8svc4P39/o7ePOwR+ok2CdNj29zWWZTMcHV/2sE?=
 =?us-ascii?Q?uUZq6Hq8XApQReBBj5QcVqS1YiLcS0Sj/qGJEEWKbWAkKDDUCYAjlkFEJX/F?=
 =?us-ascii?Q?e2jrKvKxhjvKq41/4miteHghLZz5mf7y33YQr8HVgOWZE7JZwbLzcpTnCqx8?=
 =?us-ascii?Q?mm/7VmB3/9cWZ+j796yjuBsKl5FvWwfz+cehhEEQZBxnH4zTM3z+EvBOD9K6?=
 =?us-ascii?Q?U0rXy4COZ6r2fzIlmASS99Co15J/56cW0jGVkp1utcNDcxOuU77wHRM/Ax5k?=
 =?us-ascii?Q?K6TqU/q2q1xbFGJesEgXv2kv9lGxtIeoazoMxOwZNb8SjSpWF5UZWxvK7Ysi?=
 =?us-ascii?Q?TkfiZ5K1LPpTCP6SukK4zlvEztOGRltyUw1bhPx26m4YzZCGaQegpu5uC/EQ?=
 =?us-ascii?Q?uy7Q1lJguFnsoWK8boQDm+wHGd6DQnI1nMaMN8PyMXvC4qrAZfpn75DXVzHg?=
 =?us-ascii?Q?lMYj9yRIjdWNgfayvwpO2nVAjjyT+lLKe59z3Sc7dMXFm78wI+j8fzTGIcCn?=
 =?us-ascii?Q?gZPg7Ih0Q/Gch42YLf6aUt06BpCofBm0qvcJI4qGyJAwq4xLkMwgzMfgG5cQ?=
 =?us-ascii?Q?r5UQHTfEIt/sYzZ1moFGQA0y0C90toSvdLKpCfJgfxHKRGm4Y3vO/lNTT4NM?=
 =?us-ascii?Q?YLZ4vG3OqDnTxOU6zRwzSh3DibDu66F3n0SouorjuLb0gR72J7rk/qOvX189?=
 =?us-ascii?Q?9+64kGBIN8pKPI6u06npP9KwmmK91HDR8xJUhpdnQqQqUlW9E3fhTuwiuYQv?=
 =?us-ascii?Q?jEbhNLdnkreet0iX0Z4fq5kDnT1RWV/AYCR09e+VfXKh4FLpypVhji6vYBXe?=
 =?us-ascii?Q?pxc0iR3LJdn9kh6zlhARBmdotmQrEVV0En0C4bz/b//HhKDbNXXCsoRlKUw5?=
 =?us-ascii?Q?lpsC2MJHk7FV7xlHeVt0eX49DOrZBWE/aet6ETht2rSAAQuV2GtxL9NADDKg?=
 =?us-ascii?Q?Li7OjXAUDoE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:40.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8988fddf-06d6-47b9-e998-08dcc5ff24f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

From: Shannon Nelson <shannon.nelson@amd.com>

Here's a little debugging aid in case the device starts throwing
Tx completion errors.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index fc79baad4561..ccdc0eefabe4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -648,7 +648,14 @@ static void ionic_rx_clean(struct ionic_queue *q,
 
 	stats = q_to_rx_stats(q);
 
-	if (comp->status) {
+	if (unlikely(comp->status)) {
+		/* Most likely status==2 and the pkt received was bigger
+		 * than the buffer available: comp->len will show the
+		 * pkt size received that didn't fit the advertised desc.len
+		 */
+		dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d desc->len %d\n",
+			q->index, comp->status, comp->len, q->rxq[q->head_idx].len);
+
 		stats->dropped++;
 		return;
 	}
-- 
2.17.1


