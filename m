Return-Path: <netdev+bounces-33956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF117A0EF3
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FA91C20AA7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC0266CB;
	Thu, 14 Sep 2023 20:28:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63A2134C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 20:28:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AD2704
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brHXS2+anfsCv9jZJIueE+FVJxBTqBz7sTL3eSvkWp+xgAqW/ASh1TbATkWDk7CZPTre1hoTYY5sWYDueOD3/9mZJERldJZ6GJNvA0W/ezT93PEOakY6tx9rgcaDdsiUPaTZLzEDWpIi2Xd4s0qLP5kZNF1BiUZTPgg4SDOYh5URtwpxG0af0T5+IFSo7SNwFpphKCs/cK6WIzadiDVyxXUt5liwLn2M47cW3nYGfU+6aT9IT9HRkImMpfulqEvO+5R/iPRzVf39hwkHfQtE5rSJoP15IiSskuZfIvK1zmuNtoKPClaXHqglJNX16sQycjUTzDqUT7BZ8p0OrZQUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6e77Zaqmk9ucX0IKM75ajgmmjrU2FH4k3tsp1rNFyc=;
 b=hjtKw1fACZiHFP2/pvNYcDGFoxDU+DOySH96tXPwzn/IoLiV6MRNmdwJVbXybQs8Az7F3/FVQ7vlyiE0gbpgJ4nzCgo4Rciwi2R3mALwgyVZr4QVKPdwFYaFHIqcyAZ1fuCzpKuC3/jLXDR2ZgOTsAFeZ4SnDaf48cdb2fhUsIJCunJqUo+dsMNi/roWPhZLJjNsGSbtNjYDV5GlSt3AtO5ckJgB5WHazM9suEpV0R3rBSC8SKhrlwrxZEM6N1hWcY8m829PsXKDBp6Hy6DA4ftt3jjSfgh5tWC/AwOHWaZ/jfqerPLtTzMdb9+yUSQH+esNLK4mUdSQ7OMDdAPOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6e77Zaqmk9ucX0IKM75ajgmmjrU2FH4k3tsp1rNFyc=;
 b=S9nsKA4y6EONrbXvEQ6UTiPrgKGCH6TbdpoEujVr29TVEX1zVkCZJl6z9DveNFvnuNDCtc1mjNTwoOCNFjcFXcgoGXi6dFiDbU7P0T1JiUIG5w+ESJ2nfs074j1cX65+40fgPU3zSuDJwHxFUJpayoSRIjPjfvX5O3NPTZLoPe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 20:28:36 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:28:36 +0000
Message-ID: <74e50ab6-2269-49b2-83d8-0c03f359a80b@amd.com>
Date: Thu, 14 Sep 2023 13:28:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
To: David Christensen <drc@linux.vnet.ibm.com>, brett.creeley@amd.com,
 drivers@pensando.io
