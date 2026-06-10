Return-Path: <netdev+bounces-297701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E9bZBWtwKWq5WwMAu9opvQ
	(envelope-from <netdev+bounces-297701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:10:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6F66A202
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:10:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ElICXlfy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297701-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC7B2301C58B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB8410D0F;
	Wed, 10 Jun 2026 14:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EB409136
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100514; cv=fail; b=l+tz7onOf5dGyPcMurb6vlg/NlgyT/7QBN8TuwCW77j4x/l85xgJ56jfgYzc1X4kHbdPjmNfBbHhZU8c4oCk0Hb2J17TkqKYbrRQVYBUArvO3kUiap4L6hbLeL6Lo4f8vskaqZQGltIZIeVBYPvRgVh2Heo4PvTd3HLXvP+HTQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100514; c=relaxed/simple;
	bh=M/HlsFEB4wUqcnawJnvM6x8rWGYoOgUJAIMfS5KaJJA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUa6SVRhfnLUBZ/olkZquBd/2TXO8jq0FWna5wm4KlIT7bx0s3zu3FnGouUNXGDVDGwm80utdqYrRorm4wgFu71hoOhtVqOUGUbXbIyVmmivQUpdeTeo+l7iUfV8e2osZuDUtm8geFVto7QGFxAYUyCuSvD+B0mDQ1PAw0n+phs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElICXlfy; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781100513; x=1812636513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/HlsFEB4wUqcnawJnvM6x8rWGYoOgUJAIMfS5KaJJA=;
  b=ElICXlfyLi8NXSdK110YKSxUsrY/oDdB2lylZZUY8jifrxLJt7bdV5fB
   U8I1aUW0yYWU4UtpgIP0rPxgZbjHbakZLdiCcBu998Q3xtdD27jBhO4gd
   p8nKKwkKETGOGaHbEebS4ELXFmSGFltxhL1cN8Tu7p1XTOHEe6kf53o8K
   gatIshRyO+dp0cRU8vDKJeZlNbL+Z1WH3Wybt3ZG+U++mI/5radPOQq7I
   yl7JT5miPTKNBednFsfdyoBku2WlWm51VYNr7h6XLoRkX/zTla3DC2C3V
   BC3bej6r+PXCL2iPPFQ21Yi8cge/5NTZzORGmmkIBNweOJ/C339dgo4kH
   A==;
X-CSE-ConnectionGUID: nlM6EzxKQp+ECMsT7ymw+g==
X-CSE-MsgGUID: CO5fFYpaS/WC3V8u064HMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82084858"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82084858"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:08:23 -0700
X-CSE-ConnectionGUID: jAT718IYTNC8LGrSKH3/mQ==
X-CSE-MsgGUID: v0C1YhqMS4qA3+A5RG6T/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243226237"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:08:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:08:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 07:08:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 07:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBsrmhgaL1Vq4AH5jp4JN0LUKoyaHhDKfUxF7TdPXb+8YijBqV4Scoleo+HgCHd1KefBByIVXrtNi7koY4eNMo5OOk1LbOr5tnFiatRiMFEejC2u80oqwh3dMjYK2NvQvH5evLULis/azX5L0IL8+19kAuTfiePQoE6tx0FAnmG+TbBKcJa7xbOTh9ZWNPQVhx219RekbYDc7aI41E76geQ9cTg8xINVNvUNvuISQpsRs3/NAhXqOtzXVdTKkPH2hQUZPLZvHvxgvzG1LToAcfqNDwucahrvAOsjPWvkQcCRGuBY64nCyHsZfbpGn/TOXyzVblaDSFRLfHC3ZY7/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/HlsFEB4wUqcnawJnvM6x8rWGYoOgUJAIMfS5KaJJA=;
 b=r5l4f+Kf2YXhRe9eW4ANKKNl63Mm4K4eJ8n9YavGDYT/bqPpO3ly0kdBR6nWU7k8T2srH3avhTvFevXuDSjo8QJzTZLo1EOli+we/KxOcqtUWZ+Iw7vOhzch5Dy/WinwUQ8m6SuE8kITX6T35+xqeFIOQjuiTc5UR5BbJv1RZK8kfGp6/m0Gj0X75nUB/WFN2pR9Wd5rnW2x+YWsnRkwlHlX9XYLVFUqpzLE/71Dt28E8VMTZ4BeM0PSv/0Qajw8uDqMBOJsATboAk5mMWjxxpfgGTP2is5RPoFsGgALFn0bfKUEUxWkLmHgQjdaoC6IRAOCFpw/Ep9YXyGKd5Dykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 14:08:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:08:12 +0000
Message-ID: <22fa3c80-54db-4216-8971-f755d12f0005@intel.com>
Date: Wed, 10 Jun 2026 16:08:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/2] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0351.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 301fe315-fcca-4fa8-88d2-08dec6f9b521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mC/Knt7X1gzs9cNdT9yY7lX1oC7mD97nA0nv3im5rhmLRdc73T3+MjLabfZr632DG4Ez397vzIPuzmvwgut+UKDviutfjIGwlGhVJo1a3AxOKPq5r8WXDI24J+m6QHSbXo8IR8ZiwRiCqSyLwseY+q7v9bvuHWi/ObrfynVNS2wYsKQx2MINRs4F4rXXhuiu3R3pOIKAbrVzNhR4z/QXx3aYW55r9oaQEBhX85tvlIxiBAckiMBU3wYB/qmt/XKBM6NofOi+4EuyedDgsBg7pv6oX0FKrnIeoh2i19wxCyUX3LPrHO3eNj27PSxr5ukqRwuXpOKcTNX1rfNSqh8goE1e6wrQnaGcQApm9sdtYY4cCwpRABRcSX1Seg9lr3Egzb3lw9go9to2hloIXE9qLj4R/6ewchL9HiAwg6tfyYnJ4j/9kUSoZXU/0RPocQYBTZ3RZmA7NVNrh7Odb0uC4DKRBcbyMSKjRgZSoleqcMv8Me6uywoVw74zEpH/8nEXh+E+LBnzyE57+ZAw8zixuPwQJDf66MhXol3fJOtKfNCHZGGb56PnK3+IG5FS9AEee++1ULzSKnJXF6w5HtMROIWqOZVha/RkVB0feDbANCTYNMJ3dr9zylCKp1O4tCb/3G3+PcDkd1Gx837U0ebivINoF4Rhco+FuekY8tVC/ZEFARCtu8gMhdc4QaoLfpZf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlU4SmVCOGQ5UklIZGo4VjFtU25pZ1M2aUJUbkQ1TWp5d0FickJlYWR0ekZP?=
 =?utf-8?B?ZWViejd1SkpvNWJKQTM2WFZma2QvUnU2VTRrMkM4S2xKY2N5UWF3cTQzKy9x?=
 =?utf-8?B?Z0ZBSW5HVkxTc2JjazlUWXBMTnQ5UWRxWDFtYnc0WTBmS0xycjMxenRxeWtX?=
 =?utf-8?B?czdMb2dpSUpTMHU3YU9KYW1WS1h1L21FRkYzODNTN2ZNZnUwc1NVNWlUQTlJ?=
 =?utf-8?B?a2tmWU9hRzNhT2hDT1JQNUZKODNlOFhKQVppL1FQWVdORFgwS3g3WnFkMldH?=
 =?utf-8?B?dlNpcCs5S09Td0xvS0dINnRBTGMva2krdDIxVTg1MzRtYkRYN21PcXZKNloy?=
 =?utf-8?B?a0hIcHVwYzFwaVg5MThOR1ZmbDlCejY4M0wxWUthaUs0WXNxdzhVZ0J4N0Rm?=
 =?utf-8?B?WTdJbjc2S3NZcnZ0SE1jdDh4QXRtOW5tOXhjV0VPNFdRU29Dbm9oaDV2dlN6?=
 =?utf-8?B?emRLMkJaTEJKSU1ER2NMQmsrSWlxOTRqVHVvVlE3Y2l6cnViOHVHYjl0Vk85?=
 =?utf-8?B?cVJaZGhXRWZjYWFqQmFDbVZFT3ZkSXE4YnBJT0JBdXB5UGNISDhXdkh5OGlH?=
 =?utf-8?B?S09EeUtUTE1LNTFOblB3VEdGdTVmWWRsRkJtTHZ3bTc3L3owR2lsc1N0Njg0?=
 =?utf-8?B?cHptVHN4eVFUcVpOdEtkSWZLNkxsclhsR0pxZjB3WkM1MHgwTUw0SVV2OXVi?=
 =?utf-8?B?cjkwSHJuU01IQ09DRVd6TGdza1lvZW5PWTk5NTdRTzhENUNtNnRXRlpja0Nu?=
 =?utf-8?B?ek1wN2MzTFJXMmJrNXhTN203d0RZbnBJYVVVV2NPQm5Uam5MekkxdXk4U0Vv?=
 =?utf-8?B?Nk5ZdGF6V2drZ29Mbm12USsyZXE3ZWMvMGR3SUd0RDNnQUJYN1QzTVYrU1lQ?=
 =?utf-8?B?Rkd3ZlB1UTJpSHZ2UnB4V25IM1ZsR2tNeDNvalBJbkVEKzBEaUdyUnhxdEF3?=
 =?utf-8?B?eGdkeVdoNW9uMm5aLzFZQlBUMjlmMWYxRklsRTVwOG15KzhIU2Jra0gvSnVI?=
 =?utf-8?B?VmE4Z1BBQmFEUm44N0xtbWlkMEtCRlhYbG1INDlnQlI4aHRNZVpUNUR3R2hq?=
 =?utf-8?B?bU80N0F3WHFZUHl0UFZnek5xWHNiNFF5ajVUWlI4NHpUbkhCVEpMN3JIdG5n?=
 =?utf-8?B?WXd1VnlYUEdHZWg3RUlaemxyaE80TVMvZVJGUThYbVhrY0pxeUF2ZUhKdnJZ?=
 =?utf-8?B?V2thZll5dElyWGJ6NTJ3MXU3dWZyY0QxTzN3bW1YNEY4eFkvbkNGd1d4dkhj?=
 =?utf-8?B?OUVKSldRbXpiSFhGWU5nVWZnT2JpSzNydVpQcTVJalJDQmRJMXN2OHFQeXlM?=
 =?utf-8?B?VFZFSzEvcTJ1NWJCTDFtVzJqMFFJNDlMQjVUUDdocmpMU3VndnhiR0VtVXJR?=
 =?utf-8?B?QUdqbzIzR3ZYTFVFZ2U2YXF3OHVEUkFyL0pCRUlHdFhENTJvMERBSEtLL2hJ?=
 =?utf-8?B?aC9pYmNGTldPbi9ZMnJicUZRVG5wUUJMOWJsM0ZIbzV0a2J3L1hDVVlGN1d2?=
 =?utf-8?B?YVdrYWl3WXg4M0hzck5JU0w5NjJuNENLbnVJYzJLSFVTNHFEMnZURE1FbkhU?=
 =?utf-8?B?SHZ0TUhmRVU4RWhQMXA1Y2JrcVk2Q2hLNEdJaStGdXhlTE5HaWN2NWRobWh1?=
 =?utf-8?B?cjBlUlBpZWxZekxRcU9KWXBoVUlteEZlVzQveEoveUZ5RitKWCtLVjU4RFF6?=
 =?utf-8?B?cU1zaUFrNUZLcCtVay9FS2x2R0c0VDVjYmFQaitnWW9IWkR2QXBpTlhDaXE1?=
 =?utf-8?B?UFlBeWNaZGxLQng2aVZ3Sk1ibU9BUnE4QXRPOUVYcDlVRENxY210Nmt1VTlE?=
 =?utf-8?B?Wklha2hoL0xzYnVnSXd4RS83LzBIL0tBV2xVUUJVYVk1R1RTTi90aW9SWEhV?=
 =?utf-8?B?UC9tYmFqaklvZXhFdmNWcE8vaVV1YlVrWFNVZ1NEMElCQVVURXNMRVl6dFVX?=
 =?utf-8?B?WlB0cHIvS2xrMTNXMWZCSlJVam45c05wcFkySHNyb3d3MHNNNzJMRm5BQnQ1?=
 =?utf-8?B?WTY4SlArRE5CNURvUXdVUlhIRXZ5Z3JiTTlPaDRReWJLeUd0N1BMeTdiSWMy?=
 =?utf-8?B?cENvaUVFS0pyaUhidFl4VEJ6OTlCVjg2YS9zUURraVBRMWdTdUFyUkZGN3hR?=
 =?utf-8?B?QkV6Z1NnVElHMm90RHVZMzEvbFlqdlZ1VnBRRHNNRXI2Vkg1S1l5T1Q4M3N3?=
 =?utf-8?B?clVYbWVlSHZKSFdvZVZQVURySFhCMENOZlIwcWNYd0xEeXJyWnI1cWVNYng3?=
 =?utf-8?B?RzJoSFFhc2hKVFJlRmVIc3N4YzQrN2FTelpyZncrQS9SOWJvbW9yTmkrZmY2?=
 =?utf-8?B?bTQ2TDl4V0dDTTEyTHFtVXp1cGlXNDVIQkNnVkhEY0lzeG1sdXJjVzZ1MFFz?=
 =?utf-8?Q?7b0twpcATCA+rmyg=3D?=
X-Exchange-RoutingPolicyChecked: gLbcLKihEoe/5B/3O5RcFUEQiuTQw8DCdBQrBGhH6klk9xyMZSUqt10fyq25OR09KJdD7SOWdDtAiSHgHhv1GxGhhDE2xI1tuKw4HlSy0Gk8ek0qLVWJUtiQ6jYvlrHUTHH5DlZ/bB04oDGunWDT3SJ7cO2vKDHCf3hYiBCmLFvUfUho8RGvjLcReS6iZ8RbBliwdgwucS5QvXytbfgybLwXB194r4NndUko2JUR7Sfdl6V9BzcpM5Zx9U5bte0myOdS0dJA7QYXziFwv7kGfGdfTFHayaiEYxk6VQpsOLV9Ph3zm8WFP9k6tu2rxf882QXnMLuV3anVfCfAdFAAsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 301fe315-fcca-4fa8-88d2-08dec6f9b521
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:08:12.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s0u6AOGij8YjZPXi5KUrRhccdeCrEsNGVIlLuc8R8DE3njagxRHtE9P5y1g2ELRenJhptMMwMQMYL+1T3Ks9c5h3nGFBnQCFYRRGlxQMBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3A6F66A202

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 15:33:35 +0200

> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.
Series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

