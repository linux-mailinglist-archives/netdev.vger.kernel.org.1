Return-Path: <netdev+bounces-110060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA092AC41
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5F2831D0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9DF6F2E3;
	Mon,  8 Jul 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtqQIVUn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575E45BEF
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478777; cv=fail; b=VCrMaMergVTrTzzz6zfLTVyGl6n9iKzDU7NiBT2mIA0WNp7Mp4CU2ZZKJqGk4Gfbfefw4qrMACKCt+181cknvDn2EM9cdDW2WmTtwGpucHiK1Yg8c2srIbfkEZseXHZTFXSmVGm0WqhsiTu67+LAKxmLML+ndUTuzEle0JZQlu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478777; c=relaxed/simple;
	bh=bNNIP64EyQxaacicX2HV5F8OlOeOQ3NJ2YeD+pspqfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0aHKoF4Ir9USf5frSg9qP1wG0IqjBRXG8szomUjVUjDHmv/tdbTTaS7V9yZWPypmquix1wXkHgdDiJEDynPvRlkKzOX/NIEo/8kgsxafHLHZpivpd3psUFoEIlBh/Z+KmTIkTmAqt69h6fO3g0IxdGXxzbYdEFL2sIuKM/X6z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtqQIVUn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720478775; x=1752014775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bNNIP64EyQxaacicX2HV5F8OlOeOQ3NJ2YeD+pspqfw=;
  b=OtqQIVUnfEiHEtLxy8VUF8b6npbWvkm/IcRSFFjDi1N5sRoA0pq8wNnA
   TS3PhSEiN2eocWYIxTB7N6BYlXlFjn8XctBM/sf1QEwz+3r8nW/PFHJb0
   lxUhBLI8ASUJ1+zVxpZLuHryTvZEse9rgwSYC9VF2JFCv3+3NylAV7fnr
   TfhyS0bW7C1l4wu4Q/od/PpN8d3ldUauGAdlGIA8zKkrsM7cVRplxOz1s
   JWeq/D8pVmx9MAfgMJ4dDlEMEsNRqJiQxflY/mLgaeL2KfhsS3SnC8jCb
   w2bzhmWPWlP3PKaYlyx0GECgTOStzeykC8jYn8Q1JCAuDitfvj/8qXuys
   w==;
X-CSE-ConnectionGUID: PrzE0TJYQyChdVg5LWWJBw==
X-CSE-MsgGUID: gtbinxaBQXqiwy3014koXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21572383"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="21572383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 15:46:14 -0700
X-CSE-ConnectionGUID: QYUF6n8KQ5y2LARQtIkMPA==
X-CSE-MsgGUID: NUQBAaM/SLSCQMw4xRQKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="70855786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 15:46:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 15:46:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 15:46:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 15:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apVjr6/d/HLQTzxMDgwaoyB72sFEjrvjbYBI4puU++TenLln084pMhV9Arfja3ZqcgNOUy3DIWp4NAAOKvv/YRGOHdNP7RbLCneFnLfyOFI66ko9oRqvDESSSNQB1ZUnPwszttML0Z6JMtm+s96E7GsJQ/IpjctVSPWBPGNwGqOyR0P70nRGB9ogoHJgP9LWDRqEOTxvnKDPqq8zSgs6L5gPVLl5dGCeUOGfJ6rlPlC6cvZS4CDm5afw1wnIjTHg8ME9XxPD6prjA7WJszuxD5k/EmeWeo2+flTH2LjbKU7vMUU3BBzpDuRSYD2lAgkWWQI7ayVOavESpeXDfvZb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJA5PpSvSj49D53R3kC+6k2+DejbGyiS8b/d7Qdjb18=;
 b=OEtDHeugcu/VADug3oAuzeB5kiSN/4Koq1nHWB6udZRoF1AFgGpojlbaAJgrOzH/HrlJTdDIXWXhnZaCbJo3gkLw1KUZxNikaKhiHGDoaJbhTalySYDpj6N/E4hv1b42/vwYrA5W4nDea1B+jfTE00CAc5xk/NbqSzLy/IPpjDKWi3WbEmPhtSveaI4PSi+eDKUwueq+Lua/i4MJ+etL2O81FcduE3U8tUx1igZ8Ny4+hKWTtIPrUAZt1omHRTj5wXDk7n6/UYS3e9RvKCStuY6ESMEObBKNQwd6wR3QtSZlWp8Xg7T/QaYqA4HK061SmHnDNR4G1c0gdWShjAbiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 22:46:10 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 22:46:10 +0000
