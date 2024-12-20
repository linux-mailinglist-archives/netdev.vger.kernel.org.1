Return-Path: <netdev+bounces-153619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E299F8DCC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA9D18896EB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC01A2545;
	Fri, 20 Dec 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JbbiFaiM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB467082B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682575; cv=fail; b=bMtoXkCGJTkOmDS1+pWk/zrOaO33GwrpB/eyF+N2eStzjbb+gtudHnHrpnA8wDzxdv3WAJh8R+8I+tRjxvOdjtIY32nfI7a/8LysnK0sizXYQ5pgoP3cR8+SG44J/EeDHAF2eOJXK8sOqUsoNJmjXcc0YhVNHf4D2C1NAOgR5mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682575; c=relaxed/simple;
	bh=ejc9f+dHuyKIq/cPHueTYPqk9+P1vTK6RKTkZYcG52o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDkNOjsozpXFh4kWNcTlK+Snn+SfWPFiRrDIu8WIhtJIz6E9fSzzg/8Zax58I0iBvdXTFJkESKuKB1GEwcMbU6nRYDduu5p8cLiQQcKbu3a3Td323l+VJvLtgZD1QnEW1W6dLQRaSd90a1N8BzF44Wkj24e8C0Log3mOOScG2F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JbbiFaiM; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcYTfJMDh/MDuyLIGgdY6n30VMqBugovbb+gq9r6q/chM66vdeUZLVv1am86eU5Ht+GZ6nE1Xwcmt5JDuEsrqdsEGELvLyNsnuh3NPr/IXC5hhvCS3WL6aNAxMFFF0Gd9IiJ3cH6AVnZGQiG8/Nkd9hA3PR14EvngxIV2rbpLgiyT5O1X/2cxF0V3BPlzuY3vht8wNYGWsiBFrrwPN7TA74sBeNMNqjfYAv8azwt+180hgJE8GOQyu5JxyBE7TMomIss4YEgCdZaGsfrJg2AK03fS9Tun4RSFg83Xo4mTvQytkWgDl6jUU5viItZFUhaTUn7J0U3942LFGqNiEnifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHiWL1kuWCfeXH/1LTB/G8gQuuBC1gDGO4Ti+kzT/Zs=;
 b=RtenmZoCivajiuAL/NXLgkTtM/f0BtdGB9cHRbUEf5OBfyclrFOaBzdwkHMnCTNbq+7svajXvyF9gTrPVy1JRJVU9S2DnHrgYNRZTGhmH0y8XTFbqKE5I5f9YSoppYXoKo+0Im/i7bhfg1anpDuPaflljV6k1DC2OGQTmMT2t4LpuKM5MjVGnZ0Kb7bIVmjfKKgrHhSGT3sQHBGZzcW6t+FwcURihVDycqgvCiKyawqTy/hw6EwEA1YppuaBBcJLRh326MRAWWtLutfdaQf4PQCXgdkdTLwSQLnPcW+MlWvFXnKAj6RbMAOE94/atdA1gZH70tlgrw/BsDttz70vEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHiWL1kuWCfeXH/1LTB/G8gQuuBC1gDGO4Ti+kzT/Zs=;
 b=JbbiFaiM7cmFxtDfFBfXdoGjDm2Q7ohYwqCZmbApVIlt2PQ3tAQkQY0VPCqGCeDNq6MocrLZLnkKVppWrLCDodiKWts3+U72HcDjB39k5Kld+eRepAa43+aSLV6xpkktUObYQml9259ZbCggUBTe3JNy6Bp5CHJ8e3HTAEdNvADsN8Ymd8qBXadOOS27tVzLOZG9YctAvlZ71sO1w8Bh3EiwulzbzIyult4fM+tGLVqLl/wgvkXWPrH7mNOER2U9LlHucZLL3HC8v/rYtA2baV/WQ/3Sa/JMBonX+Nn6TJkJYzSWqAg369M3POOgSZrkfdJrtHqGoPZ/NgSmKpIgpg==
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:16:03 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::49) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 08:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 08:16:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Dec
 2024 00:15:53 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Dec 2024 00:15:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Dec 2024 00:15:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/4] net/mlx5: DR, select MSIX vector 0 for completion queue creation
