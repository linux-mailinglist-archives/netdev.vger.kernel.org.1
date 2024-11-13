Return-Path: <netdev+bounces-144573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B19C7CFA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FB7B231DB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E84F206E97;
	Wed, 13 Nov 2024 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqghZ41D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9B18454C
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530051; cv=fail; b=qbGyaEHVCEmBHThU1BSMLw4XuW/YJFvDejmXi26w1YYBAg5B2/y1cP2rEjNo5BgqWD+onBJmDGpfKQmiZaLj8GJv+Etv16p4kmuXfwegNSF0SJjBPsTG1Z7zcMPaCxEra+bluKq6P0sZ33yHV+hdLc4VJKlXJHUYAkB7RXVa8bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530051; c=relaxed/simple;
	bh=FSrUI++riL2MAo4nFp31A643EWTN6uy60QeJbEc/fK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN1o9HxQhiH8fyi41+24ur36s93FxcJV6zPjUGaFEBmklgVpwIsSHyrNTXEfAdWNENHQs8UJBAPEExnvt9+MHuLtiR0T84vqsORg3CYHaDjaYwdoO9zaIK35/QTefD7KTyyrrtbSBBBzREirmcLSTBB0fgTz7UlbbIUsptuadlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jqghZ41D; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj/FFigMDOtayx+vVfXQ1ZPYIkWImPnuIIODipTSMC7Ny8RXY5tEWwpjv2kmGZRpMcgNSqxuvws/K7Bd0yO7DJ2a8yM+Cz6t9AJ6bjAQG3hjMm3Q+XbGCw2qkAMoYezejSa7+S6/8ayeesht9V5EM+t/FMHfE75biuMm7kawUEhUp8OMUvV9qFtbLfcbZRBL2GwDP30Yi+1iwNryH8m/djXA6DiCY/dgBO9K3JBaD0YofoKUUTm9tfsKccU81MHj/R2XadcMqaAQ6/Z9piWdXugX0cwxGxLv/sDM+tO9zznqxirPpk1Gib8jJyU8//uTydvwX747mUACDUN8AU+/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRWySyDUhGC3Gywz22YKkFRyRhbBpoRVpd9hXTsNVD0=;
 b=KoOf+uKwPitmRC6vbFYY3g5WxZ5xq89lXDr/y67fIFO2ZAWRpVCeRfikUfU535hrPQ1Ib2PLf5lxCPDuPk2FpXEAWZmhqtUitfxrs05/HExP0FjkwrvoSzppLkHv6nS5AzCTv31p5uGqRjdLqyUsedMm7A9PiJ/y2mDFjZQHCX7ERjePjGK7fgIjtepm+NupOZN8HUL3YL/w6OpWIydyVvbX8LiMJltJVDvCvZPZiTpFjcjCqilungs/sX55BHbGNxApd2kH7/65j1Sc3YSsjXEzFkaLVc/q8W4nHGbCRtdSeH1LaYYWo6gCbNDv3S9gRUTcK47Ce+Xd9OIpgVnbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRWySyDUhGC3Gywz22YKkFRyRhbBpoRVpd9hXTsNVD0=;
 b=jqghZ41DGYnuzTw9qD1vI3+uEpeAkawrITpkOeEkH0D4meN8NoT624hCPa9IzyMe9vNwijxKl3+zRc5gvehD2OOQrNx82Y92EH3/bQ+nHJ4qvQDslWaJxA8UHs72SscvMSd7c8sOz/NvNZTzYTvGXy/aZskyjL1cKoqLMEwY+h5dKbjd76e2XU2opKQLGF5XBZd9yG432N8PbqqZPqCS5leoHBVCW1WexwsY04RMePPn5G/wpHAEPjpZRCfBlEcVFv/v6O+36UixAWmauR26I8r/Py3zwaxbohN3Dpn0ikhDbdRc9JEAuP/YZUmosl9HpvO+MREhH1Ccrlx1Ct63ow==
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:34:05 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:180:cafe::59) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.12 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 20:34:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:42 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:40 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 01/10] [Cover Letter] devlink: Introduce rate domains
Date: Wed, 13 Nov 2024 22:30:38 +0200
Message-ID: <20241113203317.2507537-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: f263f755-3a23-40a1-8f50-08dd0422842a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7VljJCr3gMQc07xHYnPpyUe9Kw2GPtqlUXR6x9rCNJwcL2tWgrdwYMtzOd6?=
 =?us-ascii?Q?g/PPA3zGCJW/X3SG8y/1CkI6+iuMoiGysuc9rdBQPnlXxr9pnbxcZ+yM9jHj?=
 =?us-ascii?Q?oqKTsyq7W+TP4eIi6aHv7F8UxYfkEgv4K0JkqsderRYEirdtF1IoWiX3qLo+?=
 =?us-ascii?Q?tyf9pkqXSa4D3iDs6jwefU5bYIafQlTn+ZPNhRSKgw4SnLavRPJiKPiVi8eJ?=
 =?us-ascii?Q?9MQTzn1lINZa77yDppHNoV3r8OYY8biPyGlNMJVX4OiKAKIcJPmkoFnIfaG9?=
 =?us-ascii?Q?6ofC9TWgaJN5JgfHaJXNqudhyPdT8VejXZCfD92+y1wUY+k1TCn5TIXVzrPc?=
 =?us-ascii?Q?qX1xNrTu6/deszC7czAnIOvyXivSfXf9We45X3xUC7o0qDjjwADvd9FU4zK+?=
 =?us-ascii?Q?vGBkmqA3rXL4xSNTDO1nxap1Ccun/0GlKlAXt8iSP81IzxJAmf8QLuOETh87?=
 =?us-ascii?Q?jcxE3R5QkIKzNRcJZJERW0ZxlmeT/0YHXbSuhsWKzbt8hKHzMiyuXswxNVUA?=
 =?us-ascii?Q?WRBhbKp6YMywWblsUHmgYA4cQ1vdOzjfzL0B6ADos7Es9W0wKnPthZCzhIUV?=
 =?us-ascii?Q?oBdoESvv6/XKXRQQ8ujMQNYMccbMZswnLxF/jgfeowp12dxrc1JEz2ZXr2eN?=
 =?us-ascii?Q?ZlVeU/36DaXcvm75mHvoMZZAXjNNt/7eU30dz6UrIc/pVfWi4xVYqkVH+8GB?=
 =?us-ascii?Q?65eHP5epROVp95NQ8f7NE1DPgbn5xwIDCMhI9B6SQsIB7FIiEMYeqnKm2sGE?=
 =?us-ascii?Q?sTtxkIDVOV9FiS7kkvJ/XS8Vbv+yqHh0tEmmitFDSZSGZqVVwehSuEUlB8cW?=
 =?us-ascii?Q?lXf4Rkerg+TGeU9tUdhi0oeTV8DUQvzUlapWmm4763XJ9TU0LfeT1t41UqiA?=
 =?us-ascii?Q?UR19SbO/YA7hy+aSyIkl1sBRfK37w8yXB4XnwPE8HvJ2SPN8wuR77zVBb4Vh?=
 =?us-ascii?Q?5fRZI3AOC2OHay0rXGD4Qr0uumUpATT2omvIJ9Bn5cH16qiQiRW0FbCoAVvv?=
 =?us-ascii?Q?5n08Za8Fape8r3yoAmxOa7KrtwpMCfGo4oRd978xIKRHgydk5pC0K5jCirv6?=
 =?us-ascii?Q?TfQp3dK1LHYozqDtxNIJ/ATpA3qlUrvOnMOvcu/rYF5cYw+n2SGofJ76OcDU?=
 =?us-ascii?Q?k8gccs3hwyZaxoXm5FsXMrxH8lWMOcmALgOaf1pgKGFE1sFBkuz23tHcaPjp?=
 =?us-ascii?Q?BTWtUrz2vLiwGnHPyDhhdLGg4QyGBuTn/kVqze6amU6vOm94rwUAinpwlFt6?=
 =?us-ascii?Q?36w13X96FIXl+Db3TiHE39c8nAUM3li8Y35n39GKSY/mNruKKAA9uh2t4ivl?=
 =?us-ascii?Q?1j841gYAU4iDuwDlkAuAYtl1f6D0zSrJHpvwdy/dVAscaqq9EhXvSZzuRvXe?=
 =?us-ascii?Q?8Hv4oTSqXVwGoCT27TazVVfHE02NZ3fo7Xw44iIZ02mNsP6dOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:04.8165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f263f755-3a23-40a1-8f50-08dd0422842a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

