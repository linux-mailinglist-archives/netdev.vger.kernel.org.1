Return-Path: <netdev+bounces-178802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E6A78FA8
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868553AFEFA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908A1E5B7E;
	Wed,  2 Apr 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNtcxBOy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19871D540
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600195; cv=fail; b=TBXloQHdj1acF2yQIVgJ3Oc9CwfGqLEJsWneKmQ2ilbME9xLMOi4ZyDLCSqpGnbosJ8JW6xF7R5KYg/dtAfGl0OB++rn2uhVxs9xPDnxIyd1Bi+24lnAasvAGxCQz+vwgV3av3/z8lFOZrt2LLAzGh1OBLCbkTiJ4ictcWPleu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600195; c=relaxed/simple;
	bh=ZFWw0SibSUrgMUiBh0boFMKv66KPwdDCQhJOgQs4IHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6kD9qV0fRiAa7TCOHf81fOLVhEZB2hY2BpTyY1uSkmhe46AJ7zHow3wukdZp2a9s9j6setrbEiCQH9YGRaHh1b3I9NnJNyyQelkZLaQ7iiEBMu5CA9Pd9TsCaftPlp8TPEl/xqd/Y3qfvANPHzlSPg6uBhuOtQvEkwqlX0YGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNtcxBOy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743600190; x=1775136190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZFWw0SibSUrgMUiBh0boFMKv66KPwdDCQhJOgQs4IHc=;
  b=gNtcxBOyhOm5GB9Jk4DTDpBGHUY+pLR42ktt2B0bk0fqDwuyOqODB5NB
   riVn+s1x8nGqBUpAo2r0MICndk8uKvxAbbI8RKbj9a/Jm7402YXXqi2P5
   nwFNGq8mN8GCHsHa+Ykcy6bvKAIHroLfElZ3DJ8rgNCh3yhbBw9Oengq2
   FVF/emxuKIEVCBbm+hoxrxOnyR1KVmerOjZl5Jxp+1klK72ErVZj5QXps
   9wtKwCt1ApLWubc/HskMlh1MMjDaTtV/dodw91o48ZbzuXcPu6cd9LFBi
   OXOgBmhheavwDB1Y/iByV97fuuRa+MCQFnzifHEws3nZ6s+ysQyjSQRQQ
   A==;
X-CSE-ConnectionGUID: itY3OyBpSdyjY/xH8/UWTQ==
X-CSE-MsgGUID: 4rGrpL4jTmquwh7badGoTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44114397"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44114397"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 06:23:08 -0700
X-CSE-ConnectionGUID: 8D+83FX/SqaoGRPTf1I/Pg==
X-CSE-MsgGUID: qUavKSQ2SbqYezdpj/e/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="157654450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 06:23:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 06:23:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 06:23:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 06:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGYU+zID7FybGkYjq3XqMQwWHDt7tj8mEsFRfxkYWwDcfe+w+HhVliaaaLU5/9pozrxRKrfmfsTF8njirPtuU/0vj1KDI7dmKLogAoCKv6NYVIBGIAuqtFYaGPgCtZVuRBsWsFCuZB+rUma5zZf4NHLoUm5CO70JLlEHJHdC/id3UlSFp4UHRaL5nxDwLjTK2NrdYiTqUHe+MG/ZFQIrVft24OhfLnKeFQqLtQPaKW1fPad9F0XloSVjsou7flHwLsTpJypoGMH1WmuyKZRLkFUw1tk2TBmGqdOv4CNh1pEfGeYoULDiHTNCkGOqt8YSbSmLxOgfc4oSJPiLb40F7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bygwjqKD5e+Plfn1+JCHcdgiYzY8L5BYdD1dYBRx25o=;
 b=UTaIWbPnbSyJhadPp2kKCzJhVP4XXMkBIp3mg0X047HORpLHpa5WFcPwemjK0kJdR1rOA0s8FcNz+YsFhY+I/1Jf1SWr1jNJwxwrwPL0WsJpHn3zl71BKgA8oC0olStfzn+iyA06vknC6AX+t3BlOAKLeOWmZLNCS1GOFbV35aqF63HZ3PpSmntFYpJtbLFYKdgZrK638fja6VHI9myb0Z1F9azSqRYunlmQKEZBZVOeEhmIPrDIpGc8bBsOkE6No1ysEWnDt6UlW2LXBNNzFJLeapQ9c0suLaF0HiPbXX9arXmuPdS/upenhvlqxwSmAc+ogA7s2qV3B2aETqcAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 13:22:45 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 13:22:44 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Dumazet, Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Salin, Samuel" <samuel.salin@intel.com>
