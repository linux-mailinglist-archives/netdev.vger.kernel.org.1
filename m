Return-Path: <netdev+bounces-108929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B798926436
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFF1C224B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C469717BB3B;
	Wed,  3 Jul 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bj5hPYDX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7417B51A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018999; cv=fail; b=kBSxzyCg6aKMOM86JLwGyEkzu9SwUpML3y1PHzo7XtiPMMLQkmWRTelvT4G6tRHCHn1ZMPFd71hx/xPA4cVNJH0hzMONDA7ri0ABVkaX3K38qbFlrJwnvIcHvCn1B0Vgkxtx8WClvpq4P1aMoVfPqf27p3zeTWo+7frf78j9XY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018999; c=relaxed/simple;
	bh=Oe6w419pX7Q2P6SwmdUFVZW41KyUy5bdzht7GyfSe5c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CzzM95lKobbfm18DKY8On9j+XPKbI8pUi/TLF1srFIxDcFiJHPWI1Mw4eILt6uizZkKG8Rvcvk7Ufo4hpOMKsyL/ybcPqjMhh2E2oJjohNydbEGx/QC7b9ggRLNwrAOppwAJd8jvT/oIzlzPyk/l1bDa0mTePNUMLXyrCconpVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bj5hPYDX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720018998; x=1751554998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oe6w419pX7Q2P6SwmdUFVZW41KyUy5bdzht7GyfSe5c=;
  b=bj5hPYDXY/2smxYzWT+y6IqPvWFD40gB5rHx5ju7HFl75EQmO4+hKNyR
   rLlKoZrXggDxyQCCfOE7pxSrdS9xk9f6D3KMrVAfgK0c65yLBOeCSJAuI
   EEKYjmOEFF8KlRU36p7Ilz/FeOcYMLugkwZgGY0caW+dp39Cb6cxQaeBI
   Z8Or9gxputZ2Oi8/d+ZvFeYLLA58ySoAlDJu79VCFZgxjIP2T1NnxI44O
   pij7L2VFGI1JYttWVtevDRzFPGFeXKu+hGNR1pY6AJgIjodGeFoF+3fEA
   RuUbvDGaRhESU7O3nJQnEl7aC39pHZn5J/L4vrp1bx0AZR8KNFdq/8qWZ
   Q==;
X-CSE-ConnectionGUID: KJO3KVbZRSa2ctEPQN9t4A==
X-CSE-MsgGUID: 0+405ddQSNafdD0vOkXnUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17373772"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17373772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:03:17 -0700
X-CSE-ConnectionGUID: 8vh3Fit4T5W1SKEFvzFCRw==
X-CSE-MsgGUID: g7j9vMLkSd6j4MT3RzGgCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50732242"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 08:03:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 08:03:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 08:03:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 08:03:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 08:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly0gwIk0BoYxkeoFDZKLdYpr3yRUgZyRWRBSVN6EIcvNXlb2UxHMB8yNjzQBQnj/0Kbda/oZ2i+lIfV4d474KIkbe3VjqiJT5FFbDpz1tTDxpODfoZY+EfE/BtjkQVGytDUkbSFNJvfclrJjN7gvaSCj+cvgo4HXxS3S0T3/hO28+5a8FsSydViWrC6nEJFDZ150K21DWfa8g0O4O+mPNl7M8eqRT8Ab74p6UvCfqFpJS8YbmuVjpWKCj+y4+4icZbG+rmELwa6KJOx49f29GbXDrbXoDampY+PfF72vjZ73RPjYeIxcdbm9HvIsv20JCybc1QUf5eF+FQDYOUhQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S0XOrlwD4DkbZyMNoi0jOTOdn+X5LT7w3c1yPPvPGY=;
 b=R5JLydAx+Tseaz+hDQxePlGzpV0Qxx/2hmWS8LoZJOQoTx/U85GcF4oHkQe7aMd5idnljUgRIJmkLBcitv+rUYHVGqaXDRwzQjacxiyz7rqe4BFtPHFAscPM2SlzAuP95kSjWNMrhueFUfw9P6P+3aANxtsRCFMEGnY5z1833t/5qk0F/5jdXscPmstuU5e+YikD7Zu9YaLL+F3J51rU2VkCFZ7/BK7SWQ6X8a0yZfiusUpxDi07NxkZhiry16Z0Nsb/i+pvu7HylboDxpsw5ViMoObt0cgEPSlCr4/iyZAAsIH5L2SRdiQyexl/8bduz9c8saXcgfaMVgqzShq7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 15:02:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 15:02:38 +0000
