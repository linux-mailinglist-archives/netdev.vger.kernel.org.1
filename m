Return-Path: <netdev+bounces-119027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D411953DFC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0DD283588
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610E155C8D;
	Thu, 15 Aug 2024 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5B68wDg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77C370
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765211; cv=fail; b=dNdhwGcqa+zoWXd4sYSLuwPptwEnjfoMTcUJSO6GxFG6yorTp6yusioH9oXrEl8pQg5D7Gi75tC/O/B8dhnN4SoOwSYG3GdVnYiiL39xunB+TVltXYfaKxzYg1frlf/+HLO8hUH6bsMl9kggG+G+3m285hVIOUNnkp9Sboo8Uu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765211; c=relaxed/simple;
	bh=ZXbLFLtgETekkSSE+fv8mZUdtMf8duYsJ/Z1gvqC/7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hn1WDjARrl4VgTb7SZffm+cxZjYOjw6AWgoKWcLcDQ2eNFFE7xiF7UNV6n0vhzDeCo+AdA1IgHaVu1nTzWGEHE1y4qYYb6HHGQNRxwSzg2eZqoOipvAyUMTyt7KR7P1xpr6CefZ3EUMYIBMX5xw2KtYCIvfqHuljCl9Jq6b+Vc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5B68wDg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723765210; x=1755301210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXbLFLtgETekkSSE+fv8mZUdtMf8duYsJ/Z1gvqC/7g=;
  b=h5B68wDgyI+Rxx5n7bnFMCh8Sb5KagmUn6XbJRz2JDgV9ArFdUCysr1t
   Mt/b4OkarYl3JaRTevuP0/m5ceRBOXvjDqgQTEMmU6DT0gpMTkZPObTnj
   nBZWE2790Y5i99X5EHd6Ks6f2EgNaWlR+C1aXmktjcOjyIGFr3xlpFkwX
   +Gucay4OZOmGCI82td+licJorERZe/zb6oDnOwif4PQEGl3Ofd3TgVQJ1
   VbvBu+xbJmUlKxhuUy8guaeh1hMlALHCozhXsHzjPjX8kM1tJepk1+Th+
   Aau/i9FC4F+30LKnbQbu6W7bo0iVYd9j13fKxTZmijz49BLB8K25P6GYs
   Q==;
X-CSE-ConnectionGUID: zWtWxBcQRGefs1NAqEqzig==
X-CSE-MsgGUID: 3pbHpBP4SwGAXGpyQ4kxmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21926521"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21926521"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:40:09 -0700
X-CSE-ConnectionGUID: w4n7SPIwRE2OkFFnjEljjA==
X-CSE-MsgGUID: pEPOHoy0RSK9o/41TvzZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59181979"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 16:40:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:40:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:40:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 16:40:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 16:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4ZtPvfZj5FP1sUuIXTlzMLbW83ljyNA4qU8d5HZ5Jenmn0HxjMSrEF17dOppDlOGlUvxo6mMFi0toB/b/oIouzcZBohgEl9U3QM9siUR2KPrLIIosrroOXr1s+jM3NKLxQsJoAg54JGwAiFJJqBZ0xT5N6GvqpD8Agj7M7ZAYbKrjIcyr+krtykDYWb91jw8fD3O7IQ78BHZn3lXzIIUsUBaFpJJ4MH4tO411cy7HoM7e2Oe23rqEM4peMRX9pUwHmekQd51jWI3fTziNGVHJERZg3FL9wMDPWLd/ncakK9cT258IAtkYUATw8+VKSYGN5Ayv+2Ct6vE5WMxqdQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXbLFLtgETekkSSE+fv8mZUdtMf8duYsJ/Z1gvqC/7g=;
 b=AXSliIBqTH/I28RacWF27/HDW9Ltwjb/ZfIbpORE+6RJa+r//SfQV3088sWUGs1WLXvyjRaUGQONjJxDp7JiKkDk65UQoxbsf4Am4rqjuQKIEbiO16cNuxj6r0k3Wj5SH43D5D70nfGU3o0GKKE8TLtqVEqIJibB2HPOWjKq0+96DxsmPZNsgl+QmJAB1eoPRMt6lQVoys3ZSMjswnlpcNZ9JPDwtLcVNWaG5XJ3fB1tizvRV80LeOZfLsosnqwXP6nwueqFIYmweX4OUvc+4/sETawM8K8VZDWuYYCiq8ywUshSjv9aAhS1tr8LeMU8XKOFiAOqcX8PGQqHZ2/8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 23:40:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 23:40:06 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, Sai Krishna <saikrishnag@marvell.com>, "Simon
 Horman" <horms@kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Index: AQHa7YHj8COFOXe30ECx/qIh9rmSL7Io5ooAgAAXFpA=
