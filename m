Return-Path: <netdev+bounces-199788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C6AE1C8E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702803B0459
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA32980CD;
	Fri, 20 Jun 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pohHG9Da"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6D295D91;
	Fri, 20 Jun 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427189; cv=fail; b=IAjTpQGNfJ1N3kaLhpBSYBzEp8J+RvTvovN4vESESbycuAtWaRu1t7NNq3WoNNNArmp+FIuX34inkxj0z5qJQXVRbKoBsIdeCkx7pp4hLakKoQYg9DKDYmxRhJ3LekopkG8x7JTKKxwUUoRSKVAIq7zc0hort4jYjBZbiw58tjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427189; c=relaxed/simple;
	bh=QF/x62rH7SNjnTjgAd81eOMlOdFl+Cxw9K9eA8AAHoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbqvvfM0RbvVM2AZqGvA70Nf7VSPX5uoo8VArDqQJzVN3IIUEF36smqlglFs0kJ4aoWvB7Mp96a0OMePVZvH09QBspUuAReovJi2kbVkumPd4wuDqYkA+PsOzYPD3iLLdwoJ0i+6ZoNX6zuZojUOeAWJNvFbDrnIpCjTey5E2pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pohHG9Da; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp4/UJuw6AyowSZuXD2olxUPEZnCL9fmapyJwcW8w0o668g10xArL3YHWk7dQpPaVxIJc67T/10G+Jnnqta4n3n/FKlsQUR+p9ncQIWplmmFkF7nuVX1JKNdW+b0hJlo3QgwPOWvTtHZ/hF8qdOalF6pmvfnJ7qMlVkTuxIqlaM6Pdz/u2zG1JxWBFn/9EK04am6x4tQdZPWPcSJktUF3NnvaYmHVhtVHRJB34hPASKzNnO/kdBlAeH6aolfYpvTfht/89WIvp+RdNtoTLwIl0g+SrXzQB8WgvCDTtWsQz/y3JS8NfvPNgwwI5e9+nVGHgmiDArowgzIjBaKwJLtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdoRrWZJ3GPXjwD9PDit3j86z6d0SP4w98qUWA4stLk=;
 b=ZbagK4Rcf/7UyEpBOguB8eatZhtoSiJ90YILDt6InKziEAMhZjAm0/cvT5sarJ7pvm4M8BlMVt10rALaMBgpw+1GWIL4mZOGXqZQyoz2gveeV9/HJbNEE50HMWPmJGQOho5NqB5C19pGyuWm+yyrll8dzfbjE8UoHNdQalpZly+h83GnJWSNqRqABPrv//sya0HSL+FGTcf2PLrkz7CWtBAJS1ZBxp+c49xcrxYQerDzFXv5xkLG17RKfY8z7FZV08zaRzeN2uwaq290Wr/PVce7OYNam0iKD1JdJfX8PMj68ATVtJOAlG8NupMCb3doO3NcBwgvMmbzDWFgDzryuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdoRrWZJ3GPXjwD9PDit3j86z6d0SP4w98qUWA4stLk=;
 b=pohHG9Da5EcZn5pqDC7WxJ9dLaD5W4pJ/Ym5jBLbV4gEqvNhxtsY/FjLYzeDLX73/79AKUH20NNZCLLrleY4/VKgWtgFKTLFz8yeju7oProoJL3U6WiUhXP3/TAnMHC7zHgLrAnN+fvKzZwITnDyH7lq99hCl87AKMYic6pHpeM=
Received: from AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49) by
 VI1PR02MB6126.eurprd02.prod.outlook.com (2603:10a6:800:182::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 20 Jun
 2025 13:46:20 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::ac) by AM4PR05CA0036.outlook.office365.com
 (2603:10a6:205::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 13:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 13:46:20 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 20 Jun
 2025 15:46:18 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH 3/3] dt-bindings: ethernet-phy: add optional mii-lite-mode flag
