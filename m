Return-Path: <netdev+bounces-48190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672C7ED1D3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C799FB20D7C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75713FB0F;
	Wed, 15 Nov 2023 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nqg6+4XZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1592
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079086; x=1731615086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SHqzs/dgsaSPzqbI6K9AN8QkCooKX4ypH56S1VpKKwo=;
  b=Nqg6+4XZUDr8bCm0oPyJutf5FdkM6BddFGAch4hXTDeoVAM8eG0qj7jk
   VFzPrDovT0/WSlFX5znHH5rZJbTYy2i/2DXxGZq6UvYdCnNIiGFXuGiGg
   YPVD4uq/oIMsoYbFqTLhIeURttkusiOlroRsqbKr+ME5si/a8Qglbz1/Z
   ty/vDky8SU1PMfLw8EZP7Cq4U1cPwh67nr4f6xfOz3Rl9BMl1Zy15SJAE
   vj6JjeGo7TKGzHbEuCRkXIaKz1tMOwARGSwps7u28IV9iA0fZMTduMkjK
   u5LNXjko21yoMEfS7MVX7G0u92ZQSktXT/EIyJlXNcJpH27m6oxJt8avw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388110345"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="388110345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="6500483"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:11:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:11:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:11:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Sj9OihBj2zgtYINQEW/KoGTJtKrhiRspFPRxVTIv+BtFTMQTtOzG0PqbTgduV3hRj6lW+218smaMcte9lt3eRHimI6ixGlakwIjofpkbJmIRtTZg/8BmchITJQgmH6A/U3GgjweMqEKp9Xoz/8mmwwKy2+huzu8066XVYEo1yeLJfBX5IBV4KeMw8ks49vuIaMxgM97qUzlxa59EzVGuSkSCo9dSmuGoahZwjk8c5hkGzO6fSe9qV01Lu470C/p99bdezq/eltiiitsjmAHskUzDeEe8oeiMHlOWRMKuOd6AjH4X9BD7Fmfvai6GSZfb8jhXMetUlLjQrpkAf9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUou2WFhCYKJILBjLHRrAjDTtoMtl1fByAbd/+xZADY=;
 b=b00Q2A/DStu4EzdO8wGnI3M2OnC/3nEuuC9q7nU5Ps7GOtvVgTPdc4EO9wBcrcDdKMYBfwsr4D2nKfujJerJ2kGUeBqv+2a28sGnbY8SkYj4FV7RIM67IRm4/htIb8qpN7uKZGieJzzlOwTgx7PxKR6Gpm03PlaExHhg8jeKQnNo5XGjyXW8/osriloaeJfd0OKIqVjzZ+sT2uazub9Iq0+VpkraMPqhYg3v0fmuF9ueYpBeIsV45EWHwiIpkX9erD9/jjrGIUk1W9EdJ2xHyBJEXLjS/Fqb/iOuYlyQPnbONj0FkAJG5kXepgyXJKApylJU5S/26j6r0Jak62ROSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 20:11:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 20:11:17 +0000
