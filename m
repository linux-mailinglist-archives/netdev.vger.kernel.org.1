Return-Path: <netdev+bounces-117679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695D94EC67
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBAB281D2E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F90178365;
	Mon, 12 Aug 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Prdyp47Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AD175D3E;
	Mon, 12 Aug 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464583; cv=fail; b=YsHp3KdqXU4ZIXvUoWgZK6TbUuffaA0jN6gV+b3J7/3FDy+CT+9TcAvR5tlYDkezfctalBK84y+A8LOScWwYxhfc84Jof9cGS+QB1QCGDdJQN9EN1KmRRJq9YyOCTbJy50JV/eSa9YtBieLdPeHMPGRFp6PEuu8Bh8YrZtZ/k94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464583; c=relaxed/simple;
	bh=uc57qEowK0G8QTXs31w811iREmxnH4tAjSFt9Pt+Lco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p79xbLkLg3QlckbD/cYy4rqrkHEPpNVNZntwjA+09KxyOGtHinXBK8alo8SDnPXriMB8G7JbF5aM1vORV1dsiEEttVvAsL5iNyEvLqu3NBpte6hLznsHC9izuq/fAex54Bsxet+BFCyV0DXuOQR13RO+SKFempAFsZFPSsE6F/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Prdyp47Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723464582; x=1755000582;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uc57qEowK0G8QTXs31w811iREmxnH4tAjSFt9Pt+Lco=;
  b=Prdyp47Qrf6DO0uipaD2dH2vi/weexZFjdsZ47Y1pSS6l06axMS2iyXv
   F9nvkj0xQ/zRnmbmn669yJd+lTNPQcQWiOO/h72ZR/d54og5L5pbxf7/B
   p/EPM3M0u5VJ2xsIKtOswxUbw4wVpZlg+QMb4RB/UOQqulJwh7jjrujZR
   tS+vgF8t4dwWuejTiNH233NlvVw0D9SWE96L1GgLsojLG1A6eQT1Ec74d
   pwI5KzW8jLvtBPg5Kf0fDLch69B8BcXUy81NRuYj1cg0eA+WLw+4aLLP0
   DNYRFUB/u31ecY8819BSyOzTv4qMT8vH5aWjBZDlCQ3FxiGCqxUOTOBJy
   A==;
X-CSE-ConnectionGUID: iLW5JS74THGV66NiWEHfvA==
X-CSE-MsgGUID: Bw2l04PCSbGaq8E3DM8lWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21378290"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21378290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:09:41 -0700
X-CSE-ConnectionGUID: 9q2rojgUQY24zsbvNXMrGA==
X-CSE-MsgGUID: UmJQgHUxQPmtD21hMEf9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58325652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 05:09:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:09:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:09:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 05:09:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 05:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InJ/JsE3/HekdmgRomlWOwkjbsEfr8sbHp7JgoiFb4O01Kpw4WdPmemNKAnc2ampWCXH71D3hbv4kEs6cdMMqZQwIHmaktLNz/s64U3T1TWgR7PA+0rwBo91GPNRQEWQsGkjcoFwabln1g9/o2XpExvQG8skcykNMAxzaZ30iUukI7sTIdHM1MyHCngDvFGFEORhN0YYDsM3j9oF4WgxuHASZOz091xwrKf64WU5G9C7qfUlbMJ8dCv1xCuGbSwEls6vvAzKmAXK1Ml7yhZtPP+qehYfmxbAxdOfVIAEqYDoOhhEzn50RPVvyLXjc712svHIS6b9YEsTelPH2BWraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeZljsX5dSOSXFNzGkTVDbiADR+bRzcC1gaCd9o5ztM=;
 b=kddTQdmwuZXP/r6W3gjmwZPhrGwCdb9hZpD6SWbi9gz6R0grAMh7HKSws4a2njs87+LP353kNM1+Z62rV7tvARgsrtJbzWCJppq8bZ7cs7aD+x1RUAWHgeYShgELK3bWT1+0t9ocpPlSulZbv1ybxufch9QiqOfzQztkKoUZVwDBnychH64lw+s1+Xuck/QlQDvF+rSQXR1Nd1JTygKlpXTYc52a5aOejeRJzpKVnt6ArU7ow7m6E8Hhv7toalpj76Wzwm0WswTaFdhlFGXOLlyUZNNXOJQjnK2ZeWVfP/UnLg28fqAk6x8FapcQweC59NZYMa5l0Wcf/XLExuOBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 12:09:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.031; Mon, 12 Aug 2024
 12:09:36 +0000
