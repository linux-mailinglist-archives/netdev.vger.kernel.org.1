Return-Path: <netdev+bounces-223894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D9B7DBC4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EC3460A01
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED76303A35;
	Wed, 17 Sep 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUCGyZ6r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C48302141;
	Wed, 17 Sep 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095104; cv=fail; b=kIN7WE58IxLsyl2yxc+vnZFxDeotwVE+y+aU3Bs7uPu0pamGpHdKr4NhdhYlHrYVs7E5n4Hhcm3lrcLZi/6L53VUDCa6p4ri0SiU1uGqg0/cu+0U4g5pcK4pq7EVuB3XuDUluYV7L2M73i2stYWm6U8gMqxsEo9hDFRAd8l38R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095104; c=relaxed/simple;
	bh=bAcavMHLtsrQXYCgoew+ybR5bfSTcs4gbn91zYqpc+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chGccxg0hSyj0PTjpeCD2XIJTkrCbE1nrhsm/ukzJpDH5+ytTvHbuzyadcM2U5F9j+OnsuegCiwfaaiVEfyVr9yD99OC2PU7sk5AipTR+0kT9++K9EvmFKXJ/ZwfjcUPcNnhIPvrC+OmDoVyEcDlfZyixpWLlDgGluSTENSeWJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUCGyZ6r; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758095103; x=1789631103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bAcavMHLtsrQXYCgoew+ybR5bfSTcs4gbn91zYqpc+w=;
  b=BUCGyZ6rG3ruSWeQfQOtfKkOoQt5d9ImCZKt+6NdAb0EU79CyFl0HHiS
   6f5nvqlVn3+8+lLtKv6Qtt0tNeIJFffUUpyN8saZu0UMAViY0rsZdcU5n
   Le40gfYXEsEaX1/+NDbUXbriZ3Ecd5sw5OJyWHT6k5X+8MaxGofTYp0kG
   yjGx2LSXjlRm/fudjtmVpgfWsW1wSt67eBOFRvsFHBBtyTCI4NM5FgJwv
   d7xk5dJOtoH6wnWkn7dhHPKjTVoM68aHTs1NPy+/xfifw+o/678/1YE3z
   /WsMxSFXnvReAXg2eqLYJhvQ1nmy81jeR3igzFox//WTlbPpeHyxl/NLE
   Q==;
X-CSE-ConnectionGUID: 2f6UUYhdSnikE9ZdvpS4iA==
X-CSE-MsgGUID: zUZOKupiS2adJyyJiYloPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64210304"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="64210304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:44:59 -0700
X-CSE-ConnectionGUID: 8OXrnfQQSaW2ZoXqXLTCiw==
X-CSE-MsgGUID: Xg+kTSq/S+ir9LSdkT3HlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="180436961"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:44:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:44:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 00:44:57 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:44:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfw2Q4JYdzy6k/clwOAJrRYc2ufBYRrJo4NfVkj4FBv6h0/DEVz/qCHVJM9Hv1GV//jYOAf3W5GRsZ1hCvz918dfyk19yQo1fn/WWL4FwEevgqZD61Ov+zVpOneZTo3F3RwOyadldKoG3dCeWaUQZJP5p0IPte3moTv7X4p3evqeF6A503OhcFkW91foIFL5KbibQ+4/sitAZX4T1ZqZtxrtB2qSogL8rCze8tzzhAeSfrj1IV1cXvd59t7/czwVnBfueQhBDhkprFsLcKLiFLpwydu3p2Oe4U5KEvELd2FKcsrTc+id46cfJukAqfsCbrKIYE/mRcah9klM5iOFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmV1xyCuYCAuVSu9cehf8bT3JCyRVO7JBiJSU9DVQPk=;
 b=AHAzVq5vAvNdMpsXzYfOo/IVkajFDLVtJj98Babp1pjIGe6uOPMJy8C5QodOxyfNaypDpImNaoZXBHP9tIsjPYWDsLEGG6rRiMTEKs43Yf7Qo8WY58RhRu0l0esYBkAGSVyDSXuatTO9WyojO9USlhISoKKCyGW0eVQGnUG1VZUsOSiZ40hlBgkC5KaqSyzvDlIwKJoqmuP4/MmJkM9fr5v/ol//AO6Imf/dlnQW4zq2lc+SFyvjvPNPGYh1pOw5gDH+inMQipSTPvAKS3jUb4wZOgG5fkRZjk3fS29SW/2kKMFltfoiGEcG2us2/RzOxcrNWW09LWpGLm1HDhXFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS4PPF641CF4859.namprd11.prod.outlook.com (2603:10b6:f:fc02::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 07:44:53 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 07:44:53 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Koichiro Den <den@valinux.co.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"mateusz.polchlopek@intel.com" <mateusz.polchlopek@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v2] ixgbe: fix too early devlink_free()
 in ixgbe_remove()
