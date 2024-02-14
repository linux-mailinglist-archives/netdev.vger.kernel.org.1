Return-Path: <netdev+bounces-71855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8345855587
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3917B214C0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46C7141986;
	Wed, 14 Feb 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFdKTfyq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B47141981
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948389; cv=fail; b=sibUQ4dpOUR9aPHJv+4C6UChdHELt6ti4Yo/AWzkufdQk6d/TSOmLkclHhx4VEcbF8jnjRaNRvQ3eHSY1DWl1D2tu4PBdHqIdN+sV7qhxKNCfAEE9+FFyrfTujLbvunrQgvs8b8xtoKtjVmduq6zJoV9SduJ58na0OS/BgTXIP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948389; c=relaxed/simple;
	bh=cl0OmXy8i9A9fVZtKaI7h9VqUsPTp6NxnQfgT/UMP1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AU41bW2zjVAaPQ2pBu20IrIZOqg2uYNE/aWGb+0VCakW/tTKf1dI1YcWbOCoqykTnPnlFv98UBjgHlNKljNSsf22xesoJsYjAcJMpppnur7KXxgm8mpTqXGXWIZuCCarVXiSczJBstx4zbc7uuwncAWJrVEaEFO6uV74PjmjYwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFdKTfyq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948388; x=1739484388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cl0OmXy8i9A9fVZtKaI7h9VqUsPTp6NxnQfgT/UMP1c=;
  b=PFdKTfyqwwb0IDRlTkvvujtqFPfqCMqMi4mwWwspqCxy96dtjBpQwy1w
   4thgRi29tsZJh17hmEH3EctEIMRuM9lEHaf5EL3o9neO59lc66Qkcr0JU
   3HhRASyv3E210r5TvjRl+GgnUlMCDjfmXv7Kq1fbIWTfYKnPt/x41vBM7
   SJxlQwwPghPBXiySvxQq0V95kx0iGmjS6ez3qOss1zbNoVffxHIdb1FLq
   OAs0DEV6qzKkbSNbN8m5avwHpBCNISxL+ZuAmg+d5zuAr2M1NzPVqMr7k
   IjnNqj7bzp7FzolVwabvlXZgeoiLs74sqVTE5BfY3wjLXsFZPuo0gPrCM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19534540"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19534540"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3701195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:06:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:06:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:06:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:06:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:06:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yap068vcKqgupCmBMg4gpPYg0oDkeU1GvcmUc3DuWcJFoiNKf0KWN0XXOZdueWuDHvuKKz4fR6v/OkVaAfEXaLIlXfAmWa7HGFZxKJ7egGD9uPcgFlby2QovJyUc9DGqpYYA9ib052+pqyPb/NHfX/Nt+5HeVCtSnNQevxGZpk+2PnWPvCNpzWKHHagW6npOElFiG8KnX3V5LBZf0gWPj9CqNEwBTrCReIJKNHDxt2Q48S350PitA1jzl4gdz9JeP+uCGL/2ptV2YRVvuEC/ooZMxYinhvlNKJ8JjrpaBB6gvq3fruEIDtDprRwrsHcw00n3SXN3sgb/agjueR9tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYIHxYM3+t9t8361aK6P4wM6ju7ZPrLljLi48mVaLNo=;
 b=Xa/nsQa9ssNddHOcihIdIfG3C4PDzMIbU4oCv5bafQTVKUTRsLD3+XexcNBB3bG3eUYipLayW+pdYn5vIi9NVrKS+UA3hLCE4RaO0/qmYlQfQAWeXAbEtFeirjea+YsDrE/+KsLMQbxLo36DUvcxemuVFJVhP4Fwi4P3vhU56tqgaZ9R6CRfw94JzbwJIiUh3KZmqW5lKgD0sytTGaYDbMWLkoO/3ICLyQEMIEr4oRlFrOjfqwH5+6WnvBFjIOPnU8NgT0/WOKucJOlORj3NMWpT7mRfCdeJljJp2RapV0Qb7P7efX8kYgNRypQvQNVRbfnVkmFGYzMTvmntlW/fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 22:06:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:06:24 +0000
