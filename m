Return-Path: <netdev+bounces-216900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8508B35DC8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B12C7C68C9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874F2F9982;
	Tue, 26 Aug 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6Q5KCCU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743621D3C0
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208786; cv=fail; b=jeXy+Tin0kUY3QY43g7K1z5IYfTsWDSpBr+NRWU4r+yX6gUqEz+h6jRjL9eMw64BfJBQGzxHs7zKJWbF89VoBQst4g9TOQLzgPxK7GVwQ6C0bPgO1ZKuDTT0suGc0iRVjaien3Bz4qNi9MJNEspP9DW2o6EOl40vfy3PgEhO3VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208786; c=relaxed/simple;
	bh=k+6lZsqe+bjRjEts1CMtvJJWzTO0veXBj8A5Z92x7w8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+6AB4qX6txegX7+N/JbeZDNwIBxr1Cb62UoRCDXW07YdlmBGnehrGTA5PSQVgSR9JKqKIRvnKAofwf/bDt0eC4W6Ww2uT+NMv/zmXSKtvDgB08JoV40XlJuhLWQeBEm77ZWCy5ZlDDUjEaRAB/VpNgm6YtbexDVW3TfXtjBIyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6Q5KCCU; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756208784; x=1787744784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k+6lZsqe+bjRjEts1CMtvJJWzTO0veXBj8A5Z92x7w8=;
  b=e6Q5KCCUfLzaiIvyHQ73NF3r6VvRrsrzpYw8iqmlCeNH7L6xvlo/Px+R
   c3Oh6pChvj26IJUHztuB6Da63nylplTif8/7vhqpV8GFk8qY3VmPfxbVz
   XjsEjUstoEh/FPQeT8csdjd6IADM0uDpIRZ1kfnktiiovwZdQlE76rG/y
   TV9TiNrhBWchuoPsNrblK9RTMxNOEfgxYCysbHe/vRS8ZXu+HfrL0tWXZ
   sRHK4LYhTnMDe2j0Yo3bsP9tPTNfyp5cL+x9cwB13zNFZ4RlrMigp1Ci/
   fqkTmFSNBNe87YTToBH7SiTcWbli3mR9IrHy/APOS3SPCLU1ELM9za2GM
   A==;
X-CSE-ConnectionGUID: WnenVvyMT16cbDvFvTduTQ==
X-CSE-MsgGUID: AcRJDX4KTKSCf5fHJ2K6KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62271328"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62271328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:46:23 -0700
X-CSE-ConnectionGUID: E3UJdEJWRxGLfV7aKe9+dw==
X-CSE-MsgGUID: 7C/nrYL+TzGp2Y1+xs1IxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168784628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:46:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 04:46:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 04:46:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 04:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6MkYtf4B4ESz6QYH0b6HEBuwB5m3HehMQPKD+m4CTcytsdhYiumFAtzKcRY95SQY1lc6vqsKWSV0MtdzFYBmuRkVz3QT0t6zbJpUGK05CD8DEXFu4yawaLLUg0Pesdsum0YvVkIOfEj7QXbJwCU1CGJBeNpzaIb1pb/m9u3BfZr6jdfhSazTQNokKPZn5UMRAC3yIoqkHRXzFxTtyUStkPV1hLN6kQZUlTg2cYhOhYhgAzfMgy7EaNq19AQXSoJlu2hLRSHgQK1PnQ+PMIPWqW+9zL9xNByXbb+yEZy+6lzXRfr5xAHC7qQNam1erDiwWvd85xeG0JS4RtzB1S0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfT/bTIVvdEdV3PJuJehYDEMz4GZIH2nN6muUyhnGDw=;
 b=jWifZ1ZHQitLWuUsFuzEM+bYt5VlcN/H1kgheOMDhqKxsxiYJ1j/ru+YiEA4AueZbp6rNJvuLYJwHAbibV9Q0TxVabR7rdZrPNLFZVhTmL5ln5pBMwAKCFkUv8Kb34wsvlkk8bpIODGow5ok8sdqXZADmakXYBFcSD0yAzYx6lWZRVW6lQLP+eQ6fLzdr9qDpzozayEgzdAcQk9ObvCyYtpJMHUbcIsNTI9oxEkVicrZUUNfKU4dWjfe1V0EV2QyZR1w9kbycw7eL14YEP0SNmdAhT49+PR13u7SFbN81M3zOU1GX96Gp2TE+naX1BqZZr9oU9o0bGD4DO/MZFlJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 11:46:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 11:46:20 +0000
