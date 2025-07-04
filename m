Return-Path: <netdev+bounces-204067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C2AF8C77
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083D0B61BFA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EF28C010;
	Fri,  4 Jul 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="k2P2jpsC"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406B28B419;
	Fri,  4 Jul 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618141; cv=fail; b=iXCAu0FuCOcRrjJxGpP/FBpxEHw1gqinzvvmFnXj3OtfuqsA+MO7eLF+5NKcYTMG1CtA5OSEkFQZmiX/nob/BkBb6P+jF3tSuzJS9xp8OyHRwT4qvb1foek2Uk0WgIh/cSazy5KNJhbN3Nycwsp8LK8TAErWMdI4R+qFTaqAU1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618141; c=relaxed/simple;
	bh=y68XLclY57vukmDjI0wPswgmz56iKl3lHEmuvh4MqHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7y/uDQGHns5U4d/cDRczIHpmt5kFexFMRIzvj6qCsrGgQ5x8FoZKdDelYyQ9zgeeux2F9hjjmRx+OYwyntGJvd6taueTS9pFBwU1hUcoFiekld5yLvRO8mhRSRAIN6o5hXkRBbC/bc8PmiG7LtDBtSCeAkftAabPpd6JuJgKuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=k2P2jpsC; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdH2sVzJZheaLmacu/R4ushjM0mSgmrxH8dp0mBzh8h0eZt8vG3N1RQcfOsvub3QigjIM4Ue/OoaKutRwuyzhb/ny7aitYEW5sUPQxwJSR1UC+qbrgUV9z5JzxEI3I/KqREBtpxU4c6CP6FletSHlUFEw3oEE8QfHiMb/1a1oR+dP7FPtivOtDyr7m5pnvUgJij6VkOz5cY6lZej7D+KwH2lI/lXkh2gU7dDRvbXvPCv4wi3gU48g868xdQc+1WEoBzy2g6TiJHXi4q8t/h+yiKshC1QZ7+LGVipaXcvq3CZScsBv1D8VMiB8dsyaVDJzS0m9rs7NzSJB/dwVUJ+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=qasfsYNC2j15AFPNSACB1GVSLH+5fJwIdeLSw5FR/rdVn2YLzcx/Ql6UXNM9OJHNdwjwmtjLsCpEr7a3UoLshCer0AndCE02kIhYJDP6rj+aLymGs6BgABGnazptaTLo5dh9daschwaaERzSUSrnvqNcDjgtdHzRNb1WtE+SsADUM95/P8O1HEOhoEIsVSbbNAQsXLGPkI3Q1IhJr7yRtRpMDGWge5A0bphsrJQNIv0B65Lj1FZ1yOBD5OwC1j6JGNNTBGgefbQSueXMCpSHRgHzWzlyc36OqyZtFCd/3dvIM1Eu1bYHLvIyJ6rh3bH5K4t2rt4AUhe8VhNU0s+/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLTe4whWT4q7CGpR5VqFknx4DTOHOJxShD//P9jJf9s=;
 b=k2P2jpsCLqiwEtdU+WdNJT0J1xOgao6dQOf6UL4/Ww9Cbj8dFMrxW6WZJf8a0ukrkR7cNECIWGMX5hIBLRDoDUNUXmf8j7CCiFJDoPxRjI1Qlbs6AN8T6ej4yWTXq7/pn/EiNnJ8Bm1wJveI6cxCh23U06LrDqvSx7ghY4Ri5Hk=
