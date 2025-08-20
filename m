Return-Path: <netdev+bounces-215142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE00B2D2F1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3775A3BD0F9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BD23E32B;
	Wed, 20 Aug 2025 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWLdQsct"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6C1F3FED
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664062; cv=fail; b=FlBk5zxxOKhVPZTkczXl2ot2kgeAbSKTx6DRYnoQRk1dd5yLUzjBp1SfNmumta2uCorZJ4k4TrpZkzD4V/d0MuUG6k00uJvAL1UY9J00G27CXs8qazhFx1B0dq1rXT8vgewJ/xVpGFt2TXTcafFPHzdaVrZt9lRZ0r4sC8h2MDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664062; c=relaxed/simple;
	bh=45a6C0Tu4FeGeQo1FLef8JTYcPTiBSRDnPrL4kRIymM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iAtL4HtEm8VB2heOqrQVCRMJ1pnnB9WJvGzncazscT876YOQpmUZaJ51fwyfePi31C3Fsv+kEHrnkCw1tTlzUdPhDHcHW32yP1h/ySaUE7L1LIT/r7oGDk6aGz+JTJeO9nTSwyC6UXrrLDaLC/SXS67QMfW6IvIIa1DKLbMP33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWLdQsct; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755664060; x=1787200060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45a6C0Tu4FeGeQo1FLef8JTYcPTiBSRDnPrL4kRIymM=;
  b=cWLdQsctF8Cysym+ufvW/Zq86i9sf+CqBlK2t/izz04d7ErdjqXPrP9y
   gW4tSohnPaMoWId9/Z1P80Jkmc3xl5b/FOATp6l82jRkYbh/C9Y7XD54b
   5aXc2i6v6rmhVB4MFqb1XnboiLy9orBRwJYMpaj3HWnoHOOjjyCLHm7tX
   +3neY49r5UjZjgnWPuEAOcT3mLVGaLdDicp3uXYxXx8mE/V4AdgKU3Cjy
   4wMCoXSKO1XuJUOPhDQWpX7g7KW9l7w+6+o72Yy+vEDLcyZvNAc8pgf5E
   BpGdRC6Mi0+nbtU/S0ooKvaQeLFDbbWt7B/BLKJtTRemk00DRrlBf48sT
   w==;
X-CSE-ConnectionGUID: Wo/G2xDZS3y/02W6cIPgfA==
X-CSE-MsgGUID: dZGPbz5XTuOttPLukFoKCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61737445"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61737445"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 21:27:39 -0700
X-CSE-ConnectionGUID: 4+l7FmlOTdWeH8BSp0piiw==
X-CSE-MsgGUID: ZJYIZVJER0i8l/vD9Jj68A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167210268"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 21:27:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 21:27:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 21:27:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 21:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGcH4K/ggqF862vFmLTWrF1Zpy2yyE8zj7BovJbRFxtGi/mddyQ0Hpcvj+/M7IliBv2eVtgyf+zlcgUL0dB2Gi/m1TXTrOB26jD56XPkOx8TeYc3U5wd27T7ePdWMja+EDeOW9SNIEvgCzbxKMGOLUM05ac3UKXuvs3aqRg42O5FFIe73PkLZZxlR9yqhetOnzNbfSGURT2j1gtJXg+5Jd/INsT+DnR3ufnPy4XAudxvkJYhWEjFiYPovwP2L9QuNWI46ixqVjaCm2C+tSWo+aLfWvUwfE8QtS93p/qqNKhfL8c7iNF31AEdUE+9UzH57vTgWo5ZdtZ+9CuSnJcDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45a6C0Tu4FeGeQo1FLef8JTYcPTiBSRDnPrL4kRIymM=;
 b=BVlUD7F1SNc2WbKiQ10wAIFgmGzdBXVmeoynkK8/e6LM1wrbXnyEu5lCOCEFea7ATmGs5n01N5x2Tuv1hxmN2VKOYwExcrV4seB4NB5/hOF4hOfc2RdllhWAHU2l4b3PnItY5P3EoBuIkRtQCDSVlpA5fsWzOvUr6Wzyt7lKXi09zDyJJN7Ps8rrr1oYZKIvkZkOmhz2xyfoARa4YkV+nwnfx6Y/+M5S3QL/U5i694Zc1BRvT3Z9uV5F8xzRod8GxOtwVtN6zQKeXM0x1GPy2Z+ifYaJ/ne529b8IrIq609ZA+MN/gXZMFX5/Jjzv88OnO62XhnS9Jt4iNSM00YEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 04:27:35 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 04:27:35 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>, Brian Vazquez <brianvv@google.com>, "Willem de
 Bruijn" <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next] idpf: do not linearize big TSO packets
