Return-Path: <netdev+bounces-98832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFC8D293D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234871F24C0B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FD1391;
	Wed, 29 May 2024 00:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4zfdEx0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E516A41
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941021; cv=fail; b=ar4DmkBgRzS+pHJeww9imh8MKyIF2xv68j3TdvG3Nf4/OB6AeNl+1dy+WgK7LmCqM8A5qMWTNyipvUlsOAxoHxveijFG5Cx1JQQ8Aq5NBboA/+3gg22TQusRyjRxQHPYnMGHTvkYolfu56AJr1axh36Vp9FF3HsDs/t2luRweK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941021; c=relaxed/simple;
	bh=BgzFHfK14okRcyhs5KJ8+Q6Ji+Nnh83pc/0JVG8a/Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmPy5xVgW0JIxY4GgXBVsAoz/OZfa2xXJRVEmw+T1YkOOZGfqGwPapf7FFncomTEkYOXfYvUs0ytngcoWpi1uI7O+VtFx1ALchwkXPJCyvgXz4SwhDHFdMe3aLk7kgvgDsbDSDt0+TY3Ww0aBAktGjohAj3MJO08B8bfltlQBro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4zfdEx0; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrkuy6FToZZSFMVyZKcy/InMIlQxnwUGj9dkyCA5xo8my2etx608t87mwHw4Ln0YuHyJwFVAC7/BAyo0kDlEaP2ORtRyqf+ur5X92ePeLXwRTfAOJ9jP/yjhWv6txXrv1w5aIwDCuMKXhoTu5ExYS4zBiJg7LIIbWnR3vHSikARMPc/cknRMMfFKPO7ps5dQznZCKy7thKDA4MG1RCP100xoqZtz79oDH2J8wjOP/yD6LUWrh8Ykg6UkOl7UDJ9YeA3REC5Erei7aN5pX5MK3SueaDn4X/kepqr2Hzfg5SwmjEM7m5BD8EeL5Tm+hHcuNrL59O82W1qd6bXbuzoB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYF6XXnTTZyC/hAa0L0lfiLzeskoARV2OnoFCrVkCiM=;
 b=OSYliUtlzWMccAEhJv1RyVN+CsNvDL8szCRxDrr7sm4sV0T1AzI6fazPlJHyYD1aNJxpGktpZWW2/693WVdTUWH9jY5jHCLEzML+zYOciGofzaCeRpDBgabC+9UmuhOVI9WwjQoMhVKutfjiOeyK033K78kP/gZGlJI9zUBDWqwjF5CQUfkQSZpFU1HZCSULJZVfDcLEZAh9gH04AjO7fsspfsCV/NKOfRlmCkDwJW0jsmcJ97SNPnONES8GXNKD8Sm+a3NWdADEP9FimtpOo1LLT1Uif41NOKnY1uf2zywaWCh2w06AtJarsIBrGGbVE2ugPKWcC88s8QyombTeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYF6XXnTTZyC/hAa0L0lfiLzeskoARV2OnoFCrVkCiM=;
 b=W4zfdEx0P991ptqW9eRhkglSpVPY1SZBGCgLiXhZXkJSoHkgcNzK4FBk9DyCWwd2+LYbxBsO+QFoGM3ci6zUIiZPI0hYO7hV/tq79IyV5By0/hDOvP5Ihujl2w5iLalipG8ZcTzSMx4jIKNbMyRI9bfzZpsfrcKPr80qfnwjjPg=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Wed, 29 May
 2024 00:03:35 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::92) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:29 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 4/7] ionic: Mark error paths in the data path as unlikely
