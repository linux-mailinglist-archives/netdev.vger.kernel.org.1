Return-Path: <netdev+bounces-240104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B112EC708E8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADDF64E7FDD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8E2FB99C;
	Wed, 19 Nov 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djZaafdr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97A2F7AA9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763574726; cv=fail; b=kSsREPr1ycYasCd2+GIPDAnX9Akd3L/pLjYcaoJsY/DJ5YUiBBSZyCc/l33SclVbSJG8AFZjmGBecp7e3uc0inNZ6H5Uo1x+smVPcSTku34V2SQlKfLBV+MJ6wT3SVJb0Rz/anIcfHSQr9K4QnIV7w/eKcq3iQQVSWVcOYs3Dxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763574726; c=relaxed/simple;
	bh=AoYwa5rafKcc5RCDGqkO5Bd/zVt5bGoQTqKDRMZrcuE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBz7+pBtuhcZ8ATMEo5nWi4W0hvX/GvOr5VqYwbio9nNjW/Pzd9YGD2/LctqxhH3SHh7MUkPiVSfE6IxfGtTwiEBe5glvJovR5T2oiLWElAsAbIFq1CA10oVDBybag5Fq64IPq2WuKHSrAXc48DbnRl6gfTZnEiJ1jyhjcUNKNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djZaafdr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763574724; x=1795110724;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AoYwa5rafKcc5RCDGqkO5Bd/zVt5bGoQTqKDRMZrcuE=;
  b=djZaafdrWJcqo32VE3ZOltzkLzo6jBspBlmdBLbwiezY83nCrgYo3fM5
   tFSy6VmV1F8Cmv8kut1YVMIy9I7Im+RODt3XCjWcEmCEarQKlb/BpD1C+
   nx/1DY/MEORUIbY50grYzKFEI653uCdz2w35Y9q2eUVVFCX2x3WQHkCsc
   3nGZCUWCzUd7Ybj8z5Hu9xbNr+Ri3HqnY4CNHGFkQTXLiz6lZQnvOHggq
   toQsD49l/DUbqfasd19CTPWdbeh7uE7nhvGyAdToncL/ZEuYLkKzJZzzY
   QkcshqSLyQeiMHNPRGKTBBJbY6UKuKYuij+2u/CsCHIbv6gId3kWAsCvh
   w==;
X-CSE-ConnectionGUID: AFyZT/6uSruOgyjuDQDvwA==
X-CSE-MsgGUID: UNLMxCCnTAOazOymnk+J7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69493198"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="69493198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:52:03 -0800
X-CSE-ConnectionGUID: gCNSbeqGQQ2jl5r35VqO+w==
X-CSE-MsgGUID: vlczcqHKQcOEnmEnFUrQfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="191921292"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 09:52:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:52:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 09:52:02 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 09:52:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufehU+g7s//Tq/YEBZ0oMe5jpAovC8LaJb9Twh/mc55wwfCbEfv+hP8Mfd3mYlsOVkjP+d1ohieVKCj1LFziduN4aIwl+Lkj9hAmXPNw1v7Hdffdfw5nnH/C1r/gIDtoZByXvc/tuMDa2f15+nlqJVaQfbAR2ZJ4okIGjB5hTX3UyW+WfoArBIlvMbPtVLiYc2v9AB02rqVDyUHGufP2gxZYNDkX5b10OYxlnhb41GS3B04iX8QHHu1AuI8DA2PXDbVsfd6YaAGAR6SHZvxh+5KEp8bB/HN1C24HgMhRiImuOMz0QIhgNGJpJCS6rXT8sO5cwx7S1//IgIdQhxGDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNUvgdt8h9g04/xU+Vxh1dL/Lpnf1xnQrgWLUYBkN8s=;
 b=j5J+7GOrgZ79E28Xzsg0xFl+4waMz/7gVoxBuoeqSqpzqq9lhz+1V2M//enE32o/4StcbhRNyGlYwOWSNJam/Mxl3w0Y/nHiPx0Ww932/WRN8bjeq8k7t7X7L5doUy+YsscsiFn5+UeTXGxj3lxvtr0t3FSZ8TjAkSPKnIu4PKb08oRUJIGM4I6f7TMqIwxWTgAn6KmBNQsqd7PzSHcJItHnJjhtbGucwdyQ74vx3F/6e57qccSsH+7s0c6J2o8omJnjgr276AT0qjhi/RUD8Ys4pPFZ/R+rjygV07C71XFaDDyRt2Or1DHx3W7vxMlwKexmotPXMOiautNWaDlaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:51:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:51:59 +0000
