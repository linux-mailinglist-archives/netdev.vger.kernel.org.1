Return-Path: <netdev+bounces-277249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAwUDvuJ2GkIewgAu9opvQ
	(envelope-from <netdev+bounces-277249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C043D24AA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A27300F189
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FF33436A;
	Fri, 10 Apr 2026 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOMDWOLd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4E278161
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798775; cv=fail; b=bg8BT2Z6zU/TJ38plj7E27c9LuVuLwa/1Jsju/TB2+8U2WFY4xKrgnfG4rEp3maBM51E24dj5K0vOUi/DCpS8mTWJGADneM+O1mSW5olXHL+oiPeIhkTRbyz8RVb3zXKpQMDUJidVRuYFqlb+SGCPMZDchM/wXkl3LFBdK2vjXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798775; c=relaxed/simple;
	bh=zJjZhrnDzLJf6T1ReGc7+fewpFU4JchXtKDPIFQLwAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyjEaUfDMUISYnQFdpWcbA8pR7PWNHxdqdWCBEtEe83SWJD03DCEdGLPaoa1uqmwMmyPwsD7MGQIUrkOAwqotMbdpmTLHStWCKMwi8rSxfxyrR2pV1iMMeM1/n1uCt/nijjESQpQOrgyb3ESR9LoyQiUTxexIhjKzXeM1OGpUKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOMDWOLd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775798770; x=1807334770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJjZhrnDzLJf6T1ReGc7+fewpFU4JchXtKDPIFQLwAk=;
  b=kOMDWOLdK7IIurUEnQBYMqSdez8hzSjDgvUJJPtlQKAFf9bfds39AL2L
   ifh4VmSGygKjEKyr5z27Xm3IC94ckEKgZQLEn1vU7uGC4nM8UBdkH1kf0
   26o+IoQhNtiRUP5p2nU6BQVXRy0KTjMsGAGvsPr5hIi56dsv58pxWPIZ8
   TBujaI5MpwLkkabZCjarqVkrFTQjD/lwEDHh/JHGmmi2ffvfqmYwGsyM8
   EwQSrgsNdbjrfOdL7/NKQ9fgsAmXeiBf6anD26IDkCkefQQvtjwU1W6tf
   bM33t9ch35q+3nRUi5ynrkcGtktR+XLQvELp85lyZNW+feLO97nSGrcaV
   A==;
X-CSE-ConnectionGUID: TRSKHpa+Ri+bie503anKpQ==
X-CSE-MsgGUID: kmvhIGVHSQuml6lArw636w==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="94390225"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="94390225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:26:09 -0700
X-CSE-ConnectionGUID: q7BEzx1ZTY2fHNEiM+Y3PQ==
X-CSE-MsgGUID: zeZYNvCNRY6Y5F3KFWgZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="226268656"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:26:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:26:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 22:26:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXtH/xcoYnyYbLqSQiAF19qLIRkt0IGS5hQe1CDbrcezG1ddYHaqee45ydYo99KiXhI2iNbELyA9LyNsCFFLcrBm6Oq1BY02CbgVLjrzXuckAzfq9S7COox2QzeJ/lgs6vVc5iqZfgb8gVhHquemLqIQwuNk77C8PWUBqgelr+lptgrHOF8kuMezj7VoXFf5Rrx0Cb5FX/uHb1tUvhH+Aw/othjY9YTMKlpOC+1PWDjmtn510jSmJ5zTitarIMDvaMUy+7BYgFgq2VGXAyD2D2v7zGyMpUZTrJ4vyHqfs3i/sD6gCi2y4/hV3n3CFuO8iSKGb9ScKNbKhxca4vEIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8m1MTT2pIMg8bzTKeP/m+YYBANRUVawa28okTjxzE0=;
 b=KsiGEaevcTBItiwTwgOfbqEqsc09EfrxI1m/x0Pex6mFZ7Cg9QoZ9ECH4uMI9Bu8j7Pl6JL7Rk3/5zbyI36wXBc1WWAH8HNtE8XbCnFGer7MAkEeGgv478QwoRsmWQyZMEARtWzTOLwrk3qoTKF6DCpPZnaOrpRhWeTOc/H2O2VidJSs0x6MmnbaLlTodfpTdmIV7vwDkNT/6GqAJDgcFMxJJBlBMfX+tLKT5jWsT4e7hV3Kz/t2ugM1itDdXW1nnkWjouNsH06aD5zGY0jkaBe0Ox67QUPbTU175wjLdcRdgJloPhGmTXLD3xGsIELU3sH8xFWfV/XYUvdHb8RPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.35; Fri, 10 Apr 2026 05:26:05 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 05:26:05 +0000
Message-ID: <98b6cb1b-7888-4c40-b359-4dfdad592b0f@intel.com>
Date: Fri, 10 Apr 2026 10:55:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add clear-error-counter netlink
 command to drm_ras
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <rodrigo.vivi@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <aravind.iddamsetty@linux.intel.com>
CC: <anshuman.gupta@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<pratik.bari@intel.com>, <joshua.santosh.ranjan@intel.com>,
	<ashwin.kumar.kulkarni@intel.com>, <shubham.kumar@intel.com>,
	<ravi.kishore.koppuravuri@intel.com>, <raag.jadav@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang
	<Hawking.Zhang@amd.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
 <20260409073318.2909379-5-riana.tauro@intel.com>
 <e7978696-eff6-4c1f-ab0f-047dccb18b59@intel.com>
 <413e8508-5f29-4a5a-a583-8360f9e48712@oss.qualcomm.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <413e8508-5f29-4a5a-a583-8360f9e48712@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 26980e90-cc4f-43e4-c5a6-08de96c1a9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PXAEnwkxmKiRsem5y7SJfepbaBAl59ATIlhTl8qJY0u0inLusQLOLK6uDoRa22wkppl8YOLxNIpqIWZkzCbQeENgNwEhSQt85Njj8JWi1DztXQEPfuoZG4x6iuv/ZzzYgCvC2XXHYgNeZbVMIVdn2km7f0sH4Q4hRqiv2acgsKhL82FYb7Xl405o6DKXV1+n297xmQvJqwo7nLaE/LhuuRWfYp8PF8gVuXJsnnI7WKfHDeqgJrferhdcPcGBdRCInJoOm3SelsBOrxKubMucqpD69RkUvRNnsV87Sd7sHFyUUz5uLmWEFkzJY5Ic59uczgJ15Or3oHG17PzPJiPe7LI7L2E/UMD8vZOsfBUVxYB8Y1FHDvWUkSTzC8USphrGs5JuZ58nlXahOuaXA2tEjAbAIM53rWf6BOk8h1cg7SWoB2s3JL8TxJLHPSb2ipejnwsEEUQ1HAstDjcW29A1xDfMeKBYX35W2LUCKHVHJp1/qSs8VU1Ihxr4dF/lllJ5e6MLd4Nur6AWwCwk/1BKV9Lyka3QqJqai7KmJ5Tw7vFF0yzJz6jVj3WsYpXmfbmAJ7NKUzXa9upL4WipQjSK5Efgn7cagLOsVr1w8tXRgaNLr1E9oSMJA2JrtJM5sJ3BNTJIqBkP0BRfoS7DIT8aMBdYVPuEigyWat/GMXyi4a3Had3WXxwWGCz0KA85NYLKTGBBUwd+VG5pXKHim5pa+sT8R9MYyu3toy9imb2wrNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hYMlVGd1ZiZkw3cGcxeE5BeEUwSEZ4SlJYYjZkZnBmWGZldE5QSENnRW9W?=
 =?utf-8?B?T29SbHBhNE5GOE12NFhFK1lSQS9kK3VJTXNHenNEc2RPTW93NTVPa3FHK3Rw?=
 =?utf-8?B?bnI0Y2ZLOTdlZlk2c21FS1lzOG9JcTVDWmNJc3liMXZORVgvOGFRZ0pkOG1L?=
 =?utf-8?B?WktWNzBzMFZadi9YNU8vck5WTkVIdFdkQlFSTmNQQnRTMUhtQVowVUJNOUxw?=
 =?utf-8?B?WVU0clFCK1pMNlJSQmJGSXRydW1QSCtKT21oc25oN2d2VVQycEEzTUJpN2tl?=
 =?utf-8?B?aTN3YTBBMndSejUyWXJST2k2dU41MW8wYzdqOTl3cEJSN3ZadUg1aWsrazBI?=
 =?utf-8?B?dGQzQWdrSTNLZWdZc3pBQ3FYWGJCOWRnc3ZlL2x6NHRpMnlocGhqNEsvNUhq?=
 =?utf-8?B?c0wyNnhleTZyd202RjMyWFI4UmovWkp4UTRVNFU5MklDRFFZSGhFck1vbmZp?=
 =?utf-8?B?R2d4eDFyOS9TNlIrTFVKVGFOQm9iM0gwR3J6SXVXWitmM1kvalozdjN1cGR2?=
 =?utf-8?B?NUZaTE9FbjZhZnZTLytXbVl6UlY2UHM3T3ROejVYVTJucVl4bU0zSHpzVG9h?=
 =?utf-8?B?aHNqakZZalVQaTFJYThQU1hHYUkxL0JsRk9xU1RRMXJIOFd0SFF6QVA2Ulkr?=
 =?utf-8?B?NG8vU21JSDMxSUF0aEdEeW5oNE9tcWF5dGlIbXdaM3A0WG5PV2h6bDRQV1p4?=
 =?utf-8?B?b1NXUXhrM3kwdkNTdThEU01YYXUwTjVHNjFEVktLZU51WXljR1EvT1NGMGhw?=
 =?utf-8?B?bXdDRlNwdnVlQTJ2TGx2N1RqUU1GZm03Y0txeHM3UDNFL1B1WXduSy9hTFVO?=
 =?utf-8?B?TlhhVXh3RHgvTXk0c0tQYjh6WU1RT2luUkRVYlNVZWF0U1UybjFWUlJoV0wy?=
 =?utf-8?B?QnhEbnlFMWQzMHVab2E0LzVXbHB3eDFwbXI3c1NuRENYdUQrSkhzNnVydUl3?=
 =?utf-8?B?VjJKNG5TWkc5SldnaTlKZURFOFE1ZEEzSFh0RlpOM0RNeS9KYUdjTm13dEVL?=
 =?utf-8?B?NHVpVy91dVN1Q3UyalY5TXBwNFZDeS90cE1sYUpuT2dMaG9BVnhwSE1OM3Fy?=
 =?utf-8?B?a1VzMUQ2eWtOT0lwOGVNeS9qLy94Wm5QT05CTGxQOFNQWTJiU1RpSk5MTWI1?=
 =?utf-8?B?NWFxZkUyMWk2SVZNSHJyNVE4MHphVHN5VkduMUYxcC9LRlgxYUFpaXJyYWRm?=
 =?utf-8?B?dlZkWlcvd2RDYkZwY2lhRjBiY2QwMTZQT040QlNvY3VDY2dFbGdibTFWb0o5?=
 =?utf-8?B?Z09XdFlZSkFmYTkwTjI5NFFnZmhJWGJJWTgrYW8rWFNNOUZ2ZWtnSHplNWpz?=
 =?utf-8?B?bWJLS3gvV0FiNFBzR0JUcXNQYndEVk1FSDUvcUN6Y2l4ZmJXN2lVNzl6UERF?=
 =?utf-8?B?NE02Zjg2WmpQdXlpejVlOGZKL2hYN3ptdVRsaHlzRDN5MEw3cEczaHNEQkp1?=
 =?utf-8?B?aHk0MUFGRHNCaHBJWGV4TWtQbVdveVFNL3cyQWJreGVSWDhhTEQwNm5oclB4?=
 =?utf-8?B?N0MyODZGUitjeHlBb2JwNDFoalBITjFGTXJEdTF6eUgwN09yaUVETGRlSExt?=
 =?utf-8?B?c0wzS1phbngzMytEVDJVU0R2dUM1V0xlSy96UjU4WE85U1ZwTThuaTJEN1kr?=
 =?utf-8?B?U0Y5KzlWWDdvV3U5bkZKYmpEQm5oSG50Y1RiK1B4ZVRRSUc0MjFrL0J0aTNj?=
 =?utf-8?B?UjRFYnM2cU13VUxWYytzazljMXR5QUtzQWFSWUVlaUd4Ly9uZVVvM1lLbUlt?=
 =?utf-8?B?SkwyYjM0YmF3NkExNGFpVHI1T3lsbHUwWEJQaUtaZjY2VGRQdHp0bGZBUHpE?=
 =?utf-8?B?Q1BFOFVlQVZWMUdNQ0tzU3ZUb3gxUjN5d21qUHJQc0tDSmhuWHJvZWhlZEpr?=
 =?utf-8?B?eThEdDdSSkhhT0dEZklIODlmeUdJTExDNHQ5UW5KVEFORkRkbGpxbWRwZG1x?=
 =?utf-8?B?RGdvNCttaWhmNkRNL3dBREp2RWJ6ZSsvTWRnZEhaNFREYWJOZ2xpeWlnNG96?=
 =?utf-8?B?RW9xeFp1c3RNRjdONnJZRDlKaWs0MHFjM2FQdUhtQlZ4dW0xbDdEWmpHRXdn?=
 =?utf-8?B?NE94ZzB6UVRmMHI5VjRKZFovZncwREE0d0UrRmR3bzg2elRzTDVXRG9zTHB4?=
 =?utf-8?B?T3MzdzY3R1RDZUpTcmYzSkdJWS9jZkhTVFBFdkxtZE5sZW5lcW8zYm9UQWFz?=
 =?utf-8?B?bXR0V2grSE84VEZhMXhWalh4TGJBL2xuQS9LQ2FYUXRJQ2FsL0NkZUN5MlhN?=
 =?utf-8?B?dkZteEw0L2xqY01FdDNOaUI1dUlzQjArWHNCa1RyUFdPeDN0d0huemJyS1Bw?=
 =?utf-8?B?SndDdGlrZHd5azdPQldqTGwzK2xuL05OcHhPczBEdVBodUpEak1adz09?=
X-Exchange-RoutingPolicyChecked: UEcYzU3lYoSqx99oFRyIvQMGJGGNoZUObxQr6TTMwa7KzKGloHe/X2Pl2nZPdF+5YJM6CcfsWqiBrmMPaKcsx9rNuzkwrRJ+ZQnJLoec4UHXrfNkx4u6gZPeQBT4m6CLeDnKG3W6t+6e1nZxfZiKFewt2sHyTFrT3eJIJ6p/F0rz9nvLpYTrh6ZXvUXt3rr+/3Qi2KXI8iHvw/8+LI4tZpyisLqhEpqy9WJIYFay1VdbFywzrmdHmZ2XaHvtBGH/mViRgUQzVI0fLSjx59L4XLfGaAB6KuR/SwsOwlaihXT25KYj/10hFPf4dj3vPrchSPu2NsG7zJGkk10QsrDilA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26980e90-cc4f-43e4-c5a6-08de96c1a9b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 05:26:05.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NY7rs3Qy8+HXFd7yCLgnYnUSgHP+UnyPChaC0hiJZrc9BUA57XiKZ6gAEeRUgP7Vsbizhng3J48LRBy+1rtzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-277249-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,ffwll.ch,gmail.com,linux.intel.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A4C043D24AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/10/2026 4:31 AM, Zack McKevitt wrote:
>
> On 4/9/2026 1:21 AM, Tauro, Riana wrote:
>> Hi Zack
>>
>> Could you please take a look at this patch if applicable to your 
>> usecase. Please let me know if any
>> changes are required
>>
>
> From a quick glance, I think this looks good from our end. 


Thank you Zack for taking a look.

>
> Thanks,
> Zack
>
>> @Rodrigo This is already reviewed by Jakub and Raag.
>> If there are no opens, can this be merged via drm_misc
>>
>> Thanks
>> Riana
>>
>> On 4/9/2026 1:03 PM, Riana Tauro wrote:
>>> Introduce a new 'clear-error-counter' drm_ras command to reset the 
>>> counter
>>> value for a specific error counter of a given node.
>>>
>>> The command is a 'do' netlink request with 'node-id' and 'error-id'
>>> as parameters with no response payload.
>>>
>>> Usage:
>>>
>>> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
>>> '{"node-id":1, "error-id":1}'
>>> None
>>>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
>>> ---
>>>   Documentation/gpu/drm-ras.rst            |  8 +++++
>>>   Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
>>>   drivers/gpu/drm/drm_ras.c                | 43 
>>> +++++++++++++++++++++++-
>>>   drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
>>>   drivers/gpu/drm/drm_ras_nl.h             |  2 ++
>>>   include/drm/drm_ras.h                    | 11 ++++++
>>>   include/uapi/drm/drm_ras.h               |  1 +
>>>   7 files changed, 89 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm- 
>>> ras.rst
>>> index 70b246a78fc8..4636e68f5678 100644
>>> --- a/Documentation/gpu/drm-ras.rst
>>> +++ b/Documentation/gpu/drm-ras.rst
>>> @@ -52,6 +52,8 @@ User space tools can:
>>>     as a parameter.
>>>   * Query specific error counter values with the 
>>> ``get-error-counter`` command, using both
>>>     ``node-id`` and ``error-id`` as parameters.
>>> +* Clear specific error counters with the ``clear-error-counter`` 
>>> command, using both
>>> +  ``node-id`` and ``error-id`` as parameters.
>>>   YAML-based Interface
>>>   --------------------
>>> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>>>       sudo ynl --family drm_ras --do get-error-counter --json 
>>> '{"node- id":0, "error-id":1}'
>>>       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>>> +Example: Clear an error counter for a given node
>>> +
>>> +.. code-block:: bash
>>> +
>>> +    sudo ynl --family drm_ras --do clear-error-counter --json 
>>> '{"node-id":0, "error-id":1}'
>>> +    None
>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml 
>>> b/Documentation/ netlink/specs/drm_ras.yaml
>>> index 79af25dac3c5..e113056f8c01 100644
>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>> @@ -99,7 +99,7 @@ operations:
>>>         flags: [admin-perm]
>>>         do:
>>>           request:
>>> -          attributes:
>>> +          attributes: &id-attrs
>>>               - node-id
>>>               - error-id
>>>           reply:
>>> @@ -113,3 +113,14 @@ operations:
>>>               - node-id
>>>           reply:
>>>             attributes: *errorinfo
>>> +    -
>>> +      name: clear-error-counter
>>> +      doc: >-
>>> +           Clear error counter for a given node.
>>> +           The request includes the error-id and node-id of the
>>> +           counter to be cleared.
>>> +      attribute-set: error-counter-attrs
>>> +      flags: [admin-perm]
>>> +      do:
>>> +        request:
>>> +          attributes: *id-attrs
>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>> index b2fa5ab86d87..d6eab29a1394 100644
>>> --- a/drivers/gpu/drm/drm_ras.c
>>> +++ b/drivers/gpu/drm/drm_ras.c
>>> @@ -26,7 +26,7 @@
>>>    * efficient lookup by ID. Nodes can be registered or unregistered
>>>    * dynamically at runtime.
>>>    *
>>> - * A Generic Netlink family `drm_ras` exposes two main operations to
>>> + * A Generic Netlink family `drm_ras` exposes the below operations to
>>>    * userspace:
>>>    *
>>>    * 1. LIST_NODES: Dump all currently registered RAS nodes.
>>> @@ -37,6 +37,10 @@
>>>    *    Returns all counters of a node if only Node ID is provided 
>>> or specific
>>>    *    error counters.
>>>    *
>>> + * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
>>> + *    Userspace must provide Node ID, Error ID.
>>> + *    Clears specific error counter of a node if supported.
>>> + *
>>>    * Node registration:
>>>    *
>>>    * - drm_ras_node_register(): Registers a new node and assigns
>>> @@ -66,6 +70,8 @@
>>>    *   operation, fetching all counters from a specific node.
>>>    * - drm_ras_nl_get_error_counter_doit(): Implements the 
>>> GET_ERROR_COUNTER doit
>>>    *   operation, fetching a counter value from a specific node.
>>> + * - drm_ras_nl_clear_error_counter_doit(): Implements the 
>>> CLEAR_ERROR_COUNTER doit
>>> + *   operation, clearing a counter value from a specific node.
>>>    */
>>>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>>> @@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct 
>>> sk_buff *skb,
>>>       return doit_reply_value(info, node_id, error_id);
>>>   }
>>> +/**
>>> + * drm_ras_nl_clear_error_counter_doit() - Clear an error counter 
>>> of a node
>>> + * @skb: Netlink message buffer
>>> + * @info: Generic Netlink info containing attributes of the request
>>> + *
>>> + * Extracts the node ID and error ID from the netlink attributes and
>>> + * clears the current value.
>>> + *
>>> + * Return: 0 on success, or negative errno on failure.
>>> + */
>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>> +                    struct genl_info *info)
>>> +{
>>> +    struct drm_ras_node *node;
>>> +    u32 node_id, error_id;
>>> +
>>> +    if (!info->attrs ||
>>> +        GENL_REQ_ATTR_CHECK(info, 
>>> DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>>> +        GENL_REQ_ATTR_CHECK(info, 
>>> DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
>>> +        return -EINVAL;
>>> +
>>> +    node_id = nla_get_u32(info- 
>>> >attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>> +    error_id = nla_get_u32(info- 
>>> >attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>> +
>>> +    node = xa_load(&drm_ras_xa, node_id);
>>> +    if (!node || !node->clear_error_counter)
>>> +        return -ENOENT;
>>> +
>>> +    if (error_id < node->error_counter_range.first ||
>>> +        error_id > node->error_counter_range.last)
>>> +        return -EINVAL;
>>> +
>>> +    return node->clear_error_counter(node, error_id);
>>> +}
>>> +
>>>   /**
>>>    * drm_ras_node_register() - Register a new RAS node
>>>    * @node: Node structure to register
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c 
>>> b/drivers/gpu/drm/drm_ras_nl.c
>>> index 16803d0c4a44..dea1c1b2494e 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>> @@ -22,6 +22,12 @@ static const struct nla_policy 
>>> drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>>>       [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>   };
>>> +/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
>>> +static const struct nla_policy 
>>> drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID 
>>> + 1] = {
>>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>> +    [DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>>> +};
>>> +
>>>   /* Ops table for drm_ras */
>>>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>       {
>>> @@ -43,6 +49,13 @@ static const struct genl_split_ops 
>>> drm_ras_nl_ops[] = {
>>>           .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>>>           .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>>>       },
>>> +    {
>>> +        .cmd        = DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>> +        .doit        = drm_ras_nl_clear_error_counter_doit,
>>> +        .policy        = drm_ras_clear_error_counter_nl_policy,
>>> +        .maxattr    = DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>>> +        .flags        = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>> +    },
>>>   };
>>>   struct genl_family drm_ras_nl_family __ro_after_init = {
>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h 
>>> b/drivers/gpu/drm/drm_ras_nl.h
>>> index 06ccd9342773..a398643572a5 100644
>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct 
>>> sk_buff *skb,
>>>                         struct genl_info *info);
>>>   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>                       struct netlink_callback *cb);
>>> +int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>> +                    struct genl_info *info);
>>>   extern struct genl_family drm_ras_nl_family;
>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>> index 5d50209e51db..f2a787bc4f64 100644
>>> --- a/include/drm/drm_ras.h
>>> +++ b/include/drm/drm_ras.h
>>> @@ -58,6 +58,17 @@ struct drm_ras_node {
>>>       int (*query_error_counter)(struct drm_ras_node *node, u32 
>>> error_id,
>>>                      const char **name, u32 *val);
>>> +    /**
>>> +     * @clear_error_counter:
>>> +     *
>>> +     * This callback is used by drm_ras to clear a specific error 
>>> counter.
>>> +     * Driver should implement this callback to support clearing 
>>> error counters
>>> +     * of a node.
>>> +     *
>>> +     * Returns: 0 on success, negative error code on failure.
>>> +     */
>>> +    int (*clear_error_counter)(struct drm_ras_node *node, u32 
>>> error_id);
>>> +
>>>       /** @priv: Driver private data */
>>>       void *priv;
>>>   };
>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>> index 5f40fa5b869d..218a3ee86805 100644
>>> --- a/include/uapi/drm/drm_ras.h
>>> +++ b/include/uapi/drm/drm_ras.h
>>> @@ -41,6 +41,7 @@ enum {
>>>   enum {
>>>       DRM_RAS_CMD_LIST_NODES = 1,
>>>       DRM_RAS_CMD_GET_ERROR_COUNTER,
>>> +    DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
>>>       __DRM_RAS_CMD_MAX,
>>>       DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>

