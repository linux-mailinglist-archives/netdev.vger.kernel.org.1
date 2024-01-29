Return-Path: <netdev+bounces-66882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815B841590
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC89BB23F4B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F8159580;
	Mon, 29 Jan 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4pKumu+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB11159572
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567027; cv=fail; b=QHYQavYMi4ftFPs5emD81ygoI18ANmoj4WmZeXykwVaMhuiWe3+PYoS9jI5/PYPN/vmmWvOnJX1tbP8U+ZPl3lAkeH6QzLFKO5xOd0aqFRih/FFt+kbAjTO30zUiK03BQgMxNzc4NlEFvxIeXC4mdE9/tlMu0rzEwR8SavkXn6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567027; c=relaxed/simple;
	bh=DjPulFYebtqFpVH2Z7rOk8mjvnM4r+c9xJqVk8GvHOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/fxB3FCxGqKGOSLQZyUFwfSYhivTs+d66yKUo/AvSY+AH1a/Driu386FWnyECXVYbcxPL1CozXB3llqQ8QfFZS46nDNsjMFMG8L3kXtd73AnXCr25J82h5s3fmxXmGm48WyfK9oQjMVL3+KafXTo0EibDm3EC+qZiLCcADcV3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4pKumu+; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emYHDgpjoiUTeN/vx1UdyXzFwAcX6RdLDa+TjGvXMGwWv3imaxONcer3cHpGq21G9Ra6NrgJgOpEaOpE0/M6u28ywCWZTXDGyZ8FH4aXhfgDSyYujWs4ltSPtCb6pXygfj1rutkPMOItiUeSIfjlCnuOuMTS5f4KJJ6mu1+NTqh2cEgfrDiWIbhQx16Iq+LymoxpHHznWcpKk/mSjql0CnMaYaY/s3w1qSal4vsdiensFIrr3fKb4rqCW32PUACXkUEb9U8qaMUwLIITS0/SgSuLCOtVEU9aIEDWSKn8qhVPh41NTTH5L6mznMJsTmka4busyI19n06lei6Yro4UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXdZmrgLtgPX5ak2qdcOGXMJ0YOIVpd0fUcZgEN3ooQ=;
 b=NqMmmq/XdIhG0D5WuFhYR0zlbEITx5Q9FCNDad8lLDM47iBluI+lrZ+EHRBOk0hN55CZ3BhvRjiJ6EgrVirgkbDdMa+cZhFibYasLQNa2kL4PlG912fyfvHwd3MaGfIpmw+Qim3YcXYuGswyrtVLLZcv1gmiU8Q01PKtla2wu4HyTotZbKaxxogXp+wjaq44YYFzRla7o0shh9MEzGGmi35gcT1Wd3iZ4XeruFv4ITvoaYwpnfqh+N6rRyz/RnIMlUi7BZRlmRNQKGXmKhYOTx6Yb01IQbn0jUAhIADKRPQB175NZwgnNaycDj+ASnmAQj4hZaH+2sbtEhxdDO4U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXdZmrgLtgPX5ak2qdcOGXMJ0YOIVpd0fUcZgEN3ooQ=;
 b=o4pKumu+wsXlJhKeH8PbkHTbjatX6ljrjoxgvWNnxz0D0+gemXNZ9SAWl+NHS3vxmKEVtlBUzPCp/xc8VWqliQPLkq9FrFhZdEhTQTGoYw0BEbmZpXYPEIpL/WR+kiwx+wSBImFkBnVn0pQjRP0eWTyZ83rpXCqATnt5p7rCPysW8pWcLk/r5bqHEQcPWq9Gv7gv66X30zv+0t3MCIg0p9syOTRTwNX8PlT941c9ibfT8k55bMAv5IpXzYRxllPkm9Ez4rTXVJvNIaudljClV4fHseWJHOjP9qqTxXj0lcOf0cSgiJm7ME1ApZgxdBRyxgzgOzN1UhTC2mrXeaoFWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:23:42 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:23:41 +0000
