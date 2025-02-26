Return-Path: <netdev+bounces-169768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F6A45A6A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF32188F0DA
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0C23814D;
	Wed, 26 Feb 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nojXmPUc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53513238140
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562785; cv=fail; b=sbXLYLqRWQ5PxKnNfToawqtikuS8qreLu82JKwf0BWKqsmbIYFwdnqxmi8l+PvmAIWifsaxfpO3yK6wAuOLCBFoOWkXcd3vqzjwlketry9cYD/NJ1JwHZzqGSPU0o6t0t2D+1UM5qly55epW9oYdFw7QqT8WeYi3zf5O091FvpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562785; c=relaxed/simple;
	bh=y5grZed00anT5fp/ikxLS6sb0USZGwPipvyo/9ZGPfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdjzSAr14V12WXIk6G/hjkS/xdbRMI0XklQABnKkYsj1kiqO8kTcyaE+Zp1MpxsgwCz9ACd+MxUvj2iYiV2Or4SJIl4DbJI1mA+qQPI+ANhexLs/Uleb4+PnwllNKCHQY+zcRkE67+e4IBIjCPNUIJyhbCJq9auiOlN5PoNrvMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nojXmPUc; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZWDxL2UabRgQs6SdsV1BFbxuWY/qMdbeuJx6VVaWKuKuY9SipEVKppHxq/TFBH3Bv70EkagE1y1WUawH4bY+achvlyQ94hruJTiZjGVAL0FnSbAq6PhAzRwI0Mr9rAA8+xr8XB5iRzoURzlz3bkyUYZyE3pcqTTcjpQC23oG/NT0LnNG2egU18uKvDq2PMrQG/hGd9ZN/8vNM5qdAU8fFTBjN6z/VGWSmNSkga4Ylsh4rJQVLcQoG5xMH1RbnfCsiKiKqqAyW9H/BeCtK4JSyzKXi4CrZBSjiwmRBGXIYz8sKoT+N4pRPxyPRKiPVI1QvYO6FJ8uv7jBUCjh8/r+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAz4DtHvUMMsiJM2n9ozP3t/c2d3M/1yQhv15i3YsFo=;
 b=SvV7OiCUl8vlqmIgJggQDNawFiwRjUJb+TbEd4CJf1nojB30Y2hreRLqDQLapXQAlcNQFSmXAH/mf8MuKC7DZcUceF8IhAJfWNGOcxAJRjkdkpskRTp1pmXP3uL85S+WH/ZnNy8SS9gtrfy8ctMhkgVrhnGJymXI78n1jC93m/wgWUzOwEaUbanYofObkvqMR/1bRubBXYYK8Z1d6zTlfOT4oSQQymHcNeEW43RohOmBLpTKAv9VWhw7/kKRLDsZ667f9d57sQTEaPIP/r3X2cDTcvcs/bymij/EoRnzXgzOsPfzollagErHkRmjs3tJYUSwxoiLQmkfeutfvzF75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAz4DtHvUMMsiJM2n9ozP3t/c2d3M/1yQhv15i3YsFo=;
 b=nojXmPUcX8XPb68x9fmSbqulnOHZRiEMD3NUuL3VeYs1BH6AF3487bBHv1S3+1HEWsuWIovEJuQiOtccWWO3R8o+lqZbOwJmqR6aLqVaOVvdN5ooSYYB/YtBqO3610p2feLgSLacsG6oqhCsIEQsTAp62TFp7Py1FHFOELrtqv97g5wD7eUT3QlB1pwuW0fR87zWqVKv2RBeCjRN9hlMbK3uD4nTVzYlkx8a9X2rHqhILhydbJfUCaZ7G7LL2WfpkHtEO/cZNUbM1luqvlabTcU32YhgGMILu84+fyoVcIbSSZIEQC3WQA3+rDYFCffV0E15xzT236GBy3T9VUKUsg==
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 09:39:39 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b5) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 09:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:39:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:30 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:30 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:26 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 4/5] net: sched: Remove newline at the end of a netlink error message
Date: Wed, 26 Feb 2025 11:39:03 +0200
Message-ID: <20250226093904.6632-5-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
References: <20250226093904.6632-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c8975d-c298-40ae-ad88-08dd56497d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjijYUGJLR86SVx+4tPQjGkac0RUhC8WlwCYswuaTEwP4DXILoonHvf3i0sO?=
 =?us-ascii?Q?gRmh3lHuf3WNdFZdHmkOdor3fgz9dxar7Ck6ZSdZNTiUL27rZshuFGd9yJXG?=
 =?us-ascii?Q?CJ5aLWqwjsZBOgYpexW9gW/7Rdee+FPxesaA4aNQ/ZRMJndID3ekJtIU+Efg?=
 =?us-ascii?Q?3VlL+8Xcl9ljw1Br692SmAiUBXDrV04FJdAg6t6vbVKl7UVD1SXvL83p9luJ?=
 =?us-ascii?Q?zTJwC/c2LS/855XHEbsX4VL+cZDscza+He6tefGo3fsoLk/zn3aGDE63R9Ns?=
 =?us-ascii?Q?o5WqlUjp9Aw6zQ7gDh8SgZ4cw5waGnAYehPdUuHV6ZqgJgwAGqNxT++drDIn?=
 =?us-ascii?Q?eUY2QcNklMN13nbYq/WFjcJLX2qzRGCl4T1+QToxpb16a8S5a/saZJCS1Mef?=
 =?us-ascii?Q?QIyGSMrivNt1ApRbM55WSY3J6BSnKdxtLwTglGgUN8D4tbUzZNE/ir0jDglW?=
 =?us-ascii?Q?QTPdCqFeUg0PppwUeLuvr4FsPevfNNkrqBBw+sR7iSbrmaiLYJNAuigNdNoo?=
 =?us-ascii?Q?5fyIUV5IUZNZ5SyNlIT5wqrCTzl64zVXfvFNjzFlJOS9nYn83bL7R3R6wMMg?=
 =?us-ascii?Q?OmrJslhLAp385aSRItxEeN0C/BY25WQNe2hNSTHaC6y3YUvC7ree29YaVYB2?=
 =?us-ascii?Q?Fxr92mC10wkWd7kWSmJ84rGWd8rt8uTiGgYWNBfHgviUdg+1cRFryc0ja7bs?=
 =?us-ascii?Q?r9l5Lr5g858gA7PwjpctkTXlVo76m5j1bqDT/oneD8Plejfkzre7dsM7I30G?=
 =?us-ascii?Q?DVBIODH+LIKDP9UGM/Sm996sDAVig3/jTGcU/iCsAESBOYNNctCfWyRV0mw8?=
 =?us-ascii?Q?Hp20gqhdyeAaQEMmNcRQPkJHdiW5WpZAZpHH9YGSk15GmxCTebCRU6J3M+zj?=
 =?us-ascii?Q?liqaxRavb8cy650pZPcaXDX+b5H7NrD/A5eBldKRTuhblTE2ulDs/fV07eMt?=
 =?us-ascii?Q?MM/KKNO9tkNGRgFT1KY2IW9HVU+LdDbBa2WTJ+KFJTMB7ZiYiZRrq6Ts/i89?=
 =?us-ascii?Q?uGQZC3IBefusGuF/ezR7hNOufZaFJyaGxfGyT6hEmqcZf1Z4FO9StMp3vRy+?=
 =?us-ascii?Q?tkanLASSGfQsVQ00arWODuV2GeqY9I73iyUwn4k4M5h8KyKnCQS7bJZgEdH+?=
 =?us-ascii?Q?Fwts3dbmrQR2fKmPqkbvJxcdDBmTqQIHVXwEx7Rz2zHoWmoMsnwxs9GUj+SD?=
 =?us-ascii?Q?IMtZKk1F4BBKzQN833321wqcbwk9ctbvoGPWtmPXizYtlQ/08VANX2cpPo9q?=
 =?us-ascii?Q?GaFFfszt3Fm53RQmaGG7/FNYWg6jVnMOv1Z5XvAL1JoauoXHs6QgmOhGgEP6?=
 =?us-ascii?Q?aEi7NLJaf5Pc8b3Ps/p2hqoScN1wxUhQECltQwSkCVaKD8gUxtYZy3abk8wK?=
 =?us-ascii?Q?tujinqXMcY6qhbGl2GCqsj+sl9AuoHagzyQHqLqXHsujmTC0Fse+LwmsvgUM?=
 =?us-ascii?Q?m11hSbAhO0db2JpFBwGbWgL0s96yeV5ZGnPqvpNA9baCkT//F5bm8IqnYP9r?=
 =?us-ascii?Q?AS9WGqxlDuvMato=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:39.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c8975d-c298-40ae-ad88-08dd56497d7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474

Netlink error messages should not have a newline at the end of the
string.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6a07cdbdb9e1..2cfbc977fe6d 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -447,7 +447,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (q->wsum + delta_w > QFQ_MAX_WSUM) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "total weight out of range (%d + %u)\n",
+				       "total weight out of range (%d + %u)",
 				       delta_w, q->wsum);
 		return -EINVAL;
 	}
-- 
2.40.1


