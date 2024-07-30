Return-Path: <netdev+bounces-114174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FD9413CC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DDE1F2493E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8311A08BE;
	Tue, 30 Jul 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvwKo1rZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8A19D8A6
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347989; cv=fail; b=kbmmSnsj+ZQjbq2cRunp6Ha2365ti7zYAKUSA/rM2h2i3fkq+6HZgrfWGt5mjiuFrs5LS0+w3trDc9ACUHOj9jBu++tUU9EVFd4TACe0SkfakB9xiSGhs0SE6ETk6bol0E+C21fbNQdJhPHyHoSq3OnUtUViwR3p6NdnVCyv+p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347989; c=relaxed/simple;
	bh=uFHRf4c+7GEdxtmspE6SVCPPlOcY1mQrM+tzzy4rXR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDnRSrF3H8UVP7kISrFWu5isOtyye+j9p1nThLwsTXzetYfoNpvJTmQT684uyhGCLwXjo2KV7lOs+EnM/wHQoDpdkLQReURfL+RSV3xQB4pRChbqXPguohxaxJmiVLco+MtMABqQqBsIXxgGDk4jOl/2mR9S+ev7YixT4mxMy2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvwKo1rZ; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCn1NkVr1xEw8Y9qk7vtbSYknG1izXGbliv7mYSRx3KeYhNM7EgkQzLjIpGkEqUa+l/5CI2Ce5sEZcQJathj1L0iuGXVKR9nbquFtbmU9KoGU85G6S1LKI/NENmdv102bolX13sGK3+pydrUPpH0cb/L7rrxSiyQQAfz8o4zCZS3iSLCP9Fs+7sIUxM+gdrjn+aWHA8uSsBwGfi16pqUCH5qzZKCBWolvkohWShkwxNnRpERvllpe/su0rpkKcowIC2PqyQUGMumu3eVctMYoAhhRuGVd+DowzlCq0T39ErmPUssKsXGF4TroYAQJi6vqckZxd3MxSUQik3phB1ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc6H7wAaw7Iaa/I/xRoovHQxGxXBXkuQFlUYQJvAgv4=;
 b=xeMy1KWH7JeYtBbKBOnrQR57vG5ekolILZabAIvZkc02CXaN19mhdxeW5wmLhjmaB3hwNpLoEohUJrp1F/NZ77dw6MxVl7LfHmvS8loHyvjCdngpSVkBVEAt5ySQSssggvKzl/wxMJbOekU4Kgc7aqrAlz6srjWNQWVP6q48mhrvmQliI1GLNADu2uR5gqYXhTRu0TqSSTidDDfu5D9FjVzuHxurCzjpFDAQfzU0PZpj76DRUpyAmL2r+Ul0NODIYPF0yUaMN7UylK/9dBo1ELHFGjnrJKmdfPaazdSoE2wsodGWhTnSPjelMR4nwvCev4XZ/JM0+Paqln2ZUjRd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc6H7wAaw7Iaa/I/xRoovHQxGxXBXkuQFlUYQJvAgv4=;
 b=IvwKo1rZ7iveHLG6FyFj2K7GBOl23+9lJOPHYsyQ3A56vCrzSXj/SlfHwDZGDUzmtywYEN29smAKkUTPSC3KU35MKjqE+urco1y7iHBiRqJbcJ05rRJDLLWMx+k/EHVkvWiJzD2omeRS707ZZc8F3Rl7mwVfRT3aZYfmq4EtvAmzkP+L+fg6KnsohrpnXswuYBJUdgDA1gncjNNrHl0Qyx6DL2I2eu+ADOidtZdt5ZlWHwdWkZhfPnhXks7AMtgWhWH4CZG4Q0wGUi+60qx9A/yMHL3hI6QVvNgssFBFlT0JwLop1x5aAWWavw1/wiGhO1f13yZ1dj9w1/bdUMkhyA==
Received: from BY5PR16CA0033.namprd16.prod.outlook.com (2603:10b6:a03:1a0::46)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:59:43 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::4f) by BY5PR16CA0033.outlook.office365.com
 (2603:10b6:a03:1a0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:31 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/10] mlxsw: core_thermal: Fold two loops into one
