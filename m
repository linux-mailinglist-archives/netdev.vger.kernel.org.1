Return-Path: <netdev+bounces-201899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63EAEB62E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580D3560D77
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38C29CB32;
	Fri, 27 Jun 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eVnk/DVS"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012016.outbound.protection.outlook.com [52.101.71.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF5294A1A;
	Fri, 27 Jun 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023413; cv=fail; b=NuBY6u+HZTP8z7mjEZiuDCYwr4RVfYkQqVH7v3ZF3maXl54L8uWfL/l+ay09DwzvaMxTTId8eQ4RLFvexjM1dwrDmF/HJcHUeOM5i4V8nLooxYfMj/NFskxtxTW8m5NDjCFyWbchgqzFAkBdEuRuoBah4ItT0NWQw/4NwP6ZWpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023413; c=relaxed/simple;
	bh=DdzIdH1tBo3M0022adW53XQYloGoEH4wQXm2CJWpc7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FD0mLGTeVO+9cJ0bjbCxiz9GCKA7nk02jLaQ/b2GtI0zVTYL8rHxqxDfX4sWYOET0l85FjOVBGmIZZ8F+t8EJmUFRzTtnTnBrDtvuU0CD6SwGZ2CEq0NRHwzZ4/6RBBJ8HpGLDzuLGA5fGCQBpzLTcr2d97GpM82FuP6QdKdFDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eVnk/DVS; arc=fail smtp.client-ip=52.101.71.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgNmBSSfLL1Z3Qvc9RPeTcNNbUUBQe3d+/BOmjPhjfA6OOJrP5yVe6B9IeXM8vkG0OGRGfyb4TpoWhaMZyLUWROvxzB9hC6bnZJu+bWERkLg0gei89kjdbgtF96hJD7j0dy9llHPyE4CczcLQC6BdZ8um8VQFX16CWi9ZGImqXmEvJnocgc4okvO8M3mLe5eYRpTKbDCkVKLsbICswxChJTNV7Erbdu0UgWxjRzBP5b0VDkGshLkcUhvMvei+sCJiAhwL0hbNycpJbLfH+N3d1fQjWB4fqd3+JDGvywDeJXPf0kyRNqnzy9mHloUljXPAPY2uURuSROyMUD9uJwmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTpduEGJqNGs1WF+pzrCnRCGLcMMsJs6mPoO1Fjx1Cc=;
 b=MnLzA2d2o0tHXHorMg27nuyL6zswW1riP6EU3PEkfHD03GAIz3+6OJZqZUliqCmcQfH63n4mw8620D47fwuJXRcnNtY4bRpcivYHVD5Nlh/uCFgsqDArCUJvfKbi/QQ1fNnyy+NDmgITRJ4KwVh36miG9QbnEdJuOINk5gAVSDgDiwSfHkYj9bH2uodz7mroFGSYy138QcNx8ZxjsNb2CT7AJ5ZI6UdNW/0PqMrlT7JmyB0CqEtXehphio4ySMqH9BdVlxXx77JmUrEYKTkCVv+DdbkYEbtD68bYui0b684iB/BvyChM+gTlX+LW/cPIxi6+8zXk2vbgMxG5dzqmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTpduEGJqNGs1WF+pzrCnRCGLcMMsJs6mPoO1Fjx1Cc=;
 b=eVnk/DVS+yxnbRDTMh3ekHMkYu92ZX7QClHFqHFnm9SR+Xrib9YuRz9kpHuo0peZnmpgvR7sodMOBJm3XVXuaul09mXgGAn5cvlQFs//+61kMqDeEkydDdyh/1MhU8GBtXhFhWSSM2+f9+YfOSyBke+qxp0pf6tZtR/sV8PGmBM=
