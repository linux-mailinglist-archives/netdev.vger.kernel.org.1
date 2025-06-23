Return-Path: <netdev+bounces-200317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE4EAE4825
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77201B61053
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13A275B08;
	Mon, 23 Jun 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="i1YVx2ZD"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591522FDEA;
	Mon, 23 Jun 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691499; cv=fail; b=uMT+TsdO4onPFG1m1t0X3D0wP1dN437kLpQuXHaZzxf2rjBF04pVvFdSMzmWv5kLX40XcMad1SzAzjNX0y6+W6IarMAPEu94zvGoyWAhTQs56NI2oWOq5/eXkbLZPPfoG9b9tvQndma7lgwM+BUeWr9xVa3YOqtWpj/aHyhn+6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691499; c=relaxed/simple;
	bh=4ZOhhVGcrbSe6bHoYyEXRX226fWXmb7jGhrfhktxVYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VgJQ6gRx7CmjxpZHrrAlc2D4cIALJMVJ/PYEebLHZajjdQ6d05tE9c2O5Fgsb/brE/A0hLGZGiALE2bIgKChAy8Tx0JaJQVkm0Xqusm2p52eXt7LjZBszFIwH76td8bBQE5Z6HZTy+PyAmARJM1U7WcrhTDDhGf/+vqoV3ETgIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=i1YVx2ZD; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPxfXedFaCDSZWz1xghL+ywP8Snks2xj8cwE5tcQ8Vlhft8tyzcuZ+BsuDGYxJpOAr68ujXXNSdFJ4FYXbD9K23psahoCgUI0L/24HvBjOwXmOyQRrCW3Y1+T7tO6hSqI0jbcExq3fY5fxz7p2csngzvsuwGfOGqraNRfYH+xiMSTCb+my6QxboiIngB8GQPbr5WHPpn2dQimxPLRMqc4n9lWCnDlS7+9gjMGXxzANC+kexDRg9BNJ5ZdWgPvCWdBJg421s35MDgx0YhJ/tuonfGITfMQdkGIz424P69n45YKlLLRT46zBv4ZUGicyC5gUabIXAzkr94FQPwcLPWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er97gxQgCDDsV014MUsttrrofchyRjbMfbAuYrAmrX4=;
 b=vNmHlA+7YDzr7KZXJ+/nE7zf6qBm1hK5sUt8JAzR33a9tX+hYRzb7DvXJV32IPllcfHzHwaw6ZCizEGiZihF3mgH+1l/gTyiFEgG1ZbiPOI0IBf8wr074c9hsImgEJS4mm70JeigxxBMevGF1qCxvTdl3ImrYYw4Vh5V0C+NL9HBmIIXuMxRWpBKW4lZuCTdV920XPtGMfxITH3RvAApYKgS4eXLl6BYBjHsrrgwSmxarU45c5qLI+No3m/7wztIWVDb/t7eYD4JGEHj8Z4EZFW1HXHO3VF3wKLfNEMdUnOkeqnZAAYUElsbSQlZ1flFTOdrkXxHXLPpSrCDPx8w/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er97gxQgCDDsV014MUsttrrofchyRjbMfbAuYrAmrX4=;
 b=i1YVx2ZDa/q/Ce/QRHT17Lp0C4m+n0UrxwcAe7pwWBgfM0vQRMHzlKNxUI4HBIf64yCv6N6qHstHuqdqr/KPQVNpe+sOOkjOJ9dpg2dYI9bPQgVmd2GZRK0uxE2HzpzEs37gtI2guysrhTfmMY+tlTUF2TzCjLQ97hLBb3S40rk=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by AS8PR02MB8495.eurprd02.prod.outlook.com
 (2603:10a6:20b:570::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:11:32 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::15) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 15:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 15:11:32 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 23 Jun
 2025 17:11:31 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH net-next v2 0/3] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 23 Jun 2025 17:10:45 +0200
