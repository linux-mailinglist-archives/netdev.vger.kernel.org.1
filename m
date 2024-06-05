Return-Path: <netdev+bounces-100912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE88FC866
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF11F212EC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5518FC94;
	Wed,  5 Jun 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="koiLX7EK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5B14B093;
	Wed,  5 Jun 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581433; cv=fail; b=LJsxc9TnzjL2GXZP+QndTn47AmYy9yMXBVGrIwrqMxidl7N/ZCJow5iP/N5+uQKBIpvsO4SSEHvYwwVvN0J4uwFvkVJFrxS16emhH13oTQfKn7nOihbhJ0W9yj9ljI8Yhqi9jLfYmtbD+7OUn6E7iV+t0wVcw19SBA+vxNq1X0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581433; c=relaxed/simple;
	bh=qD5lz8qbBErPZy7JTc+dICOk7xKVhqvqzBUPqk4FTwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLfw1PfcHhVTVOqFupqoWwYRufg4QQ8PSOg0yDjVVhDfUuDM4opZ16dAdhDB6nSshGof48To54pLdFeHpqo1jR8/IUXic+ahcAr932dT4FVkQQiVxFkJP7NIORTNQbrXkCaTgL0vViK9gynwY1L0d6fJNpl/VYpBfEy4k1l+Mvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=koiLX7EK; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn+RiLEkmXaPZeZZz7MAI1TR0BPHM8u6jF7RtnX55foxRi7pFRxjpVngs69I6d7MOlqKShycawMbz/DgaXeTCJS+k5Ph6XY61XM4va0wVvAF+ZTx2UWLEvzPQ8C5ROwZe25OUTXYwQcFm6M7Sx4LbIXW0fe/Bl1y+upHZ6OWUDZ4FsGKj+8SY0+UmR1Gs6ZKguOM9P6mxxhJDtUrFQk8FY38jRLJCgsvosoEum/7b08CzGe88cqyN2ccvMP3VlI0wkp72xHyKugtB1OuoFcXW6QnQkY8hqmbhGp9ohtbEJR2REZwHv8EiZxPXLv5dGl+1W7RMXwL2+6LeIxfbgFTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD17DAAwXcHkqcRexV97Vuxb+MEBNEYvvwJ0VIIUMRg=;
 b=RtOshCSg4KjakMDvRzQVjlzWw9LAwYf2r+8TC8uPuLL1z8Yi7ZirZXlJlbDsHS50Tb6Xa+QzYztpzYFO7qUDYqjbbAT9XffNxaUyJ1oW4qGCCgh/VuVbhucQEhhRXJ3j1XrSiGoE12rE8qqrU9MyitfDQlOI5DAmgyPJExGCrIfJIUqXTT8gC+EFu4i3lZhe916/PqIHZ4Db3FNh94hUsCWghgfXb/wN2WtWjzmCJkNc1YXM0mxGgImslAw9xi+O7y9ANH1p+XNt83UPcYVMsRtfjoRRhppZ5+SQW96BnHW/iIr8iG1/yBCdq4gk6pv1z+uVGZhoBMaH/vsnkvoClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD17DAAwXcHkqcRexV97Vuxb+MEBNEYvvwJ0VIIUMRg=;
 b=koiLX7EK45/+KF2l+TUK2B8czk+HryqEJkQbAmvTtdYHd58feRI+5C152m/cKPf78KvA2ibqQYCCBhuQNBcBZk/U3Lh/gsJE8VuTHAS82qy/tDr+jcm7qRCB7Amn8Zdt4nWtt25lbwm5aRhPJBPWNluoc125s9LhZRgwMNPYLpI=
