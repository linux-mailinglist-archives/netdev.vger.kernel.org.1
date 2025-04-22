Return-Path: <netdev+bounces-184651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422BA96C5B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06637AA656
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88427F4D6;
	Tue, 22 Apr 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP+5cpo+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09E613AA2D
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328114; cv=fail; b=o1cTHyxZS6pDxnSA27wSvfyC89NQd2tcwV+BDlhZq4IlHMfLYD6HReGbcaSrA9aunycXMkDsQUe2Tk4PWtMM9J0PBrDALolPuJ/b4P4piM92ZGe+BQmsbvs6OmdbLxemqy/f6spWfIJnpcSuUko2zZZn0Q+kGirA1UU68VGSEhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328114; c=relaxed/simple;
	bh=TWQ9ach83sliNuahrbfUtLSugzyb64NuXPIvo51u8Cg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZC2yUMewDpapaMCgFYUi1DZzxwU25PPElU7VDm9VDCCDJZhfO0qyQMCw4WxIchRzItpGGZesLRioJPF2Nhjgqk+QG53/LkmQN8Av2DXggpz4jyIfnsPEYfaz9gyYJVvvMpJAezeSFOOoRLd1VY7YBPHydnii0N9wxuraOnJZoqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP+5cpo+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745328113; x=1776864113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TWQ9ach83sliNuahrbfUtLSugzyb64NuXPIvo51u8Cg=;
  b=bP+5cpo+3f4E/QE0CZ6w8MVRWWNia4RY18o309AimNB9/goo5GXX1iyG
   3NJ0k5NdpUGa4Hnm9k9iyYW0l6wrOsMMz9ERrBlCePp3qof9e7qnmfCSe
   nb/lSBzoeXzMYDfGKMJDzXBdTORXiqS+as9M27VDkwwV+KgvwivCOQ/0U
   MX+Qhm19cKJnzUx5QMjwmrxRS/vQRJ8usghvt1F909waRb74D2/lXTjdL
   NO6ShMw6CtyG4wEVEG8Lf6POF3i5bKY0N3kCj0E8wZ4f8iHKTGapH9dBn
   zhe5Zf7Pil9V4GxEYBtNkJHreWtAMlfXhFjhkdTnjdNzIzeRJchZ8Taru
   w==;
X-CSE-ConnectionGUID: ydTnwtt4QhOT7kkAHmp97Q==
X-CSE-MsgGUID: TeiypOY6Qp6aRetPRr/aJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64416385"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="64416385"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:21:52 -0700
X-CSE-ConnectionGUID: s1VshK4JQOGM3+S6Jw5L8g==
X-CSE-MsgGUID: ihfetGcqRC+wTLIz1sf7xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132551987"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:21:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 06:21:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 06:21:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 06:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBIua14aF/gcTgH0BnuQkicf9FUaKT98zNmVeqj2n22gMJuMqQ7cR9V0VU4vYCn/u5up5+IeLO8XRJzbWiPE9l2FIXLYyH5VJjLkT3imJOPIuOHdstaC8OOYo7IkinrM3T8FTTZRiBkTWXg1GxRky1xLryLzwO8Sg+niTdaQFtDcUjWDMIzLQF4SJIOojac1UuBYtsfVrw66ru6SQAw2Rcwh+nHOseD+KXGAV6lBCFRzCfuaioDmvjU3lvaWDTaVnTiWX4HVLW7xy//tUIbFTSYqv4QvV5GIgqinFgQG/wgPwgVy1j37syIx/hPJHMPLXkHRhpRUe68R1JHV8eo2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajnn2NrAJWlowTJxV5j9BKS9xTTY7OoVST3ZhZI2fVQ=;
 b=IJRHQ6wJCPTaT3ijfCtt8yPQbBdvvg9ULePbVrORL6EsBYrTlEZPxXku4T6nbtTH4X+kFrg7wbm11ruA9Q9RIBWoZfokS3wbZRtYuCEv+2JRCvIcVqDf9IKHd41bkXQKs1B2/PmTlb2So8kFUI0IzSU8hnpUePc/PEo7wTLjZdOpx9XMgDFqCdrO2Yy9OM3evEzV6u1KrThN5aQa8Ft6bw1e0tsBQdkm+A82cFK57lmLqOctV77ZizaEp8vLdXg3W/iybQGvkncpofM3UG7IPQn02vO8PhQ/EeIGphIHEJNA/MCwJZ0HBWfk2muG4LgGjV4OlLa2CLqqYJMEKeKxqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 13:21:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 13:21:20 +0000
