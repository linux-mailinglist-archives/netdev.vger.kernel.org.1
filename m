Return-Path: <netdev+bounces-94654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A38C00F4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618611F28323
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940A84D0A;
	Wed,  8 May 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRz6YU1c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CB54FA3
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182128; cv=fail; b=o4UB8j5VVnoc3wBXlLpXAqS8TsasKvZLBh1aHsR9Fhqj8V3dU97QjSDqn1Lbe7oLdS2bbQY1mdlK6PmVlyY8C2Gxf1QWJCB+5eIQghNGnGFnvu2j1yx15N0bw+l9PNB/+GEBtb7d0RhYNkhMyBNyiRHs1TPTAGw+ejR/I+GU0DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182128; c=relaxed/simple;
	bh=dOlOvS1V+ZwRYb/nsp7S0qrhkzxjiIuimBxeQBeb3OA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AVVTyOhbx/rCZUNB+SOPao0N044nooer8NVk/FiasLol/PHcDmFaA/NU+AzTe23/eFt8I2A0LFzEMLQMXl1kM/xJ4lKRQELFCikR7mmh0ounxNnkpBatPBlTkeGCB3e/UcrUU6mjCN4opaOvHJdFhW6jkfeZ60Hrbcd89EzcGt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRz6YU1c; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715182126; x=1746718126;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dOlOvS1V+ZwRYb/nsp7S0qrhkzxjiIuimBxeQBeb3OA=;
  b=kRz6YU1c1rXhRxwEN8Y5kJKXtsAjPTzGAHjqEs6Ccbq9kjUjERiVEDh5
   I1LiC+84mqPLUlaBY7g4Se7LRs6McEXlTM9ud7XoF1hNee/4riTgysJDX
   cWGEaQmuMAiYSkFbvglxsD2PACoK7yfS050YMmXvF2uYPLBjBdzQYqhon
   SWvcNgoptJTarNgdZh2cw6BXYCaAlqQplGdDJ6BHO8PzZhzXimrC2Hq0V
   H7bZVUfoQ3+7w2AeS4ppi6TS7xDfvWQmnZUFICbndeOVRJ4ZkvnebaqSP
   fPjkDzmutYkb/y4K6ATIQHVl/kYUNJTQ7S6ncWs9ZEZgZRxweUOc+YxuC
   w==;
X-CSE-ConnectionGUID: 2k6XOJzZShGbMdpTbwfUJw==
X-CSE-MsgGUID: 5pSFzNlHRzeu/Voi7ezkGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10891445"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10891445"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:28:46 -0700
X-CSE-ConnectionGUID: PoA1Tj6hTlqM06W+XlM98Q==
X-CSE-MsgGUID: BKQcQFMxS/aZiKPGZ7fzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59786375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 08:28:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:28:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:28:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 08:28:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 08:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvBcrky/cU3VIG6O7bOgYXQubUZvHgVpAsnDQpnxQO5rprZ2v2cmL3DIIu/1rTLITFYUoOYlLMLWmXlSqKmij7sRvqvKCcuRW3cCYTtKUtGlKc+TJCOtoA0icott3N8VCoCkWsUKZ9toGfkre+ZnRJJnuhs4k5tnCaFNoIRXr3DyrvzmeL31jLagPtszJCDcVHH8fSqxV+yKfm8SSyk45SE6UFSL+1n9g3gnmQ4JQwsDQINipzeNdzJRoDpiVbRp+o8LUqN0qEbyKQdhx0BhGrklekWhka2SnDyT42c73Y7cJMviN5TZVUKwbcC58pxzDMfQas6sIf07M0TkAOXAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3xhHjceyH0xREK4FB5KmWqaNY7bb3anL839caBEoS4=;
 b=HZJpC3J01j8xBSfYRNF0gyIPBHuyru3Fu2cB4YMHnYU5jeps9fWsmVTmFySW4xWGfN7VcWEjr1qFNBWbMCC+cKITExCHwJCFJGJ/tUwbFx4f/U+0IRJ4SJTYcLVqiyiHl+fCiXzq+i8e0ath3mY1UCV21t3cdZwFlfirO53QzMe8Q9U6IsC/fUvFnAjkfWMOvekkDVTgFBb/CzFVStsBrY9vRmug89NSMl3NSPJ2f2xRvCpcFdzRL/6QqnHGja5wGzo6pYZ/F/iR/JaymHoX9IjPTMON9ucFnT7Fl7UCV9fM4VI7wgycE0yNZkT9jGI5cE+7eyz9fndVTUpkPSfeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Wed, 8 May
 2024 15:28:38 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:28:38 +0000
