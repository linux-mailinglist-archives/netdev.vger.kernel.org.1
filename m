Return-Path: <netdev+bounces-197609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC97AD94E3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5671BC3458
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC22236FC;
	Fri, 13 Jun 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PteNPObK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB8235364
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841000; cv=fail; b=I0NFghMFDv5ErbS7i1jxjMeFo5t6Pjxd/ZU7q7yk0Z9Rq9gnk/kloSA9A2+bEEj7UkuVympb/RNVzKGKSRv4RhScyvEncZY8ARk1D8aFefs0LemdET9xmO/801H/xp4OxNxL4XNJWhOg1fMaZvmWGrDIeRan8ACmWX4TPGJXLNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841000; c=relaxed/simple;
	bh=qvF+tGL0H14geVShxjDLjnS34bnO42fB7U8f8sSDp5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKmW0SIubHyzYr6QKFpYKB5g+mQOFCx5jQlo80F51EOJWnYaZJuEdNhajdoquJDZNFQCJ2gnx4g16WlxBhhgiidEJQBmPsIaDZ41n7DKUMvMaROgrUuhUIKjUnKX//xcTeZc+U/tONR4CN0TC9XtmatfdXddzmlnDWH5BOkJuUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PteNPObK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749840999; x=1781376999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvF+tGL0H14geVShxjDLjnS34bnO42fB7U8f8sSDp5k=;
  b=PteNPObKXmCcKgFf9WF915RYbECm09cn6RJR/B0gRYmBavSXzHfXy6yC
   EF6crdj3fkfmhGSg7S0KpK0ev3/pRKzQwNp0zKc3SjBrG+BpA+B+T4upA
   9LQ6IjoWcUx2VYPFz+EdwRdeCjTBM+a+4rYduzQ6bV6E8/hBBWNeWS1RP
   zt4FMf7gUszfHWoMyTkJEZSKYeAHkri/+y7L6zofqCMR+dM1mDQfUPayL
   gitWBPAZ3SuGZbe0v1R2z+5UxIeHXul0KaR2GPMe+gRvwzRBSX/WK3+n/
   dztg1AayVa0bMGiIU2aK4u3/i5Prr0htKOWSdYWQ8EJ6ble2N2zf/8Dxc
   A==;
X-CSE-ConnectionGUID: bDLdCUuhRHy00txB/rthHg==
X-CSE-MsgGUID: /EsmzRvZSD6lqHRqgWd01A==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55867103"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="55867103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:56:38 -0700
X-CSE-ConnectionGUID: R0vahTXlTNquCS7FvoQP8Q==
X-CSE-MsgGUID: vGtpdJQMSDm1yAKRyHoLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147746663"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:56:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 11:56:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 11:56:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 11:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0WYTyoU99MiaxHjT+aNQciwKyKK+s+e4FmWnNIPzxl2vzYCTXMIK4UkIxG95CtD/8OPN3Y5W2ytVJqksQPzlSyQyYEXElM8Y9yZt+Y7bKcLnyt09jlyvG5POumvhqQofRqpn92JF3djgfaOaRLUW7LglCJSOnhwDuPzrFPq2EbB5aRxa70VyPALpl8m/EkHa2xr8EokAL+DKfCcQh7c9d2+J7kvxYr5CMMrilcIffQ8KJVKB0pvjzlYMtg9lmpB0gwH3h/TYDfcLRzYb2r66WoatjV60OcTaYWv3bYN6UZcyUVnhiF/7N9MFrXPfeUnXx84Fm5KJrUN+aGLHz/2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvF+tGL0H14geVShxjDLjnS34bnO42fB7U8f8sSDp5k=;
 b=DWfT3YaEVfzzyrnQYCe7cMMoreY8/iyDZJSG/5jeWy9t0EUGGOhzwXZvZxqEyg0OMnCtX5iRCes4U6GmIoO77IBQ2HuOz6iuL532JqdccEqnYJ5kFVy6QMkUq/TI352mpU5Pn/pDKXpIz9v8PFacYu43eMYx2Eb93DrbNRHB/XltrS/0oFqFWJUa26kuj1LghdmRJOrTbZR0yhhpLnV1s4EAJGGA0zivVEH1Nh3QZTvzmeKkVtnF4iBYLJatWOxLZu23IykNQ4kMMz5P8B2wOhI4jAKiBUeg76IX0QN0OJAEJoTMpbv54ahpzjUjxoCmpMhojhMJemQpNVohA8BhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 18:56:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 18:56:21 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Eric Biggers <ebiggers@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net] pldmfw: Select CRC32 when PLDMFW is selected