Message-ID: <de4ce073-5df8-4d00-ab26-c42ce73a5f48@intel.com>
Date: Wed, 19 Nov 2025 18:51:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: adjust conservative values around napi
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5a1a3f-91ec-4ebc-2762-08de279456a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXdiM2ZnbzRUVy85dkxkb1BrNjZXbGEyNjQ4aTQ1dktiS0xtQWNQd0hmeTZE?=
 =?utf-8?B?MllVMHNLR2RkOEU1ckwxYnNtOVFVM21TRHZtdzJWeTd0QWpkc1MwblBpeC9o?=
 =?utf-8?B?RS9Ta0doMjRyemp1VzRJWTd5YmdaQ0VkNmlqa0xraVZoMVJVbFhOS0dyT09q?=
 =?utf-8?B?ZURxS1JFR1hEYzFONHhpVnViMENzM05pd1c2ZEM0bWovcXp4Sy92YlJZdndX?=
 =?utf-8?B?RjNvNk5Qc0lBWkZZdTdZczJuMnFDazcrYmxsclp1VEp1azVtUUlac3ZqMkls?=
 =?utf-8?B?NnZrd0tyaFh2L2ZWdmFmZ3NzYWZrSzJEaWVQTGdYQm5wWlN4NUxpQ3NsVXRU?=
 =?utf-8?B?ZEJjOW5WSlNuV1dlZTROZ1IwRDRvaHowZDZOOHI0KzRiTFlqVmdNb1g3aHh3?=
 =?utf-8?B?Zkg3Q045L1p3SjNGdkQwcGYwN0t0STB2Tll4NDZJYjhva0dnckl6N015ZnZ2?=
 =?utf-8?B?b1JKVnlVZUlVNTNEcUJBS0FBRmZPZ3NsWWQwTS9pTzh5ckN1cFEwK1JnbS9U?=
 =?utf-8?B?Z002RGluSkhBbXlEY3B3YktBYVRkVDM5UlRjWlVRVy9ZWGZIVk1pbFIyTjlF?=
 =?utf-8?B?M2RlVFVOQ3hPNE80UVI4V2M0ZlV6QnRmZEE2MGF0a0dXNnU4a3dHQTcwejZt?=
 =?utf-8?B?QS9wQlRHSDFpK0RmS3JUZ25GVWp4d0lCQUQ0WVFmaEV4ZFc3WU0rbWxhbjVQ?=
 =?utf-8?B?RGhmbHg1UGpzTHhPOEpqaThCUVdjb1dGVHMxaGxwMEk2Ky9OWWF2THZYbU9I?=
 =?utf-8?B?TzhRV1U3dlI5NHFoYnZMc1p3dkZVeTBHRWJvSTNuZENIRjYrSC9zNHRMMU5s?=
 =?utf-8?B?N21xdFR4cmo5Vm9DdXpUZGhYVk1KOFJkS2ZpYy9DQzFIUGJWdElkd1dDWlpj?=
 =?utf-8?B?WjdwSkFWQnBwNVFoWCtoRjZqK0NOUkVMSGN3WUNneHY4Q3p5N0lNdXEyYm5Y?=
 =?utf-8?B?eklRc09DZTRSTG02NkZxU2Ivbk9iWnhYSUIwaSs4dHVLT1M2blJ3Uk9kcCtv?=
 =?utf-8?B?b29wUFZJNExjSmNIY09mRFZaRTZXd05HdFQvbEZkYTdCNkNqaWxWZGZWNFlP?=
 =?utf-8?B?SGU2cVBmZjZzWTZCOW9CTURpUVBzQTBmL1lFZ2tBcm9VemhtRnlLbjBXbDd2?=
 =?utf-8?B?Q20xR0RlYzBBNTZlTmE2WmVQQjhTeEErNzZIMXpzWDhZNElEdmthbGJNNm9X?=
 =?utf-8?B?WjAydVQyZVZzcE9LTmRkQnpnQmJlV01rV2svTm9YWGtpbWptaVNlTy9NOGEx?=
 =?utf-8?B?Q2gvNW14TjdyMUE5b1pYZGdnRzZqUXlTdVMxTFNFN0lGaEJ4VGhHbUdBSUhX?=
 =?utf-8?B?UElVUlNnVlY0VDFJa0szOWUrUUMxOGU3RklYMDhLZk41R1hZQUZkS3dxZ1N3?=
 =?utf-8?B?dWhaNFFORWhmNGo0bXpxWUhjeloxdXhSU2ZYcUpFaW54WWRwZFY2cjVKZWdx?=
 =?utf-8?B?S1BMM0FyRDlzOVpEby8zcUtIMjhMb2dBY2VKVUJ4S0dDN1lNSmM0THI5Q0N0?=
 =?utf-8?B?bEx1ckhUbytiVU9rSEZqa1dFRTE0YVZVUmRUNVIwSk1hcVcwVVdwY1BjSllj?=
 =?utf-8?B?VW16SDFreHdkaklGYVF6aUg3bVl0QUZaTS9CQXAyKzZxK2Rnbmh0L2VwdXZH?=
 =?utf-8?B?OUVtbkNlSkt3blRwOU0xU1YrVHJ1Ukh1SVErMTROTFBpdjlZV2RhKytxZGF1?=
 =?utf-8?B?VjVFaXNHMERyNXE5eGJUM2tLd1JlRnRZNzI2dFJ2azRNcEpkdG5JaUxodmNo?=
 =?utf-8?B?STA2dk5VYTdlTmtJV0NyQXRyOUN4bjArNFc4NGxuZTBuQ3oyL0tHMk1WQk1p?=
 =?utf-8?B?S2dJN2ZWR2YyR2VNdTV3UEdvam1wNUk2TkZYR3FJVzE4MDNHSFZERVVHU2Yr?=
 =?utf-8?B?WXBIeVRwQXNEZy9wMlVUcXJYclRJTjNHczYwM1hKZEFpSWo0TVVteFJ4Q2tW?=
 =?utf-8?B?ZWV5aGJBNjRKcitjNVdvemVhUFZVOWgzdUVXcnhnTy9wRllpaFR6clp1TFBS?=
 =?utf-8?B?SnhpeFdWMWlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFc4byt5UDJvQzlvS1FyV1V3RGJPSHkxYUZIWS9Kall4VUtzWlF4ZTdQVnRw?=
 =?utf-8?B?RTNDL3cySDJjMWdqejRvSDBVNUJ4VHZzd2xocWE3N05vOHgzSUo3SlIzWXpP?=
 =?utf-8?B?dTRVdEY4ditnN2NJakt0SnhZRXRmK1VRYVNENTMvV2FDNWZndEZjdjRCREhH?=
 =?utf-8?B?NzlEd1d2NURQSEJMdi9CekUzMlRkcDdqZngyb1lxN0RKTVpraTNXVXp1d3Vo?=
 =?utf-8?B?YmdaT0FHSTN3NVVJVnlERzE2MFZEWWhLcDFuRStTWDVsNkF1VWV0QWpQVWJz?=
 =?utf-8?B?UHZacTk5Sy96dmdsbzUyVnZZYkhKMW1YcG9LYUJRQlBmNmVjcldjSzJPUXcv?=
 =?utf-8?B?ZnFtK0c0SmUvcnpGWTVlTXVadTdVNEN2Y2pJUFFNaEJlbmhOU05sU2QvbGJn?=
 =?utf-8?B?cVNvL0Y5QnU4bkhGS0NrVEdLckw3K1dPdTNjWURydUt4RzlJNmhtVzZReWV6?=
 =?utf-8?B?YklmQ2w4b2h2Rk9MTXBWdkxZa3VOOTVaQTNZa2lnaTlDdHZzcGVZaVVqeHlh?=
 =?utf-8?B?TCtzdmV1RnF5Q1Z5dUcxa1ZJTGYrMkY1OVNlZXR4RjExL2tBQXROV25wWXE4?=
 =?utf-8?B?L28yL1oyZkluYVZ6WUp3cEZZUzZyRE0vTXg5a291ZkpXMjFmZHlmd2RrQlBH?=
 =?utf-8?B?d0lhNTREMmxKNFpFcEUvMzJia2lPRUltTXFFa0lud3ZMQ3lNeHRDdUlaTFFS?=
 =?utf-8?B?KzByemowdm1uR1IwdE9uR3lnOGJWTFp2cFZNbDd3ck9vK3ByaElHcWV5cGt5?=
 =?utf-8?B?RGtUM2c5TG85dnJ0ZzI1ZkFoTnJVNTQrSjBRN0h3YzFGYnNHcTRQSlk0MlB1?=
 =?utf-8?B?bEwxQlA5RndyNmtZTXU3NTdOYlRkYkVnWGlCTlpseXQwUFBqYXJOdjhVbFZW?=
 =?utf-8?B?YXBkUndaSXcxc2tBaDE0by8xbzAzMTlrWXdtbVY3UmRJTWdBVXIvNlhVY1Vu?=
 =?utf-8?B?MHVSWTJLUGNocjEreWE5WTdNTFBLS3VMTk50alZ0UG96RXdWclNGZTMxQklt?=
 =?utf-8?B?NWplUU02cWFUVWVjUThJOGZ5MXAxc3BmZVBqQWF0NFFBcG5ycGZWUWFnU1hj?=
 =?utf-8?B?cmpuNHRxUjRGb0tDSHQ3K0plV0VrRllZVG91UWVZcDdubkRqWU9EaEMwQXZq?=
 =?utf-8?B?cnplNXUzbFFiMHJrSmsrUlZEQXhxNkZTUjhKNUFuVW80bGlaM2ZxVTRVdG1o?=
 =?utf-8?B?cDJzdlBBdjkxaE9XN0VVNFMyS2VyQmpyZ08xRnFCZmZmK2MrVVMrcUxIZXFJ?=
 =?utf-8?B?cU1RSktqblA0enVxRWo4bi85UnBVK0xDL0NvSjA5Q1ZXeEZWRHNhZW14a0JS?=
 =?utf-8?B?NGJiQUZQa2xKRG5hcXBUMHYzcHk5WjVLZ0lNOWQ2VWtPdWpnZzhNNlk2U1Az?=
 =?utf-8?B?UVVseTArY2JmOGcwb1l4QklRV1I1MndVUU4zWEFHOHBSUXdhL2hpTlVrSE5H?=
 =?utf-8?B?Vk10bHlocDlTSHBWWHlFWHp3aDZiYlhLUXByY2VyZUtaQ1RnOHV4TzltMWE4?=
 =?utf-8?B?WVlaRHpuOFFrUUMzbk96dVdhRWVqblBlVGtHdzFmR1o2M0dqZXBxZVBqUit6?=
 =?utf-8?B?NXg5VTJ5M3VleGIrVGxndG1CTHlYTWo3SnVLTDJXem5MTnBRZ3RncEdmajI5?=
 =?utf-8?B?ZTZoNFp1OTAvWVYwbXVzUG9sM2pOK09Lc291K2tuQ2JUZmU4VzRmVjEyTTJh?=
 =?utf-8?B?cDUra3pKeU1FQ0M2QWNBRTFnWG9iY0FMN3JrR3BiSUFXTzg2N2ZzVnkvK2NG?=
 =?utf-8?B?cVlCalFQOW5qaXhTR2NDNTBEdnBWM2Zwd3JHTDIwSkJOUXFYR1UzK1hmTnA5?=
 =?utf-8?B?VTZFN3JwZG93cm9BUWJRaTNTdnZGR0hFWll0S0NndlZnbG13ME1ReGxUNHIz?=
 =?utf-8?B?MUxIb2FYVDZUdXpQckFVYWpROUllSmZoNWsxcHR3d3B3Q1d3eDN4WkNVVm9r?=
 =?utf-8?B?MkwzdjFVaDZjZk11TUs3ZGp2TExyYVZGUSt0dnQzWUplemlqUHVOMWZrQWVC?=
 =?utf-8?B?clpqTFBxbUZDM1UwVERqMmNGMHhzeDBjWm8zblRya3Ewbis4aXJrc3EzdFpY?=
 =?utf-8?B?a0ppUnk3RTdBQlZQdGZPTlVBSGc0UkNWYnlVeEdiQi9SSWRFVHNidElSdHUv?=
 =?utf-8?B?cGRISlJ2TGcybG04WG54VFRaSUdpK1NBeEdqNFdxL25MMTI5bUM5TnNSS3JC?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5a1a3f-91ec-4ebc-2762-08de279456a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:51:59.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQlEgh7K8frvf6WTCoVg9U7awjs62Rt3F3VoPOYraPuOZnxzL821ZKqpnsGuZ9ni2NcBtCG9yky9hqxyb/+ScZ8iuyGKSJGwOAFYxjR0THU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 15:06:42 +0800

