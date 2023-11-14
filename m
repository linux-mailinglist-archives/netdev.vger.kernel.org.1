Return-Path: <netdev+bounces-47778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B597EB5FD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DCF1F252AC
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE02C1B0;
	Tue, 14 Nov 2023 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsLvOxWf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B42C1AA
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 17:59:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE1FD
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAphjtX46K/OycYNc1BXTmVaTw6lBOpWJ46+Kq/ee8QKTZLf8//ZWr58zVs3eq5ZwVgqU3uV4brKcuQ8J0owYR/I/0Qgoh4zNmeHRWcQFOWdYmhUKfwoWgT/Ibv8hMr9HQmjYVQNV4pi/ld8xB9JIMFA0D3NowLNwyEZjsTLUONsO/mWkYAXWCsSFfGSr9BmA2DYffK2pplwoVjIuYBHQSck04Kie2PYpq+k/p8NJuVhMQ/sWvIxYUxvhmfsyIUHXCcjM3zwxVgTpAJ6ULr90v6nE7PtyS/iXlEFUFm3QXCE6hTIe7Naqh7iZ8I7eCme1oHRfDu3Pz5JMAGHF/Xt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6EVJcnfezbrgodo2/MdaqjWLR5RSMF+jqsiNuT/idI=;
 b=VjLB2ir5crUOeedTduJBlNbn194cVwp0I7sDcX3DFD44vv8LIZ2DG9glCRpHZLnR4+luLPDOeMI9A+gbpbcdEGTN2/OWAmc5YKP4Ef2gC4Orgijs0bts8YnLNLOOvNTDJ6vo1tQ9IOdXgGNnTWMAIYnvLRH3Ih0JKol/FlFWf5zwx4gdfD3dGC35Tue/WEI2SGTbiYy9PLL1e3fmJ5LczcWAtHzRjw24lNz6HVNilsB5sYx0B+I6qKH5IWXdOXLg8G57pIUvLMmW+GoyRcxiyNiHR1Jb9t15cON/ENXqfU8YwWqvKGm4QVVkMg+Uxz9VM3kDulJXv/88/CYCMwFZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6EVJcnfezbrgodo2/MdaqjWLR5RSMF+jqsiNuT/idI=;
 b=GsLvOxWfKYCCp+gHWKvZAmksCk0km9Croc8AD2Ogx9+h1L3CJ6qkDf0lFlvu+DPUJHYL5YKayFJu+T6A4EDZeZDvkERmrojXTx8l12QGE/AtK7uDoYV1OVo4m5uTMWFcHObON9nOddRP0yggQxiVQev25/ytuH28xquV+9GQJo9k0KvV9xpaRldbiDZhcNiZPz7z3GSqO12j5qRMdSJRs/Fz2W3qG8zGBH04lFvZ5eLvgVRDLRLzI30vxLzXkvksoQ0p5GrmfSxx7LIJVZEXD86yHlba+KQXNjKMDIcrIuTQdEM379iOxaMPRgz2FBQDM20DUY05WIMTRV55+PMFLw==
Received: from BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 17:59:35 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::6d) by BLAPR03CA0115.outlook.office365.com
 (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 17:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Tue, 14 Nov 2023 17:59:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Nov
 2023 09:59:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Nov
 2023 09:59:20 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 14 Nov
 2023 09:59:18 -0800
From: Vlad Buslov <vladbu@nvidia.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: <netdev@vger.kernel.org>, <vyasevic@redhat.com>, Vlad Buslov
	<vladbu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net] macvlan: Don't propagate promisc change to lower dev in passthru
Date: Tue, 14 Nov 2023 18:59:15 +0100
Message-ID: <20231114175915.1649154-1-vladbu@nvidia.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e0bd53-6306-4b05-ce8a-08dbe53b7659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEEHsqTyugbRxjP0GdbrJpSr8JNpnzPd9kxlguo3ieFpmQI1nN/vmkc/yyUEQfc7LKYKnKBSWRa/Vn3P1Qua5pM4yDFCS1XkLk/TO+UPSVnk5OPCCiHIGkj5qLxobh9YfInIu46HYWHaR8DbnWteFhtkAC184tPj3ZzqJv/qpXPXoH0P5engSqUDJ4K4cyZeXFlF84q9DZQ89VxYfp6O+VY0GoK6bAssTKMBz56kXgiSgpez8Ec5Gbm+5W1JcFvrxrz7czk7cx3cOgwzBQv1bVPMo+4g5bD5cArI5b/5Km0vpgTwCDGANpVp4mYoXWrt7DhpBZd3h4QS7oJ2atYzDrHKO6o2hSPksIw0QNqx7Vd1Gu4EdjP71d00dOy1P5Ij/feTi6bFFzUC28AkuwEOUeqZzfAxNzCwLeFUZHWuuHvIhEErtJI4UXCEu0bBQk3DLZ0IctBRejE6ydERqyE6QSrvVqRmTwqT78UUK556k8rXz799EphKcf3HehO45tDYdAutQnTWYtsjV9ksfEp8KxwX7WGSZo7+mK2pQrIND0Jqtdb8Exx8T+elsiY7zAOmro09EKDjOHWmCzxlYZWItqusfK7wTa2JshjqMPyH5TPUsLpSI3ctbi+CgH/UuRM6KLJLkXLCTGgOrdeGkd2hZCth6Fz2gB/ZhPmTwgZJu00TPuNite+qCycCNT2zYbz0TigaQsfxsziaVqVnoqVKoUasrWfema3X1VrMmT+iAfuyjFSqjmF2n0ZRpd/41H3B
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(2616005)(426003)(40460700003)(336012)(107886003)(1076003)(26005)(2906002)(478600001)(4326008)(36756003)(86362001)(5660300002)(41300700001)(8676002)(8936002)(316002)(70586007)(70206006)(54906003)(110136005)(82740400003)(7696005)(6666004)(7636003)(356005)(40480700001)(47076005)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 17:59:35.2454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e0bd53-6306-4b05-ce8a-08dbe53b7659
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

Macvlan device in passthru mode sets its lower device promiscuous mode
according to its MACVLAN_FLAG_NOPROMISC flag instead of synchronizing it to
its own promiscuity setting. However, macvlan_change_rx_flags() function
doesn't check the mode before propagating such changes to the lower device
which can cause net_device->promiscuity counter overflow as illustrated by
reproduction example [0] and resulting dmesg log [1]. Fix the issue by
first verifying the mode in macvlan_change_rx_flags() function before
propagating promiscuous mode change to the lower device.

[0]:
ip link add macvlan1 link enp8s0f0 type macvlan mode passthru
ip link set macvlan1 promisc on
ip l set dev macvlan1 up
ip link set macvlan1 promisc off
ip l set dev macvlan1 down
ip l set dev macvlan1 up

[1]:
[ 5156.281724] macvlan1: entered promiscuous mode
[ 5156.285467] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
[ 5156.287639] macvlan1: left promiscuous mode
[ 5156.288339] mlx5_core 0000:08:00.0 enp8s0f0: left promiscuous mode
[ 5156.290907] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
[ 5156.317197] mlx5_core 0000:08:00.0 enp8s0f0: promiscuity touches roof, set promiscuity failed. promiscuity feature of device might be broken.

Fixes: efdbd2b30caa ("macvlan: Propagate promiscuity setting to lower devices.")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
---
 drivers/net/macvlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 02bd201bc7e5..c8da94af4161 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -780,7 +780,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
+		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
-- 
2.39.2


