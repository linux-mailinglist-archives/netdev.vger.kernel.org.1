Return-Path: <netdev+bounces-33957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24657A0F11
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC11C20A66
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666331F5F8;
	Thu, 14 Sep 2023 20:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA433D3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 20:39:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F201BFA
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdHC81JOpBVcX4jTADqJ6+vRB7yEDP6gnuf64oVuZfQfElrXPd83daGwvKeViENKFDovNhqH4qemRfYUY6FBgeSxxb9lZ7+bN0VtKutfELbsixQ1zHrtbryb7/40/SGUYa5IX3P0INVjVbhPf6Dk28F1yY5Lge+2oHCnIYGCoAaXsqvjpio1rrm3LBvd18I0pxkBHHKiP3OqUUjHlQOpfILqydui9bEZjC5hd9qMK6F3Uumr0Fuq3jeX6t0LFrfvmsAAye+IQrd6TiUwXE7vviUIN3VIUos7Uu+IHNhCGyrL7FyrfUoNugWnk8zXjrQMoAKHHU1RxMJ4VdsxKB8ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxQTsntzlivtmh9vXPckDRfowx09pCViMSdmzOG45Po=;
 b=RmHETG3n1X1yuvCzMYhDJMVObgBDpG8axUnw13n+HaqMpGMyRaYiOl3DB1+8B0uiI5J4XAiXdE7po7ap5xDMMjnDMmPONB92n5/rDxKVD/Ws/j0uGVcQflOv1Zo0wBkMIOLv1fDakxbURv+ShxLQTm1U7xHnZ0Q6mStApXl8iksvUO2hKT/fgPrTgR7IyUHWITdI9DYOMCrkdpBLEKXEbXR/KP2wSxtQiOGMxhbu/kGXBLAhloAADZl/e5su+KHNw5MzzUC4Fvtawf92I0ldeKMQZ/mVzHFgoUsfs9x6Ruv58pRDBxqaG4OHVqjTtzEjixk/WZOoah/1DBFCP7lxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxQTsntzlivtmh9vXPckDRfowx09pCViMSdmzOG45Po=;
 b=g1vG39Cp1hE0MVKQ7bzvYWCQ/1ZcnMtlD1u0WCtrfiX26yUxOOQOdbpJZQdmes6TZMqLNejG45W58YRwuH7W/hczb8Eq/Uet4BpguJW1TyxYX3g2z/WqWTbZcvZdfliLxqJxJJdZvoMJ0Oj6zhxsEpdgC/h88odT1ejbsT1puOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 20:39:10 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:39:10 +0000
Message-ID: <3748461e-c573-4b86-a39a-39c95dedf61c@amd.com>
Date: Thu, 14 Sep 2023 13:39:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
To: David Christensen <drc@linux.vnet.ibm.com>, brett.creeley@amd.com,
 drivers@pensando.io
