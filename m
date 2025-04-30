Return-Path: <netdev+bounces-186970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA5AA4618
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12EB3B0A9B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC121B9DA;
	Wed, 30 Apr 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NH6u8+aw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CC21ADB0
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003492; cv=fail; b=ts/GQwM4nITRBRCxSig8tbnTCqiFKAfIg4LtTIybaZc6KsMExPimq3fgMtBPEsFMpaRS1cXQMDOKCUVzJ/E9MlsQCZ7j3KRsHeF2ZY3pHWxDp99EDl2n4f8MaWh2rhmL9kfNVzJK97xjtYu5pnZ/c2P1VAF3KrDr+a+6U+jex28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003492; c=relaxed/simple;
	bh=ST1D5OBLJqC8rF+TydHvjwH4vgmJlbwYvIi3vOsx1yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lu2rluBI0Xod1URCe5rpjC2Op2n0zLab+eYSTA4Alq7GYJOIjN+MOYjQtpsu83xyPJrml82FAx3lop8NYeua89HegZLihvr6bA+EeF7pw2bmf/egPJUT4Uc6Okzb14rGsRhTgTnpQUo3K5Z7INNdd42OUa2RFWMh57vSESe7gEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NH6u8+aw; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvchDaIMiLrs1vPym6xwtvspBVoMBwLDE4GS2E52kneDHnD2+4L/pWtBSPxKnQ0KkP8OcZ/QgOGlnmFSWOAuoR+LM36kxFCeBb6Ys+Rz38mL1/DoPyhzH+Ruap6P1Q8RUwVxfLrR7+p7cdynbM1wLCXv1BWxhqbCZHDW7IwGvjbPXyvu80okw+HYqd3bESjB5FAtw7uDaRm2bEX9gIuAyHJ43jHbnMlDw++84jMaBhVkjyafYHKgDe1lJDesQBqMHSMQk7QOi1LuaoI0kE7r649rRCXcpfm4Uc2r+YxsxICw17dgDlmtg9pfdNEEF9yLdm3tIZA3UlOn5ZO4hmLE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMV+aBfwX2MGEbvxuTojh76AAgAV8fYlLyvdcJnRg2M=;
 b=xGVoK2jXJcIg9goG7m+U9PLMEn8WuPhMkkHQlZA4nhywT5P5q/aKzIN8fB4aq31OQI+RkmL37NuF28Bt3qUiRo2LRM/FtnL/zpKjFitfeQB1XjUHUqdbZhroddpSqJU9GbJU1M7ZLHHeJy//nl60PlG0ZfgLxik27r8dNDohRbj6u3wlIyK7CcqRvsQjTUtrx0KDeCTZTTFzSBj9K8e0Pyvq4ZBrgKTpYm70KLc4WwPB6Vrj9sMwbgrRW7RQVXxuIbNoGRCdSQzE4jyrUurpQzvGdPc8ysk1zvmEPoiCc1Jztv/3WwEq5O96cAYkSD8NeBt6LdKdTNhbRLjqgkZtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMV+aBfwX2MGEbvxuTojh76AAgAV8fYlLyvdcJnRg2M=;
 b=NH6u8+awwoQ4P9J+egfxY0Whk1PRZvzABhmyCNOTKlFWyPjCQvZSEEfeZXHPmoCvz9biHfce6b/tA+E+/jYVnc/p16AzYCtKonjkXKLU6/gFSpjRtOE90SbFIHPtimhuqoWNbbnXna9QkLZAgF2rZ1431vtNsQce59g09PafTBRnOZ2pxkkIP+KeZkaPmDsL15FurvDoSsxljLbLR6wa0q3SX/iFseAuTxIV7sNFkh6BloMaTaCtRvrr1LgRLSlcaR2fVC4NZ5xPufKWND8hRnw5N8B6lb8dAjTmFHysCxG3ZElLwvnjbSSFGwoYxMH5E3fLjaJP0bm/9HGou9IVjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:58:07 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:07 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: [PATCH v28 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Wed, 30 Apr 2025 08:57:24 +0000
Message-Id: <20250430085741.5108-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f9f703-44b3-4a7e-414f-08dd87c52053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14KyyN2W5PJAIvRQ04RcR3gULbH4srURjP1YwJOYYGn6tvEtkxo+4ttQAYBP?=
 =?us-ascii?Q?7AB87GEhsPQ9bbSeACb23idO1V5ksa2dVMMehbwkoxTpPxB6dP4iSYw/jiYh?=
 =?us-ascii?Q?YlkMV1i1Do1PVTThhD1lfgrk60gwkWRoou+TRH/2J0d7bkhZXcpxN6Oo0vO+?=
 =?us-ascii?Q?LiiuUUhuu6gKpnzLcV7ntbrV2tpAn6yAPc8NGolV4e66kOabZgRVF7/IwL+O?=
 =?us-ascii?Q?Lk9uaLO5rOSPX81sSXcNsIrscvpItw+gotMRG7wF9ffpVSgXoaXo25GKjSGt?=
 =?us-ascii?Q?vOogC4rrfs5rOTBCv64a2Rkc3JdH7KxsyUYFaftzxZKAwXtNNw9srTN0Mrsg?=
 =?us-ascii?Q?Rz6t0mSaz8lgVwnE1v3MRDjob7K8G6tH/azGgh03lvpnOu2659SqPlvzWwlz?=
 =?us-ascii?Q?Xk6Lez5zBqHUEz6ZOtIW/S9ZqWuFgFGKauIU346Q1V7FT6L2txF8ShuZpTs1?=
 =?us-ascii?Q?zodhuRRJmgWimWE143ynhlrD030Eiv05k7SsfQ0xtJQv3J0fI3xdgKuXE7kB?=
 =?us-ascii?Q?q2ErqC/amSv/N4wDq/Xqg+mW10b8DAcJL1B7waLZ5GL3aKTwD1lTlCARS1y8?=
 =?us-ascii?Q?/XtklzFeY+ftr2eDmKJ3Eyhx966GOEEvo3HpZ7uWk0brxUlMu21gxhegym8W?=
 =?us-ascii?Q?4peiWtveixCxYoO94WtAmWxvi5OSpIvde9Pa637ORUdg+O5Ywvyr+9GK1n1l?=
 =?us-ascii?Q?3pgBagm7sNZFt2UbahmEsuhU9eftkUYfoambVJe/HmbhxKr54TH7DrvFfEUf?=
 =?us-ascii?Q?SfeSi15EgM4RLCG+XXitm9Ipd9Ax0iSAcCfO7fm7Aqur6PX0uAfQT+NtRcxk?=
 =?us-ascii?Q?lmEu6+cEChwuMAxGGrn9aOq/neQe1GHWYD7Zn29XQnYrjuBOqbCaXqnNApoS?=
 =?us-ascii?Q?25dl6nFaNRAutQ5gGI28fORUC/KXAH7PTGZ8fCW4uawsa+vyg/JJNZ2F/38Y?=
 =?us-ascii?Q?5QzN4ruy4l8rKoa8bI92k2UseOxKDK6bIJyMd8cQZPv0+18oRdTGOp6weApw?=
 =?us-ascii?Q?D3EbMA7VMS1OKgOhR43FEROruQuDtoMpi058bFWsoNG4VV/86vN3Adkbeexh?=
 =?us-ascii?Q?Ym3ETo43PR5mX4G/LG3+IcPcmrIZiyyx2mMkskwoEGvzGHgxFZT/FWrLmyLY?=
 =?us-ascii?Q?rtnirEKfGw6ERcj/2QSGArB5xLBc3QvWegGjV1hI74egQ31wBbwzusk3F8uX?=
 =?us-ascii?Q?KPYDZAylO+q7e627HoQ9bKPTCaD04InmxFXbBywereXmITOnCXfu2vSU4URW?=
 =?us-ascii?Q?D+puuHjiQKmLWuLeLk2hDCtbNAgFdiqvjudeBFgI02/FJApw8ZNnBoiEvC77?=
 =?us-ascii?Q?LlooPrisp+znoaGK6n4pzvzaxA/U4SQljs9dPoieuSb6lJurBJrKK8fCNgto?=
 =?us-ascii?Q?3qwj0qA4X3CYrRV7gKrXEqsWlVo6MrdpQ1+Yfpy7sDdbT0I0P2V2gCPMHTr1?=
 =?us-ascii?Q?2vWI0Q5gzDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBFEJsAZxY7LP3dhLAWDFl2Vs41cC2w7Jz1zxjrdBLhxiGU6B1XbF+JYZBzY?=
 =?us-ascii?Q?K34bhmldrsNTyViQ03MXsUqb6b93E4u3Jby8beeGRYRyJkznbqacPoh8ouYJ?=
 =?us-ascii?Q?YjyoeAgTmu82QYDJC/AX36sV2e/rZThnx+ZQ6kn1bwthvvmfMjZyakrZsulr?=
 =?us-ascii?Q?xRVsSUkVbOf+Eaa22G3DUHkMaKtH8i9ZgUrA6Mq/qhu12EEl6ulq8Mrk71Dv?=
 =?us-ascii?Q?+NRDQl/2g/zG/u17B7LP2noS3NQpI73RUpHT5YgVEBBPMSMUZ4gSTdtITXSM?=
 =?us-ascii?Q?yTIbIngD7vSA5fW3vKHhzGKr7s03GyRWM4La3oUfixbAcV2ySjiQ7ER24MUk?=
 =?us-ascii?Q?+T8QVuodkbnp/0e72aaQZAkHpETJEKFTiy+NBFu4/3GfdWc3qf03fwLweNWr?=
 =?us-ascii?Q?ErpXkIgQhQ6Ql4QqzNCFwK81bzpbIN3zjdMUnBlWmxdhPMprLPY8RKvnSXnB?=
 =?us-ascii?Q?ynnY/fnz+8tP9xVgWnShQ1d0kvPC5sDIRz07sgG8dM4a9QHseSNnEOC6rZJA?=
 =?us-ascii?Q?NjXPXS/DOrKKd9x1u5G9LWFd4RZLhMVhOcQS1HGfmwHR5ayoVC0FcvC9s59R?=
 =?us-ascii?Q?a+KSlMTQ/KigzAoKVrbAE44CAt1+mNKwNUWsxSgUFSlkIxVkKoTFi0X6SBM+?=
 =?us-ascii?Q?6YJy52jXhAsKG6ZBqw8Jx0Q9X8hYnzKMHH89fmzN706MiTQ1uPMCNSXhgziu?=
 =?us-ascii?Q?/a32s5BGPfCZ/LfBneL5VWUVio2kWTf1IJeF7DHpAQNjrO6ExNNKjGt9hSBs?=
 =?us-ascii?Q?Dh5cOwle8uUMyhq4jefZ8VpnDAxUmfPevPejl3yXJR/Ln5kafIyA6iAm5dyq?=
 =?us-ascii?Q?kWx00sQQxbbq+CNLpndbNsRS2UHL20hS1j21I/mj8r/BXhsbWa36+uxWp+F1?=
 =?us-ascii?Q?khJHVw7auN2eP0JrX4aCjsoPFOBRdR45Ev2V1J4Q/lhsra+sN7jRmFd2oJkX?=
 =?us-ascii?Q?k6RoNzU0tGDM/RFIbKtNIKsHGbEhwofzWV5ME4b1pyK6DYnByzkm2c3L2Imi?=
 =?us-ascii?Q?tHlac49hlIxapFO0J+m6QEIwBYArrTjwjXUW8oen+CynEnUlsCAKPhZJTh45?=
 =?us-ascii?Q?Zh4+lGbHqvo3QE8NVZ45YwHEM7YQNWSpCBSEq1uGWeOklp0AEgE6SuqynSLo?=
 =?us-ascii?Q?4WLoB4mTuZFu5fCA4LZiiYCk8pbIz8VzEb2gIbhUcsXuo957tGC10aPhiHo8?=
 =?us-ascii?Q?SM14AwOtelwy53SRbiEfpla3tPLvuODbdL5l073I0XkmtEDJqaGMtd6GkrBz?=
 =?us-ascii?Q?z5y4oku5+ju+UIk7elQFO/HqYccKg5hQHYWsl2DNG2rZyxHemAl3y0+VoRGm?=
 =?us-ascii?Q?4W8NIKVjONdiLhh7RnxJWLBDfhvEXI7HsETUqZGmcc4fv66G7tzEP4skdDdj?=
 =?us-ascii?Q?//Fqdl58TmlbA5s82ulP1pcThw7QtzUTwUGJk0kKV3DhCMX1Z84OcqCh56QE?=
 =?us-ascii?Q?xxhZAg7lY3rpXSqbvZKg91XeHD9FaYTIh8HBC1tK6AEyS0ATUMjwu2QMlJZL?=
 =?us-ascii?Q?NCEVFcDF07fX2BCopl/4njAGyJ2XkMdWwga7BvgfA32X2PIWisVzbINRijql?=
 =?us-ascii?Q?lPuFAb8+Jfo5rJJz4EECEtx1nUHLADtQJwVhGpfY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f9f703-44b3-4a7e-414f-08dd87c52053
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:07.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gInV0h+D+Rb4pwgV0aIH140VwKb55TqNS63J2nS/U/HVvyI0C6Ebq/mBY/FwOjh0H1MR1Ujm5Fk5iYq657m+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bc9391e55d57..f9132281a88c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


