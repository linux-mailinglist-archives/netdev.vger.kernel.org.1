Return-Path: <netdev+bounces-162423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58FA26D74
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB63163790
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253A206F0D;
	Tue,  4 Feb 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4ug+6sC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49E15DBBA
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658632; cv=fail; b=cILYg9SmMullJMmeVAk70BAszq1kToeIoyZhQKqCn2EU6J1N2dhZjdzxm9XcMfTmDyYTR1sF19Q2iAVx9Bv+rJoYX1oXWKNkDS8fAPXMaMc0jIK5Hes9Cbz7v4Khhzbcucboe8SsWm4cu3N5L7bXap/RpnW7r0pGWS2H90zDf/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658632; c=relaxed/simple;
	bh=mAeGLxi90JuDtYG4UlvRQY9JFi1ccScRK7NLF+64Np4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgorerfU8zduC8FB6QwNc1MIt2xVvFWFWr14WrQU/tL9V5L5SjEaANd44xLQ31oO1nodhOZvBgIphP1F2tYb3HOkK+AHXBijl7XPjgnMT33hOCaxu7qTP/aoXt0K/TjF+PrBxuJ4WqAdC9s4Q06C/UX7b+a/ldcsIccf99c+MMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4ug+6sC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738658631; x=1770194631;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mAeGLxi90JuDtYG4UlvRQY9JFi1ccScRK7NLF+64Np4=;
  b=K4ug+6sCzpQ41qXePQqriVWMLsbSWe3adPT+BY4FJbhQFttMhHIbqEuv
   HaLDto2v8W8b6uI3xR6FJ/uuC14kURKGIJBvo9pEeENBGSXcEDr/b+wQz
   JaK35lURd4GEV0i1imAY4txp4MW/jF517SfWUQe+jOtc+/nepl4Wjl3NT
   txw+Bc1zqnuF6KZwMb0s6BVf3IxrtQThTHMI8VOcr7TWV8ies1C3Wrm1H
   SaQRaiVtAJvM7p6Hmt9XiHHpe8TI5aXNHfGmnjsQCmFJ48yBE7liV4r9S
   FKQeZdhM53ReySF25UHVju/jAomCXz9eixOwt/ga81mYAACKG/tj8SSAb
   w==;
X-CSE-ConnectionGUID: qRy8ucOeSsCCkAwWWeyZXQ==
X-CSE-MsgGUID: rg8KQapOSs2EjJRP2qmo6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49824902"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="49824902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 00:43:50 -0800
X-CSE-ConnectionGUID: 7yFdAmefTAiJBTTwnliW6Q==
X-CSE-MsgGUID: BexDYspXQ6KA8JsutKZ8kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133781022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 00:43:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 00:43:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 00:43:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 00:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMq0LCT/1vUuYsUta+tosNDU7C7i+15ck6iwdtQa5tfEMfqIEjaA+MAkug6T48Qi47W63rti9ssL4MMDUe6a7Ufs+D64AOhQ+6ki1ZRzA0QW2vcPLdXsMb432TfMRvKa8hRcEU0ZiYw0katAGjLPj+Osk9Mc4G8Vz5ZXMm76MlrhnvaquyUSn/Iyj0yGxijcvlEvmg++A27FqZxrkXvAsG9Ave1EgJlaeFzgia7JbdusBUyCMgK0HQYDigEj8DUIpS44qqcwmhUNESW5h1sCA2Fx8GSNKy+ab+HjpccU6HhrfvlHlZ+MguF/UyWmSN33oiOqITYOObk5e2ce+cSRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtgZL7ziT4gDzlZHsgvgSKz84SiOhej0HE0VIp2IO7c=;
 b=p5mLlLDLPFmaSaCJH1KgUCoJ6qG2sVtrayTYzLrgLXHPmd/9aUyPIOLaRgmqL3CMmwWLm4nI7DaUSeS1IzZOeeeWnmwyoFp7udWeYHIds0xMkxWyUdxHAnBHTgB/OhLzaGt4WQUjPXQQFXHINbmKtvnu4J6YoBYdRTp3du+3MLRIwX6GB7Ns473InY9G5nRGRDKMZvgkf3+DA43ubaAzCgxzRidYGY7vxgn6wRDFg1Qpj7GZS7/ZtNqFRg15g6nMxT0TQfZxB+ZNDTWNIWydHDztewtbk/mkoBJhefbnmMGt829uA9tqoUgc5jVV1odrrV9gohdUyae810jc9enVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 08:43:39 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 08:43:39 +0000
