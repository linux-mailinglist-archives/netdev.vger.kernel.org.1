Return-Path: <netdev+bounces-211776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A263B1BAD9
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137D63A5F7B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B121FF2D;
	Tue,  5 Aug 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ap8hZIuI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC682556E;
	Tue,  5 Aug 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421615; cv=fail; b=pnSobOIzsNrjuYRFR7rJ0MOL8Edbb25Ft9VqfwkphYhtpTEtw26Jdeenkdy1cdFxh/kkxlRXVxakONdLpnIyi4s326ECrfgMB/9vyLK5hA2h1PBEUHUz9UzsZ/8zBDhEJv/tD69eBlDd53IqM2keUyNq62zembLBjm7FXg5GSC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421615; c=relaxed/simple;
	bh=t6NK4gEmEYUAuzyjCICfQ7zVG7bLhfk6EMdIn08lfDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pij6mGGXJsD4TtcK+Lg7339mTNkY2Mo7enOa7/7MFjffXkRiUZeCHu5/qABrZGuR5nDzdIC0Ud3q0LVCav2XRa3EHKn8oQxh37Mgu0DSBjfLLj9r71cU8K1nlnmOay63u3Y4/oVnlxxFJZAqAFSaIWeMzxSafXc+u8Rxx0sXX98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ap8hZIuI; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY/byqbDyzcBrinQcy21QNAARWlLbZquXlALHL7v39uIexGYbHrfOUcOLFxKQ0kxdREIcHmqWclO2Xncp37vtlt8wohGHSEBp7+hzcXqMr+0a3IF85a9S1D8UVVyxYLSjo8NhKC8vjeh2fb7Ih+0jM5KuoUcy8mBNhTLlGXpmBR0D/jLkIw2YosfOAl11OcaNAwmRo7SfK7qJFsWLUnfej3MtZ0NVH1wPsWEAv4QvVFtBVeF6a2cTyFOObmrI/4eR8/xW2ZZ7HbMP27Q4eCFGKvAxLcJyqVuzKrLDRm1GxyLd5fKO9IxdMloA6zx1JekzwzIdjfMiArstbPkPLDtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ghnXTUujMwe7QunMYY2cqp0o8bkLw94Sl4tRZOFUJQ=;
 b=IM9BsgrFvo3NHhr1cXUzlGJWB0476FQUTESZfqsfrhSqj4j30nVoXDNw9iNsIkxBp7A+ayGFZiaqCxHyAa5q/TY48HE3Zk+XCNNZ7T7sQr6KloT25zAyqrMJN7lyQ6uNFLtAl8OmlQuRQ2lL5T6b13XIOkRAPrD8vXsWJp52YSQktAlJCVQJh9XbgXQKMeaLteQlTfusPC7rAKfN1TbvTBY2VM9I3Msv38OHppxnOUZMwtcIpGpSto+jUEvy9kVzXqoDNVyupRDxuJrUll4r6Mwo+9s2jVfPCtoMllJY4ODNml/4Fh7NCi4C8ykjn3Q0p28KbkClE3bOwr6mnU7DAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ghnXTUujMwe7QunMYY2cqp0o8bkLw94Sl4tRZOFUJQ=;
 b=ap8hZIuI+6raltjYEQ67aYFDH3DgG+9E832Nhq6i19tobVn3NAyGbZ52pGyIh+9quiZAEQLmAGahmav7sjez5+F4sb47iTLImNSTXm4cWp9PI0XhKp/cgZBJbzUGtiex7czJkUmAQgfQTjM0uTpIP5KPOjP3OmMNsA0Q3VaSm0k=
