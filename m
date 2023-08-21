Return-Path: <netdev+bounces-29337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AD782B0A
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9868C1C208CC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFA7487;
	Mon, 21 Aug 2023 13:57:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FE63DE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:57:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D6BE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692626276; x=1724162276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FaBZM/JNYXW0x5Rmq75xTtJ/7ltuhW1kxcyM164KWW8=;
  b=mw5lJ6N5Jjy03fCPKiFyzkGHQrD/0F26dR43fO6OC78K5UG137bASL/v
   U0BelHdRKcWg6bpRR33JnUL/G/WvY5/ryG6w1fJXMRYdhuNVf0AbyPfyB
   AHtxUMSF/BwS7F/IjtFTpf+3J6a891hjOwgedwrncKZPBY22kN5do9UZ6
   xvqVsFrUL7uQRxGcSfTyUWSbhM8JZZ3/o2HZczKMKXNeK4XhcelVTtfrM
   haqX+Bo4Q29DSRAMJBseC4ZtYGpykYAoXW7344p44M0femDJzzCuT1Hcw
   lcwEqG9wsGDaS8xUZyempaPYQN2zQ9Eo29YKAPkPMC0c1y9UMUxnHERJO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376344178"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="376344178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 06:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="770959176"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="770959176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 06:56:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 06:56:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 06:56:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 06:56:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 06:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCkJUlhTDLk5Z1NJjXC7klCn74GI5o1FQmZFczVpdlkD2pP9T3LiVR5xxjUtuCebtUAQrRqcPw69GIG8ZkoXO76RLmuuCSVDwWIaKMy2uZZwaMfJyN8kLiuNtD6zxwR7qed128dJB5HzycsP8bCUD9xVduzAsKK02oYNDJY7C/413Eqm2xaQwCxyq9Y732/4ItyW+xR3DOu2wfNT0MG09TBef3ok3NAV4ROR4PZMdxKgPmESeQzQT5aWGSf6LSb9rWK8rJv7X9tD0HfqF3rg4F+Dbe3Sg3J3cupwA4u9T5fyj5B1GLOGYXYRAH2lN+QlwfyPBsht1VqjEHOle5gvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2ws8HW6OC6D+ZTB6cUDb9tsT38PdG61d3Wj6Llm6eU=;
 b=FCxF28Md2HejugXk79sznfHpRveo162Xvo2Z7ng2QFlxFlY+fp+gVScjlw7hhnEkl31D2LAOfMSgmTG1auPSaUwKwaIUDnRKUkx7rlyv1H+b1+fGplUdqQ1pSyHuBGuuQBQNHz7EKQnARxl5BFUvnMqcLiNOwmDfAwkmSu96TYqDRU62NiM4BLPlRletueXWbcC4Er2lQjgUIbCqDiz5yIZzYRrWRwHXM0olIWVTyBLPMdEvxlXF30fvUZxIfE6pOB0hFFcST+PXymqmblfbH0JoYZ8xslu3nINX0N3Z9cckqLrZg7Rd/Ry3CAHITNVU5t7X+bn4WH+SNOtFatt9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 13:56:46 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 13:56:46 +0000
