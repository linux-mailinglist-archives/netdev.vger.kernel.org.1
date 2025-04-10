Return-Path: <netdev+bounces-181066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5EA83834
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B433BD8A0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6B1D516C;
	Thu, 10 Apr 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVJ4CH2n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788519E975
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744262630; cv=fail; b=DDBWH664TAZ6z+vi+tXaSdgYz1uuYZt5MBJGx1F89/5CrSnsfanzJKNTR0W8YALrsCZBpgkSb8vcPfXd84tNXLpidCo+HCRiU6YgncMoobAmZlcupWBJV7csNT+styydZBJ+WgTofJCDiJK8tagE6hKljiaWKxuZakp12DZkMzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744262630; c=relaxed/simple;
	bh=zc2KwUECHi5JTIbEw8vGiY9zLu/TrCP+FV2BWOUcHAw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bp+Z9wgRP5+pWB0YQ48cPxKF57Uz0zcS9nUPjzV6/XH0g++q2ZVcVPtZYR31NCOfm94wmyoJgUvdC60XKvMDx6U/OHLhbJTmDWxzcRyi28Lr0sx3uOWs+XbdYG3cHwV2JoWSgfypO8XoRCgcoyCs+poVHIKYC7KcCVdxa5nEN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVJ4CH2n; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744262629; x=1775798629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zc2KwUECHi5JTIbEw8vGiY9zLu/TrCP+FV2BWOUcHAw=;
  b=BVJ4CH2nr4vUGVhZoYBr3ctasEzHZ7Q2GhncsOEoBUlYjl4yUkeAMlOV
   fp1sGzI4sQ9/PRM01uiWyzoHFLXMxceiBE63wailyVpQs2c2hrrER4ZXH
   tZ3v1uf0eEVqxWdKfl7yKjV7HgLlpqLUYT+EjpEEZbGVhZHSRSIKFD93a
   rgCEhuRZ7e/e+xKGuYcANOGlYMe33uuVYjEx14Xqw1biIj97I/XajdAlz
   cZYtECw1S2AcV+yFVoPVL/ep2SR3BktlsjoaejITyqcVXk37c7uJcDGEL
   s96UiOwOVtHMbC1jDY5pddXAnnfFAa3YEsFUY15+NkBdY9Cb2rRghApE+
   g==;
X-CSE-ConnectionGUID: mJpPe7KwRwuGgf5DpE56QQ==
X-CSE-MsgGUID: zZdpz8+HQ5G7cd4sMxPqKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49562061"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="49562061"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:23:48 -0700
X-CSE-ConnectionGUID: fyvhPdEzQkijgslR2EUPeg==
X-CSE-MsgGUID: ewDLmUieRqSmjI9e0EAjQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128772832"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:23:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 22:23:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 22:23:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 22:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2c452B9BtG3kAE/I9pmEzMvYc6l0rsZfNh58wX3TeRGuCoUKKc6jEByVnhDHrHvOklqX5jiKqs1N/vIVGM62kbHIb1HYbK7m033Fb7U0N5q3qV9lj17peWa1CuZYj728X8BdeIIhnpYTpa0G0D+QQ5xuNJRpptC9GS3WzbpZvjBCiOg1M5YCsXvrFHuW0Zc9B8pKYmDm5Q8oAql0UA2by+N3yfRMqJDVEq64cDdJuRCJg3lCD3gGTbLy6S5Xw0zpikrykL0SaRXo2X4i2910zY6/PvBbwLJGdtrbYaWWFxIr0Qkkoaq+cgYCk7H2MdIsGCVJoEbQtS/bZeMhAEOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdQS8Vr9CHi5nCHCKXuUukU6XjwDEhZW9Ws6sGIh11o=;
 b=PJbXEmS6FvSpveIRtGu82qfR8NXe2V4eVvoE8FQYk6/DwfCyWF3TBCzfjKbgb6gVo/LnZuvUzRUsP/N7eiPRM/bKn4vvH7RNfYFmEbsU5DUU/6eaeDxV9mNZ026D74QVS9KMMfHmYiG6jDvKiQBojYtGY5LjmLr+v5/QRocJeadJPhnr4vNipQ3COdnS2By5XqxO5SG8Wp2gS16RUu5sdqAwvRq0c1Q3ph+BXS1oPBHZYJaMB38LrOaA6CswAFbW4fKvjqA4qEg2+frmI1oXFQHBnEJ/4v9/3ZajXeicndEDxOKACKRd0sehEQryRqwId/TP7/eNazWnkoMTUAtHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.25; Thu, 10 Apr 2025 05:23:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 05:23:30 +0000
