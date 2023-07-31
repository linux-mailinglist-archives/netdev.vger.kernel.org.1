Return-Path: <netdev+bounces-22978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F276A46A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ACD1C20D26
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD91E522;
	Mon, 31 Jul 2023 23:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F221E51A
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:01:08 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FA11BD7
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690844467; x=1722380467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IwSNEOTheqKlByYvl7HMuroe9QbG3JFUZEiZ4/aP0dE=;
  b=hbJY1FT2DijzNj8FxOrF9KFCZGMi2qDHyse1I+P0IjFHAMSSr8qfmqyl
   g7NBXComRkt8acIXrSkHvZfkGLX138D4MRMpTbX/AoX9Gvu87jP4MEzwW
   Z3fOM5JZ803nJliBfIbQLdtVtW/s4smxeHxbsWdtmqqDW2qW7a8TqrCf9
   WTLJDfovbmVu5uBcDTAFw5w+2uCM+e1nzlzCHtLnmBgKawm8Nbgnpt2oo
   lDXBySm9yBCqJ4/+7GmdP0UQzbXNFIJqY5sfUxsNTqn9qjGn7QMKSnm0W
   HvrawUPWgZRCRueGtMOsmUfseiJn8SApJbQ2E5d7L9UhN4EbWjahBSUp5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366617958"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="366617958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763544458"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="763544458"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2023 16:01:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:01:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:01:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akPmCtey3xgLK6MtPEGrXXpmXorm2B199O70i59dQOsC8j3RKsYK4Ce1fG0lqQn4Av85EyoxL1839i1Xn2qjChIy4JVAlf/imc5aj3wo6zeadB6LIPfrBrWDXOm7pyqkMvMShk9gGpSx4ty55HzI3hA0zDuT9FFEVKbDider+Vnrd3z6gE47okgjexaqID008U/s/BoPjjlvIph3/aMqyRbG9wv3fz5h3ASN7eHhwVed4JB9yLfPzgjGzzeHj+Jlc9ryhv2GM6+AlZcfOowV0EEmUntOEbl+SZPYzyl8E053zVXaPFO67H+V56Ht00kxwtVOEqAOfhGA7CA/eEaLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6ip3pjlPxMMLuM7IBLYkp1JYL3mCjyBCSmXhbMg+PA=;
 b=jM2KLMjmxu3mcmPxjrKxCkeweKA7sgY+4ryqgL9/elg56MrJ8+d0dBZALqUV99Ceuq+8rtzO7+6YbxhUgMXVOasQGs85eNWZ7YNd/Rhxs/dk9mNpg2hslPgcU1W9wlHjf/CMCtGGig5WbTvGkx/y+8Wc4HuHji73XArwwhBVcy4dr7SMGJEMjFkdcGPs6HU7qToCADVgqZrPwdo/v8sW0jHWjnJR/yPdFMYEQ412muru4eF/Lv9wjUe0AlKUiOMLJJXL3+E0CVPcYiQ4kDgsTa6Oqg96viIdkp6QoVDhTqQStrRJ/PuksWtk4dkiPbkaOZtZRiqI/JkcTl2rlRBuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 23:01:04 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:01:04 +0000
