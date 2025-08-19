Return-Path: <netdev+bounces-215068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB8B2CFFD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D95E6843A5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B82356D9;
	Tue, 19 Aug 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgJWNxrt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93C1DDC2C
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646317; cv=fail; b=hVS0OmtGJbMGRayzA14qenWjttSrIuGvs7QG1hLSi9yY67cWZOncxdOG6CP7oAzueyh6kHuqNuHKGyrKwycSXNR5kg0m7LUjfC5/IHCUqRm3lvkdxZ2rgUM8SGGPpTEj2pT+tHOTzUru0Y0fPDjS+VMPFzTGo6SUHuHsk/DhjEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646317; c=relaxed/simple;
	bh=V/bIdpmOAHUFPUsrIX9Q4wuTo2GlgrLLdXdQFoKu84c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIIFhiJyOwaKr+DOE8NT+E3ijeQ6mEnXEeaI7wbtG1fXwbBSFgKaCNhbMdy+7fXs2TtHfV3DnrqGRRFbBeQbMyKWlVvQaVEsB3yTZ1ViGXIKrLfIBjj5dTs48cuDlrwdennjmSNCZguMunz4ZoB6z6vu/3hifX7AxQzXEvE1m7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgJWNxrt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755646316; x=1787182316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=V/bIdpmOAHUFPUsrIX9Q4wuTo2GlgrLLdXdQFoKu84c=;
  b=CgJWNxrtXdn7ow3lHZNtluuX0b/nt/kmtGzWE6rPlcnXfyQUcUQejAll
   Yf8nE1auzYqyfnLz3OKRuULufDwpvBqmNNl68BpguH4zHDvjS2zde4BTV
   q2vPjcBMw6+MMy6Ubte1Ch0kpMwpVXruvzxchg/1ajK/Relz/LkBrBbY6
   qj1fiyaAjwimmyxlExjPVkteNLlXKHhoBtoryKXGVzFNgBefMDHghxpY9
   LXYGoZuITXfi3lsTysGiz4x/PoUo4y61m8+aGn3tZH+CdDifPQo+P3iYT
   Reg1AdjzzbyhDZ9EB5ZY8STfom85MuW5fJnXLtJ7JVb5JMxWdIDTs/f1s
   Q==;
