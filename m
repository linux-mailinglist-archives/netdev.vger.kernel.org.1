Return-Path: <netdev+bounces-134683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF199AD1A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB622843CF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634B1D0DFC;
	Fri, 11 Oct 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiuF/eL3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7A1CF295
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676267; cv=fail; b=u6125hdNPDcwVPtRkl0wAUqpdEW9ULe+QhLleMYa5FYMB5J8u/HU0eZGhO1ujPtIxerHn4Yg00KI8p0pZ1JbbF8l9EG+0F3N3m8tUIdPjZUZ5ufpAyytbXVNo+bJV4Pxjh5nS0E7654eQAm7qm2YQi5j+OEtFWvg+PUEggRo6N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676267; c=relaxed/simple;
	bh=/Dux8338UgoF4QfYcnLSEnHGYvf8L982o7oy4onyr9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LDNrcUNK44RvYX4u0u+nNwvjDb1rUDflNhOii9zu23zMkh8MrW9BtygfVTWbVbXjicgTVcJWN/dsg9MpgghiH95zAY983RF2qWta4d9cpUzdFN5zGznmLmCuZs95YZ6D0V5KbQ47vdn1S7/Xlfe5LUhTC2Rr+2hcnhvByDaxwq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiuF/eL3; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728676265; x=1760212265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Dux8338UgoF4QfYcnLSEnHGYvf8L982o7oy4onyr9A=;
  b=CiuF/eL3Lc0c9yCgD1wh0iJ2ABbhZKyBfoJW1Zdq234DhgTR7N6B7sDd
   rKU6fRmo7OuhnkRgXQqLEUusqplO3QOda2O2SEtZCTkZIF2MCIfvjhG2c
   qZ9BPWGCp1YJ0PfEVNmWCYp1shrQw3hFl98aVy6utGEy+e4qySkeJoibp
   Zcb7jGvLCMaRy+9uO1zreahI2dO80dl0aXyt/fAbcDU1A54+YI64oz1Ca
   GmMkvOPcx1k1f8hi0p7aHJq5nG04RVM7uVIXrNVn96Dvasz0PdSl0zcgQ
   nurPkftvu8l1VjFT0lga92tdYzKvJZ+npyKkDJ11f8gYuBNMiQxIozOSI
   Q==;
X-CSE-ConnectionGUID: 4fuVENo0SnGZrjc4bxOxYw==
X-CSE-MsgGUID: rEDDqMWASLWrHlyVf5d3Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45562981"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="45562981"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 12:51:05 -0700
X-CSE-ConnectionGUID: BVC8Xxh2T76kBplw7UZJjQ==
X-CSE-MsgGUID: rlUmbZKZTimdFv2ZhANbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76913921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 12:51:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 12:50:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 12:50:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 12:50:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 12:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXAoTxAkWtm/+1S1PgklYFCy/FvrfTaGIy58d1t/sLRSb4I2w9PR+vOG8ZtoEjRiXBJgpn/MLH0eOeYwIj6kXLEumlDOKa7XPC6P+ZM27MO82Bw02euy5RBSTg/2b0t7jPWxTO+OlCUvknzPY2mPGswx7S4VdamN6+4kFGK/5OXdQf4f6N2dBXrklY8aUXkxN5E7QYgD7lkqaP9wV4aVuO5xriieoOKooorMDLByBwBfYmevau3FW8gjIub/jH3vmbNE+zaiIvyk1+LwOhbyQQYwuBuWke/lG7SVH2Qw1VL6l6yHvc+lBJLSnaSlczCgBWqVKy/2b5NmNSEet9VG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc+wjjcm3HfKQr0PGQvi+0qo7scvsL7jFbrxhL/b3U8=;
 b=y7x/q8IKSBI0SpqS7sSYbAYhjtwbK7QowlDm/1fkx3M7REpkUJy/qFpQKXwWUw4DE73Iu31u4VEmmhYg6DttIFTd0d+d5DptBB2VGGJsLX+ZLjpsuN3TtU6yZ3BTJAmgK4Y9zxcogCectqPfIRr8HENPYZ6WVO2X5nRvGOraMehm57ZOxNRI+n4L2AIce0+V8z0gqaJMCyjJ86IR3OudRGkDwd9nUwE6P4OZvKUw53V44tYC9cNjD6p/UKB1XWfgF3KQiwE80quhG7K+JtUTmcerA1ALc9s7crRoJXq/ILZRxWDvqNM8n7jISQHx9ukgMz8j8DaldGZ73M+gIAcICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.21; Fri, 11 Oct 2024 19:50:56 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 19:50:56 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "saeedm@nvidia.com"
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>
Subject: RE: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Topic: [PATCH net-next 1/2] dpll: add clock quality level attribute and
 op
