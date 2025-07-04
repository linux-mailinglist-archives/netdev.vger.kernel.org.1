Return-Path: <netdev+bounces-204066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC67AF8C40
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61183B5812
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F928B513;
	Fri,  4 Jul 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="H2IegRpx"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29E28B40A;
	Fri,  4 Jul 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618140; cv=fail; b=eFCPTJ11zkA+03o6kPCat0rivShc3cM7BvYJiVm8Le2FxDuLPnIM5QCze6XMYEFG0M8uTI56EIAXSFwUjmgAn1c1I88jLrt0eucNvcJ07xA3wdDL89F8MTaXxZaTCcaZQ8qxeIALlsGWoKXu+MjwaTfSUUDH+ZTJTN4/jy/8lU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618140; c=relaxed/simple;
	bh=12P1sD4xV+cRjyP/L7X6Jwnzm3v+XThW+Au0G65bAEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DF4xeyuk5CnX71WgPUToapahFGo669iQAwTKWuiDqrqoOnsXJqc+0R+9ap26oO7Jx0dt1Tu0ok4Eb4N/YVAAlScdWe1twph0GJ9pFNu0XDUCaWXbc5KJ/CkrpjPw68rs61q2jRi5i7h/BHcodhyl6nK9q1FgMIPNpG5Ma5ooEBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=H2IegRpx; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsqZZpj2Jf/AfgGuNyRL16HJ3ONUr8JGhWic4cO22eeL5Fht1lt7J7fqV94pxIZu+JzoXo3PmrVJMgxJKfdSQn/2vgnnQexmG+49d5fcbThmtnFzD5A0hEeMAPJkrgyOY/R1fIsM+Xzb8M59NdmjZaTe0T2cXxbEaXutUdRVMNFtx1Re7BnBKRCO4BUc4TD7u97bhJ9h9n6BrOa4N3Erl/zK/btanamlZA52+qU+pj+e7P+hNiQyi/kICunCOVxEliYCuDORgqfIJDXTNjVSIrcsSjZBb3Y9SdWPffX+7wF5j2naS906tWtWEIOilZ3RhjD75q1rMPexUpcvSh93hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBoM36H9hJB0RbB9hAHUbqwoA1p+E1fxTotEFpvqnYQ=;
 b=OYKdMuvGh03L2v/RdO8UiFNKYt640L9JZdoMqzrteIJHqdkbk/55DanAA5gPU60zqmScknT3J13kjH/+KoHt9Gc8fxxECSvPrkuc2n/vAO2zcBFr/oX5Jz/2Xi5pmGshLN1dYBkv9UiL6Txg/d5N/Xi5SlIZcqJf2YTFCoU9DEuTWbNs72mY/Dadjx5vWqV4Clu1G72pUWGoJ5QMUTsSSUjfGJO6egRKgUgKs4P53xl1U0IvjMKKPBiouR16PW0BAtl/4PIFcdAEm81+Sh6WvIASO0i5jiQayvPl4fbKkCHp4x51G63P7ba4fL4aCARQlp4PVfncS0PFMTlwCULhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBoM36H9hJB0RbB9hAHUbqwoA1p+E1fxTotEFpvqnYQ=;
 b=H2IegRpxcJphclWDqIEf2elMaCb67B7KBgFfDRNeyNkNhZUgRsrJKD4dDeSJHK/N0ch3X375hay/ujwwQKhcHcLuEAEspSe5s8C20JbIGyy+8g/yBP7Pdc/pF1wA3dfWkb9ncGNCqBZeN4Q6C9WVXblFaw96Q7gvvn7iSDdxSME=
Received: from DU2PR04CA0252.eurprd04.prod.outlook.com (2603:10a6:10:28e::17)
 by PAWPR02MB9221.eurprd02.prod.outlook.com (2603:10a6:102:340::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 08:35:33 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::1b) by DU2PR04CA0252.outlook.office365.com
 (2603:10a6:10:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:35:32 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 10:35:31 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v6 0/4] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 4 Jul 2025 10:35:08 +0200
