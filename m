Return-Path: <netdev+bounces-229752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82EBE08BB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DD34072C7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33F30101E;
	Wed, 15 Oct 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPoUrhUx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFD2FE57F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557678; cv=fail; b=Veo3lzaNP7tRXPqEtaCkhMtk6IJYaEIx9OE01+7VwBzMo0oIoDMUhBugO4MEyxSpSIQQSZe/7twyOFiQcVdm/I6rLhAAn2eVnCGMMNeeNZXa73c6iaeATrwb0tw9Xo7PjL8v0KIWmTBfApbfSsztbcbszO4XYPj5ZL9q5H9881k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557678; c=relaxed/simple;
	bh=vJ+Q/iMDyu1fm9JMHlVMPkpaLsIk8w42fFVLnIvyink=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4wQq/xQAaoFLvpOLvwugmxRPPfRbw4RIasdXTNnfiWZwhM/auVR2kRms0oZldbJEy87Jir8FEgDANwD6OPFdQhOhKSCmX0Ns6xkztS3VgIcxS29aPR79bQO+EcrNSSW5P+9KBc9V0ZI3RItrsnHhZMd0xW9AZdVak7VPhQ6URs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPoUrhUx; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760557677; x=1792093677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=vJ+Q/iMDyu1fm9JMHlVMPkpaLsIk8w42fFVLnIvyink=;
  b=OPoUrhUxhqihe+oeF03UH/RC7Hc9QgDf1OPEG9s5pcmJ8lAz6BC3qiEt
   sR92svimN3YI7bhbJobxFVzFlY1FoxqxtNo1cF/8OPo4ACyHPyQ2I370T
   WVrs+7jYNkhX9t1BEpJ58YGM7nEoFPj1P8SVjhN4MyMc0CzTvFgDwDdFS
   tF6SmwXhjIwpXgF7LKfayvNBTznZ4dOk4fLRlIQTwJPZJAqYK+ZegED+K
   AjaPUIWSkb8i/0V+DhL0YYlOusOouN75bbyxfsqj6uFHwNYvJjWQ72mAy
   YDzAVf4GoX22TpLIzLXAIXNgGos5luDkttVIGCCiTsvox9NbZ7jIJf879
   w==;
X-CSE-ConnectionGUID: A+40wzqcTQGO89VXDa5mPw==
X-CSE-MsgGUID: 4UWSTpKOQzmbc4XklEmVfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73853769"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="73853769"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:47:56 -0700
X-CSE-ConnectionGUID: gniDLGnhQ0i8dEv33te9GA==
X-CSE-MsgGUID: ADUd5udVQM+fS1nW4zg/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="181396429"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:47:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:47:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 12:47:53 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeBpulUb9w8WgZO3PqEoCYYNuDnb+O3TR3Zf67Ajmy/OmbYPeVEbKb4a4JzQUJFkpswbch00MIRgzG0i9gh7eR7sTmW7kdgm6RhlFcd7Q90rN/Awm79lBJta4Q/3tSJRHjPCbqvT+Pbqm2tBDPYaA3tLVYtmGaDypvvXnuJ0KyL8pYm/qjqgChADHClWZnoLUwy0zMGsDfoKccY+5sjOv4yExG/g6ZAE4uZsPDvrRrQgJAszydILY24Ya35ZeCNBpjv3JmE48UnsrHSUMD9NRIif8Zo6qbpnBuxwefrH701IzymzOgUz2+WBDsb11jdLcXWr7o4NozWtSn6XBDrD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWafqz42rNWMF7HYvfsmYYUlle7SoJ3lhH0hMUfh7AY=;
 b=hYYTRbna+IlxormU09deOicYWHXrAT6YFhU6p8zCixrBkRIUKsFdj+waf37GCeBbQg74ok2J+t554bEO8SCj5IKdcO8Z3DmSVf2DvYmwaSfotlLoeTviy5pbjeNEt5uaKYwuxMyDTvR1UWnbzqm5SL5hVmjWkeLkEVoqK2FOI6MUGH5GmsbTzPQBQuM6vh1pQP/OoD9PBoRYvdo+4B+AwDeCzsXTVA0sQazsMAkdrN6fTDuzN4pzVzizWWCAK0JExuoI45Un4mCkpxVW41BHqsbWOgkkJEQLX70zpfcDBOU4h7tGedh39mPDg4CitjSF+c9LRtcyDquBSrKHNj3cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 19:47:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 19:47:50 +0000
