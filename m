Return-Path: <netdev+bounces-27711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF377CF0B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60495280D2C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3014AB6;
	Tue, 15 Aug 2023 15:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8512B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:24:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E61E5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692113076; x=1723649076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d7jEUVZ/ceonu0IMyfQmyMtMghy5a9zP7ySXdQwCixs=;
  b=oBa9l+InLLpYXMEwfi1ZebUM0gAgh2UT7qQTUAabhYp3EKYE0oCROtYm
   468w8JCew0VsbN9mD+s65RMgVklHFk7cIkrbQ//jf8L33M4RsbEsaRy/C
   Udov20siD2wTtbAjgGZ05eZui7QkQ0N5ntTp/hSFLAVOaayrAfcMrN/ul
   QZtujb8FUWxtguwQxOIN57Tz0IYMP31T3VCMOD1LxRdv8UmdhXRx3jgHc
   Znqkm3YkP3lQ9hZsfc5e/xZDl4u9Voq4P0wIsSlvv/Q8MZoyke5ezG1IR
   3vby4QH3nKOMgIYBOe8rWpNkaAnzY3uF3+VYD8NX5WpqobPEst4etK8K5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403282851"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403282851"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823871568"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="823871568"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 08:24:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 08:24:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 08:24:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 08:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juyCJEGuD3lydnql3qylQGU5oJtdHZhAWdB48tuIUEgFbnJsdL9D+hkTzxrocvkr711lOegH8IcZSWvFDC3FpZMm78UsfGvs2hjYE/XPnVkAga5OgdA1En5nJ7k8Sbs1iKiBVbpWDxJdRLHQ9caWDaa8wn2qAjq0C5yBTgaVSKeL9r9LroIOg0tfp9dn61B/O2AVAE8+YEooFW9x7QfzW2wYzFweBLJIcRDWltJcTQVenCJO4ojB3Wjk2PyAI2DT5pgueE6aHw0KgkuS5iakA8cIUmbBWLsxII7twimYKA3Z9qpTF0JbZIQ2E9uKFI/c5KuJ53grGBK3ymxREZWMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3apdpfW+BCe33CDYMhIzOi3XFo9UFwKU0RVWJ75OyQ=;
 b=ShzWaT72gx4ZLHgUnil6WWhQI1a0TpKc6MfqBpUObNXiua8AqwIuTONrjfDLR8BBNO89hZlrmejXKp/q8TLdTUb6tARbGZELo5oi4mUC/+614vH6rtLpJA7RvVjFLkf26IxVXuFzm5unUqkbaTLNKPXsT4rmRBvmdGKTGf9MFQY5JMKJrg4tvzD+xyKsPH4vbFd7fj7srH00+nPyqHyWtXwPHj8XYDNVO1B1Ii+hjToY+00rRLps3cbUKqVl7//SFO90DtAA+/GJAZa1+7LrY8sqIF7aYgFlYPBUxzAjSoWN1chIHKGe2YneM9eRubEw6Z6n2/xEx8bgTccusUZttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by MW4PR11MB5798.namprd11.prod.outlook.com (2603:10b6:303:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:24:33 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:24:33 +0000
