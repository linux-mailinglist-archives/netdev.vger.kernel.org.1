Return-Path: <netdev+bounces-152196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910B9F3102
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185C818838E4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D61C54A5;
	Mon, 16 Dec 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2gjM3jC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08A1E4B2
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353924; cv=fail; b=CfTaSBvBpZBFcIxZ+IEU9R2LaXi6z321qPBWIa5A7p+Gmsgw0J6QfCRw4oDQMGNxfGh8Pt536cdGFmPYQnNuAiDyB4+u9YPgbX3LWZjmu/Px6++J+4zaF0yZ/xQKl1S0Yss1Yx62XAOo+78PksHnL6OV/A2/mB9YcEpAA+AF1ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353924; c=relaxed/simple;
	bh=sqRHIpShzCpNX7FXvBbBTwHPkPPDmmEEpSHY2SVjKjQ=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QIXGf2HcLesT1sk9yMMzrbbwYCpNmQ10DHTjJ/YIfWNEpY61lWpbKdeszVzsNofiHld0h6OkA0u3/8QF3t4cRWABNxboANcmo6C+u/Mgg/jEcYonSzBFXh2P6q4yX9WsGFsMS8N60bKKcArposSuKfaAASxNtkYULDyUp0V906Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2gjM3jC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734353923; x=1765889923;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sqRHIpShzCpNX7FXvBbBTwHPkPPDmmEEpSHY2SVjKjQ=;
  b=B2gjM3jCpULVvQ8RxbUABRf+IWR/0Y36KSk+j90J/sR/SqpMUY4ughJT
   jubigCHLysne7wFQXk7ge7JfWT9MeIw++fR6XnqQMY/CxX7W+G+pxjC89
   +Qd93YlbtKZZHJEVfSf4JXNlVUs9sMVIbYvg5z3kluhxuDP0hf67klNd+
   7xLsI0j+HaFKCqeTEvjcTqi/Ixu0EMcqPSsyqpiICKxWzkAwOPjP3fkLi
   E3UCLfVnA2z/L24heQXH91FP8jOVx+tact4KrbBUrtkogBcX2zX6IOdXT
   e5QXGN9VIuFKyam3FwfUJf/m6iIiKD2IErMRY2AAg/HtPRfBGdZI/grmp
   Q==;
X-CSE-ConnectionGUID: kyp3IAMLRReEj1JpeOx/Zg==
X-CSE-MsgGUID: QbrJ/MNuQWC9WKik94zYSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45344525"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="45344525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:58:42 -0800
X-CSE-ConnectionGUID: gpKLJeJRTu+mxkjwDKf0FA==
X-CSE-MsgGUID: 71Y3hPA9Q1WKGyUPLbJ4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101767472"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 04:58:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 04:58:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 04:58:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 04:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXIsgDBGLMa2E5oQNBtLy1X0d7qD5NMCshfsisC+4kDMKrdGB7niRgRkXm/1HfurnQfJoOP87bIEfuqGq3nwtem1eTP4DlRxkRt53avY68Lc0XRoXIKQDeni4UHMb4ipiHoCTG9gHcV60qoE/ZEI0AAuCPD8RgXt5K+nsPfSuqjUPC5kXjQujrxvH5nYbT6jT3tZE/sib0V3o0Hh2Ui8W0VEMLiwoiaQtwx/H8x+HDp8QInbaRcSdGD/UzthBwJ9EwoXyNKW6sWYYJ2F+T2RY6708jZjntSDmk27pJjS3No3SZsz1oxFm9oaZnV63IkI3sHJBNGJ+ieTpztQ3QCW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaJNGqZ221yX59VbGPtztdFBxefGAUlWr5pJ/gsUxGQ=;
 b=dRYYFQ//lA7RKkzvel4tPaj/anBse22oXIMPXCUqgNV679pkWjRiCwaNE9Gqs4wnS34LzxSBq4q/SoJVNM1X208OBXqD0f9OqppgvsexdVtBgNXKYdI/8bPLDK2wJD62sSqNK1GM04cbwOZbLsf7aOIeFleUAS9WDAIfxVXmW3CxjZPTDvb2kfjgBsvnLRVaN4LL8UL5mYWWT6nXBlhX4Nyv3VI7eg1UN7JRREQXZrChc8IHtxwpjhyXGgztJQhRU+lP1GZV2hhHADl4cDSNx1Mn1DGAIjbrIAwpMg+VuDZU4NtiQpQOHlPM11ZNTlbVUD6ieryRQXFZ2IVsIiygfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Mon, 16 Dec
 2024 12:58:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:58:10 +0000
