Return-Path: <netdev+bounces-40564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9927C7AD1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F25F282C18
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D136C;
	Fri, 13 Oct 2023 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJtnY89o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E64360
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:25:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFEAC9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697156698; x=1728692698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GD4irJylRszsPY940V35sJ015QeDikgapYO6yo/6xzU=;
  b=VJtnY89o8f8FNj9mQT62VbbrWZauPpDLtrOvhSiNZ9nRqUZstn7PPgzM
   MgrwxSAPgOqjOCLSx1Fikwd8Qc53ansK623/jPObbhcK2qDTrFhGTM2Rn
   YMDEIwUqOtN05XZ56awOhSE3is1ebzIvFMuvA0oXSPnIby4LbJOI174Z1
   tCCoQra8vbABAdeehdlBF4wXy3t+3qFjEG9g20XtpSO+Xt+X0F4/z3P1l
   nMCSdKfMCaB3xaOrp6e+QBJ4KXHxxxQh5rRRpjRR2jXy4QOC7JSxKoU1O
   odDnSOCyPeN5DaTqeX7lKJ7RrqdkkPqkIzX1/Triki+1DDDzlpLkSTnML
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416121116"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416121116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 17:24:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783924218"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783924218"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 17:24:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:24:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 17:24:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 17:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQrbsBpkFN+c0C6XQZgjyKMJv6OOkPjUfwsWzfX49zp5gC7VhQIjH4alYzfPLKl8+ZY3JSPOh8psd/hBbVsgMd/Xl/0jQqlPMhNzXcfVaDChQ434TJPpZJFQa9pfh5SgVRXm+yEdQ1rABakXv2wgIgDmi16lfUPf5qvxOZbX3ZE5V/JvNgyy/9EkCKdw+f/BfjWqbf9lhEmRaPle2EPk9dkQdfZorVJI9+jMBr0SZnyReB5IaSNzNe0eJ3pMlL43BxVcCdB3DPp8oiD+H9u0VxQM/GzM5d+3VnMY8rMe9y5uu1HDLpcTAMDTDps394Y40lQaGCK7pam5qHW0CgC1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVnAQk2dHTZ24HoKQNEzr0NR0uo5ZCrIz0BD20NghdY=;
 b=KZqMLZvffhbfzFVSsXygde374NDxap4Ua3EluCma6SRG/z3PsTAfOrMc/i+Q+5YhYoD6wofQZve+rr546A7Gv3WGk4AzGFuatP0LbHrqedkqlQUP3K9FiQIlpczoZVvbUhvQGIM9fESkTHVb9/WTfOXhoRUndNAzc92Sfye8iIlDVbN2itKAIZceuVQrcqZ4q5JIMKqxzthZEJF/0M675Gdr54cP51B5PhGnxqy0DoQbpOiaPGX51LuaH0dzARwnGp0mw8ii3FbMcEp/YM5sOZkt0vOT3nSCyH12un9PEzZUo3IVo5RwuilMrAq/2JvQShYRD0G0Q5J5JUjfO8TuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 00:24:48 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 00:24:47 +0000
