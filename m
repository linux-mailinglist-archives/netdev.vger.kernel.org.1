Return-Path: <netdev+bounces-45979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09347E0A82
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA97281F66
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB3208A7;
	Fri,  3 Nov 2023 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLN41Ch2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A71CF91
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 20:50:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C220D53
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699044640; x=1730580640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NNzq388MdW6cuVsEjDDARGDoA2ZFuZ2KMmUh61+tz1s=;
  b=mLN41Ch21NGYClgOdfwrbVokg870kIasTq5pKDbvxZ3hWFqXrfanRd10
   xXgfG+kKKZKAjjhRIa/LgRrdo8X4kAEDjTxnm2nP1jn96cxospAAfrgf0
   71CeuU9wv5l26W3JcioGXPufT/Vibddfrap7jYdBFZT9uK4fKs6AWIYYf
   2rTuhewMfswIks9GU08GBkY3kzsotSFKfEcaNL3seonp+b/6FXo21AhuZ
   VphllemmnSJvnrpNZDLIPnWmdn+e+LHksq+6qz+IyIcmF2eBDrz7Of88W
   yl1KovUQ+fbDMjeTxASTIYby/BsSBSWEUGXPmGMUZTymbdjiCfop4RiJe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="420135812"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="420135812"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="711624781"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="711624781"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 13:50:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:50:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 13:50:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 13:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGZ/GGhHiVWqq8Kye0GEJomLaJAA/bngYg55KCRoH9jYdMTF7xTMthuhJ5Gg6ZWxkY01jbbmDDJaHC1YZu98DW9pHPG5XDJ3e/ZProeoSyS7UN232ArcOK1EqeGQECjTO2JmKOFv7CkkHxDOwOF5ywSKedD8cT7tKwCUkjadQQ6ikWXlyaKk+idCtosY8ajIBwwG2Myx4W1flYEnUzSLcuOIFbl4jDBlGaEUMH4VTk5Kz8bk+9MTcsOdMQ/5AxS7M0QpEqIv35138yimhQHq1c1Bpve7dU+uRSCezL/bFHP4oN2CkFcfwsJrJOLpxiKz8analGdJxd1rM+8WBIiDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyrFCsN2P9t2M+i2fz6S7mn+pB4cwJ5LCa+XwhjTXS4=;
 b=Hb3itQRIU3MEZH90yHK2XCFVz/8UcGRLN3WGhwmlbezYSl8ep9+ORkZ6l3goEH4p9lz55X81X+wR+iRpjL0N24bcTASbjF/GeiDG3VG+s7qyykUNPxJymV57cVBakJ/ToUXJNagS6mdPZihxuohPklIyfzyeJ+vRSJ60QNLXipBou30CSotkajBqDw6yvcFOGgKm2M1tE1zUzZZUb2lB6WjxitmLGqQyXJuuTmlLwVNBvxQEHqp31tJEwqi3wlBTJz7G6f4ZtSi5cW7WH9DX3phVXAQ5hiBFeHLWjiMNuMf3z/Od/54FiKSHAKPxRJIZuThOQJTFkKJKtHMfS+MNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 20:50:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 20:50:35 +0000
Message-ID: <99f7ebc7-5703-4ed2-853d-fcbbf8c074e1@intel.com>
Date: Fri, 3 Nov 2023 13:50:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: fix potential use-after-free in idpf_tso()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Alan Brady <alan.brady@intel.com>, Madhu Chittim
	<madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>, "Sridhar
 Samudrala" <sridhar.samudrala@intel.com>, Willem de Bruijn
	<willemb@google.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Bailey Forrest <bcf@google.com>
