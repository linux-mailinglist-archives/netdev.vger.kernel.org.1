Return-Path: <netdev+bounces-270205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL+lL2SNvmmMSwMAu9opvQ
	(envelope-from <netdev+bounces-270205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:21:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0D2E544E
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79016300E25B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBD2D77F7;
	Sat, 21 Mar 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXpqD1Ul"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEA14A60F;
	Sat, 21 Mar 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095711; cv=fail; b=hPz4ZyMwIJxoz00s8U8Y5hC4Ce/z3uX+Z7GNCb0l9Y3+L/gLckVmg8a3bKMZsqs6I7PRRy7YMr4fEM3jT2d8L8hm0jLgLcqsyHcKb4VRBJHP/xUQ1lK1wuTJZ6JDv3dp542behcStfxt0wFY7/kN+m5TFjD/PZEfkrkrogJS5SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095711; c=relaxed/simple;
	bh=rKkN5lsZaS7oIiRcL/bXyJcr9haAawv2VVDJfwvL7/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBk+ANiXTE3XN9la4MvQYnFpjdpJWfuyu0FzyY2TQiT9jmpObrq/3fPbInNoQ8YY313DpFkrs0g+jbL5bIuwTNfvk4q4/ZWJ6oTlgp6i888AUH93pQT4VAF+AHZX6iYGY+Ujc///9CECTECdlVXPEV8rwfyXUZtRD3i68sjTjzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXpqD1Ul; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774095710; x=1805631710;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rKkN5lsZaS7oIiRcL/bXyJcr9haAawv2VVDJfwvL7/o=;
  b=TXpqD1Ulmk3BcKJJv9S3gICcdpB8OF+n7FfTQaxK9uaz38YU5mshIfjp
   cKzEXFDsuxWihMJSpD9qiMymdR4MKaDKz/rEH/Q+z94XO8engl2eeLJjs
   M5DUMfN14c8WEpyZ23KOURRUW3q+kZM+2m5Q64AE45JO2F0ZAnQ6neJJJ
   xN9LYtJYnkPfGvyob71Y/oTYCHaSMBk1QWsmSO9R8JivHCtFF7kyk1oLp
   mkuzR4vxVVkdf4pVVRWY45FdRxlzpK2SERWIj4bu3GyUA4DEvhEQHcbMw
   Ed8irrujIyUEhGn7g8LJSV07mUwE004189MMuLsKySLvl/yI8pcpORE4e
   w==;
X-CSE-ConnectionGUID: s4/sjUTiTGKMZCPRXXRw+Q==
X-CSE-MsgGUID: rCMYRQSYTD2JA0kbYDnWiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75134285"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75134285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 05:21:49 -0700
X-CSE-ConnectionGUID: IjIaK70jRiCrUxRMKK/BUQ==
X-CSE-MsgGUID: phM4o2VcQLW9GZqWZbbqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="218831090"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 05:21:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 21 Mar 2026 05:21:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 21 Mar 2026 05:21:48 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 21 Mar 2026 05:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcTcIYDDfYEC338yeV/E1yfFleV4HCiHVu4XXI1yeYfdHp5K09+w5vQFI7eOMff/Nz+WGycj6wzzFuXkHPj/fDTHJpbWrcNUbFGXL05Vt5o54RxbZ+esuCkRcL3stTcwM+3lemGnzpTS8H3c6o3TKft7Y0VLUTN2QVe3JMCWOp8CKf0Xfsnz1oWqAOSInZ7UsHlqYL9MW2hRJy6I9iN9mRSKxN1hhqtmfCTL/Yx8DZCIjjlEYNu7JxihQp2y9FgMZ5HXWYeWqfqRYuapEzpqc8trhWPu/3R1He/JuScWu8S2sQx/mw1jV6qdBY1YgRzBc9wMyHwdvtITy4f6dKyU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHDml27KD8fKgxce4BN4cC8Fha8J73D2XcfWzZ5+e9o=;
 b=RXopsDBs1xCtdJZAXsIpGVmcs8qquO012pM+e2eCDqGgJXumCdj3IIYy+VZ7p4Gqs6ygI9/mefnBsrmgN7QJL5k+NAvLfpQzmUvkEe995wNeTofBhtVNR8xjY4kaPfO+fPNR4qYk6Rgm7X1hLXGIz5NzuHQxymTFOLFVCHtAWq7woWannOT5sbkg77cKYyx1hdTUOdYBSg1EHe1rHyXsS6J4pFz/9IQPdj38oFs1co8qQl+n4e5oZcw1nC3hcru4nkwhGkovukNT1wi1Cekr4nBA8mn6RdHe6q775FzwBPTXz1XjrGlnssI+59HCJAb3iKUKwLQsCCgGHEQtw/HoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 12:21:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 12:21:43 +0000
Date: Sat, 21 Mar 2026 13:21:32 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2 net 5/8] xsk: validate MTU against usable frame size
 on bind
