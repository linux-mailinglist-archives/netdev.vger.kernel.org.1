Return-Path: <netdev+bounces-99867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044B8D6CA7
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224ED28B013
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D0811F7;
	Fri, 31 May 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giK4Xy9G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D2381BD;
	Fri, 31 May 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196606; cv=fail; b=hVy/mdUfZsyellzMs973wFO7iw5CyriOOJNXh10DJwjTg4ezaX/4LTSmVxeArxWfF3bFmIi5J1K8TdKVG04pAxryMmWhX0SSow77SiscAtIccaZnpsICzrGValZEJCOmgBM2JfYjcXTaLQOWIxn/IirJCEIdvMM5q0IU9sfPqIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196606; c=relaxed/simple;
	bh=PAQeCpoO0vRnfvsNcn2d8Gee3vemeR5OFTHtxazS0dE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TzidnLwcmLmGXoXdzGZCQc51FwPLVwS1TiUuqXEDwR2QV5uB01R6msWMsxaTyYqb/Hoee9SsHgZ7kt7/N097nkKnpf0Cu89VPtmUgsu62cnM3HQy2vcHFt8jXKc2Fc9t/rE+ADhl92qveK/mTozerQ+d+bJVQC5vh6PeFb1Gi3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giK4Xy9G; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717196604; x=1748732604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PAQeCpoO0vRnfvsNcn2d8Gee3vemeR5OFTHtxazS0dE=;
  b=giK4Xy9GEdDB221ZYeF3KgZ+eDfLocDrz6f5NIWiCutu+4cqEOHAt3ar
   Eh8E30jnH7nvB0IFy2W06VWZc/5/e28fA06LzvzkiTS3Noavto/R1FQLK
   RBVLtwxGMNKVVlIXC8JtXRdNPEbUYhfngvfFxZza1vzrOVr2aqfdoDCsG
   MSMrpa2doiNmophA+0i24QCUJI+If9f3KuvcxabpDA8kCz8VYin3It586
   g7raGdY8omnN4hojiavBZwfvsMgPSiy5OhdCI4QhGKCe9tvqMeOefRUEO
   lPx7PGD1eJLhmbQU9qZuvmc7DwtTjb+x71qffKsAXVY2Sn9jtVUg76+gT
   A==;
X-CSE-ConnectionGUID: ngOSU0NSQJ+Zmm+a8V57Aw==
X-CSE-MsgGUID: uQDcvu+USWC9jgrx7Q6jqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13883512"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13883512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 16:03:23 -0700
X-CSE-ConnectionGUID: 7sTKw6cuTmG+n4lCll56NQ==
X-CSE-MsgGUID: 3Q+B5l6WQyCpzEfbfLFsbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40743561"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 16:03:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 16:03:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 16:03:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 16:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwrFYpw4Vrd7XBuyFJxJ4y4y4LuwUBwthBMusAjxv5Iz0OKeUwPRA98Ik2UtdoURMWBonro2r9+ph3zUYYut0kyp8CO179h6gyTx9ttpFtuTINcATh5+Ot+WpsztJAcn+69uOF5Gq6DAjo66rMgEpdhcYqJJBIyU29subNEMCUbsr8Okfnax5jD2th3pwOa9UiGkg7FPWmz9AAbqckFWwF31N0Pztnq0TqZ+fV8KJ1eU/ywFgKVaGrI/5KZqkT0Fp7IzjaZI/bEKrjQDjZ3WCVYSFE3ACEKOBJGS0DkloMYMdLBssWglIBSt0GXmJ5HTggLDdLEYz5/ldqZr00tsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAQeCpoO0vRnfvsNcn2d8Gee3vemeR5OFTHtxazS0dE=;
 b=PPLBP0w5rRAET3s0efjKe63qjspmmDrH1R7xCyxmzccigjLXPs6YWIJ0pWmxR0czdEUxDZYJv1il3RkZJ7wH0orFcKVdDQ5g5GnG+tne7vHkiMIpacdYhRRsSW15jSEZVBVC84uGCp6BEc09BfilqdUSMywaQZOp2FqPKvkURJvCrpA0/MYaNovaBvRJbNvw1Ti7pxK9Eq+2htSzRsDuWqU/834e5Sp7mhy+kq2S7eF/kWWlCDRoZjiM3UiJO0GMzCb3qifL4JlYBqePKegH4ybJb0uoDftd71NAcJZ9Z4+zFEGgYZxW6+NFXoCbZJ9q0gUg+lpRmoccinhPYOqvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 23:03:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 23:03:19 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
	<danishanwar@ti.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Eric Dumazet"
	<edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "srk@ti.com" <srk@ti.com>, Roger Quadros
	<rogerq@ti.com>
