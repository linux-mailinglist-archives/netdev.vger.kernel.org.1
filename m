Return-Path: <netdev+bounces-95579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7018A8C2B0F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A024D1C21995
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A724DA10;
	Fri, 10 May 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLZVqiEB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3217C98
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372410; cv=fail; b=XoVAanHVKz7ElrfAuFgM1p7gA1tQycmp+dsHZggb4v0nZD3YhbOFF9uIiSEValcICmdIFEh86nYZjrW6Slp1MdBLLpp/LhXDfhTYAGbVfPs76SZSusO3WsJ3f6kKYZUaVwm1vB1BEBZHz3RVjvx8e8p2GDD/wRoDieMou3PKi5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372410; c=relaxed/simple;
	bh=zKK0sXlEAruZ+ptp8wx8pN4PFCtlg2qv1uRgJhZjhDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDlGYKl8QoSXEG9j3USZjta5mH6QT8iS+EL5Vl55FAuXZSdoSBHgn/MX9zURhDI4X/WtsI7vKiHc6QzcTR2DH5jNKgb0WMezUPwoukxldIgDirtXZglIVLK/75GGnV2/WIGt1+BFqOTOJI1kNFUfZpXza0KIyV2cSwIqGTaixqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLZVqiEB; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jND5lWzA5Pz+j8plFmSlh9WOcQuZhQvhmxghahe4MuA/fkcsLJ8AlTR9MKLb0hz7Xj8jci4cGkywhmPiiDZnCZQkdzhbUlnGCXAM/sE/1eq5hDWQOcX9x38frRESrbFtpNO2a4mubD5huApPq4JyTevyS+uoOzOoH8A5kUY7rR1avXUCGWAqvyIwjkQQkzYlETCuN6WzXjwpYNIYAbn8BhRQAe2OEbhiVd3eKMNYU1fIgJ+sRcFjqT+hTe7t+OEGR3ArkZb8l8OWtzQyv1bf2CaPVrVzSV4wBsMQ87mXdiEUNQcYPQbqgPFT4emVOjTwu9/CSGOwbfmsOYRJJgkNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZw6Ap0p+t1tng7PcTs7JkgqsTYSeFmtmAX/ao0PC/M=;
 b=HsaHeS+TafkpRPI1N0SO4NsG/qJuHu/qOk92Cl9psE0RXkqX7t365s0gMkV6lliCW/9iwJWz2Zp22sEJ+TvtQCFpKN8iC7b8cngybUmrAt7MCoKIMkj9eeLFOOzR8cxwTNG/PLZmcaYtlwEpO8Tj032s8dMg/GcgRqP6YTNvmzhP9Xfx7yLPGC7nQT6f6enVuL3c2bqTM6wtqgv9dtgiFG1z4t0jEYmi642SMfVeMLhXeLW7mCSjtHza4A1esGaY8tngZ9pI1kgYzinWl8EDykkcB6C4xLID20//x9xZwOVtDO3Mhj5ZZ1LH6yKJYv8iPNIyR1JgmW1bVckvEsBiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZw6Ap0p+t1tng7PcTs7JkgqsTYSeFmtmAX/ao0PC/M=;
 b=fLZVqiEB33SVfHZ4P3YpMiFhx3hEpcjs/uVDh3qC/FKALQm/mo1i0+3sz+VJ3ow85aSrfRv5muVMVqKcgAhxQL/lY0cJRy9z9UHSsTEhJ4F4eb9M2tXVADH/jxdPlgxEpvYvWL20dqyAnbJTrHBoyE4Yw1C1Yz78M8K93sr1OcnoqgIO0KpycjNu4CdL3lKnAvTDddvV0YvH+E3bxKgJO/btokSq9fCqm6WVkS/26OrlgMNsQOKmplpM2emhEFWRB5mFct5u16+KjYlcCbkGHhFgBGAzYL9mbW20nybpzHk8OZK2rQeyit4I9KqAtRqNrC8CT71QfIORuqGEVncEHg==
Received: from CH2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:610:51::12)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 20:20:06 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::97) by CH2PR15CA0002.outlook.office365.com
 (2603:10b6:610:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 20:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 20:20:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:46 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 10 May
 2024 13:19:45 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 0/2] Add TX stop/wake counters
