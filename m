Return-Path: <netdev+bounces-97876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7A8CDA2B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BE41C20B2E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A521362;
	Thu, 23 May 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bs0wIfxb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976C849C
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490079; cv=fail; b=tT1Sz7R5hnj7tmKnyQDJorILiHebVWwMg3NM3sRPB/BeC5sjmp8Pbv0wxFnuL9YJQb2/wRd/1LrM9lAI7BlamxZfcT3c3TQBdXRI23XXN0o8m3xmncACL5PRDZ2fwj38mlI9KMO4xNEzF+w9eByuLcwLL9JTRYgOAH9HDGIhOn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490079; c=relaxed/simple;
	bh=H6V4PX/QGaElrlv2j0wiZ/IoIT1yuZUd0iTKfqjZrHs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ln+nbfaXqIHh08yDn4i1PdtEbNA5bY3+2GlU2kUTIaBqny5F2FUGN8KV23dIAd8UWORtlml2xX72df5Ql/oV9mhMnprwMsGyj0CELOMW3acelOrqTFVnV2VtaqtvGP8vISPBtYULZBKYzqgnuH32EqialiG2h7LuKGaUV1Z3+6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bs0wIfxb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716490077; x=1748026077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6V4PX/QGaElrlv2j0wiZ/IoIT1yuZUd0iTKfqjZrHs=;
  b=bs0wIfxbGRapgkTfskSlqdPg4IPeHSsZcJ7us0DM5eF2no13jvXEzZ2k
   mY8YalgMVRWHn4habr0/0BDZ3NvJyb7iTu+tD/3pdV4KF/uSOh8FgZZv/
   J0pW8b1JZMBhl2pfJ+zuwhXKYQxZBycQlGMps0jq44TNZ2ZUWGmQ5RoCM
   /qyWN/4Qf8YPxIXBZtwHDMLbVjfyHYemtrHwXtoXvAodQcFaKfZCv3cNy
   70oSCr1mTj3L5OmySW49ki+40Fmk1fwjI3TaT8bwtvOg8Y3N6/YVYHZeC
   iaZ/GOkL2WSy0FoeVDwZNorOkUX8hh8ufUrBJOHvVn02cV/WTFY14UITM
   w==;
X-CSE-ConnectionGUID: xAYJC8iHTw6LQp/7oJYSNw==
X-CSE-MsgGUID: eFfqB1VWTQC92KG3Ox6U3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="30365963"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="30365963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:47:57 -0700
X-CSE-ConnectionGUID: j2Tf+U4iQze9cdwrboa1/g==
X-CSE-MsgGUID: U/0GUWo7TTSq+IicenKNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33883608"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 11:47:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 11:47:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 11:47:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY+9GMlSu7W5ndXm+k503e0VpbrkUjwYITIjGf9xMoPoIogufW5IauuzC+KYjfmor3527tWJSvHouWUgC7+dlZlXDiwVNvuDFppASGkgQltM7184cMU6Z8WRDW+Y7Hj8kfTkoRCybJSyj38m/BYoqi2v0wOj+Jqt1jG9w6PP3PajPPUQ7k29gr2K7Wlzj0ljWvj4YrbB/kYAbJyuzku7F31umDYlJpMuK+QXGmilQPu2CW0wvCJFZNlr04U86EDolnWMDQiSonHEzIntW3Tuz9g7WnmiVk0jYsQ0sbGv8majKBB3pdt5vnB/ouAWAztqUtDlm89Q7dM1vFAYXzodwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9QTX4CwY3Z6aTP9KBUTd/ViQiyo7Fti91ZfLg7PUms=;
 b=L3DE6jL280PGLMvTzUUEbtXgwTM5BbGGfP98zKGsfkh0ZsUdgQ+3HF2GCkwiVs+CQMf/agrcQlxhd2YIRG8gDVfR28VZKOfxjFy7mBrLS3rYjbc10cAcnbRIhRPyf35nhfltOpx0j7cWB+qVLzgVsEqXsVeBHEyuaf0XP3QJCNgzKJxSL5V5yDj9fgqe6upzQcNRrb/2ryfe1/sDG55OjxOLPr+2Tm8ganwCSnJ1PtOGghvac33QzWzVJVEd0b8V/LkuerIX3VEPABdxBAxBLHOTbt2L9iQKjiUNE2eb7rtfoItElXKFeoUprxZFKnTJL3b/aODHk/vzZdpXjZ+PZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 18:47:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 18:47:52 +0000
