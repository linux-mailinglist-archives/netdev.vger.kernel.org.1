Return-Path: <netdev+bounces-135688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453699EE1D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB531C235AF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F71FC7C3;
	Tue, 15 Oct 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rphwNJqS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55714AD19
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000017; cv=fail; b=lBbhzHnRI3/zzgYzyI8hv0BnyM15G2NAJ/s/1yMCeqqzKvXTO5upxOOr+G9LSA+s/5hPIwdj6RsH7MnNLLnMQ0DIu8EiriJeD9JDzfn5I6waUxt2N2xE9xeUp4EEab+cTDM3KMmDSaOpmJSEhJCuMxN5nz4EIDgzZd92q5HdkKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000017; c=relaxed/simple;
	bh=m7l1bCvW8iJLw6UjnjBnE5hiKdjH4JykbFetR0tmgQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CFEf+vNJ0yNaEvBBy3t+MZw1/fL1BtkTeD9E1OSG5t1gqnm0QqD0kQ0Y94qoAltqFxLYQfSnJ7B6DaxeYIDVeLqUK9KGfW7Aca509dmbUABomB47DSYLxd+ehP6dd01F3mtAc1wnt+w0HZ4uNmkeBzpKZn+yxeH5oxI6mttk/wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rphwNJqS; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYjIy6/qqykSEImil2/MophY6P1ZQTqGr1CzWx1x2wvRW2P98AV3+BaPcR6asFw7y7X3YQlw67n0lcUuw7raOwHaio72aeDDR0M7zpmgzmsG8eJ0rihWT2frflOGDdcxukt40GjLhA0QnluV8OfZ9xq8fsZw2Z3TxokdnPH3vdrFEJQMuzoCiMyRSxrF7Mr5owqRFOXpiwdf9gVLmT5jP+MIP9z58LsvsL9dv1Xd9CWLasFxN6cCEhHQF0Ac639KjGkO76IMUDw6LujF0lXkFWXGrChfV757gXkyPa6+g0ts9h4X4BmGUjMxhRpZNlHegy4vJ+v+A0h85B558EyHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZj87TK6aKbNNaTTyOOWoSsn6NUDGDx2eBrudzsV+JE=;
 b=Wn/5DBITmR+y9klgvnbQd+1tzpTvFQK3CrGfXchZwKE201fN1iUeqixjUqFdKuIXA0zA5vFB9MY/kv4cqw7YTSS33vF+U0ZcB3aowQQYWZs3p2mUhcy2fUMHck2+slDyx5XtLVZXAPqs/0PKJ7m4eUEx88WwNoTHwdSENSCZS+NRqiLfyB5kw9UFNWSW8c3vx+VSdcRNynHwU2puz2aTX3jZm+lZBrrEJAUbqRVuWu2e7ELU0ZFdJJPYE2iNlyHqawnXkYGroh8Ev2YIIiz0DoSS+yk/YYAetwae2+Dp7Qy5SnkJYviJdfROjm3u9mJ0g2JUZtWY9bqUyewZIRwpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZj87TK6aKbNNaTTyOOWoSsn6NUDGDx2eBrudzsV+JE=;
 b=rphwNJqSXtnfQaU/2qDEt9JgqtG8PTlBNCkF8RrrPKC7r/Ec3QyGGECsFQKAVxNDLSA5bJenhbQc27hF41hsKfZYKu6lt6YZK25U1TI4MJ2JZOYHJEhSgjo2GfnJCBqt9QT6JRoRBMJwyDBd1BTRd9fayvNYDjerzzyoLjVkyJyBTUehJAOv88jgi96lS++Nk2nNeWknv9dmoqXtQV751w6x3KTU7MeFclYvsh7je7SQvUXHsx68hUgK9nLZde/DNmiM9hxmcLu3ziPoFbGUkNB9dJyl3IZWYuTSQgjSqP6Z1Z0+ylNTvWKTGpC+diQozTO10cKTk5fUGy7YCF3/CQ==
