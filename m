Return-Path: <netdev+bounces-218657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50161B3DC7A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559A7189D342
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406832FABE1;
	Mon,  1 Sep 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwf8k2sB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D542FB604;
	Mon,  1 Sep 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715588; cv=fail; b=KYRxcxoW09r1SQQN3qFPqvw7XPtvEMYTfjeEVj6zoGuNRSd6yFuqSlFqk5MoyLDX1V5cF6ZheokfWgAIcgIh7kqOK+3L/DfH6PK0uT0IB5rdzEKvr9qKBSPqsmQzDpz94q7+BYUzzI/248wXZVR3zmeIqxqpSx48qGy/RMy91EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715588; c=relaxed/simple;
	bh=25H3YgvFWg1o8Ip7UEWSEpO5Wwwka5EaCIIGgbd15EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXYxTN4xF6u+CzK+IZSq7O5AOrJ4Tc3qkFQiamgymVtthaYmg8SWfHhN4339ztrNJCIU9EngvF532QWiOQOgbVwct7HdkEtsR7H0iqez/ZPWw5cps57FCIqSeZD1pUyODVIqoIi1En7o1pRdaMOqG7i6CGFFtmOrhH8XCjYVn6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwf8k2sB; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmucsROupAYzWW3d6BWKKRUxbXiGTViFRKi1gJkG+et8YwLDdlQXKxRr7QfMISC8r0B6RU0vByOfBazLz5mQkGirxLF2vOgrRfrAc+mAtbTP73RhtCODtuupiR+mAX/3wRFIOOUQpdCMTf4Dktl+J2cTHaAKVYLXxvQLYKxhnkmdwOq/Kq1zIXC4B5GBD3MVLTSN5LG6PGE9o6Jhbi/9thp5zHsV6LaA2uUyDre/2qutcqIp+Yvqcrd44vjulcL7/7JjqiYOdu7aO8XtY847M7yjtpEXWYdB455RM0+j5/ErGL16HHPTlqTSJz5t8Hlov4Esqw/UKJp0RGdhLg+cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNOLMX0ttIAE7TpKDaFYlFhHU4W+WlV9OmO7pFl+w/A=;
 b=rjGdD6pvYdNZfPVX9Y58DfeAGN+ua5Y3wDGXy7Pcm6y6MwrzdqdikymA5SkJMKQfSenmgNb3Q1oRDqLj8UkHYF/hoDQgMI9SDBr2b/BRSLbobQB3PhJVPBlzfyb0g34Ai+Jzmrjquna0qmeGcepkThzeFp8Z5dBmLP3YH/P19PHfI2Lyt6GcBsMiBvKIw2gAHupDfIilmu3r+uiR6dhQzgYUrAlrsPyUFfGeORkKEsjN2zRzdB7+6WvpZknITxyraNkJsu4c26O4IrXGb4lbiDy86ixwonVhm5wKQTpdS/L0pmgAzEoLV3JAsHyA4KLBESqWIHfD+nG20pDEd86KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNOLMX0ttIAE7TpKDaFYlFhHU4W+WlV9OmO7pFl+w/A=;
 b=dwf8k2sBlL720SMuOz+8ATWPqpoVTuPPSx3fnGNZ/MnYvHtWRKnb44nin9iVjEnSrnyOwLYNL5enki3JFISS6IYSyFuNbEmgympoUpc1U4u8xG+N8871yG1PZ2xmtjZbThOS7tg/XULNIQ45z6oVY4/2NgcfbNAX4MhmTG60zjIrFmPNFOb76/2RBey87RCCW/9ZdsP4XLpCfkKaysOFb7gxGeAs9Hu/bY0oBeetmjh0jqDdq6O7zZ2r8G6vZ6/z0KoVXUWgbn2yklxedrUCRrI0p2W0EenPJcP5pYCBymMVXJMBZn6BGZsC37DJ3Ctyg7qyRSBNWYYkJpvm3gsHyQ==
Received: from PH2PEPF00003850.namprd17.prod.outlook.com (2603:10b6:518:1::72)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:33:00 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF00003850.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.21 via Frontend Transport; Mon,
 1 Sep 2025 08:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 08:32:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:42 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/8] selftests: traceroute: Use require_command()
