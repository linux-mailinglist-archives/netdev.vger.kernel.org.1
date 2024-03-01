Return-Path: <netdev+bounces-76657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8886E727
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B890928503C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419A8832;
	Fri,  1 Mar 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJCqF+xs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844D8813
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313928; cv=fail; b=eqG7QbIupCiXg8olN0ftioelkUNpCjdW6yVIWKrzNHminzYHXlWZAup4kxYf44r+hn3HGJq97njJYJlbNQzC1tfwrdvS+0u38n1s+fXklN9z8qxVJDSkYuIQW1l/WsxFne3lVRhufcUJidadVtBPCzHG/9K7AhKZnFldztcm7FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313928; c=relaxed/simple;
	bh=/Aklh84lD0IUIr4/1ythCZ/oGGZ/wgZTtpzdTmfpf7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maGq1h5HcIPq33/AQFqV+04fbsgFTkaPnEZvjUIdQ+j+hIX7yrRuhn50b/wDXBhAqEOVtRWEQZJux6EICU9muscUttYh/a4W8aq8bpRRU0biwnJHZfceLkJ93H+4WLclML8ajZA4trGAMC8LVIuNLW8TIqm5R4A0DCtLYkmx01o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJCqF+xs; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx0oNho+PNmvSHq0PoFyFJo79wQ/tZd7rhhRVrcLXfldhdpxuoGlNwhJPpiGlYsbxeXMCEObm9WxogzZg10pKaF0KGZVqaQcQKA9GGis9jVtjfLL8RZjRXUxaX5P/F9VJmBzGMj9+DXcV1JNheOm740w5mSR1bB9gKiyQmpwAx6/887bbLbIAKsc0a3URkpNA51QdyiE+7phMJmhJt2C2niALCpIDvPOh2T9OMMcQe3Hvm+/1EWVV8RCebafsv3Z5nLbh8dQcAFezz+7GlZJNck9os1JtFBrTtTEc+IT90PwuV2QLYqhGj/9jEmvXUvr28NPYVYEeuLQjjjStXozrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJrNoa5JYl/RoGh0AWaI3uovSXB8dh1/Tm7gBVkJVJ4=;
 b=jXB/kMTjkPih8+czagxXuabsd4DxM0ETZ1jimIMJ4iOSdCd1wdbKblV4bZit5NzEKVvg4IIo9q7OGnA+zakaQp41GdkTcUQqagip2CYUfqAJpnhSw3ojCA1khHrCSRoFPzvpPLP8l/m+n1dTyx7cHjumLIjdk50Yf+1iTPKbO0DurUbMDlV2FSlTh3y023QFrYgeIa2K4Gj4OyyYkqYrrCBRRvEkkbYu1nrKSaaLfttGfQMBoPqkvgnHKxwcCR+GdymNGrviFLI6GlpkvAkaJpygxYrU70RanDHQSO6N5/T069Rij2qJZFY1E3UYR28C55qL4p4JCpAz+CIiCo3nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJrNoa5JYl/RoGh0AWaI3uovSXB8dh1/Tm7gBVkJVJ4=;
 b=EJCqF+xsfSHButfxcWSUQJjataDkvNubwB+suOH15c9SUucUIdhEhsfrDGGQ0a+3t4HVJ5l6gHfUr33ShnhmVb3T8uir10oS27QIUSCzVlPM6Xlaeo07tbY7GyKoZBGQxWynHKTD3Zw0IzTFdAeKkoFP3ajkZGum2e6qUzpwYswp7Ci2F7A9DXq0YVJeEj/hBPA9j32MJH38C5AICIrEGekQru84YEaZJxWSS3ucQlHct7qYMqPfdoFKeyOc9vorzuyThfVw/2oprY+fs81b0/OPHGhgvwiiuSvDsHdxPMJBWYNoI0xdOu7DLsGuzJiPEE/sDC9HLZSEixgV9uG/dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 17:25:23 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 17:25:23 +0000
Message-ID: <b25bfe54-f3c7-44a2-8c39-d32a0d5f3d47@nvidia.com>
Date: Fri, 1 Mar 2024 09:25:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, netdev@vger.kernel.org
Cc: jiri@nvidia.com, bodong@nvidia.com, tariqt@nvidia.com,
 yossiku@nvidia.com, kuba@kernel.org
