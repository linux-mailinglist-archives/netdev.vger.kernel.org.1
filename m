Return-Path: <netdev+bounces-114448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DD942A0C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116BC1C21618
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D51A8BE5;
	Wed, 31 Jul 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2a+69Fay"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C218B04;
	Wed, 31 Jul 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417386; cv=fail; b=mllPnsIhxPbFS3Dfqsst7vQRS3kNLNogNVnKR5eN+pWEFu2/x/e9SGwRxul9dlwr/HevoRCyhJp7NFa/yXZcHruz/f19bddfwO2qQ8j18UIlyHSdtAJQUr/FxomfGjTRKCwlrmCNy3WLYNrvPOtKdJSN1bMBXHozizka04qAPDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417386; c=relaxed/simple;
	bh=zVvJa9uCQ90XVmNmm+UAF9i+Oyd1oPtwfmpmHsb0/2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+3MmQ7LKnwsJDU2Pp4soW8ncxUtGtjehajnf++Y5eDVYcZVb4BPn9fQz1m06KFnhdugiKzSO2Rm2kaKwMpwCUpASGNuQ3ExgsTmKVQfaVSwsdMZFGTGGAOU9Z2AZD0gpuqigPKgP+LwGPVlwLME+FLVh3Ih8XFxrPqkC7LPYnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2a+69Fay; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uiy/RiU2iwqAsOiap+32N0edY5ioFiosA9pBUamy0DK+yHLhaoQRusrjezAqgtw9rPtsAbV4jEfuKyCOBQ45zcwNY7QNZew2bNDrLoC95bv4/OkeDMraAsRn5ofu7XMZVSuKWyZRmL0me8zi2I6sbdb6Z+Tdq5ZJeWbFJkHmJ7B4n1Xi4ha6VfGp0oOZvxxHIkuYgkwpEvLmGMdsL3uycy549QXMzYQPUmggsNIrmnwed2nnUpGiUHfgfaFoq97D5vqKNbNX2ndqpA12DFAv4s1Da/CBOBcZoyjW42edJJ3D3/aivfHqpCwU/6zNt30lp8y9xdr1KyU/hi/s2bKWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAF1RcmCxmXyHM02vFiyuaAh2Ziji5mmvTVd+4HWd9Y=;
 b=bEJTtaz5SvatmW/KvucxWfgClPSQ4scoBtSbdTBca9EiDHrFISco/GeTV5/n/OxtwXQcU8iOyb4arDphRfKwGuB/+90chaN4wfjFNiuCcDHpFjgR29SnagvDxIXhevCblOg5ZENnwqOUHDgSh9R3phSGSxtiL6g+6zrx4jLXoEytgiN+4ONXZTBrfqD8jdkCEU0jM7yMg7CNryUqzqWFhqCQlgF2L9PuQODtttyehbxBB4sVhQFQdh2Rcd8/YRvLuTUSVs2TZE+WOIAcGmZQDlJmBMMXo/ysd87UrLGKzrHvlNf7BxdhiLlbj9HK1WbUrQb58QVoC/8GWeLzM1SF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAF1RcmCxmXyHM02vFiyuaAh2Ziji5mmvTVd+4HWd9Y=;
 b=2a+69Fayd0s2H8z1QVE0QFa/o9kUfqNSb4Sn8tFQXp8ixLlRY7GZbead40zJizRJIfIQuio9r5GC+q5ecKLLGNzQwN8CBamI6dCMGE7RvcpWh22BYqEwmPrMwj1tbrqwq8YJGRmxM9L4uOMHmQcM/pplgRxXOKB+b6m74sqLU60=
Received: from PH8PR22CA0002.namprd22.prod.outlook.com (2603:10b6:510:2d1::26)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 09:16:22 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::98) by PH8PR22CA0002.outlook.office365.com
 (2603:10b6:510:2d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 09:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 09:16:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:20 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 04:16:17 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 0/4] net: axienet: Fix coding style issues
