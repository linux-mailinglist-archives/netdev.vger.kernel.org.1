Return-Path: <netdev+bounces-214440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E6B298A1
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218DF18890FC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 04:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40B266EE7;
	Mon, 18 Aug 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsBFRImH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5808B266B52;
	Mon, 18 Aug 2025 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492559; cv=fail; b=jcTTuF9NKGM7SvrZjaVvp/6rLZHsgDWRqCSjE40i145bPkPX9QVWhOAQwqnAT3/ElXv21WwHDuG/S8YHHrqfYzT63aPTY0wKP4G2Kom4ogbwc97GBHRnpBuSVixGMQEmjoAuhSdW/gz9k52Dq2iIEefER1jSwQTLPtK4g6mPfIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492559; c=relaxed/simple;
	bh=KyKkTJ/Ynuwj1d/wfg4OWDAkND2S6gCcp7NEwQ6dhg8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gHeVGLhmKfqHeHAkCV7lS7U6FRgFkNGJGyjGGv6+Xd5IDi2pTEMno9eRaX+NTH8kcaGK0UAv0ivWcTZ64EjE2XzVS5BT3/udYbOE4dcQttqs+g4PNwLB8ubwNdo1R3h4W+cII1ogEiQGuEb60r0quDqC2guxdMjoGXTkHzgLwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsBFRImH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755492557; x=1787028557;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KyKkTJ/Ynuwj1d/wfg4OWDAkND2S6gCcp7NEwQ6dhg8=;
  b=ZsBFRImH1H0FPOnV6j/lgezX+73PShFtRpi3UawPHcWK0bNL79CX+o2k
   bjbyUg5l9BtzU4aXviULsu60ZZCUgoqvMsvDoU/Lb7fKEboccmPXAzzwa
   UBbNh09Qi53YkM10QWCaB74N3nky7Xe+xk1LlNrCAn2NPoLrI4dPSuJrq
   jVoRAvFZsinuHtwe7LKi6LPgZl2RTukILyHPiNSIaLGCkQ0jaE8P4braL
   ju4EdavH1CVHNwbkLoioRVUnztlr8MSMheR/B7cKCJqn+DGMsPkZEPGZ9
   SLXBICnVOqPIdnEFeC5PX5jXudzOzoBdUn1zImjt33Dz+xUw+wzppo1nx
   A==;
X-CSE-ConnectionGUID: 3cLw1ADZRcK+CoRDIbrUag==
X-CSE-MsgGUID: GBLKNEdtScabxEplaEId1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57782081"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57782081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 21:48:17 -0700
X-CSE-ConnectionGUID: VKXCksbATr+iVn/hL9uBmw==
X-CSE-MsgGUID: ZXSH1pcVRlK9xEvwO9gegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172822301"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 21:48:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 21:48:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 21:48:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.76) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 21:48:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZWb7ocy12L+TaA7JJXDYOT7dhjRS0Y1FIpNh9VTnBCn6yID0PdQSmps/k/Zk0wcPlFPzOtbDV2c/YjaQ/9UWEsSduzNDS12zXh5iFQrvJtBa+s9Ci1YsIsfCJKFhH9jrQfsZHKLvS3u+az019LxbYP2fIvqyxSVp7idHElzSXcIHY+Y1i00W77RqMJswl55BGZ+2CbA1cLWZhizfgflL36qzld7NS3SYmeaUbiihoKszAkKa7UZm2aXB9CzfKfQx9a+/bGSMR6Yb0FRKV6hpoICNnxhjL19SfLzCPH1/eBQzRsWSVvyx9PoCx0RvvB+g55cGDHLBOym4EcpwnzA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j5g3IPYhBTILepeRaZiTc8Dr3s1L96/pEqCQkyRMqk=;
 b=hKIZIsB2CqDxotS+QuwJKuZh6if+ezC2U2mU7IzA4HT8IFi7bQ20YBhe51oXZXsAAeOGieqV6fCvLo8XzYM8LRTzLP98Kix21QkYFBhM9BWUdBSHL5XWnDPxJpk7wfyMhGKSlXPbxz//qXY2axsK50FDaHenjWm3nAaO1V1xAarK7EVBVxexmK3sJv3sJIjYhBDCpm5G4HGKtYOhtKRWnfKfYhefqz1ofShKkMNDA0VhyHASX7p//0gTA/EBZAN+Vq9eEcajMOCAQXL3Nt7iJ9kdUhKcS5yzWC8nc55h8YMehsfWTON/8HY8U4Q7DQ00Mk/jvXF4NIE8m0rnVwo2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 18 Aug
 2025 04:48:13 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 04:48:13 +0000