Message-ID: <690f4ac2-32e4-4889-b1d2-033a86292bd2@nvidia.com>
Date: Mon, 29 Jan 2024 14:23:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: Simon Horman <horms@kernel.org>
Cc: bodong@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240129105604.GI401354@kernel.org>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240129105604.GI401354@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db1a221-0018-44e2-5725-08dc2118f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rnwijBakrqEAoWWLr8L0ytlbURlO7ubd7d7mpitJ74bFifiSClDp3HY57I0CNlWSMvrddqOS1AWrnS02JSQygNo5G7rFMFOMIXxOe8QFUbBv4y4aaIOUtjetYLIu0Ar12nBnaSs3PI0zQhkVOXqCQeuCvty2RSH9d12nURnR4ZxSCVoMcVrpwoQ/ehwjftXXiTIQ46YE19xSq9ajGsHndYD7f1Q1Y766a5eDSbkF5Q0q0QFHKpuFXTvLH8oFrvfuNpZf/pWNFLTlxirA4FhJRxn+ntWOS0oT3oYVRO8u7ugmIkfDcyafud8gSCdza4hHINOVp2MKeOLOAsRlGFhX0q5lcT/Ps3+Or7sRnfDfbtxYuim1VJ8iDUhITTSOr4d/uBWw4SaRsNsIfEHOWI09Fyhfq4rTlVajipTX9Jhs40ZGfOufTX1i37wCYI6SJFrsqBWg82ZW81M/+ZjU3bx2Q6/yeXEyzTPUr1CgthsafagyJDMWU2RV2POFv77tqwkGWuZ0Xl1HVjqeQsAcMdLcwIaHzhwzAgW0rfP1zDfrRX3POMaqQiBsgq2foHnmETSGYzROUccG5K+3YTQhmhnJ9utjTZz9Cyzo/KpA2UNXX8FBGgfmCskqz02S0mvtpmKvi/y5LkbzgqyrigzhuKkQZoSz6L2vgLUWzOdd0HF1HeuHTH3d7hSjUVa1GsKmwb9S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(2616005)(478600001)(6506007)(83380400001)(26005)(107886003)(8676002)(5660300002)(4326008)(8936002)(2906002)(66476007)(66556008)(316002)(6486002)(31696002)(66946007)(86362001)(38100700002)(53546011)(6916009)(6512007)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5CSFJiSjlrTTZidG44K3p1QXlVcTRWNHg5UVVSK0JETWdDV2xzYVZIMCtJ?=
 =?utf-8?B?K3FiWDVjZmhhRVRSSUIxRWZ2S2ZqUzRRbkJSQWUxYllmR0I0c0dCQVJWejhU?=
 =?utf-8?B?Y1NlYURQWm5LS21VYjBZOWFERCtRYnc0T1AwT0N4RC9EaU40TktPR0dIRmhO?=
 =?utf-8?B?dlBUQmdHQmxFNUdsTGVjdXgzdXQvWWVhNjJsNzNsa3BVbWZiYlFZRWJSOG5M?=
 =?utf-8?B?dzZFWnZUcDBmMkh3VG9Bc0pieS9COGduVkoyc3RhS1loWnlFM0xrK2lyb2dL?=
 =?utf-8?B?c0dFVmdxYUZHZHpQNHQ4TTk0MXNTSnZXRy92MDFodDBmcTAxcDBwTmVCb1ZT?=
 =?utf-8?B?NWozaXJtTDZybERibDhSSnoxVXRTdTN4ZFkrbHNMY2N3aFVOeC93N0NxSjVa?=
 =?utf-8?B?WEpSZTc2MFV0aGtYdHd4cnp5V2xxdjIxTU03RzBsMkpwS3c2TUlOQXBIUE9n?=
 =?utf-8?B?azJsMTZjTGtOWVJkRGlIV1g0Y2MxZU5ZYXFXM3ZPbGxYUUFDZm5RMUM2N2pI?=
 =?utf-8?B?Y2ZYSUU1a1RXM0NxYTVDYjBOQWtLa2tjRnVoQmZjb3Rob2I5c0xGWVZhV1Ja?=
 =?utf-8?B?UWpJRG1oSHBISENYWXFHbXRwUlFsMVdiSXRPUWYyS3MxSjg2dmRsWTRqRkJI?=
 =?utf-8?B?dU5GOGs0cGZWSGxQODlad0ovclA2YllzU3o3aFB4QkFTVm1XZ1VoTXZOdjZa?=
 =?utf-8?B?UGtLd3NIVCtNeVFlZUF2WGFJYWRWazhTdTlPckg3blY3YzBkRDlRZ3RGUkxj?=
 =?utf-8?B?NkZoek1nVEJXVjh5OWtzNGJQRW0velBNNmxWZm1pWEprYWpiT3N1NnNoS0pY?=
 =?utf-8?B?a1hsakszY2U3STM5Rng1QkVJNUtIa0ExdFl6bTVPcUl6T3NEMk5nQzBwYllV?=
 =?utf-8?B?TnZCUHB2NVJyMVl1SjJ2R2EwMjdHQktBakVTNjQwT2VoOEI2dlQ4UUxFT2Yx?=
 =?utf-8?B?YVVwcFpzczgvSGg1TlQ1WUtFck5UMlRidGNTc1g2aUhoWTdxZEFlZTQxV09D?=
 =?utf-8?B?RkpwT2lLUmo5TmZ6YXpwSWZaakhLUGlLNkhVZktjMTkyemw0WEZVbnVNOFlN?=
 =?utf-8?B?ckhjL0xPUlBUOStRN1FISzBxZGhidXJwTnRxR0ZURnNjSXM2ZE1LS0s5K2JJ?=
 =?utf-8?B?LzlRS1dvajJQT2c5WVcvdE40U3hQeVc1R3FZT2Q4RENVTDIzc0FtczJDQ0Ev?=
 =?utf-8?B?b3lLcnlraUEwRUk3QUNYWVZjL2xCTWMzczZqYVFxYmk5WCt0MmQyMXN6Z05F?=
 =?utf-8?B?aTFiSjdISEdVK0ZsMkhuZzArTVdwckFlZC9TOUhMcEF5bnpTWFlYWmVtTjh2?=
 =?utf-8?B?cFVsNkVidTlLczl6eWdWMDFpYlRHM21lMzBpTEd3dTNQUTl1d0haL3NuTy8r?=
 =?utf-8?B?WHY2U2IyT2dUWlpYd2dDNmJLZHNsNm9URG9WdVdNZTZVK2FJNVlqakhJOVJ3?=
 =?utf-8?B?aE5ydmtrSmNZZEE0bVJvR1NGaWFqWWVhbnhjL0p2SGEyRWtBQzVJNyttUUVI?=
 =?utf-8?B?QkhEL0FHS2xoakprU2pFY0JuYmErZ0FUblhDYkpYWld4REhDZVYydi9UeXVi?=
 =?utf-8?B?M3NIYUI4RUwzb29wZXlWZFZpNmhnSnVuMlhYWnV5K0ZxR2pPK01GY05hdDJU?=
 =?utf-8?B?cFkvQ1BNekY3dm9GbTBKcUNhQ2VieDNaTkxseDdIaW9hREt2VTVKUCtQaUdk?=
 =?utf-8?B?aDJUdU5qUFRGOEFNeWliMVVib0ZvQlBjcW5pVlduYlNOR1lid084a2dyWjV4?=
 =?utf-8?B?dkp3ZEs5eUlUUnpUTWo3QWltb2ttaWZtdFN2cEVBNmlldktnMWwwdWdXM3o3?=
 =?utf-8?B?Q1kvN0pheDEvTHN1Tzh6aG5UUjBBNUZMeWdFVjlFSWZZKzVsNmxUOGdCZ3B2?=
 =?utf-8?B?QjA4TUlCM1I5RGJWczRpN2duaXd4ZGt3MVBxTEQxbXdraEhHNmY5a2FyRmky?=
 =?utf-8?B?OXUxTzQzRjBEdExHWHFMU2JDYVBaMHlkR2dVRk9ySkNaNmpCUUh1YTU3d3Z0?=
 =?utf-8?B?YXVkbWJkSXROUjJEWUhZdUNzLy9sS0Y5SmFNVEtqNDFoZ21SL0tKQmVDVDZo?=
 =?utf-8?B?dkpUMHVQSFpvK2hMZEZ0K1NOTXpsaDJXVVg2S3pydlRoRFk3bmVBTWNjYnBF?=
 =?utf-8?Q?aSGGkwahSDDXPJQy/Exgq7ELa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db1a221-0018-44e2-5725-08dc2118f2d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:23:41.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp5QfwtizDVpzLaVQb6JZJvDSP6G+MSy7qg0dQrbcb/u50PAbJ83/a1k7k1dCAOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797