Cc: netdev@vger.kernel.org
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <a7c39c89-c277-4b5f-92c0-690e31c769b5@amd.com>
 <df083cc4-e903-f122-0817-b1313397e89f@linux.vnet.ibm.com>
 <74e50ab6-2269-49b2-83d8-0c03f359a80b@amd.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <74e50ab6-2269-49b2-83d8-0c03f359a80b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:510:324::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 374ee58e-7457-42a8-6438-08dbb562a5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r+28cd/GIpgTsL6n8FZMAVARG6xIufGRIKXMPyE+7quU04fC2iDOI4gYZ6xKfuWMYIpD4P5BJLtkWuda+nQsqPMzXDXjTJD+UaS1Fr7Gz7GdRWlX7YNrY4zI4l+4nwMb/FQHJexEEaOjQU6iz3FxNzcRWCLFep7jqgT0QbPiJgyHpJDitN4IwzXHhJcS3v4dndcC3wqOTpSxZzTdSQUlFWrAJ63T0T/+uiN8ktqFizHcGWaQlcEpUF6PkVXEJ2QMzNsd2xqdP2DeWlHhEptE8Mwc91nSFX6QtVWsOKlMwOd2YCC4Nynyq1jgukZWP2laqoCoRT+HfIHXu/Zk1rQ/mQM4Yp+mtfdXtY5GJxvQJGfJ0F+MsKOAqvGav5SFhZwE6H61Rz8GCDizmRIhMsJXqaC5Z5FaZOXUO9wIplMc5jAiD2TaErn7lTJcwXn3YRR9tpZSkN+j78yPSjeXUP+a+mLDDFEDZpc2B2/RMjY4hq8mN4F9cF//4ZORdhEv62Vvs9Rzlf88BDFRdBQr187YjIt0lDDFQ66VimISp951NsY9BhCsZOeNQPU6imAfQfLf67eh9ewp1TcZMw1Z8QQXZ8s5X3t4oJHq6CszjvIzkI7Z4/6eZuJItEJTYzuw1zIWwN04hyZwDYIb3+O/sZTUAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(38100700002)(6486002)(53546011)(31696002)(6506007)(2616005)(478600001)(66946007)(83380400001)(86362001)(26005)(2906002)(5660300002)(6666004)(66556008)(36756003)(4326008)(6512007)(66476007)(8676002)(8936002)(316002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk52T1FzY24wb080VjBoU3VEeHVvZEc5NEpoSjhsUDNDRTRQNDZJbHpOVDlD?=
 =?utf-8?B?RGJnSTc0OFowNTBFM1paUHdsQnNiR0ZNMVhZUXdLRGxMVU9CSkFTa0x0TzlI?=
 =?utf-8?B?S1JPTCtZQ2hOWWlWSXZYYndPckdJa2M1bmE4cktYSmo5QzNJV2VadDY1OCtF?=
 =?utf-8?B?UEtmTFNhb1ppbjFkSk1zdUlUUmZjSG1SU0RlOU1PV1MxK0ppZU9ZZ0pBUHhq?=
 =?utf-8?B?RjFjaXBrMjc0VkFiQlphcFBzRFk2OEM4ODF2UFkzdytKNnZNZk8vQjhuSkVt?=
 =?utf-8?B?V0RjK0dqb21ka1Jra2k4ajhvUmIyOTNPalN5K2JuY3hOZ2ttWFoyU3ZxNWsr?=
 =?utf-8?B?SDR0TmQ1QW1uUkdLa094N244SGFhVWhYUi8xN1NTbGRwM0h5bDNMdWdGNFgr?=
 =?utf-8?B?VmQ0SmtRSVFIVmNJaHA4bE5lUVNpczB3YXBiQ211eHhjVjV1dUQ1Yy9HaSt2?=
 =?utf-8?B?eDBuUDAvTTFPMHpRMnN4RWY3cHlOMjFIaFp4WHBZZzUrbkpVY1NZU3NuNHFG?=
 =?utf-8?B?MFZGcFpkbGJzNmEyUzcrUW1UZm5FUUZiK2FJeUNjN20ydi9JQUpWUXU0K3lM?=
 =?utf-8?B?OHRXUU1HTXQyOGRSR3pJMXgxMVZZTGZyQzBLbHhYd3hmZHNOL1cwQmJZOC96?=
 =?utf-8?B?aFdiTWg1UzJ3WTVFNXZJTmtnOVlLa0oxOGN1NmQzYWRjdzlPN0F0eGU0VzF2?=
 =?utf-8?B?Uisza21aS3hheHVQMDdNbWNORXZsT3dSbjVQM08rVmJrcnlyb1dQbkRSb2FV?=
 =?utf-8?B?Q21nUVN4YUM1dWU5VnJBWFk2c1BHbE9DMlJidzJHemhHTXNkd20wRk5RQTdm?=
 =?utf-8?B?bGdpaVVaRVZ5U0ZUR0xmaWl2RTJ2c1BQYkk3QkxKeVlJWG1UanB5NG1FZDlV?=
 =?utf-8?B?RUlYMjR2Ukd2SkVSNlN2VHh3RWpTdVQwUEdxZnN1eXVWd05UbHhwZ3Z2Vkw4?=
 =?utf-8?B?L1RFVnZQQmJJVWVXblB0YU1WRjQwV1pzaTBNaDh1R0JXWVNPckErK1hOUWFw?=
 =?utf-8?B?ckM4R3c3SThNdUdUU0tnRVdxcitydHl1WmZjOHBUUWZGUmxKckdHTVhQeDNx?=
 =?utf-8?B?ZGM5WUZ3d3E0VklkeEFNMXNJd3N1SGl0Q0xsa3ZaSlYyZUloVnFtWG5peVNQ?=
 =?utf-8?B?Y0xQczZFNS9NVU0yNklnczZFK01hWWdUR0FQMXhmS0ptN2JtN25LVHozTFV1?=
 =?utf-8?B?WHoyUUpqTEg4dEoyQ0lJMWRvSWhCRkJqMU1VWTZzUU9ybGRWYTlLdFEzdngr?=
 =?utf-8?B?L1JOMk9SQ0M5UDdDeTY0d012ZVY4cEllWmxEcEp6S1ZuckkwRy9pZGxOMy9I?=
 =?utf-8?B?eWlhNjY5T09GNW5heElDaWxCYzlHdFN5cWc4Z1FHbU5UODdQdENFdmd4RlB5?=
 =?utf-8?B?OUF6L3pKZzZxbk8zdlRCQUpnWW96dGdGUlJreTZzektLVTl5QnNOcFdYbyth?=
 =?utf-8?B?U1R4VklEMGRDUWhFeUNTTWhjN3ZYK2YreDdVL25VQk9nNHlEYVdHTmhLUU1U?=
 =?utf-8?B?Q0JsVXM2K2hGRUwvOWx0UnlIZ0ZFT3UxN3FWbWQ3N1lVaFl0bTJzUTk2VzFH?=
 =?utf-8?B?R1lnRDJTbENWNWR5TDRGbjdhQ1dtdTNNRU5HM0IrR2xzclFiZmJERWxhdFN5?=
 =?utf-8?B?MjJsYnJ2SHNoWi80NGxmYnU3SzNTVytzMEc5M1ZwWUZKc0FFb041b1FqbEl4?=
 =?utf-8?B?Ykh2MG0xdDVaZUExaXRTNVc1Z1B5NmwxM3NmbFJGWmRJeWUvRWsvSDNySksx?=
 =?utf-8?B?S3ZoaWpNK2dTR1dMN2k3ZjRCZ0l6U3l1ZHNQYnlQZnJVYWQxQmhsRDJZVWtn?=
 =?utf-8?B?aTF5T0tyRlFBOTMrVzlYdExPNm1oVjZ3Vkp1ODUrc3VkU3hoQTlHZ215cjEv?=
 =?utf-8?B?RmVzRDhHUHVFakIwRHE0WjI0TnZDczNWZVR1d1c1aW9BcVo5eDhlTEZxNmtS?=
 =?utf-8?B?c2hsNUxYZTVSYnA4a09ZelBmNnFKSWorakxlT05nTFptcUdUNFVUM1I4bm0x?=
 =?utf-8?B?RmM0VWJxeG9GYWUxdFROZnl2c2pKTGk2VGtZY1hCbFdiNm5rTGFlTFVIRk9l?=
 =?utf-8?B?YVZiT0xpQ2VnOVZSOWJyak9XOXZmdmZVRlZxN0w3OEpaRk9CMXJaWU54Ynpn?=
 =?utf-8?Q?YrkD5HM2FemNtUqg5ML6JXJPy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374ee58e-7457-42a8-6438-08dbb562a5f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:39:10.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeXS5KGrKP4R794G+o6uRbJ8WuY2uFEQzHZMd1UCmTEquv9FJWs33S+3R+z+qYaBfqc0GqSO/TfqZZ0c3pa7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

