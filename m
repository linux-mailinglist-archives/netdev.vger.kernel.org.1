Return-Path: <netdev+bounces-124918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EF96B61D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785D31C2472F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9251CC892;
	Wed,  4 Sep 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aS2kk17Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0919D09A
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441005; cv=fail; b=KBJjonKkujfM0mFDxnhz72cM+2CJ7of9nIfCL3C1EySaDi+l+51SEXTrmRzJLJ7JAL7wVdHisR/ygggzBviwG/wMWD2YThWQi6ClgGVOcGgHu2KRlhmi4q09T2WG5OyaOuhsMOo64oxHzYdoqaaAcL7ZhV+LXGaXLXE4Lbs7VGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441005; c=relaxed/simple;
	bh=QPrUDBh7TCYs/xmc9eQAjwa5CTqYC/e0C2wg/KfmQM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uf3IlUxnJaEGKFO0bzEYWCnHzYXpjYgVXm1bmo0uyZCZi1dBNQHvEoqgtzvfzb0tWvJycDd7cnaRjkIrwXKMSloYpyY7sckT7lk3aH7xg6z0XJ6PPGHXScUK7AmXlhT41h2BfPs8hHC3HsOWtZ4WKP/2AfHaUOsRctkHsK7X3OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aS2kk17Y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441004; x=1756977004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QPrUDBh7TCYs/xmc9eQAjwa5CTqYC/e0C2wg/KfmQM8=;
  b=aS2kk17YF4f7ObvbIx0ebqJnrQt8ui0crKbyf8wzk5xPtl1eS4k52e50
   i8XjXLMkzdriLdcKZlXLm8aImv40yv0X5zrfgJqqBw5+ZyFBbgJeSj4YG
   1xGi8w7oVa3XHGB73q8W+P2nl79+8EIxpqt0dDudhl281vIv/Y5iKNvRj
   vj4Ji7IemSBzYhtUOiqtzywP6Bp3NWjKvwuk86rGWiYEhijjZcbMVqRZj
   8f5BwfgKdwX1e2cVUUbhB/KU2G0VBxn7BvXYwYLTKRu4cGC6SKR6ma7cJ
   LIguDSZejj52nu5aDdG2c6SnFMQ5s7VK6b/CgNXYN2RBm+EhnDkfX/ZbY
   A==;
X-CSE-ConnectionGUID: T1PeNwzTRyKJ/QO4r16Y9A==
X-CSE-MsgGUID: hEsDBys0TN2ML0OoYkWiyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35246344"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35246344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:09:37 -0700
X-CSE-ConnectionGUID: s1pv9g0pSYWT/m8/ctM/sw==
X-CSE-MsgGUID: oK85Dau0ToC7LuBVIICunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96002338"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:09:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:09:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:31 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:29 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:29 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 5/5] ice: Drop auxbus use
 for PTP to finalize ice_adapter move
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 5/5] ice: Drop auxbus use
 for PTP to finalize ice_adapter move
Thread-Index: AQHa88vazVJsJVgtSUeWysN1EEUWjbJHRhKg
Date: Wed, 4 Sep 2024 09:09:29 +0000
Message-ID: <CYYPR11MB842975E60F86BF2E1A5F78B2BD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
 <20240821130957.55043-6-sergey.temerkhanov@intel.com>
