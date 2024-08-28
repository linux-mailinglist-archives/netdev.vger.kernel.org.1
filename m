Return-Path: <netdev+bounces-122956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717E2963471
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C711F23EE0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08701AD9C2;
	Wed, 28 Aug 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddKmCWBE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B5165F06;
	Wed, 28 Aug 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883100; cv=fail; b=t5nbCfvs7GXUkqKZET2HxgF+rcUlBxaOWykPrBeP1fwQ1hFwLP4o6Q5Zw+mxSskEc3AbbTCvmEwc5CArW4lEjJ4WIVY3PYGCNujP756LPeOZ8g6hM+qfYv0vgfX2OXCXJ11ZCIj9f9awVvNddA1UXN3/uTAKbHbO/sJcgltfOo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883100; c=relaxed/simple;
	bh=zSexEvycTf8Yr47ob1xVxRFzPaIgnV41OyX9pKtK0wk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3naReAbktM3rO9/oVZK2fZTpfO4D/BrL84Q4ABEju9gIY4SKCiaLwUR429NeZ/7nwuPFWt6t5klvtZoYJpt4vtF3wq6Bs2GH4Pd1PONgJDCdmJx9eO7GC1cRSnfQ6MjTs8DZpqof7DL9gL8X/wPfwpB/KVoSTiFy2sIo98lIhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddKmCWBE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883099; x=1756419099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSexEvycTf8Yr47ob1xVxRFzPaIgnV41OyX9pKtK0wk=;
  b=ddKmCWBEl8aWvP95ApiHo3FEvoZ/pobGH7KOHBT4g4d1vN+OwDOkYWaM
   DTbsju8MlQelLkPd23Kis0RV28EV6psHa4NHmxtPQ0+SXfROcT40gPqil
   5zyqKuj60AtvAROQMSU67wBlGdIDlc2pdtWhjKcMCIys0VP5ucq+US5yv
   5KGIsRuIj/3LSwep2rl0xxPjABAH/t8KN7k+Qk0ugzjAowzi2avUDAUqR
   OAvmmTD3iY0ZCgo3aIHydy83XukPnsQ65cjImituGReqcNV/mcbfuh0i2
   d1SQNQHCRhFDaKcsB1jNvr5xX9stSJNJw2rIUhAwUx16W7SvygQAVog4X
   g==;
X-CSE-ConnectionGUID: RzG+p8FaQTOA3ZguyftV6w==
X-CSE-MsgGUID: YWzGgIysTca//Y5fPyDe2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27239128"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27239128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:11:38 -0700
X-CSE-ConnectionGUID: dCRxYTWTQPmr2cwuOJTXSw==
X-CSE-MsgGUID: Y4t/FwCwS96BWPqFd1nVHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63698443"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:11:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:11:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:11:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:11:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cadyEHPMOc0aDEyBxYZCPfwpclisRLEXMsLDJiJSNmcN3pGlpjoo6rDdzwn+15RCR42gr0ZyagUk9nd+5fOuMCt4U00ccjYiYchi//DroyHeG4DnnYKHz9EcN+s2BWm/drfU4eO4ZkOsLNvcsKFy97dwBlid5ilLLs++28+GR6VLrxzobzVKznp0SH01sMEVrNQ3bXgn26edSC8rkzVSqmjkqjHRAM1uTsaN/v4mngE9L08c3YV2Q9BOtlbVo3xQsQAxddZU4U3YiV3P7IcDTRYiGFRSuHCQlgKmgUfKlDjv3To1A3QHZ5vEC4X0PMZN3iH37XDd5W1g7kWPT8hlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2FehY6Ka6/ISvThKN45/0CDhfdzsR+4UW1QQpYU4cs=;
 b=fDX2eIYUi55pYFUVKmYPMZKpjnHDseIU0pIijWACtB1XQHUF0/NgFqmjhjDcohRXC9MLoRog/5D44UVkLxu7Bnpsq4t/IXp7xlanc9ADzuBfwhzSJYAqAoZdFieQDiDf49oAjSU43D2f62q6zJ5f8fI6Vcp0cvc/FSqWhN0mEnLa+PS6S9OapczieGvjpYTGB4GjQ033QvHyyKyrqNXgaJGkkp4GQn9/ESHFKBVje9xeM3D35b9Ait+1dI/aLabnG8rzEB1tuRZXkVJodZb9sPE7m3wKy0TslxwQgjD1gXBJTp7DT+7BAxKlwVHmaWUnYMOJ+jfsauzxq/vKiaDQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 22:11:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:11:35 +0000
