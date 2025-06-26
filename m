Return-Path: <netdev+bounces-201525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C7AE9C4A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6329017DF02
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2727510B;
	Thu, 26 Jun 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="djOV4F8q"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B76215191;
	Thu, 26 Jun 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936585; cv=fail; b=hkEI7KXBAHwg7u736bbaWuesOkPKRHXfm6wpNWYooh2gnpy9BaMBV1MFXrQW9txkJXdfRWLvqo/9zWX0HJP9ZWRxXjaaw/2ntyM1h6NnzjXXC3krE5eJx8CEXjT8UtFtpDTHRGbcrOT7ZqFa5cYQa5T5bSifKcFVPXCAKGaFk5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936585; c=relaxed/simple;
	bh=f6ueYflTePA/vTjHC4InMQmmmnwzqNcgZ+10zbZvIjg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hdxst0+ZE1j6BdGeute0Xjh5+gJQBXiJqZdOeC+3/qNivKKQ5JhnsO7TkFu0JKeeKGYst3SblIxBezfwdQfUb2eEdLRqIdn6X1XXJ6YavX597EPh29DxQcx1c0YO6UrL69x7MV/OYgTkJ2thf6dUth3r4BzB/Skfocyt1Xi6fuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=djOV4F8q; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnz+PiX4MQEVET99XRrQ2rH2SFO46ljL6t2G+mTld2T5YqZXo0dybSxRwTihVVjtyU7woI/9o7VZxRuNnynwaxMfDdPFcZY7ZsilebRXmOGTuLgu3Nmzgwl4gH9cp0TqYOavPUVXzeDQuY8YwjG4Q7iYpmX6dICkpg2S34lhTS7YAYTroed+xivj6p7rA1Bm+K1V2l9O9p/yYub7Q4MsvBfUebJh7T2tIaF3U7kcvXX1YlpgfP0dBk+j5UjHw/0WqdgYHJgrnVmfca+KR+H2T86qcqPs6XzZ3/GaicSQXxywdZ01Le+8xtNzST4Zl6C0z+ZF6mCduy5hyuyhv7HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7rxyiSGQXyMOrKIECUj6XNM3lQbjilcip/I5LBPoro=;
 b=nmz7dZwbOV45F+V8U7lgAVEB2ceTar4/vBNgiCvoYbccFImx13aVMDDkzIr+jlSejmNjfRrzv37BFKH5qAql+hsc2lnAunlnYYNVk18BNI4qC9sduazw7V6Wz8GjM4SFyz4LT8dxJqMn2oK6N6OC98htPaahF26MddiVG1b6sSvrzicAuY8gDJOLZ3yJ4SfyKNuXwhD41NC/Dcw0E5Nldv/3QTRFokKi74MNwmY6hzWkUjYUo7ao5WYj5jbuDSHi44On6jGOoyt5Cyj0NfnfliBiuBKkcBJeHnpW46cVUvSghiwRjqS3rMqDnq+C/wM4+kA0srE+SuJeU+C903cAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7rxyiSGQXyMOrKIECUj6XNM3lQbjilcip/I5LBPoro=;
 b=djOV4F8qVHZjt8E7wARKCzra0ba3YwXbDraNAfSoO96hp4eXtoSwirnnVF9j2bEk5F62MPrEdvtsnOr4bmAjm/Hxvo2wuVupeVdNIKJ8rJme52qja9gFU2D/0DRsyQsmDBqJriYRoH99IQGJ6HePC7OLtVnKoMjc4C7MrNaE4MU=
Received: from AM8P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::7)
 by AS8PR02MB10134.eurprd02.prod.outlook.com (2603:10a6:20b:63b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 11:16:20 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::d3) by AM8P189CA0002.outlook.office365.com
 (2603:10a6:20b:218::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Thu,
 26 Jun 2025 11:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:16:19 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:16:18 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 0/3] net: phy: bcm54811: Fix the PHY initialization