References: <20231103200451.514047-1-edumazet@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231103200451.514047-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c4af1c-f4f2-413a-82f2-08dbdcae86e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIsv87l42Na1ODayeYYLNjTSZBsF6fHcJDrZM28ALNZom20i8L1/X9Or96cAaZEguZIeFpX4xRPY1q/qpo8qMa5FADjpr/gvzy/xq4scMdYfZD4ou9CHZEi0RQeHD3rLmvWzGvke/x7wmIrdUn4CWywQ0qkV2dpOiQHEo9jAFoQ9wulpHn8J7xJSLr9aWyfo1ZSqlXWqEo8wO2DuO4DehlGUYMh47sN9vp+BRKKU/s4Rv75CFo6JA81hXg3TZWZ0stivzcIZhXoBOKRfNdBg3WOS6eBcVLWgFEQYkaz8dXdg1XtqiF7mnoe+Mh2NCRmr15HYhdFOd2HWVzebmVfhvEeUhdIEhkpnfRrHPq0b7TsZUF47qWt5BDO6FawRs/qXtIVaMBQbjc7iYY4lXElEPHe7gErqrlN00vXtCjqfp/5yu/RoUl3QwThA8FyZHPGwHKuNlDx0v8NjajhiQF3TVw/ylhsHSG+NrRkvrrFCaHeu7Q2w5WSITNKv2H9vLNWsbw8f9l6iZhmvUZDc9r8DZ191z5DnBiaranLqhvUi5m6tu1F2+Ivx8IHAxO7NhgcLfSnKgcqMcr72hs/8nS1KfrNssRM6HwEVgOSww9YLp86I5aSaJDleJb4EbU4qjydLSh00MYyXHg3WpEaHJWi9Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(2616005)(26005)(8936002)(8676002)(41300700001)(31696002)(110136005)(5660300002)(86362001)(82960400001)(6486002)(4326008)(54906003)(316002)(66476007)(36756003)(66946007)(6506007)(66556008)(478600001)(6512007)(53546011)(31686004)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEU2WGJFaE9yZFNCem5EcTA5N09oTUVscC9ETTlzeEE3WkZlSGNHVjNUd3hR?=
 =?utf-8?B?dTQ4YlEzSEJ1UnBRem9Ib0lyZmtnMEhrREdYRU9RTjNVaVZyRGJUZnBQSGhN?=
 =?utf-8?B?UlJoV3NLT3VJWG5qRWlTM3ZmL0V3cEdHNDJ3NHp4OVpSOXZyNkFRYlJOSnpT?=
 =?utf-8?B?Rlp1TjlaWVkzcnBXK1M1dlVlR1lvYnlaZGxsVUpRbnhvbDZSWUZjVWozOWY2?=
 =?utf-8?B?b21vWTEySkE5TEVBWHVLaDRreVpMVzBlVDhXSEVqd1FCNnpDNTBCNXZPakFn?=
 =?utf-8?B?ak9jUmFIbmUwMXRoNTJKbUNSTGJhV2hsTk5FSVdaQ0s4bWE1Ulh0UHpKeGpI?=
 =?utf-8?B?eDZ5OU1ITkllbXBKcEMrUTNwSnFkaVNqNnFpd1ZvKzUxUHIvMzVaNzlzQXgv?=
 =?utf-8?B?di9USGF6UnhoTzFQdjF4N0pFcGlBZTN0NFZOR2JHN2J1RVdMbENyTkRodTlS?=
 =?utf-8?B?aExadk05ZlNLK1lxMEI4TVRSZUxiZ0tkVkduRGh2YkU3UE5uR2Z6K0xCNXVN?=
 =?utf-8?B?STVUazdNZTllNGYyS09pdkRNU0Q5dm1iOHJFalhDSEd4MGNWNGNQdk8yWDBv?=
 =?utf-8?B?YTY1eE1NdlZHUEc3UEllTTJSVERwRkdnMEp1cUpvZ1hncEZmUGZCMEVSakpn?=
 =?utf-8?B?bjNER1hZRkZUZ1BCWndiTHBJTmEzVE55WXlYTzZoTk1YN3FsZTZKWEt2WjY1?=
 =?utf-8?B?TkVXczlON2xrTWU3eDNPZlY5ZFZmYUFieDU4Z1FtUWhSY1JsYXdZSFVjVDRS?=
 =?utf-8?B?OWNSUlFIUjJNOVh1RXppYWpseHU2VUJKak9FaFA2bWZybElZSGYwcEhoenZN?=
 =?utf-8?B?WFBUSUFySHVGSVhXay9zNVkyS25KL003VjdQSFhXcEErbzBUSWFYbmx6VnRT?=
 =?utf-8?B?Sit2cTdlaUl4c1FGRVAwMlNtV1QwWDlNS1Q0cEJTdW5jYkM0d044ZTFnKzdp?=
 =?utf-8?B?Z1lXbE1NRkNkUkcrL3VzRFZUQUpCNEQ1bm0rYnFKUk5vUmtOLytibmxZdHh4?=
 =?utf-8?B?UDFoNk5qOERsRkh6dVBWWEVsQ0w1ZVBVSWRLNmtmMjBNeDFqZjZiOE8zVlRw?=
 =?utf-8?B?ejF1R3VVZlVMV2ZvbG5scm02d0pNY1Z0bHhTemlNL0tLdUJVRGsvVlNLY2dS?=
 =?utf-8?B?Y0hRWHBkUCs4K1BJV0doWGUrR0lNQ1ZuZEhhME5ZVnBHRDNiT3VrRjJPMnEx?=
 =?utf-8?B?OHYyS0thMUg0TkFVci9MeXg2MVQ0OG5La3J4TjYxdFdrZVdBRktYNUNEdjAz?=
 =?utf-8?B?UURhREY4NjZMSE9Vd3U3NFhDTXplU3JlbjA1S09wcVpvQ0krWjczQ0RDOEts?=
 =?utf-8?B?QmdtWkQ1WnRKeGNkMDZSd1huNGYvRHhqaEJ3b1ZSUmluaFh0QjR4R2dvS2du?=
 =?utf-8?B?YW1qZk8yOGVid2l4dnp4NXY4QkQ3Qm1PZlVHWEZsWmp6M29ucUhLM1pReXBq?=
 =?utf-8?B?SjRlMUpHcitLbWhlUlp0WGpDNFJWNXE3SXd0Y1BUMENOczVvWEV5dEhGTCtX?=
 =?utf-8?B?emRFYmpVeEh4elBHd0V6bSswMXU4UzhXSVA4V01JUXVXcHZ4M3lPcDFpMk02?=
 =?utf-8?B?WDkyemx1eHNWWTdRcG1GV1dxM0lxd2prVm44M1BTWUR4c1htU1hmVEhzQm5Y?=
 =?utf-8?B?OFJYZjl3RkpISDZIc3E5WnA2SElmTDhpWWpvV2tpWG9zOTl2SStHSC9PNldQ?=
 =?utf-8?B?Yit0Qm1rNCtCdGxMQlREVkYvSGdOS1RLb0o0N3R2ME1hQ1lzRDNRRDU5NC84?=
 =?utf-8?B?ZDJEdkx1Z2ZmY3dUTzRITld1dmJES3JMbXFsWHhrTi84MytXc3ZTUWFaeVNE?=
 =?utf-8?B?NHRXWDBnb1B3S3NMMHpiTTAzNStwQzRDSXhSUmdqT0FHSFJPeFMzR1ljMjNY?=
 =?utf-8?B?RzgxZUFCM1JOZEVER3FFcnM0ZlZxa3lYUHBrNElNRU1jMDBRVm9CMWdGeGZa?=
 =?utf-8?B?azROa2tVT2ljWm9QdXNsci9zZWczaEdvVVlsOWpZaVlJall3SVptZG13a0hx?=
 =?utf-8?B?MjRlSm9aZ3M3UW02ZGNlSXd0ZXR6TmZLQ1BlaXlaa0pMcW1jeFZIMHBvK1Zp?=
 =?utf-8?B?VWgwYmRMYzl6V3FXQzFMV3VOQWpGTjhYa25sOXE1cDd4VTNXOTVoaDIxd0Fo?=
 =?utf-8?B?R3M0RmdERkx3UEhueDQ5NVVWdXNOU1ZlOGt0SDVsK01KVTdQY2NHRFc5N3Jj?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c4af1c-f4f2-413a-82f2-08dbdcae86e3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:50:35.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9fGpw2JL1oh6y0Gmv08HgGdD3WsR89oDY01ULyN5J0zr0mWR0zYq39izjLrpl40gEgxX+9wGXfXV4e7bzq+MwkLvhJCqKqkIbDmX7W6jWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com