References: <20240301011119.3267-1-witu@nvidia.com>
 <91629dbc-8fce-4f58-bd9b-b37293c220b8@intel.com>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <91629dbc-8fce-4f58-bd9b-b37293c220b8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::30) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: b5637dbe-e55b-47e8-f4e7-08dc3a149408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	shuQYP17EY4i9cVmLtIvx2HvjCmmJGUBklYVm4zeemSGJTvQIetKcWhZXyUDASKooUFNv3+Fr+b9lSa/EROep+iMGUBn4GVQQAGf3Ct8s0ojK9bPnCKpFZ+inNx+1XQgeKaMpxsG/M3OcAONNfAvZnM1ktYirUx/60w8/z3mpyRz9YgE5sErkMZlvH5xxgQdFFhkDgPNHVwmjJlH0RdOB7OBD001z2y++ggbcwTDDfZdd7DkD9mx9reuyBfOczm3w9HYTYmOcrBFamkUEeTkydZOH/kwrm2/qN8zRKaxrGiHTGOW+3x1QkcYm24Oi5u0ejlKEHHeNWlHklq+S/Y3hxa7YGyke++Ak8kbrYwAViRTNgUWHJjGOe6Qrb0Osc6dsB5Qo1tQIZb4DCAf3DJFrOp4kSdsYyhxn1awnvRoQzVhSU5hXw+03ONjRtGkJFiGUmb0jsKoORfzoIs2YWckH9zYmoGI9se5H+LvtJCTYWtBIfRBA/hrFY2u6Ui5MAMJgDuwwKfQHycub1wVP/DBZn4Y2xrTm+YuXvPpGgZcUmixknliAGLeOvnz2MpwxyGaxdCOOVDkWsM9nvsecFLrOwF8AR5aHcMBAIIeO9l/Dl2FPziwlmt+l7HaNNsY7cvvwZhGtSLe9zqwKeOrj7wbHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWR2aXZVNWYzQ3doNk52cExkV0hxRldaUldEUE9jRkhxa1lqbG56Mm0yUllt?=
 =?utf-8?B?OEVsUUdvL2lIQTVjeHhVWFZ4SzdLYmVwdnVyMXNJR21DcXpNQ1ZwdXo5b09y?=
 =?utf-8?B?L241M1YwRVY0Y1FWZTgrRTcwdHR0MTR5MkdmbjR0Q1JDTWEyMFJrWlc2VDBr?=
 =?utf-8?B?SC9DQm41YXpidmdjOUh6bFp5Y0FlQkllNjdoWURmdWRIMFAvV3BCeEk3Tktz?=
 =?utf-8?B?dUpZSTlwODM5bTY0RUg0Wk9xVEh6Q2VKUGREWHFxZ0VDUG5UbHRCZGo2RmxT?=
 =?utf-8?B?Y1lwTlJPWGVCQm5DRmtqc1RhdXgya2wybk1Ha3VML2xhc0s3Zy9xc2JMV0VM?=
 =?utf-8?B?V1ZjdmRhU2NybHFpWEpFendmbUZPTXA3aFQwS2Rtb2pxSDRjeHhKSUprcW1u?=
 =?utf-8?B?OUljSjVFRU83M3g1UFV5ckJhQ3NGWGdCZVhxd3BRMUtnMmYzS25tMkh0OWJD?=
 =?utf-8?B?YXhBU2pMSUY1Z0ZEWm9WMXZ6WVQyRFg2SENndVdIMkhpYXN0SHpOOFNqMFg4?=
 =?utf-8?B?UkhESWcySmJ0UUZ4R3lTaFY0eWN2TkMwSk9CTGV2ZlRkZUQ3dU14OXM0bnVt?=
 =?utf-8?B?VG1XUzBQQW1MYUQzWWc5Z2wwNHdnc1RIT0c4dGYxUkxyOUROT01LZlpGd1Y5?=
 =?utf-8?B?enZZZ2J4K2dHMWdMWkErbmxmMm80MjJGMkloY2hjQ0o0R1ZodEVxQzVVUS9F?=
 =?utf-8?B?YUk1ZWk2WW9HeWxlRzBYOXNjcGF2NHNBMkxsZElLaFRwQ2I1TklFVjhpT1pB?=
 =?utf-8?B?K3p2c1Z4bzhFWFc5MEJ4R09MV0NYbWdKRnVLaFdscTdaSU1TRWdycUlRc01h?=
 =?utf-8?B?RlByaVE1N0FjMkxuSEVJMzFwZFUzYWFTemRCdkJOWE4yTjJqZkI4NkoyMGRW?=
 =?utf-8?B?L1NBSjkwRGJka3IvSm9LeFR3K2l1WXlzdWRaVlNjeTR0OFhxK1lXRTZLenZx?=
 =?utf-8?B?TnAxNEQvM2p6L2ZCMnhkUmZwK1M0RjZBSUNYWjJGeHhGWHN5dS8wWkxWN0tm?=
 =?utf-8?B?R21USHhCemVMNTlMWjhORVNNdEZlSkthS0k1VW55RXIwb2ZDbW5EdGpwVC9u?=
 =?utf-8?B?cm1pSWp5QWtQSENUQWhiNnpOQ3dlbEhFa1NtRTlxK3d1b2FXSGhhMitHNDhj?=
 =?utf-8?B?bkpJTW83NFV1RHJDZUNTanA0Y0o0VzlpTnk3MExmTnQ0djcwTHlQTUtVOHgv?=
 =?utf-8?B?c2RUWUo1TzR6RWJaVUN6OEpEZGc4RWZLUzk3eCtKM0c0alllTnRicnBaYXVL?=
 =?utf-8?B?anVHNDJMN2tvdFN0d0ZJRzRKRTVUVENtM3lGR2ZvOEY4UldKQkNOcEVOU3lG?=
 =?utf-8?B?ZU9pVmxjamtkNkpHc1JFOEhhbWhSSFVqdDNMcHRZM2JZRTZ3QU1hVzNMcXIv?=
 =?utf-8?B?NXFMRkRORk5JS0JNQXlRVmltaEIrdlA3d2FoYU1ic1IrZ1NUb0RBWnBMeTd0?=
 =?utf-8?B?OGZNak1FRWdPZnpFTXRYdHNIMVR6UjJlNkw1MFh2Mng3aHAzejM3eUlDUVVG?=
 =?utf-8?B?VE9VQUNmWWVTWWkyRERhbkhEai9KUGF4V1RETVlkYVlJdXR4MGtWZHhyNWd5?=
 =?utf-8?B?YUxsZ01wcERjVTRlSnZDRWJCUjZ1RlFrYkg1L3FVVjBXeHFaNHJQWGRJWDJF?=
 =?utf-8?B?MzBLZEFkdjdMd0o1K2hvV2E3bTgrNElkMDN3a2pEcVlZSFdlZ3kwSmdneU5p?=
 =?utf-8?B?cGJYcUFReFcwOVRRbkJEQ3RIVVdUOWFMMk56WnByZDRzb2NUSUhCd0FRSzJ2?=
 =?utf-8?B?dGVmUjB5czhsSS9lRXZQR1VJQ2JGSThBYjZYc3c1T015eEpMMGJqRHRicFR0?=
 =?utf-8?B?cXc3U0VnZUhweHExWmt3MVZpQytBcDhRaHBuN3MrNGJGSVJta0UvTXZ6RGRX?=
 =?utf-8?B?L0Q5U0daUDg0UVVTSndIMEpsNzJhZzlSOXJWT2xWaE9UY2NEUjdsK1FmZ29D?=
 =?utf-8?B?Vk9wZ1ZieUU0d0FTSkhyeXlPQkVQSWc0QnM0eHp5ZmpObk9ya3A0RHdOOEd4?=
 =?utf-8?B?R0FNeHZ5WXZ6aXJHNGZ5MkkwNUo0THlEejdJZXVQdTNlcEYvL2ljTklIa3du?=
 =?utf-8?B?RUtPQ1FHVTB5WWxnbmtUODdnWVFnRHRPb1JGN01DMUwwOG5GcUltY3RXWVBY?=
 =?utf-8?Q?weersKy1T5bttxxEE9NoKpl6I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5637dbe-e55b-47e8-f4e7-08dc3a149408
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:25:23.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slxznmJiXShxp/zCFPQu1aLd0ptJ8HuyJgpq9OnkTsK0etLf7Grec0zK04o7Tz99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496



