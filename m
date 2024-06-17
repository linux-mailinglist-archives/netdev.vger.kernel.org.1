Return-Path: <netdev+bounces-104001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195B90AD24
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C0284EC1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10217194AD5;
	Mon, 17 Jun 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dIXX/28N"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2065.outbound.protection.outlook.com [40.107.7.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02A1940A2;
	Mon, 17 Jun 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624460; cv=fail; b=UiIx4LgwJhXuPgFSeoEJKQ/TU5gMPUiPHD4P/tuJX7wq/902pQErB0OrmF+c7N/Ww1X4NwOmFubLq8jSg8JA0ctflIru4So8nWs8k6LbWQ8z1g+BNx3JyZlrrU/EicsJiFoEB82mLUOCbyupXCmIPQGpyeTQjH9lA6k+CXm/gc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624460; c=relaxed/simple;
	bh=4fvVkn4SnCcZijK1/GP02pJnvJXMdSp0ZFuLlJek6QA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYjzDXkOaRrgKLIhPAV3v5OACR7vtTnlZD1gA5LdRKxIZb0ZfMKtF8gG338WURtvR9i2En//o1n+yJCNd8sD2OXQxwG5nhOxK3eiGtXOIxYjDr4Aec/dkV28nkOvYQDN378PuTB2VA4WbznozZYDHXghFamTl5uk/w1MJawHFN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dIXX/28N; arc=fail smtp.client-ip=40.107.7.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW2b0RUxVxoQ4jBOd9p/L41UpKlPqOgVjZCbFgZkSANjoEKDKDSt3qRMlwi6BsUjDqe4H+t++E4oJqV8pLIk1G4B5+CaosrdqJx8W7rEeYjQ8djYkO2EFXe1GsRYoW81Htf5RKSGQMC5Mv7CCsvr8qq+XLaDoFg0pcE/CcYr909+cAeyc0VlXd9uIShX7d1UAGD4tgLR/Cz0svWAPhq0p0+BhK7e+bfABnqEzdjtdvqbswZ9atgIe4yFNO1dL4I7hqCjMHibzdnZSlFWFANiffadEZhq/jkdTXs4/NkwthbSEQGqEDXXt1MLKJOjH3f+UtFhNK6BLWT9Ti99ykKlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQMg9Qoet3qmMWphji2BwHNNLwLYA4lU+6FIKIhqQr8=;
 b=Cj91YgevaxhZrc8EjJldQtYPT75otb8pQzicN0rBFwEt25gykZtKRqCbUjLt2KSF0P5x6GCHkDzbFKlO462s9Fk39Bww7l2ZRTT5lnp/dlf3dibSiAcfbb254yuYW2MG58bUgqz9wfxK1DlShGx5MA7uOSR/SOuEzSsuc8dLL7dYujRzKSqv/kjH3GDQQ2DvASWGzSUIEOGj5A8OBn1YxF7aMTJK7eG68UX+ySlRrcmWNHiROqeOPIlcjXdMACmGGAPRCJR5k0PhNBIK5YWkKqdQzRCfh5NgRUOLniMWK8P6HlhNY80sShgcI6UFoE8Cu1tZ6Ugnv4tsZGbIIfzf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQMg9Qoet3qmMWphji2BwHNNLwLYA4lU+6FIKIhqQr8=;
 b=dIXX/28NTvf5UvhIzclbywndAmwOWB7ogOoRFKqwz686KAH8RchYRAcfsJb4k9ozoeLn1QH/shJT8FzBHluIpS9swWmHVJZvS4nyzO/nWi+cJxpuxxkDAFUakM9Seui7qdkYiO2l0Q+S+XvQt7uGykqIytOCHwwZ4MkoI3ozfAc=