Date: Mon, 18 Aug 2025 12:48:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tcp]  1d2fbaad7c:  stress-ng.sigurg.ops_per_sec
 12.2% regression
Message-ID: <202508180406.dbf438fc-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0932c0ef-2003-4d40-8265-08ddde127097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AxUueWUgs1eEr3MQeoq6OW1IXe9bcPveI0aILByIqUG0Z3i83EBT7HXJZJ?=
 =?iso-8859-1?Q?DDFwfmGf1MYf1VGwlz92x9chQfEgPYHrcLI7pgOO3ENWwVZsW/KEol08Hk?=
 =?iso-8859-1?Q?16kQrmWx2LmF1qLbm7kapc9bk9lC6p/RA4zhAO+hdZfkX5R41mFwBqtfr2?=
 =?iso-8859-1?Q?hoksfThGMcsSR18aoWXErwPlx0ZAD8FUrY2+kmkoqFuREEg0wPBjSrrcT7?=
 =?iso-8859-1?Q?6NYPXXG846SStsEN+UXT/PTebd3kQavhGNMrdDr05/y1it6aGIDN2bb9EC?=
 =?iso-8859-1?Q?yHlghVed8dYuASlZfp9AsoXLlF52XWA78rNi+ehY1LI5joovYxeveq94cz?=
 =?iso-8859-1?Q?RvlVdnU4B0b9ZOuRnrix5cv/PGeb6g/OtIgnBwL0XZD2mu1EhybyiQith5?=
 =?iso-8859-1?Q?8ajSN/TY2wAmjhHEgZiFdTAdMtcfdoq0BdbWPIFNIA4xVPoQdxe8KhN8cv?=
 =?iso-8859-1?Q?6H8MCLJ3BfareeodhEXJv6VF34jutVLxE+9cC/w9PuhHQrhdNIfrqyCzNa?=
 =?iso-8859-1?Q?+FgE2Hp4y89PpXiNjOHKr8k2365/Jp4D0LS4ChjmtPWV+YWwHq1/O7/Kxa?=
 =?iso-8859-1?Q?htM/Yizx9jZ7Fbpe+knEgardsySR9tUWrkzCKHSi78d8saIeJqqRIgqvw3?=
 =?iso-8859-1?Q?rHFdkMe6G7jHOmkn8ZBe1o/FRvlemPG7kR/Z844Jn85PF2E/ZAS2bInURN?=
 =?iso-8859-1?Q?0SqmaDtI4YABElecyL48J4qe55Nz9qNGDv8nT9KUBj9QgmQSDjSPNa+pAf?=
 =?iso-8859-1?Q?q0GEVjtuaZLrY6+pp4d4TP9EyJ36q9y+rz1xE4Y7qj6OeMYZzY5bvIb1hp?=
 =?iso-8859-1?Q?CWtAiQpLSax363LJWAjehcKJ0aMUNABHLty/kYljFXVsHmNugYpJ0I5RbE?=
 =?iso-8859-1?Q?6gB6HxaVmN66xJfgxkcN27ZpyTLChHxK5wNYP5DhaGxaKZ98zQAuSITf1w?=
 =?iso-8859-1?Q?OMSi5LqROdV0CWkQJ5ntrVxFSmkNe2M+Zm6DHySTaUOTxQr8z4CqE11WWy?=
 =?iso-8859-1?Q?wERpPpypt7Ayq7ups7UpWvWvt+89Ly2ULVhf+iNNNBlC2MPUvC3MVWXoU/?=
 =?iso-8859-1?Q?+kxl7SvwWCwPNAykFhuf/Rnjx/+6ye6YmZ1NKRYhFkFqD9PbATHYDpQlOX?=
 =?iso-8859-1?Q?r5PvhQUi9NglPXaba7Wm5/5gDktrk9Xe7IAGv8iJNbFq/MeyWT2R/5+Pl1?=
 =?iso-8859-1?Q?xT+YVd0O/QX0bg0aG9TooIgs2P4fbiYG2SMHsbsWCDQQjijXBbLY1Mqu5b?=
 =?iso-8859-1?Q?d+PoNfGwRIFjonQF+7vKT7bjiQ80F5dI9o8QSxxQhDmv9afiB81zW9qCb5?=
 =?iso-8859-1?Q?LtWAX20lh+89mKcRVeN0o9u+dsinh8EDjrMhsZ3xSPTj3eWPeYSywXceY4?=
 =?iso-8859-1?Q?qVvg07M8wyp31yPLjsoWMIvMu213D4s9mnzoOYH41kdYAgtHDXY6iiE8CS?=
 =?iso-8859-1?Q?z5dybHjFbkhS+zV4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?c1LPJkYj8lHKJim9YjRt4Q+wQYEqd0uO3liVbjt/6AaJFAawrJukCoFlWo?=
 =?iso-8859-1?Q?Uil1MDBURzJ4Z+pF5Df7Z378dDeLeT8QTRfl/VBn0ELX0KCVeUNo/isicd?=
 =?iso-8859-1?Q?bLOZEnzhDw+vA8VWfWlrXzon9d8lJ44+DxUgOhLLTHHS3u9Cz7tLI+sngF?=
 =?iso-8859-1?Q?PWMBFcoptcMUGOhI6ls3NysdGtUbKObRsoZ4Sk7DPIhwYa55VF2kRkeoA2?=
 =?iso-8859-1?Q?X/GMxQ6kUiEF9vv0hlHQscK7NOaCXz25MxHgQIzaKPBK8NOsfoXd3j+uP+?=
 =?iso-8859-1?Q?ygYCYVhcgaVBSnptvIxjCDGPUl5GrHjxDfDFE0PT5vaz4VMe8juDt/HT0+?=
 =?iso-8859-1?Q?SjEVqrco9sjGBs624o3V7Qn6nbdXnjqCaBPSKmJz60meuDfGPN8/4rIWRw?=
 =?iso-8859-1?Q?oJtl/eLioAcI3D8Xq/sG6G1Sk0kgMc7ba6J+A11kkk+QSyD+jOk1ZU0yBD?=
 =?iso-8859-1?Q?TJ3bpL0cjuEftIsH2fmiNiu5bArFpYcgvtvRfgQ8px9nlByZqQwxCjEc6P?=
 =?iso-8859-1?Q?h/i5KvZddOWMc+j3OIt8rocPiiC1wpDBcluoV9agie4XFbXiAk4zjUdaSA?=
 =?iso-8859-1?Q?ZM8JX+9rQVtk+GQ/K/2cc1AwLxNeTvsmn7W0mTv1TKYQj2Jwe6pKgSibLB?=
 =?iso-8859-1?Q?KickUbEAaZUnfpA4sJ4Fpu1PCbCruf5YDXevt348MUt+3p+MRGCWvT8hio?=
 =?iso-8859-1?Q?USlr6QrZfdFUTP3xK/GdDZlUTRt8SldFWBIvZ5H6aH9s6pTlnZdpjL2Ae2?=
 =?iso-8859-1?Q?vMELxzR0fHkL8XQw3Oyqo7ezkD2Y1Fpzcor3cz63Hv22tyjNb/DtsFUUq/?=
 =?iso-8859-1?Q?BQ74yUV/XMUojFKrHHcZCt0Bk7mBGzS3eC1D6yyy4tV3Z1bJ2VGWeSd/DO?=
 =?iso-8859-1?Q?/2HzQ6bw3gUUf85r7ccUhv8qb18+EYqTAXFeXJnRZjdDQtZ7MfT/+azTXP?=
 =?iso-8859-1?Q?LFp79USUhr94OI/OxB1oqc0ajQnf/ZcDl5CCzi5883cL0XffBMl0DG/T3u?=
 =?iso-8859-1?Q?NNKmuVb0MKXjytrCoVRsOBJfqSNtO2hcG9z4jvOR4TrEiweui3nnfUjKFM?=
 =?iso-8859-1?Q?ln4e5vhtpUKpNd8poBs4Q5gR9JG0G3jhyM8LFJboro8hoGEGFuPJ/xLJwf?=
 =?iso-8859-1?Q?TCR1DzPu+i0rYkVYx5zQkLcSTcFlHF9fE3hHH3rgQS3reCq04cjSUrhCCq?=
 =?iso-8859-1?Q?wOfLe6YlRCVpvfu+ncI0ZAY/2+nB2WMDCP99ILfOV5KrOgN7ueg0Op1nYc?=
 =?iso-8859-1?Q?xkEH+9tQ/SBwQVj6cVpL1CA3qJVgjZnduII5qey7M71Qe/VihMdzWLJCJK?=
 =?iso-8859-1?Q?XexBuzm+Vg+GnlyRwZF/A38nM+2+mcp5v6mFGf/uD0O3VQ4eti4XJlPzRT?=
 =?iso-8859-1?Q?7swIYwOEVFJEwznrBAhM770WwkGup54Cj+zMGMqbn5t7ZW7dqjb9GLa6lE?=
 =?iso-8859-1?Q?1YjftINz+JFuAFD5cr5/ucyMZf9zJVjBEN18CZ4UplMG8ylW1T59+Yp+Wb?=
 =?iso-8859-1?Q?ZkvPJoIE8Xen7qnioqVWkuhHb518YPijbUsK5wkXMGbGUkLyRefHphukzx?=
 =?iso-8859-1?Q?lL9rlC+5wEQJAqyhkqqpdi3Xc/lHe/mCg7r11toQ1rIewAL7R5ll15P1kv?=
 =?iso-8859-1?Q?sZn3X94lBiNAC0RIxzh8RGBd+xk3U4PkHfRFIjS0QA08487Bz4AVfkSA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0932c0ef-2003-4d40-8265-08ddde127097
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 04:48:13.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD8W+HhimjdJhrFKVeQqQ2FsLBYHpqaQQx4nnno8Wq8xZCDVoiChK7PR4uZvnur+DhvN4JAQD6XfiwJz+l+4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 12.2% regression of stress-ng.sigurg.ops_per_sec on:


