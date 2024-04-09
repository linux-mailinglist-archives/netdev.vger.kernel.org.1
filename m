Return-Path: <netdev+bounces-86322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0B89E649
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B91C20ED6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C915B0EF;
	Tue,  9 Apr 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSoaHvpn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48F15B0F2
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706129; cv=fail; b=PJJtYj7Te7nyIV0NsYvxtdpOCth54eLg6oJR0VIbPpbvaZZQ52Fc3XF+Wz3DEhxjdTa3RqORNFUeFNaYM3uzw+VA9VAabWXwtjSQjeOxitDG+YL4NQZ/vSIRD7MmjM7aPsSZ+dklPoq485K6WhmKHrB3ff9ySX6vsgRQezDyAR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706129; c=relaxed/simple;
	bh=WkXmQvIC/jx4WgAz7dMavPjD9+PUvWYAWRCjkj0RG5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGuF6vy1DkmaNqYbmW+xbnqR8AYGu76YBkS38FeYRkQB8pY1rZMrHFyiYMiUzEYCdzxPQQdr8t5hE2Eq+Tm6AaJ2zpXsUawuQxVimE1E177SpyNTl5qqvQO5qx/LMLhfoAKRiSKw6N/vK5ITpd6Xxv7xFtvcyhKfjDR7HNRY3Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSoaHvpn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706128; x=1744242128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WkXmQvIC/jx4WgAz7dMavPjD9+PUvWYAWRCjkj0RG5Y=;
  b=WSoaHvpn4dUffNLf/KsmxkJi9nbn2LZ4B1bJhzBuOkatwUvUT5V1c/So
   wsmJoI7m8UYAHhB7O2KUQ7XYuh9HpaP7RRMXBuvOYUjOOIgIPApAehU6x
   l2aBfU7Gxedf4Nz4EfcjE1xjNKM74WAcRwQN/5NJ/GlVDze3xJNl3dk1y
   xF8iFWuNE6wmOSByA+BBaagpbXuKwExaoAS0ICY+fgfFCeMvWKD4uMBXe
   +1R4fsG+NBSgtC4uhWWSmsiNjqoc0vamoDIQF3Bti4hmQJims6JQiWPXU
   HGTdVkg7IYxHVysRL5UtDBwLg+8MVPh20SRN4gxVa+Yci5QoOPwivkuPr
   A==;
X-CSE-ConnectionGUID: eH/ylUVaRCGzuQUZu8jGTw==
X-CSE-MsgGUID: JLMd8ua7RE6unTIjRqUB4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18763668"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18763668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:42:07 -0700
X-CSE-ConnectionGUID: sb3rCWoyQJi7shz5HBTW9g==
X-CSE-MsgGUID: FJ8aGgXdRRO+hD3iXci4gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24865377"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:42:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:42:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:42:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKgEix7tVNbfr2UFs+8PHbzjQ6VRrXe28+0Q8CxxCtGp05s+Vt4UuVmFqgLI9OfODRAYS0NxpN3ykST56Ye4AKEvjfOni1dHeTLZct/gFG0yPXONwyh0BNBHGyaLiQVEARUxRBV9KwW7KAfPflU/CLU6FUfnPtarEKCTM17rE4dA3v7wJEUspWJyHawRssnMMuzfp4VZNeRMkDU1cVLeyKVTBUeD/Km5JGcHG9dNKYACnO8Qwfk+PcaiYC2eQytkX9J7Lwb+vwxBcLf0QCCGLP+pe/kbdZMmd4b17CoRYHoTfSAIGT0giN7m1yr4aVOcOKrUydlFGSPxpJvMbsxOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOdxUcz4g9bvYV4ljTA2/eOASN/SeYzxYn0yYf/GhL8=;
 b=RHxHtQH/qbbo97x7F/dNR+WNizNc8VMwpyX/QQxPq4YbtjtRoh7Y7yEpZFrNiwFjL7UuUY5zAsctypYkFn3KAgHi4IZMbOT1JwpWEB2YrKDUFQkC/Mdcm3Cjx/xc57DELcifWZBMUeigBFura1cxlhtp4nGOZrTWQypvGTg9DZDkZOwTYeRqsV817BrhVfAzseLtWudFMz00CdkHTL0+2EEuxDlORqPH1skZ936ePwdO9DOJKBMl8bC9LrU4x77fOXnQCVixSuEepHSCoQysGnGSFw8jUkcUGJxt0owetOELwkRZVDzd0B+Z+lmfbG1cOwiExByzoYdK/oPab/vK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:42:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:42:04 +0000
