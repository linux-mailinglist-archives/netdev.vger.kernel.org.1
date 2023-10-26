Return-Path: <netdev+bounces-44461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CB7D80DE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A191C20F05
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF05A26E27;
	Thu, 26 Oct 2023 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buQ17Q1u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4842D78A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:36:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34819D
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698316611; x=1729852611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+UMA+o6aVj6Z4ubAfE/fDAihFoHtbOAZhkORsYQufj8=;
  b=buQ17Q1uscqaQlXFEdxRU0l6IhXo97stzbYw8dwE7BJpKeiWX9WnM7Qn
   KYZYxEB7AOaLG6SPiem4YbA4bOy6ZOpicSMFPSmkrmEMWtEKpyb/jlhWw
   /mXbKez5RgQPtn83v8Gl7LiqB9sW9sIkIl0SnF40vQos2FOZ3y55aHK0r
   fI0Eo36Pw/KEoSJFjZQbuvXAhIVQPU5zGxma7Ypx8F/iDJpHsDwlpZgTa
   c8roeOoCvS6+GIFsx5U66VU3dvj1PnjJncL3vBsBxPQnxIYJD7QqhVWd+
   OZqq7qVFQ5MfF9WhysCOTC+wx2X8582++nKCsJgXy7WZzvjBuK4YZ7cEC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="387336559"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="387336559"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 03:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794147618"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794147618"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 03:36:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:36:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:36:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 03:36:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 03:36:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3nsCTgrhR6tsFaQFIrOcCt/HfpERHGjuvaiFas9NlYZvtzGoc4rqr0+4hCbE8daJCJi89zbACf5wT/cawdVA7Rcp7RDoUAKpcNe+CLUeN/i3NJLrkN/4o8vAWEAOymYuFuEei6W3p+YB3TSM5/t7t+hTXSGrhXZjrBizUN+DdqcXwW53GJfxR99wcG1a/2PEkVNhsUYhMB2iT248iKozvuG8cx4QUAP4WKGzfUOZFWNh8QnIvMzemp85JqLx0oFSvhV1IKU271oI8/neCOfe4ppLATe9sbMUIFDoqwByWuQmwfvrQCGg/CIP2H5TSr5jzvIR0RvFMt9OUbGUX823g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNF3h3FugRmkY0OCEsV1jXqsW8UOuWRQyfsgWpt22j8=;
 b=oQAe3KKDk0acaKz5Xu5l9o1NdAagy1d9BPTE1sP7DJw1l7PHvLnP/un4cwOPRHSGk1EwZQzEsY5/ttrrMXuRhwjWdSaZFoQZJC+E0fIet6nXGhWk/FtsCx6WQGebMUx7/FE9fevTDPqDksTAtxaCbTivnMO08YUbf/QHoOmU7jfZJ3FvzHgM/oL3zuNUcrBQIPbgVUzuSG0s2VIUm3ftzzjQMYGU0eAHYfNc0ESbeiWH5cDSvHkIwIUIjqAO15c/0Lok6WDHelfY5mTBAkLyXb5kBVDuViyeNmElehfnrTtVbz9OzlL3n9r8sJs4WGHsKFAOyh4KR5AoZhPgRdw6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 10:36:43 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:36:42 +0000