Date: Wed, 31 Jul 2024 14:46:03 +0530
Message-ID: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4a1b89-bb58-4534-88c1-08dcb1417178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3b2L2ed84FYMWjHof16VoVLH/j0DqQTy/anTWgK02mkEB5tPCXa/igLsS9P?=
 =?us-ascii?Q?Tro468pkyf6FsNUXfnjIkXrP8TKWQl8d2ae7vLikw/baonpaye5HTHofD/Oe?=
 =?us-ascii?Q?ELzsoUxEtTrf7gUiQ6JW4tWVH3nD/DJ5AZVu0XWWzRgvISIvyHfdJtPdEguR?=
 =?us-ascii?Q?qD9YGRQsjCJRrKv1qDLoJzrCSFLjggeFDTJbirODt6navEUu8BZsjTdTm4bw?=
 =?us-ascii?Q?onSbXx51b0evtkfuFeBM6CSK/uX1xhlzeSy79aRCBf08PC5UAObnTUFiW83Z?=
 =?us-ascii?Q?GtpCqn6kqr+dlBOugbd33wT+k3jCulP/fdffsUwz0bpPDMAMZjmxYt09qVOH?=
 =?us-ascii?Q?xCIV7FC3sWZySxeHVyy3jhwkbQwF/u+cxo4Dl2WTFDQSJlC6ypCkw3JIAPXj?=
 =?us-ascii?Q?Q+pi1sSCKIv8CQJA+FxvbAMUgQu2scv1le2E4URIIR9Ki3QmrUze8BE9oslf?=
 =?us-ascii?Q?iSLd3OHmHxMsgOKVoKokI5iP56AGjoWI8247aIRkYhUuz/JuNARsg++c4YDy?=
 =?us-ascii?Q?MqmuVBz35+tHQv1xYl0YofZliLnM2dR01/FO/5pFSUAyrSvmQ420u6D1DsAd?=
 =?us-ascii?Q?lxz22j2ZKmuuTwQFBOksNyG4VFLlEwPCn+H7BM/WMmpu68hEFeGyrU9nQeJg?=
 =?us-ascii?Q?+z7aZiUEE2qnEt5kO0A03BpCrYRjK5+yNUaouY5H/PaywMlOqF4cFbj12NMl?=
 =?us-ascii?Q?01x9Ianoc8e+ekCeRyzQP92uT9PnQP1+aWWO/4PJxa3Ny6bo8bAZ7u/PLlfm?=
 =?us-ascii?Q?r/TuWjp8lvfHc20crsvoemZXwPz08jvhGiZ8sGIpoYC//y5adA7qG1iJqd2s?=
 =?us-ascii?Q?GSQR6Br94C5SU/TwYsRvdMiBufuRSLHh6xnO/SEiDDlZgFNX8D7LtX9cIQ/1?=
 =?us-ascii?Q?i3nRTU9Jne87Jpg8Qn5IyuUJbGJfSogJSpnv0QlSb+/d6GTkL2EiTDbol+h2?=
 =?us-ascii?Q?hAFQOVSFEAF+jjZ9BWxxcEfdwzceQS8MpqE1+U253oJRDKdBT8k0KVKQLwxN?=
 =?us-ascii?Q?9eus7gmOoF9Kwr8ycrnFosQLS9HRIcW90tZI+RWyE3LxaF71I9r2a+57Nm3k?=
 =?us-ascii?Q?UTlog66RkhCTwYlkeP2fDPL62WEL5GmiQa27dT3pTlfh/cqLvbwUGzdtE9Sw?=
 =?us-ascii?Q?QhpQeSEIp08nawgYCdl2c5kvjBorvvQghq79Di4pGRu2uojQ4/kP7kFOOtOP?=
 =?us-ascii?Q?u6YJRg25EIo8d//JoI8Juz6mp/Rh4f2kpR9BlT3P2zecIS29J6EMrE2Sjpxo?=
 =?us-ascii?Q?YNLIoQjIJ9OLpkRjm/NiRGSyjIkJKrkIvcvBBsHcpWiNdw+aZsgKnzn5ZX3W?=
 =?us-ascii?Q?eu98DgYsrjD4CS3Y0ALnnKFwUFgfkddce/Hvqi5n3JiZp5Sc+tTey6YQsS0o?=
 =?us-ascii?Q?oHGvGMmgKfedkxNpVoJwqcWBaeIltbMBAfXUa5BKr/+SwH14nuC2a1AMpIMp?=
 =?us-ascii?Q?Zccy1b7xIkZMjF7FQW+Nvxyxm6hNUxRQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:16:21.3545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4a1b89-bb58-4534-88c1-08dcb1417178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164

This patchset replace all occurences of (1<<x) by BIT(x) to get rid 
of checkpatch.pl "CHECK" output "Prefer using the BIT macro".

It also removes unnecessary ftrace-like logging, add missing blank line
after declaration and remove unnecessary parentheses around 'ndev->mtu
<= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.

Changes for v2:
- Split each coding style change into separate patch.

Appana Durga Kedareswara Rao (1):
  net: axienet: Replace the occurrences of (1<<x) by BIT(x)

Radhey Shyam Pandey (3):
  net: axienet: add missing blank line after declaration
  net: axienet: remove unnecessary ftrace-like logging
  net: axienet: remove unnecessary parentheses

 drivers/net/ethernet/xilinx/xilinx_axienet.h  | 28 +++++++++----------
 .../net/ethernet/xilinx/xilinx_axienet_main.c |  9 ++----
 2 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.34.1


