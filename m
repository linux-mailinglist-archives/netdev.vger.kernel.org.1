Return-Path: <netdev+bounces-103233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF76907385
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8BB1F245FB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CD144D1F;
	Thu, 13 Jun 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rJ6gwIT2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89E146A81;
	Thu, 13 Jun 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284883; cv=fail; b=Oq6WZGHdJUHFPiKId4BrCJmcNpyXvfoIYqRd0KEz/ALQGKxohoFn9SQNzvhNqkiCpO43QvkRsgOHm2edqWVSvPOG50boVNyHDRo2SAD6zjMVdFG1Lac50VbYjHk/Ifr3VwNKG1ejZiLzmDw3mdKspZg1rZpnYyLWUB+cwqiLQUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284883; c=relaxed/simple;
	bh=cwMzZ2m1dn0C9rY/2h0EsG+79CnYazYIlygrMQT/FSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNRCmXnUdZRktibrmHlj0ZJc2gx2Z0QTVZR6Gs9x6jctNB9FBywixSkcc/angBGM6uTllEmHUMACuOmkkR1HDddqO+S99vRJI4o2irzrU5KmBER+swkD3nEtsX9X00KaAydUgG9OkNKywUpNp8LK8+i0+zYawj6XVsBRud7KdIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rJ6gwIT2; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeErG+fI3D1SXMfrrdG7DM/Cxv4HvXgvXZE5p5sGXS6IUVhGfB1X2eABLsFWTT2GmQz1W2POkucTBf42EroVv0x/wQYsGrRhoihXm3EkKvfwSsGlOuTZNk/PW6bERT7zzDmrgu75NTLYoxPz+BQ3tVjj1VXHKun8o2hz88Xu7Iwh8/XDDqXOaPntiizbqbXleUsoEyu1nNP0t6tMers9W7hf1VM1BE/NTCy+X2MpcOpvBpndCSz/RKCoK6gQlF6lG99DipJsdDAPe0SX16k2OZdCEJ15YD7oesJuv1wrrvuskkFNc/5SpI8mpZiQLco1rZSZhaguVM7pwQupOQg0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=DY1eO6EmujMepzBJYnNIqFxtunoaMKmPxyw460dkKM8ArqM73d1XwAIaTjjQmhXu8GpyFiSkfU9Ik/TkF6/f2bPLvv8VDmf+iPjDFlitChDVfjAANaQEwpjye2mBJuhNTkyYoxFRF41DLPKORwcBMCIbW74bVkOn2BrBlPojuQ/1OGK/iIS+4/jcrScN0Tg//Hj9gud9k1e2cCllR/KtCkph3cUY/lmrhPvkoFlgKrLLFi/U40sbt8IdaMJWvAGxGNejBYv+s01TrCPqwv85NAadW+N6YcWlwmxLvsXJSkXZl5R5Gx2tFodi1CIZmkys/CIxXuhKXMFFbV6v8gbyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN2dOLLQhedQOncCwIWhdfCtJiOCA4UAEPCcB7/T4m4=;
 b=rJ6gwIT2U+mTSsZJvwn3+vUPdX2dz0Wj/ZGPJyk8DQZ9wkSs2jF+xJriuvuxSMfJr2gsxSoHQfbix1KWjAT0KPOsY8idPADvlcsfq0OY82i01ylIv0unAmxHSEXok6I+n0FceS5M7yz99olk81t+l8VAaM9tz2YgIoiGLGJ6pzw=
Received: from DU7P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::14)
 by AS2PR02MB9262.eurprd02.prod.outlook.com (2603:10a6:20b:5fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 13:21:18 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::75) by DU7P195CA0011.outlook.office365.com
 (2603:10a6:10:54d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 13:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 13:21:17 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 15:21:16 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] dt-bindings: ethernet-phy: add optional brr-mode flag
