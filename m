Return-Path: <netdev+bounces-192724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B0AC0E6C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D253DA404CC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4B28C001;
	Thu, 22 May 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5KKrdW1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673EC28BAA3
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924696; cv=fail; b=eUThzoAJUnmh1K4tQM/YD5l4ncGIBS57MajhK9XYdqN/jB/F6Uxmzq9XKoxkG3Ej7Yt3Eh1hHTt8vO2N4s6K4GlNmo3JzAqUeoqrD/TeSBq7R5Iv2Da2aiIBdJLRDr1SXy2Z1tMSGZM7HbEEtrH/q06L3S62huEADzWNFqDetJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924696; c=relaxed/simple;
	bh=mIaFhe1Z+k1nkcHiHYz6+QtzcDST6FX92cn4mjNdzE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnwovIaoVWRW3wk3x59ORMnzjCX++cDG8hSLPEx4HtQpHHEIpgtea3zB3hf4E1P4sWgFhCjguCVAuDpxwECLRR95MbfnvPa7V3Fre3HKulmQiTOi1g6aNLlnvkVu0O0rMrqbUkF/mZEo6aT8oCDj2+D5xycDGtfT/nJJGlc2zZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5KKrdW1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747924695; x=1779460695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mIaFhe1Z+k1nkcHiHYz6+QtzcDST6FX92cn4mjNdzE8=;
  b=Q5KKrdW1qdSMBartQ314AJfX9Zcz93qh4ZT3emwpORPfl/X80zDtsNXq
   ap+3I7hW8M8pRICC/18mWQ1m6Ao5KU02NM0u67mdln8e/Nz9IGSvE8b5g
   8q03/urkUWil47AXtnZhkwiWNINmxSNnaowOk/JqNmtpSDGkpLwUkyXE7
   r8uPjshbfRMb50/MYERKNz6Vp3pFnYqkRu7BysCBJx7dsCjsA9v1ndGXm
   QwESYoCVlSEFQzpz72VPNXVMESWYspUT5VoleJmFhxpu3bnzlwXRgZB22
   O9E2dnrFYQvwW1doqMQxG6nMRsFCNmQDUh9IS0xjSt6Q35MAELbkX4dTm
   w==;
X-CSE-ConnectionGUID: j6bh5sROSKuRCp7BBdVCjA==
X-CSE-MsgGUID: 7/qTF6BQSeahCg0ik9le4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49872896"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49872896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:38:14 -0700
X-CSE-ConnectionGUID: q4jsjiosSL2WpjtFu8Qmvw==
X-CSE-MsgGUID: 4jyyEA2/SPiF428y2YihVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="140508658"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 07:38:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 07:38:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 07:38:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 07:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKaho6DIXnAC1Y66/+ASge9xDl3MoL4i+sVhzOMbguf09Wfwnh1RgaSIYMctVLsT3xZHXguxFhveq98/7wqTmoygn3Z/hxFyi4V6E1cLRv1MaCdiP/lQ1dOuQnWCZpy4VM732xDGESrDbrrJRqPc9DYoRNid/1r+33Dd0mfr4vOQ90JzPv631yumlUibNR9yA+4Sta6P3z3yz+XzQ4AR9J3vuNbTkH4lNoqrplAplFLE+1OhApl0mVQr94OaX5aKqVS9kDm8KWm1zZVq2lrQ1D6640IYf+lgyJvCTryNHU7Dp+uV0jP8JMIX+YWC+MXVKpY5VAyrSHVKVSKS/VqNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIaFhe1Z+k1nkcHiHYz6+QtzcDST6FX92cn4mjNdzE8=;
 b=lcuQ8ipUsfCdtM/SdM89qwf8y2VaYyreXxcnIXbxUD4iw/6q3SOtZyZ/CWA4h2wcoZtKCvXQ8Dmt9hMfBCMz0i91HixVd/tN5xCxwKeZy26d8F2QgoM1UMLuDDvX/FkuP1zBpX6ngMixF3v5SsK5C6Y0oagL0L/k1qNse8qe7zIp/yYGbr3e+TNyA+GvCrYUTqncx4o6o11q5N1fjmMZMqHpIbcCrtwy16uKGE+stqBsv3e5/X7yjd/hH4UxEV2H1GdCvjRzpCdZ97ej70LVAYGmt8xLADJ4+KFK/r1shSL5f5JDhcXRuYXIsCzEkl1qsq+t8/7jpzV865RqOcOing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 14:38:09 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 14:38:09 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, netdev <netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v4 14/15] ice: move TSPLL init calls to
 ice_ptp.c
