Return-Path: <netdev+bounces-110851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE992E9C8
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ED11F2109E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6015ECED;
	Thu, 11 Jul 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY0wGItm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48015252E
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705301; cv=fail; b=O9qM0XukowP6jMNUTlVOVX/oOauhhdV0o73dQJVds9lcK27JEQTXlAb3idKi5uPtYTpyqSjuKQjw+Rk3SmPFV+phgdeeWKxN+dXgAomdI3bayrd2ozcA/2J1P+jgYD9VH4/zZVhk25w53RfnW8/DFeXoRn+pailD1dEIMP34cRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705301; c=relaxed/simple;
	bh=HAYIPbBpH3OaDTj4oj3f0qTDde4hFPipK0xig7pHIyg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQrLUGsuYtfrjQ/2OyxnGBOODq08i5hTK1RssTug/7nsYqi7YtBZb2uw5UjhNYHK19DSZ3yPd3ZXUX7We3/H9slWLZVqx7J7a/BOq8wiIXrem6M0vot4UBN8OwEwkJFhO7Bu+5bodkipPSYn6QXtaIo27MuJjkRErLF1QB+eMjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY0wGItm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720705300; x=1752241300;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HAYIPbBpH3OaDTj4oj3f0qTDde4hFPipK0xig7pHIyg=;
  b=AY0wGItmwJ9WTRpeLGr5LK9HE3+n5iaSq12Hk6e1qi3sEQFTHSP2WNZ2
   RAlXatBgdAPWy6mCVYR/MMJZSovadmz9l91czNBWcVrOoI8z3RixXM1U8
   MrdtTUoxR1hatbxFJ+x2g+p2IdcUHO45tzlkrM1AFyPBoZ8JkXKF8kuK3
   C3WMT3YLODy96+S0nSY193567f++l4QpzsqkA1HpfburQJC4f93rgKatq
   XKxjps2EwMLX8ymJyilrSoot1QRSBBnb3iY/9TyTCeyuVrSyiOn87to4l
   xJcEPYpHOZuW4Osv2zOSYnXCABNRkxZJ/oVwDorJWCEwtiYE9unecpH9d
   g==;
X-CSE-ConnectionGUID: 0ZrEyS5/Q7+Rp/4Inb7yuw==
X-CSE-MsgGUID: QXpNrpXgSbW00et6Hs2HkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="20995052"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="20995052"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:41:39 -0700
X-CSE-ConnectionGUID: do+z2cxARNuYr7iRgqgziw==
X-CSE-MsgGUID: k+B2Pk0rTLWpg2gmMxD0PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="49317262"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 06:41:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:41:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:41:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 06:41:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 06:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3FLNh9Yi8l5UCybws5lWLz2D1MKM5b5s+TQifp8X2pkbWj1VmYBRpBg4q+J+VKW8GPfqrTZxC/gOGDIWFSGjqSSBP3CG9AYztcgfG55SdWwy4LjlXvplzX7vkCn0/WsOZYYBBl1XpEQ9w6183AeX0o1+vQ12B8J4PchN4l+OEuiOfSIPocqcWyamuXgIXzro20zS7h8fpv9jUNbEHxOVb2d1sRYjZ2ORtBtOFgrPiOtvX8G1VeZYN/pILP+JJKbJXVlH4CL98K7veSUpBIRc4o/GXTfnJ4I0X1Ei0DKS9ixRKYT4bTfvLUyMF+1+R4SgKbX76YBEkH1T9Gpwz9hQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0im4UZKfWpTBkQZyIBo4S3ykf/BHhg/hPS+9c72VA=;
 b=r060mxn8h/WZTeB37J5mtnDGoFInBKMLetDQWxvHqrh6YmDuIHTXMU26XRK9pqSS9hFlC3BTxAyALU4fp1F73rk4qVOCChQ9csUs8ZZ9CA8nzlr7cNzlP3z+0/1ZXYqSJILmbGAskqjl92fm9J0IOodguQfrM33Wjl794EfwXkoSpPYfs0e7TygB89ePYADhXBXE9d6lGCGp/7DM3pPHVtcMnK3NCqvF+J9wZGlXxxsMyxP2C8iCeWl8XiSZVsQepW4/D3cbps9zz2L4+HUCggqm/I3v1bkLW66ABESliaI1EyoQ09hZLB7uP1cEmlnm65EBKTs6cQLD64oKbMYjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 13:41:34 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 13:41:33 +0000
Message-ID: <4077dffd-beb8-4db8-b729-3c741ae159a4@intel.com>
Date: Thu, 11 Jul 2024 07:41:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethtool: Fix RSS setting
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, David Wei <dw@davidwei.uk>, Pavel Begunkov
	<asml.silence@gmail.com>
