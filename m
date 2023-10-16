Return-Path: <netdev+bounces-41602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C97CB6AC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480C3B20F31
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59915339A0;
	Mon, 16 Oct 2023 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDTC3RDp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70184328A6;
	Mon, 16 Oct 2023 22:44:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A749B;
	Mon, 16 Oct 2023 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697496263; x=1729032263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TFLTaWyJ6Nlk+QebDAGBFeYqjBuXDQ6hWYR1QwpfNgg=;
  b=GDTC3RDpnBey6sonFvrbgNOiAQO7rKVZzSceDM4BmkrV1NGYE0camiG7
   DfVZeo+oSSKFEwrO2764JYk7gg4mw36n0U8X/Jbd0Xhy4wBogVUgZxvv7
   Bdxowvo7eKgSDiy8V5PdqHNrC+5erPF/irXyU90IwP04dwjfe3fLlGLvo
   dgD8iR6yAZW/1touBZfI+NH9ptdCwLRY37I55hdStsVBb5Xw3xZTJAd7/
   aCTRRgDVospa2+zpeav2wtUNqxIaa0q7hnXEuevyJ2pjRxKbhpGIJl2Al
   yvsGRmRO0TJpd6h1REMBnkaN4Hi0ilJd3aKO38Kob2GAHV2K7Tf3MayHM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4259177"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="4259177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 15:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="3819282"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 15:44:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 15:44:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 15:44:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 15:44:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBQ/1tD9XxovSa0mLrHuKDVpK56zUGW8MNFLyIgHj4WK/88YZ2Js1T73cenpYop1I2TkkqUbS0VO5eH9KJa0sjlav6qfSUJ98n4X3wbTr0FmnGJ1VIqF1wroV/6HFHvQ/Nv+qe3cKrySVI8x+ZkWYa5u/z0mWVSV307A0HuYr0Ce8Y8ZzB+03iBCRItzJZ9rqTO5jcBWlYSEyGLHgtXf6WCSbTxwNX372EL9FPADdcLhuy2uSRzJqWs8cSvzBsXjRQ6oBgN+kBUCTErHwi0oYo/v2Vskku/GlQg9jr9MgU3VRi6pM8UdYpGaDSdvk6aiuCnjHoQepIuO23VcFirJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd6xcXzB7jLs9h9OI6yBWT6odMYfpWsl2MOj0cx5MjM=;
 b=i4hcLDOqWGvFkhcajAW6tb13tHHqMWXialASVBuROv8UzS9vHFzEf0PbGMk8bhJJzA6aUBck+lirdLK6I9fZKyZpDIaE7owXOqP8mqAlqdfEvY/i0Ed+QYwBhE9w+aTdv0Vi6NzQ7ZXCeXGruHfu133RPgZXLmHGtUXW6Nn7g4QfiS9nZJ2X64jMRRgSRjk9G5YxRnUFMiU5B923YPZqsCzbzI1/Rn350uFt0b6uPWhymCaHuoRJBvmDdRbO9vC1oYHx2mH+5k5rWtqEedEk8Cy2qHFEVQjfgije40AhaQQNVkXqrDLfSadlZhgfe/N4IXdk6KB7W+f6Pt0Yc3o8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 22:44:19 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 22:44:19 +0000
