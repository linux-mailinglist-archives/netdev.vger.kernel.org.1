Return-Path: <netdev+bounces-154218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BA9FC14A
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2534E162A10
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC601DA112;
	Tue, 24 Dec 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBxvPjDc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045B1D7E21
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735065461; cv=fail; b=rFBAvUQCfdKXQYzF3QyuEqwDLDQPWcxbWCJ6hAB6hzLXST3rn3IOXWa20G1iALVF8Kj2pki85ycdrwxyskVI1nMXXPfAIJ4P3YaNlguDIHd4qCpSgHp3qXZ5JcVUIsXSPSEfmD0Uf57y2LfDnKQ7fT4VAAqMig7mDSh/8NnobQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735065461; c=relaxed/simple;
	bh=asgeKB0C6lythKez7rAmTS+8xa2ByhbhSuKuhBiSjYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gYVIuKLKNNCTKNiGi3QTZ+9+QegbAR0tUC0SwYUc5nTRWdNIgaLKb9V45tQ6ulAe6r4BSrFCQtQMZpiGLCuLIhv0RlF1+q9Vu1JR17vFlQyRe9lcKFARhrjcnCF4PKNA9heyqYSpHhtzun7WDKtN/sHVZbHIp3WT3YDX49XczFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBxvPjDc; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyycFfA4qpbdTOVtlx0IBecLQE3HXH/31iAuEqzBFqrzCgJhzgbygfKyWspjmiEKfYVSFOUfkkBnTv/uLcX4YqZ3hEFkK1K6/M+IFXW4w6tumR4XiuZRYgmS/mP4SgizCrfkS4UdAQgaPSarfWoXoe28dvYR+uKCcgAq9FrsW2i5DZdXjlBPFffhXcAN/lo+qrmwYA4EFeAdOKfu9KCbGJSAovCqPFdKsfRHTVrDKbGHJHqnRf3n53KUMjdPBkTvOyRIaCFt2T578IDpIYYSbjj8xTMgeuoQ47gq80Qy5eZQs9Mv+sbj1ibYfXuhJ1ABFdk9jOdrmf7rDHiTr9LH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUw29CpPAlHbMVqaN624aeG85GyxV3ZN/O69GYkoSFw=;
 b=OSJTnKDKPYyJJm8Lw0v/4RZt7ynY0BRbdICZXBcu25O3w33yPaPNZPbnPu9smGHZOkVZMnCbbkiLjRVK6QQjIZEqcL3NTd91Bh/pRULh7JokHGQIvnrmZ0qjU/sy98PwjNla1wPFLDPFOav0xNi1Gyz4KUyFvEcKmDYXGj4hmExRJM9F+/zpvCgPXPdKcH4ysOWjS98BtPYeNxt1Xcr2Td6e6z344QtbEJEFKGuxDYGZBc9Q6Hv0T++YCrgvjQmR7lGBpLjmCzELPG+sR99N09d8LhX5SWN8gPXDtW7ZPl84SxqN8bninYVDtva9eaeogIjzlrxNH0e3bTPGPNSEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUw29CpPAlHbMVqaN624aeG85GyxV3ZN/O69GYkoSFw=;
 b=mBxvPjDcKJ3ZQaJQsX8SVsHJjvtTXyUJ+fcAOqrc9B/rSXNMPQevjkUqqbMGiXB+00Fm3j2C/R7ZJQsBuIntG9yNAOuE8SONEByoPtITEJgyaAUIJux0aG6p4zkirB+hQ6h0Lcdt/SPsrobjDj8STcWLA0faSdK9L8mk3sHQbAijfteYtyCT8+8gWH2sBAJgzs/bKJ/I36aqA7edMVi3gvXhrt+0Ck9YWmlkWfwz34lKkEYKN+UqIo9o8WxYEHENdImBAx1PfNuqR3dLnW1OuqkCLUnNeUB/LtsCFFwrV7/5cKSO40xervU0WUKH27g1dOyIQR3tvNNDK8u14DhmKQ==
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 18:37:32 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::36) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.10 via Frontend Transport; Tue,
 24 Dec 2024 18:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Tue, 24 Dec 2024 18:37:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Dec
 2024 10:37:20 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Dec 2024 10:37:18 -0800
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Shay
 Drory" <shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next v1] devlink: Improve the port attributes description
