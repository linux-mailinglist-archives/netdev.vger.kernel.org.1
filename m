Return-Path: <netdev+bounces-168450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0818A3F100
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CB43B4AA4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CE20485F;
	Fri, 21 Feb 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dovip59j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA204591
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131631; cv=fail; b=mptDpzIFstCEfG87368ZHrcQiGkMTBgnvVzNhO/cI88i9g/JehaDLl2/kwtwfDJ55W4S/aXkXHQkfoW6D+QPFpQRxRMFwi+kBa/LUwsFYiHifAgnN0pUpei8u5Y9hpIMC+h7uUR8WaholUz5LCiU2QrohWEupb2I92mZf1r9PgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131631; c=relaxed/simple;
	bh=cG3ao6XoGSmdGDQ/9IHs7Ke/Umd9M+jh8+bQ6lA2Hdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msccSiBGfJKMv2JqOEV9BcmNs0t391OrfTXSlOds/xydFCFLn32gqcw8kYXH7HDTZjIM3KkHt7eNQiwW0JzYHKQ6kVqD7bvdz92/9hzHGFifwMewz7UNccdIh6diIR/zzBkHVtqNo/bYtCEXv+BMEkNpyUaFkQdjvL1nKkD7wy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dovip59j; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQivtg7e+axcsaTak70KhTVeHamOYaZSfArHybQSAv2ybgKdMcE5piu9o6aJ/ro095DSdD/Cw9CooJUqF0eyzVrFMJZyS2ACpwXV3xut1VrflscyA8WhIfPPtLF9WhDS36gvS/gWBWiZRKGmjmuITstLb59JTUqtNuV3ag4s/5jh3e2KwnATFxziigLwkcx0Ozac7tP5zHlmwcITlVHzzoS3K8t+7OMciypgHwtK9AbAgmkSOr0DcFQv3JPFG+sFbMB/0ih6fremEvtSbKCak8fqUrJPcntQiPi5Uj/EONCb7D0d5hIkodjDy2lifXJabZnmWNeF9QG+nLUJTj7+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbANyZ4hlxAZCCl5gU0jeywsl79FRX28LlZsR7zISwE=;
 b=dRp9axgfPZF/nMpL/9cTF8FAQgkn7NokAZCu5GROHRFVKo8LAilMExAwgotPp85/NYo/8kqs2sf+Fi0jnxSevlA64RYnLILWv38krX126e13JYQpBCXLTlj0MuFoZKh0dc/mim8iEwWyI2JhTib60ffnI8Kr4KfWdfRxz5kqRdhZNJUEyHSiAEvPy5MPMqcZK8ZBxPspdVJxOyEYCAryibdRWRc4rIvAJxNDEg0lGLV0CyrDlApGKjyD53nhUA011f0kT9hgW+BzyyDskGwDN67URrZ/h0iJ7/aHtnYv5QRrLa/LIBn4NueUcwhKFOHQJk544NYhW+5DGq1l+uuYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbANyZ4hlxAZCCl5gU0jeywsl79FRX28LlZsR7zISwE=;
 b=dovip59jpnoekHPWKx+Ppih6xEBdlKsre8SheaN0g4Qa9wOg4MSPHayIqBlD9kC7MGbDRpWa5+ZZuwlqhM9vny4kbvJxJ9xKBw0MiWDrg/Q0vDiN6YxPTSVOgckbyqUCdMUdaVvDWTENye1bEj2WwzrwXKm/6Bqtz/nr1UiTZ1dIGOODBcReiBPFGkYV1RyCjhqbyGhrEA84EceU3J0lPOGJyfW1zavM9JpRPj6i6/YZ2tRwqyNi20ah6iSBc2fYUioRyEHDsH1WaTkKcsgITREhTqgcsI5fcN+OgRWQscPOECI2ghTW0Ss5myckoIIeDY+1sy3WITdHfntBtn3R/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:45 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:45 +0000
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
	mgurtovoy@nvidia.com
