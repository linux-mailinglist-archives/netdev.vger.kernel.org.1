Return-Path: <netdev+bounces-127935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907697715B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A7A287E17
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6B1C1AB4;
	Thu, 12 Sep 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxoaOfwr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EA1C4606
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168456; cv=fail; b=FWviGBg2vSGDBWpK1iATW1TvT1DmD2+BbZNEjnGxk2IM75sQBP1y2Q/tr1pbzLccRKnAfPfAJMDGTdzJG/VkbbsxcEOHAqAzuGbNDMO8MpqAl4lBjW9U0gwXlHmw4R2qKFwj9BqM5uxGx4LuxAbhyLtAbD/s7WXK/YotWyz9duM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168456; c=relaxed/simple;
	bh=zO4VnEK1Pc0ETZcP7ppay1tG1n+n+td1qvmcnoNkwmo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qoEzqvDKjzGQ+X99kd/eERKYBZ72XPobovPVE8MPjOSe7n4TnoVaWNrRYEpperJAPOyxE3wA3KR+vZCAepIKQXpb/TudFUkfTejrpVnoG9KQOJ+rfAXM9quiiRFnhwiYOy5aEvf+XIlEx1sKdjIbsS/d3nq5317Gh1OEc4VQ/hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxoaOfwr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168455; x=1757704455;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zO4VnEK1Pc0ETZcP7ppay1tG1n+n+td1qvmcnoNkwmo=;
  b=kxoaOfwrG9V3XWxcpU2h7uNTqeWxnz52kCmIzYV8/GoeBk7xD/mvHAcJ
   MHD6LzOad9morstbz1zX0fnyx/U2OtRC/IQDU7tqHb79Ddl3vOBelxhiO
   MGHKqxDVTCRtIfGQ9EqkIj7Qe15rhej/4Ai4nIz76X88exlaxB5mG2PVX
   YBvUml5tyitO3OjJa5FrBy3asy41ytC/NNd//gO+qtrQ2ezd474C/SljK
   ZA4TwfIYcQUwnp+yq5Ejopw5wWbeWXOuSC84o3FKgAJ59yC0kH04mmWL4
   G9WYHCGRSdrynYm0DQZDgiY/ZQpithG3dUakslCekH7aVugZ/1a9tv62f
   w==;
X-CSE-ConnectionGUID: 1Z6Umn/9RU62WY5dK6OCdw==
X-CSE-MsgGUID: 0QxJXdk2SyOwlUwWyVJsZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36396213"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36396213"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:14:14 -0700
X-CSE-ConnectionGUID: ZIIDurC8S+Ol4oF616KK0A==
X-CSE-MsgGUID: gXb0GmAjQw29eogR+kkg9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67516964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:14:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:14:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:14:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEucXbJAB5jQKYl9qFNjFpxr7yPlgD1jMhYcpFb9Ay8+iqxfzVbtAYvj9AiV52LIykmu2PW961V37sk7iYb01vdXD8oE+L/l3Gn7PyLlL7fqF6/DKGiaFkD0i9trpmZcaL9k7XqcRUIbXR6rCwdJKnwhw2ED0wgLts8VHWOy1//8C6P0XjmX21znPdPxoFpsB7PHrh9wZ7b2i6in8a1Hnm6S6o0hDgBJGgRzxtZiYymz0/grgwIq7Ae90+JZFBQP63/Gcy6Ny9fYsAPTXylK8X+nOPfRdB8lYbWz9rD9BSH75GXGtwrn56VmaL98MAaKGvGRvUNBrRPwqyG4wiby8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPh2O5g5A8AEhTstn16PfepPsVtbaGkNLwv9Orcd2A4=;
 b=IRB6PWCtnxtpVpFk+13UeXRGkXFFIU9iVGLmyvXdlii7IF5O8LMUG9gGQqk84nWFod8ade7EEKjApo9knAa0BMvJZI7DMW+WqQtYagjEap8o8EabwaYPZpNuL3TYsDFceJFhPt7Flr/Q9qb8T4Uwbqo41C3Rg6zD7A6jNawXLiZCAGyB4xqvumTgykmDPEY4nSDj2RcF21TRzqX6F10ZvaLTDGmrXyCSm9vhdHUtsbuxUeB1NVOinuo8uB8sWAF4iIxlZqucq7pw1BImVrBd5SXeDuDhhfcW5onrOLvooKks7QbMp6EGo8ncPyq5296VmT+6fn1k9LGcEccc3rhZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:14:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:14:09 +0000