Message-ID: <7bf42407-7b2f-9824-b2fb-114fb88ace06@intel.com>
Date: Mon, 21 Aug 2023 15:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<vbabka@suse.cz>
CC: Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>,
	Christoph Lameter <cl@linux.com>, <roman.gushchin@linux.dev>,
	<dsterba@suse.com>
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <169211265663.1491038.8580163757548985946.stgit@firesoul>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0014.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 40162fee-4a1c-48c2-3817-08dba24e756c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibJHG4Y5py8Fa785XS65Nc3i+759Ns2M5I32XWYvZ9MMg0pwJSSzrznU7auNjWkqeJboahJOY8V8LUe0CT7dQa7GxipZ5hILdIxANXAer0zfsaycK1vq5/Hqv+eOJN++SFtAlYJGp1Gzwwu9wwcYcxEEyv3I/OsE7nwHaXG9eUuSm2ndM3MM2QaAXreB6DXk8hXQHnRbz3eTQ7NwAxmwNT//9HBy0bHHmrVfnc+pTDRYsGHE6XQqgXuWYHIob+vomliN2leAcb8FRSliNhIbHXfYL8pDOHOpucHVZxVIwnKQhmd5JABxTD/Sg2CNbm43oH+gNpThcnlwGD7aFK9eK78DJ1OFcsJtfMXBE/1m355dg/FPbeRCz6KZfG5b4Zc6LgHXV91eZerUNRG2tSGeqLF/s2SfPgffm6vztYifAHpulIZyEKfSk7gYS60DhBHWBbTQm9mDGz5hB47u1HhMAFpTwL/36qBdzSaCIxSGdTKKMrrao6EFkPH2Lm/6m6D3YxfkfoEuUyO0od4Bm3NzKkpb1mBp5FrIKIA+pM6R5afb3uCtiKN+MhAQ95+Nw9FCezcejZ1dKv9UTHiSZ2rq+KhXmmLTreysDt7KDe+DK1rohyWA1JeXy3Azmy89gasJXnHvaMNXsvwwbeJt4s73mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(66556008)(66476007)(82960400001)(966005)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhIS3RzMnI0UlVhZXNRaUcrNE5NSlRBSk9MSi94cTA4VTBtSXFFd3Y4Vkw5?=
 =?utf-8?B?cTNGWTVDdllvc0FGd2tKQy9xVGJSTnlrZlJTN3NXUzVkdW0zZ0JNWFhlQlFR?=
 =?utf-8?B?NmJrS1lWM1U0K0FNZ1Bla1VFQjltdFloSnprVXNwOUJ3OWNOSHdjRWY0cUp5?=
 =?utf-8?B?cU9ScTZaWkZocEthbWVFcnczY0ZMN1dLU3RGeHcxZXBKSTdKRDhCN05wTlVT?=
 =?utf-8?B?dnhpRUJKSk81czlvMG1HWnBaREg0VW5NM1JpTm5XT1ZyVjNUYkFvajdYR21x?=
 =?utf-8?B?Y2VOMjVUOE9VK3FGeXdMTmVMUDdDN3RDNlNkQVhOUm55QjZPdytrWVpEcnBX?=
 =?utf-8?B?L0RXSXhOb0hYU21ueWVFU3hSOGZheHgvUE1uSDBodC9DOG1nLzJjWWJXUWlp?=
 =?utf-8?B?am9tRTcvSllUNDlFWG9teGdXSGt3a29ZYVpjSG4zeFJ4ZGxiRy9iUENDdUEr?=
 =?utf-8?B?M2dSL2pLREZLS2lYWFZ2eGIxUkRKTXBKSDRDNVhVK2ZPejlwZGEvTE43YW5L?=
 =?utf-8?B?QWFRalJMUk13cVpzZUVFTVZOamRTZEwzVWZ2K3RDRnd6NXJMOVRWY0dReFll?=
 =?utf-8?B?QlNmcldkMmdBY0w3SHJJQmo3RXdTRmtDdG1Xbm9yTnAzeTdlVzN5OUlaK2t3?=
 =?utf-8?B?aDNaU2RQRTJGMU9UR1pxTnc1bUZwWlM4eDl4SFRwZkNCZ0VkSUx1SVRCWXcy?=
 =?utf-8?B?VHEzU2xuVGVSWmcwUWcxYk01UU9QbTBtQlB1MUxYQjkvWmorMWNnQXJnT1Zp?=
 =?utf-8?B?T0o2TzNnUEpLQlZpbUR6T0txeXUvNlcvN1poSGZJeTlzV1pqVU01K0w3MERI?=
 =?utf-8?B?ZTZyVWErWlk0WVRMcmpmR3YvUVlrWjBDSW8yUzFzS0FBNXBZRkt0UDFQWmxS?=
 =?utf-8?B?cEI3ZDdjVTRrQk9mdWNiY0ZsVkp0aURjSDFGOGlCS3l1TUlkY1FBUjFrdm8v?=
 =?utf-8?B?cHVRY0JGOCtXdUp1M08rNk9mZXhQR3N1eVRDQ1J4eUE1Wks4Q2xVVEhxQnNm?=
 =?utf-8?B?S0NqNzlxLzRYZzF5L0VMNDhuT1pCZ0dEekFiMnRMR0FhZU5oNE5sOGRPTjcw?=
 =?utf-8?B?bUsyeGhhM1UrYjc2VXYvZlJlbW02Q3ZRb0QrcElmWUp3VXZPMFJkalc0SmMv?=
 =?utf-8?B?ZzVvb2VaMzRTbW9Fa3UrV2NYN2l6L2lTQXJYT0djbVowTjdKU2lzWHlLNkN3?=
 =?utf-8?B?UHlzT0RZOHcyNCtFK3JGL1pyRmZjOUo4aEprN0JRWUY5cUdCQXcxK3dvS1Fr?=
 =?utf-8?B?MTFtT1JTdnF0NXlwTHFxdDFBR1hHSzhqU2dtT2Y3b3ZDVmI3aDFPNm43U2R6?=
 =?utf-8?B?WWZvZEIwc0RYY1NnQjVvb2FBTkdWS2w1SzdXUkd3V3BpMkh3U3ZkQzhjbVZE?=
 =?utf-8?B?b3FnR0FabFo5NG9paDNkYS9xZk92TFBrYnpUN01kejF4aHE1L0hwTjI2Z2Z1?=
 =?utf-8?B?dzNSNmZsRTI2YWUwQVcxR09ZaTE0cnpUNWlFYzRIZkxMM3drRTR5b3dtd3V5?=
 =?utf-8?B?RkI4Z2Y1eTE1eGRTUnNmSVFjdUhmRktCUU1PaWk4TE5MMlUyZmlvb3gxaWl0?=
 =?utf-8?B?OUtwWUhGQWcybWZYN2YwdjhFc2xoK0F1MHFaWWZ5TnptOWQxckxKRURxMGNs?=
 =?utf-8?B?aVNsazR6eEdxb0dZeWt4SDhNdVBGbVlxYmt6cTU5VzJNc25LKzQ5Z05nNktt?=
 =?utf-8?B?b1FGMDRxUCtGeThIZHBVZWIvd0lieDN0ZW12dHc3UkxoS2pBTzRMV2FuYVNv?=
 =?utf-8?B?R1F4bDhtdEEzMDE2NStMKzMwYm50bDZFKzQwSnBDMkQzalNOUEl2NTk2b08v?=
 =?utf-8?B?eWtpS041V3RDZW9WWVBtNVl1YUpZUnlZY1pFVVcveG0wbmRONktSazVSR28w?=
 =?utf-8?B?elZaYitPNlJ6TUJKYTZOWTh4T2FiZTY4VStTSi9YT2E4K1pwcE9lNkVOc0cx?=
 =?utf-8?B?dGpvVGhZdFF2WkJ5S3NBblBwbEN1TlJFRFY1Y25jclBYdDVwZW8xa0d6aWRv?=
 =?utf-8?B?SVQ3L0d4alprU3ZZU00xTlA5RFpqV2pzRjE3TGt5T1pwazZwYk5raDYwVDZj?=
 =?utf-8?B?cDNuSlpVU3MrOVZWekVmU2xQdWtpeWdvd1hKcFg2Z1J4UVQ1a3lqZXk5Z3Br?=
 =?utf-8?B?ODZ3cUc4ODlWUjZQQmxjU1ZkeDh2dXVaaHN4Q0dhd0lidFIxN20rQVA4QXpz?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40162fee-4a1c-48c2-3817-08dba24e756c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 13:56:46.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdmoQ32ED/Lp5HZJb1C1yfqo/g2e4GQtV24TQ9KILoj07nAFrawZsNzr403dIYTfr+k7F7J45O2ZNjjv3B+RncJtbHzPOX7fVXj2OyQJ70k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Tue, 15 Aug 2023 17:17:36 +0200

