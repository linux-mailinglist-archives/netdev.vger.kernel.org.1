Return-Path: <netdev+bounces-202784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49758AEF00F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2EC17DE7C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C028260565;
	Tue,  1 Jul 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Zu/9nURi"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD051C84B3;
	Tue,  1 Jul 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356238; cv=fail; b=G6nnzARpq1KTU4K5UiqfK/fGfiIg/d2tkulkCgX4uj55Pa2jc/SzE0bMFoLFmSucwnFW6y5h5raiiJSr3RxeqTGvortlxadCcOQ419sQISHl9vDWNPZQuvJVBeRBM56dUtR5yXxOgiQPzXVBQThqJrMJW2/n6RS8gq5w0iagBEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356238; c=relaxed/simple;
	bh=JJpWWMSU8dDP3N1gRVlris/zzy+kI3IuviTU4lFshPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1H0iYCm2+iAKpzZOwBO2DaJrhAUgVy/yMKW3/jVd8rKNBcN+aohQj3/g6lDK+TyaAUiXMMSbH4IoO7wolsLDRlKeaNY5Ox8eT1TBIFx7jVwPPsxCcIIywO7rDmNbVRNyYWzHrsg06Le1DElDyRqcu1ocd5Kfd+diwfqkr4Jf0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Zu/9nURi; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYVv5UYSbLpLX3I2AJ2pEjvg1a8+zg+XW5jimj16CpV524+PRXVs356H9pp9elY/KlttJFrBECA3GMfyPqNCmME3NjIq5u3KSGyLomo0LvR3qld7fbKRfMv6wp/vBsnYHoj0Dd1faWPki2UCYvKjhbNlyZvZcxhTWhL4kYBB7SKZM7BD8ICG1tTk72BH/XAodqfdz6sdT0x2H3l7Rmz+hbB1ldtfdgYOF1wdLE9605v87N6gCDPfruE5doItObTRyvES5vaorxthukM1zNywWZytSLhdTzq3NygoiGfciON1gJZbR20BYsVuHnLrC2BxHmeFJVLSfk74GWCAk87o9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhgBNvUVXHdBc+x8R8pFn+WcA4hdRi0+IxpJL0OxWRc=;
 b=llFMRSHfWKLFO2krEVEg7kIZyf2+jyvzp0jhArDE3yivplg5u5dd7Wjp0ApzbbfYD3BX7vuKiWkc2s7SRjGCEws82qfJDSlxUvUjh4VqYS0fevAqYhTYMHf8Zr7JtBvphB6eZGLGaO/5DCpCUTab3MfXCdx8MDS78MiKPLoa6VEovTDgQIElorggz39ZM459NOuZTvRNR47fPxqFcIZ1oX5D+Z5OwAn1qI9GATrmXLgJtxeHdlMEAea/DfOgL/l1JyqEeGA9S7NcdfZJND5IcTnNwjtJ2Ot6jXiePPjgr1+oedLTD3pDc+cbGIxIMam7MH0JEmkBYaeLBnZwRwmMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhgBNvUVXHdBc+x8R8pFn+WcA4hdRi0+IxpJL0OxWRc=;
 b=Zu/9nURipNb1Fx5SbhFAE3d9JRooTlVZDi0r8BANTMRdiyL3ZgV1g9diQzBHuwwRY5YeT2bIb7RLzC7Et5783uJfRoHL+H0cVxHjuvZQirTD98rKO+muzdW4gRZ4DyFAdABH4JyRSSgFmiE5X4SI8NorjUN7E73VZI+kTWgYxiY=
