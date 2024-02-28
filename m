Return-Path: <netdev+bounces-75817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B786B426
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4601C2657B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC815B973;
	Wed, 28 Feb 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0RVY0Fo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF415D5D1
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136364; cv=fail; b=EadvcJJu4yPdSXCwMx7bAvw8oDv66YTTkqM8PKerM+ADQIyoxM/vhoi3jFrAWJ3MUHjDWqlxSmV2eUjV5Rgy/Q1PA6nGrpW94TFowYlNHTvxKCprTsKDXVmm8AofUCeHr74Lpb+/lWwPkEBHMk4NhjbwXQuV+/+J+EfLi1Br6vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136364; c=relaxed/simple;
	bh=yk9Zc8c7JdUxfh6l6G2CViFrkPYFf5dv38Ds26maDaw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jl/aLsvtrXxiWEs/DPnqXRA4tHh6h3FrBheQkjFfRoT3Y+secZNKKaJCdjOmMyw9L2GG/2v4SN/iSnjxvcod01J1RpEpyVY1CWhkV2msPvN0E+cLJao8ROSeox7jnYKZbcIQdxNY6CM+MWoe8X+VNQJGFGVmmupLyta1TETMgCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0RVY0Fo; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB23EYaGC6owINQLRuxeTfwWyQNDkXVhSllga3qz2IxhxnQaB1YIaKv20JP/cTRVa7LUv39WlEN9q3BONrKEUa1BFR7PzzZlDiFdIiLIcQ9zX0aLAQrN4ZCM4d2koDHvagzXfBvDBjat78Pbm4R7maH66zv8iw1yIVsaT1ANoY7CCdYuz6bQA6bj2dAt1uGdmaWowKqHmDG/Zwc3dqUc8I275kq1UKaXEKRoVPtL5R1rwG0lIZYCjYcQKNU+vILTQ83poQi1OT9QvarqSQLTrIqektDt3F/lFJDOSLvoIP2Vc+TEP447F9v1FKJYBWlzUL9wQyTyzaPQnYSLxGZR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/iCshzbH4WyFSjJZVmlLOMNFD8uxqOWbAuEt0DhXE8=;
 b=dY/IPV593QB9rQeL7UQQqu97gXInfOG8tylNwDbUNPz/1Ly/Sld+aQe1HN82WGdLLVUSqvYUd8wHSc/ZsvkiS4NzgyYDL1hlCjDyyFZra39SlvWRaCRVlS4lHynO35hjSpwMkKoqkFAF+V+Og0yr/zfDt7jibd69gjYtKAhQaEU/aefopmYdchm2EAImi/whHcAZhXGrWeGKVRzXdycXFqQHyS204/TqXoOTyMMz+r4eftk2iO/DuldO/sG3FJ9MlsyoubRcx7peQ6d6MVtIYUZmXfha+QGx162P7dRBaOCbRZEqGPb0CJFm0l++xY/ZkCnaNqwsbdd8km4U14CMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/iCshzbH4WyFSjJZVmlLOMNFD8uxqOWbAuEt0DhXE8=;
 b=H0RVY0Fo6TDgjwb3B3E45JhqGLq4gK3qZVSTnqVt0PcfNocV5OFhMWOyNIxmaTea/bLlM2rEk+BXkb6ATxMqgHawG0TkRdkbOqqOAHQg3XoCrIoFcpyQcmVTpNm0p0aV7JjXUos4IirdIn/K6XUHKjMi99zMfUy7sAOUaF+EXAdbfWCRtRFDlNaTJYQOmmcSpxFf+9zoHHWhpxJ27Kv1O+8ph8MIUTe6jxi861TjLos8pfycKXcX6OJUVJOhzYclCcvB3RKUd49uQsot99XPvGZPHE5IbDoi5OqzFgisfUlfAAyxwzqXFxiqpv9dokTFbmrhxy4vMXr1wVckBLPELw==
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Wed, 28 Feb 2024 16:06:00 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::dc) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 16:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 16:06:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 08:05:40 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 08:05:36 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
 <20240227193458.38a79c56@kernel.org> <877cioq1c6.fsf@nvidia.com>
 <20240228064859.423a7c5e@kernel.org> <20240228071601.7117217c@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Wed, 28 Feb 2024 16:58:24 +0100
In-Reply-To: <20240228071601.7117217c@kernel.org>
Message-ID: <87le74o9pu.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 37144eca-1253-4630-fed6-08dc38772830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qe4zXw64MLXJOzPtWxZEA2DIDD5XQkboX9nNOh0LMQVnato0g0CiMU+PlMSaEAYojcYnieKMTMWtvLWZrvXFJuAXpp+IhFPdMfjUKxrk7prRxl47P8UHPsWymMCwN/C8odhfAvFDQGSZHfhUdRynItYY6ZZHLeCElWHFTacsmXK+OC/PjJs7HHcIbjz7+z6FrDOf2FvPFvsIgdW39gVCa+I8cQEO8wq9imE+Zunb2LVFszlUluWO2X3MfI+aTK3yhrl79ANaIJy9WNLR0ej40kBwN9MG6LQeQl4oLGoc+HeCK/XBgrR8qSkEbZ1BeoEOTxr3F39BoXoaBkCUVhfRowa0tDPWPo0no1ZS/dkS0/tWx8dVNpatqEyLrtudXOGbD/cgAeySo36Ce5qXWTLH1Q+bC4WA631dKOFXk/iZ6X18wZlemEx972m641Yya+qK7QFWfhbWvt9ejtnAWyaJ3CjIxnEY3/Uqpw547KYBL79aTfeer5X2hJELrB66WrCsVuQV5HuY9Mqb3xhwzPcdHhpF0TsxfNdoKRRln79L+Q3bhhTjTxty1MNPAmxIUDAQgrMhdUfD76Tb1TKdRGrhWJ0IaJOGpoWW9oqQjgj+28M4O8TfaqBNu7tvfjqvNMu74gLgUH7/68LZ+ab/9jm+LKP0sSuuSKV87fHA6b/kc/XVSphNu7cFAGZR2jdhfdkz1n6nAX8Dmmwvc+MeVcDDnP28xqKioTQywm62RI3TVNQLWBRzMAq0+OgI5vsr+xrY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:06:00.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37144eca-1253-4630-fed6-08dc38772830
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 28 Feb 2024 06:48:59 -0800 Jakub Kicinski wrote:
>> > But also I don't know what will be useful in the
>> > future. It would be silly to have to add another flags attribute as
>> > bitfield because this time we actually care about toggling single bits
>> > of an object.  
>> 
>> IDK how you can do RMW on operation flags, that only makes sense if
>> you're modifying something. Besides you're not using BITFIELD right,
>> you're ignoring the mask completely now.
>
> Let me rephrase this a bit since I've had my coffee now :)
> BITFILED is designed to do:
>
> 	object->flags = object->flags & ~bf->mask | bf->flags;
>
> since there's no object, there's nothing to & the mask with.
> Plus if we do have some object flags at some point, chances 
> are we'd want the uAPI flags to mirror the recorded object flags
> so that we don't have to translate bit positions, so new attr
> will be cleaner.
>
> That's just in the way of clarifying my thinking, your call..

Oh, I see, it wouldn't be useful as an attribute in isolation, and if we
ever introduce flags field for the NH objects, we would want a separate
attribute for it anyway. So whatever new uses the OP_FLAGS attribute
would be put to, we know we won't need the mask.

Um, so as I said, I mostly figured let's use bitfield because of the
validation. I really like how it's all part of the policy and there's no
explicit checking code. So I'd keep it as it is.

