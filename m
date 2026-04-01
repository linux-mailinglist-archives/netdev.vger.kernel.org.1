Return-Path: <netdev+bounces-273894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCovBMSszGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 784BE374E52
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F94230166E3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78537E2FC;
	Wed,  1 Apr 2026 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hP7YMKTB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC337DE9F;
	Wed,  1 Apr 2026 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021249; cv=fail; b=UcDmdxeLXOV5f2a2Dtjn3tIdS0a7i9ghIGRHsOFmnlgyLa4PIVw8MpEJc9t72CZmmp3PP6o/3PTqsQbEHX9P4Yoqw8HARk0WKp3iaoY42nYHcjGbX7lvleCu8gVVFOL282tgdLQT1yTpp3dh+LuPQrcgozaHoknyaniLeLw4kUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021249; c=relaxed/simple;
	bh=JLpwSPZvMEdWMjU5+ANSArZ9OD8S5zoin0bX6pPuCyA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=W8tYzVkpNciKAd0bRZcgPPHCUx7y4dQM57F1UFjus+0jGd3WK4sBtf4uGmkIpAXAVIHUcb2LMpIrlXW0l3J86hioueQakJfhoehvBfxjFs/Zfv82rXoHejOyIXiAw8TlULqkw7l1ovW29w2JLPzc9rfTADkAtYG2i+ttzr3SkDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hP7YMKTB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775021248; x=1806557248;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JLpwSPZvMEdWMjU5+ANSArZ9OD8S5zoin0bX6pPuCyA=;
  b=hP7YMKTBYCw0pPDSgLMXzGnfGo6FxmEfrR+YK/qb9FDeWGSRCvpPZ0eV
   opeQe3boy7Op8O6WP06uZHb9vXfTUK/ASse6Y1ewwQmssQhJHrPRdnOti
   1cW4nMueUzn43XlS4Vto/W0IJxicTUiWyCEJueH2t4fnQPxJWYBPxk4H7
   JcAMJYYmtRA3PZ9sDUfkD0p41FprR/02elBcR3aTAo++PQYs8ycooRLjw
   F6mI5blaDkbYT+OZxnIgcn0wRAv6F4B5WgXNN5+SR5wPXeTW8aYqd5lP3
   7lKImoFm3O0k399D0d0ttAW0UqSitTYmylBlZb5MRC0PjcavI6/Tqrcig
   Q==;