Received: from DU2PR04CA0244.eurprd04.prod.outlook.com (2603:10a6:10:28e::9)
 by DBBPR02MB10914.eurprd02.prod.outlook.com (2603:10a6:10:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 08:35:34 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::5d) by DU2PR04CA0244.outlook.office365.com
 (2603:10a6:10:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:35:34 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 10:35:32 +0200
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
Subject: [PATCH net v6 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Fri, 4 Jul 2025 10:35:10 +0200
Message-ID: <20250704083512.853748-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704083512.853748-1-kamilh@axis.com>
References: <20250704083512.853748-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|DBBPR02MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: b91ec9a6-9f91-4648-7927-08ddbad5beb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|19092799006|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3VxQ0pwNG4xcW45NmxCMmVEWDJabFFCd05qQVBXMndCT0xFcWhscWlqTUk3?=
 =?utf-8?B?YThGSnFPOHhheEVaOTZKaE1RbG9KQzNKYWZWOVdhR3BXczRPT0hxNVlac2h6?=
 =?utf-8?B?MFRPUnRPM0lPSTVTR2tNMytLdkp6OWpXSTlZSGpPTmpjU3RIandjUGpqWmRy?=
 =?utf-8?B?Q294UUVhU0hzWFFXVnZjTWVzZmdEUkRsSU5CdStsSzFoc3lLU2thbCsxbGFJ?=
 =?utf-8?B?djFsbE9uazNDRkYrWmhrNmZWUTdVWTVpWTBOV0FMWWxBL2hNbVd2WmNsRm94?=
 =?utf-8?B?MFFkNzZJMnJ0L01ENTNsSkhGa3lWQzV0YzJvSmV4VFV0VW9ZV1kwOEVIWHlj?=
 =?utf-8?B?T29OalREREN4all4bHBpYkNPRFVpR0hlQVlLaHAraUZDcUVYelZHTUZ1Vm5G?=
 =?utf-8?B?amVDWWc1ellvdlkrSWVCWWlyTDBUS2xZS1F2Zzh3UGJOc3dMUEpkaWpGOEZV?=
 =?utf-8?B?dWVtVHNxYmt2amdiRWx0MVRnK3JicTBIaFU5ZEo4Q3J0aUorcUdUY1JUWTJv?=
 =?utf-8?B?MUxqRm80MzZLODlOTUhvYnVVYnRhbTJ4a2x0dC9vT2N1TW9GbWp4YWNHaitF?=
 =?utf-8?B?VVQrZ2xuK0I0MEYzQ09jZlgvQ2Y3Y1M4dVA5SFNseTZqRVZIeDBQbnJIYU93?=
 =?utf-8?B?L1dDLzFWa1FONkhxZGZhZkxNMzBMcGRacUs4dm1uYkZ2WitSc0tFcUEyU3I5?=
 =?utf-8?B?a1RGSHhUQlNrdXluSDIxMERCSnpXWE1SQ0dLb1B4ZElxUmFwU0Rnb3c0Nk9z?=
 =?utf-8?B?SUgrcGlHSXhhV2JxbGV1NVVvd0NoMytCNTEvcmxEK2txTFl2NnMyN1cvVlNm?=
 =?utf-8?B?VDNSMmRBazRqK1V6WmJ0TFhreDM1NnBBZXVQYnl3MWhqOFhIUnFRejZQeWlU?=
 =?utf-8?B?M0c0bDcvSlhYY0kwemRnclJXL0hTUXQxdHVVY1FiaUlDZTBCMGlrUHVUeHpi?=
 =?utf-8?B?d1VzRFpyVlRwTDNvSkhEL3crdE5UaDdraDZRaVp0dEh5WkVGY1pFWjJWRkty?=
 =?utf-8?B?VnRDUDlXbFlhbDFBcVhMUEN0eVBRSnR0Yk9Mamltd1ZJYmdWaTZqMW1kTXJj?=
 =?utf-8?B?Z05pU2R3SzFNcmkrakFWclpXRXlpUlNpWjl5MW93NE1DNC8vRmtXOUZaUE5R?=
 =?utf-8?B?anpFcUdZNndyQnJVVGI3RVFYUjBUdFZiOG8wYW1JTnVsMmRlS1BuRGNsRHky?=
 =?utf-8?B?YlFKbk9vR3VLcVhYdmhCVUUxaEZ0RWhxNXl2dTlob0pzc3U2Zk1qNWd6U2hj?=
 =?utf-8?B?OVFBd1huSVJBY1UwRmx0Z213akxHcUR6SnQxNHM1Wm9iaFBxVGE0VzcrSERu?=
 =?utf-8?B?a2Rjek5mYVphdGhkOWFkTFlpUXRzNEFZVFl2RVRJeTFkSmdmdDZWbSt6VG9H?=
 =?utf-8?B?ZDBxUUxhQU5sQ3pXR0w5d1NmUnc3dWlnNStFaSt1cTFsUmNKY29OV01qanpk?=
 =?utf-8?B?UW1VWXpKaUgzOXh1Z0hNZEdNamxpbzhZWE9xRk5ib0FBcm1VUVBERkpWbndU?=
 =?utf-8?B?U2xLOEh0SFpjT3pNak9HZERFYkJ6WXhCWGt2N0xPL05kOEJteWhQT1RoTEJz?=
 =?utf-8?B?WkRPZzVkRzFVVU5Wd2lVUjBpTytMZDhxNlB0VUk0S3FGMzB2QnZ4Tmh1L1hB?=
 =?utf-8?B?Tk9SWnlVQmNER0w5TUVJSDc2elZGaE9ISWE2cnlXcDJ5amFDaDRsY0hjdEd0?=
 =?utf-8?B?UWRBNnhEcEd5YkIyTUxrVmVOV21WSjZrNGlpUXZSTUoyR2ZjTkNIVUMrOXk1?=
 =?utf-8?B?YU5Nb2xTOGxtMnVJemFKd2JiTGpDaFMzRnl3T1Q2MWRubFhRNVNXdnZrOXlH?=
 =?utf-8?B?bXJxN2d4YzZEdTdJSFhiWHBlTUJ3YWtyV0d1Z3NCbzUwOElyM1NWQkNHV0dF?=
 =?utf-8?B?S1VlbzFBMjIrVktwamZ0WlFsUS9jbk1LaFQxV2NXdmp4RUtta1JoUml6ZG12?=
 =?utf-8?B?M2QyRUU5VzA5ZStQc3pWYm5UbmdwSHRBaHpMUDc5TnozR3pBakRvRTdZK01i?=
 =?utf-8?B?Q2ZCYUR3S0pMZ2FyTXJld3FZc1RSYlphY3lkamxld1Q1ZUpoREhoc3IzN29z?=
 =?utf-8?B?UXhCSFdIY0h3RWNMeWxpclEzeGRQQ3lhTjNHZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(19092799006)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:34.6366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91ec9a6-9f91-4648-7927-08ddbad5beb6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10914

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


