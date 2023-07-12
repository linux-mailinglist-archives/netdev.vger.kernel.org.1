Return-Path: <netdev+bounces-17296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3910B7511AA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9EE1C2102D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FC2418F;
	Wed, 12 Jul 2023 20:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91D24176
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:09:44 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F31991
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689192583; x=1720728583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=caj5sT5phFtOQcnqwWzYtWdN43iKftKIAUmrmnBp02A=;
  b=J7Of0jcJjic8V+KyzQBSEpBVOdEXvDimZS41onvEKY3+QA2kG6Gqa1on
   kr0dl+r7EWWLSnvkVBxPERfdaBxf9qd8srAnQkx2NLMSA/acLjH4MPcyK
   9byu9ioFeeXiGRU5yaDxvdkKvfz+JbbHBwAxQeNKKzK98FlTsiGxAe+HN
   qFUgeERfBYU9m+OM6zAWw59bo5G6ZbEpPy37zU+9sdCUfEsrBDW46yFDC
   PPLevgsSXy6MHBVSDh+lIGRnhPHlYnlv+HFt893OyYvHYLXM0vd0asIko
   n23wK9sF5849JB/0V0ZLtryLhMUf9HnDWtvZZOUuUvFCfCbHtYouRGdFw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="345305179"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="345305179"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866265402"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866265402"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 13:09:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:09:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 13:09:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 13:09:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 13:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiZWx9+EJ/IYpzOhie4zv5Zti/lWvAzY/1xHuTkQIRyMFGGmhOlUagaGhi8P/xTmjY/ZRMth4TcsK9jUyPRAszmHm+nv3tB1kKkQRtUMLHzplgqmCmyyIkBWdAlpx3EWMRcRHLpKg/z3yLX7prMwVqmVEK2kPBbtiOQWSWWsQ6Bm21Oin4gERHZ72mucrGkY9D41VJmD1AYAsRcLgtQHTTzANVT8Dj+9EFk5D5nw0ui9I+Ir3x2DWDjnTpep6EVfcf6dl0xddIDbiw+sfS1Oxmp+d4/Nc/UTDj6BaC66bM/b45B/pPiKa07guZiSneibwyB85KzJkqkxJ6Tmiwy9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDy6lr1k6iG9PnjJoFmymEgJ6hv5Df9A8qLxkoUquOY=;
 b=dDdlO495SVvZywHGERhOlLqyMfjzrUIwgTvGYubyG6XVTNnEcP8fFduX3EkD/H8eYd0vKNVuA1dIOC5pDIYJTmxAE6ojSbyrp2AWR8yum6QcNpXaFCq+fXWnO2Z8MzEZKnngmpbe6wALWanJ0BmoDwFtfPdHxq0DlLiVcpv4ET4izvxOCqZ6+TtojmxsOA6/LClNcllxdQR78NBfHqA2/Z8Y/XoRCMLcUPTHcUfUGHn8RuI7uQPGKIOM2UNKLELsZe3LZRccoXTr7Qm5SolKynl4qpMmuofTTztObcnr8b40hJCZwkE7t+YJDbFwz263do/WbDtUCRk/pAcbCZP3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Wed, 12 Jul 2023 20:09:39 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 20:09:39 +0000