Message-ID: <c783be58-b983-45ab-b0ff-7deb38ee70b5@intel.com>
Date: Wed, 28 Aug 2024 15:11:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: alacritech: Switch to use dev_err_probe()
To: Yang Ruibin <11162571@vivo.com>, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <opensource.kernel@vivo.com>
References: <20240828122650.1324246-1-11162571@vivo.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240828122650.1324246-1-11162571@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 13230366-9c8b-4a5c-b243-08dcc7ae6192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE1QNHFiaVE2SURKQWtWM2xIOS9EVEJaQ0IyZjViWDE3emo4aWtSdEtUWStP?=
 =?utf-8?B?OWM3YVE3Nm5iZ0tNR2w2alRNWTBuaThrTEN0M3l0QzBKa2NWRkV6cGY2QmRt?=
 =?utf-8?B?eGpuNXdQWWhWNTNPVVpRRXhtTkc1dTFWKytRbm52S0dQOTZxbU1OUVhTWmFC?=
 =?utf-8?B?N3J2ek53cERxd0pBSlZ2U052NkRTT05QRnc1b1FSU0pFZnBlRnc2cTZUYjJU?=
 =?utf-8?B?a2lTc2p1TUFQdXRIM0RpL2pnN0dZdkNhbGJHSUNXU2hscWpnZEZJTjNPdmpm?=
 =?utf-8?B?UGZiVS9xOTl1Qm9NMmc0N2tMQ0ZJUElseHg1T2VKLzRaUmZwSWFwZG96STVP?=
 =?utf-8?B?aGoxaS85aitCYno1RlkrbXozQUsvdlQ2Z3hVQ0d5SFl3cjdWb2dQbjVrTmxs?=
 =?utf-8?B?ZGJrWitteEJYUFA3RFdyc1NOVmdFNENvWjl4RlFOQ1Y2QUgwY0FZSnB6aXhW?=
 =?utf-8?B?Nnhkd0JmZWptNGJkU0g2MFlDWnNmdVowYkFrc0hHTXhTM2tncDltYlYxZDdx?=
 =?utf-8?B?K2FiQ2c3eVBlaTh0eTRTYXl5Nk9HcTVYODUrbWM1U2dpQW5OTE9jVjZqTWJx?=
 =?utf-8?B?QndDS2RVT2tpbWtJZ1RRekpTS0ZUK21BU21mY2ZWRTBlSmZ5Q25jME1TOVRP?=
 =?utf-8?B?eThFNkNTTmxqWW82cFFsSzZuK1ZBdlpiVW1ndlppQk9RdlNaWWh3NDY3T1JJ?=
 =?utf-8?B?QUN0dVczWVFnazlwK3hlOHRPcnlkK3czaWlxQ3pLYTdUdm8rZjVTL3BoMWxD?=
 =?utf-8?B?ZDIzd2FmRVh4NlMzQVhxZll2OXJOeEVpbVlrY3FHTjlxV2QvL2s3TncwUmZC?=
 =?utf-8?B?bkpHKzNrR1NvTFNPWDc4emR2bjhES3oxSzZPbjIyaENxcktFSjZpR1pqS2dv?=
 =?utf-8?B?ai9jM1FsMVpOUFQxRTROQXNaKytGMzNSVllBUW9TTWp3TkpTUWtIUjdrK0d2?=
 =?utf-8?B?S2x6elJyaC9DYTBRS2hNNVcrc3BZM0tGOGVicWtKVlg0YTVHK3BtamxTaVl0?=
 =?utf-8?B?UkNLRFl5M01NM2pSai9GUy85aU9aTjJBQzV2QzFGZGlWTEN6V2lvNHV1TzZ6?=
 =?utf-8?B?QjY2dm03dmYycHBVMzlXbzJPb2ZrRVM1Z1NkWkNvcXRoQVduQkNFREsyRVVv?=
 =?utf-8?B?MlNXaFZhNFRGT2l6TVRhNklndzF4VnN1VGJ5U1VVSkYveDBIWCtrMDM4ZzQ3?=
 =?utf-8?B?RmJCTXpyYkFuTGZSR3haOTVySWEvZ01BV3dtTklrbHVhL2Y0aVJ0LzRqK3Bx?=
 =?utf-8?B?MXcxQ1RtNTc0NXUzcjVSR1Y1VUh4bTY4ZjZFVGhOVmdiUTc3bExHVXhxeWZH?=
 =?utf-8?B?UmR3Y3dvZTBrdGFLL1JsMHRWR3BuK0xvNGcwaU9uWXpEZ2hlK09uK043VW5i?=
 =?utf-8?B?YldRR3A1aXlneVdqRWZwZzVyb2NuRlllQjk2YjZocUV4NEc4TitxN29zRkFS?=
 =?utf-8?B?anZ6QXplaEhXNkJZRktRV09CQVZ3T1huNFl1bTRFU2VUYXZ5cHAwaC8zYXJx?=
 =?utf-8?B?WFk3QnE1ejhta2ZKeUNxc3hFVFFteWpiUDBoelRNSlQ2b2Z1UWNJMEJoUi9m?=
 =?utf-8?B?UHI5eDF1SHZ4SWFoNXF0aUxBNGF1YmRrNTdTTXdEeFAvdkVnY1gwZ3lZOXdm?=
 =?utf-8?B?YStHNEpkTytRNldPV3oyTzFzZmJBZkhBVW8wSHJocDF4QlV1VUxyaS85ZmVr?=
 =?utf-8?B?T1ZURncxUythS25nbU1Va2xzb0thRzA2SGIrV2ttOWtCTG0yK2Uvc1c0UldT?=
 =?utf-8?B?MjA0cFA5RVhqNHBSci9PN0xnek4vVUNsczhPdEN2V0xSbGFITk9sTDRWenNp?=
 =?utf-8?B?eTNxRFRkNEhoT3lRWmt2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5qUjl3THMzdTlQTGJZbkZZSUdjYUJEb05XZVl6MUlqc283VEU1UmUycHdy?=
 =?utf-8?B?K3NNb3pNdFRNVjhPV3drQ2tIZlFZcE5nQ3hha0FPRVFUT2Rpc1ZMemxIY0NC?=
 =?utf-8?B?SkpqdFJsL2FSSkluQVljOWxEcENDdHpCTDVnS2VDV09hVzd0UTEzZHhpWFgx?=
 =?utf-8?B?TUxrODN4VlZRc1FYcElnQThjZVB5Y3dRcGNMU1ZmdzZRVHY2SmN0WnpxY20v?=
 =?utf-8?B?NVZlL0FtYVpWalNZVFlCMGY5T2VrRGVmVG5ENVNZc2N6QW0xcDdVcTl6ZHgr?=
 =?utf-8?B?K2FIRUpBU0cxNjBxcjg0R2dZNWc1Mk8wbmM0NUhYU1R3aXlIcU15Z2NjZTdQ?=
 =?utf-8?B?WG93ZGtIaEN1SFlXUm5sams0ODdTQTM0bjVuUWl4ZEV1TmZnVWFNSDFFYTkv?=
 =?utf-8?B?TFdFKzZ3bzRrK3VMSS8wM2NjVFA5UnNzU2g1akd5VjBrV3N0aW1tdTZLaVBX?=
 =?utf-8?B?bnU0TXlmSDBVZk5SVXgxSk1DdUw0TjdNdXEwRG1pelEvMDg1dnRTSTVqT3Nn?=
 =?utf-8?B?TjhERThGTW1yTktPeHV4VVFZTm1ySWhCQ1A4NzRIUWxiNWRjSVF6a3ZnYWo4?=
 =?utf-8?B?Y0JNZGtjU21YekNHRW02aDBlOHlQUU5hK2IwNkRlcHo4d2kwcU00YzFQYzF5?=
 =?utf-8?B?c3Y3c0ZadGo0ZWJGWXFZaGVsSDRvMkxWT2x2M1ExYktnM0NBWGZON0tHdEpo?=
 =?utf-8?B?WEFqMVBuL1NtR1hmNHJpa2tCS29ueW5yT1IrYnlwK1ZPZjY4UDQxeXAxaFkx?=
 =?utf-8?B?VXBhZ0ZrTi9tb09BRkFVS015cWxuZjZnZXlqQ0RvcllNcG4yZHJqVFoxdE9K?=
 =?utf-8?B?ZkQyVllvN2hvb3ROajZCcHR3aEkxZit2SUM0WnY4bnhqaEMyS0NRbHEzMUpW?=
 =?utf-8?B?WW8yTmNrWVh4L2xxTWVWZHJjNUtIV0hHUzMyYVdTUmJqY3FGcHIvak5Va09p?=
 =?utf-8?B?WHI2UmtwN3hsVFBaMU5zakFXMklpTWtVZmRRWlFTbC8veDYvTlNkekdmZGI1?=
 =?utf-8?B?dElFNmFieE81UmFsTjZsZG5pdmNUMWdxaFFOUnJRM1RyMW5JV2I0TFdVNEtC?=
 =?utf-8?B?V09LQUwvcXZtT3pHZkFxa0hkZ0RJeGxoMG5PYzQvZ2xvTURtQWJCeENPS0k1?=
 =?utf-8?B?SzhUVVY2T205YVcwMVRTUDhVZXZ2SDJLWi9BZGNRQjJFaVZXMnVseE52Vjg4?=
 =?utf-8?B?bUZxUnQ5anJBREc0Z2ZMaVltai9zajBTSTR2eWFUcGswaVI3REh4TDd4U056?=
 =?utf-8?B?dTZ3V0pqNC92S2tpTkQxcTZZcGdqTi9KVGFTNWhVTytCOTI0K3Q5d3QreUh5?=
 =?utf-8?B?OGJOZXIrKzVqMzRCY3hMS0lRMVI5clptQ2RDcFZSS3NQbXNMZDh0b2NJbUJa?=
 =?utf-8?B?aXRMSUVyd0duekJhZHJLQzMwaGxiaXVRSDNyT2h0Vk5WRWhiNy8yU1FjQjM5?=
 =?utf-8?B?SnM1cTdaUTlnZktveGx2THpxVVZ2ZE9RMU1zY21rcjlXbXh5eldjTHE5ejZY?=
 =?utf-8?B?SWloZ0M0cHhwcGs3Wm9tUnFIME05Ynl0aUJTWm9UeXZvOUZZVXZXK21hUmhC?=
 =?utf-8?B?Q1RhN0RHWUdDb1pjTTNtOFdjUnEyb2FEV0ZtOW82M1JzS2FvWDR0SldldmxV?=
 =?utf-8?B?d0pSUlB2QStUMVlOdmZ0QTloQVNOMStCbzV0THlyYmRzRjlxbmFuUWRxSmpQ?=
 =?utf-8?B?N0hDWXgxa1BMaTZPcXExdFFzQW9ubkJUZWRRaHdRZ1dnODF5b3htRTlPcVps?=
 =?utf-8?B?NTZPWVpuamtBNzFpTmlhSVlTVThzU2MyVFZyVFZLRFFXeER6ZVVVb0plRS9u?=
 =?utf-8?B?MkdRbTkrMzZwcDdFQ3I2eU0rTndPRm9WTWMxSUYvRTJPbUl3dXhxbnRsTHdL?=
 =?utf-8?B?cU1jM2Jqbm01UnZlNjcvZ1I2ZmE5dkIrdEV5Q2lDbW4rTDFKQjY3V1NlVi9V?=
 =?utf-8?B?TWgycVBISFlwb2dsVkdsSlBoclA2eDZDM3MrTVRNc3BXK1pvanBsYjU3cEhk?=
 =?utf-8?B?bTJqTzVBVFk5TUFyWTBkeTUrSUdxUVl2ck9FUU5SZzdVV3lteUVNRzlkaTRT?=
 =?utf-8?B?MHVnSkM0VHhaYkhaT2tra1UzQTlNckhTRTNsU3RaV2lLSU5za1RFNmhJNVZy?=
 =?utf-8?B?VU01N0l3SE41M1VQa2hwZXREeHgrRXVVYkVJWkROKy9KTk5IdlFNMHBWYldP?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13230366-9c8b-4a5c-b243-08dcc7ae6192
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:11:35.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTK+a18yUX4U0eyydek6hluX+50vZZ0JOvqRQDHcPm2C0dLLSR+F1D3W7kPSTlEbqVQ5dmJo0L1J2tzFhXvdeQ7L0QTR8CwG5c/63sb0dqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
X-OriginatorOrg: intel.com


