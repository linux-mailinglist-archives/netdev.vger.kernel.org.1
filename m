Return-Path: <netdev+bounces-38175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E796C7B9A37
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B579E1C208BB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE515D2;
	Thu,  5 Oct 2023 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IZPhxfVP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C67E
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 03:36:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14A1725
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9f5rAKfQa7IxWoXcOPnOBTBlvSXV0Q2OtGpzkju9AUSGu6BhcPS6RIruDF3UpwwLzfDrMwCsAn8kk0fsRZ5o7JzQfxtb/ynPjFaW2NgL6XaCpiYCvP0WVo9g0qCArZXcOe6rjfdKHqZjRzHaSZcuTk1xeDH0UwoMkTBGgc8dmO+qzqsajN2NPg+woHBFz1j3eyfife+LJji6ISPVu9fsLAnlG3ExO/uDXsWSg8XWZtonSziPWKLfJ6A1WItxm+xUZHXD6H+zttej1l6EPS+EM/WZ7sR7oT8LFL6Wg0xaT5kKTDjutZwWvDN2yBLenY0gqvf7BrWaUvQEidMatguJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QGkKcxrFZ+Cwl/pOohKqRPYVAye/5nIZ2+tYH3ngeE=;
 b=K7en4fy5QAETHPGbrWQg6b2LMoE7jOr0GjF0NTzRWAy0G08AcMlMYBLjD8du/MZAwoKW0SiRX8kST+VZGnELU5stffqrKQQuY7rh18JcUMZKALZIJu+aoNF043UEVqPJeffZBZI3F5fMeMlE92xOFikHEqvTLREf1dlGLLNfdCCc67XjVaKsZVKXT0Nvn0G5izQOoKxsg7TT4sLc8gL7XNg9V+wBcDa5ZPzD+beCOIMi+hXy1kiPij+aSmZXlIeR4G8CIouwtXDYbI1EdwDbL32gdSq3BFW8qhzGnYIFPNvzvBpQSXX7fXp2rbsEtZNk9pVP6uoiEDUsipIt8JSShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QGkKcxrFZ+Cwl/pOohKqRPYVAye/5nIZ2+tYH3ngeE=;
 b=IZPhxfVPlVu+p0bUkvtBgPtn1d+PFSffUOQdxPcGNfkO98d1bEGEoUhvVx81UF/ddgcIiHVzXQcvBtJE/Nxu5pUO4guxA5wEseEqwIj5ZzG3ysOlI6jzA9ebnRXgfQMsa0lNrLSt8bNfRzITCDG0rUFED+4EU+9l+fgfR1DQPuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 03:35:45 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::e928:75c9:bf10:292a]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::e928:75c9:bf10:292a%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 03:35:45 +0000
