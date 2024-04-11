Return-Path: <netdev+bounces-86906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5378A0C02
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FC81F239F7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFE1411FE;
	Thu, 11 Apr 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyNqkzCD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363713FD92
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826828; cv=fail; b=HNz7Rk0kmHVDknyORSJt/mVfluIUBAPttZmM8KSubzfTFCGa3ezJiFMO2raUE2lo6SQQDPasH6YItRCX8OOkoVFU9GvWgoZ8trl2SbIXYJQGlGLzch+YNh8JOpkZ62bxjZoJvwQ+sEJV/eYi85Erxc5DgDMHhK9sB2GpReuLIAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826828; c=relaxed/simple;
	bh=H7ISpnD3qUC/l9sQsH/35/6uvD/eMyyETVIUw4VhfBs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJtoNKXxAkqNbAawne435GOYCdkNbd68N+nf3cMr0HslSQ09oNDXc/SBuf5hJZhrjUOf0nhuPUMneDBC9DwtLRIiROac6/GIWmMitPQZ/Hymqep3P+uy6tHW/1zThY2cVk5FhEtg9Oxs4KRE1ZzUKG7dGi7mJ1jgeANxj3pM9Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyNqkzCD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712826827; x=1744362827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7ISpnD3qUC/l9sQsH/35/6uvD/eMyyETVIUw4VhfBs=;
  b=SyNqkzCD1aNUlGLwCmRWPLzQdsboZBEBv5iB++Id5fkISErGkd8T4iqE
   6lxu3nkJ8ADHr7Qw9Uq7lrP+EDrEnoJMmS0seOW223eBq9NZ3ZWgeyhoa
   KHYVTGZdR3F9azEDITK1oItXdi7R7OJafxmpdQoDQkv96hzh9RjsLKRHC
   REF3WEe2pil0C/sL6JLlKSaRl8KqUm6eFVJQVv2qDy/ljaE5NWV6OZUYC
   C4D0GS2HLAhJMxM8GZPFWgO7wapA2n1b+o/7xmhqBI1HF9UIJg5eoKMRu
   mNZ3LBLSseuOtX0tt66/ckX+f//AYecVLS0znVdOIwEFSMKUb8fxohFP/
   w==;
X-CSE-ConnectionGUID: ZRMWSQZZSMarjx8kPbAOLw==
X-CSE-MsgGUID: 0LsaeyPbSLaEInRI0s2X+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8446183"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8446183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:13:45 -0700
X-CSE-ConnectionGUID: T41KZhAgQNC5MuP/KNUmcQ==
X-CSE-MsgGUID: 6K2K/x59Rf640q6rSJ/nsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21443035"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 02:13:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 02:13:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 02:13:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 02:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFTdI39CHiFC7asrzKUTBFyhKrAZsxdJssPCC/kH/W3GvhIEAkqqCSMskJKlfB7kRP6jN0zqFp1U+8g81OJN0aGxStbwq7+XzmRmCYzziawM0A0K9lCTeXLW9IryvU/8TN9PTqN15Abb3n4/5At58Q4WLoZHtHf7sxIvmhThMYN1rYm4SCs94GOsJP3/gyl5fF/lL9ExFrzBk5BhnDRr15rVCgZN4BdRYUNfqplUBo0kyMDt29LVQblMwT2enNt25qZekA4bQIma52ZcJwxNMfqD3nTV/6meWMhdjEXMEEpnBy0hVcVXJKy9TKMNvxuYDBLS+cGpChUTXd6XCtMw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PisU/KABzqdDluu/5jb78KdTsqfItgBH6+yPJ9WCdlQ=;
 b=hkOBkxyquvnoegW0F3TyR2u+svWgbZYo3iC+LE77SeyTjq+gSuPJuDrCmI8ftPi5JHo8h9R0fGleZrOhU9CWv49vkhgQ59cAI0uyMPYLNdL0TpFK2rlFIYcKpa/Yyq61VyiH8h+5IpD1xNRXHq8Yr2n7CQpHv/FKkLwz0NXQIjqZVNnZD9CzwHVHbnNBFH14RsHggsuhvRi4cujifST9zo/y6c732SlRfx6sOIJzGPWbOlfzhgIm1BlovBiJGX3HPCB75bG7FxzlJqp/uc7Q5ZxY78mDrcp2gYvm+x6Kq7snL+SoNV1MD7UJMAI8ovzOIrtI5BsrJTSUaHXOBatjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 09:13:36 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 09:13:36 +0000
