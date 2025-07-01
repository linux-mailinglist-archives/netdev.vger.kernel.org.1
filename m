Return-Path: <netdev+bounces-202785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F400AAEF011
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A6D17E44D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C31260592;
	Tue,  1 Jul 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FcvsNc2E"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1A25D1E6;
	Tue,  1 Jul 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356238; cv=fail; b=lnYMWCE39wN8JD17lhgZLi8t8kGA/Pt6flBuDpREVTifvcgfDNvLfnCFHgZvsuFzwLQZHaFbrNS7Rn8ptuAYMr1cYPz6DP8FgjXadxE+GOEwhAeNCLD2mF4rYfKy/NJ45Irht0ne+94KJvD45B9BIGSqG3mRRlQWTfjTjimK7fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356238; c=relaxed/simple;
	bh=y68XLclY57vukmDjI0wPswgmz56iKl3lHEmuvh4MqHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHdNUgenN10scMETQ8bllla8GOmGaGQJPWaa0L4+8CPhmPv2vVbC+Cr+16jvisP53O5NA2SiROVCygXblMVI5kaihWoOJUq/0aV1sE5MM1keomt4YJuk5dGkBfjgg+HPouNm4Lfp0KUS4k28kH4sDV3L3uDHxjRLkLxXZV/aFNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FcvsNc2E; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGVMuof6OgOmfASpQylm5PuoD5rlDwmvQYVxlHO/IoYrHhyjGGX75L3LCMPYDEcf6IJ9stxbcdDkXWZ1jJXj0wwjAE5pIsJFoxZAt/3xajBaThqxn60o0R0veTd8gpnCm1nTdwElERyA6biP/s4hh6exqEquBIkanF4kcJUd9MuDWNuxCToAZ095JERcpgU5EwttwmkY5XBkIqpPQCI88qOjXfEEhF9PESHY6gnQu5lNyL76LtDcIX3sG9unQdOTjvP+QXSYrXn5UZ+h5eqPuUauy44GsFMHzfGChYkQxDtzqzA01MCoj/5/g+ZO9drPD4JzDltQPwRuqWOQMUTDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=H3TV6VRAVquGFAAe4Vl9WN2eTjxOHUQ3gp4RgNnhU8lkC2j6XC5VD8VEcU7n60ipFABmdlTjriAwVlOsX4MqPQVQRMBIgRyBHydrhlouj+FDOJ5Yose2TwkQ7r+rKMaYF6Te8pMVPilT0sT+3puka4b9tHyi8cW2enNFbBNrQp+Bqy0+ibSfgniGa6uKGygb9QawAoxoWyXFS2NlO5G7aHyydsf2+X6vHKwunonlcFnwNHQaVvff2vK8yz6AUE1iUcBFVDv3vQKADtcoWZPOLn0pccXceL2ywVnYfdrW32IP/m2WTk4+MuHg23loGtb3HMc9NaVXW7MMKoIxK3geoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=FcvsNc2EpC9jLfwEYKHD58VjZsXgtUgGr+TKGBx/2b3QZk7DVz7dV4uTK+OsRduC3KiT8SNO4eyIh1Ietg2vYm6qa2cn4xg3g+N+iD4nPYKv6BrCr1JsNHUvx3h8SotYsXNdK0dmmnTPaI+aXzAzp0e0I3WlmDG7dWbS4Mln2Go=
