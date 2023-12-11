Return-Path: <netdev+bounces-55998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2D80D33B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C884A1C21442
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C034CDFB;
	Mon, 11 Dec 2023 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZi+ylUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A836D1
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702314267; x=1733850267;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kElDWCssqb6aS6iWZXnsIwWCJveCVpLatAbF8Mc24P0=;
  b=nZi+ylUZycWBIzUbz1Ci6a0XsDQvkFRcWFc8vZBW5IoYY3geWylWD7vJ
   dld4GqJ40OFTYrTX7vuhQtCAnbG5ygwpez8dEW8iQ3rexT8lEuRucDxea
   fuLI5BRZqCQiDce4jfQc6f62bc2y5FqNUBkp9pIZBZfnsXdpUiaBWJQmZ
   9+svJiMG1rPxd/LDrKZdW58qukBkUGKWV3x4jg5K/k83dVnXSm8rYFpDU
   M8qWn+O/K2F/PNARdE64/hrjqhl957oKQ34I+cq0yq3yWEc0r1RgnZfwu
   EbGOzFdOacGx16ukt1CVEJGZDPBD+zpOweeKsVP9xOfXH/ImSSQEO5oh7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391843801"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="391843801"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 09:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946397411"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946397411"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 09:04:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 09:04:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 09:04:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 09:04:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 09:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUi5efLDiTf/2CkyCZGBdqhS7WzuWuo604AYBJu9kkWmKwI7iu4yyz+mv1zU1sCg1S6nQ320V7E+uyJI6Rf3TzZShnIjeus0VAju68CZoTFvZa0XhAwX/fhKSLYLowW0altYQ6YqOf6/fu5/rBo8rrXX1uofF5AWtErDDuUOemPyOUv9hfk4zaT4iVeSm09bbkWMhQ/hLQFgPGxZWBxzVdyjb0s1Tf32MTFzBJMdr+af9DtWoIF1V67u0MPKWtSySZMjPURItTLeYlIP2ICyB0ecGcKXjO0VcnZf+Ejsmv4yXMTXAkyH4m2XIcMJbqn7lDTxB/yFquQxBr+0eSYgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjXU+kPzEfG2yHlE656Yq8cRYN9PDFzPl3DVTd5AoTM=;
 b=USEm/eIXtKddrIoK74v98DG6kN9h5652fgMJX3K40EpGLpCc/fksOg/4ayAZPTeTysLaC5SRT1K4w3uWGsRKadH6Pix9tZvLOeUsD+8SgEj95CJ/tuouKUhH67IUx9BCFdkecOOAaNywbe1oR3SZ99nqyKouxJS9K2LZz1tD7MkQRJZjzOqr2oxxlMO0ueLSNGiKqYG1awtQs1hbF4ZT2A38VAB+hc6CzlF6YXJFM157/6q37Dh3bdMztVa3d4ceQo5P0htTKx3cQGzu3w4ijkvgNv/8sLR/okswQpaLRTCDgrYRcx/PLSUBfgfmIP3b9Y3Q2/GGaWrh3ZFjolD20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:04:21 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f%3]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 17:04:21 +0000
