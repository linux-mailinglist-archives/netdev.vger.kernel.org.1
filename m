Return-Path: <netdev+bounces-211549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA2B1A0AA
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A9518965CC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294D2512E6;
	Mon,  4 Aug 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0Rr1WNR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBA1D7E31
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307866; cv=fail; b=Byuk3Gwko7w7VRxOQScex+w+cdjZVMVUqcK2cYtSVJ+Yd5p4p9dT+2KsPflCJ8yvHW0xYDE733Bpv4H9F9KnOCS/tTK7p4KCUl3ryhs8CkAySDio0QXpX3326uMBL7WbSNKn3u+9T3VBIlo4KC+IyqHCQ5h2WjfswFrkL8ib3wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307866; c=relaxed/simple;
	bh=PYTufaWTleY6Uoghrh6Qv5BAZf3Ai8YObGXKficmeVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXtCoo8/Gkryov/X85bB4PnWHc14Bh0V67nVZgSoSLbMoTMCGU6JXYx6C7PYdys/BlpCVIgZgx9nt5aal3dXW0jaVD3MfYBBWCcCjLfIcApWdSY+vlXG5+B+a94/lGBWb0o1Rv9rGaZMq9GZjnPABtEIzdGTO/fUh4xsl16encU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0Rr1WNR; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg0F3R+bZECvQdePbra2TzKZZzId6B28gk6SlEzUhCY6ZIfQojr6N4IpuBUu/9Sw9DmOF6CDfLZuSHLYYj2jBKBgAlvPqCYESHfnUDCzbzqlC1TING29WJVa+uxy9NihicbIgBW9JOzMdiatzQIMG1lNhmJeZmP6v5SuZzOySSGGMwT3xuXxwBgqRJ8j5xseQ/hyuItURB3Vd63E+59RQTIU/iUsmedAGkqNhnItmNvb4Ns8NAkGgphcEMOJNx/W8YHO6QeKycbwRDEYvCQXPFs+3C6AM/gCbP99poeNg0NSlJtFUUuGMSMpd7CHlT7411c2r+DuKdxT2DNP7+91Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or6yed99JBtCvoiLhWkDKrpQpSEHjF9iuKTAbo7oqeg=;
 b=mTUmhd4RkrMf+vpQFqo1ofj29fO5QULG8784n14/hBXK4+Zu7YfNwdtcNa1qrQZcrTA2MaBS0U1jSKFoBzWpr7CYxbepQ0fzEZ7aeS6IA0NuMLBhIDXvBZRdeH6BivZCcwvEyck6+EEJ5dLpdNHp442HAlJtoFJeNwWUx89jFa3aKTzAZscZXKgloP4FIqc1RFoLkI4lIywb5/uqW0T/mdWob+MAon/PkswdoIPfl2nYSaxgZjb3LTIHL4mmYfPwyMlDWqc4Aga5SYAgEh7LeSAlGqGaJsrI8dhd21kE2v6NCFRUkEy/3rULkZ0JZWbudixiqDY/TBC38HWvc0MRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or6yed99JBtCvoiLhWkDKrpQpSEHjF9iuKTAbo7oqeg=;
 b=k0Rr1WNRw5qP2FkqnfSujp/f7YCEPXprOVwTQcGoHKp4NZ7zTB6ufJerZJeVpHHV2unXQjQ+D3plyxqSXGPoBxEOS5ssSi7Fktp74fbdfwZD1WfTMiDwi4QkCoaKn2O3rqtMiz5bLx7Ozo94XSp2G2mt8KPo5hlMzbtHNpnQ4Mk/75DqoLz9LnYCsWTWz5LJfoi5xW2HZZ8gQ9mOfALGqqk3d3F9bGBG0mZbx6/rlDOn96E3vgOTGDfEDlgcT13FSuNqI9clN8RuY+L8xSfjLCcpChDVF548Bd3/2YqGONQJDMriuVz4y3z7y20QXAmGU8ELPVQVcvqRYWGscRp7+A==
Received: from BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Mon, 4 Aug
 2025 11:44:22 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ce) by BY5PR20CA0009.outlook.office365.com
 (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:44:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 04:43:50 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 04:43:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <petrm@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] selftests: netdevsim: Xfail nexthop test on slow machines
