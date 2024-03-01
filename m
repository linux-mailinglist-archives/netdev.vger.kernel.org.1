Return-Path: <netdev+bounces-76628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7B86E676
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA691F2A31C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26C3A1C5;
	Fri,  1 Mar 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv4Xas3B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68239AD4
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312088; cv=fail; b=doADeuufQzLyaJ1q1vpf3cJots4PtqbARb2qxK6qzO9MJX0xyeR3KZ2AtdCWhYasiajUFM7KXGT3rwfnNDAFI+Q8U814RjNwCZCfgxqenL9Bi+XHcPYHF6cRHNlo3rb59gjE9NmBmK4h/DtH8wWC30mvvMfY7xAmHSo4UPMQBlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312088; c=relaxed/simple;
	bh=/SpECf5+mdBlmcUE5156nAS+E1SS/ozn3TWb1WRBMcs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gW52McrdgXLyxABvkqdxyDLHkq+ciCI+pbzD6bI4OC8e16uwffAgM1mYUNof2k2GXv7aPY555QvSIRYdPb0ztqeIpMWf2MB3Sky21/NVQqa+UXHR9XTXFMMmMESvPqsL7gF6uWJyCW7JOawi9yM4wneQuwcOujsEScYMvuha5xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv4Xas3B; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709312086; x=1740848086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/SpECf5+mdBlmcUE5156nAS+E1SS/ozn3TWb1WRBMcs=;
  b=Gv4Xas3BAfI6lqDyo3Wmx8N6ZqYEwO7kGP5oql4jYSfuW90MYReiq7N3
   UTYYtfrpCo50xsx7mzvgfZC3PZl7IADqDjCxn5p7cLKG137gJwrXmdWb0
   2WY2SjWOsoMYs2W0fdl2f78vpOWSHQ9EawXoiIVMQtbuGwywHqklewrJC
   nWUDzMocPf93vs/4toOsKNLAcX1XX7qRRKTqk7QMPxhQeb9PyArsN3tc3
   PCN49KteOLhNDGWI6q7RUnNkWLzacC8vmCf7SUMApVnM/wmALU75fHE1b
   YXAtg8p/CLjTb8O6eO+/S+VkUTvsbJrOtVrfYpSRzSvDFy8rRY1cdLat2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3710154"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3710154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8179509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 08:54:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 08:54:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 08:54:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 08:54:40 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:54:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUDtvzrfKBJKjC9tcLaXn2HACJvIeZn/Lz8H+fFRZvzrhI1YjoTNZAxeEo7RCV9JVI4jaN3/bjM8LvUWl4o7c/Qg4kn1bLcr/osNoNhfNWQd97IXynLE3udcGE3K1x10ATteppkN3PVgh5J5OwWx/I1g3FHQ/8s9ZioZq/e/GErP01+j8HTIuS24etoc1YN1bpyvHVb0z5bZXLj/65UnidtRf8PvOXDgisPt70kaUYRvj9ypFuQ6DJJmEawK7GfjqM/f5eVdrqM4jELyjZGO44A6NngF2taIlkL3zo6MJa93Ash2kKidAmTxd15QxJn3Pi6H3MQjO7vnjTB4fMG4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc5jXckRJpGQit9jh9mY3xaxGzqYnaGTz8AKCrEhNfc=;
 b=gg+Cd9P0w1Tmq9c7U8fAZEQDEa0ZwXjDDLLNPV7EGk4yvL6hYA7fqhqQxYwe6ks+dKVV7wsIm0mYGQJeXQM2ZvMbGcaegEhp9hCODFOREjh6Nnpg5AXrzLfn/Os2CPcw+7cMFO3O5n0cNLPdOAXCLYYlyWwthf/ou1VFQYpQutYzwB7chopHwfslk6fx8j/jKdnBtszBTf0OeIkzN+wz3K9HJ4QRRaMLZveWayn4HmPqwe/XDQ+C4VMD3fRX3XWim3Ek3+if/R4jz0kcY79Q5a0sUaJoexvAXqCEN4rUfieq5KyCCVv/+c44Eg08JYgTYHnAX/s+XwuBddK+UNwXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 16:54:34 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9d72:f2c2:684b:6b50%3]) with mapi id 15.20.7362.010; Fri, 1 Mar 2024
 16:54:34 +0000
