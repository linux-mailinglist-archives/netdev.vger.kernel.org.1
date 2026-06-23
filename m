Return-Path: <netdev+bounces-301397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6q0xJkOfOmrFBwgAu9opvQ
	(envelope-from <netdev+bounces-301397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:59:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3276B81E2
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:59:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UI25s7bE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301397-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89DF730731DE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770023D648A;
	Tue, 23 Jun 2026 14:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D03D6475;
	Tue, 23 Jun 2026 14:58:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226722; cv=fail; b=MPCog50a77jztxbO1D0i459za+lwnXYOJ4OjupEO928VhLmU3hJjiOlpo0zRNoNKba+OGjcIDvCrGy0ZWYdqp1z+Q6DYgaiq+SfS07iwteS3aRdNhBEDpnJS8oPUbY1D0uvpfL0m2uw/jrK9qWpQggjEM4dl8A1KsuUnpJm5ajw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226722; c=relaxed/simple;
	bh=i2MEFaoRxDjB5XwOFiFDUtrgGEaBSMslZ7eD99rdS3Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdkLmPUkIs3QMAyRfsxllcN6KWLkIAU33r3UdHYpiw588fAzIyAtldX4ygt42L2umaUaaZ0mv0DQOVjTfioucW1AoRN849oo6SRc7C8BSkJrsZBbc2W0zu/8vboEM5AxdAjsX3JW1P68TEA1g1mOJwb9oNzl7f02FP6l5f9Ng5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UI25s7bE; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782226721; x=1813762721;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i2MEFaoRxDjB5XwOFiFDUtrgGEaBSMslZ7eD99rdS3Y=;
  b=UI25s7bEV2VgTo926CeXIQ8AjanduqFUu72EvW6r5ZbhcUGcnAFokEd1
   9WRUakg8Z1r9MAP/HX3defYfpODD+xYMgSLd3aPJAqqNk7ytylzyV2s5b
   W4P18b9xqgPeJc+kEXXcUqn6BPNF29u6SwZ+eh3HzniohvA2qfXs+CA0K
   tuzqmmefeZzxLDttpzgdgB9/wf2NR96XW6cvR4lv3MqjULskpWT8RQv05
   OQ+FC+aGafs2pxGMB1ADffGDLCVoxDOjusvlgHUgzWfJaAS9jE5tvHaFz
   a8mbby+X9p45mL3c/r721btAookyoK3ANT7Q/inVFtSVuDe3QI/IEg2W0
   A==;
X-CSE-ConnectionGUID: aJWMcLjDSqilHhHreqIB2A==
X-CSE-MsgGUID: bIyJnG5ERfSNPXE8YN0QpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82079758"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82079758"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:58:40 -0700
X-CSE-ConnectionGUID: pAk6nCGuQzyhqpswDhv3WA==
X-CSE-MsgGUID: mV1FYghlTf6qFx2tT2EOPQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 07:58:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:58:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 07:58:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A38Otf9ZgvDswqRZfgGwjRkr1HJtFowxAuFOkny+omOrikZCo3BVSXIQspLgsWwBglydXvb37hFS5CYvaJ7R06jML0E6YAGhrmo7dcMzTNjSo+fogs8GjoOgAEQRKmH4j+R05t397URecNuoYfkKK/ULpTNhFm0O+toonPoAr/Q1B8Fc0dymjY36XE1y7hAnKQwZCmtQPGRvbZvy87ucK3sUFxmAojF9nTM9fel4VVhkhJp0hRjy6qy/+x8uUDTO9Pqc3zCToahMK9a5C77OMf4qc/N5E9HBQYAYiBoa/FXVwtkAKzBmZDdG5IjTQnVzwrFhG7pDZ6bNbX5sp+pXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwLjHcQ4j6ArYB+VEFH0T8OpKwgaWrxkHggax5jgxmU=;
 b=IH0+tCLU2cru1naPNOmKujWMpP0nXeRCxGmBzE281SIrLnuS3OqAlc2OF1tgByGr+EGgijI3ULnJgx1X9/rSHIGU/hEUZqiO/WhddZMzjPgu2YdRrZ4oopMJadqYVuRoWxhnJFMWTyMa4UN+AAw/eqdReUb+H3zqyH3bNg7vafkK0H5F87zBTab5V8DcA+AQDIKvrBEZ4OrSkFiFw6lSELpkC+BlEk3TEp98WDzTKtstrgPCcKfyx+kvN3wYEwANihgEmPK6uI57Z3s1z3UgLDhpFTwcAFZEoH7GuPIP39UcS+i5MdE8/yvETuddgz4LLRLNlztrklG3EB39/3x19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 14:57:04 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:57:04 +0000
Date: Tue, 23 Jun 2026 16:56:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Tushar Vyavahare <tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <ajqeunMDVJO+CUHV@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
 <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
 <ajJsMj0QMOF5I8qq@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajJsMj0QMOF5I8qq@boxer>
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM6PR11MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d70026-e354-44b0-2830-08ded137aff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: URK9h13QUVTvwyF3fce7uLHmNHrCAWhbv5ULs3u7PP/53rlQkB/JAJl2e/4wHpoFmJ81wpWOqPc2PNkC2Rviq++L59okzQBd+gia8gF2x+etlVpVTJmtce1aDF/ENoVbC9wOocd8Nvj8hzHTpyUs66+kDkYNDYds9qrdRLO3mEr1gC3tMyfiHwGDM+hghpHSI52V3yCqoI2n96+PijHnLPx+/9lvFGEnJLyg05WblBy1rmnQOg9OD2Ux6WVNHr6On9+EsyCnsHQUKQQDAG461EBi2YNhKFDiZ5axsht1xqFLry9BvCojk77461lWPr4tjL3WCcdKSiDiIrL0r+1BculZjCXSFmSBnAHEPVaNCdL0iLux33sN0svOLr3lgYWQcTPQn6CWHzuRpe0Rjp81ySEZOUlmRkyGYqvrwJqfss4zCme0frD5HC0TR8Q+EQkJswKkjHkX329cXhxI3zzplwXTx/C8IJS6BdCYEQMdvQAL27zW36rlpPofe9ERStVPq5lYqFJf7F1LJv0Mi1yc2z4MrwDHY0as13dlIbD9vwg7hPxcWZsMYgZmK3lECkyf6VtK3Ij3yvI3mC1OfrywM+/3OH8ZEX/o9FEAXlSN8cB8h5HPUHM3RTOi5O/d/PLe1Y2OvdOzvqqHEGH1PST+OJ1b22xJ6gh1+Q2+F2Sg33Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1R0RjZ6RkRGU2JNaCtWS2RucnZYK2d6MGY2Tis1d1Q2TkNTVkxUbnlKSk54?=
 =?utf-8?B?c0FyVi83SlkvYTJFTEIrU2NiMXB0dXlEcTJZdTY3YVVxZ1hqMTZWekQ0WHZ3?=
 =?utf-8?B?bHFabEJVSnJHL1VxaEdwWmR1RkwyeUx5ZHZGYlZDSzhDK0psSU9wb0JuL3M1?=
 =?utf-8?B?OUN3bHh0TFJmejVzcit0UzY3UXBaNm4vRWZjbkxSSFliSCtnRGhsWEQ5UkVj?=
 =?utf-8?B?M0MyemVpd3duTjFrZ1IralVyV1VtZmdLU1ZIUUN4WERDcmZFL1Jha1p5Wis5?=
 =?utf-8?B?RjdmZ3VObWtXNUFFVFdTTTUycjFJWDNHSDBGT1hXWlNmRWMySjh3MlNMQVQw?=
 =?utf-8?B?T3N0RmtkTmVRL2lZWU02OHk5MkpMQWltSTRwMVNsVWt1UFgvYWg5b2ZwL0lR?=
 =?utf-8?B?Q3ZONTFnMlFqRW43Q09RV1FwSXhwMUd3LzZqdFQrTWxUajlZT2hSdEZlT24w?=
 =?utf-8?B?OXJzNWxMdjdIb1loUHgyUmNycW1pZCtMNEYzbGlxTmh1SUc0b2dzOG56ejMz?=
 =?utf-8?B?b2lMUmw3T1VzRkFqY25qMlZZSUw0Z0ZZWUphN0tZRzhnK3QxY0tpN2orZUJV?=
 =?utf-8?B?bmdWN3lVdVltbXlzNmFGemlYclBVOWpVRW9iTis2dC82NDZybVI1Q29vc2hH?=
 =?utf-8?B?S0pVd0JHaExwY2QzWnh2WnByQmN4UGdOdTZjeko3bWxqZTJLWXIyUllRMUtp?=
 =?utf-8?B?MHMwdFQ2eFlhdXNvZncvL1ZseWMzVFhWRk12NkdwejVobGUrdVBXWjd3V2c4?=
 =?utf-8?B?VUpEdWxuTlRLZzAzKzZRVVRrWXBvUS9pbE9qSmk3cVQvMUFtZDhCb0hrSjFQ?=
 =?utf-8?B?ZFk5WEIrOFVPV3dITXJoRE1UdEhsSzRCdW9USzQ3WVZyZElQZWwxb3hOUS9U?=
 =?utf-8?B?QWhNckxRNjBVemhOUXVBeTJWOGoranorWVUxNC9PZ05weGR2dTB3K09zdTZX?=
 =?utf-8?B?a3c0aTBYZVpLZU1USG1ZLzd1L2Z6aHVsTHV2dUl2b3Z0QitKWlpVVjEySUFj?=
 =?utf-8?B?SUxKZTFJcUlUNFAvaFVEU3ZTNzhOd0xTVnRucUFwNUZBZXZKL0J2ck1obDUz?=
 =?utf-8?B?OHRCREdvUWNFOXJJQjFyT0VHL2Q4T0ZHeGJvNGxuNUNBSmkyMWkybFVhNGlr?=
 =?utf-8?B?Z0g0RVVOREpQVmM3RzkzVGhnMGZlQmM3VjlCTjgxMjhJTHRlZVRuN3JVbk5h?=
 =?utf-8?B?UnlzL0QyVVVDaEYwSU9yb0xDdkVuSi9tODh0Tml0Skw2RGRnY2NNQ0dHUDVW?=
 =?utf-8?B?TG1TcXJrR1haS2FtODR1dlFubjN1bEV6cmR0L1hQdnAxWWc0TUkyL3ZDSHlN?=
 =?utf-8?B?RDJPTXdyMHFxNENJdGhNWXVrWTJuOEJHMHVWSVBDWFFldDByMWUvV09ubmVs?=
 =?utf-8?B?VEZlQ0dDcXN1Q3YrK2VxZnVpK1lZa2dsUmtLY3hGdDNhK0REbndlY1lFYld4?=
 =?utf-8?B?OUROWDJzTUFXaEc0N29zZEIyb1RRU0lVVnNyM2pPMzNVQ3M3YjVBbDBTb21p?=
 =?utf-8?B?QUhNcGtGbXdjdDFENUVlTXBHb1FNQW0wTWVzekFJUXphQnU0aXFtSlZvVWNz?=
 =?utf-8?B?eTdmMlptZUhGSWc2VlpBSm1HMVRDa0hmUVE5bmJSaUd4eCsyS1hUWVIxQVdX?=
 =?utf-8?B?RFJUaDI4MHpWdHE4cSswMkN4WTEwcm1OYVlyNTBwK2JlcVBBa0lVWjhUR0dB?=
 =?utf-8?B?Y2JxSUlydVVMSC91cjZsRnRPNldJVVkxTTloSnBmRlI3L2I0aGZrQlZxYWZr?=
 =?utf-8?B?Vk53M3hQUlVyT3NTSE5MZTlaMGo1TVFWdy9HRWdVMy91T0w3UG8rampuYnNw?=
 =?utf-8?B?S1Zhdk80czYrUjE3OEZ1Ry9mTkx4TldRRnVSQWt5Z0NadkhteFJkTWp6aENZ?=
 =?utf-8?B?dzZiNnRIaVJkcUN1K0w1dVB2OWhNempXU2xUeFhybTY2a29uaVJydnVlOHFu?=
 =?utf-8?B?VUx4YUNycmxlWWYxVUpaR1hPTCsyL29OMXRaYnJFWmd3Q3dudk53dU1zZHAv?=
 =?utf-8?B?Y2dRMnRVWlcxL3JWcXhLMzY3a1FnVUNxTytPUlVhbmxrOVBTSVRxU3hWTEE3?=
 =?utf-8?B?ZzZKd0RZWS8vTWtwZEFJWklKZml6QnI0SWc0R1BKcXR5MnI4YmVVSE5GN3Fm?=
 =?utf-8?B?eEdNZmUzakFhejRtcFFlQWtoWHhLVXlRQkhJTGN1WkhJTWlpc2txbSt2ZEV0?=
 =?utf-8?B?VS85Yjc2SmpLYkFWMTdNSXVZMmlKTlI0V3gycjZPN3FnZytSWGx2WWk3L2M5?=
 =?utf-8?B?dVJ4eGpHNU9XRnhBeVBYRGs1RTcxUFhKYlBFVFgxY2tQZkRSSWtYVVRWZy9t?=
 =?utf-8?B?TjB1V0w5dzdVYUN4NXFTVkF4MmN5aEdOMXpZeC9KcU1wSlpQbXJVWk9FYjZC?=
 =?utf-8?Q?VfEZLplssnUE+Pco=3D?=
X-Exchange-RoutingPolicyChecked: C0GKys3qq51P7OJOFsifrGO8pzGYJcgCRj/OS3mJ3U1lhP13MrYTyRZT8l3VvvLCDU7tJi8qc8AmFX4BtNDfs53LNosl97sANAZurHZ7P3Ly+ee52M/vyhgo08AcDM3y+IxYJ32oMPmXCBcfP3CvD/0+ZfZ2hiSvef2IsSJDY2cyVJzANDbaAL1ge29PAcoK7wzxHxOCjW2E8uBLsvWayMeCRVfsZgY0gXQaqzS5kHT/jeLwgAtIPVWixfP/xvMdwVexnbrk0vdRcOcoNTMNxwmZL6oChhsZ32cC2tzXPbyL1LYphzTdZu0R/rsR9uwdql6nSWWBqHEOygdIU/+pQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d70026-e354-44b0-2830-08ded137aff6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:57:04.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suT2hteDtWOEN9eo6FZe+BKctPUReVg91gZbKaoo/0t0u9vYxGqAeaikU1I4oGpNlKZVvMR553AVw1HYDGvM2ipJ+NuLLU0wmxkFDArtPtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301397-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,boxer:mid];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD3276B81E2