Thread-Index: AQHbGkZvGPkGlPu6Y0mXskgCaB/USrJ+WQiQgAAbU4CAAUdtYIAAIOqAgAAWBWCAABxWgIAACf6AgAEEuwCAAEkssIAAUQ2AgAA9QQA=
Date: Fri, 11 Oct 2024 19:50:56 +0000
Message-ID: <DM6PR11MB465748880C94832C56FF20009B792@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241009122547.296829-2-jiri@resnulli.us>
 <DM6PR11MB46571C9CAA9CBE56D6A5FCFD9B7F2@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwaN7XZpS6tEnTdB@nanopsycho.orion>
 <DM6PR11MB465772532AB0F85E9EB6E1719B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <Zwe8M7KZHOLGzUXa@nanopsycho.orion>
 <DM6PR11MB4657E57046E4263E2ADBAED29B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwfmcTxYyNzMYbV6@nanopsycho.orion>
 <DM6PR11MB4657140103B9C33B3899041E9B782@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwjJiqFbDWwUNh9_@nanopsycho.orion>
 <DM6PR11MB4657805DBAA2CCA70D233D2B9B792@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZwlK6Xm5mNzpvlsS@nanopsycho.orion>
In-Reply-To: <ZwlK6Xm5mNzpvlsS@nanopsycho.orion>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: 816251bd-34e2-416b-9810-08dcea2e05e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YFnLU7ESvLgkqJsr/0x5lJ257EEiREH/sOwNnMFY3Xw7IK1qGSaa/VJDJqLw?=
 =?us-ascii?Q?rz+orFuoCU7EH8cva8Goh5xL7/a4JuYA4/kyWl/Ja0Sn0Gf3KR26wCYss5QR?=
 =?us-ascii?Q?qOL/swQT44Q8npa+ETKEHqYDamtfZZVhc9LRX7AQ4XEhs4uGEQo6SAD0nNkL?=
 =?us-ascii?Q?/iRIqq82rUx/dp7e1Es0hSRNaCfnJsq+OMDfrwtPNzCeXns0o/ilJzGUjaRA?=
 =?us-ascii?Q?rXHyOcAIpK6tfSDZX02M/UBzP1gZN4+yDH1Hh3AoJd6fJTUNlIvI0JSpFzx+?=
 =?us-ascii?Q?JX4u8xoqjxkuKMSkHHMXjtibh18l74Mt6UfmP9kbP32+YNhvf6Z6lIhbumi2?=
 =?us-ascii?Q?FOJ7Fe8WTeLbEDtzGlNMChO32z3mP+3H5i+1kGb7taHk2DPae+Xj4CyTkMQ+?=
 =?us-ascii?Q?Ns9vRsFVxydN5AEzIV3O0oFY3BOHjE854YPm3kdcgSN9/rZ8z4lmBLxIdIIe?=
 =?us-ascii?Q?mR/7bZWDethKJ93NQQtuhaGuehAlBB9H5B+0SHjXLvPB3QkA7B2DJ5Dc2/qO?=
 =?us-ascii?Q?e7x/LxM866fxy+Hw9tWJvvuLvAGD/abzx3SMH5J5voo02Ohw2I2RsFYki5Jh?=
 =?us-ascii?Q?wxs0KP+/Y4XyL8Ux8Xfd02EOGrx865k54dKjw2MwbDd7PDAdo1SmsGlZyknn?=
 =?us-ascii?Q?5KZYKvewSy0kpRozggDmw/6qCXZsL6mBCLMooqEt2O7MMWASXQ9Fl5jOAd4O?=
 =?us-ascii?Q?PIyM6QgKrN9mV/5UOon2XrGvr2fCy2jFw2jWQKrY/7fzAIyCiIkOWlw0mKhJ?=
 =?us-ascii?Q?WM0OEEixE4n7f6CeOgxJWcE+Apd4QVEjzIOR5euWwD43/hoep/vaXY0TqgLB?=
 =?us-ascii?Q?vQ1pjMea1kqk0uLnWwKvd7MqBPztppxrPdzS9Mep1sn8VOdpdd4Mk3Cixr/Y?=
 =?us-ascii?Q?YdMVAr1c2xYQmFy8nOWL4O1Q1mRNnBe219ZggdtbwENsMhBAzKgZf26mjqGq?=
 =?us-ascii?Q?vU7fnAc4MUowA9kx/bT1jlu2VqRMO5EU/pouP52HXPsA2rJB57VO0iu4y62a?=
 =?us-ascii?Q?HMkyfesztIyPwyN16MAQlr6xK68XnIksQ6+XwD+9XLuQBJbqOwvq9JWE6iuE?=
 =?us-ascii?Q?t7mNhWrb/b/kAPKaJdA57vAsxxJRqm/miT1jMjS3M4tH1h8h3X6OP1hrDysT?=
 =?us-ascii?Q?OR4sCs3GOWtm3ubzq0X5RGIIabvfOzcHuWXtEItzbYOoxV8FtqDZld/M1EAf?=
 =?us-ascii?Q?VEqC/wNiaWOr37VykvbET2+yReWJ03EwP/wpmWPeikxTtIVJCRta4wJ4QgkD?=
 =?us-ascii?Q?8+nV0CWS/Rq9NoaTV7zurHTTvosCJfyHILiAg+hDGwwZHaaisLwsFFIV7jw1?=
 =?us-ascii?Q?GmhBF79hOHCSmoWBq6kj+i3p2L7QqN6AhptCc6J2N8ZRpQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mVny0cNBvd8k9lIXbQ2ohMclULD9eBmOkhIfA+1BwpLdM5TczfvfJJcJ5Qf9?=
 =?us-ascii?Q?nmd6P9heeCt45zgG2xM6xuxlzegegRRi9ckXxYdqKXZG1YfwkAhVimmEiKkF?=
 =?us-ascii?Q?EjlXgElNRXVuTcdOadQdos8U/QfehWJUqUcuME2uPlVR8dKP3B3sL7ERsyvc?=
 =?us-ascii?Q?EdqQcsSp6ZeBoU+/n8EkJsiXd7ZLPchVumSNtf0fAIowBxWQfEmdHedrfp0P?=
 =?us-ascii?Q?Gxn8lQpetnEydeI2FXHx+zEYL0CAU7lPDqe+Wih5goYSZ4+sYtVPl/fNFVhq?=
 =?us-ascii?Q?b94qlz5kVSmUMdapMXEUJPcyk3H2ty5y/SHI87AeTk2oz8A5YwhLcLAwfNe+?=
 =?us-ascii?Q?VX/JNeXTvf57pA0eOFmDBmYo6xvJjr768/GcZDw6gwLtw1JK5A4TJ+UbDv8p?=
 =?us-ascii?Q?e7L/5Vy4c7dOkbOxf0lFGJcPxXQfgIba8UbU9g3S6L5ulD1vSlG+E6rkCSsf?=
 =?us-ascii?Q?M9d9dVah39crd9ZOs/gYBGu4bZoI0N4y3V7Kxw3rILpI2ocEj7uZEwkIKLyI?=
 =?us-ascii?Q?QVp0o8iK5g/ybbbqS7KsrSo6oH1QM7IWtJwWN5LA2h7FD4xg8+0HAnIkjXa6?=
 =?us-ascii?Q?i/Wf/zVX8q/abaKBV5OtxhApPSvR3llKFzvqqNFv1gs6Nrtt/YPnlaCnHi/w?=
 =?us-ascii?Q?Mj9STB+jUYDxEjXV5KzuqW4LhI2E2xaJOyo1e/6IZhc1WZWENAzXOlW0hPq1?=
 =?us-ascii?Q?81hbdxpX/GOZJ/vSinPadgt9sk+SbK0idJss//qBmJqHILH2AxFLYi53Dp8S?=
 =?us-ascii?Q?QwWbzH5d0dqTsmkbKnttbQjmMh914i2jVPMCGSKhIy12Gb6AAN4/xpJLNKEO?=
 =?us-ascii?Q?9e6MLx6PtyXuwa6aGZ4/hogs+HO57TaCXFbX/HP3O2OYbduQK5aQUcPr4T3S?=
 =?us-ascii?Q?1pjyEU6ok2It6+klxKZQVdKvZZtsopMs4NQMFVY71SYgMlo9cV404WLZxwtx?=
 =?us-ascii?Q?t5uaGXbaoJAwslwjy0rNULWI5s+BVA2oFek3f+4VWHiDNrp3SiHiH6XG+SBB?=
 =?us-ascii?Q?1v6CPGHFABSjyc0RZWErtwRZb8NmRXKKh/ShJLBWrphhGIKgCbgmfrEtp4wu?=
 =?us-ascii?Q?YdTrNdFyw8yAQmmL8lCjmL/LhpxcP8B4/dBMCTBKvdH93GxA6fjWwbJPteZk?=
 =?us-ascii?Q?VgcYUJpGqiyJ0nzCI/OrDbh4UEWXHiyQ5LEQ5TdUGK/P/93dws45iS18YCn/?=
 =?us-ascii?Q?pAemEtCWQb2D9wiZL4he3yUYZgjxyk7WVhEQwMNYHno6q3jynIvNBhK3mr1R?=
 =?us-ascii?Q?7llccBQgtVa3epzhUw+LirXiCbAWRoTeTdTiASGpjGAELPcjVdqrB2gF8JI1?=
 =?us-ascii?Q?q6/Gkz+y8jNt0Dd8EgEQ0fwse3k2rvqqLRp5f67ATmBosuARmLvH7zwgUeJJ?=
 =?us-ascii?Q?Bs8P/1pUpccF8oLIKokBZrLIwOFWu55H5ykTtu+W7ISsgJHTSstjrxyr09LM?=
 =?us-ascii?Q?mEbKTbGEaLDoq6tLFbm8gMaEsSdEJ+ClHbm8M2jJo6PM4sb1b+IiQ4nfoBwd?=
 =?us-ascii?Q?pZ/tL5Bv6y1OYpadBn7yb2yIQ27QHdZFOPiyds2FiLsGMI12Tnw1Lj4HzlQf?=
 =?us-ascii?Q?kn99PUbpVilkHfU+oDDYfTDCfDic8HVHyWLBSxVN8Dwar8TZb6baO0iRevmM?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816251bd-34e2-416b-9810-08dcea2e05e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 19:50:56.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+kCYG4/HOgtCbtgCROEoKSZcATia+6zqg9DABbRCb9jDjcQebOp9pPgmGs4M/bpNYIVICgBYRY7Kd2AfLI7yl6o8a8eHoH02f4FQm9vO2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, October 11, 2024 5:57 PM
