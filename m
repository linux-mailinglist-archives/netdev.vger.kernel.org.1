Return-Path: <netdev+bounces-238678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2FC5D77A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60FB4E5037
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDD274FFD;
	Fri, 14 Nov 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="r4tatp4D"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF09136358
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128896; cv=fail; b=hJW/bBJQsH9/m8p+QcBWJb17VUR9qP474R8D/7eLhjcbGoXu5OMUk0F3GdZLhkvlyCOrHKHXpvx5C5FbO1HMAnup+fPlHUtSikWdrDSXFQckC+STNakTWRw/2xBxQu7R+xDF1V5B21yOvyH8byKKzsiHOLu+/m44MS9962ZODuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128896; c=relaxed/simple;
	bh=A+LObcPZpd3KoSgo6xIFVXbD1a6uaMIxFghwfcyQ5ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PC6Qy/s1VNrFZ+ZfIgMCs5AGJ7sQYoUkJTF6kSON1Sx/mOWzpDr+KtKIWjCdekib2Ie+yk5zMev08V4FGV5FIUIPDkRXQ2JDcrqiIVvTU42Li/VmvfFVhRCtfoAd1DRTp8FoA/tSCkxbihohgMDyj8m8oLgKg3RYV+ucBOiHcbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=r4tatp4D; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rP+UOQA0ip2PzOAD3rEXOsIrTdB2yxhJe/fzTqeeXli0MWbqxQkO+8G3xaenh7x35yQ7eMzMCXjpz3sC5AKu2jjh1wMyzS5EkWxKmMnZa2e9FO2JpS9s4au/BCrCPmRWoQybkHiJojDJYNuIxrGHeUabZKZFTPdlNc/8d3ywLQmHQoCOQRZmqd2Mt1MZeiFAxdKSxPoaPWn7y0g75Lx79XmqLkR/hNHvgty1BYdyb8DMKBL3zo7mKgo9g7DZk37r/mQRiNI8ZPeHk/9A+gDdLwToWMg64EZli4R4KSIBU2abm5+FDexF38QDJWRJ9BnSRRNo/3N1fz3MtEf5u/z3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jswt55+CqNF3t5UfbpNlXS40Et6Kj45lhWo7euJ2VfA=;
 b=ORJEMaLqntC/C689mOKVDsGYlX3sPV1yYQu6ViBazY8JvKLEARqmWgx99YmGMTb5EiJnKBwdsV6VK841sK9m8ZAvMOqb4SSXpN95oHrmZ9kpUkvNPbCehw0x1WSk68S5T5sw/Ba1slFQR/U6plgA77vgP9I51DOfC6kO6c+E/k4vutdU5PWo48bSHnF17x85wthh8n8ptVMLNRvv2Jr/1ibkNJaCHY14nTyktmey7AqDCFvg9rQnZQnQjLQdIyiP+nnktXQxzJQsNaf+py2UrvERGApYpKeishqMTSXWsC8b35XF+HQJiDE7M5vUZ4Rihh2lEwH8PHao0rcjD9rKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jswt55+CqNF3t5UfbpNlXS40Et6Kj45lhWo7euJ2VfA=;
 b=r4tatp4DXckZRYjgf81XZJUXOOxdHOPkzfrSQrk+OoPMO9LwsInIqQTeAqNIgHTel7WgyNEwssFt9YEVLPby1lVF2q/84R2p087mFqjRi9x81a3Vf5wmCdre6V5AE+R6BCTBU2B/xx2bgoFz9DptTTV/VqOXDw0JERaOQPw0AUA=