Message-ID: <7348333e-1b2e-468c-b8ab-cc10b2d711c8@intel.com>
Date: Thu, 12 Sep 2024 12:14:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 13/15] net/mlx5: Add NOT_READY command return status
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-14-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-14-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c07063-5b75-4aaa-67e8-08dcd35f1444
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZpcmJyZFVjbVlxY0pBK2pRdkVoZllyeE9xMEwySUNBSmsvQWtDaTdqQVNl?=
 =?utf-8?B?bGFEV09ibVlPU3hWM0F2amozTm1sME5HRlVid29MT0FpZG1KMkp0WlRGV1A1?=
 =?utf-8?B?bkRHc2h3TTVsTkhQVnQyTk9xbWsxUDVzNkpoVUtpZmRrSFRpUVZIZXhlZ2hM?=
 =?utf-8?B?Y0tqQnI3V0psa1FWZHpnenppaUd6NVJ0dmM0ZHk4ZVQ0czJCUGlXU21HeGdV?=
 =?utf-8?B?bGYzOG0zZ2JuYmR5cDIvMXFQbmdDTUxEbTI5OUlub2pmenZGTzZ2K1FDajh1?=
 =?utf-8?B?Y2sreXozd1B5NEx4ZFpHUldZTHcxdEM5WVRraGt4Z0V3UzJYK1JTZVhXRW9E?=
 =?utf-8?B?ZGpwMktiSkk0SEMxZ3VjRG1UejNyS2k5bWJhalRNN2dPT0x5d2xjYTNlcjFr?=
 =?utf-8?B?SFBrb3g3clZ2SExteWxEdVByUVdhOVo0VXhKdE8vYzB5aDVyZ3VoVEZocWpG?=
 =?utf-8?B?ZEFWdzV1UllQeGh5bGFSZGlyN3RaTis0cVl4cWhVdkdlSXZpbzQyazQvUE1G?=
 =?utf-8?B?TndDRFZHWndUYmZteFc4VUc0VjFVQWdxdzQxSWpUTUp4YUQ2NzZ6UTc2bnVw?=
 =?utf-8?B?MU04RnF2RUUrOXBHTEFkT3c1cG01Q1krbXEvTzREWTBPWGx6eGVoMjFzaWlI?=
 =?utf-8?B?VENqOU04cFVGdGJXMUdhc011Rk15QWFIUEhaMzZ3bzRZSE5jeFd2bjdOdVov?=
 =?utf-8?B?S05FMXZGOFdlUnp4UUdNZnBQbm5NYnFhVEtrTEhzTGpNYVF5MEprS25USHU4?=
 =?utf-8?B?K0JGVjYrSWQ4NmJudTZyL1hHaytGRDNvY3NkdEJkTWoyeldUeEhDeUd5aHhX?=
 =?utf-8?B?bCtvVEFFTWEzRnpwNkl1YXNLYzJKaW1zY08zRytNZzVtckJhUEhRZUhWUVF0?=
 =?utf-8?B?cG4zYnloQXBxa0hkdGdnc1RkekpXYk9RRkQyQnVqSVcxVWljMEdQaXZhY1ZY?=
 =?utf-8?B?N3BoZDFTTnNOOCt1WDI3bmNnRGViSENMYnY1dC9FVFhaZkZzMGZncFJpUUhF?=
 =?utf-8?B?NmQzWldBblhaZVRBeWhKSUpJMWZUbTB5U3B0UHZqUGdVTjZneVkwUEVXWEs4?=
 =?utf-8?B?V0xMNFE2M1FuU0ViWUowS09laEV2bDMwVjJta2lhanQycGYyREFZaFlkSTJa?=
 =?utf-8?B?aDhUeEVMbSt1MGdzL0hLcHMvV0M0ZDBJWnRCVWxjOWNnL1p3QzlEU1ZhNW9k?=
 =?utf-8?B?LzBtSFA4QTFjOFk2d2pOV0VuQ1pubnRGNmFWMityU1BNT2xNa1VVOWxKZVpi?=
 =?utf-8?B?bVhkTHlMNVZaY1Zlalh1M2F3MkI3TlVhMGxla2tqZHVmK0NDNThRWm9YeERC?=
 =?utf-8?B?aXFlMyt3andnVlluc2xMM0lkUjBhYnlqV1NVQ1ZrZHIwU1pvZEpjRkpGRUEw?=
 =?utf-8?B?MG9leUFLZHdqOGwxMjBuZm5JL2VVRXdHSjVUZ0lwTmZIWDN5L2dQd0JYTENR?=
 =?utf-8?B?TzNoUFV2QnRDdGtvcnZiOGpEVUZobmNZcWhrY2JhYUFMMzg0bzR4TUFFSFI5?=
 =?utf-8?B?L1BTWHd6aFZhRHhmdm1qM2k3UFNkU0pDbnc4WE1zOW0yS0FUVTJrODM2TzFi?=
 =?utf-8?B?YTQrOFNEKzZ2aWRJN2wxNytFSUFRTndYVStZZ3NRU3RyN1V4aXRETlUwdklu?=
 =?utf-8?B?Nmtha0FtN0xub2wyN0xLNWZmMW9FRHpUd2h0VGtSVXVaN1FMNlJJc3NkcGJI?=
 =?utf-8?B?T0FVcDFQQ0RMNUt2VDAyTHdkM2x1TXJoU2IxZnpsb0EvbXdCb1o0eFA5ZDJt?=
 =?utf-8?B?SHVoZ2pOK1RjeG94RjJKWXBCbWh6dE85aWtWT0RTdXhjdStBREQ5c2FjVm5V?=
 =?utf-8?B?RDg0Mkp1Sis2NlVGTE9ndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFIwK20yVlJ6U2p4QXFmclBMWSthc0lHK1h1T2xNK1AzOWNxZGNrWVlUQ0NX?=
 =?utf-8?B?WmxqNHBQNXZYTU82UnpPRHdqN0Vkb2hUMmNmajQxcmIrNzl0MWltam8zdDA4?=
 =?utf-8?B?aUpsbUZIWkZrMFJ0LzZKbWdSbEhuZXl3aGtxdWl6aDhIa29xdjZKS3N1VWpa?=
 =?utf-8?B?dFZYdE9LeVpOQzJtQkt4MWdrTUJCQVk0TlEyRjZpNVZ5a0lHRDQrSXRES2d2?=
 =?utf-8?B?ZVY0eVh5QVNaVHF6Z1gyVTdzMDBDeDcySk95N0REYUVMWEM1QzBsOGpKMElS?=
 =?utf-8?B?cGZud2RIMXU0VTZGZm9RR0E5MS9nNDZhS2FSWklGdGZWZHdOVUhZWURJOW1F?=
 =?utf-8?B?ckI4SlBMZnk0RjFSSzU5V1dHVU5mOVZjZEhmdzVDeUZua0VGcStCTlROeE0z?=
 =?utf-8?B?RkcxSFFpcEtPK1o2aXhHZFNrS1dPbmc4UThDL3pxOHViUExCL2tvZzNUWllK?=
 =?utf-8?B?eld1eWhVWEJRMFRkcS8wRExpS3lHNlhISGY1VXFNakFlVFlqZk5EK3JtdjR1?=
 =?utf-8?B?cVM4bE51cnJ2bTVOSUp4czQxRWUrVXRQRkVIeERsSllXeVVxa09LMllZaDNN?=
 =?utf-8?B?dzk3akpGeDVneVRVeWMyaWZCekg0eXAvQmdsazBVcHFrSHpVVDRVQjFqQUor?=
 =?utf-8?B?SGsvbmRPT1duS1lYZHJDUmNvSVBPMnRXT0RXejc1K1BZRDJjdEVReHdzNEVJ?=
 =?utf-8?B?emtzZHVPU0NFOVlHMzVPRWZRM25DaXArTGZpbUpnSEJtOExBYmFlQlJ2dWZz?=
 =?utf-8?B?SEJ6RHBYQ1lYVllueXZtMko3T0hUUFhDZHBWODF1TW5YQ1NnSmhQOE9mdG55?=
 =?utf-8?B?M1Z6SWVNTW9NOGFDTit2WDk3UUxxVTQ1T2VLWlozUTBNNHNxdmU2S2pPYmdD?=
 =?utf-8?B?bnF6bjJ2V0hsV2plamtGM1FhQVpqek1zdyt2NDhqTnRJNFZJUlptZFdpSDc1?=
 =?utf-8?B?Q3JadHhjcEVjUHhhODlMZzdKeVFMVVlSQ293dkZGTlozUVBjOGw2Ykdvb2NC?=
 =?utf-8?B?VloxdTZoQkc5QXBkTW9Bb2h4aEZRMXhwZEFHQXhmTHJFRi8xS0N3TjhDRURh?=
 =?utf-8?B?SndPS3JMWjRwUEtLelZUdERBcHFJeDc2TXRzSGZrZzlodVNhekd3OTMxaTc1?=
 =?utf-8?B?MGwrOTZtM01ybkVwcUU0U2lGV25Cd1VBRXJJajNTa1o0UEpuVitUbEVhTVJ3?=
 =?utf-8?B?MUdJd3REOGxPWkV5ZENlci9vNitXZGR4MGpGeHNFdzBNVlBjQUdXM3VhUWFv?=
 =?utf-8?B?cjFnaWtXSmlDdzA2eE5kSzBOb1JOakEzTmxRSlk2Qm1Rb1NnZTJRSVh0V2Zn?=
 =?utf-8?B?NXJNbGVqcHNLejhkY1NKOGZocHB6S3FIWjFkZG5XR2FoaGFQMmtHMmlNQVI0?=
 =?utf-8?B?NUk3WVBRblk4M0o1aUVGME9lZlFhcDd4WmZoVnlPRmVyaENxMVlhRW5BSUJz?=
 =?utf-8?B?VVNKSlZtMmRCTnM3NXYvQTJwNFQweXUyclN5d0gzNkdhMzIvRUZWN1A3QVU2?=
 =?utf-8?B?MmxnSGpyWW81VTRzZWdLRzhVU3lTbFN1anF1UnQrZjAwd0hGSC9UQ05RdEd3?=
 =?utf-8?B?bVBKbHN5NXhTYlNVVHZKRGpKcmZnL1cxYjUwUDVlUk1JcHJJYlFGd3lZb2tO?=
 =?utf-8?B?dHF1VmlTemR4cmJwRFlyc0RsYTd3TjNzU2c1WElwdlIrazl4VUpUNWRpMVdY?=
 =?utf-8?B?SzBLQS9QMGxFSjBEbU8xKzltWno1QWkvcDh4RFpjZDlVRXhiYWQ3Y3FockdW?=
 =?utf-8?B?dHRyT0RWK0Y0ZFpGT2xyZ3NrUXlFOGRNdVZneHlKZUgwQUQrNERWbVJtWCtP?=
 =?utf-8?B?b3pvMC85dWQ5NVBuVUZBb1NWRG9pODZYNDRwU3JQRFlaNjZEL1h0dEl6V21u?=
 =?utf-8?B?VGQ4eE9LUUw0QTdiYklzd1NNZm1FVTRqNjVmT0JqSUJkbWpiaGFnQTlQNlFs?=
 =?utf-8?B?Z3J4Y2k4cXRvczJnZ2NnZ0pYUFpodUhHaVVISnJTV0tod1F6bXNQbklqS1JS?=
 =?utf-8?B?bUo1ZGlVMDdaNmE0SFBtR2tKVXZBVEN0S2VqL2ZQSTR2eWRqcWRVR1dqcFl3?=
 =?utf-8?B?dms5YlhxUnVtWFJONGNCNVJhL2NuY2ljNWlwUld4cnlHMlFSeFMvSXNZZVMw?=
 =?utf-8?B?SGZKS3NnRlNUR0E5bGpLejcyWE1vWFpKQldpTGdsMEM2aXpBdkg3K280RVhn?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c07063-5b75-4aaa-67e8-08dcd35f1444
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:14:09.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZiK/Aba5RFcf3nGK2wugKn1tr0zGMYhDJ5EKadWZagnVNIVgMZJReSNhEVZs7sUm1ZrKCwu3TlZMwyPTEKDBlihhJrvqj0I/VmRCMJDA2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Add a new command status MLX5_CMD_STAT_NOT_READY to handle cases
> where the firmware is not ready.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

