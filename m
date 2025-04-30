Return-Path: <netdev+bounces-187139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DBAA52A5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF451C05FC4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5DA1E0B86;
	Wed, 30 Apr 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER+3XwvI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F72DC797
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034554; cv=fail; b=Nbe67mlmrkDHw+y65PPRlJKxuJwyqNBIlIwzUw4UhL7dacPJIyzPsujBEBMEk4WBk0m8w7GuvppZsrLb+hCzymJHM7hpyU9DQpI9lEPeGBKyZgjLP2FSYV68gi2ymieLx4IxQ5UIcxs63qXCYFR2dM5lFqdwE2+9DBayexdA5ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034554; c=relaxed/simple;
	bh=QEwogwepbwt8oHMfc1lFsXD6ofpppvkulAGHTZxBs8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnMREsoVHlSFLBKpbvpAknVhzAOh3dmNxB/wRVAE8KwrNIFo8Joa85YBWfwXsEZuQceRFuIwqrylLn9PvFyW1UQu+DpNJZI17ariHTOEEbiATEICWR3KUSxg7VUShRrLUK1/A+X8ns1yWqaOL9rmLw/MHqSDKGUiQFpd6Hr+b9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ER+3XwvI; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746034553; x=1777570553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QEwogwepbwt8oHMfc1lFsXD6ofpppvkulAGHTZxBs8s=;
  b=ER+3XwvI3hMYLMFiiNwbGcyVTF3QWjo+nYxT4ExMP0xVxdOqP37KECev
   LkaDEbZS1P3QFSXna88lxTEwSTAd3baLXzFaDHSxlujQju3jE6E4fjrwX
   KYMb+8huSkDB2ZIte99LLjvoKxpFdwA4ZMMORAGCdqs8aciAI7SNc1FGM
   41KJjrJ1v6jy84JGEUcUPmieWQOPJwlf3pTYCnMT5Us4ZsHAEelhga+Hf
   rCOxhFDacJCxMFh5iwd+Rh59otXzw/zXZSiOsLmdEnoKZIjbdzrkAkOOn
   u5BsatN9bqrUxZEBY7v+e+tYgmG7yVx3h2hyWKkKgBSzCkZaQQ0B8r65V
   g==;
X-CSE-ConnectionGUID: WxdMkQtMQFmYwKcrSHWJLg==
X-CSE-MsgGUID: pfHnUry3SOCOZuX3piHY8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73095203"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73095203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:35:52 -0700
X-CSE-ConnectionGUID: /QIhvQQrRaWJZdBRiZqLpA==
X-CSE-MsgGUID: z0qTYlrIRoihceBNUGxjbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134479595"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:35:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 10:35:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 10:35:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 10:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJU0Ifgh8ZYgXUDcUfi3Jx6aACAtgRioaJsC5+RBALwnGvtp8neBnL2SHVBFy26nD3v0c1f6CITrkGPHFSrGSXnH5L/5zKLDSlwxFIM60Tt/9e4WtLxaCRNaNcKJfpvNnh/0B5ODVgZ+dHTK5vaNnBkyNlY+lpirY6kpArhCvz9K/W/3tUGB73rl+sPnYDkZ/8ndq0gFPm9ukkvUEK9xO95ooIVZMx4Ov5Z7PbMiCj55vuK3gzB+dMHvbRBiiiV8itDzf68ja7vM+zGYgeRGupGiK1j4W6loVbej4lBgbcK5vGZB5qkEQlH1fvRFZm2tAVOJcg9k2tLnjwPw1nRYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEwogwepbwt8oHMfc1lFsXD6ofpppvkulAGHTZxBs8s=;
 b=toDhfXR5NwSW1JzFcU40+y1ubCqi7oeBti66ZzkxIkWnXzp2DCfZcVnGC4ZvyH7mWZoPsO1cIwWgy4kp3nCH4ieO5X6lIqF0i4WPd+tRrEtyKgnaVlcEB7/x94ekMqjJRb1T8mtcF+tExf9HuYAo7j7xKMWswPegFLc3S6oUirxwNy6uyy8Q704alLr3HfCrOQfRWhcjGkuxam6ts9v9P++vot7zGNrwaLmUY7jhpr+Cyy+JeI7ynjsGvliWKwJRgxiQJALHu6Youzh0ypgnoNI5DddIgI5OE/UKScTL+34i9SSL+W7DmuiCKpVXFi9i2eA8umg9tfEwwpwo6QoOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 17:35:06 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 17:35:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, netdev
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next 0/2] net: intel: cleanup RSS hash configuration
 bits
