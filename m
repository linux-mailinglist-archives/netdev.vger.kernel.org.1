Return-Path: <netdev+bounces-194324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C95AC886D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81AB3AB25D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 06:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225819B5B4;
	Fri, 30 May 2025 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3ioyOLP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B920D51C
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587961; cv=fail; b=HSV0PWVq55Y/TO7lUT/g1h8vIyRY7a21ZnHMYjFOJU7F0gGcoPwgjqEFSQKyx7oPFJwdo2S5EI9mYU4mmaBJE0FbefFZUvY1dmdBvm2ue9k0CVMsxV09cX5NUMQ7LPWVBcdwcIbIYpiPAVsRaSxeO6XWDo+MF+MOeai4k3df+4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587961; c=relaxed/simple;
	bh=fwk0dySD+TPrVjb5dWQNc+hStqh62oVcLLdF6FV7Tvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+YUhcoCEXa3yzECKC2PzHoM7uYwWcx4MbJEcPj0A8uHmg5Q01Zqw+gxYCr2H4aaz7s6wlSbn34n39WvIOfBe60NZiEJCf11YCanA5+VZtGyQxQ2/aLzKbB1mdaWc1WPwl5cHKEb9aORH18HBA2VvnCMRxnr4vtxinqfdpsiT94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3ioyOLP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748587959; x=1780123959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwk0dySD+TPrVjb5dWQNc+hStqh62oVcLLdF6FV7Tvc=;
  b=F3ioyOLPCqTOzatDQtqQZmRQYYwIOC0ABWEKuwHd/LyyA8dqqYqPtP+W
   93iiMRIfj7i4ljdbPaAX9VXzUURffuEDIkoKCz8Rd7uRt4S83xOa8bAf3
   xVjZNV9A6wAu9OcNLJ94pqminTe1Ufh7AeqxLqdkMe2aBHjl8BCKVEx3z
   iC9bXcdt6l1JTPdN2rJF9ya8sfG9C13AhwKOafTs+wy3j4thDui7x2uqA
   +de+GpZBitZYJmt3K5tkGrFPxZl8wVpEwDFAeuGmnmcFNitRvD+MlLuJ2
   ZFKObLOXZ9yWY7FbpvOVUZE48tZQOt81RN0VpF4Y2rWEH8ep3b0xvi19L
   g==;
X-CSE-ConnectionGUID: 6rUVeElhQP6a9voMIHFJSw==
X-CSE-MsgGUID: nA6nwfTdTam7AOQ2vPIv2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="68224484"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="68224484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:52:38 -0700
X-CSE-ConnectionGUID: M9oErAuKR3KyFdncm+vuoA==
X-CSE-MsgGUID: rwoDshojSQ6lReXqkZmV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143614362"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:52:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 23:52:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 23:52:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.64)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 23:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZlZZVuptCx7A4P4K784e/Ub9LFcjKoXNsiPKMT486tSQyArJZ6FxfTdCEp49ygpqF+wLZnSR3tqdA0nGJFzBQ1SsVnwJRCLZopK48ZlfQdAAbSpvHO5SeR+db0CG/pDx+GNwJdQYvL2EfahT+qubwDMWnDo1Z0SbYLLkdwozSaBKO/o+XAeM8KhQXMl92Gs9VxlojK07d2tRQ4jUAMisyVE5rULyaJzXQ892IdTF37EXUkXFXvjNNR6mww73qrZ/vyieF1dU8nVFrFp52gfQK6vXmXJSX4YY8lUDIrTJfUCVf7oWPimKky+wB/Q1L8gZ7wvBnbWpuIdVCi7vtVsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwk0dySD+TPrVjb5dWQNc+hStqh62oVcLLdF6FV7Tvc=;
 b=venoL9ECV7fQVVi+VU3n08IcQzhIQPZMoBYYMVBUPByq7A7dNTwqysyN5/P+hOpu/XU20xRNtHU6GoHkSDPeKXqAc75kWOQKZ4VAUUB4f+vGgckc3rAOyO44xwqCHv0XexsF0F2CLnTvquo4/rzV9ZoE1AKbXv0t0PjQMlS1gVxAOtQ1T1ocb13J2qqyRK4N6R+v5ra4U6gmg5FpdHJZFWGUP1pb+/3Q+UGq9HCRQKSsVqThFCxsQ166YIu/8eppYpfbyEGSgKCHLRFEiVihUj61gMOp/LMDIP7QQMVBiBJRr1DoPo0r6GsZVjDcxh0PHDArr3nhN1roCY7cHIA5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 06:52:34 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 06:52:34 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, netdev <netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/2] net: intel: rename
 'hena' to 'hashcfg' for clarity
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/2] net: intel: rename
 'hena' to 'hashcfg' for clarity