Thread-Topic: [Intel-wired-lan] [PATCH v4 14/15] ice: move TSPLL init calls to
 ice_ptp.c
Thread-Index: AQHbuuwwrpKir7ruFkicbh0xgP4vfLPe2CNQ
Date: Thu, 22 May 2025 14:38:08 +0000
Message-ID: <IA1PR11MB6241B226300E24406DD655818B99A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
 <20250501-kk-tspll-improvements-alignment-v4-14-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-14-24c83d0ce7a8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB8572:EE_
x-ms-office365-filtering-correlation-id: ce8d7f95-cfc7-44b6-aece-08dd993e4584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0RQa0gzL3NYOHdhY1VyVU5EQlBQMURQajg0TVRmYUM5VFZ4RzRNZjFEZ3NL?=
 =?utf-8?B?azZLdGpUU1J0RklYU0JmcU42b0QzMm9vRjZWSEp3SUM2aEVRdXZMdFZhbU15?=
 =?utf-8?B?NFFYaS85UXZxS1BjcnRzRnRHMkxuZ2h6WmhhNEJWV1VhS0JIWHlQRHVVN2lT?=
 =?utf-8?B?OE1GTGtqczNlNy9FOTN1QUZzYUxKL1gxZWx4NDU2THU1QzhXa3RmVUdMdncv?=
 =?utf-8?B?R1haa1I1VDJSYUs4bXNrN3dnL1JrRTkyNE9BQSt6N001REJzSjNlSHBxYS9K?=
 =?utf-8?B?SnhEZ1VrR1lFaHI2Q0ZIVWFMR0hvOE9qTUtFZlRRWDJhS2NYN3FOMjJTaUs3?=
 =?utf-8?B?ckVyU2ZiRUtwa1M5V2VZaGNZT1k4WmFYSnZvMkJmSG9pdCs4K2pEWjloQm9n?=
 =?utf-8?B?ZUJOVW1Zb1FNdTZvVHp0S2VMbnowbDh4bk42Q05qM3o2RTRCc3R2R1NkeGdE?=
 =?utf-8?B?RFk5VkEwZmU0L0ZzNXBvK3dWZDBYT0FzSFRlUllBT2J4UFJINWRNRWY3dUM2?=
 =?utf-8?B?UjhpbTM0a1F2b1d6eXpUeUNaVjBRaFRMOURhZ25LeG1DdTFRQlVEZHNJOUJr?=
 =?utf-8?B?UGVZczBNL2RjbjZ5a01xN1JOQjNBS3BzNm5ZR0V3dVMybmxpQ3FkalM4WnVK?=
 =?utf-8?B?YjVpM1FRL2dtUnFvTkdYVHhOdGlJazhNT1lTb2UwNHNDMzJTbmliYXZNbjFo?=
 =?utf-8?B?UHlrVW1XdkxSdzE0SjFYd0IxaVVYUGU2dncwUjJHT0JoRUc4K1Y3R21yb0FD?=
 =?utf-8?B?eHdTU1hLZnVhVnJPSTBuUGJlTTVxeCsvbzFncWg3cTVXclZXUXFMUzMwejJk?=
 =?utf-8?B?MnN5M1JSNTh6TmdidVlNdm44a0YxaVVLMFVjQllpanJXcHdOdnl6N21GKytW?=
 =?utf-8?B?dFRGZ0tFbU1JUTVRVGN1aVB0bUg4eDRHKzJZL2ZGbW04clhKVWtMNjBsSGFM?=
 =?utf-8?B?WmZ2ZjhSWXcxUUt1NDlFeFBDRm5DbExpNU80YnQwRFF4bmJIS2RvdFRsTUV0?=
 =?utf-8?B?QU1uSTNzOGdXRUNEM21LMHBRK2o4VXVXR1BucElrUnZsNEVHVUc1eDRibUhJ?=
 =?utf-8?B?S3lmNno3VnFTSnZGbWwrdkNmdkR6bWRqMWxWMW1YU0FzalZZeGpHbTZqcUw4?=
 =?utf-8?B?cFg3dzd1L25wS3lZQXNveEIrM3QraUYxMW9TK2d2SGVGbnBiSDB1NWFMaVdC?=
 =?utf-8?B?ZGhHWXp3YzE1dExkL2VzM0hZc25ZbGJhVFUvaC82M1dLWkNvQkFKLzhUU0dm?=
 =?utf-8?B?UHB6VnVrK3FRWlA4ek94enJBcEFubXJIOWw0STVJVkEwcTlTTGNDWXh1VlhD?=
 =?utf-8?B?ZzlCVlZ5SG8raE90am9FY2hKMDFGdEJ3MnUvQ1hHSzY3RjY4TlJTTHVzd2hW?=
 =?utf-8?B?Z2hDNkw1TTVuRDNMU1ZsdkhHcXFLVU42L0xQeXhJOHQvVDlhVkRMclJkUWUy?=
 =?utf-8?B?bS9BamN5ZUgyUVpZRVYwb0tIRE9XT0RrVVRYQ3ZVV0pKMnAwQUltNUFMbG5j?=
 =?utf-8?B?V3BvQnlib0dzL0NtbjQwSHdNdllqbEVTME9kMUQzMVd1TXg4RU5SbFJaYUR0?=
 =?utf-8?B?MkdJT1dOSWF3OWNHNkM2bjBoUm5lQ3hXVXlXR2QvOUxWMXRwdU5WZnZhZHUy?=
 =?utf-8?B?Q01qYXdmUnJtdEYyOGZrcU5Nd0FjWkxLaTl0ajYzbk8wMG5jN2I0OW9qbDNZ?=
 =?utf-8?B?dVNTY0xnb1l5K0IzUzMyaitJNlBPL2ZXZjZteHhUeWFPUUFGelUxSEFaQ3lI?=
 =?utf-8?B?WlZxUXFHL2NlTENBMVRpVjFtZ1dQNElRZ1hZbElYS2xRZFpIYmNxR2lLMG1O?=
 =?utf-8?B?R3pXYUswWXB0SjFHblpsbGUwQ1VRcEVWaWRHa2ZFVjlBTDRGRjBxVmhaZURM?=
 =?utf-8?B?SjBTYi9SVVhyNEczck5jUVJENm1WSnVvaHBGNVdpaWx5UzU1ZDRxblhLRG5l?=
 =?utf-8?B?V1laZFc1TFpxclpacDJzRHdhWUdTbjVFd1AwaU9CUDEzNUppQldjVkdoTk92?=
 =?utf-8?B?QnJHOC9YZFdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1pzM1ZQWkZVcWp4K2hxby9xaldyVEIrbU1BVVVSZjZRRmp5U0RWdnVNd1I2?=
 =?utf-8?B?bCtNTmVWNVZqRWp6VENIOWs3dDI2VEU2QUJxSE1VQ2E2clpSSnpSWTZ4enls?=
 =?utf-8?B?WDA3TlNpYjJ3cDNGcEI0bENkemt3cGorMlAwT2VLTC95cEM5RUswZVg2dklU?=
 =?utf-8?B?ZDhiaW14L3ZGVFdINXVtbFN1QUthZVpPNlR5bjNaWEp1aTZHNThJdnI1WDV4?=
 =?utf-8?B?Y2xyY2Y5UXZvNEZtQmRSTkk0bDQ1VWRYOWVEYzk2M0c4dForT2MvM2FFSTFX?=
 =?utf-8?B?QXg3ditRT2RHeHJUbzMyaUJkZ0JNRzlpbUdhNWpPcElLRFU4aDhnQ05WOWpC?=
 =?utf-8?B?ZURTK3gyV09hNExpdVJpaUpQQnNjN3JpTlNRSUllQlc2ZTFWTkpTaWlDazhl?=
 =?utf-8?B?L1N1Q3BubHNLakk2Ti8yWGEvSklhcHB1NGNFaHI3QTdKT2dWbXl2NHVtQlI5?=
 =?utf-8?B?WW4xak41bTF4a3BJZnA4Rk9QSi9YZndIbHRCSVNDOGtVckE4cVI5U2o5QWxy?=
 =?utf-8?B?U2xrb2d0T2toMHRnUVVBNjRWcUpORCtuLzc2YVdKNXpESFVPamlEK1RoSjNB?=
 =?utf-8?B?WkxUYlZXUWppTHhFeVRrV1NIQWFhelArbEI4Y1lHTnQxeGN6OG5lOThUWXRH?=
 =?utf-8?B?Nm1QbHlWMnUxejhOTS9zcmtvR1V1OG5ZenV3dDlHK3pmR1IxR0lqK0VYalkz?=
 =?utf-8?B?dXIxRlVva0pmK2dua2h2aWUyK3QybEtSN3djaGl1aTR1YVhOWE1VVUZWdjJ6?=
 =?utf-8?B?SWR0QThQYjAvVFJjTmxqMHRpUFVyalZpMGJtZmlidWc2VzB0NTFxNStYYVBB?=
 =?utf-8?B?K2EvTUZveENSanpvc1R4eU5Ec1RQRFF6RE5WSnFLZkFhUStkL3RUS0dCWjlu?=
 =?utf-8?B?TVpJNHF4V3poaHlEM3dQdmhHc2hVV25saUs4SldqZ0dhZDJ0dUczNy9LVFpl?=
 =?utf-8?B?RFMyUTNUMW1Kdm13YTFBcWh0cFZZVi9tZlRQVUN3K2ZhekFoUXdaM1QzM0Zi?=
 =?utf-8?B?UnhYK0Q2cTc3TitEOHREdzQ3Wk41T1Q0NEIzR2xQL3BwV3pOM0IwM3NUcENn?=
 =?utf-8?B?UzQ4bTZHUEFhQ0J2R1k4dFBCdURJUkJJL0RpaWtZK3lpZUx2VUdQTGNWQWVu?=
 =?utf-8?B?azJpSnQ2c1k2SXpQK2tYenk5MWlxTEtSMitVMml2T2Q4S0pqaEpJL2tHb2J6?=
 =?utf-8?B?RE8zOU4vK1NuRmJmQ1ltRnJtRDhkSnIrays3cDlXMThrWmdoSEEvU3ZUVndu?=
 =?utf-8?B?MTZlQVJlbFAwZ0xYODJMRmxDSTg1a3owQm0zOUxZa3pSZ3F3Rk5WaXQ1dDZj?=
 =?utf-8?B?Z3dEWFZ5TmQyczZ0eUdjR25wSytLKy9LT01TNmxLQWZOTHc2ZWNYS3cySWUv?=
 =?utf-8?B?YTNkSUZIL2x1YUhURE12cjRQSmFvS0h3NExrb0FETDhNU1NHSmJPd09HYVRI?=
 =?utf-8?B?NENLemFtenF2TUhNNEtNbitYbUVaVU5Lc0NKdkRuait0TGxIRmZqR0ZvdVhy?=
 =?utf-8?B?YVBkSkdlTDRVanlmODhIbnpSOWFZM3V1NEhUUHIwNlVWU2R0ZnBRdkI2ZXNY?=
 =?utf-8?B?c0VzTHlRN3FjbVd6OGFoWjRUR0o2c3BSdW5tOXkzV1NsQTBrek1zeFVoSU51?=
 =?utf-8?B?d3EwRkpJQVFna0FSdE5jZXpBZmcwQ0FpSXN4elRKakh3WUltcWQrNFdrVCtH?=
 =?utf-8?B?VXA3NTU5Y1Bnenl0bFV6bTlzcHFPNEJ1MXhpMXFmcFY5cHF3UDk2dHZsYlZO?=
 =?utf-8?B?bXJBN2VnR1UxMVhSMDBxeG9CaFJodEpLQ2NsWHNjaUl6WkRqMDloMHBzdjQr?=
 =?utf-8?B?bXhOaFhtaWpzclZJQnh0THBkMjlUUzRSZmsxMlBnWFhEQVk2eEs4K3owN2lo?=
 =?utf-8?B?S3hUa2h6TS9BNGVaRkRBRGE4S1JmMm0zTmtIdzlPaldqc0xvRmt6cVJYaGN2?=
 =?utf-8?B?TkU2QXhOWFNwK3F3RXpHTFpGVk1PdVROTGpid01kS21xZWhLWmVKNnBSdU5H?=
 =?utf-8?B?S1Z6ZmZTYzhwMUd0TUVxMkRpR1NPYlhsc0xYaVAzMVZLanhuSC9mUEZ6c0do?=
 =?utf-8?B?NHZmdGJQWWJ5ako4RFk5YkFVYnpvbk5uUmEvN1dmTkwzZjNZZU8wdTFLWDRa?=
 =?utf-8?Q?VUjs8SMYJr1BpTzgmbM51hcl7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d7f95-cfc7-44b6-aece-08dd993e4584
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 14:38:08.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPrc+azNfxdlG+/Gj3QFu8J1EACJh74bIEmvVu+vbA2fvedXiMU38rEDYole+RPt3arwBhfHqAQ+/0fZnxqQgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDIgTWF5IDIwMjUgMDQ6MjQNCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+
IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEt1Ymlhaywg
TWljaGFsIDxtaWNoYWwua3ViaWFrQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtvbGFjaW5za2ksIEthcm9sIDxrYXJvbC5r
b2xhY2luc2tpQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0
c3plbEBpbnRlbC5jb20+OyBPbGVjaCwgTWlsZW5hIDxtaWxlbmEub2xlY2hAaW50ZWwuY29tPjsg
UGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU3ViamVjdDogW0ludGVsLXdp
cmVkLWxhbl0gW1BBVENIIHY0IDE0LzE1XSBpY2U6IG1vdmUgVFNQTEwgaW5pdCBjYWxscyB0byBp
Y2VfcHRwLmMNCj4NCj4gRnJvbTogS2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBp
bnRlbC5jb20+DQo+DQo+IEluaXRpYWxpemUgVFNQTEwgYWZ0ZXIgaW5pdGlhbGl6aW5nIFBIQyBp
biBpY2VfcHRwLmMgaW5zdGVhZCBvZiBjYWxsaW5nIGZvciBlYWNoIHByb2R1Y3QgaW4gUEhDIGlu
aXQgaW4gaWNlX3B0cF9ody5jLg0KPg0KPiBSZXZpZXdlZC1ieTogTWljaGFsIEt1YmlhayA8bWlj
aGFsLmt1Ymlha0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBNaWxlbmEgT2xlY2ggPG1pbGVu
YS5vbGVjaEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kgPGth
cm9sLmtvbGFjaW5za2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9wdHAuYyAgICB8IDExICsrKysrKysrKysrDQo+IGRyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMgfCAyMiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3RzcGxsLmMgIHwgIDUgKysrKysN
Cj4gMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4N
Cg0KVGVzdGVkLWJ5OiBSaW5pdGhhIFMgPHN4LnJpbml0aGFAaW50ZWwuY29tPiAoQSBDb250aW5n
ZW50IHdvcmtlciBhdCBJbnRlbCkNCg==

