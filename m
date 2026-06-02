Return-Path: <netdev+bounces-294260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3V4LUjuHmo8ZQAAu9opvQ
	(envelope-from <netdev+bounces-294260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:52:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060E62F7A9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SG9wU1pK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294260-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294260-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F8073166BDF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7F3F4DD9;
	Tue,  2 Jun 2026 14:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F13F1AC7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 14:41:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411283; cv=fail; b=WrVxRIQz1kxF4sEtipGsMWOOXq5K6Rfqj5fbnZo3Q1+/39rzL9HqUT1Myzd5EXNCTzThvpGKmwNaSAtSV2yAZqycSvvm42qaGl+EneSsUczMLa98ZOBJrgDoMMa1m8MQQo4n6U3GyB84w1HltQgmrfdI1dbuXk/ishqp8j2DmsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411283; c=relaxed/simple;
	bh=U4GEqt4xh8mkoj+hdmbDdWgr2kwARB1AEOgYN/J/BKU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3vY6iYDw7Q6XjcGjMoUpRBgP4Fri4mXaThNmmX0vxeGIGMzeWlPOluugMe2l4EkJPEmM3U2yrkQ6cJYdpHInoLQOd3fBAZS6rcyAb2MGEz8F0gDQIQcx9NIiL/pHjkalqbI/Quedd4RMWn19fRNtS0RT32zpIqdvKuSviewTSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG9wU1pK; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780411282; x=1811947282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U4GEqt4xh8mkoj+hdmbDdWgr2kwARB1AEOgYN/J/BKU=;
  b=SG9wU1pKEwBuEY1w+Z4FIAK54MYL31UZ5u6QhdwsBXiTYBO4iZ8XIosZ
   3JY+tXPp0W+aQopL02EaKdOPRkZCofDcG4dvXvvNA0SzVNgm6rCkjUBwk
   MY0wZxHB6mExJi7EG13lLxNO+Fetc9fCvXS24Ux6oN0qRij1Db09GjKA4
   NYPH3AcbjxLSEf23/zUNyz31+uKUhtjO3Z0J6RbEMYFN/ImixvIZXW3Kw
   XLoByWO4IY2LBO6A1IU2QXFZoKhO+x3JXpWu7cqRbTA/GVa/dUsy1M6wh
   pr4tYhDoxEbilHhEDTsgxM91k3J7+0+3068f+MmsivWBfm6LMru64tKY8
   Q==;
X-CSE-ConnectionGUID: cWCGUPp4SRqiAxmLiSipmw==
X-CSE-MsgGUID: /ELX/QNbQEyp25vlbylJCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68740779"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="68740779"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:41:21 -0700
X-CSE-ConnectionGUID: l2PdsXwrSkm0wQZrBLOYPg==
X-CSE-MsgGUID: b7AASB8HTQGtDXreKqcTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243761764"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:41:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 07:41:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 07:41:17 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 07:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjOluG3u5u+Osikn2dc7zKwB/44BRGMBwujFBMLQgrQDae2FkD3oJ24DXLu4xhb4pJC6sjP+5CCZR8wyFZAX4y/nxlOnTI9gXnO5hl0XrOLhNbgxH5KuzawbQ8wP0am1XtudQtF/KvsVHvelqlyt9ucPMMQrFVBi1A8wVG1gbQ+CMAq5n9NPsy2avQcSda6fZuKGFW0AiW/ujlQFwej19L1Z5jcZXfkSEcsCtOuPCilopkaOdL3jiQVfQQgelAk4RPdjBrXCi7Pk6f9wX5q5GrqmMrvyFz2yHOSOdtTGbjOO1Zdu3y14lyL5AB4yCcKY2wZRDzOmEYtKzYauz01Beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsu8cUeTvlZ/HdiSco01gPawLmbfZvGQ9BK6+VSqD/8=;
 b=ewXaSQIEuylp505j/sNY/HEQW3T1hnY4KeA97OPUUiKN3+unAI0LQIYNun0mI14fWk83CxRv8hmZrPt8DnFJkl/cl/PtT7WyNMBSUTjA7o8nFvsqBMhUI10K2p3R5s/A42V2dCVQVRHmKHZKgERBxP4XZ3QV7boI1B1U29hcbWlI4xWeAdwcQA01Udjb1qS9bHUWmge0q6f8z7fp1u3lR3hbXpctyRI+rk+yDMxEa/pmeOYvULdv/2uF1y0G6DCSQ+2XMg7w28spWhm8ampC5DaR2S+8VLi+INbWpdEESJitH1R2d5hep0LyMG1dVXhIRPEqdLLmKgRBEVZubZjXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 14:41:14 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:41:13 +0000
Message-ID: <bde2f036-3e34-43ae-81cf-cb3ae07874ff@intel.com>
Date: Tue, 2 Jun 2026 20:11:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/drm_ras: Add drm_ras netlink error event
To: Raag Jadav <raag.jadav@intel.com>, <rodrigo.vivi@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, <kuba@kernel.org>
References: <20260518112048.1746280-4-riana.tauro@intel.com>
 <20260518112048.1746280-5-riana.tauro@intel.com>
 <ah0lKbnM9CD3JQoG@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <ah0lKbnM9CD3JQoG@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a120719-ae70-4d17-3266-08dec0b4fecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S3ZTc/VFSfbNPlbtYDdFhwyHW5fY0IpZy6KenPGfiixsuSlHf5cGsZYAG5sn8KH4aBNUZ5AaJ8AQju+sGOa1gkymUZ94ulR55abGoR9vBJ06bwzOBa+gP49Z5NoaOBz8g+MJRUjCIOl5t87e22UC+T2NVhgr6lktMvYvfQo2usf0eqXonmQSh1qrCnkbLT2TdSGS41sMu1hdM0cAvRKl/xwwbeTpp9fUyne7922BpyIbrpHPblpQNK85r64eIgTZvx4qdOP0uq1xbZcwxN0FsxakanlZJW0LxRI8+M4iw41+E4HVbXAMK1bPDOPpvQLo0HlE2RZJGXoJMRS4qIdAGvs7ZEFk+b5wzlvmKi+orkDNz6p6oR1zi8kkuXug1TbdA1OeKGjpx3nm+sT9w+pQt/gV9w2/5yvSSa4yNx+rkshw6hJoYP696vJuS1uwRBsANQmRmnWPcSVd72D0NAZnncMTLzwpHaps+f6BtUG34CdzYykm0lOlQrASmdxqQzvUrwTpnQv9kfWzqoYhXwSAUJ9F10W3Kzfu6T3ApQW7GSFAjTKfgWqOyHexF2m7WcpcmimGZxPLquuTykZ9kIF5/ZOtS+i81Sxzj/kW8DYEWQJw3SjlhIi3alcSy7I6ghewFxjxvHeJRGQ+8fp3+7sjZdkqO/PiZovi3JwqaF8/+wztlR0u3U7e5DgFulXSuYxi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9GMFBDREhUcVpBc2UwMVAvdXd2L2FLWnBvdzhaYW52dDBCYzF6TkRsOEsr?=
 =?utf-8?B?b20xeVhPNWhVVExFZDA3WDh3cWlEYW1UdlE0RjRFQUUrNythdUpKSktPOWN6?=
 =?utf-8?B?MWtYV0NUT2MvUDV5ZmtabkJKOUlrdE1Qdm94OXNuSVEzRWZpbXBQOUU0T3Iv?=
 =?utf-8?B?UmNwUGhrcWtYZE9SUlFVYUx5UVFEcVAxTjFSL1A4MFBReUNTOHFFUnQyVVky?=
 =?utf-8?B?SjB4cExjMVJ5VkNmTlhUTGhydHRBNFIvK2o0OTRETVhIUkdaU3FIc0hndEN3?=
 =?utf-8?B?cGtKQzlsdHJsM1dzQmw0WUowcUFIK1kvdDk4NVpNL0VGbjBsdkJQNEkzMUdG?=
 =?utf-8?B?NndIdk9xc09FS2pFMlVpOHpEV054UnNTMU1SUTVlVE5UZmpJUy9iWkJRYWw0?=
 =?utf-8?B?bWtQLzVONm5KZVNyVDFLcXh6eWRaYkxmQllFWGlldlVtTE9uV3FWRUM0N3hF?=
 =?utf-8?B?R0FEWnE2enJLMEFvc1BUY3djeVhOZ1JLUFFqT3FtZGRCUCs3Njhxcll5Ulpt?=
 =?utf-8?B?NHhDQWsweGpGZWI0dXBqbUJBQTFlYWsxSGEzQmEyNmVCelpuam1DSzRzUU9D?=
 =?utf-8?B?NFRveDZNcldkbGpuYWwwczZJSGkvaW5BZ3Z3bFNRd0R1QjhJN1I2WmZ0WThM?=
 =?utf-8?B?UVl2cU11QnFjTFBLSG1GMk9JNkpjcWlCTUdQajkycVBaMW9pZi9rUjNYRm1v?=
 =?utf-8?B?blhvUDd3bzBEaTFUTmtBL2RqNmdGUjMwcXgzZFBqVlE0Q21TbGtjYlNaNW85?=
 =?utf-8?B?Sjc3VytyNExsdEd3Z1ZCQVpWQytxaUU1MUovK1NYcVFwMzBtSTJ4QVZGZjRR?=
 =?utf-8?B?d1lFdmxDVDRjTlVxamFGaU9DNTJDR2VXK3BzRklITzJNMDU0ZmFvTXkzMHlP?=
 =?utf-8?B?TlE5aHB1Ylo3MVBqcWdDbVNSdlNaTDNiTzZvd3BlTUlQRW5uUkE0b0pYRGZt?=
 =?utf-8?B?UG00dG5ucHY4dnBnMUtPa0loU0dtcUU4Mko1eEMzd1V2OUlrVysxWnB1Q1Er?=
 =?utf-8?B?OUlvVlE4ZlBTd3k2VS9BNjAzNlRkaU0xR3lKakRkcGRmbUJIUndXdjRWdjYr?=
 =?utf-8?B?SlFFQnBmZm1FUmFhL3hLTXJwUk5XWHlsMjBXOFBLd0JXZUZBREFvelZxUmFz?=
 =?utf-8?B?bWlmK09xMHVadHcyanZ2UTZrbjZUNU4rVWxZZVpGbGxvTlRKMHAzSWRmdVhV?=
 =?utf-8?B?WUpITEt6TG5jMklrSWRDOXdqN1dsREVJemJJb3dacFdadlJob3U3ejRPYXRS?=
 =?utf-8?B?WnJJOGl6K0dSOGF4S3VhTUtUcGNvbjI1Sjl0YTNIYkU5NUV4VXh6WHpma0ho?=
 =?utf-8?B?MGNTOUpnbkZ1RTZ0UHNHTVVDa08xSTlmczVBbktnNjlHeno0WHFLMmVpalNQ?=
 =?utf-8?B?MjZ3MDlJZXVzYkVaVlQyWFdsZzM1dDFqRTBwbjRzQWZobEc4RUV3dGVsdVUy?=
 =?utf-8?B?U0x5aThDYjN0cjErZERDb2UrSkV4Z3hiRXdDQURtOTFjY1RsaGM5Z1RVdmFK?=
 =?utf-8?B?Zno4RmV1ajc0cGppMTRwWkpHSTRYQ3hqMWFEMk43Z1I2N0c5WnpOV1pHVDRk?=
 =?utf-8?B?dlYyZTV6QjBkMWtqVWx6akJSaEdpdFl1OGY3MWdOK0c0NDVYb3BnYWJaWGZ2?=
 =?utf-8?B?cDh1dndVSWl0VWNIcUdodnY2M0psa2QvcC9DelpKMGx2OXlHNHUweWlYSm1v?=
 =?utf-8?B?NXllOXhhUmhFNkE0NzdFUEIrdlViOE5acGdUV2h4MDRYZFcvWXcxeTBFTEto?=
 =?utf-8?B?MzZUd3pnZURwdTRhTzVvTndVbjRwUTN0ZndVaTNSVUE2YThSVmREMGQwN3Iv?=
 =?utf-8?B?WE5scG1aUVhmeUVldldjTHB4cWNzcU1LUlF6Z2NPYXMrdnZxOVhFdGVCSXRz?=
 =?utf-8?B?STBwWWU1dEFYTTJmRGFqb3kxaG14b3pDQWl6ek9JMUl2QW41UG4xOGo5OHJJ?=
 =?utf-8?B?eW0wVFBaZWRxdkxXWndvSGszbUpPNWhGQjgrMlJYRURWNXpUcmM4eERCY1pW?=
 =?utf-8?B?aDNtRVMwcWJFWWJGZGk1YzZIZWdDdnl0dXdydVdTdzNUTzZraE5mYUo5VzVF?=
 =?utf-8?B?T0JKM0IzV1VoQzNPSmFUazdYZTJUeUxkOFJYUTZIMHd4UURSbUFYeXFkUEs2?=
 =?utf-8?B?STYrY0hSVjB5UmkwUWhlc1ZIRnBQN0szM3lmRUhncVJxZmRxMHNwZVlLVDhs?=
 =?utf-8?B?Q2ZzeW9QN1VHaG1EMkt4RXMwMGNOc3VNbnNYUGpweWFtTFp4ZksxM1BLWGpJ?=
 =?utf-8?B?aFRXblg2UFllUEZTZklvZk5ZR2VjZDRKUUphdlBJZ0hvS0lDbDZiZmVNVWt0?=
 =?utf-8?B?UUE1OHIyUWEzbU9kZzBmcHNBZ2tvSnJYbmowVjhMTVRZcitrUGg5dz09?=
X-Exchange-RoutingPolicyChecked: RrbwaddC+thsle3Xku5hrlBTUYAbK/6uSgndMM9xPVEr8LGTTeRSuqnaHZSFtKZuGGARQkKS7Zpxnk7XtvJ3zqx/6FQkFSLOJNpkm+RFqMwciDlnREwDtZh7EidOzs3JV/fvSD34HFV/l/pN9Cq/NYiXqWTviTwpyBQi1YrQwZcCPHKkdCVtjY/zCEBmrtetzaY1rwVfxqFDIAJAh0WKkwXLWkaONfsTxhY8wHASkZDsFHq7QzW166Or45WZhyxaYZguY/pLStWalzzv3v8E2aX/772HqngP/tXH6AeJSCk28deN6oS37sD0XKjLtzmjUk3gCE9iH8pVLBtoWJTvYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a120719-ae70-4d17-3266-08dec0b4fecc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:41:13.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fD8SAVQ5W3zbPtMBTqa5G+HunnUA+yYbj7NijkexJWTISfpS9AFYUcE2p/9w1ECsBu4Ofej/l/Z/VvGKnP6vUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294260-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:rodrigo.vivi@intel.com,m:aravind.iddamsetty@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:anshuman.gupta@intel.com,m:joonas.lahtinen@linux.intel.com,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2060E62F7A9


On 6/1/2026 11:52 AM, Raag Jadav wrote:
> On Mon, May 18, 2026 at 04:50:50PM +0530, Riana Tauro wrote:
>> Define a new netlink event 'error-event' and a new multicast group
>> 'error-notify' in drm_ras. Each event contains device name, node and
>> error information to identify the error triggering the event.
>>
>> Add drm_ras_nl_error_event() to trigger an event from the driver.
>> Userspace must subscribe to 'error-notify' to receive 'error-event'
>> notifications.
>>
>> Usage:
>>
>>      $ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras \
> Nit: Make the leading space consistent with other patches.
>
>>        --subscribe error-notify
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>> ---
>>   Documentation/gpu/drm-ras.rst            | 21 ++++++
>>   Documentation/netlink/specs/drm_ras.yaml | 50 ++++++++++++++
>>   drivers/gpu/drm/drm_ras.c                | 86 ++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_ras_nl.c             |  6 ++
>>   drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>>   include/drm/drm_ras.h                    |  5 ++
>>   include/uapi/drm/drm_ras.h               | 15 +++++
>>   7 files changed, 187 insertions(+)
>>
>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
>> index 83c21853b74b..5a96dde75539 100644
>> --- a/Documentation/gpu/drm-ras.rst
>> +++ b/Documentation/gpu/drm-ras.rst
>> @@ -56,6 +56,7 @@ User space tools can:
>>     ``node-id`` and ``error-id`` as parameters.
>>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>>     ``node-id`` and ``error-id`` as parameters.
>> +* Subscribe to the ``error-notify`` multicast group to receive ``error-event`` notifications.
>>   
>>   YAML-based Interface
>>   --------------------
>> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>>   
>>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>>       None
>> +
>> +Example: Subscribe to ``error-notify`` multicast group
>> +
>> +.. code-block:: bash
>> +
>> +    sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json --subscribe error-notify
> So ynl can't do this? If yes, make it consistent with other commands
> (and also in commit message). If no, please document it.

Sorry . My mistake. Was using ubuntu and copy pasted directly from 
command line.
Should work with ynl. Will check and update it

>
>> +
>> +.. code-block:: json
>> +
>> +    {
>> +        "name": "error-event",
>> +        "msg": {
>> +            "device-name": "0000:03:00.0",
>> +            "node-id": 1,
>> +            "node-name": "uncorrectable-errors",
>> +            "error-id": 1,
>> +            "error-name": "error_name1",
>> +            "error-value": 1
>> +        }
>> +    }
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index e113056f8c01..d94c73a61aea 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -69,6 +69,35 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the requested error counter.
>> +  -
>> +    name: error-event-attrs
>> +    attributes:
>> +      -
>> +        name: device-name
>> +        type: string
>> +        doc: >-
>> +             Device name chosen by the driver at registration.
>> +             Can be a PCI BDF, UUID, or module name if unique.
>> +      -
>> +        name: node-id
> Curious, can we reuse existing partial attr-set?


I did try a few approaches before sending this

1) using nesting - Did not work with existing attribute sets because 
netlink does not
allow root set (attribute-set directly used in operations) to be nested.

     name: error-event-attrs
     attributes:
       -
         name: node
         type: nest
          nested-attributes: node-attrs

