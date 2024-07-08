Return-Path: <netdev+bounces-109819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FD92A029
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDCF2830CD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C637E591;
	Mon,  8 Jul 2024 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Rd0fQFtE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA537BAE3;
	Mon,  8 Jul 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434475; cv=fail; b=Tn3z+IQuIum8a/ox9YOQ9Av4XOvhHDFp5gIcj09gAOtM2U6dEg2VjilVcbcdB+rlJaPd/T0K1GwotO/wHm0p5R9j3PJsKJMgzIDHOc85rDcsnRGxEeO9jY2V4sDJ1oyQN+PNQRsc7qI7zY1+YKqvjyK7zXeU5RyZS7GxnGUHzEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434475; c=relaxed/simple;
	bh=zejt8OFKTHhlkFKRNmDeV7RXV6OLDH/+sCuKQMlSChc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeOmzCfDo7LKpPEDvIlIJXZnx3TLTALyaZXj3JRtvQoV67B1W5dU4dBXEMTcTIMesUp8T6PNugOwrd6tY9OL9pZ5NYVQt9ByK0Deq8c2iIH5Ah8jquQaAsHHvWEtn2abFy3wb26bDp01DTiEqaQVDG6pHSeth/Yjx32D8VavYCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Rd0fQFtE; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAXeTVE0456XAMP2tkWUkmpwYa1nQzXB5FOJJws7ETu+FSqNl4zKNPWzKkVhS3lKsgkDOswviuHDCvgfuxYyu95Gm+6i4pIaFKOO/YqJL7v2BnOnlNldi7ni5k9Y2dQ6TnTGxXCVo5K+ImptiA45rEwTZ1/F0fNBO1/pihPuJfuBLPiv2gMkgAq90HmQxXUO/skIutT/UTIjbpgaE2pvekRXrtjeG1zIbBXUSKMNF7EsVaOsVGiOCj1bi1pkMUqYjFckJaZYf9TtW9KKnQXbyM1xUQ57Ymodwrep+/MH+aOrix3uJ2tfACCCf8JPsmXrkxILsmcMqBU7bzknsM8aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3E2eS033/HxeVIvz3zPg3loEhnofdIVXYAzDT7nBP8=;
 b=Dd2RmUr/wFSDpHjH9G6FoiEp9NiUtF7j+lN4d+GxaySF2/f2wXjgqCOGbVcPQn5Uk7jadUHIbyHuWZvsvUBbCBsd8+KBvoYscI92+DhAWO1J7Mx7if8eK3GY7/63v/xkgWmp1w+xUecrqvVutGBcXUFEWdR2Ia+6M1C1qspXh+imoXwI3xNRrdPkyUDTpv+br/y/KnY+5Q8jOI0ssTbXEaS1nwHNv1ZDqBfEO8Q60+nx9duTSV2zo5yy6xDW9MWjxwuZhcVWenL3PYk/O0ALUDxbXP1TU64nAiKki54MorJ/qNVzACQMv9eVg+zMVjqwn7G/rKeW3HTtb8mLYHRGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3E2eS033/HxeVIvz3zPg3loEhnofdIVXYAzDT7nBP8=;
 b=Rd0fQFtEsyaETrH2atvkSWF0vMCu6YMLjp/QaicCkKG6hz7Bvu3D52h3ylvrqlF9RjrGkqT37oa/xWVbURBtQv3t+qm2/azrFe7ROCQ74W2GF4mtcmPq6AgwCeBMAeeJI/xlK8pO6N8DE5ObwlOnZZ+q+DZWKK5ztrBB05vagAc=
