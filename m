Return-Path: <netdev+bounces-121085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9BD95BA01
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1852BB24055
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6991C944E;
	Thu, 22 Aug 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9yb1l06"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E9183CC4;
	Thu, 22 Aug 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340275; cv=fail; b=cvV6r7kSD+nUd9Z1ehMr3G7ZZIxE4qsIrjf3MIeUYSk/eEjLZd7GDyJTIS9mU8Mzu3RInWnX8hf5OAAKSdQWTsUoyrFRPN3j70074GztOGJ6WfPG4QAtjfSHhKSlzu+WsoQe4XedX6QvjWe7QGkTEYFWLf42S3ucG8t07HTfnjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340275; c=relaxed/simple;
	bh=6warZSNtikuyiHxTw2RBPz2pESRWKjY3afC/PWUcwVs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l7hT2nvvnNUG5nHvQEwW0OSuvA4YRO6qehyiUf1fBnUCSmCuU33fp1Zr3K3WnSgDH3PDNYRsEqeh3DDj0uH7wY2/KkJx4OUEAz6kC0iyibMsRny7hivAebF3qzILg0mIdk29+TFaH5ncmmxgryyzxGf6YtTjV/JesWNXIdzTTGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9yb1l06; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724340274; x=1755876274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6warZSNtikuyiHxTw2RBPz2pESRWKjY3afC/PWUcwVs=;
  b=I9yb1l06afEWebPL2HvOsC+83+7PFiaGN12ToA7+Q2Ei/9MBjzlvGvL3
   TjHRviq9sXiNOu009B3JLy/E10fptYy4aY+tFRn2IEN3nV+BXRh9Xgkyp
   C4+T5De+R8FjlgS3bldoLcQFRFFMwWtwgb1mQwcfWav9jU1S8jYVrCZdS
   aKE7wWzjFc0SzkwMSn7DmnQwWktzSZjgEUsCljw1iNSGdgCkyGiCXxIPK
   zkz66cdUJ0PzKdTLmqW97CFzwUtZLM042m5ToHkj39fmTt0M4CLMm+DJT
   rV8gF7xnNlj+1tQU6NWg55ajOs0IMszNgWCBHcF6peZUu7DspHYRTqPZJ
   g==;
X-CSE-ConnectionGUID: YIWf90lgSey7xI5FN1fbtw==
X-CSE-MsgGUID: m09XO/5HSmuUhyrRvJS5lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="45286227"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="45286227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:24:34 -0700
X-CSE-ConnectionGUID: ovGrCLjlS46x+AafA1jq3Q==
X-CSE-MsgGUID: oIQpQBEhRtOUMcJap78+Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61336422"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 08:24:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 08:24:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 08:24:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 08:24:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzqif49gsDNlqP3yec6WGoL6oKHiVa7nWUqSlJ5/487nLeITXKh3oe7TwgvUjc5Xs6Skq5023FL0RayrZ+NOAUn6nK67mJWLrPVvI9Bt8R9wj1kWBxgTrQg13bLuzNQ4R7dJNhzmXEVfI3f86ZamXQzYfc/sFOLakOZuFz93Q2Z7H6IHXXhg5qVeJ1GAysgWYELco5IXTv4AXtesrQ00n8VWtmZbr4b8ZDqmHv8ua6Nmzq2Gk7u7iUzhDh+MmH8nUF8ZqG+/tN81Z1u/2dfyblPYOgSJzbtsN1VY34WrPdIWxtlxsyUXTikK0k1TGXd/YPPA1DP8UxbKNOlPGtEOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEUHgFJVwRc9qHAU7BA1e0ZA2Zjijcrl7k+npjSE91Y=;
 b=FKFY+im0ucVsPV4SLY/CP93d9YNH50LUUrQq18D39u8+qrEvWcwUe7yD3ajeTB+ALRzLohnkywPP2bYjgk9fcEtsI51HJEs1v88JMbxxhUU+k/kfHnGs4+zzMEXGEkqMGAQTdMdvOX6N7Lj8I+tC7gSlSp0aCaRC5Mo1OvkN8ajtFGRVcYOwgQbXtEkRTma7MWI8OueJ9LgiI6lfahgbVq4U++/ci+eYJ/yvHaPWt1HxKkn+VWehcSveOL3RIJ2jKqT8za95q/Qe3tzkj7gigaBtPfHzxKUbvBfdsOzPPhELZBd2cBzfnKJBZaPx4iuDEdUQeDiXGI61h4Bbwag+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 15:24:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 15:24:30 +0000
