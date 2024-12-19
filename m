Return-Path: <netdev+bounces-153400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A09F7D8E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE81895A1B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE42248B4;
	Thu, 19 Dec 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9uPgNaz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8141C64
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620552; cv=fail; b=d7rboNuVIved289JSiyYCaS2Rz+E9QWSmvaTAeFS+Kichvsy+JF+r8CzJzGjk3ZYYlkpLFfaVJYUjVdP4jU3Jv+hDeg3ofRF01i0zI4SaLyK20yBCjE2L16IJQlOKEry0z6hSaCvgU3rSfRKJ9pC825jcb1HswEsTYiqK0Cqx3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620552; c=relaxed/simple;
	bh=OZMJGcPzMg+dMMevD2lhRRtry0QAA5wGrobIuW8C2L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wi4SeyAzfTi/NGehP3p5cNy0Z03VEl8rI9Vr/4GuIDuHUtTHU638c+FM1YF7j3ZHiFnyGyiB1AfrNL7wvLGfpv7pMLL1DdK8ZZ4ONNzfp6Oe6GXC7OIZ7r/7nBJ5aScEs9QT9IFRaTDXB0Zp1jWc7DLv29YJXEzFmbLbl1pZ2iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9uPgNaz; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km1fz3icZWjk52YtTwSKjvESWOhcjk5vBBVNVcvCmjURr+/vm0GluBCcrvLf4PRNKSQra91VQsQ4OLk4L3upSrio0GEQcDR8akD1gsiPzMMeIYZyxkGnifTmlfDZoaqQESUiw5vdOuT9ZrmlpFZsvIU6R7+toKi+wuaC5s0XATMoaxxNDm3Qx2QYO+/n9ACYxYIx3nXZV3OC8bUNjPb+YSNjiR/xcp/uUFXrQdK5A83PVNemj0wZ0qzAwp5s7yPOwo2mdM7WhIjEsRk4nwheWz7iJ6Yi0LzTrBOpSKWItVr+SIvPLasfqggeb6v6igDPdxuxwhzp2Voyw+adBzp8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/XeT+lUe+kW6JzJ2nybNNcEEojNUJcxoxiwvvgxwhA=;
 b=wa+uxC3SM3p3dlh9ubB7XuQwSahg5kArgLvGHxXzQcRkIm6umWyIocEsKGtZk984emS6kHzQzcXzt7QSXmNC7kMJqfK6PBnatD2nGSmzM0X9wzq4ZHEGxHlKHclkdOxSOBSO25K9h2PKA6SnA57FzxKN7JJorzzptoueXPAjg6RDia8dCbhyjLNPZ1F5ECcSwiFvgNR8FRGSMrfppdeT3lbUV96cG2RmppB2XSczQKpdvpHSryfc/GRTs32FBSRiLvziNfGk905XvQZdjSeTbrmZB8vj2bMCLqFRY5bCZ2RIL+KSOg/iWwRW7yGda8SzdAge6wBHZ1l9CdeqrW+O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/XeT+lUe+kW6JzJ2nybNNcEEojNUJcxoxiwvvgxwhA=;
 b=a9uPgNazXTV/ZGKKTHdTx04df008ErZ49X43aXgggo0a4kAdF1VQWY19InL5KeQkleT99pMZi/CISkCmc9XI0tEk5faih0Lu7oB1SQ4NXpI812vvZtC+4TwybxTZQ6gk17k6JL/MFpMchlmPxaQm1NtUnopyxMXSXChT/dKarDHIIxHR4Er7FVu7+nU6EVMUXpI3QysGQDQ/kpEPxAXEDkAZwqBJLyReHsKhMjXPTToMo2Up7CLOBJGW5Y78S9M3Up/+ua4fO4H77TitGnQ60EGUeY65XpcuDNVRD7dx/HGIkLAhgXgI8b8UhyYJHGbk1v/zdaQO1FX9p6c3TykYwg==
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 15:02:26 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::83) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 15:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 15:02:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 07:02:12 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Dec 2024 07:02:10 -0800
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] devlink: Improve the port attributes description
Date: Thu, 19 Dec 2024 17:01:58 +0200
Message-ID: <20241219150158.906064-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 620c8c39-b02b-484b-8de0-08dd203e267b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQN8f1CSVxfFhXARakLEJs//7ctIqh4lQfLq+3ywMPGDfXnlFeN6JeqM96Pu?=
 =?us-ascii?Q?gItlEQ4hV47f0occMr70rysmD+0IjLyTQSVKchDrAz+vus1DAxdkKwMAuiAm?=
 =?us-ascii?Q?15LdOQKJAuyYenqCwF2omofmBjk0qk6N8IT9zc62ttpMUfj1n+iwIfST8XZA?=
 =?us-ascii?Q?d3nPeuHzSoq/EsoTTKpaMcGYs2vI01vi9zX5Vw+scHvttYBSs8+GDorTsBWf?=
 =?us-ascii?Q?34tu/azUXX9GRPL6GRoOXZuaYSeEuNIQw3PlYYeiNz5bIf3qVRewgPLOq8Ic?=
 =?us-ascii?Q?gqrRHi47MYrDoIMd8aPEaZRLKPJn29AGKmQp8xgRf6UOq6BEpOy+RGp5kETb?=
 =?us-ascii?Q?DoF+hCJGVZsT4TlBAq/l9Z4R4vEmerNbNXkLFR6WHAXM33CkqyUvTravIXB9?=
 =?us-ascii?Q?LNucTPeeAxrTQmUKLQ5Bmh7Hb7nu4bXz4f4qr4dy38FMPrbDSA4a6qfS6U1B?=
 =?us-ascii?Q?AyQLCiGmv+WJLPzQKtv8RMvRFEGR/CgWTmR4r2IiJauGJgLjiLptBPGYEIDE?=
 =?us-ascii?Q?1lpjna0lnht89zMIyfUwZeoE+SsB1LISYt7/FU+LrcD0FNxRJvOa4EZL6uiK?=
 =?us-ascii?Q?eE3JbEEs3l+nocixuk3d2d3RuhEWcaH6Q7+uwIEgYSPi5A1/5khjB9YJosIG?=
 =?us-ascii?Q?CMi6UWWhL/RksU1me/Ux5JzxYy/Pq/YHdHJM5C9V5DVS5aitILtqCdEoL59v?=
 =?us-ascii?Q?OBR9EDh6DcnsIvqOcz2LBbybLGhwlhAyGuNVkD78hJF0uZwR395Ig2XRnZUN?=
 =?us-ascii?Q?v8EgOJSSwncQFcPN4zbbFpUVwF4ctu7ok3/GpHLySkZ1zZQ4EEY2jiOJ3ugT?=
 =?us-ascii?Q?aIHInf9v3HwUQFLuQHsuw1fSUOHJdhxXXh2762cCQQb1yQOxKZTRMpxCzPrA?=
 =?us-ascii?Q?OqokarzGKrA/kPRIZLx4XEJ0XUngKk29MsVHGrFNNatDehaTvxaoQm+hVDXr?=
 =?us-ascii?Q?RgvuPE9CP/HNlJ88cEehKKaTTBttnOVms5sZyysya44Y0Lgh1XTBLf7ERpZv?=
 =?us-ascii?Q?KFAQPMyVVoRg6lnJ0mmOhhRi5CxTdccq6RpPyL31Wa24pRfSlkzBmUMNRcfi?=
 =?us-ascii?Q?EM1lyohrKWKCiJAYpWQjCUWSUVGtvRtrB8RDCVUlBcQ9dR8EAjO0UhbYOgtY?=
 =?us-ascii?Q?XHyy7vrby9+zsd3o5ddKFJ+s0oRrbylBB8CDQOYlz1lyat+8kZqvGz3rwiO8?=
 =?us-ascii?Q?nLzWMA2kLsRWUTMO0hKhv7M+NzMMJ11OPR+q+2+t9NIrgDIeoYDY7IjltMXp?=
 =?us-ascii?Q?r6hkZ/ZluRABpk5y+g5tR4XUl8CJvrdl2ZTGNuZSIIv0qP3YdugqQMgDsO+N?=
 =?us-ascii?Q?Lfs2OShtMcBWR49MRvUglMPEQIG17bIrdYvTN7iZe1WLBliVgWVu8kLHiR1u?=
 =?us-ascii?Q?a5FedKmJ1yQkdjaPka7HHZ2FCaVTlqTDJkG6vFL5T2kwTQxnRu3IPwrtTLRq?=
 =?us-ascii?Q?CvFoCs4E33Ahw0svJYzCOLIwIwF295R+jz1w2QcnYt7/3f2LecS27tbYBPrL?=
 =?us-ascii?Q?3LwRWYJIKm0xcbg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:02:26.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c8c39-b02b-484b-8de0-08dd203e267b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

