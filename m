Return-Path: <netdev+bounces-97627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9B8CC72B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB67281B1B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732011474D2;
	Wed, 22 May 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ojm2ojwT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EE1474CB
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406101; cv=fail; b=Jz+0/0GoaIcb2rVm8s0f7NLZuZvpimq0VFdoYLzOCQ0f6x72Gm4/rAPsHQ/O38wBYHCnVDIkjBZBr6Q9zJUTSkxkm67ZcXhRrI/Py6ky21Vl3Ld3wHb9EK+7Dhhn1rPudP6EJ2zmK/kzvdY40W5bjpaLbRAb4EKwFHetJ1TUj4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406101; c=relaxed/simple;
	bh=BoOy896beE/lnr5yAMZZfpK6lmmgJVimMXwUl2dwg0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH7tTEEXrT75E/5wwXrwChzTv/rjrxjwvAoiEBxgzRAcqvULNGorDtx1Hjtx65O63YXoo5paJjUbvHdTAkXyGOAIT6qG2VeICtQESI2tFHUm/RnZfuuqd63+QO7gU77ga3JkOgEt3tj+oXQkwJaM7kjifYsmSyp/1HjFtoASdow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ojm2ojwT; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0iaD/5EUvuig6zTnVkqqhob82GBABGyJ5lD9RQ6biItmRFrvIiDiT2vOP483eFcFN4RmaZEdrFp98Z7BBE/qBRR6ps0dbbHv6pEcDAgmwYQW/ECJxKrqrywn6ePFuk+ZSNPDxHdEnyUZe2dP/xOdI10Hooqf65YudC3NtB7kElrs3zxltul3iKdfAicCBtvn1JpRZfCTR6ekd/oJpHNbG3QqUU5FoEHv8Ns5lBDM4pjlQf8Rcmg5nkLjsgYNSd51QP7jXWZdcmZhYJFp/2rTYPfCCyrZrt/poA8kUfc8W557fnVFxtDWoCcor0WZR9lWaj5ND2ljmzAKa1xURjZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf0TBNUz/+8Fqha18C+a9f9OfG4wX6S4VP+AJVBP4rk=;
 b=S2DFZSQqvGd38IyK40WCiOiDf4L7b5K1SVHps0vf0aIyVnsZ/PNzvXC6882cKhyGkJtYk+Fv5Xc4r4mjXGd6dLxDfYSSQtjy7pcBH16m6TSP/Bb2qRB8VBXZT5VMOhs6EF3337DWtdnNADOs5WKMTnAgEtEOUaZA1D3jVBL/1xHXo7+kjEpCK1VeBDOOC5bQR7am39M5HwdhLa5lfRCcc+zBkWdEAATdOPxXEOgtdyYwqmMQs8rJiru6buf3pC5WKa4xNrc0TkpBAdms1I7hzr+fl93LE5PakLBglbCDeBzkkpdvYszU6B52bTctjSxYkgAy0VnAW+cA21Of6OFkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf0TBNUz/+8Fqha18C+a9f9OfG4wX6S4VP+AJVBP4rk=;
 b=Ojm2ojwTH53HpJcTPVJRpjJjJrSB88qUznTLiBvRCWSXRVAaDFFFr0RFxK8ae8w4SqryveBgGBR5Z1QXk8J4i0oNiADpRNGBtE4H9hU7C3fR8i5QhxwWPJpT7G1pMyl+/5adh+WbQlBADSpXL89rFB4r5+/L6yXqUp/XMU/3Gih7T+iU9RsmNFdQWtyIz2rKt4UTkt3AzMOSm8x4TvagcP39HcBmwKkqe0aR2AlaQ6BrrGkREc9msmryY5UlnHNShycajxt7i+DK286+VcjT1FVkCWGstQNgTc34uBUyYc2WV7AVOTqqPMv20ql4n/DDYLA9Kzdg5JOX8d5oqckwBQ==
Received: from SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:28:16 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::65) by SA9PR13CA0028.outlook.office365.com
 (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 19:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:27:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 3/8] net/mlx5: Fix MTMP register capability offset in MCAM register
