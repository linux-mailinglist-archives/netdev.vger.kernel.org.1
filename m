Return-Path: <netdev+bounces-96583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA148C68C1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216092822B8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49011442F2;
	Wed, 15 May 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLwOcP7j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA15143C56
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783513; cv=fail; b=agaWXaJXcrDoaQv621shKnfINlndccEg3iHI+b5i3o0nfaD4x4qJkao9oMdwqHCT40DeXdHe5zQotQN0JZRzljz/aR5btPlciT6Q6Rpv4m00FQ0NQ8HKKT6D9pSeZi2iyvBNsqb0h9DpPjBKn2wcxf2b2G6TGjSvyk0VFH8l/IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783513; c=relaxed/simple;
	bh=vI3Ej/5h6nkH5EpM+ro9DnFDqO8v9BdnHlT7gK0+XjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FLZalSFv3U56DzdgDABXQCkTHpm40yU+8n4fMr6ZINuZsWzIjz0wvG1D0BpHfdO9lI6IBFtW5Gv/gxokDF2WveIL79bsJLgLyP90l8zqf9v9uZD3nkgqc/TcL6bUK2xxKSJDjM1UL6o7vEhG9hpL1EPQXjknd0XFQTnFvq5i8tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLwOcP7j; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO2l5UumnUxVrQV+ho6ojdJ+thaXjxGXZ8RpxTtd7AQlFjvv8EVnk5+xqUxf9Z5EnUlSB1Zl7zLyLqR5q5WRAIuR/qAVG4DwsZ6kEthq/UHb8OfOQ5BC9OyOkqamhMkteSxTiFSRv6hUD6uCpUE+4eJSS9XAfvYWtrFkdFlazscAKKB4xScfrMfaRev7NmjLQuCLrH8oY1NtmsKanaoUH9cQMBnuG+SETTz7jDkwDfkex+1TxxeaqiFIo0DfDeq6VmrUeLU+7anRGCUhbgWXnoCMfVt5Xq9doBL2afzbJb6YBnHIQy8tE5tKZPuFJIXjfV/hQcTZT8sufwUI7ppNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je5K0/13zLP/JEv9q2HPCYs5xFeUWHC7kXwd76vKgY0=;
 b=FDHzmEsWqtRXP+zSBTrxnsacAbghbn5w4cXwPXrNK+/eN3DWtNFLjFEcfqMRXCNHxV/rszNZA1AjcoaN/hHdjhDClNQMWAwAyWsA3QJBK57icJ1n/dCEInJgw8kXCdRuQiLLVa0Q7yIjTOuyf3te6REtyYJZGtTbWHcFoxctfDabapfiAax/DXuFhurq8sZ1wnGYdutRylORQ77wjKQn5acorpKC4WcQTtPNnaD7EyaX5xKswJ8kdeNaw/VYUqKKy33TbFmaCpSYdy7lYGN7/wreLM0AP0WAfSnDzECQJntO9UAGbmUIdUKJ+9jixfeYoJc8zdoCJM4Nks69+cuaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je5K0/13zLP/JEv9q2HPCYs5xFeUWHC7kXwd76vKgY0=;
 b=eLwOcP7jUbAY3phtHuFyJViHGq1ozmpjNGErmBJsEYQSgc1WzW1B4ZlQILOGynWIUw7clnRLX2UuUVB3hK5qxQn60+eeTtAjDC6j/G4BlBi4qHTCHLwYfoWyXI7yxxlebPCLVBZ6E4F5p2Fip9IqNYkKKEAzzLIjA/3UrpQun3sZ4/VNVqkFrSGNucvcCC3dmuMoGz4+Z6mG/LO3FxvKrTbGS4CysXUNcazXxDi5gMXJUeaMMN1pPle77smzz5szPrl0/Nju6Oed8tTmcNn0et+2CXsoS4pITaPt9MAZ6bgjux40oZDMLvyrTcacJIoRmx2l2lHQd6Kdgd8006iT6A==
