Return-Path: <netdev+bounces-220034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86705B443FB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD307BDD08
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA143093C7;
	Thu,  4 Sep 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uO2Bww9Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7A31159A
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005759; cv=fail; b=hPNXIst77SVmfAC3qQHGUb2lRga42gLt6yJ52oUkzJJf1XzZ2xO8icFZGXMOnKFyDA8jg3h6BlCIkfDmqCp3AWV+mm8H4cDyEhS/B7G34Zxb59xK8SvkytOUu6jax/OdkJP+qz8MsG/Evjgg3SPOxx3FyVb7VfURXTH+0sfihWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005759; c=relaxed/simple;
	bh=smZMWFXkm9EbCnxd+knCVrOQ5uuE+kiC1Dj3lWLPrhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW2oI9j/L1O4aYyCoh2qqdthqBHTtv9k7Qi2ZY7NuXDHmHqfzjpDvm+KlY4cNVxKYUmS9GOvuAosaY7t+3CriyqnlZRtd/Lqo/OzVUN1I9MNg7GrLLZYctBOjkyqoMGeV0udkymnnF8E6biGQd+bXiAy0mWRDrhUXwzaTl4z0K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uO2Bww9Q; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzP1AbdfI3N5xd5uBnYS/RS9u90u7d8U+rz9zTecM7LOeBlWP39it8W+zLnIxWyw4pblrXBOZKRpZ6yxI958cFq7Y2CcNTmatctbdU9jGILR+py+96V7tXGAliE71E98A9IzFQ4S/yXtM8RM7Hh2IQTsKXreXsjopI1vgUTcfuFzBlEy5aEfjPS/0X2VOPzRNdGsRF9BTZvtazjlBPIWTLazrjflQUtaPWU5jVcE0oHKhbkR4iGviGuXp6crSvGaTAcMn2VqVVJfGo7pvFBNJJeHhOdgfmLmGf9wPgScrEhZ1fx820Taef7RAjxudBjm215xldlbCyRKINFbVjmpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBpzWITxhJ6Ho06CZMoVbOh2TDLCSpdOfQ/aN7linjE=;
 b=RV8L65BmfqVuXhF3Qs/Dmna9WU1QAzMADH9k0RyzXwOtaIqWpSpgRJDUoDCtJvGBZwgVMZMSotYFJ7KjeWV6FoZZAtiSnevS7gfc7cEHBYLcvsNQ9K0hxaht3eiOnxfUeCWIlZ6mE9xeABomO+lqS3ubRus+FAIRiNuH/BfgLcW43jduEUt5xk1I18q/dcLxfl95cqZNjnAXbOLlfygd62giw3xx6lgbR4WQ3w+10p0xYg3snt3XdXYzyJDnrSwwr67Sx7sXth6I5ohFwwKJuHQCGfLzsuZwnsNSJrerVvF6p2MlGNj4wNEp4Xoqsg87SIhjw/lFusMBGZJ740boEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBpzWITxhJ6Ho06CZMoVbOh2TDLCSpdOfQ/aN7linjE=;
 b=uO2Bww9QcSrWetqllPDiFdobdCACT1ubLabVDSVxsdfJ1TTt3mug1vzVzJ8hX/YPmVFMBIu3dhx/WeuFOmyEW/YRduMNFc3ZqObbluC2tF+t68SfaCwICs3TZgQPxLj+Hf6ELBeHXatsCHZUmuxa3CLfG2TFDKVakOWYAbNvFPqs1kbre8PPt4ULElzACeWXlfDIJBDrRPfe5M2kmPUZ7hYdXQixz66gKaDhhitOpUitmGNfF9/O2uotZe6sgBG51/zkvLeLFFL/sgMdS59p+UqlO3zdTQIWxK79eo5qWej48kk2frasmReRuO/vO9kpq0YVUIZZKdTEn8T/3AJLfw==
Received: from CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::18)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:09:11 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::75) by CH0P221CA0030.outlook.office365.com
 (2603:10b6:610:11d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 17:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:08:51 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:08:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/10] net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
