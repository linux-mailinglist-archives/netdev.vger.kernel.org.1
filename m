Return-Path: <netdev+bounces-106458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71842916700
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B7E1C21AD8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFB152503;
	Tue, 25 Jun 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9EBv4Qp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274D14D45E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317338; cv=fail; b=QN+eL1FFUw4gEF8Mv7ee2MUf1QW11jC/5/CmxgpfGacOcLBsrq4kDDKYLtjul2aEg6B/sZXj7ZoUOIwjx5BzozDJS+IjOptwiDQAojpyhafr5v+E0H+rwjl4mis7ejjGnJCjAYRjq5E7Mcf1s7O6sz2YRqYla5ZW4mRgXBYJndw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317338; c=relaxed/simple;
	bh=GSHBqyhAwqhOWue9FNMbSm2xqYhpHDst3qNlLSTLnVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RthudyRBtxyNVeAiYss1JU+doG0sUIGLEtU2NEnOjFsuR2KwefnhehzFuKHYSK1G7uDbwemlt5X4jsNfKPm4IobFz1QFu+pvWY89xzWlM7v4s3B2jaIPszBhi/7ZXzgM31mwo3ko7Sdx9ojDnVwAXCUp7DPrVcN7RLZW7HsIsQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9EBv4Qp; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjMpv/nU6CBmiMdKa3Kx40oEQkdlA1sbQVbXd/B6cbOZNCcXxVvkw+Aq41f2oJazIR0iV7DzmeuU4XSZoTQahIUcaxxQB7c091VU7+7sWnBV5Gr0KWYbDOLvV166hSS7FCwJk8svpYlrVLsjIaykw7E4Ay/43wySwyTlj2vVqZ8F6AeBQR4qSFWBG38XvN7TUow+APfR7DzjnNi7CbeB+tXIZbBa/oqPDgWKXsMRtts1f+1tzDcucCL8EJ9CqxiYUMd6oNYyAIPk7tPnI2yc0ayEaEfNE8HWgXlIZH39VYwfQZI1fh+chGc7MnSbNQ0MjFRqlxxwgdUc0iodgsSe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm0LTzfYHRXcrHaBeIcuxrDE4X/gdrNdRM5J+Z6C15I=;
 b=OrVj4GFMKmaRvZzI8NfHYjPjmSza87ryziY8sn0qWueJIr0P2cw/uk2YdfVpkshGqetUdOCUDeGE/hKvIKHtzLSGeEFC9yiFF3D80a+FpqLsosE0FlDrzOKdTFt65+NSTJnzPvdEUtqYtjqJbUKzkOWiPDGeR2dsJ49ZtSSzSVCD9xqUPmqPbf9nQ4qjti4MlqGsjZBXqPiWyNStX5CdLWql2JPxv0jWgiMdKTiHT4AFCOWnge9mMQqn9Rpt/VY2Cmo1Gqr8Nf+8HAVl0cvpj88Gwqdn9Lql6RrInHIlNhnp6YD6kYKK06GTNbHonXUmjIpxHJC/qk6iq2kUniesRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm0LTzfYHRXcrHaBeIcuxrDE4X/gdrNdRM5J+Z6C15I=;
 b=M9EBv4QpJjlsQWg7GfuG3OxYMNhb2k9NEdD3sEzn54kFMxvReqAhBIHcAx1ajqF4/plp1UYvlh07MJLTh4Oqq9jUnXaO2gnGySPnUavHv6tlB3nz7qfCIGEHIZ9UlXBvMtz9nGz/t5PG3iSdxWFacRgiGxrmgon30UEbZ9QcSWqjfKHBJzt/eyciWg0X7KytB0nun2LMv4QIepxUVYBmW6l5xhUYYl3R3Tr7FDOMPPAazBBTSQ++vU/PkUK1D5rHpZLx2xUjNMUJvxRANhJgwfxfr+ODOSXJkgNfjL+WmL4qaYRSQkQyI6GV7hpOOPE/pbOhXZ0YO8ZXp0DNBPZgng==
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 12:08:51 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::55) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 12:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 12:08:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 05:08:34 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 05:08:31 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH RFC net-next 3/4] mlxsw: pci: Allow get page pool info/stats via netlink
Date: Tue, 25 Jun 2024 15:08:06 +0300
Message-ID: <20240625120807.1165581-4-amcohen@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625120807.1165581-1-amcohen@nvidia.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 26008df8-1f78-4ee7-24f2-08dc950f9367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQfrlvzwwmX7wZf01l0qazDxnVTCsYr0t/Z/sTl1+bXYiScTVVusOA+vUXSE?=
 =?us-ascii?Q?WrNbuhFKWRUicjufuPiOnhmhHlir1j5ZkBiNMLTsQUCESsdoA1bFQwnMVeRq?=
 =?us-ascii?Q?+2FNiX+29sXk4HQ1d6pj8qmocL56QCrlO+ViGJgONcn68CWGOX+e3Q7QPn+S?=
 =?us-ascii?Q?+b52UheRCmtfOcc/gT7b1qB0oM0e6z48YMrxHzC2mTL/E3D5wJ9zseWZ00bf?=
 =?us-ascii?Q?Zmpfk4oyMASXRtqTgKqvalxHVJrpXEhFK9qyxCwPoRxJGzheoRKoVaGnZwA4?=
 =?us-ascii?Q?cjvJX/GBx5I8PmJdPXR8YllSxofRIsJOxEo4g7zqQKxack/7r+2fPV2TMBlo?=
 =?us-ascii?Q?ivQyKuXPsSh6zjjVUiCCsKZ58vvVGG+lTqqhST8j4jVfbJoit7SYH5TYyk5U?=
 =?us-ascii?Q?3T/3eGqOrDcmCmxVjXKx5Hq9An2hP0lXLIHDj1JqxtQ7lm5CSG33Uzqefzvi?=
 =?us-ascii?Q?qmTfMm2LNoEmSnJXthU7ORJbxSJtrrzEXSLnSXkaSTKhTn4pc/lVkJK4dupR?=
 =?us-ascii?Q?+i1ifb13jhf1DFd+SIPamD8V5oMYzbfX2NO/NTVTp/FwlsFAGlZTq8y3Kk1b?=
 =?us-ascii?Q?W1MhRyTmZ1rU+AoOKr9gzguBJQFL4gQUBuaeMhIQ72f8nvQ7HzhPuTQ4vrl4?=
 =?us-ascii?Q?Dh4vnRchRudi/BZ7ODwvRQHYcf/N2bScY+/1dV27uv+5PDuk+H54ft6XJaXh?=
 =?us-ascii?Q?EoXMYvRNOvsFM8TAK+8TQfChfIi+lhC6H2L6RtJlDVBFRgfbDc2Z15+L0HkV?=
 =?us-ascii?Q?UlyRQljOCB/Ku8XVVCza2RHxoNh5xHPcwV/m4gqGZPJTrVZb5wyZ+iFEvIFe?=
 =?us-ascii?Q?fROm8LKC58Vgzn1qAHVm4nsT/sBIN/IS+qf6A31htUe4oukh+7uIh3g+ocAE?=
 =?us-ascii?Q?ykcgziUlVjIFfN22Vo8XJxUDvrWveq1aNTjmBK3hlJlBSLWOQIbjj4iAm0mL?=
 =?us-ascii?Q?GYq1L7U9n14eFPSDLtBCYTDBKx9SgV3bCYML0TClkWvOrLYax5543jeGZysS?=
 =?us-ascii?Q?hMTJFHSinye32Q12Q8KAIb8Vaq7PtsROVvEJ+7/k1qD5arS8BNn5pe1MrFYE?=
 =?us-ascii?Q?X/T9LiBnK6ukEUMC/P2qJAmdcVW35alfny1FYfDJuqY9Djd0pSIR5FyOae/m?=
 =?us-ascii?Q?CwNmGaCs+UxQlUgOZUUIHDbEVd4xvmDdtAuDW8tTwQ/aIJwxbpznZhlpGO/h?=
 =?us-ascii?Q?cLOzG/NT5CR7Ye5RLPYu4Ip/k7wgTjpuDayMl15JrWT8y00Fi3oBdixn4tBN?=
 =?us-ascii?Q?unDeU96zS901tuSmZcAWGIMHxingEnP7HK0omzNrdObUgTPPbrMZjeDkwy97?=
 =?us-ascii?Q?tCNcKDjnJFds0fouznX67iY69wCaGqd68oKo+Dn6pKa8T5zPwCMq5js5cf/L?=
 =?us-ascii?Q?qqA8iVqJFxGZE8Wu/nuyxT07AoSLSRqxoH5iMgsfw+yOEW7hFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 12:08:50.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26008df8-1f78-4ee7-24f2-08dc950f9367
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781