Date: Tue, 30 Jul 2024 15:58:15 +0200
Message-ID: <81756744ed532aaa9249a83fc08757accfe8b07c.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: c463b1e1-f0c3-4ae8-6f2b-08dcb09fdd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2VdUIJwxNsbe33BwJDPiGA70icOIi1x5jOtsWUgXeRGcXMLaqtLF2b9wjhwL?=
 =?us-ascii?Q?QGk4ZTTBGurV9C5KKEetW4AxrjTSjbsnJwj/jJiTDC5wcP42eTImXrNvkkIF?=
 =?us-ascii?Q?nKI9SHUEAlvwKT5C8FIAHu5A1uMpqZDxuesNjCDFs7lS/sY60qyXmlujUBVd?=
 =?us-ascii?Q?LuUslyHCWqEgHLArcHOHN+nlrKTLQKi+nNa+5Qx/RCjPToh6Qriu3OUVLfpB?=
 =?us-ascii?Q?5ibirWDyIvkom4pkMiNDzN8Ly5JZ2BhAKatwwtptEyyoiSziyGIenF0hbBbJ?=
 =?us-ascii?Q?lK1G7GhsOSXRjeYsBjx469O1j0KmzOLX5QX/CXobDQLOC873nXn7sd2pzpsY?=
 =?us-ascii?Q?vYR0Ha8EQRJiadqeiBDOenMo+genoGzqJ3dg7vmFngApkjfXKhrBR6UvD/af?=
 =?us-ascii?Q?/+mU8u6LeL2/71IXGMmwwX5S52/lnj1NYJNwTNQbxDd8rlhuPL7pSBpCGIMq?=
 =?us-ascii?Q?1BbTiivm7inFxgOe+vGhoef8fxwiBF8AL+ZnnspU/esSDasGEZ33/wMV17cI?=
 =?us-ascii?Q?r7LD0lbIr61AkkU3Uzk8gGYCsBQnaZJjfkqMWooRYaeceiifSe/8A789WRiV?=
 =?us-ascii?Q?3AURtX5RLxCqyTdNJ/qIoFYtmRGEfVBGzdONa2OKU26P0S0ytu232vRvq6zU?=
 =?us-ascii?Q?BVClneCb+vUEY4h15bEOmnPs8MmiiIk3/EXnZshjlRsCPO99Chy27MFJXFrC?=
 =?us-ascii?Q?P6oPbFwiIhppIQ78MD94m98GE6eLBzCNLrF8aIskntgrmzAI6GiakXhlouVn?=
 =?us-ascii?Q?nY9WEy/OmE+U32Cld4T/UGlY7HXaOXy/VPlgIJ+burjhxFpO/XjJO059YV78?=
 =?us-ascii?Q?n5Idxrbf4UJ6LHPIZ3dH0HfjZJnyOAMsQhmIMFMS/evt0Rb5Cw/KyZr/015K?=
 =?us-ascii?Q?bipu5/Yycpjd8V6h1Wimlc3fxETz9eqB6R8Q+ApeE7ISYgDpOtW3p1LttxyA?=
 =?us-ascii?Q?qR3gDkdpzosxxHQnK8vuWKsNk3eaXZZ7D8D++Nfe3l6+RLj1e6mlb/HsaCIu?=
 =?us-ascii?Q?IQVmawKatC2Ad70y+QdZ+YZWV1o5s1Z+k2nv6OJwqzk3d38ZGdcYjDZCbnaF?=
 =?us-ascii?Q?nkd6jVV7WeLT3s8L/0BDrrJP68Xfvo+8ABTogZLaBReOUy4pOlMJQN/8NJW8?=
 =?us-ascii?Q?Dvs/fQwCmi5qoNUQcysYVWKVFoELv7U0eGk7N7F6BqgjVzl+xURdAsGHrDof?=
 =?us-ascii?Q?X6ap/yj3pJiWDUZRhZATn1+zzFcGR5RM235LLqkIB3G3j9v8hd2lj2dp7KW1?=
 =?us-ascii?Q?Mb28JsBZQtkvP9HQCidVDRdh6PStKH2Apb+uiNBk3+LgGARbQy1QwMehoaLl?=
 =?us-ascii?Q?LVZYjBpnCqjNxccAfqZwfn6lj4SWTBdWGe8yt+Gg07l9olWoUDxg1+7j1zXJ?=
 =?us-ascii?Q?mKCL9lz9qirav6TSVf4ArdqGXzs8m8PvIG/+EBs0TyUlaNXQSOmHRiwUgKUU?=
 =?us-ascii?Q?bxNScn5x8nmdd//B4ka+VmrQXtqYp3/w?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:43.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c463b1e1-f0c3-4ae8-6f2b-08dcb09fdd29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

From: Ido Schimmel <idosch@nvidia.com>

There is no need to traverse the same array twice. Do it once by folding
both loops into one.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index afd8fe85a94d..b2a4eea859d1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -500,10 +500,8 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 	if (!area->tz_module_arr)
 		return -ENOMEM;
 
-	for (i = 0; i < area->tz_module_num; i++)
-		mlxsw_thermal_module_init(dev, core, thermal, area, i);
-
 	for (i = 0; i < area->tz_module_num; i++) {
+		mlxsw_thermal_module_init(dev, core, thermal, area, i);
 		module_tz = &area->tz_module_arr[i];
 		err = mlxsw_thermal_module_tz_init(module_tz);
 		if (err)
-- 
2.45.0


