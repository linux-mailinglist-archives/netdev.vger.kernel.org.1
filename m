Return-Path: <netdev+bounces-188446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D64AACD8B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F2981080
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62319286D49;
	Tue,  6 May 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5j7rzZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DF286422
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557637; cv=fail; b=bT/fQVf3pmjNbsQGgGCZujPqHBZMGhFZFPuUAPyjgJgzdxCghMcmKW/qIjkL8jumb4PG1dkM5AkWUMMUsuq3Uzhqe4WfGV070xVVCww8VyXQ1WlZswZGEKrjb6/wAbfykbh/zEULLMBbRt8zpXgefgrRHYKClaEYza99XdA0hA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557637; c=relaxed/simple;
	bh=ee8Q7bT2TQO/NToSYl4CLzByKDBdODRaJ0UGvQgN7ys=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLek14+vIsfH7TBFJTJCYw5cFuhhgzhy5sZwdtzEtOIb2UWH2RqA6FCl4Cm+yAPDKp/7++mWb+tORHBUDM331yYiONNXC7MmQp6xV2du1Zj1eCzkP3Q7tJUBzmYtuSduebRSQF+t1WTJmXrvI4WjXxacHraBW3PMfdGhwjV01BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5j7rzZZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557636; x=1778093636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ee8Q7bT2TQO/NToSYl4CLzByKDBdODRaJ0UGvQgN7ys=;
  b=W5j7rzZZKhCI89TkWJ2KQQ4XS4Qm+SZb8Br6I4ySQ8eVmIohUE8f8q3u
   xZMqSmJ3gqYHs+WWL476tgnBTQmEdEGXRXIQ5JbJ6Au2VyqXGwpNwDyhd
   ufF1lKMT/gQrtbZOK3n/ncES8NXvv7OkqzXLewRdC/k5hUWdqa88hd+9I
   R9YRBE3FkU1z0AwiGIYAceXTuMXpLYyQMmeO7BuUndfR2Kk7Ya4mTbf1u
   yzlizyexx9t2CD3G5TPPDpQvt7KpIso9pdaXFlo7SpPU7WqOPfTr8wOZE
   Z8qDB8fdSL1SKvUw5CarTRD8I6ILVVtp32Vwxy7fsNg9NIfzRoZ9sFz/S
   w==;
X-CSE-ConnectionGUID: mIjlL+x1R9OBLUpWmhWblg==
X-CSE-MsgGUID: kIxhFh65Tyesu0ioeuenIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48332041"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="48332041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:53:52 -0700
X-CSE-ConnectionGUID: K5vglRv1TJiHSPj91oQS3g==
X-CSE-MsgGUID: bsss0zu8T0uMH/hlLd+7BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140668178"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:53:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:53:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:53:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8gbvYskBP/IemhBGFDavYLh0sHNC7OwMcFqgI18JhWuv8ufWx5KSSRP7TI4XMatix3ZEpO22YwTCtr7QvjhhqDv2pJ1+rppkGtscz2Iz7CIk3fCZrYTnUSUP3X38tYstLpVtF8Shu3+NGwuh6jugnm9Or4VWR1xhH6dRV3241I2/dMjCclM2PGlmh/YqOdXZthkzHQLmv1mu/OB4pIVF+lvadtg2FORS9iROO/4Qx1LDcSUnx2dfTikoM/rxo10FHCIjYUdrX6/O02jVCqCnyz6SSv8vkqKf3d7IaFD3uUe9DPMqHCTY4XlYf+fFyE2CwUboGYpfTDYhU0C7KOQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq+u4T3KiKJzolrb1ObOHzzpur/pr0wSbuvKGoLkVLE=;
 b=Jvwnm3xO3Px2JFuMGAKySa5NMnuhAkxQivXELjK+oWNpiUMP8/285XrXQgs5s6PmBnz/7vCNaeNlHCe4wmSKKXcpVWMSMlsGHvLP2faG5gthbhM5Oq5VjD85Fc8a/Oj3W7kidQhRauAj0WSqUAHvKXU000vOTvao67V6tELFpawDBljPVxDNZl/O+F9wJPimN2uAW8ruBPObzU85iNZrZ0tX3ZAuksNoE43mkrWSBg2Uaoao0uzosg/0G/rUH6dANNULcIKNGq8fY7JsvkmjnZxD1ojlgYzEvCXfmJ/cP4MWLQFoBBmFYeVSLQnsROp9lo/D/eMEGue94fIXM1xcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 6 May
 2025 18:53:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:53:39 +0000
