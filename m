Return-Path: <netdev+bounces-234621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FDC24BE2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00B99350B78
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDBB3451A2;
	Fri, 31 Oct 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D2yJjIsp"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95A34405D
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909380; cv=fail; b=KwN2s+78i1WNPC4JlQOGEv/8ELTThzrdPspy6zGHOo0QgcIHXqAfFhih1BTmR9iqtyyWpQXQKSrEG6aK6or40lr0XDrJspqlQa3Yr9XucpsehVfpKbajKQ0e5nQ2gE2P0Sxpfw9yuXfVjE7+05GRZNYa6TxD7SxJgCL3Soaeomg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909380; c=relaxed/simple;
	bh=HANQBEgFCPd1aFJ9LeWIDmn0EDMfXvNBIFdndzEJZQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWibhN/zQOsC0LdmARtboc5mXpGrdPwVcVmkY2pQOLFiEfVpM99c/gFmoEk6iFEmRWPWwa4a3FDqh6JxdGAZtFX8o31Bt96zkeEEVPQp67gH8ZpOgh5z1k5oqldAlgpCnLIPFNa1A6G8HLMSRgm3v+Jg/z3dIFWzVI0RCZWOnOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D2yJjIsp; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmHYA6debGfvo/f6FznkFaoVZUa5aXc2NbjlqQLZOzsDdo877W40VZ9U8p4j9rXqmx8uIYYhozrHF7stXEaYw4TvUtdjP9g+FbbAmEiE2+BvMsOmLblbYc0H7ej8ec9m/JUN56qIbbYEC0qNKa1ZMNxSJtKh+SU/FvMw4JNjpgYs1HswhBBUYxosTlZccJLMBqtVNlmzqypiDH7jJ3niibmyZ0lMIFnfOy204ZmhZX0ql4vWBulrFLWceIG6RiLNq1wWR1td4ETD5kKoVFJ+juH/P/anX/hh2IRE2kjhwb7JBP4AGcqh/XRt48rFZb5Ov2lTRA0yEIToFAAuP24D8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQAyYZKTgkC2fiGMZdUJUJM36YrnAOhpOnTMTumpE3A=;
 b=NlGqN+FlTNzV1ak9kw7TgggyETGwumOd0ghgRaZczp5zpFvzUWI4pVdwvEyD4Nl9cMfIwTvrsSx6bevszTMj55FXgtJFOfLP5TTF8owW6mOPKJgoqD7q+3RcNC7NnOgK70XpEaRFltSsuBcBxAqonH1XqBMLuhPImDE8Qm7eXKYTeX5fAPcXzRBfuRGDVREwwV2GaOFwhFNajWBzUya0JNfO94bleUJRPzw6x22fTlEiVZKV//IXmomX69RcxZfrch91T1oYgzUvJ15I2wpxVn6vwYtpKPtr3/N6QX/FfiCyGnf/wrO8savCdN6Psnkq3/pYqL8s4DhJ8NscbaHzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQAyYZKTgkC2fiGMZdUJUJM36YrnAOhpOnTMTumpE3A=;
 b=D2yJjIspyITkpCphuIMxKaAq9lgvMtc+mvmlG9R0kemQfEpGi4P7OTjBOP2p4N/qdvuLeAhBwHjpyVD2sbUFYPZ5PK6H4xkxs123BZO+HswkCvVH7BOa3UGqn6UyMqwjoJOz26gIn3VNYvVSne+IN8qDkhmNDOBj+TYtGgsiiOA=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 11:16:15 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::24) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Fri,
 31 Oct 2025 11:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:16:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:16:12 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 0/5] amd-xgbe: introduce support for ethtool selftests
