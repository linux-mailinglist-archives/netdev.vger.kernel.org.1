Return-Path: <netdev+bounces-258122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JxJLUFfi2msUAAAu9opvQ
	(envelope-from <netdev+bounces-258122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:39:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C043811D59F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92C6530008AB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806930CD80;
	Tue, 10 Feb 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5PP+npL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DB30B529
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741521; cv=fail; b=jjKnCy//b6s+kj3bL5drYfA3rdJ3lsMi1cLY1V2Ze0LiAXekZg9DehrBLaL6wt+IiIiF6CXQzLL2y+llBSy5MjxKHGVrfo40WoSz1qsiEAbppfpH2T5RQHQa76yf+nu51OnoYaqrjQH4cn2pvo0hQnaqg9G+W/vuTNShvEVE78Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741521; c=relaxed/simple;
	bh=Cb6vPV8Tao+dEvEDgbq/Abil7MPj26Kf3u/0YfFuO7Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mvKmzQ3Wmlj6KuxNuaD0URLFduhhh0hxwiRZdAURg+CrGfPRrL/4jCtS+SOPDZd8gQ4njMt8Ncu100+ZTdR3Mzoy/pkEAjOgWPWluh8pAE/VadvAp+PUI++r07c27Bw6P1tdVL5I/gmut1NCABEB44BGD8t+1261FWAM4hSVEDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5PP+npL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770741521; x=1802277521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cb6vPV8Tao+dEvEDgbq/Abil7MPj26Kf3u/0YfFuO7Q=;
  b=P5PP+npLrsjgAAN1IEJNk8wRTyH3GMef+lvruaadFeU+3qanZ63bIVuo
   Qi+Iqs4ro3Y/32srUApWptJDLSKtSHW+Rqso1PagVbpEMFTXXWz2Qts08
   XbHTXeeemxkHdEkZ+nh1C3sPPYhyYhk/tUKcsXTA6awuVbb+2BHjLmEK5
   jWu5L6/iNwJ9rtw38C6avpHzf7bsXm4P4VrsMWfgtVFXd9E6hnYii91CT
   NdzHsgzZ16482KpI+Nt4Uu/yPWuNDS6S1QLGsDflSMPSe5qrVsH5TAO+f
   BBQCMl2Jb/IFCHBz+tiDjNQlqQyefyq6ixzKkYRjQdXtGuZ4O3ox0GMRL
   A==;
X-CSE-ConnectionGUID: 0aLrVL42SNeSBEK3MYDYSQ==
X-CSE-MsgGUID: V3R3o8LTR1aBxnxpo6pULg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83314134"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83314134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:38:40 -0800
X-CSE-ConnectionGUID: 3NRv1UE9QV2QXQ99C6TTMw==
X-CSE-MsgGUID: /jGH0BeLSqiXIEVaj/gj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="234944190"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 08:38:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:38:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 08:38:39 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 08:38:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhYDNV1BA9lsPnFDgNxYCRAyxKYaTL+bWc7qqPZ6YivJxyjsG67VR/DWkBHY/qOmFPfOm/b3dJi6pHDBPBK/QzmHcsGMnDf4aD+KCyup0LvT9g5oqAxr2LPKhw5LfzYv6YTnE8t8DjIrb+GIJXXdfmxHZvwBKeRlEUSJrM6mE8A+5nhiFR17mVLSzHz1J6XxMEVxlLRFikRg92XHyi3UrgdOlXNRTXaGYKT+k/L/LGQ8J4U0H3ohiG7UQHfHOix7QcsuvKnGB02122WCGos6Pk8HzOqG9nSifcmBFvEL70QVTHbbnN+Q7DIvJ1j1OoshYLAiBpFgD/9NHXwpf/UVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZLirmOUAitYno7Xh9RTzUcTf9PcWHXMkHb5zuYr07o=;
 b=ufy5SZKpKeeqv5KJqbpuZJu3jL9Io+uc77pu8/DHYmtnJrQgQIaby6yL2ty9UxtK91no4+quAx7rQKGRdFAK5TP/9fPUXq8i8CFbwUZZSBTGJfaXWgvsqABGqSeG4tRuV29KzDhYuz+i38Vz7sMW7PFq9ZwLWnaDxnhJ9UGbc+37VbuYnzNF2wwdmvOT4UaEM8mXlEMqb7Ht/XMAWCv9YTIW3fT695yFP5C3AG/yWOQk+yygjKpsit9QBn3yREVbX0c2VaLXfMebwBph6htqvJJbyMuMqL//sELPq53NTL3eDFS9bI5Ut4EMddn0x6t41XwWL7mBuaXy6dpOZtQ3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 16:38:32 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::b10:6045:9014:a81c%2]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 16:38:32 +0000
Message-ID: <c48f08ad-b402-4cfe-a362-4cb0c3a7801f@intel.com>
Date: Tue, 10 Feb 2026 17:37:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 iwl-net] iavf: fix netdev->max_mtu to respect actual
 hardware limit
