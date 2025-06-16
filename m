Return-Path: <netdev+bounces-198060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA2ADB1D5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35B27A18C4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDCB2F4317;
	Mon, 16 Jun 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qb0xN96b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9E2ED87A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080386; cv=fail; b=pDNeN8uhrUkO0QWtbS1O1w7B3JD+rvoEgFmR6JsgIKg6MnKiKrsDNqKMg2QWEI3T+gj01qQniR20DP2lCrWsCEDuWvn0rVu6Sb3ZE+KT9WL15tWOoe0/LC8RcE3pbted1iyOSg13pNVkJRecp5kNDK8mAgyChfEgSI2Iiy8n4MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080386; c=relaxed/simple;
	bh=K54BLA1ElcobWoJ6pN8W9fMaFZf5yXMRWe6QJNL2GmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bH2qpOpnoH2UqNnwPMN6zNbkfrePG2HPVqaoy8IipiXyGWTmK8qY619psZ7Ux7A0TtHdAprslJPvouhVeezDRstLzTKXFw4WEurfE4/gwxiLGGsfs6u/ueiOubzcdekMYzRqUkR5rdFj2ax/E7oAcvRK2nfPA7qILddSJ1lGbrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qb0xN96b; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTcgrhayuejpgalWeTavtmU+NnGkWdtdxhauyavp0uMuhdObSB0irCTZIT9zt8FbOxZKFQtalRTR9pmMWXExoHXye2j4GckT3KyY9aPyvniM0FGLok9Rx0Ctw0knMUcHbMcU8hLBvXr/VfGHph4Dnd8B7fmwPTlByOeDGKdYYcNtlb352h0ZsqZ6SbzKPwHAGyI1IjgzysfCJ+7CeNhbSXDW1L+Yw70MA2BHZYTrGzybUiiliCHn8TC7MgolNbQc86PO1ihz4QxvONlkOI+HxKgj3SjPf25PGfi2T21msLfEZq7l34ySMXBb5GotmqdYDUZN8FYE5B6/UyEQ8Cdf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Is8Z0F7EvOM21x2IFO1GDPYFP8ZQlnC0mg/UzwGzw=;
 b=ybtSLS1cpR4yJWMghA0eFB1If+G1HCjQie21S9oL6Wu5FHj0bS6tAFuHgUjyKFtTL5K7x2XfhYWk1TZejsPxY0nfRgBS1aIzyYvMZZ4hfdPI9tF/vgYu171yGth/Nj0A9MBV7gqbyNO+/ICwkKT8vjDSMlB/ub0HcdC+BMFFH/k72w+OW3DTIZIA+aCKyJF0zPd3qAIXbMI4geN6iZRghpKi8vgtHdMgjZ18h39E+PEewdhb8kOcs/9P86A6EBSHc/k6qI2btrIqt80JiG8fXqqAxSuttucfDbwt9JALGgU6fhOVi4ms9oZJPGyO0o4C/cnO3dh93o4+XWFJEH0O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Is8Z0F7EvOM21x2IFO1GDPYFP8ZQlnC0mg/UzwGzw=;
 b=Qb0xN96b8sWP6CNefyzinuq/m9tdN4Wwy2NDxpMSNA+zvtx3Qb7c2SMsvhGirYsidcUZ+3VEUzaoiGlmUZbNfemTYYVp6ZL/YyJPqWNxROvRZsv9Isptaz9NaA3OMB9POLCTGM9K4Er85hkz4nQx8Dbn+O1GqP3/RKqHVgRfCQoXF+MkgeTaBRqI6pqxJQu+zZebTYwquUvGfsLhkP0bQEooc4zBavpy2oIVkAvziM+3Lv4rQ7NfbQqLe+hLNkXRS/JWi7iT9qmfQXHL4dQbi+5cwR8znWS4HPWoXedXIoeZ4+q/QfGad1G+NDMDcEOV9Vkk0MyXuM5FgZIvABQyzQ==
Received: from BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:26:19 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::cd) by BL1PR13CA0309.outlook.office365.com
 (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 13:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 13:26:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 06:26:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 06:26:03 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 16
 Jun 2025 06:26:01 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Alex Lazar <alazar@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 2/3] net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