Message-ID: <7554b924-3c09-596a-af11-f3d309bd2d19@intel.com>
Date: Mon, 31 Jul 2023 16:01:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 5/9] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
 <20230731123732.5e112027@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230731123732.5e112027@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dfc0f5-d1c1-4f1f-4ab4-08db921a045b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQKM9ZW1utx7HB1wXUXbC8fcvfCcGF4MrXPVVGBL5zHqsAzPjtC+FDJ4tUFvAGPwTZihUMvaIH5ICTTLa6+psL6D7L2meRUesKOdhaMCOEuhJWhU3boXKI2d/Sn0F4jGbv0VB1GSd8U2c/3T59RJ8pinR2CqURBDj9TO4rGHYdQAyyV9b2/Snit9nFFd3nhNsDB/x1rjxqj23q4ie6n6suwblMr5xqmcDFiLJNAHDbA5fU8GLaB8J9k/oHhhfYDkBdGfMtkwH3dVh3dy6uG2Z2my4q91Zer5fxbpMJrwhs0/1jokJJBZBPxi6J20XraUXsXxrK5GGQdSgcW0cj2ZSaGhEUJGwmT1TORb+Q+NJDxgjZ5hx/ZV0mimo58v1ZH+C3+qyDglnc8D9uRWMMkQkdRrYbv+JfA4N8hf2PMVl5koYakPd6IqpeAfAW4jM+L2+R23fTsufledZa/k4DTron2RDLE2XxynFuB/+XuHK85ut+yTWutPHyZjNXeADRbNc/t/pT5LCOQRkxvHbj/c+xHq4ZUaFYVJ4AnrCR2i2PnghZidDI4wrvQ0gZ6kfjsunUEuhGl2XEXawwln7MCAZlsRprtbWasrdEb95EfgkyURdEWOvDtgbGGL33UUkQJYQNRU9aKcq6VXYgmZj5zd8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(38100700002)(86362001)(66476007)(31696002)(8676002)(8936002)(31686004)(5660300002)(316002)(4326008)(6916009)(66556008)(66946007)(82960400001)(41300700001)(478600001)(4744005)(2906002)(6666004)(36756003)(6512007)(6486002)(107886003)(6506007)(26005)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJ4ZFhGODdrU3YxTU5jdXo5STZZeGhlOWdpajAxQjRRaGVHYnJmdStzTm1H?=
 =?utf-8?B?WWlhRTkybzhvQ0syaWpzUzlNekRBYWtMZmtpWWZqWHF4WEdHWXBuNWJJQVUx?=
 =?utf-8?B?Um00LzdhUjRaRXkvck5ldFJGaEs2Uy9MOFVwYXU5aEVyUUdyN0tQL2hNS0pW?=
 =?utf-8?B?MVNuekRrRHZCQU9vS20vTGdmekl5RnM0YXZvU29HR3RPOGpkY3F0aGg5TGNB?=
 =?utf-8?B?dFNueE4wZStsajZqUHRadkc1ZC8xSHBkNnpFbFFTRTBxMW9ITGx5S2RFbjJ4?=
 =?utf-8?B?NDdjV3laejBVbzJWSUpoN3FGYWNTeThjdzJyaXMrUEYzMk9oVjV3cEtmTXpV?=
 =?utf-8?B?NG1ObXQ3WkxhNnYzRG5LZjVCcldRSmJyQTlYbnJyc2RDRFYxMGlQVkRrN2lL?=
 =?utf-8?B?aGtIRmVCU0wwazg0d0REckcrZWFueTJkQzVWUm5lRXpBVkFianFYWTRvdndT?=
 =?utf-8?B?WXd2MmFWVUVzanE5Zlcvd2N1cDkxWG9hTVkxam9ZRGNPUnZZbS81QUpJTnli?=
 =?utf-8?B?TmF4WTVQUE0wbHNyUVhDM3l5RGo0OW9hTHdPTWg0TTlrQ0dPcXJaaHJXOU5Q?=
 =?utf-8?B?NlUyOE1qTmNhcFFKRUc1S25leTRUd1pRSU5BZUZCRFNGdlVYYkxTNldpMVNv?=
 =?utf-8?B?SWhIY0Via3VvSThwZDlETVV4bnRzMXhlNVRaSWlCdU1tRlk4TzBGbi90aktY?=
 =?utf-8?B?YVgxaFAzUytZaXk0b3BsN0d1eG1kUWYzUWVNYUQ0VHExYlNmMVNFUXdRSWxj?=
 =?utf-8?B?WHBWL3hDVlptNjhBZFMvNGJud25DS051SE15bHNMTnhJTnpDMkJ3czY4OEVx?=
 =?utf-8?B?dlNmNC9TNVk1blIwRGFhdkE3TnYrY3ZoT3YrcWlKYzFLbFVWblVVZWVwK2dO?=
 =?utf-8?B?RU5MUlFkWjloS3NlMHJaV0ExZ2ZreWg3NEY0RXNtdk9VblFrSENSRTA3UERG?=
 =?utf-8?B?ZnY0UUVnUHA3ellzM2ZUSC9tdlBLOGtKaW1xOFVucG9UMFoyZHZmMUZJOTZB?=
 =?utf-8?B?ZU0yUWd3MlZMZWNHK2lQZ0RVT2tvRFQ5bUlFN20zWGFHNDRFNDhxYU16ODZS?=
 =?utf-8?B?MVRrWFI1Rnl1em92amcyTEZSRE8vaEpCVGwxb1RPMGxXT09zS1QwdGtvQTdO?=
 =?utf-8?B?U2FXTXZxVk1ZRXlKNHZaQ1pxVTRyOHZ4ZjFLVVhtUWlpSXNHTm5YMGp3NWx0?=
 =?utf-8?B?N1Qxd1IrTGRGdnQrQmlxdHlsWEJnTit2QzZmQm1mYys1N1hjMEJQajc0OUxY?=
 =?utf-8?B?NWg0NC9rZXlvcVk4dVc0dEtDRllBTldDbFl1LzNHMjhXZFR3NmxjN0c0Tzhx?=
 =?utf-8?B?ekgyZ2p3ZlJzVHlEMncvb0hhbUNNRVE4ZVdZSEVKTGJhSStyYWh4c21abXph?=
 =?utf-8?B?R2VNWkpvT0F3OHFZOGpjMTUvL3p5Z1JINmFWUytJRy9UbHBxZTBEOWhLck9q?=
 =?utf-8?B?eVBXQzd6aUxGcm42ZVQrcm4rZE5XTTdyRXQ4WEcwR1VKbjhCRnk1aVprTWxM?=
 =?utf-8?B?aGdsYVZ2K2Yvc3RleXpJNDExYVhXZU5UOHNKTWR3QW1IbVBrR3RYakRwZlI5?=
 =?utf-8?B?OXRiNExXaWh5RlZ6UUNNM2hsbE45azgyWFgyRytPdTlNZCtaQkRUUDJEY1Jo?=
 =?utf-8?B?dTBMVVN1Z3FxakRiZElXbHlUSTNRTlM0cGRHRnlMMDAyN0orNDZ1cGRuZzYy?=
 =?utf-8?B?OFdHUEJRaGdNT2g4M1Bub0M1RjRJTmNMczQwVlZSZ1NnOXExbGdnV1pkUTVK?=
 =?utf-8?B?WGRqT0ZBUHpYYVlLNU1OdWQ3STUxb21VNUgvazdQMHlFODdFY3pLR3hrSlk2?=
 =?utf-8?B?a1p3NnhqalNRcEtPNXlTTll5SCtLbVBKUWpqN3hMWWdGM1dxVGx1aXJyUXUr?=
 =?utf-8?B?MmI1ZmVGNWoyUk0zeG1uMGdMd2lRY1Fjcy9NUVl5VnU2Ly8rNWR1NTUvSVd5?=
 =?utf-8?B?enFjZmJyZXF3dExadER6WlNxY0crLzc3Y0pPL3FiOFNsWWZOR3c4WjU1bEZI?=
 =?utf-8?B?RE5xM0ZLWiszMExhOWlZbzR4WGt2a1V6WkJTZzB0K1JmR2V1dWdITFZDakZK?=
 =?utf-8?B?aE02WmFBUUVsNnVldDhXaS85M0gvMzl5YkszcGVQZTB2RlVuMHdua2R6elBV?=
 =?utf-8?B?TkVaZW1DSW5RRU1RMU04VmdRTUt0Y0JhT0szMjlQTHRQVk0wRXg2aHhORmpX?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dfc0f5-d1c1-4f1f-4ab4-08db921a045b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:01:04.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CNMH/w2YLhBm5jfuviWvs7AcV1sgNa5HIfTCh7ViPAq+PaeBDHfzkDfIFW8In1ZQetg/dzP9lOOhIBkw3okexpqwRi8ZU8+8hU3hr5hETA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/2023 12:37 PM, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 17:47:17 -0700 Amritha Nambiar wrote:
>>   int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	struct net_device *netdev;
>> +	int idx = 0, s_idx, n_idx;
>> +	int h, s_h;
>> +	int err;
>> +
>> +	s_h = ctx->dev_entry_hash;
>> +	s_idx = ctx->dev_entry_idx;
>> +	n_idx = ctx->napi_idx;
>> +
>> +	rtnl_lock();
>> +
>> +	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
>> +		struct hlist_head *head;
>> +
>> +		idx = 0;
>> +		head = &net->dev_index_head[h];
>> +		hlist_for_each_entry(netdev, head, index_hlist) {
> 
> Please rebased on latest net-next you can ditch all this iteration
> stuff and use the new xarray.

Sure, will fix in the next version.