devlink objects support rate management for tx scheduling, which
involves maintaining a tree of rate nodes that corresponds to tx
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating a tx scheduling tree
which spans multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing tx scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed is to move rates in a separate object named 'rate
domain'. Devlink objects create a private rate domain on init and
hardware that supports cross-function tx scheduling can switch to using
a shared rate domain for a set of devlink objects. Shared rate domains
have an additional lock serializing access to rate notes.
A new pair of devlink attributes is introduced for specifying a foreign
parent device as well as changes to the rate management devlink calls to
allow setting a rate node parent to the requested foreign parent device.
Finally, this API is used from mlx5 for NICs with the correct capability
bit to allow cross-function tx scheduling.

Patches:

Small cleanup:
devlink: Remove unused param of devlink_rate_nodes_check

Introduce private rate domains:
devlink: Store devlink rates in a rate domain

Introduce rate domain locking (noop atm as rate domains are private):
devlink: Serialize access to rate domains

Introduce shared rate domains and a global registry for them:
devlink: Introduce shared rate domains

Extend the devlink rate API with foreign parent devices:
devlink: Allow specifying parent device for rate commands
devlink: Allow rate node parents from other devlinks

Extends mlx5 implementation with the ability to share qos domains:
net/mlx5: qos: Introduce shared esw qos domains

Use the newly introduced stuff to support cross-function tx scheduling:
net/mlx5: qos: Support cross-esw scheduling in qos.c
net/mlx5: qos: Init shared devlink rate domain

Issue: 3645895
Change-Id: If03c5c0562bf4b53fe2fa7b8a070207f6715a755
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
-- 
2.43.2