Message-ID: <17b3d748-e921-4376-9413-387b4ff686ff@intel.com>
Date: Tue, 9 Apr 2024 16:42:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] bnxt_en: Update MODULE_DESCRIPTION
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-8-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-8-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6EEykTU3m/4viZpjMeE/IRKfaYjspjMTTYiNLGyFwogBn5AQwUN4ioAGMeUWw5837M8FVK66lCDHjc+qoirBqbgvr4qeLDvxOmLzJw3pJe2nrVI1CCYvWuUp/L8MfWlxMDTodEQxmfbov9/qETCWybQ4O6Tdhutvzb8yNTdutZuduTZXM+YDnGdixpa2VrUGjxnEiaj47E/AJLeaJVbwGiP8zoS1mmra9SrPhns+BYofFrSfq+wjGssKWNQHvWWP4fDMcPOhD0fSJlZ+qx2JCpEQ9ZrlHQqyyVPHvaQ6BtRXH4wqD1p+24bWjoO/LZOqtvLHO0ugavQII06xjgF3CsfvfqG6YyN99VEZ7ar15e7vLs1wshJSrUuJRvC8bQjzEGpACnXtHpwMG83yEyqdSVJYHqpmKi2vpXjR4D/pnY/RDvg+z1gFdNQUFIAN7yn55pYHVdiXkFNyvZ8L91Yi5/KWMo5Am3exmv2kgMUPoEA0b8hJeSJypKvpZDCEF7QiVDIgKRglZw1fOF51qx5mFn0nd/3qUHPVbAMu0GqFo/LeTuRbd+2k4irWQrvvFEW7Vxks7xrgbZkIGTiLfmHghGBZaEVHqtFF45vhG6/LRdfCHz8gx1+oD48rDcRo4KKH+vMzH6rmrKI5Kh/hMHwOAFrCjjQPtg8UkQMJ3ysA6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21tNnhDTWY4dkxnYmE5bEIvTXJERXQvdmZiYzd2SW8wd00weVRNcjlLUUQw?=
 =?utf-8?B?UUZEYVdoK2JRU1V2aEE1NkVOeksremUrd3FXNUdaSTB0L0hPc2VQVzdvVmhX?=
 =?utf-8?B?S2JReUU3a2hiSUhXLzErLzMyOUh1R2o2bGZYek1ZM3M1M2ZKUmt0VHhZTzRk?=
 =?utf-8?B?Yks5S3VHTTMxS1p0Z1ZiWm1KT1o0NVRLcEVuc0NDblB6SnB4K1FET24zaVdK?=
 =?utf-8?B?ajZEMFhLdkd6ZzlrM2dJU3ZERHByUkdSRFJGQlB0SWtCdTg5WmRxQTZ4WXBF?=
 =?utf-8?B?NCthc2EzMkF3NnhCa2ZhYjErK012VUxPeXUrbzR0cHBCOVQyanNrRFYxUkFm?=
 =?utf-8?B?TE1tNFRCSjdyTVNQYTlUWTdZbW5NdlZJamUvNE1IekZyQXVVTi9wS2dXbEli?=
 =?utf-8?B?SzFqb3FjY3E1Ylo5ekl4QWFsK1hjeFV5azRXbFVhbUluWGZWZVB1Sk1ua3pj?=
 =?utf-8?B?aHRBRzJsNDk0eXVpYnNhcUpOS1ZyMWFadGFMa0NvUTBvMExKcmxsSWF1MlNC?=
 =?utf-8?B?SjJ2VWZscitrQ0tlbkdFUEdzSm9YK3pmYTl6TmFYYUVLaHdRdGtTd3ZWRm5R?=
 =?utf-8?B?RUtWcnl5S2ZiN1Zjc2doNCt5VWQvSGo1ejI0MjhFck1XdFpSU0o0UVhMN3hj?=
 =?utf-8?B?UXNOd3VwM05mMzdsTWlBU3kxV0U1VW9WVldvY2xQUFpPVURqTGVveXRoZVhE?=
 =?utf-8?B?dHFRRUF6WUh3NWtWdkVic0o2WXlZUzhZRGFzVjNFUHVVR2RxdVFaeGsvWlBm?=
 =?utf-8?B?VHNCeWpaV3UzeGxlbTcxQ1NTcE5kR1QyZzcyZ3QzcURXNEFyV1hUaUZ2VTFl?=
 =?utf-8?B?Zy8zNHcvbGdKTDdzZE80UmJkdk01K3NONTA2WitoOTBLQVhwajNQL3BlTzFy?=
 =?utf-8?B?bGg1QjJ2WkVWRjZOWGV2RG05eitnWW84dEZhODBPaWV4ZlY2RVZIWTRHV3Nj?=
 =?utf-8?B?WXFheWg3Z3RTMUQ2SmVzOVBER054ZjFBQWdlM3UyT1c3QklieWREcTlUYkwz?=
 =?utf-8?B?WjluelMvY3BhSDBhTDY3ajlhQUJPZW5VNjdmck1nZFpnVS9PYjlvcDVQalRu?=
 =?utf-8?B?eUM4RHNmREg2dFEzRklUQ20wNmNoeFp0MmxLa3pQSzU5SkFoNXhHUllVL1hE?=
 =?utf-8?B?WEdFKzcvQm93aHVkTS9CeE56NWFUNVhhYytHeFZKYUd5clhJdVo3d3gvMWxQ?=
 =?utf-8?B?cmU0Q05OanErZ1hmV3pjbTQ0d3hCczlpL1hzTG9kUms3MTd5YUN4blNKWVlk?=
 =?utf-8?B?RitpYzAzNnZpVXBFNncvV3JBNlZMOC9SbmF5VDVTL1dRd1VtMHRtU2RzTWpX?=
 =?utf-8?B?Z2hOZm5vU2REWCs2Tzd5eTZSc1ZzNFdDV0k4VW5wK1pwM0FlL3I5bjBtbEFL?=
 =?utf-8?B?RzhzMmVvUU9KOFRibDU4S0JZNU9abUtoaWJtbHJNNzVWY1RJYkNZOUlKQVlW?=
 =?utf-8?B?UmFvN3JMNFpHL0k5SkgyLzM5eHRHbWpkZDdBbkVQTGR1MlpwVnFCRGl4OE01?=
 =?utf-8?B?c2M3OFlrYnNEMnJLN0hYcHhhZWs2N1dUbWk3cUF2WlhKOUdIdnNRdGFqU2Zr?=
 =?utf-8?B?amdFY0pLTTI5d0xDMUFTT1ZxMi9mditTUHM5WHZyUFNxOHExM3VpaFpPU0Uz?=
 =?utf-8?B?S05ZNjJiUXBXQVAreCs1cXVYaDJJc1JZOW4xZFdPNEN0enY5b1h5SUxybXg4?=
 =?utf-8?B?TnRTdnBXK2JVRGFNYzNUc1k2bmtVWGNSOUNzN0I1bm1Cc2R1Tnp3NmltS3Yz?=
 =?utf-8?B?dkUxWExFNTIxV0NURVNtNUZQV0kxTlFGMFMrSjh1Y2NCcWQzTGhHeE84dnpn?=
 =?utf-8?B?NGhwMzFPMi9SNlZKMnNZMFFSL3RMUkorWlhHcmNJZnNzOWJmNnFYclVaQTZZ?=
 =?utf-8?B?K1V6eGR2cEwySklWeWpsb2xaQnhkWmtDdElXUGxTblgyRmVsWDB0Y1lPZ3U5?=
 =?utf-8?B?c001RXN2SXpUZWx2S1cxTnlHUkcvSnJPR1pCbTJYbWdTODJqdDdqRnhkcDVO?=
 =?utf-8?B?RjNrOHBkdUk0YWxCZTdwMVNjekhFbUdHbUozRWJzS3JyOHJCV1lIcUJ5SVl2?=
 =?utf-8?B?SzhxYUxGdGNrYzc2S1JaSDdhNzhRNFRWL2hab011OFNWVGNod3Jkc0hEc0hj?=
 =?utf-8?B?WHFzcEpJM2JwL3ZyRHdZNE84MVk1eXh1TCtuYk9Cd24rR0hwbXczVEt4RU1M?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab12890-8364-4188-e06d-08dc58eea970
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:42:04.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZR3kNfLbdjstTNnoEe1Qd61KDrC8gRSx+UvwtSrmf2AYdGZtAPP3E34vf6fxwp7LxSGYdq+hznd07ALljFyLgUbBRYH2VF7KrvDRVnCyKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> Update MODULE_DESCRIPTION to the more generic adapter family name.
> The old name only includes the first generation of supported
> adapters.
> 
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index a2e21fe64ab9..d728df139c9c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -76,7 +76,7 @@
>  				 NETIF_MSG_TX_ERR)
>  
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("Broadcom BCM573xx network driver");
> +MODULE_DESCRIPTION("Broadcom NetXtreme network driver");
>  
>  #define BNXT_RX_OFFSET (NET_SKB_PAD + NET_IP_ALIGN)
>  #define BNXT_RX_DMA_OFFSET NET_SKB_PAD

