Return-Path: <netdev+bounces-118742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8269529BD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2339F281B8F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851415CD52;
	Thu, 15 Aug 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V92VzZfa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E93CF5E
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706301; cv=fail; b=DOUQFMblsyd1TcTTCgjWp974dTU3XTOtKnfnIj9t1ty9vMTAfqKfABI8BvVxeo4CzV/WMnoNi56ymqjADAuonCkps5mjENYAGVa+kWwzXoOssHHZN9jw47ic6SkjOFUG4eQBtR6d0DzWantl8Sde1ZuPPTgZ0hoEk5LjboaYogs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706301; c=relaxed/simple;
	bh=l0by+g2nQm7HXZEHs7JTngMMYYdOG8Ci+3dJqVlN9b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBZA/kuaQmB8lY4EZ62ZBuz+QDE76AQENhlCny8ThmRRQf4HlPppwzVwqijFb0zJ1kesLklVHjERGstNbt59q5M2c4NhGz+Lbpe1xbi57iwx86A98m5qqGFPCTK+80YsJtBB3CHX9ukdJHa08QBP5A/aIL1NYiMwuxyiiQUKwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V92VzZfa; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQVptFXdfDC0j5TrpHWcyYmxPqxGh8uU0VsLxiHSvZYoNoxSCM6vN9a8IRr4JGQUB+TfvPUT3juymU+lR/6Bxb4B3/BOxSwcYl1Gf8PqjL+zu1RaPli1Z3dfZnnrW0bHhf2YeCZRFW76Ca0uuotTuZXSRLEFmbXdj75wb2ZnX4UCI/W5ai2ypuv4bwe/m3rsYWmauNzlLpoLGMvCIjf4EN7DP4JnvdW9lfwdHtr7ew0H/WZFDJYVjh38QmRIsDnWVz7AgWx3hvEg/8Mk2wIhKQD52tdXEciqn9vHZymg9i9z7tmTRywU5wlzxbabBUXyj1bptMqpAyKA5jiY+PxdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HNByP97mer6G160re0+pOPWnzjldj7qX0xfColf9CA=;
 b=EXobU6smv0WF8xIssG0qqIGaxF3IhQkbEmOdLk7KmaDSsPmNoqAavQHBv9Em3njGnvfjHZeDFD+p+1/dGYQ/jeg2QrTCwUOGQI3zu7j0ALppBVsSLTl967/qyBuPi5lbWX64ZSUvK+UCa0HSIDP+agDVOUX5RnH2O5fRUFuoHWnj320U9OMag8+MwZXjUGxLMhtnV6b5mGYpaK3t9cih56woxA/0gmweVbMz3SimQ3c+Ho4bQ50/knh2G4v7v+/AofHk1IGLF1Xj8I7W9UCpfdL0dpj2uslqaGxSBiR9EyWoI+iydXKp+KQhk4XbJLqqoyULSxklnMLnCNqmYGBkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HNByP97mer6G160re0+pOPWnzjldj7qX0xfColf9CA=;
 b=V92VzZfaYK9xN3B+jqFVzCEfAGvna8g9IzCHouACSlw1P5UOYuXpL/pu0Oc0SeZDdodXDviHIA/9euyr1KvwtQzlpDoPAHzc3vQS2v4CU282X0CGxasAo9O2EQoTGt9Obf5S4eXPRrclgJvCxjWV4yAR3u2N/krFKiWWB1Jg+XM/znvgcSO5cS25fgXF1IvuW9Q06gy9GSugfbWgx46u24M5NTukdT8b12/vmmCrnyIlDttdBj+g4eg5vZkoKSGnisqZevHrGmjdYkMAj3gnVs7Dj2VBR+iAKYPm3xUxnRcR746C22Af09tSp8YU4BdBYOfJxK4ErPQFDQ0uhocWdg==
Received: from SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20) by
 CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Thu, 15 Aug 2024 07:18:16 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::f6) by SN6PR01CA0007.outlook.office365.com
 (2603:10b6:805:b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 07:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:18:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 00:18:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/4] mlx5 misc fixes 2024-08-15
