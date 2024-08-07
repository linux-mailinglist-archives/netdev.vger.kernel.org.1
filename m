Return-Path: <netdev+bounces-116545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B994ADB0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3044285399
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B213DBA5;
	Wed,  7 Aug 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LDEKxOUY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D113DB9B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046825; cv=fail; b=bg43cZlewxsyp57HrEAZNSxb3I1HHxBfbE/ZlLHu3Kd1zeUUcr+jwtYNkpexMlzKKH3ll6sBPmOt6vTu2ZJMZ3lEhSuL5+WP60Yi46ncaqAbhn0gDaVTYAhuGFfgs4lJFb3G7IeXQBz3jNIC4TRu8onK0caXq3CkcoQS4TTncQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046825; c=relaxed/simple;
	bh=UQ5W41yf8/jkSg+LjCkjSKtkdEPIgyABFPtrReG0xzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNYqRdwHh01xbyTZkD58tArTlf8vJhiNGIEUJLf7GJQ/x+tQKWO5v5f5wGVxA8L/uQ2qvt9exHYIK8mD6GgcIPq7G77xS4ogq96zuO+Zms/nkConbXMadKgfSn9O26lg9ixzFJ/Tvc2XCFs3ZmM25C8FY6G4bTKmbi03PjDJUsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LDEKxOUY; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW2zOF3uZ8iJOH6f0gqkt0NyI1/PqSudhPu6lEX7NdO7ulFwPNbfry+dxBim4k75WervU9/dIZ2ZCuQt6GfDpipxdVX9AyU4zRsvrLmgfaS2tseNa7KrSuRINFmpNLi/MO4HyOzFCqPF1xOsilwFlrXkbxle4+X8JFMYEh/9/smVGyCg1urtHFMM5LRrjNzXWXaK8b/gyunldD/mVK2gbxIKGdW/5uSobRqHgU8JLR2hldPQz7k1RO8xUD5FdoILZk9rL6PoYidDTDlcpXKfSGTOk+0MNwGvHAgp3UFVtYbdgh1OJ95e2t4W+nBu0lJGtd93IGTiL6pBGlgI1UfoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si2GVE5L4sDFa503WjVMDNXWYgirD6nNsHsEZEc46lI=;
 b=k/J3+bJ4WOO0mlYIbkIhGgZnrwOiCJQ7KdKWtQ8yCFr3UHbZEJtSrfTlD8GZVYq53u96McBmJ4uvuOBIWDrB4eXHjPnehkEEoTdZy47MMcUMyort9mF3dTAPvWZGXXQlGXwoaoJcUG2VNdffQ8qTyHxHOwXv6OgUX3HtXW80LJhZPt8ZLB2rxlc4koTYm54BpbMTV2zAhjOadoDjxlxVjipZqpp3ZCD4Jz0qnnbRzVM7lONwN9tT3x82PP9VI6WznUBNvji06sRvP+ofHNqVgNBSL3TyM6GfblZASFg+xPsxvoluWMNNH1+MH+EhRFXnWi6ZIHOqCGXv7b3+Cr0cuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si2GVE5L4sDFa503WjVMDNXWYgirD6nNsHsEZEc46lI=;
 b=LDEKxOUYPIjIDh4LjhG7mcg6YqosRZ8G30Vr1CLs37LM5SDeeuEvRA3UC4Tgmp5G12MK4LKmgQHNFEFrt7d2ZrqRatpNb2hY7ndTQD4959MP51N/N+v077Af7hKn7R5Rarz1oolbHeYkGvL2jsHqe/xF94u0k8tKNLVY/AOTTB4=
Received: from DM6PR14CA0059.namprd14.prod.outlook.com (2603:10b6:5:18f::36)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 16:06:56 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::12) by DM6PR14CA0059.outlook.office365.com
 (2603:10b6:5:18f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 16:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 16:06:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 11:06:54 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 11:06:54 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/2] net: ethtool: fix rxfh_max_context_id
