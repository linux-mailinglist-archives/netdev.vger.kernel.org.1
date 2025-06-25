Return-Path: <netdev+bounces-201255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903DBAE89FF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C9F1BC5314
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FF2D4B67;
	Wed, 25 Jun 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jPRpw1iN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AF1519B9;
	Wed, 25 Jun 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869315; cv=fail; b=TBkomTUjK5i0xzQcAFTY8vP6Zkkvq0Uenyl4aSy+vX/bSe9jJYglzOovbqxGinK6249ef7DzRODjkOOdNquCHfzTeNOY1uqFDMsIsZU1usRF/mXJ4Jb6gtWp0hDH0Jf8jw097dxwQ0Tn7qYzlwtGZ/jMUFOEX7A/a5sbcpieFaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869315; c=relaxed/simple;
	bh=f6ueYflTePA/vTjHC4InMQmmmnwzqNcgZ+10zbZvIjg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyRT+YtKgeVutVFEoKN//KMHnAkTuJkF72N0Or2OdabAFN3/0mRbf3NAPQlmkwRrVFHmxuSjqs+0rglzpdSGGpokyALq8WU7+Cw0fSh6M1jtS40yh92T+Nl+Edqvg2ZKA2TU7zeXlQr9wjAICtNCJEbLXNXiWalWFUFRjE13EaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jPRpw1iN; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOXXe1yobso5h8e+jEkt8VSArtFZRACqPg2R/VbyeiAyLoJo6Ocr8BvC2cv00hGUdIOAF49XY514dzucjcXK3PHcZaIfkZLVb0KqZylqv4AB1IKy2cTlY8mtG0oahwDsYpRR6AUvDTASoO16H63H3MdbzK7SfR7TVXO5eGkfVOa6SXr4e597QFVJ1DgOZ9rezJ/37mUf7wYeVn2urrSO8EsqCrprczdOiJqntYmJBNwFL5neUp//mN7Fu8K1Wd+CcRpI/+zl6QQRcXoS3/g56LWLS4q0kvfJJVMdfexE2tTDqvya98LVPvja8htEzJVXusb+hWBESoYA3su8eK8qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7rxyiSGQXyMOrKIECUj6XNM3lQbjilcip/I5LBPoro=;
 b=r7CSJm0LOIwXphyD2voYr+sG4NiBoFqVmCc+OcvKBNi5BajRJk7omd1Ezv2PsMUG95Kwf/jZdzY43GB/yWDpuqX/I41RVIdvMtbWecHe859Z6WVzZ5ng6Bawmf1R7GIYiJZH6XGUhwvizmPw98WzrvW9rtnibwLOT91yuiYkNQgJgXv1ljayPEDB3zupOf5+2w3m4phXo/ns6k2DOgUHiEe1VLxpAaoZhJZLpSHNgmHYQ08sVLPvO8UynJbhyNY4VjbidqaPOFFmk/J2R6xs6h7QVE7dM/lN/qoJpJ9CWsxuUF1klpjSF/zf+c4NUKCtz5iX/c3SbWRpfyb9kOLfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7rxyiSGQXyMOrKIECUj6XNM3lQbjilcip/I5LBPoro=;
 b=jPRpw1iNs5CPan0utPycYV3Z8m0RM8kF7kHTd6JO/QtezyOfGa87/9cTmkmelv1IbIhWdz/aw48WetVU5jm1ppLfOipcMexlgnRe4rNuUMXCnhhLAXySlo+ADEU1v5bmg87YMSPy66TCNXD3qYWTO8oezj5cPCpS4PR1hWt2mhw=
