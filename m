Return-Path: <netdev+bounces-158268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01111A1146C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A457A1B2F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F11D47BD;
	Tue, 14 Jan 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4TNfYTe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA620E01D;
	Tue, 14 Jan 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895165; cv=fail; b=GxiT8Zk88CFp0EbJX2TiE64TOYQq0pgMM1ahbxbWlsYZhr1L5uaQwfTV0zg3k2kjGmBToM9bD1zl6gb5OcgEi5SnGtsdHAXl3ldCLqbc6ouK+2dsHxz6OX6CdCVh5lVvdIq0IUJ8v9wsEdGkSZhdeBCkLunLkN1oheUbaGc71Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895165; c=relaxed/simple;
	bh=zSOL1351nALHBMpryhxU+YfRTgUitkNwobpDxB0pnos=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OzfXk4I7h3lDPhQl/OKOMKT88yJ/wJz48BqcUlwHRNz/n1FbTxG2Rkz7tRxywnYpsGSy7fM49LuqcJRE6GIZPNvVEtkrOQJSFQWx65oEd5J2veFAdD74vLup+F6QYqkzSWFBHh53LKyFYryVN21dVbGoEqjYdlY3K7yTuJ8OJ+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4TNfYTe; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736895164; x=1768431164;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zSOL1351nALHBMpryhxU+YfRTgUitkNwobpDxB0pnos=;
  b=d4TNfYTey9vXpS7wwkSr2/AzAw7KqzlT47fv7gwPPnTRvZ+3K4Q3IUoq
   N67+bNzUm/X/RF2QapkBwr8sfubW+ALZ7gKv7IyTY1hg8BOy/hdHaOCsq
   TxpvnkRV7paXLWnS4I0+OEFY3aYFc8KW4WJ3pR8Th2cQ+xsvoiDq1HT8x
   WVn2N/7WopFm+J6Ig9vn/zx+H5FT9vT+I7+U7ncxX9GXgSQ50hF7MdzOb
   ska7UPVX4oZyJ2sPa1SkkccZ9oQHIL3p2UBMs4rLlerHYQ1McxcheNS5S
   hUDfVCbaRcbOPmRULs+X8p1Mt/BrQHw7KfaEeGyY0e64VHIXw+0IDYrpk
   Q==;
X-CSE-ConnectionGUID: OCTZld1lSdaV9b0RMNOBeA==
X-CSE-MsgGUID: 6PMxvzrYRRektwFmprE9bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48598563"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="48598563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:52:43 -0800
X-CSE-ConnectionGUID: B8qp9yxdRUeSQPdWPtOKmA==
X-CSE-MsgGUID: U48R+pH2QLGuFiyOeeX7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="104787017"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:52:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:52:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:52:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQoJoA8zJ5rYIvgJbokcvsFLKUISrbNNI2XqC1/g0o0r51FPvodn2aDbantpEAOovj3QulbcH4nrePG8eJXXj50IAS3vlASBpkytAk1WZQVm5+82b4kCAo2p0f58cvsTpgaCxKp0xpM8RyXaVR0TNOpzOF8rjMfp2AdN/bL+pgp0drdFgYxaB0LT7jW9N+/3bzmkGhWesCj0KqG20HdgGNdlmPygxbEykmtvkXqaaBlCyBV+GrbnTp8G9hw6McjE60SQkrjlVWcGoucE7Eg7rcU/eQh124MtC9T6e1Z7b50jM1ha20KXT/+D3vHHgon1oHGyXL2bqOFJFI2oTcxFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krZMmgi0PvSuJhipMjrYIuwBQBQ2G1Pa5pHw7hmVB2g=;
 b=eVHF1cUJ3hvUDY3Qb5GAxMOyCrpsfYQ/Us2idjavllDwTgv62qqMII6TV2NUjogBSgaHxtvRNfbvCXN2+AMOy71hebvD7VVIz1kmbYbP3wofu90StYjQ5+cQUyw7hCTdJ4SRD8pVvZdjtvIEWE8HcvTSj46ZE1ua6mLBO3XgWwRLaxHziPTHprp5hR3AX61N1nQ02Bm0jidskPqbSPK0leC1KSB4m+77OLnQPMsJ66YCiHpnDSYIE3Rw+rnTtIX7Jii8IRXfIMZhAP0/GFaRV1F5bo6CZgGuAKI8rJT6Ozf882kS+4Kwx6C0ynCpO2Ga2UTGpZOQFYuIaenRB6yt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:52:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 22:52:38 +0000
