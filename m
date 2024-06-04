Return-Path: <netdev+bounces-100589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE558FB3F0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2858BB248AD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A121147C90;
	Tue,  4 Jun 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="N8Cm7p1g"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F392146D63;
	Tue,  4 Jun 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508240; cv=fail; b=k0RjJCUymbeo0RMSsS20iCQ2bLjHID2Nadx4tSARa7JwSNx3wfqvxiYb/xgxIRh0xz2HYaDgNL13gXSK6iQ66XbaLOhyQBZodr92u4WDRqan57T2SOfzuQeu95cLx9M2QUXQJWmIEM7f45FMEPVqC0syXMNOi3T7EwdPXD6H9Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508240; c=relaxed/simple;
	bh=bGlA0Fe1qbGLCYYOc2+PPJ+YxtczySNQTWxhFIJzyqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxTMs+l+WD1+GhsQp75tMC9I3xj/fGwIncrbxSJL/machXMWbrkHyab+OazmdiDyDot8kCg2/HyX0nFZ0o5aPGsQEbrW+jxWUauySEioy2/IW810iCCZg8zkB3FQmJZ+achhJVy1peRhT0AXxnWJnu2Lxe9WY7PqGuSD42xgFek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=N8Cm7p1g; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCpgJEOgfWYIsPMVxJkad7C/hBjIjihDvRt1CMBKnnQq98LXAhdMdjQ23J5RvdOF8YabChE3gD04+y8v5mEbYh1awKB0LdLUAzOi0U2A9p73X9Ql+H9klzuNOiP970+lMWt17SGpCZE2YT/ncIPKzsEi1r6bL0DtAE8PEtA4sSq/WkEfEgT8+mJ95zYipkmtXePlB2mq/mqt8nQhETLQhZIZ2l6VuHIpkThTkDB03EYN8XeAILo0wQBqEf3j2JAPVsc2EFz7aKUS2YzBrRukhLxbMMDJoqP5+G/+TB6kXVf7/9qbVk3sgny8guQfwkDDeQ9yBRbSJAMEAXcNIztUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQjVtp4EO55ufhI7vbF8hFze6hhoAylrf5+cYuEtggs=;
 b=BiUSg3zFGBfFx7pcXp/KDYcty+ynblu0G5fyZI0s3G11VjOeZhX064+2Iy8/6nMtWOH2qSmT5pJtL0Z6dy8JP9C5p97ApF2oHdKAZ4NYAgOUPyRDBeiwEtJr7z9HO1PEPBFZQcNLlOOwr7ASPfKvt/ZuEU4924n1TSe86AtngN9G06PlMVLvgDq3w5RURi+bOE8wp2UdHcscRSD63ubrPoKxPZu/GCv2SO8KANqezcSdrqY7k4aHkGgkgA5/oO4vHMrybiNFwVHf6KmzxhvhDCkXA7zvaNlUkEmavTrtqEHLcfWERMDaGpT1s98lomqor2UUNM+ftsl5u/hi6nEANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQjVtp4EO55ufhI7vbF8hFze6hhoAylrf5+cYuEtggs=;
 b=N8Cm7p1gPbWRAJ/uB1uDYqaB6Cn4g6yeNH4zcsUiPxe80WpPO55z42pIz/+895nQ/j+qbkgRj/TGu1bpqg59NTj11jdvG47TyiCPxK8hPPHh6n9L6t+f905eyNlQsQClp6mfTAz03Whu3497dZ+PAXrks3RVnvfc8/ovE5lNYOs=