On 11/3/2023 1:04 PM, Eric Dumazet wrote:
> skb_cow_head() can change skb->head (and thus skb_shinfo(skb))
> 
> We must not cache skb_shinfo(skb) before skb_cow_head().
> 
> Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Joshua Hay <joshua.a.hay@intel.com>
> Cc: Alan Brady <alan.brady@intel.com>
> Cc: Madhu Chittim <madhu.chittim@intel.com>
> Cc: Phani Burra <phani.r.burra@intel.com>
> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Bailey Forrest <bcf@google.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 5e1ef70d54fe4147a42e5a3263b73cd3e6316679..1f728a9004d9e40d4434534422a42c8c537f5eae 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2365,7 +2365,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
>   */
>  int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
>  {
> -	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	const struct skb_shared_info *shinfo;
>  	union {
>  		struct iphdr *v4;
>  		struct ipv6hdr *v6;
> @@ -2379,13 +2379,15 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
>  	u32 paylen, l4_start;
>  	int err;
>  
> -	if (!shinfo->gso_size)
> +	if (!skb_is_gso(skb))
>  		return 0;
>  
>  	err = skb_cow_head(skb, 0);
>  	if (err < 0)
>  		return err;
>  
> +	shinfo = skb_shinfo(skb);
> +
>  	ip.hdr = skb_network_header(skb);
>  	l4.hdr = skb_transport_header(skb);
>  

