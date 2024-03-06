Return-Path: <netdev+bounces-78178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5B8743F0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731C5B23FCC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EF23759;
	Wed,  6 Mar 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDcRVD2X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D443208AF
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767829; cv=fail; b=TCq9OC81b9P5tPljROakcPTkWKksdJ3OGyWtSgyQ1GOpFH+bN9iJYj0kh2oogLiUGjEpbS+mT5/6bn94gS16Xha5WP7VaUnrxPeKt2TH5sePN/LX3EXEeUfwx8HdEAqruW5G4BfKvJDSitmdIKIFvRXjbjprCKLi3T5RZQXC6Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767829; c=relaxed/simple;
	bh=LV+YCs9XXvVd+4/dXcGFAvTGMPNrfzIbYuZOGlrk9bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW0lmBGGDUaeHdhsrKjvIVnlspSvZDq2BjergZ/OO6fIeqfc2CeJPHMRz4aFgb1cEWzsvW0zf+KaClaif2+zOqBWccG8gtfOJEN2y/4Kvvxmk3ko1kynvIuJaq0XkqsyuCIPc9hr0o9tIlHzkzhi2UDQ4ro2AjraNEiQs64svaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDcRVD2X; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6iKBGFshSlYwBMfWhEK5H7FtA3PFi0vVucun1MKAV8dXiXMqa5iPlcWtzNLXaS4zaqLReIAR9R6UJKPlpABYjXL2cP9rvw6JjFdkuBlSI6Kb4X4nILOFu/hI04sI/nh4HCY4wqmUL3ECWyvUVGV+kzU3JR1xW4zHfEfiPazZelPdJGdsI/278cnCf30CdBS+xQBdOSekaiwM3j1HdHls4mAC3B97/26K89kQwUQB+5VCbdkYuVk4OCpni8SvuQL6xaQsOr2Xdlgidlg4bY8LSsYmgroUlwShVxz+1W8ULcm+jGJI21ANTf8qxbV2NE5Di33Ts+4j8tGdLRFg6ookw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3k/9gO9ae/Fv7HYGjZXjLEkWqntL994zoyESuvSTk0=;
 b=JVYMA3K8hJrL495ddbioV/epvCzbuHEDVtl6cZSULwX5UCE7SS+1gTeRhHBrUmKBgGLTbUMLILeDuzp2MwvLURqGOuqIWAaXxV0jWv6ZX2++KMcODxiyMp2rujw0OeEadjQyFV4KKpeQNJHq5y4Ac+t/JBiNGgii2upcoMO4dFdwbT1ooK/xAZeB3ztFHOkFSjTHGVowPReLVi1IX0FFwV4mbVY78zmmoGFwLjY886L9l/Z7ttm/9MXMskmTdBK74ZffEdc7TIXeMvJTajR6DXb4IrR8a4nh/gwETxbHBaUanNq1sh6h3GgtxOwA8I+i82I7UbYkVn/Rwg9DFRsKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3k/9gO9ae/Fv7HYGjZXjLEkWqntL994zoyESuvSTk0=;
 b=SDcRVD2XKTNgqrlIiNTqV5M3Yhd40oyd/XBfGXMSH4xg1BBf5rsYsrRoEdmj5v8E+2Tga+HQ3A4ZQf7Dx2U0wXqB4ut4CHoBgHBvwtOqllxmjqKQnlaL+UUrcOjogHBceHJ4Cp3fUvAQJsAczJBOJ+6fTKIj6wsecd7jtWkAXQc=
Received: from SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::11)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:24 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::76) by SA1P222CA0185.outlook.office365.com
 (2603:10b6:806:3c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:22 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 08/14] ionic: refactor skb building
