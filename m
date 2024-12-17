Return-Path: <netdev+bounces-152617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100C9F4E1F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE40518862D1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026A1F6679;
	Tue, 17 Dec 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFkl6Ew8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B31F6666
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446727; cv=fail; b=CD1vpbjDXKI92sI98KDX8Jbtfgm6pRx+SWAJVHXPknSMZfiInVexHAEOfpo17ZcChqRQk+ocoanBGl1X26xUzrZ7Z86mMfM/IAFZsnn4/27qsOKJFIkq3nuL8tW0p/9OmOkN9T7OsloJXV8LQaFme7B8FQYd0JOsrAWUpFWvKiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446727; c=relaxed/simple;
	bh=hjABhN/sF/8buq374j0h6cETkwYtZuSMICS97ARvmJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMj0axmeLCiTRK/hJjtswg0rzQa6vHhgtNtu680cPLxXt59tRrkGBrgamLvK5jq5d9jDvCOejtvHx3R8F9Oznb10KTlNYDYO47Fs3DZ2dswA/byFer5Y9Wp8c4e33RHE1vxhBh5MpOQpRYKRBZgUWVdpi+nUsMRho0CM3yUD0Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFkl6Ew8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734446726; x=1765982726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hjABhN/sF/8buq374j0h6cETkwYtZuSMICS97ARvmJk=;
  b=KFkl6Ew8CYAfWLXYF6wislnfkrPWYL/wZG2X+9Q3BYr5NLv12+DrGqWH
   aqTmN+W30WbRB4aZcm6Y4n+pkVldYTI+jTjjjRwWOtE9/0MgUNgdYvvLG
   IN/DQItOXGlznfzsoUZD/sz2Ni3Q9uqnGxZ6py3MvZmwxD1x9uPPXH1iR
   67nbM/ENl4LszANHKq/0KS/Rbe/2OqbyNseWDSzQmOqIbdmB1op4AY4qv
   57XKlt6vw1x0Q/sckBYLS2Xqx5WrzMK3LggOtcGXcSoXZUfE5sF+XD/Wd
   6c8BcWNGWBWJS4cGJHDOYEfWEyc2Zz4h2qrfRUSvlBECARuqW0Yq8zHOC
   A==;
X-CSE-ConnectionGUID: pccFuwAKSVCxCntFO0H+3Q==
X-CSE-MsgGUID: H/aDYfNgQAO+PpPwZVjwww==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57354983"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="57354983"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 06:45:25 -0800
X-CSE-ConnectionGUID: GVxAWpILSYe7oD+CaPplDw==
X-CSE-MsgGUID: hCBI6HxBTtWF7yD0VX9+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102642430"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 06:45:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 06:45:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 06:45:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 06:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgjrnlEHuMAAL8biq6uGs5BRXodD9YnjsZz4XkEQNV1dLoFgTprwmePWpNWEWV1Mc6h4764eERZp08zw+nIotu2owzCc8Xsr036ySl7KcaK8aiOD+CwlcJ3W6n3wGTQ+I24me5yu2jLPo4tOlurAo22qBAjsNCQhhVYKqnbkV9y2xpVLx2zyOZm700mJmwq8F/nPXL8zveVI4qTjN/V4POcqw3+UaTd7gcGR626iLXFgmcDe+LEQKmylpRZNJaIIKwopMvWJzqWTuVUJ16ZZVnUQwmK9RbYt1A5AhzTCWwg8bo8ofzd+D6GkztzeBVTe/5n/DpKiX44/iWh8SiB1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slkl6Y6ExgQUe0tCVkQZ1RM4qHLKxe7nJH2i6Luv0yE=;
 b=n/r7VfqR57r6XR1l9tBC8WVDSyJM5drWTIzLYMsjlXggf+XV1390Kz9AxCmQramjYm9nGDqqgOzTOQZGaYTAsnxoOMt5slSBlKH6de5IvzrdCrQUs6F8GikAoD+A15R4QUG/GY34WauE20CZZv1LvzrxzJPukNJGaaHaRmsdPy2vvjD1ri4PwARtGC83JTctqAsSQG7wV4suQe0rb2jZwmbMKwKqJvHnhUOaXpHuet6yyX0O6KmJ/5OtmHeghGZt+sk4CYZD4NlxdOZXGt/pr3PrRSNLJx2VHP0Tn3Vo319rqige42QDs+hTFsSvQavWPtdynoqaF3Iv1V2MwwL0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Tue, 17 Dec
 2024 14:45:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:45:22 +0000
