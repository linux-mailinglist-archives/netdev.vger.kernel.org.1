Return-Path: <netdev+bounces-71543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FF853E97
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01509B2A5CD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CF62158;
	Tue, 13 Feb 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZjgrMhI4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794C62162
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861896; cv=fail; b=nPozkJPwDwllPEXwwEt12+4DI/wVKXc4eLoEDdKvYxNYDX4wXplZuJjQ/+xLGzoJD4eUp1fZKXCV/OuR54NHy+tv8tGKWYxhdm7vNHxbstdOnMrP6avNhyyYDIjaLrE0vZUIkVSynYID21bZ/ICSd258AxYh1OtGcRSuE0DkTFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861896; c=relaxed/simple;
	bh=6pHM/4Gc01M8po0nT8mvB4bxBlEvLPJXVSQ8YfJ4KHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8hQ3BkJL8Yb3B5BcqPF5xJy/r+cG6mKIxBBDDwrgdbG1TU5wXC5HKRz/sd1sqQqBAhtLmgTcCi+Ac2/cp9Y56bsd7UtanB9VU1v0gkbqpu9yT9bS6ExlC0vtB9s72o/j8Sn3W1u9hfGJQlCblo+IVPscptaZaUWRPwfchMQNYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZjgrMhI4; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQqmTDli1kpzshRVu6cbvZpNr6hg6XR75iKdfcJXCZSzFcW2lLVdE6PscsYJYzLVrvmZiXArF33Hy8i9H2+uBL/lTm5pqyd4IQN23yJa0+IrnxVebo6kAtEot6WVk1qk8ztxpzQDA9+PWoyWOcGczCgrq45F+ahAG2mxq5bXhaQfCAyI9mQ7TgU7k1RnR+VSiPCumx9YnJ7bpBe65cx35yDwqhnGgZP0bc8wg8k46PQzNmmp83gTJIBQ0GsyocEwCqHa+kR+yaZsBErIS/3oNAv5pJJ9cbCHLoheZjIw0ohu+R/mCh6v28QhdAiB0O23mX7KifDStajt6qqBIidDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvR7s4BlaWfCr8ATeH5Y9jMzvWa+cJohzaSGLingLAM=;
 b=UAPVZ5Vs3b+x3BYeSxXQJo6CAIJq8uIT5PtVwb2GgifSikOoJ1C7WkIXXaQdM45mvUC5+h3Evrhf+ECEig7Fm6HJ2WSD0wKBDUzANP25w2q39apQnsKsXznKKrZyejU2ouQnVFIy3bUnG21aUDyVA5kE+7bsJEzxnJHw9M4tn0sgz7otu5UY50Rs2kmVLi+5GZ89ZXSRvc1e/p+4+1pqWFbxj32URyzxhZSx6MP+3U2ORUoR0lJVBaPEHJXn1bQpH8vNi6G26QmLKFtJe1fKzcXXSI2QOW/gWj/Ks0P3MweuraKOWuJZ002V9MObktWGa4K6tFXomk7vlHPeXG+mPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvR7s4BlaWfCr8ATeH5Y9jMzvWa+cJohzaSGLingLAM=;
 b=ZjgrMhI44v1i5mrWLbgrT9RmBX4AA1mlMq6FrmjIS/58UBzN6+MRAwI81Rb8/DFVGZhIkjbz4yyO3sqnH0PBKvL0/cjq3a87QoURZUpDse+BFY+G8oYmAWb4KHWfH+AsNsAQE3GsKUXoxVGlO8QA3Ze23ZGpqrxd74NX+2Afvnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 22:04:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 22:04:45 +0000
