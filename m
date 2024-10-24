Return-Path: <netdev+bounces-138619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E459AE4B2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81EC1F23029
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE641CACE1;
	Thu, 24 Oct 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvuuTNHE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C5176AAD
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772649; cv=fail; b=l/NiGRYfJIYwfOYiPUmT3ZYKbi/+wA294hYy6bvPgM6Zz6mkfTcmBtMoch+sxxuFyjP81c8IXfwH1XQOY57rGIpr1LYy0kB5guCCiZJ+1dNdBa4SToJ0hW5ha7XIZqDX1gGDzRF7NxhZN82JfzgNYCDKCFM5gT/2owJXiWLyJF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772649; c=relaxed/simple;
	bh=bKPaLT085py7Ly5Xbrf7Z3Zqi4/6VnwZCxkOVml4Gj8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PhuvLchrADice3w18Nsb4W6xJWr6RtjO8FUSLPxaaKTMxY1yvZ1U2M3nQ7WartXCo0nDrKVXWz7Dq0nbzc+pW/3ejDetjCPlT/P5B5pp3ukWwztdzXYtZOEkNsX+H9qMqbDUTK7GqH3eQyPBz8HfzfCdfWMq1ePb+kP2e2DRwIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvuuTNHE; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx5b07E63QnW7cVusNZ+b8DshD7+PrCwfEAyUtCMxLUXD76PEWqjWpKMxvNY9TEVaOau4mX3OhaQ4R/ZdMWmiiNHuxKi6nwuQn2lqZX9x933NDlCAVyKG1nSS2IPmODCr4yvt7fBN4bCLRi2av8mDULOQtz3lKeSjHBlNF+vWUPMASRb+eksQtVllIzvHzVlyii+3GPOTwldDKlI00ai9GSCkq2udH2nxtxeGi4BfVBiJZzpH9bwIiOwyp44zku+bcXi2PWV1gLNMYbM8gH8r5oSY3hZQ5zCOxkXC4Lu3MVXfCNq7QsREta1iKXfhaWEaStVB0kgGsbDzQ0eu+HjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbaV7FYHmByOlSlw17lHiB6xDrizHM4gPtxXzEIrmp4=;
 b=mJigL0kKMHgajkYlf+S110rYsvuef7EeZLVA+K2e96dqxdkrfsI3lGsNNxLtv2f/NRUrjtLJIMDlteYckfQsK4+idXGPbkizZ9tzYXObfB0WSkFESvpcbPNQQ8iNYeoCYjXTcVYlz+vcB0hmb9KTn156YaHjdaawEutDovwuh2cmKWLQvf5O9g8dFG/DMpxP3C6mu9DLG+2R5itrxwYo/F7hsdyupCVwm7Xsh8v3y1iDLv0kD0WtxCt7BWne9HHCkLzZr5P08v1a5sm4gmziI3g4rJsTdJCeXC/rcLKs39bifT/GUPj9RMniDly1X0PhTQICyaSi/7zf+N4+PtMu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbaV7FYHmByOlSlw17lHiB6xDrizHM4gPtxXzEIrmp4=;
 b=rvuuTNHEFRdD/gIkC8VZfl7Lfs8r1CjvbTr4VljSwXkILjGGSP1P6E0Rtdf5Ngr5xrIxFxjs05mRJuv/FjEnLiNJF6MazFDYMJuhXYt44CCUwkmO2UVMEUiWJGSHDr0sTbgXmNEp1uRnpAn5MAzG23Poj8qcaI0d+bTbOh9JaIKXF1rCbH7toFXd7qHdSzvBzhXHi0dwwD1rLLS9MeBT3HFvLMVAOEbZSn7LrFcHAbDu8mjT0rhQTOLm5NsrjzL1AUeo8DF5uV9HBqrSV9G6U7B7oOKra65m4gRaibDRkGwqSC5wVnEGJ7ts3tlwSyv6aGtZqX6U5mm1vh+G/5jxdw==
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 12:24:02 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::eb) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Thu, 24 Oct 2024 12:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 12:24:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 05:23:48 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 05:23:43 -0700
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
 <20241024105508.GA1202098@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: Gax-c <zichenxie0106@gmail.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <petrm@nvidia.com>, <idosch@nvidia.com>,
	<netdev@vger.kernel.org>, <zzjas98@gmail.com>, <chenyuan0y@gmail.com>
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string
 in nsim_nexthop_bucket_activity_write()