> From: Jason Xing <kernelxing@tencent.com>
> 
> This series keeps at least 96 skbs per cpu and frees 32 skbs at one
> time in conclusion. More initial discussions with Eric can be seen at
> the link [1].
> 
> [1]: https://lore.kernel.org/all/CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com/
> 
> ---
> Please note that the series is made on top of the recent series:
> https://lore.kernel.org/all/20251116202717.1542829-1-edumazet@google.com/
> 
> Jason Xing (4):
>   net: increase default NAPI_SKB_CACHE_SIZE to 128
>   net: increase default NAPI_SKB_CACHE_BULK to 32
>   net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
>   net: prefetch the next skb in napi_skb_cache_get()
> 
>  net/core/skbuff.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

BTW I picked these numbers of 64 (size), 16 (bulk), 32 (free) when I was
working on 1G NICs/switches on a 32-bit MIPS board back in 2020. Lots of
things have changed since then and even back then, these numbers could
be suboptimal for faster NICs/architectures (and yes, the cache never
was NUMA aware as the MIPS arch code doesn't support even building the
kernel in the "NUMA simulation" mode).

I remember clearly that the cache size of 64 was taken to match
NAPI_POLL_WEIGHT.
The size of bulk to allocate was conservative, but back then it gave the
best perf numbers. I believe the bulk allocator has improved a lot for
the past years (note that let's say cpumap still allocates only 8 skbs
per bulk, not sure about veth).

Anyway, lots of things around NAPI caches have changed since then,
especially when it comes to how the kernel now tries to free the skb on
the same CPU it was allocated on. So I'm glad to see these parameters
tweaked.

Thanks,
Olek