nit: subject should include "net-next" for changes like this which are
cleanups meant for the net-next tree.

On 8/28/2024 5:26 AM, Yang Ruibin wrote:x
> use dev_err_probe() instead of dev_err() to simplify the error path and
> standardize the format of the error code.
> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 34 ++++++++++-------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
> index 78231c852..65919ace0 100644
> --- a/drivers/net/ethernet/alacritech/slicoss.c
> +++ b/drivers/net/ethernet/alacritech/slicoss.c
> @@ -1051,11 +1051,9 @@ static int slic_load_rcvseq_firmware(struct slic_device *sdev)
>  	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_RCV_FIRMWARE_OASIS :
>  						    SLIC_RCV_FIRMWARE_MOJAVE;
>  	err = request_firmware(&fw, file, &sdev->pdev->dev);
> -	if (err) {
> -		dev_err(&sdev->pdev->dev,
> +	if (err)
> +		return dev_err_probe(&sdev->pdev->dev, err,
>  			"failed to load receive sequencer firmware %s\n", file);

Nice. dev_err_probe also handles some specific behavior for
-EPROBE_DEFER, which isn't being used here. That's fine since the custom
logic only triggers specifically on -EPROBE_DEFER. It also has custom
handling to avoid logging an error message on -ENOMEM. Neat.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

