Return-Path: <netdev+bounces-48193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0C7ED1E5
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D102FB20D89
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA341E4E;
	Wed, 15 Nov 2023 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaZkrHmn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB0B8
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079501; x=1731615501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8o5di9LydHdmFkv0XHjF0AUihHz7oFG1oKRQ4sWCt8g=;
  b=gaZkrHmnV6XQjhsDfb6aIty2ORlQJjn8DlOoIZVD8K4wPz4ErV2/VtZS
   9Jkm0iSmIZilRQiM+mxgq60M1h9X4izNiYa10djbGZhMIbgSVprmAuVNT
   OkIklFowXSlmlmS5E4ZvIj9/f230P19ULkTG3fab7B8jQ9iCqpGFs69uM
   VdBv5d5V9eEGPiHwVeY5mH9XIv3g6EJAWduBFF6aynH32QLyWrsn4aMjd
   /dRXRI0bWNzgaKMQw0G2Jxv6pKcMJuFBc+/ufAMrsIMuMY3SzPehV6TQC
   fq1htoGytgEIYn+7HndfokfCHbbh4X1/SVfTK+gbUfdfJqg5cZ2dw2vkX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375988529"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="375988529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012375405"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="1012375405"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:18:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:18:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:18:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:18:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:18:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckTOIfc7JkTLIcLhoSgHG6jQhQ0QZ7V9pZqfsM2n4X2eckdJpUT3U8yxmi5IkkN/iT/vsnvN2RVxWEF8X/3GtUkgmVDStv477NN6gP/mHxZ7JccGV4nWh7Izpx/56mX5bcxv4sArTBB72dNR0gXNm4CvizG0T03JXClBnI6U8I5rIvgUVntE0GWAz6DkBZyNxkUvBk3y4KWAHXWeSkgk9oOsWqrnamsfNYtL8F65a1WJmq6QY6qXB23LAfE1kxfFAfpPlviTKF6PMJ+t3bn2bC4e/YEqyXQGp99ZgJ8i2I9qaShapkbQNtczrtOvSVUT44jr10BB5pwbVED2lcmzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=551Ni5xIEg1ohvGwCOIciK/SbRXZoKpuqZkt1k699aU=;
 b=mIpyUlTdiZk7lP3YVjX7aijyP/CEJGS7Yxha9EYr+P5wGsXUwo2OBRhxp7xl0pRXde57a+8CBk5YYQlh3Nxalo0lMfmYs7cqnTkO3kdj8dGVHeNkwmn+76MkNWNyDwxlo7MRW2vDNKjCXBk2VOU5qPOs/DHLRQYi6ZBgaarKpi3VRocCJd22sFL+/LdBanUbfIh4Rwu0cpvZuMAuWsTUnSyZNoHhhvPa+FONCr/OIojGT2W7Be1N7BaYYbvNI+Hz84KbpZr+5U1y0e2kWCN58sie1PZrz3/4XyrcFOtfrQ8aukRKaH+SyW/S7Sb95CE6gg1Y3q9p+dbwR4PAn6qO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 20:18:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 20:18:12 +0000
