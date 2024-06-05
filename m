Return-Path: <netdev+bounces-101039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E18FD02A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA32329BE9C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAFB14B97F;
	Wed,  5 Jun 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJOA5tQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014819D88D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595514; cv=fail; b=SPfrJRklOEBdWu7awKoYf0EQtc24YKJw7hAOlIZOTMhXNIRx6Ks/sIjBo8yoB1fQCa0RqscliKC4sU9LM+CjHW0SuXOSaqMLrKrk0XkFizkj6dd+X/68UqGwYGBlONI4l69ZyZ5olFQhD5PLRe0ymPW0VO3HEO+N5yKX/hKLlIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595514; c=relaxed/simple;
	bh=XoFUtglUn1OHpMRnE1z3OGdVjGTXfbr+LF3O8cdf0lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exzS8gOxRvFk6Qd8oFn59tHhTif0lWoiUqmzFCX8651pSXGb0bx/8CXvkZ6DBltqz+5UoiHTp1HCsQg5j+lD3e57nNyCj4BIc+E+y82CYTPhieBQMTRjTJeD3V5tMpmOAuhxccYqYF0NE6Hal/dKb8b9FjruXN8faqvHpJIfZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJOA5tQ0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717595512; x=1749131512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XoFUtglUn1OHpMRnE1z3OGdVjGTXfbr+LF3O8cdf0lo=;
  b=bJOA5tQ06xyx2Xa1wY7INTLDzu3HqxA7PvesW6sf6oCIOoxGBiKN+FVN
   HOwvLvUV3o7ucgz+BaKno2UDOrLMOi3oMJZ2UcxZjcz1PnLuqPt2mvJ7b
   HTTvql5cj9T+9e3u9YTE1jX7Ez7CT47rLfGLvBl1Ip1wSdXFN8nI4GToD
   jTDkXMelkylmqjfWtiJObS9D5pRRC/j/A0HnVvykVHoD9afwYTQkCeR6j
   do9WY/ZlBSrjkgDG6HkgcMfXnKyjpDWbALvxDv+VoMEUXMx2ML+pBfSny
   qhwXfnYaPZAvgtXD4sHkREaszM0TSZXaHVQSHFpirEZP2z56GH+DrXUbg
   Q==;
X-CSE-ConnectionGUID: k9MXdqrLSACVLCJNFI1QdQ==
X-CSE-MsgGUID: bt3fECLhQVaS0nVHuBz4og==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25614283"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25614283"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 06:51:51 -0700
X-CSE-ConnectionGUID: tqnakwswRbqZsNUs1PFvcA==
X-CSE-MsgGUID: 7/y52V9fRZ6FJ04dF4tbRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42031862"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 06:51:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 06:51:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 06:51:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 06:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsFyMcuL+WDkrg95aXw5Cr0/MLzd7jVpLkULmcbPisNQi0OIrLRjKOzgvPMCsCfgcveo6yJecnSo/8YC9X1UEFS9fkj1SZYW8ecEkQUf+xkUervpGFLfhvGr4ktu3jmh2J5oRguvtFq4kcXwHX52O6e/av8Lz8HCeFqINjo2E25LDflYfPF68Q6ZYaQUCoEjhSrugo7rPXfdACrPiHUG4xTt0ZY8UZX/OfPetR9/MNk36MBs0llAExJ1lBaixkbN84yipJpjdJlMvp1XpxFSbHbLVTwoRiZ2wtGIOoNRSUIB1PZxOQRECPr8SrKAb8BpGSF1UKm8oqqUZOHL2spqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7ipe51w5dVMweKQoqbblElfgj83++MgOj9anH/5fGs=;
 b=FqVytrdwl+/v2fapqs2DQPP/mrhGeOEr0bDyj6aLZ5/RceaUTHgDm8J+eWD1r6czhcUyuCC/3P3j5k+xiW8FTHJRSD/O/klVMntnbqH/rSgR/81zHp9Bb8ULj4C9cUU4NxFre3BL0qUL/zvbQIP266b0yO7mQiINlzHw5o387SmB0vUpB2rai0HfxWE8NSws8CCKQ0pVHEMYK+l/kflLFq0N/Bf9cMJDnrpa4XLF/UF2+O7a6QPw2oXoKSMWDRVbW+qFaPNaZZrBN57Pm6iImrYM7etmfezL89EDutAMS0NPHbRqmCOK16zaFNMyVtSdjNH2/pRL+L2KSYxwVHeXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 13:51:47 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b%5]) with mapi id 15.20.7633.017; Wed, 5 Jun 2024
 13:51:47 +0000
