Return-Path: <netdev+bounces-40499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB887C789C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C3C1C20B19
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98273E496;
	Thu, 12 Oct 2023 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvOCD/Xg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB553AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:30:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73644A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146212; x=1728682212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q2hMi1D/EzAzjMN6aXFYjoyjAsjcsvHWWi3djfjhEhk=;
  b=IvOCD/XgP9zW8D+KF2SM5n3ZD0KepugFC9cXC7CeSW1B2iGz1VeOFHF5
   ff+AtN+2o5GC0JKF5JaLm6cdJP2W6Awg3vAxKoKYz9etFR1QxalQVJTp3
   U1eqAPdkNg+BrxtLoVuOH4g7R3kDhr9cbe+CscUBtqPJixCfiyHqKrFQB
   38r+gBTGbvAx2j7x9vBDVeD3W2RFP9HYHzG1uuCXp+lbEMGvvhM4IyxPq
   5sUimPiwEkqJ8WQfJx/Eqk8emOik00uSHD1n7kozsUjdG7gW3/sGnPXIU
   f6wqvZpRkChvPNOwfhwxQyck2WqcGIsTeRH8v66pSwhxvr2E6CALI7x9K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3635867"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3635867"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928154070"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928154070"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:30:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:30:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:30:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:30:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8YLKBeP3awMXVnQ+PjF3sGtYD/8r1YrrjmaGr/qhknhqVUK+fSbQ1lv0QnAxG/2SHXXnJ+B+WFWojehi6UzcXre2tlk8DetbXlUf74SrPq0FDybwqrtkoxUpGwM1/X5iR0mj7tkxbYpO3ciCZSVMGB2HQcLf3QZE77+15xgcT53p1PNumpG086PUHJa1RLK/ZjOMqKb760+5nhF0496dAsmPnA2Esk9XjraQS3vYWk+3PMFNrTzm66a4L7uLTLrflmGgEbDyHzQOaFyecUh01k3eF58O7ogKh09M+1rVR41VyxvzxOc2IywEvylh+hO0ggZdZS80SZzZVriakw9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1aapf99ErzDweOa+fWl9NfGXaXEmBikRudJMrr+BR0=;
 b=AAlix5XmGz6lWymWbAYRzpxMNO58ju7UADCFVwN78QGwV8ee1AtcZpy6QZYrUA5v5hGtO0yJL7EGPqJskJmZOMqKO6vs8XRU/c5zgJHDpE0jQM0yivhXU/Gc1Giu8Hq58vM1WLzCINCM51C7JA1PEiIM0Up5q0R4l6SBLIi2yU4V8jRJO+6jdzCUedHmRT0LXBYyC6VNhxEC9wXmRu392yWFo1stcnvCOJfmMXIX0Hp2R2ukMHpks86Tqddjqu1TiLYhVys8hIYoUqzO7Yd8FPFrYYUaSAbRLCMCpXeu6UPFfyffLn1N7oU9zbjnuP+jzHKlXvX+xDbub+SIKFDeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:30:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:30:06 +0000
