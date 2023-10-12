Return-Path: <netdev+bounces-40500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869337C789F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DF51C20E52
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728883E497;
	Thu, 12 Oct 2023 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezws32L8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A13AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:31:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818BFA9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146298; x=1728682298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P3C7NUXDiPxF7LUf3qcV+t/Gf1MGj+Ob8+o/rok8J/I=;
  b=Ezws32L8nAfpo1rCJx/wesTHqCcNc6OORc4fxdiiA0+/Pivd5f5DQgRM
   KMBTZuHRFnX1Ji7K0KSxBAPdCHFaEFMmjQvPa5ujk8WoZKIWFv0DDKaXn
   mVUU3LXDtRZyLcByEv29SoAc8AX7wYE1YXNWdJQnOuLeTjSXDh4OfZ+Uq
   xOnq2P2CRKM8acn++ZVh9ALqcbq9M+3nIyyy3ziIwN4msolv5Ev6dUhEK
   GuJ7jK1eGqKYd2gK4Ll8fP2xajiEBLI4z3BGnBBHhYnT9vpuJC4t7xjNu
   l4fI+j2URA/SAGhyVGzkz+kBmG26IZtjynEMWqQuRqxCVKBA1bq74mi4X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365303616"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365303616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704343696"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704343696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:31:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:31:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:31:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEkW8jRpltyB3/8Aet1fUnlSOA8Px7QTmz9sGexVWHnvWF97DxsE+RQJNIXdg+4Ytpz1pKKL5os4HSiDfxiGAKES0hYic0c76toqKthlMLxJ50hPFJgLSH3riWzQmxuUb63USuBm4jUF4wCGoZeKMLN/4/UyEvP8sxG2zJJFTFIkfxAJWNze+a367rYpNnFzHoStk4CGMlsNJtunoYSG8N6CgDCcAMNSaJPyvbrPqOdYZliQ+xxI7nOfZtoT9l8f4Teh7ohhFQ10wg6nUTWNmF9v1jw0RSdww1KRD6gMkMBFQSurS+/vnE7iWcInl8SDinwuNGoV/yRvef2xbw/U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zshr+It10LHddFyxmIR/yjHfy+qWyTu7UF07r17nOl8=;
 b=Ibt8HTmDj4uxLVP4CL11dBimSUN2qYgEOo9WOS/COKp4V02vvvretKh+4OwOd7p2tjwpAVCrU2d/iTknURb8JcHfBdu2GOlBCjx3VToR3RlbEkTBQ55dHSghNqsr0jbGuKP06EhT9bdNtd6FRw3+uTVTO3FAOf5rMAa6MryIqKxpQ1a/h6BmZwm9cCP3b2XKo6OJElCWCUGWwZQkmUTryrDcWCVEi+Qgd2eIW4mf9QtJFyd6RQjPM5GnKxKPD2IKar5ygGFrrDPGRbHDR+paxhowCMdqPPSl72WO3fsU9uipAOiOJ2T3Oyx99kcLaBMv4tt2sPIoXDzFH5y6BwhhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:31:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:31:34 +0000
