Return-Path: <netdev+bounces-105672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF15912394
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFF51C2153D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379417A93E;
	Fri, 21 Jun 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="m+S4/uR1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D617B409;
	Fri, 21 Jun 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969231; cv=fail; b=V00zWHK9vBYw4mXNadkWOFUlvT15hH3rqQSm+fzS3xRPb1jWqO6OS0jlJJVyrBKab1iSCipIVngAqFjEqVlI+MdAxPgYmZg1RO+GK9OxBXaOgQEeWIqMzXnXnUTbjThXMNM0sJs8vn7d14wYXhagAb69hqW0q2fOAijLL8bQj1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969231; c=relaxed/simple;
	bh=2YfOy7qFNNuArukRtWEz+k3DfgSZdcKpkAXALwjAhjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JX9EIz22esdqtbWnO/JFSZZ0tNARauGwKSY0ToSA5a/tCIvyLxOZbPaqXuwo7w475oMMFq8zAcKBVHrQ2owHwSn2dnCDTK6t6XTUYcUMpaYUPyxFoVi1XcaUuU3qgrRBx/yoLB7D81+7bn9SsYk46Xw/vPzs1KBcmkst8O9rIP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=m+S4/uR1; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgzbroDttfJoQ5fKCEcy77JWbxhZg7orvReiWm/l3Mf+oDTgGiNrAVY2lI8Vj5xjXsviWGF9DF95Yei4TzjUpNlR9VSTNoVDdGFQXI4pxUwlwmK7mE8y+b4EmjflUmZZNR+Jun+i/G2gjpL/qnwAhhdAeJzr2l1V8Gds4+nfmHuH3/PyDMw42mAElKsiLLHL+CxPQiWD1tYe7jva8NTCxrvoRBtTt5eHmBscNcqgZq3WHvTAM54SkhYjoSkDZvhoNWugMwBdyvWRwIwNvqE6QOQEdUoSZv53d8Dax+9cX3qd2dQHBEqEIQQAsWJxTDbGt2a8XdHgBnyOEdAepGjphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRpHa77vYawAswSBBMOlNFgB75BYIko/dRF4Dx+f77I=;
 b=TcJeAl0wpQzd1TObkq4tVzTctcSx58MgRgQ8TtzL6oF09V+GDSHYp36Jf4qZ+RmexphDYmB8VMiAaIcKbcR0kLO8j6CDs5A7LUWASb4APMYHTDH7YhR+N0SutJLZ1TZtM4w+GM713T/4dC4oGTbyV7hVRUh3nLllrxs/FsULKNE16iCba26OvsTiCHdj9TS+V35TTnoIqfirFNF1stpGmK9oVmjL1KgeWA4ZpVl+KPgoOZid1/zJ7iP9jsVyiLIxPZ3ymRBqeauKINAvs7YNEw1Ff6PK4pUjXPAyv0nGDQ0L9PXmYvSHV7nCKj69jz2PNLfGrYLNs2HqhbqaK4Dc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRpHa77vYawAswSBBMOlNFgB75BYIko/dRF4Dx+f77I=;
 b=m+S4/uR1qx8tlTpW9jy0kcihBGIpeLeg0xgKLJ/twD7/3460BkKk8jN4rIEWhnKdYIslxi/XEB+gLIryvAjIh5a8GEdurykZzrA6IblM4k6xYPJRY40OB6GkqGch1OHoxXoZOJMUImYKTHUTUt/eYXOw/DuFjqVGqhN6F/G8ihM=