References: <20240710225538.43368-1-saeed@kernel.org>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240710225538.43368-1-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM6PR11MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6248cd81-2ad0-4992-9a93-08dca1af2d9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T05ZR2hBaUREVFdVelk3Uk44Zno1bldpbzFHTC9tVmRFWEdrejRUOTlMM3Uy?=
 =?utf-8?B?VHhpOEZtNFRaZ2dCTXpaRFh5NzNFUUkvMXZtMVNEOGJGMnVWdU15OHIwZ3hX?=
 =?utf-8?B?R2UyOXExaE1MZTd0Y0RoZDladGZVaW1rUGkxTGs5QjdNc1pXK0lLaStybWJ4?=
 =?utf-8?B?WE1TMFdSeXBLTG90U0QvU2QxNEN3S2RuaWp5b0V3cXdjM2Uvcm1uN0EzOFlk?=
 =?utf-8?B?Z0ZtMm9rTksyN2JlVFdaaHRaNERqbG1HYzdrS2plaWYzSENGdzBkWnovMGVw?=
 =?utf-8?B?d3J6emUyR21pUjhxR1FiVFk4M3ByK003UzVoT3d0eWhuKzhBZW5LV2hKTjF3?=
 =?utf-8?B?M3owa3NlU2E5bklnU3M3Ti9qeEN4anV2RExhU1Y2UWJvQ00vZXh6aXZMTmFG?=
 =?utf-8?B?ZzdQeGNXbFBVUGluRlBkSTh3SXpzejhHdTJsQUV6ZWROamdHbDZkd3J5L2t6?=
 =?utf-8?B?aktNOTY2UkxnajZjNTQxNjRlMFpRcURXMCtLdWZLOGdURTQxS0NGY0F1Nndp?=
 =?utf-8?B?ejczU3h6WnVIb0wySVkyMFlKS2NvRnhTM1RhTm42SFVISkl4SmFwS2FQSzJn?=
 =?utf-8?B?bGlVVkhPQnRTM3JTWngvTjVpM2pPdFpKb3JvRzUvcHNQcDVKZ2VtR2RPeTVB?=
 =?utf-8?B?QitJT0JiQ1g5R2RTVk1EdlNRaCtHYWVUS20xR1FOUytIMHJkdUNvd2luMThv?=
 =?utf-8?B?L0hiejM4SDB6bkV1dVhaQk5xSElESit3aUhtOVJNc1FMZ0FITEN2MVRiUmlH?=
 =?utf-8?B?aDRuYjg4Qk1nNVpDeHpqMHNVSG95aW4xWkRSOW83OFZORzBCK3JVN21iR3N1?=
 =?utf-8?B?TFI2WVI1SS8vRXBLS01tNVZWa1VtY1dnSDRiNFQwNTFWVzJUK3RnTUUzOW96?=
 =?utf-8?B?OGRrYnlpRzVMcTQ3T0t6VzZTY1p1N2FzcXFTSzBsUnp6NWx1Q0d3ajRoUk1Q?=
 =?utf-8?B?TWw2MFFQTXV1bFdNQmpTTjMvOVJ3RUJXL2ZpOXN4allXTzZJWVdSb0VWZ0tM?=
 =?utf-8?B?NGpjSjl4L2JUMEpqYlljaFREL2xZOXY4eVp0RGQ4STc5ak9JZHVNSDZHbFFl?=
 =?utf-8?B?L3hXazVoZHZuaWppcGxXL3p1WWVzWVBSSjB0Wld0SEpRMU42VzJBc2cvWEdE?=
 =?utf-8?B?cDV3a1NnN2lNUFFWdUNVaE9YSzBQYVhMcmdhSWt3UUFDQUZEV0o5TXVzUk1M?=
 =?utf-8?B?UlRDbmhXdGwwT1Vha0ZKTDFpVUdwSzlXLzVVV2M3WWpFVkxJaXBlb1RZQVVm?=
 =?utf-8?B?aXhiK01NazVHUFFGZW4vQmQ2RW1NUEY0a2t4bmQ2QjErVFZLU1N2RWpIZC9X?=
 =?utf-8?B?TWltQ2ZTUVpwU0xZc3U4eU9JWk9KSVRlWEpidVhja1hsZ29uU3VNYVdGMzlz?=
 =?utf-8?B?T0VESVVXNUVjcW0xRVJaMTAwZzdYcFE5UjR0MlpHcW40UVIyVFFqc1ZMbU1Q?=
 =?utf-8?B?SFNNY01la01OcE04QUpkQ3JrWnJLalh3N3NiLzVhMWgvU0xZVnY0M0J6YWhl?=
 =?utf-8?B?TjRZd2s1RHJtV2sxRG1EL2EwLzJHc3ZOd24zZk9aNWhDQ3RCNWhrSUVGNmpn?=
 =?utf-8?B?c084eEZsZXd3TU8vTXdXU0dXNlhUcTVoTWR2ZEI0ZStuU3BEK1B2RVBVUmZJ?=
 =?utf-8?B?SHg2WDl1NDNKKzkwb3g1VVdheWFaaEdiaklNYUNKaU11OE82RjNPRmNOeTRm?=
 =?utf-8?B?a2c2Zjd2VW9NWVdWdDU1YTlGWHFtdEF5UnltdGhMRVF4MmN6a2crWk9wd1Jt?=
 =?utf-8?B?eVl2S2ZCVm0zTHdKOHV2ME9jVGVKSHNRZjRQeUo3dXVYYlNVbzBOVVFHR0JD?=
 =?utf-8?B?eWU2bC9DQ2NzTFdybkhlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZsVmhCMFVOMXRIV0t2UHhUbHJZS2UyY2dmTmNCbW1TdHY1RGJSS1loVi96?=
 =?utf-8?B?Z2ljaDBaT1VvN3FOYVZNNEdXZEx5SU9oNzU5YUpubzUyY3JJekNBNzRKUDA3?=
 =?utf-8?B?NkR4UWhneEMzNnJuRU5HZndsSTBSc2U5NzJ6WmFub3VvS1VLVEpxTWJnMThT?=
 =?utf-8?B?YUJXNkxXeFRuU3NxYzlKeHlzQVN6aHk4REM5N2dhM0hseVJRSlNCb044NXN1?=
 =?utf-8?B?Wkt4cy9ReXA0a1RRbkFYdWVMR21HTlFtMlRKc204QXBWZlhSOFZLamFnajVj?=
 =?utf-8?B?RjRJSUpXR2p3VFRQM0tTMEhGeXBuRCtkSk9kakNackZ6Z3pvWTh6OFRiVGhI?=
 =?utf-8?B?dFNvZDJRb0JpSGhYRTMrUXk1QXJKTnVBOGdlVEJIVmdQbFVIYklJMjcwMllX?=
 =?utf-8?B?S0lMRnk4cWI1UGtBSHNlTkkvUXhkSzM3YUNqQ3FXQkxMcDJ1T0RmQXpxV2hz?=
 =?utf-8?B?WXRkbW5EUVRUWERYL0NMdTV2am05OTgvb3pja1hwM3VhWk9CenZPazhsSllr?=
 =?utf-8?B?VHhRdlordi9JOTBzM1kvcGxkVnA0RDNZaDZQMkl2Mzc0NjB5Z3BObzh5WXBN?=
 =?utf-8?B?U3RuZ0hkUlRoZllUam1icXRkcFVlaHRzMUs0K2tlSnQ0d2ZHcXVYOVE0d1NR?=
 =?utf-8?B?elFXQlR2VWpzU0xJcFZONktDRGtFL1dNVURyWWpkVlp3c21NaU16SmM2Z3Z1?=
 =?utf-8?B?RVAzYWk5MlNSQW9XbTFUV25HaGFqQ3RtdlA2MjI5cWFudUtZK0VKdmxTMGti?=
 =?utf-8?B?TEdjcUhPR1UveVpSWGZCVTA5WkpsTGxWM1VmaGc1VHlPRWtSYWcrQ0ZqS0Rp?=
 =?utf-8?B?akZ6REIxVmE5Ry8rbmowTGZZanRhTWVwajBpY1NSZGZIM3hPNXc0OVFpNW9i?=
 =?utf-8?B?U1RhcTlFNWxrb2tVWURuQVg1Tk1tTGwyOC9TaVhYeDM2Y3VQM0wwcHhnVnRX?=
 =?utf-8?B?NXUvbGZoT3lmMWtmZDAyWmpGcjZTK1ViZFpiZEV1aDBobHN6WWptN09QODY0?=
 =?utf-8?B?SmVoRnZjclZLTDFROUlhTTZPeWZ4OXRlbEhHQjZPb0dBM2F3bjVaMEdWWFN2?=
 =?utf-8?B?aDZxWnBjclJ3WmM3akcxUzg1MkdNZmJyc054TEhJRWhpQkk5MXdZcWNEVUg5?=
 =?utf-8?B?RHdVbWFmcnhISnlYdXhJS0pkaGJQYU1aaUo0RHJGZjBjczJqbjlYZlF1Z1JL?=
 =?utf-8?B?NEFvTU15WXExcVR6Vkgvby9VdlhQTWhSMEY5MlRKMjRkSVZyZXZWbVMweWRP?=
 =?utf-8?B?WXBhb1pKUERCN0J4YzhlMnlIS2dYNzdybDFGeE5XUUEwVUF2VWZHTER5ZTNI?=
 =?utf-8?B?V0pZYVNkM0VYSWlhWHZZdWsyWEZXeHQvMDkrUEhlUDNNTzFWUFdzZGd6SVVS?=
 =?utf-8?B?OHBxZm1uN3lvYnpKTnRjbWRZNlhNa3c3dFFrVEIxQ2JtRkJUZnRxQXg5em9h?=
 =?utf-8?B?WlFBMnhWajZMaUI3eFdsaDdUR0lBdTA4K0pGb2R2SWtzOGcyYmFRdG1tcEg4?=
 =?utf-8?B?TkdRTW9YZWd5d0Z0WTQrcmR4Q2ZLNXhHSkpXemp0WmNyeG9KSm1ocnBSeXpY?=
 =?utf-8?B?YUs1aC9GWVNWM2tadzRjTHdlVXBmcmJQaGl4eFRZeEpkMTgyNkFIM1BTOTIr?=
 =?utf-8?B?aTIzSk1oR1VlOU1tRlZKbW4xdndVYzAwMUUyMnJlVWZ6OHMrU2xnWE41S3pB?=
 =?utf-8?B?Z0lIbGFEbWhVenlqYktodGdRSXBrSnM3ZUZDVTVLbk1Da1o4NS92a05UQWI0?=
 =?utf-8?B?Q0pEVndFb0dQUWhIRkdvVmcyMHZ5K2VKZHJ4R1U2MjdtZGZlczA5SDhYOE5M?=
 =?utf-8?B?ZkpTdThzUEtSUW4vY2FOZUcvMWhyb2d0b25pcmVCODl5TkMyUFY1OXN3V3NU?=
 =?utf-8?B?ZVFnNCtiZ2Nsa0h5eXR5Z1ppOEd2VTVXVDF4aXZFYXlFcUViQWoraFF4Nzds?=
 =?utf-8?B?cS8rWm9NQmJRNk5SOFJTWXRpcmRZbHlFS3BPMENRYmpiRTVSWHFNeU9oRVU2?=
 =?utf-8?B?R3NpWHlIM21HRUdVdmJUUVg5QUhPcTQ5SmxxVm1VeEowTXdMTnpaaDlMRkxB?=
 =?utf-8?B?ZEorakdXLzBTcVY5dEFFcnFuQW1sdUdNZnVZMFlVVVo0ZHZNNkY5a2IwN3dk?=
 =?utf-8?Q?T8lQ0YKEuYuL2l04fnlQP+x2E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6248cd81-2ad0-4992-9a93-08dca1af2d9c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:41:33.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ3FIl/9VrCUKTtvmK+Shc4ekqwcPgMieyyDfs0kLePOiLxtecZjLTmTQvNRzLUhyHTb4xhaiPCIb+kJ4IObhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com