To: Kohei Enju <kohei@enjuk.jp>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <kohei.enju@gmail.com>
References: <20260210155810.135577-1-kohei@enjuk.jp>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260210155810.135577-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dd673c-cc70-4e15-85ea-08de68c2d407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uy9UNk94S3RUWmhRSDc1aUtGUDhUVDAxWkI4OEZ2WFRtNzFvTXEvZytTWHdu?=
 =?utf-8?B?NU9USzdQRmVpRDBKQVFlSVNxSi9tSUFiei9NN1RVclE2TXJCaTh4NVhTYzcv?=
 =?utf-8?B?TjF0QTVvQmRKWGYyb0s4V0V4QWFpNmd4cDVBcEIyTmQ5TkMvVzlDcGNpZTht?=
 =?utf-8?B?enBhTmxzK2xMdnFXYmZWd21QYnNSS1R3RnBmK2hGejJaSXhxRDUzTU9UY1dq?=
 =?utf-8?B?TyszQk52bmgwam9NcjM0aGpDOCs5S0tEZ2tEa204V0l6SjdYZGJnL1g3L1RI?=
 =?utf-8?B?VG9Pc1pCa0dzbEFFdEZLVnJSVXlLUHVxMTNrWllWaU5pYml3anhRdU5FUUcy?=
 =?utf-8?B?c2c0SGJWN1Z2K0dFdnBrbTBQZGg0T3RwQ3dSTDV3eTNVQjZrTytocDgrWU5p?=
 =?utf-8?B?dmZveFV2aWNjV2J0RThRYkdFd044UWRXbzREM3h2ekMxVG93QVp1aGZRYWMx?=
 =?utf-8?B?NU9DMlVXSHNURjZiQmsyMDQvSzhxT21wditnSmgxZ0d2eXpERk8xQlIrcEYv?=
 =?utf-8?B?ZjIxOWpkdUtmM05hanFTdVBaYXhweTFnZTZKc1hDWmpnRjhUQU9DV0xuR3VJ?=
 =?utf-8?B?ay95K1ZlRzNJS0ZWOXg5YlRXT01KVDRFNmhJQ1paci9uNHpTWDJ2OTlTT2VE?=
 =?utf-8?B?ZVZKd2pWVWVUbXQ4aXZNN3QvS3pKZFAxT1g0eGNRdUVOdHVwcXZuSVM5aXpG?=
 =?utf-8?B?VU1VRW12dUd1eDNWelZXVXNZdUo5UUNaczhranBZZzFMbDRNcVE1ak1CMGta?=
 =?utf-8?B?T3VVMnIydDl0TVUrbHA5c1pnOTdKNDJiUjF2S0NTalZIRUk0Z1Q0akFvcGVt?=
 =?utf-8?B?WUVsWHNXVzdNS21LWTNYdDhnZlVRVUxOLzJCaWdWaCsxemJ2NkQvYmkvVWpT?=
 =?utf-8?B?N0FNdHgyU0llNi91WWx4TWN6RFN6NjJST1F0UUZRT1REMzFtOEF1VENOeWo0?=
 =?utf-8?B?dVFnWHEvZ2I5dWNGbTc2d3MrNUFCdllFOEpNZ3dEdTlnd1NWSHFLOHB2aFdm?=
 =?utf-8?B?clFwWDRHazhlV2RqeEQ1b21jSGttT2NRNWsrQXZxOWlVSjhnUndUTFdYMEx1?=
 =?utf-8?B?YlJ3QTFSNElmNHo1dStoT21UdnlmRnFnTm8wbUkwR1lGY09jNkI0eFNXVUNn?=
 =?utf-8?B?dVFiYStOZHNLMEdKZlFkdHhvc05OenNkVllvbWxjMFFSS1NwWWdqYUo5NHc4?=
 =?utf-8?B?ZDNLSUttNnRuRVZIQ1FPUDN6MHU1bnZCeVpnTVN6SXZ2QWFnNnVYOWVwamx5?=
 =?utf-8?B?OUp5dTZ1YUhwN0pKRlhxR1FteUF3MHB1WXNFWWJ0dG5KOTBocjZGWGZ0QTN6?=
 =?utf-8?B?Wkh5cjhycVRESEpBL3A4MTlIVzk1bVRTb2VzTWRPWklLbzF6RG9WbHlTcGZF?=
 =?utf-8?B?YzZ3ZHM5ZmFJVjh4UUxmNVNwNTJYOUlZRlp5b2tYT3BYK3gzeUxGS1pkTllU?=
 =?utf-8?B?MWhrRS82cklUR2p3aWQya0ZJVlRpZHFMdHQxZG9MckZjMVkraDdwU1NNNDRC?=
 =?utf-8?B?Z25KWENEWUh0aCt2ZVI3WTVsT3A2Wk1nRWlTd3lyNXBlcldHS08zZGtjOUZF?=
 =?utf-8?B?MUJydW9QTEhQRHJaaHUrdHJId0pod0NGMFk1Q1JxenZiS29aUGFxeXJHNm5Y?=
 =?utf-8?B?SFlxYVNPN2FVUDBORHNYcGpCMDlLajNCL2FOUTBPUDM4TXF2RFZzbG1XeTJB?=
 =?utf-8?B?R2NIVEM0cE9YbThKNGJYc2dBVExQU3lxeEFSMmNlOUhCem90RlpwbFlMOFRu?=
 =?utf-8?B?aDRGYUNBSWZ6cmRKbWduOVdnWjAwTnBOVDFSUE9xZE9ldWJray96bWJ3R0tX?=
 =?utf-8?B?SmlzaXBUV25xeGhvaUhLaTBjRnpjeXNJM1pSemhpekxCd1FhMFJYVkdQcjJ3?=
 =?utf-8?B?MkpmUThLTG1XS0htU1RIekFTcUxQU2JIK1RydUl3SUdpU3F3VzVsVURIQ0VC?=
 =?utf-8?B?eFdMQmNNdGxsdGxsYzhvYnVDUldtL0JLQWl6aTJPcGV0M2h6U09kOEJya1k3?=
 =?utf-8?B?QUhsRmpoYndQODBZYk9yNXBoSitWdXZZdklYSlY3WGZ5TUNMYU9PUFNlZEtG?=
 =?utf-8?B?blArRFhnWkkvSG1WU0lJZ3M0dVBEVjhyTkpHTzlIM0xRZmlrdGlScnZKZmln?=
 =?utf-8?Q?GGGk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejl4NmpwSlVqWjhhR1ZrTjhhVFFRZDhTS0FMeEtNZm84b1BZT1QzNUtEaDVR?=
 =?utf-8?B?TWd4S2hMUmZDcS85a1RXdUEyWGdHN3lwdjBUVkdnRTEyTFN4cm1jeXJlTGdp?=
 =?utf-8?B?dTJ3dWlYemRka3VJa2Zhd01ZOGh0QzAwQlYzRTV2V0UyZTVvNGZNMDhsTWJl?=
 =?utf-8?B?bDJNR05MTzRiTUN3TEdOM0RwTktVdDUreWVRdnA0a2RURzdGOVR0bDllQm1h?=
 =?utf-8?B?NkxMNzQ0MTVPOFluUFY0WnBReG1FN1ozcTd1S2luTyszRkFqakJ3SEF0ZDk4?=
 =?utf-8?B?VHFrcGQvTlAzb2dqU1JiU0VuUUpSTHRlVHBlenJFRGNvcStjUGd2ZDVrZkg5?=
 =?utf-8?B?NVAyTU1OL0w2am81bHdOaUZ1Q3JlRS81NjJDZ0JLVzh3MXVsV29JNURHaUlX?=
 =?utf-8?B?NGdyWHliMlhZNmlpVmRjRktiRTk1bEt2WDc1MEY1QUExN3h0dVVkejVQUEhl?=
 =?utf-8?B?QnA3cHBNSzhzU2dub3VTNS8xR0p4MmUzdGVZaWY4cmJ0cU94QncwUkVvNVZP?=
 =?utf-8?B?MlBpN1V6cUM1MFh1QmFnTHd0MmZld3dWaGtTdVZPc01TLytCcEQwb1hIZTNT?=
 =?utf-8?B?a0VzcFZoN2ZZVFFqVUdhM3ZGLzdaY0pvczNtU2FRb0JVM0o4TS94YnhhWVhQ?=
 =?utf-8?B?RVNvMGY5ZjV3cUJuQzJ4bys4c2pwRDZLYVJQVzQwWmdEdWR5RnJhSEUxcGI3?=
 =?utf-8?B?eXpPd29ZTTg3NnRIVGtkM1Q2L3UveW1zVS9RUW16Nlh5SWlDSlRJbS9EL2Rz?=
 =?utf-8?B?bjNVTnR2bGtLWnlKMUFJR21WOXM3YmtuVDh3QVFaait3TkkvaXFwbTA0Uk9p?=
 =?utf-8?B?Smg4M0NNNGVrVG4ydFEwVVp0QkdxZjZWNWZIaXFTSzNXa0hMYVBDSTNqWHVV?=
 =?utf-8?B?eUJtbTV4cEVkWFRFVGxzZ2YzajRJL3lUWlFQdDJPU2xIM21xWXJJdWVnV28v?=
 =?utf-8?B?YldNSm9PVXJTcGVuMW5ma0wwWkZnKytkWFVETHc3c01IdVJxK3V4bGxCeE5J?=
 =?utf-8?B?bHRKbm91VEJIREFQUUtFMGZsZktQKzJwWFdkL0xHZ1ZUc21FMXgxZFJoemRI?=
 =?utf-8?B?ZjVPRnBiYXlvaVZjQjdBUGJocEYzZm5BUjhTc2IzdUFQUkE3NVJxWFVKaUlN?=
 =?utf-8?B?V3MweTAvN01HbW5GM0V2ckk4ZjJVS01QeTNRMllKZFNHN3kxeU1RWG1hSkJh?=
 =?utf-8?B?QXFReVNkekFRbjc0bHMwa0RxZlFmcDJRS1V3aFN2a3J6QUhJWkM3eGNwVDhZ?=
 =?utf-8?B?Uk8vWG0yeGlKQjVxa2JCVFd4TXJSaUROWTNWTTEzZFlvc2IwY1RrNGRCVmN6?=
 =?utf-8?B?TmNXM2VoVWpNSnVZZXJYRGR2V2lRSE51NFFZRldyY1Zxa05ObzRaNENZMm0w?=
 =?utf-8?B?ZDF4UmczaWIxWElmd1VXcWhQaHlPYUhEaW5Hek0zYkxUS2ZIL09WN21OelFt?=
 =?utf-8?B?NnBYalNKbWVHNXlOZHRIa0RZdUpIWFk3Qm56d1M0ZXBKbXlkSVVML3ppclI4?=
 =?utf-8?B?b0RDUmZsOTJ2bDl2bUhtU3hQcmFCbkdZY2tZTWU1WHZyMWdnUHhsSlVwT2JQ?=
 =?utf-8?B?dGliU01UMnZmWmU1c3pwUGUyMDMrVVhYbEt5bS9veXB6V0J0amxtZ21mRUY4?=
 =?utf-8?B?WXVOT3I3MkJSdGtNaCtqVmFycngrUCtPaWZqb1d1L0haUHdKVXV2YTZuNXhz?=
 =?utf-8?B?eWJDSzNkcEtodVNyOVZseTlPM0JwUktxaEdRbFd4QTBZUTMvcHVaYnowZlhi?=
 =?utf-8?B?Nzc5YnQ4cjhoWDAvbVhrWURVQmhuZHR4MmJTOGNtZUZkcUlXeGd4TXZqT0M4?=
 =?utf-8?B?ODRaeHJYUWw1QWdwVjBwMDVZSWVmWEhDcU02NllreWhIcWVVRWtaSmd4UHN3?=
 =?utf-8?B?SU5YSEpVRmd0blJsalVERDMzYkZ0cGVMRzFiSDZmZEM2MldEV2haV1JpRDhG?=
 =?utf-8?B?SGh2K29sYzVkQVBXbjVndkNzdU1Ia0RJUEc3cjNXOHlVdUxuVWRiN0FBVldY?=
 =?utf-8?B?RVdhS2lZRU0vYitQK1czMjg2c1dqVUg0eVAzM0NvMlhLTUhHMXJ2S3lCYkRq?=
 =?utf-8?B?czJvUWZ6dUw5dXFYaUg5RXlDTE1SekxUUmVobFgyYXFLcmNrTjFsRlRRNnN1?=
 =?utf-8?B?aEdxSksxdlR1SjZhOTJweTJob2dTMk82bkJwdmU4SnVkKzRPSkdKd0JoMXNv?=
 =?utf-8?B?NU05OC9qdFo0ODR3NGQ1SllveTUvbjR1SWlDbW5Zek5pNHlwQmFOSkxHSWJO?=
 =?utf-8?B?WXpKZHM2NlpkQVc0OWdkd2ZqNkNjTE1sZUlMVlUvN1ZVSXlhd3VVcU1Lc1Ns?=
 =?utf-8?B?MzRJcUdEazYwMzl6eklyWTFHRWEwWStUemZiRk4xNk5MTTN0b1Bsc3JRTjlH?=
 =?utf-8?Q?BfuGyvc1KH2cd5J0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dd673c-cc70-4e15-85ea-08de68c2d407
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 16:38:32.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boP7lf7L/PdBywjG/Z7/xFfjNAY1AudGYggmIuHzdaXySw4rW6vugOqEiJFIJVpAUxKgBSS9H8rqa8ZCH2CAagt5zsniPOzCIqQugYPRMoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258122-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C043811D59F
X-Rspamd-Action: no action

