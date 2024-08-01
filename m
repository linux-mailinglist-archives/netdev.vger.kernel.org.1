Return-Path: <netdev+bounces-114869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C42944781
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAF1F26C36
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FB170A08;
	Thu,  1 Aug 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ReDNdfsi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542715884A
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503324; cv=fail; b=kD/lES7A5OIXjET/h8B3dxoOQ79WxdHytmPly95/WV8tByA+cS1U5abZsGNrS8lmIBtwq0gnGRzTmWXKd0syvZGf5HCleLsl7TV4w/deVUJ0TIC02jlzmlFj0nXaD9f7owPrEPZGt3Qd49NnvDj34pOmbOtAc5NipEOWxFca/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503324; c=relaxed/simple;
	bh=XeKIHQkSvnKoQEp1LTC7Op5Oh9wyeixFQJRK3hzcf7g=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XuhcK8VIWEFrXJkMXzDFkYCRzoA7oOMBNh2ttNMp83m47gZgwvGQLnnjJ+UzGRUslATT5I1/xBqIV2VJiop2UqtIhMaiu9I3ZFhSFhL5gGaHfiDXeYa314Ymk4EGAFoj4UiLWPZB7mtPEGfPlgYOjHhuOyvNlvcp2puVP4uOZpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ReDNdfsi; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyuwthwZe8Z7ho5HZUuwfIz7ExtlvWH3yQ+eHwLi//ezi7e1cnNnmM1yxGqnuw/cn7VYqjda9r9I3xc/2S6gPPZbfdEkbiNDmmMYo9yICPQbrNM8QZYIM9MUKCr/TtT7xIAlpTu0VrFfTECsqecRvm/4OoNGJ9CjQDR0Lw10TTBQVPzccgHkVyrx8UQQiEBdnLvi3hkXBxycPxPsNZ+cAJdLNER2omS/dHaEsd3z/b13uDyxqztFp4UtuYmj5GjfMH98KdEVvJMmw2oAEwtSh+Di/wnLBKz1mh0l8RB9brqsuyQCWgqJZEDDxdoS3eH645kdXZLLrSoWm+L5l0oh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHfyscBkr1L6JJmZRahVC/YrTBz3G399ClmWsoWdrBg=;
 b=TrFyDg8hGdfO88153bzsy6pVYOC2wAh/OMap0Q3OICbZv6NMuEFzML88ZCuWcknvtg9Cby2B8FUCvT+VsP8NLOshEhradUWqMsxT0gFKt4VcxVNmZZdeO/w7/WZgdiwJnss2daWkIPodOYqjas6qnjDEeZyxq7CUWXjUWd6IFRGkyp1TcyC9nHU8QGTIIm/vxXOQC+MNPi9X4fzap8EncxLb7hmCeYmOt6Sx+OYlccfCJCHgEvEfAGmVg2dO9a6pEuGPA5uY3xkr57sYIe0PIt7zBxNTECOSO8cpTLOBcMfzjfdwCdMbNHtLxhHEprXBihUDIy2SVb7GUU5yj8PDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHfyscBkr1L6JJmZRahVC/YrTBz3G399ClmWsoWdrBg=;
 b=ReDNdfsiyScUCIdje/4csLQDPK0/8Y2zm7D6cj8toE59VR8UBcNow/I5xN36aIwi9jaqO4UoDLKKxfl+3KBDkXJR+B2HUOL14Kpex5ONbxsw3lhaprGXqsxo0z4qff/b79c+/0BU0NbGu6tWhSyMSWjaPSrZBySRkOY6jsyNw6/8GjYntJhd+E2iRLdU7gaoSWWOVLDqIRxgAoWwjSEpdr93skkHibNNbz2eIBR/F8PFycFF/+j/nYbeRbUYevTpDpVQ0rndok1CXS0dA2HSFzRb8y6goi4MgZ6DCLW8tZzp3W8UlB8S/bFISaQWs0+/LSGfRJUFQ1KYt5MN1JYUJQ==