Received: from BN0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:408:142::10)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 13:46:50 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::89) by BN0PR08CA0025.outlook.office365.com
 (2603:10b6:408:142::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 13:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 13:46:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 06:46:35 -0700
Received: from [10.19.164.158] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 06:46:30 -0700
Message-ID: <ded4f325-e83d-4b34-b96c-656fc3c0845f@nvidia.com>
Date: Tue, 15 Oct 2024 21:46:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] macsec: Fix use-after-free while sending the
 offloading packet
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Chris Mi
	<cmi@nvidia.com>
References: <20241014090720.189898-1-tariqt@nvidia.com> <Zw4uRHzqS05UBMCg@hog>
 <89ccd2ac-5cb8-46e1-86c0-efc741ff18c9@nvidia.com> <Zw5DwvIlxyL5n_T1@hog>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <Zw5DwvIlxyL5n_T1@hog>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cadce16-d7a0-45fb-6e2c-08dced1fd234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVJOZ0MrNmNpQVhHVmwyTWtKRWp6dEhmVkE0RGx2c3djbVJCUDhOajhqWndL?=
 =?utf-8?B?RzBLQ005YURaV2ROaXN5TGM2dStFbnJxcmJJUE9qZy8zZzlSSVJ3RS83emNl?=
 =?utf-8?B?TG9Vc0gxcHdvVTloN2V1am9pNURycGhFWDFjZVB0VkdFSEdQakw0MCtpZldE?=
 =?utf-8?B?L1dYVTFFRjFRQU5kQTIvYU12VXk5ZnBrb3VsL3dTbG1aR3AyeFhnNUh6SXZB?=
 =?utf-8?B?OHQ4RW84V0hEdDZ1ci80VElRQngwK0tRMEoybGtjMmlHK0I2U3JEK1hSajVR?=
 =?utf-8?B?R3pZU3BVUXF2Rjh1dTNCOFQwTFFEbGFkODhlbVdFQmFSYi9KaFNvcDBTZ3dE?=
 =?utf-8?B?cFhCM1JmRGdtalY4ditPVStka05qeUhWeENSVndRN013TlpmNVdVY296SFEy?=
 =?utf-8?B?aHdLdTJ0Nm5pZEYrV1libkVFTEdyZ3lPam9RTjh6dE96ei85MmpBa29rMkl3?=
 =?utf-8?B?b3NEUm9EeGhidGZqNU5nV2NoUk1id3IvQjErUnU3MHp6dGZvK3lYNDAydndp?=
 =?utf-8?B?R2JkVkIxTEN1MWtHaXZBb04wSm5zSlIvRGFSeXlnK1VlWXYwRmR1WjVKTW5l?=
 =?utf-8?B?TTYvYUpqZXJzNDNxUmUxTUNBK3dldnRGUmh4aUZZaUorWWNod1NQRUFvVmUr?=
 =?utf-8?B?aExONVMvUUhsVXUrOW91bEVkTnBIZjVWa1dzUGt5T05XV2x3aXZxUWZ2ZTli?=
 =?utf-8?B?c2ovNzJCK0NjSEM1aklYUytmcHVnT2xWYlBnWVJNQlBKTUJsd1BYQ2RCTnRZ?=
 =?utf-8?B?aWozY21zaEJQd2VuRnN3N1FYWG13djA3M1Z2OXAzNVBvek5SbUZvZWVmcldq?=
 =?utf-8?B?a1NZTkRwdS9VeVJoV1FySHJhcERxOEZ1R2ZkYVcxOFY1QllubnE3MCtnWGp2?=
 =?utf-8?B?dGVBQm51akdkZ0tIWUhldm5CRGZiWnlpdXM1bFVRL1FlMlFGWEZST1JhUTE5?=
 =?utf-8?B?cEVHSzdkNTZkQjNCbHY3ZXdrc3FoTE5ZR1ZYeTRsQy9IWmUvSUR3dzdQbDEw?=
 =?utf-8?B?b0F3OW92R0ZkdHNjMFhHQWltVDE5dFhDSmYrUXczQ0EyV1ZZbGhUbEpDTVdn?=
 =?utf-8?B?RlJ6cVhSTmtibGdoS0xDRkJTUzd3UHFxYUtBL0gweHp6Wno1dUthaHA2MW9V?=
 =?utf-8?B?Um1zZkFHMlhQaUFyWFZxb2ZPVm85QW5JS2ROQ2F5Sm1pMFo2U1RpazZXMWY5?=
 =?utf-8?B?UWswMlk3RFR6THEyYWhTMldHeUNMdDV1L25pb2FIczVUZlc3Yys0VU9uN2FK?=
 =?utf-8?B?TWZ6SjZWZW9hZkNFNU5XenQ3bUo2WHRiNVBFNWgySFlGbzFhdmdPN21HSW04?=
 =?utf-8?B?Vlo5ZENjamloUlVKTHBwY3lCQk5ieUgvRm9lS0FwWTVKUVlDVDhYbm9vbUVr?=
 =?utf-8?B?U1c3ZzduTFVnQmwxMCtrMFJ5WUc4S1lZVTdMQnJ4bXI5UDRrSG5KMUZxZ01P?=
 =?utf-8?B?clF6NCtKd0ZESFZYTm5kUFp6Q092bTZ3aVdJYU5mb0MxSUxtSzFZTSsvcnlY?=
 =?utf-8?B?RmNCczV4Tnlrb2VaWG5BcWgyZHNNaFAxQWhXVmN1a1c4c3Rtb3huZWNwSkdJ?=
 =?utf-8?B?cmlFMnRnRyt6cUZycjg5SlVJR0hWQjFMUVJ6RWJqazd2RTRydDAvcFRDWXNQ?=
 =?utf-8?B?TFNzOUtsZ3NtZW1wQ3lRK21YQVJDYkpYZTc1TUN5c3hOTTMzTnRKa2xqTEF5?=
 =?utf-8?B?My9xTzFWZXR1ZkFjNC8zQXFXUGs2Mm5GSUJJUDY2NGN3elpNMFpPZFI4ZGZl?=
 =?utf-8?B?OEhsd1A2alQwUXk2K0MwMUQwWjVvdVlyVDFaekcvYzZlU0RERGRMRlE2cVVT?=
 =?utf-8?B?UnFFQzJuQnRHZmFYcmRvVysvOE9GbCtkR3B1UTVlc2IreHZ6a1J3aUlGeVM3?=
 =?utf-8?Q?NT3JxlU6cEoku?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:46:50.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cadce16-d7a0-45fb-6e2c-08dced1fd234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567