2) subsetof- cannot use two parents

The only way  i could think of is to move all attrs into a superset (ie 
ras attributes)
and the rest as subsets

or

Add node id to get error counter response and reuse the response as notify
(Response - node id , error id, error name, error value)

Let me know what you think.

>
>> +        type: u32
>> +        doc: Node ID of the node that triggered the event.
>> +      -
>> +        name: node-name
>> +        type: string
>> +        doc: Node name of the node that triggered the event.
>> +      -
>> +        name: error-id
>> +        type: u32
>> +        doc: Error ID of the counter that triggered the event.
>> +      -
>> +        name: error-name
>> +        type: string
>> +        doc: Name of the error that triggered the event.
>> +      -
>> +        name: error-value
>> +        type: u32
>> +        doc: Current value of the error counter.
>>   
>>   operations:
>>     list:
>> @@ -124,3 +153,24 @@ operations:
>>         do:
>>           request:
>>             attributes: *id-attrs
>> +    -
>> +      name: error-event
>> +      doc: >-
>> +           Notify userspace of an error event.
>> +           The event includes the device, node and error information
>> +           of the error that triggered the event.
>> +      attribute-set: error-event-attrs
>> +      mcgrp: error-notify
>> +      event:
>> +        attributes:
>> +          - device-name
>> +          - node-id
>> +          - node-name
>> +          - error-id
>> +          - error-name
>> +          - error-value
>> +
>> +mcast-groups:
>> +  list:
>> +    -
>> +      name: error-notify
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index d6eab29a1394..6696ec21782e 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -41,6 +41,11 @@
>>    *    Userspace must provide Node ID, Error ID.
>>    *    Clears specific error counter of a node if supported.
>>    *
>> + * 4. ERROR_NOTIFY: Subscribe to this multicast group to receive error events
>> + *
>> + * 5. ERROR_EVENT: Notify userspace of an error event. The event contains device, node
>> + *    and error information that triggered the event.
>> + *
>>    * Node registration:
>>    *
>>    * - drm_ras_node_register(): Registers a new node and assigns
>> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>>   			   value);
>>   }
>>   
>> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
>> +				     u32 error_id, const char *error_name, u32 value)
>> +{
>> +	int ret;
>> +
>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
>> +}
>> +
>>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>>   			    u32 error_id)
>>   {
>> @@ -222,6 +255,59 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>   	return genlmsg_reply(msg, info);
>>   }
>>   
>> +/**
>> + * drm_ras_nl_error_event() - Notify listeners of an error event
>> + * @node: Node structure
>> + * @error_id: ID of the error
>> + * @error_name: Name of the error
>> + * @value: Value associated with the error
>> + * @flags: GFP flags for memory allocation
>> + *
>> + * Sends a notification to all listeners about an error event on a specific
>> + * RAS node.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>> +			   u32 value, gfp_t flags)
>> +{
>> +	struct genl_info info;
>> +	struct sk_buff *msg;
>> +	struct nlattr *hdr;
>> +	int err = -EMSGSIZE;
> Redundant initialization, see below.
>
>> +	if (!error_name)
>> +		return -EINVAL;
>> +
>> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_NOTIFY))
>> +		return 0;
>> +
>> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, &info);
> Make this part of below and return err directly.
>
>> +	if (!hdr)
>> +		goto err_free_msg;
>> +
>> +	err = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
>> +	if (err)
>> +		goto err_cancel;
>> +
>> +	genlmsg_end(msg, hdr);
>> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIFY, flags);
>> +	return 0;
>> +
>> +err_cancel:
>> +	genlmsg_cancel(msg, hdr);
>> +err_free_msg:
>> +	nlmsg_free(msg);
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(drm_ras_nl_error_event);
>> +
>>   /**
>>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>>    * @skb: Netlink message buffer
>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>> index dea1c1b2494e..ac724bb87a3b 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.c
>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   	},
>>   };
>>   
>> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>> +	[DRM_RAS_NLGRP_ERROR_NOTIFY] = { "error-notify", },
>> +};
>> +
>>   struct genl_family drm_ras_nl_family __ro_after_init = {
>>   	.name		= DRM_RAS_FAMILY_NAME,
>>   	.version	= DRM_RAS_FAMILY_VERSION,
>> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>>   	.module		= THIS_MODULE,
>>   	.split_ops	= drm_ras_nl_ops,
>>   	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
>> +	.mcgrps		= drm_ras_nl_mcgrps,
>> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>>   };
>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>> index a398643572a5..17e1af8cc3b3 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.h
>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>>   
>> +enum {
>> +	DRM_RAS_NLGRP_ERROR_NOTIFY,
>> +};
>> +
>>   extern struct genl_family drm_ras_nl_family;
>>   
>>   #endif /* _LINUX_DRM_RAS_GEN_H */
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index f2a787bc4f64..d4a275efdbb0 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -78,9 +78,14 @@ struct drm_device;
>>   #if IS_ENABLED(CONFIG_DRM_RAS)
>>   int drm_ras_node_register(struct drm_ras_node *node);
>>   void drm_ras_node_unregister(struct drm_ras_node *node);
>> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
>> +			   u32 value, gfp_t flags);
>>   #else
>>   static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>>   static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
>> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
>> +					 const char *error_name, u32 value, gfp_t flags)
>> +{ return 0; }
>>   #endif
>>   
>>   #endif
>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>> index 218a3ee86805..bb2a8a872a44 100644
>> --- a/include/uapi/drm/drm_ras.h
>> +++ b/include/uapi/drm/drm_ras.h
>> @@ -38,13 +38,28 @@ enum {
>>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>>   };
>>   
>> +enum {
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
>> +
>> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
>> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>> +};
>> +
>>   enum {
>>   	DRM_RAS_CMD_LIST_NODES = 1,
>>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>> +	DRM_RAS_CMD_ERROR_EVENT,
>>   
>>   	__DRM_RAS_CMD_MAX,
>>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>>   };
>>   
>> +#define DRM_RAS_MCGRP_ERROR_NOTIFY	"error-notify"
> Where is this used?

This is auto generated and part of UAPI. Will be used by userspace

Thanks
Riana

>
> Raag
>
>>   #endif /* _UAPI_LINUX_DRM_RAS_H */
>> -- 
>> 2.47.1
>>

