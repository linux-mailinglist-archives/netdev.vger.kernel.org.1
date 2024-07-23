Return-Path: <netdev+bounces-112520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6241939BFE
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31501B21D46
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26D13D2AF;
	Tue, 23 Jul 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTQbtyxz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6236130
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721242; cv=fail; b=qCouyxiyyNyuKZx1zu4ebQLWOTuUgRSbroeu6s4Qg0WMQAsCV72YATFiK2aemxzl09Po6awzdvz7+mr5kl1dvYcy3ZN/H6SVhS7kuPJcPC5+xBYcNxvBDVXjGGPTC+HLZvtb905+6Vk2ux3HgE5QlYb2THDXL+FKC3ABwTpx8Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721242; c=relaxed/simple;
	bh=Y7Zhud0N2JGni/qLOE0RlTQpmhT3sMvB4FMWHdoSFew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhKPuSPie7q4bi6WKkVhbk3VI5dx6UCeMFGzxx+O187Fra4qJytytFmRpCIp98w4o4C7vVfs//e0qRepsK+OdS+jJ+ZTOgwfGqY1xGG6uzrTDI4VC/r4bznxkTw7GgaAcV9bTBpDYHjAbNrrMPjeQzUD19itKdN9WlpRgbv+QvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTQbtyxz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721721240; x=1753257240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y7Zhud0N2JGni/qLOE0RlTQpmhT3sMvB4FMWHdoSFew=;
  b=RTQbtyxzZWTitiqNcElrYhXg/joCgrEyUcjjBii4bSKFAmgQlyFBsF7i
   aVb9xQc/UFBBCOME21nE8Enj+wLxakx0Orl+cfst4G59p0MPN1TycE6lB
   bLOvQdFUy5V7ECYu7edSjgj+yPW7rTQ2L5KA3uzdeGuAaPGCuN6Stx13M
   cLBFPgqs/BaGyqX97XExAFc8WPNfyZLGPBW3Mp7d9aMS5QL+ibLYyZwsR
   xyHP30yqDmMnIkZ+oY6SmnAOa2YERtGsf1BE8UKTLfBtp0W32mIrgxsXd
   2kTEDVQpx/ftft4PhKhC7sA4JaMqYCRVcych/e2iukyhSzslwGnAUHaER
   w==;
X-CSE-ConnectionGUID: kiaYijNGTv+zBstf0+8ZXw==
X-CSE-MsgGUID: Dhl9fmvWRg2XwRDYP6XWfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36771827"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="36771827"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 00:53:58 -0700
X-CSE-ConnectionGUID: ulQwhn3DQfqz16mUeYI0xA==
X-CSE-MsgGUID: lC0FsO1fTyiwg91btSiPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52151317"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 00:53:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 00:53:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 00:53:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 00:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOZrT64hObZ977KW3sPCAksJL8T0GI2hoYz00fEwEnys1wDx/VCmcZkJs2aCONT9f6HEfyXGa5SsMg+rxiZm+/MR8Gyj7B6a/OTmnMsM0ixiKP/YqP+axVKOi6xqreANDBK0mn3wBUqJgx+G80dgBJqfYlvlTwwK8aCK5cEkji7KvmkgKcHAGxHRlpcr8cJ5XRI+dCEpqqFZNKHrIDp3qu7PRMp3BUet9Mfd/TSF675Q35Ax4rKYkVNwLNNvbwDSd4EIE6TZyshGxbIf8k9RYWrde1WcJZi3ZcONrLCjJ3A1BJSqGmK9fqj7/k5KAbysCYqbiGnOBE3DmrWUAY5fWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vum5GfvO8NO6dH0Z5W7smjQbtqPxshEnW/uzRQO+VjU=;
 b=bimo0jWIrD6enEXVVqJ78Ot6FYS90zTQLIx6d+Ol1e6cMvCLXObKWtLIMArl2m8hQ/0mFlqKTyXV+fPOJPPLSWBGeK8h+PCgxH8mm0AFbHJ7cDBO4OKcyXVYhDtBUCQtctV6YDaJzzNQoi5fOKK1UOdUAkWIPIAd3+WAaBwmtC4LdVXyg4ovi9dm9olbQDjQdb+sIcdLs5/vqXYxcAfyLrpTZ8zRbQN5FPw2g6KqXox3lQd9X+4BG9sKeh5+sijFYb1UdTLQqP6Bjg3w577nuDBbY1iNfN9MysWmFighfgjN6v8WsfzMr1YnEAWffOvPPcOJWm8LfzThS9hi2wEb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 07:53:48 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:53:47 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Guo, Junfeng"
	<junfeng.guo@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 01/13] ice: add parser
 create and destroy skeleton
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 01/13] ice: add parser
 create and destroy skeleton