Date: Mon, 16 Jun 2025 16:26:25 +0300
Message-ID: <20250616132626.1749331-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250616132626.1749331-1-gal@nvidia.com>
References: <20250616132626.1749331-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 179ffa2b-db87-4bd7-db4d-08ddacd960e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0941/ASlUQZwdNppA6z+/mrQ2negKWKBz3XCFUzyAkSQMx6u1x1cDBlqW65G?=
 =?us-ascii?Q?HWkinVqtUk5q2jV2lVEAajQEmQBUKDa5msW7U1KEjiwN68X18oVD5Ef6pr48?=
 =?us-ascii?Q?krodbIiRItGmzEm/C9rNdz0044+UouJdBDJoOmON1SkJMhriAUX4gECealL9?=
 =?us-ascii?Q?dlwSjoehWRO/ar14BqGCHcFruEIiruV9nUpMWfabGRUeUSdBC9LZdZ5mT/fl?=
 =?us-ascii?Q?QOKd/Jrl+2wzfDIHihQFji3ygqZE/aq9ge3zEepxxNQ8fJnPlg1COk6qTlJG?=
 =?us-ascii?Q?MIeFds4TJ8lDNqu0C3TpE7z6i364O7H6J9or1LG5i8474qUmCqSwOJLNPFzW?=
 =?us-ascii?Q?v9bLlaNBqTtRqUoO8gL5+cmipEBkVzItlqbUK6NUaYMwVq4Ym866/KGDQ3z0?=
 =?us-ascii?Q?e5QTEKJug04YZTZCA4+S/IMbQkHDdhcrR7TunakUXdFPDDIc86Id+OSrpKrk?=
 =?us-ascii?Q?/2Bt+oIvZxbNhVKS17HRBP6eHzeMMTQxjmSB8KmvRwwGxWb2baOuA5D2X6gL?=
 =?us-ascii?Q?WZAWUeLsJOtxeMfAj8I334YMWP8NhqRTwzq0j/HJrlBDPSUFjmOHsyBz63AR?=
 =?us-ascii?Q?AcNBqH7qhE6nuK47xfUZ/xWui0xnQ2xZFlwTkVaE1j4xxtcsp/q64X+m2zNF?=
 =?us-ascii?Q?IhemorpoQ0E3kP+oyScjJdJpsCHd4fYNf9RgHM+tKCdBm3u75yCN82O//fNS?=
 =?us-ascii?Q?dJUEg6jSrwr1DhWgOggsHNvTH2d4mYoSTfsOQPUyeWAuvHYlYqw6wDeB02F2?=
 =?us-ascii?Q?knwbAsgpVKFLrbASF7pMgOEdLRuA8oRtEFooxDXn/FFBZKUui/ecSFPbsYQe?=
 =?us-ascii?Q?HbzqnlDd+qzeOYwVMMe+EGYBUBAsnklp1II/1MxMYKN6FjR+NhDktGxrjSM4?=
 =?us-ascii?Q?RhpZpcK0qb5vGvfODIX8n73FL16pbtNGx40LV0ndOyFXZMi4MUQ9S9iBCF7M?=
 =?us-ascii?Q?oeteis7+OAoLrpzBYxfseFAP4TXAwZGvMjEyfm/6MNaeAV3gc0SUpnaaf3yE?=
 =?us-ascii?Q?9vj/QmNvrBSb8cMBXVSypVq1wMIedQBSCEmcZu8lWRCLGj4E11rC71QRxwcc?=
 =?us-ascii?Q?2/ZdzVF16+Z7T4m3fANYXvitibZrPtEMtSor1pfjLf35L/PLZTZRVpXPJ1dx?=
 =?us-ascii?Q?2P0U7cLergdVsuTUbWjky6EctIdCksZWBtqOpSpd4Ab7drsyp5a0OOhop4b5?=
 =?us-ascii?Q?mGieRnybWVhsCFWin8zQsIxNLHFAxZerWr21MFeMF0UtnRg8EYNDmeM4leoN?=
 =?us-ascii?Q?6X3eEA6CLvWw/TGCxcUfQCjoUUtANDlDwGAa3cDsTl+ZOC0hCtfS5Xi32os4?=
 =?us-ascii?Q?H734ycSEAft5y6QAlWD354ZUPvLkVMPd9FiLVJDYCh7hrlN3r8Pz24ovrTax?=
 =?us-ascii?Q?4DCjinSbkGD2Cj4RfQIaZowHIDRSl6HK65G/0nP/LkmyIRZT56UcwrvJPOQj?=
 =?us-ascii?Q?6NxR4MBZSG9kZRq4UJdwLd0e2yK9xV+4KDHVAkdWO9b8FcxRWqTOIZLoAhKF?=
 =?us-ascii?Q?m+b3k0XVBo+PbY0kFtp/6o5SX/GpYIg6zsMi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:26:18.8135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ffa2b-db87-4bd7-db4d-08ddacd960e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

When CONFIG_VLAN_8021Q=n, a set of stub helpers are used, three of these
helpers use BUG() unconditionally.

This code should not be reached, as callers of these functions should
always check for is_vlan_dev() first, but the usage of BUG() is not
recommended, replace it with WARN_ON() instead.

Reviewed-by: Alex Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/linux/if_vlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 618a973ff8ee..b9f699799cf6 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -259,19 +259,19 @@ vlan_for_each(struct net_device *dev,
 
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
 static inline u16 vlan_dev_vlan_id(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
 static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
-- 
2.40.1


