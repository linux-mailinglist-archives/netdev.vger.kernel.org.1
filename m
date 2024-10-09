Return-Path: <netdev+bounces-133805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227739971A1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EE71F29353
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA511A0BCF;
	Wed,  9 Oct 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2OYW0eQ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF4199FB4;
	Wed,  9 Oct 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491324; cv=fail; b=P1pFUwmETTZThjMy0iqqay44ie9lAC8fkvdqtgOrokgjHCJ5Ma8RC+He9yQvHXngDTEW2FiKtkfzla3CHkP9XSUuc/QgzLd/3WNb1LnLsJUw0+nvdLB3y1CcRd/Xoei9RqIz5vHdGlG+aziyxoYHi/Yve18eAtHIi3MIEMJkHug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491324; c=relaxed/simple;
	bh=DJxBAsAPDqzuzE2lhR1LLeWzrDGHxT89t9nBhVtWj7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMrRL4/dPIAiZYbD9lcDdkTFviKqePFFL+p5yM7vqOYjb3lgkGwrv8D0dPiGXQ46gog1ZCTm2Kmz8dDvVAx8gH8VYLDE9tIJXzb6xma0GTSJW4uy6+sPMNCpERPW9y3nSso3gs2/6YXyU+K5eH16R8JBMSTL47OCQaGrJwzrSrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2OYW0eQ8; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPKwV1/H8NrZpeehW9dBhWM/BbZUp2wop8lvo6X5aYmgTWkekoC5KDVZFnOKUOe7NFwqzWce3qh5LocQrkqGddx0EYv8P8wMYgJpgiUMm7lIOnm3vS86LQp8JkaazxHW9dbRaajryj7beTPVYZFx+DlM1p67QFBgjCb9/vYfVer6744ZvjXWLPgKmBk0xru2U6YYL+lZj4ZthmVz2Sj/Rl8V3LJ1rSDIdDp398qh1x8CnVg87VTDOwZCXCDX5rz1rUBZV9qaUpPM7HyhfihzL1oIY9+lPKEoOj/pseYOy31D/gs1tPHIoYkeaMYaLJyhDXgkpTdtYMmBna04lRzldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIhfu1o2O1AQqghNxEuLZJnZSM8IN6sSCwkUmTGkZOw=;
 b=n+9wrhSAuR5kHRK2JBipqB/UlWJQlpUo3lCuUhYoXE+EbBuICJhGw5xEnl6LyS+Fi/mlbg8Ub4Hzs0xsfQtgvuQHGM0LCXe6+hCCYOcPOND9k6QfLqHkpGMz9EcxfPiCzausJxxFC26ISGo076f+oPlPQoWioMbKdFqzeKFJ8C8Zr8V0ylD+AuSGUct7M/uqVAPveV4svQMddV5F0rWUHh8IAcICxyO/WBRVtEZNQ4d5zml+nAzEpVOQdPN9qpGQ24NjBHLUVp+tUFIAiYGK+86q5MPYFgRZwjdpId+Gy7+w3yJmvr69qALRtbmlHwBxb509lY/+6W25R86ddFa7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIhfu1o2O1AQqghNxEuLZJnZSM8IN6sSCwkUmTGkZOw=;
 b=2OYW0eQ8AkldsaIAU2hiVrUsBuMoSM+KvUkvBCO1cxZljqDVzBoxXmK/anpUXGyTay12OrHMaTLQSzj2VJkopkV0FZZONybjgPFtgxViQfRoTkGajLKqxqmxTV4iPdV6ui6lVEa6tTBaagJ/xRFwirIb2NQzHX6Urhayl3VlQxY=
Received: from DM6PR06CA0072.namprd06.prod.outlook.com (2603:10b6:5:54::49) by
 LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 16:28:34 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::c7) by DM6PR06CA0072.outlook.office365.com
 (2603:10b6:5:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:28:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 11:28:31 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 11:28:27 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v3 0/3] net: xilinx: emaclite: Adopt clock support