Received: from SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::24)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 09:08:39 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:22c::4) by SA1P222CA0029.outlook.office365.com
 (2603:10b6:806:22c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 09:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:08:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:08:26 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:08:21 -0700
References: <20240731013344.4102038-1-kuba@kernel.org>
 <87h6c57q4b.fsf@nvidia.com> <20240731074814.7043d9ac@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<sdf@fomichev.me>, <shuah@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: ksft: print more of the
 stack for checks
Date: Thu, 1 Aug 2024 11:02:40 +0200
In-Reply-To: <20240731074814.7043d9ac@kernel.org>
Message-ID: <87v80k6267.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: a89b869a-7c22-47ec-49ec-08dcb2098886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMUw30DT1Kq95PqqHM4uW3jBkwoiz0dss+1KB5jfq+dBrdMh2FLyvuG5cgEi?=
 =?us-ascii?Q?UulaKiW/2xDyIRw9uVag9oWrFh8QdnltlK2R5dd1ffyX9pWf15NCcoqy10y8?=
 =?us-ascii?Q?NPIwe9xTQ9YTqvT5NeSnqpciwJQPa6n5674OQIvmLKH3hiSXLWsBCW4PzY+0?=
 =?us-ascii?Q?8TwANOaXBwILW50TdP0Woz3dyLfJOML4qAg4aMNNeH6DiMSMiJw3JLSy47nS?=
 =?us-ascii?Q?BbmfTiIaiYwLXKRdhj8MUCtJ77A1MpXFaVNUlHK2crHcOxchFh8LAZP9jky9?=
 =?us-ascii?Q?KnqLeZQwPKWiFDSRpeVdKrWmxt90zEnaanqdRGzRYs4c7dyDBTeCMWMNTZIU?=
 =?us-ascii?Q?toVOWtRNsWLzST6LMArOWlW8amt9P5kboywVisr7PdEvOc8SsDWTpva8ZcuB?=
 =?us-ascii?Q?DXSbnhoHVHpLp7kNd1Mu1T5YwZqsbt4qbXzK9V4irGzcDSlFK3eUTA2sQ0lg?=
 =?us-ascii?Q?jFTBPhnLV21RpUCeQB6+bb9W9m1LBbPH5UeEp7r54kGp1jbnIQz4P3AwyvdA?=
 =?us-ascii?Q?32jQY58UBtFErPG0/tThyiJT469B6QpaSGR4Z1QK7gPBf8LjMtICHWhgA9SF?=
 =?us-ascii?Q?eiGM10G65s0Yt/SGzkXvwC6JjJkZD10QuJjBosRsMro+uMYhL4HgWKcsqpgR?=
 =?us-ascii?Q?kHjgUnLAIBP6aJ7LDhJOwt2YCs/O53d4QEQJcCxA1QYC7cENcf3zpd1W/pLG?=
 =?us-ascii?Q?NlJkpG/6HViuMkk+K/VuL0ebxSlyk0J/71NIzCmKVSDcCH7W6qOqstxLaA0J?=
 =?us-ascii?Q?YZN4ELTIgScND+IE23ZtXUnWeBFbL3zMfS4JMOhiXqNCAaC3cx+YzvPxrV8i?=
 =?us-ascii?Q?1/8Z0FKrmqybYfJMl2oKy8f96ft0ofwY5c/SfQxR+3l5BxrN75PFlY1SWlLF?=
 =?us-ascii?Q?QDf6pSzsxpfuKuAnq7zKuky7jkauvkDedAckjAYXm78Tpr3bEMagMmONvuL8?=
 =?us-ascii?Q?Ho3a++5EzhV7YliI4m8vJN/o6K4dzgw6eIrMlnPAA9edUqjq1iTLO97sG8lH?=
 =?us-ascii?Q?BV00MX0YROjmpBCuqUcEIELd282qg1Lh5eNxSMo9UTJ1gWh6RpjsN7dh5/dG?=
 =?us-ascii?Q?Jajl690taeut4KLx+suW5X+GC65Qh+M1WlOr3BRtIPc76GMH1LPmLY2KqYNF?=
 =?us-ascii?Q?s3YXfMgv8BbL2PqjnxY7ooV1mC4rpuORcLgwGV0NEe2TssgPna9j7PRK4AVs?=
 =?us-ascii?Q?zQj/zOhQcRq4fpnFkPRDamUm7OMuWRn4Wo+Jb8Sk+X22mF8L/ser+/+vW/e9?=
 =?us-ascii?Q?ktAa081TeakyCYV3jfuTV0qT7pE9PWxXPsz22ZV4rPYuk/Vyo9DQHu1JK7Ay?=
 =?us-ascii?Q?5+yEpclvutfnTbqme5Nq+UwepKNRKA5+QEBb6/fMxntbOVkVsx59BYbUvxDh?=
 =?us-ascii?Q?WFrqXKuZHF+qde5oOeTbQfwD1cKDFJLxxGwBSHTi5g42xtDil7d4rsc4mKOI?=
 =?us-ascii?Q?fDiaSekOIvI/axPPRFg8uZsJ4wCYL9ZA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:08:39.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b869a-7c22-47ec-49ec-08dcb2098886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 31 Jul 2024 13:07:26 +0200 Petr Machata wrote:
>> > +            started |= frame.function == 'ksft_run'  
>> 
>> Hmm, using bitwise operations on booleans is somewhat unusual in Python
>> I think, especially if here the short-circuiting of "or" wouldn't be a
>> problem. But it doesn't degrade to integers so I guess it's well-defined.
>
> Right, I thought the automatic conversions to booleans are sometimes
> considered in poor taste in Python, but wasn't aware that bitwise ops
> may be frowned upon. IIUC the alternative would be:

FWIW I checked with a proper Pythonist in the meantime, and it's not
just me :)

Also, it's not bitwise ops per se. When doing bit twiddling on integrals
it would be totally legit. It's the part where we are dealing with
booleans that makes it unfashionable.

>
> 	if frame.function == 'ksft_run':
> 		started = True
>
> or
>
> 	started = started or frame.function == 'ksft_run'

I'd prefer the former.

