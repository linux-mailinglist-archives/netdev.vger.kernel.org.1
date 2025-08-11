Return-Path: <netdev+bounces-212617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A2B2177F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA893A3A86
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872D2D481F;
	Mon, 11 Aug 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gf2bFL2V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A0214A78
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948200; cv=fail; b=bcAap4+4+FtiKXhs/Dd73PgszfhpYV41Sg3ljINbvCICkpGvP2SdKWwgR2eA61quAFP8BtMS8GLJg76lmOrLEl9F2au4j5P0wTqNAT/5IGoGD0OnAH2MiWFEHS9yJ1QZS+yTZI0xuoAeOsO9Koui2hXdUD3clKbXEiVFOTfy1Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948200; c=relaxed/simple;
	bh=+/nG5tPbWGciX3k5ySeHTrd/o7MufbkwP3YEd8Ng/x0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcFJggCE5ituj8qfVqwYqAIwaTu21tDp5cQtNOp4hHu3wCakBv6c/7ZzWT87BHI/to3cJwz1qKpll6YdAlQ8Um4mjoOdLk3gNOj3J7JKIiwNXFRTOCZ0MQ7+oJpmRcELEkcSqSPq9mw9ENam0n3gGsVTgHXEsx0+FvgoEaDd8no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gf2bFL2V; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754948200; x=1786484200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=+/nG5tPbWGciX3k5ySeHTrd/o7MufbkwP3YEd8Ng/x0=;
  b=gf2bFL2V26LgrV65dSmd9CSOtUMHK2zN5jEfdEdaQZV7ulY4d9aczNeT
   cWrxLsvxziYUs1MPYujUupol095+1zdC/wbhWieMmKQ3XmP1cazboAirI
   N+lWlNYnR0Lg7w8jIuyaxS0BH1DwNgoIwFh9je/eoYqV1qmmQp9NK8zuV
   fibS0E6jupRbeRi0ir9dlrXrEGPLcG/Bm5df1Qo8sxpoVnHIOUDUUiawj
   hKotfN+k+7GFYwYtc2kf4y18YSZYPWTehLzM8eevZf/0lNy6kO6YByEC5
   bUXOVFIg+acdunsO/KgtkIJoWZXztgh9UQW+TKy6pomuGCeSPtsb1yBBF
   A==;
X-CSE-ConnectionGUID: 2V7Pq/QjQpu9lc3WPmiSvA==
X-CSE-MsgGUID: s1DOWtR+T/69x1hAZyyOeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79782348"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="asc'?scan'208";a="79782348"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:34:03 -0700
X-CSE-ConnectionGUID: N1nJJ6XnSc2tOjB+QD/r3A==
X-CSE-MsgGUID: WpMW4ahWSrCa23SlAfk6qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="asc'?scan'208";a="170463330"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:34:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:34:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:34:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCBHHP3gGvn+fo3URamZV0397SGZOqx19fHHHChruL62t6/wjWDvX8Y7OTPdYVG2t1tjLYJNVQk1bdAEtgQLNL3n5+1f+O0kXvMDAn8uyICEcTsUmBgVj1Xu8dhFf4oSypZ16XYw8eTtVANwM0u4b7leBqqC5Zb9MIYErXb6iuvRE2leJ/NWJeLmC03R1GLEaruuKvGEBxRsw2OpBLW5VrUurqfEvNw/XcYfwL8gt2qQKvI1O3kPIIcyxxy5zJZNsqQ3fgfunS5gyBtWrqY/Kt6EaEBQT+yhOSCdRHP6ZMGcOZTu1RLC4nhqKnD5VJJHueNB6Pdln4leB7opLVUqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAyaG7DynTyPmSQMa/wZRU1je0QgV4u071fOsGotki0=;
 b=ErTOyuPam2SKvdItsqmrnkdUYpNlTaKj+OwjhhtRRnDIvSaN4eDs8SdeL8j/JHGu0+36xCenQDBUE63WOmkgho3IFWpamrtyKXUeESztqH5ufiD+aFfCREhIZJRzUzWr9iP/izI0mtMwmNZVwuvvli1LsCWm8Mcm2YZyU4tgH/0eBseHcklrZj5nXmhUHxV1ctHeC7dWqv2reWv0UujVm/MXQO0IDy4hzthlHwxyqgkXgy5Ky32gCbmS+CxDhAEzbv33D83r606UAOEPAxW61MTP2GzOscyCZsx4GW0waEKcKNfuKyS+PIGNo5anju243qXoqei2mdvOPaaZD1o1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPF9EFFC957B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 21:32:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:32:30 +0000
