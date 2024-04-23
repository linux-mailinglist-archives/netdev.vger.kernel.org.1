Return-Path: <netdev+bounces-90336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D58ADC7D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30416282752
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF31CA96;
	Tue, 23 Apr 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+QppvQV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847B1CA80
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844690; cv=fail; b=J+3oeh+rhp5Sxk0tk3h++6TC1ZXqMA9ipfrbdYw+Dd7qUZt7a/kg+yuBxmJAxnKZxbIuYL/pwCfto7ainIFKk0W4hWfQLme8tgkW4obWrHyXNhbsSOash1baK7XIzVCjJH+hSUwavqQg/2PhpsW0h6ORe75Y3wlFb1eedWrQFmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844690; c=relaxed/simple;
	bh=1pcffGuiAFD87BI+wnosNUb0v468/Pzmq6t5SXyiy24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uov1x30Z/J5WOlXopZY8a7BMx9dMSbB8cz/+wb5sBlf2u4u2WccBU8TFMR5N7HvG2jiku+YPXXDoIV2aSsNR5V723aqTkmWoFd2kjvgl7O6qAM/7dYPokqS0WUZq6a5uUs6UjnZYqZMBbM7H20pFqQidHm5E1gzbl6n70KNfJKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+QppvQV; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMR4YWttY4X8ROaRHjs45sVGmcq0RsqmJJbGnJLHNc2ZhD3vkJOSxx3A12qXlEWpt371rUxyoaYoZIMmOTNIom223tD4ZA6DMe9FfQQJE30OPJ4pmHZmQHOk4OjHecBNHp42JMEHVCx3FEo4kU0qRT05KAQIjpezf8LjvPh8m5ICpE3U7TpHU4njYrtWfPHwEO7fOFj42gQr/5DOe8KzuMkwqKRtatpCWWo7qrfZEpP0QWPxubfQV0xc+UrfUxEv10VsFTkkdrehJK4KtXiiBvmg047ZfYjuRpPZn0c4WXZ/vfozRcwQSFZubVhg/h6YlfwrZqyqnxJsprol1JtOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNTt3sPbYWix/wsTwVbyBG1MhZXy/KHdLcZwIaIwi8s=;
 b=E60jOWbqU7FnkJ6ISXa7OQKrhpQ+3vhgNvzxfh4kZZBkbZKIOrDhc8A9bshIVWtCQ0C0YDZzHbKFNuAybvXE5uoGKWvumrdedMwdRc1X9jkU0RL8USo67MScQorb9aSFzspgagtil902SraQwuwc0R44mVARfVhugeNOjQkhO+Ax2qkGxGEQyph7peXypVoBp4rUOQq3dVPFTrrkvI3iBXnrUvo5OviaSf7Nzz+WoIcY8+9dEhIhmmMR+8hlI+eiO2WS3PrZ0fNMoMgyCH3HwebMAmLgKcvEBxF1eyYb96/wj/DgKxmisqau7IOPsv4RYrU03i2v5RqwxanXtJ/7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNTt3sPbYWix/wsTwVbyBG1MhZXy/KHdLcZwIaIwi8s=;
 b=Z+QppvQVdNHow0x3h88iuBXgVJsUO3hKfwwBovMTR8atDZBp2mBJEaA556Nb2mZrUaH6shf8sLWbIh/jDEKU2j31Zss9zX7iz3S1Jbs3Fs+NfTc9KI4Njmfzu1IiIzftF6M7Q4BxHmgqwJyLsg6/x9mD+qggurcxKZa0dTNNbJSvMNN930CeQwtN+pPmkef6XalvZjmgkWhfpwXEF7gr6dLrLhmHH8NRRLviYzmg39T4t1lCbL/7xKwm3SKokEvbDw3soJYHZOklb3G7VPm6K8Kp2WpdbrPCCeKbewNjsiE85TbCizzgdv20JoUWGIrvN2pgtYn3ZCKZijfgk3XfhA==