Thread-Topic: [PATCH net-next] idpf: do not linearize big TSO packets
Thread-Index: AQHcEHqv68StrpTUo0SeFjWhn1GLPLRq8XzQ
Date: Wed, 20 Aug 2025 04:27:13 +0000
Deferred-Delivery: Wed, 20 Aug 2025 04:26:16 +0000
Message-ID: <DM4PR11MB6502871B0C99047AC76827BCD433A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250818195934.757936-1-edumazet@google.com>
In-Reply-To: <20250818195934.757936-1-edumazet@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|CH3PR11MB8186:EE_
x-ms-office365-filtering-correlation-id: d8e371fe-3a4a-4fdf-f710-08dddfa1e348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TkJZOXNNRWhXaVdEOVB3Z0UrOHZodmVPNGVpZ0M3MjNiejA3Z2pMZlhtbnNK?=
 =?utf-8?B?Y21PS0JEa0RHa3dZemx1d0xoQzlrVS9ZUjlNcXJ1bDFNaSt6cUxFUnlLNG5M?=
 =?utf-8?B?ZUtmNHZCSFhIVDhzWHRGeDFLZzJpUzVuWjBUbkVlck9qbHVTdVVwa2xGbjBK?=
 =?utf-8?B?ZWRhVExRS0tRNTI3Q0Z3K2U0MHdoRFdmZWxRaDN6aWdUbm1rN0pEK2ZPQThT?=
 =?utf-8?B?YmxIVldTMTBvMTJIc2xRNk45SVNSUEJMNm1jdTRsZGk5M1RnOWJtRDZpWWlm?=
 =?utf-8?B?SzMxQ2tmcU1QUXV0UlVTTEkzK2FxMXZldllka08ydERvaGpyYUEzQ0pFajM4?=
 =?utf-8?B?MHBOM0s5SHFJdFZHS2ZEbi9md3pjdDFCZTM1L3pib09vWVZmQlBKTE96Wmpr?=
 =?utf-8?B?NXJaNExkUC94Zi8yT09vUUx3K0JvRk12YXZXWGhLUitwUkp3Y0JyWDVaRS8r?=
 =?utf-8?B?UzV1RXhtbW5vT2JmaEtFZ2xvSm5QT2JSYjhOQUk1YU9DVGdNaUFyZlpLdmIv?=
 =?utf-8?B?UE1HSjlBNk1XTFg3QVZ0dWpJTUo4ejAzT2ZQd3NJaFBPMGxpREtZZldod1dS?=
 =?utf-8?B?NzN2eFlEZ0JubW53bzhIeXB5cG9GdDY2bW9hdlduSlVPcTIvSVdkR1FaUnZK?=
 =?utf-8?B?K2ZNdjIxaFowWHdUeUloNStEYVFackFlSnFCTDAzR0dvdUJKSDd2UmZQakow?=
 =?utf-8?B?cml2akE3SXlwMEgvbkNITHdqWE5PMWczU0ZPbk1vMVVaN1A4VWRzKzNRVkRG?=
 =?utf-8?B?c3BWNFdkWldlV1pIZmNtUU9FVlpEczlkSi9wVVptNTRYd2hkaG82ZWVlSjEy?=
 =?utf-8?B?YzV4ZThQbVNnSmdLMnNUaDdEYUpsM3UvSDkzT0ViVHJVSXh6THlhQXRPRUEv?=
 =?utf-8?B?YkFTMUg3Qi9EdzlxbXpOYnJOU2tndVU0M05xam1xYkR1SjhwcmNteWs3MmhX?=
 =?utf-8?B?bExDcVhkOE9nZ1IyVHpxK1c2SEhVTHlQOFh1WkpRZVNGK3ZGcSs1OE5oQzVC?=
 =?utf-8?B?NUlIWDJlT2hhUmNpNUpvM210UTY3SlBKenpiN1M1cEpYTnh1Q0VUWFUxVjRt?=
 =?utf-8?B?OVYwcEpKUEZUNG9rNDR0KzFPVW9xcU9WcnBySzNBdTNYY0FiNU1LSG1SRW81?=
 =?utf-8?B?TlMrWTF1cFBXdEJVSDMvZndNc0RoUjZuOEg0OXF3c1JkcElFSHArMmRTa2Va?=
 =?utf-8?B?Rmp5Uk1tY3dWMlY1SCtYOU9ZZHhDZWJZRmdxaFp3azd5c24ybmFOdHdaUFhR?=
 =?utf-8?B?SEFhL1J5RHBwRFpYMG45bjBQamsxcUJyODRJdkdvWjk1V01pRkE4M205eTM0?=
 =?utf-8?B?YnZqeTFkOSs3RXhrUnBpL0ZPY01FTkZxNmV4K09nNklYbmNVTllhQUJIR0hI?=
 =?utf-8?B?di9VNlo0OWdnK2JPYmZwaHB1WmljcmhtcDd0UWxvWkNteHgwM2N6bDBhMWZG?=
 =?utf-8?B?TGRoLzJobkFhZzFXNkVUMlUxQVM2cHNwSkRlbFJsREV5RWw4RFJEbENRdkgv?=
 =?utf-8?B?b3ExYVdFZDV1VjI4ZnczMnVlWlJiaWJMdlArdGxaMXM4aGdoRFhZbHZrblN6?=
 =?utf-8?B?cmRYY2l6QjdmQUxtdG5aSVFKQzFtVEVHaVdRb0pVK3VOQ0w4NGtUbVJpU2FZ?=
 =?utf-8?B?Ym1XWHBMODRxRGdNNEZCcGl1T1hjejhzU3I5SGIyenE1dGdwYmpreU1WNVBX?=
 =?utf-8?B?VVQ5Vzl3T1Vwa0dqb25HaTBoUzE5RkhxbDVKZUNtWlBZVkMyRjhJcDU2Vkc4?=
 =?utf-8?B?dkc2Mmk3OWVsY2oyUlk4UDhmd2k3aFVKSlhKclQ2Uk5yeEoxZTgzTlNtS0k3?=
 =?utf-8?B?YWw4cnl2R0NUTjFGRDBoVzdlM0pFRkt5V0krVEI2ajU3aVh2NFREUFlQUG1k?=
 =?utf-8?B?Q0tKT2dHR0s4N1ZsZkVNSVJ5RDNPVFhSSlVHZW9KVTlPK1o3ZmZLbGt1Uzgr?=
 =?utf-8?B?L1AxMExoNzMyWFFPMlVYSlF6bEVOcGlLczJWVUdDQTIvajNwcjVYTFVSaDZn?=
 =?utf-8?Q?8/uyjGo5vzvTgnyHg7FencbhuRpJPQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHNQSTd4azJjZDdnQzBaeHBkbFVTS3NBdG5LTmo5a0hJdVN3dzB6T3BuWmNJ?=
 =?utf-8?B?N0JOa2Z1dW5sR2xZWTdIN1U5T2dVMU5DSkZMZVlndjVuYjFjN1FYa3VRSmtk?=
 =?utf-8?B?Zm9uS3NPYWhYTm9KNHRyR3BUWEVreDkzcXY3SlRaQ3MxMnJOMkZwZXJhSlQ3?=
 =?utf-8?B?RzlhQU5WaUFjTWVaTFgrL2tyTjFqNDdvbXNCTDJYWVFCcVZjQWtMR1pPWDQ3?=
 =?utf-8?B?OUtua05qaWFQUStRdGppa05nMlI3NXRKd093cVRVSVExZzlkTkNrTmRmcW03?=
 =?utf-8?B?eFdQdFFWb0FVdWpHOU9lM1pBRThScCtGcElqQlNsUGZOOXZkMmt5TWIrWncz?=
 =?utf-8?B?OHFaRU83dVNsRGhEQUlIRmJEZFFwVm96U1R4ZGFkaUplMlE5RXgycmhCSXc1?=
 =?utf-8?B?R0VEVHUrcERoMit2a0VMSnpoaXFidklHTTlOeEIxbURUNjNpNjZ3UUlEU0ND?=
 =?utf-8?B?dVF1SUJPUzZVWjNpallEZmpUa01FY2JkQjNjL2pKRUNYaHZZamsvRmVhR2xx?=
 =?utf-8?B?Uit4dGt6V25hRkJUMkI1RlZuNlgwbjl1Y1hvRXNUVU1tcmNlZ2xpSlBxbGVZ?=
 =?utf-8?B?YmRjVFlqM2pnemRnNGVoMUJOMTFFMFlIUlVUV2RRVGRxNHdOV3JMcGFKaG5O?=
 =?utf-8?B?eFpYWk9xcGovMWpHK0FHdU85ejl0NjBiNE9LOEF2MGEzZ0VoNTM0Y2w0TlRE?=
 =?utf-8?B?K1dpMlJKN2MwS1hGTldWUnk0cVdTN1pXSGJnZ2pxYmxIZS8vajcyT2YvWkh6?=
 =?utf-8?B?a0QvTE5IMGhVSnhhWXhyOElUS3RNbDAzRjUzWkpIVVd6bzBTUm02WXlzL2hO?=
 =?utf-8?B?TndZdDJmM3lPdHJLM0k3YktuZDZhZVdiWDVHQUd0ZWt4NUhwaDkwK3BuNCtq?=
 =?utf-8?B?RWRCZmo1N1lDT2VROVc4Ym8zWG84TnZudlVDYlJ3VUU0dXFBUWw5bktCS0R6?=
 =?utf-8?B?QnFkSUgyK0psUkc2MVBmcHNmcHVGWGFRYkR3dWZXNlRjNDdhUlBwOCt2ZGtY?=
 =?utf-8?B?cEora2hmWEhQR0FocThCQ2NuUXZmL3RiVi9Nbm1lbWJlVlVKZFlwdFR3WTIy?=
 =?utf-8?B?QXoyenViVlM2VVV1NUFKek5HanpWNElEa2ptdnRheTR6U2tvaHRQbW5mclgv?=
 =?utf-8?B?cXhlZjFIK2tVa2tibGlxLy93M2ZKK1gzRlBGNGRUMlVVSm13OG54NXhxeUk1?=
 =?utf-8?B?NUpLUGFESUlKR3JHSEt1TzFPUXlIT2txa2hCNURQK2Z3VTZwczIrTzlaSjJ4?=
 =?utf-8?B?QXBRN2lqbE9LK3Fyb04vM0g4OXAvZG9FWkNHZ0Y0eFV1YWgzTE4wTmpxZUI1?=
 =?utf-8?B?UVF5Zm5jYmhLaXBIM2lxbU4yTFlQMjV0MThEa0VIUnNydU9Bc1pVNWF3aHJz?=
 =?utf-8?B?ZGVlekgyVC9nV25yN0IyYVhTZHVmblM5SmU2OHRsdUZIbTd0NkY2dEFrR285?=
 =?utf-8?B?Z0tGQmxGZk5keTY2cUpVdHMwM3F4OTB4bEZvWU9VYjVUNWpJNEFCdUhVMHNt?=
 =?utf-8?B?d0dXaVVQS2lsUDFlSE54TVdlNlBvR3RuYWpIQngvaUVuTzZ4dlNGQ2dGSyt2?=
 =?utf-8?B?azdzamNkS0s1SFQvaW1zMEIzcFplYTF0M21tTHY2UmxmSWFIcU92WnFVZTd4?=
 =?utf-8?B?Zk1oZ3pMclJlMUNRcHp4ZmkvUUh6MmxmcXdUMUdNMGNXbzZrNWxObkQxNXlU?=
 =?utf-8?B?QUZKMUswWk1KNHAzUUlQdnJ3eXBIa3dUZnROcVpzZmhRR0w2TURjZ1hQWUdm?=
 =?utf-8?B?eU1tQUdiYUppNVJONktzL3RlUDNqQlhqU3FTTjZOcDVOb1ozVkZBdVkrenNY?=
 =?utf-8?B?aWFMUzdsbXVKbW9PU25IcURuaWd2OVplb3pvd0JBV3NNeUpsWldyK2dleG1p?=
 =?utf-8?B?YjNBN0tabHZMRVBwRGJKeUM0eDBzbTIwR2tDbU04cWlPK004UDFtMnZZdytN?=
 =?utf-8?B?WEFVcTNCMHZNNmJDNEdkeWJwY2c0YkRCMW5HUzRjT01SUmg1Mk5UbkxGdEkx?=
 =?utf-8?B?TW5vRmpvMlhDYm5IR1U1bGUwM25keUFlRDFiTXNrYjVnZ2tYZzdPVWlKa3hX?=
 =?utf-8?B?UnNXWjFsMXZLZFJCYWlmdUlEWThsZmpLbXRZV3puQWY3Rk43VFVhZEc5Nmhk?=
 =?utf-8?Q?D/WIBa4Fa24qbx03NXqcyANOo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e371fe-3a4a-4fdf-f710-08dddfa1e348
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 04:27:35.2098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJlRzKe1nJAzEYa3vrflmA7u+6NSLu0WOuIlouooASBMktrTnBqkUQ8krzkEq4Wta6RQSu3b+rOr5mGcoQmFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-OriginatorOrg: intel.com

PiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IA0KPiBpZHBmIGhh
cyBhIGxpbWl0IG9uIG51bWJlciBvZiBzY2F0dGVyLWdhdGhlciBmcmFncw0KPiB0aGF0IGNhbiBi
ZSB1c2VkIHBlciBzZWdtZW50Lg0KPiANCj4gQ3VycmVudGx5LCBpZHBmX3R4X3N0YXJ0KCkgY2hl
Y2tzIGlmIHRoZSBsaW1pdCBpcyBoaXQNCj4gYW5kIGZvcmNlcyBhIGxpbmVhcml6YXRpb24gb2Yg
dGhlIHdob2xlIHBhY2tldC4NCj4gDQo+IFRoaXMgcmVxdWlyZXMgaGlnaCBvcmRlciBhbGxvY2F0
aW9ucyB0aGF0IGNhbiBmYWlsDQo+IHVuZGVyIG1lbW9yeSBwcmVzc3VyZS4gQSBmdWxsIHNpemUg
QklHLVRDUCBwYWNrZXQNCj4gd291bGQgcmVxdWlyZSBvcmRlci03IGFsb2NhdGlvbiBvbiB4ODZf
NjQgOi8NCj4gDQo+IFdlIGNhbiBtb3ZlIHRoZSBjaGVjayBlYXJsaWVyIGZyb20gaWRwZl9mZWF0
dXJlc19jaGVjaygpDQo+IGZvciBUU08gcGFja2V0cywgdG8gZm9yY2UgR1NPIGluIHRoaXMgY2Fz
ZSwgcmVtb3ZpbmcgdGhlDQo+IGNvc3Qgb2YgYSBiaWcgY29weS4NCj4gDQo+IFRoaXMgbWVhbnMg
dGhhdCBhIGxpbmVhcml6YXRpb24gd2lsbCBldmVudHVhbGx5IGhhcHBlbg0KPiB3aXRoIHNpemVz
IHNtYWxsZXIgdGhhbiBvbmUgTVNTLg0KPiANCj4gX19pZHBmX2Noa19saW5lYXJpemUoKSBpcyBy
ZW5hbWVkIHRvIGlkcGZfY2hrX3Rzb19zZWdtZW50KCkNCj4gYW5kIG1vdmVkIHRvIGlkcGZfbGli
LmMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNv
bT4NCj4gQ2M6IFRvbnkgTmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT4NCj4gQ2M6
IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gQ2M6IEph
Y29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBDYzogTWFkaHUgQ2hpdHRp
bSA8bWFkaHUuY2hpdHRpbUBpbnRlbC5jb20+DQo+IENjOiBQYXZhbiBLdW1hciBMaW5nYSA8cGF2
YW4ua3VtYXIubGluZ2FAaW50ZWwuY29tPg0KPiBDYzogSm9zaHVhIEhheSA8am9zaHVhLmEuaGF5
QGludGVsLmNvbT4NCj4gQ2M6IEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT4NCj4g
Q2M6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4NCj4gQ2M6IEFuZHJldyBM
dW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6IEpvc2h1YSBI
YXkgPGpvc2h1YS5hLmhheUBpbnRlbC5jb20+DQo=

