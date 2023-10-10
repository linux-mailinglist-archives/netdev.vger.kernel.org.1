Return-Path: <netdev+bounces-39676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E397C4077
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749AF1C20B9F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85947321BE;
	Tue, 10 Oct 2023 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeX/ivBQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9732186
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:58:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4A8E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696967917; x=1728503917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KqfibQMuWiI8zoYwsBSvTUYVigONwJAa/BcSXFsAEbg=;
  b=JeX/ivBQHhg5DpidT5YtMothlJphttrs0BZMKVpJ5A5IAvJv09ljj+R+
   wiMTNm6PQZ7g42yBtaLAsya4bojHV00Ys7OUoaNu8GAjS9G8x6hTDjsUh
   lIuLxFErlCC0YR3vPj5xKOLvI3bfNSCxyjMGEw2L+UCKzeUg2megUixZ1
   V9hyd30PHqDiHG6Yu0FZiuY55UYrl1/yCkA8c/95vQu9zwrqKeh01U2VX
   IMZ8RuACb3kvjG+3tGlPqaoVX750sVdE7L12ivw/bjmkveVE9EwdkhoG1
   WYU6QJve06/xu1NqghZyJYbWQTjkn5/8F0BslW9DGCAay4VUwBKMZr0BC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="450992989"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="450992989"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 12:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="757249405"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="757249405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 12:57:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 12:57:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 12:57:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 12:57:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 12:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8LUAFucuSdhLERFXv9BomsQYTD32wNd3kDfJRDaEVEeBCf5A9TI9opP492LhLRDWh/o27OJzaeQVMsmfqtu5Pn1PL2+hmEd+hTRimNDTGZfoVg5xR8gksxmeYR/D3Qh4MSIa9JGLeknP6HU5ddsc+RwQZMBfsSEK+SmR39YZZ2kB8RO1kj9pEiT1H2xnevDC0tVvTIiqopF3qI2Yw0g3s7YhMQqa5HiZHbWqvg61wJeyLTYtUVrcXUrV4tNe65nx1/zjeBlwerxflINeazYJw+kZ8oup4utwpO6Keg24IdwC8lbBeiWWFcG0RvFLYQZSXIYZv6PLwZZxQ6dPBRJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlIvpNtNDdl4Qv0G98rPV9yKFUEz1l5T5A7ZdnSFLDs=;
 b=SMtGdkRZySDgXeZTbLjdUizhGvniAQdPtb0MJhz77IyUVfBRt76APjV7D2fhBAxTtO3KUfoojKiTR0jJon8m9rDR7V+4MCbdPjbMOJfhJVd4+ZLe/WsA0nzwLL1YmzHQc0iwlZlHja/znDvNnwYBvH7tD1huymqaS36LsRPOD80/SoZuxOqVw87auZWNh3NWSSAa+B5bg37Q8KsLhGxowB+uy0DRLUeFOxyY4judP+5FQ+lZNqbXd3CP5Jk1vRSx8uQm0+aSjeGA0vvjBFU9AMd2uCZOF9RTW/GEqIJukEMOPq/jXI/aWBjbUKakZga7MsG5hP4u3jU+kI4yS2HVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 10 Oct
 2023 19:57:52 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 19:57:51 +0000