Date: Thu, 4 Sep 2025 19:07:18 +0200
Message-ID: <ab85e33ef41ed19a3deaef0ff7da26830da30642.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793a1dd-d7fd-45d3-55d5-08ddebd5c439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U9avBdIVqDmsQOrzpLwt6QH/v5yLmDN1xW03a/wKpaZ6+5egjRzjMZVs0Qfh?=
 =?us-ascii?Q?WBlGpiPTG2YT/v81fASMFDSv3WB0B2AJNaql3uOQejGWMBKKqBKox2c2jlbA?=
 =?us-ascii?Q?JjFcfCEoeMG5ujyXrdgTLnC2VpkfjaleQK/j8DviJoFtQZXnKWg7NoXlVdKS?=
 =?us-ascii?Q?mEukOUq0x7W9Qtde+CEuWrbOphu9DgXOeInqaf0Jm36mf1R9lyKIrqXAMGL5?=
 =?us-ascii?Q?9W/wIFOa/RKwv/xNiHqghV47u8V0fhtCGx/TaTQM8OcRNusjMVARgzxl8TfY?=
 =?us-ascii?Q?l1Ro5HUJcjhcW0bFSUHDXlSRHFr8/W59VhAZRg4YY0gK7RG61swYeiwuT9WO?=
 =?us-ascii?Q?BjpOP+/o1tkfArqQ5XJM+FE5IcrHjBQSFqhZp69g5Ross0gg/Nq6FB7wz5PC?=
 =?us-ascii?Q?Vzs0XRMmHabombt7y1byKMmCJUUGNclr+Ltb8w18sHLr/reCy3qpIrKHaoKx?=
 =?us-ascii?Q?2kjVcHudZWX/Yv6jGiS4+RG6lYWYpxjbZ2RfBCt45WAgqmtcxyzpQBULn0wB?=
 =?us-ascii?Q?m9Vt8BCUGKJJEvQpaNW5KWz6ZuoP5MKxqwoQ1xvI77HX2E8AgU7XAZokTrey?=
 =?us-ascii?Q?ICwNBdRcf06zFHNpF/q95w+LgiHxZ+a+ZHDHIbvkixClHUrWNBlOpcaJxQYB?=
 =?us-ascii?Q?iK+4wWeEJFytW8BB/wLJyuhzuZruYcxXnW2CQS+sB43qLcUD27nwKw22HWb4?=
 =?us-ascii?Q?uatHtbDpYOpsh2d/I3xV5sNz+ZeFMpfmM5sPjzzLQKTVEnYLGDtpSwd7AhVs?=
 =?us-ascii?Q?9iD9pBbUVU64/2G1IF42j/LbNtIrl3DJoHZ6doHVy8WsD5uekKFnIsGqlsz7?=
 =?us-ascii?Q?WAu9TiyYSBs+rDVULXEpUdNHaF9SXj3CBn0fWBJtWKDSKL6N8IS/IPNFJGA1?=
 =?us-ascii?Q?05aQU4VJJC0EpZRyt1m7dpXxSdMEuOga97NjNx97wlwIKuM5/WMnmoANUt29?=
 =?us-ascii?Q?nZ3c38iA9msGtnh+naMtyLhlouXChupBCzaezLAnyn5fYKLqfdjnZS/S3fvd?=
 =?us-ascii?Q?iQ4tpwBztupH/qOGgcRcRj9nHEmJIXy/CXXCfidt0nO3cuHZ+Md8qpwnZrI4?=
 =?us-ascii?Q?XHvEvVzBO8zKn6acZEwm/0bBRuJyIkHogMEa84gp86lB5NhBjoRyTi5H/1Et?=
 =?us-ascii?Q?/jM31Ixqn6Fo/DTt0plOntlH9gPMOO2CkfrvmSU7IRmTbRRV7KcvSZGvv/35?=
 =?us-ascii?Q?BaUcW0mU5iVSMJXU0KJG5iTPuBNqC/k0axX9/z7U/bjQ14TYKrzWeMF+IdhD?=
 =?us-ascii?Q?sVY94NClK25f+XH3uJQ4P1GGjpxHst8C4NwAC1uz2WCWzwTCbqk2+PkKmOqT?=
 =?us-ascii?Q?gxAj1LZ0/js3Jx8LkqLkOuIVy66YZY6E4suOIXKKi3OLE0NpFvVkyHYpS3Br?=
 =?us-ascii?Q?lP9hkFTtpNpRjAhIGIaFnFJiD9/Z8UrHm2kUhyXFAr2+mGeOpkqGzjwShQZP?=
 =?us-ascii?Q?9ZjrLQbT2Kp5wPdwhe1r6EoH5+FmQd2/yr0Kte2SnYvsWKk1phMxn1R7YGSQ?=
 =?us-ascii?Q?2czfVv6kSkudLk64+wApDkPCfvqOczNMJkpo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:10.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793a1dd-d7fd-45d3-55d5-08ddebd5c439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

The following patches will gradually introduce the ability of the bridge
to look up local FDB entries on VLAN 0 instead of using the VLAN indicated
by a packet.

In this patch, just introduce the option itself, with which the feature
will be linked.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8de0904b9627..87da287f19fe 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -487,6 +487,7 @@ enum net_bridge_opts {
 	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
 	BROPT_MST_ENABLED,
 	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
+	BROPT_FDB_LOCAL_VLAN_0,
 };
 
 struct net_bridge {
-- 
2.49.0