Message-ID: <1c64d64f-23c6-4efa-80d4-e39fdaf16280@intel.com>
Date: Wed, 14 Feb 2024 14:06:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 9/9] ionic: implement xdp frags support
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-10-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-10-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7ea100-fa6a-4c02-0c75-08dc2da92f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMZzGmOsgaIM9PyThTll1BY+k9u7+EdX237Jy6SONcWzrwvQxAc11ngXBQMhrtzuD5tz1/KJalXIXJqR/QL90rXxr8nau+dsHU4cyKaUHonVbiVFFO0UAGeQ3DR9BjP6PfV41jp3Owd+dKoxh2uI8ufXEVAGg3WS3vup4pzVQbxQMEbJvc6uPLqF77w4GOInPno6TPEVhnQGwrY2zp1o3uADh79Rw+aIkBvdacELRZ19J5P0NAc45J1WCxm//I//o/gfsPhX7zZaFR0VNnCQsPXsk6R7jP4NbkQHm7tUyjRVc1vCucOt6kd7KfEESq8J9Abd84lvsUWn0kTNHH792fPdahwgTHUv+HK940mEINAtPSgX2HjoXzZQd2br97vbPhUZbKDsE+aZ+I3dIteePQdW2Jii/LXwpY7k4gx9B2uGcp4CEcSyQQsEcGPDKYTxQQzqHzEcfh5nnzix7E7fBpkOwW2dGtRJKIGB+yAFuP1YxgFMrw2WsubE2aCM9UmO4at9d/9mGL0Oogrhu47oHFTRcWiJBedAkKxTwjpwp20V7EA0tNCtzc0n6A6Ch1wM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(2616005)(82960400001)(41300700001)(38100700002)(4326008)(4744005)(8676002)(5660300002)(8936002)(66556008)(66476007)(66946007)(2906002)(6486002)(6512007)(478600001)(6506007)(316002)(53546011)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RJcWxWVFAwY3U5OTFWKzR5WTV6Qk50MGRyUFhtN2NJdTU3L1RsZC82OXll?=
 =?utf-8?B?WVlzRG9MOFZkTmRmS1ZhMCtFWWZHL2lTK1ltUHUzcitUMUdicEZMT1Q0S3hr?=
 =?utf-8?B?YkNFL1Fhd0NrUUdzaGRXUVB3UTZhMGtWMjBJUDZkL3NYMC8yUjFGVktES0w3?=
 =?utf-8?B?L1pOMHVhdjlpODZSZjhEdnh1SXNJTmIvUmtDZ1prZDFEbFNTbGxzZ0UwR1FQ?=
 =?utf-8?B?M0d3cVBRY0I0OEdRTGUvaGNWRWhjRk9NSTR4eVpnWW0wT3NVV3lxSTdiMU1u?=
 =?utf-8?B?bWkwWUM0VjdjdkYwVDdsRWZGajBES0pMYS9Qamo1NFZ1NlZlSlE1ZndvOTNX?=
 =?utf-8?B?cnQ4NFRjb05KUHlXRS9KbElLT2pHa0duYklzMExVQXJCUkY0eFFSQjd2a3E5?=
 =?utf-8?B?TkQvTXIyend6c09LU3RMMzNnUzhuNUpXK2pQL3ZacFJFVVhBVTVNZDVGbmlO?=
 =?utf-8?B?VVZHb21KZ0JQK3dkdVVBckdYZDNaZTkvTXZKMlRSVDlpdXFKdUx0c0gwUTEy?=
 =?utf-8?B?K0hwY2xqYzg0dGRXbkJtRFU4RXJTUzhQTEFnUEVsQzhYRmdkV2w4NmMyTVZ0?=
 =?utf-8?B?TTRVUXBqaTNadWs5R3ZsZ3hJZXJkUGVIbHhRRW5aRFdKbzQ1Tmk0VVBaMW96?=
 =?utf-8?B?Y2JHcDVXRlVhaExtN05xZ3VxRjFpVy96YkJ5UkpSaTBVUzBiNHU0WDUwSUZ5?=
 =?utf-8?B?dkdvZlFoUlphM05BSm54blh2c2xvT2NQc0xDa0hkWXdwWEpsZzlDUDBBOG5t?=
 =?utf-8?B?bE9YRTFLUCtjTEFpNWVqbFBuMkdVSTRQNTdDYXhGSG93SFZoNVVmVDkzR2U2?=
 =?utf-8?B?clpKVGNGVnlZU0ZROFQ3V2Y0dWRRaWIxK0hyL2NWaWlXVUF3WjFHRDZac0RK?=
 =?utf-8?B?VVFPUTZBMkdmVFViTDNYVTB4TkFpNmUyNU0rVXhnMVhJak9KMXRMYkxMb3RL?=
 =?utf-8?B?aEpiWkdLSWxzTTUrNHI5TVdpM3NSRURUTzM4N2VtSmdZVkNqSDN0MXZQcktQ?=
 =?utf-8?B?YWxRRmR0ZXVyQXkvRk1qTStSVk4yTCs0YU1RT1pST0JvUTQ3bkF4QklxOXhT?=
 =?utf-8?B?cllNcFBUY2tqZGc5OGNSSktubkVVN244Z0xhMWhJSFRDNEZQMll3NkpvRURD?=
 =?utf-8?B?UXFPWExuRkhsdU84L0xReG1jWDV0OHRISldIU3pqMWt0bjJPdHRqQVcvWjZH?=
 =?utf-8?B?c1llNkZ2VXhOdWFQa25HUzlVMUsvTmhlN2VFaHNlNnhWR0tjK0NxQUpYbnBR?=
 =?utf-8?B?YWJoZzR1YnorQWozNENJdnB2ZDhrdEYvb212d3pPL3RqMUlvdkF3TGRpaHpa?=
 =?utf-8?B?NkJnSnQ5TytIZ2Z4UVFlb2Z4MDI2SHhhS3pyVWhkbDNEN2d3c1RmbEtXdGhR?=
 =?utf-8?B?QStLOVRkZVk1VW51TWtDcjVSRTVwNDRzcytkbEZBMjVPV0hrc2oyOFJkTjZ0?=
 =?utf-8?B?NFRpUWVEMUtkYkRONS9FNkZnTW1sUzlYOTRLcXJmMlg0M2ZZTCtlQkVIVUhD?=
 =?utf-8?B?ZTFqMXRNRDZXblR5ZGdRUHJWMmRVQXdpQWU3R3NFTldBKzN2ZkNBMktDQXM5?=
 =?utf-8?B?UHlDeEVLUHd3eXN6REpQdnlWeDIwSUtZY0Z4T0FhaDg0RTNRd1d3dHZ4SlNt?=
 =?utf-8?B?blpvenJIS1V4NHVmY2F1M1B6cytyMG1ScGJQVVZwTGtQTFBybm40VTdiYmE1?=
 =?utf-8?B?ZmJyeWxCTVdJcXdjSXFFR3ZKdE5pU1ZtQWplaE5RdDFJeldFQ1IyakZGSVlP?=
 =?utf-8?B?NTh1TVVkTVlYQmVhYjZ1L3ZTVXBDQk5tSVRjdC9EY3VkSVg1aGk2RnNMc0tR?=
 =?utf-8?B?V2JKWXAxV1MvczhxR1RjTUJBRi9UL09heEUxRE10WGt1ZkhVSStiTzBoL25N?=
 =?utf-8?B?UWpldkx1QWptaEU2ckROSTJiQjhmMXZ0WWduSmxGSVdXSWxjbEgvNjl3NVJD?=
 =?utf-8?B?SzZoeHBCQm96NXRPUEdEa0g4WGN4ZUJZRk9EU2JiZTdjeEJqeHZJN1V3bEtC?=
 =?utf-8?B?VFJUaXkrT1pZWWNqempYT1IzRFpoUkxMUldmNXBWREU2QTVWaG1xdUJISXJ4?=
 =?utf-8?B?WlJuYzlQa0ZHK0xtWmRwV0pvODJNbG81Rk8zVmZzWFJlcHhFa1JoaXdET3g1?=
 =?utf-8?B?UjBpL3lvK3JXOTNWOEUrMDJScmMwZzNKYmhTYnp2QkpQbGgzb2g3YkltaHh5?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7ea100-fa6a-4c02-0c75-08dc2da92f15
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:06:24.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JunvUAMYvjB18wKD6bDpzaE/kee7bJbCYHjL5G/ZJ1AHW5Y5tE+TQD77YPmelM0Rk2BvkPQwdH5RLan6UurQAy2sRMnNPcjFIZCOUwTfzP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> Add support for using scatter-gather / frags in XDP in both
> Rx and Tx paths.
> 
> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