Message-ID: <38980b21-4d8f-4e67-baab-514e05038f93@intel.com>
Date: Wed, 15 Nov 2023 12:11:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 1/8] devlink: use devl_is_registered() helper
 instead xa_get_mark()
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-2-jiri@resnulli.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231115141724.411507-2-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 299818e2-a5b5-4aec-91db-08dbe61706e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUeOV79wknFBRHHysy9ugqb3mtSgvY1vnILZ+Krc90dPtVaXnbXzDjE/atk/Twi81zjRSo/ZEBHSwePYsAMc/qD/UimlMpLjtl4PgJT2GFgt/60/4npW6GbtgN3m1TGgbeo32CVcJE8vMAUJEQ5EYs3clsD1m/2aHz2kXcy0Bl2sntEfMJ2EL+pfYVY9/DEbFmlpg0HOdo1KKvumnpq++gUVpK1hSP5jPefwiiAxNnno0Kc5ruVqshy5zOGH04k+RXCMI72CAn7l+7a+TJasqJ7uyTWn7L9NLqZNKn9647FDX54JBURpXIyWGnCZVfqwGGo+N2I3WVZ0VXZokObbkiFWBb3uY+wympiN7k6Vga1qQYmpEQKzZN7TTgxpq12Waixy8n/Xu43lNje80DhZPSMag/ECuD5JqnmpTrIKYj9SDHw9Z8GTtCMCltb0dFEAi5PlPzzkh86K9i1M06PU8fzVUVbDCs6aIZ5FcONDMV1UIeDJUroKUz00jbrmft4gUb9Jr6DyOKktEC+qZ3rCekZzE5mAmHspgr7Rr7DBoGFZAHQiRZ7j7vXExJlYxztK7GlcqUT3QWzt7azgW730C88db9StFPHgYdRxRvVMFS3yNyF1Ud9YXPWYRRT1AOtRrvMGXbPNfImNgN8X0aP7lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(31696002)(86362001)(6486002)(36756003)(6506007)(8936002)(8676002)(4326008)(316002)(53546011)(6512007)(5660300002)(7416002)(66476007)(2616005)(66556008)(66946007)(31686004)(4744005)(2906002)(26005)(41300700001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkN1TDRJYVJYTUlUT1VyZVJRQ2dwYWViSVpkUU1FNU1ZRVBSOXJzUU05NDdl?=
 =?utf-8?B?Y1JDWFhVWENjdnpGODB0TzNoMkpTZHhzZEh2ZGd0S0JDelg2dmZDQ202WStu?=
 =?utf-8?B?eHJ4Z1BvVU1TYWxScEMvUERmTWpTZUl4RWNmMnIya0F6VEFRdUNBU0lhaVNT?=
 =?utf-8?B?Uzgzai8vV2tVb1dCQk5hWGlTT2FVNCtwUUxHbmQwNzdQdGJobWZqcHZzbWE2?=
 =?utf-8?B?TkVBSkY0QUxra0d2UGJnckx3b0NRSmVBVmJENyt2Q2Q0Q3VsVVBzbDBUUWlC?=
 =?utf-8?B?d1kwQ0xXY3JlMmd4aUorNE1MNnlXbFpqSTU3YzNkWWJLNnJ4TnFFY2tBOUhi?=
 =?utf-8?B?WmgxNGdBajRsWklpWUtBbzRFRGc3OExPN3lHWVM1Y0k5WXZVL2JYcGVoWTlL?=
 =?utf-8?B?Q253eEptdXRDV1BwYjFLbzlsQ2hIUk9CS1FhSVhxY1FIL3Y1YTYxZTlVSjdH?=
 =?utf-8?B?dHl0Q2ZBMmFmd0VXanBSK0ZMdGFQSnhoZ3dIS0ZIMU5KT29FUzZ4UTlab0dQ?=
 =?utf-8?B?enFMRDM0RDd0Z211REhsb09iL1RFT1RJYllwQm5EcVBkM0tjY2w1K1VWYS9L?=
 =?utf-8?B?b0RrUEhseEZwWDl2Q1ZvSm9Yc3FyazFveHIzdTc4TUZjWGdRRVB2aHViRndm?=
 =?utf-8?B?MWlNYmhyL0Q3K204RENnd2ROOGFiSmpLdExteWVneWZubHIxKzdUTHlwZEJY?=
 =?utf-8?B?VExkdEFMcG55Ly8xakEyejAxNzZWK1BIRnVVcWZ5NGNLTTdPZ1IrRHg4Yi9u?=
 =?utf-8?B?OW5pYVMvcnZGa0k2Z1NvSlBtTldaMnplZ0hlWDFISitzdlhNVkJYL3Y5VnVm?=
 =?utf-8?B?TjdpbjFMdzI1N0lxdjBGRUZrUTFHam5BTjlqQWY1UW1PQnIzNy9kTFUyS0lz?=
 =?utf-8?B?cStQcEg1aUtleVZrL2cxQ09Xck16Wk5VbGdGRlQrVkIvRjhNaE5RODdobldi?=
 =?utf-8?B?THowanJMUWlPVkRQWWcwVkJITXZBU1NTRytCSzVSMjlVNEdpY3ppZE44MVp2?=
 =?utf-8?B?aE4wVWdhWStkQTk5VUFsbDNkR1BGTllWMEF5NGFtcGNienI3VkI2L3FucFZR?=
 =?utf-8?B?NmxRR0RtQkc5dDVGYXI2NTJjRlUwY21heEVXVTVsMVZld0FOc3ZnMHR0UmxU?=
 =?utf-8?B?blZWUFBnV2VMNHg4SVRoalpTYlBOc3B2YzhpK0VLZG9qYXEvMGx3V1piajZn?=
 =?utf-8?B?QkdQL0lxcFdlcGlrTlZCTVM5NWhGNENvZnRRR3JRNW51UWFISzUzVWU0Rldn?=
 =?utf-8?B?LzliT21KRWliTHlBT0U0VUJpRUhaQ0haU0VoTzUyQitZMGg3SnVxZkVFZTl0?=
 =?utf-8?B?b1NwU1RhS1UraTVIQWp4N2t2UUloOU1FOVVyTTkrR2JMeUozQTgwY0ZtZEFj?=
 =?utf-8?B?eGVTamRKWjZNaUlUOVUvdHkwbE5BRXVMd0RaVHFObmNoWm96aHRQU09wZERw?=
 =?utf-8?B?VzNqUEs0OVJnYzR2WHAvS0IzYWhwZnBwNTlTYy9udGZPaDdYbUVXMisvVlhw?=
 =?utf-8?B?eDFGL00vMzQvalZrWEI3QmlHbi9zeUF2TWN1bEM3NFRIMEdHaG9hNmN2QXBQ?=
 =?utf-8?B?MVh0RnN0MjJTeVVXUVRzZDNubVpaN3JEN2pHSThVaGJxTGpWNVN1dmVOTjQ0?=
 =?utf-8?B?d082aEJneEx4bVFzUm9SZTlGSytwd1A3eThEL2VKZW1EWisra1ZOSVVNNTJs?=
 =?utf-8?B?SzYrZkVpOUNUaWtrUzdDVllFdzlaajVUU3V3WFlNSnV6Nk1mSjc5eWRqWnFm?=
 =?utf-8?B?TEErNHQ3TE5Ca1BWWUNFdlZnaDNYaC9Ic2F2RmIzRWttNVMrcmxyTytHbS9u?=
 =?utf-8?B?TUhRbDRBQlRhZ21BdFdXeFhKenVvUTRXQ0RaNTNTdHhpUlpoWXRKSUNobmhv?=
 =?utf-8?B?NDFvQjVucElXVG9YZklZdGtPaUlCWEtxYXlSNzM2UmhEQlAvbU9EbVRoNGpH?=
 =?utf-8?B?QU5YbzVvTUdxb05iOWtiTkQ1TkJIYnd1U29pWXZaQmc3TkpQL1pOTkUwWmZK?=
 =?utf-8?B?cE04MmZqa3kxbnpmd2w2QVlIdG4yc3VKOTdWRlhaVWtMWWFRVlhGSEtPd1ZX?=
 =?utf-8?B?UXl1VEdZMkozY0tTTlRLbnBNNW9LWjkrR2xsbTlHeXI2OTN3QjZuWTd5d2lm?=
 =?utf-8?B?RGZKUzZ2MEdTMCs3RmhiRGNxbTMxZGtwTTVuYXhXMTFMSTYxRVRpNDlBUjhn?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 299818e2-a5b5-4aec-91db-08dbe61706e2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:11:17.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEDTlU+4smOoYBhLjYMY52fGx6dOwChr96SwVn2379y1TfzyZOs182vOzDvOINrEYgN9mVM2VPAz4VouqX6O2PeYSGntorjHneta0gqvnPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com



On 11/15/2023 6:17 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Instead of checking the xarray mark directly using xa_get_mark() helper
> use devl_is_registered() helper which wraps it up. Note that there are
> couple more users of xa_get_mark() left which are going to be handled
> by the next patch.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

