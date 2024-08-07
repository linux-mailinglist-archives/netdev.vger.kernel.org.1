Return-Path: <netdev+bounces-116507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782B794A9B2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB49DB2614F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACA78C9A;
	Wed,  7 Aug 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6cMMCOW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C478C92
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040080; cv=fail; b=qusuaDu3hdU3EGI8vyKtfXJTXh1dTSwaxO+p3Hc/1WUetlPlvRQiyAMfJITK/PXoy/kqcEh/XtcK3TAdbb65efbSHgLWoHDZsPO8VQNPki2yhhiYtww6fCyv38pL61QsQ5sDyfdTrN+1nlz4ureDFrTwEPzGq+mUNT+aBNY5P+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040080; c=relaxed/simple;
	bh=WfqcAIdgR75NO//WpDghkNZmarC1NuvyxPmAFlhX4rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHINECbTzdD/BlLYCy9BXXpY9mHi3kDv1nZkCom47B1yRxCvQJiWWrhix6g2jd1knWe4XEk7aNs1kd3e/5/cFYF4fUR5+05cxw8rfDuII+bt6AJgJbA1Z8t4p7j8MpucQ6vXZv7+IeOB4PrmvhCU3hUuXAF52CoNrvUZ6Q9kzzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6cMMCOW; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chpUYe9ubH2gfH3eYSwoIDZlzZ1NnIs9he2gSiHa2F3Kc6B5QzO7hHEZsT0o8Q9DC6k9f6xv7eH4eJMrgE0Vp/x76V1ITmAlk63i803lcs/3kgq0Fno9MTq7YySCcJST5HqetlVUAXlFc/4eJLWJxyfUK/NAJlqypYGf3QokCFwVIVKxRkyYETRRmEvWsc8NrHl2QFmbpT6xz7vQrNKr9BYokw7oSqWMeSEE6HgyZR+q4ZD5xTIdqV5hfiCCHYy22rgpuaCAFSr5AF6RU9AJzyNDKjStOLUgaeDuJ6M7B/sJzLYhsywqx6ojSkBS5YeJ3mjxbkVhDdtHfGJ2KF3doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onmTDcN++S3YB52BX673SxoM055hAUa+115D10Xu5s8=;
 b=tvMgXLTxIbycJvwDaqCYQb4N6xVwvvkjofQuEahdvUpfhw9bkZ8caUEQvUT26N9fQE4tbJDpl2tEFOaMFstJyoWUsAaViEkW4mBMJ+AkAoy/q4mN9GtB0MCDrPSUU+RdXNxA+Qw55OVA8QIyQC9WwlpBuWyZAoOY3JE6EFneOPlbUHYZlwHoGyPLjho+b66qnYXxPb495wgkrcmVKQFpCq308BMzrluFTR9VdGC1r578890Eb+X6vT267i3pudNS23ZZQBw2s5f9nXoAHJ3ZA3vmlZ6FQZbM/gnFhJ6ewyM6FEPiX9BuS9xWvtzI4sgrnk/T3UC4TpCNWzj7hulSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onmTDcN++S3YB52BX673SxoM055hAUa+115D10Xu5s8=;
 b=Y6cMMCOWO1MOTjpOFE7BvTOc1qcInJm8dELYGh/GCtum2NfDs5DHkhFedtGOpqooYusCXp0ABbNaZabI3kEWI3AcrLK9QAsM5R3sV3vXmb79xXXuvFCCbnrwjsn4orInvRsB7FYAywyG9L0qc1snpNZouBM2WpxAh7DfAwLVKmrwupL0Dx2/REvKZYpspLx9sG8sHwqafeLLJO++ImEMJ5kuUHhOtFBR8hWtCFNRybyDC58Lq1Yu72M3e/9X3A5za95uiYjqpBrKaDeX0r1gIsCMaSVYY2mDjbXMrH2hxNmuwlmVVbAqLXvwfSX5/+y/x6auaFT4lTeqzPVdS7wbuw==
