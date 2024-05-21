Return-Path: <netdev+bounces-97268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CB8CA5E4
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457771C20A4F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822ADF9C8;
	Tue, 21 May 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MBCsqIad"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E13BE6C
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255475; cv=fail; b=JkEr0+BsUOhXeDTN9lwL8vldPRVlLiIVDNGfsXESk/ob/fKVXq2+nTbhOHganjxYHSmuecRkk09zdHdfIzGUUvtfym5KgTBFNG88lcQFDAmhBXS1dDhPl0dVClCpvy56XkNzlSS8lR3TjWeapdxLDDRSf5vBBQzUBWXWOCX1/P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255475; c=relaxed/simple;
	bh=NW7IAqYDGH4gNJvD/gjvUo+bNTXBcSo+oM+INzku3Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnypYFkqnXydeLT7AtxEGAyaz5QTOGxbveZBneZ1sXUB3VXR3ZNwy6qCQnzWxTqhXayCeaW1p3fj/H49TtsHSWKGw5V6wIf4xdra/F5g17ACuemmVQ8kCY9w5TGR1AnuSNZgV9MjhCitgca3m7jnotXQ6VOo50gck7Al07xjOYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MBCsqIad; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZs2OTMb85v+ugdDpoeBD9wgMSNgK4AX9SF3uD+y7ZLMPIJqcjQ6XXLyPW/+0vd+pmH5JB8fekjbUiOPYRrbe8H0QV/jY24Tt1TP5SlZpiwXERWVXHAQpud6ljRLpjsNWuQputUXYPQb8+8XG72NZSlszdIcrS4oQSLdS1rilpbsxsKpCK2Cof62dipcxkbltPDQhX7PdFfyitaOXbaJ4/48/W8vDg+iSmg68jtV5ZQYPaHBO36GGBDZ+i8bQxAukgmayCGpaVheGBv5A2u1Z50nvn9LCuBa89gF2Oy5o9LMVxEemvCVnnl4klm9BAvv3GWA5VJAFqcrrAU3/WE1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=denBEdXh2ig/DRJ7xEGeiXsZDIe33ghaBIqnGEGssjw=;
 b=W83GykyBi6UQWARspL+FZDkOdzncqs/+pyMIdzxgfdHVvEUDsSgfiYXqeXAjxDz6DbyW7mVfba6Y3C6YcdIkGqGu9l4/bS/mQAbYWnFLV3oVFG8RHlciUtgE7zwib7BhVbp/VN5RIeMv19E34hMYGPTYDgcYPAd0TVHSUL2FfDgDZlRpcC30DNK6rM9P4LdWGWOG+z86OI/rTGnxxuwwfV6+3ws5N+yq6dqDOCXdLsH9wPwtuGIBCfHPbrSmE8rnPIUEhhybzuOhWxh5nyzrriVgwBvhY99XrPDdFjc+4mQqNNaprYy4zvLJujSWXdeIOgywMTJOBCov2dJkAIzWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=denBEdXh2ig/DRJ7xEGeiXsZDIe33ghaBIqnGEGssjw=;
 b=MBCsqIady9ONaw6kj0fhB9QeSucGhEweEFa7h+AcEjfN+MdSJKzMik1pzwvUwJKD+/wzGaePgs3BzAfRVzUvG3pqBbTEFkbKzu7Ik220lpk/NLxevkBT59IxIUWz+LMQDSuw5veTzKrH59EePYB/e53ylh1dnF34WTmbVmGZ3cw=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:37:48 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::6c) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 01:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:32 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 4/7] ionic: Mark error paths in the data path as unlikely