From: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [PATCH iwl-net v2] ice: fix ice_parser_rt::bst_key array size
Thread-Topic: [PATCH iwl-net v2] ice: fix ice_parser_rt::bst_key array size
Thread-Index: AQHbUI/EFHjc7NjtqEuUO/HqmcsforLqgfMw
Date: Tue, 17 Dec 2024 14:45:21 +0000
Message-ID: <MN6PR11MB81029F41249D762EBA2E8CAF97042@MN6PR11MB8102.namprd11.prod.outlook.com>
References: <20241217142300.7119-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20241217142300.7119-1-przemyslaw.kitszel@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR11MB8102:EE_|DS0PR11MB7311:EE_
x-ms-office365-filtering-correlation-id: 5ac2b3c2-411a-4af9-0605-08dd1ea96f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u2IfKD9SwVACHHx14aSjpq7DCudD6EqJfhKepcrCEppjyfQYPwgBSAngyDfr?=
 =?us-ascii?Q?zstFfuJjv+fMr3HaO5lY/dTt69YVywnByHnRwuq6C98UT6XUKPHEaGjKVtfP?=
 =?us-ascii?Q?LJIHjdQzT9p7ypBPDZStSWX99ikigutocjAJZC11/1+zcD02/2BxS+qyoixW?=
 =?us-ascii?Q?1rHgZsK4tdzA8t732xw9mHWW3N/lpLZ6654Ud3n19yiGxCs9wmuxz4+IGhG6?=
 =?us-ascii?Q?gOD+b4mpr9fo6+FddwZI/xjCFJcctAwzMWx8fPD4PZC+pak+7yZcEywZBx0A?=
 =?us-ascii?Q?bIuy99fCrdXj5oztmPG2v6mQoba38A9bUG21VwweLsy0/0YN5eFMhz2p/0lQ?=
 =?us-ascii?Q?O74XHaicyTu3KLpxNtlCNcJDaJuR8I2yERLyiTCDdyZoV/gNM6tdHPZMSk0q?=
 =?us-ascii?Q?wZZOqu6uFnHobH3WIAx2z4z7wp1n+I30bx7e3NyR+LwaDUx3q2nX6pWy2BXA?=
 =?us-ascii?Q?Tewo64b6Z/idnMQi35MGTSZZ3SUK0xdbUTZRBSPfzZdMNLvl7tOmdMmzO1z8?=
 =?us-ascii?Q?aJYgAPpTU5zpLhmiDohnTnNRsZfhQXwLt3FBgmZP0gJ1NC+PuAtxAW5ks0pE?=
 =?us-ascii?Q?X+pshAd1rhz4oUAOv7wzIsrCqJHBtTuCFeL1zCYAm9VYo/uul9ZT1cHCqqlu?=
 =?us-ascii?Q?U2axPRQqvxxX/LY4sXZ+bRnHS3bGVJU5fGCzVZrlj3JxoOzNLsr2YX5QCmKI?=
 =?us-ascii?Q?9UMYkuHPzT3TLmbqiTp3/PUqLLKyDFhbJAwngrR9Tmu+ZUmw23Fc1noSw/aZ?=
 =?us-ascii?Q?/jBD4OSjdtrTNR+OUTZrPI0grVQsI8C+ewrzNu+jcnLWSAAzkPNq0rTlsTRR?=
 =?us-ascii?Q?qiDKOnLD4Dswe63u6op4bNDsJdyTdZ6NXnvSauoiGfVCr0/RqTPUvozSPOLO?=
 =?us-ascii?Q?y+RjOu9zCJP+ui7kN8p1bISD0x36kNoW/HeUmNitACAt/JB5G9pedwLymQdF?=
 =?us-ascii?Q?qq6+A2KChF3vYqHhrs+btG9HhEDntWNYT2KBeFbztTniVnYnnyyvfDMoffd0?=
 =?us-ascii?Q?+DbwHmrOpsG6G8ffl9OFFsIYe7Qx1PdJokZkp0t5rxESEMhGoPd78Tx+PXUN?=
 =?us-ascii?Q?ry5dSNfMv+LAaaJ1ObNUtS3yGjQzaNCwmkKZQ0rWfzryFGB3VtW754v4tb5t?=
 =?us-ascii?Q?/7117u3USkgP+Fi/qNCs0jgCvGaOTTtZaRy1dboLms8GVayzfBceuWNtrgGw?=
 =?us-ascii?Q?27Nn/ZHk0uUhOLTbzv3ihrksNEh7daU7PXxHuQams6tn/E38YvlcH3Jm5RVD?=
 =?us-ascii?Q?Sn7QMh+VFQqDLCH0wu5EG0n9mxAC/hr23FKfY9A5HHsoSpctt4r5CPGQredA?=
 =?us-ascii?Q?s7QjXSwFwuBu9uZWpnaq7WN9qnkG7MGihI2r7FHHgXUd/fI9WEkfpond8U/y?=
 =?us-ascii?Q?6bI3mrB+Kr1rqRy0vBXAW4Lh5dffbO2rsZM166lcmYwHpZqiOFGpqL2pE503?=
 =?us-ascii?Q?VdAgx9dykTlLfOi+gwcM9MT2ArHZyQla?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6jdSdlliMoBVPevYSDtOOjPpq2l167FKBQYY7GYWgah60eUQOVrdG+Zb0FC?=
 =?us-ascii?Q?ZJ5WeY8OWxnxm9lBkByujoj3zgbndFzLRhiGdZGMA2c+VrLja9E01IFTTeUK?=
 =?us-ascii?Q?OHo1nEWMV+8bRH+lTge8+pot5avnmKvw9JOHQcpBolU1wjMd3Ra1Qu2bXgzL?=
 =?us-ascii?Q?N9AglXEOx6XddeN8/1JL6ZCsME0I2qftcEfDvDomczywQJi3OlVa243KQOLE?=
 =?us-ascii?Q?bBBlnHQEETx0RUw25OMbrC2gRIxub2p/5wwbtAABvwdNQiklr2hgSNRlwDFt?=
 =?us-ascii?Q?sFp27+R/MVxiF5mVXx+HuSacbSK8U61GJ9R1yd2FpNBix8gQQtMHAwW+g9p3?=
 =?us-ascii?Q?MdjmJcLdJDK+HfPPnUg8jynGL8b2K5HM0elmutFH+iQ5UwsfqTioDremb+hC?=
 =?us-ascii?Q?8aKO1QEh6ddzxspK+GAA9gg+HtqoH/bgAJ8aTuaFrHC8S90g7YorUtTVABmZ?=
 =?us-ascii?Q?OX06SMwPKpdVx7orxzti8K7lxQGgUqq/jo53KXM5HB+O02fy1HJqeAgIc+bX?=
 =?us-ascii?Q?IwSj0T7/GDqhhTUKsp5lo/6cWscf4YQ+74Tej/l3xrlgCEgcrBztqAkvYw1n?=
 =?us-ascii?Q?L+HP0/lr0QMPz04ME20n58EqYdqByxlFM3lgXqC0uMMGcGzI1g0GXsEr0Dvy?=
 =?us-ascii?Q?63qle95Mq9LHtBFywRFmYkDQxNXkgWrFoNQMxC4J9sU2yU4P4JLpZE1ik2/2?=
 =?us-ascii?Q?WjmkLYSz+X8HdpS3RS2l/cSBn6+1Tmlnk0ulSLF1uR157KJosc5pkHk24aNa?=
 =?us-ascii?Q?86h23oqW/jdH03O/YCvLnbrLdo1DfdosxByPes+1uS/Heoy3LNCq/GcIzvW0?=
 =?us-ascii?Q?RD8L5PfVqxVvnDu/Q45557MFWsyKYE0IeW+/mssWtOIILWFKBpHEImeCQEhc?=
 =?us-ascii?Q?fzQTul74GCROiwMhVpZouZconQySCei8XDY+7krTJQZT9rcA79osmj6h3YaZ?=
 =?us-ascii?Q?mq+jSuz9pTqM8cTP9Z3n83gkifxg+t9l8OxMopuaPEPbDaktlJqW/DKJTpZ1?=
 =?us-ascii?Q?QREm0B9/dO31wMVfN8s3fLNMMeoLeo9KmxxUWuugNCJpXQXscTjF2k1cnqrL?=
 =?us-ascii?Q?8QjbAhaw7I5IZ3Af2XQihEc7nMp0DZ5GZxd6P5x9hrSyknLsq8wAza0T5zAH?=
 =?us-ascii?Q?fLgHZPGyD4XdWFNT5vAbQ8ypCD7/Px7RbG8f5y628k660cUqusi9uSWCbXzP?=
 =?us-ascii?Q?HBYjmQjkejsq8sYF1cYFGInrlAwoM9Abs8cj3cihwjbx5sCOc6+GkU33DqOS?=
 =?us-ascii?Q?SyWC80bn4bnv8/0SrP+FbItcTq9bZDsCuAemP0e/ACIcJufBSzB9JZCLMnxK?=
 =?us-ascii?Q?STHo6sUckm4WPcn4fxvUP/t5d9D3zAbAgM96GJng9094zixYIo8AwVrVyDpn?=
 =?us-ascii?Q?3nnKFFeoT89hV/Y6jGQRVgwlfKTh8mU1UHwsrjok9dnenqLxqJ8W6tAdkG3M?=
 =?us-ascii?Q?4ikmuLQtUafv/QCo3REW28gxIZyF/xxOlJ1zxvMhNYI2HP/SKbbrp9meImuQ?=
 =?us-ascii?Q?TzzqSJnSxo3JWnk75vXBC0AjePzELvx3n7K3Mud+8kJr241nhKUUsWdQXLFc?=
 =?us-ascii?Q?MwmlZH4TR4lmu3qHs6OBof/5bVE1hlVHZRG/zABi0H7iBmZjdJsvTvjLc5Iy?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac2b3c2-411a-4af9-0605-08dd1ea96f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 14:45:21.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJ3NMQA8EOljJEB8SFYdSHleqpBNUynIrmA7IWeQXIbknxx1eQM1Fku+YnLPKjqBGFdUCbd7Qac7zRhyHopXnqmQ3SEfuZ2yZja7e4PiIOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com

> ---
> v2: mention printing change in commit msg, add missing space after prefix=
 (Simon)
>=20

Meh, I forgot to squash the change :/, sorry

> +	ice_debug_array_w_prefix(rt->psr->hw, ICE_DBG_PARSER,
> +				 KBUILD_MODNAME "Generated Boost TCAM Key",