Message-ID: <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
Date: Wed, 15 Oct 2025 12:47:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251014224216.8163-4-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------EPOFAPxhe0H356noE8LOWL70"
X-ClientProxiedBy: MW4PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:303:dc::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b09fcd8-d5af-4d4f-aa8b-08de0c23b903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnhjNjdPOWZBbHFtTlg0bWhLVkoxdDc2L0hEZ0RVbTdXTmExWmhHVXFhc3o4?=
 =?utf-8?B?dVFmRFZxTU8rNk10S2hxT1gxTFJib2J0NklUSHY5N0d5R2RWZm1mMFVRV1Zi?=
 =?utf-8?B?MnRXTDdJNVpUdWQ1Tk5tdExiYzlxRXM2RkwycDhaeitvSlhjLyt3VVVETHE3?=
 =?utf-8?B?WHRvaHRkRHlWUVBXdlNtM2g5VkpaeFVqNHk4eWFpdUVaUUtsN25QbGlrL2pC?=
 =?utf-8?B?VkRqZXN1MHdPbm95azhqVE1LTHdmQzYrWmlWTCtuc284QUJjL2tYclFES3VP?=
 =?utf-8?B?UmJvQmJRSUo2TVI5WDFEUWVFYUJ5K3JYZkNvV2pHTUhJOWRpbm91bWVqdnpj?=
 =?utf-8?B?Y3hXSVhBV1ZiUUVUcTV0WFFCSVV6UFd2b3czcVpZKzNxNWV4NTZYSFBhZEFp?=
 =?utf-8?B?MEUzQkVYYWUwclFvaDJKNFF1NllaUm9wVmMzdk9zMFhzemNqZW5zeFUvL0dw?=
 =?utf-8?B?aVJvVk04SStUUE83NThLazRVQ0QxZm9zdUVYVUhhN2NGczc5dGJsQ2VVZkR4?=
 =?utf-8?B?QjgrVnk3VlVZUzBVNmdIODI5WEJ4UjExVXlkSktjVytyRGZ6WDdIZ2lWQ3lh?=
 =?utf-8?B?MzBuMkhhMFEydGpwdVdwNVdXOGtVZXFsaUN2Ykpla2RpbkRUcFYzT2xOYlVS?=
 =?utf-8?B?aXhFTkRncmQ2a2hBOHMzRjg0UFk5ZG8yZm44d0VxMEwrcHdqOUZUNSs0cXZT?=
 =?utf-8?B?VzAvS3VhZzAyK0tEeGtBWW9MM0dEenhZVmFaZDVoSjhORWdWN2hqNHp2RU01?=
 =?utf-8?B?TmJTUklnbGZuWjBlaW5HQXZlM3FpU3k5RVZDTlpYa0YwSXRsVVJJUVhVb2VY?=
 =?utf-8?B?KzgvMVgwVEsrN05QREZkWFhSREl5MUFVUUVsUWpVY2tNUFlEYUhjNjZLU3h2?=
 =?utf-8?B?aGt4YlVESW5XL1JEbTNpRGxQQ3U0Qys5eXZRLzVDZVB1ZWUxSE1vWGVtK29u?=
 =?utf-8?B?Q3pqZ1NPWEt3WHVkTHFiQ1VzcE1EYzFqNXpYVnJPZUF0ci9KbHdnTG0rMjNR?=
 =?utf-8?B?ZDF6VjIwWmYweU9WZWl2VlNNTThCdlJ0L1JvRnF5TGgwUGhjbFZlOEs4SDM1?=
 =?utf-8?B?VkN4WE1JOXZ4TFRKQjBsUXVHMFVBOE14enM3NDdxMnl5RE5OOTNrSkcycXlM?=
 =?utf-8?B?cVV5UUVIYVE5MjFNN2JjUnA2bW1tQmVFODRvNU9jOUp5ZTBYdGlNWWtDRG1s?=
 =?utf-8?B?aWJOTWJpRDdlMDdCbXpKUnhXOXNyT2RFRk5zK09vTHRRZ1lMQ0pJY29SZ3R1?=
 =?utf-8?B?Qkt2SWlYUm01Zi9JaVAwUmNEOG1RUi8wZzBEamZzOHBNei94QnY1aXBDMUtN?=
 =?utf-8?B?enRpcXVqY1hJUFladDBpN1NEUHNiaE1SK2hodE5qMDNZMEFzT0ZTa2l0R2pq?=
 =?utf-8?B?bkZTcWNTT2x3WjdpVE0yNVViT2tFQ1Q5YVYyTVFZYVdQOGRlcW45eUN2dVls?=
 =?utf-8?B?TFRhcWNiMnVCaU10cGNNdUh6dHZobkVmeGFiSVU2SXh4bWdaVnVwUVp6ZGFm?=
 =?utf-8?B?a2o1ZUNscW9JWDJFYm52cGtxakVuTmJ4dU1nVlFmZEZJWEpwbHlWWm1nNWpq?=
 =?utf-8?B?eWwzYVdiRUxRd2ZjajRDNWt1dFE0QlloU3JEWFdJWXJxMGV2WTVVQXQ2Qit2?=
 =?utf-8?B?Y2JIK2kwZjdkUXYrYmR3Tm9oS3ppUUh6eFJXQ1loU3dRUHp1U2IvQ2RObjVt?=
 =?utf-8?B?amdvZnJZTzIxRzBvSEJLVVJTQUdUekw2dXZKaXNZYU1ndEJ6OGt5NkxvVHNW?=
 =?utf-8?B?bnJ5SGZpRlZKL3k1ajUwcVZlWGVJN2ppL1N0eTJtZm8rTmpTa2lqYTdrSGFr?=
 =?utf-8?B?eXY1U3hwTW4wTTVkRjRJanQ3bC94ZHQvN2JidHV5VlVRT3JlVGJhS000eGVE?=
 =?utf-8?B?bzdQZWxUWWxvWjBFcG5BNlF1c0s5amcrYkthVFZzK1dhRlN2VmovY2lTaE9U?=
 =?utf-8?B?T2J1N1pLMmN6TUFCeS8xejBWa1Y5N0RzN2pSTTlyTE5xSlhPdkk2OHFXcmRQ?=
 =?utf-8?Q?hWjJlfz+mJYtQPO/I4sixGZgnU4KY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG95SnZOTndkZHh2WDI3NGg4OEVmQlZuSEplM2hvckJGcTZqbjNoNFNRWDFF?=
 =?utf-8?B?cm04a2s0ZVFIZDViOHlFN0tJdGhOSHI2RzQ4b0N3Q0xTbDE2ZVo3SjdLQTdC?=
 =?utf-8?B?b3A4Ym16T216Y2NBMHRLQnNCa1lCMlJHbnhkUzgwMm8vWUVldXNQbXhZZytW?=
 =?utf-8?B?QkhWRWY3TUtaWFRDM05JMURoejhTdmhnRTZzOHc5NkRwaFB2bHVyWnNPYUxs?=
 =?utf-8?B?MlNidnExWUpLdXNqZDEyV29TeVdYYWpOUUM1NEVNcnZvN3dybytDZ1RSTmR2?=
 =?utf-8?B?VDJFNWxQcFRoWXlVVngzSlNFQXBtNTUvVGtNYkhYWWxxNEg3Rm1MSDVzaU0v?=
 =?utf-8?B?WUsxZDE0Sy9PSHFVUEZ4WDEveU1nV0lYRUhEbWdvd0loRXhodzdDWStaOXpt?=
 =?utf-8?B?bnZEcEQxcmZObjNFVFc4cmlMTysxSi83T0FYNFBiOE5sTUR1TU1RaWFMMHor?=
 =?utf-8?B?UHJsTmphY2Nzb0hoTkZoMzByRzhtdmVQajR6dk8rdWE5UW8vYTg4bC9xN1py?=
 =?utf-8?B?eVowa0VFOCtDNlhXVzluL3c1RVdNaWhwNkhyUkR1ditXK1EyZHRidXhDN1ZM?=
 =?utf-8?B?NTYrUnFBWDFwUEdEVWF1ZTBkVm5HOXNtME9JNUhURkNpcHdZSzEyMXIveVA0?=
 =?utf-8?B?bXBXZmpaZXRSWkdqTFlkWjEzNFpxZzZmaC9JQllPeUVJdnFDRkdHc3dBSkpV?=
 =?utf-8?B?Y29LV1pJT1l6VExOVllYOWVUQ2NmS0Z5TXFjYWw4OUZzNU1iQ3JQWHpxTi9h?=
 =?utf-8?B?T1BwOEV5a2J0RURqV01yejZhR3VsalVKWlNqTVZIVnZsOWFHNW5mOVkzN0I5?=
 =?utf-8?B?WW1uNGRuVTh1YWdIcGczclM4bERJRVZIMWJ2dkRKRnNQeFROb0F3RUI4Mjkz?=
 =?utf-8?B?OVM2NnkrOWduMEQ0TlAvbHQ1TTJnU0RNVWVmQXFiQnZpM2x3bFVwVDA4OG9J?=
 =?utf-8?B?NE0xZk1PRHgrZzJQMzBTNDZrZ1pYaTVXdHZYQ3JReHdvMGRRTG43Z2FBWlFF?=
 =?utf-8?B?L0J0ZmtxNWpjSSt5bGhWZzVRWFFjMHhFV0xJdjBEN2JBNlZmMzRSd0d0VW5F?=
 =?utf-8?B?YlNJUC9UVXhISVk4T2NiaFRtT1crSjlNcVY3dXA1d2dFckRBN1Z1TmU3RzFF?=
 =?utf-8?B?ZC9lOFFlaGRIdnBabmFrOGt6ei9neWJvcklxWXhLcUsrMFp5cWhaRnZvVVg2?=
 =?utf-8?B?MjdFUm1yQ09sYkRBQWRDYWxHekJ2RTRnRXUyS3dKcnFZdis5MzY3WHg0dFY2?=
 =?utf-8?B?ZFhRUGRaaTNBSWZyUml4Z2hrblpEUUQ2V0tBSkFhK2VBbitoUUFhcU0xYTJm?=
 =?utf-8?B?Z2VVbVAzUEI2em5ZNkd3TFJzcUJLOGFBWjU1ekEwRXNVZ1Q2NkxDU2MxRnFP?=
 =?utf-8?B?SEN1MGx1UFFlWDhBbXR3OVZITnduVnNXOHpUdzdMcy9YUWVnWENycHZ2a0Fs?=
 =?utf-8?B?RG1ZU1NKZUVnMi9TRWJVWm9XU0lweFUrcEpOMklCaHlodGQ1TEVkQ1RycTFl?=
 =?utf-8?B?eEljYmMxRjRKMW5xRHp3QW5jUjROUEZkamlHekt1UU1DMlBZOTBVU25WdmZu?=
 =?utf-8?B?bTY4bmQ0RUloajcySFVjc3ZaL3JPTU9SSzBHQ09VcjRYZzM0eDFRVWNKVEdl?=
 =?utf-8?B?ZXlBTzlvOTFhQWU1N1N1M3RhMHZPRlB6ZmpXTjRLWlJrS01IbHR1dU5sRHpN?=
 =?utf-8?B?SC9tY3lvamxNdU15RTBFOVJ5dVZtc09qMWwrNEc0aFhCblp2M0R5NCs0cU5Y?=
 =?utf-8?B?bWx5VFhHNGpsYXBtTHM2MlJhMjdyMWtMVERONTI3bjFMek9YUGVNRWRSQmVO?=
 =?utf-8?B?clJrL3Y3aERKNmRicy8va1NUYXA3emIzUXArUHdDMTlYbWo5cjZiaDkyY3VG?=
 =?utf-8?B?aUhubXpNOVd2QWVpYjRLMmNLVlYrRm1sSXl2cmd1WGlsVHB1ZGJMZnVxZk56?=
 =?utf-8?B?bmo4NmRTR0NWY0dQNS9jNCswaWg3dUQrMkhhSkxZYjVSMlIvL25hYWZ1dity?=
 =?utf-8?B?bzdOOVNYY1hxL25BV3J2c0RhQ2pkb0pra2hsWmxEeDJvRzlvMmQzSTR3czFI?=
 =?utf-8?B?dEdrYitVelFPamEvbkFoeFIwR3hzNWVUdFhwdk0rYmYwY250VWJjMWVZYTlC?=
 =?utf-8?B?UDhiaFdUcmtYcDZuakIzWDRvVGFrbHJ2dU9oTTFnZzE0czNOeTFscDloUnFL?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b09fcd8-d5af-4d4f-aa8b-08de0c23b903
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:47:50.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuoOjwPvVN7iGYT2yYf1KM7GB2ft58MLJhGmh3vlVge3eSvBC7Mwuss6G4mfU8HRo3wF6DKwlH4dx7jrFW+JmovhIUgrHKlc+7tCFvYGnU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com

