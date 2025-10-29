Return-Path: <netdev+bounces-234127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2AC1CDBA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3BD3B18E6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFE3043CB;
	Wed, 29 Oct 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKZT6blH"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C952EA485
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764387; cv=fail; b=AvBGcr3FCQqKk96oGpM2MQY4xwGQfIPKO5GoxMlTBfzpQ4f1YWF8VRP5pXB01KlPbU03pIf8DQyAEfADwmH7xbP8ZfGQZV2NuA8yP5YV90acAOtJqBOfCdRoTuLMBvE7hWUJXU9beTkV7Q+e4ZkFXKpnCB7sWkvzaGHhsK50V2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764387; c=relaxed/simple;
	bh=AIe67SS4P8iklpTht9bcTq1UIWduS1xw8QWDgrLwDlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNlPznsuamLGl9GaY/zmBRjmecYDuJUNje8VIz7Fj0Vp6eGtSfoO+gdHjQ178Q+bcVYI1VxEQRNMqZJU1UGagkkKAnOwr8bpyf8ZdrcE7X5XnnZkFt53hXj1o2ustyoqWBWuX/7dbikTbq2vZo7Fr89Olq5Eo9m/y/WYVupNGRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKZT6blH; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si9f6QGtOZF8vHpzUAIv4vpvEcqAmaR+cnku4NouM91iom5RebHXALUK53UnCMuGlgfpH5D1xxUqdRV3+w3KoMJlaKswWYE7VaCnX3G5FuiEs9dakVj8eisjjV3MCpWRaJxZ6pKJXb0oxxavU2wkaMcA14u5qpIKgsAX3SOwWzY8GJWUsYlKlnJ7s8NK2TCLbxaQ3qf9aSo4lct0GF0buH8m3+Gr5hwoG234gWrKiRj+zdCeyyOwitUInlCxo0zx4vY+zLpg2maVO9YSVQWJNCgrf9bXYcEaWjGwWDrOwXPWmRE7h76sir+zoDhOgLNVMB9DJnJYYg1tKTif+3EVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuqkue9gf64KstX/tux2hD0D00WROirfFdrVcOBM81c=;
 b=mUrdoz4K8XiXguQx6SH+aR4AQErcV96bOAzaugJsTDyAhGWsdeooF/pi/fMetUXmpo81+7g68S2KL8rCAvxpBJTL78LuxtuIB6giOiz454W9qB9tYuydQ+yhDyJ1aapqnFdf+HVYasiPbHH2Ewv1RxAXipZgaI928RTPbx4WJdLZofA02WLUsf0LBm9aEXLlwkZ0Ug7UZ63tHxycSFbFnww+OQn8oPUpVZi95bKHbY5DMPfnsbt5H4S6Kyq8afC1RxkF6EGzeYR/d67TaBdaMRpqzv6/T3x1jtKO3tyHq77iyIpgygSgnMLdKyA2/xQJazeusjSVe3VgmNAueKY1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuqkue9gf64KstX/tux2hD0D00WROirfFdrVcOBM81c=;
 b=wKZT6blHc8UmhKQ6fQqZptEp/NLoCsnFnb+NLBYXzMsjNMU6cNZVT/dJKeDV+RKVoYnH8f7F1QLor5MqdErUh1k1hbohmuCnbrzgvjEXJuMABM393/KEeBGrsgUog0BfdfJi9NUrZfQl0ryLuQ0h5HJ9APKvGQKufzpHvoGH47E=
Received: from CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17) by
 CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 18:59:43 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::e1) by CH2PR05CA0004.outlook.office365.com
 (2603:10b6:610::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 18:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 18:59:42 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 11:59:38 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 0/5] amd-xgbe: introduce support for ethtool selftests
