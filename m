Return-Path: <netdev+bounces-109926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F399A92A49A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241181C212F7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B013B7BE;
	Mon,  8 Jul 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riT2IpCw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9178C75
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448812; cv=fail; b=GOuLyQmwCRcz3aZ3Jh4E7XDJpX9B8A4RYgrOrhk8FCwF9iX3SdIoqr/ZJsU3U6tO7f4hRgNVavJ54IJvZaVxcuVtGQmmxR0OmTqGgt1KqpsMOpSZ4xl6jVGgcOq9JRyq7xJbXFzltiwUUvHXuPNghWzB+3xTm4Zp0A0sprS7EqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448812; c=relaxed/simple;
	bh=N5sMfDbtA4gHxegq62Rv9X736i8B8UGV6QzOCMEUWrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYp2ivYZxH7jifuf2bw75Qn4IonDcqY8sOxHq50LrFJhgTg8LREz/rM66kVKQBaBrt/N//66MrpToYc05Jqy8rL3PBTnc4iBmxexbtTRUbNTxo9BIGRE23LZVOEG324/wNup0c9gWVhqP8TKC9dF/pE458gjyqDXI+qhy+bNqMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riT2IpCw; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONjKTUzOPkCDdGvjrir5p+sikE5Q7ACwoYXpXBNIW9EDfSby3h5miVgdABVWtc2nZe2W3pnIoOd//TJcCqaOZaqYxOiQd6oMp8TNYw6OJPmTA10B+pj/OmTdJSi7Lgt71wTgzYMU19RB5p9D3lwUNu748nChqilw1SMdhZ3JtAb5brPdRg112iwC5McgFpDVJrccCkOi5aF/gXxOGf27hwLf0LFoJtOkw/lpDG3AOwYstiEVerOISRD1Uge74TjgyPtgikOyMUIvZc7bxY2qUFTXDZ8qonnpnjjzTkAzyqD4cDih5a/k9hw6Tesru3pNNJAXJ/kh6XcswlurzDTT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3E2qsYq7ZfrRI6LdJl7e3ON8xH0mY3qWoSuadfDx1U=;
 b=VoVDWCBbRyJRh5vuujUO12+YlPgqgHenQ6VoXTowVUdq6cTseTIvWcq25BKBHsXXVqzTRvr7fZ+6ye6Zqjs5xY8SQsrMjyvMBIEgO/fkktaM2YsMoJsdWakKqPD/DCDuyggAMIBC1r3C8Ja3yRQVuNjh3hDgwnopzFbBginNVMnOvYyilogJkbyPnwRqB2QonodSpQqCe7o89b2crG5z40BCx/q3uOTDA220k9RE1S3jVlutHOjNtVWoqt+qW18EQJZHyag0vir5Ib66C2VkUvmnj3tG9QQWZgLZbY+ruDhE+GHR3HKkjcMqz2rfV3JekhosFT8JNfEF/l5JfBpzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3E2qsYq7ZfrRI6LdJl7e3ON8xH0mY3qWoSuadfDx1U=;
 b=riT2IpCwWLCNG2pMOxRICaIv4UHpCjIxKyGdBuG49q/rC12ZmL3++sBSWFt7RxhTxyFf9hOAKUsJjkCTW34BVWEsnbxkAWvttAqecLm9sAdooZr61NM9sTFst+s2iznh8O83Ap8gEFmnmhvC9W/20RlPC7KmmcI3j6NGA9xfWrzpq/aMyajGrRSGnmAfbfo/XPnBePPBjT5yjVnYbVTOJhZR4TkwPDcxI3rDcKLf6y2Fbsd0tN/bucHQFryLQ0rV2PJJlUb5Xl5sBjbv7v0ZqddYyaGnzzKEQcAgy6TmbCdGC5ClbYpmP/3CjKSOCQzvq8gD/8i9F43Hhr9huHzvTg==
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 14:26:42 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::d5) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 14:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:26:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:21 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 07:26:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/3] mlxsw: Warn about invalid accesses to array fields
Date: Mon, 8 Jul 2024 16:23:40 +0200
Message-ID: <b988fb265c2f6c1206fe12d5bfdcfa188b7672d1.1720447210.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720447210.git.petrm@nvidia.com>
References: <cover.1720447210.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb6634c-c4a6-4b01-c20c-08dc9f59fc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Isbu/RMWY2K8o6S9b6uH6jVZ3XJ43vjtF/0lFFbLQU/iY8ebZbNTehbE4GQ?=
 =?us-ascii?Q?Hm3w6hqlOHyP2BDeg/yNAI3fO2hC7Bvr11aitDwlPdg+DC5XwVuC6XYzcquG?=
 =?us-ascii?Q?Xrp4FEr33PKzR2Pgub3XaBiC/1mVmvIKw2g7564yYuKe/+3gTH04kkw578nn?=
 =?us-ascii?Q?p1UV1uctQKREKPu2NrhM8uatrueHSXdnO7jk099Gwm2uxgOSUkwTrJU4HlsU?=
 =?us-ascii?Q?zLbiG5b0USVyG5R/VBnLoe1M4U5VciO0v6U0w26OID1J0IqimnjA1jKNM6e7?=
 =?us-ascii?Q?+5kUhSCq2K+X7IxPnuBqpSYMpzIfaMcfTRZMzpteVVR0LbMao9iXYkNPInus?=
 =?us-ascii?Q?jc+78l0iJhIuueCrFsqb4cV67OD6TjtTV3Wxd3KBMXE82819xbyxzHxf9G/O?=
 =?us-ascii?Q?9XOaXaVk/U2J7CkWBZjKVJ+KE8sBiMM5dNHSj/pNtUl5crKiYEsAiqhqBxr0?=
 =?us-ascii?Q?/YjA5DleIbwQOyIm6I5T1x+2xXazWs7g/Vx4Ef/RVe4yB3ca/DfTUEoFpZ6O?=
 =?us-ascii?Q?Mjva16qgsM+NbmwMqHcxSFeRxo6kDkANaSmUwtWv2VUvW6jI1uFZXD4VgyVd?=
 =?us-ascii?Q?Plt4b7bxx4G+UKYo+riN4RkYcP2YC6NZL1xTHTHiD13NDkBMdBD1Z6amDqpn?=
 =?us-ascii?Q?DnAygfvhxhB7C4OdqRE4NQr7J/nTmw078UHaQa/K5Z80iEYO5zdfqyTPXRbW?=
 =?us-ascii?Q?5QTCSHQ7VbhXDGn3mFMFKMIMUqGd3SfZBLGkR71c9PM8quWjdV2/3QwbxslY?=
 =?us-ascii?Q?+QKiNEiRCCe9FjQtKoZKCXA0JAx+G7B+zCvP8qa1KXiej9PYhU1D1HZ/BK0g?=
 =?us-ascii?Q?YApQFtUsJExXc1n9aRe8+hOg2C7AsZtVG52EFrdaORZPnYB9QISUIu1A2cPE?=
 =?us-ascii?Q?/SgN3q3h1xCV8BZtidEtrFHM8PJUKa+5HHzMiPafVZ8KVmqun42BbDDF5R7L?=
 =?us-ascii?Q?dxh0Hxx491cAXG7yLnGDXfqEGScQPs2VuMxwxGNJekrn10902jWkClMEfZRp?=
 =?us-ascii?Q?SQgmm4PX2KwwyXWS/JwwBsCKme/NuN+yfI3yjboyD63JhLu/jZPXiJuzVSu1?=
 =?us-ascii?Q?3e3CMQ0jzbArZmpCrMpZaShG9B72dm0AZPJIdOmBuPOv5GOShz0q0bfatBZf?=
 =?us-ascii?Q?Svmc/V4PpudIsDqgYXokRn4/sUV6jAYhk2V6L8m9vyaGM9ga+o4S1r967A8Q?=
 =?us-ascii?Q?2lIQgc1GgGefkLyLterJ9qzCZaUjUCHM008Z3ZR7Y5yX/0pKQkyqhamf9O6E?=
 =?us-ascii?Q?V3qMd9FKofaKtLm7A6C7GTUorFXZcy1sn1MfLvDGFr/BEpSRp3f1ImT1gD7Z?=
 =?us-ascii?Q?zXSyBGP+X4Xxd+XGJIftRjLHzKK0Wieb16rzuqxAklQbvzBva8T1QZpdXB7g?=
 =?us-ascii?Q?4CjoFUE2DDamRPqaOLfKM4739Rjo4RUUATsIPOdudBJEkGrs2/5PUKpJjVii?=
 =?us-ascii?Q?dPpCXEGxl5Bk7bPKiBDAqXc2dfsJrJZD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:26:41.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb6634c-c4a6-4b01-c20c-08dc9f59fc8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

A forgotten or buggy variable initialization can cause out-of-bounds access
to a register or other item array field. For an overflow, such access would
mangle adjacent parts of the register payload. For an underflow, due to all
variables being unsigned, the access would likely trample unrelated memory.
Since neither is correct, replace these accesses with accesses at the index
of 0, and warn about the issue.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - changed to WARN_ONCE() with some prints

 drivers/net/ethernet/mellanox/mlxsw/item.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
index cfafbeb42586..a619a0736bd1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/item.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
@@ -218,6 +218,10 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
 	}
 
 	max_index = (item->size.bytes << 3) / item->element_size - 1;
+	if (WARN_ONCE(index > max_index,
+		      "name=%s,index=%u,max_index=%u\n", item->name, index,
+		      max_index))
+		index = 0;
 	be_index = max_index - index;
 	offset = be_index * item->element_size >> 3;
 	in_byte_index  = index % (BITS_PER_BYTE / item->element_size);
-- 
2.45.0


