Return-Path: <netdev+bounces-201534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F3AE9CED
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81079160C5C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD482C2FB;
	Thu, 26 Jun 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EvLKy83+"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A982F1FEC;
	Thu, 26 Jun 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938999; cv=fail; b=ITFZPVqwHf4Fy/8QejnVcbu1kKx2/ILx1/9+KjJr7A+rVEQWBmq5mPScKDPFNf70z7157LIQLM3HWl6K+cuYUIp+vrjRht585mSXN2+3EHQG0Adn+ChAS99JTa4mMIZT4v0Mkkl75nyAPcXuAeRr2DTmMU7z4AOHJMQponerWZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938999; c=relaxed/simple;
	bh=ypqYPIQmafbTYlU0K3vdDJJvc/VGCOkjBJ40b72rH3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lqhmJGXnyFUMkCd4KH7wVMGXtkGa65p6g3LxpVotPb+XUxhvOj/Lr00KfUuppM64ZlvE1PBKiLnOf5Hr9k22Zjd5Ylkdu2fPYnrAev6mncmEdcn6rZx+E/imTDGUI8S9W/eMXn3pu4cCe/wzmvoUs96Jk8Qoa63uXwgiel6ywFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EvLKy83+; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfWUlkwPngilvOP7+C4j02A+X/OiKZdB/7Nal1hiw9viTF4G7kWN0us9tOa6MGeOpPw1JOO8FdFBPeqZLVRFvNZixqbBy+SoH68npayyixxLJ0M4Nkmwz4X+Kz5Y83feIFb+DJwEw0chh3FvObhbe8ja/QVKex0qk7gwiND5MgiN0foYGc9lwY3Urj5mgda7ZNBjx04V+ToAHy+aocJcgiVvenXJYrN3Peizm5kTSMqgMdD2SN3keibmrHavpNakDJGj5DY1pqRr5/eslreHAulWZ6983sZ8gydZrNNR+LiJemBR4ZSvYwWWSB1ZOHO61Mi4kzlIcaAMykgS/PzpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZy5zpYLihWpjMxJV4JADIoOVINRxrpxm+YX6JDqy1s=;
 b=hYsnYJ0mU/dU92Ij4AWvbTRJIgBag2bpkQ5Lero0iaqrOHJtWD6lO9iZ+D22xXxyd3CRc3xcVaN40OOqSn5uO84eptn/nTfOxdQR7iqsLsL4yd1VrNP2KmM7AUJh1ZVwgFOR0u9hbjOS0Z1oKBTt06/g9e6Ee4Uf5FczrfhUI2PExAlVOLI0xBS72kKxHtLGdUuOU8ZQn78XNpM8cESuejuBsVxEVvwIjLRDywabaSLe4sDaV32uNVAFmbPfuY/nmv5fT8ld8D+Ax8/N0ockR+I5qTnqmHOKJ36Rh/REK+QC+GHCKAmWOenVPSQ7J6gkOKeCARee/UgiLOsVoaBURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZy5zpYLihWpjMxJV4JADIoOVINRxrpxm+YX6JDqy1s=;
 b=EvLKy83+WjBnkD4yWEwieVsRz0B4KFnZU2Th6OxbEKOgEhWZZOW49jpHF+4jO1uC0YDJHJIIE5sNZiBctftj87059oEfoM0DfVOzowUY+JEJNTI/s66pGKcVKhso0FvKIQK1VV6i3Ljg3wFjLdPFrTgv7zec4rZ6nFmKRECiYwY=
Received: from AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::12)
 by AM7PR02MB6002.eurprd02.prod.outlook.com (2603:10a6:20b:1ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 11:56:35 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::23) by AS4PR10CA0009.outlook.office365.com
 (2603:10a6:20b:5dc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 11:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:56:35 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:56:33 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net 0/3] net: phy: bcm54811: Fix the PHY initialization
