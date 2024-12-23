Return-Path: <netdev+bounces-154004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253869FAB87
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39931165B2C
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69218CC08;
	Mon, 23 Dec 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RT4rAj27"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C9187342
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942598; cv=fail; b=jlstS5G7NroKEjGC16zbMKkYGVcDlFjuiWoOxNggNsClhHYHNfqTozI2Z3NNhB4rs/+6Uz96FcJ/3hmpjkyviFJgmAMpMBuMtGddXTTjwGpW++QEdZr6dOj1EgO+fLGeIF4NKFvi7jf2GgRpon9Gx27u9zz/snHz+MpL6Bt25/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942598; c=relaxed/simple;
	bh=itk7EPhc8V+rndxTSJqAC+I5VcJZqmHM1/b3jB6S/V4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmThxD9fgO/spAPhOgSvhsz202u7bQpMXHH7NmTc+B7zC0GGwlbMVUidMVP4Ds63RJtw1bHDeLb0RXD1LryqfnfjH8tuUc+e5FWoluvYIPdLhDbVVKGBaWtwc7rh1tuvlLiuMYsc5+nbT9ADMJrZEmDwOzjacoE2AujhyS8xo1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RT4rAj27; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgk0ZFCbzTfDNIb5lxAVIHWwshbudqbeY1xYXZne3eJAdhnLfPW7s4Ms7H2O1G8jPxKFtDgJNk27cj0FqM4Fl+awfwBVmsKIl8L47RRWcGo0eneqdN++aBsD2WAPSgSRIb5Z6wq3qPxho3rDWO2ga27sVmFN6qdcdn8f22MoetdrLtpXMPGKMAy56AjNYK9z0MzELsk2VjIFckiLIcb3nOgowVzmmiiZN2R1kj++eyj9wDQ3UTvXHjGwqpEpU4Vcq2aBCCgPyruaWWhZAMykbfAUBgHhTNPsUemnppiIUlcZchQoIyyIYBPw12DhLRMfXim+KHmu4k6Z1frHSLSBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpCOsDZvU5BJ893wRameJLOdC2R86lInDQ5OSZN6y1o=;
 b=tSbPSQEDG+7rqwuYgiheheSJiCFpe5HInNLc42yEi3Zhh35bKul5h96f+ttioGrwKLOWRJ+KMmauIXPTELYwWOJsUJyQaSGp/jKbxG+kokCAUBjDiztPXBJmkznz07V/ZNFXSVXcb9t59uDZwEZwV32x+tAcEHap/Vk5+rPo+g0QQn4ul7j4fsHFYHk0gqwIz4zUTK9kEIaT8p5Tn/fEQ4VJWfpYKtQSzySN9/St34Wu2A7WDFQJIXSuAJDDhDXk/2vb4UA9dV1dWnsHLNz5Jy9En23SjFtH69CT7fFUP1QtTwK0V6eVnfNG/Oq3E5eS0E2IGxB2u0m3DjhlXncd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpCOsDZvU5BJ893wRameJLOdC2R86lInDQ5OSZN6y1o=;
 b=RT4rAj27xPvohu7qFvpLCg696zmnNZ7rwUXJuiNP4CBjGFfk3N+PzMVM2ysIhLsY3gm/04uaXB0Y4XbFno9Z6hQ00Y1ocSUzxqmK7eHyv8PXS4mTtXZQlTAeycqtjpeUqmvZZiCdLldKEKMLGF5p8WhtlcplVYjirCv5EecdJ+rre5ustnFNm3JnzX8DQNZ1e3UakQKrT7n+rfA0Ezjt+xaNRFfgnaGqP+bXgqYrxH00jW9yCB5S2GQgKtvDThidiAELaVyvfdqagI8QM6tPaVH2ymzryzYCrgnuzqWxdrLia9JcnnjowSZnOO4+GVUx2AREyGJbB+oo5TFpdsku1w==
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 08:29:49 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::2f) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.20 via Frontend Transport; Mon,
 23 Dec 2024 08:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 08:29:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:37 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:35 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 0/3] Add flow label support to ip-rule and route get
