Return-Path: <netdev+bounces-182753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BEA89D47
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2055F3A9E38
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935772951CA;
	Tue, 15 Apr 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KM/N5+pw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8400294A01
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719164; cv=fail; b=YPHkszrNbOjZJIbk54nm5gNxXWMizPvgj+ZP/H5c7Iqp87fif4j29KgBb8RORugl7/2Gl1ziKJIhP0jc2UI6a7I1s3eHQ6nUMEIDTDCuWvuecu4itC6TZyrzn0LHR5rgXjsDbk3XiFvLFyivkYk0h2CvB7qPrr86gjPWWvAM6Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719164; c=relaxed/simple;
	bh=iZQN2u3E6AE0KLkiAWAf8etHAyTzChWRAuHtjnf7qzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dnt+6M92js3EOLQ4jA9Usu3fmbLXLGUTCGF9Hs0agS72YB+HIGwS5O/lrPOVewEohppDD97LjxewLn0P6Wr4BSCSUVGtEbxDlKuwqzGZyR45MhKqquMLuonpsp9IUyK6wkb1yhCQtYk2i90BthJO+jcsBsmKXS/hocXxn90SRpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KM/N5+pw; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKmucAgic3V//WHl1F972u31g8TIn3aG0YyARK7A7Y+ZDtcudbaBQi6+KUWSsQv6MOIQ4N916+gQDeloAbMvHAJquO36HE/qvnWunqoe8OwaQYpjyNtBV2WCpSpsAfRqa/VeZ7A4qz/L0C902M/UVi2qK2JQ9Ooki/YLiXarkQP4dxkn0hbbx0XFmrlVdbLS82aR4awdT7GdSOuw7fL01B9xiDfqeaq3QZNlPyFP6Xuj/8BnY7E4mf+qVAOGIH1m5lIUXQdkwMjLnbTF8OfPQzBhU8UCwGGEGwbiERMztxHNtI8U4/8au+K18Du47nj4XTCGaphztrYZgZcoJxZZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRv62P+dpSBbSAXe99HWIqBGJac4YCSR4VO+oepCqoY=;
 b=MEY1Puj5YMvueolvTbmRNld5OhTRcqb/HCtWrjlMxVawMUVfKLlpbkX6DVrXrMMp1rUWn0j2Xo8JaWOTcZ/qWBtbzh0LTH4XXWr5tI/+CRqYDIgEqP+6+ilmzoRSN0i0cATXsmzzA7277N16P62SVz5Mz3GD4xsqI2vqTRMCxiE78tYe3eh/OcbevgGOojQgm7EVXlNv5AfAZjU7MAYe/AUWx7xjwyYKnXSYElQJnpM+lxvCMop+D5yo50TxeKWf62jJStLPMIZow0L6VZIJPJXn2+f5wx96O7lcUW1q9mTi22b3Tc6VX34IdwhCkaqx01cD8Bv2V3i+FlHQJSEPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRv62P+dpSBbSAXe99HWIqBGJac4YCSR4VO+oepCqoY=;
 b=KM/N5+pwPpa1BtuESIMr5QP+q34AhJnmO6UcvGKRTXuI4DVppymQXYBBx/8G6mcxvDzVz/XObYYTOkaryrhVl33nf+SboH6aTUgjxkvowULXr30svq+SVbHpIOuwNFfOkDpmkc9iUJOFdb9gWnI7WsarS/y1stouMGKnZBI5AWKU5PObaNwGGeqrbDolUVXUP4XGyByJ+KUND57woxLOS9LxMF7MqhEBrQbO6WU4BhZNE9Oi2pArWor153hP5M93Kp0LKjJ+4YozrqguX+GtXbuTgFULlsMJxBZSK1xt/6fhZtZxcAswde2SG3pLzuu0eX0k62xzhh7vO/t5Bph8Sw==
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:12:38 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::36) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 12:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:26 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:23 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 07/15] vxlan: Add a linked list of FDB entries
Date: Tue, 15 Apr 2025 15:11:35 +0300
Message-ID: <20250415121143.345227-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba9a6bb-b7a3-4977-c8bf-08dd7c16d05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1mN47+gswyaXHL5RCT/XXdB8nPBqxjqyddOz3jk0lrhc7Yik5kySMeSsffn?=
 =?us-ascii?Q?C/y9K82V0gnhoZQ5XjUqnnjWCuGGRSZjvKeuQkEQbMIPzlyK3XFuMH/Qk4Mn?=
 =?us-ascii?Q?HW5yZ1sg7WBNukjctKM34OMMXiwhw12h/g5TxRrAuC1RLjAK4f5jvt4L2QGr?=
 =?us-ascii?Q?wQiy2eQkZM6OhwNj26eTYuTWuV50Ho8Q2ChOKJ9Vf6WfurttyiiehjBVYmK2?=
 =?us-ascii?Q?0rMWFZodCEDh6uFd2AWimLpmXGpaOCnhTtfpZHZr0yBrEHqkyXIT64T1ezUi?=
 =?us-ascii?Q?7jrOHp101VSNB/trXH2aRHQx5s4zi5Ffjhxx0jU0EkIFina1QNpv06jfZI9h?=
 =?us-ascii?Q?UQpGaW/JaD/j67bnpeTjbxfMGZF+krE2AxTSwlTcjyEZSplim7xubYyWLlMX?=
 =?us-ascii?Q?F2VwjHquXyVMBKJucUMnukl/iciuaZf4iuZAJwtoVW56s4WwRs4S1iGSCg9p?=
 =?us-ascii?Q?RXCiGsxjqLQAqmdYT8eYX+0LPrA8vu3bvkBtS8FCvBZJ9EBZ0i6xLLSLCOm8?=
 =?us-ascii?Q?x77+yC637nLbeptKPlXg7FOnZ1J0iD+ksNRcRFddBfkMwCh7tbqPGk36qj4a?=
 =?us-ascii?Q?TVG2jMONbtSV/yL97BMbCq/94phKmaJSWjRJ9Gtjs95W+e6TVPBQylFsgrDI?=
 =?us-ascii?Q?vT3evSd7XNucqiErDqKtNgcjgUvUMKxiE/4ky820r7/wO7LGs5pI8tx057we?=
 =?us-ascii?Q?gVRqHdKwqiYyPsj2SeuW4YzSrBAUX4dN6AzRXiJUMLk8Zb+fQOaGqNw4DApn?=
 =?us-ascii?Q?65YJXp1yd+zKHeOKrn8Wr2xmih+yIrOg9L0laJriT4N88gtX9v+mTIXTMUka?=
 =?us-ascii?Q?k53KGBHUYSVkUeea79dI9laVzX8PM6C5dkRmCwZsVQS4oo0zdFQmh2If0PMA?=
 =?us-ascii?Q?RJTvi1qPig784exmvZBJ5gXAQqo9S2yh1/bdcRZoWRPqCO48CaJ06hmJLl/z?=
 =?us-ascii?Q?cOuVxpUvyTivGcLSvcCciJbup7M5rZp1rYGKq/65tLBahXhKv39gNJwlVabs?=
 =?us-ascii?Q?eEH47xvAk8wDfGeAkYZq2X34bnOURr1djdaWv0wLAYRh/08iyDx4CYcYqD/i?=
 =?us-ascii?Q?VEJz6jsf6BbrfZdJTo9MIHDE6Pa5kg58dP+8YtqZW+mSjm3Tu6VWmp4pVxQ+?=
 =?us-ascii?Q?276S/zhUDPUN6WnX2nPxwglq5wz1lgnkz9mHhegFZBpWtKheS/rAPL7LlHoa?=
 =?us-ascii?Q?jfU9CV+E7H+B7705yhxuxWngu2flJmRMCYYrbj+2KkUIhe6vooF5N6qEoVkU?=
 =?us-ascii?Q?Emzu3SJUN3nPa+OmUBaf0s6ZzLuO2o/CHAVN1SwJpJuLDWHwObPHVFJxMSSc?=
 =?us-ascii?Q?TIjrtgtpbJAXQjtKJWCHyozbKV/2111vGLgiE4D8N0gcusz8LTr9OoJ7ndcZ?=
 =?us-ascii?Q?k6fUdu2/6eR7nTZLzoSM8dKnSK5pHyQ6QaOtlvbuHNRIYDUYjdhqaglxVCnW?=
 =?us-ascii?Q?K4HbxQ4GrZHC2o3100bXmrpW8w16InZdbN9AvyBjrZ8ajNhVbA7OFriWDWhf?=
 =?us-ascii?Q?PzOuccbi4xF23uVuLoBqhDv0Cww5Qvt4OoWc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:38.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba9a6bb-b7a3-4977-c8bf-08dd7c16d05f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

