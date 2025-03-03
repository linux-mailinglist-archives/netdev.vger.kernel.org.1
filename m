Return-Path: <netdev+bounces-171217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A323A4C01B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FE3189126E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7A42036EC;
	Mon,  3 Mar 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y42nWpi3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E01DE3D6
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004405; cv=fail; b=SaBjUj6CUAHWPRzpJhoO6aTTwwCEEmzBcgYw/gOicykQF0R8REpETqy9TDYwN1szYTljagsHs8SFXbgr1RayavZbXNipASLGpc5BVwBlhLxdZRtSN+M7dFEzR8v/qVQcRZDk1MJVqn6KJUSJwK5Ir/aGuNrH+tUAHHbAtI1iXPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004405; c=relaxed/simple;
	bh=W+omtoYaNYxpXQr2M2Q7OgMF14ZYsykB5DNxku65F2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP4USCHYtJ30x848NmU5LRb+IAPBpu/TLRT8ic1Rglws9otX8eUpKq/ashohw4O097nNGeG2aETJI9J2NZhToz1B7mCT9zDUECA28UZZZjrqpwUeFnU4O2bVi+aS5ZEGtRVo2SSqtah4l3krrzVDBkwfI0dCbC9NswbJYgvS7/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y42nWpi3; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTejO0XVu4T8yg53b/h3UhJmX9hz+Go+OW9Ahzse0aRng4wZns/vmuJpUliaJPqwkcbHpTb5vnEkEWMonydL0h/D9vInh6L4hhpE6ZVWh20KFqtMm2JREPuO87EMyYIu9CLfwE0agwgbxuSRHvQs/dpZ+jCsExDKBg1iYP3GD3yF2+CP1a/XzWDuCEXkTcwtl2adNehBhoinc+JuQAbAmJeqNsPnx344oY9QLy2oFd09/9tkkwC0suRVuoH8evdh0iCMma7PuoMkdCs8W3e6e9dNT2/eTjyCp7gDCDo0Ow9GXZPcTXtotHzaqBdi7hiOO5HMYVwQ07o+qhJRUVcjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuvJUo0cgJFxsjo2S+NhCayd9rC0ejDuK1QvYY55FTE=;
 b=lCMub+mC2mhXcnKXEsYq183W8bivfAUGlbhq5gEX5tXj83PKGr40x0otRvOq8LhMDWMfW8kHN6rJyQERLSODZYjbuhcbrbMW9i0mxrT0B3tJDTJwMZ/NbeDttJ7yx1Qs6DwvCY7zva9f1h+lik4rnQ9iyeWbQBuSdkAjEvHJ6Tm15dT3F04mIcgSvYyv0JlMPH9Et0O4XWYW9EsDcueWZBRXpOUXBDzssmZMVMCYaYKMDYxxLnuOcR/QMjJHwOaEOvl36gK6CL2hff2Qp4I1gj0NIB7N3Ep3jRyRZ3hZBsSZ9OHRvyvKSSKa7nxthrD1fFEmBGB7Vag4WH5DlYg7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuvJUo0cgJFxsjo2S+NhCayd9rC0ejDuK1QvYY55FTE=;
 b=Y42nWpi3VrbW+lV+T5yZTflME1oti2ze7Xnv9YFi5FGNJZzTQqxFXT8rqHqf9gYktGLnRy8DO92jJBIGRPrmo2/Qw1RJezWdmv1tKxg8b6JT6Ptsy6n8lsJhNfc++SVRZzGDGMLyzpHXhh90dGbpEx8qW+MFoSehYrCKykPwWgf2qwvwnKKcJIOVNZUDPutonuSjrDyGhFl/spEH3ip97Igw1TA3gkAyYtGz6JT3xUEU/0m96h8CsD9tPyxFYQjrrn7LU9ZZsWAfFlabSvumxDR9aNs6Qn7XsF9uIFAZnoyo2LVsLc59n+5b9AqX5Jn44NtR66N2lK2kH79EXC23NA==
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 12:20:00 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::6f) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.24 via Frontend Transport; Mon,
 3 Mar 2025 12:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:19:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:48 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:46 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool-next 2/6] Print unknown RSS hash function value when encountered
