Return-Path: <netdev+bounces-218674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF48AB3DE6E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34177A5068
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD423002D0;
	Mon,  1 Sep 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARI7/L0N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472B255F22;
	Mon,  1 Sep 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718641; cv=fail; b=swI+yGX8Ea81zZvRx1JYtnwD90XKqWhseAMPxq0XqHx2OhhsGwiRQaRzngFDY9m+ffstenMDoGg0XeAwDoy51Au75whMLhRbLL6Zdt5gUYWX0XHKZQ0JaGxUMhfrBUTpEzgvWKdkh1guoQkpyPksyi9a9kTwm81u4PPTZP0lS1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718641; c=relaxed/simple;
	bh=Emkoq4LHyNK7VrijZR8b82iM9haXMRBYvQT2b4FnYXE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TSdD40XnQDak7+P4TSguJ78lwA5f/L0ly1AbjMTdbeIGMcaGKpR9iasREtWjfrruFi71/5B5OBgbutwVI9It6z7djs3Z9A2WVfIx0bGw/X/M2Q+V3+ASVdOCE9DPlltmqWIHkbUpNSf0SJJgmCbMWhzYUxFjtoKnvhV1kicpp0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARI7/L0N; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZXnMWwUPdHSY2XOrwYResNtF4SkNvACDJw5udgSCtQdi8aR2YwzgTz3rsgytBK/lpJonfJ/h5lbZkOqLGNhSaIqDDpw5/xBbsUdFNoVDbFWuYVoXfZf8+zG5YR3O59XjrYJEna4XURS4kC3A1PGvcddv+xh/PgkENRHNrA4tfbTbaiwDF2eFFY/5dLCiK9ejKhtdzC1ujn3OFN3CwP87VuKP3hK2kaEkWbrO2v+oq00GaviU8yYoQdWyaxMpQxvzCz6nDfK5L8j4fJa0HhsB1311wNUGusNfn48pyxg7Njb67vCI+Ji1sGvgf+dITxmOqWyzPlFJQ6j7OyVHgArEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OMcF43yrhlJjbMyfKnvTi1UqAo64I4/QB0EhGrYGw8=;
 b=diAm6zCmhUDGgU6n08qwk3oqbL2hpd7svEOEWQXqDBSHzD7IFS6k31M0QxRkbIWFn0gOMyZenaTmjEiqLHBQZ18EESxDsl6KF3vjEfL9EGHcyS5ovojvaBZmJAzQ98iM5htv/THzSYxuf4/zb2oBeCNfU/GmhlDuet6aTrGcOvf8s7kHy+fqx1IXrGGldtxhf7dm/EDyFj4PHvBGB5/yeCgwlskMAv3XDqmRdPZCkGP+eFEWf9sj9iU89POliRM7ttE6pFHyeyV0cfbe+Q8QU4Ei3CbVVLFPNXj9HkFW+t6Mpf5rlk9h1b09dSq4y06R8wO9bjiyxQLMx1JsMkVLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OMcF43yrhlJjbMyfKnvTi1UqAo64I4/QB0EhGrYGw8=;
 b=ARI7/L0NmBOAy0onDhcS3h9W0ZMRJBfeNoVdO3w0F9M4DiWDglXitbeV13pXQzKJNnQxR+OCtcm0AIm5mErGzWnwOwT/Wn065d76j2Q0SBXV+u3wSyfZ3j5dvpLSsUSRLjoe4LewXYfpQ43E/XgOIBbQyfR5cm48VFwVhS9fYGXj6KfqEfSEuiX/gqU4442YM4/k6iFVeT9LT2pgseD6hzkMWCT36VQTjgk1Bi2GRz2RPPE8mvVxcltX+QWnXqGZ5I3Eg2rzBE5qpfI1k6bLNsRBLcL8oHyXhw5R+BRrFIBgEgsDvNTZqhLIldNKdWMnX7J4IWWzWOOGJHEJZ8gvpQ==