Message-ID: <61d32959-83e1-f255-9aa7-65630027deb7@amd.com>
Date: Thu, 5 Oct 2023 09:05:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Content-Language: en-US
To: kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 Shyam-sundar.S-k@amd.com
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
 <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
 <d6c6b06f-4f90-62da-7774-02b737198ce0@amd.com>
 <703cae60-5898-e602-f899-06d795b58705@amd.com>
 <13d692fb-1f89-4336-a53a-d5d07d81f6a6@lunn.ch>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <13d692fb-1f89-4336-a53a-d5d07d81f6a6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 340f28ca-f51b-40a5-aa54-08dbc5541cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gi8ZZCRVQis5Pmdqrw3khWXcMiA4sP6j1yM7bpY+z3567AapFlvTxAdQt2Uiy3LKeiqAo1Hsxi9SYyT7oU+AV6NatBYNwar1tI9u+fvLmbq91Wc25EAwn56joG4ivre5CSL6bKg51vBRb1hQ6T9phWgrdjeY55QaJqYxcahIeGuEt+CuwMOtVNbvIPKPZZyoPzFwRCPmew4WrlkznlIEva2agIaM5Q94Jb0tzozjE2TRDLyInId8qXn+j3xU0mlR//qOZMPFCXz9aX5Ia3mpxbHkgtBikNr/qSN+nqeYAAiF/nv85wy2KxAFePqHPBa0+zFPRne3qjstoAHe7tO9g4RHIVrWRT4oV5Lrfo39dfKD6V7MQHBDV+Gh1AOF6qu17kn0+5uv+b1ZvQ0MQT/e/2A/J06wb7CXvvLhcsPVZIafeu30TlJQVRGq883EPHW0i1k64D3l/09tIPSb6IO5vaMYlcwlMyP4nsES50051xkBEfPg0lD+coVCwbep/Na6MJkO6DGPCknR8pYTofk80meZNoPJY01gFBSmB2VaJEltPJJ9siokPM8SSKFWUAaevCqlkTYyLWaXh0k3UQpAaXYpegOqwsDZqMW2GxIP3VaNAPlkcjGOxT5EFWEHgJvYCitQXt25sd/8QJwvEOjmQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(6506007)(53546011)(2616005)(478600001)(966005)(6486002)(6666004)(83380400001)(26005)(2906002)(5660300002)(66946007)(6916009)(66476007)(66556008)(4326008)(8676002)(8936002)(316002)(41300700001)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE83S0VKWkdESlQ1dm1neTkwK1ZiRVlhU0gxdkx0SHFZNCtxODhLRDF2QTcx?=
 =?utf-8?B?bGFBVS80dUZDZmhmU0c0V0luQ0RCbUdaZXFoMGFWQUNydWFmWC9wNm9lSmFO?=
 =?utf-8?B?aHM1cVoyN0ZwUkgwbmtzNitzSzhJR2Y4d25pS2JIUXYya1RaQVdEamxCMzhL?=
 =?utf-8?B?Um9VUVI0QmswVEFjMVVYUkQwb0hrRlNqc0xJSS9FSmRJeTlkUDlseUNZYW9P?=
 =?utf-8?B?MGtxL08zdnhaV3JCM3QyVktROFMxRGN0WFFpTDNBY3ViOHpIekxzZkl0bytF?=
 =?utf-8?B?S2gyNTRHYmdVZk1mZ1JMVFdOVFpWNTdzSkZIOUlSWjZVQ1FCSnBNc1UzbjZm?=
 =?utf-8?B?em1Fckh2b0RhUTdpQ1hEZGJPQ1BoeXllYU9oNmI4QkRKV00raFlSN1RPV3hS?=
 =?utf-8?B?eUxRVzh5UDJ2OGorZ2syUlFEWlRGOTltWTZheEo0NENKTHFCeGtEaXdlYlNt?=
 =?utf-8?B?TnhrUUJwdjZUZVlJQ3ZCaFJEN1JueTBkdi83bm41NXZUN0RmUXFDcFh6Mmtv?=
 =?utf-8?B?WHY3RDAzMEJQUlFpLzZpUytHMUpoejNJNnZSS1J3dGJpMkhrNXo3U1o2Uzk2?=
 =?utf-8?B?VHNOTWFpMjExMDl4RnFYd3lrRS9yYm8wd3dlMGhRdWs3dWRFMUw1d055Y3By?=
 =?utf-8?B?N1pGZndaQWJNemgvZnpXcTFOS2RUd0poQ3ZuYkkxNFlEbk1KOFJrbWNaOG1y?=
 =?utf-8?B?cEVwV1cwZU1sWHQ0Qk5iN1BuM1Rhd3VxcXBROFQ5MVVXSWJWNjduaWFnRHFl?=
 =?utf-8?B?UGRWQUpqSXovR0xwa01pVWhxbmZXeFJzcEozWUhyNkYxeDZlTm4wenlqeWxU?=
 =?utf-8?B?MklTWm9NeTJncXhkc1hicWs4Q0FkUWJHTTlmM0RiWG81a3BnZDBrTmdCYTEr?=
 =?utf-8?B?YWxkUTdXRzYwYmoweXo1VENteVdGbm0yNkRFSi9KTG9JL1JNVEJnZXBTeEUr?=
 =?utf-8?B?ZFVSRFFtRnAzTTdDRHVTSlhPOXN3RWVRd2tDNDFEWkd4TkxpS3MvdkhXR3JQ?=
 =?utf-8?B?cFRlSU1kYk95WmhzVll3cXQzS2ZFQ1VrMmlFNEFmQjBNeU9nS3F3eXRZRnB2?=
 =?utf-8?B?S0J2UUo4YlBXMmF2ZzNTbkpDVEszVkZ5WnNuTm1MVEt4cmJKUE5PRjlOeGsr?=
 =?utf-8?B?M0Y4NE5sUlFNVURvU1pCTVgxeVp3cVdSNWNyRmZNK1dEUjVNbnMxY2FNUEtv?=
 =?utf-8?B?bzlROHRVYzd1RjlReDU4NVVOYVVtUWZ1QklDNWJMZnI3ZzdZbnZycmlLU3Mw?=
 =?utf-8?B?dDVNdlFkV2s5dk5qUXBPTStaa1htQXE1T05rQmNSNzd5OVVxZy9BdGxPSklI?=
 =?utf-8?B?dnBoNmIwd2Y0TUx0Y1lTM0tKU2NDandLSzNGYzltWWJCY2JHUDFtQjZnUWtQ?=
 =?utf-8?B?K2RFRlphbEt5WnFJYm5yeHk0ZDdBNEF5Y0tTMytYeDZsWExvTHRjMms0WG9U?=
 =?utf-8?B?Ty9LVlZXejE5dWZoUVJmV3dsb2FDN2p2bG9DeDY4VWF6ZU1FS0pFMk1MUHJY?=
 =?utf-8?B?MU5YcEE2QWdmVlM5alpOSncyenkxTVd1RkNOUGtBZjliTTh5cTdtSitGYkFN?=
 =?utf-8?B?ZGEvMzh1b01tbzJtN01qc3ZUaUxSWVBzWTl3MWNqajM2aU15Mnp3TzNmMEQ4?=
 =?utf-8?B?bVJubkhBVFdwUkhiOWZYWXlTYThYbnd4VTFkMzlIVHI5ZjJHU1A4aDFQQ1h3?=
 =?utf-8?B?emhuZFV0djMycWV3UDNaV3JUWjhlSFZ6WEJ4WmN5Z2tlUWMwMmhjM1YvUXRj?=
 =?utf-8?B?VE9TV2VDYWxWbU8zVjFmcnRkWUNEZy9FSW83SENnTDNpYy9BOFJVbG94cUFR?=
 =?utf-8?B?clI0RFA2KzhNakJBb3EzbkpiNy8xbDFWV3pHZkVuUk5VeTZtaTlJSnd6UE5U?=
 =?utf-8?B?U0V4NXl0Z1RTcWFyNjNrajBDQ0hrNkVLM2JPRXZXLzgvOU4zbFF3V1F1dWsy?=
 =?utf-8?B?UVFSRTlkZUQrai8vNGRCNGdOblRrb3VKc3duTHFPS2FlNjBRVnUxVndlcFR1?=
 =?utf-8?B?WmpYbm92TU02eEVwYXkwTUU5TnN6MFVIbVdFWFBseGRXOC9ORGdXcC9YbFM3?=
 =?utf-8?B?TVRUaWt0Sk9xcU81UmNKYlBpaGdKd0JabmRLeG5BcjZvQ2dYTUROYzlkOVls?=
 =?utf-8?Q?Z7Mj0K2lyzH74rz3KWeblvrtv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340f28ca-f51b-40a5-aa54-08dbc5541cb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 03:35:44.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNrf4VNeTGKWymmKP7lJ3dZDVMyopmTNSAwfRDIU3JRqpokMhj7s0c6mwyugujVCRsEIe4RSJUHhqh/dcyd6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

