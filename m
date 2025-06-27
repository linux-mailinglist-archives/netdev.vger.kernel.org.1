Return-Path: <netdev+bounces-201898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC6AEB62D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77561C41E33
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65029B8FB;
	Fri, 27 Jun 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="g6gAWtN1"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D929552F;
	Fri, 27 Jun 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023413; cv=fail; b=gZbKxPKdIk6vKFUT53X9exPzpkjcrSayMm4naBRHqsADPPgDucFW3YggmsiQDhfw6KMwb1PQbbpRo6/E91wi6YqU9oHWiIBQkamVxA6cY3HYxrbkSSMVgkyaFX1TJwwDaUpPAez4mwz4ybkoRsDdgQLbfiFtHzVPTDILOpIaa3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023413; c=relaxed/simple;
	bh=IS1X6Rvm4rmWmumwGaTS6hqSfFLct/k+zRjslSCZDyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SuEvDT/1qSegaj5cfglZ9RuqDqdLtWkMKqxS+DvuSYTaSc01QvdUEVTLYCBhDtEaUO32jgLhrI+yoB5u71C88WP52Raq0GaKgHpZuetoF9zwx7d3wAC/y0YyKFfr6diiq7XbX/O6d47vfihF/p4RJFcIUJ9Dbc5GEDlksmj27VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=g6gAWtN1; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuhwEbnAIXigB3dRAcm5g5KNQn0pvy+fBqeeBitNata8gotMkFtV0jjCFDv74bTDFBB0u0mgImVTr+uCzMCE5RT3rB7krgnUSpe1Jhz6Ap+B9sbbSUIumSqHJhjIjotIIeEPMO2Lr8zgBwXjD7ouICiq7djTxKpooV/PSOarxKQG/8eIIQvW6/5lnBzJLz1JVzrzK/j+3AvtfSfzDoZjF1k0jXuyh2zxn9Atm7PvJkc7LeSata0h8BoqgkiAJLg39Gg75inz6ocyHRuV2E55di21ay0mAV2SuhiFec6kQAPHyvlhjaBotcNkiSdgkdG0TD67+n2/nK+ODQwFVPnalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXsT7fF4qRZS7FvhSu7tSSPhI0TqBqpFozQ8kLup8pc=;
 b=DT04uoSBtvy4b9/ZviGo8PDPPfqAaFE8OiQCeqCtlxCOZphuS6PtK5D3j2z9jQeQfiT0fbyR4JqcUExwXxRYdSXRsMc+CGNRgHg4eIsyZgTzK8FqaOCiVgfQ5zRib4akHEGfbzeKHMUxxjV0mqP3zwROBIBq3koaCFsMn/eOKuAGTaT8aMFuoGRaXNH02/z3bU6vb7TBDHjkJgDMJHpeL82HC9/s/PbkQJqIM8a6kWypS1kS7Ta70lWctrbsNTz44x2DI10fm9dBi3VnfaGLyLMDly1nCwdSTtvxLHidL4pUNhtrhEtbb80fHqDxcdtsabZ0eh6w/iP+0R+hzrU+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXsT7fF4qRZS7FvhSu7tSSPhI0TqBqpFozQ8kLup8pc=;
 b=g6gAWtN1UklGY5Zg3FhURk+jUShcjI79djyKtxJS+6X8kx2LHM6DK7SmtGaIdfzLyOSYQSSwS+9yON7ZQl6+vQIiTci8yKOgVpQ4D+AEH4AksA2lOIdW1H6L8rwmXHu80l9IddlE1qC0R47o0Ir5pliawt6aeGGBZxr0tMyX68o=
Received: from AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20)
 by PA4PR02MB6959.eurprd02.prod.outlook.com (2603:10a6:102:109::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Fri, 27 Jun
 2025 11:23:25 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::c0) by AM4PR07CA0007.outlook.office365.com
 (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Fri,
 27 Jun 2025 11:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 11:23:25 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 27 Jun
 2025 13:23:24 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v2 0/4] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 27 Jun 2025 13:23:02 +0200
