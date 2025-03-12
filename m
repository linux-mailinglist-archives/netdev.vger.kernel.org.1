Return-Path: <netdev+bounces-174155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542FA5D9F0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EC217124D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCA23C387;
	Wed, 12 Mar 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvGw2fmT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE21E3DFC;
	Wed, 12 Mar 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773264; cv=fail; b=Lq0/IkGDPq/Sk8Z0T05E1fo5DdWA83r+NKa23I5RAtPpUt+1guug8+vEWIdvWabLrYbPoSFicBMucHfHm9QzvsRXgEsa06wu5pytK6uDaeX+WEwUksnb0ugaAcd+T5PFJ5qWypl0wb4Jca9T9ABwHftnxUaXOdqnC6DdnIWyfOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773264; c=relaxed/simple;
	bh=cIqikaqUF0Zq/+1WhBa1YOVM/PINA+S34YdCCbNNmLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1BS6tiqmMa91EDmwkxKEHmkAc2DSXCXHm5Q/G7urYPngC9I2l/YlGfzCGvTZN9jeSA4GAzjCXTXGV4sCfcLB6thwTNbjook1dA2XU1SRCwJK+i9a7oj4LweqS/dJO3WFECQmXSwhdQpzs4ToWoT5tz72kVoyiOUkH4o4Orwpf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvGw2fmT; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7CzbapKDHHCpiddP+2KPpnhqpt94KpXQQXcXRFFX6/90ugVwU78Ey+2t/ChvohKELLa40XmwsMw5PAkfPuV+VHTdFzwN4Jq8HoNCbs1dzVCXPs2n9C4SQC7WhlrFE+Anekobc1jRxgp9GQeKxP/FE5Zk+pNUxIQzJocRL0AZrUcZrb9jesEBoFORiLIt9R9V857l8EEF93A10cInAA+goGqu8ROvOWTl2RZBqPnaC+nJP0VYHOkCKptz/bZsmYfWIlFWQOXaSAAoNxHRjLLCSd+dGiusQqQKsaHk4zGjCuW8PMN7vNlfkxl+V2Q3OO37qvBzy2Rd5lGRIKTdtVgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI/enS/gSnthKs4EEBRXflgdsBsnnOZvJqwo6z0T2ko=;
 b=TXJBKKyxuom4fXmOXWcG4MzHnAZ3dyWK+kSoLyp0+YqzI5DnTu+//bBQIP1C5C5jPjic5ppmR6500kgMgCJlcOOp8W6VkRQaNKjNKgwDZajGJSWPnM09PMQ+dz7ytDi41NTiPZQ4eRPZjyqZpP2P2f40bUMOTvkuUFA/5vaFlz/p4lVDvanNv/fhJOpm6enTgZSb3VYgYtc+BuE/DV62OoPTIc/79E760NbUO2kKwu9h+9LIwh7ljWuPL+Iyhrh0gZ8ti3k44fHB2mKIvjt/NYpWpd2vWR1g+KxPx1E0/KHXTLRAmtx71ZVatUdNo8yzuR62MBBPshnUbKMg7UwXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI/enS/gSnthKs4EEBRXflgdsBsnnOZvJqwo6z0T2ko=;
 b=lvGw2fmTMCIlWy3eO60UbLCFN3yiDNZBZRBf823Va7MEjzgDT5jM8BOTpWlHuyZu+rW0R+GY8onNlNTiNnPzR38DLiitF7wDy6Qzoh1cVzNmuw4oIPOOawHwovUw7BRI5jjozJDP1ucQrljYeOUGcuQjg6IJiSbSk/lmyBNcYn0=
Received: from PH7P220CA0175.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::16)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:54:19 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::b3) by PH7P220CA0175.outlook.office365.com
 (2603:10b6:510:33b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Wed,
 12 Mar 2025 09:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 09:54:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:16 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 04:54:12 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next V2 0/2] Add support for 2500Base-X only configuration