>
>Fri, Oct 11, 2024 at 04:25:09PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, October 11, 2024 8:46 AM
>>>
>>>Thu, Oct 10, 2024 at 06:02:56PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, October 10, 2024 4:37 PM
>>>>>
>>>>>Thu, Oct 10, 2024 at 03:48:02PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Thursday, October 10, 2024 1:36 PM
>>>>>>>
>>>>>>>Thu, Oct 10, 2024 at 11:53:30AM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Wednesday, October 9, 2024 4:07 PM
>>>>>>>>>
>>>>>>>>>Wed, Oct 09, 2024 at 03:38:38PM CEST, arkadiusz.kubalewski@intel.c=
om
>>>>>>>>>wrote:
>>>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>>>Sent: Wednesday, October 9, 2024 2:26 PM
>>>>>>>>>>>
>>>>>>>>>>>In order to allow driver expose quality level of the clock it is
>>>>>>>>>>>running, introduce a new netlink attr with enum to carry it to t=
he
>>>>>>>>>>>userspace. Also, introduce an op the dpll netlink code calls int=
o
>>>>>>>>>>>the
>>>>>>>>>>>driver to obtain the value.
>>>>>>>>>>>
>>>>>>>>>>>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>>>>>---
>>>>>>>>>>> Documentation/netlink/specs/dpll.yaml | 28
>>>>>>>>>>>+++++++++++++++++++++++++++
>>>>>>>>>>> drivers/dpll/dpll_netlink.c           | 22 ++++++++++++++++++++=
+
>>>>>>>>>>> include/linux/dpll.h                  |  4 ++++
>>>>>>>>>>> include/uapi/linux/dpll.h             | 21 ++++++++++++++++++++
>>>>>>>>>>> 4 files changed, 75 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>>b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>>index f2894ca35de8..77a8e9ddb254 100644
>>>>>>>>>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>>>>>>>>>@@ -85,6 +85,30 @@ definitions:
>>>>>>>>>>>           This may happen for example if dpll device was previo=
usly
>>>>>>>>>>>           locked on an input pin of type PIN_TYPE_SYNCE_ETH_POR=
T.
>>>>>>>>>>>     render-max: true
>>>>>>>>>>>+  -
>>>>>>>>>>>+    type: enum
>>>>>>>>>>>+    name: clock-quality-level
>>>>>>>>>>>+    doc: |
>>>>>>>>>>>+      level of quality of a clock device.
>>>>>>>>>>
>>>>>>>>>>Hi Jiri,
>>>>>>>>>>
>>>>>>>>>>Thanks for your work on this!
>>>>>>>>>>
>>>>>>>>>>I do like the idea, but this part is a bit tricky.
>>>>>>>>>>
>>>>>>>>>>I assume it is all about clock/quality levels as mentioned in ITU=
-T
>>>>>>>>>>spec "Table 11-7" of REC-G.8264?
>>>>>>>>>
>>>>>>>>>For now, yes. That is the usecase I have currently. But, if anyone
>>>>>>>>>will
>>>>>>>>>have
>>>>>>>>>a
>>>>>>>>>need to introduce any sort of different quality, I don't see why n=
ot.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Then what about table 11-8?
>>>>>>>>>
>>>>>>>>>The names do not overlap. So if anyone need to add those, he is fr=
ee
>>>>>>>>>to
>>>>>>>>>do
>>>>>>>>>it.
>>>>>>>>>
>>>>>>>>
>>>>>>>>Not true, some names do overlap: ePRC/eEEC/ePRTC/PRTC.
>>>>>>>>As you already pointed below :)
>>>>>>>
>>>>>>>Yep, sure.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>And in general about option 2(3?) networks?
>>>>>>>>>>
>>>>>>>>>>AFAIR there are 3 (I don't think 3rd is relevant? But still defin=
ed
>>>>>>>>>>In
>>>>>>>>>>REC-G.781, also REC-G.781 doesn't provide clock types at all, jus=
t
>>>>>>>>>>Quality Levels).
>>>>>>>>>>
>>>>>>>>>>Assuming 2(3?) network options shall be available, either user ca=
n
>>>>>>>>>>select the one which is shown, or driver just provides all (if ca=
n,
>>>>>>>>>>one/none otherwise)?
>>>>>>>>>>
>>>>>>>>>>If we don't want to give the user control and just let the driver=
 to
