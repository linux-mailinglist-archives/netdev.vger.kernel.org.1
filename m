Return-Path: <netdev+bounces-42037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0DE7CCBFB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158BDB21070
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB812EB03;
	Tue, 17 Oct 2023 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAmB1rrI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DB2EAF3;
	Tue, 17 Oct 2023 19:15:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A465ED;
	Tue, 17 Oct 2023 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697570101; x=1729106101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwQZwZUkeAQbbLjiPEYgszjdaN+qfPlk7yFGrJc0X+8=;
  b=YAmB1rrIC+i974+jKEBKBzBmjulBTbaboL3bbxVNOhXxh3MaasQ8l7+T
   PtQeMXK0zQMdKOBo5xbEkndU1b2tNOGA+KTbKSZGTNAVmqy0wRS9XPFSY
   OLxbe563VMvL8gGPJoErVVt4MrXfjNzWKn6lmdMt1O6UZg1RoXTrFgijw
   apod9Gk/x33o9D/8UkZg6QVe4xoBwA7z9HYxcliOkKOfGqxXAcKc6q4hj
   1/9aypA9Q9QkUhT5jamFVUYRgR6X5NIwvmjpSFiCPlTENICW1GG0SdELB
   VFjAnpAQ1CMFb9zaPntdT7fsQ7D+AMHeYwE0Ox7J/u392tmPYdpX8s6AB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384741491"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384741491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003462693"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1003462693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 12:15:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 12:14:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 12:14:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 12:14:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 12:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPPHXpFllqwBj55UymYh9ucQwrmFs9G9X/cRL8B4bP3yKULkqLTppG5AyeZTFUQUZA5kD8bH65rAtX6Zx58aCDvpaq2Wh/Fv56VVaqxjPH9TwETVa96/cZQRl2C9emeGO0wJNH4Au8R4TzkIAUa8/nz7WHTRq4eRh/GLwWKy315pveWVpN0EMYexP2WVS1BCr1GC05dyBiQBATdF9Ttd65IjY6a9knx+sL7bUHWquc3Laf4Unjq/ZwVV8Czx0saXZg2Dmmnl0gdyW90DJw+WXh1DFofHj/Wcg2wtfu02m67EGvq7lts7/dPUHYWiUVHIJ25mFVGkk3+WzINkhd7D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymuv79SUXOFYNGn8bj6e6TOoXsM92f2gwEzjP+9A56k=;
 b=NIcT3D79U2AE+F/tzR26VFsuLZkmyxfUbHa73HqqR6cazemBbaoACI2Y2kVleWg9KzJVZdWr0ylh4Qi5hXKoPyCrx7unC7//oQcRwlfRXhAtOXkBrOtIPhdHskop77jKxh+5Tg1qH3lx1NPHflOATZPjlZEAjzXKy+Vo1GhxwFRnxUiNeZr/dY9ethoyQKNCQL6+ub+AAJhDqXyP7dPDndR9vWMwdyispIV2Cg71+LKqxttIXkyMRYeXI/u58HNAjeyfMvec8sIbbipoq7qY1SzmScfZf6qf8g7mYGCRbFjrIGvrQLUjGMpJS6kuSjxMkZCiNE/DAjWm6J7cHk1aog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:14:57 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 19:14:57 +0000