Received: from AS9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::28) by DU2PR02MB10205.eurprd02.prod.outlook.com
 (2603:10a6:10:49e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 14:01:27 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:540:cafe::c1) by AS9PR01CA0015.outlook.office365.com
 (2603:10a6:20b:540::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 14:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 14:01:26 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 14 Nov
 2025 15:01:25 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 14 Nov
 2025 15:01:25 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 14 Nov 2025 15:01:25 +0100
Received: from pc55631-2335.se.axis.com (pc55631-2335.se.axis.com [10.94.180.160])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 97FEC2560;
	Fri, 14 Nov 2025 15:01:25 +0100 (CET)
Received: by pc55631-2335.se.axis.com (Postfix, from userid 18910)
	id 9252E43A51A9; Fri, 14 Nov 2025 15:01:25 +0100 (CET)
From: Peter Enderborg <peterend@axis.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Daniel Golle <daniel@makrotopia.org>
CC: Peter Enderborg <peterend@axis.com>
Subject: [PATCH for net-next] if_ether.h: Clarify ethertype validity for gsw1xx dsa
Date: Fri, 14 Nov 2025 14:59:36 +0100
Message-ID: <20251114135935.2710873-1-peterend@axis.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DU2PR02MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: 510eabc6-b67c-4a49-27ca-08de23864d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvwqYhmoOllDh9rFM2IK+K4jnz9C4EEMqH5roXAjo5/YAO7GfkQwyxh1Kdgl?=
 =?us-ascii?Q?7mT4FIVexkAFdjrkNoCZUX5mWL9jiNua8TeCE/Zmdrc+jo53jO2G67arxNQH?=
 =?us-ascii?Q?kOaeiNFhQVdCgxULRjdwO6IigB6jGbVKfk4pTXnD7xyugD7c5evXifqzjxqJ?=
 =?us-ascii?Q?EW2nV0ND5pbIaKzfsfPNPJKRLlmORXC9Yi8igEkSdV2yY93qWI4xd+QsrSVu?=
 =?us-ascii?Q?wo9mMZD3oFAfx/fqwc1QQCPwRV5/kQ/mP/0nLVJCkvksdY4JnwkpbAnWEo8g?=
 =?us-ascii?Q?eLk5Or0r3mjFuc1rnbKPXznZ39PTzvVyOeqy+uSxySKXgRFeg0Ft8b4S0n8s?=
 =?us-ascii?Q?SgIxqPGY4DCjnlXvyxurHpuca5EAmCmfenULpz8UAIFzP8/sZ2yrhT7Wru5l?=
 =?us-ascii?Q?GoVmBwvMRivqQ9/vP3YDB2tPCt7kIFNh7p+GMwkb47AR9nJBCtC+cLmZ2m4U?=
 =?us-ascii?Q?TRb/jzY/xLUWtvojfQ4GFw6DGuyx+Uo3GT3MEsy2DooC1jdjR7yY42PlBE/i?=
 =?us-ascii?Q?ciAFjlFWwHpbi+UOGC8QXLYtr2LdNHIib0g/jH0WJn4aOjwjBzGSPQVky3E8?=
 =?us-ascii?Q?OwG18uBaptmSOWQgZAiWmipsR9bsllwpXvYdpo1M5hUdztVNjvTE7nIEy+/A?=
 =?us-ascii?Q?/ZAmsrs7OOokLAVDNrPlxCEwNEm1862CtVhnqLwSPfsqapj/EEwV3zXodne3?=
 =?us-ascii?Q?Z1DY1yXYg6CNVIU9pgt/BYNE+gyUevroO0HGGHKWuoA2ttUMMA1XcJL/Lkyg?=
 =?us-ascii?Q?nWGow98YqSMMSXnC2flFtPoch3+Qi9LJkdwFO9+1udJ1uoGejtCsmhmguLKl?=
 =?us-ascii?Q?G9RB0YAIiH4s5zTwD5ZTMmRvvUa+8BNnFqqdFwP7cw5AaJKW6gJcD0kqIcDp?=
 =?us-ascii?Q?Y8te76ROJrKwE+p30RBYV3G/McRXDq4rbYBogKHyQDbwSShHNjUEU01yp4rC?=
 =?us-ascii?Q?v6exgEpkKSLBv8D97e3qlM/L8hgMG+lZWxC5rp7HCdsy7tzHUbxrJPVNDb99?=
 =?us-ascii?Q?SxUWy70+Q8n/9wnJ4WInR1ev5lPKD1KzM84WJgXUt2+OzLxY6ZS/jCiYs/CY?=
 =?us-ascii?Q?FGE+4UBHW+7OABpINrKAwbPjxejv+SMQjpKNHZYYKWHOCCviijXV/YtSVWOI?=
 =?us-ascii?Q?juOwasjVgOK93+f5qa7ld3vr1BkbJQ16lggviluOkUOXBKD01wpZGxRmC/+d?=
 =?us-ascii?Q?KMsBfDEeHvsZtbbgJ53XRRC8VySPuNWNFmZqCNbLnS22Jn8kVoKcSigfiq+e?=
 =?us-ascii?Q?nzjK72bKtrBcqPLyqPUZMLy7zgkLjfxYsUmSIx3PwPA1Xe8FohoxYb19zZJ1?=
 =?us-ascii?Q?Pv5up0rzIUYohs8vtMMGVBxwfXBfGWWkflAZ3l/VF5yiXT3ySfwSDW7TZwna?=
 =?us-ascii?Q?T7PpLTTOM/5qrckuR7Ov2fC/XYuF5POgBvSY5Ke51x2KcBp25Fh5rrDAaPDh?=
 =?us-ascii?Q?hOjnwBPVjek8fMOqg5GXAdv6cT7P3g9qUdtL/f0X4IICm7SX4wViVEDssY5q?=
 =?us-ascii?Q?f+kbt7ObRtlEaV/8gWInDuUPAO2RM4Rbc8r70CEcdDdREM9Dj9fLy0CjYa/k?=
 =?us-ascii?Q?7dSxuMsmlrR+QBmL2oA=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:01:26.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510eabc6-b67c-4a49-27ca-08de23864d40
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10205

This 0x88C3 is registered to Infineon Technologies Corporate Research ST
and are used by MaxLinear. Infineon subsidiary Lantiq was acquired
by Intel. MaxLinear bought IP's from Intel including this network chip.
Ref https://standards-oui.ieee.org/ethertype/eth.txt

Signed-off-by: Peter Enderborg <peterend@axis.com>
---
 include/uapi/linux/if_ether.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 2c93b7b731c8..df9d44a11540 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -92,7 +92,9 @@
 #define ETH_P_ETHERCAT	0x88A4		/* EtherCAT			*/
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
-#define ETH_P_MXLGSW	0x88C3		/* MaxLinear GSW DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_MXLGSW	0x88C3		/* Infineon Technologies Corporate Research ST
+					 * Used by MaxLinear GSW DSA
+					 */
 #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
 #define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
-- 
2.34.1


