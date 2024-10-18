Return-Path: <netdev+bounces-137152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1C9A49AE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 00:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474491F249DB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AAE17BB3F;
	Fri, 18 Oct 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUCajtOt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2A7485
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290707; cv=fail; b=VEeVcoq7oBwg7mXs5IoIlSNsFgGpZp3XrZtAFxuVD+FgBEZyIFkUrnpzpiQKHnyIxa1k+uH2RTywguHfagaVvcmGS355aPANGIZraFFWzcttor1+Fg7hrVGVCU8J+gMRe4n1AJlDFr4gKYfuuWsXgATi8RHaqAM950riqrnfcOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290707; c=relaxed/simple;
	bh=pbxIYp397BaLfefGbvd9e1X4YH7J9EGQBig7e4oW67U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lv5d5ZEm6MtDJBCtfDGQwnSfCIOa6dtYPidGO25NYP/Yb/tFoqNPgTHzXKDHm2ExoUtc3XEyMosxmSG+C4pJ4QR4Tih20Qj9y/NkeTo0PNhhwbzqtTNjcxKsUt4Dwu8A86befnU503r3AWOte3xMsMT/vbODvRaFuFtbHhDOd6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUCajtOt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729290705; x=1760826705;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pbxIYp397BaLfefGbvd9e1X4YH7J9EGQBig7e4oW67U=;
  b=mUCajtOt8fyWLF+ZJLfj2X48gz3D3XKbK/hNUojQgLh5730U3zDpzfwM
   UyqH3YlyAyMFmOlpqfqkaSkEqhkybtehE4qNXiBj8SVswS9u5P2nsJL/3
   p59OIBrtj5v18Kw794QTPkAQbbHOypdJjStM3oNaYXRYUoNBfraqW1KIp
   UxiXQoq/Y1et6P6JQSffN04iZzdgTDzPAF9OURzGZJIRKRaT8hfp6SOgp
   XTJpASJ5Hz2Wcba4TtNObV7bDaTmC657mOruulfkuCzHHMItx7rc0HUlS
   BsA/JG/v2U8RLFuASh2tDpyB4e+2HavBgm/HLhVTNbfjx1ST9S775fNJh
   A==;
X-CSE-ConnectionGUID: v6lD7RLMTlutvqtRFNtzug==
X-CSE-MsgGUID: GFZGY5mkQZSaMasvDGO2/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46334683"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46334683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 15:31:44 -0700
X-CSE-ConnectionGUID: y3G1CgtgRV6hBlu1QSRz0A==
X-CSE-MsgGUID: wDaRDDCAQkGXnzn5eovFIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109816481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 15:31:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 15:31:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 15:31:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtR1F9+sh0dboJcQ5G3f22+/Lo/jYzTQlvvfMolNzJryNRc4Gax7IMhqHWdIT9L7uAU6TLiCfJLhp5ulRUmmiuQd9t+/9UZEfgszKbg3GqzzajPYK3wTOfu1/nH/huBMa1a0d5KxV0ho1uBdWAsgeErMGi6ngEFM+ScwyfHeRZLW2ieTQarv6ULp5hii/KzAi2Z8pAqC9VARWRxRM60N1pCLzg7b+pjD9TFsvbG5QRgg5c7cmgnxysJUGtlTw8MrDqr6NonkOol//NFjE2iw+hU9EF4t9QoLZIdFRia3WUbRTzPWDP6JEE1PYMruUlp761BjcbjLk4voe7FOQn3KJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLx7FcAyXGT7kTX/z+2kowAJvzGWjQnCpJqwy4IuL3w=;
 b=v0zS9aR2ssXrALzPyHi7oFHfdCgfT3OMSHKMLdOLiUKVKwD8EmI+kfDoCMHZlzAQy2MrxZFZWYmNvmOv1yw/dBN/gjBDv+8oObqMxkFUUe+iWCGC6BJu4mYVyakfhLf1VIHLqGasQZHI89XCDulmGxPC+4kFqXYiAH4/bkT+EBW/TdywdsBRjqsec7PSVo2jw7Vzg/KfNxiUdTrDqqedU53Yhk+HEzKTd0cYAg8ugztIRWch0jNCL3aeR1ylWNYb3HeEgWocUlDP0twFE5HJVPCw29QXDzvbyX2eZGTCV85WAs0CS2NIGysOQ9zY3esLFrAJGm6BUI32DunUcTRKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 22:31:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 22:31:39 +0000
