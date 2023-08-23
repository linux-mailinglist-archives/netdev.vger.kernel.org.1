Return-Path: <netdev+bounces-30114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838347860C0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52691C20C9F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6241FB33;
	Wed, 23 Aug 2023 19:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC167156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:38:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD445E60;
	Wed, 23 Aug 2023 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819512; x=1724355512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ieu7kUKtbytsPf4Gt6QoTRc3F04cLEBCNoitxDLI2tQ=;
  b=SlRGS8Mk+Bz4lf971pXTmjitTjiSuCSStbLCGVAp8FkAW5R/oYmHhZms
   Dm5EnXTqhg3J0lhyDy+XZK3eSB9QZKz8NnIEKnbxWUyUbXCPYhNjREeOT
   PrB8C1W4+jlQlWU6kQyyexi5hLWiX+b/mZ5gxLB4z/yRenzuzCwPt0eK0
   4yZ1q2KZFVmcdYffyRfhlovCL8LnD7uim4UGlFHJyRCJKuHjkGKOXMZEz
   f5Yq6fh79dHhai0zhS+wT5L/Vpg/t9VjT5IKwq3ZW+OO1HDvhPFaRKtCb
   4OVU+GnLrFvC1ry+HF1t+RKIB9PC95BGAKACafEEdBJaeKUxvcmD+L8Jf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405257970"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405257970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851166003"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851166003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 12:38:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:38:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:38:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1imZt9JmbHyXsuAVzmGrx9sAqJjAI89nMtsWKeiYnH0Xv2FdqgpS2jIhcpI+ZAAwfPIVqA84aiSNZIQ0sjvAKXvRas1UFJd0zXEPhfKYNllrkzD1wQsFp0EJgCSMK9UAPNInTynF9aYDBCys95QnMBY86T1EHkGLirInRtTEHXO44d8cHf4pu2lrPr4FRQujctTVHroYSd5ji9Yn70VmC0mWlF/G5ZWOckEQoz8zI7IE0LVlEC9fncAAhLaZ3i0SUKIkXT+JCVbdCSIM1oFdEenXD5cPHvNM2zfBBvQh8IAyzzZpAHvGmNirSOiWSEZ6K0TmhJPfI8cR5VyJrq3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2nyqrVfnlo4ace0dESskWMqDSgAQFEC2GQ8IWINeoQ=;
 b=jQM05eSxSEDxA5EU4L9+PLDApkNCFPSt3s6HO+30ZpoHDdcgrjwPU6VXlo51Uo9LdNlr1zbjZx0LeG/+rECPHGc2Q6Ki3gtho8CnE4IIAuKUrijpXKu14XdeKx+EAwOQzaIVIa3rUfYY658nba2EJOuXUhJQBER1J3an0OpEsO0WLrkp0A/3PcUH4w4Hq3KF6DMeJWQw59gwt3PVmR+H5C7bY2gPVJU1pTQ9AhPyuqTg0qf4iL7BHvKnV/SWhHGTpVHqeO18bxDlDQOv/km4a5QIcP5370Cg3dl362vwT9SZ77dMFtWXKs962KCnZJ6xF/dRh4yUeoHR3zYd/iGEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 19:38:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:38:28 +0000