Date: Tue, 14 Jan 2025 14:52:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4cdf34-48b6-4910-0bfc-08dd34ee24bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtLvNzGM2eSC1mgFhDpXZm6fs+w2EBiOUav4qZ0MBCuFKBbc12twLISGgOjC?=
 =?us-ascii?Q?zVmOUxm/0jmwE36RvxcuoM8tbW8VwsQBrJOZiLSCMEIZp6IUOZ8Dv0OB+YX/?=
 =?us-ascii?Q?jcDmLP9poS9QmNYoIDjBhK6AJ0rUhzH49xFPGfv0YLwVy5dmJFVZZXPcdtBD?=
 =?us-ascii?Q?cmToELt7UBqiRYzVzOZ+v/NlNCg7/wvqxY3Tzc6zz3GG0NsGWLMYR8XPo8LE?=
 =?us-ascii?Q?DZnwyZwkSO4ELGjfUtBCX8YoacRbseZ6afCsyKyNJ6U37NzzNcewwEd1bMrE?=
 =?us-ascii?Q?JacU5rKwazWMF4ClARhXCZBnq3c/G8KqLjvRhAeJyIh1oxEWGZphGG3H2zJh?=
 =?us-ascii?Q?QXqmEaSh138TZV3ey5KC/WfQ8p5An6Iito+XRR/Yokk+Pu6Iu7lRsWVZeh/+?=
 =?us-ascii?Q?zjqoZMhtkNXzimUfMiCgx1Sr/JYhROK/cQUI3S12NC1tTkSXqK2pLdJR2M6m?=
 =?us-ascii?Q?NwAcCm9etdInqRtNiZfN6QC9J1bkZEwE3boM/ftAHx5ylhBZ7jYhPztHKjDd?=
 =?us-ascii?Q?F3+EMY+0Eus1058zUOpiR/xzr4Bzb3NWUc6sLn4+DQupuee0EKFioxWVvDpE?=
 =?us-ascii?Q?83TTywbP1Hxp/3Hnsl0oZxoJYwjtsgAfJlAkC7N91sPOoP/Xr0OTRZXr3czU?=
 =?us-ascii?Q?7FZJUDTuq3K50oICBb2s30+l6njdXd94ZGPSp6JLzyDLJ8erZxSaczrzeLhN?=
 =?us-ascii?Q?Pt+Pbl0azsEYa6TWJLazFYg6wcuQbL5xh4JPvWNWIb54ta/Byn04OXFbzKYu?=
 =?us-ascii?Q?+pol+p6sJikxNLKUVshOd8hsbdxMkrGZv1i3Bv5ebLtxjWYmnrH/HEkp9gAS?=
 =?us-ascii?Q?24Ci0lyAYuQ2fOrzDQQjv5b3DtJ9zIBp8+nxXKRL1NBKQj1R3k/K71nogcOH?=
 =?us-ascii?Q?Fwo9gvibhHAzacJ2KctkeuU6TPaHEqjmimKCqVTwyrhv13T9KUbE4Z1IQiWs?=
 =?us-ascii?Q?qE8SeJpYW4eBtu2cNyBy6eBszKIcTp3Pvq38h2aOatwz+U/vGmclFL0cbCSb?=
 =?us-ascii?Q?4HUcESBn1Jk6hh2MOLt+tqGiGc9UlRXFFUC+5rHDD47eH7rQreT8e78fhi+s?=
 =?us-ascii?Q?OkCOB9a+I6wGhdjnt10zfuxXaZR3BcwUOr6brebnv55SUBDbMd7oJ4FPqFuX?=
 =?us-ascii?Q?rFPbzMcVcI9/d2zMySnd43T2XnGAVW3ZS2yMpPcmrmCLGpaAT15ZsdLNqiF7?=
 =?us-ascii?Q?+a6gAr1Fy67ofvB1ODdbDXFnxsAztr71xm+f91uCMGw7XSo7xAnLC2OXDymn?=
 =?us-ascii?Q?1vUAv5pwSqyfYoKR8bcf3ZLuyG4iEl7EmVED5eFAEq1oyIG5pavHx6QAktoS?=
 =?us-ascii?Q?WBk4DQlBeJ5USBB9gFKalGYnZAzk5MDJcHQWdDiEiHqHNbWGGtsAagIqaXPN?=
 =?us-ascii?Q?nRdnq3/gV2FxpMM7os2mYF5sitc2V+x1uk0YDiI9c2n8AReI3LGh25WDjqVc?=
 =?us-ascii?Q?geJjskQ+APwtwPUuvmWjpC9nI/OMNFb6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vITw/PAQ30YNwDqCr8cvy9llaSvj9u1XOn5uPE8wWVnzOv9W6EUWc6iukYR6?=
 =?us-ascii?Q?OH1IaPpPHwWmtZ+usV0RXHg2zZgd8NqPxx/281M5kYUMem4r1A4C4Zdh5qG/?=
 =?us-ascii?Q?5SgNnI+LW3EzJHcIPB3A/aafkw2hPMtP1OggK8m5p8J3orhyHv1RxVfyJ0lq?=
 =?us-ascii?Q?H06DP6gHpUx1RDqHWXgWcHBmH6zf/KjewlAk2C1Y9uZ1tEB59thcWKJZLZJr?=
 =?us-ascii?Q?1Ug5XCDLnA2tiyASbRs3ihdxRnyuGqFWivn0CWfmO+M4IyhIKIUYBfKGMGqy?=
 =?us-ascii?Q?o3R/v+mdwZZriiY3l3NW+tr3XNLc3Q1+ZWuzX4/FbsgVXQPQCdAJlgGCij52?=
 =?us-ascii?Q?6QD5o5UFgn1Kwgtq3qmJ5fcpBFqvSzkPNZzjC1Lr+SB5Y9xspCnLqjL3htD2?=
 =?us-ascii?Q?obhcK9NHlw3EUBeldkQd10VVzlr43UnJcfPuxaIJJv2Qo5Gsg+6iGGHyMzhY?=
 =?us-ascii?Q?jX8gAmXMsyj8GGDlCDeTZdle41bQ7SbD2PKjG7CSHgxRbnbEXMYIh5pGETsA?=
 =?us-ascii?Q?3bpCywFwRci0jHRyYfqxh7i8WrQekzUaNLGkUUczco2uXR/NMWdTA6Obzk1V?=
 =?us-ascii?Q?0xNyFlcPl067JuMMwSXlDNI2qpFOyPiSdzIkBKuOCV4ii4+sysXeLM7px+Sk?=
 =?us-ascii?Q?fYFhwzpzeYEfI1rQN76sFKaSgZN7hqzdsm0vvgrzRxuR7QIcOUHlaqg5byiv?=
 =?us-ascii?Q?SvLR1sBhyPH7E3C9BroKW20cFnw3TM7xRdSXoM7dr1iXUTZFW6EHjyR8XH6p?=
 =?us-ascii?Q?V8aLV3bqNpGA31du5qzemJQ5IpJHNlXToTVNA3HEMhHuolCAn4bC2OuhX4jF?=
 =?us-ascii?Q?k6walRsZ00MZW3urzO2wgkQD0+RzPBq59v8NLUrVuCVLNFRTBOS0XHEtX0ZA?=
 =?us-ascii?Q?MTPnxpBB2X7NhYfxK033MmIOx1N3FnGnTLQCsiWQfjRDnZFi0Nn+808N8DSs?=
 =?us-ascii?Q?bH4HWYwQAvUPY5/Ich9TW6uPUvTRqV2tSHzb9MxgIOgcxPgSGOZPFVn+BpRH?=
 =?us-ascii?Q?9UqHjydIWI6DplWgSGNeDJb5kN6LdIrHMeU99JJLY8R70hiue8ob9Qklrj80?=
 =?us-ascii?Q?Dk3Ydp0WMOPw/dK0mZ7Z/hg2Kuz2f+mKD/ysGVry8cHXhYyt1XVCkuO8NUQf?=
 =?us-ascii?Q?jQflldzmzeGkddKHpRsZqMX3tzy0bN5y5YO9nffY482a7ca3Tqfya1UoCfJl?=
 =?us-ascii?Q?GybY4zgZLVBKAM8yYu7a/6T8dP9bO+G61XGrzGo+7U1A1lfl12aFw5BSOh7f?=
 =?us-ascii?Q?qaSV2nljxp5EbGgE2E6VWt/4b9ocy4CTpgzDNzGljiRexTIPtoIJx3ZVWHRQ?=
 =?us-ascii?Q?i4/6KhwHvku25wCtI7FbWQieen7NdvK3twokUCiPgMMTUu39USV4L+DIieP4?=
 =?us-ascii?Q?InUQf33AQTKRiMOM9fDEqUyS6bVVEIjw3Jzq0xrC1+2BrOz4hIL/a3+KfpH/?=
 =?us-ascii?Q?7JJBBkF//oT7icEpJjz9dNit8QEMnXPs7k4S3Ws20WV/k9AzdVTQmd2iTsmI?=
 =?us-ascii?Q?w14hcXUALuT/pRwn4+hHQ1G1cCJQ/wleuh1Le09CPhAZUkUU9LwaVzTSke2W?=
 =?us-ascii?Q?4i8STVhpllEgk7t7mLI/Iz4SS+3O6Q3kWEKFpqVCgqUyS3nzjdZvq1FSLL0v?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4cdf34-48b6-4910-0bfc-08dd34ee24bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:52:38.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjAoX61Iwr9lsrSiTCZd9FYzMv4ino4MsrL8olz4kwzGK++h1U5S9tR8H7KE/0gOmBrQSaulZeTULIECcyj1GMqm4ZQqFg5MiUQvqaZwGlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/8/25 14:32, Alejandro Lucero Palau wrote:
