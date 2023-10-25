Return-Path: <netdev+bounces-44076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6AE7D5FF5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81521281C2A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD031FB7;
	Wed, 25 Oct 2023 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtK9m5E/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AEE1C14
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:29:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294B9C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698200947; x=1729736947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GfwURIx6zFBw4ziNR1AQ+t5V5vLSZC1Ztchko0G3G1E=;
  b=CtK9m5E/Pdfk0K+HJq6AhPf0jjHBJIYfSIcMz5OhU5FpyiHL56KeUT4d
   KAUPdct5IJWxspBrBK3/GrYzPga5kdtUOi8Ar20LzJoXpH1q4jSLVbNhB
   TJNn92OidbbMvrbZHIaM0cTquvXJM+OcKQaxiY3UnVV0WEXZz6HJq6UZC
   NcGpm/O03DmzdOytmLLrlSASM2BiKMX0+TUCvK4r6wkY+odZYSeSg6yhk
   sLzeo8yNi+lGyD6rFSnUZb+Kik4dSI1FEJ+jTEPyYHi3mUa5giaq4gGZ+
   9iiPfw38QmTK1WyNEly+YbkR69GO8qFvw4T4bGWGh27nKjaaWxiTo8nPv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="8777655"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="8777655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005846769"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="1005846769"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:29:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:29:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:29:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:29:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:29:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6ntKujWM40JaU8lZjebBn/kuoMh9Kv4Msblof5ewF2YtAzCQLCDxf8oEJEp7c5ey81aXRb4VjVemtmOoN7QNE2YQ8ohm2Luf1AKmcGgo9uKQVhB45FKNQX1rqPFSi4qGtH7YaHo+lAkUjvAmAQMwxxU8Pe7sAQz3x2JrZa+AhX0nAu/NaG0Yw2QyrSl7XaAMSWq1qiAGzv1YaxC+w0EgdA6X4lqXT9shXgYO/phPTsEDXynelA3Z+8kboQ0hlCT7kxwe7+PODjoK6GH+SUC3Wi6hZ8bFwIF+qw1TmFI8gN3XdFmrMkb9kFRfnOz4sFtfrHQH+jj8y2D2LeZIAK08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTSsox+1LKkF9JHPloPzd6gCtv6M5ILh+arNojnxvsI=;
 b=C8Na+U4amoHYQR3ZpJblwjuzyQivqQmd/dfmc+P2R0378UQ2URmxXkiRp2dDz9BfdpUBvv99RNGDLkDSh8IpyIL6q0GwmMME7ofgjc7lz2+FC1gxZznFokl5b8weA+C9+aCZhrLlhZlVF6DARkK0CtoE7TqLCYD4SUpZv99Ksp/si/T2/L7SmZ9vibYWtalu5BZLXqe1y4Q/TE7QZGLi1NTCtgaohnbILWVAirk2/TwR/9dq0ns0nojVCT99qgB4EkyIbJC7e3j2ixK+TPTcpCgB5apkOBDayRVN6nHVK3OxXXaiKyuC+77n3s464k/78ElmUahpMV87f74iga5YLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 02:29:04 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:29:03 +0000
