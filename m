Return-Path: <netdev+bounces-106459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0A916701
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E508BB254BF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36362153BF0;
	Tue, 25 Jun 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mv0h6IE9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1501509A5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317340; cv=fail; b=sNX2OMd5Lvc35pDAqbM5BbEPLv54StrgiR241l/lPPMWGZ2uQu9enGLcFvbhdYD7qkOgIFrcC+Gr73y59D31iceVtp2tKPlef8MB4ziuTPhx3SDtV7TEtob1yrPnquZI2EfchLcNhgljKqKE/CXH6U4+KzYyB8TPy50JPxq+Z9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317340; c=relaxed/simple;
	bh=ITHFml1Qg7bjOnrrCohycqW+szqvdOWFbHGo1bR47tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJBD2oDRnBVnbrpgYMdEU+ytrJ3W/9VA68t9icFDQu4YOHbLkNCzpdc3oAmBIh+up543YD99z0bes738wRU5q0cF1eTyGPE/FX0gQYGQvojidgoyehhkhGWu65H3JbQocTIw3ib/A+PgxZsAHJLwksF888mRxWugH2Yq1O0c3GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mv0h6IE9; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l411CQxmyQv66s5H2zh40iP2ipiREafVUFFmAfR+cPbSlmLPo1koD/rc3xIIgSQ8dOD3pF+9dsRTMswVvumawqeqr4b6YEtbBaV1qv+KvSwKFXG4C+Z9mHiz3wgMI9Q/PvoCJv3P+cQbK6Cpb9mUD5JJ9Ksdm+veKcKWsRQRJoboID4ZnRdcxFiONY8A8K2Qm3rqf6WfCyUEqooslQH7k7PWSC1iXkNqCaxoq4sowEKFjDn6TU39yTlpO22epM1fnErvFOWiCxJwV8zI22LRHUiuM+rks/Tym3OXjuuK2Os0aJ7usLrRVy6ToZfWl/PXt1TbUN36wE/f5gw2oHYUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7gHFfYA3swwjN1lpwyXmEZ63rXgWzCVnd8do4GX3nQ=;
 b=jXLoJRO4YKYGXUjzXl9LZb4EztNbssDpRzF/9MG523mSaF7V7yMTB/h3wvZBIEWc+WGtoKaPS3GS1QiHFTbcIpHAjwiWlQd/uHpmpQ32dyvX7hdURg49jJQCPGtZUDtPmGjFC5qNqmD667AiKiW/u5zMeQ0bYyZq5r1fFgTFWVrhz3CbwP4g3KDKN5ZLzW6VNA4WnQYPfX1K6E0J09Beb2bf1ufr65BRGVslh+bc731zBcuNDkxDaCN4Vao3uaj5KQ8At1QCD9nuGGTuh+i6z3uUpPkl6DBNqWbMoykkMeacHy+dfJa9PhMgmwUp+bdBcSvT/8l+MDyEJ3LtNuVdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7gHFfYA3swwjN1lpwyXmEZ63rXgWzCVnd8do4GX3nQ=;
 b=Mv0h6IE96RazihEFK2lDliI5SgMdfDXZxOlGEjvzJFRoeL2sXlwW2QsNtAhauY/Z9Kwk4nE2avoGCppD3/Ivis1VgFHcOlnukJrsIxGF+sf5mO1Brp7JutQz658k1Gxuq+OLlHaIWbMFP0VnDyPZuQ6jQCnnEo/au5e9AzppY/qtxnJio3agp3Qb/s1JiYQPJCVxMCuo0EE7t9jELhIgG1nsCqXAOMaBhNJGJsFkFVEUI0LEfL+NfzScc0BzhMyo7Uj4R47J//EAPvzA6setnSvdaocwy+ESj/KUp+jMnUXfeuxoKPSSDz+q/80MIEfLh0DP3uFEtWcdF1Uf6kKTdQ==
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:08:54 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::98) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:08:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:08:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 05:08:34 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH RFC net-next 4/4] mlxsw: Set page pools list for netdevices
Date: Tue, 25 Jun 2024 15:08:07 +0300
Message-ID: <20240625120807.1165581-5-amcohen@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625120807.1165581-1-amcohen@nvidia.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbbd664-81f1-48c2-2102-08dc950f955d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7nti1ca+zXzvNXepCpvkrpZEvw54udURs7e+JHXdKey9FxlxcMqzr9mh61Ou?=
 =?us-ascii?Q?zyDqCPaVVNOq9bUR3PqBPO2Uae7WreqMEKxJz/2/qqqxXPEGFHmDB8Q5W5JY?=
 =?us-ascii?Q?9slzPBEcU7PZogRuvfIdujg/WvwBlXiRKLMw8JykItY/UHGeNnrhSqvoZtFv?=
 =?us-ascii?Q?w2ToGXU6oUOFC7ZNWbSMV2dgN3z8HYCQFnO+82LI+3jADhI+meNt5+mIP4qu?=
 =?us-ascii?Q?+FJc0EI7HWtg1zy/hpOpukOBNLa2tVa7TzTWZwqqxhohP4Fd/kMRkhpFEzqH?=
 =?us-ascii?Q?QnUzwtNlTOLhaudRGuLZxU68P2y3/hcRWJTDOz3CJq41ldSMUxJRot/4X3F8?=
 =?us-ascii?Q?497h8cXaKskqObuUfDHNViSyV8Ri/vzfRRRo9RUJE27iI1aDagajVqGnIhGR?=
 =?us-ascii?Q?VHXygWq7PrlrkxFplOwt9RXHAfewTTq6j5ZQ48OrMn0hrz6HcQyW/Q5tAANz?=
 =?us-ascii?Q?w43KzRGp3pe0nfRFU8kN0OvGp+Wmf8qmfHrblyc2NqymhgK9DjvQYQha4H08?=
 =?us-ascii?Q?jOWzFPzZOjQAREUcmh17oYEvkV2xa3xpwi2hZCaiNeCnxPdK55CLrzTJ+C3a?=
 =?us-ascii?Q?Rm8cRe4tX+orZdWf2/3PZTzmDvmytnmj7Jz+PylZBRMFmZDN51QoZKo2DZmf?=
 =?us-ascii?Q?Q2b4nE8kp20S4eatQFZKTRptcFCOVWu80d9GHcqio4TkXB9blnGUUswXhUk1?=
 =?us-ascii?Q?XuvX86zr9ifJ3nXBnHCb2ClCO98Cbe7dKlzKFBmyVF6OD8qrNnombK4Zu8nK?=
 =?us-ascii?Q?UJKSXxdpX6ihP9W05SHk/jpND9tnZDoxJcXMB0NdQm3nzomY8es/O7n3N/D4?=
 =?us-ascii?Q?K2v7uVcJSykx/NMgECJl9dVwG88Sm4FQugOSbm/VImcQZr6260mNhKoS5Av9?=
 =?us-ascii?Q?OGAZbTgas4aZ7D5mUnZopVORktqd/PtJvKUWL5sfnrZHSU33UAcRaR5O1Mru?=
 =?us-ascii?Q?KpPLzRwIyM2uGLf0qF8Kuft10sfR1a+t+EfpJBfIkARewQPvU9j+Dvcnp1Jx?=
 =?us-ascii?Q?vZNm/zll3pFd43C1XW4JS2t+Rv5zid2CLQvzEfIfEA/gwhtfuo4c2W0GGO0w?=
 =?us-ascii?Q?KzpxFJDH2jMmo8XeHe7eIadC3LZh4g2UicfiCMGodD4f9+icSuI+hGEajWmn?=
 =?us-ascii?Q?TTdfwM9tTK/KVQh6rHkj7RmOXdV2NEXxGWXUl/OtUs9L278dT3kCBO3NqQ3f?=
 =?us-ascii?Q?POuq/Ut94ctXhP8xTOA9kCaDggBwfkNu/pNbF6bwg3a+B/hOCqQBvtkCIo5W?=
 =?us-ascii?Q?W/jd1Xd99TPjtBAPAAVVKicCdLatOyvSS3oOInltU/znEK0xiZ/mLXUkBZHQ?=
 =?us-ascii?Q?UIcZ2W8KPs3ErnoUaeRRDfHlech4ssOPXK0cA045PDNcboY7bo8BZ4OI3fa1?=
 =?us-ascii?Q?5uyBN6x97O4gJzHRyXprKT2zKXUUqTcmdx4qt2gucMW+LFi9WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:08:54.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbbd664-81f1-48c2-2102-08dc950f955d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

