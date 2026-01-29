Return-Path: <netdev+bounces-254698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LvEKTo2e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841DAEA7C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE5C301178B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB4349AE0;
	Thu, 29 Jan 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9rxIACZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF251ADFE4;
	Thu, 29 Jan 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682485; cv=fail; b=LuckA9caHC8jCfCXFe11RzodxD/HeKxzDQ8MZxhpl20fF+zVJDGmRhb0haDA4vL8C5hYQRX0qnyaDwaK9icJonbun0hgJuooNzzs19NRXez3zTg7UFjda34O20Sd0MB5Y4hiMcOxkYfNSz/XgXktkPlbGiCcvr+7oiOoVyDwL28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682485; c=relaxed/simple;
	bh=kScWIhdh3d1EEwxDzIb4fdnCb9uiPTXZX8PwnKWzDtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dk71bMc+md8GzSP9LLMqVGyDCRaCe1nKdU0jOe1veFgWXGdKhrWvTn0bsLQ6JQJZxu9R30kjhZ2t3g3k98pMxYfxA82+fGU4qYvgBDl+IeNwoOrGztKeUt06nr+5s+HC6CqUicR+7IMhHOYVrF9z4zkIls6/7P5Xh/AppUbImeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9rxIACZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682483; x=1801218483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kScWIhdh3d1EEwxDzIb4fdnCb9uiPTXZX8PwnKWzDtA=;
  b=H9rxIACZ/FRRiI6nvCemjBBnXBD9XrgQ98CwUH28Gj3ApTUabeWcREdb
   JxEfe1bAFYV0bQU0sOwsLErQ5VXlnxQMEi1xzvVcmvgY/lkHDevxJJw1s
   0Ah50w1SWYqF6BU5M80AIVhp/1Y7lt3Ji5Hl8Pr+a10BYLyF4rW99jkH2
   7B6T7hFix/PYNtJDOK5CHr4TaMiqkeW7g27fnVrNjKDFpoUgPuBmZdcP5
   +rXkaHsKIXp/g+iumFcPz9aFTUD4CJSSP/P0ZtbUNfCPY8G3nFhU/Lnap
   PPmIAgChWnpu6aBk6j46CP5sUx5N+yVASNbLk+oJSifmfKthzCjE3VFDD
   w==;
X-CSE-ConnectionGUID: VpXH/LLKTjGdCO0+LWGvfA==
X-CSE-MsgGUID: xgv6ziIzSiC+sclHQqQHDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="58498327"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="58498327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:28:02 -0800
X-CSE-ConnectionGUID: FYfaKxZESpCeSPAyyTn2pw==
X-CSE-MsgGUID: 1Uy56AYvS9KHLNKryNAy1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="212624834"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:28:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:28:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 02:28:01 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:28:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B76Eperqtp8dyfiDhjc2C6QUPzLOPZPL33jPcKSONKJKDlyd+Vwa7aSollo+/L2Cy+s1qhW8pxCi+Mu/x61UIc0LQGREDZuK/wmVEsZtbW7t8jf7J6fzGtjUkJNLjLX72rioHV+Kiaf0fjsa1q+yWSogWprSV1VfpHH89Fs1CP4anaBWwJu8j0Tu/IgVC7Xv5vI0oUqYMN6qVGIMjobSQo4njHrrSVB0CtG9Wd+CXYFUiVnWa2cAQQMWHQcKQVeJsPL42dH2o15yMGwNUPE2IXdFepM4uFExfJRs08DMud9y41YfHu0Unb4h3ug6IfDn6Wh2U5erG42TNgi4zkKdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kScWIhdh3d1EEwxDzIb4fdnCb9uiPTXZX8PwnKWzDtA=;
 b=Fj1cgtjb3Ib+N7wMqoYzBY/BCp+E5BX4DGH1Zq+Oc6mrkqQQZyITALeRzdI2Fw6rmpoUTTyFEmG8By2VtL/Kan4qooEocOOPEbpo44ZUu18GJMUkIIGlFmf6kgxrKaQO437uR+R6VR3GutylIt/LLU2oAgRP0wWgJNgheSdPQtnGUzvQkboajAJrw01wAW8TSGLs89fe45irL0qhbYzfufWgKuS3+8PDqLFlH2VCNyKE8zKNO92+5Yp9sRZguI3ZLkOgtAeulcKcerwmG+YW0qaslYWlrcc7DTu2B08E57mBp6VTv9vowGnE+PahGoRkFP2of9zNSoNlcG3ge5gMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8225D2149.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 10:27:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:27:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 07/30] docs: kdoc_parser: fix
 variable regexes to work with size_t
