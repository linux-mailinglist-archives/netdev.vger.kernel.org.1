Return-Path: <netdev+bounces-120482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75761959864
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B681C20A3A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6141C2DB1;
	Wed, 21 Aug 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVxTUY61"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37B1E201E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231141; cv=fail; b=OjPdEfzMnXxZn7hFLeOS7Yo7ht1jimKbU7AJznFkR3Hg1UwNqZYv8KfWkeOA62129S6UnbANDXqVmueSc349eEOpRsbJBPMLq7ADTacUvTs4FTcVcvQS0iA711FG+5u81jxDdQjuUL/bFt04ZSe6Gd8dPjGy1j+pcurjmJJKyoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231141; c=relaxed/simple;
	bh=a+qWu9+MiENTGb8gkLT6CX9WvOvPzzIr0qrYJjVOMK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nL8vq9/SGcpmusc0GvjtUY5GxtG2RuGo8o6bKf7Xt+x6zF4bCzaPbZHhnxe8hJoc94FM8P7tEWlvCR314FxwYFDZEZSeBAA7UoKSo8bGTlo3l2D+xTWMxkN4zdccoB1ka5MzUKYKbFX5pSxKH59zqgFopICuUApE8jZFGW5r1Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qVxTUY61; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjtLrYkYJMz6D/xfbMp/xXT9mTXlQ1p5KKjJU1gHx0tK0XD3ZQ6LHx1MnmYsclvuDS5Uwwa1MLtoIYWLrWibjTMKGTjns1m7fBvef5Edl4rp+rhj34+vo49twsj+ZlDst1r3rMaFvrMFtlZgewX24XKRXZ6iIz3OPzQyezWMv//h5HaslbimYHlGxBABlUzGwaZraIY+DyYH/TCb+4s2k+dmhQ4a2VJNWl2BW/7AMMEtB7Lw+TiTWx1kWS3FLFrPVO7191go4W6AbA7ZFWZly+oh6MmhSqt+/5wkNiWI5Szve68BJjlpouG+7KgTJeVczDQwDPJSrSQiePYI3d/FBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bi3I1vaaB00e0gGOmn624j6zprtsmsg1zU69fhGLEw=;
 b=DEFBbuDBEinWjQuqsglcM00LmzcApyMW2izvHSCRRlUDNlBLFG/nihrjeiBahsF4Z28ZWGi8jF3V7XuoV6d3wOH2t5FiAfJ6nv70/VjNb67T8imzbcJcFLYFqCmE/qoWUg1vyvKmIAp7pbBIwBggBRcqwzsLHjFRMCZXgdtSJMZVtENhxE8WAf7139D7/6UbSuwpFJJC1WJfkwgQpfq3KbZtF1yF5MqQX5xIN/t5V1V84klnJK2yHhm7HPDWuRQ/UqBnT5yIHwhCoTSY5aWU++aHEpQy+GD2D54V8vjeh0bOJ4Bw4goqUTX1FLuC5F6qXL1NZkYpFdpqIRgPv+wwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bi3I1vaaB00e0gGOmn624j6zprtsmsg1zU69fhGLEw=;
 b=qVxTUY61stu3VxykhQub/6JiSEW7ZdvL6W99l/yTHYQ5XT4xH2psXxfLSetCWI82GMmnhCK2uK1ejoTr2ZRFmh63yZMLaJynWD67gvGE1LR+tqF5aJXArev8sZsEiHsXUaTNilOR4VVW+KBXpmiX1Xf3bMOBZychehaeUoi28HTusOceuwhfKwIqg/b63I1ip1XXAXcQn1nDNoqQNVJVkkia/rS8bmp15KooMoBFrAXzOs92pLGYTrSAWBT7BNdHF3rllfqmSUykguHJgHpCiBnzDybAdI0Zdn5NZi+KJT2cpj5pqWlgABy0AZ99EGMpB6G9oop43BP03Nv4vx18CQ==
Received: from SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::11)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:05:35 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::9b) by SA1P222CA0059.outlook.office365.com
 (2603:10b6:806:2c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 09:05:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:18 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 Aug 2024 02:05:15 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V5 0/3] Fixes for IPsec over bonding