Received: from AM0PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:208:3e::36)
 by AS4PR02MB8383.eurprd02.prod.outlook.com (2603:10a6:20b:51a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 11:27:06 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::97) by AM0PR02CA0023.outlook.office365.com
 (2603:10a6:208:3e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 11:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:27:05 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 13:27:04 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Fri, 21 Jun 2024 13:26:29 +0200
Message-ID: <20240621112633.2802655-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|AS4PR02MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: b822cad8-b194-41f3-108b-08dc91e51475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|7416011|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djhheWNpZDNyQVRIeXFoMDBTV1UydXVEZjV4U0k3ZWNuUW52bzQ3S0hxK1ha?=
 =?utf-8?B?TkZZa1ZGRWhGcmxONCtBRWN0bFdOdjkrdngwNUtCZzhTR3NzZndHaGJoejRC?=
 =?utf-8?B?STRLQ3kwZG8zYjBIM0Z5QmVNdTV1aTlzWUdGMEpFb1VxV1RUemJ0RTc1SUZ1?=
 =?utf-8?B?ZEV2TkxMOHZrTWVFTU02VG9kaTZQcjNlVjMveFFkeHVpUkJXL0Z2a2xIU25V?=
 =?utf-8?B?K3ZHT2k1b0tCM1RQK3NrSWZ0R3NwSG42RDlhb0tvNVdSSWI0RVRIQTlobTk5?=
 =?utf-8?B?U2RoMnZWTVRaUzZyR00wYVQ4Y2k3Wm1ETEt4Y1Exbm5pTlRSR3JCZUsxUkdr?=
 =?utf-8?B?cWNGamU2a1ZTdjdQNDRkbDlyVEhYa0xTcko2dzNBVktuUitlQ0xKM2dyOXBH?=
 =?utf-8?B?R3BEaEw1cWdXMVBUK3pNWmlJbjF0bVlPZ1Z1eTJUN2xXcTM5RU1VTEdXNTdV?=
 =?utf-8?B?d3BLMzJuQUpraVBmMGJUY25meUhJUU81NFVkd2xyMFRsVEVPRS9ONGV1aEhY?=
 =?utf-8?B?Wm5laTB1SWl4WFJLZUhHa1ZjS3lqK0VFUE1HYkxESDVicTZZVWdxbVN1TjNw?=
 =?utf-8?B?Yk9PK0lRZXZUYjArYUpGYmhKQ3UxdEx0T1ZpT2dpNzVkQmVKbGdyZDVpVjJ6?=
 =?utf-8?B?bGQ4a1VpN0MweWYxc2ZZLys5bDM1Y1FjTFpjZWlxVm41eDh6VkxnWUE4M0Zn?=
 =?utf-8?B?QWVTaGh3QkkwUEZNcVNEbHhsSFczcWRoeTZzRkpsU0VzRFRTV2VIWWZReWl0?=
 =?utf-8?B?Smdqd2c4TjY3UTB6SGVUL1FsdDRJcDkwMk5ZY21pM3lrN0krTm16bWl6QWpz?=
 =?utf-8?B?RWJldktsSGRyTGZ5RHBNbmlzaG5OWUZ3c2VsVWtjWk0rZjNyNmFhcHNXYTlE?=
 =?utf-8?B?ZHEyU3NWSnpiRWlQYklBWEpGVDJhYysyZ2VFUmxUbDM0TGJNdHBTdGlvSmw1?=
 =?utf-8?B?VGY3YWhTaVNieS90Q29PNzlJYURMVTVrK0N0UUgrdmdGTDF5QnhPYVlFZ3hJ?=
 =?utf-8?B?cFVyWDFVQW1mZ0F3UFgvakxHT2JpRHlSWG1JR3dTT0hseElSbmcwalU4Y1Z4?=
 =?utf-8?B?YUJDMmExbWFISlRrcGNOUjRPQ3hKRk9SS0hBbytBRU9xc1k4Uk0rTko5NEVn?=
 =?utf-8?B?d09PbGhlek1Nb3JLNzFwSDZ0ZEtlSlJVbjhCaU43YTI1cStwcmxTS2V1a2hE?=
 =?utf-8?B?VWJxekFiV2FPWUpKbDBWU2crbXFPSm1BRUdzcEllV0ROeW9LbDlBQW1Cb01i?=
 =?utf-8?B?aTdJaS9Ib1QrdDBkRUV0ZkxLKysyK0RkSnZCSUdiUWEzR1dsajRHZzNBNUk4?=
 =?utf-8?B?dDFjR0JrT1pVbzJsNjRNUXdjdmxDdnpsbWZLTzB1U0hsdyswTFZKMEZaMHBp?=
 =?utf-8?B?bU00TUJHcmxzYjNIcDJPbFM3RnhHMi9rZE1FaVRRalgrVjRJcVVseFNNd2FI?=
 =?utf-8?B?N2s0dmhHZXZ1OUVzM2w0QkUvcmxISXN0SlM4Qm1YQnVNRnNZUVFyZ2dtV2tX?=
 =?utf-8?B?QndzUGpDTCtrcFlRUUJRa2lOcUNYSVBVcXdwakhCak5ZYUJ1SktGcldjYXpj?=
 =?utf-8?B?SFNpQjNTRk4rMk9rSkJLUGpHRkRwb2JrMVNiMk1KeDVvK1UyalhQdzl3QWtB?=
 =?utf-8?B?MHhwUkZCN0lCN2N6TEk1aGNtU3hqSjNPTTE2ejQ1OVlScW5IakZKVTVqVVNR?=
 =?utf-8?B?Vkl5c295amN5SlBWSzZybG1YZTlBUkoxcnNGVWJTaWxmaElWMjZkM0tWcjlJ?=
 =?utf-8?B?OWFBUlEydFFSdXNlbGxmNFduZUF1eitSQi9GVFpEOVdheW9abTJQQldJdXJn?=
 =?utf-8?B?UlBJVVcxTFFYWG9YR0dzR2tiV2Q2c01TUldNTm5UM1NkNUZsVEE4Y0dlUmdP?=
 =?utf-8?B?VzBFN0NIRDBnN3JYeEdFRUV6cmtqR1p5TS8vZXFqNEFIZ3dUYjkzN0hoOTFW?=
 =?utf-8?Q?nCg0CXQ/swI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(7416011)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:27:05.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b822cad8-b194-41f3-108b-08dc91e51475
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8383

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

Changes in v8:
  - Fixed coding style and did other changes on behalf of the reviewers

Changes in v9:
  - Applied reviewed tags to unchanged commits, reformatted the submitter's address

Kamil Horák (2N) (4):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  dt-bindings: ethernet-phy: add optional brr-mode flag
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 .../devicetree/bindings/net/ethernet-phy.yaml |   7 +
 drivers/net/phy/bcm-phy-lib.c                 | 115 +++++
 drivers/net/phy/bcm-phy-lib.h                 |   4 +
 drivers/net/phy/broadcom.c                    | 392 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   3 +-
 include/linux/brcmphy.h                       |  89 ++++
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/common.c                          |   3 +
 8 files changed, 595 insertions(+), 19 deletions(-)

-- 
2.39.2