Date: Mon, 4 Aug 2025 14:43:20 +0300
Message-ID: <20250804114320.193203-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b6a4d1-5240-4f9e-d6e9-08ddd34c410d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBA5OX1XaoGs5XVcUH1LFjg4vpl9N/+x2CX6F8fVjDzTdGJrxK9IEElU1L0y?=
 =?us-ascii?Q?b3fZmG7rOyr5Nm74qUXP2tIIIe0M4I+n1XpvUOPpovpAmGbY4CIlGGd/zc/D?=
 =?us-ascii?Q?E2gGnlb5ciGOhlBRfaCgdGPhBV3m6gicj2SSvRJlhfW+apkmo/fWjNokMPln?=
 =?us-ascii?Q?1hF4gEb2bvhrZD3egf8psNBFcVcQU9RIQ4jZ8fnZYoFZm8hubd1MuiiDulfU?=
 =?us-ascii?Q?LE/sMYxyIuTMCY3Ikp8k2G1k79KA90bGUlPtxjyUJBOo+UxHuNdtHsWmGpS/?=
 =?us-ascii?Q?E/pzuP3Hx01sGQlmAS3Emp4tUkhPOW1ShObhy1bozfwsABHY6NzH58SIz9HK?=
 =?us-ascii?Q?Vdz0NAOmf4lZIkcv0894RM9xAhlfMzewMkcdz0e5Vbfm8mgMx6erJlZvIITw?=
 =?us-ascii?Q?UUcGfRl3jd65tAw/DFWI8sA3tdRjdcoMjRU+3cvQiPsZ4r1yjooJpXzT+mlw?=
 =?us-ascii?Q?sEu7tYtrbfCwltBnJ3ZsKcqAz5XZjaDXAN8exUL8pDUcer3cxVTBMraWaeRD?=
 =?us-ascii?Q?QsGcqvH0lnEV0wBPm6hLgQ15Jsir8rjNxtGgsENJFGwJpSrHXK+4Pxqj5dAD?=
 =?us-ascii?Q?lWdE5FYsLNmjASCZLRyaNoOI1m4OXsCXCkvQ9mIh+1v/EeZ4SpE3l1Rkm53E?=
 =?us-ascii?Q?pN7kwno5rZ1TkJtxC93ePXdFwaBu+y3vj0NtATcyCz3mRbp0ZthGCToJrL11?=
 =?us-ascii?Q?yPkbzJ0MsxK53+wzZSiHRqOBKuMGgV5a/bxns/5rmZBcjMEcdlix42X58Iuj?=
 =?us-ascii?Q?+UH5UQ5B4M4AHqqtPvncdpc3/z9+z7XZVD7Swn6VQiEVYPQV5YD2/kZ1GFLe?=
 =?us-ascii?Q?4qk1no0POItD2TRBLk50ey1wLjFa9S2R3ERe28t2HTgkzfG8V9paC/3HhbPB?=
 =?us-ascii?Q?UZzR+LnehUlXdAbEad+ESlN+V/JsEhjKwgt/PXyzOfZNAj9V0cM2+Nvm7sKK?=
 =?us-ascii?Q?BRADn9Tuh8lZI7WBYaEBZ9tIB9UfcWrszUY+HN1g7G8cEaj6HlDmbNajPFra?=
 =?us-ascii?Q?3WdhuxGMg5l35quM6FE+zh8TqZGvP+LHX29e2ruDwyD3MmmLYgCsWpEh4GuK?=
 =?us-ascii?Q?xnFkGaSAOqZ9MAU9viMWQMyIjYyGCqFuF01yX1UfQYM0iu4xN2Yt+EDplRBq?=
 =?us-ascii?Q?ylIfGwk2j0GCvBnD3pzQKNC0rN7+F0LRZu5z4IoEIjc4orzoKHsKUB/5ya0P?=
 =?us-ascii?Q?N/JLt0o5t4Gx+uPymUs59q/H8fK2nlW2kg7XHrNB6Jcw6zos29sgB/2MH8sN?=
 =?us-ascii?Q?Kp+gF2C92R1KKGxN1ZP0s7z5NRPGqRE78Pt6q8MsuLuhL5ID1RUjb6KjXEix?=
 =?us-ascii?Q?b7e9DwyLG/UMiTJ4ai8xqUMNDOJkAtvv5SFMpCWSNF4//12zAkqNoxaQzw8J?=
 =?us-ascii?Q?hNFhAIJTrUr5o58dK3DiZbNJn7cJG2PStOIYbX54Xwix3TQF7eawkGKkWZvQ?=
 =?us-ascii?Q?egT9JPSUrBmWDSDrZHuQiAy4FxSOtfAKgUasEFXKbWGVbBTlqTsQSSd31Aai?=
 =?us-ascii?Q?AtxYmIAkjGlNrLumcMYSA3wuU0g86MA6zWtSAyQFAtfmlesfGoCN6qD6rA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:44:21.6075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b6a4d1-5240-4f9e-d6e9-08ddd34c410d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330

A lot of test cases in the file are related to the idle and unbalanced
timers of resilient nexthop groups and these tests are reported to be
flaky on slow machines running debug kernels.

Rather than marking a lot of individual tests with xfail_on_slow(),
simply mark all the tests. Note that the test is stable on non-debug
machines and that with debug kernels we are mainly interested in the
output of various sanitizers in order to determine pass / fail.

Before:

 # make -C tools/testing/selftests KSFT_MACHINE_SLOW=yes \
 	TARGETS=drivers/net/netdevsim TEST_PROGS=nexthop.sh \
 	TEST_GEN_PROGS="" run_tests
 [...]
 # TEST: Bucket migration after idle timer (with delete)               [FAIL]
 #       Group expected to still be unbalanced
 [...]
 not ok 1 selftests: drivers/net/netdevsim: nexthop.sh # exit=1

After:

 # make -C tools/testing/selftests KSFT_MACHINE_SLOW=yes \
 	TARGETS=drivers/net/netdevsim TEST_PROGS=nexthop.sh \
 	TEST_GEN_PROGS="" run_tests
 [...]
 # TEST: Bucket migration after idle timer (with delete)               [XFAIL]
 #       Group expected to still be unbalanced
 [...]
 ok 1 selftests: drivers/net/netdevsim: nexthop.sh

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20250729160609.02e0f157@kernel.org/
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/drivers/net/netdevsim/nexthop.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/nexthop.sh b/tools/testing/selftests/drivers/net/netdevsim/nexthop.sh
index e8e0dc088d6a..01d0c044a5fc 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/nexthop.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/nexthop.sh
@@ -1053,6 +1053,6 @@ trap cleanup EXIT
 
 setup_prepare
 
-tests_run
+xfail_on_slow tests_run
 
 exit $EXIT_STATUS
-- 
2.50.1


