Return-Path: <netdev+bounces-150138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22D9E91CC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AB616603B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAF2185A0;
	Mon,  9 Dec 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEoYy0zB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971621764C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742496; cv=fail; b=RRaA1jkNWQhtpQkmdPjdEzuXt0oJhVoPYHZZkZNevVQXVLEexPrkozG3rwEK3dwDWfWwTmH1Ivm3PwKBsuJtqEhGAASIpHwIdnCvd8UnhPijnPvBWOhJVu8dJKre8vzr7DayQNgsN59NYCdox8u38wSL0xHqnooQDSly0cHWaMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742496; c=relaxed/simple;
	bh=DMu+eLqBpAFzZEH9MzJOQomgUVxD2CiPqJ3NwchMJxg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t85Tyxm+EaFOttkwAhblkyGb94wQPzsqBpvldSRUH1WdxeqjDgBglKLn1V06Mc/ZaTks0e2vxRoHmZRZbd/p90eXvc+vvCb/N7qtYDj6cqEedZc1c7rzBhco5487STZPBNe3pae3F1PwD7hKoLCS0mDezVxsggRZBqrCKb0gTZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEoYy0zB; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUS3SLgistUq2CH5LTy3opwiRF3z/tuvQSPKEEVCrCBUBjSq08G7UBn48IdMM7ln8BcxsNXfUPmzorGZu7+dUdizFMXak82VZPAvt2LDtrhn6uhbWfNnUx1SF3Ag63D5dl3pNaxlZQMa3gSUZSwv/KI14C/D4doP09/SoDEo0XggQhJR+62s29U+KD9n/RIBhxOkpjM33pGpWSWTqU2FPPkNDdy1Uus/U5bgOEBn8fDoXBE8VC9hz9bNyqo/s0Fc1aisUWsbS2Ub2pkTymTzJIMaoq+1AMRJrtT8rPC4sC+hl7/E5+UXEBnPXhVZ/tp3Cqbbt3RgfE0bG4IyPveyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOtD0W2IVpM6SSUjiZfIb2Urn0vJUC9romWHSTPS4tg=;
 b=CwYoJJW8d30rbEueNka30/ixW0SVajYU3lE1Gapagh6KYsrUYGzPXL2koEx+TU/aqnFtzdrdb52fjb53sfsaR9DBXZTH1QKlCcOdngX3vFzGQHaGlWk/zDQCcYfYID1zjnQ9DOYgw2FwWMnNLsJhxqnKM8nK6HhbZoKVcQ9NjLY1bONO9nnMAwxX2NcpRe6AVRlodyO1s+eWPyFSwolNc9TTLIfWw23Dte0Bpq3zGy478uBwV4YMgyW3itDIPHt51WqXwF4kRvgbWcM7AmlQGEY7LkXi38UjXOzEOoVWhJ5BXQJmHyyHRRI8C+2t9NUtjrz2+/ZskzUvNYKWCpWNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOtD0W2IVpM6SSUjiZfIb2Urn0vJUC9romWHSTPS4tg=;
 b=KEoYy0zBz7nZQmu4n0QzeDJWtF+vm5IOPEUj+3UrYFghxUrjq0Ncn0kwxqS4M/ed50m1oZUGOAq1yXhY8qPXtkXktHghdStGvsp2/8PzjwmzLfGvTe0dOmaZs59EvCCe9zp0AuaupAw/a4PCCiJDiye1Ima5CXRx4D5GAhqkUQGCbTlv1/xbCeYFgLU0MEUjSW4PaFjS9s1Oc5afzkW3KAxjfLqbmTvXy2KsxnVk8qlvRBFbBCtMcOxZw6XnHQxKAR3qXJo8CtAX3QLOHJXn4C423Al98pAEFdTBCiANj5jbqlYfdsrFKC5b6rF4YwVHKjQPN+zwAOFYxEHSaBLJaA==
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Mon, 9 Dec
 2024 11:08:07 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::6e) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 11:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 11:08:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 03:07:54 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 03:07:48 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "David
 Ahern" <dsahern@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net] Documentation: networking: Add a caveat to nexthop_compat_mode sysctl
