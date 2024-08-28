Return-Path: <netdev+bounces-122833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4752962B23
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C72A28397A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666738DE9;
	Wed, 28 Aug 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCCH4zMA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D01DFCF
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857597; cv=fail; b=g+h5uoGOvjYEALdtzToDReDnxUDb9U/jpD94FgpSngzayZPCpDcOnFzjddg7Lyj8hxTqFmdFEq/SDpHKohdCd5s1x4maXV2dKIB3JBCb1J9Cn88e60FL6veygiFuagBtlNFk9UOdMamIBxcKenhYkcbAH11mVisz2OJiLtIUVBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857597; c=relaxed/simple;
	bh=V+vJpW/+u9X4KXcCelpCzzJLQRqUHUEXPH0nM/kuYUk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/A+O9tFn5TXNZESE5PyFCJx9xEV3Hejln+YZ1eS4tZIk8tqMM7xBBDXC6sgyBWwxzX8EIKp0gL0Tj1FiD0z6eh7yHQCrthE/zpn3dirsYfwlyxohXeH2kciGH2yaz+ENdskV3mnBVuuq1oYB98pyi9YLLhO4YM/XH+FikF86jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCCH4zMA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724857596; x=1756393596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+vJpW/+u9X4KXcCelpCzzJLQRqUHUEXPH0nM/kuYUk=;
  b=QCCH4zMA2dBe+LecTHOHC3xgJ6T3+q+9HD5x7obc7UmcHsPBKkMvzWWQ
   sBJct0IAVIDbPbyqOXG/5LXWbrRXP/JJ3AUYTG8yXZP97SFwaiwIfrey6
   57/S0eDwRrrALnrqwXvnPx+veRP0od7USggr1rtAmdO9wjtH8ls/pTiZw
   DJxE1ggd2rjrN8rNLgHuIJRnE7sFYUKgZCLMVEPeT4q+o17mPsLQzV1uv
   1ECK630KwoKZjfMQlcUuaWikvp4+uZkMrkGbs3vDWPE9Dpq32L0pgBiuO
   +MdueR44S11UJc1q6fN4lqXVvHt4gAFu/XD9b1FPZmg3sqAVuPBIV5BPn
   A==;
X-CSE-ConnectionGUID: jU7vP4snROq1k+t/MFqQsQ==
X-CSE-MsgGUID: 7bz7dqGKQAaXShVNKMW25w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23352737"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23352737"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:06:35 -0700
X-CSE-ConnectionGUID: twuXpqbETpe7dHJccS4VmQ==
X-CSE-MsgGUID: LlA42j1IRUmL2d+VYxm6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="68095074"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 08:06:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 08:06:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 08:06:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 08:06:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 08:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgDA9FwnhQ7ts8A0zi9iCMF+R+PiCdyKeiL8LB2wdnau0vM4fstjd83JmcGZDtl43MqqUvfLsySjImZ58TMWtu7SROF2iWO4NwJF6xTjoH9U5Km6UEpo05QBDzYp8azOoc43Ztte+FnH2Hx6eDMloEFftzLHvLkBeNYnbrvkOfZvc3ztRTDzcq4gKJ1lFwKQ6Gg4gb01BwIUoCPZlcRbLItPVdLrDijzWBYq3FQYIDyD5E7oyKGVfYbmX3uBh/1wv4FdSl8nQDA9XSaI8wTfm3HwvJljKMXSaIKRmf1gJXRkJJ9Ix5ARiNJ95DK8BKH36vB8zSbIB1JahOL5st3stQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEPGg1hEDuBRiRA+wijs2jU4j4oVtM2LH5Z6YqQC/uE=;
 b=a8EUPW8nuQwpupIHtljrzWvxrGL8a5u5FsXUSDzSmE7LipSIOGvzRQLfJiRQvy/CrNmPNfqlJupCK6Wa9DUjeAOn9lohWSjYmXOOjreln75G0/MBAjaxMNztpAiAPSplLgDqC5joteCwWwnRWSVtTf7gtQOqal9v+N4fvCQum6TkU/7fdGUsKakKCkq9RUyCT/bmv1LxE9JDeY6MLHHm29wquDrLv6V4e/kzb37SAWn0iFCV5MgnCsdBTFA7RPWJB1W6XJyOlyLab1uXAT0zCWxERm0q3QcD2ZBaP0KfZJmZncATZr7XwxrgfRB2mOF1ZOqz5vUj4/+gSjXuRLvqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 15:06:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 15:06:30 +0000