Received: from PH7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:510:339::26)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:14:32 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::5) by PH7PR03CA0001.outlook.office365.com
 (2603:10b6:510:339::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 14:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 14:14:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:15 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/6] net: nexthop: Add flag to assert that NHGRP reserved fields are zero
Date: Wed, 7 Aug 2024 16:13:46 +0200
Message-ID: <21037748d4f9d8ff486151f4c09083bcf12d5df8.1723036486.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1028bda5-0e4d-47ed-7614-08dcb6eb41df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qpxfjfxu2sN/PtfvArZZ9KRew9inpW8rKHP9PaC2QBoH+IAGmSOYtIzTc2zJ?=
 =?us-ascii?Q?oev7f20xLXneYHRAXDjq/iDrkJiobdYT9+T3Mnx9aH0kUKhJ/Inqph/RCgve?=
 =?us-ascii?Q?ZOssof5gA0lFOpYafkUkcuIacWO+NAOvllQteveYNUxW8MWOh38V1OQQDvYL?=
 =?us-ascii?Q?5a6sI/xffnC36+tdBwc6VtBPVKJIf5lkocHcz67km7tLPCijGiIKUckhVynp?=
 =?us-ascii?Q?ONVzisRkb0bE0gCK6RbI9xZAi0mMN/zsQwQ9d0pkNIj9EynHMu6fGfSPnQVd?=
 =?us-ascii?Q?E0uRS7ZdmTxHmi9c6Je6/TggovadmSmhEws2YvnoZE+47n/WaHyNvdr2yafU?=
 =?us-ascii?Q?Yb+C1R8kr3DDOBxoTmGxbmOFjWSvndRgexPK8dZ35WIlFDRErpu/iGBG7EAK?=
 =?us-ascii?Q?ieR56NVeubcgHz8166AP6taDaEeer9OBwXNd9GJITSytiQ68E9ZzaCGwHUaU?=
 =?us-ascii?Q?15S74L2oJGNbT2aaVwl6fu1B1rRts2LtLQAHR8vR82v7ltFa0wttBSLJ/jlW?=
 =?us-ascii?Q?EQcJJpgMrE2A6GvyIKuaIhzMEdQ8dHRialJEDO5ZShyN/dbjO/tetpY5oQnW?=
 =?us-ascii?Q?7XIEAdIeDDQ2k/Gqrek3918mZORRbBXyY/VYcwhoY/54sSmDClV3ctEbD9kv?=
 =?us-ascii?Q?qYxwThREiWCsPw7CNWupnyrYDKHvV1+xShMzoqQHKkcMQfMhNtb1PkX/cN7H?=
 =?us-ascii?Q?+fv8B5GnWZnE8TSwZ2sNUoMyZ4ktgQEqjec3wpH29XYNFMSfwzsT/aahxrJh?=
 =?us-ascii?Q?PAGXKqiDh5aZnO0nr1WVdHL4ad/AjMUxiOzMHSgCqoTEq5XIj/YnIUhkXC3c?=
 =?us-ascii?Q?bR+Tgx3fElpt2gjcrOTXfUdKM0dATV0xbXdhVB6+OiLsqlKJHid15TpzWTKi?=
 =?us-ascii?Q?uPJ9+42E2NShkH/yhS+oGFZf4GL+P5uJsqaDNtD2FaCbewl5+m0cel++tM2x?=
 =?us-ascii?Q?duLdk4mqPBLxVePXkvA9sqJuA5AOQWE+OnWfXnkko3BtJRh7MqyN6YnsUGKX?=
 =?us-ascii?Q?LEpvOLxyLACZOdjq/eWKK3J8uNn5aLWHtUaAxRCXV6xwBxLSUyUY5iy9E7rH?=
 =?us-ascii?Q?SZacPrCta1uX+l6GCTlVeQKHXPPWvU9YvDenilVY+pHw3Vd0+Hk40E3LweKy?=
 =?us-ascii?Q?VZvK4IENdV5PzTPgEr2pVK2H3TPalzIfGwpvOyMrWHCRTAnagLmxWMicy92X?=
 =?us-ascii?Q?kOZQMzeODbcu8OdPTc9kfsZkK1hjyfWwkPin6+OWj4G3oXeftwwOVlP0w321?=
 =?us-ascii?Q?itEmUGfRKYrMaOciZnJbQ1rC6m6KxhWt3DjeDETxh2WbMyAvML9otU/NFxez?=
 =?us-ascii?Q?2N3D8CV6y/Ui+SrIq6pqpE/f00xWwivzortIrMMamkT9OaWkwTPGRXnfcn+S?=
 =?us-ascii?Q?ei8UKs1Ej7D6CSNk1m+O96wjP+3n8DDrjL3pTxkEK5BF1GnNcxXdCCk/0Foi?=
 =?us-ascii?Q?TToafQyiBmmW6DQlEGw/cLF+FD0NblvC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:14:31.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1028bda5-0e4d-47ed-7614-08dcb6eb41df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

