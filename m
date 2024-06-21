Return-Path: <netdev+bounces-105563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52FB911CAE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C991C215D6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB312D74E;
	Fri, 21 Jun 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8cUOmTZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45693C2F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954488; cv=fail; b=CiYSJkdbMJeI2RHCrb+/n2whasab2B/egAYlH+6Lr6kEroqGnt6Q7biP96SBSdKV8McODWcljMpUJyGKZHtcozfywDlCDR5XqTjyaJeEDdCyV3Cn6Y7TxjYqDZDbGHtX6bQwr/TCJwNk8C79WdyqNeoxSJCQJdvm22Zpj16Ytnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954488; c=relaxed/simple;
	bh=cTxhkH+66cbuV1ZMYRRVwiVi8e1GW/TCll2lRcfsGYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kl8phnSawduRmtIYOR3oBvnEbZWfH7+23F7dv/4YN+AYiYEWCM8jpTydAhfBe7O3qGM44GGIx3rToPDL+DjoiUsrs739e+OSyKHj0KdhvywyRyTcHjTpUYL0BFQxvr0eTL4u2ijy3UnweBqMeTufB9B4n4ISuclnr4sd+ewoHBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8cUOmTZ; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghKwmrbwhXfQGjN1984k8tHaQtYf3ULzqUcG445rIaQ6XvbX/pyJWqHcRzGaEBWW58yfEP9I2tYpQC7Nxn6IffajsyLUKjKtHmDziWpIrcW3Xf7qB6B8sk6Nk0bm+nZlL5NYh12Sy40QQm8pk2Pc4+LQkPolJnUNS5+eRVLARubTjKmwej5VOl1gMrYjnJSlNT7MWHBMTkMt1lbNmY0d/xoKwyCEZ40NCmV6WvX1y2YRr5zMi9KkaKJma4LxtCaHjCke8LfDuH7FDSBgsji5r+LfLiWCruLE6jCXh3zCTW061eEfKCjZK//Mb5RBZJF63LOiM3BLBoqpL9h58m1PPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npPYuHTJ8iSm2H9w3FSUrVaAcSSYWyEIyQbBr3EqH90=;
 b=UhXbjvdnw49BcCHV0p2L+gjqulZNKdILx87GuHroeNZa2o3Ff1NSkp4QLUQm0tpRwjIgepaNbJzrXAcGOVi077IBYDIbhS+vY2KkuzXw1W1YOo9S4seM69SnDHy9f/VbPTc8z2T2YuK5/YgSduca3PJemdJW0+BVQggwwSpCtGI6mfJu6I7dGoc8Qv61/EQE6tXyJDvcZp5L/43OYoNXfEEX0H5IwLYO0tdfjRtyShnqhqYmKvCkm51U4R10ykZ/F6VFt3+GeP+RLUqKU83K7J9RfaBFvO4FGhWE3wY+zF6R1Y5S5u4LNEKcnsUByM1YpdKA/gdvUs0jaTA4buKr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npPYuHTJ8iSm2H9w3FSUrVaAcSSYWyEIyQbBr3EqH90=;
 b=L8cUOmTZv+RiDhsjT3rQ7eVtYTLt5pdo7T3H5uGFqldDQlnSjF+ms4FU4YpfGdLTbCAhvuO3cBwUemehrR9CaqRGxaQvnw/EdfULOSqjkPHMmjQfpePT4GO22gZinf5E2zAXgebP9DX2HZuBaMQH9VLsgsdIKysO5Inj1V22AsVS4+5fGovAIBGJpOKzSijaO7dasNBlo13kgWNrrFvq3hhbjuwh+KdNvI12xaUmj9NIAJlTkr47pP5aa75vP1xqEIh8tlzIlqhzXmHfSVpb26G14HTzBAo91pFxSTQYVebsn0uciutMBxJqd5VGIZvQgr/ToaOCegSRYBoxA/MYrQ==
Received: from CH2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:20::28)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.35; Fri, 21 Jun
 2024 07:21:24 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:20:cafe::27) by CH2PR07CA0015.outlook.office365.com
 (2603:10b6:610:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 07:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.0 via Frontend Transport; Fri, 21 Jun 2024 07:21:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:15 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net v3 0/2] mlxsw: Fixes