Message-ID: <66ed04bc-95c5-4e04-e0f6-c1d5e0d99f21@intel.com>
Date: Wed, 23 Aug 2023 12:38:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 08/12] tools/net/ynl: Implement nlattr
 array-nest decoding in ynl
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-9-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-9-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 048fcabd-bcd4-499f-bcf1-08dba4108633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDzeUYpwje4I2BfzmCZA+ihqj6l4Ae6J8tNgkLZkDgzQBpa6ST61CoOaSsHIc+g5Cz1PoSH4Ys/YFcubMlj3bUMhPQvkIe8l2CsM0RRb5E89eYDAf4uqFnV15tIuYhA+sZI6xt/ksZFVyzIKhWKGDCjIj79U3VZvkioQ09Ujms3T5tMwK9eeKZf9eBtHZiqY5Nfm1v3r9vacBS6ONRvrhNN+7c0Xc1pFqav4eyZ1wSrR4pPbLrytCROniibxnOUuRwg81N8qq4h/33gTvEyYdLRLm041IJgnwRINTJm/jU5Vvu3nY5MjzY/bBszPXfPXqYv9UIDpFc9DOdjPtQgev6KyHXD8bYWBddtcIEqOYRl1LiV8adP7mHXTfltgy0dnDivyOrinztQb5cOJvCC34lUNqz4jGC6PTEAuVVxBuN8jcKIwVVj8etU7HMZE2I4IYaSnspnRLlsoW6bz07BQ+XSE+pV6bSiwszN96Hu2MPRwtjf5Q0H2bSbd4QhLrrGCipO7NABFW5V+PkVvCg/UOCQlmOC8Zj5nCAb1C7Or+5YjbZ0diGdos54Dt7N1j5Ohbf3BeZjy5XTrYU87df3VcvhTbdAeTbRHU2udJxesjzxMtThdjumPraJTKy3exd4+RAh2tBMJEM3t9c78kT7yH/7ozkZE2hfkb2zBpBBEU30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(921005)(478600001)(6666004)(38100700002)(6506007)(53546011)(6486002)(7416002)(4744005)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czZITEJjbHl4UE5yQm01MzZqb0diZHRJRWhWWENyWjgxZkI3a1pTc0RjTGVY?=
 =?utf-8?B?Nm5hR2lqUjE5bzVoRnFzdlhHbVliT2tFUkdYZFhtZjZ2Y0psSElQdmFwdEVw?=
 =?utf-8?B?ZXdNV2JpcTlRT1YrbTdEZUFYSEM0c0laZ2wzOXpjVC94RnY3bHQ5LzNpbURl?=
 =?utf-8?B?VVFBeEo3WjRlaW5CTGRkOFRuM3BtcTZKa25QWTZoSnRCWDdJeVJ3c3IycERr?=
 =?utf-8?B?QUk5bjJmeVU4SEpqR3phblEvYWoreDVpNTdNZDNiL0FVajA0b2NiMFA4R2oz?=
 =?utf-8?B?cUJzUFdmZ1NkS3hyT21wL3A0ZzY0Mkc0NzBDOUhKcTZiUzVtamJEdTMyT0d4?=
 =?utf-8?B?UHZ3NUgyM2kzNzlNbUlzdTZYZFhyaEQ1cjFoTlNLQnJ5QXNTeFFCTmg3aGc3?=
 =?utf-8?B?ekpPV2lmdTBnNkFrdFFsbHVHekpiV05HV0JSY0grckFLUmIvN01HdUdldEM0?=
 =?utf-8?B?WnE1WlBoVlNBRkg3a1p0Qy9nc0hUaGdqbkM5dUhXc0dycnZkc2RJbE85OHhN?=
 =?utf-8?B?ZHJFckZwWFZDMXR0NGdmajJpa1daT2Z6QjUvcnlLeGh0anRoWnIrQW1rbUJH?=
 =?utf-8?B?TUdDZUtjZWlHd2J4YWJ0eE1YcGlBVWtySHZSVDNUdFowdGJSbVBmZC9RREVv?=
 =?utf-8?B?aVltRitVMWdIR2Q2WUlZZmFZamVZcllxL3FhSGpYeURNSW5kMmlLMGtYaFY4?=
 =?utf-8?B?bjJVcTRFaDlXN1JhMTJHUmQ2Q3F0S05NMFFXbnhGa1VydmRMWWliNTJFRW1o?=
 =?utf-8?B?WE1ZRlVWVkRLL2VBNVV2YXQxM3hXbGd3VTcvMkU3VDBHcEVxV2RrYVliK0J2?=
 =?utf-8?B?SDVBbTZ0bi9hUzBPbjd3NEk5RGEwZVYwQkFoWGFHUDVKYnUvMHVsemtoRUFV?=
 =?utf-8?B?K2Q5bWxvR1lYT0MxZmhCazFWd3NwQ2pacFYxbmIyTEVNMzRqdDlHZHBXbTN1?=
 =?utf-8?B?YnZQRU1tQUJKNExmekx0bW1mZWRGZnd6eUdQaVN6T3pPRkxiWUR3ckR6RlRu?=
 =?utf-8?B?bzZiZ1FuY0RPaWZaOXVkNWswWWhkMUk2dm51K3BwS3l3NkVlQjUzV3BVL1M5?=
 =?utf-8?B?T3l3T3h5ZUx3L1BJcmt4cmpoMnNRS3k4T1RPME0yeExGNGNaZ1BEeVhlQTNi?=
 =?utf-8?B?a2NJNEFYSWRQa00xeDNId0xBeUVzV0ZVVjZ6TGVsMkd5Qzl6VlgxaHNXaGlp?=
 =?utf-8?B?bGxxSS84V0dEVEM4c09XMXZRdy9yTkVBaW9CRzBOR3MyRDJZNC9IQXFSMTc3?=
 =?utf-8?B?dDg1blgxb0FBa1dkYmFwbjFVK2xuQ2hzK0VSMlZ2b3NDY0dlTGxtK3F2ZGN3?=
 =?utf-8?B?YXZyRzJIbTJaTWtuYVE4ak4xQndBdStCRmJxZ1NsbW1GNkFjMzROTXNpTFI5?=
 =?utf-8?B?NlUydFNqRFdyVERicE9VV1pGVUZSQ1c3REJhYkhyeERCeENXVjZ2T2pndHRB?=
 =?utf-8?B?czRIUVdBclo4Y3k1ZEZaMjZGSHhRMVU5L2FEdHIraURoaFZFU2RkNjZ3VWxW?=
 =?utf-8?B?WFpaa212KzZxM3h4b3ZYQ0JuWjNNc1V0cHBNYzI4dGlWbzNKc09EM3BOU2tW?=
 =?utf-8?B?dlQ0VHVTMlRhKzVERzhMMUdscjkrR3poZTk4dXRlN0p1cmVyazloQXNSSm1i?=
 =?utf-8?B?VXJGb3ZuWHpnanVoSGFJTmZ4VkpTaCtPYlhPQjBrZG5xRVNENGdIWWVhb1A3?=
 =?utf-8?B?djhKMkYzSkFOakpiZ09HeEVOTURjTk5FdXFkME04ZlRpS2ZuSzVYcVJKUDhQ?=
 =?utf-8?B?bFM3QVFBMmh5L3I1eWlsZlpMNVBPZE5RT3N4YUJOa0N6dklEUTBHS0dBRUtF?=
 =?utf-8?B?UW44RWZnYU1UUnBMSVlzYjJqSjhvMEY2NUV5ZER5S2YyRXgwOGNnZUlWQ0Nz?=
 =?utf-8?B?b2duQWlUa3ZMdk1TU3VXbGVCekxvTkV3WkhsUWVRN3hueUVkVWJ3TjB1L2ZC?=
 =?utf-8?B?REVnY3U2eGltNFJyendEWnIvTEdlUDg3by9HMVFQWDBkUGpSMW4zQ0gxMitK?=
 =?utf-8?B?VFpnYXVxME9tQ2RTcFBPelVsUHIzTE9SZkltVnVmdU9VN21mV09IdFhwWjJo?=
 =?utf-8?B?Mm1LZEFEUFViV21mMk5KVFdRTGdVWjFMUk1idDlLbkF6T0U4TXFHVmt0MGFl?=
 =?utf-8?B?Mmo5M3dzL3hIOEtFaFpkdFdNWkV2RytMNEdYUzRUTmVwZVpJdnlLYlJ6Ui95?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 048fcabd-bcd4-499f-bcf1-08dba4108633
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:38:28.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+ULNp7s6wrvecyFhXqYBBde/pdbK0uNk5KSwWNAWpzdTuM0TwBsFRceXs4jdtxCedOGiwH6b8FaSAA9au8CXcZTZWxmqYcHeNa0CEGgr5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add support for the 'array-nest' attribute type that is used by several
> netlink-raw families.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