Message-ID: <e7fef7fb-df43-4a62-be71-311f9b65fe94@intel.com>
Date: Tue, 22 Apr 2025 15:21:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFG] sfc: nvlog and devlink health
To: Edward Cree <ecree.xilinx@gmail.com>
CC: <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski
	<kuba@kernel.org>
References: <7ec94666-791a-39b2-fffd-eed8b23a869a@gmail.com>
 <e3acvyonpwd6eejk6ka2vmkorggtnohc6vfagzix5xkx4jru6o@kf3q3hvasgtx>
 <96e8acf9-dbd9-6512-423e-22f52919475f@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <96e8acf9-dbd9-6512-423e-22f52919475f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a1de76-df07-4a50-9705-08dd81a0923b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzcxMER1UGt3d2p2ajFLV0doUTFJVTlUSU85aTRrRStlRWxjZ2tocXp2QmpI?=
 =?utf-8?B?UnNlNGk5ck1EWXZHYkNoTWZUUWpHRDJjaE5INDRXaXlQcTVFS0NCOStvRGdr?=
 =?utf-8?B?alpxNlhjZm9iWGR0QllpQlNrc2VDdDExVFBsSUticWUwRjN1ZElqMUtxNEVq?=
 =?utf-8?B?Z2F4R2pQeUNKSTJ6aTk3aEFRUzByM3g2NUdEaSs5b1lTemJkMzVPSGh4T0Vw?=
 =?utf-8?B?Tk14NldCTGQxaGQ3d3htVGJ2S25uQUllczlOMWcva2J2Q2V6ZVYwcnFhR2xS?=
 =?utf-8?B?MU1qenRLdmg3TUsxdFBXSVRvM2ZVZjJ2a1VENFhvdTdmM0o0RytYeng4NVRC?=
 =?utf-8?B?RGMwajk5YjVha0VkTkJyUEF3c0lEbDFmSTRMMWpNMGVJRXFhMW5Bcy9jVk9t?=
 =?utf-8?B?Uk1zTDhqa1JxUldEZ2FFNG4vejAwbFFlaG5VcTVPeEN3ZzUvK1Rpamc3SCtZ?=
 =?utf-8?B?dzdRNi9hS0VMRUtrZVh6Uk9EVkhyN29IL0s1S1ZyZTl1OW1ieG90RXNVREVj?=
 =?utf-8?B?dzVqV0x6bmd1TXJ4VWpXVXo5Q29NY3FyUUFXdEhjNzc4MlAwZ1BiY21sWGo1?=
 =?utf-8?B?OWljRGZWUjRlRTU3YUNmVGNURXlHcjNSQTRyOFo1TGc2emZQM3JXQzRCRmZm?=
 =?utf-8?B?bTJKWEZMeXJjcCt6aWVCbVJya2lNTGE3aVpZekZKcHYwc1VJck9yNkJtU202?=
 =?utf-8?B?UHhXZzFmNmlzNHZldHhobzR6M1paRnNJWDR2ditsRlhRbitnTDI0NjZkT3Vr?=
 =?utf-8?B?VmhtT3crYUhUb25WUlpyWVlNcytGdzlaWkJ5V0M1bGNRUDFLUFFFRUwwdHJJ?=
 =?utf-8?B?Sld6YnJiZy8vcTRVdnk4ODZ5azlJQ2FhQm45aFUreG5heWo0b0VLSkdGMlM1?=
 =?utf-8?B?OENwVG9HdDNaZStqZ1hzcllXNm9FT3BzRmhGZDBQVXNpZmU3UldqeXQ1SjFN?=
 =?utf-8?B?RGxSdFlrLzRjWjVFT2xrcjVqM0dPT2J4b1ltc1EreXdFUUxkSmhlU282SmM0?=
 =?utf-8?B?RlUxUDd2ZURsMlM4dnFqVVJyY1d0bXJTUllLTGZmQjFyeUlXQ1FsUE1Mb2Jt?=
 =?utf-8?B?L3NYWGUzMWtURjNLNU5NZzBocTM4T0w0bEp2TUQvTjFtS0hZMGI3WlQyNEc1?=
 =?utf-8?B?L01adDJjaUcvVVF4bHBIWEdwbyt5ckhVRUdYWlBZRWRlT0RJZ09ocTRTMkpy?=
 =?utf-8?B?ZkJzSEhVVC9CWUM3TmF2bTdjbXBTbmJ3QWlLdjNKK21pYjY3ZVpmMG94bGVi?=
 =?utf-8?B?Nk95UUtHYXlrVWJSOUpXNzRiaG5LYTc0M08zeFFXTDUvVGd0THJpamx2TGdz?=
 =?utf-8?B?YzdCYzJ6OG9DYXdzTU1lN3hnL0VHRmZVNTFidkhnMlR3ZlNTRWtUM3ZLR3BK?=
 =?utf-8?B?d1dGQ0E4TEV6VWFIUkY3TGFmd1NadzdOdkUvNzdESDI3MjNBaFk5aGVCUFVl?=
 =?utf-8?B?VWh3eUZRU3RPaWMwUVNnR2krUVliZHhRVHBUcDI1ZHVud1V1Z3M1eFU2K2xR?=
 =?utf-8?B?RGFMbVk3Qkt6YWw5UFVDZ3hkMmFtWnBIR1RITzlwWXVBaGRCVVRVMmo2TFlz?=
 =?utf-8?B?cGUvTS9kand6enFaMTdWYTJmVmFBbW5QQUlzVzhkdXVNNjhML2lBWWtZUXRz?=
 =?utf-8?B?WVJlVUtEN0FBZk1EbGtZb3lXNzRHTlJkRkt0K2dUdUFMVDFRZEJrcitNZnhv?=
 =?utf-8?B?Uk0wQnNpNnlTeGRsd3RLS21HSDVMOVM1WExISm1GN0x5SjdZUTFwY3JWN0p5?=
 =?utf-8?B?bmROcURQK1lObzU5UHYxSFlBQk93ZXljcGpLSUtwZmQ1ckhEL2ZrMERZbGpp?=
 =?utf-8?B?T3BqSXB0RmJDNUpWanBWcXpvNlNHc2tjQXIrUFBZTzJKOWFnc1dLSjZxd3Nq?=
 =?utf-8?B?TjJvd3V0R3M0T2tJSituTUJNY0lZY3c5cWQrSzJ0VDN1MWR1SmN5eHNLVEJS?=
 =?utf-8?Q?dOVdostyDsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlUyTjVRQkVFT3puYjVvNDM5bEtWVUR3VFVkNW0wcU44WkF1WW9xbUhKNDhk?=
 =?utf-8?B?YTMxOUU3RUJ3Wk0rZUdiamdqcm9sTFBSc2ZDOWtOeExoZlY3L3Rwa21pZjBm?=
 =?utf-8?B?Tit5dWpxaWl2Q0RtV3J5VG4xVDZSb1RNOWMwRndFUlJRUmZNY0hwRG03d2tq?=
 =?utf-8?B?djFjYnVPaWNHZ1VKeVB2SCtyN1BBNjVveW90UFVrMWgzYmYrdDk2SU1ONVNo?=
 =?utf-8?B?MmVETDFEa0cvbFg5NXNBTEJyTGNzQ1JkVlNmZmQ2OVNET01lSnN2VmlQNmZR?=
 =?utf-8?B?dmtIVW9LTHZOc3RGdjhPTko5K29RZy9kM282MVpJU2w1d2crUnZkRERsSTNB?=
 =?utf-8?B?N25aWnVPeHdJYW1TVHQrbWtia3NsSU9oR2JzMVVHYTF6eFNQMVZKdWdxemxa?=
 =?utf-8?B?ZDZUMFJuVnNEcTZSTlhiY1VCRGhob3dSKzA0c2pzUUZHUXdRaGN3WU1LQ05T?=
 =?utf-8?B?UEJuT2taeTU2SE5EYnFxVFBKQ1lVbGd4NVpFM3NnRngra2ZpQWNWN2RTeTVj?=
 =?utf-8?B?bE1pRXR3TkNhSTdTOGVBQjBGY1REN2xEREwzOTRVenJYdTYyUlVhc1cxQ2Uz?=
 =?utf-8?B?Sm1hWTM1VTVidkcwbSsrZ0FXQmFtZ05ZamxMaWQrZzdiMDByVmJtellROFNz?=
 =?utf-8?B?UEFJdjRGdmNxcEw3REl0RXdoNlBtWTJnS29ack1PeHhvVUp1RStTV0I2MFBU?=
 =?utf-8?B?OS8yR25qZTJiWlF5TWVmUW5yOHQ5bHg2ZFVZa0VZcksrMzA0S0xCY1RQdjVW?=
 =?utf-8?B?dDU3UFlSaVJMRHRIcW1Nak82UWgyN1RMNTVRbXhyU0FTVkVEWFdZdXEwcGtL?=
 =?utf-8?B?Vi9jaUFlT0w3TlRvRVR2MWF1bDlzcjZGYUM1Uy80OWpDaXNPZTJUU3Jybk43?=
 =?utf-8?B?Y1BPWHNYQU9QbzVNcXFSRytBTkZLUUJnNFl2OGJ3QWU1YS9oVHBMdVVSQmxj?=
 =?utf-8?B?UGF1cmVIL21BZnV1UGEvZE9OMlJHSS9aM3g1TElmNUpOLzdSaEVrcC9BcDN5?=
 =?utf-8?B?ZmxJT0lSUDMrcmJnOHZCNi9JWUFmNXBDNktTRWNlekFBZmVJaGRLZzRZZVYv?=
 =?utf-8?B?UTFKbkVkNGtUQmo0N25ydW5sS0lWVGExZTBxbG11RDhoTW9EK0h2dzdyRFpo?=
 =?utf-8?B?TDgyU1plOHlONmhGbGZPc0xhdHA1THlKaEJUUTNtWk0zQWM4eVRjSHBhKzJx?=
 =?utf-8?B?Wk1ZcjFuMUFmVlNEajYySSt4eG9qRldrRWdRbnhzNXRKRGVKTmN1bU1rREJo?=
 =?utf-8?B?cSsydUhpTWlnUTJNSXJDSjB1UEJZUlVQaFJKYXR0cit0MzFDSnA3WW0rRHor?=
 =?utf-8?B?MUFFdW55YjVwTW9DRlczQVZHM0FQYUV2eS9kcTN3SU5rNnR5Z2ZLUzVvR0Ro?=
 =?utf-8?B?Wlp1NUxtdDhEN21nMVZ2NmYwTHM2V1hUTTBIWFZ5dFN2NmhYWUxMUENFNG5n?=
 =?utf-8?B?UlhVakdWZUg1ZCtrd1V6RUtERGVIT1ZqcVdLVVZIdVBTcTY3ZkZ5ZC94WVF3?=
 =?utf-8?B?NDByTUwxN2FndURTNnR5MjV6cStvUThyZUlTanR1RnNLWFcxOGJYMWwyMkMr?=
 =?utf-8?B?U3MrOU9yOVVjdjJzdVdEV2gvejIwNDJvMm9PV25BQlNrQTR1OFJXMlU1VWJS?=
 =?utf-8?B?Q3FSQ1diUXJoSVJZL0w5SDNZRnB6KzkvZmZENnI3a3dNSGVuUGpVcEl1MXhl?=
 =?utf-8?B?ODFiNW5sUzkvM0IvRTlnbTZubW9ERHFpZUlSU0JFZ1A3UDZpdUE2eGhNUE50?=
 =?utf-8?B?OUhyWGNvNjNDdWFjaEY5YmlPaFM4cDRwemZpdEJFRTBmMUxVRVVENUZDTGZP?=
 =?utf-8?B?eHpLTmFvcEJYY0Mwd1l1V1BQbW1kVHNhT1hLVnVqSDdkZUJrWnk5RHZ1TGto?=
 =?utf-8?B?OW92aDBGL1hJVDU1TlgwNjNmclZxTW8zdytkSVJpNU4zQXZmN3lqVGY1c2Fk?=
 =?utf-8?B?Rk9sYTNWaVhkQXJnR293QTBUSzJQWEVmWXppdXZDemkwZzRObGp1eUFBYTVM?=
 =?utf-8?B?RlJEUXlhanN0WndRY1I2eGV1bjZ1dUVjRWk0UjVqRGlzaDJzaGZxT25LbHVP?=
 =?utf-8?B?MDlVS01FQStlblpXZHVGTi9pV0N0N2ZXa3gzNmtYM1dPNWNQbUZoWSs3Sjgy?=
 =?utf-8?B?ZUdNTXdjYW1yUnF0OXMvTHZoK3dEb0JzMTZxbzVqc0pIR3J5MktjZVA5RkdI?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a1de76-df07-4a50-9705-08dd81a0923b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:21:20.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+0X1kvKhYbdSlbmVLC3zUQ8ecy7H4LPI1cNgFlL0K2cVbnHRE5SOROIJFu3jN4WkVHP+vyi8yMdqyrNjxEM3kk1AbjLKvCM1kYWTpIvr2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com