Message-ID: <ece1756c-3795-4a4f-bcfb-400c54753d03@intel.com>
Date: Thu, 12 Oct 2023 14:31:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 10/15] net/mlx5e: Refactor rx_res_init() and
 rx_res_free() APIs
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-11-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-11-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e783cdc-d255-4bb3-1b22-08dbcb6a9b9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdHXG3rDK8xlkh3bJ4JSA+/Z7uoGvdLDRuinz9vXzZI0RC6llg8mRqpqgJKewtM0oasqmcfc0j3M1DirHqOGEXrJTelEIjYOnj/u9EnNxEjEfB626nII5lkIT1MeWwqn5LJ26wewd3JXGMarliKmqcszZ0u9CFwBwOEVJYRefDeABAC+nnu4z1DI3RY1X55phJdy1mAVJiOl7s6doxbhajVGUT5pezhB29EOhAyfath6omabyq7LlFi2wI6UPHMJ/Mm2lfBnWKrlXCcZzxV/yqpj0AAcFMSpbOK38S+NH4zTF17wcDNQ47NbGU6dCXZI/AQW6xzz8edHQd7W4h2+bSebeOqEn8mo5mkflRtmeer8XIUrhFZNcTFHR73/2hl5Wy+I/6wbsDHV8ueBOhnYTNLCwTlYH6xQ2hGokpowdl2oYFIJzvNL1KoasI9ylfaRBU2tlO1lD/BWew0dQR4umHPzXxQVWuxNfECucsQhgiCIfYKfI2n6jtT8/zjdAFxpjBMrLU6Y98D5X0B01JYi7ZHfiSYAL9SSSIReBpLEji2EPoroSf3dTie/Fg1vT8r6h3tQWhIGLVTEhOcBG9Hp8y3E36L2gb0ZQYfJoo+C8VOHFs5+beEo1y5jBQIejXImmdMwxT7p3gGeR8TQ07+guA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(66946007)(66476007)(54906003)(66556008)(110136005)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(478600001)(31696002)(2906002)(5660300002)(4326008)(8936002)(8676002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdJU0FFUjZzZ2xTVkRLK2U4MDhGVnRnVW05aGoxdUI5VTVpeXEybmEyQlp4?=
 =?utf-8?B?UTRJd2llMDBBSmd1NnZmV3hnaWQ3QU9WWTFnSzFRZ2c3U2V2NEZodGVBTUlN?=
 =?utf-8?B?cEpDUllRdmkxM3R6NmNQczQrSzF4NmJTdU9oL0NXc1FGa3pRTy9XOFNkdnYv?=
 =?utf-8?B?a3pTbzI0bEFSQjNLdFU3MGl0d1dyL3I0RGhrOG05SGR0YkZBdnZtQ0hIL2JD?=
 =?utf-8?B?RWNPOVczaE92b2hpV0RzcWUxelY0YjJvZ2hSOVRFZy9wWmUwWWN2OUlHdEFs?=
 =?utf-8?B?NmNoQkxBbjdoQ2FhUVE5a2J0VWFzclJMVXY2RWp3UnRxRTlodTh6bmRZazU2?=
 =?utf-8?B?ZkphOVQ4U1pBZGhYRkVLQ0JQUVpuaHBlYkVqVDJDRTdwVk50aGtqdlVLbDBr?=
 =?utf-8?B?MGZSREQxcEVzTW5OYzdSRmQrTVVLT1Qwek1mMlN3c0hxZWY0VjZ4bHhPdTJU?=
 =?utf-8?B?cEZYY1JJNmY2djR1bHR4aWlkMkZ1ZE9ZSWFaaTZvUUVPTDdtWit3TXdMaitU?=
 =?utf-8?B?NE5SNUhpMjk3WDNCQTdiSWU2VkxLcEd2MzVFQjB3TEYwZ3NGMkhQNFBIVmUr?=
 =?utf-8?B?dHRVTUFXanNRMDZKRnVvRjVueEkrMWV4aytoQ1d3RFlWZUJ3cEhhNSsrR3VU?=
 =?utf-8?B?WXR6YzhBMGVjeGNhRi80MmpLSzRkajd0dWdINFlQRDlLWGlPak9IQWxJeUZU?=
 =?utf-8?B?MTBVK0d0ZjE5cXc1eXFXZCtiQUR6RUVlTmR1ZituZk5vZEFRYzJNc2xha2cv?=
 =?utf-8?B?UGtJRGlheGNHRXRwdkhVNjFXYVVlQzUrYzJvWHIxWlVpbE5UdTJYTi9VNjM1?=
 =?utf-8?B?TlRoZWtrbFpJSC9Ha2ticDRtMmtuVnlJMXg0aHF1QTJ4eHlJaWJ0VVRIaGEv?=
 =?utf-8?B?SVBRdUpNVXdvRWJTcGpaUUVNZ1VTektBMU1mVm44aW1ob205VnJybk1zT0FE?=
 =?utf-8?B?dWd0NGxpYkZLUElXZVBmYVhyUGFtQ3QvZnkybVhRS1BOZFZxNkFyTlJjQ3Ro?=
 =?utf-8?B?dTd2K0V4NG55WUhSTVlLRlBUNWtYL2pLZUcxOUN6eitTdG4rVXdpUHRVTnE5?=
 =?utf-8?B?OURRZVQyTzJWVE5xcWVGUWV3ODI2bGpzc1lXZEpaSjVVekJJbGpTY0QwTTdl?=
 =?utf-8?B?QU9mTWpLVDh2V3BjTEN5TzBEbEZJODVTOGJwR1lhWlVZUXRuTzAyS2lqYzFU?=
 =?utf-8?B?ZW1ENnlrT3U3OVdTRFU4MzQxWWxrQzdwbXZQU0VUS3VWZjcwVnk3eXdCb0tl?=
 =?utf-8?B?eThNWC9wODFjeG9EYU1KS0dyYlJSQ3FPK3FzRURBMGFyZHB1Ti9Qb0tWa1Br?=
 =?utf-8?B?MXk2SGNyVHRBV0Z0YWpENVY2YWdPUjNwOW9zemw3RWhnNEpZcmNJdDI5MEpv?=
 =?utf-8?B?dTVwVjRFZWZKNGcrOWM0dldnSTRtM3VsVHk3RkNTRVYvbzFEdlBzRndoS3lQ?=
 =?utf-8?B?VGI3OEIxTFJPdTRzRWpnRXBuZnhTQUxibzU5MVFtVVIyaXpWV2lLWkNZSUpC?=
 =?utf-8?B?dytWbDBoM0p4N3ltMlpCdlJUSjhzMWZMbXdGOEkwZjhtcVZ5ZEdXSldwR281?=
 =?utf-8?B?WWVzeXpLTWIrbWtWYUhSRS9hOVU0eXV0OHR1ZHR5NmNJU2J6SU5QTkJhQ1dr?=
 =?utf-8?B?VEpYYlFzK3RlOUhLalV0OXhiNWFqazVZcktLSlp6TlJ0ejZpYTJtNUJxdW82?=
 =?utf-8?B?VjdlT3BlQVRMNzRuRkNJQUVnN0ZpK2c2RDdHSzFlcDViZC9LWkFnZXBwQnA1?=
 =?utf-8?B?U2VVZWVqa3VCRkRrdlhESWQ3YWRJWnhOZThDdTNVQThXOGJlQzJZTmFQdFkz?=
 =?utf-8?B?VU1MVm44MXpWR25RdjlXZ1YvNkpKOE1OWFZmd0FUSElIR0h4WHpwNHRJNU9i?=
 =?utf-8?B?WHVjZEpyWkJHODhhd2dSWTJBWWtvRFhLMU05VlhrNW4yaWx2M3ZwZ0tGZC9C?=
 =?utf-8?B?RklMRGd2U0tLSjNXejM1cmluRE1aWFpoYlhzZytnbnZrcWlvMXJsOWp6MHU4?=
 =?utf-8?B?RVNSakFUTjdwREhOc29OdUhmdEZqZ2pjTzlnUmdtbVRqekM3TU9Dc2lQeDhE?=
 =?utf-8?B?bWUza2k4Qk5CTlFpMjVhMVlBbHJwVW5MQzV0cm9ZRXBXSkVvOTBZOHZNSTVi?=
 =?utf-8?B?czFJVWQ5NTc0ZC9jNGtxYUtBdS90ZUJuMTlxcktHY2lvWkptRkhjSVpnaVdj?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e783cdc-d255-4bb3-1b22-08dbcb6a9b9f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:31:34.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfbLh56qOb6VInrg1DXNxfnxjq7jENFIsmboWV3tFiZrNICO9gYazivfGaOjjDp6KKSDjNqcUALKTum1lTChDTwYVNFQLObJpihX/1miZ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Refactor mlx5e_rx_res_init() and mlx5e_rx_res_free() by wrapping
> mlx5e_rx_res_alloc() and mlx5e_rx_res_destroy() API's respectively.
> 
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