Received: from DU2PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:10:232::31)
 by AM7PR02MB6132.eurprd02.prod.outlook.com (2603:10a6:20b:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:27:47 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::e4) by DU2PR04CA0086.outlook.office365.com
 (2603:10a6:10:232::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Mon, 8 Jul 2024 10:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 10:27:47 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 12:27:44 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Mon, 8 Jul 2024 12:27:15 +0200
Message-ID: <20240708102716.1246571-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240708102716.1246571-1-kamilh@axis.com>
References: <20240708102716.1246571-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|AM7PR02MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: aac8f136-c96e-40f2-91ac-08dc9f389cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M05vOWc3ZUVEUXA3QWtBMkFuWnRKdTlRczQ5YUcxSFFsUDRPSmozckZIR1N4?=
 =?utf-8?B?d1JFMkdjbER2OHBUeTRFdDdETURLcmphQ0k5WTVnM05mM2dTMEltZ3BrV3dj?=
 =?utf-8?B?aWYzVS9henZXbzZtSWYzcEQ1cWovWlFXWkVpak5jLy8zVW9tRExWcEZocGo2?=
 =?utf-8?B?SDlhbWY4ODZHdTZVRm1xV1R6S1M0V2tVaFAzV0VRRWVRdEpBK0FMSFB6VlJR?=
 =?utf-8?B?R2paQnpjbnlsTkp1WU5vRDVEdVp1RnhEMXRVWW50RVZtQkJ4cjhkeFVsN3BK?=
 =?utf-8?B?V1AzeUxROEVld1p3eHhzR2JMUld4ajhhWC9YZjRQSTZVZ2FwNU1uTFp4bmc2?=
 =?utf-8?B?dnFoemI5aHUvRCtxdXFyMXo4cXhuRDU3RXZSVFI4ckYwUnozeHZmYzV5eUFZ?=
 =?utf-8?B?djBnYzRRYjg0WlFBVmJQbUkxNEZOL3RCcE9yemVYb2tobS9XUjRpSGdtbkli?=
 =?utf-8?B?RmJpMkhjR2p2U0xKMXMyNC8wT0Z5alNPdnBORENKd3ZFRkpEcjJIUEhwSU1D?=
 =?utf-8?B?NVpnSTRGczQ4dlpMTWpmdDJKYldwL2g5UisyeFluVHA3cnBieXFLUFdRdUF1?=
 =?utf-8?B?bVZCVDhoRjNobkQzcEExWFNBdjl2OG5iaTBJV2h3RDQ2WTRtNVh1YnpSUEZX?=
 =?utf-8?B?cUxqZHdSendhNGNBNEpCeW9tU3d5MmNzOG8weHZQdUFpSVlmclBjTnZhYUhB?=
 =?utf-8?B?RXdib1ZzVCtndjkzTC9aYjJVSHluU2dpUWx3c0dsbUJGMTVoQmN4amNySU9q?=
 =?utf-8?B?c05zTHlTdm5od3BKQWhsbmp3N25rYUQ1SGtTNndxMFEyTWhXMUE0RE9WeGpH?=
 =?utf-8?B?elNoRFFzNTdPaG5zMGZWc3hzM2ljVC9lOFUyVnJkR1NhdUdyY2NRZVhVeVU1?=
 =?utf-8?B?WEN2eDRBaTZWVUUvaUp1VkdmV1R6R3QwRHZHWS9FUnBZczdwc2YyN1kxbTNs?=
 =?utf-8?B?SlE4R2pqSEJnQWc1MldNSEZQQXp2YW9EUWpZaWFqSDZBZEo1dFBjOTN1QVQz?=
 =?utf-8?B?YUQxRjRHVTlON3RuMjlETmhZT0E4QkRXOWZCNytxaHhHNTBkQjFzRC94RVhJ?=
 =?utf-8?B?MnNQYTU0TWRxUlZMdXI3Q2tMaE1XS25Wc2RXNTlDblJSSnFSRGdKUGZPT1J5?=
 =?utf-8?B?Wjh4c0E4WVVhOElqSWxldFNuRDcvQzlCeXdjaG5KMTFJbjNCNTNFYldvTkFJ?=
 =?utf-8?B?VldxSEIrY0l2L09tTlJuekVCSkhlTzhOU0xNWm83ZmRmSmpSMjljVUNPcWRQ?=
 =?utf-8?B?MVpCaU1JMW5nUUF6cThod0lvSVl4ZU1MdzNBWHZxcTRCNGM2TVpOZGJuSHFx?=
 =?utf-8?B?N0dIWDhreDQrRTVkbVhUQUJQVzJTdmh3bm40bkFIam9SdGNybXFyM1FaV2dC?=
 =?utf-8?B?MHFlNVQyQnJqcGF2WnU1SVEwdDBJTXBiQ0Q0b2d0OTZuMUdNYStjZzRvaEU2?=
 =?utf-8?B?b1hwODk4bEkyVjJCMndRaUp0MHBXLzdqTGQ1dTBSbG4ybzRBWjU0ZVd3VVZ6?=
 =?utf-8?B?alJpelI0cjZuWUE3UkhEQXg0clpxV1RLT2ZxRmRVYjcwQVZJaGJHaE9VLzFV?=
 =?utf-8?B?dVpHY2s4eHE2SXRlS004TXB0MEFZMWtmQjdPdlJ5M0RVQzV5YXhlL0VHRytP?=
 =?utf-8?B?MmVwb1BlK3hzcXZ1RWxBNnpaMmxMTjBKZnBGdFBoaFFuRHV4UGFUTUZPeGpJ?=
 =?utf-8?B?SmtZeWEyQ1QrMDF1b0NLZEFzbFhBVWxzTmtvQ2RVVndKTEV6Wm5Ob0FlMk1P?=
 =?utf-8?B?NUQ2VHJUcUpBSW8zTFI3WlJPRkFvT2htZERWd1pVcS83OW5raUZ2S2pBWTEr?=
 =?utf-8?B?NGRORFlUbGlReUU2a05PUWh6MEd0dFRObUZyZGlOYnNvNVFieUhReFJGenNX?=
 =?utf-8?B?bTRJd2tGbnJEanBZSFpqbE9KRFVTaE5LNFZXYkNtam53VjBmcVpuRTE0RG84?=
 =?utf-8?B?MHRuWDJTdGd0VjFxTGxkVDY1Mmxkby9HZ1BpU0g3WEF5T0tYZm56ZWdMTmU2?=
 =?utf-8?B?RkJxbDBUMUx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:27:47.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac8f136-c96e-40f2-91ac-08dc9f389cd9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6132

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
index 8fb2a6ee7e5b..d9b62741a225 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,14 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  brr-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, indicates the network cable interface is an alternative one as
+      defined in the BroadR-Reach link mode specification under 1BR-100 and
+      1BR-10 names. The PHY must be configured to operate in BroadR-Reach mode
+      by software.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.2