Date: Mon, 3 Mar 2025 14:19:37 +0200
Message-ID: <20250303121941.105747-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250303121941.105747-1-gal@nvidia.com>
References: <20250303121941.105747-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: a99d8cac-9170-4286-b915-08dd5a4db7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPXPih3PMtooPKtZL2dnJerxkWpIJMJJdi24a+DEDHN1d5nV3oHJH5eO5Z8e?=
 =?us-ascii?Q?nyJyn/JeV5qMXd6hjXGOO6GhGEyqqclqu0G1UQQ3VkYIIGhlBhP1/vGZq05r?=
 =?us-ascii?Q?m3jBxPpRGUlrs81vc3drjroBMu0Arc8GbgQ37iTO2wSujRTvymkg6iZH+PAK?=
 =?us-ascii?Q?cXxcCS8SAuZsIKKX1dTJIEI2UtnDyo9/8WCK3w6eZNMAJHPAMJKqVFR3MYV5?=
 =?us-ascii?Q?5pciCf9GPkDr3mOuGcSKEufcL3R7gBTi/c3kVfAvGEg331Y4WW/hvtpGUd4Z?=
 =?us-ascii?Q?pArUA18iTbIwaAuFhpfAOnaFEQ/on50+vxEZzdqZclEEM3eq9MKHzISi5cKD?=
 =?us-ascii?Q?oLybq9Itxs/2d5mVwzb+q+64q4o49fXk+SncDLs639zdQ/PuCU1zRTN6GOGf?=
 =?us-ascii?Q?G723RTOjYEjUAqVvwxSUiUP2/JnpHb9Ms4yxZ4aO1fKAEu7eL3Iwvz2hJhTr?=
 =?us-ascii?Q?2ewqKd8kp+IbweILgFzGyA6oSGrv/+lguyG4ihcKcWPyynXzOPBMqeGKOcV9?=
 =?us-ascii?Q?9rR1TQUUWYggXBg/KoktpYAj9FpNY+jC9D683qHSFPK27B5EbUhSRiL95bdl?=
 =?us-ascii?Q?qs+ja6l3+6YloCow2Q+aP+JbdpLbPWGh12/z8UTLIuBU7ASGkBGORNSyux8t?=
 =?us-ascii?Q?4SsMX7udPtMslfbnPitot4mw3jVFNy2Tie2P6GpUBYDdmVEB3GcQjmF5E+hw?=
 =?us-ascii?Q?IcPasPuImiZYjcpN+mLO0FFCT4gza5Du7UsGSD/AzEm5lZz6J4GRFSJ3hwZV?=
 =?us-ascii?Q?J1w99WtKHmn6ysXu9TdqU3WrHhj+7CzZYi0F4uUQIE3SuZpGk+tC6qx83elU?=
 =?us-ascii?Q?3w2mYqSwKjM+sXtGRlfRo3f+ZI3LAipYm3WXA/UGuwoDyMlNHWKeTutnJgqp?=
 =?us-ascii?Q?AAl8WvnLedVOMyiIsXSw/zW/6J+XQZ7G/amFStUcWzL4zuuIhPC8mDbVRcMK?=
 =?us-ascii?Q?b17AK10Owwwy55VkIYHCzmrgfNlJGJQpuUOBRvrDBbmgXnKPN2SR7MLuBxcs?=
 =?us-ascii?Q?JuREAuIEgMfWTLiuV/qjvzW02b/tPdRGyUWc4GiQZYLqA45JEVoKEkTwDGjG?=
 =?us-ascii?Q?3z1sGhtvb7bqk7hueHivb/omlnRT8pIME/dxhypO4iiZl/IdtJx9D6SqnURq?=
 =?us-ascii?Q?pQ3m/1f3ePbZP1GmtUVJYZ1AUv5EOw4hiccuuNKLNlHmFsozJqeTkqJbC423?=
 =?us-ascii?Q?vyWrgAEHSaW7EpicxD2wV8+8ggt+QBi9lWmbyHe26jFLSt+UjqjVpotj329V?=
 =?us-ascii?Q?UM+AGYrMJCfMeh+MzjcxPlTU068WkxGLprKrw2veJXfwKBMArScxc4yQP0qc?=
 =?us-ascii?Q?nnA5byvc4BBYgNLO4Ezx1MUs9GUR/ljIUEImm7pGfRUbGKtTEF1oDMuYcmBu?=
 =?us-ascii?Q?Lkv9cuSjq7R35kNItPu3pkm0KTr3LsMHYdeOKkbztZtpKgTWnLgU5Zbk0DA+?=
 =?us-ascii?Q?R3vFgS6lENgFTA/kKfRhnMS5jcTy7l5xnT6WroU5GB1NU45z4D8lnKx5HG2r?=
 =?us-ascii?Q?+wg1EgJNlnQOtgY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:19:59.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99d8cac-9170-4286-b915-08dd5a4db7a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

It is possible for the kernel to report unknown RSS hash function, for
example, when a new driver which uses a new hash function by default is
used with an old userspace ethtool.

When such hash function is encountered, print its raw value so the user
is at least aware that some unparsable function is used.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c     | 6 +++++-
 netlink/rss.c | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index a1393bc14b7b..712e5b4fbceb 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4106,10 +4106,14 @@ static int do_grxfh(struct cmd_context *ctx)
 		return 1;
 	}
 
-	for (i = 0; i < hfuncs->len; i++)
+	for (i = 0; i < hfuncs->len; i++) {
 		printf("    %s: %s\n",
 		       (const char *)hfuncs->data + i * ETH_GSTRING_LEN,
 		       (rss->hfunc & (1 << i)) ? "on" : "off");
+		rss->hfunc &= ~(1 << i);
+	}
+	if (rss->hfunc)
+		printf("    Unknown hash function: 0x%x\n", rss->hfunc);
 
 	printf("RSS input transformation:\n");
 	printf("    symmetric-xor: %s\n",
diff --git a/netlink/rss.c b/netlink/rss.c
index 0ee8a0dbaaa2..7a8c4e5e7379 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -56,6 +56,9 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 				break;
 			}
 		}
+
+		if (i == get_count(hash_funcs))
+			print_uint(PRINT_JSON, "rss-hash-function-raw", NULL, hfunc);
 	}
 
 	close_json_object();
@@ -163,7 +166,11 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		for (unsigned int i = 0; i < get_count(hash_funcs); i++) {
 			printf("    %s: %s\n", get_string(hash_funcs, i),
 			       (rss_hfunc & (1 << i)) ? "on" : "off");
+			rss_hfunc &= ~(1 << i);
 		}
+		if (rss_hfunc)
+			printf("    Unknown hash function: 0x%x\n", rss_hfunc);
+
 		printf("RSS input transformation:\n");
 		printf("    symmetric-xor: %s\n",
 		       (input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
-- 
2.40.1


