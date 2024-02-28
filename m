Return-Path: <netdev+bounces-75853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DD86B5B0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C88B23B9D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFDB3FB9D;
	Wed, 28 Feb 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4c3Swb/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D85320F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140637; cv=fail; b=jcUHDyWuCEGekQLKCdYX5zWaMZQiPjAtG9qR8876dOEZ2YWnDany5V5MZ1hNzIhGFIdRoWL+b/eNyF3W0LBeP8903pGGOHodWX0/2M4MZjA6FjCpPvM4c2aZeO38M6zpXTkZQN2RwpLGk7pPgADM1VSe0xNruDyzCTrRQzhm3cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140637; c=relaxed/simple;
	bh=/JtEZ8ZtTEI9Sl2djYbKIovg4XItcGUm0MldmrUZQiI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QWX6fkUVrQ3o2TK8+nTN3Mv7D+n61YxHfkz7gusZiP47uqraehCAsvFlb6p6YCo2KPi1CdQor7OIEbI3sPmfZOG8hgrHkdhZVMO7cRBwCX944YyLRie+Z+gRCSA+196aZrLgQPQWo7aQmYj90FT3H5KR1DQx5MwWBlC7ZALrAec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4c3Swb/; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx/jyLBK9djM8OKANLFh3n5pd6C3HRh1stUlBvXVHMLcfMv2ywUFRVCeJ79tncWo40kBOARBMUNO8AG0ZfwDNfLd2U/F7P/EW+81UHsu+tH4be37W52A+DQchgqwxgU3OXH41zsby1o9Si0BoSImehnE83Galw+Tqab/Cm4dLS3udl8lA+ogcACkqw6qvG23vpmPkgvu0oWVZ8gbGFGQOL88B1aN4NtlDx99koNGThcJbKSORRgWqOsy8TUN+mFLVi8Cem1/7gWhS1JosL1y6ribEP4MzK6Jikg+rp3bHc+iWtXLlQ0/M11ApNhs3kXf4NX35ClXHuE4gVO9mM+45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmLp0MuSBaVaWv8X4lBxtopLz+LdPLujOAQIDSYaKks=;
 b=FghUgcnsOxJGYoxeX5X5UN32UfXI1WeL3jVwIhI3zvE7jRoAqEjHsj79Dzyu8IZeCikOsOG4V9U3uhq9MGXdZY8+CHr56bsgw0kZQ+IumdyZHZPCJXc2XCOjk+tXyAfFYsOZWuVyrVXgxtsNr3QfIblYUxlRTxGbrIPasIiUElwLfetIgdXZxFibYZlGDvR2ouLcBhVCVkRYXSu1BqN0nDQYdy+mH/IRNIGj0lapuDq2ZNeJKYmTsbs3AT/wVegwsJjPlGg6pRBIdHyfxX7DFNlx/xNqu7kGLIY0xMkWYQ5GZS8kPJXCmgo/s/YiMmfayw06U0ghHRhDYJJIgCMd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmLp0MuSBaVaWv8X4lBxtopLz+LdPLujOAQIDSYaKks=;
 b=a4c3Swb/SE7va4sQq1UVVGVKL+L8A1KheqsiqPMZ85L8rAUluQz8V2QU5nUFH4ZWSJUnQTlcPHSSgwXMEaRzHrcKfAdoVUGWm6KQXFCIxv9vweMvTi9nuV4YKwtPmZdGq78JQ4/3IyL830Cm1Ivea4BxxmNLJGohP9qZnmn31f2U2crafdVPv0mIGdQDWKhFJSVV6sA339AAlRx95bO8Ua5f3YL+UIi2R2QNTJ+9kSUocLOV8WcWiRX3Yh/QCx6oitKlDjRQ8LYOarJ2ceIO+r0MaPJsf4jLL7UlGUSZJPnhqS69K7V2nmD6QpB4IOwydWFldCPueTPJp4MXrglT6A==
Received: from SJ0PR13CA0143.namprd13.prod.outlook.com (2603:10b6:a03:2c6::28)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 17:17:12 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::75) by SJ0PR13CA0143.outlook.office365.com
 (2603:10b6:a03:2c6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Wed, 28 Feb 2024 17:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 17:17:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 09:16:54 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 09:16:50 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>
 <20240227193932.7762464d@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>, "Gustavo A . R . Silva"
	<gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH net-next 7/7] net: nexthop: Expose nexthop group HW
 stats to user space
Date: Wed, 28 Feb 2024 18:16:22 +0100
In-Reply-To: <20240227193932.7762464d@kernel.org>
Message-ID: <87h6hso6fa.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: dc987544-6748-410c-06d2-08dc38811a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xZ6JbX/qGbxcFOtkvDN9KxfEqKI0Ounpzi7Y+5nXUpVZ0A79MG0nq5CipxxBdUiv1k/gbLgzO2YaTQKWQYroS5KlInBgw+bMZU1iWs7rZviR3IZCA/eBuwjNErZZjYGMfJ8W3qMP763BJJJMv8XU8ArSs4atPNILjfAgLqwUC7CpTn7++tgChOZjRcA2CvTnGTpcmbz5Uk1oZFwEX4veLu+AihLhKNNbCRuLjVKqtVotTvE2aetqqDh7cyZ4kwf6ln0daWfkFEFatxV/78QDgCWLQp9d6Fxz8aTWJF+WoXlw39++cBpHkXN7K2T4x0XwZcv2sibIlVulOsbNPzqhBQ5LfL7IdT95BdhbZKS+si7wHbRcRKh8KKOtpPpEBO3uJo5IstgD6Pw/XoU/YUJm0AAC4OdGl9Cs5X2nQKyhYUTaVEgWlhbVy8Ygg2/V1kExGsGzKx6G4w9zM30eAJNBxDbzL2X6Fv3b2CG/ApyBR35TfS54q0waEhuf92dJpdmrW6GDKbyxfoNWKGkJ+mrak2+BjMqvbf8mtCpnzpK7YdKDfSF8PzwsnZ2kKsf7FqS1k2W7OjZR2lMnSk/fN+TGShjpXlWcxvWpc572QYUneuygZLYAhEYWinlnnD/1CnJxn8Of6WNxejgXxrV3QaJIc7LdprBQENCFLozeKy68lSZftH0Qc0tD7OMj6S+fT6q0j/kT9ZCsABrOSxPl5AHFV2zqQGO8a2MGa2j+PxFrnb0BEs15llUWRI3bbKeFs6Dw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 17:17:12.0404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc987544-6748-410c-06d2-08dc38811a45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Feb 2024 19:17:32 +0100 Petr Machata wrote:
>> +	if (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats))
>> +		goto nla_put_failure;
>> +
>> +	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
>> +	    nhg->hw_stats) {
>> +		err = nh_grp_hw_stats_update(nh, &hw_stats_used);
>> +		if (err)
>> +			goto hw_stats_update_fail;
>> +
>> +		if (nla_put_u32(skb, NHA_HW_STATS_USED, hw_stats_used))
>> +			goto nla_put_failure;
>
> Something's off with the jump targets here.
> clang detects nest is not initialized and you'll try to cancel it

Yes, the nest only starts below. Will fix.
>
>> +	}
>> +
>>  	nest = nla_nest_start(skb, NHA_GROUP_STATS);
>>  	if (!nest)
>>  		return -EMSGSIZE;

