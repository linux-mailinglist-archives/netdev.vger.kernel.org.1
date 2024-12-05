Return-Path: <netdev+bounces-149516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E89E600D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 22:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E472844AA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB21BE23F;
	Thu,  5 Dec 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byNXYkTd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009F192D69
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434002; cv=fail; b=HiSakQVq1UglTVaxQdo/5200zQ3NQWAFKatradifu/K88mwU9qgH3iyZk68nPWPnb1FHTGw0qCVGLqzx4eK9f35K+bLDlfP+DR8SKwZEg4KxzZf9NdS++txXP/AAcvjingaYDJf4IHla7xQ0amPp7VICztbqLEKurIdemlS5/Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434002; c=relaxed/simple;
	bh=Snmedi0nL/UND7vttAFQaKBnJe710LOttcRmnYHi9+U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vgpit4+BTpnPYT7INN0GQjwNq9oJTseLmHZj96QTp5YfW4WHFIL30pD59ZfTHlFWDpz9g79qwcyuoQJOnQQMhUkWlTcfd4Me6uum9S45VKeFmqHdeCLhATcUD+zY4SaYmrfH+bvO7ChuJ+PY5/iEpk46FAiPlVxjEUhCjl8XITk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byNXYkTd; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733434001; x=1764970001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Snmedi0nL/UND7vttAFQaKBnJe710LOttcRmnYHi9+U=;
  b=byNXYkTd/lc/IsiSF3ORc8Ft6bOkSQP37XvChJCRbGuRcuFhYUZpT2Uy
   SgNrgl4wFm2FcoCRzeLYEVEMPphg3rQSDoG7rbCcTvEH0GVHYNZd9o1MH
   8gxO5MX9WbHZHDefe1MBDVPOMTKKqEM8nCj9BNHJID88jTnjPhrt4MLuu
   ytwowlj8lC2NBsbSE8d80JORPD2BSzUHGrR8GvxBl9UkMD2P/nArG+gez
   HBJdHAAQ9nlBA1QfelCo+jjcoHN1zxGoO3UntMI6bcsLJWei6HR8yfLiH
   1uv9tibcs+9CRJPVtRzXd3fnxK0LW132uXIm65ekxc9a6eejXdU4B9oIU
   A==;
X-CSE-ConnectionGUID: EpkKTHKMSaWxnqUKMEPGtw==
X-CSE-MsgGUID: VodhEoRYQviB5skUJNbTrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="36608869"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="36608869"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 13:26:40 -0800
X-CSE-ConnectionGUID: tuGpyTpMQLiolsIcEd9CHA==
X-CSE-MsgGUID: utjGRdo5RBaufDLL1rARNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="98287211"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 13:26:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 13:26:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 13:26:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 13:26:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3ExWHBi3xISuy/5v9fVcdGNDB1qA8kKQ+DkzwR/c0jcLp8Sz9bq6EDJWyvQp3ndWqO0gnu1yV3xOKL7chebBqqMmpmfFQLdfOlfMYO2W8AlbeqI4/mCBsXvtxu/DtFKuSrI8FQHa7JlSCm/dIU+/CKvGQZPnY0Km3VdTbo5Xi3HwMACJ9uQfsydcjt0NB5Q7KoTeXjJSITGbV5+vFfhuPZbNT2Sm/Qo8SjtX1d4M+MdHdN1XGsOGI7+ZJBYBZoTexjcYWIUBmYaM0cfk5QApqhzLy7N7mntuwMV+IY32fs2EgkADYFsFc59KGXgiQurcBEC66r1E4ikEY1Wyy0xOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHmLuFOYNCs1Jylfup1OAW2hn00qUjQq4Iu95Xt0cac=;
 b=SYVXrLH1HX0fXIum1YWLcDCfUX7sclh3WXX1/wnbheDIkgGzSw4YbChd0idO1KixUBn9sRimuBaR+DU6ADIXQ1o1No2tQphaC6aLvv5dmCy/cqWdpt/AXxYBrNnPsmR1JL/gfYl0p937WdmKTcYLkOlln97GzIarIM3NbL43T3qfqVOU3zJEFaqNhBJ1iR5N5Ul3wynVPrTWy62ntxJS0J5YPxh+FhvGk/1c1tyZKo7uT83CP5zs7lvL0BEGYMQjybnFB4USn8nZRcesvo8013QZPSgopCjUAE7ogCg3kNntZzPmy+U+sJ5XDP00FZiMx2KSMEIeb7TEysAWFExuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 21:26:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 21:26:30 +0000