On 10/15/2024 6:28 PM, Sabrina Dubroca wrote:
> 2024-10-15, 17:57:59 +0800, Jianbo Liu wrote:
>>
>>
>> On 10/15/2024 4:56 PM, Sabrina Dubroca wrote:
>>> 2024-10-14, 12:07:20 +0300, Tariq Toukan wrote:
>>>> From: Jianbo Liu <jianbol@nvidia.com>
>>>>
>>>> KASAN reports the following UAF. The metadata_dst, which is used to
>>>> store the SCI value for macsec offload, is already freed by
>>>> metadata_dst_free() in macsec_free_netdev(), while driver still use it
>>>> for sending the packet.
>>>>
>>>> To fix this issue, dst_release() is used instead to release
>>>> metadata_dst. So it is not freed instantly in macsec_free_netdev() if
>>>> still referenced by skb.
>>>
>>> Ok. Then that packet is going to get dropped when it reaches the
>>> driver, right? At this point the TXSA we need shouldn't be configured
>>
>> I think so because dst's output should be updated.
> 
> What updates the dst when we're deleting the macsec device? And this
> is just a metadata_dst, it's only useful to hold the SCI.
> 

You are right. It's not updated.

> But I guess we would have the same issue when the macsec device still
> exists but the TXSA is gone, so hopefully this is handled well by all
> drivers.
> 

And for now, I'd rather focus on fixing the kernel crash caused by UAF.

> 
>> But the problem here is
>> dst free is delayed by RCU, which causes UAF.
> 
> To be clear, I'm not objecting to the patch, I'm wondering about other
> related issues once we fix that.

OK. I will send v2 later.

Thanks!
Jianbo

>




