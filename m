Return-Path: <netdev+bounces-40860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2707C8EBC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78436282E5C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999F22EEE;
	Fri, 13 Oct 2023 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdVIFwZm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495F37A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:06:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294BB7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697231213; x=1728767213;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wdMcyQ8VJS32AKrvxh4LZBjbqPgikx7dzirBepDE19w=;
  b=MdVIFwZmENYv6ax7VH4yenpMtt9zfVzI1chtvNoSQDIrzMPNqjNl9vE7
   cYJfsqR7b88xazIres3hpgPqqWFXud+1e4I2wjl2LftSd6qru13I4EY9b
   5oRWjK673WzhRZXzZoU+Vy02CSt3v9GkK0GbnyG3sm5MrmX+nXCRckX1w
   u2qiIzWjzKfE7Aj4aUkHlmtn5ZdMU3UGUNtVffECQACSFxHVL0CNeH2W0
   83AbxffhDQ0aLIfTdDCEG9H40A8CtRGqjNZ1zZ40eJ9IDu5lHI1kYmFge
   sqoUDmoPbKB/FQA5Kq/f8VB80O3GaCOTUuicxQAOKj7kMcpsrb0DkYBfd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="6830427"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="6830427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731499168"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731499168"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 14:06:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:06:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 14:06:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 14:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHOrwxwai++6POBKiTvh0XpZRjxEGssHwAKE1uMnqP+gMoNgu7jL7gNNXjYmY6sdOX687lzxvEdsYO7NqqRlhMpXhd9O6P/xEk6xhj4iwi7rSf0l1BjNojmfyAyGAj8iJ9zlYp6MsqtHWU8gqahkSDenS/S6SLRv9+Mkv8pO5DNDZWRfFjARL2gOfKfXHJ4LexU/lnK3w0UPB5o9zn3544e5nSi9/Yr+BGK9lqn4CT8X0/FPcJSYswF2vpxvpPzkd//MoDduCJ3BPBG41XJMbMwT/EiNqFHk8fdaha3WG3vEH3Fg8CmmNopLt+TX5GijrXJ2HKV3dN28KX30aeCOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdMcyQ8VJS32AKrvxh4LZBjbqPgikx7dzirBepDE19w=;
 b=T2InZH7aWJbw4VAwCvAo4doAA4J3yvRXgBObTzlWt+e6k2vVY5DL2wILnZvZtGwf6njCIHZad1UlI2MdMXxsf7sseSppoT6i9ffwPfH2sDe6XF9tmoArcDhsqreSDLZfuUEpu2O2BZwSjPjhbcZicDVQFK0fVEpV7q44H/+QjPlu60rP41g3gd0L1k6oDBtkyWD+m9UQbkh8ROey3rjkZvYVoui4cSguPdVWn6HBE7hHc6vwH+FY+9fXVmvSZqhR6z1xxL+sciiHw97jT+DeL9nuxi0HMgKfM5yHTvbYp/EPmX3Mju98noBN3omFes/Tfjrk2OSBe3A9IpsK+nF0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 21:06:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 21:06:20 +0000
