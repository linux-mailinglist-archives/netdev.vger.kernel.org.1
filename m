Return-Path: <netdev+bounces-204885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB4AFC683
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABFD1AA4FFA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED42BF010;
	Tue,  8 Jul 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="LEgPsxq3"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FF2571B4;
	Tue,  8 Jul 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965323; cv=fail; b=kP32oAU3RTdGG65YqmRV3CdkzMGVgzkUU/l8Ty4/SUTdlhbaX4kBxRKi2xpAi+HQKU+XkVhDkMQTtrfVZ2MQlOrNMx3+vadslUOWfVF2+87Lv2iQ1uRFqnoSydASzbOLBNVHdUmpLCLlSHf7GGIJHNJLkB4KqLHRp1q9xtkWXYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965323; c=relaxed/simple;
	bh=w/27CWqpipuZm7U18l7wkYQrvR5ldtNyrcBj8YSVB5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmNemjHiTsvtjnopD57fpDIQd7DXfRmLtrvjMwpilSmb7A6WkFQ380adEaRd+dU4a7jOSDQGmYCD2JMFmyXRNzi5T1hH231dpkVLlQFRkHaFBbB/gWALE6n2Km/eTTINy2HNMXAdZFnkFuxZ3yHsM/GAhvjRrkZLjMHQxYhlEno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=LEgPsxq3; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4tdpRT/5/kuzZ69eRldxruowSOJ0Db21F0Y7xOyd6qzI88gIXKo0mbfox1w8KO7BUuxrF6pkhdSELT3a5owUaIuhhs9QqwzEnVp4z1J6f45OmvD0fJK2uaZZvNTMtUKTLp3arKGH7ZdoP1t7Ak/ikhYSNvda6IcweB26Qjw+CJdPyEuc4xqwcx7/KsRXxu5AiJFg9ypx+hVX1iBRH6nXCB2cpsMJvGJuwJrn4W8x21N590YiPKxfClYxYRH14jCqQiBnaScVeyWL8LyzF47RA7gS4uWzOIYYNKUCo3d3E8m0vacu3r03AEwa+WJpNlpcCRc+1uYlE1waJ+OjGeuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbC6rbAr+aJiTuI0V2l1TsBrDaDCF0avu2ZpZs8SwPk=;
 b=DKlYQhQGP1AcZX9E5qFzLg0Dh6jLD2gAcYJb3+COOn/mP1OuZNohdeOQdGW9ZN10bkPbo66sMInY9Qf3aWv/Qs7dTCEmnHyQkGTmFhcNQZcje5rEu5ikseARE9wJBKjXyInh/lARo00JX06bGjf7dkEi8okHHaZpRo6Umnus0FO3uVZLnIjShoWVa3jp0v9o3x4OeIkCqXxbc3Z3d2UPRmvrgtcSeWOtQnEf1Wa1RCPqr0VqV9aVb5LKHsCMxJ/p/CyR/O3JlWQTp384RpHpzdOwrDygI7FpC/Hk7VOpsnIUvNJA4ei0BpcWjZJVgjnmipPsR97AiXiLrZ3kBLYEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbC6rbAr+aJiTuI0V2l1TsBrDaDCF0avu2ZpZs8SwPk=;
 b=LEgPsxq3YGP7dxuLNiwnTDEjriKVmR2Recm7Wnm2KSS/sLOXAFUJv3u6w1HhOMN/xFTGVnU1ms7rhMCLa/cwFtnWriBH2OZBbFeO6jaEB/KNCN1VeQoz0t35FLGhPtCJ1JAzz47Cu+2wD4Xd0dond/IHEMCOzei8slTyuApHxW4=
Received: from DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) by GV1PR02MB8707.eurprd02.prod.outlook.com
 (2603:10a6:150:90::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 09:01:56 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::3d) by DUZPR01CA0037.outlook.office365.com
 (2603:10a6:10:468::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 09:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:01:55 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 8 Jul
 2025 11:01:54 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v7 0/4] net: phy: bcm54811: PHY initialization