Message-ID: <46e34729-cf28-4c62-bc72-02cf68c4d43a@intel.com>
Date: Fri, 18 Oct 2024 15:31:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v11 09/14] libeth: move
 idpf_rx_csum_decoded and idpf_rx_extracted
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <aleksander.lobakin@intel.com>
CC: <netdev@vger.kernel.org>
References: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
 <20241013154415.20262-10-mateusz.polchlopek@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241013154415.20262-10-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc43112-fb24-4e37-079c-08dcefc4a23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnlabVhYU3FZRVBBZVlONk03T1VKMkdzVHJxdXFsYzQxYVNETjc3Z3FsV3Iv?=
 =?utf-8?B?bHBmMFJSU1dyUjZ1TVdKOGhYRlJpbnpQSDhaR21YZWtOd082K1ZZWERwRTk4?=
 =?utf-8?B?bTlYVlNPMW10T3htVWFLeHluM3ZSb2NuTkNDNXdDQ2JRQjJ4ZWN4SlZIM1lj?=
 =?utf-8?B?V3JwbVRkMVI2bDZEengwS2lpOUVKTWNZb1ZjUzU0bEk2S0o2SmxOdldmMDFB?=
 =?utf-8?B?RTJESXlCU09wOWp0ekFaemhLcTFSeWJYeVh6dG5ONGtFVHNPanpZOUxZYTFX?=
 =?utf-8?B?cHVPWXFUUlN5aU45TWxOTENmQWZsdE5pVkpqNitCNWVwaXBDdVZ6MUljdjNL?=
 =?utf-8?B?ZVdhR2E2NjJwY2hQK3F1a3ZidVJjeFZBV0VlQnpHK0FYTDhWRGl3am5uK0cv?=
 =?utf-8?B?SXNWa01jWVZTem0wRUI1MVlQUFJLbnNNNTcxNTlzOVJacjJYVTlsN3RQQU1n?=
 =?utf-8?B?d1RMV2hnUC8zR1p4a3VVbk1zQzhMTUJsVnFPTE11czU1WDJuK2dMMjF4cGFG?=
 =?utf-8?B?bWY2YlZEeDNIUHQ1S3M5bi9FR2NaSG8wQlYzQnJ2SHU4eEMxZHI5OE1NZzI4?=
 =?utf-8?B?SnhBZmZlRVoxam5zRExpV0FmbVlGWlVpdXBPY1JPUWhrZWo5a1cvWGJtVkpm?=
 =?utf-8?B?VUwxK1hQak1XdGMzMGptdkdzY2MvUUxWeXNYbVpNSnFXMmVlcFlEelJwZHRy?=
 =?utf-8?B?aUxiR08wRDBFTG1wL25wdGlYZFRZTGpUcGtJQmtVazVDVGwza1JIMXhWUHA0?=
 =?utf-8?B?SG9FL3NvZjd4ZEpMcHZ4Z0VmaDMzUUt1dmJGL0tvaXUzaGpTWXV0QlRxTW9q?=
 =?utf-8?B?Q2pSN2Fac3J4b3FkV1dmOGNJZEQyY2RRMnl6ZWlwVFdUcXpodzZNSzdRT2pn?=
 =?utf-8?B?bTRiNldOY1lFRWl3OWRzYWltamphRXNZWHdoL2hGaTdKMVA4U29Xc3l2RlI0?=
 =?utf-8?B?YWdjT0lWaENWS05NdDBicTNVYkY1TDJ0cCtlT0IxbloyM1phQVlHQlVvazR5?=
 =?utf-8?B?bXBMS3hVbUFFSmFmM1JqWlVPTDQ4NDZia2ZWaVd4R2xOWmppa2ZpRThHVmZ3?=
 =?utf-8?B?eGVMWGRicitEWTc0VFJiNmFxK2ZOejRmTkhlQWFiRi9wM08yVXVTTzNXbTdn?=
 =?utf-8?B?eW9vVjlyM3hhOWRkbng2b2Y4OFNrWDVCS2lJaVZITktHdm1PcFVCQW90czNN?=
 =?utf-8?B?d3JMK0E2MXZwaGNMcUxzT0pkbW1CNll6Sko2NmxQZmFBUGFTUEtKWXB4MGxM?=
 =?utf-8?B?WHVDRHM3Zmk5Ykk2dXBiOEsxeENwYWVJMmVZbzZ4TitIKzZld0YrcnlFM29w?=
 =?utf-8?B?Q0pKRi8zRG5aV0RlRnJYaEd3Vk8wWC9ZazYvaFhYdUhQNkgrc0tWUWNxUmxh?=
 =?utf-8?B?TzU5VDVKejQxRXltaksxTTVEZnY5RTFWTU5qWmwvSGk1RnFzYlBuNm5NV21w?=
 =?utf-8?B?TEJvLzNrNTFadWlzOFNDNitKSGZvbDEza0RKWXR3ckVnelU2YzNnZjhTMjIw?=
 =?utf-8?B?emsvYXJxVkh6SURldWJwQjVrTWxUQ3VzWXBEQkczR2pNTFJhUWM4blhvbDdM?=
 =?utf-8?B?SHZHM0lwNDFtdUQ2VnBrc0F5RzU0YVA1c1dzRFZnNnhuQWhBWG1wZzB2K2Ny?=
 =?utf-8?B?ZE9oQU9tTFNjK1RFTHpVMzhVZi9Edk1iS1BCanQzY2x5S1JWZEtHUXZTS2E4?=
 =?utf-8?B?NExlRHlVemFoN0N4ZkRGZ3ZaU09GS2hQM3UreHlqTWtQYXFYcmE3ZXc3bjFs?=
 =?utf-8?Q?nUYRORTBOq22pDfl6o45e02MG6F74XRLwl4Peif?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlHdUIxeU5sQUZEMElMWTZKK1R2bzk0Q3FyOTNzQ3R5bWhrMGVYWGJIcDk2?=
 =?utf-8?B?Y3haR3JJK1l4d0RIM0N6SWsrODkrUFIybTFuaTN4WE0wb0pyVVl1ZXI4alpp?=
 =?utf-8?B?SVNTWURObityY0dRWlZZQkRjSUhIcGVEdWZMWE9jcThHQkQvdjdaWDJ5VnBI?=
 =?utf-8?B?VG5PMlJlbmY1NmdXSzJ1ajU5M2dmdnI4dU4xMVpyajkvaWJlTEVvMWlrZndT?=
 =?utf-8?B?RzBjbDBrZVl3WEU0UllWM2hpM0dKc1QxN1hMUDJUS3RvL05vVTVMYVFiWGo3?=
 =?utf-8?B?OG1mdVJKVUJXUE5Zb2krMVAza0xsTGt2dndiUW1RRStPaUhUSXRBVmpuT3Vn?=
 =?utf-8?B?bVF0Rk1OcWlMR3RweGhsNG55VStVeWV0UlI4ZUx0YzRYQis4VEp2VGJPQU90?=
 =?utf-8?B?Z05Db1ljV0wyME01akhuL3dJcjFScWVnUGd6Yjk1bzNBM252NDdxMzNBaFVs?=
 =?utf-8?B?ZlpxWi9LbDFIZDlHS1d0TUtVUStmKzZUTGlwMVg5UlRZeGl2OEo3U1lHaVFU?=
 =?utf-8?B?UkhzajJZSkFSUndqelpJSXdBOGN1Ym1LVmFSNWZyWnI0SVR6UjAwNmtrT2Vw?=
 =?utf-8?B?bE95UkEwaHdaTUY2WC9CNHdzTnh6VHJEN1hDZFQzVi9TZ2xZSmVzdlZLZnFZ?=
 =?utf-8?B?VkY4RUI0MUYrM3A4MVpyaWJ3cXI4c0h5N0RRdWdnb1liMzdVelE0R0xKZEE1?=
 =?utf-8?B?bjAzMkpuemM3RGttQVNma0d0K2xyVFBad0MwQ0RuZWpUK1p6K2FWKzM2elV2?=
 =?utf-8?B?bDhHeHJNM2ZmL2NJMjN4NXNaY2pLUU9iNHkvNkdqY0toazdqb1owT0dKTGQ3?=
 =?utf-8?B?VUYyd1o5c3JjRE1lakdWODlZTFhiWHk5NlZ0QTQvcklZRWxNKy9YMUczblU0?=
 =?utf-8?B?bTFvV0p4SGMzYzBLQ2lKY0duMnU3QVBRN1hOQkQzZ0Q4aWxLcTV3VWlBZUhl?=
 =?utf-8?B?N2dVWmlSZ3V2bHJxTWhjNVJ0ODdjdW4rK2V1ZThwYXlKbzNvREtIVFFsQkxX?=
 =?utf-8?B?bzEvVmJIQ0M4cU5GWSszWTlzd3NUaU1qZjJ3V1AyMU5hWFJkUFYrUkVlTHRw?=
 =?utf-8?B?dU5XVEI0d0pjdmlROFFPbTMzNUtyQ3lZVERiSkFTcUlINVU4YUlpZkxneG12?=
 =?utf-8?B?VWFVTkE1NG1lYUxGTzhjRjdVQ0JOY014NzRldWZxMnAyb2h5OEtmblhvcXJP?=
 =?utf-8?B?VmV0MU9aZUd1VkcwKzRUWERUVkFKT0d3U2M4RWNaSE1DcjJES3AyUkl0QzVB?=
 =?utf-8?B?RVJ3N0NtbjF3OWtDZjkvOTRLK2o3bW5XTHV1YlYxQzlNeXpkTkZUanVPWWpN?=
 =?utf-8?B?QjNQWkR0UmpNUzVSSC9RUEF0Umdid1lUSTZ5NHZyc0hNSmNHQ2lVY1VuS2xh?=
 =?utf-8?B?TndBSDFnVTJsRGZIV3RjbG1QNkV6Tmptd2lidHYzZjhQK2RIT1pHOTBDZ1gr?=
 =?utf-8?B?OHR5aVNkNDFWOEJmWCtMRHphaVBadU83R2FxOE1Xb0I3ZXBYZTk2SE9VTys1?=
 =?utf-8?B?NjdFbWtObkJFc3hEcGd6c29RNzBrakU2TFVlU0hSbkE0dlV6UjNSL0lFZ211?=
 =?utf-8?B?WWNnUmlLaW5ESEFuWVdTMVlYOThUNVU5dnlFTTBxMHlqWmNHNHFaM0Nac0xK?=
 =?utf-8?B?Z053OHlEQlNRZ0txL1V4eVZWeEJzclIvTldoajRXVVl5Sys5RDhFYnFQeXhJ?=
 =?utf-8?B?WTlKQzFicHhXNUloU0o1c3dwZTYvcmdYeEZlekhLN0xQNU12NUpqZlRxY0pB?=
 =?utf-8?B?T2FkNVI2VlVaUFppMVMzdkZHNkhrZktQbG95akFvM3o0ZGZnaVQranJHY2Zz?=
 =?utf-8?B?YkZCN0NmV1hXRWdPR3d2Tm1MZ0psTFErbncwa3BDUVB1dWNoSFcyS1dmSDdn?=
 =?utf-8?B?NzJKSFh2d1JYVC9Dd3VYRTZnRjZZQjVTTlJodnZtS3Q3K2RsNmM4QkZzR1Qv?=
 =?utf-8?B?RUQwa0lmOFFVcDd1UmUzSTVTcEwvb3duZEcvZm1nRm1RdzFrUG5CMkFDeFY3?=
 =?utf-8?B?Y25UL2pqWUV5bGdpNmtYVEJ6N2gxcUxxcVhmdE5EOTZYV0FSdXpLaytLek1p?=
 =?utf-8?B?QkwzWmR3enJ1WStzWDBWL1dVNUs0M1UycHlidUJZNGZ4UGpjVGIvNS92SCtH?=
 =?utf-8?B?RXZ6UnpVUFp4WWpTT2FLNEthTHBkbFl3WU1POUVka0Q2VThqOEZyQ3BzaGtw?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc43112-fb24-4e37-079c-08dcefc4a23d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:31:39.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLxhTEWcb0RzUNq+5QA6+p61ret1tYddUU6ukyQSP+rs9i15K9avchUlwmzh9m+MZKnZFbQ8dARKCcw3ubf/JXqYv9uEH5JWija8hauNoYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com



On 10/13/2024 8:44 AM, Mateusz Polchlopek wrote:
> Structs idpf_rx_csum_decoded and idpf_rx_extracted are used both in
> idpf and iavf Intel drivers. Change the prefix from idpf_* to libeth_*
> and move mentioned structs to libeth's rx.h header file.
> 
> Adjust usage in idpf driver.
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---

This fails to compile:

> drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c: In function ‘idpf_rx_singleq_clean’:
> drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c:1040:78: error: expected ‘;’ before ‘napi_gro_receive’
>  1040 |                 idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype)
>       |                                                                              ^
>       |                                                                              ;
> ......
>  1043 |                 napi_gro_receive(rx_q->pp->p.napi, skb);
>       |                 ~~~~~~~~~~~~~~~~

Thanks,
Jake