Message-ID: <8c9704c0-532e-4d35-a073-bee771cd78c5@intel.com>
Date: Thu, 12 Oct 2023 17:24:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
 <20231010192555.3126ca42@kernel.org>
 <fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
 <20231012164853.7882fa86@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231012164853.7882fa86@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA3PR11MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c34a57-d35e-469f-f5c8-08dbcb82ce6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xN+jcPLQaP6YAHdrqbPk4FIyp3tlGKvh1r9pfJJjp9NeMS9Xs4T3VMqaHA+z8cPppdssUCvdnitEAFuFJR7EBewMXwNd9Mn/gxmkQwa47AG+WW5U2TLgftBhVZ8ME/Li/ZHdl3vUlI9RDm6svpIwS39Gir+XaNQhP0xozyjB7xl4bMCEJOTXi/qi/UVvFptyfR+Es5AaCgfhufIJ2JZ4DSQtLn0CxdFABVozRz+d27nlaHUDfJWGWB0kFX1J+VyzgHgjSHBGC47Lnxw93HmuLLVeQNMjwRlSrbH/A+EmC6NVbdlgHr30rEK0t0DRnVShGUOrH5OwXXX+pxWkKtBWbecKS9xwfXQDBjkiocPxdORwPzabgJ9IpsjRr2jtcFYmB6FINv6In9/Mid3665ZKcdC4d/bi6YJmKjzQr8H7L3kizhh70A9FcKFgkKVpgq9EckmrhDFUbbuOrkKqJK0j8kpb5iM0CLfp/Oqo8WT3jlcJCxvcj2hBNrtNT17tsenuSB7DSMSqM5Ym+VYXar2HymdjsHaFSGjlfs8Nr7XJAv52/A5XAr405qL7jdC9KXuqq/lajz5lvHJmegW05u7h8RxJmFZIZmdfbdL0q3LENJTs93lAI17u7PWFPKeAwruD8TBXOYO73PxXuLE06TWcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(6512007)(4326008)(8676002)(31686004)(8936002)(478600001)(6916009)(316002)(66556008)(66476007)(66946007)(5660300002)(6506007)(53546011)(38100700002)(82960400001)(86362001)(31696002)(2906002)(26005)(36756003)(83380400001)(41300700001)(6666004)(107886003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01uL3JINUlHZHRZVHpYZ1VJUW51MXdiN1RoblFCeDhGTUg3eXZvekUwR3Vz?=
 =?utf-8?B?U3JDV2dVUFVOd0hHRDlLdGY4TXBuTUJqZ0RjczJLNUhZbmFxSnlVckNXTng5?=
 =?utf-8?B?SDVBWXBKdUVXdXo5NE1JQURyMXpOaXVIK2RVcmtmOEtMSlZkeitoOWM2ZVR3?=
 =?utf-8?B?R3RMb2ZkZ1pJL3hFalAyS2tyTjBqbmp6Z2grUktsSzNMYmUyRk05V1owMklP?=
 =?utf-8?B?RGlUTk1iN3ArN09zQnZFS1lmWGptakUxemhJUzN2eUZab3g0Nk56Wkdjektv?=
 =?utf-8?B?K1gxVEpvUFhDMzBwNjZJKy9TUHhBMDlQY1FqRVl4RFZ1bDhvdVhnR2tuYURD?=
 =?utf-8?B?MmlMNjlvWlZ0dG9DdFF2d2ZCMjNpNi9BTHcxNzdWOTBDWFF6Q3l4dU9IMjk1?=
 =?utf-8?B?Q0FSbFNnaUg4bDhPR1B6eUxxV0FROHFhaCtieUtxTExuYmRTTXp6NjlsVGQ4?=
 =?utf-8?B?UHdxOXU4bHo0ZzB1aEs0ZXI3SzFwaGthZnFmZThkQzlaRzJrSmJ3UmRva2dO?=
 =?utf-8?B?Zlp2S3RuSWJCcVA2UmRwWXh3K1NmL0lWWEdHdFBnRGV2NlBPS3RnYjJoYWtw?=
 =?utf-8?B?RFliY0hxcnNadWNuRy9iMXlnaXN0ZEVwM3dZZjVpN3RLUTZkZ1liQXJMTll2?=
 =?utf-8?B?MEVnN1RDakg1SnlEblFjencxUU9RTzVURGdXSUx2aE9sNjJwVmwrYzc2d0Nz?=
 =?utf-8?B?RVd0b3ZjN0JoNXlFTnNkWUhHeW81SmZrUTFJTVMrZUFRZEpUQXhydFhrTDZQ?=
 =?utf-8?B?RTZaUUl2RGFINmF4RTJQd2lnQUE1amUzMlFBWTgyWVp5T21aQkJraHJLcy9m?=
 =?utf-8?B?TXpTZ0I5RStqZ2t1NE5CbS9USUY3VUVXWmpJMFBnSC93UVVGTnNraWlXR1Zr?=
 =?utf-8?B?NUQzbmpIbnpJeFgxTFRMaFkvTCtxMjJ0SGY3RW5GbWpIRDJpMjhKVlN0S2dy?=
 =?utf-8?B?WWdQaGhyYkR0blRLQWpFeXUxMm5GdmhKcFZ1WWQwdGhqQkFMUjFzNVFkOG03?=
 =?utf-8?B?UkFmdTRaS0VHRnZmdmZOT3pEK1U2ZFFKK1hSWkw3b3BDc28wOFppdlpNQnRo?=
 =?utf-8?B?ZmtXbDE1UitBSXIySkpmcXk3bWxDVXJITjRTZ0dsODhDYnU2dDdWakJ5d3JS?=
 =?utf-8?B?MUpKUnllQStycGRHR2trMGNVMnFpZG8vV29xamJnYmNkZXd2QllNbjJ5M3pM?=
 =?utf-8?B?aW12cS84ZDJTUzhoWEF0NzRIamJmTDZZZk1RQzVZa0ZQY21jSnQ4LzlkREFD?=
 =?utf-8?B?VEN3SnNoUVB0TCthdktHOUlWYk1LMVA2a24veWNFSzRlR2taUHdudWN0SDVw?=
 =?utf-8?B?RFlwVTNidkpubnBSTGI5Z1ZYWFFLNnJKNE9nUm1JUVVKb0hZWWNvamVHQWsv?=
 =?utf-8?B?YWloQUNqUDBPcDNvakx4UzZxZytna1NFYW9qWGhtOXc5VHhyek5DRFAwdDdT?=
 =?utf-8?B?WDFYdVE2QW13VVRBc3dkaW5Od3QzYUs1SnhkU0x0R0YyZHFNSi9zcWFmdmE4?=
 =?utf-8?B?QXZ2S05ZR29aQnFiNUgyN2ttRFRQajAwblgyT1JNVlZTZk1XaXNxR3ZYb2dC?=
 =?utf-8?B?UlFjNTc4SEdoREhxMy9MUjhJLzRzREVKeFlKNDVSVDVSU2lrL1lmbjZ2TzIv?=
 =?utf-8?B?M1NlaDhsZnQ2enpIZmpPUnR1c01aVE8rYnVibm9UTkIvVkNOTHpYbVlvMzZP?=
 =?utf-8?B?NHVJeUd6WHowRzVWdU5JVGVWQ2o0Yk1HRllTQi9ybHBnbE5ZeERNbXZ0Nkh3?=
 =?utf-8?B?WXJUVDQxMkhnTHJ3K1JmRmJKdnduaUdYdFZKcUxTYmxPQXlVOFc2YnptR3JP?=
 =?utf-8?B?V3E3QUcrYzYzd3pnbUNaRWRZMFFiUVZhQjBWbXNYQ09JWW8ybkg2d1JvTTBJ?=
 =?utf-8?B?YWZObU1GY3B5d2ZZN1JyekJWeVliZnh5WTQ4MEdPMk81ZnpDendXZHpHNkEy?=
 =?utf-8?B?RE1WdFQ2alBsaVkwbEhjeitNeEFISmhFaGhSZ29ReCtMSEZWNVhjNDlWZ2lw?=
 =?utf-8?B?TjcwTEo1QmVSSlR4OGlrWHlTZ2lxMXNhUkVNR3VycDc0K01TT0ZIMjY4R3ZH?=
 =?utf-8?B?eTBhTXhBZUZvditzaFU0dC91VGVoRXVLN3htYlppRi9hTXdvdVpXZm81bnJo?=
 =?utf-8?B?VHQ1SDFoVFc2d0pBWFdIZGlydG5hMFlCbGpIdmpPWTNpS0Y2eGsrUzkrTVI1?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c34a57-d35e-469f-f5c8-08dbcb82ce6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:24:47.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6k5erqIqzHbZe7/v8IPnU91JQcUHAX03MQrIZcyvyFoqLG5YEHWs3ur9vgeK1na5esgasY3tYGOW6+N00Vg6J7MDxT/Dx8d8VqNe2Qbi74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/2023 4:48 PM, Jakub Kicinski wrote:
> On Wed, 11 Oct 2023 16:54:00 -0700 Nambiar, Amritha wrote:
>>>> +static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id,
>>>> +				    u32 q_type)
>>>> +{
>>>> +	switch (q_type) {
>>>> +	case NETDEV_QUEUE_TYPE_RX:
>>>> +		if (q_id >= netdev->real_num_rx_queues)
>>>> +			return -EINVAL;
>>>> +		return 0;
>>>> +	case NETDEV_QUEUE_TYPE_TX:
>>>> +		if (q_id >= netdev->real_num_tx_queues)
>>>> +			return -EINVAL;
>>>> +		return 0;
>>>> +	default:
>>>> +		return -EOPNOTSUPP;
>>>
>>> Doesn't the netlink policy prevent this already?
>>
>> For this, should I be using "checks: max:" as an attribute property for
>> the 'queue-id' attribute in the yaml. If so, not sure how I can give a
>> custom value (not hard-coded) for max.
>> Or should I include a pre-doit hook.
> 
> Weird, I was convinced that if you specify enum by default the code gen
> will automatically generate the range check to make sure that the value
> is within the enum..
> 
> Looks like it does, this is the policy, right?
> 
> +static const struct nla_policy netdev_queue_get_do_nl_policy[NETDEV_A_QUEUE_QUEUE_TYPE + 1] = {
> +	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
> +	[NETDEV_A_QUEUE_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
>   	                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yes, this is the policy. This policy does validate that the max value 
for 'queue-type' is within the enum range.

I was thinking your review comment was for the entire 
'netdev_nl_queue_validate' function (i.e. if the max queue-id validation 
can be handled in the policy as a range with max value for queue-id, and 
since max queue-id was not a constant, but varies within the kernel, ex: 
netdev->real_num_rx_queues, I was unsure of it...). So, another option I 
could come up with for the validation was a 'pre_doit' hook instead of 
netdev_nl_queue_validate().

If your comment referred to the enum queue-type range alone, I see, 
since the policy handles the max check for queue-type, I can remove the 
default case returning EOPNOTSUPP. Correct me if I'm wrong.