Message-ID: <59036dfd-d008-0d14-0ae5-b4e258147777@intel.com>
Date: Mon, 8 Jul 2024 15:46:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 2/3] ice: Implement driver functionality to dump
 fec statistics
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Anil Samal <anil.samal@intel.com>, Simon Horman
	<horms@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20240702180710.2606969-1-anthony.l.nguyen@intel.com>
 <20240702180710.2606969-3-anthony.l.nguyen@intel.com>
 <20240703195557.4b643f90@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240703195557.4b643f90@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ee38f7-f60e-4a18-4d76-08dc9f9fc317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUJKZWFHRlgya3lKUXQrWUFyTm04eTB1N29TdTZTVEdwS0ljdnFxVk0rRlZC?=
 =?utf-8?B?Wk5OaFE3ckFzaXZUZ08rdWlZaVZhUlp2cWEzRVNaZGFKRlE0aEdDc25LcGZr?=
 =?utf-8?B?ZE1ZaGNIUHl3UVdkTEFmZGdScDZDVk83eUN0VFoxcVFZbXltOVU1cmxrQ0FF?=
 =?utf-8?B?bS9vVitiMVE3enFzbFh6S3NjR2wxeWxCZ21ZYXJTelFFcmE1eWZBeGhhaUlR?=
 =?utf-8?B?Si9iWEZTSlJjTTJUeUhVbjVQcmM2MENTeUNqTkh0elFWZGVHamd3L2kxbHNi?=
 =?utf-8?B?c1U3M3J2TlhXbjR2MmpuSWNlVHZCUDE1dk5sVHFNWjYwL0xGS3g2eFBkS1pk?=
 =?utf-8?B?Uk9uNmh2SlVSU2Y2dFluM0N6VnUxMzIxTFJsV1hoTGppOUk1RkNpN2RYUEdl?=
 =?utf-8?B?ckg5UjdpR1NIZ1BFa3doSVJjeE9JeC9NRkw1V0xGbWFoUHVMYldRTWVFWm5Q?=
 =?utf-8?B?K3k0RUl6bkRiVldqMFhoZ2F4M0xoV1B5eDJHZXZ4d1NjQklOaUdSdEliVHFq?=
 =?utf-8?B?TGoybWRMRkdKS2pYNzhSYk1yZXJTVzEzTFZNYk5Pc29iZWNsbzFiWkw1NWhr?=
 =?utf-8?B?MGdCMUZyb21SbnVab3UzZExLbVo2dnF6ZlpYSVkvQnZacnVtK2FjM3gzN01h?=
 =?utf-8?B?bFd3M0dTRWpSbGczak9ycTJtTElLTXh2dm44cWZpUFROMStpek4wVE1FTnVh?=
 =?utf-8?B?RGF4aVJRMGZqdE9OSVUzN3k4RmdybkZld1pmZXN3SGRLYkpsdmR2RjNLZ01V?=
 =?utf-8?B?Tkk2QUxoeHBseWhWck9IMDJGZHJQRzFBbGZEZXJCME40ODFoZlQwNGEzS1VG?=
 =?utf-8?B?cEllOWZOenBXQ2RKYVNaL2x1eFBHajhoZmozVm9nRk5nbWVrU0NDZWNJVzJ6?=
 =?utf-8?B?YkNNTXc1djk2VitFcjNCdGJyNVRGZmx5VWlKcFFzTVcxdG5tbk5EQ2RJRURk?=
 =?utf-8?B?L3g1MkZwRHR2YUFab3JhTWVEQ3Vqbkdtb3B4UVJ3VDBxVWJvMkRjNUF2Zk85?=
 =?utf-8?B?QTg1T3lSbTMwVmxTczhYUjdrZlNZU0E3cWxvVUlaOTkvdlUybmNFWTZkQVFX?=
 =?utf-8?B?aEI3ZEQyU2JFOURnYnZRVmt1bitIV2o1QVNuT1pTZ3lyR3YzQnV2REtHL3pY?=
 =?utf-8?B?eGNhRTcvVGJ2aDB1dldKampEOUVMYWYwdzBkVzZFWFVZbzdxZEJFeGt4Vlpp?=
 =?utf-8?B?MVRaNFRyd3gyTVh0c2V4WTRaUzZHbzh2L2x4VHY0cEdCb0I0dno5ZFJDaDN5?=
 =?utf-8?B?SEY1a1hDdTRvWmNXZytSNDgzZFNHU2ZodnJiT0JjV3JrOG1aUzh3SzZLdDlN?=
 =?utf-8?B?Sm43am9vaHBLTTNEbC9qMVAwT2hVbVc2eVB2YTRZZ090bzZLd3VMMGIza3pE?=
 =?utf-8?B?UHgycG02UlUzbzZzbFVPT3BIbzBGVGpaQWtIelUrR2VHdHp0Nzg5VllyQThH?=
 =?utf-8?B?ODFIMWRuOW5oRHlKRDVLM2lCMTNudFpTOHZOeVduYzFXTkdYK1F2NGpaT1VY?=
 =?utf-8?B?cXFCbGF5eEk0d0JhUmZIRXNES1RoSndaQjJNZE1ZRklhWTI2SzFXOWhEOG1T?=
 =?utf-8?B?aExDdER2OTY1VEx5NkRwSnRtdG1BeDVGY05ueENJNmx4dU9GQk1nUVJOZ3Bt?=
 =?utf-8?B?YmZFblZySW1ZMTVhZXoyZ3k5UGZFS1BHUSt4UWtpcFBvMWZacXRzemNiaEpN?=
 =?utf-8?B?MFgvcVBZZzRHZWMrbHU3cTVsR0ZSS2NPZmE0MXFWSFlhcUI3RDRZYUlmVHBL?=
 =?utf-8?Q?IpfHet+0mCgwaJ1G9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFE1NDh6MVhVbUY4R2dPRnRLTTBML1FiUUl4RlpHcWhTblRqT1R3V2xHY3VJ?=
 =?utf-8?B?dHJiZnQ0elhkbFY2Y3lpT3B6Ym5EUWRrRHRoQUR6YTNDeEcvc0txRTl3OEE5?=
 =?utf-8?B?enM4c3dGN21rOGluOG1iMFFPd09OTE56MkRBbGlPdmo5TUxHWVRiSmtQZklC?=
 =?utf-8?B?RnRDMmNSYXByQmRuRUo0bmdZNURhMUcwc2xaQnZka3pERmIzY1dCd3ZRM1JB?=
 =?utf-8?B?engwOGUyYVc3TnBrclpXY0crSmErbVdpVEg4ZjhlZ0EvQlBTVnhKNmlYdHBW?=
 =?utf-8?B?dFM0akJ2WWRMbkpNaGpVWjdGWTFQZWNIZzk5eUlpSmtVLzJPd21FTllXeUlx?=
 =?utf-8?B?Y2UrZUQrTmNKVE43M1VGa1phRHJ6cy9VT3VjKzN5YzE1T05xUWpwTW9WeG1L?=
 =?utf-8?B?UlVmRXJuRGNGYlQ1RE1vZDdkbzdjbHVWVHpWQWQ5ZkNYNFVFcllIMzNZU1Bs?=
 =?utf-8?B?THZYdVRMMTZrN0pQWEZ1Nmp2akpQZllpclhGVCtnVEdGTG95UUZlaEZRdVVW?=
 =?utf-8?B?QkxkVm9ET2J3ckJsOEhuS2ppeG9ZeGU2Q2NRSjVlNitSM1krMVAyQitlTzdx?=
 =?utf-8?B?OUhwcDZzVDBURFk2ekNHWDRrd3NJejFQM0VHV3pHWW52MWZ5Z2lrdlNhUkh1?=
 =?utf-8?B?KzBaN2o1dExnRDYwS29nOEJxVjRkMXZGTjdOU0x4d1VsQ2QvWDhpczhRZk9l?=
 =?utf-8?B?ZG5CRUdCZE5sZGZiUVZqeURtUWVDMVNTbTdZWGJvbG1wVEdxY1Ftc3pZeEtp?=
 =?utf-8?B?SnRxQy9QSXR3SmhNdDVLQ1d1V2Vuc1F5YzFidlltdzU4VDZzMnRIYkVWT1c4?=
 =?utf-8?B?NTM4eW16MFB1OGtGU1RROTFuY0kra3lvRkdwZWQ0UDdsN25kT0IySUxWRUJr?=
 =?utf-8?B?c00xK1kxODFueEIxSWNFQ1FPeDVxK1ZqRVZqTHFtVWpQQy9ESXNjUnJzeWRC?=
 =?utf-8?B?WE10YUNFbWhQUjBsOEZMdC9ad3JZRjJFSjZSZlUzVHlpTHZLeVZGRXROcVNi?=
 =?utf-8?B?bEhwOGNEbWNmVE9KWUE1Wk00UDFpeW9TWlNyQVdKeVBqVnh3UUFtZzhqTEF0?=
 =?utf-8?B?b0ZSYXN2NTh1ZlMvTTFETm45ZTRGQ2Nwa3BxUXBRazVvTkJBR0FlVURjVVhn?=
 =?utf-8?B?eWxHQUJROFhVVkpndXp0cDRqSm4rN0tFQ0ZXRDFBZnNtbTdKd2JUblpEM3c5?=
 =?utf-8?B?VWRWL2JpZjdNZm1wTlpqZldqWWw3Zm5DemlwS3ZMUkN3Z1dJWW5PdHE1dVp3?=
 =?utf-8?B?U00rTGVGazFwOFNUaXk0U2lzYUxSRCtKVkY5OUFMcG8rVVNvazY5bFJqVUho?=
 =?utf-8?B?UjZCYkw3aGd5WnMwWXRGejR4eGhadUlhbC8vWit4azJ2VzFtK2dsdThHQTMy?=
 =?utf-8?B?R25iV1IwNHM0ZzR0R28zQzNlQ2Z1QW11WW1rQzJPU0JMc0JWY0k3VjczQmNQ?=
 =?utf-8?B?azJwNWxWeUluT0RlNW1EVzJpUk14R0JjY1d0WGRhTGxURlhnajJVbDBYckU2?=
 =?utf-8?B?UTJiK2xVcDVvWFo2K0xDN05MTnZ6dmtBSTFiWkdFTHp3MTM2YmVQbndVaHRO?=
 =?utf-8?B?SDh4YnFMbWZYZExDN2wrZU1FUlVnd3ZycW9hd245SGR1R1hCWnRnQ2hTcHQ2?=
 =?utf-8?B?Y0JWcmNmZ0MxOVVqenRnTENPVFBiZWtpcG9HbHNsNnE0d0E2MkNtcDc5emw4?=
 =?utf-8?B?RjVEUllteHRVQUFXcjNWbmgxQ1B0ZWVhTWtLWExiUFZmdkRmTVZsbTAwYmwr?=
 =?utf-8?B?bXdMa0FOQnRFREdGTVpkdmUrNjczcTV0bWJvQk5VTDQzTUxsUDBCUitVNkU0?=
 =?utf-8?B?TDZsdmdBRVBQeSt2ZTUrYUJuVU85V1ZUSFVRaCtibmlxRVd4YUI5bkg5VGVR?=
 =?utf-8?B?N2VtLzJKT2tvMERnMHBFY005NVZ5aTVzMDY4cXFrK0U0WTJNREFHSnUwQTJa?=
 =?utf-8?B?d214OWZQWmlyQmRmWEQ1NWJUUTV0WE5ZdXJoVFFJWTd0Rk1tQlUvNkVkemlM?=
 =?utf-8?B?dlRjcGozZUtQWVErdlQ0SEl4WWt0OXk0RUR0c2V3T0wxbUFOZlZHbGNNVkl4?=
 =?utf-8?B?UmNoTjFJZ3lwajdhREU4MjJid0N2V0U3b3FVa1laTnJCbWhTOUlWSVhmWWlS?=
 =?utf-8?B?d2NkdFpvdDFReWh6dTZ6U0FJa3FrdHZkRXVUSXV0SjRyekhBOWVQMW5vckM2?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ee38f7-f60e-4a18-4d76-08dc9f9fc317
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 22:46:10.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okvom1xxmVu9/8tfCFRss/lHYhALq+iyD5qmFSASuyuNxgzxplEmq4Hjrg6kBI8hFKE0/4g05ZiCdmQMnVZbrXeEJRcqXrJ0EJNciG8din0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

On 7/3/2024 7:55 PM, Jakub Kicinski wrote:
> On Tue,  2 Jul 2024 11:07:06 -0700 Tony Nguyen wrote:
>> +	pf = np->vsi->back;
>> +	hw = &pf->hw;
>> +	pi = np->vsi->port_info;
>> +
>> +	if (!hw || !pi)
>> +		return;
> 
> nit: hw can't possibly be NULL, it's pf + offset, even if pf is null hw
> won't be; maybe also combine the pi check with the type check below?
> to make it look less like defensive programming..
> 
> next patch has the same isse

...

>> +	/* Get FEC correctable, uncorrectable counter */
>> +	err = ice_get_port_fec_stats(hw, port_topology.pcs_quad_select,
>> +				     port_topology.pcs_port, fec_stats);
>> +	if (err) {
>> +		netdev_info(netdev, "FEC stats get failed Lport %d Err %d\n",
>> +			    pi->lport, err);
>> +	}
> 
> unnecessary brackets

Hi Jakub,

Anil sent his update to iwl-next[1] so will get these changed for v2.

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/20240708144833.1337075-1-anil.samal@intel.com/T/#t

