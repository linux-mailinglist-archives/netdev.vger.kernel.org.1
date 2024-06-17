Return-Path: <netdev+bounces-104003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66090AD2A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49781F24556
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940B194C8A;
	Mon, 17 Jun 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hX9f4VL9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A071940A2;
	Mon, 17 Jun 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624472; cv=fail; b=ijKVtJ2YoNSJ6/unlsFjJUUVMrtWX0khQ1+0orITuusnndpP9bjdMgaOYeRhnwm5Lg0hV81aAqIrB/T4rJLSRumblDJPnPtKvd4e+3ytzO2ZRo65+iHQoPYLg+0z+CLTIInWoXXOecNV0LZ83zX9ao+VSoqh9NEoa855zBS6Elk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624472; c=relaxed/simple;
	bh=cwMzZ2m1dn0C9rY/2h0EsG+79CnYazYIlygrMQT/FSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk9goC7ZAEmCMwIPlbL7Ozo2Ekh531YvsqOQhXxYH9MiGQyMeLWWJknsa0DRxMfbcykmoqJE7NwjaxopQoKVcERmd6qCTM+TcKf2ZECoQ6NE1E0GZpyFxTd5Qd6CEsE0wYiDiuB6zx4EbCc/AabKwz31J9SzytkNPstMb9NE9dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hX9f4VL9; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCPT9/gm3DYxajRSX2Z/y22it9STEQNTlTOGjDPhelTy8JPCgE7VEegvwe6gJnPRx/3Cmlsjc0xyRQ9F8ukj+ab878VyIVuiv92v9/ejZE6xQqoFXgkUHy3LTMoMoz4V+oW9JUyGe1XACXeC1ekReTxNjJdLXHuHXhpOfqCMZhfnQJbwgp/QnOns/yGGkxw86j9A+YF5uMXDjYLXGkfiCMAuFnin0aFSH5TjbPbrVXHWR/1ieSDRfl9MlHFcixZi7FOQPNlRFIXzsc7kELpbxG2jJjOt8uMoEgSavWKZ623at0UrGQ/VYUzF8Lr3waSAhWuYym76tZVdNd+oOD0UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=L+6XXPTQdhi1GHM0aLbgHJ1HZsF5sdhBpqsXZHErtQPX8FEBU/wLq0MWLgDPLXmIsiEsalFbDs1NWqMWsieYIK0nHk6n0JDdDproDdnSu0QdxOz3t3elxZioBemb9bB4Dqqd/f7R+MgGgzJZGjAl2BZW0yxY/hNk+dCPn1nQQX8EC1R6e1lUlMZgr89xtes5ua4qsJKUWKvTPrYBEHaKxHqHY8CSO3pxjPKizq7NA7JVt1J8biBbMMxrHAsCSS8vLX4GYlTGXYRoZz4sMG29OnQvMEd6jc5l7roaEKjphGTVLOKajAoCdqRVuDrId48mmWq5K8rpaxp3/SC3xK1+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=hX9f4VL9JemNWoFc//G+ObylGEd9lDSy10/wR/u0iKIHUUNC9FIwB5X7dvKpgY2viS8BEL/pomHJVDvFe4OcqAqXlnRMWi9OUDWSf7iTol6ibB7mIPw5qLaLNd95p1cKhq501vFuqljwDic3t9vS1RuoNIJrxHCDEWXufJbmbZs=