Message-ID: <fe6f2325-7454-413e-acba-b3c5f3313dfe@intel.com>
Date: Thu, 11 Apr 2024 11:11:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: save some cycles when doing
 skb_attempt_defer_free()
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Eric Dumazet <edumazet@google.com>, <pablo@netfilter.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
References: <20240411032450.51649-1-kerneljasonxing@gmail.com>
 <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
 <CAL+tcoC2FW2_xp==NKATKi_QW2N2ZTB1UVPadUyECgYxV9jXRQ@mail.gmail.com>
 <CANn89i+6gWXDpnwM9aFtP_d_oTfQRDJdu+VMoDtvVcDrzBM_JA@mail.gmail.com>
 <CAL+tcoAZYeFsoPEFvWSFUTezofpkvwzggJd9zp81yTAy4PVOpw@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAL+tcoAZYeFsoPEFvWSFUTezofpkvwzggJd9zp81yTAy4PVOpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: cf653e94-3b89-43cf-b4ec-08dc5a07ab41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwTM5iu56Wzw4knrVppeUpZpQzBU9wrG0lICCUupqUYMtC7jsDwPw1TQS3yIuLhl7NRpT7BLsdwqBT8O6JR4FLsVXywvlb3FSlH6cObjyKPEanfbICQJ3ZynP4U922y8U8GlrKeRb00g8w5udAK/n/oKPxWwNU8f/PZYi6ubmasneacUb4DD3DMrIEW+br87foWKZ0xi86GYtIemAMxpooe/JI5HV40a7evqwtIvNzngfGDDdTGANVEKfCdKJeLGlRYbXPx8wr62/S7iajWE/vMf9J9E4GKHH01d8PafBTo1UD96b0WyAQsZEpeYFw85jD1UxeH+4xMP0AlEDtqi3Xcbt6mvlgpgz4Tn+klxjMiSebLcLXu5BnXOyuBe9Lu6YDJEOJ3a2ywzC1hFXoRXONLKN2WslBWGvM+qdwKkow7A0587ojOtQHPazN+lkesXkgLSIUVjB0DwwIh8uPXsPM3sxRKV78hITz0Vu+Azo7WbA5fPQUxkU8CAV3cifyrV7Hcyx9rEe8PjM740XfFrlKdP0wYnWtN4I7BG1LI6pUK0kkGXgM65+0CTpAsFnszpulkdO4gnSxLzuCR2b71dw2I5lGPS+JQ1U+DEBc60I+i6KITm5EEsF52dMDuNNgvAo0aw3IBd3o/qwmMA0BJgZ/5V4CWiuNLDThZbmHMvKkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkt5L0JWditpYWdrVjBhdyt3YkdveVlYNklrZlNTSjI0SmcwRGhJeVFvUDVJ?=
 =?utf-8?B?Z21BWlhNK0RWeDhVcWNtWHovbFZDR0F0UzlxR29XZWJtWjlnTzJaOFg3OVFV?=
 =?utf-8?B?SDBpUElFNnNYbVdPTWRaUkhxdTROQWx4U1Y2T2R2b3hseExIY3RDOGlqdmxa?=
 =?utf-8?B?aytjdkJHdzVxYnlWRnByQmczZFZ0MEEwUjZEeTR2c1dvaEsvaHJrNU9Ma0Jx?=
 =?utf-8?B?TzdIRXBEdFB3SGQ0N0VJSTIybytrank2R3ZmR0ZacXBNWDBadDBvZThldml5?=
 =?utf-8?B?TmRZVVlxVTUxNkN0MDJoblZQMGwvVERPTTBaV08zK2ZqMk1uYnFFRENYMzdT?=
 =?utf-8?B?NjN6MHF2UEwvWHhvWlZvNXpYTFAxbEY4dTBZUE15d0tSaTMzWmd4cWtRQkRF?=
 =?utf-8?B?NTFabUNRUndrUWNqd01RZnp4ZTNyRy9HM2pmM3llTzhuYjFJL2NES0ttZUtB?=
 =?utf-8?B?MmtJNnFyNmdMVktMUEpYclhRa3YrV1RRcFlQT2ZHTXgzcmJqYSt5WjYwNm5R?=
 =?utf-8?B?Qi9KSGlFc3FoZzZkQXZnVlJZcUxLV25uMk9EU0RoRWx1dVZNUmlJQ3N0SDZL?=
 =?utf-8?B?ZXd4eTl6aktSaDA2cUFydjFRVHBKaFdHejQ2Zm01cGxXcy90anl4OWlXWHdl?=
 =?utf-8?B?c2lubzNGeUx3NTdJUjdHRWkvb3FQMTNpNDluL2xTRTlhWEZIZnF3T3crZDcw?=
 =?utf-8?B?UFE0eTJvN3RIaHVwZ29nNE5icXdhdFh0bEJ5UlFSU1VZMmROdVBrNWdBQXE2?=
 =?utf-8?B?OEVxOFp4NjRIRS91M3JkamhCV3EycWhSQWcxY0hVZ0pGWXZiSDBLa1JwbG5D?=
 =?utf-8?B?ejlEd2tIaXhXQm5CSzUzaldwLzJaaDRDNnBYbU9pcllSQmNmQzR2ZmgzdmVV?=
 =?utf-8?B?ZmxNVEN5WjZBZVQ1dHBsR1JXK1RXTTZ6QzZ5a2ZvTnpwUy9sUTJPdy9LL3pV?=
 =?utf-8?B?c1ZxT1RkcTdZWjVoTXo0bzdsdzhwM0l2ODVQMjQrTDhZWEdMdWtVQWQzNFdB?=
 =?utf-8?B?K09RTXpPWVBmb0JkTmNCR05SWHp4ZUM3VGYxR2dEdFNzSzBiVUw5TUx5aTRl?=
 =?utf-8?B?bVRrMFVMNlUrUE01SDRob2lMTVVsaTdicXJKZXJHdHg3cGdrc3Q0KzZPRlEy?=
 =?utf-8?B?eUhJa1RQRGdrZnFCTldRZmYxUzJNSjVHUGQzWm5RVCtvYnBUdHBEYjRBbmRi?=
 =?utf-8?B?NTE2Yk9GeXpMTC9IalY2YjhtYzBVNXJlWmsvV1VuaGc3aU15ZzRERlFmYzNO?=
 =?utf-8?B?Q0pOZFR0YWJKVWNnYXE0Sm41Zm85d0ZyclFKbGQxYnFDNW10ZnBzZjJtUXRy?=
 =?utf-8?B?b1hDdDA4QWNVUWNjU2ZHTlhvSEpLenVrUWI0Q3JuOS9BK3lvd1pseHlrT1k3?=
 =?utf-8?B?SGZlR3k3ZkhDMEx1S0xxSmJjdCswUmpkS01CTDhQR2hFZURvL0s1RUVJVFJR?=
 =?utf-8?B?cHVWTWJpeWhpNU5hc2o3Q1ZQY2J2OHd3bDlWQzFndnNDVjJ4VWNjemE0cnpn?=
 =?utf-8?B?a09CbzRyTVYwVGV1YThxUkJjN0lacnpEcGNNR09OTXVPMURTTFBoanNuWWZp?=
 =?utf-8?B?TGFlcHNmRGIraUFndmV1dUtHM25zZU5HNE5UQlFnME01Ym5zSXBQNVc5NVBr?=
 =?utf-8?B?S1dIN1owUTAzdHBOVkh6UW5jSWtQY1BhZmVxcTZGSDdHZXBubTBJT01xSjVS?=
 =?utf-8?B?c0hXYnJmWEZySDg3c3pIK0cwTExSWHlISlRKZkZHbmRuc1dLdEFXK1o3NkhM?=
 =?utf-8?B?UXJRUUVJRmhYT2liT0JDSHNNMm9FY3ZBUmRVNWtnR1htNzR6MjZ6MTh2Q3BP?=
 =?utf-8?B?eVZ1dlJJRi9yMGZFSXZrUDNvZkFEd1lpalhYMXlzaE16OGNwMDBjUFJNdW4r?=
 =?utf-8?B?czJkbFNBYTVkUS80b1FFNkM3cDdzaVVSaUJxNTByYi82L2p6Q0V5aGVLQnQw?=
 =?utf-8?B?eGg0YUxBeVRBOFNSL0FGYWcyd2hRVExLSU1lRUg4enB5bXJkL2k0SVNnUUs4?=
 =?utf-8?B?TXVFNWRuMEdxWnU1blhsbFUyQWxVaVdySVF4SE5kVXRySEg5WTVteWZURFJX?=
 =?utf-8?B?aDlwWlRtMkJMUjJUVm9vei9Wa2pLaWJ2NTlHaHhPVDR1UEZGRWJwbEs1cTNL?=
 =?utf-8?B?VWk5cDI2RXhRZGQraVBpNlRuNkNTenBNS1phTGorb0N3N3E1dXBjemlvWmh4?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf653e94-3b89-43cf-b4ec-08dc5a07ab41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 09:13:36.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KIa32waXydHyFO3FHy6r1866I3V94MchNoWouosOj/0yCre6S78ALQ5c72upEWAUaYTO1NunPAQ5taItDLeG3kFJDWjjFhpgn43vx8gboE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 15:31:23 +0800

