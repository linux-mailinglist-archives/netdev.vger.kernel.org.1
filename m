Return-Path: <netdev+bounces-168185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500DBA3DF13
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6519B7A84D1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE41FE453;
	Thu, 20 Feb 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiwHSfwd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F01DE3D9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066033; cv=fail; b=oZP2pRWTmKfHc6Pb1NBK3AjpuO6+8Idwh12fS9dvQmNzZ0hcaw30kUlLxJIOnCykhdgNX0ZywyX6tRebpM5+z5cIsmVYHernCzN/0S91k3vozaALT0jevyW6KEG+jFAiWzTlqhTh7wlOyzSxvM9gmFkIdMINuza9er3pyEz2Lj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066033; c=relaxed/simple;
	bh=oV1odx6P7UJpy8jeQXi8nkHO9Mt+0EjjGtG4yX6d6+8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VO5EV67A1mP6+S+aEtRXpgKL0SCzLxfcI4+Ep49+kb/xbqXbDFRFxY53H5lrEDBYFe/dZIHfOODNZJEYwZSuD2hvKQcXY3NnkVlZxiUXtMH1zqsoVDpm/0rkcH+W8l/OJ/W7qygw3OVSkcppHblAEA3u6PcRVgKqUfqS95H1ts4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiwHSfwd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740066031; x=1771602031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oV1odx6P7UJpy8jeQXi8nkHO9Mt+0EjjGtG4yX6d6+8=;
  b=LiwHSfwdbo33FBQd9oik0SQiOuQkEENx3IkA2lptBN8bxddUE8fpYnXA
   l0rsRwNfQT/j05QQxZRhsY6rgKYD+zjhv74FoBzyUOmLHeAniO6r6T27T
   asfgYMLb7b22U3taeQ0ydWD1N0LILCRTQ0sg9srKyn4nIGqE8GRd2Qnun
   c8WLhOQ57HgBub6Psl9gbzjZazLMcyrXbHHvOkoIwFxy2vPTgHnPK1K1j
   7GTdcvpsyHBYTE9u8QrflOb/oV9H6CmZQ+UWBSaczO587DSAu52kRff8N
   r4w8faqs4vAzS38jy655OkQ4i6qK4ik9z81MSyxM8XmAxCI+xBgfiP4hB
   Q==;
X-CSE-ConnectionGUID: YOP1UKAgRWaYH4V13y4INA==
X-CSE-MsgGUID: aRmuEiJ8TXGBHL8iqsm2OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40566370"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40566370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:40:31 -0800
X-CSE-ConnectionGUID: ocgUVUjvSWKFzjSMGE3UVQ==
X-CSE-MsgGUID: axgofLSzTzuM4S4Bw/mxPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115013384"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 07:40:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 07:40:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 07:40:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 07:40:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKWCaBpTNPY8GXPH7i/k5H6iN2/GZ6aVXtwzQxPfoQJkLORDW3EETui1RNLfmrzDL5h7ljKUSAQxS80HukKqVvCmbGc/85xnAPL8cA/Nixw3LxcmoPsZEsJmiBuK/ZEbxpMbttW48OjeACq9yC5b1TkzkSmiijAn103lnolMAr/kVVuHAg7at0jQNN0rsYvWKEXaCjLftXRv/7O2mIlcTS1HGm9DKpbjskQdy36NWbHAlwSyXQYM7auOcRUuwnzr0+UFzw8JvvL3eSLXmFik/xygPjnq45f+GpzAJIRMZnhcmD6SCvnBqjXOnEUF17Vj0y6LD/tibLzOGAZ9h58bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTepLkQSITvpfEOYX9dTTEaGlqv4l5/BoFy4T14asRY=;
 b=n8GiI/jxBzeZB2X/uliae/EjF6Zx7GqHdfzGYXxgK5oMiOza68UGIRhDOew3sUurilhq68OqVkYh4lI7X6vUVLgMXajyNxGaivFzhXU6KK1dCVeZnVSXfGL3MKapeX6wEqRrJYxWluTYQo82nWl4GNosXvijFY2cKZXx09jQsL6VIillWN0QHyTR2wo663t9Cqu22dBycznDC7OCX4S12N5SNeKU4UmmVbNO3Zfoa9kuTBKnOQT9fdw+lUblUgueFGLyzmmkArvHd5RDZkJ8Nv+cak0nlRuEAdvdfGh7vcRZWFUB0Nc3dciF5IHoMPG/0noJyNsZ4qCrJXAZ914Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 15:40:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:40:14 +0000