Message-ID: <a2768226-854e-464d-8e76-240f7c76e987@intel.com>
Date: Wed, 9 Apr 2025 22:23:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] netdev: depend on netdev->lock for qstats
 in ops locked drivers
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <sdf@fomichev.me>,
	<hramamurthy@google.com>, <kuniyu@amazon.com>, <jdamato@fastly.com>
References: <20250408195956.412733-1-kuba@kernel.org>
 <20250408195956.412733-9-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250408195956.412733-9-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 792f2b5b-f947-4569-b158-08dd77efd481
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzRsNlRzTnFtcDhCU1FZL1J5azR2Vm5qWGRSYXlteFcrQ2w2ckJ4NHkwaVBS?=
 =?utf-8?B?NzJLZHR3YTRPcE5oakVCdHBiZmliS2xVcE02TVBETmF2TFQ3Y1VlSWRMRWxZ?=
 =?utf-8?B?ayt1cGNCeXB6eDEvTFdNUjhoS25uMk0zT1FKZHowaGlYamczaFpEeTlBWHNq?=
 =?utf-8?B?TVpYcTFHVGFpd1grd2tZeGNqT0ZWcTBvemh0QjczVkhOTzh0WGFWbDJBYTBQ?=
 =?utf-8?B?Um9RTTZNZ0FISC9GcFFITjZRNWVMY2lqdWRFaCt5NVJESVlLNHQ0TGt3VGtu?=
 =?utf-8?B?a1VzdDAyQ2lnVVVGSC8ydUl4dmdvcUxpL0VaeWxzQmwzMW81dHlQYWladWkw?=
 =?utf-8?B?MzgxS2ZIL0pVZXlPb2JYK2RSMlhhUnl1b3NPQjBmOW9ZTFc0d1FOalp2c2ZN?=
 =?utf-8?B?SzVMRjIxZndKT3RwSHhCRjQ2d0tEcmFNNktyQWxrU2M5U2c2WUpkb0Zmc0M1?=
 =?utf-8?B?NVQ5Q2RTTkZPdWJzazRKSWVKYXFneTZtb3g5cEZnWUpUQ3B1ZitqVmR4ZCtF?=
 =?utf-8?B?MmlYNlcrc2hTMFRyQjRQallmRnNadzRsNGZFekFPakpaUXorcFROZWpsZzcw?=
 =?utf-8?B?YWNKSm80VmRoYWxwR1NhWUpYSDM5WEp2V1JsN29ESlJjS3ZBQWxzYWllOGl2?=
 =?utf-8?B?QzZoMHRDUit3QXR3bW11RHM1ODJYd0U3S3BmYi9wTDBHMHF1TUQwOGFTWTkz?=
 =?utf-8?B?SmxQM3lYZnpwU2VQNE9GWkowMlNTdjFSVXBhYXMxdXZLRldIV1Uva1RxT0Jm?=
 =?utf-8?B?ejdtd1poakIwb1BHQ3VEOXpjdmVkY3hWRjVNNUV0Ly9JUDg2c0c0Q2FWNzlU?=
 =?utf-8?B?andnZDg5ZlE5Qm95Q0pBVDQ2SlB0MlJCbnYvZEtoT21vMHVlVVhuQjlONHR3?=
 =?utf-8?B?RGo3VEp3c0pSSnhEWThOT3d1ekdWUkJ3cU5FbEEwM3A0NWthcFNMMjFsSCs1?=
 =?utf-8?B?Wmd2ejNGZnQ0OFJWOStNZU4yelhLT0tNQVZVUm9CdVh5ejlVa2xDcmZvbTgz?=
 =?utf-8?B?QzZDdXFDd3B4VlpzQlFDa1YvMGlDYWNGQWhub0d3VmJ3NExFK09OQXdVaTlr?=
 =?utf-8?B?bGpjZzZWVmRhdzg1ckZIL083Z3gwcFoxWFlnMmc4dVRlMFR4enpXTlFpdHdx?=
 =?utf-8?B?M1NoWjYvT2FVTjg1NHBBTVdMY0Y1emprR2pxQW5KTU1TL2N6dm5WNGc4cWZx?=
 =?utf-8?B?NS9QZU9oVGwwKy9kU0pIKy90ODcwQTRqVUNrWXVyZGlJUkxaS0EydWVKSUFw?=
 =?utf-8?B?T0R5a3RxOUdYa3JmUEZ1M3Q4RmtTT2Fva2Q0ZldsNDNZOUV4Vy9WVUlqMC9Z?=
 =?utf-8?B?TUQ3cE9xaE41NHI5Z2dURVY3QVZGZnBySG1EYStMN2w3VndISlZiU3lBTjFr?=
 =?utf-8?B?TkxrSnlsTVZpREdFWlBGRFZqWVhVeXZvYUFQazE0TFk1bDJ5VmFWTEpabkgw?=
 =?utf-8?B?U1ZWWk5rcjNKZXZCZDRXeTUzaS85TDZsL2dNbGdUZzFnUzdWREN0NlVvNjl1?=
 =?utf-8?B?dmpaTGJ2amdHV2JKa29GQy9yVUVnNHNTRUoxREYxUElKMFlFTnN3NXlLcVhM?=
 =?utf-8?B?dlViT0tMWFZlRGxLSU5zcVNHNjVZd1NEMHhRK1gzUjl3VHExN1poVUtOUkNE?=
 =?utf-8?B?b1pablN1T3FKRkI4U3VhTTBiTHRZWndDZFdrY2RZc3pSVWRDajM1RWlYc0lh?=
 =?utf-8?B?S29uaC9Qd0FGbDQwY0VUdG5XWUU2WlVkdkFPcjcvcmE3Unl6L2JIWmR6UWpz?=
 =?utf-8?B?M09ld0JWNDV2c0Q5UGdGOEt1WEJhWGNFRUZ2SWt1UVg5Wjd5UVRSb2N2SEJu?=
 =?utf-8?B?MFZ5STE1d2ZaZGU2Zmttc1Z3UUR0TGdtb0k0d29WaDBTSWlkRGUydEVSSi9N?=
 =?utf-8?Q?yX5eVCraSVwP6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5wTVdESHVWaEp1UnZrTSt5UXdaMjVJeHMwYjQwRWVuaUxaMTVBVUxVUHdq?=
 =?utf-8?B?bkJ4NDhwZEUrUy9EZkk5WGRMR0g1Zy9FT2ovQXBVUXJGUTgveC9ENDZhdkxB?=
 =?utf-8?B?d2FGZFNCaHYzc0thQjFiUEpwR2E2cnBFMDFCWm5YYkRBMU1oOTNlam5nRHNj?=
 =?utf-8?B?SFlSaE45YWpnUVBJMTJRMXVRd0RXc3VoWFVLQmsvQjN6MUk3OXBNUjJsTVR6?=
 =?utf-8?B?ZnBjUEh0azZCLzBRV1REQlkyTXhzUFk3WWpsd2l5OFVyY0VEN0JBd3ZqWkoz?=
 =?utf-8?B?dVpQeXlHUWdmK3ZVSjk1NTZlQjB0RE1KNGR4Ymd5YnQxM3RqbDUvVFFUUGRO?=
 =?utf-8?B?M3pnQ3BORkVBZ3M0UkxYMkVLdWJFR1ZVUW5oWFBNWTJHUnp2aEcrcGtUbUdT?=
 =?utf-8?B?RGlncnJqVy92YkNuNDA0ak9pNzN1ZEd6ZjdQTHNRNEsvV0ZaLy9nM2ZCTzhj?=
 =?utf-8?B?M3FIZzlRQUNrUTRMWDVFSnlOYmRiZUV6VTVOQ3ExRVczeDZOQjlqTkNucEQ0?=
 =?utf-8?B?aTMvOEFlR0RJbG9yNlBaMkVwMFprUWpWdUg0VWVUTFhVbEJJN2pla0tDN3Yr?=
 =?utf-8?B?Z25Qb1ZIZitoWmhQbktwRjh3WGF6VFFiS0JjK1NxeHJkck9wczM3NG94VmJK?=
 =?utf-8?B?VWpjdktOTlhXcEZLVmp6ZXl2TlFmbHE4WmNlZHo4QU0rdEVaMWRqd2hRbkU3?=
 =?utf-8?B?OTk1V1JKN0oycjJ5YTVYZEowZVRiMkJ4WlRxUjlkeFNiVFRQVzEvdDRJQ0VD?=
 =?utf-8?B?MFM3TWpTMG5uK0Z6eTk0RVhreEZwbFBJT0dkYUdZODF5RHJMeFNXQTltRXR0?=
 =?utf-8?B?RncyOVNJQWVRZXFwQUR0NDR4b3JWVkFCWHNXaC9RY21ucko1bXpjWFlzemtP?=
 =?utf-8?B?MUZsc2RDREVxV0MydmZZeXlKTUlQQ2RuMTdpSTBpSGMvQkIzR2VwUUlTbm9Q?=
 =?utf-8?B?V2pzUkh4SGptMTFXUkRPd2QzMjJJQjEyR3VMYUxYcit2cVlnZjRDS0JBT2RN?=
 =?utf-8?B?SU9mT2ptWmt6SW9ydndoQ1lXM05QNmV6eFgrcktmT3BzUzJwWWZhdmVaOE9X?=
 =?utf-8?B?dWNoREt6ekZCbnlZdEdkOWRWR294djJ1MHRaTkxnb3FlVHE3WDFLbitDN2FJ?=
 =?utf-8?B?M2lLemxNZlp2Q1NTcWYvZnZCUkFnNys3Tm0yUXVqUlo5a2xKemF2RnpPM0xu?=
 =?utf-8?B?L2luanl4bjVoU0NTQ2NPaHJhWURkS1FrYnkvUTFCdmJDMHl6UFlNQjJ3UDJL?=
 =?utf-8?B?bzIrZDZFMU1MVGtTYVNGamRhYVJGL3N6Z1hNNEZhNHdQa2hwSWVTZ2F2VEJy?=
 =?utf-8?B?OGxPaGk1S3NZSHVoaFNsb1FxUTZDR0tQSlN3ckxqczRxdXEyQmdOTmJBQVdC?=
 =?utf-8?B?Rk1OT0pRaVZpcHZLQlFCTU9xcWJFL0tqNWFqMEtOSkZia3F6cGtyVU1WRnhw?=
 =?utf-8?B?d21keG1CMDJab0trcG5FVFJMR3ZTZVNKc3VwL0VjbFJwUGpocnZWL2tSeVor?=
 =?utf-8?B?bFpaNzlBMUdHeGEwTk9NdktBV3E3ZXlabTRVQVBPWndDUjEwSDA5RnoveGhU?=
 =?utf-8?B?NUp6VEx5ZjRDcW5rUy9BNHFhc2pKUmIzbFpFR1daUDkxcG83VlZleTcwQmV4?=
 =?utf-8?B?UWNNaWNVVkZUYWorV1djMCs2TGo4RFBjckk3bytRY21hUEc0N1VSQmVLVzM3?=
 =?utf-8?B?ajBFUkJwdXhvQzYyakpFMHJsV1F5R1MrU0tCNUJiS0MreWpQTTJGbG9CaS9M?=
 =?utf-8?B?VkRqcGZnemMvU0lBV3VQUVh0cmluMWdOa09IOS8xa1BUcDlTamRVWkVMS2xs?=
 =?utf-8?B?aTM0dEVNV29TdjB3OTUwZm1BSFB6ekxvcDhJeXJaS1VYMUdYS09pZWVCU3Fz?=
 =?utf-8?B?Yk8zcXBJR3ZmSTArdWNaMEVSMHhVSEFiS0dqS09rVHRINjZ2RFpJVW9TdnFK?=
 =?utf-8?B?NXpITTc1b2Q0a3BPQzNnUFNQeGlzZzRVVCsveXc4MXFhd2tPZHFBZkYwa3ds?=
 =?utf-8?B?WVpQWU5RemFQTWhPQm82cTUzQXY2MXdIdTYvbjJzUWNXKzR5MTY0OXR5NnAv?=
 =?utf-8?B?UWFMdnpGYlVxYTIrT2xUMlZjSkdaU2xPS2FySHRqY3NaNzlhMUlUdjJVOVo5?=
 =?utf-8?B?L3pMb2oxRjA5R2kzbVlmV3d6MFFyOCs4Sk05eTd5QjQ1YUxuZEpxWFFwS0Qy?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f2b5b-f947-4569-b158-08dd77efd481
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 05:23:30.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgYM5R+mfyMS9GDCgmcHqlVbNo9GWndhASEoMZhIZdXtYmTrYvkH4VELGja13phiPOK9TsCXLhpkihy1GZdV1xdzBVJXWZUv0bIsIMSK81E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com



