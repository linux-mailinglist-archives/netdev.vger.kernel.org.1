Return-Path: <netdev+bounces-209026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C4B0E0C6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DF81889E79
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77D278E7E;
	Tue, 22 Jul 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qVyNLY6I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6357F9;
	Tue, 22 Jul 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198885; cv=fail; b=iQ+r/hk19FgIZwDm5dvry0G/QQTbZjcLXMl+D3rlkH+wU38Fr6KaRbGzxR+QwQZXgMiRGDBvSW7PLWwntRWdI9ujNJahi9GbVg4uUgwCuPNQA82lGXr/EDJGJnKu7H8uUdRHWXsTh5I/9ItFawBBDBmFWDKyUvXeIGdncE+/JjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198885; c=relaxed/simple;
	bh=jkZgVQBS0MGcgjfseqkB2gCK6kAurPrnfBqUbLGmoNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDG1GQSTzuMDF9mmMa6KmydbTr9NLKf5bSRIzmsTg+TzcEL2VTAfeezXW9TuKQVSE+VGmrOKIZj97RcF1fMzw/4lSC+kK56faB0MNUDSlWX5Ny8g/OJm4QxvAiEFbn4xvf0djMCJ9RcV/7VkrrK6KmZB78wDcV9WbCMrLxwSuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qVyNLY6I; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c72qsvlYfgibnJrz1l3uF+C+fpLv4V1MNFsBTAFvNFhA1yfFeWRGFaqgHa92u0QLf2qi79De503LfaygEqrcGQp0f23dLF5Csgksbmfs+5HBbFWr/r1ZnOtq0sr8Q4ZgsTakO5G75mWCTHvNhxO5kKbIG2YjWHvUVrOdWsuetgSBOsIXoFFDYmxkA/9x7bB7k09ZcKQKinYTeHfix09sCgV16bRUMCg2AShCk/KQqz/+DtHxnNxfajF+w6X2+ElCFMKr97NtH4MfiyGCDmDl49B78cNQADiFx0VpbNnll7aL2Z0P1BjExTKJpgQNSIfmek4aINPA2tR+C4KxbT6q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMpArG2W2TJeHQmu0BGb2wTiG9pjxPrlGzl6a22z5LU=;
 b=S2lj5IbyEbEifb3GxbIHZov4LL7A58YeHEf2rqu5E8L0NZWQ9RM6++CwWTi6EtC11J7e+ysW1wzcLDzoNikD7uvUWwqts4OKUSyoDzOb1cCGs3Tj1tnezs/CZmxyPN+nzMMPtAKwkuwpwLsfzCtJa+Z8g6Jf9ODYuuMge9GNfRP82shQrnW/jBc8J7OAkG8aSOHNGIAvHKc9hBnHcrJdlxeSKft3nQX2JXjlqQZzpFET1WSuSNO37rzAQGlQ8Qn5tTSuaMPeCqvr9TI3SZpOnKs/CIPc+p1VKRakhJKAiBBvvzsTg3JF80BONNi39/wqTsIYFfRC6deZwKzOrlM3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMpArG2W2TJeHQmu0BGb2wTiG9pjxPrlGzl6a22z5LU=;
 b=qVyNLY6IQrc2kPEl/N1+6/ka2pNMW7aD+J69hv3GoBNCALbLlWhNhc5QJXluUxpK60gqtDC53c0VQss+9rWjn4vvNN2uH+P6MMvjqjs4T2gRpgYh3UiwGBHsBYqigWhQqZxrKZevg2hbmRKoYSeYxrgR5EsGZjvQ2G5LbCR8D0U=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 22 Jul
 2025 15:41:19 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::55) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 15:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:15 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:12 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 0/6] net: macb: Add TAPRIO traffic scheduling support