Message-ID: <300eefd4-2813-429a-b853-601518e20d98@intel.com>
Date: Thu, 20 Feb 2025 16:34:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: advertise 'netns local' property via
 netlink
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Ido Schimmel <idosch@idosch.org>, Andrew Lunn
	<andrew@lunn.ch>, <netdev@vger.kernel.org>
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
 <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250220130334.3583331-2-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0111.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c66af5-5d6d-4171-45d2-08dd51c4de2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3hNVWJvdGFtY0ZOaFhLSlR1cTA1dHVjODlzOGdNMmJ1elVKUXRFcjVyeVZF?=
 =?utf-8?B?MjA1eUR0U2N5V3k5MVo5STZWRERkMkkwaGVzNWpqTmxoSmdudER0a3pRWXpW?=
 =?utf-8?B?QkRRN0I1a29QbXlQRnAxcCs0WHk0Y2RqVHNDMzZRaE5xeWtlYTdTMzN4WnIx?=
 =?utf-8?B?Y2t2SzF6cnNnejZaK2MxYW1DSGVmMWFuV2RWbnVIZnA1a01Fa1BmdGpuWDYr?=
 =?utf-8?B?bnpGZXRYL09mYmYyNTZWMEVlbllsV0FPWTBqczJNZEJPN1NOcjNRTXIvVlZD?=
 =?utf-8?B?S0VCRUkyOWt3NU0veVVWbVpodDk0ZkVOV0hLWlhyc2pIWVNzQlk2dkFqUkNl?=
 =?utf-8?B?L1F2RUtka0dENlQ5SzN4VlBvUTZRdnhxVXUvclJaZzQ5YTNUaldxUUNNdmc5?=
 =?utf-8?B?eUV2WDZucVprb0RpWFplRkUxYzFLNndZLzlHTzNDTU44Y2E4Z252eHM0QkNC?=
 =?utf-8?B?N3NBN3dFbUxhZmNqdHdGRVp5eEFJOXVVM1VEN0xBeWhiR29ZTjFaOWt5YWlV?=
 =?utf-8?B?S0FtUjJyY1d4QmU0Sjh2eXBSU0c2YVFUTDc2OS9ZZFNzckJOTVRkUG1zc3By?=
 =?utf-8?B?eDBJbHYrblVDY3VFTEJiaTVralBBZEp5WTVWY1hhYU5SUEFpcFZwVmp1enpO?=
 =?utf-8?B?RTRCMU9acklCSTFYeUE4dGlaMHk5WGU4WUV6VjVRL3lYelJ5VGtyb01jVGNw?=
 =?utf-8?B?UzNFdmEzcGh1QUZCbDl3WFBNYVlIbFk5aEE0ZnozQ2k4WVNPc3RDeENWOFcv?=
 =?utf-8?B?cXJUdTFHVHc1aHZ0UnZXY3ZmbXFCTm1uWmFHV3pYSWxVUWdMNW01azdMc1Y3?=
 =?utf-8?B?a05ydURGc21SQnhaWWRLemdpayszS2U2S1pGSEs2dFhvd2ZYbU9xSzA4REUz?=
 =?utf-8?B?RDg1SW90OUtUVG5aNXE1U3ZabGFlSDRFSDk3dFNEMU5sVTYyOVVmdnEzNTFN?=
 =?utf-8?B?aTcyMm56aDJXS1ZNdGd6a3ZIQ21lakc1cnUvREI0Y1NnUFZzU0U4T0tqR2cv?=
 =?utf-8?B?RFFZT1E1QVZGOUJNTm0raHI2R0YxZnNDNFM1S09paE5MS3ZNVmlIcHUzM2RK?=
 =?utf-8?B?OFhXT0VuSFAvTFhSMVJ4eFhibmY3YlVmb242ZzkvSmVKY3dUM0hzWHphQVYx?=
 =?utf-8?B?ckRhdmJ2NVJ2ckRUaUFhVktKalVvU3psZjFDOHNFM0pud3c1aXJPdElLbkxP?=
 =?utf-8?B?WkV2LzJLZFZHTDdLc0pOdnAydE1uWUd6anl5bHFLc0VHR013TWgvTnE0S3Mz?=
 =?utf-8?B?MWVITkJhajZzUW5xamlUV0toZStaOU0vZm9vVHo5bGFYNmZpbHJqbUczamRk?=
 =?utf-8?B?WWY3MmxWME5Ydm05WUFJSUpES3U2b2dkcmhJL2NjcFJ0b2o2dTdQY1dnV3Z6?=
 =?utf-8?B?cVVIbW1udVdMSjI1OElPbzNYY3FYUXJXcGNMeVc1TzV2WFZQT0pvM1d3cUg0?=
 =?utf-8?B?WTBqbEpSU1dXNi9GdDcxMk5PVXpOekkyS0p0dHRCWjh3RUdmdVoxNTcvY04r?=
 =?utf-8?B?TjJpR0dpWDJTMnlYN0d5VnAyazhEclMvY3QyekE4OG5CckpRK2xDZ3VVNGtm?=
 =?utf-8?B?d3l4RTNwVWRyY3VNTjlvdy9VR0hhUmtLUDN3ZnBjL3FtVTlXRU1VajRPb2pk?=
 =?utf-8?B?cE9NQWVsTmxZQm9iSm5YVUx0dFNpaGZIcnduZTVPL3gyU3RHUGlpeXdIVC9H?=
 =?utf-8?B?Q0JOMXZrSytrVTdheDljUll0OUlubGVuQ3NKRzYxaUNxM1lQMXRNMkhSZUVE?=
 =?utf-8?B?S1JLVDJZR3RLNGN0eFhjUUxwVWZYM3FlalZnM09oYVhHanZod29aZk9ISWxN?=
 =?utf-8?B?Tzd1MzZvS0ZBZ3U4eTJOQTExZXJ5cndPMGVXcmJuRzJrK0E2QTVBNERyaXZV?=
 =?utf-8?Q?XrM6CMVzFamUN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZ1YlJRZUNSUHlBWUZIZUhkZlVGU1BQMDdsdmtsc3RqaHVFazFkV0dKbjQ2?=
 =?utf-8?B?VzMvR3J2K0x2YWYvSFNZWEpmKzNHMGM2bFR5bmJITFNQYVd1dEJYQ3VGU0cw?=
 =?utf-8?B?WU11TTJjajdqaFFCNXR0ZURuMjVwUk9nRWdMZGxFajV6MktiUnRwZ3JTVzV5?=
 =?utf-8?B?UXNjeFJSam9SYWFuVDZGdFY0WmRSMkM3Wnd5dzR3dnRLQ1g4clk0U0EzSWFM?=
 =?utf-8?B?NHFYU0VsMzJVdjRGTEg4Tko3ejFmaWxVOG5KejI3L0poamxBMVdHQ0YrSExB?=
 =?utf-8?B?YVUvTUt5cHIxWldJbDFES0k1ZEhNeWhUTGlGZnR3Mlo4TFZhemkwQlBSWWxh?=
 =?utf-8?B?NkJlTnJwU2kzL3lobEdWU1pLMFBpYVppTWgvRFNhTmIvM0xYYnFBRlIrcXZM?=
 =?utf-8?B?RnBhOFNMb3FqTU1Pa1JIN3JSSnFRL1RlZGt3ZCttaGZweWlPVE42ZTFET3h1?=
 =?utf-8?B?dDlIcjNZdklsVzM1RjdCUHNFRDhCQ2tsK3I5U0xTU3B3NE1IQXNocFZOdEpq?=
 =?utf-8?B?elRKOCsydTNZQ1NGRE9oNzQvSnNxS3lXVTQwWkt2T3VSZ3FDRE5DZlZhMHdu?=
 =?utf-8?B?bjlJOC9XZHI2cEowTnhGZ1I1VEFyTlM0UkZaS05nUVY3T25mMGJCeVVSdlVu?=
 =?utf-8?B?dDdWRnZwSHBxc24zb3Z5b1hmY09peGZWSHBKZ1ByMFNId3ZDY3N5a0VLNVpk?=
 =?utf-8?B?U00yaFUxczkwSEFhUlVXWnRIR091ekVldjZVMU9EUytEWTU3SHlINTh0cTZy?=
 =?utf-8?B?bHBhY0NKdmNGYjFjZTRZbk9vYVZtdUFmV3VFdVhUTFhKZjcyL3YvYkRCYjdl?=
 =?utf-8?B?UEpqcFBZK2ZmVGk1dE5FdjlqeW9JQmw3SXJuR3E5NHdaazdXSHdOMGpNMnc1?=
 =?utf-8?B?Ky9kWjdqb2phUmtNMjJRZE9HemxGd3pybHl1TEVwTUF6bGppZGhXR1M0OXVt?=
 =?utf-8?B?VUQ2eHg1bVFqaWFGWVlZZ1lTSjdvYmIvUjI0L3l5Z3dBL3BOYjA3NzFpMi9q?=
 =?utf-8?B?ZkFhbXpCUGRzOTRPNzUzNHdmMlJvNkFwZmN2TXhCSzRsZWN1ME5YdGF6Y0Yz?=
 =?utf-8?B?YjdkcUhMbHh4Ly9qZUNFSHVqWGV0cnBURTk0ZkN0a0hVaVJ5QlJSRHdOby93?=
 =?utf-8?B?QTBqOE8zNE43R2daVXdzWGx5VWh2RGl3YkhYaSsvYUF5MzJQcW9jSnQ0aFI4?=
 =?utf-8?B?ZFhCdzcwN2UvYVdJdGRObEsyQ1JEV1ZENktzNVJpcDRJMlRBTzJsSkhKbE9a?=
 =?utf-8?B?UXh4OTJtVjNpejR3ZXQyZUFOclZzMG92ZjNRMytSMy9MSkxoVGpWa0FSTVVa?=
 =?utf-8?B?VTdxQ1FWd3Z5QmYyN3MxUTdWL3grOExkM0NaMkhQajM2SDBkVGVMQlNXdkl1?=
 =?utf-8?B?Mi9UTTUwQWFMNHc3OW02bS90Lzlib1hWdE51L2Y0dWo2NkpueEZxY2hWc3No?=
 =?utf-8?B?b0xxaEt0dWtuSjI1Zmovd0tKWDY2eGhpMlg3amxONnd0dnQ4NUFibDFLMUN4?=
 =?utf-8?B?NU91NC95alpZQjNsdXNzck5vS1R0U1lvdnhQSHBocXBsRWM5YWpMbXhaMGRa?=
 =?utf-8?B?ZlZyU09TMXl4QTl2MzdKTzRMZTZ2ZU9HWXRjQ2tJOWkxV0FWaVNRelNtVzN1?=
 =?utf-8?B?OXJ3bzBQeFJZMnFrRHFUQ29TMEEvb0QxSFpNNnBQem0yeXZ2emJJRVFWWVha?=
 =?utf-8?B?SjYvUXpyd0w4Z05FK0R3WU9NNEZFSG80d1FVd3JNOVpCRFJJbEJFbUFuVFQr?=
 =?utf-8?B?M0JpeXlFeUQwcXhKakJRS0dpTFFteHNTWm5iaTdnMU9QS3gvckJGVGxUclhk?=
 =?utf-8?B?Z1A5aG9KcUp5clBPT2ZSVFpQVEpTUWlTWEtRS1A2bnF1b2d3YmdHREVyditG?=
 =?utf-8?B?eU5meGp4eXR6UDFDMkFEQnpMYlh3Z2pNY003OXRGTjYzMkhoRUs2b25PeXZK?=
 =?utf-8?B?N2hralRZYlBWc1N6WTRiNXdUaDdyaGFrRFMvaTlXU1UwRkJKTXFKK3N0RTRi?=
 =?utf-8?B?Ym9peVlpUkNYYlRrZUNUdml6cERKR1J4c3I3QXMybXZHbU1ZenduZEFiVlZQ?=
 =?utf-8?B?OVpXTVpZTzdtczcyNUhZWXpsWVZUMmo3SkEvdzNyQWtBS0dWTkxMWGlxbTJw?=
 =?utf-8?B?NUNSQ2drNXhmb0tlNjZEK3VSNEN3b1BaUjg1ZysvRGdjdUtTRUdITk9IdnZK?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c66af5-5d6d-4171-45d2-08dd51c4de2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:40:14.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCqIyMHh4Ycg0jU8tkF9QTbdl54k7Hpo+RJJUdO9+H9kfro+MxSlayhl8hoYhztaiDYvb/1sRshddhtXTnGX3rcLEqhCHuPmPluphm4fPyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 20 Feb 2025 14:02:35 +0100

> Since commit 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to
> dev->netns_local"), there is no way to see if the netns_local property is
> set on a device. Let's add a netlink attribute to advertise it.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Meh, I was sure nobody looks at those read-only Ethtool "features"...

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  Documentation/netlink/specs/rt_link.yaml | 3 +++
>  include/uapi/linux/if_link.h             | 1 +
>  net/core/rtnetlink.c                     | 3 +++
>  3 files changed, 7 insertions(+)

Thanks,
Olek

