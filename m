Return-Path: <netdev+bounces-254705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qODrOvg2e2n4CQIAu9opvQ
	(envelope-from <netdev+bounces-254705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:31:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D0AEB6C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBBE63025179
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61823815C3;
	Thu, 29 Jan 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV83ilaV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D943815D0;
	Thu, 29 Jan 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682666; cv=fail; b=JDj2NYO0iDF66DzEnCHZzFag+5MwxBinxpaIA5FnyTBIZMz1yvSXp8+/5iJeox+NMYhizjyMXxrZDZnFWnu+0fzzHAC6z8qPF3lEubitG8aErklxK/QAOWj9y8qNLHSTyEDK1Ii4/8+xvZCWSmhWsaXQMHYNaUxHXcFq+b5M2BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682666; c=relaxed/simple;
	bh=qXeMa83c+mGKqTb1TFqfxVhRovrHbH3Wh0WuhxcdcxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHlghRr7Fltxti+nz3a1DR+GOEpV8D6/znQnhFJpG6DC9aa4TeM83O14QPxB9YDI3voyw5JMFOR6jwcvNMWWuuuzgJDBJkwwhtleTtlMXb8M3GvdyKWSFxPYKu+I9A6vx0Fw57KcwwoCdPhR8vIWT8OYZDSx/EOFD2kX4o/+EGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV83ilaV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682665; x=1801218665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qXeMa83c+mGKqTb1TFqfxVhRovrHbH3Wh0WuhxcdcxU=;
  b=KV83ilaVqISP3JpQLofr03Cxjn9ESc4IaLKIhikyzYJ/BNzdwiFuS5M5
   i/yFOnkHZiFUXuh6uBXYicGKmeu1hE6OFiaPOfqQ4Sz6+BclliTodIlRn
   /Qo0BcNyBt2g123PxHj+2Xq3qMsS+mEwgEcGM50gw4+jQkRHIv3HnjZAI
   AP7fXxN7YusRe4ZbA9Zu0SJhXLrEA167zKlzzlhJ6mqG/Bn4/Mkm0jMG8
   YFFsDgXwCc6i6DwX3aVma9xYfU0O9PfHOzpYg+fOsjYuuAZ+9WVmHCVeQ
   IESEOoYb84bKB8eHP/qGo7OXmUwTiGgKoghfWelHgs2Cfo9poMvz3hgjs
   g==;
X-CSE-ConnectionGUID: MJxSosClQ8eAdKcKOaAeGA==
X-CSE-MsgGUID: NhV+2XMUTy6eZOi+gH+0ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74778910"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="74778910"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:31:04 -0800
X-CSE-ConnectionGUID: RHFuBsYUSuyJAFFMp12ecg==
X-CSE-MsgGUID: xjC3bgGmQs6jjAcDBDFg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213042890"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:31:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:31:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 02:31:03 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brePO0Om0HDkhbJZv0i+o4HTxkDrz1S1bVCAYG88b6COphCKCVmjssM+aKpN3j5CKlkF0p22N45N+sx6wXO7fXFiFgE0jjc/iAdYhMEu1HnjKpMU8EoQm9tzh5kfYAJQf3hK91v/y+6mD7SvE7SHRe9arVJ6Da1FWa0CAB13ZtsxPSKag/rWWVC8Fp2guAs5319JSfvwknzv1OoeSEHdCx/B+yYQLTtlKeA+fp5pxd/2Rsalmv+0YNVlfYIr9L+wc7JYYmAflrFqRGFwY4w6Z2PZRLGa1O6gD09q4CPJ59Z2ZUwLZJQHqkit9gG7AxVO1uwCZNueY+TwvOA51ml+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXeMa83c+mGKqTb1TFqfxVhRovrHbH3Wh0WuhxcdcxU=;
 b=UJiIaBJ80mgWAGbUrn2dcvjWQU2jZMJVR1q98vwRLVLKDtAm7eeujAFZB51/7g+KDbtPJf8k+XCIkqZZoVjFeU0Dy2PtH7xGbMMTJTY/3BDeg6BvKBdXzVYi3okr9+ValQFA57q8shfHh2B96QZcp6EyluRN7fUJhLiJwl1CvWlwXMCl8qc8U/xMm0edbd+1GZcuULJzKKoDSzDu7f0COQUeq9W6HLAm7RCHD3rFOFOZUd/PLRxraMn/jMAgGJDFWlVTAcRlG/Byvb/7ndLt/PR2VDi7HxDNI1Jigaciz2detHiuSVe0rV3EG6WXaaa/5sbd8ULNJ6P5Kwea+Kikww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:31:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:31:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 15/30] docs: kdoc_re: properly handle
 strings and escape chars on it