Date: Mon, 20 May 2024 18:37:12 -0700
Message-ID: <20240521013715.12098-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a990c76-5a33-45b2-8de4-08dc79369f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?li6feg6zvihbUgParXvGwMRqxUSiQfSsUkh6dgtiljiuVOSuoqq/mQKqbVQC?=
 =?us-ascii?Q?Kcs0LyCZ8vzjxvNxedzSuTYot4NbKHQczb+FZRHXqm7Ek84s4nVCJvmYrJeG?=
 =?us-ascii?Q?b97evcXAW7ByAaIAqnw6oK3wThXrW/OZ1xcMsInZVwN8rVqY0bYwyYcTM7j7?=
 =?us-ascii?Q?V8uGGny4Rc9tm/I4hG1zhXZhdzvH++vn89X/S9R5BoeHUcS/Sh8Epy9j719W?=
 =?us-ascii?Q?/w6Uvg3X3ia3A2PLoJi+xfhJ0U8SwTRaURt784CZ23IuYHhXbyV+wabkKbq/?=
 =?us-ascii?Q?Ys0TbMQeFkR+b092YsbnWzperF3s4lRmTm7gMtwYkR+V2IcKVYfmZ5qRgBHW?=
 =?us-ascii?Q?hSygJVejyrEvXo/CYraslS76xFZjKiaMFh9+scalCZqAhwjxrXtsDoi78Pt2?=
 =?us-ascii?Q?UQ1kNVbCenoO77BEXpsCC5vow4D9+ibeYPcFveDK/vcR207RPMXdiWxlbJSH?=
 =?us-ascii?Q?GJk5Z/H8Io4t/NJ5t5w3FFGLO4euX/xIc1535HNDsReasQnalMZY/lAquzIJ?=
 =?us-ascii?Q?TenNun3DzfFFe3ztF2pgBGWotVqiBmDzlCvr42WaaP9NOWRf4q95u4f+Rc4t?=
 =?us-ascii?Q?YiocOOhrE5xd32We12dTFOl8D0b1xdKiDGiAriacZaCw0Qj9Wfu77z2BGA8H?=
 =?us-ascii?Q?FXsr4r6NeEqFK6Npb33FHKXjEF9neqQx2ZNr7Aw2q9lQ0sZ7nZ2hANW6F9Gh?=
 =?us-ascii?Q?mHfWo0jPlgNPL3lqK8Aif1coY+YoV/sI1O+05Rvr408iQkvnxiFQbFWwyE/b?=
 =?us-ascii?Q?RUH+xMOF2utL4meJ2lctajtWHPQXNKydJFSrhVST/GhlNMUGhg+27jcnGkGJ?=
 =?us-ascii?Q?EldSuNxNSnKnNT0jpht4tDZx0vilpuImJClhZws9vNWPikfc3iOWpggQJB2r?=
 =?us-ascii?Q?aBW6sfd+czqqBCSyTGlPJUlXxlLjgJe1TJQtOqJ1fCbdhtqmv/7VG4yIu3+T?=
 =?us-ascii?Q?oL3abthWdEUJvLBEM+KZCjL+dRPX8bTQdZO+TNtCmgFl1ANeQ21l2w3NW5aP?=
 =?us-ascii?Q?jAw8gr1BIdDxQY3lrI4BYosgAbZ7NEADao76fUXvSvyh0Iaw7GcjA/FH0GCM?=
 =?us-ascii?Q?zrz8vx9PtW1FlIcQ+YbQmrkDV/RqFRd/vs34OddCogLgZyDRKD6iZIll8Md/?=
 =?us-ascii?Q?6btIMfXcli6eZ/PuC/vJTcDxB65Ukg/PQXTDonK7Ve1zywOohJX18FwyGb0Q?=
 =?us-ascii?Q?if+tn+psUis23JhTlubjPOcD5+CR3WGK6tErbsKtWYIyPJNK/njGdm4E1POK?=
 =?us-ascii?Q?2dV8IDK10S50y2RjpgoBoRCghso030kQgL2azqZigKCit11mX/1ejuyyD76Q?=
 =?us-ascii?Q?hN4Mvd4iWeoELP4sJiPJGk5uVdgR2ddaqvhJ3bzizZmGXK4luL4GuI3h8Vvm?=
 =?us-ascii?Q?aT0eHbexU8ELJ9N1GBhIsQ8YSQUt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:48.6342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a990c76-5a33-45b2-8de4-08dc79369f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

From: Brett Creeley <brett.creeley@amd.com>

As the title states, mark unlikely error paths in the data path as
unlikely.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
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