From: "Ostrowska, Karen" <karen.ostrowska@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Joyner, Eric" <eric.joyner@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in function
Thread-Topic: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in
 function
Thread-Index: AQHasN4Z6+vz+5ABikyLgOGWjsDjQbG3um4AgAGCd5A=
Date: Wed, 5 Jun 2024 13:51:47 +0000
Message-ID: <IA1PR11MB621994292EF59CD938ACBCF5E9F92@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
 <20240604144712.GR491852@kernel.org>
In-Reply-To: <20240604144712.GR491852@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA1PR11MB8318:EE_
x-ms-office365-filtering-correlation-id: a9a3110c-a9f9-4926-83b4-08dc8566a4d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?RtLmr9AHDdtnTaBWHPFP4eppT3Lj4nD/gyGtBjCSYP76t3MX6jPQQotlM+n/?=
 =?us-ascii?Q?Duhec64Eg1etpj9fILxrVVRLXYfzfTkb/viD829W+tgaPBpUNXb8l4nb7XHi?=
 =?us-ascii?Q?WVLLcQswyMOmn0JAVWhJjCo88HCMgu2bNdsbmqNQx2qDOwSKe6xNm4qng0Df?=
 =?us-ascii?Q?qwgKqs8sjpQ9m48w6VCh40vDtXFqH2PlHx6mjc8Yt2pxGmlLdnD9voq9W/rb?=
 =?us-ascii?Q?TTAztstN9hZqowCIVrscMIoptkPKRC/4OXlmJBjAhJodHoXlZwY6eU1QG4nh?=
 =?us-ascii?Q?U5j3XfVL9iicVxaXJnJ/hM8cBdDaWsYkN1LnX9U2e0fBeRKMxlxVx6EPaqLm?=
 =?us-ascii?Q?3s3xFgA5Um/AM7iLHkQdvG+QedJWU8lrRMaLMpaGVaj5jZH6v3vZ3asdWBd3?=
 =?us-ascii?Q?usvdmCCU5/R5b+bgXEklZnGatQc6HEr//SSlp4Jr2KnY3fxOvM9xwRr9doAN?=
 =?us-ascii?Q?e38EAx5ipSUOtNunffMEzOytf7cRQe819joCUsKeR+F/XVKYkQOFxhf2fKyu?=
 =?us-ascii?Q?TUh/X8EoIiiJL7z/CfqDKHlE2IRxF8h5dqYuyzyBUIzmpVdGABAbeHFMKp0b?=
 =?us-ascii?Q?WJBZpdjIIANaBIIZAgW6xqv3HpqKyz+7mZ7aS1A9CoPEr3e8j0QhUwqJu2Zw?=
 =?us-ascii?Q?h2+3BlbDzCwEe8y72e08inrJGA2fnxZtu8FAkckeSJFNiEmusTZpbi1bo+lo?=
 =?us-ascii?Q?Y41aNzfmqJd3buUMVph5oZhc/3n/2uBYEz3v+kNNusEwjceLeIBsjs/1jJ0f?=
 =?us-ascii?Q?TQf5HCcE775uUCL6YI4eXddBcAmN2RwaAFkaKjiUinyZPXKpsl1vxL9oeDEl?=
 =?us-ascii?Q?Y5juzACzefDv8/UtbQLqMJ8N+Th3nnpP/1qtxw5DW/VSWdkLCtU3v7wDAg90?=
 =?us-ascii?Q?ugGO/o5wG47G5Xn05muHxTkewrqvQAiv468U/2jWXsnIw99QqUUs2JumeVFc?=
 =?us-ascii?Q?STocyxnTCbgBaLxqv5lz7yJalHI8MFJIQyjZICS58PU+GxH3GgGZ3ZhXKTou?=
 =?us-ascii?Q?WJaS/qgoZeKDfM5DVxBIBvINABHqDr6NqXt9penw2IXjHO9SyJNptz5vKeKk?=
 =?us-ascii?Q?gcPHSlxUYA3WH9K9KLyJhsaBtKsFvu9Tu+dTywYKSA7CeREP11wsCBgpVj3G?=
 =?us-ascii?Q?Qng1lilXdceOLltDNnnE7JnI3m1CkwwjwymSfmKpHbdUcPNb6Q5ccA6b7wFM?=
 =?us-ascii?Q?2b9r5L9SOaX1btoEaB6jLKVoVOD9h2Wp8yExotAJyNEjT0Sme4RC0SIvyf6R?=
 =?us-ascii?Q?botOxJREfNVruSn90kCLaEpmfEpFMhz+xC3yRJeiGYI9nPFyKk1bOlSpeYCz?=
 =?us-ascii?Q?XSXsNF4rjAcn8lgEl7BK5d/jbpZ4Cy0WQx4K+k+QQEMbf3IdrDrzk2d5M13U?=
 =?us-ascii?Q?Lo51+xc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gMNTsPZ1H3tjPD6JcEUrHwI85bDvBGVzWa/v3vc2zTl39p6/imC8W5PJOJPJ?=
 =?us-ascii?Q?5mZzjZxO3/CruNKT0+pe3HsIj96I+vN+isu5nS3KnLiuZYz+Dr3kEiiyG11X?=
 =?us-ascii?Q?DBwuvDiDh1+0IpLBHIzsLW1Vw+27kKCja1T9pKd4COii5WSdyXdHSxQIoJVo?=
 =?us-ascii?Q?f503iOonRbuV5b/IoNqXJnoe2wHxRnekogI+xwsm1IhZ/kzxSW+ue1FF8Cyv?=
 =?us-ascii?Q?ZSd9rh6dQlLVyir9tVG2/EHO0CyRXCMEqBzSMFJrLGIHL1pzbkqj40ypFuop?=
 =?us-ascii?Q?8Clk/UxaDxsREFz3lPcCBJacvofc2G6CJSLYtd4ZYs97hliHz4w6Hh4NHdhS?=
 =?us-ascii?Q?urMQHaEl7Qfv2s0sSSQAESXVG2G5JaNQzGpRFbkMOUqL4Yv8zXUbTdhzEn6z?=
 =?us-ascii?Q?p2tAvHrwywv/GhIvQ8WxrRSTydaqU9vE55R9cQ/j/MTd692+yczKUNO3/VfY?=
 =?us-ascii?Q?eiLhqamEAA9naUZ6/viFI2n70sMO/EXlVhpAOxSVSILUEXl4Y9+tyNo0QMpe?=
 =?us-ascii?Q?3cCQjKp2rbhpAoILaUeAJ9ntHoiiVqCR3/zZRufI81B9xBvmrKJsL5KZrXPe?=
 =?us-ascii?Q?KtQykL34dbJNaOjIvu4Pw6TWLQa5fTTRafoAkqaAK1L5RvA0aypf0MTnQWUh?=
 =?us-ascii?Q?B2wF2AbWSO4YCWKUc9LXmaS010E0XnLJJNQAI3NiGeIvNX+feip3LTp+78Mr?=
 =?us-ascii?Q?M2c7AU0y5Bi/cnutFy8Rs0a0IfYVmSL9H4Gk7vxhfrNeOCltLf098yCbt6Un?=
 =?us-ascii?Q?XdeAvQ/mHeHzKBTIBfcTc0mWEDcdUrK4bnIvLeW9aWKBwvmR7WqhSbuAuRfz?=
 =?us-ascii?Q?GxiFGbL/DxEs2dJPjH5iDYmNZnn7PfYvI7l1uyBtk1XsL7gn/8TdW1tKXDvZ?=
 =?us-ascii?Q?aJN0eD4Jqpbn0vRMloPbWt0y1qB9FtcdQALUx502mpfXm3GdA4VP/n9dKHxs?=
 =?us-ascii?Q?GVbQDyRefnvEkGpwRGu8IJ3f/ZYnQgW1R9y2VhUMk16qg1dSCBxhwt7FUTIR?=
 =?us-ascii?Q?GV/6o3D+PGHxqEffXgTyPkKg7urBcL+aZWnKitLBw4wFE6RVE/TyXdDYxbZ3?=
 =?us-ascii?Q?Qr3pP/eDXtkmAObmneef15CDkL3TBJolGVKh5vBl6SnvnzxsYa4lBVIGHzWZ?=
 =?us-ascii?Q?biEFdtTe9BWA7KiD5xlRn2bSc9rA+nkw9pfW+9NCcvb7eWUkZs87OMj88l1Q?=
 =?us-ascii?Q?OoiBBrTU6RutC2qBApOoCWpwfHzn6fgGqqns+k/ZZkfgsJya/t3FxG36XTDz?=
 =?us-ascii?Q?fv+GuKmKwvQQj754ec8grt2lKbbJIMoKncVz7h3PKibV8ZOalfmKCNewSqrK?=
 =?us-ascii?Q?6SddHgjbZ7Ls3wu8qYz59WZvWrwinPVVX32BOWp8O9sL4V13TkU8PeQs9Btw?=
 =?us-ascii?Q?qqztOWqAIPYPoIlsCiV6w1qEGLGVxjE8N4ILFTk+s6dH9/8gB6RnAO1nyxcA?=
 =?us-ascii?Q?yWLIS1b9q2MP+CNlK48J566yRd/yMROhEiTIrGbwuIFEcmZQqx8YRKz6N5Bg?=
 =?us-ascii?Q?Hjh3jt8zHMHfLsZJ1YnF1iUkWi2Ew1PAV3Ifefd9D5BQkNm3OXlVB4/uhGY9?=
 =?us-ascii?Q?a5Lod0PUQScIlVwV94LQ8NNXK/k6URWFA3QmVYou?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a3110c-a9f9-4926-83b4-08dc8566a4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 13:51:47.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfmAsutKoer0XquaMhKOuMMF7feFRZsKWkEiw806lRRnFQmVYHOaC4bwYoFnSlwp1CNS/al9dGJwlfZDsJANVLCILALXbtjAuVt+vmOUgr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com

