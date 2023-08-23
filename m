Return-Path: <netdev+bounces-30115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472777860C5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019AB281387
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B71FB36;
	Wed, 23 Aug 2023 19:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50E156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:39:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99D10D4;
	Wed, 23 Aug 2023 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819550; x=1724355550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ObHIPFSsTsPF5NCuyQ20jFQJrRCUlpqFF0uVj0oKwU=;
  b=id+c1qbuZAEvKIpR++dK9+BHIHwNr7OrbYNXVvVC07MPOJMlve+cHBSi
   2npmZHkJOGmAZ36iQnZzDdqwyxjDSMAu4gcvVkzEFLrS7MOFj5RpB3CLL
   4Vt9K/xBugLAaHp/dVxX27jPhmPj3kTXCdV43ekVUuEX8O+RSaeDx2Esq
   QuPfcdqWMMmPbis9tPgkj7g996vOFOHIkp816/d/eBMCu/jeqhnnDBQAc
   XyAk2nhUdghlX5i8tQiX04iYO5QcpAZb1fNoEHLApJ7Igg/Pw3eF3tpIc
   q3EG+uJWE+A8eEOF14lU0UH1jyW/GYF+Ek7t4Rp9j8j2SRlARqNPObAfU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364430844"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364430844"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="771834102"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771834102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 12:39:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:39:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:39:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZa8daD+QVsk6ZuJgZ/8OqbC4wZn7TsbZS+/Mu/lk1V4v2GOBdOT0RxMjKKjJK6NgRyUH7rB0emuUshLLuQ4HaUbAVtbcqBXEgXHiK591EjOJ3KOeALvWl7CJGIGywjABLsF06n0zxj+0qstlQ3Xn3v9QIxqU5qb2Q1dtQmn6ywHFp0HSBOhhwaSHozaM3tn1aklL/9f0JzVEpiwlOCCZEZsKyFqcgf3kd6PFAYNwp044yHqMiVGq0CWLJf6pI2/WsZwMM1gknXKT5k07lQYNr4IHsOjSOPgMwimmticTvtwuPS8BnHfGJzW8ny1yNSc36KN97ppOro0U4GFU5ONKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4N6HMAutDi0gIrhmkg+x8pszpF2znv4pcnNJimOJpU=;
 b=T2a6+0oKHXo+m6bCk/fNy7vPNkbDYDFRfkRJ+mJyWqeJpdqVl6DU7+t6L8scjChct8yBvUfgGKC/tgNR/NH5iolbefroUPi7ZNowovnpJaQL2SRol1GVU4uvv1oiDVtjvx9V+qA1TirqBHpDp1BN2ZDuvB3pgdOJy0SOAdDMbDFAGSPubPSmG1GB5jGEiIK98VueX1Px+QCPZmCYLMMNt8mQ4o0ojjp6TC+W5ELAQemLMSrY+qTbk3TmtWioKb8GdOPT7bopF+pLxD+FQ2lNnpSGqTyJjdShwTig5NJ4N8KpTPCUvpcVJYHCiCMG8V4bt+SYBHXIWpBOaD2QvfYCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 19:39:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:39:05 +0000