Message-ID: <c9ba7475-ffc6-4e82-b2f1-74fd295060ee@intel.com>
Date: Thu, 23 May 2024 11:47:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: <kernel.org-fo5k2w@ycharbi.fr>, Jeff Daly <jeffd@silicom-usa.com>, "Simon
 Horman" <horms@kernel.org>
CC: <netdev@vger.kernel.org>
References: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1d7458-f50a-4ce3-7947-08dc7b58da03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blFSVTFsdkl1UTh0SVUvQTVpMGY2bi81QzVySUlPQlJIZVJ5S0xxWTBBWklG?=
 =?utf-8?B?U25tdlhYSTdNWFlRaTM1ZGROaHl1bWtPM0pJaWlTTTlhZ202YzJ6cTFlcDV4?=
 =?utf-8?B?TUxnSDJRL3hIY1kvcDI5bHN1ak05QVNkb0xVMWdhamx5cU5JeC9iQk1zUE10?=
 =?utf-8?B?MnkzMjJVMkhMaytjRS9zcm10cDBMS1VrVnNNbXVNOWIrd3UrdjZ4a0p6ek1V?=
 =?utf-8?B?Y2c1a0NpODRrUVAyYWxMR1htUEpSSDRpU1FEMktWZE5yWHBSVGYvT1U2aHBZ?=
 =?utf-8?B?U09DRDNKSERZNGtHOEtHS1phcGVBNGQ0VS9mdHRrUFUzWER2eUh0N2owdnV0?=
 =?utf-8?B?NFFmcDllVytMTXBCMytsQUgwcUxoODlDYndTcVdSVHd2ZHFMY2svdTlkRi9q?=
 =?utf-8?B?WkpyUHRHS2hJcEdUL0RTcVpCMEJQM0FwTkhFUWRTRjlZdlcwbkI0VWxaMkVj?=
 =?utf-8?B?T1Q3bzdhT0VPbW5YZTVQRllmY2prWXBWb0FzVTNyZUhPY3Vqb2t2Unc0Tnht?=
 =?utf-8?B?dkJjYmJBMlczTXdPYWs4MDV5TjVTSzJXNEFaRlVZRVZHc2FmZFE2L0ZJamQx?=
 =?utf-8?B?VlBqYWlnVnMxZmt1REVlOG44WDBaNkxQN29McWJvTm5NWXk4VzZXaW40dnBE?=
 =?utf-8?B?Q20zSEZueW4reW5TaVIrVlZhZkJkYTBBbzViUmdFZms2d25pamp2eGRGVndJ?=
 =?utf-8?B?QnRYeWtGSzBWelJtOEEyTFZscmIxZCtOMnZwWDBqM1kzNGtNcjJTU2hIMVBw?=
 =?utf-8?B?RWI0cHVubkpjYUhDbXNEWTZGMmRKY29zZGhRVmxkZDhDSE1MaEpZbjRka01U?=
 =?utf-8?B?SmJiR2JoUVpuQW1pN2o4OU5mWGNTcy82dTVvRTdQS21IZjVZN2xLZERNNWFE?=
 =?utf-8?B?V2Q2SjdHVms1WlNMc0hKaVRVdHhlR1FFVW43MW5uc0tJSzA2QUhpR3FUUmpa?=
 =?utf-8?B?Vy8yZzkxZ0xYOE5BMjEwWlcxTklubkZzelpnUzg1UXhOMmM2OTVrNzBDQlYv?=
 =?utf-8?B?WFZCWnBxclM0Z1NwWDBKYi9BWnBZMElkbHNqd1p2UE5HU3Z2cXNRbUtnS05M?=
 =?utf-8?B?S2lCN0RDK3dFcFgwbGMwUE1MNHNhak8wMXZuVDdLRVFKMTVydCtlNE51LzEr?=
 =?utf-8?B?ZjhhNThidy9kK2tHK0pPRFZwYlFqMlRMYkJudEdFRjRnbTBOOGJ4RjN3aFVO?=
 =?utf-8?B?dnd6R3pMNlA4bzRMUWVLSGZla2s3Qk93M2lVb0VzMUE3U2ltdldnbmdUcCtQ?=
 =?utf-8?B?bkdXdENJODluZDZJeGRmcTBvNCtMbzVvK0k4K0l6cnhFR1lhREUyaUIwaFJs?=
 =?utf-8?B?S2pFSS9seEZ3Y00wSHNxcmFWWjZRWUdjOElPaCsyMHVnN3VFaVdldmQ0cDE1?=
 =?utf-8?B?U28xUHFYTGZBTDZUK3o2eWU0Q0pOQlh0NXFraEVZLy9yZHNNSkZTNkxLWGFM?=
 =?utf-8?B?RW9ITDViQXVZaG9YVnVzenhrNHExbXJLeWlKcWJCQWk5Ym5WOGIyd1RvSjBx?=
 =?utf-8?B?MW1GdW93aG9UbE90R1NVc3VjTGsrVURrYTJxNnZkc1grUUdZNFRLc25hbDVo?=
 =?utf-8?B?QXZRNDdyYzRDSkttNWRZa1ZJWnJSR2g0OVNMdEZidVdDZ2w1V3FHWExIN3F2?=
 =?utf-8?B?QzdwTk1EbkVqS0kwclhSUGRkZURGNWlDckJxTE1NU2ZrOXdrenpOeS9YYnpR?=
 =?utf-8?B?U0tHY0gzSFRnU21JQkhSamhrVUFHV1lXaXZFWXNhSGhkUWxyWkdFWHh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNGRjFZRmY4OHphZ0RlbUZ0ZklEWnI5ME4ycU0rQ1pTQUIyMEdjWWsybXBv?=
 =?utf-8?B?K1ZpUDRMbXRNNFRwMkRYWGdTOElTMEtwZTBQZWEwbzduM1Q3VFVyRGxyam5l?=
 =?utf-8?B?WkpRT3g4MmlyZlgxMytMNE9YOGZZV3NWenBIUEhRYlRFenp1YXQ4T1hlcEdI?=
 =?utf-8?B?V1FCRmhhai9xMjRMRzViU0dvcGdlcEc4MkJVTGluN2I0ZGpock0xMFFPalNM?=
 =?utf-8?B?VkY2YVpHNytHSXVjVHQ1eWdBcjYrMXZxTVJEU1ZNaVFrbmRFYzdpRXoweDVO?=
 =?utf-8?B?ZDMvUm5Wb0lFTjd2dVljVmVudjFFR1hNTldzaTVycE5nNnh5M2o2Ty9YZnQ3?=
 =?utf-8?B?akxnQ3hjSkVndDZSSWxWMldGWm50eUNxWG5JOFhNNW1ya2p2VldmblRFYzgy?=
 =?utf-8?B?K1dvZTk2Uzk0TnZiNlpucUM5NlNoeERkWHhqckMxMGphYmVCME9kR05tRTha?=
 =?utf-8?B?WHAxbnNFd05TNEhOajdMMXFWM2hEODhtMXVUaFY0bWdkdmU1REpxS00rcHZy?=
 =?utf-8?B?WE5zQ1NEZUdEL0ZsZlMxKzJGNzBseldWcms5MG5WWUNhdWV6cFpVV2Y2SmJC?=
 =?utf-8?B?N05RNitTdHlUdWNtejhhdzZaQy9rVVhneEdNTENWQnd3R01IaDRDcUEwaVBV?=
 =?utf-8?B?b1J3YnBPNkQ5RTd2MmNJTTRmMU5ySk55T2pPWDFid2FtQjhhNnJJQ2tGSVMy?=
 =?utf-8?B?V1dXTzRVTFkwemQwTXorcFlCOFd4NVVlK1VMeGYxU2txRC9yK1E5UXlHbkg0?=
 =?utf-8?B?WWU5SUtwN3l4TWxhWnJPMXA1SkJWakVxRjlibkpwVFQ1TGJja0pGdVVLajJo?=
 =?utf-8?B?d2dhZzY1RE5KTjFBbnRGSEc4dVhQTXBFT2w0cVZRRUhQQmM5VTUzOTMyU2Jx?=
 =?utf-8?B?OHNYUXVtQ203dmQ3MFhBNHlsRkUveG4vZkw0QWhiY1hTRHhscU9IVE5UbTc5?=
 =?utf-8?B?OXRYRE1WV2k4amxjU1prQzAyMzBKSVZxaVBHbUYzdlZWcS9LK0lzZ3hublBy?=
 =?utf-8?B?YnM3N0d6eitpL1FKRjJHMnNFT0ZOejdRNTh5OHA0dnh5dW5mNE5XakdjVkJZ?=
 =?utf-8?B?S2diVU50QmRtcnJORW1RU0lNUU1aandUY0VUWnlhZVpNaXFid0w4dFRjNCsr?=
 =?utf-8?B?Y0Zyemp5dkluWjF1RENKWWF0VDNURHZ2djdNY1pVanRCYVhvbmdld0tjenRt?=
 =?utf-8?B?MFhMaUdLQ1JrbktJUFFDN3BmK01GUCtNeWE2dU9STVJ0L1o2VkZaMEd4Lytq?=
 =?utf-8?B?WEdGT1RlaVkway9kZ0kvSldBOEY4M1JrWFk2QWl3UWEzSGZtR3BmbWV6Ymo5?=
 =?utf-8?B?bmpSaEpqVGVYcklnTGxLMlU4UXdKZjlDbmVnQWlQMUxydDNrWFR1Mm4rUGJI?=
 =?utf-8?B?YTd6STBaVHVQUWw4TmljK25ERGtSVk1nR2dVWUJmZW5jdTFPZWxWd0s4eTk3?=
 =?utf-8?B?Tkp2dGg5TVVncEFwUjZzbFk4REF4SUIrQjNJSDJIWXJWRHA2WEJxeXpSN2J0?=
 =?utf-8?B?S0o0SkFTZWRMNWdyWFMvSTJuamdFa0hzVmJ6T01GN1I1Y2pwNFNzcGxzMCtm?=
 =?utf-8?B?Y2d0QnNNeUR5SUxhZm52WFhJblRxcnNsNmJudXVTTjNCSWNCYnQySFBtbElD?=
 =?utf-8?B?emYycU9Temc3MzZleGp4RHgxNGFDWHNwVmphUGUra0ZQZ25yWWxSOVlKZVhV?=
 =?utf-8?B?ZWVwdGFxUWJUN0ZGa1NNa3FVbUZkZFB4S0p0NWJ3RExPaGFHRkZ5cW44SlhX?=
 =?utf-8?B?bTFoYUIvVVpmNlJPN1drM1JEL0dsSnRuNmtmelJHenJNZDdNM2xNcEJ6aDZi?=
 =?utf-8?B?dnJXdk9GOGFhdGxqbDJUWU1IR04vQjRsdkF4UnppNW5BM2hJZm5xMzhtcStT?=
 =?utf-8?B?QkpOWmVYNkMxd3JHN2FUeUx3M0tsd2Z2bHdtemFPTWtINDcyLy90M0JBYzBF?=
 =?utf-8?B?WUwydnJyZ0tGVGU1dmU0N3R2eTFOQ0kybzdQVlZPYWJjMWUwQkhQdEpOUjI0?=
 =?utf-8?B?Rm9SUlMwSkFwYlhETmdpUTB6djBrZlhoWEZ3NXdVb1ZCekt2bDZxRUd4Nm55?=
 =?utf-8?B?bDZ0bUptUjhET3ZNYmZrMFd1TmV2KzF1Uk80dHhzdGtRNysyZUZWcFl5SGlu?=
 =?utf-8?B?eWF2cWMxc29zVkRsNXVWQlJvODBEOFdqZW9YWlRrNlFEdE9ONlMvbndTL1Fw?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d7458-f50a-4ce3-7947-08dc7b58da03
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:47:52.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or/HUWiufXt5vSwCajct74wBAYy6BVuEDzov8IL0e2w/3/kyZxgIwbTsDf3K78ZPkxLsV4jPmWgZ81VKlmoKZTG8dWA+vVEIq+Fv+Dnn0/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com



On 5/23/2024 9:49 AM, kernel.org-fo5k2w@ycharbi.fr wrote:

>> The link is an SFP-10GBase-CX1?
> 
> As I understand it, CX1 is the name given to Twinax copper cables such as the one I used in the experiments in this thread. It's therefore a priori the right value to display for this kind of connection (instead of “10000baseT/Full”).
> 

I'm filing an internal tracking bug regarding this as well.

> Thanks again for your hard work in finding a solution. You can always contact me later so that I can carry out tests if you need. The machine is at least available for 1 year for testing purposes.
> 
> Best regards,
> Yohan.

Appreciate it. Hopefully we can find something that works for both cases.

