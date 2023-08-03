Return-Path: <netdev+bounces-23818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1776DBE0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EFA281D79
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA979FB;
	Thu,  3 Aug 2023 00:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4893C23
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:00:56 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC12D43
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691020855; x=1722556855;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+/cOv+wwegQkiEf4ENcuNNFNCtbHfiQ8R2RSGpagrKc=;
  b=nM8k5/AndU9Jo8VUV/7QOGE47e/W72EvjaiP+VZg+j+T6+DCDg4ois4t
   bizhHVcRR4rwySH1zwRsw/2W5IHb3YT5QyLdSABjy7NxZnIfoynfc85wA
   d2WtNTVo/aDdP/3+KJHCTSvk1n8VejPELfd4cyBvhLh3NVefkDRjyufLs
   ji1rEjhBVzhAnSCuYVqBzym/8XWRXLp4rGniqQyugFg3uSs5T0zr3B/Ww
   bHxLyrfOcwq/Tsjl2bsDsiesZXBfpp/56xQIfsHr+mTGAGwaVfb0Ra6w/
   hoxs7NQKHTseKgBO3TS9QVjqqytukpagx1oY8vBbisIGRzCKztCzWxuyT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372464431"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372464431"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="679276287"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="679276287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2023 17:00:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:00:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:00:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDJhGOsyrq0p1R5/aDjB3HxTfX5QFDUgnzIU/qQdChTIZ7oYSajEDSN+vG0g1P6QIQOMUkwYlp4kT/PNPumnBIGXq6KwitlUzT3C+c8wCoxvbxQGCayUMaHKlhIYLnVDYngFZqlvhPWSdnPWmZekvA+B0EPqG+DFvOacDW24IzwqI1NQ1TqkYM2U6rHoHxkhTI+CY4UxGP++zpfID+tWWD+AYafODJx5AUmNok6qs9kOZ7mRoYI2jRmUvamF0/BX6N+cFB6+bPtypdF5s1cUKq5ctmAubdKtACHwvsFcfjbU9CO599eMDckaYqJKn8LehwKTLZtqdS3fHM+XRl8OlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMiXOnB2YU9izworg43hTEJOjXua1QPF5ay8P6rYmrE=;
 b=Ri26Cr0x+YqZoGpEkSJql25nzK4PAX0OqL3RJivTtGAgOk9Po3hl41rzmQ/xMTJN+hpRy0+w1g+SSimgucLo4JVZUlQvpT29EwAfDzlR8WJOUMqxq4gcJgaDM4NeOPaU5bpr0kI+Rhi7xaNCck4eMnWpI30FwgVF1TgwIaQMsL6Cbmi9gqDxRThoQPyZ/7/dWbpWKfqJE0q8IkK4lCf3sSjX31Q1v8ONd247OLHoKy0VkW1XFrcRhAKzZqTkbIDylBwCSxUG7XmUe8nOGJX6s9dCquFRlMG2dDpKrf7Jz3u8lS6KyIXZBT0t6cLW4P/JwJ9UrnJdrzt2hdJ/PpTlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:00:35 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 00:00:34 +0000
