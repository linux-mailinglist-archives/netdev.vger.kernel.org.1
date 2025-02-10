Return-Path: <netdev+bounces-164608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93665A2E794
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF13A6655
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB71AA1C0;
	Mon, 10 Feb 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loXjtv+F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EC1A8F9E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179460; cv=fail; b=gNzr/STxswIzzRgGaSAEFsz3n2e98hXu+eAOcuARqt0d60TadE7cmkT5m6PnBORZ3J15bgLwoNxi2zalHCSr2fvOZ6XNnPLso8z76td8H2nc2FhrLXjljnSuEbcVUqrkLE5wgZulKGMhm/4dOoajeN+uprZD85Ike2UWFQot8B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179460; c=relaxed/simple;
	bh=0fNtLN30P47cZJe0HHNGEVLS0HErCiE/lJY15uMGNW8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jKQxOepQerRWZnD29Vk9cs4MZ0CEr3AhUcclvo5nLG/mRviZjiHea16SJOD5LPCuhglJDaR5OjrpNMmTu+DuPbadbSBbEUakRN08iZN0PH3GmesDz2qprGPJemrFGm60uTqBCA5M4/V/C+QMapUL/t9a/gnbC7hhmC06VJJBGnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loXjtv+F; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739179459; x=1770715459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fNtLN30P47cZJe0HHNGEVLS0HErCiE/lJY15uMGNW8=;
  b=loXjtv+FAHJAusGOoyB+B+V3WwI3RkhJMbiZzWi8FyHG0cK8FEGYBiCe
   J11qQpIKUgw+rZdeA8W5Sxhi7rAaEiC+dvcJ6wvxJibljJ8WRB6l2DqA+
   AH1DfaoeHhj4uLVH1wq/PQjcrF83Uaj53PDxxh31e/kBe3KAM3/tRy8/Q
   TOQ5nqG2v9bXN0Hv5QuCmGpqiFtACbMQvRXCBJKUgkfr5tffh7wjtZ873
   pdsEXcDpRBh3HdSmJYqcYZ9c0XUZxY5NpQ3iS93CTSGh487HE+2lKKp6W
   698EePjvYp13HWM/LU0YKRcLvgO7rXwZXrEtelrZgnD8HKDVlSNbEMw+5
   g==;
X-CSE-ConnectionGUID: 4cY3lUuARlORcKSo/NuZ5w==
X-CSE-MsgGUID: TtGQ9mMVS5+TC77DRvpOWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38954786"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="38954786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:24:18 -0800
X-CSE-ConnectionGUID: MbXyKQCKSO6VrzOfnN2s4Q==
X-CSE-MsgGUID: 3ZV32+w0Qp6hVCaEJS0Tlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112364145"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 01:24:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 01:24:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 01:24:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 01:24:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtdQwiFjbL/IHRp3BwXnpU//uZy1SjTQIAOFguFQ2muOGrl1S6CbbFGqMi+u15xbyWT5+lTN38bT0+AkeppK5rMXc/hG2+BTgiqR+MabAwtEwQRYeKBmovrUDAEHzr4ctbJCZtmpmqRoq3cBHL69t6mNB/CNXAfzI1w0euXEFGqVEvggh3hxrl/CEkJmt6AuXZsej1AYeKSSIFCPRUbm4FFlvprPNUa7Exa94yjc3JA+drWK+LbOrOKQxjaDoGCRFZ6a7HYyRwc5VtyS+EE2SlSldWGSC2ysM/E16sFAJYsuCnH33gE++TJTemCGLvYIGyJFiQpHNfVRfprlnslGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivb283+5DBoaJxmAerBdspXFz4aCc2ttfnw6cpOlyZU=;
 b=GD7Z0ykBnDXCTo4UyKWZTuqezWbuNUJsfWyvJ1bf0Tej6WHONn3nXfRWQOsptoAlSlldDXDTMiF0wrq1fX1vzlXOk9HzrxmD3AY5mMRbyg73EoGQdNrOnrUecfDSOB4UHy9QfcHkzZzV6jrexCoQaA123xTdhQt2L58OHYc8goDGKbL+pVOFwX7MjWFKP3KgByf0rr115+yix4AHiIVJO6ajD9gXs/7eS8fPK+X6H+c7bfkExyXKLuv40hZQXr6kwKKoB2pvgkdCTddEg3GjNpF4Q9z6a1F3MszEEkiyVP8HKP+PRlEpA6Vs6gETEtDgTSnD5ZuY/0uLn+cqXlcWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:23:47 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 09:23:47 +0000
Message-ID: <227b48e8-191d-4637-a0c9-3885fbe80845@intel.com>
Date: Mon, 10 Feb 2025 10:23:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
	<eric.dumazet@gmail.com>