Message-ID: <1014e04b-5e74-4f7e-b2a5-ed0f8d01629d@intel.com>
Date: Thu, 26 Oct 2023 12:36:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt_en: Fix 2 stray ethtool -S counters
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <gospo@broadcom.com>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>
References: <20231026013231.53271-1-michael.chan@broadcom.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026013231.53271-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: f55688af-2f6b-4526-9892-08dbd60f71a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbJiw+DLdWEU523f9+fFPFe2g+X951b8DlaRP0TkDdCgb3e/Z42Ds1qbOCEZJWQFblu0dsAfOLZEMTeImoz08tRc+8yhVaE/aFjB/l62SL6B0iIbMZFRs0GBbO8P7/T+d6U7QG+Bw9j8FOBeTZMrhtCKL3cE44r9kbhLS2yZWQhviNLq/9aIld2v9SNrNPSK/dJ5RqIbIDivLjmpJObPXPNclyWHgmbeG/VHOD7kxQETGf2Hk2oA0tnwDyR7n3ujBLGauYm8+6cGUrtHTP2+Z3Y81XSpI+jVtOk5HI8T8fz/6U1yiO2j21vDbRbNQ/8fIJhEMSLf3WbV3e+Px1AwEcCFljWZviREiBoH3+RSufm7d2cvu6DNE71yCwM4tg9Omp6SyNGNVGCDrUM3gGLDEN2XpRoZxFHzjgyhUUkUQ0BZUBjmxjSqPdYscxy8g8G8Wem44MtdPeV6fDvLAAlpifAXBt68m6R9xxwlYgTrJ4VWlN/rOLhM4mWnpEVy0qx3Ryxn3Q1khNNhZ6cHHMEaXAXqEMtPJrz+CqfO/CqC3JB9FnleCRNmJmeg9NLb0BLh7KPwaNiZKLQ6ugCmDlKUt3Wy2GoOSYy/g12ikgrWXjZdXqdyeh7FobCTRmWy0L4H36tyA1t2pmj0BNOCiVnr0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(31686004)(38100700002)(44832011)(2906002)(66946007)(86362001)(5660300002)(31696002)(36756003)(4326008)(8936002)(8676002)(82960400001)(316002)(6512007)(6506007)(66476007)(2616005)(41300700001)(66556008)(83380400001)(6486002)(53546011)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBWbmRvZ2dlLzBwMGpmVlpvN3ZPbG42RWEzbUM5d0xOQTBuVVRWWlRpVVpO?=
 =?utf-8?B?aXo4SFczbE5KRFlJaGdvd3FySHNIV1BCVXN6MG5OY1dMUFV0dUREOTBaRkdW?=
 =?utf-8?B?WDZra00vbWN0cThNblJXQWdMS2ZSdUVKOXRDWENBNUIxSi9YWk05Z2V5andl?=
 =?utf-8?B?L2IxaFE0OHJiTzI4WUJucGVCTmh3WGVHU3VTOEYwL2d5Rjl3NEJaQWFDSmtP?=
 =?utf-8?B?VkdTckZod3h5TVkzdkxGNGVNejhsSk5tR3p6YVdlTnNHS25kS2JCOEZhOHVz?=
 =?utf-8?B?SlNqUTJ5MkFqWlpNait0VHQxOUhpNm9nOStNdXNTQ1VwclpSd0w4QklWQnBp?=
 =?utf-8?B?NXl4cm1CcGJrNzRLeGMwNm8xWTE5aUJYVTVSbk1KQlNWRjZkc2J6UnpzWEJX?=
 =?utf-8?B?NjZjbjVPTUNCZ240MUxSSFd4VktZTVF2R0w5R1dUZVEzaW0reTVlZTdYTzJl?=
 =?utf-8?B?YkFSaVBLaUF3YVhFdy9IUWhVN0YwQ3ZwTUNaK1RqcnFQeHJiaGZIUTN3SlY2?=
 =?utf-8?B?b1FzbVVKaFViUC9KZEM0WXROSmRNeVY2ajlDM1lGL1A3cmJDWE9kZnZKS1dx?=
 =?utf-8?B?VFBBdFl5N2d6MUVHUXZ4aDBoWXJ1RWJ1VkpDaVFva1RrZWZLcXFiN1RIVlY1?=
 =?utf-8?B?RDNtTU9FenIvZjFpd0d4ZGFOd2YxdGFvazVwditlbVFMSlNtb3JUMTNKOU1o?=
 =?utf-8?B?RzV0YUxleGRuUVUrd2dVL1dHQzBoNnVOS1RXOG40T3kzcEFZY2VLa3ZKakpY?=
 =?utf-8?B?cUFRSnZOMVQwWWxRdnJ1NGV1V2RjL3JibHk1L3Q3TVJZYWVYQlNpMklKK3BL?=
 =?utf-8?B?VGVXQ3hESWdkODYvNHFudW54RXJmS2lEdnZWYVNmNXAzS2xMb0dEb1pXTFpF?=
 =?utf-8?B?VVI3ZkYrak5pL25yT1JzV0phN2hQYm1BVG9GNWNBYUIyVHdMZ0hTUDZJYm5w?=
 =?utf-8?B?QzBxKzRTcm5rc1lFT3d1N09sc2lES0RsZU0yYVAydmI4QkhYRlNXVDIyNm5N?=
 =?utf-8?B?ckEwVE8zRDh0aDJicTRhWXcvcjFvSWpXZVJxUVhVTlhLbXlRcDVNVVJuTSt3?=
 =?utf-8?B?cmpJWDM5QUNPY3JNcEMzSWFVYzZIa2VoWDNRNHExenFQVVJGSTlEV1Mxaklu?=
 =?utf-8?B?MXZBVkR3cnFhUFhwbXA4aTdyWlNWLzFMMTZtUVBLcDZzRjNvd0c5T01FWkYr?=
 =?utf-8?B?bW5PRU9WeXNUT3F3QkMwTFRnSjVTbHhjQ1M2bTBKY0cyMkZKWjBEUktNd3F5?=
 =?utf-8?B?a3RPWXN2Y1JDcCtpUU1pSG0zQU00NDdxaVlCenlwT2huVEJ4dnV6MThya1BN?=
 =?utf-8?B?RCtRZEVrSDBhd3ArQkVjVWd0dzd3YXVJbkdlbUtzN2FtK1BiNXFqSlRMa1FF?=
 =?utf-8?B?dWk2ZFE2eWJoZ0h1dWt2ZkFneDJOOHdQRDA4dlVteXR5VWhkWXBmUlB4VFVW?=
 =?utf-8?B?WGMzRTdxOXJtSUczbnNGWnBEWmhENnN3S3EvWHRPY0RVYTRyNDVJRlZIak5y?=
 =?utf-8?B?cTVyWVdkVS9IQlQ3ZldYa2UyMDV3UGk3M05heStvb01IMzFtQ3NCSnd2R2NX?=
 =?utf-8?B?ZHNHcWxwa0dNMFRsQVpkTDdrVnk2NnRVckxBUVljQVpvdHVtL2JVc0w2ZXVv?=
 =?utf-8?B?VWJ5MGQySEFZQk5iOFB2Rm96ZHRCbm90dDY5b2tWdW1NL280SnRwRW53czNO?=
 =?utf-8?B?RU1RWS9qMm1KY1E2dklJU0MyNFUrSXV6dnlabU9XQjlMdEN6clgwUS9Bcysy?=
 =?utf-8?B?UnRRWUgwOUE5ZGxramhySEtWUGZjOFhybXhuK0t1RjRpRkpDOGZ4QVA5WlEz?=
 =?utf-8?B?Qjh5cExYV2RoZHExT2RrTUJ0ekgyYTNFNWhPQ0FET0ZMNE1BSWtQN25tc2Nt?=
 =?utf-8?B?Qy9iZ0lDZjVJY3R4T2RMOGs0bHFJSkEwL3pkbEIyNldnYUhmM3VTMmNLZ205?=
 =?utf-8?B?UjM1c2l0aHIyYVpiUnhiRTVsVWgzaEo4YzQ0Vmd6amd3RzNHK0ZkelFWZjBQ?=
 =?utf-8?B?b2QwenQrTXZNQ1owbUF4WS84WTRsd2pGVWpTWUdiYkxXWno4VldvVWFIZEhn?=
 =?utf-8?B?QVh4Y045SnpsT2RHdVFyZno0VGhCVGMvaFJHalc3SGlEb2tYdHFZbTVlbDRr?=
 =?utf-8?B?VStEeitiRlQvM0JqN1JFNUNOUXFsWkEzUDdNTjNCaStHTFBHRWFyclYrZXZ6?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55688af-2f6b-4526-9892-08dbd60f71a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:36:42.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1EGyUoLy8RPXhPBlYBCBDK3bwXHd9g7AcDcB0ej5d5CS1gN4VfNass8Egtw/Pyyg/gxiaJw1MAJvY4Js/H/k9zFRkX2TW732KtzFkczOX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

