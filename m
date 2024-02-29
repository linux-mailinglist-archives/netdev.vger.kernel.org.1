Return-Path: <netdev+bounces-76303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873B86D35F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45401F23DDE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228AA13C9C6;
	Thu, 29 Feb 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z9/FMmSR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207E70AFF
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235612; cv=fail; b=HNMB/AMNLvpHMAJ04jQzQFimMa60jgM6k81BxmQwzahxRwJ6O93tpS98xaUi60076SmAcEEgOqTeuvOWRblx0mdUM0OfSKHzTiMeEp/uA+MmDPO4Y5aVLne/ULrxH2C3zdc7gTpRYw16YpmoBqZVa5Q1FI/abadyyjhHjZ/8g6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235612; c=relaxed/simple;
	bh=fPuEu+m+ROQJ3O9yYXIt5SV6zFWtfUKBdK2tk3gF6Lk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fS6ukO120TA3h2msAlJIB8vm0RdGmnvDw9gjsHjaEi6lf3Ty78eYoq3oAxBE9MTAQMQHRXMlrOyumMT5LyDFgXphzDB0/3OSSlULxNcWkW8pRYwFFr4YNQKmXs1eFTmfoWhDJaFOGH3YvA278mIyAfu+M+HCq7T1DA2VAczKEpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z9/FMmSR; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcrrA3FSuhkjCosBPYnEwa/OAgywknfq4ixcaELGulaIxwmqo1SPMZlTRdYlMVtbzZhwl38rV/HPUQKWUW3qbpxODY1iQ+/TvaG5Gcnl4TrIEtQnWVSZTshenKIOSnpdhDNj12U2aJ2yLIhfDZpVagylR3Upu5NpamxzkXins7eGzIBw524MAIkTrEfVB1bbYD1MwXgMDLqyMIDScBHyoY4qIHEF50bjHPj75LBv80B2QkmCn/c0BNS3BV80XnOMdyCbhqEJQL9bOr2aD7y2Wt+eEfQ5LxSKsvpjI0Q6UCXIluLkxdg9UK0C0uueVxj1kuOLkrJat/W3gJiIYHCnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWJOqwvM5n0lIhOIrI9sMdDOCDSX+hb8a4GIDEOQTmk=;
 b=ADokq2G9mZvmRnVStYul/bRQk1GuOd2Q2D4kKzMULeW42HvN2AEkvfgaF1vl7L49kGj7T5cm56bIEIlmV/8t1+us8sNx45cKH9ndh+6WMFQny773UUncN3PDLlGKRJ7AX6SIGL0c5d35/ooBHdzr0Wau9fpJ9/PP8oY6Ce+FXRR6VxqRwhUrZBriSN/Z+sDvrM2T4M/Pwfd7O7BGElMEYccO2PKIZsyLsqOJfFMS6HhiScRNYEHMmJtHU4Pt9Bm1fPZBQuDqt/zCjQEdaaDSuDFUw/JmLuyXdwUGw1yULlosZKjrRIfLUmcY89INCozKpx7HCTqusfOKrI9oj5rAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWJOqwvM5n0lIhOIrI9sMdDOCDSX+hb8a4GIDEOQTmk=;
 b=Z9/FMmSR4Vqtmp2TxEAniTHOnN3xGChtDIug3vgFIAMnTS3gws93W/jCZJ1vB2+IgEPI5BGVxo81fLAjKV6OSv9mZUriqNPm5jXJ4oUErFMQ0JaeFAWnKK1HZPG1YmZoUgB8V8qoGI80eMWrQZLUZ53Sufzv8UHJ0BIRJRblp4w=
Received: from MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 29 Feb
 2024 19:40:08 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::1) by MN2PR02CA0028.outlook.office365.com
 (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.29 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:08 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:07 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 00/12] ionic: code cleanup and performance tuning
Date: Thu, 29 Feb 2024 11:39:23 -0800
Message-ID: <20240229193935.14197-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 80784b46-bd18-4fb8-e765-08dc395e3c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ijSubaoKJnvwoobxubHcfq6E0lydYv08q6SY3KKqvzRCpErI7d++7eyljiZzUad2AzCnIKQ/fpw5d9/UPA+Q1Nd3qkYANIYhNP93Wq2ugtYWOOzNy1RsUmHJc3PGPfMhCpMl4lweL9YC9BAcEezMKIb164Ltb848DoOzDYxn2lCQMhZkx9jA1n0Sr/UqptJuLb+8pmjKZBt5kvGr0tlCwHbpc65WfvtSb2V4fJ2HLOuHEGiDzJyKiDVEDE1GWIL7BCKtB8xa5+LKUGOpBUUMpImOSBPFT4sbwG5mpNnS0z+jLJxL8q4EavXODZS3FVpRmDz4Ov0ikPoqSy4si2F+5l28gfvy9ESa1rF22C1nN917ROhwYT4jBPiDXARmOs01wov8AWK8kry0uRBZq+FHwDe9mgUxFH5Z+DwPFSsKled8pLJ4AK4ZTcYswfNV+6ETbRztMlskthWadKYCA6gYPIi4kMmwdGWGAhj1+468YlDGazBYTCYGcU01UHn3Nqduy/dbtSnFGHHbZGYMRpSf183/basbfb77x8PeNykyasWJJLO3Rq7y99JJ1/8sPlMWBJHpLh6YzOTGpVSFUFKpKmGnN9weKg1PINc9W7jLrGG6FpJ8w3Ox4PJ+c1yYz3y0GgDUU92CpXuCJC065en2oOK7GqcPuThOxewRoX9/QXHrnAjp2iaPLFcn+B/VsihcR7t7XdRLo9neG7FNSD3TzUbOg7dJ1DqDzB4W81+r1eEDrWNndFMEw/5XMEmPQqrJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:08.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80784b46-bd18-4fb8-e765-08dc395e3c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

Brett has been performance testing and code tweaking and has
come up with several improvements for our fast path operations.

In a simple single thread / single queue iperf case on a 1500 MTU
connection we see an improvement from 74.2 to 86.7 Gbits/sec.

Brett Creeley (10):
  ionic: Rework Tx start/stop flow
  ionic: Change default number of descriptors for Tx and Rx
  ionic: Shorten a Tx hotpath
  ionic: Make use napi_consume_skb
  ionic: Clean up BQL logic
  ionic: Check stop no restart
  ionic: Pass local netdev instead of referencing struct
  ionic: change the hwstamp likely check
  ionic: Use CQE profile for dim
  ionic: Clean RCT ordering issues

Shannon Nelson (2):
  ionic: reduce the use of netdev
  ionic: change MODULE_AUTHOR to person name

 .../ethernet/pensando/ionic/ionic_debugfs.c   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   4 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  16 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |   2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 216 ++++++++++--------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 -
 7 files changed, 137 insertions(+), 106 deletions(-)

-- 
2.17.1


