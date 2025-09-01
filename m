Return-Path: <netdev+bounces-218618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04AB3DA47
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2131898499
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD5256C9B;
	Mon,  1 Sep 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6qhS90o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E02566D9
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709554; cv=fail; b=q7VmY5k7Q7J/k7u7qlBbqAv2rbILTx4ClUFrmvcAjR7XA0Gnqt0Hje/GAwiTEz86HSv99ZawDF2prfIbDmD7SBs9u65ZE7fRC1ZLfZ8Cbtd8EFarLA9cZurGKYkzvs2VnFTxXeSQ7oI1sH+acdrv8CV0+8fXQVhxvD2BkkrESLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709554; c=relaxed/simple;
	bh=hTJgfWWd6myZ4haIDT1WhR15VweFNGr5kfCHKQup9OE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ns0ZFhpxm98G4dIfZvJ0JceOUxRr4qAo/J+XaFMTMZsriERTzkwCeatFMsBxebYlAoTWmftuX2X1dAL2j2un14oHdM5wnRaJviL/xdvYO+rRHEp0VCwjnwuAAp8DwGkM9dMqhHZ9iT5NvKY+P74sN3UWL/sRPVi+8rCqXqoaV10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6qhS90o; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/kCLv5HYIsNzRvfYSppFR98qGSiu7raHXrukorMwVwg+o/GDB8Z9EDq20b9JE2qjt17n78w1rnkGmfXfEN7li2D0SVDEvm9EHLhl4TJTNNCmYMghoVNF87S98XNmbNwbwth/WiFqiVnU++yHAH2nlTFmkHQnpr88dZzPYvLj+qLE/Evv1BcyUMwxFHAYe21oX1yUxpEw6QDky37pwW9tNEEmMbSJFm30CIAI3mOlrt+nWdRPOL2S/3RdKQNE6FD2XI0e9DkF2T+TuEJ0l4J4cqFm/cUv9fUcfgcDJ0wSIZAQU85qsPULRREdE+LLA2OZ8tfWpzFlvyqL6KBHmPFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/niGO0teedlx+YSi6X4n4gZjsmXlUImkQgoJDYH0Src=;
 b=kMP9wsANsZsiL1f/HcYPaGFnIhwvMDtcPxE0ikRXJv8GVy4NGV0mVxzDXL9JHwsJ1rSzPFbY1j7ppVwPUK0CbKvMkAPVu/2+xM2PJnc6nMrcX0S8kkTB5ESHJioTEiUbakqjuGNph2KGvtRBIlqszMo796Is/ct7sTASz/nd2Gqj7uesJbVlv1Wv8yxq4VTiEiuLR5ziMbcrQSQdorhfNtpFytXlOCHksSEVtzbUnFbtCpYT5fdykDbfrCZn/1pGPho1wXaMxOFHctpUTcCMLSGoOcbhmxQPWHGa4Fo48vatm3ZzjZFX50IFE9vNjHPSMVTt7Euk+lfi+3+LaWscYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/niGO0teedlx+YSi6X4n4gZjsmXlUImkQgoJDYH0Src=;
 b=X6qhS90o8q72BoCysDATgbg5RPB5+EXxzDRB9PlXNitXXAv/oehGNqgh2QvvLf+XWwnZceoZ/GTDR6+p+2/jOabg8l9f0rprRuy56bLwe+RkTRIuAnCMUab9jOjSNHB8hnuDiOCBxvUQAYw1lubDmj+86t4B0PQNIc7uj/SR0FJm5oGXRL1nL6QsEmZqk6agUyknsF8DiNV1fAgAYHB0t+EFNQEuDsJqsRalCFYBBqT+Q6uiNtQTsk3WHeMecf8YnVmlv1wZGQmWOPC2XorWLvuic5rT29OOYJJGflMw+ukL9vdJrhtLPzArLNrzXGkdSoYBjwNcFfs2ZRVqipi/vw==
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.25; Mon, 1 Sep 2025 06:52:28 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::2e) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 06:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 06:52:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:13 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:10 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<razor@blackwall.org>, <petrm@nvidia.com>, <mcremers@cloudbear.nl>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net 0/3] vxlan: Fix NPDs when using nexthop objects
Date: Mon, 1 Sep 2025 09:50:32 +0300
Message-ID: <20250901065035.159644-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5ab53b-742b-4a5e-9c66-08dde9241dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCh5sa4UMbW83eL3f1wBfRIUO2aNPSBXmfEDmhn+02Q/Lnq8WcClfuwXxrA3?=
 =?us-ascii?Q?ax3wG000kSexRn2QL4o3XVEyeNFWmZadRzZ/IISBJQdVh9bgjBk3XHsorxnj?=
 =?us-ascii?Q?2Y6lRDvwj4EcasU+xCdfxvR+dyePkIQErHXFU7YPmtWdYQCP9SKMO2xtwN+o?=
 =?us-ascii?Q?EGoFj6uLQwFaK1nNVptVKXtC/IaZLtOzoQWXJlKTgpxsw24f9H1p2NZbWIPT?=
 =?us-ascii?Q?Bt8KIy+t4RjVVGEst+J59qgQaeEh4zRtVNti9Wb6dTZq6lXjtBY3J8SN/x/3?=
 =?us-ascii?Q?71diwWzn1x0FamN1eAtXPd4BgLNkntFsFpPBuYd4HA7Ii5ChbdwIxg3hyA4m?=
 =?us-ascii?Q?SMqibOGouyHZiQ4micigCa0P82Dvi1ST+y5eXEiB3D3qkyFan4vFIWV2OlUH?=
 =?us-ascii?Q?qQB/UR+DIEAXSQ1VFjH1rxPmtgi7HUQQnZRoqAvlWius0NCVIesX9kBO7Dzm?=
 =?us-ascii?Q?UxLIAij9rnLJ8WkFpaSollycEew3zHpDpc6R0gbnXyKwj98eHfuwNEEuCmSW?=
 =?us-ascii?Q?8e6t/NC13tjtYSa2LGzmxgq+Frv2N4ZR1jOD6ezoa97C0WzosUG+w+WQNaeJ?=
 =?us-ascii?Q?0CsVqSGsxZt1234aGDFu72ByFGt1d+DEnulUZlJOuhgx2yRyqe1Mc9Q98fVk?=
 =?us-ascii?Q?FDRVOiwpGG5a+qHgacBB17Fsv+jNfG3yHHqX6HtjoWbQnvtB2c65AI7dF2hO?=
 =?us-ascii?Q?0fhsH/2aaNLiIgS4pzO0H/6Tckj3+hqIFmqB1gGfJbsUyTOjbxisu9GN7++P?=
 =?us-ascii?Q?VW7aAqlsBhWZKoxW9R8vZ/ZFwN3ZkiDYivHica30pTCMO2FmbKXMVABfsold?=
 =?us-ascii?Q?1+iqZmyr+ARFyliDxH9x8Ol8Zf7nMswAMmnlj1LQT33bBI6VB/Qu6/N3Y/oV?=
 =?us-ascii?Q?+UPpzcOw5VE0g1VUqwAhU1HF4wtQ24IuTMMpUFHE7tDArP9Uat2ZSliSjO6Q?=
 =?us-ascii?Q?19heYh9lkgXf4hI2R7ks0h/Alv1xS99a71Drjk1ixe3fcFcs6+hO66RTw+Ri?=
 =?us-ascii?Q?Vx7XU6jc+Z79GON3nKf1B2TXWz7v5+SNL+NdfZeTH2h779UoB8nlJ80O12Ib?=
 =?us-ascii?Q?dUX4QJ1wJhqUdur0CHf+Fr/ESIIHC5wquSGSU5aCMUBqdPXqeUVEH37etaCX?=
 =?us-ascii?Q?NoD+iDEt3c0Sq+T1wit8EJtDlAQGwi/SZoWdy1Vy86fqeI0esoThhZOZPQjX?=
 =?us-ascii?Q?4ET9rAxKvYYgcL2xUPWyY7nxLGibl/LV9DBVdDn1TSS74ZHgVnmn/MiFpEkw?=
 =?us-ascii?Q?I9oFfbr3JfICol/PnRBjRTSt3IkqxZWqzXToGrTGbU1fdlNcH09ETRo/XpyC?=
 =?us-ascii?Q?ZyNdX1ZFeW6NrjtRDX1mBqojeBqQuTS57RAfgWwzcttziLaf0xVQ2ybwtVZG?=
 =?us-ascii?Q?iNeBci1ilR3aMjUUFgrOTJxE8rlHKXDfujg1svdo4QG0muUDb6HffFhfe74a?=
 =?us-ascii?Q?ZY2ALONkPwuV/EA8BgCWU89fXiTQJdfgoU+3Ps4YJYGosyZP3We1a3ba95hg?=
 =?us-ascii?Q?IeCvIX8XA5bJQxMZKplwmShE5Rhgv5vTtgI7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:28.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ab53b-742b-4a5e-9c66-08dde9241dc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802

With FDB nexthop groups, VXLAN FDB entries do not necessarily point to a
remote destination but rather to an FDB nexthop group. This means that
first_remote_{rcu,rtnl}() can return NULL and a few places in the driver
were not ready for that, resulting in NULL pointer dereferences.
Patches #1-#2 fix these NPDs.

Note that vxlan_fdb_find_uc() still dereferences the remote returned by
first_remote_rcu() without checking that it is not NULL, but this
function is only invoked by a single driver which vetoes the creation of
FDB nexthop groups. I will patch this in net-next to make the code less
fragile.

Patch #3 adds a selftests which exercises these code paths and tests
basic Tx functionality with FDB nexthop groups. I verified that the test
crashes the kernel without the first two patches.

Ido Schimmel (3):
  vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
  vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
  selftests: net: Add a selftest for VXLAN with FDB nexthop groups

 drivers/net/vxlan/vxlan_core.c               |  18 +-
 drivers/net/vxlan/vxlan_private.h            |   4 +-
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/test_vxlan_nh.sh | 223 +++++++++++++++++++
 4 files changed, 237 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_vxlan_nh.sh

-- 
2.51.0


