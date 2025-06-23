Return-Path: <netdev+bounces-200319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC864AE480B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA87ACDB7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723A246BCD;
	Mon, 23 Jun 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GpIrKvUJ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF22276051;
	Mon, 23 Jun 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691502; cv=fail; b=TcJyMP5WQo7bIg3setTmXugwAe3lCRHT8fF2TeaUf+l4nlVEFo1GmuVuK3ThPwZYhSmt/as2uLysMW2HKTY5PZsDXUSoN8rIZI6tCttBSAX9edQNptSPrpacWAtW0kBrOPq/jasNlmCVuCJ7Jnfpu8pWYiiGLhVF0QJPbOXm+vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691502; c=relaxed/simple;
	bh=PXZLe+vY0k1I1US0rQqtgjE9O++mNtDKYKSRsy2Trvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgBRUUhMlhb1BKV6dp1H+F6ukrbyIUpwZj+yz4swcgFohzGw2rxCl1jidt6w4+y5nbxDtF2vRvEOcm7gwdM6f+eNGx9BGLYoASmNIZSpzlffg2xbFQGKFv5pXBHxj4voGpuBw+P/wpqpnSVw31aTqGQwoMRkX28IRtNekZ3l/bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GpIrKvUJ; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhUgFasEgfB6+3MeVseVvgvzCAJIDdycWAsJOpj4Kxb4MZS27/5ALQcuwgD2rfzysvGppCb0ew5colNg8dltZtwQt2fe7S3wIlne8VEYTt/3sH5cQHJVO1jOiSU0fvCdpqUAGYJevNznOwZ06Blkk6BYRVlVggXy84qf+OQ+KeCf7HPfi/Le8TFhVtmQVEOYFzhpsJk4ChttB3CyOSBlmT4jyRfahrZVhRsg23hcjuqr5f6o3K5cRJ0YpYrY2CBvh3yj5KCIu2Z+1CIYsYNqk8go/15ZPNLuYR/l/LXwtkbpOhFyC1/BmcOdA6ZquK5vrcLvi5ypnpuzCnkzTqxrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN6zia9c+MkVqr+Mw+Rxiehdg28wCc/2naOGaMe9i9U=;
 b=IO56OZX/mb4V6w7siUNRo6S5D3GpEGIntft6bbwV41Hew4xvDN35MjvPytYoDOrGWnLr/SqbZX9IpxruYBxQmxfG6C76g1YNZWAMBC/WcFAa+DN6w5JZeTYnu1lqxxEBe1AASKRVOxvG3iKh5aEl9PFRwGWqJ6BrSjfuKU5jzV7ARdJwHJROfgkUFG6S1axg3HAHqPYYanKJLyHiDue0+kwU9d9dCHiax/5uCR5UTMYSjlrplVo7EKiPoLpitjPVLFMWN2zvaQ44ui7cjON/3GYSrgmacM8JhNSsQOWFlm2dRwfXI2Opigtf+PN54gZTJiAUr03sqfKe1jWkfDnpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN6zia9c+MkVqr+Mw+Rxiehdg28wCc/2naOGaMe9i9U=;
 b=GpIrKvUJdvU2qS5prRgfO+CW7wnTEy7NQPhy6Uf1z6avqDjIQF1r3CSnkBWoyNd3M8tgoXPmXob7kUCpAYJfeWepN/ILKu3i99Hw+8M++q192U1JZ6bETy1TrLXUL9c/yPPk4BYeBbqLy4VtW2tbh+R1emcpcbG9TJpbprc/2uM=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by AS8PR02MB8495.eurprd02.prod.outlook.com
 (2603:10a6:20b:570::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:11:34 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::87) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 15:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 15:11:34 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 23 Jun
 2025 17:11:33 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH net-next v2 3/3] dt-bindings: ethernet-phy: add optional mii-lite-mode flag
