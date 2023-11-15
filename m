Return-Path: <netdev+bounces-47952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B337EC13C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C628124E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA36156F7;
	Wed, 15 Nov 2023 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DA7gTUYv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFF168A2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:25:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185512E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700047523; x=1731583523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgFWadQP7AFrpAEGhIERS/WzDSGJWUe/Hzr6Rst7La8=;
  b=DA7gTUYvQnFvd+uxnK2fzYlvflFpU5TMrPP5uhHqgL2edMFQculmJFKT
   MkXPBIExpxxw4ZjrOwpZx5cGMN97qPERDs/H6Bl21YdghF3pyTx9kgBXN
   Loj3hNlvGxl2JpNMtL7483S13h3aSle7xJ+8OplYd0sog+dyDUD/+G7+0
   AttGVza5fLAQGZ5WE8ESatSQu0P/ezoZRdQE27xh3Q/iLj9usrurh34b0
   jGLm6lg54+YD0blnpyCgtdCb7XNKTY/xwWNTEHvOhAw3oMt2Cl5ABeSAP
   jwKp3lFZXvHPow/A/ym88iywzlAEfStVG/ZAoPpVI5/nbNfjqOdgdlRCQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394775279"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394775279"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="855620411"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="855620411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 03:25:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 03:25:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 03:25:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 03:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfXOtFjW+8BCykqVCiYglkV6Se/MAr32y1DtS6oDGEJO8qD6jEGCyGe4kUNXD9je3QWETdut2oywAQR3aaODl5eHJ8YjaUgeKNRkZ6VFsmPnlpgs1rg0ZqmrXDfGK9l1zDepCpcT+hXY/VXlOncMJsAIV3S4oqdmoEIOwFZdS9o1eVm8yh9ourVBjbYAux2A9mVkd7DXFwAGBDdLDyJOHW/fqP0KNoaT1IYAo7N5zFvp2QQdbrGnoLpvhcT2DXyKh2bAvbUpXlqrmuuWKPCcpGdm22Z71mUbhVNrO5YJQj4APLxpwPhhAoOtmfSAi8GHQYjBHDS8Z74xPCP9ZVGReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9SLw+mDf4wqXOmDcASUG2O8xCFCg6uBXcnaY+PxNvA=;
 b=T+0RJ1ASD/XqzFEaqNG3sgWopFMx/nbQCvzUz22YTuL6aYNoc1CqYGp20jqucM/PtTLTa7Gfy1wuc9+NqMZ6y/ziqDXKy8s0JaO0HMOrFRuLPuDWacEQIe2m2qxzeXVRD8Y9EVI0F+1lmNw9/g4HNBSkyZqmFr9zt5jT+Cii4wUd/WErNebfRHdPJUg5QlNAgLW22k6Bh095rT3hXPpQgcxRHMLzTEY7FXy2nAWuKYjpHIq6gofc1Mq+IaX4LrEI+VyvSsI7w5welIEu/ecYKqEmsXa/NN5p19kGF3VKlLFbijfQ9oOSZoMr+aKyY0Ck1/mv9URCFoAnslGc6t8iEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 11:25:18 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 11:25:18 +0000