On Wed, Jun 17, 2026 at 11:43:14AM +0200, Maciej Fijalkowski wrote:
> On Wed, Jun 17, 2026 at 07:39:06AM +0800, Jason Xing wrote:
> > Hi Tushar,
> > 
> > On Tue, Jun 16, 2026 at 11:50 PM Tushar Vyavahare
> > <tushar.vyavahare@intel.com> wrote:
> > >
> > > This series improves AF_XDP selftests by making timeout handling
> > > explicit and fixing sources of non-determinism in xsk timeout tests.
> > >
> > > Patch 1 introduces test_spec::poll_tmout and removes implicit
> > > dependence on RX UMEM setup state for timeout behavior.
> > >
> > > Patch 2 fixes thread harness sequencing by attaching XDP programs
> > > before worker startup, removing signal-based termination, and using
> > > barrier synchronization only for dual-thread runs.
> > >
> > > Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> > > configuration does not leak into subsequent cases on shared-netdev
> > > runs.
> > >
> > > Together these changes make timeout handling easier to follow and
> > > improve selftest stability, especially on real NIC runs.
> > 
> > net-next is closed, but in the meantime I'll review the series ASAP.
> > 
> > BTW, another thing about selftests I had in my mind is that are you
> > planning to work on this [1]?
> 
> This one is on me. I took your changes Jason and aligned ZC batching side
> to this behavior, followed by xskxceiver adjustment. I am planning to send
> this today EOD, however let's see how badly internal Sashiko will kick my
> ass.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> > 
> > [1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gmail.com/
> > 
> > Thanks,
> > Jason
> > 
> > >
> > > Tushar Vyavahare (3):
> > >   selftests/xsk: make poll timeout mode explicit
> > >   selftests/xsk: fix timeout thread harness sequencing
> > >   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
> > >
> > >  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
> > >  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
> > >  2 files changed, 56 insertions(+), 42 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> > >
> > 