Message-ID: <63be4b0d-4cff-45d9-90b3-a318ac6e28c1@intel.com>
Date: Tue, 4 Feb 2025 09:43:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net/mlx5: Add helper functions for PTP
 callbacks
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
 <20250203213516.227902-2-tariqt@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250203213516.227902-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0186.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::43) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8bc0ec-75ee-45a7-5fec-08dd44f805a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWRvMi9lbXcrdVRuRmQyVi9kQmhOT2t5OVExM252bDd1LzltdVZyUHdiZEtZ?=
 =?utf-8?B?MlI2RnkwUWp0eWFuRkI1dXRIMTEwV3FGQ0grc2xZWkp6Q1MvT1NzWktYVWFK?=
 =?utf-8?B?aEZxazUzMWtlRjQ3UkFQL1RsU2R1YmJrRjIrNTFhejF1dEhDNGJJZ3I4SEJ4?=
 =?utf-8?B?azFqbHpRaGlQeVR3NE0raEhJamQxV0RxRmp0MWdxcVNNcU5CMzRFbThRTllG?=
 =?utf-8?B?M2YrOHZsQjBTNkhEaVRFRUZEQ0U0dHJsRlRUWXBnUWtNOWI0QU9DSDlMaWNZ?=
 =?utf-8?B?NXdGZUdKTG9pQlRJdXRBeFhnd1huUHBocnNQM3FEUFFrakxuM3hpdXdBbFFU?=
 =?utf-8?B?Y1Q0QzRpUW9rNUxFWll0d0hVVFcwZzZCczhWMmV6YTdaeXNUQjc4aGwzcE53?=
 =?utf-8?B?VnQyVUhkMjVNQTJoNS96UndJYVRFODJweW9WcDZ1b0swKzlHNlgrdk5Vd3V5?=
 =?utf-8?B?NzhnQTZNNW1XdHZFQVRLR3Y3OTNWNWlSbW1na2dEaGpEblVocGJDVXZGWE80?=
 =?utf-8?B?eGdRN3g3eEpEeDFKWFV2blFuaU5PMmxiMzlNa2luNFZzM3hxS2NmRzVaN0Ro?=
 =?utf-8?B?akd6RW55RXdDUlhvLzJnYklBYmoydWVtMGd3cGlTdGVPMHhZN3hBNHBJeGl2?=
 =?utf-8?B?TUdJOWg5Qm5Ednl1WElXOXNVYmlXTk5iWWFzQ2xNL2hQTjhKb1pwSXI2UnQr?=
 =?utf-8?B?UkZ5ZTA1eTJ2V3JSVWpGVWFGYlZPUGZzUGM3Z2dNR3dEb2Y5TXc0a1NkMGJZ?=
 =?utf-8?B?YTlXTkg3UG5oaWRYZW9Rd2lRU1Y4L3huK2dsOHJuTXRkak5JNjlSM0l2R1Mz?=
 =?utf-8?B?dWhSckdHU1JEQkR3MnF2YmM2NmJmNkpwQTlySCtBMjFRNzloY0ZrQmtHR2xW?=
 =?utf-8?B?aGZqVTVPalNYVHRIUHYvNjduSFZhME1HK3EyTkxzc1RpSWQ1akhreVdOL3Rt?=
 =?utf-8?B?S05NRmV5ZThOT1lERVpCM2xUZ2lpRE1wYlA5YUtma3JhMi9ONzI0ZXdPWm9F?=
 =?utf-8?B?djFXdWFQQ1lJYk92dWZxRnlNb2Q5eW9rSjhNVkRra1BDVWRXS3hVSmFGSDBl?=
 =?utf-8?B?elY4aWt0b3kwVE5xMXRJbTNrNGMxcHJ0OVh1d21NeFlzakxoL0x3Y2pqbWF3?=
 =?utf-8?B?Y3Nqa1ZRV2RtQkIrWDc2MUpUa2tLWWFMdzlmZmY3VnFkSlozN1Y3UjIwUitJ?=
 =?utf-8?B?WlFwSS9hU1pZVG9vOGFDUzY1eFg0WHArZ1JyMGtSWFVKQnREbVFNSWJieEZQ?=
 =?utf-8?B?WkhYUC9PRWZvY0daWHgwWkJKb2tveU9Kb1JmMWdyaDVXYi84ZW5wNnBPTXhR?=
 =?utf-8?B?T1pTQWU0QkJ2TkF1TUlxN3FkN09BaTR0TXJPUS9OZEFHZHRRQmRaWHNZK0tx?=
 =?utf-8?B?aGZEeFk4bW41VXY1dSt0WGYzVVJpVGZsYWxWcDBHZDR0UzRmZXoyL0k3VkNx?=
 =?utf-8?B?bXorS2Y1QndtRHpqM3FGS2hONU9vNGNTVGMvQXhXRkg5REtMTUY4OFVHQXJ3?=
 =?utf-8?B?NzlFNVlYb0w0WmpuOXpTTGFpODRJK3o0enNjSDVpQ1Y0dEE4bW41T3Vic0E1?=
 =?utf-8?B?aUFjamZoYjNSVzQzN1pocVdNajZxNWRKMUN1YWdXc3djaVNGNGJDSWdoQTFP?=
 =?utf-8?B?dnJJeHdVOGVjSEppdGd5NWRWZjJTUzZzRXFhRElMdE1kWURZWm9NcmtqUHFJ?=
 =?utf-8?B?SkEvRHR4dXlFd055aDdjMzBjSWhBcEhNQjVOV1E2WXFtY3dXMUNMa0pLTGIy?=
 =?utf-8?B?VUJjdUQxcVZ0ak01UFhOOG1xeUNEckREaVJwNEtIQ3Z5N2E1cmM1a2VzUWps?=
 =?utf-8?B?Rnh0TThkQVJaMytQVEZSbG4wdG1Cci9wN28vQ2Ura2NLQk1VUndMMElDN0dL?=
 =?utf-8?Q?7dmTj+MDrdb++?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5YVnpUTmFUZ0tZTGRvR2hkUDFYTDRZOUd6OXl1WExqM0JOeEE4dGZhVkxt?=
 =?utf-8?B?bDhQWEdYZmhJZkpsUVZNekY3MmRxaVA3eXBHYzl0VUtBUDIwOVE1V3BaSW1i?=
 =?utf-8?B?TEhUbE5kYW5WT0lGd25QenVzQVVpZFd0WkRYdGVMaUh6NHhENU9MdkdQNmda?=
 =?utf-8?B?cS9HbE1WSEtsVHVkZ3BoWFpkZmRWSUlNczZqZHBrd0lVWFl1cGpmQXN1T01W?=
 =?utf-8?B?MmtpWFM5aTRzaVZaejBtMmNSN1ZEeHBuM0txaHBzV1BvQ2NNWFFOZHJ5ZTNu?=
 =?utf-8?B?U1lkS1Y5ZCtDMGxKM3ZDazd0VXYrcjAyYk53cndENjl2NFEyVWRwbS9PeEtw?=
 =?utf-8?B?NVN0cWZjNkYyK1dxdmE1ckxkTmorUWwyNThHeCtWQU1PYndXd1d1VHdJd291?=
 =?utf-8?B?NlAyLzJjK0NrT0xlZ3NrTks3NnFaSVc5SGxLa3hvQUJtZDlWK0RXdnBjTERX?=
 =?utf-8?B?MkZ2UTd4cHVMclB3NFQ2Y3F2MnVPTUJDc2ZlUTRNVy95aDRlbmI4NlhQM0x5?=
 =?utf-8?B?THR4N3lVa0h0TmJLRHo2M0MrMk8xUXV4bXdFNEpzU3NvZld2RVh6RllVN054?=
 =?utf-8?B?a0R4Vjl5OEM5YW9idGk3Y1FzaCtoODFROHNlcnhGU3c5N3czWm5XMU1UdEsv?=
 =?utf-8?B?MzB4U2t3VFp4NEVvRGwrUUxLM09jeEpPai90Y3g0WkJRYjBrbDU1NE5oWko4?=
 =?utf-8?B?dU53Nmpxb2RCdGZOQThrS1VJNnppZ3lSWTBwMHRqeFJ5Nkd4bWhmRE1lR1hQ?=
 =?utf-8?B?MUU2bFlBeTJBL1FpRnR6dHAvMTk5NkNGWXdqZjFRdU5oUG5LNU8xdDRvc1d6?=
 =?utf-8?B?THdiNU04ZUJzTGtER05XQkdzK0NpK2dqMW9oWVJmVXhiQmxEeEZWaXkrMy9t?=
 =?utf-8?B?MkhDb0pieG5PdnBYUmNaWjNKamcxelVCaHQxTWtBdHhNUVdKaFkwT2tsamFN?=
 =?utf-8?B?cDd3MFZFYUMzZ1JuQ3AxZGJhd3h1SHpUTWdzVlFKakNaOUl0cmczZ2ZyUmly?=
 =?utf-8?B?SGVLOXRDTzZWMnNqSE9NSC9Ia0U0a1kzem5aTU1CRU54VjBhT0Z3a0lJc05r?=
 =?utf-8?B?b1E4N1ljVTBoSUJGQVVkSjVwL2h5dm5KRjVmOU5ONUFKNmp4NTlpc1FYeFVa?=
 =?utf-8?B?QmNBcGdUT25iWE1zS0ZzNGFOZUhOckR1OVBZWHZoRGZCMHpBaUdIeCs3dlQ0?=
 =?utf-8?B?M3FDY1pOU0N2RjB6NjByQm1QdWZIbDRSNlRXbXNYMlRoUzdwdGF4Q0FnaVVS?=
 =?utf-8?B?L3FXalZWekhpSSt5c2pIZTZxZXl1YWg3Um95TGUzc3Y0c0Q1UVlZZm9raDdI?=
 =?utf-8?B?K2VzanNTNUhvRzNkUFJSaTlidlB3T2ZSTzIrVlo5SlFCcjN5QU5tMXhNMjdh?=
 =?utf-8?B?aXhzL2V4MEx5aDZEOVZ5SWhXV3dwaklMUytKOXlYWUd3VU5XdkYyTngxanA4?=
 =?utf-8?B?K254N09NbWE2b011S1owM0FvSjFtSUJvU01ESEpRc1g5aHRxaEZGRFIrdy9l?=
 =?utf-8?B?c0xoYkFoWGNZc3liS3lmUm55VHlpVEtwRkJ2VVhqRmxNQXBhMHlWWlNLTnJT?=
 =?utf-8?B?a3JKN3IyRThsT0pvMFhJOWw5bjFEQW5jY29neXRKSVYxU0d3OHNjWC81T1Y5?=
 =?utf-8?B?Y2ZtRGd5czVNalVVa3M3UTVqV2VrUlFzQVZHYk5uVHhSNkZqVEZ1dXhtR0Zy?=
 =?utf-8?B?KzNJTEkvc096U0FZVXZPQVZLS2k4QXFoVUEvT2M0UzhTLzRrelYwNWVXTG5a?=
 =?utf-8?B?VUVFRjZFdkZzNW9VNzdmVE00OTFwbWNhK0lMM2Y4ZVh6d24rN2hReG9RWjNR?=
 =?utf-8?B?UTF1N0JBWU04d2w4MmcrYU5Jc2FSVUM3RkhtNUFlanIvZTRDQzljQWFDSGU1?=
 =?utf-8?B?bzlicFRiWWhNNmM5Rk9ZN0ZINlM5Z0NaTHpsc0FJUGZrYzhlMXlSRGg0WXQz?=
 =?utf-8?B?bUR2bmxWSHpKOFZYaUh4dnkvOHNCckNqakJhclYxbkVyUmkzZjNSbWx4TWdM?=
 =?utf-8?B?cGQ2cFR4TzJmbWpjV0FhZlJuQW1qR0FuMzlvZERKcXJqRHU0Y3pZa3R6Y0xy?=
 =?utf-8?B?ZjNNL014a2JiMFJSL0c3ZVJWejcwblpyNUN1SHFMRUNtNnE5aSt5TEdqRERm?=
 =?utf-8?B?WTBzZklHS2VDQlhFd1NtaStxUlV2bllyZTNjc0xjS2pDVnR2T3h6SVVCdEJ1?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8bc0ec-75ee-45a7-5fec-08dd44f805a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:43:39.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pXrc14jn1CiSRtc5S6fPrKD/P8oBv07ewZoYxfpKppyFEa7a59t7zpfHjZoKy9rGFElCuBKy8ZDGZSN8co6VvWMp25IcPge9J8XeOFV+sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com



On 2/3/2025 10:35 PM, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> The PTP callback functions should not be used directly by internal
> callers. Add helpers that can be used internally and externally.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 +++++++++++++------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index d61a1a9297c9..eaf343756026 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -119,6 +119,13 @@ static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
>   		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
>   }
>   

[...]

>   
> +static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
> +{
> +	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
> +	struct mlx5_core_dev *mdev;
> +
> +	mdev = container_of(clock, struct mlx5_core_dev, clock);
> +

Maybe just oneliner for mdev instead of dividing it into two lines? But
it's up to you

> +	return  mlx5_clock_settime(mdev, clock, ts);
> +}
> +
>   static
>   struct timespec64 mlx5_ptp_gettimex_real_time(struct mlx5_core_dev *mdev,
>   					      struct ptp_system_timestamp *sts)
> @@ -1129,7 +1141,7 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
>   		struct timespec64 ts;
>   
>   		ktime_get_real_ts64(&ts);
> -		mlx5_ptp_settime(&clock->ptp_info, &ts);
> +		mlx5_clock_settime(mdev, clock, &ts);
>   	}
>   }
>   

Only one small nitpick, overall the code looks good, nice rework.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