Thread-Topic: [PATCH net] pldmfw: Select CRC32 when PLDMFW is selected
Thread-Index: AQHb3ILAaZ0B4MFdJU6RCNqy3glUabQBcIgg
Date: Fri, 13 Jun 2025 18:56:21 +0000
Message-ID: <CO1PR11MB508949985925739C911F18A7D677A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250613-pldmfw-crc32-v1-1-f3fad109eee6@kernel.org>
In-Reply-To: <20250613-pldmfw-crc32-v1-1-f3fad109eee6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB7205:EE_
x-ms-office365-filtering-correlation-id: 3ffe91bb-ea8f-434e-fc70-08ddaaabfcb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?anZqc1NVU09YellzbmtQU0pkZ2tLK1kwWVN1L0puRUduV2N4L0RXcU5XSFhh?=
 =?utf-8?B?VTR5Y3ppV1lBWDc1TjdxK2pKTjR2NXB5Q2JmRmRNVXZ0S242L1hLNnJKY0Ex?=
 =?utf-8?B?eWNhS0pOMzJTMlYvNjZ2b2puak9PdER3SkhTdzJMak5rdit4VVRVTUJ5SUhT?=
 =?utf-8?B?U3c3WE9sVlZWTDVlTEFjNnV0amdnRzI1ZWNob2k1ZWhIVVN1bFpzNURkcjNw?=
 =?utf-8?B?UnNmYnpZeExKQStIWURWOExRNFlCMlBPVzlpVm9XbEpzYUlidmMvbXI2cVN0?=
 =?utf-8?B?VHc4QVlWcHhCMUtOZndxcDZsOEpSZkVnZFBFK0hCOHFsNjFIRCthNzZxd05q?=
 =?utf-8?B?MmpnNWZ5V043eHM2QnI4bFp3TlVkY2xaT0o4QVdtcU1JSDhQVUlzWXBUSXhr?=
 =?utf-8?B?cDRvenRwUDYzNDFCaHRhMmpQOXZ1a2diV05wMnU2VEJlWlYvYWVvMER5Slpm?=
 =?utf-8?B?bFdDYXduOEVUT2xOVFlWY1Fjbkk0bElyN1VGVkE4aHplbDUybE5JaVdocHcx?=
 =?utf-8?B?bEhGajhBYnI1U2todmhRcW5zTWRvRDNwckxKUUlzYTFZWHoyRjVkNWRPOFk1?=
 =?utf-8?B?c2RDbUdTbUtFTjFNN1VuQ1ZvVldWRGpQVFE5REUweEdUandzUlNGcmN5bWxD?=
 =?utf-8?B?ak9QeWU3b0pkeHI4NmVjNTVMWjlXUVg0aERsbWp0Z3huTGZQQnhvVkFyRklV?=
 =?utf-8?B?amVhTWpPTUplQVhLWUVqQ1VzWEd0SWQ5a3NWY2ozMzYzUitVM0NpalBNQmta?=
 =?utf-8?B?ZUcvckY0TS9VbkFkbERmdnVjU2JvUG9BM3lNcDg0ZCs5SGFuVzM2Mi83N2Zh?=
 =?utf-8?B?bkhtQVFVeEhkVjlWeWVRdCtWaEhxaDgvYjZmNTBjTUE2eW1wa2Vjd05mV25x?=
 =?utf-8?B?bVhKSTdFb2o1eW5adXpCZGxRcUVOYWhxZnJqRExlY1YxZ0dWVFZ2M0tmbWYr?=
 =?utf-8?B?bnZlaGNNY2dIakhtSldFU1lEamtxTHNuTlJqZ1l6SWdTRGFic1Z0NmJ0ZWkw?=
 =?utf-8?B?Mk5kTEU3R054Q2V0c0pGVm9Qdzk4S2RoMVNnSXFCYVk3b1hXNUloclk0ak9N?=
 =?utf-8?B?MXZldk03U0ZJZndHYTQ1UDM4OG5pTEVQSUozVlhIeDhvZzJtMU5qTWN1QjM1?=
 =?utf-8?B?MEhRU0RrNUNhUXdYMkxhNFo5ZktLV0FNNVZNV2V1eisvbi96YmdSUlJudmVP?=
 =?utf-8?B?TURHSHZmMm5tblg3bGtQM25kS2djODNuNXlLaXltUVlhU0E0cWZuSndvQS9L?=
 =?utf-8?B?dk1JMWlRT21jL2RGZWZLeTg5YmdQbGZqdWhtUXgwRXhpUm10TlFhVkljK3N1?=
 =?utf-8?B?b09PM0tpOGpFQk1LT0JwNysycDNpSy8vQ2VtUVJoMjFDYlFNbXNKcXl1Ty9v?=
 =?utf-8?B?Q3doTS96RWcyVSt4UDBhQUh4QzZRenh5QWRUR01DVW5LaGVLWjdKakdlVEY0?=
 =?utf-8?B?cDVXdUE4Q2MzeEszQVJMcmovMkZ3VitSZlMxbkdiWnJFSGh6alNIaEhReWQ4?=
 =?utf-8?B?TjdoZ1FRelpuWFdzZnJZWmNnWVluclhzUXpxbEVHeEdxZ0RhK1R6MGlkVDF2?=
 =?utf-8?B?UGVBZjhhdmlRb0w4Q0F3VVRNSllCK2pLaDUvNDJmcUdtbVUyVitSMCtIV2lE?=
 =?utf-8?B?MVdsV3VtcVg0d3pDb0Q2NVgvUWZCaEhsbFptWDQvU2xFRDhrb0NxUnlmbWp2?=
 =?utf-8?B?TWh2WjJubnpTak5mb3NQM0c5cWc3dUd0VENtZXVZVGlCbEtWRFJvSHh5MGIr?=
 =?utf-8?B?V2JNNlNmb1J0SDhkRmJ4d0hWcTRNM0R3dTliYUZTR1JzdFdCRTdhL2k4ajA0?=
 =?utf-8?B?ZkUyRTJCTlJLcjQ5bk1WWlRlVWNNQlBTelBhd2RYTjNtRU51Qmh6d3R2U1M3?=
 =?utf-8?B?Z3o0aDlHS2d5WFVtOVd2T004NCtEUlhwVVpiNEw0bFgva081RVBrMjNwMlZn?=
 =?utf-8?B?aTFESlpFTzJrb3h6cTNJZy9SbFo2WS9FdVJXbmZHRTJ5d0crWWtXN2dBcmgx?=
 =?utf-8?B?T25VMDZYUndnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NldWa2RoOERlOC9RNXlndHNMYVpsTkhnZ2VJbmRtU1IraGdXOVpPb1QrUzds?=
 =?utf-8?B?ZWdOUGRVbGRQUkw5Y1NmZHhOSFZSTnJyWThBcXowNkRjRUNMR1NjaXJ4Nm91?=
 =?utf-8?B?cjNYTFFrZVBjNk1uNHJ0SkVGVG90WDMyZTNGOFFBT3NuV3hZRWFQeWJlTmV4?=
 =?utf-8?B?Qk1MQlFvLzRja3pKdlBheVVOTFp0b21nQTZYOEdXUEcyYWJHZDhNdFNMSjE1?=
 =?utf-8?B?SjE2bWFnYS90VVRveEdGWGkveXZiYWxPVlIySW5tWDhIZHBKcUxsUnhNYUNJ?=
 =?utf-8?B?YVhWZitBN2RXRnJKODdYSWh5WTRRQk1VNkMvVTAzYXNWZ3VQRWExb3BzcUoz?=
 =?utf-8?B?MlBuK1UyQVVFa0o5UzFzMStGaTVzLzlqNXNhUjhYaXlRclRHMXFUaUpTVTJx?=
 =?utf-8?B?bUU0VHZQQ2xzRDRKUHMyMEdkYU5uKzhQT3ZHMWw5eG1HczdsNFU2L1FrWVN1?=
 =?utf-8?B?elI0elFBOGxWMHppQzB5QmR6L00xc3pHOXdIdTBEMXBIclViY28rK0NOL2lv?=
 =?utf-8?B?dTkrN0JTNUk2NXlmMTQ3Wm9WLzBxb2hWZUlPTFlaRmFjdzdLeWJaVUZmaXlu?=
 =?utf-8?B?QXJlN016alFWTU1PODkzTmlGSzJybUcrMTRad2hwZE80NldlYzlxTjJOekRk?=
 =?utf-8?B?UGdIM1pDeWVudnJhSmg0bU9XbmljdEhuR0dhU2hDUnV2NTBZYWtsaWE2NFpy?=
 =?utf-8?B?Q3YxTTVHQm81VVFBc0FGbnFra0RjZDgvSHp1TmJEVGZ0ZlNvSElrOXJla2JX?=
 =?utf-8?B?cERFeFFIdzNsK2ZWei9GMU5EQktFc2hseExXVElMTENEelFkalZ2b1ZFQ3Bh?=
 =?utf-8?B?K1Y1UlVKMGFNRmtLVmlleUwvU3VRUHNPclZaY1E5eUVzYmkrSFd0NnVEZFFR?=
 =?utf-8?B?V2lveUI4WXNxZGRtUVpaUm9wbjVGQWNrdStSbXZSSDVYVE00QXpVcThKcVpI?=
 =?utf-8?B?YzNqRUpqbTRuMXpoSEU4TGtDT21pdG1HditDcURBSDN6NjQ1SFlWS1BEU3Z1?=
 =?utf-8?B?RnJ1VUxFTElaT01TVWxzTkJHc0t6emtGUFNzQWloajBMOXhwbnAyMUo4Rncv?=
 =?utf-8?B?SnBTOUJlcytjRC9ZOEl4bGs3a0ErZHZFK2xEdy9GeHhtZUp3NHpLUWpNdllQ?=
 =?utf-8?B?Zm12S3Z1TjlscDdpWVNYTi9aQTNJSklwVGhFdWd4b1BnclpIRWNZN0psTUdr?=
 =?utf-8?B?NWd1b2xBYTY2V0VMVVFzRkpCclpDT1dEVmZ6ancvQitTa0RhZFBiRXcrbUcz?=
 =?utf-8?B?SmRVVC9FR1p1aWVUZlIzQVVnMkxUM1l5elRldU1iSlN5bzVRQjhCYzllMGlm?=
 =?utf-8?B?dzlBQ01vd1JzMEgveXZoQlF5OVdoVm1NanpKK0NVcjlub0RCUk11VS9relNo?=
 =?utf-8?B?ZkJVVEhWQzU0M0tiL05Jb0FkY2ZXbFlKcm9sc3B3UUU1RVhvalFTUXJkYU53?=
 =?utf-8?B?MDJQRVQzbFIwZ3B0OVFtWXlqeXo2UnVuZ0VpbHF3aG5sR2oyd3RXZmlSZjlm?=
 =?utf-8?B?VG01anVpTXNGWTBnUmQ4bVppdGdCSlZaRTB6Z3hDK0tLWngrQy9YblFUalQx?=
 =?utf-8?B?WTBsaU0rdDBwc24xME9sbXR1emNqSWhzOFY5RGZkbko4NjNOWlloQ1Q0Rm85?=
 =?utf-8?B?UGZtdnlJLzYvejY1d0dLZ0U5OVBCckt1OGcrNDRhOFpoRURwUXA1bDFEeWhB?=
 =?utf-8?B?cTY3VDhOaE53cm5XSnc4Z0VRclNna3VZckxrRy9NcVJ1QWdUT1ltUTQ1d0V1?=
 =?utf-8?B?ZVlwSGNIcGt6dEh4blBYeUJuTlFUQjQ2MTYrR0Z3akJoa3lvSS9nSGk0Z0Jr?=
 =?utf-8?B?ZjFWc0JpVys4SkVwejBuRHhpU0hCOXZvSlNDMFR0ZDMzKzlXdG5yQUV3YmlV?=
 =?utf-8?B?aHZZREZkaTVKZUh6VVZsYnV2czAwdTA4TzJiNVc3N1pRMmJjSG5yM3U2VFZh?=
 =?utf-8?B?VUl4UDA2SENNVFlUOGN0TThOSWNJbGZSOFJ6K0ViZ0lIOThiTkFZOEEvQUpO?=
 =?utf-8?B?VGJyeDN5aUY5QWNZSEl2NGF0MGZuRi9uaWdTcWNHVmE3ZnN2SFlMN1ViL1JQ?=
 =?utf-8?B?dGVMNGpBM0hEZTgxNCtZQUtYUktXZ21vakNrRXhtZmhMSUV5R0pyQlptUndv?=
 =?utf-8?Q?jJCGQPwGa/Z9hW7cpb4eMgTFF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffe91bb-ea8f-434e-fc70-08ddaaabfcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 18:56:21.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfJryKxmAJOXjkJAalvjc/AYZf4xlhSbRGd+ZF4TjlMIqUcsCnepDsv0TnyQ5loQ+0vJnEQELchby3HsxauZpOvVpDGsrB+diYDd7MJpjk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMTMsIDIwMjUgOTo0NiBBTQ0K
PiBUbzogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0
DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IEtlbGxlciwgSmFj
b2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgRXJpYyBCaWdnZXJzDQo+IDxlYmlnZ2Vy
c0Bnb29nbGUuY29tPjsgU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0XSBwbGRtZnc6IFNlbGVjdCBD
UkMzMiB3aGVuIFBMRE1GVyBpcyBzZWxlY3RlZA0KPiANCj4gcGxkbWZ3IGNhbGxzIGNyYzMyIGNv
ZGUgYW5kIGRlcGVuZHMgb24gaXQgYmVpbmcgZW5hYmxlZCwgZWxzZQ0KPiB0aGVyZSBpcyBhIGxp
bmsgZXJyb3IgYXMgZm9sbG93cy4gU28gUExETUZXIHNob3VsZCBzZWxlY3QgQ1JDMzIuDQo+IA0K
PiAgIGxpYi9wbGRtZncvcGxkbWZ3Lm86IEluIGZ1bmN0aW9uIGBwbGRtZndfZmxhc2hfaW1hZ2Un
Og0KPiAgIHBsZG1mdy5jOigudGV4dCsweDcwZik6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNy
YzMyX2xlX2Jhc2UnDQo+IA0KPiBUaGlzIHByb2JsZW0gd2FzIGludHJvZHVjZWQgYnkgY29tbWl0
IGI4MjY1NjIxZjQ4OCAoIkFkZCBwbGRtZncgbGlicmFyeQ0KPiBmb3IgUExETSBmaXJtd2FyZSB1
cGRhdGUiKS4NCj4gDQo+IEl0IG1hbmlmZXN0cyBhcyBvZiBjb21taXQgZDY5ZWE0MTRjOWI0ICgi
aWNlOiBpbXBsZW1lbnQgZGV2aWNlIGZsYXNoDQo+IHVwZGF0ZSB2aWEgZGV2bGluayIpLg0KPiAN
Cj4gQW5kIGlzIG1vcmUgbGlrZWx5IHRvIG9jY3VyIGFzIG9mIGNvbW1pdCA5YWQxOTE3MWI2ZDYg
KCJsaWIvY3JjOiByZW1vdmUNCj4gdW5uZWNlc3NhcnkgcHJvbXB0IGZvciBDT05GSUdfQ1JDMzIg
YW5kIGRyb3AgJ2RlZmF1bHQgeSciKS4NCj4gDQo+IEZvdW5kIGJ5IGNoYW5jZSB3aGlsZSBleGVy
Y2lzaW5nIGJ1aWxkcyBiYXNlZCBvbiB0aW55Y29uZmlnLg0KPiANCj4gRml4ZXM6IGI4MjY1NjIx
ZjQ4OCAoIkFkZCBwbGRtZncgbGlicmFyeSBmb3IgUExETSBmaXJtd2FyZSB1cGRhdGUiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpS
ZXZpZXdlZC1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNClRo
YW5rcyENCg0KPiAgbGliL0tjb25maWcgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnIGIvbGliL0tjb25maWcNCj4g
aW5kZXggNmMxYjhmMTg0MjY3Li4zN2RiMjI4ZjcwYTkgMTAwNjQ0DQo+IC0tLSBhL2xpYi9LY29u
ZmlnDQo+ICsrKyBiL2xpYi9LY29uZmlnDQo+IEBAIC03MTYsNiArNzE2LDcgQEAgY29uZmlnIEdF
TkVSSUNfTElCX0RFVk1FTV9JU19BTExPV0VEDQo+IA0KPiAgY29uZmlnIFBMRE1GVw0KPiAgCWJv
b2wNCj4gKwlzZWxlY3QgQ1JDMzINCj4gIAlkZWZhdWx0IG4NCj4gDQo+ICBjb25maWcgQVNOMV9F
TkNPREVSDQoNCg==