Thread-Topic: [Intel-wired-lan] [PATCH v2] ixgbe: fix too early devlink_free()
 in ixgbe_remove()
Thread-Index: AQHcG6Iwd82lgouf10S1mbUrl8rEUbSXFJRA
Date: Wed, 17 Sep 2025 07:44:53 +0000
Message-ID: <IA1PR11MB624143ECF3E9827B7325588F8B17A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250902003941.2561389-1-den@valinux.co.jp>
In-Reply-To: <20250902003941.2561389-1-den@valinux.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS4PPF641CF4859:EE_
x-ms-office365-filtering-correlation-id: 10e56712-d779-406b-ff6d-08ddf5be16e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?R6kuQy309pdIbMDzwH+t14QBm2QrkxKHAYOBUGo6h6cHhJf9KyVcn0gx31g6?=
 =?us-ascii?Q?kzcudzmCb1r0IFzSOKhGDvewhgF8rNvXvDWFSjGhEspvSbf7iFa62FAPdyZW?=
 =?us-ascii?Q?1MrrxpYeOOtWN1lv781cSvCKqhX4si+I5z7/8yoNEk4LTDoWvWfOL6NVOdGY?=
 =?us-ascii?Q?3FzqtzKqdT8E+CFAbisjtpApq6BqaMqj/UNp5H5RtpXyXsu/j88P2MyAIj4N?=
 =?us-ascii?Q?G9lVMMPuftvPLqhnSUZZolenowL5UE0CtAWkPLaAxvem0yinQ+zw6JqELPJV?=
 =?us-ascii?Q?7ecjbWQGk1AMQ1dP6w8sslvjsO/1Y4KLYcyeZ1JuWlygiuIW60oPFhZuEJ8N?=
 =?us-ascii?Q?dLtWBW5O+8Bn7IJTr/mNsdLOzJ49YQt2N5bxTg7XxEZi8zugyHQhTbT8mVcZ?=
 =?us-ascii?Q?xSOMpKm60GLWbLyOIMmyq231lhlg1HepFvpQQKcGOs2B/P7o6mdVxmHiB2n6?=
 =?us-ascii?Q?sP04vNF4v3N6dYig8RG+v73Y72chNODjfg5omXhLCgHF+1S1Iomzq3DY+bkI?=
 =?us-ascii?Q?6UaRnoVDXnPK/7sV/5SCqsqrqT/VNsciQ4/1pfTdxJidtHGQ6xxLNhDqqzm7?=
 =?us-ascii?Q?7sZf6azSi/he5N+kBidIgz5cRzXCa0kR3PtvGdtaL8N/frh3X+cbzeekih7j?=
 =?us-ascii?Q?d4dmUSZQA5OsuOpgsJTmfGU1Gv5T4DkEn24Q6FDR9FjV5D5NkpdF+qQt/nuq?=
 =?us-ascii?Q?R698wAvZJ+dNngJWm+GpFZw8sPZPPltWIXeohHZ7e+e4Hevg71GM5ejaOM0t?=
 =?us-ascii?Q?jALMIWdcZClsltros/IPtrabVhQGva+Yr7NDpGC/nHwtGYjPliSntvm+32/p?=
 =?us-ascii?Q?UMoqfJWnT++dDgNmG+EBGdDB57QhqSadlB72O6FANJoWxbFx2o84YFK7K6aR?=
 =?us-ascii?Q?8kurDES3o21oYnwfoqn0wAIcW7lw1LywVh8Pi+K+QO4/ahAMBiiQBoMlpPZ7?=
 =?us-ascii?Q?4eOpyNHMmLbIpe2D6dqpzdXpvb5wMu/7tnkNwiksFONVH8yq4ZNuBXI1Sd7M?=
 =?us-ascii?Q?dvgmFWKFjIjsBeLaQx2GtYL378iNHYMsRIIMW/zgOmzD4EW6i6abWU8eV36J?=
 =?us-ascii?Q?hYimFcIhKYRvmCcXa1Vhla6DFfkTJYFe/31wXvWIhfpBOWrPnQF47tVN+b2s?=
 =?us-ascii?Q?45UTpVMFg/7DQXuerbnmHv4JEg2hU8aCfG3gyh6FM1hx4npJHh+KhMH0XyXy?=
 =?us-ascii?Q?05h6/NrwguFV6D6DSCxvxI9Wn3Mjcyp0bo2D3e+kdJil+aGolMju56+G9Pmy?=
 =?us-ascii?Q?+2Evr29xDD7ddKH3MLxCJm1/oIfqAfcdMRDdE+Z9nYDksiJv0ljgNvFFzuWJ?=
 =?us-ascii?Q?4LuyvWqWzRz29zV48sydqKrlbeqlG76ABNRPkLWQWSp3vAHFmYgQW+oSaxTe?=
 =?us-ascii?Q?bVVsBebHXTlyVkvk/Bgs1cu5dNDRYPGhakylECNql0s+mqKiwn3eaHO16cJE?=
 =?us-ascii?Q?xfaNS/yFiZWh9feOzYPyOlbibB7rG8YDnPpsJAa3+aUL3pzJwOSQElq/zixz?=
 =?us-ascii?Q?8ol9+PNYwsPNwSA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DGJB+kfmY1SlGuiE1iiRSl1dsn7vsSVSR107p30iWSYx4spwsZPjL0jhKVZV?=
 =?us-ascii?Q?E6fKFx6PrzicgISTLwnU5ML3TQbxeajsewgH4xylQx3KZHBk6ddM0PT/Z6MK?=
 =?us-ascii?Q?UZkL6QDADoSiXLmEMFyiC+gpcJ8q896cgcRdQZwWmylSeSh4iKuka1UCdeJn?=
 =?us-ascii?Q?frZp8ysyYslwXu218/a9mhbASafoLpj8bthrOiEcWG7i/XB5gulreCCI9wIY?=
 =?us-ascii?Q?g8Mvr7uOHpTnho9lp8NVRCg2dtZIfSKDNMwmKP3A9+aHjDt6ecNNEbwOpbQi?=
 =?us-ascii?Q?XweK2xQn2qnOBqG024JmBntFIKWhZZqepBPS5NbQGkGmMM560fp0uUlQXz/L?=
 =?us-ascii?Q?fnUx1PDKneVtW4KbkX9v5pyCup9BqQrjtYVQbhSIUlRVc8FsByzLMjLDca5G?=
 =?us-ascii?Q?kX8XR5Y6q+nHpmzkcpIOuoe/YoyOLJbqUtInMx8Zvfsz3FzdVka2nivqEI0B?=
 =?us-ascii?Q?3lUW8RkSKj0tfNnkizm/xU/pJILshJCNy9ljJfXbOQYQoGbm29Xc6a9h5PKI?=
 =?us-ascii?Q?pieaLXm29M0GtSJK04GqNnsiDh2JDbwMJExRy6p5FyuZTADvrmzXaBKiI2bH?=
 =?us-ascii?Q?t+s3Gd/O8WWGb2r2xS+rztBxYJOmStR1JaHcbzf3sY3kdHHw2DC+Hf0pk/Pq?=
 =?us-ascii?Q?onaTxfndKsCSko8TsBW8Yc/r52x1vlkrn38pkf8BYMxu+hbiCbhGkQYQBRW8?=
 =?us-ascii?Q?Z3/Ry2knvGMN3JBJbL+KgkKwKRLlZruDliYSQ7JwgJz+Q1HiHAzkMiEnLDIE?=
 =?us-ascii?Q?Gyfil7eDPbSDkv0WZppr9qHg9Ur3h7SV8i1c1z5Xirf21cgLXRkx9Ms44IYj?=
 =?us-ascii?Q?NobCliA5e4VxOygHb0yju0bYUBI1MHbybKw4Rwt7cMstf2PPQ5kKFmWJSjT5?=
 =?us-ascii?Q?DuD9IR7pqztNn7aAvYzB/8GK3VMCEGhFsdOULlgI6IgvG3sNZ6ateJxRm9Eu?=
 =?us-ascii?Q?Ib+8PwTrbrcFlRR/RbTMbvS0DPe+c6cQg1pmjFEnslBrr7ZPNIcWE3O5ClPR?=
 =?us-ascii?Q?aPTRvjFyZD3d7/MG126t8uAs0m/rSXeLRrirgNFaF2IKMkUqMfLCh/uZYVI9?=
 =?us-ascii?Q?JHUxvJU9gqbp+pqhXIEVaLjH+H9WT9QEsJ6GShZkHwH+ePSviOo838BfRB5H?=
 =?us-ascii?Q?BayCNtelu23nbqExKK0x5LMDzWRlfkre2wIGyvnpUuJNf8GuAq4KB4mmAJz+?=
 =?us-ascii?Q?dKDDYJOtf8FcMOT5jq7crXygZwyPONj9hj6RSWIaAkA5NGtWW0eBNR6xZ3LI?=
 =?us-ascii?Q?sEAr3HrDjh04lxj48DEg0fQjLFs/kdAphaMhSoDk/13a+DOFcLgzqBJVnqeq?=
 =?us-ascii?Q?KDfUtXBy53NQAidDYR2wc1VQqgQoQdfdCK7oiqf8vkCba8mR7nmkPqPRECk8?=
 =?us-ascii?Q?TpdJS8B9p4NIFYXoaETxdkgLp6PNw1QKEGQwywdy34wEsFwk9Wkshd8wpnIQ?=
 =?us-ascii?Q?tvUhi7DZXiqfaluOzWIxxbSCy3O1UhAGaf5Si+1jZH8lLHrWZGWP/PINdv/a?=
 =?us-ascii?Q?YO5vAiaoNnWf8g2e3S0UQSzJsNYzsMV9FLMn1ZBh11jEv0uu+ElXJOQ5zbnE?=
 =?us-ascii?Q?65OSjXnH6+BH5xEkiLhXp93/qEy4wrjlbNdhQ/EU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e56712-d779-406b-ff6d-08ddf5be16e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 07:44:53.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOVqSmToW9/Fgnd7uOfANsdX+yNbsV+b+KRKfVPoUps9JcRjvje0CqvOEXweHvOrpHPmHc9ogFWZHwugOtgblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF641CF4859
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
oichiro Den
> Sent: 02 September 2025 06:10
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; Jagielski, Jedrzej <j=
edrzej.jagielski@intel.com>; mateusz.polchlopek@intel.com; netdev@vger.kern=
el.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix too early devlink_free()=
 in ixgbe_remove()
