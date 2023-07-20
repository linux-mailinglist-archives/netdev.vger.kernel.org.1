Return-Path: <netdev+bounces-19522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA875B13C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF071C2141F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C518B1E;
	Thu, 20 Jul 2023 14:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3518B1A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:30:28 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC55F269A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689863427; x=1721399427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xHod507utfCV8rakJ9LOnpba5ZJqsHdR2L5b6eWFADE=;
  b=Kk7KwDNO60oDE0bVaJRS1HI+n1cKfImvJkgRm7W8jR4kNrgGexnDY9AC
   +oIQrOD3GdkMiZo705JGUHFSMpey9RKIq3XTaplUPi3zqirTPCqhxw3PO
   l8zalmL5sFe94K6kMtSlxS83sdFxxcVSQXn9ERwv4vaJIKE4+sXe9g7+O
   eyI0wgQsds8L/IOIGrA8P+lQRAExQ5pEeKOE63GBL/jNUK4wACKe8eyJa
   N4mWC6vkhFw0ACIT7Gr5FDiH8vJl6JzKYU04bm3Wj6BbEx6+Ul8BTmLAg
   H3R3EBH6gkcmPQY7P7S74s975r6sCJ/2ghEmEUCTS1406a5OHS89C9Uw9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397633789"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="397633789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898301530"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="898301530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 07:30:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 07:30:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 07:30:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 07:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBeCNZhlo85u8DpyDfro6CJZbcMI+XqxAlcYMvDbxHI19XoFXmkYJI/m6/AOLtP0T1Tw99uSIO9be95z7M/alBg7JK92iH3v/V2Ntywx6J+LMTrfLEhqpRiOJaKl3/Mnw+CEVmTSMySLJVc1+Eg6nL4w0uyLAi0+w6lJWPWWJkHuLsHOCNePbbc6eZmauDO1Fv8u7MVuPq/8jGot3J8x/nnfBzkptmiD3E16e/quSxmkO7wuDsZFbshhAeLtb7/FhZGyqm9+XlmZxrqkXVYOl/+8EAe8Mj9sw8pZQyPe0CXrDE+gDRHfKod+eqqdEe4V+o6gABjYvAfreJxDjyBF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc2v5jzS652r0u+ctdMTimSHLlnVuZ4/ud3PbjPDIZs=;
 b=MV+hpRp9YhmhORLqyjsuMH/EzHUkZFS9k7U3l8EmeykxStMlgTPpIwiIqR6W/CybP+H3twTNaFalmq9+WFuODtNe7suL5KXfCHjVD9WAFtIUFLtkwjNam1di2Cwj16yleweXU2OHIn7oKW8WvFqdkGaUnhGD9mSbPq1zAcMRA2+/+CDMoe3zlR5ZHnH/hNUkhmXq83iqIgHL/oOSi3Zj7aUQFM8ZT0J5rZh+XXXsKvRxB5M+toQqbVOBuJnobJCUF9nviSGkSg0hnFdUwDh134Sgc7ZBLS/hq1HCnZuRI5OXOl1qjAkkkNVPX0QeFvbkCCv3/5dh3RGxS70U+0pUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 14:30:23 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 14:30:23 +0000
