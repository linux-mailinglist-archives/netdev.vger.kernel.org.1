Return-Path: <netdev+bounces-98847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A949C8D2AE7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7DB23A21
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032015B0E0;
	Wed, 29 May 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpdGvvMe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD517E8F0;
	Wed, 29 May 2024 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950151; cv=fail; b=k1tZGU9QZ08e0ufTa5jeb3w4vVixrWqHyaXA5Dx5D+ljhxAKsB4d8ycC0ePPAz36jB7mI0JvYgd84L594cj9RpvHrvwiVihv+t3oQnZOehb1Ms6liMo4czZ4eAhF3lX//zqQo591wWvPnGcDIzeJcKIRukLjZPHjOBQGYsEIas4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950151; c=relaxed/simple;
	bh=k9OlccnNvMd3opQ7JxbRvoVp2r0kcKwtdUfEw5j1uek=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=q2V/PjOkH+OfhkKFgmHksPsP+ccei5R/B0cbMd7rK3zsTSBPAKWAU4qi4gKeUtlRMStl1De2jjdeMeQa9bNRo5ebClO3t3FwD+HQewVeHX/AfMC7kTVJN4pXcttCNGyan6O4/V5kvbbD6yEYQgwTOcc8/KAOiu9vpCdxJxqQcYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpdGvvMe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716950150; x=1748486150;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=k9OlccnNvMd3opQ7JxbRvoVp2r0kcKwtdUfEw5j1uek=;
  b=YpdGvvMevF8xrnOlM/R46yVXlqRqT+eTmV8iNVEWJ7qai213Rx148qZJ
   j70Aj5e3XJIi4I/IzIu0spi7jIUI16tW5Yd6Y+Sukv0rXQ/K/PFnXq/GP
   w3vqbqT26L8Lfiah54qSVzpfThxvrAjHFri5MJWrZeksX8xUQBWhvn5pH
   YlC3F/7X2SpaUCAkRc/duAMCFYI1sT1IEWsKgIbX7EItX3UyyBzjaC/dz
   Gqwm/FcVYZq1UgKucRHxKvocZZ7cv8Ag7MQPA9uSfuWc+N4SWVLQA/hTy
   BOjLWaKaLgThAn55TdkahCuvN0l5gkOE5QsYsIhsAtCELKvO2O33zsvhY
   A==;
X-CSE-ConnectionGUID: 1GvDKg8AT9WskF1mcbh7Mw==
X-CSE-MsgGUID: Lv3WJYNvTie2islyRJ+TkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16278471"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16278471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:35:49 -0700
X-CSE-ConnectionGUID: S9Kcs0tkReuGblmRG3Kj7Q==
X-CSE-MsgGUID: WP3UsrtnTmitFKZOgfOOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35362696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 19:35:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 19:35:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 19:35:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 19:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWzWtclLh7TsxTSTd+KSK6LO5iftpaKTYfVH3X64GF2LH7gFrhxCX/LEzNKocgskL0r6TfI1Qwp97AKMqIV4punUuIffDfgBbB337TpixkgPNZmuQetK106EI3OODcX4gzoHLoChS2jIf+s1X3s6QPTPBFCX30Ch6O1kaKxjCB2zTmcRy/3pEkM6t/KaA4RdleoxKfB5yOeO+ZTCqQqjIaMfP2/xe0PchOHP4yevJcHRjAmwcZqoJdAnNyWntXcAQSR4nzluIJ7tu2FkE0apXkO0IZSRNc1Lo1CdWXr6tXarltear3ZoEmcAFR5EeWsEfqnuerNWWcd/+YuiPdwMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk/HPuzJ8n6LrOGDYDm+8WBcQ5tyNrPqBWI/aMVEadQ=;
 b=JjR5E6Kly+TA8ry4HqUFJgjA/2+nAYplRPSfoq8YNSVDDV/MNIh53VKvj4vEnsAu6p8G8o+WB9LaxvVASm9XdjKg231OxWI7QYnoncqCvgT/BqW4JeWqc5yG2XqdtUuPlQOgpVQtC5b2qyssZtKQ5lxPuB+tyjMciBNAEvssdt3jBeULXv5o5u2pDXjzTQZ9E5ZWqM2IUMlcQgd84fursMiSxGlpjsYem2JEXP/BLcj+gStQRXrn1pRhJ/1nSPeqkhdB8yjuFg6y5h1COwgf1YhVrZ18Ix1c7vH3V27axZPCw85U37lHT6aYxZIBH+6J2VYwnpxrwpKAIThrGxiLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 02:35:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 02:35:43 +0000