Message-ID: <717f19cb-9b6a-bbc1-26d7-facab245bbf3@intel.com>
Date: Tue, 15 Aug 2023 08:24:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 1/2] igb: Stop PTP related workqueues if aren't
 necessary
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Alessio Igor Bogani
	<alessio.bogani@elettra.eu>, <richardcochran@gmail.com>, "Pucha Himasekhar
 Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
 <20230810175410.1964221-2-anthony.l.nguyen@intel.com>
 <20230813090107.GE7707@unreal>
 <f8b9cd9e-651b-8488-5c4f-aacc03a3c9c8@intel.com>
 <20230815052301.GC22185@unreal> <87leecsvqs.fsf@nvidia.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <87leecsvqs.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|MW4PR11MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cf1d64-581b-4e39-b23a-08db9da3ba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnHDAHsrVaP5rtegOZprXVg3RtP3Acndl+XVQZkqEYDgJJlmiYP44ATHjKbhn2S6jjgQ/lqgfaNR/LSb2/KLrnLeRCvgiTC7Za8VNnjyXgTaDXb7gSpGl89ahkPfGhJEnx8y+4ytqIKb6p8owDaQ5B8vO4EaDyora8uNPFaauKL2LSKFt1BtiLJVr4WEW9S7vTz/Q+PbYCwtj9rfkiLQup5WpSvxFHTcll2dL9UHdrgi92WKXY2oZjwnTaSaSAIWf06PVN0lgKU7y3II9MRH5Ps+w+w4VdM/lHUM6TtJyGzMij10pvZ5HCJeqETTKne+Tl0cK8T15MbuhjKl+LQWsX6wrvcjuPm2QgQMJ98m4yU1m/Zmk9CSuhso84i+xd6/Cp0bnr8JZ3gTPHivZqLPvAxTZfqH0r7b0tuYFvLC1YvpY0nJ8sArf8nwLV/ttHEYV4C9eTgR19iE2JOhmlvedwXL9nfd3o7p1/5F3wqYrCmlDSwjFfJVBUdOttSEsEAp0dMMIAt4uWR+uzJTg5S+WVLoBNNCniSynwoZwydI43sf70MZI7If1RSTgJ0KfzhAZ3VG1t3gf7MeRb1DRW2QR2EWiOyPsnCGcbpXt0llyLmf37F875ZOCFFFzBVk5BxdMMJYcblaCJ8bdxfQVW2TIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(1800799009)(186009)(451199024)(54906003)(5660300002)(478600001)(31686004)(2906002)(6486002)(53546011)(6506007)(82960400001)(4744005)(8936002)(8676002)(26005)(6512007)(38100700002)(110136005)(36756003)(66476007)(316002)(66556008)(4326008)(66946007)(86362001)(6666004)(2616005)(41300700001)(107886003)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9NMWdMeDRxUmNLOU85ck9XRld1bDdEdHRpV1Q2VkloWExPWlVxMmpBb2lQ?=
 =?utf-8?B?ME8wTGZHY1lHbzJRejNnRGVEOUlzVkdLeXhHNmR2cktPVUloS2Q0cXk4dnRK?=
 =?utf-8?B?Z2JiTFNRcUUxZ1RaMDFrZFBSSC9LeURhdFIxTzZwOWRFZ00zR25aNVVudHhU?=
 =?utf-8?B?ZjNFMzZiRVpLUXhDTE9iZzdIN0lFM1hMOUFjelNWZ05zOGRTRForVWpZMklF?=
 =?utf-8?B?eExTVllSaW50YUZ2aERhcTlhUnhxTy85c1VmVGxJeEh5cHQ3ZDRmTTBCb005?=
 =?utf-8?B?MzVubVprMWg1cGVvdzhVUGt6bFE2RCsxWEl1L1VEUmJoM3ovMmtZMXR3cU9U?=
 =?utf-8?B?V1V5Tnk1T2hURlB3U1hZWWVnUVFJbDBWcFBlUUEvRnVURDh3RzNmU3puRWFE?=
 =?utf-8?B?WGtvOFpvY2xSZFhFQWg5Rko4REs1UmU4Z2hsRzFmRmNHVUUvcStzSHl1dWtC?=
 =?utf-8?B?Uis5b2lZb0NKK2lRZjJ3K0dXZlAwQVMyZ20xaUE2aHdBTzZ0ZjZoZUZXQVps?=
 =?utf-8?B?VFNFa2lnN01TT3RLcDRjSHB2eVE2ZlpZRzZ0SU9IRXNDc3pzaE8vR255R2pw?=
 =?utf-8?B?QWVpcG5Kci9QOTFMQWdzMkV3bVY0RnV3MXFBRUlHZjM5ZEI4TU44M3R1SVZo?=
 =?utf-8?B?RTV1SUhJeUdVd1I5SG82dXhQRkVKaXpDbmpHN0R0TDZnV1A2RVBxekhFQzlp?=
 =?utf-8?B?VkZyRWRzZDJJNk9KaWxHZjBkZ3FoWnlENDFzQ2p0RzhraER6QVBGWllJYnVJ?=
 =?utf-8?B?YmZKdHVRZTF5ZDkrMUdPMDY4TGRKZGZRQUpObmY3dHdoYitKY2xwNm1BZnJQ?=
 =?utf-8?B?NS8vcDdGSDF2N0g4R1lMWWxaV0dRQ0cwZnpDZHFFOFhra0MrTk5wdjdDZmpv?=
 =?utf-8?B?L1g3K1ozdW9jZFlLYWtzN3UzTUtBLzgrUlh0eEY4TVFSdVlNSVU4ZHdiRWdN?=
 =?utf-8?B?cUFaaWloWmRMa2lXeFE4Rmg3dHBGb0RiU1hkemdqR2czQW5kRG1DS1lyZW5I?=
 =?utf-8?B?K09VMVRLRGxhU2NTb3lNUFUyVldGZUNVRWxKNXpZRWdaWjZnU09ONnRvWDQ4?=
 =?utf-8?B?RU1NT1gwbnQyM09pbWRsQzdUOGlxVkdQa0d4czdjc1ZzWDVXNnRpNjIwVmk0?=
 =?utf-8?B?YnNvSUtBS3h0VmhwY3R6WGR1b0xZQ2VRb0k1OVF2SElNWElmUzVHNElNWjBO?=
 =?utf-8?B?eVBiSnpiZnFBQjNsck9ZV0grbno5b29BbGNMYnFtQTdzcVh3cEw1QytNU2lu?=
 =?utf-8?B?MG9ZT0h5bDdLK0Q5Vys0OXZlbGE0T0VFRmNrSXBMZXBGTHRSd1pIOWpuR1NB?=
 =?utf-8?B?b1ErVk4rMVVjM0xjQldyWllJRzhScHI3Ryt3bWR2a1hDQVJzS2drR3pNNWVJ?=
 =?utf-8?B?TjVBbUZiNDdpM1dZOE5uVkp0NVVGdHJZcVNsTk1Idy9Ud0NyRDFQS2s0cTJj?=
 =?utf-8?B?ZWJjd25rT2t2QjVibmxmMDdyQ2lEUWFDZXVScmNNOTVrYTNaU2lIemc5Q0pI?=
 =?utf-8?B?RlBIM20vYWFsVjJkc3l5cEx4bDVJZlJwekoyOWdyS0dPVndySTM2Z294U2My?=
 =?utf-8?B?WjIzTzRNR1lOY3RIbzJIemw4YlhuZ1lzYUQ4c0hnMExJNzJnVUJENGRwNVp2?=
 =?utf-8?B?TWFOT1BsVFJLTVFOY0FGOEt4Q01ML290MlY3dlNCVS9yK2dRb21oWHpoQTFM?=
 =?utf-8?B?QXpOOGRlS1JqWW42eVNiTS9QS2djR0F6eHRqSDZYaXhqT29UZERqU1l2QklR?=
 =?utf-8?B?REJ0U1lwYlgzUDNXdWRNL0JwRGUvY2VTd2ZDVUI3L0dlSWhzUjVnSXQ4cldx?=
 =?utf-8?B?QVpIck0zNmdTdEt5aHhtaHBPZ01QOUhHVVdmRTlHdUhSL09CM1hCUHlEdFZv?=
 =?utf-8?B?YjQzQ1BhQzFLblpSZzhDOUlVWG9WbTNzQlc5UHJudFUzNTZ3TmZpbDJzZGRj?=
 =?utf-8?B?RGZ6R1lxeHdTVFc2aVYzK2EyS2JmdGhURWI0OHZXM2RaTFlHUEd1ZDJ2MnRM?=
 =?utf-8?B?ajZmaGVPdjRLWGJwSkgzVmlIOTRRKzJSWkhUNFBmS0psdjYzZWF4RnBEYkhB?=
 =?utf-8?B?a0FaWDhHNjc4MkNqYTRqcVd1VEpYc2JqSHBYQkxIQlRIMnN3dlJaOFNTYWRP?=
 =?utf-8?B?QXJ0R2VJdk5JUDhsZTU4aHF1cUxsN1B5cXBLNGhpeW1heW9SYVhCWHk2c3c1?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf1d64-581b-4e39-b23a-08db9da3ba57
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:24:33.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMzkSPb4XcnUxCjzXWNmj9FQ57A2hbhqbBftIWDFQdEcaVtC9T5i4ooptxgLt+Ax+3o+gr6kVuUUjB8tnyeLluwBjK2ys7wu7v8/DOAGfQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/2023 10:46 PM, Rahul Rameshbabu wrote:
> 
> I do not think it's an issue for the work initialization to be after the
> call to ptp_clock_register after taking a quick read.
> 
> ptp_clock_register essentially sets up the needed infrastructure for the
> ptp hardware clock (PHC) and exposes the hardware clock to the
> userspace. None of the PHC operations seem to depend on scheduling work
> related to the ptp_tx_work and ptp_overflow_work work_struct instances
> from what I can tell. Essentially, the only case this order would matter
> is if any of the adapter->ptp_caps operation callbacks depends on
> scheduling related work. From what I can tell, this is not the case in
> the igb driver.

Thanks for clearing it up Rahul. I believe I have a version from Alessio 
that has the changes that Leon suggested, but it hasn't gone through 
validation yet. I'll drop this from this PR and will send that one after 
testing.

Thanks,
Tony