Message-ID: <03a5bb84-7af1-401d-8ae5-8f043d511540@intel.com>
Date: Mon, 16 Dec 2024 13:58:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] ice: dump ethtool stats and skb by Tx hang
 devlink health reporter
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <jiri@resnulli.us>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, "Knitter, Konrad" <konrad.knitter@intel.com>,
	<netdev@vger.kernel.org>, <mateusz.polchlopek@intel.com>, <joe@perches.com>,
	<horms@kernel.org>, <apw@canonical.com>, <lukas.bulwahn@gmail.com>,
	<dwaipayanray1@gmail.com>, Igor Bagnucki <igor.bagnucki@intel.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
 <20241211223231.397203-7-anthony.l.nguyen@intel.com>
 <20241212190040.3b99b7af@kernel.org>
 <2a71791c-a73a-4a3c-8573-7b80d1c39d57@intel.com>
Content-Language: en-US
In-Reply-To: <2a71791c-a73a-4a3c-8573-7b80d1c39d57@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b64d91-c456-4d08-6539-08dd1dd14b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTh5aDJCd05wdTJJTWdFcXFYMGs1N0RHL3JZUFZpcExxUk9RaWoxcUY3bjhu?=
 =?utf-8?B?Sy9wNVU1aUdLeUEvRTM0QkhMWVIzR0p0WnFLK0ZQR1lGbHdaRmJibUFGTlFn?=
 =?utf-8?B?czY0aVorN0NucURNeks3eWEwUmxwb2ZsVkVDdUFBOUN6ckZ1RCt2a0dSOXk0?=
 =?utf-8?B?YmNXZjNnZ1RtdE00Ny9yQUhLaFBpV20xSHBQejA5UmhLdElBck11R05Nb2c2?=
 =?utf-8?B?SGFjMnd0U0MzNWhDVnVUd1NtYjRjQVZ3RXVFQTFCS3JrRzJVTUF6YnVFODN3?=
 =?utf-8?B?akVQckxlL0ZpRTBwYVV6THR6WGpMeW1kS0RWV3RRNjRnL2E2NEpaZG5iOUJu?=
 =?utf-8?B?NkYyZ3EwbXc0TjdaSmFkWEs5Vm9lNmxyblJKWjFXS3ZQUGFlazBremVXbnho?=
 =?utf-8?B?K2t1WjFzb1pUWUZqblZ4S1YzTWxxZ2hRNkNTeXNUR25STyt4SUVqaksrUU9r?=
 =?utf-8?B?eW1ubmlDb2tWcjR2bXZqc0N3TE8waDAzclRUNnBjelRyWjZQR2dYN0ViajdJ?=
 =?utf-8?B?dERBR3dNbHRyblR6Zm5za3dFaVhkVXI4NjhyNHhBVnpNK01YZzc1NjhnU0pq?=
 =?utf-8?B?REFuR1hNaVRxRklXL0VpSjRBM2JQZXh0aXkyd3VydnZBTWhoSmR5WVNGckhu?=
 =?utf-8?B?eU1LODhWTWkxZUhlaFh4dDlFRDNTUC9qMjVvREtNM3BBbE1BWEpRSUVKRk1E?=
 =?utf-8?B?TDFsS2dOWldzV0FtMHg4WlhOSzF4RFpINTFkWmFlcVdnNWpRRERhSUNjMjYx?=
 =?utf-8?B?dHhsSTR0T1lQdUp5NFJleVNwWVl1MGtFbVFMUEV1M282Z0hzelBDbVlvUitw?=
 =?utf-8?B?Nk1MaXpTV3EwTUt0dXpyQmZOeTVLWnJ1bnhMTW81aGhRVHVNRXI4MkhVbWM1?=
 =?utf-8?B?dUg5UW1INHcyL0QwSzhCTzhwVkh2bVdnMEhhdS9DcUs4cTlVT21zNzN5Z0VZ?=
 =?utf-8?B?K0dVK0ZTb09aVWVxQS90NUZkU3ROSlM2eGFqTllUSHIzVU9NNkFHYU41TFpa?=
 =?utf-8?B?UUEwV1E4dzlibzgxSGRWLzVXTDhSQ0xuY09vdmxtbGZNa2ptY0YyekFEbnNj?=
 =?utf-8?B?Si9ISzhKS3pudnM3QldEUFo0U0lLT0hBUWphQkpNT005U095NWJUSGJzM0Vk?=
 =?utf-8?B?OVZGckNuN3o2YmMreEJ0QUtFbFhPT1F5dzNXZmN3UHhMZkR6UzhuUzhBSWI3?=
 =?utf-8?B?UE43N3k2WFJySVQ4TnQ4Vi8rT2hLZVVNRkp5TkJpQXRaR1d3cEpnM2FnQmN3?=
 =?utf-8?B?S0xoZHVYZk5pQys2bXozSWY5SFQwbzY4cGFWaGtzVUd1VG5pNjJDTUdacG5Z?=
 =?utf-8?B?WXVkTEE0YzNFYXVwNVpRTmh1QnVxbjNCUG02YTlqdmpLQ05JdnVsYkdDUmph?=
 =?utf-8?B?U3FEQzJEWWhOTjRMVHRxNHFidHV1cHdNK3FZbytwd0FiNHBrSkFPY1NJaUk5?=
 =?utf-8?B?dzZGdGlzRm1HUXBTN3FyWTg4OEZYK3FQR1J1SDN6Y3lkL0tQdXl2NUN2UTh2?=
 =?utf-8?B?V1NObmxXRWVmL2ViN0E4VHd0Rjg3Vzk0V29mMkR1Ukt0YXBhWDFaVzNpNUNC?=
 =?utf-8?B?ZENUbi9Eb2xNczBWYVUxd1hmRkUzdEhhKyt2bXd0NnErQTYvMjVqMVlBaWlo?=
 =?utf-8?B?REg0OEhYVUxiZVBKTnBwU3FocU4vQmJLMVM4MnBwNnBqeEhCbElkUmRYQU96?=
 =?utf-8?B?SDdyODluUlVPNzZaRnNrbDE4MzI4SE9maG16cEV1V0pUOGlwSEpZYytRMmVB?=
 =?utf-8?B?NDVJVktCMVJERTdOV0FOMVdXYVEyRkpkK0todG90bGcxRUh2NWdkR051Zm1w?=
 =?utf-8?B?aXFEaGg2Q0ZzU1lOUHFBMGlVVGczaHNJOFFwZTJYYnM3TGVYZkY3Z0QyWitK?=
 =?utf-8?Q?RXVimtiYVJnF5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJWMVpDODJMR2haRGJvSmhBZDBQekxab1I3anRwcEpKZW1MU2E3aWdWaEhn?=
 =?utf-8?B?dGY3SGRQRzBRMWRtL0JKWWtkcXRtM0FCUGhNT0Q4QWhkNUVhWHBwT2FsMW5s?=
 =?utf-8?B?UzlrVmtEcVpjdWt5b0FKaU03c21GS3QvUDhUTHdvcUVhOXpidnBxZlJycThG?=
 =?utf-8?B?TXNydnBsS29MNWh4b3VVMk9IVm1pbkplSWY4RDNWMDdtc2w0YzJST2hQVkVs?=
 =?utf-8?B?a2d2S1BHelVMSVhZNmRabWtDVWdzYWs3VmdvS1VnVno0bkZiSEppMkU0ZUlO?=
 =?utf-8?B?OVRVckJ2NXpuSzlnQ1ZTUkhxVzZhOGE0NDRWNkVwWVh6UXJjWC9vUDh2QUho?=
 =?utf-8?B?V29nMkx2ZnovWEFRQ1l2WThtRjhIUFlCRjJUQVllQXREOUluMDl3QjJwUGJH?=
 =?utf-8?B?TnBGS01VdlNYcEI4ZWI0MExQaGwzWEQ0UFZmNUR0UnhPS2Jwb0h1ejdkV2dO?=
 =?utf-8?B?MWErd2Z3WkpNY0Z0Yi9MMEJMbHpQajVsYnFTVEpoZWdRSGs5OVM4eXZsSERW?=
 =?utf-8?B?bWJETFJxZk5RSjArdW5UTmRwQ1VRRXZscUVielZydGtrUFRXenNCY25RNTZv?=
 =?utf-8?B?WDRkdHlPeHhueHhTUjROdU01MzBzdldjcXp3S2o4TVM1ZVdMcnJRV1NOeHNx?=
 =?utf-8?B?bXl0VzRWVnVMWTFjRWd0SXBnNGlJQVFMZFVwZms2K2hwOU9hME8xMHdPeUM3?=
 =?utf-8?B?RkkxVVJ5UVFLT0NSWVNHaERpN2NwNERCTkNYQ25Yay8yRzBIV1NVNDlJYjRj?=
 =?utf-8?B?WlV0cnFYeDVlNEVvY0RnQWZHWld3K1pGUmtqSHpYMDBKazl5QVBZenNYNkhj?=
 =?utf-8?B?WElXVzVqOEFJZHJNZ2swN2Zxa0JNWGw5RTZVVVZuejFaRGtuakR6ekdJWWhQ?=
 =?utf-8?B?OEQ4RFNzVmxPSjN3WVpGM25RZzJGKzNESGc4bVpHV3JVcXZtVUl1WHZpY0cz?=
 =?utf-8?B?a0hJN2VHcFZ0RmRVQitwSzhIRUdSQXVncGlVaFgvMFZDSUo3T1l0eTBSWnJH?=
 =?utf-8?B?QTU0bnVBcDlPMXdralZ4aGVXQkk5SUpVZTEzVDBvZmxrTVlIYWI3WDhkRkJB?=
 =?utf-8?B?U1dXSkZEOHJaSENzdXRUenZJR3lGek5NTFVPTVYrM2dvanB1b2hCYjNLdHRp?=
 =?utf-8?B?eUVQVFVrbHpoZCtKNzJ5anNYM25wRTZlcVZxQUFtM2JjNnV1dFRGcWJJODF0?=
 =?utf-8?B?aDFpRHIrcWN0T1ptOWhKWjNDM3NwbWtoZXpPVjdKbFc2S0IyWVJwQU9XUDAx?=
 =?utf-8?B?dlA0NTVtcFd3WGZZQnVTRzNISDhMVGZMRWtUdFBPSjc4LzVjRVRYdVV2RUtM?=
 =?utf-8?B?bzdNWTVtL2V1dkhjNi9tcVhvWXozN1FPdjFPY0JRY3UyeG1pd0pFUU13Mkp1?=
 =?utf-8?B?VytTeDBYN0p6cUhhQ3ZLanA3MTZiV3EvRTNObDNWeEdVb1BTT0V5RHpva1FX?=
 =?utf-8?B?d29kbk9RVTlIV3FTNTVNU0VBYzZZQ1BPVnM2VkRQTHJMTTVmOTZZdnQvNjJP?=
 =?utf-8?B?V0QxWmdEeUdqeWIzNFVUVFNOdHBhcVJDVHorekRiNUNpYng4dmxqR0hzUGkz?=
 =?utf-8?B?RUZyTksvR2NyVVdZbWp2MDdoblJsd3hxZ2MzcXhjVC92WU52Y1VCMEVTWDIz?=
 =?utf-8?B?QTgwOVRVeWFrTVU5WGZaNWsyWFZYUzFRczBaYktyR3kxbWpkK2xqTFRWVlBt?=
 =?utf-8?B?czBXY0pLWU16ZnZvYVlseXkrb1JqejBXZ1czZ1FkZHJiajQxeCt0OWppV1BB?=
 =?utf-8?B?MHVCV0FhVzFCRk9YYnJUbExZZWlHSnJHS3NEQmNCekJoNkRaaEphMk1CcVFS?=
 =?utf-8?B?eDdMaGJTVEtKWUpZeHVaZFRCVVhmeG14bDIwTXErbUcvRFVkS1Z6UXZjMy9I?=
 =?utf-8?B?RXRyTHVORjI4UHVWNEpLYks1NjRtMWpyNDIwRWdMcDZ0V0N2Vm9sVXZTR1U4?=
 =?utf-8?B?RmNNTXpYV0kwdDhRb3VQdGlDWVBTZHlLMEt4YkFkQ2tpOVVJaGRhTmdzK3c1?=
 =?utf-8?B?bkJLWDFLZmVxeC9WbldicTFoQ0NtdEtkR0Y4cjY4ejdoNkxtNlJxWHZBcWxL?=
 =?utf-8?B?eFFSZXppTXR2Mk81MUQ3TjMrVzdrQ2NCZytQd2t5eEs3SXN5NkJKb09sYm0v?=
 =?utf-8?B?Ukc1Nkg4a0QxTnd4T1ltSEtMS1ZFaWxzcWlkODhIS0EwbVlackZpa29WbE1E?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b64d91-c456-4d08-6539-08dd1dd14b39
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:58:10.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0Uv59Rz72ipPDBbSdABIv2dx96kG/vTJquEC9GrcBlw7hfO48SmgrpkQYdAh7C93Mu3cxGaPcY2RJkuMVTnoCAzC2GfskXr5ZCt9dJvxFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com