Date: Thu, 15 Aug 2024 10:16:07 +0300
Message-ID: <20240815071611.2211873-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 722b00e2-8b64-4553-b776-08dcbcfa6e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2etLydI873myTIgGRK355kZF1KB/U/874Arfz+jcJi6LaVtMYZ2FGc4qwj4n?=
 =?us-ascii?Q?qdu1HtW/jWoeXCjFs70ImN8/UBFJnEXrWtJRFzGPREz/XZ7vuvohB7JOcDxY?=
 =?us-ascii?Q?J2P8CAs0GvDvGV3O7X+o/trzcwFvDs/g7Zua2YnKSv43qhN2FqVSmjpBPY5y?=
 =?us-ascii?Q?tXfY6zZLrrQuFqpRpAKzkvVqI7s4oU9WeN/5F8SXNabHmhW87iQMEmfRrGDd?=
 =?us-ascii?Q?D9HhTql0ZFdIsdzQa9qGrMSQAZKrscWOgO0PZCjK435+RnwQfFKQXNtIFUf7?=
 =?us-ascii?Q?A3ApOHKQjon/HzXFi9Jy5PKeAkyNNcJftYzYEdjDYPNkmEGvUzViJq2UeJKc?=
 =?us-ascii?Q?AMZjCQc7rjUeS6T5MBxLHNCQK5uqD+GdmhosCWaRpPHfebWw+ovtu1bLMHnu?=
 =?us-ascii?Q?o2tMjw7dFBhXPY9CqsGLne47Vcxh73Aa8D/oWk8qBVcNnoPRKfN0TolqDFjs?=
 =?us-ascii?Q?RteGtsCJjRvb0mAlKdFk2F/+nhl/ygSQLLIuTcQbzT8sNldpLzwxoZDe5vbB?=
 =?us-ascii?Q?P8+Nr5FXfmb4mFuZWmblGxzoJZ923C973UidFRbJXgpMur+UFa8QbrVKSNuY?=
 =?us-ascii?Q?VKQmccaivyxavsNlGBEyRrxEnE2BSiHlANPovdASvCfTKn0k6R9KHdu1xZqw?=
 =?us-ascii?Q?Obu2CARFplu3JkdoDk8lpY9jLVqC2DB4KbhgIubGDXPY2elJfUrkUEudadjD?=
 =?us-ascii?Q?oGVNcDtdKNhOg+NA+RbBk/BSetff+YoHt8p3rlTYkStDaSyVqOkGMC782oh+?=
 =?us-ascii?Q?RE8MB8jS5y/ltglig0Wpwso+DSsYMXjgTfZEyACwfE6YqZTE9Sor3E8Na0oH?=
 =?us-ascii?Q?7+RVH8ydji8xkMjpMMVzTSh1lSiKVtMSPPs+iZFSvVLiQGSmei/cpx2mwdB4?=
 =?us-ascii?Q?VTOz6wjV7XbhqJstPu3NOwXdmEojQ0Hh8EWJNSpDVnhfPTRj2NFOxJ4E5NSM?=
 =?us-ascii?Q?fPKkN5+Ew1SzOJ1UDuCsWOm2nbWPWsF+meoFtrhP2IEe8Ucq8JbGrZf53N+I?=
 =?us-ascii?Q?SzIVO01FqfFGhRTxgCsOzf5OXwofMsAIYfBCn9/hpHWSdSkfhPfYX1fSDrxb?=
 =?us-ascii?Q?S6PAuEgojMw8tVMxxVOfmDgf/A/HK/sUhtoUUxIqmfWs8rTLtayn9Lyrfjau?=
 =?us-ascii?Q?sk6E1C2+nowlXJAon46uBDVyD1MCWNyLG+dQdFL98ZqCjAUCqUADcRVh3UU1?=
 =?us-ascii?Q?i0y+7cM3eKj3M4HzAAMFVUGt0rckUJQp/VJEjxue/N2iA75HarIdqiA0Zmjg?=
 =?us-ascii?Q?Yhy1kTcryhzz91uRaEZOBKrRA57gdZce4P94k/q1CrsVGLccouuIp7EDQS6S?=
 =?us-ascii?Q?XG+BWWZPmX/ZU+RQ9C1h3Toz7tPzb3GLvjCFC1ZEozNZcLsG5q0EDc51H7dJ?=
 =?us-ascii?Q?JDpMXDAMvwW4wt0MFJhL1dliz4okPuN+pbKWvmhLOW72EtNUF6w/o27oPIUZ?=
 =?us-ascii?Q?Wcg9CerD89QY7XAeWpLEnFVzbUnc7fxM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:15.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b00e2-8b64-4553-b776-08dcbcfa6e5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

This patchset provides misc bug fixes from the team to the mlx5 driver.

Series generated against:
commit b2ca1661c7db ("Merge tag 'wireless-2024-08-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless")

Thanks,
Tariq.

Carolina Jubran (1):
  net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes

Dragos Tatulea (2):
  net/mlx5e: SHAMPO, Fix page leak
  net/mlx5e: SHAMPO, Release in progress headers

Patrisious Haddad (1):
  net/mlx5: Fix IPsec RoCE MPV trace call

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 21 +++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 26 ++++++++++++-------
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    |  6 +++--
 4 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.44.0