Message-ID: <e2cbded6-ab97-4998-bfe6-20f46e219ff7@intel.com>
Date: Thu, 12 Oct 2023 14:30:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 09/15] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify
 code
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Yu Liao <liaoyu15@huawei.com>, Leon Romanovsky
	<leonro@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-10-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-10-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0321b620-cecf-46ec-8308-08dbcb6a6769
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7CTAuTPs1OpL15tbk8q+tIST6TLWv+Xii8yJXOPKDMdvpvJCFwekQaJQEgqbVwQiRTAycBo4S7m6qYqt1cGv7c3jrX8sGhioJTyrBESHUS1QjyG+ovT+73dZVV4iD2bvSZiwPgCIdWUkhDvv/TeUrOZwLHLZOcX9x3GDinZXhngZ9fuwHjaEjb4VSpwPVXLqlBJWQrcPtfDqH+UMQs4yfy1BVl9dXz35obD3krwWjZ0OJ/QTu8i7RKOTTpErRAMzR4V1Mr0xah2Q37a9gzV/KVel2/Kkod72NfE50v+MJY7H1MnlwB1wanj4z9lMUjtcTWOmvFjJBRNEorpmVlanjFoxvdviQ6MwjAnsxvoR8PHuSY8e4ylpuOeosJ1CHWCF0F8R8o17qPvwRF7o6eNjRUMsNyUzHt/QgR9QOSAHlSHC80Evlcee8XZHVoYTuYv5pPBhAR81+ZOCu8XgoITHq2290k7eDcXZhOa6+hL5dkegf+BrK4iG1NeC2qlTqrNVen0ALzY09AjA+ncmYvB8+Xfr3UT+Cu+pMQzwjUDGcY9HTQcHq26Oxq9xKKniLoqAHXjNzGh57nFLoZ3VRAqxXr946UI8nmrKNBQnP31h3z9isXWmkrhrAmHn0IFo3SmI6imX+9W2tZQ+Q6vZj805w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(66946007)(66476007)(54906003)(66556008)(110136005)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(478600001)(31696002)(2906002)(7416002)(5660300002)(4326008)(8936002)(8676002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFYS1REY3lpajQ5TFRia3JRR2JUT3lHMXk4NlNxUzdKbTYvZXA1NGRRK0li?=
 =?utf-8?B?alFKd05GQUxDTWdJL2U2TlcrQ3d2cGRJQTlaZSs4VnRDa1NMbXR5UXZuazhX?=
 =?utf-8?B?cFpwUXp0MW10UzFqU29aYmlZaWtZTklEZm1FTjd1T21OOW9senNpT0J1TlBM?=
 =?utf-8?B?dS9FZ0d1djE0bXEwZG1WTGgvNHNudm9KRVlHTVcxM1Z2bjUra0NzR28yT0M0?=
 =?utf-8?B?S2RsQ0JtQnZoSHlEWnhIWm9ZVmQxMHJOQ0RTQk1ENHNjbFY4em5DMnhRbkc3?=
 =?utf-8?B?SjVsejNlbm9GcmltZHBsaUtCS2F6R1FEckV6MFNGYjAxWEJad3ozMjR1cUE1?=
 =?utf-8?B?Y2cxQmJLbWpwejJKQTZKRXlvVytEWWZNZzBqcUg3dHVoR2x3Tk9Ubzk5SnJn?=
 =?utf-8?B?aFJrZ3ZodlAxUHRQc0NoOHh6NDBuSmFxbStOVmdJUFRzR0Z5bitoS1cwZFRa?=
 =?utf-8?B?ak9sbHdOQUpsL0hZZ1prS2x2TXJUOU81V1ZaZkJYR3lKN2p0QStBVkMzNVo5?=
 =?utf-8?B?NXp2M05KRmZuZDJSU0N2aHBMRVFGRm5LYllYUXllczYzNUlKcjZoaVVPYkxt?=
 =?utf-8?B?d3FIUE5nbXF3UXZXNzJWbFFlcjFQZ2hJUXRFOGVOTGkwWDc2M2p1ZHJuSnJN?=
 =?utf-8?B?cVNvZDRiUTlOVGw3Vlo3eFg3VkRnbDJ2eDRXeTVtYUEzLzF5c01sUStIZjUw?=
 =?utf-8?B?SWZFQnBIYXB5Mjg1dnNsZTRhVXRoZCtHd1ZEaERBVTZhTkhtR1QxWkhXM1JK?=
 =?utf-8?B?YkhEcXEvN3pOckRMRkRrWHNTMnNFY2pQM3pCU3FTcVJuZUNlYjBrS25yZkhX?=
 =?utf-8?B?eWc3K1hFQ052K3JPVGY5eUxiTXllOWl6SXZEQjFNY1RpVjBrVHdBK0F4SUFr?=
 =?utf-8?B?dXNReGFmZE1yUkFPUHNKMmJTR0s0MExpVFNSeGZZR09GOS9LK2sxQjBwQ2V3?=
 =?utf-8?B?ZGgxV1ZuQkNvQ0N3ekJjdkJDTytZTXh2K2xJWFVhQkVBT0V1emg0SEdYbCtB?=
 =?utf-8?B?UkZMVld3Wm9FdnJXcHRsT04xM21udThwVWtCUUF4RHJRL3FNM2d4Wmh5d1Bi?=
 =?utf-8?B?WnVaSEI4WGhDSmNvMUZ2c1RaYnpkS1ljM3pmNWd2bktxSGVZbjJINFlnSU5Z?=
 =?utf-8?B?U3hCYVZnN3RMZy8yWXNJc2pqL0p3UjlON1dtSTRxbzBDT3IycGdlNTl3TWND?=
 =?utf-8?B?OFl6UXgyL0JLNDVOR3JaSnE0RURJRGJRbUpzYXRVVS83bUFncEpwYmg4UXRW?=
 =?utf-8?B?NERoUFZxUUNjL3ZsUmQzR3FScUxRdmZFSm1mSytVcmI3OFlsMW1TNkxES0xD?=
 =?utf-8?B?U3pjQndubSt1Y0gyTHUzMnFCei9PU29rcGtrS0xiaCtUVFJKS052MGpTeTJu?=
 =?utf-8?B?NWJSbk4yYTZ3Z0tjQXEvRHRpdDhiMjNKZmtrc1Y4aVRnRWVxTlRaTEpIMmZQ?=
 =?utf-8?B?ZW96T3VUL1VMZVRHZUNHTkMzdHV2RlZYcTNGVDhUYTlvN2toR1Bkc2dPTEFa?=
 =?utf-8?B?anJPRzhFb05Kd0FCNHJVaEd1U2pkUVR3OXE4QnlVNjZ3aEtNcEZrRHNiaWtH?=
 =?utf-8?B?SXRaaUozVXV0d3l0V2tCY1dFbU5iWGRuK21lWWU1enRJRk1TZDlLVy9nengx?=
 =?utf-8?B?UHorZ2dMTG82aWRMd0tmQWNHeTQwTTY3T2FDNGxLRGZvMEJ3MXpWQ1ROZzMy?=
 =?utf-8?B?S0FvUGpsbDFPc2VDSzBZMDBjNHMxZ0FlUHlXVm51ZVBqSVZBRlRLY3pCdWtj?=
 =?utf-8?B?MHVtUDVvM1lzWnZCTy9La1B2NGRHY3NRVDVFT2tPQmFPYU5CUGpWQ1daaHdE?=
 =?utf-8?B?YzFLTjRtMStwZnlhd01lNmtXMEJsajFJTzRVaDE5dHRPZ3Q2WDg1YVpuTUlJ?=
 =?utf-8?B?Y2IyLzFDTTNsQmxNM1E0cVcrbXJrWko2TWdsOVpiTkN5aWlrdVRuTFdkTUhs?=
 =?utf-8?B?eEhOY3U4VG1LWllpWnJndk9KeFdVS1h5TzlvRnV1dDkwa21OVzdFVU1LRG5J?=
 =?utf-8?B?dE9oWmV3Z0MxNEZoS3ZSVUZtYUdmcENYQlc2K1NMdTB3YVgwNFRxNnJGMFFh?=
 =?utf-8?B?TVBpZVJXNlo1V2pHbDI1VGpXSUd2OExVV2t3VGx3MFFmN0FNdnIyN0NCZTFC?=
 =?utf-8?B?SVJqWDF5bWh5ZW1ob0RWYUdlbFRtMytORW9jaWNaM2tzY09yMWFKRDFvWDBq?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0321b620-cecf-46ec-8308-08dbcb6a6769
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:30:06.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWFz8Q499eBKSNZufT+kaP0V4GaHefuF43Iyu8FN7mSQjAgOwBISr6LHpi02m/3fgMm+mSfGytzy1Q71Ka0s/93WfeKmnKpPgU0RzMApp74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Yu Liao <liaoyu15@huawei.com>
> 
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

