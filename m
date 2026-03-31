Return-Path: <netdev+bounces-273678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOCdJ3nmy2myMQYAu9opvQ
	(envelope-from <netdev+bounces-273678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155736B94F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD24630B052F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79359401486;
	Tue, 31 Mar 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7GmJGYu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9C3E928B;
	Tue, 31 Mar 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969932; cv=fail; b=h95GgjjQppUCMESs7gsCH5bkWu+dFIoodneTVXNs2fsJXr798AMgLRsjU+AhiDffkXpTrL5DEhxAnwuyYV1336i2TSMh//VBhYeK2A0rvOceAVDid+yUMf4DSg1ka6J8LhWL0Ifx7M2m3EUydcNA5u9AiGhuO/lHI+FXVToVdQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969932; c=relaxed/simple;
	bh=P3NfRrXRu4A2uwufNRrroIlIzqATdJTbXI36HlnlAI0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDn6NftmSohch1y7PmHMlhRlv29p+ypfED4DvKt1lrkyEWImdm8uTgDzL1FBbBBNA3k2CZNeEPiG33qQwDcAyZBnz3vIMwuuSyNm/ZZb7q8aRsokTZuGH9gAUlvpTzcz/tmnHAXyk39FYwy5TF9Ovd2dTehWdoVagge6uSLLKt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7GmJGYu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774969931; x=1806505931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P3NfRrXRu4A2uwufNRrroIlIzqATdJTbXI36HlnlAI0=;
  b=I7GmJGYu7YjbOHFiTNLpoC6B9GjZ37tCJADeycUIfKB7FdowajJHFpE6
   ph7MyHn0/qY2uuH3ugBJSpHVuQYKHrc8QTLao4kCfY77S/OUfkn23bjvZ
   JMuJT9cM219Ma0Iuf5ZMuO82XXIIvXbP8BxGUNcrSzbzkoAwrqiSBQNSy
   FLnX3dfaBOX/Io547PTDPy7RrRIyJ8xalcmg2r6URUeGIeNTikZxWGiGf
   tKF7Tkvb721W7XzWTz5qo6/VQx3VZEF7gEpXXZgZuTQ41HxSjpsFkv03w
   bi1Dc4pnbCm8rQmL8gsQtJQ6Xyit7ewK5RvS3oTHsjow8FVpz6q0H0fGR
   w==;
X-CSE-ConnectionGUID: 457Xr3z4QQ2GKlkzLGbm6w==
X-CSE-MsgGUID: g7yGZtavSTaGNWKzCgT6LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79880441"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79880441"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:12:10 -0700
X-CSE-ConnectionGUID: sTPhQLesQKKxYFWwt46vEw==
X-CSE-MsgGUID: VOvZqFwKTjuCxUwIIV7gYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="249603701"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:12:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 08:12:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 08:12:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 08:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/RHDgmIZv/F4Rzx97MaghY/EZIAFvkJjtjZco/VYiN6vQxJIQooekjVBlLDG6yEI51WIyl5kWCBWsthttbct235f90Rnsqdo8kS371iYh6JaoWvPR1br7BLHsnAGbE8NEtlKqz5wZwDG9ErF/jOoD8VQHVQFv97otyzPKzURG4hL8VWGd+rLGyljfg9pwefLWFw4h8uqaTCG7p0FodSe1p1/FnTv6o6PickyTPXV7vv9hWcX+m0WVzPqq6PWx8mBDaOetay4uuLoiHQ3gtx/GCMZAB6b4hwbp7z/qYKDkEeDtQziiF1fLsm+dNFfReudUNlJ7FcGWOUIqJRwYkw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3NfRrXRu4A2uwufNRrroIlIzqATdJTbXI36HlnlAI0=;
 b=XVz+HsIMoZ8/xu4swWCCOYoP6GOSmlzh1jbriuGyGqSkZZZUOZNjXI6GSRz1t93h4yUmRdXBUl/ykHtjWw+sjqp3NaXJWssWNc++LEFTWBg7U3QUaesh1lH3mn4b/iehIKobKQ8n1lOIaAHxkbqqIrSumt6w4VM8xs3W/Jxwbu6SWJTxy4O2dpkVpGTrGxrb02pAFxJnazcDr1J87NbXN5CDkeGdo9E63OA0PZ8vyeDmJ3d/OGXliU9RsVVUeNlhdkZSV5Zr9LWEehY1UnLS6i/bQOadO5EMGI/ZCztD4gtQzn9fcFmA2OG7NuJFJEbFCHN/5wjEVWqkzVeNF/9N4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6281.namprd11.prod.outlook.com (2603:10b6:930:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 31 Mar
 2026 15:12:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9769.016; Tue, 31 Mar 2026
 15:12:06 +0000
Message-ID: <bff33e56-d1eb-4291-a3af-121fe54b1539@intel.com>
Date: Tue, 31 Mar 2026 17:09:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] ice: migrate to netdev ops lock
To: Kohei Enju <kohei@enjuk.jp>, Simon Horman <horms@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<horms@kernel.org>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260325200644.2528726-1-anthony.l.nguyen@intel.com>
 <20260325200644.2528726-4-anthony.l.nguyen@intel.com> <aclmhA5yjXfzX_Jk@x1>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <aclmhA5yjXfzX_Jk@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3178feb3-b10f-45da-86dc-08de8f37def0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6slimocX/D0zzjGiRU3G8hFyYUq+/sqS25s+0De9Hm1wHRUiFrwduqgBfi5qzwz41iXgjb8XCItBdxDAsl3I11SFaEtP0c5CFVEWxG6q/IVUPJ9Yl8gGHmdqwTj1eyaXoNEWfy4LuxGnXBLjILtjG9Gm1BVO5wx02QUlUhcMuQTDICNATGTmlmdk+V2sUDMrlugKnFk168YwzzafXe0XVeMTbi6fzJALjcFAUCthtpjBWQ+g0k3CUPbJ3XTvcM17DbGL9TI4HQgrLuIlXcnMmGF7H9+6SzV163OgS06GU0LGXW05Ro9BYnEkG+AGeuxTpGK1x9cwqnnW2qVUfHRpIy6YebyUvBleIsmfWXNJgFuVAT/touiiPISXGdcMEz9Yj9nJx6O6LKO0iIVG41d8E4K3K7wX0GHR9Ed5BO/nMuacj6tCmmOsZ6B6sMyw4vHJYafBgbuaGAihYtNikJjL8b117WeGErD8TJ6OuqusArCsRiILYh1aWZBQSI2NKKOg/kVlMXwB+4EpXY4Ntu37To3gPt30Qx4X1FaaPWr0oW2FhmZdjVMWx+3MabqCpu86Jq2lKSGrRL8O+yA9X6FYkfKhTt/JlpwgBWDFu8aScl8FsRsQ+5PssxMTcE1xeASS++Xxz2YRlYOnDp6H34TD4t/LDdTMk33MmU0Qa53LDebii5m5c+Nen4qCny50yPxQytw8pIj6dB6LBltVdItmk7Dq/zpUMH1ikcXVRljiukY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdTZGNyeXh0VmJwN2xNK1FXeDFZL25lTmVaTjJtTEIxbUw2Z25CNjJjRkhN?=
 =?utf-8?B?cHRhKzZEbHFMMkNmcmNqOXR5aVowcDFuRi80V29oQ1VPRTErNTJuM05BeWxB?=
 =?utf-8?B?dkJFelJjSHEwQW9yWlhoRVl0V0lIRE1GUjVxa3pJOGNxTGRhbWlUeWlzUG52?=
 =?utf-8?B?Y08rY3M1S1JCVjM5cFltV1hDbmlTQi9CWnAzdHVaYkEvUjZzRVZCY29rYnJh?=
 =?utf-8?B?c0dJK25qc2dBY1RncTRnTEo5ckVaYlExOTRHYTZLL1UreERiV0E5cnFnNzJo?=
 =?utf-8?B?QXdCVDdmSFE5NkJLNmxoeURmbGlTRWJYRDN4dWVBL3VheDRLRlRvb3E0YjR2?=
 =?utf-8?B?c2xwWTZ4akQyRm5jcHFYUUpYYXVIZEpHUmd5Y1RpeEE0eW9iZnZCR0x6RWF2?=
 =?utf-8?B?UUIyQ1N2NVhzb1UreHVhREFZOFJtYXN1US9sUEdkeld3alJQRmg4a2RIRXVW?=
 =?utf-8?B?c25uemZRT1U5R09hMk01VEppZldjbkRVWld2OFRWKzB2NGsvTVRGdnVqSCt1?=
 =?utf-8?B?bnRCUWo5R3gzbm9FdzJXVmp5U1MrWjc4dmNTckIzbm16czJKZzBHTG1KZ0U4?=
 =?utf-8?B?dlBlK2RtbjVaMHd6a2dIVUQ0WDMyclZ5NVlOUm51cnM3WVRsbVoyMXZUWWMy?=
 =?utf-8?B?R1FkdWRVUTJubVJBSThmeDNBY1Z5akxHNFRZN0x0UjRUWUxScjFLSzhSWEd0?=
 =?utf-8?B?S0lBZmdpS01OV3dMSlZJQ1VQTnhSeVp6SlRmTkowT2h4TVBNb0JreitTVnVw?=
 =?utf-8?B?b0x0cTZVaDMrdEl1SFhheG9HeTUxM0FDbXlRaWRWdFRsUFd3SGdLWW1VT1NE?=
 =?utf-8?B?d3B1K29tSnJWY243R2hlaWdVVEM3OElBelRURUc1RWE3OC9NNXhQUDJXdldv?=
 =?utf-8?B?L2V4Tk0rTE4zMFRGaXpEMEFibGsxTnhpQWEzeC81L2ZIRVY1ZkJRWkprNG56?=
 =?utf-8?B?cUI3K25oMS9YZ2NTbk8zV1dkaUpvQWVpNGxVS3V1ZURoQjZkQmZCUDYySEpt?=
 =?utf-8?B?Znl2UUlHelVVa0lKTHhFYk9HaEtyeWFNYjNObzd2QVAvUUxpVVlvZmpMeWtV?=
 =?utf-8?B?WUdBQ080SHkxb3Exb0p3OFArSWx2VklyRWJQVVE0cEw3cjNudzVMYzdGaEJX?=
 =?utf-8?B?dEwzSFdYRnhuOXlMRVJjb3Jjc0lEVjBzVGFXUjc0NjVsd3p6U3BzV09YY3VS?=
 =?utf-8?B?d2xwdFdKWk5adGp5Z09ZVzNubXdBM2MrSDdaMFlMRFl0QUVsZGpHS21nczhT?=
 =?utf-8?B?TTF2ejVQQldVd2NoRDF4SFQxejYrYk1iWDFUSTdCaHg3S01RSUVsREhCTmlS?=
 =?utf-8?B?UytacHlhSUxjYXF6Sm0xOFFoREhvSENlRjZ0SG1VcGpKMmRvWi8xTnBsbW4z?=
 =?utf-8?B?SWpsM3RhV1haVWRqdDF4K01uRUR2VS9TeEt2M0JhTkxLZ0hraUp5aEtnTjBP?=
 =?utf-8?B?VldmOFJZMlB1ZHJIZ1Nab3J3Q2RXcURWOTh2ZEZ2d1dpTnBLVzF6a2lkNzY2?=
 =?utf-8?B?ck5WN21Ta2lBWkVIT3NYbko3MTRGNWNZaGlKakhRRHVNV0hqbjdMM253djZM?=
 =?utf-8?B?cXFuM1hWTnF0b1l6YkkvQ1JkQTM0b0ZrVTRDSWh3bGhpSG1yUDNzT2lpU1NP?=
 =?utf-8?B?NDhQdDFXQ2RvZ2J4S1U0bnJrenZ1RDNmamVOZUJzdiswZUlLdzRPRlZuUTZu?=
 =?utf-8?B?TGV4a0RaK2R0dFVkSmtOTC9WaHhwUWJnUHZsdklDeGdOd1gvY0Y3eTBYRHFF?=
 =?utf-8?B?dkg0cjFBaUZlR2kwajVQUm9odnlaZTdrUTZrbUFPaWNtK0NzeEtWQlAzNGRP?=
 =?utf-8?B?WWlFNWkybWJJQ1hXSTdTazQ2cEtDVFJVM0xRcG5MQzVxcmhwYjZZeHdRcmlJ?=
 =?utf-8?B?Y1NnVUpSdjU1ZTdlR2pwWmlBb2FaTGJJZnhjMUdlbGl3SzZDNDkySS81dmlH?=
 =?utf-8?B?dDREd2tncVlYN0FTa3J6ZHhXdytjYTBkZUJ3QzFvODR5TlVQMGdZbmxVY2xR?=
 =?utf-8?B?QllPUFIvODVVZkNCcW1scjBmc0psWHc2R0tRLzBEL3VFM3pjdkFGU3J6bkpQ?=
 =?utf-8?B?Tm1YUjhoai8rSTFPREQzSG44NTdVMXZmMXA0cWFNUUtvSlpyUHZWdHlzVDJL?=
 =?utf-8?B?MmFyc1FXWGhkL1IxRVNubU5RVWNJTGhoNFRqYUNHc0hGUGRSMFlIZ1dHQkpC?=
 =?utf-8?B?eFkvZi9hQlVzdlVhYnhWQldjSE9VbnVETEdTSE9kSFFtZW52N1NnZGxiVUtz?=
 =?utf-8?B?eGhKQWc5S0NSUXNGSkJvd05ocVBYbElmRkZtdWkraytyK0JTZkZraVo3NWs0?=
 =?utf-8?B?V0JYMmEwRDBxVlNPV0QweXp2K1duTTQ5aVFVdmMydzVob1lqcXFINGlneHMv?=
 =?utf-8?Q?MKypcqEwt6qOBsOY=3D?=
X-Exchange-RoutingPolicyChecked: ev859LABoXxZj5iS6SG/zBEgxNcRthbV1r/EmJ1DLWlib2VFOYEBWMrR+FOAXkxyxNkcmvcoRq5Zlx0OltIdRlY0JMexUXGdn8KoWWkLAYtvLyqfB2qD7PhNzEziStQX9+xnXk+GN4pRZqfAy5Hcozgl6KvKyIYpv5rYop04/T50CIs9Azj5kyw8Yt6Ki7zwqVNa/wwCPRChlvjfPqf/UYJmcmGkSSfrkfXttrHnFkb1JOcEs0Aaj+PGKqEY1D417hJK3/32oNmUQM4fvGoCkJvvv3B8L1Zxubj+2E257t5TT39GCRQf81LOF1M10vDwmMO0lejCmYOk4hiPeKECog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3178feb3-b10f-45da-86dc-08de8f37def0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 15:12:06.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwNva+/KnAiqErQh3oSYPxxGyo93qg4rW1WgOR+jHXs1qr/B6SS+dq97aXpXI+z3RoZX8d4YMU9UpnIlEbELCs8tY0gCYau3y0xQQ3DbQV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6281
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273678-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2155736B94F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kohei Enju <kohei@enjuk.jp>
Date: Mon, 30 Mar 2026 03:01:04 +0900

> On 03/25 13:06, Tony Nguyen wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Queue management ops unconditionally enable netdev locking. The same
>> lock is taken by default by several NAPI configuration functions,
>> such as napi_enable() and netif_napi_set_irq().
>> Request ops locking in advance and make sure we use the _locked
>> counterparts of those functions to avoid deadlocks, taking the lock
>> manually where needed (suspend/resume, queue rebuild and resets).
To Simon:

Yes, the DCB code was reported earlier and I fixed it already in this
series. The DCB core takes RTNL, not netdev, so now ice calls the
functions which take the netdev lock.

But seems like the E-Switch code should take the lock, yeah.

To Kohei:

Ufff, I'm sorry I missed one more part, this RTNL -> netdev lock
transition is when you change one bit of the code and then the whole
cascade in some other part breaks...

I'll send a new rev once I fix and test both.

Thanks!
Olek

