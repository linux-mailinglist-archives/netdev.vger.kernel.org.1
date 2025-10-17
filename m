Return-Path: <netdev+bounces-230340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33536BE6C3B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E61A94E4436
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F3217659;
	Fri, 17 Oct 2025 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDobiweH"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157B3346A8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683661; cv=fail; b=PRPdoKhzA+pgeNiHsUYim3lqePe1nOKL2WsF9apBIsqu9Aef245wPAdlx1MHvuf0WBVzLe4nAES71+jZOamvoe365aMhrEnumSBU/eeccHcxy+ICfJNnMzXbX46kQIlhVBaEyTkR4J1uwtuKuIbgLehcckZfTj/VFnr9uQBafF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683661; c=relaxed/simple;
	bh=5DTKAzuXIjb82hiP7A5FEk8eHgJwNFk2hgLEdRcRDQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hS/783BBFJTH20J4k5GoUZdsjl9q5E4siIGC8CHABKrSxv7lDTMz1D3ih/Te4QmbEiBYn+zdNfY02p4Z6+RhOci7dZ443aJHs6FAoprd3TRwHPQbqB5S3S+SOLfFgsDTQl6vN5uNLqV6oBN4SuTUXKWF8rFwBfmELHwJ0l7Xfac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDobiweH; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDZjrvMdr0XMrOoQkMbWmz4DdCKf3d3aUyPXmSZLIcB7Cong8UJd27SJlamB9w3Sf3wqYGCfzRLb7f0IhUHhus3XDcEFgDuIRedk0RalgdRXYYD8JSWEcc9pYya5clrs+rL9ucFfkABHX9t3+aE6Zyf0NxdZjgQ/GJwrtaxhJlSQ5PgnhHBHFFvkZaiuXd6ZeV0JQly7G5UF+5zP1vGyH1g9mVQb7quTAzeKIA/XoQlN/YAr0sGfrceOgRa/681vDyZjel60IoAQdr7XyXyhyvph1bGsbe8oYR/R48M8YyknbPIn54feIxeQN9euUhxRZVYUXuf3uqg/WPkOHlZXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gDHY+1PjQsXLWjRs9H7afypIijKAx436y+WEFwJxpc=;
 b=F3L+yvVFnj4xUJsLvhM2jdKgdkPtD1n98Fn4UcxCtG1yY3WGIbCrycYTN5Y9NCDqVuRGW2Fti4/9t6r17ZinioQgdXZyfg08xw6rTu4fUK7lxEX71JuPhh/CZx1Mllyem92uz4eCxFTIyx/5YiUIUIv9SmV9T+M27QkJ7cFI5iYQpzTl71cq/G1UbXE0qB5qKfdjn/GZr/BLhHga1dh/I/dW4JkmXpYkQnzWs1mn93qRqP54eozEu3HvGkk8R/CngJVSqAFIZksVQSW092XmE2YtINlLlidEddgS2WY/5OkP8kW1Ages5roCzQyu1xUKZE348iS33BftvU0ifHW7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gDHY+1PjQsXLWjRs9H7afypIijKAx436y+WEFwJxpc=;
 b=IDobiweHVstbwTBAn/CHLuVFSbPnhae94aSDTxEDiO4a300aXV46c3zt9sSQ8PDAgriyM2c9avPQt6wd9coM68HmPX8xyZt8R6D1d30bYLUWGBbhejPQqarWOR+NgfaxeOuiv0Th1h+Oa1ZKwbeACm90EaSbj0G44oRQM0zOda0=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:47:34 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::77) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 06:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:47:33 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:47:19 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 0/4] amd-xgbe: introduce support for ethtool selftests