Thread-Index: AQHasGfvzIrt9ONjdk+4Rp0smjCmabGxV1WAgFLysLA=
Date: Tue, 23 Jul 2024 07:53:47 +0000
Message-ID: <SJ0PR11MB5865C56F91B7F9627DC8B91D8FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-2-ahmed.zaki@intel.com>
 <20240531131139.GD123401@kernel.org>
In-Reply-To: <20240531131139.GD123401@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DM4PR11MB5325:EE_
x-ms-office365-filtering-correlation-id: ce39bb36-4c91-4a71-c5c9-08dcaaec95a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?evPhiPqMbo9RCyd+2BJ/j9J+9ED7/4EmD2uC6LFOsAMMIYLtPIPGcegly0SV?=
 =?us-ascii?Q?UIqG5Wur+091kyQqIjFElj62P0k5erxJ5bJRGZo1RK9HJEn0oavVZEIIoph7?=
 =?us-ascii?Q?5cpX7StzuAC2YhK/LQZOHDF0wDO2aH/i7y+BdbMHTh0an92Hpu3Ssbc8Oy7l?=
 =?us-ascii?Q?f5qjiNlzyR5xKVzetJf4YLxh2NGdOi0AsIYhGPgyJKdTccf8MJki0Ymb9Fx7?=
 =?us-ascii?Q?A7LJvEGxzkpEftL14CbmMCZZynur1ZyG6xw8rVr0AM6bzjVhCyOy+eYliBVV?=
 =?us-ascii?Q?Z7/VhgEGsnxCOBhub+I0Z0B69gAXxFdyP39cKHL2DTBG3XiBV32u2veYpi8i?=
 =?us-ascii?Q?aJwmVUHc25Tkw9TVRDr5+/RkeW43NeCBBb+QYZMoXk7CNMadO05SS4QgjuKj?=
 =?us-ascii?Q?4qY78S68sbZUbKiV+5fkKFHcRl2PwHF2D5+VSDffQGmRcHIE9HhflTXolbzQ?=
 =?us-ascii?Q?XcdoQE0plAdAYUld4voa3/b6J66JGzh+G78c09ThPbl1u4K29P4v6Q02ri5y?=
 =?us-ascii?Q?0DSL3AjJy0l5VVsEZMTWcUl7l6yFK8DQXXQMmIXPM+RX3umF8EnZYmafQWFZ?=
 =?us-ascii?Q?9TLFuZc2CCzk1CymEcMKCVxtM0UflQj5msTjq2kFRmRn8a58utBX9cS9HRsp?=
 =?us-ascii?Q?y1GZf0jaOtwzmO0PioBd+IT6rcU8xosvvFZfTiw2wEN73EoLQYjo/VJp9dlz?=
 =?us-ascii?Q?vK6x+GLM/z9KoMFWzhN5pL1JZh3D3BTMUr9apav+KxsIcGQCvukQYSp1BR2O?=
 =?us-ascii?Q?74ty4FziBUF6ygyuadEYeb5ClIqLQcGocfEmhi+yILOA+R4Qq/2KbVr9yh3g?=
 =?us-ascii?Q?c/YPKYXWgU3JyCaAFjtK8ZBazkUuFxbjDW1S1o0ns05BbdUtPyH6K/VLDwrB?=
 =?us-ascii?Q?xqT7lV7eASc9EmxfFjdCn2h2lxF4AtBElXttiftUjKPGXaanU7Cx74id8h5h?=
 =?us-ascii?Q?LUPFmErSdnv0b+khV5UGNclzfwinGTBhxereAMlUnwm83GSVmbb6A2w6j38Z?=
 =?us-ascii?Q?bPxeeuxLRNvREeAnfKKQJyYM4K9DXRBOdqEpqLvlsvOcjHO57E0YgO/aEwFE?=
 =?us-ascii?Q?iaVxjmM9CxhOt8wm5ybzpV67URASBj5gIW9duwR2jI3Swp1AbYK/7euVyouZ?=
 =?us-ascii?Q?oLmKKC5gRBACCFLNVx1Z4CgwHkxpEJeuGHDW7Fb/3TGnr6fMYrSwdVa6wfOE?=
 =?us-ascii?Q?LuBud1iJjwXs0YOlkk8qtVYugDURK4pKewlRlgYAfVYEB8Pnj4oLjy4DunqV?=
 =?us-ascii?Q?sA47HlSgAsTPUhGevBLRaFxo8e4BS0yOHmoQOCHGasZZs6brbhaT2NoAgIAH?=
 =?us-ascii?Q?9lrYO7F0u6OQ3tNy4XnVcImnZurxkgZ5D90xUn8T2gICsc9TGUu1zwVyLDR3?=
 =?us-ascii?Q?LGS5OYQX3FgqPJi485KipmnMUwa5h1Ixlw/jo6HekHUVJyxdRA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yyg+PTAb3YHORXtckXULcJceGPtS+lnFRXR5YJlTNdLi9ibru3Qi1xJg+sVm?=
 =?us-ascii?Q?QJHPvkWCf4Ooib14ksvunsS9W/GdcKI87+OV4joHUnuGipmWZOSwb98jKau7?=
 =?us-ascii?Q?4jCSrVKpy2HZvPFiXyz62rQKC1j8E98k83NFoJJwAAnWVdEZTQMPKfVqEV1N?=
 =?us-ascii?Q?Aw4kgUthi+GterP+fWx8ppnJmoE+a3ZVZ7Op00rZr5HVb0K4SORHZ702GTxM?=
 =?us-ascii?Q?s0wkgMCtRmd708nzjxPIHdk/1xoQQJZei5htJl3K1PzVtsIiGCudOKvXf7VO?=
 =?us-ascii?Q?ZvHRMkEuPrbmVwqIsnI8x5LUecz7x7vjrkcg8i0k/0GYj0kB3ibxuAp36b+b?=
 =?us-ascii?Q?3dDxGYLBKZU2ufvA9MzhRkHgUY/qqW4I25N/P6G4k/kKrbbb0biE9H/nPIv1?=
 =?us-ascii?Q?CaPhXfV2MrCu8hJiYXBQOGwslSaCMOswqSkAgxDMWKGS34bUlnfEhDr+YBMj?=
 =?us-ascii?Q?83JZXnWjtJasUQmqTTMfLNZkVHvZusexhHLglHOcbpS1yVchXdZ7RDah+083?=
 =?us-ascii?Q?KHkJ7WfGTFabpeoCQK/PdOz6r9UK7ZAFerw2kSFPW/T1nJpoegJ/3OVUK4dh?=
 =?us-ascii?Q?ZweXa231vi5O2mwIPJtsQDfJcTejIttFF+qTV3Z6ANOLTEdQIsRrJOyI/0iF?=
 =?us-ascii?Q?cn6c50SD2Rc9Dst2Z4D4k/2YnDBpO7nz9hgg6Cz2hxdhd3ankizluNdZdoHP?=
 =?us-ascii?Q?l7GlPtaHcKEiFJDzB4TpuCtXmEbZ1Crlqw/jhOo9SKGxhryH1cGg17FvksG0?=
 =?us-ascii?Q?zQyCUuoGvhHZxy3SDb2hOg20fiEWOvpMnBe4FLajlI6erVZlamFOz1MDa2d4?=
 =?us-ascii?Q?SUtbP7nRw/w96YFzGVzlhChxMUUNJGjDyB60bbvSwjdbYztdv57VPoE/z/Ku?=
 =?us-ascii?Q?XsOB5NzythttHBD67dM+oKYUjIhIJGBR+WS+6T0bo3ijGCGXaw1vhof1W30w?=
 =?us-ascii?Q?AKHtsFtdT62Y1Z4ldluzAOWeOG5ZaaQw2yi1PjdD9Mr2mNHMflinZqbPPzFT?=
 =?us-ascii?Q?wE5CJbYtKkvCuWZgzi8RJyoWQOaA/PRNObZaR+33vIs4fcl/cUxiu+pjXVVD?=
 =?us-ascii?Q?3dOebYCUpUEqjla9CXYG7eMII+DoClOGOAoLrBa6q5+TcdvOa4yydrBT5P/S?=
 =?us-ascii?Q?93OvIlhGzdVYK/rANN5TOTN3ba4mtjrXF6jbe8ifHh7zXQTP2fCUwuGQElfB?=
 =?us-ascii?Q?9efgp7cipRFrHr/b9xz8kWUuNBH2BRpQo+ldWFKetdbB01Ixu0U8ShCFIbUm?=
 =?us-ascii?Q?7giJLZotHZmgLaNPmIUdc0n6+EluEuSh/MXJmEDIivs5mang8UA1iRyEiPU+?=
 =?us-ascii?Q?uUj4KwR2AYHHQV3PY7ziRdoD/oTV3x3Ug4MM7gZgLcL8qccTwUISHqedBoDk?=
 =?us-ascii?Q?SC34z7Vctix8KUAFWgLcVcmCjcF8Y7CtFZ8XjyGYqDFWvxM2mTxMsVIB0UoM?=
 =?us-ascii?Q?ckzBdMdHJw64PVgOpE3uFPwW1KTkJ9amfEUkjgibMvAkQK9BDIbANd8wGYIA?=
 =?us-ascii?Q?L2fAobLtD2humHpKONfeJfPMMbL+D8tbKw53MXFE0fZgz6vjwNNJM6Ic9lvN?=
 =?us-ascii?Q?YbZKdttt+sKX5fyDiOK+3tddeLQ52Xp3HNBFj9wDvcptYVLHIummfJWIOwb+?=
 =?us-ascii?Q?iA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce39bb36-4c91-4a71-c5c9-08dcaaec95a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:53:47.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLdR56UZnYwj5PIfboq34hSLMmnJngceGy3+vpS8+AsryyEcWT45Hr6/1e2Z6ZHVsN3GzQ/U2nMWS7RFnbfLMVhTCgD7fj2oviFDAM+JI9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Friday, May 31, 2024 3:12 PM