X-CSE-ConnectionGUID: l3/AbrpAQN26MY+hvKFP4w==
X-CSE-MsgGUID: ub1T4CI+QJyIreXvYn0BgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87125780"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87125780"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:27:27 -0700
X-CSE-ConnectionGUID: Lod9gg2hQxiZcpnsvooM3w==
X-CSE-MsgGUID: mstT4onDRUSF7mcETKFtDQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 22:27:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:27:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 22:27:27 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 22:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/eJStTVAm+Sz/WqzgFmL1J7y72IJGWU6uURznp6N5KfH5k5WtPogAGZ1h6EeikrZHucpUmKH/PYZt4SU/CkQUA4eA+OZ+PxOVcX6zPyIwziwtgh6053wF+G91G9hgzamR9BfySEoBkgT3wd72vnAAd4vYHtREcXV7IjYNuGyilCbu+xKh3/lquqxIvPDZDaNChuD1yVREOEuDxQx8dtxCDR9Ug9BBK0PTTxOqPZjUn7DPv4do7j7MXnKdt/jFt3lqBXcQzF4vTJNkrQIzEvqhlEhEoItOT010MhuetJGKuGWG6izd2lOmKkmvhUIED+2+ulqWpFgJfeKSollnGKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3weVUg4GWwryov9D25qSy6GsVCIuuImOx+yckI3aDzo=;
 b=oVnSapPYvRjksbZpn8T35qgM4jlaMcKKKM4lWys0i/jeJBMGcUkuNpvAsWIl3AaBCinRE5+A99ZtVKbtx89HrSFTT4QeCZ4m/eX61If4izsuxgvvbZBpHYA3KXzE8WusC4o6UoJq/VGQ+Mf1dGVD5dM3o07+fFqQkNzoD9Gdjb5Sb+A31GS422u8Nj/GABIjktm98gOOVJD23NdHGqf+D66SV2t5DK0/6NFOjnj4J9uCxWSxlQrOXuwXgLgZNL3V403p+hRVoCo1G3Aj07SnRqdDyUOyMWtStZgSM2uBi2CriBS9oqZk5c3HWZdh6esVqJFSSljgb3OtUpB4fG7SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 05:27:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:27:22 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2026 22:27:19 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Message-ID: <69ccacb7961fe_1b0cc6100b4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-11-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-11-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 10/11] cxl: Avoid dax creation for accelerators
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ef1036-35bf-4604-87fb-08de8faf59dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6ZcDBGCBSLPgFFfFsIz+MNHVDHju4nUiNh17+WFs8TwR78Y9mMtxHPkgMV20d9NHkuP6nKkMKlcvhsLVAWwVAmlkeo+QnbxKF8cn2DGJOMayItIU4E89SBzZgJWobikwnUQFDzM7fe9vs9BNFdgyX0BMRfNcajSsBEBRZ+typtCwGTF4ey82DCx/v7XVG1T8VsHsK1t7ecQGLsFCtVg0AyatsT2NQRlRF0/NbHYimDBMMcPbG4QQWKdODx2q3TDbUlEyXL90gOTauILlrk5xtud/WYa8f7sbmj9ztMR8l/DQFLP6ptdUn9+FkRzJt8PrzGot9mZ11btu5uaDsrqtiXqDlmmkj+fkyJsYquvFwP4S1Sk3/f72aj5/n4RB143I+891xs+gUBRn+gxozIWv8UUIdo+BgUJrAfL8M1NRONY1p/6KTdQPJajLwicF0v8kRjHAGbDahrhgNea9PdpoaJ/exXtFfeB6zNl8uiFpl1fWe7ut90WHymQrUxZBYPHS/MmaGX+LR/bEYNjqPSLxDqEzgHP1kAY5NILmC5YdDJPcZBsLY//OBIJq1aBeMJIst5fkTDQXHROyMU7GS2OigDBQWDmWmof9BU73C3HBC/I0lcYfZ3nbAQVzW6h+JiyMMs8wp7CEqFAWtFgm7eBy4+sGm9BFpU5OiKMRwxKkvf0RmHKYGYuO+P0r27BpldAvV3vgOXtEuuo/ZQxGsyaYcmjqq48/wFJGWZ66l4/87EDhM9/tuPbyOiYnoHvD6eQ5WqsOKNRKWCis17qce0KpuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFpkeEl0bmdsdXRqQUdyRmZHeUQzNGpJSGRFSjQ4Q0NIOXBRVXNvSVFoeTNz?=
 =?utf-8?B?N0sxZldrSlFUQTFXOW44eHVKdXpMUFJuWFNZekRxRmZsTnZPWVUyOHpaTkNG?=
 =?utf-8?B?ajNDcnhsNXduMzkzREJqSGdGdUQxY2tjNm1ISzhwNk1LLzlsVGZXa05nbUQ3?=
 =?utf-8?B?aHM3WlhhUEZtdjlmWDQ0WFRjazN0ZlV2aUZzYTMyeEt5TzFLMXcrN0RwbFI3?=
 =?utf-8?B?TWVJcGpMTk44ZGtLalpLZjNaL1hzQXBBejlSQ1pOL1psQmN2N09nWXlHblVR?=
 =?utf-8?B?dEozeFRMS045b2NWd3c5L3VSRG0zWWRxODg0STlvSFpmWU5oUjVLSElZRXRl?=
 =?utf-8?B?Z1FNRHlPck52M0E4dVU0aE5rTUVIMVpVbXdkdi85Z0NHelNJdGtsb0ZNMXFN?=
 =?utf-8?B?N1Q3STYwTFZFdDZjSElpOGMrbU5BR0V1UGlxalkwVjkxRVg1RjJMR1FibGVq?=
 =?utf-8?B?d2JaOGNSSjZpWjVON2M0VU1CVUFjY3VQckhzRXlXaGw4bExQaUh5bUNvelFn?=
 =?utf-8?B?NndmalR1bTl2cXBmcUlEOVBNTFlzdkVsMkV3QVM1WDh0TU8xTnlJYWVOcEpY?=
 =?utf-8?B?Y2FqTE14Zi9sSU5XM1Vja0RkQlluaGdrQkczMnFlc3FNKzlBakV4R25FVWtE?=
 =?utf-8?B?RDZPL1ZIYndRODVCbnBkWWN5bEVzVkROZUJNZ1FVLzlFY1VpQVdjaUx0VDF2?=
 =?utf-8?B?QUZ5bTloNW9PcWNjbU9ZZ3J3b1ltNWI4UmtSb0lFK3BQd09iVTAvbDVHc2g3?=
 =?utf-8?B?QVRxTFBBTDhQeGdMcDNUckdhSXc5U1pIbWtzWHpNcGVsSFNxTmxqTnk1QjVR?=
 =?utf-8?B?ZUhobUZlaWg1RFE5U2ZzQXFyNUg0MXhVQVYzVzdMb3kwM3hYcSszUlQwR09X?=
 =?utf-8?B?TkQ1dFFCaG1rUTZFcjJhQzZ3VnkyV0lVOTdhNVZza1ZqUEYvRkcrVWUraTRI?=
 =?utf-8?B?R3RvaUw2MGFQNE1PaUY5aHRtVDljd1BITHM4VnAxOTRZWmp0ZU5Wd1BRc1ps?=
 =?utf-8?B?WGphOXBGcnFEbGMyWDlBa2w2SlBXRlJCYkdJRlpLMVVrWmlCWjUwb3gwUEsx?=
 =?utf-8?B?MDhUY1NQL0ZvL2t4Z1hwbUZyNzhCS3lrVXlDU3pHM3o0UWNHRUVXblRPVDZK?=
 =?utf-8?B?R044MFozcW1oMUd0eUpuSFFIcHV4VGRweUd1NndXcFNGTWY5TzhlL2hFNFVU?=
 =?utf-8?B?WUFOZnd5czdmRlErdkZGc21PWENJWE9pSW80OHA4R3lDU2p1eUMyMnFuRWJa?=
 =?utf-8?B?ZVFoZnM0UWg3MHY1ZTlXdDRvNklLYWRXUXM0dzRLUG9kZ29FTTRZMk1MK0Ew?=
 =?utf-8?B?MEhMSWpyUGVRMjZCUi8wMTBOd205ZGhCSFpyOEhNQmRkeFI3L1pYTW5ZZUtH?=
 =?utf-8?B?WlovazNBaFUwZTJBOUkxSXMwWEExS3ZiUW1xSm5BYWJKeFBIKzkvSzhPMmZT?=
 =?utf-8?B?V2RjTXhITFI1ZWFsWWlKMlg4VHAxb24zNThYYkZwYW5uWnRxVU5ERHNZdEVW?=
 =?utf-8?B?d3R1ZVZPYWpTclNSSHN3THRiaWhNWlZMamhsVjAyby9WOC9EcDNnQ3Z6TmNk?=
 =?utf-8?B?YVNZdXBJcXdENlhFeXBCQUNld2creHFYdTI2S05QejZueXpKTjJIZTc5ODc3?=
 =?utf-8?B?dXYwNk15TDFKNHkzL1NIeFJRbVRpK2IxNkt1L2JqN3A0RWE1WlBZWmpXSVJU?=
 =?utf-8?B?dDdsckxneit3cDVJZ3k5aUw4SE9YOWJTajB5MGpQRHcwYk04VkUreER3TDVv?=
 =?utf-8?B?WFFzckFxdFFYa09Fb2l5WTAyeFhhTnJBNzlCRUFtWWE5MllXdC9GUFk2M0Y4?=
 =?utf-8?B?VnppMXljVFRhSWdwcXFDTVVlSEliSWN4djk1WmRMVzdqUEpUeDRxMWtvejVw?=
 =?utf-8?B?d2pUb3BRT3JhaGwyTDhFL1ZlaUd0Ymdlc2pISVkxR3BEeDZBSmt4TFAzTE1Y?=
 =?utf-8?B?L1V6SDVqR09ycCt2SnIrcDdVNHQ0YXhSYUxid1pNTWtaNEFCeTNmUE94WW9Q?=
 =?utf-8?B?QnVQa3VXSVdtOWlTS0xjSDRJL0xRWFQ5YjlVVERnWi93bzVjZzcxaEZxeFBG?=
 =?utf-8?B?UWdxVU5CRm9sNWVLYklna0l0d21KNlJLTXpLSUh0NFV4RnlBYVBWK2JPS2FY?=
 =?utf-8?B?WGFDVmNVS1FFeFR2NjllMndWRWJoeE1aY1JFTWNBTTBUSjk1WXZObDhrZ3lC?=
 =?utf-8?B?UjRFdzdwZFcySzhPY0lMd0o0WVo4TlR6WGFCUGRkbXJaTE02WUdiaVBxdi8y?=
 =?utf-8?B?VUlWU2l6Nkd1NnVid0FHNGpLeERhUnNtZGtrcXRDTXlCMlNaYUFQYU5nL2FS?=
 =?utf-8?B?OWsvT01aVGd0WCtWekU5NGRKbHAwTE5tbG1UbFU2SFVEb3IxZHVUMzdkRzVP?=
 =?utf-8?Q?TtM4KKOMqCxcJPRs=3D?=
