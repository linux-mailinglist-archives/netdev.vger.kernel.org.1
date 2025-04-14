Return-Path: <netdev+bounces-182384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E9A889AA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7296E7A4BFC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3528A1E6;
	Mon, 14 Apr 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6SXiWcy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30828935F
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651285; cv=fail; b=drXszJ/zoVSUGxqKziw9VsgoeD8m7Z/sL7DqURGwEFd2uGlcdAzQA1DspngwIg6GJVwLEV7z23IbS3tUwt5gqNKHnrNuI8X1CuSKXAL0ITWP9sz4AcQfhWzSULr8LWyOWN0EVVUilAlH/zokYm54G08JyoPsD4ZHDJg0gcSh0bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651285; c=relaxed/simple;
	bh=b9CwxOqs4ckR+907LV9XaOYNc8i6it0hBiRTY7Y1oQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2QVWawjHTj2xM8Z2fZIhNwSfxMI8osHxxfm3TmfGN+YMHftyWeJPL5ZXHqZudsIGMCgOJ7pvPXjnb1T7J4UkCzAqHVWJpqeRDSn1kbfxsuNuHG3MQpgNLeGUInGekBd3PlEX2n2C200ncZBxY8Gf/849dxW3J8K7WbiFWjfmaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6SXiWcy; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Knvxw3RLSYmlG5ov4japLsI4cR13Afo2Q03gm2jt+E38xknhr+F9WlJ4cgpEprkaT32zRft8yaoNttUtV2Yhctn+BJadSm3zYoWrZ0ZZCobYimkpVmFq5f0Tjb+6HLaWIxo6Qh1JfjXJM9F4AvkR7suN1quyuy/GHVmsHzv6A2RBOSMwIYRyun+2gGj/GjTz54VUvtzDHU3drtBmsE6bzxxJi7cZZbPPa2YxFjss3o330MaAun5pa/phmwtMdZ+uWw9nbwPsh+fNPQt1mDlKCbo9pAsxJFxg0e9PeH96/1SC3dMqWlxMnYINZBebUDtJ8deduuGKyp49irVjHOhZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keNPpMnrORRoQjYTN9BafS+/ig4eo9W0BeO9Q+pw/y4=;
 b=BquoaoseOIH2NArchmhHtx4pq0yCfujY6HoVCXZaoTzK97hR7BI7jK/PLrsZ5eAmZ1ayQfaP2pbXVPx07q1NUP7KqxbnoI9Pw6wAzEoLpRFFEc62r2JQ3M0PBKPsmTCH8iGLjcJBZ6hYDk1vzNApwE6O9+Jjgm5pbXw0sPsGC4Djw7Z2BbzcZ+P4c7yTvtSNf29fM0q7GNrrE8uaVxoUW53EHMNRA+Am4Czf3Vcu3iwpBVOsq6flKIqsUldPHp3pBDA+B0/EclmKPqKmZ1iF54zaYqtgswYdTnPdX0NdhXVv1xO3VHU5m6aWeSTMv1mWofj6bAOYGf4z020ZBhWZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keNPpMnrORRoQjYTN9BafS+/ig4eo9W0BeO9Q+pw/y4=;
 b=Y6SXiWcyVfbWvUEIVpm3nYh1jTnETPckn6XfFds9tDjMzqGs1XqhFthU8v0EiJzH+V/btfQ7thGiT+5fZsGwxbPoZr/IrPosZfxqMk2BBzp5hDmsyCc3i4t+RlHGlWPXkgrep55Rbki4iF3NdjXMW3RbQpa6A9nFCJ4Pue+fHTawiMLO81c8doHLqQF+0fwaZSFZEZd5dkH4AVKpQ4CFLddHrfRlJNy7Lhbn2xwz/g1xdJX98kPrJaFEgDd3nTwMSbbA221Pmp+Axn//Zc95BpQb5z9eJDPEbVb8CHMjCU5cvrO24tzQTH9YKU0tVHw3CJSCrtEKIgWWItCmFJAqyw==
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 17:21:21 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::ad) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 17:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:21:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 10:21:08 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 10:21:06 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<hanhuihui5@huawei.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] fib_rules: Fix iif / oif matching on L3 master device
Date: Mon, 14 Apr 2025 20:20:20 +0300
Message-ID: <20250414172022.242991-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: 876df063-9983-4230-8d5c-08dd7b78c683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evd5H7ug/IAZ6HvAvNUCj/oylCqrjiPHfX+ivlJT+ZKZXK41Cq6zS66nLlL1?=
 =?us-ascii?Q?xRxG8lWL523MApicjhTdMpt+SHkDFEGb//jjk4ywMuA5x34PmbYXRgq4PI/5?=
 =?us-ascii?Q?C0/pmKcIqMjh/2AcFWEZV0akrKoy8hbDcU5I2NqPfZNRSMWPvm3jUcY+c6Ds?=
 =?us-ascii?Q?q0L6Q3YNmNXnoH9d/rjxHCROypb4t++RdgjDfkpepoA9AcMdWXj9z5WD15r3?=
 =?us-ascii?Q?oVFyCV2xJ/iBf4p3KXH0I8vuyKpJFh0XZBkWrC6NfW13ntmuvHUIU8ERcmSZ?=
 =?us-ascii?Q?Ou796Z7TswIyA4EMGx0gaOxHOieg2/bB4hROwS/9uKDPWeoV8OPTr3oDEXed?=
 =?us-ascii?Q?7h3dsz7hfWLL0h0LDWTEZ4RAdf5VK5JpkoVtZKh4+O2fbQy+dQXuN9rHbFDh?=
 =?us-ascii?Q?Os5VYCOAxlF4HOpKcZkjvAVpf3JEMTv/DMpN2GmZAOTfHTj9JWEAyz9qwzoY?=
 =?us-ascii?Q?n8zU9NCfmASvB87OyL2fqt2sGn4zsMmbsmMwN6zDJnZEk1v4e1rq7AEFDfP9?=
 =?us-ascii?Q?Re/p6CNqGVwgxeEi2kqZUPtK4qrjOsA/qC3M6Y/CfVlq/23Fom3CUIDyLMh/?=
 =?us-ascii?Q?4LOhKOCwYk+5xYGQMYKkw9E9z1q7NrLtZLXxzc0Ppw5Y+6gndes4e577CGHI?=
 =?us-ascii?Q?QAu2SD70Ri2MQKI3Ckd2bgO9c2lKOrG9jghaPnC3cMQDHKw+Ac/tOfjFZiwK?=
 =?us-ascii?Q?WryL+Vedjqjz5hKgwQ7YVMJiRGFEaFsKvgk9owMfCWJAAh9zZmNI74gp3mnC?=
 =?us-ascii?Q?A1z9K4EeFmL2uJ7I6wBWktdIKzMf1bFYYXyUEqocWPI+fFIiqKoziwZFmama?=
 =?us-ascii?Q?wI0OilTbhhcbAAYJqwLvp/oKHIovRr0d2L3mT8X798jzzjEhjvi28RGZu6tG?=
 =?us-ascii?Q?rc4zFZab2xbj5Jwaa+iPfc9Q40lG+DjhpUnjEg1wL+yrMivKJFRDuCkpC9pb?=
 =?us-ascii?Q?85eYCLXkIkse0qouM9Ys/FpHSafmxpl3PK7+DJxOe1abWW0XckzUdgObXUDw?=
 =?us-ascii?Q?unrjSrb/Y+JsIZKCF0xQVlh3iaT7GIspIoDm5KnWiv/qCqpPhdQIwLLaZF5J?=
 =?us-ascii?Q?hIBbmiBDyklLLzzQgcpzarohLFJWvuB3FQsF3/xTxL29aLuxgpGMg09R4I2j?=
 =?us-ascii?Q?KiN1xSh4rwXxh9mxU8yoiYrfEXi31lzVbe9gNhy0kN4wcU2uYB0L9VSlYiHR?=
 =?us-ascii?Q?QGjc9neey2dRsIXaMQO4nVi/2mm3vwmZBC0gz0C5eFwlkbRizTn257UV/PmJ?=
 =?us-ascii?Q?XJg+SNo78a0fcF51S9k/iDS193WfL06RGG6vujamivlsBLQeM+0NZ50rURnV?=
 =?us-ascii?Q?qSRE5cgi1QQKDG7i6MP9eIYlODZXY//Z/BBGznVzZGYQ+6Jql9SAyQaCNpBH?=
 =?us-ascii?Q?0s1xqCTCVtEf+v4GIVTFz5IEloxRetJhq2p0rJunJeb8HXItnrM5+asQl/iF?=
 =?us-ascii?Q?Yvqtpam5gbKEkYOyoAW6z75gPLIFmqGMu/MnnN5R/DIaBj0Dzs0OU+29hoyP?=
 =?us-ascii?Q?dSHgtW/X+fAes9i6YMjFrtpJNSnChfH1Mf86?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:21:21.1405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876df063-9983-4230-8d5c-08dd7b78c683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44

Patch #1 fixes a recently reported regression regarding FIB rules that
match on iif / oif being a VRF device.

Patch #2 adds test cases to the FIB rules selftest.

Ido Schimmel (2):
  net: fib_rules: Fix iif / oif matching on L3 master device
  selftests: fib_rule_tests: Add VRF match tests

 include/net/fib_rules.h                       |  2 +
 include/net/flow.h                            |  1 +
 include/net/l3mdev.h                          | 27 +++++++++++
 net/core/fib_rules.c                          | 48 +++++++++++++++----
 net/l3mdev/l3mdev.c                           |  4 +-
 tools/testing/selftests/net/fib_rule_tests.sh | 34 +++++++++++++
 6 files changed, 107 insertions(+), 9 deletions(-)

-- 
2.49.0