Message-ID: <f78c8cde-cddc-4ddb-8792-281444b2dce0@intel.com>
Date: Tue, 10 Oct 2023 12:57:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 04/10] netdev-genl: Add netlink framework
 functions for queue
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <sridhar.samudrala@intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
 <169516245672.7377.15243846195860899954.stgit@anambiarhost.jf.intel.com>
 <3b763763b779f95dc478c0b9177c60a97c1881b1.camel@redhat.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <3b763763b779f95dc478c0b9177c60a97c1881b1.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22)
 To IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|PH7PR11MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d58ca1-2ca7-47d7-a5a7-08dbc9cb2e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfbmMAOTNeHqAkKiINFJG8Sn2M2q3FF+7mePr17X2QZH0aU1SLPzyKJLP6nWX3+gVm4qHw79h+KgRrDNEnIgyVhxy8Wa6iAbR5jaOLaJXfTziHq3VjOMAd4/dIZCGgG+dQ/jWNmI7qlC/QkX1d57JGOkcRSJO4Wfx3q6K1+k+FxNavTpPu4q0YwJ/KLbpH3ndcrPF3+AErsCQQ2oLnVajFbiYkBNXNHjo4dq/L/JEA7LidRl+EyUoS7HK9++5NOL6eJgDFDZjT5tBmzw+OhVbhTm6ajqa4b3qH9w3hhcdawREAe9IW1V7i6h/LfKJR/EiJMBWJE9qp7hcDzomu2Ed27wq23wCRbN4l4z6vitG12ACTWPVHFjv7pZXzRgB8tWrfWVqWZB5Dud+WIad4Vyvl99hgS+IAfC5zFjKgq2+JZQiVdF1kBBH8Sy5UYtGLj7rtmykVsF3wS4RxyKx/uJ/vQXXBG51lQEGannpcxQ8wv5PP0yRbsaotPFdWNIFPC+y1n3JhRVnudiQuvFng8FRmEKEUsfHaHOKK1tqk403fKCnIS7Zh8R8FocCJ1U+WsNS9UL1KbWKdaYL+qSjbVxX1EN8APfrhJq9vcGnlzv0id3E/U0pekR3XTWR13rrqUQv27uW8UA0ZvOl2yIhLNCTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(66556008)(2616005)(66476007)(316002)(26005)(107886003)(478600001)(66946007)(31696002)(86362001)(6512007)(41300700001)(38100700002)(5660300002)(8936002)(6506007)(6666004)(53546011)(82960400001)(8676002)(4326008)(36756003)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEtKUmNlb0tnOGZMb054NGVIZ3hvcUJFcTFQVytlV0hiS2MySlUySGlGcWlk?=
 =?utf-8?B?eXBkOWFrNjBNQmswUkpqRUFYU0dPNTFQVWZQanZoTEYxdjFHT25rUmN2UllF?=
 =?utf-8?B?UC9PNjRGd0xRSE44UHRTNTI3WHNneFFYejl4MXNhWmt1R0JvY2dzeEUvSnlx?=
 =?utf-8?B?aVNpYy9LNVFOY2krSGxMaWZvRUMwVGlZRDI2enAxVXdYK1o1ckFoMUljK3RD?=
 =?utf-8?B?dXNFazIzVEh1K1AvYkRKUjh2Y3p4d3A0bE1lTFUwY2I1Zk9QR2ZWM29OZ1dp?=
 =?utf-8?B?bkMvMkg2aC8vMHlEMVluOFh1d1lBaXUxSmtvR2VMOXVKQmdsOU13QUM0L0lT?=
 =?utf-8?B?a2loTGJLTTlQNUdIOHJ6ZDY1dDRzOWgyOHBIN0YwZWFGeG1nNHI0Y01sR2s1?=
 =?utf-8?B?UzZyRlExQS8rQlpQanhwUHRKZEtmN3dOZldDcVlqQmJIdndyMTY1blN1K2ZP?=
 =?utf-8?B?emM1aDVJZm55MlJUbktqM0pramExY28zTUc4T05JQ0VNN1dTYXhjcG93aytT?=
 =?utf-8?B?NDdhNDNacGMwZ2NiN1E0Y0h4aFVzS05ORjUzVmVPazJLbE9qUE0rZlN1ZWZU?=
 =?utf-8?B?bHBPTUdjdENYb25pV0x6VVVIbkdJOVdXaVRxZ3g1R1gyelpKU290bHJKM3Ju?=
 =?utf-8?B?b1dlcmxUMzZxSHd3cHlCWFhQUDZRNUtBVmc3VDdlZlFTR0xJRGpjNlBwa3Zt?=
 =?utf-8?B?d09TamZ2MFBVY2pEU1E3WSt1aGxWN2VWSjU4cjFhenN4Qno4d1ppNDRUeThH?=
 =?utf-8?B?bkxGaWpRakFUWjN3RTBhNEUySXlZMzc5ekxaZXFwZ3htMWFMOXhNYUxTWVVY?=
 =?utf-8?B?ZjJwWFBvcnVEa2c3WHUveGROVTRUUHowbGtGZlhwUEQ1dDluOEs1Q3UyV2FB?=
 =?utf-8?B?MTlXWWFZY3UvSUp2VVRVV3FmMm5uWWNVSmx4Rk9MV0MvdlZ4QXgzbUlvRmE0?=
 =?utf-8?B?Z3ZFYlBNWjcxb2VzTlp0dGxJbVVzK0praU9EdE9NZzJEYjgxejBDanlxOUc2?=
 =?utf-8?B?cHRYb1BFNXNTZXAzaWZ3WitTR0x0NWJkbStpMG5jaXorMTJ0WnRYYjB4RFkv?=
 =?utf-8?B?ZW56N0ZaM2JnNGVUWktGTHlDb2pSdE92Ny9NaXJpWjV1ZHNMbDRSZkFYekpx?=
 =?utf-8?B?ZXZYZkUvdzBWTmRIT1ZYVmxrOEhCR08xbEYzeUxOaW1uMTRRTVFQRXgwbmZF?=
 =?utf-8?B?Q3FrTXExZFJ2QzJwNjlrSkh4UWxDL0loRHBtSWNaWGxxUE0yM0NhZ0lYNUFZ?=
 =?utf-8?B?TnJhb2Z5L3VvUjBic2hXaGErTlpJVU4wc0cxMUFRSTJRaWhjT3BVdThwdUFn?=
 =?utf-8?B?aHMydStVajZ1SmhpQ0Jrb0RocTFRZG5BeE9hQ0RsN1UzYU1QejNDSXN6MkIx?=
 =?utf-8?B?VVA2eGRneXMrQjd5ekNnOFowQ2xzU2NiTkpBN2VlL2N1N21CMzVRekdpbmFt?=
 =?utf-8?B?RzlubTdPeFNSUnFlWHRGcEJwZ2sxMFAvWWFobDFGVlZqS1lTc0NFcEVQYmkz?=
 =?utf-8?B?d3pKeDJubHM5aXZrRHdJZHE5WFBqMFoxRFVSYUEyM2QwWjJNUTErYzJpU2xU?=
 =?utf-8?B?K2NMcWs1WnhvYmg4YVRsczRBQzRITTlpVEtNbGJPSko4dEc1YUdtTHUzK0V5?=
 =?utf-8?B?S1ZMckw2N2trVzVGK3NSeVBmWHdGSlNsb1RJMGV2eUV3eGNIUzRYYTV5M29F?=
 =?utf-8?B?VUFBbWZPajAvSG5lZlFaSnNOaE1FRU4rRkxWNHhWdFU3QVhtN1ZlUlFXYWJB?=
 =?utf-8?B?R0IxeERpM0hJOXZFRDVpZjAzNkw2TnRRM2hCdmxNSnNZblQ3TjZGcFpsaDhE?=
 =?utf-8?B?cnozZnVNVGQycDVKVzF4bmFBVkYzS21wSjErVkdJeUMrY0dlVXpQRXM1US81?=
 =?utf-8?B?bzJMVkovV0hJWXpBbGY2VkxzNmJheC9VaS9NRlROSEJVMTQ2M3FObDhlcDh2?=
 =?utf-8?B?UXhzZ3lXc1R3bFk2L0hnZzZPSm5GNjdQcjJOcXFZUWtiRStic2JMWkNlMy9L?=
 =?utf-8?B?SmlTbDUzOUZBeXIwZjJ0NW9VN0ZtM2hIQVllWVc2L290Y3VQSGtWb3VmWThN?=
 =?utf-8?B?R0h3R29ScForYzNCOWpsQmlkYXVyUURHcVk4UkRyRzBzNFRtM3BFV0huT1hk?=
 =?utf-8?B?NlNndTRpblB5SDZZL0o3RmxBZWd2Y29lTlc1bkVRSUIrSENkWElibE5XSHZw?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d58ca1-2ca7-47d7-a5a7-08dbc9cb2e60
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 19:57:50.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+hFBCtuavhwtB4LgsBT7iLERpF1o68xKxldeLBSMuHWWcsM6lnU74QnLe/KkvWmZMofcjy+O6OJAQjr3+5VB//ZdUaXjg5qsUv3A6lWPEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 2:08 AM, Paolo Abeni wrote:
> On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for
>> exposing queue information.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   net/core/netdev-genl.c |  207 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 204 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> index 336c608e6a6b..ceb7d1722f7c 100644
>> --- a/net/core/netdev-genl.c
>> +++ b/net/core/netdev-genl.c
> [...]
>>   int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>> +	const struct genl_info *info = genl_info_dump(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	unsigned int rxq_idx = ctx->rxq_idx;
>> +	unsigned int txq_idx = ctx->txq_idx;
>> +	struct net_device *netdev;
>> +	u32 ifindex = 0;
>> +	int err = 0;
>> +
>> +	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
>> +		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
>> +
>> +	rtnl_lock();
>> +	if (ifindex) {
>> +		netdev = __dev_get_by_index(net, ifindex);
>> +		if (netdev)
>> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
>> +						       &rxq_idx, &txq_idx);
>> +		else
>> +			err = -ENODEV;
>> +	} else {
>> +		for_each_netdev_dump(net, netdev, ctx->ifindex) {
>> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
>> +						       &rxq_idx, &txq_idx);
>> +
>> +			if (err < 0)
>> +				break;
>> +			if (!err) {
>> +				rxq_idx = 0;
>> +				txq_idx = 0;
> 
> AFAICS, above 'err' can be either < 0 or == 0. The second test: '!err'
> should be unneeded and is a bit confusing.

Sure, will fix and submit v5. Just checking, this comment is on v3 
series, I had submitted a v4 addressing your previous comments.

> 
> Cheers,
> 
> Paolo
> 