Message-ID: <c4ab4238-1494-4c42-8650-6662eafd1b3b@intel.com>
Date: Thu, 5 Dec 2024 13:26:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Masahiro
 Yamada" <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
 <4c0cf560-e18f-4980-918e-8a322afd866e@intel.com>
 <20241205095221.ivb3gnrhkfdyulxy@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241205095221.ivb3gnrhkfdyulxy@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dd473e-02a1-4f63-2098-08dd15737bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czBlWnVMZUdOeTVjVWVOZFZZK2p0b2FEbXNoc3UvbkIwUG9nVUsvcEVyTXQv?=
 =?utf-8?B?RkQzcGwrRjRXb09CMW9SYllaa0FDYWMxR3pLeDFtejFob05ObTJ6OGtmZmRB?=
 =?utf-8?B?K1o1SmpMRmswUkxaZWdUdVlxbzVmOG1BYlpiL2YrdXZpc3daZEN4SWE3RHhD?=
 =?utf-8?B?U096aHJ4c0ZJTThnVXVUZ0lFSzh2QXROczMvdDgyVnNzOWUzUTc1cGhsNVd0?=
 =?utf-8?B?UExucGZNbG05d3JzWUhkNEJOdHd3NUV0aDJMdjh3OVFoSUhpUnptU3VDYmph?=
 =?utf-8?B?eE9Pc3lCYi8rK2VJSy9QUGR6TS9FWnFZSWVuUE9odUt4OUwwOGlNQUpuQ05l?=
 =?utf-8?B?dTRpdXFvQVZzYXQ0L3JPTE9XcjEwMkh3QkJsTVNSQ2poRUZMWVE2RkdDRVhR?=
 =?utf-8?B?UWk2MC8vNWJTTUFPY28xSVprVzkxYkcvUFo0blgzTm5hZWxxeVVrcmF4QzVp?=
 =?utf-8?B?MjdXS0NVcXZ2ME9GTHhZS1RwRlNiQnJiUVR0WlhvcmZzZnR3Wk5nb04xNUZk?=
 =?utf-8?B?bmtpa3c0dlVYWHh6V01xNmp1eWEvMGgxNEFaNzBrWjNCM05uUmMySlVSRFZZ?=
 =?utf-8?B?NFZpTWN3TEs0Y0Y2bUVKKzNTLy9YRjAxaktwVDBlR29YL1BuMmVsSHVmTFlT?=
 =?utf-8?B?ak5nalpOVFBSZzFNTXNyTk9sNUpiaVdyNnZpK2x6SVl5eWJTN0g3OWVDYU5I?=
 =?utf-8?B?S29PQkszVkZBVVRlai96dGhXbHQ0WVF2Tm9VdTRpM2hSZ1M4SkZpYXVpR0Jx?=
 =?utf-8?B?RnM2ZURpRVJzRjc3Z3kwMEJjaVhUMFNTb3lobHNDT2xFeUdIZTcvMEZnMXM5?=
 =?utf-8?B?akZtbHBoMlpkTDJKZDJqdE1SZFhWck8rMW9acHIzdVJHUTdpaTBEZnZ4NU1B?=
 =?utf-8?B?NzMreVlpOUpGcC9NWlVsc0JLU2dYTEJmdkxPcEZRWVladUhKeGNQSmswcGgr?=
 =?utf-8?B?U2Fpem9RWFVibkFkckMxV2EyNlVnNlZLWmw3WGVpVDB2bVJtd2tzMC9jS0g1?=
 =?utf-8?B?RGgrU2xBTXV1dVZPdFJEVDdTYm5EemxabitSM3l5K0RXbW44RHhrZkVUYnQy?=
 =?utf-8?B?S2xNNWpxS0h4ei9kRWpSM3VIcVZFWVZuakZrZHJTZUNhT3JIWE91SmFCUmpu?=
 =?utf-8?B?bWdYSDNuVDAvMzZvL25HdVVOemJtRC9RVFU5SkJaRk9semNiNU1XcENsT1li?=
 =?utf-8?B?cDN6N1RTczdrSE1NWk9wK3hRanBSWU9RV29ESjQzQ1VMdTUxY0VXTmxwZDFk?=
 =?utf-8?B?ditiRlFkdmpzRFZWbXErb2hvcjBaK1BEMDl0Zm9nVzhvVXBqUDh3Sm9WRzBu?=
 =?utf-8?B?QkNKcGNmeGVMSWVVK21lZm5ON2IrdllIcFNRaWhiSW9sUUUwN1NwZjRNSXdM?=
 =?utf-8?B?NjNwRUdrUXB2SzAzZE56aU9ETVZUb0FvWWZhTFhtTXAzMUVxd241aWE2ZVA1?=
 =?utf-8?B?UUJFaFdUakVJUjlNU2RKL2tjZ05nMTNYWlJQcFJ1YmY4MWRyWDM5VGIvMCt2?=
 =?utf-8?B?aE1rR0YxaStZWGJyU1FYcytIL2JPWlpDaGFWZk5nT1lxajV0NkhtOWhyd25s?=
 =?utf-8?B?MFk3bnJNc1dXYTJEYmxWTC84alVpOEY3K1VDcWhFNnovUXc2VXIrRkRLL2hx?=
 =?utf-8?B?L1RwaTBSMVRtS2ZqVHYxYTJacTEzK0I2QkFuR3VPWXR5NS9IM0ZSV3FsMnRx?=
 =?utf-8?B?cFJrTys5SGxNd1hKWEs5aWw1WjhySXpTTnQ1WUFDUUJhU21mMVBWVjUreGk5?=
 =?utf-8?B?SlhGUWFvNkRLdlIvczBHYTViNTY0MzUzVGY3ZVl4YTI5UGRCN3Jkdm9NY1NE?=
 =?utf-8?B?WFUzdVBHekl5U0FBKzJqdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFREN3QrZEs4cmlOVnAyalIxWkp5MmJPVzVITTJUWlVVZHdXaGtybTgvQnF3?=
 =?utf-8?B?R0RNd21mRVpOMWdzcHlRYjJZbTB5LzVQR3VMYVdReTl6U3BnanJ2VVRZSUNa?=
 =?utf-8?B?d0Z2VG9QaTFsUXhZTTRnQ1ZSVlA1RGxSOUZkUS9Da0hmZ0JyZnEwRnk2c2Zo?=
 =?utf-8?B?UmhyWUltSlJxSVRlSk9XdzVTME9QTDAzdm1KRkxCSGdibXB5QjRsSW1jM1dO?=
 =?utf-8?B?d09QeVE1Umo5aUNOY3lsUjVQVHg3OTJ2Mk1peHBNb3p1em1RQWp4ZVA3S2hC?=
 =?utf-8?B?cUVYMTlUcktmWFhINmFndE40Q3l5WGVYbVF4eHNIaEVEWU1Od1hGeXNIeW5v?=
 =?utf-8?B?UmFWK1ByRXV2OTl0Wm9PTXM5QVVlZEpuZm8vbVM0SU00VHppc1FZTGQzSGRm?=
 =?utf-8?B?OUdhTXEvd3dpd3JDR2ZFU0tOYlI3N0pCQUppVUUyUUlqTHg1MXhzUlUwRkhm?=
 =?utf-8?B?NEFrZnFHZ25iZW1DclBVVEtmZzdubWxBZDVMdFhNWVlBaWlCZlUxYTd2UlVF?=
 =?utf-8?B?dmNYSVJrZnNudmVOYWd3RGxIS1ltWWpBeVE2QitPSWU0OWhuMllRdUl1bUlt?=
 =?utf-8?B?SGJrR2s1UVNxR01lUkFzdXJXQkJIQ0FoR3ZsT2YzVUJrRGtJdnhkZmxNbXUw?=
 =?utf-8?B?VVMvZzJac3ZqaXcvdFlKazNxNWZPSHJVaU42Mm9EaXhybzZHQlk2L1M3d2pO?=
 =?utf-8?B?Zi91OC9sMkVDYkRCa0Q5ekNJSThoUnFCbmxNcUM1dkJ5Znc3TTVyb3hHRG1T?=
 =?utf-8?B?YTcvYm95VHNERmNYSW1oN1NmSjl5Q1IwYUhzdFhTMHZXTk1TZ0VncGFMU0Ns?=
 =?utf-8?B?MkZEVTlQQkcvMnIyOE51c3c1cWdEdWNDaGZ2QUZlUk5pU0FxVGdIVnpxYkNk?=
 =?utf-8?B?UGhZYWp0NHh6VmljTGF0eGpsenBqZ091UGMybnFPM0toNm9ENzM1aFhmbHEz?=
 =?utf-8?B?RmljMWNrZDV0dUVkM0FnaG5Zbk13L0RSMUZ3V294QVVTUUZBRlNzQkF1TUUy?=
 =?utf-8?B?OHlTT1Y3TXI1Rnc4c1lzMmk2NEczV1RIMC9JN2pGd1JxZDI0Tm9VNlNuL1lU?=
 =?utf-8?B?T2VqN2RtTXI3SEt1QnZsNXhRdWxVbTJpdjdIVVRmVnZ4di9DNG9WQVJSb2Zl?=
 =?utf-8?B?RHpxN1psb09tWHovc1pNWk90QkFYcThVOUsrZW1ydjN6TmtrOHZldlh2dk1i?=
 =?utf-8?B?WE94L0JDaUxqMkRMT24vVEQ5YkNKWDNEd0F4WnhVWmRFa1h4UisraExLSitQ?=
 =?utf-8?B?YVFqV3NuT05TY0x3U1NxdDVPNXBhYjR2a2JleVpyeGhKbGl1SjBZRHQ3V3dz?=
 =?utf-8?B?bE9uTi9ZMGw2MFpEa2RpOVMvNU1oTVh4bVBuNlI4ZUpvekNYcnlHb0VmWE56?=
 =?utf-8?B?RmUzYitKY0w5ZHJscGJ3SzFJdXExTDdOWFlweTkzUG5Oa05tS2psKzRGdmZM?=
 =?utf-8?B?LzVSempVRzJrLzBiU2FlT3h4eFEyL1JuSnZyU3VzUytPQjN5b2dGZG5UeFNp?=
 =?utf-8?B?cGpZZi9oSTBYdGNYaWNZTmJuOGhWV2V1S1dMc2dCMHgweS9RZzRGSmRPZjR0?=
 =?utf-8?B?ZHFZVEphWFBRdzZ4ZW1xK1hlVlR3Z0dtcWx1cFZlWXdSa2txdVlBdEZrb3VC?=
 =?utf-8?B?SWNPUi9lMHdWTDhjanoya3RPbWdjUnVWSzN5UXdYNDJjL0o3MlJRSDl2YW5o?=
 =?utf-8?B?U1J6LytOVG9iMklrOXZOYlNDR1hQTVZkb2hKcnVxc21MK1ViZGxBenNSSDRN?=
 =?utf-8?B?akhpVkVTN0xSM2F4S0JBOTZxVFJwUStjam5pdlQreUdvSWhHVkhYRVZRY3N0?=
 =?utf-8?B?Q2hRUHRTalluVTVWQXA2TFdMYklNOGl6d3FrNnA0UFc3Q0NJNGZJcjBNVHhp?=
 =?utf-8?B?c3kxMDdISlVuL2JXWEwzdXRqQjJTNThraVVCNVRGNExlS2VWK2pFQ28yWFdN?=
 =?utf-8?B?T2paWWxVaXpzUnBBR1VBSU5lR1VUdHJFK0duMW5YYnUrWlQyNG11eFdRN1BV?=
 =?utf-8?B?T1BITWl1dnJrTHBybUN3bDZqRDQ4YzQ0bkJuN0paS2JmZTVFSWhIc0VKS2lr?=
 =?utf-8?B?a3lyRXhuekh4WUFrbDNwWGpZVTlMV1dobWNtMks4QXp3TzFyTUprenRwa0hO?=
 =?utf-8?B?bHczeVI5aER4RTFxSDBQK3BMOFE5UHQ5VmJCczFvOXZkaXB0eCs5dS9lNjhJ?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd473e-02a1-4f63-2098-08dd15737bc6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:26:29.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMGmU0xPhC53bmJt2oug37ZAEpqw7A7rGUorVPmMGs6NJ+9FXFOxD2+pAh5XJ2Q6H00QhH+QXF+CjETAep8GANfxcQ9r0e1U2Y/QgG9Go2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com