Subject: RE: [PATCH net-next 10/10] idpf: change the method for mailbox
 workqueue allocation
Thread-Topic: [PATCH net-next 10/10] idpf: change the method for mailbox
 workqueue allocation
Thread-Index: AQHbmCC4LDKTYvRqoUaIvX4rM6ozrrOEY/sAgAwPa4A=
Date: Wed, 2 Apr 2025 13:22:44 +0000
Message-ID: <MW4PR11MB5889C4E3889E6F6B8A07C3E68EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-11-anthony.l.nguyen@intel.com>
 <2cc1c107-b244-468a-9692-3fa5206728fe@intel.com>
In-Reply-To: <2cc1c107-b244-468a-9692-3fa5206728fe@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|PH8PR11MB7095:EE_
x-ms-office365-filtering-correlation-id: 26a803d4-eb25-4e4f-114e-08dd71e97431
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?U5ogE0wSsDwjG55aG95g2CWpQSSn7/2j1nW9Xha9P1fWCyoyaYLKvTGxLvgg?=
 =?us-ascii?Q?EtiGHx17E7HAZvXBHzonKGb3/iM72GEvGb6gACvFRwHwmd6jm+a2p/D2TPMJ?=
 =?us-ascii?Q?BQ3Yu/3rHeg75HHW6VpSdgXZ0Eal6EnUXN+S4ffj0Vy4K8mDpnHEe7tO4/qd?=
 =?us-ascii?Q?lYaaHrO5jy3dfs5a1vF7rtKTWEV8qe9v/R07MBQhVg3k2SJpzEwRjG0DXON+?=
 =?us-ascii?Q?sGwVAvDHO2bA3gh9dgvRwa7Pd3JGL1mdFscIP9J7BJ61rtaeLHlxhdW6eMzD?=
 =?us-ascii?Q?vNwc/3VIQFmZ4brmr7ezU4RaCZCWT1oYYEnFTtKpym4GliN6SkTvKyMvVtdw?=
 =?us-ascii?Q?RQtHANJlpVBZaXehGgy0yV2XjJMzGnD7GKUIzXePEEv0POXfewY7/Tq0fANo?=
 =?us-ascii?Q?V1t+2D1lRQjmow//qE7d4d+xsG4R9ggEJKCcUg2RJ6M0krTkiwb5fs7Rt+Go?=
 =?us-ascii?Q?ZNoznW9VM5uFz00QPJ2QyfFmOHBh5N+XNZ/XIBVvPsthUgdyvPYe0hGvMcnx?=
 =?us-ascii?Q?PPjPrsRatxABHs9rm3a7mIfq0Hu1SxEGXr+7ZeJlOU6/HFbyfHQK4m3HMj18?=
 =?us-ascii?Q?nFIZoKm1Mgc8JbRA8CgntZwIwBtrCJxFK0y4pLo1Bq5SO471m2TL5Xoi9nFi?=
 =?us-ascii?Q?Z9AbB7PcfMd9dRUQkH3IPR4qBsQBWym7nEQFNWT2OaTYNWxkKdUYgduD4o1r?=
 =?us-ascii?Q?FghkpvNP3UIHC7+2fENkhXKVrwPc1y655DqMWEXbH398L+/KuUECIf9fpBUX?=
 =?us-ascii?Q?coAT4KxW01oy8bz5JajfXA12QI0GIwi57a8dtEGFIZeplpf4HdtGguXSDimR?=
 =?us-ascii?Q?8h5g85437i5jVzFlowr416tedJ6an7s99p8ryjGcSZhniFp3w19VaHXGqXbL?=
 =?us-ascii?Q?ECPFvED+gQQ9J3q56CjhPAiA5E1hPRtq7gqzSTTt+Y/HUobwdXCpBuQN7P//?=
 =?us-ascii?Q?RY+u6k1e4UtvHKd++kCHm3lSk9yyRKGdBEU+xU0PJPnAPFtnIj4mRUN0BgXt?=
 =?us-ascii?Q?XNHcU21fl7RnNAowy86w6nhxtg9Q+uYIacucta/xwuMJwtZKzmKe7vE94a6Q?=
 =?us-ascii?Q?NH4nRTS1ORUyXMwQeuJA3El9ZYYKoDnvYm9i6matME7oJoNX6yhbUwejubfv?=
 =?us-ascii?Q?M0+CjlzpJKZiNWitYCQdx/mZ2mzkkGaTmOdq0QRRccGGupgsbSeRJ7EZkYdQ?=
 =?us-ascii?Q?TwyL11gWtDJ9Qv7QQlQf9CpgsFQldTVzZctM2ciSkeY0MZGmIXNC6Tb/lvnK?=
 =?us-ascii?Q?04ROfjJ8BZw8FkBeJa6WCElk+l7buD2DnQkQe3ub9/OewGxHjblh+ywDwHBR?=
 =?us-ascii?Q?kuR8B603o8uaXm7/JxqNqVjnTzBUn3IXzMyrB3V7W6Bci1cTZ900Koomf6Yj?=
 =?us-ascii?Q?S9Vw9K+th7dTyCupOWO9kcAriD//6FDv5UbkeqoptQKopq+MMEkUe+U11W5H?=
 =?us-ascii?Q?0Pjn/7j5j14045V/EVoGDp3I7zTchOMys5ebKEH5WvgJdWhmY0tJJA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G8ICN5Sf6apKRw1D0N2r3a4Ovp08Wq+xqM4VEhTKbL4j5GvzwH5U9rIUT05f?=
 =?us-ascii?Q?YwPwciv1Gis0eamlpI0NZgYj1OL25TEZ2/fCnpR8AiuigrmPfbR//QRKHa2w?=
 =?us-ascii?Q?oOTb739vfUWWT0TQBYd6ZdxgZyzaMgUFipXxSHYm2w3EOXvyKuJ40EK6FMII?=
 =?us-ascii?Q?7mKxioNf6ZXtq8Xh68xp9qAjuRo+SDXcSeokd/877zQ9zTZKKLpIkm53J/YJ?=
 =?us-ascii?Q?XHO+WV88azhKV0ujbU+1Fe24X8GQrkPnEFE1IrTLj8SRSRJXLJ/TaYVqG2oj?=
 =?us-ascii?Q?ICjKJL8aMj0UzxCLeFBFlKk8vBDjPhrztl0VK+k8uMxT5FIaUSp8y3gw79VP?=
 =?us-ascii?Q?shmFtlJZDi+wJsIBWRFGNIYdPide2aVafN4FhXTYkgpexJT1qtYPjZTbiC7V?=
 =?us-ascii?Q?OCqeB0RcpKC7RG8whHSpUiVeEsPrWHQWcCx5stBIF6xdHTyPkrHJZJq9Tv1Y?=
 =?us-ascii?Q?tP4nMNrWuFqLoQf9FtCU4mfbFouu4KroGCyoB0ZuTZs6SbYlAxHki3p7Zr5N?=
 =?us-ascii?Q?w8JkNuw6DJsBw1eVFcZ1A1MgIfj95sgEkbNA31kiOGjyV3+esbi41vTdV6Bm?=
 =?us-ascii?Q?aql38MJlXfIoLErIIGXO4u99PgBne36JPTDbaYfvxwmTBGKFCMRZm6YkR1qC?=
 =?us-ascii?Q?aC4oSJu4QE2b3peSqenetk6spC1wp1OvuVT97bllvaaC5lVaiHmK6fvBU9uI?=
 =?us-ascii?Q?jzl2///Usqgy6xMpUlAh/drlxMJMOAItYPxMMylwykXxyc3OxFd63goMxh0L?=
 =?us-ascii?Q?gFz4Obc5iS0tQF4TmNUpSV+Rb6cs1lScCf0tlo+Kz4rIWFq3f/gT9Ct7S4za?=
 =?us-ascii?Q?twYJMyqw2cVgZ9mlW7807OZ7hCut/7AdIib/ZTPHdSCZ4skvctuhGVNVkfEW?=
 =?us-ascii?Q?8RPqGafukq419aDnEnsiZVo6ite5q3r8LlbsyYMarOm5uBoy6IZqPrpa6SFS?=
 =?us-ascii?Q?awkgKZipklBuybyUSLs0WTcI0CxUZmePGtz5cvtrxRbwAWMQKrhjbeyGUuC2?=
 =?us-ascii?Q?eYrmXmWm7V0AyH1rX5LTFB47X9Zwek2HOq0gA272uFo4NLkSVt+Ji675JAkN?=
 =?us-ascii?Q?hHWZnZdRT1nY6JhkpCV9SnksV65NMFuoP3bRRxiynQJpyJdH/+AI0HCb+dJB?=
 =?us-ascii?Q?UwuRg9cLMH/Pbydejcu0QRwNzJHWMlXllbm60Obruonb8LIkkduRS0j+jRtQ?=
 =?us-ascii?Q?5kOPMoY6GzBh3BH8rwRbyNx1HeXniLjmzqSxMV9y0hiROsye2EW1uHa++3eb?=
 =?us-ascii?Q?OINF9RcEq1OPWGwO3w4HzWQPdLyCbYd1xjYjdevkZWtX8zHsENtubZsyX67U?=
 =?us-ascii?Q?ctO4tK4J24D1ryiRCn8N3jGtABFfcI3SYB30fAPEayjA4iTNEW+5KhR3ldz8?=
 =?us-ascii?Q?vkfZ76AUzmCM+7SU1f81IoY2PCxLgNWsbe7ZPZsWmaz8E1wcbFdpK6c9Wcj+?=
 =?us-ascii?Q?SJa0KYV8ySH44AzbLkgxxcDQCf5zeErS06yeSJmVO6/vMA1gVx//c8eEJ4aO?=
 =?us-ascii?Q?vkXTuxiJ5AoV8pcop4FIcwjqHDD5fPZzn+sr2+H7eVlqXFGnZPnfVoTo+9rd?=
 =?us-ascii?Q?ZutLfXHrsQ/DSjnJYEhP97ApmEENiZuoQXT7RTSK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a803d4-eb25-4e4f-114e-08dd71e97431
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 13:22:44.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7GH8gxNyQCub65hx9Y3boPfcjlkYWOkzfHuPk7sQq39LFUsL5qp7iqEEJHjMxIme0c6C/8qwXFlS0jnE4AHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com

