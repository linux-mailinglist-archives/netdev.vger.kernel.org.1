Return-Path: <netdev+bounces-104975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2A90F580
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13B11F2236D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF7156243;
	Wed, 19 Jun 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VqosBGrY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC71E87B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819562; cv=fail; b=XUF63uM5Ipjau+q8Wz2MI5lqPN60NBCqp2v8zivxXB/NYeLdsGiIuSW4P9fh8oJkiPparm/f0IfCamNjb21qCgx8xZE5VPk1CP1ZRswpEhOMki5k0f+P6UL81F11TsIV1yfIFJXT2oexZg/HFRNKggdZ27JfHyvGpZHMDfdLWts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819562; c=relaxed/simple;
	bh=vHbmZcai5VzYBu+vT0xgut8ABKhSpw0EdQCkIloukkc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mvC95oCwF7mDNs8Fj4/GYr7zQFHPrXlPFAp2UNk7MWoBUqC23tltw/CDqXro4Beg4Xh5gZg8iYqUfvqK1S3s2ZIeWwTbteyiNuQWxr0JWStp+Oms/ovU5YAskmwkFT4DOcG8qvr8lSMI1Vk1FG9ELshykQmHo1l/6fF6wA7C1Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VqosBGrY; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcOhZ4Vu4YFYx8tPsEEPDDGOEgMJLRdWPI0noUVSYqURVbTyFu+V0kRUvLpOCt2WORP6C3CodZDXzoO+S/RqJrRZQKx+qBfP9lTFIYxG7LZPDezNk7q7eS6mwpgVyWApp2UQS3PIR1kM0Ob860ZLuUJs7Ghb7rVWuhHAN60QcBUPkQveIbmaEOIm4mpHZuDs0NuMH6qUW4YRrmmOsXAb/Kr3C4ebSGxwSAYPFtQdy+yAj/i55/G05dW8EOoWNhQ37qEYVIceUBqrFZjGH4ngf6zkoDgYcQo8o8CB/l/yT4clOzCjjnJ2iB/ZV/29SS2JkstISQ9L3qPfHX46Zn8fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHbmZcai5VzYBu+vT0xgut8ABKhSpw0EdQCkIloukkc=;
 b=oWf/aKaSMrdERVnFmOlUPPJ2ODV0w3n4QhEN//6r0lqm07LgbePmSWgbIX6ucKZIxL8LtDJ6OjAx2z+wNK/qP50JivMG8dh90Y9EogXJXJcuz5QnGjG7wQN0ulxuRbCWPh9VqnoSaZ9JhYgudR0W/Pl4XB3iT/xipk7KzlR7YDCYqyPUItYTv4l2yv+2S0ImvamVOQGMdE5/0JY+Wdg6U6y8SBbazXc1nZmxrPOxLqFM+WRuuemonody9cKqp76Pixe6JhTRXi0TVHTScAJJGhUljSSUZTx5VjLpurtCkuOT/FUJacMk0SJYFzQWQ6qRDKu/mwXNOUICt9JdnoHiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHbmZcai5VzYBu+vT0xgut8ABKhSpw0EdQCkIloukkc=;
 b=VqosBGrYQIvf9pPP3Zb6TbP3BlRrDryK898QD5XDn1ALZjxIUn2nXfT4n1bO5kj3b69i4rGg6wN8fUmnQUZLdnUPiNI0DwvcJVHlvR4AA4gdC/sEjWYQ4REFYvU3AGPUbwlstOVMLBE6EWOq6MbA5TO8Zc7B1NjTwk2BOBKkfzaLyz/OQn7SURI98KMzg/5OcZ/YVRco/wdndQqcLfZ1IUCH8abB2YqMTli0HK1PYWgToHu++KKAG9UNKocjamly7xo0gNVoHAmon4Z8ip6T0C+kyCh734NZQU9zvqGv+TTOz4uGiF8XP9elbRmhkMJIFjMqSRJapoXbU4JmQDGYCA==