Date: Fri, 10 May 2024 23:19:25 +0300
Message-ID: <20240510201927.1821109-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: b46eb96c-77fe-4dcc-18ba-08dc712e94d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvZN4ykFcmDaKq/JMOjmXgFdt4Nul5Kl9PSTTU8ZYekgHCEFTK2lSgZfmyr9?=
 =?us-ascii?Q?efEOFMA2jnoAHlSagCjpQYG5M2ktAKiP0X0v/AGYr+BDid0ThezHyZ03oht+?=
 =?us-ascii?Q?5speneg1s1J45HoEhDAUBSQAcbihHXkYG1WggSx9oGFcKBs7t+AYpCnH2gWB?=
 =?us-ascii?Q?jk2sWSIEc8Xq/l2hRxsvp2BVTENeKTBXHeuiItJIRKyw+G2Uqr6PGtI7nkhz?=
 =?us-ascii?Q?7X3BVrgUWIjhIx0bI6agHk1ZbcjYJTzQbB6Q+nHSe3l5jDhIFeTrAMBhZKS1?=
 =?us-ascii?Q?7ScyUYxMhgIJoCjPo5/NwrWGsXvr+LqjlPM2LuCAJTsUVtodWYweCrQNy8sR?=
 =?us-ascii?Q?8OBAXB8IbqBpjhEqqeYXXYjBAjADTDLQKPhRR7+W0SVoPqk5FFn6CW4fIDG9?=
 =?us-ascii?Q?TTT0VblpJxOGbLI/ccSmOist42jVrkWbZnACufSVnGP8e06r+fN7EUsewFMf?=
 =?us-ascii?Q?1kR71LqL2xGCOHIlpiUA6IxfK5SEqFViKDl5brxS89o2vMnRlhqHpq61qAGr?=
 =?us-ascii?Q?uN682P6jrQBM53KKf3JRfQPeCx75KLln6mr/BV2R04/4mq6Fw7Y0SfGAvHqK?=
 =?us-ascii?Q?24LXEm20v6agPbdIRENWaGcJR8PBZCRpx1y/KVioh50OCm0sj6+dyi/wjPjZ?=
 =?us-ascii?Q?lZ2m81boE+bpH3VfWJnBDsW5FGuitMf+xETAlDcFKnrv5y2QKKfT9V09cxcv?=
 =?us-ascii?Q?T9RZL61B82bn7z7x3Vmy2ZoZPCM8JbsrmfBYU4Ky/ju2oS6kSuMmkgcAOD3A?=
 =?us-ascii?Q?M9aZ3E+pqTv02WQnES7vYLZW0M0+aKuZeoRSyoaZLItZUKOF1VJduOCNhkt9?=
 =?us-ascii?Q?F07oDAJ20ojTGpJyyQyEc9R9pnb6lVImBNpJkR/B3sPaxaqWuqcGNLvG6lyN?=
 =?us-ascii?Q?Sb9aq2fzBhuyJERG34n5+NjkiIq6E2ySyrlUR3fy8Y5UJp5saYSHDkFFjcx8?=
 =?us-ascii?Q?iLYHmmkQZuO8PNBSJLiimaPVhBwkTeR2QnOi4iXQDCYP4xKSVqFEryweEleq?=
 =?us-ascii?Q?U8vbznpV7kAkYRaB3naeXyD1w8J8S8RIua4VTrOAYiLyUvUvuoU5FEWlBjgI?=
 =?us-ascii?Q?77CPzWoKsXvqKQYc6OCyLSkN0bx2M/TxI6/ppgATEzJ51qDaik/HDfI9oIC0?=
 =?us-ascii?Q?0xlwIYnVGqGEf0c/coVe4Sd7skHSRbQxKfhJ0gONIN0c5bSvr3B2ci+cDKN3?=
 =?us-ascii?Q?wYAv9qvk17WoHENAw1lGr2yvFTaPpaonJgUUEHwv2hdQDio/iYoyKQIZCgaH?=
 =?us-ascii?Q?T3Njowdbipo84H7ghAhv13A4VHxpwuha8qyLDfymGIwR93hwbXKqpcxMo97n?=
 =?us-ascii?Q?5QUEhM+En7MEnHfZm+E8ZWSeCIyVe+x+ZJtT2IW4JAN3j/kpaXUAJAcNSNfQ?=
 =?us-ascii?Q?v804G+AT7vChCpe1e2ggtfOF+Vc2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 20:20:05.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46eb96c-77fe-4dcc-18ba-08dc712e94d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

Several drivers provide TX stop and wake counters via ethtool stats. Add
those to the netdev queue stats, and use them in virtio_net.

v2:
	- Fixed an accidental line deletion
	- Enhanced documentation

Daniel Jurgens (2):
  netdev: Add queue stats for TX stop and wake
  virtio_net: Add TX stopped and wake counters

 Documentation/netlink/specs/netdev.yaml | 14 +++++++++++++
 drivers/net/virtio_net.c                | 28 +++++++++++++++++++++++--
 include/net/netdev_queues.h             |  3 +++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  4 +++-
 tools/include/uapi/linux/netdev.h       |  2 ++
 6 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.45.0