Message-ID: <519d8e95-b802-657a-d6fe-b0573498a898@intel.com>
Date: Wed, 2 Aug 2023 17:00:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] drivers: net: xgene: Do not check for 0 return
 after calling platform_get_irq()
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, <iyappan@os.amperecomputing.com>,
	<keyur@os.amperecomputing.com>, <quan@os.amperecomputing.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20230802090657.969923-1-ruanjinjie@huawei.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230802090657.969923-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e23ed36-1866-4db9-5ae9-08db93b4a93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1N8uyj5aGsRaYWISLFZSYTIOT9cJkjUZOYPsrujPS/8Q+OlkaDdfwu8070VnQSSQ2ezaxtoajFqclejhyrZTp0RXc5fOCzFAca4gxpH3Gu03H0jHzlMP/XOmEbL2iw3IvprsXkIjdc+3ENcve9XAVBzH+aWpNLFsDItZ9OQgFd+g3QRTV6dzi22rAcbyKoTiCLgQ6IhDIG1zY8opsvRyQ4c9iwNUAsqn7/Cg2Heg8v3hg1g2LO/F7TDkMdF5btb1zr6YX1d67jqbvSrrx1au4g7pz3lKUGZkwFBwMqR3L3EAwTr4W/CTAtOdyf+lonmbr70i+62x2sXYfmOzRp0bFxV9WTTawv2Rf/BnHHDxoJKj7IcZBLxYJFVw1aTmet9nsZaftErco1yJUua7E88Yc3pCWcL6Xor44WW2pL+eyQZGUDeHyovuB0rLKxrmE9nboxS/1YnvcNioEjUosogJWSc9L3rGM5rDZLXJ0mHpeGQpdXDh20n36D8aPCTJCvZPsL1fsCVeCf6YLv/0zxmcIbG9V6vBYq9VXEXIIySS/VwnuhwQ0z8UGvAofW/K2Ej3d/QuG3cJSlzD7gWV1TeuvGPvh8/0GaXpRcu/kuaU8u8Cj1p2vCyP2rG71poSATZAtgmZXsur9bfq7146lpRRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(53546011)(6506007)(26005)(186003)(316002)(2906002)(66946007)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6512007)(478600001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(558084003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJQL0FPeU5waFJuT25CYTZWT1Y0UVNFcUtsNlFuRldyZ0NKcHZTUWZWMUVF?=
 =?utf-8?B?QXBKS0xEQi9TQVhpeGhNVDhyRWMzQ2FxclJpQ0Nmc2J3V25xQldqZFZxOWVH?=
 =?utf-8?B?ZkxuYnloMUhXa2p1aElOdmFqUkpuK2hBYUVTY1Z6U3JrNDFuN29ReUNkejhH?=
 =?utf-8?B?TExBU2hXSkdNTVprdzJWVmVHcGpqT0JvQS9RclBUOFlkclJGbXVHQmovU0h4?=
 =?utf-8?B?THpLNTdhdDFBYjRsYlpFUjV4M0g1TjkweERsb3EyMEJ0QUhjcVZ5bXpPSG0y?=
 =?utf-8?B?NTRHWktaTTBvd2pFL2F0RGphNW90VEdaTnhGdklwcDVUcXZRdHNqbHNTNUJi?=
 =?utf-8?B?YnFzLzR0dVdQQU9pd3hmcDBwYUhoZWNWRmlUajdoN2FPSTFNTnBxQi9QdnBU?=
 =?utf-8?B?cnBzNzNFalBUcVBiZi9rdkwyY2loZDNGbHRqL1ptOW1qVnVEQUFaSWhsVytl?=
 =?utf-8?B?S25IMFIyeE82Vk9Xa1RxczlscWQ1UHUzUFd5WmNJVk45b0FZckxPb2hvWG9F?=
 =?utf-8?B?cFdraEpGTlM2b2pIa2FrSW1EN0w0UlNtbWxNcUR2cU9VK3FlZ1ordkZvUDBL?=
 =?utf-8?B?NXVpSFpIbHBEclVHb0x0N21uVXA4S2ZxSWdIQ3F6clAvVmM5VjRGREc2ZmdX?=
 =?utf-8?B?MWVCc1dwU2NobDUwSWpnbUMxZllOdUV1blhKTjZ6MWE2b2s1NldPMENPSnhk?=
 =?utf-8?B?djFjY1NpaDNrWGtBYzRSdURMbXFFNVNzaHBNLzlVL1F2ZGdxVHdVVWN6b1Bj?=
 =?utf-8?B?NENRVHBISi82dEs2LzRjSklXeVNtY1ZvdUNJOGJwcjU4bTdMemlmZlBFSkxs?=
 =?utf-8?B?T29UencyQ2NBb2NlWStHSnMzaEZERFBsVGpjR1p6NlRuSHBsWGtWRy8rSHQy?=
 =?utf-8?B?YkQyeU1QK3ZnVWU5VjMyaXRibVlGNWVkNEhnUG16ZnhWcGJ5ajAydk13ZnpB?=
 =?utf-8?B?emZkMHF3NmgxcWsvNGhudlF1ZDd5ZGVRN2tDRzgzSVNZK0dPL3BtYTRrMmpU?=
 =?utf-8?B?b2JIc2tKUENtcTVnZXJSalFsMlRVaGVwc3dCSVZUWEl2MU5hT2EyaWtnNXRF?=
 =?utf-8?B?M0RRS0tEaXdjMG5XdkgzZ2gxbmlsbXY4MkY2bVBLU0lMZjdBTnhsZGNmYU5u?=
 =?utf-8?B?N1RQR09sMENXN3ZVMVByeDF2eEN2V1FHVDBMc3Urdy83dVVZS2g2d0xqbnhr?=
 =?utf-8?B?Q2gwZHFIWnMvMXh6YjRBSXdlbi8vd2hHYXZnd2pvNTRnVE1ackFIY1pub0Fh?=
 =?utf-8?B?amFJRG9pSDJaUjdsQkRHRmhhVllPcnpwNjR5YTV6bUZ6dDZpaFpxRUc0NVJL?=
 =?utf-8?B?cTZLd0ppUWFQTFRERFlKdE1XNmI1bW9DaG4vc1g4alZLOFV5MjhoZFFoeVhr?=
 =?utf-8?B?bCt5cHFyZ2FPWjFsZUM1YVVuOVdiNlorUk9TcDE0bHlNR0ttMWdwWENLclow?=
 =?utf-8?B?MDR5ZThaL3FBeDBvdjVYeEY3STZrdis0TGJzQ01QRy9Hays3THdpMys4RHdX?=
 =?utf-8?B?a0JpWGVHUmhFcHZjUHR2U3dia2FaWU1SVXd2bDRVT2tGaFREU0svZzFVd0Vy?=
 =?utf-8?B?YUlWRDBaSFEwQjFWL2E0cjRPbGdSQ0dNaWhOM0lNZmdCNWVLdU81NXZWWmNO?=
 =?utf-8?B?TnM1eS9VUlVxditRMTBOMUMzd2w4NE9neE5GalRFSndKYVM4VnhFYVUza244?=
 =?utf-8?B?UGNUcW00eThsOWVZZEFkSmVscUx6UjgzdkIwU3ZtbXE5R3FaSHh3bDNMYzN1?=
 =?utf-8?B?TDVXbUg1K1ZBMEhXcmJqV2N4VzVUNHBrVXNTZ2NGN0RJeW9BZDNtSUFBRTQw?=
 =?utf-8?B?dkQrNDVaT1l0UVNwRjN0cXg5MmFDLy9YS202clByd0VPVXY1QXNOenFJRXpY?=
 =?utf-8?B?MzRiYTZtOHVvZ3VkMnhGYzRMQWtaN01oTzJpdHZLL3Y4QzloMTJyU2pSTHJK?=
 =?utf-8?B?TXVSOU5iTmxTUURnL3J0UHZ4NnFKSU9CMWNvU2NXZkF0bE1aSjBiSGpFb3lh?=
 =?utf-8?B?TzBRaHlQUXNheWdhRjRKNDJKNDlqZGdDVEtvV2JubVZuTWs0VW1mQXh4b3ZZ?=
 =?utf-8?B?U3ZsbWNxN3BvNWhDTUhlT2NDbUJCY21Qc04yWHgvWlE4ODNhcUNFZmJCZ1dn?=
 =?utf-8?B?cVdXckw4ZWVPL0VzTzk1RHlVMUM3dkJNbU0zYllzNU5sSnVidjNKTCtNUy9j?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e23ed36-1866-4db9-5ae9-08db93b4a93d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:00:34.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1hkoX3vSm+TfT7aPRjFWWHbl7ZZjpnttYkb+/z967yBAMX5rMxmm2Ewnr6ZDanE+FC0Ni8guVB0fUgqjWoi4arxycusX5e7Gu/jM2DNwCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/2023 2:06 AM, Ruan Jinjie wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


