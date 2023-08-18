Return-Path: <netdev+bounces-28912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3487781237
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB742824CA
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4031AA88;
	Fri, 18 Aug 2023 17:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCF19BD7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:41:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BE35BD;
	Fri, 18 Aug 2023 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380516; x=1723916516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNVHaJQ4Q1fbdUkjcmS3eWjBpbrUP5mm0VSvftJvK9w=;
  b=WKZSVjtEivg0mpXcq4EmXz1HPzv3bWpV/7kxMWXL70JEsmmHEL6YmYzZ
   vDnCPEdUKJsgGHmlc8n1r0k2Ts2/9Ia1I6pB13ddaa0sKzwVm7ZmJr80+
   l4gmWO6lq+1PAxhuxwwatkenCvMjLyE+upSK6Lk8BbyXlGta6dU/GqF8A
   Zpnm5QWcsKa9TXXWJqm/2ronE5dtZOojC6zUI4EkwIrIcJNySyfTte13f
   nrQkj0mzM8WU+cNmLY1FIkkxvJp0KUs798kNmkuYMbJnWOUGyecZ61A/n
   QR3zGS19+l7f5iIVWsFj8SE6YeMw/MOgdVgyqBE3YPs1AKgDtqFZbc38B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375935919"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375935919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="858770591"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="858770591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 18 Aug 2023 10:41:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 10:41:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 10:41:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 10:41:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 10:41:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flLdsPhS9kMMSTcmtNS2UhXJVw80TzEU9jR97pE8qGXu5MU6oQDArsol4bCRw8gScxbqA88nY5dwEcLTXBlfeosDIWvNCq25suvEOTttoMxJGNV2O7vgdxRhlL8MiOJl46r/8ii8sk3wtLSRmP1lKDe9XXNrZUdG06PBgQqd1dlivLX/vAd6hV/Uol1g1dZKCDOs7XjGmvsFk30ihNkSjrFFxbzzrqgeesOxY/6qtOD4Gprp2BzX14qwhl+04osREjqxL+fpBF/ntkCpDbrTHJgJUObQbjD0f3mpPjb8pYDleynvp0u1V7Cvm/SD06Rxvqe4sLQLBJhnc+MAUNwWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAgxwEkEzSSXRdLKkE/SebNoP3fD8iIRHbRGbgxVo2I=;
 b=YlPO/Jb4gP2ZvmUfRFmkgw+QpZHgZ4p1h3Y7JRwoAhA+Bqek7o7a3Qznl42tHkXicFQksISwPZkIAVMJWboM707zjbZQ1QLNpRbZL9dYMhILy6s9QY3S1vuX7+iBj4M61ijFge/V0Dthmq6wqIj2GBSr2rPTgfTeH/WkG61AsvgxV7w6kJtQCj3vhYrPMhZAqInq34pTFP1aaEHw8r2MdQT3IdoF+id9VmQYxwDv1lbB7MrnuxcIjU3/kGgz8jaqeUnEsjP6prF7xvFn7f0uyKxTmQZie/G/kDkGgBCO73PtZlv/Bhcqd7Q0EKpba2gvjCiJGGwMkZ3r0a5nbNShYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 17:41:51 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f%6]) with mapi id 15.20.6678.025; Fri, 18 Aug 2023
 17:41:51 +0000