Received: from AS4P192CA0027.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::17)
 by PA4PR02MB6989.eurprd02.prod.outlook.com (2603:10a6:102:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 11:23:27 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::98) by AS4P192CA0027.outlook.office365.com
 (2603:10a6:20b:5e1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 11:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 11:23:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 27 Jun
 2025 13:23:26 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v2 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Fri, 27 Jun 2025 13:23:04 +0200
Message-ID: <20250627112306.1191223-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627112306.1191223-1-kamilh@axis.com>
References: <20250627112306.1191223-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|PA4PR02MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 65225c78-0e62-4c4d-e99a-08ddb56d095a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGRLb2NvcGhPNzJLZ0Q4SkJMS1R5M3ArN0hiMW1NdXlhZ2w4TWJFV3VYckI1?=
 =?utf-8?B?cTVwMlg0ZkVjaEFnTk9wN2hqTzNkOTJZcWltdWFYZ2tuejU5SVNTZ3NIYzI1?=
 =?utf-8?B?YkF5NXhFUWRzOFVwNW9QWXhiNWFTZ1VXV3dWNElvNm5rOHMweGVmdjVOdHhH?=
 =?utf-8?B?M1cwY1FZZUh6bkRvM29wRGdpT3p5Njh2SUN3S2FpOU1FcXJkN1U0eVgzVXJV?=
 =?utf-8?B?RGw2bkk2OEN1ZjRSWWwrOEt1SmM4aUJteW5uVCtGU2VFYzYzQXlYTFlaQXZD?=
 =?utf-8?B?WnlDcDBUclJpakh4M0VUM2pIcnhibmJkaEFWWU5DNzJ4a1BZSmkrSlRScWRs?=
 =?utf-8?B?YmRBNTk4cWVFTXpBOGV4bFpaZXBtYTZySHNiQ09yMm5nM3lMVkpRMlJVMWxi?=
 =?utf-8?B?clpEODFsN2VRSEhBRmlNRHVKa3ZOWW5kVCtHS2FWdUJMT2J4MlZwYXdZY3ow?=
 =?utf-8?B?N25XbnVEZjA1bitQUjZ0QXFUajl2OHBYVTFoV1ViOC9hVVFadWVMUlpXdC92?=
 =?utf-8?B?cjV4aVJYN1M5eU5KM25wdkJsNXp5REJYUzFVNUUyV0UvSHk5aDloN2wzMWI3?=
 =?utf-8?B?UWovZnFrSnlOU3ZpRGtrS0swN0FUdzVOdEVzMTBzK2NUcGgwb2VPWHUrWGtH?=
 =?utf-8?B?UWdLZ29KMzA3ZDdpc1M5ZXNHQkM2eDdlS3hNbEE3cjh1R1QrOVdnK0tpeTBk?=
 =?utf-8?B?Mmx3YWk0VHZJWFJHQTZ6OHZ1eGptVkJ4MXFYbmZsT1ViYUZFNmJqdGovNS9H?=
 =?utf-8?B?ZDZhK0ZwYzRZZWtBeVcyaHFNMzFRZUNwY3JVY0FNc0VlZjFZRXhoRWEyWFhF?=
 =?utf-8?B?OEgxZ1laQi9ybnZYeEs3NUtoYmE5cEw4M2pKOGdTRGVyMEJNNUlzckliV05Q?=
 =?utf-8?B?aitBNjRTYUl1V2NobklrVk9CeUw2Y1J3K0JvSDRqSWh6MEZ3MU1zQk1OeCtQ?=
 =?utf-8?B?S05QNCtSQ0RtMWhWeG1iQTh0NkI3K3lXVmNTR1B3aXFQOWxSTTJlU0lYN2dr?=
 =?utf-8?B?MW1lSUpPRmsvMkZLNHBoaVk1ZnExckhxajh2aUFrbEZHNDlCYURqS2w5Vm5q?=
 =?utf-8?B?UkdLdVFKOE00Z2ZJK3BCZnliYzV5dmxORkphdjcvWU9SYWlmMjFVckpFb2dy?=
 =?utf-8?B?WDl0T2x2Tm9CYmxmenRPQXNhZVhLcDh1MjkraWhNdERKN0xEM0I0aUN6OTVV?=
 =?utf-8?B?MEZ2eFhxRXlmWCtMTFF6UGxiOE12ZUlSTlZaQkJRSlZQck1uanN3MDh6aE1y?=
 =?utf-8?B?c0VGc1l0TDBaQy9BVnBTaWFpSm44VW4vaFUyT1BrRWxrNTlISjhOV3FqcXZV?=
 =?utf-8?B?VUQ3UkgySFRaQ002WENVNm1lRFBBbWJ2ZXdNSEZTSjNVQjhCSUxZMkZkME1K?=
 =?utf-8?B?MVN2azZyS2RUdXRkcmpFUk9mRVd1MXZ2MzRjb25vNEQva01ESzh0eXk2T0lj?=
 =?utf-8?B?aktGLzRrbXF1NDhPWWJ2cU1jUndJbHk4bVkvOHZtRjJyQ3NUS01YbHJDWkM3?=
 =?utf-8?B?MW5UKzJtbU5ESnV5RzY4UlNyMmFhb3dCNFVUN05wcjJWT3JwL29CalBEUkR4?=
 =?utf-8?B?VzEwM21VbSswSmdaOForUFZFdTlJdFllbUVreDhxQmtaNENhcW16MDBVNWQw?=
 =?utf-8?B?b3RzTzZBSVYwVGVJQ3B6OEFlU2pPRy9TMVBWYzNZWUQ3UWRYQ0syYmhvamZj?=
 =?utf-8?B?eDZaSVFoMmhBR0dDUTh2SXUvdFFnS2pVN244eHlRZnc2RjBPME93UUp0dFJE?=
 =?utf-8?B?RFFhSlM1eGNZYjYzK3ZyZXJoTnhka0dXZVI1Y2dXMnpaaVlqNGxnZ1JGMFF4?=
 =?utf-8?B?TXh2WTBmeTNZVDgwNm1YTGVhbFROaEU1a1E4LzZmWWN0aVpjNUl0SzhNQ3hC?=
 =?utf-8?B?dkY4WFVMRjdQTXQ1cURvOURQWWJNeUFYdmQvcjN4SFJCY3ZZSisrWGlkR1Bo?=
 =?utf-8?B?NWwydUloK0N5akIwdmhqOUZJR1h2VzFxWkJyU21ldGpTQXB2b3BXTDJaT01U?=
 =?utf-8?B?OFhQTkZDVEFrS05OS1RZNWNtTysvQVl6K05pbmt0UzNuL0NZUjZ5V3pTRDV0?=
 =?utf-8?B?OS9VWDl2Y1pUM0VSNExmTEJtWURNRHFEYW12QT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:23:26.9071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65225c78-0e62-4c4d-e99a-08ddb56d095a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6989

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
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