Message-ID: <ab6NTLRYG4LgqQn6@boxer>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-6-maciej.fijalkowski@intel.com>
 <87qzpeopzr.fsf@all.your.base.are.belong.to.us>
 <ab1s9J5yGxCbqB28@boxer>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab1s9J5yGxCbqB28@boxer>
X-ClientProxiedBy: VI1PR0102CA0091.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::32) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff02c35-2812-45cb-84c0-08de87446994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xq/3PEOPfRW/Wji17VZnfhJvdd4JmEPo6iww38GGaq2PA/Xz1tO0PB2F/B/B1U/ZDnJvNXFkHgdkMESVKat1wbzCMDkhDo5kOq4C7IF7hqcYplTQHbBp9kyy0WisdUu2Xupn4JrsrYzAFroa8b1hjuLEsLkcNEFj7C7j1pk2ntr0i2UhCz9lbJrBtHN8gsdwFn43GG/KVqVIfENzyk5NacjcbQzRhjTbOWN4P6ZWpwL3w/ibepag2PUHptaNc3MYU7CUmjLUv1IOT0HXrN037Id6hgwDWy7gZEE5WDRMBYYMbZ4YKQeM521Gx10UxXspLhsa+9EBkGsM7DcnX60PVr5qJLP6qYCLO9M7FVk9HLqQNjubYiFOEC1Wjt9trh3LdJ/CbDiualCs7apxmOe2HUlCvACeR3HAlUt7+Q+xN5B6UbrRmnw37zucOOBwgImHZpJGnfsBoGBYT0Gp2jSaQ1X5T+HhuXdPqX2U+V/fmthVJlAWfkByPyCjJnR0LU+2D8qYfatH5YVQFfreTe4EYunUizz/aWu/6YPmVLw6eR69gqKUuf2xjbKuJVLbIaFO9CuwuSXBhi1qbdyb3DRpZTt1uavmIk0SO9STa2HYPwKtxDfQB80c798QCha+24Lpsx3G0JQh3TLyFjQ0vCnyq5zIitFoCts+7SE+bcSxbqkFeQpCFO1vAEFmC3e3w1PPLfj7XWbCVJO2n1RVEI0IIXzwQFxSA2vR+PmtPJXlktM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xZZe4ygxg1mXCMq27B961ivegvhbx7vcXIoBuwnjzgAzprtfumlR09AoG/?=
 =?iso-8859-1?Q?iSoGBrSAQpjtv41mzwOezYq8QeO6KzAcuPGSK0HhwKnl1Xrhnbgx/6G3fe?=
 =?iso-8859-1?Q?TYaJWvkHpNidMSbRBauDj2OA6u44DcCWjnoD5uKxPItpubGInwX892ycCM?=
 =?iso-8859-1?Q?gHCDs7yis2regr5eIpr0s6zkb6c30h1RqYfZXpiHO+7XqJkIV8S1hv0wDX?=
 =?iso-8859-1?Q?G+3HIghj4NdTnLgxKMt0GxVK8MyDiUe68i2jKrwiYw6LWa23sSH/+w4/UC?=
 =?iso-8859-1?Q?QJYhTdvXa0DtB3fk5Tox9z8heq2WhXbLMNa09HJi/t+fbOWgFGQVDqwyhn?=
 =?iso-8859-1?Q?h3Ldyhg3oxgez2EKihoUDLguyDu8dCOCCX1LbShsKTTBgOyciCDBqwQcmH?=
 =?iso-8859-1?Q?jxtv81oZIr4zKPENajp8urX7bv/EeI4gx1kSm5DUK1QX3mr7R0wJ5sXvjr?=
 =?iso-8859-1?Q?By0MCorEGHqy/VRrtOEyVWEk8f34p+UCpXEzs+Nbva0qrujY/lN1B3PAAD?=
 =?iso-8859-1?Q?wmg/mcSDV/4BhcfPEvplp/DLhUd13O7zf/JeNRMu6YUmBR6xAEJemdxIAH?=
 =?iso-8859-1?Q?lhGDc/T3Y0pjCouPAGCpytsej149XSAvrqhv8YBG59mRz0CzVfUzqAqWN+?=
 =?iso-8859-1?Q?GcemjTz15WH4pX0z+gua7ARjXo4MU+CkK81afIe8IZ0I3j9kLpxC+le5Vt?=
 =?iso-8859-1?Q?y60RML8EnIFM8WcRX+UUT9+JD8hbP5GKgjC4XoN7zfTwJzc9FMNy4IXW1m?=
 =?iso-8859-1?Q?lMlkTh/lXGSeFbjmBwBrOWZB6fSqk8I3kvN3sW4qYD+bdhsf8MZQVsrfmB?=
 =?iso-8859-1?Q?PvxmEKDt6GQM0jmDH/IRRRXRe+rkRCRcRZK0hfYsKBbLcDDCKW/V+GDr/o?=
 =?iso-8859-1?Q?Gxhtv8ZLLxxT6uQG77VRgz7NwS42tqxiRpD3GU2Apu8GvjNHbK73Lf1/5B?=
 =?iso-8859-1?Q?RXxcpQBq3Sy8a2+KvpmvFVf/T32MXwWp8Nye/HgkZt1BgJl9gFZEuW/267?=
 =?iso-8859-1?Q?TcIjLgsTiJotWp213ZRPvCB0V6PXA+hPNTsu8jej2fQPSmAhy5atU+yzcP?=
 =?iso-8859-1?Q?OZ5VGgPPhNwIjdGzxZ/6wH23N3IvDFZDYiq+nDerqFPAXO/8v0DLT0NQj7?=
 =?iso-8859-1?Q?iGwFPMWtS4tIBykPYvjkC1UzatnrJiduhzOoisJ7GcKjAoq2RrhcbTo/wx?=
 =?iso-8859-1?Q?92zfHcJRxB1BFSvLf80ekH4jydOI5TmbOhK6wa3fqo1Ys5WhUO+RGoaK83?=
 =?iso-8859-1?Q?P58YQ3/zVMV34IPU6mztut1/TeD3NoaL3NrgAHr9bVTB1uVg9ILhSlOCrr?=
 =?iso-8859-1?Q?Cu6SiVlr/oud2uH9jW+RvKoMtBXS/PmYxOmS2PHnB2gB8k9iMrDy8lUgJw?=
 =?iso-8859-1?Q?ImJiHArjIEU1UCdwMQ27JW+di7ntt6ThX21z8+6N2vjbjc10QJ9PWMYO6K?=
 =?iso-8859-1?Q?wIduEdmng8a13QjlRAcNF55nEz5BABaLgYjvMSB7NttXnmoo/TqIM3IRE9?=
 =?iso-8859-1?Q?IQn3zaOG6zxMYjPsTC2eqfNJIIfRDAb26mD5QWdDN15JT2zrTphbX+GVf8?=
 =?iso-8859-1?Q?0KQ8Ap+tbUqOUt9oLed1I7c9ayRtyBAKJ5W1hQZQ3zObyEwHFv+KIR0ilI?=
 =?iso-8859-1?Q?6nwrMhZhOOJKw5/JS+y2XMiHVMNzy1vQJicTJd1c5uRueiJhKQa6u1TL6O?=
 =?iso-8859-1?Q?vczuliBabiu524AhXscbrndldfa0MzfbmwMyMyN9Mlt5wyyRoNpJrsCsGl?=
 =?iso-8859-1?Q?BdQKo4NPkYUdyWTerNcj+G/QeV9Z/3pFH3M7idtTESrDCKDVk75G8trgKb?=
 =?iso-8859-1?Q?VMEmAxwxeMTZEmmtdq22PPMVgCibzlU=3D?=