Thread-Topic: [Intel-wired-lan] [PATCH v3 07/30] docs: kdoc_parser: fix
 variable regexes to work with size_t
Thread-Index: AQHckPaEsEOVLCjnV0a+kU335qK8/bVo8eyw
Date: Thu, 29 Jan 2026 10:27:59 +0000
Message-ID: <IA3PR11MB8986895CCD6207046CE6AD4EE59EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <1df8a82162411a720dfec076062263bc7cbbcfb7.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <1df8a82162411a720dfec076062263bc7cbbcfb7.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8225D2149:EE_
x-ms-office365-filtering-correlation-id: 761771e3-df2c-459d-6be2-08de5f21136e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eGhSZ1ZOb2JweDdLdHFaZzdaRWxXS2ZwNXJ0WXBUWHN4eHEvQkk1dmw3NnZC?=
 =?utf-8?B?b3I3cmthdEtsY1FTTlBmVUR0Y0tnMmVjdnUwSTYrbllzR3ZiNjRtQXczVVQr?=
 =?utf-8?B?RXo5N3MweVNvR2pKRzFRS0hOVHRldnJtb2xka1c4M2FQbWdETWlRVHQxemFQ?=
 =?utf-8?B?NHUzd291SXVydjJtSk1heFdvRGI0SEp2dXNwYzFRdUpLK3RNYzY1STBCRDNX?=
 =?utf-8?B?bTgrRTlDKzltQ0trYSthU1RMTklWN1BUc2lJSGZpbUY3NTFUWjN4MXlyV3pN?=
 =?utf-8?B?UmNVcmVxMFd3R2JINzZGcFZPMlE1UWYzU2Rwb2NlQzkvSFJBckk0QzJlM284?=
 =?utf-8?B?dzBpWmNxRFpBQUpoZjhQRWVWNzBWZFNpeWFKTEQxSlZEUzl3cVM3NnR4U0xr?=
 =?utf-8?B?dzBiRjczTVVyTTllOUNBc2RleUthUjJ2NWp4d3plOHJwVlVDVVREZ0RSM3RW?=
 =?utf-8?B?R2dMV0JqNWFTUm1UZDJQUjB1Y0YvTENwZUduclRweEk1MG5qVFptRUlML0VB?=
 =?utf-8?B?VUlNd3VHTkRhNTk5NVk1dUZzbnI5SU1UVkhhSW1HclZzTWJtREdLbEdkZkRt?=
 =?utf-8?B?VEgxVW56ZndrVkI2OTAxc1MxQWx0eU1pczZHSmFreGRoRFZ6MXFkVGIyQVFZ?=
 =?utf-8?B?V0dwcUtuTDBqR2FGYVRweWJqKzl3eW5hVlV4NU9SbElUVWtyS2FMekVIcHZL?=
 =?utf-8?B?YitqaTVmUTh1dThiVUdXYURVVHZ5aWVOSEp0K2FPUE5TWE41VlFGVXJhMkFa?=
 =?utf-8?B?Z3BjVXlCMzR6bVBvUEZMbjZpUlpSdnVzRjhWS2plM21oSUZya3krWDk3QzBP?=
 =?utf-8?B?cWd2UUxsZk5UN0RVSGhIcUpLMFNLTjVHd0cyZzVsZUxVWDZJWVk3TW9iYk9Y?=
 =?utf-8?B?K29KajNaTEl4d1FtWnJyNkNEVjY4d0ZVUVhkcVphdE1MRWhTT3JDczdad3Rp?=
 =?utf-8?B?cFVtWmduVFJOaVlLczFJejJTRDB1WjF6dEcySWw2czBWMEwrYXd6cjA4Vmth?=
 =?utf-8?B?VENLYVh1ell5Rks4YVU2TFpsTnpDTk1JMWhMTFpjZXU1YXAyNVBHSTdpM1Vi?=
 =?utf-8?B?YklaNjlYY0hZRnpFblVWZzRxb05MeWgvQXR2V01GTmp2V3RkZzlPQnFDalU3?=
 =?utf-8?B?UWFKOHJBOUhWVnhpMGpwOUFobXRaNi9uekNpQ0gxajU4UWpvNTZVYWZXNlMr?=
 =?utf-8?B?UzVva2w3TnFGY1BGUWp4dW52b0l6SzViL2RZTGNsN2JQSEs2aDl2bmQ3cm9n?=
 =?utf-8?B?ZE84c1JObDhvZGpaQjRKakxQNHJMcURUOWE1WXBGb1NIa0pGOXF2VmRlVUxW?=
 =?utf-8?B?Z3RBdi9HaUNTTzd6QVNGUDZmRm4xTE8wTEN4ZjhyQTk3VVRCa2M1RXNDTHVt?=
 =?utf-8?B?UW9USksvU3kyY2ZLOGZ4ZEY1a29yak5PTHdVd0ZqaStDUk14NFplNjBpMzFr?=
 =?utf-8?B?b2p0WE5jZzZGQTNsSHdqZ0dwdTF1NXFxSDdGcmxhNi9QS1dHSEIxYjJxeldY?=
 =?utf-8?B?TDVHcVFjKzJJWFhWMUE0OGtxa1pBWFBSaU03ZHNxcHlrUHdCaEFBSGpRU1VQ?=
 =?utf-8?B?bWZFWDI5UlFXUnBwRmtFdnhJMXNRV3RqQW5XR3RyYWMrZ2MvV3FoNWZvbkM0?=
 =?utf-8?B?M0ttUG1UNlI3TjFhdXJ4cnBMWFFjY3k2bkRiOUh1T2RtRFg1LzFJVVhmdzNO?=
 =?utf-8?B?a1RqRmxqTU15b2RLSHNESTNienpBeUdxYnJTT0l6bzQ0c0FhZXpUUHBtK1Nl?=
 =?utf-8?B?cjZRa3hTK00zdmZyMXpZckYxWjB3WlJEaGR0Q1R1K1ZKNGZNTU5WeWo0Y2ht?=
 =?utf-8?B?UlU3TldaYlRXbVduTFoyTzV3bzQzeUpiZ0pndDEvcXFwWU5TZDF3QTZaTDlD?=
 =?utf-8?B?Mjl6Z3QwaTFGNTNQcEJTaXpuZ2Vka3dKR0JHcEhQdVlqMlJiQ1VBQTB5VW1B?=
 =?utf-8?B?L0F4TUQ3Sis5TFo0L3lvSU5iRndueXl1VTZHNWVkQ2o0Z2gzVW10YStVSXAw?=
 =?utf-8?B?NzloYnE3OHZvOXFzY082ME5idy8wQmU0alFMWTF3ZndBYmJ5UzZITTRKNjV4?=
 =?utf-8?B?UlRlZ2VxVm5oTFZGQlBXWXFxaldnaHN6SStZc21oZ1J5ejdzeWFQWkIxdm10?=
 =?utf-8?B?ek1ibE5SNklTa3VlOFdERjZKOHpGYU5HR2hIdVRlUldOdytwb1hQd2RMY1Fs?=
 =?utf-8?Q?NF/EHUVqUGL1IfMlsphm+3I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmR3RDgwVnVLT2duNkVCU3NpSjJUZk14MWYzdjhMcTk4ZjBDVTN6eXlUa3dz?=
 =?utf-8?B?cU9VMCthTi9mOW5jelNjVWw5QXhCb0Jka01sbDVEREl0Y3paQnNZanVkR05r?=
 =?utf-8?B?cHdCRkhYTC9pbDlDcERIbjBhZkE2b2JHYVhWSjZqR2dEbnhjWGRwbUJuOFV6?=
 =?utf-8?B?Ym9ySGdmNVFVd3Q4YXBlZzBvZ2gxcGRXSXFyU0F6em5MNnN3QUQ5bW80N3oy?=
 =?utf-8?B?QVdxdUpLdHdqL1dna3JZeUFDVzlJN2wvQmYzc0JlUmMwbGJZV2F5VTVGaVpy?=
 =?utf-8?B?SFp3K09VazFHMG8xNU55ZTRuUlNBNFMxMTA0UkI4bkNRb25OS2t6Nmt5K1I5?=
 =?utf-8?B?K28xcTN0RXUrME9xNmpkbXRvSkRTZHJoV1B3OVN0SVF2aUh5MDVzQ1dZWUhE?=
 =?utf-8?B?T1dxdEpSRGxMVllGeGdLYUNhTVVWeWF0U05iU1RKNkdiT3VyZTR6RGx6a1ZV?=
 =?utf-8?B?R3hLTXJlRWd4T3c4S1RlS0JqVjdrcXNkTnUyRkhwVVdhWkw4UnpheEIzTFhV?=
 =?utf-8?B?L21aSyttNnJ4eXhtS3hJcUswYWRtc3hzTzZYeG9EVVcrbjlIYTBSZ0ExNUlK?=
 =?utf-8?B?STc0My9XSURqUndRQTJRN3pHQXVQU2VJY2JkVXB3RmVQd1NqclRaUUgxQnhW?=
 =?utf-8?B?TjRhZldkdjFSa0NGQ1hlYWRXUXV4ZDRtZDlWUWkyOUs4RllqY3NTOFFWREZR?=
 =?utf-8?B?ZW5Qbkl4RVVHRVBRb2hwbVJ0MnRTa2w0c2czS1BjYmtnT1c2VXZjOW51UXZ3?=
 =?utf-8?B?SEF5dnZHTU9HcEdTTWpQd1AwcnhvVG9rbGhPQVJCTXJ0Tis5RTFNcUZBbGFH?=
 =?utf-8?B?S24zSytkbXAwTlQ2U3B4eVlnVG8wWndncGV5SVhxdWRJSFYyU3N4eUZXWG9F?=
 =?utf-8?B?L1NwVjFJdzBIbVk5RVJGTzMvaFhwam1JSUV5dUx5K3dhUlpKS2FYQ0htSGJ0?=
 =?utf-8?B?WlJ4VlJ3ZUJ5Tmw3ai9tRW5HRDFjV1lVZGpWbWNVYmZReVlXR241TVd5Y3N2?=
 =?utf-8?B?TDVQVTJQdjBqaERoSm1GRitGNW4zOW1HakhZY1F6Z3JjYmhOZVAweXdiZFlG?=
 =?utf-8?B?Ykx2bzUzT2VFWmQzTDZsLzFwUTZxblBqRFFaeEgxMlF6aDBVRWtJTmVPQ0M5?=
 =?utf-8?B?QlRKc3V1Ukk0NkFhRFgzZU84TE4yMWIrRFRtb3ZuRm5kZXFrd21PSTZmOGQz?=
 =?utf-8?B?MExYcVRVSDVmTTl0TU5rTFJtLzNzVmVFSDY4emF6Zm1hWnNFTlAvYkhOVDJR?=
 =?utf-8?B?MmtETlZEY3Q5MFB4Q0hYK0VSSjBZTDkwaWVnWTNWbHNKc2FRMmd1UU1aR2Yx?=
 =?utf-8?B?K0tMbGFuWE84S01GaGhHcnN6S0IrdCsxUHZRenZYc1grUXh1UkUvUjZaUkpv?=
 =?utf-8?B?U0tNektxcS9tYkVNeXcyakl0bjJ4MXh1anhTNUdkOFFRMFJRSVQvUWxVVVQy?=
 =?utf-8?B?OUpmc2pHNGJ1VnZlZzM2SFQydzBoM3Z6OVJQTkh4cTdKdi80aDdqbkR3OUpF?=
 =?utf-8?B?a3FwWFA5YXpLQ2ZDYWhxbk81MFJtdE90UjNST2dIeDNkZW1jb2pJY0pockhQ?=
 =?utf-8?B?eThPQnhCUFdkMGo2YTJOYzh2WUR5Z0RNZ1lzWHlmYk1EWWlaNk9iZ2dwT3NH?=
 =?utf-8?B?Q0hDRG9vYzlQbTVBK3krTlI0MFJqUE1Iak1RbVU3bGZyRlFOQmRQeHkwZmVG?=
 =?utf-8?B?VU1acFdLclVtNWRSb1ZMUHhaWmZPd3IrZ2lDWEpIYXVnSzFXYWNYVG5COGVZ?=
 =?utf-8?B?ZE8wd1B5L2pycEkzbFlUdE51bkVvbmREN3NJWGtjZExuNDIzUC9BeCt0REtn?=
 =?utf-8?B?TDFXRUJUWG9iRWJUeVhxbWI3dDMrajBXUVRDYVJzREsyK004b3VmbHJBUy9W?=
 =?utf-8?B?MzJjbjhQczQ0RGRnOUl1MFZHM2ZsdGg2YkVFWGgxV0MzRGZ5Tzh6Z1QycTVm?=
 =?utf-8?B?UC9vNUFWalRKd3RjNDJQRG8wVnE2SnZGbGlaQy8zRm5QQnhKTGx5YkxoNlIz?=
 =?utf-8?B?d2NKN255UGU1NS94NTlqODhvQkk4VWs4Kzd1eVEvc2FPOU0rQitMMDA1VHRI?=
 =?utf-8?B?SzR2MHMrOWJHVGY5WlNZMEFrR3B6UzRVaEZId3I4akNQY3RLL0dXdVNuNHlw?=
 =?utf-8?B?WER4cU5qVldMeWt4clpjL0R3UjAvclNZVkJDOFBDRXdFWE85UGdCbTlTUDJa?=
 =?utf-8?B?NFRzVWk0NjNQQjkvSXJiMXJpYnptS0ppYVB0bERoN3pFQnQ4YUZKYm1Sakgz?=
 =?utf-8?B?b0p5eFJHVTB6N2c2N1BtRWJpR1V0N2VvRlJmM0FOQ0owQThKSm9lQ2dabUJT?=
 =?utf-8?B?TnhXbmNBcmhDWjVGeU9uSjFETmRsRXk3QWZxRzMzTHJhbi9xVjJHa3pTTE1v?=
 =?utf-8?Q?D7C7Df77ruGK9jVw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 761771e3-df2c-459d-6be2-08de5f21136e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:27:59.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhRFpJem9S2o2H6DwzZ+CPzJKqt6yQauFplViTEjVlc4j0gaB9ZF3arsTiF8whRHsF0qstsVgtL/Zz6mJOf6c6NN03+yef1oLpJ+bM4MF1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8225D2149
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
	TAGGED_FROM(0.00)[bounces-254698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,intel.com:email,intel.com:dkim,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lwn.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email];
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
X-Rspamd-Queue-Id: 2841DAEA7C
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
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYzIDA3LzMwXSBkb2NzOiBrZG9jX3Bh
cnNlcjogZml4DQo+IHZhcmlhYmxlIHJlZ2V4ZXMgdG8gd29yayB3aXRoIHNpemVfdA0KPiANCj4g
VGhlIHJlZ3VsYXIgZXhwcmVzc2lvbnMgbWVhbnQgdG8gcGljayB2YXJpYWJsZSB0eXBlcyBhcmUg
dG9vDQo+IG5haXZlOiB0aGV5IGZvcmdvdCB0aGF0IHRoZSB0eXBlIHdvcmQgbWF5IGNvbnRhaW4g
dW5kZXJsaW5lcy4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFw
QGluZnJhZGVhZC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8
bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4NCj4gQWNrZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBUZXN0ZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPg0KPiAtLS0NCj4gIHRvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNl
ci5weSB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19w
YXJzZXIucHkNCj4gYi90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4gaW5k
ZXggNjQxNjVkOGRmODRlLi4yMDFjNGY3Mjk4ZDcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9w
eXRob24va2RvYy9rZG9jX3BhcnNlci5weQ0KPiArKysgYi90b29scy9saWIvcHl0aG9uL2tkb2Mv
a2RvY19wYXJzZXIucHkNCj4gQEAgLTEwMjcsMTQgKzEwMjcsMTQgQEAgY2xhc3MgS2VybmVsRG9j
Og0KPiANCj4gICAgICAgICAgZGVmYXVsdF92YWwgPSBOb25lDQo+IA0KPiAtICAgICAgICByPSBL
ZXJuUmUoT1BUSU9OQUxfVkFSX0FUVFIgKw0KPiByIlx3LipccysoPzpcKispPyhbXHdfXSspXHMq
W1xkXF1cW10qXHMqKD0uKik/IikNCj4gKyAgICAgICAgcj0gS2VyblJlKE9QVElPTkFMX1ZBUl9B
VFRSICsNCj4gciJbXHdfXSpccysoPzpcKispPyhbXHdfXSspXHMqW1xkXF1cW10qXHMqKD0uKik/
IikNCj4gICAgICAgICAgaWYgci5tYXRjaChwcm90byk6DQo+ICAgICAgICAgICAgICBpZiBub3Qg
ZGVjbGFyYXRpb25fbmFtZToNCj4gICAgICAgICAgICAgICAgICBkZWNsYXJhdGlvbl9uYW1lID0g
ci5ncm91cCgxKQ0KPiANCj4gICAgICAgICAgICAgIGRlZmF1bHRfdmFsID0gci5ncm91cCgyKQ0K
PiAgICAgICAgICBlbHNlOg0KPiAtICAgICAgICAgICAgcj0gS2VyblJlKE9QVElPTkFMX1ZBUl9B
VFRSICsNCj4gciIoPzpcdy4qKT9ccysoPzpcKispPyg/Oltcd19dKylccypbXGRcXVxbXSpccyoo
PS4qKT8iKQ0KPiArICAgICAgICAgICAgcj0gS2VyblJlKE9QVElPTkFMX1ZBUl9BVFRSICsNCj4g
ciIoPzpbXHdfXSopP1xzKyg/OlwqKyk/KD86W1x3X10rKVxzKltcZFxdXFtdKlxzKig9LiopPyIp
DQo+ICAgICAgICAgIGlmIHIubWF0Y2gocHJvdG8pOg0KPiAgICAgICAgICAgICAgZGVmYXVsdF92
YWwgPSByLmdyb3VwKDEpDQo+IA0KPiAtLQ0KPiAyLjUyLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtz
YW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

