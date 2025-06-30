Return-Path: <netdev+bounces-202445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909EAEDFCA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D297A60E1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738828B7F4;
	Mon, 30 Jun 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Z1XRF+Sd"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249528B7DF;
	Mon, 30 Jun 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291939; cv=fail; b=JlVUiGBBTGpFVk347yKLcLe/cJrhLGl9amPCIdsp+gpcSHNZ2d7LszTPRrkss+uedC1/8H7ToGt6kZdgCHuHuwTUhx3gMQOgwD9MU09UY+2ogqM0XpaNQGvgjkHwUH8r1vn1oDthIfnfNRVr8GhUcN6Iaas+Z3fQthci22ekxNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291939; c=relaxed/simple;
	bh=xce+MpHzEwJliYk0xmo6AdG0IruXd0WX4LPpFM3b578=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkqnsvtizirBFEWAUQenqHjbg1r2Bw94bF2MVykgCaRmH56hyWFFqf8MYJAK7Q1SfyqeHJdiWUmVVch4MODJiagTcdQ5kwuhOU+JwJEt4003HbFKsyHuCCNvlAsgF4C9Et2T7eFe0G7/SBjMQs7ghkLzHT16aJNxM6v0CcAxQ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Z1XRF+Sd; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIjtum65xmem3cA90xOr51dEvRf2UsqzIO2+XQmj+tuW8OfbN0chvXRrOSWfVkpS2FuW14oFh9Aw4ELsuvMqw7PxT4l9bsivN5YkSjjwXxB08bOl1vqRvoCcvbmGplIBZVYJaiubrNoELh2fP6eC90bmWSa1RId8JJ6yFLgwJkZ0Zd0bKURBQUDmtpEOfGQlez8j4AuVSaHA9/e+tpSIixqJfZcu8fVf9P93fVi0IIzz9H58xlap9WUjQuvXUeTsBw4RSSZsxP7+STxqy4tvh5V24/nyKihNBLwzdJG+97NuBtxXsTM+OeplJrcA/Q/7o7jRe0jwPCcEAZk9NoUZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbvlDC6LuUGEfBOGTC/Fn234HntBvlSU/d6fFWEQQSk=;
 b=N5lfaU7SphBoPzF94ysTV9onuoZfXsbevRkLYtyOlSBUlPUW8+A+rM7olRd1kSlySB/3cZ3iqh+Vvq3m7ym2XawMGLgLcVHEIjmkuNAv1ayjDQcRyzpsc+3Qp2+JbFhcL8Uh6fkSP6w4hiUPChagPzxo0uch9MQMBQGpTJ1jnZzONgCXpDvpLGDRHh60K3GdMejuqA1S08zk1KbtmaHby8TCBwKsXg8zH2eWcNLjliQqh6Z/Db+UgtPXyFnGACJhajuR6XAgE18Lkmjrm38yEiTlcooS/PYVb6JRKA01MfERW4KOhFnpyM2ustui7/Zf0lVBy5r4nHt7CnzCu3+aLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbvlDC6LuUGEfBOGTC/Fn234HntBvlSU/d6fFWEQQSk=;
 b=Z1XRF+SdG237vHPZjcGxt95I6WkSjAqKUjLAJkWyXuZqdgDMo5LA1hL2noiwwTRy7g2K3ngHqn0ebNYig68erLJM9qbt8LNLQsP6fRvuFFBzDVApsHSs1pLAjYApM1um8d430VM2NumSTdfekPCvUSPZbNTu8yw+S6lgV0KcUyc=
Received: from DU6P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::21)
 by VI1PR02MB6317.eurprd02.prod.outlook.com (2603:10a6:800:17e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 13:58:54 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::ad) by DU6P191CA0041.outlook.office365.com
 (2603:10a6:10:53f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 13:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:58:53 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 15:58:52 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v4 0/4] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 30 Jun 2025 15:58:33 +0200
