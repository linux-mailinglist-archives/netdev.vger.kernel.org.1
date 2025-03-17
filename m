Return-Path: <netdev+bounces-175315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06134A6510A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B770E1895E84
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67623F28D;
	Mon, 17 Mar 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrJdlM3o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB52417E5
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218172; cv=fail; b=ENS0O4mZ6b35Y2cGvYCeUy//aqXR+QFMbQbuWKS8YrIrPIX0SheUnZGOXesMyuII6GFPRfhcxIUhzdm3lss35G++OdXQApE5/vH/SD+153S03WZypEqhtAVzQcjs429Fp66ii0sBjQkmhmJBxqpatilyRw/AZz+ykHC7vUyTukA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218172; c=relaxed/simple;
	bh=UhgwWODPuaZLDTxB/HXLVEeQWLDrF/x/yWjdrjsWfnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnyVTH8G+UuMLMnfeYmBxeGHfqXOfXoSMNRj2eVprmhuXhrxCo16qWi4HVmFdSGn5rDIslh0qriEdiu85Crn2CDLOa+Eb9jNihlrz2h99CkwYCa/lT4bkUx1ZbWn53dFIyqC7+dQ08gOzENUsI0+DAy235ORKGAsv8o0CbzP1XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrJdlM3o; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742218172; x=1773754172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UhgwWODPuaZLDTxB/HXLVEeQWLDrF/x/yWjdrjsWfnM=;
  b=WrJdlM3op2xj0M49RzO2jSISCwqRGiZzkvd0ugPZRCvd1yJZIX3yd+4m
   fjuLAtUWWK78icElEinzL0cH6CJcnP+9JIXukAmSW/0GkW9qLri0u2yAW
   wDWWMplAOBWV1Jorm0Mc3gKocUiKiRjBMoDK/QCIM1bl8QnJtweQmEIHj
   9P1Xx0pQKZ90Kdh8dvC35J8oD/jhwFODnNgiuqeEwN4A/I2PrMGWlW6hz
   0aOwBJTGKU37qApzMXlRltZvbdoldjQG7BVkFFW9maTxrWd6EV/szxnYM
   vOBjMa+8ElS4R39/35IwtE8kte6GwybxUw7RLir2+OXY7onusE8eRwxU7
   w==;
X-CSE-ConnectionGUID: 5kacoTyETWK1evdcP/9PfA==
X-CSE-MsgGUID: gmjTyKqfQRaNUFMpHReV3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43177805"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43177805"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:29:31 -0700
X-CSE-ConnectionGUID: 0Y1uxS/YTb+cXfm0BTzC8Q==
X-CSE-MsgGUID: flf9kcIGRbygcYkgYol3BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122122230"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:29:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 17 Mar 2025 06:29:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Mar 2025 06:29:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 06:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCEMXt037iEM49kpn9EI5UTEBxNqzQAgnRj9n1bLdvVM0f3ZmUOS1kVhaVstTTFb3TvNSQ0gpXh/qQV96LUQvqaycpmsoF2EbW1uYNgSUfHQ669c7gLBPocD4tS5bnD8Z+4022sMvfSgFCeU6aWR++CTexBJ3Y/0FhFTj9K+dghtWHJ4vGtmLlQGPrLCffOikecP2UBM3POhYQEdLgG1YozT2r9ciDsrjyzTsSH8bZhDBhViS1savZA4OAlmXM+h9bx3fCzJWBR2GwzBomeNDH2z3b5RN5f+LZb4x3AO7XkkB74GBYI1P73I34L+tfSjmMNFmmG2flpd17cbDjEjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQICBAkbg5FzLr/FxN/tXZOwPihZH5WAgwD/i/5OyPY=;
 b=Poz0PPTSPIEdo3GfUMx+sC19K3R83M5Pwkcf9Jl6bsv+BGxlrDk++3JS8ODHMzBqVAX181WqTWxOdnF/K6/KdZ5RBeGaw1EGjpc9HBOo+sK1Ho4r3i/pMRTm0+W7IUN/XsTZ8JitYfjfkk0/T9eSmgH0WNtrJCDYlpusnFbKBAbXjUlKeko9ux+FvpizTSbMoz9eBrh/B2OzVHUsh4+CBbHoWkLcBz6xmoG+LUSz0alpL6uX1NoYRScYJjQAeWmqlmpuSfDf2/bkKNkuwNLa45cLXgdybnxjUKm+vuo7ewjlJM5ScTvKhRqm6Dbg1my40Chq07mA1Kk/3czwYSwjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:28:45 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:28:45 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Glaza, Jan"
	<jan.glaza@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-net v3 2/5] ice: stop truncating queue ids
 when checking