Date: Mon, 1 Sep 2025 11:30:24 +0300
Message-ID: <20250901083027.183468-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8a7da0-2d7c-4101-c63d-08dde93228e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oojVlddFI7OjsZjBn2EvcOOwxEm0zwET1qRcgAYUBhMQb9sMiLAqXVU9kxfU?=
 =?us-ascii?Q?JCItuBoVaXUwNodQ5+C2VzhGYYDmXErTGvrlMrwZCLMucLrFasw2oUe/tCGj?=
 =?us-ascii?Q?w8GPcQ28JFum9dM6C7N5kd4VFsR85BKMQFQ2WkvMiYHCM6y1BpTzwlma8K8F?=
 =?us-ascii?Q?zBIXVLMZ4K19jLlUw87od+WkaLAIuBRXuN+4g2J59qE0z8528+EXPvouCzee?=
 =?us-ascii?Q?XmTy30+T9yatFyc7Sbayh0RWQ8zZ9LT0xJDzkeaWLCIEwOQRrF4GV2v4ZBy8?=
 =?us-ascii?Q?If9KbBZtvvjn6biSVtG6aPwjwy02DUKW92cQulZI8XTUntxcINvjNIoPCbxL?=
 =?us-ascii?Q?0mXR3kPuODAkJxrSPisq6NMTKwk0PNijuWnn3m+hv8krCPYsBS/IPl7tfIYw?=
 =?us-ascii?Q?RxfIW5j5mlGltYOGQChyztYbL72g5lHf2vGpCCTIOhPiVrYqy1RARzGzXoZm?=
 =?us-ascii?Q?pWUo0dGT+NPQoetEEm59zu5P9MPJ6AbZoliwgkEUoi6TCngzuuzDcryUJ045?=
 =?us-ascii?Q?rUL8wAQiZw8yg5RpdpoMsOVyAwLJRseN8nzWqC2WLyBPqX/NHHqh2oYyDIzc?=
 =?us-ascii?Q?FLm6ZlhIi4QMB/smfqAn6d1GxRaDfn+gcTbghEjuj+uY/ACU6P0K9I9vkJRJ?=
 =?us-ascii?Q?PaspdbIAKkfiX7nZoXvUXUCXNXZzO8IqZ+tHXN2jQYfLQZrLirKW2tscCtcl?=
 =?us-ascii?Q?2UROXB3oduKW9Nta3wnCtrP2AlXQFqeEuFhW3OLlLJjyfY0kWoQ+67JAkny4?=
 =?us-ascii?Q?xCK27MHjHzEzRGxPDPE6ysyQ6g8CsuDpBnwLfi8N06VQGkpIrjgAWlB6NU/q?=
 =?us-ascii?Q?8+b7B3PX7aIY8hTvpZsBOlWSOUz9UIeWLGo5eJD8nd6pl9W8iIBW2qXxM++4?=
 =?us-ascii?Q?vdHi3fD7PE5Io8NCEGnyrnJWX3nMGLBZwZQMQ5iGyUCpDMmHRTmbEiBdQc+F?=
 =?us-ascii?Q?+NRMRNUsAH/gsjXjHDVb5rywdKq0LZCiL9D0ssFV/4hEvfBpYP74eWSF7UZ4?=
 =?us-ascii?Q?DRrryMYQxhfVe6WkA4n/xuee/ghHjziFuTk37EDuYZfnAAzYPcB5YWKLVCjY?=
 =?us-ascii?Q?jFiqQo75PegDw+2rK5zzTCoLW8hUJiOA/UFeOEcaWBpTld0VVAFv4RM7SiSw?=
 =?us-ascii?Q?73KgKv/OmqjSCM5GKbXskrX9Dgob9D9x6VzSNkkorNt2zNEUVTAi55Vr69as?=
 =?us-ascii?Q?VOuILa6uoSNSEp0ZxUe5f1kr2eLQL8gToDabar1p+Om7SE9czJK0fBbuCFk5?=
 =?us-ascii?Q?wDjySTLmYIuOX3EHWon1HPr5PcTQFD6eQwxATIU+fc4yCg+HJHj5+dzb0W68?=
 =?us-ascii?Q?c1Ie8lODZneecVKWN1RBaQ6wHmwEWcDrQqq6/PY7H8ALg7C65sbnzZmeTTnP?=
 =?us-ascii?Q?/tupA+llZ4nwPO/CfZT4jX0s78OX2mXb2ndRVcNDySCItZA43whOPFigC5Lu?=
 =?us-ascii?Q?ASDHtW6v4FHBlIVC0lTmUXWxE5CIZHpj0E3Vu/SZxS26N/H14yYSTrjeZIfy?=
 =?us-ascii?Q?+N7Jzk3X1R8jZu0VwB37LvsaFvqCSv/buJid?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:59.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8a7da0-2d7c-4101-c63d-08dde93228e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

Use require_command() so that the test will return SKIP (4) when a
required command is not present.

Before:

 # ./traceroute.sh
 SKIP: Could not run IPV6 test without traceroute6
 SKIP: Could not run IPV4 test without traceroute
 $ echo $?
 0

After:

 # ./traceroute.sh
 TEST: traceroute6 not installed                                    [SKIP]
 $ echo $?
 4

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 46cb37e124ce..1ac91eebd16f 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -181,11 +181,6 @@ setup_traceroute6()
 
 run_traceroute6()
 {
-	if [ ! -x "$(command -v traceroute6)" ]; then
-		echo "SKIP: Could not run IPV6 test without traceroute6"
-		return
-	fi
-
 	setup_traceroute6
 
 	RET=0
@@ -249,11 +244,6 @@ setup_traceroute()
 
 run_traceroute()
 {
-	if [ ! -x "$(command -v traceroute)" ]; then
-		echo "SKIP: Could not run IPV4 test without traceroute"
-		return
-	fi
-
 	setup_traceroute
 
 	RET=0
@@ -287,6 +277,9 @@ do
 	esac
 done
 
+require_command traceroute6
+require_command traceroute
+
 run_tests
 
 exit "${EXIT_STATUS}"
-- 
2.51.0