Message-ID: <fc659137-c6f0-42bf-8af3-56f4f0deae1b@intel.com>
Date: Thu, 22 Aug 2024 17:24:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com>
 <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: a555d7c4-d8d6-414a-6c35-08dcc2be8459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXRLTUhmcGEraDErOXdUYWdqZ0dSaDk2bmFKQ3RmaEtYQTVJNzZaRTJLUjdO?=
 =?utf-8?B?UjJaY2VZZWoyL0R0L0E4enM0WnhpZUNyUktVd3F4V3QvRlh1bUxnSjJiRXBl?=
 =?utf-8?B?c29xd29uazlMV0w5QlFqK2M1OEQ4UkRZYzhFcERoci9XSkw1ekZoa21lVlpl?=
 =?utf-8?B?N1lYMjAyRUIyT0g5RXl4NTlXS05UZ0NDYkNhWVJlNm8rT2Y4a3BXL0pKY3Nj?=
 =?utf-8?B?elBUL1F3TFl0WFJhekZCUUhGNG9TLy94eStTS3B0VUVUaUZJN0g0UGhDaUgy?=
 =?utf-8?B?WEV5YXJjU0wrd1F5dmpNbkZ4am5pYWFCZFk5Y014dXdySW5KUkVqMHpiZWp3?=
 =?utf-8?B?T1N1bEMrNUw0d21TOWQ3NUxiKzV3bHJJSGh4NEtLd0s0SEo4NmJ6emdkQk1Y?=
 =?utf-8?B?bFpvNmdZd3JHMFVBZHR6Y2xJUWRvbzlGbWJhUDRpaTFhMnVSVFdxcGdhNkdi?=
 =?utf-8?B?WkIyNU5oVjVBTUk4US96bzVlQ1IwVkxRMEFIaHIwRkpWOGVnVmxDOW5Pdmdk?=
 =?utf-8?B?dWNXTUp6d1hPeDVNbDNYWUNQeWlHei9YZWV3M0RJSkRYeTR1N3FDNXgxZ0Nr?=
 =?utf-8?B?aE53MjlWQkNLZzI3Q0xtTXVIZ0Y0T1ZvZ2t5RDREc2tIeEFpMWxTd1Bwd0Jl?=
 =?utf-8?B?ZjdvTWRTbVJBUnFxV0xOcFFORGtQR3VTWURLUFVmcDFyRHB6c29LTUJEQ3Qr?=
 =?utf-8?B?SzBzV1hLMlJuRXRRd3JBenVDK1p6Y3pCQmpZdHFBZWIzV0R2b3lIdTFiL0l6?=
 =?utf-8?B?ZUhZY2RTYXN2VURGOXkwV1BqRTFFdjNldHFjSlM0MVhRQnhJc09aMTZ6T2Fq?=
 =?utf-8?B?cGJaQ0lubE1JNm5wd01TWnc5UEw3ak82SHNGQ2tONkxyMVVDWnhtQU9yMWZD?=
 =?utf-8?B?aWM3SVBDVFRzZ3ZDNm1kRzFSSEVSdW1IZi82UUpFTGdyMjdZZ3JpRk1kdzQr?=
 =?utf-8?B?SkxRekMwV1VLaW5ybm5vYm8rTWdqaFhxUUVPbTVvYTlGcFZIeS9oUmpnejZz?=
 =?utf-8?B?N3hFREh5SHcvb1d0NUU4VzAwL2N4RjBRSWdyQUltMjZMWFlpeU40bm4zNUNB?=
 =?utf-8?B?azlpejVQNUJrdFFqcFpPWEtkTEdIT05HMWQrK2ZkTmRvR0xhUGFpdkphVmlw?=
 =?utf-8?B?NGxxRVM3Y3cwbVNmeDhRU2N6SG1BRkpaQUxGaDI1UlZzcmxMWVBYaTRJOGRH?=
 =?utf-8?B?dlVlQzFVVTVuSGgzREcwN1JKQm92Y3FtWTNZNHJOOUE5bVZZU1pzZFVYOENa?=
 =?utf-8?B?eXVKYnJxTjV3aisraGZrVmVVcTN5K1pxNHhwRFZsT1BMWEZXamhLTklBYTQx?=
 =?utf-8?B?Z3BNWUpwMm52cmNDc1RXSTl5c29hZWkxUllYbDRhU2w5NTJlRWpHY28rcUdV?=
 =?utf-8?B?MytldGpWMEdhanBNV3ZXc1drSjl3a0pZbXZQQkJDdmRwRnhtanB0ZUloSkhE?=
 =?utf-8?B?RWU1T0VZNlg5aXdVVGxnSVlYd1lyb2sxaFdOUnM1YmtzeGhoc21Uam1nbWZ3?=
 =?utf-8?B?R3ZYV2QyUGNNS1NhWjIxMzZVejZmMllsaGs1c2s5TERJOXZJSTVyUkVySWRB?=
 =?utf-8?B?d01kdGlCM2plbHIySUFuZ1VKanF2ZlBwT1lxZXU0a2VmczNFSEVzVENjbGh5?=
 =?utf-8?B?S3crdkZYazgvVXl1MStUbUFwOW1iK2tpVzAvcWdLVlc5UUtKL0RBMFFiSGNw?=
 =?utf-8?B?dlZlWUlhaXY4c1VwQzJXLzNJMkZTaWxUSEJES0V2eUJPaDR5VU9PMTRENXdk?=
 =?utf-8?B?UlQzWmZPekVJNWFiMit5U2NteTdRYW1CYkVld3hvVUhvSjJ4bmRSSFVaM3ZN?=
 =?utf-8?B?MmY5Z0FSMHV2S2krZHFJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElpYXQ5UWxPRnpMWnJ2b1M1Y1cxeExMUGV4TDdMK1V3bHRWR2VEMzlXRDU5?=
 =?utf-8?B?YmMrWDczWS8yL0hEUHpxb3JmNGhJMEtTRlFGZE5JNDhoU0VaRk1pOENta3VZ?=
 =?utf-8?B?enNPVWpOMjZDYXJzYWViamVZWkx0eDVFdU1xcWEzK3pRWmo5dUhoWkZaL3Fa?=
 =?utf-8?B?b09wTDNhOFRjbUJlY1JWNDBKczk1UHcvbitqOU5ZTG5UUUVpYitMbjdSU2x5?=
 =?utf-8?B?MGwwcUQySGc4UER4dFJ4UlhPQ2lRY1MzYjRGMFlCanhuakYzeUdxOFFSN2pn?=
 =?utf-8?B?ZXB5Y0c5b0hLaWlOQlEwd1AxYUtXM1FXKzJyWm1mUnFiWXRmQjhNRy9kRjV4?=
 =?utf-8?B?aUI3WUc5STJYb0xQWGJCQTduMFQ0Z2dLa2x0UmZqMis0SkJyMFpMeXgxOUE1?=
 =?utf-8?B?T0hTR3dhVlRVWDFBNk1CS0U3MVhYaE54YzlCZ21ySnZ2YmxiMXhuZ01nRENH?=
 =?utf-8?B?RVJCajFucEtOaTRPN1BJc0xiREhyVVZpL21NN3Y5WDRNaFUzZTNtZDVZbnor?=
 =?utf-8?B?L0lCOUxjS1JmU1hwbnd0UzJ1ZHVOaTdLSmpvTmlYRzJpb1hGSXpIL0NSQnEw?=
 =?utf-8?B?OTNwQ2h0eFovOHcrdlIvMUtmaDBJRTVnM3JpTFA3SS9lTnJHc25iNTNDMEtZ?=
 =?utf-8?B?TkhzWWpOWTFnZ2szTUYyUUJkN1BwQ0w0MlZwR3d4U3M3YitqbjdyZi9aamlP?=
 =?utf-8?B?aWw4a01lSWxQQVpTMjVQWUhMVjJiSFdrZm5XTG9xeUdIVVFuMFNCUTJLVERI?=
 =?utf-8?B?dFN5MGhnU0dZZUdaWDkrMEM2dnIwQkpsQWtQYUhIRjdqZDhPZXZERWJ5N0lW?=
 =?utf-8?B?VWYwbFhaSU1nTWJNb1VNUm1Da2VBSlFpWVl6SzFnNHlVZmxIRVYvWHFKMjVH?=
 =?utf-8?B?eTRwam5STGVldzNSQUNORE4zWFlWS0p6RE5HV0pCYmR1aEQ0a2pPTW1uU0g2?=
 =?utf-8?B?L0gxcjFYcDMwOGpTRjBSaVRQVjF0d3NEZzM0SFJUaHcvVFVKclVhMnFaeElK?=
 =?utf-8?B?WVNoOU42Mi9JMHEyeFdDeURoTW5wR2dIRGF0a3lZOW1QUEZ4ay9ub1ZxZnNN?=
 =?utf-8?B?YVh4aFgzdDVndDg0Vk10cW1vWjF1SkVUU0tzZHhCM1duNTg2R09FSkJUY0VB?=
 =?utf-8?B?RHdkZzk2SG05Q0ZYUmloZzV6d05oNTNOeUVFSWVzZndBWHVudjYwZHR5YlN4?=
 =?utf-8?B?YmZXbHdrODZObXI2S1lMK0poYktmOUticTFlb1ZlQzZjVHYzN3lQMERmeFJo?=
 =?utf-8?B?Q1lpRGhySytoQ3dVUWRDaUNjOExqSVdoM0ZXQlJjSFJrVExTMGhGVUNoTVVZ?=
 =?utf-8?B?TW5ERnFJMmxTZ0w0aEVOZVN4eVFnSE0rdUM1NHJLalNZblQ0Y2RNWmRDRGsy?=
 =?utf-8?B?WmNUbkR6cTFRUnh0NEVEY1pLZVdDWWZ3ZXRNMjFXV240LzVub3ZZdFVGbVNw?=
 =?utf-8?B?N0RFbUQ5TFV0eE02ckhnVmpHMEd4dE5FVUNoSkJQbGcxcmp4NExXQ1VESHVD?=
 =?utf-8?B?b01rL09XMmJPaXZzYVBqQmk3N1J5SE1OVy93RHRWS0ZMUWU1amVWSE9yK01D?=
 =?utf-8?B?RWE2eWlKaDdycUkrM0VoTTdRQkU0QURwOFBnMDZISVFDcHY3UXF1TytkcHZP?=
 =?utf-8?B?Q1lqRDRUbUNnQlcrM1ZWOXUrTW1wbzlXSTlXdWJMd1VsMG12MjBXUmU1Tmtu?=
 =?utf-8?B?RnhhNE54bzc3Q0FmTXVwTEFQeE1LZjNzR0ZDR0xpZzkxL0p4MGZBZVlsV2VZ?=
 =?utf-8?B?WVlETmhIazZhOER0TCtiUnZMb1hNdXJQUi8wTHNFUVhYRUNaYlpoNzB1T2Vo?=
 =?utf-8?B?WXNkM1RaQmxRSnZwa1pEc1dOcjZwbXFMRHBsWHppVlVpdmdOSldCVndIZCs4?=
 =?utf-8?B?aGN5UG5sS2pubUEwOE5kUWlNL21IWTQ5TDc5WjhPYmgvcnJ0azM1Zjc5TmF2?=
 =?utf-8?B?aVpPZmVNd05WNnNWSmh2bGFVVndrb1AwdlN1MWhGK2IrL0V6Y2hKanlsQTk0?=
 =?utf-8?B?QWVBaHk2ZnBITEk5M2U0cEFQWlRaWFVKUFEyUDNXWlNRaHFUVlJ1QmYrTFpt?=
 =?utf-8?B?Wit2cEhvaXF1TDIxTUpDV2RKUmViekpzbmdlTUl0c2ZTSjFSdDdpZnRvUjhF?=
 =?utf-8?B?Q3gza2F5WXJUa0tWZGk3cThoWnpTOS9jYXVGTXQ4L2tHSnpsOE4zUGV4NHR0?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a555d7c4-d8d6-414a-6c35-08dcc2be8459
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:24:30.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucjnjsu24JgQcSaAg5s9tOrPPtoVf90GX56jJblENYUZh96l1s1YgfxlcDa/7HHC0gZUyFfX4Z2XAxd+rZU+jWddekftcxvoJhk5asT03vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 17:43:16 +0200

> On Wed, Aug 21, 2024 at 5:07 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
>> ("net: remove NETIF_F_NO_CSUM feature bit") and became
>> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
>> Remove this bit waste.
>>
>> It wasn't needed to rename the flag instead of removing it as
>> netdev features are not uAPI/ABI. Ethtool passes their names
>> and values separately with no fixed positions and the userspace
>> Ethtool code doesn't have any hardcoded feature names/bits, so
>> that new Ethtool will work on older kernels and vice versa.
> 
> This is only true for recent enough ethtool (>= 3.4)
> 
> You might refine the changelog to not claim this "was not needed".
> 
> Back in 2011 (and linux-2.6.39) , this was needed for sure.
> 
> I am not sure we have a documented requirement about ethtool versions.

But how then Ethtool < 3.4 works with the latest kernels? I believe we
already moved some bits and/or removed some features or it's not true?

I could try building it, not sure it would build though. How do you
think then we should approach this? Maybe document the requirement?
I don't think we should leave the features as they are and sit with no
bits available only to support ancient Ethtool versions.

Thanks,
Olek