On 12/16/24 05:53, Przemek Kitszel wrote:
> On 12/13/24 04:00, Jakub Kicinski wrote:
>> On Wed, 11 Dec 2024 14:32:14 -0800 Tony Nguyen wrote:
>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>
>>> Print the ethtool stats and skb diagnostic information as part of Tx 
>>> hang
>>> devlink health dump.
>>>
>>> Move the declarations of ethtool functions that devlink health uses out
>>> to a new file: ice_ethtool_common.h
>>>
>>> To utilize our existing ethtool code in this context, convert it to
>>> non-static.
>>
>> This is going too far, user space is fully capable of capturing this
>> data. It gets a netlink notification when health reporter flips to
>> a bad state. 
> 
> It really pays to split your patches into trivial vs controversial ones.

not so trivial for git anyway...

> 
> Will it be fine to merge this series without patch 6 (and 3) then?

we will have to resend, so I will remove just ethtool stats part for now
sorry for the noise

> Patches 2, 4 and 5 are dependency for another health reporters that
> Konrad did:
> https://lore.kernel.org/intel-wired-lan/20241211110357.196167-1- 
> konrad.knitter@intel.com
> 
>> I think Jiri worked on a daemon what could capture more
>> data from user space ? I may be misremembering...
> 
> We would love to read more on that, then with more knowledge revisit
> what to do about our needs covered by this patch.

still interested ofc


