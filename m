Return-Path: <netdev+bounces-109815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549592A01F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65675B20158
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E8770E5;
	Mon,  8 Jul 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TkZ26nDW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782F156E4;
	Mon,  8 Jul 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434469; cv=fail; b=H+Kz9+egBwUgYX13A8YtoowdJmthtNKZ3mKEujTxORAmZpz+sswQyzmhXbkjn93kD3GYz6FUEL2GhNkHPNUIEq5GtCXqcypbG5YL3IPs1qk2wHXVe+Ap0xc+QrUSOEqU44qqhwXzWrvw9NOAHgMHwuidQNC/RSYED4i7VW+xaqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434469; c=relaxed/simple;
	bh=DMyobsf8qQnxeTaQ4m2EecN1lb23ZZ4Ht5xYmMwD0G4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b96VyUTpSXzPfNN7EAJDS0ZxeVd1exXMP0NV1KyxgFfIticA/Xed+Qtwz1vyO84c0EVu7SFvrIBE557uRPETIb9jfXWjniyxXFY2w72FvyJGj3YQmunoE0dKRR5eMICzjF4h0gzesP/7OUpyDhPL6tmnUauWAyfrzMz77EexYHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TkZ26nDW; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L83H/KJjrzQLz2w5B1OL3PnB+2atGxZ9LV8sMp9g7PHsuYkanGySRerhtTTFnSsoCEvBeKNBo3tfV5Z9KORzIROq5SbFFQ26ZGreVCAvWu0h7MPDcBtAPDvm2VyChMYjlogPVPcJbGGFzO50P/QtzC0qiS0i74fIIpxA2CqqZgMtEjPvl/YbqzC/gQCNkmFpz6BIHPxZSOvCtbJh9fqUJ3fNvgwhOqpx8fZkeqFehua6NWKFH1FvTwvN9sJVqGqTKqmzBq/hekK+guZ3OHSkz4HRNymPyOy3FMzvd7GDSIeHVvKaawS5OcOyi39odXxp5Jnz+A7K5oQWiLXdSM4OeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stMVYkJDkx/4ibqQLccd2rbLCa2SEteAH40aUQHrNfM=;
 b=Er7grGwQai4LRuZFfVK3RmSJJ6mdlH3H/uLISGTCv3phuLpRMtjnKusKg9GqcMcOwGpzAQuDMnlCy1zuBRRvQo8eszmfVqaVT6IPXgM6gxKdmMg3MGrmzgLhITKuKFWFq99s/Z1J8PH7UMlAca6J7nGrlqfptKBNUsyncYTE/72YRV4iv9NHL+7kWX9F/q8SV8oOrSHIMcRcJh5hc0X2skJEdyz6fVHmCo8pL/za8hPgmhw+CsIU8lY/FVMwmtIwWgzBNzeYHJrTTD0n7oEDSfEsF8BriviM0T+EQgcRtp9EDWfCNSfl3/F5RIn+Bs0vuCOB4IbqWVObt4qGAz8U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stMVYkJDkx/4ibqQLccd2rbLCa2SEteAH40aUQHrNfM=;
 b=TkZ26nDWV8tJ879hn1Z3VhzAVsFHiLh1degZ0qyX2AEH30LNjz0ePVCQpfxwlX1FniBNk9C3S9LOgh1+VPoPrZgbnxqiHEvUllU4sXDNUCromDaUAx0cWBcRt8OS+W8KqX+20ySTUpb1dyFzl2WBIb9nyfxIM2bU26YHHVVlnwc=