Message-ID: <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
Date: Wed, 12 Jul 2023 13:09:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
 <20230602230635.773b8f87@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230602230635.773b8f87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: c9151ca7-fd7b-4840-0c5c-08db8313ebf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXSSx5RtFZxZg6wPZocgNGHdSSexx/aTgdOGsLiaEL8lwuvW/FGY9MPNbBYj8bpmRFN7lM9XfKMQ0OIBlSxIM1pfmDeqUiPLCSffPhoAPUK/IhxW5HoIJWUjxH/vFyTmcP437GDyYm95CkkfAwItm/r5EvoFRB0+ouYqLtOGsKkCTQ1owt6C2tPObHjIaNrwy82zdiq+B38aBktuUvKzUvkdYz4addGgTlX4jd4mReUQyuUmWxE2N2n+/3Dfl/2PRgyL0zz7ysfSOgCdONtvVfvsBNSDDaFY0A8V+qXnfFGKOfW0eCoyoJSh47sDQzIoGk+kCtzynjoUS7/ySrVUSKNxFpqdKNuB3tLbjHxjtb/gdeX+O2mlGLTIF/4xkhLnZZsZgRszqzIKnbu/ulUxuUDsypEXBmcE8Znb2pksQ6BCpcykN2RmudBX0J2iLLOS3pUkxujHCTM2oZNGMb6XdmSFOLrkk5KXy6gV3hYe+2Q4qINbnd48V4eA2YiXbrYFkh/YDqXRBJDSSRQRxEWSxEE2nm1iw3LmSKJyOL1BsIvWfXNWvfNi3jrIojEvOZ0ykq20kIzVzO0tE2ygB+P0oJlwZY2b9GvCOcNMg8LHUuNEDVRB37kbMJBNq/qDOg/FI3dsFV9w7KB8LuxmP9YIvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6666004)(6486002)(478600001)(2616005)(26005)(6506007)(186003)(53546011)(6512007)(107886003)(36756003)(316002)(2906002)(38100700002)(41300700001)(82960400001)(4326008)(66476007)(66556008)(66946007)(6916009)(8936002)(86362001)(31696002)(8676002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJ4aVB5RVZzV1JkVTkvSGU1YXRncCsxZ0Y4UE15bGJVbENyVG5YRDdQa3ph?=
 =?utf-8?B?V2tDaitPVVVGSW9CUVU4RHNhM2Q1Wk45MWwzZ0Q5QmtJTWxCVFN1b01Xb1k2?=
 =?utf-8?B?L3NKaVRlTU0vWVlMMkhjSW1iRmxGbUhNTUQ3TXlsOHZUZWF6ajlNc2tkUmtl?=
 =?utf-8?B?ZTA2M2JQam1MNHNzTnRzMFFjUzVEdWVsd3BTMnl0Q0Z2SEFzVlJkQ0dITWRt?=
 =?utf-8?B?VWFVRUtBbE9Mb1YzMUt0b1hEd0U1M0lNd1g0aWhBZFJnaW96VnQvSmtlZlhT?=
 =?utf-8?B?d0FNbTFMcmpCb3NsMEM0TmxaT1pSaWlnQ29BQ2VkTWJPOER1Z3ZXbXBsVjFa?=
 =?utf-8?B?a0FyRmwyVWtVdVFpRVkraGxsZ3lIS2JmVUNLcTZ5TmdWdFpvSVJydHlTTzJk?=
 =?utf-8?B?VDJMM05yN2pPdkY1V0VwVHVSNlZmWWNZN1Y2bHhRVmkwQTJEZGIyVm1YcnpC?=
 =?utf-8?B?RkFnd3cyV01oOE9rdDViYXR0YWtURHdkU2RFZFV2S1dCRlZoT1I1ZGtjYlpk?=
 =?utf-8?B?ZFkxTzg1MTdPYTV6dW4rNVlBRCtHYzYxbnBKR3dUYUphUVo2KzB6Q01iQmhO?=
 =?utf-8?B?U1hMQjRlOGhNdnUwd3c5cStseG01cjVEODVEcVRUUGw0NDFmNTQzMmdKUDV0?=
 =?utf-8?B?Yld2YVZ6RUFxTFNJTDBucUVyMUhDV21idFpSeEswRHpOYWFTMnFVN29UVVNr?=
 =?utf-8?B?TjJQaHA4Sis5TGZQM090SXNXOXNxMFk2TStCdHZpSURpTnVJQ1VWM1h2eDdO?=
 =?utf-8?B?L0I1QkJWYTJPeHhKdkV2RlY2ZlVMb3haeVVOVHlSUzRQTjV0SlplMkxiTGVa?=
 =?utf-8?B?REllQ05TZGhvN2kvdHRUU2N6OStWNE9RQ1R6cTloZ3VPQlRLRkZHWHVNYTgz?=
 =?utf-8?B?Nmhyd2Vnd3Y1dDg2MHIzRjROM0tHWjhSd3ZTSGM1akRWYnZhbkNmQzl6dE1a?=
 =?utf-8?B?MWlaTlhHZVpYNGFCUjJURjFydFJDQ1BoK3EzSmVJS3ZWYXR4c0h4Mk5JZ2xa?=
 =?utf-8?B?TGpXcDNBeGQ3YnBnOUpscSs1c2RmQWhoR3dXTGpRb3RZUURlb3pSMEFiY1hu?=
 =?utf-8?B?cTQ5T2JrM1RyaHQrL2dsdDFYQmpzb20wd3Y4UDdrdXFXWjJnSHArMi9sOWVz?=
 =?utf-8?B?R0YybW50OFlMcUgwRlZuNE1XNmdIVlZwM2QyMmQxZSs5TWlRYVZDTGRtUGFV?=
 =?utf-8?B?MzJGci9ZdjY0NlRVaHBzTXRBWHF1MzVzZjBibGZYZ09pVDJibUUzTkRGSklB?=
 =?utf-8?B?ZWdjcW1pdEJ6VHFsSW50WndIMFFhdU9PaXZpMHM1U3Btc0FVM21DTGxCNUlB?=
 =?utf-8?B?cjJDOVBRaTgxa1VvSzlpUHpvNDV4bUxzUjJKUUphakU0TWRrTVhpRGIvYWhS?=
 =?utf-8?B?UzAraVlNenY5TGNod21zUW9RMUptMzV0Q2pLUFNsMEZFdVpkbnJqR29JQ1Jm?=
 =?utf-8?B?anVsZE91VG1YcmtjeXc4aU9xdFowU2xqSzNHdHZlZzdsZlRvZnJXMUNLdlNh?=
 =?utf-8?B?b2FwMTdDVW5rOEJDS042WXRLZUlkQnlaWlQvSGtSTmwxRXMxWEZpNEwzYkIr?=
 =?utf-8?B?Q21GQzhudjhTZjc5NTVrRmkwdUVlTi9oWVFFcExxekdqdGNJMGcrem9WdTlC?=
 =?utf-8?B?b2c3MzkrREdxZ3hJbENDUVRkbU5MdExIWDhaSFR3bklIZjc3UXNsc3Ewcjc2?=
 =?utf-8?B?K2NGQ3ZSdnc2NldJVFhvM0dZeEMwYTVMYlBZa2R0M2VLV25ENUdBY3l1eWxI?=
 =?utf-8?B?emZnby9RWmhQelZGMXdMOWZtTVoxUUtXaG9rNkFmVkZENGs0OTk3ci85Q1py?=
 =?utf-8?B?SnNNRGZ5RE5mNmJjYzFEbWYrZk5JS3AyWExOMjBxMzZUUDVrTy9PTDZqN3Vh?=
 =?utf-8?B?ZU9NWWdHaGhFSEpoMWNOL3JSTWdablBHWmErREVLblFJR3dHVG4vMGtoTlVL?=
 =?utf-8?B?ck1rd0kxM3R3amN2dEZqT2g4M0UzOEVYUk9Ldm5tVmhDdEttN0RXY0x1WjJm?=
 =?utf-8?B?Mmd5a25RbFJxWVZsVXlFcUthdmw0NHNBSnpDOG01bWdEbERrbEYwQm9QbmhH?=
 =?utf-8?B?WGcwUVFCQmpweXB3SE01ZkZaNTlxNThVeW5rdSsrTEdTemRUS0hzNThzVnox?=
 =?utf-8?B?STFVYmtaZ0xucW9vMGcxRmRMMmJQRkpiZFo5aWlkWHhBckNqRUhaem1Od000?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9151ca7-fd7b-4840-0c5c-08db8313ebf5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:09:39.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9Uv+nWn/bT6T+WgPs64l63lFZNMXAJ6hlGvxDmmgcw+d3nXM+c9I2U0TzpwaZpPlI9P73z8sJwl/NHzAdD3kjZuRJzJRqva57aYgPtciow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 11:06 PM, Jakub Kicinski wrote:
> On Thu, 01 Jun 2023 10:42:25 -0700 Amritha Nambiar wrote:
>> Introduce new napi fields 'napi_rxq_list' and 'napi_txq_list'
>> for rx and tx queue set associated with the napi and
>> initialize them. Handle their removal as well.
>>
>> This enables a mapping of each napi instance with the
>> queue/queue-set on the corresponding irq line.
> 
> Wouldn't it be easier to store the NAPI instance pointer in the queue?
> That way we don't have to allocate memory.
> 

Could you please elaborate on this so I have more clarity ? Are you 
suggesting that there's a way to avoid maintaining the list of queues in 
the napi struct?

The idea was for netdev-genl to extract information out of 
netdev->napi_list->napi. For tracking queues, we build a linked list of 
queues for the napi and store it in the napi_struct. This would also 
enable updating the napi<->queue[s] association (later with the 'set' 
command), i.e. remove the queue[s] from the existing napi instance that 
it is currently associated with and map with the new napi instance, by 
simply deleting from one list and adding to the new list.

