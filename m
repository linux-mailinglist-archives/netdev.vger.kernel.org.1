Return-Path: <netdev+bounces-227432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4BBAF254
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 07:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BD617B7B4
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 05:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F10261B9E;
	Wed,  1 Oct 2025 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHY+nvXC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D2261B64;
	Wed,  1 Oct 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759296565; cv=fail; b=KsewIj2UMMpZ7GMELDFrdZVse37fMYOG1eS4FYhkUfGnSvNhtBVi3pn8p0iLQpXGihEErJhLmOUej2QwLOQIbM9G5iMYlr0gIWAdhkQvjU+k0Q+BIUTOaIFEZL/25FL0K+ffzwpHrqb78PlQGFAVZ5o7NbGwz68/UpeOFEvAy8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759296565; c=relaxed/simple;
	bh=oZk1Mq4pkRk/zaZ9uX2tuJ4Y0tQJzS6PSXfrveG9Ahk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=onHP8ukeSX4rjdadJcErTnrc9W1hDcWNXcUp0oCdgmq6U9mub0DAiT7WK/wOn1ubVdFy4LmmPGdaF393c6fW1vlUFVLxR72n+Z1Zwy4OJGLYFHYJbd7vlP7aAhPqD0Y8uR94nExmD6xVTg5iSrKQCOjQgpbROW6t1NmHQBadq1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHY+nvXC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759296563; x=1790832563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZk1Mq4pkRk/zaZ9uX2tuJ4Y0tQJzS6PSXfrveG9Ahk=;
  b=GHY+nvXC7Y7Hswcpw4iuGzc/aCn6VQUgHP2OPK/26vhVuxi7naPRxHNI
   JWpLIkVCV7UWGKVeSzIwaiNCuQupQxfwx4DPDk/Q0DJvFNoG66NcvCQFY
   /FyLca2HyNSuP4yHf5tu1rVf+AZOXpq8ktig19K9BpJvU9dln/ys27KEt
   QChCWx+h0Hsp91xHfyce1VpvcK6hLIOqyNbDl6MWKekOvwicCgghRgMj1
   nxE+r9+BnpBVTquloInNDZRU4HjOBTL7FLdNQ0UM0E37+HOPgenmO/7Pi
   IrnL0/YrQG3nCz8nPCognqIysCLQhU37iOK8NYCjj1Iawv9zPG83g+gkw
   w==;
X-CSE-ConnectionGUID: Y3KQ9Cz8RPmY1NZ8C879nQ==
X-CSE-MsgGUID: gGQ7diylTo2SacUeh0sPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60776580"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="60776580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 22:29:22 -0700
X-CSE-ConnectionGUID: MR2b18UgQ16x7qre+GrfnA==
X-CSE-MsgGUID: FpzAUTPrQFSHPKw0GOlYhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="183962228"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 22:29:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 22:29:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 22:29:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 22:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kghiE7Moe98LmpAk3BfvgXEtoz9k2uvOYS0VbrQd4tSn1tVpLxeUuNUr4nHSC0Mz4JBSaDNT/P2PkZY5OxOwn8uXUUxE1mJ/wfuFpero1NaPZWkkvBSdGFCShdXnBeYszHptoNMGISYwjGpm6kamZ5VRy8zQWQTeW6fbMuGxURKt90Yxjx2f8+RamgZ327PREdibnYEi2z9kEqPbeTbrY/kiO2O0HuwJo1liSZrp9+JulJ9dzFs90PyarfPPO1Jue+fmYfDRQr0a5gqvRdkgpnHR+TuYmR7x9QMoGBxo9IkysYbZ1sOajPyS9p4TkxSUNkt+WbdXUVVveQ4vSh7jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgtNo58EjQMoUObC++3YFI4H2ft8JXbxwOVZxwgz/G8=;
 b=XpyLG7GJsNPF0t7u3umRFZ96JPTGklDZ9uxDazlO014VJUiydf7MYw9bUjsLwdVYEtpm0RKAJInz4XbCO3o1R/mCmWfHt/SDeFDZ4xFbel7wiCNqsR81tEgdtx/Xxbv3dUntiYY+Nf+he3eggMgH+GGJC2BD3cexAtPcE5eIGVYcgicgwTi7DvpTGz5p9H5jltFRcalmFxi/2/BiioqqHuHQ/g/uVvXIpjohPXle/6H/LKpESvn/c7OjdOyDiaysirw9RM9WKSOb85rh93fDxZmyzaPYBrvoNmBG5/XONJuRahKQX2X6Tyf1ITFgJLp/PKe702AJ8lJdxnu1vw6Hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 05:29:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 05:29:19 +0000