X-CSE-ConnectionGUID: Di2jJLbaQ+60TvHZ+E7SLQ==
X-CSE-MsgGUID: 4Dp6BwUMT1yh85rvrWno9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56932582"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="asc'?scan'208";a="56932582"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 16:31:55 -0700
X-CSE-ConnectionGUID: 656lH5NeSgyDr+3MLo19yQ==
X-CSE-MsgGUID: Y7I0oJXDS4Sb7Vtr/Sp1Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="asc'?scan'208";a="168389608"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 16:31:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 16:31:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 16:31:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 16:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLLr38+pTfGl1ZCanrGUeVoJaB9IXSBKUCbytSnrE5uhKUX3GFYeQOeePB3sGZcGGbMYL5q95SathO63NI+vXF4U0hJ55or9RJk5S05b38Ky5os7u2tXjjoBEQsCTsa3g1ZUYhEHcmFb90qXnTRvg5uA7KHBCPEY3i3/8LxGCf2dN6DJ/oICN7HGWj8VnEYsuXeZYSgWcxk9I1LsewwUnqy1t15jutNpAPFrF3yCwOPIVq5icvh1f5oUm9QVJmeL1l+cOOoMFNFotucfpOw+uY0aRC4WHB7tBsPZo1ZfTqsOP038e0iQpYTKghe6DRBZnVdVegCfBeRisIe9PxLvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bIdpmOAHUFPUsrIX9Q4wuTo2GlgrLLdXdQFoKu84c=;
 b=O7r5pp3mqh27lB6l8ViHhUSqMXA0egLkDRmDNO0+pPuvOI5jIZp91axG2UqZJ972R28sAWeYRsihfKMc+GrksYDAM1MLSDHAO/WbiS9x7Y1HZjefTpNUt3aLkCyS01POLHgdxfaA2pY6zOcQxi8NSx134WEETMNlxPLphfLx92g+IG/UW5Y2u8U4xgdQbjlTWBxI9gDz45kFS/8p/Mr7ZadgMKW+pUZnyj4Y1pORw2S8/5T1jAM4yNdp4hIjDRxM9SF1qG4/gwo54Annm+zvRs9K2hCvOh0kLpwlmTbgZm2ILNh6APFLt2J6ykVa7KgyEwrmxNOgTKtOGXg1U0+kDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7610.namprd11.prod.outlook.com (2603:10b6:806:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Tue, 19 Aug
 2025 23:31:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 23:31:52 +0000
Message-ID: <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
Date: Tue, 19 Aug 2025 16:31:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
To: Miroslav Lichvar <mlichvar@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
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
In-Reply-To: <aKMbekefL4mJ23kW@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Xj8xfCbrWPA3ipQCjUTgdyfP"
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dc9753-e34d-417c-e554-08dddf78939e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXRkR2w3d0gxUUdvQkpQa05sYmh6NG4zMk93NUhqc2NVM0xOMjBFQThaM2RQ?=
 =?utf-8?B?enVrdm9SL1FRdm1hTGJGRWRPOE54ZTB6ZVZtcTBtbUFhd3VsdmRJdVdHZ3NB?=
 =?utf-8?B?MlZFUTc3NXFCaG9UZlhRN0VlZlhOZVI5dmVndFpFYzc5TWlKOUg4MURla3hB?=
 =?utf-8?B?M1hQc2NLRW9QVFVTMDltVDFuVjhtRnI5UjZxQmlSU1YrZHJ5RkpKRUI2d2Nv?=
 =?utf-8?B?TndhRlpFWEs5L1BITGxKVlVVNmk0M0t2WDNwVnROeitQY29KSVY0dTBlOXBq?=
 =?utf-8?B?Yjl2SUtaem43NmtBZmRwWnhianF2cEt1RTMrald6aG01bW53dmpNdlZQR0Fl?=
 =?utf-8?B?eWkranJHVldtRjBMS21CT1NLMFRSSnk1VXZERXBOUlV1TGdoZHZGYkRBU0Vl?=
 =?utf-8?B?UEpHcVZtckZ6N1VoeU9IUkU1V3Z1STJyNHNrOTdoWUJpR3c4WjFIUU14MnJZ?=
 =?utf-8?B?aEo3ZzkrU2UxWkQ0NjFVMDB0QmM1Y3YrUEpqM0tRRjFIRHo4c0RRVmh6dU1I?=
 =?utf-8?B?WGVJSHFKd0h4Sm1BNUZZcWFZSjlzbFpYYjBSTzdzelFTTU9yYW9Kc25UNE9w?=
 =?utf-8?B?QWhZMHpIQUhLQVNabzYyVG4xWXdCK0hQcDdZd3NDdWpxYUV6L3Zvc01YcnBw?=
 =?utf-8?B?ZlZiWWVzdk9JZXkxQ05qRVdSdXhMak82Y3NCT1l1S0xLRkl5QVNuR3BuUlBx?=
 =?utf-8?B?V1REUFB1SmI0SUl0SEd0Q0gzMmZPbnZOQ3JrN1Zqb05zbzVLME1ZdG9aclVa?=
 =?utf-8?B?WGQ0T2JLUE1NT0pNOFQ1aGg4bGU4N2M1SDVvS3N1OFNsL0hkVll4SEFYOExZ?=
 =?utf-8?B?YnZNWk1SYU5hc0NXL2g2bGxyeEpEdUlTVTVuNG9mMFpIWHg1U3QwK3ZpZkh3?=
 =?utf-8?B?YVloOXVSeEYzVTMxamNWTkl1eHN1RVBxQkZqWm95Qk5pVm5qajRDUEIzL09O?=
 =?utf-8?B?WWg2c2VtNWovb1BZQTdQTU1aWnVnSU1kQUJSZ3VxYnZNNENDSHFzOEZsMFVr?=
 =?utf-8?B?amQ3NG5yTWVBSmpFNEF0SmZoRDEvQzJSSTFsRUg5TVFZS3MyZUttZ2pCSnNh?=
 =?utf-8?B?akVQSXdVYVpoeXVPVHBjYndrb3Ivdyt1UlJySG1MUmdNVGtuV3ZqUVVjblYy?=
 =?utf-8?B?MXM1ZlREWEZORXJ3QW4rWHM5MjJrYUNkdXNFaXN4K0FWRVZMaVN4dzIrTGY2?=
 =?utf-8?B?SkZkUDRyYjhmMVJ1cU5DMTBtMWJYOWE2dThpRFZqRDJYcnVxRjh4ZmFhVWdz?=
 =?utf-8?B?d0ZrRHpHTWo2NnpPY2N5SlJZUHpwakhnRnRrTzl3RitaQ29uV2FxL2FpQ1la?=
 =?utf-8?B?Titwek1ITFpKNkxxMFpSNGZ0dEFNQmtCWUZib0d6VFR6MDRrcjlVZWVPc1Nl?=
 =?utf-8?B?Z3VJbUtiRERocDg1V05ZdVYvTnJsWFVYeWtUMFY0OGZmdlRwUk5uS0lhbnUx?=
 =?utf-8?B?R0JWZTkweEQ0c3EzeU1NSkZRUWpGMmJ0a09wZ2ZKZ1pSVzAyZ05jOUtzdUxI?=
 =?utf-8?B?Zm9pMDJ5NmhoeDVEbTdUZmd2bG83OU04RjJqbVpiT2pQY1pkTlFXZlJOYXhM?=
 =?utf-8?B?TzZ1R3Y2MkR0amxVQW1NMkVmYXdSSTZHUUtpbzR0T2JRU0tTdnZQYXNrdzMz?=
 =?utf-8?B?VWkybVlsWnVFRU5JOU5KOWhocXhsRkpTSUQwQkhLajUvbEUwekR2UHNuZk9i?=
 =?utf-8?B?ZmJIdVFBdEtNMXV5T3E2TXNmY3BmMCtVaXVmNDB1ejNSWlBQM3ZsTGRNZnVC?=
 =?utf-8?B?SFNmYXAyazVnczQzbUFYdU5hZjNXSHd5Z0wvMEgrd2F3bEs0M2pENVFxN0Jn?=
 =?utf-8?B?TDBTQUZaWnZMMGdISGV3ZFRUcUw0N3NDdDlwZmd0WHQ5QnZ3TCt0dnF2WHcr?=
 =?utf-8?B?R3ArYzdwRDRRN0VuVHp4ZTRZTlhzN3ZkVE9ScDZDZXlvZkVDcHdSZi9uQ0Vm?=
 =?utf-8?Q?blsjIJubUFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25YY1pJbTY5OGs1Si92Uk92TzBoU1R3MFdvTDI0c1h0TVJaWWpucjZ1MWpX?=
 =?utf-8?B?aVNiRWVDK1FTNmFQSEttVjF4VVVMK1RJRkZTNG9YcjJsZ3dwSEcyYURUQ21P?=
 =?utf-8?B?SWZSbzJNT2xiZ3FOdG81amNkc09CVmNDVjhsNnRkWVpDeElSTFpIdXdnRU5S?=
 =?utf-8?B?dW5pZFBabCszTWlmK3cwNU1HZFBnTFBueGUyV1hLS29wK1ZlQ1hkVXNkY2Nt?=
 =?utf-8?B?MjV4YzF2KzFZWVV5WDgweGpnRU4yN1RTTnBmTUZRME9PMVJDYjJIcWpRWS83?=
 =?utf-8?B?TUpCa0FHTkFmbWNONmMwcysrYTVWMDVHRVFFT0huRDhEMHBUM2NXRlRYc3A3?=
 =?utf-8?B?VHdEcnNsejQ5bURGSkZyTzY5THhXZEJUNkVMMEJnUE9IdDNsYm9EaktzejM3?=
 =?utf-8?B?blRzOUhzUmQwLzFLcWJabmdrcVlFK2lFdnNLR21RMGdwZVRkdEVUREM0M1Qx?=
 =?utf-8?B?QXlad0o5N1p1ajdJN2plZ0J5OGd3Rm8wSSs3ZVpFcDg3MTk2WWF2Tys0bHBh?=
 =?utf-8?B?a0padHF5M2RRaTA2Rm40YzF1VlJLb2FlT0cyTDdCYVQyek1xSUFHZld4Y3By?=
 =?utf-8?B?QjVCd1prelRWT1lyZXk0U3dULzZqNkRJWG52cXp4UVNNUzJBNkdpejFlNDVq?=
 =?utf-8?B?V251WC9tUWJTRXpmR21WRGlHR0MzZHp2bFY4aDEwTWVxSkxEUHo5SE1Cb0R5?=
 =?utf-8?B?Wk9US3lCSUlteFBuUHVkN1NiQ1lPYzRkcTI4SmVKdjR5S2FIRE9Peld0bFk4?=
 =?utf-8?B?TTc1TXVkd1pGdVE0dWlFNXJWQUFyWm04RFV1OHBkVjVVWmNhaEZpcFRpV2x4?=
 =?utf-8?B?Y1VjVHVkM2MxSkJjVnp4b1A4SnpFaktlWlplRUdXYlUwVyt2c3I2MlZxTnlK?=
 =?utf-8?B?ZXpqQnVoUE5yOXRadWtoY2tuOWdYTUFuRUQ1UmlxNzNzNmNJSnBSbzlYaFlG?=
 =?utf-8?B?ZGpGdHRpSlNPbExHVi9pWXFBZHgraHdDNHMwZ0ZyM1F3Yy8xYk44dzFpMmlV?=
 =?utf-8?B?eklQbUFzN0t6ZTZTMlFyOVNNZnRLOVVDSlhGOGlaczMvaDNYc3ZZNGhuQjJj?=
 =?utf-8?B?dUYxWG1oaWt2M0lMd1JOY1hwNXZKeVZNR1BGRWtBbEUwTjc5RzRIYWpFc1hT?=
 =?utf-8?B?Y3FpSDdKLzBNQ04wWFVabW8vYlJpc2FyQWQzblEzS0IzS0QrQ1U4QUFjcFBt?=
 =?utf-8?B?YTFxMlNmcStlamFBamY2b0JlVGxIYzJwQ08vMThYcFJ0bzVyMWc1T0FmcmZP?=
 =?utf-8?B?b2hnNTdOOFE2clJNUk1hMVNjRGRzcTdCMnRuWnl4bnZmSm8zVllnbW9TKzZ5?=
 =?utf-8?B?Z3dYUlVZTzBTN3dXTjVRUjVpNVZBUUx3U3dBUFhaSWhBR095cjI1eitDY0ZH?=
 =?utf-8?B?ZkxoSGJJZjBhSTFqWUl2UzQ5dmREZkpZcjRMT1Y1bGFMdjhZeVNtN0dVeFdV?=
 =?utf-8?B?YVF6ZDZTZ1ErWlQySENZK3h2V3hMVFZ0ekpDcnZVWnVMZCthK1R6RGNia3ov?=
 =?utf-8?B?a1JnOGVSMStyc09pajhVbHVnSWJqVlMyNHBTUlRSTUdmOXhQL01UVjViZ0cx?=
 =?utf-8?B?RjJ2elNJRFVBeER5dHp1a1UvclFRVHh4T1ZhS2M4dEZnTVJYWlJOWXljNkI3?=
 =?utf-8?B?STVCNkJKYlIxZExNZ0xJWGs5aVZkYkIxVUxYOWdrME1GcVBtNytPNkNsdjhL?=
 =?utf-8?B?bDY4K0lpQ1g2Wkh0NlJFNUNqcjBxQW5NYzhBa3BaT3VKTWNtOEVkeXhnYXZB?=
 =?utf-8?B?alVDbGVmd3BvWE5DOCtvS3FuczB5dFpTUlBQS1ZKYUVmdWF4Vk5kS3d0WGdG?=
 =?utf-8?B?QWJMYmxOMDlHYW9FN0hqd0lENW1QMjA4ZkMxQXNqTEZVb05aeHgrak9pN3A5?=
 =?utf-8?B?UnpPZmlRbXFmb3BSRHVvMy9yV2VtMFJiVExYeWV4NkVrZ1FabmNxMDJMNnps?=
 =?utf-8?B?SC9nVSt4eGpEd3RweHhLcm92bXI5RXNZcVBpOEVtaWpJZitxVTIyRE5GRjIw?=
 =?utf-8?B?ak91M1RONWdjWGxtcnExSWh6ZDRkWlk3cno1alJEYVpmV3lqYjVNSjRrQTJG?=
 =?utf-8?B?RWpJRDBUUm5VQytVUng3dUNLcTB0dkFZOGpaOFdsc2xtRUZacEdDRzNraE9H?=
 =?utf-8?B?Q1VURUlJT0pLODhKRGdndGk2MnVvNG1OWVhwT3FaQTBna2I5Zjd5dG1QVHVM?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dc9753-e34d-417c-e554-08dddf78939e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 23:31:52.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHMNwFyo8+PFQVijTGFePtUKK4sYOCgM/jPZ2uvuqlLTldYAssd5nHg6IcFrLwWtnec7DjNN9Y2+tZSCVYyidefs7t/18uEp3NHwSwHPk88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7610
X-OriginatorOrg: intel.com

--------------Xj8xfCbrWPA3ipQCjUTgdyfP
Content-Type: multipart/mixed; boundary="------------0n0dFWI6OMmmmr0fCGkdBVbo";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Miroslav Lichvar <mlichvar@redhat.com>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
In-Reply-To: <aKMbekefL4mJ23kW@localhost>

--------------0n0dFWI6OMmmmr0fCGkdBVbo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/18/2025 5:24 AM, Miroslav Lichvar wrote:
> On Fri, Aug 15, 2025 at 08:50:23AM +0200, Kurt Kanzenbach wrote:
>> Retrieve Tx timestamp directly from interrupt handler.
>>
>> The current implementation uses schedule_work() which is executed by t=
he
>> system work queue to retrieve Tx timestamps. This increases latency an=
d can
>> lead to timeouts in case of heavy system load.
>>
>> Therefore, fetch the timestamp directly from the interrupt handler.
>>
>> The work queue code stays for the Intel 82576. Tested on Intel i210.
>=20
> I tested this patch on 6.17-rc1 with an Intel I350 card on a NTP
> server (chrony 4.4), measuring packet rates and TX timestamp accuracy
> with ntpperf. While the HW TX timestamping seems more reliable at some
> lower request rates, there seems to be about 40% drop in the overall
> performance of the server in how much requests it can handle (falling
> back to SW timestamps when HW timestamp is missed). Is this expected
> or something to be considered?=20
>=20

Hm. The new steps do have to perform all the tasks for completing a Tx
timestamp within the interrupt, but that involves reading the register,
converting it to the appropriate format, clearing a bitlock, and
submitting the skb to the stack. I can't imagine those tasks being super
problematic within interrupt context..

The Tx timestamp interrupt occurs on the other IRQ which is used
primarily for non-traffic causes which aren't high volume (other than
the Tx interrupt itself). I suppose possibly freeing the SKB could be
something that is causing issues in interrupt context?

I'm having trouble interpreting what exactly this data shows, as its
quite a lot of data and numbers. I guess that it is showing when it
switches over to software timestamps.. It would be nice if ntpperf
showed number of events which were software vs hardware timestamping, as
thats likely the culprit. igb hardare only has a single outstanding Tx
timestamp at a time.

--------------0n0dFWI6OMmmmr0fCGkdBVbo--

--------------Xj8xfCbrWPA3ipQCjUTgdyfP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKUJZQUDAAAAAAAKCRBqll0+bw8o6NF6
AQC4vt4/s6GbP3XLhcYqNh+b27VNMWKj2vLiKuJOPjyifgEA13AFQxZ12mUq+CXBoqs8F5SO/fn9
4/aTk9E0PDx4hwE=
=D58s
-----END PGP SIGNATURE-----

--------------Xj8xfCbrWPA3ipQCjUTgdyfP--