Date: Wed, 22 May 2024 22:26:54 +0300
Message-ID: <20240522192659.840796-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2398008b-651c-44e7-7089-08dc7a955483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDMNd5t1ss7WO4ulg+8v+hW5l2OQYTz2O1dwac7VXhl4VvO1idfvvq0HyYZW?=
 =?us-ascii?Q?uX5E/h9ckQEsI9kNofAD7LqjHyY/EJOyMiyn1dxIjqS9nWzvlTlkJqr1SDKD?=
 =?us-ascii?Q?eCw8anPHfAJSxHPlebP8kiVttoKGkZBRM6XmxQbXsG8zoUIa789DGj4vezPc?=
 =?us-ascii?Q?EV93QZJhyVBMDUQZQE1xz2KDYrHqY4N/fRSXytMGInWCm49dlKItoC5tqIpN?=
 =?us-ascii?Q?Zw+m0C+HfGuXUGX4MIokYPttE1MIKDo3DsJ9nprc57hW0JJnzCeXLhgj5n8y?=
 =?us-ascii?Q?JdGg2msRpg3RQ1ExBgyktNhjF2Dj5UWrXfwV8HWhjIC9zG8vU4DXq2sL7DK4?=
 =?us-ascii?Q?gro/XRFa2ch79pY1wJl/EyDo8i9OiUIFnQv0AYfbCFYajMyZLvasze+ABBQ/?=
 =?us-ascii?Q?5YjjOxh8/hy5athyk2uCPWwE1XDxSk54fsgY1SCzYO1l1kN7mFwHZESduS44?=
 =?us-ascii?Q?U4ly8G9hrPN7tJluCsqWSzB+kmpxOstoEtetd0SUJRSm4GDB6YNpoCbRt0vo?=
 =?us-ascii?Q?DqtR8rONv/QqnB44rI/rpgcWzCI3arnBlSdsUnC4BpYiyp/5HaZwf90BhxDm?=
 =?us-ascii?Q?RQVg6PeHnGCG/Si8FP7mLtwOLSo2NabAfEonsCGmB4VyAMOjWH5NcfEytZpi?=
 =?us-ascii?Q?LQn2whDTbSxhqPth8bzmaoaH663YQH1jENKL59IJdHbIKgVKCPDsVxk3RISb?=
 =?us-ascii?Q?7kkLo6WxGQj4RkwM0vRgqdTG+MM1Yh6lpJJRqGEZlWwzeSaWUuRGEXAnNxkf?=
 =?us-ascii?Q?gque3c2sAJYLbBMGsaZCnt1j1tEXbD9i0++U3Rlgs5u+clUNDk/3kHmPzw2o?=
 =?us-ascii?Q?PN6q8cbvgNPlVh7bCzyvuAllW67q8qjmu+JGO/Pmm8fGGP/QQPqMiMXpnWY0?=
 =?us-ascii?Q?P09ZcL94wqiJ/6PX2ItUCxCYCm9k+kkzUWGNseVoVyJ+XMtHxpiWmxt04fkY?=
 =?us-ascii?Q?OhSOsQbNvJqs42V+Cwv2Pnq5SCzhOUMJVtiFCdtdgpY0l451ndw14HILEyTB?=
 =?us-ascii?Q?prYD1JptDge3Rgw4s0HrmT+OdMeTrbcrhvs7iI7GI5adgUtS/HdB1ONuHihf?=
 =?us-ascii?Q?d+aMwZTQS1fvZBD7TVZtlji+a5voygQfKKIHOcobzO8ek5HRhEBpSN2OgRQE?=
 =?us-ascii?Q?GLSzRlw0+ALDbQ+LxoNf8SUPrv4/2RwddWUrWTvxvCob9Xug3VLKX8ButAD7?=
 =?us-ascii?Q?rtKoNSFEnO3SmFsvFyaOeHrdhB4S9fqiPcjfxo51I/UTIv4bfi3qKiGQ0lHG?=
 =?us-ascii?Q?vFqdq0irrgIbAJUTRw63baFiAVV9AiYH8trUxqE2wIMshba5tlGL3WmsNLOe?=
 =?us-ascii?Q?X4WIDkMEg2YLqnHNiRi2bwoNRx7aaL88jK4TsVIJV6KCs+AcpXa8MxAhwDT1?=
 =?us-ascii?Q?RJzb+ctoX0Iuzq3jk4AlASVGe/GR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:16.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2398008b-651c-44e7-7089-08dc7a955483
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

From: Gal Pressman <gal@nvidia.com>

The MTMP register (0x900a) capability offset is off-by-one, move it to
the right place.

Fixes: 1f507e80c700 ("net/mlx5: Expose NIC temperature via hardware monitoring kernel API")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f468763478ae..5df52e15f7d6 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10308,9 +10308,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 	u8         mfrl[0x1];
 	u8         regs_39_to_32[0x8];
 
-	u8         regs_31_to_10[0x16];
+	u8         regs_31_to_11[0x15];
 	u8         mtmp[0x1];
-	u8         regs_8_to_0[0x9];
+	u8         regs_9_to_0[0xa];
 };
 
 struct mlx5_ifc_mcam_access_reg_bits1 {
-- 
2.44.0


