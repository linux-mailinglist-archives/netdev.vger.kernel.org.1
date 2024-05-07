Return-Path: <netdev+bounces-94264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63728BEE5B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C596C1C21C38
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743AB187340;
	Tue,  7 May 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzenidF5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F418734E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114885; cv=fail; b=MMKJQa9PTQixXoLH89/uBYce7Q3LFr1Gc/GJOvk6BCmwdzcBx8wjmd3NKe1+AHcDMu62jFsFI87UD3S0wug6XleOqqWU4z9g0II/ZOKuoDjYwUUlwuvyxSDbXl+EhuPdzhgEpkqEWlCejpbnESoTlslc5LeK9g8nx9qeTrUfJ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114885; c=relaxed/simple;
	bh=oKCoy0kZLpHouU4W6b6Ma/t3K06XhdvQl2QcwKyT+HY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hr659frEB7rqp26xWG+sKXWVuWbyEe9njV1gG4xN87/z9DnG1tWUAAZcNob/VV/6b07HaVT1zjWMvwSlA3OMP1kvn3OQCW7gMAo+ELxjlvfmWLxAB/Q1prxIVWAfcmV1bXXuOhu/tGL2pAYs9zDd2Xr7lgeohRGr9Q37CVOV2Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzenidF5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715114884; x=1746650884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKCoy0kZLpHouU4W6b6Ma/t3K06XhdvQl2QcwKyT+HY=;
  b=TzenidF5QhKBasqdvqBvZTXqf9Ei7GpPz9w+zb92nDSlSDGrHc81fBKr
   mvb3HhRGwlgUCmgxNB3K6lLn9QiXVwmycvqDuhEQbaEjiVsK4SZyv6Yvx
   vVl5i/ju5xGKP8wtRkTjU24sSqyfzHAHP6QHCRys0/SW3agsYchl4mtAm
   D0F17aLkdobAiRbG3bIXp6vcs29liINwGyxMHEwPpcFudYE9yG4jcvnLv
   B3Pt5DW6wjVtEexwawZ4mMUOvia+mfwgDcCmoW9aXGu7qz+mld3FrmRTw
   l4N08VUzzt9Nh2i3YYcrLD4g5caj/62BGJdcr2XyvbBzGtWZit7vkY6IO
   g==;
X-CSE-ConnectionGUID: d+3XHlpJTMe1Y9Jy0gXL6w==
X-CSE-MsgGUID: e95vk3kmRYuekhNVNRpLeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="13890812"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="13890812"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:48:03 -0700
X-CSE-ConnectionGUID: pcjlMzbTRZyqR9Io5mB+Qg==
X-CSE-MsgGUID: cYrPC3Y9SVCTi5NB/GndAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="51852548"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 13:48:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 13:48:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 13:48:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 13:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YczFiOEcfxjAjcGb+t3y1tUw9xhmwONCu0oaq6COE6c6HJy98rfugzKtK3fHx8S1u6HFoK60A8E1jQEjEReal/GCSissB/rUcYC8uECHfsy4271GgGPY4AQVyF/gE7gC7tclY11amS73bsFa0BYF+nLdNQgxHqWmroV5i3V8GDIlnH15X9MIOQ2cFTDQGRiLodnPj/qpoZuKQN3J750q7hzRnkHRf7mT9nHABZdizoz9hN/EAOLhDbYx8EsC1KJxdosDz5eHuZkC12HIBJtIOjf9drI2cOM3HxkJMnKhZiSu+9biBjDlW8loKf+rdIIm89GDshe9W/sIzuUMmY48Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZjdQ9CZqDjFVi5DgkC/JirCo5U8lMOcRz7XjtGPaPI=;
 b=Au0KU8RTtWGw/4CQNc9WuBgUC7pHuECzMrWVeWSf9NZjJ6M+gUgehCx7mlfzeO/0YKFhl8FQU5CZrA4igApHBBD9rb+8POiYhBgtMWbGqvRPoXxu90jPmMChruH9SNewZ+R20FkwJpySLE3RIHAnRWJ0D/PWy81k6+KML2JlvUcxOw6M8a7de1MivxJnVP7bkgHb7Y0EwHiKrmujUhzKkeppHe165HQvh994ZIpAiFqpY1kmiO5mxq7+zMwmItN8O7tY5QzDACXY+L/mKUpYt/r1gAwRlOPQjS+NIY1B6GXo7a+jQTmEC2lDu8Sls1/zBPU87BrzJChofpz8S9gT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 20:47:58 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::18ff:e3c3:1dd7:8a12]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::18ff:e3c3:1dd7:8a12%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:47:58 +0000
