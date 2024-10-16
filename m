Return-Path: <netdev+bounces-136159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF89A0A14
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9E287472
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E199207A2C;
	Wed, 16 Oct 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOdDuzEj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C5207A03
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082342; cv=fail; b=dUdbKUgwFzJpM4A6C7qccxpdIFnZU0leB4pRoeOS1gxV0Bw/bzTWQ493h0x9QgFoBXQBXWYNjlDJP7OIQCif3uBQUb5gujOa061PUO84OEvtkXA5Mhuicpe6WfjBK/Dzrk9RKOx82n1DnaGEMmkVA9AWNtmd61G81hZOfg1Dekk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082342; c=relaxed/simple;
	bh=2woBSCN6aoSuqnxE+b7xZEmvcDTcM8Yu316lmz0ii6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TqQ455HChShlZ8fk4yHyzP/Jd61xUAF0sjw7J9btc67CtXbjVPvkJrlNewd4LyHvBA9mLDyIUYxRJfCRoWCOxIB4KUNgRrFiKHBLC/t8PaOXGLuO8Zt3wey4lUN3KYF3aJlOAW9EBjunkrJVki3XPnwje+Y6ZTlVo5kLqFRHrfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOdDuzEj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729082340; x=1760618340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2woBSCN6aoSuqnxE+b7xZEmvcDTcM8Yu316lmz0ii6M=;
  b=hOdDuzEj/pXyIP5CHsM5BRYxzlF55XVJxDIPCYqD9s4NHbzXTqmurjbq
   hhQVc+L8EG4Uno64I1sviaDxX1EXfIBu4MHKXaBklrw1mj2hwjBgV/qm+
   TKB7Kf4urmS8JcbXjNsGJtnuunFHknsIe6DqTGhw5N7Kd/l1P5hlJz8+d
   6MnL1S2Ig+/7+wmOxcFm96BM1DYT9x05WQVwgU0XLKNPwn2krDpxcRqMc
   WctrnxLVIApJ8yzRGdye4Qu0mRLDwSstniRwvShuLFgdamP6Be7fnCAs7
   eOHZj0pDpij5FmahH9PWv9i3q1hl75lzabm/rsKDp2U28yy4WL9l7Zd3M
   Q==;