Received: from AS9PR05CA0223.eurprd05.prod.outlook.com (2603:10a6:20b:494::19)
 by GV1PR02MB8564.eurprd02.prod.outlook.com (2603:10a6:150:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Tue, 4 Jun
 2024 13:37:12 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:494:cafe::d5) by AS9PR05CA0223.outlook.office365.com
 (2603:10a6:20b:494::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 13:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 13:37:11 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Jun
 2024 15:37:11 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Tue, 4 Jun 2024 15:36:51 +0200
Message-ID: <20240604133654.2626813-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|GV1PR02MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: c028ceed-ec1a-4ee5-9464-08dc849b7029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmRDZEJ5Rm5iRVRsS29mN2FvQmlRd0NoL1dmc3RWc3lFZ1REeEtNbmZ3R09n?=
 =?utf-8?B?TzlDd3lCYTFHWEY2OWx3Nmdtd1ZGdER2RDc1Q2tna1VyQ3A0WkVRdW5oRzV6?=
 =?utf-8?B?RnNpNXhVdW96NzNRME91R2J1a08zU2FTK1ZlWnpXcmNZV1NtQUI5VElwcXhW?=
 =?utf-8?B?QWRHVVNmczJySmZqdXVEN2l6NzJtNm9UR2d5b0U4azVaN1VkcFcrTzNLQ3Ux?=
 =?utf-8?B?alNaOGlEaXBUSFJjaklIWWpRK0d3cWhscXkyejJyRis0OEUxRHNEY1Y2SWho?=
 =?utf-8?B?ZDdBcVdNQU8xUVlpbkJEZWt6WlF5dStxOXY4WG9ReW9DSDRTMDFZU0Z0NnlV?=
 =?utf-8?B?MUozSnMyZ3AvbG5uSVFXZ1QxMVVSSTRtMmdkUHo2aUg3WldLeXluREgza1Zz?=
 =?utf-8?B?Mmg4T2pKdmdPVkp1Q2VmL1NsditjZG00ZnBMQi9JRWpxaENjTno2R3gvOFcw?=
 =?utf-8?B?MUFXNHhCRWJKK0puRTJTSGtTTklpV0NXanhEZ3dzZTZhNlNySDg5a1liRVhR?=
 =?utf-8?B?N1ZidGNIa2xIaHJRMkl2ZUpEWW5Hdy9LZVZ6QzJYMFVxQ3czM1FMVjRnZVVT?=
 =?utf-8?B?Y05NNWJlbmFvcENWSWRZTEFCUXhFK0k0ZDd0S202enZ0MW9vRk5qSlRDYlVR?=
 =?utf-8?B?S1N0WXBDQytyRktySWFUL1NLTnIrbGNiYTVGMDBjdGlzTzMybUJheTA5ZHZY?=
 =?utf-8?B?VVB0ZUNDdzhkY2VyVWh0bkpJTllENlVuYWdXdTJpSDNpbnpyQTNQZVFCSXBu?=
 =?utf-8?B?Vy9KdnF1YWdhdGxCcjRyZjhhK0R0My9YNXVlNGVWaDVDZjcwSGpnOUZyaHB1?=
 =?utf-8?B?UDlkd2lzb1MxZWxERzZjOE9sSmQ0QnE5d2ZaYWk0NmJVM21GZlNSODBUZWNT?=
 =?utf-8?B?T2ZEc3NFVnhDRURScGdoV1d4NGZVUjVIWlBaVmwxeHQ3RGl4bEVIZm8zZmRC?=
 =?utf-8?B?VEl4aGhVM1RJRTRMS0c0VnNWaXR5aHB3Qk54WjV0azAwYjdYNUdlY2VVU3BI?=
 =?utf-8?B?QjFrZ25sWHU3NXFqWnZnYUFvREw2cUMxTTVzclZWdE1CUVpuYnlaOVFlb3Ri?=
 =?utf-8?B?ZkhkK3lNbmMxUmtGa0pYcVFscHF6Sm5ydFdWR25RQlVTYmViRXFBZkRXcDFu?=
 =?utf-8?B?dkMvTU1zcVVNUHA3bGM4T1ZzazA0dEdyV3dMS3J4NHJtSVMrVVlEWFlzajZi?=
 =?utf-8?B?VjE0WnEvejEwSklHSXlNaXJ3MnNjbHovODBJazczbUUxZzV2cWNuUTdkSDky?=
 =?utf-8?B?RzJxSmt3UFF6YldQNkJoSzlGb2lXdzF4WGpKZ3NxTm42RFpiMXBLVnIyVkF4?=
 =?utf-8?B?aGRubU9sR3AxbGlUWWtzQUZSeW03ZCtnWlRyR3BGZjRxWnpwekJ0VndXMEtr?=
 =?utf-8?B?MkZRYXFmOEYwbjh3bXQ2Rll2YW9OUWxhKzkyc2tYc0MxTC9UMitkUkxXV2Vh?=
 =?utf-8?B?VFVXMjdMS0x5eElHL1p4Y0hMS1l2Uk4yWUdldEs1R1EvKzZvblpKUVNSUytJ?=
 =?utf-8?B?OC95OWd1WXk2dUxlaHpPOHdCMUI5VW1LK2ZDSXR4eGxRR1Q3TVpKM3pBMERk?=
 =?utf-8?B?M3FBNXZnQ1VpS0JrcUROT080SCtFSE05eDVKTlFhd0lvMGgrM2I2bVFGa2Ev?=
 =?utf-8?B?Q1RuMHRVcW5iM0liWU1kc0ZXKzlmZXB5MnBxMUwycitHcGU4NEdsdEF4R09L?=
 =?utf-8?B?aXBBK1FoVVhmV05xdW5Sckgxd1pwd0RaNitoMzM1eEw4Y2Rma2JZemsra0ZQ?=
 =?utf-8?B?THBBdDBmK3l4eFFpQ1g0UWRJS0hzcy9mU1crZGlJb3JHNWVoTFNRRG9GdWw4?=
 =?utf-8?B?NFV4YWFJVjdrbE1PeDlydjFkV1FpS3J6aURXYjlzbVorMjhTV1B6R25zYkJG?=
 =?utf-8?Q?Zz9rVWK4QO2xc?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:37:11.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c028ceed-ec1a-4ee5-9464-08dc849b7029
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8564

PATCH 1 - Add the 10baseT1BRR_Full link mode

PATCH 2 - Add the definitions of LRE registers, necessary to use
   BroadR-Reach modes on the BCM5481x PHY

PATCH 3 - Implementation of the BroadR-Reach modes for the Broadcom
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

Kamil Horák - 2N (3):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 drivers/net/phy/bcm-phy-lib.c | 122 +++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 368 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   3 +-
 include/linux/brcmphy.h       |  89 ++++++++
 include/uapi/linux/ethtool.h  |   1 +
 net/ethtool/common.c          |   3 +
 7 files changed, 574 insertions(+), 16 deletions(-)

-- 
2.39.2


