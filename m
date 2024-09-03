Return-Path: <netdev+bounces-124546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418D969F21
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69DCB2150F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251931CA69D;
	Tue,  3 Sep 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNOyaBtv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607093C24
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370623; cv=fail; b=JdGslOb9ZseXhlxftSKJYWTii9RnUPY6GdTl8r1PzBvZaactJvYkO9XfTd0CR5QURRYZE9rzij3xUfLnb66FTFFsHexheB7ZJNzKebfriSbyxbkwCS3/ra4gcICKN57qgbFuv8y6dHoXBYjjW76VyfYUCigMe5CCAYZDuFIWy2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370623; c=relaxed/simple;
	bh=M1Cr+fyNIiaV65UZwaMz1YRPqmPeyZF81WEXfLZ91Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2B+LULslMb1MVVI3Cp3BkkGwjkTZ2Yoh9dOZS+lzQH94iNcdY7Ky0ofnfihOMOB6MT7OC17Hpcyq3qjCyfJlGbZnHVWjdKMu2+eWEsuUOQkVAMfuOIyehOrqKgBLpb9Sli+VnM7xq3QhOyAKSPBs3KpN4Zcn+gAK4BDu1/AglU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNOyaBtv; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqd8BX/ZnpCIERBfBe3qZoFXyXfAGKodqCUOVinoO38pHh1ZPIxmAqyUbc5v+hESiaMfpBwnvgG/SZzwAa85bx8mPj31JdRvwsIXwOeOXMl4IOhmxwMVhSXHVJf6BfCmZMc4sbPk4DoEJ49A38SEGtLvWK89v8pgiqVEch/dBf7FGuZ+2Rgr/PgKNBcnW9v/Y7qhK6CXHxSqSowlUAi4Wubgraf8DKF/25ehV31KYvHadhnqEsqKbrpUfXKUk6p9W5Si2kwQcLmkpZx0EMtxf/VYi473E+zgWWZ798kb/jsMPv551gtYausQgYXbBmx2KGwGBuSqDetRRsvaV9PLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNp3RHxFosTJQjV6Bty5lrOjulngh5hXyQ7lv07ajZo=;
 b=rb6YD1H0cURlj3XZb02gQwXotubNx1F0MNsl4V4OGxXNVg78vC5y82ReRJR5iBUgdgz3L/B65nEwKpphG8o3xjGB5+4WFVKbd0/kdPsY7101jAdMmreTbBcp61nH6PQRSdXmov2v3M4wz1Da7XLVIwlFQweEXB22HGiJkW1Gd7RaTWGkhov027zMdvXpgfztqErkqVYE5AI2EM9lOQSWOYzv6Rl3s1sq0G24PsEB88SLXNZ7ZSoleSPb2TYhMqyeQG2GQ/2Zjmnp0jMokK/7ja194hyGGZJEKl7Ix9yjpAjsIL5LNp3gxfRLcuuc98987nHY695AP84nZqzozenz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNp3RHxFosTJQjV6Bty5lrOjulngh5hXyQ7lv07ajZo=;
 b=TNOyaBtvXDT65q3QrD7kL5Pbn/BsvNgQWpCSfy5YnJWGJzuCI3zieidb1rcjNYYfrcTl/t4dG+M4VmvdQv1FGNWJ8TK0udoWuo38mFKlXB2TVCDS/bO+lBM9daQI3Yl70zwYgVIDx/NIPK83TzUAVW0108hhxT+fWRlcoQ9Ka8l6+GLC849cZ/LX23jJzVeALbfycOATLkcb3QQzhjV+ZTC7/z7pGQ9IZ4PSqbkmv26kEhw2FN/8ZB3TMDjRw/yzC3y1B1MJmAHge+j9A/0JWaPPMBx0fuCpbCSxsHMP3ZA0uhdKFU6MgKSIL7UiT6oe1Bt2uvT7GULIZo+V+PsANg==
Received: from BN9PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:fb::28)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 13:36:56 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::22) by BN9PR03CA0053.outlook.office365.com
 (2603:10b6:408:fb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 13:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:36:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:36:39 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:36:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] ipv4: Fix user space build failure due to header change