Message-ID: <20250623151048.2391730-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|AS8PR02MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: ad59a45c-5910-4898-fe4d-08ddb2683ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjdheUhibVI3V0dwQkFjcnhxVzd1alJoVDdRbEoraldpT3NycUp0YS9kMkta?=
 =?utf-8?B?eWlDb1pHc0NFNld5Y0VrMnlFbGZDUkt2WnBLd2dZWVhHSGprZ24xeWc2S2xH?=
 =?utf-8?B?R1VTdVVocDVFV000V3VqL29Bd3pKTWw1cEUvZStKWWZsbVNnY2p1elVrWEdr?=
 =?utf-8?B?c0l4ZEdiRjZHaDJLMTZRTjNXR2hHUGxYdFMzeXYyS3h6R2FLYXVHOXF1T0t6?=
 =?utf-8?B?MnhCS3FTaU5HOFMyRnlYMVNUU0dlTStReVlZOHFxOGdPR0VGOU0rZENEMjZq?=
 =?utf-8?B?ZFpyQzBhYStsd0RidHg4WVgxc2RJc0hoNTNxblJ2Q1RicjZVQTdyZWdvd25a?=
 =?utf-8?B?QUY3bkhRMXhYWFAyeVhhYjZFaGp3YUlBeHYxTnVKZzdYa3g4K3NtbXRsL1ov?=
 =?utf-8?B?ckRUNlM2UTFxbXdZVnkxQnNRWGlIUW04NGhwSGR3UEJiQ3VVdnowRDQ2Z0RO?=
 =?utf-8?B?YVhaUUtmS21PaCtxN1dlWGF0WHA4NWpLdnJJY0liaU9IU2VzckdYa2lLeis4?=
 =?utf-8?B?bnFUWGVXVVZaYXlrWHZFYllLNFRuU2hzbmhjczVYdm02Q3B0YXkzbDl5ekxp?=
 =?utf-8?B?NFkvVWwvVHRxTEVnU240K0M5ZFF2MmtOQTVuV0JmTlFjVGNCYTkyM0EvclNY?=
 =?utf-8?B?OHo0bnd1ZU5VVnV0ME5TYkQweFNOdlkyUDdSODFXN1dzQlNCdktMZmdibVR1?=
 =?utf-8?B?aG1lVERsZ241bnlKZktxUm5IRmpka3o1OXNFVmJoK3VuMDQ1RS9kak5BY1o4?=
 =?utf-8?B?cWVjNnR2OGdZdm1OaGlFc0R4STltWkFjTEtadnhMZ3F3VjVTSWlEMWQyUkRt?=
 =?utf-8?B?VlFvQzN4UTBYMEord2NyMUVwMFBlcWlLSmtOaTdxRVkwdGphM0hsL1d2Lytj?=
 =?utf-8?B?ZE9yblpwSlNDYVNJS3NDd3U0L2ZIeFhHMHhldDVEUVY4Q3lMVE16VjJKQllx?=
 =?utf-8?B?RUhjbWYvRUxjdlJXai9Yd0E3bVB3MjFmSGdMck9laGNpZWNKVStPUVZCTUJN?=
 =?utf-8?B?RzJ0cWJhU2ZmRnBOUHRBY2xHVzlMMUI2QTUzK3dFN1lNVVlaRXR2MWVsTkNQ?=
 =?utf-8?B?TkI4QVZvQ3daS1dNU056ZkcxMVRGRUFhRENWY1g0UVBreW1CUUZkaC9BRit1?=
 =?utf-8?B?U0d2ajljaEJERG1tZmFVOEg1MnhCUGF5aFoxelVBSlNoZlRRMkJuUkM3NURL?=
 =?utf-8?B?NWRTRU5xMnZFdVFkZ0dCSnQ1akpCM2d1aDZBcXpqMG5sNE5QODBNb0hkcWlw?=
 =?utf-8?B?eWRsb0FNTlpvSVA0U1NXUU9pM05kLzFBdlUydjFMOU1DbWxmUE4wT3hsd3Za?=
 =?utf-8?B?L09rUWtRSnFMbm1ObW1TZGRxUzhhV3AyWElWZzF5MGQxZDB2cU9XeGxlRnQ0?=
 =?utf-8?B?YXNZeVQ2RndUOEFoRmtBd0poVWEvaUNCeXo3QUtkUFN5ZHBGVlhsTVljZFdD?=
 =?utf-8?B?ZFNMYVh2ajBKOFdaUzlvTWJHNmdUWnM3UDd5c1o4S1RxTjU2OVFwRUlkSStu?=
 =?utf-8?B?bjZmdlZUdGhuUE5uVElLaWMxSVNwbE5wdmpwUThmZUhILzcwbS9zMGFXejFo?=
 =?utf-8?B?eUNwVkorZ25wV2ptODNOQjlOOSsvWFlYaUx2Nm92ZTZQbUdyY2dVVUdoTEg3?=
 =?utf-8?B?SllYKzZRaTBuV2RrM3JHTW92OW4wQ1J4WWJNWWNIci8rR3I3MVo1bGgxWGxH?=
 =?utf-8?B?ekIxTXVqc3dCZHJPUE41T0FGY0p0eXBKUFVQRTdJSWd4c0Rua0hLQ2dHYXBB?=
 =?utf-8?B?MkowVTZ2MGZxdHRKNW45VGJRaTFreFFGeDg1STlrOTc5aVBkS1o5MmZ3RlRP?=
 =?utf-8?B?V3NvZUxCZFdHOE1sSzZ3WWNVdWRuQnhBaUZvYWZuemQvZ3l4ZW5oekcwS1d1?=
 =?utf-8?B?TG16ZjlNazdwRFdhMnMrdm5PcGwrTWpCSmhFdnVueEZXWmtmSnFlUU1pbnlX?=
 =?utf-8?B?dldEeDBTeTdSak5mMmtpTkhKaktRVVE1ZSt5T2taaHJVY2lMYW1HeTU0dTVn?=
 =?utf-8?B?ajh3RFpMZnEwVnhxejMvelRWTmFWWWQwWVI1THh3Mk9TRW10MlFiM0YxdEox?=
 =?utf-8?B?R3gyalpjVDR2S3NxTU9VSlVFQS9PTFRIdjBTUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:11:32.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad59a45c-5910-4898-fe4d-08ddb2683ccc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8495

From: "Kamil Horák (2N)" <kamilh@axis.com>

PATCH 1 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.

PATCH 2 - Fix the BCM54811 PHY initialization by implementing MII-Lite
   mode switch

PATCH 3 - Add optional mii-lite-mode flag to switch the PHY to MII-Lite

Kamil Horák (2N) (3):
  net: phy: bcm54811: Fix the PHY initialization
  net: phy: bcm5481x: Implement MII-Lite mode
  dt-bindings: ethernet-phy: add optional mii-lite-mode flag

 .../devicetree/bindings/net/ethernet-phy.yaml |  8 +++
 drivers/net/phy/broadcom.c                    | 54 +++++++++++++++++--
 include/linux/brcmphy.h                       |  7 +++
 3 files changed, 66 insertions(+), 3 deletions(-)

-- 
2.39.5