Received: from MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:06 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::b2) by MW4PR04CA0237.outlook.office365.com
 (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 03:58:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:52 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:57:51 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
Date: Tue, 23 Apr 2024 06:57:40 +0300
Message-ID: <20240423035746.699466-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: d2820918-e9a4-4385-5832-08dc634994a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFDkSrA40t7m5QMvmiWk5bgowPpkuRBVMPOTbRExCjFCSUrmC6gAVrTfdPGf?=
 =?us-ascii?Q?FdRpEaSS7t0yEJX8COTS7fBtXV9JH8v36dK77lGwdydIQ2oif9zIfSmgDaK5?=
 =?us-ascii?Q?FG2b+dDIWfgTqAAOJ2gKAcW7k/3wOcfYo+ZztLNCBDKmtBpzkFNbnCnAywBl?=
 =?us-ascii?Q?fQ7VCY8EkmOwDMSCulWA7AQLuX3rbtb+Ilh14opckyc5+YpJEOu9rox9hwvX?=
 =?us-ascii?Q?VzmVZydC1oTzOH7/h6LH/8s4iwF3oTFbBjMesl8bw8f14/bhOaQBzv3+eMv9?=
 =?us-ascii?Q?ie4ySL6aHOsFnADQmErOBog+WPe+b2HXSzLWD2iia4w2d/3g8K6JX+5hqDjC?=
 =?us-ascii?Q?HfdkjCEhGX5Bf8nKE7LaSUu+X2haaTJADK5OITd3Hl95u3oqg2MVSbvO01b2?=
 =?us-ascii?Q?21/XL1kLC9SbtXwWUQZ2pg4qSOm1xFnJCxj8Y3vue1TCd4hGhqGSr9Q1waa3?=
 =?us-ascii?Q?pyufRFXCCxtRs94s+Cf6WTtDciiV2IdcXDWEclVGRll6NldfAiiQZikV3+by?=
 =?us-ascii?Q?iBhAvgrqutlhzuua1CNyPy4hEJXw/7JiWQulA56maBYLdCD+Zq7/n6cBMWM5?=
 =?us-ascii?Q?V4o+W97rHxB1UVCFcOwXjJXdhHx6A51GzolrbtXdzFMyjfcS/UDOjBWNMtC1?=
 =?us-ascii?Q?Ea+QW4wLG+OIYqy7SNKdMjfJYF+CkklzqF42UIvMxp1ch+qtJGDyD9fDY0Kt?=
 =?us-ascii?Q?TpZpls9rFZdYmxsgQaWPxLozckcTJiUVamkLhHaL8vL+uTmm1+vBEDyGdWd5?=
 =?us-ascii?Q?C2qlepPnfzXoH5LrrBz0sMPzFETcTKszT9SPxg7oSSsYWNtQkMktaSThqmqK?=
 =?us-ascii?Q?q8XzO3WDPU9VKiGjJ93xD703NlwBsnmUBlIY9TZYMWXCmWSnpQLqzQPc3zuV?=
 =?us-ascii?Q?pIDHW4H0Z62deHW1F+LpTcEf2RgWNW8GRkeecYNpBdyi8aK7Iba9Thk/bnUz?=
 =?us-ascii?Q?B/T9AlUAVsOViuGGl7FhhZwpneAP2861ZeJYLfruTGt7DPbK1PLPOQUQQ1V7?=
 =?us-ascii?Q?UWP5Wd2ZNIaVs5pPR9zS57tSlC196QdnjxwxdnEdT77Wy9OuKAUMXUYnrQm9?=
 =?us-ascii?Q?IifLMvEvTMKXrCWZgFNEsgtZiamphxLTzOScr0KFf/ZVzO/Rx2G5fquuowtx?=
 =?us-ascii?Q?Gfd3lJiDuKYLg91JOXx45bU2W3nBWZvItMOgOjWwd68AbC1e+HeQ6q3L4Xad?=
 =?us-ascii?Q?o14pStD9De4/v3MPBkHtQ7keZIqyFZdHDP11TEXspW7PqmFa7PckT0L2WNPe?=
 =?us-ascii?Q?eUmDI+F75k547gxMTkO3PVJpZim7slw09d5suDTbrQ5zHyAxWcKADvCztTSu?=
 =?us-ascii?Q?aY+h8yf8l4EG5AL7EKiRoPJZTXlJuFCywioGGhaZj2PI1gSwvUHzDlG8tveb?=
 =?us-ascii?Q?vnD0ud8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:05.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2820918-e9a4-4385-5832-08dc634994a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

Currently the buffer used for control VQ commands is protected by the
RTNL lock. Previously this wasn't a major concern because the control VQ
was only used during device setup and user interaction. With the recent
addition of dynamic interrupt moderation the control VQ may be used
frequently during normal operation.

This series removes the RNTL lock dependency by introducing a mutex
to protect the control buffer and writing SGs to the control VQ.

v5:
	- Changed cvq_lock to a mutex.
	- Changed dim_lock to mutex, because it's held taking
	  the cvq_lock.
	- Use spin/mutex_lock/unlock vs guard macros.
v4:
	- Protect dim_enabled with same lock as well intr_coal.
	- Rename intr_coal_lock to dim_lock.
	- Remove some scoped_guard where the error path doesn't
	  have to be in the lock.
v3:
	- Changed type of _offloads to __virtio16 to fix static
	  analysis warning.
	- Moved a misplaced hunk to the correct patch.
v2:
	- New patch to only process the provided queue in
	  virtnet_dim_work
	- New patch to lock per queue rx coalescing structure.

Daniel Jurgens (6):
  virtio_net: Store RSS setting in virtnet_info
  virtio_net: Remove command data from control_buf
  virtio_net: Add a lock for the command VQ.
  virtio_net: Do DIM update for specified queue only
  virtio_net: Add a lock for per queue RX coalesce
  virtio_net: Remove rtnl lock protection of command buffers

 drivers/net/virtio_net.c | 276 +++++++++++++++++++++++----------------
 1 file changed, 163 insertions(+), 113 deletions(-)

-- 
2.34.1


