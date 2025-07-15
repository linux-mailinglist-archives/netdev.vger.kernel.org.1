Return-Path: <netdev+bounces-207106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C603B05CAB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379041C24D70
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635382E7F0D;
	Tue, 15 Jul 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qehhsyWx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42262E7BD8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586106; cv=fail; b=VKYWAd7Act3kPn/VCwshj05aeDQAwYUSr2WpySslOTLucBI9QocuWBTzxkX+HNUp8NbR3vthEtQRbaygoWmZVdxbZ+s7Id0QIhw4B4scgZW2PGQKYPYGQC3n5kpLjLBLzsiq9JpWPL6BRYOW/fhufwF0O+HHmJpVBvCHTLXK+s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586106; c=relaxed/simple;
	bh=Ao2g3bUiMDQmmjSkvAYw/7PPDE1B2l/HT+FRA2XIpdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ef1JBnHULIFZUQK70DkpTkXLe/hYExV9UymwfKV2VDXZ6X/TM/vPz6EKFEVhulH3KG//bTC7F1AmEEBYZWGUxtPoYY6wjWHe4ml3Kccv5kzYkCvCp3MHwI7j9hJozuFbxKUhRqc0S7U2Ht6a+ZFRxZSTVAYJZY81wsRMIUdUIc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qehhsyWx; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/fW4Imghb/29tZ7ljAFgGzbLw0+CcXpElcpHovUVUPTxhCl/NrZRB9hM8JKq6QbEeCvvoW6FDkbHC/NsNN07QIl1jfgszwAkEt2TeQwkI+evh73a46VU3TYby60rRfBrGlcGhRfWOgwnnCWNnm18FDYCJEPqufTHgNPNXQ911ETZ7Tom0k9FQsYoin9H9S3xfp8/2SGvabVxv685+MlpEXxkjRFxanuwAlo8XBVPHUXJ18Cg9irpzCLgG/9mvQ5HHnihhePburv2cEkqpi3T8t3zN5hVIDpolW54AQAAPSOeCvw3ZMRfFx5ZjBP2iCNICw/zERjZCsJR7d55hv50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awFhljjfzJEjzSw1SKbrGkrheVkDe6NRH0EOTO4SjY0=;
 b=Dh8RpU043xi54J3aU1mySNEpDiICYk37FgrPxRVPBn+ofeVLoqLy3seVYr0bZiDtuSUkdSZzzqNQyXdQ1B2YzLD6WvjrIpym3o9PNiI5sxMgBQic9LjpmJXgaY9CxIGuGbzRW5s42CbRbj94CGjAvXZIhwI7dHQtyCopzilsj0TV1OI+GIm8DV7jeET3X5WfW4ouuvTgQvXfwnmB60Rg7s1GzEQjDrD54VqwSAB1ew6ofSLQClDjemSBBXI/oJLVE+aCi+YuGxAfECUMVMMKtYXKzQsgoL0wSEIqbLVdEKjFXZZobeYCeB5Lz8H8+qUUbTLsjHWn9WlO9Tw3h2oMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awFhljjfzJEjzSw1SKbrGkrheVkDe6NRH0EOTO4SjY0=;
 b=qehhsyWxTV2QMQTtVZeUWLnR8Yc59F62z7YEpSVB8eQkmpPkk5DWmX2Rsd5sHpUODH74WL65h7N9zP4byJteleonkRsetdOVm5Ei+NFEWz1by1SrY0GmXn2/0B7a8LhaeC+bJcRL/BYTSifxfxHFiqPcqWxs9diNfoKweRjccur7Xsvye4CGUw0IVOK4W8if5pbQITrysNououOEtFiWn4ILu6EhXsbWguLewpgLcZmjQ/1CrkXImNXxgs+PLmvvLGPOmyPWYf5MDI9VMHVhF91ygCNvL2/Pw0QqvJnwre1qEaGmMFq83uvvL2Zi7nb7EUM5BXdQIXsbIlbK+AwYdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:28:18 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:18 +0000
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
Subject: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 15 Jul 2025 13:27:32 +0000
Message-Id: <20250715132750.9619-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 93907e21-b261-4cce-6fd9-08ddc3a375f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aSwdr+pvmvQnhWWRtfNQl8b7XrKU9G6kgkXn/CcykHmBd+KelDywbqC3cU0W?=
 =?us-ascii?Q?HcLRAVR8fk9mhdlgtpsB9KklWGAOlQqYdZ3Q+WWfeiIN6Y3BZkIcUdqoH1Yz?=
 =?us-ascii?Q?mDGv6CSBawIngTW+SGAX6j/GF8xC4f2vxdrNZcH4qcCMtK83ZqRmLUSWM9TH?=
 =?us-ascii?Q?6+INXoKhDPJYuG5X1nqURBzClpwEdHL8mHVlTl4OP7ZRP7qXQT/D4HvxK4Pf?=
 =?us-ascii?Q?i86zk7X1RhgoDYDFOcBWc5wgxuAzUxwkyibufwdj234u3Nzb05ASwdEb++0f?=
 =?us-ascii?Q?jqlCmwOSLdWzMIWogg0LhrlW97qYmLSmr/Gy1cblV5Lwsi4uXgo1TiiQdDyn?=
 =?us-ascii?Q?6YYcMkkMt2/wF8UxX8v3zfIlfPmufVSyHXRKp0i1c8yEhIM0ua13iHhB5b2f?=
 =?us-ascii?Q?3fgZHZjAxwJEToCM/Id+Als6CVc1jDkjwYyztWmfl/zfagneWfKYq0A1D7df?=
 =?us-ascii?Q?2WfR7A/IS1e30LGT7yVrSOxICla90yvobjnbjcYVAtD/vGQRr98/aZNU27KG?=
 =?us-ascii?Q?n3G1U/rDR1MHetLB/++LSqE6BqnvjrzGKrUx3+n8bl7z+p3wIshYLCoB4XBX?=
 =?us-ascii?Q?/ZwBHNiqj5v5mgT8Hx2PVdScLMGje8kgyTEtSjFPdnZeyvpUUD50+uPmdn8Q?=
 =?us-ascii?Q?O1N+lsi1W9Tsx8ypzLQiM22G6v3qY362CHgHHBvkIbyc2H5nAKShXjBgi9Ae?=
 =?us-ascii?Q?CPHcl4Fqx/s04MtxzqjLToL4ruq5l11ZYuSmo8Xe95w+AIJROlnIH8NEkdUm?=
 =?us-ascii?Q?breXofu1NS+dqA0NKk90qMkTrW74hnbDhoOr6JDoEwhxwxCO34lE1/Znb9eF?=
 =?us-ascii?Q?gIbSCjD4MZ7HiCauNrl1InNLD2Qia7pMDnpjkiNwmalesbFrD4z7lt4ltTZC?=
 =?us-ascii?Q?UQK6X+ckYLejfFdBxQzijEj3davG+Y0NrQavSj6UdT6kvUmcsxBjYiUG1Wxo?=
 =?us-ascii?Q?XIFz0P6g8u2ogMaIn0SUmgpy4vgOc0hVtbF1fOKaL0/QUBJE0Kvz5Mvn0S2q?=
 =?us-ascii?Q?ONWUYp+/ZiYCtguhUWrpeV/CqcHOiCou1uGc3HaKWef9/dWB4rnXScCGxt4+?=
 =?us-ascii?Q?Ab/2FoPmGfa7zZsR54r73JY3dy1qyQ96S/jCbgC5jiP9CWSHbmMCl+4S+3z7?=
 =?us-ascii?Q?POxlfoXR8I1CCpJ59xjRVZfT+Ygzj7mPjFejGfJCHtXzKIuNF8hGNhv+oL38?=
 =?us-ascii?Q?YyWYTNyZ+tb48BgYOCwK/AmDb6qxuEUuMKmK3fp3uP8pPuYHu5/WIuCMrsOX?=
 =?us-ascii?Q?0GCWXO2BQcLca35i57UhLo3PrtD02uVHPH0sQbrjM4LG9Qh9RaHgjRj4Bp7M?=
 =?us-ascii?Q?nzJxPffzm2H63U4hLlH0HWSVaiAMjBeOKFeI9AFz+YPn+1gg02izX7cKk2iA?=
 =?us-ascii?Q?JuSySmsSCq0E5xcYSIMDE3PQzEuzIo4BzpwI1HL6RdE2HHcDafc2S47X7wsy?=
 =?us-ascii?Q?YVxLQQr55eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZvXlEauRpMyI58yqk40ygjNtPjcmQKqTtfbFd2CT0cPDSvvdON5w+p3evh8?=
 =?us-ascii?Q?6hb+AI5XGMuJXTH/4QJd7wlOE7RdwLXd9i2rJe96gfdinFLH9eO9cbKMMr6a?=
 =?us-ascii?Q?+lIM4uC2L5gvlakZiW3LdSJoAQC9QwNY365lNARUuYonXeyV0veBxSoYYxzb?=
 =?us-ascii?Q?GoSBTXsV48UHUVSNNwSIk56CURNWZB6mLA7T7SNw/MobFQR3oR9j9yknSTwd?=
 =?us-ascii?Q?e6Y6vvQUXyHBZhKWGFM1/52TUtuZlFl79DdLB1oewpMiWDBF1/bTzg1gU3GR?=
 =?us-ascii?Q?GfCkXu+BW9GKpVlkBRf5G2SL8z5LORZQ1a1ksHJtvb8h9R0LUPnrzc67m7DU?=
 =?us-ascii?Q?LcPBaeygwCTz70V7DZXqgVdqV1dqpry6/sA8BjVnjMOlIkkGKVL8BKk1hU3z?=
 =?us-ascii?Q?e98kzxD/VcUsDttDT1DROhKUxwyorImuKmECdfN4RFhFoPr+oqqkXB+g3qcX?=
 =?us-ascii?Q?qyc25eUw3PUNuY+AMwusjYRrC+Qc5UtpTlU6fxKCNY6XPiwUty0IZRp4PI1/?=
 =?us-ascii?Q?zfl5cgDaMdOPo3BVcACF7OsBqm/ko+9BDQXMLnDKhQlKC0Mmq7klYlaOWVP+?=
 =?us-ascii?Q?tir7CXadojo4M+ODhyNE9ftWnMvw31gNK9pIci/ZGNRGyQyZd63kbzZGTbhe?=
 =?us-ascii?Q?DTSnUXrevXoVrmbslrXPAEVnf92phw/8v8/KTZZ2DWQEZDbetFyi9QYqe1yx?=
 =?us-ascii?Q?B+M8nDyMs3zvSDfFfOrvpoDSMp9kpOGb1wI4xS0b+h0d2ZwZqb4XFNimK0I+?=
 =?us-ascii?Q?jUI6UhU6I4GQrmS90nnkB6qi4lW8Lv62vPVvXP2H1pS0yEl8IE/t1E/mcz1M?=
 =?us-ascii?Q?IXpapWOukgCkzOX1dP2bqkA7wlMx6Wu1/ah9UHbwxiJH9ss7OsfXGZszQRPR?=
 =?us-ascii?Q?wj3Kl0tVwlSkC+gIpGC0eyRHK1YoVwF0MDjCxWTGSDep5y5Hexlqn6CZwwJK?=
 =?us-ascii?Q?SxLa7KSKVVAwjfTv7qZgsuAS7ZsoJiHAdadrH/zdCX/JrBM/CDjWd8yAiEdZ?=
 =?us-ascii?Q?QZfYrOcBC7oxQk0wICPIpYVJFRsmImdz0TMW0igl6YKpW4lg31a85KllwNhB?=
 =?us-ascii?Q?2sbOIi/YoP3QAZW7U4BLP4mpH7N98Vhm3OEnY3xM5gK/jelGqCY2a3VNrN/O?=
 =?us-ascii?Q?NHnz9CIGEO/9eaQrZQ0/ERpUXdncIjfOIzIWvWOXSo769DVVBj2Yh9baEoB3?=
 =?us-ascii?Q?SZesZ+cUv/qiHUuToYjMkRBI1fsECAzy6nnPZTztn6YBxPOoxmDQlzTVUhk9?=
 =?us-ascii?Q?romsvmFequGXJVpRQ4i0Kze7HLE0Nyr8qYxXSqzMGaq1HNasjQoPCCymb2mJ?=
 =?us-ascii?Q?yKsO5vxtGXBD6PSnrtyCAarlSwUm6Aiur3OThMkEIsJe/3MHRG8CSS6eHqfA?=
 =?us-ascii?Q?yk7n7ujjUZW+4uKydWScKk8GsioKPj8JgwisnqnDVrpYOWA8ShNPjI6NS+NA?=
 =?us-ascii?Q?sB+WN63sxwNx9WDlXH7FXjFKxEco0o7EV/uPErv+WWc1vJlPoZ/Q5SQRYnm5?=
 =?us-ascii?Q?WKQaRdhTYeWRvvPAGO8EoI2yFBXA9M9sRVTNWP4dSn71kJRP4pW+QBSIc/jl?=
 =?us-ascii?Q?65/SJhsnbxBQZknOw3YlP9ALn/ZulaJktf9DguXp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93907e21-b261-4cce-6fd9-08ddc3a375f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:18.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj22Ot/fgIVgBNgV+o6JLMTkVZc9WlvytxXKeM0aguEHVqIKmn5UYQiMx+Bu4NYis6nhTifdVHCpBWMNyYTobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

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
index f9193f952f49..47fdb32653a2 100644
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


