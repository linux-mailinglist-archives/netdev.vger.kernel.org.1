Return-Path: <netdev+bounces-75810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F886B3E9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285DC1F29383
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9815DBA8;
	Wed, 28 Feb 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xjte7aZT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770915D5C4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135889; cv=fail; b=mdNBdQMybOiHKZdadD2DuzbllkCaP9qHrBwqM6XzV9hvNJShUL8J2n4ojo/2altZmQfaJP/zWWKHNKoj7qxp91VKsvgCvzMiae0EDwDRudDuFgbjdMJ9hC0CFQ3YS6idPyR49SHxbZOwQoAsPsgVZmCJRrJkp+/9yTCXlP/EoXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135889; c=relaxed/simple;
	bh=MHJeLYA5VwzqMBHfiqFjVDEBKMxNf3DGMNCwXvZ06lY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=em7gHvCPlThb3vrfLKfPk6H+l4x9s2MJOn3ZwXApgbFwulRbcYG7qenncOZMbmDRMvv1lP2U5syX9pUVIbJHw0k7s5EjGkMqlcfbtZ1ztV/N2l6qBDjE6kouXQemwwdo2WvMrQP1f/LtO8Qzpol4L0kL9+Dq4tSet+2sDP2jMZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xjte7aZT; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZc9N7sZJrkOHEpyi4aS2phLQE6g9ik8pZ6RPEU4ka/KCb7Q+vxWZwEZQRj4GQ8PfOnHCcQyR1wZ+y/8KXuo+SpWTrTwncL+cZNJ6mxKrGU+9r41HPNk581j4z1xjvP2XP/tbpBLu+tzUkd+WGuEg8HuqBt0liTEpJ9Pm7FgniAIdgSKKUZQ1J8VzetCFOKBVNJpFuQwKA1Ns2MLebh/axmApLz3s/4oU7lRQlmkJ6ZH/kFZUgK7gFDvBksf//RyliRS3E53cJ0E6QJfvEqIu8cnx4eOVHlDbjlDOrFYpoTv1aa1LQWfHSuvy95wuukEX1Q+83+YISe07h060uo47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx2xBwd3u3bSs+YDu1TLSo1Z7QkRyIyWwJs4GHZezAg=;
 b=nZM/4tyVr3ONbC33IzT5DcULEMGvpEqPC4yAc1Qs0akxPvelZ/GsrmCOGqznFLpJ86zFf4Tri7pGlsCp0gSBe/6Z/qtIDgQFggCutgVqSV7zj4tnbStk2Kg6ilQ3YQVMRiHnHTo2zKpBNkvsepFV+CFp9wQXl7uhS86BQvUdKb4IxPLbW/YkEQ56iUO9R+DgtmD/c07K5RNOBNPTNK1HfMFgghPVqon8vB1Z31LKXg5T1EQGg++jh8QKy7jUezUA2JXCpZe7grYlVlJjw55qMBaVCfw+zVnPDEon8AHyK7Bvs+l9W0dhye9jJ50g2Q8gcf4SVRKhLCfWw23vTgeeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx2xBwd3u3bSs+YDu1TLSo1Z7QkRyIyWwJs4GHZezAg=;
 b=Xjte7aZTPlnjVFOw2AymhEQKb27Y9gBfCd/MBay++YceJTcEuktfTxK0UKINCtx04UX1z0G4MvJnMtV1jwB+08QE1MqlSPtz6kIpDaEtx/bDI3ixDXrg6Vc59qqQpffyrVMjNswlt0CtfQ5Xh3z6v3H0Osn33ReFmxm6VvRzW8lK2/P6jw2/dqxbm52FwSSSkcaz8VUXpKiTRV4tQr0f+m1qfzOM3U4//0FvUScss2CYigP51RgYbtlYyrUL7csIus/5tHBKYVxBkd3qe8Imu3Xyv4r4wsSZyfw1LP1RWJZxa+JqIDg7pYbz//Nztd/025FGIjmRyF/xb9V8PEo2eA==
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 15:58:04 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::19) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 15:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 15:58:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 07:57:51 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 07:57:46 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <7b6e4e106f711bf25ffeae1da887f2ef53127ce8.1709057158.git.petrm@nvidia.com>
 <20240228143004.GF292522@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 3/7] net: nexthop: Add nexthop group entry stats
Date: Wed, 28 Feb 2024 16:57:02 +0100
In-Reply-To: <20240228143004.GF292522@kernel.org>
Message-ID: <87plwgoa2w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 899dc502-8292-4f37-619e-08dc38760bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UeruoZebq9UgJZ2eD91tDaDXmVEB0TqGcwKMmaT80scFKbN4Ibd8nC+c4Mpv41UzDlRSIhAaOkhzd6pBxEz68jYLP2HDGfci9x4RiSL5Xt4YURyMxNF8O1m3q2PD/mT+abVuSptmRsfapucrBNjtGyT3fKOJpbG8RLrjJP7nwrHVz6HzkWdjo3C9elqx6wZucEj8ELY5+oib/7saxj0b+7hw3/aWYgJDX2ZAui6af4/l4fe864Ei44ttUHAvyzm092VIZLWY8b/HSXc7/hr3AxyajCgz3vYRuycoxRQ7KIYeFDU4wr9qnvAbwAOTpyVx2TysSvvbV/oB06hTMLoqf9sH6P0TafejE2gHnqTNiRGWIfHvL4UYcEGbVHF4cDGgjhdcTlprFhO1vVmYwf82sqU7r221gRjjbZJMY9eIcge8eMjzHkFLgHiJicDXxbnHycVlb8ox+cSai6t4eHUQSDO+rDG4tHet1aHycpu1FhtG3qOl7DiUHRHQesH2FFnMnoLfucxsh0ByKinb/0QKbXe3wJbqRWLMuqCW413Z2bMEw/N022fNnS8XDGrLQz/s3ff/kUvwTDXrprMpxmgQbkk6g1ojSjP0LL/1nVdlTafmywJVvpSl92gcY4da6vavKVbaEWtxtfxeLsOv7aMUSDTUYihAQRJhx5ptdWkIrVwk03qP1Zf57j5HInL3cfCOMECZxIb/sqoYhWaTL+7sTwEeIBm7nQNpjvp4wlCRCgMsIbL/rdoHleZjDnJJiHYG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:58:03.3798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899dc502-8292-4f37-619e-08dc38760bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617


Simon Horman <horms@kernel.org> writes:

> On Tue, Feb 27, 2024 at 07:17:28PM +0100, Petr Machata wrote:
>
>> @@ -2483,6 +2492,12 @@ static struct nexthop *nexthop_create_group(struct net *net,
>>  		if (nhi->family == AF_INET)
>>  			nhg->has_v4 = true;
>>  
>> +		nhg->nh_entries[i].stats =
>> +			netdev_alloc_pcpu_stats(struct nh_grp_entry_stats);
>> +		if (!nhg->nh_entries[i].stats) {
>> +			nexthop_put(nhe);
>> +			goto out_no_nh;
>
> Hi Petr and Ido,
>
> Jumping to the out_no_nh label will result in err being returned,
> however it appears that err is uninitialised here. Perhaps
> it should be set to a negative error value?
>
> Flagged by Smatch.

Pretty sure. It's missing an err = -ENOMEM.