Thanks for the explanation. The current approach is holding good for 
amd-xgbe.


Hi Jakub,

Can you please apply this patch.

Thanks,
Raju

On 9/17/2023 7:41 PM, Andrew Lunn wrote:
>> Thanks, Tom.
>>
>> The following thread (found online) has the detailed info on the IEEE 802.3
>> Standard that define the Link Status bit:
>>
>> https://microchip.my.site.com/s/article/How-to-correctly-read-the-Ethernet-PHY-Link-Status-bit
> 
> The relevant section for me is:
> 
>      Having a latched-low bit helps to ensure a link drop (no matter
>      how short the duration before re-establishing link-up again) gets
>      recorded and can be read from PHY register by the upper network
>      layer (e.g., MAC processor).
> 
> By reading it twice, you are loosing the information the link went
> down. This could mean you don't restart dhcp to get a new IP address
> for a new subnet, kick of IPv6 getting the new network prefix so it
> can create its IPv6 address etc.
> 
> When Linux is driving the PHYs using phylib, drivers are written such
> that they report the latched link down. This gets report to the stack,
> and so up to user space etc. phylib will then ask the driver a second
> time to get the link status, and it might then return that the link is
> now up. That then gets reported to the stack and user space.
> 
> As i said, you are not using phylib, this is not a linux PHY driver,
> so i don't actually care what you do here. I just want to point out
> why what you are doing could be wrong.
> 
>      Andrew

