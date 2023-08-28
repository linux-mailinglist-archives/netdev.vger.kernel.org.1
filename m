Return-Path: <netdev+bounces-31028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2878AE52
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07851C208F4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014111C8D;
	Mon, 28 Aug 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2711C83
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 11:00:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D1A0
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693220418; x=1724756418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5I3Y5R56JZSP2/ntA97Co8pI7UzJ8et/cfDf35YBoPA=;
  b=mm9qEs+7G0bMCel4TwuOCwiEdF4mhOa7mjRpK1QG8vgmygFJBym0E4jJ
   jNi8DkR+9Qe9s2HXwoXaV5Bcja0NcA032BiXVh7S9RbKSl1TW/v95R7ru
   bRtMW0j/Ia+nW4mXuU+SnDXmYgJKIujpmrGLI1k31OY+P5zPwBUXGtG8t
   OxTPmlgNWhPyxJD5CbSZmMKME5748OJ1puCs7qprfENogfpic06Wq2DTI
   bss+DhAhLnkH5TX2sGVd31Zw6KNwJoC1Yy2DgEIav0+3oymY/JF7a2+/E
   Y/lJCajckVidrqsHtTGb6Zjy5mMuMCvNBq/FMDmAqyvu2Y9vx08G09a0n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355400544"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355400544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="715072857"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="715072857"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2023 04:00:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 04:00:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 04:00:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 04:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUsVBxkIR7mum6JkAx+FTyGoBw+WPDEVo1+NhGB2ejbMNLwQBATrDyNUlhZgEwemE2eJCPRwJZQPYULJ0/38TGpKdhRH3xifc0yyETiyTkDOLmHPvGyqB4GKuPrrRuDn4FA1La2OLPv29u2glusogI+ZIbwke4H2HOZf9mOynRp2i+uzHgAxnFb6aMAl3EOkKzJsmm2fX672PM1hu+HxMbuajM/piTIT19NFl2X44lL8GhEan4+i9fkVd4H6Xg5ToB/372rnox0OKW023Kbjw8oKfw4qNGTv1zqbCvAu0byzGL7iGhGmoDdraYLhyqGeBR+rWiLwy0pVao70pltzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jheqLQDRSvKt2fPu1+2/nNg67ZAeDgGCyvf8gcwhsU=;
 b=GUYtTWv5uU3xfwJAUuIG1LacPCNebPm0UHxL7P/7QAF4UZiw1dqay5hRs+Ao2gUNUhUeW2hg3eYZfctmaeGOXv6V4bFDbSmtOpXPBb3gDMycd2rcgxk9Ww8Tph0Oi48k1BX22J7Q8Seck5xMe8NoQPZxI/AYkB9YMyNFEjN6/e1hv+ObAUDMV/2pwe4WvGqodM/nRGmaDJhJIMB2liJomSS1TyiaT3mDWrc/tw5iTA87AHV8VFkYnnlekwJL8k3eLVi+qduivwgYn4dKkuOAfyjgC3xmXtHn++kvawKDG8NHGoAUgP1hu6A9eNh9z1/My8bTsy+Iv/5wSjszNFGEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:00:04 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 11:00:03 +0000