Date: Fri, 20 Jun 2025 15:44:30 +0200
Message-ID: <20250620134430.1849344-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620134430.1849344-1-kamilh@axis.com>
References: <20250620134430.1849344-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|VI1PR02MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: dc334f32-b8be-4ad3-f1f8-08ddb000d6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDExMmQwNzZXMi9aU1RIalMrejFlczZXQU1KeVQxZXljYzFoT3BETDIvYXVY?=
 =?utf-8?B?USswQWRMd1JPWWJla0ZaVytnSUxORVdSMThSRTVQblRySUxMZWtkNC9hN1c1?=
 =?utf-8?B?d2N2UVJsL3Zid09XNXFEeXBreDRTRFIwc1NLbEtGa2I3R2NsNWpNay9UQndJ?=
 =?utf-8?B?RDg1L0VCcjg5R1N3a0x4L3hIN0tKeFl0cGk3KzFJZ2h6L3JpWW5BUjdWYUl5?=
 =?utf-8?B?YUw5QUdlSThKZFhKdkh3ZUQzbmV2YnAwTlhxdWRTaTVZN1phRnRvRE1xaUxu?=
 =?utf-8?B?SEJlMEVoWSsySkhZdmsvUDJHREEzTXpUWEgyQU9jZmw2Szc4NDRPRUp0Zng5?=
 =?utf-8?B?ZnR5MGVBL3lSTS8zRzlPbFg5dDNPZXpxNit4OVM3K2lKMHpodDJpWFdjT3Uz?=
 =?utf-8?B?cWR3cEIrSXpXVWQwVEtxYlhuVG15bkVzRGxkVXdmeitJSE9DWUl3R0Rad3Jx?=
 =?utf-8?B?NkhwbXhHN2NqbDlCTGNvSjVSdFk4a2t2YU9vZFl5NVM3MnlJZjlTZk5xU2ZK?=
 =?utf-8?B?Sk0vM0oxdDFTeHM1YWR6NHAzRVhmVmVsUERzOFc1VnRwc1c4S0s3SG8xd0RZ?=
 =?utf-8?B?QVhoOTdPaWRwcmpsQ3JyNFZFanBtZERnQkNkemtjM0IxRnN6L2pMYmRGaVVC?=
 =?utf-8?B?a3pnM0RtM3VTTlBWaXB3cVhEdThwWDAvdTd2d3FPWlRITWVvcGNFYmt6dksy?=
 =?utf-8?B?U013cElraWNoQkZHaHBuZllTYU8xVUpLS1A4RzY4OWEvUHJDR3lJc3VBbHlp?=
 =?utf-8?B?clVid0RSa0ZVMFFRYnJrUXg5K0wyN0hkcXpTU0Fhdyt3OUVkNi9tWGlkMkdO?=
 =?utf-8?B?a3hSS2phWW4zdFJYME9JNFNUejlWdU9yc1JOcFEzckNkM2t5cTRoazI4YVdk?=
 =?utf-8?B?Q3FSbWFqQVI4Ym8xeExZUkRJZjljclc5M3UzUlBSbml1WlJmTTBWMU5UdjRQ?=
 =?utf-8?B?T1ZWSWdQSDY0VVpYM254cUQzcUlJckRBbzRrTW5mTnRUSUZKSmRBblNYSWNr?=
 =?utf-8?B?K2lmQXdrYnEvQVNYSlpCU0R5R2dQQlRJeGFJeTUwNkZXN0xiNGtML0lxVzRJ?=
 =?utf-8?B?T1N0VHQ1VjRxZ2FlSU84d1FwMG1ESmM2SEZLb25FU3dNT01LS09vY0VoOFlT?=
 =?utf-8?B?UnM5SkhWVE12TUhhY09IcEE0enNpU2tUZ2Z6L20xQldGRXh5TFhLZjE1Q2tQ?=
 =?utf-8?B?cHdvZy9NNFJsSkNmUkhHOTVKdzQyeUg5YnBESlpqUkYxa3d0RDM3U1k5ZTJE?=
 =?utf-8?B?OWpmWmpYTy85bHlRT3FEa21ydEF0b25JMUFsWWsvMm14VVBTZW9aN2JxWXpD?=
 =?utf-8?B?VEk2eVpSUzNYOFZOS1F3cmFsWEp1Sno3dERZcER2S09iM0ZVZkZNdGM5YWNx?=
 =?utf-8?B?UDFKMGNuME5ScWd2MWtjRXNBQXdrRW5lcHYxVDM2bUdZME1KYXNKcEtOL2ty?=
 =?utf-8?B?bXM2RFJiWEd5QVhoVFJ5RlhRdmtmOGtYazJXbW1aUnFKMTNtWE9iTmZic1N1?=
 =?utf-8?B?T1o2eExiUFRCUlNIcjBwYWxQSU1kOEdxa0gzVnBOVWM4Q2xwSkRKTlJTRVFs?=
 =?utf-8?B?L2xtQkRBNVFVRG02QnpPK2pKK0ZVdGJzK25ZR0UvUTBuWlAzekxUWHNNYk9y?=
 =?utf-8?B?Z2grMHJrTjFLM1BLT0VSS2dUUnVVL09XRnVTdmVFTENOd2NzWmRhazNJbmRF?=
 =?utf-8?B?SUtXcXd0aElGZ1hwNWdXNmNZQWsxelhxVHFYVG5TdDNwd3hZV3crVEFQWDhY?=
 =?utf-8?B?OHBFUC9reVNIV09WNXlYL1lybWtaamRHNEoydisraUdKSDJLSUM4Tnd5N1Vl?=
 =?utf-8?B?WVE1QzVUY0pZazN6akxFd1ljUDlpK0FrZ1piNERONk5rVWg0eWRaNDl0aTVK?=
 =?utf-8?B?S0o0dmRiakhVZWMvcEViUDlBZXBaa25Ea0puOFFYZUx4R1h4RFBpRWUyOEZ6?=
 =?utf-8?B?NG5FazB2NFZBRi9JR0Jlb013eFpYMW5qNUNkUGdCVXVYaFh0UlZKdUxqa2hW?=
 =?utf-8?B?dmFPNHFaMnlaV0RFOWFxS1VEb0JHSXE4UG9tNTBuZkhjM3BNZkJweXZJSXpL?=
 =?utf-8?B?TTMxY0pzMzR5VjFDakMyQzlLRjR0ejRJeDFLUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:46:20.4267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc334f32-b8be-4ad3-f1f8-08ddb000d6ad
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6126

The Broadcom bcm54810 and bcm54811 PHYs support MII and MII-Lite
interface modes. The MII-Lite mode does not use TXR, RXER, CRS and COL
signals. However, the hardware strapping only selects MII mode,
distinction between MII and MII-Lite must be done by software.

Add optional mii-lite-mode flag to switch the PHY to MII-Lite mode.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 71e2cd32580f..edfd16044770 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -101,6 +101,14 @@ properties:
       1BR-10 names. The PHY must be configured to operate in BroadR-Reach mode
       by software.
 
+  mii-lite-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If set, indicates the use of MII-Lite variant of MII, without the
+      functions of TXER, RXER, CRS and COL signals for Broadcom PHYs. These
+      PHYs can be strapped to use MII mode but the MII or MII-Lite selection
+      must be done by software.
+
   clocks:
     maxItems: 1
     description:
-- 
2.39.5


