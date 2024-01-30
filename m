Return-Path: <netdev+bounces-66931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5B84184E
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E321C22460
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87555364BF;
	Tue, 30 Jan 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kcdZjzli"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0D364AB
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578271; cv=fail; b=itehjcwYrT7hczaeRMqXC38QXVzd0CHPXauKJS+J9VWK0kMHwEwwO0DQW+0GMoCTIF1PHOz4/OjcVeyGlhIMRjnqo45K2kQWhMlofN1onmNfWDz9LtVF1mANtJNV2iq8BX6+48bML1quV+Od3froLBJUYRUIaBWPg5Me/L+WDqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578271; c=relaxed/simple;
	bh=iL5lXyQWAEFKMD1KCjiJfwYmdVvwvQxMEdCZgH/4mMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMtOB/cmL4CwizEVjdwSXOUpRMOXn1RNmQHVh+YWi02Ek1okEPfO5bnKqrN2KHy8VtkoZhOmDAxPAhjHP2Ravv2XStAob5y5VvFq26Uo5g5RTyRWdiAxfqcFDNV1CbPu2HwNb0UA5/rwKdqHurZOdY/lXpGP0iSAI40TOuxPawE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kcdZjzli; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNw3TVxbvO6Jq4oHVPbFc0kkiG9qqOr3n0FT7u9mctP5NyNk/d/s9buQfB4MHNXrW/s5un6CwwA7zcfoowu4WE1Eq9ljkpXAy1cr3afxiEhHbI4oKhhKSdeVGg5eM9vdwIQnCFA6nzL0psEjQ8tZhezjP98jH8s2+ifXJqdiV3cSZa8aMXJiA5LdmTRLEJpRvwEw7Z2gsFFnz3RSJ4aH1pwuImCFIK0hLdBAiFm8UhFmVzb/9+zWEkKZ/HGcbYEaytf1V7mxvn1cOBm6jTZ9XcnK9DcQqRioC3e3U6e1UmuM9x2c1TUTa/pPZmDR+PctXCWwWvE2tbZ2cIpJD4uBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t301f4OhCMUG6dYYrx2rgTmyo0jKwpEP9FVmIjeyQDU=;
 b=jiXDrgvDmd572WyuzSVIJCEZRDUuZlTJNDw7Kvj5FdmGKOaJAQnLz3numUeyYfa7b4WgXJaMPsz5Qy+u2oxUSZr/fHOz3Vr1YAhaUG+uNEg6bgynO30pgznVc2Jka510YbGpucdBSHYBafYnxZujoke+Qe2Yb2pe9Upq3WfAN3A1upwsSl351UsLmhQCZ34R2SNTRkFtpz9o2iiwgD+eatbFLfIdc9xtcLKvw/Kq81JdU0rhNbri9Fcu74oZ92aeEW8Cu/kk856i6WRkKypjpIM9MZK9W+aoc6G1nsaOQ6C8DdCfx0j8Hm0HDs1ebKykdQJwT398P8yq21HpDbp4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t301f4OhCMUG6dYYrx2rgTmyo0jKwpEP9FVmIjeyQDU=;
 b=kcdZjzlifxK1HgK2AmA92aBk4gvIkPnCg31w1upBnlAAQcricwXlUqlWnj+abP3BXuMYTW5TtyCk3yw4oSx54tpmeVJ+0mffuPGddH4k171JWae/E8cAkwHHFaBtTVExsOQgyd1SMrqOrg3uEHFDld9I7UPAjM9ycvr1Gkuv4pI=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 01:31:04 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b0) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:04 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:02 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/9] ionic: add helpers for accessing buffer info
