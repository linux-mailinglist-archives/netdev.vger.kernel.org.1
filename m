Return-Path: <netdev+bounces-44236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370907D734A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18691C20E14
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CD2AB45;
	Wed, 25 Oct 2023 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chJnqxgG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E631A6D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:32:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C8BB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698258753; x=1729794753;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AkqeMywqYDA9sDQpEBGRJFsXCCkN3eAjPjpP7jmQegw=;
  b=chJnqxgGiFlUPD4QCUBSiLEcbheQpr9Kx9ck5m21doVyOEl+8QxOj9KX
   HdHOJo2nhowzcqkqTILnCFGtMqyKVtzuqKZbZA4Ia0QYrCa9nFKVeV3ez
   Kwu3Lk8lkeUI5A9e10qp9etO4X6Y4r59uIzQAkWXd4s5wU5WIvg/N9hiX
   fnYuRTuWYoZp/PNTK+XntPTCkmTiSpXIGepCktnLxyIKy1vyt/MrjBp1+
   reO82Ocwi5PVNaUcHshoH6StDzQw6UlXqE+VSTzNSsBG2pQ43necf0P4v
   tvVkrH6Gi0cOYxTWyyBXw90SNQUYiCh3lgWb4PNElErPTrVZBnTWx1iJ9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390231325"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390231325"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="849624077"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="849624077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 11:32:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 11:32:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 11:32:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 11:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbRq7jO+QGtc1WY9aOoCIpGYN5ChquMtTtcSNIIwbqQqH5cAd0tChFqz4wkiu4/8OEYUavr44lwDcKFYsfQ3/xM/kEiomoSxe7hs0JdeTcd6wHcP0066quyyKJ9YaLreDgedpv78k7fD8Ce4WskMZexjaqI0uQp8oKPGdSNUL/Wzt+Z0rsLTrI4SmP+e/Yp2UKPe2V3AbmpQbptumdm5QjlsEkdlDwccIUREo/L74wBoALmT4XKUHOW61mpyHsYO+WQ1C2xgYtQlz1AuZbXjkm2mpMs5whu0P5o1n391XxlDW904J1T2MIZGphMeQmCKUZlBDKuJ0bxryYF4ua38tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGkgj2K6dBa+1TJaxACal33tTo+2He8JkhZOHwb5IZ8=;
 b=Ni0Dw5hbmyD1Zv64wDs1S4ogkRhSYmV/eudZ3zfM/0+5fYvnShXN/W7WflS2NxaN1jOMfJ6MlM201n6lDlzJrhekjjWJmP8l8udaz9nuSX4Wh2LxZp79ypBHDlBoeSkSIWdCRY6BHlSArImNIWZkBSesFnyZwvRzSbo+V06RWhPrauJgS4ZoUbD86EjHr2CgEaAXY4x5FEMu9QR82bEtIyjANdsVG11k19XbQQgUHOjtE9MPzscASbguXyAhMRrpjRbvsgqfdxtp5CINg7RGyU6mGBLXbCL+xD8V3K32+orcnA4nE15Mds0hPyj8UX7O28uqAH5/UTeXq784RfI1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 18:32:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:32:28 +0000
Message-ID: <ce2e5b10-4605-4782-88ab-1381c8eb4f55@intel.com>
Date: Wed, 25 Oct 2023 11:32:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] iavf: in iavf_down, disable queues when
 removing the driver
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Michal Schmidt <mschmidt@redhat.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
 <20231023230826.531858-6-jacob.e.keller@intel.com>
 <20231024164234.46e9bb5f@kernel.org>
 <CADEbmW0qw1L=Q-nb5+Cnuxm=h4RcdRKWx1Q1TgtiZdEaUWmFeg@mail.gmail.com>
 <20231025092516.3c08dfce@kernel.org>
 <f0107627-5dce-4b31-b448-847c47b1bf04@intel.com>