>>>>>>>>>>either provide this or not, my suggestion would be to name the
>>>>>>>>>>attribute appropriately: "clock-quality-level-o1" to make clear
>>>>>>>>>>provided attribute belongs to option 1 network.
>>>>>>>>>
>>>>>>>>>I was thinking about that but there are 2 groups of names in both
>>>>>>>>>tables:
>>>>>>>>>1) different quality levels and names. Then "o1/2" in the name is =
not
>>>>>>>>>   really needed, as the name itself is the differentiator.
>>>>>>>>>2) same quality leves in both options. Those are:
>>>>>>>>>   PRTC
>>>>>>>>>   ePRTC
>>>>>>>>>   eEEC
>>>>>>>>>   ePRC
>>>>>>>>>   And for thesee, using "o1/2" prefix would lead to have 2 enum
>>>>>>>>>values
>>>>>>>>>   for exactly the same quality level.
>>>>>>>>>
>>>>>>>>
>>>>>>>>Those names overlap but corresponding SSM is different depending on
>>>>>>>>the network option, providing one of those without network option w=
ill
>>>>>>>>confuse users.
>>>>>>>
>>>>>>>The ssm code is different, but that is irrelevant in context of this
>>>>>>>UAPI. Clock quality levels are the same, that's what matters, isn't =
it?
>>>>>>>
>>>>>>
>>>>>>This is relevant to user if the clock provides both.
>>>>>>I.e., given clock meets requirements for both Option1:PRC and
>>>>>>Option2:PRS.
>>>>>>How would you provide both of those to the user?
>>>>>
>>>>>Currently, the attr is single value. So you imply that there is usecas=
e
>>>>>to report multiple clock quality at a single time?
>>>>>
>>>>
>>>>Yes, correct. The userspace would decide which one to use.
>>>
>>>Wait what? What do you mean by "which one to "use""?
>>>
>>
>>Generally if you provide some information to user, he shall use it
>>somehow, right?
>>
>>Maybe you could explain the use case as you are the one developing it?
>>Is this to tell user a quality level of your device itself - without
>>anything connected?
>>Does it change during runtime? (i.e. locking to a neighbor?)
>
>Nope. It is the quality of clock the device is running. Locking does not
>change that. We propagate this info over SyncE ESMC message.
>