Received: from AS9PR05CA0347.eurprd05.prod.outlook.com (2603:10a6:20b:490::35)
 by DU0PR02MB7873.eurprd02.prod.outlook.com (2603:10a6:10:345::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 1 Jul
 2025 07:50:30 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:490:cafe::22) by AS9PR05CA0347.outlook.office365.com
 (2603:10a6:20b:490::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 07:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 07:50:30 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Jul
 2025 09:50:29 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY initialization
Date: Tue, 1 Jul 2025 09:50:11 +0200
Message-ID: <20250701075015.2601518-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|DU0PR02MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eb415b-f002-4f4c-728d-08ddb873f3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUJTaEl3YjR6d0Z6Tmx5NG5kaVNtMkV0Yk5ZUk4yWTg5NlFmSzY2enEybHQx?=
 =?utf-8?B?eUw4VXBEWGdIYVNwWCszb055cUZFWE9GVkVieHI1Yy9oWldzR3JrdGJRY2tH?=
 =?utf-8?B?aGhKUXRKWkYyQ1h2cllkTm0yTFhDaFU0R3VJdVhtQ3liTDZUL0EyMmNlMXl4?=
 =?utf-8?B?YTFHb09HL1d2TCtYZmMyQ3lWeHJ1MEh6bmxUQnVSRjAvRmhJb1F0WEJ2dTlG?=
 =?utf-8?B?ZFY5OXA5MmR5NE1vblZma3BndTVkVTBIeVFqaHdsbC9WZnBXbXRUaGJBZmNO?=
 =?utf-8?B?OVdVd2xRZCtQcUlVL3BkMjJ2UDdEeERmcDFVNGNVZ2xaNlhXR3ZKdmRGajBk?=
 =?utf-8?B?VGtMWlM4cnhWL0dvRXI0cG13QTJLTy9tak5wdXN2TEQ1UHRtY2RnZUh3WlhV?=
 =?utf-8?B?RGNPSFd2Rkp2Vlp5RHVzQ0ZwVWhHYm1OUkdZQjNyQmpGUVF0bkE2a0tkaGlS?=
 =?utf-8?B?VVZqQ00zRld4dXZUWDlCZDFDRm9XRTVJN0hwYmFYZTJPUW9xWkJUUnQrSGd2?=
 =?utf-8?B?RzlhQmtSRHBMUnJ3Y2xZb2tWWFZYWEZ6WWxud3p0cGtPcDBLVkJBdVJRZkhZ?=
 =?utf-8?B?R1duMGNnblhnOWdyTGp2NE1RUWVobDk3aGJNYU1MNy9Yd3pNNlM0MEI4NGdx?=
 =?utf-8?B?bHloQlF6MHNoNk1mRW83elFwRHNCUEpnMmRPOHZQNy8xOGRUNEJMYnNHempD?=
 =?utf-8?B?akNpeTY5Z2xZbEt0REhjMHdzWlVnZHBXMHpNRUp6N3JrREEzWnZJcmJJcmxx?=
 =?utf-8?B?U3B1NkYremRuWi8xOE5neDh2WkxrYThrdDRHYUpCN2dqVHErTStzMThVd0tt?=
 =?utf-8?B?bkphVnRXM2JhTDdYWGx0VHI4K04vcElPcWUyYmd0VzdxVUVwcENnRWU1eFdw?=
 =?utf-8?B?QW15VFQ1Q3pmOXZJRWVsR3ZCUXZmb2QzQUNSSUsrRm5pOTV6SitWVGFET1Rs?=
 =?utf-8?B?bDlXVi9zai9yMjBpVXlYVTB2RUIxOWl4eTE1cDR2dDU2eW1zMmZQbkVPM1pi?=
 =?utf-8?B?OVVSVDByOUNQRm5OV29qbGorcEJkRGQ4RWpsKzR4dGhmcDVTZVNBK3dYbEYy?=
 =?utf-8?B?N05MeVN5M0R2UlJLQzBoN1NhRVVYdEZma25FQzhKVXZPZDFzaHZpbXo3L0Rv?=
 =?utf-8?B?NUtXOHE0Qk1VY0ZxS0pnV1d2cGFQWlNCbmFXNFRhUFZaQ1UwcXBJNEJkRWps?=
 =?utf-8?B?VzQwQ24yYm9nSFVGRUpUZUVIOFdwaHZTS0Z3ZzNvNHNpSnVGbG4xRFI2Sncv?=
 =?utf-8?B?VWJXMmxSUmRMNVlVTVZrM3N5NmxOZVpkbitKQm1CRjU4WjRMSnFkSmZuN0ZL?=
 =?utf-8?B?OEhuaTdVaUk2ZTc1Z0VjKy9hT3h4K3ZsRDNGcXR5VU9RdDlKVWdqYWlZUjVO?=
 =?utf-8?B?WXozV2JFZ0RxN2wvMDRMSVdwR2NVZ3pMdzNRWkVmMC9VWDQxRldibzFQVTBN?=
 =?utf-8?B?RHVjSmxjMjVibGdVZzF0Y1BZbmc1bGRtU2RyWncxZDdlRmNvWCtMczFOY3lH?=
 =?utf-8?B?Q1F3amYvN0lwTENKY0pHZC9rN3lJMzRSd1VDMVA3eEJYRGtEQURnSFVxYThk?=
 =?utf-8?B?TGl1MWltVy9Ec01vbzFoVTZiOGMzd2dXL1Q1dUN3YjFleU9VNm1xdG50NkNv?=
 =?utf-8?B?bGZYZjdJWHY3VkNXR3FrYTlIVm1JOGNkZ3lyemVjZnRGbGlFcnE5T2h5UXlN?=
 =?utf-8?B?V2RiRFhDNC9sMTd1YXQyZG9xM3pNYkIyWUk4SUErdzEwZ04xM0lCQW0wZGdO?=
 =?utf-8?B?dzNHMHdhdlVJNkJNODh2REx2Q2pZaHZsOW1Ed2tMS2JKc0xOM2lXaTd2amRM?=
 =?utf-8?B?OHA2UUpCdWx0Yi8rYXlWdW02ZFh2MWJNaEJRU3pLdnhrRnZJLzZadlNNbzFF?=
 =?utf-8?B?Rlc3Z05lcGxEaHZqS2YwRVJHZWFMd1dkZFFRbldaQTd3YnkxTGVLdWZOS3Vk?=
 =?utf-8?B?MEFVRTZWVW90VHpOS2twT1pFY01GV3BZZ0U2RkoyNzVaOUFUalhnQk0zMm1y?=
 =?utf-8?B?SVZHQTlhckVWN2xPYlBIMmZnd3ZqeE5UTlNlcTljRDhBQUFZRm9ZL204dDZH?=
 =?utf-8?B?bE9xYnVod2JSS1pDZDNMeXluMlNJRCsyRk1jUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:50:30.5087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb415b-f002-4f4c-728d-08ddb873f3ad
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7873

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

Changes in v3:
  - Added MII-Lite documentation

Changes in v4:
  - Added missing Fixes headers

Changes in v5:
  - Removed unused PHY register bits definition

Kamil Horák - 2N (4):
  net: phy: MII-Lite PHY interface mode
  dt-bindings: ethernet-phy: add MII-Lite phy interface type
  net: phy: bcm5481x: MII-Lite activation
  net: phy: bcm54811: Fix the PHY initialization

 .../bindings/net/ethernet-controller.yaml     |  1 +
 Documentation/networking/phy.rst              |  7 ++++
 drivers/net/phy/broadcom.c                    | 39 ++++++++++++++++---
 drivers/net/phy/phy-core.c                    |  1 +
 drivers/net/phy/phy_caps.c                    |  4 ++
 drivers/net/phy/phylink.c                     |  1 +
 include/linux/brcmphy.h                       |  6 +++
 include/linux/phy.h                           |  4 ++
 8 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.39.5


