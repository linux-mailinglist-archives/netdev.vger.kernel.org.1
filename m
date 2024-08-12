Return-Path: <netdev+bounces-117730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2241994EF39
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A938C1F22439
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DC17D354;
	Mon, 12 Aug 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9O5i5uD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81317D340
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471940; cv=fail; b=umir6Fiy9focSa0cLgUwkmp/hVZs9hn6ccPjCskGJNIfjYw1MPGsOj77RGnAMhdBScX2gtLYC1TagTYIGCUJEKmWZbdriKg7/F1bvgDGNoCm5sil0WvkzNCWfyZu7sKWXL3C8dJAM80TrmbVKbiTh3GXQBB+q9jF7r4133EySsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471940; c=relaxed/simple;
	bh=ilg10aZ5tESKKK5u/ew7O3lB6uSpILGeRLtDiFHDnnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CTpqQtjy0P+m+6q0TsEjVuekOvzVaX1h97NdtTfTHdjHHaiWsorfA7SKBedepPtwhDYWzS8IYiBC0bxxeW/zvrXXhvQSCkiyIocKeD+iMf2huiEwjtITIbPZovjhzQOiOTkXRU2k4zbwHl2/Ekxmg5AWMP8OUna3FoTpPbi6SJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9O5i5uD; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FENanX3GadeVLky1rALv3qvCoO3vaivI6mvDXbsnx1Jm800gv2u2mqTKn+mJrOPbX0RWZzzuzT4CLhOSDl3sB+1Iw1VzIk3jch1y9d2v3FeSMoajDDOXEzdi82cn3a5XrANJHq3Wvm/nlXxSiaa5C7QZfGDPoHr0Vepu9y4Mtjtc6esFXMDT7xxmMhTY6V8XEHyQewL7HYkKAxX3DnRYY9joWOBe6Ich+VRcSg+tCmPEV/jmglm8lnF6TzbBfE9h8/ZCet+/3fm1HhRx6wZVmuTlOjQcC2e7on573yHeqbO+jIL0BvtPh670c0Exv83z2C+pnztu6xpqjTn7IZEzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43OTnMsSdwj9ARV2R9+6RUOkxlg4F4nPpXfOgl1FJgk=;
 b=ibKBWstQMZusZA+VZH//4mvVFpMmhpkvYrYAyfPz5ni4cOnE8FU0G41eQcPvfPWsofUvVMbrI4zOHT/qeGa/MPjnzYgJ+K8+6Fcv35fjE9AXnrxIgbN60KdOMQPBXUkyBLAHv1UO+1N5a06AwQ6IYd+pES/OQpZMRRCJZwaYQzlb+9bHWrnm5Zd5uy07L1xzc11xce9YhtN2ngVne01dFdR7YPXdGK4cfZiS7p1vQdjsklMSbHmq6rWGA1nMVnWqiPHXhgzwFxX8+UjgPyrg+RkknRqgUaGlaTlqpuwbYK6u2WcxE6xUT1gWjJy454ysnNc5tNRvOdtQ7PNPgVadvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43OTnMsSdwj9ARV2R9+6RUOkxlg4F4nPpXfOgl1FJgk=;
 b=P9O5i5uDhQUPGUTzvLVni1uMvHiWEBNApWoMthNSL+Bk0+SyHKKJgzN0sAy19YKWW0JL2XEhl8fvA6W85XF8S74r521mPwjXPCbBeeP6WR0Jiiv3TYahQYhl6rq9sSUgqGQIXKQ759KKUgY3nbgecni+sOw+Y1ioUldLHG/4feD3tMWqXUgVU2dGgkEOf944S/4zxAMT9GQPE8jmmX+1mSC1CrQIfPdf0J50oUov2ZrHvjY+hRFaZKKWWrfRbZSWViHxC9WR12f+ouaG916PHJeXP7QjTJRC9z9bzVm8JGgfGaXrTQRXbrq8M6n6jtEuMjy6TiHp7sSNCkpKAIML2A==
Received: from CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:12:14 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::a5) by CH2PR10CA0009.outlook.office365.com
 (2603:10b6:610:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Mon, 12 Aug 2024 14:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 14:12:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 07:11:55 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 Aug 2024 07:11:53 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool] netlink: settings: Fix lanes parameter format specifier