Received: from DU2PR04CA0238.eurprd04.prod.outlook.com (2603:10a6:10:2b1::33)
 by VI1PR02MB5887.eurprd02.prod.outlook.com (2603:10a6:803:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 09:57:07 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::df) by DU2PR04CA0238.outlook.office365.com
 (2603:10a6:10:2b1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 09:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:57:05 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Jun
 2024 11:57:04 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Wed, 5 Jun 2024 11:56:43 +0200
Message-ID: <20240605095646.3924454-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|VI1PR02MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff7ff8f-14e8-473e-1aea-08dc8545db12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amYwbWsxQjlDYnIwMHE1R2V1Q0d6ZGtndUM0azFOWHhBM2ZrUitwQkNaakRM?=
 =?utf-8?B?WERKNWxVYWsybFlGUUdEdVUrbjlIZnlHaXBRTm5LSXJONHRodVJzaFlvSkds?=
 =?utf-8?B?Ykg1TWppMllpQmhOK2tvL3BQYWlxYjRBekdtWm0vNE5xSUNYUkoxdzhwZ3pG?=
 =?utf-8?B?OVNXdi9KVEFpT0UvVnpXK2h4TGowdmluNkI1T3c0RkFYSytXY0N5M0V5cHhK?=
 =?utf-8?B?bHpHamRTZXFFeEhOaGdSMEQ2eCt2VTBFZGRvRm9nM3laS3Yvd0Z6eGJkSCth?=
 =?utf-8?B?R0MvL1llZ1NEVmoxejN5bFpFKy96Wi9XOFRLbVVib3BYTmo3T0xTMXBRbWF4?=
 =?utf-8?B?a2RjKzRqWGpxbTFQUWllQmpZWHNKUFhyZCtiQ1NzM2J3T3MrNTFoUGFKLzVN?=
 =?utf-8?B?MkxKNzlrdVU5UVY0c0Irelo1VTZLQUNBbXZyZE1CUmZaQVljNUVZZ1hYTEwx?=
 =?utf-8?B?OTRFVmxEd25kVXM4MU5yNlRnTkVEQUxuNE1qbjBIdnlaRHR0Z2Mzc0tjS09M?=
 =?utf-8?B?Wklxb2Q3d3QrN051T2gzdjF0OVpSem00VG1XcDVkdFludDBBMjVqWEh2eXRU?=
 =?utf-8?B?NVJRazF1ajd3NjJob3RpdThWQ09rMmxhQ2lOVE9GdDFLWEt2cThqOG90U256?=
 =?utf-8?B?dEtFMmIxRUJrYVQ4clRXR2U0OGFMbittWDN3YXByL2hrUGJFNHBCTnpuZUMx?=
 =?utf-8?B?NUtxN1F5ZEdrMDNvMzdhTzNTYzJHVEVSQTJuend5MjRBQk1qV0J6ajM1R0lw?=
 =?utf-8?B?MnUzTjRUY2puclY2OFRKYnJHK0l5R0k0dlNNb0pmcHNZcENrL0k4QVFtSC9o?=
 =?utf-8?B?bzZYNS9iV29zejIrZmdvOWhoTUdPdHhrTC9tYWdSVTkxSFFUVkg1emhRc0wy?=
 =?utf-8?B?ZWp0eE9KdDlSdytKbWlrTGhFcVZHekp3MkZsblRPU0crRVFLVDJmRkJocnZw?=
 =?utf-8?B?NUMzU3NtNk9nK2tOUUF5NExCOVh5OG8ramdxQzZVVHNTVnJwUFh2WTFYUmZD?=
 =?utf-8?B?bnZhbWVmU3pZU1pyd2l0NVJTQk9NS0QwVnNyL1UySWl0UkZaRG9mTTI4U3h6?=
 =?utf-8?B?UDByMGdBVUFKN3YxN0RXem0reFJlK0JERWRaR1h1VjdNREJna1J1OUtrUkli?=
 =?utf-8?B?MHMvYXY2V0RGOXBGdXdXMldybG1zVXA3VFA2SWhzM21Yd2tCQjAvZG1Md1da?=
 =?utf-8?B?UVpSaFB4Q3N4S2lwVFlhSDZVR1Z3dEo1SHg5M2RuTkxzc1l1SGh0N1U4Yzh1?=
 =?utf-8?B?aWVENWFRREQ5MU93YnNvaEJNcDJORnVldXNtLzZxTXhpbVJBSzJENGpTRW44?=
 =?utf-8?B?WktRYUtpTkhndDcwQUE5N3FzTG4xakorNUlNV3FFaURjSlFLTTdQZExFdmox?=
 =?utf-8?B?T1g5WjFwMUl5dUd5ejJTSWZWcHZIVkFzWGloLzVOMkJLTE5ZR1N5NU5WWkJW?=
 =?utf-8?B?dUROaFpTMEVScHIwSXRRTlZEQi9oVi9PNUh5Q2lzMDJnTkVNWkNoQkg4OUhZ?=
 =?utf-8?B?RzVZYitkd3JWZXZmUG5Xay9OMnl0ZmdqL1NRL1pQM3RyQlJMMzZtTUxKWFNJ?=
 =?utf-8?B?RUQ4OC9SVDNiT2NjUDd0TEIvTDdObmtVY0l3WFFJZkZtOXByM2dXMWV3N29G?=
 =?utf-8?B?Wm1ISVp0N3V5ZVRHYkVWeGxVQmE3WnN5MzNxaGpENHJwQnMzNVVTVnJrM2ho?=
 =?utf-8?B?VkRoTTd3OENLUElmYlpWKzB5aE9IcExrd1padmdxbmVFelkydUFYOEo5MWhC?=
 =?utf-8?B?RFk0YzZpRWFWUHJkb1N4bm15K2x0ekYyRUVKOGVyNml3VzBIak1JWmhBcUxl?=
 =?utf-8?B?M1NRekU5YnRkUVBoc0Nid0NqUWRVOWJPbGhZa3Q5QjYxWnM1VmNqWWVqaEhU?=
 =?utf-8?Q?9ZZhOI9sWG7yT?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:57:05.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff7ff8f-14e8-473e-1aea-08dc8545db12
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5887

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

Changes in v5:
  - Fixed the operator precedence as reported by the kernel test robot
  - Fixed doc of bcm_linkmode_adv_to_mii_adv_t function

Kamil Horák - 2N (3):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 drivers/net/phy/bcm-phy-lib.c | 123 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 368 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   3 +-
 include/linux/brcmphy.h       |  89 ++++++++
 include/uapi/linux/ethtool.h  |   1 +
 net/ethtool/common.c          |   3 +
 7 files changed, 573 insertions(+), 18 deletions(-)

-- 
2.39.2