Message-ID: <1f7ec7e0-2f25-0a06-0333-665fa2df46aa@intel.com>
Date: Mon, 28 Aug 2023 12:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<netdev@vger.kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Paolo Abeni <pabeni@redhat.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, hariprasad <hkelam@marvell.com>, Qingfang
 DENG <qingfang.deng@siflower.com.cn>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
 <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
 <20230825174258.3db24492@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230825174258.3db24492@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: add58bb2-f738-4c0f-fe1e-08dba7b5ee06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TwFuzrf/gGjsM4m3/h7o4cn8FkFxAL98xaINdoPvxjJ4G43HrTGJGxp1YvlHY0w6LhaRYrxP6zOiX+/4/eLGviAvtQtmLSWTZDr1mSWaN29zTNqLOe3LGdk/mhwyxCXpDCGDTn8YDydofdg2sWw9YLBISnAZDJeb+YnUvHZb4Dvb6nsdAbR9tii9fn4k2Bh+L75ns3pbwhDS7Up0940MOLXUjqH0U+ojFkY8sHDykkh3PK7guuwOg/2BhgBhwjzzVqNNFjb0OBjX0zk0QZqXTGrgTRzgr+rzH7L3f0NdqhfpBbA48Z/HsJf9ZVi+KUFvaXKVnbTgp6+ST769K5uJEtQKPh2sUIVKPFWNHC3W1ROFRVAMvo1EVdEp96QjzvyBPMD2PxuEBnTxFnbApL/IiiweknJvyKKI+wV+9tdYISF2ACzhN/H7dl3kM9CRNFJW2Kvo4Vh6/6OH/yHIPOvq8eM9NZWBHh02W/8xK7GZzvCNKMUX29GMyAiGFKBied5R+lF6b8rptbnDCw2X7FzlewqVqbZbe8STKkfa/UYi/9IFiHZQ0CzjnKrhCD2hTofmUyyrhfXKIOiCqBUEEfLOl0QyuYaXVuLjIbeQ6tR5QG1kg+xfrvXNOfTDneoXdVCAYeKSydmt5zTcTG420mKGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(5660300002)(31686004)(7416002)(41300700001)(6486002)(6506007)(2616005)(26005)(6512007)(38100700002)(82960400001)(478600001)(83380400001)(31696002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVPMDd0VXpKZFRvSU9iQXJrUDYwU2syYUd3VlhVOVN4RVl4VnNJVWR0bzRP?=
 =?utf-8?B?NDQvUVNtTGpPdHZqcFZRQTBsWEIyYmJWWmpYT0VOZGNvT2F3M1ZWYkFsNnEz?=
 =?utf-8?B?OUFvQ25LOUc4eGFUREZEQ0poazJtMzNkZDRsTzVFNk1KWmN0d1J2QTlrOWc5?=
 =?utf-8?B?VExiTlgvK1B6WnViRDROcTBjTWQ2YkE1ZU5RbVhZSTdHNTJCNnhqbDQrWTBU?=
 =?utf-8?B?RG5sNjZiRTlldUJLNi9ZOVFHa0Y5OHhMb2NROHd0akZpYzRsNk84OVoxZmVF?=
 =?utf-8?B?cFRETzJnblYrOTBhaVR6Q1k3MEFkNXVxNGIxY0tKdno1czJ1cFVsVzYxYnJn?=
 =?utf-8?B?UEZYMTY3d1JuQkJUMEs3Wkw4SExwV3kyR1BlVThnYVAyeVhZb294cHkwT1ZC?=
 =?utf-8?B?TlkvTk02ZmZRVThaQ1FhN0dURFpzNHE5OUJCbjhkMUdka1hQenJLODlKZEcy?=
 =?utf-8?B?SmM0dk12eXZsZVl5RUxKd2xtVzFxOVNNMnU2SG5sVU1TdTFDNWZBNWdsQ2Qx?=
 =?utf-8?B?b0JRWHJuTythdFI4MG81MDdyYTZkem5UenBjU1F3QjA0dkxIYjdva1ZDbWJP?=
 =?utf-8?B?Z3dOTnJBRG5yVE40WUdNYmxRNHplK0orWjRpV3U4RUJCT0Z3Q0tjUEZ2K2tS?=
 =?utf-8?B?anNkT2c3dnJGMjdwZ3FQNmE5SDBFdDFmQndNT0xVUHUySHEzV05OaWZzMm54?=
 =?utf-8?B?NHZjU1RjUWtBWnNDbjNnQkRDVWhRckI1ZlYrb3hoWTlZeURXOGw3S1k2MG8v?=
 =?utf-8?B?SnFmSy83UGxuQi9qU3JUMkRXbi9uSG9qaFBvS3RyN2VGdTgxd1FIMzh4YjVX?=
 =?utf-8?B?K0U2ZUM1VElvOEVjYlhMbzRDZWI0M3ZpRTNPUGprWFVubFowRHhWUGRGbDEx?=
 =?utf-8?B?RjI5ckpqRmdvZ0hJWFh2RjZNNjhNNWRUZ2tyM0FDVmVGQ2hEbk5RTEFzTGRi?=
 =?utf-8?B?L3hQUmFkVVFrSHVpNExGd3owM2YvRTE5NTg2V0p1U0YzRUFsaEZMazZ1ZEJT?=
 =?utf-8?B?Q29hSHRSV1dSUzg1NlVJSnVyK3VOTWVzMndGVi9QVFphUHhaaExyLzBCcW1Y?=
 =?utf-8?B?T0VpeWNZbklNOHAxWDdaVUlmMEN5VzZXMVBJR1BiY24yN2pud1ZHbVV4TUx1?=
 =?utf-8?B?VzM3SzZGWjBWOEZmWkdacGtsNzJ4Uk1HejBaaDArdkRDVDNDTGpqUnhjaVFv?=
 =?utf-8?B?bFdWcDU0bzdDN0xCMlptdXhqZzBYTWUxNTVUQlliRiszTFgxc1Y4cXVoaHZU?=
 =?utf-8?B?ZTQ0OHZGNmlBamNhNFFqak11eFhicjVoOTF2bVhpV0tERnVKOHVjNmhCSFYw?=
 =?utf-8?B?YStSRzBjM0xDUkhXRU9FQkFranU1S2pzZUFSTFNqdGxEZlhjM003amdnZGVi?=
 =?utf-8?B?RnRpa0xwNWNsL05aQmJmaDVhYjJQMkJuTHIvbEtIUkNwSjBDM3NKSHhTZHhR?=
 =?utf-8?B?T2Z5OWg1ZUh6RHJpYzFIOVc1M3VnUit0VmVFanppVWF0RkhmQkVOTkhHeVJl?=
 =?utf-8?B?VGpHcXd3UitIQVZFSmVvcEtvYS8yanI0eHNTRlZwQU9HcDdMZzFEb1N0ZGND?=
 =?utf-8?B?MXRPUlJIZjZnRkp1bW9WQVd3Ym4yalpueUIyV2w3Y3B5dTU4L2FpblhiNzJP?=
 =?utf-8?B?UzViaHVJR202R2Z5VlpWdEJFdEF1akNBNnhHRWdMMWdFRmxyaFZydjYzaE9i?=
 =?utf-8?B?MmZGbVlSanRpNGx1Mi9hQmNhbm44Y21yVzkxZk9lLzVFa0gzcGdhMEkyVldH?=
 =?utf-8?B?WndFTk11bjczSnJ0NnFBWUJkYldwQkJEU2NtOXpoS050VFhtYVpaMVVNQjNE?=
 =?utf-8?B?UmVwelR1V1ZlUHUrSTJEaDNFZXpsSU02cGtrS1RJMmh6eTlSNU1wbUE2Y2V5?=
 =?utf-8?B?Q0VZekhRbjZCUzUzYzlOQVJVWmJ0aE1kRlVieThGYlpOZHYxVzVMMWhsaDBP?=
 =?utf-8?B?R05tMks5TDRzZE8rQTM5ZjN2TVpyOVR4WHBUYjFJS3FUUTUvZVk5VDAwamIz?=
 =?utf-8?B?STYzWkV3OUNIc3J2UkNaeldrbW94QVBDMTBVWU02ZFBGTEcxZmFTRDFPMTdx?=
 =?utf-8?B?NTAzT1luWi9HMWl6bTNycHhZbjJDSm5wZXdtV3loZlpEcTVpVC9Sc3lJZ0V3?=
 =?utf-8?B?Tlg0Z0pYa1ArdnVyQVNmcTZmeUl6cStSU09TQi9wN09mV3VYWWNZQ3oxSjN6?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: add58bb2-f738-4c0f-fe1e-08dba7b5ee06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:00:02.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPFcjbKtsmyJXeN+4wD3dKVgSLm8QcHd+wzd3doogiJfhRc+K0suzfxFEHIo1zka4XJ7rtjPQsXOZ8x7AphXhnwDavPbBpaLjU9/fmQLrUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 25 Aug 2023 17:42:58 -0700

> On Fri, 25 Aug 2023 19:25:42 +0200 Jesper Dangaard Brouer wrote:
>>>> This WQ process is not allowed to use the page_pool_alloc() API this
>>>> way (from a work-queue).  The PP alloc-side API must only be used
>>>> under NAPI protection.  
>>>
>>> Who did say that? If I don't set p.napi, how is Page Pool then tied to NAPI?  
>>
>> *I* say that (as the PP inventor) as that was the design and intent,
>> that this is tied to a NAPI instance and rely on the NAPI protection to
>> make it safe to do lockless access to this cache array.
> 
> Absolutely no objection to us making the NAPI / bh context a requirement
> past the startup stage, but just to be sure I understand the code -
> technically if the driver never recycles direct, does not set the NAPI,
> does not use xdp_return_frame_rx_napi etc. - the cache is always empty
> so we good?

+1, I don't say Otx2 is correct, but I don't see any issues in having
consumer and producer running on different cores and in different
contexes, as long as p.napi is not set.

Split queue model is trending and I don't see reasons why PP may require
serializing -> effectively making it work the same way as "single queue"
mode works. Esp. given that we have ptr_ring with locks, not only the
direct cache.

> 
> I wonder if we can add a check like "mark the pool as BH-only on first
> BH use, and WARN() on process use afterwards". But I'm not sure what

Why do we use spin_lock_bh() and friends then and check in_softirq(), if
PP can work only in one context?

> CONFIG you'd accept that being under ;)

Thanks,
Olek