Subject: [PATCH v26 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Fri, 21 Feb 2025 09:52:17 +0000
Message-Id: <20250221095225.2159-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: f0aba007-6514-444a-9bb3-08dd525da16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Df3MtISQ54v4JkgeMNa6+tq7KD/yYYhMgJ+Tqt78qhDryRZpMW3h1uWoD7RX?=
 =?us-ascii?Q?vDRywGnyTFEPsFGolpu6142H2ZqGElwpeq/D9OtA0R2umuQZ1bSsnjtUfd63?=
 =?us-ascii?Q?l0YcChA5/js1pR8e45EQKWcXX/oeFRoh+/ct4iOowB7xhgkLHDdusZbGDm5N?=
 =?us-ascii?Q?9Go7U1iVNtBewxEFMqZnqLp22S1mN4F9KgfhMPgV4XVgbH0rKBnu3Yv5S/Vc?=
 =?us-ascii?Q?t7VJYKAc+k+cAjk9XcJujj7n8ccinVbnYbmGq2iDTArWTGetn5PMn+bSSdjh?=
 =?us-ascii?Q?Ks+lc3DgiLPjf1DM0cDdYwg0KvRf6RcHZKTlrP1+Gr6WV9qh2lSc/uMZfIDi?=
 =?us-ascii?Q?6w7LX2+8whYPfRX5d9pqcAv3Ou2z50wEktSpMnKA7k7eslDlYBVyI4HbK7vI?=
 =?us-ascii?Q?FvHs7e/dLdgksh4jGImlqd/iJPxTtDjdAf5sBdbN356p3Q7g4ok+sxWM0uXr?=
 =?us-ascii?Q?sFeq4eFmJNPEA0xUWXq/jZI/00ObYFrjIWnEMIvGo6zyGRWlH1ocP/ZM41Ww?=
 =?us-ascii?Q?Fp8CLVX2VAZHSZLxRKKt+s4z5zAG0bMoavSjeNTg4l3dY6joihdtZCQ7u2Ma?=
 =?us-ascii?Q?jXW2QGrWD+tXqRfR5nXUPMJCWx9rwbNjWU/78TG35YzinXSZ5YfWJ6dCSRgA?=
 =?us-ascii?Q?Nn6L7NpNd+O4dUI9SmHKVAtejnnA1SakdEADOtsofC8QNRZMzshMCET6W6Eg?=
 =?us-ascii?Q?3wN1oXVNSLmWZS5eatqKYKjAU7edhE2nJnHVEBLjb7bsIdcw1CJ7VpAYS9oW?=
 =?us-ascii?Q?zaRwfozKffb7uetx/xT04jKzjf5A6RoftZDXXPFysdJwskpJVvb7nLBp8rOs?=
 =?us-ascii?Q?ADf6dh5zSAQRTBqxqPGDmbY/foIWiTnvY+2qyoUDItqlmMvfHpnn8SZQoCA/?=
 =?us-ascii?Q?Q6AYoBCSP/8LKgwlMnS8FSnGewHU13PI+lSOx7QYgEwLu9psXNVv8skNEPwj?=
 =?us-ascii?Q?W4rXKv+i2+lkkve7o6HdlNoCA4wgAQYU0j8xvWLHVgGbcaiHqiKpfSylaUAi?=
 =?us-ascii?Q?Dakgzw2RtAr4o98Mlwg5Zht6FBChWd6vVs6/358Mievjvk5adHUU6yry6xwS?=
 =?us-ascii?Q?7LGll+k1LJmFMpTfUSXec7hZBL9Ej4+uZTaG9ges16ycuDeBYveumt21dUJf?=
 =?us-ascii?Q?RkPO/pyuHSp0djxuHyph9Vl/dicHI7XDeW0RwyYiX8gXzfbsKiggkBzgD6Wz?=
 =?us-ascii?Q?d28uOR3PZk+exSZL+0j4/Ign9rwbD+TbGejnCQdO3vqG9il5yxwxW4F6HTkv?=
 =?us-ascii?Q?sfIc0h9ki4/wvFbgosDjPcqVat0TYx+Lo0VxHeKiQrpdGUI3l4I864ToHWS0?=
 =?us-ascii?Q?Wx4grHKKBR7cQONm7OGr7l4oV1qiRQ6RuLWEPMcAZX5rlOTiKrV0Fy7a1JWh?=
 =?us-ascii?Q?d9EK8RzHV2e5AAVAOANPwU9kuucz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GCqf/U15m2KtDcqTCp1AiMhXT6+qpkmgDQZC10gffrgd206naoO7m8j0/DA?=
 =?us-ascii?Q?g2ziU1vLHwuLvXO+GHZZsnEAg4yuvlmza7rA6/Rq+HsNc0Lz5OHsTajgkmB2?=
 =?us-ascii?Q?Q1kOQ1dbLnXVTCxt7G+QuPOE9CIKghv+5cQQopeC9w8Y5G5iBosU8m9MGsWT?=
 =?us-ascii?Q?rg3qiZxyytrFxWZZNB4FgDN5iVgeSV17Ux0GehX7e4Ii4KyEVymUhsGbpHVW?=
 =?us-ascii?Q?9vZA8y/lqxWVK1o2h0kMdA/Y2UfAclkqDtl87YOfGz776fMtTE9yG9DLeiYn?=
 =?us-ascii?Q?/HqPXqEvFPipRgLuN83/8qhKSzJWJerz50kXMh9ekseumUN/xQ/ptRv31QL3?=
 =?us-ascii?Q?LvawP+fJUXqy5xFx41RMv1R6SSrGdEPlbuSAk0SV/hYLxB6YwgRKfLYnrVLB?=
 =?us-ascii?Q?rZ7/N/xMEWviCGOFvereviUWkYUyFOc3O+nI3KVoVSirrN86TKFq3DYedw1v?=
 =?us-ascii?Q?qRWH9EbfHn4Jo0Zzh7HF9K+DgK/MHI25jL3JAtA0Gp5IVEs3bq5d6/5CpXHx?=
 =?us-ascii?Q?8sWsegnw7FL9NhkUu0kDT+BwL4GFkpCOgN6pW0wWcbyBb4H2t+IioAjlWk/K?=
 =?us-ascii?Q?eMil6739Wbu/QEjxzo24FblGzj/mHETeM20WTSoCE8UhZ+JRXsL+1z5xe0an?=
 =?us-ascii?Q?OuaLtvLoNXD+3L4RIs1umi11Xhaa1A6qY+fWD4wf+b5g8Fy59rbZxZ2LU7ap?=
 =?us-ascii?Q?+hmtf65QKN6fY0eXCwS4W+39KHC3xW1jWhkfkD5uv0Dp+wOgQ12k+dyCEo4e?=
 =?us-ascii?Q?YDv6bYh2W9Z7JEKUQWthD785OiFUgut+6/Xlf299vVj1lSN2sHR6WIRqI1xv?=
 =?us-ascii?Q?Fbspqhk0UJUF09cbD+pLrFuFTKj7RHGCVVcxKaPJfLSH+8vmaV1WmpV3iq8W?=
 =?us-ascii?Q?mv5RHd7nFZxHa9cWpwG8J6yikw0IgdFXi8EFIAi2vuSmHXnQgW3+folRlePN?=
 =?us-ascii?Q?WM5pWwRTcbiBVIEnLCfIFL3YE/LW3zKWxPPBjkJpB7wU31s5l2Nyhuw9oN1q?=
 =?us-ascii?Q?4Idugm3wfGt2pdGNsXnHFEbE7IeRYmukULvN9vzCDdLW+NEIBtGYhVHq1pNm?=
 =?us-ascii?Q?bxAuwp+YOeHhlTE+VSBXjTebFOvMpAc3Hd+YWnDimTV3Y1o4bh/2pf9kJVtV?=
 =?us-ascii?Q?cfkcB1PyGTofzPRXi9XuagEjBVlkpZQBEL5n5/FlVP+c+Dras3KECPL02BxD?=
 =?us-ascii?Q?pj3eaBDhxL1ghqr9glIp+jJ+xjrM84vFxUPdeQTdNyIT/qdrIQjW35977oco?=
 =?us-ascii?Q?Akoy9qMEk91lMDqTVlnHBz17h08rS4X1HQiU4PBPI1YzFwXZu+vib+rwouIb?=
 =?us-ascii?Q?nc09X8cXAA2Jq2lyLP8YEMWGx+CRGpsRL2+jGzTCVFu4FDO+n7SuOX3egImV?=
 =?us-ascii?Q?VXEUcKqfBiSL57fG+bSb5JaxEuZmGT9x0yV4/ytxPVrO9OulPcphfmHgYbm3?=
 =?us-ascii?Q?T0PtaYF7tLmG2f/lIf8BxbwsgULYWKBi4DU6bBXFzHmBvzuvuiCIJ/fP+OFr?=
 =?us-ascii?Q?Vov6d3J2WmO9bK31HL0Zp9fpRfw/fKled50ahLovzj1W+iYx5Bb+fZFYnbvp?=
 =?us-ascii?Q?Tju2JRpMPkLQxtHf7ofMFuVYebydlcpuTJlddJob?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aba007-6514-444a-9bb3-08dd525da16f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:45.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDDV5vCniczCGDFCR1a4NymDaLm186nVtZTBo2rawqWvrif0cCYguvY/U6KSKL8/o7uJe0wFVTEg/9QpavgWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index b253d1673398..045eafd0167f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -287,6 +287,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index c1c4589794ae..23c3af7f8b68 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -265,6 +265,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -820,7 +821,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -869,6 +874,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -904,6 +922,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1244,6 +1284,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
@@ -1474,6 +1515,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 2936580c35da..8e5ebc792896 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1596,6 +1596,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
@@ -1623,7 +1637,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3761,6 +3777,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -4013,7 +4030,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -4044,7 +4063,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12490,6 +12510,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12497,6 +12518,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12870,6 +12892,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12883,6 +12919,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12905,7 +12948,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -13225,4 +13281,15 @@ struct mlx5_ifc_mrtcq_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index fc7eeff99a8a..10267ddf1bfe 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -228,6 +228,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