Received: from BYAPR11CA0083.namprd11.prod.outlook.com (2603:10b6:a03:f4::24)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 14:31:48 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::14) by BYAPR11CA0083.outlook.office365.com
 (2603:10b6:a03:f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 14:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 14:31:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 07:31:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 15 May 2024 07:31:27 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 15 May 2024 07:31:26 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Eric Dumazet
	<edumaset@google.com>
Subject: [PATCH] virtio_net: Fix missed rtnl_unlock
Date: Wed, 15 May 2024 09:31:20 -0500
Message-ID: <20240515143120.563700-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d710853-4b8c-48a5-41dc-08dc74ebc0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TE98vZvG7c1wQQag8MWy8YtlM8KUP5Hk//FRMHMw/3ahqiv/SOeJzfaKYWX+?=
 =?us-ascii?Q?RVpXdElC/b9Pf/EGs+obOb4NMKzyLolWcT7JpqDio5izoCWmtPrubMfWQ1rn?=
 =?us-ascii?Q?peoQQEMDFVYve1YWp1NNZsAQU1j4j2tJ12U9FOXFG7spSsNoGcsbeWLvFvsl?=
 =?us-ascii?Q?ui5wPpExweHTIxACW6o/KhxgXDeEvC/zl0ERVElx8hCgCvXpf+tPZa9p9iRj?=
 =?us-ascii?Q?Ua/FKRlz2WyJBh73pD1e+kSZRZPeIsvmRQywjvpg5L+YbbANlIGP4t5YlTfh?=
 =?us-ascii?Q?x7k+3oGZpel0oL/aY2Sb/agicA7WJmY5L+3KxxGANjr4Jv0yk9B5fG2bwP5t?=
 =?us-ascii?Q?71cUzYOc2kgztqB/5+aAjlwItQn8/4pPEDpQgzRtMp+TvUhNE1owO8ScUN+X?=
 =?us-ascii?Q?QVPBph2SkJOTRobyiaJiRVKbvy0soKELaHT38U2mnnp+jEoiziLefGGHi00G?=
 =?us-ascii?Q?GhxFrg3uBDy5Srrw5BWjyJ78cu/UmvyIbaGsjh4pKBups7YqDLwEimPtj8N/?=
 =?us-ascii?Q?csKW30oaGg3r7eB/3eKxbUOVWQXNEEUhPMdsdOY2ISBE7Uip4vdcujnZCcOr?=
 =?us-ascii?Q?WntkZFtIvwyhBhzQFcLB9C4tBaNt4fSY/LfepNSImP5hLZ2xLNZqqE4jFt1j?=
 =?us-ascii?Q?HyDq4BHkWO8KxUCf5A+09aozzGLtDaS8e8uxq05VEa2gZjg1/4UzYwC1pS+H?=
 =?us-ascii?Q?YZJdNom3e+iyfL0XsGQafjfoEixcP5qQwYFSWrb8BPVKeqFIswSSJAsv9YtS?=
 =?us-ascii?Q?hT0Skyx3DyMQ+XSecbkTaHM3w9ufxMiObYNLeaZYhHIkX7VmLv6QWh78JFV2?=
 =?us-ascii?Q?pJaWNg0Qt1AOFGSkD18irZ0S4N/nxylDW+Q4rEtJtW27q2sEFz3BIU6R5c/b?=
 =?us-ascii?Q?zjNRuJYHDCW88c9/cULAY6j4A1/ZCjEjHyHS3sV5E9XSKAwTpzNdksX515UC?=
 =?us-ascii?Q?0Otvj3o0VwfZ8XG6EkE8z2u5zUU99WwwVnf8L9Wv5I6cRLpT0D+idSSeBUnv?=
 =?us-ascii?Q?h0iNR/QKn+DPOPiJXNZy8tfuCNY2K57a2VeHSUz9Z0F0lfbhhbb5Z7mXSubi?=
 =?us-ascii?Q?ymxuhBPyJigfL8TRp5NKOR9Fu+9zEezL479ZscZeIE81sIJF+zTG6yHuGRAR?=
 =?us-ascii?Q?zoO3dvJw5X5pKNJRihVks8o/sW0T/dmu20rcg6llYb0r8sJcjqQupqq7JAQe?=
 =?us-ascii?Q?K9lDhThBk2OAADTvNXiVRWOr3GKYWWXKifSPd8+bKyCEiAJ9hh23UaWk24wn?=
 =?us-ascii?Q?gO8gaj8i0eDT+jYnPusUwueJEKOXr8dJ3hbiVAgTze7qU6ag/BXsib5T8B8V?=
 =?us-ascii?Q?BNFvqsdD1bYlU6GG2k/58VVcXfXRjfEquM9nRRuhzhwQRq91plouK/Q4ejpN?=
 =?us-ascii?Q?otCTfVuCAQooLCeVLAitSQl7hSU6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 14:31:47.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d710853-4b8c-48a5-41dc-08dc74ebc0a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

The rtnl_lock would stay locked if allocating promisc_allmulti failed.

Reported-by: Eric Dumazet <edumaset@google.com>
Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 19a9b50646c7..e2b7488f375e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	rtnl_lock();
-
 	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
+	rtnl_lock();
+
 	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
-- 
2.45.0


