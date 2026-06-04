Return-Path: <netdev+bounces-295396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OjA9JInMIWoKOAEAu9opvQ
	(envelope-from <netdev+bounces-295396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:05:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE06642C91
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:05:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=So4j7R09;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295396-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC3E3007F4D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17E353EEB;
	Thu,  4 Jun 2026 19:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E213224AF7;
	Thu,  4 Jun 2026 19:05:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599917; cv=fail; b=Dxx1zmpAm2BSsy7rJ2mtfagCEm3rlsDUfevxSE5h7gfEu64L8biAxqXys4fPuu9Naox7Fon35wCsv2VLrwq8S3vo5FeBidvzmx1ywg4sbVr6+s/kO6FHLJoytWVXxO0ULrjhH/Bwi3LprKOFsH4ilfbEUUXkTnSz/D03+BnvD/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599917; c=relaxed/simple;
	bh=KBH1Br2NVnKKKUYYRhudJQCf94QExIE5CsaB9hSQoU8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBd0Qbre4M/Qgop2d0cLfMr9AE+AxE3nkTndeMo6jsCH6umY37sxqak+ij5J8eobGGDnVkwf5BGKQJKBlucYGWwyIqC3v2VN2WTR8LlX6Qqy/0cBLSnDOs7ZVfOYnklHj+bOFtl24L3i6J96NleemYRnF+MYUPsPgPCkomiYg1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=So4j7R09; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599917; x=1812135917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KBH1Br2NVnKKKUYYRhudJQCf94QExIE5CsaB9hSQoU8=;
  b=So4j7R09vApD0WUVllKVbZNKIz9n+aLLJEC4PaWjHf6kJswd5qYEPpJe
   C+h8AKS6H7x+kOeaJnyJDD0xYhJxz+AvDs/I8K5/4H2N5sdzPVPGr1Fe2
   PjM5Po1v2rgpKTRVlrQVFG4C6IT9V7BhwnTNshuXGAW5BRIBVB81CTdAQ
   pxClyNRxQ7OFdS/9WgmWQjQ09OeDNdXLIRpQzZWs9UD7Zse8hoI2DjHBc
   5F6otIt7rWlUSZzWZEQB68UdARMcnsCqv0OhhmjJogN8fGA8wiUyTZM4m
   yr+/zP5flWy0x8qlrK5LG93UIVNzIKwicuOuCZ1xhFwLRw9njJZRqqzJ9
   Q==;
X-CSE-ConnectionGUID: +BSoZrRBQHyewELSZExkdA==
X-CSE-MsgGUID: cv5tDGQ3QreUFNoSLOrm6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98852389"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="98852389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:05:16 -0700
X-CSE-ConnectionGUID: j1E7qhLsRP6omV63Eh70Xg==
X-CSE-MsgGUID: BjEBPkouSGWVU8vrf6gKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="241644834"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:05:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:05:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:05:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjZZ9HXYdFCCyM8Xob4mkmRXGN72rN94TTRcKQk2E83lQmqV+igHh89bU5EjMaACWvhqbiC4waAPUoFcScRhzXGvHOS3JVhjQHr1TwYr5AzV7ZYfmD79t2x0zwRsqnGfvZWxSOSVkivZMUfjtRh7IYVaLTc3F/22pEtn2iU9TXRjBX7kgP+qdqU3k+khHzWH8iXGBLB/kTyhcrpeZPpYtIYPxvAbfQJlp+IzJc7876F1R3W1r2GITJreBfMrWHBaW9VZM9W3dzyu9WBQ3uERnX76/ZKNJ2AY1LmBWqXg8nVp8hFb441JJ6jQtfnvLqwSeJ17ugEGQ7UzPKlDwC6LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+bE4ePjPb3qWVtVaIwDfwymqAPxdxhgtkWKZ9l08Hk=;
 b=q4F+4aAQcN6jIEYS1Ill9ERFT2I4AhQP+kHGlEzdfUufuI+a/2nTfkeZad9qHSkiubOTyfKk+9Jvoo/BNcIRllU3aO9xnxAGxPVzYfoNVtfM03rAfV36frSsfbiQqoey52MK33NVSuJOGd6z73a8eZUWXOGG4sCP5tno+SLw+HZjKDBHuwjzVeBYxGzjloK9PD3Fr88xuo/wNqpqittLbH/IbP15s5CeqKPtJI2SYVcR71S5sNlKdtto22ru9690qtsDvcRjumyVvVqMNVZBpMKqyNrU4WNu8T1vEokZPCriZ7w8V36TkcqoOm88zyt8gCv64TBlqEXYuL4cTyVACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB8293.namprd11.prod.outlook.com (2603:10b6:a03:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:05:11 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:05:11 +0000
Message-ID: <65617cc3-5e3d-468e-a444-db7e839320c8@intel.com>
Date: Thu, 4 Jun 2026 12:05:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
To: <muhammad.nazim.amirul.nazle.asmade@altera.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <rmk+kernel@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: b456b798-f95a-4fc6-1eda-08dec26c33b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: o4YG7ncJd/oejLnVXExB4jTkTO3ejGd8LOVxgl8nKY+z7STj1ckr3VPIW25sPmAnlyH4OLP85QDO/KHrEtOY1GbDpzKvhzZTU8l2lK9g9W8w6OILTIkN81mBbR54liq9AqKdZR5wQeCalH/V3M+Qb3Di8gXGtltv1oIGQ5bSLOhnvL/Sd5GAJ/wgYZZeP0VVA5ab+9gTNIUthqp99vI58ubu7j4Yba0WwndECctyZz4dGkOyqsGbMC4fNIa7mpSDZo2KW1LAxJmeLnBtiJ1kja26ScGqQWUuxOSnJZvf0eeJxuihYjMv+j9wahwsvpcz4Cq09pK5zTobvdiJmGSXdbxF/iKgTP8fYG6oiyG7EAm7Sl5mcVcT0EX4XnfpnloFOQP2xLhLoCHI8Ewa2nL6ZYJCU3G0ZsCd3H9Trf4dXQhChTPTauFx6Z9HLc56kY+JAXaPzTxsIwLo3PkPo+l/51/5/rCUKbeaFkfiUz3KkO52yM1CWXmTaL45qIChBDwchjweDoDeqpb7NtbcCPTuLo8ze2SHrXEkEOgnCIrlZL73eKAco7erBQHTx1VPInNWPPWd0qA0QUBbH06dZqRqdpVt/D2xhpTyzOta5iWRMKJCHGE/vt5PUbEw8DToiK/aWJr47b9JBBs9KuMNfiOXCa44dIPnQarsexncUGCcE+k6iaOBtmw1eZSXHCqty05D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JMSkpwOTB3SzRoeEdocjRqNFJKUlVrcklMMmJaMVhCaWFXSUgvQmRSdGR1?=
 =?utf-8?B?VTRJYjl2RC9ySGJCVTlGZnRpL0U3OTlVazdGVnVIUzkwYXI5RW4vMFlCUW01?=
 =?utf-8?B?czdadTNKNnVQVU1jRkc4TndtbkFkTmx2aVVMVHpGMS8yUWJ5dlRHTnM0c2tP?=
 =?utf-8?B?Rmptbm52ZHRMN25vdXJLM1MwQjVNa3JuQWNtcTBDRWRIaXJrRkcrTVhXeEd4?=
 =?utf-8?B?Y3p1OUJWS0VaQklhQTdsZzZTdW1WWlQ2ZDA2NnI0akFzNS9yME1QdXRHL0p5?=
 =?utf-8?B?Q1JsWTlIaWNGOGM3NW1oV0trWm44QURiemh3bktySUdOOHNyT01RdkRBeFJV?=
 =?utf-8?B?MUx1OFZ6SlRhcUpGZGRPOWRzLzc1TytxQjd0UlhIenR2TFlDVUZKOUhPdUt5?=
 =?utf-8?B?ZDczREVDbnRrUkw4cmFhZVhMY1BwazhET3I1b2F2RG5mN0FLOXhxYzM2VlVC?=
 =?utf-8?B?aHUvbUp1Ulp2T0ZnNHhwcEhIUWZiaWtLRndnTlVtdVpkOHpnckJnd1g0RThn?=
 =?utf-8?B?OGpMSTNuNXBpamw5aTlCQVlkS2xXdkRZdzEzYmhKQXJsSC8rNUd6UEdsNGJq?=
 =?utf-8?B?YVBjWFltZ3F2NVZ1QnJHeUx0REE3Wk5JNHh3OGlyL016NnpsTkZKNllwOFZY?=
 =?utf-8?B?NzhNUUlMN1Nybi9VZ0o0MlpzcGZZV1dlQXZGY2hxNmI0RlhUWkhQcDgzT1BR?=
 =?utf-8?B?ZjdWSEN5YXpGY2xkOGw5N2V0Z0Z0NTdPbXlqMDNhRXg4OUVOQ09vUHRiazVB?=
 =?utf-8?B?UDkvTzg4OVZNMm9KQ3ArV2Uyb21CVkZ2WktSbUM4S1kxaUJvWDYwNFlmRUxS?=
 =?utf-8?B?cGtsTlUwUDh6TmVTTjZNN3JhZkU4NER1TjUrTHlpbkdFc3BXZ2NyYVFyb25N?=
 =?utf-8?B?dVJJNmJVVDJGRFNCMEE4MmVEVVJOM2NCTFF1S2dKNGVNNkczZFpTbUw1aXA5?=
 =?utf-8?B?U0VCZzJZbkxsNno0Q29BOU85OXNNUUp2a2Frak5jWUtHWW96c1p6ZWE1YUJI?=
 =?utf-8?B?cm9NbEgwb0llZCthdkhQT3drK0M2L3pYM244RDZ2THZlY0ZCOHJrdFljaUJG?=
 =?utf-8?B?dk1TdzJGVzF0QlNncWE5SVhpeTUrZWZ2MytGdmdGdEY4MmRTWVVheDhzTUta?=
 =?utf-8?B?Q2RWbmMzcVc3dng4NThOSEpQNEM5cGhZUUovRUNJNWxUQ0diMFlVRENlYlMx?=
 =?utf-8?B?a1h3MTRGeW5VclVIbXVIcnFIMnpHUUJzSTduQmpKU0RxbVFjd3hYNGpYOXBm?=
 =?utf-8?B?aTlTc1Y4YmFwZTYyU0lTS0h2TnRucllvY1dGTDNXN0NBMkcrbzZDbEdEeFRm?=
 =?utf-8?B?a3phd29lR284a3V0T3lscXp3aTh0WjlvSEhKcU5sNTVmVVFJWjkwTXJVaDVs?=
 =?utf-8?B?emVrSGI2RjdUL1N1RDYyNEVmRlppVmVSZGdubUl5Umw5aVJpRWw2Rmt6MTlm?=
 =?utf-8?B?R0Z5K1B3YXhHWXgyZFVYLzdBQ1ZWRE02WkZmYXdWK0RhcnplMFhQcGFYN0RH?=
 =?utf-8?B?SXplT0laWDlxaUQ4SXpFRDZNMDBvRHJnK09pUkJjV0Jib0swa1cxZkIvVmxK?=
 =?utf-8?B?bmYxb1d2UTNzNEhhWFdhL2g2eTlGMGNpOHNNMTd1cEJqWDk3WjEvR002bGlh?=
 =?utf-8?B?RFJvWDlPTGtpNlpTbjBuWmxuOHcxcVRIb29pS0NJMTBGZ2ZyWTl0dGRMcmlU?=
 =?utf-8?B?MWt1RFRNOVpZYnNxWkJFNTMwVlRxcmltNkhKNHVFSDB2UlFhMEtmU096RUkw?=
 =?utf-8?B?TkhzcVRiWnFKYjRuUTFDNS92YmNtT1Fhc0pXUXdOdjVoaEJHQzFJUllkbTc2?=
 =?utf-8?B?V2UwcXlJM0pmYTQxcmV6VzBBLzVFWnREZmp5cC84TlRpZGp2bFdIZXQrMG96?=
 =?utf-8?B?S0hxU1NzZ2pRMHIzcktnTFQ1akQ1dWZqc0pSS0F3V1E1cGc2K2t6RW80MzdE?=
 =?utf-8?B?OXNhVmtYaFVqK2tyZ1E3cWZ6N2xvcHBJZU8rVExnVjY1N2J0TFRxck9MKzh6?=
 =?utf-8?B?cHcxbmRhcE9tMTBXdWIvUTIrb1lPM1VKVzNvNGFKeUd4REp2Wk1hSWcwVHJN?=
 =?utf-8?B?YkJBZ2Qybk1JWlF3dWtwZXh0NlY3MFc3MmtUZUMwb1I4bmFlbVFzQXVrSWQ1?=
 =?utf-8?B?Rk01c1lVK1dadnZ0QzZDRzRpS1ZJUk9PNUdMY2hDYlFCeVBWdTdRSkt5VjVv?=
 =?utf-8?B?eHphaEs2czVFbVU4TE0wUnNObEZrOTQ3WUVVMnZzamNVV1VlMlBqQXFMY2t5?=
 =?utf-8?B?YjdaVXVJM0J1YTZYTm4zejdSUU11QlhHbGpWclRyY2ZhdVlIN3Y5KzZPSzBP?=
 =?utf-8?B?MFB3VHd5K090c1FTWVc5UEVQUzFlUVc1TFNTcEkraWwrZjJ6cndkaGxjdE1p?=
 =?utf-8?Q?i5nNm9PQJ7R32lN8=3D?=
X-Exchange-RoutingPolicyChecked: RxyKOONNo22bUqpnq4MXneVAOHeebN3gbBgE/DuNaPCIWsz86S9Oc2kt0KbDAF5PsTtieACBSBD/LsV45ne0c1FfHksrY1nS/5n2LuZ3bU68/n/2PVf+EWIwT1ASo4oU53H+rFBw1HE4i+KefsgEoh+npsRmJE1fptJEfq1WV2zqFDG4vUGEYg+0HxsTJJw49sRMePBUssTM5otXst88TUI6Tl0iTdJH0ONQNexaeq/TfikPL2T9tuqJbA0JAdZRowXEjGVX4kDeRLfirAfW3+E6XYrvtlIrXpu0SzMwNe//HkfWc1ytZaHNn+E4pL0ZntM+ReACMaYQ/jFb0O2vIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b456b798-f95a-4fc6-1eda-08dec26c33b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:05:11.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22MZcx5GsdXTwjrszNHAbBCUT7uabLgZM/j0sNuIs5ZKQQPemlNVNcyfBjEdoT8/oyljzss4k9HrmsnLFLAWcSM8y9ELhe/zO9Gb/P8w134=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8293
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295396-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE06642C91

On 6/4/2026 1:30 AM, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
> and increment the corresponding ethtool statistics counters. This allows
> users to observe L3/L4 filter hit rates via ethtool -S.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       | 2 ++
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b0..95fdf3133208 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -429,6 +429,8 @@
>  #define XGMAC_TDES3_VLTV		BIT(16)
>  #define XGMAC_TDES3_VT			GENMASK(15, 0)
>  #define XGMAC_TDES3_FL			GENMASK(14, 0)
> +#define XGMAC_RDES2_L4FM		BIT(28)
> +#define XGMAC_RDES2_L3FM		BIT(27)
>  #define XGMAC_RDES2_HL			GENMASK(9, 0)
>  #define XGMAC_RDES3_OWN			BIT(31)
>  #define XGMAC_RDES3_CTXT		BIT(30)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index b5f200a87484..6719ac6e395b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -27,6 +27,7 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
>  				  struct dma_desc *p)
>  {
>  	u32 rdes3 = le32_to_cpu(p->des3);
> +	u32 rdes2 = le32_to_cpu(p->des2);
>  
>  	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
>  		return dma_own;
> @@ -37,6 +38,11 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
>  	if (unlikely((rdes3 & XGMAC_RDES3_ES) && (rdes3 & XGMAC_RDES3_LD)))
>  		return discard_frame;
>  
> +	if (rdes2 & XGMAC_RDES2_L3FM)
> +		x->l3_filter_match++;
> +	if (rdes2 & XGMAC_RDES2_L4FM)
> +		x->l4_filter_match++;
> +
>  	return good_frame;
>  }
>  

Right. The l3_filter_match and l4_filter_match already get reported in
stmmac_ethtool.c

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