On 1/29/24 2:56 AM, Simon Horman wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jan 25, 2024 at 02:36:17PM -0800, William Tu wrote:
>> Add devlink-sd, shared descriptor, documentation. The devlink-sd
>> mechanism is targeted for configuration of the shared rx descriptors
>> that server as a descriptor pool for ethernet reprsentors (reps)
>> to better utilize memory. Following operations are provided:
>>   * add/delete a shared descriptor pool
>>   * Configure the pool's properties
>>   * Bind/unbind a representor's rx channel to a descriptor pool
>>
>> Propose new devlink objects because existing solutions below do
>> not fit our use cases:
>> 1) devlink params: Need to add many new params to support
>>     the shared descriptor pool. It doesn't seem to be a good idea.
>> 2) devlink-sb (shared buffer): very similar to the API proposed in
>>     this patch, but devlink-sb is used in ASIC hardware switch buffer
>>     and switch's port. Here the use case is switchdev mode with
>>     reprensentor ports and its rx queues.
>>
>> Signed-off-by: William Tu <witu@nvidia.com>
>> Change-Id: I1de0d9544ff8371955c6976b2d301b1630023100
>> ---
>> v3: read again myself and explain NAPI context and descriptor pool
>> v2: work on Jiri's feedback
>> - use more consistent device name, p0, pf0vf0, etc
>> - several grammar and spelling errors
>> - several changes to devlink sd api
>>    - remove hex, remove sd show, make output 1:1 mapping, use
>>    count instead of size, use "add" instead of "create"
>>    - remove the use of "we"
>> - remove the "default" and introduce "shared-descs" in switchdev mode
>> - make description more consistent with definitions in ethtool,
>> such as ring, channel, queue.
>> ---
>>   .../networking/devlink/devlink-sd.rst         | 296 ++++++++++++++++++
>>   1 file changed, 296 insertions(+)
>>   create mode 100644 Documentation/networking/devlink/devlink-sd.rst
> Hi William,
>
> a minor nit from my side:
> I think that devlink-sd should be added to the toc in index.rst.

Hi Simon,

Thanks! will add to index.rst in next version

William


