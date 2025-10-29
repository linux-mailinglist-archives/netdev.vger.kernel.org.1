Return-Path: <netdev+bounces-233854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639DC19481
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D5507C84
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD73168E0;
	Wed, 29 Oct 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEhP3UX1"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404672F7AB7;
	Wed, 29 Oct 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727179; cv=fail; b=l6iINc9icG1nQNv0bNhvucqz3TdejNIBjEFa55wep+JcqHFWGlViN9lz8LyRMSyFbGKyOBOh1A7NVV31plSn00RiPQ2F/5T+vu7A7+p9lPrbF1B+3A93xw7Fbo4nw4aDPmOwYJCPga885141oFUNHmHmTsUlwgujuP0ICNL/wFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727179; c=relaxed/simple;
	bh=iGCVZXXXFeLGHulxSM6sN0lZdwpJ0opvA1G5DaM/f54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCpEZSm8b4QUpUFYpL+5TcAYqWbvkxq16uWH9jeuWGo/dGpDIkJMibm8SJ/9SczUcLgnP/X5I/Sdqh00hdUEO3wp33rnxhSS6u4M2CevUN+Z1qOW+n5+5ybdfKVFnPau6j6cuKI0PkoBS+AIzO09WtEo4tMnUKaj49mrgmFJJ30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEhP3UX1; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5ia51ghbJcnxjsWTvp/zwYWOWbodflK47bm8K4YDEW+Xn2VWrynqj3ddpayM5bm3hs8TaeRZuQHwKtm0+fZ+M2Pq9FqVi375/AdQ0dbHDOj43itMrq2KLGwk+j2PUGI2ZH1KHoYP9ZGqGISUYFTow39HQTeiT3hqZ8JIoH4LeUniF8hpMOWGOvQ4H392/ndUqs+6Mv8+vKAKm52lZShLyq3Hrb9EERfl3UTYEuJXjS2bIEN5NYDBJ1eT6qEz2UL5VmZCrWXK6OzFOMNUVhGo5DpUOqppWPFRddAV1zGAEdfgGWAM4hPzYdXTcR3OfcPLAz4I3YmSxFWUB+r5JnleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxdK9ug7balWwtSHP+Z5RiOXhP+S3xPFSRelsjHYFS0=;
 b=DIx2eEV1Znbt5zG8skteuVM7wwrvqRe7HjSk9fLQh2uhlg5RNHJ9+zh9u30B4TfOU6s1yJGJSEXpctihIIWbxYIWKzLvT6Mj+hXz7UNmK23/xm+hBim3HTehoFhmbOLiDPE6QbPC/il7SzD/KcxtX0apt4Tzsl24z4p0q5JtTJtIG33O9sp4lNXc0sfLtfxfgk5nMpRJ7+9ohwityCll7P4qeeTLbHOjw+gSwgYDmhQ5xhWCHtdIdztcjGZR9S0GDuQfpwLbVX2GNn1dqdJQeI0tUNbTi1DdiqnhRXYDao8SmRirvf8svL9DHVlq8ZFZ7kAB1/HxGqNSkkC3BGZUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxdK9ug7balWwtSHP+Z5RiOXhP+S3xPFSRelsjHYFS0=;
 b=JEhP3UX1+g/r0CGlptyx1OhDE8sZi1pdO3//fNxZH9900zUYRoD2nUo7ZAlNsS2Whnv2/x4I5z/e/7qkQKijyrjLEXNT4aLGPJW3DsST40BvC0ow7FS0mAut+hqEMkM8AIjmSZmz73cUp4nTEaANYksXRYOhN7Hp0vq1gIKHWJDeuG/rvU+HJa10jZL34vUKfSecli9zGmbg472XrwGLV/pvCNU8TbxXKZMTMMZsoG70lNxN0nE4jGPngMHmBULQtMerhV/waP1YR/qCeYHW6rbvTM/WsMYuWByO3DyMfa9giL6fcIlm4T01UE1fh81GKnWfHvz3YOQtn11h9cDitQ==
Received: from MW4PR03CA0343.namprd03.prod.outlook.com (2603:10b6:303:dc::18)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:39:33 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::7c) by MW4PR03CA0343.outlook.office365.com
 (2603:10b6:303:dc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 08:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:39:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 01:39:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 01:39:19 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 01:39:16 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net] ptp: Allow exposing cycles only for clocks with free-running counter