Message-ID: <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
Date: Mon, 16 Oct 2023 16:44:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<corbet@lwn.net>, <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
	<linux-doc@vger.kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
 <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 96794f6e-e706-4567-3ae5-08dbce996ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBL5VQaTAKgCSR6B43xJ+mar37VTzWwFo13epz55tmJH4wSA61p3/73pdvxBjw8bF44Yai1uAD3B+HM6tWl5QpnfsaeGSVJbcNGba2l+bzP+hYBSF1ClusKYEb+kPEoYxGvTDfpCiM4o+ErNbn3u+JSH5eRI4qOopZs0UXv0na5sZisxUA4NyFWnCyHdkpjtJw4DmhABOHlnazmTTyI63zmz5z/MxXXSBxsBMQJPxxL5DzOKqyfsFqwPddbcRbB5KRMOOgDlEiGYeOpOh/ACf8W49Mo2eUzjbL72E9mAygMx4vC4KSyNAWEkgszmZla6p2dnFXvRhADNrAdCRYv9RJHZqjT7uAIcUW28u9XKOWoEJPg4+ObFksVA6yjoWEHIe5PQGNCYvu9wo6N7etVj7EKjaCP421EpfGJXUmAskDUaw3gkFesI51FDGU5Hs+o5ssSNRkoe9aIm8bX6wuN3aYUXjqKsWE7RcIoKJQLonrX/n2NHu3f2hIfern4/iWjQnxcbn1oH144hjShUREK2dYlT4jXPQ8WhYdQSrhN+fnIZs+gaFwzrzrb0LV5UuZZ1pXfTNjaBfoBnWZsVcP4kbYcBtn+wtr6DmpORuIgqywwF0sQsjC3WQg/9Y6GfdjBR+ZRjFf1yKbh3c5Tn+7RTBgnMwtZVftpTuAYoQMlve04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(7416002)(478600001)(41300700001)(4326008)(8936002)(66946007)(66556008)(6916009)(316002)(66476007)(8676002)(31686004)(44832011)(5660300002)(53546011)(6506007)(31696002)(38100700002)(82960400001)(86362001)(6512007)(2616005)(107886003)(26005)(36756003)(83380400001)(6666004)(2906002)(4001150100001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxpS0RoY1pRM1BDNmNWcVNuNHk1d1ozdCtPWkxJRTZiYTA4RnhwVXBoayty?=
 =?utf-8?B?MHRGbmtHcjV3SjZMVTZocnVUVmZHODhXamRGbXBvTEhMK3YrZ0pXb1QwZjkw?=
 =?utf-8?B?QXJIWi8ybUh0RVJKVWhVYjJvelFkMU4wSGV4N2RRcVpZMlp3a0N1WTJhVGJl?=
 =?utf-8?B?eXJpZGM4djlYUlZOd3dGVkErWnhLcm9sSDNQajQ3NTdRa0Q1a2NDZGZHREp5?=
 =?utf-8?B?eVBXd2t0UkJRK2ZVMWMzZ0lSSysxdFhwc3lxVWNZc3hiT0JLOWRWVk9NY1VJ?=
 =?utf-8?B?RHJGa25HMVNwYnB1TGEza3ZXWFpMUG1TOHMvbHhEOVh4MEs3K3ZlRnlDOHA0?=
 =?utf-8?B?TlJGYVVhWW03UVptcHVZQ0hKQkxxSFlNc2R6NDBueWIvZzZpSmk2bXBCR0JT?=
 =?utf-8?B?RTBJQTFzd01uVTMyNTQ4WFBxdzRoMCtPWWV4UVZXTTNvYms4STlMV3NsY2or?=
 =?utf-8?B?L2ltbENlWXo5YWZVenZKeGs2THB3NklEd3dXMnZvS3A2bjZ5UUhRYU1UOW1R?=
 =?utf-8?B?ZjJPOEQ2NFd3N1VRN05FbTBQM2FlUzUrNkRGaENmdU5EQ1AwZ2w0VmdwcFBI?=
 =?utf-8?B?SThZUzdMRFBkQlVoRXRWWldIVUsxbkFXTElVODY4UDJYeUV3T0pkZ01ha1Zm?=
 =?utf-8?B?MElOcjh6VFY4UzJlbU1IN1BDVC9Hd3dia1htd2VUNE9zUitNR0RPZWVIcWww?=
 =?utf-8?B?RkEyNWdMYktRVXNrZm1QU0YxdUgrcWlEcFFQS0tNSFRidGIxSzBZZHRRalcx?=
 =?utf-8?B?U2wvOGRFWC9VSGEvWXBJcno2aVdENE9JRUJRb3FNZXhBNllTK1B1OW9yMlVY?=
 =?utf-8?B?bzNNOXVrMmJSMFVYSUlJY2JxZ00wWStMLzd6dUVXSFV6NU40aWtHWkZob3cx?=
 =?utf-8?B?dGhCMjRBSjdIeFl4d2FYRDhiNGxWdjRZVHpSQUJCTk5ndGhETVJMQmNRNlBZ?=
 =?utf-8?B?ZHJyVzhHc3Z0aFVEQlkyZkpsWjloZzlIQ2FNcStNekZZUmt5M0FyNGRVbEd4?=
 =?utf-8?B?ajJRYmpMZHVQWUNJSy9veTJsUjFJK1hydDl4OHVzd094WjFNL01xL1F5VGRt?=
 =?utf-8?B?M3YranZpbzhZTWRPV25LM3RhQzQraUhZUnJZaGI1OUxsdUNFdFVobGxjeUhG?=
 =?utf-8?B?WWpDa2ZDVVZMeHBRdlk4c3VNQ2NRNUNQMk1CVGRaTTQvOFFCUFhrSEVkSExT?=
 =?utf-8?B?cGNNLytoTTZPRldYLzBLdlByeUxObXR6SDk3MGxzUSt1ZTQxQk5XRjZVT1Jn?=
 =?utf-8?B?U3p0TUhpV3VqLzdVN0pSODkrMG0xMTI1cWgvWmtwSGEzN285SU9zWmNndS83?=
 =?utf-8?B?S0kxQzgyQm9ONzg5VUc4bnpTZkFQa29zK29vVkd2T2xpSHg4THFFSlJyY2ZX?=
 =?utf-8?B?QmZ5eUVBaEkxcjBtRGZFY2ZxVmx5RkRtc1loeTdQT3phcDN4L0tNdjJtUGNU?=
 =?utf-8?B?bzFjdDhjSTJjS0tvZXl0WE5ZWGRqRVU2YTQ4OEp0TU9YMmpTT2MzZE5vQ0Nu?=
 =?utf-8?B?aWlxN2duV1VrTUJLVEE1NjZLT1NqVE5oM1JxT2JZdmRXckR2RFVVMUFDVCtx?=
 =?utf-8?B?d29JSHJsNGFOUHBrYk1LWnVpUG9lYkEwSmRJMlgwSXZHT2VsSG1mTlBtN3Jy?=
 =?utf-8?B?UEo2RlB6WlIyUTdNb1pnTUJrODM5SXo2NmF1V1cvODBWc3R1YXlNVEVrcEQy?=
 =?utf-8?B?QVkvWjlEVyswcFdJRWNJZmpSbkE1L1kzOHNpNEtjUUsvQ1pDaklWalJCT3Vr?=
 =?utf-8?B?SU0vMnZyWFE3a0VDUk41OC9PSCtqcmIwNDYzRTV6VGlTcm5EbGRIWEVkblQy?=
 =?utf-8?B?bWtHNFJham9IM2tYc0R3aXRPSGFMZHFmM0ZaRDhBWERsR3RLV0trcUQzR0RY?=
 =?utf-8?B?Z2ZzUHYzYk9uRGZCaGFDVlh3MjVYeHhVWlBpNmIzVEhQckg0c2JOa3ROS052?=
 =?utf-8?B?ZTVPVlZWakdkUDdYV09tcjJYcHByWXdReDhpVWlXc2huOUNMUDhPT0dKRlZk?=
 =?utf-8?B?RTdBeExjbDFZWnJ1YXNBYUZFaDg3L1Z6b2I5d0RBUnlBTFFrRjJnMnVndS9G?=
 =?utf-8?B?L0pLT1V1aVVBcHVKNnIybDVCSW5VR21qVGdYbEdMNG5WOWpGZnd1bTdIODRD?=
 =?utf-8?Q?MEvNwKqrtzNkRnZli5HPLOJ7s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96794f6e-e706-4567-3ae5-08dbce996ef9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 22:44:19.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1NSoDzTs+52BHDLoNP4lYpYq0NfV1jp/cupdcQIBRrK/vWTuNkeSjCsr38vnzGJVQKDNgvnpsxzEW55LHk1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-10-16 16:15, Alexander Duyck wrote:
> On Mon, Oct 16, 2023 at 2:09 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
>>
>>
>>
>> On 2023-10-16 14:17, Alexander H Duyck wrote:
>>> On Mon, 2023-10-16 at 09:49 -0600, Ahmed Zaki wrote:
>>>> Symmetric RSS hash functions are beneficial in applications that monitor
>>>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>>>> Getting all traffic of the same flow on the same RX queue results in
>>>> higher CPU cache efficiency.
>>>>
>>>> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
>>>> by XORing the source and destination fields and pass the values to the
>>>> RSS hash algorithm.
>>>>
>>>> Only fields that has counterparts in the other direction can be
>>>> accepted; IP src/dst and L4 src/dst ports.
>>>>
>>>> The user may request RSS hash symmetry for a specific flow type, via:
>>>>
>>>>       # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>>>>
>>>> or turn symmetry off (asymmetric) by:
>>>>
>>>>       # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>>>
>>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>>>> ---
>>>>    Documentation/networking/scaling.rst |  6 ++++++
>>>>    include/uapi/linux/ethtool.h         | 21 +++++++++++++--------
>>>>    net/ethtool/ioctl.c                  | 11 +++++++++++
>>>>    3 files changed, 30 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
>>>> index 92c9fb46d6a2..64f3d7566407 100644
>>>> --- a/Documentation/networking/scaling.rst
>>>> +++ b/Documentation/networking/scaling.rst
>>>> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the computed hash for the
>>>>    packet (usually a Toeplitz hash), taking this number as a key into the
>>>>    indirection table and reading the corresponding value.
>>>>
>>>> +Some NICs support symmetric RSS hashing where, if the IP (source address,
>>>> +destination address) and TCP/UDP (source port, destination port) tuples
>>>> +are swapped, the computed hash is the same. This is beneficial in some
>>>> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
>>>> +both directions of the flow to land on the same Rx queue (and CPU).
>>>> +
>>>>    Some advanced NICs allow steering packets to queues based on
>>>>    programmable filters. For example, webserver bound TCP port 80 packets
>>>>    can be directed to their own receive queue. Such “n-tuple” filters can
>>>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>>>> index f7fba0dc87e5..4e8d38fb55ce 100644
>>>> --- a/include/uapi/linux/ethtool.h
>>>> +++ b/include/uapi/linux/ethtool.h
>>>> @@ -2018,14 +2018,19 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>>>>    #define    FLOW_RSS        0x20000000
>>>>
>>>>    /* L3-L4 network traffic flow hash options */
>>>> -#define     RXH_L2DA        (1 << 1)
>>>> -#define     RXH_VLAN        (1 << 2)
>>>> -#define     RXH_L3_PROTO    (1 << 3)
>>>> -#define     RXH_IP_SRC      (1 << 4)
>>>> -#define     RXH_IP_DST      (1 << 5)
>>>> -#define     RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/SCTP */
>>>> -#define     RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>>>> -#define     RXH_DISCARD     (1 << 31)
>>>> +#define     RXH_L2DA                (1 << 1)
>>>> +#define     RXH_VLAN                (1 << 2)
>>>> +#define     RXH_L3_PROTO            (1 << 3)
>>>> +#define     RXH_IP_SRC              (1 << 4)
>>>> +#define     RXH_IP_DST              (1 << 5)
>>>> +#define     RXH_L4_B_0_1            (1 << 6) /* src port in case of TCP/UDP/SCTP */
>>>> +#define     RXH_L4_B_2_3            (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>>>> +/* XOR the corresponding source and destination fields of each specified
>>>> + * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
>>>> + * calculation.
>>>> + */
>>>> +#define     RXH_SYMMETRIC_XOR       (1 << 30)
>>>> +#define     RXH_DISCARD             (1 << 31)
>>>
>>> I guess this has already been discussed but I am not a fan of long
>>> names for defines. I would prefer to see this just be something like
>>> RXH_SYMMETRIC or something like that. The XOR is just an implementation
>>> detail. I have seen the same thing accomplished by just reordering the
>>> fields by min/max approaches.
>>
>> Correct. We discussed this and the consensus was that the user needs to
>> have complete control on which implementation/algorithm is used to
>> provide this symmetry, because each will yield different hash and may be
>> different performance.
> 
> I agree about the user having control over the algorithm, but this
> interface isn't about selecting the algorithm. It is just about
> setting up the inputs. Selecting the algorithm is handled via the
> set/get_rxfh interface hfunc variable. If this is just a different
> hash function it really belongs there rather than being made a part of
> the input string.

My bad. It is the same RSS algorithm (Toeplitz in our case). Still the 
user needs to be able to manipulate the inputs. The point is, a generic 
define like "RXH_SYMETRIC" was rejected (that was actually v1).


> 
>>>
>>>>
>>>>    #define    RX_CLS_FLOW_DISC        0xffffffffffffffffULL
>>>>    #define RX_CLS_FLOW_WAKE   0xfffffffffffffffeULL
>>>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>>>> index 0b0ce4f81c01..b1bd0d4b48e8 100644
>>>> --- a/net/ethtool/ioctl.c
>>>> +++ b/net/ethtool/ioctl.c
>>>> @@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>>>>       if (rc)
>>>>               return rc;
>>>>
>>>> +    /* If a symmetric hash is requested, then:
>>>> +     * 1 - no other fields besides IP src/dst and/or L4 src/dst
>>>> +     * 2 - If src is set, dst must also be set
>>>> +     */
>>>> +    if ((info.data & RXH_SYMMETRIC_XOR) &&
>>>> +        ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST |
>>>> +          RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
>>>> +         (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
>>>> +         (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
>>>> +            return -EINVAL;
>>>> +
>>>>       rc = dev->ethtool_ops->set_rxnfc(dev, &info);
>>>>       if (rc)
>>>>               return rc;
>>>
>>> You are pushing implementation from your device into the interface
>>> design here. You should probably push these requirements down into the
>>> driver rather than making it a part of the generic implementation.
>>
>> This is the most basic check and should be applied in any symmetric RSS
>> implementation. Nothing specific to the XOR method. It can also be
>> extended to include other "RXH_SYMMETRIC_XXX" in the future.
> 
> You are partially correct. Your item 2 is accurate, however you are
> excluding other fields in your item 1. Fields such as L2DA wouldn't be
> symmetric, but VLAN and L3_PROTO would be. That is the implementation
> specific detail I was referring to.

hmm.. not sure how VLAN tag would be used in this case. But moving this 
into ice_ethtool is trivial. We can start there and unify when/if other 
vendors push similar functionalities.

How does that sound?

