Return-Path: <netdev+bounces-120227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844889589D6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DAD1F23494
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB2191F6A;
	Tue, 20 Aug 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbpKM+ht"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCD1BD512;
	Tue, 20 Aug 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164600; cv=fail; b=MK5rbtTzBGTmotNGPd87NWy9b6+piTAoNoLE3wtcBgOoXdXXXXHBc05MzDnCfLR0U91RIFnKw0vbp13dmykAh46CXfWlY2C98ndR9q6tYrXUzLZy/3I4PooWz+gCo8V4Owfqgqz/U6mXABtj7Sv28DGISPpjebZjRBRjYd3d8tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164600; c=relaxed/simple;
	bh=FFqOsyXp1IpmS/xMB4wHRtVe10DW/nZeilHQrDeaftc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hz+oQuwnBWPqOBKTpQvaWblalaMZmXIILDQtsHTh09aV1NzJI+TIw3Z5oDoPVxgCqz46tNdT8fwlpjkt/sg7dFnVIFSoJMCHxhEsDMF+gOygjRRoZYdrf4mhlRef/urkqs9ziGl8RcOcyRpS22uP9sWJssax0oU4/aU+TAi52rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbpKM+ht; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724164599; x=1755700599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FFqOsyXp1IpmS/xMB4wHRtVe10DW/nZeilHQrDeaftc=;
  b=KbpKM+ht3fS+QvOgY9azWQ9llalI+qZBgRw6UBFmyh4t56k6Av7EMYxq
   LO5KxmKNbUIzZTU+2Xdrrne+D7Zs2r88lfapDNXTpnS97LrdNbaoMxjbA
   t24Ps6LL7zd3DkguMTEyhXacNuRxkrN5ETKYdE3RXxG25JqU5xGQHuuD6
   2WGO0FW6cUhWFEPSy2T9YwCpIm7/nx+ZnfhOIajEB9JxdMae7hgJEF1hp
   plGraLF5H4p4X1t93DOLvsO8sbkBwbiO4VMTC0cZYlXUcY00nyZ2J6iyk
   PD5/5sRPW9Pi2lzrArhSFs7E4Kk84aNWY+BUT+xBgUf7O6U8CJTEuHOkz
   A==;
X-CSE-ConnectionGUID: b0KB4+2QQwCNXwX58ONNKQ==
X-CSE-MsgGUID: sQ/wlLDaSl6jOefwsjfqcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33886374"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33886374"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 07:36:38 -0700
X-CSE-ConnectionGUID: za9xUFtZTW+702BivASdUg==
X-CSE-MsgGUID: c6MOAK7hSeOdIlcZ3SwpTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65430289"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 07:36:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 07:36:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 07:36:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 07:36:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 07:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed4kcIrxyoIek+xd0juhFEZm0gt+UZa7/nnMLAg2s0HLHkp06BvVwHapuaHfkR6RlSFQQZieeQSVa/2p0cTWom9PcxbrhsDbvkNL5wJLV/3Nmztq21RQFf+A8TM55jH0nfQmTeqAPC95XSghjYrkb+1u4vNxcnqVpMyGkY4v2EafnF1iEUvwIrlp3FZ5nfe9GAE/0WMN2DZAg4MutKCGTpPHRaDpEDOnV47Bj5WFtfIx3Po54UT7yj77YrmCjHm12sTPjmzCuX9xifmhgXujcCSu+p0nS21lDpM2vroyX31CaEr5+KKSRaNitNitOsTC/VvUBNevwvLFHrTubZDhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JR9SNGnUOC3zYnyjaaTWUVRPIDY9UQ9bOBuYMy3Vfc=;
 b=knGgpVbFxFNqB7T5skURzCcNoaHDFXnC/0sk4RyqVuzqGuwp27ao6KjtJcI/SbGN1apqr2dphQTjkrEFTL1WjTWfzxSBLRMa6lvXUVEWuFu2ZX/Jl1g/59Up3vthAP0a1Cafft7byrvmDhK5XRWmM2xkCvvxYOkkYp/BkBQvWO1T1S5donBazoMB7dEk2x+D9kigHxopAdKmAI0ZH39yeIGmAziv36GaTWJeqEevPZaNWS9tYbQ49yI4VbzfmCFqtSqbmc5E2k0U0sD4Pu8D5Oy1FUBPQzGTFRREMaytwzpjhd2z/vBcuCOOURKU5+bIur6hFKMuLgMvMtMsx6a4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:36:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:36:33 +0000
