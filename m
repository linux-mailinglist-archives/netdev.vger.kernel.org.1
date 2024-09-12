Return-Path: <netdev+bounces-127921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1E9770F3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A05FB230DA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185CC1BF816;
	Thu, 12 Sep 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbFE+qJj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C0188925
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167138; cv=fail; b=dqNo1skMvGSK5RQhn89Rv9i5MVu8bg0E2n3LLFRD6e82gVEHViIFJ3cCD6L4ahG+oRTXGpi2TBA16eUtHApxXvVXNc1YzpW5mYKTgWAlNvBw2jAD2DvMWhEFxYk8ZO933LDiprXRetzXoqP7Aaky1MV5mYvqrGe/Yaoxma6LHvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167138; c=relaxed/simple;
	bh=j6mX14cExZ3vg1KvVjmsjyU6XHdVTPeSED/DUwx3wKg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LV4hsY3RS2kry69O1fQukSufhjsddZsENV0x0bXr4rzGMXFnks+RFGmdVGEUzZoP+8Rz0Cbrcdw/1PxUNx9TuCNntGefiOwdVelhp5H9O8rKGFSNS4Icb/VRU1Avt/m/8Wp/aUJbtcUbq3I+FOylJ/IEL1Vy8ZlSfjIvtrAhzxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbFE+qJj; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167136; x=1757703136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j6mX14cExZ3vg1KvVjmsjyU6XHdVTPeSED/DUwx3wKg=;
  b=EbFE+qJjpq8+B46iiECRm+TE7JZyKZgKGY+Z4dqQresSCT0kuXu0eMS1
   fVJFfJ5BHIH2/kKZmDBeJmghL520JUnKC4FOoZNSa+iqS+0SzhHTEJGC0
   1htvtKQn9drRVHSovpEoFK4zwIfv3YCDIE7v2dkWGHsseOUuGC/BYBtAK
   fIsyYGHMWCQsxH9EE29Mk4AxUWXnRAS2J8sMUixebnq4F3xombwUIWvd8
   GfF/wcgO5FsiKHaKB+ba/9jLYttoS2AFPE4du7gbd/S7flcr3Z4tJxKGe
   HiLjV8vh2LWfhuh7+rr9KCkxuPMBdhhuXRCEonPZ0kLhTxMvkaIBxj+95
   g==;
X-CSE-ConnectionGUID: BpBm+m2FQVK4aBkd+BpXCw==
X-CSE-MsgGUID: XUR+hB78TRG6PqjKxVAYsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="13500915"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13500915"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:52:16 -0700
X-CSE-ConnectionGUID: eM6QQG4tRlGBYph1BpW1MQ==
X-CSE-MsgGUID: ADC3TFTGRkOl3LOKbyuF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67735218"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 11:52:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 11:52:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 11:52:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHucuFFjAby3OzhlCjIrVtcmuehviV3EnCHn16320kGhQfB5aOGq2I974Qumutq0YfR4bIkgmmFDRhY2MJKDNMYqMXIKOkAyBsU0h+h5cU5XE32hsSYbvJwBlhTvl9I4zOYA2KbUDcLJ521iswyEusJoDUuOrGcYQK69stXiOlvridZM3yoIaal2RixqlboI8XeSQnV7dwcoDSK7+nxfcWpwxKD74Dhn5cScT0GmVk6HrE8xSkiffHNW/S3Xx04kdmX8XJL5dLROtaBEpURlU8QszsoXXvgFaT2XXoT/NLv1oYYJwqBTvBj61yn9O42aR5ZH2R6L9TOYXBkGI0e8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzJwKP15IKKtMb43/lL/CFK300R7gjAqYeiQg85SgE4=;
 b=p7KMrEpC1Ho/tgj8uKBlJtgIeggA9fX7UUvP19Yj3GDdqah2RFKqN6yxTW7ropDmcny2ktNs4j5xztV4R+s/Gl0ci5tj0p4hkEhQyI4kq+2kDlU1fhp2aj8zF+xj5nCUBiVb/kOuxdYrxtxXKod0iYdu4zpn0VNFqc53sQiOhOAy6/l4b7SYmBuRo47UavH0hYv3NQVBNgdzL9cF5SXZdPLhNsal2Uq66PxRknCf0REuA6di/VT5Jz8YZsVUeQkZf2jisYufuBSiOoU5a+TXUB882qGgKcThbjiXfuGim/6lj4ZbKdj/sTK3dHG9TwITRrC9PbL/KHuLrL6wPWfIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 18:52:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 18:52:05 +0000