Message-ID: <99edd3f0-5b58-4cdf-a421-b4f2cf2b4369@intel.com>
Date: Tue, 26 Aug 2025 13:46:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 1/2] fbnic: Fixup rtnl_lock and devl_lock handling
 related to mailbox code
To: Alexander Duyck <alexander.duyck@gmail.com>, <AlexanderDuyck@gmail.com>
CC: <kuba@kernel.org>, <kernel-team@meta.com>, <andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
 <175616256667.1963577.5543500806256052549.stgit@ahduyck-xeon-server.home.arpa>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <175616256667.1963577.5543500806256052549.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f2a442-a5c0-4829-7a62-08dde4962cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE1NK3hsN2lKS1YvWDkySzkrVlBib29HcjYzWXRqM2JFdEduSTcxMjFhWXhC?=
 =?utf-8?B?bTYrSVVjYTBPeXJFTG5pK1NwZ0ROeUVjQkorZzNWNVR5ZlZNbThkSHBwYTNw?=
 =?utf-8?B?Sk4wR0ZWMitoTzd6RitxMjlaOXM1cHI5RkRJZmN2T20xQkkwdFNJbXVtdVdO?=
 =?utf-8?B?bzh0N0ZhNTBBK2VGVFhIRExkbnpRMXpBa3FHQ1hHUno5MGRZY1BHRWZQT3pH?=
 =?utf-8?B?Vm1UdlVmSFpyNlNkc05jVzR6RzRLSFJYVDdleGVRc1lkdGVpTVNpWGpMTXRU?=
 =?utf-8?B?a2U4T3FwUGxpVWFIWWlBcjQ0MmpCSHEwQzFkYkNRTXNZQTRtankwdXFBcFN0?=
 =?utf-8?B?N1Y0aFpLdFlUak1xL3c2TEw1N0Z3NGdXMDBEM2VOVGhuUU1EOENTbUh0V3p5?=
 =?utf-8?B?cnFySzNkQkdJYjBJTzcvS3BpR2lSUld3eEhSdGxXc3RxYStHbEhORnhKdU01?=
 =?utf-8?B?S3FoOUo1S3dZaFd3czVMdS9NcWFmMzF3UzlidXZ0cjV1dWYvT0pkMG53UlJP?=
 =?utf-8?B?UDRMR205UDRjSXZpU1B4VHRCOEV2SFljTU1DL3IzWTIycHA1bVI5RklndmJo?=
 =?utf-8?B?MjYxRjNNREJWRUVjcSt3ZUFGSmhDRkc1ZDNXWFJ2Nmoya0RMZ2M3aFI0bHBk?=
 =?utf-8?B?TTJiTnV5cmZBanJnVlpGeXdibHpPdXpWbFlJVW5FQitpK0RoQ3hhZXJSMzk5?=
 =?utf-8?B?cm8rdXM5VHdnbFk5T0hRQ1AzWlpBYkdRc0NVZCtZTFRhV0t2M2dLbTVMVTU5?=
 =?utf-8?B?ZlgyRVZjUlM1THRGZWNpNklRWG4yWEpOZWRSYWVML3AyL1NRS1A5OHBpVUpm?=
 =?utf-8?B?aE0zcUNLM21IdmdUbzVoUzJqd1VqK2doMmw4d281N1p0Q0lESHhMN1ltY01u?=
 =?utf-8?B?U2JqQTIrYlo1K0JyTzkvSjZBdzFHTnI3OXJuMTlnSENLQ2x1QWxVVUNEbkFB?=
 =?utf-8?B?bTNjRFJ4RGZzR2Q5TlEvNitvRFdqZlp1VVJvME92ZEw2amdDTDM3eHE4WWs2?=
 =?utf-8?B?TnJjNkNVUzVtRlJWTENSMmhYTHZZTVdkbmFJcmFuRWZCK1lHWGg1ak1BYlJx?=
 =?utf-8?B?VXZtTFVsN0FkdURqMDNMbFlXNFM1Vmd1cnVzTndlVjZES05HMGlTZTJtWFdq?=
 =?utf-8?B?bGNqWm1BZG9VU0RnYXBWMDYxWnFYNlEvQTZFUHh3OW1hQjlIZ1RraWhYbm9G?=
 =?utf-8?B?YVo5ZnJ2aTRUaFNDWUZtYjIyc0JNZU1jRkptSmxwZEZaZHZSYjRZdWhjc2FG?=
 =?utf-8?B?YTFjVUVXZ0ViVlAyK215cU9rRE9DU0tEY0xHQ2ZYdTZ2YjdzK2dzNkovZmd2?=
 =?utf-8?B?eER3UDA1NDNVUVVnMTRQOXhLMzZCaXluVGNxRFNlcnhGdUVybDJhTVNzc1hk?=
 =?utf-8?B?cFh5dHU2WVUrbWNIaDBUbVhhdFNJaEJXd1V0Ni9IMEFRMDR6TklubnA2LzFy?=
 =?utf-8?B?dFZtVEJhZUF4WXZEcXp2azQ2eldZMmVvTzdOekZUNnF5LzNNSm81eFl2TVVS?=
 =?utf-8?B?aUx0eUhkQnZqM0dCNnNxdUVkSE0rN1lEdkhsL2VrNElrZDFkaktuTDEyaWFv?=
 =?utf-8?B?T3lBWGY3bTM1ekNkc0ZXK1NlcjV0dUdBZnNsSjMwOXZ5dTBXS2VSWnZuZVFS?=
 =?utf-8?B?eWZxQ0JiWnVPdE80OFUzNWxzT1dlYWczdzFXZjBpYlNzTEpBbDhvZDVwVFIz?=
 =?utf-8?B?WmJySEIzcmpiZmNBWFNxb2l3cE9qK0dFR2Y3Ulp1dlJ5eFNOamZibTFMMVhG?=
 =?utf-8?B?QWJTMnBsVlFhcmNYU29JY1pLMHU5SkEwZllNYjZNTjU2RVY5VlE2VC9yWWNT?=
 =?utf-8?B?bityTmlNSklsL3g2L1dkRXdQSll6T2p4NitKNmM0VFFzeWRxeElrTGNwVzE5?=
 =?utf-8?B?RHFiWktncDVQMlRjL0hUS0ZvTGpISHJxQTU3WjIrZTFDVWFwRmZjZkZaaDcw?=
 =?utf-8?Q?iDWaEWl/2K0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHk0aENxWVZuMlA4V1NIQ04xUTdEMkxtcjljU2hGSE5lS0ViaVZUUnEyWlJ5?=
 =?utf-8?B?Q1NlUFUyU2sxNy9TeGc4UE5YZzZrY2YxdTRtNVN2MWgrTzFkNTd1emNydTJs?=
 =?utf-8?B?TTVqODMzb3hRM0c1WUd4cnJ3dGtJZDRMU3BGRkREN1V6OVl6M2t0Y2VPNWRr?=
 =?utf-8?B?OTJTd1NRbGt1MVZDdVVScnYzcm1zWUptRFFUKzBEYkhEaGNCYWkySUZvMG1F?=
 =?utf-8?B?TkdXMG5icjZyNldkbWZRdHRWWm9NYlBvY0FUTXJIOVExTnBJK2c3bXFuTDAx?=
 =?utf-8?B?Q044aGlMT05ic1dNRmFTNytKaGUyOGwwK0VPcngzQmhvQlZ0US9Ld1NOZzhz?=
 =?utf-8?B?bmdzRE5zeEEyWFhVbGhPNTBMOW5rcEdJbUxORnIyb0pYM2xaUGJwaXhnRVV5?=
 =?utf-8?B?UTVHbC84bUY5TU1CcjdhaUdJRDNHOGJTQlQ2ZVJNMkhxRHNBRjI3TDB5YnVG?=
 =?utf-8?B?My81cEtyWVZ5VzJ0VVNzalpDcUpPeWkvK1E1WFR5cC9zakZQa2RXanR3SjdF?=
 =?utf-8?B?eGVxSHMyRE5qNnJ0TnZBOGtZV0R2VDhtdmxnbVVzeUh3bW1TVVR0NXdiZHJS?=
 =?utf-8?B?d3V2TTU1Uy9XZ3d2N05HdUpPYUdGZlFxTTR3eEh4dEFBTEVCMCt6dTlIUjZX?=
 =?utf-8?B?cjBHRFM3RTMwV1F1MG55RmNNUi83RnBzRnhlMVRhQkhpaGhFSHRFNDduZU1v?=
 =?utf-8?B?M3hMZW5BRlFYZllYTnlxNlBsb1lOWkc1UUtBUEttTXN0Z1c5M00xY3k2cDRF?=
 =?utf-8?B?cWFIYW41ckJUTU5zanRmRHpXekdKdTE2UXg5M3k1ZTRpL2t2TjlER3ZZbG9C?=
 =?utf-8?B?R0xUOS82d2tMRGNGRWQ0N2M2bVdlakdsZ3QrYzJmcUdlNWJyM3FqN3R2Vmtk?=
 =?utf-8?B?MDFCaEtaSlNzdnl3NCtWWTVQNm4wVHlSOUxZZzUwQWdwWmd5VTR0NUIwT0cw?=
 =?utf-8?B?bThBK0NmRWl6NFQ2WDlCZUczMFR0SWMwbDVsZHlpOG5ITDAvREgyZUxGZEJl?=
 =?utf-8?B?TXE3WkN6OUFyV0tlRVhIOFd4REdGNmpVb0ZSMHJhNlBKOEhIQnJVOCttMk5y?=
 =?utf-8?B?UjMrRjRpK0lQaFd4QzF3aWxOQ1ZaN0VDemZsblNOR1VHSk1UQXNvRHk5bGxn?=
 =?utf-8?B?VFRiYkRiM2dGVTdwYlF0QnZCMzJ6QTFnMmkzbTdPcDFoSDJGc0tiSElZNWJ0?=
 =?utf-8?B?WVcvUkhHd1ZCa2NFdFg2MFZaaDNoeTVLYjJSZzZScUYwQi9vNVJ4OEo1YXhj?=
 =?utf-8?B?d0FXUUZ1QUs0QXB5SG92NG1BUSs2bmRrdjBHYmZpZjRidjhHT1dtZlh0TUpw?=
 =?utf-8?B?cXJ6dk5YaW5VRmEycWFoV29FNzFBejVpMFN1dlhHWUJWUTUzRmZqcGRhdytx?=
 =?utf-8?B?ZnljTkszdW9RUkFwcUFHWEREMzhQNUtFcUcxeFhtd2taSjhEd3g1aFAxYUtP?=
 =?utf-8?B?S2k3OHhIdmhLeFhmMVlHaG5KcDVaZXZsWVdWa0NXbitxOVZjR1JmREUxSllZ?=
 =?utf-8?B?MU1XY2REWUFGekxMb0VGSDZyOE5DT0NyNUhVZWZjaUh5bURDdUpBYmhpWnBh?=
 =?utf-8?B?UmVUMWM1QUMxdjdtc0c0Q05jdjVRWWtjczV0WDIwcmZNeFZSdTQwVW1oL2NZ?=
 =?utf-8?B?bGFJWFpHSU1lRVFIeVRvT1hzVDBQc05ZVTlyS09HdzB4K1FqQ2phMGRwMW9B?=
 =?utf-8?B?RE9nSGtpMkVpRXZTeXVjVHNUMVV3c0lHUEtyYUhPaEMzWGNwU2E1TmhpalN5?=
 =?utf-8?B?RVFUMmNxbUN3czljVG1CM3RhVUtFc2tGUmFVdHpZZFpib2tnbXVnZ0RIb21n?=
 =?utf-8?B?aUxIU0VVVCtZbmlBN1BuWWx2Rm8wK1B4b1hrSEdWOGpXV1NneUZQVXNoYXU0?=
 =?utf-8?B?Q2FRZ2Vydm9jdXVYQzBwMnlzUTEyQnNPWVpGbFB3NzhLYzZvQ3hoSzJBekky?=
 =?utf-8?B?VnlWWFdEWjE2Z1ViU2xobU1zUXIxWVNreUlFUFFUZnBMcjhZZ0tlZ3JCQnNE?=
 =?utf-8?B?S1JnQnd2SktSNFFtaWNDN2VtMzhvRThoZzE3UFZSdUh2Wlg5ajhSZWV5U0dw?=
 =?utf-8?B?a3JBZkdmYmxVb1ZzL3lVaTRYeWlieXV5dlo3ZHJQenhva0Z1U1ZQYm1FVE85?=
 =?utf-8?B?aWxseEROREFLYmtCamtFR2QyandoeCtXMUdISDV4VEE0SzVjbks2K0JzdEZl?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f2a442-a5c0-4829-7a62-08dde4962cf3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:20.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoE6BzkSV+S7jidgG1QOOe0QZ0j45zO8arCTQ7kFlYgyJFMCXj+52DgkDm+qJz2/9vj+WkqOCaBS/I4KKeYMmRbwTKIcJGYFq89o+AeQlxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com