Date: Tue, 3 Sep 2024 16:35:54 +0300
Message-ID: <20240903133554.2807343-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d48c9d-901f-4c64-355d-08dccc1d7ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVjRzNFZUUwNDI3WlltUWpjRkZkMFpXZ0VYUHA0QTVQRkcweksrb0xrci9s?=
 =?utf-8?B?bkpTZFJSNTFYME1VdXN4N1lSc08vazFGZlJBRUh5S0FpMkJkMDQ0YTF2Z0lL?=
 =?utf-8?B?VGh1Y0J3cmNYejFFSlYyNUR5b05uMXJISmhYUFR3YTV2UnU2b0Npd3EwOFJS?=
 =?utf-8?B?K242NDYvUFp2bDduVS8yWVJCT2Njc0hJVzFPNDFBZGk2SFEwZThlQWFVUExy?=
 =?utf-8?B?Z2VZUXE3MUJBV2ZrMWhqVVpiQW9KZHJTSGJiclBEWWtQYk1PczFoR1M5UlRm?=
 =?utf-8?B?MjkrYm1QUHo3Q0lncjFocHZxNHZhRzgxdFkvS1BoSjFST2NIOVg0Y1dFd3Jp?=
 =?utf-8?B?bWQvbmFCaVNXZlQ3YVQxMGwwOTduZnU2Unk0S0YyZURoWEJsSXByTXZvaER3?=
 =?utf-8?B?Z1B4Q005RjdFYThmZ1VQM0dPVXJCK1hvMHBkRFY1L1JzWDZTSnNRdytNdXlm?=
 =?utf-8?B?RjBOcHNSQVhOdFJkSmZIUXVVYTFsUjdPMEJ0UW9Belh1TjZtTDAwUkJLaUsv?=
 =?utf-8?B?N0dMMFhGZldzZEtvL1JQV3paUjQ3MUhJQzF3eDdVNHA2bEVxRHVMdnU5QWQz?=
 =?utf-8?B?ZzRCSHpDRll4aG1EelQvNlZxbnRoSTFhYjRwZExGNXVncGFUbjBLUU9XTG83?=
 =?utf-8?B?Y25MOTNNUC91bm9xWlEzUGZPWmtaM2tmdDFNYzRCRU5QM2VNOGxmUTljSEth?=
 =?utf-8?B?MHBLM1VLRUxtNk41YkxWWTJ2cDMwWS9IcHBDdjFaMnoyQ1ZkeVdXUDB6ZGsx?=
 =?utf-8?B?WnZ0aDQ1QkpRa3BQMDAyeFZYV0N4OTU0RWxDelBBU0cyci9QdXhPV0FqRElF?=
 =?utf-8?B?N0JjSU14NEVFREtKRXlGajZxTGN1bUxWclVkRzRlcE0xYWJiYmkvNDJFZWdx?=
 =?utf-8?B?OHRvOVZldW1mWnozV0hRcnQzVlFmMGp2NWhJUjBpaFVyQ3B0aWk1ODFsb1lw?=
 =?utf-8?B?bGhoTkVZdlFJeWMzNmltaWRxQVJ5Y0lnYUxqc1IzMDRmZXc5cHc5cHB2OEFB?=
 =?utf-8?B?TmV3MmtZS04xbFNIL054MU4xUDNjL2pnLzl1eHJLVFhKOXVuVEtoWDByOHNq?=
 =?utf-8?B?SGgvQzFaMEFRUEFZK3hJOFk3QnZ4dGYrSHZlM01JakdwZzVOc3FkNlhqVUhm?=
 =?utf-8?B?R29VNnFBdFU0eDRkblhQS3JRdEdOeXorM0JQakxINXRIVnd5TGF6b3V0MlAy?=
 =?utf-8?B?MGZhZjBJSUZvdXdEcVo0enNBRm80eVozMmNsaENTcHh0bGNnQmVST3htTGtM?=
 =?utf-8?B?V2RUMXlxSDU1WExORVc2MlpKbllWWWc3Q1RoVkVYOXBlVDVKNG9HdGdkNEpt?=
 =?utf-8?B?cHJ3bmJFd0VsNGdhVFBqNHNrQXJRbXdqQTYyNGVsLzVpbzVST0puRjExMWM0?=
 =?utf-8?B?cUtmV3lNaE5wT1ArZ3l3aHlOMnpWU0JGR3BXcFhnbVdhQ3JWOFBIQXNzclh1?=
 =?utf-8?B?MXUxV0JyczhEcm5xWVdEMUtRc1QyZlczNXRUWnJ1T0s1RUlZbkN6Y242UGl2?=
 =?utf-8?B?VHAzcVMyTEYzSnJXRkllOVZyRGlDSDdydGtFWlpwWmhKYUFVaFk1SVFCZ1pa?=
 =?utf-8?B?V0w2TnBDWFhIRVc2SUh5NXJ2QkhLTkwwclZQOUR0YWtwd3JRaC9vV3Q2U2s2?=
 =?utf-8?B?QmhzaHNTYzB2Q0tIbjQzUFVoQW9wd1VCY3ZQUnpvWlZkVWVRbG8wWkU4UHVv?=
 =?utf-8?B?VWQ4M0RPSGFRck81SVo4NmZ4L0MyQ0p5MFNvREowZHY5TkhYcis5a0sxbXly?=
 =?utf-8?B?YmJxNysyNDg1TTRFRmJIdGpiSElVMTNjbmh5S0YvY21nRkJhWHhsbjBMdkEv?=
 =?utf-8?B?TTdiMG1pUGJlemM3NFI0d2pUMWtXaUFjZHdWeTcrUDhwVm52d1NRVlJKci85?=
 =?utf-8?B?eHRYRVVZR1pBVzdxdEg4Wk1tK0h3YmlibFVocWZzelRkZUpQLzdrWjBmalRF?=
 =?utf-8?Q?JV2MIiFlkiDk/rEe9nCPuGo1vGfnDtNk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:36:56.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d48c9d-901f-4c64-355d-08dccc1d7ab8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