Date: Fri, 17 Oct 2025 12:17:00 +0530
Message-ID: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: ef58600f-e92f-4831-49e3-08de0d490d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WaEQyG68M0govyH/Aq9b4utuVXzdsOhPov4T+dC3YGMZf7WI6r6RUMQosQyn?=
 =?us-ascii?Q?ZbX03moFFgVZlYjck2XEdnp3ciFIT3se7hEh3EMf3gE/dBpqn96bmmRcTL2p?=
 =?us-ascii?Q?xDU4pm2yspIfZ7GbHvOiwqWjff4dzly+owcUTT9dJlZsGC2Z59RqX1EU2P0E?=
 =?us-ascii?Q?DJhFxiWDoQXTX0wGjm8gBn2UMR3/yHCjV69RPvIqUqu1RzdzC4bQxUTozfY0?=
 =?us-ascii?Q?lblQYKb/By+bamCRScMSPmvHaHnGzxzA3+uR9ltN2UNRCdJdijW9gSU3iFN0?=
 =?us-ascii?Q?zdG6mHzVvWaRe2ExZR+5Sg3VyEm2GJ/Q+A7SQibcjhSPOYJv0qZT93KhLcuz?=
 =?us-ascii?Q?LR8+8apDG7oObvmwXOBJ5Y14qNmk5FRqt4boaFcQFplnIFFSyWyxVDuLLRgN?=
 =?us-ascii?Q?96YjteKF3OPAeGj3NTbHKLmdc7vivZmaEe3xCnE8I5rKV1ay2lFMloX4yUNh?=
 =?us-ascii?Q?NlTIwJzg+47VzLjQFx8h9dwZWUP9Ivy2l6qJvShreU8AcYiAux01vhapv50e?=
 =?us-ascii?Q?rm80XuEdovfR/ApkugHtE48DQ9nAK0WOx06wtcnWBcbol/Y9wg6kqeSZx/vH?=
 =?us-ascii?Q?uFDq8Ju2JN5KaH3iF5TsWxU7Q1DDCuI9EIg14xYceQdq11uWLXGB16P6Boeh?=
 =?us-ascii?Q?2H0nkR+CwK2mHzD/3dA6roL3bSq5I+VRoSGTTaw7Ys3rt65vVM/joaLydOb6?=
 =?us-ascii?Q?YxYHSv5pagork8sqLbyOnUnhVScHu9oj+KmAgVU4kvccKXpvdcfSrfCpweSz?=
 =?us-ascii?Q?yiomzHeqxO1nIZBWKgVbYhClor2bTMK/4NJPZMlv7NIhM9h3yCabhBruLmBw?=
 =?us-ascii?Q?M1qntfgrKCxGjIeC3J6T3aP23EBcj9+Pj46e09reIi1FrOMXjBs0pt0n/JIZ?=
 =?us-ascii?Q?Dxh/uz1x8Te6DUhKErsLwYeVWluwl4SJ73uZBVZVZnLd5PcN/Ab/mn1/YOZQ?=
 =?us-ascii?Q?fztlB6pMZ8a3Fyv1FE8WMECzb0Ix+QjudQPxjzuLXNvXeJZVAvIrwBnmf4r7?=
 =?us-ascii?Q?qFMFfl17WE5tmSyZ/cIoqzDr/Zf3VJQDpCjRy0RwGx+zH0ogm+WeUfSjbRw2?=
 =?us-ascii?Q?MetqIoVZHd25f+X3C3CjMaJR8OWPu6yQW6OzMJCgmzdEHRyaU+xku+Rx6ngn?=
 =?us-ascii?Q?htfO8YsBnvTi/e4anblgykGIeByZKHJPq9IPr6c0IT8CjHKNodMvwrrq30Zm?=
 =?us-ascii?Q?iRYf0/gbObpxe50aF/Fr0GEiSTH81tpn6fWKG9K2Sc4Ke+7EhiWZqieHsoyF?=
 =?us-ascii?Q?KYVylFLsTxd96+mpMIh1RfXzKQ8zyl2XxrvLh1X03emU7rBNIm2C/o7jttlM?=
 =?us-ascii?Q?LzGHyzsE5ChyYQp+yGCfClFhVs0RA/gFMgH1t3loHIoPeN30Jq7D8a4VSZrQ?=
 =?us-ascii?Q?BKA5M+IKStEUhnrORivSe6fuH/tSMstX4w0fMeN7jgUZsqMxyjSXKJACDsw9?=
 =?us-ascii?Q?ztbGjKtgmiMk8KvUDOz2f7COnDj9+Qpen6M57W8i/iqd8r36IDU/e8BJkkmi?=
 =?us-ascii?Q?l7zEik/OfSDJMnu7yg+rbTk2Qg8ymVdXbIqy4lH0W3bLbTRx4KRoM5hDmuLw?=
 =?us-ascii?Q?gUfT3H2yucMOvWCqPo0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:47:33.9121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef58600f-e92f-4831-49e3-08de0d490d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

This patch series introduces support for ethtool selftests, which
helps in finding the misconfiguration of HW. Supports the following
tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

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
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 506 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   6 +
 5 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1


