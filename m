Return-Path: <netdev+bounces-21571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D5763ECB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF84A1C21217
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D307E1;
	Wed, 26 Jul 2023 18:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51517EE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:46:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0930DC;
	Wed, 26 Jul 2023 11:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mow8S5/TePS0QBP8PWgh9rKEN1auOI9HmhVT/QfYSC8K9O0CEixCTLZpRauDiC8Ci+G/9GmyW9h5TMhn+2d+vp2u5Wr0pBAznRKMlx8GoGP5tk66q3RSBmaaxdix9mwAWnudiyy9qy4eEH20dFr65V9P7TBUGwL+vSxZIiEWWC0lEs/CWw/m6dO5O4fbepkiPraVwdLvzJpoy+mTCLBU+sjzShdYDqP1RweKKbBBOmHYOkDDWJDl/AiKzt4abfZr+YzyxOR6LPmfKjhnNg8oqYD1QO3ge2goqhapLkdKiNiZCophUISGuzYv6EovDSE1zTJKWe9Fm/BXqDbHhBfSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRcBUPGeDl8G4i4qxqOkitT4zcHUpedIqml6PCBq+lA=;
 b=Di8T9caebinrqqk00k6ax4AaQ2mzzopZfb59fO83YTxjwBbcAwVh03xl+kUQTjW9UXQZ3EpHtHAf8wWxEmpiBkhnJt63bYCBo9Ucpo4RcglgoHMO8xtbh5wDGJ9KnTi4wPfi3YS+3LLGuH2w5D82j2ZjBAMldVjdCYOBiFkqK5+lVhjCfU36MzjjmyVjKwP1/99s1eYf0nUYjQGkRzsuMA33tCUTKwe5Wsc6OArE3tDNDbemAMJzFVOsZN/8kNlVPqgyLtu3sPFWFVkIcUSf2ALF8Crnw+D+1/EVcM6gcriWD0zzExy1fDmflCyPifzON6fyyHP5/doSo5yZ9b1EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRcBUPGeDl8G4i4qxqOkitT4zcHUpedIqml6PCBq+lA=;
 b=40wyUKT6ViGzNenJI8bCBWvpImKaX1IjBZXPmEPsQxtYDcdtCLMpcjHJBb7YyFnZwshm0G0MmRqhZputXWwySdzWO6n4YzvsLHhmoQHWeflsLe3K37ag/4ojaXee2NPXjbYswVbGgT2vT2sgVXd5+5F3sZVm14QRkT9R4Pii2q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 18:45:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 18:45:50 +0000