On 12/5/2024 1:52 AM, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 12:43:35AM +0100, Przemek Kitszel wrote:
>> On 12/4/24 18:12, Vladimir Oltean wrote:
>>> On Tue, Dec 03, 2024 at 03:53:49PM -0800, Jacob Keller wrote:
>>
>> Amazing stuff :), I really like the fact that you both keep striving for
>> the best result, even way past the point of cut off of most other ;)
> 
> It's all Jake. I openly admit I would have given up and not followed
> through with the review feedback to go to modpost and back.
> Additionally, the __builtin_choose_expr() breakthrough was all his.
> 
> Jake's determination, perseverence, discipline and level of skill are
> something to aspire to. It's safe to say that without him, this set
> would have gotten nowhere.
> 

Thanks :) I'm happy to finally arrive at a version I am quite happy
with. It certainly took longer than I had planned, but I believe the end
result is significant improvement and code which hopefully many other
drivers can adopt.

>> prior to the change CHECK_PACKED_FIELD() was called on values smaller
>> than MAX_PACKED_FIELD_SIZE, compare with [j] above, now you call it also
>> for the MAX one
> (...)
>>
>> off by one error? see above
> 
> Yes, indeed, thank you for pointing this out. Jake also replied a few
> minutes prior to your message.
> 
>> PS. incremental diff in a single patch is harder to apply, but easier to
>> review, comment both in a single reply == great idea
> 
> I'm interpreting this as a positive comment :) I got mixed feedback
> about posting diffs in reply to patches, it seems to confuse b4 when
> applying.

Yea, b4 am / b4 shazam don't seem to handle inline diffs like this very
well. However, I've made good use of:

$ b4 mbox --single-message <message-id>

and then editing the file to extract the diffs myself.

I think there may be some possibility to use the scissors lines as a way
to identify the diffs, but I don't know if b4 has this builtin. See the
section from git mailinfo:

>        --scissors
>            Remove everything in body before a scissors line (e.g. "-- >8 --"). The line represents scissors and perforation marks, and is used to request
>            the reader to cut the message at that line. If that line appears in the body of the message before the patch, everything before it (including the
>            scissors line itself) is ignored when this option is used.
> 
>            This is useful if you want to begin your message in a discussion thread with comments and suggestions on the message you are responding to, and
>            to conclude it with a patch submission, separating the discussion and the beginning of the proposed commit log message with a scissors line.
> 
>            This can be enabled by default with the configuration option mailinfo.scissors.
> 

Perhaps some way of marking diffs with the -- >8 -- lines could be used
as convenient markers for where a diff in a message is, vs regular text.