Received: from AS9PR06CA0349.eurprd06.prod.outlook.com (2603:10a6:20b:466::24)
 by AM9PR02MB6738.eurprd02.prod.outlook.com (2603:10a6:20b:2c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 11:41:07 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::68) by AS9PR06CA0349.outlook.office365.com
 (2603:10a6:20b:466::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 11:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 11:41:07 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 13:41:06 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Mon, 17 Jun 2024 13:38:40 +0200
Message-ID: <20240617113841.3694934-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617113841.3694934-1-kamilh@axis.com>
References: <20240617113841.3694934-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|AM9PR02MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: d50aa0b8-621e-41dc-2f74-08dc8ec26098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0VhcTRIS3dvTGcrVWxhbU1xYkVwVE95SG92ZEt4SFpGQTROTkJydDRybDMy?=
 =?utf-8?B?Y1hEM1JqMzIxTWhsYnpTNzB5c3hUbzhrZ3V6UFZiT2trcWM3M3gzMnNqSG1l?=
 =?utf-8?B?TEQ3KzJxQTgvOWF1WDgyUm1iS1g2YVducnUzdVJoclNPSWhCd3F4SVZ3YSs2?=
 =?utf-8?B?VHloNVE1Y2c2QWdCRWpSYmt1NEc0dTBLaXVFVDBZVTNxU2JYYTkzakh0enZN?=
 =?utf-8?B?WE9KNUFQZ21WWERtMlh3Um1xSGpSMWJ2NnROYWlvS2ZaVDhQdEJwNEV1cHJO?=
 =?utf-8?B?cVh1QUlTNlVZcDlSUVRXeU5Nd3E1RTFmL0hFNjU1UUFJRGpwa1JlRFVOOHVh?=
 =?utf-8?B?Rk9JT1dKMC90dXJUM3VmR3ZIZ1FTR0dhbU5WSDF0ajdzcVhobnByVW90YTBD?=
 =?utf-8?B?TzVGb2hiV01UUUxnYWFuTm1qNi9OMXVtMjBtYkNSVm1lbFYxUlptUG01SW1j?=
 =?utf-8?B?VllNVnloVzE4cVpwWXZYaUlvMXNaVlNMeVFNemljZ2VmVGQ4ZTl4N2sxTkR2?=
 =?utf-8?B?dUlmMmhLOFpSbXV4K3FrbDEvT3QybHlaczVwbFdrdkozMm9KUkVTTU8wdVB0?=
 =?utf-8?B?WjNCb0NMaElwZEEySThKbmdrZWFkZmNXYStIK0hvQ210YkpYN2FTWXZPbXNt?=
 =?utf-8?B?aU5LdUFxMnNHQ3YyQnlheFEyS1BhbzM0MlIrTS9TZXZ6SDNsWFpPdFE0K0FQ?=
 =?utf-8?B?c1g4M1BvWUtSeWxZTW5XUlRmTi9WUCtPaXRiVW03U0d6V0F3ckU1NzRpZ2pp?=
 =?utf-8?B?U1E3eGFUVFREK2t2cmgrMUR6ejYzS3duZ2lmWmpnZktkMm5TbjBYYUt2K00v?=
 =?utf-8?B?dUViVFp5WEsvc0oyUkdYaS95a1pSUENMSmxtZWIzVGNQckFyb0hFNVIzT1Z3?=
 =?utf-8?B?dUsva1hpQjZoRmo0Z1RCYk01bHU5SE1VWURQSlR0RnhYWElERHAvTEkyYVVo?=
 =?utf-8?B?R3dXWFdQMHZ6U0lTUm55UkVhY3F2QTRvUmRGVWkxUnZBS2o0aTZqZFRRM1dj?=
 =?utf-8?B?YTZZL2o5SlN1eHNKRkRNOVN6UkFVN3pJQ3B0ZXR4NDFEa0FWV1UrUWpQMFVZ?=
 =?utf-8?B?WStYV0tYckI2VmRoUmJSdXNmbDVmMlhiTGFhS0ZIeEFZOGpWTExCRUhYUVhh?=
 =?utf-8?B?V0FwNGpVcDZPbGNzbEppMVR0OVNLSG1VMVRoMGJtdlZpTm9IbHBiNVorcWE4?=
 =?utf-8?B?WGtocjZ0Umt6MVFPcEE5U09jbFp0MGMwQUN1c2Ftdkh4cnlqZ0RVY1F0OEND?=
 =?utf-8?B?aDFvYkE4aWgwelM5SlYxamUyVXE2MHdvUW5QQlUxVUdWVFBoYzErdU9QSlRE?=
 =?utf-8?B?Wi9vN0lYOE93OHIzbzE4d3dSS2JwS05vVzlYWWlaRlg5SHJOa05ET1RQTzky?=
 =?utf-8?B?V1RDTEVTM3hxODd5eHVmRHI1bXlkZ3VIdnJ6bGRwZjIxZmpyb0ZRcnVIZ1B2?=
 =?utf-8?B?ZWIwUDlQeE9OT0tGY3ZqcmQySkJ6M0UwSlhhdHhtZmtrYWUzZlJnbWVFd1FW?=
 =?utf-8?B?QjcrNDE2WWVRT2xCWmNNcUVJOGRNaUc3ZHlUbmNXeDRwM2FxL0l6aTB2NWVI?=
 =?utf-8?B?THh2SDdWNGE5YWtaTTkxNmREWC9JTUVuS3N3K0dWSnovNGRReG54TmRoQ0dI?=
 =?utf-8?B?bExWaVFmWGJJVWRyZllPVVNZUzFGTzhyV1lwSjlBZ0VUOWdET01rV2xudE9m?=
 =?utf-8?B?VzRCc0ozNEFkNW9hc2IwOGlwcVlHUzE3QTRpMWZDTXNWeDh1ZWtRWGFwTW9P?=
 =?utf-8?B?Z3ZQL3YvR3NEVUd5T2lYQmRLeHE5U0Z2eTRYN0FhVTBoTFVidk5FTzh2OXRa?=
 =?utf-8?B?UTVYK2d6UVhQekthRVVTT3R3cUdVUXpNTlc4dEN2T2JZZGdJSHlWcDZyVE5w?=
 =?utf-8?B?eWdteGpuTEVEbmwvZXY0NVR3cStYL2hkZDNlWUhjaTgwSHlZK2VJSlZ1UHhz?=
 =?utf-8?Q?Y2sftvAKmkE=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:41:07.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50aa0b8-621e-41dc-2f74-08dc8ec26098
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6738

There is a group of PHY chips supporting BroadR-Reach link modes in
a manner allowing for more or less identical register usage as standard
Clause 22 PHY.
These chips support standard Ethernet link modes as well, however, the
circuitry is mutually exclusive and cannot be auto-detected.
The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
(1BR-10 in Broadcom documents).

Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
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


