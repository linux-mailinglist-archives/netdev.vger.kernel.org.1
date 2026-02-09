Return-Path: <netdev+bounces-257951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HHUATnniWmdDwAAu9opvQ
	(envelope-from <netdev+bounces-257951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:55:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1310FEAA
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18AC3005AAB
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA813793D4;
	Mon,  9 Feb 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NdAdQeP7"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01523D281
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645301; cv=fail; b=T+B6moHqDjS6uBnbc3D0PoQb3mJQ9u8nEH86vq2aFtDLgy+wwJvALqFu9EcrljOeun/cq8SPVwrbJs3gn20HWapiMUbUk6QklntjoJiD1LRzf/gVpCSpJtkQdQxwqnkT9x1VwZGvdbOExRam1Clixn+VBoEYyPAhc978UsZmYD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645301; c=relaxed/simple;
	bh=4HvrtREvPp9jvvrOvp/8ZyRYvnXMAwkm+N7CvGcm16c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jcC4dIzGUk/MAU1niFlHMGFd2MGJf2R3j7tfMf5orlxjYKjd76MihqIkVSlFqZc6zZNjcUCcrG02WS/BLkQOdK0rKUsVH1GE9LF+jE6dRTy3AC1FaVCNa79WnzMCI7mx0BnY3bj4bjPmauX+koZ22Pj8/9GwV6eJVWkP0rmP2X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NdAdQeP7; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHaDQhcqfmyY6O7GHlDm28xDXx7Ro2weW5/B8an6Ecl/WoHL0zsFMl6iX+HOuO6od/LvSp63RcwbmPIOs30soug6pQ6bQueZz2+cCo8wNJqS/dND9hIAEbDS1TqkMJy6rhgCecW3SglpSlSzBanvzwfBvcFw3rTJd0FxHpLh+HW9K6Snypd3PnassTABzA6PnV4VI6tJHQwCiX3NmkJ/LgSJ3ogebIJCHaL5CH5xMBB+wIHo8j2OczCkhQ5zu/t+IdRBiMEfMvtIMHxdgMhCgTBkYNvINucf3uKTstko75/8j/EiyCb3Vb5fdrg3ValkGx/iGHR0IAxh3Enh01DJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpATTu09WXnlIUg8e5K4rVarBRJ8GWULX3pcM+XAYi8=;
 b=LmrPjY40HYFbPl0dTXALWdfYKutHDErMPidPV5wg3Pc1IlZYOp1PDBqZgKluDzlaSf8ST2gHFfJdmUqi7o1i7uDB5eUp7xK/Ph6mGBA3Z5zgGMfbQ/OxDxaZrTi3NxI0OAJP8lJOtjVrcbttFCQTKKdNhUU1N0nn2k6/Als3h1ISPsy5dE7VOI8S3fwll4mJXzkFqNNlWDV0PsZ0eWz4QdH+Aaz1QEgPOy3Ij4MSxKOevlW55ZU/hJm5+k+7OAHyNFX9APfnWEggLHXR6CNdqsXu0lkQl1k9JrB4ypBAFaKTfi+dl4vNEQ8UcpSNFMc6Xp0G7Md4X/OUYx+wMcRAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpATTu09WXnlIUg8e5K4rVarBRJ8GWULX3pcM+XAYi8=;
 b=NdAdQeP7usemiItvgv+UYpq91FWLp2p7XQCwwUOKy6dOtH8tN8efJ3deJ7ANgHrIPnzT7X6rXOkK6PQfiSswH1K3OUiQm0glJWVDZw8E2hq3S8I8yeNQBYHzG0RflQtCwYGL8Adt80BVXZEuDXcshZDxKXLPXsRhv/hrVYt3mtq577lQ6JuOtgK15Ch1BYe+9/2lGZO6lZUBAZEhHOF6E+Lk1zz+E1tfQtxayexDJTHFu4SuxwPEUT6Bmehune4xiXI01zSrywuUHvvDuvsFWdQrMhp5Zxvky0enqEqXOGv74A1+L2quypj53AGs8A0YUd99Tkq51A7mtAu2a3WPhQ==
Received: from CH2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:610:57::17)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:54:53 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:57:cafe::a6) by CH2PR12CA0007.outlook.office365.com
 (2603:10b6:610:57::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Mon, 9 Feb 2026 13:54:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 05:54:34 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 05:54:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net] selftests: mlxsw: tc_restrictions: Fix test failure with new iproute2