Received: from BLAPR03CA0180.namprd03.prod.outlook.com (2603:10b6:208:32f::10)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 19:20:08 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::95) by BLAPR03CA0180.outlook.office365.com
 (2603:10b6:208:32f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 19:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 19:20:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 14:20:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 14:20:07 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 14:20:04 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head pointer after BD is successfully allocated in dmaengine flow
Date: Wed, 6 Aug 2025 00:49:58 +0530
Message-ID: <20250805191958.412220-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: e5118afd-ec5b-48d6-0abe-08ddd4551718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANtDVkKiw8+o34Yqsz++fZ+6+fi7DpurWGTrUkQhy1sAbABw85BOfG5lvtrN?=
 =?us-ascii?Q?cSOlR9+3I8jafR0u7/2peAuGJyYuBC5TNCfym4VpWLfsHrH7i0emZTe01fCQ?=
 =?us-ascii?Q?sJtP03Dgx6Msx2YsfAHFgrDVEb+URyeQ4DV8K1327/eW0miiUurEoTBddliq?=
 =?us-ascii?Q?LXLVxYv1ApqnuiSMK20wcQmn8PDvIZqUfYlrqYlz8vI0LFpqJy5Mu+UIVSjh?=
 =?us-ascii?Q?X60juCdDpaz/CO1qbT77SngHGLCHGK1UxEfkJckxxulUJ5Xb3W300HkhFSZg?=
 =?us-ascii?Q?xxxM+nSJNZ0VdrLS+sO1LxVa5g6BXgpJJB6b8zpvXzRkLirG9+bvOBQbUi5W?=
 =?us-ascii?Q?jMTgc3SGDBQglxXK8tC2aMMk1RtJu5QXiuqEi6998YLqUp6EwjMioWIVaFOY?=
 =?us-ascii?Q?5nW7vo0xbNI1DcUtEVblwPjinxKPRm+9Qyllhm/bU1/0Q0qPZryFBgt5ft/8?=
 =?us-ascii?Q?VIXzX+vEdhPgR6zyzH14L0uaNXC5Aux0+hZW7UHlbWJYxqDciTHwMSi3fgHe?=
 =?us-ascii?Q?npOcpg43kkAQBsUMsxhw5LkS2d92+AsQYGbh9q3xMNKvrBrZhz/wr/YH1Bfu?=
 =?us-ascii?Q?Gr14NPx4XgyEQiRgNMgmhYfdZhqRn3PCI4IW6n/eng+SzxrN9ofR27lJBA3p?=
 =?us-ascii?Q?2Ikcp2CfiXFQwKIjvaoeJ5kJEgSTCveXjTBc5x20K0id/HX2vvwhwJ9qtlHI?=
 =?us-ascii?Q?HyME/PcSy/16u7Ivx+OoCNjIWESs7U/4G+QWcv2TrppxWpZpYmR4H+C0MtsV?=
 =?us-ascii?Q?1w57rpKyn9gBkcIuJEBSFvt5cdZ96nMm4tYe2GnHl14eJo0/u3flszR7p2ax?=
 =?us-ascii?Q?b4Vk4RsQ87cNJvZTO0eqSIsu7ownmk4NMfyQhAdy/XH4iDiDtEVIvkJI2tuN?=
 =?us-ascii?Q?BC9N4LiWHm9Z21UqT9C0oQ7eKZOW74CNeAusmgZysETO9OYmDfkLhDhA41v7?=
 =?us-ascii?Q?s+VyceMQwf4Qz5XbM2ti2klICTkgQSoFNjuKD/v5kntSMwLtzs/IOZRM9ZF1?=
 =?us-ascii?Q?lBGBj0el0ENuGzALNduT3JbUSaRrZHL5tMCCniP+EL8SknP2rAMAN/Aia7FV?=
 =?us-ascii?Q?pCozLliUQyQ27OL/E3dEgQdpG1W63cwPjj9cwP4Z1//Dhn1vL/wx3PISadId?=
 =?us-ascii?Q?HjS77o41HVHF6cp8ueYpBeAKJVzZmaqWdRle+WbYUdwmbYxpiRWrJRM8ZmVi?=
 =?us-ascii?Q?olcXr1+aFtRo1hwtUrBhv0/HS6Zw6CBYPUF9hpcvcGLrif8ufBid3nbOh9Fu?=
 =?us-ascii?Q?69y0pzZ5/todPOv01IX3KM3l2wEq7fedorHYsyO4tmnT5FxOcBJTqZc2NNyk?=
 =?us-ascii?Q?7kRmyMNL03smrDVnfYyexoL8Ot2c2vEO78RdmF9R+taNKl2gf9L+A1PDoLsN?=
 =?us-ascii?Q?MhseCKtjfY+JsWG/ykUK+fORA4xaO1GQ6NXxuHmhXo8CYdDRre0A1gOaN7Nz?=
 =?us-ascii?Q?tDgRWm5fslDDZ+4LGyExJA4rHs7AhX4uLBKAnHRkETBrhCGOep8c9HxvBOz5?=
 =?us-ascii?Q?W0xb3yZONFcHwLeQItw9vvAn7ZFAnwsn908P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:20:08.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5118afd-ec5b-48d6-0abe-08ddd4551718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

In DMAengine flow, AXI DMA driver invokes callback before freeing BD in
irq handling path.
In Rx callback (axienet_dma_rx_cb()), axienet driver tries to allocate
new BD after processing skb.
This will be problematic if both AXI-DMA and AXI ethernet have same
BD count as all Rx BDs will be allocated initially and it won't be
able to allocate new one after Rx irq. Incrementing head pointer w/o
checking for BD allocation will result in garbage values in skb BD and
cause the below kernel crash:

Unable to handle kernel paging request at virtual address fffffffffffffffa
<snip>
Internal error: Oops: 0000000096000006 [#1]  SMP
pc : axienet_dma_rx_cb+0x78/0x150
lr : axienet_dma_rx_cb+0x78/0x150
 Call trace:
  axienet_dma_rx_cb+0x78/0x150 (P)
  xilinx_dma_do_tasklet+0xdc/0x290
  tasklet_action_common+0x12c/0x178
  tasklet_action+0x30/0x3c
  handle_softirqs+0xf8/0x230
<snip>

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6011d7eae0c7..acd5be60afec 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1457,7 +1457,6 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	if (!skbuf_dma)
 		return;
 
-	lp->rx_ring_head++;
 	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
 	if (!skb)
 		return;
@@ -1482,6 +1481,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	skbuf_dma->desc = dma_rx_desc;
 	dma_rx_desc->callback_param = lp;
 	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	lp->rx_ring_head++;
 	dmaengine_submit(dma_rx_desc);
 
 	return;
-- 
2.25.1