On 03/25/2025 10:09 PM, Jacob Keller wrote:

>On 3/18/2025 9:13 AM, Tony Nguyen wrote:
>> From: Milena Olech <milena.olech@intel.com>
>>=20
>> Since workqueues are created per CPU, the works scheduled to this
>> workqueues are run on the CPU they were assigned. It may result in
>> overloaded CPU that is not able to handle virtchnl messages in
>> relatively short time. Allocating workqueue with WQ_UNBOUND and
>> WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less load=
ed
>> CPUs, what eliminates delays.
>>=20
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>> Tested-by: Samuel Salin <Samuel.salin@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/e=
thernet/intel/idpf/idpf_main.c
>> index 60bae3081035..022645f4fa9c 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
>> @@ -198,9 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>>  		goto err_serv_wq_alloc;
>>  	}
>> =20
>> -	adapter->mbx_wq =3D alloc_workqueue("%s-%s-mbx",
>> -					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
>> -					  dev_driver_string(dev),
>> +	adapter->mbx_wq =3D alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHP=
RI,
>> +					  0, dev_driver_string(dev),
>>  					  dev_name(dev));
>>  	if (!adapter->mbx_wq) {
>>  		dev_err(dev, "Failed to allocate mailbox workqueue\n");
>
>I would reorder this patch first in the series, since it is required
>(due to the way idpf communicates), but is not strictly related to PTP.
>

Sure, I can make it the first in the series.

Thanks,
Milena

>Thanks,
>Jake
>

