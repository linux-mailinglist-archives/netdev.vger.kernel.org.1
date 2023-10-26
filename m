Return-Path: <netdev+bounces-44423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AB7D7F0E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F57B20C89
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36C23743;
	Thu, 26 Oct 2023 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPBWOX6W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916C18B19
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:55:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4C193
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698310518; x=1729846518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zBL1/6KOgJ7ndef+QP2+esSEdkOUSMfF8MurCtL14ow=;
  b=nPBWOX6W6MX64kwQ+OTcMW/RyTNnsPIOQTpK/0Kkt9D7Ml2SYtdkB/cv
   OI1PylsnWMRrC8wlqBCVEvsT5HCg+LhRkTqYBD++m+zndzhyN4JTCG98G
   diHgrn50eKMMShcaOq/IBUcrB6whbfQxcPM5uBCs84QL3IKK+4E2ILmfl
   SduLNWXbNB47zdtn76Q6UeJUPFpJuqiYAl19ITDTzkg4p0hFoKvqpsLXg
   i8OBX7q8E+Aw/6BGCyQYMaFmIJRo//VjI7ZfVHSHuK5dh+u97iqoTb80z
   CRyreqGwfc834Oz27vzzndobkJxRbGDb0w+I/Y1LiP4lNz6qTIHMuWdEF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="303157"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="303157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:55:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="424104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 01:55:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:55:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 01:55:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 01:55:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 01:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvw190EUBJXagIgYeeVILIlmnPV5ZM/yK9c3KsO9HxJxf2kMjuLLxFQ7nW0z/leMlCq3ydw7e0Y+GOkU0P5OyPYCr2BxRCU5j1GdW1aldCFkvYAYsBM4u3nLTze5xL68H25ZtqI1DoNBhJ5Sq7UC6ayBIQVb57A2Kq7QLnoL+IbjggbNJbFNoW4eJPbrpvQHPMq38UpMWLW6oIzk6G+J/u1bbJUk5oVIj5wI0PnfpscAy4KOZGe9ICtFSHNOuKnKKpljjHhp+wplcn8mDTkN3x8mKi+HBPrCyDHuDFooyPeoKavOGQjFlFIpQsBn64r+HjlnxxlhQTBMv1jYmtGJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhifVe2IN++gQxuURIMwRMqQqOreF0U0YWmeo/9qJow=;
 b=nCuyqQV8uohqjH+ptjJLLllMQ2JbLlQ2GzdW6+0hhGroPpNrqZyGA+53eh/QUPdD8gBiIpCWZ8MP+o6F2BdIpstC1WItYX8Znf7U10BHMFKJ063XhMBx5GH195nDXlOw8JnZZ7EtuQrIOhHb5UGpNZJiCoMaUCuBaWCI+gO4Z9Ner8O4ojIIYPP7PSSmtt3gzMmzavY0C+AzFMrvf6OCLmyKvOqs5e0Tp4n4CVWyviRPQbloaef0m9CbB0/e7qm7f+MEPsCE+MsmXOczJ/M8Rrqmasx3AVxo0ikcsszP36TNqE4T1OT9KEeWVvMpU8xTfWaL/BGGkTs3egydmozhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:55:12 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:55:12 +0000
Message-ID: <40bbdd83-d62d-420b-ae6f-a16695383b41@intel.com>
Date: Thu, 26 Oct 2023 10:55:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] nfp: using napi_build_skb() to replace
 build_skb()
To: Louis Peens <louis.peens@corigine.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Fei Qin <fei.qin@corigine.com>, <netdev@vger.kernel.org>,
	<oss-drivers@corigine.com>