Message-ID: <63361a8f-ffa5-50e7-97d6-297d8e8b059f@amd.com>
Date: Wed, 26 Jul 2023 13:45:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Joe Perches <joe@perches.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org, workflows@vger.kernel.org
References: <20230726151515.1650519-1-kuba@kernel.org>
 <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org>
 <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org>
 <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 646efd6d-bb9a-4ee1-4f0e-08db8e088862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DoFSFQ1mfcxVJWb31BN2xJSf/N/T1AWWaDxfmTgPUbcMzzyDUI7S2VTvKV/7gyT46ZntAMf4PiYnzprrr7TpGvsFkdduUai2aOjXx+MMVYiVaiIOXRUR/g/g5VcWrj6T8Qg7t/lruFDaKK7mu12cjFlMEbTFK6W/nIvOhlrgxLbhPJUz4PDwWbqnOu746cxBnWvlqZfrU9je8zMMUfL6VlK2Xl1jQn8Rx4oYTqrF3/Nh8e62lkZfpX+TvIQMxJQNPreerxtn9/8fVVO2wAd8qJuHZUOfm2P2cF1QdL5V9HwIA6a7q3c34xC7vumHHBymOFL0bv6jkG1VbxHob6T8UogSBix3g0Sqo7ucKli6dpLi4UKfPvos/bv0Bc4tDiFlx24AlmPNEzdATwWBLbKlyi391tiRAj4v2u0sT5KX9yfCuCNAUTPb8u1UhujZa5OF0kDqhqdEhLjvpBPeC2XzHqG27WrW6/C37HCggu1SA7Ss43hr17/hUO74BYzVESypXepjgCXWgHJ3iUeyOVyo2qAHso1VNloqXVM7G1QMM+hHo0HfUqtyzaeUrt5WdarKguhcfh11rXvD4TBzHoME2xAUC6a9YWE1OygnOXCY1YnXiZDUMQc/d/cb+/duqYDFmtZ87neJpKNcGyOLvfnfHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(31686004)(8936002)(8676002)(5660300002)(41300700001)(316002)(4326008)(2906002)(54906003)(66946007)(66476007)(66556008)(6512007)(53546011)(26005)(6486002)(478600001)(110136005)(186003)(6506007)(6666004)(31696002)(36756003)(86362001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1Z6MkdrRVZrT3JVaXF2T0l2dkd0QnZHSGl5bStpTUVGNlBhUTlUbWI5MklR?=
 =?utf-8?B?d1FkdlgrWTJBSkM1U3pEdmhMdHBaTEt1ejlnbWJnRFVxaHdFMFBjOFA3TlZp?=
 =?utf-8?B?cWcxSVFHTnZCbnhyVk9EY0cxRjJjUWRiN3BWMC82T0s4SXpGdHJpaEFpUXlT?=
 =?utf-8?B?S0RUSTZ4WFloUkk1MndrUVZnVmIrZzhVaDEyd1o2dGZuN1V0Z2w5SS9IdmNN?=
 =?utf-8?B?bTlqQm80NU03aHhZdkV1OGkvQnFYRFI4Zi9FMHhOVWljNWZXUURZUEtXWkxV?=
 =?utf-8?B?YUd3WjBaVDdBTDJxcW9JL1M0cXJvOEFXYmNVaTlDd2tGc2pENTlxWUtFdmFI?=
 =?utf-8?B?WTRUYlBzQ1o3b2Jxa2xXN0QxN3NGSWkxTUNpa0R2b2liSktkOE1jSEdCcHpo?=
 =?utf-8?B?STlNdk5icWtwdjZKL09CY2FhWWlMU1RiOGozVDNPTEFOcDdRTTFHZmkzM3VS?=
 =?utf-8?B?WFlsRUtON050TGpzSXNzWFFIeURKUUFidjJ1OTVCTGVnczNSV3VvbVo4VlpX?=
 =?utf-8?B?OGYvdnhONkJ2S2E0YTY1cHBQQ3hjVEZWQUNuSVBkSnlNcHJLTWZkTU9UdGVj?=
 =?utf-8?B?Z0UwYk9qUHZZb1RNR3FaM1Y2Q2k3TDlQK01Ibm5wMU5LTS9LSUE2NG5LRi8v?=
 =?utf-8?B?NXlLRGNOblZLQ3d4ZHk5QitEM1BKNGRSQ2VLQk8zYmlvY2J1U1ArMjB3a1Bk?=
 =?utf-8?B?ZER1Q2hJc2NzN3o2N3ZBK01FUHZUSWdzZzFzbXJ2MXRLbzV2NDhwY0NlbHdQ?=
 =?utf-8?B?SXdKOXlBNUpkZnpZMmFKN05ZUmVReEFyeGU3UjhPRFVPK3I2ZjJGNWpHb04w?=
 =?utf-8?B?N0RQa29TRDcwVnRBK2EvOUhBMXJrSEtWanY0MGY1b0czLzQ2NmlGYmIyZkFh?=
 =?utf-8?B?RVFQMlZnVTJKMENna1RVK3VZNkxvaDNJV245RG1zYzhpY1E5N0MvL1dNVUdi?=
 =?utf-8?B?TCtvdDJMVE5DWFp1UElMMzFXeGxhUXBwREFwUTNBdDdDeExFckwySmhTOG94?=
 =?utf-8?B?OXUwZnNYTVJoT1ljMVgva09TMFQyTjljUnByaklla3lrOC9mRUs0d2J4TEha?=
 =?utf-8?B?QlhHaVRTOVpaNWpGOWRMRFJzZ3hGOWlUbDVkZlFJaVBBbWlDcUNuTEhjUmd0?=
 =?utf-8?B?RDlQdXpkQzJua3lJSE42Y1FzUWp4Tk5LRmRUSGl3RkZLaFROU2pUci9ZVjQ2?=
 =?utf-8?B?MHFNYVl0WUhqSlVqWDhPbDBZWkh5UHV0M1FDT29xaUZmazczeXNNZ1dVa0E0?=
 =?utf-8?B?TGZLUjlyckZvVzdaRVpRZGN2SGQ1c0RTY3ZOWnlYSjNNR2d5T0VRbjVHekhC?=
 =?utf-8?B?Wk5NRDlnM3RsQnZ5alVWTXNYN1BLTzRoZ3JKTHpBL2FCdlJyUGVzOUJoazFw?=
 =?utf-8?B?VVdRRDNxT3pQcG1DZTZFNGQzVE04bkhiYUJTdXdWaFdGWjZ4dzNjSkV3TVhr?=
 =?utf-8?B?aEtTU25ScVpLdnRxZkJMWTNBbWZlZUZjKzBkMWZUejA2eVhURDIrKzlZRFUx?=
 =?utf-8?B?YnUxTk5YVjhqTWdrTFJkSlRsUnY2U0pzQzVWdVBFNzBLaUd3Q0NwNVRLRFFY?=
 =?utf-8?B?V1YyVzlwMldMZHN4WnNLL2J3SDc4Mk1UZXFMUnZZOXNta2ZVQmU1MVc1QkRq?=
 =?utf-8?B?SVF1dGRkV20zaXhyWG45Vk4xMEVPR2ROemNUQXd0aHR3VFo4REVxZzREczFX?=
 =?utf-8?B?akZienJoNW5jUDZyenVEcFJONkMxN3dhNEhuZXhHWVJoZTJVMnNkUVR1Wm56?=
 =?utf-8?B?YndqK0piRUdocWdPWjZVK3gwdk1iUWpBb3ZmWkQ5SEZhaFY1czBzTzlabDlq?=
 =?utf-8?B?RDdvNitsZytpZSs0WmhMYVFJSVEzbEp6Zk5SQStLWVMvcTIyV1Z0KzZMQ1pK?=
 =?utf-8?B?UjZlU2pvd2h1OUNEMkVIQWFES0IrLzJKSVVXY09tN0FHRUhYbjJmaHk4MWtI?=
 =?utf-8?B?bGM0OTlvRTdqVk1uVEFFcHZEaWNsSUpreGJSU2g0YzVSY2NEMWFpUUFZakNO?=
 =?utf-8?B?M0pJTnVHOG5KeWYvem1ZbkNDSGl4Nk9EbFBxOFVtUExwTWRseXRyVUpJeXhy?=
 =?utf-8?B?ZmVmV3FLcmxjdWoya25yMHpYY3Q5bzNybSs4ZUJabExnenZ5MVVRY3kxZHdY?=
 =?utf-8?Q?V00i4Ezaj16UFVbiLTBH9DDlY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646efd6d-bb9a-4ee1-4f0e-08db8e088862
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:45:50.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9EfpfjxCXsVonGIux+xP2K2+JpCCvE6CqBQvn07XWzQm6cMSMO3qD5dku35Ya4wCctC6EwIHQkrzrdjrfavKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/26/2023 1:29 PM, Linus Torvalds wrote:
> On Wed, 26 Jul 2023 at 11:20, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> You are special,
> 
> So my mother tells me.
> 
>> you presumably use it to find who to report
>> regressions to, and who to pull into conversations.
> 
> Yes. So what happens is that I get cc'd on bug reports for various
> issues, and particularly for oops reports I basically have a function
> name to grep for (maybe a pathname if it went through the full
> decoding).
> 
> I'm NOT interested in having to either remember all people off-hand,
> or going through the MAINTAINERS file by hand.
> 
>> This tool is primarily used by _developers_ to find _maintainers_.
> 
> Well, maybe.
> 
> But even if that is true, I don't see why you hate the pathname thing
> even for that case. I bet developers use it for that exact same
> reason, ie they are modifying a file, and they go "I want to know who
> the maintainer for this file is".
> 
> I do not understand why you think a patch is somehow magically more
> important or relevant than a filename.
> 
>                 Linus
If the goal is to get people who are involved with a file, how about 
some variation of:

git log --pretty=format:%ae $PATH | sort | uniq

Granted this is going to be overkill, for example I can see on 
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c that it would email 198 people.