Spectrum ASICs do not have queue per netdevice, so mlxsw driver does not
have NAPI per netdevice, instead, "dummy" netdevice is used. Lately, the
driver started using page pool for buffers allocations, each Rx queue (RDQ)
uses a dedicated page pool.

A previous patch uses "dummy" Rx netdevice as the netdevice of each
allocated page pool. This will result "napi_dev_rx->page_pools" holding all
the page pools which are used by the driver.

Ideally, we would like to allow user to dump page pools - to get all the
pools which are allocated from the driver for each netdevice, as each
netdevice uses all the pools. For that, add bus operation to get
'hlist_head' of the "dummy" netdevice. Set this list head for all
netdevices as part of port creation. With the previous patches which allow
filling netlink with netdevice which holds the page pool in its list, now
we can dump all page pools for each netdevice.

Without this set, "dump" commands do not print page pools stats:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--dump page-pool-stats-get --output-json | jq
[]

With this set, "dump" commands print all the page pools for all the
netdevices:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--dump page-pool-stats-get --output-json | jq
[
...
	{
    	"info": {
      	"id": 5,
      	"ifindex": 64
    	},
    	"alloc-fast": 1434916,
    	"alloc-slow": 49,
	....
	"recycle-ring": 1454621,
	}
...
]

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--dump page-pool-get --output-json | \
	jq -e ".[] | select(.ifindex == 64)" | grep "napi-id" | wc -l