Message-ID: <d362d083-e0b2-44fe-8bbb-5a0286ace230@intel.com>
Date: Wed, 3 Jul 2024 17:02:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
To: Tom Herbert <tom@herbertland.com>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, <cai.huoqing@linux.dev>, Linux
 Kernel Network Developers <netdev@vger.kernel.org>, "Felipe Magno de Almeida"
	<felipe@sipanda.io>, Justin Iurman <justin.iurman@uliege.be>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
References: <20240701195507.256374-1-tom@herbertland.com>
 <ab3e6312-cf67-47bb-b30f-d425f7914053@intel.com>
 <91496a94-1648-b69d-e014-65868aca3a78@intel.com>
 <CALx6S35zhg8HAUj9_1=Zm=nV0mzSe-Batdo5qpjz6Zd4G8T17g@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CALx6S35zhg8HAUj9_1=Zm=nV0mzSe-Batdo5qpjz6Zd4G8T17g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: a9514588-6193-4b72-4fd3-08dc9b712e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWZ6NXFPRnJCbjluVHdOeFVGKzZ3Y3Z6Qjc5U0pzMi9vVE5iTi84eExyWmtR?=
 =?utf-8?B?SUVkeTAyQnkrVTZqSWZZOHpWSFJ5a3BzMlRpdHpEQ2ZXUjkrNXJSZXdFT0Nh?=
 =?utf-8?B?MkkvNXVrSm5NaTdOVUhRYjRXb1YxMkljaEc0K1FxNjJGb21VdzdXWmkycnRS?=
 =?utf-8?B?aDZHWW9McTl2RlRmNnYyRnVyd2ZNRFlYZUlTUlF5b0V4QSsvOUVQODljKzJU?=
 =?utf-8?B?b2tnM0xJQ1dKWGJFYXB0Ty9zOTVVNWsrUUVBTFNjaEU5dGtqK25kWEZNZ2dF?=
 =?utf-8?B?amRKRUlEYnhLbm5BUU55c3V2bVhXc0pWWkhHSUxYVjRtenVvZXE5Tk92T0cx?=
 =?utf-8?B?NlpWNTJRUkdRZFVnWUk2Z2dsYTEyR1d3L3FmZ1pLajZhS0Q4Sk1pN1JpSytL?=
 =?utf-8?B?a1V6WUxjT0RsS0RPUGwycVkyWnFLamEyZk9xaXVqcFo2emx5YyswWnIwaVp3?=
 =?utf-8?B?bkVsWjg3d0RCY0paUmtSZUk3b0h6bGdtMEo1NkE0N2tia3UrMEJzdzh1bkxG?=
 =?utf-8?B?azV3Z2ZYcVV3d1huRmFsTWFKSEwzWXhnMUpmZjUxWnJ4VTlFZjAxamRjL2Fr?=
 =?utf-8?B?OXVSWC8vU1YwTU5VNzVJWUQwVURKaEtjdlUvdHkyd21GNktwZDhOVzhGTWFq?=
 =?utf-8?B?cGlpOTgxeEM5dDVEaTZibEtmSjNUeEt4RFdQeDRJa3pmWDNZVFJWbWM5NW9R?=
 =?utf-8?B?eUlOT1NIMXBvMTZkaUZsZWwrWFBDc2o2L0JKR1RpWWxoRnBPOTFnTzMyQk1T?=
 =?utf-8?B?aFgyUnRHQ2tGS2dNbS95aUdXNnVYeVZwR0NuVlY0QkIzcWdDRGF1ajUvUjAr?=
 =?utf-8?B?V3hxNUVxQUtYSWY4WW0xSCtxdUxiVHNkYlFReG9VWHkzNXE1dG1DRnBBK2xD?=
 =?utf-8?B?RjN6L3BkQ09rYWpNSUxwWnpPbWZWdmtxeEk3L0gxbE1PYnhLVTJVTGlib1Zn?=
 =?utf-8?B?TVlQOVh6SzVVcjZqdnAyU1c2L2dYVE9Nck81UERJN3R2enpoVGxkTWt4dFQr?=
 =?utf-8?B?aGFyUlI2QjFWQUpMR1lVSW9DZkhLUDB3UUlzalcrNUlNRnBSQVFnZnVVVEx1?=
 =?utf-8?B?N0tjYUZCbjUvMXlpeW9JR1poaENOTkJNY0pKSXlJNG5HYVN4U0ZvK2k4UkRk?=
 =?utf-8?B?cVJrd1pMdzVHaVEvUG9CM2lsWmpWd2ZTUURlRDh0MkZsU3FXaWZPL1NITlVX?=
 =?utf-8?B?bm5jOXVSUjhQOU92SDhXUjF3SHU0U3FXV2tvY2ZkSnV4d1JldEcvTm9NU2d5?=
 =?utf-8?B?a2hRemNFeGk2NEZyRlR0SEZ5SkwwakljaDE1VUxGZmtnUGdLZGd0WVBMcHZ4?=
 =?utf-8?B?RTBkUXJzc1o5RWhnVlM0QUJML3RTRHV3MU9nQkwxTHo5ZXhoRTIva2QxajI4?=
 =?utf-8?B?NU4zZDlMZVdpM3VrN3RLb2gzR2NldXd3TG4vaGMzRU4wSkdhSURJV2trZ05W?=
 =?utf-8?B?NXZrVjBEbUZ2TEpyWlVHV1pyNzRBSkJFOGpldCtKUDhwVjVtZUdxc0JOcHBt?=
 =?utf-8?B?bjdBdGpYbTl2WGh0aytRdkh2ZWkzampwV1NuKzMyY2FCWis0Sk9QVGNlOFRn?=
 =?utf-8?B?OGQ4UVR3alNMM2xxdHI1QVBGSGVtUkgxTDM0NlFXS3BZNDdXaG8zNCttNGZl?=
 =?utf-8?B?eWZVcnJJVUw5L0Rwcmp2eC91MkduYnhnT3g1eDlJMzdpUGhOckN2NXFRNGxF?=
 =?utf-8?B?Q0N4MEFJa3FXazdDN0FqeUl6MmNmNXFEQUNmaVhWVTNOZ09sRlBqYVZyZDdP?=
 =?utf-8?B?Rk1KVmR5WFF6THBqb0tHOFAyRTNSRTNkRjQzWGxZeWRiWnY5RUkxcFp4U0Rp?=
 =?utf-8?B?QkdiT0tLb0RWYTdOU1Uwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2w1bExKM3U4KzVDNjVjSlFVNEZ4eWdjL2l2WVN2S1ZnNVpNU3BHUEp6SlBX?=
 =?utf-8?B?U1hBSnhuekRQbTF1OHljQTlvOWcvSFlwYkJQcE8wQ2F0Y255QVZiRWtZdjM2?=
 =?utf-8?B?MU5sTzd3bmk2N0lYWVhLeXNla1FMd3J2SWJsRHJMVHovRkM4QjdjUlJMblhX?=
 =?utf-8?B?c3VVcFo1c2tNcjlSUzVZZUlCcThTcmlVWUphY3JYSm1Tekt2cjBCRmRwdC9T?=
 =?utf-8?B?TUliNkMrZDk0V1F1Y3BzTWkwQm41TmZINGFWRGlpRXNuVkt2TGR2NkIwcWtw?=
 =?utf-8?B?aEUyei80WUh1NmNGT2o4U0lLbysvU1Rpb25HV1BHZm8ybE4ydzYxS2RlUlo0?=
 =?utf-8?B?K0svWE1FdlNNREFldlZGclBCVjlGZ1F0djRyOTVjelE5dzRxVFg0aFkzcjhX?=
 =?utf-8?B?d2tsVVJOZ1hJUkRTOWg1ZTF5NXF0d0N5d2NubDh0S1lvQnlPcHhpZGlYVmU4?=
 =?utf-8?B?Nm5zSDUzcnNGMERCaTN6VTgvMktzS3dsTVU0T1dWeW9jUDJpblRKclk5bXdl?=
 =?utf-8?B?bjU5S3o4YnpaOWt3UHlkdlIzMlJ2bTBJTktHSHRkajg4TXJkcWNyNzVlTHI1?=
 =?utf-8?B?L01ETE1GYlFLd21JZk9PRytQR1dlNkNMMFRCWnBmanJBZU1vdm53bExOc2dn?=
 =?utf-8?B?bnpjSnNOdW1iNi9KRjdOMDJoV1BrOWhBRERuMmZCd2Q0T1RicTdGREhVQWFx?=
 =?utf-8?B?VFRZdjA1WTNsVkN3TnBrY0F5SmVPN3RkMmdHelFZY0RkV2dzUGxHb25ZOEVB?=
 =?utf-8?B?Nkk3OGl2akwvNjdLTTd4ZWNiOFVQNGd3MmhKTTA2U2dCSlhBOWhwOTRqNy9N?=
 =?utf-8?B?MjlTdkJycCt0WEdQeDkxQXpCdVEvMnNBRjYrZnk1QkRjSEMxQktUT2x6Z0Vi?=
 =?utf-8?B?VmErT0p2WjRqMlVzWC9FbjJhZ01qNUxKMGJZQ3BMWm4vYlNqSWF0dG16eFdv?=
 =?utf-8?B?RlRyRng0aWNyVmt1Z3VFYVVDaFd5aWFublVOUStYRFRNZlNOaFpNZ0RQOHRJ?=
 =?utf-8?B?K2hoK0U1S0RJeUNOdlRPMWF3ZjNhdGpBWHU4ejBOemJZYjUxN3dpS1JOeDQr?=
 =?utf-8?B?MXFoTWlicWFGOFJ2ekFBbEpFMzRPNzN0eU5ZTkVBK0xNN0laSWFGek1FeU1k?=
 =?utf-8?B?SCtjTUhvSjZBZXJzL01tdjJIZmFBSTdsbnkwYklwR042SXhxR0Q2aGlzTVdT?=
 =?utf-8?B?MDFJN3ZNNG9YdEdUUHllWDlnS1BZNGRRS0k1Sjk3QjE5S3ZYdk1HNFVnc0R4?=
 =?utf-8?B?MjEvbnFMV0VBTWFCL2svcXlCNFJYby83WGpoeEpOc0I0M2kzVGtkVEczL1Bz?=
 =?utf-8?B?YWJqUGJqUjdSdGhwU2RwRDQwbTBlQk81Q2FTVm5wK2kyamRsUXZOZWxEMkND?=
 =?utf-8?B?RnQwaS9QTlpYR2pJUEtGUnV4YmcrNzVzOUEwVUhWckd0NjhrWVk5UVV1WFdj?=
 =?utf-8?B?RStoa3B6Q1JFMmtiZVdtNmgyVFVaWXpSL1J4QnkwMzVWRTZLMkJGaWhjMjNa?=
 =?utf-8?B?ZzRaczFBVVZsM0V4QUljUFpKNWkveUdyNzVBQVUvd2J3QmNBdGRsQ0lRRENO?=
 =?utf-8?B?cGZyUnNyWG0yNlc0eUdSbjJ6c0Y4V1FoZzNmbVhBaG9pVEx1cVd3QUJ1cll5?=
 =?utf-8?B?b3VCcURtRU1acHVaOXBPOHpISTJtdHpiZFVMdEFFcy8ramUwdWNXUUt0cE9S?=
 =?utf-8?B?MmFoV2xNL01hb2NvN0NpZUtKVG5tdlBVa3BXK0N0Zi9oUWdOQWRrOXVBR3Nl?=
 =?utf-8?B?bnAxdjBGRzNxajZEOGQwZE03UlZPVnFLbjdxZmJ4N3lwc2xoZS9XSFdQUkFj?=
 =?utf-8?B?c1huNUpNdEdDNHh0RGJyUDk4czdLdUlXVm5nY2JSZE9EckZYMVg3T2pVem5j?=
 =?utf-8?B?S0UxZzVzdWhjUTExelp0YVBXRVhOazhkNEJERjNDU1M2NGIxWVJTRnowN21V?=
 =?utf-8?B?YzI5RDlySHUvS2ZoTTlnSkUzOFBNb0JWSi9GVjJXL2RsZWNDTWhOMXpkN09w?=
 =?utf-8?B?Wjc3YnN5U0lNS3FtT29OelZ4bENsZDFHNUxmV1VhKzE1Yk9UR1c5K0cxSUFH?=
 =?utf-8?B?c2NtZzVoNVlqbE9LbllIRHFEZ1cwdzh3UFJTa1ZqWXJvQmZWdzJPSXVNMVoz?=
 =?utf-8?B?QzdHQVlFQWQ2QTlXb0EzeXpOV2NYR25WUk0xU1hjaE1KZU1Ld2xCdEFJV1dn?=
 =?utf-8?Q?RAR/LOpGWhrdaV8EJjNX7Ro=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9514588-6193-4b72-4fd3-08dc9b712e20
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:02:38.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJQmnWenYpSzlanTmD2x6URVB5rjtLgzZmUQguO0Zy43X48RmKQ6/tPkVm6Q7FN2WeKORv5anDJB23ra7A/mS+MU9kLzDg8Q/il3N18WToo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

