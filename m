Return-Path: <netdev+bounces-202385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B3AEDB03
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F623B8B75
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32525743B;
	Mon, 30 Jun 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="h/J4umIS"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEE231858;
	Mon, 30 Jun 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283059; cv=fail; b=cAdQgKkO8Bgeh1s0BB5d7S/WASFKpiftVg3Cz5ab7GgApEIEj2JmYtXroQqmmF8cTCN6M3OgYiS+/Rg/N9ZOZZDAporS7+8CRQ09EFtlYOMmlWwTGZMKbEd529MEIaLUdeWCZFANyquMTbrhpQ4nnmwcjmuLVTggYjt3ffauVzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283059; c=relaxed/simple;
	bh=KiIbifbixQcG/JBkbf4WKrEzQYqst9RQExjTLr4Fg1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dOoEPJmm8eqaRjSajzRbY8m3JGphfeGmK/622E4/vq9LvHIuFN8WziJCNLEmk6977YTvH6KL5d645PuhUrj6aHDNPNjhN46yiZksGYjudUpXDkBOBLFQyUySbKBW5R7I/fnyF5uYNH2/oRVcQkllkhf5yqP3afPMGpzXgO26Fp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=h/J4umIS; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxpa5aVNasayINaKfBLMlgdrDTmKg0DdzzNSk6sclqzNuAeLSNRBeCmkAjNWK0+HmTJI+zP/n6sr+cagBG3b9bFVs4iBabxR3/lYLbFrfRIEXkX6Y13O7sl6XsEigS/nzEOzu+PNTNTBz5SEUiZhRNYWbfJhRyD80ynzW7EAVInjOZtx7Soepl/yJ9ZMqRkKqylP86XuOBm7Zv9nrgiESWb9GRskbVnI9BCV15GQbV6x75ZEBoCU29GTgiynxBfzqZeHWW3VvFWPi7tdJxuUTIwPjYs3z2ZPEP25PtMcPmZbjwrbHXKwgYZgwdWpRWN7mVg+vpJpjkKJ82TAJNDXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow7NKXsGuVhjBtaukSiXs0U3ynFs+EKO3pdSc/CK+oU=;
 b=h3qYs492I2/ea8TjY3alVcFkglXuBwHdlkQm9Kixy/4tyDusGrWkA9SRIN7zMeB6af1J9zNe1Rw37hFrQK/d2Dgo7f03z0POOR0E2SidobNsDkWGgW36ADIifxAh0NcL7K+VVWNbUAKVAEghBq0hLKSmhA9/Pq7Av7JWaS5DNkwMI9+4GyoqkOHmqGnYWBSDIF0A9O5Ii6/nmzVmGKmNWrK2Qt5TrUy4GsZW6eXKQR93d/SAJq1+yDkBCmsBvMj+fOTuR+7r1VmEC9Im6HEqUssd5FhkallKbyzBjbdmvnO4AsTQB1b4mrpxDibJb0wg9/Map9vutFtOAKJ4ESj/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow7NKXsGuVhjBtaukSiXs0U3ynFs+EKO3pdSc/CK+oU=;
 b=h/J4umIS9sHHwMIbzIkLfYJVw2uo7nLSIAS27vpv20ruR9PHFLFtpUb55nCJvnWpLnb4Yb1TljgswOvqyfxzY8TOpbccqRLOOLcuNypDv+DVMn8zYaeXYZLiVDj6Xyw+9M1ZcqCy1K6nBDweSZv15tHB1C5WKFlxHymE2tyBGAs=
Received: from AS4PR10CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::7)
 by DBAPR02MB6134.eurprd02.prod.outlook.com (2603:10a6:10:18c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 11:30:54 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::5f) by AS4PR10CA0017.outlook.office365.com
 (2603:10a6:20b:5d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 11:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 11:30:54 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 13:30:53 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v3 0/4] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 30 Jun 2025 13:30:29 +0200
