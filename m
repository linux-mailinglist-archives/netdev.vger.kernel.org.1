Return-Path: <netdev+bounces-78875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FD876D2C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F751F2175B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899481D699;
	Fri,  8 Mar 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QB/yvDZ0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D615AF
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937228; cv=fail; b=t+48orDCHGPUgrc09Rvvi4el6gl8td7Ns3knzYZZ0pq8AO1EEkd2Yv2yAqXb4AtxM9+kVWAaynY8CCgujgcUzdnQF3pOhKsyR+nHmYVYfpGNIz9y+IGN/+pXT/S/HADwzkmdS5AU97xBGwOVLBzHNB1BFgwDXF0AsirRlU+ZWq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937228; c=relaxed/simple;
	bh=sVQW8TQKRax5PkPfvTHq1ecxbqe0lcxOVjWNqIv505Y=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JXYGTxeJUCYcv6UrtfoqBnVy3yXdTm3lAvieNqMttDgd/dhAuX7aUoXiNeqhkU+aI2YDMb+bnKirH/r/ljhYEmhgp1SrtAW0V0OsDplNutWAsz5jU37pAuRMJgUD1a1KzIsvzH6+yySFvZj2dy2JYw9N8KEE/GXlEEkM4v7M678=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QB/yvDZ0; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGo5iySi+fqNTQ0C3fehXmQhntXc2PEOTN5Phvr6AnyL7suf4rAML6Y++/3+RWl5p8N8/Tmv440NplneGCAgzLM4HBUlAvxDve88ktZj2c87sQ+OcyAxzncMZGdb0Enm/tqNVf1eTy0O/71FIMFQeMWThYtqpc77pIC3Z6i6LFd9V1Jl+OiAvEygPgSi/WQ8iizwNu2J14hk/1KTEVCNnXrvHxMN05D2nbiL+uQ55gWxHD1j6fQcIavNqRHlhVH1qO3xLw4vuaAJP9lGE8n8QwzQSS0umhiLdcLmTQUDMq3C/5/k1f9KGP6Mf3y/84BhEGHTYDXE/jiNinof8lSBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQKI5QIba/GYg899eYKAF1jizpH+WYN/VbJ12bSvgDM=;
 b=I3hgja5lspOl/qVr0sIJfDLbAKq0oD9FWKxwaIMK1uQ+xtLewmonBKzDM4H/5RIUYNUIZUvQGsxQY/K2mwXh95JbKLaROliM6Q4YjCZABylUU4/UBxNQ3hCYVs5vtyemdmCMEj5kepuxKfgXgjmGwGg48OMLSR36+1RtuaV58HyutUyJ6yV3+LSNEtI/U92DOHv/bUJp1j8IaZ6beihkQf8/34U9VMd03o4SYyXdRNoknBXv25YqaZuld7zJcVHTU/Klu1Pxhbl/3g+ldl+1p2GzeWELmAkarWi01ZTcMmT+8QCMuLb6Mtd2CSmK+Tr6jKj6uWNX43HilRnWQviJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQKI5QIba/GYg899eYKAF1jizpH+WYN/VbJ12bSvgDM=;
 b=QB/yvDZ0deluDVUm2a8NPCldiIYKjYMFMKoaOtbC7hGGmauCjlWS+gmdBdz19Y7tJ9bzPLQi/qLEz3GOyo0lrWqv2WIfiszeDPZiTObGhyM2wafpM4uzUW2lhN/onwPpg6/lIJP58FdD7MnjjNyKKE4/0kPQERn+qYlMmHHUlN67DhTQ4LJZgUeLdl/Ul7X2wdFgrNVrLG26R7+ZA9jMguD4sTPZLc4Y150aqj3vSb8KJyOK4EoLIdnoizNuPk2YdrVXuK1luWn0IhbwqzVo27nU+VlUfR2bP8RaPQ/LdmSAzqYp6+WDuNC/zDCPzOAYJeX227Dv75RNuGepfq8zSg==
Received: from DS7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::19) by
 MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 22:33:42 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::9c) by DS7P222CA0003.outlook.office365.com
 (2603:10b6:8:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 22:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 22:33:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:33:29 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:33:24 -0800
References: <cover.1709901020.git.petrm@nvidia.com>
 <2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
 <20240308090333.4d59fc49@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Date: Fri, 8 Mar 2024 23:31:57 +0100
In-Reply-To: <20240308090333.4d59fc49@kernel.org>
Message-ID: <87sf10l5fy.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdba970-3d43-40aa-f95d-08dc3fbfceaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6PZFS43rt8O67sH0WtiGsrmRBzIUVFsPz782HoS0at+S/i7+STr/S5CRMQkyqhu4a+5m20CjKOpb8TPn/bTAL6+hlT7LR8Q+KjCSgyA1yphz/Vxm6U0QnpTq2upsMokPrvQT77cu71vBA8oQU2JC8wGOuWKOtEeE/5Y0fB/247KbASBiLTGohoQaozoEuU6C7cvqpReJKtl9d5a7j6x/gTBZNnCTauaZ+4S9Yb1T/oOEGELFl2rwqv2jv9WyuMG4MCGigK5VopCaNArDZ0bsN//JV5ojUXnvABY/EGLrti8blOnIRMOYhw14TX0zXBSzK2fQBmqnps5HBxU2mtX5mGzbBybgz/A95HX4OgKYUxdTGif5tmiawgHBOSvLUSEhDpbLM0y8U1/choSauB81/4k9jAxnTPTe9B6KZp3YFKgtv/eAJ0rB/9vWrDPVwVH1+VfzQkOJeh3LT5aWppWSbhfbzX8AaDUpyMKHotdYobhbwok58/2/qkJgpeVNYQPizYKJCXP/DLCrTDZ0dkRSOhu7/thF5oVMRbwqquGVfLj4lZDwfYxgQxujUcXw8kbRKBOdGDgxF0Cv8JTDVlHmFjsWcIgo4+Rl5uTRm5uDbpurfK8/4iw84OMzrVkN9xjslgLV+K2k3mlOtVeEfcunVQHpAnmsme56RtZElbCjQ2BtQgHbGe83xTEA3yW0R3lSUBhv49zN9e0Wja4/XF3F6VjahPTkXV/9xKda3HuRdyxNoNQjHhk8dz4lzcVJ78xe
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:33:41.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdba970-3d43-40aa-f95d-08dc3fbfceaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 8 Mar 2024 13:59:55 +0100 Petr Machata wrote:
>> Add to lib.sh support for fetching NH stats, and a new library,
>> router_mpath_nh_lib.sh, with the common code for testing NH stats.
>> Use the latter from router_mpath_nh.sh and router_mpath_nh_res.sh.
>> 
>> The test works by sending traffic through a NH group, and checking that the
>> reported values correspond to what the link that ultimately receives the
>> traffic reports having seen.
>
> Are the iproute2 patches still on their way?
> I can't find them and the test is getting skipped.

I only just sent it. The code is here FWIW:

    https://github.com/pmachata/iproute2/commits/nh_stats