Date: Mon, 12 Aug 2024 17:11:11 +0300
Message-ID: <20240812141111.3718889-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c070095-6f4e-4dc2-fa8a-08dcbad8c428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJ92K1vRaKvBFOy1srNXUgV5xW4nOI71d/NBUsVtx6rsd69KIj7GXhyl3vkX?=
 =?us-ascii?Q?dGN1Wu+WJILqTp3YQI8l8s+juefpXT5qCGdzsNw4tIN5QFn193GyQnpB5a1K?=
 =?us-ascii?Q?V6LfdmhH/xFFxWK5uKtu78Pi0oZX4ynFRfQJE0JODp+fHLWCs6FLGfrYHDOu?=
 =?us-ascii?Q?frk9S8k3Fk13pbQJZ55Vs9aQssk/rmNehOWtrW2UuCzDD+EgoXJdImjyif0y?=
 =?us-ascii?Q?guHTjvtfgUtreyIvcxYA2BGPxf1TOvmn3RSC1QABphP4bSdrK4cMgF17IV/A?=
 =?us-ascii?Q?0/C0cDq0PzDgna0AOuTePp2UYQNId7xrXaqj1h9IGkH50BSo6hxB6ir8E6yG?=
 =?us-ascii?Q?nH/R7KhgfcIOrs8E1D5j4VK1hCrlaFziP/WHotCvDMjRHEhaNZRfE3714Og9?=
 =?us-ascii?Q?+iYWRMqUZ0GXPo5ICoyPuS7niplXAiKBAeOSSrLgGQKsoC92RivfP/rAAFa7?=
 =?us-ascii?Q?pPlfrWX9A23kPOwkkEhUVqP3XztcG3E95MS/uiWEd9TBs09wyUStkAvo3oA3?=
 =?us-ascii?Q?J84dp+dOk5HYT1KG5X9PwAiC9XUn/K6lYAHQrxrVlJmUPnSCnRON7ky5b/Rj?=
 =?us-ascii?Q?ZL86iKyBEeksDYDjSWXeOony2O3ffM9HBDkgqRIo6YCC+aX65WB5uuOkP9SX?=
 =?us-ascii?Q?DmekvmnebrGDX4UymM8J9a4MxJFALqz8H8rpLHTjYOxvCrU8Pxt6vfNpSFGV?=
 =?us-ascii?Q?HFBR5emmy5MpUQF2sTr0u5U0bn2JWjG+pMloxdGPgSs6wGMRGpe5ORz66Y5x?=
 =?us-ascii?Q?ewhOHehWE8sgdAXxiAoK5lNuEafdgBhY7MCtej1W37wxS/mEDsQ02zdNczel?=
 =?us-ascii?Q?j8yAvB7HqB9nr7X+YwPHoovLjFTMKSyKq55GxWvZ9iaiUOJR0uWm2iMXE+1g?=
 =?us-ascii?Q?kFCabxdOFl9vD7Vp6RHPvf7n/Hr8e8UEl2mjemHX7jzrW+zHu/NVYve8NNR5?=
 =?us-ascii?Q?YvinFI6jD4HZEkqQviAWg1f72xLUFSOJovg9LuNaLBi+QwOwmW0ZSjxdorTR?=
 =?us-ascii?Q?iGdTHF3N1daY10yw30T5j5hShdyDD5Dbx45QaNHU7kbe4TyIuDTiqKiyLy1E?=
 =?us-ascii?Q?TMtXOfp1lK+7j4Dv2d9CFOUw3faIDOHd1NSoeDJ+ksjgQdp/PJs/ucTAFiGj?=
 =?us-ascii?Q?vv4K1VGaj13X1zgZ5sUcaMee4aPKAPKjVToRMqeymdeEQ1nc7ehIVNT6Q/Le?=
 =?us-ascii?Q?lYnygh6rCXwzVWxyURGyCw7WI5pRYLfd+FMwU7pASHM8Z6Grj4IFAgpV1sVc?=
 =?us-ascii?Q?RpV1IiMjvD5T26+Smi6mAX7/o6D1tiL8Kcw5hWDHRq5i9LCmdGl7N7C51daT?=
 =?us-ascii?Q?U2oTDO4uub8eEYlYJnswm1oVIV5xQCmyC3qVBFbIQb/+EBi0wdQLHmllOwPp?=
 =?us-ascii?Q?p7mnbHXAW23xdaeGLSgrN7DwwHF4cooaoetbmNaINtmwt65GXMlIXj/XAiHV?=
 =?us-ascii?Q?pMWt4Z+kFg6Wpk5tY+5TchclCgFr4zOd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:12:14.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c070095-6f4e-4dc2-fa8a-08dcbad8c428
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475

Lanes parameter is not printed well on ethtool base command causing the
following output:

$ ethtool swp1

[..]
        Speed: 400000Mb/s
Segmentation fault (core dumped)

Use the "%u" format specifier instead of "%s", since the lanes parameter
type is unsigned integer and not a string.

Fixes: bd1341cd2146 ("add json support for base command")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 netlink/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/settings.c b/netlink/settings.c
index 9dd688b..62dd339 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -527,7 +527,7 @@ int linkmodes_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint32_t val = mnl_attr_get_u32(tb[ETHTOOL_A_LINKMODES_LANES]);
 
 		print_banner(nlctx);
-		print_uint(PRINT_ANY, "lanes", "\tLanes: %s\n", val);
+		print_uint(PRINT_ANY, "lanes", "\tLanes: %u\n", val);
 	}
 	if (tb[ETHTOOL_A_LINKMODES_DUPLEX]) {
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKMODES_DUPLEX]);
-- 
2.45.0


