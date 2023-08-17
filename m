Return-Path: <netdev+bounces-28608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F307777FFD7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85341C21519
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A31B7DB;
	Thu, 17 Aug 2023 21:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294A37D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:26:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C63C05
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307559; x=1723843559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2x55cSkZNZhmz92IpCOWtESnbZtji2rMb7NGV1rNFQ4=;
  b=ZSRySW143a5STFII+VVbFX2kCDXhCr0YjxhXKYH14rZtFVQGaBluAm91
   4NlUsqb3VH3AxC6hLUQKn0pD9qekPz0/PmAsE/aUjtmIGmAxkrIH54zoN
   zCZneGS5Pgp+PggKmEaRyjtLE/9hn5ogsrCGnEq9FLXRCYlfxjFMDDZKt
   sgW2ipD2LsZIiNNiEUKviUZzguXBhmVtn7KiDdhTxvVzhFFCsCXrEGaXy
   HJSIh+IjpGLXF6QFoi4y2Fyq43KNIm4ORwPTRv9clUuMwL3a+g4ybtJ4M
   X8uVrwCPkew40hTH4F6ifx1hK2egq5j9ORV5K7EseEbce2vIwi3ZiCxvo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363094369"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363094369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849006588"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="849006588"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 14:25:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 14:25:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 14:25:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 14:25:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 14:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2uGyBgwoUyl447k3bQ5A8ud3jZFmKtYIFZ29bXBZr4NzOfT3KeXEK4bCQbrPsOI5Ekk/X1mKzZDR0WozdMGnInoaSwnz9x0AqN1/vH5JMb0bmNIbZvRYBOSa5h4EWNvRdoADzM/UojKfXkaefidQI+A2xjvxjx+0bFMgh+6Az6FLCQ93tH7zp5PC/oExfyIJB1OlLUuh5Mn7YXAWhd6yOpIFRz05nMDXlk/h/xLLpfwZRPKJ1bKkxU8+wUVXR27ZA+BUcBr1IBmd9lYcNtNfXBJjDZYc2jhuMCOajx35fc2YSbCQM4xySI4PignFjJU5kSP+xhVBq1PoTPczFtY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsoiQFFXH0+cIzSxPSHhe5iCAoIR4Wd3hNa3FBNIOI4=;
 b=XiPRG1JLWIEENk6KP4Gu3FGmHyCHJaeFPQPORaFsdZlZ69+qJ15RHM4soKgIJ2jsseu4U/IFCKYUTHMCwSlIL6qO3+4eJdgwBXa+aqX527dKrUQUOTsZvoVLCD+/VHAZ5CrQ5cSjU8CZ9QCrvHa4Q9Q5jbpMjzxOjuGbKK/Ey4RU0n8TnLVrKk29S0dOIqWUNIR3DESsbRFm09TjS+GrqtwMOfony9kJ5ULbRO0D5nbidOz2tgaTkxAQ1vJMTebUCYGkd7dRJUiwee6PkD+QnzKT0ZImp7PLIPjHJZPIQiHgJbMDMKWlDJASjC0KbueQhM3+9Q6eaiBUDfo0Sf1vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 21:25:37 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 21:25:37 +0000
