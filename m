Return-Path: <netdev+bounces-17324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF975142C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4EF1C210A1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810B1D2F3;
	Wed, 12 Jul 2023 23:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B11D2E2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:12:05 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34C1BC1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203522; x=1720739522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2FKSwFqaiILLnOyZ/ZT/w25/rBsuBzSd1XOGwh8QmhI=;
  b=QmQOWXmU4gHgB2fTkZ9O2yc+JfZTy1riITF/bg5Y+dt7jXd4Z2JOOgE7
   LQteIWpqj6B4iMkciPL3ARZyCPfvNq2zmuslaxWP2xgEgGUSZ7/tmD4dE
   MJSdWBZB1Vvp4VePrkF+aAFuuJDjEQM7kpBLUAXzQ9Pkgw4g6Qp5AdpHc
   +V7QaustpOuLhwCrGDvhYrsDwe0RHHi9+m7aQ3BSMMDZcdHBHVk1apznA
   DHFbua2cRUq6jZDryagN0YlOBd3BGke1p9fBdp8+OL3hvSU2XDaRrOeG5
   Nru495ZU7arWu7zHxUwKWZCelVsu04ZombtCUcUzxJP+Ua47RAvVbP3km
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354943180"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="354943180"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725060845"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="725060845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 16:12:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 16:12:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 16:12:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 16:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkpVjVqhhSjbWzWWItmbCoYMx9ajWDJXBO4XPoJORmNPnMKtqa4IM2yJIKdWCfo3GMtWzhMVLkuT+Yw+1FZEtlqBycmFvQDSgrry55LH64HudQRmvp7oEOmQ4LVDyF82joRngx/JSZCe7iRCbe1c0qeUefBNFZR2g62FcFG1ttCOHL0DUti703uwwPhPYnzbAVl7mrC/Vni7qC94lPpy0UC3T+vvj10pBw+o0zvlKbPwGaHKXpf8LxYaMQINK2fQLBtpZJ+jK+2P7mycPGqYrbU1J4ulQ/DcCK24sb/tyO7o9WdfsH/GXhcDUgmtNZxzIA0gCMYLrPPjQqH6yS2+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeKYsXtYy7tDdiSCFSSzSiJBjVxPJV2EeRE3jgK+c14=;
 b=Ux4zqH4rMJydQEutjQJulvbAXQSOeZ/915IeaQnNBZftl2Tr+dP847Yw4Lad+y9lzq7ctQqxrpnDm1/hQN7htYz++wXCG5O+pxz9GkfqF5fjxd6INl14CJP3lxtc6vbKlxrYbAceM3/6soaJJwLGlYh3FKqHlW2yPdLLW2/BRP014JeagVALunrxlnUhy24ruZFCBylTPhcGGFnu/BFyF2h2k/7SOCmUvhsIwPSxFhs4bCy0CF2H5sGHSKrOCq2Mjx785j/ZI+QVBUYL5oh1kvGuNOdUomcwv05kjarVmbB94KzII5VbxKdueqqmFBO4rIapgo3lwc6c1rG4/bbYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 23:12:00 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 23:11:59 +0000