Date: Mon, 29 Jan 2024 17:30:35 -0800
Message-ID: <20240130013042.11586-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 05946122-b80a-48bd-b912-08dc21332038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d8OyDoR6DJGsWgrVnYwVB1Xcc0Gf7Nynm4j8nzVuFRE7kvPvi5T8/UYXb6NhYtQwfxbCx43tQ8HPm0wPSbXViVupQ+eFepiJsrOzrV3QCIS/0w+ytjXnv/8AivFq6oWCMxvEjoqQav76WcCME4wjwGGmstDpowbERW9/YeXP4rkC9nEITcf54Z0EZyWV7d1sWcA7HcqdAJJhxTxiq92XUDA7YUa67cgOdXSuC0YPs4nLSoCtcRqV0K5aPa9I3iPNsYJQfXkkhvHCe42njdXIeBQhCb5EnZcHSiDgC71/kAJ834PWBACHS+n4dG8MgA8fl/XUhw84/49s1/+E6+6l6xA2S0D3IruMVAqfwOb0Vrr3RvmjZRoE696IKqwIhF2BLX4nnZiqzijZsD/eLLfd7Qb9DpEjKlaMNpO0Vh2VXg/+YNhevNdm3Em5bvG/AKz8Hx6lKoqBOITy46yiTdR0HdbKLQMQ++2gNBlT77gFrZZkGwDGuib5eXyoxFfCfT+66Aewth8X0Y4ZhIghHzyAKFe1e1EAsHbaXrgj6efXw5UxO7f8jU24dTZtkOUChk+mizjfUaABrkdtjV5VYhh1SYVPaAhUl8ilrG4Q88/rO7kC2JMyWgUhe5s9XV6cw058Gwn8zRZiRQEYxTjOXFW0UQF1t1wq24wG0Qtn02t466puNyeDfOTtaarUZTBD2r70DJYqhrNsyde4K7+RvvMZZgDjrGm+VThLgc9gcER7F5BugqA5HBkSxfQqBVbMggQZAvAyBI4MKLkMddvkyH+BfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(16526019)(426003)(1076003)(6666004)(336012)(478600001)(36860700001)(316002)(47076005)(8936002)(8676002)(81166007)(5660300002)(4326008)(44832011)(41300700001)(2616005)(70586007)(2906002)(54906003)(110136005)(70206006)(82740400003)(26005)(36756003)(86362001)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:04.6936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05946122-b80a-48bd-b912-08dc21332038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

These helpers clean up some of the code around DMA mapping
and other buffer references, and will be used in the next
few patches for the XDP support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 54cd96b035d6..19a7a8a8e1b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -88,6 +88,21 @@ static inline struct netdev_queue *q_to_ndq(struct ionic_queue *q)
 	return netdev_get_tx_queue(q->lif->netdev, q->index);
 }
 
+static inline void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
+{
+	return page_address(buf_info->page) + buf_info->page_offset;
+}
+
+static inline dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
+{
+	return buf_info->dma_addr + buf_info->page_offset;
+}
+
+static inline unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
+{
+	return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_offset);
+}
+
 static int ionic_rx_page_alloc(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
@@ -207,12 +222,11 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
-						 IONIC_PAGE_SIZE - buf_info->page_offset));
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
-					buf_info->dma_addr + buf_info->page_offset,
+					ionic_rx_buf_pa(buf_info),
 					frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
@@ -262,10 +276,10 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 		return NULL;
 	}
 
-	dma_sync_single_for_cpu(dev, buf_info->dma_addr + buf_info->page_offset,
+	dma_sync_single_for_cpu(dev, ionic_rx_buf_pa(buf_info),
 				len, DMA_FROM_DEVICE);
-	skb_copy_to_linear_data(skb, page_address(buf_info->page) + buf_info->page_offset, len);
-	dma_sync_single_for_device(dev, buf_info->dma_addr + buf_info->page_offset,
+	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
+	dma_sync_single_for_device(dev, ionic_rx_buf_pa(buf_info),
 				   len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
@@ -452,9 +466,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 		}
 
 		/* fill main descriptor - buf[0] */
-		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
-						 IONIC_PAGE_SIZE - buf_info->page_offset));
+		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -472,10 +485,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 				}
 			}
 
-			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
-								IONIC_PAGE_SIZE -
-								buf_info->page_offset));
+			sg_elem->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
+			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(buf_info));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
-- 
2.17.1