Message-ID: <eff8b9ea-0774-4f31-b5b4-34067deff394@intel.com>
Date: Tue, 24 Oct 2023 19:29:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 08/10] net: Add NAPI IRQ support
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <sridhar.samudrala@intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811124126.59034.7955140077923696489.stgit@anambiarhost.jf.intel.com>
 <83a69666-31d2-43c3-8612-2884f4570ff7@gmail.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <83a69666-31d2-43c3-8612-2884f4570ff7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 783502fe-9fc2-4b61-ce50-08dbd50227ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /70L4/O0xXxwnpmrzGZ60+IbMXrk0zM4jIlHkF2Hui57oGHpC8lpCYGFLmWDkUnj6yao5DORf/4BG9xES2kXIfcUUgo7cWvzz2+MX6wJJAkuHob6nshBWSh9UDw9OU1dDgQDjLZuux0pYEAweXD3sYLmp/KMxn/2HgkUhIkdZSwbAqRd3kUXeymdbwn3r+0G9br1RjQNjOEYtioODvysL9xd+7a7kJng9TXdmHDzak2tJiyqzIZgNi7/gRPSSbUGZvW5gmU3HNYYl/NHXXZAtUl6RmOZG09NwM5+rUoTG9iKo50sepzq59xcWmDLeYYPxGq0ukN8A6d/yoXz5V0XdBCQb76I8FcFg9yaW0KppggMBtspwpS/xkWZh/78//TZ3LjSFTso5zE4KKrDmfvZp3rRjToG44CooM6n2XhSHG2t6GQas0gZ02PNBw/cweLywc7ufZ9XWTfd3prgzOulWp9INOapQetK+RvNxmErOnSFL8f+HSxGwoM6QbMdHBUyYxqAvpfiI0qIO6I/kyzJhdOkGqCAu32/p7kAA5qB0TrtAxwBV2Ua8uIh8ZoDo4MCNFJXqTotzT+fvekBSZHyPyW4mcAIalUEBlD5y6Khp7pIQBFp/hc+2nfXdLso7WerIgLWRsIPYAZXgwU19K8B0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(5660300002)(86362001)(41300700001)(66556008)(66476007)(478600001)(316002)(6506007)(31696002)(6486002)(6512007)(66946007)(36756003)(8936002)(4326008)(2906002)(2616005)(53546011)(38100700002)(107886003)(8676002)(26005)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWN3VERxRFFyMnJXNU1KWkNIOWx3UkpjUEJBRTZ3MnpPcm95UzN1MWdESFRy?=
 =?utf-8?B?Nm1pVjVGeFRWS04wZEpJcll6U2JhTGJad3FjbW9oNHBEU010L3BsS1VYRjEw?=
 =?utf-8?B?bENYYmczRk40V0k2T2NhWSt5K0Jqbis0S2lVZHNCUlp5M054a2t1UG02Ni9I?=
 =?utf-8?B?L1BRdVVGZm5xVC9OdmlVeDUvbExaZHp1VExZdHlneHQ3b0pPOG5Wb1E2R1VT?=
 =?utf-8?B?L3orNkRSR1R4SUgwT1pmWFBGa01DZXRNRzc5TGVqT2FycDNSclg3SWZvRnZ5?=
 =?utf-8?B?OS9KTkpIU1pvVGh2cmRvNGErMllmZUF6SEVNVE1LbVIvR0hHYk00R3JtNXdT?=
 =?utf-8?B?bC94MjNtd3p6S040SnlkVkxzaTVtMWI0WUhSNW8wNHZZMnVib2RRVGF1a0xD?=
 =?utf-8?B?OEhrazArbnJFdnIxUUd3WVNpeDBBWkpZR0ZlVEVkdDJkUVNhMmlBR3JOVzI2?=
 =?utf-8?B?RDFlZG9ldTFPYkVUdUhiN0lTOXFYemw0ZE1wN0wreDBXRkRQM0plVFpydlRS?=
 =?utf-8?B?YU4wQWtRZUkrU3RLYWk4cG5VSHhxMlFkSG9IL3B2akNnblZUTFRGRHRWYVl2?=
 =?utf-8?B?K2h4YjdmWi94aWhlMlFvbkQ0ZmV6azBDRk1INytkYWZuR1NHQlg2MzBWaHUv?=
 =?utf-8?B?SWs3cDRLdDNGYUdXZ0JLbWJpRkYvQ1NGdjhtUGJxV3B1MEEwSnZTV3Ava1pF?=
 =?utf-8?B?R3Zqek1zRnQzdGFKbW5ya1ZUZndvRXpXYkMrMUIrcC9aU29xZGJrMXB1ZkdX?=
 =?utf-8?B?eXgzS3R1bFpyWXJqemVWM0IrbmRaU2lUN3l2SmhzdmxxazF3NjEvdDlQT0xY?=
 =?utf-8?B?eHdlNms5ZzVtc2NQTEZlbVNzNXpUcW1ScENqa01PTVJuTTBOMW8rYjMvY3FQ?=
 =?utf-8?B?SnVKTk96bWlsR1pjaWJOamhFTWxTU0dRMUhOdHhHUUpUSTAwbmEvNTlnZTln?=
 =?utf-8?B?M3dYdjZ1RktFNVdCbHVSMEJHSmd2NzBSRTB1cEdHem90cmNzeDNNSVlBdDRn?=
 =?utf-8?B?VWZ1WUtLZUlkRFlVZGJQL1RCakN0Y0tOdjNiYUh0VE9Oai9WSlhjZUhvWlFx?=
 =?utf-8?B?SXdxVmZNTXRaSUNaRTNWNjIxdkVwL2tiY0psVEdOMzNBa05RYkZVVGZkN3I1?=
 =?utf-8?B?WUdzWWpTbWNrMVVYN0tET1ZadlY2RTMySU5TeGlYbzF3VFY3ZndjVUk1VEM0?=
 =?utf-8?B?RVVSRU9FUlJqNWdsdS9wSFFFT0hXN3RDbTdZZUJGaFZWNkVkNkZGMjB6NmVS?=
 =?utf-8?B?b0Rib1dTWnFyY2d6TXNOUDFOY0xUcThLazUwdTQzUWlTL3M3aUxLMjZIMVdY?=
 =?utf-8?B?bG5SWDZqcGFzMlBMVjZnbEpYNzFneUJ3b1BGRXY5MmFQRmhReW9aQi9yMGNz?=
 =?utf-8?B?T0JmWm1TRW5PeGs3emJXRHB5eXBDeHhNTzV6SWZycVBtYkxWd2IyblFlNFdn?=
 =?utf-8?B?S2pubnpJM2w1cis2T29LTFRVbjN4QzBOOGljNG96aXg3NUFzK3V2NnhyL0dj?=
 =?utf-8?B?ODdnOG5EME9VdjZhcFc0ZSsrSVkwMXRhM2JLdEVZbnJkOFp3b2xBa0dKMUE4?=
 =?utf-8?B?bGVEVnE0TnAzNVZJWCtYaDFENVlFWlpYM0cwUXlaTitRc1JwbnE2Q1dTNHZ0?=
 =?utf-8?B?RHlDU2UwNENLTGthNndUZ2pwbFhiQTZxcndPTU4yTVJaVGZPKytpN2xpU2Jl?=
 =?utf-8?B?UzBFZnJEOVlXN0J4SURuMElZb21hcDA2RDlZemxnRzJpZENhMEhhaEU5RmRO?=
 =?utf-8?B?VzdCemlOWStGaGQ1QTc3YlloTktVdkwrZEZidGRZZHNLNCtyU3Bzck9GUlFv?=
 =?utf-8?B?bDhNNmF2KytnR21Wc2dmMnlrMHR2dE82YVBOZzRuL0pIelFjampmUnFrNXY1?=
 =?utf-8?B?cjFweWhXN3BXKzEzRFJyVjBhbDJwK1hqTzhnM2pCVmpWbWxpQlEvN2F4TE5G?=
 =?utf-8?B?RUtNcHJDVU01a1UycFdYa3VjeVZaNkFMRTVzaE9mamRJZlgrOEJpSm55bEZw?=
 =?utf-8?B?b0g2RjZ6czE2MXo3TlBMMHlIUFhLdUdyRnZxYzF3WXV3dWpGV2p5d1YvNllm?=
 =?utf-8?B?WVJkN2JUMXNLM2ZwQlVGdS90UnA5aFVKWjc3bGVxM1ZpS05NVkZnTVIxc0ZW?=
 =?utf-8?B?QzNmQVdpc3NnU2tpM3pmNTNoWkVWaHBQSEw5YWRIK1lxQnpFQkh5QXEvcEpP?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 783502fe-9fc2-4b61-ce50-08dbd50227ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:29:03.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJebx+8jK6U4dMZ6LKH1o24rEPAX7wmBe63MnhQ1H1X/z5n9+Q68JeVTlhMgQBeCZnUM2Gju8qWu2a6M3iCMBkaLnrcgfkwr1PEl6tZ0oFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com

On 10/24/2023 4:29 PM, Florian Fainelli wrote:
> On 10/23/23 18:34, Amritha Nambiar wrote:
>> Add support to associate the interrupt vector number for a
>> NAPI instance.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
> [snip]
> 
>> +static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
>> +{
>> +    napi->irq = irq;
>> +}
>> +
>>   /* Default NAPI poll() weight
>>    * Device drivers are strongly advised to not use bigger value
>>    */
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index d02c7a0ce4bc..adf20fa02b93 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6507,6 +6507,7 @@ void netif_napi_add_weight(struct net_device 
>> *dev, struct napi_struct *napi,
>>        */
>>       if (dev->threaded && napi_kthread_create(napi))
>>           dev->threaded = 0;
>> +    napi->irq = -1;
> 
> Is there a reason you are not using netif_napi_set_irq() here?

Just overlooked this one. Sure, will use netif_napi_set_irq here in v7.