Received: from AS9PR04CA0122.eurprd04.prod.outlook.com (2603:10a6:20b:531::24)
 by GVXPR02MB10855.eurprd02.prod.outlook.com (2603:10a6:150:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 11:40:48 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:531:cafe::f8) by AS9PR04CA0122.outlook.office365.com
 (2603:10a6:20b:531::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 11:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 11:40:48 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 13:40:47 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Mon, 17 Jun 2024 13:38:37 +0200
Message-ID: <20240617113841.3694934-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|GVXPR02MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6287e8eb-b2b9-4808-f690-08dc8ec2551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzluYnZ3Smw3ZUJMdnZRSGVVYjdiUENVSXlwM3pjQi9ZOUxQNENSdWxUaUt0?=
 =?utf-8?B?M0VNbVFsa25xeVJiMDRmU09nUHo1MnEyWVdTR3RseGFTQnllSUYzZzRoRHg2?=
 =?utf-8?B?bS9lZjJMdnRvS202SCtWRXpVeDVibGE0Q3BlYUhwNHd2czRTSFAvTWZUK2I3?=
 =?utf-8?B?V2NrQnhUaXFsKzY0YUJQNTdKRFVJWkFXeUdxRmtYOUF1VWVCMzBURVBzbGd3?=
 =?utf-8?B?WmM4VzdLeVlvNVgrbXd1eFVzZ0ZkMUpla1pna0R3bVFSV2YxWVpodHFYeG96?=
 =?utf-8?B?dm5hZyt4YndTRWIxOHV1ZUpDNklBdmY1U2JYb1FYb01KYnBlY25odzd6TUlT?=
 =?utf-8?B?azNPVmk0YUwwSTRwN2hxSGZPUlVadTJFaG1kbW1rTWp1cldGYnBnV2VjT1Ew?=
 =?utf-8?B?VGZKMWw0TUgxeWJsRHFYRjdDc3VpZ2l5VWNGd3RWMGE0ZVBROXhSbnhvalho?=
 =?utf-8?B?M2dDZU1ReThvK3haRGxIdmc4UFZpQ0VJaVJPWFBpVFZIZldSSDUvWm13VnBD?=
 =?utf-8?B?dG1vSk42dW1TQ0djK0xIREhqSmxVdUVZamNqNndUdHJuZHBNcHFJOGs4enFD?=
 =?utf-8?B?N29sOTZUTHNqZXJ2bFNSeHA3d24rN0VLZFVSRWhzM3MrQWQvWGVRckREdTlP?=
 =?utf-8?B?NUp4T3cxZFFFUXk4NGNrdFhZTnRJYTNYVi9QZE04aUp2b04zNXk1Z3JBQkhQ?=
 =?utf-8?B?anc0dFd4S2Jna1pkeGJUcUdRSk1QVFFCTU9ydDNVNDJCbDV6bzV6cGZ5dm04?=
 =?utf-8?B?VlV1OStORzdnT1dHbTRTdVdrNGo2RlFqc2RTWWlUYVB6Q1VaUFNtaXpuRFpH?=
 =?utf-8?B?NTd6ejFoeFZaZlN5ckFTN2t3VW8wdngxS3RjdjcwZWR2V1lXNVZDVCtZV0lX?=
 =?utf-8?B?Z3FTOTVPT3Q2NlE1NzdEbWw4UC92ZWtPbjVJUE1CNkhzZjFYZGZmZ3Z0cWRr?=
 =?utf-8?B?bHdQZVFXWmZSeVBzRzhaWGgxZTN1S3F4ak9CSGZXUDJlWjZwNXpHL2I5d2tn?=
 =?utf-8?B?QkxDMmkzc0VUOVFVSGptZFhCQ1R2Y2k5SVFQZFo0NEVYSGlBeGNJbjBwQTRF?=
 =?utf-8?B?NVFlQVRUODVub2tsSTNEaUE0amJCWTIvdHViSWszS3kzT0xFSk5pZHllTGZY?=
 =?utf-8?B?WHd3SlBIeE9FZ1BhVmFJZitVb01IZUxOM3lGZldZMGxUSjZGVTlGdXdsTnZs?=
 =?utf-8?B?eWhldCtzTG96YWpRQkdYRmFLT2VzdHRlakdFY0dvV291STQyWTE2bkR5eGFL?=
 =?utf-8?B?bko0MGU3STRyZnM0aGc3alEvcmdjUm42Q0h3ODIzYnhJYjlrMWlwTytTMERz?=
 =?utf-8?B?YzA1YVJNYk5BUGh1OFl2bzZUN1JEcXZ5cUxORHZWTXNUMkN2R2FiN0dUVFMw?=
 =?utf-8?B?Z0ZuYWlTTG0zeVpEd3BXbloyWHYvT1ZoNWhtUDlweWdhQjh5cVFGTFNjMVZL?=
 =?utf-8?B?U214NWNOVEtFNGhlYXVDdGVOZmJqZ2FIK1ljVnYzaFM0NXFjaTM3RlVSa2dn?=
 =?utf-8?B?NnJKSWZxMFVPNkJETWg3VTZTZGVRdiswSTZpQzJ0S2hVazlxNDlXbTEwSlVl?=
 =?utf-8?B?RWYvWGk5OVd3V2FTaGlRYUFZM3kzMWFkdnU3MFVlejJKV1hObjlLTnp6Vyts?=
 =?utf-8?B?dVAvL2YwWE1CL0hjTVlyWjlMZXpoTmV1UHhkTFJ6U2hrdm92c0dHUjZRa1V3?=
 =?utf-8?B?WlJleVU3WVg3NWJEUWZWcUlLSHp5VkFRNkxXV2Y0TDlrbTNVdGR3V3l1WkFZ?=
 =?utf-8?B?L0sybjlpQXE5dlE4U3Z0S0ZzU1BLQlh0RGlJRTl4V2ZGWVYxN0ZsUVZYWGVN?=
 =?utf-8?B?QlYwTHpub1pZMFliSEhIUm5rc1p2dHRoUGszN2E3cWFvYWRRVjBEQVZSUFZy?=
 =?utf-8?B?MGI1ZjViSmxicTNFU2E5cHRzbXZwdWp1NzU2emJHYm0zekVDSng3M3hXcU85?=
 =?utf-8?Q?H9cLeIbojPo=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:40:48.2256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6287e8eb-b2b9-4808-f690-08dc8ec2551f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10855

PATCH 1 - Add the 10baseT1BRR_Full link mode

PATCH 2 - Add the definitions of LRE registers, necessary to use
   BroadR-Reach modes on the BCM5481x PHY

PATCH 3 - Add brr-mode flag to switch between IEEE802.3 and BroadR-Reach

PATCH 4 - Implementation of the BroadR-Reach modes for the Broadcom
   PHYs

Changes in v2:
  - Divided into multiple patches, removed useless link modes

Changes in v3:
  - Fixed uninitialized variable in bcm5481x_config_delay_swap function

Changes in v4:
  - Improved the division of functions between bcm-phy library and broadcom.c
  - Changed the BroadR-Reach / IEEE mode switching to device tree boolean as
    these modes are mutually exclusive and barely could coexist in one hardware
  - Made the link mode selection compatible with current ethtool (i.e. the
    linkmode is selected by choosing speed and master-slave)

Changes in v5:
  - Fixed the operator precedence as reported by the kernel test robot
  - Fixed doc of bcm_linkmode_adv_to_mii_adv_t function

Changes in v6:
  - Moved the brr-mode flag to separate commit as required by the rules for 
    DT binding patches
  - Renamed some functions to make clear they handle LRE-related stuff
  - Reordered variable definitions to match the coding style requirements

Changes in v7:
  - Fixed the changes distribution into patches (first one was not buildable)

Kamil Horák - 2N (4):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  dt-bindings: ethernet-phy: add optional brr-mode flag
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 .../devicetree/bindings/net/ethernet-phy.yaml |   7 +
 drivers/net/phy/bcm-phy-lib.c                 | 125 ++++++
 drivers/net/phy/bcm-phy-lib.h                 |   4 +
 drivers/net/phy/broadcom.c                    | 370 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   3 +-
 include/linux/brcmphy.h                       |  89 +++++
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/common.c                          |   3 +
 8 files changed, 584 insertions(+), 18 deletions(-)

-- 
2.39.2