Message-ID: <ccc138d2-fa93-43f2-9733-e461396db769@intel.com>
Date: Wed, 1 Oct 2025 07:29:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ice: ice_adapter: release xa entry on adapter
 allocation failure
To: Haotian Zhang <vulab@iscas.ac.cn>, Jacob Keller
	<jacob.e.keller@intel.com>, Matthew Wilcox <willy@infradead.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250929024855.2037-1-vulab@iscas.ac.cn>
 <20250930015125.617-1-vulab@iscas.ac.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250930015125.617-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0205.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::30) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 16923ba4-a2df-4eee-fa7b-08de00ab784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2Q4bWhVRDVKV2JDQy8rc1A5VE1aR1crdGswR0VFVm9UK2FzUkY4TSthdTBw?=
 =?utf-8?B?MFJNWktwb0NyUm9vOWpsckRTeVNMVGpNcy9DUXMxdldSazFPZE5VRW93UXg1?=
 =?utf-8?B?S1NqU1ZZSmxQTHAxV2JzUmVRV0ZCalRqOTdrM2lzNGZHRHNtc3Ava1lxbHpM?=
 =?utf-8?B?cGNKTFgxVldnWmlxbEoxR3V1NkZ5S0FMMjlvZ1pEQ0dGNk5aWCthVkNKT1ZT?=
 =?utf-8?B?amRacjVBY2hMc29saXVNWDVLaG5XSTk5ZXlXcjBkRVNiN0ZlSGhxMkFnZVRG?=
 =?utf-8?B?bTY2OEdvbEIraGY4VTJ5RlE5OWh2UzN4dWd1MVV2WXdnakNJUWpHVEFndmYv?=
 =?utf-8?B?bWt4cXA3S0lJTEErZXB6UnpHMy9GcFVJZGl4NnZpaWhpVklabG1TRzFrYVEx?=
 =?utf-8?B?NURaR3M0V0Izamp3MHM4bERZRnJOSjZmaHk2dWN0eVl1U1JOMVFseTU4amZL?=
 =?utf-8?B?YkkzQ0MxUElFYWszbmlOVEx4RTZmY3RuOHBNU2dwZmV6b1lidlVhYmxHSkFN?=
 =?utf-8?B?TnUyMmhqb05lVFZqSzBMZ0JpNmo3RGJ4RzQrU0JEMmRHSUhhUzZ0UlNSQ3BC?=
 =?utf-8?B?cU5iSGJidGZtSC9kc3dCVHp3VTcyZ25yRVpicGNraUJVa2NlclNpUzJ3aXY0?=
 =?utf-8?B?K1hnVUtyVXNTZjhXL0ZCV2tVUFF5dWlSdDU2TC96U3hINVdDWVFmeE9qU3hN?=
 =?utf-8?B?SHlnektENFdHaHlWYmxPdjFPWlFOSTRkclhIZVd4Ums5TVlGZmlVV004VkhV?=
 =?utf-8?B?NnVJQUhFVXV2ZXRzSU55SjkvbFF4anlQWUhaUkVTNkZJUndXdHhmUnd4TERH?=
 =?utf-8?B?OGFsUVRCZzRoSGxtRXk3NkFIL2gzQVFnUVZBeUVXUmFsemk0QlVSMzVCbnJ1?=
 =?utf-8?B?alYxdDRVQ1dYeUN6VXlaQjBmcEM0SWxBWUhlOFVBVUc3Nm9OU09nMFAzZGNL?=
 =?utf-8?B?SHdrZWJSekV5bXNXdStmZzlIWlVrcElrSWp1NnhveXk1VDRqRVcwcXJLNjZY?=
 =?utf-8?B?eThUYllvZTBWVHFvMzRrbGZTOENWaUk4RUJMNk1YR3pteENrSS83VC9sSUJV?=
 =?utf-8?B?WFVxZWVJK1RFYUwzQ0hnbm5HblRCOHIwQ1FpZ25KT3NJaUJQTlpRaEVDbzdV?=
 =?utf-8?B?a0ozL3hGdkF5RGN6TE5HRHU3UlZLdnkwQW1ibDVDU1NyMmRyaTlMaFJaZ2dL?=
 =?utf-8?B?QkFHcHhDRC9neUJlSnY3K0Y3QUk5NVQ5dmtVSGxIRndTdUF2SFQvWGNWSXZ4?=
 =?utf-8?B?SE44WG43VzQ2NWpxRGtuWWs5SjE1R0lhdFA1cGM3dEpDNGQvQXBZS1crOVM0?=
 =?utf-8?B?T3FpdmxUS3Njd2pnd2xtL0hTNjZlU3NXRm15UzYxbnczU2xoYkcwZG5Jd1pD?=
 =?utf-8?B?TVBXUEZ4dDBtdkF1WWZwWkIvSEN6d0QwbXNrbXZGRTB6bDdDeVBiWjZxMnAv?=
 =?utf-8?B?MHJybkFSS2Robk05d0diWE8wYlZzd0kyVFRqVjREZXlFTFhsc3JCZGRJZi9R?=
 =?utf-8?B?eFIvODJqRGQrSWhybHl3bjR4ZEE3N0RzTlJzeDh0d3VjOTZUK0trbnVZRmVy?=
 =?utf-8?B?U1dMaWVsVVE0cm1wN0NIb3VQWlE1eTREWUxmanBUeGFWRmZRQkE2T2ZTbVN2?=
 =?utf-8?B?ZURzU0RWdEp1RWVHZ1NsblpHa3EvQi9tbWtNNU5XQTNRbXc0OHJJd3Y5TU4r?=
 =?utf-8?B?YUQ2N00xc0liY3dWc2RkMEZZOE5jQ2VTem9RaTNvK0NBcUNUMHo3dzZDTDZ6?=
 =?utf-8?B?T0tpUTlQb0M5SU03ellSQVpDOGhzWDBqSHNIZnR4WDVEZ0o3VHVOK0JPWkhF?=
 =?utf-8?B?c1M4UXg1amlOeC9SRUwxMUNKTUVwVWlra29acDZDZzQvQmh3YVJtMjFLaG0z?=
 =?utf-8?B?Uyt3Sk5jbmllcVlMVmZaMzhUZG1HUTRscmR1TFUyY1lkZy9IQ1N5eWprWHVJ?=
 =?utf-8?Q?8u8fUqNcARm1EEkMgND0lH2ysQawsnIH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDd3WnhzNlpYQjh4WlZVRlV4U2NTZ3ZYdXZITEhBQjIzQmVrUGJWMzlXVGdD?=
 =?utf-8?B?VEVvRTJRaGhqbnk5ZUxBVzVjdEl4OUhsZzk2ZjBOTjR6U0l1UFNXK3lyczFX?=
 =?utf-8?B?QzVHak91T1hZd1oyWUFMUXM0eGljMWhnTlcwSjNWbmtCUzVWMVBiajZrWHc0?=
 =?utf-8?B?SERyZk1CREhFWHNEL0hXbTNJaGo5RTFWOE9kRGpaZnVtbFByS1JJcWRCVHVC?=
 =?utf-8?B?WVJyb3BKZnpBM3Y1bU5qbnA4bEMyaDFZUXFhclNUMFlaeUhhYkxsTlVkZ1lW?=
 =?utf-8?B?Q215b3RTUXBHWjJjUmdKSG5CcGVJQ0xCWjJJNWNFNFN3NFZER3BiNzQ3WjE0?=
 =?utf-8?B?dGhwWXV2RUwyckpZYVpTYjdTem9SN2pOZUFKZmp6YXlOaEZjTitOSnVkN3g4?=
 =?utf-8?B?cmFCczh2ZE55bEZYRmY3Sm9JRmJiYkxVN0xZdlNJN3VGTjNrWG9PR3RqYWhY?=
 =?utf-8?B?WDMwcDNtakhsSmNWVUpyVnZ0Qld4MVJDSHhhOC85WjdkYUszRitDR1hzYVNO?=
 =?utf-8?B?eUVNQzZrUGN6ejRCZ0UvdHhVSjVWU0xQUCtwcFhNOGNtN09aR2xsMUVNbXpu?=
 =?utf-8?B?dEpWditlY1Y4ODMxZzArckh1TU5OYWluQXJmNkxsTDFnWXhqNXc3Y29wbmM3?=
 =?utf-8?B?RUJlcnRiS25HWEJ5Zjl1N0h6a3pjbWNURDQ5eThqbWJ0SGUvS0pLUUMxRGxo?=
 =?utf-8?B?c0EvM09XTS95aEN1MEtrOVJaMUpUa09Jc1UvWUVFWmJUOHBJQWJUMXc4UzNl?=
 =?utf-8?B?K2VBT1Z2UHNWVzNjWGVhMlMxUnRkWG9aMWdGWVR4NW53RnRJYS95ajVjbnU4?=
 =?utf-8?B?R09pcERneVBNekErdmlvL2twMWxCUjJGSWo1Z2lxaUlZVUs4c0ZlZzhNWkVI?=
 =?utf-8?B?TFhmOC9FajR0OHlzaE1zN0hZY2taYzhvblJxMHd3WHoybGFoaE9mS0J2NHZw?=
 =?utf-8?B?YjVQQVJCc3pNelhUNklIWU8vTVprbklyQmFKSlFlSFgyMTRhYktWOURuQTRI?=
 =?utf-8?B?S2ptb1oxYnIxNXZFV0R1ZXZWbGVvYXI0RDZCeGYrYXZiMVVFc3hheTFuZWF4?=
 =?utf-8?B?MmZNZHdNT1BSTml1Tjl3N1hUU0YvVUJxcXI0Q3FTOW9sa1laRDB3Q2JPK3Qy?=
 =?utf-8?B?Z25FL05mcHpYZU92K2JvakNpMDU1MHozdFNmcU5pOWpndlc1M2tMVGEwRWxK?=
 =?utf-8?B?K2c5bWlWRXhpUUk0eUNNM0QwdjFzVU5rKzlmVGN1eW4zenp5cyt0ZHpFb1Vk?=
 =?utf-8?B?WlAvYjNlM3k2WXBucmNoSkxMc2doVEg1Zzdldy8xMVpVWlk5Zm5RUjBtWTk5?=
 =?utf-8?B?ejB1cHJYbVIvVTMxcDdEZFozay9jM2hXSGRCMU5KcHE2d3JZUXJjaEZyeFQ1?=
 =?utf-8?B?M0ZCajl5eFpXcXpyZDNhTHFlQ1FUd045RkFBZUltbk54a2hVOGVpWVBtUDBZ?=
 =?utf-8?B?SlhISUdGTFhtdUJXeVk2bmhBMW5JRDlGcGFoaUN1YXRnR01BNFVWb3Njb3Bl?=
 =?utf-8?B?RW1kZE9EQjduWXNyNGliTUFOa3hPUG1PajJ2bllWZ0lzeEZTN2VFNDJaNmVl?=
 =?utf-8?B?TDdLbit4M292SWtCL2RUS2VoOFNxcGhBcVkxcVpJKy9jRDFvY1VMa0RCTXZS?=
 =?utf-8?B?OUFzSWxpaTMrMXhHTThNZlhKN3NwYTVyUnY5WWFnbEtKY3dQSC9jVnFrU0t6?=
 =?utf-8?B?bWpubzkxZ1V1aEluYkxUNUhhVDN0ck9PQUJ3UWpnVGQra1ZqSmpLbGZjb0lW?=
 =?utf-8?B?Z3psaENyODlsVWI3SW5GeVI1QVA2bmVnNkRaZGxXT2c2YVUrajdYN25KclVM?=
 =?utf-8?B?WjYvK1hwKzdpMDNKdFlpeVJRbzQ5YUhoSEFBRGJxa3BMU0lycU82VUMrNVJY?=
 =?utf-8?B?M1Q4amJFRzBObzVMdElCQlJjOVA4UEpFenNUakVHWTIzVDVuNHIxU1N0YzhS?=
 =?utf-8?B?Zloyck5yYnkyTjFkZ013R25ZcCtSOEFHcjJzVjgxNVR0RFU4TzRjQk9VRkt3?=
 =?utf-8?B?L1NMQy9adHhJU1NWaXVkekd0cTV6ZlI5TG4zT1VDd3pBWFhXbjVYY2ExYjRU?=
 =?utf-8?B?ZWd6eldoRXNxMUdLVHl1VHRVVkdHcUZ4TUJKS0J4UTFKVWdtOFpqem5udkwy?=
 =?utf-8?B?cUN6ZktWbDBDbmZ2RjNKV2F6emlBRkM0TUdHNWdyenh0bTRNOHMyVkphOW9K?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16923ba4-a2df-4eee-fa7b-08de00ab784f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 05:29:19.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viBpw1iPA7KdtGSl5OHkoheuSmmmN1PUUjvBiRVZhIrln46EQNc0qhwOSrrYXZ2zZPf0CarSV1RgUuWIVMA+TALMaZ2SaMl6CXXdq+rqKg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com