Date: Wed, 8 May 2024 17:28:32 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] ipv6: prevent NULL dereference in ip6_output()
Message-ID: <ZjuaIFoFNDUEssnC@lzaremba-mobl.ger.corp.intel.com>
References: <20240507161842.773961-1-edumazet@google.com>
 <ZjuVAnjhYNomU/4J@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iLGeG3pMbO62hpuC5T5tf5DXmfzVNzgHjP6GXxs9RSHUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLGeG3pMbO62hpuC5T5tf5DXmfzVNzgHjP6GXxs9RSHUA@mail.gmail.com>
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: ef49fff7-5ba4-4782-4926-08dc6f7388c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0ZnTnhFWXZ5cm8xelN6ZkxOYzhRR1NoZVcvRUJQbGp0OHI1TEEwbkcxTWta?=
 =?utf-8?B?cnFuSHp0TkhFbFptQUNjdlJNR2FiM3EwZ0RpdWRaNEUxTDByaUxheitNdDMy?=
 =?utf-8?B?ZnhxQUdTK3E1aXFVZzc1S3Jlb0lyaFNrN0JERDRaT1gyNGNQUWR5UDBNenVl?=
 =?utf-8?B?c2tCRzBpMVJMcDFWT0loZjU2RzA3aG1HOHJKRmhpcGZxcDJvM2NocEp5TG40?=
 =?utf-8?B?YjY5dVZZb2NSMU4vdUlKUzFqNjRrMlZOV0JxWW9tU2FiYlJJTWU1S2dCSytQ?=
 =?utf-8?B?dkVoRExzWEVwUFZaazZYTmt6cnN6eEVrdmJhL2dKWEp2VjJ3Umt2b3p0czlw?=
 =?utf-8?B?ZWhFTjZ3ZFhYeWlaekdkTXpaamsra1lnOUYrL05GeFBZT2Vjbzh1YzA3MVlR?=
 =?utf-8?B?cENEK3BreTFkcWt0YzB2ZWc5RGNXTFJ5Um5uOFZCRTZMNE5kMjRBZmlzdWdw?=
 =?utf-8?B?WEh5YjRaYWcwNXJPS1JFL2F4ZGk3MWk2YldtL1JReEc1UkpndGpZZE5pY0hS?=
 =?utf-8?B?anoycjZUb1pBb3MzY1dMS0p3YjhQb0RWSDNHVjQvTGYzMGpCYmJheE5jUFd3?=
 =?utf-8?B?eStTejZDbnBzZVJCVXJkVXZpU3RZVjRyaGRYeURsUG82RkFHT1ErNzhmYmZ5?=
 =?utf-8?B?czRLTkNjaW8yVUtHbCtUR0xsV09GU0psL0Jia091aVpyVWMwYlMyYTBRdGJR?=
 =?utf-8?B?SnBwWnhTNkpKUFZabm02TDZ3ZXB1VmdxTkRyajkwa0ZvY0FtY0lIVHp0SElv?=
 =?utf-8?B?RXJaUm52Y3lsWkdnOFJqTmdJaGFhVkxXc0RmZUZFbFUxN0wxS0dITkpGQW02?=
 =?utf-8?B?MFdzNWQ3QTBRLzduMHV2YkpwblNnSExrY0hWeXMxdDEwUitSd0RKVnNrYTZ3?=
 =?utf-8?B?dzYzTGtiMkY3V0xzZUNDZHJaalphUk9ocHZMTGplUGVQOUVtUGFZaXVVcEVj?=
 =?utf-8?B?a2NMQ2FIelAyMnl3ZEFBZC9yWCtOaXFWZGptanduV0dIRlp2YmhwSWUzQWNj?=
 =?utf-8?B?QjRGWklSemQ4QkFzalc3MmtoR3U5cFAxd1RZZ0xWaFJRTy83aEJtTUlRWVZx?=
 =?utf-8?B?aUhCL3ZnUFgzRVR1OHM4bmhSazRUT1JXWjE0anZ4OXovdkFPRktHTTB5bTE1?=
 =?utf-8?B?dWJRdnFPWmVFVXRocldhU1hPdjkrMnBjZjVTQWR1b1RybjA4dk9TaUE5Ylhv?=
 =?utf-8?B?LytiNVFRZnE1OGhna3RpWDNEVXlrWFFueWVIcGtQR0g2YVIvaVpzZUN6N21O?=
 =?utf-8?B?Mk5NQ3BCU1BESDA0bjVDMjQzc1JtM3gxOG5uS0hHc1FBdVoyY0QwNlFETGw4?=
 =?utf-8?B?SFBXU2FEeS9rcENoc1JCbEwzN0xzNHgzakF1NTlnZmVGMVJ6YmgzV0lZR1Nw?=
 =?utf-8?B?dTBZbWE0Ykh5SENHN09oS0FGK3FNTEk3L0dPVDU5YytabW5KajNmUXlFWlpj?=
 =?utf-8?B?MkZ3WnpGbWRHS0wwQTFpdTZ2Y2ZHUURhcXhmdTJlZ3FQN0IxWFRyRHJBanMw?=
 =?utf-8?B?UnV5YTdOdlpqdFpMZ21oanh3R3N4aDIzNmxPRkJjNVp6b2VvQ0xkN2tBK1VW?=
 =?utf-8?B?TW9MRnlpZ1FkM1Z5NnkzejRJbjEzcldkZmVxRlViTHFLQVo2ejRHZzdIV1VE?=
 =?utf-8?B?cVl5ZHJaQTA3ZnZ5Q3ZtUVA5S1ZqK2dkMkFUN25aSDNDbkZCSXhlaFlVbGZE?=
 =?utf-8?B?cEFRVEhWSEthMjhVQnZ2TVBOMEtZTTExZkhXSGdVZk9QWmFhR1Jab2dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFDS0NoN0lmTFlYN0QzMktrTnpGbjNwSzQxR0JWMTIzSnljVHF2UVdTeGFp?=
 =?utf-8?B?NUI1Sm5IMjloaWFlWGpTSjBwZU02bzlBaUYvaWNxNTRmZnhXV2pUaW5FaFB1?=
 =?utf-8?B?aTdsWGtIRy9lMUpVSkZmYlBqUXczMFEyeDVXY204SC9rSUMzd2VDdEJVeDFp?=
 =?utf-8?B?bVYzM2FZOExBNmhDUWhYZ3lFTlVZdURJYzVVZ1lGdHNqcnJWTGRJbDJiRVVX?=
 =?utf-8?B?RlZTYTZFZytGcGUxS1dydC8xS3VhVGJDMDN4a0l6Mzcyc2M4Y0s3RERYaG1V?=
 =?utf-8?B?RzJhRnBtRTNSc05UOEhSNVd1ZUk2YmMzelRidmVmR2EwSVpYV1IwQjRLeUtK?=
 =?utf-8?B?MVNoeXQ2K1E5M2kwQ1BvUUtDSzZCSDluTjUzTlJWZVNrVzM1V0VEM3JSVXIr?=
 =?utf-8?B?bmhQV3FjZFNIVmppMm8rV0hRWHMvYzNVanM0TzRoRDdZL0N6QmpRUnpQOU54?=
 =?utf-8?B?anVwdHF2UFFsQWVyOHJDT0VrY1V2UGIveXIxckh6ZEZsR2VLUHI3TmxKZ2hr?=
 =?utf-8?B?NkdMbUdIQUNIOWpwTnh3alFiV2ZQY0pGNDArZENSMnBTTGt3ZUp4cytxMkF1?=
 =?utf-8?B?SEVHdm1QcXlQdHlNTVQ5NFp6R2Z6Z1J5TDd6dzduWlJCUlZMOS92cGdEdFlh?=
 =?utf-8?B?Mm11SFFlNVRiMHpHUmZXQ3FSTTM1VWlGRFY1eG8xT0ZYNURidTc5dHl2bGlR?=
 =?utf-8?B?OWRYMVVvWXRKdDFhUHRMdy94S2pHNng2T3NvVGVWMjh5WENJUGxEVEIxa0lO?=
 =?utf-8?B?V2tDeDBwM0l3RS9oRGY5SmdyNzJ5dlNyLzk5NzBhbTFWQ3VQclVWVjVGVW1Z?=
 =?utf-8?B?L0dsOVBKZDBkZnJ2d09UTkFwdE1NUlM3SlN2R2NUaWRqekxKbFQ5MUZzZ3Bs?=
 =?utf-8?B?U0dvdkcxL1NUYUNxSC9RTzVWMWRpVUM1dTBQcnN1UXdWY2E5M3hYbjB2MUxt?=
 =?utf-8?B?RHRTd0I3Wm9seHVNRGhCa28xU3NCK2kxQ1BKRDFjcjBwd0ZJUEJKUElUN2NJ?=
 =?utf-8?B?aUtpSjJEWVBabUtjNC9FdHVaRTE3TmRUd3pESjhlUlZIWkFjZ2xWaHNjeTlv?=
 =?utf-8?B?cFRXYWpXUkRoOWdzbm02ZDZmb0JyeTg5M0oyU2RVNWFENStaYmV3WHI1VENm?=
 =?utf-8?B?Vmt6M1dUeDRiSG1BcWVaY3VaSWN1RFdlNi9RMUR1dXhuMmdrWmh3a3JWY2My?=
 =?utf-8?B?SVRYQk5qUDBqOXJPNDJkUnlRemFXZWF4Tnl0TGVueXZyeVh3K09pd0xkN1lZ?=
 =?utf-8?B?YVlKcTY1azNYQmlLV1R3amY5ZVVKNWppUXRrUU5xeFpRNVdqZm44YlI2Q25F?=
 =?utf-8?B?UW1GZmF1Q2ZKQ1lsclZXbnBFK3Q0Y1FqcVZnOXo1Mi93RHRxZGhQVk9xNE1a?=
 =?utf-8?B?cFYyL2d5UDMxa244Yk5Jb2hRQ3doWjNYQ0xkbUtPNmdQdHFITXZVcXJucGd6?=
 =?utf-8?B?Vkx2M0swamkzMEpoK1RNVnJ0V2JiVkpQSm0yUXl0M295MXg2V096Y0tvUjV0?=
 =?utf-8?B?dVFpMjYraGhWaDAwbitIRDNTMGg1RTczb0VYRkxIM0Q1dy9ER3h1U2VRdUxq?=
 =?utf-8?B?c0NFa0RqY2l6ZmlIVUx4WHV4M0l4L0VSUjkwTG41WU81b0RlNGUwN2tuaVpZ?=
 =?utf-8?B?bHhGdmd6NWFzdDBWaVRGN0ZhOUU5bzE1aWNMY2pXNnVhYXd4MzZFUmpMTVlW?=
 =?utf-8?B?SXFNY1lSdWhFZUs3K0ZoZFN3ZXk3VDAvVDVzdHdJc1c5WnYyOWVwenRybE9l?=
 =?utf-8?B?eVZPcjU5TWlEcjNLRmYxclFWNTJZL2loRCtXRWxTQmF6LzU4MEJYOWVlbThW?=
 =?utf-8?B?UnQ5R2RZdGxpQ2NqTC96QVI3c3dHQmQwcHJpNnk2Mno5NkFqVDlrVFJRcERE?=
 =?utf-8?B?QUFzZFlNeHV0OXJIMy9YbHltMlE2cWtRNHdINFg5dWZiNC9aRXdVZXk1Z25D?=
 =?utf-8?B?UFk0eWx3RGZPOFdGOTVIb1BnRnFxczQrUUdqMGVKZGQ4cUJHWUhBdGJYeEN1?=
 =?utf-8?B?eTZHRVRNVW8vdkhGVzhhRWpTcXFWcXFZRHFSVzhCYWt1RXdxZ1FGMmFWSmhD?=
 =?utf-8?B?dDA3WjZEOW13VHFOMzE3V2d6SE50TGpzaUQyWlg2NVlWbnk5L3l2a20wM3N5?=
 =?utf-8?B?NDlaeFBpSkhmQ2ZNNVZCM2s4R3U1UTNISkhpSElSWHZ4dGVUY0xodzJnZ1JQ?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef49fff7-5ba4-4782-4926-08dc6f7388c4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:28:38.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOCjxG1xNbF6pbqR91G9K+QdKzgSIMkgSTJmqiHodO/yL++gV1mydVnP6PzXNXAeCYzuX9Ztp6Owl96RwG2VW0N2LMye9qqd9V1eJaHdj7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com