On 2/29/24 5:46 PM, Samudrala, Sridhar wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/29/2024 7:11 PM, William Tu wrote:
>> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
>>
>> 1. shrdesc_mode: to enable a sharing memory buffer for
>> representor's rx buffer, and 2. shrdesc_count: to control the
>> number of buffers in this shared memory pool.
>>
>> When using switchdev mode, the representor ports handles the slow path
>> traffic, the traffic that can't be offloaded will be redirected to the
>> representor port for processing. Memory consumption of the representor
>> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
>> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
>> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
>> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
>> ports are for slow path traffic, most of these rx DMA memory are idle.
>>
>> Add shrdesc_mode configuration, allowing multiple representors
>> to share a rx memory buffer pool. When enabled, individual representor
>> doesn't need to allocate its dedicated rx buffer, but just pointing
>> its rq to the memory pool. This could make the memory being better
>
> I guess the rx buffers are allocated from a page_pool. Does it mean that
> a page pool is now shared across multiple rx queues belonging to
> multiple netdevs?  Do they all share the same napi?

yes. The basic sharing scheme is to have all representor netdevs' rx 
queue N sharing 1 pool.
And packets are proceeded by uplink netdev, so they share the same napi.
More detail here:
https://lore.kernel.org/netdev/20240125223617.7298-1-witu@nvidia.com/