Date: Fri, 31 Oct 2025 16:45:51 +0530
Message-ID: <20251031111555.774425-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ec9eb9-2871-4342-ed4f-08de186ee85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktTQIavvQ4XAIXSUZ3sw2GKmbdo2OkG3w/6xGRIyDrxGY2be5bajVTyxAC0f?=
 =?us-ascii?Q?c6O0oBPQiESBro/4NvqJeCL0XbJyxQ6bcUwtQTdk87sNL1UmNH2mjq/ow1jQ?=
 =?us-ascii?Q?JC2q77432indnJXvZOJ0mWJU58B6jqyAurtAUJ0tGvbvZHkIAXAbCbEtmuTM?=
 =?us-ascii?Q?uxdkZpeEdCqLf9ekP2zS3Y3EXWYPMa9vUn+RP51cXjG7ReMmEqcynmv35XJJ?=
 =?us-ascii?Q?yhsFO/QemQlRtIaPCN98zkNZ2FTkFr7xPBa0Zaqn1AqL7TcDsNg6Y8Titnic?=
 =?us-ascii?Q?yJnnsIyLCIXOiqHQv7IKoQ3CsJPD7Xf3N/igwIPY6wMFO5WVPPQ7yCz/2CtL?=
 =?us-ascii?Q?i8GgIuDAm+5qYP+4MnybYeoIkfpoASql+1kTJL5+sC09O3W1FU2ucYbxH1VI?=
 =?us-ascii?Q?rPsa2wnqsvpAqlVSyxaS6PMbydr2rBsnrqFX0sFVKHej7E06zEdXXpMWcImm?=
 =?us-ascii?Q?g3jJUlYsViEnnN6ax0BnXfFIfq+PYJjJb9WsUVhcQgdM+WpkmPCbbyozOvSs?=
 =?us-ascii?Q?RHNUraJn/qkTA+u7Qy2RdT39/LNGjxUfQXXFvHxkYLIi6vuKdP4X90cMKT1n?=
 =?us-ascii?Q?KC1iNVXo6mBDYuSH/veQ5opPgW2YZlhe+xoOQHkEetGE5tSo8pIczn2Uxi8F?=
 =?us-ascii?Q?HVnE4D22YyBxh8z90OlJKlUUqYWLScEZoH97Tlg0LWqn7Y5SEEenksgAxjms?=
 =?us-ascii?Q?sXzsQjKiL/04ekdVpjjcx6I2PxuJezs1DVn/ZuW/8KJzSmABR4rlMOTmn/hY?=
 =?us-ascii?Q?zT09gBeMSkNdmRsCCOjhJ0H6AaGy/KXYTapvemNNcXZkkNCcvEldijw2o/6s?=
 =?us-ascii?Q?1YZrVTwSok0xD8TNygPUsVvcrQI0dvm8iiTmhuoqJNE2fBp+NmOINmSXVcXb?=
 =?us-ascii?Q?ZRtiz2cEmmO5zxA5WnsbU9Ie+62f73u1A4hPB8jJoMi17dmR6i2J3jAGXVRM?=
 =?us-ascii?Q?y88fTPm58BdrUkSOTSUAnHRDQoVqa8U1kLTpLRwk1pJ8gKKuSTGAVU+8oV0t?=
 =?us-ascii?Q?szgy5oD7HHj1uE2wiWjMRqFQML/NtD27KzCbK6DwQP/7rTM5qm5ga35kshTP?=
 =?us-ascii?Q?Jp+DjQW7egna2xzfMuKNvgE+wJq92qBBMulFQk2ZAZHczNGCRYZknBrf2VPE?=
 =?us-ascii?Q?3Ernqj/d34c7E5jBJoEo+Nv4RHOn792P6mx+U3vzVN9XycvJKpxx+bGjUwLc?=
 =?us-ascii?Q?c+K4IkwD5PYT+JOZfi/pjGLSLOc7+aoDugOXKV1iZY90E57dpWKpbU4KEHwo?=
 =?us-ascii?Q?RIurCsgiNvyqQHa2kqDSolKIOABKpN83CcCgUBfCzUTJh58eiaOyt+pYI3ys?=
 =?us-ascii?Q?IXC3JGRMUEPbBAKwK87/19wZstmUDXlfzOPUCE4deC5NmGDf2cNFN9zpw9x4?=
 =?us-ascii?Q?3ICqz9wfKmGVn682xNtrRFnN/RBtbai6N+TxHK16ziTBchqUfqUOcArGrpJ6?=
 =?us-ascii?Q?fmtV4DM1jOmK7pueB4An/aA92fBjNgebLy9MgUoSd7qtVHXBMEtjkxe4gO5t?=
 =?us-ascii?Q?j5ud7tzHsDAMyZSQTiwknVqVbaZSQklJdea3tQ4kZs5vGdaAPhL4B+eXdDzJ?=
 =?us-ascii?Q?F/UVhHb9IGIYCv24vdc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:16:15.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ec9eb9-2871-4342-ed4f-08de186ee85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798

This patch series introduces support for ethtool selftests, which helps
in finding the misconfiguration of HW. Makes use of network selftest
packet creation infrastructure.

Supports the following tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

Changes since v5:
 - follow reverse x-mas tree format 
 - fix the commit message for phy loopback selftest
Changes since v4:
 - remove double semicolon
 - move the helper functions to appropriate file
 - add inline keyword to static function in header file
Changes since v3:
 - add new patch to export packet creation helpers for driver use
Changes since v2:
 - fix build warnings for xtensa and alpha arch Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

Raju Rangoju (5):
  net: selftests: export packet creation helpers for driver use
  amd-xgbe: introduce support ethtool selftest
  amd-xgbe: add ethtool phy loopback selftest
  amd-xgbe: add ethtool split header selftest
  amd-xgbe: add ethtool jumbo frame selftest

 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  19 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 346 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  11 +
 include/net/selftests.h                       |  45 +++
 net/core/selftests.c                          |  48 +--
 8 files changed, 437 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1


