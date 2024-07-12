Return-Path: <netdev+bounces-111090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB692FD28
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054DB1F24995
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F5172BD9;
	Fri, 12 Jul 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="M0cUmmqG"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE38821;
	Fri, 12 Jul 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796873; cv=fail; b=e38Af7MD3uiueBDkeSaGGjAuK0uKso5bCksQtN55v0dwAhfV4Jknj9Bt3CCKHlcbaf1HyRcQ4rrT6XAINpmt0WUWBIR8DlGUDWcZoNi4dpNMQasChMqrxvufoUU2D8bXkWtjkp3wXQf4eUuq3sx0p61PGi3Hdmk7DKIXOplBW7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796873; c=relaxed/simple;
	bh=7E0JO3Jg/Q7HpN6Lrs8MGC7yiQafE1N1pldN5Bub6X8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRw1x8mdBhjm4DyHqsKXhmUnBPEchBwihQ6KNltxeq0Bu31gG09JLvcnFh4YzwXdT4otHr0wxJBdaVbbhcy2alkds2mkKIppnHnQJaRZz44ELMtHCsfv/YSqIB0/Z2wkSKvGLQCHfhu5sM5gHddwWfi/4feSt1dv0tv4Bt4Acmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=M0cUmmqG; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWB4lUWT8A5NZDbvXWxgWI2eMibm8/vbsJHxCfYNTrMDuZfLDnM3QgzSBTcfg3uf53PvT4TC2TFJqM+w9AEeKgKlU4Pv2W1PJjNBm/cCloSD6CLzBkrjZNbojsls4U77LGJTnu0k8ruV2wimwfJ6/JclRNlQxuzWjZBggklofaFeMy0PUW2B8Iy6imOzV14JScv8OXEELAMdp59+a8EOSytFxE2bfHJAtDQvNIpnnOLzQ9bdQFRAsrRBtV2QJV1cgO5PRr+Xzt/koWxzPr3m9A2DjGqJGEjgYw3Kf0i3uULOu5IhSX6Bz6iVYezMqsAZUY0UXbV1M2yms9O33WUivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWFWUE4kCue6kUyVwb4TNKUJeu7mRq2cw7a0fdNtUdI=;
 b=coyQ4S4Ciw9d4LQhmsxXYnz7U5KDzkvCTSsc3GQs9In633bbeXe1qgWPzmVG6P3MhC3PPLa01m7Dt1Z7Paby1PvaVPW0CpvV3DzEefgvLPZEB8VXf7dUmPjVCKPrD1NSQTUXayFlfib68tRAU133o+6oomSRWYOuT1hKLYI5P4ujynHzucHIvQGwR5D03y5Xbn5/jxiNeLx5D5WnV1CoFWnPxgjp0aGPIaaJDx2s5ODxhlh7mnNGIyeL21TAzpneRLhdPv/dy4oE9FQSRDRFK6/Ma14P0gTlX86sGBGExk/TNLEmgponmQ3HQQmHdlPcsYHm3zHu7pT6e1ejL9rSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWFWUE4kCue6kUyVwb4TNKUJeu7mRq2cw7a0fdNtUdI=;
 b=M0cUmmqGf41URkm7D2v3Bw7veGYvh/PCgbJwAEXj3XGvtRHRGq94YL5mpfu925j71tZNpFWyeN049g0tecyg4GlDJsKw8UwY9Ae4jVZKfQO1HNYv5fjsHhfboP/dDgMv1h3+Ykg6Hl4of7n1Gz0blBuccHTnCXqbfVBn8hJQSyU=