Currently, FDB entries are stored in a hash table with a fixed number of
buckets. The table is used for both lookups and entry traversal.
Subsequent patches will convert the table to rhashtable which is not
suitable for entry traversal.

In preparation for this conversion, add FDB entries to a linked list.
Subsequent patches will convert the driver to use this list when
traversing entries during dump, flush, etc.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    | 3 +++
 drivers/net/vxlan/vxlan_private.h | 1 +
 include/net/vxlan.h               | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b8edd8afda28..511c24e29d45 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -908,6 +908,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	++vxlan->addrcnt;
 	hlist_add_head_rcu(&f->hlist,
 			   vxlan_fdb_head(vxlan, mac, src_vni));
+	hlist_add_head_rcu(&f->fdb_node, &vxlan->fdb_list);
 
 	*fdb = f;
 
@@ -962,6 +963,7 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 						 swdev_notify, NULL);
 	}
 
+	hlist_del_init_rcu(&f->fdb_node);
 	hlist_del_rcu(&f->hlist);
 	list_del_rcu(&f->nh_list);
 	call_rcu(&f->rcu, vxlan_fdb_free);
@@ -3360,6 +3362,7 @@ static void vxlan_setup(struct net_device *dev)
 
 	for (h = 0; h < FDB_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
+	INIT_HLIST_HEAD(&vxlan->fdb_list);
 }
 
 static void vxlan_ether_setup(struct net_device *dev)
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 76a351a997d5..078702ec604d 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -36,6 +36,7 @@ struct vxlan_fdb {
 	__be32		  vni;
 	u16		  flags;	/* see ndm_flags and below */
 	struct list_head  nh_list;
+	struct hlist_node fdb_node;
 	struct nexthop __rcu *nh;
 	struct vxlan_dev  __rcu *vdev;
 };
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 272e11708a33..96a6c6f45c2e 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -307,6 +307,7 @@ struct vxlan_dev {
 	struct hlist_head fdb_head[FDB_HASH_SIZE];
 
 	struct rhashtable mdb_tbl;
+	struct hlist_head fdb_list;
 	struct hlist_head mdb_list;
 	unsigned int mdb_seq;
 };
-- 
2.49.0