Thread-Topic: [Intel-wired-lan] [PATCH v3 15/30] docs: kdoc_re: properly
 handle strings and escape chars on it
Thread-Index: AQHckPaWSZ6MMhybxkK+4jvgoXYYrrVo8sVQ
Date: Thu, 29 Jan 2026 10:31:01 +0000
Message-ID: <IA3PR11MB8986842ADBD12FB865D9B8E6E59EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <486ef8c6f1f066d495b23df2dcd450fa5c2bc3e7.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <486ef8c6f1f066d495b23df2dcd450fa5c2bc3e7.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: 94adbdcb-4996-405e-f056-08de5f217fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K25ieDVVRTBhNmlBSHlWclUwcHNSNGl6a1hrekFidG4vYlRhL1d3c3FKTE11?=
 =?utf-8?B?bEY4U1llRitKUzdEYzkyeG5sZFhHTjdhZUFjNEcyaFBiSHVaMmJiRkZ6bUQv?=
 =?utf-8?B?RThMRW1TNTI2SHAvTm9sVVpudldZWnUrVHNINk11ZHhLcTBGVGJROC9rNnVj?=
 =?utf-8?B?VCtHZEZZZE1GQU9ld2Qrc0hzNW1wM0xFcXpEZzVsZnl1ZjJjeDYvVEdwRUox?=
 =?utf-8?B?REJxR0d6N20rK0ZOQ1RnazFXWll3eVJWeWJFZ2RCT1JQTzFrRm1FSUpxY3pj?=
 =?utf-8?B?eVRoRXNwMVJhNnIwS3c5WVMvOUJsME1MNzRmbVBVUDhIZ2lRMktlNWtqcnNq?=
 =?utf-8?B?N3MvSm9zbE8wajljbGExOGtTb1dtQ0VCUmFuRlZod0RvL2hwLy92aHkzcWpv?=
 =?utf-8?B?UE9CT2NLbW0rMHhqQXRrckk3Q1ZKR2FVdlRJTWZEOFp5SjcwV1BaZmViTElj?=
 =?utf-8?B?Nkk3VExOUDVCTWJSSUg1aWFrTTBxT1JCRnlmaWl1MHdKREkzaFFjbzJHdC9O?=
 =?utf-8?B?QVVlMGtwU1RXTStFR2dIekVJNVg2RWtadk5xR2E4SkJTc1B5M05ENnBSNEZZ?=
 =?utf-8?B?K1JaWnR6THViVk1ZSkpJRFVNQlBMU2NxQXp2L1kvcTd6bWZVWW5tOWV5VWhz?=
 =?utf-8?B?b2FGbW1USUFqUjNsQnVrc0U5ejBCeTlCQXVsTmxRZDVnNHJrTnpRWWxvSVpI?=
 =?utf-8?B?S1RXOEZUc2tneGtadXJ3UnhoSEI1SEF5UGt5dzRFWXNZVytZTUJkOHRWbmFS?=
 =?utf-8?B?MWpxTmxJR1JGRitlRTNKVmxwLytQUXRPaXR3NVY5ZTZNQzl6ZTFDRGtUMm16?=
 =?utf-8?B?VGFId0k1UCtoUnY4Y3crT1h3YVJEMUV6SFB5emR0c21wWGFGazcxNHlodnBS?=
 =?utf-8?B?eVJEdGpFQzBXUFJWZFBGVlN6SEJiZ0o1dmZmL240NGZKRXJXeDl4Y3JjOU9W?=
 =?utf-8?B?ZlJtcWZGNXNuVSs5WmpSb3NEZFJSb00xTVVXbkRlbk94b0wzL09jUmFNNHFo?=
 =?utf-8?B?K0pZTXVETjJ3Um9ockUvRUtkUkhMcENWTzR2R01jYU02SUJ6RmR3eDh1YmVz?=
 =?utf-8?B?NTZRakhMNzdNcDBKRHVqbkVCU3lwK1lmcG1HMkE2L3h4eG8zUVA5TTlMSzQw?=
 =?utf-8?B?aS9vc2hJczRlWVl0dDhMMjd3Smlzd2RzcFdMR1FUcDNUU05zd0F0T1I3ZHd4?=
 =?utf-8?B?bWRDVmpzRWhuZFQ4R1E4M0kzTzl1VHJCRURFR2ttVVlrTEszdFZCS1RzOVZX?=
 =?utf-8?B?S3crekZlbXVKaWhjUGdaYXF1SGZpMTN4VUdXblcxYkxrQWxydWRYL3ZrOVVS?=
 =?utf-8?B?d0xjNzlMc0hYNjdMM09UNVpkd1Q5eFZDbGwyZnZjTURUSy9LRmptNTdZdTZ5?=
 =?utf-8?B?dTZMWmNBME1md2RMS3RTS1dBQkNpOUV6VWNMR2RqdUVzTmRrTVo4cVdnYXg2?=
 =?utf-8?B?MWh6VU0zeEM4VytzRmRLN0VWYXZkclNnM09ETXpaaldwRlk5ZlBubjRyRHBz?=
 =?utf-8?B?TWJ3RnVWc2J2Uk1oMjhwOU1zME9kZDZuRVczNlJkUExnU3k1QW9QcW9Rak1r?=
 =?utf-8?B?aFNwVGZZUlFQMkNYOGFlU3R6RlByTGdPbTlVNkdQUUNuMHJKMTZkZlREcVdo?=
 =?utf-8?B?V01xejRCVzdPVXVzK2xkYjhmZ2tHMm42L2hOdEdzMDh0aVpaelpIQ1l5VHJ6?=
 =?utf-8?B?eVJ0VHZpUDFIWi90TTF0S2kxVGYvWWZhOFZIQks0SVd5WkRydXlmL3hTelhQ?=
 =?utf-8?B?NWcyaDROeGE1TFpPRklsdURBNEUzK0hJMFB5aWhEdkZpQ2g0R0tqcnJzbnB4?=
 =?utf-8?B?Wko3dENyNGlCUmVkRlVvU2hOanMxWGtjVmlUOWtLYzhnUU0vRXNUQVR2UmxS?=
 =?utf-8?B?aGRtYWpHYkRnKytmdWdHL1NVWXRYclgwSnBESWYraU1RSXpOK1dKNmtiTklI?=
 =?utf-8?B?T3BzK3ptaUZROVd3WjBjQTAwTWxuY1ozQy9jOUkvVmV3M1d2TGVTaE8xR0d4?=
 =?utf-8?B?Q3ExcWg5Y0VnNy9PcGR5RjM5MjdMb0JFT2dMRXBmeFpiZXZPUkw0WmVoT1p6?=
 =?utf-8?B?ZVV2QzBTbUhycGY0eHZRdy8xNHBkQjM2MW5EbXFweUdFeHpId3JMUUZqeHMw?=
 =?utf-8?B?VHI0V21OM1dMcXBhSHpybkFocU5TQ2pSUU9WQysyTGhKcWYydkVVRkdRczVN?=
 =?utf-8?Q?pCGyV3vFMYFfTMG+NQZ+znY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3o5VVpHMVVOelVZWVRPUkxvQ2hsSGNySUozM2J4ZVN0VHZhdG15ajZTOVM2?=
 =?utf-8?B?NUlXcHk5K3BVSGhvYUthK0xXcVluMlJIM2VHbzczUy9LaTJhdWhTeklLOC9h?=
 =?utf-8?B?Q0JGNHlwQ2NnYVBHRCtiYm1mbHRXZFRUT0FEa3d3V0pRbVhURVU4OEovZ2lT?=
 =?utf-8?B?VWVFTFdQYmVrdlBIVVg1WTUyWnhleVNHMTM0MjlmRXNyN0xOUldSWXVqd0Rq?=
 =?utf-8?B?NU01OUN4NElIeWpPdXhQajdsWGFWVzlOdDB5UHh2V0wzK2FvQlYwOEM2M05x?=
 =?utf-8?B?MlAyOEJycnF5YThFUmt3NVRWUlJ2ZVJNQ2xHM3VPZzMrazR2alBmaEUwLzBn?=
 =?utf-8?B?YjVxSjdTOTBrcHM2M1FVbHEvTnVRZC9ZOXBYRUdVNktET1FmZVVjZ3dlK29L?=
 =?utf-8?B?UWd0M2FzRnpkTmliUWJ5ZU9BSEFNbTVQejJBekpQb0kvN081N3I4NGM1SDhl?=
 =?utf-8?B?Z2xEVmFRdlZVektsRTdkL0kxUWQyMTB6WmpTcVFURkVMTUpmNTBhYVFONUtX?=
 =?utf-8?B?aHdweHo3Z1dYc1phREZFemRyaUxFa1h6c3ZqY00xNnBMYk52Q2tXU2tiOFFJ?=
 =?utf-8?B?b21Ba2k4cVJCaUNDR1l4d2E0NGttT3VXeVh1SlBuUjIzWjg4OFgrMFU1amZk?=
 =?utf-8?B?ZEtHNWFsUWlKTHlXYytRVisxUHo5YlFKZUZZOUdteFZRRUpGQmpRdjVvVzVT?=
 =?utf-8?B?MFN5dkxDK2V1SC9Ha3VLZzE0V2dOcmw2UkdPb3FrcEhkZ3pvajdabVFwUWpW?=
 =?utf-8?B?anZaZkkrZ2JHbXVIRkQ4UlgyT3RpVVlsREd1RjhDc0hjRXNLZmIySzlFWG9G?=
 =?utf-8?B?eW1HT1ZoZ1NjOHlWUmhqZnhiMmt5S0luTE9wUWhOalM1UjBML3lOOUhFUmk4?=
 =?utf-8?B?b3BTbGJONG81UlRvaEVycnhPU0RudHdrelc5S3huVmtQek1LdHpIY2VEWkpa?=
 =?utf-8?B?aTFlNlQvUEg0Ym1JY3Bxb2cwVW9JdFhBWWphb2dFY2RpcEg0UHNkb0hoSndz?=
 =?utf-8?B?aHVrZDJpSy9FTGFnc3phbndEV3YwdldyUTdzZWlRTDRzbEpycjJsR0tWUkdz?=
 =?utf-8?B?UUFYeGZuY09RUEdLSmJzMUx5MVdKUUZjZnRrRnZpWHppZTdUem1uVDVQSUxV?=
 =?utf-8?B?bk5LZjc0TVZXQ1FWaVdVZkx0a0RQU0hEMy9mTEpmaGVlaFRTV1dGVUkxQmtk?=
 =?utf-8?B?Y0NVUEIwRWE0RHMxRG92ck56d2QrSEFsTnkrN3Z1akVUejdUMWJXNGdWUmNR?=
 =?utf-8?B?azJhWEdDSTVHY1F5ZG5xZFo1SHh2VzFyOGZydHYrVkd6UlZFVm8rMCtrZmNm?=
 =?utf-8?B?Z3NSV1ZTSTFwV2JadFNxMzdKV3c0aW9aaHJmcFVFek9Tc2kxNWJPOGdndmQy?=
 =?utf-8?B?QnNBMkJLWW5oNFYrTGE4ZTMrZjRRK2xmdWg3cnd0SmRyYndkNGpWbm1KNVdG?=
 =?utf-8?B?QnRvako1b2lDUW11Wk9TV3VadU81VkFSN1VJeFRZbzJMcGkyUEFJRHNRZG9W?=
 =?utf-8?B?Vml4ZzdSQ0tHLzlZVkRydTZDVlJaSUtxbVI0K25QVlJaNU10VGY2aVhVYjho?=
 =?utf-8?B?eVltV3dUK2phVy9CY3VIYkI1Z0tmWXhiZGtYMG1EamVtZmJKbW5CenFDMmRj?=
 =?utf-8?B?enV5YVBMS0xtTE5PODM1UFlzNzBCZWdDWWpJVDRUakd3U2FMWVFEQXd5TjRG?=
 =?utf-8?B?SHdrcU15WVBnUXp0NmkvdEJ0am5NOGtXZ3B6SEdHWE9Lb0dVbFNkZ1lhRjJN?=
 =?utf-8?B?d1dHWHBpMFk0VGZRcDBQbTlqNmpnVlJRVmYrYWVRTWRwL1h6OWZBSytsbDk4?=
 =?utf-8?B?dmRUaWxnUFV0Z3lSN21pRFVVeDBjYjFtZ2ZDd3pPRlpxK1lsdGFSOHAyNkpE?=
 =?utf-8?B?NTE1TVBaL0NFZWx0Rk05Rm94cGxqVVNNbTJqcXJ3NzdQTi9XaTZqNXpwZjNZ?=
 =?utf-8?B?Rjc4WDNudmJzWE5rQzFlVjBteEFjQ1pLTWNtaGwwWFd3d1ZTdmoybW9yNjVr?=
 =?utf-8?B?dWJhNEcwaHRjaWpsaUg0SUlCUnhpYXVSdG5OTFJKYno2djlXUzBaRjg3VWFu?=
 =?utf-8?B?RFhEaFgwYk9QNUgza2tiWEl1T1g0UWY4N0VaSmhyaGE3WVNqbkFqbHBaMXhm?=
 =?utf-8?B?Z01xQVZ1dHFNNGNySjVwTmtQQ0g4RVhzRVNoVHN5K1NXZVFZN05mM3JHc0hV?=
 =?utf-8?B?aUV6UjNRcVk0QS8vMGJDUWMwZ0ZCdXpmZ2pyRWRqeGwzbWFzS2h6TnpmS1VV?=
 =?utf-8?B?eEQ4QWhOMUNUTUtZVEV2V3JhSWQ4bzN5Vk1kRUJlL2dDMEZwNW1yZ25tenN5?=
 =?utf-8?B?UWdLZG1PLzdsSFcrc0taTUZNV3UzbGkyWC9ZbXZqTmdnZmdYOXFpYk83ZzZ1?=
 =?utf-8?Q?b0NhbKKL/o7R9vnI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94adbdcb-4996-405e-f056-08de5f217fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:31:01.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5a2yRlbT5OItx1FGzRBk7jz4sHsjONOyFdZf3rHb51DR9HDSRnJPdXfItzzeG7RXaDO4zMOcN+tUlND8XesSD4ukf/99h2wCfroEbSGxy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lwn.net:email,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 964D0AEB6C
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
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYzIDE1LzMwXSBkb2NzOiBrZG9jX3Jl
OiBwcm9wZXJseQ0KPiBoYW5kbGUgc3RyaW5ncyBhbmQgZXNjYXBlIGNoYXJzIG9uIGl0DQo+IA0K
PiBUaGUgbG9naWMgaW5zaWRlIE5lc3RlZE1hdGNoIGN1cnJlbnRseSBkb2Vzbid0IGNvbnNpZGVy
IHRoYXQgZnVuY3Rpb24NCj4gYXJndW1lbnRzIG1heSBoYXZlIGNoYXJzIGFuZCBzdHJpbmdzLCB3
aGljaCBtYXkgZXZlbnR1YWxseSBjb250YWluDQo+IGRlbGltaXRlcnMuDQo+IA0KPiBBZGQgbG9n
aWMgdG8gaGFuZGxlIHN0cmluZ3MgYW5kIGVzY2FwZSBjaGFyYWN0ZXJzIG9uIHRoZW0uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KPiAgdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkgfCAx
OCArKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkNCj4g
Yi90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBpbmRleCBhMDQwMmMwNjVkM2Eu
LjE4NjE3OTlmMTk2NiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2Nf
cmUucHkNCj4gKysrIGIvdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkNCj4gQEAgLTE5
NSw2ICsxOTUsOCBAQCBjbGFzcyBOZXN0ZWRNYXRjaDoNCj4gICAgICAgICAgZm9yIG1hdGNoX3Jl
IGluIHJlZ2V4LmZpbmRpdGVyKGxpbmUpOg0KPiAgICAgICAgICAgICAgc3RhcnQgPSBtYXRjaF9y
ZS5zdGFydCgpDQo+ICAgICAgICAgICAgICBvZmZzZXQgPSBtYXRjaF9yZS5lbmQoKQ0KPiArICAg
ICAgICAgICAgc3RyaW5nX2NoYXIgPSBOb25lDQo+ICsgICAgICAgICAgICBlc2NhcGUgPSBGYWxz
ZQ0KPiANCj4gICAgICAgICAgICAgIGQgPSBsaW5lW29mZnNldCAtIDFdDQo+ICAgICAgICAgICAg
ICBpZiBkIG5vdCBpbiBzZWxmLkRFTElNSVRFUl9QQUlSUzoNCj4gQEAgLTIwOCw2ICsyMTAsMjIg
QEAgY2xhc3MgTmVzdGVkTWF0Y2g6DQo+IA0KPiAgICAgICAgICAgICAgICAgIGQgPSBsaW5lW3Bv
c10NCj4gDQo+ICsgICAgICAgICAgICAgICAgaWYgZXNjYXBlOg0KPiArICAgICAgICAgICAgICAg
ICAgICBlc2NhcGUgPSBGYWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiAr
DQo+ICsgICAgICAgICAgICAgICAgaWYgc3RyaW5nX2NoYXI6DQo+ICsgICAgICAgICAgICAgICAg
ICAgIGlmIGQgPT0gJ1xcJzoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGVzY2FwZSA9IFRy
dWUNCj4gKyAgICAgICAgICAgICAgICAgICAgZWxpZiBkID09IHN0cmluZ19jaGFyOg0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgc3RyaW5nX2NoYXIgPSBOb25lDQo+ICsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgY29udGludWUNCj4gKw0KPiArICAgICAgICAgICAgICAgIGlmIGQgaW4gKCci
JywgIiciKToNCj4gKyAgICAgICAgICAgICAgICAgICAgc3RyaW5nX2NoYXIgPSBkDQo+ICsgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+ICsNCj4gICAgICAgICAgICAgICAgICBpZiBkIGlu
IHNlbGYuREVMSU1JVEVSX1BBSVJTOg0KPiAgICAgICAgICAgICAgICAgICAgICBlbmQgPSBzZWxm
LkRFTElNSVRFUl9QQUlSU1tkXQ0KPiANCj4gLS0NCj4gMi41Mi4wDQoNClJldmlld2VkLWJ5OiBB
bGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

