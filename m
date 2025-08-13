Return-Path: <netdev+bounces-213285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C6B24601
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D37AD66A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B4212556;
	Wed, 13 Aug 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLcmbjrl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC32FDC29
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078365; cv=fail; b=ocXzqCAvMRjVnPK2prKZGphFtgTlBWMUTrHkpZdA5rdUlNBU30pk91WFVTIue2XCCF3MiJLUFM/4/LuURI7DouMRTjaotbKgoEkIfDXjG0J5pbHrhH4efay4RifVqJ1ZxKaeXuEqIMaUNIOTQt0i9qQP+iVK7OapIDO96EUrUdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078365; c=relaxed/simple;
	bh=vR5+S1f3jA22/eS8QeE+v5pcZYOaX0eoFQ/OlC2u8DU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd/NRKVbmrYr/gK1G4oTkq5f/37fF7z3QB8VmUFWgtELdvNj+WF6r5RCzZTR6Qab+2DypaahFzgzWkGIVnnQTaqHmyvmpm3a0xyaPF2eZ4YYpvfpCWEt/ZgihKM7TwljuiuFOMG7CjrnycqqAQwhnZ46kDwd2ImzoBumWSoVAXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLcmbjrl; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFNgtrnjVqrTOXe3ZmGKgl9hR3OYjgEmo/ueeOwOQF2JtstDGcGnjoWuDAPB3u0TUBv/REYgUzyGopnEQEJ5FwxOn//5y+hmqTAWh3cIUYdlzU6cs07/ugf+b396MELigtOLLumtCHvmx9+apGv89Wzn6rMX0c1WNAhgsDooTN1i1BgXU3jskYOZW7llZ1g8MN4qn2O/lC4cDShuif3rx3Rs+DMG3VQtzICaAlcG+Buxm16z61fnUaT/oh9cc0T+J84e4ifxc/QxAIMW33MBDcgbo57KQWVdfmJP7Ml3olZ52B6Uns0afsI3Z2TKiLFN570rKBGWlsE1UhelOcY3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1wpyvibUljv1XsEvu6+cYn1UgdVExrMhtsJ3CS7a+Q=;
 b=PFvKBvaSX0Ju8MEqgBs8KGqVJeWw1te42T5JVaDWSY9AukMWIZHrlq8UIXCfG8OblMPzvWFV+Qrd8/4xUQRKrW1BDVtCsuhgWHYz3WPAh2DsBXQBoNSXHugJ9KHs7BdrZ7M/J0//NzVD8BHGPX/jb5XiMPcsOIX3OjePYWQW2FT2khxwrTRTjsVtMbOFbuhKttuWvyH9ezzyds/SBI9lHXYfWcGa7mBQmyqLgC7k13RBjnT2lf673vFCJQQCS79tsdRKSQZWvSYK4+tt+e42oB7AlPNnLceBrSQvi7JHjQHZBN7oLXvdB/d/wTyGRmdYbXe4+m9cA4UdDOIbi89yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1wpyvibUljv1XsEvu6+cYn1UgdVExrMhtsJ3CS7a+Q=;
 b=qLcmbjrlrjCT/adLdfuVWlb2AT4gqmaj+b88fznpM86618m9hIKCaP4a3XSRZ75aZmJ4fAqT8MiAiRRCq5wYWTLkqT0Hh1DwWqaUAvKGtRMKGvuSrvWU+vAPXNmDSyhb79XIN8afyrr26oCtot+yQfaTBs5JBh51xCySsfCGjJ16f1Gt7MXMHrsXzDi0i6cSB2riaEAq3vJVVIdVYdOHExFbwjBJzQcumnZKzOSMXcyuQaDihvZTyp7qesx5dqLOBxyWE2c1AcFKByMRKyaLZcgj0+J60ijjkE5yXcu3qPKiMixW/6uP2+jCB+8DJsBrduUmh3DeXB5rH92dFcwi3w==
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 09:45:58 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8e) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:45:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 02:45:37 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 02:45:36 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next v2 2/2] devlink/port: Check attributes early and constify
Date: Wed, 13 Aug 2025 12:44:17 +0300
Message-ID: <20250813094417.7269-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250813094417.7269-1-parav@nvidia.com>
References: <20250813094417.7269-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d815071-85cc-4168-bbdd-08ddda4e33f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LkCaA31zBk8QjOj0l+w6zv4TabqjtzIDxY1bEM5k+hVYz00pittjiUTqWQ89?=
 =?us-ascii?Q?P3g39h6Lb7NAbw7hzkSd3taOt2kjZHPp1xLYE0fTODhYPzHFzFHkOrc60Ied?=
 =?us-ascii?Q?rKVuWOlDGP6WtrveBkw2xB6XvC4sEwJYjJRdTV3jwbcu+spVsSXvJ66dIZrw?=
 =?us-ascii?Q?VpvE5BCUqIM+utxzYrPnR0RJA2zINcRIA4/zFe0yn/gtLvJ+yboV5JM4fZdq?=
 =?us-ascii?Q?owM1BEEOh327I3VT/i/KTRVOI0qXgAQrS1nnpd/2rwAD7TfTIgBxm+CtfdEi?=
 =?us-ascii?Q?iexOhImGzIDk15rSLnFVURFHe7veCCWX6HkyO2hYak3HFqljHuEzoqP2pyiz?=
 =?us-ascii?Q?cUnK2ytlpkZi1nc+mm9U2B0MuCzQYK3Z2xuT2o0ZHEmxj9oMhOG8ge2t6Ncg?=
 =?us-ascii?Q?Gb9fWGvnw8xKdPi62R/4IAq0QSqVB8KPd50FMVrZs3KsZRJDEcsGo3X4rKxo?=
 =?us-ascii?Q?sKL4udH5LhJpEMYDZtTFfA1r8j1cqhAG09iVUqSb1n85iZcmZgLz82bhtwFz?=
 =?us-ascii?Q?Ngvg8Gf3RKcFjnzMNw9xEqCF7cVDEUS71+0nM5bgGx4VlmbsN5J/jlLMSJe8?=
 =?us-ascii?Q?pH0e14b4IQrZSsKTrSHPRYoOdmpSErpVNpYKS77OI6y6LOed2kRPIc70gqUh?=
 =?us-ascii?Q?1gc8rFuQTtwA02/el/UlAfjqZDFGmLhGMON0zYSTTkQWmEu3NnRmMDiItIeG?=
 =?us-ascii?Q?2fBdlrN7VByDmHx3IdkEM5K/KRUINrWypzhkiw1UKlKa3Upn7FsrreBIpr8k?=
 =?us-ascii?Q?1wFu/8UuJm31B0jRNfybgLeu19d9mMlGbIJzcJ4vyFw1epuvcg8qqfLPAZfr?=
 =?us-ascii?Q?Q38dAULa5x2P93sV4Yibvds+qv36ZnWd9Kq0UOHbI8zvW06osiHeoQyRlhVH?=
 =?us-ascii?Q?L5AaZbLYj6hQv3PO1DYEBrkla2scp8OPjGUFYX5gdhY3py36n1SoxauEOAE1?=
 =?us-ascii?Q?FpApG8sR/ddcWOvTF+TxQPN0E8UxK0OdplZLeLikrCPap37wbe258oX6/DTr?=
 =?us-ascii?Q?m35/RshCLxawwDpz5G7J00KZshPUDpM8WHTJf1OaVBBkQy+jB9qxpqNBxFMu?=
 =?us-ascii?Q?LJds0Ywiy1tWIhVkjnKfisrNQvGEXAlJQGmKlHukMbavwoYx8GSaPI/diFSW?=
 =?us-ascii?Q?M/LtGJIjHyh1MEwnV6UMxx6NvxIyAvb8cPnldwWzlNLVDDPRgS7tVQ5z819n?=
 =?us-ascii?Q?1IZxykbweSEduO8J0BAZYaUIfSMKSoUYCnT2fmeNpL/ajQymvcg5eeLgFqQo?=
 =?us-ascii?Q?LoLD2hdUcoDYnO29oNNY7BoJ6Xv6EfpUaR9snEeNL3rQOUR68AZJ/q7EaUHM?=
 =?us-ascii?Q?Mw162QbpWfUpvWdLVENpt38xH25XzeAXynjh6URVcnjYEAHEif0ghivW4p2h?=
 =?us-ascii?Q?5YtAYnoKhZ2mY2hZ9CsFWmIVEVrcFxQH5AxbBvIXD8MPaOYXOAuLmkKk2xc5?=
 =?us-ascii?Q?SwPg6csyeLxr0ziU+Bs0rdeaQxn9qNvOwE5SSOO5EzwGpsmWX9K+GqWv7j+r?=
 =?us-ascii?Q?0doOw6vywvjZ4raOqXWZIlU+guXGUbKMzSMask1PQsFjMx0uSxaR87/iZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:45:56.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d815071-85cc-4168-bbdd-08ddda4e33f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