Date: Thu, 26 Jun 2025 13:16:00 +0200
Message-ID: <20250626111603.3620376-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS8PR02MB10134:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f8d310-beeb-482a-065a-08ddb4a2e04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHl5Y1h5QU11MXZzMWYzMG92a21TWi8xbGUwNkpSYnQxbzc1UjRwbG1IQWty?=
 =?utf-8?B?Z1JPeGJyaXZaR3hwL1B3Sk9BR0ZVUjhqTnByYUQzTElsYkhwaVAydXFpQ0hp?=
 =?utf-8?B?VlErMXl5MjJ6RVJTUUk3NnREVmF1TFA5Y0lTVlQyTjVkcVVlcUhIdG5CbmJY?=
 =?utf-8?B?ZUJjWTExVG44SytPMThxRmJlalFLNW5DeC84dUlpbUVpaWRjdHZKWlFmdXMr?=
 =?utf-8?B?bmFrKzNvS3QyRzUzb0d1bHhPNmZrUUtBN1l3dE40a2J0NlpRb3Z4ZFk5Tm9O?=
 =?utf-8?B?a1RQM0lFZStmVGtRUCtmSGplRnBPdXViMW5vTUlQMXRYcDJEdDF2TWs1UjFL?=
 =?utf-8?B?Mkt0NUt3V25NaW5VcmZNYVRXekZrd2V2Q3FneGpBV1RpS25iZUc5VG5NU2t3?=
 =?utf-8?B?eHN5OUthdGxrSzUyWEd0MjQwcjdCRFJWZlBOVVA0dytwUThsaUlRaHB2Vnlj?=
 =?utf-8?B?S3dmSWtjSkxyVC9adDY5eVFpMG05YXhoQ3Y1VHlMMEVMNStsRCtNNnZscUI1?=
 =?utf-8?B?OWtpWFl3NCt1a1VCUVQ5NVJhKzZiUUNFVXZYc0YyaXprMy8vdmtGVjFDWWVs?=
 =?utf-8?B?Q1ZYSHhoaFZtUEtURG9IbGw1eEl3THdxYnRndGUzUzVDN1JIdmJWd2xmMlpQ?=
 =?utf-8?B?bTU0d05pMW8wYUpBN0NCUHRWekpKMmRxRHZmTEFjQkE0L1hjdEViTkIvZXNx?=
 =?utf-8?B?cDZpemFFakFoZC94UDZSTWVDTzUrdmZCeUh5K1hkR2tSOTJKZFVDYkt3L2lI?=
 =?utf-8?B?Z0NXWm5XUWNtY0s4ZWRjdk5RV2lZNjBHL0FiK2lGRGlCald2czN2VlNMaUx0?=
 =?utf-8?B?WG9VWXlyclo3bW00aHFGQS80T0k2Z0I1bElWdUl1NExGUkhKaW54ajA5ZXNk?=
 =?utf-8?B?TjJscUg2S3BaNXY3N2JQdm1xVXFLNVVQRC9vbmpCaTlNY2VlNDJJZ01WRUdr?=
 =?utf-8?B?OEJGZzZGVTh0UCtKNy9KL3F1cms1bzRaU1hObzBtdkxTN1hkODRLT1NjNGQ2?=
 =?utf-8?B?NTVndWpiZkJHYzdPMnNCSXpBK0VlQm13N0k4QlBlc2JZY2xPQSt1R1RlNklQ?=
 =?utf-8?B?S0hmTGgweWhFT0J2R0J6UEUwc1Rldkdhcm5TZGF2Z2xJWURicHByQnFURHFq?=
 =?utf-8?B?SEtSOUl3V3oyb1NlZ2NZclBUYStFMStMT3JIcUYxRUo1ZncrNmZ1N2xveitj?=
 =?utf-8?B?NGxqVkVrMFhkZ3dzTUcyeVJON2JXRVRIcjZqVHJUZCtoWk9LVEtqUDk2TXh1?=
 =?utf-8?B?NTdjNTBUbXNheWorcUhmREJobnpRVDJ5Mk83RUV6elNVNFJzZzU5ZGxkeTB5?=
 =?utf-8?B?VmlEU3RTZkpDd0k2d2tzZktkamJTalZiN21BOHZ4bFZPMkNGQjY0REUyU2tL?=
 =?utf-8?B?OXJVUTM3Qkw5cGJiUk5PSy9vY0thZ0lNb21sN2ZBaUZUekhJSjAvdHkxdjRk?=
 =?utf-8?B?c2Q3WnJLV01jSDhnaFQzYm5BTjcwQXFsUEY1dUhmYit0dVRVY1N3WlhZeElH?=
 =?utf-8?B?Uk05cGErL1hzL0p6OFc4d2U5cFhDTHRKcWpWVk5zK0o1WmovUGVMQkx3N0xo?=
 =?utf-8?B?UHN3WUhhVzFaYlhkdk9SdWFFNmVjTDB2K1BtbzhCMWxiUFFRRi9YbTk3TlZ0?=
 =?utf-8?B?WWhQMnN6cHNtclJCcDdFa2NDQUN2WXV1RDJmbUxxMVVNb1NRTjl0aVA3aENh?=
 =?utf-8?B?TXVHMkoyWkltdkE3aEpWcmEzem1JMzErMXZBSnBVbXcxZUtTa2NscGZGeTUx?=
 =?utf-8?B?dU85THkvNUdKN0NSNDJJRFRHL2R1Ky9yeFlsZ3VDZjBqMFYyWjNlZFg0dTlP?=
 =?utf-8?B?YktxNzNLUjM5cEhWZHBCeVN4THFGZnZYanluTHlhZDVLYUZvNmMvOVpEKzdJ?=
 =?utf-8?B?OERWalFrQzJJKyttR2RKMGtTYXI1eTlTcGo3NTNFUnJDTVE3TkUyQkRub1pk?=
 =?utf-8?B?VVAyV09RU0JoVnJTZGdIY3VpVnM0MkxZemNKdW1VLzA1bkF3ZXc1Zy9aRW1a?=
 =?utf-8?B?QkltQlVzZGh4UVdzczYzczZKMkpGM3pCV0xiQXFub0pnY2Ztdms3RDRFcGJu?=
 =?utf-8?B?TEFMVGQva1VKRGtHSlRwYTRaQXgrUVQ1M3huQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:16:19.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f8d310-beeb-482a-065a-08ddb4a2e04f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10134

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