In-Reply-To: <f0107627-5dce-4b31-b448-847c47b1bf04@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 20603e11-c415-4e4b-bf8f-08dbd588bdfc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjUxN7aTgm00ThfJ5CNq38noAhsNKlDiiyvUlmD1yN9HCsyw3+y6GmzvjRb6ZIhq1ZZKd8LZ1rctAR84jKKCrotbjychVUbY2lYzbqq2nzaphfNy/Z0UxwFilhc820JsbqEiBNwWg57IKzq5iAgVlXLhm+iEIPOSivJwrDIq5curcGO+P5RZrY6UonfhW8J46lWZCLUtBHdBVBJBOlRCR9dL6UpTntS2MF8o4wLW4lkfisH2FReI859b5uWArIhUmvjqYp3PHA8Er49KMYWWdoIGhBkBnbv/Ij7s7DFetqK3NVv8Wq9Xe8wxWunz/l/Mu/DOkg1k+YS4fqXdhkq/f0ks+2kbLso2u8UeV7Hrzio1JTZbybZ6DUSaMo3o7uuO5bo1c5AWsi8xcd2fg0Rj2Nnwx26/IhpdHhjValUuMiMN0930IXtUoRF0gNxgevG7SYyracnFP73DwkTrer62/CvLY0Xmm1+WIgH2bKnpMaQJljwQ4og+Dqqp+kqM2pg3vU+1yZPqiUGyVgLOu3tXUrfCNE/IyHKZ1YY8IGntlC29ctxqWTSGib1fbh35mjG3oNa7ZIg32kNK23bDUArxZq+CqJimD8GHXOFDgm/c1+WDzRq9v2VKZfYMeUrbg7XWID6l55Ng+z08hnWSCdLNLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(31686004)(38100700002)(2906002)(4744005)(66946007)(36756003)(86362001)(31696002)(4326008)(5660300002)(8676002)(41300700001)(66476007)(8936002)(107886003)(6506007)(478600001)(54906003)(110136005)(2616005)(82960400001)(316002)(66556008)(53546011)(6486002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE85aGZUTHBQNnltd2R0djYra1NRbmlnM3hBMG9INmtNSTNGWlpsRkwwaEZo?=
 =?utf-8?B?Vk9JNGZMRHZmV2hzWVQ4TzNmQ3hPbEpXS1FGL3Y3UDdOV2c2dFBvc1pHQkI2?=
 =?utf-8?B?Y0lIaVFLM3JmNFpvamtzdGlhYnBabXRoUjVaQVQ4QWVsK25hdUZzdDdINlV2?=
 =?utf-8?B?K0YvNGJuRW5CVCtJVmU1MHpNanIwckh5RHZSNGtidDFCOVcvRXJ6eENqa1pz?=
 =?utf-8?B?MUZwZ3ZheEd1blh2ZVh2UEVycjVUWVJFTGdpcUM0bGQwRDhvdk1pZkxHWUJq?=
 =?utf-8?B?RTJSL0YxYnUvVzlwZllhTnR6d25yc3BndW01T1cxS3UvNGtuZTl2UmJCMjJu?=
 =?utf-8?B?NDFDY2UrS3IwOVZZSWpncVFvYnFibW9PRTJjSXZFQ3pFRG5UTFFTVWZWblVq?=
 =?utf-8?B?eGRkYVB5Wkxxd29EYXltOUdQU3RMb0FOSWZiMThuMW9GdzJQTnVlNFNNWUx0?=
 =?utf-8?B?QzkzcldmVC9sTEdyUlExWWQ4Rzg2MFNBUzFzRG1Fcnd4UGd1bkRVN1FmYVNQ?=
 =?utf-8?B?WVFGRWVJaXA2NDkwc3JFc2Ruak1qZzVFeUt2ZWlnVWgwR0toaXN3Qkh4MGQ3?=
 =?utf-8?B?TU1IUHU5NjZ0UEprSGlLaytZQklDLzBsMytyVDFXd3dxTWNHVDVpbUpCTnh6?=
 =?utf-8?B?a3JlOCtaVy9MYnoxMDVDQkk1K05iNWpaSExueWZ0ZC9hanRZejZtOEJJNzhu?=
 =?utf-8?B?eVFyQnlGQk45eVJTQnZzUjNCYzN6dHhvdkFSK1l3ajZlMHR1VEo1VVo3YXlE?=
 =?utf-8?B?M0dyK0NNeU1GYUFnR2xtcGhic29kQ1h6MFRkUE91cVViMUFiaS80aTg2YkpX?=
 =?utf-8?B?aHg5VXl6NkQxcjU4amJVbU1oTlNnRFowcTZ2Q0RYcGk1WHpCQStXWDg5VnlM?=
 =?utf-8?B?Q3ptUHZTRkM3ODR4RnhWT2xtT01PZjF6RDJUUThzSlVMTnArRTBkU3ZvRFBX?=
 =?utf-8?B?Z1JTTkxIakdSVVJ1MHFTWmhLWGlVTGl5SmxCWFBheGtGNFNTRDVnalpldThE?=
 =?utf-8?B?dmg1cmlTU21HNFRNQ00xUHdKN3hEUzh4dnprYjgxQVR6bEUvQUwxaDVXS0M2?=
 =?utf-8?B?Njd0aU5IMVc2MlpyY1l4Nm1jcVZQR1Fmd1kwMlBaZjVkdG1JaEFFRGZGSEQ4?=
 =?utf-8?B?YU5UY1RjWWpIc0x3TGx2cXM3SDJCcGx2bFlPNEE5VmEzdStjZmtLMmhtRWFQ?=
 =?utf-8?B?M1liOTIxUFJGd3Ftc3R1eXl5SjhZZzRlOEpTRHhsZGxxN1pJcWN4dmhqTmFv?=
 =?utf-8?B?TWFpVGY5bEpKNnpDNTV3VTBLTGxKRmUvT2Q5dGpNS2xxb3VnZUFTMFE0c2hL?=
 =?utf-8?B?V245SDVIK091YVNFTExsWWI5S015QXczb2RiaTllbzI4aEx4OGFaUjE1ZUFF?=
 =?utf-8?B?Zzg5VDRIRnUwTEE1UGhIVVBscld1eG9yaDBMMWx3a0liUjRLc3NkQUdKcjJn?=
 =?utf-8?B?bUptZGUrTmIrdnBmalJ0eXA2YjdZSWQ2dnJFY1l3aDRkbnBYVnhIQ2l1VFhk?=
 =?utf-8?B?ZENUSURSWmU1Z0dPQStUVXRSeGdHWGNyekdBMGc1eEMrcGVBMzRRZzRRZEJ1?=
 =?utf-8?B?TTVaMzdOQStXM1JReHdLQW93WlFWUytXVmhzaEM1TXJ0L0J5eGlpSjhJTmFD?=
 =?utf-8?B?STg5eUNPS2FtZ1IzZEsyQVU1enZuNDdzZExvZHNuekpFaWhZcWxiUW4xblVS?=
 =?utf-8?B?MkY5SnJaNDh2akErV09HNmV3OTVTeERqajhMek8zU045dFp4QkhDckkyUHJx?=
 =?utf-8?B?dWpJanhZUzhxeE1jSEtkVzNmRjhjeDhpNHNLVGpzL2ZRa2dWa0p5ZVdiYzBE?=
 =?utf-8?B?clZjWjMwbFRFOEFQVytPaDFTUHQrY2FlUmVGcGxhYmc4TVNQRWtDdE9rT2VP?=
 =?utf-8?B?UldCNk0wTkRqM0RHU2NVTC81OW1zZU5haXdPTmR1a01ET0hsa2RuYnlQbFNu?=
 =?utf-8?B?WFFqYy9tWk5BYkRMY1I5ODQ3ZStUUUtuRi9CcnFGOVNMTTZYYXh2VlJIcGpz?=
 =?utf-8?B?bVEwcXRXSU5BSVhJcytYM3dtSnQ5OXU0UnpxbjFnekpMVEhDajg5ZHEzL21U?=
 =?utf-8?B?cmczY084NzV3Z2NnUXM3UERYRXBVOExSY25OaStuYTFTWkZUVEMyN2dwWUxy?=
 =?utf-8?B?bFBjQ3pSMGF3OUhRa1BBKzFCQmtqM3VIcXJ1NW42dVF2M0xKeU5XMC8vNTJl?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20603e11-c415-4e4b-bf8f-08dbd588bdfc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:32:28.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGS9I7iGrQul1tVwbohYBS1cnHZVEiOjcVU5R7HY5XpBEHFTztfmeq7YPav0cKO+8rMKiRYiin9PmbkG0KbqS8Gu9h+5ce12VJ2/CCexVzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com



On 10/25/2023 10:23 AM, Jacob Keller wrote:
> 
> 
> On 10/25/2023 9:25 AM, Jakub Kicinski wrote:
>> On Wed, 25 Oct 2023 17:24:59 +0200 Michal Schmidt wrote:
>>>> This looks like a 6.6 regression, why send it for net-next?  
>>>
>>> Hi Jakub,
>>> At first I thought I had a dependency on the preceding patch in the
>>> series, but after rethinking and retesting it, it's actually fine to
>>> put this patch in net.git.
>>> Can you please do that, or will you require resending?
>>
>> I'd prefer if Jake could resend just the fix for net, after re-testing
>> that it indeed works right. I'll make sure that it makes tomorrow's PR
>> from net, in case the net-next stuff would conflict.
>>
> 
> Will do, thanks.
> 

I tested this on one of my dev systems with 128 VFs. Without the fix
applied:

$ time rmmod iavf
real    1m19.132s
user    0m0.007s
sys     0m1.974s

With the fix applied:

$ time rmmod iavf
real    0m17.951s
user    0m0.006s
sys     0m0.827s

I'll send this out to net shortly.

Thanks,
Jake

