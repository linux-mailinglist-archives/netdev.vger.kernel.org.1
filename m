Return-Path: <netdev+bounces-105676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665939123A0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B021F28B13
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC317C203;
	Fri, 21 Jun 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EEhsnDHJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918417C206;
	Fri, 21 Jun 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969253; cv=fail; b=D1lo4ARaWvaIE05AATMQRhvHBvAcwp2AUzfhjxI6vtgO8DvfpuIUmg4ra034fhHPj0YVpOilaSqa5K2WLZP2vZAonbQbjcbtHPLo+CG/v9glJ1GDBCQYjHVjBtU87BRKQTomHNRV6QeMUSWFr/SDDoz1kYN3CsOHx+6fdIIHBDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969253; c=relaxed/simple;
	bh=CP3rzto5ZSB2Q6gYnwgFIp/TtIVmjDlIHEod2w6/Sgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYsuKaxCJ/HogKcF8rWc5KkTf6nv0nOIV4EYLD1YiQ2ry8pcl0B7IZqTxzo9OHG2npKP9I8gdICr0m+igsFFjUT259nEl4cqfLHxTg4q51nJ+KerrsHVAgnL/IuFqGBJNzlF9j7txmJtKimvo9U7eqM+QIoTT2ObUuhrNzJqXF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EEhsnDHJ; arc=fail smtp.client-ip=40.107.14.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV4U8zuEwpuWIcEHE3TriJOASFwpQ6fqyGV1pF0c6/uBcy4xmE9oDTJcNIAI4AJQSf1KHjVVGtTgKQlpP8NOuRGMDj0bed7fMDddL2vkQon7X39v1ITV53f5TQGJuhDTCORyK2pPngBHACaoXqncIYUhAlSAzqdmg98Tl5AZsNAKAc5QDNW2sth+3D/gyM/E54LVE+ijJRb+ssTi/u4d7ToKwJH4FE4s3cKnSb43rWfW+lmQsUgJKoVnslRBsGEcvhEbvFKJwVbJRojh4H/R8fjLFo3zD3YYboRr3/vdDPUvmblJ/cj92Yy6uPQcxuHpv4s3RHQ3VNCP3BVet2eqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On0aN//aZG4ZrDmC/JNdRuoc37i/FTYVznKXrV7L2YQ=;
 b=GeKxM3QZ6IxhtabDNksbS7bHZWwCXceLBuVeg7o2MLYv0M9wju+7jjPKcc898mH6XWrciCc1HQb0Cm4pSj8PsIsXyJErVLbc9tjHjirIR/i81yTUP6B5PDnpS9IXGRTiiPguRHlJAPoe4MzW6re+dbU2I/KbEU5VNGw+TixSqS57I3iACzxS/M6hqG+hIRco28Ki7iWAG06e9BIKq0axAouQdoMhtAHqe4wutcAo5+Pfcv56weUw3qSrScIYV5s+gN9ForzKKlfCYQqQHUwLxaPTizLwB3yQY/Vqd7YGwIypHQxwVOph/91HAwhZ8yxCFwq9sySb7ANGWT2vj3RmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On0aN//aZG4ZrDmC/JNdRuoc37i/FTYVznKXrV7L2YQ=;
 b=EEhsnDHJuNcHkwQApFfvnQGIPj4B9g3f6Fc1aHqB7X6AGVBAzsS9khhXcBwvsY/AUIzpXsGp4JSveSzcYFLNHFMwZVzyTd1lpDzL32pGIw8iL1+GvoxJLfoBM/+8j+X4TL2XUcD02W+/IohMwTRLYN4xwwkGHzWCAevqSky9kck=
