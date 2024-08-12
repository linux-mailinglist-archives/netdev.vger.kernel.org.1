Return-Path: <netdev+bounces-117639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E294EA85
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E9E1C2099E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0016EB5E;
	Mon, 12 Aug 2024 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWDiW+OP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C416EB5D
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457450; cv=fail; b=V6V7BovM1KhwEKwhUCI28FyXKXipdlK2my3NRjacqmKF35nYl48HeJI2TAmIJiNzSlNK+1CalbZ6VLJh0PeKKRKf5mpUzRTgOf2lrmS7yJjU8phQoCcr/XOb2SchrlrWgCcoJMK56EnFM0JIX6f9tT6as7KqdSgwW43zoSkLtJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457450; c=relaxed/simple;
	bh=iGvHl2iYIQCD7Ze9AxQ5YPB+mB145Nvo7Ks61UX3IV4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jfmQ4uD8b1YrzP7PNgPeXmTwk50VYOM8oEWXrqxFUt0nG6z7+J2bEWTScVhFMyVJwMgr/7aHZUE0SKAP77REhxRJuzGzkW5rSNHVy5/OC3vF6XYrzBk8DIWXNdaU7/F5SI/ZMUiM9opEUL7w9aJfUVmG4ggGQqXBE5r6a6nVvnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWDiW+OP; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2Caq8gKnNBHcKWt4Qo5jve1/g6wdj6Jv+ypbmdjqDPOgEdSPvj+7F8yHbs+V4m4VMxHzJaUeuucmdRuFqWjBuaGct0yKQ4NDcDE2cci5lmo8ovHNx4n0DMwV8dvVaYY5DW/tzAVnUjFw2h9T6PRx3WDnhlRGKwIdfiYP8MoujkETAOos/zpQpp+Jf0NgfbeQ9icmLPQMYi0gVRD6fa1odtRKDa5OOpemBR8wcLqdtTr5Z2Bpu5aKapqBJ6SDMveSPF0IgPAczc/hihooz6BDi7ShyeZxzJir5pK0AQXZzhq7QApVqP69oYCJuldpvbc8WzrhK09l1YoGW+1dPHkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePsMRGrcgkNBqUICFiLOAgFfN2+50FcjSyA2uiVmT3g=;
 b=lf68lpCp3fwQQgxZ3SeWUbzuLL3YtG11VRxdfgz4RYPNsfVIuKaWVI5RApHe2jVs/aYQUvPBY5M3upeBI0on4sO0bLReb8CyEZs9UaTfvWMvzYwW0/8KkHVGEqIfKV0qaNo4I06Mew+G6C5pWB25CrQcTBJAPH5TY9LTe++VzhoKHWAF7oSfWd/kNoneocVSvGFi9cPs6pdCkrDxJP61d8MIe3An3Jrj3pCTdSUpwdO7+BnKfe9kxwsC0ygU8OQeILTvfL09/Ow8Ba8Kht2JpZua/zOR8aZ6W/6WET85+AD07GSDj3AAY7w2yGiH0VSg4RwXj2icYwURcL7nK2oiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePsMRGrcgkNBqUICFiLOAgFfN2+50FcjSyA2uiVmT3g=;
 b=PWDiW+OPObKOkwlEB4gs8lupxnNdtq/KJX3VnFMh+kE+HZSpXIwqsQMk65QjXORvCdODWw1sS/q11oTHg4ado2JYk0A93QUZfJRuh3xPB4JJPC1bIuaAxXNkh2ImHNvuf4Z6VlhkAadA99MC8H+MYDmV1eFXV5gnxQChjqKp+nN2QVnruFlrZ/vTUydLHtNyorLzEc8rLbVQIjnq8Kpn4qIUyIQbI29KE5+8MbJyQBfzlaFIcK/YWf3P0w3Fz9HPCzTDa6a7WJjiFCaY+/ghQVLoO19xQ2YFTPL2ngGccgvUvn4s8jiJ20cNMx/jaxheDunE+5pNWK6uW0W+WDv/BA==
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 10:10:45 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::8c) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 10:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 10:10:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 03:10:20 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 03:10:15 -0700
References: <cover.1723036486.git.petrm@nvidia.com>
 <20240808062847.4eb13f28@kernel.org> <87o762m31v.fsf@nvidia.com>
 <20240809210934.02d3c2ec@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