Date: Tue, 8 Jul 2025 11:01:36 +0200
Message-ID: <20250708090140.61355-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|GV1PR02MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b6a359-c24d-4202-d36e-08ddbdfe16eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|19092799006|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnNrTk1nSDVjNmVDTFg1SmtoRFBaL0lQR0xvTWVUL1hvVHJ6UnZSdzd4MlBl?=
 =?utf-8?B?RWpManBQc0U1YnFzd08wVUNVNFpCbWVOeEIxVHpKQWVXcnZzajJKcVEyRUxV?=
 =?utf-8?B?QUhRTXZjWUw0aEYzU1k0aGxVczd6SGVCLzY2MmhiZ2FJWjNFd1QwSkgzejB0?=
 =?utf-8?B?c3hRNlg0bHZFMEtldTBueTh4cmRWaGZObTZVMksxVzJnaXVxQkwwZW5NaU9X?=
 =?utf-8?B?Q25IUndGNmdHZTlxa3UwUFNXbFpXME5EN1I0MXcvV2hmS01zVHI3SFpYWkVz?=
 =?utf-8?B?SlhFV1VHNm9BS1hZSU40MGtFaitGQWhEbUJXSG52Tzg5cC9HRE9qQ3FUSHFZ?=
 =?utf-8?B?K3p3ZFo0cmZYYTFnVmRTa3JCSzJFUWwvek5RdVJEYk5YeHFBOFBOUDJpVzlk?=
 =?utf-8?B?Wk5BcGF0cWE2SXFLR0lRRW1GWTVTMHZPUG5vc0NmenRSOHVLanNYUmVFWGJk?=
 =?utf-8?B?LzkwcTF6Zks4N1FjNURpQ2hlTFlNQkR6VHhxK0Y2aGExVy84STNwTXBLL0pT?=
 =?utf-8?B?T1VoM1RtM1B2T0F0NkRZbTNMVEhMZ2pkVUw0ODVxcWE0dUMrK0k1MFlSWWZx?=
 =?utf-8?B?d21IMTUvVlI4SG4xNGowbDg1YVFzdXBvZ3l3N1dibytpSTdWdHh6eUFNbmd2?=
 =?utf-8?B?N0xrbHZWUWticUlQVW8yekthYUF1WjZ5eE1qL0ZLZHlTL2NoVDZ4Q0FWSmpL?=
 =?utf-8?B?YWI4OFBpUUppbmg0WkVhZUZka1grV3hDcFkxUW8xL1FZVFNUQTNrbXlabXQ3?=
 =?utf-8?B?RWlzdzh0OUd6dlZIb0YvQWMrOWpURVdJMk1rV09GbHh0eGIyd3R5ZU5JM2p4?=
 =?utf-8?B?N09wd0hOQkRObm4vUjBLVUJ3T21VNDk3L1U5dlBrTC9xNmY4di9TQ3g4MWNJ?=
 =?utf-8?B?aUk4TGIreGRRbEtJM1ppNVU0SVV2MzZzcUJpcXNObVRsVE1IanVEVDBqT3ZL?=
 =?utf-8?B?WmtoNnFxY2pXQlBBYmFsTmVwa3lQWW5hejl2dFhUSThQbUR1MElWVW9WdXVx?=
 =?utf-8?B?Mm0vSmREMmNLcFc5SUtpTStScHdZclhmai9UZlZ5VllCTk5GY1p3bndNclhy?=
 =?utf-8?B?RW1OYWt5STZwRXRrV1M5b0lFMDJtblRGS0doZHBHWmJjSXFVcGJqdGFhaXpo?=
 =?utf-8?B?K3Z3cTZtcGNkYjZOcnFxcTNzVWtWbEVEWWN3dllTUlVVRk1wZlZOQ0xKbTZj?=
 =?utf-8?B?anIrQ203N1kxOTE0UUhVdVBReEVjNzZncUlMT1JRcWthcWszTEQxczdFdU1h?=
 =?utf-8?B?R0ZlVTN5c1VxSFJEaHhTSFlWRkJRNW95UVJHWEdZYWZyUm44OXF1a0Z3Uk9p?=
 =?utf-8?B?OHVnZXFvWVF6YVV4OEtLeWcxSU5ZMHpBUUswbkkxRXNPWmtKYVJyY1Ztd3Fu?=
 =?utf-8?B?RjRUVUJMYWpOck9vZDNGRnE5V1IwNlErZm9jSzJoZm40cTVvZk95S1dKckpm?=
 =?utf-8?B?eGFXUnhBMVorbXo1dWdleW1tS2xXeG1vZEZaanE5SzAxVm0wOENldW9Pcyt4?=
 =?utf-8?B?Yy9ocFl5Nk9tOWVkMG5hZzF3MHdjaGRnOXJudU9taHRMTlYrb0l6OUxRSkZi?=
 =?utf-8?B?dlExV1F5VkpxWWdiWisxWHBSM2pNd3JzR3JpM3Y5UHBKanREelUxRjJmSi9x?=
 =?utf-8?B?L0pVajI1NUt2b0JxdS9kRjJjeUdJSkJKNk1waHJXSjNuMkFSUTBGSkZ2YzJY?=
 =?utf-8?B?QURnQWFRQ2RGYnBGYll0K0VHMHBBU1pucU1KTnpZYUFieWZualVwMi9OMWhr?=
 =?utf-8?B?czhHWUJMYW05anQvTDZxQlpIMTdGeXJnUDFWOXhrWndDWHNrUG83QTNWQk5F?=
 =?utf-8?B?UWU4RkdqcGJxb1NERHB0WXoxNlZ3M1Yva1hsblZ1UFQrdlNiaTdOdDQ5bDg1?=
 =?utf-8?B?dlhxMnF4Yk5PN0U4WkZ2R2xzcmQxWGNreUtPL0JrdDZSYzI0aUtvZmlMUXI3?=
 =?utf-8?B?dUNYcnN3enFROTI0b0M5WjVsbENDWkJvcWtJeEhIU3IxMjkwYVN4S3Zwd3Bu?=
 =?utf-8?B?VWlBRm1MMHo5emsrTitqMFdmVkEyV3NiT1ZqYVRpTmRtd2VFM0FuRW5SeFFw?=
 =?utf-8?B?N25ab1QvQjN6Ymo2bDlsZzB4OHVsZ2dtMlJnQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(19092799006)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:55.9847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b6a359-c24d-4202-d36e-08ddbdfe16eb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8707