Subject: RE: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
Thread-Topic: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Thread-Index: AQHasbhogAiH3qp7qUKOpTkQdurfEbGwF1+AgACqGYCAAThScA==
Date: Fri, 31 May 2024 23:03:19 +0000
Message-ID: <CO1PR11MB508975B409D7369CDC9AD89FD6FC2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-3-danishanwar@ti.com>
 <7143f846-623d-465f-a717-8c550407d012@intel.com>
 <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>
In-Reply-To: <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CY8PR11MB7340:EE_
x-ms-office365-filtering-correlation-id: 40bd1582-3119-4b0b-5704-08dc81c5dcb8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?anozYzRLd3ZHSmU4VVUwMmJGbjk4SDhnSE5VS1JLMmJKc3dyaDluWGRoVG5B?=
 =?utf-8?B?NitBTzVTQ2lKQkJrdGpJRmRhVW1QNE5lRVlLY3djdlFjNTYvRnZyUkNrN2NM?=
 =?utf-8?B?Z2pQdDdUTkNtQ3V1TzU5RmpGWFB5NU1oZ1JTSmhZNmpWUXl1dXlMWUNpYUhu?=
 =?utf-8?B?MXVrTlVjTnNkQWEyV3U5NDNwZWdvbjFLLytGaGIrOCtVWVoxaEJDRUF3Z2pE?=
 =?utf-8?B?S3lxUzZBYkpPQnBUTHNTcEdFYzhCVURSTklLNnk3ZkQ5bGxKYnUyWVRNSHFa?=
 =?utf-8?B?aVVpMVNSWVZBWTViQW1CVXNRV3VTdEl3UUs1T0JnQkFtVjAya0RhQW5QN0lF?=
 =?utf-8?B?UldWK29LTXZpZlRwdzVjVFJMQjZpMFJIUmUrK1dQNEYrK3I0T013WjRxc1FS?=
 =?utf-8?B?eWFMeEh0aWFISFJLaHc1cDd3TWwzYVdkQ09qUHJORHpPMU1TYU1QREF1K2Qw?=
 =?utf-8?B?aXFOZWdIZ0JSYm5aVEdHaE4xREltME00U2krQTZKaGE0Wit3NUJyY1R6UkhG?=
 =?utf-8?B?REZSTTVHL0lrK2dWd2llenpabDBXQVdFODVBaUk4ZUk4MHJrbXRvS2JoOG9Q?=
 =?utf-8?B?ZnJJMVpyY1dQSjRuR2JHUTVJQng2RWF0SGxlR3dHS2xRTWpNQitBQ0FvdHkx?=
 =?utf-8?B?LzVCbXJKSFhHaTdReE5oUCtjY3B6UFBqL1MrbWFGUloraVB2MEJuUWtURFBB?=
 =?utf-8?B?MnJvamp5YUc1YkRPRWpLTGcwYzZpYUM1NU9KQmkzWU0wRURMSFpsc1BIaFdM?=
 =?utf-8?B?clVHekpFQnNPb0ZNakxkdUc2VW9DUi81azhSZWlkeW4zRkNNMVBTV0pxSzBx?=
 =?utf-8?B?UWJFOWx6YzZsWHpNZGVTYitBUng2a3E3eDErWjZFZERpSThScGlMbURXYXRH?=
 =?utf-8?B?NDhEOFk1YzhncTBiNDRWYW9vRjJHVitUcUkrZDBqRy8wMHIvekFOQSsrZU1Z?=
 =?utf-8?B?a052YTBLVXZIYmsxaGhQZ3FxLzFqWFMwcFlUVFhSS0laU0NFd28rK3Rrc3Nu?=
 =?utf-8?B?NGt6NXJsODJqUTYxNGFnVk0vY3A2ZHFLSEpsenMwUmVJWkIvdWJXbys3V1A1?=
 =?utf-8?B?Zk51Y25IdjUvTEV1QlZGOWQ3M2JaZ1RSeDBRNHpwTVgyeGdCejNuT3dUbEhY?=
 =?utf-8?B?R3dTSTlxblQ1MXlybTRnaTZxd3Rqem1kMWYrTFVZTHlUV0FpRTlhTVVUaWdX?=
 =?utf-8?B?bVRFVTRRWDMycko1SjJPeWJKekxSQTdKVndpN2FLZ2lwK3dIWFhjVzRpRHUy?=
 =?utf-8?B?dGZLc2ZNVE42emROK3lEZWE0TzltOEZaNUY0TFRMZ0RZVENjRkIvRm1RcGVJ?=
 =?utf-8?B?RWdrSlJJU2FIU0s3Mms4bHZha0RtWDIrREt6cGU3aHZNa1E1cGVTMmpvRUM5?=
 =?utf-8?B?R29UUU9ZR3Q0dy9tSWVKZE1zVkgwVU9RVDhuYlBCUE96bmY3eVIzVWI3Wm9z?=
 =?utf-8?B?Tm1vaExML1d1SEY1UG8ybE1QMlUrazNjNnNaQllVK09PSitVQk5mVzhoUGRx?=
 =?utf-8?B?NnZuQ0dDUEQ5b21xcFZFMGtldnhYbmZZSmNTVHJaeVdWOFhNRHRhemxVWEdr?=
 =?utf-8?B?NysyVnI5WVhyT2U4aXpnNURBSUhnNE1qQkVCZFB4NEVxMzNKazROVmwrSWtt?=
 =?utf-8?B?TkNGY2Jkc3U4ajFNaFk4M3lrc1BmYTFwRjFHTVhlQ2RSSENwUkdCWmFCSGc2?=
 =?utf-8?B?T1lxMFdBdmZXNlpIYU9Cdm9XS05XZG1aSXA1UnlmQm1yM0pnZzJtaDRHT1FI?=
 =?utf-8?Q?dHuxi31BoQw1X9uUYo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVBMZ1VBY2JoeUUvcjdDT1IwYWhRY0lzOEI0TnY0b2VlR01IOTRyZmtNaitv?=
 =?utf-8?B?di96M2JnY0prU09NMmhxM2tiby9ld3QxYU15S25IVmxnTGRZUklQNW00a21B?=
 =?utf-8?B?VlJieFVvV3d2cmQ5am4rQ0lsbXRHRmcrMm5VVWkyMTFGSG0zZC9sNUtBTEpJ?=
 =?utf-8?B?aHVOaERmWjF1T25IU3FxUEh6NXQ0c1lIZzVpM2d6RVV3eTV2N2hJY0dBTDkz?=
 =?utf-8?B?Q25Id0VOcGtPSFBhbWU3cCt3VzV0UkFPbC9ZS1EvN294ZkVHR0J0ZVZBZTBs?=
 =?utf-8?B?R1NuYmZEQkVyYVpBb1RzZTBRTVRvRUhEM2pTMTRjbThYcmRmbUI5Z2xPWjBr?=
 =?utf-8?B?TStEaFB0aTlKOXFRZEJXU0NXcjBpQ1dOSUZkdStuQmhtZTlVYlhreTF5aDlp?=
 =?utf-8?B?bFVoQlYzd3ZyT1M3MlExMDlOTGljeTBIdUJ1bnpPKy9jZk5JT1R4TmlCZHV2?=
 =?utf-8?B?NWZ0cVRwYTdLeTBWV25UOHNpQ3lBRERlYWU3NjJubVY0OGFtZS9odHBPa3Ur?=
 =?utf-8?B?NHJKNDdIZ2FWMXJlL3pwb3ZZZjNSdWZrVTB4N1lpbERYYTdqcnZ0MTJWODNR?=
 =?utf-8?B?RXJxaHY0YklRYVo0Nk8rZjFvNWR4SHZwcWdQMFZ0V2tFTlVWVXhKOUEyZDBK?=
 =?utf-8?B?bkMrV3lodXduUEh0RHBqdTh1MzVDZThKa2xTekUyUzlRZitMNy90cTQwUDY3?=
 =?utf-8?B?WGcyV1dXTkJZenZ6cldQNUorZXlVTEpPSEEra2Q3TVU3Z0s5blBzMTFoVHdr?=
 =?utf-8?B?Q0ZidVNmRXhUL1dHa1prOFNXWjRmVkZpSy82ZkJLeXdqaDc3cGhUL0wvak0w?=
 =?utf-8?B?bGY0TjFzb1JYT1IreVNFUi9BYVl2bU9CUUx6d3NBMGREVkJwQmE1R1JTUXVr?=
 =?utf-8?B?TEhPcFNGOURTNVpFK3V3UXVrbkhKMFkvSnFBUEVFRmdBMFgxRnptSUM1bFhD?=
 =?utf-8?B?cWd2N0ZGTGFyNjVkajRWRDdxdk0rL2VaWDZrV1BTUmVZOVc2QWd1ZGlsTVlM?=
 =?utf-8?B?MllrcERUWGZmVFFOZTFQaGw0TzYzc1FQbGlyYzhLSnQ5N2ZNRytxWitJTEdZ?=
 =?utf-8?B?bE5wOW9QZSs3clcwSmNiSEpZTXdEVnR6N1hYQ0x3MzByWkRvN2xhdi9PVllm?=
 =?utf-8?B?MWIvQm1XWDRybzcwWWEzYi9xZjhVNm1MR1lnVGxsZjJKNjlQREdiZUxzRVpX?=
 =?utf-8?B?aDdsK0pUbGJQdTg0VSswWHA5YnNOcG51aW9TNTVtaW1EQXIwUTZLbVR6UUU4?=
 =?utf-8?B?VnNvMXZEdzFSdGN3NGdwVDlVZkJBckkyOXE3MEF2S2YrdXhXVVNOUEtXdXRZ?=
 =?utf-8?B?b3hRbFNPQW5yeDFXUGlUV0t3NW5SQUlBSGJzeU9YYm9iTFpyeUJiWGw1Mmlh?=
 =?utf-8?B?VmZCaVVVN0ROb1lSS3RlWTlTR3NTY255NUVKc0djejNDZlNNQXJFenhyUkVJ?=
 =?utf-8?B?RGd3OFpEQ1h0MGF2bEJvd0JBNEN4QktYNWFYdzY2SmtQLy8wbHRxb1Z4NWVa?=
 =?utf-8?B?eFNWUU5tNUE5bnIvV2Z5a2NtdExRZ0J2UDhxaEp0YW4yZTdoYlp2OXlmbmkv?=
 =?utf-8?B?UzArL1JOTElJZXZTNTFBVVRYbllaNzlabXptOUhKcDJVVkxNSUp1c3ZpVzZ2?=
 =?utf-8?B?M0E0d2N5eW1jdEF5Tm5CVGJNMmw2aTUydWNVRitHdlQ5WEVncTBwTHlBNWl5?=
 =?utf-8?B?SE0xRUh4NkJzMFh0ckcwVXg1ZzZPc0JESy9pRHJ5NEtGcU11bTN2TlZrb0NS?=
 =?utf-8?B?b0NGeHBJY1UrcTROMVZHSXJoSURRaW43K1FkeFV6VXl2QmZJZ2lGa05OTld3?=
 =?utf-8?B?TjRaRmcrWGhpSWVGSmU2TGpENHpobUxBTlI1ejNQbjVGOG5BYjJCd2R4U0Vy?=
 =?utf-8?B?L05vRzR0RmNKa1pDUWdNZjFmNERCRXdhZEk2V2JLUGZ0aVZJUlBSRk9HdytM?=
 =?utf-8?B?c0J3NDhPYWI4TlFlbitCZGlPU1RacTJhRGIzcEY3ZTZLdzZsejcrZkRScm9k?=
 =?utf-8?B?YzhDVFZEc1pTL3VTNE4wc1l6UVZuWENLRjRaZ29uc2FWTjdEbGJ3VW5XcE1N?=
 =?utf-8?B?c0tTSlcrVlN3R01BM3NJNUMyTi9RVS95b01tNUxDdUdQLytRV1Z5SjdGUDNF?=
 =?utf-8?Q?Xj3UvsJc8KOfpVjMqK2JJrf+X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd1582-3119-4b0b-5704-08dc81c5dcb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 23:03:19.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82Yb7inL9f7TEu/proXw0myn1n1ov9tyx051CZ3vOS7SR+AIECCFs5xaN2ccwvmb6HPptmvMVBzwblNb1q0VTFSfzfvb/1B187nT800Z/uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW53YXIsIE1kIERhbmlz
