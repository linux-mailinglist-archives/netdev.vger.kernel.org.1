Return-Path: <netdev+bounces-113636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B186B93F5C6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2B3B21AD2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972F1465A5;
	Mon, 29 Jul 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYKYhH7D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666421428EC
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257144; cv=fail; b=dJn97HqtVpAj+kHl6ESh7FjRuesSKqgy7pZGMmQLhSTGmOXbZVe7D06NofGv6CExaR2CL5gEhY5a41nmqfUrlIADsNFb0l1znFTJ9xH2ETONcVPtcnVeQCjOoQ2rXDk7jAe1RAYkXZ40x79kDCmonEc7Jmr72byo7Hj7/yQgkYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257144; c=relaxed/simple;
	bh=L+i+JbbajntsES1FIvMlr5nuzoVPlyLFeFbrn86tTso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZjQDiAMNDTj/ePJR7OFhSfkCoOllumn53fKZ9BA/y7PlbBUJnsvYL+mCDanTCDTzWkivF1txhfwngmRUDMH7Fv3bQFDymt1vSrzDg0/bqDpCOPHNoCIEmrA0t5j9iJoRF/fnvU631NqpFERPiHiagHvaGgNws3D0jdj6AHkIK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYKYhH7D; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVAGAco19hx+54KmGZSB0UwHn4m8SLihECvvp8AIVPOdyOkGPC5R4BclR5Ufm5Lzj2ka886aYuE3+rESwEA3QRrwi3Lpy2v/sZmar+pcQc1jhHUG7MKbE837H1h4d3lgjNEuGHs9hkTfkTf3+YXWAjiRFNsACbbqeEoksNa/7e31JZkPMLVYcO0+uyz4JkglsJSxH24lSxhcw1W8Kv1Hr4UEZ0N1M5+mCze3ir2JVBJ+gczNy68IbGH+2oiIKHdFHvhVyg4jMUYovAbcZNvmT5bUCxNlGqW45e196ui4WAThXqHNSGIxx/nUYOftev01Yyu4Q956G0moJZU4l2qf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC3fKuxGVnR3YUOEhTeKw6OIXQegDQIrQV3+gWSwiqQ=;
 b=MQq4dg/BSxIw/mjspcuqp/Q5yK7tjWIKfhVpov1xIiELQlajkhSHMInDppK2K92YVgiaWqPnQM6ayOs9XE/zsMqfBZ+naBhEPq/ni+B4v9xvRxmC8hJKNP6M3K0cLoy8Hi6yxfAHLQ9ocx+GoyniXCng/1ztyCYH1p+zyZUfe6PACMwnSsCjK1QMZcDR5A3nURXxdjPHWPCFG/UHvpAMQjo/7yHzOw+nbuo227IsEBUn1V4PBxx2F9BVOPwqUMsOYlL2FDiWFh6Pz5f3dnfIq35p39Ilqc8Y9YdH46SuYXQZrPuybEvEQaw6IDbf9Kx15kdLN3YhAOJbWM25RQlkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC3fKuxGVnR3YUOEhTeKw6OIXQegDQIrQV3+gWSwiqQ=;
 b=uYKYhH7DeyO1blGPrktgIEuhvUA9Tf+VTz90K3RwdnbXzsQt24NPLELOf8Ohxz0tj2snEQFEQKFoOCAgGp/ONx+pOrnv+HhFzxYLYxwsvjmoZS9Xcoec/tS/8/w/V/ukwDNMX63u6u2ct01I6uQobX8nm6WVz0JZ3B4rODEsoiSgonAzIlTc1OPZWYt8dibCnXc9dqHfVu0lUWn9i7M2uw0k07pMQVBZ8ZcO39mKN88p870BaosRU2BG+W11T7c90OcCtGIWNt8Egq2LPhcx1yIsT8Y0yIfmRJDC9N9HC6SHYba3jyhiuoof6mG9fVJVFBlQOZyzTdijHmP7OFfmEg==
Received: from SA1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::14)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:45:39 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::16) by SA1P222CA0004.outlook.office365.com
 (2603:10b6:806:22c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 12:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 12:45:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 05:45:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/4] Fixes for IPsec over bonding