commit: 1d2fbaad7cd8cc96899179f9898ad2787a15f0a0 ("tcp: stronger sk_rcvbuf checks")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master d7ee5bdce7892643409dea7266c34977e651b479]
[still regression on linux-next/master 1357b2649c026b51353c84ddd32bc963e8999603]
[still regression on        fix commit 972ca7a3bc9a136b15ba698713b056a4900e2634]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sigurg
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508180406.dbf438fc-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508180406.dbf438fc-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sigurg/stress-ng/60s

commit: 
  75dff0584c ("tcp: add const to tcp_try_rmem_schedule() and sk_rmem_schedule() skb")
  1d2fbaad7c ("tcp: stronger sk_rcvbuf checks")

75dff0584cce7920 1d2fbaad7cd8cc96899179f9898 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     36434            +7.6%      39205        vmstat.system.cs
   5683321           -13.3%    4926200 ±  2%  vmstat.system.in
    530991 ±  2%      -9.3%     481619 ±  3%  meminfo.Mapped
   1132865           -13.5%     979753        meminfo.SUnreclaim
   1292406           -11.9%    1138096        meminfo.Slab
      0.62 ±  2%      +0.1        0.70        mpstat.cpu.all.irq%
     24.14            -8.3       15.83 ±  2%  mpstat.cpu.all.soft%
     10.95            +2.3       13.22        mpstat.cpu.all.usr%
    627541 ±  4%     -15.4%     530831 ±  5%  numa-meminfo.node0.SUnreclaim
    721419 ±  3%     -14.0%     620592 ±  8%  numa-meminfo.node0.Slab
    513808 ±  6%     -13.1%     446297 ±  4%  numa-meminfo.node1.SUnreclaim
   6100681           -23.2%    4686698 ±  2%  numa-numastat.node0.local_node
   6205260           -22.6%    4802561 ±  2%  numa-numastat.node0.numa_hit
   5548582           -18.0%    4547552        numa-numastat.node1.local_node
   5676020           -17.8%    4663456        numa-numastat.node1.numa_hit
     22382 ±  2%     -37.0%      14107 ±  4%  perf-c2c.DRAM.local
     28565 ± 14%     -28.5%      20433 ± 19%  perf-c2c.DRAM.remote
     61612 ±  4%     -28.7%      43958 ± 10%  perf-c2c.HITM.local
     18329 ± 14%     -27.0%      13378 ± 19%  perf-c2c.HITM.remote
     79941           -28.3%      57336 ±  6%  perf-c2c.HITM.total
    155304 ±  4%     -14.4%     132870 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
   6217921           -22.8%    4801413 ±  2%  numa-vmstat.node0.numa_hit
   6113343           -23.4%    4685551 ±  2%  numa-vmstat.node0.numa_local
    127106 ±  6%     -12.0%     111885 ±  4%  numa-vmstat.node1.nr_slab_unreclaimable
   5686635           -18.0%    4662431        numa-vmstat.node1.numa_hit
   5559197           -18.2%    4546532        numa-vmstat.node1.numa_local
  3.39e+08           -12.2%  2.977e+08        stress-ng.sigurg.ops
   5652273           -12.2%    4963242        stress-ng.sigurg.ops_per_sec
   1885719           +11.0%    2092671        stress-ng.time.involuntary_context_switches
     16523           +11.2%      18365        stress-ng.time.percent_of_cpu_this_job_got
      8500            +9.2%       9278        stress-ng.time.system_time
      1438           +23.0%       1769        stress-ng.time.user_time
    195971            -6.0%     184305        stress-ng.time.voluntary_context_switches
    487113 ±  7%      -5.8%     459038        proc-vmstat.nr_active_anon
    134039            -9.5%     121269 ±  4%  proc-vmstat.nr_mapped
    186858 ± 20%     -15.3%     158269 ±  2%  proc-vmstat.nr_shmem
    284955 ±  2%     -13.8%     245616        proc-vmstat.nr_slab_unreclaimable
    487113 ±  7%      -5.8%     459038        proc-vmstat.nr_zone_active_anon
  11891822           -20.5%    9456122        proc-vmstat.numa_hit
  11659806           -20.9%    9224357        proc-vmstat.numa_local
  86214365           -22.0%   67254297        proc-vmstat.pgalloc_normal
  85564410           -21.8%   66883184        proc-vmstat.pgfree
   6156738           +13.9%    7012286        sched_debug.cfs_rq:/.avg_vruntime.avg
   7693151           +10.1%    8468818        sched_debug.cfs_rq:/.avg_vruntime.max
   4636464 ±  5%     +14.2%    5295369 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
    238.39 ± 92%    +228.2%     782.32 ± 46%  sched_debug.cfs_rq:/.load_avg.avg
   6156739           +13.9%    7012287        sched_debug.cfs_rq:/.min_vruntime.avg
   7693151           +10.1%    8468818        sched_debug.cfs_rq:/.min_vruntime.max
   4636464 ±  5%     +14.2%    5295369 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
      2580 ±  3%     -13.3%       2236 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    104496 ± 28%     -64.4%      37246 ± 38%  sched_debug.cpu.avg_idle.min
      1405 ±  3%     +12.7%       1583 ±  2%  sched_debug.cpu.nr_switches.stddev
      0.68 ±  3%     -40.9%       0.40 ±  3%  perf-stat.i.MPKI
 9.475e+10           +26.6%  1.199e+11        perf-stat.i.branch-instructions
      0.13 ±  5%      -0.0        0.09 ±  2%  perf-stat.i.branch-miss-rate%
 1.178e+08 ±  3%     -14.9%  1.003e+08        perf-stat.i.branch-misses
     40.25            -3.2       37.02        perf-stat.i.cache-miss-rate%
 3.325e+08 ±  2%     -25.9%  2.465e+08 ±  3%  perf-stat.i.cache-misses
 8.258e+08           -19.2%  6.672e+08        perf-stat.i.cache-references
     37598            +8.1%      40642        perf-stat.i.context-switches
      1.31           -21.4%       1.03        perf-stat.i.cpi
      2327           -15.3%       1970 ±  2%  perf-stat.i.cpu-migrations
      1927 ±  2%     +33.7%       2577 ±  3%  perf-stat.i.cycles-between-cache-misses
 4.888e+11           +26.3%  6.174e+11        perf-stat.i.instructions
      0.77           +26.9%       0.98        perf-stat.i.ipc
      0.68 ±  3%     -41.3%       0.40 ±  3%  perf-stat.overall.MPKI
      0.12 ±  4%      -0.0        0.08 ±  2%  perf-stat.overall.branch-miss-rate%
     40.27            -3.3       36.95        perf-stat.overall.cache-miss-rate%
      1.31           -21.5%       1.03        perf-stat.overall.cpi
      1928 ±  2%     +33.8%       2581 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.76           +27.4%       0.97        perf-stat.overall.ipc
 9.264e+10           +26.7%  1.173e+11        perf-stat.ps.branch-instructions
 1.148e+08 ±  3%     -14.8%   97834009        perf-stat.ps.branch-misses
 3.253e+08 ±  2%     -25.8%  2.413e+08 ±  3%  perf-stat.ps.cache-misses
 8.077e+08           -19.2%   6.53e+08        perf-stat.ps.cache-references
     36742            +8.2%      39741        perf-stat.ps.context-switches
      2273           -15.4%       1922 ±  2%  perf-stat.ps.cpu-migrations
 4.779e+11           +26.4%  6.041e+11        perf-stat.ps.instructions
 2.914e+13           +27.4%  3.711e+13        perf-stat.total.instructions
      4.41 ±  4%     -17.7%       3.63 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      6.74           -12.8%       5.87 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      5.30           -19.6%       4.26 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      5.22           -23.4%       4.00 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      4.83 ±  4%     -15.7%       4.08 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      5.20 ±  2%     -17.9%       4.27        perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      4.92 ±  2%     -16.5%       4.11 ±  2%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.75 ± 18%     -88.1%       0.69 ±115%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      5.00 ±  3%     -16.2%       4.19 ±  2%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.35 ± 15%     -37.1%       0.22 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.47           -16.7%       2.89 ±  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.13 ±  7%     -14.8%       0.11 ±  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.82 ± 55%     -45.0%      18.60 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
     36.83 ± 10%     -32.7%      24.80 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     10.05 ± 49%     -58.0%       4.22 ± 33%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     55.68 ±  9%     -16.5%      46.49 ± 17%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6.12 ± 18%     -81.2%       1.15 ±116%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      7.91 ± 27%     -39.8%       4.77 ± 24%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.73 ±104%     -99.1%       0.02 ± 44%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.56 ±  2%     -15.3%       3.86 ±  2%  perf-sched.total_sch_delay.average.ms
     26.64 ±  2%      -9.6%      24.08        perf-sched.total_wait_and_delay.average.ms
     22.08 ±  2%      -8.5%      20.21 ±  2%  perf-sched.total_wait_time.average.ms
     13.50           -12.5%      11.82 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
     15.61          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      9.72 ±  4%     -15.7%       8.20        perf-sched.wait_and_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     15.17 ±  6%     -21.9%      11.85 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     11.74 ±  2%     -12.5%      10.27 ±  2%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.39 ±  4%     -13.0%       9.04 ±  2%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.06           -15.7%       5.95 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      2317           -49.6%       1169 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      1488 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      1953 ±  8%    +347.2%       8733 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      2360 ±  5%    +251.5%       8296 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     22781 ±  3%     +16.7%      26578 ±  3%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     13753 ±  4%     -14.8%      11717 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_stream_wait_memory.tcp_sendmsg_locked
      6038 ±  2%     -12.6%       5275 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     71.60 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     53.03 ±  7%    +140.7%     127.64 ± 45%  perf-sched.wait_and_delay.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
    435.94 ±122%    +263.3%       1583 ± 27%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    987.24 ± 22%     +59.8%       1577 ±  6%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.49 ±  4%     -16.2%       3.76 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      6.77           -12.1%       5.95 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      4.89 ±  4%     -15.7%       4.12        perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      9.97 ±  9%     -24.0%       7.58 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      6.82 ±  2%      -9.6%       6.17        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.75 ± 18%     -87.3%       0.73 ±113%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      2.01 ± 14%     +38.1%       2.78 ±  7%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2.38 ±  7%     -12.0%       2.09 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      5.50 ±  3%     +24.4%       6.84 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.59           -14.7%       3.06 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     26.85 ±  6%    +311.9%     110.60 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      6.12 ± 18%     -81.2%       1.15 ±116%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
    985.54 ± 22%     +59.9%       1576 ±  6%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2411 ± 57%     -74.1%     623.65 ± 38%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     17.94 ± 19%     -38.0%      11.12 ± 19%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    249.22 ± 28%     +48.9%     371.19 ± 16%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