> >
> > On 1/8/25 01:33, Dan Williams wrote:
> >> Dan Williams wrote:
> >>> alejandro.lucero-palau@ wrote:
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> Differentiate CXL memory expanders (type 3) from CXL device 
> >>>> accelerators
> >>>> (type 2) with a new function for initializing cxl_dev_state.
> >>>>
> >>>> Create accessors to cxl_dev_state to be used by accel drivers.
> >>>>
> >>>> Based on previous work by Dan Williams [1]
> >>>>
> >>>> Link: [1] 
> >>>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> >>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> >>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >>> This patch causes
> >> Whoops, forgot to complete this thought. Someting in this series causes:
> >>
> >> depmod: ERROR: Cycle detected: ecdh_generic
> >> depmod: ERROR: Cycle detected: tpm
> >> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
> >> depmod: ERROR: Cycle detected: encrypted_keys
> >> depmod: ERROR: Found 2 modules in dependency cycles!
> >>
> >> I think the non CXL ones are false likely triggered by the CXL causing
> >> depmod to exit early.
> >>
> >> Given cxl-test is unfamiliar territory to many submitters I always offer
> >> to fix up the breakage. I came up with the below incremental patch to
> >> fold in that also addresses my other feedback.
> >>
> >> Now the depmod error is something Alison saw too, and while I can also
> >> see it on patch1 if I do:
> >>
> >> - apply whole series
> >> - build => see the error
> >> - rollback patch1
> >> - build => see the error
> >>
> >> ...a subsequent build the error goes away, so I think that transient
> >> behavior is a quirk of how cxl-test is built, but some later patch in
> >> that series makes the failure permanent.
> >>
> >> In any event I figured that out after creating the below fixup and
> >> realizing that it does not fix the cxl-test build issue:
> >
> >
> > Ok. but it is a good way of showing what you had in your mind about 
> > the suggested changes.
> >
> > I'll use it for v10.
> >
> > Thanks
> >
> 
> Hi Dan,
> 
> 
> There's a problem with this approach and it is the need of the driver 
> having access to internal cxl structs like cxl_dev_state.

