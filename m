Return-Path: <netdev+bounces-114883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BEC9448C8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47AE281391
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080D16EBEC;
	Thu,  1 Aug 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SMTHSqPG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44BEEB3
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505860; cv=fail; b=AQOn8hTcDSh5mdzVcFBO29SkyCHkuuGAkl33FYCaSJi0GW/650sqrmqU7q6fP+cTYKOERylHA0UMn434JlTxOx7jt2Pdm59mjd/chvE7meU+XKUhqjY6Y3EXXHTk4Z3fu4b94EzhXlQLll8RNco04ZJU9xZh2k855fySfL5ODoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505860; c=relaxed/simple;
	bh=d+lnJ4We2NI3JI9P2MgiLJ3I77FT0fA4bI5SZ8o2Vj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+vGZFaVLvzYEz4qYp9FluRI+YprT9j0GwhQaUYIKK2h087mXGlYXfNOfn9CcjyDQKEmvUcK7IRvsVdGAIIAdJb9iJds2W+nZXI5miDiuAbBenRK5IHZU/lfhdO6XbP39XLOxEdoJZ0veszmSsfxddyt0Ait+795lT5catgzz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SMTHSqPG; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEBYt7+r5CisIrYPbekEYUZIN+Um7fTpDLXHfbndndMbjGUHBnUaDTkYxWtUZ3tPGmluI+6U5vPvEyNrE7ExT46U72fMmH/DsNOvgy1jjmjA9tXE+ejFJtwlN0drOwzM/skCfYQ/BEcXCvdydiyX5ClUXMFhTLfwT1dp7z729e6mq+4MglyLpzCCWftPoxfnhkbJ37UCJznZYC4RbyfJz0dTwB/fNNoTObm5Z7LKmQQhevcKUYSxE6c1cpGpKDxBOWrvR2hcYBuTzaGgP/LMrtOjBr3ZgSTgDgiDXwKhRe1LujTnnDQFlL7ufCF658KB030+sg/Bru5M1HeO+o4fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LQhPVm2LqYtBcE70sp6MDLY3CUauv/4Os67VwrZ3zI=;
 b=xPstJNaG1n1HOgpmGbAUn22Kqkv9fpxUjiFQA4QZDO7lizHJyL4AysjOqQkF767e14qTiBwC8Fx/Y1ZqsTrT9G7LcqhMTFUJiqyQ/CRH9WxgKDeD7MExY4lXHmVaar1pXPNjBDti0V0LBGpLJFiWcr32+ckivl5UO5s9fCnLS3g69hjyYpOorHv+i59Ve0U/XeIXCPqpy9MFG8lwPbcaAhHLoqGbx5iTrwRioiWtV5LGv1VC8l3rDKn58dHzYpJuuUryEju0fTMNhkLEtvAc5wBDlYMxVufTzxULi7NS+AuTB6swjpSmEte+SwsTeKU0CKuRgoNpZyTneLeVEwGCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LQhPVm2LqYtBcE70sp6MDLY3CUauv/4Os67VwrZ3zI=;
 b=SMTHSqPGiA9mJFZyk/KPrktL1/9LmzUSaYUSrLwSVr/mLY90GWaZY7WSO1NT0WbwsLDxtCCYjehL/u4MuS6bn/0IwWvZhHex87lcecSayMT1+FCt6ddOxRFN42cIaxBworbn2mahYTLT2eYe80L79MPv0XYyfaFbrMDEECgLXsDMdhU+SZ23bAaiVSO3EZ5zfEPBb/jVotebq4Cig6qUIhNs0hto/mzQD145/5PT+KeUjQqbVubnvMLhcGjOBkBdXzhrtzJqBzGzUtYv0AE6L+D+sVeAdm9o4ByY3TkYov5UXmqm/kg1AYdFE9rkmlKZRUwdIPXsQplq+YXXyQWeYw==
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 09:50:54 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::b5) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 09:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:50:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:50:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 02:50:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 02:50:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 0/3] Fixes for IPsec over bonding
Date: Thu, 1 Aug 2024 12:49:11 +0300
Message-ID: <20240801094914.1928768-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 762a99df-c536-4fbe-9c4f-08dcb20f6efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sKh0XpQPDcZPB1+fShE9rLyfuMSmY5nD7n6jRkLJZUnJOLazeex4SaoctKH?=
 =?us-ascii?Q?kRLlHPHuT4VTf33uAfR4K0XsIeOdrCH/T2zbFNuNK8l5Weq5gtN0nCaJ2M4Z?=
 =?us-ascii?Q?kgaD0wIcVQGUizsHAgtjrdUsxEATrc21bP+y8pI60BjG07w6BmqN9IB9FvJY?=
 =?us-ascii?Q?58vPzvU2Ae2WAz1XjWlsLDdT76pxDby1o1Y0PaZlZKAvEz7eUb1Qu8YTYomg?=
 =?us-ascii?Q?Rmu3IZQbLccnLvIlR4lUftNTwDw+txWtHZLvn3glCUeGd/z/AxqiO87KqFMs?=
 =?us-ascii?Q?SJJes/qXmNXULS3StQnbu1Vn9rvBDi2k4LrsLslGgMZVOAR/YiXeHArwj1pn?=
 =?us-ascii?Q?TvgrU1XkjKWsN9zOI6HX2bKbGCD3z3fac9cVQ6GPkE+G+B92Y8X6QYdQUM/W?=
 =?us-ascii?Q?b8CdI0KgHMH38lefYknNHC8pqVagM+Cm3C6MHvvriHXXb2me58x+QtXrCyxD?=
 =?us-ascii?Q?A/Sgw0gyH3v1qv9BW1Rha8bZ7tJlYVFwoS5wgGLNX3kkNTJV9ikWFzuk7wX+?=
 =?us-ascii?Q?phcIcZD7KZddi2rovkdOdniXJvG9Yjuv/7YPbw4EhPwNpBeqrrKChW0VLqKu?=
 =?us-ascii?Q?2VZ+AOQl1SmpDaMWr5z6qCIxG0JgCzO44QRdWUBOlxq1rJeGk+QY9ry1Ml/6?=
 =?us-ascii?Q?VQOgR9p546Bpw/BItavYngP02Pbmx+NKebkvrk1HJn6nIUSLstXF5zSYNOgU?=
 =?us-ascii?Q?jq0MbXmVAQiUcdp48g7VQuSnc5bE57iQ6saUTNszpSXfQf+tIwGOiclrv8Qn?=
 =?us-ascii?Q?vOlVmtSnLE0q6T1mXGwYI7d9IB1mmnhyH6Kz7o6w2+8W/pcKQTVCfC/90ZwM?=
 =?us-ascii?Q?GGbXrLkE37cHuV3oVIg4ZkYI8jZjwzY8zy3cxrL+T67GwzEPYvjPR4VTFT4Z?=
 =?us-ascii?Q?vjthOD3KH5Beeo70zjUKHVjuFiJgCbKqzRTlPoVFy8z8wq/XEfB7ED6XQDMZ?=
 =?us-ascii?Q?1Usg+So1qzTDVVfOQ+M6bJIx1cNPurq4ZQDB5CaqZEF6oxAwC+RuuuUYJCX+?=
 =?us-ascii?Q?xKiawMjwDINUUCGSRP00zch3/9vxU+EVsXr+bnuL0GgB0gJDi8GH/LGUwDQT?=
 =?us-ascii?Q?jSCBTG1eFo6t9+IiJ4ymBy2K/+ywVqgw+GtAbIgyrRlzQxnyzonaQHh1+04P?=
 =?us-ascii?Q?VoUtXAYOynsc1D8gjJfaDqfz/XzxmNKU1kcr8U1nRPNZPaovHuJMUHKbA72l?=
 =?us-ascii?Q?xfQnyxThpMozTPJRbBRLDnmF9DwtwFH1NS8LHY0NejjcxxduTsuECenCEGvN?=
 =?us-ascii?Q?MqZoEHxMO1hjQjOF5APoaKwCmbKpp0G/k38KTTU31A36cUW3AcJxexK3yP8W?=
 =?us-ascii?Q?hwxx4qKqHHru3nR+f266z1HaxnsALa2reR6TURbWOayjV62szJnu4qtkXTV8?=
 =?us-ascii?Q?pV2B3zYmK5vRPxJrwH/zc/oMBOH0Y80pRtMs5okRLWyT5Ez3Q5dgosVG/+nY?=
 =?us-ascii?Q?+aic4pd2wxgHs2qjDcOdHa4UUI0YNkXn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:50:53.4038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a99df-c536-4fbe-9c4f-08dcb20f6efc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

Hi,

This patchset by Jianbo provides bug fixes for IPsec over bonding
driver.

It adds the missing xdo_dev_state_free API, and fixes "scheduling while
atomic" by using mutex lock instead.

Series generated against:
commit b9e7fc0aeda7 ("igc: Fix double reset adapter triggered from a single taprio cmd")


Regards,
Tariq

V2:
- Rebased on top of latest net branch.
- Squashed patch #2 into #1 per Hangbin comment.
- Addressed Hangbin's comments.
- Patch #3 (was #4): Addressed comments by Paolo.

Jianbo Liu (3):
  bonding: implement xdo_dev_state_free and call it after deletion
  bonding: extract the use of real_device into local variable
  bonding: change ipsec_lock from spin lock to mutex

 drivers/net/bonding/bond_main.c | 151 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +-
 2 files changed, 95 insertions(+), 58 deletions(-)

-- 
2.44.0