Cc: netdev@vger.kernel.org
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <a7c39c89-c277-4b5f-92c0-690e31c769b5@amd.com>
 <df083cc4-e903-f122-0817-b1313397e89f@linux.vnet.ibm.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <df083cc4-e903-f122-0817-b1313397e89f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 724dee81-6d16-4830-e165-08dbb5612c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oCn0eTMnsKO6F4q9xwEK3NdcZjdB66CTksabmbEWzizYN0qdY8a0iWA0aCaxKgjLZtzMM/G5WbNCth76Cb0++YSEcf+8+cO2DH0OK94HNGVt3X2f1TB6ttdQDrHY3ByRGvTh4v+Y+OROin32Pjy8kYRPqjFjnsgIgmKDbeUd3Vr323UhiRlC+TSzYUyubmtCig3zuI48NH0I6yJnymM7UkmVPy8KNwxMZex4SoWvQm09iKGgnAYJKqObntCo3xM9BO8SatjQkN8a1Q77BHR77ENBS7dMp8iJ+l2BxnAFMs/J8m66YXcWMbANpzJkNVOdg0ki3ZUFvBg0pJ7sTgs/0WqvZs2gjM2I38imIWpfqK2O26xmDn7XfgWbVXFCVrROv3IohGa+eU2mKqJCEd1b8ikGMO4CJOxCDvGmr5I7JAQL+QKwjRbNGJCFCsJ2ioSZ14nl/vpjp9R2CEIGXOpl43NlfANlrkr530Xn0h0Zc/9c/wsi6qaSgmpvH1xO3ioZWajwvPU3rjFf3K25sSI1oBer8q3r0tbLUI+urxoof8UKRojjizWmFssMEsXGNYDA0IsQbT0oKUQyYoj4rMWqmF59uoeBT/s30DLhx248Xg/TMFGFPp1G6QIsC1uZgtpoP7PSwYmo8Un4jLNRfSXEeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199024)(186009)(1800799009)(6486002)(6512007)(2906002)(83380400001)(6506007)(53546011)(478600001)(66556008)(2616005)(26005)(66476007)(8676002)(5660300002)(316002)(8936002)(4326008)(66946007)(41300700001)(31696002)(36756003)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUxNZm9WMkR0aDVPMXZCeXJkWjB0YTlRYzd3NEJYTExaZ0tTN0hkWjBZUmNj?=
 =?utf-8?B?MTVVOTBzNWxmRHJQdmlOY3ZsanVweXQ3SnV5WFF2bVhnek8yNGxLa3NMaCtq?=
 =?utf-8?B?SDIvbnhqZUpRVTZSTjZVV3NtTjhBNU5TQlRtVFdSQ2ZGY1FndmNMWW03L0xt?=
 =?utf-8?B?UGhhK0pZSFdheEVCNldha0dKZEpUSkV1cUN4UVlkRENRS0dVWm5nUXUvd2pi?=
 =?utf-8?B?M0JsejVVQ0l6YWdSSjFiaDBhWXFNTGtJQlJFUnh0QmJJa1A0eWhoU0VwS2JJ?=
 =?utf-8?B?ZXdYVUtUZnVBZWZkY1NIQm5YVXYyUHlGTTljbEl6eTNQczdIcXVVUG1HRng1?=
 =?utf-8?B?djZETk1ycm9ick9iZWU3clhWeWRxVTJwbDRBbUlPMXZ1RG5iTmpLT1N2YXdJ?=
 =?utf-8?B?dVZiRndrMk1ERGVBc0t3VThLV2FGbVRXOUxhRU5peFlSb3FKSHlKMW5TRTJx?=
 =?utf-8?B?aWxFa05ld0g4VUpvMS9IaUVLU2hkSG9UUFpZdDB0VWMvWkg4TDZMejJGZkxD?=
 =?utf-8?B?Z2UrQXdJUVZWcFJwVXFSWHN5bVpLTzV5OGttb2ZoM3VWZHFsU2dsd0xwV1Fo?=
 =?utf-8?B?UU5mMk1UbzNLMHhnbU5xMTg1RnJIRzdUWXRBUmN4MGJDNVBOeHFqTkczVzZ6?=
 =?utf-8?B?UlltMjZsUXc0N2sxc21qbHRBZzJmcG1Md2pkQnZUQzkwOGJBTUhNOXY0SUFi?=
 =?utf-8?B?WGZVVUQrUm5ZWTkxaWprc2o0VEg2NncrNWY5eDhoU1BsYzN1enFWOEJOY3Y0?=
 =?utf-8?B?eXA1MzR5Y01la0VUVmZzcUZETG81bDNva2hadU9RWFVJNGJtNUYra0JSU2Ra?=
 =?utf-8?B?K05LT0NPS2xBaXVBTDNxL0pNcHZFZmxRamp3RHByVVd4R3hMVURXNU5vNGlN?=
 =?utf-8?B?VmtmeU5QUzc2Ym1GYzJmMytxT3FvZUxmOS9sRkNnb2hSaGsycVlaOUh1V0ZB?=
 =?utf-8?B?V1dWaVc0V2E5OXhxRm9SaVVwaTQ3VGJUeXhYSjd6TmVVZWlCV0l2SVV5WGZV?=
 =?utf-8?B?TnB0NGZPMU5WNlBaUkZkdGNrSzR3TVZRUmhKQ3FNVVo0WEdoNmI3WDBuWTFl?=
 =?utf-8?B?OTFLeDZRNFpIMTcrYk9wa3lUOWx5SHA1Q0Nnby9NOFp4WkliUFllVVNYQzFU?=
 =?utf-8?B?d3hmZXRnQWRsMGpCOWorWjdRUXRMU0VpSVZUQkt1aVpRVjhFaXdjQ21KQjFh?=
 =?utf-8?B?cHpZQ0Npc21teU53YUNtUXFGaS9YdjYwY2cyekdTUThiektXcXA5QVBaRkVt?=
 =?utf-8?B?ZDZrVHY3MFpYbFFoYnB6bmlqV08wYmJJZjluUHFkTFRxVVU4WGhlMTBUTS83?=
 =?utf-8?B?U3lLaExMSzB6R2dMR0pwWDY3d0dreXdpZi9nVU1RbzJ3SG45NGZaajF6SnVB?=
 =?utf-8?B?aXJsUmdTZ2EvRmJNRkR1RmtzS2pyUVQ5T0pRbVFEaVpXVnlXODhMR1pqUVRm?=
 =?utf-8?B?bVRDSGtSNmw1Q213QWdMNHZJZnZEMDZ3cVNhVm0yNm1vRzNobzlQYTU4Y1BQ?=
 =?utf-8?B?cHdvNkEveWJOYmlUa2ZnUFp1SkEwTXBYVWpOdGdWSk5rT3NrUlV0WlRuMU5y?=
 =?utf-8?B?QUhMNVJRU1poRVBmL1ZCeDhZV0JlZUIxU3RCdWNiaUM0UkVHM2plS09pbElI?=
 =?utf-8?B?TEFTZFRDNXIwTWwra2RoWFVIaWNvUVQ5SVU1M3JrZVdUUEZOMExZc0UvMGJt?=
 =?utf-8?B?TXVpbjJmWTlEVitFTTVqUjNvMGhxV1l5amNCS1dCYk9YTFBrYk84TFBsbEpH?=
 =?utf-8?B?UGl0L1QwMUsva09GZ2JMWm81YVovZXRlOVB6ZTN0cVpZUnY5YlhwK2p3UFUr?=
 =?utf-8?B?MnN1S0Qrc1JndGIwQ05sK2RtNnRwT053NUUxRTBXRHQra1kyYjd3b1pLRWll?=
 =?utf-8?B?dVRzSitEeFhSMU10c29PWDJ5ZFNkMnF2dnQwendlbHJ2RG9GQXhmNDViU3FY?=
 =?utf-8?B?b0pnM20rVVNWY21jbnVTYktpTTRWa1doR0swTkpvd08yNHd6WVN6bzFqUEo1?=
 =?utf-8?B?ZzJOeHNwSk50ZXd3d3FnU1pxTG84SWs3VkNRTFVqOHh3Q1lkQ0hDc3NsN1NC?=
 =?utf-8?B?VnB6L3VjWFcycXh6czJ5WnowVmU5Z3dMdDdwMWNIQ1hXNExtdTBvS1JLNkxs?=
 =?utf-8?Q?RLyG/2l+VdElyN/1zapZgqQKX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724dee81-6d16-4830-e165-08dbb5612c4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:28:36.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaPMg37sJJG2fXbUYm34SeDR8zKQZfNEH2KCCZ9u0PmabxJEt8LefurR2WOgxOkNSv2gY9RqECSpY85RhSNOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