On 8/26/25 00:56, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The exception handling path for the __fbnic_pm_resume function had a bug in
> that it was taking the devlink lock and then exiting to exception handling
> instead of waiting until after it released the lock to do so. In order to
> handle that I am swapping the placement of the unlock and the exception
> handling jump to label so that we don't trigger a deadlock by holding the
> lock longer than we need to.
> 
> In addition this change applies the same ordering to the rtnl_lock/unlock
> calls in the same function as it should make the code easier to follow if
> it adheres to a consistent pattern.

it does indeed, with the added benefit of calling fbnic_fw_log_disable()
w/o rtnl

> 
> Fixes: 82534f446daa ("eth: fbnic: Add devlink dev flash support")> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/meta/fbnic/fbnic_pci.c |   13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index b70e4cadb37b..a7784deea88f 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -443,11 +443,10 @@ static int __fbnic_pm_resume(struct device *dev)
>   
>   	/* Re-enable mailbox */
>   	err = fbnic_fw_request_mbx(fbd);
> +	devl_unlock(priv_to_devlink(fbd));
>   	if (err)
>   		goto err_free_irqs;
>   
> -	devl_unlock(priv_to_devlink(fbd));
> -
>   	/* Only send log history if log buffer is empty to prevent duplicate
>   	 * log entries.
>   	 */
> @@ -464,20 +463,20 @@ static int __fbnic_pm_resume(struct device *dev)
>   
>   	rtnl_lock();
>   
> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev))
>   		err = __fbnic_open(fbn);
> -		if (err)
> -			goto err_free_mbx;
> -	}
>   
>   	rtnl_unlock();
> +	if (err)
> +		goto err_free_mbx;
>   
>   	return 0;
>   err_free_mbx:
>   	fbnic_fw_log_disable(fbd);
>   
> -	rtnl_unlock();
> +	devl_lock(priv_to_devlink(fbd));
>   	fbnic_fw_free_mbx(fbd);
> +	devl_unlock(priv_to_devlink(fbd));
>   err_free_irqs:
>   	fbnic_free_irqs(fbd);
>   err_invalidate_uc_addr:
> 
> 
> 