Message-ID: <ea4b0892-a087-4931-bc3a-319255d85038@intel.com>
Date: Wed, 28 Aug 2024 17:06:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-3-anthony.l.nguyen@intel.com>
 <20240820181757.02d83f15@kernel.org>
 <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
 <20240822161718.22a1840e@kernel.org>
 <b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
 <20240826180921.560e112d@kernel.org>
 <ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
 <20240827112933.44d783f9@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240827112933.44d783f9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0acad8-6280-4c78-6a7f-08dcc772ff52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azJJUWJ2cWJPWFE1WSs5dG1HZEpRUmdESk9FbTkvVUFIc0lyemptMVZwSFY3?=
 =?utf-8?B?NCtLSG93blB2amo1eXE1MFlncHZNTzlJY1hnbmlyK01yMnNvck5CRW1aZWV1?=
 =?utf-8?B?eVQwY0VwaDBBdFNZcHVwNFNUVFhwOEhIMW9HTkhxc1pMQWE4RWRQSEpIOWQ5?=
 =?utf-8?B?YmxPcWxGSTVORnFYU3hGZ0IvZ05Dclh3bUxiZXJQcVgrdC9GZDJoM2pSQjJo?=
 =?utf-8?B?OEJBTWxFT3FORk41L2x6K3IxR2lqRGtOdHJBRGUzZTdCQVZzMW5odWtkeFMz?=
 =?utf-8?B?MGdRd0dncE53U2tDYlN3Nm1mQkpreWZNYUZKUGZTMGtIL2Jnb3pYcGpXbS9w?=
 =?utf-8?B?MXFKR0hZUmhpTW1pN2ZqS3phRVA0V3lKQ3ExZ1YwcFFjaE5EWU9vdVFpOTZa?=
 =?utf-8?B?SHFhMzN3NE5haEhhcDZPTVlxUkM0UHVhak5qM0ljVXJYZXFtaUlNaVpULzhR?=
 =?utf-8?B?Qm1UdW5yeThhZDVsT0xWZGFFZm14K2NNL0hhd3Yya2xUQWhkY05xMlZqTjk1?=
 =?utf-8?B?Z2d5OVpVdWlYamxwMGFMWitrSktqdjZUM2ZxRnA4b1RmMDVaQWhMTUplK1F4?=
 =?utf-8?B?bVNEcWJlWVh1cndBQWVRb2l2azRXUk8ybVREVk5ic2pra2luYWtCT21YWWk3?=
 =?utf-8?B?cjFuOTZsOXVhRHdKeWM2UThJaVFTV1V3YSsvM0RzcWpiRVpjdHRzaE53OHl5?=
 =?utf-8?B?K1ZFWnJTSmhzZC9XeW1PRzBGbHNSZUVJVzRTeTdoTGxFV3k1VXZXSEJFMFo2?=
 =?utf-8?B?SzJiYWNxL1RHc1JjekFYTkRKdnpZaHloWitnWnpodFBFQmtFMk1rL1hXVTBQ?=
 =?utf-8?B?UEZRVTVMMXl2aFRLWCtsWDFzcXFsSGZzTjZLOFhWWVBrMGhwaEVmVSt6S3VM?=
 =?utf-8?B?bkFLdUgyWTF0aHE5b3d2bThIR0IrOGlud2dLdEpsQVczdHEvK29ueTIxT1ZE?=
 =?utf-8?B?aS9qd0V4QnQ5RlRpUnV2NnFGWDdYNEVGNlNLQ1liSlk2cERRVDlHbWlEREs5?=
 =?utf-8?B?aVRpK2ZsQ3NiZ0ViUnBUUWs1VC82b0Q2VUZRdDFCWERmdFBpcmdKZWxER1p3?=
 =?utf-8?B?MHpmTnBqaVNWZHE2Y0NybnV6d1hBOEEwbWVwc2VrbWdKK3MwUWtOdU5PQ1RZ?=
 =?utf-8?B?RmtXVTkzRm9Na3dQVWRLZ0lIWjFncis5ZUE1L2sxVDNldmtsS2tVdlpacnkv?=
 =?utf-8?B?MWZRWm4vSHhZOVhPUURIUHZsY0J3ZnNpVFpkUVFpdGZDR2FNWU13dGl1dVBW?=
 =?utf-8?B?bWxsT2x5NDlERXl5TWJBckh1MGthVFE2eEU4VEtmbmFWSHBha2tCOWVwVmZL?=
 =?utf-8?B?TEl4eERQaUxiVVppZjArK095TThzbjAvSXUxN0tRU0cxclhRZUdiMTFwVDZL?=
 =?utf-8?B?Ui90aDFZc3NMam9FUDB1K3FpS0pqaEdtLzBWa3h6S3lIRzc0SWRPOFBKejZk?=
 =?utf-8?B?WmVIQ0N1L3ZEYUREeXorQmVMcjJCVkN2UStZR29IbXdubzBpenI0LzFwczh3?=
 =?utf-8?B?UWw4UitoYVNLY3ZsWDFsUzZ2QmlmdnZMa3Nvbm1PaW8rZGR5YkVUMWd6T3BT?=
 =?utf-8?B?VFNaY0o2SFBJVFdzM29iV3Zya3dHdGZLTWJaV1h0NHdtR3BEejllSERNaWll?=
 =?utf-8?B?U3hEaXMxQ2MvS2d5Sk5HU3ZBTkljTk4xbHR2WjVHeTFDSVlSa0tRZWJobzUz?=
 =?utf-8?B?REJoRVJWSmtPVW1BajBPQ0ZpeURWdzhhMVp6US94andEUVdVdnZTWG05eXl1?=
 =?utf-8?B?T2VvQVgxRXdMekFLWTRxS0JUZWJLZjkvYTNuanhHZlF1NmU0TFBjREl6V2c3?=
 =?utf-8?B?KzBRN2xCcUhOZzlMNFhQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUd2cWhHT2pKVmpXVTUydXR3QVhPOFFSWmlIMlRKbkJqaUJ5VlJBNWQ4NnYy?=
 =?utf-8?B?N2JheU1YVXVjNHpEZ1BsYVRNaUgzUUVTZVNUSkNGdld3ZWdoby9OdWFQUWZj?=
 =?utf-8?B?NW5LTC9YejFCUHFFNWJPMXlWeGxjNHpzZ3gvQytDcWl6RGYwalRCdnpHb3JV?=
 =?utf-8?B?dE1YS2VVSHFyQ25raXFzRjdyMFRUdXY1aFMrSENpVWtKZnR0Z2RRa2JOY05N?=
 =?utf-8?B?Y0FWR3NyUTErekU3bkpjVSsveW9ZeWNrS2lQSmNBalhEOUh6WWY5dWFnSmRn?=
 =?utf-8?B?cHoweHpYS0plZ1E0Yng2dEZOYWN2ZDVIendSNFBRdEtONHdnVzB4Qzd3OE1t?=
 =?utf-8?B?dnozOXBUODdReUlSOFk4ZmtGaDdEYVlLRGFXcXdtS1NiVFVKNXBCZFRFek5v?=
 =?utf-8?B?cXNnUXl2enA0em4yMys2QzMzaUZGeWJ6eklDdXJwakRFRy9UV1RsNUFQNmlE?=
 =?utf-8?B?TC9xUWErMjFEYytOeDZyTCtzWkI1OUdNVGx6SklpWEVXWkVySWZsZ3N2Mm9Q?=
 =?utf-8?B?S1FWRjlua0VBWGZ1ZGJQN0tybVM1Y1JPUjVYbGRSeFBBLzFla1RNRWFKak9a?=
 =?utf-8?B?dHhGdlJiZWdYRzhoK0pyaWxSMjhHUTV0dFArcEZoS0lJYXJ0QWdiVC9BeEx6?=
 =?utf-8?B?Vk50eEVyQ0UrVFgxeDhYNDdHOHc5OU15U2tKY3J2NzFPa2RkZzJUZUUwZHcy?=
 =?utf-8?B?NEtzdjhRa3BlRkJlYnZybG9zR1RJZ2pMRTdTOGp3R2s2bmxjMTY2bkxsdTlu?=
 =?utf-8?B?cmZlVXdyQm1VUEEvNXBwVnRLMG92RU9uWEpKK3lvaGFiR0cvQ3ZwQTFvcGpI?=
 =?utf-8?B?YmpjRkl0bE1HdU5qMzRpNjgxMHpLaG40Uktya0tYalRwcTNJcHFnWjY0a1RF?=
 =?utf-8?B?TlovVjV2bm90QjY0VmpvTlRpbDBLSmtrUElOTUpTNmRJU01MelFudFpjblIy?=
 =?utf-8?B?K0pMTVlTR0lZSFpCajUvanZIRGpFNUZraDlYQmhkNjljSmdMTEpoZ3owcFpL?=
 =?utf-8?B?TFdyQjYreTh4dllza3BqcXdoYjNBVkVaM2pJZkJ6a3VrTy9Sb1BYUVVuQ1o0?=
 =?utf-8?B?OU9VV1pTOG85UWt2SkFZd0k4TVF3ZmNPYmVpTVFyMmw3WkhZUkJpT2dJTXo2?=
 =?utf-8?B?dTJZcTF4ZWtWRkNkMjVtZlR0MnJyc1BnQjExZDNIbm9rVjVQWXIyLzl3ak52?=
 =?utf-8?B?KzRkRzg4ZTQxTk03ajJQcUNzUEp4V3c4VjlJSGpUcDJISXI4NE95NzNFSE53?=
 =?utf-8?B?THpFckFXR0xhZE00Vy9yejNoaUpuOEcwaFFIN1QxTmdPNFJRQU85cTJXMFZz?=
 =?utf-8?B?ZVBKSURzQ0JVc1pxeTdDU2cwSndvVUNVZFBkWTVncE9zUnFxYXhZczh4VmUv?=
 =?utf-8?B?TkNISHQ0MS9GeDR0NGhuV0dmYkZhWHlkZ2EzWEcwNlJ4OEZQZE1tSElObFRi?=
 =?utf-8?B?NEFBOUl6UnhNMFkrODlCNFBYMnJnNjdSczB1blVoY001RnUrZEVURktRNlo3?=
 =?utf-8?B?YlRnWUhiWnJVTjhKdC84YnVTL2U3YWN0bnZuSDBMbVdDMGNGUDNUMFI5TVND?=
 =?utf-8?B?Qmx5MDJITWxwT1o2dklKNWdZeGR2Q05KTUNtU3BkeXY0TEsydFRKc1VKazFw?=
 =?utf-8?B?ZzZMNmZrc012SzdQOEg2Vkl5YVhJYmRGQ29Pa3hEeGQxOGJ5bE53L0IzZ200?=
 =?utf-8?B?SzU2bHJqemtXY1B4K01DcmVvMmtsWlNiaUhqMzVOWW50VlFZYVBQQVlMUGYv?=
 =?utf-8?B?dHlmRlZQcG5Fdk1QR0lkcGlyN2lZNTAxTFhNbGtsTUwwelgvZndqeU5oVGNC?=
 =?utf-8?B?UTdUdW44OWljS0FpWjlPZGRaK1pCeUVuS2NaeXJyK0x1aTJFZWovZDZUZS92?=
 =?utf-8?B?NUx5M0E0bkl6eVBkYmU2U3ZpY2hxTTlrU215L1NkS2VqUWZoZUFOcVZYZldl?=
 =?utf-8?B?UERjcVVXdnJ5VjdUdDRDdExqRXhQa01Ed1Vlb0pYYmRENlZMQmtXdkdvQ202?=
 =?utf-8?B?bXNnMktHMUErLy9zTlJnNG1QVHBtbDh1SGZCODBrZmhpbjdjc1NUcjlVcmdX?=
 =?utf-8?B?Vk1TMU1PN09sTENFaEl0QU5GQVlzOW0xWUpzL29jZlJaUUR3SUl4bVY0bXVo?=
 =?utf-8?B?Z1hhNHR6YTNidmZHRXR5dnl5d0FnbDV1OVBxV0l3eFpjMnArNVhsTmpJdVBQ?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0acad8-6280-4c78-6a7f-08dcc772ff52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:06:30.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOciSKfqzXTOeADHM8X7jyUyrxjJKfrz6d/iOGRzk9PFwhjDMe4WHDfIT8s9SRKNhEYG7bqmjiw5R+Xbnsmo/CBIKiQLH0jaXo/UrB35Hw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 27 Aug 2024 11:29:33 -0700