There are many unpatched kernel versions out there that do not initialize
the reserved fields of struct nexthop_grp. The issue with that is that if
those fields were to be used for some end (i.e. stop being reserved), old
kernels would still keep sending random data through the field, and a new
userspace could not rely on the value.

In this patch, use the existing NHA_OP_FLAGS, which is currently inbound
only, to carry flags back to the userspace. Add a flag to indicate that the
reserved fields in struct nexthop_grp are zeroed before dumping. This is
reliant on the actual fix from commit 6d745cd0e972 ("net: nexthop:
Initialize all fields in dumped nexthops").

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Move the new OP_FLAG to bit 31 to make in/out confusion less likely
    - Add a comment to the flag

 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index dd8787f9cf39..f4f060a87cc2 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -33,6 +33,9 @@ enum {
 #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
 #define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
 
+/* Response OP_FLAGS. */
+#define NHA_OP_FLAG_RESP_GRP_RESVD_0	BIT(31)	/* Dump clears resvd fields. */
+
 enum {
 	NHA_UNSPEC,
 	NHA_ID,		/* u32; id for nexthop. id == 0 means auto-assign */
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6b9787ee8601..23caa13bf24d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -865,7 +865,7 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
 }
 
 static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
-			    u32 op_flags)
+			    u32 op_flags, u32 *resp_op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	struct nexthop_grp *p;
@@ -874,6 +874,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 	u16 group_type = 0;
 	int i;
 
+	*resp_op_flags |= NHA_OP_FLAG_RESP_GRP_RESVD_0;
+
 	if (nhg->hash_threshold)
 		group_type = NEXTHOP_GRP_TYPE_MPATH;
 	else if (nhg->resilient)
@@ -934,10 +936,12 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 
 	if (nh->is_group) {
 		struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+		u32 resp_op_flags = 0;
 
 		if (nhg->fdb_nh && nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
-		if (nla_put_nh_group(skb, nh, op_flags))
+		if (nla_put_nh_group(skb, nh, op_flags, &resp_op_flags) ||
+		    nla_put_u32(skb, NHA_OP_FLAGS, resp_op_flags))
 			goto nla_put_failure;
 		goto out;
 	}
@@ -1050,7 +1054,9 @@ static size_t nh_nlmsg_size(struct nexthop *nh)
 	sz += nla_total_size(4); /* NHA_ID */
 
 	if (nh->is_group)
-		sz += nh_nlmsg_size_grp(nh);
+		sz += nh_nlmsg_size_grp(nh) +
+		      nla_total_size(4) +	/* NHA_OP_FLAGS */
+		      0;
 	else
 		sz += nh_nlmsg_size_single(nh);
 
-- 
2.45.2


