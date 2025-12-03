Return-Path: <netdev+bounces-243468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD4CA1CD6
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC683006A52
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971B2D29CF;
	Wed,  3 Dec 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLfGW5oN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CE2D249B
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800257; cv=fail; b=PGKHJQ5TiMXE/nMcNaDDR7rDZfI84bkQfXvvK/o+4vki/OHwL5SgFOKEA1/ExHBmEp0K07ieKa+ryi6ZpSvTEc4Tz5gTFNFX+FTadej2tZ+oI+JKxdOFUezKRb39mGINsh8oFwFRNnEMDAv+kyf1pDSN7FkaGhuQq1D/Q//M9gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800257; c=relaxed/simple;
	bh=hpiBknbY/CsfTcOVFQZ9KTp5Id24MJyGC4Dn9qHeZOE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqld4Lvw0VIU2Qxlzk5SrCGABKmevAzjTbpMxaF88IfnhYSkNdEpOkL42xkcTJ+Smhw4Mbj9tda3wtQgcyLFsieyLfpMKq00JdyQPYNaoEFtpRExjLAwnx3kgvaFnMn59z37tStuGVNVw3ExcXra3hvXVnix4j56izZYSIlf2ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLfGW5oN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764800255; x=1796336255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=hpiBknbY/CsfTcOVFQZ9KTp5Id24MJyGC4Dn9qHeZOE=;
  b=CLfGW5oNroBOiPR525O7AP/QiWxqdaD9Ygqy2vBVqEbATlseYz91Oqvb
   i/ZGqK6j++MEftToBSEoS5w9PMpM21akH/zAUlg8D/TzbTQJA9+BkiJL3
   yszhTmqwNrJc6JrwVWtQWjI7teY7Z2SJlGdyKFE+JVIW3lL6o/awmQ3o6
   liapaDqVS3lZYY0mWw1X/zGOI4vuD2JRdqqOya8ASKVAwYCOwVizbau0z
   vDTgt7WcMYQWuHF9Ijzx8M+9TtGeevhQSio2VXCGkS6ROuFw9T1HD3o7n
   VoUtHPeh47sfaK4qcj1Qxerneuv3Yu3m3h6kGddrxiXRHnsl2Iuy4xCwV
   A==;
X-CSE-ConnectionGUID: 9/x9ASYHSV+iuhuoIAdbmA==
X-CSE-MsgGUID: IwyEtYbiQ/uE1iSbnpXwJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77432036"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="77432036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:17:33 -0800
X-CSE-ConnectionGUID: I+n03FS0TIecL6WhrJnzuA==
X-CSE-MsgGUID: 3amLU760TSWtRTVoCkK4dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="asc'?scan'208";a="218159685"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 14:17:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:17:32 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 14:17:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 14:17:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ5JYmx3fsDS8i6V9u7CDjgeku+PtXRCq40AHlJ/JcoHYWtCULTutnr27V3GC77WvAGjxoCAqsjCXC3mVkey6sNgiJSrjgFFdLM19FBXuxk8z7ZOmur56re1D3KBe4GJlwXDcM+2wSXbfsxLV/CbXnBV8a90dhmc2mJD7pe3O1sO5v4BFT26/qZ9w2FTYZjQIfbcwstswqnu9LS2ODyRkXLRmoK3nVESR2l4SzUG+AF7RkUi6PM9vW2q/iZjuWbzPdYEnmdLDDYr/CA4UT5/TtIJJ6EBoqSBLR4aaZgh5D4p2gjczHopbZOG53nhPHOHbgTMOsc9bDuUNhRqnzUEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpiBknbY/CsfTcOVFQZ9KTp5Id24MJyGC4Dn9qHeZOE=;
 b=F3RzBU59USWhfQw3W5bTHLIapJ2/9hKWo6ktWzjX5eLvaMfz4xj6FLnXxTGMtJTRqomAupCGpqLLsRN1syBLkjcYfCRF+TaD5Ruhah0vkp3RWDh7zbBEwATkQBVJcGpk/FPf0fACAHxsoXh/3rMzbzn8EpvM49WtbjmKq+hqEdnZFusug6uKB/aLTz6rZMiOTbL632IrrUbL1yg5zjGs3bbExbobcQpKebJaEfMlrzcDwCNgdbP+yWzSlup2LNfqOx7uPJsVaW75UyRzSwJVz0Vpj2maAh3A2qREHu3VozV9nnjUtIgwDuY+y8MoB8gg1RvWKJakLxgqEtZvZtA/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 22:17:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 22:17:30 +0000
