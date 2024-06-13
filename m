Return-Path: <netdev+bounces-103232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10C2907382
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23051C248F1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4C14658F;
	Thu, 13 Jun 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QaEOGIsQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566D1448D8;
	Thu, 13 Jun 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284883; cv=fail; b=hl+FN2c/IqcFQF0HVDo9MXS7UQjy/25M1JFwnnkWiGS+/yhfTU2tCLignVM5wkIwlGv95ndeSF2HneP6m/Wv+wNIc3C24ik3LR8JPoPrpyNLjAJRJeymA9kChuxjNYQMhFt6qkcWSlTxe0vLrLdaYjU/cPpMaKF5XrU6YymwVnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284883; c=relaxed/simple;
	bh=LHWBRv6Kz3LgR6SydWvZSGzLiGDL0uN6OKpItSYvNhI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BW1bdigmDnt24oKmMfCrdMsiAhxD2lhJbdw57kAQv7BNF6kD7U4os6cWZwGUA3c9WPHi1+2S/fqohTd8BonDQMaHvP6/bNfhGls07kDclHDYkFY2E2GFvKQQ6XSab2/uFOZFx71nJEZXOMWDjd0f+1ZspsolCqqIX/Wxjk0azjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QaEOGIsQ; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7OwsxeNHPvq7U/JsascOAHqjzsb3tSJ3/rNU+CREWHJcpe27B2kZ45G8d4IBycoIe5JVCPrOuaUDYn8chmYwLWFApzyT0HpeEqA7cnaZ5lnv/Q1D7hnHOxwrkStBFe+I6e+z59Z7bZoTsKyxX03wt7VFKP1RhIM/dLJ1DQGkCFyZyWLVD4orwzwU7dQFQAnWGannGmtgtElPm3aDaR1VKHRSCGnDZQDE+7izftDMin7NvFodPljbF0jbaVg4j3W0QXabf6q8UxTweslr3kXeBHFGeH/h0dplw4pFU9JukYmdl+EkOCSNKaNeGLXfKdHrA3/9BZgVt7DtYLF7CtsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tUdOrxT955PQwT20/EJZ1RoJX2UwtFWOTcvsmbA9NM=;
 b=H3DYmPwesBPzd1f+dm3myjzI7NsC8MLaQEyzKkoxCnzTQv3dHV7GsRptbiKXyMEqj98QMxboo1pAxnY2Ns5QmyjohD2QpLvw4tXjttnz/ZGeNrNegmHmZmNKNRkogmztAagjiX4hNq5Nu2zzkKZfTGnaDtNsQCGdhPcUX6IJFupM4x5PVz/wW56ynDokYP8Oadk1VPlifP+/TRU7TaTV1Rh9mwiFCgkYjANvnH8B7zqb5vQb38NRI9oW2CQ2UQKCVDGDGtoh/KFIF/hvzR5X73wREx5NZAW0Xu5Lde/nKm6yGa86xRpmZ37bbnX1AcZWGiOVmMiwZv7mYhzxsXXPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tUdOrxT955PQwT20/EJZ1RoJX2UwtFWOTcvsmbA9NM=;
 b=QaEOGIsQ/McAs+I07uRN9L2h41KcmtrhL1u7xahYJyIblcpwFEv8mT+WrydrcvKellOsVXcHNDTN8KCS0yPjOjAOo2V1kjjVu0vHTl64rsUN4cLj2gEtI0QvkfQImX8bcyHZuaS2gNPeJ8iyjuP1M9BfZP58RABZDYwYKdyE7kI=
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by AS2PR02MB9955.eurprd02.prod.outlook.com (2603:10a6:20b:605::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 13:21:16 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::2b) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 13:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 13:21:16 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 15:21:15 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Thu, 13 Jun 2024 15:20:51 +0200
Message-ID: <20240613132055.49207-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AS2PR02MB9955:EE_
X-MS-Office365-Filtering-Correlation-Id: bf74e0a8-7ecf-43c1-32c7-08dc8babb491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG5TSHdNU2pDTm9vMVR0VmtTSVdWbGpXYXpRM1MzNE41SjVINFBHVzhaeVhP?=
 =?utf-8?B?MHVreU9SZENpQ2xyYmVUYjlSQmRlRE42d2l3SFYxdDVYZUZmUTlmSlkzWU9q?=
 =?utf-8?B?QzRPUDhkNW5lelAxbEx3S3JpUmNBTVdzL2d4bkhaUHp3bUtVVnlQM1ZQOS9K?=
 =?utf-8?B?bHVicmpyZEVZaElhSEdOK0d0MFgwbXRPWG0yT3NVSEhTbGljNnFRcWk3S1Fh?=
 =?utf-8?B?Wm0xaGR5SUxTYjZSb2FvcE1tcTRUaTJPRmNoK2VPWHAzSDBJL2dSWVFuV0VE?=
 =?utf-8?B?b2lMMGFBcXhQc295dUZ0TEtoenh5OWt1R2JQTUdibjR6SW01dThjNlRmODBT?=
 =?utf-8?B?V3F0aTRsUkpFZmx4bXVnZlVjMyt2VlJmeWh1V0RabmJNcDRJRFkzcDB1QzYx?=
 =?utf-8?B?bWdrZWNQZFY2OWk3WmgxM21mUHRyRXFzQUJ0VGhNRHVGeGRHWDE1Qko0RHFk?=
 =?utf-8?B?TS9CeTI1cU9NZjhzOGliaTdOUGVteVUzbTlZalBPY3dLNjltWXc1b1BoVmtz?=
 =?utf-8?B?WWNHSEJQUGF3cTYyZk1OS1M0dVJZQm1QaHF4V05wN0o5V2xUVkpuYXhjaitI?=
 =?utf-8?B?ckFoTEhFUkhWVHc4VjgwcDJ5OXpNaUZ1Q3VaM0pRMmkxaWVGNXJhekpneFBG?=
 =?utf-8?B?VzBDSXNKckdoRjhKR1VNQ3lSVEFkaGM0MUltTkdSNGU1YkRzMlhwNkpJbk1Q?=
 =?utf-8?B?SzBsZFh4UkVqVmM3Mm8xMG8xdXlwaG5BMWN4YlJ5QXJiRng4Q1dOUUJTMWtB?=
 =?utf-8?B?U0thSHJUK081d2d6QzZRanBzZ05pd0dQM0dFcTVlMkRJdlhJUHBMdnNNNFB0?=
 =?utf-8?B?ZTZxd1BrZVpBTW5kSnZMYytoOG1ZdUxYekZDdm5UMWZHTHdvQlRmV3E0SXpX?=
 =?utf-8?B?R1Fja0hGeC9WNnU4cU50aXJjT3lTMk1RT1pjWUJsNk1XcllTK25GUU9rK1Ju?=
 =?utf-8?B?Q3E1MENLMC9GcFFqSzdMZHg0dDRHRWJvWCtkU1lxWm5FYnY1eXpqeERvVWNs?=
 =?utf-8?B?alRRU2hUdnpIZzRUdWpLTU4vaHN6WjFZRnJFMHFhKzJPK0ZUSDdZMWpRN05T?=
 =?utf-8?B?dWo3QXY1d1hpeUV1YkRkUXAybVpvd09jdW83OWxDaG80aEVseEx5bEllZUV1?=
 =?utf-8?B?V1pMaVZaVzRYaGs2dnRyTXhoK0F4T3dRakNRZmZJL1R6Y2p1UHFXeDdYbnBt?=
 =?utf-8?B?NTFZSk5EV2J2YzhkVWREZUF0UlUvMVVRU2RVZWM0RXI2L0xoT2lGSHRrR0V0?=
 =?utf-8?B?d2NGTVBDVk9MT0gxYklRbVR0ZVZJVUpUelFObU5PS2YrTjlydFpjREVXUGt3?=
 =?utf-8?B?WmpiM1FEVG43N2grbWQvQytYMCtrWWFoUW1YUjR5L2JYL0Q2UUVVdjRyMUtD?=
 =?utf-8?B?aGZUS2EwZmhDZzBhajVEOXRkc0o0a2FHNDN6cC9STENBdGFQcVhsazdRcEhl?=
 =?utf-8?B?N2dBVFgxRDgxUFFpL3dhT3RlRmdKZkpWcWdnRlBLNEZ0elJUQk44Q0FHeXVY?=
 =?utf-8?B?QzFKWGFVZUxPYXdKZXNmS0NSRFZNYm9jQjVxYW9EUDRQY09SV1N2NW04dWhz?=
 =?utf-8?B?d25IVSt4eDhTV2QxdUNkMGVzc2ErTW5SVElOdTBSeFYxSnErRGhjMzJLUlhk?=
 =?utf-8?B?VFM2TVpPMWlIZzd4TDJIUCtSTElsMm9rZ1VLcHQ1czgwamM4bW1pQ0hCUW1i?=
 =?utf-8?B?MmwrakxQNUdsNzN4dXpNSDZaZVF6VmRpMkQ4TzE1enE0RWZlOFArK0plRUxL?=
 =?utf-8?B?RW40emY0c2dxZ1RRa2JwSGFHS1ZwUENpaUsxdWd4ZDN0R2xoWlNzQTl3VWVH?=
 =?utf-8?B?Wk1ZUmtFMkYyazdsTnBVcGxPbEd4RjI2cTJmZUt3dEtHVVNWeE51WjNMYkt0?=
 =?utf-8?B?dWh4ZE92cys0b3hZejQyUWNSZVhZNHdwNDhaeTl6RFhYWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:21:16.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf74e0a8-7ecf-43c1-32c7-08dc8babb491
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9955

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