56

Note that CONFIG_PAGE_POOL_STATS should be enabled to get statistics.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c     | 6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/core.h     | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/pci.c      | 8 ++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 2 ++
 4 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 4a79c0d7e7ad..15b367b37ba9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2337,6 +2337,12 @@ int mlxsw_core_skb_transmit(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(mlxsw_core_skb_transmit);
 
+struct hlist_head mlxsw_core_page_pools_head(struct mlxsw_core *mlxsw_core)
+{
+	return mlxsw_core->bus->page_pools_head(mlxsw_core->bus_priv);
+}
+EXPORT_SYMBOL(mlxsw_core_page_pools_head);
+
 void mlxsw_core_ptp_transmitted(struct mlxsw_core *mlxsw_core,
 				struct sk_buff *skb, u16 local_port)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 6d11225594dd..9925f541ed50 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -95,6 +95,7 @@ bool mlxsw_core_skb_transmit_busy(struct mlxsw_core *mlxsw_core,
 				  const struct mlxsw_tx_info *tx_info);
 int mlxsw_core_skb_transmit(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 			    const struct mlxsw_tx_info *tx_info);
+struct hlist_head mlxsw_core_page_pools_head(struct mlxsw_core *mlxsw_core);
 void mlxsw_core_ptp_transmitted(struct mlxsw_core *mlxsw_core,
 				struct sk_buff *skb, u16 local_port);
 
@@ -498,6 +499,7 @@ struct mlxsw_bus {
 	u32 (*read_utc_nsec)(void *bus_priv);
 	enum mlxsw_cmd_mbox_config_profile_lag_mode (*lag_mode)(void *bus_priv);
 	enum mlxsw_cmd_mbox_config_profile_flood_mode (*flood_mode)(void *priv);
+	struct hlist_head (*page_pools_head)(void *bus_priv);
 	u8 features;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7abb4b2fe541..16516ae6a818 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2179,6 +2179,13 @@ mlxsw_pci_flood_mode(void *bus_priv)
 	return mlxsw_pci->flood_mode;
 }
 
+static struct hlist_head mlxsw_pci_page_pools_head(void *bus_priv)
+{
+	struct mlxsw_pci *mlxsw_pci = bus_priv;
+
+	return mlxsw_pci->napi_dev_rx->page_pools;
+}
+
 static const struct mlxsw_bus mlxsw_pci_bus = {
 	.kind			= "pci",
 	.init			= mlxsw_pci_init,
@@ -2192,6 +2199,7 @@ static const struct mlxsw_bus mlxsw_pci_bus = {
 	.read_utc_nsec		= mlxsw_pci_read_utc_nsec,
 	.lag_mode		= mlxsw_pci_lag_mode,
 	.flood_mode		= mlxsw_pci_flood_mode,
+	.page_pools_head	= mlxsw_pci_page_pools_head,
 	.features		= MLXSW_BUS_F_TXRX | MLXSW_BUS_F_RESET,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f064789f3240..3c78690c248f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1826,6 +1826,7 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 		goto err_register_netdev;
 	}
 
+	dev->page_pools = mlxsw_core_page_pools_head(mlxsw_sp->core);
 	mlxsw_core_schedule_dw(&mlxsw_sp_port->periodic_hw_stats.update_dw, 0);
 	return 0;
 
@@ -1880,6 +1881,7 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u16 local_port)
 	u8 module = mlxsw_sp_port->mapping.module;
 
 	cancel_delayed_work_sync(&mlxsw_sp_port->periodic_hw_stats.update_dw);
+	INIT_HLIST_HEAD(&mlxsw_sp_port->dev->page_pools); /* Reset list head. */
 	cancel_delayed_work_sync(&mlxsw_sp_port->ptp.shaper_dw);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp_port_ptp_clear(mlxsw_sp_port);
-- 
2.45.1