Message-ID: <e3110f85-290c-47f1-800a-9430afed5abc@intel.com>
Date: Wed, 3 Dec 2025 14:17:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 5/6] ice: shorten ring stat names and add
 accessors
To: Simon Horman <horms@kernel.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-5-6e8b0cea75cc@intel.com>
 <aSWCQQsd-_cIKucF@horms.kernel.org>
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
In-Reply-To: <aSWCQQsd-_cIKucF@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------U4Oky1rYS0kjHbi6LCwgC330"
X-ClientProxiedBy: MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: ab591f7f-35ee-44c6-94b8-08de32b9bfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTFjRnJ1ZDdGdG55YTVDQ1ZYVU5WOWtEajhNOG52NkZwTFVnMFhsNW9XY0Zz?=
 =?utf-8?B?T0l5SEpkTXY2eHBtQXdnMnliRGc1TTJJQkh4UHdQVTVsMlJZUk5uWFBRMHRp?=
 =?utf-8?B?QTlIMHlUZlViNkhDbXltRHJzWk1qc3c0eS9qcEF4aGp5QTVtMUhnTitmS1Jh?=
 =?utf-8?B?eWRyZHFwSmc5NEdHZHRJb2hUN051UkdkR3RMWUJqUkl2WU9XNFhROGJTZUlm?=
 =?utf-8?B?RnZabzVDbWpsdU1QZERIUVZtRklsRnROeVdScEpTMVUwdm96UllQdlhKUDlR?=
 =?utf-8?B?TGx6alQ1Mjg0TURKK3RRSkpRNEIwRDQraEZ6R1hPalRZMDdUbVdLVWt5NHk4?=
 =?utf-8?B?WVhyd09wdmUvTXN1UmtHdW5GWUIrekplUzAxVHY0a2dkT2k1Ynl4RGxiNDJ5?=
 =?utf-8?B?czRmYW94cVh0YU03VjRJRGFocUJOc0hYNUdnK2U4NHFzeE9UUkxxYThiU3Ex?=
 =?utf-8?B?T2ZUSFQwVU5oekNxTFpxd3QyK2NaZHF6c0p3MDFBa0pRNnQvSnc1WlR6aFJD?=
 =?utf-8?B?Tlc0YVJnOHoxalhYbm1DNWZnb2EramU0QS8vZDNZbFc4K0E1K2xIRU1NTXJY?=
 =?utf-8?B?U1RBTEMxc0gzaFdzVDhrT080blBRQjJWNkZEeHR3ZXVJNlNJTHpqc1BjWHg2?=
 =?utf-8?B?L055VDg4Qm41T1MwUTBGbVZPS2tRVEdwajJ1NG9LYjVGMU40UlhZalYvYVhi?=
 =?utf-8?B?L1ZKN2Fnbk53dnNBVTJscUUxM1VJaDFTTTNEekZ0L2F3VmFMdEM4QVhGNk5s?=
 =?utf-8?B?Z0U1YlhjK1kzakphcVRROWlab1hFaXZOL1cvQ0ZjVk1YRHFFeldUN1o0eWh2?=
 =?utf-8?B?V0RvUjd5SDI4SE1nWW84MzhlL3Zpd3daSTgzZld5aTBTTVFTbEZtc0JETkdh?=
 =?utf-8?B?VGUxZkVCVUQ5UnVrK1NqZ1h5REhsM0t0RlZZZzl1b2hRMFVlcUNRRzlLc1Jn?=
 =?utf-8?B?eUxqNENlQVFycEFoUTJtb3BXeldsS0Q3Q3YxWnVzcmliVVJTYW1hbW5Dclo0?=
 =?utf-8?B?cXFBREhIWjlGSVpDZGZwbDRQQThONnFhaDVWVHB2SFREMVk5eTVXVXRuOXBn?=
 =?utf-8?B?dWtTL3R6S3pvTUxyUUg1ZjRQMDhZb0dPZzB6TjQ1OHRjQTMrT09VcUV5UUs2?=
 =?utf-8?B?U0FJZDJCaHJyYzluK0x3SzVEUm5Fa1ZMUStINWx2V3p4UXV2R3VVa1hrKzlr?=
 =?utf-8?B?ZUY3ekpJZ3JyeHVGaktRMU5CYmNYcUpqTW9kYWFVOEtJY245NUwrQkRDMW03?=
 =?utf-8?B?dWszVzh3Wng2SVk0cThPbmpmdkYyUjcrZU12dE5LVjRQMWJJeDNRYUtJeitv?=
 =?utf-8?B?eFdoOUthZ1RKTU93eUVuSG14dm10ZzBLSUZvc1RxRFc3Y3JLcHZXU1FaUzl1?=
 =?utf-8?B?SW5lQVRKZjZXN3BmSENsQllLVUdvYWpRTWZ6L0ZnSjdqQk1jUE5KTDJqV0pO?=
 =?utf-8?B?RjlOVllic1pacWd2bWpadHhsaERVYXFMTTlKTkNqU2tOVkw1cTQ2SVZpNGlr?=
 =?utf-8?B?bTd4citOenlDWVVvZy93OXRpWkhRY2F4WVJDNEtmb2Q3TkVza21ZZVB4ODZH?=
 =?utf-8?B?NXpvbUxjeXRBdHVhS1ovb1FWdy9jdW9mVmZlaE9lUzhaSytpSkw0a0VEMTVS?=
 =?utf-8?B?T1FuSmFBbzZ0UUlGUm5RYXlIMU9pR05leDdnNUxVdW9sZndaWWNhTEVib2NU?=
 =?utf-8?B?aDNmeEtVRnIzYytmWmsrcUQ5U2VHZEFBMytEcEtGQnEyUEdRb3F2L0JsTFpB?=
 =?utf-8?B?VEhtYXR0YW52NkM2dUZnL2FSbXZsdU5rS2pwcUx6ZFhlaWYxZ1FvWU5FZ3dE?=
 =?utf-8?B?NXY2ZDYxNitOSUN0cTgwZW5yZmRsWC9jTjg1b3h0UzBPSENnNTJzaWdIYXpr?=
 =?utf-8?B?N3FEV2FpK2pPZXNTTStnYWhGZkh0eERuQTlsMk9YUEtpSGxqdEtXWjB2ck5s?=
 =?utf-8?Q?FOIVXNuQBP00Adbs0Sycqv49rBBDG0Uv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJ2Sk1kbDA5TW96Rm5sdDAwN2pyZlRVU29Ub2hFTnRkbFNnTGh2N1JpSzVR?=
 =?utf-8?B?eXpoNForTzlScVA5TmtEeXpWUDRSaVJIQno0QWdEMEZ2c2hSczdWdCtwdHNK?=
 =?utf-8?B?NGZxdFAvd2xnMnUwbEZPSHhpb2tSS0NaT3dLU1lHdlBtSHlWVzc2aHA3MGo3?=
 =?utf-8?B?Z0E0SGd2K3dzeFY2MFpRQmh5RUVmUkdpQWZzRGxjbnBlaXg1UytjMkl2Vkxm?=
 =?utf-8?B?dDFIdXlmdzRzU2xIVDhxK3hWREUrQzVkM2JOa3l5RHZtbCs0U05vMFlOQnZG?=
 =?utf-8?B?NEpIdGltUDRMNEV4NnZUdHoreVIxSXJNVllRTzVsVWdrU09YWlRtOUJ4MkFC?=
 =?utf-8?B?Q29heUQ4eFVPWk1QUUFDMU5tbmdlempMRE9pSDlzYlpyS20yd1JnNGpYNDd0?=
 =?utf-8?B?S0Q4am9LSWpnUlBabElWcGl2aFVuYks0YkZEYnlTSnRYMGR6WEorQ0hFbkZk?=
 =?utf-8?B?VlU4c2JMYndrOUJCVUJzclE3a1lxV1Y5a3ZqaFJVWmJoeUk5aEs1dXNoZ1Z1?=
 =?utf-8?B?WVd6ODN0RTNHUENWcTZseFBEM0ZSWWxTUFFwL2pHcmp5SzQyQ1ZiUUE1RGhE?=
 =?utf-8?B?ZHd2a1dWd2NvRS9LT2ZFRkJMNk5KclhiWjF4L0RtQnpOUkdOTHJXSTZRalRQ?=
 =?utf-8?B?YitoaldVcno0Z08zek5vUFpzbTRxMDluekxmdElwSTJHNHEzMHpkZEJqRnNY?=
 =?utf-8?B?blBVVkQ3SFZhNzRmSWlEbDkrWTYxZ2hKa2pZL1RKYlppSS9KdGZYaUR2NHVY?=
 =?utf-8?B?bklCV2Z4enFDUWhvQUpreXp6ZkxrbDFNeVh4WENiSlFsLzFtQ1hLUEtSUkRx?=
 =?utf-8?B?cWtZSTV0d1FmWEhURzJRQlF4UWZaQ0ZPR3Z2OGVEeU9mOEx0ZjY0NjRNc3Fy?=
 =?utf-8?B?QzdkUzFQSk1XVHNrbmdPZnZzcGNsVldHckFvOHVQZEMzVzBVYUlwUFh4Mzhy?=
 =?utf-8?B?MStTLzd0OFM1Q001OTBaS1RQcTlMRGt4TTYzcEtBcVhVRVMxQ0FBWTNtTGhS?=
 =?utf-8?B?WmRLUk9aUkNOZkZsTC9BUG9FbjhkdDEzM2RXaStUcHFiWmdjUTAwSmxjRTd1?=
 =?utf-8?B?OWRoSnRFWVB5OVNtcXN1d3Jtc1lKRStiaUNlTm5YaDZqWkN2Y2tJY3FsMUNK?=
 =?utf-8?B?dmRqeGJIVlRkd0E5RkNpYlRYRCt0aVpyZjdYK3hOL2o4ek83WWQ2K1NxQ1Vk?=
 =?utf-8?B?aGVQTmdiUVNiK0x4a3U4SXZTVDBtWlAzWGtjbGxOM0NZNm1FWkMrREhKMlZC?=
 =?utf-8?B?bUJRZTUwdkVDNFJHbWJuV1FqdHNWNUJsQjZxQXNXVFVxN091SW13bUJaakl0?=
 =?utf-8?B?bFJ3YlVFZXhHY2dJckVVVzdpMTB4aGhPR1hYV3c5VlE1aTVoN1VWL3F6TDhq?=
 =?utf-8?B?YStMVVk4cUc3aE1tMWs1aHcrR2hFdE9vdE1qYS9BU0N1Qys3aVhhN0pISnNB?=
 =?utf-8?B?Wld0VkxudDJZczV6ZkhINWx6K0Y1RlEzakNqc1ZJQkRIYU5UenVDRE52bmFS?=
 =?utf-8?B?cUl0b0hHWkpaRnlXWUZRSjcvaFNDS2ljT1AxSlBPRTl5aFdVOE9vQmNobnNH?=
 =?utf-8?B?LzJucldZUnVUeU50dzZEREM0Qno4WEtjT091dERNSnVNaUI0WG9OTnpLOStw?=
 =?utf-8?B?WlpUejlNS2pRdW5RRGFzZEx3Q01Ja3VJYkllYytySFFVbU9IRUdteldIVWk3?=
 =?utf-8?B?aTgrQ0VHcVdGVVFBS2lyc2ZUQzhSbDhia1FUL2lGNW5Wd3hlRDZPS0IrVTho?=
 =?utf-8?B?L2x2V29tNjVHR1RuNE1mYVhCOC9rRWlGTktZeE1WK092TzZIaXJpZVVvcVRX?=
 =?utf-8?B?ZEdjWUtjdFJ5R2ZxK3pjWVh5N3pESFlIdzBGcmdGS08xTnJKczNJeWtISEhS?=
 =?utf-8?B?NWF0bDRId1FzbFVrTXAvMlVwcGR3TXAzNnJFb2JYMys1aFJqeVlBdTNLUGhl?=
 =?utf-8?B?bkJCUnllVjZ5RXdpUTZROWNFbHhMZHo5ZHd2SkNqYVdRbkRPVkQ4OVMrUVhX?=
 =?utf-8?B?SGxrQlpYWkoxUS96YytYWGR4NFdhNi9LcWJJeUdvUHNqMHBqeU9LNURBbjVz?=
 =?utf-8?B?RGVUUVc0a0hTMytCN2ExOTRhUXAzSVBBVDF6eUpYdnF0R3VxMUdOdW1VZ2p4?=
 =?utf-8?B?UlMxbCs0OHhwS3drOWtqODZjM21nVUdkRVVNNURYL2pUK0pLa3RCdVhscW9T?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab591f7f-35ee-44c6-94b8-08de32b9bfaa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 22:17:30.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TckpS7F1H+o3fInSxmRzf4vkUUG/l/KhozDWWpS5f1GiW3c1RQwOKkj7kMuy8GVI4uKyJbMhum+LoRQozbr6x0enGK8KGD5/9GLMzRf9Ces=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589