Date: Wed, 7 Aug 2024 17:06:11 +0100
Message-ID: <cover.1723045898.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 895a0f73-c17b-47d7-92f7-08dcb6faf580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yX5yznIwwK60sBcKw+tURemxexkwOskopi7OwspRBQO80/1S7eDHjno5zwku?=
 =?us-ascii?Q?MBIWjqN5qYvUxePdW1eP5NFLM551QikPtTRsQhSoHxIUQgfOtZvZ9gr518qk?=
 =?us-ascii?Q?7ADnnkSqecrxa7rVWxYg3DaSoxVGhiVvhVPfS7kXqbxWk5rYPuoX8xRn4qtv?=
 =?us-ascii?Q?3dRLtUMNZSl49Lv4vmW0+ovnI0Gdyom3+jDtpXARPMkP3F6AlZ+9b0zAMLn8?=
 =?us-ascii?Q?aVAswZ+fCJ7dBhH0XfohR2bRxxItbvhX+V3zDCSsPEK+++fgNodEpEI+4qO+?=
 =?us-ascii?Q?jsokEixmXkR0PuwMRuroeFAGaWGaSeT0SB/8SyTMii6k53CUMQaiDK6moUyH?=
 =?us-ascii?Q?sGS8/gVd1cCR26tAamEiGds/AEa8ulYzXl8DZ5YTen4d5WyTVIz8fSO918dI?=
 =?us-ascii?Q?RU64jZsIMu6tUvVup0eZv7HhorMziHbewRA6416AaCB82gF8Dr71Lnew2GjQ?=
 =?us-ascii?Q?J809wpnLHC9GqbGlmQ03unhqoYfrInudKBcQzCyxVuu12+/rGGe7+8G6/inW?=
 =?us-ascii?Q?VWKvMBK5yZ86HYq2L18zYW3lFeYLawYPRrGkeWilVjNPga0nCMfWHvDK+Api?=
 =?us-ascii?Q?NbsztHLN1+918p2IJNvbOwzmVPCcL90SsPcl8FudWaENKtvYWw36sdftrq3Q?=
 =?us-ascii?Q?R70golFqT+4rfTzv1S+DyVbRM2eQhWlD8WGJgpFZUwH2Z2WrqEofCeLzDOLc?=
 =?us-ascii?Q?xhBy8tauOj9tNSCKEoh2tkCWBknLTGgPeWYinfqVwUIA1hLpuQT7aS0mMMCB?=
 =?us-ascii?Q?NwhnZTrR6mX71dLBsYIyxm7Zyze38fbVYt5MqkF7ixJEUVMA0GdFBM2tfMgs?=
 =?us-ascii?Q?7NPTWUFaZaeD+CUS0oRZNnE3DLW5qt7NE0RpAqEIfY7uzUL6H0mHwdOwNH7/?=
 =?us-ascii?Q?Tb2HCz+NtajsbzVEaMDakRVSIjK11z4Vq1OrIoIjVpyCSQoQy6YxMIvstCVL?=
 =?us-ascii?Q?q3SJKdeceTYtb3rnuBbw6UaTT+L8nu6waOs834FX4mUqENXivenbOwYq2aNk?=
 =?us-ascii?Q?Np0nziomstc73sBzy+W3NUR0VBNomTWsYl0HsdkN1pvi25qj94T3AMAI7big?=
 =?us-ascii?Q?zRYcVrGAxYdI6786oBISYpUXEbIzbRcOkYK0/sxwYWtW/egwqRM/X1VavlB6?=
 =?us-ascii?Q?qcl5MDM4jHdqqop+AgpyBEc9a62c3wR9l8v98S/LYBNnKhyC2Im2p7PKoyWG?=
 =?us-ascii?Q?cYALr/Fyf8V1RQADSa+eBg+uJaph+6Wy3WOlqGur09qKbvBT56xtuyNGs8pt?=
 =?us-ascii?Q?MStTJrFFUigvSXVYournxC3IKdnODYuxRH3BDmSI6P8kuLdHyJQAjIKpMMm3?=
 =?us-ascii?Q?MuYbVTOoabj0FU8GnaHTYwfa85c/AC91LNz53cxqOwPvDIT5mkx37C8Sz/2H?=
 =?us-ascii?Q?g0UVjwswMhcsUeQDj/aGPA7hyMT8IdWx4ymkzPUbYMVgETHGjvjPaCy7EhTk?=
 =?us-ascii?Q?wv9AhByKJoDOaP9dHraodVj6C7H1UZ/t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:06:55.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a0f73-c17b-47d7-92f7-08dcb6faf580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

From: Edward Cree <ecree.xilinx@gmail.com>

Changes in v2:
* Removed unnecessary limit==0 check, since this can never happen
* Renamed rxfh_max_context_id to rxfh_max_num_contexts
* Incremented bnxt's max to keep user-facing behaviour the same
* Added patch #2 to validate the max is sane

Patch #2 doesn't have a fixes tag because it's strictly supererogatory;
 idk if it should go to net-next instead.

Edward Cree (2):
  net: ethtool: fix off-by-one error in max RSS context IDs
  net: ethtool: check rxfh_max_num_contexts != 1 at register time

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 include/linux/ethtool.h                           | 10 +++++-----
 net/ethtool/common.c                              |  2 ++
 net/ethtool/ioctl.c                               |  5 +++--
 4 files changed, 11 insertions(+), 8 deletions(-)