Message-ID: <5b42afd1-1af2-453c-8260-c40f6abacf94@amd.com>
Date: Tue, 13 Feb 2024 14:04:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/9] ionic: add helpers for accessing buffer
 info
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20240210004827.53814-1-shannon.nelson@amd.com>
 <20240210004827.53814-3-shannon.nelson@amd.com>
 <0a0655c04c98c56eceb8ca6bfe4a74507978a4e4.camel@redhat.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <0a0655c04c98c56eceb8ca6bfe4a74507978a4e4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cdf691-d165-4efc-94c0-08dc2cdfc9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CtVu4ujaVHoVg1/PdaDfmpKMPdw4bfPg1cczLvUbLx2hX+eR+l5x339IB2bW5ch5VftDBptq0evv6Pi3RnIkhqJLdB3gOsei4p07XSU7hoQaSoHR2on0etxSw3IT1L8PBm1ujTj0Pn/rewieFngHqEoXXMBaGJ5sWihNSxXNbR8wC0nnZkjZOHj1pM+ULvUPEusXoq7yoCKMW5W4IcuyqD2g97Jdy2g3TgBF/V5fHo4lYP0kynWY5XHvLjgWZ5jlOJ+c7EyCrWhKt/O9u03NcBevMGfzP/rZgyRQpmsv6zXP4+wlvR0gvpGbvhFs9NlBM+UALKdNsIuSHU477aLcOgjdnR8Xx9nk7S9zJpkOVRdyGcMbCtbMkvfYjpmmOPNNsopKFkyTyOxoxb4pyzrGbv3gfV5gHbQYKx7tIY9bA7Z1q80PFWs1Nsxa68/VoWeB5CtZtik2KQSkMF1skxM+/O/dhjWWoLzCQ1R6R/YgkoPGICHFVeK5NnjPbi3xHlYVBdVaAseF/PWSM0d2ktV9PiYWcA1/bdom8p2xDCv57cAYeWBPQM3adCUYhhMucjQX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(41300700001)(8936002)(83380400001)(5660300002)(66476007)(6512007)(8676002)(66556008)(4326008)(66946007)(26005)(36756003)(2616005)(53546011)(478600001)(6486002)(316002)(6666004)(6506007)(38100700002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eExneFlPOUNZVVBnZU5EUHczRlpDdkk1STNNQ0RQQ3NjVHl0cjRRQzJoN2Yr?=
 =?utf-8?B?eFBYajRXcnZXaENqOEV4cTZpRm1wRWw2QzBOL1ZoU2dxODI2SGFlaHNkWkJR?=
 =?utf-8?B?YjFSSXdMUWpoUCtNYkRza1pVcDRHcDNSNzdBUkNrODRySE9ZdlNGSEFvcE4v?=
 =?utf-8?B?dmlZWm1KOFlzaHJzQ2pEcHcvZVBqZGlZMXQ2WlJOSTFxSHJUVG5aV2ZxWUVD?=
 =?utf-8?B?KzEvZGttOUpYYTJ3ZWIycmVyb2lJT2xKNll5TlJlMk5sTzZqcVJOM2U0Qmo1?=
 =?utf-8?B?NmwxOHNPQmhVQVM0MXMwZlJiVnVYU0ZLUG1XektxSGhTMkZvVmF5cEhvTmRL?=
 =?utf-8?B?SXQ5cytUVlQ1a2pxem5TV3ZZQkdvU1BmenByUmd5eVJ6NW15NjNmQVFCTDkr?=
 =?utf-8?B?S20wdytYTmdRRk9WbllCZFMrR0pxVUkvcnpmRVY3MzBwbXljbHArN2NDYlR6?=
 =?utf-8?B?WDF1RDR5TC9lZ0tOK3puYTVEVGUxUHJCNE9JS01EL0FkdnBPS25Rd1FTNHZK?=
 =?utf-8?B?SXZDVVNWM0tBbjNRYmhzWWNkaHM4d0REeW1KUjdMMlJjWU50WWFpRVIycXZM?=
 =?utf-8?B?bUpDdFNiSFBheWZCU3dzWlJ6OTdDQlhwUEovTXFTTmdKWHVISG5nOXdFVnBM?=
 =?utf-8?B?bmIvSTEyVFliV0p3TXpXcUhGbnY2MC80VkkwdlVsOTd2ZFg0TXIrZVR3VERK?=
 =?utf-8?B?K3lOV3RReGJWelozME94TnZqK2VBNThFM1R4NzB2WDhKU2ZqelFkWVZkUkF4?=
 =?utf-8?B?QUdMUkFiRVcvR3hBbXVhcFNiNFp3alF1STkxaW1Ub0M3bWwwTTZHQm9nb2hh?=
 =?utf-8?B?YXIyTDR3OXZ2a0srWEZyUDFjODRkbkRHVWp5SFhwMFB5alh6TnhnNkZ0MXdQ?=
 =?utf-8?B?aGV2cEh5Q3FPWTE2V0N4SzJQRnd1dFNjdG1PUkdKcmlPbWhNUlRyZGQzOGZG?=
 =?utf-8?B?NFhVb0psUmVvQ0kvcG0xTEhiSkpOcXBQaGFSTEloYjlZK3k0REdaQUN1NVhR?=
 =?utf-8?B?cERrOEdFSDhHWDRzL1gwQjNNYmt5YXVsOStMUU1LWG1LNGYwcWJBVk5iaVpU?=
 =?utf-8?B?WWp5OHRCSk1PdzJadjFvcWl4YkhXNXNYdWRqT2dQTnBEbU9WWGZ5ZlA5bHJE?=
 =?utf-8?B?RXcyTjNiMnEwMlR0RVp1OVpNak9FTXdrV1JoWmxJQmtYUFdOQUc4cERoVkdL?=
 =?utf-8?B?Z3FndFpaS1k2ZEg2SkN1Z3ZvdDdoV1NtaEhsT25sc1l2Z1dKYzk4Nmw1R1lT?=
 =?utf-8?B?N3Zrb09lWkpwNHBXaU5qdW5jbUNkUHExbENSUWJhcGdNdkQzRVhWS2xqSDls?=
 =?utf-8?B?QlRJV05Sc0FiaHpMZUVUS2J1NEdtU1FJV2lGUkJUMmpIQ250Q3VkMkE0Z3lK?=
 =?utf-8?B?c3ZobkM0Q3E0RXlOWTVCanBveDlzK0t6UkNKMllFenp6blJiV3pnNnMzT2dt?=
 =?utf-8?B?TS9WMU5OVFpha2ZiY2hkM281K01LaTgvNlRzUzl5WnJqUmI0MFdnNys3Zndt?=
 =?utf-8?B?UkxDeVRPNnZaWDBYTE5qZGsxSWUwdUNQMzR0TXVQNEwyS0xsM0FoSDdRWE5x?=
 =?utf-8?B?Z1MxT3RBRUUxeDdLdldSSG4zalpMaytTZEhob2lmVmZQNkR2S0FYYkRkVVR6?=
 =?utf-8?B?REVyUWlvOGh6dlVma0JpR0xQRm0vSWVTbTRGUTBpQmYzcTZUamoyY3pYVkFF?=
 =?utf-8?B?UWxyOWlFYmFTbE9KQ05IY1JId2hPejN6Y0xDb2IyMW9CUEtEVVdHb1ZiUk4y?=
 =?utf-8?B?NTFOVmRnT3lXTlFkU083UlBxSHc4MmMvRXUrWW4vdHNlVWFpellwaHlxRG5Q?=
 =?utf-8?B?VlR4UmV2cTBYaHhQMlBkQml2cm5nMGpaUy9kVy9RZUhyYTFCd1pSL0hqbFFD?=
 =?utf-8?B?UjBucEpCWkxXUjhUWHRJOWQ4R1VZMHd6MStoKzZKOHBSV0FTMlA4SjMzdVdT?=
 =?utf-8?B?QVFKVFA3YmFqN0xGdXdJZ0Q4T0NBVVJ1MzIvNFlQMG82bGNJSjc4MlhXak1v?=
 =?utf-8?B?YkZydk1OaWhFYWRIQ2lqZ0psTmVWWE5EQVc4b0tkTkxVS2EvWXBvNGJTakFV?=
 =?utf-8?B?SGFYd2M0MGZpdVc0SitDcU55UDZqR1VxYU9mdHg3NDczSDhEZ0tGeVM3SWM0?=
 =?utf-8?Q?rZHDcIgKuA2a+G3/rZzdMW2fi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cdf691-d165-4efc-94c0-08dc2cdfc9cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:04:45.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTN2iFa2s59nUorAFILRo7ZIkeAx9ERHLZ/LDge+r60VcjjUUz+hwSs3a8ZyPDMgpSmyKaK392HDMwpwtv55Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

On 2/13/2024 3:12 AM, Paolo Abeni wrote:
> 
> On Fri, 2024-02-09 at 16:48 -0800, Shannon Nelson wrote:
>> These helpers clean up some of the code around DMA mapping
>> and other buffer references, and will be used in the next
>> few patches for the XDP support.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
>>   1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index 54cd96b035d6..19a7a8a8e1b3 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -88,6 +88,21 @@ static inline struct netdev_queue *q_to_ndq(struct ionic_queue *q)
>>        return netdev_get_tx_queue(q->lif->netdev, q->index);
>>   }
>>
>> +static inline void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
>> +{
>> +     return page_address(buf_info->page) + buf_info->page_offset;
>> +}
>> +
>> +static inline dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
>> +{
>> +     return buf_info->dma_addr + buf_info->page_offset;
>> +}
>> +
>> +static inline unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
>> +{
>> +     return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_offset);
>> +}
>> +
> 
> Plase, no inline functions in c files. This are trivial helpers, you
> can keep the inline keyword moving their definition to a local header.

Since these are only ever used in this .c file, perhaps it would be 
better to simply remove the "inline" tag?

sln

> 
> Cheers,
> 
> Paolo
> 