Date: Tue, 28 May 2024 17:02:56 -0700
Message-ID: <20240529000259.25775-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 654db6ed-a64f-410d-f58f-08dc7f72c8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CK1AMtFZME/ywL3Wd3f7k8vmnlhJaGKP4F/Ii8pdTJZTySoEJgvJj+vScaAz?=
 =?us-ascii?Q?iOCs8xfvFSlCMGNxkdVkF57yDYVfI11t4et7LKIVvMT4hY6gHVkcfxVa4pSN?=
 =?us-ascii?Q?fdkhNvozkiq/gphe9XmCg05We18ZwG2ExfhM6H7U7BiMterltwf2AsrlTd6j?=
 =?us-ascii?Q?NXVmfbvLkiwWmq4rcvLWcC0f7/FOKSy2air/bW0xLNyQ8kD+O73y2M84KBmB?=
 =?us-ascii?Q?lwHlgDjijjoTXh3M9u7j55oLobOSiGALQGIWlWnB6ppRqY4R4nU53dgTyKeQ?=
 =?us-ascii?Q?0pHaLbgjMocj3OlKwTGumCiedJ/BMVbH1X86JzLuZVhijgy7xjdR8WbvfdO3?=
 =?us-ascii?Q?4I6niEjcAqAdscfiiT3gRJKBBBaRfw8si3SWrB7ZlwXGOTOhPZEmIffMBYlj?=
 =?us-ascii?Q?wlMhSLUgWQaLrBmZG2lglEoKy805wHH3f0rLR3x+q9lzRq87xwr0tgz7ZBAK?=
 =?us-ascii?Q?ygDrd25MJXH+muWZ6PJ1+SlX34IpppMzzTlwtaP19duHp8EtD8NohFrLvy3F?=
 =?us-ascii?Q?w+AIPJiFEcXVhasEmzLkfs/DsPddj5jddbBEHWyFUJ0lZYw+MhoEJprTMKWw?=
 =?us-ascii?Q?0hShNoF8YhiKslZE8EE/80ELtFhS3WMtobS8enOsSY5CV7wP7QKGsLdmCN0I?=
 =?us-ascii?Q?vnmQJFwX5N+TU9S/X/IdlzI/y2gBJhYpsBp5u7//kr16CYtGgwheC2/BOXo1?=
 =?us-ascii?Q?kxO2cQk7t7SbcOJIK6ZoPJvKNIPtvTScs3o5iz1uQcTfhjY/sXaoLDdoaMgl?=
 =?us-ascii?Q?jdy5PJF7qq9xQIHcxkfNLD4ro7ou3XH9sEwp4x+tLo+hc0lzHcvjFHeg2hW5?=
 =?us-ascii?Q?dtncUrEftiySHfS+OmB6IrsbFPvcFYpLNM3ES/I5r6mK2AvEZ1viqHibW2qV?=
 =?us-ascii?Q?lTBwe1OpZgsUZqCmBLimLgxiH0e91DVOPKUrxlnM1g8LgGEBnXL+Vx3aJ18E?=
 =?us-ascii?Q?TquYwglZeoGFIl5ocm9w3mMUr7SCS63OHFWumKDMS7C2N58Jm5JK/bJoTOkD?=
 =?us-ascii?Q?wzND2HScVW7kdf0USIb26u9e4uVjJH5GrqESd2ZKJj15PaR0SLdinBwB8Ycb?=
 =?us-ascii?Q?zSeqVqSOVDBOpiK8Rdx5exPtHvGUtpa0n0R7UjBtLAJr0htDBwiz4VUARYHy?=
 =?us-ascii?Q?3LCfOlJQmbeERoZjGnK1PsAzteIyqKr2zfx0KT0G5C5QxzoVuPGCY+U6iPeQ?=
 =?us-ascii?Q?/Bs/2omTW2jRjsSrB66VU29x2HAPXuZjB5XWwj3uufeZRS0B0W6cU8i9gaks?=
 =?us-ascii?Q?flutCOFmAS1caj2Q//4ybCKseadzFBFbXvOUTeEq7fGohLuZUlFHeMrjPTMT?=
 =?us-ascii?Q?kXB22AsnYJgJZ8UUhfhqSO0lIB8Jtlgxp8iVWSuXs0YaGnzF5YPLne/rvZOD?=
 =?us-ascii?Q?vhmAqCO6oNJh4Zb3nzgXgw34dsVw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:35.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654db6ed-a64f-410d-f58f-08dc7f72c8f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

From: Brett Creeley <brett.creeley@amd.com>

As the title states, mark unlikely error paths in the data path as
unlikely.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index c6aa8fb743be..14aa3844b699 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -582,7 +582,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 					   buf_info->page_offset,
 					   true);
 		__netif_tx_unlock(nq);
-		if (err) {
+		if (unlikely(err)) {
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
 			goto out_xdp_abort;
 		}
@@ -597,7 +597,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
 
 		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
-		if (err) {
+		if (unlikely(err)) {
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
 			goto out_xdp_abort;
 		}
@@ -1058,7 +1058,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 	dma_addr_t dma_addr;
 
 	dma_addr = dma_map_single(dev, data, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
+	if (unlikely(dma_mapping_error(dev, dma_addr))) {
 		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
@@ -1075,7 +1075,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 	dma_addr_t dma_addr;
 
 	dma_addr = skb_frag_dma_map(dev, frag, offset, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
+	if (unlikely(dma_mapping_error(dev, dma_addr))) {
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
@@ -1316,7 +1316,7 @@ static int ionic_tx_tcp_inner_pseudo_csum(struct sk_buff *skb)
 	int err;
 
 	err = skb_cow_head(skb, 0);
-	if (err)
+	if (unlikely(err))
 		return err;
 
 	if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
@@ -1340,7 +1340,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 	int err;
 
 	err = skb_cow_head(skb, 0);
-	if (err)
+	if (unlikely(err))
 		return err;
 
 	if (skb->protocol == cpu_to_be16(ETH_P_IP)) {
@@ -1444,7 +1444,7 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 		err = ionic_tx_tcp_inner_pseudo_csum(skb);
 	else
 		err = ionic_tx_tcp_pseudo_csum(skb);
-	if (err) {
+	if (unlikely(err)) {
 		/* clean up mapping from ionic_tx_map_skb */
 		ionic_tx_desc_unmap_bufs(q, desc_info);
 		return err;
@@ -1729,7 +1729,7 @@ static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 linearize:
 	if (too_many_frags) {
 		err = skb_linearize(skb);
-		if (err)
+		if (unlikely(err))
 			return err;
 		q_to_tx_stats(q)->linearize++;
 	}
@@ -1763,7 +1763,7 @@ static netdev_tx_t ionic_start_hwstamp_xmit(struct sk_buff *skb,
 	else
 		err = ionic_tx(netdev, q, skb);
 
-	if (err)
+	if (unlikely(err))
 		goto err_out_drop;
 
 	return NETDEV_TX_OK;
@@ -1809,7 +1809,7 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	else
 		err = ionic_tx(netdev, q, skb);
 
-	if (err)
+	if (unlikely(err))
 		goto err_out_drop;
 
 	return NETDEV_TX_OK;
-- 
2.17.1