Received: from DUZPR01CA0274.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::13) by AM9PR02MB7011.eurprd02.prod.outlook.com
 (2603:10a6:20b:267::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:27:42 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9d) by DUZPR01CA0274.outlook.office365.com
 (2603:10a6:10:4b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 10:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 10:27:40 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 12:27:40 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Mon, 8 Jul 2024 12:27:12 +0200
Message-ID: <20240708102716.1246571-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|AM9PR02MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b0ebd0-40f3-41da-559c-08dc9f3898d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjdBdTVVeFA5Z3VNc2pLWmhhUEhYcy90OGtaOGUrTmRRNkxvRjIwdk5ML1hB?=
 =?utf-8?B?UlJVTGljbFV5Z2NPaVVielExdjBRWWV6K1NuSnIwMXUwcUxDYk5hUlFyVmdm?=
 =?utf-8?B?T2hlRXJOWjFxVjhnd2ZwSmNWUDFTREpBN2lodTZ1bUdhRDZrQjloZ1ZtNzR0?=
 =?utf-8?B?anNrTmxHQmF3SVhkaUZONDVwTVd5Z0NwQ1RGekxBTE5XTU9RdnZLSmxXL0Iy?=
 =?utf-8?B?VytwNjlKajMyUkgzUkF4ZzR5MDVCZ2lyOFNmNXZDdDJBSVFlSTNIZmVwbEZY?=
 =?utf-8?B?QXlaZDliY0hoSnROa2VvRDNxbnNtN1UyWFVBWklvcjZQQ2hMakMxdS94VHIz?=
 =?utf-8?B?NzQrc0NUS2pmbkRVZTVheVdWekVaZDdCTDZuaVVsdGdIc0NTZXlUUzZMRHNQ?=
 =?utf-8?B?Q2N0MWJRZERRc3J2eFdQUGhOZnFPalZYVXp5ZktRbWt0b3BSZTFYb0I4Wmtx?=
 =?utf-8?B?cVRkRUdNSXhwUHdYRzkzREVadktGTXlyZFJNMjNiZUxIb3lQdnFwRmVwRVh0?=
 =?utf-8?B?ck9abE52amdHN0g2ckh3bFRFNmx1bzNlN3J1dkU1ZFdFeU42eldVUFJGYnRa?=
 =?utf-8?B?ZDM3dkwrakRlN3dyK1QvRHc1WERraEFITVBjbkRLRXdScnNpRVRhNUJLcmJp?=
 =?utf-8?B?QUFtTWgyeElodG0vTzlDUTBZeEdPWVE3RW45M3RKRjZ6eDhDa0Nsc1AvMGV2?=
 =?utf-8?B?QW5Jd3lYOUNuZng1eDZpbFlyWWFKQllmOW5rR3oyR2QrTEMxRWdMMTcvclRs?=
 =?utf-8?B?TGFqM0c1NFozbzZINk5jalBTalI2SVJ0SWRLNFBGVUdsbnh6K0ZZTWhaNjZh?=
 =?utf-8?B?SnhoRFRKVlRZd3NVSmNKV3VtMkR2aDVpcWVZR25rS1FSWDNwWjRhNTNyZHFZ?=
 =?utf-8?B?a3EzMndOcyttb29RMzlaaEZ5a0ZnYjJhWWpWQlNFWHN1M0lwTHNhWjZtb29W?=
 =?utf-8?B?ZDBRbTA3YWpVRk5lNlZSYnR4a21ZZ08rbFhIRmZCZWhhY252RjFrRFRzcW9Q?=
 =?utf-8?B?ZSsvWi91QkFyaXhIRXV0S1lycGkvM3pPYlRVTUZFd0NyK0p6cHVIYkFuMDlR?=
 =?utf-8?B?UmU3MGFWNFN2eGtkL0xsR09sM01HRGlobXVOU3RlWGQ1N25ySzhBWFBWVjZ1?=
 =?utf-8?B?R09wSkU5ODdZZnpmQjJUdzhmYmlTUW1GaUtjTk9EOFFpa1Z1cTVMY3pWWjlk?=
 =?utf-8?B?djRvdGxpYmR1NUhKQVA4TDEvOHc4Wi85VkE1STMyWDVBTFMyN2VuaG5VdVhs?=
 =?utf-8?B?Z3J3RVZOQXc2VWtqQW5yMit6ZTdMaHJMeGwrR3VaeWo4NC9Xam5QR2t4RjRF?=
 =?utf-8?B?U0tpOUFTRmlXLy9oVm5qQ1Myc0JuSmY0MUxnejc5bEVaSFp3NDdlNDVLbUdz?=
 =?utf-8?B?YkhyZjloeFUzQlBiMTYyTkp1UHZEbDJGdmk2enBIUSs4TFd6S1dsdmVNS3A3?=
 =?utf-8?B?Tyt4RVloUG5RTHRDRWk4bDZVNkpUbHlWNk1iU1o0U2FrbDBoSE85cjB3czJt?=
 =?utf-8?B?ajJCclZxOU5vbms2dWNvVzJENnhsNzNqVXpaOXRkb2VER1FKK3ZaMVlRSWxU?=
 =?utf-8?B?WXQ2cjNyU3NJaVJYMGM3REVWSzU1TVI2KytUdkJwL0VpazNNY2N4cktscDdj?=
 =?utf-8?B?c0Jhc1FDcGVoVVlPUzhVVUtaZGNGQldvOG9uS0F5TFZqdDMzZzNEZnNubC9T?=
 =?utf-8?B?aThTWllSQWc3R2V2SngrR2FrdDIzOUVGYXRZUHV0N29tRFg0VEc3U2dvWWI4?=
 =?utf-8?B?cGJtbG5xdW9tSXJSR0lFaG1qanRja3E0MnozblN5OWcrOHNYaGcwdkJ6ckxP?=
 =?utf-8?B?RWtBQ2dZSklEdEdxeHJ3N1ljUFJhS3o4dEVpVE5naVBoOFQxSHV4V1ZoN0pE?=
 =?utf-8?B?azdxWEU0ZDFjRm9qbUtPbUxOVHFNemlFbzYyREhaNURydHZBeC9xQ1QyTDFv?=
 =?utf-8?B?KzBOWExyN25ZYjZzUmFVeEl6RHpyYzJ3RzBiYWxLVmVWYmMzU1hpN1VaRWpT?=
 =?utf-8?B?dHpzTEZYYVR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:27:40.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b0ebd0-40f3-41da-559c-08dc9f3898d1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7011

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

Changes in v10:
  - Fixed minor CR issues, clarified the embedded documentation and the commit message

Changes in v11:
  - Reworded the brr-mode flag documentation

Kamil Horák (2N) (4):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  dt-bindings: ethernet-phy: add optional brr-mode flag
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
 drivers/net/phy/bcm-phy-lib.c                 | 115 +++++
 drivers/net/phy/bcm-phy-lib.h                 |   4 +
 drivers/net/phy/broadcom.c                    | 405 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   3 +-
 include/linux/brcmphy.h                       |  88 ++++
 include/uapi/linux/ethtool.h                  |   1 +
 net/ethtool/common.c                          |   3 +
 8 files changed, 608 insertions(+), 19 deletions(-)

-- 
2.39.2