Date: Thu, 26 Jun 2025 13:56:16 +0200
Message-ID: <20250626115619.3659443-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|AM7PR02MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 06efc5e5-ac7c-4be7-898e-08ddb4a88005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJ0UUtqekg1N1hZNGk4MmZ5N0RtK29ubzJENGhtdUxQRzZ2ZTZGVXhyRys5?=
 =?utf-8?B?dUVSa3NWTG1GejZqOXJFenozb1FPQzVuUnBwRHdKMGQ1R2JCYlo2am5BeG1G?=
 =?utf-8?B?OWhaMEl3encwQTVXTXVoWm5NVHFiN0dabjQ2Z05iUmtXY0FHaUhtUHNaejUy?=
 =?utf-8?B?TVZZTXM5aE9wVjk1K2VKcUsxS0k0eU43K0JWQjNKQko1clAwcThxVlZKVnNV?=
 =?utf-8?B?MmZqeFY5ZVhobzJVekt5N3Z6cktlUXlPT3g2bGZDcWFuMzNIRFZWTlNLUVhv?=
 =?utf-8?B?eWcxcTFpL2lSS0V4ZlB5dHlrMEZHMlFoeFBJM1dpM01ISlk5a0M0cnhGcmNT?=
 =?utf-8?B?b3RhcFYveEVpS2l2VXpUdUV1dHhFVFhzYmZlL0hMUk5zRC8yS2tleStEKzVG?=
 =?utf-8?B?KzlGaVBlZGpUNWhYMWZiMnNHQXMxaERBdVd3SGtrOUJxSGR2ZWU0MUhGYmtK?=
 =?utf-8?B?RXFlZmJjRHVnbGg2cVZjcFV3bGgwbmlwWVBYY08yNUZOcS90N3ppK2VzbVY1?=
 =?utf-8?B?Tm8wZnRSZGw4TGtzNHZCWnhqd2c1MEdhNitqOUl2Q0RzWThhZ1VYa0l6OUdN?=
 =?utf-8?B?UWZZVHVUbFZpZjV4WVZEMTFvZ21EYjNQenVZa2dkVUFxV1NrTTdoWnZvWGh6?=
 =?utf-8?B?Z3dMZVVOcE5jUmtGYjlGVDN5N3lTakxIOHFvWUtCNldyT0l5ZzUvSS9OV0Q0?=
 =?utf-8?B?a0R2SXBJaEdpZVdmMHBkV0tSMXRvaU1iMHQwYngxU216ZlYzS1VjeXdRdDAv?=
 =?utf-8?B?RG8yaUYvcDlaNGZjUTF4OVB3Vm9FWWNQTHBoOWYyNEZHQk9JYzVBYWZyUFVl?=
 =?utf-8?B?cGtpYnFNOHZxMitwT2NvTmo1YjE0UkxTOWNhd0hKNEZ0UVl5SFVGMTNsU2pi?=
 =?utf-8?B?VERtb0kwMmliMENCYTlnL3FwZkpvMUx2ZXZtQ05jRlJybHg4L1BYck94NWZ4?=
 =?utf-8?B?eXNSblBlZHFHMm56L2RWTUxVRklXdk44Ukt6M1BzTVFHNWJ1RDIxdGtQRGQ5?=
 =?utf-8?B?MkpvVzdYZFNnNjdaK0JTTjFDQ2xUTUlxYXRWUWRQQmp4alY2YmhhN2lmSC80?=
 =?utf-8?B?bVJBU1BNL3RKMFRBRVFCdS9sdittMEptcXNxaVNYL2p3bEJmNFVXVE1KSlQr?=
 =?utf-8?B?c3F3QlZMOTUzMUIvR3FyTVUvWU1FVDE3NDFsbW85dkw0OXF6dFMxNi9BT0JO?=
 =?utf-8?B?YnJkM3RLbTUyR3VTMVJHMnZiMEp0Szl2Z2VnNUxqRmp6cjN4NXVKM2dqbUtr?=
 =?utf-8?B?SkgyTmJ1b3RBTU1xeUlhRDRnNGNaQ0dNOVBVYzlDTElOQnZaaUJKTG9YYko2?=
 =?utf-8?B?Y3ZUclZIbXc5V2szZ0V3Nk9PNFpmRlhJK2dTQjRkUk9CYU1wa2hVMlRabDZz?=
 =?utf-8?B?VGExVG9VMExGT056cC8vSFVLeTk0THR2N0ppL25PTE1HczdUNnoreFpjVEtv?=
 =?utf-8?B?ZHVHZ0owWWlLdmNyMlpHczVOL3E2NjRVeS9SYm9ta1NCMlh1N3hNeU4zZVNH?=
 =?utf-8?B?Z2FIQktKYVZheWFseEVpekJEV0ZnS1JZT1N6RWlRUU9DenJUSU9TbGpJR3VO?=
 =?utf-8?B?a1FINldwOEdrUVRveG5GRjI5blZ4RC9ZSHE0YTJDcGM2UEczUE9GcXhiT3FQ?=
 =?utf-8?B?Ynl2QmREZ1lCK3NoY3orS0I4Z0N1aDJtVDQyTHVmNng4dktVQjJkYXl1VUIy?=
 =?utf-8?B?YUttMVNIRVYxUVl4aHlkNlZmMzFZclRYK1RTUStEWElyN202REdnd3E5R1Zm?=
 =?utf-8?B?bjd1NXpPS1l2dWN3aUduZ0RqdEFxT2I4N3JlTEIyaEt1cFJTNTFjZWFnM09K?=
 =?utf-8?B?VlJTbys0OXNQc05uMzNxRTFOS3FmVFA0a0xSQm9QT3dEWXcvczh0RWZSdUx5?=
 =?utf-8?B?ZWF1dkRGbUVPNi9HbUxwaTJ4Y1I1endYQW0wTmhmdkdmcXFSbThYdkZ3WmZJ?=
 =?utf-8?B?TzV2cjJKL3V4TGtrek50MmttREY5ekduUFpIVTl6ZFQvWWdHTU9iUG81VW54?=
 =?utf-8?B?OGQva1NJbVV5aE9BWUd2RndHMGZKZ3B6d2dHU3EvMEkwUGtBbGtwdERHTmxz?=
 =?utf-8?B?aldVaEsxUzNJTUVqdGlWUi9BSkJrYXhKTDM4Zz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:56:35.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06efc5e5-ac7c-4be7-898e-08ddb4a88005
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6002

PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
   their two-wire PHYs. It can be used with most Ethernet controllers
   under certain limitations (no half-duplex link modes etc.).

PATCH 2 - Add MII-Lite PHY interface type

PATCH 3 - Fix the BCM54811 PHY initialization so that it conforms
   to the datasheet regarding a reserved bit in the LRE Control
   register, which must be written to zero after every device reset.
   
Kamil Horák - 2N (3):
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