Thread-Topic: [PATCH iwl-next 0/2] net: intel: cleanup RSS hash configuration
 bits
Thread-Index: AQHbufMNZetUStGErkym6N979H7j0rO8eHJQ
Date: Wed, 30 Apr 2025 17:35:05 +0000
Message-ID: <SJ0PR11MB5866DA7E6283533AAC4BA700E5832@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com>
In-Reply-To: <20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|DS0PR11MB7801:EE_
x-ms-office365-filtering-correlation-id: 46815006-816c-4d72-2cdb-08dd880d589f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eTJxRm5USWNsd0ZpL0JhUi9JMHpwb3pOZVdOVEZ4MUtjM3FtRG1DK200MWh5?=
 =?utf-8?B?K0dkWGZCd0N5TzcxcFhvOVdTVC82Vi9OOWJkcEFLSlRRSm9HSlBDQWFEWHpo?=
 =?utf-8?B?azFmRjZQeVZBZEEySm9rRHJIRzJDaSs3ZGlHZlE3THBKMFEvNmZnRXdvQzdO?=
 =?utf-8?B?cFhWckI1QTJzcVBrOUpkOUlvZUdFZnhGaE5MMktsYko5RDcvcjd4YWNPWnV6?=
 =?utf-8?B?VjZuUWh1K0hpTFJlZEF0eG1XZ0JmZzU3bTN2dVFNb2lROWpVbm13N1l4QVJY?=
 =?utf-8?B?bytNN3E5K3d6S09NeHVDaGlqT1QrSFJkWGVrVWJTN1JUc2dxSXRkUVdyMFFN?=
 =?utf-8?B?OHZaUDRDU3FLZGoyR0lpQjIwd3JPT3l5M1FiZnVOUjJsSDBRZkMrckdkOHNM?=
 =?utf-8?B?WFZwTDNsLzlyWHNka3pNRE5WVHpjWHhGYTh5RHdvaldOUFRlVGVjYmZRakRq?=
 =?utf-8?B?djJnSnJJWE0vaExYWnZ1dE1qTmpqZ1hHYjl5R2k2K3kyenhWZzUySWpPOTR0?=
 =?utf-8?B?K2N1TlpSRGtlQW5oajZxbDJGdDJINk1lSENNK2k1K1NVTnZsRGExcnBPbXZ0?=
 =?utf-8?B?QllFd09JcTdVWFEyT1J3ZW1RZ1dXSkw4S2hTaUZ1L3F6NkQwSHcxcFZ1U2dv?=
 =?utf-8?B?VEFyQ21iMUQxY29SckVDeDBCQ3Z0QVBrTFJ3c2wxdm1IaWVwbGIrempPcnhr?=
 =?utf-8?B?c29Mc0lMNkhTV3o2RExzU1VMRUsyb0dtZEtYRUw0cUdWMTlPK28zQ2l5amdC?=
 =?utf-8?B?NWo2eGt5U0tVWEgzQldkM09ta3FjVEJTdjduZDZOcnVGWHNLVnRNekZFNFVR?=
 =?utf-8?B?cWc5d0pUUFlPR2VCKzh2WmQ4NGVyZS9lRTA1TzZaQ2xaZHVYa1Vja0RFbjJ6?=
 =?utf-8?B?MW5jdWpEb1FQK1RjMjByOWxkVlUxRkxxVFdaOUNXeCswR3dOR3NEZ3ZnV0I3?=
 =?utf-8?B?Y0RlNFBrbFhzREhnaTVaWGdLUmZ6WitOR3haV2ZKcDgrYXdIQVprZE44dDZC?=
 =?utf-8?B?Nk1ZcGVBdTZCbWxzeTI4WFlWa3FxcmVCaFhTTnFhVjdCVUFBNC9RWkpLRm9N?=
 =?utf-8?B?MzYxb1BIRUQ1TDlpODRMSnRUczJyZEdUL0NPTldWUmxDMnR1ZDJSWlE4R2dC?=
 =?utf-8?B?enpnUEdYeWtOSDZ1alAwU3lBb1pYck56VmI0NndVbHg5eTRIeDE4aHR6ZUl1?=
 =?utf-8?B?dG5tZ256TTcrbUEydzVNZFhyYmFJMDBteFlyeWJNRmhRUDQvc3NOSlVmRmEv?=
 =?utf-8?B?T0hEeVNhYk1La1NtRGpWTHlqTTN5MjFpUWp2a2pONE8wOVlBVkNlV1hZSEs5?=
 =?utf-8?B?YktFUkRkUkZLWTBRODltZ0lISUtqVk1vaWx4S0Vvc3FTTE9BRzhOV3VQbzJa?=
 =?utf-8?B?VDV4enRqWkpJcDliRnVFM0ZkcjJHZ0NzUW1XMHYyYm1yYW8rbWcxeEgxZldI?=
 =?utf-8?B?alFrOTFnMWxab2YyMGFmWHU4YzVBaituL0dxVDFCSnc3ekFzbXdxYThPaDMx?=
 =?utf-8?B?KysyN3IxMmVqdVNGcWdEOVI4bnlVem9RYitBZWJpY2haa21wQlMyYWxzRVhU?=
 =?utf-8?B?byt1QUJlOVMzQWV1TStDVXg0ejd0L2RXbFZHb24vMmUrdDFtNldoWXgvQUlO?=
 =?utf-8?B?cWpXQWZETWpWbG1raXFwZythVEZGV083blJkNE1WMGkwbHV3eUQ2RUlxMXdi?=
 =?utf-8?B?UzlELzRtYXc1cUROZm9sZFhscGJWRzRCdnRiYmlTT2xreFZZbStuOFl0cno4?=
 =?utf-8?B?TlhkVHRBajhzazFkcStxeS9UVWVOSTRXZXBRci9STFNmNStGTnMxWEo1WFlt?=
 =?utf-8?B?ekh3SWcwRERpS1MxN0FUbEJRRzJIUXpOYTZIWDluQ0xIMTlsRTRwOHdYaU5H?=
 =?utf-8?B?Q2NHUFBTWGtkc2toSGw5YnNhSU8xVks0QmhabXdSRnRUMFYvRHpBSHZsRE5m?=
 =?utf-8?B?UzM3MXgxREhBUmltTGlSRmUwRXAyckdOR3hzRkdYQ1FiNE9GTk9ZYllOOUk5?=
 =?utf-8?Q?uUrtxfmC4osMDpAg1p590KTvVw1gSQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1RaMGJjdmJyMUl3U21PM2xkcVFkRXd5NFFHc0pudXdUbjFua2ZvVFA3OHYv?=
 =?utf-8?B?U0RDNUZXYWhCYVNycGd0OFUrQ05pRnRIdXpmSmlvS1pVOXQvNm5tQ2RFWkxP?=
 =?utf-8?B?UExlRldWVlVJU2NqL016K3Y2UUkzdHJWS2RLS1E1Z09IeFZmZWV2eGEwZnVL?=
 =?utf-8?B?a3JzZFdVK3c5ZWxKcnFpRGt4Nk9BcnpVNllRUEVEaVJBdWgzNGRUTjVJMTAy?=
 =?utf-8?B?QW5lcXNrdVFvb2Q1a2xzQjBQL2dNQzVFb2dDZnBRVkw4cFpDNHlHREJoU0tC?=
 =?utf-8?B?U3BYYlNtWVFNcHEwOTRYNmVLaGZ4RkI1SytuWW5GaHN5VE82eUdiZVJVa1FX?=
 =?utf-8?B?cEdMTk95cGk5cDJTL0NGYThGaGZDRFBXazd6NWVFelZTbUdDZWwvRnZFSXpk?=
 =?utf-8?B?SDFXSFdod0Fwc1M1SU1QVTVMakFQZE5PWlFNUzhseG5xeUdUMjU1OUVVQWpi?=
 =?utf-8?B?dXV1bVFmRDlnWThTWkphWTRMUUxyZ2VvVTdJN0hBVWsyRzdxL2VuQ1FlMkFn?=
 =?utf-8?B?Y0NvWFFiTjM1bnkwMkNpYTJHR3JIK2pUb0oyM0d1NlZGVkFRQUNiN0c3Z0tK?=
 =?utf-8?B?QkZud1RrRldUdTd1RUtxY2F6Q0pOM2lhRVYvMFZ3TFV6TXpBRUJTbFA0ZUFR?=
 =?utf-8?B?VWpaZW9xZ2ZmS3l0Ty9xKzB6dHRKRlgyMHBSNjVHK1cyOE82MlNUTlVNeFRE?=
 =?utf-8?B?SlhISWxSNjFwOERhVjNuR2J1ZGdaa1RHeWFrdGVUVlFYWnFCWnlucVRHcDJQ?=
 =?utf-8?B?RE9mV0NkVHVDQmZNYW01NC83cDZQL3dRSjZyWVhVemsrTlZoTUVqWVlsbVVE?=
 =?utf-8?B?QWtLYzZiQWZJeFVRUHR0K2l3dnRQa3E5N2JCZFNIQ2Y3c0lnbjJKWDh4TG9G?=
 =?utf-8?B?UEp5OEt1L05jcEM2Y2c3RU9UVUJYR0tJNlpWRUM3Y1psOVA3ckVyVU96KzA5?=
 =?utf-8?B?Yyt0K1drdElpRHFSRE5CcFFMNFErb2hOQUpKQUR5Q1lUaDM5MHduYVFReUZ2?=
 =?utf-8?B?d2QxTTgzQ2FSRzBVYko0UGZxN1lseU03eGIvb2w3dkVYSEZEaFNOVmd6Mkov?=
 =?utf-8?B?VDdqKzFnSzhROUdidDNqbHZRbU5nRjVZTlVUbVV0S2g1MmRaRDZqdzR2WUZX?=
 =?utf-8?B?bmlNaWpBUVFaMEMzMnZSbFFyNjI1Zm02NVZTQTM1dWNWcTdTQkVHZXltQzRC?=
 =?utf-8?B?eGtScTlPY0IxVVJwRmNOQlBvNTdOYXpobGdpOFovSklQV1c4VCs2OGE0N25E?=
 =?utf-8?B?blNXL3czdlVESlJ1VlR0azAzMW93RDRZMTlVRCtVb3FBdzI3eEZKTzd3c2pP?=
 =?utf-8?B?VmRvNFBlRU9ib0M4bmRjczh3MlNDbGh2TTBwRjJNY21qVm4vSU5aTGRuOTNi?=
 =?utf-8?B?by9jUUZCR1ZVYStNTlYxNzBUWElEeEgzc2dpTHo1Z1A5b2tRS0dNRU9lTjhn?=
 =?utf-8?B?TldyTi9EazJlckExVXdxR3RtbHYvYWkzQU40TVNnVzVKZUlobDdQSGZIeEJP?=
 =?utf-8?B?WXBHZWVkQUNsY2tjL1lGSFU4c2Q3YjFQVzc2WnZydTgyZG9sT2tuL2REM2VN?=
 =?utf-8?B?NkhXdmRTV3paaXBML0JmRlFqN1hlKzM2QlRvOWo2TTl1SGJYdGpFSFZ6bExH?=
 =?utf-8?B?OFBFZ2t0b1pScTBQOEFoSUM2dkxuQjdCUE5wcnJlSjNQZ0Y0T3VTK1dMd1Ja?=
 =?utf-8?B?QU0wK1pnbCtRcklzaGJzZGtFNU5YVGJkWHY5Qk9CY1U2RjdYRjE3VkRQTDI5?=
 =?utf-8?B?MmE4cHl5R1JsbW5TanVuMHUySHNoQmNQSGRvTEhGT04wQzlMSGI2dDZsa29t?=
 =?utf-8?B?Ly9BZWs2REwwMVZaSEIzZURJdGtydjVTMW9kT0xkL20rSGs3dFNrMk02cllM?=
 =?utf-8?B?WFRaa09wcUdnWlNQZXVFUGcxSDZnNTdQTmRQbGEyZzZBUkhYWDdKd3A4MFkw?=
 =?utf-8?B?STV6czFUMW1TR2R3VjR3UzZxblB6WFQ3QjB3UEh1K2RodGZFbHQ1cXYvVnc5?=
 =?utf-8?B?dDdNNU5MRi9reUxaa2tENGJlN0tQd1p6ZzY2RzZ5L05MbFJHSHM4TFFLWUZC?=
 =?utf-8?B?MUc2cXhMdU1LV1lLMXI4K1Y0SUhub2dIVFhBUDc2Wld4M1pSWEFabzY2UHhh?=
 =?utf-8?B?ZHJEaDNBVEoyMVRGSTh0NUxXZzB5NjRUT2ZlTDVIbHZjeStORlAyNGxOUDRG?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46815006-816c-4d72-2cdb-08dd880d589f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 17:35:05.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3USOQGRBZZ4QJDsd1eDnf8yjCTzxr9I9JsY3h3/d0p0+CdP331Clz3SpBvTEOdjltmY9pBhcdE2QRGCsr9scAh4NrC+EaH/tTDEhbxvaN3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMzAs
IDIwMjUgNzoxMiBQTQ0KPiBUbzogbmV0ZGV2IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsgTmd1
eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgSW50ZWwgV2ly
ZWQgTEFOIDxpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmc+DQo+IENjOiBLZWxs
ZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3Nh
bmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNs
YXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBp
d2wtbmV4dCAwLzJdIG5ldDogaW50ZWw6IGNsZWFudXAgUlNTIGhhc2ggY29uZmlndXJhdGlvbiBi
aXRzDQo+IA0KPiBUaGUgdmlydGNobmwgQVBJIGRvZXMgbm90IGRlZmluZSB0aGUgUlNTIEhhc2gg
Y29uZmlndXJhdGlvbiBiaXRzIGRpcmVjdGx5IGluDQo+IHZpcnRjaG5sLmgsIGJ1dCBpbnN0ZWFk
IGltcGxpY2l0bHkgcmVsaWVzIG9uIHRoZSBoYXJkd2FyZSBkZWZpbml0aW9ucyBmb3IgWDcxMA0K
PiBhbmQgWDcyMiBpbiB0aGUgaTQwZSBkcml2ZXIuDQo+IA0KPiBUaGlzIHJlc3VsdHMgaW4gZHVw
bGljYXRpbmcgdGhlIHNhbWUgYml0IGRlZmluaXRpb25zIGFjcm9zcyAzIGRyaXZlcnMuIFRoZSBh
Y3R1YWwNCj4gdmlydGNobmwuaCBoZWFkZXIgbWFrZXMgbm8gbWVudGlvbiBvZiB0aGlzLCBhbmQg
aXRzIHZlcnkgdW5jbGVhciB3aGF0IHRoZSBiaXRzDQo+IG1lYW4gd2l0aG91dCBkZWVwIGtub3ds
ZWRnZSBvZiB0aGUgd2F5IFJTUyBjb25maWd1cmF0aW9uIHdvcmtzIG92ZXINCj4gdmlydGNobmwu
DQo+IA0KPiBJbiBhZGRpdGlvbiwgdGhlIHVzZSBvZiB0aGUgdGVybSAnaGVuYScgaXMgY29uZnVz
aW5nLiBJdCBjb21lcyBmcm9tIHRoZQ0KPiBJNDBFX1BGUUZfSEVOQSByZWdpc3RlcnMsIGluZGlj
YXRpbmcgd2hpY2ggaGFzaCB0eXBlcyBhcmUgZW5hYmxlZC4NCj4gDQo+IFJlbmFtZSB0aGUgJ2hl
bmEnIGZpZWxkcyBhbmQgcmVsYXRlZCBmdW5jdGlvbnMgdG8gdXNlICdoYXNoY2ZnJyBhcyBhIHNo
b3J0aGFuZA0KPiBmb3IgaGFzaCBjb25maWd1cmF0aW9uLg0KPiANCj4gV2UgY291bGQgZGVmaW5l
IHRoZSBlbnVtZXJhdGlvbiBvZiBwYWNrZXQgdHlwZXMgaW4gdmlydGNobmwuaC4gSW5kZWVkLCB0
aGlzIGlzDQo+IHdoYXQgdGhlIG91dC1vZi10cmVlIHJlbGVhc2VzIG9mIHZpcnRjaG5sLmggZG8u
IEhvd2V2ZXIsIHRoaXMgaXMgc29tZXdoYXQNCj4gY29uZnVzaW5nIGZvciBpNDBlLiBUaGUgWDcx
MCBhbmQgWDcyMiBoYXJkd2FyZSB1c2UgdGhlc2UgYml0cyBkaXJlY3RseSB3aXRoDQo+IFBGIGhh
cmR3YXJlIHJlZ2lzdGVycy4gSXQgbG9va3MgY29uZnVzaW5nIHRvIHVzZSAiVklSVENITkxfKiIN
Cj4gbmFtZXMgZm9yIHN1Y2ggYWNjZXNzLg0KPiANCj4gSW5zdGVhZCwgd2UgbW92ZSB0aGVzZSBk
ZWZpbml0aW9ucyB0byBsaWJpZSBhcyBwYXJ0IG9mIG5ldyBwY3R5cGUuaCBoZWFkZXIgZmlsZS4N
Cj4gVGhpcyBhbGxvd3MgdXMgdG8gcmVtb3ZlIGFsbCBkdXBsaWNhdGUgZGVmaW5pdGlvbnMgYW5k
IGhhdmUgYSBzaW5nbGUgcGxhY2UgZm9yDQo+IExpbnV4IHRvIGRlZmluZSB0aGUgYml0IG1lYW5p
bmdzLiBUaGUgdmlydGNobmwuaCBoZWFkZXIgY2FuIHBvaW50IHRvIHRoaXMNCj4gZW51bWVyYXRp
b24gdG8gY2xhcmlmeSB3aGVyZSB0aGUgdmFsdWVzIGFyZSBkZWZpbmVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQpSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQoNCj4gLS0tDQo+IEphY29iIEtlbGxlciAoMik6DQo+ICAgICAgIG5ldDogaW50ZWw6IHJlbmFt
ZSAnaGVuYScgdG8gJ2hhc2hjZmcnIGZvciBjbGFyaXR5DQo+ICAgICAgIG5ldDogaW50ZWw6IG1v
dmUgUlNTIHBhY2tldCBjbGFzc2lmaWVyIHR5cGVzIHRvIGxpYmllDQo+IA0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3R4cnguaCAgICAgICAgfCA0MyArKysrKystLS0t
LS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV90eXBlLmggICAgICAg
IHwgMzIgLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmYu
aCAgICAgICAgICAgICB8IDEwICstLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2
Zi9pYXZmX3R4cnguaCAgICAgICAgfCA0MCArKysrKystLS0tLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3R5cGUuaCAgICAgICAgfCAzMiAtLS0tLS0tLS0NCj4gIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZmxvdy5oICAgICAgICAgIHwgNjggKysr
KysrLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3Zp
cnRjaG5sLmggICAgICB8ICA0ICstDQo+ICBpbmNsdWRlL2xpbnV4L2F2Zi92aXJ0Y2hubC5oICAg
ICAgICAgICAgICAgICAgICAgICB8IDIzICsrKy0tLQ0KPiAgaW5jbHVkZS9saW51eC9uZXQvaW50
ZWwvbGliaWUvcGN0eXBlLmggICAgICAgICAgICAgfCA0NCArKysrKysrKysrKysNCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9ldGh0b29sLmMgICAgIHwgODEgKysrKysr
KysrKystLS0tLS0tLS0tDQo+IC0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUv
aTQwZV9tYWluLmMgICAgICAgIHwgMjUgKysrLS0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaTQwZS9pNDBlX3R4cnguYyAgICAgICAgfCAyNSArKystLS0tDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfdmlydGNobmxfcGYuYyB8IDQ2ICsrKysrKy0tLS0t
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX21haW4uYyAgICAgICAg
fCAxNyArKy0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRj
aG5sLmMgICAgfCAzMyArKysrLS0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfZmxvdy5jICAgICAgICAgIHwgNDUgKysrKysrLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3ZpcnRjaG5sLmMgICAgICB8IDQ0ICsrKysrKy0t
LS0tLQ0KPiAgLi4uL2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdmlydGNobmxfYWxsb3dsaXN0LmMg
ICAgfCAgMiArLQ0KPiAgMTkgZmlsZXMgY2hhbmdlZCwgMjg5IGluc2VydGlvbnMoKyksIDMyNyBk
ZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBkZWVlZDM1MWU5ODJhYzRkNTIxNTk4
Mzc1YjM0YjA3MTMwNDUzM2IwDQo+IGNoYW5nZS1pZDogMjAyNTA0MjMtamstaGFzaC1lbmEtcmVm
YWN0b3ItOWFjMWUyYjgzYTVlDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IEphY29iIEtl
bGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KDQo=