On 9/12/2023 3:31 PM, David Christensen wrote:
> 
> On 9/11/23 5:24 PM, Nelson, Shannon wrote:
> 
>>> @@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>>>
>>>                  /* fill main descriptor - buf[0] */
>>>                  desc->addr = cpu_to_le64(buf_info->dma_addr +
>>> buf_info->page_offset);
>>> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE -
>>> buf_info->page_offset);
>>> +               frag_len = min_t(u32, len, IONIC_PAGE_SIZE -
>>> buf_info->page_offset);
>>>                  desc->len = cpu_to_le16(frag_len);
>>
>> Hmm... using cpu_to_le16() on a 32-bit value looks suspect - it might
>> get forced to 16-bit, but looks funky, and might not be as successful in
>> a BigEndian environment.
>>
>> Since the descriptor and sg_elem length fields are limited to 16-bit,
>> there might need to have something that assures that the resulting
>> lengths are never bigger than 64k - 1.
>>
> 
> What do you think about this:
> 
>   frag_len = min_t(u16, len, min_t(u32, 0xFFFF, IONIC_PAGE_SIZE -
> buf_info->page_offset));

Yes, that looks a little safer.

We'll still need to do something about the 32-bit frag_len used in the 
cpu_to_le16() call.

> 
> Can you think of a test case where buf_info->page_offset will be
> non-zero that I can test locally?

No, I don't have one off-hand.

Thanks,
sln


> 
> Dave