Date: Wed, 6 Mar 2024 15:29:53 -0800
Message-ID: <20240306232959.17316-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8cbf9f-90a2-43d6-7b08-08dc3e3565b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nilOslSjBqqi9j0HDK0P/4qkODqT/Hr5aSwexND5/NpY66OKkSfZubZJZydJXzDdnHph+IGUZD9JjdO/ekPLpZlthpc+XJh4j1vAr5+vYSwVM6lmLCmuooVtBpFStE8aLopzaXXIZ6rjSb50SZtFf21UmYOJmxi5olkEUP/ufLkBYAGcJXIugivxLeqhpijdgNIGuYDSlExzRtWB19Af1h1Nzk6Nb+xpYZ4xCoET1krboWzFtttUkwrIpXdrijY+dKnXYgdlMvchRQwKnAqNaJuSdqowMwVcVt+5XqMq4baQnO3m4CdVKQS2SBwvaOE5UWETfpFsnbApc8Bj9JXP7+aeeTsIQm3QXJH3DVgNxkIHJEu1Rpig3X7uUtivXkTW8rfGMSRWzuvALmrQ6tCGk0fSJhoOdR4F/x7RjbfQgb7uq+0BjcGhnV2xkayfA0wtwiEkjWbp+kZKDcHZ6AhOHnQgApkVzHlbzNwC4LDaEqTLp6DowqbqnLQXGr7HTvSr3+pmpck0lId6z6NeSClIbP4KOEa9nTz/1rpDzDbFvwJQmHsgA2mxRuuM4Wr3IZvs/AM9xFRytu3RGMFEJGGsLIjPJh7+/QV4EEDkk6elKFqEVA6cQsWsdEu420GoxqZvdSCTJZ+3Cqq3uEaA2ecIE9nxhgDAmKnbhMIISBPxpZN+LCSFsiQixWiTseFwoVP7rtyEnYJ+YOp6AcQ9eRc2IUQ0vqlyyK3nZSgVfVI/2L6MUJqhvRoD2V19FZbZIQmW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:23.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8cbf9f-90a2-43d6-7b08-08dc3e3565b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

The existing ionic_rx_frags() code is a bit of a mess and can
be cleaned up by unrolling the first frag/header setup from
the loop, then reworking the do-while-loop into a for-loop.  We
rename the function to a more descriptive ionic_rx_build_skb().
We also change a couple of related variable names for readability.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 118 ++++++++++--------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index d4fd052fc48a..269253d84ca7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -185,7 +185,7 @@ static void ionic_rx_page_free(struct ionic_queue *q,
 }
 
 static bool ionic_rx_buf_recycle(struct ionic_queue *q,
-				 struct ionic_buf_info *buf_info, u32 used)
+				 struct ionic_buf_info *buf_info, u32 len)
 {
 	u32 size;
 
@@ -197,7 +197,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 	if (page_to_nid(buf_info->page) != numa_mem_id())
 		return false;
 
-	size = ALIGN(used, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
+	size = ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
 	buf_info->page_offset += size;
 	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
 		return false;
@@ -207,17 +207,37 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 	return true;
 }
 
-static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
-				      struct ionic_queue *q,
-				      struct ionic_rx_desc_info *desc_info,
-				      unsigned int headroom,
-				      unsigned int len,
-				      unsigned int num_sg_elems,
-				      bool synced)
+static void ionic_rx_add_skb_frag(struct ionic_queue *q,
+				  struct sk_buff *skb,
+				  struct ionic_buf_info *buf_info,
+				  u32 off, u32 len,
+				  bool synced)
+{
+	if (!synced)
+		dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa(buf_info),
+					      off, len, DMA_FROM_DEVICE);
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			buf_info->page, buf_info->page_offset + off,
+			len,
+			IONIC_PAGE_SIZE);
+
+	if (!ionic_rx_buf_recycle(q, buf_info, len)) {
+		dma_unmap_page(q->dev, buf_info->dma_addr,
+			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
+		buf_info->page = NULL;
+	}
+}
+
+static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
+					  struct ionic_rx_desc_info *desc_info,
+					  unsigned int headroom,
+					  unsigned int len,
+					  unsigned int num_sg_elems,
+					  bool synced)
 {
 	struct ionic_buf_info *buf_info;
 	struct ionic_rx_stats *stats;
-	struct device *dev = q->dev;
 	struct sk_buff *skb;
 	unsigned int i;
 	u16 frag_len;
@@ -225,54 +245,41 @@ static struct sk_buff *ionic_rx_frags(struct net_device *netdev,
 	stats = q_to_rx_stats(q);
 
 	buf_info = &desc_info->bufs[0];
-
 	prefetchw(buf_info->page);
 
 	skb = napi_get_frags(&q_to_qcq(q)->napi);
 	if (unlikely(!skb)) {
 		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
-				     dev_name(dev), q->name);
+				     dev_name(q->dev), q->name);
 		stats->alloc_err++;
 		return NULL;
 	}
 