From: Kohei Enju <kohei@enjuk.jp>
Date: Tue, 10 Feb 2026 15:57:14 +0000

> iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
> from PF [1]. This allows setting an MTU beyond the actual hardware
> limit, causing TX queue timeouts [2].
> 
> Set correct netdev->max_mtu using vf_res->max_mtu from the PF.
> 
> Note that currently PF drivers such as ice/i40e set the frame size in
> vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
> netdev->max_mtu.
> 
> [1]
>  # ip -j -d link show $DEV | jq '.[0].max_mtu'
>  16356
> 
> [2]
>  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
>  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
>  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
>  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
>  ...
> 
> Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Although I'm not sure the 'Fixes:' tag is correct. Was vs_res->max_mtu
accounted before switching to Page Pool? If so, then yes, my fault.
Otherwise, this issue is older than libie.
I'm asking as IIRC before I did set max_mtu to the libie definition,
there was a hardcoded value already.

> ---
> Ideally we may fix ice/i40e to set max MTU (not frame size) in
> vf_res->max_mtu on the PF side, but this would break PF/VF API
> compatibility between different kernel versions and would need
> modifications on code that treats vf_res->max_mtu as the frame size.
> 
> If it's acceptable to change the PF/VF API, this patch would be simply:
>     netdev->max_mtu = min_not_zero(adapter->vf_res->max_mtu, 
>                                    LIBIE_MAX_MTU);
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
Thanks,
Olek