Message-ID: <a2d8d014-8253-4793-a97b-5b8ada082807@intel.com>
Date: Wed, 15 Nov 2023 12:18:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 4/8] devlink: introduce a helper for netlink
 multicast send
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-5-jiri@resnulli.us>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231115141724.411507-5-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ce38e7-cc65-4eb0-3be5-08dbe617fdd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzC4d787RKf8ppuwLa73+7lAu7aYB1NLeOUs9mtNmaozjYdFf3GR+V3nlTGMDt9amjMuGJ1YXujdR/xXcVLS8OnhWkZVbl/2QwgHiWEj2Aew4e5G6QkteZs2FLtFQTD/wNgVR7MKzCC9pahq2WgrcipJmutdGQCM0+kUInEeUzWVVz7aIMlAAD/oGi3TjRk0liRdFysOm8O8RIvEEax2+9jPUyE6u3AMySFU1lJVsyrMNAdZ3n0vVvOsq41rbbS4hLhjKLKBF9IFf3IJrtPQ7ToHB1l7P51RLg/QGJi3miS2jk8DdA6S7+kGrtDGnbo4L7xpJ03muODrRzVoYfxGlEYtP6CqVoq9IEtRvje5BzscXvBod81fnJ67D71s4DsNlFVIuVOnJ9cBYUnfKv0kbwEVSWBn1LpQwxKNN09Wi8CyvN0hv+oRq9vZYjaiv6SGUmdi+WnmENhvlSy3zEGV/LTYNsZTRY00ZsCW1P7H91ivvVKJKxHuVh3IDrpRvSUr8JuLUroQQMoUg9IA0VdbofJRlxciFr4w2dsD9tE8MZoyeH/PjrvCHYVUurb6tsSpz7eIxP//EQAsvyxYVxNdWWF0utanGHYDMsI7NJZFlzmDflKeu7meSRIqjK2bJUTeyOL5Guyyth77ogt9DmEq6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(4744005)(2906002)(7416002)(5660300002)(478600001)(83380400001)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(36756003)(6512007)(86362001)(316002)(38100700002)(41300700001)(31696002)(53546011)(2616005)(6486002)(6506007)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQrZWMxSE9MZ3BOelBCTkszK2dsTUtYQWtlMS9COVJnLytnUmNFeDRpbVRC?=
 =?utf-8?B?Q2VQVEdSMWQxOHIzaS9iY2xtaVdQS1VXRzA4ckpVZ0dqTkYvV29HaHVCM25R?=
 =?utf-8?B?UGQ4TEE4SXpYdlJsaUJ6UjU0NndQTStnNGhrMGs0NTZCSW4yV2xYcG14RlJZ?=
 =?utf-8?B?YTNYNW9QRUY0Z0phUm1kQkpIMkx0YUJ0MUpBNW5CNHRCMzZYSEc4VW03dE40?=
 =?utf-8?B?a2ZvS1FXeVlldkNwbG1uNmpmeWVhUEhmamNWMzF2cUt1dkdhbVVwSnpNUnlD?=
 =?utf-8?B?NERMMWNhd3ZjYy8rTytML1JaVGVDbFpVTHlBQnZHRHNGZkFaUlc5NWRqa3Y4?=
 =?utf-8?B?UnpBanZ3UjdVcXRsTjBzYml2WjFLT3ZvaGl3NDk1Uitqc3BPdm1oRkwwTzRX?=
 =?utf-8?B?TzllbW9CZ1lJNjEvRjZCaDNjU3AyYURjM3ZONjZDamRNNXZsZHpaQVR3NkhL?=
 =?utf-8?B?SGhGZWowVXhoMHBkT0RMM2IrLytLSTh6cVF4MHNRckRpM3RKZDM4Rnp4MTVM?=
 =?utf-8?B?c0RUQmJQZFR4dUh0MnJSRDA4U3V5NjdPNHFWQm55OTU5SFRwYjFMVFVnQ21T?=
 =?utf-8?B?MW9wSGZzeWpCdzRIOXowYXZXQUE4bDhyb0NmMDQrbGhKcUtWbkdGZDlOTm14?=
 =?utf-8?B?azVpZTc5Q1lsVnZFQmYrMDVZSVhlclNvLzdJM2VxaXRQTlBQSTB4Z2xNZnBX?=
 =?utf-8?B?RU9Jbm5XUVlibWVJN2tsenRLUEFPcXc0b2dKaTVsZ09WVWNOanVUOGFuemI2?=
 =?utf-8?B?UiszRHRmOTVUZENJckxhNTZNMFRZSDZMSVNIUE5ZWFFGWmlvekJ4RTFvUTJq?=
 =?utf-8?B?R0ZzaTFzYVZwN05ZSmVUckpXaHdaYk5LcndPOHc5bWxYNDgyV3BVL0IyS2Ex?=
 =?utf-8?B?ZHVrZ2ttU2wzdnp5RjRIeWhlWjZBazVUZnprb1dGdm1XbWNJc013MnM3NUg2?=
 =?utf-8?B?V3M4OEJxdXhvbUFUSWMwYmRZb0t4eFFxTzY1Nkk0MUQ1eVBsVDFnK1NjNnNo?=
 =?utf-8?B?NUlPRWVQd1UxQVlMM0U1K0gyUzNoQytML01LUEpqRzZmQzg5Q3UvVXczalps?=
 =?utf-8?B?ZVhERVZSZERWWk9aVnhiaFB1U2RpOVR1a01ySzNCVmV1Wlc4MDBOVFFnZkJq?=
 =?utf-8?B?Z1MwaWtRQ2FXRjI2QlJMeVdmZHBLSGltRk1DY2tWclpmNnRkQWNJRDZSS1Ez?=
 =?utf-8?B?WmJPTnFxYVBkOXdXR3hjRUppSTIrWWhaNGp6RVJkY1ZsZ1ZwYVR6cXU3eUJN?=
 =?utf-8?B?UU11UW5xa2hXeVp4THo4RUtENmpmR0xzTE1iWmhjSS82NFNQRVNRUGRpWWts?=
 =?utf-8?B?bFFnTjdVNGpRZXlKVzNudnJMRklqUGVuUmVTbThTNWdiRWhMcnAzYmpFVnlL?=
 =?utf-8?B?Sjc3cGZVcDQwNHNYNjdsd1lUc0NqcG02dkFnakRReFRwT2lzTTNXTFNyVWdN?=
 =?utf-8?B?VDMxaHNpSitNWkhVTU5vRHVlRWJVY3RESXZCclhuSDZkbjdiWTFldEkrdkly?=
 =?utf-8?B?clVqN3N1OStkMnRqbEZQeU1RN1RoSWs5b1dSOUVKcC80RXhNbGlBSEhETmFv?=
 =?utf-8?B?d3pzaytQS3ZVNysxaHJNb0NwUjlNdXlHanhVMkVLK0I4TUNpYittNG8xTWNG?=
 =?utf-8?B?ME9TU3Rid2ZLbDVkOHFFQTFpcjZEc2g1MW9hcHdqWGVaQ01VaHBIQ1hUeDk5?=
 =?utf-8?B?ODdXTXdQKzh2eXhyc0VMR25VWitjTE5YYUpTOVBEaERLbXZCWE9pd3JacEVZ?=
 =?utf-8?B?WTgxdStnRmkyVVdwY0lrRE9INHNEWk5qdlhhV0xJeHIxbnFNNGx2RWYyNURm?=
 =?utf-8?B?MVFpT1hBaktuOUpxUFNiRjhJZFJJQTlPQ3U1Z3UrelVudG9zOVZpaUljMWxW?=
 =?utf-8?B?dTkyUld1c2NCRkIyUDQrTXROclJRZUlZNGhjRTJYNFE1TmduMXl5TC9zdGgx?=
 =?utf-8?B?cU1yTEM1SHl1ajYrcWNWelVtMlcyUXJEL3dXd2hWSDVIZTVmNUxhT2E2eDAv?=
 =?utf-8?B?TUNPR3pRNGlSYXgwbk5iUUpmcmErZVpDcEtvbExHSGtEWlVXMEFnQnNldWhO?=
 =?utf-8?B?WXprQlh2a1FFeGlvblVGeEY0bHpJTGxFMmZ5MS9FdkdDZEYrQ1owNllYTGdT?=
 =?utf-8?B?cjMrdnI4ZFUxRkN5K3ozeFJoek1hSytmVytCY0ZDZTZsUnp2bUtOODV3YktR?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ce38e7-cc65-4eb0-3be5-08dbe617fdd6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:18:12.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wpa0HcyrNMZyBrF0KHkBXFM9WXWG5ELrJau3giAjoG3Yf2K4Jn+SniRpeYiFdceoxGIwF0wLz4NLgNwXGkuaXOzA4h+VqrTvjCl7ohjicbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com



On 11/15/2023 6:17 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce a helper devlink_nl_notify_send() so each object notification
> function does not have to call genlmsg_multicast_netns() with the same
> arguments.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Nice.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