> On Tue, 27 Aug 2024 17:31:55 +0200 Alexander Lobakin wrote:
>>>> But it's up to the vendors right, I can't force them to use this code or
>>>> just switch their driver to use it :D  
>>>
>>> It shouldn't be up to interpretation whether the library makes code
>>> better. If it doesn't -- what's the point of the library. If it does
>>> -- the other vendors better have a solid reason to push back.  
>>
>> Potential reasons to push back (by "we" I mean some vendor X):
>>
>> * we want our names for Ethtool stats, not yours ("txq_X" instead of
>>   "sqX" and so on), we have scripts which already parse our names blah
> 
> If the stat is standardized in a library why is it dumped via ethtool -S

So do you mean that I need to make these stats generic Netlink instead
of adding Ethtool stats?

[...]

>> FYI I already nack inside Intel any new drivers since I was promised
>> that each next generation will be based on top of idpf.
> 
> I don't mind new drivers, how they get written is a bigger problem,
> but that's a different discussion.
> 
>>>> I'll be happy to remove that for basic Rx/Tx queues (and leave only
>>>> those which don't exist yet in the NL stats) and when you introduce
>>>> more fields to NL stats, removing more from ethtool -S in this
>>>> library will be easy.  
>>>
>>> I don't scale to remembering 1 easy thing for each driver we have.  
>>
>> Introducing a new field is adding 1 line with its name to the macro
>> since everything else gets expanded from these macros anyway.
> 
> Are you saying that people on your team struggle to add a statistic?

