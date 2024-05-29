Return-Path: <netdev+bounces-98826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0858D2937
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50692863F8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719D184;
	Wed, 29 May 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8URzp2M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42758363
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941011; cv=fail; b=ItolOlhFnpb/y3Ei9O+wCdKS/D1aW1Bv6yK8ae3/JfhN1eqTonPGOLujDefZQrVwN/sdIPGYzMmulhUeLi4BBAMakLP9tvZvuTot9DfQLzg9PyA/OauTK2h2CRu7TP1Ud7quaEInYjc8G5hWSDnIMyUdpLQPbSG4gYmxEeuhKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941011; c=relaxed/simple;
	bh=DudBYGwECuRvsr7j17ocv23ZTye/G7y2ifpQ8v38XfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AILRxCC50T1gMMJVsb2U2jrPageGuhBrQ+AqM3ixeLJVdRYhHUiN0voe34MelQnzmhu2BPScXi88ZIqVHGNxqtoc6WC2vKwb/wJLO2kN4r+nzqpEYGDnoe6VoY/esCrv48Y/fBsHjptyQB+8oGp7GefFn8mvqvQ2zr/XpGuHhAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8URzp2M; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkCEfa01P60H+iGSPA4Ak75+NeLe5VxFCTpNH91nG6M/gCpN+YaVRIlxfOdoT7lOgY87SxlfEOp8hBbFjG3L5Vsd+40pyPuBo+KxovbKc0fXFJLHFDVUe8C+AL2dEnqhYVILkCFCJUk1DYcUNmXBXkbikHGHClq4QkyEdtKfuYi2iMfB+I2RZ5p3CErSwq7HUcYwV6I8xPiZJW+t7joUDtI/Yk6QxMnM2hmv2EVSQCGWJThOi4vDmG1beRkG/Qwned60SIvf+OrtH+j44Tdru6v0REAHQkkL0hHUCn7utys5T9YOXZqFimzLs4pU5PLUqiOIZMr8Wn63BFhImj7lCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKLGnYbjd6qYyuIcTx0lBOMOqxYY8h48eWaEmu+wk8=;
 b=Ml0jWxCmhS9AJAFALoyVwsx1yXWY5dkO8XExivx8fFTETuGOk57OXym2ahVIBgmyJg5g1UM4FTiP/ARYQX+H3ii5bOjf/nelNkDkinwJZG31ETY6VghL3v2qH+lU+RzHgJwb3eKgWnvXJ6jdl3LRlcKpsJFHYqGdwBD93yfU6fXIcFKvERzGZCdHuiofs03rDsCwczb7Ocve9pBRx0h7DnSsDe9+gNN+4suKY7JeD5ZVcT32185wr9I/tQHKU7oOL9ljBGKGyP09WqV6ZOwOQv3Jj3Uxv9GtsecrshI33warOyDQOkN0glklJEkjzTcUv9dp1DiD5bkjUt44uAS7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKLGnYbjd6qYyuIcTx0lBOMOqxYY8h48eWaEmu+wk8=;
 b=y8URzp2MCRbE/NuGpN3rlZN6HK9tsP3nrE2/AXcpSAoQ3wxlLdohHr6GsGU+JMjPY1C0jx9VmvCJFRNKS6sHcTOswchFpmbcdHTIiyCA6STGeVrjSGqzi7ee9AAji8wIPlwZft6oB5GUGrcTr823uwyy8cvrZP1G4B45ob9dC14=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Wed, 29 May 2024 00:03:27 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Wed, 29 May 2024 00:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:26 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 0/7] ionic: updates for v6.11
