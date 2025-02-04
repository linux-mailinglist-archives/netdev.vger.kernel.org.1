Return-Path: <netdev+bounces-162445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A91A26ED6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD81610E8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64928207E0E;
	Tue,  4 Feb 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqrNJnBy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F05CDF1;
	Tue,  4 Feb 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662829; cv=fail; b=ECN9m3ZD6GQr8nPhqOgr4sFM8uGfRIXyNc8Q+epkEypJaWJcT7JJVDwEi4OdUA7H///joeOhqVDOd69sQqQzDjl1aNKU0Y2G7xOF7QIXt5zQfpKWpHpTlTYm1BC9RocD42w+Z9bGBYHX7Wq2h/8ploksCsdmE1pLw31B99bt7s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662829; c=relaxed/simple;
	bh=LodRo63jXh8AZDwk9rkfrZVfhruhE6u3h5egEDV8DOo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JdRS9i8DggTQR+FB0hicVR4fWTQZbdADcw2vMqATM3k8elZEBeoAbjghjyVTVl1iPlVGbHVyd5LuZN7zpqmNU5GfjfSJ3sH6GwKkRSz03KiubJTmWVsv0A9oiTyc7l8Fboyx4dSiBz8rMcLlSf9voHx+hOaX2ygxv8MTnOY6gCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sqrNJnBy; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWdklj37wh+FvvZ1pF0thvG3Y3p+2qjU9jkNmYqoK4qxZ9IIzlBk82Sa1V84q6OSXLI1BLweqGRwGNmZDGBW2bklfOGLbpFVCBqx1G811zqRj/f+IE1H0kcMyOb8hkkqvMDKiQ/TALUu1/yl41ekgEhVct4ZLGoUtCOEcFoKTQphDL430QG+KjOkLUEqQOJLMx+ZYZHwgxf6uqT6p2VfELhbtOWouLQpUYXPgrQPgODI91m36sVWCBUGdOc/AgGfOZ24BOY7wzoN7U1B/tI38HhY6jFwqjn6YQVN+qx6A1Oa6DbuwCjrFPACWWU0jWvpJdCDY79nU0/S2wSuboTX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LodRo63jXh8AZDwk9rkfrZVfhruhE6u3h5egEDV8DOo=;
 b=tKywBPC1hUrBvR751BSk6QYoC0w3ou/bpLI2+7CCWugMpPKz9JOlqTaZq5X7nKWObEQmhaZ5GC1/bHRWnQvgEm88Dt4XifzqjvOJyx6NhMkHG22GwSGujiZqjP8LInjJYhJXQwlKQdPJ4jlOTgsDq+4k1FquVjSE7qo242dfI1WOvmeWqanG25X7ag2O/iCUpBwqCJd5f5tXJnG6XAWbKKrV697kqLusBd0fHtEimlVXI7TBcynggCXS4Vrf5k2jDItps/HP6B2X/2IDX5NS2AtQK9LiAhS/7/8v/w4vQHkbaZLbHuSTvKaJXJzxt6Ud9uysagtPe2pArWSGPr8u/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LodRo63jXh8AZDwk9rkfrZVfhruhE6u3h5egEDV8DOo=;
 b=sqrNJnByZTLCttZwh1Q7dWqim5AJpx0LUDo2v7RRUROg/+oQgK88LMrbnqzMKuuhZNi3PLW92KjVoikYa4ISlSj0Hsx2I9Wr7WidTrDyGB1t0Evn/pmwVTRntd9kB1sGF/3u5Fe3ZTDYcN1X+x49oQ4+2WwPlK3AHDGOwy/MjTcvfgC5OB2G6gjzkG+fNrFmCXPilQVexEEc2LjQExrTOpRoL3hbnCefRUGKqlJ75Q4qDmo7o9Y1uBnNCFX8a2kcm7S4T2ulln52764tETBhKHuJjGX0SI3bNGE+Rw78t3M3TfPNmXgDoLo3adMgPz5qjIKlqaRHIpaA1Pz1+pK1lg==
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 09:53:45 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::3c) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 09:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 09:53:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 01:53:29 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 01:53:23 -0800
References: <20250203190141.204951-1-linux@treblig.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: <linux@treblig.org>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: Remove unused functions
Date: Tue, 4 Feb 2025 10:52:57 +0100
In-Reply-To: <20250203190141.204951-1-linux@treblig.org>
Message-ID: <87a5b2nii9.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d3480c-6da2-4f94-cec2-08dd4501d02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTZA0mOobkhUD0BV/fLUcwaUhZz+ry2sV6nnWGXm7iCmBVZX3ElYI3/X0uVM?=
 =?us-ascii?Q?9gNia6lWEKFOOXjL8KLWDBaOIbJvgSNBPM8Yj8ylw2U5MFo+HGGyMcGAhJz0?=
 =?us-ascii?Q?Isa5hm+e5pBWEycwbzzpmMyv6b56Dnx45q+tRngvpiChc49bj+TMInjnVrxz?=
 =?us-ascii?Q?1CGBtHrlYxhnoAZL4E8kx2yWzuDyLwvIWOV4/dRuNhpCSUNWh5kItiotH6oN?=
 =?us-ascii?Q?JWlLNDvLXEW9Q3J314/sLBVfJftZOUPl8r3e6FthV7NxPWwBCx79BVOCmw5k?=
 =?us-ascii?Q?Fncog2Wg/axFCNwTedPJkd3ySWxzAlJJWott6kc9S9aBVRCwLBql1VfJRN0y?=
 =?us-ascii?Q?97DNppHahl+xcoTPwY94iU/gmmBQTCURyyohg/LQvxjbQsvrqqS1f8jFiDXo?=
 =?us-ascii?Q?Zi0oBG2vBI8sbywL3OIW+IeMJSYjItcgN6HDryfzaTzxs5w4vYupfqlXn3RW?=
 =?us-ascii?Q?nqskTuAlx5/nFIDCi4Kdyo+QT2h/qTjk8tjNxX6j4YuXHcNIW6oRvWQUAyU7?=
 =?us-ascii?Q?Ib0d9cskwQUHOjM+833TcO/A9hHaacOSwszg/GoOMTMixRBfYPh3GrwSqbQm?=
 =?us-ascii?Q?ApAYE4y/xuzzcqw9QG9/T3dRoyyeCdjZMlDXCHZxzi7QTpXEccihu/e1nQm4?=
 =?us-ascii?Q?YLsexf8MGHWz76tq8HK6E4AiFvYJOEsF4mJH3VdBcBgVIm0WC9NddnMvo9LI?=
 =?us-ascii?Q?1BEM8wMckENp+L1Ky2nzn3j+NmhSkBZgJGMQG6qAnMajxm4As30KekYWzK3E?=
 =?us-ascii?Q?l1kgzdLwC6jVSCNZw6TFsCtv9qsPP/rKJhRL7D/EUdtWMzQ6ClZIUG+Haw/p?=
 =?us-ascii?Q?t0py816/S/1DVR19GYIWeTKbXCpYyLuXEhfLsDd+MEZCF0Zu74H0bl6J4U0F?=
 =?us-ascii?Q?qf0/+dk1HUPxPWUVZODSzFa9dO0QC0Zj4B1mIlCU6isLkGmEaaD8HPZClayZ?=
 =?us-ascii?Q?v1tH/MEafPZyJfIEfHBoNgmw5quLEVTK07OYSaNG/qsQKnUggJGbeH1c4znq?=
 =?us-ascii?Q?BWX5EYmHgVZqPYa+FWsWvUwDeQ/dqHlKEx9cXVIH83PkCqdCnYOJC/TOIx4C?=
 =?us-ascii?Q?PvoywRlegB0VHiPs3zjO2lw4SvyqMCXmYwSnVPUgdNGd6k0fkwFr2GIp4SmE?=
 =?us-ascii?Q?Tfw/aUY0utQOGXdNo6jUEAz567kNj0CQbKTZe4kSc3ukg/RIAayqJus7OG0n?=
 =?us-ascii?Q?j11VDRAjyaaB49RAgQDDwD+vvpspf/xERlGjoK7kE3bPbfoZQ8y+lZprYHt1?=
 =?us-ascii?Q?RmwFuya6/68pifaWclbThRc2I2wnGl5Dx0bpSB7LaNQYVDGq4xB7LtnY445q?=
 =?us-ascii?Q?TcPbe7UFPjqALfiDod5avNrSGtiwKpIMSt9RIVOSGzizQ4uZ9hXbeiuIfc1J?=
 =?us-ascii?Q?Pw+utRtd//MidjVmlPRno4xvSWjtM96xXkz4FpwWik5et+37mscwZ7ol3jrl?=
 =?us-ascii?Q?HbWseRp8edOO4vE1+EG9eKMF0KX8Vc4LxjUDAAMP6R2ZGX/b5DzTnPSCqURI?=
 =?us-ascii?Q?fM3s+SDdWsf8114=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 09:53:44.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d3480c-6da2-4f94-cec2-08dd4501d02f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369


linux@treblig.org writes:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> mlxsw_sp_ipip_lb_ul_vr_id() has been unused since 2020's
> commit acde33bf7319 ("mlxsw: spectrum_router: Reduce
> mlxsw_sp_ipip_fib_entry_op_gre4()")
>
> mlxsw_sp_rif_exists() has been unused since 2023's
> commit 49c3a615d382 ("mlxsw: spectrum_router: Replay MACVLANs when RIF is
> made")
>
> mlxsw_sp_rif_vid() has been unused since 2023's
> commit a5b52692e693 ("mlxsw: spectrum_switchdev: Manage RIFs on PVID
> change")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

Thanks!

