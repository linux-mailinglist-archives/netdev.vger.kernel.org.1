Return-Path: <netdev+bounces-79201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AF87843B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B2128354B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4144393;
	Mon, 11 Mar 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4lzvy8F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F44122D
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172388; cv=fail; b=VVqsDunJCD/IrUTNsIyp1YoLPzrHUTzSIssNCVU3lRq4JccCbsu/SkwLZCh7DhGG+mG9u1msqojM6dDGc9K9iSmwZA5h5VI2qFI7yiV10iFej/NYymD6zfuEhyGrYo5icw+8/23bl0+sEwAE7D4p7CRNnLywi7y2jthvipsgOi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172388; c=relaxed/simple;
	bh=lXqY0pvpQmZmCxS6SIFffxE/spzqqHvah3L47bYXd1A=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BBCLizElzO4HPPejCOyOSXyRmOMn3vdM6MF7d3gjTlcxhFSEqDC1aZEmA0NdR6QckHehDB+m9qC8yuZwmo2XZRxLGqersuzixB+oMfSZhdNeFiHlHmjbtFJk/6A/7+8ARlEaj34yDtwXLP6tm1P//6V5ZnO+2M3neyyZmo+JEBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R4lzvy8F; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxND9lZsYSmVeg97oG5cA2zslowXTRqz9Wf2q6HGlPkayFa6w4Xw002ZnO0EkdBREkYmz23dTEvIQJJHF4blOniZxBpf/mHoNFo9GOrTHtkYGGCqxGAyd/WcJls1WxVRFrkSnBO1wBApWl4kgDY4TOwjfELUoDNGfQWl7MdleJb8DZdcXgYOvASQZe4wR68zLVs8hQBLsMu7oEBfHf1t3CRtIBwzBAihjw4TdBIbdJPw3Fv4icTU1SD2upvVVV2I/IGYDQE5Klfbf2Xx8ww7gvmjRZJWwb7KShp5I4B4piWYYZ7eqNA09oDvoGu4x0wsQzae35wa0QvbCuL9EnHMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0yXRvYjkSVBs595cPRXdbzuvUqZrAZ7m6g6hhyDN6o=;
 b=gTwWFALoBiaUty2AwCOKeDxk2tTOAg13P1DzHlBAk/JAu2PZGOlPxkHtNXjHQN9RrADuyJ3zrGkEDcsojiGHPaFeQ1uidGiKeSa/0Sg2uYyHF2GMYS/twCy84BIwyVWqPse2tPmQ+AWicUMqxNaqMw95I2GZ5lOGabOPt0V3qODpWTcPo8Mbr1qlMJxdp+lYDZrzZ0bBuZQj9lAfczh2UJYH2yb4+a+C/9UkTPsT8yXBtI8ZuujwV9V3E81phlnM0k9RQNeSshc+H076D1AU+glKvSKFQL8xq6FsZ4r7gt3z/dnEW6t9Y+DpLAEhe0wyivRr4JpkBh94vkFh8TnCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0yXRvYjkSVBs595cPRXdbzuvUqZrAZ7m6g6hhyDN6o=;
 b=R4lzvy8FpJOQqgskkMXJy/jh0k2lzW4NvzuT6oRkxZbFqOOcVm+KcGPBqHB4x1GxrEYD0qhqxTWGNFjWkCWL7VgxT7NE0bS8fjrDX9OLelobxgwmSwten0+ZCaaol6145/AekLVjFSgiEq2V8rqV7olH6ruUbmPZcTd/YB6BPjWl4+Goz6nyLztbbsFxe4A2VQH+gX+Oidzx9xV2sKZsPsgrEeMsD0zG+q3ywUnDTsCCtMNUDVKvnR8U16xQTHrHZOc1NCIs3X3sw9n7VkkZEK7o1J46EoVN+aOFraMmbsZy19yuDM+mPCVN9n+cWE9uFpfIo0Iu3m3Mo6L8bWABvg==
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 15:53:02 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::a3) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 15:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 15:53:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 08:52:45 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 08:52:41 -0700
References: <20240310173215.200791-1-idosch@nvidia.com>
 <20240310173215.200791-2-idosch@nvidia.com>
 <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
 <Ze4pIe_E4BgkCP6w@shredder> <20240311074702.340dafcf@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Date: Mon, 11 Mar 2024 16:52:23 +0100
In-Reply-To: <20240311074702.340dafcf@kernel.org>
Message-ID: <877ci8lq9m.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d665e8d-4518-46b5-8db3-08dc41e35599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HcxKE31ZUQ74TmoJdpKYnV46b1ayDStwoY0YfgnbMWqUkYDvV0+vNXBkKx3iaJpi0y9rHvnAeN4J6bS5FUbAPXE5EO7JV9890Jv59xb/kCUM/UH06vGriC4vJPFVJpu9TT0qCMyp1ldYmTaSsBwSxq6qwLDlSZaHwF6KzW5ZnDjRJdp4culNZEc7FNpkJzlXXCVQlN46XZANSx7S3olxuBTiDYXEJbu6SKrnyXjofj9PA1IRqGo/4nmdjIsXdoC4+BEbdxktFKfKCujzu7FOaeNFYgCBy2Fl7lTG6HJmT1NSGcPNC/hMG1CunWMPzB43v+YpccdBTuPU7DCBs43XYeKPAyMfTSFuho9CUwiWIkTyDUPwYiWa8VnWfIAs6/76ESE+/v2gX5uUxY+4Pg/nRVxMjIhqr+Qyb7d9iCJvBcfIFPDKjUu1bVWimYaAdoKZJXvihyxbsuPOnOp0cXc6k5e8EXFazYCtXvWrBfviwkY5eZ6ZIlsVlzE1DvH4G3V84JB1QdJ4jezIoKy0SxO8BXtCkv1rXq9Ub6K6rNsUSWhJh98cvMdJKLLEBZ6BqZlCMvUauz85Z+g6REf1IMJybxtNV5WxsLExkRM8oD//bIy94Pgja6V9kXJhO+b0X+qSxJC94qGkHz3nLu7DGKwgDNKSmaBG34T34xpZ70gsQcWX99pigU/pPk3q8tqbOC3DW0VJHeNlUdpe3VFPINV3aNtJzRLv56VJrsq4XA0r+kxFoFT+D4CUNKpw0D02+2rP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:53:02.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d665e8d-4518-46b5-8db3-08dc41e35599
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043


Jakub Kicinski <kuba@kernel.org> writes:

> On Sun, 10 Mar 2024 23:41:53 +0200 Ido Schimmel wrote:
>> > 'tb' on the stack only needs to be ARRAY_SIZE as well; that's the
>> > benefit of the approach - only declare what you need.  
>> 
>> The reasoning for that is explained in Petr's commit message:
>> 
>> "
>>     - To allow querying for presence of the attribute, have all the attribute
>>       arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>>       pass the corresponding value to nlmsg_parse() as well.
>> "
>> 
>> IOW, with resizing 'tb' to ARRAY_SIZE:
>> 
>> rtm_del_nexthop
>>     nh_valid_get_del_req
>>         if (tb[NHA_OP_FLAGS]) -> BOOM
>
> v2 coming, right? Please repost as soon as possible. v1 crashes AFAICT
> because tb is not 0-initialized so tb[NHA_OP_FLAGS] reads garbage.

Ido will send v2 later today.