On 2024-07-10 4:55 p.m., Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> When user submits a rxfh set command without touching XFRM_SYM_XOR,
> rxfh.input_xfrm is set to RXH_XFRM_NO_CHANGE, which is equal to 0xff.
> 
> Testing if (rxfh.input_xfrm & RXH_XFRM_SYM_XOR &&
> 	    !ops->cap_rss_sym_xor_supported)
> 		return -EOPNOTSUPP;
> 
> Will always be true on devices that don't set cap_rss_sym_xor_supported,
> since rxfh.input_xfrm & RXH_XFRM_SYM_XOR is always true, if input_xfrm
> was not set, i.e RXH_XFRM_NO_CHANGE=0xff, which will result in failure
> of any command that doesn't require any change of XFRM, e.g RSS context
> or hash function changes.
> 
> To avoid this breakage, test if rxfh.input_xfrm != RXH_XFRM_NO_CHANGE
> before testing other conditions.
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> CC: David Wei <dw@davidwei.uk>,
> CC: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>   net/ethtool/ioctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index e645d751a5e8..223dcd25d88a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1306,7 +1306,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>   	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
>   	    rxfh.input_xfrm != RXH_XFRM_NO_CHANGE)
>   		return -EINVAL;
> -	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
> +	if (rxfh.input_xfrm != RXH_XFRM_NO_CHANGE &&
> +	    (rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
>   	    !ops->cap_rss_sym_xor_supported)
>   		return -EOPNOTSUPP;
>   

LGTM, thank you for catching this.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>