For sure no. I just let the preprocessor do mechanical things instead of
manual retyping stuff.

> #1 correctness, #2 readability. LoC only matters indirectly under #2.

#1 -- manual retyping is more error-prone?
#2 -- gcc -E ?

Anyway, just side notes, I get what you're saying and partially agree.

> 
>>>> But let's say what should we do with XDP Tx
>>>> queues? They're invisible to rtnl as they are past real_num_tx_queues.  
>>>
>>> They go to ethtool -S today. It should be relatively easy to start
>>> reporting them. I didn't add them because I don't have a clear use 
>>> case at the moment.  
>>
>> The same as for regular Tx: debugging, imbalance etc.
> 
> I'm not trying to imply they are useless. I just that I, subjectively,
> don't have a clear use case in Meta's production env.
> 
>>> save space on all the stats I'm not implementing.  
>>
>> The stats I introduced here are supported by most, if not every, modern
>> NIC drivers. Not supporting header split or HW GRO will save you 16
>> bytes on the queue struct which I don't think is a game changer.
> 
> You don't understand. I built some infra over the last 3 years.
> You didn't bother reading it. Now you pop our own thing to the side,
> extending ethtool -S which is _unusable_ in a multi-vendor, production
> environment.

I read everything at the time you introduced it. I remember Ethernet
standard stats, rmon, per-queue generic stats etc. I respect it and I
like it.
So just let me repeat my question so that all misunderstandings are
gone: did I get it correctly that instead of adding Ethtool stats, I
need to add new fields to the per-queue Netlink stats? I clearly don't
have any issues with that and I'll be happy to drop Ethtool stats from
the lib at all.