Message-ID: <b46bc1e9-ebd0-3ed2-587e-014e6ca3e3d7@intel.com>
Date: Wed, 15 Nov 2023 12:25:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 12/15] ice: realloc VSI stats arrays
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<wojciech.drewek@intel.com>, <marcin.szycik@intel.com>,
	<piotr.raczynski@intel.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
 <20231114181449.1290117-13-anthony.l.nguyen@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231114181449.1290117-13-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e42782-dd1f-4913-4bb6-08dbe5cd8b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOu/wpDtJN+jviiEAtJiIYQyXcqFGwFPRUNNF0m1oBwsjfAG0eR5uRUGlzugZ/tFWPDImVfRscIfsaUdD9zscl/w6aNNLSJljx0Zdormuj9lM1kBKE4SQmVyS7qfH/RKPQcMiTGNW36kT7XIVRkwuOLr7nUgRutMlQbmfsDo/rggBnDOO3XzcvEiVAbdba91PMwHdMlckzkE5rZvNWQxRXxV6RVyte8gsGqC4xurWSGuI6R0LKtjolrKLFzaMQ6AOzDyJ7jxsQM9kfp276uvxTJbZTveW26+sPNPDqfLGSQbWmkPDDs7O3Q7Zq0bndLTcUMCcJrK/dMVDu404KPpqnN5/cjfNlaRgFfv+qauCkgjW/dCLivUlWB9g3IRAsvTTBjkjfCtyNls3pKeKxQh+xFQZ9mMujXKaM1C6/ChBxf0WFgEvnVfErKZqCJgC5gezPl5MxiVB+KLME4xX9e8UeqNH6AfaqI3Jd2Z+hxAnxWQKcH+MRsZtklyLxhfYWP9B8ddxp34Y7ud3LHyo7UV0WYba/vncyoKF2opGRa0sy1wxm7vwnixK5fles0Av6Fb+Y+jJjzjeP5uRfuCjXXLWsX0tf7rxu6/uzqKhnXLFLk5gHJwq//RyYUe2KZuzFC3n7VgVg32O0cAkB8Eu5omBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(26005)(53546011)(6506007)(6666004)(2616005)(6512007)(83380400001)(478600001)(8936002)(8676002)(5660300002)(4326008)(4744005)(2906002)(41300700001)(316002)(66946007)(66556008)(54906003)(66476007)(36756003)(86362001)(31696002)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRJejRyRXoyTWdtekkzem9EWXVqYi9iQTJXZWpmdWloMk5EdWdXSFNIWGNx?=
 =?utf-8?B?VHA4clNybFN2Ty80NURQZ0R4eW96bXNUUDB2M0J3c0JVV0VKTXpjbHZZRjVR?=
 =?utf-8?B?Rjd1ZDg5TXpnaGNZbUxaSkdDRGdRQTM1cVhxcmxoNlBZSnZrQ1E2TVoyb0hO?=
 =?utf-8?B?WEdqdERONFVxbWtTZVB5MEtYcHh3Z3hSRHJuQTZ3M1JGZlVJak9pNGxkdkwr?=
 =?utf-8?B?WnNVTWNmTTNISEFzcjQrTEdnME4rY0U4SXFZRFRWeGdkaDF3SlErWVNEQ242?=
 =?utf-8?B?WVdJeXcvcTFKcEtOZGEzayt4ZXh4YjBHMGc5Ry9DZnlkRkdGU1FDVEkrRlNN?=
 =?utf-8?B?Q0VuT0p0SmhaN3BjVzdWcDVjam81UTFTdkk4TkZzZWliOTBrN29BOThwMXdS?=
 =?utf-8?B?T1FaM1N6bG9OWU5BRDllUldiUDV1aUxWdGY0dHJrUnJGaTRzSktLKy9tbE8z?=
 =?utf-8?B?KzZLbjVFUDlpSHZyNXUzR1JHQTdxRGEwaXg2SEVVYXorN2c4VGJ0aUE5TTFh?=
 =?utf-8?B?c0ErTncrMnhwbjl6akVWTlVEbmJUbCtESzBVVkVFK3RjUTdpcld3TDhqelBo?=
 =?utf-8?B?aHplY2NMaWJ1UW9NMURpZWRoSHE5bUJyTGEvY1hvY20wcW9KSGtzTU5DclRC?=
 =?utf-8?B?UVlZb0ViaFQ4M01SOUVVbk1hT05Ucm8rWXExcUN6ajM5SVpZRTkwcEhsb2ZS?=
 =?utf-8?B?WTFWSjJZRzdubys3WXlwTVpSQ1BwN2FMcW1NQ0tic2labkJ5RnRGbmJSNzhF?=
 =?utf-8?B?RkNZL29HRFRLeDY0V1ZlZjdWcnVxaStHTzV1a1ViYzIwbU9IYks4UnZlT0dF?=
 =?utf-8?B?OU5uOFVKaHNCOVVrMktHQkRmUEJWU05TUko3RzdFRzhzcFFqelV5cmR3RXBV?=
 =?utf-8?B?WWJ4dVVwckw1dHo5R0NDVW92ako5MjhGZ2FRcnllMTh4Z1p5dXpLUnd2dFlS?=
 =?utf-8?B?YTMzUGh2MEVMeVF5b3dsU2tnd2VHT1FNc2x3QUxZeW1qOExLc3Nab3dtUm55?=
 =?utf-8?B?QzNzcUVMeVMyQVl4cmd0ZTRZWG9sczdKUGcvbVdDM1F3Rk5pRXpFQ1lRdlpy?=
 =?utf-8?B?ektRamNFbVI5RDNnN0NTalI4RVVneDYycDB4OC9BeVFkMXpLOEpiQ3RZOS91?=
 =?utf-8?B?RmhXc1o5Y3lHQUNOcmJqSCswZ3pieE1ycGVidnZYVkpNTUdaZUVRUkplS3Rm?=
 =?utf-8?B?SnEwdkduMzVBUVZ4QW41WkxzdG5HT3U3UWlJdUFJdmQ4OGdrMit1WStQQ1NI?=
 =?utf-8?B?cUhhWmR6bGFFV0lmdTBvWnJwejhXRkdkY25uTDFMQjd1UFlXR1YvbDRWSGJM?=
 =?utf-8?B?dGxMWmcxT1lxdk43S2pvVzNsSFFmUFdaUncxY3JqbEozUUpXdkpNc1VzRFE5?=
 =?utf-8?B?ZmhhQ0p6QWxvajlGVHhlTUJrT3NFeEp4UU9nL0pXdGtDT1J4UjFLTG9yNlkz?=
 =?utf-8?B?UEwxeHlIQnpKL0x0MThLYWE2SU1Mc200anhIaS9aY2U0LzBMQzUzbEpna0FB?=
 =?utf-8?B?NmphVzR0UlFLenNuUldLWWZqNTRtTzg2VmowamZHRE9sSUpjcE5rMFZQd0JE?=
 =?utf-8?B?K1hyZUdKWjgyZnhqQmxWakMxSFpTdEFFVWhlR3BFUXI1NVZNY0FtUm9yb0hX?=
 =?utf-8?B?ZTU4dENyUHRxNlB1bjdVemhKMGhZQ3VoNGxiZmV6d3FqcElaKy9JVFFEN2JN?=
 =?utf-8?B?NHkzZ2NLN1R6TTB4eTRnUUQwTWNwNkZzS2FOajBWNlNzSlBSTGc4N1JNa1ZP?=
 =?utf-8?B?enc4d0hmS1pBUmxpdGFINHhFNURCYmxBeXVxc3AzYnQ5akMyb294bFhEYm04?=
 =?utf-8?B?ZkZnMGpzaWlRWExzOGJWUmJhODZsMkpOVjczdnUycXVGRFJna2Ftank1R1hZ?=
 =?utf-8?B?Q2xHSDFPbzFhRzNsUkkzS2ZQV0RSWUkwQVQ5bDlRWGZrMm54TzRkYzFMYVQv?=
 =?utf-8?B?b3Fydkc4NWwrMDhMWDc0RHgyWHQ2MVQyeGhEcGxzQlRhR1J6THJBUnlZMEpD?=
 =?utf-8?B?c0pQM2lhUmIvemdIL04zN1EzdU5xbEdyNUFLNmVjQVpZZUhDaSszaksyaGg0?=
 =?utf-8?B?MDN3KzdxRU1pdEIvcHAyUkV5a0dza3dTdEoxS1lTU3JFdzB3d1ozZGxYbFJP?=
 =?utf-8?B?MG1sTE9uT2hwZXIvSEtsTjVkUklURG96L2EzTU5iTlpidVFveStkV0QrUHc2?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e42782-dd1f-4913-4bb6-08dbe5cd8b82
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:25:17.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CpSlYAmSaNOoMl2C5tfUn7P7OhQEJD6yYdSbHgGrDSzIqLQ95EqUr/gkbL5PD5qnlsMWjrZ2iCdmbVhauBGa0ud046sc2PY99QJf454mMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

On 11/14/23 19:14, Tony Nguyen wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Previously only case when queues amount is lower was covered. Implement
> realloc for case when queues amount is higher than previous one. Use
> krealloc() function and zero new allocated elements.
> 
> It has to be done before ice_vsi_def_cfg(), because stats element for
> ring is set there.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 58 ++++++++++++++++--------
>   1 file changed, 39 insertions(+), 19 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

