Return-Path: <netdev+bounces-27427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD477BF50
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906C61C20A9D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06208CA43;
	Mon, 14 Aug 2023 17:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EBC2FC
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:52:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC0124
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035542; x=1723571542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8l3ZrvffcO2yEdfGuzWx2DIl6/dxFrE1UjViJGYCAOU=;
  b=QtZs+7+J9Pg2EWSdzggHYbV8yVs7dKp7F4y/iNQ5+CGuFe+rYrWROK0B
   sirV3zcRpKYhnTtfw+VZErumvAm3m7bVZ4OsQCyHvMztTusCzG5jPjLvv
   tP34NVxAmt+jfFSTcBCIH4A2uo4hb4tc/8+RGJ/7U13G3Yzf5tj+4aSqG
   pVTb5EKiIlc/dzC1+p3GSYbNihDaNMppJ/Zz7LfybdBbEw3inBm2ThIfm
   0LJ1cybHktTF4gxi5figTVVHAk1pFYWbjWa6q4d+Q1k6O/zBB4YPzR38K
   99nJwpl7X7Lje81eWcrr6WeOxJPI7Zfx71mcmHCyKoMOdqhZpTfFm/E1f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374873703"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374873703"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877052693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2023 10:52:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:52:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:52:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bedW9k5acsFDmqQzjaAaAqfC/qNG0GNvRjrbr44eCP4oGXq+yebwXinRlbXRkpmPfv4E6AD6MSJ8knEyBMJ/GZNEbvdj8NhRc214M+NGgjRvg5nZoC6ZuFXB4qYaek3rrKB0AYKyde+vhRLBFkoq/6Wfnz7vK36z99g33baRIBtc9rmqqSTPgJzR9lXTlefeYYQT6DYXGJQ9756TI1aV7sE5ipHJt3q+4h0Y3MZ4iQ+RJ3pBBCgnHEzrt8Gn4kZGgWUzocdJ5FSyhuvXWgWWcIqsgyzCbIauxAoNedoE61qRCF9yda+Lt+bOI4UCluS+VZL05JQUoGwa4TB9BJFUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTvec1ud5PHFldJSuWHEjINqQLCVMpwuXMy0xAOPiQY=;
 b=T/T9RmKhazKb/5l4S9F3zYmiBVvDl+jxeeiMbNOSApD9WGE+tASjsurIFJ5H0epl9SlO5n5ssl8mSdmqzEeABvuoV6n8XmKIODaheD3XvjSIF+sQRxPR1wYyprRVW3xbGNvoUkxcqEtel9giFwNRgcr9EE19bqMiKT0/lA/0ZfSOXdML4QvJU90VhreiQhMUDTukDt4Yv/e/dPUyYSMMGg9ZWtFfRxeNwDscMNCFyEdqliZAzT6trv73lnCP1NY4sZI8e7uMsPdrYdxbzLXAfTLwrzbaN3no4u/b7AnSsxBI7HfrcaA0FcIffeIxdOrX4JPY2SbYzi0LaOUblfknVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2593.namprd11.prod.outlook.com (2603:10b6:406:ab::27)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:52:04 +0000
Received: from BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542]) by BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542%5]) with mapi id 15.20.6652.026; Mon, 14 Aug 2023
 17:52:04 +0000