Message-ID: <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
Date: Thu, 17 Aug 2023 14:25:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
To: Leon Romanovsky <leon@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20230815183854.GU22185@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MN2PR11MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 58286b2a-287c-4b9e-cb1b-08db9f687fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gx4c05IM8j+CgJrwtLpNgNC12LQ0of2XDJrlVOb4VbFOWa9y5ho5SpjY5TdFxBHutnfySR5fbF5Lb/TBlPjtZp459rhpfNtH2QYtKHr2p0tjFiCw2A87fWgftR2dqHekoTrXF7Wyl3EJK+xG6mWqytCUZy+N3jOQiuHmn8iJoZYApjdqFSynfoMUkt7lFg3MaGOBFHHcxf1yDyVqL8heiMHAfJgCwKlyljeWICdcg8/kjft9vFM4RZrm4x3AueveGmQlCqVerIsvdtQTUzKCNG9zbBXtr4DChYyILmNchTfXfL3Hl6ZhNRIwlEYGGMRNaz5wj40akZXOnml5j8/DcVvwKRKayDD/rxK0M9NWcCQ8690jcR2pLb2z2LkCCdsPVJC+o1x2dgjhjlcNdZHqgtgRxyDkiJnX2MPzagSQRoFf19u8lVCbP5jBQAHj2Z9hii19NWGn9GLnwKO3aI4kd2w/IM46b/rpGeQkJEC4z/HDCVmINl0xCx5piqZRA/utPyNU3tPj4imdocGH6QhwhXBB4gwslKz9rRffVIS/pdI7EVPbUk+LGqfgXE+bZ1H5RTFSiNFJTUWrT6F7LzcZh3NyD/x5tkYzyak3TviaCd08OAxUUgmXOTikQROcCFUiZmzbLzNj8R80z3C3HB8bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(186009)(1800799009)(31686004)(86362001)(31696002)(36756003)(38100700002)(82960400001)(5660300002)(2616005)(107886003)(66556008)(66476007)(6636002)(6506007)(478600001)(110136005)(66946007)(53546011)(316002)(6486002)(6666004)(26005)(4326008)(6512007)(8936002)(41300700001)(8676002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VEdHViMXRPTXVJaDdYd0x4MTRhQWRpT3U1UXhQWGpUTUdWQmhobUFyOE1i?=
 =?utf-8?B?VnJ5ckxIY0NIRHZXVkFCOHlKcmczcUJCbHVGTkdhdWJPYU5JMlN4clQ3QXR3?=
 =?utf-8?B?emJCaEFNTHAxZU93ZCtwVHB3d2J5cEUxV3p0bnY4WXAvUW9OdW5zaG1GNmto?=
 =?utf-8?B?cnJFc1JKWEZ1WERBVDFlNzJRUEZ4WTF5MFdBemdJU3ZMekF3Zlo0Nk43amdv?=
 =?utf-8?B?cDhlVERaRlM0dW5xWXBETHREUTZabGlWMWQ4SlN0RWlWRXc3c3ZIUnI3cnJB?=
 =?utf-8?B?MnMxdXN6Y1hLdlhzQXFNS2p4d1pmbnBiR3UvL0ZpU1VsaGRoUmUzQ09HWEdz?=
 =?utf-8?B?b1BFNnNPWTR0MDJwblYxU2lOSnN1cFRKQ0F2NVFvS3YrSE42bllEdXhMVlh0?=
 =?utf-8?B?dStCeUQ5N0l1WHVZamNDK1NUZ2FpWS9nbElvTkQ3aENTc2VZc2JIeUFiZzY3?=
 =?utf-8?B?RWRPaFRucnp5eUNyanl3ZSs5ZlY3SWNGSjMvdDdQTnFJK0g4ZThKV0lyR1p6?=
 =?utf-8?B?TzYyazZtdnlObXUwejhlYkxpTExZSTZUNys4VUlHMXJzN2R0RmVyazhQbVJ5?=
 =?utf-8?B?bC9KTjdwM3ZMb0t3OHBWd2JFQ0lTU3o0TEpGZ2pVL0ROSWprM05MRVVLbklD?=
 =?utf-8?B?cWJWM1dhYzhaVmRQUlhzTXo4N0lWMTR1aWxmdU1BTFF1YnpGZFpuT2prZU5Q?=
 =?utf-8?B?Yk85THlXUWJVWXcwdUlqQ2V3V0xwOU5MWG1IazU3b0pYTXNZRENlS2I1TTRI?=
 =?utf-8?B?VjVlYmlIY1lJT1hIUWowcDgvZkJkQ0RvKzYzRDJBS0FuK1ZJMmREektuMzl0?=
 =?utf-8?B?S1FKL0pCZ2hpa3kxdkptNkpQWEgzWVdWMFptRDV2T2ZGdHRiWTZrVnlDRmov?=
 =?utf-8?B?QVd1VUVIRk1lc1FMK2RuMjBZTUpEcmp5Mlk5SmZSQTFudWRWdnhMa05vQ3Bx?=
 =?utf-8?B?WUtaZDRkRmlqdE8wOEp2RkRiaHUyWEZSMFRVTGJsdTRZamgwZnZKMnJPSC9n?=
 =?utf-8?B?c2RWZkFzN2MxeTZOdmY4MDVyN2xsV0JTQmExc0wrNTN2YjJPUWRrVnNUOTNC?=
 =?utf-8?B?SWJBeUdaZDl3U0xpU3lMRXhINmIvUjlwdlhSVVdUWXBmZGVYdVVjRWE5V0Vm?=
 =?utf-8?B?S1gxZHRXRGU0Rm1KQzg0UVd5KzdHUm44MVNpMG1iN0MvN0ZBd2N2bjY1aXV3?=
 =?utf-8?B?TmxFUXRlbFF0VlpFSnpTbjF6UVcrY2FFdit3S2YyekZ6M3lnUEtVRERBK3NV?=
 =?utf-8?B?ejJIVHNyb0lrcnRrbU8vU01jTGlucCsyUzNnR3A5UERlTzhnVllwdVl4K1Rw?=
 =?utf-8?B?NFZpTzh2aFNvclRic0dXdnFJY0JWcXRiZitod1Y4V1podmMrYklyd2w4UEUz?=
 =?utf-8?B?T0Q3UlN5OTkzNnNNMmx1VUhQVWRDa2wrTllCR0twWEZlNlJzcHhEZG5QN1oz?=
 =?utf-8?B?Q2plc1ViVUJPWnNTWVMzRHV6bUZ3NmpSNHZTd2hlRmlvSnVGbm5Ub0RNeWpz?=
 =?utf-8?B?dUF5aEZzMExnQldTTFpob2I3V25xQmhMdDBWWlRJTmY4bGE2dm1WekJyUjZu?=
 =?utf-8?B?N1hEUDhqMGNsREM4eWxCZTkrNCtQVFQrNnVibTNsVXdWV3FnNkg0YnVyNVEv?=
 =?utf-8?B?azZOcDZzQU9sMTFPVHdpblFOOGRiS01XcVNDeUhOY1p6N3gxbjJFanlka1li?=
 =?utf-8?B?ZHVRZmxGYWU1SlVmdGQ0cFg3UytGdVByUG0ya0JWK3o1eGxyZk9UT3lETm9i?=
 =?utf-8?B?bTR3MThwWkdLbG9pdWZ2bC9PcVZrRXRMLzZzcUswV05nYzdZRjk2dXYvbXdH?=
 =?utf-8?B?QU05MWcxUnhhNkE0dVRBTHJVNkdCVlE1S245ZFYzY0VwRXVJT2pINVUraVVr?=
 =?utf-8?B?MkJ1SWtmTTlKTndFTWRRSi9VTGVUcEg0aEcwaVc4MEo1S0kwNkQ2MldhVGhT?=
 =?utf-8?B?VFd0MWtBTUcvRXhabzVQdnZvb3lXRjBqeGZndnBzQ3duUFl0MXJKREpRWDlM?=
 =?utf-8?B?YXVZeDJqTDRINHIzWVJrMEVlOHd4dU1UckxMTHo3MDBUTUdUVnJKa3BrT2dS?=
 =?utf-8?B?OG8rVitjYWl5NndMNDJwOHlEQnRQbERwSVFoNE5UTTJOYlhWN0dlSk5yelo5?=
 =?utf-8?B?S1lLemVoSmlEQUR5eGViNmtkWXFXZ2h4ZndRdHlraVZ1V0tSN1h6ak1wNEE0?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58286b2a-287c-4b9e-cb1b-08db9f687fc6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:25:37.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 668LpAEFDY+ETacYNF7l/p0Sm/VMD7aVQ/BmpoZOkru1O0GHBDR6JyDXdWB52vCZRJyIh3fAdlSQ9brYq2CygiC/fIZEgzuaiPVvJxyGAWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>
>> Users want the ability to debug FW issues by retrieving the
>> FW logs from the E8xx devices. Use debugfs to allow the user to
>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>> Reading the file will show either the currently running configuration or
>> the next configuration (if the user has changed the configuration).
>> Writing to the file will update the configuration, but NOT enable the
>> configuration (that is a separate command).
>>
>> To see the status of FW logging then read the 'fwlog/modules' file like
>> this:
>>
>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>
>> To change the configuration of FW logging then write to the 'fwlog/modules'
>> file like this:
>>
>> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>
>> The format to change the configuration is
>>
>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
> 
> This line is truncated, it is not clear where you are writing.

Good catch, I don't know how I missed this... Will fix

> And more general question, a long time ago, netdev had a policy of
> not-allowing writing to debugfs, was it changed?
> 

I had this same thought and it seems like there were 2 concerns in the past

1. Having a single file that was read/write with lots of commands going 
through it
2. Having code in the driver to parse the text from the commands that 
was error/security prone

We have addressed this in 2 ways:
1. Split the commands into multiple files that have a single purpose
2. Use kernel parsing functions for anything where we *have* to pass 
text to decode

>>
>> where
>>
>> * fwlog_level is a name as described below. Each level includes the
>>    messages from the previous/lower level
>>
>>        * NONE
>>        *	ERROR
>>        *	WARNING
>>        *	NORMAL
>>        *	VERBOSE
>>
>> * fwlog_event is a name that represents the module to receive events for.
>>    The module names are
>>
>>        *	GENERAL
>>        *	CTRL
>>        *	LINK
>>        *	LINK_TOPO
>>        *	DNL
>>        *	I2C
>>        *	SDP
>>        *	MDIO
>>        *	ADMINQ
>>        *	HDMA
>>        *	LLDP
>>        *	DCBX
>>        *	DCB
>>        *	XLR
>>        *	NVM
>>        *	AUTH
>>        *	VPD
>>        *	IOSF
>>        *	PARSER
>>        *	SW
>>        *	SCHEDULER
>>        *	TXQ
>>        *	RSVD
>>        *	POST
>>        *	WATCHDOG
>>        *	TASK_DISPATCH
>>        *	MNG
>>        *	SYNCE
>>        *	HEALTH
>>        *	TSDRV
>>        *	PFREG
>>        *	MDLVER
>>        *	ALL
>>
>> The name ALL is special and specifies setting all of the modules to the
>> specified fwlog_level.
>>
>> If the NVM supports FW logging then the file 'fwlog' will be created
>> under the PCI device ID for the ice driver. If the file does not exist
>> then either the NVM doesn't support FW logging or debugfs is not enabled
>> on the system.
>>
>> In addition to configuring the modules, the user can also configure the
>> number of log messages (resolution) to include in a single Admin Receive
>> Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
>> means push only when the max AQ command buffer is full). The suggested
>> value is 10.
>>
>> To see/change the resolution the user can read/write the
>> 'fwlog/resolution' file. An example changing the value to 50 is
>>
>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>
>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>   drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>   drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>   drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>   drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>   drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>   drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>   9 files changed, 867 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>
>> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>> index 960277d78e09..d43a59e5f8ee 100644
>> --- a/drivers/net/ethernet/intel/ice/Makefile
>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>> @@ -34,7 +34,8 @@ ice-y := ice_main.o	\
>>   	 ice_lag.o	\
>>   	 ice_ethtool.o  \
>>   	 ice_repr.o	\
>> -	 ice_tc_lib.o
>> +	 ice_tc_lib.o	\
>> +	 ice_fwlog.o
>>   ice-$(CONFIG_PCI_IOV) +=	\
>>   	ice_sriov.o		\
>>   	ice_virtchnl.o		\
>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>   ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>   ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>   ice-$(CONFIG_GNSS) += ice_gnss.o
>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -556,6 +556,8 @@ struct ice_pf {
>>   	struct ice_vsi_stats **vsi_stats;
>>   	struct ice_sw *first_sw;	/* first switch created by firmware */
>>   	u16 eswitch_mode;		/* current mode of eswitch */
>> +	struct dentry *ice_debugfs_pf;
>> +	struct dentry *ice_debugfs_pf_fwlog;
>>   	struct ice_vfs vfs;
>>   	DECLARE_BITMAP(features, ICE_F_MAX);
>>   	DECLARE_BITMAP(state, ICE_STATE_NBITS);
>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
>>   	return false;
>>   }
>>   
>> +#ifdef CONFIG_DEBUG_FS
> 
> There is no need in this CONFIG_DEBUG_FS and code should be written
> without debugfs stubs.
> 

I don't understand this comment... If the kernel is configured *without* 
debugfs, won't the kernel fail to compile due to missing functions if we 
don't do this?

>> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
>> +void ice_debugfs_init(void);
>> +void ice_debugfs_exit(void);
>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
>> +#else
>> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
>> +static inline void ice_debugfs_init(void) { }
>> +static inline void ice_debugfs_exit(void) { }
>> +static void
>> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_DEBUG_FS */
> 
> Thanks