Date: Mon, 23 Dec 2024 10:26:39 +0200
Message-ID: <20241223082642.48634-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b82a8df-6367-47c4-b20b-08dd232bf6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5PQw2WZevDiOCR9A3G1pRzOSdj9RzuI0cT4KH2LOpZo729iK6zeTnchTA3qW?=
 =?us-ascii?Q?GoIc0rd8Uq3dITJPqdMoaTY0lY6u4Q45AttG7vrncNwihRVRR9tMHIryuisI?=
 =?us-ascii?Q?Lww79OCPrujKRDWgcJ3vz0mrWiap2RV1cz1aezmAbGmydlLVK9Pjigv/VfwG?=
 =?us-ascii?Q?tDGCUgmYa64hUHJOvB/ugZAFpshRRX/Zg34YaDVuinTWRWVBOLcV3FUxW/FP?=
 =?us-ascii?Q?f3hwvunJ9JuiOx/No5C0IKJcymu6r5hMAaUeo+vJu1Btqdr5jKnh4Sunu/sW?=
 =?us-ascii?Q?YYYDnhCcytyGE4eIjtE+ecb0BMMKMwxMQHkVC9YmPrPyR+8RLzqZXHxD0X/j?=
 =?us-ascii?Q?B2+GrqmKffEP/cgV4u/xPAK7UD4lQk4upBbS3WJw9p0h7nFzzaL5C3JXiFIy?=
 =?us-ascii?Q?pVwk49ot4Kp1oZNeAhV+C6mRMMTi3W64HVGw2PKw+FCjm0yzxyxLx8HH7EqM?=
 =?us-ascii?Q?bM/uKzStHBIWS+3DicgE/ei7tqxhL2JUwXCzu7bYqlMfrzx3jkkrvrrb2MkM?=
 =?us-ascii?Q?URbW9AoXMql4I9Mi+7Y9Q+hJdTPIAE0NwKBgjT1hwefY7MAQmqUxnFjrTMm1?=
 =?us-ascii?Q?4oX/6I0SucEOO22j5fevufSf/lMxygFXkx8mNTG4h3vfzaGeWH6KUNnDSzBN?=
 =?us-ascii?Q?dylLicsfffYzhmFkz1DBMXt8iPEydWsApq8aOBCgQ9eV1HXrRjKoHmaM3WQu?=
 =?us-ascii?Q?piBNQ33sCtfR/b3q7n4edCTR/sWrP8YCI4ePzNAA8AIvsv3BH02BomXSZUUT?=
 =?us-ascii?Q?Ua7T1uiGX1UyMAciuAyUzPWb0VDC46dLVPsJf4r6qapuxkFtTONY6X7RpQCM?=
 =?us-ascii?Q?5ytCf1a3EHWP5gQzDvzu1+PZQv7imKxmWfEyDEzpzKBongKyKYOCYfoe/Cfd?=
 =?us-ascii?Q?ACnUjM6FVk+XiANSEku77Drp/8Xcb2emdRpHMLxfu019firV5O88qIpZx330?=
 =?us-ascii?Q?Ewhxx5LAwyyJ5TOCRQBfGPd5kGe91N7rjrWhk2zjm8v05Vz586S9en13PI9c?=
 =?us-ascii?Q?KT4LPNL0PSm/CSGOA8nVKna6xLhtMUi56JOuGDjj1j0bXbDFw7rMdqi9/BAS?=
 =?us-ascii?Q?vuEOgXvYzP26HwMCnJ8B2QKD1zoPic8NmMwrMA9Z5Ac6RzDF11exDLaPI11h?=
 =?us-ascii?Q?Qa/d0xw89iKJcgT5WlMWRWRIyWu24aUUUJPih0NtqBkgFWBVhhDp8xK2tza0?=
 =?us-ascii?Q?Kcl3EhpRDdKsFfzL9FNTu+MX2Mka1NiuAEhwknssSV9L1RwGH8jvuv/nky2h?=
 =?us-ascii?Q?9He+vvvj/xEGrH1OT58EDkRnGDCAQ86MobhOfrK2b97fCUdFtXVfBwFpoCTC?=
 =?us-ascii?Q?FREtBXAU1AOWNFGTqyhA1psJntXFOaING0E1mAsm9IvXR/1RJcBpIDVvxUr7?=
 =?us-ascii?Q?oC2D6mdW2RlGcW3UVD5GCFE6IGdFH+L65dbs3iEeDDSIWuH2bCTKnIJlPMvD?=
 =?us-ascii?Q?99jN9Bm1x3mDJerc2S52jmbowNvXt0ADApJh2OHSbYrgQ+UmS0VrUejm0MzS?=
 =?us-ascii?Q?pUS5vqEEqdG24/4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 08:29:48.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b82a8df-6367-47c4-b20b-08dd232bf6c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

Add IPv6 flow label support to ip-rule and route get requests following
kernel support that was added in kernel commit 6b3099ebca13 ("Merge
branch 'net-fib_rules-add-flow-label-selector-support'").

Ido Schimmel (3):
  Sync uAPI headers
  ip: route: Add IPv6 flow label support
  iprule: Add flow label support

 include/uapi/linux/fib_rules.h |  2 ++
 include/uapi/linux/rtnetlink.h |  1 +
 ip/iproute.c                   | 10 +++++-
 ip/iprule.c                    | 66 +++++++++++++++++++++++++++++++++-
 man/man8/ip-route.8.in         |  8 ++++-
 man/man8/ip-rule.8.in          |  8 ++++-
 6 files changed, 91 insertions(+), 4 deletions(-)

-- 
2.47.1