Date: Tue, 22 Jul 2025 21:11:05 +0530
Message-ID: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 151d9e69-633c-423c-86de-08ddc93632b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+T0dZAirVxrlVd9zhf/1d4RYDgYRLMGF6TaMIEJIvXajdhVDIZ/TF9G/MzB7?=
 =?us-ascii?Q?MUbSXHZwO0eYJb/YYstyuAWK/KCx8Qk0ctvTYsYNMEoGvnRVxTl5v5KWKTFi?=
 =?us-ascii?Q?TUk5oohSY4a6wioAedoYKA9NaEmzs2Y8IFVSF3padSPHMJD8jQ7o5FND0Q0M?=
 =?us-ascii?Q?VarEXzLs8LXEQu3rYj8nAmOkxYqEh+AkOmenUA7NaWUAbtaLQxkyNAH12kby?=
 =?us-ascii?Q?rONorYJlDOu4F7UbxJ6DkW+ssPEZ5uXMPe+F9ZTLEN8FzQdwN5QMRPeivme9?=
 =?us-ascii?Q?j7GoVdt1f5nxVtuiwNANcvSn2cQCpaoLWcg3QGmr5B70MPGGm6zvMuge8Di7?=
 =?us-ascii?Q?mwNbyYdNh0rRFR0a5pkcbFkTqtbIpVJO7h6iBssbDpS0uKqClR36hM8i2bXx?=
 =?us-ascii?Q?iTpegynuwcnuM90KSGLaHIlo7w3Zeh4UbpSKyvtlmBMuvyIZYBGTC/6BoZeo?=
 =?us-ascii?Q?x7vxKK4WCcDiNrpGy9sOBrlL72gh04LAbpq5AjWGhc/S7jWPpsXd9dE6TGiP?=
 =?us-ascii?Q?RfoxLkcmkDiDsiaerL4PMJm1PvxPOeGpPuCjRx4xff8UYFyGBHc0FR/1s9Nr?=
 =?us-ascii?Q?7OWFOrt1/TXcHrkZcvIhUNNSH31mwxctwliuX4BbE2GSFZgXE006emDyfJ1h?=
 =?us-ascii?Q?YXNCQVwjGaQGi7g20runGcBNVs6BnHUO/qkxt3ZcEc3uBg5j9PgyGuXbM/1O?=
 =?us-ascii?Q?Z7JOMOHVZcx2OeD33bcPBE+fjXRMW7HkMkdGfdodcNVgJ4jyzr99myF9MLqN?=
 =?us-ascii?Q?84pnqOq67fwel9Zb5TFM/mLwHln0lshE91DXBJXz+M2n8WJIDt49/tfq60qQ?=
 =?us-ascii?Q?kQuXJm0pWzxWyCQ9MX/ip2FCR+IpGEzpGfaGeYYchc7bcCGtzACdW3NsgvM4?=
 =?us-ascii?Q?5ACr8Rqe6yNcW21iw8cj0jqrIaeNd9QxyLeuhrM0wXWK5QFzf8geFTnNjNYx?=
 =?us-ascii?Q?E541xfyk3IfGiQzd1vFfVfANGCdX7JjCGE4uPlFWgL5eWGtywJxN1u5YdMDl?=
 =?us-ascii?Q?l+0ihHk52ptzLN1q5vvWcBmLrHOBFNuFxLTFgkc+sr60RxkWTjQkZj1uL+GF?=
 =?us-ascii?Q?+mjVGfIX6Q8P6+sh50sk2ShacOnLskJE4V8At2YVS4aqWzJi/mybvFiOv2Qy?=
 =?us-ascii?Q?OIcsDMdNwybtnA+3ZMd3IXJ1674dOz2Mp8pgNBBiQZt3gwnRdExmjwp4IY3G?=
 =?us-ascii?Q?YUUEDLvHpO40Y7goJgH2JgNZcyQvxb4IfYtUMd5YO0AjvipoDQgSxx4epBIB?=
 =?us-ascii?Q?NAP1Cb3bthNCL8GZ3Fyb/m0cNP37v4VNshsh5VpsDZ2Vsg8yjxtGPBUjVahl?=
 =?us-ascii?Q?mr9kWaDUgtv7JHqeOezX+m421PDdvN6KWX8CwB3V1Hg0OfpOUTOItVLdtyLv?=
 =?us-ascii?Q?QsaaEU2mJ7+Ly/8ZhSkbQw1Ir5Q2NkBcevoskyf8sT3dL1QVsEvE1kffK76e?=
 =?us-ascii?Q?fXiGtS+9Ryv/JGafV8sdXGTGFSYhuHi//2K48mqnRrCzbtynoMg16/gGEjuJ?=
 =?us-ascii?Q?kPw3xcbROHvPr0/SFVpKddgYT+cvDNv7a35K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:17.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151d9e69-633c-423c-86de-08ddc93632b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737

Implement Time-Aware Traffic Scheduling (TAPRIO) offload support
for Cadence MACB/GEM ethernet controllers to enable IEEE 802.1Qbv
compliant time-sensitive networking (TSN) capabilities.

Key features implemented:
- Complete TAPRIO qdisc offload infrastructure with TC_SETUP_QDISC_TAPRIO
- Hardware-accelerated time-based gate control for multiple queues
- Enhanced Scheduled Traffic (ENST) register configuration and management
- Gate state scheduling with configurable start times, on/off intervals
- Support for cycle-time based traffic scheduling with validation
- Hardware capability detection via MACB_CAPS_QBV flag
- Robust error handling and parameter validation
- Queue-specific timing register programming
  (ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME)

Changes include:
- Add macb_taprio_setup_replace() for TAPRIO configuration
- Add macb_taprio_destroy() for cleanup and reset
- Add macb_setup_tc() as TC offload entry point
- Enable NETIF_F_HW_TC feature for QBV-capable hardware
- Add ENST register offsets to queue configuration

The implementation validates timing constraints against hardware limits,
supports per-queue gate mask configuration, and provides comprehensive
logging for debugging and monitoring. Hardware registers are programmed
atomically with proper locking to ensure consistent state.

Tested on Xilinx Versal platforms with QBV-capable MACB controllers.

Vineeth Karumanchi (6):
  net: macb: Define ENST hardware registers for time-aware scheduling
  net: macb: Integrate ENST timing parameters and hardware unit
    conversion
  net: macb: Add IEEE 802.1Qbv TAPRIO REPLACE command offload support
  net: macb: Implement TAPRIO DESTROY command offload for gate cleanup
  net: macb: Implement TAPRIO TC offload command interface
  net: macb: Add MACB_CAPS_QBV capability flag for IEEE 802.1Qbv support

 drivers/net/ethernet/cadence/macb.h      |  76 ++++++++
 drivers/net/ethernet/cadence/macb_main.c | 228 ++++++++++++++++++++++-
 2 files changed, 303 insertions(+), 1 deletion(-)

-- 
2.34.1


