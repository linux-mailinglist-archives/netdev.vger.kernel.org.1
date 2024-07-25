Return-Path: <netdev+bounces-112904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0A93BBB7
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E4B1F223B2
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354A14A82;
	Thu, 25 Jul 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvWkQ8Qq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D6EAC0;
	Thu, 25 Jul 2024 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881554; cv=fail; b=A1dcOB32U8x8UzrWC7zB72iRzTLt+kR0F9fK2xcK1pnQTlUCg1dunf2/qv5wsWQrpT727cWLbPGkOgI+RmcNSCuBvvMqv+Pjmw1fgwsuUU7XwKwSkcqkFRhHYWBLbh9MfO9m7ob/7ZxdGccgc8uGfQw2oTEACmH51+jmuJg3lgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881554; c=relaxed/simple;
	bh=I7hP6wY6GKYYbJLRq21/T2VS1rTD11B2Xjt8dnHvC4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkrXaT2anDYmBTULkGcMUDt+bcIAOJFhAcsobisE/mR5OMZruPlP8LTtOaArSvtrQzE988OzpMeXLrAyqUBIOxmgMqpa6yUNDTYePMFh1GhydPx67ElLthK73IMW8YrRZYZivXExAFVwG1UUHMERHv1aP5JMPTcFebHdrboFNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvWkQ8Qq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721881552; x=1753417552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I7hP6wY6GKYYbJLRq21/T2VS1rTD11B2Xjt8dnHvC4g=;
  b=JvWkQ8QqkglkUTKqfV8HMwj3kxqhDFZMycrC/g0EZpoWC4B1BVgOX107
   98vtveowPlbvI4F8EAGRRyRplS/LuMExnh3H81Tud7x82eyMRJV0cX7sR
   Dl/BBr8xc7G3+xkz1MUh4UlhOmkNeW4bds5fqlZaoGSM2WYU16ZgNjIzU
   6/IInYyGCj3xwzPJnSb9XoYoDj/6uHI/eLyokiUIbgsRW2AlldpghmNAL
   pfTJSyklrKTqrYkic8fL3JBqoint4B6aw1Wy3n9JjeIu0cj40zBphjNh5
   V+F0aegITJDaz1tUrSDkGXWuUb19WFUaNdIMMKBxFk2sBBnoaXtDt8Cuh
   g==;
X-CSE-ConnectionGUID: rWwyZGH3SXGg+FNiqsJkyw==
X-CSE-MsgGUID: gg2fEH/DQmK4/DxR2Xolsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19289446"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="19289446"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 21:25:51 -0700
X-CSE-ConnectionGUID: paH1jujwSR+d68Ud/9AL5g==
X-CSE-MsgGUID: 4xAtO7bES0m4RL2wYS2dVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="57590887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 21:25:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:25:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:25:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 21:25:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 21:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUAwSNeGt+4gRHf/sTNYhv+/WJp2E/j2lQ+IZKBypdqOkAJv5RPqXNoWtQiS+yCDhV/bcrJavIDRUwzD6ITJJFiB7Y2vGhAVYHBC2A5/caHBm6NdSUCBJwIzajiZaimkqQQjsonCg+/LzkituNdyrGb4kEjB/cHgOIZOf8wKXbNW6QlT98FrPc/3P+NIoEE/q1bhLBm8MnzvSP8bevrE3YuCxSJ26OI78aFQhXkoz6RUGSIEqPtPOcouyAMkYZwRsL7EfilfsGyP13jEOBY4+4P8QmzGFqhYUiIsH1+lyYrzhiDfRg2WKjRVqHeSit0yTI54+K/7rPRFWsGzPyxZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckQRw2jinkF+uWihK7mqquI0kUOB0xkwsEr5NUrRDac=;
 b=NsTh6wJpwBfz+t+LQSUDMBiitGAEy9VgCZlUSKbtLsGfmvWksi7gcljJuMphIGzyNtrZ1p2utHgMu0e8X6O72wXIhR4OTEgrlt5GTVt3QS1bZe070vQNchw81FQ8gc+b4UY2BNeoKSWuoDluSpftfkJqlHYjmfy/S3O/cj2wbULRqlWmHD85ZHckcU3hYsM1tWrUJu2H5dFpobY5JvidPeHvpDuRChel7IM8wX6Ln4EBT0SylprwxxbA8sC1r7pQytEFneFNFQLPKjhZI6ZqXOry7NZm89TDfr7VcBJVmcKDms0Ujz46iom6kulfAvBgSStWYpzQu9sprKxQT49RMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 04:25:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 04:25:42 +0000