On Wed, May 08, 2024 at 05:25:27PM +0200, Eric Dumazet wrote:
> On Wed, May 8, 2024 at 5:06 PM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Tue, May 07, 2024 at 04:18:42PM +0000, Eric Dumazet wrote:
> > > According to syzbot, there is a chance that ip6_dst_idev()
> > > returns NULL in ip6_output(). Most places in IPv6 stack
> > > deal with a NULL idev just fine, but not here.
> > >
> > > syzbot reported:
> > >
> > > general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
> > > KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
> > > CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > >  RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
> > > Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
> > > RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
> > > RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
> > > RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
> > > RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
> > > R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
> > > R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
> > > FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >   NF_HOOK include/linux/netfilter.h:314 [inline]
> > >   ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
> > >   sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
> > >   sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
> > >   sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
> > >   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
> > >   sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
> > >   sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
> > >   sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
> > >   sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
> > >   __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
> > >   sctp_connect net/sctp/socket.c:4819 [inline]
> > >   sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
> > >   __sys_connect_file net/socket.c:2048 [inline]
> > >   __sys_connect+0x2df/0x310 net/socket.c:2065
> > >   __do_sys_connect net/socket.c:2075 [inline]
> > >   __se_sys_connect net/socket.c:2072 [inline]
> > >   __x64_sys_connect+0x7a/0x90 net/socket.c:2072
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 operaion on specific interface.")
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> >
> > 'Closes:' tag would be nice.
> 
> I do not disclose some syzbot reports, for security reasons.
> 
> Maybe this escaped your radar, I am triaging most (unless I am OOO for
> more than 6 days)
> syzbot reports before deciding to make them public or not.
> 
> Have you seen a public report about this bug ?

No, I have just assumed that since you metion the source, report should be 
public. Patch looks fine to me.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