Message-ID: <40c3efe2-4cac-4483-a77e-c114a70a6b1f@intel.com>
Date: Thu, 12 Sep 2024 11:52:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 01/15] net/mlx5: HWS, updated API functions comments to
 kernel doc
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-2-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-2-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d103ec-32f8-45cf-fd2e-08dcd35bfeb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3NBSFRnNVhWeHdOM0J5ZU00OVBHbkpKQldic3JvVWh2UHNiZE14bU51c1I5?=
 =?utf-8?B?OTVGREg3bHF0Vm1jajhCU0VxYU96WHVyOFdWVjdiMmlEMEFXS2M3YVlyaUdj?=
 =?utf-8?B?VGh1VUZPR2kyNnZJU0F6QjBBeFF0R2NnM1oyZi9rYk1UNmFzMzRvQzZadDFT?=
 =?utf-8?B?Smg5RDlKNm5mdUJJdmxxRGJpam1KQVJwS2VMdDlTajdhSm5wWXExM3RqbmRO?=
 =?utf-8?B?eVR5N3g1UFdPYVhWTW8zdkhCRzFQK0UwbEM4bmVpNG9tL2tHUzE2SjdvdEhH?=
 =?utf-8?B?blZiQ0J5U1dsYkFLdTJsTUxoc0RNU3d4dkdFNStCZGhRSytUUnRaOFY0eS9t?=
 =?utf-8?B?UXErakZwRjNwbVFnWEtqRTNCcit5Q3cxbnNzSytpWERVYmxVb0FtYXNsdUxo?=
 =?utf-8?B?VURoZzZvUCtKalNiS0ZvNElkWTc3eTdPaS9rOFhWR0hlUHA0ZEhWYlZpU2tt?=
 =?utf-8?B?VTU2SE9QZTZQSjl6eVBab1J6ZDBRV2c5ZHhRN3JmVFdKdXN3dHRuVUo0Wjgy?=
 =?utf-8?B?OEdBNDNTWUdSTXova0tkWExldCt5Qm1HWDVMdFhjdUhRTVZyOE1qRm1TVkxK?=
 =?utf-8?B?aDVLdnFGeUpPRmx3bmZaS3hwM2FGWWQ4amRjTURvcjFjTFFDeE1mWExkZ3cv?=
 =?utf-8?B?WHJJeVJzZG92a1g0bENmUmNwSFpXMnV3dTFLSS82eFB2VUtOenJnZXM4K3Bw?=
 =?utf-8?B?YnA5V3QzTlY3cmxGdDc5bXdqc04wdW1BQU90eTFTa3Y5ZWpoQjBZTGwra1hW?=
 =?utf-8?B?cG1sTm8vRVNIYmRzaTV0OThPdy9vOVA2SFd6R0ZUWVJZa3RQQ1RVV1JWMGVO?=
 =?utf-8?B?aTZuajhqbzZvU1dSQnl3b0hla1FiZEVLWkZVNkQzaWtVaTRJVHNDekV6S0xF?=
 =?utf-8?B?R1dzMVVUTlJMd09KcjdPeXhPWUJqNHRYTmZLRll3enlaMEdNS1Fud1RhMi94?=
 =?utf-8?B?T1FwUUw2SS9WTnYrQ2xqZDlGVzU4Z2lXbE1FK0tHb0tYL3BvcE9UTGlaTFdi?=
 =?utf-8?B?cDZPVjBEM2hxbVZrcmFoVzQyWS9lek5ZYzRaeEZIWHB1TzlEYmE2Tmd2b1Fi?=
 =?utf-8?B?OSsxMDZZUThSdUl2Zm5zRnZGSW9FM2VqUnZPSDdVQTlFdE5MVFNLL3hRMkRi?=
 =?utf-8?B?UlVWZng3NVJ6YjdYaDJUb2RuNXpvRkY0Qm55aXBYUm9CZW1kODFuVHBWcTNT?=
 =?utf-8?B?M2pZdTR1TGRpTmFxVlhmbVg0T3VJclBYOEo0WHNpWFFQQXI0Y0FkZ0F3bURr?=
 =?utf-8?B?U1hQTHdLZzFFN3Y5OGxYYWcwdCs0RVFGamN6cTVvbFZnZUVHTUk1dVV0WHU2?=
 =?utf-8?B?M2wrNGxQVHJnUVhQT1FMRGViNDF3ZitoYlQ3czV5NTBLdnFseTI0eGl1M1dY?=
 =?utf-8?B?UEt5aTBXaURWdldRaXg3U01VbXF6MDhPR2pJdE1iQXlsWHVOS0VETDRlY0s0?=
 =?utf-8?B?N3ppUWsyL2VtMG4rMUNjSmRib3pJWnpORTh5VEQ0clpOMndLSkhTU1FGOUIz?=
 =?utf-8?B?TXpCS0ZqVW9nM0JwL0JEa0I0a01rRFV3Z3JLdXRTVkE1ZFN3Y24zWWQ0OUlm?=
 =?utf-8?B?OFk0U3JTVGNwRWdSTVhlRVA2U3VLM2pRQVRvOWdiZFhTdk5ZbW0zR1FyQVh1?=
 =?utf-8?B?TVl2YnFQdTh6OHVxQ2R4VWNGQWt2dkZHT1NCNE53blZjdkJYRUt3UXNaVGVh?=
 =?utf-8?B?Q1V3VmRHZy92N2R2NjMxNVF4ZTVQUnBrd0pxTk11ZjFmQ1N4NUdMdnVwWGNM?=
 =?utf-8?B?b2gxYkhnQWYrM2Nlb0VlMWN0QjM4bWg3WGtJUC8wOGQ3a052L2VESlhLMFAy?=
 =?utf-8?B?QllqS2twSm5TMlY0bUs0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9UeGxhem9JMlZScS9GM1ZuZjNGZzZtVEJ0dEtyZ0h0c2xiODN3SlkyeG8r?=
 =?utf-8?B?NnExcEd2MHY2K1l1YStCUzJGaWRVTjh5alQxUXFBVzVVcXZsT0I0Vk5NRzVq?=
 =?utf-8?B?dXE1K3pDU1ZlUlFTK1VFUmtVYytyTEZVYk5icU9ybnFndi92UGhNeThtVU4z?=
 =?utf-8?B?NEJraXAzN01jTXFXelRzSjIzalJZZnFJTGJTWFBKQVJRR0t0OFVpQXlPOXh3?=
 =?utf-8?B?NnZaamg1QStKcnFOUjZZc1REMUQzcmhaUWluZndPaktpbmlUWkxwZ3dFdXJi?=
 =?utf-8?B?MWsyZjlBS2IxM29lWElLLzlCWFdYZDNlWTFNNDdieXBKamc0TURDY0FHSWs3?=
 =?utf-8?B?NG5qU042TTV3UVpyVmdTSHpEMjltME5oUlZPUGl5ZDdOWldRVVR3U2lGU205?=
 =?utf-8?B?bGRrZ0sxcVdPSXUwaUtXeG9UTkJtZG8yakE2Z0tQa2xITTh5bElROXM4bVdn?=
 =?utf-8?B?UWFvWmI0bWd1TmJiNE1SS0NmZ2o4WnZRZytVaWFTMFVGRXdjVTVueWlPNSs3?=
 =?utf-8?B?REZYSXFpTkVCQWNzK3ZEWmk2OGU5Z3VKTTVIWStEQlBETHpjL0xpb3pkZWZk?=
 =?utf-8?B?aFBPaWxEaVd3OWNVd29vczVaeXFnWHlybVNrQ0dPSzBDTFp5RG1nb2FPczNw?=
 =?utf-8?B?NUZJOHFCVGpMdWhjU0QzOVdla1Npd3dZc2JsQW5qektBaFFWc2lOeUVEMmJO?=
 =?utf-8?B?c296REU0MFVOTmJhNnFzM3BwaDdha3VESzNMQ3VTTlBLTTk3T2VFeE1sV1Fp?=
 =?utf-8?B?cW9KWEVnQkV3VVFGa09pZk1zNGw4ZEZFZUNQdUIwOG9vcHY2NXRDaDdFT2pS?=
 =?utf-8?B?VFNJSVNGMHVpM0RtTWE2OEdrT1B4UkorektuenVyRFZXczVJbitESFozOCtG?=
 =?utf-8?B?NFF2aThrWGMrWlhTdDB1MWFQVFlwTnZBKy9QZ0pRNnI1Y1N0NlBDUHhjK1FF?=
 =?utf-8?B?SVUxVDlZaHFsZDAzWTJkUVZ2Qk4xdVZpUnZhN0VzbjkrdHpQQ2dTa0VjbmNJ?=
 =?utf-8?B?RktuM0tKazNTa3BpbmNjZ1BIZ1NrOUhYK1dEQ0lDYnczRVczL3hHRTFXblVw?=
 =?utf-8?B?enpURnRqVGNabEJsbUpwKzd6WitmM3JQTEJ2M1JpTzk2dlZMbWkvNWI3Slg5?=
 =?utf-8?B?cmlWdmJyYm1xNTNlMTJtTkJMdWpnM0puejV5MDhOT3ZpcjRvdC9ueEZDdzBl?=
 =?utf-8?B?c0U1QlNCeWNGOWxOdzYwVHJYSklLYU5zTGs5QmVzRWhsMVlrckpKWTNRb0pI?=
 =?utf-8?B?bjY4UVpOdmFGYm9FVDJXMEM1V0Z2MUVQRTVTdEl1YVM1ZVpUY3pvdmcxRU8r?=
 =?utf-8?B?QXo1dlMydWgvYWdjRWc1MlU5eWZ4S1lXa0xNMUtGMmtSbUxkdXBieVpQQ29n?=
 =?utf-8?B?VEJGZ094UzM2bzlMdngwb1pDMm1qSGYwTkFKQlpScG9vWElvZUJyb1g1em1K?=
 =?utf-8?B?MHpJRDRiazlNcXo5cVJ0ckdCeUs0K2tNUnE0M0ZISFROVUV0N0dOWmhCOXlu?=
 =?utf-8?B?K2pQZ0JnKzZMcHFjOHNOblNRaE5uaStMWlhmcTVSMVI0OWZWSm4wekJXSGdN?=
 =?utf-8?B?QzVOUzRWL2lldjY1ZUJQa1BIUDd0KzFvYmlnYnp6Q25QZXFxUUlrdG1FaDZa?=
 =?utf-8?B?dFJSQ2RwaWhIWjJ5Rm9XTWZoZDM4SWdtdGZvY3ZDMktwVWtvTFROYVZqK1gv?=
 =?utf-8?B?YWo1VDNNcENXK2JwOXBzcXVWeUt0SHBWSGdiY2szYzNqRmhXT1J0STJEYU51?=
 =?utf-8?B?MGhnM1RPaVNkR21oRmVhWHVzWW5OT1cwdHk3bElEdlFpR3Iza1poc3dheVBX?=
 =?utf-8?B?MVNJTThaV3FmNC9IdXgzaFlVaXRXL3NGQnNTQ01USm93L0Z3UmpPbG0xakxp?=
 =?utf-8?B?RmVmWVVtMnBkLzBMcG14SkNQMk1FQUY4bDA4endHNjNkMSthRGNjSkw1eEZi?=
 =?utf-8?B?UVpocWhnZ2NQS29FOHpndWRidzBXQkt3d3ZIVnd4R2VJd0gzSmo2eHZOWU1n?=
 =?utf-8?B?WFFnR3BVUjdpSXM5bkxPcG9sKzVSZEQvYS9vNjlhVUZyei9wTVcxcWVmcGNt?=
 =?utf-8?B?NCsxS2JFbG1YUUxLZzl3c2UvOEdEd21nL1BlZFh3OU9mNUY5LzIwRzVtTU40?=
 =?utf-8?B?S0s0ZWJtUHM2VTA0L3FSWmFkOHkrbVE0cWo0ayt1Nkx2MkJ4UlVhY3p5TGtQ?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d103ec-32f8-45cf-fd2e-08dcd35bfeb7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 18:52:04.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WoBiO5V5JdC5STN0DtgNJ/TtSWKvj8Fnl80FGN3woGSf2h/tJavbtqEGL93iOah2Pwvs5gd7P7q2swq64fet3gvyXKf4GwQbJMdnwdwJXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> Changed all the functions comments to adhere with kernel-doc formatting.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

I also ran the header through kernel-doc with -Wall and didn't see any
issues.