On 7/3/24 16:38, Tom Herbert wrote:
> 
> 
> On Wed, Jul 3, 2024, 7:20 AM Greenwalt, Paul <paul.greenwalt@intel.com 
> <mailto:paul.greenwalt@intel.com>> wrote:
> 
> 
> 
>     On 7/2/2024 3:31 AM, Przemek Kitszel wrote:
>      > On 7/1/24 21:55, Tom Herbert wrote:
>      >> Several NICs would seem to support protocol specific TX checksum
>     offload
>      >> and allow for cases where an IPv6 packet contains extension headers.
>      >> When deciding whether to offload a packet, ipv6_skip_exthdr is
>     called
>      >> to skip extension headers. The problem is that if a packet
>     contains an
>      >> IPv6 Routing Header then protocol specific checksum offload
>     can't work,
>      >> the destination IP address in the IPv6 header is not the same
>     one that
>      >> is used in the pseudo header for TCP or UDP. The correct address is
>      >> derived from the last segment in the routing list (which itself
>     might
>      >> be obfuscated so that a device could even read it).
>      >
>      > feels like there is a missing "not" after "could" - with it
>     added, reads
>      > fine (not a request to change, just being verbose about assumptions)
>      >
>      >>
>      >> This patch set adds a new function ipv6_skip_exthdr_no_rthdr to be
>      >> called in lieu of ipv6_skip_exthdr. If a routing header is
>     present in
>      >> a packet then ipv6_skip_exthdr_no_rthdr returns a value less than
>      >> zero, this is an indication to the driver that TX checksum offload
>      >> is not viable and it should call skb_checksum_help instead of
>      >> offloading the checksum.
>      >>
>      >> The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordingly
>      >> to call ipv6_skip_exthdr_no_rthdr.
>      >>
>      >> Testing: The code compiles, but is otherwise untested due to lack of
>      >> NIC hardware. It would be appreciated if someone with access to the
>      >> hardware could test.
>      >
>      > we could test intel ones (except fm10k) via @Tony's tree
> 
> 
> Awesome! If you need any help let me know.
> 
>      >
>      >>
>      >> v2: Fixed uninitialized variable in exthdrs_core.c
>      >>
>      >> Tom Herbert (7):
>      >>    ipv6: Add ipv6_skip_exthdr_no_rthdr
>      >>    i40e: Don't do TX csum offload with routing header present
>      >>    iavf: Don't do TX csum offload with routing header present
>      >>    ice: Don't do TX csum offload with routing header present
>      >
>      > sidenote:
>      > our HW is supporting (among others) a GCO check-summing mode
>     described
>      > as: "Checksum 16bit (TCP/UDP) with no pseudo Header", but we have not
>      > yet provided patches for that, and I don't even know if this mode
>      > will be used (CC @Paul)
>      >
> 
>     We will be adding support for GCO "Checksum 16 with pseudo Headers" to
>     the ice driver. It will be off by default.
> 
> 
> I'm not sure what that means. 

