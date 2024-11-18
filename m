Return-Path: <netdev+bounces-145765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5C9D0ADE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF59DB22A4E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E5156231;
	Mon, 18 Nov 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eiXz4HVW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480E1553A7;
	Mon, 18 Nov 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918416; cv=fail; b=FYSRbNpVrB8Cf07WQFIfFYbZTLrs2hpNdfZrrESIu5wFAWL6RJxKpB+sg45jlMPAbVZdY+196nOSLDX4gMDwysWD7yepGlJ/0p4NZHtn6lvBKSPq94RvEREBIsXd71pTHJrD/hg2p0Pbl/yN1atksYHi66ZMedVc5vB/rYFE80M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918416; c=relaxed/simple;
	bh=k2THFt5i9Q5ktPl9i6K9AfeNQwA83UKU0EZx1Uz7boM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNn3/rO1Mmkrqik7l3rfsUWVoyX1u8J+Ca9yYjB+RO7hPhLF+1Y4PaI73juexQmOU07BvGWAvu2nWM4lyitcHY8nALkg81M2BiAhk9U/opYVqd9me9lhUaEsfKcLBmgCnI+uylxWOPrEFcA/bTxX01hZgPnkrb/LMv5LcQ2AuME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eiXz4HVW; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxzmsEzVpiZ51m2Zw8PMWEX8P4rS8QhF8RHnwILz6EtOVtC0aj5ZEVwth3d5EIMfAQrWgGZcfUkMw/XEncrBPexKwA+FFytyv0366d/Xrf7JD7mucpXZGNN5bJ+gyRO8tcqT63ZKQcT7mq1d0sgGGtA5BhvxrRsdD7gclLSvXpD1vjAOnMXP69xf2IV0PIrzVOWr/58xsXDdfJ5oz+dAMsgF/3PH7AwmUsoMt48XXlbQ4tFlBwKhGBPubWgGfXG4k/bmrsZ5uUFZgsXRz1bIyBQ/tb5tRnpldJLUW4aMJCysF2iCC9T4t6mjqm0GhCh6Gw4uGm8z0Huq2hn/bggX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLzyqXE/umOTtclMV4gtUWXVP5zT8ju2oj0gszja9XM=;
 b=UuYnBH91gMHQ0C3imWw1L0gRzeYDbMUiJru0AHKJ/bHN+RaPMnWZT8aUJeDaKEJQQhfBxLIUSOMrNYE1SafOE5R7eK4s9Fyi44KAvGd01Wpyo+DhCzVUt5frOCXrU3AHyG+MgcEjaezyUlzeP3Yx0b85d84NvuUgi1+7iS2tjqC75Ko0nH7sE6GqyxL3yonHkfR9SreegX8mbwL5EmYtbCRnjCWZGMbB8w1g+zgVqRDflqzuz7v8lCUm3LDpYn2YzD3sFaGpTjizyCFhxcQijN00VyhFR0ZJAP+Zo0qF+yB6tfXMvQqyxzVXIXUbRv6ZnvNWP++br9hnBQJtQSxfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLzyqXE/umOTtclMV4gtUWXVP5zT8ju2oj0gszja9XM=;
 b=eiXz4HVWBgKNK6UPeqAapJYtMfbOaen3VmlsQedxXCsFi6JhtjB+YcEbD/2zMDNui7ICDzm6qaPTobO66+Lfn0uYoHOloAOe7AtraGZXJ6FHHPZq1F/FHMPf+cCFrHhuHfdbc2POK0J+tTPT0Nouul+xEe4TUpHTTVYWTVtHt3w=
Received: from DM6PR10CA0029.namprd10.prod.outlook.com (2603:10b6:5:60::42) by
 CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 08:26:51 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::eb) by DM6PR10CA0029.outlook.office365.com
 (2603:10b6:5:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 08:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 08:26:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:18:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:18:26 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 02:18:23 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next 0/2] Add support for AXI 2.5G ethernet