Date: Wed, 29 Oct 2025 10:38:13 +0200
Message-ID: <20251029083813.2276997-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2d31f2-b7cd-4adb-12d6-08de16c6af54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VGqTNvhgAqbOdNW157o3ybllwbn+P+ICMzAE9cv0axAAwMVembVs6WEY0cBI?=
 =?us-ascii?Q?YPEa8Kh5tCAJPYnwbml87FTyr/xAwkyF9i6o5Aokkp6m4HDyfryqcDfuLTtd?=
 =?us-ascii?Q?WmhniajwjnMP2yKKvNLjLNNC5oeiBgTOflNmku8ANYU7wYnLMgItdSqqSI0K?=
 =?us-ascii?Q?6B7X49/1m3x4KULHkT1/7H6jIwVgG3CsFsW0NxILg8RQUxy1aSybEQ8drHI3?=
 =?us-ascii?Q?hA77kSyeyJziSC9PNK1T2lKf6YrKTpbAEli+J42KFpXFIKnLdoolhobOXNxF?=
 =?us-ascii?Q?uw73FvCVXplP5lNKjYEZxfSD38tj640zhPHRghN55pWG6d69bEoAIOYVhlN3?=
 =?us-ascii?Q?e2nPJayEsO9GqJauNxVBVvNpVEdlLxpI2T0mqUICNH9mAAwiiBqrDZI8hsHt?=
 =?us-ascii?Q?zdt+ljIdvKREw7yy8UzydMmHlHVME0B3T2jMLOmyZ9P3N3N1s/HrhehEMult?=
 =?us-ascii?Q?WEOFsSYS+cSqq2uMw8/MCTT0v0tnXksH3R+9dle//ibKhLwHDfVXzy+sg22q?=
 =?us-ascii?Q?yqwbzvUfqCEeqpzYySta1ci/Dn27G9lj3duTsQWbGDTBMs1yPPBDm7mw7yMa?=
 =?us-ascii?Q?sXGib5NDyB6YZDWr1eRJKxJBaGLspPQrdWPSEPvnJDY5dQR+h7l2z1Uo+S6y?=
 =?us-ascii?Q?OALbAPwDcTvQ0voYaCnXSVSCQocg9WWxTlL1NsX6aerofOx2tc6NYIZw8kcp?=
 =?us-ascii?Q?NRKEnKBffnLG2Kn5r2j5r/m3innIyIj+TZRaK3RsjLntnQbIlK+0LXjrV9Mk?=
 =?us-ascii?Q?4mpi+EhibGqb+7mc3LTfpKS0EfRfpPhVL+XCcGW9z9lKdSlMiTpMsmeItwgM?=
 =?us-ascii?Q?KMO/jglNUtRD8hNgnknWHJj/Odth0GcwSsSsiV9oLEvKPizBs5eZ2uDoKaBo?=
 =?us-ascii?Q?av+Sx/IdwRVcMCDvzs2nogNHBLc72qJw/7biFsfXazEojNYQGhQrQ1Vu96Fg?=
 =?us-ascii?Q?eEdVGnFmKNj2bHGoY0pIfnfqKh7Nk6Vqp3OPtjCU5xqb6yshBwfZ0/TVtMbe?=
 =?us-ascii?Q?T/ujpaUKgSFpja0Nie0tm4R6/YE7oExVnQhXvqNy1l+towkICTb2zXiLWH3M?=
 =?us-ascii?Q?HR9tkeyLTpZgKEffQMDZN3GXukXyVy2A+ddUMZvfzJ86RWQELjpAWmYW/7Li?=
 =?us-ascii?Q?12ERDnzSMTfHU/O1WMb5D8N9ByoX8gsLSrMH1EMh7WGC8EnddPXa/F/t8Fho?=
 =?us-ascii?Q?AqNe+hyJH2m5AmnFqhpUGKp9IQbivcmQYEw3MGDbidQgQT5F5de4Nc6S55vV?=
 =?us-ascii?Q?jxO1vzvInpWmc0cE2t1bum0cL4yP7eL/UZBC30fn/Udy19CVpR2CisgtU1bU?=
 =?us-ascii?Q?JC6X8w3H3wYsKYGffmrJMyPnBhZyDnZAiRA+A9EHrxtngPh8+po8Zea5OeVq?=
 =?us-ascii?Q?tk+65D0Etb/wlY6SK6qyKYqib41Ix+nDB1ijAab+iKMNHYtPl26YHk2IYs4P?=
 =?us-ascii?Q?aKZ7+Wg6ytkWaOp+u0QlXyewqYeWiJ6PGd6ncrkSmOlXalAJHHuHXt1ojStC?=
 =?us-ascii?Q?78HWf0pZjG05TngV6YmF3Q0QKlYw7vYo3qsG5mCdgJWNtzksPSDRdHQUzw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:39:33.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2d31f2-b7cd-4adb-12d6-08de16c6af54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454

The PTP core falls back to gettimex64 and getcrosststamp when
getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
ioctls to retrieve PHC real time instead of free-running cycles.

Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
free-running counter support since the result would represent PHC real
time and system time rather than cycles and system time.

Fixes: faf23f54d366 ("ptp: Add ioctl commands to expose raw cycle counter values")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/ptp/ptp_chardev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 8106eb617c8c..c61cf9edac48 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -561,10 +561,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
 
 	case PTP_SYS_OFFSET_PRECISE_CYCLES:
+		if (!ptp->has_cycles)
+			return -EOPNOTSUPP;
 		return ptp_sys_offset_precise(ptp, argptr,
 					      ptp->info->getcrosscycles);
 
 	case PTP_SYS_OFFSET_EXTENDED_CYCLES:
+		if (!ptp->has_cycles)
+			return -EOPNOTSUPP;
 		return ptp_sys_offset_extended(ptp, argptr,
 					       ptp->info->getcyclesx64);
 	default:
-- 
2.38.1