Message-ID: <20250704083512.853748-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|PAWPR02MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: c87b3bcc-2dba-4578-6962-08ddbad5bd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZXVFowbDJqOTBGQ1dZdUVFTXhCcXdnR3VpbjdDR0dVRXMrWm9ETjdWbWVI?=
 =?utf-8?B?dWZFdXRic0lUV2hRUm9yZlZOVnRlaGRnT0RGQ25zREF6eHg2Z2pjNnQyQkJv?=
 =?utf-8?B?OWgwc2hwYTh5ZUpZVVN3N3YrbExrbW9ER1J4bmE2eldjRzFJZDZOcEJCNG4r?=
 =?utf-8?B?aitrVjlKNzZ5WG9wSHgxejdQOWY5cTFkLzNjeG1iUFlzVFJ2ZWp5S1NDQnRo?=
 =?utf-8?B?NUh1STN0MGQyUXBYaFNHTWIrNW9OejB4MFFob3J3ekd3TVNScHcwSTFQNDR1?=
 =?utf-8?B?SS84Ulp3L2ExZXAwQ0lzcDltejFOVDlreWV6NTRGbnNWK3ZMUmE0TVM0U3lP?=
 =?utf-8?B?MVFsNnpIa3J5YndVNWhSamxYZlM1aG10c3VBT21vdzk1RTFJcDRMUDVXSnNz?=
 =?utf-8?B?MEp2QmxIV1ZjVFlaQmpJdGhtR1VxOTY2UDh4YTVUNEVSYitKY3ZaTkNxT0cv?=
 =?utf-8?B?Y1hoZHVuM2p0YjNUQ3BiVXk0ZDNTYXpWd294OFpqUHZZYm1GT2ZMVndkeFdG?=
 =?utf-8?B?QnI1KzJTaU80RXkvQXZwYmtsR0VYZFdZV2tqTXU1RjRjbUduVmdUd0l5QzRz?=
 =?utf-8?B?OHF4b3NZYVpQWC9XM0tUR0R1cnZFYlZmRzZDcU5IUXJ1NFpUcFJxRzJrRGJZ?=
 =?utf-8?B?eFFnZ1Zha05Jd3ZVVGxlRTBkYlJCQ0xyaDFCakRJTWFoZzVsZENPcnpPVjdi?=
 =?utf-8?B?WmRTT25wN0RDY2NVeXZBOUh5cHcwVHZveXk3aGxJMzVoQk0xM3psVWxiU3J0?=
 =?utf-8?B?SktkbG5Eb1AyNGlSMC9jWng0VVRONlFCdFAvUXFWNUE5SWlOZytva2IxL3p2?=
 =?utf-8?B?WXUrTklSaHpuMTdWSTdqSEJnajYrVkNORG9vaFBaamxNTGgrMThFeC81NlhT?=
 =?utf-8?B?b1RGT2pycTZaa0k0ODV4VG5NU1lpNTBqUnpjOEptL0xDc1JuZ3RHSE43Nm9X?=
 =?utf-8?B?K1JKOVg4dmY2ZDdBa1RWUUN5ekFZa3V0emtYMlRmNUVuSTJQa2VHOE1jekt2?=
 =?utf-8?B?cDlzOG13UnIrWjJIbUdHUjBlQ0xIRWRTQlo2bDlnS0psVitGMEE4UnFZMVor?=
 =?utf-8?B?THdCTmNJWDg0aU1hVm9OL1ZHcXMxWmhCMmhUbzlIdXQ3dHNjOFlmT2p0QzZJ?=
 =?utf-8?B?blAvcy9KK2pQaERkZHRiZU5mNFZBbjNFU29WYS9ydG1zbkkzT0FaQW9QcUJa?=
 =?utf-8?B?a3Y4MEZOVDYyd2JCM2RMQnJBVTZHd09EOUhRTWR1bVNKSS81d0tGMkRReE8v?=
 =?utf-8?B?QzRyOFU3emJsT1Rvc1VUR2ZuN1pFVmNNVHhkcXVQSFJvRVRRZmdDWjVLbHUr?=
 =?utf-8?B?b001cUV4bWNHM2RPcDhrakZjTEx2bTVZZm93bHVyVXM2NTIySnZOV2VHZGxH?=
 =?utf-8?B?VUpDczV6QkJQdUpFOWpGaXZoQXp5VVlwTHRpRFR3U1RuWTY0S2ZOb1YvdC9Z?=
 =?utf-8?B?SHNZaElqK2FZNGltd09CSDZYUEMzbVR1VGduV1IrdG1wamUrUTJEbGoyS3or?=
 =?utf-8?B?NkR0eEJneVI0aVFCRnNMdHJKWnZ3dnozOThnVXJNd1dTdkUrWXZsV0xxWkJz?=
 =?utf-8?B?OGhIRDE2UzRjZWtuMnBGekw0bTlvWUZnWmNxNjdlbkp5cTJ3Y0o1Y2NEQVdP?=
 =?utf-8?B?d0lSZjk2M3ZaUXcwZVQxWUZJTWhFOVZqbmwyWGJaWGRBRktZQzBEWWJsNkRF?=
 =?utf-8?B?TjVnYkx0cWp1ODQvTjZIRElJWnA1dnU3dHduWjUrQkRRWUx5bWliVkJuNS9p?=
 =?utf-8?B?ckdvWklIdzI5azVHOTNxaWtSYktDeXEzMERTaVBJV1lySGZOYVJ5cWdXaW9u?=
 =?utf-8?B?STVTUWtHVzB0RFA1ZmFEZ1hKcVNRNklxQlhzSnRKSEtMa0hWY29PNHlUcXpQ?=
 =?utf-8?B?WWVlVmhVdjFHMzVhTlgvNkk0NGpSZzZsVGkvUHdvRjEvNDcrcW53R094Mk9Z?=
 =?utf-8?B?NWk1Z0h3NXcxajdIUE51QkhyeFdNcEVDU1JDNnpOOXd5ZWt2SnY5dnhJY2Vm?=
 =?utf-8?B?YndSNzgyVWlKL0JDN3crZWwzTWtYeFlEenlhd3hoSDkzNU9CaDBtSG5xUGtK?=
 =?utf-8?B?aGpRdlIrMTNoMC91cVlmTitaVVY5bk81RW1SZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:32.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87b3bcc-2dba-4578-6962-08ddbad5bd74
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9221

Fix the bcm54811 PHY driver initialization for MII-Lite.

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

Changes in v6:
  - Reworded the cover letter to explain why this series should be applied
   at once and routed through "net", not "net-next".

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