Thread-Index: AQHbvfpkJGMhfJEeTUSKzD2mLdYHTbPq4jvw
Date: Fri, 30 May 2025 06:52:33 +0000
Message-ID: <IA1PR11MB6241346475B29A59D4FDA6638B61A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250505-jk-hash-ena-refactor-v2-0-c1f62aee1ffe@intel.com>
 <20250505-jk-hash-ena-refactor-v2-1-c1f62aee1ffe@intel.com>
In-Reply-To: <20250505-jk-hash-ena-refactor-v2-1-c1f62aee1ffe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM6PR11MB4610:EE_
x-ms-office365-filtering-correlation-id: 1c5e8c7d-41b1-45f6-2764-08dd9f468e3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TFE2MjYraDBVdlFNZ1JvRjgzUFh4Qko1ODFtc2M5ZTU3QUZwWDNuajRUZTRt?=
 =?utf-8?B?elJvTGFhTWdMZEhVdk9Kb0x0SzZZRTZIL0pLK2VoOWt3YU5Nb0ZjMmIvR0Y2?=
 =?utf-8?B?bS9PamYxTGYzb0NKT2pVNTFZU0cydHJSbzZaTjAyNHVFcFJRd2k3OWVPVEk0?=
 =?utf-8?B?OUlZQWFueXVxNHJRYnREY1BYbzFWWjhHM2VGbU02MzhXUGVKT0Y5aWNidDhF?=
 =?utf-8?B?UUtIVmVzOUFGK0djMk9Ud0N0SFBJSzAwRlZEWVptMGliZzlUb1ltZ1RxQkNC?=
 =?utf-8?B?WklXSkNhcXJwQ3A1bkR1bmY1bDc0cC9zdUp3U1h5TWxxS3dYMDEwb2IyTm81?=
 =?utf-8?B?dGdtbmY1cjRYWmhpS2hoRU0xSTcwS3NFZ1pmL3FNckZCNyswNU1CRHR6V2NU?=
 =?utf-8?B?QytDb2JweDBCYzJwTFl0VXZYaHN6QVcxKyswZW12dEpCVW9aMk1HMTFtdXov?=
 =?utf-8?B?YUxldlM0bUFhWkRhWWsyUTV4SDVpMHR2WnJJWnlYM3pTSnROMko4NlQvVENl?=
 =?utf-8?B?SHdVMFNuaFJob25jOG1oTmpCaFFlNklsRDEzYTlDRms2MFBiRHhVcTVqV09x?=
 =?utf-8?B?SVRpVStPcmpDcUJWTUJudm1nemNpSUM1dk54V2NSdGJ0cXJWdnQ4QnhnMHVl?=
 =?utf-8?B?VWdqZGxsTVNIL2hqZE5GQUZkV1RYdCtTUFJWNDhWWm5iVWowQVdoMUlGNnZS?=
 =?utf-8?B?MnBNaGxIeVhOSDl2cUFiQ0RYMXhRd0QxTzEvalpvcmJlTjZ5U1hFeU1RL2NC?=
 =?utf-8?B?WGU4ZHpJSkltMjZsQk04WjNVMVNzNHBWV05QaGxxc01Fd05FeXgyMFJGUHIy?=
 =?utf-8?B?WWZMTkc4U3gzVjhzVEQ0dmFuY1l1ZzdNNTh3YVhQLzEzZnpkVllWMFRRODhB?=
 =?utf-8?B?Uk4zNnRINnJlM3pOSHVNTXdFZjFpZmFYemYwMmFtRUw0dXAwVXZ0czZNS095?=
 =?utf-8?B?UzR0bEFOK25vVk1OcW1yTlJQZCtnODdYUEthWjNmMWp5Q1hXZXVaemhqc2dw?=
 =?utf-8?B?QndIMDZFd2hIY1dyUS8yU3IyTFhtZkl5NFo3Wjh4bDU5M05xN3hveGdHdXpQ?=
 =?utf-8?B?bFlsVXlHRXZJRzBibE5ZemZYaEZFZXh3WXVFcDZpUy9VcHorNnFrSW5XY1hw?=
 =?utf-8?B?ejgvMVdpK3RoaUlza0RuK0I0ZUpCcWtaRi94Qk5ENWRKcDdoTWZPN1plTzVE?=
 =?utf-8?B?eXNZc0pJakR1NUVKUmRoZGJkNmYybmpRTyt1eUJEV1Q4amJFZ2xoMzZmYzYr?=
 =?utf-8?B?YXFxOGRiYUVZaG5xY250aFpMeG1KZDQ1NW1SZHRHaGFMK3dlbGhOWWtaMUFu?=
 =?utf-8?B?UGdxcG8xQXZxcUd1MDNsbExjU2tlVGlLSEJGWTVldW41UzJ6b2hHMzA5akp2?=
 =?utf-8?B?ZHJEa3ZNaXRYeEQwblhrNnRjMTVGYTFLR2NXYkZ2aWF3SDVxVWlyQmlGU1Bq?=
 =?utf-8?B?dDJZZ3ZqYkR6ZUI4WDUya3IzamxrRnV3ODZFZWdjTDFQQmkxQytiTjdJbWJk?=
 =?utf-8?B?VktXUjRFMDMzWm1VVWlybGxLcjk4dVdQajVkUW9PamxqOXRwQkM1dTFwVzNJ?=
 =?utf-8?B?MVNBcDBJNkVmdXFGdEFCZkR0b1cram9OcStUaWZEVlMzTXc2QnF2OUM3ZWhV?=
 =?utf-8?B?TlUrUUV2djVwSEVMR3EySm9FR01iZWpvdnNDdWQ2RjRLNS8wa21oQnF0RlZ5?=
 =?utf-8?B?aTZhbkFwcExENmFYSHlBSzlFcjNhcExuYzMzcTVJSmF6QnBOUFV4MGFCTWJC?=
 =?utf-8?B?ZkNMTGU1MzRJUFNIWFdEcFJKTW1NY211eDJlRWVqc0Y0dTV2SXg1MXMzZnhC?=
 =?utf-8?B?eE81TURobzlqYnpuVDNHTVkxd2kwU1lkTWppalhmRVJpVFhWUTJIMS85MnRJ?=
 =?utf-8?B?bFZZZXRnSU1lalpudmFYZmdFQ2NwNG5QTHJLaThEYXFHNk9YYW5VUDBBb0Zq?=
 =?utf-8?B?aUdGS25YaHUyYzZlcVNobEFRUmVUbGJ6SXRXQW4vU0sxNHFYQ1pHdVI0WFBr?=
 =?utf-8?B?TFlqSm9MMzh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZWT3NtR2JrOVloSEp4WGJpSHB4UGZkWitZUTlkTTR2dDg4WEJFVG4zK3k2?=
 =?utf-8?B?WVJYY1VjMEpCemR4VVVxamlpVktYbnZBWjE1RThRT3ZNZmI5NmZIL0ZDMENK?=
 =?utf-8?B?cWI4Mk5BVng0bUx4bnpBa2NTWWxnRjNIZjRYNTByZkJNNU1hQTFZb1FCSHox?=
 =?utf-8?B?djM0bUZJV2l3dm1VNmZNckNjVTV4bTg0OHZjVUtMeTBYZE1lQWtobU9MQ2ZL?=
 =?utf-8?B?anY5M0FkcXBiVjNOMnJyVzEwL0dmVHpHQXp2SE1kSDNIWTA3alEwTVRUWEpa?=
 =?utf-8?B?RUxBNm5tLzZoVjNUbkFOZCtNS2ZtN2RWaGt5MGVxZEYxZTRRZjc2M01jK2tQ?=
 =?utf-8?B?cm50S2thNG9LODBoVTVWam9EMmF3b0hNdy9xbFVyS0R6cTNOSEVENmhDZUNH?=
 =?utf-8?B?U2VDQjBsSFFIYXd5S2xTOVFEM1gzOWlhaGo0VVY4b1FTTWpjZjNXYTdJWjZG?=
 =?utf-8?B?bHNhek1DVVdDbjhQeUJhY3hJOHRVOHA0cmtUQ0lKcVBiWmhuTW5MY3N4Q2pr?=
 =?utf-8?B?bjk3NzFNUit2NUQ3ak9xZDVrazhweWFtaThEUk5RR0JyaVNMd280alp0bWJB?=
 =?utf-8?B?RlpObERuZGFxZUo1b1pnRWNDVEZTY0pXd2NpQlNCd29zN0I0OCtrdHh4ditB?=
 =?utf-8?B?ZDdPTzVvcnNIWGlJTHdlekdzMis2MXVpQmFoT0Z4bmpaZTlNN1FUSStFY1JB?=
 =?utf-8?B?OXlvTDYrR3pyUnhta2dHQ1laUVFySzRqVUZoakoyUTl0aDVFOVQ5eWQ4K0dz?=
 =?utf-8?B?eW1JM0FWTm9GRmQ3Tlg4cUo0TjFqcHg0bmVtRlB6bjJaRVVmUXZQQjFXQXds?=
 =?utf-8?B?UnhYaXc2THZSUElCeExwK3duY3hYRUFkTmY1ZHgwNEdtN1NnSVFZMVVyVEVJ?=
 =?utf-8?B?TTM3YmcwaDhLVGIwRlgwSTI0RTZ2ZW1waCtXanZ2eTJNS3NnaDZDQ3YwMjVk?=
 =?utf-8?B?ZVk3ejhPUlArc09YaUUvMDBnTjEwSEkwZXVEdGQ2YmpVeTRaUVh2NlFTMGtM?=
 =?utf-8?B?RlBpWlBsNWdrcmFGUHlyeDc1WjdDZ0NYRGlZVHgvamZ6eTNxblR5QXZzR05n?=
 =?utf-8?B?bEdVeVBXbjBlN3RrNDZMcVZERm9DbmR2aitPN0QzRXc5ZUIvMVdYY0dqTHVQ?=
 =?utf-8?B?cUd3aVpyTDdyd0RlZXNxQXpKNDA0S3FWMEw3M1U2aWtrYXhHckxWSlpydDlr?=
 =?utf-8?B?aGJiWTl5L0hhL2paSFBrMmdoYWl5ZlhHOC9HMi81MTRSbFlGeGprazFzQkZX?=
 =?utf-8?B?bjlTYWkzdVZIM1pET3VBZE5JNGh2SHJKU2ZtWWZ6ZVJURUxObnlBaCt2UVJi?=
 =?utf-8?B?dS84SkJsakFCSmtydm10N2Zsemw5V2J0b041K3p6NnhObVd1RjRkQkkxVVdF?=
 =?utf-8?B?WDJldE0zUmlvTzVudEF5SjN0bjVvY0UxKzA0VGtQWFk1T2NsRGlmNHFDRm9w?=
 =?utf-8?B?eVR4eHBXejNkTksrNFF6OWpvTnRVc0lTaFNKOGpoTklGY0tzb0dUTjRVSGpH?=
 =?utf-8?B?TmtsakhpM0ZDUXpqZ1kydGVVYWsrODZ1QmFXWU9tYzE3TE0rSWNUbEU2TkpC?=
 =?utf-8?B?aHJQajVwQnQvUDlBTXUvdGJDU2svdWhHOFB5aHZFbkxMRXA1OVRJSlAzMHRl?=
 =?utf-8?B?S2xLdW9JT0phZTFrWmc5NGlLQ3ByOGVXMU5zZUZrZnlCcHJEdUJ6b3BkTkxz?=
 =?utf-8?B?bU8zaDdWY1JrWjJLK1FGd21ldlpGdEJxZ0JpREJuWmlFTWlDUkdFWE4rQVhp?=
 =?utf-8?B?Q3QwODBXMXUyaVR2TG1RMFRrclFIUk1lcjI2NC9OMTlqTHBaUmVSODZBQVZk?=
 =?utf-8?B?bzZOZ2taTG9uTmt5STRhOGlmanVGVVk5Zk5yUXdvYVpuNndGUFlOR05EaGxu?=
 =?utf-8?B?Y0NEVFU2U2VDVVRPallWQzdVOENnRHNNdS9BUFlvUEpCQ2s2VmZidDZNZ3A3?=
 =?utf-8?B?ZlZXaUtqdmV5Z05Hem5VKzREOU1LUVJHbys0NHpKdzVBMUhXNW15VXc4anFa?=
 =?utf-8?B?NDZwR3ArOHFjaUhsMTBldFpNUUFFQlYva25rc1g3ckVIMzlFZW5TR1djUVdU?=
 =?utf-8?B?UmNEY3ZjL2xISkZ0Tnp3dUJpQk9sVEl2dUovVzhCTUcwT0E3cEVENTRTV1ZZ?=
 =?utf-8?Q?AcMMh8/hIZH9vgYLpVjGXWI+Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5e8c7d-41b1-45f6-2764-08dd9f468e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 06:52:33.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42Ho3ISQ2yoxanDI8dlY0PFvCI5Bf32aC0RzAW0WIchrBpGgtGyZ+LzP2iK8aSOomjxrQ0kkHI1UPeniAf7jKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDYgTWF5IDIwMjUgMDE6NDQNCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+
IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFs
ZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBTaW1vbiBIb3JtYW4gPGhv
cm1zQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wt
bmV4dCB2MiAxLzJdIG5ldDogaW50ZWw6IHJlbmFtZSAnaGVuYScgdG8gJ2hhc2hjZmcnIGZvciBj
bGFyaXR5DQo+DQo+IGk0MGUsIGljZSwgYW5kIGlBVkYgYWxsIHVzZSAnaGVuYScgYXMgYSBzaG9y
dGhhbmQgZm9yIHRoZSAiaGFzaCBlbmFibGUiDQpjb25maWd1cmF0aW9uLiBUaGlzIGNvbWVzIG9y
aWdpbmFsbHkgZnJvbSB0aGUgWDcxMCBkYXRhc2hlZXQgJ3h4UUZfSEVOQScNCnJlZ2lzdGVycy4g
SW4gdGhlIGNvbnRleHQgb2YgdGhlIHJlZ2lzdGVycyB0aGUgbWVhbmluZyBpcyBmYWlybHkgY2xl
YXIuDQo+DQo+IEhvd2V2ZXIsIG9uIGl0cyBvd24sIGhlbmEgaXMgYSB3ZWlyZCBuYW1lIHRoYXQg
Y2FuIGJlIG1vcmUgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQuIFRoaXMgaXMgZXNwZWNpYWxseSB0
cnVlIGluIGljZS4gVGhlIEU4MTAgaGFyZHdhcmUgZG9lc24ndCBldmVuIGhhdmUgcmVnaXN0ZXJz
IHdpdGggSEVOQSBpbiB0aGUgbmFtZS4NCj4NCj4gUmVwbGFjZSB0aGUgc2hvcnRoYW5kICdoZW5h
JyB3aXRoICdoYXNoY2ZnJy4gVGhpcyBtYWtlcyBpdCBjbGVhciB0aGUgdmFyaWFibGVzIGRlYWwg
d2l0aCB0aGUgSGFzaCBjb25maWd1cmF0aW9uLCBub3QganVzdCBhIHNpbmdsZSBib29sZWFuIG9u
L29mZiBmb3IgYWxsIGhhc2hpbmcuDQo+DQo+IERvIG5vdCB1cGRhdGUgdGhlIHJlZ2lzdGVyIG5h
bWVzLiBUaGVzZSBjb21lIGRpcmVjdGx5IGZyb20gdGhlIGRhdGFzaGVldCBmb3IgWDcxMCBhbmQg
WDcyMiwgYW5kIGl0IGlzIG1vcmUgaW1wb3J0YW50IHRoYXQgdGhlIG5hbWVzIGNhbiBiZSBzZWFy
Y2hlZC4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBQcnplbWVrIEtpdHN6ZWwgPHByemVteXNsYXcua2l0
c3plbEBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFByemVtZWsgS2l0c3pl
bCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhv
cm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pNDBlL2k0MGVfdHhyeC5oICAgICAgICB8ICA4ICsrLS0NCj4gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWF2Zi9pYXZmLmggICAgICAgICAgICAgfCAxMCArKy0tLQ0KPiBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfdHhyeC5oICAgICAgICB8ICA0ICstDQo+IGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZmxvdy5oICAgICAgICAgIHwgIDQgKy0N
Cj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV92aXJ0Y2hubC5oICAgICAgfCAg
NCArLQ0KPiBpbmNsdWRlL2xpbnV4L2F2Zi92aXJ0Y2hubC5oICAgICAgICAgICAgICAgICAgICAg
ICB8IDIyICsrKysrLS0tLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQw
ZV9tYWluLmMgICAgICAgIHwgIDIgKy0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQw
ZS9pNDBlX3ZpcnRjaG5sX3BmLmMgfCA0NiArKysrKysrKysrKy0tLS0tLS0tLS0tDQo+IGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9tYWluLmMgICAgICAgIHwgMTcgKysrKy0t
LS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRjaG5sLmMgICAg
fCAzMyArKysrKysrKy0tLS0tLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfbGliLmMgICAgICAgICAgIHwgIDIgKy0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV92aXJ0Y2hubC5jICAgICAgfCA0NCArKysrKysrKysrLS0tLS0tLS0tLS0NCj4gLi4u
L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdmlydGNobmxfYWxsb3dsaXN0LmMgICAgfCAgMiArLQ0K
PiAxMyBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKSwgOTcgZGVsZXRpb25zKC0pDQo+
DQoNClRlc3RlZC1ieTogUmluaXRoYSBTIDxzeC5yaW5pdGhhQGludGVsLmNvbT4gKEEgQ29udGlu
Z2VudCB3b3JrZXIgYXQgSW50ZWwpDQo=