Message-ID: <e40bd282-9d88-c182-f2ab-dce9bd3f5f7e@intel.com>
Date: Fri, 18 Aug 2023 10:41:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 15/15] idpf: configure SRIOV and add other
 ndo_ops
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	Alan Brady <alan.brady@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
	Phani Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-16-anthony.l.nguyen@intel.com>
 <20230817200239.7d2643dd@kernel.org>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230817200239.7d2643dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 87863878-e9da-435a-c9f9-08dba01267da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fepyHJt1JlHkopcjxu394k6MXxqsLporFcp4b7DBrUpMYCR27LA7ufdyC97lZvJcGJJJTw513Mi8DEwvQ9KjWcvvN6szxfq9q2OJ+tH9ZzpDgVsTd68BJYCdUOpAjqKyw3+UOuBGxyH/AuEOaJ6IEmb1iIXuLhmsSbsVwShG5ylhRqVg4Mmh/TkaWN6mOFEcMm7ojaAo+ZIEb4kb0WpvYUroeBSnbw8fkCsH78Cqz0FjeQTwd2zVMXjRc9FpJnjcKWTc/L6BGjtJGbGKRm3o7zilwmZYzqiCn7ijkNyPFA+CexGKy7Yaah28PTmc+WH6pnaHyBcbBUZo8ggcVpiiwq5GBx3UpmzaT2QHMAVJKWFPhrKHBXfsxuqKDav8cmDaEhcFhUsdKCpz8QgbhzDoqv+w/R1C1IBfxxy2ASztbHXbKd2ndheWhpd/oK9c9czubgtB0mRGkeswmrCLw7FNKRKobfo6o7ClqJh4LgavthVVfvbr+BhtUv7a0qJiqP30OPKy8JHXRmkn5UQ3Ch19Fc//3FXVYQSOCD6hdp3ycKTTJmbKv9y+ej1Niri5axsvYpRhziJZKqGb+NTpx8NqLo8nXGy7hXVzEi6OB1hB74UiF/xFjuIGi9XUlZZdN6HVi7oUh/f2fdidTsF/7OE6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(1800799009)(451199024)(186009)(5660300002)(83380400001)(66476007)(38100700002)(316002)(6636002)(54906003)(82960400001)(66556008)(478600001)(110136005)(7416002)(2906002)(4744005)(41300700001)(8936002)(8676002)(4326008)(53546011)(2616005)(6512007)(6506007)(6666004)(26005)(6486002)(107886003)(66946007)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpOaUpCM0ljaEJPNXc1bU5QZUsxNHFQQk1rRTJMWEFIcURTeWpnOGUvVWJY?=
 =?utf-8?B?anpSU0NwandJOHAxU3Z0REI2Q0RDUTEvMU1rNXk1L3ljdkZ0RVp6TDFFem9z?=
 =?utf-8?B?ZDB3MVJyK3FTcDBoOHk2anAzeDA4V00wb1I4S1FkNUM1VitabnpsL2x4SEN3?=
 =?utf-8?B?Q3pOMXkvZmVHOWZjK29FVVpiK2hsTXhYQkFqZHpOaWllT2Y5R2FzbW44d2gz?=
 =?utf-8?B?bXZKNkREUS9SdzkvSHppcEVjeFpnQlhFL1Z3WHFxeW85ZHNoQVQrdGhpRXpS?=
 =?utf-8?B?TW1JbEJIWS9laXRQazYxYy9TODI0dWRGNHJRRlhUWWdHa3ZhUmNpYzlqUjRx?=
 =?utf-8?B?bkhYVy9iOElDUEhZQkhPYjRmQ3lNVVc4Znd2M2RtR3RMWDJTcVcveWNwMzJs?=
 =?utf-8?B?R3hZNk5oSzNjU2ZxZWkxcGl5WWJGWUJBaFE4T25tR2M3NGJWQzVHU3BQc0pQ?=
 =?utf-8?B?WjY1dXhvVkc3UXZlM3JLR293aTIwQlFUTzJGOXRWYUR3SUk4Z3ppNUR3T2tS?=
 =?utf-8?B?WDlncHNCSXlBQUMxQVZCdTVBOGQyTmxmWnJWNWcrQUJCN0RTTVJXSEdjK3ZK?=
 =?utf-8?B?US9XbENlQmk1Nm5hNVpNTFdsUmdDSHJlc0d5NWZUQ3dENzJweElFeFZUWkJa?=
 =?utf-8?B?aGlvaDRuUkZkWUsraXJLTDNrZzcwamlDUVM3U0hXcnZkVjhDa1JrYnU0SStC?=
 =?utf-8?B?YXYvMlBDWnFWK01Gcm13a2ZLNzRCOTArSk54ZnZyZ2I3bHdxVG9SYkZZYXVQ?=
 =?utf-8?B?eWJNYlRjejV5NThZQlM3VnBRSVR4M0dUYXExTEk4Z0RDb1UxWnFsRWpZRmY5?=
 =?utf-8?B?a2htQkFqYmJxMjUrSzZYREJsNks1NlFzSFliRzJNb3B6VUdKVG1ERVViQUxV?=
 =?utf-8?B?dmlHUXVGMDl6Ni8vZlJyVVFYdHN3U0h3VHRHUzhRQnFSVHBUUll3NnZ6bU5y?=
 =?utf-8?B?NDcyODgvL0ZLc2l0MWxmNVNqaHpaVWlwc1Z1ck5MUnpYa2tIMVMvUVJrb1pm?=
 =?utf-8?B?dGxNaTJBSTdvT1cvTGJENU01d2dYQU5vWFB6OUVFejFFeVg4ME5PSTVqOENj?=
 =?utf-8?B?QmVPSms4T1lHdTlTcW4vU0NFS2VJa1NlYVBWUG5WOUoxWVpwanA2azd1emJj?=
 =?utf-8?B?YWhUZ0xtdWgxT1dXTkg1T0pMTytYdlhPNlRIOXFDeUM1SHBZVzRmbUQ0UVcz?=
 =?utf-8?B?Y20yYnZjOUx5STFSL0V3SGwzUXNaMytmQXhUaHNVU2ZMVThtaXlTTm94WW05?=
 =?utf-8?B?NDFPZExEZHZBbFkrU2pLaFBDbUg0Nk5QeGNCNSszZmhSVU1zc3J0Mzh4ZHpx?=
 =?utf-8?B?VUZGTjNDNHFlWUdab25xOXcxOWpxTzg4S2c3KzIyVENsQUx5bmRPQW1ERnJo?=
 =?utf-8?B?R2RBNTY0bHhUZ0RaOXdXclZlQVZ4cU9HR202dWFmb0JMWmxkbTN0M0tCekRn?=
 =?utf-8?B?RHVmNngxdktOSTJrOHhBcHZNRmVaVzFJNjRWbU1HTFk2cU5iZDJvNzBqcmc5?=
 =?utf-8?B?OGdxMHN5d2ZGRDVPQlRCa0FSZDJEbHMrbjZyNythSEh6a2l1blhEVTFyQnFG?=
 =?utf-8?B?Q3ZkcHlWWWs3RGdQK210YjZEalM5ZWJwRVhndUpWNHN3dUxKemo4aVNBVXpa?=
 =?utf-8?B?OWJuUjJLakRjTGNGUU9JWkMxUFQ4ZFdEYVB4R1dDQUwxMHdSb3FzbkFnazVu?=
 =?utf-8?B?NUZMaEEremJqZkZiUWNWQi9NSmNKc041alFMTS9QTTVRWVhIZzFRNGg0UDBZ?=
 =?utf-8?B?VFYwTTRPWFZNM2VWbjN5U29Cby9YZTNxdlVid3pxWG1QcGpSMWxweFowdU1O?=
 =?utf-8?B?RDh3amRzN3plenNVdHo3ZEkvUUQ2VmpYSVo1Um8zeTBCVmRFNklwQTlSTFB0?=
 =?utf-8?B?aFlja2ZFUncwSEc3WW4xRXdHRlBTckc3MWR5WGxmQTVDdnVzNDViZERTWjF5?=
 =?utf-8?B?c0h1UnFYRUdVVzNIaVdkN3AyaFFUUkFNalBhallhNXNRZUxpdngwY1hhNmRY?=
 =?utf-8?B?Vmc4U0J3M3JpYXFZeDd3WVhyMFlrQVJTVXpPellVWVlxR0VkS1pDRmFRQnVm?=
 =?utf-8?B?cHdlTmtHVGhnL0NuTmR6VVNIelA2dUdWbTFFNkRmVTJEcXcvQjR6bTdjcmVV?=
 =?utf-8?B?MWxOcmVGWXB1SGUwSzZ2bzg2MWxSNzVrcnc1c2REY01BLzhjUVJhZjhBQ0dq?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87863878-e9da-435a-c9f9-08dba01267da
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:41:51.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKtryUUuMJs8isAegPuJpDYbnyLMMRWJ2qTURqPadUx64FxdTTxkBhAdEhQKw75Qmib/L4gLXDYfMX+gokDGjA8qlRkWJz6g+vvZV29C5NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/2023 8:02 PM, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:43:05 -0700 Tony Nguyen wrote:
>> Add PCI callback to configure SRIOV and add the necessary support
>> to initialize the requested number of VFs by sending the virtchnl
>> message to the device Control Plane.
> 
> There is no API here to configure the SRIOV, please drop that from
> the next verison.
> 

Make sense. Will reword the commit message accordingly.

> Sorry I run out of day. My comments so far are pretty minor, feel
> free to post v6 without waiting the 24h, otherwise I'll take a look
> at 9-14 tomorrow.
> 
> Please add my Acked-by on patches 1-7, if you're posting v6.