Message-ID: <29ccab1d-cf8b-4a5d-8d9a-54535925f71b@intel.com>
Date: Tue, 20 Aug 2024 16:36:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification
 process
To: Furong Xu <0x1207@gmail.com>
CC: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xfr@outlook.com>
References: <cover.1724145786.git.0x1207@gmail.com>
 <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: e40d63fb-c27e-4f31-7aeb-08dcc1257d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2kvNmJ5eTZsRzZYWExmampkRWE0OTNUSWVmNW53UnNBMXorclhuS3p0MnY4?=
 =?utf-8?B?aGpZeVprbFpwMVVUSHBINTFHK1hRTzVybHBJSzFSZVdISSt5NmRORlRJdFg0?=
 =?utf-8?B?QjZZSWUwRVpUQzdjMjJoci9FQmRaU3FLWTI4bnZTcXB1RUZ3N0dZZkRSaldQ?=
 =?utf-8?B?TUhsOW01UGhiYjVaN1QySlUyMlpoQ0cyUGZFSVVkUmVHSE5UVVAzSkVwcVZw?=
 =?utf-8?B?L1RETHBDNzJ0RkR5bXdxUXRsZUo2YXcxZjAyK1RBN2I4bjhodk1sYWRIVEsy?=
 =?utf-8?B?U0k0ckF4YjQrZFhCanQxZTRITGJwZHZSSWZLLzR6TlB0VmtOS3ZqL1phNE9n?=
 =?utf-8?B?SlNlOUdIemE1ekNTekdLNEF4Q1gyd1Qza3FiaUpwb04yakx6SExEL0ZsdXh3?=
 =?utf-8?B?OWxGU3gyTGwyTHhLUkt4WDc1QmtUK1BjTlJlK1RybGZNNG5KbXZVQ1JtNU1L?=
 =?utf-8?B?NVM0eDVlNkJkMDdIeno5MzBDcHhvWDhqd1IzRThpcFJLSHl1ZlArc0tNVmFV?=
 =?utf-8?B?bUt3MTRsNlE5amo5WkNhSHZva2hXbUVpRzNaWnhuU2xQOHMvcE1HeDl0ZU96?=
 =?utf-8?B?eGNkR1JONGVwblNWYlpocWJMZVZQZ2NoN1haRmozQWpNSEUyV25EN2NkZWJZ?=
 =?utf-8?B?SHRZMlE4a29tTENvRis4Y0VBbnlkMTgza0ZRZnoyaEdOalorL1p2TTF6UlFu?=
 =?utf-8?B?ZzQweTJTNmVFeW9kM1Q2SWRoZGdjcWVvbHhyVDJnTS9Bbm5RRnBoeDRSTE51?=
 =?utf-8?B?QXp3ejFLWnR2YnB5bE1qeEJteFJXRDdVcTZjUDBXOUpueFdVcU9TVEFjcnlx?=
 =?utf-8?B?V1pETUFYbytNL2h4S29VMjdIbFdmNFN4OThsdFY2VVBiTkw2YmtlVXpyTVE5?=
 =?utf-8?B?NXEzdE10YURjeVptYXR1b09yQ3RkdmoyT0tQVkN3Z0kxUGt1M3lMRUZjMEVN?=
 =?utf-8?B?NjI5ZnRXOERHVlpDNXoyUGZHSng3a1orcVg3QUNUUmFPdmhxMDlMWWJ3WHpq?=
 =?utf-8?B?SjhXWjZlZ1JubUM5TFR3bkxZZ2x5Y0loeWR1ZWRhZk9KVVlwSVJCNkw1UDhK?=
 =?utf-8?B?TnRGRkNoSEo4d3NBWXllblVYbktjaWRYOE80dWFqamtRcnVZdzhPUkd4LzJz?=
 =?utf-8?B?TjVhVVpzeHpqRFZhckRuRDNyclVoTGJuTU4rQndiaHJUc3VBZW9wT01aM1lo?=
 =?utf-8?B?RjFFTXRwK0dWQWpXbWxSSjZKT21ja1hDK0ZOQ1dmTFBPd01sd2VlUjRvZ1Nk?=
 =?utf-8?B?ckRpeVFwZVZwRjZIeDB5SUNsOUpZTzZBT3pBZll0WVBSaHlYUS9FblBUcU93?=
 =?utf-8?B?VHdCeXkwTC9Rd0daR3hUWlFaY2dmYkhFY0hEcHdTeDhVSncva2hCZDRDV1pv?=
 =?utf-8?B?MTVFT2d6TXdqK3hqNjVrblNyM1FLT3puK1liUXZncGloUVZlMFFHQnB5dThq?=
 =?utf-8?B?WXlwd2NrV3FaTTlZVWJmN3J6d09MTC9VYjlSYzFXUFpMTlRqZ3BITGlsRG9S?=
 =?utf-8?B?dWpnMnA5S0MwMFN0OHVMb2NROXkrbU81MHo2WUdkdkJmRzJjSW1sY1NoWDNz?=
 =?utf-8?B?NlptSkNiaHNQQzdGUWFnOWZWMy8rZVJONi91M2NEMk81WnlMWDRNdEFjcWRi?=
 =?utf-8?B?Z1VDbUZ6M2ZNSW04WFdJNjY5Y0gxbnBZbXRHc3dKYXpIc2J2SHBhNndHam5l?=
 =?utf-8?B?Vi80ejVpeXNLM2tYOUVpcmw0aTZWOTU0cE4ySnF5NWMxc1dRK3J6c1kyZXVE?=
 =?utf-8?B?S1h3eDRDeFArQ1RvMG5QMm5VTTFHU2pMUXRaaGc3V2poUS9VbGtiNmJCWC9n?=
 =?utf-8?B?V0FHZmc0YkZPQ1ZYMTU4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndkYmM4VHdrM05raldpYlNpQlI3Ujk0S2MvWEZ4WDZxSzBUeVV3NGdFaDMw?=
 =?utf-8?B?WFNqRHdXWnJDY2dqQ2lHdVBhZTk5T09QWGNNK0tSRlBWNjRmOXhoVmJvWTQ3?=
 =?utf-8?B?Q2NGeDRIV25ESUpoOFpaRWZsc2lPaVdHQTNRa1RIRkRxYjUxRUVMcEl2M1pz?=
 =?utf-8?B?TTFkWHRUWkVMUEljRFRtQTlKY0c2YVlsK3BOTm5ISCtUWnBtaDVUVTgzQWk5?=
 =?utf-8?B?bVIreDBlYUdGN2hvRFdxZEN3eVFRRE9VV1BKT01ZcGY5b0w5ZXhldmZTUGxW?=
 =?utf-8?B?UVg4Mk8rMXVSTE1WWlRVczJHK2JWMDMxRXh2ZGxwYzR6QjRzMlcra2FKdWpG?=
 =?utf-8?B?TWZndlVaNVNQbUVDWWpzazlVU0xYUDkweGZuMDA0UHFqZ2hVK21obmthZGJh?=
 =?utf-8?B?ejF1VXFSVVV4a05aNnNHYnNjY3JsL3ZjUWFaZ3RSdnBGenJtNGh6VjJFY0Y1?=
 =?utf-8?B?SFpGeWxVS0V3N01sU2JLVERObGc3ZDg1SXpGNnVoanJaUk5jU0FoSDhlcVBB?=
 =?utf-8?B?OGhnOVJDYk0rdGVBZDNiZmJtR2xmTU5tUzNKN0pZbmRsYkk5a0hJdnZ6VXJM?=
 =?utf-8?B?N1p0dElSNE9Ld2g0b2N2WmdhOEdCb3AxMGxYcTFXSFFHM2V2Wmp4TVpoR2Rt?=
 =?utf-8?B?dXFYdmNtdTNsV0JjZmI2clVLS0hyKzhhMGNLSDJCdlNRYmFsRm5UMVdYenlw?=
 =?utf-8?B?NG92c3h4RlBMdnV1ZUZrdGdodVZxMzFmaExMckJLOTFWMlJpRTZNUXYyWDR4?=
 =?utf-8?B?cUorWk1MT1VlcHFBUGExaFc5VlhHUER0ODZ2SGltbTFrUjdERGhtQ1BGS0FS?=
 =?utf-8?B?R0lkaDZqRy9qdlkrWi9xODBFT1JxeC9jUTRXdTRvbm1ObDlteFB5RFQvSWRQ?=
 =?utf-8?B?OXVIdzQ5UjdlbEltS3I1bDVCTmFBamUzK1VrT2JGdlY0UWJLZmlVOEdQd3BZ?=
 =?utf-8?B?cGg1VHpEL0hEQlU0aWtJR2RtNnFQUDc0MVVBTEhTMElSbmZaUFlBWjBWVjI0?=
 =?utf-8?B?QW5pWUJTdmk5amhFVldsYThNMmhld3RGWVB2ME9lc2ZySGpuNjFlN0RWTVY3?=
 =?utf-8?B?Ly81QVVXdGNUK2RlamNwdkRWcysySi9INEcxTUs4ZDFodUEwem1Qbmxuc0F5?=
 =?utf-8?B?THpsRENxTm5RYmhrTUw5S1RhZTFBYXRtaktyZjB0MTYyY29xM1JZcmVSd0dk?=
 =?utf-8?B?dFNBeGRYenVsejk4a2x5UXRURjlIOE5mQkVqcWZaMVFzRnpyd0h5M1JNRWlX?=
 =?utf-8?B?TEdpY3VLQTVqWTlqZERXc2RDV3RSczBXcXk3VUZWc0dIUjhMUDArNFF3UHFm?=
 =?utf-8?B?d3lOdmNLT21EeXFiNE5qeVhXd3BxQkYyd3NNblNxWG5jZzdEQ1BBbTYvT2kv?=
 =?utf-8?B?ZEVWTjVvUFRJekQrSnRlYWtKcHBCUElHek5aUWFKOE9VUU1Lellja09abk9U?=
 =?utf-8?B?N2V3WU5YYTlDMTkrUVJkK0NRTW9GVHJvL3lvc3NEQThtY3dzSVZybHErTEhH?=
 =?utf-8?B?aUMvNWtFQjZyRTM5Q05veFNUZm9qdlZVcTJyMmlOWmV0SVJqUFlDbUtjSENz?=
 =?utf-8?B?d2Vaa2xHUG1VZXBRaVhQZEFuaFhsbVU1Vk5Yck55emkzK3BleHk5MUF6dDNS?=
 =?utf-8?B?aWhodVZmZEgvRm1KM0N1WHhzSXE5OHhpemtYcm5EU2VhbHJRWVd0NjJUeW4z?=
 =?utf-8?B?Qjllcmwwb3U0b0lyVDBHSmRJT2FVOGZrK281WXBibEtUWWpvU1ozTzBUM09U?=
 =?utf-8?B?eitMV0tXaVdvMXNRRUpSY2NDUnljalprWGtaOE8vckc0cVJNQ0hhTWJ1TWR6?=
 =?utf-8?B?OW5yaks2eW9oM2s2MHI4OGNmeE5ZemZLZVI2RHA1Y0FwNW0zWUZCaWhJS3VD?=
 =?utf-8?B?aW9EeEQ0TXJjNnRTK2l4dVZhZCtyaWtIeGxVRWhkR3puT1lNZk9BaVJvQjJK?=
 =?utf-8?B?a1lMWWplQkVTWUJLSytnMWFuNnV5QXhEazJ1eHlHSXpSN2xuN1IvWWxEL01O?=
 =?utf-8?B?aFBrWlZZdnErM1F4Q3RxeFQ5Uk9nY1pLWVNaVnlTT2NVRmlONDJSYmJBd25Z?=
 =?utf-8?B?eTJxNDA1QUU4b2N6bTdETjQycFpFU05vblBJOFluTEpsTWc5aGV5YWZSMEdR?=
 =?utf-8?B?bGNKRjlYbVcrUWpjNUNZczA2MHNGRzJMMDZOYXNJaTNHZmIyVjFmOERXS25U?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d63fb-c27e-4f31-7aeb-08dcc1257d15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:36:33.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpBTvGZfD5lMNUBbGZmIfxrVR2fbihYnMxmNz0RBs5R+nr3gEclAJT6c37z6CbpPDRxYhlLV7qyZ/LRRdn4z5LrtZUCfu90jp3MJ4iAcf50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Tue, 20 Aug 2024 17:38:31 +0800