Ok, but we shall also add such explanation somewhere in docs. To make sure
everyone knows that it is provided as kind of "default" clock quality.
Whenever dpll is in unlocked state, just to make sure there is no confusion
on userspace.

>
>>
>>I already explained my concerns: if device would be providing multiple
>>clock qualities for different specification options (i.e. ITU-T Option
>>1/2(/3)) and they would differ for single device with regards to the
>>meeting certain class spec requirements, the list of those would be
>>required. Since the names for both do overlap it would be not possible
>>to let the user know accurately without changes to the uapi.
>>
>>>
>>>>
>>>>>Even with that. "PRC" and "PRS" names are enough to differenciate.
>>>>>option prefix is redundant.
>>>>>
>>>>
>>>>I do not ask for option prefix in the enum names, but specify somehow
>>>>the option you do provide, and ability easily expand the uapi to provid=
e
>>>>both at the same time.. Backend can wait for someone to actually
>>>>implement the option2, but we don't want to change uapi later, right?
>>>
>>>So far, I fail to see what is the need for exposing the "option" info. I
>>>may be missing something.
>>>
>>
>>See above and below :)
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>The patch implements only option1 but the attribute shall
>>>>>>be named adequately. So the user doesn't have to look for it
>>>>>>or guessing around.
>>>>>>After all it is not just DPLL_A_CLOCK_QUALITY_LEVEL.
>>>>>>It is either DPLL_A_CLOCK_QUALITY_LEVEL_OPTION1=3DX or a tuple:
>>>>>>DPLL_A_CLOCK_QUALITY_LEVEL=3DX + DPLL_A_CLOCK_QUALITY_OPTION=3D1.
>>>>>
>>>>>Why exactly do you need to expose "option"? What's the usecase?
>>>>>
>>>>
>>>>The use case is to simply provide accurate information.
>>>>With proposed changes the user will not know if provided class of
>>>>ePRC is option 1 or 2.
>>>
>>>How exactly does those 2 differ in terms of clock quality? If they
>>>don't, why to differenciate them?
>>
>>All I could find is that the same name of clock class the quality
>>shall not differ. But again I am not saying we shall differentiate
>>the clock class.. Rather an ability to provide each one, keeping in
>>mind that device can meet different O1 vs O2 (vs 03.
>>
>>How would we extend the interface to provide Option 2 clock class?
>>I still see some entropy, I mean higher then expected..
>>Let's say device meets PRC for Option1 and PRS for Option2, how would
>>we provide this?
>>The same attribute twice? This seems also possibly confusing for
>>certain cases.
>
>DPLL_A_CLOCK_QUALITY_LEVEL with value DPLL_CLOCK_QUALITY_LEVEL_ITU_PRC
>DPLL_A_CLOCK_QUALITY_LEVEL with value DPLL_CLOCK_QUALITY_LEVEL_ITU_PRS
>
>same attribute 2 times with different value.
>
>
>But, in the meantime, I learned that for example ePRTC certification
>may differ for option 1 and option 2. So we need to provide it. I will
>just put it into the enum name. Looks as the best solution, UAPI and
>internal op api-wise.
>

Fine, but then we also shall have 'multi-attr: true' for this attribute
within this patch?

Thank you!
Arkadiusz

[..]

