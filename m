Return-Path: <netdev+bounces-146865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190C9D65D5
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117182817FB
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A1187355;
	Fri, 22 Nov 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUO1bwR8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94C15B13B
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314916; cv=fail; b=rbdi4SkWiuXbYX+dEytPRG5Ng2QBqPpJtBPaV7xd4bQe95NXZv5BQcqv+ksltDn+Z552kMFCBkpd8Uj+MywrohX2QcUv3WRueCmgwkhE4iWTAhljQMFeyXVsCgO9e794uUbMDRc50fQLavpMWsqnvo/QUGpfeRHjTOqxcu/fRD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314916; c=relaxed/simple;
	bh=tTfUZsE1VfzGOoUDNK7mXRSBIrAQO9n3hpozLDpbp+w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLUKE0aVc+RtVn2JTfUgq0JaLt2wr+PNjVkCGmOBqt4QkcIQbrKBsFygLEUf43X0Jr+sdaWx7QadxbsfZx/NNqFVlLc1a3aC3tajj7o+gFEELsshIJMq5Pmc15tHmUpAqLVlpXWChm47EbpsR35L4TOWJflmr3xhIb1Oc1QwAek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUO1bwR8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732314914; x=1763850914;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=tTfUZsE1VfzGOoUDNK7mXRSBIrAQO9n3hpozLDpbp+w=;
  b=QUO1bwR8BxhoXCi7XbguDT0R8zPz/Gis0WwLINjBVmtYIgVds11mV0eI
   ZO9BiWSE3580FIIYSnYCC6lbH9llephVKSirumh0gVIqdM6JRAU76jIu0
   8Y0aLgOAbseLRN09U/4sK+dr3d1lwQN0Zq+Wz+tX//Z911Bks6hJ5n+Up
   6v16Cskx1uJswJqhzchiCikcttkqHvOAqMIopwhHlIm7LsQCnjJHXnrPk
   ZHyOTYX3ZoJiFOFlr7Yr78dmtbLpLFaUAauVV+eY0ylRmK3JUYFFJZioC
   Xb6l6tF5u8x2xr2e8IE4T5doO8TXER7GkHSROxn0PC0tFELejWqoCc8t3
   w==;
X-CSE-ConnectionGUID: XZMktLxJQ3SOG1ncGsKxuw==
X-CSE-MsgGUID: nFXoDLyDTyuEQzDsM6zsJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="54990493"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="54990493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 14:35:14 -0800
X-CSE-ConnectionGUID: iQdSr7hdQcuGGAYNuRYz5g==
X-CSE-MsgGUID: QclgbDCcTLWlJEq7DeaCwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91122449"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 14:35:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 14:35:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 14:35:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 14:35:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPNvTZAxc9BzfwvYadfc9aXU1mcfDS9MSPrb+1O80zkeiKMF/2NaxO2XfPqUqfeXtIlfJc5hDOmlXKr8WlzAzNGLHUhY8zOkDYht572MsVfWIHRMKa75lTtJhZQIgZI7F048g/J5jJ0w/egnCZz7dkQtttZjgIphGNZC+AjkjscXl1lODn8Y01DCFkK8GufZqrovfazC9uYIcA6JKORijFIMzlThS8/4+HX4YGbggH6B6U7LRNNzfkC30WL+lF4cOSJbFkgNpI7f3HA0a7dwI6QR1AsBD6TZ0Mddui0hPmaNoUxJpYIgA6ok4j1Czsxt/fvc4Ca8ROOYp0yKg8jyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTfUZsE1VfzGOoUDNK7mXRSBIrAQO9n3hpozLDpbp+w=;
 b=F86sraQEe3WBjR048rWuQ6XiOqRZCzKqAgn9nn7ZbCJT+RAvgHHGccmfcs9/FGJjQtvzoRWEmhgcyqfdcg9IGkTCgwSXaId3toThcuzn35ZkAxhh8xYMniB/OJ3KVKnb/UmTfQ4Um2rhTfzSeE2cfnEnSqxJZIvVE4lJvdkXVLhZKv6n3PxwIiA5vkm3zWiuHD+CHc295V7WO4A4vB2mmR+ib+KGZpUSBcty2eY5H79zYEecA6r/CuWiwdbSAwWwoeZ4nzGiVRrBB+0BtqBWA9TnXMaS3hHzO26HcARX2MuHsbKe7IJAXTVqTNQ4Dhi7olua1b4fqqawY2qCGlH8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22)
 by SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 22:35:05 +0000