Date: Tue, 24 Dec 2024 20:37:06 +0200
Message-ID: <20241224183706.26571-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 224dddac-d746-4916-e9d0-08dd244a0720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rljnjfpD2XK6x0r0RnwYryJ0KggzFfcWWDtxmYgnj7/YvJApT1Vrfg0Y7r/S?=
 =?us-ascii?Q?0sLoyjpDIN7LWuLap3p8M2a0Ln/ACzdJ9AwrVolBAXuxD1MPkuJPNs4YyRmz?=
 =?us-ascii?Q?OHfgqGqk1ZskfXaiCohILR2T+mWDKMsPcXWr7FF8mmODPKWB2zOCOg/2G1gd?=
 =?us-ascii?Q?PglrcXnLxJauVqSRCaiiYRbG8iYw0Ep5Xb1+QjxTRo79CXkMKAx9CFcq8lVX?=
 =?us-ascii?Q?0RzrqQzTAuWr86VJW1sj2GbbHoxZPn4iqr2Yq9ys4rVjxzSsIs0nx75rJbGT?=
 =?us-ascii?Q?6EQ5/5gFBYOhx/aVXtIYru00dElo0av58syw9rA2J3F363ceKIxmDXMfOdKy?=
 =?us-ascii?Q?iaNlyequtprz6QzyBg6V2NDtGls2Svm1HGhUNdOn5J7CLRIp3/RjwFZ4L4ge?=
 =?us-ascii?Q?DLnHUenfi7hUlZYcmBhyA71HmEM+aQC10xZwDGUXDi59COpR33yqX8LuHr0f?=
 =?us-ascii?Q?s0Jx04hEPov96rbqVtAikpB4I8lhblbKLDUlvNAmHOkv86ygRWxYrGMJufx0?=
 =?us-ascii?Q?u9GbyqcjFW9tkzK7mjROG7hprEzl+JuwxZuL2CV10xVTz5uShCOBMxXn9llG?=
 =?us-ascii?Q?OsR2HeaI/PnnqmMv3kWUfcODj1S8G1mPPfSx9tTEskOYUpUah7Dp2GDRslkZ?=
 =?us-ascii?Q?y6uWeybmzw0XCej/f9uu3USkhWdyQA2BXR+4JoAJ4mOe0Ju08U7X2/6srsdh?=
 =?us-ascii?Q?/JCcJuYUH9ajG4ITRButdRngkcl5jqe17pbMleuDZ8KK0YKe2pXy/0YDVls1?=
 =?us-ascii?Q?BRX4lChAUEkaBLgIl/9m6nYaIfZ7AoMgf7gN7AmfS0Jq1htJTgpOyrL2+fEk?=
 =?us-ascii?Q?68EQxKOwzD6MyA40Th7JODWcvIpKF8Q/SEWU1ITetNMeNr7imdft7op9b11G?=
 =?us-ascii?Q?LyJTeOmWZCgF1mbgrPdncIiWAbJi1KmPKipwseOZ2Xm7NmYGNLXZJN0QJTiB?=
 =?us-ascii?Q?XTDybI3Chsbgr00lzvKCdNkujfjlVOPaclJeuTObAVQBbaNaxUg/L13NQP0T?=
 =?us-ascii?Q?DDSue+cMxpHMsr23KYn0S2xpgKX2PQ8ynVvucpVtB73Ip+AYsjiT1aSfs8Rt?=
 =?us-ascii?Q?4w4IOxU++3zRC4DN2LFaOMS1wpQCu1/1FfyrAqGno8SHkXYAzZf7e43s7QSY?=
 =?us-ascii?Q?tgu1WmcuFxKBm0w94WOgkmYdXPExZdCs00/vtWXkLx4AECqbW2KY0M8usxuO?=
 =?us-ascii?Q?212GahHwZ3USHxaHmGUYFVqkz9lgC7m4R+sUZutILQ1eXD6KJPeDa4wniWt5?=
 =?us-ascii?Q?k+HeHMt3JBaRK55Yl1+AdeiQpY69RL+icc3pIqsdsht1G4l8vRpL84LWgVpo?=
 =?us-ascii?Q?QI/j74PlITChMBbdrFetmr0pmu9h2H3+vWzCBzj9A13jaUiH9HIe9EKAfxiC?=
 =?us-ascii?Q?nD1gzAJz8F793hpQNhcCpvfIsB/rv4AjBtRUMZpXvudCqVJJmaGqmcnk4WHR?=
 =?us-ascii?Q?SOPxN8GgLDyKZjq/AA2J3F2f7DUOnfBuHY1rIyo5Hup4IPw7R5ERSsyqhoeu?=
 =?us-ascii?Q?BrJhYyu+Yj3c948=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 18:37:32.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224dddac-d746-4916-e9d0-08dd244a0720
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

Current PF number description is vague, sometimes interpreted as
some PF index. VF number in the PCI specification starts at 1; however
in kernel, it starts at 0 for representor model.

Improve the description of devlink port attributes PF, VF and SF
numbers with these details.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- address Jakub's comment
- updated commit log description
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