X-Exchange-RoutingPolicyChecked: sQ4Lgl8vRWt2EZJQVjllCTafj7zljCnFkSN25i31/qdCYRNx28q2QGKFVMJGatpwCRJ5ak6lBvEsfIjPUi6saD6VqCeJ7mFoYjv9qQHAxeO8jMJt3pd1m/ip2+MVpGaowRcrjlAGbY/l9ChEhiZdOaYgeE0uL24vJ/yrIG6DDzNEkdlqJ7y9YEtzb9Boi9d2FY8q2MGcRXcXtQ5M3VGbEDjkPHqB6y6geSV+d1cXXGaB8TOVunpXMvvcwqAFlXpzQGV8SmO6IIWQM83iQ1r4WpYOM5ZuShdetJD7vUHkHa4LLoKLsq0Ss17kTehYb0vuX6ISOcPOV8Cfzo2S+WhjlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff02c35-2812-45cb-84c0-08de87446994
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 12:21:43.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udVszTML1UMiK8WhwJhUhnphuy5gTTtir39EHi9ypzDudF8vupOzjhnqL7dI8/1UIHra4lNIZRQjbqQtizy8LSXcOqVFNYcZwR+3FWPAJCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-270205-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E4F0D2E544E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:51:16PM +0100, Maciej Fijalkowski wrote:
> On Fri, Mar 20, 2026 at 09:38:00AM +0100, Björn Töpel wrote:
> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> > 