Date: Wed, 24 Jul 2024 23:25:38 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<gregkh@linuxfoundation.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<mcgrof@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<woojung.huh@microchip.com>
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <v6uovbn7ld3vlym65twtcvximgudddgvvhsh6heicbprcs5ii3@nernzyc5vu3i>
References: <20240724145458.440023-1-jtornosm@redhat.com>
 <20240724161020.442958-1-jtornosm@redhat.com>
 <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <8a267e73-1acc-480f-a9b3-6c4517ba317a@lunn.ch>
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0e2fb3-4ede-4a52-8cbe-08dcac61d842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5sOKwvR7+YRVr3Lw9iH6fR/Kaf+g2n2JI0+AJ3SMlXCtHV6dhMVWk03GL6+Y?=
 =?us-ascii?Q?JXp4icZT9fJ/c0mA8KpVxvrxLG5qtVp3aspHRT0F1V6EJHO5FRJlGhrgPwSk?=
 =?us-ascii?Q?cdkyRO0dYyGL+ZbQ61lfEQ31Zrx5nRRTVfPwEe96xdUgn4pqOKO/Z+brhqcp?=
 =?us-ascii?Q?qFpAGAYi2IwH4p4PKmH2omGkiZk+Oc6vohfAmqcylhyypuikVgH1DnFw43cY?=
 =?us-ascii?Q?2h7ym+r02sze+0LuC4xwVjEC2zDSt5qTCdSmPORKkD/w+XxBcpB+e9jnNgYj?=
 =?us-ascii?Q?Dv0n/M1iWjj6DoFgChExcmWNp3W1PsMtliGMbK7H/iw/3C3WG1meNvyCPdBw?=
 =?us-ascii?Q?/JuRpJm5qPGTJG7h/hO4b6GKEUMvqvTnR3tIKgtKqG9NTgmg3eGdx1pMSL6S?=
 =?us-ascii?Q?SJCdiBSScyc0VCNMtesnkGucDIdNMZ7JrJkY516wfFjRY/Tt2DLsKPUFRiaM?=
 =?us-ascii?Q?qq4G8tzpogppSDmKELQ4SXKxC9Sq94+K0fp5bkpH4+0l/X40XdoF5/5JCTWg?=
 =?us-ascii?Q?m5vWZ1QwHAVqu7yP4XD3X147N4LDdfJgqW0g7LH6tbhKAuXxDKvutxiqi13g?=
 =?us-ascii?Q?74TqAWi/vRkOhKVp4y5HYkjSmE10p5MgPjMc1FaF2/bo+O1+ka/odUiBNbW3?=
 =?us-ascii?Q?/kQ3RoquGDhwMj207oCfMhwULEYQx9Ytj4h83t/k39WbTDO8r5wBgosr97Ue?=
 =?us-ascii?Q?RhZKBqQ4fhwm3qodjxaNuLO8zPF5MhdnHwWAVhEFulS+fwXJCRe2QbgLgDPs?=
 =?us-ascii?Q?fMOusOEjjquCioVkInBnbC2agaTzEU4srVqVSFBBuCE5vYBDOR3/0ZIOey0N?=
 =?us-ascii?Q?G8fLGYRN7wjBSrLvDRCVXT5z4ItRz0RN7EFwyureDSHviIHvArRSL5m3gkxC?=
 =?us-ascii?Q?3t6jIuvrCYA7yhJAv0gMXfgOQLoCJQ13IzjAD+HscWNZW/mzSFAauZYhVzuQ?=
 =?us-ascii?Q?zWhFvUi11J9oNJ12eKxDzY5pI+A2AqbaA5Vj6Jmcmclck5YtUwo7iwUOiHwW?=
 =?us-ascii?Q?oxbwiQhNy8ecdTfWz4vBGTTEhon9O6V3+hDD8FjlzSlmN16ObyF+qvACXnop?=
 =?us-ascii?Q?twO1U5T3EzAGJB8/s8q5HEKSJ+gHeyR2RSdRSMysPbjx+RLDi+/gzpbMM502?=
 =?us-ascii?Q?65bYjtWaBTLT2QrTMsJrAruiR+stDpJXYRV2tXBp34nuI0lYSiwc2frYFOH7?=
 =?us-ascii?Q?A8RKKkmiWroJ83kTwZQqojTNu69n7yjDwJ3M+dnhCTKSrCT6oChL7Bu78Mw7?=
 =?us-ascii?Q?BzW8x8MSUd7R8FQoyFeTPFo5WTCHEp60Xm3n6dAjLjAy/NiznWRyWbcdmJHc?=
 =?us-ascii?Q?UMkPTSDHpL14aVt2lDUK56C5Baz5APuAfxbRyYfIGhOiXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgfyvKlyTwu7Jr9UyELr89hmuul5R9yB4i6KkOT7TPufbquNinBbR22a8Css?=
 =?us-ascii?Q?fXdcvG+Ueynqx9KCQl6SJiUczl0f7m+G5i2jcl6yrSevzZUC4zZK+BpS/0NW?=
 =?us-ascii?Q?i864fRPmDFo3G0AgyNNyy09k0r9YiZlUCHj+kQmBFB5dGBbgQ19knMIC/BU+?=
 =?us-ascii?Q?mR+KfaSizqx2KFcPdcMEzp0xEl0ytJvYpy+i3Nq9J+U/UIGcnnQRR0KmoDdc?=
 =?us-ascii?Q?dqAVpGyoGQxGP/9ysfQdaozFxkoZkaKulgyKCFlEZxdWJBev33lXx0WOP/Zq?=
 =?us-ascii?Q?ssLsSfhGcptkOaJexbTEj7S2nCUBtTKAegq6Ibmil3TbBCgi2qgEHUA4+eVa?=
 =?us-ascii?Q?V4jS+oUcXC3FOV9Hd42tFMdoOWRWZGm3exUht4obpK2hyQnKiS+yU3A//nr9?=
 =?us-ascii?Q?mYyDWRTKvTS2D7qSIr8bSWWWgn6uKMR8sJoZATNVN9EawulZeoddv7anaAnu?=
 =?us-ascii?Q?OIxsA9lTnwqZSWZvN6+/GN2TjHXLKcp2FSyAIoUrrPxxl9EH3WsybiCmOANA?=
 =?us-ascii?Q?6zBY667ZCaiDN49g2RdXLQd3MSta0A9gCroTuXy3Dkh9dQ1dJmteYv+fKCjv?=
 =?us-ascii?Q?s9DFbA3/jGAY+dUH1WZNwe1Yh8fWPt5hBf6Ps8/uZ/reIHFtbg1LtI4QCZQK?=
 =?us-ascii?Q?w6x840q+I4Bab7VxXIxdNHCceB7Oh/pSkmM1v2V0dQ+WipQknaw7WpB+G9W/?=
 =?us-ascii?Q?wapbcVgb4o/I7JZk/6GRzVkOfJv/Kfgc3dPrGHK6ht7W6kxAAxsvVz6iOelK?=
 =?us-ascii?Q?nYe/lBEWBAxYz9SV2/huWI+KArkEKakJdOUbyZgap26LrPPMqGcVmGysbkD0?=
 =?us-ascii?Q?7spBEOPiF+0WVgfroALxXcgsc3WwpVA/VB1kBKJmDa/R0HHb1MvpMXtV6S5z?=
 =?us-ascii?Q?mnU/E9mhLdYX5hoh22fkHt8Sm4ChmsRs0SBppaNTE8obii8ztAOWR2GD5I91?=
 =?us-ascii?Q?0wApA//vbNnIcnWt/moF+YivwZwIUhmuE4ve/ho8SeZzv9cz3mi7/IFgrj6M?=
 =?us-ascii?Q?iv6bioodArX6qPF/XxDNhcKBGTWdRaLlLIQGmOnFO53ZJAUIVLKUQzDAbMVO?=
 =?us-ascii?Q?wfj156FlNxb549wGjlN+rG/29PuJ94V5CzDQzoulnRPqP4Xnba1S+0SxzWkL?=
 =?us-ascii?Q?GdLqFIFP9YP8oHERQkh8t7h0H0tNIWQP6YlijOQ4bnZ4nS8EPTrVSPoU/glX?=
 =?us-ascii?Q?Xb5qz5dhfjofAgaOr2FCZjSgSCrNweI1upOQ6VKY1bzXSF1MFbQBFHq6WrmF?=
 =?us-ascii?Q?TjTtn5qwuOdLG/iJYrHyxaqW3Hh8Uf4zTRmWQ2lbiFvx5uzBgypZtpAQz197?=
 =?us-ascii?Q?3TYnaztM4NvPabSulbQ6hJ1EdzXht8nGCR+NbfaXj13y/t2UHTDfRhNqWuIs?=
 =?us-ascii?Q?0x3IOoryK2KC9ZTPOvucULR5+cvegtwFZQcGSnmaDQe49wGKhaEiw03pPzOl?=
 =?us-ascii?Q?yl4SU+s3tQppY2EKsC244m4fJQ/Et1BFf2DDGs5o/X1FNdgAjA4CYvJ5VAFu?=
 =?us-ascii?Q?ZzrA7icVYLhHQ+MP/+bmFeDCqwY3iJj3F1hj/qpQ2iAPGGT+Gh9Ui9kO0YI3?=
 =?us-ascii?Q?h6uvUr4eZoSseg/UIJOwCU++ax4CYzqYNGZ8HnoauCamlFlYhW9UpWe6tTGN?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0e2fb3-4ede-4a52-8cbe-08dcac61d842
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 04:25:42.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZLWpJ+bA2dgTvnpXiWFap55qXawqI2cVn/YjhoRk1y9bpqFkxn7Ggk7dvSs68F+Gwy2FbJwzjBLaaE4N+jDuprImNijU5ZSBdbWvQQNCyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 12:57:05AM GMT, Andrew Lunn wrote:
>> For the commented case, I have included only one phy because it is the hardware
>> that I have, but other phy devices (modules) are possible and they can be some.
>
>So this the whole whacker a mole problem. It works for you but fails
>for 99% of users. How is this helping us?

no, this is the first instance that was found/added.

if you declare a softdep what happens is that the dep is loaded first
(needed or not) and your module is loaded after that

if you declare a weakdep, you are just instructing the tools that the
module may or may not be needed.  Any module today that does a
request_module("foo") could be a candidate to migrate from
MODULE_SOFTDEP("pre: foo") to the new weakdep, as long as it handles
properly the module being loaded ondemand as opposed to using
request_module() to just synchronize the module being loaded.

>
>Maybe a better solution is to first build an initramfs with
>everything, plus the kitchen sink. Boot it, and then look at what has
>been loaded in order to get the rootfs mounted. Then update the
>initramfs with just what is needed? That should be pretty generic,
>with throw out networking ig NFS root is not used, just load JFFS2 and
>a NAND driver if it was used for the rootfs, etc.

that works for development systems or if you are fine tuning it for each
system you have. It doesn't work for a generic distro with the kitchen
sink of modules and still trying to minimize the initrd without end user
intervention. So it works for 99% of users.

Lucas De Marchi

>
>	  Andrew