In-Reply-To: <20240821130957.55043-6-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 839e40af-aa6d-42d7-2b1f-08dcccc1488d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aqJc7P+50dT16uZ702CjdD+sgOKhJssurcJ4GTgCgjPIwKjtnjkihvr4WQ74?=
 =?us-ascii?Q?I69loXG7P7J0+7fFG40XSOPSMbAiN8kI1bePWqySdYFM/4POI3NBj+gre4Ff?=
 =?us-ascii?Q?o4QHskb4QaNwVimqWEE9UvoU7RVAh22FR2hSN0xKRfpRCwTrCxaEv4PwYqty?=
 =?us-ascii?Q?DY+WWixNvCRH9AUO7uf/ApHLw/wOwRuF08tXwZi0UCv1g534ATsOBxLM9YeV?=
 =?us-ascii?Q?uvNHw/kV79dZ/pMLy2OYT7fr5z+qUuRSK9sQzNSK2DyIZVCzloRVcer0TTNz?=
 =?us-ascii?Q?FhVYJz/p7g2A3NZW9JgAguvpqGRVS0kdTWKFjGc4EbAPm9aiN9BsSgwjOnPX?=
 =?us-ascii?Q?wi69xtrGCoT5ztSdjJFscxH4ePvVP0yrSageZmfErVe4fKxgXCORfIdT9OVQ?=
 =?us-ascii?Q?fm3z6INxSZb5QF/C+fUhTGJ75tVw08d/MUhYOM15htxYEqFoKOoR1JkwVzHr?=
 =?us-ascii?Q?2spqtccf/TvDbuNB0wG625Dl2cie0O6G8oPTqcjfhecgB3NGZvIvT+fqVxFX?=
 =?us-ascii?Q?6ticMzFIHebFQKOxFWQ0YSTyVGtgm1fVp/uM1QHA3+nPFhm6WL1CDfQkfES5?=
 =?us-ascii?Q?RuGtWJT5Ck1ZPC+siz1ZYNyk67LEAPdH6LvEN9htDCNMdaSWCnTkbR77aMVm?=
 =?us-ascii?Q?PCuK1jb/GFq9DRX+Q5SU+3jDg53hC90oFSC/2xvJxp1Pfo3NlZ2r+oz45KHf?=
 =?us-ascii?Q?wyB1asvzwDuiV2DUT7Jn3Y24FDJKmIGxe1xF+SldNSjP5UwJzOiMNuVMJw6I?=
 =?us-ascii?Q?rlqmhZtQbLQw5L2TM6xwgsJTDIiBRl17PcGQLPImafyU+NsnJhICLiKBA91S?=
 =?us-ascii?Q?NEObuojanJhQPKAAR6LTLXKNTDL3cmYVTudLUHZh9T3u4DjZU6kDruxFrjLO?=
 =?us-ascii?Q?u16guwW4FsHNbXEWZOi5j8vLP0SiyEoQJOsYj2+X/ll4yWll6FZ8bDXJKUzv?=
 =?us-ascii?Q?Td1+N4bpcq7eQ6W2QldERBBfVX7Nx77XWTkHhXG48KHIBRr+5jdxkEw4JsQR?=
 =?us-ascii?Q?o2olamFSOH4x5U2sCZoNIPFp0W2izwE2JE1fUFWDe3L6ERty+LbtdgPhh2aB?=
 =?us-ascii?Q?eD68sLoauWhKT19A9dgDGC4cjYtCK7qil+Z7DII8ryLXpHDytT7/IVpKn8d8?=
 =?us-ascii?Q?BSlM1iHKhZ18z48YOZxCMeZz2esG7CcQqKWG9o4/2tRDPkcDWZJ5kJTV2De8?=
 =?us-ascii?Q?t+k30p6OXOf8qX3mWb7aa3yJu3eGjnjBmARm8LPWGED2XyJM4v7FXJQDo/0u?=
 =?us-ascii?Q?unWwEaFYw7sNMcn9MKWESrKn63i53wkTIxQEpyrqCknYSgVXFVJCPQcbxmV4?=
 =?us-ascii?Q?iX2gMl2MVCq8FdrTajxTBCNO2Ehd1ZiqWklZNtDprm52VYZLmti6s2K6Uxyf?=
 =?us-ascii?Q?q2w6WfOXn04QhNcGd66UsniVcNUJ1s9vi7lfs2aWduwEJP/4KQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wq8REpWaCGapJNhChLk4gKjGkxS9AxsBxMt49f0qvTn4xO7s4fM8HGiU+nWa?=
 =?us-ascii?Q?TKpR8MQi+vEkPt7sxkEUFzESYdNLE+ukf7l/NFjd/h6SJoHGiV3s+CSvpXL6?=
 =?us-ascii?Q?zla8zoml92o+bSQ/bTc2SB6Qy+IlCdbLGNNLx1XZf9VS80QnsasBDEaM5WJx?=
 =?us-ascii?Q?+Kkau7kCsBe4Y8M9pDXojf+JIKRp/g846KcJrj63CU3G/ppRJZxzZD8gTtA9?=
 =?us-ascii?Q?TuodApo8xuv3AIDZpIyKlXmcWTgi9nVn9MVIRFA2Ao+ADTwyh5xFKCzHbhaO?=
 =?us-ascii?Q?Gmv6f4xWHxqHFPMvwDnvzL4emd105UB4pNLvviUZnUoLaoBBeTyN3s/baAez?=
 =?us-ascii?Q?hBRLRCR2VSkVzRTD0NGYjEXgwWWpq4kO4WwjpBTCepx2QvPFK7wD4KoD8zJs?=
 =?us-ascii?Q?R+s3H6oHrOtofpde6+yoGbYSSoMQ9n4QuwH66NX6v77DFo0sLMPG7CFldnfn?=
 =?us-ascii?Q?dTSwgfWqczLb5ZPxC+MRK9UAobV/sk2dNHZWk+lrU3GEA7CkEyhzdw+dbFUW?=
 =?us-ascii?Q?PYDJTI1OcYmTtktf4E1oKvRgGN3y6sCqStlk2VOJsuWjyc2fPEsLudOtFln/?=
 =?us-ascii?Q?dbvjAkus49aLBabOBGsMIXFEj91/R+XrKRwwlR22NaFK+jaWGAc/xfOIxg7R?=
 =?us-ascii?Q?dCZWRb5zhzK1knsGPCO+eUXPBQMGS1CwbpGaQsgDCtbvuKjB7gBkrLI51wg+?=
 =?us-ascii?Q?GN00KHNoW7uoUiZ1KnnhrpcfD0ZXpntA8XkO+lmFJLxe49hpcIIBLLG2YD+C?=
 =?us-ascii?Q?QX5W/ZfQ6ubzeedxnZLE5AqkHLsPrtRLGJODgR9WgT8DOjETHKWuYSxeh/Sc?=
 =?us-ascii?Q?ww+cJo2qAEVG0FVQS+gT2YJYPCEo5bWS2/uWKP9VvD1w1xREAl1AFk/NBSfY?=
 =?us-ascii?Q?pzoadRdL7MJI7jp/oFDieQA0t1+pdoZSEGznMdrf75q0YCPldLJo2lpb3UZQ?=
 =?us-ascii?Q?INmw8sGkhlcpBy986tckFgVsZzHZvmC8NguMacDlv48b1Xg9uLzw11XmLXzx?=
 =?us-ascii?Q?Cul2azPG5E3wosp+7Ejmc0NB12FS3BM9nnFQoAVfld6Sj/Mivt0YZkGpNjnL?=
 =?us-ascii?Q?aYoa8htzYlGa0uc00JFxtg6dCM1PrFUSoLaqshD64c2e5cICbAz5B6O/0pS2?=
 =?us-ascii?Q?sM/NAyMljNovT2EHoMvsMOHLPoDefTVd+TFxB9Wv+Y1n/LqEYKNb9PJnYya9?=
 =?us-ascii?Q?j03h6MwBYblvLMFM1UhMlZby0OPwvr7l4e0/sApSmohrKMlFv9zRDS205ur0?=
 =?us-ascii?Q?X6TbNq0G3g2yFchpqpcb/khuygN9Yqr6qVjmh2O4Rit5FtRlPIAidrQd8iRW?=
 =?us-ascii?Q?zkSk2CixMehBmc2qcdQvJOV9gC7mmgTQ4FaSKUAbV4XPPXdB6hA7ahOlD1Bb?=
 =?us-ascii?Q?SAbnpAFNlP7mcBRqdMQ6moMBIbxrHlhM9/OrSoY9yj44p6Ru9jytoFsBoOun?=
 =?us-ascii?Q?tRVhktN3mCeaYVHz96NDHrccpTxl9DY6ln7wgUXGkPhPCNmyajbpe5DvtWjk?=
 =?us-ascii?Q?QG1MiOwmyBMF6g6IzpaZiMU9lgqY2dWQf2XsndE5n1wvK7T+NOAW4rpRAlcO?=
 =?us-ascii?Q?CkRruHd8JdzROGsQ1uOICmxm8i9/3UjmQ4A1/eiCLqC+X5X40GugwkFnmhrt?=
 =?us-ascii?Q?5g=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ3dUBlyLYhGC+oX9tln+W5y0FhCl4t3wuHt6TH3/u6i8abDgS2rfin6VNQKyb/pQ1Nu1e5ix3SOVU0yuy8/Ma0c96vOqekA9FrDx34OSJbuXTaNue+Ama8Pi2k1HgKVfRZy+rFto9sWwB3deUjECggRlGDT8CuJLU6c/OVHG+Kax7fL2Y+ze6aPsFnFKy93aRH+zWPc3eQtyL/UEOEcMCl0Q6zCFfL3Hxst7mtPKoaq9f5isQKDZU/qHcnK/Df/df4Pen7axZ4ZOd3JQDXyKwbgKtzXCTB2zJFnj59zgeQXU31L82yY64JJigdC1+V+7pH97tsk4sAvuL3vU6Xd1g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI5yer5MI+MoLmF67c3ET0u6XROZa6WTVhLYkJ/EzhE=;
 b=nX89AjoRuV7nTo8QDn7fwDxr0vHoz6mBhY9EDtBY0hYYVWZDmUgOm4CuDQttRUzuuyuk75quNAlVZPbDrcJ+Xjyw/Gv9e4OAFS+J93pQQSmsmGwFSWwwmO0AZ9vkqSgYCJCrgXsKCT1TDkTbdL0Os74JJ9BGefpC5EKFT2Q0zLFU1QFjlZVtj0JQPUWrE5bVCxKIzp3Mnh/X/D0uEhTZJxbvnFwoRT07px9EVg3Xd6EOkg0K7v3dgiuuGvjJQtqXibHo0baCXv1jJY2b82cvhZMvyqoPvUsK4QVN9KuNvZEr+X8iHJ7+Q1fgYUVJQYCVNyanpzFworpFHsUnyc1Myw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 839e40af-aa6d-42d7-2b1f-08dcccc1488d
x-ms-exchange-crosstenant-originalarrivaltime: 04 Sep 2024 09:09:29.7200 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BWTBvC2gc98fjtPgUx1AzbEWvFByXwpzkZvhjlQY0OJnbz90SJ0Sn/lPyENg/0+bImVkJcCu48BUpvR9XtVQzP/2KnqcvYii68W4Iwz/1QSqMQqKpi5s7HV6o8eWJjwZ
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB5830
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Wednesday, August 21, 2024 6:40 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Simon Horman <horms@kernel.org>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 5/5] ice: Drop auxbus use f=
or PTP to finalize ice_adapter move
>
> Drop unused auxbus/auxdev support from the PTP code due to move to the ic=
e_adapter.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 252 -----------------------  =
drivers/net/ethernet/intel/ice/ice_ptp.h |  21 --
>  2 files changed, 273 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