Constify the devlink port attributes to indicate they are read only
and does not depend on anything else. Therefore, validate it early
before setting in the devlink port.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- Addressed comments from Jakub and Vadim
- changed patch order
- replaced dl_port_attrs to attrs that matches implementation
v1: https://lore.kernel.org/netdev/20250812035106.134529-1-parav@nvidia.com/T/#t
---
 include/net/devlink.h | 2 +-
 net/devlink/port.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..052234f0d8ce 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1739,7 +1739,7 @@ void devlink_port_type_ib_set(struct devlink_port *devlink_port,
 			      struct ib_device *ibdev);
 void devlink_port_type_clear(struct devlink_port *devlink_port);
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
-			    struct devlink_port_attrs *devlink_port_attrs);
+			    const struct devlink_port_attrs *attrs);
 void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 controller,
 				   u16 pf, bool external);
 void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 controller,
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1bb5df75aa20..93f2969b9cf3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1356,13 +1356,13 @@ static void __devlink_port_attrs_set(struct devlink_port *devlink_port,
  *	@attrs: devlink port attrs
  */
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
-			    struct devlink_port_attrs *attrs)
+			    const struct devlink_port_attrs *attrs)
 {
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
+	WARN_ON(attrs->splittable && attrs->split);
 
 	devlink_port->attrs = *attrs;
 	__devlink_port_attrs_set(devlink_port, attrs->flavour);
-	WARN_ON(attrs->splittable && attrs->split);
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
 
-- 
2.26.2