References: <20250210082805.465241-1-edumazet@google.com>
 <20250210082805.465241-4-edumazet@google.com>
 <31325da6-d74b-4c9c-ada8-67100bd50310@intel.com>
 <CANn89i+WfwMQnYRRe8greWXTYR8CpUGz-pZF-YW-1B_fM7oXrg@mail.gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <CANn89i+WfwMQnYRRe8greWXTYR8CpUGz-pZF-YW-1B_fM7oXrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::15) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1848f9ba-e46b-4968-d15f-08dd49b49f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejQ1VVJnMXhabWsrOWVMMGhxLzdJckJHZmJPclZQRWpBcXB2ZXgycVRqV1E4?=
 =?utf-8?B?dzlubWlKaGo4Uyt2QkM0QVpRWG9GNjRpSHNOeUNXaitFa0Y1V3phMXBNMUFw?=
 =?utf-8?B?VXkxNVI1N2k3cjZwc3Q2cGplcHRFd00xTkhZUmJhNk1WMGVDTEJlQVQvdUJU?=
 =?utf-8?B?TlMzbmR3Tm54UTNjSXVHTUZxVzBPMXVmTGMreUxreDR4T0hHYUVVWVliTTRD?=
 =?utf-8?B?NC9Sa1lrS1YwV1JybjVXVEdHUnRHVlVSVDZKVktGZGFxNzUxK0NTVXBqYkxZ?=
 =?utf-8?B?RGtNOUpTWktBRnh6c1VHVXp5d1VYQjhCdWJsZUhkWHhwYVFJMUpWMnJCc01K?=
 =?utf-8?B?KzY3M05wUmZDMkdzSDUzY0k4K0tlR3MwRlFlYVdyYWxYV2piVmtPcVIxNEFT?=
 =?utf-8?B?Snd5b3ZsZVAyaks1N2x2YmVtTGVZK2hlTFNsWHhvWEcwMHJYOVB0TjJPOFVC?=
 =?utf-8?B?RHhpSkVac2hNTEFBUzBHck1YVEpRZE9FaGlUYUthT2pxOWxvMFNKd2wyYVBi?=
 =?utf-8?B?cytDQTBxS29zT3ZuMzVyK2dGMjJ5WEhqQVJBL0R4Sm9Sd2NEN1p1WjAyd0RJ?=
 =?utf-8?B?ZEMvV2tQeTJSRi9kcjVoQmlxN0J5Wm9mNnFjNlg1cWtuY2FNUXhkQW5ybndo?=
 =?utf-8?B?dVVWSDBJTWZWQ0QvUEhMTU5IMFMvSE5qaFVKRnhtK3VUeEpsU3ZhVmgxd1lT?=
 =?utf-8?B?eHhaZEpsTDczWU4xMUsxUmZ0MjRGU2hPMHhsQTZjUVNRZ1VaU0djd213TGRQ?=
 =?utf-8?B?a2JzeHFNZnRIYUVWK0trc0NPM2dob3QzUEszNkVtZzh6QWM1UVhTS1N0c3Y1?=
 =?utf-8?B?N1pNdUlxaDNpT3NHUDdOY3NETkJzdlJPMG9Gak4xOGRaUzdQQ3BXVzBwZUlZ?=
 =?utf-8?B?K2lHWjhyNUV2U1VnUUg4YlFxVmxaV013d2t1dFhQVEJBY1FQQ0dvNlFyODJT?=
 =?utf-8?B?N2Z6ODBqcE1JaE1wV2VSOGNvQnJWeUZDa3BzRTZFS0F4L0ZXQ2toVElhblow?=
 =?utf-8?B?UG9BUVZyTU9LK1ZZUlBSV3UzeXJsRFBkT1pnejJsV3FhSzFIYWtUR0ZNZjhZ?=
 =?utf-8?B?Rmh3bXA5VEVCY3RhcExrRERQcS9yaC83Qk8wNE55dFFyZEZTRFdsOEQydlcz?=
 =?utf-8?B?Q0ZyaGFvaUxDUzhYVDZyUG5BbjVFaHo2alFlb000ZGFWOHNORENQVEUwdENz?=
 =?utf-8?B?bE5yTFROQmM2VFV6MzZQdjZlRXo3a2tIMFlwZHRwZ2VnM0hKTWNXRzhLSU5h?=
 =?utf-8?B?ei83ODVWK2p6OWVXdmE2blBiMklpQmY1S3dJanlwb01veU1scEpYT3JRTFY2?=
 =?utf-8?B?dTB5U2hRd1p3d29WQWhQSFd3YytsdkludWVER3FsNUpGM0J5SFFmd0Z6K0Nk?=
 =?utf-8?B?c1ZiRVNnai9oSUVVNkFmVVFxTnpJdFVOamlDOGhFU0kyS3N5RnM3cWlSNXF1?=
 =?utf-8?B?QXBVaFQyVisyYW44bmwxOGVZUDk4eGx4cnh0dkFGK3RJaEFKbFpoWWNwRXBW?=
 =?utf-8?B?bjBrTjY5MEovRm92QUcxejk4SmFadVdBM3U1ZmRBMHBFbXU1Ui8yRFUyL0Q0?=
 =?utf-8?B?cEdkamNTOE4xaGxXZFJxVUpvSy9wRTBXRkZOeDdqcHlobno2MW4wbWdjeC9a?=
 =?utf-8?B?R3pkVzdVcmxaRmFwa1UzOGRicC9hV3prN05GQWxXWHZ6MkRuVkhFcGhQbFhZ?=
 =?utf-8?B?WEoySTFwQndpendrWG44ajVZRGQwM1Y3R0FuQjFLNVFrdEJXelhRT0VVYzJM?=
 =?utf-8?B?NVVnZFFqZTJHY2g5OW9YalYzNTh5bEdtN0I5NFE1NXpXUTMxd09uQmhrdXFT?=
 =?utf-8?B?T2s0cXFxTUpQYStDUFh4SEN4S2gxeFYxWHlJRG1BbzltcFZNUGY3UVRXQkha?=
 =?utf-8?Q?URBwqD4yr7UNV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThyZU0vL0hWdEF3dE4yRzhwZ1pBMmtVcDZNK0hyUGs0MGd0K2oxaGVuMFlD?=
 =?utf-8?B?Nyt1cUlJZEx2dCtlQlhZTkdOajFKOFJ6SXdvWmZ3UThTZElyZTZUeXFuNnFI?=
 =?utf-8?B?cTZVaCtncjRwTUdtTU9ZTWd4Mzdwd2xyc2wwbDJUQnJKck8zdDRZMUZ1T3gr?=
 =?utf-8?B?NGJGNndFOWsxKy9DbFNuK283M0E1SU9KWVRDZWRSamdkRTRSY3RKeWlJZDZ3?=
 =?utf-8?B?ZHAyb0xzR1dBdEhzeFFITVlHdk5lVXdPR3N3L09jWTdOdncxY2hkaExmNnlJ?=
 =?utf-8?B?YXRzNzdaeWtIQXJ2N0ErTUUzUE5BU053N2ViTWxrVDJ2Sml4S0RqNjg3Z085?=
 =?utf-8?B?QzVzYm9BU1Z1NG9OM3o1cHFXL0JwMEtjWnhwNjN6cEMwZVd6aytJaFFtU05P?=
 =?utf-8?B?NElYUEFKQTJneGplSUJCMy9tM2d5eDFoRXV3eHA2Q1dYcjJTdUpTNVhzNG8y?=
 =?utf-8?B?aGZvWnFJQlBST1YzSVF4emxPTlAzcWU3dlREeXB5L0s5QWZOM05XajVuci93?=
 =?utf-8?B?ZHRoNFdWNU5jcHNHSHFxYjIzNzZDV005NFRKcngzeHZlWE9qRnptOXMvRGRz?=
 =?utf-8?B?MStqWERYWFhiTDVrNERObTlWTWpCUWVxemtVcXQ1czc4bm5kWk41NExwd1BS?=
 =?utf-8?B?a0lnWk9Fa08xQ25uQ1o0dkwxWGFRV2xBTVhqTjNuWnVBZ2dpSjNZd05QdThE?=
 =?utf-8?B?Q2JoUmE4NENJckNSZldweTU1S0wxcFh6S2JDdEl1dDEzSUJEdTdjS1JPVElv?=
 =?utf-8?B?aE01MHBJZnd3UkRxRzJJLzgvMCtNd0xPWmRtZnZVTnI5ZWhjY0piWmJuaTAv?=
 =?utf-8?B?L21YcFh1ZDV6TGcyR1gycVgzd20yTitDTkE3RytFOFdCZUVubjc2L3pKUGk2?=
 =?utf-8?B?dTd1MHlWaS9adWl2Y056VGRTL3ZialFCK1VzLzEyUjFZakpBTW01TlVyQU04?=
 =?utf-8?B?L2gwdTJkdzZSVFZmTk5hbk12U0NHeHBydFE5a3h3bzNrdXpsOFBDUk13ZzlU?=
 =?utf-8?B?NmswVGhTZVhoTnQ3M2Y5M2lkbExoQ0dBNnlrLy9WTlVSOW9SOHZiRzk5S2d2?=
 =?utf-8?B?ZEU2SVpvOWRiNldWL1YzSXZnckZtY3dMQ2FjM3ZFOGc0RWg4NVhRNFZ4N0lC?=
 =?utf-8?B?eXFvbHNGMmNMSVN2akRsTUVsM1hNODUwV0xpNEw1VkwreTNIU0Q5T1VuMGZI?=
 =?utf-8?B?Yk0wa3hyNE5Pd3ovS0JHckt1cnYyVkFiK3JFS2FtZmRTSkZySkhhRGEwYWNT?=
 =?utf-8?B?NWhBNlZnSWUzV1BRSDBibVNnM3E5dVkvL3dXckxUQk50a3BrTU1nZlpITmJw?=
 =?utf-8?B?UElWbGcwTHNTTGtZSzR3NzZBdXZGS3BCNDd0R21UcDdHa0pPWm9mME5QYmU5?=
 =?utf-8?B?ZGdYcGkzbWppbTljcmNOLzRjdmhKSEFWVUlqbnR6UEVBSm1WZHUrTHlDMUsx?=
 =?utf-8?B?cFhOOTF4M1VFM05nM3VNUWVwNFRKZmVYdXdpSnc0NkZiUHUvK3laK240clN5?=
 =?utf-8?B?YWxCdW94cmNhdFU1bTVUMHgwMC9od2RZd284dWNOOVgyRjFyelVWVUxYNytz?=
 =?utf-8?B?cGcyMUtwQzJrNk5xclhObUtJU1JiNklqcmtKbUx3clNMd1k5a09FZ3ZMMmhS?=
 =?utf-8?B?ZFdpQXg1aDBWeHhVWVlrMThPRzV3ZVU0YjFDWlNmREsyWDZBTVkyeEVqMVly?=
 =?utf-8?B?OUZ3TSt0L0RFQ3YwdldWbngzTGxydGw2eTd2MG8xMkRHNFQ2bzFUR0hTQXov?=
 =?utf-8?B?dDltWTRDakU2aVpwd1h2b3Z5S3hJNnZ0WGt1azN6d2pxZjN2SFh3NFRTaE5w?=
 =?utf-8?B?a2VwbndnU0ZET0RFQUZiK3VkQk5mcEhRaldWd2FWVEk5bTJRcGM5MmVEbVV4?=
 =?utf-8?B?WUVsbkVrRlRXcktrSGpFSVlsSDdrNmpWa3loMDVWeEJPT2gwcUcvVnZjamZY?=
 =?utf-8?B?YVJlZUF5ekttZVhJYjBZUUdQTmFEZWl2c0tZOFIzMWxlOW9tYzBxNFdrVmdP?=
 =?utf-8?B?T0JOR3I3cUgxV0Fic211NzFpQVVvV0RmaWw4U1NDTTlJY1RDYnN6V1lScWhC?=
 =?utf-8?B?RFZOc3kyQW9iOVBzQWNuNkkyV0xMenJJbnFYYkNJWGxlM3hNUHYzQ0JQRDIx?=
 =?utf-8?B?S1BtdFBQc1VEUFpnbHRXNHcvTUIzanQ3WXNzY215TzBOTkZtQnQzTG9FeGgw?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1848f9ba-e46b-4968-d15f-08dd49b49f54
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:23:47.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KTSNu7J4pMpnRvb/A1rYVLSFu0BEdNqPx+I2MNFj6JKfbFxlFYoSLLmvGqxDr0FzchGL1ztIsxrOkMRI3UdONiXYTFNVfnNCaGm09MEH/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com