Date: Mon, 9 Dec 2024 12:05:31 +0100
Message-ID: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc0e20f-9863-4f57-2f8e-08dd1841c282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tPSi2oQCqadvYAKHZUaoTFcFonM3i9zwjakgToK158UUriI8MuZKnf2WHj7t?=
 =?us-ascii?Q?RViU6B6yTefLU2f54uPf4DcKWfLLatSAYO6ygYuS4bMsxs0Y4sekLNFLJwbz?=
 =?us-ascii?Q?416zxw3J2XDQGCUe/2qfnKiZwG/HvHVYfWj8V8ez6ri5OYREyU5J95cF30uz?=
 =?us-ascii?Q?P+DQOIyShimsXM8yKHQFUN3pHcPCYmVfM1QpRndTg59wHt6CVR1lWh5aim7C?=
 =?us-ascii?Q?eeVclrZ6mGum2yC4p2n9A86XMPOkxbPmsbBfBrSOhqahcKEFCihqcowaClXk?=
 =?us-ascii?Q?7gz8OmrfE3FxTbzWxTPCbxet5iiWTcKMOaVRdsqEibVVK4GU4rOYIVqkQJnF?=
 =?us-ascii?Q?+NUTt81RLTIHbu26GGk4YoS4u9FyrYqk2bDZds3crPOe6xkNiS1KlSvwCZcJ?=
 =?us-ascii?Q?LwAInL/RIPs7xNAFuL/yL6cANOWzZMbfhiXdbXZeG03yoOyoC2tdlh0lnam5?=
 =?us-ascii?Q?1myFLY7b2U6tyLPDsuKmROxphtdQP9aNWNUTYlWFizirxsrF9k0AqcR0R0nv?=
 =?us-ascii?Q?m5d4k3kLLfDV1ca+bCFwXU3+0UM/Dcv1/9QaYQ5KsmdmZe75wkzF7vc/Yl4l?=
 =?us-ascii?Q?1uJ/CtGvNY09gihxXup8C966pbJx36kPb1KxL5yCF3acVDUmx9aKkJramkRh?=
 =?us-ascii?Q?sJYeyeJKHUJtR9GK613pJT4SyMQvrDGqs+Kp0qhhSIBue/XgavuACJCU6zd8?=
 =?us-ascii?Q?XPeofpdzkDWVLuAAUbwm9HnrLEy6cacAkZBRhqfyaRb/bzJnN4l/xh4O5ifA?=
 =?us-ascii?Q?NBswbrHl5/QuZQzncErJ5rX/H5G43Q2ojjo3CIFkdFbMj7PA5CDiUIsiMSx5?=
 =?us-ascii?Q?CdmacNg85M7XBX0Jtz0gWuBoicAVzGTVjZpcv70f2mj14GpNKFaLunp7SdFx?=
 =?us-ascii?Q?QTSKNvDRrPbx6weTMg9yrzVjchlAdqrz2X4SUr+Bwpa/FR+whvqL1EF1Clt0?=
 =?us-ascii?Q?AI5DNWvUQWOFx4dnFzkXbze6oSoPQnrQF6WTAbOh/c4c3J1SVZ0DSRUZK3jt?=
 =?us-ascii?Q?JGvu/bZ2tNYBEVnULy2h7hjAyCBJSYYTUW+ei8sQsLlNGOcvzUwe7t7g/OKe?=
 =?us-ascii?Q?dcCjICTAA2Afyi8L3apgIIr+oPjSSnOCB8wqFV+0FFVo5YQM/TdSG9xNk2H8?=
 =?us-ascii?Q?+BeeTpH6U9T9A6E/gUaLn27chUtYD1MXkZZnfipBt39MZr4FfrIRuiMPE0NG?=
 =?us-ascii?Q?ukT6g5WXYXiceXTFYSSrEg4FWGqNgVNR3TjEDgcxqtgrRCGQc78JAjKmswmB?=
 =?us-ascii?Q?/yTlELKLxcgl7+yZYQStO+Gqqe+zJjeQPlCmQQLvWDmClrBZj2P1v+KvIm6u?=
 =?us-ascii?Q?B8YgZ4ADCBJ0w8UdBwhUsjQsX/qaDDpMv0YmD6vFii5xq2W9bpURShkLk0Y6?=
 =?us-ascii?Q?NrGKv0RowY2JVEV/Qy3VTs31lBYOG1AXrjy/moH84witAE6T422LjT4MxdvT?=
 =?us-ascii?Q?WEnrVfCeMyLj93TXgYpmnkf5sDKENDbF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:08:07.0168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc0e20f-9863-4f57-2f8e-08dd1841c282
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

net.ipv4.nexthop_compat_mode was added when nexthop objects were added to
provide the view of nexthop objects through the usual lens of the route
UAPI. As nexthop objects evolved, the information provided through this
lens became incomplete. For example, details of resilient nexthop groups
are obviously omitted.

Now that 16-bit nexthop group weights are a thing, the 8-bit UAPI cannot
convey the >8-bit weight accurately. Instead of inventing workarounds for
an obsolete interface, just document the expectations of inaccuracy.

Fixes: b72a6a7ab957 ("net: nexthop: Increase weight to u16")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 Documentation/networking/ip-sysctl.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index eacf8983e230..dcbb6f6caf6d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2170,6 +2170,12 @@ nexthop_compat_mode - BOOLEAN
 	understands the new API, this sysctl can be disabled to achieve full
 	performance benefits of the new API by disabling the nexthop expansion
 	and extraneous notifications.
+
+	Note that as a backward-compatible mode, dumping of modern features
+	might be incomplete or wrong. For example, resilient groups will not be
+	shown as such, but rather as just a list of next hops. Also weights that
+	do not fit into 8 bits will show incorrectly.
+
 	Default: true (backward compat mode)
 
 fib_notify_on_flag_change - INTEGER
-- 
2.47.0