Message-ID: <d95b93d2-82a3-caeb-06cb-42e98a763d30@intel.com>
Date: Wed, 23 Aug 2023 12:39:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 09/12] tools/net/ynl: Add support for create
 flags
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-10-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-10-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f7002e-bf1b-4d2e-773f-08dba4109c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5bdDQuJuWIultFQMbenr27jnX+pnjF0QCdeOU1Y2WwUfGet10oBSHKqrsblsTKhgtzTcpK8MiH3V6UT3WjhMbza5SI6sbvuepJN7xW2KQKg39kGko1QuyYlyRwelATi/aqdqpnXhB6BJf3Kv79lPbOklIrPbqHtCLlpFaufUmlhX+7hmrZx/K1o+iIhLXeYia0zGqyhEulb437wfHpOXj12WQUA326R7smJlur4oK63OQtt8KN1O6TM/7ceTR81ZuTACFw34+I9O6hRxKmxedSLAV/cKrVOcDXny4IEPXlQ0T6lBvyiyHIaYEqPC7ngsSKUm4NkmzIZc7M4ymuz2Or8JBkaBIeMa/QOnpVpyi9SOv2RPHkA+JNaAddPDl2r2lswSmt+SUIDwfpbw7lNuLxqXquob1wT0mlCpawzHNPGQ+3Cq2LC3v91B9lcRXYweSC7X3x7VseX6SygrQ1vjgsDdZo+kDYzPQySgLRf4BjYJAFaZw811YXksEgHu269uBx7iadCVUuCLcfNj26p7kBqGmUk4t8Pdgxlcbm+XV3+8sc4juuAx92ckGV8Z1+rlMYTAhcrHWHxpVykcJh2eqcEnNOL/WnT4M7yHc8kkLditQKJ/vj632n6o43JPsDUBMGkHNvcH1RncuQ3lMwzmPBuDXMNpVPACVGs0YAuGZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(921005)(478600001)(38100700002)(6506007)(53546011)(6486002)(83380400001)(558084003)(7416002)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTltSnVqdVdTRmVTR0tBZWtLck9LbnlaZjhHS1FqdEppa1RRajJJajA2Wlpj?=
 =?utf-8?B?ZWxGTVJUbDVNK3o3WWw0TElJcW9HVU1jWHVld2pTR09DUi9QcXB6V1oraDJw?=
 =?utf-8?B?dkZjaEZSVWF2NWhCejVmamVCclhOcmNGMURmK0xldjZUblhVQkF0RkFpZEZP?=
 =?utf-8?B?NTdOanVwSEY1bm12bDNtYkd3QW9wOHhQaS9IcXMzVzl5Qjh2UVBLK0IzZU5N?=
 =?utf-8?B?OFcrdVhleUJ0MklZRkhiVVA0akUwR3lQWlFZb0MvWEZ3RFhqNXczWlRnRllG?=
 =?utf-8?B?REtNWHlobWFyRy96Skl5ZFU1cUJxOSt1TzZBamd1WDdhRkRIRGcvOTZsOThN?=
 =?utf-8?B?NjZST1IzakpMcXVJemRIa1NxY0JQWWdnQldVc2pLZGROUTZpVEk5Yk5zeTZ3?=
 =?utf-8?B?REtqSzJaTkdJV1NWQWNMdnN5N1lmQ2JuOFJRbkNtMURDbVppMXZ1ZUszdDg2?=
 =?utf-8?B?bU9SSnJ3d3ZYQUhxdXFRRjBaTWRQYXorVDlUM045WkczZUpCRUZGbXlhT0Z5?=
 =?utf-8?B?dkhBY1ZoVVpQUVY0aHpYVEFzNUNyVlAva241SUtieEY2TWRSOTJra3BTOHVB?=
 =?utf-8?B?bEVqSVl3T244VGp1T0xuYWVncjg0Vk4xL05QVnJqV3ptWTUrUVUyRE9KZ2pQ?=
 =?utf-8?B?TndRcHRoUUtPc1Z1bFEvZnh4akNUZHZHWkVvM3ppcFF3MTYxSithZVVCdG9n?=
 =?utf-8?B?RjVzNWlzZDNqQXJZU1NVa0lTSzJmQ0pMZHk4SGxZenY0NHM5SmNRTjRpSVJa?=
 =?utf-8?B?bmIvOG84V2JNQnlzVmVSTlNlTEhvbnRKTVlvOVBvWmpGMVBnOUFEcFhxcWpK?=
 =?utf-8?B?NTNxT1NVV211NHBzVlpianBsNWUxb2psQmV4amFyUGlXMkNLL3ZWT2hMYjhJ?=
 =?utf-8?B?RnVPTXV0TnBzWm1YcGpkclM0aU55bkJjdlhzbFBVQ05jR1YzR3RBdmwvalZx?=
 =?utf-8?B?eGlQcEVsVzFZVnNOQzU2ZDJKTDE5SkVHZUowWGZ0aWRyZkZHYXNvdlpsR2dI?=
 =?utf-8?B?ZFdrdnMyV0RpTlUwODlhQjd1Vy93aGRWK2V4Q0lVdC9pSGt0dW4xUE43ZG9L?=
 =?utf-8?B?QW1YTE1PZllaQmhqbzF3bG80YVpYTGkxYjdxQVdlQm5yaU5RUHJlSlN0ZFhj?=
 =?utf-8?B?L3VoaGtEMmVVQkJLOGxhSllsZXpVNi9mNU1QUHhCNHptMkl5cU0xT1hFTGxn?=
 =?utf-8?B?QnM1MjY5NjFCZHFRZGc3Zzd0UHMrSUVYN0hldkdXK1Q3Z1c4YzlDRUlvZzJx?=
 =?utf-8?B?ekNMMGptT0ZHazRpT0NFOTBPQWg2Z1hJSUF6RFJGYXhGTnRMajUyY1hKam9m?=
 =?utf-8?B?aTMvTHZhcnlJNzJ2amtXaU5TMWZINTJZSnAyYzRDa1g1R1JQN2JMTU0weHNl?=
 =?utf-8?B?bU5xZXNPRHpINnBVMUIzS1pzWnNaaEpHdGp3dVRIT1h5ZjdGQzl0TEI1aCtH?=
 =?utf-8?B?Q2FUMWZXUldHTWxOTEVxVWV6bWZMZFBWQUNvcGtqWHZTZHRKcFF4YVJwZERr?=
 =?utf-8?B?SHVPSjNKNndmR1M4NmtRNkdrM2JMOWJLVmpZYWpNRDFqMWdUSWRSUU9TZElC?=
 =?utf-8?B?K2lURE1WUWVlT1BBT3BlRjJaZnFGcXRwa25YbWY0MXQxRkpsTHJ2Y1RLMTRx?=
 =?utf-8?B?T0hHa1I1WTVicUJaOGFrRThnaUJVQ1JBeFZqK1UxYlR1OGhIaEp5SExCeE9N?=
 =?utf-8?B?QU5EQXVCTTRqQ1lnZVNHQ1dhbGM1d3l3NkhBVElhQlNyUE9QQXVGbXYxMkVk?=
 =?utf-8?B?TE53OUlidG12ZUxMOGpIWjAyM3FiTGk0aTRuZWVTSmc5TFBsNitTc051Nk8v?=
 =?utf-8?B?WXR4eW9RWVA3dEZSMVlRZ2dycjFiZFZWZ3htL3hENVlSWDRVRnBoaFRXUmdG?=
 =?utf-8?B?VVJSWmNNSENDK0ZFZDQ5bjhRVkxyOCs0QmRvMkFqbjJWK3hwWlJNQkVXN3pv?=
 =?utf-8?B?VEh1Ny9GdWY2Ni9MZlprTzhqTnBxOElVL0RGOTk2bFlJZnh1d3VxeER4ZHhz?=
 =?utf-8?B?UlpFanl4Mk5iYmMvaFhEWlhpTmI2TjY5Tms4TkdhcDRvWWZjTWR1SUFkcDJH?=
 =?utf-8?B?L1lQMm5WbzRoaG9GRWNVcXN3VjdCK0hhZUdWMFc4ekdkeGRkeTlrZ1lYM3kx?=
 =?utf-8?B?NXJPSU53cnd2S2xVK0VaOWVJNG9FMnRLaWt3VVl5bnd0TkpMaHM0ejlRM3Zp?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f7002e-bf1b-4d2e-773f-08dba4109c91
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:39:05.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzzuVfTEyQaKaq3RjT7QYbEWtZpTyMjBCYzBgGRdRX80oaYGa+tF6+vrGi7vrHuY9F0kfdh3gU47VDj6I96FVAxXlAc4rrMwkdhl8j4uedE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add support for using NLM_F_REPLACE, _EXCL, _CREATE and _APPEND flags
> in requests.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