(except XDP stats, they still go to ethtool -S for now? Or should I try
making them generic as well?)

> 
>>>> * implementing NL stats in drivers, not here; not exporting NL stats
>>>> to ethtool -S
>>>>
>>>> A driver wants to export a field which is missing in the lib? It's a
>>>> couple lines to add it. Another driver doesn't support this field and
>>>> you want it to still be 0xff there? Already noted and I'm already
>>>> implementing a different model.  
>>>
>>> I think it will be very useful if you could step back and put on paper
>>> what your goals are with this work, exactly.  
>>
>> My goals:
>>
>> * reduce boilerplate code in drivers: declaring stats structures,
>> Ethtool stats names, all these collecting, aggregating etc etc, you see
>> in the last commit of the series how many LoCs get deleted from idpf,
>> +/- the same amount would be removed from any other driver
> 
>  21 files changed, 1634 insertions(+), 1002 deletions(-)

Did you notice my "in the last commit"?

8 changed files with 232 additions and 691 deletions.

> 
>> * reduce the time people debug and fix bugs in stats since it will be
>> just in one place, not in each driver
> 
> Examples ?

Eeeh I remember there were commits as between the drivers, the logic to
count some stats was inconsistent? But I don't have any links, so this
is not an argument. But I also fixed bugs a couple time which were the
same in several Intel drivers, that can always happen.