Message-ID: <31cde50b-2603-443c-8f55-a0809ecdd987@intel.com>
Date: Tue, 17 Oct 2023 13:14:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <corbet@lwn.net>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <horms@kernel.org>,
	<mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
	<linux-doc@vger.kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
 <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
 <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org>
 <afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com>
 <CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <CAKgT0UdPe_Lb=E+P+zuwyyWVfqBQWLaomwGLwkqnsr0mf40E+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b60dec-b07a-49a8-8836-08dbcf4559e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05KL1iLgaxOwYISgRT2PPT7ErxbxsozPB6tUQME6PZ9HCJX7q14U2Cg09nVsTxSXKLO1EqNIPg9pqsQRxpQ/z/StreyCCa2nOknsO4aK2R09F4j6Re74Jbj/1vFOMoSU9nf8gwRYQAbqn/RcJmCILoochy6swt8B7IWf47LJYevNsgyp+qjGnp3ul+WDUaAmKI60CbQ7+lync8oh8mOZLFcdBLmBilWyeqPOP0E94CJFF5eOSpxAfN/jhxCYRX6wYNTSthA/Q7LjBQoMW/TuDlBwVqff/iGsxUzo6VhPObQQWbKQkZ7LqULjCgzU+2KPAMDxqfYkbf0Vn+7JITSZCF49KKGCcurbCSDj22FWrTkF7YiH0uOISkMWw5Z0SqqWfBN3Ekz6XOJp/rFPaW4iZ1SxxqCWhrNLefyBMNzlajx3DeGTd6Zo66l2NFHXhPTK5E0d1TdsKMkrPOlPGlBqUQClSQELpja9y/QaxdN8fp7Lar8kzGlGWTqxlWe842h9XDmZjjzzUe7UguaYDfZxoLI/hncUJ2piinsGI19W2CVZnJas6/jE0yZoriTqVA1ED4xtt8EhiGKrv6LEt8XgZHK2qTuA+3DznzwWMoqB5wvtoBY8jBU1TtKtybqzImEmAxf4Z72Cc3HRu3JYXevFbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31696002)(86362001)(83380400001)(8936002)(4326008)(8676002)(66946007)(6506007)(478600001)(6666004)(966005)(66556008)(6486002)(6512007)(53546011)(7416002)(107886003)(54906003)(66476007)(26005)(2616005)(316002)(6916009)(4001150100001)(5660300002)(38100700002)(36756003)(82960400001)(44832011)(41300700001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExoeWtCbElkTlJ2a1MvSTdIYmt5RTVaT1FBSHJWbFI4ay92cjk2amRtSU9n?=
 =?utf-8?B?RWJvQmdLZDlxY1BSUGs3cUg2MGx5bzNZQ2YrejZhdElycGplcHlrdzVCWENl?=
 =?utf-8?B?dUdIUTlJSGI4ZmZkWDl6YVM2OG9QaUlLZHN3eEVCMmc4Y0VNZTdqTTB6T2pN?=
 =?utf-8?B?aXRlT1VEc2hrNzZFN09mUzFyY3FpbldLcnBocTRxNGpVVEw2L250MFNCcHBw?=
 =?utf-8?B?MUs3Y2w0VkgrZlIxMDIrSFlTc2swc09kRlBXOVU3aVI5WE1VWEszZG0zeFhx?=
 =?utf-8?B?eVArUTB0MVEvT1kyUFJ4RkVSa1Ivd0taa0V5enVGVU4zQjh0R2tMQVFUS2Yz?=
 =?utf-8?B?WWpNRWxMZEx6Qm5CNzlKOEJtSlRqR0xoQ2tzZ1BHWW9ZaWl3MXo1UjBMeDlj?=
 =?utf-8?B?Mzl6SDAyL3R2cU9XdEEyVmt3T3Rpd05FbzlBbnVEVWREcUVFS2tQOHJlNllC?=
 =?utf-8?B?MWpZcCtBSEpyQmNxWlNwdldKdHc1Vlg1U2lSMzc5a0J6SWduN2U1ZFRRSHlD?=
 =?utf-8?B?M214aGlURXIvWVlPUG94Z2ZhV0Rldk1DbWdoL1NvYVhHQmRMQU54R2dDcWM3?=
 =?utf-8?B?aDJwR1A1aWkvdWdyNUZtSEZncVYxVkJaUG1wK1dXdG1RaTB2aU5MRW83MVgy?=
 =?utf-8?B?bXlFRkhKalY4c0NHM2F1dkVvY2ZiUUgxRm5pbDRQZTlXVk5XUmFZMlJLU1lD?=
 =?utf-8?B?Zm5YUnB0dW85MWVlcHJBc0hDa2kwVXpockgvcUN6eXhsU05DcEp6enRuMjc4?=
 =?utf-8?B?NmR1UTdYTHVWUWR4UmtRK2h1MjVIWVptNkJaRXI3b1hWaEVvY3J6UmhFb1ls?=
 =?utf-8?B?OHJvOThucUJSM0tVZUNYdGxLbm4zbHpEbTJaVGJNTHpKZ3FFZ3ViR0htWHFM?=
 =?utf-8?B?T2lBRTM2TnJER0JEcWNkUUoyU241ODgvMGt1MVZOTUF4U2U0L0lOMmF0RVU1?=
 =?utf-8?B?b2VFc213YW9QWUFJTjRtU1ZVaFQ2ajJjUXIwMHZEOU0xQjhpeVZpeVhueEZH?=
 =?utf-8?B?ZjJURTNrSzRPY0NYelJNSnBPdWFOKzZJWG5sYk1tTzVPVWtTanEvdGxQcmFN?=
 =?utf-8?B?Ym9jQk45VVJzMWdvUnB2K2VFOVg1Q29uV3ZkMzNCNkpPV0dNOTlXaUFMRE1E?=
 =?utf-8?B?V3VSbHlUZy9BdmxYU0UvbEwwNjFKdDJVYXllTnYxaktrbUpCSHBNRGVvWkRo?=
 =?utf-8?B?VjNXUTA5cXIycFpYNVUzcXVtUmJrRW9vTEhaMm55R2VUK2F2VjBXMDBYRUNk?=
 =?utf-8?B?QTN4R2dQUkN4MnY2dU5wOXBWOWdPSDRkL3dLemRBOGtEcUw3aWk5NUdDNVBW?=
 =?utf-8?B?RjJ3ajZXbXFoU0IwNmNwR1dCZStWWUYzNEpQM3o5MU45aHVkQXVhVXFMQTVo?=
 =?utf-8?B?N012cUZDaVQyWXZiK1d1ZlZvVFJSWXV4ZTFPYXZNWjZxZmJBTEFNQlc2ZmRz?=
 =?utf-8?B?Y3F6TUpaNXZZampVZzdXTUE5TVVqb0pyVGw2ejJhY0RXVDFFMktMSlo1eUQx?=
 =?utf-8?B?Sk1uV1owTDBLUjRSVHBMSS9qVzk5Q3U3OEJjcGJrYVdyb241YjdLV3ZSc0Za?=
 =?utf-8?B?b1J2eFE4ZmllaXpsbStoczgzTjBWOEYwbDNNNEJzTXlKTktPM2xyeEVWV0lR?=
 =?utf-8?B?R3NQenE1UlBKYVJVc3J3L3RMUitwR0xEVis1K21vRmRnakRBRjRDaVF5YTJ4?=
 =?utf-8?B?anNERGZYZHIyZUhRSzZId1ZYbk9pWjdEdDFFeWZuRzVkUTIvQTk0bEt3YTJh?=
 =?utf-8?B?eWo2Y1h6UXRmZnRjR3dKUDUwYUVTSVJWaytYcVMvd1hyd3QzMVJKRFROK29t?=
 =?utf-8?B?RXpQUWxEWlJ0ZnNzTEtrTTJmMml2dW5QWVNGc0wrM3dqNlNKMDRMaHNrazZy?=
 =?utf-8?B?TXlFdjU0QVhRSExZODZFa2x2cVl3blJreXlKeVcvRVA3ODNQSnhIMENHRTJV?=
 =?utf-8?B?c3FwdDljMXNPaDJKVzRHNHFlcHFMZFQ5N2lzZWtjL2RFU2pIY0IvODltSGNx?=
 =?utf-8?B?eEIyNkh1c1dSdUMxaEJWblQzNExhU3pJMTlDd082TWYvMG1xNUJuR05RVXA0?=
 =?utf-8?B?d1l2U2lMT0h6QWJpcFFYcnRFcnVZQnozS290S1lWeklLbzFCWXpZbkdpZ2pK?=
 =?utf-8?Q?cfErC6kPUt6cWexaPflHFS1bV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b60dec-b07a-49a8-8836-08dbcf4559e7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:14:57.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iToHfTbiCZZu3wLZJGIS/ROYa6egni01LfsE/GtY4MGt82ss5kAT4GKjXDPTuYPVOOuQ80f/xg5gI+v9BYJ+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-10-17 12:42, Alexander Duyck wrote:
> On Mon, Oct 16, 2023 at 5:08 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
>>
>>
>>
>> On 2023-10-16 17:30, Jakub Kicinski wrote:
>>> On Mon, 16 Oct 2023 15:55:21 -0700 Alexander Duyck wrote:
>>>> It would make more sense to just add it as a variant hash function of
>>>> toeplitz. If you did it right you could probably make the formatting
>>>> pretty, something like:
>>>> RSS hash function:
>>>>       toeplitz: on
>>>>           symmetric xor: on
>>>>       xor: off
>>>>       crc32: off
>>>>
>>>> It doesn't make sense to place it in the input flags and will just
>>>> cause quick congestion as things get added there. This is an algorithm
>>>> change so it makes more sense to place it there.
>>>
>>> Algo is also a bit confusing, it's more like key pre-processing?
>>> There's nothing toeplitz about xoring input fields. Works as well
>>> for CRC32.. or XOR.
>>>
>>> We can use one of the reserved fields of struct ethtool_rxfh to carry
>>> this extension. I think I asked for this at some point, but there's
>>> only so much repeated feedback one can send in a day :(
>>
>> Sorry you felt that. I took you comment [1]:
>>
>> "Using hashing algo for configuring fields feels like a dirty hack".
>>
>> To mean that the we should not use the hfunc API ("ethtool_rxfh"). This
>> is why in the new series I chose to configure the RSS fields. This also
>> provides the user with more control and better granularity on which
>> flow-types to be symmetric, and which protocols (L3 and/or L4) to use. I
>> have no idea how to do any of these via hfunc/ethtool_rxfh API so it
>> seemed a better approach.
>>
>> I see you marked the series as "Changes Requested". I will send a new
>> version tomorrow and move the sanity checks inside ice_ethtool.
>>
>>
>> [1]: https://lore.kernel.org/netdev/20230824174336.6fb801d5@kernel.org/
> 
> So one question I would have is what happens if you were to ignore the
> extra configuration that prevents people from disabling either source
> or destination from the input? Does it actually have to be hard
> restricted or do you end up with the hardware generating non-symmetric
> hashes because it isn't doing the XOR with both source and destination
> fields?

Do you mean allow the user to use any RSS fields as input? What do we 
gain by that?

The hardware's TOEPLITZ and SYM_TOEPLITZ functions are the same except 
for the XORing step. What gets XOR'd needs to be programmed (Patch 5: 
ice_rss_config_xor()) and we are programming the hardware to XOR the src 
and dst fields to get this hash symmetry. If any fields that are not 
swapped in the other flow direction or if (for example) only src is 
used, the hardware will generate non-symmetric hash.


> 
> My thought would be to possibly just look at reducing your messaging
> to a warning from the driver if the inputs are not symmetric, but you
> have your symmetric xor hash function enabled.

With the restrictions (to be moved into ice_ethtool), the user is unable 
to use non-symmetric inputs.