RT_TOS() from include/uapi/linux/in_route.h is defined using
IPTOS_TOS_MASK from include/uapi/linux/ip.h. This is problematic for
files such as include/net/ip_fib.h that want to use RT_TOS() as without
including both header files kernel compilation fails:

In file included from ./include/net/ip_fib.h:25,
                 from ./include/net/route.h:27,
                 from ./include/net/lwtunnel.h:9,
                 from net/core/dst.c:24:
./include/net/ip_fib.h: In function ‘fib_dscp_masked_match’:
./include/uapi/linux/in_route.h:31:32: error: ‘IPTOS_TOS_MASK’ undeclared (first use in this function)
   31 | #define RT_TOS(tos)     ((tos)&IPTOS_TOS_MASK)
      |                                ^~~~~~~~~~~~~~
./include/net/ip_fib.h:440:45: note: in expansion of macro ‘RT_TOS’
  440 |         return dscp == inet_dsfield_to_dscp(RT_TOS(fl4->flowi4_tos));

Therefore, cited commit changed linux/in_route.h to include linux/ip.h.
However, as reported by David, this breaks iproute2 compilation due
overlapping definitions between linux/ip.h and
/usr/include/netinet/ip.h:

In file included from ../include/uapi/linux/in_route.h:5,
                 from iproute.c:19:
../include/uapi/linux/ip.h:25:9: warning: "IPTOS_TOS" redefined
   25 | #define IPTOS_TOS(tos)          ((tos)&IPTOS_TOS_MASK)
      |         ^~~~~~~~~
In file included from iproute.c:17:
/usr/include/netinet/ip.h:222:9: note: this is the location of the previous definition
  222 | #define IPTOS_TOS(tos)          ((tos) & IPTOS_TOS_MASK)

Fix by changing include/net/ip_fib.h to include linux/ip.h. Note that
usage of RT_TOS() should not spread further in the kernel due to recent
work in this area.

Fixes: 1fa3314c14c6 ("ipv4: Centralize TOS matching")
Reported-by: David Ahern <dsahern@kernel.org>
Closes: https://lore.kernel.org/netdev/2f5146ff-507d-4cab-a195-b28c0c9e654e@kernel.org/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h          | 1 +
 include/uapi/linux/in_route.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 269ec10f63e4..967e4dc555fa 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -22,6 +22,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/refcount.h>
+#include <linux/ip.h>
 #include <linux/in_route.h>
 
 struct fib_config {
diff --git a/include/uapi/linux/in_route.h b/include/uapi/linux/in_route.h
index 10bdd7e7107f..0cc2c23b47f8 100644
--- a/include/uapi/linux/in_route.h
+++ b/include/uapi/linux/in_route.h
@@ -2,8 +2,6 @@
 #ifndef _LINUX_IN_ROUTE_H
 #define _LINUX_IN_ROUTE_H
 
-#include <linux/ip.h>
-
 /* IPv4 routing cache flags */
 
 #define RTCF_DEAD	RTNH_F_DEAD
-- 
2.46.0