Thread-Topic: [Intel-wired-lan] [iwl-net v3 2/5] ice: stop truncating queue
 ids when checking
Thread-Index: AQHbjPXnMKdes9pBWU2Mzf1TTr3IZLN3Zv3w
Date: Mon, 17 Mar 2025 13:28:45 +0000
Message-ID: <SJ0PR11MB586515F5FA4959B00073C33B8FDF2@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250304110833.95997-5-martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250304110833.95997-5-martyna.szapar-mudlaw@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|PH7PR11MB6676:EE_
x-ms-office365-filtering-correlation-id: 559df60a-2250-42ca-e6b7-08dd6557a49d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gEYjNG995VW0QVMmAtkRQ2MzzLOta7BkAKoJTwfRkl7/hOdzi7Eln9RqcKu3?=
 =?us-ascii?Q?weAse1PO3moDb4Otjc84hfUjpByqjOnMyeq/FdawjgH7/2MBM3ofVf/CO/Gw?=
 =?us-ascii?Q?nHWanfQwtr7KUC4fie5chqrtoMaAHHVoovFVeIH0y3oyjjB2g79jc4rW/c32?=
 =?us-ascii?Q?vATsE0yXdV5MT7K83bdnuimhcXcBp9lF7niNDxnfJhOfAJtB4nxQSFadKr6h?=
 =?us-ascii?Q?Zk9eVRMsuq0G/RSuYN1pO/2knYZ+LDYAYGO97OSIiPJxq/RDsOVHN1GDhpnJ?=
 =?us-ascii?Q?DjzZ5xlpLoGzGkaNa0baNrLRR6Jq2Nd2+FtVJZyT3j2Bh5aF/LZaZrb3IHvC?=
 =?us-ascii?Q?Ym5rpqmhJ7WThbp27v53BVN6hEPXLN62npWhE8kNpmolSDW9xeU5CI9TSEvt?=
 =?us-ascii?Q?Vt3as2d1ZARKaCA9qnvsmvT6H2tk+3kpG76q0eU4hqP8W+SM299+/hjzK72R?=
 =?us-ascii?Q?HRNHpZ9Dn2tOaiexVD6creNpx3QOf/4ak9Y5CeNLZVMntBcITrMR5uvtiU+1?=
 =?us-ascii?Q?V7cftp8IMewOoqnLxjAymHDwEwJ72/SVZKAuuHZaVnYAr02rzLfvLo6m8GDt?=
 =?us-ascii?Q?/l1QOSNPstNt56Ms6H0IacRjkBV3o7dlqQvVHUIStYBzvMHcyfpDiM/EMlhb?=
 =?us-ascii?Q?drOVH326qebPzMJP7ZqkERz827lqdltXDxaE40SgK6bhISQrhxhAlbUS2CPx?=
 =?us-ascii?Q?ChYWOHsdGxGi1oVDAAo2XfjU4cQgu46cwyF9+drnhhsto7obyHMFKgUaLSgo?=
 =?us-ascii?Q?H5Qq5xUdnxHSk2RbExdV50SB2Oj2bA4LSY8C2bUs9wzhzDp/TXPjUDnXh0xP?=
 =?us-ascii?Q?5MZ4XYaaemTP0kP28qzpVeMGbVgCe9jBp8Coa3hQgKtRq43laTjK9/jFD0sB?=
 =?us-ascii?Q?Id+osuv6WXVIPPGHZX5AVanciEdu05mlVl8HWhw6i2ZYwlVXVIkB/q/cYbmO?=
 =?us-ascii?Q?0LjprY7UjQE9D3lG6aAJQ147j7xw0LYVLRPqh+bSH0K8KXKgbugNRrieSHMF?=
 =?us-ascii?Q?PYd1go2Y89B9pAlwZKaS3QBTDeWUVjrrorIaKnnfIN0AUc1kypi48JX6UqW8?=
 =?us-ascii?Q?gzh6Rsnfy+bcERzlDALrAU/mqyjhiGupQGf2Plvk1sn/4wlt1ssfs5QrD3Z6?=
 =?us-ascii?Q?DCdqPUN03Py94VGNXrkwsIizDgKVOBbI4xvVSknMJdBsEFO1B5XlrmLqzsPX?=
 =?us-ascii?Q?5VSCQyp4TGnYifJ8n+qpteoy/8qQz2nW8+VkKLVWFq9mWxK2qQmojR3Fgk9F?=
 =?us-ascii?Q?JuXVQ+xo5lBNRCYTL1ZyYjqgEOl59GOkxZ7oEapQS1yRfBZLgM53al3rgvjQ?=
 =?us-ascii?Q?xZlhmRAfRpLOrcq9Crbpc+itjL5NQO/dNx11BUOnxICUY6X8cYBL6Tr9WMy3?=
 =?us-ascii?Q?S3+9S0Kg/m6O9ZAwKYMgQ8ZEQU/FLZOWdCadUtUbnL0EbnGA2+wlvIEyjuOG?=
 =?us-ascii?Q?4d3UGnCzd0sFjrMFl84eG4CxDLGktKkD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BsyW9C2G2Pwqfl+um/3kKwTxszCB1PB+BBfZHnYL2pC44t2rBmgWpwldvSYc?=
 =?us-ascii?Q?ZpB7f7rRBu0J2xvWzo4ppcB0l/OgsGUey/aFI2MACf3Sjjl775qeLHOX5XyE?=
 =?us-ascii?Q?pXbtQD85MzWpTKdQ9dJQZf8Ca7GapicLEahRj7ivr2fAht2VPyIRggmi4t3n?=
 =?us-ascii?Q?cog/ez0oyojjfRhy97oe6tEK87k2gsnsxy0NGifwCMCLOLzUm2qHPBB2om3R?=
 =?us-ascii?Q?jSNRyfdO/q07lF2aJk2HOd8s01XofB2u3KpsSvL2TK+jxL5vDpL7vYymCoV0?=
 =?us-ascii?Q?bhgtncioI9VSoavdiaLFXKI4/aOP8oUb/nE3hu4ldlCRQb/KCkDbBM+sTnOB?=
 =?us-ascii?Q?SFtpphhZEG6Iwf1GGtCRX07j+gJ7V9lXtYtelYLURNjzxopLUMNZ98SU1W1E?=
 =?us-ascii?Q?3JcaHNjl+9NxF5ss1wbzPwlijI47RdwOWgeWB0LSV0q41f+jpXdMqC9hAcnX?=
 =?us-ascii?Q?2OrCPHn2IT2AJQhM3F7mS/SlTmMI2KEGwyueN3NUrJmKyHu6ckNEShz4TZxD?=
 =?us-ascii?Q?x/qTYVMU9ApIoyq5ETc7DD3uentJe+FgAOm8MTPkA4Fx+Nfg/cFgPCmLq27Y?=
 =?us-ascii?Q?bqtt2jYpi9rObY6ijfoRYbyDb7mLV9wBaN++/nw2UIlZ6fQ2vcnaXTKw/5CC?=
 =?us-ascii?Q?A4Vww1eOZyNqSgm1mI5RBpMU3ewuINvEsWcQaVYfDI4ke72Dd1w0S5v6yymd?=
 =?us-ascii?Q?xrdJ0+F+SnJEU5ciKk4tTRaXNMAafIraZxCKWgH/LDnHfvPwDCZ3beL4oRlr?=
 =?us-ascii?Q?0IGCeqqaMel094/kdcEys/Yf5LpEozHRAE4O6J8xNw6kktQ2yE5EPgTqVVtJ?=
 =?us-ascii?Q?+MGY0Aw5L/hCMbjOqXdBAwJRh03xRrdqNcM348IYZNuRcph9VYO9MxC2Rscq?=
 =?us-ascii?Q?YH4e1x57CH5+ssYc8NP7omVfVyY3AgodN/3YoJYHT/FA8GpnvH0XeQ+v0mGp?=
 =?us-ascii?Q?y0mjL2oH5zXTlMj1aVJ9dOYJhh+jzO5KcCrVT2gW/82WjztMocxD5RInvY23?=
 =?us-ascii?Q?Kp8qax4t7b5EgSGYLCwF0l5+oSFNaIvY+xCRyZOZbODrhkaEJ+NGFa2BwuHl?=
 =?us-ascii?Q?WlukNUngZQJS0KcEYw8AHmMEf+3WZrCYj4nfKVll8R5T/P1+L8jXVtjLbdmF?=
 =?us-ascii?Q?Vhi+/OIYXXhkm2Ct7Ca6wUpThMgW08nkHoPqfQiHt5nZv5q1k9tewvK0ouFY?=
 =?us-ascii?Q?8iQnqIQnoswUdPJcwjJhpp6daNPSHGLHjbkgjSsU2zwaS/uMSnj/kxkp3/Q3?=
 =?us-ascii?Q?4Z96XlY+uvvRinJhiYsWQjOx4IlbQXvEp4JDaoQXCx0innwqg/Rpy2xJgzbv?=
 =?us-ascii?Q?ZFvmgYUYamFxJQdziRMGBGDijDI1TvGzyuh7zsFx7wb44gAUzK8z4rgeEZgv?=
 =?us-ascii?Q?Y9KVG0Ona+OXN8Tybn1YYN9gZdtXpknjqlm0wqGKXsh1XX6Bz9ELJInv7DrV?=
 =?us-ascii?Q?fRv8mkK4D9tc7Ubx7fKgqhCMyjtNRvKGIwDKuxCMnUgEdUYIvCmKhvayqS49?=
 =?us-ascii?Q?T5lSKWff+M74gyKUZAiO+AIpocD9BRrOdbC6yA7GJf1yxSmmY2SSK5IjK6NC?=
 =?us-ascii?Q?KGTvEYhoJSQtX0PfSFKENvruShLUXyw0CviyMgy5yAwvJG9pUM4Uq8pZOQyB?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559df60a-2250-42ca-e6b7-08dd6557a49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 13:28:45.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCM0hXqrmLuPnockchQiXJ04sE7sQ+Ngr5/got8LQZdplCUyXEY6DyqJpdlCXmuP5DkbT8k7MH8CUmsShh7ZzQK/P0GYRBQmZ2MsXgJmpPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Martyna Szapar-Mudlaw
> Sent: Tuesday, March 4, 2025 12:09 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Glaza, Jan <jan.glaza@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Simon Horman <horms@kernel.org>; Martyna
> Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-net v3 2/5] ice: stop truncating queue id=
s when
> checking
>=20
> From: Jan Glaza <jan.glaza@intel.com>
>=20
> Queue IDs can be up to 4096, fix invalid check to stop truncating IDs to =
8 bits.
>=20
> Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-
> mudlaw@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index b6285433307c..343f2b4b0dc5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -565,7 +565,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi=
_id)

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