IPv6 Routing Headers render (simple?) HW-offloaded checksumming wrong,
but not for the "no pseudo Header"-checksum. I have no idea how such
checksum will be useful, and we don't have plans to implement it, so
this is not much relevant. But that is just one mode that you could 
config our (new) HW.

> Can ICE just provide checksum-complete? 
> It's by far the simplest, most robust method with the most flexibility 
> for users. :-)

sorry, could you please elaborate?

Paul will implement GCO for ice and otherwise my understanding was that
our checksum is fine. Is there a room for improvement?

> 
> Tom
> 
> 
>      >>    idpf: Don't do TX csum offload with routing header present
>      >>    hinic: Don't do TX csum offload with routing header present
>      >>    fm10k: Don't do TX csum offload with routing header present
>      >>
>      >>   drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 +++++++++++----
>      >>   drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
>      >>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++---------
>      >>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++-------
>      >>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++---------
>      >>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28
>     +++++++++----------
>      >>   include/net/ipv6.h                            | 17 +++++++++--
>      >>   net/ipv6/exthdrs_core.c                       | 25
>     ++++++++++++-----
>      >>   8 files changed, 98 insertions(+), 68 deletions(-)
>      >>
>      >
>      > I have reviewed the patches and they conform to commit
>     message/intent,
>      > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com
>     <mailto:przemyslaw.kitszel@intel.com>>
>      > (for the series)
> 