Message-ID: <d075fbb9-4cf3-474d-8bf1-af8a6a1109f7@intel.com>
Date: Mon, 11 Dec 2023 09:04:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
	<horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
 <20231205211251.2122874-3-anthony.l.nguyen@intel.com>
 <20231206195304.6226771d@kernel.org>
 <75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
 <20231207181941.2b16a380@kernel.org>
 <df263bfa-9610-419b-8b17-623f5fb54d26@intel.com>
 <20231211083000.350bd5e4@kernel.org>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231211083000.350bd5e4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SA1PR11MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a93d20e-d3c9-4ff9-0d21-08dbfa6b3841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJx2oshHpRTIVD1Az4NqCKZGphGZnOA0PTD3PJ8WREyOuFu6hPV/MmsYx+IoknOu/whDOZORDpN946yK6gGb51p3GpKrfOYBXCNjVOnDtzRzPgNsGtjMtwiafQ2Zif8Rz6rQG9u2rhEjxgtak1UJ/GvYIPWHDmEu/SoNXZ9VxPIF6hu1673Hzh4FrBpCJnGBNQbv5kWkKSEX2akwYrQ8FcINSJ1hLoSY9xesqLkTqNwbBA5prAdPZEedJZQxg+9aBezelmx0RL2+46ZfXN/YGiVUN2gU9y3bqN7H+aboUQ/JYSNg/or3YkpxCY421bZWvhxGAFBVoaCtoRdvha2fg3ASMrOXFnvof2hK2sy0ZSRH12e+JLieAl2FacPYmX0SsXzMDQVXK+6cyntP+D/Tb7PNuJt2ctZ9aJ94Ix9bHej5jSBN+1Us26S6gLHb0GmPWgDc7t25k8DnXVs1ViSgAFgUrkS7+0M1kSQsFjgzROoYBu+JyfYFSp1GKKtqiPjR1v+E5bOJJcgHdmbiU324vikOPfGkbZLYcT1mgpigX0CQsJWs00Cc0CKWznTHCUG1Ed00Ja3v/GEvKGq0UAOj1jFI1Y0k4NRLMSJmA8pVxQmyAS/4zj8qoIgw1mD7SoKOrJD2oABncjGCJxuBpCGxKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(4744005)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(31696002)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUtzeXNhcWZVRGlzWDdjamVuNkZLdnQwb1RCRDNyVy9kaU8xY2RVY3dTMnNi?=
 =?utf-8?B?MTUyRWJpUlE0ZFNWd3hJOHppM3IvbkJNclZKVVpxMVJacnRpdGhqNnZncWZy?=
 =?utf-8?B?NzdnclFZWXBJWisxWHpUMThadFllK1RkVm5rOXNLcDZOQXZLdVBSdWtQR1hQ?=
 =?utf-8?B?UkN5TGdFR1luUUdkUUtuRDNUeXdMLzFNMFhZSGRUcm9DanFFMXBXM1pnQVoz?=
 =?utf-8?B?OWZRS0JxVGtRaHNjUzljWUw0NFpFWUNhQTFDalpxMUZ5UG5Pamx5TUlUQXEy?=
 =?utf-8?B?TVZRMkdyekR1V2l4MVdYSTJ1RmNHSWJPSGNicEpOOUhrWitXL1dTQTBtbUl3?=
 =?utf-8?B?TVp4RDUzMnhjOUlPbjYxZ1Rxdks5UkFSeHRoek11QXJNLzI4ZFBZUEVhSWFH?=
 =?utf-8?B?T0h3REpzWXo3aGpUb1A5Mk9Eb1M5QWhER2JwQzA3cnhyYXVXUWtqTW1kbi9t?=
 =?utf-8?B?WTI5SzhaZ0d4OXRDVDBPOENUY0tNQnpzZVU5NXJWa293WlcvVFZCMjRpelZh?=
 =?utf-8?B?S3dPYmUzdmxFVlRnTVVaR3BxRFRjSzJPU015d29LZEdyR25wNExwNTd4ei9s?=
 =?utf-8?B?UTdnWndKN0VQM0Rpc09zdVhaRktiR01YS3FMdjBkTDRuZWdJdVJvZnZvV3Bk?=
 =?utf-8?B?bHgvb3VmQmNkY1dqbzNGY1h0OXpJYlk5TGRiajNqSk5lSzNuRlhJMXkxeVZH?=
 =?utf-8?B?aE9oSndVRzEyUTNyWXFEYkxKWEJnRmNXM3BRcmNKVzZubnhxNVdSeEFHSnJP?=
 =?utf-8?B?aHJrQ3BCVmVBMkNWSkJDdzFMTVJuU1NUQTJlcnFwaTNYRzFLUjJQUUhaWGRX?=
 =?utf-8?B?eUdmNW82MDUzakl0RGNHRm02UDdwaWdyQTFab0xBdzVlWEpXVkI0OWJULzVM?=
 =?utf-8?B?NkJDb2ViZVovR2g2TW05L2UrUjdBVEZQZXhrdHNqL3JUZjZMUElVdy9TLzg1?=
 =?utf-8?B?RUwvS2VEVTY2Z0FmRWFtOW95cWRYekdya1BQdWJKQk5HVUpIYituV1NBbTdk?=
 =?utf-8?B?Ymlnbi9IUGZmSWIvYlhIUVpTZHVFaVllZ1ZEYnIveXBVUk81WWw5YktnWnpy?=
 =?utf-8?B?cWdkQzJ2YTdoU21qem5UYVIveHpWN0hzKzZPZkdWME5VQkZYWTVZK3UwS3R3?=
 =?utf-8?B?QkNCbDkrK3FqZXhoSGxiS2pHTFlmRkNGMEEwTFhFYVM4V0szOC9FcnY3RXJQ?=
 =?utf-8?B?UkpkNm03Mk1jaEdHS25RVy9zMlNFQlNqdGdpYTFGbmdjRm1hUm45TnRRWFAv?=
 =?utf-8?B?REw1L2Vnay94K0srcTh5MkV6ekg2UWp4bGZhMDJzTjFxT3J5Qkh5QlVrUDd5?=
 =?utf-8?B?ZVA5WjBZZWFLYllYZFlGN0ZnOTBFeW1vMlppMnl4djlxWnFCMmR6Ti9UblRk?=
 =?utf-8?B?NmpjdUEvbzRFMU9aZjZ4blVqYjRuOVpkUTNBQjRMNFQzTkFkeFViVy93cm90?=
 =?utf-8?B?bERtQ0w2aEN1c0l0M3I3WXBHbzdzS2JOMjRmMC9rQ2JEZDZOdEpITUVKbVFQ?=
 =?utf-8?B?RkwrRS9sWnkzd3hrbEJORVdLaHA5NW1CcmlHUWdnRFhIZXdSbWN2SFk2VEk5?=
 =?utf-8?B?c0ZPUVFNZmpiVzk5RS91MjBxMjVZYWVnTmNKa1FPYWV6SE5qU2NUN3ljYm1i?=
 =?utf-8?B?clpPSEtWbEN6amhYZk9RUkRNcjYzbjZWZHZJWnd0OWY0dHJSYjRob2ZmYXNu?=
 =?utf-8?B?L1Z5UW80SXhrT053Y0xpMUhNaHRlSHRnclpEZlYzb3UzTVprOFZsc3R2dUE3?=
 =?utf-8?B?LzkyVDVaZkpvMXBIN29KcklZMndHSXVIZlM4aEJzcXJXck1mU09wWE04WkFU?=
 =?utf-8?B?U0d5WlJqL1hJL0VJTUFyZkdkMURkYXo5U3RicHM2K1FuOFU5Z3ErcjVUOGtV?=
 =?utf-8?B?V1lOVnJIM1dLcU1TNTFhVHV5L3hCeVR6N25kV3FYRTB1NEhtWGsxaVh2Umls?=
 =?utf-8?B?SVd2VlF1S1BSN0gwenJXSUpFd05uMU1IYlY1aHhxbEszQlFVRUtuTHN1TDdx?=
 =?utf-8?B?R0o3K1U4WGpJcVhhenJodFlscUl5V0daVlBiNEVTOFVBczU1eHdnL2gzU0wx?=
 =?utf-8?B?L2l0dmVGWDlzNWx3K2VBVzg1Ymtpb1RSZE5GVjdTTVdYZTY1OGxHRmJhcHdl?=
 =?utf-8?B?ZkQ3SDNReG5MQXMwVk80Yk4ybUtQRGVvZ1ZBRUsvK3FjWUxnd2ZWQTRsZ3A0?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93d20e-d3c9-4ff9-0d21-08dbfa6b3841
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:04:21.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j5ve95TRgL6ygzln6QN5uFLUwEvQswjTNTgDFDHOYA5GihbsuOfPev5vWmyYNTh+1kO0fH0vKw+RXY1h8r9sA9lap+w9yVpmedmOe+Vwyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com

On 12/11/2023 8:30 AM, Jakub Kicinski wrote:
> On Sat, 9 Dec 2023 16:09:40 -0800 Paul M Stillwell Jr wrote:
>> This brings up the question of whether I should use seq_printf() for all
>> the other _read fucntions. It feels like a lot of extra code to do it
>> for the other _read functions because they output so little info and we
>> control the output so it seems to be overkill to use seq_printf() for
>> those. What do you think?
> 
> My rule of thumb would be to use seq_printf() if you have to allocate
> a buffer on the heap for the output. If you can output directly to user
> space or the output is small enough to fit in an on-stack buffer - no
> need for seq_printf(). But YMMV.

OK, thanks for the feedback!