Date: Mon, 9 Feb 2026 14:53:53 +0100
Message-ID: <88b00c6e85188aa6a065dc240206119b328c46e1.1770643998.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 985b71d1-1e49-42ad-3db1-08de67e2cc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jFI0Iy51CEfwn/q94GE4XZmXj9Fp9nZ6IGWTDppAurV6r1y8jWCsCUt1RnPs?=
 =?us-ascii?Q?rQ9d7fX3q/swPAPz5LZHJ/EYY+3aMJcHDc4lWs7fXLhAX/EDx+yQnqeYkR/E?=
 =?us-ascii?Q?hIgsf7McrfRpUeGDB2+yG1mcAfdSCbpHy9u+a+X7w4wG3c18iCp00HVkFxkB?=
 =?us-ascii?Q?xsfeNZYl79BU+xs/4yh1ouOZDbX6AiL+KFeD4/fd8LnuUqpDLi1LCeSRtDvL?=
 =?us-ascii?Q?PPyc3wtw90Hvchi7dTGzWm3C2pOxlQtcpw6mJde2qA7SabOmoiGhphpVVWJJ?=
 =?us-ascii?Q?jtYAGLN9pY51/V136tPJL5k2TGFKmwFgff2WZRWlOH7BHeZxLFUV68ZQL71u?=
 =?us-ascii?Q?ee2+hljaKJhLa9sOcKQLEyBc49NdJ0p1ui+dQtQD7VPqt5BRRTmj255q5Ex1?=
 =?us-ascii?Q?DZ6WVHS+w3MqAfkTvbQErjPfSzhdIbnWCsX0LwlDZKVoZ7hSVfEABMD1ULQG?=
 =?us-ascii?Q?amGNIZlO8no3wDU20gHYwaALXM8XqV16PpFzNmUXGNC7f48V/ecCVmM9gh2H?=
 =?us-ascii?Q?rSuon6ir/DlLizHox64XtGyNdFk/435haqDmvvN3hS/EMj0I0FC8bBLQMd5p?=
 =?us-ascii?Q?M99x/gAGxkp44YHUScWrmmXT9elTqftx1NgHMTyuQNFDQ/mLEEXHJNoC58cE?=
 =?us-ascii?Q?gtzjYjnw99eUqk7IdROyD4emxcS2KO6F6z6VwxAoFdbdk6jTbQ1L2kn1R9Me?=
 =?us-ascii?Q?sJ/zrl+XSGBywl8wUNNSY1NZETppCjDaVJaysO3gezuvXxktjNUbVDGG5yCj?=
 =?us-ascii?Q?XDFFjZqh+jbCGeyku9T6CUDLzw8gU0/mw1G2Y59lww7i5AKQSBv2jv4WsCkA?=
 =?us-ascii?Q?byDsG6xpiiq9zAN2zkc6ZI8HOZhxN5msITRZ6wxY07ruWopZVdPv2XVGZli+?=
 =?us-ascii?Q?8GmuBlgwb5EJJzBlQ6q1KCI8GsCSX0cEcjX4BAJm38R7cAgFgJZC3uO0N9bs?=
 =?us-ascii?Q?ie6q8YZFnnRNB3ksHVfEo0CI9zVwx8xZHPs1VVkO/U2Z4q03cQ2FMIB43Tii?=
 =?us-ascii?Q?45xTYLFKyiNj//AHz3SdQmv2oAGApC8Db3od6JfGI2MOlSFFYPKoc7C0CPNJ?=
 =?us-ascii?Q?noBil2U0CW1fTmO68F6AXIgaPc8IfDcA0SCs1HPXvUYI+Z5iyrUXw8PlBFPf?=
 =?us-ascii?Q?SY/F97YvEGSsaEUiNrmlYeEoQ44pZbUwNQOMxLmevksFHi4Cew6wNtsx2yQm?=
 =?us-ascii?Q?qR2XA2RK5ar8YZ2irY1e49ynQ1+q5FvnOjFmXwx4LKm62yoMgITmW1ybU6+H?=
 =?us-ascii?Q?5yA5J7GrYhHP/JZMXKqAa2HwuA6HawZcHYecJirYKUIfp2JTzBG/xYBGJ5he?=
 =?us-ascii?Q?zsYLgOwhlNCc5oK6U5XojR2e2ooqPteIOdszF4A9jYijTGktQl7PQJFyANda?=
 =?us-ascii?Q?AeoNtn+o+yI6VxV6EX+NU67tyPVRh4M2eKHsR7V34pl34C+JOi0X4KAIwBEn?=
 =?us-ascii?Q?izu0Yt3IlMMZYZ5gUt3eUfh+HXeybCgjnnNVSsZ7SvtrWIrwxgZHeYfvKXvp?=
 =?us-ascii?Q?2m10Ss/gBy80OFymvHnXrEKEeGoUhO0YU5d1jvybU733YI52wo6ZtO9V0d9/?=
 =?us-ascii?Q?tjN8BQxvRzWF3CE0OtyxzybuXqE8Puhwji+M0jgSPQb6BN1EGtmjehXphSjy?=
 =?us-ascii?Q?OECNpuXX3hVCZvuX/8xDyrVaN2uSpJItMLyccu1Xr0KaMO1/GMpAiWklJC1U?=
 =?us-ascii?Q?VAgVPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zvR6rD+TuNq/h6d8tWJV6ajWHuCrMiTxdrLDTQfdWe+pGHoCBXCmacztLpPUzHbrplmPnRyk75KBXB1bmA1USMWzGIpzROoVvlVZjsP/z+Iaaxy04CCvZ9mtv1VZHDwcBjtLCrPElL7q1YwD5PrUY8rE8Iq6UWU6/wADqR3ww5VEkkgc7P32weGeDjXTOzoA1crNsZR3/cIl347GcdElpdvjevL/3glkm3AJoHM0qInSGucbRg79XwMDysF31cc+sGSrS8G1IM31qeHI4n2Xou97wlnHrT9aOfxF9fEw4kXDbScwOYhPxUtcowJX3rjG7WUrETMyif3PGzi4IrJn+ujbsimWqg3aB0W3B5yu10AQbswboJWh1iJkR3Xp24drNTYH7EYXh3Dw0+2QDCo6K7tguyEyFVERijvrb9l+gXAoSaXs0H5p3K5X8A2RZ5OB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:54:52.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b71d1-1e49-42ad-3db1-08de67e2cc85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257951-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 83C1310FEAA
