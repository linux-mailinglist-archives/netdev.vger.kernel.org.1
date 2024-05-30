Return-Path: <netdev+bounces-99253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB98D43A7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FE1F2484D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0341C2AD;
	Thu, 30 May 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv6c1n+S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0543165;
	Thu, 30 May 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035373; cv=fail; b=mjEtSaFMvaJOCqGKwdDz1KUyCUAfTcpSIduzXq9wAEIoyQP+1c3MBn5TdVACaMr2iY3Aa6Mnn/h0lOtK2Pbis7M+btpS9aU2uu2RO0o4P7q9exp7nrCWkCmkMM3/kuSTq+RsJhWWcaP0i1q0kn/Z32HyMpJfbhGXWT5ikWeczkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035373; c=relaxed/simple;
	bh=KUQrC+CdeoWpF8WxbBWbqChOwtreiJlgVIG0GxyGBvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LciDhH6yqqnyqnKmAgQQ553//nncnBLEd3jkiiuWVepqTRWfLPoBfmqduiQleCr7usTITKLb5+WX4t76vczs3VpzHI2j3NqoSAzRmf2YEQBveANwfPKncOnCVS+5tOvVq0UT6BF0NlJPBnhc5xR0UU1/v+b71kYr1Xiz8Xnglws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv6c1n+S; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717035369; x=1748571369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUQrC+CdeoWpF8WxbBWbqChOwtreiJlgVIG0GxyGBvQ=;
  b=Dv6c1n+Spmon3i8BHGvW3QEeyyuybFy8gIOTGAXaLVrW6D8qvwfsXjHD
   AO6Rv/+gA4ULW7u2AM6OzcuRbuLbn5Z+e7nkC4hw2K9PVXyAooblDSTS9
   SigEClLkY08qa+E8Zlb0HdaxcqeslB3i2bOg7g7HwgHMPlN039abgE8nU
   +8htP1v2PjfddeW5HV7DBDs0sB+TBnQDkFiKBOIWY80SKEeUuNVcZTewh
   dmCBkSX14aX5n8Gc2xhofIEok7gZg47MZjN4bm4CrRWs2FY8KpCXQA3cG
   GwxFnGb8BfvHZCdB/ARHNf28BIyyFSg0I9GyVlHyxOgK5kufpynB50VJx
   w==;
X-CSE-ConnectionGUID: rZMhl7TDSLWvUE2pdhoaAw==
X-CSE-MsgGUID: cWXzfd9iQaiH5O0/kKcWTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13251607"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13251607"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 19:16:08 -0700
X-CSE-ConnectionGUID: jFkAh9icTE2+lc8pDGDj7g==
X-CSE-MsgGUID: 78HRmDZoTPuBn3k8/4AlMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36195145"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 19:16:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 19:16:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 19:16:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 19:16:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 19:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHe7sMAS9RCsrxYbEGu71nsoqMAo+7QmxPA5uD0Vx2ndivy4D60Pmlw8qaeMsQcQZTO/GAmezaXIxMtcXsj8rpYX/IZh2HU4Cg2+0xk9O9NZikJkFcGTDSCbYF4leWXWWWGw8QFGNAZGXsj2S6liaD2NzXmewwyDcttO6VOjJIi31V/W7y+qbz+jX/WhJCNq6eoisrDR1O/Qzx6YuqG6fQt73btARzuNg403WDapsS8rojja+McsJ4kw2x+G34JfH7wv54jtNp/AKAc5cVPjYBdwQ3Qg+xu8gAwG1wOwdzboCntzJTWLSPc6mIhJcxmiM1u87D4PjHh15368744xEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUQrC+CdeoWpF8WxbBWbqChOwtreiJlgVIG0GxyGBvQ=;
 b=Fc7UYOaW2Kp2KTJoSrSIIg5h70t5og7aJ4sSKGomQvv5Etxbg/YiTXBhx9c++fwDh+/DRtLLf8SVAGOE3xOa+uUaS1FnVdJsxFI5QcUeK+GQHTP1Wx99DC89Ebizi+z+YxZCymHAgW3y9Agvk8CcQbewUgxsaA+l8IQerIyrgrfFy696lpxtsLNHhGR7W8G9fA5y95BKl9qrbL1HRdwFrbWHJ/ggwxvoQLDW/I9JluFSzK6KFuox/VzCBro5+/gAAD8peP+XirWiWYvDeuOIcK41uusq94x+wsoLTZC0sGS4xK8/8EAwFwqeXJDhCQAZQLaZJSIP88L/A9nV3/dt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB5748.namprd11.prod.outlook.com (2603:10b6:208:355::12)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 02:16:05 +0000
