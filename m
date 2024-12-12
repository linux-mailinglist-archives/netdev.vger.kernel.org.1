Return-Path: <netdev+bounces-151517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFC9EFE50
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775FE167716
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C901ABEB1;
	Thu, 12 Dec 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I6ygTLz+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA738DDB
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039144; cv=fail; b=dQWF8neMcbeVGsgsg5sZi2SwVlP644JsNRA3XJ5J3fSkMI7QtbDIA3XQUECpvvy4RukXMMgUpnefivyV8wtKfPrq+LAu13FZv+OD+heRkY8pZUs37lV1jiGNBXOXcGXGejwdMiFgtPE2qrUszC8AUv4E2BbpYvkGS6baZ7jzf+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039144; c=relaxed/simple;
	bh=Y+M4HshODMa54LKkwGyQWP9CviFEca4FQwzb1f7B5CI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N98H1NsTD3ICUupqBcHtVYtLR6WKgxg09VPmHBX9M7Ir97zpW6ziYcM8IPPDUWQfPy3Zy7bea/o43hv1tf6nQjlcRtHwew8IJv0pdKz60PRA09MYVtDqd0KfFymWht/XD5ENlmuUtNDTVr7gK+hEWBr4JQevHuzgBvN5e0/u3P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I6ygTLz+; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybH6qs2KqhkYxiYryApXlZqEnw2mwoBkTqfrzct+WfnkUHTALJRJX8LqvEn7hX0+G0zfLqo1J5EIwl7efRURRTL8CK0ocfQ7PGyuOkDG8TJimh5vjOSs3KqIaMXTW9bksjS3iarHr0sInq9j3dB97PGvxyOz0HCvycpRgMqF7jD3rnDNCY+aQIACTQp8n9cfdUY2jWbnGxEjxHlnt6w2phTi7iFlc374hXwigkaAKRKP4QIhuaFbe2lbnlejWeUAxnlZUDy9ff7OE09P+th1u6XXw+od1A30PnojkFVhhKS5hfQBEsWq+ORuSDm3EQQbW7Jzo5HPsCot8OEM6maBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBF4RJRhM/luiELHvxD0OO5dpJAHnd9T2kGwHqpoh5U=;
 b=F8dD7mhe3IkPTZKQqV8Mh1Hef7LZmfna0XXPOzt/EdhX/WwWC+dv7EEybyT2KizE1rD3FfIrm3amlD5OGCaBpB5BFrfBkyZl/sQ0sMUWsr7K6OqDPHGLzFC2PfOZKxIlYoRx2ykIEA/BM4sqKgD+ERdO6BAZlBxuTwnjwVBrNFyp3BTXl3i2/av50RzcFHAvc6/plRI+lG4SmflxZAQZfZo4iMODi4LEEOJ9Lhd70bnYgOj998VXMYVVBdEyqT93rL5J2LYKQSY/AOO5HQXH6fhP+1UC/q9A0Ri0SgROcSlR5FVMOm1R37aqHfwZKE9MKn48UQ0hLhESMWEpRxdl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBF4RJRhM/luiELHvxD0OO5dpJAHnd9T2kGwHqpoh5U=;
 b=I6ygTLz+LMv5LP3Gqeu85CRcqivfzLSRXh/kt8SHs9WFSBT3CcnH2hsiw2bDwN/ABxeGS+iKwE0UAIom+AJpPlLn5FzQlgxP8FoWelhrXQBqMqeCSW15irIbOAuMmurUC5KZ8ifPUAyY2C8u5U6pv7mFV56xDr/SQjwhFT8OU2I=
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:32:19 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::3a) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Thu,
 12 Dec 2024 21:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:32:18 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:32:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 0/3] ionic: minor code fixes
