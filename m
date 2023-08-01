Return-Path: <netdev+bounces-23192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63376B468
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6F1281998
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379E214FC;
	Tue,  1 Aug 2023 12:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B01F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:06:56 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98100A1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690891615; x=1722427615;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F14AWfYJmupfTDyX5b/jFgha5HpRy+foUU2P0g0xMAU=;
  b=QZAdT9BKn+HZfqvD+Z9Bf3JIhAluzamXErXUgx0OfY2H6HO24PGH4ANI
   QXizzxmfzjcRYZoaMfGR18SFaHmHJ8jCBFo43nO901C8r1EdLEbpAdACI
   2kvqwdSZcfdoGJoJp7+MsOuhbrsLJyQMKVo+N9yypBRmTCRmdZytbUVe3
   4UaRM+VPi9dO15Qe8QTSF1go/jXyPxDgpgB/VF/IWiFUREB5+f0fAAmqS
   H/bXFxwu74lV7FrclMQvimpUr9E8QEa26GwVVLTSU6VnMkUG5qwK1JBnU
   1RxDq2oTLcF8tW9D+q1nt1rWGC8VDDDFuUr9lWxj+NdNWgSY14CuzGvgy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="354208374"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="354208374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 05:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="1059375946"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="1059375946"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2023 05:06:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 05:06:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 05:06:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 05:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrSL/RGo4vXbzUumMv6eUsCroRO8KzNxzmZ6vSRKv19b30AxpoeilL4d7zCY2SdsJNEYgR1QWSkrxjXHhOuGPieacv2/OjaO5N+5vGUqzyJyK0Fq+jwI4vZcebC5rRh4ZME54rO5CKZNh0ekDrzzLXbjEy3C/gz3hX+ohr+D/f5QTsCX+Oc4SBmCEETatf9zmVvFBhBPwI7tesd0elDcVbk2ott7hvCCbRXR4zBCxvBAGBxetDwl+oFOJofIGi2Zx3jI9snS/K9ovqMNJyX8mefJWGjQerGUUwofMdqqxsLwSIr9YcxNdWA1JdEtL3EI0aaDcYAQvjwldpRrPeQdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkudpX37bOe329WNE8LkkHTXw8DKWWjKuHhMtaB2sIk=;
 b=dAbS/mbKJVJmGfwZWeYGLnYIsBrYCsl7dl5mdGwBt8kD+X3ulcvTiMrRxi7Cz4tYFrKAx508dmZnq6jJJe5HXzLMO9FXP2fEGvhT9b4B1jm/nj9d659nD1oaw17tX4/LGwLXg41m3u+v0CdpiwnOKwGTXkB6i3OcFMe780ii4svQV6GyzWA0FqFgfhINTD9V1Czlf6wGdcWagY59f6Ydj2l9H7VjSYArZhnxrChIavvAHqAJwKeL21BS+fB83RpFnyfhw9dZRx/zHKJM7C0+8ht9pc1ijlOt+fHz2SMaCf1h9U6lRA1o5AlNqlM7LLSw7TIZnXSH9bISBv99DTigsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3674.namprd11.prod.outlook.com (2603:10b6:5:13d::11)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 12:06:33 +0000
Received: from DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::7f4:c05b:358b:79c4]) by DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::7f4:c05b:358b:79c4%7]) with mapi id 15.20.6631.034; Tue, 1 Aug 2023
 12:06:33 +0000
Message-ID: <ddbc01d5-34c9-eea6-2c8f-6c8758a92792@intel.com>
Date: Tue, 1 Aug 2023 14:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Block switchdev mode when
 ADQ is acvite and vice versa