> 
>> * have more consistent names in ethtool -S
> 
> Forget it, better infra exists. Your hack to make stat count
> "consistent" doesn't work either. Unless you assume only one process
> can call ethtool -S at a time.
> 
>> * have more consistent stats sets in drivers since even within Intel
>> drivers it's a bit of a mess which stats are exported etc.
> 
> Consistently undocumented :( qstats exist and are documented.
> 
>> Most of your pushback here sounds like if I would try to introduce this
>> in the core code, but I don't do that here. This infra saves a lot of
>> locs
> 
> s/saves/may save/ ?

Series for more drivers are in progress, they really remove way more
than add.

> 
>> and time when used in the Intel drivers and it would be totally
>> fine for me if some pieces of the lib goes into the core, but these
>> stats don't.
>> I didn't declare anywhere that everyone must use it or that it's core
>> code, do you want me to change this MODULE_DESCRIPTION()?
> 
> I deeply dislike the macro templating. Complex local systems of this
> sort make it really painful to do cross-driver changes. It's fine for
> you because you wrote this, but speaking from experience (mlx5) it makes
> modifying the driver for an outside much harder.
> 
> If you think the core infra is lacking, please improve it instead of
> inventing your own, buggy one.

Don't get me wrong, I did it via Ethtool not because I don't like your
infra or so, strongly the opposite. Maybe it was just something like "I
did it thousand times so I automatically did this that way for the
1001th time", or just because I wanted to deduplicate the Intel code and
there, all the stats are in the Ethtool only, dunno =\

Thanks,
Olek