Message-ID: <20250630113033.978455-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|DBAPR02MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: f8167624-5b45-44a0-cd46-08ddb7c99334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFRDSWx1THR5NGp4Nys2SkZNbnc5WEhYa1FjN1BUWmV3ZXVlb0NLUnYzU2pl?=
 =?utf-8?B?L1B0TXErekFpdlpNYllTL2VjcENFbjVJVWF6RFgyRWJNMEFlam1oZklEZmYy?=
 =?utf-8?B?Qy84bkpiWVVOZlVGQ01nb0kvTzdvaHRwbmlPZGl2dURsV05jTUxFNUNETG5a?=
 =?utf-8?B?MTV5TXVNOUVZUWwzZ3FYZWFVZ2Fza0dCK09GVldvVE9RT0xscUR1MnZwSFdK?=
 =?utf-8?B?OXBYVUluZDFoZXdycHQyQ1kwSjRQR1hIZnBBb0JZWnNKYmtrZ09abjN5cEc2?=
 =?utf-8?B?R3dKcTgyTUdvZ0ZKMXk4NDZaQ0Jva3Q4Wmc2TGhUYmt4RmhIY0FRQ2lwN1p6?=
 =?utf-8?B?WHA0RnFMc21tdzRCZGVwMkNiZVlYNVp2ak5WMStTVEpWMmRPb1VkOHg3M2lT?=
 =?utf-8?B?TWYzNitDZTZUZ0lDdllqR1JrMVoxaWxsNGN5REJSKzd5YmtDTE5LZlNlb1Rw?=
 =?utf-8?B?bHEzUGZMQy9hSmY2VzNXVmxuZVlYVkx0T25MZ05yWkxpYVgwWTFPMWtMQ0NI?=
 =?utf-8?B?eEE1L0FZWE9VV2txR1F1dGZZSjdGWXhqYmhTcmZFWDU0SENWVng0cklLaW9G?=
 =?utf-8?B?TmtsS0hWNnp0UzczRjZNUWtIN296cWFLY0NoaDlPYnNSVzI5N09ZRmtxUlhP?=
 =?utf-8?B?VnhpUjVrNE1FRysyeUFhVjViU0QvWEhhZ01HdEp0eEdkSWJZOWh1VWlJLytW?=
 =?utf-8?B?cElubjhXQ0hOYUlnZ2xhU2liMlVoQlkrQ1VuYS93V1JTdFpmT3JIL3JuWFBr?=
 =?utf-8?B?L0gxbjFRQmY5OE9mYTZFMVVxbitvamxBTnpodjh4TGNOSGxXdk5wZGVYUkwx?=
 =?utf-8?B?aS9OMUxpc05kV2VEVUc0dVBtQ2p5L2lyNGFPRHRPem9LaHdBY1FOTHJiOXJj?=
 =?utf-8?B?ekpKK2dPV2UvQ0ZzYUFVWEdKWk1qckZQNkxiejRoSXZGa0ZXbUtOZEhoajcz?=
 =?utf-8?B?UlRaVnprQkxUM0NEK2Y2Z3JKZ1llUXUyWmdodWJRUmRTaTFjeE9vcjRLUjYw?=
 =?utf-8?B?TTFMQXZtZkdQWEJyNnppVTZvMWZvWURLVGI2TWVObm1vb3N4SlAyUTVIUEkx?=
 =?utf-8?B?WUEwUms0SGVCak9UMGVab3pZYUhWQnQ2SzdSNmJlWm10VVNtN0hyaEo1S2hC?=
 =?utf-8?B?N1MvSUVveEU3TkdXZC9uWDVxeWxTcDFKVlpURHRTS2xUZ21XaGw5elZLQVlD?=
 =?utf-8?B?dlNha0Rqc25LUTJGZTZ4WDRYQldEYmF5SDNXYjRGNUI0NnpsT3EwaXJBSnp0?=
 =?utf-8?B?ZUpoUGkxMW50ZkdkWk0rVmJOSGZyalEwTDlJTU1Td0Z4U2Z0VkFhajh2ZWw0?=
 =?utf-8?B?SmN5YWxKeWNHYnN6azJsbk1NT1BvdEx2NHh2UnE5bEg1QlRjN3dzVlk5aVcy?=
 =?utf-8?B?clF1bkY1RE4rVDUzNmlFN1crQ2NURmNZWjg5ZGlqRkpUaS9jTlIrZWRpN2F5?=
 =?utf-8?B?UnFtbDVSYkpJRWluTTlkcndibW0yeDRRaGlQVkpDVU9kcVlRbGhKQ3lQZ3VG?=
 =?utf-8?B?d2R1OFZnV1laN3U5Qlh4azh3cGdTRG5FcXNMVU4xS2RVV2RKOTNjcVRKTGlU?=
 =?utf-8?B?Ky93K2s0K1RTdk1RUTZPcGpvQ3BjSkxaSlhEZTNCVHVha1Y4UFl0WTh6T01k?=
 =?utf-8?B?aDJpTDJEYnJLQ0RrZEp2bldaUkUyUE4vRXEyd2VucC8zeWI0UFJVV20vZy9y?=
 =?utf-8?B?MzdoUW5ZZ1BHQU9QYmk0ZTlSNm9wS0JyL0RHNThtVDFMYlUzRHFib2E0R0wr?=
 =?utf-8?B?Z0NsM3ZRYi9BZUJQSXhFR3FaQnNYc2d5TkhRd0R0TE1ERmZKOW90RFhZWG5p?=
 =?utf-8?B?bnMyeHo3bXlMQlhPVW92bzNXYVQzSWpIZjdlOS9SQ0R1Q0h2dkEvNm51YUxP?=
 =?utf-8?B?K05PeG5Da3JKUUZPcmhDNWNFd1Q1VHVvVnlNejNYbUtzVFo5enJJWE5tMTBI?=
 =?utf-8?B?QlFlMElDQU9hdkptN1d6ZXNpZTJRT0ZHMnF4Y2NsaW5kNXV0ZTZEL29nZGFu?=
 =?utf-8?B?YnhtR2NieVZERm14Um00Nkk0RGU1YjkvVGhQVTYyOVN1djVXcXJ6L3BTaHNp?=
 =?utf-8?B?NWVoR3NtWjFLdDAxTWdRNE85Z1p4dnpaS1VUQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:30:54.2087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8167624-5b45-44a0-cd46-08ddb7c99334
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6134

PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
   their two-wire PHYs. It can be used with most Ethernet controllers
   under certain limitations (no half-duplex link modes etc.).

PATCH 2 - Add MII-Lite PHY interface type

PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
   PHYs

PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.
   Also fix the LRE Status register reading, there is another bit to
   be ignored on bcm54811.

Changes in v2:
  - Applied reviewers' comments
  - Divided into more patches (separated common and Broadcom
   PHY specific code)

Changes in v3:
  - Added MII-Lite documentation


Kamil Horák - 2N (4):
  net: phy: MII-Lite PHY interface mode
  dt-bindings: ethernet-phy: add MII-Lite phy interface type
  net: phy: bcm5481x: MII-Lite activation
  net: phy: bcm54811: Fix the PHY initialization

 .../bindings/net/ethernet-controller.yaml     |  1 +
 Documentation/networking/phy.rst              |  7 ++++
 drivers/net/phy/broadcom.c                    | 39 ++++++++++++++++---
 drivers/net/phy/phy-core.c                    |  1 +
 drivers/net/phy/phy_caps.c                    |  4 ++
 drivers/net/phy/phylink.c                     |  1 +
 include/linux/brcmphy.h                       |  7 ++++
 include/linux/phy.h                           |  4 ++
 8 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.39.5


