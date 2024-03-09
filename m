Return-Path: <netdev+bounces-78981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8EA877342
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34791B21549
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611620317;
	Sat,  9 Mar 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VebQDy75"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4881F17B
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009144; cv=fail; b=H5LkBcCLuZICspVSEaNIaUIHHwJhv+5NWP6S11IctXRLycP3k9tx6w50AVDSRadcnEZTACeHuqpn2g3ZXf/9O6uMWUhB0PRkQSS3hB8kyUVOhtFKYWVElzdpBWUuyp56VMlnZrzRlOUKmiSL2mn5P+Qg1ZO8//OZQqMhF083PD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009144; c=relaxed/simple;
	bh=Iid5myzLosFfDcG7uDACVLfxO8j/jo1NLcG3cT4MpPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHehKUv1gEPdMoXwGTZ2oMAnlS4DVe7WjvMUefeOcD+7+bVEw84AV9knvWl33xVffemmxNDmHCbQK//HsoWa+7SAvoYUJUcmEbgjwXEFsvYQprxbPFvuaa8imKRgrgF2S6CJsroC19iHsd1Ev5z1snP7fKBBYa68ntHBYI2A8vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VebQDy75; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkAxk6KWPbxBG00rW6D/Ego7vkaULvNaeHFFqrOWPleyrI4MefS+Euh1dqk1g++cLMpxQIkZ4Z0wGoQYstBI4aHFJOmx6drgdRYbrKaRDDaudzyCq4MxuyWJcfk8tPfnmOWbVRgAtGG/CgKxyfGGg18dQcs9sTjU1NPglOux82HjnIOWAeQaAEllOAXIrjVUbVyQ4U16WsrC1gBwEbThxOsP2cj/lqvABSadIAROS2jebCfEZJGT2Snxnk5vYMZV3y6nJ4+JYIf8y9M7HIpQCmw6Agi3sIZzXZPbVSJg+U48Fe/wKojjue69QCX5ir7yxvli8UEQwFdBAV9ClgWhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7Aiq2OhBPXyj50xip3+hu0UoMIsQIhkDtNPezgsnNQ=;
 b=NJKAsZ/oy38pMakoV2G5Gwg6viQ1nxpB9TxToCalwCfvxPSi7HJVz7j/6ZRUKktB4YRILKnLV9hUck4Q0tNyPQx1lThw4oAq10z6vUd6BNlHhys30Kkma3QeCv30D88djvAz90ZXBWTVKUGg1xCQZ0+EmAXF/3ikPxi42B9QtGREHIDwPzrbCVeEIqMJ5Zz/UIFPSElGATstfQl6KHttJ7xrt1WuY7Wz0UgUbgXXS5o3WhOyVt+pszwHcC27xYLMPB2UWciRNA5X+9aKF15ziEHFWE5l+QgMoCbF+htqpYdRjBHHKidked42ezpdbI/RtP4xK0C6FoBs47PCe3JrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Aiq2OhBPXyj50xip3+hu0UoMIsQIhkDtNPezgsnNQ=;
 b=VebQDy75K6PWINuPinxd4aRz/5+2WNlSIcUkvzieQzdctuNIQHy+j0ZvklFDZuDyqPgmrHyXWdzhGeleT0TR8kTDI/LStUoWBeDNDFR4ng4KwZgScNLRzazmtawSHxmLFYpbejEyL5YhjVubcUqumPwISGPpamXUVGNgZDFYrwNPnIK39YPfYzmyTRB4lF161yQv5L+ixQiWHjeQ/JuFl6x6aXiWtWUJwFwAJYRzdPUx//YmNM1D/zKm3HRrmyd9UrZh1wFKRCGETgGHN0XCgrzgSeugH63IVuOg5E0BuA1RZ9KIOolw2h23rfKIer7qNMa6CZNL7jw0swXCtQWwvA==