Date: Fri, 20 Dec 2024 10:15:02 +0200
Message-ID: <20241220081505.1286093-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241220081505.1286093-1-tariqt@nvidia.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cffd109-0d92-4297-5c84-08dd20ce8b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6Q9nkdh7OdNQvZp3IYolQ8xFLZZj6j/nfnq3HaQ9hH1qwrxv1FRD+G2kvHC?=
 =?us-ascii?Q?Ge1QvuWmbxk+eNi8ve7efh8rLhEH5WUBYHZiSquLCLsxkmkYR/WoSaS6keBR?=
 =?us-ascii?Q?lP7n80MMUSvba7BD2Xg9uS/dyg2VZ6V8LrkV+NVHlUZzIzhMwFHAs13fXYQp?=
 =?us-ascii?Q?cuedvL/cA/85c0D9C654Lh3i+6HRaO7QGm1mokk31QjNMzL43k27gp0dDGnG?=
 =?us-ascii?Q?89k7lZucp8ENMVYsN1/CtLD6cJTcpBdlfAY8vet/+iMP3dV3TPckP19FyquE?=
 =?us-ascii?Q?sN7wuoCdUP0pJynaWUiM0F6cz9Tv8LpdNlPDv+LXjUxlMBnzOv0ppdmXn0Xf?=
 =?us-ascii?Q?HXHMR2jXhvg20TIKI3X+CdSi0xoVH40uJow7HiRcpmSxMDLQyMle8+tMlKQk?=
 =?us-ascii?Q?ga30SxNsQmfaWl4c/zLuWnwrrFui8UWMW6TfA42fbavZFmsTmbpS+wbiQxbx?=
 =?us-ascii?Q?Jt+nrAN/qXUhTOIBZEOlEWqrdcw3gocICAhQJLqJLJ8ePh9IzHT9YjghwviL?=
 =?us-ascii?Q?wskhCnDld3VYvXNq7f5eXqWb9VMP6z1Np/OxioIkOLxypTX4eODksZLar1Js?=
 =?us-ascii?Q?0JvRqpbiaOgHiiCtgGcsQ+Bsi2yv5KO9Yge87kN4gnJ485HZVD3GaocScBaS?=
 =?us-ascii?Q?Ty9sXAzplPclzUCM4GHWjRQcEUaHRMNWphQWxsFU78K7h/SFVtEy4+quDhfw?=
 =?us-ascii?Q?nYO13yUxjs3DeCz+NDBEmuqrTvQkg9Yx77ZL5mmOXShP5EwWssxh8+HO/Orh?=
 =?us-ascii?Q?b83Ek276H4LSADk3rGPAAgWqmaFKQYtBS9lNhVjji9QRLsQwdcnAGRYB8MDN?=
 =?us-ascii?Q?EJ9LaqNVz96GLdm4MyYldbKljqvnRAiN/AXIGou1KQYW6R0I9hPEXFzEKRLV?=
 =?us-ascii?Q?izW9r/SXscq7lY2l1D0hUGy2wiy3OLu8a6USlwu5ZbhSiAbQwu6udr2X1+D/?=
 =?us-ascii?Q?d2taMuWaJgqaWMlF5hp0NZbygwXerOs8Eg9hGGFcPhOWzBwQGmsVrlYHdwNT?=
 =?us-ascii?Q?a95jHLSvMLH7DKFmC6a0MF3wvj+DOWTs6Kb9RwyEG/+iR3W7860CaaET3PYf?=
 =?us-ascii?Q?s/eLMHV670TJLsF9vVL13n93IsxjjFq1ksDYSBUtyeJQkcrSxhCciKLx6/iF?=
 =?us-ascii?Q?mkQrlsfWuULfRKZDe8kmHeBmiy3bPLJZbI14p2W0t+em/W6d9d16PIQ8pzcu?=
 =?us-ascii?Q?XRszZXPahAFkBENuICVqQ5jM8wa6Qc1AJqU++IKsbsozlpUGQO/NtEw1UlDF?=
 =?us-ascii?Q?bGqmaWxMHgl42u0235EIp3Fy23mgFM/wUdvxoyajCIYyV1HJnjVbY6pH4c1x?=
 =?us-ascii?Q?11TDPrFbQcHeALznQHNpze//rlXqWFn0Oat8ltmQuSlmlo3Ms2FMEY8pXBU8?=
 =?us-ascii?Q?RiZPtt9UlG+/0/5nuy+/YxlgYRGEz6J17UqeCPeU7+tORqKuii9rGL79bWu/?=
 =?us-ascii?Q?BbVbSK61xsRPVACW0UdFiImUQJSvDhMcry8RKFoykvnPGc5ZmpKC0ZUe/hp/?=
 =?us-ascii?Q?aMwIG+pKZI9aV/o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:16:02.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cffd109-0d92-4297-5c84-08dd20ce8b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

From: Shahar Shitrit <shshitrit@nvidia.com>

When creating a software steering completion queue (CQ), an arbitrary
MSIX vector n is selected. This results in the CQ sharing the same
Ethernet traffic channel n associated with the chosen vector. However,
the value of n is often unpredictable, which can introduce complications
for interrupt monitoring and verification tools.

Moreover, SW steering uses polling rather than event-driven interrupts.
Therefore, there is no need to select any MSIX vector other than the
existing vector 0 for CQ creation.

In light of these factors, and to enhance predictability, we modify the
code to consistently select MSIX vector 0 for CQ creation.

Fixes: 297cccebdc5a ("net/mlx5: DR, Expose an internal API to issue RDMA operations")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
index 6fa06ba2d346..f57c84e5128b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
@@ -1067,7 +1067,6 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 	int inlen, err, eqn;
 	void *cqc, *in;
 	__be64 *pas;
-	int vector;
 	u32 i;
 
 	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
@@ -1096,8 +1095,7 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
 	if (!in)
 		goto err_cqwq;
 
-	vector = raw_smp_processor_id() % mlx5_comp_vectors_max(mdev);
-	err = mlx5_comp_eqn_get(mdev, vector, &eqn);
+	err = mlx5_comp_eqn_get(mdev, 0, &eqn);
 	if (err) {
 		kvfree(in);
 		goto err_cqwq;
-- 
2.45.0