Message-ID: <20250630135837.1173063-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|VI1PR02MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: a44044be-0abf-49e2-9d63-08ddb7de3fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|19092799006|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNLZkdvclVVYzhQSGtCKzZzaVpVcm1zMzFYVVlGN3dwRjM2VU90RXhWMVVT?=
 =?utf-8?B?K2NYVjl3NnNHdGdzcEZsaS8rTjFPWEU5V3NYaTBzYUd1ZExYMkZIaVkyYWdP?=
 =?utf-8?B?OEZYVFN2OEFIMW9tOE0wVjd6endZOUVxYUpJS2ZUWFVNdVBBTkZoeG9Ia2F4?=
 =?utf-8?B?UmlSYjJ6V1FCaURocjlTdHVQNHZGZlZCdlMrcCtob2dGRmVaUzc0eEowOWNt?=
 =?utf-8?B?V2dOeU51SEZkdW9NeS9KZDh6QmhCYmR0NytNZXpLa1hxMlU0Q2hLTExvdU9S?=
 =?utf-8?B?Z1AyMmdxMXZrdVlLYjY4RThwbDJCU012d1l6ZFhoNkR3NHFRLzNINFBjbThx?=
 =?utf-8?B?eFc4L0Z0VElxbjJyenB6dWozQ2ljMTV4L25KV1lkR1B4TjRmb2pSVDVGRm1O?=
 =?utf-8?B?SkFLZU1yWVF4RmkzTFphYTBGclpUY1RIQkkvRGZrc2xxd2xBd0wvSVovaHpp?=
 =?utf-8?B?SmIxUU5YSXJEM2s2R1pKZ3A4QWtTbDNLZnovOXdpRjIvRVRJNGpFZkQ2OGhh?=
 =?utf-8?B?WkVIQUdWZkVGNWR6QlBDaS9rYnZKeUFqaFJGQ2lKSTdlRlJJaG9Ob0g2TVZy?=
 =?utf-8?B?NDd2RWZoMkNYNXlZMTRkbVBScE43eUZmL0lBbVFSU3FYT1pPc2owQXd0aTZK?=
 =?utf-8?B?MEw4Q2ljTDZVRzRTZzVYVWpNYng4Tm1UODBqR2hSNFRnNUkzZ0hzMGNMTmhJ?=
 =?utf-8?B?dVJFSU5sMXA4K2k4RGtQMm5HMW9OeXdKVXBPOE5zcHZzZUNoQ0xSL2RmS2M1?=
 =?utf-8?B?WHNqeHhMay9iKzZLWHBKYWxJN3ptOTNjZUtRNnBlUWdDVG0yTDNNVHE3c2tX?=
 =?utf-8?B?UXFGU1YyWUYvRnpaVFFYR1FkMk0zZmc4T1UrS1Rhd1V4TU5FZFNKeGtVOHhQ?=
 =?utf-8?B?MFNTOTFlWmxYbjdkeHMzQmdpS2RBWlVUWUFUZ29uN1dyNk1HVFpiQXhGbFFs?=
 =?utf-8?B?MDU5djRkMjU0TlJVRFpvUlRrSjU0NmQxMDNiZEJ6ZkFIMUdtUG5lUHpQTU5j?=
 =?utf-8?B?Ym5nVnd0aXV0UGsxOVJJYTJWemZkZVIvamlNTWl6QVhpNkVBWjI0WUhmWXh3?=
 =?utf-8?B?SCtSZUVRaW9iZ1Z5ZXZ1SXRoZjBzWTROV0s3UWhBTUpUbU1CMmxXMTNhandF?=
 =?utf-8?B?ckNCdmtSUUhBWWlDT2ZJaERhaUhyN0VKOFBpR042YXVkY0VRZDlMODBuK1RS?=
 =?utf-8?B?UEFsNWZOSm5Td2wvMnJqUHg5UFRZcnpycmZZUXlCTlhQSUY4clVhSWZmQVph?=
 =?utf-8?B?VWdPNFVDOFdNdXRWL1Y3Mi9Xbnh1cWlhbHFmb1JOcmo5T3ZLWTN3cTRuMEZE?=
 =?utf-8?B?V09BZDNJSDludFdWV1RiUVluZjd0VngyYnZRRTcwRmtib3FMVGtrM1VLNVRD?=
 =?utf-8?B?TnBObWVmSXZvdXJuRTRicEVwa3pSM25aZ0xjcnpNbURSajJwZVUxclorY3VP?=
 =?utf-8?B?OTAzYW9NL214TU5yRmpORFlOaUJGRG5nREUrNnRjQm52VFdSTVg3eDJaV1F5?=
 =?utf-8?B?dUtvYm5RSDJWZnJQblBrTXJERHlSclFyTlY3T1U2eDJpYy9Hc3lZZGQ1ZTVy?=
 =?utf-8?B?ZW8xbVFMeElDY0w3RVVEVytOQXRqQWVuKzRUMkZqcFRpMkZnYkxIS0pXemk0?=
 =?utf-8?B?UjRBU1hGendVS1dOenBRbUQrWEQ3S3ZGQTVuaS9nVnU2QmIzTkRsL2hOdjh1?=
 =?utf-8?B?eXVpOHJJWWpuVExlS3V3ZkxaVkcvWmJZcmt0T3ZoTDF1aXdwSGJjREluT2kv?=
 =?utf-8?B?ZURhaUlXdDMrOE9iT0kwblVGQUlFOXJIZEM3bUxwU05UWHFqKzlHTG94Ykp4?=
 =?utf-8?B?cGpXK2w3dDliWm01TEhtQUVURHFXdGhSNFNZalJvUHNLOWxjYnU5cHdPYWdl?=
 =?utf-8?B?YVFucFNTblZOZDgwajZWdDgvekZzZ3o1aHI4UjhGbnZ1S1I4YjRBNlFWbkFs?=
 =?utf-8?B?THFwaXF4cWtuN25SRjhVTEg5Z1hYYm5mdWJuYXIwNmNrLzE2d3puQ2RWVkl4?=
 =?utf-8?B?K2x5UzZGcWlZZmZjMXoxYmdDUE8rM3g4NzRrS2YzekFzYmJOU0lEWWg2NC9x?=
 =?utf-8?B?RldiQjlDUDU2SDE5akRrb1ViUFJpYjJjUGtEdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(19092799006)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:58:53.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44044be-0abf-49e2-9d63-08ddb7de3fd7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6317

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
 include/linux/brcmphy.h                       |  7 ++++
 include/linux/phy.h                           |  4 ++
 8 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.39.5


