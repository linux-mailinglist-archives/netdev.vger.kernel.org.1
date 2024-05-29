Return-Path: <netdev+bounces-98996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0888D3565
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FF28A01C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10E17F370;
	Wed, 29 May 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAhRLZEX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4D17F367
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981703; cv=fail; b=Dbh30U09GH/By4pUk3ld5yRRP/38fHykQ10Bmd9KZ6KeEX7+87W2TLxWlpL3SYTjYGwpvF5UE6bdlJwj/IY3bg7OJMzt5GbdFoXAKtiTR6oRWgGqjxu3yuhRIZlsxctwyo1gtegvo0YVcBTk5dtkWQKsru2kDxluGgYkuuHej88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981703; c=relaxed/simple;
	bh=jjrFTJYIs4xQC98y4+qPZnF/yJGc+ueaiXyJ2sOEc2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDmSBecHHmbMGgo+r4WssMrGT2QxrGcS8mHA6LRJHTvtVTUorj0O7L4v0oizjX7wCfq62FfGyXOSrASSrBO2P4e0qUjjp0WvBJa3dp1B2t1ETEUiMl5VCdGPnrKwGlkpzZVWwcqnpJaHlUQYfBCanrI/1jxE/01MNPvV1zONz6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAhRLZEX; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTtSuvBhZlqlVYoeh33d+D1YQ5Z6saWdDrugriqSqUWS7oMCfvjVANH3lXiNExLfRepg5M7n2UDn5lPvXuDetKJ7zRC1bNGDRpLem6w0P3NDDOdowKBpZ9Z7BD6x6ai9jeYkZsD5K0rNwrFqQFJgsZA8gWv88RlJDzhH9jpU0rcvjAFs6kGR3t8IVCz2ImLtIzII57J7hXaKm7AuC80e3wCTM4+djVnszRl2xYPUmugqfu2ZU8/su1kVZOE3LQWSEB4nJbf76FVWaydrLripMEXW5z26Nlc7SVOn6lrKOX+VPh/pL4deTz4SWu70mSDHzmz58Yxie5tf3IALHYsC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe5LIqegN5SmcDeFtsyywVi2ETeNYWoOcMo9na/Maco=;
 b=D8G13PvuDMaSQbpdA3NorFew6PeDs2skRPQta2LsTyCqOVuoWB3Q7qImvRF0fHAK88yco4CHyPWrQaO565tCcPDInnJkgi4cslhVr1FCsIgL3h60PJ8n0mFA+C/54rpKHeSWbdQ8/KcHpq0AJQTxi0+Sg73XIdmqQU5uYNeSetJkQBooqRYKrG1NWp0m0bnW+3fpI30I9AO1bid9ILzgZr3EQ94yQrlqSjOFr356K/+1EB5FOrjaQB1AVGbg033VFvF78cRT/GqaG0+pp//gu/Sx+DiYrt3MUkrb4oT+xxEcnQSD2XMdY59yf2aBCeA+LTdQGYFpwT4CgUm6FfFs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe5LIqegN5SmcDeFtsyywVi2ETeNYWoOcMo9na/Maco=;
 b=kAhRLZEXlUcXdzlXIVGnJo0xKrbRj9iwOVMcwwPltbp42y2VeMZ0DY+pFzdNTCb3mUXs3Trvgvz2pekq52NcSKBAlxsSGKiuFCCT/PhdfGPHVT54PwUz8Z45STP5+rR4ozYUCxgTIUOvL3Qi1kmzLHWuIjB//nW47iGD1SNfTKP2vX+WQ+0br/Oihar4u0wPy2FkrtKPW8jZouJg6YODKEBdAvv1MLNXcBk8f8sW+pQHZrGEU5iGtUSQeEz6+b7RxJFuPcFPTSEy8/d/0yKFSrp7MeJqFQAE610QceBZhbgN0mbjT/R/6p/964o+1aZ7h8WN6Tc7q8qIi01qxtYfDA==