Message-ID: <7da199b2-99a8-41c6-8b8e-554354ac15f2@intel.com>
Date: Tue, 6 May 2025 11:53:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 5/8] fbnic: Cleanup handling of completions
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654720578.499179.380252598204530873.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654720578.499179.380252598204530873.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 235ac3c7-5876-4691-e246-08dd8ccf5045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTlSQXlvUEozZEwzNmI2VFgramFSRlJ6MzA2aDZ0eWF1WWZGcTdsMEIrVEJ5?=
 =?utf-8?B?TG5WZmNESllOS1FiSjJocDJueVVxMURYVzBmS2Z3Z3JXWmNrZml0MlFnZURr?=
 =?utf-8?B?ZEJBQk45dHBQMG5tS1ErWUhpZVQ0VzhrUE0rTVB5bG1vRFl0akh3MUJVb2hZ?=
 =?utf-8?B?dTNmRkdiMS94eGsrdkZHS05hdkU5SERUZHBKRXBBY01IaU42MzFFNUxHNFJO?=
 =?utf-8?B?QjZ3T2hDRG1EcHZKclNDazltbGV4WVlJV3d5dXdFNDFoZ3l5U21tUTVyWmpL?=
 =?utf-8?B?Unl6c05kVzAwYXZSQ2N5Z1ZaSWc1SWNDUDJyT3FJM2djSXBHeUxjN1V0Ylhy?=
 =?utf-8?B?V0JTMDlFUzhTTjNJVGI2dzlQbTdOdklQQkoyaXFRNzlWYm9CRmlJN0F6ckZm?=
 =?utf-8?B?ZDg0Nzh1bGRvNXJzOURlZUo4SzZEQW1aNTh3ZXNhbGhQUlU0M05ldnFPcU1Z?=
 =?utf-8?B?a1RnbDFUVjY3Tkc1MzdRdEVQcU1zZk5zYXBLME5GczFldmhPckVjdFZOYlov?=
 =?utf-8?B?cjFsMGRPL2dGZWd4VlByYnFnS205WmNTeVpJNFFkNWs0Qllqd0tNWk1FR1Jq?=
 =?utf-8?B?S3R1TllUaGJaaDBxUGZkdFJjdWpmbEQva1ZhcDlTYXVEbmNWck14S3lQcUpE?=
 =?utf-8?B?SzB5NUtJVEpzd0dRQ0NOWHFjZ1I3VVJKc0VPdmhoNFdzTUt2WHVtQjRQM0xY?=
 =?utf-8?B?R0dmaVEzL0lIQURtTHBaZDExRStGZ0lOY1NmSVdoVmpGQUI2SG1JNy9RNVc0?=
 =?utf-8?B?UVJzdEhEdURoSDhQbk9kK05DcC9ZWk9NUDlRNnBEL3I4a0NXQTlWQ2NxOU5i?=
 =?utf-8?B?UThTeEZaT0h4TVRTQmo3amhaWlRvVzY0MGVJTDkzdFFmc1N3SEZ3QlBKN01m?=
 =?utf-8?B?MUZTT1ZJRjI1YWFYZGRJdnhpWENERDJMQkpQUjN6Q3g5eXlveG1pRGl1bkUz?=
 =?utf-8?B?SzJ3WHlRRFYvcXhTREgrTUtBUmhycFJwTVAxVXpsTFc4M3JlNmdXQWh6Qzlo?=
 =?utf-8?B?bk0zc3V4Qi8rU2V0RGlIcjE0WlNIeUJUU3hjYzJzbVE5bGhrZnp5SDZmbkYv?=
 =?utf-8?B?T0VtYys2QzQzV0xIVVFJVmVDUy8vZ3JNNlp5TmdQT2VjSGsvTHdhUUllZUta?=
 =?utf-8?B?QktTNGo1d0E3Mi9NK252WGJuZDlRTlNob0wvN3ZOSVg3TjdnT3RMcTFCL3I1?=
 =?utf-8?B?S0RweFZmbnJEUkhnTHZFNWlTcWRYaW1JeGJTK2k5SmM3blJWZjBuTnI1WkNV?=
 =?utf-8?B?QThCcVp2YXpFbDBQV3M4UmoyZUdSckdvTXhDaDJSZUIwajNQSnNFZkxDL3hW?=
 =?utf-8?B?Y3FCeWFGcnRub081Z1dXYTdPVlM5b0VWcitSZXRNbS9uWDdVSlo3cWNyZTdD?=
 =?utf-8?B?NlF3MUx4MWhIQXlNbWFZbXV5d2lldjdzV3d0dlJMcm5XdGd6K3dNSFdaNTVN?=
 =?utf-8?B?dVhzL1FXTU94YVYyaDdESkdKSHVoS0l2NkJnMmV1RDM5endzODFza3RUb1lJ?=
 =?utf-8?B?czdVMmYxUk9uSGVpVkVBWjVQRG5MaHpoSitTVk5uSFcvUUovT3lETk8wa21E?=
 =?utf-8?B?SXo4TjFwYlBJTmZza2xraDMvWVdJOXJZaUIwRUM1b2U5dlZSUmg1WnpNc29E?=
 =?utf-8?B?b1NGWTlCWDRtaGtmczQxYnV4c3greUxNSDZsSUtVdW93OWQrWFExK2dXL0pR?=
 =?utf-8?B?U3d2Wk5yWHNiUEhrK2NFeEN1MTVkOWVDUEVLdjByMld3MWxSejFUYmtZWjdj?=
 =?utf-8?B?dG5KSStjTDR5bm1yVFRLRmFMTDlUdk4wQmJ0cVdVN24vOEpnUm1rajhQTjY1?=
 =?utf-8?B?d1ZuZUVlOHZWMkkvMzEwb0hVeHRzL1BrZVhnZXFjR2wxSUJUVElOSG5ITlMw?=
 =?utf-8?B?UTdQVC90dWR0blVIOVBLdjZTdmQvYnZiUVZvWWF5UXlsem5idTFYUGZvRXR4?=
 =?utf-8?Q?3GxrVf+gXR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdESE1TS2Z4cjhrYkFsUUpLZCtyQUI2dnBaYjIwcDVFY3JKOElneVRNRzNZ?=
 =?utf-8?B?SjdDeDJPVnNmZEkydVhJOEF3cnV6aEhsRG9NTmtZcUg0VlRKdGJSbkIyTUlk?=
 =?utf-8?B?SVNFM0p5MHFEQTMzazM2Y24xdVdBNU5nTEhJUGZkY2RVWnBOTXpOQ3c1ZUFG?=
 =?utf-8?B?aHJRTUFqbHVJemR4SHdud1lxczhZRHI1ZlRrMVRtVDNFWEt1ZndkUTV4eU00?=
 =?utf-8?B?ZzZUckg1OVJQbHovZjYvM0NQNXY0ZXFia1dLcm44TXh3ck5mZUEra1Yrb0lK?=
 =?utf-8?B?V1YzUnlXQllyNFVoN1psVFJZTFd4blZ4VHZaY05odDhnTkpGaXJnazJCOTls?=
 =?utf-8?B?VVFDOGVJKzFBR1YxR1ZZeXVaWTJHTURrdllmVm9kdFlITUROT1VUSjhvZFMy?=
 =?utf-8?B?V2tOTUVVaVpzVlVnd0hKaEtBQURKRDJ4MDdKV2NWb3kzNzhmSjl5cTNHRllL?=
 =?utf-8?B?RlJhWWhsU3J0UllyN2tPQmE0WnZWQ1A4bnAwM2UzNitYOC93SHRwVXZwdldz?=
 =?utf-8?B?cWk0L2pQNTd0WUJRcXhuajJNTEprQXNxNU1FcFdzMFlLZS9Xdmt3cFFVM2N0?=
 =?utf-8?B?QUxWMy84L0tid084UysxVy9lWThMdEtsMWVYdUVjTGZxSFVQci9EU3YzZmxm?=
 =?utf-8?B?UU4zajRZaWFjaUQzUENBSFI2eEpjRUtDVFhWc08vTDF1dXBTUHBiUjltS05P?=
 =?utf-8?B?VFJIYmE3YURFSW1yUTVLalVJeEZabkJ3MUM5NXE4VTRucFdtdlVnMFhraU1q?=
 =?utf-8?B?bmdPY1A4dW5OQlNIWnVDTkxubWJCd09IcitWOEJQRDNPUkZUOHgrR2pQUkdh?=
 =?utf-8?B?MVhHaFcrbjlaeW1FeFdnR29Pa2s3WXplbWpuUnh5WHRvbmZSRWhXV2hwQno0?=
 =?utf-8?B?c2lzR09XREtHRG5XMGRUZHFISlM5anY2S05qMzhMcmRyU1d3UW5JaGs2YlZs?=
 =?utf-8?B?ZENMek9OdUQvcHdmM0hvdDI4Syszd1hYaWFvWlE0THgvTHFpSnlNa2h5SDFk?=
 =?utf-8?B?MWl1cGQvZ2VmNktBOEd2NXlvQjdlKzB3azV1a0FNaGFzcU5IME1JbDFXKzBX?=
 =?utf-8?B?bmlsK2k0OURTdklQZThSWWpkdmFySGIrUDdsNmFkWm9pbUJzSEJZRkYzUTVt?=
 =?utf-8?B?Mi9QYjIzc2pQditoUmVsUE1sM3JBTTFoejFSc0hPZWxyeFdzd2FKMFFBbjNV?=
 =?utf-8?B?RzJWaXNVbmpKTDNtYWo0enhNN3RkaVJDaCtneEpuU1NKN0FIbi9HWGkzVWFw?=
 =?utf-8?B?TlNGYUtYbFpxOWJDdkt1amhpQmY3UkFvRDJRbkE3SmFKNEwzZjVWWU9kNzQr?=
 =?utf-8?B?cVd1b05aRGNSNFdmekNQN1RHWElETEQ1WEh0UStudjlFZ3c2emVWaXM4c3ND?=
 =?utf-8?B?NHBHUzEyejdERGd6QjkzZXZVVnBBaWRZYzc4cTR0bVRPUzZjMnZIOFM4eXRr?=
 =?utf-8?B?MmI0dXBzclZreWxjS2thYzYrQi83VFNGMFA1OEhGSlAvbWtPTzVsbGFlZ3BO?=
 =?utf-8?B?Rk5KSTFReENlSk00bHFKUldJS3FuT3FnR1FGMmdyODdRUWgrU2hBT0E4ZHBV?=
 =?utf-8?B?TFllMStDd3RRNnpwNmhMZkVyb2xoRmhhV1JocVk2YWNOa0s0MmVlQlBPdlVn?=
 =?utf-8?B?K1F4N0V1QkM4aThOU2F2cEx0UG5taUV6Yld1QkF6amhwclFZeUxRRXoyVlYr?=
 =?utf-8?B?VVRZN0daREQ0U0VLdFFiSGp6SVBNMjBtY1dZdWlYdjdiWmdnOTA1RVUrclZv?=
 =?utf-8?B?b3FOODFBMng1UFNEcjJJbytoOG1vVndNUUxwMEszMmIzZnl2QWFNVHZ0VDBC?=
 =?utf-8?B?NllzMVJYaXJjZDFHVVRLZjF0bVNjb3VmRGFtYUFxcmJacWFETnVmb2RmUm84?=
 =?utf-8?B?dldkV1psemJrWW1zcldOMXpybDRyaGQ4dk9rNHZoUE5EUEV3dHRXK2pCdmNk?=
 =?utf-8?B?dE84WHArb2ZUM0EzOG1hUUZnczNVMHNkN3ZyK3Y4cFFmVU5YV1dnSlFhVWdp?=
 =?utf-8?B?YURyWHUvRmZZOVIzNHloTUh5STIvZm5IWHdocnFSYkk4Z2p6UzBrUHFRbXFJ?=
 =?utf-8?B?VXRPaUp3MVdvSW9wRVQzTXZUV202VDdYOUQyMlNvZklPakdxVHY4Qm9tNXJr?=
 =?utf-8?B?U1BPSGlORS9rODhlUXVHNzJ3N2ZMeWIrWU5oL0VwQ2hCcjBZbk1tNFFDRVdF?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 235ac3c7-5876-4691-e246-08dd8ccf5045
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:53:39.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBcI7dBTnUYF0EH6p0jcOuJAJe1jhnKOoZIblrqfEVA2lFW/kEHOEixxuA4fkLZJPScRvtDV8lPo+LVBu2r3FbXyyh3U9Qo49csY8AsYLA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com



On 5/6/2025 9:00 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> There was an issue in that if we were to shutdown we could be left with
> a completion in flight as the mailbox went away. To address that I have
> added an fbnic_mbx_evict_all_cmpl function that is meant to essentially
> create a "broken pipe" type response so that all callers will receive an
> error indicating that the connection has been broken as a result of us
> shutting down the mailbox.
> > Fixes: 378e5cc1c6c6 ("eth: fbnic: hwmon: Add completion infrastructure
for firmware requests")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