On 9/30/25 03:51, Haotian Zhang wrote:
> When ice_adapter_new() fails, the reserved XArray entry created by
> xa_insert() is not released. This causes subsequent insertions at
> the same index to return -EBUSY, potentially leading to
> NULL pointer dereferences.
> 
> Release the reserved entry with xa_release() when adapter allocation
> fails to prevent this issue.
> 
> Fixes: 0f0023c649c7 ("ice: do not init struct ice_adapter more times than needed")
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> 
> ---
> Changes in v2:
>    - Instead of checking the return value of xa_store(), fix the real bug
>      where a failed ice_adapter_new() would leave a stale entry in the
>      XArray.
>    - Use xa_release() to clean up the reserved entry, as suggested by
>      Jacob Keller.

this is a correct improvement, but please let me propose other options,
with 2. being my favorite:

1. (just ice changes)
change the call order to be:
(note that it is under a mutex)
xa_load() // return early if another adapter exists
xa_reserve() // return early if no mem
ice_adapter_new() // return early if err
xa_store()


2. (xarray changes)
(perhaps I'm biased as the one introducing the error on error path):
change xa_insert() to return 0 or -EEXIST when used as a reserving call
(IOW: caller wanted to reserve, entry is reserved, so return should be 0
(or -EEXIST if we really want to differentiate in the callers)).


> ---
>   drivers/net/ethernet/intel/ice/ice_adapter.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index b53561c34708..9eb100b11439 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -110,8 +110,10 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
>   			return ERR_PTR(err);
>   
>   		adapter = ice_adapter_new(pdev);
> -		if (!adapter)
> +		if (!adapter) {
> +			xa_release(&ice_adapters, index);
>   			return ERR_PTR(-ENOMEM);
> +		}
>   		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
>   	}
>   	return adapter;