-----Original Message-----
From: Simon Horman <horms@kernel.org>=20
Sent: Tuesday, June 4, 2024 4:47 PM
To: Ostrowska, Karen <karen.ostrowska@intel.com>
Cc: intel-wired-lan@lists.osuosl.org; Joyner, Eric <eric.joyner@intel.com>;=
 netdev@vger.kernel.org; Michal Swiatkowski <michal.swiatkowski@linux.intel=
.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
Subject: Re: [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in funct=
ion

On Tue, May 28, 2024 at 11:01:40AM +0200, Karen Ostrowska wrote:
> From: Eric Joyner <eric.joyner@intel.com>
>=20
> Check the return value from ice_vsi_rebuild() and prevent the usage of=20
> incorrectly configured VSI.
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c=20
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..e8c30b1730a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int=20
> new_rx, int new_tx, bool locked)
> =20
>  	/* set for the next time the netdev is started */
>  	if (!netif_running(vsi->netdev)) {
> -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		err =3D ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		if (err)
> +			goto rebuild_err;
>  		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens w=
hen link is brought up\n");
>  		goto done;
>  	}
> =20
>  	ice_vsi_close(vsi);
> -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	err =3D ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	if (err)
> +		goto rebuild_err;
> +
>  	ice_pf_dcb_recfg(pf, locked);
>  	ice_vsi_open(vsi);
>
> Hi Karen,
>
> This seems to be a good improvement to me, thanks.
> But I do winder if we can go a bit further:
>
> * Should the return value of ice_vsi_open() also be checked?
> * Should the return value of ice_vsi_recfg_qs() be checked?
>
> Also, I think the following is appropriate here:
>
>	goto done;

	Yes, definitely. Thanks for remarks!
> +
> +rebuild_err:
> +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and=20
> +reload the driver.\n", err);
>  done:
>  	clear_bit(ICE_CFG_BUSY, pf->state);
>  	return err;
> --
> 2.31.1
>=20
>=20