Message-ID: <20250627112306.1191223-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70C:EE_|PA4PR02MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 084e6633-c028-4ed8-84d5-08ddb56d088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y292S281NW41Z3drZ0dzSXB0ZHhDaXlFOS9sbzF0b08wUU5OcE1HeWFDVS9M?=
 =?utf-8?B?ZmZwbHd4V0R4U01JSDJyQTVPV3RLc3lWb2Z1TTNGOEtTTllobVk5K09hY2xs?=
 =?utf-8?B?czBJbHlaRVBROFQ2SEF5WXZxLzRGYk8xV1FpazBTbHhkZUpLZlFBNmNWdG9D?=
 =?utf-8?B?QjVXOEdMUGdaZXJxbE0xdnZwblV5Nm9yWXVJTmFoZElhczZ2emcxVCtJV3Fr?=
 =?utf-8?B?cXVJVTBmVmg3eEQ4US9RalNxcE9XcjFFWFBlUHJUdXUzeS9kTnF2UzJZVllz?=
 =?utf-8?B?YUpIWkV5TXA4dmEzTVF6ZDdndjB6ai82b3FPTktOTEhGY3pxN1A4ck9nNzV1?=
 =?utf-8?B?MjRrL29jd3N2SEs4VmNuRGJVS0syUDZMNlR1bWlCdXNBY1EvS09BMTlnNmdt?=
 =?utf-8?B?NWE0RlNtV3RlS3JYMWdPeGxMSit0LytENEF5ZmFRZmEwY1RvUjZjUVE0R0o1?=
 =?utf-8?B?bDdPVXJ4SzZzL1FPaU9rQStCZjJoTWRvNGtxK1R4ckRNelhDVC9TODMyWEYw?=
 =?utf-8?B?bHZCbzhZQ3lUV0dLOWY5clZUem9oV2QvTVhMM2pIV3A3dzBJZjc3NndhT2My?=
 =?utf-8?B?T05qK2lKUU9Yd0xlRDM3M2Z4Ny84K2w4dkhCSUdjU2d2cDU1TnhLYWdwRnQw?=
 =?utf-8?B?SDM0MzJzY0tGdXhiUXp1cTZtaUR5U1JpSUduSHhTODF2QWowTURMSWV2ck5X?=
 =?utf-8?B?S1pwZWljayt1UG83b01zaXZhQTVSZVNpS1d3MkZheVA0SGZSMHcydGJVOGQx?=
 =?utf-8?B?UWQ3dFhqeHFacVBselhRVFNtcFNGMTlGSXM4ajBUaVdIbFZrbEJGU0RRNElh?=
 =?utf-8?B?QWxRcTJ5OWdSU2RWOFhFalVocm93Vnl1Tm00MXE4VDlMeXVtUURZdjNHVkxI?=
 =?utf-8?B?QjRpSXJPQy9Cb1BZb0VhUm1qUWZqQStHdXpNa1NpNDdQcVJrQ21LVjNrb0dq?=
 =?utf-8?B?RjhsVVEzSjVCeDlaaGR1T1hLUnRpMHVWWkdoMXZXT25URmRhRmZYZjZndnhp?=
 =?utf-8?B?Q0ZXTHVpRTJVQzh3NTZNOCtqUStydWtPWndOMTJXdU92MHp3cDNvOXFlWHU3?=
 =?utf-8?B?T0FsUUVJcERUYWtlVHEwRHJWOTFmdUFqYXNXSjZxYlE3aDdDZjZyQS9DTUNs?=
 =?utf-8?B?WVBjdlgvdVRmVStHM3VPTG4yM0dhRU4xeUkvb2IxNzBsQnZrSUE2VG9QTlVn?=
 =?utf-8?B?Um01RzlIMVBSU1pJa2JHR1h1ZXNtQzdVT294Ukd0M3Q3ZVVyc1cxdzVvSUNl?=
 =?utf-8?B?OGVVZ0sxMlVXV3p2bU1qQkxHMlRJM3VwanlpU2Y1T2xtODdjU3dLVGJXaG1S?=
 =?utf-8?B?b2hpNGpSTzdiZFdtSW0zNE4wN3YyNTFNVGRIMVJtb1ZLY2VHUDZHTnNHdVc3?=
 =?utf-8?B?TFRocWNSV3VNSEg0U2luOXJrSnFWYXFsS3l0eExaNGJDUDFpQkRkWlBHSmph?=
 =?utf-8?B?aU9QMENoT3cxbURuRndrQUdNK2Zvc0t6QlJXb1lmVEpLOWk4WFZyakR6Rmh3?=
 =?utf-8?B?bmZYMWVNTEZDS3A5Q1RXdktoSTNBaUpORWxtYmRvdUVCQ1dXNk9wYzlSamVa?=
 =?utf-8?B?eWNVNDZnM3JxMkJLaWRmNStUaEtjWmhER2c1TUxxYmRBZDZaRks4d0lja2hr?=
 =?utf-8?B?Qmp3R200enNsSEphRWx5Qm4rbENkUjA2N2d5YllHbGo1WEhTRWg0U0tRZ2E3?=
 =?utf-8?B?ajJrRjhvYjhLVUpXcVF5bkJ0MlJIblo2OFZPOWp3WmtaYzFrRE42eXpRUVVR?=
 =?utf-8?B?K1BTNEhOUGNOSHR1blM4U2kzWkRWZUJQOFgxbHhxb3dlV3J1Ty93TDQ3bUxu?=
 =?utf-8?B?WjE5elFseEoxRnFWdjk3Y1c1YmNsbUt1aDFKRVBXSlRpQ0U0bk1CTG9yRVJ6?=
 =?utf-8?B?UHowY2lTT1BNQTJwWjZncU1UYjMwT2F2RUFvQ09kb1RNZHpmNzlGekQxL1Jw?=
 =?utf-8?B?NzVJU1R6OUF5R2hMdHk1UjVrUE02VHBHalFoWXlRL2JvcVJibWVKZlFueFRq?=
 =?utf-8?B?MHhUZXZnUy83andBNnVEVm85cy9saFVvU3Q5bklNaFZoa0RTY0JJd1Y1Tkxv?=
 =?utf-8?B?QjFwWnA5R05nZUx1Si9yaEJHckxrSVBtSGhsdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:23:25.5630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084e6633-c028-4ed8-84d5-08ddb56d088d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6959

PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
   their two-wire PHYs. It can be used with most Ethernet controllers
   under certain limitations (no half-duplex link modes etc.).

PATCH 2 - Add MII-Lite PHY interface type

PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
   PHYs

PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.
   Also fix the LRE Status register reading, there is another bit to
   be ignored on bcm54811.

Changes in v2:
  - Applied reviewers' comments
  - Divided into more patches (separated common and Broadcom
   PHY specific code)


Kamil Horák - 2N (4):
  net: phy: MII-Lite PHY interface mode
  dt-bindings: ethernet-phy: add MII-Lite phy interface type
  net: phy: bcm5481x: MII-Lite activation
  net: phy: bcm54811: Fix the PHY initialization

 .../bindings/net/ethernet-controller.yaml     |  1 +
 drivers/net/phy/broadcom.c                    | 39 ++++++++++++++++---
 drivers/net/phy/phy-core.c                    |  1 +
 drivers/net/phy/phy_caps.c                    |  4 ++
 drivers/net/phy/phylink.c                     |  1 +
 include/linux/brcmphy.h                       |  7 ++++
 include/linux/phy.h                           |  4 ++
 7 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.39.5


