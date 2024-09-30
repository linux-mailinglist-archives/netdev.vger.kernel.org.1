Return-Path: <netdev+bounces-130278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEF989D2D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936201F2234D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9817C9B9;
	Mon, 30 Sep 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnkreHfB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2017B433;
	Mon, 30 Sep 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686031; cv=fail; b=OuawrVUt+VqxXDiVjkGBYntt1AtEAPipDZGaNjPRugL8Q1OMNc/pARjAazLOXmcfQK+puUq4Uk6Nb5V2TLOo30edbdQQmFT/oY9TU7gOh8kuEAOCkFGuX3trIigdBOeSyuBONtI9tqJQZ6ibqtBEO8SvLPKw4/pU+Q6BsgYmV2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686031; c=relaxed/simple;
	bh=XxoVFaTRfRvsE7YeibesFFiF2mVuviYmaBifXVbeeiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N08ZqkOdj5wXiNJX622ycMMrw/qH0/r+qj1WpNcBKc5+mnkCaflUaBUHS5sbRB7XpF5ZnehfHVETOqq/jbVF+hVVKj7NydRwQvJbIUaPe0befuqcBVpYKO9Mta0myn4vQwmJHLPXzw5JjRhwebuAUOg7i5g/jlsn6Z7hw7Lw7wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnkreHfB; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP/2mEAwm5roVxKsNUWIcyNaNVLe+lo6Tkfy2bT63yXSxnEwibB+335zWCg1gx5WhQf2GniJZk8BkwLOMaVbAaZDbdRYzn161mhyXDgM77cAgFOe4r5roJ7YjpIPJgn6EEQNw3Yw6aBUNiFu34xMtpkkcGd5mQbpDP2HhmoNjzHAijwoD017BKBPKDTsaENnbee1fZHt52TmV2Vvp0bBcitbJqsN1CZzb+nvTWdx5uqMrkDExZu144qgF2JtiFpAPFagAfTa1Cr/TUiOXH7XByWEbPOP8QvkU1rsoo8chX+quneydKigiVkn15LpxDc8XspQ41h03TCaihy92puHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O9u9kC0ySo5B2R2jKNV3ZN0TllfMT2kGyn0dH4QFJA=;
 b=yzbsD3KrkckEN45EMXso/vbGuqo7F/p58YCnMIQF4v0nF22i5+e9RVOOdwu8iUW6/3qYyT7tr8UOe91svZ4MiuL+eSARygpGYZSoAxevpEe2VMIYrru+CCieQl4t+KMAupbLqaCu7iHBuQP8fbcZU2QSpMYFan5JXOT+oIy9neNqfVt8ECGz1X4BhFVisPXwBv/B2m+rWDI3PGVb06IgdYVuMtYo1gTU4FHRFeh2z6EaM175lz5c0Sc68bRXbs6f3jg9j6nZgRM94GNecOePM4GTB3NJxs+zpoLnpwVMUSMY1uHOys4d/ZHz9C8lDvbIkG1E6oI6wlOd9hEzlqQ2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O9u9kC0ySo5B2R2jKNV3ZN0TllfMT2kGyn0dH4QFJA=;
 b=dnkreHfB2qeG3BRGROAY3W5gNgAMGtufIJqZ4TnZkxf+I6go23UhRd5J9/NXeLPFKWIxc/A0XiM86HCQ/z0ZNc7m25uzyFFcPQeW9rzjr5GKKRWAhTyP2Soz0MbeCC4dRD2aTCZsO3alJHz+pDqcx8nn0OfsvLpV7WIhDSGeSd5M3vonzQu5jSjfbbu+pILbNbClZD79V4C2YUpsRDvA3ZWxiMNT204zACDtkv4vcC1051BRHRHRx8tOfztvNtHzzmbIPvryE1BtvNDCiivf3D7ybAJT4oZEhCTs9yU9cqfB94bqTEyc2XawBQ2XTlRyr3gd9z3bN6/g7XWQmi4FnQ==
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 08:47:06 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::7e) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 08:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 08:47:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 01:46:53 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 01:46:49 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v3 0/2] ethtool: Add support for writing firmware
Date: Mon, 30 Sep 2024 11:46:35 +0300
Message-ID: <20240930084637.1338686-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e925ee-fb99-42c7-e25f-08dce12c7673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M6F7uqC+INvxKsH0qwiI+NwjOFr9qt56AFlgUCVgCsnGBhqSO5sDGhjjDC4F?=
 =?us-ascii?Q?vWdn7osQuL5xB+lJGp3IYNlEmZyePgjPE6Y/c39V5U/RT2TkJoGVYCtpsb3u?=
 =?us-ascii?Q?X8GyxutXyap7QmuIu9ekTaQZpzdoySXVzvUXOfIfdWTk0wPjxfvbv34T7Zaz?=
 =?us-ascii?Q?9vUIV8ut4JBGoUIiEUdxrZdB1+uayfddZnHluY819IUnCx2ffVIUfOrhnA+Q?=
 =?us-ascii?Q?ud7SoQYpqgBK0EZNrai/c2FiFxBwuFdzWQmpIpmEJ4mpGGgsmTLYadVdCuNI?=
 =?us-ascii?Q?Z0NLb1DCmVMoXRz1xx4cGOoUP1EonhxrYtmP1CqBC96IHEQQ05QmS9fDG0hy?=
 =?us-ascii?Q?2XcIgFTpkb9EYbTmHUcgWTFzn4PO0LIfSu7qjeeOL2pDqpdetKvKf7tTxEYV?=
 =?us-ascii?Q?tWokdVZTYbUSIQcNSWac6GuxmgRDLNm097fZYeuuePFV/EfGyJS1KQqyceMk?=
 =?us-ascii?Q?BGnSJjpdVIKJInuKgZSqbPSm6cLREA8zgAYaUMaq5mgoosxD42rm7f1Yquus?=
 =?us-ascii?Q?DpUpYm+H+9q9FJ7AI1r5GBqTKsg4laTw51yenrHhgqsgCIf2ZZ44UruJ1VUA?=
 =?us-ascii?Q?BfjRKIhs0xzOWOQIEaKj760lZkq1gQj09zsBxTnn/1xr+i+V0UXJvq/Dau0l?=
 =?us-ascii?Q?rhmKa7946FMXnxNj86DFmr0+iI8b2mewuOFHPtCOEiDhPRuXKOOj7CBjZC/g?=
 =?us-ascii?Q?B3JacCUZm9mEziEEMRGDdW7XgcIyk/qbesyWSKQUsc0MFbfZUKKJr0ZwOueQ?=
 =?us-ascii?Q?3YM6DNLfcpaYPE2O6Xd+YQA8qMHjEv/EKygO9mfgZXPtKUaXtMCEP102kkCh?=
 =?us-ascii?Q?Q+XHeDg+WiideXMbKTAvCsBwdYWmkEzYJhc1BeIg6bCjoL4npZ0e0arAi6vA?=
 =?us-ascii?Q?a5jZ7psEBzWOQDpxvGml4z5jG+H05CBmZiFUts2LwRucFQtgjzHhiwaD+Q4x?=
 =?us-ascii?Q?NxPnoATpUvp/0bYBDjs2ex8riIWG6dsF/XAj/BqflK6bhefbxViJxpU6/vDj?=
 =?us-ascii?Q?HfBprqWlFiD7/VerZDjNbeE8O2Nu43kXdrh3YhwmyiPs5VK6B2o1OVhxiMl/?=
 =?us-ascii?Q?4bD+yHLEjgGHxxskgNA9U4OduKisRezVhLrRtDmSsUDN1mRvCTU6L8yHQtF9?=
 =?us-ascii?Q?Mq5v2XqrPyHlVDPyvvqa2SwbLdAJ3tLCFRGgXsxhLNmiyOX2QKHln/n4h6g6?=
 =?us-ascii?Q?gr0APB+V9hIe/2aTASZ7dR+uppP0/G0wORIijEaYqzpsoifGeV/rhPN8N6Du?=
 =?us-ascii?Q?NXDtLQTS89VM+bn3/s15SEdLlaX5WxQVdm231Yy/uezgr8SpPLAQwybpb0qj?=
 =?us-ascii?Q?1c92SET8MC/IJoNZdtdcvOj7Mccr6lOo2PDzAKKsDXjvqatd2TcCMLzH8/Xr?=
 =?us-ascii?Q?GeNNjQgkNiQzVauq38+9Bx3T/TjV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:47:05.9853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e925ee-fb99-42c7-e25f-08dce12c7673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

EPL payloads are used for more complex and extensive management functions
that require a larger amount of data, so writing firmware blocks using EPL
is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to support
modules that support only EPL write mechanism, and to optimize the flashing
process of modules that support LPL and EPL.

Running the flashing command on the same sample module using EPL vs. LPL
showed an improvement of 84%.

Patchset overview:
Patch #1: preparations
Patch #2: Add EPL support

v3: Resending with no changes.

v2:
	* Fix the commit meassges to align the cover letter about the
	  right meaning of LPL and EPL.
	Patch #2:
	* Initialize the variable 'bytes_written' before the first
	  iteration.

Danielle Ratson (2):
  net: ethtool: Add new parameters and a function to support EPL
  net: ethtool: Add support for writing firmware blocks using EPL
    payload

 net/ethtool/cmis.h           |  16 ++++--
 net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
 net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 34 deletions(-)

-- 
2.45.0