> Since v6.5-rc1 MM-tree is merged and contains a new flag SLAB_NO_MERGE
> in commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag SLAB_NO_MERGE")
> now is the time to use this flag for networking as proposed
> earlier see link.
> 
> The SKB (sk_buff) kmem_cache slab is critical for network performance.
> Network stack uses kmem_cache_{alloc,free}_bulk APIs to gain
> performance by amortising the alloc/free cost.
> 
> For the bulk API to perform efficiently the slub fragmentation need to
> be low. Especially for the SLUB allocator, the efficiency of bulk free
> API depend on objects belonging to the same slab (page).
> 
> When running different network performance microbenchmarks, I started
> to notice that performance was reduced (slightly) when machines had
> longer uptimes. I believe the cause was 'skbuff_head_cache' got
> aliased/merged into the general slub for 256 bytes sized objects (with
> my kernel config, without CONFIG_HARDENED_USERCOPY).
> 
> For SKB kmem_cache network stack have other various reasons for
> not merging, but it varies depending on kernel config (e.g.
> CONFIG_HARDENED_USERCOPY). We want to explicitly set SLAB_NO_MERGE
> for this kmem_cache to get most out of kmem_cache_{alloc,free}_bulk APIs.
> 
> When CONFIG_SLUB_TINY is configured the bulk APIs are essentially
> disabled. Thus, for this case drop the SLAB_NO_MERGE flag.
> 
> Link: https://lore.kernel.org/all/167396280045.539803.7540459812377220500.stgit@firesoul/
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  net/core/skbuff.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6..92aee3e0376a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4750,12 +4750,23 @@ static void skb_extensions_init(void)
>  static void skb_extensions_init(void) {}
>  #endif
>  
> +/* The SKB kmem_cache slab is critical for network performance.  Never
> + * merge/alias the slab with similar sized objects.  This avoids fragmentation
> + * that hurts performance of kmem_cache_{alloc,free}_bulk APIs.
> + */
> +#ifndef CONFIG_SLUB_TINY
> +#define FLAG_SKB_NO_MERGE	SLAB_NO_MERGE
> +#else /* CONFIG_SLUB_TINY - simple loop in kmem_cache_alloc_bulk */
> +#define FLAG_SKB_NO_MERGE	0
> +#endif
> +
>  void __init skb_init(void)
>  {
>  	skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
>  					      sizeof(struct sk_buff),
>  					      0,
> -					      SLAB_HWCACHE_ALIGN|SLAB_PANIC,
> +					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
> +						FLAG_SKB_NO_MERGE,

That alignment tho xD

>  					      offsetof(struct sk_buff, cb),
>  					      sizeof_field(struct sk_buff, cb),
>  					      NULL);

Thanks,
Olek