Date: Wed, 9 Oct 2024 21:58:20 +0530
Message-ID: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 61352782-c627-4f24-a337-08dce87f6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEVHYQgbSzgnZLbG/13lVkcU5fXd3340Bdgd3WhnaCRvNHquV7zDdi3iSlUA?=
 =?us-ascii?Q?iPzWvd7WBee77DR6e4oSCWjkzHR7raiEb2Ba1RvoNnO3HBvvv1Bf+O/WmasC?=
 =?us-ascii?Q?TdigynXWOYcaGSP0VobfOhCArj+8skIJzkwRuEoEE2zGF1RVen5SX2n+1wZ0?=
 =?us-ascii?Q?l02NfRA1WQKuFD/uU24BuMKEdLfW6svXe5v4Z/zFc5WcMUbMYcGaC7J34qPe?=
 =?us-ascii?Q?bhmbJaNnG6/jK5iBQycFmfFOc4CpQ5vFph2S4gZJm/CywSMMB0NwQK0QHygg?=
 =?us-ascii?Q?NboAg9ejU95+yg7ctbMIxMriR614K9onZdMpqiIXo65nuULmkcEv8hISpI/8?=
 =?us-ascii?Q?/39QqB+L+KU3wJJ5vMET4iD1NqsmSJdig/naTMKdrVoWQRo3fRkhYhCjC33+?=
 =?us-ascii?Q?kmTbuqUUsCeU94P3K0P95uD9ePkjNdNVhhHvmLkzQOgE3YD3/tX681s79mKn?=
 =?us-ascii?Q?rMU7N73P9NqIk3psNNQ+o/WwapZrnkTrJ9AO4CziwQtuXzyOq6bkwz8mPVxR?=
 =?us-ascii?Q?IVBq8+Cmk4PBkhIslp7wj1fLolA5Tmji8SRoP/osz7iaoO1uwGdh2ymsCCZr?=
 =?us-ascii?Q?ZjtzOXmnb2Uewf1r5+tiDsO8p8EOfeFPJY1pwV19tqxKKNcaTJf7xR7rSVxu?=
 =?us-ascii?Q?A27RGDlwVCDfMIZ4kaLJKegdPhqubgRoebdabwAPWOyx+VGoWIp1zycDawyb?=
 =?us-ascii?Q?YsB6/xrM7EPZzrJejMIlLMvYkmBGF91HpGGgzsovWW7EPPR4Q4qTjBGrp7oi?=
 =?us-ascii?Q?CSE1LTpgNkhgX+O0ZY6ulBBP37/R6USsb+5qRyvhr2/eA185GPF5w2YrWL2T?=
 =?us-ascii?Q?WmxzUyZHmlmbGOscZJt3rPPAhIrp8EFx0AWdPht7VgJ3VPfm93ZlYTxmWAaj?=
 =?us-ascii?Q?ybvqmWgLuCkZx6XAkqC0zqDAF+O8la+vJCkUNsISI/aYRBv2xFCUEaDanlK/?=
 =?us-ascii?Q?o9NnsgGLQ/RaG/wMaI7aZNyMHzSyd9qtJmqT7PGugDTa6eFdR9MWEQorkDIL?=
 =?us-ascii?Q?u4+br9DonyBVZcQN7tlPRetLBa0jufXERMmnkHv1AumylC8G8D8etM7zvF/G?=
 =?us-ascii?Q?iYuVOxVo13PyRFpChH7RqQJ1uCBgxQvfwMbMV0lFPtnU3vw5iGXoxA+xJ/Bj?=
 =?us-ascii?Q?tKfiGcCPMsbRzyxAQZIT1RcYS9Z6ecCSln/anYc6m6b3BaOVNwWiK0KCw8JQ?=
 =?us-ascii?Q?lT5JkhT2ZFt1hGOOZcxtafIQgWTWPxYfVEzIR8zQfKy5KvQZuFwDvB4++RBa?=
 =?us-ascii?Q?Syv7LaJDSX3Hz4KbikH1C1KUxwjQmMsIk4EZrRXk507q0/SCkv/56h9Vxv1R?=
 =?us-ascii?Q?71LTq2iTequ88p8eS0eJoXKYokqetRfnbGof9s7GfWUKT4vEcsWh0sfszZYq?=
 =?us-ascii?Q?w5sXoKKZz+STBWOH28/ad1xAEy6s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:28:33.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61352782-c627-4f24-a337-08dce87f6b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

This patchset adds emaclite clock support. AXI Ethernet Lite IP can also
be used on SoC platforms like Zynq UltraScale+ MPSoC which combines
powerful processing system (PS) and user-programmable logic (PL) into
the same device. On these platforms it is mandatory to explicitly enable
IP clocks for proper functionality.

Changes for v3:
- Add Conor's ack to 1/3 patch.
- Remove braces around dev_err_probe().

Changes for v2:
- Make clocks as required property.

Abin Joseph (3):
  dt-bindings: net: emaclite: Add clock support
  net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
  net: emaclite: Adopt clock support

 .../bindings/net/xlnx,emaclite.yaml           |  5 +++++
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 21 ++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)


base-commit: 6607c17c6c5e029da03a90085db22daf518232bf
-- 
2.34.1