Date: Wed, 29 May 2024 10:35:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Balazs Scheidler <bazsi77@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Balazs Scheidler
	<balazs.scheidler@axoflow.com>, Jason Xing <kerneljasonxing@gmail.com>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [net]  e9669a00bb:  aim9.udp_test.ops_per_sec 2.7%
 improvement
Message-ID: <202405291024.412dc03e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 42468a3b-5cb3-4d1a-93a5-08dc7f8809b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oZbGXwzAMAw6DWKpmCbXDxjieApYats3Y2Z96H/zUctvcLPgIYaUOAyiBN?=
 =?iso-8859-1?Q?GeLcU8AS64VrMs8c8CdZkmrQEUJ2oaeGH5EgngM+tW+vFh3ZPBv8bAMsep?=
 =?iso-8859-1?Q?f9xwO5S4tX14k451QVzsufuD/ZggHSV6qRT/GIXgDsE/WBQs0HKmRzcAOi?=
 =?iso-8859-1?Q?aXebhAww2Cy3PulFrdO2Mb0XLLGCMxeFndQPr+ZdwDWS0jV+THxtjKvY4K?=
 =?iso-8859-1?Q?vK0ld1C0G9pSKkRKWbD/kAinXAwKqgvIa7r+XRLWQX0o9G/fUSQnXtVHyE?=
 =?iso-8859-1?Q?jojOTCH5NvEZZ4kVXtyiYdr9orXyQfivwEJ/KfqXYestlE2Wcp6FsRYU8V?=
 =?iso-8859-1?Q?7LZqbfyVBS+o2reqnDPIWL6r2AWbru4cTWByYHC3296PFSG7yFVa7Uo0+T?=
 =?iso-8859-1?Q?JHXm2lZZiYv+V2iFN9AlPN6w4f41hlhu0wsFAx7g6kImXUvtCUmV7KmNE4?=
 =?iso-8859-1?Q?un9/Vlwy07ATLCJoPxpAqBkGZhYPG8kcPklBqH2+/DyWRUbvmYFRlxTfMa?=
 =?iso-8859-1?Q?blvJ+KoMkOoYjagujyKkMCIJKAxczavKFQMiqk7M3bfWUeFIvgUtClRaZm?=
 =?iso-8859-1?Q?YvSnH9nNNdPVhJTmOXlkZ/YcHP2yGcNmxFt/0f/BLilneVunm9O9wwCp9G?=
 =?iso-8859-1?Q?7dpNQGPahazonRb31nrJupHBNwkcTaVl2nEDt5VtjdPWfgad6mXGfBbyJ8?=
 =?iso-8859-1?Q?DCnmFYtQK8GcGfwIpob2eUDgI85PJah+nvqEMvnSQvJd1U15R6UmylTQQK?=
 =?iso-8859-1?Q?iVhmncKZNvzFLPu1YrBtpJc8QU2w0jLvFr73PO2Q+3yI5xnSMoHorxKGFS?=
 =?iso-8859-1?Q?sLyXB/3cNZbksQefdPtdDZiFX1paBp7HBhfOWqYSeM5e7Ee/lWFkjhxT+I?=
 =?iso-8859-1?Q?HFk1W1LUH0fLlRA9SBm/sty9k5y0CxNI72x6MkNqxQudN3yN0Jj01d6/0j?=
 =?iso-8859-1?Q?qj4Ma2UjBQ/LWfozEXz1y6NBKVDvbwT+1kJi/G3J3TUMNZaoUF3QCSH/7m?=
 =?iso-8859-1?Q?lxMVcYg9QzyBbvuG/ABsOpiNQf7kVy5a4MBJOgGTfpdcABj5Nslg47uYYa?=
 =?iso-8859-1?Q?9oKZRL47V3t4rWSmhYf81CiFasCW+7XEjYqSKWTpnYdg0DeL0v9bjkuSH6?=
 =?iso-8859-1?Q?gFMprya8bkXaYJ3/4ABLQ3NbwmkM11X13DQ0nX9kc8nmMFYMkVQKFw+5iK?=
 =?iso-8859-1?Q?bAaK3Co+4EdLDnn9M3Fq6FiOab4YQO9ESbQ1lkKAVI/Vz2HiSVTdxkIuzn?=
 =?iso-8859-1?Q?pt+Ki3tPlydz+RZglsVA5IvyqZp9QF8cR2LN3ItGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YWUIsDm+Om5ndjIirRoqRw0vrY+sVByz+frn0vRgjCqla8WSjuH86YN2lE?=
 =?iso-8859-1?Q?QvgPdKFnxC0Nv96lJPzn8K/SMikgDWfywYwaGndPNSjpl9iJLHGMJhZooh?=
 =?iso-8859-1?Q?Azte2tkHM4jqfNBTeUgxyyTIchUOEb7NsSuFY8WZA+Q2VEQLQX+ffbG8w8?=
 =?iso-8859-1?Q?ubkzlCpTArTV+zAZrKCiScugX4yxBUSn1EYoY+x56v2bpwvTdAnk0xFlva?=
 =?iso-8859-1?Q?9WrDZEZ+6TP/sCdLMdK0/xqXSf1TOAKKO1V69rpQQWXkmTM8qeqe8ADSuz?=
 =?iso-8859-1?Q?nG5VpdfY8GGitWD9QmWlEdibtMb8+RtR6U3yskMKfWFXeB8T3KM7NawHLy?=
 =?iso-8859-1?Q?vwrV536OxxGHi2+0iWwX3weDgcDT5Z81Kv4g1XXS7JKzjJawXKu6Y6i3T8?=
 =?iso-8859-1?Q?LmNM98/uezVxdCIBIfBSaDhWJE97JsbORmJ9YAqjvE/zFIUAxtxkmeff58?=
 =?iso-8859-1?Q?j/U8bjzRT7+EZFVjn8yvosBuF4y1dmeBpTxoCDMv8FGEYLLt75ZunkG1vC?=
 =?iso-8859-1?Q?J4eoLSDmBCGTSpPTSo2KoBUAPTFbTQyPdICBmhgFRVcmMBYXnQ8xcUWpRh?=
 =?iso-8859-1?Q?0GFopWnYAmZ06XKOqLPATK2/5M2KZU4mXlcPfTp/07dp8acpceoPQpzok0?=
 =?iso-8859-1?Q?1j4xdQ3OwJ15Gs48ovfmwA/AXlb5aAASD6OILKP75raIAkELp3/kmbl0Uu?=
 =?iso-8859-1?Q?vDQOvVDO8zYiPEpgd/qF51m4KFEG6h4y2rVRSmUOkLozTyMzVWO8qng+b6?=
 =?iso-8859-1?Q?ixU3Amz8V3Wy+Q2CBn3IwB4YQqbIUz9SDRA1B+QNfKRKh2VzJ7lUH/7kdE?=
 =?iso-8859-1?Q?gAxe26TQ3H0j4OA/mGM/JmEak/HJYb+ds0ZNJehHPhp178XavRqYmmXxs7?=
 =?iso-8859-1?Q?wEvZM04OOhKVntq3cONDn/yqU2yMEwLGHNYLJOwMvPYWtrsGAyJ5YhYZ9Q?=
 =?iso-8859-1?Q?ovOoA4a7BDkK8jyRXKJLSokYu0YwKCVG+sRenUpdxoEcNvOgGpT7GWphFO?=
 =?iso-8859-1?Q?7V04AnZI1m+uJzPuG+17G6s/dfodiMbsll9qyHrT19ZB1+BIMW2y2XhF1o?=
 =?iso-8859-1?Q?SkOIqfBuQ6XbFYGFGu0Bn1wweDxzZ4LHF+no6UfEdJaN5vjYV07hiDkzXX?=
 =?iso-8859-1?Q?miR6lqDmmwoUA3DASV2T4UwwIr6s7SQpV82xhFsdnGlLQ9rRml0X36QYL7?=
 =?iso-8859-1?Q?HkfRN6nq42QgxlT+UIvI64//P4B7BSvmxxLX5h3L/KPRfT1NDMMjL2P+Wv?=
 =?iso-8859-1?Q?on/IpbhsKsQhLso5poftsBUZwwvLr5ICd/TYYF/trOrPyCFuBvA3lliKuN?=
 =?iso-8859-1?Q?t6x8AbECc5jlx9fAWd4VTjbL0NGScBo/yTFSOQhCXpr5khwhzw5gb1pEfB?=
 =?iso-8859-1?Q?w512SdnixhB/YlKK7aEesSvn7pNsBUpVOh+s8pB6yK8OKCvahMmXKDXDM0?=
 =?iso-8859-1?Q?nLZVYKDumqqw9Z/+vrQi9zONjd954PDJUJl9XcOfnNIWHO8p7+64svmA5c?=
 =?iso-8859-1?Q?4fPKl0snwFNSnxazKWp9pBDeUmIlQebE+TIIt6F5IFC/jus6NEf+0gaCdX?=
 =?iso-8859-1?Q?8HsoHGhG0P/r8q45+2I399Jx69O1gGsPFfLtem4Ps5QjNItWeLTUj+gLOI?=
 =?iso-8859-1?Q?aoo4UswVGRY8a6R1zkj3xQBJT0KcPzO8zFPQmCcbvLhYTSKDVViGWuJw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42468a3b-5cb3-4d1a-93a5-08dc7f8809b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:35:43.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLACUEt3TkMX36ytxYf548EIdrJd9UZBR/oQ0R3So5BOpQmaPAZf1XSUY+43OwinwstSON0F+oJWKwU3VY/ZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.7% improvement of aim9.udp_test.ops_per_sec on:


commit: e9669a00bba79442dd4862c57761333d6a020c24 ("net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	testtime: 300s
	test: udp_test
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240529/202405291024.412dc03e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/udp_test/aim9/300s

commit: 
  a0ad11fc26 ("net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent")
  e9669a00bb ("net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb")

a0ad11fc2632903e e9669a00bba79442dd4862c5776 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    294621            +2.7%     302449        aim9.udp_test.ops_per_sec
     20613            +1.7%      20955        proc-vmstat.nr_slab_reclaimable
 5.444e+08            +2.1%  5.558e+08        perf-stat.i.branch-instructions
   8460968 ±  2%      +4.8%    8867626        perf-stat.i.cache-references
      1.58            -2.3%       1.54        perf-stat.i.cpi
     66.45            +4.0%      69.07        perf-stat.i.cpu-migrations
      4858 ±  5%      -7.6%       4487 ±  3%  perf-stat.i.cycles-between-cache-misses
 2.846e+09            +2.1%  2.906e+09        perf-stat.i.instructions
      0.65            +2.2%       0.67        perf-stat.i.ipc
      1.48            -1.9%       1.45        perf-stat.overall.cpi
      3684 ±  3%      -5.1%       3495 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.68            +1.9%       0.69        perf-stat.overall.ipc
 5.428e+08            +2.1%  5.541e+08        perf-stat.ps.branch-instructions
   8432000 ±  2%      +4.8%    8837232        perf-stat.ps.cache-references
     66.22            +4.0%      68.84        perf-stat.ps.cpu-migrations
 2.837e+09            +2.1%  2.897e+09        perf-stat.ps.instructions
 8.552e+11            +2.0%  8.726e+11        perf-stat.total.instructions
     21.69            -0.7       21.03        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.32            -0.7       21.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     22.29            -0.7       21.63        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     21.21            -0.6       20.60        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     19.97            -0.5       19.47        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.87            -0.5       26.38        perf-profile.calltrace.cycles-pp.write
     18.78            -0.4       18.32        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      1.54 ±  4%      -0.3        1.24 ±  4%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      1.67 ±  4%      -0.3        1.40 ±  3%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      0.92 ±  6%      -0.1        0.83 ±  5%  perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_write_iter.vfs_write
      3.21            +0.1        3.32 ±  2%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      0.76 ±  6%      +0.1        0.88 ±  5%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.92 ±  5%      +0.1        1.05 ±  4%  perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter
      2.76            +0.1        2.89 ±  2%  perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      0.43 ± 50%      +0.2        0.58 ±  6%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      5.96            +0.2        6.21        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      4.81            +0.3        5.07 ±  2%  perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.93            +0.3        5.20        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
      6.92            +0.3        7.19        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      6.27            +0.3        6.55 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read._IO_padn
      6.81            +0.3        7.10        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      5.80            +0.3        6.12 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.53            +0.3        5.86        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      5.44            +0.3        5.77        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     11.02            +0.4       11.45        perf-profile.calltrace.cycles-pp.read._IO_padn
     11.08            +0.4       11.53        perf-profile.calltrace.cycles-pp._IO_padn
     21.71            -0.7       21.04        perf-profile.children.cycles-pp.ksys_write
     21.23            -0.6       20.62        perf-profile.children.cycles-pp.vfs_write
     19.98            -0.5       19.47        perf-profile.children.cycles-pp.sock_write_iter
     18.81            -0.4       18.37        perf-profile.children.cycles-pp.udp_sendmsg
      1.57 ±  4%      -0.3        1.28 ±  4%  perf-profile.children.cycles-pp.loopback_xmit
      1.67 ±  4%      -0.3        1.40 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.60 ± 10%      -0.1        0.47 ± 10%  perf-profile.children.cycles-pp.__netif_rx
      0.56 ±  9%      -0.1        0.45 ± 10%  perf-profile.children.cycles-pp.netif_rx_internal
      0.49 ± 10%      -0.1        0.39 ±  8%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.35 ±  7%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.sock_wfree
      0.37 ± 11%      -0.1        0.28 ±  9%  perf-profile.children.cycles-pp.ip_setup_cork
      0.17 ± 27%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.__errno_location
      0.12 ± 17%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.__errno_location@plt
      0.16 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 18%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.30 ±  9%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.ip_rcv_core
      0.95 ±  5%      +0.1        1.06 ±  4%  perf-profile.children.cycles-pp.__skb_recv_udp
      0.77 ±  6%      +0.1        0.90 ±  5%  perf-profile.children.cycles-pp.ip_rcv
      2.79            +0.1        2.93 ±  2%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      6.02            +0.2        6.26        perf-profile.children.cycles-pp.net_rx_action
      4.82            +0.3        5.08 ±  2%  perf-profile.children.cycles-pp.sock_read_iter
      4.94            +0.3        5.21        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      6.93            +0.3        7.20        perf-profile.children.cycles-pp.do_softirq
      6.36            +0.3        6.63        perf-profile.children.cycles-pp.ksys_read
      5.87            +0.3        6.19 ±  2%  perf-profile.children.cycles-pp.vfs_read
      5.46            +0.3        5.78        perf-profile.children.cycles-pp.process_backlog
      5.56            +0.3        5.88        perf-profile.children.cycles-pp.__napi_poll
      8.55 ±  2%      +0.4        8.93 ±  2%  perf-profile.children.cycles-pp.__do_softirq
     11.27            +0.4       11.70        perf-profile.children.cycles-pp.read
     11.08            +0.4       11.53        perf-profile.children.cycles-pp._IO_padn
      0.32 ±  8%      -0.1        0.25 ±  9%  perf-profile.self.cycles-pp.sock_wfree
      0.22 ± 13%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.ip_setup_cork
      0.16 ± 18%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.__ip_local_out
      0.41 ±  6%      -0.1        0.36 ±  7%  perf-profile.self.cycles-pp.net_rx_action
      0.11 ± 17%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__errno_location@plt
      0.15 ± 10%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.04 ± 67%      +0.0        0.08 ± 23%  perf-profile.self.cycles-pp.udp_queue_rcv_skb
      0.20 ±  7%      +0.0        0.25 ± 11%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.09 ± 18%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.06 ± 19%      +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.14 ± 11%      +0.1        0.20 ± 14%  perf-profile.self.cycles-pp.ip_generic_getfrag
      0.13 ± 19%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.inet_recvmsg
      0.27 ±  9%      +0.1        0.35 ±  8%  perf-profile.self.cycles-pp.__udp4_lib_rcv




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