Message-ID: <4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
Date: Wed, 12 Jul 2023 16:11:55 -0700
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
 <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
 <20230712141442.44989fa7@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230712141442.44989fa7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 272a41d3-edaa-4fda-b79f-08db832d6497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXNmfku+AIFHMD62tHPPIT/9oR/1uyLF1rqPpPoPMC1Y8cVHUlrddF0Cu4vPPPZBOw0hYAnZE5eha5LA3V6T12mm5KFqWPJ+86qxhf9JgqlDQqV2PsAI3dteDHQrmDuYD6UNtPn2BhAUbhKOmfzNvCN2NX1Go4QyhNKIP+ukou6k6kiLwlJxGHChu9Yln024z2niTk5ZZcVvgJOYeIF27yjSFSNaksnQtqITKNifodVokaplOuCdmtFnAu2Nht5WK5ULA9UJ2ezGXp5mUqezl5h60AkgF9Jnu9MENaRqa6UJMbthxCUsUGy/INVFt1++m5h4UGYcTekqhG7zP7tYwdZfPxWeLqhlDkzb2tj7EBKNW1cUpMox6lentGOuiDULl3zUHUscFKCNvJtuNOQLtHW/kDLAlGljPGX+A8Dhe8JA5lLo7RmHM+Da0JUcpBhzYuZ8BLJ893L42XwY5U5rgyXe+O4GHunqgI/Qto3wBXeM6pIZ99qXUBJ5SE8PBNn/1bJeXCkIEk3mVDZCzAhLKJ7Zu5hdBc/Q0vf5wKmTC78q9HeQrWtqvJ6/KqXQAPiKTB9sTyIEofhFP0e2BUdhAC0vdvnlXLAwQ7SZ6SRb3Fmzi8HVS5DWNZBYnrgHO7maoTCPce3ZXIWaE3UDXAIY+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(86362001)(38100700002)(31696002)(82960400001)(31686004)(36756003)(6666004)(6486002)(107886003)(53546011)(66946007)(26005)(6512007)(186003)(6506007)(2616005)(2906002)(66556008)(316002)(8936002)(4326008)(478600001)(5660300002)(66476007)(8676002)(6916009)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFMyTDExWVRqYk4yNnpIN0g5VFhtRk9GdndDamkwZnVmNFFOR1pORExlWmFK?=
 =?utf-8?B?RUJPakFwWjc4eDE5SXVQSGdybk1MeU14bFBVZlhQQ295aFVsbzNyUnZDVG5O?=
 =?utf-8?B?NGVQWmdBaTdvYS9salFHeVNuRktDSTBLVHRTa0hpQTdMci9TcktvdkU0V3l1?=
 =?utf-8?B?SEVpVWloOTlqM21raWVvS1Znd2FGT0JPekVsNnJobjJkdk55OFRaTkJpV01F?=
 =?utf-8?B?dE53ZWRTZUN4L1NnM2tjTEkwQUcrS052cmJ3NmJ4OXZrZ0dCUGNUaXBvSkor?=
 =?utf-8?B?cm10REppMDZwMkc1OGRBeEQyNzFjcmt4KzNPdm9ScUlpcWpINzF0Uzc2UUJy?=
 =?utf-8?B?UEpBd3pEQWRHL0ZBclF3US9NRXpZdkptM3RQM2xRVEhXK0w2WkxjM0h3Ulpy?=
 =?utf-8?B?bzRwUVNXNXFhR28vRm96bEdkVkRyTUQzYjV6MElXMVByNjdQVjdKb2dYcTN2?=
 =?utf-8?B?UGh6QVdjdDdTNTQvb1dZaXJCVlJyYkdTZE1TRWxURUlza3BJWlFWSzR4VjhI?=
 =?utf-8?B?YXlZTXl5VU5YZjVFbVliNitGeGtTdlJKRllsZXNqQk5wSzlqcFJFeXRFaytF?=
 =?utf-8?B?dElncUQyQlBMR3ZIOGc5VG93cGxpN2VhQSt0eXZyZGt6YldIcE9JMmdrYkJ1?=
 =?utf-8?B?VWNpTTZ0WWVodmR5WWNteDhMaEVzc24xQStob2swRFdSZ2pGUU11WHMxVmRQ?=
 =?utf-8?B?V0JwVXN0NEJUei9ndFplYUtXaHU2TjE4a0JJbjFiUmI3ZWNrUk8zZE9HczZ2?=
 =?utf-8?B?ZVhMMW4zUkZkNW56eEdEN1J1SHIrRmhHR2lLemFQaUdncm12U1o5QTl1V3li?=
 =?utf-8?B?MlAwZE9BRDBMemRWZ1VkZmVJdTVJbE9HK3dJWm91YkRlRGs0Y1VaM2RHRE51?=
 =?utf-8?B?dHNuSitCNC9NcGxKM0w3ZkY4VFBjOUl3RzU5TUtGZjFydGh6bnhyajRIeFFt?=
 =?utf-8?B?S1FocDZsSlFGMFVQSGoyaFVzT3BJbGZJaWNBMDBReE1wQW5IU1lUa2VMSTV1?=
 =?utf-8?B?VEF5TzdkZm95UWErbUU1MDBzRjRNZTVqY015OUdjTFpOUU5aYWxPVnZ6cXpl?=
 =?utf-8?B?TncyRVg3cEN6dUZUdmZNZjNoak1IQTZoTVdpUFNDY2Vta2hCYWJPUFFJMjNS?=
 =?utf-8?B?UXVkYW5SOWhxcC9XNnk5NDVhenhIS2k4d3N0QTd0d1JXZTBrUDlxMU1IN05v?=
 =?utf-8?B?RHdRaUJrdjVZU2w4ZU9jT1JabGJRNkRtR0twOGt6bm5Ed0dGZWdycW1KczJS?=
 =?utf-8?B?K2dLajJ2TTEvUHJGL3cvM3VEV1hJSXl2QWtuQ0pqZDM4WW9XRm5wbzQyZVhT?=
 =?utf-8?B?cEZMVmhBQnJGc2FvWWVybmw5MytEc2VzWkVoMlVEY1BDakdHMHFjS1FSZnpR?=
 =?utf-8?B?OTV3b1plOGpSMjVicS9USnloUzN0cEJsaFdnSG1LbjRrbERUTWNtb2FRZEpC?=
 =?utf-8?B?U3JTVTdaZFB5UzZ1akw1eDlITWkwNzlDSFpnS3R5S0JxbjU3VXlHbTczZEpS?=
 =?utf-8?B?bVRZcnpCbERxUGdxL21DMVVnOHJZWVBIZXo5SkoydXgwMHVXYXl1a3ZlVjFJ?=
 =?utf-8?B?UUZ2cmZuWllOdE9ZRlBRNkpxQTZsKzlpU0dZbllGQkpXcGVhV0g4TkJsSDcy?=
 =?utf-8?B?aEVLb3p2bUlKdFJzVmt2eGk2V2hEYUtwZVJFL2dBUHozdmc5S0hEa1hOVzI3?=
 =?utf-8?B?cU1mSC81d1Z4ZHFkNzZBSE8xS29pSjh3RTE0NHp3dzB0MGV5MjJJR2pWWU1Q?=
 =?utf-8?B?b2xTcGlzV0huVlIxYnZweXhPMFczckFiT2x3eEZWVlAzYW44YzRQRG9TcHNh?=
 =?utf-8?B?dkRQcmc1TDJRcWxMa2ZYNXNlbFRmRjlJYWZUdHcreit3RENqbDhqUDZ5a0ZP?=
 =?utf-8?B?cW40MVZJeG9SRmxZRDBZbkJyeW14MUVhKzBHbEt4Tmh2TC9VbzRsUDRrK2Fw?=
 =?utf-8?B?b2pmNE5PM1M3dzRhdDlvUTNzbFJlbVpUT3dsdDRnb0hZaGZTTEw4UWIxeU1U?=
 =?utf-8?B?dVFKTGJLM0x0cVFRV1REeEFNcThENkE2Mm1jeUQrUngwcG1FT1QrdWplTzk3?=
 =?utf-8?B?eFJTVkdYcy9sYkMvSEdjcDVxdUZhMVN5djM4UjlTcXpnVXJwQVR2cFg1TXNJ?=
 =?utf-8?B?U1ZaREpPMXMxVXpUV3ZPNjNLYmIvTk9TSVcrT29OTmNjdUlBeDFScUFETmxQ?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 272a41d3-edaa-4fda-b79f-08db832d6497
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 23:11:59.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL5Jq+oyPGux62Xf4+qE8JTgAuWNvRKemtnBaVQVgPqDqcA9OPweTM1tEy69OFSd+Vbs/Sf4GwI3YTeMA7OAT5haSNzNHD7Vw9MwRVQuUEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/12/2023 2:14 PM, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 13:09:35 -0700 Nambiar, Amritha wrote:
>> On 6/2/2023 11:06 PM, Jakub Kicinski wrote:
>>> On Thu, 01 Jun 2023 10:42:25 -0700 Amritha Nambiar wrote:
>>>> Introduce new napi fields 'napi_rxq_list' and 'napi_txq_list'
>>>> for rx and tx queue set associated with the napi and
>>>> initialize them. Handle their removal as well.
>>>>
>>>> This enables a mapping of each napi instance with the
>>>> queue/queue-set on the corresponding irq line.
>>>
>>> Wouldn't it be easier to store the NAPI instance pointer in the queue?
>>> That way we don't have to allocate memory.
>>>    
>>
>> Could you please elaborate on this so I have more clarity ?
> 
> First off, let's acknowledge the fact you're asking me for
> clarifications ~40 days after I sent the feedback.
> 
Sorry about that, my vacation to be blamed.

