Return-Path: <netdev+bounces-103395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC83907DC5
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193E8B22EDF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CC13D896;
	Thu, 13 Jun 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bG6x/50O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AE13A256
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312543; cv=fail; b=DYwXcTEymiwFzpXM9DIBs1ttBfH7ajroAXUKnyaahgnX8v9T3jhIxgna+EH2lgad3gePbXE/FIANeW12C5EjvVP8CSqXkn8bH11kOEwyq+3SQC2sM/L21iD555AZhMtrhHUBwFCGnJ5kzc/9gwNnJwfNsHfSaJ3kjGbCMbG/s7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312543; c=relaxed/simple;
	bh=5ek446OFcpGfKlzN8vv030fyf0V194rFzpGEetqNsxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSdVoV5Qv3BXuXDBOj2vqyi2C8GMPmah95qatZEZN7wqWaFip+WyCjnvG5CE7KCbtHq5AdCsjNsFfqyXLbk6T4AsQgKdeVtxf/EJuia3uwAF+thqcvc09ZhX92bGka2Jlev6DWo9k59lB+r3lxQaU01PMI6nk4RtEVJdOo/hAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bG6x/50O; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6qY4aB37JES+juLYOg6iSN50mtm1863FmuAE4oYbs5Xt0itAXJBfdnnKvbgwiwbI34M/JYrwFLiG59fNDUQynqgzh5Gerxmj+3nIhbngkPVpCAhSdDGcaoPBKpgd+LTtKx+CD/e3qhanNtdFjJ/bO2+6LQtcmIgsaK7G1tdRX+FsvaIiLNaTckONB+4/VMBayRsOuNt40axa/vUW3IN2m8ngVF66+7xSQFgU5C3o3tPSHnXnB8OstfacaOeC77exh0dUUetopPHwep2prmFttf84gkoUF3x5KtnWiUegNNuMTq8sPykWmc6tOJ3hGnxU/tj/OtSJNzPTVrm46ZErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKfM3yRLh7cw46Kr3oCs1DVUdnp74PhvKCHpIqRDmwI=;
 b=mIeWt+KecSK5osSAsQN38nN33eQpdOY7Z5yJ4OOlMeJzHCDhA1RWj/AKMTcaVbGG6x8jubN5CtGLH+CSgiVK/I4CeV+7wUTr2ypBO7RpIKaXUCEtxbKVmtDr+sGlEXud3k2XBKUt9uuOArhVMkrwuzLrdgPUXICSTcEop05zqMOGZrtjnicLaP370qtRmSBIVtOyR1RaISD1Ew2ne6vQC7H/OEu4I/vgo3+kCYAkAbZSaKkGii6P3uwTkXu5C2sbsWXTTF+QwC5+skPfZ5uhepGUEQFfbCjgCfIO+Wky5aEwiA5F2ZGwFE0hdPADxGHZUDXNZb97c97C1N46erGh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKfM3yRLh7cw46Kr3oCs1DVUdnp74PhvKCHpIqRDmwI=;
 b=bG6x/50OtMWWRAOxXvuMqh/AZvXG7drs+ieD2TeBVBB6sr0+9GTAoRjGGAgmZZsS+CdEAVy+y1fQ25znvgmATsX3onFEYsmIi9wmDeJPXZi6zmkVQNvun1hvve+SSXb2VKwx1D2ycwTj5FXt2D/B2iePFfJB7wTpWFH17E6n3tl9dEwA0giq8sPtexnT+/REMeo/l5ABHw8O0QUog73Hdjp1MYG9xNORE7dRakZfBy/6imyCSoJBdokt9xRF8MYWeH2zVEYqqZBZFF1mv9kdaeKhnA5Krh0+PqsCKtFEwQ3QqOX99U0VRtiR5e2NTqk+AK3FqrGCDTamY0sDGdaNnA==
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 21:02:14 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::50) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 1/6] net/mlx5: Correct TASR typo into TSAR
Date: Fri, 14 Jun 2024 00:00:31 +0300
Message-ID: <20240613210036.1125203-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b81fb7-9464-4ee4-be8e-08dc8bec19c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wy/wzhBWafKDYrntu04ZQXoRVBXaf8Hg/FNJjE0+lyfv2GJfiba5+UHHfd3L?=
 =?us-ascii?Q?nyZx6k8jGXZWVtcNtIQHAh3qDmikI90CC8HHPfgClc8Uhz1Wz9bLuetRI43/?=
 =?us-ascii?Q?OC30WyzgC7btHKARbynPrcrGw0EBTBfi054V2xRMGLcWMrBzB1MRpuBzTGK9?=
 =?us-ascii?Q?TF0He5iGzIb+dFHd+syKprOrI8BOqnSdOWpsJqj9w8sEG2v/C9wTpiEjF/Ud?=
 =?us-ascii?Q?lAc32E9Zc7TXRLluRtuec9wQzmcc6KRbtRR2mPpzScBfAOj5bN1uVmEr0c7T?=
 =?us-ascii?Q?tvTw9pXtggr1IrGIXnAcM/BSJuGaN/XJcqpiAOgY3ez43Gxeq966/5SHd93k?=
 =?us-ascii?Q?wlxtgCgiWAcIRGGT4smF2rJbvFYhL4l2XAA2F+baVJLmpEtcGHDkL5fYlKj6?=
 =?us-ascii?Q?Yu6w95K0D6cZVELAkCbdA7cAZ2pbbCZQy8PhGVkzNKrdgJp90aHrK36zC82N?=
 =?us-ascii?Q?7EgF2iSAX6+WdcdLLlQssC9KDutsclqs7GuB7KA0Ubw8InnrF0q3MGreeWaL?=
 =?us-ascii?Q?BHm0+J7V9mFTf/xwMtNppphM5t0JVaY/DmWuvjEaS+U/Kxd8vfr7Y2VaCQxg?=
 =?us-ascii?Q?9icGvjkXM7jR9ki2qbZgoHAxOtWskzYfxnHOWR0P4PgExcRfeXMDAd+VZ4OJ?=
 =?us-ascii?Q?X1NA4EOuit0pbHOmDXmPuwsx2Y9qIITN/LOv/z8O9W5bnuJDab7DtbhMx7f4?=
 =?us-ascii?Q?gCq3Rx7GZWOOVfYljJS/EwxQG38oJJA3FkaC3xYu32ry+RdZiPT2gQZV8Uq2?=
 =?us-ascii?Q?iYLcO5cen2J1CkEOutrWCVsr+dhKozgF18FaSoYTkint1N1jygqX1vYrzc1I?=
 =?us-ascii?Q?ixwzMmi6TLLwULi+NcYBekq3wWOwJ1Sd6tgImZFUIw18eQzYe2OdIpLSnmTp?=
 =?us-ascii?Q?cepVxg1Dp6V26pK/CyMiGp7SXpgzLoWHQM57Y/hgo3ha7z4Wu1VurbZWRfSN?=
 =?us-ascii?Q?+mDBUXPpje0GERsXSdzGoJ4tVZ/JTxPMjdHSb9oEbO+qsuMIVoPgTcbpDQwX?=
 =?us-ascii?Q?36Uca61wEt1DJDGOKg9Npb/rI86TvwMF7zF2t3eKt/nwoaaTSt1yACwu7+KC?=
 =?us-ascii?Q?PnqpG7FiVs6vU1o6lLCqbsQfV2E/0sVYcF9ERHEnn/lTwFRXLUhkzzRexw3I?=
 =?us-ascii?Q?RZ33qvNetGIsWAb5kxrQ3q/Hy1dbNIAqnDE1EY7rFmDufVcZuCElLfB+1wOW?=
 =?us-ascii?Q?WKeFyCNwNmZOsVsr+RiuKpleJo5OrEPjmcbOLWcshQYaZrL5lFPC4Tk4C0xx?=
 =?us-ascii?Q?tA2q2c7zoZXEsj1M5f13a7x3C/mFn48iyV9z/Vxvrb8l8Go67K6+es7yr79r?=
 =?us-ascii?Q?ozT32WudBjlXw61VMhp/sulMU0MkHnapgijWcTc9XrRkWaAkoTkJkyabinDt?=
 =?us-ascii?Q?8zhfnFm/37qdqHEBaKbVa3PZUCeb3EiloEOeHtGriEdDqoBRFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:13.8578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b81fb7-9464-4ee4-be8e-08dc8bec19c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

From: Cosmin Ratiu <cratiu@nvidia.com>

TSAR is the correct spelling (Transmit Scheduling ARbiter).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 2 +-
 include/linux/mlx5/mlx5_ifc.h                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d2ebe56c3977..20146a2dc7f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -531,7 +531,7 @@ static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
 	switch (type) {
 	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
 		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_TASR;
+		       ELEMENT_TYPE_CAP_MASK_TSAR;
 	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
 		return MLX5_CAP_QOS(dev, esw_element_type) &
 		       ELEMENT_TYPE_CAP_MASK_VPORT;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 17acd0f3ca8e..466dcda40bb5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -3914,7 +3914,7 @@ enum {
 };
 
 enum {
-	ELEMENT_TYPE_CAP_MASK_TASR		= 1 << 0,
+	ELEMENT_TYPE_CAP_MASK_TSAR		= 1 << 0,
 	ELEMENT_TYPE_CAP_MASK_VPORT		= 1 << 1,
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
-- 
2.44.0