Date: Wed, 21 Aug 2024 12:04:55 +0300
Message-ID: <20240821090458.10813-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fe4a14-fc83-4bbf-fc30-08dcc1c06b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdQib197XAXU1va0bddVTR/Fs5Ja2S0lqn2KNENcM7MXKKn+UT0eZg8CmZFH?=
 =?us-ascii?Q?vy1bElps9hpt8suu9EszqEsvo1Zjz0BYciKc6TyCma2QyhS4AorMbC4Wzz2D?=
 =?us-ascii?Q?KjM+CQm8eGS/gd+LiOtcXccDf4mWFZNrjf0hLDZ6x9btGc4I30AVttx++Hws?=
 =?us-ascii?Q?an5nGEQQSHLYsaKHfEJqYP77Uu9bRBBIvaZfJc1Aqzzlvl+8MYcHoU9UIbdt?=
 =?us-ascii?Q?kggcqs965PamRSuuKkG9QaD+vhodZ9hPUo46KclezBBGWmJJ29dGUFMxROqD?=
 =?us-ascii?Q?Ay/9B3/CSH/yYz/8FrdZBwgDYXjIbm1RlS14JGv0kcJ9Qsu2x2EWyAEvD3z/?=
 =?us-ascii?Q?5CCLJVPa4V2mzYiR1Qs9IGhhJL2sdHCJL/7754Kv3aQeZD0PNNeTRjsYwyC3?=
 =?us-ascii?Q?dP2J/9+thSZ385r4c858HllXs5UQA31Nldwnz8ArgjTCDXNuDyjKV091jSh0?=
 =?us-ascii?Q?6Nsg1b5dQOpXt7isbrTYvczKikGSTDSSIyaSuX9eJdErmNMG6Ts5qJqm8gca?=
 =?us-ascii?Q?gsdK3A4zZGXUwFy83zTuW+tJF5aopXPyGTCIQq6VSaMlSFwvfAe8Gr2rz3Rp?=
 =?us-ascii?Q?HiOEwshKki5cPVidi125OxS715WxYa8EWFEc1Wc26DaXLoPNigmkXpJXc1Rw?=
 =?us-ascii?Q?dGBK+RD2FdLa8U94Yn3T2D/tJB0PvYdJAI9MEJ5HKNO8SSzkkRWhIf0JWFRH?=
 =?us-ascii?Q?6dOalf2l2IhSh7T+6sOBoCJbTcNlkFRS38s3mQu9whxTFrQDQO+ebPzW5m7W?=
 =?us-ascii?Q?tPbFDkNbOcdwkaJAnCbkvQuGCEwG5J+pb4wvRg2fvl/gFb9sa/besq5wSnXW?=
 =?us-ascii?Q?hEkN3k8BrNcaw6Iv+z/rX5A1x2NA0uMjuhfic4AUzH5bz0KGMvtQFoI/frAR?=
 =?us-ascii?Q?OC4A+r3RstoTSjGdxo5wZQRXRHL4NuxjWItC7JWzRyXQBivCsE2V1HTUsdFo?=
 =?us-ascii?Q?pFOfodgy07p/SlKFoSLOSKize2TTTI5xVboqmfSZyUxssAAO/fUOliVM42tg?=
 =?us-ascii?Q?xBBzw2eI/3CguGNOATd8MTk4ICOddgKonHngPX/wOxFFSPtdI0ysbHj8pPAG?=
 =?us-ascii?Q?OWzX1ALctF0Xbry/X+Mb0tGEhM47qYkjZZpp+RhVAdhk07qx6ZrtfuxIFqZq?=
 =?us-ascii?Q?zQC5efXdfdptP66/X1XCHd0RRVSbV8loRabzraO7IDg5X/T8thRD29SSqR01?=
 =?us-ascii?Q?Flxy2kwf9j36q0jfi7rER/d6cY8kkaFqOvlq6vHT3rDJA7e3t03sEgoSzmxP?=
 =?us-ascii?Q?x6OLtBU1tRb5wRNLAk+1aTBDNsMTRtojfpyDEGjqaPEfLIzDyqIbrQPLW6up?=
 =?us-ascii?Q?1HwBXeKjYkZwVozRQ0c/3R2sO2mjpD7RKQIz+qcJnmYHuaDlDVwVYUg/pONA?=
 =?us-ascii?Q?N7LF+hid975csaVZvG0q+59Dfmzaa1vT8df4Y0tWPR2xZmu/11Z3jx0i7tRz?=
 =?us-ascii?Q?c7HbDkjHT/nk/JxBBp6BbRJgolQft1yV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:05:35.5770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fe4a14-fc83-4bbf-fc30-08dcc1c06b44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

Hi,

This patchset provides bug fixes for IPsec over bonding driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit c07ff8592d57 ("netem: fix return value if duplicate enqueue fails")

Thanks!
Jianbo

V5:
- Rebased.
- Removed state deletion/free in bond_ipsec_add_sa_all() added before,
  as real_dev is not set to NULL in Nikolay's patch. 

V4:
- Add to all patches: Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>.
- Update commit message in patch 1 (Jakub).

V3:
- Add RCU read lock/unlock for bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.

V2:
- Rebased on top of latest net branch.
- Squashed patch #2 into #1 per Hangbin comment.
- Addressed Hangbin's comments.
- Patch #3 (was #4): Addressed comments by Paolo.

Jianbo Liu (3):
  bonding: implement xdo_dev_state_free and call it after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 143 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +-
 2 files changed, 90 insertions(+), 55 deletions(-)

-- 
2.21.0