Received: from SJ0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:a03:39c::8)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 09:23:55 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9c) by SJ0PR03CA0333.outlook.office365.com
 (2603:10b6:a03:39c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:23:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 02:23:35 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 02:23:29 -0700
References: <20250830081123.31033-1-linmq006@gmail.com>
 <aLQps4-Fq21R7N4c@shredder>
User-agent: mu4e 1.8.14; emacs 30.1
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Miaoqian Lin <linmq006@gmail.com>, Petr Machata <petrm@nvidia.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vadim Pasternak
	<vadimp@nvidia.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: core_env: Fix stack info leak in
 mlxsw_env_linecard_modules_power_mode_apply
Date: Mon, 1 Sep 2025 11:10:19 +0200
In-Reply-To: <aLQps4-Fq21R7N4c@shredder>
Message-ID: <87plcav86o.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: f205646d-6166-4f6e-f09a-08dde93945d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvMJoxKurN3699FKt5K5/24CNAUVRB6j+jTY7WJN5ppzUPY8GM2sQjTE6mMf?=
 =?us-ascii?Q?aYoDha32H5EBbPp21N00Y38YNMLZlSqNRZIZm2bDfuBkfAjf1KKt2X2FjQYd?=
 =?us-ascii?Q?VO9HaEKKYO0czh5flMfaaFmWYxAOcyj/FrE+urYBb4rMVTrjzo56j+dx1utU?=
 =?us-ascii?Q?VDXNRoRfB7VV5Ld1VC+VoHCr5J/nNA5lSZQ7QsJ+ylHj8wClJPxJOEYhdeaG?=
 =?us-ascii?Q?nFrk8UdkZoeYiqP3ozH/Xp/eP8NdNS89/+G5dRfCjJtVpiSkXEVoiwYHJ9H8?=
 =?us-ascii?Q?xFdSpUNIXPdgRGvxuXHLd4EmpqvqaniUGHBAh/R3GPCgBXMb652Gvgu+eqUH?=
 =?us-ascii?Q?004WP8DyLH3fh+ZQzPkMLgbpIlIJL8JKVu+zydIrLuHAfAOoMUbj0ofbDOgr?=
 =?us-ascii?Q?WH0uz8QYzxWjUS8eDKVlr0IGE0IMhuX7mrG0VSoXkDvB6sSmi6/IoIl+UQ55?=
 =?us-ascii?Q?+f3+G/wKWL7L0WytTNQwwfStNd99BMZBp0xzPA349WaXnLy75Zbew3xzPlr3?=
 =?us-ascii?Q?afvzrFDBo/I18JdlcufypNXfbVE32aZhhWBc86M+KLAHwSP+S7PBj3iVzBFZ?=
 =?us-ascii?Q?p9cmKtyS0Bnrdr6tJd6Bc81re8PqCuTBSpimlUsHEytHBZW53dueR/70ioTM?=
 =?us-ascii?Q?oXE0fcY43/wcuZTUSdeq0zQZWJVl1WYHjP03DfkV6CNHx/IO9rRcDV34cslh?=
 =?us-ascii?Q?wd1RU1QAPrfRK5LXS+Q+r1uJA1AZsYQ5eQG1Y2GXRxTsMc2yOn6eu6oT0Usz?=
 =?us-ascii?Q?vN2+ApJ9JI3/a4x0MPkpPMR8KNXI1vutEN3i2ctCFZKIFl+iK8Q75qJ2oE2b?=
 =?us-ascii?Q?gjYzf7ae43R9Z15oTlGbzaTrypdRLnp7ijGS8ipeQ2DD/B8pHIwLs8SbBVGf?=
 =?us-ascii?Q?zOlaE/DhOp6Rp9U5DSMy7QqWij3uN9Y1xjCkYYKsQKZTGQPhTe6LW2eKKoZk?=
 =?us-ascii?Q?+wOrKU54cyPqkR2NSPKCPuHmZ+OcE5rslpM8J9cbWAdpC80IHPsHMT8Wwe4b?=
 =?us-ascii?Q?7/XOgA1LB4iddgX8Ut1w0RX8G1uA2uVJiFe1AezpqOFP7dhWoA0DyJw73OUc?=
 =?us-ascii?Q?SXlWqk8OE04txndb2bFphnMZrqypzLCBpOjxgKknPrDDEDrh1pAUhZk0hHj5?=
 =?us-ascii?Q?2YPI5SAyOD9GwmSm2iEJ3j9erseaBML8MvzhmPl77kx1MgE6OdvD9XCH1q+D?=
 =?us-ascii?Q?OdMeRjEZ+l4LxN2eblNlbCTnUl7aECXKILqGQyhZwSEmoudM5lCBPbPQe3LF?=
 =?us-ascii?Q?MEXNfxMl+Mjmj2yoAl7T7q/0r3aMsRUgbY6rRlTL++VO0amgApS1v4QGlyAo?=
 =?us-ascii?Q?/K28SJb265lFtfeJIFGMScYdpd2gUS+bUcl+Jq4BuF2ekdslMpR+wnegMHsD?=
 =?us-ascii?Q?Wsu4LWDbs52rzaLC8V21v5S29oTjNigylPB+AJfTF9KTFFNEHU+gexJgJp74?=
 =?us-ascii?Q?gTA6T7VxwAQiO7B8rAuYwnbRk1jvtBZE0UitJlBQej5A7hFgUnFjDirJYF3x?=
 =?us-ascii?Q?KJ/uxE24+0JWVgJktQpwXLrNntwfvC+EKsPB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:23:54.9248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f205646d-6166-4f6e-f09a-08dde93945d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032


Ido Schimmel <idosch@nvidia.com> writes:

> On Sat, Aug 30, 2025 at 04:11:22PM +0800, Miaoqian Lin wrote:
>> The extack was declared on the stack without initialization.
>> If mlxsw_env_set_module_power_mode_apply() fails to set extack,
>> accessing extack._msg could leak information.
>
> Unless I'm missing something, I don't see a case where
> mlxsw_env_set_module_power_mode_apply() returns an error without setting
> extack. IOW, I don't see how this info leak can happen with existing
> code.

Yeah, I agree it all looks initialized.

The patch still makes sense to me, it will make the code less prone to
footguns in the future. The expectation with extack is that it's
optional, though functions that take the argument typically also take
care to set it (or propagate further). But here it is mandatory to
initialize it, or else things break. With the patch we'd get a
"(null)\n" instead of garbage. Not great, but better.

>
>> 
>> Fixes: 06a0fc43bb10 ("mlxsw: core_env: Add interfaces for line card initialization and de-initialization")

Yeah, it doesn't really fix anything, it's a cleanup if anything, so
this tag should go away.

>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlxsw/core_env.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
>> index 294e758f1067..38941c1c35d3 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
>> @@ -1332,7 +1332,7 @@ mlxsw_env_linecard_modules_power_mode_apply(struct mlxsw_core *mlxsw_core,
>>  	for (i = 0; i < env->line_cards[slot_index]->module_count; i++) {
>>  		enum ethtool_module_power_mode_policy policy;
>>  		struct mlxsw_env_module_info *module_info;
>> -		struct netlink_ext_ack extack;
>> +		struct netlink_ext_ack extack = {};
>>  		int err;
>>  
>>  		module_info = &env->line_cards[slot_index]->module_info[i];
>> -- 
>> 2.39.5 (Apple Git-154)
>> 