Received: from MW3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:303:2b::19)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 18:32:19 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::17) by MW3PR05CA0014.outlook.office365.com
 (2603:10b6:303:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14 via Frontend
 Transport; Sat, 9 Mar 2024 18:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sat, 9 Mar 2024 18:32:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 9 Mar 2024
 10:32:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sat, 9 Mar 2024 10:32:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sat, 9 Mar 2024 10:32:12 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <u9012063@gmail.com>, William Tu <witu@nvidia.com>, Martin Zaharinov
	<micron10@gmail.com>
Subject: [PATCH net] vmxnet3: Fix missing reserved tailroom
Date: Sat, 9 Mar 2024 20:31:47 +0200
Message-ID: <20240309183147.28222-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: b4806ec7-383b-498d-8341-08dc406740c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NplG0C/yB2IaY7STcpVi+KWbTsBcs6nVpSegzJO5NclFC/+VNm3k40iweKD4/Qk7fyuoeCWLyH9UiwbXlkqA9V8Ve4kEl93OUBWSBq+R28VlwopDa0e//Lr2Bk2UyS/p/sqzS+32P+Fhq/+Y+8GxBZCb4tzFor74XSdDUx/aZ3rpRL/YgAG+ZF6M+7iabhkLvXaGbAZ/8JLbiaVMn0a55nT2hGnK92klVgLg35Xe2hK21KFGRilic0w/DAeD6r9OdICuXk/p57qfaSpqEt1whpa6lFmTfYAMIvzx9gluOIBEHf91ugQyATB1Ow1yTRVJHE1jcodNxiNd1QBdfTvZc3YTPhl/l4ee71auqIr6EeC2CmtM+gZb4nMUAmUEjHlNX21s3PmIGutFTD4+3i/LTRerCB2SPJgs+Fr4eMgzRaxAySNpk/ObXvokbFea4nFWOqW4LRvN1k3r295yVc7+vdZAzEAAnBqkOKqAShyPKDFQuCQg+llcOJ1aEr44OQCWZnkIyrRga6eMvRP4sDa6qEZO0HM1TaPXYB0IY+qKcZhlTPhltYlzpQTf4oqDN+O2gBAhI3AxZMM9mFoY1S63z0FydC6HKJeQeQ9abBUH2CPztZPHuPQGf9mpaUp84PSCbwIJTp+9pkCfBufpEGh+bYJr3mSPAGVhAHZDsh3Gy9nJnzY1va5JV02Zcb1Q9h44uHTI16TccJcRjDnkn2G7LZ1HfEzM75nR0MQYtE+OkzgCzemo9r12lfbbLHCOs/fI
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 18:32:19.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4806ec7-383b-498d-8341-08dc406740c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

Use rbi->len instead of rcd->len for non-dataring packet.

Found issue:
  XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG: missing reserved tailroom
  WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/0x20
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.5.1 #1
  RIP: 0010:xdp_warn+0xf/0x20
  ...
  ? xdp_warn+0xf/0x20
  xdp_do_redirect+0x15f/0x1c0
  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
  __napi_poll+0x20/0x180
  net_rx_action+0x177/0x390

Reported-by: Martin Zaharinov <micron10@gmail.com>
Tested-by: Martin Zaharinov <micron10@gmail.com>
Link: https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com/
Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: William Tu <witu@nvidia.com>
---
Note: this is a while ago in 2023, I forgot to send.
https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com/
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 80ddaff759d4..a6c787454a1a 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -382,12 +382,12 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
 	page = rbi->page;
 	dma_sync_single_for_cpu(&adapter->pdev->dev,
 				page_pool_get_dma_addr(page) +
-				rq->page_pool->p.offset, rcd->len,
+				rq->page_pool->p.offset, rbi->len,
 				page_pool_get_dma_dir(rq->page_pool));
 
-	xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
-			 rcd->len, false);
+			 rbi->len, false);
 	xdp_buff_clear_frags_flag(&xdp);
 
 	xdp_prog = rcu_dereference(rq->adapter->xdp_bpf_prog);
-- 
2.38.1


