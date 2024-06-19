Return-Path: <netdev+bounces-104912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8490F19F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818B91F221D8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5514B96E;
	Wed, 19 Jun 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="T/nzFuL4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055534545;
	Wed, 19 Jun 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809473; cv=fail; b=ssFheNIjMGU89f7HCqpi1yiCZ1FrN6Fn0Z8mNFygMpYPPZBEfm6cK58HGOrC2JFjUytaETzWZW6I+Ji4HISdw9OXHZcj3S7OtMtg1XjezKlFou13vyfkVFnW7lUh8M0Z6+dOUS+P8LbNnqtxHcGoc6qaAQDX1UMlzaZJ09gBhmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809473; c=relaxed/simple;
	bh=jv8oR5GRQElf6jlQc2Q9F9vap67qg/5vUBiKyY/iqMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LCUvDAOoTVbKZ5SrzWpCrksnwxXDR7d1GnnKiErwdogWvz+r8fdF8yj/jAzIeKr+VTtPprL4aJp81IHx9uFaf3OrQyF7eFbHYBe+0doYTJ9lK7XT48Y8SNdoeHGBtXydnOHEaARnKW+DJ0a5kVgOQEGN8femx0EbFcsxYJ27K7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=T/nzFuL4; arc=fail smtp.client-ip=40.107.14.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMuAkvRnZAfT710bEMtyDYSFNziqyXklIhAaX0qT8x+vKhS/nKGppOLJke9J47kDwylCOGg9Nyp2KKnZNRpk/yvfIMT0EZgjsxMe2mvV7aMflMtyvUVjJWABO43FTwwte33lt9YcWKGFc/xok7hqrNXRTiZhTfVxdulNq+Of6d87m4l3kSDaSS8n7v/36ZAHZbNdukzO8d0fzszjV1EgxXIEDv0eQ4Moi9saxBwpfChsucWxEQhPHtuScrnAtOATugXXYhlerwcZBPuZFdOf9Kythzkl05GsqFoEFnvcAbCPv3RTPP+8djaPy9edEcBT26+8TMChWLeMochOLvRLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj+yseJTCi5oOBM5PXFBNvw/ujFW6ez2W5OltGdyR1w=;
 b=DCtd3ng9USLKBZ2SImeheVW3nEfvNS0HGSA9Om40TUv3Km3e9np0UodjE3yjT04G1IDxGLaSUlp6bCzzCio6i0GLMqYvZd2yCRFqBlw6rfWnDy1F6MlYEFB0omSD80mwjnMD93/3y3eGl/9nqWbXGwaxBXd76Sc3nym7Xocn2jgammdWz7EjfFc8s4MBUTY7UFsqKspBeYPiiW1SvaxJ0LldNEE+VDqj5inuLppllTK/WPoOW/2NhMc7zNfmnl62Q+HkGSzC1lwCY/Yt391Uhdjp+TJlKzm2gt2f5m/1ZTZqwye+suEOmIb3xBveY6/v9goYfqpvGgPp2CFKFQiOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj+yseJTCi5oOBM5PXFBNvw/ujFW6ez2W5OltGdyR1w=;
 b=T/nzFuL4grlfZnBmy5yMVKgyuQCa6d9jtuNJMpWtem6QSntPqYaBZBVz71QyCrH1Iv1B82b+5HbtMOeW+MRmhY1aGwdU7x9Umwku5c0yRtgx2ZE008b20YCI1bKViEw/0AeccE8j5rtp9CbMx5e6aCzeo82CGBQ68mxfWR0rpx0=
