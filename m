Return-Path: <netdev+bounces-230930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01273BF2123
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C418A81EF
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2900266EFC;
	Mon, 20 Oct 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ytBWY9Lp"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B24237163
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973783; cv=fail; b=osPTihkIH635B45Kt1EoYx6UJIsd3URf2ZzbbIY9C/6gXb+KKccOvxxgiftyBls7vuYZpXffzRlaDFwjFs92IT9u8MOCQe+v8XhNE4siVz5A8/+Rz44SIZO+Q3IQ3Wfb0nfiZkPi9E8llHJsXk6BLbc+37WT9sltdArMjsfQcC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973783; c=relaxed/simple;
	bh=BT8MDjjcQnI+TrPs9okwLXd+gGSK5xoAZEp1SRoLWWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oq0cocKboOyxJ7XEGacp1aey2GPeaLEZqAVozEcndFaOkk679VHD5mhIndUOVYM5/+zO040sw7nwv5Z4ALLm73T2y3OaMe5RlUdtdbyfSdN7zdRef9c4OrCyEdhBdSW4v5pVQp6vM01ZdLph+kVldSkCz3iGDMTuAHLh9zPyuUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ytBWY9Lp; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5Lx4RO0QyyquUcFQKa9/2RG3EiZEPj8gL4UO6begjMigOPnzbCIYk7VVChwTx8/2ZWGkobmo2AFpRdK/QqO5iuuEWI+HZi88XQGBctWG3rdEDaXmQsIU4t0Y/kXNY3K0R5XsTm+ZnZkbjkk1fTRVFHg7dXh/+VI2GNQ5n142wrgT1EH9XDVfgM/wpSde96iwvNDU7eO5dLqGQLrTeBlUiqFEQvLTxqviq77x+DIjDDlYagLAIxNyc7dJyh4IFdTQjgAo1Iqo85D6clTdOZ2x7PfUeWZ2cIlnO04/vpQSPW6n1k7m9wcI4tHx0GkL1EloGB014hR9M6SaMiBxgkGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=133g8EEgD+U/yx0ARkj60lHz2j21fxD3mSTrTCAWa2k=;
 b=eJ14utEnHwH2ZMQCrR2IkQFQPWgNbOygvekds+as0qi3gGUAi2jx2F1KT5rR4Zbu5/X3LfffaT/3EosJQDVfaxvksFEQTYjFAHnzHbEC25lm0jqmQdYfBdlqZ6n2fuu5HLEAtJLdtLOqTaZeUr2fsTeY6rm+JjC6aq2ddZcblK4jMVkQ5k/oRXVf/9xeaZyDQkHbiT11omqXcBRx9rKH+RcMB5Bfb7aVsPsORREXLUZWWCObYfFqd+jeAp5ITez5P9jkIXdfgxLFLRntOU4bLeHLHBxE4umbjOZh829or8EOroTR187+6wWAJ0A3zCQZX7XILF2oVWKuJwby9x6adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=133g8EEgD+U/yx0ARkj60lHz2j21fxD3mSTrTCAWa2k=;
 b=ytBWY9Lp3cd53PLvh7VPUF+BvgA61YTkkQ5nFwWQXIWkM3qOeVifarBKCizrmM8WmK2KgrO8NZHABkc3zYGoHcXOG4uMmOtfZqpU6VLPzsxyuMn10p1OdPCzmZu4IvwKypkVpAsJqwpE2uDKDM3w5eXJTW+Am1mk0umBkQ11kRo=
Received: from PH7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:33d::6)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 15:22:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::99) by PH7PR02CA0029.outlook.office365.com
 (2603:10b6:510:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 15:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 15:22:58 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 08:22:56 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 0/4] amd-xgbe: introduce support for ethtool selftests