Date: Thu, 24 Oct 2024 14:15:54 +0200
In-Reply-To: <20241024105508.GA1202098@kernel.org>
Message-ID: <8734klit9w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2739ed83-9525-4c3a-aeea-08dcf426be35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BA2bCDhm4LVeETMk9ZZUpuZvCm7+HGul+YO/l2JpR1RU5Jlqi8FBRemoB+p5?=
 =?us-ascii?Q?VET412kam3ShOoRL3uOeDozXn7BUkhCZyQz3YD2OlVxzeKCoRrfwuHDArezI?=
 =?us-ascii?Q?dY6NhX8nkBDCjXHLmf99xkkvS0r/ExfmfBdB36dMDVJiduGaTEEe3Vv1lWjB?=
 =?us-ascii?Q?CqSs5KrEaR+ZxDzeHeoXUdSMYD7vp6tswQA6wvav6n5oda0pL001emH/uG+0?=
 =?us-ascii?Q?hbDuar51DiA1NsVGbj8fmmzA0yTEzM/2DWJe029MQ6sdfEcS2zqWsqQgZ//J?=
 =?us-ascii?Q?TvS7GhbhSQ9jqJ+OAL4dSqm9igNaM1AOnEGHAgOBnxut4iwTnRXo5O6Xyn25?=
 =?us-ascii?Q?4Ki2mofxudbIKaGlJLeGnRMk54HUKXyhzob7qjOEQ5r8u6+mYbr0FVGD9bh6?=
 =?us-ascii?Q?+h3EyFO5m1aEKUoSuAUUOJAx6tg/i3XdNrYCCHf8nTwfLcrTdW0NlEpht7S8?=
 =?us-ascii?Q?8I8jqQYs1N143xkHEE+kTpIcmxruOEMOMdrKHsKXVOPmsEC1P21/QB7A5aRx?=
 =?us-ascii?Q?GilZcszpoBlUSyP3ZXKtdQ8eoKIUNqo+gVWv2MXKW0os+iBDt2y+DNp48cb1?=
 =?us-ascii?Q?eot9oaKD/zLner6I5mrgnwl74L83KLdamCHTS8ho0eLYjgNtre6pSKqcvEnS?=
 =?us-ascii?Q?igZy5bAEWOLqy/mIskiKIGI1UPgHHhwFgnTy1pyRdJneYnh1SVSvuctnODvO?=
 =?us-ascii?Q?g8lcmKKQLoCRiM11OIM+VgV77eywQx28FSegsQZC23QM/wTVDnLdSg2WJpx2?=
 =?us-ascii?Q?Yln7kTHdGcefbsgKmG/q9hNCRT0ekQvRimlKL/fmzHZkHpgZpzF7bCWloCHR?=
 =?us-ascii?Q?k1dizqgHWnu9Mro4WsvWR8/xW/jkMGnRBL3egTjbYA8CdDzPqqSOwFok84tz?=
 =?us-ascii?Q?HXbp1OOrpH5b/t4FVhl6nuxoBn4aXrHXfkXsUBgGepOk96LnwmKGBP63GL6N?=
 =?us-ascii?Q?zQwX/nGs9E33cPOvRLJvMX+wjVHPA1iD3tiMYOi8Gku0Rrru3qVpft2zLQgK?=
 =?us-ascii?Q?ZSO3uUR8U2uBq9mYygkvLe0WZN4TMOLwyu7AnfErjQbat0d4O486jdh88hfx?=
 =?us-ascii?Q?4Wk6P5bqWo/wUPBQRQ+8zzOj3O532jYhwe5w7NcEKFthXJaBywH2TyfpWM5M?=
 =?us-ascii?Q?KAP3Iwo9dGiPiZzVwPbO9lk9jl5zFYMus5ijTCrQ6wtrYDDtuACljQSwAd+K?=
 =?us-ascii?Q?oNOopgq1rJ0ri047E8foBq0Z/ISn9zRVtSyfJt2k9sEJz+YQ5G2jK/qUUEDj?=
 =?us-ascii?Q?VbTM5857H2Gq3xu3nzT6V63pQbtBrTmrnZh4jn8ja4H0Taidmr2i6kKnuXAj?=
 =?us-ascii?Q?6kXEgx9kPIxdgQkBrQvQ4MvnwZy+GUW4JreCP798MBmDD1qA0XPPUIP8t9RQ?=
 =?us-ascii?Q?/kMNmbCODpQ5Gqw/KGqBYeJy7lKpdFw/PL4ALzHFQQ5E8HRSMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 12:24:01.5329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2739ed83-9525-4c3a-aeea-08dcf426be35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365


Simon Horman <horms@kernel.org> writes:

> On Tue, Oct 22, 2024 at 12:19:08PM -0500, Gax-c wrote:
>
>> diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
>> index 41e80f78b316..16c382c42227 100644
>> --- a/drivers/net/netdevsim/fib.c
>> +++ b/drivers/net/netdevsim/fib.c
>> @@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
>>  
>>  	if (pos != 0)
>>  		return -EINVAL;
>> -	if (size > sizeof(buf))
>> +	if (size > sizeof(buf) - 1)
>
> I don't think this change for the best.
> If the input data is well formatted it will end with a '\0'.
> Which may be copied into the last byte of buf.
>
> With this change the maximum size of the input data is
> unnecessarily reduced by one.

The buffer is 128 bytes, and sscanf'd into it is a u32 and u16, say 18
bytes or so total. Arguably the buffer is unnecessarily large. I think
the -1 above doesn't hurt.

Though if (user_buf[size - 1]) return -EINVAL; would work, too?

