Return-Path: <netdev+bounces-306523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nLUtL7vVUGoz6AIAu9opvQ
	(envelope-from <netdev+bounces-306523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9173A2CB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Mr6DTz7r;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306523-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306523-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9835B30067A0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67B4192E5;
	Fri, 10 Jul 2026 11:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6A413D95
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:20:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682458; cv=fail; b=Xh/mLW72CwXAf3rwiKlFmC5MI96E6CCRqanDW6wKtFO4+JpUKXHonNP8l2IFRGNZyKd37QHmy/R7iA7ajuEQbGDZ6bIwgMefFibZGNS7iFQHquQlWZyTqH67fJrSBlCu5nEtUMoQlnXzhuHX0PKikeLjHaOd4tiRlv59RKvK+zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682458; c=relaxed/simple;
	bh=jgqyp5PB8T4Fyj5VmylRRNfcbzUfJhpjI0pARwQuG20=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=TYYKIWrgFT41Kp52fcsNs/OAHw90KdyMFe5TSL0vMFJrEM5oWod9oci1+OYk7559+kwkIfWDOtmDyMCMnYLChNxHh0KzCTlUcgz//Kxw2Y3OUsbVCUqldzvcJc2/ViPIh830ltSg4nX3rKnshUKcA4PZXXkUgEXkETj+V4eq3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr6DTz7r; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783682454; x=1815218454;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=jgqyp5PB8T4Fyj5VmylRRNfcbzUfJhpjI0pARwQuG20=;
  b=Mr6DTz7rqk3ITWl7vYlIM6x1br7KUNuTXzBHIBozGXblwFU0hEUlXxEd
   k2AAuwVN302ihd4ZR0dxXKArtxfMlwCASLz/AVJlZOTB9Yf/rqgvt5KbS
   2MdchWoEBKM5nPjm6un8svEXiLtqbemgfENRaJR4izEy+scCj3bMTSYCz
   GPAm+vaE+95cYgdWXdNYKT3A6y4rSWse3F0SRzHt9KfeyKkEs34ss7UbT
   J74p8lm8m/78RnmnSLsi31qoZhGCGerI7shptQtw5/a2R6Ux33eqlXdVf
   CQQJWQZdX1jszEPG02dcOHhvRRUJv7JEVk5U5V4nR5K+0lfStRLXuPJts
   g==;
X-CSE-ConnectionGUID: sL9Fjk2DSHyKlwpnCafM2A==
X-CSE-MsgGUID: 4qc71tx9Qu271BTW+I7qOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83356558"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83356558"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 04:20:50 -0700
X-CSE-ConnectionGUID: P4miaysIRemSZR+VxWHQVQ==
X-CSE-MsgGUID: VCzXHS+KTzyQ/DZixAPEBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293061992"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 04:20:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 04:20:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 04:20:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 04:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frnBdw/JI+76Pfttv8lpjLCkNsueONhZe7fQtgkC/uGCto9JELVqTvZWu/0NXTUdhz8xaHxrfNdfoO9vlYt+8c6AJzHxGIpLHGtAnJkWKZudskl7NWE10c7yQusi2cU53mUliFEMQiHvcP5oxBZNon2azNwiVA/UTZxtIrne5xX1VbgNcBQmSicFYcPi9c3orooKDGzBNebIPkwiOsihXgupMWlVkxrZ0SPFn4IBTNmFJBI8I5C9LCgScHmoYhUMm5iTRNgUaTQlpy4lz3plcXknIH1PBWLLBaj5II/SeCX8g7Fd0HyX46TWS7X5olo5PnYoqgZxFEtGunU3GiLhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1DN8H8xtI+e034D9WXwmYF7nR8nKIXdVudwIDulBLQ=;
 b=UKC36DwHDjd/ReHAhI2AAXoDYsG7Kiu0IXs+EhtmMX8O6CWc57rS1vzLzV1Q2mwd6hhOlblvtIeJ9hRbmlKNRnbwqMbNphdLMAviIcHjgBIccT7Esph3PqYNAybOqlfdN8T9gMAWbJH9Mjc7fMrD+ycD9/KODdOEtuewD6e1BGIebCLeRmg1Ad6CnsWJhlLBbPLVI5U8znr1HWiTLIRDQojeAX5xAmxNOSe6CgkPzNdIxJnYIPqDaRSDrDpphSd409SP3a9ARSmTy04+TtMZHnXCSvcTzIFvRzwZ/UmkZPD5eVE1eu3ST5JXDZM4agsuinDLEOk4Gohu1z+G8HZsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 10 Jul
 2026 11:20:46 +0000
Received: from CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556]) by CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 11:20:46 +0000
Message-ID: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Date: Fri, 10 Jul 2026 13:20:40 +0200
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>
From: "Pielech, Adrian" <adrian.pielech@intel.com>
Subject: [ANN] E830 NIC join intel's netdev-ci
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008B8.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::68c) To CH3PR11MB7323.namprd11.prod.outlook.com
 (2603:10b6:610:152::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7323:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ba0df-c0ee-4c2b-22c0-08dede75494f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 62Vicu/QfbxGdhPIMUBUgqjPTHUIVyYGnAy0IsmHVeJsww5EPN/2RBovn+ttJPQ94HHau28rpLxrSqG7G/KIObasMAwFKscd4iis98GV8ri2hHIvh9kQIH8+YnxiVKdlnA1d1E/ffEXX/FEQmKypv/EEcPn5gf60EXe4Z/rWjbKutd0doDiT6GFLWIiOZbloKqqhetQEmdDVXsyYSyjpJJm/z1+47qKA9VW8NiD0GoZD4IatKBbxbnYaP2CVBeQEglV0rC6aaKdt3p8Z7MWYrjdoiCwohbMW73zZxuvpsRxzAn0xSNakWT4LSC2tF5FOs8XqmUUzLDyu5Z4cC+tyKHRtRjM2X2ogyZsX9DG8D9Y02pcUz1eIr+WQQTtqjeWIhabtpaugj3ViKvjVEhtLkysCRM5WRgOgmx6jREtejVFAGZaU3VB+nwHzTwGYi+3KMYMw5bNDIRecb3wqSkLZsf3KI+xdzZMyIibaKIyg0WBe1wPgXbywKBqg1fK6bRIl4Ob2yCGUgxGJ71nHgKxCqGLpk61RkJNky/fhaLSHdAAvqepJKjCqvzAxoGe0SGXPR4nV7RF9DPJyA8JPvjAI6bOMeMf4sITrPI5G9+hSLfGgB2clT82ZzLfz7ijA5pL2xzmhKvi2cAXicYZHbZ1uYtcJ/92adIGYX+x0QW7RV4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7323.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdvdTZPU1EvQWNsdk9xSFQyODVjR0xIMDhEcGJFbTFlbk9OL0VVdWFocTJj?=
 =?utf-8?B?YysrWnArWDJKR2lDNUpRS20rUVR2YzlhdFJtTU9TQzNWcUpiK0tJM0VDY254?=
 =?utf-8?B?M1AxY3RRaG9XR05ncW9rbDFhRVQxaTgveFZjSGZJb2E1L2FFOFNHTTlvcnNo?=
 =?utf-8?B?ckpIL1NmY0VVdkRKQk9uTXJ2M2t1bzUrbVFJN3ZrTmhPa3VSR1EyTjM2R0Zl?=
 =?utf-8?B?UldnUm1ram5BSDZFV3o0ZWNUYVJjT3VTVXlVMXRjRVErbkNWNTFLZVViR0VB?=
 =?utf-8?B?U3AvTmdOcGRNZWN3d3FiWEsrd3ZQMWtORDI4cFliN3B0M0ZFcjdxbUxlbzZx?=
 =?utf-8?B?Y0J0ZGJaV1pSMjM1RGlYVytpTFFEZ0dzSENZODZMeURzRlJuaTlHazZmd3BU?=
 =?utf-8?B?aGRFSkc0QllHRGZGMjFTWUVmMkUwbVlVOE9mRktEeEM1QXhtaGJNNWJISTAy?=
 =?utf-8?B?UzFJczRhcXlkU2xoMzU2a25ndWQzaHl5SHNDRTZaQnMvNEdHR0FydHlwZ0Fs?=
 =?utf-8?B?UVl6V1RzRmp0bkZkZjI1SHZjMVg3amh3N255MHRmMW1IaGd6aFpmYXF3eGVR?=
 =?utf-8?B?TzQ2RjBtVCs3NFhtNXZJTGVLdDRVUjlMRDFlNHJCM2xhMnVVN3JiTGwvOTlp?=
 =?utf-8?B?ODdabzFLVzIxMTZmVTBEOWxtTWxlY2wvMFF1a3pnd1pKV0dEbituKzFlZnRx?=
 =?utf-8?B?SGlEem82WnQ1LzUvcWlHZWlFbVFVaUtwc0haa0M5SFFBZzNNZFhxMGI4ZU8w?=
 =?utf-8?B?dCt1Qm5Tb2VwT3dCTy81Yk9TcjdiZTBiY0JOSG5WUml5SWdFVmxXaW5GY1RY?=
 =?utf-8?B?SWl3SkxSaTZUYXJ5QXRWWTZ5N2NUSjI0dEdGNHRreDBCQTRlS1dSdVlnUVpZ?=
 =?utf-8?B?UTVENW1XRjNFOVlKVVk1Rk5RMHRQb2xFN3kwSUIyY2d0T3NVMXJDTDBZVFdQ?=
 =?utf-8?B?Y2dTUzlJUnAzRmVXSTNzSjVqdXBMem1SWTg0WEZrdWJTd3pCdlFlandvaE93?=
 =?utf-8?B?NjVQaHNpZk5NVEtUaTFsclJCV3luY2tPQ0ZZWG03MTF5OTE2T1FjVlZqa3FS?=
 =?utf-8?B?MENCazlEcFFYV1A1MCtGSkU4cWZRV0QxZXpEcVJ2Tkc5SUZkWG4zbHR4R1l6?=
 =?utf-8?B?c2k2em94cXRvYmkyeHkxT0tHVDlUSVdRUTU5QVJXVityRkFWUitZV3UwOUFl?=
 =?utf-8?B?QWdZRUFUbGltanFDUG1NS0NUeHZ1L0xmMmlmY2d1bkI4b2NCbHdINUJwNVFn?=
 =?utf-8?B?b2c2N3hJOEZNd2w0blBZRHhSdlZzQTU2SEphaGpNRjA1Tm1EY2xNdzVGKzA3?=
 =?utf-8?B?MkhSWlREZDRRVXhwWDRSTGVPZE5hdnZoakRqcjA0bHN2M2NnM3RURG9xbmZR?=
 =?utf-8?B?bDdGMEM2VDBpTFVJQmhmZS9Pcnh0WU1wQmtET1pLOGcvaU1UVEZTeU8xV3BQ?=
 =?utf-8?B?THpqNm5ud2pSa2pUeWhCNHBqbmFrM0tpdk5OQTJDVUI5UU15UzVPT0NWMjc0?=
 =?utf-8?B?UjdtMjRpamY0MFdTbFRlOGh0b05DVXpLKzhzdllKWE84ckdrY0V1UjRFRkxS?=
 =?utf-8?B?U0x3R0NWaHlMNlBrWWo5S2tscXl4bC83Y29kUXJURDB6MTNBTmRWZXdnZnlm?=
 =?utf-8?B?RlloNU95WVRQVkc3UXB0dHhIaW5PRHpPWHVjUlVLRDA0dzhhZUF0eGF1dy95?=
 =?utf-8?B?ZlZBVDdkeEd5dWhISkd3K2lIVDRHVWh6bjBRNzNKSXRxMExxbU9vd0hOR252?=
 =?utf-8?B?WFAzVWd5bEo0YnM1SXVNR1JTTHQ3RkcxT2t6NVVlUEN6MUE1dDh0dnVxV0Vh?=
 =?utf-8?B?VzFYSndjMjU2RVhpNXRzRVlSYmhCZWhsUngzWkRuaHkxUDZVeGZIYWJTODNa?=
 =?utf-8?B?U05ERDhBN05aU04wRVg1eFJiWEZ3OTFyY2U2aGh0NTVrS0JqKysvNGZBaEZn?=
 =?utf-8?B?QWtYbk5YdzhBWEsxS25Xay9uWHU4dmowMUJBMjRoa1RaN1Ryd2ZXdjlyWTlP?=
 =?utf-8?B?UWVPQSt5YnR2YXdta2tMNGdxekpNZXFWVVhadWpGN1EwMXoxZWppYUZ0eEZ5?=
 =?utf-8?B?Q0hTYmFRQm5zZjY5cGJjT1plblZSeXB2cHZmRkIrd1NJOTh2VlJxZjVTbGhR?=
 =?utf-8?B?Mi9yUzBJTmdNU2l6UkF3TUVyOFFQQ2YwK24zM24xYTQvSUU5Y2Q3ajNwd1pW?=
 =?utf-8?B?SnJtajI1QS9nM0NROGtDMnozcVBXVnVtcFYrV3ZtWk9TYVNJaE1EZmVlZGZi?=
 =?utf-8?B?Um85aGJHNkI2dk9wZWZMcjJ3MHBpTDVkeHpkK2hYL1NCQkgwSDVPVE5NNGVs?=
 =?utf-8?B?OGF0QVVDMDFOdTNSQzV5YS9WWkJyT2xTTUFsYUx3SkpQUjlRTHFuQT09?=
X-Exchange-RoutingPolicyChecked: gtEakDv7q5AOsIgbYfoaRU43WTySTZ+3xNQG17iXlr1yVq95i4hbS+XRbN21wn9j1I4rZf9nr4Jb0/iarAOkwROPBUqTwEF1lcZOA6TnfdJpwZiAufc9r8T+KrJ1DMM7ETGLs0MgGAdTdqtHcFvhZk6b62VhX+0UPjyr2ARDvus11IcAvy1z3RUns9fIGRRIGW1u1ejO0/aDyZebB14xVzRjbmC4XPK9Wa2jVY+tbL35X8WSXVmubETDIm04/sqhU/ZgmpaKv3nFLAzlsbKcSELHIDLgMRBJjWwLJWob/Cf+VZGIRKl6sxBnqsQCUY0neLxLElIhOZaZaocTOL+0kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ba0df-c0ee-4c2b-22c0-08dede75494f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7323.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:20:46.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz0mVsygcucVQkF+CqEVSfSlrUJRdMnQUulrfuRYcGYK6q2vUIehbBy7/y4XaZnvA3l17tY7POORsWK9CF2zischOzdCrxgZXUB8p47dxG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.pielech@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92F9173A2CB

Hi folks,

I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet E830 
product line joins the suite that tests ice driver against net-next-hw 
branch.

Adrian

