Return-Path: <netdev+bounces-201526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A39AE9C4E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181EC189803B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDB275866;
	Thu, 26 Jun 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Q4NhM8AF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B215B971;
	Thu, 26 Jun 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936587; cv=fail; b=aBzLb2TVcTwiHGcH8JnZqPzZPfUmSU+fdBKS5fHxDyMwVoLJtTUVsTu0f3r4D2JLEM8razfCBeO2iXzFExSv1y0fKATB++gv+01Gq2+FvEhJmyTX5N/6/U0zNVIr/ucfLVOzU7ybjxVFMQ3/m9PyED7V8NNFJLen3edNBRTwDcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936587; c=relaxed/simple;
	bh=AXEFTaY8Dl70QqeV37/ey1rX77oxDxnP7/fmpiBZYmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbsqjwtnLBmGyQwgK22/36I4VH1UN3GMSLpxYy0FiSXDplGVM74DxAmTytFcOZouAnL/9iLWpwsw9EkIaYNauT6KXEVUJ1asQilOScPAOYGmbi6QZFGw2Zt84RaKXw8h5tCGi796G10djwWS+Q3OcwLSc6o+NGehTBzeMTpJ2oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Q4NhM8AF; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzP5ZvCM4uv+tpoAb7j+pIcAbMDWBpFtMrv0TFmi+lOS5Nsi/GVg4nD7YQ445+QWtJltgMCzgpQ9k0Jr37dbSBU8l46xrMOG9CXUWJl8TpoTV8vL010ePG3XCJK/TlBBKBIRdpWooy0q8woqMIUVXok7pytvG+nueULXBMjC5EjEiKKExWTHpclrXpUiHI6PrJgOSDwCH5wIBdcAhcFDMBh3W0qm7wt7WBNti7If1Aiivc9YX1EPR55Wsk7L5JCmasrR+DoyoNoy24fZzDSJTtAn/mMLQY6uAkkAuYB+WBAwc6YBCBFCBY2l+oq6Gd+OgX42adQaAC9LEvIfFbH1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iuwv4TOgBBH7uC6d1M0AFq0avU66bPGfPLr6PdS9yK8=;
 b=zWKBsWHN5v1CrAWKA13yphd6UkYz99tvv0rntH+vWquzFWeldtwtAjpFnuWQjBid1BUCLl3GmfXkU2OpOuVhtGBOS/BuF7a5btDV5Z7hNS74wLTpBJXXotQjR+jjOV+vC/KOA2Q/FhetqQrFCrBxNHB8W671/sCygY5mgrB7zp6ScokFdmVv8YnKy9GFz7pr3qlRSMWPIxVRjBunRNdfF5uBRWjHRh+RWdzElkbQKyvb7tDGmhcyE7HIcSrawEzB+2A4YQBQXO/jiv1iObEi8K/ITyKbJPDzDAbkj/IJtAZ299FDftGZjL9YBzSAt7dHw3FLj6VdTdUQTxTwx+Vh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iuwv4TOgBBH7uC6d1M0AFq0avU66bPGfPLr6PdS9yK8=;
 b=Q4NhM8AFiBFmgNdknkM1Y6Stq5DvKEr2WG2O8nn83wOQyWbqSw4yMYhKncMVJZIZh//N1bjr06zn5jYeAamcIHFfsthZpDEanXr03TVi2dFJKSARW4cNsa/GSIGvtac0fC6YTXpHlhDN0lHC59FzWsv0BKmh0kKjCDAKtFm04M4=
Received: from AM8P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::18)
 by AS4PR02MB8527.eurprd02.prod.outlook.com (2603:10a6:20b:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 11:16:21 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::da) by AM8P189CA0013.outlook.office365.com
 (2603:10a6:20b:218::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Thu,
 26 Jun 2025 11:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:16:21 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:16:20 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 2/3] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Thu, 26 Jun 2025 13:16:02 +0200