Date: Mon, 12 Aug 2024 12:09:08 +0200
In-Reply-To: <20240809210934.02d3c2ec@kernel.org>
Message-ID: <87zfpikq6a.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 139369bb-5871-4d8f-c521-08dcbab707cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmOZeKYdI534Jel/Qt0KebBL65Ruc70vMfbxpnIP+6NPs4sjpEE+dH0r3azG?=
 =?us-ascii?Q?qPyl91C2qkiEmBSp7q6iUUbaBht5fcvxBEEvOW75d1vhZ1afyINvCkHn9r/9?=
 =?us-ascii?Q?eFXEX8fLt0vcYqoGmB7lapGSeareU7AYx1pKJzIGrSuQp2n/qtK+ypuA3Y1C?=
 =?us-ascii?Q?dWhTkuyivpmKwBen4GewLH92R6HbRBzKBaEl3r+anGSayjZ7w6bAoSKh4ZMb?=
 =?us-ascii?Q?WyB08yF9egk42lUCU5CGHa4fuiO1ON6d0qa3DQdas+88NrfSD0DcExDuW6qQ?=
 =?us-ascii?Q?x2vxr16QFFazc1Vc09i7ZVMO2a5Idt/KjryNlHQBI+5mE/ESwR4982N/Vl4H?=
 =?us-ascii?Q?hiTBPIui4ygV0z3knXROC9OuE8eIjADuO44PWjBQKxfySYNUvCU2rFGZLM0Z?=
 =?us-ascii?Q?2NS7tNoz2C4x+vAgSBP0Qpc2ETqU2/NY3hQ9vuG0eOLACOPohioesr07Kkjv?=
 =?us-ascii?Q?XPjOkedHlL1wHPwSAHTJNLRjlNNOYoTKc6u4iOKXEfiPKgnjQYf1KC+qtFEG?=
 =?us-ascii?Q?ymQOv2mJN4Ed5f9GIPqox7RZJrVvg6zUWityC/DcXuAwjtWEhR9y4VTqKuiC?=
 =?us-ascii?Q?0V0Hj8J3DH2kzQK7tl/UrJ2OJG2BgUKkmEjeLCO2E049GbGfY8krCYYzUa9q?=
 =?us-ascii?Q?y37gPj65H6DW0GYn7Ln6KLi50tavjziw31E9ynR5O9HviD7W2xN3MHn0QnFX?=
 =?us-ascii?Q?uwG8F1dc5/FpHU+cFzxR25OFBufZ0TxUhB9+SHquO2u1Icv5+uUrJGm9/EHF?=
 =?us-ascii?Q?yzrvi2CjJE7xiip1psk+YINlu7wNoicweZCfh9/jK6yaxQbtrBNQFGKAQiFt?=
 =?us-ascii?Q?w/hcLIguJ4TzmMJlEC5nRkEMwXks2Lb2XBJGJYYA4RA1Efh9g29tTRWBIfYl?=
 =?us-ascii?Q?qCdGA5FTTTenS3USLcqpPNNtK9pzKIopQLJ+rdSyzT9lMF3amDLsCP0ESONG?=
 =?us-ascii?Q?Ct6uPidvSSmFcZacimcdGqz1sRHUt5nHlNNjXfXWri4Bmyt8G25e9AdvZBD6?=
 =?us-ascii?Q?4qQ16qDboWcIvBkuTB0MiY9gyFBdf3KfhbK4ga5sxl7Uo9DrtwEOLhyoriDp?=
 =?us-ascii?Q?6YqbIPoeeh1ri8QtbHP5U6vr6pU74LGRLdZQx1tvN/f4jJA0sjrD5047ZNIV?=
 =?us-ascii?Q?R3JHWeSzXWSTEXRfUTXKTZbToVyKnkQ9G9g70EHjdtYDqQPlrz++ByildVLL?=
 =?us-ascii?Q?WL7wu5LTnyCAyejXqbd9IKJIxBoClpEM6KrgD8VYgykvjaCjRw+OhUxV5Fik?=
 =?us-ascii?Q?pVMysoaE/v3YeBpcEE0aR/aHHpKCplXoT/1JKFySB0sx0zjUmgxeuXQppahp?=
 =?us-ascii?Q?xY2LwsPwdQUSD6O9PunscuTL9g3vS94ZeIR2KHk4uAmleAArrfxm+Jdbgea5?=
 =?us-ascii?Q?OV91N8paaWKw660o5Y4WpRFbyjNVV9uj5xlsox2ARLwZxhOdZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:10:44.9844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139369bb-5871-4d8f-c521-08dcbab707cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 9 Aug 2024 11:48:09 +0200 Petr Machata wrote:
>> This failure mode is consistent with non-updated iproute2. I only pushed
>> to the iproute2 repository after having sent the kernel patches, so I
>> think you or your automation have picked up the old version. Can you try
>> again, please? I retested on my end and it still works.
>
> Updated now. iproute2 is at:
>
> commit cefc088ed1b96a2c245b60043b52f31cd89c2946 (HEAD -> main)
> Merge: 354d8a36 54da1517
> Author: Your Name
> Date:   Fri Aug 9 21:06:12 2024 -0700
>
>     Merge branch 'nhgw16' of https://github.com/pmachata/iproute2
>
>
> Let's see what happens, I haven't rebuilt the image in a while
> maybe I'm doing it wrong.

Looking good:

https://netdev-3.bots.linux.dev/vmksft-net/results/724221/2-fib-nexthops-sh/stdout

