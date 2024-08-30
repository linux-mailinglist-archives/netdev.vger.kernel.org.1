Return-Path: <netdev+bounces-123702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A038F966372
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD63FB23B81
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3131192D6A;
	Fri, 30 Aug 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Azc5uWwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3718C001
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026034; cv=fail; b=sVeCisVepxfxBdvkV9zvULKLzqlqKmlzEsYgiVvKE5qhDwOz5t4dYJbNaMi+hP9VJg1XV46ANsCRZ75uxm5IeWV3ItTqXYC3oVs3/m2wB9D+DoMFf05YbJZ71rde2hsvaV/961LQ2BIRxwUrerweSP4/vCQRqt+B7LdSvrlQPxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026034; c=relaxed/simple;
	bh=hLujCa55Eo614OvV9WcibAZiOIAdh+w59o6VqufIKDU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rz6yYJp4Q1JykjSJLlHX2qSv/pSaYmI0ESR5jGDat+PC945B4eOUKGM0QiKPeCU0+loZ0ZLL79nwARpeoPQrKit2h/MZMnUJtKs/VFrJGTdUIDhJEelFtVqR2BoMaf2GIngg4WQF65t52WS9FAXsnn7Omf8aOROO7Lvweatrpfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Azc5uWwu; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725026033; x=1756562033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hLujCa55Eo614OvV9WcibAZiOIAdh+w59o6VqufIKDU=;
  b=Azc5uWwuVsI6tzFZEExM5G9JryKMMWgfA58CrSMsrQQpz8ni4ooYmABU
   loBTBVuSWfVRHqzUBtB+9jHMk8dEbvcqnfcP0z46CxfBwDu7f7wM5ydwx
   P8DaXDIuucleypEv4Axm6cad1fEPnK9s3NELlGzDXeKBu1J4hDf9UfJic
   XUsLQ15eTOCEtZ0wZwdeLJC2ydG06LyH9Zjjk91ZrkZpGUj4cqoPsSF72
   RQJeoRyRPQB6pd3bKQjrH+Yfol73mZug6RBnGw6iDRoHP7zUi5tbNLMRK
   BJRuCfIXrKaZD2DGvQ68+p5rNbjukVnFTK0/SFQ0iV7EoUXNSqaBbJ8XL
   A==;