X-Exchange-RoutingPolicyChecked: ngpi4gZ4jZ8MlQzpGqh0YISv2qKbS3XPeka3zGnNcs62RusLMrGNOAOP3sjOxmaEIZ03TKXLbatiYRjbv52nI37A/5XAykOHO47VMd23vYdh+8pO01yomZkVnnuKNRgCi9s+voDGCykUxhkVkbmiGc7HeTWnWa4PPuragqdQodLTM6zoqdE3mfos0P1RqPbIoIMTxsUKVbvHMTOT0DLQ6iin7XMOex6MpHD7qp7DKOf6o1YEI/lIfOqqtQ1GWxHYRVbIhfGigddJeP0dbIlqNuGLDoGcukqWqIkBQ5PCsuborNtxDQWHP07G2VihVsi+JZYN+dYzkyVy70/4X3gixQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef1036-35bf-4604-87fb-08de8faf59dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:27:22.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWHNcEy+Ere+QOYYa487GWEubeZoeRmVssgiH6QiRUbsJzk/KAlZI08UcIyEOb2rHAESHVtufZMHpjvH/xnZJV3JP/SDTncpZ9NPSbrEKxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,huawei.com:email,intel.com:dkim,intel.com:email,stgolabs.net:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 784BE374E52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses like DAX.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b3a6d08be461..6a89a1817199 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4264,6 +4264,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;
> +

It is possible for a general memory expander to also be
CXL_DECODER_DEVMEM. Imagine a memory expander that could back
invalidate on decoder change. See my reply to patch5 for the changes to
cxl_region_probe() when an accelerator driver wants to own mapping a
resulting region.

Also note that cxl_region_has_memdev_attach() arranges for memory
notifiers and poison to be setup. This is for accelerators that may use
devm_memremap_pages() and accelerators that may implement a full CXL
mailbox for whatever reason. A CXL mailbox remains the only generic
mechanism for determining the DPA layout of a device.