Date: Mon, 29 Jul 2024 15:44:01 +0300
Message-ID: <20240729124406.1824592-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbf646f-b4cc-41a4-cc45-08dcafcc5999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOzHCsrExEjBT/rpQgdr65DzypTsBnRADqMgleRj0dqQru2mxYx/JXSs8ew7?=
 =?us-ascii?Q?OvM1EVHxixzwcvvFtk0IaXkJVq/QDedRI3gMBCj24849Hl5bS7KS9k6+LXWx?=
 =?us-ascii?Q?fW9snRJMX/1TPojC0VAy5kOus4HBxPr1dAY9GfTm5PwiqPSdc28CFgp2yocg?=
 =?us-ascii?Q?b5Y4JFOKLiK1WLidydJI8OtQQwMLXTquenXmf7ExnZz2U2D1pCvKrg9SOkJA?=
 =?us-ascii?Q?v2pNHaD2ZceZsXwWWwC2eJejdnMqpjSm7Rp40uPWrO1p9YLXRWThCxn9+raY?=
 =?us-ascii?Q?mzZwd9ARK6U6UuFQ0PKIfj3+yUETOPnCHNUxshRxl+jQ5/TyDFpJQElfgSOa?=
 =?us-ascii?Q?i14OswNNkaOWrYg7FaJEy3JK9Kth91dzaD2FDi975B99kHhg5GPUXW7Kop3s?=
 =?us-ascii?Q?QyCxfhuaiGxwWTMkMuMVrtmeVBanJoqj3T1ZeIJbT5IluXP+VVCB0qZWhYbx?=
 =?us-ascii?Q?o80z1EWDFBv2NTnwy/ekArEYm48v+Bco5pkww1g0oobjJ8Ws0Rn2DsVP8eko?=
 =?us-ascii?Q?ERBkR2GNvOT372WqIx/Shd1NuvVPSLLwB6MxJnC1RpTcbMeXDks09cTWEfQf?=
 =?us-ascii?Q?nOVw0+lpoEms/DwiG5slkslGx7TV6o3Q5+Ou24DNZPInpaPKLixCgnZ9FaWK?=
 =?us-ascii?Q?1OBL1C+vJtpOGuZw0rGJ2QrDhqGTJNs5pXK55envHEJzgSdqYxuzl8OkC/U7?=
 =?us-ascii?Q?xWenVSIZBAlTKZ64mMaHECt8s2Kv8+jdeyObYDj1Tq2yvaSXiXA7T4NmVC64?=
 =?us-ascii?Q?p2YfKrqFYJvQ1N/X59WX9Db2CsxT6H7B0tG63wD1Otz37DM+S2loedRXQmiM?=
 =?us-ascii?Q?1B/24SaVlKkMWxci+iq26asNruYEG6XQFR6AT1q1br/wNwiAMQ1YT4BsVQ6e?=
 =?us-ascii?Q?yuZj/SxKguDYjXjHtOACcjXu4jLidZHa7CY0K9W9+edyNCQqtlmA2bLa4BTH?=
 =?us-ascii?Q?L1wWh7/8ek1b64MzuxmCKWtyxBLI9CkXIGZM9ATp5kLOTZREVhY3YqM6XuA9?=
 =?us-ascii?Q?6PIh+HE98WdX9HJCXTAjazcFEPVdsizswEhnr6L3oVMf2+OxPjJwSErrw3En?=
 =?us-ascii?Q?O8aavqCH81drs0lVPQCJ55+CSq3jUn2ViQ+4Y4HbbnSWS9CEVgzl3xLqufWh?=
 =?us-ascii?Q?3lHleNAMfWVl4MXAyxVLArzci5QVb8mNQq0HK54vXg4QPOb/pkE6YxRmLZnq?=
 =?us-ascii?Q?+uAGasKvgfM6ee8bhKD7u3pN0wZdW7DK3bvL4HHrXLdx7o8rs7mSXnyLl4sJ?=
 =?us-ascii?Q?VaXUwdq0SpMWFW2rF7qr+GhFdD6y0Pqp+WONYoPTUODY0zjf3PBRWd/qurcd?=
 =?us-ascii?Q?MmTUK+gJmFGuk14tbgGtg4bSNKyM5pCd23CzAAXri90/pA2Pzzg2rGdGBTsI?=
 =?us-ascii?Q?dV7Lgg8Wk8+tnmfZbQe9jiWqRY97KO1nbIkmpre/937og9dbvErTEEOmQc9V?=
 =?us-ascii?Q?a0aSj6tA17AmZ4qq14SJFk2OddIBgNty?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:45:38.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbf646f-b4cc-41a4-cc45-08dcafcc5999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

Hi,

This patchset by Jianbo provides bug fixes for IPsec over bonding
driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit 301927d2d2eb ("Merge tag 'for-net-2024-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth")

Regards,
Tariq

Jianbo Liu (4):
  bonding: implement xfrm state xdo_dev_state_free API
  bonding: call xfrm state xdo_dev_state_free after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 131 +++++++++++++++++++-------------
 include/net/bonding.h           |   2 +-
 2 files changed, 80 insertions(+), 53 deletions(-)

-- 
2.44.0