X-CSE-ConnectionGUID: B0Du2WBpTjaC2siaZV8Pjg==
X-CSE-MsgGUID: hsD2dJE+TTqj6tXbOTPzDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39157189"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="39157189"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:38:59 -0700
X-CSE-ConnectionGUID: HFDT4gA2RKKPr63QTCtxCg==
X-CSE-MsgGUID: 6fABekEMRFme2JHhkA6iug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82874050"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 05:38:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 05:38:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 05:38:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 05:38:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 05:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el2kOWrNqIJ2TivVTAGoBHXaWJtceSxU9DUicrad/8xTQOwF3GEWJn3fLUtQpWEuZWluFB+OWhxOMfzDgJhO/1h18nssFDOqZyKV+60ZTby+cT0YDPi+P7apHeZyT3k7kL6y+qxHUYyCXfG2uGOKrVFj5eKCSwdt2KRFfHLKHJCVFqdeXLWEMpTBbySRkYJxYFK6Jx0LwD1fe15wFb1kq1jdN7lbWo8TA8dXOcHxMxPuODwVYBFkyZ/iRaLUR+7JW6J69ifB6DvWjiHWO9k1AIyYoEFa5UXKspMh/U8KutED/V0LcQRnc55yaoNqy2hf0ipf1EPjuRKjZttttljfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0rOXANTKEuUbffoVa42c5yr4r6b80jKWbozilsEhd8=;
 b=XxE51CddpydeYDl1dDoVKCv0OYxK/y4/FjVkiqSFdqx0Mq+953kR1OUtAgnLZ+oR6Loh/2Ht2YntgWAB4KlLmehirHTE9LxDviL7P5oxk6/ZKmW81iZ7Ce2p8j2M3yt4Flfb7da5E6ero9BvPxp2Wj6zD7HfUXp8IUR8fhEsUBLIHKjDrEZNt6aq6JMr4Hl1bBgwxpypaVEvNqCs7A6E6mZmRyhxWlZ1x2IbMxzEoluCBWf4Bme7EXUAVGb8lfgp+XkgEenHus0BmjzLXdzbesQMidU3ejWaeLW9wgX7u6L4bU0pmpAAlKbKNbuI8ENZ/k/ohMjCSwc1T/B41ennTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by MN6PR11MB8243.namprd11.prod.outlook.com (2603:10b6:208:46e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 12:38:50 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 12:38:50 +0000
Message-ID: <69da9a2d-bd4c-4289-a10e-7264c325c44a@intel.com>
Date: Wed, 16 Oct 2024 14:38:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: fix xa_store() error
 checking
To: Yuan Can <yuancan@huawei.com>, Petr Machata <petrm@nvidia.com>
CC: <idosch@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20241015063651.8610-1-yuancan@huawei.com>
 <8734kxix77.fsf@nvidia.com> <107fb00f-1dac-4a13-b444-af2649901ae4@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <107fb00f-1dac-4a13-b444-af2649901ae4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|MN6PR11MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b431b9-3826-4db3-5983-08dceddf7c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JRWWZLaEQxa2FIRW80U0NjU0tudmtMdkhoTjB3aWRMeGE4WDVRaWhSTldt?=
 =?utf-8?B?cXVWWFFFQ1paSWxHVlZ3UkcwbFZRVDROOTA4RC9uVEIrRmtWbTNLbkd3eFhr?=
 =?utf-8?B?cklPY1d2N0dFMTVTdktJdWJBcGhyajJrYXkrbjNHNkIwRjh5YWRnZFZ2OURa?=
 =?utf-8?B?c2xoQ2ZQZ0RvZnNMMjF3WnBmQzdSTXpZUnYvWFZhQmxWUGYyQVJjKzUwYWky?=
 =?utf-8?B?dmZoRGpzRVNFRHpzV3c1ZnA0NWNuczVhTkFwY1VJR3p2Y3ArekJsR2xBUWtW?=
 =?utf-8?B?UFV5UXdTdURQVWFrNFgvcFJabGdZZ2FOL2JSK0k4ZlJ0aXFCdXJNbmo3dm4v?=
 =?utf-8?B?Q1BNa0RPKzlLZ2dmMi9ENDlsUDViSVdVV0FsN2lEaC9rOXFzVy9FYXBmdGJJ?=
 =?utf-8?B?T29SRHpOZUM3QmZ3L2tNL2pLeGR4Y0JrY05PcFJCK0FsRU9kQWpyWVFVTkVX?=
 =?utf-8?B?blUzcDZ6TktyR3ZHMStiekM2amNDQ3RqVGN2MHh6azUxRThGNE1SM05nV0NY?=
 =?utf-8?B?aGVEckNmdUxnZU9NM2xEUDg3aHdtVlNleDArNHdrazdOMzFYN25ra2d2RU5u?=
 =?utf-8?B?dmdSeFJ6eGltcnlYZWozM3Q4cjdIbzFMY0JkdXRFRXdIR2wwcDl1SmgwaUhJ?=
 =?utf-8?B?YlNZYWF0d1ZOM0kwSllaNHIzOE56eVhkTzd6OTZHbndxd1JCRERCZzRXQmh1?=
 =?utf-8?B?YTBodG8wa1k4RDJBa2k1NEx3Z1FnR0FuUUwzTXpiS2s2NTRxNFNaVUVQdmV5?=
 =?utf-8?B?djBabEZJVlZWUng4NzB5QlRMckdUd3RLMjlUdGx1bDAxNm9VU0g0T2F1VmZs?=
 =?utf-8?B?OEl1UTJtbVNwRjg2ODN6cmt5L1laNmd2eUp4Q3RXTW53OEF5VTRtQ3R6b290?=
 =?utf-8?B?L3BZdHZ0U3NSSmRoaG5KZm1wK0NtWXk3bStFYWdaYThSazdRY0J3bFhvcjFT?=
 =?utf-8?B?TmNsa1Q2MzlmNmFuUExYb2NQWWxiOXRsd3NVTWowR3VHdi84eTdzWGo5L1FI?=
 =?utf-8?B?U3pRbHJ2cGVFVGF1WmltbSt5VFVaOHAxdlI5K3JmbURFbFlrSXlrc21JOCty?=
 =?utf-8?B?N3lodTk5TnAzQ0NqMXptMjIzbzFQZ0t2Rm5Fa00rVTZ0Y0VxRzN5MFBSM05X?=
 =?utf-8?B?VzNsN2RZV1hteThtYVJYR01CZEQyK1BsNnRlOTNjYXYvZ1d4aURDT1VsWXFB?=
 =?utf-8?B?WEZWTTZidWtLM2pjZkdycWlUbWo0bUF2a28xdlVQNHZtMGxwZjhHeTczLys0?=
 =?utf-8?B?NnNrUHNxL3ZJbU56TjdJVFdad0szZ2NwZzdpT0FERTFOdVBwUEM1RDFQT1RV?=
 =?utf-8?B?MVpBTlJ3Ynh6YWdGczJMb1JqV3dFMmVVSC9waCttSkV1T2d5K3VhbUh3Q0gx?=
 =?utf-8?B?Y1UwZkQ5d0hObHQyWUpwZHUwU29OL1VLTkxzRTJab2dtWDR5TXB6Tko1TU1j?=
 =?utf-8?B?Q1krQUVRbmk1QXE4TlUzY3MxYUZSMnZCRmhsN3FDd1lROVpXT1hQKzJ4dkc0?=
 =?utf-8?B?cjR2MXYyd1FWYThwd2lzMTEzOUIwV3o5U2xFQ25TR0ptem9YVzFtYTQ5cXhr?=
 =?utf-8?B?M1R6RjhabENOY0RoWkhQdzNvcVhGZHY2aTBtcWVwTFViSDR6M2M2T2JyT1d3?=
 =?utf-8?B?RFFVSUJiaUdtRGo1VU1BVFMrYkNrRzk1cGlDdk9oNm1yUWdDdDBuSk5kaGJu?=
 =?utf-8?B?SnRvTnZOM3NHVmF4TG82M1FnU25CWk00SnpFak5KbXVrODFYMnl3UHBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVlSWZBR2ROcTJ4WU40NnhMREI3RXRsVVRObXFCQjIybkdteERlV0RVUERw?=
 =?utf-8?B?a3R2VS9FQVRrZUNTSE8yV3NwK1phQTJ5bHN6SzF1MUJyb0NnZkV1K3pUSWM3?=
 =?utf-8?B?b0Z6S2tBLzlYSmhCL3hmdnR6ajBkRU81a3pvRlVDS25FdEhUZmdQaEJSZkFP?=
 =?utf-8?B?NloyYncyVTNwaVlsWktCQVkxWlZ3Q1VHUkduMVhkMUJsdXBoRnBlT2dHMkR1?=
 =?utf-8?B?NVZIU2gwREVZb1drY2haNVZhNEhsbWJZUStXa3pSUldxc0tZMUswMTZVMm9U?=
 =?utf-8?B?aDk1NC96ZE5odGZlb3VtaGwyc21hTENndGF2WElNZERjK1hoY2pxcDUyZkxB?=
 =?utf-8?B?Tmd4ZHdqaE9Ec3dleVJXLzExSHVCWEQyN1hPTWJIeGZxYmZSbUVIL29CczQw?=
 =?utf-8?B?ampxMHlZUlF4Ulc2MEE0VVVrTW5KZzRmSlM2VzBxdHVmSlJZU3ErQVZld3Rv?=
 =?utf-8?B?VEtCdFBUL2M1ZDh1ZFY0NWt6eDFkTHFiamNhaW5vSG1UWkNkbEZpUUVRMUNz?=
 =?utf-8?B?TG8zeWRDNmhRdXhVclQ1TCtNR0VwT3JDSEhDWldXVVl6MTNJcGZGM0NuZ1FB?=
 =?utf-8?B?R1RkQ29XQW9IelNKSTJHV3JJU25oVHNISWg0OEhRdjFzbkpJTHYxUW1rbm13?=
 =?utf-8?B?OEpqWUNkeXdEVU91THZURVJKMGllMHQzWnlMblBXcEhXcXdOUkxZcHhzdUNX?=
 =?utf-8?B?ODBSanZRdVhwd0x1aVQ3U1hENG16c1hYdXowMDFMT0hmTFBQTFZpM25oZmxm?=
 =?utf-8?B?M2RqYlRpSmFFOUROdVlxdVI4VllOdC8rMThVZFlibi9yOVFSUkJzUFdpNzdY?=
 =?utf-8?B?UFpkOGpsQTZqR3lQNmZnSFNzVzJySXd6RVRodThkSjJJMGh0ZnRTZkp0Tk81?=
 =?utf-8?B?UUNwM0hHanF2MTkwN2t4ckp1NW9raGVFTVUwSTBidFJYTitMSy9yNXFTTEF1?=
 =?utf-8?B?NGxsc3U5S0VMeWF1cU4vaWFRK0RCSG9lR2g0Y3ltUWtLZnhKL3NrZ0dKUTFC?=
 =?utf-8?B?VVdCSEpJWStTRUpVNnB2SHRKaEliR0hCOStML0RvbWFhOEpCbDlHZmNRdmVS?=
 =?utf-8?B?Yjk2LzhyMGNYakFKS05DWmgyNDBHRWhkL2djM095T0JUZDQvYkVDRG1LdXJ5?=
 =?utf-8?B?b2kvZUlpcnZHUkJaYjhUYVlOdDU0WS8vdGFNOGVyb2RjRTNBK1RGc0FSMHQx?=
 =?utf-8?B?RmRrVVUzTUgxL1JodEJFcGo2TXlqbUIwWDkzQk45ZmxBT3lEaVZJeVNlWUNj?=
 =?utf-8?B?V0w4cSsxd1Vrd0p2MVNVeThsREpYbG1LRVAwMlJpWDJGeDZxdXpSWXMwWEZ5?=
 =?utf-8?B?dk1kTEpmQVlTOGJCUXpSUE9Ra2dxVldMY0xXd3VHNWNmSDNnTmt5bnF2TDBU?=
 =?utf-8?B?eWVocUVPclEyTDBNN0tGa2l6Zk85WU05eEdMMGZTamZieUVQdnEyeVIwSENq?=
 =?utf-8?B?eEZlVE5tTHMwNnEyV0FFRFNGQWRjNVhoRm5QMVdPNjcya0VTMldSZ1J6dm5J?=
 =?utf-8?B?L01wY2VnTFhZaVBFdDZUNklaWTJET3FrdVNYZkNiSjhIUHZ0dFpWUzhSa3FL?=
 =?utf-8?B?RUpSMUREUENzU0x0MVErK1lGcUdybnd2QkdXZVdXM0I0M29adC92S0M3N1dW?=
 =?utf-8?B?YVJHL0JMTkN4c0doWFlsRkI2Wi9oZ1Rza2p1bFErcHBnenpvZzBoNWlzN0xF?=
 =?utf-8?B?V2hFYW9TbGRkQmhsWVZGb2w4elJGQ016SURQZ0pTWnFmcVlXczhxVHZUZERt?=
 =?utf-8?B?L3h2RXNHWlFlNlQ1YmpiRmluVFpDZkRsc1F2T2pucHJBR2RtNDZKWG5IY3h6?=
 =?utf-8?B?V1dhU1JJdEluYU9YYTJwRmRmUXZVZ25pdUsxVkE5ajRyZzg1Q3JPUUdEOUxz?=
 =?utf-8?B?Z3FTTXp6L0N2N2FXQ0FaYTZ1U1JSMEZmWjlQS0puMFdhbnVRZ0krRVg2c21l?=
 =?utf-8?B?TGV0TnZnSXZQOUtPcFY3NWorcFloMUtmUkQzSGJqY2ZGQURXa3RScURRV2x3?=
 =?utf-8?B?SSszaGFSbVJ4V2cwdG0vK0ozd1dKaGUxQkNDbXl2Q3UzcGlsS2RvRTd2YUhS?=
 =?utf-8?B?VjRxYjFCbjJLekVMQ3hqdlZFaUxjeldEVThLT25selhHdGdsSlFhbmxySjhW?=
 =?utf-8?B?SmxOV2lhYlQvdmdlY2I3bWhCN01yTUp3eWpIejdyN3RIZHVURUQvMldiZFB2?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b431b9-3826-4db3-5983-08dceddf7c6d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:38:50.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFvQ/+3m9m6P99jQl2en+5kGBGb9cj1O3Q8qo9oJ/w3bODdjXECZU8EA/hP+sZAUwnNIYjLRHZz/ROadc4PWwzjQn9oQpRXpN/UxzYbv46o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8243
X-OriginatorOrg: intel.com

On 10/16/24 04:19, Yuan Can wrote:
> On 2024/10/15 16:06, Petr Machata wrote:
>> Yuan Can <yuancan@huawei.com> writes:
>>
>>> It is meant to use xa_err() to extract the error encoded in the return
>>> value of xa_store().
>>>
>>> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters 
>>> in resilient groups")
>>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>>
>> What's the consequence of using IS_ERR()/PTR_ERR() vs. xa_err()? From
>> the documentation it looks like IS_ERR() might interpret some valid
>> pointers as errors[0]. 

it is an error to insert error pointers into xarray,
but @nhct is not an error thanks to prior check

this patch correctly checks for error returned from xarray store attempt
which is later (just after the context of the patch) converted via
ERR_PTR(), so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>> Which would then show as leaks, because we bail
>> out early and never clean up?
> 
> At least the PRT_ERR() will return a wrong error number, though the 
> error number
> 
> seems not used nor printed.
> 
>>
>> I.e. should this aim at net rather than net-next? It looks like it's not
>> just semantics, but has actual observable impact.
> Ok, do I need to send a V2 patch to net branch?
>>
>> [0] "The XArray does not support storing IS_ERR() pointers as some
>>      conflict with value entries or internal entries."
>>
>>> ---
>>>   drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 9 +++------
>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/ 
>>> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>>> index 800dfb64ec83..7d6d859cef3f 100644
>>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>>> @@ -3197,7 +3197,6 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp 
>>> *mlxsw_sp,
>>>   {
>>>       struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
>>>       struct mlxsw_sp_nexthop_counter *nhct;
>>> -    void *ptr;
>>>       int err;
>>>       nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
>>> @@ -3210,12 +3209,10 @@ mlxsw_sp_nexthop_sh_counter_get(struct 
>>> mlxsw_sp *mlxsw_sp,
>>>       if (IS_ERR(nhct))
>>>           return nhct;
>>> -    ptr = xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
>>> -               GFP_KERNEL);
>>> -    if (IS_ERR(ptr)) {
>>> -        err = PTR_ERR(ptr);
>>> +    err = xa_err(xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, 
>>> nhct,
>>> +                  GFP_KERNEL));
>>> +    if (err)
>>>           goto err_store;
>>> -    }
> 