Message-ID: <52692e57-61f9-4eef-a537-78ac84aa76b9@intel.com>
Date: Fri, 13 Oct 2023 14:06:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stub tcp_gro_complete if CONFIG_INET=n
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	"Arnd Bergmann" <arnd@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>
References: <20231013185502.1473541-1-jacob.e.keller@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231013185502.1473541-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6f2137-028c-4ac9-b745-08dbcc303f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZmEY+l5Whzy+bPLDwace6EbFQJ6+hoyAHMmJxPGuK7ZRF99KaPcajVsUfihhLZEHPYbkFku8d5194bhMwxulPDHsmtabvrrJXo0bc3ggHik4iKARbxIXcSFHIWyjUJl+s3FDTBGo3Vv9+eYPcPognpE1SrBvtmFKz3y0dytk0J1KoeaADa82agVua0w71+W+CE97Ujj0XkuQfTo7GU/szlusrP1WdimBBIPTU8M16eLsV3bK0WbzYsDNeqefJftT9wJhti19bYcBet0pJoCMWjItvTYqPLVW/pfLNiptLdhmnnidnospDAq3wCp/J+yxwz2lGmsFVXoOMYTvdvmR2WNjOQsp+wn9S2dk0zvehH+hUsqtyuq1J77UU2kLpIWJ87svM9wVop/s5dFyxWTRajSfrL/WI8HVdxerwLcA/vKuQinBLQqAOSNRKGjm6UsJjMRK2h4o5YXD8OncJZFq8JR2mfTKJH28o8OR+j5Ud1jZsHdv4Aet7CZWaP79+EXqnRcIVmq/6bonH0NIloaT4vGCrNUxESU/1k4dIXWj1JB+bApYh3Tjfejyo9cLztD5IuReeIc0Xz1uK7JArj51WTm5YWufSDsS7+WOqR46zes85RdIyfAE/s8rCVOBRcqHguoi5KQC3GedbUw4gMbnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38100700002)(6506007)(53546011)(478600001)(31686004)(26005)(2616005)(8676002)(6512007)(2906002)(558084003)(86362001)(41300700001)(31696002)(5660300002)(8936002)(66556008)(66946007)(316002)(6486002)(36756003)(66476007)(110136005)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VEMEk1SzRydGZWVHFxRktYZ2RrTnhvd3JMNEFacEF4ZHlQYlF5R0Q2MjhS?=
 =?utf-8?B?ckIreE1qNnZNNGN6T2tiSDROcXMydlpPR3VpVDFtUEt6LzhtTk42cklsMnBT?=
 =?utf-8?B?WVYrTkJlQVVsOVdVeGVPU2tuNWpYemxnSkV1TmNpNFZ4WUlRVmZYYStMdW5Z?=
 =?utf-8?B?V2xOSjUwbUV6QTJqMXFGSi9qbDZ0eEwzU1UvclhpK3pNN1VpQU5YM1lZNDBy?=
 =?utf-8?B?Z2lhM29qamZSeUdVRSszUWtGZTBTbUoxWldFSnNaYWZLTFFJWEJseFhlNHhW?=
 =?utf-8?B?OVNsUHE1akxLQ1lORFVybnJDOVY2bFAyWXZVMHd3TVEwSUYxOWZzMGttUkln?=
 =?utf-8?B?WHR0SW5kTlNWcHN5eG9FSzJheUNkTjZzL0lGWUFINGo4NnRIK05ld0tJQTdz?=
 =?utf-8?B?OWRtNWhtZjA0bW5KMVNEaVRvZFM0RDcxd2FuZEt3WTFlZDZaZ3BGSUtCblUy?=
 =?utf-8?B?clRKRk9jVUVHVU16bWZHVzBIYS8yVGZNSGtKYmpFQ0RoN1g4RHhuUGQyaTBj?=
 =?utf-8?B?MmkwRGU2a3BqOTRZck9SSlF6T1FKSkxtVWpDL3lkL2pSWjdzKzhaekRMak9E?=
 =?utf-8?B?UXpNcTdUQXppMHo1Y1RGUExhbURFbzRHQkVxUVdJcndWYVF4aXFKQk4yZ2hT?=
 =?utf-8?B?SzgxZ0k3WTZJRnBuTEZTTENqbnZRZTJWL2Z0NFp2Nmd5TFo1SEpNdmJuRXR0?=
 =?utf-8?B?RmI3RElFZDJmREMvRUo1bDNqWlo2R09NU1JobFptUUdRWnNOSm5jWkhqL2t3?=
 =?utf-8?B?M0NHZElpakVqODM4MFUvVWwvT2d2eFQ0QWFFN3FHTVloNjNmZ21uWUFNSXQ1?=
 =?utf-8?B?cFJSZjRFcmZQbUtFVGhYTXVHRnVzUlFUeUcrbDBDbDFhcXJIM2haU29qbTE0?=
 =?utf-8?B?eDMzTG82bzcydUorMDNJcVkrZ3NSTXFwR01NenZsVFpRQmtZbVk3eVMwWlZM?=
 =?utf-8?B?WUR2TC9oMWVGampwMmdyNmtLZ3FQZk1mMFpPR0I1dk9ZQ014a050dkFZZEtm?=
 =?utf-8?B?OHB4Y3l2dVpUVkVnK3VKWlFWUGEyVFUxMkRVcWpFR2sySHMycjI3YmpqN0Vm?=
 =?utf-8?B?YmJSVWRYeHhHM0ZoRE05a2lHRnpiU0JLNVJBcFEyU04zVytzZTdPRHhkV1hI?=
 =?utf-8?B?TnZkRnBkSjJqdmpXR1RmUmVNNjBKK29OcmNZZm5OekFoS3pqWFMxRDlVZldB?=
 =?utf-8?B?c2R1VGw2cXlsbGdDZERNM2dqcHlaZ2FNUkc3UHFOZ1krRmZKTlM3RGZSdGZV?=
 =?utf-8?B?WnEwd2JkR0RIMkMycGl6RWVHTFJLQXVNMFlJTkIwUEl1WFIrWmVqVFQrYUUz?=
 =?utf-8?B?L3RwY2phaU1waWpxT2pQRmVRVXVtQXBaZzNGeENRUDc1WnJuR1VXK003b09L?=
 =?utf-8?B?dkdkcnFEaVB6TU8wSjlGLy9HRmp2ZkNYU2RaZ0ZLU0xSNzZyRG83R1AyUFhj?=
 =?utf-8?B?bDVwUk43TFFTRklleEV3a2hMRTcrQzUzVjNub0ladFRhQTJBOGI1SkhsTlgz?=
 =?utf-8?B?WWswM1lGU0hGaEtJTmdzcmJXWk95bXoxa3BkVlhoQzJJOTJTcnhIQkVqR1JC?=
 =?utf-8?B?NThxdWRpTWdHNUFNNzY3clQ4SnhZdlZJMUtpQ2pMcjhPcmdaek1GR1FsM3Nh?=
 =?utf-8?B?NysycWdVN3pkaXQ2bncydU9HSCtna2dKWVAwb2FCMmdMR0I1SjdFRzJtcmdB?=
 =?utf-8?B?b1NuRjV3a0hWejRzZXMzWkp3aVc5SG85Q2Y5STAxNy96a3F6WUxNREF0YU9s?=
 =?utf-8?B?UVVKajBUNFJRdUhTRnZta1lRRFFsZjM3RGlkbkdSWVFhT2Rmd2ZOMXl5djV3?=
 =?utf-8?B?SXM3NXh2a0tMbEJlZEtyV1lWRWJJWVEyMDJ1dVNpYTdJWElMZm91cVhZTDNl?=
 =?utf-8?B?b2Y4R1RGNkk2cXg0MkxiVVJSU24wWmQyOVNxRDdjT0swNnNlcTBpODVyRGYy?=
 =?utf-8?B?ZEdRazZJcW5zOENycmlidVE1cmd4WE1rajNpRC9yNDhyTzJBUjFaaGprT25v?=
 =?utf-8?B?dVh3U1J6RW9nRktsdC9ONXFaY081Nzd0TEF1SnFGMFJNZTE1ekhwS2tvZUFs?=
 =?utf-8?B?aFBHbEZQYm5MU2pkR0thWVY1bEIwNzR1YWZHSGhCMDVoK3NTazlxSzgvYlNN?=
 =?utf-8?B?Z3VXN3hqNzR1Wld1QVRlMzV2RlJJWFpKMDVWK0hNazEvb2ZtVjdjSVRrMGRC?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6f2137-028c-4ac9-b745-08dbcc303f91
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:06:20.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJNLco2V43Z5pryEAdNltJ7CTwfY+aQ5C7rcLZIKl1Il78mXcHpIVwC7zxqAVSN6WHTZnZQ++L256v/3d69oY/5HefYnzca2gGzGTQx40iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/13/2023 11:54 AM, Jacob Keller wrote:

This should have [PATCH net-next], but I forgot to set that when
formatting. Sorry about that.

Thanks,
Jake