> On Thu, Apr 11, 2024 at 3:12 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, Apr 11, 2024 at 8:33 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>
>>> On Thu, Apr 11, 2024 at 1:27 PM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> On Thu, Apr 11, 2024 at 5:25 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>>>
>>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>>
>>>>> Normally, we don't face these two exceptions very often meanwhile
>>>>> we have some chance to meet the condition where the current cpu id
>>>>> is the same as skb->alloc_cpu.
>>>>>
>>>>> One simple test that can help us see the frequency of this statement
>>>>> 'cpu == raw_smp_processor_id()':
>>>>> 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
>>>>> 2. using BPF to capture skb_attempt_defer_free()
>>>>>
>>>>> I can see around 4% chance that happens to satisfy the statement.
>>>>> So moving this statement at the beginning can save some cycles in
>>>>> most cases.
>>>>>
>>>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>>>> ---
>>>>>  net/core/skbuff.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>>> index ab970ded8a7b..b4f252dc91fb 100644
>>>>> --- a/net/core/skbuff.c
>>>>> +++ b/net/core/skbuff.c
>>>>> @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>>>>>         unsigned int defer_max;
>>>>>         bool kick;
>>>>>
>>>>> -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
>>>>> +       if (cpu == raw_smp_processor_id() ||
>>>>>             !cpu_online(cpu) ||
>>>>> -           cpu == raw_smp_processor_id()) {
>>>>> +           WARN_ON_ONCE(cpu >= nr_cpu_ids)) {
>>>>>  nodefer:       kfree_skb_napi_cache(skb);
>>>>>                 return;
>>>>>         }
>>>>
>>>> Wrong patch.
>>>>
>>>> cpu_online(X) is undefined and might crash if X is out of bounds on CONFIG_SMP=y
>>>
>>> Even if skb->alloc_cpu is larger than nr_cpu_ids, I don't know why the
>>> integer test statement could cause crashing the kernel. It's just a
>>> simple comparison. And if the statement is true,
>>> raw_smp_processor_id() can guarantee the validation, right?
>>
>> Please read again the code you wrote, or run it with skb->alloc_cpu
>> being set to 45000 on a full DEBUG kernel.
>>
>> You are focusing on skb->alloc_cpu == raw_smp_processor_id(), I am
>> focusing on what happens
>> when this condition is not true.
> 
> Sorry. My bad. I put the wrong order of '!cpu_online(cpu)' and 'cpu >=
> nr_cpu_ids'. I didn't consider the out-of-bound issue. I should have
> done more checks :(
> 
> The correct patch should be:
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab970ded8a7b..6dc577a3ea6a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>         unsigned int defer_max;
>         bool kick;
> 
> -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
> -           !cpu_online(cpu) ||
> -           cpu == raw_smp_processor_id()) {
> +       if (cpu == raw_smp_processor_id() ||
> +           WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
> +           !cpu_online(cpu)) {

This one looks good to me.
Feel free to add

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

To your v2 before sending.

>  nodefer:       kfree_skb_napi_cache(skb);
>                 return;
>         }
> 
> I will submit V2 tomorrow.
> 
> Thanks,
> Jason

Thanks,
Olek

