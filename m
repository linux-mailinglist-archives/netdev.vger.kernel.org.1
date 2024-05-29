Return-Path: <netdev+bounces-99109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003748D3BB5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E51F267B9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04318732E;
	Wed, 29 May 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrduSnNe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10918410B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998551; cv=fail; b=FeHRdf/7F3yB8dWXlojD0xB5fZLlwOiDYb/f623FkA+9b2KxfdSXwRK3o5z+k7J35+jVmJFut/tFa4J4m9F6YgXFkYQ6JdJtoGuimk6O5uiGX58nB0pDMeCWuiilVNJPxTl5NCD7G68kzM2pVskjt9QJQAI5Jtkl4BYCLqFqA/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998551; c=relaxed/simple;
	bh=5iqQB/8ErF5jjYs5ocrr88gKwGEDl0QiiYGrcw9PIEc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDF15sd/1XQ06ydQlsf4CaXEs7H05/fhUbZ0pxfQulvPiZOgNJbhpSfYZrCmRiW6i1Bxc8eXkPFoiBakr5Tj5aXkuiO2LIf+KlugLbrZmxTPnMkc+IuofMhS+dK9UElfi18U9mXPkfWDKfppVv9NVGBJiJFpIVyAOVWP+oCnbUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrduSnNe; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6suXXRblEO33n3ShHf7dlGoJKuIMrhi2dIDnVnuGUTQVFqeixIXkoUsQjl+jHTZFHqAxE/WuiOdMlKtdvVBZ3DD8oLYyJpeR2hafN0j/wJ8I3j15At73othpNraFevkBS/YyigoOKORFwLFjXKAXX+zaU9BrjiCU0k9JHLVwnaquE0X5bJzP2K4YKuzWoVQoVVPoqhvvtZY8zWDwkRLoQ4icdKxuesctHdr3vo/I0PFVAj9Uiv3506x4VCDL+UrBwroLxbAk2oy6z23jbqsdPh+rjIXYEP0CBDogDL7RXXXrPqJ4Kt2XVvLPrC4tS5UkM1rvzu13XFbaODRLskasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnlOyT6KAvyU1OrYhbGQb1vcthWkKs3cPwoUNJWy4VI=;
 b=I3N4mZTCC3XKV2l1O46aKNrZNJXAaYyNGGfJuNZAJExO8YeTt+9Ye7m1h3Rx5fU/Oy5a+cmgQRszG2FOGZ8xmscGmmRc9R5JoMKqY/9iUt4ycHRnWBZeAU1cwTcrmzY0jMIr6+BhsecaYp2ujw31SnsUXeayKSqRiJF4L3nUFqsScOORnnu26C+IfxdKQxy0AUHeJY1Q4xwWrV64Mdv0iN53E7QJnvL22z0+oYT6/XLl//bPX++D34DvqJbynnwJWNSfeF4Snpxj1RYfUCwfz03Oh56gaqbqzOrRkGkLM3CD8fYuP05KW39rtmROmmWCFAT10b86RzH1U6lNQn6Wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnlOyT6KAvyU1OrYhbGQb1vcthWkKs3cPwoUNJWy4VI=;
 b=PrduSnNetMKrStPyhPzBtyCVxKrtY/Lq16/GLsNbLfRuj24QaVuI9j7GHH0JujbD8kqF3IDxdwb2+wS0o8DPt7jOuI0y3SkbEdccgoeqanZWL9+nMVXyRcNNb7N3Xr4Mxw0wnCF746fUwS8MAlR+IG+JhHwEjSNFExd7Pgpp4aLrLccvM/lYKW8M9jsqwnNzZHct0Y5zkKZHOoX7NlfFmj7bVBsuJvX+Q7xN2kJPyty3jVNxL1tgFQKWoXYk+72cmV/Ti8SxmzCe1W1cXRMIYixrHBd39MihVS1Po6pD9GBOAvLomsH43k+2S73uHb9DLsoCkQ5wTM8L/uXCzuLm7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:02:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:24 +0000
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
Subject: [PATCH v25 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed, 29 May 2024 16:00:48 +0000
Message-Id: <20240529160053.111531-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 898a9ba7-e293-421f-d140-08dc7ff8bb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOHVVSTmJHgHSFVWy9BA5o8aLrX0Ym4Rg8Ai+/S+Au6o3q/T+VGzVOzarfFr?=
 =?us-ascii?Q?/wV1CqhX/dGfE/a+lok+wcp3v7kTp4eIxpE0K7cs1i9w46RJQh+0KX+RMVXs?=
 =?us-ascii?Q?bgvT0qRQpeJJNsuR3ns+tzY1Etlq/Fse+P3D50qnaALvYkcIky5vNHIHfTPt?=
 =?us-ascii?Q?qyDMzhPXZ5MPQAjUxnye0icFZ934oo5589TxYULMSxCgUsZsYzUNruJWkkiG?=
 =?us-ascii?Q?djLzNSwH77zY1nbf7U+D4PNSAor7qSzGZU8u/7KEvS4KWNO8CjWGBcn12Ffk?=
 =?us-ascii?Q?ANP+RPHMJg+Ox2lfE4lF2Bz35QF91vmvkv8WBqCIfY6VXQaxtVcwwA/KTtPN?=
 =?us-ascii?Q?Mp6JhpUFaai7fVKAS8XwcIooNu3kwpzMCz8JE84nZnlhWYA75oy9/yTlR0f3?=
 =?us-ascii?Q?p0XLf04Nc4j6lIFJ/l2paGeIfUzt7lnyyh0BQJ6tO1uk92rg6GxoxUQz2X0g?=
 =?us-ascii?Q?nujLfnUqbgMjE9S7f5miK15out5Nfvkahi24v+Lw2hnU5N7D1p8otBQYLf7I?=
 =?us-ascii?Q?WU3o90R2b9jQNnsp+3LNzRGD2KBkGiy8RQrQx4p4IFtPlDwD5Labxa/AsHB+?=
 =?us-ascii?Q?LpzWZyZ12BpPWdtXDn2jjUOfbLCjyMS4tQ9xlxiSVBIuBz7ArINky/WWdwoy?=
 =?us-ascii?Q?VWJQdjijQlA2QbpI081lxetf6qJ/aMur386Eq6hf0tHwtO+PLPmK9Kl/VD1+?=
 =?us-ascii?Q?GnpnZpz71JNGXhVUY15+mfMj3W0KavgNDIrgjVwvLYNP/EblBfT8EZ7mQ6fM?=
 =?us-ascii?Q?HugwUnZ3NQkzOBSNwu+UH4VH1KJAJrld0xz3RKjNPpIcyVLKjBxJVrZEiozH?=
 =?us-ascii?Q?CGn8SCgWz61/fEAQpc084YZpfTtohbw8hjPqPn0KjMItLBaVbhMJt+Xorn/u?=
 =?us-ascii?Q?feVDMIJFk9R42/yh2+3+GzG1L683c54z7DgPx10WbQij50gYz3mrAK9BR1Lr?=
 =?us-ascii?Q?KLnn/ZhyuMg/FtFwg61vDidKduA+sE6OCjm6dI6YpUVunu4EDb/smUEv4ocp?=
 =?us-ascii?Q?Wz10X9gX2CFUd6sGbdTWQ+qKtebUjJ64xNGBZ6ulkhw/HbA/vai7u/RcDtGI?=
 =?us-ascii?Q?8Wi++cHxwThzEqsP2IqJFfyDGJ7PKWLuBgcqOpiDWeaokK+myMTLpTI+EORd?=
 =?us-ascii?Q?fo9+FRlbC+DDJoMh766uTsqljr7JL6UuS5mMrzTFxr0v5NtX1L9Jq9aLIq8q?=
 =?us-ascii?Q?6NcsPIvjTnf4JqN92ZLMv1yvvOvjsrWqQVV97RcKGNVUfSW3g/DiZ/mwolR8?=
 =?us-ascii?Q?DOAjb5GIog3dXE0OXe+e8AzwLo42MjOTK6hlhWG8wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8P2TaH/7N7TVQ6vkExKBE7WMHm1dlDlgkbpYTCrhVojU9VtKkpUNAShtzJzF?=
 =?us-ascii?Q?c4IPKFvG9eQ5VNMnw0EMzAz6LC9n+ef+Teb5crAuD21u9/eF4sQdGrAZZ+QI?=
 =?us-ascii?Q?d5mKG4QV5up4gEZ9/RNwV2he+7YyqEfMKtWnN44J6SOtW//p6hSBwdITqeDQ?=
 =?us-ascii?Q?XFy/DpE1MR6Uzffsz2DIFYt/IP53O52aNUJg4WynKM61LQgTijwkUR/0RebH?=
 =?us-ascii?Q?cdd1O8Yk/U4S0eyKFMwMSdqTx6OtDrXnFjeC4C3AEVH+PdiEgxTZlrR2umA5?=
 =?us-ascii?Q?hT5txR05R3b/Fz1yEbvX4UA9eigygcUWxli9gj9V5xzW6JKAfOj+XIiyh0vc?=
 =?us-ascii?Q?8LKG8ok/d6x/DG9Ef3QFCMiQZ0uDcW4m2J2imIj4Qdn7SjxJ6UHxT9RoRSkP?=
 =?us-ascii?Q?mq+g/LnX6qHlHvx9hI4RFN536W9qtZhxtbn3ladtaXG6U/umLuG9BcKpOtBA?=
 =?us-ascii?Q?9HPpyl2EpHlZZF2zaVobY6AZjsTjuRtWmxf03WzcXvgRQDL3KOdQtyFHVT5W?=
 =?us-ascii?Q?OWI2jczQRxwgwFyrTZPaVjrV+pcvUWTs/J03bsDxTkkxTG8PO3uYraP8eCUO?=
 =?us-ascii?Q?IUEZCplkfOnzOjVxXZI6onCzPJ96DakNx2cNvaGuAkJL+uAqEMXm8g24UCR4?=
 =?us-ascii?Q?0rxGLS00zuRLsGfUc/a/sN9q2itHpEwCtVn9oSQiVGgmG/iiLM15z9DktBU2?=
 =?us-ascii?Q?iL3JfV20xidQjDX2gWiDLoKyZGn7EGdzS2wrGM09p0NuO3bfiIZJ+lq+C/FG?=
 =?us-ascii?Q?Pay0G50VfCnKXpVoLu8xMdovKMvN/rLmQu/vy4hGfDzzlVRmZzdCYAIMsmFX?=
 =?us-ascii?Q?Mg71aqhOhWU+0T3nZyxmLH8Xg9OmL4VI3WhhFqlt9rqzw1R1JtSRHtNsv8IO?=
 =?us-ascii?Q?rmxzClJ0v7Ales/HNd4l54xdJC0M1aCMXpiMf5lcftjq5Gzo/3z2c4z9iZSB?=
 =?us-ascii?Q?aQ20ZEq4kTK1pz7FtmB7zjO8WC6lxmcaXDepongrL+3JCrKmaLXR73a+FQS/?=
 =?us-ascii?Q?zk3kiff33HiTA9ljKIvXBDwx0rkU2nrw3vwfjOthTQCJ50PKhyZr+ll3zqNA?=
 =?us-ascii?Q?u0At1xVqLIIXNfa5UNBq4EfyD/K8vt2P8a5MxGhjhvM1TiINwcSLdiPoARJk?=
 =?us-ascii?Q?5GO2WOca0Y19MA0I2FhntfkZMhIkS5k0dz8Cu6W4vVRBrBBMabPFNr6l3NJf?=
 =?us-ascii?Q?AmNJtfWx6MZvwkp4NiipoUkOBOFgyiBZ+nQG1/c45sukbb0S9x/4iDLwToej?=
 =?us-ascii?Q?cZ9CZmWi5/htemb5vzellSrqSBRub78ZMxzzmDWOOVWkupmcWdbHGsbRSqXQ?=
 =?us-ascii?Q?Ee0XPwu3vlDwFhU5ds+xHLWGLpaPI1fPG3Y24luKBfbLK72HA9kX7goMFx7R?=
 =?us-ascii?Q?wNt7px5KdiYJweK24n4M7fKBVwZOzu7eAH7YwX13VwuJ8aL6Rl0pMu1OJlEu?=
 =?us-ascii?Q?tmk3PUnbFVWNXJ1b8M+u+5JvkypSy1YJj6EI26Ho9P4JPOA5qrQ3eY5inout?=
 =?us-ascii?Q?slZ5/1A32ZncH4VUwhXux51ie1livFx/5d3piGIIHS3VvNRM2eZ2lKUsWt3l?=
 =?us-ascii?Q?0BPdfEoNlW/0qF4hVYdaEFpqxufNK/8J4dCj92SS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898a9ba7-e293-421f-d140-08dc7ff8bb1e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:24.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kJNlGrN/WkpZWumcFhUjy7Y/z/4OCjuktCPfP+tzajWF0n9mdS0u7+Lou8COypaZqip/VGQjkNyel1HF7++Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..294fdcdb0f6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -50,6 +50,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -256,10 +259,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +276,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9965757873f9..c36bcc230455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 47bc37292bc3..d13bef7c72e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