Message-ID: <26db3c81-5da6-483a-b9d0-6c9fcda5c5c0@intel.com>
Date: Mon, 12 Aug 2024 14:09:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] netdevice: convert private flags >
 BIT(31) to bitfields
To: Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
 <20240808152757.2016725-2-aleksander.lobakin@intel.com>
 <20240809222755.28acd840@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240809222755.28acd840@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f76fc3-3f8b-4e75-db7a-08dcbac7a26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUI2MkR5T0pDRlRwOHlGTW1JZS9kRURhTkpoNmFyRGd3QytEcVV1QXZpdmZ3?=
 =?utf-8?B?T0dPOGF3UVlLcVU0dkZMZjBOOUhLZTJmbStCRFRZZnZsaE9tVHVYdzhzWHJy?=
 =?utf-8?B?NzlCZGxQZjQwYnpYTWk4c0FxaStrMis1VzB6ZHJFZmMrWFBlb2VWT3dsaWpa?=
 =?utf-8?B?MWdWMTJaYUpETFdVM0VUNVZmcDFjVDkyL1pVUXVBWW04U2hJWWJMbGtGMmFa?=
 =?utf-8?B?cFpRakF6SVdwSHFHZmprYU5ZRXVhOEV0WnVNY2FKcW9iSEZ5ZjI1M0RXODZM?=
 =?utf-8?B?Z3RVUkpXWjB5bUlMT01zMk93UDhpKytpZHE4eVQzSksyM1FQUWxGcVpNQmpP?=
 =?utf-8?B?VGtrVXN1STBuNXFHaHpuOWh5WFZpUGYxRW9DeXc3N2ZRa1F6MklkcmVsdlNm?=
 =?utf-8?B?anNQVWU5c0ZHYk84d21zWGhhcC9LYU15ejEwY1hGTzNYbzZEWmlqQ29JNFJW?=
 =?utf-8?B?dzFQZU1WZ1dsNnFJMExoR1A0cjZvVWRTSU9lMUdGdHRKZ3IzcStxZ3RzWGl1?=
 =?utf-8?B?cFNlbFQrZmo4STJxVzZVNXB6OHR4VXNvZlhDOTB2cmJOekVsQnVITm9BOVdV?=
 =?utf-8?B?YUoxVmRuQXNOZXFQM1p3bVVsUzlCQ05IaDZWS0JkeURXOFNIWVhtbHkxZWtP?=
 =?utf-8?B?ZHhhWFdRdXhHdUY4NE5vM25sNkhsbTV2WXF3ZTV1ZlZSUE9DOTYwQ3c3WEJB?=
 =?utf-8?B?QkNuMkNEWmxGdzlUZGMyZjNHRE1EZzdkRjRjQmRCY3ZYamkyaXhBQnZ3Sy9M?=
 =?utf-8?B?NWFrNjRSNHFZQmwrWDRCT0RhM2JERkNNZ0gxSkpaWmhVOE9ZVHJ6L2s4ek54?=
 =?utf-8?B?VHQ1V2FyVkg1eXA0ajFNYnp5OXZVamNScVVRRHRjd25PT1ZlSllyYjlzYXFC?=
 =?utf-8?B?d0tIUExJbW9Ja1pzMk1UUzZVWFkxWDZqdEE4QjVCdStKbEEyTmIvWE5ZSEc4?=
 =?utf-8?B?bC9lUFFnSzVyZDlhSmNrL3F4ZHZ0VXVOL3J2cStTa2NpQ2JZT0VtOUdZTi9a?=
 =?utf-8?B?NVdrWlpPNmxFSk03RnVkdWhJZjNEMUpwYW9yT3UwYXFwVmNIUDJ3NlVoU24w?=
 =?utf-8?B?VDBoc1NtWW5FNHZEdFY2REhmOS9henRMa2NmQVU3WlZRNWExa0lDNkdtTEoz?=
 =?utf-8?B?aGZtRU1tci9aa3ZXWXhEZzBHM2RxOG1CMTIwcmVVUG9CVTdpV3RRd0ZlMSta?=
 =?utf-8?B?RWo1Z3RNM3NVWnRTelRxQUhQTEFPN2xHM3pnSk45RlRURDJlN3RCUmZ5NHJU?=
 =?utf-8?B?RzNuaGZxTXF2ckNDUy9qYmFHdVpTd0xUV3NhNVVTT2RSTDlOSEFXYzZERDRG?=
 =?utf-8?B?Rk0yaDV6VURMaDgxN1JmelhFZXBCYW1FSjZEWHpiMHVZNStuREJjbjJWTjRv?=
 =?utf-8?B?MTkzOS9yTDU4cGR0STFOUUNublY4Qkt3OStwMWh2eDNRRWFtVmd2c3U3M1NE?=
 =?utf-8?B?SjlNU1RmN2daZXBOZ1JZRWtYOWg0UXIyU0kvSUVKZjMyeXp4cVdZeW1tanZ2?=
 =?utf-8?B?M0dwTEplc0VIdGxHZXNHMjBNVmdsN0Zway9VV0dIR09EenZsK3ZBd1dXTDB5?=
 =?utf-8?B?emc5eTYzVGVPZVpWTmQydk1VcmZ3VlRERENZaS8wSTh3VTRXcy9ZTHNSMVlp?=
 =?utf-8?B?ZG9RRXMyL3ZPbFMvZndmMW5SNGRseUg2SGhqRDVGNThpbGtKTjh1OFRSU0p1?=
 =?utf-8?B?VFFEVm1qK0ZmR3c1Y3dncjNwRFF3Yi9PdmdCYVp6U214TzZFQkl5c3NLT2lJ?=
 =?utf-8?B?SXB0d2FOSVlMWlRqeW5iUzRadG5xY3VrWHFkMzZGNTdSVE9xeHJydGVpOUxv?=
 =?utf-8?B?UTViWkpoMERCOGRyRG5xUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9rTmNPWVBIUUZnZkltdlN1UHZIcDV5ZlFvZjNHeGZKS09WOEo5YmRiaUQ1?=
 =?utf-8?B?K3F1dXR0VlA1c3hUd2ptTW1lUFY3YU5XRWZXN1RqeTY0Rk5ITGp0OXdjSzRO?=
 =?utf-8?B?djVURmNSaWZiY0VROU80b3NYVDJxeXg0TEJ1amUvUlNXMmJtbWhWem1iLzVB?=
 =?utf-8?B?VTBJdjlneHB6bnhFM0dBUnphMjgwSUlQZDBjeW1RR0hhUFJOVlNGeUwwc3Bx?=
 =?utf-8?B?VTdRS1hjZ2NTYjhSUHdwdTZaOHFldXNZZHN0UTgvRWJQVWw5SGhxVVRUdVJs?=
 =?utf-8?B?NndOc2FnQjUybWVxckpQWFJqNTN4MjBUSVlQQ1o5enJCbUpCT2VTeDBzVk00?=
 =?utf-8?B?VHhFRlArbFFNb0xHaTJDN2lyVGdOVUxFd0tIYU8vTEcweGlTamZ2NnlHemFn?=
 =?utf-8?B?N1dka1dtaWwzWlBUUzh2eEVzaVFiSUsxY0Q3QlArc2dYVk1hVm1hdk8wM1Zq?=
 =?utf-8?B?UWd2RC9kMWdCQkl0VFNHV2dxYXNjV1dtVEgvZWh4TE5meFRjT0VVRFNQWHBG?=
 =?utf-8?B?TmJaSDBZa291WGpTQkFRTzBoTkZma2JGaUxnR2hzZWpXQ29pblJMU0tNdTFV?=
 =?utf-8?B?S3luUGxxVWFQOG1HSzBmY0lBbjNCQzAwUWFCU2ViU2dKY0hJSzFqSDBMTDBK?=
 =?utf-8?B?RER1MDR6OWVQMzhVTk45bnFmTG5WcUZDUUdSQUdFd0J6WVZXY3JOZDRjN2Ru?=
 =?utf-8?B?UEJzSlFhQUdUM25NYk1lczMySGdudXJQMk5YZHlwT0lvdlV6SmpuQnB4VnJ2?=
 =?utf-8?B?N1JUSkJJcVBkYkd6ais0ZFB0UktWR2M4ODB1QlZZdktWUWQxd0JZVkpmdTAy?=
 =?utf-8?B?ZmpubStFZjNRUkJ4aXE3NnppNWhmN1NzdFJTRituU2NZU1I1WTViRi9MZlJh?=
 =?utf-8?B?Q2VadmwzUUtTYnByRVVoaURxZEwwQzByS2t0UFF6akNQOHRGbHNybjZVaktX?=
 =?utf-8?B?VjhqaEFyNW56SjhYeXpnSDRQbktHamVOaFIwTE43anBzN3RqcjJXbmVnLy9P?=
 =?utf-8?B?eXlFRVFLOFhqclE4OE1wdW5UU0F5SkNKd0d4S0NpQTZRb2lNVERJTnBLZzZh?=
 =?utf-8?B?bVpGaFlQMjYrdXJvZys5SU5LelFZaTlvbzlhU3VhdmJteHBCTlR3Vkl0Vjhq?=
 =?utf-8?B?Sm0yUm5ndUUvV2h4NnBTVlBCZHRlR3MxVFl0R2dLQkV1eUZuU2pRNGlTU1ZH?=
 =?utf-8?B?cEFEd0xXQ3N1SU9CMXpWME9vczJTWWl4ZUVPbGdBdG5aME5nK21QRndvSC9z?=
 =?utf-8?B?bmlHb3FjTFVtNXF3S3Qva29MSVVVSlBHQmoyK0lyNURROTZMTVR4TmNaN0FR?=
 =?utf-8?B?Y1JkYzRVMGhSandjSm9BOS8xemhROUljU3RSTEQxYnYzOFJVcERrdnhDZU9z?=
 =?utf-8?B?WWJMWkMrS0sxK0EybjN4b1J4M29EUllaSEZlcW14WmhLb2JYMHJCVlkycit0?=
 =?utf-8?B?L1BGR3IyMGJXRXpFZVRkVm4rQWRGL1pkS1pVbUxEbWdad2dERlBOWnBvN2lK?=
 =?utf-8?B?R3F3ODNrcWtjUzI4MzRsb3JFS2lvbUtBbjJIeW8rWHpWU1c1Tkl2SVluVnRT?=
 =?utf-8?B?MVNjbFlHYTNxVExuS1lISm9EbTUrdk0yWmFLTzNvbFc0ZGFjTCtEVHFkczZS?=
 =?utf-8?B?MDJjc3NlVmk3Zm1GL0hjQWNzMHY1MTlmSzhWckJDcXNBbzlHMEVyQXBxaU40?=
 =?utf-8?B?aHNTRGFJL0E3UmVZeVYzV2hYNWVBTDdISEZzdTdhdyttSzFvcTdkUkQyZWVD?=
 =?utf-8?B?N2IzSDVUMjNBRjBxdGpNWk5RYTlubEVuUlJMM1hiMndGNzNnSDV0Y3JFN3FD?=
 =?utf-8?B?dUkvN3ZldUlySS9jWlkydnZzUm1EV2U5Uk94Q09iOCs3bHVYdFhaVkxvazkz?=
 =?utf-8?B?WmdKK2FCUkxwbFZNQ1ltSWo5MHRrbUVTMk9OcWNSSm9rUWJZSmZNcERmWTIv?=
 =?utf-8?B?Wlo0bTRIbnZrZWxnTE1uYW42bkYvemxiVFRSSXROdFNNWG1ScDA2ZVFFTk9N?=
 =?utf-8?B?eWQyRXFvOHNyS0h2OGFDMDFCaHkxQmdDNWNQalFJOERaTWsyY21TZXYvRE54?=
 =?utf-8?B?TWxWdjdvNncxckh3SXlINUowNWUxelhXV3BUMGpMdTBwTmNwQ2toQ3dsajZM?=
 =?utf-8?B?L2dBMG9hOW8rQ0c2ODVmays5QUwyQzRWVGlzZ2poakYvbHg1aE9QaXhxRXAr?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f76fc3-3f8b-4e75-db7a-08dcbac7a26e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 12:09:36.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf6m58zUh6FQ4Gujb3dfr1Jdkp/SPMMF/m96ANRoCJ3OlBKjH1531XgtLjPemChbTubhn2DULTFSGes+GvAMrIg30gCsuwogixlB+pfHQ44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 9 Aug 2024 22:27:55 -0700

> On Thu,  8 Aug 2024 17:27:52 +0200 Alexander Lobakin wrote:
>> + *	@priv_flags_fast: both hotpath private flags as bits and as bitfield
>> + *			booleans combined, only to assert cacheline placement
>> + *	@priv_flags:	flags invisible to userspace defined as bits, see
>> + *			enum netdev_priv_flags for the definitions
> 
> The kdoc scripts says:
> 
> include/linux/netdevice.h:2392: warning: Excess struct member 'priv_flags_fast' description in 'net_device'
> 
> I thought you sent a kernel-doc patch during previous cycle to fix this,
> or was that for something else?

Oh crap.
The patch I sent expands struct_group_tagged() only.
If I do the same for the regular struct_group(), there'll clearly be a
ton of new warnings.
I think I'll just submit v4 with removing this line from the kdoc?

Thanks,
Olek

 