On 26.10.2023 03:32, Michael Chan wrote:
> The recent firmware interface change has added 2 counters in struct
> rx_port_stats_ext. This caused 2 stray ethtool counters to be
> displayed.
> 
> Since new counters are added from time to time, fix it so that the
> ethtool logic will only display up to the maximum known counters.
> These 2 counters are not used by production firmware yet.
> 
> Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")

If this is a fix than the target should be "net" not "net-next".

> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 28 +++++++++++++++----
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 53442aaabe5e..f3f384773ac0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -535,6 +535,7 @@ static int bnxt_get_num_ring_stats(struct bnxt *bp)
>  static int bnxt_get_num_stats(struct bnxt *bp)
>  {
>  	int num_stats = bnxt_get_num_ring_stats(bp);
> +	int len;
>  
>  	num_stats += BNXT_NUM_RING_ERR_STATS;
>  
> @@ -542,8 +543,12 @@ static int bnxt_get_num_stats(struct bnxt *bp)
>  		num_stats += BNXT_NUM_PORT_STATS;
>  
>  	if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
> -		num_stats += bp->fw_rx_stats_ext_size +
> -			     bp->fw_tx_stats_ext_size;
> +		len = min_t(int, bp->fw_rx_stats_ext_size,
> +			    ARRAY_SIZE(bnxt_port_stats_ext_arr));

You don't need "len" var.
Why not just:
	num_stats += min_t(int, bp->fw_rx_stats_ext_size,
			   ARRAY_SIZE(bnxt_port_stats_ext_arr));

> +		num_stats += len;
> +		len = min_t(int, bp->fw_tx_stats_ext_size,
> +			    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
> +		num_stats += len;
>  		if (bp->pri2cos_valid)
>  			num_stats += BNXT_NUM_STATS_PRI;
>  	}
> @@ -653,12 +658,17 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
>  	if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
>  		u64 *rx_port_stats_ext = bp->rx_port_stats_ext.sw_stats;
>  		u64 *tx_port_stats_ext = bp->tx_port_stats_ext.sw_stats;
> +		u32 len;
>  
> -		for (i = 0; i < bp->fw_rx_stats_ext_size; i++, j++) {
> +		len = min_t(u32, bp->fw_rx_stats_ext_size,
> +			    ARRAY_SIZE(bnxt_port_stats_ext_arr));
> +		for (i = 0; i < len; i++, j++) {
>  			buf[j] = *(rx_port_stats_ext +
>  				   bnxt_port_stats_ext_arr[i].offset);
>  		}
> -		for (i = 0; i < bp->fw_tx_stats_ext_size; i++, j++) {
> +		len = min_t(u32, bp->fw_tx_stats_ext_size,
> +			    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
> +		for (i = 0; i < len; i++, j++) {
>  			buf[j] = *(tx_port_stats_ext +
>  				   bnxt_tx_port_stats_ext_arr[i].offset);
>  		}
> @@ -757,11 +767,17 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
>  			}
>  		}
>  		if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
> -			for (i = 0; i < bp->fw_rx_stats_ext_size; i++) {
> +			u32 len;
> +
> +			len = min_t(u32, bp->fw_rx_stats_ext_size,
> +				    ARRAY_SIZE(bnxt_port_stats_ext_arr));
> +			for (i = 0; i < len; i++) {
>  				strcpy(buf, bnxt_port_stats_ext_arr[i].string);
>  				buf += ETH_GSTRING_LEN;
>  			}
> -			for (i = 0; i < bp->fw_tx_stats_ext_size; i++) {
> +			len = min_t(u32, bp->fw_tx_stats_ext_size,
> +				    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
> +			for (i = 0; i < len; i++) {
>  				strcpy(buf,
>  				       bnxt_tx_port_stats_ext_arr[i].string);
>  				buf += ETH_GSTRING_LEN;