X-OriginatorOrg: intel.com

--------------U4Oky1rYS0kjHbi6LCwgC330
Content-Type: multipart/mixed; boundary="------------umK26AVUEoLbmFREWKj7w3rX";
 protected-headers="v1"
Message-ID: <e3110f85-290c-47f1-800a-9430afed5abc@intel.com>
Date: Wed, 3 Dec 2025 14:17:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 5/6] ice: shorten ring stat names and add
 accessors
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-5-6e8b0cea75cc@intel.com>
 <aSWCQQsd-_cIKucF@horms.kernel.org>
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
In-Reply-To: <aSWCQQsd-_cIKucF@horms.kernel.org>

--------------umK26AVUEoLbmFREWKj7w3rX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/25/2025 2:17 AM, Simon Horman wrote:
> On Thu, Nov 20, 2025 at 12:20:45PM -0800, Jacob Keller wrote:
>> The ice Tx/Rx hotpath has a few statistics counters for tracking unexp=
ected
>> events. These values are stored as u64 but are not accumulated using t=
he
>> u64_stats API. This could result in load/tear stores on some architect=
ures.
>> Even some 64-bit architectures could have issues since the fields are =
not
>> read or written using ACCESS_ONCE or READ_ONCE.
>>
>> A following change is going to refactor the stats accumulator code to =
use
>> the u64_stats API for all of these stats, and to use u64_stats_read an=
d
>> u64_stats_inc properly to prevent load/store tears on all architecture=
s.
>>
>> Using u64_stats_inc and the syncp pointer is slightly verbose and woul=
d be
>> duplicated in a number of places in the Tx and Rx hot path. Add access=
or
>> macros for the cases where only a single stat value is touched at once=
=2E To
>> keep lines short, also shorten the stats names and convert ice_txq_sta=
ts
>> and ice_rxq_stats to struct_group.
>>
>> This will ease the transition to properly using the u64_stats API in t=
he
>> following change.
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> I had to read this and the next patch a few times to understand what wa=
s
> going on. In the end, the key for me understanding this patch is "...
> accessor macros for the cases where only a single stat value is touched=
 at