Received: from PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::22)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 11:21:39 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::1d) by PH7P222CA0019.outlook.office365.com
 (2603:10b6:510:33a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Wed, 29 May 2024 11:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:21:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:27 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>
Subject: [PATCH net-next 3/4] mlxsw: spectrum_router: Apply user-defined multipath hash seed
Date: Wed, 29 May 2024 13:18:43 +0200
Message-ID: <20240529111844.13330-4-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240529111844.13330-1-petrm@nvidia.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e47c9d5-49c0-42ee-31ee-08dc7fd1824d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tw6hNM5g0+fXAfQ0JlUKvY3oGd/VcQI/YiBnwyPKGBi0+k89wmGRu/sByi4R?=
 =?us-ascii?Q?RubrV1NyUt3utOduQJOsjpwobOQLNqTuaJMV4ora6jn2G3D405+gBTUDdDvB?=
 =?us-ascii?Q?3gFkXSSneLgfa+XkCEVWC4T3uMhWHouODlhassOgFnGh9z/rVBhGCeP8jmyj?=
 =?us-ascii?Q?6zn9rcCKW0WSYz4VQdFWU+KLks4P8a18FyzY1r0VcAhY8bpJbV4gul20IG59?=
 =?us-ascii?Q?N404HzYzXSWq76LF9i9smZ8ZX2iQGsFLJYZr7VcHmF4SF2PZ+/Q9ZJlZuoA2?=
 =?us-ascii?Q?GUqoSqQXVttLV/RL844MMFCIfmh5pQ2A0boqsFW7SyUf9x4ulmaQzUxWVFd1?=
 =?us-ascii?Q?sVe+c6lyLY1G2Vu1vlmafkR/LRxLLiKQD8MDsNnWLruxqNV2P658UPTZ9Msu?=
 =?us-ascii?Q?OaWURRusF/I1TTxu46UdpxqGNAPlI17/WBGsq80j5SmS0WenfHBYQWTZ23jo?=
 =?us-ascii?Q?NjKpPH9lN59BrdBarfeeuSryUPIMaxJuvEraxl32t+04XwhZRmlAJs1sd6/J?=
 =?us-ascii?Q?G3jCxNbHEHbQkaReefPB6MBsgXZX3WF6GF6s9LSBPiU/8rpL7iEFtIK4fA9L?=
 =?us-ascii?Q?B2q62DGBSx2uATxezSdUYCAFIpJaEtM2UhWC+h+nf1sFOrSMFQBP4HvVzg57?=
 =?us-ascii?Q?bWRFWAgQ2d5x+vyM6PwqVWBMFyXd8ceDEk9IXSik2tUPJ6cxtRw6yLEjiJ+e?=
 =?us-ascii?Q?rciNmQhmp7Ht7t+WlixcOlheZGut7MWtCHjStYffFrv7MGURkqsaTD11mH0o?=
 =?us-ascii?Q?pVMqZu+7odbeWG0pP715SgMbsNlT2mF1fUY3A3SiUvCWGeE4QSZj+bSc6ZO5?=
 =?us-ascii?Q?NeiQk2qldU6yJxtuOULMNR9jFAsq2fneVKbZAnyNuox9izuup7oAL538YiFA?=
 =?us-ascii?Q?5FckqPkN7rgNg76E/GpEVxQR03uJOtgj8sbRCdUL3j6Sr2GU50uz5RsLThuz?=
 =?us-ascii?Q?QdOm0WyBEW8me6AyDKOXXoZ6mzMrwx74FU5FVqW0Bv+D2+rh/cJ03/GOPynZ?=
 =?us-ascii?Q?sORdWC0AM36hKO256CEjQhQC3MyDzlUBKxv/MPKKisXVlAjtmqZVevx+H2eC?=
 =?us-ascii?Q?1JAhKG2G1UsYQ8g0hBcydwEES9E86hg8ZkaQp4AFU61le1hm7kPWFjhur2pX?=
 =?us-ascii?Q?T46H64wCM6P9CcB2Ob6uKDwlUMkosOWB1VnKhaK9HwdHWA1/92Z8KJcWPMWH?=
 =?us-ascii?Q?5rI6cFxmXUeCKRPBOKeUuuJcSQSIZFEfW3JAHc3q8ofyekoV/+yZi1gmf2os?=
 =?us-ascii?Q?a2XryAywhtAl9ga1B04tlMxWeBjbB0DDM/9mQdZ1EXEH0+Qi+kGKGklT11O4?=
 =?us-ascii?Q?YGhQplX5W01LE4G19Bp7LSB9L6uPaEYoaOxTps8H6dXVq4WPcMk6tFjlitQG?=
 =?us-ascii?Q?PS7oIM2ILhA+1Nwijtv1g4hF+nOm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:21:38.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e47c9d5-49c0-42ee-31ee-08dc7fd1824d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

When Spectrum machines compute hash for the purposes of ECMP routing, they
use a seed specified through RECR_v2 (Router ECMP Configuration Register).
Up until now mlxsw computed the seed by hashing the machine's base MAC.
Now that we can optionally have a user-provided seed, use that if possible.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 40ba314fbc72..e5b669f0822d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -11449,13 +11449,23 @@ static int mlxsw_sp_mp_hash_parsing_depth_adjust(struct mlxsw_sp *mlxsw_sp,
 static int mlxsw_sp_mp_hash_init(struct mlxsw_sp *mlxsw_sp)
 {
 	bool old_inc_parsing_depth, new_inc_parsing_depth;
+	struct sysctl_fib_multipath_hash_seed *mphs;
 	struct mlxsw_sp_mp_hash_config config = {};
+	struct net *net = mlxsw_sp_net(mlxsw_sp);
 	char recr2_pl[MLXSW_REG_RECR2_LEN];
 	unsigned long bit;
-	u32 seed;
+	u32 seed = 0;
 	int err;
 
-	seed = jhash(mlxsw_sp->base_mac, sizeof(mlxsw_sp->base_mac), 0);
+	rcu_read_lock();
+	mphs = rcu_dereference(net->ipv4.sysctl_fib_multipath_hash_seed);
+	if (mphs)
+		seed = mphs->user_seed;
+	rcu_read_unlock();
+
+	if (!seed)
+		seed = jhash(mlxsw_sp->base_mac, sizeof(mlxsw_sp->base_mac), 0);
+
 	mlxsw_reg_recr2_pack(recr2_pl, seed);
 	mlxsw_sp_mp4_hash_init(mlxsw_sp, &config);
 	mlxsw_sp_mp6_hash_init(mlxsw_sp, &config);
-- 
2.45.0