Message-ID: <4099c802-1fe1-4c04-805e-87abefb9d610@intel.com>
Date: Tue, 7 May 2024 13:47:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Driver and H/W APIs Workshop at netdevconf
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
CC: David Ahern <dsahern@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, Pavel Begunkov <asml.silence@gmail.com>, "David
 Wei" <dw@davidwei.uk>, Shailend Chand <shailend@google.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
 <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
 <20240507122148.1aba2359@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240507122148.1aba2359@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3e018e-8e5f-4530-8004-08dc6ed6fa20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG8zdGxvQTYyOTQ2MS81UG96cXcxMFczMTBWNk5DVWZsNTNKOXNVdzg1QUw2?=
 =?utf-8?B?aHhVTTN1VWsrR1JXanNCUUtpbUV5M3ZBNGlpcENHQzBvL3RHck9SaWUrL3hw?=
 =?utf-8?B?QytZY1Mwa0tVL0xkWGRpc3dJSmx0Rm1zTVl0QmlNbS94L3hoYTZ3Vitkcnhq?=
 =?utf-8?B?UHJGbldFcE1yZW80ZUZnUTVFV0c5VzVFMWt0RmlNSVVOd1V4c1pmZ1FUL0VN?=
 =?utf-8?B?NmR2dTdzamN2aEdvdmJITjF6NUFSZzQrb3BKM0I1MThxaWVQWFJ3d0wyQ0p6?=
 =?utf-8?B?cFJnUGI3UnI2ZCtvWUswMHlZWUx4azEva1V6Q0sraW5SS3hzZms4RWt6NnRw?=
 =?utf-8?B?d0ZkWWl1cW9MZGhjcnBoUjg5ZHdTUU9zYW5OdS9FQVl3cGZUbENMSGtzY0Vx?=
 =?utf-8?B?dHlKakxpTjlBR1ZaaXBpK1lRcGcxanFIcHloUzM5UEdoUU82QVNBSTdtS2Na?=
 =?utf-8?B?N2t2M3Jvc1JaVEFoQXR2cXRoUys4eStqT05pbnJTUTV3amtWMGMwZWxzSmRh?=
 =?utf-8?B?UnBWZmFadlNXcXFUNTAxd2s5M2Irc0NHYm02YmRydFN5SW1OT2NWQzc2WFhj?=
 =?utf-8?B?ZXVxQjJYQklsckNiSCtIZU1pdmoyU3lDaXBFam1zMlp1SlUrRkQxb1NQYkVw?=
 =?utf-8?B?UXlnYzNGM3RnS3hBS3c0dnJKOWZleDBrSWR3K1czYklkMmxHMUxZS0xyajBk?=
 =?utf-8?B?b2d0WTZKdmFBMVRWd1cxeTBFZC9nVEUzUUpJd2pEd3NnMU1xWXQwRmxDUms3?=
 =?utf-8?B?M29KbTRrTHNmWThrVVdmUU84aUtPU1dweWNQOGtVR2xlWTk5MHQ5ZUY5bHNo?=
 =?utf-8?B?WGZZeWMwUWltYXBXanlNak0xUU16TFMzYXJ1cDJYbmtOT0FJTDFmVmNJZ1V6?=
 =?utf-8?B?K0hEOXo3VGcrWDZadFlTYUdxYjlMUXRzVWdwaWh6aEtmRDJoanJaWkJtNTBh?=
 =?utf-8?B?TTUxWjRocldaeEZZc0c2Nko1NEdPNE85VkNpbUp2Mjd2SXo1TXVOcWxzU3hH?=
 =?utf-8?B?bnRucm90V29hNHpsVFdVckFWNVdNTGhBb05adlhKTmpSMFhkN2xVWm9xT2hw?=
 =?utf-8?B?TDZIc0ZDYW92Skx3MzJ6MEh5RnBlcHV0ZEJhZ2hNazZ5YUVSdi9oMENSYmtC?=
 =?utf-8?B?WGJKQmc5TllxUEtPczRybklMaU5GSG1EcjUxeFhtK2o4LytOdC9xZTduVmZX?=
 =?utf-8?B?a2RLelFJN3BMYjZySUhvMzlXYlpPaHU2ejVQc0RYbktVMGtobzhScXdPNmph?=
 =?utf-8?B?bDNIMUdmcEdpOTRObDkrTUJYVllyTkk5c2pkN3BRMXRUbWtzbU1lK1pPVVRa?=
 =?utf-8?B?R2ZpYmxsd1h4N0hIdTlQMUFoNWwrZ1hJREF2VTFaRkkvdlYrR3hxdUt5TnJp?=
 =?utf-8?B?TUczWkg4bHo0TUY5aERhR0FBMTlFUGZDOTJvcFNKazl4WlJvYzdMSE9FL281?=
 =?utf-8?B?U3M3QmR2MFA0VlB0alJDc0grY0dFNnoxSDh2VlJncHZUNEREWkdzVDNZeFE2?=
 =?utf-8?B?Q0lCQXViV2dGeUJudFFZVlRvdUZ3OVk0WnlxRTgzWlJCb2p6UHduVWtvZVNj?=
 =?utf-8?B?U0RxZ3RxUkkxa293bERhMG53VzByN00xNmRWNUdWN0V2QnJQdnZid0lMUFM1?=
 =?utf-8?Q?YWpSfTVxMERRqJQ12atToPjktC5Zn/ceeG/+LD1cnIWk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdiWVhPL0d1YXZUbGQ2VElaV1Btclc2cTB3MzlST2FTNG1wN0xRSjVSUjJx?=
 =?utf-8?B?MXppSFdxMkM3TlVRRGRGWFZ1SERCaVlNQlJZeWNibW1KeXMxSE1POU1qbmV2?=
 =?utf-8?B?Mm4rdG9MWld5cTdmMGRBUkxBc3dtNXEvT0dpdGpFcGZXdndwR3Y1cUJaMmpK?=
 =?utf-8?B?UHFDcnV0R3BERnd2SzluUmZ5Zmg3VFIvR0RRcmlmVEVjdXhTeW1YczRmUENh?=
 =?utf-8?B?YlBrTWFhZTJtdzZGNk1rNXg5b3pLNlVJeWtlYXdWRFQ1UUg3bVFrSlpoRytZ?=
 =?utf-8?B?SENDQnFQSHZtR28wSzRVeG9XOHlEQ0dvNE1URXdOZ24xSVdGSCtOYzVHQTUy?=
 =?utf-8?B?Uk9aaC9IZCtuNUpVc1Q5L2Vwb0RGNCtIMGlVTk91bGcrTnErWHh4ODZyQzVh?=
 =?utf-8?B?WG90dFRPdTF3NWYyTUtCWXFZc25ic25vd0ZTY2xYUXhUTXVHY0pMdjdXVkRB?=
 =?utf-8?B?Wk9jQ1BoYVZxRGpLZ1RtWHd0SU5RRmp4VmxuR3lZbFpqU0pVc1RBeHFBdGUy?=
 =?utf-8?B?L2dBTEZHSTdhVGJyaVErbEVNaitCcklxM1dCN1g5dXAyNTNPOXgwdkhabTlT?=
 =?utf-8?B?QjNEQXpweE8yZml4NXNLTlduTlZoTVFacVE3TzRrdWhvbEFDNkdzaXZxYUFn?=
 =?utf-8?B?YnhtNEpWY29QOHMxM0FKYjNpUFF3YXpLS2pneGpNbkI0V2k0TWcrSzZscFdu?=
 =?utf-8?B?ZHp0bzBaNFRMVGpHRzNGMktzMG9mc2hpV3VJUDlFOXFJOTNMallUZDFsS0FS?=
 =?utf-8?B?ZVNGUC90ejFSM0VTVXFOYUVwU2tadHlmditaSHVGamQ5YU1HNVFyazYyUHdR?=
 =?utf-8?B?TTBkQUgwZEx1cTJTYVNkSW1KbW44RmE4VkZmWlN4OVcyN0hXb0hYOWtVMCtQ?=
 =?utf-8?B?WVROQXlKeXVDTng0NXJaenIvb0U1b3RmTjMyb0NtT1o4ZGdKejZMeHNOcTM3?=
 =?utf-8?B?SHZJdTdaVWk4cHZYeEVEUGJ3RkhKWHlnWlN0elo1dk5zT3FWSkJ5cVZ6K09L?=
 =?utf-8?B?YmJEYWZZOTFaVXVJcnV0YVpEaXpGSVZBbFdiYXVLeHdmVkJOTm50aDc1bWY4?=
 =?utf-8?B?emo4YkxKdC8xQk1tcTBIZVVnVitEV2MyN0pjS2Z3ZUxWQ2JDaTBBK2h6eFg4?=
 =?utf-8?B?M21EclJQYTUxcUFxTHFQbThPa3BIckpTZW1xU1VqVitkQm1DYnBIeHZDUWFo?=
 =?utf-8?B?dUs1UTNKZlpIVVpyVFpBSTI0SytWVzBKdFQ0VkRmN1gxK0l4R0tSMUdCV2FB?=
 =?utf-8?B?emsyczgvM3BjZ0ErWDRrTm8vMFBFSTJLQ1o4MzFMRDBwTno0T21EQUJ4aDd3?=
 =?utf-8?B?bks2eUhRUFFiblRhbWxaMk5NVEVFMmxoSjhWMVlYTFEzZWhJTGcyTElyUy9t?=
 =?utf-8?B?VnI2VmVGOVNybjVobnVGS3d4M3NsR2hzVGt5YllPY1hHengvdEl1MjdKZmpr?=
 =?utf-8?B?NzlnbHF1bmlqNGh2LzNYWnNldS9XQ1BXQ1BJUVF0S25xL2ZZcmp1dEFaek04?=
 =?utf-8?B?RnhGd3ZNZVNpTDdvZHVtd3FSdjQ4bE9qdFYwdW5VNERieFpvMGhVbjRSZERa?=
 =?utf-8?B?VGw4UlcrL1A2THN1RWdyM2JtVWg0L0xDSVpCMDZRTmFtWW5va0FNcURoUG9J?=
 =?utf-8?B?TEd4SlREZEl2Mkw5cFVxOGVwVXRKaTRaT0dzVURmaFFSRXNwVlY0VzJMSGlz?=
 =?utf-8?B?MGxCczVJdSt1RjBDQ0VDMzJCekVPRkNaRVZCMXFjWHJodHNVWmlOdGI3UWNP?=
 =?utf-8?B?RDh5VlMzdVdwQmk4TldOcVd1MmdGcXJRU0R4L2ZWWnJpUHlzK0xVdVhHa2dN?=
 =?utf-8?B?WnA0ZVdhbWsrSXhXOVhMYUZQNmNyM3JDZUgvYzN2cUorVkZMT1JUcm5oYWkw?=
 =?utf-8?B?bVo5eUhPaStSbTN0eDRpR1BMWlBJNkYxek5lR1g3UjJTeDlsWlZRN05vVURT?=
 =?utf-8?B?S0hjOWJHUjh6ZC83WlExeE9EVGt4ZVZqNnhnbW1paGNFYzZvQkt2ZGk4d2NE?=
 =?utf-8?B?dEVFRXBvM3Y2M0Z4NUxNYkFDNExkRnhVRFdVdzE5MnR3UldWbzNXa2p4akpi?=
 =?utf-8?B?SmtOT3NmSlhJWnR3aUtHSkJKQWw5dVVIN1FwSXFkOVFtY0FGUVU0T3l3QXM5?=
 =?utf-8?B?QytmT1JobUZHMEtYbldLSm95cFQ0S2xhZnJvS05ua05PRzF1bTJReVIxdXFE?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3e018e-8e5f-4530-8004-08dc6ed6fa20
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:47:58.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+ZYjsTuMk+qrv+UlY1N6tzBbUcrKg0CV3oxbvSiGMXc0gj/1J2ZHm25ChglSytT+VpKZnFBoQxcSftFZWTWCNTbRTxfoPXVDkc6TwvGpH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On 5/7/2024 12:21 PM, Jakub Kicinski wrote:
> On Tue, 7 May 2024 11:17:57 -0700 Mina Almasry wrote:
>> Me/Willem/Pavel/David/Shailend (I know, list is long xD), submitted a
>> Devem TCP + Io_uring joint talk. We don't know if we'll get accepted.
>> So far we plan to cover netmem + memory pools out of that list. We
>> didn't plan to cover queue-API yet because we didn't have it accepted
>> at talk submission time, but we just got it accepted so I was gonna
>> reach out anyway to see if folks would be OK to have it in our talk.
>>
>> Any objection to having queue-API discussed as part of our talk? Or
>> add some of us to yours? I'm fine with whatever. Just thought it fits
>> well as part of this Devmem TCP + io_uring talk.
> 
> I wonder if Amritha submitted something.
> 
> Otherwise it makes sense to cover as part of your session.
> Or - if you're submitting a new session, pop my name on the list
> as well, if you don't mind.

I haven't submitted a talk this year. Last year, I covered the queue API 
efforts in 
https://netdevconf.info/0x17/sessions/talk/netlink-apis-to-exposeconfigure-netdev-objects.html. 
Post that, I believe these are the new efforts:
Queue APIs WRT netdev-genl - Jakub's queue stats extensions, Mina's 
netdev dmabuf binding (more like the first queue-set API in netdev-genl)

Netdev queue management ops - the queue APIs for alloc/free/start/stop 
by Mina

I was working on netdev-genl queue-set API for NAPI configuration 
(https://lore.kernel.org/netdev/171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com/), 
but as discussions progressed, I wasn't sure if that was the solution to 
our problem. As a part of that effort, based on the reviews, I was 
considering generalizing some part of the code into core for queue 
start/stop steps though the driver implementation would still be more 
extensive.

We are also seeking some feedback on devlink-extensions topic and plan 
to bring that as well to the workshop.