> once.". Especially the "once" bit.
>=20

I'm a little unhappy with needing access macros like this because its
yet another "driver specific wrapper".. but I couldn't come up with
something better..

> In the context of the following patch I think this change makes sense.
> And I appreciate that keeping lines short also makes sense. So no
> objections to the direction you've taken here. But I might not have
> thought to use struct_group for this myself.
>=20

Right. The main issue I had was all the places where we increment one
stat we'd end up needing *at least* 3 lines. And trying to split or
refactor all of those updates seemed like it would be problematic.

I liked the use of struct_group since it lets us keep size information
and logical separation without needing to add the extra layer of
indirection in the accesses.

> Reviewed-by: Simon Horman <horms@kernel.org>


--------------umK26AVUEoLbmFREWKj7w3rX--

--------------U4Oky1rYS0kjHbi6LCwgC330
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaTC2+AUDAAAAAAAKCRBqll0+bw8o6P/k
AP9jXk/u9I7yHKgtGMx9OHT4sz0Uzo+Wkr/EGCNIhe9toAEAmSc0xMDG5pHA8XPlDpnHBulC8dtQ
VAaJTpYCYTQo+w8=
=xGYv
-----END PGP SIGNATURE-----

--------------U4Oky1rYS0kjHbi6LCwgC330--