On 4/8/2025 12:59 PM, Jakub Kicinski wrote:
> We mostly needed rtnl_lock in qstat to make sure the queue count
> is stable while we work. For "ops locked" drivers the instance
> lock protects the queue count, so we don't have to take rtnl_lock.
> 
> For currently ops-locked drivers: netdevsim and bnxt need
> the protection from netdev going down while we dump, which
> instance lock provides. gve doesn't care.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdevices.rst |  6 +++++
>  include/net/netdev_queues.h             |  4 +++-
>  net/core/netdev-genl.c                  | 29 +++++++++++++++----------
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index 7ae28c5fb835..0ccc7dcf4390 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -356,6 +356,12 @@ Similarly to ``ndos`` the instance lock is only held for select drivers.
>  For "ops locked" drivers all ethtool ops without exceptions should
>  be called under the instance lock.
>  
> +struct netdev_stat_ops
> +----------------------
> +
> +"qstat" ops are invoked under the instance lock for "ops locked" drivers,
> +and under rtnl_lock for all other drivers.
> +
>  struct net_shaper_ops
>  ---------------------
>  

What determines if a driver is "ops locked"? Is that defined above this
chunk in the doc? I see its when netdev_need_ops_lock() is set? Ok.
Sounds like it would be good to start migrating drivers over to this
locking paradigm over time.

> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 825141d675e5..ea709b59d827 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -85,9 +85,11 @@ struct netdev_queue_stats_tx {
>   * for some of the events is not maintained, and reliable "total" cannot
>   * be provided).
>   *
> + * Ops are called under the instance lock if netdev_need_ops_lock()
> + * returns true, otherwise under rtnl_lock.
>   * Device drivers can assume that when collecting total device stats,
>   * the @get_base_stats and subsequent per-queue calls are performed
> - * "atomically" (without releasing the rtnl_lock).
> + * "atomically" (without releasing the relevant lock).
>   *
>   * Device drivers are encouraged to reset the per-queue statistics when
>   * number of queues change. This is because the primary use case for
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 8c58261de969..b64c614a00c4 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -795,26 +795,31 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>  	if (info->attrs[NETDEV_A_QSTATS_IFINDEX])
>  		ifindex = nla_get_u32(info->attrs[NETDEV_A_QSTATS_IFINDEX]);
>  
> -	rtnl_lock();

We used to lock here..

>  	if (ifindex) {
> -		netdev = __dev_get_by_index(net, ifindex);
> -		if (netdev && netdev->stat_ops) {
> +		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
> +		if (!netdev) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
> +			return -ENODEV;
> +		}

I guess netdev_get_by_index_lock_ops_compat acquires the lock when it
returns success?

> +		if (netdev->stat_ops) {
>  			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
>  							    info, ctx);
>  		} else {
>  			NL_SET_BAD_ATTR(info->extack,
>  					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
> -			err = netdev ? -EOPNOTSUPP : -ENODEV;
> -		}
> -	} else {

But there's an else branch here so now I'm confused with how this
locking works.

> -		for_each_netdev_dump(net, netdev, ctx->ifindex) {
> -			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
> -							    info, ctx);
> -			if (err < 0)
> -				break;
> +			err = -EOPNOTSUPP;
>  		}
> +		netdev_unlock_ops_compat(netdev);

And we call netdev_unlock_ops_compat() here... but I don't see how this
branch acquired the lock?

> +		return err;
> +	}
> +
> +	for_each_netdev_lock_ops_compat_scoped(net, netdev, ctx->ifindex) {
> +		err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
> +						    info, ctx);
> +		if (err < 0)
> +			break;

This looks like its scope guarded so its fine.

>  	}
> -	rtnl_unlock();
>  

What am I missing?