Message-ID: <20250626111603.3620376-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626111603.3620376-1-kamilh@axis.com>
References: <20250626111603.3620376-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS4PR02MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e3f496-029b-4ab5-882a-08ddb4a2e163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0pOQ2dqdGI5KzlBaWpYWDZXazdtMmp0d0pUUC92V0dKZjVxNHQyMUlZM3FX?=
 =?utf-8?B?MENtS29VdXlqNlVSU0IzYm5yeTlJNVk0Q0dOalVybHlCRGx0ZldHUzgwRmFZ?=
 =?utf-8?B?SUhLdXBTWHU1M3pMSTdvWWZBQzEvVzkrMUJ4cWoraDlvTTBwOUU4WENGdGtj?=
 =?utf-8?B?RnAxYXl4ODVLTVNneXJpMkpyeTRLcVlvdnFqa0IwZWJUL2lTWEptbHZ5ZU16?=
 =?utf-8?B?RnNCV3p4dm5KaE9MREMwTmlsVjFCbjBnYjAyOEMwQ1BEN25qRit6YmhCMG9j?=
 =?utf-8?B?QnVuYk9YNTlRWVNqakQ5b0NhTExJMzB1ZEdJcE8zY1FZdnBWQldSZHBoYjNs?=
 =?utf-8?B?bm85V0k5UHpaUHFnajJ1NzdPVVZ4TWQ2L1NleGRoK0d2aXhWMmphZUJWV1hJ?=
 =?utf-8?B?T1NEczE5aENGbzVtb2lWa1VoNXBUd1R6VE1FdjBKUmxscGlBZldLOWo5SmVK?=
 =?utf-8?B?bFMzeGMvUjRDUFkrUnpJYkJpTG9kVDBnK2R3d3dudDNPMURtREU3TWpyNXB4?=
 =?utf-8?B?WWp5cllMNUtSb3NQVHRaWGUwOURvbmdzSm9oNVdPM05aNjZpZm9mQWFlSEpk?=
 =?utf-8?B?MnJVVXU1V2JzTHJCaFhYUGozZW9TQTgwaitEQ2RtRERMVWVVU0p5a3BRQ2dU?=
 =?utf-8?B?am5uVGFHTVJ2Zk82L0hvTmNsR29HS2lDQitEdHBxZ0pwemRyT1dsa0ltRnNx?=
 =?utf-8?B?M3Zubk5RVmxNcFl0MTJtaGY0SlR1QnhxU1ZjTnBmTTBJY0VTVXdrdjhkOHZV?=
 =?utf-8?B?dTdDbzFUQVZZcmxjVjlPY2MrSG5FbUN5enhZd3dlQ3pBNkdwN0VIT01IY28z?=
 =?utf-8?B?REJIb2kwRGxjQXprQTdDeTc2aUZqcFRjVS8rcHRlVWhVbjcvdjlhMGR3NFkx?=
 =?utf-8?B?SnJUQWdVcy8ray9vaGErcUFka3AyZURRV08yMlhubDlzV0tiTERVZTdrMWFS?=
 =?utf-8?B?N1Zpb2FFZ3pNOGh0MEEycVplbS9ZVU00eWVCMnFOVGkyUWx2RGpFdlpVTnp6?=
 =?utf-8?B?eGZTb1FIcnRMTnhtMTRQTTR5eTkvU2JDTDkxOC9PdzdHWFNZeEJEeXVaT1Ay?=
 =?utf-8?B?aUJEVjhSYkRpdVVEckF1RnFGdmRFbFVYbElEd2FvUjNiZUFJWFJtL0dwZEhl?=
 =?utf-8?B?d1lnaFIwMTI2cmVSM2FudTc4SllNb1IvM3p5Qy85ZkUvNTNoaHVRUTJnWUZF?=
 =?utf-8?B?YTYxR0srRFJEK3RyaGpLaVoxR3htZE55Mk9LY0RRMnNPOUdqNTUzVlhuQVBT?=
 =?utf-8?B?QWlUbmsxWlQwdi9wR0pobitEQ2oxMitaZWJFQm9FaHQwUjJ6VzVvQzNyb3B5?=
 =?utf-8?B?V214NlFiU1FQblF3YmJYUHR5bmN2NC9vc21WZE1jRmIxcjRUS2wrY0RkWjRt?=
 =?utf-8?B?SUhpZlQ5Q0hKWE0xRHFoOWRGYUR0OGRGZk41Q09lc2NwVXMwWjkxelY0NElC?=
 =?utf-8?B?R0VEaHk5L0Rpc09qYjNPV3YxZVJCT1dyaXE5TS84WlRLN0NwU2REM3pSSFdz?=
 =?utf-8?B?UzBRazhDQXB2b0V6UEJVSUswV0ZUOVZQTG5QTlZpaUlScnBhMHVMUHp4Qzlz?=
 =?utf-8?B?dWlHNTBFd2NGQ3pXYXpUQ0tRRXgwQ2JrdGZoNFNWNlZUT2lJMFRTdFgyQWcz?=
 =?utf-8?B?STlKcWg1WXRIdnVOTXhsSzBBTVpjN2MwRWlFZmlkRGRGWmNRU0F0ejl4TnEw?=
 =?utf-8?B?ckZVb3M3UW9mL3Q5VlpNVCtFbTRNZjdMQUN3ejJqREpXMFIxYmxoa1BkV3lt?=
 =?utf-8?B?V3ZXMVk3UzhiMWg2Tk1BV3ArT29Nc1g5VjB3RW9Rb0psajZSR3Q3VHNyeXgv?=
 =?utf-8?B?UGhlUFRoanJnMG15R0VOcW9yMlpoUk5nOGppajVveW1oVy9JZTNpWEUrR2lt?=
 =?utf-8?B?OXp4WnlSMElQNkI4aFA1WnhCNUVGYVpDcitSTlE1cWdveEN1dDdEQ2VxbkFy?=
 =?utf-8?B?azdsZ0kra21VQ2lYdTZyTC9lY0NxVFJmZzJoM1NPQS9YVHR6Yk5XblVMUUJZ?=
 =?utf-8?B?U1JIdzNEQUFkaXVmMkY4anl0cGpuZUtsbXhnWnRqVUo2eUcrNzZweEExWUh1?=
 =?utf-8?B?c1IrL2lUNWZiNGFGTFdYcmpCRERpTlErV3JHUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:16:21.5149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e3f496-029b-4ab5-882a-08ddb4a2e163
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8527

From: Kamil Horák (2N) <kamilh@axis.com>

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
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


