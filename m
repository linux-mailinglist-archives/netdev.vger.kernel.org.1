Return-Path: <netdev+bounces-109232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7999277B9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5BE1C21186
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D31AEFDE;
	Thu,  4 Jul 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="W8x3sjMO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CC1B0120;
	Thu,  4 Jul 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101899; cv=fail; b=TAQ6N8qK/LGyrMfGu8TABPSmiNVcdrndsfKo9sik8gk3lGLRMHtIvdZ/tciFgZeEiM8DDtwNzDYx+Vj7aKSJSewnOhRIXd+XLegS2264r34vrGs6dfrCxKr8g4rsoReASKNI8IziPqiNrr+q2xLEnx52DtjJAoLz6wuvB2H4rD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101899; c=relaxed/simple;
	bh=nhxOlAxVrR/YC86FBUfnYUdAo6Uu17uCqIUTuMEMcs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmnbrcRC3egf5OcJ0gU8SfmSS1yVyceFpGJl2754KCevVlIbi9Lf5QlV5MUR0aCclB5XZVHxvdSGm4JzAjHWf2mAMFFWyzpnrulNyAW/smXQd7Swi+lzVjanN+D/+7Y6Zg9672ZcLfWF6dVij9DfbEQ3jGzcKmJ8nya/Gntj42s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=W8x3sjMO; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5A6kXCaGWjdF9O5X34jP93VhDPvuvjCRod1GJ0oiXUMLEzYtVCaH+31p/hsI6047OPxEc0+9A3wyz+A8xp3vmGdkAcBYnuQgdgoVP5LEA0tJBhrMAMEgVhslUdMl6Nc7zivPB4omCteqAndtqqe8p6uc5HYLRf4D5kJHdel4Gm7dLX72usoreoPHp4XjcYSObazkmXz0Hyv97/arqUPnrf2E5UuNOimc3buDUiVD6X1EIhNBd3c8THe5CAE5CNWe9PEMAERhN5MOGjA1dlg8uS6jXO/1E47Oq0/yXxkl23kl3MAfE01Uh676WiMCkr8k3A5zY6a9EgsGQkQr7yx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf+rrrbUXJPQsenI5ofcGoaayi7umJe4YFsoavQ6Xag=;
 b=FlnCVZkO1BmrGmuCAtg13QqHuoohoshhWshyVtdgmcJETE0i3FnHn5i2R/lcmBC7QKGi7ZibJyzDGyh0V6D4RLTBRgCa94d55pYUvXlEvhJ+mLRT1477Seh6/MRAsn522oRALtkS6tUYJFmM28v05F6kwLED5dOP5ed1na7052BothD//08bsWkUL3EYGFUkQ3TBBzeszeDtU78Zs6ZCUqeCXE/6Itcxpaw6XTTRqKJFiAl6qp3gdpnoiaW2aI1al2eLqa9mBP2C+ldZirum1QSktOX7DEb935dhpT7lHxp6LH4aSsuKVU0qmanQkGwEb+7JK7TlhjliNoTzUiaqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf+rrrbUXJPQsenI5ofcGoaayi7umJe4YFsoavQ6Xag=;
 b=W8x3sjMOn3CGXV9P5mo+GraevqDstX2reRfUKnem8yhLSatZOiG1rk5MEXlK0XuvhFrLgjbgh6bWfbf57ae3d5xKM/JGRHQrpt0gWTT87Aqopc1QjboYl3uT8RxXAuGHo4qa6lyuJvHVXUCBUsKTuhbxawKg13Ji6WG0g2GMbpo=