Received: from BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) by
 MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Wed, 19 Jun 2024 17:52:35 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::c8) by BYAPR01CA0068.outlook.office365.com
 (2603:10b6:a03:94::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 17:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 17:52:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:52:20 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:52:17 -0700
References: <cover.1718818316.git.petrm@nvidia.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/2] mlxsw: Fixes
Date: Wed, 19 Jun 2024 19:51:18 +0200
In-Reply-To: <cover.1718818316.git.petrm@nvidia.com>
Message-ID: <87wmmkbz20.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb3e269-f53c-4e9d-2d9c-08dc908899ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yua9KSK4+Tk59yCRMNr5joMYX63iS0o80M9+quHEGae6T8rfv27GrkF9S0Yi?=
 =?us-ascii?Q?79bpu2VC1ltXxOJ0R0Eqq6G/KpSqmKwAtRYNkFp/imBF14O7E9MWiQnuS7oK?=
 =?us-ascii?Q?G78J78r5edkGfelG0hZbX/8EqpcmnepdHsTHlfVZIUkEcfHW71wV8vMpTCNG?=
 =?us-ascii?Q?4gKx7tNcQVDY6s009q4G2WS/c7pBMeihHVhR5kHyON5YbKDJTvtK0NzwWvU4?=
 =?us-ascii?Q?YUSxz+ohr5L1iryh6iQoJ6r6TombF8ee9Gpz5yihLlaNzv9xrIQoCzDAdPfd?=
 =?us-ascii?Q?wCTFZ/5SzmeG05ndhHqL4l0pjiWXgUrqhun2iERr3XHomi96UvVEfCOaJMtO?=
 =?us-ascii?Q?g+GpgGV71YIrTsmIT0jyOEf3NU1ojLBb+MDZEKc9mBwBzatS+SOS7TjZ1sXU?=
 =?us-ascii?Q?rM12t9W64LueNK6JT5KBwFBWq9TEQ/cuqvCSXHKh7sX9SPKkls7CbccgApc4?=
 =?us-ascii?Q?5qeScCOEwjm2y4yrMuULeIOgngUBCtSDs3vOI0761VRUTgioNmgZuXdoMT7N?=
 =?us-ascii?Q?WsQR4oYcEcmb+/+df8K8b80epzoaYoswUw7dtr1IV0sZimx6ThGSoOmoj8Yk?=
 =?us-ascii?Q?yBnyFsvbZD9XA87fZGZh8jFyeykOy6C+9kRucX/gEL33J2Ob+al49sTFU1Pp?=
 =?us-ascii?Q?z5zkKM79yJ9exMPOxmPL9qPSlWNesQ+aHxzjbmkQSLUmDMQMkYuJXSeTKJx/?=
 =?us-ascii?Q?CnewN/DqdND/usR+q6orEqnsFQWY8nf2R4YHCsxNgmkTNde85tuHNdJPnyBY?=
 =?us-ascii?Q?fcvBbO4Mpoz2FEms+Xp3lePnNpwBbRaMH5z3BM4o2h9ZGs+YCjmFWI/n/UXG?=
 =?us-ascii?Q?XBwQsZ/Zygg8rV4vghoGd4sA9riFdAPKIDstOGYskJLeLXbD2IVUFTM8b0UH?=
 =?us-ascii?Q?qiQ6+zZS3MgikNe4+PlhnQ7fUAqNtCsmPewSya3zVR/z1AuaL1KXNNqC4Efe?=
 =?us-ascii?Q?EjW62dkdy2jcQWDtqxsBwAJ2FS3R360ChsvqOShMI7cmaqe1KTRcqRibQ4he?=
 =?us-ascii?Q?NBdLapt0P1fD7DlCfmh6obZVAtGk0Em8Dh6Uxy0CEuQdyfW1++pgh+KvUHrf?=
 =?us-ascii?Q?QIFP2lNCiBm7Te5V9XPT8XBWxHlknLbZoWDPPuPlt19HyVmdjrIyHnuqKLSF?=
 =?us-ascii?Q?YYq9aswuibXsTQhO0g6vdPrliYKJFMgHuO500XhycyeoKNq2ylKL7l48fKab?=
 =?us-ascii?Q?7BQI5ly8DM1jn6QyPjQcGwE1MIcusQ2aGqutvRmHs7+NYdGxmMfiJ8QSICLT?=
 =?us-ascii?Q?TT2njd4MOYu5fwyEO+Wltr6WWaeBGL2fxjQv8wfBQsj11pWmGWC2CRuJuvBY?=
 =?us-ascii?Q?NiP9s464nVaPmRPcnBSk+fOHx3+vZ7fuY8naxuVp7+pUISEncEaVFFyR5xkE?=
 =?us-ascii?Q?gkFTfBXg7/grGKpssKIT3nD3iiZayfMovrwHxMrFh+dAc/kWSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:52:34.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb3e269-f53c-4e9d-2d9c-08dc908899ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

Sorry, this should have been aimed at net, but this one e-mail slipped
through. I'll send v3 tomorrow.