> Drop driver defined stmmac_fpe_state, and switch to common
> ethtool_mm_verify_status for local TX verification status.
> 
> Local side and remote side verification processes are completely
> independent. There is no reason at all to keep a local state and
> a remote state.
> 
> Add a spinlock to avoid races among ISR, workqueue, link update
> and register configuration.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  21 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 172 ++++++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   6 -
>  3 files changed, 102 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 458d6b16ce21..407b59f2783f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -146,14 +146,6 @@ struct stmmac_channel {
>  	u32 index;
>  };
>  
> -/* FPE link state */
> -enum stmmac_fpe_state {
> -	FPE_STATE_OFF = 0,
> -	FPE_STATE_CAPABLE = 1,
> -	FPE_STATE_ENTERING_ON = 2,
> -	FPE_STATE_ON = 3,
> -};
> -
>  /* FPE link-partner hand-shaking mPacket type */
>  enum stmmac_mpacket_type {
>  	MPACKET_VERIFY = 0,
> @@ -166,11 +158,16 @@ enum stmmac_fpe_task_state_t {
>  };
>  
>  struct stmmac_fpe_cfg {
> -	bool enable;				/* FPE enable */
> -	bool hs_enable;				/* FPE handshake enable */
> -	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> -	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates.
> +	 */
> +	spinlock_t lock;
> +
>  	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> +	u32 verify_time;			/* see ethtool_mm_state */
> +	bool pmac_enabled;			/* see ethtool_mm_state */
> +	bool verify_enabled;			/* see ethtool_mm_state */
> +	enum ethtool_mm_verify_status status;

Why not embed &ethtool_mm_state here then?

>  };
>  
>  struct stmmac_tc_entry {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3072ad33b105..6ae95f20b24f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -969,17 +969,21 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
> +
> +	if (!fpe_cfg->pmac_enabled)
> +		goto __unlock_out;
>  
> -	if (is_up && *hs_enable) {
> +	if (is_up && fpe_cfg->verify_enabled)
>  		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
>  					MPACKET_VERIFY);
> -	} else {
> -		*lo_state = FPE_STATE_OFF;
> -		*lp_state = FPE_STATE_OFF;
> -	}
> +	else
> +		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +
> +__unlock_out:

Why underscores?

> +	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
>  }
>  
>  static void stmmac_mac_link_down(struct phylink_config *config,
> @@ -4091,11 +4095,25 @@ static int stmmac_release(struct net_device *dev)
>  
>  	stmmac_release_ptp(priv);
>  
> -	pm_runtime_put(priv->device);
> -
> -	if (priv->dma_cap.fpesel)
> +	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_stop_wq(priv);
>  
> +		/* stmmac_ethtool_ops.begin() guarantees that all ethtool
> +		 * requests to fail with EBUSY when !netif_running()
> +		 *
> +		 * Prepare some params here, then fpe_cfg can keep consistent
> +		 * with the register states after a SW reset by __stmmac_open().
> +		 */
> +		priv->fpe_cfg.pmac_enabled = false;
> +		priv->fpe_cfg.verify_enabled = false;
> +		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +
> +		/* Reset MAC_FPE_CTRL_STS reg cache */
> +		priv->fpe_cfg.fpe_csr = 0;
> +	}
> +
> +	pm_runtime_put(priv->device);
> +
>  	return 0;
>  }
>  
> @@ -5979,44 +5997,34 @@ static int stmmac_set_features(struct net_device *netdev,
>  static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
>  
> -	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
> -		return;
> +	spin_lock(&priv->fpe_cfg.lock);

Is this ISR, so that you used the non-IRQ-safe variant?

>  
> -	/* If LP has sent verify mPacket, LP is FPE capable */
> -	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
> -		if (*lp_state < FPE_STATE_CAPABLE)
> -			*lp_state = FPE_STATE_CAPABLE;
> +	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
> +		goto __unlock_out;

[...]

> -#define SEND_VERIFY_MPAKCET_FMT "Send Verify mPacket lo_state=%d lp_state=%d\n"
> -static void stmmac_fpe_lp_task(struct work_struct *work)
> +static void stmmac_fpe_verify_task(struct work_struct *work)
>  {
>  	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
>  						fpe_task);
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> -	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
> -	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
> -	bool *hs_enable = &fpe_cfg->hs_enable;
> -	bool *enable = &fpe_cfg->enable;
> -	int retries = 20;
> -
> -	while (retries-- > 0) {
> -		/* Bail out immediately if FPE handshake is OFF */
> -		if (*lo_state == FPE_STATE_OFF || !*hs_enable)
> +	int verify_limit = 3; /* defined by 802.3 */

If it's a generic/IEEE definition, then either put it somewhere in the
generic headers or at least make a definition from it, doesn't open-code
directly.

> +	unsigned long flags;
> +	u32 sleep_ms;
> +
> +	spin_lock(&priv->fpe_cfg.lock);
> +	sleep_ms = fpe_cfg->verify_time;
> +	spin_unlock(&priv->fpe_cfg.lock);
> +
> +	while (1) {
> +		/* The initial VERIFY was triggered by linkup event or
> +		 * stmmac_set_mm(), sleep then check MM_VERIFY_STATUS.
> +		 */
> +		msleep(sleep_ms);
> +
> +		if (!netif_running(priv->dev))
>  			break;
>  
> -		if (*lo_state == FPE_STATE_ENTERING_ON &&
> -		    *lp_state == FPE_STATE_ENTERING_ON) {
> -			stmmac_fpe_configure(priv, priv->ioaddr,
> -					     fpe_cfg,
> -					     priv->plat->tx_queues_to_use,
> -					     priv->plat->rx_queues_to_use,
> -					     *enable);
> +		spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
>  
> -			netdev_info(priv->dev, "configured FPE\n");
> +		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
> +		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
> +			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
> +			break;
> +		}
>  
> -			*lo_state = FPE_STATE_ON;
> -			*lp_state = FPE_STATE_ON;
> -			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
> +		if (verify_limit == 0) {
> +			fpe_cfg->verify_enabled = false;
> +			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> +					     priv->plat->tx_queues_to_use,
> +					     priv->plat->rx_queues_to_use,
> +					     false);
> +			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
>  			break;
>  		}
>  
> -		if ((*lo_state == FPE_STATE_CAPABLE ||
> -		     *lo_state == FPE_STATE_ENTERING_ON) &&
> -		     *lp_state != FPE_STATE_ON) {
> -			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> -				    *lo_state, *lp_state);
> -			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						fpe_cfg,
> +		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
> +			stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
>  						MPACKET_VERIFY);
> -		}
> -		/* Sleep then retry */
> -		msleep(500);
> +
> +		sleep_ms = fpe_cfg->verify_time;
> +
> +		spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
> +
> +		verify_limit--;