Received: from DBBPR09CA0046.eurprd09.prod.outlook.com (2603:10a6:10:d4::34)
 by PAXPR02MB7262.eurprd02.prod.outlook.com (2603:10a6:102:1c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 14:04:54 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::4d) by DBBPR09CA0046.outlook.office365.com
 (2603:10a6:10:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 14:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 14:04:54 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 16:04:53 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Thu, 4 Jul 2024 16:04:12 +0200
Message-ID: <20240704140413.2797199-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704140413.2797199-1-kamilh@axis.com>
References: <20240704140413.2797199-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|PAXPR02MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a595590-2c98-426e-5e28-08dc9c3247a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJmam01bU5Fek5iNjUybHZwbDlMTHRNekl3dGF1K2lteUVZU2UzSGFhdk9G?=
 =?utf-8?B?cWhJclptblNGOWIxc1AwTWpLVVBhVDFkUkpVQzZHZGo2cHhxMXlrOWIxRFhq?=
 =?utf-8?B?OWhrano3Q3VBWDViYmpiVHhSSWx1YUgyNDRWanAwMnR6cXhndE9kYjc5a1BB?=
 =?utf-8?B?Y042MDZoY0JDNUZQem1Xam9tMFJ2SWxYMTN2M2U5N3MwZW9aZUxrbEFRenlV?=
 =?utf-8?B?cmY4bDh4K0k3K20rUmZ4VlA5QkcyMVh1QUpTZ09PczdnRXM1ZW9FTmJ0aEd3?=
 =?utf-8?B?SkhWbUxJaGFvTDJ3Rkp6QjU2VVpFMGk5RDJqQ2g4Z2V6aG50dStSVTdhRk0v?=
 =?utf-8?B?WjdqNTQ0N3FRTmY5aGNxZ0pTQ3dxZGdIODY4bDU0aW1xdVRITFhyTG4wbDBk?=
 =?utf-8?B?SCtTTDNNU3NUa0lGNGZFand6Y2dlWGlFYlNZV0U1dlRJblg5TG5hMi9tcTdL?=
 =?utf-8?B?TmEzbjltVnBKZHMreWZyQTFGNnprREprT1Z1eGw5SXhKbW94ZlVldVhxeDFy?=
 =?utf-8?B?alFVeGMxWFg4ZGlTbWgwV2V5QXAyV2Z1VllGUmMyOEo3RkRiSHZ0N04zQ2Z0?=
 =?utf-8?B?UW1ISlFKMUo0UGRaeVNTL29XbXlMSWdLaFFpTFBpaWhxSE5UamllVXBiQWoy?=
 =?utf-8?B?KzJRaUhCVUI0cXB2QXFRZCsxMTRvRU5aLzZUWVJkUXptaXc4MWxCT2FPYXc0?=
 =?utf-8?B?NFJJYVB0VEltK0MrWllNL0d2WFdnTjJ3M2lvM2NXR29JeEs2cmZyNHFpR2lx?=
 =?utf-8?B?N3Y5ZU9wc21VeDg2OFNGSTMrN3N0NFREYVdDemxkMENmWmFTSDJiTng4UmFG?=
 =?utf-8?B?ejJuQmpUQ09kR2dPTkZWeGx3WDZKVmxxYjdwTHRmSVJEdjBFdmd0cE9XMGpC?=
 =?utf-8?B?RGp2RjlFK2JaRWxyYzZiclFMRWx6Qmc3Ymc4QVgzTmEzbU5WVERXeEd3dkZz?=
 =?utf-8?B?SGt0YlVQUm9GR0RqcHNiTHAzVE5jbFpvNklZb0x1NXhzOWI1cU5XcnVLY1RK?=
 =?utf-8?B?UWRORmg4QzRKRUw1ZE0rU25Wcjc2NXhPR1JKZHdMWWRTTFlVcnZwUG9lNzlt?=
 =?utf-8?B?TVdlUFFhSEVPK2RqcDd0WGxtRDg4Y2FMb1BQSzRURCtxcUZ1dERwejZpeXJu?=
 =?utf-8?B?YytFVnBqL05oYy85UXQzWGtQTWlwOXRLeVBldUdFT21TRzYrRi9aMWxtcXVQ?=
 =?utf-8?B?V0l5cTBIa09ld1IxSHZ2RVZLNHE4eE9vRnpxcW0wMElZQmUvZ3pGblFNeEJr?=
 =?utf-8?B?dlExcHFnTzdNNHEwMVhXdHdsM0I2UmdVMWprT2pUM3cySW5hUnQvRjlYWjFK?=
 =?utf-8?B?dlZHWGI3b28yTzIzNXVoMzZGWXJ4ZjRwZFpTRU9tL01LTWtST2tIZjU0UnVZ?=
 =?utf-8?B?Z21jNFZjVW11bjE1Umg0TldrTGFSMWRIbThveWR1ZVJmWENKQnAyT0o0Slh0?=
 =?utf-8?B?NlVFY1RXa1N2VEo1M0M1MDRLeiswdmlzaTNjand2RlJKR0l0bS9sbGhCZkYx?=
 =?utf-8?B?QkhxbHNCTE1YcFUzUEFyc25kczhFR2x2MFlxYW9zSUxGWloxMW45d1grdmFI?=
 =?utf-8?B?aEw4UndHak9Na3pCZ3c2ak14VGcxYnhXUmdQclFQQm43dHhzU0RRVy8zdWxs?=
 =?utf-8?B?b2lzZHc3a0NubXExVzV1cDQ3dWhpSDhKOGlwWExIdkxraTNOY2txZ1puaEFv?=
 =?utf-8?B?RklGM0YrdHN6blVuaGg4V0VyelNPbzNhdkNPTFhaVWpwNmtHUFRFaU9YcWJM?=
 =?utf-8?B?eGxRdDlRak1QVk9nSXBCSWNMWGViNkZQdkx3ejlzNjRBVWJuUEtMU2lJM2hF?=
 =?utf-8?B?UnRIdEREa0tJR0VVcGVBVC83QlIwMW8wMUdrOEszWEJUclRKazZ1cktuZDhL?=
 =?utf-8?B?eGNYekZKU3pvREhNdlVvdU1JdFZmL2hjQlBmRER1VEE3N05IK04reXQ4bndD?=
 =?utf-8?B?amc0UzNZK1dKVWtDTk1uTHVMUXJXRGFhdithZVJFM2VVMDJHckR5amhDdVc3?=
 =?utf-8?B?RzVkcHZZbTF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:04:54.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a595590-2c98-426e-5e28-08dc9c3247a1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7262

There is a group of PHY chips supporting BroadR-Reach link modes in
a manner allowing for more or less identical register usage as standard
Clause 22 PHY.
These chips support standard Ethernet link modes as well, however, the
circuitry is mutually exclusive and cannot be auto-detected.
The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
(1BR-10 in Broadcom documents).

Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..349ae72ebf42 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,14 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  brr-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, indicates the network cable interface is alternative one as
+      defined in the BroadR-Reach link mode specification under 1BR-100 and
+      1BR-10 names. The driver needs to configure the PHY to operate in
+      BroadR-Reach mode.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.2