Apologies for stepping away for a few days, there was a chance to get
the long pending DAX page reference count series into v6.14 that I
needed to devote some review cycles.

> Your patch does not cover it but for an accel driver that struct needs 
> to be allocated before using the new cxl_dev_state_init.

Why does the cxl core need to wrap malloc on behalf of the driver?

> I think we reached an agreement in initial discussions about avoiding 
> this need through an API for accel drivers indirectly doing whatever is 
> needed regarding internal CXL structs. Initially it was stated this 
> being necessary for avoiding drivers doing wrong things but Jonathan 
> pointed out the main concern being changing those internal structs in 
> the future could benefit from this approach. Whatever the reason, that 
> was the assumption.

I think there is a benefit from a driver being able to do someting like:

struct my_cxl_accelerator_context {
    ...
    struct cxl_dev_state cxlds;
    ...
};

Even if the rule is that direct consumption of 'struct cxl_dev_state'
outside of the cxl core is unwanted.

C does not make this easy, so it is either make the definition of
'struct cxl_dev_state' public to CXL accelerator drivers so that they
know the size, or add an allocation API that takes in the extra size
that accelerator needs to allocate the core CXL context.

Unless and until we run into a real life problem of accelerator drivers
misusing 'struct cxl_dev_state' I think I prefer the explicit approach
of make the data structure embeddable and only require the core to do
the initialization.

> I could add a function for accel drivers doing the allocation as with 
> current v9 code, and then using your changes for having common code.

Let me go look at what you have there, but the design principle of the
CXL core is a library and enabling (but not requiring) users to have a container_of()
relationship between the core context and their local context feels the
most maintainable at this point.

> Also, I completely agree with merging the serial and dvsec 
> initializations through arguments to cxl_dev_state_init, but we need the 
> cxl_set_resource function for accel drivers. The current code for adding 
> resources with memdev is relying on mbox commands, and although we could 
> change that code for supporting accel drivers without an mbox, I would 
> say the function/code added is simple enough for not requiring that 
> effort. Note my goal is for an accel device without an mbox, but we will 
> see devices with one in the future, so I bet for leaving any change 
> there to that moment.

...but the way it was adding those resources was just wrong. This also
collides with some of the changes proposed for DCD partition management.
I needs a rethink in terms of a data structure and API to describe the
DPA address map of a CXL.mem capable device to the core and the core
should not be hard-coding a memory-expander-class device definition to
that layout.

I am imagining something similar to the way that resource range
resources are transmitted to platform device registration.