Received: from AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::32)
 by AS8PR02MB9603.eurprd02.prod.outlook.com (2603:10a6:20b:5aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 11:27:22 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::7b) by AM0PR10CA0022.outlook.office365.com
 (2603:10a6:208:17c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 11:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:27:21 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 13:27:20 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Fri, 21 Jun 2024 13:26:32 +0200
Message-ID: <20240621112633.2802655-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112633.2802655-1-kamilh@axis.com>
References: <20240621112633.2802655-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|AS8PR02MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1773014d-0a8e-49c8-a0ea-08dc91e51e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWtFU3ozWGJGaWtHbjBtWXl0OTZRbko5TXBJakl2eXk4LzFsem9PeFZvNyt2?=
 =?utf-8?B?M0NHQmpwc0ZrUWR1VVJ5YS9kQ2ZBM3VkbmNhOXFHMmJveUlCZnZoZWhtN2Vl?=
 =?utf-8?B?eGh6RVQ5K2xUNzBMVEJNWitCekhmYXF1SlVLQndtZisvVVJYYkxjaWtkZjM0?=
 =?utf-8?B?ZzNjVGptdlRXR0lMd3J2OGozaHlTUmJGWUdQQVcwRjVrcll3VG5VQTZYUWFI?=
 =?utf-8?B?UkVIUWJQd0xZZzM4UVlETWdhWHFYenBVem9PMHBZaHdQYjNNemhGWmhXbWhl?=
 =?utf-8?B?UEtoY0dZbjhUYXExTEVIaTlHZnVtUS9wTTFrcmZrd05UME5XRThIWmhYcVVZ?=
 =?utf-8?B?UE4vbE9NNHpNR3FHYzlKRFJNdERUK3YwRHdpL1dpRjlhSkdROFZESSswTmpT?=
 =?utf-8?B?NkxCemFwYnNaZ05BT2g4SWVSNHVwdlF4Y1Ura3JwVVo0U2JRV0l0MngyczhK?=
 =?utf-8?B?eHFYZWgrM3VLcUhFM0pyYmZlazRENzRtZUE3dUplcFdwMHY4SDFKWkZ2TU1B?=
 =?utf-8?B?NWFVeisvSmhaMncvNS85T3RxbTN0YmdHQlVybWRiSGk3NzVZa3BhZjMzRjJs?=
 =?utf-8?B?NU9qSUhlazBHZ2xCYzJnVWNpQUEwbGI2dllxU095N3NEbnhmc3k5U3drbmVS?=
 =?utf-8?B?cFRZeHg3U2ROdXJWaXNjUlNQc0hHNnlxL0VvWlV2YVY2MUwzMlY5dWwwZ1dP?=
 =?utf-8?B?cWRLcmI5RkpMUEVHaHJCVUlHVmlkSTBGUlNsdmlWVHc3bmYyb1E2bFF5RGZE?=
 =?utf-8?B?UVNKWjgvNnJXc2NZYTBCc1NkUTJZOXVQWUltYnZpU0ZKaG9UMVZtb2lUYTFi?=
 =?utf-8?B?M3BYUkRPSWJ4eGVoTmQ5UHlsejV1TS9PdVIxSEowK2ZnYmxDRUdWN3lWQ2xB?=
 =?utf-8?B?bUFDeElpb3c3MGZFdDBUNXBab1grRVdlUEc1bHZXb2lBSVZkNTFoanNyeHZ1?=
 =?utf-8?B?Z2N2a1ZaRVJEMUM4bU9SU3B0S3ZJMmNDZG5kR1dMRVBIbUpzbnp4andxckNu?=
 =?utf-8?B?REdsbWN1TWVMM1UrUjREbEdlMWVFeXJNWVNtWXNPUEYxZEpOaUpSZGdLL3hx?=
 =?utf-8?B?ZlQrSnduMkRORzAyeE5DRm9kR29FQkJoYkVJOEU5UWFkM1pGUUNJR2NoVldN?=
 =?utf-8?B?bkFFZ0Q5YjJBb3c4ODhlcFpXNVJobTBHWG1qWnhFZjhHbU5KaFRGMXpIRU9t?=
 =?utf-8?B?eVIyYTU1cDBkSm5sMENxcm1RZHlUZWZjUWFsdTUwZFdmRG0wYVBUbk9FY3Fl?=
 =?utf-8?B?bjVEc0pOY00rbE82eEpGUS93QU4xdEYzUzc4REJ6eWNodTVrSnJ2QzdPaDZX?=
 =?utf-8?B?UUdsZW03anFIWmhCTXBuQU9vQUl1ZUd0d284eGJVQW5VR21pNTZEK095T0NG?=
 =?utf-8?B?SFcwWDE3VnhFYW5RaDVrNkY2NVRsdzYveXBOVkx1bHhKdjV6UnJWV0p0aC9r?=
 =?utf-8?B?ZlgvQytQS21sMUVUQzVETDRCeFlxTlZlUjJ3WTZqUXZiNCttd3NDdU9YL0dq?=
 =?utf-8?B?VDdyRG5XNk5lcGFUcVgrMkdKd3RsNlFEMHZ0SGpzanVLWTdzU09QQzRqWEh1?=
 =?utf-8?B?UFg2VGQvSFA4Z1Z4NTZvcXF5dFNkSDNoekZiWW1ya0ZudW9mWGdvUmNGK0ZF?=
 =?utf-8?B?eTkxQ3BSOVBRZ1YrdHc5eGNaSndxTHBXWDZicEMvVG53SlBycnVOWW1pUFNh?=
 =?utf-8?B?ZUY4QUg2cTgzL3ZhOWFYU0t0VVR3WThjZks0Qy9jYVNiYWVDZFRsOHZ4a0pB?=
 =?utf-8?B?NldCTGRaaWlEYks1Q1podDFleDNsbW1ySXNEazJSSE52K29qTTNmVUs5NnpE?=
 =?utf-8?B?alpPUnYwdHM2Vk5NMDhRc1UwR1U1RUVKVkhsOUp1eUJ2U1FtMDk3TzBqdWtj?=
 =?utf-8?B?RDF5ZDd6OFdlOExiVWhRV29JL0tyN0VKcjFacEdRelVUQThHY3ZnMVgrNG9x?=
 =?utf-8?Q?BHSGWKb1pnU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:27:21.6981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1773014d-0a8e-49c8-a0ea-08dc91e51e0c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9603

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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..0353ef98f2e1 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,13 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  brr-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Request the PHY to operate in BroadR-Reach mode. This means the
+      PHY will use the BroadR-Reach protocol to communicate with the other
+      end of the link, including LDS auto-negotiation if applicable.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.2