Date: Thu, 12 Dec 2024 13:31:54 -0800
Message-ID: <20241212213157.12212-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3727ef57-76a8-4b7a-5684-08dd1af474ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UILT+TktfSbHfyLo3bDiFZilgTtPDD5UdrWEJcBIm4ZIQQLBIUv8hIQ9HxtE?=
 =?us-ascii?Q?leA/lrnHdZso+0DUfoqNd+H3cfClt2+BFb1rPSHrNyPROkXX3LuvfUiPWdAq?=
 =?us-ascii?Q?qaPJoJYmnAf2puSlj+AuXGq4CawoWCtCt9ossGMNEJe2IzVjc5O4ruO6qN5h?=
 =?us-ascii?Q?fhZwNCUqFHpE8383dp1RLrpDrSDQEJlzXdfhZyPnHHxcnW/Qbt5JxS4496gA?=
 =?us-ascii?Q?V099jb8hoAP1nQ+Fw2LJqOdfUAHYgADpRO8rAyUgrnbYnTwD/TVi7udCjX90?=
 =?us-ascii?Q?KlcppYBMgfPvFakVNR9hGUafcSobSdNDIam/9iCrMQXJb1iLFDC3io0Gz7BI?=
 =?us-ascii?Q?9dyS0RRCuky5MA2N9C4THYRfW1BWjJFfbTjlDIE3BJU6tfmhiXt56FzYijcp?=
 =?us-ascii?Q?lKD8U2RyEPCHZ9YEQffXRrQ8oqMMBYb4UtSa+Us1HP4RETQl+KtXF0RNC0VR?=
 =?us-ascii?Q?pFS2nNlpQuj2se9yeOYHBgLXZoeOEjoZd2N3f2jNUjR7fjI+J4sN/Pw3Wv+q?=
 =?us-ascii?Q?V+0aSiBVHS+sTbcNDBFM5bRWhM9LAsHc/LsBCbA+VQKw7mShv2qTiSK4Rmgg?=
 =?us-ascii?Q?rohGelJeE0S8JgP6OlTuIVJ8J6jjhRGmJ4I+uw9g06WFPNfMI6c2mm8cqnYi?=
 =?us-ascii?Q?T5ua517TvgNz/bcHOW+xhRzAexyM9Km2MGAWpDuLfynjCxejGj5AgIBD7E7s?=
 =?us-ascii?Q?mMVK02ZDc8yCMglJUvU+4QcypHz3P2eswp4mWGADXgVPpTdx9jsMwiVz13If?=
 =?us-ascii?Q?NSp22Fjnk7shrQQg89uOdl/k2ahNSQzzd6feHX5jNdRGo+94kVv7O/l8xAnQ?=
 =?us-ascii?Q?wIKWoJVTYmPBOvu+J70aFDvOZsi9Dpi9Sci5g3RYk8l4ZMhxw94ZU8s/D+K4?=
 =?us-ascii?Q?NE9JYVuUJXv3MkYgKFMUEtGAD5O+B51ZNoyG9lAivU+COmnLE5vic2/IkUr1?=
 =?us-ascii?Q?UFOQNUQvoL1UrBP74oIezAQd2+9oZWs40vH7IfNdZn2jhNnrSip/6SqXzoN+?=
 =?us-ascii?Q?2o+LhSDo/kjyNW3vRbUmghz3utSFML/Bug932lJateltJOfNEUfu4YskYmgD?=
 =?us-ascii?Q?jd0yBc5Z7fbiwmBCVQcJuTOejkjJrEuERfkYHjnYYra+GAhsIlqugqAm9Bp6?=
 =?us-ascii?Q?vIPxCFup5pfE0PYyiVz3JPpaixI9q4hTA5S95lG8cbL/tDk/gcn9NPRdvHuy?=
 =?us-ascii?Q?BAVRROx4uV9bcBOBMH0/eiMeFLNn0jR2M7oahOPPmiF4tuRrAlgk4JNZY4Tg?=
 =?us-ascii?Q?e3CvAlkOhgflPIc9m9LBm1Uo13luMyzIGYiRRPdkLN77o1Mtp2/UjlYYZXqq?=
 =?us-ascii?Q?50jzEi9ZklbmKKjD8CZN8nvZm7w1P/bHtZihmpXGPhSEv1qg98qKmO+AoHW8?=
 =?us-ascii?Q?RrZzUO4Xi65AXKC/bF+vaeRIy0f0UqstizCkcgZYJ0T4fhzkwIA6gEfcTY6E?=
 =?us-ascii?Q?YxzmWhuZJzYizL9ySZpP5u9zRVjAtO4+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:32:18.6709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3727ef57-76a8-4b7a-5684-08dd1af474ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

These are a couple of code fixes for the ionic driver.

Brett Creeley (1):
  ionic: Fix netdev notifier unregister on failure

Shannon Nelson (2):
  ionic: no double destroy workqueue
  ionic: use ee->offset when returning sprom data

v2: dropped nb_work removal from first patch

v1: https://lore.kernel.org/netdev/20241210174828.69525-1-shannon.nelson@amd.com/

 drivers/net/ethernet/pensando/ionic/ionic_dev.c     | 5 ++++-
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 4 ++--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.17.1