Received: from AM4PR07CA0032.eurprd07.prod.outlook.com (2603:10a6:205:1::45)
 by DB9PR02MB6795.eurprd02.prod.outlook.com (2603:10a6:10:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Tue, 1 Jul
 2025 07:50:33 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::6d) by AM4PR07CA0032.outlook.office365.com
 (2603:10a6:205:1::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Tue,
 1 Jul 2025 07:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 07:50:32 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Jul
 2025 09:50:31 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net v5 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Tue, 1 Jul 2025 09:50:13 +0200
Message-ID: <20250701075015.2601518-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701075015.2601518-1-kamilh@axis.com>
References: <20250701075015.2601518-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|DB9PR02MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1ad980-2db2-4fce-3d43-08ddb873f49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|19092799006|376014|7416014|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnlJTVY1YUsyWmovVDJKYkVWdkwzN3BTZUFyYVNvM09GVVdkaFFXWUp2UllN?=
 =?utf-8?B?clZtbHFVSkUwbno4QXFIRGE1NDUvVzF2RU1PNGdNWWozMUhURUE3MGJocWFq?=
 =?utf-8?B?amd5eTJxZG5hRzBIMEZNc1hZSWdEZXdkS3FKd2RoYjRZRStmU2l1V2hpcW5Z?=
 =?utf-8?B?Nnp1SHJKdlB6THIxaGprTUlTejMrOExaNXpsNlR3MmozT0Y1cUlPNzhLTC91?=
 =?utf-8?B?Nk9qQVhiTktucmxpVHhhSGtHaXRUYXU1NVFWblJWQklUR2E2Vkh2Tnl5WXpN?=
 =?utf-8?B?RFpBV0NScDB4cC9lYlhrQkFCcHhiUUVaUFRqWnhKc0hibkh6MVVTbFE5YzlN?=
 =?utf-8?B?Vmd0aFBpMlBjM1FpSEpGVU5nVHRTV0kzbzVkcFU3ZmptMUNzamQ4UUhraHV0?=
 =?utf-8?B?VWFHL3lzRWthRmd2ajAzSmsrMHVLQncvOExsTS9YQ0pTeG5tZWdHRUloRG9j?=
 =?utf-8?B?NzlRU1hEbEYwMmZLNlltR3lWZ1FHTTIxVytsQWNGZHhMYXMyTFI0dFFybjhi?=
 =?utf-8?B?ckZYV3BWUm83c0RkdmNIQ3hBVmVya0ZGWVRwMEhWaStyb29MMy92d3krVVRt?=
 =?utf-8?B?cGNxSnVkeWpES3FGeUJ6SnNSbTU2akdDSUZjay9zN3J3TDJEQlQvWHhPaXVZ?=
 =?utf-8?B?elVrd1NJc2lqZkdycWFZdTVTVFB4WTdIMVl2eW9ZQ0l2bEo1NEJmbDJUNHJ5?=
 =?utf-8?B?ZHhHekJWMUFvOGpVV1BBMVg5Sy9MaUF2a0IrWjBadnBXZWN0eEE5V1JpYzY4?=
 =?utf-8?B?L0UyRjR6VjZmKzlTOEdVcm5NSkJhYTNpWDIxUVZzejRIVGRPc0lsak00YlVU?=
 =?utf-8?B?YVBMdUFxU3VCbnNRMC9XSU42THNoNDlJR0MxLytmWktqUGsraUR4MHpEbEhu?=
 =?utf-8?B?QU82cWlvZHF6MzNBTlZrM0Q3amZQdmI0dnJBNmJsNnpiMVBQOU94aHlSL0d2?=
 =?utf-8?B?NUNVUXV3aEhFUUlGSVhaaXJDQ1FlZHBwQjNDeDBxUmgzbVpoK0x5OHprcDlC?=
 =?utf-8?B?dFN5M0g5VGQvVTdXazR4WVpua09XL1F5SkQ0MCtLY292UXpIbVJvM0hORHVk?=
 =?utf-8?B?bjQ5empCZ0F2WDcrNjg4TVpTUEtEa21ucEJHbmMyM1Y4ZzNJcTJNWm1qVVdF?=
 =?utf-8?B?ZzQ2ZXBkbkxpeitGdmc5M3BHakxvSVFaYTdYYmRjbG54Mml0eXhsem5JbXNZ?=
 =?utf-8?B?azRCd2NzbTVQajRoMzl5bDRWWlpuODduUnVTUjdUWURUbDJ0akpleHU3SWR6?=
 =?utf-8?B?bjNNdWNGdXNWNUhNVzZWcnF1aWhoYXBJR2luajZsZGFUZjhTSnhWZjRkNnhn?=
 =?utf-8?B?bXM3Y29HNW8zMllkTnJGdjg5VVBKbUUwTEVsd3JWUUJVRjNnejg2ZlcvMGtW?=
 =?utf-8?B?d3dKOW42N0xYcDRCdE45NGlOemNYRUtHSWUvK0RHdWVteG9EMno3SjVuWFZk?=
 =?utf-8?B?NlRUZ2tJck1RZ1dkM2hSeWh2NU5KeFl4OVJqNnRocmxCWUljY3cyQW03enRq?=
 =?utf-8?B?cDIyWTlVNktKQjIzVDhzanVmUjBoakordEw1cXg5TWdTRHRxNkw3eGNBdFhM?=
 =?utf-8?B?aUJydC9Jc3pSSXNJdzRydS9DYnBaSUtKZ2d3Ti91YTZPUnlBVG44TUJLcHM4?=
 =?utf-8?B?b0xEdkFiaWdNR1BCZ3BaeVJ3RUJ3TENaSUJDMkV6cldJNm1WZ2d6WmlhYW1H?=
 =?utf-8?B?R0N6RHMyM2Z4UUZ5SVp1Q1pBMUpPZytXYlp5NHd1SlozVDBacFVUZU8yb2k2?=
 =?utf-8?B?Y3hPcDVXSEg2Qm0zYVM0ODN4cE42blIxaitnWHZ1Y3kvYVlLWHBKTHNqT0xZ?=
 =?utf-8?B?cTNsamZ5MHVIbmQ3bGZJRjlPTFhFclBGS2Zhek8xRnVuUlozZE85KzJIOVlz?=
 =?utf-8?B?dFY1WWt3OHF1d2Fxb3BoZUFaZlJ2NnVFbkhQS3IzelJPNXZlSnBYSmhlQllq?=
 =?utf-8?B?TGdtbUE4dEVtSlZ1dkk3N1lYVlY4RUt1d0k2b3lhS090ME5Ecm9nUnNkSENQ?=
 =?utf-8?B?Q3pIUkVjQ1pLMHo3dTIzSHdHUDRzQ05LKzRkM1RwTm5mZmI3cFhNM3lqeEJX?=
 =?utf-8?B?N0NydG9lbUg0ZjVWMzBYRXA5a3IrVGxobS9lQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(19092799006)(376014)(7416014)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:50:32.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1ad980-2db2-4fce-3d43-08ddb873f49e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6795

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..66b1cfbbfe22 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -39,6 +39,7 @@ properties:
       # MAC.
       - internal
       - mii
+      - mii-lite
       - gmii
       - sgmii
       - psgmii
-- 
2.39.5