Received: from DU2PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:10:2b1::25)
 by DU0PR02MB8292.eurprd02.prod.outlook.com (2603:10a6:10:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.37; Fri, 12 Jul
 2024 15:07:47 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::18) by DU2PR04CA0230.outlook.office365.com
 (2603:10a6:10:2b1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 15:07:46 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 17:07:45 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>, <kory.maincent@bootlin.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Fri, 12 Jul 2024 17:07:05 +0200
Message-ID: <20240712150709.3134474-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DU0PR02MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3d433d-86b0-424f-9396-08dca284630f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1BLeTkwelI3MWxiek5RV3MzYUNFUXorWVR1aUFQb1R4UU9aZG1LNXI2VTNR?=
 =?utf-8?B?ZjcxY3BGZUpZR1N0blc1YVdPUXRVa0d4c1Nvd2VZcHBMWVBJMzdSL2FaZjkv?=
 =?utf-8?B?aTU4dEVqdjdEbmNIRDVFMXp5bnFHbDBFeHJBQ3QyTzNWK1d2NXpZT3dOUHZp?=
 =?utf-8?B?Wmc3NDQ3NGN1OUo0MzVtMEVtdk1xcDBhOFFBUmVaSmJYL1NOdnArVytZQjg5?=
 =?utf-8?B?cC96TkZGQldGamQwWk81RE12NFhVRXk1ZWRZdGlOMEtCdmoyb1A1Yk5nY0Nz?=
 =?utf-8?B?YzNQR3RMTm1Rb003dDdMR1pSeHpPbmNFTGNkNmJTTFNUVEpSSFRtaGNOejB3?=
 =?utf-8?B?SGlNcHhwQWxCNkJLZ0V5cmI4ZHhOVElHTFpGcmVYTjBGMkRDMFVYbitrRExW?=
 =?utf-8?B?dFhzbHpKK1REaUhlZ2tCQkhmSnUzdXhaRllUYXBrMkZxekkxMzZodSs2dVBO?=
 =?utf-8?B?WnhrQW5RQllHZFd3eGkwaVpHaTR4VU9pY3hhRFlHQ0N5YVZDclJvbEhPdEtX?=
 =?utf-8?B?dkt5TTc1NEZvbmhRU2tjSEJ5cDZDaytyS2Y3Q3BCcjg4YUs4QVZ5b3FGVlRY?=
 =?utf-8?B?L25LbVI3RFZWUmh6aTFKcHppaGJTdnJjZFc5S3A1STVHcURQUGRlRjNFT2d6?=
 =?utf-8?B?Z2IwZjJnOTNDaWVKZVVsZ1Vmd3E1dExxdXFRSVBxUUU2d2xDenZCMWpmMzFi?=
 =?utf-8?B?MlRYUDZ1UE1lVytodU5aTFVXdHJvSEE1MEJnTFVicU0yWkRJejIzS0hKOUhG?=
 =?utf-8?B?dWZZbjFNL0xRQlpaVWZvMGtBdGl4TmFFLzJLbFgvaUhWYTRneE1mcEYyVWtR?=
 =?utf-8?B?K0lxSE5ySlk0SThqNVpvNDJuS0RJZzdOSzlFdGdnVGw3UzQrTTF5ZTFUdnRw?=
 =?utf-8?B?dzQzU1ZGVVArdG9wL09DUG5IaHU2bUFSa1RqU1A4a0ptOUd2SVNLVFFNb2s0?=
 =?utf-8?B?NGRhQ0RKSDk3c20wM3ExWTZJSEF2TU9qMzJDZ2FhNS9CZUFkLzZHVkc1ZVdx?=
 =?utf-8?B?dmdDdXBBOXJYZ1RsOFNaVjF0RFhGOFVCc3R5RXJwTnpHdU5PckQ3aWhrOGN3?=
 =?utf-8?B?RjJObk5qd05KWUpaZlNlK0Npd285eGo3QVpJTVZMTkFGb0N3Q2JkZXZteHE1?=
 =?utf-8?B?YkwxTWlVZDI5NklKYTZYS3NTZnJpd3dpQTdsV2xhaXZZaTB3bHNnU1RsQmRr?=
 =?utf-8?B?WXJQQ0l4N2JjT3lVenFKVEFWS1JJekIyZEk1R05iUDdzbURPd0x3WmROQlF6?=
 =?utf-8?B?bElvUERvQWxEKyt4c0R4cXc3WlNSWHFrcEk4aGNCOHh5blpNd2ZaTVJGd2lD?=
 =?utf-8?B?VURRVkN4UWFPZ2ZJd2NDOGw1VHZwZzIzR0ZITDdCN2VaOUhZSEdYeHA4TmNG?=
 =?utf-8?B?cmxLaDl6SllUWG9yWFhETVpQb3piWmRmT2pRQndyTzhicGIrdlFWUXhjK2tu?=
 =?utf-8?B?U2FRb1ZLMWhGM2xFNVIwTUVFMTZTRjIzajRtVm5seS82dmlGQ3c2MFVrK09P?=
 =?utf-8?B?bTdYNGNNbWZiUk9Xc1lhNm5BY2lUdWZDZGxnK1NsMjBVU0p0K0pUbElQY3py?=
 =?utf-8?B?aDYyUW9UZnVPa0I4dndwdUdHakdYenYwVGx3emtodFVHbEFMeVcwbmQ3MUt1?=
 =?utf-8?B?blFqOUFna3RySU4xKzZlc2VzRTlvL2QxdG9pbWo2S1J3RHNxSzFKQmRrWnJl?=
 =?utf-8?B?bmRwdUthaXYxdjVwTkJXemZQZHZvOWdZMVVvV0FuWXJncmFzaldIY295TkZ2?=
 =?utf-8?B?QzM4VTFPVFFvS2VJQy9ES0ZwNkdBL2E1bE12QjN3VjU4VVhDcnA2bkV3ZzFt?=
 =?utf-8?B?TWZWZC9aM2t6WFFTa0x2SEJyV256T1JiWGI0Y2t3R1JMMWdBKzBrSUhtbFpp?=
 =?utf-8?B?WDlLUk9INnJ6bDBQR2RCL2VyMitwSjBBV1pUS250N1M2SXhIdm9zZ2Q4eVA5?=
 =?utf-8?B?cFB2akw0d21qbUpvcXEwTzZzcTZzOU4raXViWk5rU3ZmWEhXTy8wQnQ0MWhQ?=
 =?utf-8?B?Mk9sdmxETUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:07:46.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3d433d-86b0-424f-9396-08dca284630f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8292

PATCH 1 - Add the 10baseT1BRR_Full link mode

PATCH 2 - Add the definitions of LRE registers, necessary to use
   BroadR-Reach modes on the BCM5481x PHY

PATCH 3 - Add brr-mode flag to switch between IEEE802.3 and BroadR-Reach

PATCH 4 - Implementation of the BroadR-Reach modes for the Broadcom
   PHYs

Changes in v2:
  - Divided into multiple patches, removed useless link modes

Changes in v3:
  - Fixed uninitialized variable in bcm5481x_config_delay_swap function

Changes in v4:
  - Improved the division of functions between bcm-phy library and broadcom.c
  - Changed the BroadR-Reach / IEEE mode switching to device tree boolean as
    these modes are mutually exclusive and barely could coexist in one hardware
  - Made the link mode selection compatible with current ethtool (i.e. the
    linkmode is selected by choosing speed and master-slave)

Changes in v5:
  - Fixed the operator precedence as reported by the kernel test robot
  - Fixed doc of bcm_linkmode_adv_to_mii_adv_t function

Changes in v6:
  - Moved the brr-mode flag to separate commit as required by the rules for 
    DT binding patches
  - Renamed some functions to make clear they handle LRE-related stuff
  - Reordered variable definitions to match the coding style requirements

Changes in v7:
  - Fixed the changes distribution into patches (first one was not buildable)

Changes in v8:
  - Fixed coding style and did other changes on behalf of the reviewers

Changes in v9:
  - Applied reviewed tags to unchanged commits, reformatted the submitter's address

Changes in v10:
  - Fixed minor CR issues, clarified the embedded documentation and the commit message

Changes in v11:
  - Reworded the brr-mode flag documentation

Changes in v12:
  - Reworked the BroadR-Reach mode selection as suggested by the review
  - Renamed some functions to make clear that they handle the alternative (LRE) register set
  - Some minor changes as recommended

Kamil Horák (2N) (4):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  dt-bindings: ethernet-phy: add optional brr-mode flag
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
 drivers/net/phy/bcm-phy-lib.c                 | 115 +++++
 drivers/net/phy/bcm-phy-lib.h                 |   4 +
 drivers/net/phy/broadcom.c                    | 403 ++++++++++++++++--
 drivers/net/phy/phy-core.c                    |   3 +-
 include/linux/brcmphy.h                       |  88 ++++
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/common.c                          |   3 +
 8 files changed, 596 insertions(+), 29 deletions(-)

-- 
2.39.2


