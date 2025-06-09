Return-Path: <netdev+bounces-195722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F8AD2134
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7B3188C868
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7125DD15;
	Mon,  9 Jun 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPM8KblL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AD25A351
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480206; cv=fail; b=CapNvly9JGzGEswmcfgLeVz8EsLh/ALnLlMuRGOtRAx7BJwNkSBO3fkWkuRKzNim7wiIWoKaEXGTsCXoI1sJ3YceaH9ZRQ43H45FJX0pinaeVq3yJ2G4Ht4wnki37BBi3OfNkU7coswKiqGPYnL4NbpWg+Y4tdL+xZBjo+85ffE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480206; c=relaxed/simple;
	bh=/WrOWOh5qpuvseaQKA/RtOZ0okeZCEhTr/o3GGJ7dds=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=D690j3QrS5DPGJ18EXZeUHqju0FhlPcu3FXJqXjfzS0UdL4LVxGJOOw7MrL8DEAP6y0cP7Z950xt11TI6CqHr1TiJczP3cM7JPGu4I6rwK4bhO15P7ddLoNkoxd1yqDTjaGam2oxE1y4+aHK03vi8v8lfqlC5u+0a1+hkzTU1kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPM8KblL; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBldyOGrnVsOH+QlLrP2N77jWnsrmw3C4yKIbjA5gbN+Q9TWCnvpPEuN0+8Y88Thz9IKtZf/BlKoZuMgT/AQF2oAllDNL3vcIfjV0QtDEsCi4RENk/p4WwXReEOr4AdTWueZxMefmJKLqkgnZ1W1NBFrbw6oB6cm99u9rPXmkFjp176n+kOqZbkTDwjgzcY92AE3Mj6cRYuDuw6Li7jE6YtYc61yO59ow4qJdgOZMIJaYHi0/6PRwrYtuS3VueZFf5+AkJBuUSKDRKxvQ3nvDRev4dXmsDhhJjYwdkLElDrO+O0qXDRcwDomnFLjy4N8hb4JL8PqQbvvj/tlvK7BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzaBjVKEp6bDFA0T5ZB/hzSqBiMczOl3P7f+l7K0DDU=;
 b=QCwVu4w1KENVx4am6V1Mhvi/A33zda16L5PxZAnf6Aa6bUJzQvmxj9DzHLuDWz7O8/lqEPJO7ZLn+mfP3T8E3n4A5O0G/7TIoHJ/tM/MZC9Lms/6Jq0s9kZgSj59q2PWbFdXHvkSJUqYXYO9Jd/ahVW7MWx9lUC51ikmDp8v1ufg7xRuZN5qhGaPnyRk3QaW74n1tQM55cKZLJ1pmYzgs1oz/mE4G0sY3k0syGxPbrIeIo84jqi8YqzfcTEl5Zkrqxj8dssCiU3nEIfxt6hP9+h6Qvm0U5+yMWmu4bJxmLT/tFEihj/FZCLxHP+gjOY2f386g8iMvvZqdejjx7cMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzaBjVKEp6bDFA0T5ZB/hzSqBiMczOl3P7f+l7K0DDU=;
 b=oPM8KblLWqUBi/G4iJle5aMGRUIeBD3n85zNuGpEReNUXiTqUVTK0x+kZcuAc2fhOZG70kH2mGLjLtf3GmjHJWdBlnrQzuDLs/n6Ued6jph0pPXkEzSuTymksyDLgCYzH8Dehuko2d2PD+68/c7IH1gyqkLRmXe2tCDY6LyXS3ofrWXklZxz7pAhVmRhLj8o/Tr57ZR5dXV6PFNxby3DKnRKsd5XXgHI84hFLIJAe5i+9Tr/qu+ieokqlUPsGpP8+rJexk8Rayi0H+IZmNcNdNwvjOyHqB+fMPgNmj+rMXeiy2zEIT7dR7g5WO/JZIizOLkynrOYtMldfbYfQHEsjA==
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 14:43:19 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::1a) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 9 Jun 2025 14:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:43:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:43:04 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:43:00 -0700
References: <cover.1749220201.git.petrm@nvidia.com>
 <5cc3cf81133b2f1484fbdadd29dc3678913ce419.1749220201.git.petrm@nvidia.com>
 <aEWdqycUQBuevEtZ@shredder>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 3/4] lib: bridge: Add a module for
 bridge-related helpers