[...]

> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 37b7a68b89b3..e9377b05118b 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
> > >  int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  		  struct net_device *netdev, u16 queue_id, u16 flags)
> > >  {
> > > +	bool mbuf = flags & XDP_USE_SG;
> > >  	bool force_zc, force_copy;
> > >  	struct netdev_bpf bpf;
> > >  	int err = 0;
> > > @@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  	if (err)
> > >  		return err;
> > >  
> > > -	if (flags & XDP_USE_SG)
> > > +	if (mbuf)
> > >  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
> > >  
> > >  	if (flags & XDP_USE_NEED_WAKEUP)
> > > @@ -200,10 +201,18 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  		goto err_unreg_pool;
> > >  	}
> > >  
> > > -	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
> > > +	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
> > >  		err = -EOPNOTSUPP;
> > >  		goto err_unreg_pool;
> > >  	}
> > > +#define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
> > 
> > Yuk! Move this somewhere else.

Forgot to respond here. I'm gonna just place it at the top of the file but
to properly address this we could introduce a common define for this
calculation, since we define it already three times, at least from intel
source code PoV + i assume i could easily dig up more open-coded examples:

drivers/net/ethernet/intel/ice/ice_txrx.h:73
#define ICE_ETH_PKT_HDR_PAD	(ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))

drivers/net/ethernet/intel/i40e/i40e_txrx.h:115
#define I40E_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))

include/net/libeth/rx.h:21
#define LIBETH_RX_LL_LEN	(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)

But such refactor is obviously a -next material.

[...]