On 2/10/2025 10:08 AM, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 9:41 AM Mateusz Polchlopek
> <mateusz.polchlopek@intel.com> wrote:
>>
>>
>>
>> On 2/10/2025 9:28 AM, Eric Dumazet wrote:
>>> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
>>> to be exported unless CONFIG_IPV6=m
>>>
>>> tcp_hashinfo is no longer used from any module anyway.
>>
>> You also removed EXPORT for tcp_openreq_init_rwin function. Quick
>> grep shows that it is also not used anymore by any module, so probably
>> you forgot to add this info to commit message? Do you think it is worth
>> to add?
> 
> I forgot to add this in the commit message.
> 
> Not sure if this worth a v2, because IPv6 no longer calls this
> function after this old commit

Oh, you are right! It is not used in IPv6. I guess it is not needed to
resend the series, thanks for clarifying

> 
> commit 1fb6f159fd21c640a28eb65fbd62ce8c9f6a777e
> Author: Octavian Purdila <octavian.purdila@intel.com>
> Date:   Wed Jun 25 17:10:02 2014 +0300
> 
>      tcp: add tcp_conn_request
> 
> 
>>
>>>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> ---
>>
>> [...]
>>
>>> @@ -457,7 +457,6 @@ void tcp_openreq_init_rwin(struct request_sock *req,
>>>                rcv_wnd);
>>>        ireq->rcv_wscale = rcv_wscale;
>>>    }
>>> -EXPORT_SYMBOL(tcp_openreq_init_rwin);
>>
>> Exactly here
> 
> Yes, thanks.