Date: Mon, 9 Jun 2025 16:42:53 +0200
In-Reply-To: <aEWdqycUQBuevEtZ@shredder>
Message-ID: <871prtf028.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e1ef74-170b-4069-1082-08dda763fa1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ui4E0xD+Q4k7bmQOrpNCFbPO1/R1MiRgB/v7uKywcUHX+1PgLHEAlS5SHDbu?=
 =?us-ascii?Q?yrSyJNjImFOSWTvPSgVBoXKFgZCb/iUkkyAOjTHWipesnPpFoRMIw+6f03rI?=
 =?us-ascii?Q?R56d9t22PLnMI46Nlt9Bg2psd6jX3MafrA9g6Yvg7AY9ct9zsitJiPK7GVzd?=
 =?us-ascii?Q?dK4B6+9f7V42E6hmSlxJHixEM10dfVhMcy413N3QsGGRX9V0WOEzdxfAYuXf?=
 =?us-ascii?Q?tfm3mG9BM43ec7pxQsugDzSWfSq2XvSK16uKEtq9Vk1eWNqz6VgbgM0bQ4+u?=
 =?us-ascii?Q?W88lHvdzPm3awdgzClwaKFcLllxmEdSHa7Kq3u2iyatDSL7n0qEQKsGZHnvB?=
 =?us-ascii?Q?aBnNmGhpThpDyY/dpaZtWlDESWhGtx65+KhahKJl7tUaA9CIC1iCVR278bw+?=
 =?us-ascii?Q?jb57bJeD7aHW4LC/iXNjPaSfkRgHGyPexmlx5VgfUkVLyJ9vSCDEGsmAHzOd?=
 =?us-ascii?Q?NoKHtvM12qomjRGdg+qyWhHyiDgiTyl0oSSbmK0a1mON3EzOI9MPgQOqcT0S?=
 =?us-ascii?Q?xwxTuOQaqs4isSbz4qNTkpbNaCHiI1DoPakQYrRPAbGM0MXVeFZrm6qEJKSY?=
 =?us-ascii?Q?c4AhCBUdi518ymLN5jKGsy+2UsmPzw/YH64YbZJYgtQ6yFsKc0gP/hFG2LH/?=
 =?us-ascii?Q?Q0JFFoPXmhBRn0EtqgCepluofsI4F6/P5b91vuG6J47+YuICWqk5kh5h1heu?=
 =?us-ascii?Q?d+iSRBR+5OPoress10kqJgIEjl5yn9Q0eX9pGIXRaIpcWyZQhIgNn0Jm0QKG?=
 =?us-ascii?Q?ZUBazooWW9j4uAx6PUQ2+G947aCLnxP/vfignnWu8T/veRw/HUqGSNuzyv1G?=
 =?us-ascii?Q?3jN5kMprc3DhkhAr4LEiM7IFPNQeTAB9mo+OB2wuEVHh1c5dDv4hp2L0PhF2?=
 =?us-ascii?Q?9MSqmuqYLF/27sHn9SjjsToGhf5Jl9GtbXhUaWA+EV/L/rbRv29ziPEKFuCW?=
 =?us-ascii?Q?Qfdhk2/462fRY6upqae/pgpTHOmPiFWgg+qt99jkVTisuUlGgwhFvACg9SBy?=
 =?us-ascii?Q?Mt9OE6Ywpd5iejHc4NXTm1gLh0YmmhxBhzNRtYpbg/gvcuR5Ubif84z3OwXv?=
 =?us-ascii?Q?eaUODABUDWyQyu9le+30c/HY8m4RQq2N1B9uwbz4IPg8Yrcw97ahUxJbZZdp?=
 =?us-ascii?Q?Rp5oBvoBqWpwvzFG4fNXOrEvD/EIUL0v2ZwWGq/kX+9Rb+AyLTXK8EhE/T6t?=
 =?us-ascii?Q?d2xIC2jeLjvFyR/l/8djWxlv2W21mQTurwZ989VuX0ko0vXkOYa0w4aZj0Km?=
 =?us-ascii?Q?SvR4vMXmzFrlyRh9WqyiWrABR6Jcgm54RJB4OVnVdwVJylPVEqC65zxPfEeG?=
 =?us-ascii?Q?L206W3cL1Trk/+vpNmXqYbhrl0GieWTzOGQyA99DL3Hk5s9dmMEcBym3jTLB?=
 =?us-ascii?Q?39XJl8NEJIprvrAaBQBA1gAni1yt+4OLT4mhq+EbcTkOTzNZ334L2cfFv+5q?=
 =?us-ascii?Q?xFBlUCLcfoRY9M343psCi1swapGg2WMY4hzlVa3sU8/eGTMJxx758GNhp+TQ?=
 =?us-ascii?Q?ykhve7xsqspf3+W7LxKMIEyoRY7Li8Se5hgc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:43:19.4797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e1ef74-170b-4069-1082-08dda763fa1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918


Ido Schimmel <idosch@nvidia.com> writes:

> On Fri, Jun 06, 2025 at 05:04:52PM +0200, Petr Machata wrote:
>> `ip stats' displays a range of bridge_slave-related statistics, but not
>> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
>> code to libutil so that it can be reused between the bridge and ip stats
>> tools.
>> 
>> Rename them reasonably so as not to litter the global namespace.
>> 
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  bridge/vlan.c    | 50 +++++-------------------------------------------
>>  include/bridge.h | 11 +++++++++++
>>  lib/Makefile     |  3 ++-
>>  lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 65 insertions(+), 46 deletions(-)
>>  create mode 100644 include/bridge.h
>>  create mode 100644 lib/bridge.c
>
> Add file entry to MAINTAINERS?

OK

