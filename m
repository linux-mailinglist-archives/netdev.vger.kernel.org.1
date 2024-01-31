Return-Path: <netdev+bounces-67388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A4C8432E3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36022851D4
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7D15D0;
	Wed, 31 Jan 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TjxP+uNl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE64C6D
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665384; cv=fail; b=ma8Il7Em7hUhp9F8w2G1Msy1nNyHrm6H4o0vgxsBp8RX6omneQZaGFIgHS4ZmQGQOUO0Dnmp7WTFqRwlFaRmsxV66eAcB5iH0IpnYOAQVxSSsPC5cbWQjyzIp3JHzIvgbazJCjBu3Fod6EtSfzHE1S7AImgWds+OElT+WWdbYho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665384; c=relaxed/simple;
	bh=Qc54LkIoCuPkxkNG9ILY9YiyTEqdeT5Me459BP1BSeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uQ7tbqjC+V7LqaNXO7hw2KEc9KPYtvrWqBZ+HTnUdhqxiUBITqkM9sOg9yvLQXoW56KNgEQwdl7fQCzMV5K125lzWD1mobXpUW6Q18YCnxG2D3SVzZip07qCy1DEzEE1biVZvk/JGemYx0rbyfV+xZJIKJLTv5U88Po8Ba/ifDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TjxP+uNl; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs3Ifb00V/uzZqmxO9LM2sAbDFs7qFTs+uRgW2hq7yH7vrIaPKvxO/3wh49PZZswd5jIfYpFM/NJo9nHpagiXagX0nY2G4PWDw0Rz9VjPBZph+ihdQRNHevAOWlqEp3K/mIph2BS5xzgslaYEc6ajsgUIbLVDKiSrbuRTeQGXSf7oESoKgn0atInlraLwVCMLu+gfJqto1DaRdBkhfH5h+hmr3KB4JqP2fIKvHF0kB/JTws2LgBjO8tjPnp70kP+/8KOEYz6UPB62EfiBCgHl0/8C3MA7p91MXne8v+ZiFl1lN7IFnrR4e5xBIW8F1lr3cm/dJYn8NF+0sdsMgUI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TeH7FNwlLTtuG8kzkxs+0G9nHhg8mxi2S8Wnjf3HGA=;
 b=Ab/sGamoP/q4PYfEbGgVqAHtNunyP3mKE76KSnf9OtI4ZUKx8SWm1m8mJcZBpgwbD+0FQ7J6Ja/MoJ7Dm+sIx9kjWzgpmAgdS/nPnsl4p53oVOUVfAZiIqrCt4n//RBju9NenB79ajz2ooMMb5dmhBHsUMp1GxJmzUrsz2SCUWRpVVxvuw/0oznZOZ0xar2caVBj/ABVM6BAsLzujL/8Gnq1my4AaKSBgei3rDaaEwWUwVHyHfOqPWBqIQxso1tAqrUTMYFxAQmWZ/4ffzq6WJBrwVFP44s7X71qAk6dNjeGJR5xl5nsnmaxxShblybZ1xH5dBmInUugG3QCCUOc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TeH7FNwlLTtuG8kzkxs+0G9nHhg8mxi2S8Wnjf3HGA=;
 b=TjxP+uNlb+06yuzprha3N1rBTV2n3cIbi250a0NQgfs7syvWUd+zoFVPEBF7ogGbYguNvT6mFWT0NGsok4Nl7uLKD98mXDOz6JI9vWm8HmKGUKwPCWmXFQsivohS64mloaxMomgNljM76Qco26BDfhijURH1I1xy0vyXxCCDBLBPCz8irE2wDtRiPDbvtJrgBJtbq6JK8v0yaLvqnHvSMinhkdEKPpOfIiFWHpKB8i1tcSx1Csuj6WKx2OGRhHWl+nzC3nmFpowPBCG7tOqgULnLEDwfZP2iS7wwSlOauWbQQgMfGC3VIH3fzjMe/qJh80kylOw5del8QNJlHw2H9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 01:42:55 +0000