Are these 3 empty newlines needed? I'd remove at least some of them.

>  	}
>  
>  	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
> @@ -7535,8 +7550,8 @@ int stmmac_dvr_probe(struct device *device,
>  
>  	INIT_WORK(&priv->service_task, stmmac_service_task);
>  
> -	/* Initialize Link Partner FPE workqueue */
> -	INIT_WORK(&priv->fpe_task, stmmac_fpe_lp_task);
> +	/* Initialize FPE verify workqueue */
> +	INIT_WORK(&priv->fpe_task, stmmac_fpe_verify_task);
>  
>  	/* Override with kernel parameters if supplied XXX CRS XXX
>  	 * this needs to have multiple instances
> @@ -7702,6 +7717,12 @@ int stmmac_dvr_probe(struct device *device,
>  
>  	mutex_init(&priv->lock);
>  
> +	spin_lock_init(&priv->fpe_cfg.lock);
> +	priv->fpe_cfg.pmac_enabled = false;

I think it's kzalloc()'d? If so, why initialize booleans to false?

> +	priv->fpe_cfg.verify_time = 128; /* ethtool_mm_state.max_verify_time */

Same as verify_limit above, make it a definition, don't open-code.

> +	priv->fpe_cfg.verify_enabled = false;
> +	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +
>  	/* If a specific clk_csr value is passed from the platform
>  	 * this means that the CSR Clock Range selection cannot be
>  	 * changed at run-time and it is fixed. Viceversa the driver'll try to
> @@ -7875,15 +7896,8 @@ int stmmac_suspend(struct device *dev)
>  	}
>  	rtnl_unlock();
>  
> -	if (priv->dma_cap.fpesel) {
> -		/* Disable FPE */
> -		stmmac_fpe_configure(priv, priv->ioaddr,
> -				     &priv->fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> -				     priv->plat->rx_queues_to_use, false);
> -
> +	if (priv->dma_cap.fpesel)
>  		stmmac_fpe_stop_wq(priv);
> -	}
>  
>  	priv->speed = SPEED_UNKNOWN;
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index b0cc45331ff7..783829a6479c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1063,11 +1063,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Actual FPE register configuration will be done after FPE handshake
> -	 * is success.
> -	 */
> -	priv->fpe_cfg.enable = fpe;
> -
>  	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
> @@ -1094,7 +1089,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
> -	priv->fpe_cfg.enable = false;
>  	stmmac_fpe_configure(priv, priv->ioaddr,
>  			     &priv->fpe_cfg,
>  			     priv->plat->tx_queues_to_use,

Thanks,
Olek