On 4/16/25 12:24, Edward Cree wrote:
> On 15/04/2025 17:41, Jiri Pirko wrote:
>> Tue, Apr 15, 2025 at 04:51:39PM +0200, ecree.xilinx@gmail.com wrote:
>>> DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR is no use here, because it only
>>> clears the kernel-saved copy; it doesn't call any driver method.
>>
>> Can't it be extended to actually call an optional driver method?
>> That would sound fine to me and will solve your problem.
> 
> Would that be "diagnose"/"dump clear" or "dump"/"dump clear"?
> The former is weird, are you sure it's not a misuse of the API to
>   have "dump clear" clear something that's not a dump?  I feel like
>   extending the devlink core to support a semantic mismatch /
>   layering violation might raise a few eyebrows.
> The latter just doesn't work as (afaict) calling dump twice
>   without an intervening clear won't get updated output, and users
>   might want to read again without erasing.
> 

I guess it is common for HW/FW to have a buffer for errors/events/logs
that could either be cyclical or just stop data collection when full.

We have similar thing for fw health reporter in ice driver (E810),
we simply collect/display also the data from before the driver even
probed (seems valuable).

So, when to clean?
a) clearing the FW log at the point of user-triggered "clear" command,
will easily open up a window to loose events coming after the snapshot
was taken (likely minor issue, as it is typical to care the most about
(some of) the first events only);
b) let the driver to clean (send the "clean" command to FW) on the event
and optionally do the same for .probe
c) newer firmware could implement auto-clean-on-send,
making the b) above a no-op there (but it would be a good fallback for
old fw)

just requiring more actions from user seems too much for the problem,
that seems to be solve-able by the driver