Message-ID: <bdfc02a5-b1fb-e0aa-ed0a-0214132253fa@intel.com>
Date: Mon, 14 Aug 2023 10:51:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 14/15] idpf: add ethtool callbacks
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Alan Brady
	<alan.brady@intel.com>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>,
	"Joshua Hay" <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
 <20230808003416.3805142-15-anthony.l.nguyen@intel.com>
 <ZNNreRbo5jB9CaWc@vergenet.net>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <ZNNreRbo5jB9CaWc@vergenet.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To BN7PR11MB2593.namprd11.prod.outlook.com
 (2603:10b6:406:ab::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2593:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: e4562a1d-a3b2-4237-271a-08db9cef2b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4R5/NDeN6vBAaPGA1xKhtbF5wS4BerRloo8mgXLBEpEbQ37ybz7bm+MgWgqyFeHRtZ/dL1/d2zHDDJux0wTy9sV+5enz0Q1oz0rwEWOibsdHTMPJ+hDd5VxVlLz89Lz7MVaLIufFxM8jkWKUcftyXc59c/8ufRnyrKgAZ3GbxRfT0WvEEpoBed8e2+n3iUiELpF0HwWY7608wdGvzcV7MWfSdF55DmOYj9KhCE24qjMowA5Mg1SK4VALSb9NYtoI629Ij8hCWRybNeFZVChXIp679WR18aiUpd8QGYwJxA5WXww1yGhCTsIezaTdecjt3oREVpvf1TkWSFuVPjLIIm3MjFOgu1jaiLi2kVNtu/UDEEYTha/yOiEdL3W2eWjSxFnP1Sd1cAQ7OV7oR81daYEeYwlRGu4vJvqXv0MoGUuMAY5PDXQLD86qx6eqfUV5SnccOK5sXg2Vk2lgpsm9VZByCB3SE4i2YA3pSQRNqT3xYlBDtGucxPY7Hj2BlTd0S9uTRJ0MlFsXGBzGEeEkngty4JCpMlskwr0nPyO734KFk4LTinFD02o+1jiwGJjwKJhAakDQuuMbZd3fEW6G+snrvyoKLaAn6ZaUAAnLhGBRv93WKS5Fc0EHktMllypJM+PyZryDbHVLzfGZc0ZZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(186006)(1800799006)(36756003)(86362001)(5660300002)(7416002)(2906002)(31696002)(31686004)(4326008)(83380400001)(66946007)(66476007)(54906003)(66556008)(38100700002)(41300700001)(6636002)(316002)(110136005)(26005)(107886003)(2616005)(6512007)(53546011)(6486002)(6506007)(6666004)(8936002)(478600001)(82960400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFJdkl6WFJvTVgrQUVTaXhpWWpaRHJjK1lnbFA5Z3EvTGZucm9XY0lJQ1I2?=
 =?utf-8?B?bUQ3OUQrUTlncGJUckdGcmlPZVZxSFNDTXVDVytSRklkMDE4QW1GUjZNSTZG?=
 =?utf-8?B?UDU0SG1CWjBoeXYyWDcydy9FVDZVSTdsYVFqcUNqaWNrKzRzaTdKOUJsSDFa?=
 =?utf-8?B?YW8vWkdlQkszeHlHTFVycWFhNUtxMS9QYWhZTExjSGU2MGdneVhUUkxEcFU3?=
 =?utf-8?B?SFZLdjR1MWtKcWJsdlFFdmY4ZHdJL3pVNFpJNEZyLzg2a3dWV2tUVkQvbGRK?=
 =?utf-8?B?cnZCc3RFOG8vWHpIQnczNHlzejNQTm4wRzh3R2tlUVBmdUxiZVlGK1VyNXB6?=
 =?utf-8?B?SzhFaTlEbWh0eUJMTnJ6UWFON1FoMEpqcURZeDNXaXpMME5GUFp6YURzWHd1?=
 =?utf-8?B?R3BnNWpqcHRGOEQxdG9FTUFQT3d3V2xncFVvQnVNdDRkWVp5bFZndUJDTFBS?=
 =?utf-8?B?N2xTdWdOcGNDK1dXN1lRQUE2Y2xJVW9JSE9Mc25qeU96VlhSQlFxLzRjY3dQ?=
 =?utf-8?B?eC9NQm4zTmlWTVM1alc0eVViMUgwWHBiSW9WMFdyeEpuRDk3MXN0a3NUUEN3?=
 =?utf-8?B?RXV1UWhMaUNZUUUwSUt6c1EzTGtHR09ncnh5MWZ6dG10STYvZnVNWFRDcWJ2?=
 =?utf-8?B?aDJRRU1DYjc0TlhmaW1LcWlRVnBJcnljb1ZTZHR3Y20vcGtpNHFYQ0M4M1Iw?=
 =?utf-8?B?d243U0haSkxtK1ZaZWpMd3RLZE53dFNmS05SRkhVTmtKZnBYMEZNa29Jb21S?=
 =?utf-8?B?d3d6cXdpdUkrZERsWnJ0WEFKVjRqQzB4ZmIwV1M4bHpjbjY5dmRiYWZLVGM2?=
 =?utf-8?B?Z3hjSXVGTHhybDlVRHNNaHZkM0JDK3gwVnJxZG1WZnRPeFFuMHpWZ3h3ME5F?=
 =?utf-8?B?Z0RNWnF5dHpCd25WWjJ4TTZHT0RSRkR2WEVEMVJhM3lTRHlkdm1BU2hxU0Q5?=
 =?utf-8?B?V29OeWFURXQwWWxpMi9oSnVySDdZR0RIbUhIUDNTek1ZWnBZMll3SFBpVzd0?=
 =?utf-8?B?WGR1TUVTVjRLTUpHT201YTU0dUZzZUh1L2o1RUYwbzR2TXVoNG1KTXF4STEx?=
 =?utf-8?B?MkpDSTdEVDlzVE1PQXlDa24wL0F0U2hGTlBvNDQ4Q2Nmb25ISnZ3YWN6cGhR?=
 =?utf-8?B?Mmt3RldKSHU2RXFpUmNEenovMk04cGFYVVlmVjQ3c0Q0dWFVODA2L1MvSXh2?=
 =?utf-8?B?STNyTXVITmZ0Qk5TUnk1dlpqUCtsTCs1VjJMMlhLckFJRk1YaHN4V3dqR3Zz?=
 =?utf-8?B?elVoT2p5b0daVG5mZENMbjZvWGlraHhubG1mdTJyWGdjSGlSekFuQm9EeUgx?=
 =?utf-8?B?SEJTTnI2K1hCUTIyNEVxbHdSNTl2T3l4djEwK1didVhHTTNvNCtTWGhkMVRC?=
 =?utf-8?B?THh2UGMrRWQwZlV1OTkrZnR3QVFXdS9kLzFUckpTa04vN2VSUDhGWXVreGRS?=
 =?utf-8?B?ZnNtVGsxTnRjcnRYSEd5RFduS0tGRi9FQnhMUnAzSmdUYVhLWitnVDRmK3c4?=
 =?utf-8?B?eFRoMjBCZmlFUXQ0NWR1ZmlsUkgycVpUTEhuOC94US9mbkU1YTdqNGVzYlFw?=
 =?utf-8?B?UTgrd01mMnVyNTdaYkdMNkFEZHA2dmxzWXdRczJVdXNIUFozZklvSHhLcVJX?=
 =?utf-8?B?Z1VCQzBndVhhMGhNOG1oTC9qWEczVUJIdUh3aHRRSkd4THVTRzQ1MWpONkZP?=
 =?utf-8?B?alFpbFZXQnB2aWVxdzJkOVJ6MTZiYkhZelI5YTNFSFZ5SUMwK3VDWUtPdHRQ?=
 =?utf-8?B?Y1NENWloaEt0ZlkrUlRJKzM1dnpQUFZ5Wk5PcVNaVzQvNk9QbDZpK1dsMVh1?=
 =?utf-8?B?VThPaXdzQnhqWEM0OWNPUkRTUE53dTV1NmkweGpSMnBnV2hKNWpkYjQyZHBn?=
 =?utf-8?B?S1dtUFhGdSswa0Y3REFXMUhaQWw0WThKWjFmQS9aVFJwRGFNRXVwSmMvSHJ0?=
 =?utf-8?B?VklTQmN6OHdTUkEzYU85d21ocHBNZlNUV3JlRVo0ekZvY2JjVHhFNnJqelVY?=
 =?utf-8?B?UzJxS0cxY3dtakpiTVZReXJKQTV1c0NOZWg1S2JieWt0aW4yT1EyWWg3bUZz?=
 =?utf-8?B?MFlHWG14eDd4bVhHZ0YzN2ZmTVIvZHVmQ25MWHhHdFV5NXpmNWxmZFdIQXRU?=
 =?utf-8?B?d1FGcXFmV3BvOE56Q2xJZHJCQjhEd1I3U3RCOGxJL0syZGhhMDJoNDBMUENr?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4562a1d-a3b2-4237-271a-08db9cef2b57
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:52:04.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5J2K+yNfcMPYhYUFYkzJfvttNpuduI6LnwEx6VWI/HFhtoO8WJoPi4Rq4nmAJ6jD/dmTVrPfc+xtH0dctezOgjlXx/YSU4AVLGMGWGsLuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/9/2023 3:33 AM, Simon Horman wrote:
> On Mon, Aug 07, 2023 at 05:34:15PM -0700, Tony Nguyen wrote:
>> From: Alan Brady <alan.brady@intel.com>
>>
>> Initialize all the ethtool ops that are supported by the driver and
>> add the necessary support for the ethtool callbacks. Also add
>> asynchronous link notification virtchnl support where the device
>> Control Plane sends the link status and link speed as an
>> asynchronous event message. Driver report the link speed on
>> ethtool .idpf_get_link_ksettings query.
>>
>> Introduce soft reset function which is used by some of the ethtool
>> callbacks such as .set_channels, .set_ringparam etc. to change the
>> existing queue configuration. It deletes the existing queues by sending
>> delete queues virtchnl message to the CP and calls the 'vport_stop' flow
>> which disables the queues, vport etc. New set of queues are requested to
>> the CP and reconfigure the queue context by calling the 'vport_open'
>> flow. Soft reset flow also adjusts the number of vectors associated to a
>> vport if .set_channels is called.
>>
>> Signed-off-by: Alan Brady <alan.brady@intel.com>
>> Co-developed-by: Alice Michael <alice.michael@intel.com>
>> Signed-off-by: Alice Michael <alice.michael@intel.com>
>> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
>> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
>> Co-developed-by: Phani Burra <phani.r.burra@intel.com>
>> Signed-off-by: Phani Burra <phani.r.burra@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> 
> ...
> 
>> +/**
>> + * idpf_get_ethtool_stats - report device statistics
>> + * @netdev: network interface device structure
>> + * @stats: ethtool statistics structure
>> + * @data: pointer to data buffer
>> + *
>> + * All statistics are added to the data buffer as an array of u64.
>> + */
>> +static void idpf_get_ethtool_stats(struct net_device *netdev,
>> +				   struct ethtool_stats __always_unused *stats,
>> +				   u64 *data)
>> +{
>> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
>> +	struct idpf_vport_config *vport_config;
>> +	struct page_pool_stats pp_stats = { };
>> +	unsigned int total = 0;
>> +	unsigned int i, j;
>> +	bool is_splitq;
>> +	u16 qtype;
>> +
>> +	if (!vport || vport->state != __IDPF_VPORT_UP)
>> +		return;
>> +
>> +	rcu_read_lock();
>> +
>> +	idpf_collect_queue_stats(vport);
>> +	idpf_add_port_stats(vport, &data);
>> +
>> +	for (i = 0; i < vport->num_txq_grp; i++) {
>> +		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
>> +
>> +		qtype = VIRTCHNL2_QUEUE_TYPE_TX;
>> +
>> +		for (j = 0; j < txq_grp->num_txq; j++, total++) {
>> +			struct idpf_queue *txq = txq_grp->txqs[j];
>> +
>> +			if (!txq)
>> +				idpf_add_empty_queue_stats(&data, qtype);
>> +			else
>> +				idpf_add_queue_stats(&data, txq);
>> +		}
>> +	}
>> +
>> +	vport_config = vport->adapter->vport_config[vport->idx];
>> +	/* It is critical we provide a constant number of stats back to
>> +	 * userspace regardless of how many queues are actually in use because
>> +	 * there is no way to inform userspace the size has changed between
>> +	 * ioctl calls. This will fill in any missing stats with zero.
>> +	 */
>> +	for (; total < vport_config->max_q.max_txq; total++)
>> +		idpf_add_empty_queue_stats(&data, VIRTCHNL2_QUEUE_TYPE_TX);
>> +	total = 0;
>> +
>> +	is_splitq = idpf_is_queue_model_split(vport->rxq_model);
>> +
>> +	for (i = 0; i < vport->num_rxq_grp; i++) {
>> +		struct idpf_rxq_group *rxq_grp = &vport->rxq_grps[i];
>> +		u16 num_rxq;
>> +
>> +		qtype = VIRTCHNL2_QUEUE_TYPE_RX;
>> +
>> +		if (is_splitq)
>> +			num_rxq = rxq_grp->splitq.num_rxq_sets;
>> +		else
>> +			num_rxq = rxq_grp->singleq.num_rxq;
>> +
>> +		for (j = 0; j < num_rxq; j++, total++) {
>> +			struct idpf_queue *rxq;
>> +
>> +			if (is_splitq)
>> +				rxq = &rxq_grp->splitq.rxq_sets[j]->rxq;
>> +			else
>> +				rxq = rxq_grp->singleq.rxqs[j];
>> +			if (!rxq)
> 
> Hi Alan, Tony, all,
> 
> Here it is assumed that rxq may be NULl...
> 
>> +				idpf_add_empty_queue_stats(&data, qtype);
>> +			else
>> +				idpf_add_queue_stats(&data, rxq);
>> +
>> +			/* In splitq mode, don't get page pool stats here since
>> +			 * the pools are attached to the buffer queues
>> +			 */
>> +			if (is_splitq)
>> +				continue;
>> +
>> +			page_pool_get_stats(rxq->pp, &pp_stats);
> 
> ... but here rxq is dereferenced.
> 

Thanks for pointing at it. Will fix in the next revision.

> Flagged by Smatch.
> 
>> +		}
>> +	}
> 
> ...
> 

Regards,
Pavan