Proper bcm54811 PHY driver initialization for MII-Lite.

The bcm54811 PHY in MLP package must be setup for MII-Lite interface
mode by software. Normally, the PHY to MAC interface is selected in
hardware by setting the bootstrap pins of the PHY. However, MII and
MII-Lite share the same hardware setup and must be distinguished by
software, setting appropriate bit in a configuration register.
The MII-Lite interface mode is non-standard one, defined by Broadcom
for some of their PHYs. The MII-Lite lightness consist in omitting
RXER, TXER, CRS and COL signals of the standard MII interface.
Absence of COL them makes half-duplex links modes impossible but
does not interfere with Broadcom's BroadR-Reach link modes, because
they are full-duplex only.
To do it in a clean way, MII-Lite must be introduced first, including
its limitation to link modes (no half-duplex), because it is a
prerequisite for the patch #3 of this series. The patch #4 does not
depend on MII-Lite directly but both #3 and #4 are necessary for 
bcm54811 to work properly without additional configuration steps to be
done - for example in the bootloader, before the kernel starts.

PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
   their two-wire PHYs. It can be used with most Ethernet controllers
   under certain limitations (no half-duplex link modes etc.).

PATCH 2 - Add MII-Lite PHY interface type

PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
   PHYs

PATCH 4 - Initialize the BCM54811 PHY properly so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.
   Ignore the LDS capability bit in LRE Status register on bcm54811.

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

Changes in v6:
  - Reworded the cover letter to explain why this series should be applied
   at once and routed through "net", not "net-next".

Changes in v7:
  - Reworded the cover letter again and routed to net-next on behalf of the
   maintainers. 

Kamil Horák - 2N (4):
  net: phy: MII-Lite PHY interface mode
  dt-bindings: ethernet-phy: add MII-Lite phy interface type
  net: phy: bcm5481x: MII-Lite activation
  net: phy: bcm54811: PHY initialization

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


