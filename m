Return-Path: <netdev+bounces-294758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 654/E68yIGrvyQAAu9opvQ
	(envelope-from <netdev+bounces-294758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0AB6384E9
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WeQv6yl0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294758-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E3A305A5F0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35292332EC8;
	Wed,  3 Jun 2026 13:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF72C21F2;
	Wed,  3 Jun 2026 13:48:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494505; cv=fail; b=OO10QQsiPw/TBIobZgOWZ9uuRAy9ALu9PPG6uRer7wrX/ClHxU8WPOcVU+tFeM9whOHVMECTQ8Ksxnl8Q6/SxieJMgYFilhQUDsi/OwIgNVIjX0NNelL7a3rZ1yqiO5v2ybsigRHwNYHediEC4CrtUhXqPumcVK9kmjnfRl9tjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494505; c=relaxed/simple;
	bh=jC9y7Y8I8qYLZZb9yK6YmUPEWunsXV4r/yNS0xSC8II=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSqtJHBSYIgz/e3rdficRGBciD1+iqafUU1jcr7mEn80Ss89D/8+N5gvYPz1yLVh7n07Fqyr4G7QF1uvoKr6UkcMF83/ytU4NHW1VI+Ir8xS4/aO2JwSzoHYTxITGSE8/E/Cp7EOh5dbl0LQCY0eXxe2QfSHw09C8ukFDrAqJAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeQv6yl0; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780494503; x=1812030503;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jC9y7Y8I8qYLZZb9yK6YmUPEWunsXV4r/yNS0xSC8II=;
  b=WeQv6yl0+xop/52ZbFIst09AbmSnsO7MV+Gfi0eFY4sDA7CQHWpfkCfZ
   6P3IRhWHoRqwQWGeRl/5N4z4v9PXDOrweFtlb7702qhPAg52Cq+2s2UPF
   8v60qM/W2Y3swrFfPLRpGeYTlyo5xyB+NPkDj1d5tfFHBsG758qOKLH60
   Z+WqL11Jq33pmY8tHCUFFj2w2LNdDemj38PpFM8OM4yoBHydix39njqgV
   yiuq3iKH/zDzpyrOJxTWYppMrRFSH9ktOtXtWjgd135EjC2YctQRjYUnt
   Lx0a2htoiX+Ga3ZuXstL5x7eKl+aGC9ZvyJv/sqxm62klJCBNVKjvOzW7
   w==;
X-CSE-ConnectionGUID: 7ypgdAKzTzubJxBevkVgMg==
X-CSE-MsgGUID: SkpC3tDvSROGabzjbRP0/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81364797"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81364797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:48:14 -0700
X-CSE-ConnectionGUID: 3+KcN4J8QZ6t5cWtvT2mqw==
X-CSE-MsgGUID: sP16TrczTIi8CpNPxC22gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="248553473"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:48:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:48:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:48:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pULny8GWxJpfLjeinjEW656AsXShJjsgEmD1siPX0trB0PkZG8bsMpfaJDuK7QWvT2pQSbkhuL60OSteqLlqNrvA14/sDm+I7lSwKWhZEBoMgLT7UjbhN4kJuIbEddOOWmjpmjEGCPnFk3COffzxTGbsJxxlB+QNFQWrAFeYM5bwpWcolJ7Lq6bMHlWaMxTOjoP63rHkXF+Fx7RqOa6HHNfEEq2e3pDho6IUo/io4zZF0fOUtqmvQjNe6tVkhO6jBXwYAXmnbuaf1b1XLblvzTy8R4qy1N7g8Slbf8XwnxOFml3nJy2UtF9nquL0uKF5qOBMxOiZgfXVE29aEqs5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+8z0NUok2MQIBo0KTQjsK2LN/62W2Szop/qaStag+g=;
 b=tdP99ROj+CI94wzxMtA3nQeiIGTkbXrYt8je8jz2KTdjyfOlgokmOb26zBOn61UIXt22G/iA3MaSO0CJgpUdR+vsslcWAOrwHbuqaCuaYfxWRviEu1ABxIC3qq4iK0ZtonnQwjy7uoJ3SdLJkQQR1wxEtHj+t/VvseaJdnrwkzBrz7fnpVhg2Pu++1ech2dG5NSDBm970PitNWqiOFO1YgjVEjp0jb/js4COGIUaxTfox/BCD5Xd2ESH0gdD3PNYG+KygljJrh/eDsBIW682QUs/7L1kHUbE4fqtrwEEXpXFDLdH2WMXblL4HNDIwSVlTle+DKP6u5H9AHOyK6Bzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB9613.namprd11.prod.outlook.com (2603:10b6:806:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:48:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:48:10 +0000
Message-ID: <423d23d2-b2ba-4a33-96f1-a1e21437484a@intel.com>
Date: Wed, 3 Jun 2026 15:48:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: clear skb->dev before running a sockmap verdict
To: Sechang Lim <rhkrqnwk98@gmail.com>
CC: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <daniel@iogearbox.net>, <cong.wang@bytedance.com>,
	<john.fastabend@gmail.com>, <jakub@cloudflare.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 42381bf5-c4e0-4553-366c-08dec176bf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v4KIrhSZuyyj19KpkycED/5mzS4PTmZH4QiW+TK/oMNtC5JPB1Rdur/ZoMiLj7aTuCgISzTfRP7alqhdS6+0yWBtM/TeXzYDAn2WXITe46uDcoJTyoSX8Wmbr3y4P964L7YhA6KwQBtK+0l/qAKNwGBfcb7xXltceuFAh7bCg3HksLQ3sdliUVTZkzWcAwWSV9UxTuixkZ3KNXKbAtzGnwViIjPn1/2SMnPS5lj1RxtjfQLWHBecdDLMqeIxSvAO+AoKBILK/jfMU5F7D3AOjlExzq/7ALsl0MvX9T6zUjxMgeS/EAdME1d91nLiKUBHzJ8M/4MHa38Y2O1UXfcm42A0dudWh07oqa6fxFBLUH1Wx9OhhDXvkTHQ75NwvpIX3XE788fiFQxiprVSAgElMB/U1BJjrm43XDyXzsmO+LU9aM2CIffTRSy03LgTL9zVirkgOXZra6vAMbtv32x3vtIpZzvF6EkqILaZw1QMcElc6xeWouK5oo7GiWuBryz9b7VnT6/P3khRpYz74GtbQ1lxuOOsTxOlezVtnmdDU+x4vJbUeT/j6TNsPToTEIpZcegfv+Lfkf7kBj/PUipnoafxb2e1ugdGKNE0oAranq0Qd/TqEbYZd0W6S8ofoX+SkKvIumwDaQSoJ/7JZ6/QeP2g1rW28CLhHyPQEc0gJKINHTIZyaDwuLpTvliX27vN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNNbE1IalpSblhNS2xuSkhMM3hvbjVzZ1pIaFBuV0tRMmZnaVBzSXQrU0w5?=
 =?utf-8?B?NzR2SDFnR1Bhd1RQSmYvZkF2RDdWekV1WGtvTXF3SmU5eUFKUURNaUJlMUhY?=
 =?utf-8?B?d1NKcnpCOTgwMmFBd3ZDaW9YSDNadFpxUWJpK3lNMHVULzM5UVF2QTdjdlVs?=
 =?utf-8?B?UlEzamZIa0VDY1hQSGJjVytodUN0aHBTcnRBQnE0b1FUaWpHY2t0NFBlQVpS?=
 =?utf-8?B?TFROM0tUT1ROZHhDR2FzVEw1akV0Rll5WVQyMEFBVFowWU5IWmxjK1A0YTRC?=
 =?utf-8?B?elE4dDY2SXl4Y2QrR1E3dzRGRjBRTEhVeUJqdVFSb3kwU1NFYWpYUXkzUjlz?=
 =?utf-8?B?QnRCRFp6ZGpYT0c0WEZWOEQzWlVvb1BJZWZaNnUveHZBSndzT3EvM2Zscjg1?=
 =?utf-8?B?VjhsYU5MT09oa1R1clRBMTdXek9ESENKRDZHRS90SDZ2czUzKzFwWTN1dnps?=
 =?utf-8?B?VG8vRy9VWkhTVFk5VGFIbm5iVUlxZkNmb0ZaenVsM3RsQzEvNGMxUWlwNzBH?=
 =?utf-8?B?MHN0ZWN4eWx1Y1lzZHNzVlgzOWtqUTRPTVBIN0liaEozaXpMYnFLMUdudUlt?=
 =?utf-8?B?aUZNWjM3NW55T2FyS1h4SEZWNkM1NTFwMEd0N1AzOXJCR0lPNVVVTDliMTYw?=
 =?utf-8?B?ZDZtQmxvWGVCNGVSTGtOaElDNExSVFdHSDUwV0JMRldzRXd0VzliZm9EQzg5?=
 =?utf-8?B?NlhiOW1CY0tTLzFaN0Q3TUYvYU1DajU1SnZUOFZzVFg5cm0rNkY0N2drRjhE?=
 =?utf-8?B?dG1HOWUrU3lRV1pmNnZMT2lIclJMMldBRUxQeGtrMHdKelhhcFA1c0lQVlpr?=
 =?utf-8?B?TE5qVmpUNVIyeVNGSFlsMUQ5K3Bzb0pxRUY2T2dxUklhODlDY1FXbTBzUXNW?=
 =?utf-8?B?Yi9uSVdFTUFsU2JMekZtaFFveDJHaFFhenl4NzVuV2MzenRIL04zSW1Nd1ZK?=
 =?utf-8?B?UUVveU1GUHlIOFJ0UUl1cXBReVZuNkJkREJlUlV3Qkc5QUpWME80Z2lXdDlJ?=
 =?utf-8?B?YmwyRlZ1V3FzMlU5U0VCdXBTeU42Y2pJVUtRU2JQUExsZUtvVFdmYUpRZ1lU?=
 =?utf-8?B?QWlyVEdvMGpjVVlBZEIzdWRaR3Qwd2JMaG9YZ0JCWllVcnB4VFRMdUVGbW9R?=
 =?utf-8?B?UDhVOHlpTnJxVkxqNmVPc2U4cXAzZVVwZGJHak9hWS9jZGtTenNwTDY0d2lV?=
 =?utf-8?B?WmkvMnpCKzFNdHpSVVZ0UFV2bytGQmxKRlJ5ZUZlSklNNGNhNWtWMDhtSExq?=
 =?utf-8?B?Nlk4cXphY3lhOUdmY2hCMVBrNzlxdFhKUUhNUkZhaHNQQTJlZlpwZHlmMWx2?=
 =?utf-8?B?L3Qyd0JaODh4VkNZTUhkQStGNUlJeHM0SnhOakNRNU5UdWt3c0lWYVRiU1Jp?=
 =?utf-8?B?RWp4YnV6Unp6SG1iUzhmY1pnOVJIQVBXRDlwWm1VbHRGWmNITE9FTWZpLzk2?=
 =?utf-8?B?QWlUS1JuRzBNMFVUUmFUR1lvQ3JPc2p6WWpFUkY2NS9TNldqQjBxeGRUbzJX?=
 =?utf-8?B?Q0FPNjVzenNwdnl6Sldqbm5TME1rOVZRYUp4U2lydlpwbStOaUFKQm1iSnlK?=
 =?utf-8?B?cHM3OGlycDU1K2tnc1FhR2FXUVVmNXV4N21NRzg0TXhUN2c5MEtVbHBrUkl2?=
 =?utf-8?B?bjkwby80anM2b2ozcFAzWEd5ejEzVEc5TzRGM1QyRUlxYURDSVphNmdxenhk?=
 =?utf-8?B?NTZyWUN2WmZQbURySlBHTG9YN2dvV3lBZVE5UlpEVjFnT3V3MUhkbXZINmNC?=
 =?utf-8?B?cG9wNzBxWXZOckFZblljR1NMK1ZXK3hiNWF1K3RTdFhsRmM2TGV5MytncDJp?=
 =?utf-8?B?TE1ja1lqR1lwUHdnb1VJRUpaOEs4SUh3aUxtb25xUGsvRGVnZmVXWk5CdmlF?=
 =?utf-8?B?UzRHSUF5dXZWZUtSZEdianJHMWFidE95YzNKSE1uTEsrSVdYR0NlQ0xVWkNX?=
 =?utf-8?B?S1pHejdoQlRidTJ0MGVtUzdkcDc5TC9XTDhsOTVVWjNjZngxNXhCbG1oVHZJ?=
 =?utf-8?B?NDY1Y09UNE0wWEI4eU9NaVFaWFBCM3AvVlB5bEN2U2FmUWo4aGV5RXBBbUVC?=
 =?utf-8?B?bnhMaC9EOHcwUjRwaFVoaEFkbWxnRW5RcWRXMGp1OHFNOFNJaUp3dVBvT2I0?=
 =?utf-8?B?VEJjcThqQ0ZGTlFTamd1c3VyNVlxVmJFOVZ5SFp4clZHYzJLNlp6NkVaSVU5?=
 =?utf-8?B?MVo4Ym81WFFrTTlkZTE0MXpEUjBFandTUWNtNTVxNnBTcjlyTkx0RXJCaXcy?=
 =?utf-8?B?R0hKYk1nbUhmc2xaTVowVmV0RE9XcWtNU1hvQ0hPL0IxcmVqK1BKWEtUY1g0?=
 =?utf-8?B?OEFsdWduR1Fkd1dEU2VoQnR0MC9QRm1FVVhQUjUrL2lMblJTdlM2RzR6ekZV?=
 =?utf-8?Q?QmgDvK/3oG/KL/ro=3D?=
X-Exchange-RoutingPolicyChecked: CAY0Ir9vy7EmlryzJ9EQqj+lnnKnw5HoTVPFdbJce5pwbLgJkNYCbSgYokCeeZmS/JlYZurb7ykqTFooIIL73yJfGz9K0t7atRmxP4zmSoRjHMozjkrPz6dIZnZsBURY6YzZZjGWvm5ihAjgZZ0UGuEn7gSXDxqvQrDf8zuC3OUd4usgdXizfevCpfTCNUbx2K3bobUqPlCTAv9N8ILxEXG802sO3jB6G6mCpZBL+qgjPslfoTLvAwJYB6d9k8HCrlJMXdi4qb+gmnMBRtFxQCF/OfMA0O7Bkoeny5ENWVycAUa4yo8fOvct5dXLiZcEVYWDv9nTmSBbuYK2UyyHLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42381bf5-c4e0-4553-366c-08dec176bf77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:48:10.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btW4selFO0+b4KZFPJalz7yTOBqa8jTfrQpnM1wBiLX2zgv7dAgP6p6cWJDkoSIfVedCdgoIQfMDzlriS4AJZl51xvbe3wO+5LgouL+wC/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9613
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294758-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:cong.wang@bytedance.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:from_mime,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,bytedance.com,cloudflare.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D0AB6384E9

From: Sechang Lim <rhkrqnwk98@gmail.com>
Date: Wed,  3 Jun 2026 12:26:37 +0000

> On the UDP receive path skb->dev is repurposed as dev_scratch (the
> truesize/state cache set by udp_set_dev_scratch()), through the
> union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.

[...]

> Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")

I think you need to add

Cc: stable@vger.kernel.org

here to mark it as a candidate for backporting.

> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/ipv4/udp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 0ac2bf4f8759..f5ba36e721cb 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2011,6 +2011,11 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  	}
>  
>  	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +	/* skb->dev still aliases the UDP rx dev_scratch (its charge was freed

Pls favor generic block comment style

	/*
	 * skb->dev ...

> +	 * on dequeue above); a sockmap verdict program may deref it via
> +	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
> +	 */
> +	skb->dev = NULL;
>  	return recv_actor(sk, skb);

I'd put newlines before and after the added piece for readability.

	WARN_ON_ONCE(...);

	/*
	 * skb->dev ...
	 * ...
	 */
	skb->dev = NULL;

	return recv_actor(sk, skb);

>  }
Thanks,
Olek