Message-ID: <476eda4d-5a21-493b-a3a8-ac44e4f37ac3@intel.com>
Date: Fri, 1 Mar 2024 08:54:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: igc: remove unused embedded struct
 net_device
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
References: <20240301070255.3108375-1-kuba@kernel.org>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240301070255.3108375-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fd5caf-af8f-40dc-c3ec-08dc3a1045a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPXSrsxPw7pShgETRMd4EiZOgwFFSLFjXnWngOcg1Hk4ioRe8AdHfhc2XuNiL4kqzHiX5wObkupdWC/Jyn/m8Ykp9tJjEOacghu79w4jMLu9EI60bxWtXQ6iJ9CEehiqx2wWp2AOPJWGf9fIhxdySuPBMrx8MWa07+3/pWQlV0k1BJ4LNRzLszZio1CxWn9Sq44lMaShx/IPsIVByH8xgvYFfGSWaAaHAyEl1Tk/9aO2L+w+93KlcZFpEERKVWScYdhc47rOz2P75OmgCv7DhGZFGzBjy7DfnB3Dp442WSi73do2QQeMJGmfXTvbwwegkac9P399y7o3+XAGCLcmpSIbwlJHuhqU59X9pGQaUiGb6wtyJeSze1AjYq0Yapg+FlMekcYfKxx2TnQdY3wwfQDZT+JPaXWXSGzwm5udSdfZ9B4AyHhA0WchDItNqH1BbXaTGnLI80T+BSvIKRhrwu3No7KZEkyc+dcytbn/m5aXOoi7XyTiZSIQJCFjGJC77foTMG8lNxPb3X2TGGEd0x+3UC7f2J01gvchQBWqXwbV0vCSv5zoLethZ8oBWasvLMlJYSJ4ba4Wjnn/jxfHV6nAnEZq6lCl8HcjFnwkLAPcun4m0wwuSvyxxGbtWyVb01EzLKoU0V2n9uW0l4df6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJjRVdWR3BseXRGUUh5RGdkQ3pFbGU3SU8wdldxN2ZRMXgwQkRSb0VIT0xz?=
 =?utf-8?B?VmpXOTJRZkZxa1E2WC84NGY5bys3QUxrRW1JL3VYaFdJbDB6SEZsL3JRZTNv?=
 =?utf-8?B?OU1ZRUNhZzYwNnhzTERldC8rc0FGL082WGxtRlU2WFl2Z3VzV1ZKUWJCOVdP?=
 =?utf-8?B?SmFEQkQ3YlRhSnRyQ1MwR3BiR3lqYk16Q1JwdG9JSUt3SHFIa2tKbDVTcXlj?=
 =?utf-8?B?V3NqQjBYRVYxRU9NaisvVm1NLzE1OW9zWEpqRGRFOU1kWlpEc0xvUUJLTEVB?=
 =?utf-8?B?Z2FjR0cwVGVqTFM5WE9WbUxtTUdVT00vWkR1MWFYRG5kZ1dkV2pnUE9oeDBq?=
 =?utf-8?B?VXVJNUlqOU5PaEE5UzJLWVNLc1hTNnVNdS9pemJxWlg0OHAvT2owckVadFd4?=
 =?utf-8?B?cjl1VkszYk0xM3RNTjdRV3o3dFFoSjJWSXhrSzdCbnh3SndzWkhQZC9iWm1S?=
 =?utf-8?B?MmU1QkhxWVUrQXBHL2NXR0trTElkNFJXRm9DYkdFNDZJY2JKRjhKUlB3UDZT?=
 =?utf-8?B?MG1jd0FOa1pXdXN2c2ZyWVh2R3V0em9Pbk0yZ1BFaFBOc0NWY1hQcTVZOGY4?=
 =?utf-8?B?eEg3MmxaTXlXRG5CQ3VocmF0TDd6dWxjbDh5RXpvWTk4SVJ3aCtqZ28zL2x6?=
 =?utf-8?B?U2QzZERLcUhxaUFNODZhNkJSaVllWkVzL0t4NDZkMVU0OWY3aDM5R0VtblQ1?=
 =?utf-8?B?ZEZ5SUtTcHo3dy93S0VQM0tWbGcxMG9rTmRlNndPMUhaS3l4T2t1enpKaGdV?=
 =?utf-8?B?T0hnd1hoSjBzY1hKcHhzQWJUeTJ5d3VVNmNlSmZGZnB5K2Z6TTl0NjZaNCtC?=
 =?utf-8?B?WWlGRmtQUnVpVjFoYmViWnNseWxSVzh5MWRDS2d0SVZlUlRoK0lsOWhZUGZV?=
 =?utf-8?B?a3pEVmNyVEhyYVhHZWZQVkRZN3VEaGZEaXh5Q25rYVdKT3YySlZEQTVtUmdk?=
 =?utf-8?B?UjBzWStFN3ppdURYWTM2QS96NlYrdm0xUzhVd1ArbmwrNTNKOVdtS3JabE9i?=
 =?utf-8?B?UFl2RUN2amJqcFhFV2luYTFUblNEWVpUSGtrMHJnV2l1TG1wZFp6RGdWMFBt?=
 =?utf-8?B?aUVFcU05dXBOSzNHWkxFK1NoSnM1R29OZDlseW0yZHVVejZYSnpEQjJMK3RK?=
 =?utf-8?B?SjFiWFJna1VYSjArS0Zod1E2VWRUTXI4NWhkN0ZaMW9Xb05MSkFuZmRHMWdW?=
 =?utf-8?B?WDVTNTlGT2x0TnM1b1JsTjd2cCs2dVFkekdpVU9uRVE0STFmMjhuTjM0SG1K?=
 =?utf-8?B?MFhVLzR3U0F5REN6MG1NdWFTMUdSQlZUTGdGVm1CWk9ZQmhSUHhLQnVNT203?=
 =?utf-8?B?clh3dUY2azdQc1IwUzcxQnlxVTlCZDF2SHBFd1MrRGdlVlhqeExQeGppL2I4?=
 =?utf-8?B?WmtYMmU2dGJ0QWFJWkNoOGRmNkNyZkpZdGZ4ajFZM09DQVNLSHFacGFEN1VV?=
 =?utf-8?B?K25lWjM5YWtsSVVNdkM3Njd3ZXB1bjhoUktQdXlIUnp6V3k0TDNLM2ZtaW5k?=
 =?utf-8?B?SmJOVGRvdXJMUS9ab05BOUk1L083STROYjducm9yS0Z5cWVyVWw0c0lYK2FM?=
 =?utf-8?B?NU5RWCtRQmwrSzNOem51ZVpVOVZSVElGTE5TT1lFR1R3NTNXeFd6d2N5amhp?=
 =?utf-8?B?dnRhVjJJRGZNc1M1eFZlMEdNVHdLeG1Da2pzR1RlU3VBclNHdmpCdXhoMzJN?=
 =?utf-8?B?RFVGb1hVZXZIcXozaG5FbTJrZWtRd2U3M3FLaW0wU2pZTmliWlhlZFRkZCtH?=
 =?utf-8?B?QXJuNWYxbmNIZStkbjliM3JRSzh3QTE1dTZGUFRnMnNUdFoxLzVJTE1vRHNV?=
 =?utf-8?B?Y0V2d3daeC9RLzdCNzFEdFFVT2MxZ0xGQlc0MHpaUTFTSi9WQWlRN0ZvdXZZ?=
 =?utf-8?B?TUxTTTNTN1pmQVRndG1vY3ZSdCs2YkFyeUJiTVVJeU15VmZPWUtjUU56S3B0?=
 =?utf-8?B?SFhEVmZoWEpJemJuUkhuSFVhdmg1Q3dRanVtMGRFSEMyVTFyOXRvU1NlSnc2?=
 =?utf-8?B?NmVDR1pYYWZzd3dYU1RVbkJwajhjOFUwb090aFdJNDFSaDVYdDJUZ2pMMjJh?=
 =?utf-8?B?RFJyMTY2eWFFdGVYK2ZXWnBUMFNsdUNSeXZzWUpiNDVXWm5haVVHMUpLUklW?=
 =?utf-8?B?ZjZNdVJVQVpkV3ZrMDcyblY2YmV1NlF0bUMxRitUZzZRSmg0dHJRZzJVZGhJ?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fd5caf-af8f-40dc-c3ec-08dc3a1045a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:54:34.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HF6OfG5VUvWnRnZpLV5kzS4xU/O4BMzQXUtuRTv0+KZTyUT5bOmEMnfETyyPT6PQR+3fO8dw2LNrEAZbxfqEI8A8zmG3dX/d2y0yN43FmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

On 2/29/2024 11:02 PM, Jakub Kicinski wrote:
> struct net_device poll_dev in struct igc_q_vector was added
> in one of the initial commits, but never used.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub, you can just apply this directly AFAICS.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



