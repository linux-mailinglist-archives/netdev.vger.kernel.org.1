Return-Path: <netdev+bounces-30162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02878641A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3CA1C20C1F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA822200D6;
	Wed, 23 Aug 2023 23:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FBA1F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:49:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435F10CA
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692834566; x=1724370566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4n+2MurP46s60kEF5Qp/glhw8pQ1/lf9oschEzKcqdA=;
  b=Jh9hRflgrSsIEK2VU8YCHpxdSbN2fQrGQyj8QMp6o4v5oBqZT/Adnn/s
   x1yEG5GguY3jBpHjKvW5bTbPrYA/KdouJLp5Oj4T1iEdAavhiERqBbddJ
   EQ9omzoijihGEn3cIiskkf0HlTb32hC7F1T5Ku/KbjiKibBHKu0zLf4cr
   /70MRR2rH4gCpzPPCIdUNpPf3wLKzv3/kJT6HG0adYahUM8EFskQbJOMJ
   yJ5WZ+Ukq+0WMVz/nKFB0lfwyh2HfWkti1Cnd+CyfiIhyZCGHgxR029XL
   MtsRbDntzEcVnyim7rngTdj49rZwETEk+HByHSVuJBRKLgzrGPM12rl/H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440652413"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440652413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910703138"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="910703138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2023 16:49:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 16:49:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qza+6I+TdYfiGNdJ0BIQrzMsZrRq9jLSVZGyBbJkitA4E5qZUF1FGBx/8BpU9uD+KkxIhhYaU3wG3fRyncgmDxCiRebaVcjTpvunDJYp+xrTmDKLwyOkjwYYqjaoQJ6bN9d1y/CoDbFMUlLtgpUfCQGi23Qjsde3lQLDga6BUIJIACXcXR+u5z6lv7oDU5f22MHz6IUBn/ajyQ8h8L9ikgQp3x599KgPM6LH9ta959cYWbIine1bBsqlcX2bjU4RJRm2bWGIcApfDLdsdEgJUbcNxcHFp8T9DhiJ+pqElZY0q0bYPhfRqshpcXrG+sZ2eg8x41eT1mVCXDHHPua0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32MBnlw/UrtWIAXH5bYIeWwLzw1a4xzKJjCiYGM/n/w=;
 b=fv3kw+OaRuFWJKic+W7mDTLrubpW0BI0ki0WJQ8C/19Ho9s4vQz8hT8uJV/MHPzZf+5CIIluXlupWRKCxrzn5Klry89Jzx8PqcUniESb4QoowZ93xVDOdcWseYwH4h/FnIq0YeMk53TGPAM7KtWU79uNt8kucMSAAZXGHIOLhRm4EBLM0cVXz3DKjTbQejDuc5j80nPgMnvnGGg4VAtJf9l2Xm9U2Rk3Yp4ZzTQte2d1plICwgDHH3LO0zDzpn0u0LIOo5O6UgWANYJd8gFvhrrtzDd/fpx+E11f4gidZVtdexz8sHYDV9r18ivromcKYxYNl4sk/rY8Dr0NRCh/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 23:49:22 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:49:22 +0000