Improve the description of devlink port attributes PF, VF and SF
numbers.

Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 include/net/devlink.h | 11 ++++++-----
 net/devlink/port.c    | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..a1fd37dcdc73 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -35,7 +35,7 @@ struct devlink_port_phys_attrs {
 /**
  * struct devlink_port_pci_pf_attrs - devlink port's PCI PF attributes
  * @controller: Associated controller number
- * @pf: Associated PCI PF number for this port.
+ * @pf: associated PCI function number for the devlink port instance
  * @external: when set, indicates if a port is for an external controller
  */
 struct devlink_port_pci_pf_attrs {
@@ -47,8 +47,9 @@ struct devlink_port_pci_pf_attrs {
 /**
  * struct devlink_port_pci_vf_attrs - devlink port's PCI VF attributes
  * @controller: Associated controller number
- * @pf: Associated PCI PF number for this port.
- * @vf: Associated PCI VF for of the PCI PF for this port.
+ * @pf: associated PCI function number for the devlink port instance
+ * @vf: associated PCI VF number of a PF for the devlink port instance;
+ *	VF number starts from 0 for the first PCI virtual function
  * @external: when set, indicates if a port is for an external controller
  */
 struct devlink_port_pci_vf_attrs {
@@ -61,8 +62,8 @@ struct devlink_port_pci_vf_attrs {
 /**
  * struct devlink_port_pci_sf_attrs - devlink port's PCI SF attributes
  * @controller: Associated controller number
- * @sf: Associated PCI SF for of the PCI PF for this port.
- * @pf: Associated PCI PF number for this port.
+ * @sf: associated SF number of a PF for the devlink port instance
+ * @pf: associated PCI function number for the devlink port instance
  * @external: when set, indicates if a port is for an external controller
  */
 struct devlink_port_pci_sf_attrs {
diff --git a/net/devlink/port.c b/net/devlink/port.c
index be9158b4453c..939081a0e615 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1376,7 +1376,7 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
  *
  *	@devlink_port: devlink port
  *	@controller: associated controller number for the devlink port instance
- *	@pf: associated PF for the devlink port instance
+ *	@pf: associated PCI function number for the devlink port instance
  *	@external: indicates if the port is for an external controller
  */
 void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 controller,
@@ -1402,8 +1402,9 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_pf_set);
  *
  *	@devlink_port: devlink port
  *	@controller: associated controller number for the devlink port instance
- *	@pf: associated PF for the devlink port instance
- *	@vf: associated VF of a PF for the devlink port instance
+ *	@pf: associated PCI function number for the devlink port instance
+ *	@vf: associated PCI VF number of a PF for the devlink port instance;
+ *	     VF number starts from 0 for the first PCI virtual function
  *	@external: indicates if the port is for an external controller
  */
 void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 controller,
@@ -1430,8 +1431,8 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_vf_set);
  *
  *	@devlink_port: devlink port
  *	@controller: associated controller number for the devlink port instance
- *	@pf: associated PF for the devlink port instance
- *	@sf: associated SF of a PF for the devlink port instance
+ *	@pf: associated PCI function number for the devlink port instance
+ *	@sf: associated SF number of a PF for the devlink port instance
  *	@external: indicates if the port is for an external controller
  */
 void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 controller,
-- 
2.26.2