Date: Thu, 15 Aug 2024 23:40:06 +0000
Message-ID: <CO1PR11MB50890C2657DBCEB94CCFB826D6802@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
 <20240813125513.8212-7-mateusz.polchlopek@intel.com>
 <ae085a90-c786-52aa-2351-c7eabdc5292d@intel.com>
In-Reply-To: <ae085a90-c786-52aa-2351-c7eabdc5292d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SN7PR11MB6557:EE_
x-ms-office365-filtering-correlation-id: fffc246e-7200-4c4b-68f0-08dcbd8397b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzByNFFPYjk3bjV1dmc1Q0dINjBvVStiZUxtQjNTZVJEZUNqbFhlUTVuQm1H?=
 =?utf-8?B?d29OcDBMZjc4UDlodlFJNzNIdm9Tbi8yVFprWElSTTZISXd4WTVtV1RLVi9M?=
 =?utf-8?B?aG9SRG5tZWF5T2JHL1ZXVTV1RENZNFVWbURqYVRodzh4UXFPUnhSeDBXS3lR?=
 =?utf-8?B?NkZzL3k2ejhIVndFWVlITEszOEVZak1oTzVUcTRHTFh4RW5ETXJUUVltMTVY?=
 =?utf-8?B?eDhmRmlQQnBRRXErZ3o3YVNKVHI2TDJoMk9aWWlpTDFILzBzdWJzN1NKSFFB?=
 =?utf-8?B?YmxBc016TUdyWEVhYyt5MTFjQTFuZUdqQWdxVDVXcUtva2wyaDl1OUFiMjI2?=
 =?utf-8?B?NVJPeTJTcHNVemp1Yzd0dm8zQXVTaFByWGFRenVWbUxLOGdwSkNXWDNYZDIr?=
 =?utf-8?B?c3lMMW5rNkpTYnpkUUg0bU4wbmNjSUtkcGJ3c092UytEb3NicHpZWi9DR2ht?=
 =?utf-8?B?bkRxR0F1WStZZzJxODdtLzZVckNPQ3RObTZWK0xKRE5XZko4dTRjRkJjNysx?=
 =?utf-8?B?ZnJWSXBIYVQ1Y0FFMVBPRWZKbmprNGdUeHJMenJVVlZORmFnN3I4bkp0OGxX?=
 =?utf-8?B?ejFUc1NUQWRFbnhjd3pYNW0zdEhYaDNyV0JpRGN0QmIyYVdQNzk4U3RVVXdS?=
 =?utf-8?B?ck10cTUwY0pwVHo1WWxBa2trQUpncC83blcyblNtUjU4YWRrWTlMN2k3Nm8x?=
 =?utf-8?B?cUpDMTF3aEtTSjZDaSt1YlI2elZRSGRPNW9vaDl6V3FSYjRBNnJCeVdKQ3hl?=
 =?utf-8?B?bDJYMHJHcTJRWXhodHg4KzgxN3c3enNjSGhUdlhUbXMyQ0hSNFBUQjFPS1lt?=
 =?utf-8?B?NzBjNU1lZ01XeEx0ekppbjR2TkdRTjd4UjFmQjJyVG1TK1I4bjBvbXpubkFp?=
 =?utf-8?B?dWpoS2o4b3NZTjlNeE8vVmswQVFGakxxK3g3MW9ENVV1VW8zdzhmdWtrZkNl?=
 =?utf-8?B?azVuK2pGZmVnVkJKRkg4NkVFQnZKODJaVG4vbmprVkZUVnFjU0JTWjlyQ0ps?=
 =?utf-8?B?MkJnOWNSSjdNejJXS28zMVF2dXBVU3pseVNlaW9xVVZTRjBwbnpDQmlaUW5B?=
 =?utf-8?B?cHB6N2M0ZzZwSHpNd2xUVDlGRmhiY0dvdzV2RE8vSVljaXRzVkhVdityMGc3?=
 =?utf-8?B?aFduVm1hU0FaQkxaeTBEUFJ4WXN4aXYzZllrOFRSWW1HU2F3YlN0ZTNLMlNH?=
 =?utf-8?B?WE1scjFCa00rVUFSVTc4UGt0ZjNhYzVmYVN5bmFCYmE5WC9PSy8vMG9vNUZx?=
 =?utf-8?B?NkpWaVBvbk5GV1IyVy9xcHQ5M0pOL0E5a1lsYnNncU1zRWZmOFJkdmFYMnhS?=
 =?utf-8?B?TjN5MVB4QUNkSTE4ZVBEb0xkYjd0cW5yS1I4Z21YYVB0ekMvWFFBTVQrc200?=
 =?utf-8?B?Tlg0Z1loMGd2L0dIR05FcklYM0ZsKzR2Qnd5cEpWTHVYN0paOEo1YW1pY2do?=
 =?utf-8?B?YVNEa3ZvbnBIL1B2UENXTnZQbndreXlYNlJiand2T2xzRGFXWU9scDVYLzRz?=
 =?utf-8?B?MnBZZ3BOMWR2aFlnMWVQcndLclUvbDV6K2Y3ZFpxclI5dXJhQXVBbEpBZ244?=
 =?utf-8?B?L0xTMnFoMkdVUm9CcTVPTFpEOHJsZXRVRC9pajdZQ2YrZHBOY2orZ0s5MXBI?=
 =?utf-8?B?UHR2Z3RSc0p1VTBkM09weGp2QmVCVUkyR09BRjZ5RWdibVZoelFzMjV6T3FN?=
 =?utf-8?B?ZXJXU2pkRW1XdjExU3dSR05aVXJmV2pBdVQ1eFM1eEYwS01CNkRMY3ZqeU9a?=
 =?utf-8?B?Z2NaNjBMbWhnanBCU1RMU3pEL2JRSlFScnR1MUo2eDQvS1lUUVlQVUlsS1JE?=
 =?utf-8?B?MjhrWTdCc1k2R2YrOFo0Ny9EY1FpRzNEbitOSmZsN0wxSEtqS3kwT0RiTmF0?=
 =?utf-8?B?VWFHZ05EZUZwYXpLUXZpalI2SStjQ3hEUzZ4SGNwV0s2d2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDRVY1ZpL0tJMVBvZ1NaTkdPM0NiWGRodXQ4YVJMRldoeUJ1b3NIamtKYXE3?=
 =?utf-8?B?b2MzUjBJbG1JSFZIUnpadUxPUHhqS0JDUXowUCs3OGo4aUJqaEhlZmR4OVVp?=
 =?utf-8?B?MHpsellIeE5iY3FzczJnbEowdkh2Rk1oRWFqTmJxNGNoK2tacnpES3BhaFhE?=
 =?utf-8?B?NDMzdVo5KzBlRjZCQXowZCtvV1VPUVFYcWN1d282QWplelRRb01lN0E5ZGo0?=
 =?utf-8?B?TlJjNUhNMU5pb2NNTGZkcW8rRExTd1lQM281Y2ZoZWN3Y2hCTE1YcmtjN1pV?=
 =?utf-8?B?aGRzZTlHQkkrMWJOTGxrSUlKcWJqVmRZNHoySE82cElmSEZ3WHFPbG5GZHBV?=
 =?utf-8?B?N0wrVlhTU0tnWjVKbFNUWGZCTEZ4eWgzWnkvcDRXZDhIbnRCOFc0ZWZuNDZS?=
 =?utf-8?B?eGZCc1R3azVVZ2V4N3BoWFhzb1RmZnRWSWUrdEFUNGRadmFYcHJUUGNZYkNa?=
 =?utf-8?B?TjNORVBkQVc4K0VzdnBMM0JXc09GVy9lalBoTnFOY0JRbG9ydGl2QTU5RSsr?=
 =?utf-8?B?aFJlcTJuTnZmTGRqK2FmbVRWaStqR2F0a21aVWU2SE13ejNESVN2eWo0SEVR?=
 =?utf-8?B?UjM2TjQvenNHSzY1Wm5FdzB5L2IrNm1aMGE4S1VZUThST3VXM3g4cGZxRldX?=
 =?utf-8?B?eHluZmlsMUpYa2oydVJMbTlvYWVWWFlmNEZobFpPb092aWgvV0xBMXRCNUds?=
 =?utf-8?B?SWJsM1RRQU40aTUxTUp0V0N6NkRYYXBLWFlKVWVtRkErMXFET3pJSWtPb0hR?=
 =?utf-8?B?S0xhYUZmRDFZeEJMVU8zVW10Vk9XT2txR3Roek1VV25tQmZ5NG1Fc3ZaM0hm?=
 =?utf-8?B?RFhZaWlsUUJYNTlMODQrSzV0SHMvcXhMelczcThHcG41K3BXY0U5dlZIeUhG?=
 =?utf-8?B?a3htbXMrY1NTcHdwcEJpcUc2Z1c5UFBWQWdLODFpSWtSNmpjZWcwVVF4TjJE?=
 =?utf-8?B?dFh3dnV0blVRYmlSWGw1S0Ftd2FOb2h3VkRhZ0JGZ291SE1wR2F3cVJLSGN1?=
 =?utf-8?B?YktqZWtmS2NsWFZrQ3hQUGJVT2FpaXlQeVBpWWtaaXBsSlQ5RG1FaXJzU3dY?=
 =?utf-8?B?NlVyRWkrTU81ajJFdWc2ZW94R0ttMlFNVmhnbWN6WVdPdDJDWW10RGJybEQ3?=
 =?utf-8?B?cXJBMEdoeUQ2empwYjNzYkJzM0FnT3FIcmpZZ1BzQ0hxZFREbnhLZVR2UHRU?=
 =?utf-8?B?TG8zelJTaktYQkcyZSt1R1YydVNrRFh2cSs4ZXBWNWhEdTF2YUpTai9VckEz?=
 =?utf-8?B?SkhJaEVTTVVMTXYyZmx4VjVxWGR2VzlpOE5vYk9WQWxjeGdjRld1bFpPODdM?=
 =?utf-8?B?a2dvNkwwSzgyYUpNVVM4Q2VURTlnU0FoVlUzRjhxYUFDOUI0NlN3N2QwckJF?=
 =?utf-8?B?d2JnR2hjRWFvRXYzc2FLd3I0emJmVW0vRi8rOVhseXdGU3lIMGZ3bWcrRnRO?=
 =?utf-8?B?YzZZZVpXMDEyV3p6ZXNGcnhEd2R5T3VWd2xYUEZNN2lrZ3ZHQUZxa1hpT3FW?=
 =?utf-8?B?MVNMOGJXMWlpTEN6N0NhTnNUUlNMMDhKTURJS2U0M25MM1kvWkJwbVFpbHpy?=
 =?utf-8?B?N2YyYStuTDc0VnFFNEpqOTdPdjRoWUpnMmQyVHd4ZVNVNU1sNmxSdzlXU3Vj?=
 =?utf-8?B?RWJ6L29MdHF0WFdCeFZsKzFnL3JlMHRmODByeXBwanQrTmxsN0FoNnYydUls?=
 =?utf-8?B?aWEwK0ZHTHVBdUpyRmllWlR0YlAvSENYSHFFUWFmbGRuS0tEa0pzR0Jxb20v?=
 =?utf-8?B?YzZXcDVKZVUzT1lEUHlFc1ZYTzhHTzkybU8zNSt1aXp2ZTF5NDNPbzdkWmt3?=
 =?utf-8?B?djFnbFlJcFN1M1FXUmlsY1V5TmJrbHBRbk5yVjhielhzeEQ0U056ZU93SHgz?=
 =?utf-8?B?TUZpWVkxSlB3SGIvdkdSS1VyWklUUzV4Yk93R3V2L3YzRlFjVUpsRFJCNWZ5?=
 =?utf-8?B?Q0wraHU4d0ZacXptNHowQmlFUGw2MUhYLzV2NjZEVnNQampaZXliZ1c4Y0ZY?=
 =?utf-8?B?MG5FWE1hK0JXSVZUb3YwaHduRjlScTYvTzlIY0c4SUZkZGpMak9sU1pXMGxI?=
 =?utf-8?B?M1dTUHRqZTBvdHp0eXl0V2ZjVVpjQ0VTT1R1S2tTVEZSR08xcHJqT3Z4TUxj?=
 =?utf-8?Q?eLlYPZxydu8vzH5hPs1hbIWAm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fffc246e-7200-4c4b-68f0-08dcbd8397b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 23:40:06.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hn0ZpfuktiSroJfbBQpek5K/CDwZbzYsF7duI0Arlv4Ru5bBhMAFgWvOt6sE+I5CQ21KRNQmAExsQ7oIyoN80Kvg6dx6pcigYmLtk56wXzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmd1eWVuLCBBbnRob255
IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0
IDE1LCAyMDI0IDM6MTcgUE0NCj4gVG86IFBvbGNobG9wZWssIE1hdGV1c3ogPG1hdGV1c3oucG9s
Y2hsb3Bla0BpbnRlbC5jb20+OyBpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmc7
IExvYmFraW4sIEFsZWtzYW5kZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IENj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT47IERyZXdlaywNCj4gV29qY2llY2ggPHdvamNpZWNoLmRyZXdla0BpbnRlbC5j
b20+OyBTYWkgS3Jpc2huYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+Ow0KPiBTaW1vbiBIb3Jt
YW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBaYWtpLCBBaG1lZCA8YWhtZWQuemFraUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjkgMDYv
MTRdIGlhdmY6IGFkZCBpbml0aWFsIGZyYW1ld29yaw0KPiBmb3IgcmVnaXN0ZXJpbmcgUFRQIGNs
b2NrDQo+IA0KPiANCj4gDQo+IE9uIDgvMTMvMjAyNCA1OjU1IEFNLCBNYXRldXN6IFBvbGNobG9w
ZWsgd3JvdGU6DQo+ID4gRnJvbTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5j
b20+DQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lhdmYvaWF2Zl9wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lh
dmYvaWF2Zl9wdHAuYw0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IGlhdmZfcHRwX3Jl
Z2lzdGVyX2Nsb2NrKHN0cnVjdCBpYXZmX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBwdHBfY2xvY2tfaW5mbyAqcHRwX2luZm8gPSAmYWRhcHRlci0+cHRwLmluZm87DQo+
ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmYWRhcHRlci0+cGRldi0+ZGV2Ow0KPiA+ICsNCj4g
PiArCW1lbXNldChwdHBfaW5mbywgMCwgc2l6ZW9mKCpwdHBfaW5mbykpOw0KPiA+ICsNCj4gPiAr
CXNucHJpbnRmKHB0cF9pbmZvLT5uYW1lLCBzaXplb2YocHRwX2luZm8tPm5hbWUpLCAiJXMtJXMt
Y2xrIiwNCj4gPiArCQkgZGV2X2RyaXZlcl9zdHJpbmcoZGV2KSwgZGV2X25hbWUoZGV2KSk7DQo+
ID4gKwlwdHBfaW5mby0+b3duZXIgPSBUSElTX01PRFVMRTsNCj4gPiArDQo+ID4gKwlhZGFwdGVy
LT5wdHAuY2xvY2sgPSBwdHBfY2xvY2tfcmVnaXN0ZXIocHRwX2luZm8sIGRldik7DQo+ID4gKwlp
ZiAoSVNfRVJSKGFkYXB0ZXItPnB0cC5jbG9jaykpIHsNCj4gPiArCQlhZGFwdGVyLT5wdHAuY2xv
Y2sgPSBOVUxMOw0KPiA+ICsNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihhZGFwdGVyLT5wdHAuY2xv
Y2spOw0KPiA+ICsJfQ0KPiANCj4gY29jY2kgcmVwb3J0czoNCj4gK2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lhdmYvaWF2Zl9wdHAuYzo0Nzo5LTE2OiBFUlJPUjogUFRSX0VSUg0KPiBhcHBs
aWVkIGFmdGVyIGluaXRpYWxpemF0aW9uIHRvIGNvbnN0YW50IG9uIGxpbmUgNDUNCg0KWWEsIHNo
b3VsZG4ndCB0aGlzIGJlIHJldHVybmluZyB0aGUgb3JpZ2luYWwgZXJyb3IgdmFsdWUgbGlrZToN
Cg0KZXJyID0gUFRSX0VSUihhZGFwdGVyLT5wdHAuY2xvY2spOw0KYWRhcHRlci0+cHRwLmNsb2Nr
ID0gTlVMTA0KcmV0dXJuIGVycjsNCg0Kb3Igc29tZXRoaW5nIGFsb25nIHRob3NlIGxpbmVzLg0K
DQo=