Message-ID: <35f733b5-577e-4529-b63b-30dc1d6568e5@intel.com>
Date: Wed, 23 Aug 2023 16:49:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 0/9] Introduce NAPI queues support
To: David Laight <David.Laight@ACULAB.COM>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <22603595289e4e86b6d61f0146b2e25d@AcuMS.aculab.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <22603595289e4e86b6d61f0146b2e25d@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: d65147fb-b154-4bb7-dc59-08dba4339308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKaYBXZz4WFfs57PsjM9J3jNX9bd4wVjCAxwtmblOLDabXLoz4trVBC2mfYVIWa8VkujPx/SfdwBPhSm0dTE1WwZSwJA5ugjMT+xYkDHeabDg2X9N7rFAB/aZ3/VEP1abN7dkHV4zRucnEnMRb9zr3jgdV4ACzOTlUB8o3wXLEHz1sUC9FlA7QZawg7nQxJXM0Wb0cJYZSfNalEA8THQLbtCwxi4fUJnrXlmYCj+CvnFMik/m2CQE+4a8aHopXF0xClwFw3r9ybmxcz1BcnsWvmumVjhj74FT5jS/03Htz2mLdGkY9v7+bigfZOBeKaMZzRS9xE7k0ZBi+jxe6mbxy3nACRbFg+QCscrJmYQlHBu1f1Mht+P77DDUMCHN4g9kitb3jipCe5HJQjyaNOTNuWgVyAEQ8xZI+wJvNwtPCozldHNbMh6knvhhOGHzBl8tuxidF2/Xfz9oj3RUHPz5SBv0rp8WRcPyFOTfm/m7D22Q23G9PVmbs2J9NK3T6WQTPWtuiI/cZJG1CzVRmz2lQLZSLQqOQjz+PSnmxOKGe/DYkAttvTiO2omILLVxfcQHsDaU3KkmtvJozI3/CATENSyMuldaK46Hic/G/rBXXT7jUF6pnQzZVtbGWutVARx7XgfNmkddwzCoN2cJwJYSVmdfcrB+7StGvNjtiUxPHuBUltnyQBzAoe/rdTcBVL8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(110136005)(8676002)(8936002)(107886003)(2616005)(966005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(53546011)(6486002)(83380400001)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akw4VjlUQzFhVStHYXR5aS83V25rQnoxSERyZW05cFNQMTlnWFhBdzhEZFAr?=
 =?utf-8?B?T1MxUDh1Ynh5SVdOMVVDUnRPOHZlVGlhTUJDVC9yS013YnpocmpTb0MzNEE0?=
 =?utf-8?B?OGlmeVlnd041TmtoM2dQdklrOGRwM3VhL2V3ZDQzdWhtWGpyWVlSMG1xSWN3?=
 =?utf-8?B?RFY3NmZTeVBYbkdyZ3J2SzlOOGg2d2UrQzZYVVNyQWk2Lzg4Y1NROFlJR2dM?=
 =?utf-8?B?RisyYVRYM3ZWUDd3UGtOcVZMeTN5a2F1VGphQmdYUTVkT1lKcHdTenpEWE0y?=
 =?utf-8?B?THlhbHBZTm1jM3RWbWp1V1p3SWZncHRRWkJscGFEZ2dCc0NlUE5rYlhSdTJV?=
 =?utf-8?B?bEp0M0FPNVRyVFA3S0I1ZGpnUnVDZlZYNUV1dzRzVk1CMkcvZDZ1TDVScG5L?=
 =?utf-8?B?Q1Q0NkRROStGdlJrUWE4OGZRKzMxd1RaK0UrR3M1RzdOMHUzK1JKUTRrK2VJ?=
 =?utf-8?B?QmFvMENIQ0tETTlqNVlHa1hVM0x6U3AzNUd0ZlpKdGZWMUhEaytBQnhYMk5q?=
 =?utf-8?B?SU5paklHWjQ0ek9lYUhsN2k5b1A4L05uRnczUURjZlRXVjBKK1gzaUJyTEp4?=
 =?utf-8?B?M2pnS3UvTTQ0WHRaU3h2M3hUeG1PdmlaNkRYZmpTK0lEZDNSSFVnZ3FnblpE?=
 =?utf-8?B?UnU5MXhYQ0NDZzB1cC9hbXc2VzNDcDczQ1QvT3JIN2xIaE5Gb1J4dmNRYVJG?=
 =?utf-8?B?bUJ6Uit1Ym9hVThraHJQS2ZmNkgzeXpUeXJSQk9KbWNtSGNNbElMVHlWYlVV?=
 =?utf-8?B?eTRZanJiZzZIMDhWS3NDTHNhcmdpOHhjNWJKS2thUUtUSnYwTXh4MTZTT1Iw?=
 =?utf-8?B?UVYwWDFoT09IOHlZcGk2Q2hsQzhoT3hRODNPYzF4Z3hzeVAzdXhYQWtpUVEw?=
 =?utf-8?B?TUJ6N1pxVjBNejRVemVhRkFoY0ZYS2tEdzZhSFQvMkloTy9KbmlXTHM5amlz?=
 =?utf-8?B?eXNnNTNQN05FN3dXNjNka0VRR1ZaRXFWa0dCZGxHelRhL3B5eS9YN0Rmdzgx?=
 =?utf-8?B?Z3N3Z2VHZk5FampQTTVrV1NIaVYydnlKditRTXZhZ2M5QW0vQjhRSzRPcmtt?=
 =?utf-8?B?TE1wdWFVZUtyL0tXWTRVSmQwWE9aM1VxNWg0QlJwQ0dYYmV4TUtJLzVHd0tI?=
 =?utf-8?B?VUJtWjErTVZjeHNYd1loV2JBQzlnZFdHN1lXdE5KV0hmdlFnZVRmeEFDYnR0?=
 =?utf-8?B?NnVZM2w4akxoWVFyU3hVRU1sYXVjMGtjeXRkcW5laitJL2EyVFhaMW00dFE1?=
 =?utf-8?B?ejdwbkVkZlo0TkY4VnF3OTh3Ky9kRVV3TkhQcXJlTTF5K21QN0dFZTlUN05E?=
 =?utf-8?B?UlllWTRmVHdJcisyOUkrRnJJbFQ4V1pKT0MvL0hMTmo2eHFrU0g4V01IRTBJ?=
 =?utf-8?B?dmMrblpWRlJTeWVZeVlhY1oxTTNSZUVUcXhrZ2ZZaU9ETWJFZlFxN1haWHY4?=
 =?utf-8?B?VTV5S3pwUzc1YXYzRzJ6TU1jTjVZNmZZbFlyZ0kyN3huY2VlaVVKUGwzWFRS?=
 =?utf-8?B?N0d6THJwTVNqQ2F5NGlIQ3V6bk9hR1FiSlgwTHFGMUh3OWlZZ2tsWkZuVWxr?=
 =?utf-8?B?VklJVXl6dkFmdklGRDNjOE9DaS9CclNPd3VLc0xuTHJyL2NrMVk3ZXRYeHhz?=
 =?utf-8?B?SXV3SXZZM01EcG10b3p2K1ZRcjN3c3Jzc0NId1BhVFBaaldCUWxQMWhaT3lH?=
 =?utf-8?B?ZW5hU0ZTSkZ6Ym1UQ2IzN3NkdDNJSElIUFZBSVIvMCttSCtGSVVpemUvM2tU?=
 =?utf-8?B?dHlMYXRpZmJsQjd1RCtBMWlnTzQydVBlQVJiejMvb1Niek56YTJnNmlwUVRl?=
 =?utf-8?B?SW43ME9mR2tWNGxHRVdpRDdMY1JLanRBbDhBdHdHZHZpdHFVTXVSNCt2elFW?=
 =?utf-8?B?R3JKb1JWanJ6ZGE0Wml6V1JNckJ0YlpKYk04cTA4K2Jhc2N0cUxtd2wxck5q?=
 =?utf-8?B?dzFSRFdodTFWTGRqdm16cm5zT2N0czU5ZW9EUE5YaUtqZWxjcGMvM0lnbFI5?=
 =?utf-8?B?M3J0Y1Faa0hzU1Rvdno2d0hsMVJTZ0tQNnhoNDhZQ3ZKMG1taTFwWko4NWV3?=
 =?utf-8?B?S0J0Uk9hZHhnLzFZYkFJQ3o4WUF0cUNVMDVVdlpGUlJidGl5ZGZOYUFzODFm?=
 =?utf-8?B?SFVacVpoWmE3dGMzNmlrVWt6a3paK084dTQrbTFmMlliN1JqRUJoR1IxaldB?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d65147fb-b154-4bb7-dc59-08dba4339308
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:49:22.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpYScvSWtpy9wDC+AqFwOdc7ddU/Q3pOctp9GYvQ2/AeKF4EGsaXRG7NBF5S+nPXYvUPIx7K5WzVUnfy2peGQwwycUBaUBt0xwRSI8c5y44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/2023 3:24 AM, David Laight wrote:
> From: Amritha Nambiar
>> Sent: Tuesday, August 22, 2023 12:25 AM
>>
>> Introduce support for associating NAPI instances with
>> corresponding RX and TX queue set. Add the capability
>> to export NAPI information supported by the device.
>> Extend the netdev_genl generic netlink family for netdev
>> with NAPI data. The NAPI fields exposed are:
>> - NAPI id
>> - NAPI device ifindex
>> - queue/queue-set (both RX and TX) associated with each
>>    NAPI instance
>> - Interrupt number associated with the NAPI instance
>> - PID for the NAPI thread
>>
>> This series only supports 'get' ability for retrieving
>> certain NAPI attributes. The 'set' ability for setting
>> queue[s] associated with a NAPI instance via netdev-genl
>> will be submitted as a separate patch series.
>>
>> Previous discussion at:
>> https://lore.kernel.org/netdev/c8476530638a5f4381d64db0e024ed49c2db3b02.camel@gmail.com/T/#m00999652a8
>> b4731fbdb7bf698d2e3666c65a60e7
> 
> Not of this answers: what is it for?

The use-case is to limit the number of napi instances for the queues
within a queue-group. Other discussions at 
https://lore.kernel.org/netdev/20230524111259.1323415-2-bigeasy@linutronix.de/ 
also explains the need.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