> Pause for self-reflection.
> 
> Okay.
> 
>> Are you suggesting that there's a way to avoid maintaining the list
>> of queues in the napi struct?
> 
> Yes, why not add the napi pointer to struct netdev_queue and
> netdev_rx_queue, specifically?
> 

Yes, this would achieve the queue<->napi binding for each queue. But 
when there are multiple queues for a NAPI, I would need to walk a list 
of queues for the NAPI.

>> The idea was for netdev-genl to extract information out of
>> netdev->napi_list->napi. For tracking queues, we build a linked list
>> of queues for the napi and store it in the napi_struct. This would
>> also enable updating the napi<->queue[s] association (later with the
>> 'set' command), i.e. remove the queue[s] from the existing napi
>> instance that it is currently associated with and map with the new
>> napi instance, by simply deleting from one list and adding to the new
>> list.
> 
> Right, my point is that each queue can only be serviced by a single
> NAPI at a time, so we have a 1:N relationship. It's easier to store
> the state on the side that's the N, rather than 1.
> 
> You can add list_head to the queue structs, if you prefer to be able
> to walk queues of a NAPI more efficiently (that said the head for
> the list is in "control path only section" of napi_struct so...
> I think you don't?)

The napi pointer in the queue structs would give the napi<->queue 
mapping, I still need to walk the queues of a NAPI (when there are 
multiple queues for the NAPI), example:
'napi-id': 600, 'rx-queues': [7,6,5], 'tx-queues': [7,6,5]

in which case I would have a list of netdev queue structs within the 
napi_struct (instead of the list of queue indices that I currently have) 
to avoid memory allocation.

Does this sound right?