Received: from IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73]) by IA1PR11MB6194.namprd11.prod.outlook.com
 ([fe80::4fd6:580b:40b9:bd73%7]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 22:35:05 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@linux.dev>, "jbrandeb@kernel.org"
	<jbrandeb@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
Thread-Topic: [PATCH net v1] ice: do not reserve resources for RDMA when
 disabled
Thread-Index: AQHbNiheW2jXC+EQOEikvp/7aLqJQrK3EdHggAGfQICACeRqgIABUSHw
Date: Fri, 22 Nov 2024 22:35:05 +0000
Message-ID: <IA1PR11MB61942704E6FF9FDEE627DE7BDD232@IA1PR11MB6194.namprd11.prod.outlook.com>
References: <20241114000105.703740-1-jbrandeb@kernel.org>
 <IA1PR11MB619459AFADE5BB3A515C0577DD5B2@IA1PR11MB6194.namprd11.prod.outlook.com>
 <45ce4333-57da-4c32-ad06-c368d90b1328@linux.dev>
 <acd9c54a-bfaa-44f3-94b3-85442277a65f@linux.dev>
In-Reply-To: <acd9c54a-bfaa-44f3-94b3-85442277a65f@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_|SJ1PR11MB6153:EE_
x-ms-office365-filtering-correlation-id: 15280767-6075-4523-e9b9-08dd0b45e94b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVpGYVNQdHdyM1U4ZXovYS9UR0J4Y0RlQ2FvMlMwTHYxSTUzdElVR0hQN2pD?=
 =?utf-8?B?Q0wwem92R3RRdi9henFRRFlESUJVdFd3bFJCbTNpMS92WmcvQUFtNjhiLzVt?=
 =?utf-8?B?a3N0bisxRWk5S21IcXVZeG05MkpaQmxoNEl6YTFnQ2h2TWticEtzMllWM2k1?=
 =?utf-8?B?SjlwWVUzWDB3R2VvQlhRVVppYjlxNklKcHVrWk10WjdYSHlmc3NQL1gveGpi?=
 =?utf-8?B?eURWYTBjdTJJSTZJcldDVVY1dkFRK1lVVHRVMVowUmtZQ3FXYlNyNTVXYStv?=
 =?utf-8?B?Wm1EalZ6elBvT2tCSUxzRnByc1pxNXNRL0dtV2hTYWtyNmdNU2dsOEFoUXdR?=
 =?utf-8?B?NnlKaWxUcXNtRUNEREN5M3pRQTFkaStNdTRPbVduSm01dFAybzJoQ3ZTSzAz?=
 =?utf-8?B?THcrNFV3UXpIYlVFRkpmK2wyd0luZ0poVWM5YWVEZ0owZlh0c0g1Nzd2MDVT?=
 =?utf-8?B?QS9zR1J1Z0haL2ZRSnRsYkduREh3Rkg2QzFkMWl0M0VUWnVMVlNKb29EYkVp?=
 =?utf-8?B?VWRqR3c3U0lUb3NaYWd6TTEvbFVGYlFURHZYZ0dYNzBrQ25yT0FXak83WjNP?=
 =?utf-8?B?ZXgzOUhOb1BReWZYR054WW9TUFN2c2htU0NPdDJkUXNWOTRoSkFETUEwOGRt?=
 =?utf-8?B?UFdKTVdFY3F6cjcyY25mc2dRRmtURHpWeUo5eG00QkNsdXhGUXBLSVBSeGFw?=
 =?utf-8?B?Y1JYWEtWMlh5dnd5ZHhieWs3WksycjkyakdocmZTc29PZmtramRSU2VTNW15?=
 =?utf-8?B?Y2VxckFndVVPOHdVR0hoNGluZjRhL3FxNG1iT0Z0bXN3RjJaQ0lxZFB1aFlh?=
 =?utf-8?B?U3RIdk5RNmp2ekxaREtoYU12NGlVbmkxZ1VZbzVIZ1B6MUQ3Szd2aHBYR1J5?=
 =?utf-8?B?eEI2TjdBWGV2M0pXdjJ2MFVWK0FlYXk1cFZsVXNna2x6ODlnZUt1b2ZpdTdu?=
 =?utf-8?B?Z2loblF5eXovbENNczNJdEUxMGtuZWhFQ1F3bHhIbFBBbUZ1WHZVWk8rMjlY?=
 =?utf-8?B?aHpUcWhZVm1GL1V5R0RPb2pVakJxOGYwbnUyUDdpbEZZMTI5M1VWUXpVOWpk?=
 =?utf-8?B?bi9vZ25EUHRvanpXNEdrZk0vekdoWmNsMWFMWUJJQzFmWUV0SUwrY3lsYytL?=
 =?utf-8?B?WklZTVRMZU1EcFMwTFpOMTJkd1djRU90MWF5WTZPSSsvR25WRnY4c0lSUWta?=
 =?utf-8?B?bTJaUmFNVm93VVRNTXA5T3Exc1BPZTRwS1VheFlHb2thMThhOExIU3VxTGpl?=
 =?utf-8?B?bEhRcG5LS2hnc0tPb0FRV3dPN015bnB5WE1xY0diVjIxTldkRkhlZGZ4aWp5?=
 =?utf-8?B?MVdiK0w2Y0o0RUlNRy9EQ0QrMzdMUEhGY3kvcjNkQmNjdlF4SWNnUllTY0Vp?=
 =?utf-8?B?aWk3YXpTZHEzWktuWllpckp6d0pBNC9qZEQ4Z0lzTEM0YkpsZG5OTnZiaWw2?=
 =?utf-8?B?ei9wRW1kaW15Q3IxSlhBZ2RWQVF0R04wLzBjcGs4V09Bc3BFZ0llRzJPc2hL?=
 =?utf-8?B?S0dZS2FRSWl4dGlYQmQzYmJVN1ZRaXV1V1c0a2xFSkN0bFhCSmx2QmROczRY?=
 =?utf-8?B?NzBmOTVUenR5eWEySWhrVWNnLy9mU2Y3b1lldE4xK2pBV2pRVExqUFFPTVdl?=
 =?utf-8?B?VEJ5ZE1qNmdmcGhiZGltVnh4bUYrT0lWSnhMY3BDeDViMlR0RDRXM2xLeDZl?=
 =?utf-8?B?aGZwY1hSditUVWRORlMrWlpwcU0vTmg3dWRNRk14TXU4Z0dTVlR1eGozN1ZJ?=
 =?utf-8?B?RXB0enJJU1RzZDlXYnkrbjI1L1IrZWFOaHNEcjh0bHRPTUlvdm1hbWJPS0FZ?=
 =?utf-8?B?d0RlZC96WEFZeGRSR2FSOTNkOVVBQ1BvYmtBd0NYckNxTTlCak1BbmJzU3hE?=
 =?utf-8?B?VTdWekFNU0JFRktDZHBZRVpaNEhjUXRrV2ZLbGVXTUJsVUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHpDUkhaVFJxbXNmdVp5UW5PNVlrTU5aYnVldDR1dTNYcndVUXhMTTI0UXpq?=
 =?utf-8?B?Lzh3dHgvSktuU3hqZ201NWRISFQ0RXFUYUlpaXNtbGlaT2QrSU5oTnd2b1hs?=
 =?utf-8?B?N0FDNHFaUTdyekNRQURwaXpDTTIyM2EzVDU1VWg5bG10d2xtb3doSWtub0pT?=
 =?utf-8?B?MEcrNUx3QjZDZ1RGNENyd2JCcjFXSkFsTmlPMytCN1Z4VCtURWtHamRDcXlr?=
 =?utf-8?B?d2xsYnpGVXI3TW9QZTN0Tzl6L1U4QWhTaXpEemNQYlh2VmFkc0dNbDdOMkJs?=
 =?utf-8?B?akcyQmhwWlp4bjZqZThETWZIdGlTTlgrbFlwSlpUVUJzbUJZSjdZQVVydGtz?=
 =?utf-8?B?UjlHbzBUSDVBK2ZpbXZIUFh2TjdhYm5Sd0pGTk9TLzNZendMY1J6aklrUGkx?=
 =?utf-8?B?ODJSQ2VpV3VVaW91N3IrMUxwa01nK3krcE5CRmFXVUEvWVR6Umplc25jdnUv?=
 =?utf-8?B?U1ZKV1FRQ2pNUlhML3lQYjlidnhHVmZnR3grTmhSQUFwS013WUp3MS9Nbk9p?=
 =?utf-8?B?aDIzN1ROZm1IcXprWmtqZDhoRUo4dmFIL1IwRG02dkEyNmZoajc3V0dHNjNZ?=
 =?utf-8?B?bUt1VlNhZE1wR2wwZ3RxdDJya21VNDN5cVdRbXRnc3NOQ3RTYkJUR3o1OG5H?=
 =?utf-8?B?MU5pU216RkY4VnRJSDBZa1VGU09TRExsY2Juc1I1QnlVRUR3ZEMxWS9BeEt2?=
 =?utf-8?B?UjdIeDBPZStIWUNrajl0Y3R5c2RaRWpFZThieElmRlRjeXJzV3Fxb01pMFp1?=
 =?utf-8?B?WDg4c2dCdWpKVVZsZkhNNGZKWEVKTDA5VWlXQnlvS2tFaHpGblExMEVONmww?=
 =?utf-8?B?OHBNRjBpbmxFdERscjFoVFdjSE93eVd0TzdYeUlFaGlMK05uQlNWaFpSOVNm?=
 =?utf-8?B?enFITUpNNjZkQzB3R0RwRnRCL0pUdkQzSjNrQ2dXZ1V0ZE1YU3ZXZW9nRzZD?=
 =?utf-8?B?dGJxQ2xzanM3UEZHZE5ZZVozWUV3bG9menRaeU1uSUEyY3R6VVJrd2lQT3Q4?=
 =?utf-8?B?MFBGZE1aK2ZKVHhKeG0wNVh6MnBzdnlpV1JXS0xwejBHSXZtZEo0UGtPU0hK?=
 =?utf-8?B?MUZvVDFvV2VjZVBWWUlHY0l2ckJDam0wYmRLMlFjZC9tc2tuNWpDQ1RKYVFD?=
 =?utf-8?B?VlpZeGdhNkM3akMyVTJWbUVvajBMaW12amNIWlZLUGhjc0JGZEhEYWVlU1RW?=
 =?utf-8?B?S0lObXZ0Yi9TS0IyRDFjMzRJZUoyNmdPaFhQemw1NytWV2xzZEhCR2Flelp2?=
 =?utf-8?B?VjVuMlMvVUQyK2V5bzJ5S3NPZTJORFQ3WUswRHZNNWQ5dnlXbXd6eTFqT1p2?=
 =?utf-8?B?bFFtTU51WGZDdTYvaGpnOTFuV25icCtSaG5xallMMjhQbTR3RGtnN3phMkZW?=
 =?utf-8?B?UmJtaHV3VTdCRWVMS203TDZKUUZOTmdiMWoxdk5YTGNqTGRZcW1JQkM5TTFX?=
 =?utf-8?B?U2FEU3VNM0ZXU1B4aW8vS0Jlekxzc2ZCOE5yUjZhaUFqQkNLSzY4QnZUa3d2?=
 =?utf-8?B?djhuYXdqTW9EL3QvY0JwKzgrQkxzRlh1YllmS3RxTUU0VlNaZXF1MllRUlpu?=
 =?utf-8?B?VHVqU2xqY2Zudy93YjZCRTJBK2JBYkFoYVZESXpNU3U1YmVUQ0VzeDNJdDlr?=
 =?utf-8?B?dGppNElmeEhObkxaMGR0a0xVWXpnOGx3VmhLRlB2N3lhcy9EODdPUTd3THZo?=
 =?utf-8?B?U0J4Qk1uMEZRNy9PcE5mZ2dVT0I0MllBMkFacVQ4QW1uTjVOUXVBdkFmYU1v?=
 =?utf-8?B?WG5DdTgxRGNsYU9VMldkdm1iTWZWTE5Tb2tVajRoWUJNM0pYekZaUzlwVFZV?=
 =?utf-8?B?MmpHTDJFQkNLWWlpaWZWRUZMQ1UzRm5wTEtiNWNvY0pQN1dxNVVpQ04wbWRk?=
 =?utf-8?B?VTZteWIzTXp2TG9UMGUrckNDZ2NMNDdMajhkcTlJTEQzYTZVZ2pKNGZwTzdn?=
 =?utf-8?B?bjJSMW9qY253SThSOXNZTURNaFFZYk04ZDVLQ1g0M3BUZFdlMksxd01xNnRO?=
 =?utf-8?B?eG5JTFJYcmo5WEV1VkRxOFFsYjJNYS8rcDNGcm1qa0JyU2NJbXdrUUZ2bXQv?=
 =?utf-8?B?SUhVb2V2Z0pqaGY0czNzVXZTc2NlZ2RDVGI5cmQ3b2l5MnpON0FscDJMemlB?=
 =?utf-8?Q?SmX15J4zx8oghIsZhKfijKYFd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15280767-6075-4523-e9b9-08dd0b45e94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 22:35:05.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slJSFjDBv6AOucl92eVXXERYU3lvi7gD/L2ux7fik8J9SkX2iTkWWMxLiCjXj5fAfCPIOd1tvEmVnMZ7IoxnVxNWh32LXbjTe4WDwkhshjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZXNzZSBCcmFuZGVidXJnIDxq
ZXNzZS5icmFuZGVidXJnQGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDIx
LCAyMDI0IDU6NTAgUE0NCj4gVG86IEVydG1hbiwgRGF2aWQgTSA8ZGF2aWQubS5lcnRtYW5AaW50
ZWwuY29tPjsgamJyYW5kZWJAa2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MV0gaWNlOiBkbyBub3QgcmVzZXJ2ZSByZXNvdXJj
ZXMgZm9yIFJETUEgd2hlbg0KPiBkaXNhYmxlZA0KPiANCj4gT24gMTEvMTUvMjQgMTA6NDYgQU0s
IEplc3NlIEJyYW5kZWJ1cmcgd3JvdGU6DQo+ID4gT24gMTEvMTQvMjQgMTA6MDYgQU0sIEVydG1h
biwgRGF2aWQgTSB3cm90ZToNCj4gPj4+IMKgwqDCoMKgwqAgY2FzZSBJQ0VfQVFDX0NBUFNfUkRN
QToNCj4gPj4+IC3CoMKgwqDCoMKgwqDCoCBjYXBzLT5yZG1hID0gKG51bWJlciA9PSAxKTsNCj4g
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfSU5GSU5JQkFORF9JUkRN
QSkpDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXBzLT5yZG1hID0gKG51bWJlciA9
PSAxKTsNCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpY2VfZGVidWcoaHcsIElDRV9EQkdfSU5J
VCwgIiVzOiByZG1hID0gJWRcbiIsIHByZWZpeCwNCj4gPj4NCj4gPj4gVGhlIEhXIGNhcHMgc3Ry
dWN0IHNob3VsZCBhbHdheXMgYWNjdXJhdGVseSByZWZsZWN0IHRoZSBjYXBhYmlsaXRpZXMNCj4g
Pj4gb2YgdGhlIEhXIGJlaW5nIHByb2JlZC7CoCBTaW5jZSB0aGlzDQo+ID4NCj4gPiB3aHkgbXVz
dCBpdCBhY2N1cmF0ZWx5IHJlZmxlY3QgdGhlIGNhcGFiaWxpdHkgb2YgdGhlIGhhcmR3YXJlPyBU
aGUNCj4gPiBkcml2ZXIgc3RhdGUgYW5kIGNhcGFiaWxpdHkgaXMgYSByZWZsZWN0aW9uIG9mIHRo
ZSBjb21iaW5hdGlvbiBvZiBib3RoLA0KPiA+IHNvIEknbSBub3Qgc3VyZSB3aGF0IHRoZSBwb2lu
dCBvZiB5b3VyIHN0YXRlbWVudC4NCj4gPg0KPiA+PiBpcyBhIGtlcm5lbCBjb25maWd1cmF0aW9u
IChpLmUuIHNvZnR3YXJlKSBjb25zaWRlcmF0aW9uLCB0aGUgbW9yZQ0KPiA+PiBhcHByb3ByaWF0
ZSBhcHByb2FjaCB3b3VsZCBiZSB0byBjb250cm9sDQo+ID4+IHRoZSBQRiBmbGFnICJJQ0VfRkxB
R19SRE1BX0VOQSIgYmFzZWQgb24gdGhlIGtlcm5lbCBDT05GSUcgc2V0dGluZy4NCj4gPg0KPiA+
IEkgc3RhcnRlZCBtYWtpbmcgdGhlIGNoYW5nZXMgeW91IHN1Z2dlc3RlZCwgYnV0IHRoZSBJQ0Vf
RkxBR19SRE1BX0VOQSBpcw0KPiA+IGJsaW5kbHkgc2V0IGJ5IHRoZSBMQUcgY29kZSwgaWYgdGhl
IGNhcC5yZG1hIGlzIGVuYWJsZWQuIHNlZQ0KPiA+IGljZV9zZXRfcmRtYV9jYXAoKS4gVGhpcyBt
ZWFucyB0aGUgZGlzYWJsZSB3b24ndCBzdGljay4NCj4gPg0KPiA+IFVubGVzcyBJJ20gbWlzdW5k
ZXJzdGFuZGluZyBzb21ldGhpbmcsIElDRV9GTEFHX1JETUFfRU5BIGlzIHVzZWQgYm90aCBhcw0K
PiA+IGEgZ2F0ZSBhbmQgYXMgYSBzdGF0ZSwgd2hpY2ggaXMgYSBkZXNpZ24gaXNzdWUuIFRoaXMg
bGVhdmVzIG5vIGNob2ljZQ0KPiA+IGJ1dCB0byBpbXBsZW1lbnQgdGhlIHdheSBJIGRpZCBpbiB0
aGlzIHYxIHBhdGNoLiBEbyB5b3Ugc2VlIGFueSBvdGhlcg0KPiA+IG9wdGlvbiB0byBtYWtlIGEg
c2ltcGxlIGNoYW5nZSB0aGF0IGlzIHNhZmUgZm9yIGJhY2twb3J0aW5nIHRvIHN0YWJsZT8NCj4g
DQo+IEFueSBjb21tZW50cyBoZXJlIERhdmU/IA0KDQpKZXNzZSwNCg0KTG9va2luZyBhdCB0aGUg
RkxBRyBhcyB1c2VkIGluIHRoZSBpY2UgZHJpdmVyLCBpdCBpcyB1c2VkIGFzIGFuIGVwaGVtZXJh
bCBzdGF0ZSBmb3INCnRoZSBlbmFibGVtZW50IG9mIFJETUEgKGdhdGVkIGJ5IHRoZSB2YWx1ZSBv
ZiB0aGUgY2FwYWJpbGl0aWVzIHN0cnVjdCkuICBTbywgSSBhZ3JlZQ0KdGhhdCBhIGtlcm5lbC13
aWRlIGNvbmZpZyB2YWx1ZSBzaG91bGQgbm90IGJlIHRpZWQgdG8gaXQgYXMgd2VsbC4NCg0KU2lu
Y2UgdGhlIGtlcm5lbCBjb25maWcgdmFsdWUgd2lsbCBub3QgY2hhbmdlIGZvciB0aGUgbGlmZSBv
ZiB0aGUgZHJpdmVyLCBpdCBzaG91bGQgYmUNCk9LIHRvIGFsdGVyIHRoZSBjYXBhYmlsaXRpZXMg
c3RydWN0IHZhbHVlIGJhc2VkIG9uIHRoZSBrZXJuZWwncyBjb25maWd1cmF0aW9uLg0KDQpTb3Jy
eSBmb3IgdGhlIHRocmFzaC4NCg0KRGF2ZUUNCg0KQWNrZWQtYnk6IERhdmUgRXJ0bWFuIDxkYXZp
ZC5tLmVydG1hbkBpbnRlbC5jb20+IA0K

