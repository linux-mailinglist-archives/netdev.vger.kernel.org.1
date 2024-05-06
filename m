Return-Path: <netdev+bounces-93741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8608BD07D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE311C21902
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB791534FC;
	Mon,  6 May 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="D+SUhDG1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AD13D2B5;
	Mon,  6 May 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006496; cv=fail; b=K0y3vme6NsdCFhjA1bP+pXs73ze8jdje4qgA5QwuTiN2odVzVm8L2Q5eEbwrzp01Voe//1oQMxgZ5GJcJq/2ioX3pqHO0G367PS56Gzxii/zGBdzVR3B76OtUi1S26dViXbaYPVQPvtW0jQqRTask6FdjHGQ8Yz8WH1K8rXvHQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006496; c=relaxed/simple;
	bh=VtXr092UlbS9qSPvCTznzcG7MHb5PuYqJvIkHrq1Lrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYu3wOo0yrCAXhmS8NcdkaBdrVUXgwzwYgxA8v3hFV/sX+zcVz3YxlXVp9cHiR0FLev5sHeTPVamhjmH2x41kxCpWqbLd8db63zLVaOj35spaM0uj7CA3YNSSwRZHJVZ50GXcsTKTPexxE6FWsXYsKhXH68bxwHPv3FDrIMOVRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=D+SUhDG1; arc=fail smtp.client-ip=40.107.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIXBOHPGXOjEdsMuoUmZDG/RMK08oXFtHBqgvKMA97+59vxUUuSjeoWr+Qgk8NiiEO6EzOwl00S9kqi4kZ9EVbSZVqI3+QIlLcGQcluPaEGz40aenTD6Ds25IMy0sW17xwAiKOMoWau+a+BUVK6G73BOatIjyTaUbm2zRfq+XEz2dm0gguY1EUQ8g7OiPgUKEy+VehTbbHSQV34z+QfG45fp+fiPrsNcA81KorJwpYb/it12tpcIK6RzrjGszpy2KdKLN9hK2cXfhJQpOtrer06j3WrTfsupbUUzTIpfpadmXLjhCSjIIpdnIBK1Hwm/YWeCHIMPkBnlId9XqoAVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esEuBF78dWh7jCOQeLpLvTi8NKTxafBM+zJwDMWqL4M=;
 b=G9k1lalJAefoi5C3m55MVWpE0Lx4//4zpF8TsIWlY9idRYhQVbiy1TvW4c+W+Pyg/yDt7W067skpOQYj4UQTk2RlgfV4AhkDymH/3pYBVen7NBlWP5IAq5M6gG5hTZQsVexHKJ2ZPIWatNRl4Jc4Owl9pKIn2CI2NqFxOTN1CKUw2JExd0Rewk2CtOXeEXWKL50HSgYQo/ZZs+mFrKUqOQUnhSFM8PsZtoB6Nb5JUBcCXqgaJ1KO9lHKXgdgFw+HMQDzflLrOagAXeg9ax6x+HRpMwzmHL9KT3SacG33GlQkfeXOlGhV86DSVtV40Ulm9BAHP1Zvtjk0DLwBgUxeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esEuBF78dWh7jCOQeLpLvTi8NKTxafBM+zJwDMWqL4M=;
 b=D+SUhDG1Q+UUVDlcC6EUXyNBdI7RvJOTDr3Qul1MCwrpEO++lmbTlrnebpEZq+IAFdJAu0ayp8w9Nk0CoPKOrFxEsrtz550Sea8xIw4Wnt+b/d2mBdr5cK9GCWDlcYvtuRdQFbBnsotbDxC4XF8KMMfDtj1+0e82IoM9Mb3U5hg=