aCA8YTA1MDExNzlAdGkuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDMwLCAyMDI0IDk6MjUg
UE0NCj4gVG86IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTUQg
RGFuaXNoIEFud2FyDQo+IDxkYW5pc2hhbndhckB0aS5jb20+OyBLaXN6a2EsIEphbiA8amFuLmtp
c3prYUBzaWVtZW5zLmNvbT47IERhbiBDYXJwZW50ZXINCj4gPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IFNpbW9uIEhvcm1hbg0KPiA8aG9y
bXNAa2VybmVsLm9yZz47IERpb2dvIEl2byA8ZGlvZ28uaXZvQHNpZW1lbnMuY29tPjsgV29sZnJh
bSBTYW5nDQo+IDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT47IFJhbmR5IER1bmxh
cA0KPiA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPjsgTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBs
aW51eC5pYm0uY29tPjsgVmxhZGltaXINCj4gT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNv
bT47IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47DQo+IFJpY2hhcmQgQ29j
aHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsgUm9nZXIgUXVhZHJvcw0KPiA8cm9nZXJx
QGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBKYWt1YiBLaWNp
bnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUu
Y29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3JrQHRpLmNvbTsgUm9nZXIgUXVh
ZHJvcyA8cm9nZXJxQHRpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2OCAy
LzJdIG5ldDogdGk6IGljc3NnX3BydWV0aDogYWRkIFRBUFJJTyBvZmZsb2FkDQo+IHN1cHBvcnQN
Cj4gDQo+IEhpIEphY29iLA0KPiANCj4gT24gNS8zMC8yMDI0IDExOjQ1IFBNLCBKYWNvYiBLZWxs
ZXIgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDUvMjkvMjAyNCA0OjA1IEFNLCBNRCBEYW5pc2gg
QW53YXIgd3JvdGU6DQo+ID4+IEZyb206IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUB0aS5jb20+DQo+
ID4+DQo+ID4+IFRoZSBJQ1NTRyBkdWFsLWVtYWMgLyBzd2l0Y2ggZmlybXdhcmUgc3VwcG9ydHMg
RW5oYW5jZWQgU2NoZWR1bGVkIFRyYWZmaWMNCj4gPj4gKEVTVCDigJMgZGVmaW5lZCBpbiBQODAy
LjFRYnYvRDIuMiB0aGF0IGxhdGVyIGdvdCBpbmNsdWRlZCBpbiBJRUVFDQo+ID4+IDgwMi4xUS0y
MDE4KSBjb25maWd1cmF0aW9uLiBFU1QgYWxsb3dzIGV4cHJlc3MgcXVldWUgdHJhZmZpYyB0byBi
ZQ0KPiA+PiBzY2hlZHVsZWQgKHBsYWNlZCkgb24gdGhlIHdpcmUgYXQgc3BlY2lmaWMgcmVwZWF0
YWJsZSB0aW1lIGludGVydmFscy4gSW4NCj4gPj4gTGludXgga2VybmVsLCBFU1QgY29uZmlndXJh
dGlvbiBpcyBkb25lIHRocm91Z2ggdGMgY29tbWFuZCBhbmQgdGhlIHRhcHJpbw0KPiA+PiBzY2hl
ZHVsZXIgaW4gdGhlIG5ldCBjb3JlIGltcGxlbWVudHMgYSBzb2Z0d2FyZSBvbmx5IHNjaGVkdWxl
cg0KPiA+PiAoU0NIX1RBUFJJTykuIElmIHRoZSBOSUMgaXMgY2FwYWJsZSBvZiBFU1QgY29uZmln
dXJhdGlvbix1c2VyIGluZGljYXRlDQo+ID4+ICJmbGFnIDIiIGluIHRoZSBjb21tYW5kIHdoaWNo
IGlzIHRoZW4gcGFyc2VkIGJ5IHRhcHJpbyBzY2hlZHVsZXIgaW4gbmV0DQo+ID4+IGNvcmUgYW5k
IGluZGljYXRlIHRoYXQgdGhlIGNvbW1hbmQgaXMgdG8gYmUgb2ZmbG9hZGVkIHRvIGgvdy4gdGFw
cmlvIHRoZW4NCj4gPj4gb2ZmbG9hZHMgdGhlIGNvbW1hbmQgdG8gdGhlIGRyaXZlciBieSBjYWxs
aW5nIG5kb19zZXR1cF90YygpIG5kbyBvcHMuIFRoaXMNCj4gPj4gcGF0Y2ggaW1wbGVtZW50cyBu
ZG9fc2V0dXBfdGMoKSB0byBvZmZsb2FkIEVTVCBjb25maWd1cmF0aW9uIHRvIElDU1NHLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+
ID4+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IE1EIERhbmlzaCBBbndhciA8ZGFuaXNoYW53YXJAdGkuY29tPg0KPiA+PiAt
LS0NCj4gPg0KPiA+IEkgdHJpZWQgdG8gYXBwbHkgdGhpcyBzZXJpZXMgdG8gcmV2aWV3IGl0LiBV
bmZvcnR1bmF0ZWx5IEl0IG5vIGxvbmdlcg0KPiA+IGFwcGxpZXMgY2xlYW5seSBzaW5jZSBpdCBo
YXMgdGV4dHVhbCBjb25mbGljdHMgd2l0aCA5NzIzODNhZWNmNDMgKCJuZXQ6DQo+ID4gdGk6IGlj
c3NnLXN3aXRjaDogQWRkIHN3aXRjaGRldiBiYXNlZCBkcml2ZXIgZm9yIGV0aGVybmV0IHN3aXRj
aA0KPiA+IHN1cHBvcnQiKSwgd2hpY2ggd2FzIHBhcnQgb2Y6DQo+ID4NCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNDA1MjgxMTM3MzQuMzc5NDIyLTEtDQo+IGRhbmlzaGFu
d2FyQHRpLmNvbS8NCj4gPg0KPiA+IFRoZSBjb25mbGljdCBzZWVtZWQgZWFzeSBlbm91Z2ggdG8g
cmVzb2x2ZSwgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUNCj4gPiBwcnVldGhfcW9zIHN0cnVjdHVy
ZSB3b3VsZCBiZSBwbGFjZWQgb3B0aW1hbGx5LiBJIHRyaWVkIHRvIGJ1aWxkIHRoZQ0KPiA+IGRy
aXZlciB0byBjaGVjayB3aGF0IHRoZSBwbGFjZW1lbnQgc2hvdWxkIGJlIGFuZCB3YXMgdW5hYmxl
IHRvIGdldA0KPiA+IHRoaW5ncyB0byBjb21waWxlLg0KPiANCj4gV2hlbiBJIGhhZCBwb3N0ZWQg
dGhpcyBzZXJpZXMgKHY4KSB0aGUgSUNTU0cgc3dpdGNoIHNlcmllcyB3YXMgbm90DQo+IG1lcmdl
ZCB5ZXQgYW5kIEkgaGFkIHJlYmFzZWQgdGhpcyBzZXJpZXMgb24gbmV0LW5leHQvbWFpbi4gV2hl
biB5b3UNCj4gdGVzdGVkIGl0LCB0aGUgSUNTU0cgU2VyaWVzIHdhcyBtZXJnZWQgYW5kIGFzIGl0
IHJlc3VsdGVkIGluIGNvbmZsaWN0Lg0KPiANCj4gSSB3aWxsIHJlYmFzZSBpdCBvbiB0aGUgbGF0
ZXN0IG5ldC1uZXh0IGFuZCBtYWtlIHN1cmUgdGhhdCB0aGVpciBpcyBubw0KPiBjb25mbGljdCBh
bmQgcG9zdCBuZXh0IHJldmlzaW9uLg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0K
PiANCj4gLS0NCj4gVGhhbmtzIGFuZCBSZWdhcmRzLA0KPiBNZCBEYW5pc2ggQW53YXINCg0KSSBh
c3N1bWVkIGFzIG11Y2gg8J+YiiBJIGp1c3Qgd2FudGVkIHRvIHBvaW50IG91dCB0aGF0IHRoZSBj
b25mbGljdCBpcyBub24tdHJpdmlhbCBiZWNhdXNlIGl0cyBoYXJkIHRvIHRlbGwgd2hldGhlciB0
aGUgbmV3IHN0cnVjdHVyZSB3b3VsZCBmaXQgYmVzdCBiZWZvcmUgb3IgYWZ0ZXIgdGhlIG90aGVy
IGRhdGEgYWRkZWQgYnkgdGhlIHN3aXRjaCBzZXJpZXMsIG9yIGlmIGl0IHdvdWxkIGJlIGV2ZW4g
YmV0dGVyIHRvIGFycmFuZ2UgaXQgc29tZXdoZXJlIGVsc2UgaW4gdGhlIHN0cnVjdHVyZSBlbnRp
cmVseS4NCg0KVGhhbmtzLA0KSmFrZQ0K