On 9/14/2023 1:28 PM, 'Nelson, Shannon' via Pensando Drivers wrote:
> 
> On 9/12/2023 3:31 PM, David Christensen wrote:
>>
>> On 9/11/23 5:24 PM, Nelson, Shannon wrote:
>>
>>>> @@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>>>>
>>>>                  /* fill main descriptor - buf[0] */
>>>>                  desc->addr = cpu_to_le64(buf_info->dma_addr +
>>>> buf_info->page_offset);
>>>> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE -
>>>> buf_info->page_offset);
>>>> +               frag_len = min_t(u32, len, IONIC_PAGE_SIZE -
>>>> buf_info->page_offset);
>>>>                  desc->len = cpu_to_le16(frag_len);
>>>
>>> Hmm... using cpu_to_le16() on a 32-bit value looks suspect - it might
>>> get forced to 16-bit, but looks funky, and might not be as successful in
>>> a BigEndian environment.
>>>
>>> Since the descriptor and sg_elem length fields are limited to 16-bit,
>>> there might need to have something that assures that the resulting
>>> lengths are never bigger than 64k - 1.
>>>
>>
>> What do you think about this:
>>
>>   frag_len = min_t(u16, len, min_t(u32, 0xFFFF, IONIC_PAGE_SIZE -
>> buf_info->page_offset));
> 
> Yes, that looks a little safer.
> 
> We'll still need to do something about the 32-bit frag_len used in the
> cpu_to_le16() call.
> 
>>
>> Can you think of a test case where buf_info->page_offset will be
>> non-zero that I can test locally?
> 
> No, I don't have one off-hand.

Sorry, I was thinking about the case of a large page.

In the normal 1500 MTU case with heavy rx traffic (e.g. iperf receive, 
pktgen, etc) we should see page split/offset use.

sln