X-Rspamd-Action: no action

From: Ido Schimmel <idosch@nvidia.com>

As explained in [1], iproute2 started rejecting tc-police burst sizes
that result in an overflow. This can happen when the burst size is high
enough and the rate is low enough.

A couple of test cases specify such configurations, resulting in
iproute2 errors and test failure.

Fix by reducing the burst size so that the test will pass with both new
and old iproute2 versions.

[1] https://lore.kernel.org/netdev/20250916215731.3431465-1-jay.vosburgh@canonical.com/

Fixes: cb12d1763267 ("selftests: mlxsw: tc_restrictions: Test tc-police restrictions")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh b/tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh
index 0441a18f098b..aac8ef490feb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/tc_restrictions.sh
@@ -317,7 +317,7 @@ police_limits_test()
 
 	tc filter add dev $swp1 ingress pref 1 proto ip handle 101 \
 		flower skip_sw \
-		action police rate 0.5kbit burst 1m conform-exceed drop/ok
+		action police rate 0.5kbit burst 2k conform-exceed drop/ok
 	check_fail $? "Incorrect success to add police action with too low rate"
 
 	tc filter add dev $swp1 ingress pref 1 proto ip handle 101 \
@@ -327,7 +327,7 @@ police_limits_test()
 
 	tc filter add dev $swp1 ingress pref 1 proto ip handle 101 \
 		flower skip_sw \
-		action police rate 1.5kbit burst 1m conform-exceed drop/ok
+		action police rate 1.5kbit burst 2k conform-exceed drop/ok
 	check_err $? "Failed to add police action with low rate"
 
 	tc filter del dev $swp1 ingress protocol ip pref 1 handle 101 flower
-- 
2.51.1