Content-Language: en-US
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3674:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: c0147229-e328-4019-2d6c-08db9287bf1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xDC/qLagiCgpaYvNdNFa6DNbni9w33cW+VDn13jdIfGFindTJoBMPHQPd94hcEQr8BY19DCZjLGO4Al05W3FQykHFhlAeVcBHevgbxHr0HfAwbJ7JxBanBhS5Dnr8ZgPvSwXH3i/t1PenhSlJ+QhfqN5uU65ZnpS1TbR/+leq8zsM4FBbRMYQuxZhve4v8SX7H1XjQCUcpqcaipdyRuSPTFUcbTKJloSHnmIOzWeAOWfSvWeLiRnBimClhlnfPy7mGECpTvdcQcYxhcaWJ2F2nA7HV9kJsesxyxGo4YdxxJeO/CYQhiZbbyKFov3wkMy9jzaEcWHlGFXtsTrJqlcHQGscQnm1p43vC4atcTQxbKCNUs2dFuzsWoJw2hEDs44kuH20QS2iVxbymABY3UYJ7rtFrIML4eOTfTkvwEiIPkNrE5td/ShMBzeSv4yXzp3BxHm7Yxyj4MnjxlsMm6OlBdYvU0cTVqHGlp17HJWMyjkXxCoTzhIpdNN66Xhplz6e76RmBEtkPJzIsOw3yrnwqFN4DWpe23AU14Otf484oFYfEFZme3dY1spzyDbhsqEkFRRpOBSt/2EUmYCvJ0j4eFJnolniaYYLi7cOovUq9T5cflTJSwlTqVJtiQyglomkuxuQcaFmNvhYN6qrcPSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(8676002)(8936002)(26005)(31686004)(41300700001)(82960400001)(316002)(6512007)(4326008)(5660300002)(186003)(6506007)(66476007)(6666004)(6486002)(478600001)(66946007)(66556008)(53546011)(86362001)(31696002)(2616005)(4744005)(2906002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldFc245cnZ2Q2I3bzNBYnQvMnFEYnRXRllaRGg4dDZGaVFIbjFPd2tSY2tJ?=
 =?utf-8?B?TGt4VkFid29hR1V1MHFLL0wyWXJSQlVpV1hRVkxnWG5ZYlIzOXZSOVQ2cjc3?=
 =?utf-8?B?UDV4Y1UxQ0tUa2t2OU5uZ2VuTVo3MXltcEcyaHJmNHVTRHMzTm5DbTExVVJ1?=
 =?utf-8?B?cTNZY2dzQzNzRC9oMDZOY2JBZGVHRE9pNjhidHMvNjR0M3BneHA1VVFxaStw?=
 =?utf-8?B?d2dISDYwdVViOVBPS2ZRQW9EZ2M2S2NSQ3QzQzBLc3lOQ2xFQ2tobzFOaTZt?=
 =?utf-8?B?MkZBbmVVM2lEREwvbVQza2lVMWlrUkhvRStURk9reHJXSTl3T3JCbm5ram9Z?=
 =?utf-8?B?OXZSVTZYbkRhQlBZdk1RdzVGZEYxcUZLMmtkZEs2MHV1ZWEvbFZJbnU3YzBp?=
 =?utf-8?B?NTZTUHVFbmxtODBHa21SaWM4eHRPblc5Njhsa3FibERxaVNWVTJJanY5OXBJ?=
 =?utf-8?B?Zjl6Z3k5UkhYUTlzUm12bk1HdHovNGdEQ0tPQVNQYUV6ZmUvTjFhMDIvaE56?=
 =?utf-8?B?V09vd0F5Zmt1RnF5Ui9jcVFkNllZcWovTlRnM2s4ZjRWQzM5RUdacUVWM3RU?=
 =?utf-8?B?Njg2cVNFUXVvK0hrNEtuODBPSUdiekRvQWppMmJLbkNadWx5SkEwNkduaDF2?=
 =?utf-8?B?WDlLdTJVMzZXbkVIWUVSRHNtL2NGWEZuRTBTK0xacC9jYkpGSUQzeCtHYlVY?=
 =?utf-8?B?ZjV4MnBTaVZWN3pvcDFqNzV5YkwzUkFrcy9XcE5WNFI0bnZzNG4zbEdJVlZW?=
 =?utf-8?B?NGdKQ2ptQk5wc2ptVjYrWUhhMVZRN2hLL051dk50aE5XcEVGUURuLzZNSnFl?=
 =?utf-8?B?cTlaeUhkdk4vUUVJTDZqY0tZVElaSm54TlVuZGhNbGRaa1dpbHlXdlgrdUYx?=
 =?utf-8?B?MlFkVTdwcW5JeUdxaHRBZE55RjhFUHNGMWNqWmFUVEc5N3BTcHNQbnM1aWtX?=
 =?utf-8?B?ZytTSm1nTmZHalJHT1d0cSt3ek1Pb20wVEdEM0xGNTc1bjYyaSttTm5wMG9N?=
 =?utf-8?B?V2R6ZFJ3OUc5SEZONnNFUGJ2eVRiRVJuVTdZdXdGZEErVm9weDZMUDJzaXJp?=
 =?utf-8?B?V1dsUXdRQnhGUTZMakZVdWhORVN4ZmtMeHJLU0c1ZFRTQWN0OVhYTWpnVVRE?=
 =?utf-8?B?T2FuV1RmN1daVURkb25MN1hVcnFjVzdnVk9DdWw4eTREc2hjdWxLd1NtTnk2?=
 =?utf-8?B?ZW5jU0JTdjZaYVpWZUtFY3laVUhiRjJJSkZGQXcyOGtUN3BadkFYTDViM3RO?=
 =?utf-8?B?MUJvV1RUTkxIVXdMdFF6TTByTWsxaGVHdXhvbFdTcW5BOUpxellhcEx2RjJO?=
 =?utf-8?B?TGdZT0RFcThacEdGMFdVNTRHdXMxb2ZWanZNWENtYUR5MFBXMWZFOUNzbWxx?=
 =?utf-8?B?ZC9lZjUyQkh3RFg4YVlNRUYrcmREUFpqcWJwYUtuVFBSZlIyV0pyZVRENjRp?=
 =?utf-8?B?ZjFiV1UvRkZmUUF4cnJpa3ppRXJ1L0orWU14QmJVdnZWNDd6N3k1MlY0cmsz?=
 =?utf-8?B?N3VKTVIwTG9xMjRSL1ZFaDlrbGhYYTRUbmxiL2V2eHRrc2tyWTFsWWEvNkUx?=
 =?utf-8?B?MVY3dU8zL0pBT3ZVNStpamFLTEpRWDBmODVRTThNSThOemxXNVlONVgxOUpl?=
 =?utf-8?B?Zk95TUlOR00zUW5RaUpkc1VWWGwwRU5NbFVBNmc3dk5rVG5kcU9oKzBnQlgv?=
 =?utf-8?B?Z1ZhVkJhQU5Ga2JrdVJVdGxXYkc1ZkhPUnVsYXdsaDJaNkFXUXdhTEtlREps?=
 =?utf-8?B?Y3QzNWFiRW5JZVFzOUpOUHEzakFOUHYvYjdRcGFhQzhiNUZkZUVhQ0pOdFcz?=
 =?utf-8?B?YjEvZlpwR0lGL3VwL2FxZS9yUFlSQW5IQnFZZ0RPS2c5azFtaW9QZnB3Vjdj?=
 =?utf-8?B?YXk1NWtxSVl2eEx4aUlLYlNVbFhyTTI2NW1KMlVYOVJwMWY2TUhwdXgwcEJ3?=
 =?utf-8?B?cWxTdWFaK2VwdDRmeXYwZ3NocDBKWE9EanN6NE14TkFWa01hbEJVQXM2NVE1?=
 =?utf-8?B?UGJROEpEN0c3RHFkcWJYQVhUZ2JjaWlGTHMybWladnkrMWt5b2ZaaUp5U0R2?=
 =?utf-8?B?UUx5dzFMRzBVQW0zNGxqeDZvU2hsZHA0cjVVRDBCblptdWFmaitsYTdpUStT?=
 =?utf-8?B?emxPNFBQUTBDZU52eXBhWDgwL1pZT2txbytsTE9jQ1ZWb3hlYWFNTVh6cTlv?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0147229-e328-4019-2d6c-08db9287bf1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 12:06:32.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBuZD3FQwCfxT3IUcP3WPeJ1zBGY4cndomb1mSHT8AwElVOiTVfBS22+iNR1ZdiPEw9hyWKgKp6Bx62BY/yPqTWe6a0fbkBmkO8UA1MlVoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/23 13:52, Marcin Szycik wrote:
> ADQ and switchdev are not supported simultaneously. Enabling both at the
> same time can result in nullptr dereference.
> 
> To prevent this, check if ADQ is active when changing devlink mode to
> switchdev mode, and check if switchdev is active when enabling ADQ.
> 
> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>   drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>   2 files changed, 11 insertions(+)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


