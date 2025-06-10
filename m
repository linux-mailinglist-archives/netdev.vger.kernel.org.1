Return-Path: <netdev+bounces-195963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF17AD2E9D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6934516804C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A527EC7C;
	Tue, 10 Jun 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/oKflzC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B127E7F0
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540390; cv=fail; b=f9J+jJHgxRSRrMDTuA031oks0MpMlTbAt50dkn1gbxw5m6ENPCoH5BuYCMkVAM7+cn5kjOCW/WbSP3wJzdqFf8ARINMv8wfY0FupqqULGxmNPCh0x/UgUm8qVyLZ9t+NfkdN3RdQMo4rpz5XAril9jJaeSMwczTetBowTHig8uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540390; c=relaxed/simple;
	bh=UaYRYjrzR9gz+OinMfnj6ePSuPz18aWpG14CsKUQzB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESxR1tgJgdSpo/WZkV4jAyu+5G7zub2q3piU5oY6Rz/2zqm6WH8v2gYFmEeB1Nu5z22Klp5meCubrcJNMjwvoSbLc2xXKLgQXKXhjGiM+2flpH/gBN2jmn1O6dNqG279sgCveR9wHNmR47HKIdGQFnguu3Ip/ysueP1oSjGLf6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/oKflzC; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYEnUahruFO31ZUoi30XPrwa/3r1oTh5bbpXeKAuQ3OHOQfpnrNZ6SAc0l/M6jjnAEBP5aQOzGFYFrKRnX1acfywD0FzhdaBvAGLj5+K+iZ+d/N6ALf+gZ35BucxzTSaEmmoRk4SpbhrvUWd+DNAAHUg7l+usq7IbTCbYyYOnmH1SxLfMtlZ7u75kM0cv0c1BwNRRktrQEnjMssqFrF1QTVHnZhozfF7MWWGNdXSc2qN6lNRwjUcIpYUrYviHcQMEDygsi7pb9WidQ5E1hnBzOolmpyUaqbPCCwaiR7J8DhV7S+7ynzD8oWa5GcUZPalXp+AckAq/gMKOJI9U45b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eMbbHfl9lKAZpCIaxtc96/i2n5ytUg5en4G5hYUveE=;
 b=bHn6O+n7fK1JkHVpS3ea1ckHznIelorn1+rlunRSqhCWJIvfihhd87OXqJA9ytNI5KNtmdAgVxkZMJAimrbCjsT67Vh6NB9BZpkdE7ekROxnuUihiUK1GtQpK7VRu2IeXDSEaTTL1NqOslFjkZPx/AWuxZm7C+xeNApWismXCOuno1wBHdO5dicVcg7JbpNNyWPevWZBpx0nQ2TthtFGxL4/KC8iCpwsJbhR8mOjWB4yvPRSvVhlwLlpcHN5qJLyehEUuf7EZ+TMb+6XakNXn5MUGZv1tbJtQxy+fy8lmNxrvRjzgbc/NhWFHzykBMFfXL6typyp8INTYJz2qC/uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eMbbHfl9lKAZpCIaxtc96/i2n5ytUg5en4G5hYUveE=;
 b=B/oKflzCOBQCOY2tgXl1Cg87q1yNSXPeimM8h1fCWjTXMFJuMUJc16B/6nFOpBRxXjgVrBZLFA7SB6mCd6TBQdiQ3sRWJEzsLsNrLBYOLPCnkRjP6on5CEj7Typk5JRTZ7fLZA3KV3oVGNpoki9WdDOdTL53KgYh245/ZyLd1lxILGTI2cl1NlOHLg0TyySn/kxxdE+iGz873mNpMuzqCWQ0/YP42tzdxjEdOHTnRTInhkr+6+dOr256uwaPr1dAC6Xe9OeLKsD+nNWkuWjM/cAYiliBlL6LgakaCwIeLkVR4ZvkyiMA9Q66NqeVUfXAyB9kDM3WQbgzSWbqaCfC8Q==
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 07:26:25 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::7e) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 10 Jun 2025 07:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 07:26:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 00:26:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 00:26:07 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 00:26:05 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 0/2] Couple of vlan cleanups
Date: Tue, 10 Jun 2025 10:26:09 +0300
Message-ID: <20250610072611.1647593-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: abed126d-e5b7-4011-5f90-08dda7f01b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUVKNFdCQnYyZlRJbCs5ZlJQVEJsSFZKeWk4Szc2Y3pRY0hTUncybnpRNFFB?=
 =?utf-8?B?T0xBaWcvcmRqTFVxYVh5QUlaaWRxMWg4S0JLZ0lic2JuNUVnYlNsU3JoQkVC?=
 =?utf-8?B?VDRTVWpQa3RCR3k3RVp1QnRGeGVCM0o1OXhrMXlsTlYwc0txdlRIWFpsbXRP?=
 =?utf-8?B?emk0dFpESVhBVTlJamRNLzVLNDRNUUs2MzZRQ1RNb2pkVTNNbWM5bjhocVh5?=
 =?utf-8?B?SElVUEFEMFdNaTQ3cGFSeXVYcGJvUSsreHpBQnMwL1ZubTE1QUZMejhBM1Ex?=
 =?utf-8?B?dks2TU93c3pUUlVHSWdDaEZJQ0l1RHBwaWlQTEZ4d0xISDNpMGY0emhFdmt1?=
 =?utf-8?B?aUNVNllnS2VveDUyOEk2Y2FYTEpKUmtna1BJSW1NR2VvdmRoNGY3N001azJv?=
 =?utf-8?B?bnovRUlCMkxEbUpaTW9yUXVRQzUzbzdwTDV6eVFFL2E4SThweVVrZHhzUUxl?=
 =?utf-8?B?ZVZVVmRpN2o5aFJzUTZaTzNUTW1VWnVJSlFXZDY1dkdybzA3aVk1OXFyZ1JS?=
 =?utf-8?B?NGtYRzZWZ1p5UVcxcVBzaXJ3NHYrcTROVnRmNGlidzN4aWZubVhtOXlBNitZ?=
 =?utf-8?B?ZU1qT3k3TEFiYzdyZFRkVmlmY2hDR1RZNHZpZm5YYmx2MFdTbmMwMkorUmJY?=
 =?utf-8?B?Q0liT0NCMGpaUFpsM0czZ1NjN1dHTysrRzl1TGl5MGhqaTRLb2xwNXkwUE81?=
 =?utf-8?B?djJ6TSs4cThnQ0NtWEl6Q1NSVDQyUTVVTWR0ZWs0eWhic0dyV0l6Y1JUT21n?=
 =?utf-8?B?V3ZyQTVQZFpPYnlPS0dwUkNqMEd6K2dUbUsvdGFONTUwakZzWVcyK1hHdWkz?=
 =?utf-8?B?VFpCbU9NbG1ENUl6dFE3Tm83NUF3TmxQTi83bTJ1Z2k2ejlIUjdhZEx0emFj?=
 =?utf-8?B?ZEUveHd5YUVlRFphaTV4aXBnZmpZbkg5Vlh3VGszZ2tYejhQZlh5dmRmWlpD?=
 =?utf-8?B?MTR5akRFUTFCekppL3l1LzNESk00Tkk3V0V1UU01TCt3Z2djTW1jQ0R1djgr?=
 =?utf-8?B?Y0VrUC9KV0R5QkQzODVrWk53MGhlTHVPTkRwWUdSbTZHNTFnak4yUWVrVE9a?=
 =?utf-8?B?TGM0MXg3c1ZGWHNML3pOeEI1dTBKZkRKcG5qQU82L1BrVmlYdHcvUW4ydFZ1?=
 =?utf-8?B?Q2xEK3N6d21DZUNiRjEydi8rTTR0d0J1Ny9BeVlDVEdSa2NvVmQ3R3VYNXdx?=
 =?utf-8?B?NHNHRTdCa1hGaFlsby9lWkQxRHdlakYvUEdsVHpyMXA5Qllab0pyQktTMlVN?=
 =?utf-8?B?VnNtVy9UY080cEpxZXA1T2xPSyt0TXduWGRIa25mR21WRm8zVjI1UzB6T2Iy?=
 =?utf-8?B?S20ySXVHNUhoMDhrWVF6L0w4STZpTmVnTTBOQkl4VFFDb0dySGZPZkpPRXh4?=
 =?utf-8?B?M1gxSVRyV1dzMkR0RTJzN2VWRStzNW5FR1J1azhGNWJSVjhEUVlmZmkvQkNK?=
 =?utf-8?B?Zk9xMWhrV0Y0Z0swS1RTTlRuZ05sSXNlMmRBTlNEV0FicEVlQzNVcXV0cm0v?=
 =?utf-8?B?Y2xYNzJJUWhiNS9uTk9sZngwQVRsLzhyVGZ1b2dqd1ZXeUg1dk5OdUxqYU1i?=
 =?utf-8?B?ZVlQYU40M2Q1bm5seEhUMUU3eVExZWw4YWpKV29GbnQwU0swN2UwQU0vK28w?=
 =?utf-8?B?T0lGbTB1U0VHZ0tTcWdLQlVnRUJXTU05NitPeC9Cd0hqMGl3MVY3OTgzOVpR?=
 =?utf-8?B?ZE5JTlA0cmRFQWE0ZUtISWRSTHRCUGRxd052R2tMbVFPNVNSSWx2R1AvSjVU?=
 =?utf-8?B?azVONFBDeG1EdXZTcVkrRnVjTEJXRnZzMnowcTdWOFlrOXl4U1BlYTJUUFdN?=
 =?utf-8?B?aWJ1NWw5UzFRODFJY2V1N2Z5VEozeExVUVJibFhRcE93ZXpWUWE4VW94ZCsx?=
 =?utf-8?B?SUpkbExXSUJzRENwUnB6Ym9IdWVpU3dZVjNnSmtSZHlLQWxYZG5yT1E1WHR0?=
 =?utf-8?B?d0djRWFTMSsyRFpYNkJrQzNlQ2d1UUZaOGkwUENWQ0s3QkRTMVZXQnJ5bklT?=
 =?utf-8?B?YklwMlh6ZDZSdGJWek9PYktpSm5xTk9RYW9vekxzYVBIVFhsR2IwZk54N3Zy?=
 =?utf-8?Q?ViAeFF?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:26:24.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abed126d-e5b7-4011-5f90-08dda7f01b47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413

A couple of vlan cleanups/improvements:
First patch replaces BUG() calls with WARN_ON_ONCE(). This fixes a
compilation warning/error from objtool, and in general the usage of
BUG() should be avoided.

The second patch uses the "kernel" way of testing whether an option is
configured as builtin/module, instead of open-coding it.

Gal Pressman (2):
  net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
  net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard

 include/linux/if_vlan.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.40.1