X-CSE-ConnectionGUID: 4ktoIOONRnGayi9tUO57Gg==
X-CSE-MsgGUID: 5Jc+4oP8QVigOFDRihqmNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13297836"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="13297836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:53:53 -0700
X-CSE-ConnectionGUID: /3h21ZvqQdSQfDPMkb4OtQ==
X-CSE-MsgGUID: OovhOpANSb+jwE2ZQaEFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68308527"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 06:53:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:53:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:53:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 06:53:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 06:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/qocyhdGdrhKcOqdtfr0FIUxn/WrmoeWqPieh5teyRiw3RQPIVe8/ou3LljXmW/mPX/KQzU1eQm0owW4maU7iMnJcmxBGJ27+cHBZubxZl7D528TvjkLlh14fu8B1AcffFut6AaHfmlP1eaCGTYRs2De+iIDDTC3TKQCIHCE+BIPCoqM3jPAQvaB/UmQkD4qms8NFk5vO6cGlxX4JXPDQxSsPCiv6jwmAm/AvuQ41jTzUY3DTztO1stwJUlQO42wHxRWik56460zVPdYm1dDkG7wpQ22/wE/kplnG2PPi6yw00dhKj2qXDKnGioOq6QPSIps/d1nd/MooxHqxIa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn8hL3uQIFtX8pcMO1YGhPf1yhiaY1KVka3lYM7Xx0M=;
 b=ijm95I55h0A7olon476arPyJUgWstJZY+zg6l1ohwGOhWETICapMbZNIxNuKE1PSlwlMrU6fPdXlx54ljOsXdRtXVRWlNgo6qsrIE6fKXjRK7SNzUm61A9QJXnZFyXThanWtyaSF01JZxLD2U8UVbDHZEA5l7uPi7GF5QoxNjP41giE5TcO+FbHhN8VVxXEm42C3cUp+0slYs2V9o/UIdqZX1QjtE+jXpkOtk6Aa9Fb74TO25wnyF4K1GfG2EjfL220Fjewvy1IkFSDH2ly/+nF67VAJN+A6ZWc3OytlUMD5auiuJCUuXreOzpJOEZmmKiq3daep361n799pfp1irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB5973.namprd11.prod.outlook.com (2603:10b6:408:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 13:53:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 13:53:49 +0000
Message-ID: <1811760f-ea09-46cb-9918-b8f46995b415@intel.com>
Date: Fri, 30 Aug 2024 15:53:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: sched: use RCU read-side critical section in
 taprio_dump()
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240830101754.1574848-1-dmantipov@yandex.ru>
 <20240830101754.1574848-4-dmantipov@yandex.ru>
 <857dceaa-7ef7-40c6-b519-2781acaa8209@intel.com>
 <905b141a-7c7e-408b-bcd1-7935b8fdba0e@yandex.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <905b141a-7c7e-408b-bcd1-7935b8fdba0e@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7efa1a-8d1c-435b-0ffd-08dcc8fb2c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U05ZeDZtRTlyWGNWOVBPQlhWWnpOSDFjYXVlemZVa2pZMlZBU1lOY1BhaEU4?=
 =?utf-8?B?bGhPbkc0cGNualgwOUpJU1NjbGsvdjVTeTV5MXlrdzF0MGswS3hpZnFYRW03?=
 =?utf-8?B?dDBJUGtldkQxK3BRVk1uU1Eva21IdzUyRHQ0SHRYZ3lYeXdaVjhBVHp4UUJG?=
 =?utf-8?B?S3FwWVZaMXJicExLY1laMU5RblF6T2NxbFJHN2IzS0xHQTFlTVhKWDhRZFJQ?=
 =?utf-8?B?Q2FLZUtDYk9BUTBPdjRhVWlRZERmYnlzY3N4Y2dWb2NlWE1sNFhYRzdWREdn?=
 =?utf-8?B?KzQ0Q1kxZUVtdTNqakJORytmQk4vYVdrWFR1akU0MUFWeDVvb3N4cjBLWGpD?=
 =?utf-8?B?d3o1RXJTeUtYYXh3U1pDdWVrRHpzNDlsc0h1WU1raDNWbk5Va25aMzFXNmJi?=
 =?utf-8?B?aU1OYmZRN3B2Rjh1NHFlOHZ0QkVvalo5d2ljZ2dyakVxS0tqL0p5RFh2Nmdk?=
 =?utf-8?B?NDhsenFnU0dKWEF2ckRoQWJWZjlxcnpCTWUwNXN2OGU0UGpRWjNQL1lwdjNB?=
 =?utf-8?B?QnBYZld4RHJZWXphdzFiK040dmZ5QTM4cmNWSjU3d3lYNUpuRldwaXlFU1JP?=
 =?utf-8?B?bGJiem5uK1Rhakp4czNCamtraktpM04zZzQ4bVFVR2NHdXZGQzBYR2VTeno5?=
 =?utf-8?B?UVJVWGtBYUx1RDIwYnM5Sm9NWVRZRTFidEEzSW1GNWJSejJ1bFV2ZW9sVkRq?=
 =?utf-8?B?cVd0UDVuZnBOUVRpeUp1T2UxczhMUTRkRmQvbXNKZVI0V0UzVUM1NHVHSHpD?=
 =?utf-8?B?UGRaaTVjS1BlVzFWQ0ZCSXZWdVJBcW0wSWZKQStvWjhGK25zcE10VC9YVHl2?=
 =?utf-8?B?TmhqbEpxczBqVGdoT1U5L1U3TjVpdXROOVIyaFExc2xZbXVPcitqeVhVRkdy?=
 =?utf-8?B?YVNPWjRoem9yRFE1RmNMcjh3d3dZTHJ0OFJMeXpSLy9rTW0yM0JGdkJZd1Vt?=
 =?utf-8?B?U0ZuWEtOT3hwQ1EzVjhJcTJJTWwzRnQyYVpoSllSZnowM1owVXN1cEZ4aExk?=
 =?utf-8?B?VXRSMVFLMEg3YkVKK1VDR216bTJoOXFraHQzTHZQVVhGeDRLeGVWTlZPc3JZ?=
 =?utf-8?B?cHdTZitBQmpOaFpWajZFdUZZUEFCdmYwUytyajI4bi9nYlFxa3VUK1VDTGJo?=
 =?utf-8?B?THZVMUFTZlFaYXRlM1VIV0tvOEdKSVRQYVVlRVJnSHQ2aHlFbkRNYkQ3V2No?=
 =?utf-8?B?Rm9iRjl2TWFnWW5nclRaMEl3SjZGTlpJbVVQamtPaTlaK2hYRndzWm5kYjhi?=
 =?utf-8?B?Nmh5dnRPUlY2MXMwdW1rRmtJZ3dlYVFZbXZQZEZrakg2cW5lWG5UMG1UVVM2?=
 =?utf-8?B?WURFQUpZSENqd01YOGx2SEZoRTI5Tm9KenFiNFIwTU94bVdyY3hOaVJKMnlt?=
 =?utf-8?B?Y3UzNDhFNHQwMktzSDhMN25SbGk5K0FVTURBMW5TNCtaekM5RUR5c2RXY3lv?=
 =?utf-8?B?dkFOZDlsU2lvSTI4STZrUW5UaGRpcm4zTEM5bUhvQ2RuV2xIZEVYZ01oY2lV?=
 =?utf-8?B?SzRGZDhGN1kyME9LTDQwSGlzelU1TThwMmZueTE4STY1emkxUCtZTkVBZVh6?=
 =?utf-8?B?UnN5SFVwRE5obVVaN1NScFRtaWVCbXYxMitwMjRzRDJLc2VvT1RIUDNSZU5T?=
 =?utf-8?B?dUNTU1Z5S0RTKzloM1h5TTJZTHJJZlZneGVoV2RiRUZUc3plOVRuNVIvbjFa?=
 =?utf-8?B?bWdJeUthWUZkUzliSFl4elVsS2tkVEtLT3JyMlUrN0tWSEFITGJ3dzZ2M2l6?=
 =?utf-8?B?TXZEVnJqcS9Da3VwdWV2eVV4c1hMcU9yM2RsTGZVb3lJZHlZUlVSazZRanpU?=
 =?utf-8?B?VlJqQkJmRmdwVGFWYnpPdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25zNlYxSWZ0OGdyaDNJc2xlRFcxYVJyRXYydXNsaTI1b2x4WDlDZ0VFRVA3?=
 =?utf-8?B?cmZHaWlPT1F2c2ZYaWlHZHNIeVFzUkV6UVVSTXJyc3d4b0hGbmh1Z2pjSWEr?=
 =?utf-8?B?elBJUFAyckdLaDNrc3hKMUg3M1JYWmtoVThpY3pqc2J6TjVyWHkzK2doOGpm?=
 =?utf-8?B?Smx1TlB0b2pDWjFIK2l5cE95S2J2bXBqNHZwaHVqNVQ3NytYaVArbWZmYkph?=
 =?utf-8?B?aFlGUzhHSEVocy9IM081SndmanJ4RGgzMEx2MVdIMVdsOEhjdVdwREJUNDVl?=
 =?utf-8?B?dEZlNGwzSCtBS2M3dXNiWFljMzg1N3kyRTMxY0dFQnByZEpkZkxpU3VsdFFB?=
 =?utf-8?B?b2piaWNlMjdkV3JvMnNVdWowczZwY0R0M3c0RFZXc2IvMnpHdDVvcFV6N1lB?=
 =?utf-8?B?WEx3bExHMllGWE9SWUxmbDYwY2ZpalllekVabUk0ci9xSnBmUUFiS3ZsTHpQ?=
 =?utf-8?B?SmdUZW1Lc3Fta21yVWZ4ckxtVE5tTlppNFNraTlja2xuZ2Rkdkt3d3ZZRUpU?=
 =?utf-8?B?cDFlNWZ3d1hPT3JFU3cvRzZvSDhsWUxOYzd3eEsyek9PY2RXUEg3bGJVbHZB?=
 =?utf-8?B?bXdMNWhuZjhpZVYxbjFJZEljZE9qTzA3bk1BOXBsLzZBZ21hSXZBVWc0SFJx?=
 =?utf-8?B?K3hNWDNSWTYvdTNRNU43cENxVHNhdHErMnNtZE8xNWhIUkk3bkpHNTIxcEds?=
 =?utf-8?B?S1pCb2IrdkJieWovbHZ3ZGlGQTNUazVmd1J3UTMwMkhPUVRtYkhrV21IMFZs?=
 =?utf-8?B?NUNDcEdEZ1A5dGVrTGRnWGdFSGtuYTIwQThUcWtBUXl3bVRPS0o4Skw5eThu?=
 =?utf-8?B?VWdJam9lU2pUVDkxb1VJYkpTM2VFYVJ6NldnRTdUOHFPSlpvNDdrRk9PaGQy?=
 =?utf-8?B?NnROSTRsVDNMWFJueVBETm01ZTFockdIditENEFTSjJSQlhRMGcySVZBWWQ3?=
 =?utf-8?B?V2R6OEs3T09aWFkzYXF4WkZEZElCRU5weGpLSFBQMjFnQ1F3a2o1cS9ZbHBB?=
 =?utf-8?B?ZldmVG03V1hqb1pCL0YvcjFmRlZpQk1EU0psMk1pMjY0U09Kc1BnRkFNS2lx?=
 =?utf-8?B?R3ltNDI3MklJQVBTemZXWGF0TzNobEhXV285b0o2am4yUmNDTzQyekM2dmFo?=
 =?utf-8?B?RDlReFozYTZjdWpwaWpGME8zanZhRTgvdVRkOU85Q0YrSUE5SHhoak1IK1V2?=
 =?utf-8?B?aHFDa2dIUys3WC8zQUZEK0xKUU0zdDhPMS9jYlRJMUdKaGhpV241NWFuNGFO?=
 =?utf-8?B?NU03ckVVV0NUNkdVaTJXTmFLdzdEdkdnL3JOSWFDZFJZck04ZFVBd2RXbEIw?=
 =?utf-8?B?bUJRMzJ6T3RQNUhTWEIrcjFBVUlqMDkyQitxZ1JtRmtCTC95R1JwREx6Q0Js?=
 =?utf-8?B?Nlc4T2tUbG1qeHdFbUQ2MHkzN3ExTHdDNU9KV1prcnVnUjRBYnBHUDJTTzRK?=
 =?utf-8?B?Um1za2NXNUlMNUlLbWhjQ2p1djQrMjVnUlRJd2JFZXdHU1pycEZzbk5kWDMv?=
 =?utf-8?B?OWRiS2UrWkhUd2ZLakZIRE9FMWhmQXExNXVSWVdtZW4yNldkZ3l2dVJQTGRa?=
 =?utf-8?B?MEJRcnI3eFZWWHM0Q2RtRWZVRU5vTjRBamNab3l0V1VVa2kxTXdXRlhsaHNU?=
 =?utf-8?B?alB0NFdBUG96OUxjTXROMGs3aUJqQklqQUh6cm5XYVRHRmpBY1JHalJtTVM4?=
 =?utf-8?B?VDYzbmJWTUZZZjgvZWZiZ2V6RFU5bC8yZEVOZEtRb2xmMENEYkdVcUJCd1pa?=
 =?utf-8?B?MlR3WnNTV1o0Qi9lZjF3L0M2RHFLc05qMlJVZHVRU2JlbFhhM2JQNHR0TnBh?=
 =?utf-8?B?OHk1eGF3d1MwNVpqcS8wY0RPWGFkV041Zmg3SEN5L2xOQ1JLZnR4bkNNQS9X?=
 =?utf-8?B?alBicXcwaFBma0RkY3hueGk1VU5VU2ZqZkJNNmVDQ1Uramp3L1lINVFaTno1?=
 =?utf-8?B?dXlpbWF4K1o0Mk9lMWFzQXh3WDUzdDdMQ1hnMzk1Ly9FUEJPUjN5Yjc2V1VB?=
 =?utf-8?B?Ky8xODhTSmxlVVVuaXNWRGk4eERtTVVkd1NGanpFMEZic3VqOElhL3UzUHZz?=
 =?utf-8?B?cmZCYzJ3WUE4dkw5b3RjbzM3dXVrMTRwVlFCVkI5ZlBXSHhxb1p4Z3oxcDls?=
 =?utf-8?B?QVlWU2dlTnU2dUZyRUlLK09HV2hyekttYStZaFpnRXpwK1dnd2JtN2tSdGls?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7efa1a-8d1c-435b-0ffd-08dcc8fb2c72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:53:48.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdk3P14WZFDxoBao/hSUeEow0ZJ1tABvmsvnrNl6ITqM/6WnqL08Kmv+3Fmqt1UJELvjHUJEW1Em3ZZylZa2hU1Kjq/LkXx/OYlVzhePzik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5973
X-OriginatorOrg: intel.com

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Fri, 30 Aug 2024 16:48:39 +0300

> On 8/30/24 4:02 PM, Alexander Lobakin wrote:
> 
>> Why did you invert this condition and introduced +1 indent level?
> 
> Just to reduce amount of labels and related gotos. After adding 'unlock'
> at the end of RCU critical section, it was too much of them IMHO.
> 
>> The original code doesn't have nla_nest_cancel(), why was it added?
> 
> IIUC both original and new code has 'nla_nest_start_noflag()' and
> 'nla_nest_{end,chancel}()' calls balanced correctly.

Ah sorry, I haven't noticed you removed the related label below.
That's why it's not a good idea to refactor the code in the patch
targeted as a fix.
You just need to fix the actual issue, not refactor anything / change
the code flow.

> 
> Dmitry

Thanks,
Olek