>
> Since ixgbe_adapter is embedded in devlink, calling devlink_free() premat=
urely in the ixgbe_remove() path can lead to UAF. Move devlink_free() to th=
e end.
>
> KASAN report:
>
> BUG: KASAN: use-after-free in ixgbe_reset_interrupt_capability+0x140/0x18=
0 [ixgbe]  Read of size 8 at addr ffff0000adf813e0 by task bash/2095
> CPU: 1 UID: 0 PID: 2095 Comm: bash Tainted: G S  6.17.0-rc2-tnguy.net-que=
ue+ #1 PREEMPT(full)  [...]  Call trace:
>  show_stack+0x30/0x90 (C)
>  dump_stack_lvl+0x9c/0xd0
>  print_address_description.constprop.0+0x90/0x310
>  print_report+0x104/0x1f0
>  kasan_report+0x88/0x180
>  __asan_report_load8_noabort+0x20/0x30
>  ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
>  ixgbe_clear_interrupt_scheme+0xf8/0x130 [ixgbe]
>  ixgbe_remove+0x2d0/0x8c0 [ixgbe]
>  pci_device_remove+0xa0/0x220
>  device_remove+0xb8/0x170
> device_release_driver_internal+0x318/0x490
> device_driver_detach+0x40/0x68
>  unbind_store+0xec/0x118
>  drv_attr_store+0x64/0xb8
>  sysfs_kf_write+0xcc/0x138
>  kernfs_fop_write_iter+0x294/0x440
> new_sync_write+0x1fc/0x588
>  vfs_write+0x480/0x6a0
>  ksys_write+0xf0/0x1e0
>  __arm64_sys_write+0x70/0xc0
>  invoke_syscall.constprop.0+0xcc/0x280
>  el0_svc_common.constprop.0+0xa8/0x248
>  do_el0_svc+0x44/0x68
>  el0_svc+0x54/0x160
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x1b0/0x1b8
>
> Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
> - Move only devlink_free()
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