Date: Fri, 21 Jun 2024 09:19:12 +0200
Message-ID: <cover.1718954012.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b10d413-4e45-42ea-6b86-08dc91c2c1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QN3CPhhUTGyY7/hqiL3e5tgBg5bkNt9wYp56d6HopQRU/ePlB7R7KsYp0Jls?=
 =?us-ascii?Q?6JzfQJPsBvvmOQ6NU3E0vDSY5au3m8WOkIkHdbH7wjheAjGw5QEaZ7jYDXjQ?=
 =?us-ascii?Q?wXvu7vPpavrVhyog8vDgxxR56n4BoOJAUTu0BqGrceDJYPuF6QnqrzRBVkSS?=
 =?us-ascii?Q?7y0/xGpECGrCoJA1Mt9qnmcZuyWEQxhR0jtRR8iHAYPLK/lJPSVg2QYgRce6?=
 =?us-ascii?Q?NhnC1uwqKfL3YdMuEVxAYJZZ8aL2YwoMI86jGiKn/AyX/gBDxqC5IriqhzRV?=
 =?us-ascii?Q?651mfIHfPmsFtm+S3bdcB4Ri4OPr9INZILS44VjO/PW0wjmLZ/TbonGJbBmG?=
 =?us-ascii?Q?12RNd6twyJNdWUt39BRlOLmUkFl683SgiKqs2dlDImLK2H6rROnhyOtFyfiS?=
 =?us-ascii?Q?Ax+v5xEHD9qncu0n2+sro32lpZNV5yjHzk4S4vAQpvFDruXtOKySLGzl6i1A?=
 =?us-ascii?Q?zQzUNIUBO1NJe53xE90NgKmRarQYmkIgxq0HXQyIZd4yJ5LV8g8CgAMRulSX?=
 =?us-ascii?Q?jxoDdYqfzn4gIwFR+qvv7ZvzJzDdaoeFeQTpbamGSG26WMhiD5HsVfroW+z+?=
 =?us-ascii?Q?cSNWcsoI6MMj+7HgsAWe9sSewM6QCI1Tth34AIHgW+33Cbt+tjhGJhamFjn4?=
 =?us-ascii?Q?Oo9rXM7MfVGDzbc729HNpuhIvnspSfLGfd7LjtydXJL7xRCfEmO/hAv8ZzUt?=
 =?us-ascii?Q?Pla9oRawABZ5eESrSOkKLwceuG2MYm+E8bDOH2ObWF3JNB+io1P8KE66jcKS?=
 =?us-ascii?Q?dyLHGlP9aUQCyzvveKXUGQdte2cLkKyJsgdLKcXpFI7MI08iYpQR/EB1456B?=
 =?us-ascii?Q?wLd0uTodTB2o7UNp5x7J3ClcGTKIOkAYG20C/3y/LBA6Y3PVeDa7BGu8TLbx?=
 =?us-ascii?Q?UfKib7rvqcF3jfQSmpQEMqyiWDW0EHF9PTNGL9QbYdpEYPeuBcecN8XJqlXB?=
 =?us-ascii?Q?jab15aoBB93LW43cqWXc/PDOmG8AG9S9w2I2i94Jra1AtwuKBt3XCY8oEpNX?=
 =?us-ascii?Q?OYmSn7X3W/W8CWQjQfJLplhm/sB4SB7u0XT4P9Q7W+zCXk8GSUaJPBqNSY3U?=
 =?us-ascii?Q?ZTTZQqVJnqODRIwhwP6XGuX/lPYwdduXs19Afpy9Nt4e2C8mNJHGIBPlRAIv?=
 =?us-ascii?Q?94AUyGYRuJUSmcGvLDAPIkA15UaIudzttPrOr5b0E66W1hajAafWO3gqclZz?=
 =?us-ascii?Q?d3SWAmqATNCq8Xlfx6JAm4J89sEs8smCRQs+N+PK95pmqxSnt4MH9pOw4W7J?=
 =?us-ascii?Q?Crfqy0SO5rqHLKQKaBWJxgbVoEOufrX5qIzt9Kt1NI6A+pBaSoIrfmkQhDBP?=
 =?us-ascii?Q?g6GrZYtYhuPNZarZZV0lWV9nF2FB/x5/QprbaHyl3MM1T4wJCSTm1cnPvb2o?=
 =?us-ascii?Q?5NR+wtxF1V6hzDqzs4lJjPaiG7Fuql98JEwJG2chsLw3mYvTqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:21:23.7437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b10d413-4e45-42ea-6b86-08dc91c2c1ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

This patchset fixes an issue with mlxsw driver initialization, and a
memory corruption issue in shared buffer occupancy handling.

v3:
- Drop the core thermal fix, it's not relevant anymore.

Ido Schimmel (2):
  mlxsw: pci: Fix driver initialization with Spectrum-4
  mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 18 ++++++++++++++---
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  2 ++
 .../mellanox/mlxsw/spectrum_buffers.c         | 20 +++++++++++++------
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.45.0