Date: Mon, 18 Nov 2024 13:48:20 +0530
Message-ID: <20241118081822.19383-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 44aad868-9c13-4a28-85be-08dd07aac091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NGZnMindW/P2BHRd0DZ+K3OBBzz4HOdc2WDbmofFB/Z5XuPHTsK3grKgccG?=
 =?us-ascii?Q?vG/9tuM/0eT/ZR9u9DVavUwmmeSXVHa+P8iB5IJyKEhK4rU+5goPbF3WO5BT?=
 =?us-ascii?Q?vtw/LxgKGRhoalOuz9TdyTDYGLPFcRI+/AMrZAKF1aRf5xjTaN+5iVZkDHYq?=
 =?us-ascii?Q?2HCb+s+VNi94OiEDnT+dS8LfX9Z7u3RSlx8ummsiDyMlL3bulMlBGJ3xs+kl?=
 =?us-ascii?Q?1Is6OZKvGhxwdIGHxPZVTE/HH/wFUVQCX5hwYVSHAcFqLtylYhbvPAIKWeFS?=
 =?us-ascii?Q?Jw2CxB3jLBsMo3wR0d7SHKohMfu7OapeCPQ5bVcse8rEelNCOE539QfHh+zd?=
 =?us-ascii?Q?ksLz6v7kVIsZW5Wi5N+UTqrucPX1X+hTLAtqc68zcsPK5yOASV1bR9D6yT1T?=
 =?us-ascii?Q?kgs/uXKb3MCh2Y4xLk4b9EqYuDmuW+p9Ml2zKJTXUYrGtsS/jRp1H836PaaU?=
 =?us-ascii?Q?A63xhMVZNWZorkcZULMLhKLjvavZ0LSvTHw2Tz/BPSOSJKnafZuz+hIKuZYq?=
 =?us-ascii?Q?4+uXypJQu5gOvtNk3SrAkLAkwyAlekTnO4oQjY5OG5RE8V3gB5LULqiUk3r2?=
 =?us-ascii?Q?33HDG0k/xNB0rAHNLVPluVGbeOgYJzaCUtQpczVj7/HIS2F1R0dBHi34hz2h?=
 =?us-ascii?Q?exYRS0T4HFo9LGJTogGpO0la4y4db8fzw77Weh9duaWR6GrmbasQ1jLAPPmP?=
 =?us-ascii?Q?ZUMyMQRqWQ74Hi5Ms+eagN9GADvKAwlS3+b7/7aNm04Ir7Mp9v5qnnwZrx26?=
 =?us-ascii?Q?RnJ5/4ILo1pbeJ0nfxF0UapThurZYEWpdITdl94ogNLqTY7yXrXijtDeM9Tc?=
 =?us-ascii?Q?pjPgU/O4dDs++Oe0vwmnlcB3q3WqytTOuGh4pwjuiAyiVRMynqQr5gs2/P03?=
 =?us-ascii?Q?IPHMpDVnJfRMTANqE1meCZ2NSkS7imNZr++ueZe9lAu2UnUWSQVZOXIWjfdv?=
 =?us-ascii?Q?2F/i+LKrP2FtJf22rqiaPeDKQpAQx3tIUR98KHZvsFbs106Q91yNxFT7edXA?=
 =?us-ascii?Q?apeuKSUCwcP7SfYZhy1Rs0tuMpFTkLnMGETViDo1hDbbbRMjqP4iqFLNDW8O?=
 =?us-ascii?Q?lBzDj7mXSPNVb/9AwTtGSKquKtt3KU/jNYV70nXc52m6FT61BiEX5T/1Emey?=
 =?us-ascii?Q?fCvEmZCPmJjMh/vKHledk5D7+PGyP316v0wtXYjqDrhTkDAzfRQt7YTPsDIl?=
 =?us-ascii?Q?ci5SMd1jVOEtpf0jedBv8CzSOwqJjeSgG/DximYR8T4a2KbOggp0ikWlU93D?=
 =?us-ascii?Q?WSv5dIEsZhO9K6qFIL+bQb9JsDyAVNgDGvIFLdGJRjGcfdHcy33VpSNaD0dk?=
 =?us-ascii?Q?fI3A+5gXKdkRwm8Yhxwjkjiuguy4v8XMq5nwsRl2sAcpB2Hfp3wZ99SpE6iJ?=
 =?us-ascii?Q?b9CnInXLqwbDE6br4U4CtHZpG8O+GLzox67zvmwGdIv1w4EjMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:26:51.2138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aad868-9c13-4a28-85be-08dd07aac091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

Add AXI 2.5G ethernet support which is an incremental speed upgrade
of AXI 1G of AXI 1G/2.5G IP.

Suraj Gupta (2):
  dt-bindings: net: xlnx,axi-ethernet: Add bindings for AXI 2.5G MAC
  net: axienet: Add support for AXI 2.5G MAC of AXI 1G/2.5G ethernet IP

 .../bindings/net/xlnx,axi-ethernet.yaml       | 44 +++++++++++++++++--
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 +++++++---
 3 files changed, 62 insertions(+), 10 deletions(-)

-- 
2.25.1