Received: from DB7PR05CA0043.eurprd05.prod.outlook.com (2603:10a6:10:2e::20)
 by DB4PR02MB9311.eurprd02.prod.outlook.com (2603:10a6:10:3fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 16:35:09 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::c9) by DB7PR05CA0043.outlook.office365.com
 (2603:10a6:10:2e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 16:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:35:09 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 25 Jun
 2025 18:35:08 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>
Subject: [PATCH net-next v3 0/3] net: phy: bcm54811: Fix the PHY initialization
Date: Wed, 25 Jun 2025 18:34:50 +0200
Message-ID: <20250625163453.2567869-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DB4PR02MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a9768f-2d15-4e22-b53b-08ddb406401b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QllQajErZkluN2NnQXNnajY5WllUa2R6RWcwZ2I3Qzl1UUtFZzdNaXlScVpu?=
 =?utf-8?B?TTd0bzhyTEdCTDc0V3JnbC81eHAxbnNoWjRlb1VCaVp3aFd1dzU1S21KM2I4?=
 =?utf-8?B?ZVl1QStOQTNDR0VTbmREaXhESHRCc3VXUzgvL3FzUldOU2g3bFhVRWxwMzFH?=
 =?utf-8?B?dklqV2treER3bUdDMnZkY0x4WXE3WXg1N1NqQUl1aGx6ZEE2cnl6UitEdjd5?=
 =?utf-8?B?V1BFWTUzQ3hkRVlPeEJYNHJXVjJIK2pJQWZFbU1pd21DT3lSbHVvem9lcjc0?=
 =?utf-8?B?ckIwVFFYMTdhTm9Gb29tMDkyVXBrQ1JoNzFKaHZ4c2tUZXhjelh6d2RvemtJ?=
 =?utf-8?B?bTlkMTUzajU0anFpM3FDcVpienhxQ0xEaWkzT3V6UElkQ1RyRWZmV200M2JR?=
 =?utf-8?B?R0NycGFmSkJTSzZqMUdWL0U3c0JBUGd5MFJ0VkVTbjJsT1JkZmlwd09UT2x1?=
 =?utf-8?B?MThmMFdGY2YrUEkrNVk0aVcxOGM0RldYOElDUExKcmgrMndkMktjd3FFdW9y?=
 =?utf-8?B?ajVlSmxEY0EvaXh2eHgvRDhnWTc1WW1DWnpMbm1IaE1GbVJ1dEp3OWlRKzNB?=
 =?utf-8?B?M2lUdmV2bktVOWwzdG9RWi9OUDBLeWZqVjEvQlZla2FDTEEwb01MSCswRHBr?=
 =?utf-8?B?aWNMampDNVlHZUZ5SndubCtGaFdpRGJRYjJBZ0x5RWkzZndDSkx3MVN4b2JC?=
 =?utf-8?B?WHBqS1phREYxWXF2bTdSVG91NFloTnQ5TXd1L0dEeC85ZGMyK252M3N0ZktT?=
 =?utf-8?B?Yk9KSmJWbkVEcHoxK21QZnNDaFlNTmFlMkdyQzRVK2loODdCeEcyM2tRWDd6?=
 =?utf-8?B?YXVwZkNJZUc1UFRzOXFZOHVYYWlBckIxVy9TSm1WQmRTaFVoR0p3eXdITW9z?=
 =?utf-8?B?ckhUalhla0g4UHhOa1YrQUwyU2dLWlVoL0d5bGlHeHY1QjlzcVJFaXYwSG5M?=
 =?utf-8?B?dE1jKzVkNlM1a3ZFOThCenBGRFgzL1h0dllmN3Z2OUM0UmpyZnY3SXIxNkxS?=
 =?utf-8?B?UmhkRWt0T1Z0eFl0THBZay9aUEo1OHJyVnFaSzRtZ003NFZkVWNoc0NqWisv?=
 =?utf-8?B?MmM5eXArZWt3ajI3eWszS3d2bUxTcEswZGhqWVBTTUVweW5IU0ZIWDkzb1I5?=
 =?utf-8?B?dmNaVVRYYTk0SmJva3JiREptTnlIRWlvdHZLMWZuZkR3b0JXVThOTmVMOFJN?=
 =?utf-8?B?b1NRclFpVmJ0V1hnb3NTRytUaFZ1V1h5cG9kZWVvY0V1N0l4dWFZNmFYK1p2?=
 =?utf-8?B?TWdCbFdrN3ZWZXJyNDl6Y1dxTENsT0F6Q3l0dDdYc2lsWlRIc3pCRVJlYVZv?=
 =?utf-8?B?NDZWZ0FOakM1U1ZXRkpobnlRTy9obHp5dHlFMVZ2VU9KWlZLRVBURzdQQWhz?=
 =?utf-8?B?R1BZZzZHVFBENTgya3R0Z0FCWG5meTYwNGVldUN1NkdkcThhbXBVL0FIcEUr?=
 =?utf-8?B?UUxSQSthT3lBcHRlKzVyNVRqUkQrdkU2M0RhTDBFeG9XWWRhRGFSQnBydWVE?=
 =?utf-8?B?QklzczErL2tvR2FhSlF1S0FoeXlKK1lGVm9mYjhXay9LMjcrWWQ3cEhjUFFs?=
 =?utf-8?B?NU9reHhXeUJpUTdqZFBGSmZVSUQ2b2xHL0dEeWJxcHYxMURJRTNGYUZuNTVN?=
 =?utf-8?B?aU1pSmFxYWIyWEdtaS9zSkwrVk5HdSticVcvdUk3Syt3eWdYZFBDNkFXS0k3?=
 =?utf-8?B?QWIvWE0vSDAzVFgwUmVnTUQvZ1FhRTRFNFZGaGFjR2xJSFNzNDNySmFBUzYy?=
 =?utf-8?B?R1hHWlZzeVAwZ05FTDhWRkg5TUhoeXBVNmUyZ0R1MTc4c0VQeWN3aXVwOXdN?=
 =?utf-8?B?RmVwR0dYVitOTm5sU0NpZk1vZmZvWk5IRXcrYTR3a21qQ1lSWGI5b0xpazl0?=
 =?utf-8?B?aUMyemRvUzJDR3RqQmx5TzJuMFZBQ1NtbjNDb3J6ZlhGd0Y5Tlg1NzB4N0RI?=
 =?utf-8?B?WTFHQmQ3RTJkTzhMcFVLeGdlWFN2R0JzR1J5M2VTUUcwRElBVEhWdXJueWY3?=
 =?utf-8?B?ODdWbVB2R1h3RWMxdlAvbHIxQjVpaS9JOStJL3p5ZkFBL3pIYkFpU0VYeFo5?=
 =?utf-8?B?OUhJc0Z2eWJKS0drbUw4dzZnbDNzcGNXMFJPZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:35:09.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a9768f-2d15-4e22-b53b-08ddb406401b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9311

From: "Kamil Horák (2N)" <kamilh@axis.com>

PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
   their two-wire PHYs. It can be used with most Ethernet controllers
   under certain limitations (no half-duplex link modes etc.).

PATCH 2 - Add MII-Lite PHY interface type

PATCH 3 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.

Kamil Horák (2N) (3):
  net: phy: MII-Lite PHY interface mode
  dt-bindings: ethernet-phy: add MII-Lite phy interface type
  net: phy: bcm54811: Fix the PHY initialization

 .../bindings/net/ethernet-controller.yaml     |  1 +
 drivers/net/phy/broadcom.c                    | 30 ++++++++++++++++---
 drivers/net/phy/phy-core.c                    |  1 +
 drivers/net/phy/phy_caps.c                    |  4 +++
 drivers/net/phy/phylink.c                     |  1 +
 include/linux/brcmphy.h                       |  7 +++++
 include/linux/phy.h                           |  4 +++
 7 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.39.5