Message-ID: <fee09923-c46c-4c39-8f27-ee720b604e56@intel.com>
Date: Mon, 11 Aug 2025 14:32:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <David.Kaplan@amd.com>,
	<dhowells@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
 <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
 <20250808115338.044a5fc8@kernel.org>
 <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------v0OUBokrWi0bPUWkKuLXmcmJ"
X-ClientProxiedBy: MW4PR04CA0384.namprd04.prod.outlook.com
 (2603:10b6:303:81::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPF9EFFC957B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b767d3f-0413-402e-e38b-08ddd91e93bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L21BTGtkWEJlenFWald6d0dyQU4rSXUxekJ2VjY2azZHUXVQWnJKby8rVDJB?=
 =?utf-8?B?dEJ6UktFY1JTTi9XVmN3RzF2Q2E3cGs0RXNIT2UrVGtxYUV2ZVo5VUVnZzFl?=
 =?utf-8?B?NmloS3BFckF5OWRjR1JlQW1wV2Nlcm5FNWo1MWh3d3JpM2xXTWl4MDZHRzVy?=
 =?utf-8?B?Zy9kM3ZINHlXSnYrU3hIZGRNTmNIR1QrOWFjVHlFUmdhSzhWYm92Ny9TZGpv?=
 =?utf-8?B?WTlnUHNneWplVGRBczZFUXE0TEJxdWxiU1c5Z2hlOVZZd25UbVYxa0FFanpG?=
 =?utf-8?B?ZUpPaXBDSTUvYmN3VmRqMkZFQzBKVE1GM3dVVjBmeGtUWDQ1ZEJBVXJKMndD?=
 =?utf-8?B?VjBGSThOSUFwOWlrMzhHQWlDRG9iUjVuR0dkbnBQTHVWa00rbVBLeEtnTFhy?=
 =?utf-8?B?dTdqL2gvUzJCaEZsREVvNHJJVDRWSzVQVGlFZEQ2cDFLZ0oyb0wxbFR2M09o?=
 =?utf-8?B?UW82RkJLVDFGcm1zcVZMNjNmMXBRNWVwaWRRTnN3OXZhOWhvMU9sdS9CY21z?=
 =?utf-8?B?cDNaTEhKMVYzVFNadXdLOWdJVFBvWFhMbFBUYWNqM3JGc3U3VmZSdGNFY2xv?=
 =?utf-8?B?S0krZXhJUzBRVDJZb2pQZm9xTXduWnc4eCswdG5LK0I5TGlKQUhjS3dpbFVs?=
 =?utf-8?B?Q1diNndyZGc2RUY0bVh3Y3RHWnU3SFZnYTZMUnFhWDlDeUdCZUZLVTJxZXdY?=
 =?utf-8?B?OFdPSHdSQkVqbWF5NC9mb0NHbGpEaWFHb1VIMzZieG1pU1I3Y2tiNUloY05m?=
 =?utf-8?B?Rmttb05IRmZLOTBWTzhXcWF4RHpZOHVNKysrYWlyaGVVelpINHhmQlZQUm1n?=
 =?utf-8?B?ampyK2gvZ0dnNVVHeUFlQmlvdnEyNmpWODRQVXJPWXRqSFo3SzJNVXNFSVBR?=
 =?utf-8?B?VXh4am1GVkJzRHZjeEJ0N05CV2dWREVxaFZuNmhzbkJaMTdWeHVYTnNoaHVT?=
 =?utf-8?B?ZS8yM0ZuZ1VhZCswU0hGeE9mYXlIS04wV0ZkTVRVcEV2MUpteFdDTHFiUnlI?=
 =?utf-8?B?NWlRL3VFbEFLQWxwNmhKbklPSGZFRFdCcyt4eTdpM2d2TFpkSEZpdXdLcmhG?=
 =?utf-8?B?aXRTa0s3Rm0vVHdaUWowVVIyTVlnT0M1S1FISnpGbk9QYVVPQ0MwcVEzc1hK?=
 =?utf-8?B?a1UzRkdoWGtLdmxiQXZjb3VaQ3BIR0x2a2FPVTFkTjhtRHZrVWdJTVRTeEt3?=
 =?utf-8?B?RTdRSlh6YVpMZDFUb2FBK1RpZDVrdDQyUkVLVG5LYmE1ZkpXZk5xcE5mL2Zx?=
 =?utf-8?B?VDBMSzQ2ek5JMWZEejBMMDFmRXNnb1lMaDQvTnJJc2tybzFadFJlZDB2M2hw?=
 =?utf-8?B?bzVBRzI4dFB3bVlpc0JKZk5aSyt1ck5jMzA0NkV6VEZuM29VNjhZOGtxTGtp?=
 =?utf-8?B?YUJoNUZ0dkd0ZEIrU3FtTGlIb3N3YVRGZGJKNUFTa0JnY0pWcE51aDlBTGhM?=
 =?utf-8?B?LzArZ0I4YUx0UWVqRXJxRmk3UmhPdTRNV2QrQXZGUC9YcWhRampoeXFCNzE1?=
 =?utf-8?B?RWw3c1lqemNwRnk1VHhZcFEyZ1pHL0pEMlNYNnFPRVJ2SXdhVEdjS2txa3VG?=
 =?utf-8?B?aVBjdTRnS1FtcXVTY3VPcmMzbEhOeURnVWhicExyZnd3dWNoWXlSYnpMSXJO?=
 =?utf-8?B?dlVHanRPMG5MNytDQ0ttbU5aLzhSeVc4K3ZMQkVCQ1JxRVlIekFjeEpwc0xR?=
 =?utf-8?B?YXorUS80VStvam5zVFpROExPRVNNT0JiYlJqdkFOYUdDM0NZNHk2M2psLzdo?=
 =?utf-8?B?RUloYkhDM25NREVvbHF3RzJEVGdtb0t1dVROcDU0eE1ZSEs3UmtXcHFQaGlL?=
 =?utf-8?B?d2tGdGc5QWxzRGlSRTFhL0w1VU1Takl1bVRLUUxPVXM2NDl6Wm9hSFhTajQ5?=
 =?utf-8?B?VzdoUEpseUwxSFcxRGR3NzNVbFhSSEwrUVo5aTkxckNFLzdOVDdPYnV0cFE5?=
 =?utf-8?Q?HNZbZZmmi30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnByK0VjN01lb0pzS09BMkZrbG00Y29pYTlvbHBVRzE4Y2xUUmVKeWFTU3Rw?=
 =?utf-8?B?OU9pN0k3azNzSmc1Zm1naXpYangrb2tid1FDaWlHUit2RHJxRW9rQ2FJeDZ5?=
 =?utf-8?B?Wmc0WVY0L1dWNS8xcGI4T3JtNXZUcks1TWVsa2RKUzV3NFNKQW9uQkdIRnR0?=
 =?utf-8?B?clpqS2RYK3Zxb0sxWUdVYkdQeWdJNVYrdW4raFNGZmU1blZXaGhRb3BpNmZE?=
 =?utf-8?B?WUlXUFE3enJYaUFIODJqd1gvcEkrYjlFRkdEZzJxZlN5OVdDcjR5ZTFhVXRS?=
 =?utf-8?B?N1Zsb1poZ3ltZDAzNS9EdWpHSVJmbDdPZEppMjNjekVWM3NNODdFWWlsYVpF?=
 =?utf-8?B?d1NrYjBjL3FjOVJIM1Rwd21HUkdmMGRGNjJSVmFjaWNJbkZ4aHVsamhXWGVG?=
 =?utf-8?B?K2F5OHhvUXFOdk1vblNPY1l0SG1pR1RZcDZ0ODdGNThrcEtGbGdQc0x5Mmc1?=
 =?utf-8?B?d0lYYVRqcURISmpNRHlWUXVJc2NkNzhYdld5d0ZHR1J1QWo0d0IzTFJTc1BR?=
 =?utf-8?B?N3R6S1o4RVgyZlFvZ1N6NjZhUG40ZXZXb1R3aks5VkdJdWpCMGpxc3M3Y0li?=
 =?utf-8?B?anFYdzBad3BHVHRQWmFBeGNXVUYvRkVrLzZJU3BOVGhib2dqUUJjQ0cxeCs5?=
 =?utf-8?B?bEdjWTBkL0dVeUJGd1RTV3NNNTVpSXVBaUl1aUFRb3ZSanJVdkNxWFozTnJi?=
 =?utf-8?B?OXlRV2lFU0pFMlo4Ujl1SlVaTkZRRFdsNlFIZnRxNy9lZk1XZmI0WU5WeFpt?=
 =?utf-8?B?Q0t2bnlTYUc2SVJHRjM1RzhWUUtHbjg5SFIzUDIzTk9oNnJIbVp0ZnJMU29i?=
 =?utf-8?B?bUp5aHRuTDFSU3ZOeGs4RHNLWXIrTHJobWZ2MHhLOUpPZkVTQ2F5bGN0VHVM?=
 =?utf-8?B?bzh0ZVlMOUVlejBpM1BqM3IrNmg0T2svTzFCRGs1bTJQYVdtblhxbGxDeElW?=
 =?utf-8?B?VXJEdGVFZjJaZUhydWRUd0dxNEVxcXBSV2NMUDc3THFZcllLZ3VmR0l0SlRh?=
 =?utf-8?B?c3VodVZIMmQwdCtMU2NqcDNSaHBsaWg5WWxGNUhtZE93UFhnbW04YUt3OGRW?=
 =?utf-8?B?M0VscjhLZ1ZkWU54a1l6Z1ZkZmsyNElnaGN1MzNaTDgzSlM0T2xXNll4a0F4?=
 =?utf-8?B?WVZNRURVRG9jSW9mYk5OZkxxbzR0emQyaFZlKzFsdlBPQUliR1kvaEF2YVU5?=
 =?utf-8?B?TXZWRmpWdlliMUxJajg4K1ZkUDA2dDF2czNTYUdLUkpxL2dTVjJQZDdiZmVJ?=
 =?utf-8?B?RnJsTmRXOWM5R3B3UGlycmVjbEdrdytpOTFsQm1samFMZS9OMVcrd1lTWTY0?=
 =?utf-8?B?U292THp0ZTBQU25JZjZaclFFREpYVXhXT0I4T0Rvc251bDh3U1A0d2EzOWZm?=
 =?utf-8?B?cXdMaDZQNk42NFRSRG5pK2NQTkV2a3MwWGdKME10b3g1S3Jlc2VacGNMNkdG?=
 =?utf-8?B?WFE5eEFjbmNNMWZtUFEySnBCYThFN3FEbHdiOG5jSy9FOElIZFo1S2dzSDZh?=
 =?utf-8?B?Zjc3bXBWWW1yOXhXakpXeVpCOEFuMjdERVNyMWdQZ2VtTEd1NVRacHJSWk5z?=
 =?utf-8?B?blhzT1cyRGtJaFRrTWNuZWVzOTYvME9adklKRnZmcjBUT2hiNmMyZ09DMXZ5?=
 =?utf-8?B?dWFjZmJMcEo2YVJDUlpmeFh1WnloR09JYXk3YXRYMmxjMm5UYk1WWW5tR3pK?=
 =?utf-8?B?amtyQ1NCZHZwNmp2bzJYSTdWNDc3eU5wMU9aRTlGWjdRWmFmWU14NGpvcjVw?=
 =?utf-8?B?ZWx6RTZXR0JaVjdVNGM5czZLMUxpUEhLRFRwSStHc1NGMmw3UHdHMHZJVHBM?=
 =?utf-8?B?MlhEOUNTV3hEMnJUcGpNbjY5Mys2WVVPZ3ZHSWtPOFd5S1BrUDd3RG5SRFZh?=
 =?utf-8?B?OWsrNGVpTmRyMWQyTnBXbTdGVUw0bjh1VlFSQW5FRHVUSU5rZkxyQVc4dXZV?=
 =?utf-8?B?Vkh0MkZ2YlBVc3Ric0tBK0VsWHM4Sk1VdWt1SGNBaU1ZYU9LbkRNS0tMaGFy?=
 =?utf-8?B?eDd5WTNZV2d4Q2RmY1U2UTgzdUV5ZnFLZXc3VitxQnB2ZGsvQXNxUnhMNmZw?=
 =?utf-8?B?RFlnazVpNldYeTA2eFVhdjZmc3RjOTdYQmtzN1YraDkwUU1aZ2owWUhaRmpu?=
 =?utf-8?B?akxkUUZ6S3JqTjNJZkhnemlEdUh1ZXUwNE1CTHdTdFZPWmZ4VmVhQlBTdXBE?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b767d3f-0413-402e-e38b-08ddd91e93bb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:32:30.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIlW5y0PqNAfPkVM6fDI1CSsyvvKEH+YTRyeEdpm7dL/NCQHt8A63sQXXElcMkc9fAyU5vw0AnlskYvSPAyGBvgqabrWFlH3K4Z0MZ6h8zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9EFFC957B
X-OriginatorOrg: intel.com

--------------v0OUBokrWi0bPUWkKuLXmcmJ
Content-Type: multipart/mixed; boundary="------------UIBbYilETHfNgugx3465c00V";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
 David.Kaplan@amd.com, dhowells@redhat.com,
 Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <fee09923-c46c-4c39-8f27-ee720b604e56@intel.com>
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
 <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
 <20250808115338.044a5fc8@kernel.org>
 <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
In-Reply-To: <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>

--------------UIBbYilETHfNgugx3465c00V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/11/2025 2:27 PM, Tony Nguyen wrote:
>=20
>=20
> On 8/8/2025 11:53 AM, Jakub Kicinski wrote:
>> On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
>>> +	if (devlink_port->attrs.no_phys_port_name)
>>> +		return 0;
>>
>> Why are you returning 0 rather than -EOPNOTSUPP?
>> Driver which doesn't implement phys_port_name would normally return
>> -EOPNOTSUPP when user tries to read the sysfs file.
>=20
> Jedrek is out so I'm not sure the reason, but it does seem
> -EOPNOTSUPP would be more appropriate so I'll make that change.
>=20
> Thanks,
> Tony

I agree, -EOPNOTSUPP makes the most sense here. It aligns with the way
we return -EOPNOTSUPP when attributes for the port aren't set.

--------------UIBbYilETHfNgugx3465c00V--

--------------v0OUBokrWi0bPUWkKuLXmcmJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJphbAUDAAAAAAAKCRBqll0+bw8o6LZw
AQCqwWA/x6uUknitfiMBT3ZZTfjv/2zaWluUgJIQnL8s0gD/RRvRxTI6vWttDXxh0lem9ujKzhoC
nYZMbt0Gh8zQdw4=
=uOir
-----END PGP SIGNATURE-----

--------------v0OUBokrWi0bPUWkKuLXmcmJ--