Date: Wed, 12 Mar 2025 15:24:09 +0530
Message-ID: <20250312095411.1392379-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8d8906-9cb8-48c2-dbfa-08dd614bdb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PVkKtbJQSsOBOWQMtvBDeiPNI8LJXl5ix5nSYaSkUsgfzAa/k5QOhcNIpfxS?=
 =?us-ascii?Q?EsaGZlt9S7uhJoSJsJvwZSsDKwcWD1KM99GfEXBt/vruvqbZ83nvzJ9BBC5m?=
 =?us-ascii?Q?Q521WC84qvJeRzFkEljoyQLkf+HJJoDjiMPIkkzOHyPIpz16ySS9o9Tf+1Hj?=
 =?us-ascii?Q?jAQvtjJu71FdWzSouvgDeDaw3t2jznIuWUaMNya3ovTlc6JdlGNIzz+tD2dW?=
 =?us-ascii?Q?JHZ2xnSJ4Oee8ny+bi/jMRvpzijBdaCEp6v9U86shlY5O1n2EZ20pjBSp3qV?=
 =?us-ascii?Q?l10BVW9UV3yLVTOvBpOeIhrRmPQpYxZ0ZRXLNbiTZlSC0nb0JB1PuTg+7rsp?=
 =?us-ascii?Q?s/Nqr8GiQQOOuoh38pLhdRe+sQAdxn4w4lybn5HSwFKgulBLMogRyYp+Kl4W?=
 =?us-ascii?Q?bpvN1KgAcEqhGMwIZIsRdQOxRea2IlbUH4g8eHSigJpwD2oZwu5IHL+JdAY9?=
 =?us-ascii?Q?mOPR866ECcJvU2AYiyNfciIhHkBRbhZZBIANIRdOtnzCrTbm0lW1+SBduy50?=
 =?us-ascii?Q?zi5i/E25M/xFrchcikNujwBY4OWQnDbcSzyv9Bm4BnN2zrAGtKsyxMaGZySy?=
 =?us-ascii?Q?YrJKuTwwZeKA04jh5p/zAD7a2v4lmU530gCzy1m4tMGiBgFd5lllOWGfHTyM?=
 =?us-ascii?Q?zIR0m2o6LOi9P1FM5RKaFpnpTZT8XzUWfwSiHoknvtEVQCqprOWPyD5u9+pg?=
 =?us-ascii?Q?OUbN8jB0uY14Wvi3NJkyO+P48I9UTcrOpJl5d53q9Fj1Pa4VbB8K75w3Rgrr?=
 =?us-ascii?Q?xsf+5IrVuo7XL+ADMk3EUzNNo05vzxeWq6QoDn/SJf14Gqe1VkaWL0Jpzw3P?=
 =?us-ascii?Q?LBW0biKTb7Giu+J5w4hRanzJM0BkTwOEi70O9x5n9bX7mxaKvtMpG3x4IL58?=
 =?us-ascii?Q?zQAw5xj6E34kVA3cusLwWL7ku7Xp3wvTr1kTs6aC/vi4dJiDgR3h9LP9SUT0?=
 =?us-ascii?Q?I52CMJyi8xmxNTf8jSj4uaayfYGWtWSaweA6k8JamKFnQqgJRnwTmMalAN7C?=
 =?us-ascii?Q?/35VNLOVwHYYQ1lpi8fhp94lTE0zEpenhDofEUTfDgCE3FHsH7zC0OeW3skq?=
 =?us-ascii?Q?wbZ8zJcCnws0Tlh+logSGqTt/lV1qJTOOIG24l9zjelee//Don0xqjl7h+5v?=
 =?us-ascii?Q?gJy0WU78I36nKGONkylmDPDIPmTSZGzI+5uwCSrWSUJ2kzcpSSqMP9gTWEwx?=
 =?us-ascii?Q?ezYnq9nGVzJw9f7UxAhYcF0VD9To2HMyvGh106S1Fdg8R8chtj8CMUDl9lxe?=
 =?us-ascii?Q?6gAK+9vDucBDf4EFIEL3dQTRWnyxw6/wILYetc12ApUxFKnEX61xgBv77n/t?=
 =?us-ascii?Q?cuY8QgV7BKSt98GuTCdD/WzDJ6TZNXyzfg184JXE/AGWGkKDRjxiNYzvftAC?=
 =?us-ascii?Q?V5L9MipIJfKlYMaUS5Jxy2r2aWO7ZXAxAlAyw1WOkFXywWkuKIOiBcNG3XAp?=
 =?us-ascii?Q?/TVKsrveg2EHMX6mvd8ue5vMduQNO5fgou45XewNIWbKCRVxJ0wA8pTQ7ZVo?=
 =?us-ascii?Q?oPJKkkIW+/MZUeNTH+bIO9h562OAx7+1nDde?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:54:18.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8d8906-9cb8-48c2-dbfa-08dd614bdb15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

Add support for 2500Base-X only configuration, which is a
synthesis option of AXI 1G/2.5G IP.

Changes in V2:
- Read 2.5G ability from Temac ability register and remove
max-speed DT property.
- Mentioned all 3 IP configurations in comment and commit description.
- Mention this series is for 2.5G only configuration.

Suraj Gupta (2):
  dt-bindings: net: xlnx,axi-ethernet: Modify descriptions and phy-mode
    value to support 2500base-X only configuration
  net: axienet: Add support for 2500base-X only configuration.

 .../bindings/net/xlnx,axi-ethernet.yaml       |  9 ++++---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 +++++++++++++++----
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.25.1