> To: Zaki, Ahmed <ahmed.zaki@intel.com>
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Guo, Junfeng
> <junfeng.guo@intel.com>; netdev@vger.kernel.org; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 intel-
> wired-lan@lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 01/13] ice: add parser =
create
> and destroy skeleton
>=20
> On Mon, May 27, 2024 at 12:57:58PM -0600, Ahmed Zaki wrote:
> > From: Junfeng Guo <junfeng.guo@intel.com>
> >
> > Add new parser module which can parse a packet in binary and generate
> > information like ptype, protocol/offset pairs and flags which can be
> > later used to feed the FXP profile creation directly.
> >
> > Add skeleton of the create and destroy APIs:
> > ice_parser_create()
> > ice_parser_destroy()
> >
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> > Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> > Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c
> > b/drivers/net/ethernet/intel/ice/ice_parser.c
> > new file mode 100644
> > index 000000000000..b7865b6a0a9b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2024 Intel Corporation */
> > +
> > +#include "ice_common.h"
> > +
> > +/**
> > + * ice_parser_create - create a parser instance
> > + * @hw: pointer to the hardware structure
> > + *
> > + * Return a pointer to the allocated parser instance
>=20
> Hi Ahmed,
>=20
> A minor nit from my side.
>=20
> I think that in order to keep ./scripts/kernel-doc -none -Wall happy this=
 should be:
>=20
>  * Return: pointer to the allocated parser instance
>=20
> And perhaps it would be best to mention the error case too
>=20
>  * Return: pointer to the allocated parser instance, or an error pointer
>=20
>=20
> > + */
> > +struct ice_parser *ice_parser_create(struct ice_hw *hw) {
> > +	struct ice_parser *p;
> > +
> > +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > +	if (!p)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	p->hw =3D hw;
> > +	return p;
> > +}
>=20
> ...


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