Spectrum ASICs do not have queue per netdevice, so mlxsw driver does not
have NAPI per netdevice, instead "dummy" netdevice is used. Lately, the
driver started using page pool for buffers allocations, each Rx queue (RDQ)
uses a dedicated page pool.

To allow user to query page pool info and statistics, page pool should
be attached to netdevice. Setting "dummy" netdevice as part of page pool
parameters allows querying info about specific pool.

Without this patch, "do" commands fail:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--do page-pool-get --json '{"id" : "20"}' --output-json
Netlink error: No such file or directory
nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
	error: -2

With this patch, user can query info of specific pool:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	--do page-pool-get --json '{"id" : "20"}' --output-json
{"id": 20, "ifindex": 0, "napi-id": 108, "inflight": 3072, "inflight-mem": 12582912}

Note that this behavior works only in case that the devlink instance in the
initial namespace, in case that the devlink instance is reloaded to
another namesapce, get command will fail as the dummy netdevice associated with
the pools belongs to the initial namespace.

$ ip netns add pp_test
$ devlink dev reload pci/0000:xx:00.0 netns pp_test
$ ip netns exec pp_test ./tools/net/ynl/cli.py \
	--spec Documentation/netlink/specs/netdev.yaml \
	--do page-pool-stats-get --json '{"info" : {"id" : "20"}}' --output-json
Netlink error: No such file or directory
nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
	error: -2

A next patch will allow user use "dump" command also.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index cb043379c01c..7abb4b2fe541 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -892,6 +892,7 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
 	pp_params.dev = &mlxsw_pci->pdev->dev;
 	pp_params.napi = &q->u.cq.napi;
 	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.netdev = q->pci->napi_dev_rx;
 
 	page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(page_pool))
-- 
2.45.1