Date: Thu, 13 Jun 2024 15:20:54 +0200
Message-ID: <20240613132055.49207-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132055.49207-1-kamilh@axis.com>
References: <20240613132055.49207-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AS2PR02MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b31a580-fd2d-4c38-4f9a-08dc8babb571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlhqYlRqTGdQbzlsTDZhUTR0WC9rUHFvb1hObWt3ckJhKytwamJMTnd2dDBr?=
 =?utf-8?B?MnpBYnVBakZjVU9BWDNmSk8xRTloRzhJS214MmJVVmhmQ0N4RUZ2ZzJIQUQ1?=
 =?utf-8?B?aloyeEVzaGp4WEtnOTltbkVqMlMzNS94NzlWQUZUUStGcVQ3MXJ1UkVnd1NB?=
 =?utf-8?B?c2V0ZzRNWkRIbEFLVUcvejljdVRXYVVVVmpWdGVsOTZuZmlMQ29ycDE1cHQ3?=
 =?utf-8?B?Um1BVDY2ajQxYVBPQ0xadkFJdFAvWlBsaHg4UnlEc0p4WlQ5UDQ0S3pwazJE?=
 =?utf-8?B?Rk1iRVlQeEtuWk5ibWMySUI5a2RubCsrUHVIWjlydUM3L0YrZnhJdkQyLzhx?=
 =?utf-8?B?NE9kb2ZhR3ROZG1PTWcrakdxNDU2QkZ1eHA0dFFMajAxc3N3bTFpVm92NUhO?=
 =?utf-8?B?b2FuVUxNMTAwcEN4RjlmU3ZwbHREUXh3d2gwNXBhZmd1R0F3VThSeWhlbE5Y?=
 =?utf-8?B?UURSZGV4d0xTZmNhZnd2VG9NQWFIRzZlcDFvbUUvMHVyM0QwVEVFeExPUkU4?=
 =?utf-8?B?aW9UbTQ5bkhOMWJISktsVUpBejBmbGMrWC9xWmJJVm1BYXc0WEhTN3p0Vm16?=
 =?utf-8?B?YzV6QUEzbHAyTm9WakNiWlBQbEM2NjhSYTVEVWF3eFZIeEZ1eEZTbDZmVUJ1?=
 =?utf-8?B?dC9zTEJ5dTVjdml4M0UyOXExL2FWeHdpWkFROXpZQmU3Tjh2aDFFMzVhclJw?=
 =?utf-8?B?Y3JxcVFsQ0s0bmhoakF4VjhqSG11UElKVmRNb1BnWVlZaEJJb3I2Mnk0M1pV?=
 =?utf-8?B?TnNjYkxVbEpkc01xWWN2VE9xSWJxeWM2SHVrdm1DWTdrbGh6TWNZalZDL2pp?=
 =?utf-8?B?cXc5VVEzUWEwSVBGRFpSVStYSDEwNEgyRGZqSHFjRXEvSTFVSlowWjdIWUlH?=
 =?utf-8?B?SkJWRWZKdTFTd1B3VW16MjRWSFRTNzR2TWExbytUOEdBY1VIUHB4bml1ZDRD?=
 =?utf-8?B?Z0tKRW51NVVGMDFHbFZyRFU5NDlKZFJzNTUwdDJKZnBuZXBXVzFwOXVHWngw?=
 =?utf-8?B?ZVVMdU5lSHp5bFhNVnorYVErSFI4SGpsYi95RW8zR3FyR2NOazZtR1JROFk2?=
 =?utf-8?B?NkM1Y21WKytGS1pabDBoS3NyVVQ0ejlYWHlnY0lNclJ0OFN2M1pabDQrbnor?=
 =?utf-8?B?d005N1l5eDJLSkU1M1JQVVlLcE9BVVBCLzJ5Z1JHbkIvaEFaOGcxY3hhdXZO?=
 =?utf-8?B?NmZRc1FvT2xrbkloaXVBa0V1ejU1c0xOK1U0NFMrdUhMZ1hKVHdaM0FzY3la?=
 =?utf-8?B?K1VVanorL0ZETXpQZHZuU3ozYndsaUk1QWNubVptblZxOUlMdk1KNVhYdity?=
 =?utf-8?B?djRWaExNZ3orSVN3UE5KMEpLdm8xZ2s0azNETkE1eHcrZDE5M2ZVR2tUNGVz?=
 =?utf-8?B?Yno5eHhnUXpjQjAzNzZKdkZsdThBMk1aay9jTlVtWHc4c2hwMGhXZ1lxU0ZT?=
 =?utf-8?B?c3IrU2hCdlpUajhZNXM4N0YxQncvNnZZbTY2ZHVFbkxOb2JmWEVJQjVVcERD?=
 =?utf-8?B?UVZacUp6M05OYzFRRllBZDMzWStiemhSZTQ1MmUyT3VWMXRVWmNPZ2thWUpD?=
 =?utf-8?B?MS9oTXcrV1FFb0l1ODF5SlE2YW1JMlM5T1RQYWx5RDFsbVBMcUxZeE1LMnVh?=
 =?utf-8?B?UGg0SE1zOHBLa1pRRndMZGJmUjE0UFZGNzdXTDZFT0E5N3l3RTJ4NWRnZHJm?=
 =?utf-8?B?TDh1TnRRZUcyZmU5RFF4ZjhnYjlnRS9jWVI1MUpkQjB2SDdNMmRrM1MxdS9X?=
 =?utf-8?B?Ry9FMWFzUTFyK1FQQnpsRUl4U1Q4STVoR01iTTlETUgrcW5pdHFQR1AvZW5Q?=
 =?utf-8?B?WG9DRlVWN2I2VFd5cVJBTjJneHg3YlFHVHpPTjZCNU16ZEJHbFYzYnBtbWl2?=
 =?utf-8?B?TTlUT05NZHRPd21LNmI2QVNKZXpESjhkZG5CWFdHa2M4RFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:21:17.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b31a580-fd2d-4c38-4f9a-08dc8babb571
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9262

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