Received: from AM0PR02CA0227.eurprd02.prod.outlook.com (2603:10a6:20b:28f::34)
 by DB4PR02MB8727.eurprd02.prod.outlook.com (2603:10a6:10:378::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:04:25 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::f5) by AM0PR02CA0227.outlook.office365.com
 (2603:10a6:20b:28f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 15:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:04:23 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 17:04:23 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Wed, 19 Jun 2024 17:03:55 +0200
Message-ID: <20240619150359.311459-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB4PR02MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 312b09fc-782d-4bcc-0a54-08dc90711b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|7416011|376011|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0RXQ1RobWVkbzFielM3Ujl3bDdtZ0VlMjU1ZHo3OG5ldUxMR0dBMldEUSsw?=
 =?utf-8?B?REF3WnZmRzNrNlV6RnI4aHdpTjI3eEdNYkUwWUw1am44L1lZcEVNRDV2cmN3?=
 =?utf-8?B?OHNON0RqL3NPVWxSczRwUWpraVRzTTF0UVFjYzJUTzJvdXVBazJoaCtWR1Fk?=
 =?utf-8?B?cE1VY3liVkJuQVA2SVB4cFdSYnJuSHV5RWNwLzg3WlY5cU1CbzhPanB3czhX?=
 =?utf-8?B?M2p1RHYvUzhjWkJ5MmQ4cE1PekVRaEszcGxSYWloVWRYQy9tNlRtUWpLd0l0?=
 =?utf-8?B?WHFnQzMrL296WEg3MEp5U0xub0NLaHhZY2pqcU5DZldiSmJyM1hHN2ZVUTdj?=
 =?utf-8?B?UFVObE4rbGhZN0JMcFVWTGhuUkZTUUo2RmNNRms4YWg1TDg2UkRCZDJ0U2lG?=
 =?utf-8?B?bWNvVFZVL0FsbEd2VHJ4cVFVUlVDeFdGL1JhaFdxM1VFSlBrM0VtR0g4d0N6?=
 =?utf-8?B?QXdzT3d1MW1UZ2tROCt2K0NrUE11d0N6aXFma0UvWE5PbmlFbEpCbEp3R2pz?=
 =?utf-8?B?c3FPcHNqNjk1dHg4MzhmVzZrWDlyWFZOaUVRczg5dDdWa281d2U0VTRuK1NP?=
 =?utf-8?B?VnF1dVUydUd6d0xPZ3ovaW5XL1FYNzhkV0ppUFJETDJpdjZmNmVhUk13bWRE?=
 =?utf-8?B?SE9MVytSaW8vWWNHd1gycmMycUJadmtnWVhYbXY0MndqcC9PRGd2ZzluYktM?=
 =?utf-8?B?NVlOV3ZQRGtzdVliVTdvaVZqQjJ0RTFSa09JVFRIN0diN3VZVDRENEkwalZW?=
 =?utf-8?B?ZzBxWjJkTUk1SFR4R1A2MzU4OURvSUJwNmFoNlhFcjlUdzZCclZWUGN1dlJi?=
 =?utf-8?B?SDFFMnRlVk1CWmVDcnY2TXRibGhPM1VMNGxsdDNLdW5YZDRGK1lPYnlwdnll?=
 =?utf-8?B?VkxoM3V5Z3R3VXY3dWZWWjlIMEVLYmxiYzRPZ2U3bzR4NkZlUXIxWW1HTmY4?=
 =?utf-8?B?Qnc0QkRUci95cWllZXBXQ2hVUHJsMHlIZ1ZOQ3ZNQ2g4NXh2Y2dpTFZPVWJG?=
 =?utf-8?B?alZMdHpPWHNTTE9YMlhuZG1ESlFhTU12ZVoyeXNSRHJuVDgvTnB6KzJqZ2p0?=
 =?utf-8?B?R0srN0pxU01MRzFIdmwzbXA3R0lEQ0k0Tm81VzFWY2NIVjdWcmtEckQxNkM1?=
 =?utf-8?B?blJoZS8xWm15WDNoRVR6UFN1NEIwUmt2Z01FeGZIUHVsd1NRWE4zaHk2akQw?=
 =?utf-8?B?ejVmMXEwUFZVQ01IclJjZ3ROVGtmbWJpS3JtRGlvK3lxdVFWbllqTGV3c0NB?=
 =?utf-8?B?QjZjSXdaN1JUWWtPNlcwdGZCVGxSME5Ka0c5bkNHMU1XZTFQT2NYMDJKanVn?=
 =?utf-8?B?c0I3cVAyQmtqNTRMTmwxdWdQVFhXN1g0YXRCdHA2eXl3ZlVQcnNsNDMxdG4w?=
 =?utf-8?B?eFBHd2ZnZ0hIQjhHcXJhdU5mc1pMRU9aUDJUWHY2TGdiSDU5SHhKdTBPeTNn?=
 =?utf-8?B?TWE5b2ZaV1FsU0h2QzZDQmp6UVlqZmlWNkc3dCtBZXR0RGVoVDNuZkREVjZp?=
 =?utf-8?B?MVE0Z21xTDZObjFmUG93NlFTcnB4ZE5oeEFiRnRtbVpLZHBVZSs2TkF4dWxF?=
 =?utf-8?B?Y0lzS2ZqdDJqbW85WmZTb0FLYVVOcTlrb29ya2dmSGRtenZIWEswUEd1VVpr?=
 =?utf-8?B?MWVkRzdtNTlzNFdxZ2JnSlpiRERINE5oTzViUGszdmhEbW9jSzE4aW9YWDZy?=
 =?utf-8?B?dnFaajl5RXpaeXd2NHlNUnN0M3cvdjBsTDJpaWZoekxQWm1SdjJVZ0UxR0xO?=
 =?utf-8?B?Mlp3dUZ0VzRibXpHUzNJWE4ydXlGOHh0QXRwWnBoekx3dFN1TXZYZHlJb0xy?=
 =?utf-8?B?eWw1Ym0wRHVSNjN1dk5TT1NQT2VyVXdySUlRd1BTV2hmZG0ycG8vYnRKVEVr?=
 =?utf-8?B?TlM2clhUWHFrNGl3d3FEVVp1aXVWS29FZFdqekkwVjJKMVpDNGpZZ3BIQThv?=
 =?utf-8?Q?0D9FFz6UDgs=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(7416011)(376011)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:04:23.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312b09fc-782d-4bcc-0a54-08dc90711b04
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8727

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

Kamil Horák - 2N (4):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  dt-bindings: ethernet-phy: add optional brr-mode flag
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 .../devicetree/bindings/net/ethernet-phy.yaml |   7 +
 drivers/net/phy/bcm-phy-lib.c                 | 113 +++++
 drivers/net/phy/bcm-phy-lib.h                 |   4 +
 drivers/net/phy/broadcom.c                    | 393 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   3 +-
 include/linux/brcmphy.h                       |  89 ++++
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/common.c                          |   3 +
 8 files changed, 594 insertions(+), 19 deletions(-)

-- 
2.39.2