References: <20231026080058.22810-1-louis.peens@corigine.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026080058.22810-1-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a029d9-d078-4d30-8374-08dbd60143b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VRevaMvN2JgXTdlQwdQp9FdzuT42CcXnxmkbPrTn5oS5k7cBmxFVpFdqgS12UinjOBCd/aQq09EHXbcWYg0jQh2Zk/ZUNhrUUA6PzqWFDKvHiwYLbunEuG1Z7HAXxuafvbYyM1qP6VKYic5h8OPv705dA/mTUDQtqfyULuBBF6mR2J3JHQ/crUS6CLNKWR4SoKpuyhTRbnKKH2WE19cZF/mJPsUK8FEwwEiz4mitJitOmlWhoJdoFhNtBpUs6hvZNTSw3PFJDRtEgEX24xfJcQEKv3AdZkmininJnrldWtumyoJZEhk4y9Xln7DZJ2MbAYle+/D5qORaFItXdEFH6PpweENpCvKPjJFkUJafHG5Qd9j/ZsxpHGpqyQrxStmwA0SkPfvZGqp+IpFbw5Ek95ff+O50hnkFyhHdc1Wz7mdHzryVXRz9ZG/TRZll7uVjyRW0cxIULOCWmkgc3kE2s/9hH9q5DH0AGQO8gKIyZKdUO71Jx86T+lOCJRuphVxldmibGXYYQheGcHtvgN5kGgqpxFdAzWjD9O8++UwuLPb8F+xclKdl2gDgyj4uzJ/ffjVn2UeV4KQgFWPfhPte1cUBDebWRhiQEB8FKze4H4ZfnDp45xm5SusYoDDK5Y+F+7RlAYIpX1zqBGWv8u/sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(83380400001)(2906002)(8936002)(2616005)(36756003)(5660300002)(4326008)(31696002)(8676002)(41300700001)(86362001)(478600001)(44832011)(53546011)(26005)(38100700002)(82960400001)(6506007)(6512007)(6666004)(316002)(6486002)(110136005)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJIRzdrVXo4WDVUL3ZTekdWRjF1RjZoaW9FNEVNKzBDRXlNTkU3Z0ZEK1BZ?=
 =?utf-8?B?NFZ4blZkZHZRRlNiZk5HVDlqcTdoaldGdUVWSXFIZGUybWEzYVk1SGY0ZVBs?=
 =?utf-8?B?a1VodmtXbXJwUWZmcUF6QlNXa0ZET3pubXQ4cGp0LzBkVmZ3LzByZ3BxdDMz?=
 =?utf-8?B?UVd1bDE4dWEyTUhGVTNiSkR4Q28vRHVLbnVseVdJdFdpN2J3aWtJNkdJM2Nh?=
 =?utf-8?B?RDVaTnFxRmZoYy84QnNLc2s0Y015NE1Za1FaRTBTNVZvU1pjTlJ0Y1VVVFN2?=
 =?utf-8?B?UmhBYzF1ZTlpQ0hsdFg2a2RoeU9RcUEvcFV6bmxvWDV0NmxsODh6YTJhOFVh?=
 =?utf-8?B?akhZeXBSYTEvS2Z4em5NN04wK1o2djc5Y2NaaUdORzBYL1JGeWM2R01yN3A4?=
 =?utf-8?B?bVo1ZUJQbno2WDVzUCtYUUUyV2NGUU5YdGFUa2hnMmlnUGxnZHhCUHBzOE9n?=
 =?utf-8?B?dTBLZ2FnTUFFbThYSEc0RnFYVyt2N1Fybi9IeGZ5dW9JWXRVeGFwdUdjQjhs?=
 =?utf-8?B?elJDdmxxQnVCSEZkekxGWHNzWm12MGV5allGeXcxa1hrYXViZnFnYklhcXIy?=
 =?utf-8?B?UCsrNmhmZWxicHdUQzB0bTZjM2I1QjRBQTB6enJlbEZQbUNmd0hKWFV0NVBv?=
 =?utf-8?B?TmdtTC9xWFkvZTJEN2JrN3dpdEtYYUt1YXF3dTlRc2sxOTNqbk5YekplVnpu?=
 =?utf-8?B?U1E2R3N6QzlLaHMyK0FRUDZMQWNKWExMclFSR1dNZ2FVU2lZZXVsODkvb3k0?=
 =?utf-8?B?c2ZEbzRSdytCbjhlSHhCczlSMzNNNlFMSTZGSVFVcjNUNEJIOEtpQS9yYkhJ?=
 =?utf-8?B?cjJKOWd4L1dnRFRFbm1USEpYYi9zbnFFVzNIekVtSzRXL3F6R2VuVnU1OHN5?=
 =?utf-8?B?T0VkM1dZZG9VT29FTnhEY3Bsdmh0dUQ4QzA0YjRmSGIyQ0I3TXA2MFA5WEhl?=
 =?utf-8?B?Rnk2dXRHN2dhelhBc0FubnJjckJLVVlCaVkweTZodVFJbVBVVGFTc0VSZ2NB?=
 =?utf-8?B?Q1pDeXh5QmZ1Ym1VUGxkNU5NWC9MTVF4SmR6M0tTTjhDSDJOMTNyWmpVZUtE?=
 =?utf-8?B?QkQ0NjJzVi9QWit3dDFvK3NwcmFsUWkvc0dRRS82Z082MTk2T0hNN3Y5UHdI?=
 =?utf-8?B?MnBHeGd6UEVWRVlYWFVFQXJraEZKTGVNOTBHY3l1Nk55T1VGdTR3YlA3eTQ5?=
 =?utf-8?B?TDNSTjY2dzMyb2NZdzVIVkRpcWVRekhZajlJRDdhNWtmTFhzRHYxTXNUQTI3?=
 =?utf-8?B?UUtuUkZJMnpqUGZXOEZZamQzb1ZtL3F5S2ZSNCsrV21zSUlWa3dQTEM3WXhm?=
 =?utf-8?B?V2dMUWFOMW5DVzgxaEk5c3VWN3hjVGRkT3dmb2RxaHZNV3Z1WnVIb0JWcEN5?=
 =?utf-8?B?SGE5cUlPa1NOSGtySW4xV090Z0xrRWF1SzliNUM0MjVjeWRSRGhWZ2pMaFZl?=
 =?utf-8?B?TGhBQnZSa0o0eVNacDFKY0NyeFB1R2RjellDRkUxaHZ1ZmZHMEp3SGlyTjZF?=
 =?utf-8?B?Q2hEYkJkbmhXZDFTQXlvVGdIdGxxMWwzU054ZG4yMFZ5dmc0b1JqdHF0bk9J?=
 =?utf-8?B?RXhsMVVIMmlPWXBJTjk2T0REanlXZXc1NzJPM0VhRDNOblNHYTRRbkhtSGQv?=
 =?utf-8?B?M290cWU1K2FFaXZQQ01abDVEZHFmRWlld0twSmdHNG5TVXNtejEyb2RRWCtI?=
 =?utf-8?B?RjQwV3B3WFhwSjdTY05xSmwwdm9XRDdDbzFvVXByVjF6RFp0a3dWRVQ1Zkds?=
 =?utf-8?B?M0c3azJUNTk1c1loQnN5dHI2b0F4Y1NVZ0VBUDd3UFJxWGFSRDVycm9ONU9W?=
 =?utf-8?B?Z1JGdjZFRy9SRldSTFpiRWJSZEZROVllRlI2T0RtaG5BeFRQaWZtRk1yQWlq?=
 =?utf-8?B?dXh2TXUza2pmZ3MwUUZuNXZJM1FzWWRIWmZPSjMvQmQ1ajA5cTZzek9kdXhR?=
 =?utf-8?B?LzcxNGZoY05oZVdjeExKMGtZaXc1SEZUSkFnRnpyN2ZmUDk0MVVzMUt2MU85?=
 =?utf-8?B?RXhhelJLOFh0N3ZpU2krZjZaWUpzdDFXT05RdTFCa3lsaHAyVytCVE1SR1BD?=
 =?utf-8?B?VFl3d2NPSjlvcWhzMERJZHJZNFJMWU5rMUlMY3hNa3E4VGpNLzV5RVNSOVpz?=
 =?utf-8?B?c2NuL21hN1hXYUFKNFBWUi9zTnFKQXhVL0NrN21RWXYva1VCR0JKdTREUTF4?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a029d9-d078-4d30-8374-08dbd60143b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:55:12.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBYnXjsEiWvluzP+G5IN9gqfZIncmWSM44SVKxL77MjSouX49CUK3zxNzEVzUbBYSRAsMnKFfN3+ktkEAzaNYNz/oieQZ1XpceEw6XVEGls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com