Date: Tue, 28 May 2024 17:02:52 -0700
Message-ID: <20240529000259.25775-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a175d46-38d5-4a7b-1bfb-08dc7f72c42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?336QjsfUPsIBE0WbyNAssS7ZHX3lUcrZVXrtCIflWkDclQ1TYK3VmRWDvIvR?=
 =?us-ascii?Q?NWmHCoSkmL/tlmBrc7IfO6SstXIn9RoTwvu0Cq2y73sj7YPEHSx6aECN/SDo?=
 =?us-ascii?Q?oVFs23Ynnahzs9krbQ2Vx0c3x3/AWjEXL6JlI3pYaZGmowoG9VdqPIrPutfV?=
 =?us-ascii?Q?KRPIJt85fV5kBgZR7ytEX6J9xgiZM6YveW220TMdr2Wx2y5ZwezTyShdRV8l?=
 =?us-ascii?Q?vfDpcy1CrNcE9mbu1peBnT3eiAMu6pJbGpCYtDodwizyzWZ40lROV/B+iBYO?=
 =?us-ascii?Q?pmezCRseg4q2OyFsWL4YwFWsb0VJJh5ua0fkkWghyfmWbhH8qyrwL8ZUkxwY?=
 =?us-ascii?Q?OUdKbD7O5991NvyDqiEQR7x2Y3J5ciEaXTo0RECnkSwJ3/m950OG0+4p0w5h?=
 =?us-ascii?Q?w1T3HIY5linGl8e+RRLKr3q2ar5wVFv6L4ENJ7qUGPLkbc2kAAJO8BVkvgwi?=
 =?us-ascii?Q?VwTXd5HRcyA9Zc8u1E0AAZ0cpJpYYp4QqHkTj/y8VjXOeoxgCjxjemii5Jr1?=
 =?us-ascii?Q?aa2TMlGRkby4WcF+YGGpP976XK3tuBNpZ21P2TbPzG/NQpD/S3IC90ZiuD/s?=
 =?us-ascii?Q?+nNHiG1VKaNTvk3o3y/39qFjm2NNgnnE77YMGr0nMijqM5wyzxVbyYpRsJGq?=
 =?us-ascii?Q?eBZKalOgtKjF+0h4nUPFqYoRIOg/x+knJHhdNh+HxT4CfMewcVrXh+Tg5wvn?=
 =?us-ascii?Q?nzNjYeeGtWcv18EiCMtJXCvFrX2Dfrkv7nPeu3Yt8XiuHDjomCTQGuLiSHkP?=
 =?us-ascii?Q?vMn6YZ5cHsVLOsDvaFbfVIcBdePjLKt+aH8drLY9r+CcOfQtVB+VrsyD8Apm?=
 =?us-ascii?Q?zBr7PqJf65NFUCOLBXazwK8uBGOpoQKhGGl6WO1H7DinZTXH15DyWpVTR+Jf?=
 =?us-ascii?Q?F0IGrNQR7+nNP5Q6ogqgGTKUl+07DyGHZ+v/pbrTmuzwqzPNySRo0LgdBHGk?=
 =?us-ascii?Q?SdZzj3cPiHwSmjpaT/oTza3S1pjBc1zpF2GX9gkD2JJOjRGmKp3qZbS3Gagr?=
 =?us-ascii?Q?VVP5EmI61qqvZ4n7bDoG+vDfBTqS+7iYs73SgH+7+C1P/PTfiqpE5lVoTNdT?=
 =?us-ascii?Q?5AJSHQLar9M85bHS0cdb0UjT5MgWsvElA1vgZrU/Amdyzu3HKC+R1XicUoGD?=
 =?us-ascii?Q?cmO6W0UaD4lBjXZEg3eY/guRndPzkry5hWNWeH+O5sznaq9I3qU2vKmYQTtO?=
 =?us-ascii?Q?vtJIynSj8PWaLtlmZEYc8zva12F+IbQepqMqZ96TOL9NeXFmssfO6Wfd/tJ8?=
 =?us-ascii?Q?jXkvN4RCgzDovw+1Crv/3JrSzPVq2tiEZaAgRoShRKpTjVbr6nhXKxGt7CjX?=
 =?us-ascii?Q?dh1zdJPW5Y5xD3BvM//Q9iRa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:27.2676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a175d46-38d5-4a7b-1bfb-08dc7f72c42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

These are a few minor fixes for the ionic driver to clean
up a some little things that have been waiting for attention.
These were originally sent for net, but now respun for net-next.

v1: https://lore.kernel.org/netdev/20240521013715.12098-1-shannon.nelson@amd.com/

Brett Creeley (3):
  ionic: Pass ionic_txq_desc to ionic_tx_tso_post
  ionic: Mark error paths in the data path as unlikely
  ionic: Use netdev_name() function instead of netdev->name

Shannon Nelson (4):
  ionic: fix potential irq name truncation
  ionic: Reset LIF device while restarting LIF
  ionic: only sync frag_len in first buffer of xdp
  ionic: fix up ionic_if.h kernel-doc issues

 .../ethernet/pensando/ionic/ionic_debugfs.c   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_if.h    | 237 +++++++++++++-----
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   7 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  32 ++-
 4 files changed, 201 insertions(+), 77 deletions(-)

-- 
2.17.1