Message-ID: <f1f9597a-e8c6-2e55-4677-a9fa0d9c37eb@intel.com>
Date: Thu, 20 Jul 2023 16:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 0/4] net: page_pool: remove
 page_pool_release_page()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20230720010409.1967072-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d185446-df6d-4420-59ce-08db892dda5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkcA0h3LDGFpbOOdBgMK0ISNNpvuyVfhuP13Dd1HEVGGbjmqnLOSlyI7HK8fRcaTxs9WnTfuWRhVB4RC41RxCZiNKy5zAWcoU+XZXW0sH7zqgO1qlM+xifhbX7ZP0vunzHoFHe73sl11sj/8qSwabTtpPuz1xODQ+qpCL9kaQXiPDwoXmMEWFa6fG8bMduSts5XNpI+BUV1DxB5Yr+FHjTZ+PJ3vLsIZbjFuU3jq09jCrjcRsRxo5IUF605pdED93pOlJswUeUkm0Hqdt4yhMUa9/wcLMN5Ezszo/pM1wKl6ssOO0tHrEYpiVsDzPmnI8l/pQLSa/IPcLGlVsXoBer68nr2gP3Kavn7IEKUMeZjO9vKwQGh/r0vge1slcP/nOfjj8828q4oqh90OGHL6sFamV/FSGxPipdwi6mupPx8+hSbchHlujW1OFxzbkPTEJXwmCti8ItOvnZ2TtglqXlYd1r5xLKuCuHYa6FMzraXgyz15MTDr9Fvy0IrsYd/Abj/oghxC24WvyJKXqS0Nh4pmCSFx/n5WbHIMlY3upV9xzaehDZx3IH2wP2PU88ZndVrVWkl21fHr+CL+2AkIC5MPDTqd+2VcuIHag4nevLcFiIr9j4iPUOAcGKyThHhOco67HIGZNID+6iAwo++9wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(31686004)(6486002)(478600001)(36756003)(83380400001)(2616005)(31696002)(86362001)(2906002)(6512007)(26005)(6506007)(186003)(66476007)(38100700002)(66946007)(8676002)(5660300002)(316002)(82960400001)(66556008)(6916009)(8936002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmYxVm5YVU1RbnNuZFJzcTZWRm91VC93NjkwTGpaV2VDN3ZlWHpXamcyOTRn?=
 =?utf-8?B?VFhYczQwRlBZL3RDZzc1cG4zWWhjMXFHOUNQNG1Vd1VBekcxVVgzRlB5L2VU?=
 =?utf-8?B?RFNkaHptNVdybTEzdk1Lc0YrSkF0UVEzdExXd3pRMzQ0U3Y0MWVpdHRrVisw?=
 =?utf-8?B?NERXTU5RTXhQd1lSazVyOEJlS2ZSNVorN1Y4emJBNW9qa3M5UktFa0dLSG9H?=
 =?utf-8?B?VFlXL00zdmhvY1BJQTI1TFdBV05mcmZ0THc3d2N6bVR5TUlaYlp4UVlYTmNZ?=
 =?utf-8?B?eXRBNTBBNFdwZEpaZWNNOXJTRERha2l1b1ZwZGhXSW5STEVCSjZUOVFjS3Z0?=
 =?utf-8?B?aXFxYUFZdWlaMUhPVjIrZ25JUVhDbkRkL29YdnNLZUFHellCOWtMUHBNSjZm?=
 =?utf-8?B?Nzh3RzRuNkdvdXJwc2VIamQ0WjM5Vmg3NmJEWUhScHNSd0pKM011eTJ2SWd0?=
 =?utf-8?B?cmptdlJzOUNZSDljakVkMEZFSUpOMEw1SURIMHJQL0VlNVpWWUdrK29WT25I?=
 =?utf-8?B?ZmxPd0FNZDhVWTV6cGlybkxkTjF2WVVaQkpMMWM2WGR5WG9PUUhUZVRWRnJJ?=
 =?utf-8?B?NmxvM3d2ZkhwekxHY3VmSGtIRTNVT2t2Wk9WMCs3c3Z0OUVqWE1nYm83S2x2?=
 =?utf-8?B?WEdnZDV0QmlGeGdrRy9BaHRiSHFHbUxZWjZGeTh6eFZaNy9CYkpsNkM3RlpJ?=
 =?utf-8?B?UEFjcnZzRVdNLzlwZGcxdkI2K1JmTklxYzJKOHZ2c0M2SmJjbjRMR0Q5RU4r?=
 =?utf-8?B?c3F6RG1ZLzlJUXhZV3EyQTJlZXdvVlVUb3U0ZVhnRUc3T1Evd0orTjNYcVVR?=
 =?utf-8?B?UVMxOGh5eXRaWDlRaSt6bmtHdFovL3dTV3RmMFlwVW56cFdEUXc5OXljQStX?=
 =?utf-8?B?dXpRNzBQQkNlYkFNTkNsNTlQTHFHRXJxalBScTg3OW8zOXJFK1FRREZoT21t?=
 =?utf-8?B?S2VYdk12ckxjdFlaTlFaNk1sQnlFWU8rbnJLVkJVOUUxakhjWldBaUV0MUw2?=
 =?utf-8?B?Q0pKYTJFRlNNRGoycmcwZnRLdHlzc0Rkd3pRaUwrU1c2bjVZV01IVFdRZmhZ?=
 =?utf-8?B?VE1HWVVneWpENURPRE9aNFRUS0lObTRXSGI1QUpQalN2R0lTVzY4L1grTDdB?=
 =?utf-8?B?YkRTSFRsYkNpWXZLWmcxOGFFSk1DcUFzc3RPdE9VVXhyWHM1eitKODJoUTQr?=
 =?utf-8?B?SVRBSVYrVTdtQkVzeDI0V1Z0bVRmazZtL1dkM2ljSENsWGo1MkJqNEYyWit6?=
 =?utf-8?B?K3RyMm9IVEZXZVJ0clROcnJINDZJRmhOemhFNzRCc3NlY3lMQnNwTWo3Tmxu?=
 =?utf-8?B?ZlNCWWJxYmdLNmwra1pMZnlFZ0gzVm10azE1MEFzQ2I5YnZGZG1MNDNnZEZC?=
 =?utf-8?B?T0F6OWdIaENuRlRKbmtWOTVWZi9iUXFoamtoU0YrdXpjQWpTb1NEelBhVStX?=
 =?utf-8?B?UnkrWXJ3ZEhpcmlMZkhCQ0MwMVpaYS9LT1ZiUkZMWGNkSWRWNUhaM2VhdVU0?=
 =?utf-8?B?cjFGb0Myb2JxU1RrSWNqdWFCSzNrWUFnOW0yWkFYc0V3V2Z5Wm9mamw5bnBV?=
 =?utf-8?B?S1V2QUcyMkpnQWp1L25YdjVjUlA2NWg4TndpN2pxNVBYanIrV2VKYWM2bmtG?=
 =?utf-8?B?MTU0SUg0VmI4Y251NGNFUUZLSzZJcHpyY2xWRVRKbnhuU0h1QklYWVQ4T3JT?=
 =?utf-8?B?dUlVa0dzUVViNnh4NVdxUlJDeUlsZGFod2I0Nks5VDdKWlZpVERQWlNNVmJP?=
 =?utf-8?B?eGZtUTF6MlFUenVvQnZjOTRZcUtBZmVKWThiNXJQWVBBdnF3dVFsQUZ3bUww?=
 =?utf-8?B?MVBHUnBEUGF6bUJxMTZ0cUdhSUZ4M3NVait5cTd0N3VqdWZuYkYzZkVPY2tx?=
 =?utf-8?B?Wk5wTU9md1p6aXIxTzduK2xXK0JwQXdNNUZhd1JTam5GVzNreXAzMFFqc1B1?=
 =?utf-8?B?MlpKbWc1N1FGbjNOSC84UERyWUdyWDUzdTMwKzg0RnMvU1laNmp0a0hqQW1V?=
 =?utf-8?B?d2VtTHdBRVN6ZFBNWURsQUU4SmIyaDh4Z3QyZHVUSkRDdDdKUXZJWFkyd1FL?=
 =?utf-8?B?QURKNEFpTWpncXRhWXZvWWpHVGM5MVc1M1NjKzBrOHBaelVPcy9IUytwbVRt?=
 =?utf-8?B?YzNvM2ZKVkg4YmhZWDljV2U4ZjhGbHpZZ2xKRHdoNzFoMUh1VUV2WGgzQVlW?=
 =?utf-8?Q?PfqbnScaeaOkFXksaa5KpeI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d185446-df6d-4420-59ce-08db892dda5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 14:30:23.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crak464ywk9OzSH5vav+yy+BB5oC5YzIjUElK46HLVev3m02fjcr6+yusSWq1/fGaxFeZGzhpF1QpzV2y7VHZ17dgr2e8MT+cUP4gV+uSCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 19 Jul 2023 18:04:05 -0700

> page_pool_return_page() is a historic artefact from before
> recycling of pages attached to skbs was supported. Theoretical
> uses for it may be thought up but in practice all existing
> users can be converted to use skb_mark_for_recycle() instead.

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Good to see that now all PP users use skb page recycling. Apart from
benefits for drivers obv, this also increases coverage for the related
PP code.

> 
> This code was previously posted as part of the memory provider RFC.
> 
> Jakub Kicinski (4):
>   eth: tsnep: let page recycling happen with skbs
>   eth: stmmac: let page recycling happen with skbs
>   net: page_pool: hide page_pool_release_page()
>   net: page_pool: merge page_pool_release_page() with
>     page_pool_return_page()
> 
>  Documentation/networking/page_pool.rst            | 11 ++++-------
>  drivers/net/ethernet/engleder/tsnep_main.c        |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++--
>  include/net/page_pool.h                           | 10 ++--------
>  net/core/page_pool.c                              | 13 ++-----------
>  5 files changed, 11 insertions(+), 29 deletions(-)
> 

Thanks,
Olek