On 26.10.2023 10:00, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> The napi_build_skb() can reuse the skb in skb cache per CPU or
> can allocate skbs in bulk, which helps improve the performance.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
> v1->v2:
> Dropped the changes for the *_ctrl_* paths, as they were not within
> napi context. Thanks Wojciech for pointing this out.

No problem :)
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
>  drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 2 +-
>  drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> index 0cc026b0aefd..17381bfc15d7 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
> @@ -1070,7 +1070,7 @@ static int nfp_nfd3_rx(struct nfp_net_rx_ring *rx_ring, int budget)
>  				nfp_repr_inc_rx_stats(netdev, pkt_len);
>  		}
>  
> -		skb = build_skb(rxbuf->frag, true_bufsz);
> +		skb = napi_build_skb(rxbuf->frag, true_bufsz);
>  		if (unlikely(!skb)) {
>  			nfp_nfd3_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  			continue;
> diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> index 33b6d74adb4b..8d78c6faefa8 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
> @@ -1189,7 +1189,7 @@ static int nfp_nfdk_rx(struct nfp_net_rx_ring *rx_ring, int budget)
>  				nfp_repr_inc_rx_stats(netdev, pkt_len);
>  		}
>  
> -		skb = build_skb(rxbuf->frag, true_bufsz);
> +		skb = napi_build_skb(rxbuf->frag, true_bufsz);
>  		if (unlikely(!skb)) {
>  			nfp_nfdk_rx_drop(dp, r_vec, rx_ring, rxbuf, NULL);
>  			continue;