-	i = num_sg_elems + 1;
-	do {
-		if (unlikely(!buf_info->page)) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-
-		if (headroom)
-			frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
-		else
-			frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
-		len -= frag_len;
-
-		if (!synced)
-			dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-						      headroom, frag_len, DMA_FROM_DEVICE);
-
-		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				buf_info->page, buf_info->page_offset + headroom,
-				frag_len, IONIC_PAGE_SIZE);
-
-		if (!ionic_rx_buf_recycle(q, buf_info, frag_len)) {
-			dma_unmap_page(dev, buf_info->dma_addr,
-				       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-			buf_info->page = NULL;
-		}
-
-		/* only needed on the first buffer */
-		if (headroom)
-			headroom = 0;
+	if (headroom)
+		frag_len = min_t(u16, len,
+				 IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
+	else
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 
-		buf_info++;
+	if (unlikely(!buf_info->page))
+		goto err_bad_buf_page;
+	ionic_rx_add_skb_frag(q, skb, buf_info, headroom, frag_len, synced);
+	len -= frag_len;
+	buf_info++;
 
-		i--;
-	} while (i > 0);
+	for (i = 0; i < num_sg_elems; i++, buf_info++) {
+		if (unlikely(!buf_info->page))
+			goto err_bad_buf_page;
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
+		len -= frag_len;
+	}
 
 	return skb;
+
+err_bad_buf_page:
+	dev_kfree_skb(skb);
+	return NULL;
 }
 
 static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
@@ -641,6 +648,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	struct bpf_prog *xdp_prog;
 	unsigned int headroom;
 	struct sk_buff *skb;
+	bool synced = false;
+	bool use_copybreak;
 	u16 len;
 
 	stats = q_to_rx_stats(q);
@@ -655,17 +664,20 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	stats->bytes += len;
 
 	xdp_prog = READ_ONCE(q->lif->xdp_prog);
-	if (xdp_prog &&
-	    ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
-		return;
+	if (xdp_prog) {
+		if (ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
+			return;
+		synced = true;
+	}
 
 	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
-	if (len <= q->lif->rx_copybreak)
+	use_copybreak = len <= q->lif->rx_copybreak;
+	if (use_copybreak)
 		skb = ionic_rx_copybreak(netdev, q, desc_info,
-					 headroom, len, !!xdp_prog);
+					 headroom, len, synced);
 	else
-		skb = ionic_rx_frags(netdev, q, desc_info, headroom, len,
-				     comp->num_sg_elems, !!xdp_prog);
+		skb = ionic_rx_build_skb(q, desc_info, headroom, len,
+					 comp->num_sg_elems, synced);
 
 	if (unlikely(!skb)) {
 		stats->dropped++;
@@ -732,7 +744,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		}
 	}
 
-	if (len <= q->lif->rx_copybreak)
+	if (use_copybreak)
 		napi_gro_receive(&qcq->napi, skb);
 	else
 		napi_gro_frags(&qcq->napi);
-- 
2.17.1


