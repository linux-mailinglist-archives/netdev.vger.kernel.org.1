Return-Path: <netdev+bounces-116468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D79294A887
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8106285AE6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556091E7A4A;
	Wed,  7 Aug 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2uuQ38t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A71E6743
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037144; cv=fail; b=Q08KSfzjSnsiR+FpAOCvadJFGSimLa9mkuBwUWex+KCzDCSTsnmqsMWgHDduoJm7vvSiBhs7BiaIc8t1Tl9z7ZiwJpjsjL6IvVwM2XcwILjIcM7JZBZj58QBRNuGSuLkO1tI/nwCRF3Go3d+YDm5VkZKHMjvDIds/2Eq3IuQ2mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037144; c=relaxed/simple;
	bh=6eKX1HsEk59QuSJibG6qaDRQSLrwdLOlj/ufDR97l0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tlcTy3Q/81yyHVIX4Oyv+mA916mtq+meIi1lktrzOtHBsWXSh5aAV0YdbLU/Mj2rRH0OnqMQtpVTHlcR7VhXMYPhM7/SG9O3xKqtXTpxe84WSFT/Zl2GBk6yttjBNPBTgWFb3U/uU7DvkXX61XJJabiSJ9mjPvbeNspOSOnSMC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2uuQ38t; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCgB65Sf8+qD6SLl5CTZ//bCZ5c4CLZ3fKE8iM3aHbB6+liLR962+7mm8FYC5rK85uUnwf0tJtiYBU5MhvIY24v08ltLsNp11OKUCpPCWMM7lY3XE8Q0DyozQh8e8XhNB62WCfX8Zcu9DCftwyio4IQnY9BTmtWneQbaPSD7oevqWVZynnVGVuuhGojaR2WmVz6RYaSHUCGL3rZlvpeyIcpHruTpAViNsBV28sxHrXiWevb+9NULOyLhNrXExE92fFyZKJnxe+OWLLsXyF14bbym8x9CCY10FiRbBVb88FxIuxAZMDYEnuUNwMzrsqFa2PaHLQtsvuOvXHzX9D/LQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRcwP7cCTMjC3b4qoQMXToZatiSb+Xv+1e/APOh0IRc=;
 b=Ku2XAHGLRdhfYKUxHIotagCZVOLmXl4+T2ln2rz6FfUbJZRdTMsRy6O0s3xVkxp75m/nwH5hdAYXTZSCBbd4f0UGPlkUIO0rArWPK3D00T9DFQ5m+P/J0Q36REkaU8wIOM4t7WPJS7nTbAHob9grMGbkAEtRAqfp6Ae0GG9X5EbcL78a0oCf2UeQfEjNuq4Y+jZMpXjdiPj0j2/NmokYWspjbDKQsAGQ8eydhyjctgooxw2q733Bbmqk62MrC4M8QbQigU0HXsuQqpaG58TCIy2uLGgF/75XkeMNSkkoE9Kif3Ct95e3Ywpongu4ZckYbOAoR2Vswi9JvFUDDUB4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRcwP7cCTMjC3b4qoQMXToZatiSb+Xv+1e/APOh0IRc=;
 b=a2uuQ38tm5/mw4iI/Z5nGLgr474Ln5QLKp6GcfW36ekta3moEPtZOPw7mzSH2/fkFvDfz8qW+ezdcopAdXSDO+wA6xvVwyiLX91ogyGTL7/dgwFNtQKAMnHoi0EOgKS02FQLS+A5ZMxc/A36ip1moIE0DfpBQQFHwMojmGnDVi3b7boqdUcMZv+c7+hSyFbd/w8+OUUl3ISs5Y8sW5TUke84n5lhBOV1qE9ZMKMtlcIa8SDngh2OBg4coETaLoQpon7C8dN87ntQPCeE1Fc20o69LR4tJqFvMcANoh6o026FIyBleYMaYpAwej/1pDYWi1Od+D3ZExgwcTrjjXrONg==
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 13:25:39 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::81) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 13:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 13:25:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 06:25:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 06:25:25 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 06:25:23 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net] ethtool: Fix context creation with no parameters
Date: Wed, 7 Aug 2024 16:25:41 +0300
Message-ID: <20240807132541.3460386-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: eeaa46bf-c777-4786-c416-08dcb6e46d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzR2UI9bTkhmzISiwGgCF9Jv98cUuw4Sy9iSOhmIuQrd7Bj6KPcc05KdTP5T?=
 =?us-ascii?Q?V0JYqZbvQl4HGRAUNxEwPrTjbmRwqMonZBsmdPudh7VfslT8TjxWDvhQ74gL?=
 =?us-ascii?Q?RwPic8nIA0DDNEGR47SZNTYHRYsxqnBKZmY5dIil/vm5aHyt7bNkbsjFpQVn?=
 =?us-ascii?Q?nNjx8CpQeBdW0lZ4bR4UvcV9CDjZrWjXKOqwc/+OYD8pLpdKmMwgk88ORPSU?=
 =?us-ascii?Q?bHkXUQ2eo+mmnqxrXl+Z7Q0KaoqAaWYFHofDrk4xW9HfsqqZOv3ZVAdjZc/o?=
 =?us-ascii?Q?bGWhFFkRzdTsXX4hyPyAHjvqgEiSJecAUgU9JVDf3Fi57cMxIUXkTWpTCs3M?=
 =?us-ascii?Q?SYrg5yGu43cz0CI6c+AQr2dSJFkEeTBDosT0L6lZqYaf7Y3n/yH9VMlBr3XG?=
 =?us-ascii?Q?6DzSJogttW9rq7pRLHjehjkkT0HnalKeS1C0wXa5IZYm/oJDwInIRyFouZOk?=
 =?us-ascii?Q?OH3s7TxLtEvEm/Ft6qiJuc4ckNpsKMuS7ERW58nmcWxFELZ2jSHWZwQu/A/p?=
 =?us-ascii?Q?2bf7AMsZG7lBFRpV2W7X4ODIWybNB4gcCJZsaDTIKY3296W0adtFAMFq9ihB?=
 =?us-ascii?Q?zqZthOkwOSLx98/FkuS9EjaKEt9Huy9ELviqeg0A35i3F3avrpKmmVF4kz4d?=
 =?us-ascii?Q?DaLiXkV1qOcQQUWA9rjND8+Nj2+zqT0J+2YbyK4TStNb7O/SOQzkqun/abDE?=
 =?us-ascii?Q?zVI28RIwjWgHC+yhM1wCzGYSesjPFoqbeXxHjWdzZafV24wrGJD6V2go5NsT?=
 =?us-ascii?Q?ba8UaT/wF/vudm5Rxs89qlO1sk2QROFarRuqMRrxCKkfXCopyFMt7SugmIM5?=
 =?us-ascii?Q?roui8idmhfcFFRvGVW1KZ4BX52h9U5rXE4I5QWC+Z5OlKOjdVbJ45RLC7nZA?=
 =?us-ascii?Q?al/CC8Gz12fFZoNM2MxKs4GkeJYS3QBJQVs1FVA+HV89CIcWeKcOvhCUCNHI?=
 =?us-ascii?Q?s5KhNYgqmO/9Zyf05cK9DKmdBrgqpfA384KAQAS6/YrwmPy61iCO/Wtb9hfm?=
 =?us-ascii?Q?zDInamF7rmTqTW5Hl+jHSmdIUyIiGsUz1xTzFKvhbTXFMEreYD4rnQYQInBK?=
 =?us-ascii?Q?6IdHbhxomu24J5cr2PVXUre5dwyR3AktRTvvzLaz4LX95MY1BtEH+F3lhnfK?=
 =?us-ascii?Q?UBrRzKX0qs3ui/mSkG2C1ikXWZp+Nm0bF9FJrvQikNFiD3e1+L4u6/5+c5Pb?=
 =?us-ascii?Q?K+91HDMPM3RoppGUNmQt6NJjq4xDULaPCCtVargn8UCiSoERfsOhzJiXgBwN?=
 =?us-ascii?Q?HKX33YiKrSg2OsUOGGYjDf30+JHKjnqV89u+g3aaIalJpv+3SYgnMkCr8Y2h?=
 =?us-ascii?Q?rFgwJs8aLvg4iPntqgs8Fxc9U29IU0/Bo4BymvqA996VG+Ly7zUl+MQh6D+p?=
 =?us-ascii?Q?Nyrl4teVkvTqe8Jse1tN40/nRWpt8Sc3cJ9uoF1uI7dIKzrO+ba3PWqCQczQ?=
 =?us-ascii?Q?ks8E7i13fwHiw0dvZlP6UUylJEevLCsm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:25:38.4739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaa46bf-c777-4786-c416-08dcb6e46d90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

The 'at least one change' requirement is not applicable for context
creation, skip the check in such case.
This allows a command such as 'ethtool -X eth0 context new' to work.

The command works by mistake when using older versions of userspace
ethtool due to an incompatibility issue where rxfh.input_xfrm is passed
as zero (unset) instead of RXH_XFRM_NO_CHANGE as done with recent
userspace. This patch does not try to solve the incompatibility issue.

Link: https://lore.kernel.org/netdev/05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com/
Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8ca13208d240..2fdbdcfa1506 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1372,14 +1372,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	/* If either indir, hash key or function is valid, proceed further.
 	 * Must request at least one change: indir size, hash key, function
 	 * or input transformation.
+	 * There's no need for any of it in case of context creation.
 	 */
-	if ((rxfh.indir_size &&
+	if (!create && ((rxfh.indir_size &&
 	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
 	     rxfh.indir_size != dev_indir_size) ||
 	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
 	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
 	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
+	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE)))
 		return -EINVAL;
 
 	indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
-- 
2.40.1