Received: from DU2PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:10:2b1::25)
 by PAWPR02MB10022.eurprd02.prod.outlook.com (2603:10a6:102:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 14:41:30 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::93) by DU2PR04CA0230.outlook.office365.com
 (2603:10a6:10:2b1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 14:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 14:41:30 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 May
 2024 16:41:29 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Mon, 6 May 2024 16:40:12 +0200
Message-ID: <20240506144015.2409715-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|PAWPR02MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c3441c-b779-42a0-9a77-08dc6dda9e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEJXc1J2eXZaQUJxeUFqaTdpd2JkZ2NPOHlmaXFBbXRpVk5Sa1U1NDVIV1VF?=
 =?utf-8?B?eW5CUUpkbUJ6SXFwWWtqeXltUTkxWVhIdHhhQ3ZaY1lLNWZPSUQzVko1NE5r?=
 =?utf-8?B?YXoxbGFBNzlhTG9iNUorQ1RMUTVnMk12N0NvcUVZbFZWOFNkY0VpVWN2bU0w?=
 =?utf-8?B?MGJZNVoyVmVLZWhnd09odEZoU2d3RUdGak93VWZyWHNZNnRPY0cwSFRoL0pw?=
 =?utf-8?B?d0d4STlMWWVRZ3JlZU5LVnhJOUZMdFA4dDZkVkVTblRBeTF2clZYUUl0eXZ3?=
 =?utf-8?B?TzJwNk5SU1E2R1NDNXMvVTAzMUI0aWkvRExEOFcwSFRoZ0ZuWGdVNzNVTU45?=
 =?utf-8?B?OTViUkl1RWtrYlNUV1AxOHRYR0pITWpZMnViYlM3Z0dMUUZZUms1Qzh5dlY2?=
 =?utf-8?B?RmxCdDk4UU5LRm85dHJqbU5PN0hBSFFwTEt2c3MxVFp5M2FZZ1BmYUpsT0FO?=
 =?utf-8?B?bHB0dzdXcEc2UDlPZ3JKbjFoak9rWXgxOVh3ZVhlWkI5VmVlWW14MEVqOC9q?=
 =?utf-8?B?SkVDcExYNG5vWXlLSkczREt1SEZLSi9oMnJpMUNidWpvZG0zMG0vdExSOFQ3?=
 =?utf-8?B?YjR6dmh5ODQ5eVFCaXNHdFRyaWhhVDVUeEZnMTFGdlRoaVZpZ09aWm1KWEJs?=
 =?utf-8?B?UjlTVW81T1JCVlZHTFFSUWtSMlozS1hxbUV5RllGdWRQSlc3WWhmU1VHODZ5?=
 =?utf-8?B?ZmxOSWxpQUNUUEhKd1FZTjBSRkxxVmhCZFdqUHp4RGlmZ0Q5VERSK3dZWXNr?=
 =?utf-8?B?MDgyaWRDS09KaUZGYWZJa1lrU2Z4YWFldzNZMFB3QXB5YnNMSm84QlNVZE9B?=
 =?utf-8?B?YmRDVWRWcCtVUVJRMlBIOWc0SkJKcGhtMllRRGNzZ1M0cTllc252SDdZWFhv?=
 =?utf-8?B?dktYbmNmcWx2TklkR2hIT3ZnZGlyVzdPcTNUelhwZE45WUF1dHQwRUt6Wmkx?=
 =?utf-8?B?ck9GcnY0aXQxanZKNjFFUk02T1NXMm5BZFJXNEFRb3F0QTIwd3NySHZrRGxV?=
 =?utf-8?B?eC92QXc0WVhIazIrVWQ4azhtUVJUYzV6OGd3b2ZPYm9JTVJNbXpHTEpIOEd1?=
 =?utf-8?B?ZUdGdXhIb1lpYmljOWNJT3E5UkdzbGIxOUo1UDhjRjVPN1M2M3hKREo2U1Z6?=
 =?utf-8?B?WEQxdG9VYXA0akM2UXp1c3FiTVoyandnL2tyUE5IL25LM0FiVmV6M0Q4T1F4?=
 =?utf-8?B?ZXBWS2IyTE4ycnBlNmhZUjlqbDFLeW45WDlYM2ZGajFaNWJrSXlKVk9Wb0JN?=
 =?utf-8?B?V0tEakRscTlBNEFOOThDNUFFY3NwOUNiSGplMGdRYjBJUHNNd1ZGaXIxMW1v?=
 =?utf-8?B?VThlYm1RU3lmZGtFdm1KdkgvaWpVVGswMGd3M2lDdXZ5bEIyR3VTRUJCWlRF?=
 =?utf-8?B?alBCUjZpSUtpVGNObGFqRFRScjdnZ0lya09XSUtuN1kwVDBGbU0rdFFmR1Ev?=
 =?utf-8?B?UlBmZGlOV3RQbVRTWHpDYmI5d3VMYVFoOWlzOE95OGhOd2ZwYm96aTZicC9x?=
 =?utf-8?B?VG5JOGFCV0h4U1M0Qi9OZU02dGFaMWVDd1Y4dmlmeXlPYnMvUkNVS2dJR0ZM?=
 =?utf-8?B?Nmd1YXVQUmJSaklFZHpLb3dRWU5ZOXBMZHArZkpIRkJNeXNDaTF4N2FVMGJN?=
 =?utf-8?B?QVBHSWZUR2pCSDB0V05UODc3MUd0cHFKeTc2UjZLZUEramxDWjVvUFdnOFdB?=
 =?utf-8?B?RjJib2pOeVJjWGhKbktDN1lvOE0vaHQ2SlljdGRPNmJXcVVGOHRhclhadHdJ?=
 =?utf-8?B?eURMSzVlK09EVW1NSUxhOTFKZStPbkdXQ2VRL2kvZzlKbEJ0TFVCTlN6UnBz?=
 =?utf-8?B?MHAzVUEyZWRtanJ5ZGUyT1hMQkJGbmFkYWVBVGhKV3c4ZVdia1UwSjJ2aXdq?=
 =?utf-8?Q?fbaNxpTDBwvvr?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:41:30.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c3441c-b779-42a0-9a77-08dc6dda9e5d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10022

PATCH 1 - Add the 1BR10 link mode and capability to switch to 
   BroadR-Reach as a PHY tunable value

PATCH 2 - Add the definitions of LRE registers, necessary to use
   BroadR-Reach modes on the BCM5481x PHY

PATCH 3 - Implementation of the BroadR-Reach modes for the Broadcom
   PHYs

Changes in v2:
  - Divided into multiple patches, removed useless link modes

Changes in v3:
  - Fixed uninitialized variable in bcm5481x_config_delay_swap function


Kamil Horák - 2N (3):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 338 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   9 +-
 include/linux/brcmphy.h       |  91 ++++++++-
 include/uapi/linux/ethtool.h  |   9 +-
 net/ethtool/common.c          |   7 +
 net/ethtool/ioctl.c           |   1 +
 8 files changed, 560 insertions(+), 21 deletions(-)

-- 
2.39.2