--------------EPOFAPxhe0H356noE8LOWL70
Content-Type: multipart/mixed; boundary="------------gE5g2d5geUcc0uuzp4RavfGx";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-4-vadim.fedorenko@linux.dev>

--------------gE5g2d5geUcc0uuzp4RavfGx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/ne=
t/ethernet/amd/xgbe/xgbe-hwtstamp.c
> index bc52e5ec6420..0127988e10be 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
> @@ -157,26 +157,24 @@ void xgbe_tx_tstamp(struct work_struct *work)
>  	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>  }
> =20
> -int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifr=
eq *ifreq)
> +int xgbe_get_hwtstamp_settings(struct net_device *netdev,
> +			       struct kernel_hwtstamp_config *config)
>  {
> -	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
> -			 sizeof(pdata->tstamp_config)))
> -		return -EFAULT;
> +	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
> +
> +	*config =3D pdata->tstamp_config;
> =20
>  	return 0;
>  }
> =20
> -int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifr=
eq *ifreq)
> +int xgbe_set_hwtstamp_settings(struct net_device *netdev,
> +			       struct kernel_hwtstamp_config *config,
> +			       struct netlink_ext_ack *extack)
>  {
> -	struct hwtstamp_config config;
> -	unsigned int mac_tscr;
> -
> -	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
> -		return -EFAULT;
> -
> -	mac_tscr =3D 0;
> +	struct xgbe_prv_data *pdata =3D netdev_priv(netdev);
> +	unsigned int mac_tscr =3D 0;
> =20

I noticed in this driver you didn't bother to add NL_SET_ERR_MSG calls.
Any particular reason?

--------------gE5g2d5geUcc0uuzp4RavfGx--

--------------EPOFAPxhe0H356noE8LOWL70
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/6ZAUDAAAAAAAKCRBqll0+bw8o6Fki
AQD5zroxysQcLKhSHYArpPeoucxnmmK5t4rbqoMYovW9OAD/VnE4OnmE1ur2GomwG9IlTJca26pH
2ddmzRRjvWyMvgg=
=yll3
-----END PGP SIGNATURE-----

--------------EPOFAPxhe0H356noE8LOWL70--

