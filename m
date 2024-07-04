Return-Path: <netdev+bounces-109230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E704B9277B1
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B461F2731C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E221AD9E4;
	Thu,  4 Jul 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CVtX6piu"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013060.outbound.protection.outlook.com [52.101.67.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBA191F70;
	Thu,  4 Jul 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101883; cv=fail; b=K18OUltWh33JUg/lcOUvtZenhlHUfoXrUhT7RF6pJeOi3iTwXzMXmMaoHMqEJBxVa9lTkF0sBzD5QP4nZpgmuvGtmQf6XBYrLxxQaRjZE5HbDy15dqhuWxWHRLhpoFieTrq3KT1CiI/FbFjj6ADms7Q+eSDBWBS5M7w4QRqyaN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101883; c=relaxed/simple;
	bh=R5aLCsOxqH41FW96b8XHZKIvedJDlo1q0zoP0NioXE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuKFg8wpeDZAQrVKpBh3d9WDLeeH9uo/5CAEHReGMWvFCduTCE6xcVoHQZmG9AtCuHyi6zAVwAeWequLAWXl4jHPwML7Qd9xDIaO9/Je62AtYhlBa9yGGBgLz4UNT6hDJvHpgDOl4WfGW085Pu8KXSzNgncvhM0DD4Li3sHoH4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CVtX6piu; arc=fail smtp.client-ip=52.101.67.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUYt6bEY5tpYx26tXtq9Hu48F5qzdoHMdBkJYdhZc7kTGyWMVuNsMghRmCZC2dnnCUxSwp+oz04VNnP6SSWg3in2Rr8o1b4czxum5JlGQtFRkAcg5DDQYS/e+hm5iBQZpdzk2/MKoGKLC9Jph3wE2dfYnguQ3epJKli3sSCUhhRRenUkujA3sWnZPaHS/v6AAWsihyQtVMPCg7xWzZBdf0dM5dKa8eBAeciM7hLXFxCArr4gx6akr/oeBZPiUkUOuAkx1JGTy/7yNfkWk6eJtrc8aA+uqYCwOm6edr6TYkxCmtYclYZIwOSPJHJlQlaCGqeYuVRqiPXH4f+zzwioSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LmwbmdY8dSibdvgZLG+/0/aHJtpyxDOrE97NIw1EsA=;
 b=OEZExL1J6wqE9YzK493a1fFedK+4Dx986EFMOYRQjc/jNZjnAJ8y6jSspF2UXnUX8P2mKRbpBVg7VmeAFh/Ekttt31AP+7YbxN0L0xEjKukxxRSJ+YimatzMVItmI57w4ekUav1Kq61Q3qg8dPVQOLeDOj1LMd9rYIG/Skpc/wpOVskUgMo50YCnQsOIo0H1spC3EqboMhbhzMz3Tx+afNLt167xOyVfE1pSx7+91QRqA4cBDOj8OZxmFA69X5o73mBJWHVizialaCLIGKwv7bPpbTiSMV3f/lGk0FUMryV8kxrYMhxq2iLl33bNTC4TLIMcwfIM83ybhWGWa8zXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LmwbmdY8dSibdvgZLG+/0/aHJtpyxDOrE97NIw1EsA=;
 b=CVtX6piuyHnmGAuf4mhDDqDE6vfg4iNABEgY+Za8K8gKwVVlpC3RPuVcYF8WUFbTim0HmDlg0+tP4FpzKFDk5X0+RXEUMJgFB1OGjRHsEz1I5oobo2oUKR9hSlhErbNxi/i440y2ZRZYJP+hbVJzoFDA+3dOVYrkZ927Y/pjTBk=
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by AM9PR02MB7074.eurprd02.prod.outlook.com (2603:10a6:20b:272::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 14:04:36 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::2e) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 14:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 4 Jul 2024 14:04:35 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 16:04:34 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Thu, 4 Jul 2024 16:04:09 +0200
Message-ID: <20240704140413.2797199-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|AM9PR02MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed47f8-aada-4ed4-4261-08dc9c323c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WS9jdjk5YXlXckRybnBZVThwcXhBMEo5KzlOZXdBckR3WkdqYWJQTmw4UHRR?=
 =?utf-8?B?eUVuMitPNDI0aXVoZ21vUElFaTNXUmlNb2FNWU9HMnY4KzkwT29sTS9ENmMz?=
 =?utf-8?B?QWV3SmI2K2dITjZCZXp5Y1ZLZjVLdVZLNVJOZWpIWVpLNzRaSFZueW1mZmdW?=
 =?utf-8?B?QnpiVXVCc2ZMR1JsdXRSZHByTmxHb0FuWG5ZdFNFVm9WSTliZzU2TEZ4NW55?=
 =?utf-8?B?REdsZzE0N0ZOcW5ZQzRUMGxGZWpPY1g5Y3UySGgwVmFINjdVaEFnQ0VsRlVa?=
 =?utf-8?B?b2NJOWdBOEF4YVBPZ3R2elMwY3NtMUFOK3dhTFNIRkxRcUFTcVJZT3g4RlBw?=
 =?utf-8?B?LzJUeW5lS3dTSERLQnpBMGRKWjRzTWRIS1oyUEt5N2txODNCM2orM0VtUUFO?=
 =?utf-8?B?TktONVo4YXVUS3UydUZLSktOVWRqVDBmbDQ1ODdQb09DZUVGYTdzOHpKRUJS?=
 =?utf-8?B?WXFOZ3FRNFVPd1NlbjZQcmZ6MXJnTml1R05sRkNSVzMveWt5R1JHa0E1WTkx?=
 =?utf-8?B?TkxmVE9kWllLNU51ZEMyUGJXc3lMRlJjdkdqY2s5M1FMdVJSTzN5NDUwcVZB?=
 =?utf-8?B?TnE2dytuN0R5L3Jid1o3UVRtWGo4WVJicUNzMWVLdEJHcGpnbzcwVmQ2NEVo?=
 =?utf-8?B?VDhBMy9OdUtVR2lKamF5cmlXU3JTQjY0TmNMVUJqWUxWREdUd2VZcVBJd3NJ?=
 =?utf-8?B?YW5ZV0pHMEpOcnlmMlBGWHgxNVRxMXZVMEQxdzNrR20yZG9TR2F4c3YzQkhv?=
 =?utf-8?B?T2JJSGdkdGtRNUFqeUZ5Y0JKeDd2bXNPMVZpdDgxUUJHbHRiZlE0ZHVmVmt3?=
 =?utf-8?B?eGRJbnd5SGFqei9EM0NRYk5TRkxYY0FaSDh6bk1oZHBnelpkMmRSM0lndWlx?=
 =?utf-8?B?TFNCc2hFV0phaTBpRUVNdWpKZCtZYzh1OXBuenNURnV0WGQxMWZBaDB0Umk2?=
 =?utf-8?B?bEpuNHJsTVF1UkJPajd5YnZwQmZDNFNmWWxZOE1DbDZCVml1TzVuSHFVUzcv?=
 =?utf-8?B?cUtBTjh6UGZuYnRFWmovdDE2aGYxMEEzMGs2MytjZVh0L3BXM1MwRVRZK1hH?=
 =?utf-8?B?WkVTTmhyc2lZbWdHSTlnZWZ5dkVMRFpIRHpuQmlUZ3F5NXZySEJ4Yjg5ZGNI?=
 =?utf-8?B?RW1oVlZ3bHVEK0JGSmdqVWFnUWFacWdHMVBOekcvRXFObEw2KzloQWhLaTVP?=
 =?utf-8?B?QUtsUjcwTC9NU3l5OTRrY1NRSXNMdS9DWDFQYlFHNGJiVGorUHZLSnJ1QjZN?=
 =?utf-8?B?ZnJqT3dnWHNKWkgwb2lRb1ppdXBsTEdkLzUxMW9tbjUvN2EzMFFNQktkMVlm?=
 =?utf-8?B?V3FZMXdJb0ZIeXFXelhJWUliUUdmTmg1c0g0T2MrNncyZ0Nxa0pPTWd5Q1pC?=
 =?utf-8?B?NnRQeUx2YVhOOXdic2ovSm1HcGxGWHVTUG16bERtK0tVVUhUQUhGQzMyMXNj?=
 =?utf-8?B?SHFKZmwrRkZXTCtoQ0NiSHRUQ3YrWENzN0RSdVJSWGhPTlZpd205emN1VitF?=
 =?utf-8?B?QnpjT0pOZ1dFL3lxTlYwUHNxZjBFNjFwWThJKzFkbUU1NHZLVUlTZ3NoUngz?=
 =?utf-8?B?MDBaOW9Geng1MUt6ei9Cd0JXYi95dUpYcU05c1g5Rjh6Z1NaejA4RGV2RGhn?=
 =?utf-8?B?U21SRlpwS211bnZiTXd2aWtRUnEyVkkxUDFZNnZ5WFBpM2ZGSHhWQ2FKTVlH?=
 =?utf-8?B?eWs0eE5icXNXUlcrd0NML3RtUE16Yi9ZT1B2Mlptbm9Da0hjakMwemcrelg3?=
 =?utf-8?B?YWpwa2JaWUtkWS8walVOditDMm5Bbjd6NEpSajN3d1RJaUc0MXYxMFNZa1ZR?=
 =?utf-8?B?Q1g3WWxzWDJhK1JpaUtnNHovRWxoMUg2eEtwSHNVb2tWMzZ0bjVJNjFpOHZV?=
 =?utf-8?B?MTcwcjVEMlloaVVDVWFOYkd5czVrMUpBSXBpdXIwVkJUbDBLUjBZSVRzdVJ4?=
 =?utf-8?B?UW1PRzZpemd5RmdwVmhDT1FvNUNXeDNhc3gxemZDdmppT2wyWnlObnZXMVYr?=
 =?utf-8?B?WXlSQURKSFd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:04:35.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed47f8-aada-4ed4-4261-08dc9c323c94
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7074

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