Date: Mon, 20 Oct 2025 20:52:24 +0530
Message-ID: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 291ba121-a3c1-4d60-0c15-08de0fec8d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MzOY1myzGxTDkCXj6e4BY6oV1wsc5zERbcxZujI4pzDx4qp7LEaNvnHnL9wz?=
 =?us-ascii?Q?aoG8tJHhfh7xJi/wGoaDCCUitYdYDWVvzgcUQBh30cLkdLRfqkmScOaNE0o6?=
 =?us-ascii?Q?If2Ak0HUNgQlZO159dySDFoPJLjYY4ENPvas/LYexXq/2oh9ouwZT9vPEjiu?=
 =?us-ascii?Q?aSVPkHimJ24qNHbrrVoAglulVWsA3Tv9KIQjGRUM4cYGp5gxVf4Ro1MZp6Fi?=
 =?us-ascii?Q?ixi5jb/ob76rq4iCpY7WvRqAWmeaLD9hmXaruYH8k3cBQbEu+LQsd6I9Effn?=
 =?us-ascii?Q?HR5zBmeDdTQh2ZiZOcc23vA6XKH1s3NoS1jB7dSKkWQ63KXPHcSo/maMmQBs?=
 =?us-ascii?Q?j+ZT6j5pjRy7MdHADrlXvcPtAz2afllf6E6EyLfZbABeyEWUZA30oKcm4m/a?=
 =?us-ascii?Q?s8Ez7o7MX/i8A9LjwRqj72hzOBe9dC0tYLajsxNKPVaWkBHWQvqjLQv6dxsm?=
 =?us-ascii?Q?EcwL3ui20ffGQGTRPbG4VjwX1/crdMjIRL/9SMduBUuGjQrmNC2EwsX4GfFX?=
 =?us-ascii?Q?s9MW+FaxL7EXipesL+dd218USlOgmfD20/Hw+7j9xilL/IL7V2e3VDga11KG?=
 =?us-ascii?Q?yPmz5a1GqkZQeYNSsIYnQd6n4UN0US2yroWIsWWie0EKpa8OUXRvfqcvTf6f?=
 =?us-ascii?Q?f73Z926bKCIHPmQbomNlxFfPy/yvP8cUelIyoDrL8VECrMQVRteKiKJHngyx?=
 =?us-ascii?Q?kq3W/hXsfX/CxaatV7tLNe/hAoAx204Tu0rQs19AKhJp0ekEKs0UvMjYnRqn?=
 =?us-ascii?Q?qhDgmJl7GuIQtPNOcanCD+hlLHaIpkJn7xGQNk6kM5KAHAJhuDx+8FXpQzny?=
 =?us-ascii?Q?9fkYLbhA7nncV7GFWS4qaZo+5rH+uLC/cBuQOMUrotmox7vCFThtXP3ZyfmK?=
 =?us-ascii?Q?4ndc3/2ivrf5etnhiyaDA+PqQY08trO73u7Vnmfzjf05xjIkrW+B/nweEFPY?=
 =?us-ascii?Q?+Y6JiDw/8uJjDyU4ciUm5Ny/WwRzrZ4ysn3AzvWYLJtbvzLl9VQgxErEP/9d?=
 =?us-ascii?Q?QSGzIPJNoDP131ih+/DpXUe4f4Ox6UWcX8BXG11FtAbjEBIdoBDSSRm++Ovg?=
 =?us-ascii?Q?zQpYk1arn37rTNRQKuK9JZgUeVHL0+sbytNW1UDHQnsdwx3Pbv4DixaR6ahq?=
 =?us-ascii?Q?usyE2jx2QS1PaGGZ3VGjd6rga8i2CzGtwClWZMW8TBJctLx6Ediyb/XkPasn?=
 =?us-ascii?Q?p8xq+ywIUW4vq/9/MMaVoPEKccZfEIjVqCTj0EvnkI3Jj/+8zKuRYGGMjq0t?=
 =?us-ascii?Q?3H8uln+FYTV+0xdpIIheGhiDwsfYG/TsBrXVJS+6QNy+1j1udopJ56KB4i/l?=
 =?us-ascii?Q?mF495DU18kvEwsP+RiTQ5Xkttn77JF5qOsM5/+89Om0UqLgHi5lBYSLDirG4?=
 =?us-ascii?Q?qJTCCbIzs1iKLBpwJoJdj7K+wdMWByjvjIAMa3Wbywwz8TwDDlSQQo7pBiV4?=
 =?us-ascii?Q?7dUEju88nCwA1+PBfoCbJ3NrytYZnAQ+ePV5FXmnIDrsaUys92JQiJdiEuFs?=
 =?us-ascii?Q?FNHTCjs0I2kI1iO3L/Ro6ayiAkdjwbKNyCaOh1R8FppbUuQ9XGcf+eJXk4br?=
 =?us-ascii?Q?9T52UASosMoH7+TisEI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:22:58.9538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ba121-a3c1-4d60-0c15-08de0fec8d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

This patch series introduces support for ethtool selftests, which
helps in finding the misconfiguration of HW. Supports the following
tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

Changes since v2:
 - fix build warnings for xtensa and alpha arch
Changes since v1:
 - fix build warnings for s390 arch reported by kernel test robot

Raju Rangoju (4):
  amd-xgbe: introduce support ethtool selftest
  amd-xgbe: add ethtool phy selftest
  amd-xgbe: add ethtool split header selftest
  amd-xgbe: add ethtool jumbo frame selftest

 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 511 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   6 +
 5 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1