Date: Mon, 23 Jun 2025 17:10:48 +0200
Message-ID: <20250623151048.2391730-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623151048.2391730-1-kamilh@axis.com>
References: <20250623151048.2391730-1-kamilh@axis.com>
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
X-MS-Office365-Filtering-Correlation-Id: e05ebc05-a1e4-48ec-4c8c-08ddb2683de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGhLSVF2aFBzVXoxZlU1RjVvR0FtOWkyWEJBWkEzYUJSeE9abGk2bU5CR1VD?=
 =?utf-8?B?emxBZjk0bVJLdTcrM1gvbHlDUW1tdzJWU1lJbjRXZ25WL3d3WUJFa2FOTXdD?=
 =?utf-8?B?TWdlVFh3bml0bzRqQ1FsK1RqaGRCZFhHaXJEV2hoOU1rM3gwdkIwbjJWc2xK?=
 =?utf-8?B?WFpKVldQdjY5MzVIT25hSmhqZU9XcTM5bzc1YW9JZlIxQUJEZ3J2WjFVYjFo?=
 =?utf-8?B?UmFZaXZqbnJMc2ZWOERVTkQzRkp2dHpCcERnMWpseTVLZUlnYnlwdFlSRno3?=
 =?utf-8?B?ZkZPNDRvM3I3Tk82OU1tbGRyY29hQWorZzNUYmR4WWJpNGZEZWlWY3JTYzhB?=
 =?utf-8?B?RGNHRERkKys4M2FTcGpuMXUwSnNTSnY1dGhwb08zMWhPUmhSV3QwT21BU1h2?=
 =?utf-8?B?eWlVekZHMnducjllQzF0blBCeWtjbjRRTXZOYURjYi9jdGJZbnJJbmhTWjlW?=
 =?utf-8?B?bU1HWEkvUytnM1Q0UlNMYnQ1YUU5WHkxSW5GNndJNElrTWZOclhYUFVGSlp4?=
 =?utf-8?B?c1pxRk9hUDFoRWFnMU1hQlNuUzVtbkFGRDBiQXRHNDNTeVlDTGhORGp2ci9X?=
 =?utf-8?B?T0ZkKzdGZWppeFdMbmIxUUkzUXk0Syt0VzV5THFNUGJQSmpoeER1Wjg3VElU?=
 =?utf-8?B?MllTTVVRemZ4TVkxMC9KQ29QdmxqN2ZTUW9TQWRvL1h4QUtxWWoweVgrVmNw?=
 =?utf-8?B?bndhTGplMlJJNWJZTDZsYmNUajhMc09GelQvUkJwSVB1Y1NOTnM5clIrVlEw?=
 =?utf-8?B?d2dQVUp6RVZSdFBBUkY2bVFVdlN5MTJkOXUvb2ZvamRMVTFPMDFDRmVnZHZn?=
 =?utf-8?B?c1VCUVo3U2Y0a0xpbVQyNUgrK1RkeVVXclQvU2Zmd2lKNHBsVzFPOWl5ZlNP?=
 =?utf-8?B?Z3J6OUVJbjFyaGZHUHZEQ3ZkTktXNkhJUTNXTnV1eUFsRzZqT1dFNmExR0NR?=
 =?utf-8?B?bjhJT2VDbFhtK1BKZFNlNkdTWGpwV1hrMlJLZUR4T3dNTU95MnFMWDRxaUJl?=
 =?utf-8?B?MUg5VU9XNW5XR1FEbFJyWEw3b2JhNHdHaFB4SzFDY2Z3Q3Rlc2N2UkY0VG40?=
 =?utf-8?B?WmhvZ1RuUi9VU2xtZWRpZmJKSFVRc1ZiOGhYSXNsMUxWR3E5dG1ieEdJcmp1?=
 =?utf-8?B?cVF6Vm1WWFpGMnRxQXV1eHhEOHkwTjBxajhYNEFEUjRVbmNmUjhXT21sZitr?=
 =?utf-8?B?bHltMkxQL0UwdG9tTGRxa0tjN0NsTUJtWWljeTNUaWd3bXJQNnNQbXErV2Z4?=
 =?utf-8?B?T3hPTThNbko4Vmo2a1pybDQ0Y3ltREoxSE1RNTNEZWRhYWdOYS84NHZ5Z2lp?=
 =?utf-8?B?L1ZGSURqYmU5QlhieVI4UWh3MlJJU0NZTkVvRGxxNGM2cFd6K2lkNVYwSFR3?=
 =?utf-8?B?ZXJTRTVRTHUxaWRmRElPZlFnY2hzc3NIdFBGNFVZMndIQzNVNzFvKytKbW1C?=
 =?utf-8?B?Vk01T2UvYUdMUURxWmwvZ28rZ1cyZ1VoV2s4UU1mYVRreStqOGl0VkhFellv?=
 =?utf-8?B?dnhzRWxxcnlSdzNibTlCMnBrdy9Ia2JvWXFIMnRhZkZIemt4Q2RJdit0eEdV?=
 =?utf-8?B?a205VjcwbE8wd2xpN1hEZ3RrNHNyQ1QrQ2NoblZKcVBqVVJUcHFSV3BnQ3hk?=
 =?utf-8?B?T3pKZGw2Ymh4cEVueWhOOUFPdXB2VE1CNDkxWGhEaE9Wak5uc1RFdVRvUm9Z?=
 =?utf-8?B?aElRelNDTnRJSE1hM2tGV3VaYTI4SXByNUxERmc2dnRNRjZuL2QxL1oySDk2?=
 =?utf-8?B?WUpmTk9GYmw1RCtWNXZpVXBCL1ZvaEIzMGFRYVRnSDZvMTBTTHZKcldYUUxv?=
 =?utf-8?B?dnBqRmF1OXYwcDBsVWJqUnJPVmZiSEN3VWVqekQvNDFwd2t0UWRwZWcrTDFT?=
 =?utf-8?B?TTJGRGJ5c3J0RFhSRUljNnAvemJHTjZUWFlDekVGOEhzN0ZpcXRYWUZ3ZGp4?=
 =?utf-8?B?NXY1YSt0M1g1WXlvNWVlZVlLa01PMi9LdkxsUEc1aVYvNnVic3FEWFVHdEc0?=
 =?utf-8?B?YS9qeEs2bCt1NFBibUNJcVlnRmV0WmRDU2w1OFRORnMwZFVjWHVnWUMrbjIr?=
 =?utf-8?B?K1IrZ1M4MnZHSTZFNlVtQnFFMWd5c3RYVG9YUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:11:34.0480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05ebc05-a1e4-48ec-4c8c-08ddb2683de1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8495

From: Kamil Horák (2N) <kamilh@axis.com>

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