Received: from IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9cdf:faa9:928f:7b9]) by IA0PR12MB8086.namprd12.prod.outlook.com
 ([fe80::9cdf:faa9:928f:7b9%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 01:42:55 +0000
Message-ID: <d5a7f141-9d49-6208-59e4-39017df3d20b@nvidia.com>
Date: Wed, 31 Jan 2024 03:42:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [net-next 13/15] net/mlx5: DR, Change SWS usage to debug fs
 seq_file interface
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Hamdan Igbaria <hamdani@nvidia.com>
References: <20240126223616.98696-1-saeed@kernel.org>
 <20240126223616.98696-14-saeed@kernel.org>
 <20240129205529.GS401354@kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20240129205529.GS401354@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To IA0PR12MB8086.namprd12.prod.outlook.com
 (2603:10b6:208:403::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8086:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: d3388718-e29e-4ebf-6c2a-08dc21fdf210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ieTFnMoIkyHlRzDg9nsRqkBkROXMQbyWxStO88Y2h5I3sNioXSWB9N2IotvPqBPkQZYg4RAYHFUba1MRjy7pP1ZSTQhyuwjoGRyQnmVt5J9+6V7VAtNlXM2bqmNJwQog76srkN6FEY/d8gM0jUbBTcPCYGEjVUKLOa9kFtZqqqL0cBIwYRgO+VfSRh0n0IdVecZoZ9lpCc/ylwKdywM0cH0AYDKCUsZCz+NVqHVRtYPLppBW5iMTnNOtQ+HyVDBcHf66sJWVuIyMI/PCIkxs9uwNYFlcVg7cOozk2ZX1KLqBkNXyWKw+t+CHxTkUX+r5rqy3UAAm8pNnrWU9dCR7LtrmAr0wCtIAptWIzy1esARhul8663FmYA/XfZ7NaS2NsIIm3UcnSzZYGrVRxGmcc92jiE4Hk1hSyYfv9r6zeOble7PcWAPVEH6S1EN+qMohIsmw9CR5x6jMzaq3JAwONsLdpk/54doX498ksAoGrAaS6MmwUm/jLXCQXnrfiYeEg677l85/zXOa9k5BWAU6aPk0+4EOrYLrQVVwk6j5/+zELYmE0WfzeY+LbHG5OB2QlfPf6nEHGjM8xCbN+nYhiBcjazvdC+/PiFaPWB1XxmF3C+NVeJRjVXE6H98ZLSCyx2kB4DDyx0YI3nD+fx+LusRi3WxEb0ioInKD6vcM3zlllseNwD4zKGgtEX0XzVqD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(31686004)(4326008)(2616005)(5660300002)(6512007)(53546011)(6506007)(316002)(8676002)(26005)(66946007)(8936002)(6666004)(54906003)(2906002)(110136005)(66556008)(107886003)(83380400001)(41300700001)(6486002)(66476007)(478600001)(31696002)(86362001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEJnMnhScmRycDB5ZHhGeFJJSlJwSzA2SGVHb2p0RUdKaGJYUjNRYS9zektw?=
 =?utf-8?B?cS9pWG9LTzE2SHd0RDRBdE13c0dGRXZUbkVpQmthRlRFZmFsZGsxYlNRZEhC?=
 =?utf-8?B?MytPVVFYVDZzWDR5RndvSTlMSUxTUTJGMmZINldYRkFZNG1CREoydEs2TnZE?=
 =?utf-8?B?Zys5WFp5S1RMY1FYUlRZcjlSL01ROTYwT3I0RnB3dEVFOU9yVWpBeGFEdDhE?=
 =?utf-8?B?eVk3QlVXK1ZKTXN5NmZEN1cyek0rQkp6OHdXSEN4OTZyeFppVDl0QmJrTUg0?=
 =?utf-8?B?ZkhjNHlWWmswajJlTjBxWjZ4YnB3VktYWVlCK1p3R3F3WDU2cTZYUFQzWUZK?=
 =?utf-8?B?R1RRWXE4SklhZHVyOTZwYk85MTRYWmFiKytrRWllcWpyQTgyQTExMlFDSEJD?=
 =?utf-8?B?RFpmN1Jjc25jRjdaRGZLc0ZicCt1cTE4K2sxRlJTZnRyMjFKS3VVWDhCK3Z5?=
 =?utf-8?B?eWxyUlkzUWlFeHhkQnJ0TDJ2ZlVxY01NNlMybVZ6dGpNam9waE9ySnNpUURZ?=
 =?utf-8?B?UVRHOHNhMW1SaHB1Vjl4S2dBYlNLSUw1K2JWd21IZUVsN3pla1pPK3VzWHVi?=
 =?utf-8?B?MFpsUVd2enZDNUlPbDdoMlVmZ2JMVDU3ejZ4SmpYaW1LQ2h2SllBNWNtNGVZ?=
 =?utf-8?B?WXExamhQRTJ5TmlhQnJPTS9sUW9NVGxlSGdqdUZNbXZGTFVQM0l6YTVWdHJF?=
 =?utf-8?B?Y3ZPVk01Qm1nZ1d1NDZVRHZIbGxPMS91REw5TlhYN1M3aVRPTTQwWEFGa1B0?=
 =?utf-8?B?OUpGV2c3Rzh5YmhYdmxydzByR00zYlZ3QU44VHlDVjVYRGVmOUJSZVVGbldY?=
 =?utf-8?B?aVpiVyswQUJDSmlEempNRDRiL0Nucm5pT2lBTExyb0x3NjJUOVVRcnJMVEMw?=
 =?utf-8?B?NlJGWjE5bEVqUjhodmE3RkhXVHc2NzNya2V4Sk83L2V4U1l1NFpBdlYybWFr?=
 =?utf-8?B?OXoxMzF2WGxZejhNeXpRMElyU2prSDc1TVdXdUk0TEZ1YUdWbzZ3SGtla2pm?=
 =?utf-8?B?eW1yQk8zVjlTMlVGWGF1WHpxVGd6TFhwQlJJMXBBZU1uWExtYlhpeVdVYnd0?=
 =?utf-8?B?MjVJMmF4Q1JBQzdJUDZVWFdQTTBHamFzZGRoR2FrSWhTem9qdzhQVXduc053?=
 =?utf-8?B?YzVCMy9vcEhEcGJCKys1MjNqNVJHMUdWUjA4QTlUSi9LcnA5ZkVXb3l1WUlV?=
 =?utf-8?B?bjRkbXhzNFZPVExkaTZlaGlOKzVWcEp3cG5lWldORlZUeHBkUXlqZWp3K0Ir?=
 =?utf-8?B?SncycVBPVmdXdWVSSkR1K2ZUTkwzOGFqenJyR0VkVmcvVmRjSVJ2YS85Qkgv?=
 =?utf-8?B?MG9xRm9HWWEvQVBoNFlJY1VxWGFzemhZSDZtYmRLelFYWnp4bU1TY0J1d3R3?=
 =?utf-8?B?cjhEZlAyZDdxVTBhL2puUFBoRytKWkF4SDhtVzQ0MGY5U1RONWY1MFZqRUVh?=
 =?utf-8?B?NFlpY21oMjJNaGgxY2s1THRJZ29DQ2dGR2VaYVpobWRwRW45UzMzKy9ZeWZB?=
 =?utf-8?B?RDlLQU4wTWpJSEZqb3lJSjY0MGFVRktFcTFiSWk3V2VlNDdEcmNTRE9QVXhw?=
 =?utf-8?B?aTFLUW9xMEFGVlRMckF6NmZqanVSSGJxdDNDVW5IYVU5eWVDTnFLMU16QTJP?=
 =?utf-8?B?blkzWkp2VWh2VFJxaFYyWTVpN0NidHJwRnpCVmxJdXJoTXJ5ZU1zTTYyaTIv?=
 =?utf-8?B?RVRNWUpuUE5EZ2szUWhpMUxUL2F2a0ZTbkdZSVdZaW1MZVpaZVhJUXNmaktY?=
 =?utf-8?B?UUxndWtWT1Vkd0xqTFZFY0MwV0dhQmFBOU44b1NDQjY0UVlxTDVnNnVSZWR5?=
 =?utf-8?B?bnljSUU5alVsdGgvZndWWU4zc3laSFdIRnc5S1kzOGJGbEZtTFVMVUt0cjNT?=
 =?utf-8?B?bnVKVzVXdEU4NkNnL2FZTzg5R2FGYlFsQVN4c1hrSFFUL1V3MDZ2UEtjbU13?=
 =?utf-8?B?TFJydmMvRWQvVUM0bTdWY29OUTIwSnVxNm9FeXNIZThWSU9ma1p6b25kb3lQ?=
 =?utf-8?B?NmNDK3lESGdYeEJXLzU0MC9GMHZjSnRlVlBoU1o1cUxmaVYvbHgxbXFxV2lV?=
 =?utf-8?B?K25zdkJsdWthSHYzdWc4aFB4dXVvSmlUVUNDZ29McFpCdEpRYkdkbHRHZURv?=
 =?utf-8?Q?1R7Gaj18aRDIrxs55TGRoZwDO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3388718-e29e-4ebf-6c2a-08dc21fdf210
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:42:55.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52Eacf835oCvLqKO41CSzNqlhwYJuP3gR6lqQf+cOn93rwejpFMkbsd+WexhR6OHKHc8vRY5Mwgyhpu+0cEp5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

On 29-Jan-24 22:55, Simon Horman wrote:
> Hi Saeed and Hamdan,
> 
> I am seeing some warnings which I think relate to stack usage like the above,
> combined with inlining.
> 
> clang-17 W=1 build on x86_64 says:
> 
>   .../dr_dbg.c:1071:1: warning: stack frame size (2552) exceeds limit (2048) in 'dr_dump_start' [-Wframe-larger-than]
>    1071 | dr_dump_start(struct seq_file *file, loff_t *pos)
>         | ^
>   .../dr_dbg.c:703:1: warning: stack frame size (2136) exceeds limit (2048) in 'dr_dump_matcher_rx_tx' [-Wframe-larger-than]
>     703 | dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
>         | ^
> 
> gcc-13 W=1 build on x86_64 says:
> 
>   .../dr_dbg.c: In function 'dr_dump_domain':
>   .../dr_dbg.c:1044:1: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>    1044 | }
>         | ^
> 

Indeed, there's an unnecessary long buffer allocated on stack.
Will send v2 soon.

Thanks!

-- YK

>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
>> index def6cf853eea..13511716cdbc 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
>> @@ -1,10 +1,30 @@
>>   /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>   /* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>>
>> +#define MLX5DR_DEBUG_DUMP_BUFF_SIZE (64 * 1024 * 1024)
>> +#define MLX5DR_DEBUG_DUMP_BUFF_LENGTH 1024
> 
> ...


