Return-Path: <netdev+bounces-254714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDmAus4e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:39:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE40AEEC9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A81D530A1FF4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75B385526;
	Thu, 29 Jan 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWr4lSkt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A43816FC;
	Thu, 29 Jan 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682861; cv=fail; b=VSkxJAN+4UNl4L5+6x+qn6cBDm1dGZL3FCsiFi8nH+zAvLX42lUVK6AK42EeiVAxWLydq+IFl1azs9UQfwIoUW8RvI+r1Pqqo17OfYpGGtG+oXxSypK4nZRprD2kQhUc0mi5depi+meglispUOYdS/CABiIkt5v6kpBkz6S0q5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682861; c=relaxed/simple;
	bh=lI0EdsS/Ube/QkV/doUufOJJgk/GN4jaLsOWUqXgQlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HATwetmx+Oz+He0a+imEy2ml9Ms4uvuh0qlp5cQs54ELwlGBe3KrhJtV9czHHiYvp80pNt/02aGCaN6O/Pu7kRBNov4I+slfo0fbY+5OaPxkjaAkZ+NvZjpDxu5aLBXVg5/Ek5S6BFryct1V5QlVDB9dgmB7qN2KGm6NTdRH6fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWr4lSkt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682860; x=1801218860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lI0EdsS/Ube/QkV/doUufOJJgk/GN4jaLsOWUqXgQlw=;
  b=GWr4lSktro4j0EQH5YvHFijcdiA5BTdAsz1LcbhZaFVGfR3J+tTLhKtF
   p3CWbGRIkCD9fZm1OUjKdxgA0KgZKdoLagHFtbzViyBKOtHBmpCPMA7JC
   5chcNNoxFHQxLYs1oqAP1n0rRCWL4j4mSMD/w3wtJB7B0YorlscTCpQrq
   3Tb5pv0bfq4K+wP0nCCPTosCE2UvtSUueW5CaBJ0lkp6c5Yi1ISd/jDPZ
   E8JALVKmQYMtO08Ulbaz4In0ukkzaFSjSM+5rUIde4JQrg2BDRQOc9ReO
   iw3NdPrU/5F0elbbEtwS7FAv81FHkR0S1ql0TYkPPX+qSvXe3Q4BSgjlz
   Q==;
X-CSE-ConnectionGUID: peQeDTtEQriQRKMPtcpNJQ==
X-CSE-MsgGUID: N6/frgYTTy+QwH4vlwrYLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93579051"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="93579051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:34:20 -0800
X-CSE-ConnectionGUID: AwgFG5e/SfiHfXbzcPJfJw==
X-CSE-MsgGUID: fhlXCC7+RZynadvsM9bN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="207658036"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:34:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:34:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 02:34:05 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:34:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+SNJkiew5t+TtDYxenMeZbPbatHLR7GSEYpbm5e39ILhNn8hngxpSLsWND+eHHC6S88z4zzSJ9Q/6bXNrjajfVK2jRNzQuQbGPD72w16tVYUBngznKXlUludIl3BYxQj7mjJ+Wyq2k0K5ORcsIjrBRYLg03zUbaY1pnvQaOh9yiPNXYl1X2YfYXksVz6ezNVEqayyh4laGP6tZRr9gQcOQVCjS12i+UVoZLEZ2jyQmtOxjLBwI8VFp/4mAXDb+kght1BpWez8fAMu7nu0cewZr/R1/xaUeveb2IoWUx6q1sFWRiVmKcuSPIL+irvqO1G45VL/TpmoQfBH3borff8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI0EdsS/Ube/QkV/doUufOJJgk/GN4jaLsOWUqXgQlw=;
 b=IaxvlR9vA/onxudDryx1NC+sdM0lQektgcBc0XZ6Kuj/fc8TjLAcBXaJ4aTlL837zQi9cR3K0VI67JgwALDeaLg7W79sXMspWbjIPklZvLJ4mX3SAI2ClRSvU1ddVX9yAzbRLFaUsLaAMfy52Ebb/2j8UpifwM3M6R/NzB8RbOxFHsn3+k6H9Y0B9ljvac798nui0SlRT7Yn9ABE8Za9TuT5pKtlOTKYZShi0Y//8dN3bTZO3KjEIOnutO32NLp6Ztnl13HqTqHJTbSGKSotLAdt42+izlyX7VZHGVdxUw+uhX54DpiKckww071zCqauqjDiPM+vEBNYymG8hxhBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:33:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:33:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 25/30] docs: kdoc_re: add a helper
 class to declare C function matches