Received: from BL3PR11MB5748.namprd11.prod.outlook.com
 ([fe80::4de:65ae:ca8f:f835]) by BL3PR11MB5748.namprd11.prod.outlook.com
 ([fe80::4de:65ae:ca8f:f835%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 02:16:05 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasM89szK8kSaG/E2tzqRYe3FnP7GsPSPAgABUdoCAAnD58A==
Date: Thu, 30 May 2024 02:16:05 +0000
Message-ID: <BL3PR11MB5748AC693D9D61FB56DB7313C1F32@BL3PR11MB5748.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737D071F3F747B6ECB15BF2C6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB57515E89D10F06644155DA11C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <cf5ad64e-c9c3-426f-a262-3f03964b90fe@lunn.ch>
In-Reply-To: <cf5ad64e-c9c3-426f-a262-3f03964b90fe@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB5748:EE_|CY8PR11MB7171:EE_
x-ms-office365-filtering-correlation-id: 80226d70-5414-46a9-31b8-08dc804e75d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?xOLGusypt1C4HdoWBYFcS2wpXIDZ0x6S5p2u/bnh9a4NgSvNWgarHeXblKih?=
 =?us-ascii?Q?UFbxYHN0/53G+FWtpYR7krw0GyfqxO7t4RMy8zajzBQ61ACU42lH59xE0w6U?=
 =?us-ascii?Q?gHhVLZChg5dT2bYzRxcaYut6o+r6QP6jH/c7PoGeJmkoXdl4rNwkcc1CAnrO?=
 =?us-ascii?Q?C0rKfEe6k1fEO39OHVv4mNbZQRM2hMflTuP83dlTM58dWY7yqImLAw3yuN0I?=
 =?us-ascii?Q?ev1rd//19XJqXLp3NnwaCIIFw1jvpZoO12EEZxOiVO559D7RGzQx8nYZ743a?=
 =?us-ascii?Q?u1ax2K6pnkidapRUI1sUQPGDaAQoD63X11m97fGFYrmyBRXCF0JFWPIeOp7+?=
 =?us-ascii?Q?z+CdUeJxz60ww5C6ORsS4hTcSJeddLjG8cNg3sll3u6cdu7CeojbzEMTMA3L?=
 =?us-ascii?Q?QRswLeqNJRjIWeZNx0AU/ZruVEk+7CTGrcyMqkscEhyTSTrvoXjshY501A9V?=
 =?us-ascii?Q?4Eg5fhpeuBya0zVhS0yCTQWeKlbxzXXy5RvdEJvja/zpfPaCvHt6Dsuz26bT?=
 =?us-ascii?Q?uHLudhtY82FA3DOgSbwu+t6EO2WhVHICUiGW1XzQu1BCCXV8efGqIaYsAn7o?=
 =?us-ascii?Q?ZItI/v7ggvnJ/UQZnP3qxYjEIzNPRlImgCRNZXkqOYO7P4fSg+EwERKVLn7S?=
 =?us-ascii?Q?9lQB5mbdyh0NPJR580Ak7ywusDRqgKAmLkrl3+N++U+UqCaFQE7S8SzhExpW?=
 =?us-ascii?Q?QMdiv2XWsx1FHJznZ/wWB5LjHHVnZJBafA1Nzdp/eduPYG5gBfwxpwUhwCn3?=
 =?us-ascii?Q?NtFWw8PeJxO6pVdNTxav1n3vhzuiA/yEdE80aO86hG5QV2uRwMLyHty0wCsg?=
 =?us-ascii?Q?PySwSwtY7HHVNZ4cDgVY1sdUlJk2fd/ev2zo5xp2ARN0l3oI3vIr1t/JgwwV?=
 =?us-ascii?Q?79tWRpqB0V4/Skd/y/4kAY/GbTlfUeJgAIKV18H4c3WX6oWn8CruBgKJ0IDm?=
 =?us-ascii?Q?y7UHSez63eSkM1NVx1TicrMWSemocBXT6IpVwUcscaInvE81s7t1FxLDz4EI?=
 =?us-ascii?Q?jDMo5By0i2YyMKRTi5adOwXsxlV9XtfGtopcZEmo1+icZyo3DYhQebEjMNYz?=
 =?us-ascii?Q?4PDuYcR1HHYNE8g8o+H+heW06m0chP6jDP+c1DSSyLymy6ulSo9bjOjQVB3Q?=
 =?us-ascii?Q?BCFk3du8I+6axCXMYVvi2QiBje6o6yri6ALWYxs0MKgAOOMNsfJmlPdgqueH?=
 =?us-ascii?Q?ZHCiKkF/W/YPfHYX3P8XT20TChpkM1YZ5hXN5YtsFbJTLelDJBHdnt5iNg8y?=
 =?us-ascii?Q?wm/zQ1Xvzdgt6kPbcAGCW3e4mXHYAMHNvx38FYkZWPYiIRJHPFsJI7mnCDdW?=
 =?us-ascii?Q?LMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB5748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rUln2l44OR72sYcfAiaDYUufSBWLegzXdKwceDFwl0PgjIqcRSXmGxrKmoKa?=
 =?us-ascii?Q?2kZUBQ1/n75CLW9sen+fX3+2iYvBFI+qfKfRzqDPnT75CU3hOxQj6OSjAASR?=
 =?us-ascii?Q?o9w62atOZtlAb9p0kkTOeEZsswLDWSFl4i/xI36Zs0iWCS6s47TrK1p4Gv4F?=
 =?us-ascii?Q?UkiiY8AYyNAPpPfAk2c+hVjZ1iNYQTRgZj0wAaM6V3V6HKxoZei9TJDt4Lqt?=
 =?us-ascii?Q?BMreIxbFELnBhsR4T/l9qQ8CJT4jbzzcZpeOWUd4RSbm69AdZWrkaMRLuGId?=
 =?us-ascii?Q?FHg2RYrWU8kN5FvwAUBngbC02VAlJcg2ZvgCI3vULl2uxsIKsiXOJXVZXawn?=
 =?us-ascii?Q?BzhBchb2m0EqO0fwH5IhiX7yxsnpFcQRg6sjlLBsQn5Qxs7BlshoxO/90oBH?=
 =?us-ascii?Q?M9RdVqH6pJ0+4IGOFpPQHBz/427eTDKTiuA8sWBwS1EbbZc62uUYRTZorISv?=
 =?us-ascii?Q?0WcaZhSFQDA3eG+F+ph4tH+nlwNixTm7lbNw/ssWCUs7lxoDi+wRrFvisloL?=
 =?us-ascii?Q?ZJVIPRA0Dzilbn8Qk/RoBJIum/hBXERwKE/0N+22RnVV9SmcNXseo7ZRwXjw?=
 =?us-ascii?Q?vuy3f9WAw+xcaRecvxlbnoJzPdjSnZKHxkhoRjG76kKsPe8he46RWaCUaL4d?=
 =?us-ascii?Q?1VFyFNih2o8vqAZ0niEPLjODU01DllYfVICeFBShpwxtI3bBnYVVkZkQFx8I?=
 =?us-ascii?Q?8Iu16N1MD5lkT/DTJPuWWFIjzchcA/8dFoG4CfYNO1CeskuWR6Ypy6sGTmPJ?=
 =?us-ascii?Q?SSuoinO74cE8dut4XFaa/Nnb2pQEZScOH+3MVT0DjBUx0p5wW3TkjStNoD4G?=
 =?us-ascii?Q?QSRxPhSc8H3167tucgPqzv4BHMOnMiEbLAyT+sN3zI/prx6r1aXphaQ7+TlD?=
 =?us-ascii?Q?+Aeo7MIrn5tbnjGz4OCkMYRtsX72XhMLmS6mn6DiZr1HjQyChkTzZpkORyRU?=
 =?us-ascii?Q?sd+Hk3dadSerFRozKHs2Ff1KOFirjZJllbfxYZlAeMBtDpB8rO4cqEOAG7Tk?=
 =?us-ascii?Q?QjWzpu7zGwaKeSWoY2CqtI0EzEdeI4mr9bRfXEVPthiJucevSiehxRruI/vK?=
 =?us-ascii?Q?DKDGRrX0tdNfom+7Spgj92ly5sP1R40xyyAWm0z0SeXUV5p2+fBoJxjF5+mb?=
 =?us-ascii?Q?Tqk8SCtAglJkjZhdkr5LvNhpXx1npcMxnWDu9/25qSSaPzaVk2TQy9BIToHy?=
 =?us-ascii?Q?+jIZbYSFz3Gdbq7E5BQ+srqganDbKepErPA1+p269vTOotoB146Ss09JlaEw?=
 =?us-ascii?Q?vjIWSDcSLKvX4FynqzGlFb7Baf5bvFOyWWlsXxgTC6mf5Chbbz15ZKrYzAzY?=
 =?us-ascii?Q?KrstEcMnhaYq2u7l0cZ1a0zNKDV9ZfZxKKPWRXqvilG++DD0lUkXQqDWic09?=
 =?us-ascii?Q?fD4jwxUaDBmP3QhztAoGyIc8rGtmfwy1b4h7Y8vT7aHkk6d0fS8GTgbwMCEl?=
 =?us-ascii?Q?tqS32gNxOwI4yO3Ezpm31MFVEcyN97tneRci90Wg3c2noHR5X70YvEpOPvsR?=
 =?us-ascii?Q?GHOfwVnSKiWWLkKrffwNieiMpV0nr57omnxOdXSOliH24zEhB2McIWcVvHuL?=
 =?us-ascii?Q?ckeEj2yRp+gOqvHpFljsvcKSHrDCQrvz1+p5aL9PMfBcw9YkN9/RSQlJfIIh?=
 =?us-ascii?Q?uiOVxQmZUl/19K7pm6+BYGJdLLjSdAEKrKCzknwaJ7Pz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB5748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80226d70-5414-46a9-31b8-08dc804e75d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 02:16:05.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2OXgyQYCoAvxVQjOXk2tZVkYtBJD5oBFBwUlMtqSNIQTzFNwQxQk2gEbsr4q1CFbwESgqQtgH1yE8l+MAr+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-OriginatorOrg: intel.com

> Please trim replies to what it just relevant.
>=20
> You probably should read:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20

Hi Andrew, Thanks for pointing that out, will take note on that.

> You might also want to read out to other Intel developers in Jesse Brande=
burg
> group and ask them to do an internal review before you post to the list.
>=20

I have reached out to our internal intel reviewer, and this patch
was reviewed by Andy Shevchenko for V1 and
Ilpo Jarvinen for V2.

For the V1 I got a NACK for the reason new hw_vlan_en switch
 is being introduced
https://lore.kernel.org/netdev/DM8PR11MB5751E5388AEFCFB80BCB483F
C13FA@DM8PR11MB5751.namprd11.prod.outlook.com/

So, after the internal review of V2 to detach the newly
Introduced hw_vlan_en switch, I have sent the v2 for=20
internal review and Ilpo helps to point out some of
the code that can be improved.

When I about to send out the v2, I found that the similar
implementation at dwmac4(which I got NACK) is=20
already accepted at dwmac4 driver
https://lore.kernel.org/lkml/20231121053842.719531-1-yi.fang.gan
@intel.com/T/

So, I have to revamp the v2 code again to match dwmac4
implementation. as we are using the same upper layer=20
code (stmmac_main.c). after sending this code out to
review internally again and no one else is entertaining the=20
review even after email and reminder also private message
were sent out several time and which leads me to publish
the review at the mailing list.

I hold no grievances toward the community or any individual,
I fully understand and appreciate the rigorous review process
necessary to maintain the high quality and integrity of the=20
linux codebase. My primary goal is to learn and grow as a
contributer and I believe that constructive feedback from
experienced members of the community will be invaluable
in this regard

With that said, I kindly request your assistance in providing
feedback on my code submissions. I am eager to understand
where improvements can be made and how I can align my
contributions more closely with the project's expectations.
By working together, I am confident that we can enhance
the quality of my code and ultimately contribute to the
success of the Linux project as a whole.

Please feel free to review my recent submissions and
share your insights, suggestions, and recommendations.
Your feedback is highly appreciated and will contribute
significantly to help with the linux codebase.

Thank you for your time and consideration.
I look forward to your valuable feedback and to continuing
my journey as a contributor to the Linux project.

Regards,
Boon Khai.