Date: Thu, 30 Oct 2025 00:29:07 +0530
Message-ID: <20251029185907.3220756-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 59453017-8c09-45e9-b844-08de171d51f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?il3JFigt0V7SrpCVmnaybcE48ThNKEnw3obkLbLFoCzPlQrV5qHcuwmoU5ST?=
 =?us-ascii?Q?m7w5x298gXUvKGYPriEbG/eqqXsT2dji6RPxjHAq8uyE95cluHf1NN7eqviV?=
 =?us-ascii?Q?gtSnI01vESy4OEi0OXzd+VFRV6BOWMJdykuze4evSov58cPvMI3Zw/coc71X?=
 =?us-ascii?Q?p8MRAXEwP0aqjS62WWmic0NSjmdHl/kK8Nj3DnUllzqoj48p7DqemQ1lClVR?=
 =?us-ascii?Q?annSjkFJkve2OSGqlltalJr2Eqm0lgds1hBY92GM8WYJyvH0mEnZViSPqh/u?=
 =?us-ascii?Q?BsOtlyDqnSyeWW0lcYSaoETF7BRSF9MQ3I1I4e2ZmByo+ffAEiJvNUU3wpIC?=
 =?us-ascii?Q?DvSSV+gm3X490rmldwnB3qK7VPhMjKaiLGadOgnex1JN3zhdexH/VxzuaY0x?=
 =?us-ascii?Q?jcohK58O9I2DEk4PmlZjDCfvef3MWeMrPwwVaG3tDSM4KcfUh2be/iV0kUwW?=
 =?us-ascii?Q?xOmHoBrJz3FNhdH9JJDl8tq/hefhh0Qc0xYeX+Afm+76NDBgVH7H998z/tUX?=
 =?us-ascii?Q?X7Pqpy0cGekhCL+dD3XbnxJTlXjYA2bplgW4kslWf6DYbmIIAzJugMlhQYzK?=
 =?us-ascii?Q?t5JKxTjC0W5r9KG/RGm6ekZpiHOTHemZlBRtDtgQ0VRWxZiCQVlXnXDsLXU/?=
 =?us-ascii?Q?rtvBEcPgudPY4pjsEaVZ6TxSOki45WOQlwoSMRf3zMwsUa8BPcYCl8yc7j7G?=
 =?us-ascii?Q?rMRWN2AWQy71YPcXVEaHdHwMVU1G3/PGSl8l3dSqvYiD6xDSRsM1Hrrt6STh?=
 =?us-ascii?Q?mJIRGtjqmTQd7pL4h93+CQpfRtiR0WArJOU+Kqgzc3MFY8Jg2RVWx+23k3It?=
 =?us-ascii?Q?AyyST/v3ECH349HRdi9vFtxha5GOFlDaw/IWqXSfoHGBM6WV9glsFBN4NIsy?=
 =?us-ascii?Q?0ENG6o2jHyJk7M9jImqSO4itVfTBzKvoNJ5JniHzmher/pKiKYsB3IvVTbOW?=
 =?us-ascii?Q?LGb35d46IFE8yG3GyMJvjFOYdUdOWX99GbydiLNx7/5xzJsTyugHvyUQuwXg?=
 =?us-ascii?Q?gbtWa6ZM4zyhggUzyQmEp4slaQOHE524XLKBVfnCjNvLR9aRDtKpXSr2Csb6?=
 =?us-ascii?Q?WxQKuio6WivkdCizua+Rq5eY87LpDietiLwms04CS7M/KzixrvK/XhjZ3Dd5?=
 =?us-ascii?Q?GOqEl8W9eNkUrHrwANBkel2H1TMjgO4qJolXDZGdYBQH5ui6Vzizy3RsTN9X?=
 =?us-ascii?Q?6Q0EIqOjZ/DZttXlb2NrkuepD5ViodHhWIo55dFIGaIo8UYy0rrjkcFq7inZ?=
 =?us-ascii?Q?oQawqA06wEgxuDQsxsbecm8BmbZWcjNtcbMtWCHLwh0rPDvCQUQ9EYXi2SuG?=
 =?us-ascii?Q?vw/YURGfbu/5wlZykWoPORynZtJzFUV4Xj+U+LgTmACKI4nsMGCr+ZDv0VD+?=
 =?us-ascii?Q?aSOtwpolUZ7yBoFvjxT7CC/COmBBQ0F9XN+ugM8B5vzoLVVK9daDpVCbsRUi?=
 =?us-ascii?Q?d9ESbG62426/TidGvB2KTIVjjcgR0FOiIjho/LIfwfIOogTDj9c8qLtH/WXa?=
 =?us-ascii?Q?CLVyH26SJ/R1APac8Zp63eB/tJVN+3I+cP84lRJbDEKuZDGfjBPK3g3ziSc+?=
 =?us-ascii?Q?+NtD8YDOYJZa/jBBKKc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:59:42.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59453017-8c09-45e9-b844-08de171d51f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653

This patch series introduces support for ethtool selftests, which helps
in finding the misconfiguration of HW. Makes use of network selftest
packet creation infrastructure.

Supports the following tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

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
  amd-xgbe: add ethtool phy selftest
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