Thread-Topic: [Intel-wired-lan] [PATCH v3 25/30] docs: kdoc_re: add a helper
 class to declare C function matches
Thread-Index: AQHckPac4aDehX8PAESasIn77jYTVrVo85SA
Date: Thu, 29 Jan 2026 10:33:54 +0000
Message-ID: <IA3PR11MB89861562F92C9FE6194225FEE59EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <9d3d27d956b25921cf40410e59a17a86caef32f6.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <9d3d27d956b25921cf40410e59a17a86caef32f6.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: 4faf7d1f-f360-429f-d728-08de5f21e6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Vm9RTW1Oamh1MHorY3lZL2RQMzVhcGdEcTYrUGcwdThVbVRCb2NkTWRmb2tl?=
 =?utf-8?B?ZTdxOWlEbE84dTllSDIwRytURkc0MVlYeUpQb1p3bHZEWWs5WU1VL3Q4UGpN?=
 =?utf-8?B?K2NTYXljeTllTmtpOUJ2clpOdXgvdEliYkllQ0tOcVM0RmNDeERhL29la29m?=
 =?utf-8?B?WktCVzJHYXQ2RWJKZGd3UWhvcUlRdDExVnFvWVk4WTNrTXhwdERHOVM4N2Vu?=
 =?utf-8?B?aGM0eWIvLzJQdVRGdXFic3hKR3c4RmNtWExrTi9xTXFLZFU2M2xqOE83TWxL?=
 =?utf-8?B?L1ZxVkptMld4VldNNFVkUENkcS8yQlU5elcyMHFtT2N5OUFJd25Sdk1zWXFE?=
 =?utf-8?B?UnRNM0owNXRFVXpwcXkvVzVyOGhXVjRYVUJhY3d1cVFKMGtpZVV5UnQySjZa?=
 =?utf-8?B?ZmJ1T2kzR1YvRWE0SGVEMW9oaVN2SXNydVVrNitCQ3pxVHN6cURKMnA4aTJD?=
 =?utf-8?B?L3lQZVFFV2F2VmdHaHc4d2tKeDZjNUdQajdMVEdGRW1vRzV2L1doVU9tZVJP?=
 =?utf-8?B?TWZFaUl0T0p0TndVZ0czbzIxbGc1djNFb2dzU05iQS9TYzQya0JEWmgraW1U?=
 =?utf-8?B?REUvQkNaWXQzQmthajloVUVoL0NxRWo3dHlzMHlSOHdUc1h2Y2d3dTFpL241?=
 =?utf-8?B?MER5RXIvWVRuYmhiVFFrVU5JOHRWSlRyVFlZYmRObUlpNnhjRjB5dE51R3Zv?=
 =?utf-8?B?a280SmxKQkgveEZjZUZXSHFLR29CcFdqbjNBWUFadmdsRThtNEsvbXVJNzVz?=
 =?utf-8?B?Y1l6NWlneVhkRUs3RHpwRzVCV0N1a096ZHJRZGlHdWtiblJPVHdzV0hqNENj?=
 =?utf-8?B?Q2YzZG00OXRZUzBjdS9YZzRWSHN0Z2tNZVUvVk9Bb05xdnBKY3hzUnU0dXgy?=
 =?utf-8?B?OUlLUlQ2MnphYnMwUkRTdWZDQlB0WlJBMjcxRVN0KzE4Mk5mcFdiU2M2U0Rx?=
 =?utf-8?B?RTFObmhJRWVQb24vSko0QVdvUXBaMDFzR2dubmo5T3dHbURvajMvTnl5YzBp?=
 =?utf-8?B?Nmh5N0Mwd1VtNGppUFhYcnMzeDA1aGJ1STVUUmFsV2YrZHI1T3VrbkV2VzFY?=
 =?utf-8?B?dFBUaUhQU2xaTSt6d0pwV1h2aTY0Q0N1dVl1dmpKQ1RzVzRGckZCdGFYeE1R?=
 =?utf-8?B?Tno2RUNMTTJpa2ppZGxDMlhzRnE4OTA1bFh0eHZwUE9ndnVTVDRkd3VsazZJ?=
 =?utf-8?B?TlVKNUIycjA1THROQlhHY1hyTy91M0ZMMG8vMWtkb2ZFMTFmR2toTFdVK2tw?=
 =?utf-8?B?QThXVGpVdFpsOXkrYmM2MklKOE53NVJaUXJadEZWUzgxVzRXQjFDRGY0WCtU?=
 =?utf-8?B?Nlg3RmNUVEIrN2JxUzRmNXhEVWRaY3JIUVV1MHkrcGpMR25WaFl0alZGUERu?=
 =?utf-8?B?OVBqaVBVMkhoa1BlQzdYSjRHWEN6SUVYcVcvY1BaT0JzMXVQdW9tM2xYd1Yv?=
 =?utf-8?B?Q1c2Tm9sbDcvY2JqNWx5bWZya2U3eDlKQ1dTVHFxU29tNzJBczBXcDNwNXJP?=
 =?utf-8?B?UVRMcjdFRlZtVmZnWnUrREJEY3g1RUdXZy9tdHBsWVMwREY1eWl6UXdrUGRv?=
 =?utf-8?B?eTNGa3JoK0l6cEI4aXRJYm95Z09ETktkd3NCMHNHb0p0aHVqdE15OXZEcVJH?=
 =?utf-8?B?MkFYRXdpN21yakd1SlN2c3lTVHZKbDdXRzVXRUpqUy9lMi84ejVZWmdRK3Yw?=
 =?utf-8?B?QkVSKytzNS90Tjh5WVpXa2FBci9OUW5sQkFsYllCanEwZFAvOFhhQ2tUY0NN?=
 =?utf-8?B?dUNxMWJJZXRQWXI5d0ZvTG1kWU0rc2V6Z0c5UVlEdUdnbDFpV2pJNmV4K0lM?=
 =?utf-8?B?VmMrQVgyV2dYTnVVaXdNMzNBcWo1dG9xRVVJWENMV2hObmNxWVVuMFdNa3pK?=
 =?utf-8?B?WkV6Tk1YKzNXMy9XczlGellsVFU1M2oxL3luZlNZbDY4M0J3Tk9zYnZ6NFB0?=
 =?utf-8?B?cTFIQ0IxVE5ZeGhFSDdKS0JPQUNtOVNkcFhjTis2YTI5d1h6QkpnbWYzM1Ar?=
 =?utf-8?B?eEYzdllUbjVuUVRlWVpoRDV4bEluSG4yekZ1TU9IMjZHV2w1R3cvOFVhai9w?=
 =?utf-8?B?dUhESlBDeDRnUk9Scm1nMlRTZzY5YVZ1M1JzTmUrRGlkL1BnOFJzMmJheFpi?=
 =?utf-8?B?djJMLzU4OUw5bEwwR2JvQU5pMUl1Q3kzV3NiK1dGMzUralNDZEFNVSszWEcy?=
 =?utf-8?Q?dWGCeR/25iBMkpSagEnsJC0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2gwVFUzS3orR1pXV2w3OE1DdXFpbTNFbTRLVzRyOTRWRXk3d3o5TE8yY0FU?=
 =?utf-8?B?dGNDVzRFQjdYaFloVng1WVh5MXkwN01ZaExQdVdaSTFyUEJuUFR4NE4yN1lR?=
 =?utf-8?B?b001R1V6ZUNxZ0ZMdk8rVHVEZElCbC9nVjlRZFJNYVViQ1pBQzB6L0M0NGpU?=
 =?utf-8?B?aHRBcUdlWHNZYXdhakRRTVNpSFFEVW9scmYwYXBhaXM0Z0RxbGxOdDhQUUx6?=
 =?utf-8?B?cHovcUpGWDg2ZEdTRjFQV2Z4UXl6K3R6M0VVUTZOSTM2cEJ1cit1bkFNOHg1?=
 =?utf-8?B?UVhqaEZyRldBZkIwU01GeFJjMGt0ZjdOTzJrRWcyVk5pTjZ2QlNrb1A1U09J?=
 =?utf-8?B?RXBucERUaG9POU02WGtBQnlmZlNPZ281UEVSTC9rMzVqQVBNRzV4OWJGWWs2?=
 =?utf-8?B?eDVRTWVOMUkwYXpQZVJaSzlzNmxjNHNzTHNyZ1QyWVdFSU5vQncyZHhaQ3Bq?=
 =?utf-8?B?ZGUrQVZrOVRlbEh3bDNEeGkrdUpZUzJRcThMNEVxMFpxaXpGdmFxVkFRZE5m?=
 =?utf-8?B?SmRhaWpoT2twSTNsczFwRFpPZnVGdWVRRlJaRjRkcW9BMXVCemloMXEweGRY?=
 =?utf-8?B?MlF5K0lIMndxRlczQzM4Vk9IR2JtQ2dsSlRpaGZ4WXIyVHBaOTJHWFBRNmg3?=
 =?utf-8?B?MXhoNS9ra1FSM3V4R1NGOVJoTHpyZXBDKzcrTnZlUytSM3pqb2xDU0NRRUU0?=
 =?utf-8?B?TG1JQ1l4Vk5abnhmc3kzT1lVYnVqUUtlUElSMTlRSFRKRGIwbWRpVSt4UFVi?=
 =?utf-8?B?SmZScVhGdnVSbjIzdGNrZ0NDWjRYQ2tTOHpHY0NhdG1WYTM0MW5RdFJaOWdp?=
 =?utf-8?B?MHcrSWZ6STN3SW51cDdpb0VtM1FCN1h3Z3RhRmd6NEU1VlNBMEY0UllZbndT?=
 =?utf-8?B?U2pDd0RQdE9WQ2NOREMyZE50Zzl3aHNHQmpVYmYyZlR5cHdiRjBKSkJ5Z2tW?=
 =?utf-8?B?N0tQaU1JWFB0ejFSU0pidldRWEtYZzNVQUdlR2VZWUFmQ3l1RXFUK1RRTEx0?=
 =?utf-8?B?U2JucGFBRmZpWjVrUmx1M2YwWkhaQW9WY21KR0M4R2VHRHQxWHdQandDNi9Q?=
 =?utf-8?B?bEYvRWRyR1poVkI3dEVNTmJPSzZINTJEUVFaNm5GSGd0YVJ1akFzNmdoSDBH?=
 =?utf-8?B?aGl6WVczQUtpYjJQMnB3cUxGQlhqbVlFeUFRSmZlRHErZk9RMm5QQ21MVUFw?=
 =?utf-8?B?VFA3bjVSZzVDbmZ3N1F6VFF5N0Y1R1Bhb1g0WXJONlZPczluQ21ZeFB3aE1U?=
 =?utf-8?B?alJKTTVaK0dhQzNvMlA4RkMzVnd1d21vTnJHQ2ptNlhCa1krOVA1VklCMUNa?=
 =?utf-8?B?MjU0WEt6ZHlNZENJVzlKREtVck5Kb3M1MUVUUVF4OUV3ODFaeTVJN0xuUWVN?=
 =?utf-8?B?MWUyZUllMStmUXRCc25UdmNUbE41bzFCd3pnbGlTMWl1bDNsMHk3ZVdQS3Fh?=
 =?utf-8?B?NnRVTjdiK0pINm1FeWE2WmdKNkEyZFFyTHJTd3VXdUdYemwrNjYxeEpDbzNu?=
 =?utf-8?B?b2tiU1NmcG92b09rS2FHUnNkK1dXb2JOeUcreG82ZjRNVWQvdUhJUHFOZUV4?=
 =?utf-8?B?T3dkSDlONHNGdW9pRFF4Wk81M3puZk5oYVVxdGhXTHRrOE0wcjdjVXlYSEZU?=
 =?utf-8?B?d0g5bkdiZDR5eE5GUWN5NmJHTmJVR3QvTWxZWDBaRkwySlFZU0M3V0xYRGRv?=
 =?utf-8?B?L091c3Z1VzRsT3pvMzBFYktqS08wVUs1RGV0NklxSjJnREZsb2cwMnFETGxW?=
 =?utf-8?B?NzVJT3FwYjd3R0ltOHVyNjM3eXBPNE5oS01IZkNvOGZVM2o1UCtNWjRnVi9R?=
 =?utf-8?B?d1hQRTE0TlhRcjRFTjJ2dGV1dmxiSW5MRW1WVkJhN1hYYVhWZFpZRlphMm9a?=
 =?utf-8?B?ZGE2bVlqYVkyY0p4UjhNbGdUMEUzb242NERuUS9VdHhLSnk1M1dnanVncUs1?=
 =?utf-8?B?Y1JXM2tZQXowK3hwMjBXNDQwSkRLSjVMVEJDK2VFd2tDVUx0dGVRZW9WS1lh?=
 =?utf-8?B?dFJGVm1WK1VIUkJyM1dLZm5HWXNNUWFPUndWbnZjbytpQ1FZSG92SHBmQ0pV?=
 =?utf-8?B?OHlvR1k0UXZuOC9PWE13NTd4elBubFU3cmdJVGxZTUhoMGZvanlkR0lzMmNl?=
 =?utf-8?B?R040Y0thMlFjblo2MzFwWjRKUEh1Qld5Yy82Q1VLWUNBZldoV2dFVXd2dTJF?=
 =?utf-8?B?SlJ5OVJtUXlIYS8wVDZDQVNteUZEVThKVEl6WUoybEc3VXFmR2UyQ3BObENq?=
 =?utf-8?B?dXlRSklxN0luOHRxTXhyUEYvYTVBUVV0T3lwa1VPbTBuVTloeDQzSVI5SGlv?=
 =?utf-8?B?T0ZUdzBDdUN1TTk3dE9RWXVQbjN6YmpMemNmR1hSaU9vbHJFdGoxU24zMjNq?=
 =?utf-8?Q?iLIhKWmDExM3ouLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4faf7d1f-f360-429f-d728-08de5f21e6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:33:54.4620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi4SPBRcAfB9XLsLXz/DUwWuc5aKV/yRCIQwBDEoRAeVcY03QFsDQDdCiqLDEnwXRoo6H79/t3BrBA4viSlIecmuXTW/YdRqfkPFXaqjN20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email,lwn.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BBE40AEEC9
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI5LCAyMDI2IDk6
MDggQU0NCj4gVG86IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBMaW51eCBEb2Mg
TWFpbGluZyBMaXN0IDxsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IE1hdXJv
IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz47DQo+IGJwZkB2Z2Vy
Lmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBsaW51eC0NCj4g
aGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFi
QGtlcm5lbC5vcmc+Ow0KPiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYzIDI1LzMwXSBkb2NzOiBrZG9jX3Jl
OiBhZGQgYQ0KPiBoZWxwZXIgY2xhc3MgdG8gZGVjbGFyZSBDIGZ1bmN0aW9uIG1hdGNoZXMNCj4g
DQo+IEFkZCBhIG1vcmUgY29udmVuaWVudCBjbGFzcyB0byBtYXRjaCBDIGZ1bmN0aW9ucyBhbmQg
YXZvaWRpbmcgaXNzdWVzDQo+IGF0IHRoZSBiZWdpbm5pbmcgYW5kIGVuZGluZyBvZiBOZXN0ZWRN
YXRjaCBpbml0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8
bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICB0b29scy9saWIvcHl0aG9uL2tk
b2Mva2RvY19yZS5weSB8IDExICsrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9j
X3JlLnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkNCj4gaW5kZXggNWY0
NTVmZmZmN2IyLi5hNDliNDJlM2QxODkgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9weXRob24v
a2RvYy9rZG9jX3JlLnB5DQo+ICsrKyBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3JlLnB5
DQo+IEBAIC0zODAsMyArMzgwLDE0IEBAIGNsYXNzIE5lc3RlZE1hdGNoOg0KPiAgICAgICAgICAi
IiINCj4gDQo+ICAgICAgICAgIHJldHVybiBmJ05lc3RlZE1hdGNoKCJ7c2VsZi5yZWdleC5yZWdl
eC5wYXR0ZXJufSIpJw0KPiArDQo+ICsNCj4gK2NsYXNzIENGdW5jdGlvbihOZXN0ZWRNYXRjaCk6
DQo+ICsgICAgciIiIg0KPiArICAgIFZhcmlhbnQgb2YgTmVzdGVkTWF0Y2guDQo+ICsNCj4gKyAg
ICBJdCBvdmVycmlkZXMgdGhlIGluaXQgbWV0aG9kIHRvIGVuc3VyZSB0aGF0IHRoZSByZWd1bGFy
DQo+IGV4cHJlc3Npb24gd2lsbA0KPiArICAgIHN0YXJ0IHdpdGggYSBgYFxiYGAgYW5kIGVuZCB3
aXRoIGEgQyBmdW5jdGlvbiBkZWxpbWl0ZXIgKG9wZW4NCj4gcGFyZW50aGVzaXMpLg0KPiArICAg
ICIiIg0KPiArICAgIGRlZiBfX2luaXRfXyhzZWxmLCByZWdleCk6DQo+ICsgICAgICAgIHNlbGYu
cmVnZXggPSBLZXJuUmUociJcYiIgKyByZWdleCArIHIiXHMqXCgiKQ0KPiAtLQ0KPiAyLjUyLjAN
Cg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPg0KDQo=

