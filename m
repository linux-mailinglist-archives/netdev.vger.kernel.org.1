Return-Path: <netdev+bounces-205027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1FAFCE68
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010D618889F9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590802E03E9;
	Tue,  8 Jul 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhmSWa4Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78101FBE9B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986747; cv=fail; b=WxSWx3sMAcKq3w7REtRrXLqJ/bi9sMMMRQeWUEMN6IOh8MJZTB+8DxvQifILuxrpI2zywUXIz+cOLo2zg7FBgeuOautH9R+lwnwcpkgFX9Rx0hO1rnoq0b6Nrz4UuHpvRfVBgKaQdx6ZDMlLRXKUvrlh8r+vKITsIf9h1+VacTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986747; c=relaxed/simple;
	bh=tMbPmL9Rqd/CZ7fRcwBAO9NMVygOqwO1frzp5ovECAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvxtuvAG7/UVGWqvQqwIuLI2RBRXxPIgh5Qe9pTrgFhnVvF7dsdTqqkVfYK08mESOVf8Ds4OHdoOlPDNJCzDhLyPkLveDHkXTaLvn8RxTYORDWxPONm3XudFe0VDmQIAGEsRmVoH+PKj+r92U+NwEYfIEfbJ/lQa4pcfZq1frYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhmSWa4Z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751986745; x=1783522745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMbPmL9Rqd/CZ7fRcwBAO9NMVygOqwO1frzp5ovECAc=;
  b=RhmSWa4Z8INVjZy/aeV708j1Cls4H47m1Du2IiHJw3X3ovcU/wu2t700
   mzs9td2BHt6eRz3vFaSnPY0QPAdKXvrL+IXawo3CNuCnXmSR+AqhxiZK8
   yZAQ+cmyiWuX189GOYKAM6iNgq5//AHlkC/TNP3gJi1dMucx8P7JVGhy5
   1Kep3KnHl8p5EgpHf1s6t6OoycUbptkIFFWIvSvjtomvZS+xgFAGQcI/o
   6p6NX87MO9o3nOUAwqmQ+fwk2r9/dgsdLobbRN0ff0KssmDqnwJOVWSuy
   /FPCRBTyMU9m9MlmE+OlgqFM/Ld/R2IupZU4JwOthI8ocN/uy9sGCzQjc
   g==;
X-CSE-ConnectionGUID: QoOQ+GSWTxmfZfzrNtakZg==
X-CSE-MsgGUID: DGeLaqnhRX+ikiPOORcTew==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53436591"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="53436591"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:59:04 -0700
X-CSE-ConnectionGUID: gKyIigFYSweeY1bzd6yRmQ==
X-CSE-MsgGUID: gwg5+gxTTfmpRi4dS2QDrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159559389"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:59:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:59:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:59:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:58:59 -0700
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 14:58:30 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Tue, 8 Jul 2025
 14:58:30 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>, "Cao,
 Yahui" <yahui.cao@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 8/8] ice: introduce
 ice_get_vf_by_dev() wrapper
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 8/8] ice: introduce
 ice_get_vf_by_dev() wrapper
Thread-Index: AQHb4J/xImD+ld4V2katoxlqGOUyh7QocDfw
Date: Tue, 8 Jul 2025 14:58:30 +0000
Message-ID: <IA3PR11MB8985A1C87B18F619A28872CC8F4EA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
 <20250618-e810-live-migration-jk-migration-prep-v1-8-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-8-72a37485453e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: 35a3b641-4f18-4a03-da05-08ddbe2fe6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ei9zQmRHbkJlamF0QjdFUlRITjZEN1BLMyt5NzJLTm1TelYrK3NPZXVhVUl4?=
 =?utf-8?B?TWNMNndaSzBLRWY3alRHL0pTRE1BVGFQQlpFaGpkbEt2NmdTUTVqa0JiNDJZ?=
 =?utf-8?B?elhBeEVyNnFjY09BY2lyOE11QVEzNi9qVldCdlU2OXczSmYyZll3bDFSeE9n?=
 =?utf-8?B?cjhpS095bkMrak1adGdPd1pqQ1hhS3Z2SWE0T3daRlNmeXh2eWJ5bWhhbms0?=
 =?utf-8?B?UTlqdUJERW1GdmNzVllML3ZvZ3Nkb0ZwaDQ2ZGRiY0FObGtoY0hVNHk3TDFz?=
 =?utf-8?B?aFhhOXc2MmVhSDBaTDAydFkrZDBwc0owbHhzZ1NnZUZoTE5lWVlIa1dEWXVN?=
 =?utf-8?B?bm8xN3hraStIRzYvZHVQaWhiSVVKWlhPQ0Y2YVo4azFJNFhrL3ZReDlxMXRi?=
 =?utf-8?B?Mk9HL1pWS3JjQVVIVHNQQTRCd2NBWWNlYklKVGt2K3BMWDlPS1Z1UFBDQkho?=
 =?utf-8?B?S0lyODNRSm9ubjZXTHV1L29zVFUrRHNPclFRK1RraG1jczRDOXlHMFZEa29I?=
 =?utf-8?B?YWZGK1JKSmpTTElzVGdGUWZjR1c4YmdwdEdKZDdXTkN4SGU3cU9aczlEZzZ2?=
 =?utf-8?B?cmlzWHllOWVIZmFVdldyVW9LdXg2WThhZVZodVBoNHFISDcvcFJYS2x5SVR5?=
 =?utf-8?B?bmxyUEpGZlFweC95NE1qY0NKcVRkd3BYNE9TbktYZ2wyKzN3VkZPbWM1Yi9Y?=
 =?utf-8?B?SWs1Z3hQVGZCa1FaS29XR20zL0ZKWjRBM0hXQnJlcmUzdTBpTE9nb0xSNmVh?=
 =?utf-8?B?YkVCV2RJdWVhSElJZ0ZHblpLd1c1aURNTmVjU3RGdzl2VnBsT0lqTHpEa282?=
 =?utf-8?B?Wk1tMmtLUnBiUHpDdXJLMCsxUGs1RzZWOTAxL1A0elU2N24wWWRDRmNHVE5Q?=
 =?utf-8?B?aTJYK01rYUlyK2ZaUVFLNFQydjdEM3ZWcWI0UzRIV200WExnczFGdDMzSFVs?=
 =?utf-8?B?RmR0bjQ5UFlYZ1gxQkl3aDJpeFJsMy9TVStaZ3pOTzJMOTM1TE5EbE1nKzBw?=
 =?utf-8?B?aEZSQlYxZk13R0tuaW8zNm1tWWRXN01hZzJPUmdzQ0xKbU5rakhxS3RmVyty?=
 =?utf-8?B?bkJDTXVKL2RzajFSbVdFb0pDWEp3QjZpbHVIeHprVnAvNzdGVnJuTnZ2dWo5?=
 =?utf-8?B?ZVdiTFVOMndRdTZhYVpHeE9lRndEdmNUQkZRZ01lS1dZRStrNnphdzBBK21h?=
 =?utf-8?B?aGllN2FVb3lLMm5QNWtZZFJuQ2RxOUxEa0FLeGRUZHZIZmljcUJYSFRBY0Rk?=
 =?utf-8?B?cjBSY1QrbEJDQmxpZDk3Sit5dktLN2lMbmsySzI4YkxQK2lreXFzM09RMU52?=
 =?utf-8?B?MDg0SnVxc1RSYngrM2hGTDFhMnVaUUdvKytiR1BnRy9kQXM0dlF6TEdPQkZC?=
 =?utf-8?B?cUxWL1VsYzhVdndzWGhHRFZCVndWOXphazVQajB2Y0hhU3FWcVpqMU1Tblht?=
 =?utf-8?B?Z3NJdnJDMGlpV3RoZGdoaHlXSWJWR2FWdEhadWY1MUhWbHp5NHVPeEZTUmZ5?=
 =?utf-8?B?cTNWT1kzcS9PTUZ3L3hNdnVwMlNJWWgwZ3JCMkdQWmp1YlY0c1JtVHZpTE9s?=
 =?utf-8?B?d3g5UjVEWXFxcDNxTTB5bWFmODZpL0I4Yjgvc2VIZzE2MnNkU2I2SldmRnVx?=
 =?utf-8?B?dW1pM04rOGlUVks1S2pUeU5HYUJrZ2VlWlBWK29oSnk1MnhzTHpJWkVLS0NG?=
 =?utf-8?B?WWl1WHl4SW83Mk15cm5oTGZwYm1ES3NsaFhpdkFmM0JwQUZtc0o4OEpVZm5B?=
 =?utf-8?B?SHFVemM2NFRpZnA5UTZLVVlJQzBIM0orQ2U1YUV3b3duMXlBTjRMY0ROTzNi?=
 =?utf-8?B?ejVUQ0FiYlFISzd0M0wvR0o5czRIMWhUR29Gdm5JNTcxNHdpdThpb1orUlZU?=
 =?utf-8?B?VEt6UzJMQVl6Q2RBN3A4UzZGaFhWMEhPakw1N3I3dzhqb0VDWWUrZmtibGdJ?=
 =?utf-8?B?MzVlY01kWnc1Y3ZueC90eldVLzR2N1JLQTNKa2lOYWMwUkRWWktqSVl0YjRy?=
 =?utf-8?Q?FMexordn4gEA1wQWE07aMjU07TBDJk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkZMVGpFSUdzRUFQQ0QwQ1VlNUFiSHIxWG1UUzk0Z3N4MURFTk5KMXhXRzNV?=
 =?utf-8?B?KzdSbjhBQUdxeWRMTEpsRlZLZms1ZVBPTHkwVUtQd2tIOE5XdWNMYUVab3lq?=
 =?utf-8?B?Rk1YY1ZjWVU2R3dtUHBsVFAydGYycXgwMnprK1ZlRVBMTWNBTXRzN2ovTDMv?=
 =?utf-8?B?Ujc4UWY5aGJpSWlsTnNwN3ZnTmpmamorUUZ2WmdZbVhCemlOT2RMVFlEcyti?=
 =?utf-8?B?ZVIySlNYLzNVOGI3U3RrSVlseE5xKzUxWXgrM1BaT1Y3a1J3cDFleHlSNFRv?=
 =?utf-8?B?TTZjUUdVMWhlVFdvUXNlZXBUYlZIL2M3aEs5SHlWckVPNTFBbkZreWJPdmJx?=
 =?utf-8?B?T0VpMm1mcFkwQTBKNTRTbSt5ZXZHY3h4eHFQY0dTajRXTHZEanMvNERGNHFz?=
 =?utf-8?B?YU5sWmZwVlF0ODl5NWhkSXlWeHlIRHNJVjZNOVF5dERoTGlYejdwZ2JVWXJ4?=
 =?utf-8?B?YzFDZUlDeVIwVzdSd01YWmJxaDJqdWRGSXF4em9rRlRVc1QvNWJCbzVIeE1V?=
 =?utf-8?B?eWM4UVpSUkgwU2VabGtLT1EzeW1Rb3VuaXRQbmphQ29VSFV4VFo0ekRxVFlS?=
 =?utf-8?B?TVRrQXpuRitNWUZwUmZIUjNpQkNnTERlQWwyRjZqN0hJQWUydlJBMWQ1dmlQ?=
 =?utf-8?B?OG9sTjlJS0pIQjUxZ2RySzNtMG43VDRIbU5GQzFRRUM1VFlQWEJCdS9rUWJj?=
 =?utf-8?B?MTFkc3plZ0dFUWI4cTIybGdPN1pTT3Qwejd1OXF4cmUzZzRrT0dHUnZuSjhN?=
 =?utf-8?B?Y3AwUmpzK1B2TjBlS1JoV2puQnZ6VlZYOXh4Ym00RVlsT3J1VzFYQmhXbVo3?=
 =?utf-8?B?T0Jadk9kL0l6bEM3UVI5QWM4VUJTa2d2RVZVb0NQaXNVTnliTXA4ODZMNXJH?=
 =?utf-8?B?Sjgzd0h6Q3I4bnFVdVpRUjFBeXgyeDVUbWdmeXRWd1Mrc29KRllHR2lBZVc4?=
 =?utf-8?B?VWdLaDBhMXkybGhGSGFFaUd6NnVqTGFmVTczMCtCNzljL2wrUVdUWVNicjVj?=
 =?utf-8?B?MHI2VC9xc1kvc2djSnRJdW9SVUN4MzBXUzBwVGM4QzVQQUlFWTVrVndhcUhs?=
 =?utf-8?B?M2VxL1ZRS3l0eHMrRzRLTDFCL1d5My9ZQlVWcVFDVnNGQUVsL20xZzk3WTQr?=
 =?utf-8?B?Q2Y2bFUyL1hzT1lRc2Y4Tm8xRmRlREtoYko5WXV4RDcxb1NtaFJUc0JDOXBG?=
 =?utf-8?B?M3l0M21uU2pPeWtmTUhWcnJzUyt2bmpRRU9lS2hHVGFwRlo4aUlyTUpub1Iz?=
 =?utf-8?B?WXRGQnk4REVYQUQ2N2F4YzVQS2FMNHViQmhoMkFzZmtrYVVSYjZNTFRpL3ZW?=
 =?utf-8?B?WGprVG53MnJjbnVITi9pekFEZkF3MDY1aWc4WWtUQjhqeGw1aVFyM0FZMHpu?=
 =?utf-8?B?ZW9ldFFKcXVZNzY0MlZydkJ3ZTUxSExYc2dCUFlWK1dNdGdjakprTUFJemxr?=
 =?utf-8?B?blhjRGpxcFgvYUEyRitqcU0xYmtjV2xQMEdldnYzcjFNdTNIQm15bUJYRTRz?=
 =?utf-8?B?MDh2N292djIwMFhmY1hrSmpFWVA0Y3ovclJwZDdBV2I0UjhWODAzTXNBTWx1?=
 =?utf-8?B?ZTVEaHNUajRUaWk0b1lVeFpUdmZpVk9hK1hDR1VXWUt3TnkxSzk0WEdLL0Ey?=
 =?utf-8?B?NXVjMU9STzRDa2w2bS83SHV2dmVDMWx6UktoUEg0QVdXU3dIYzQyNkhScTBo?=
 =?utf-8?B?QUZ6c2FCTEdrc0lPcEJYVUV0MkttNkt3ZHREdytxcXlGUy95K2RFSzF6eGpq?=
 =?utf-8?B?UGsvN04vczhuTkFPRDhnQnQzWjQ5dmpRLzE0T21ZVnBCZHJKeE5QeXVLVVRR?=
 =?utf-8?B?ZlBwdUFua0hwamJWMUllenJ4Sm9CL3F3NHNkY2JUQWdYNWs3TkY3d0c1YUtt?=
 =?utf-8?B?a1VkbnNxbGRlaExMVEN0bktiSFVNOUVlNWJBZEtLVUxlQXZ0UHZHclVtWnoy?=
 =?utf-8?B?cDlMRVFIUmtCdDhVQnF5b3pQVUphSGw4S0Nackxma0s3YXY4N2dCLzQvZExK?=
 =?utf-8?B?SVZkM09iWUc0UWRSWWY5S1VxS3lVTTI5R1VxbGhzMG1SWXdHbFg2M2tpdmdo?=
 =?utf-8?B?LzNLd0hrWVdHTEtHY0wzaFlNbitKYloyUk5lQWhrZjZaN2VFSWY2WTl6aGZB?=
 =?utf-8?B?cnVrcXVjd1J4UkZTQmZDWEdLVkJXSndoL2ZBTDNFQzRZZXFUcW10YWxhbWor?=
 =?utf-8?B?ZHc9PQ==?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4a+67msjKoi/F2ImdFPE65soBG6IsiOvp1zw7QC2vwd6axQ++AT6bX8urxmEvIB28NxsP6OtuMURaWH+Iugt/znp+rBbAe0IEJqJ3hS4y03pKW43TIS70K1w6JPFqBGygKeu3ircHmG7Ghx5rr2HeXIUhsI3xVMcQemdDN95ZurxML1I6JepU0ughtTIRlIAST73d9aYJI0FD+kZrVKr0TJb4pf2gQxl5E7TqY0hch3s8QCrMB9O7rWZDkj9cW1LftKzAEo9V2joK4pTZVai8RFIa7uE91JfLK63EF8oM3jM6XdE4rF6kxnTHV/RtQsqKqwH7O+0t0lJByJ24UQfQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzteR9qcji4FDBBeyJi6TM9LLPrTYT8+QXbWflH+eIU=;
 b=mAt6m2tcryjPns3jpp/WxpldQGyQTwWlm/3afJXufcAWsLKElc7Fvab/FfE59mtkEgHocKymUqM/jFMmat2FM4CNHO7xAVEpAaSn1wBru5Uhew2uWNcRtLwV8T/7WnAO6CQchNmUsbZmM0mOvdMjPQc63YbHaM3rQmwHBdKG1KVfLrLO3EzC3Q4/4Gx5sMnMhGM75NNlUFRHTLXz9/9zsj61TwZjdYi5hV7vizPSQN7uD4Jp4UArF0tzwwDki6JIA1rYIcMKL1gmtpzMQYl+pJIWsqEspXWmk2l1OB6VYYl1daYRDH+6TST8NOSz3P8YBuO9HoEm3mnY6XItWXlI4Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA3PR11MB8985.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 35a3b641-4f18-4a03-da05-08ddbe2fe6fc
x-ms-exchange-crosstenant-originalarrivaltime: 08 Jul 2025 14:58:30.4014 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 4oSxJGfoLDGFHwszivgRTKAIzzAublghYwhA5UlCpfCGMyGESBHy5Uxd0y66fFe4dHKVcN9s094IL2GrWH4hRHYOrhNmPmAEhQ8qU6IiiVw=
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR11MB7300
x-originatororg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBKYWNvYiBL
ZWxsZXINCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTksIDIwMjUgMTI6MjUgQU0NCj4gVG86IElu
dGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+DQo+IENjOiBL
ZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IENoaXR0aW0sIE1hZGh1IDxtYWRodS5jaGl0dGltQGludGVsLmNvbT47IENh
bywgWWFodWkNCj4gPHlhaHVpLmNhb0BpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFU
Q0ggaXdsLW5leHQgOC84XSBpY2U6IGludHJvZHVjZQ0KPiBpY2VfZ2V0X3ZmX2J5X2RldigpIHdy
YXBwZXINCj4NCj4gVGhlIGljZV9nZXRfdmZfYnlfaWQoKSBmdW5jdGlvbiBpcyB1c2VkIHRvIG9i
dGFpbiBhIHJlZmVyZW5jZSB0byBhIFZGIHN0cnVjdHVyZQ0KPiBiYXNlZCBvbiBpdHMgSUQuIFRo
ZSBpY2Vfc3Jpb3Zfc2V0X21zaXhfdmVjX2NvdW50KCkgZnVuY3Rpb24gbmVlZHMgdG8gZ2V0IGEg
VkYNCj4gcmVmZXJlbmNlIHN0YXJ0aW5nIGZyb20gdGhlIFZGIFBDSSBkZXZpY2UsIGFuZCB1c2Vz
DQo+IHBjaV9pb3ZfdmZfaWQoKSB0byBnZXQgdGhlIFZGIElELiBUaGlzIHBhdHRlcm4gaXMgY3Vy
cmVudGx5IHVuY29tbW9uIGluIHRoZSBpY2UNCj4gZHJpdmVyLiBIb3dldmVyLCB0aGUgbGl2ZSBt
aWdyYXRpb24gbW9kdWxlIHdpbGwgaW50cm9kdWNlIG1hbnkgbW9yZSBzdWNoDQo+IGxvY2F0aW9u
cy4NCj4NCj4gQWRkIGEgaGVscGVyIHdyYXBwZXIgaWNlX2dldF92Zl9ieV9kZXYoKSB3aGljaCB0
YWtlcyB0aGUgVkYgUENJIGRldmljZSBhbmQNCj4gY2FsbHMgaWNlX2dldF92Zl9ieV9pZCgpIHVz
aW5nIHBjaV9pb3ZfdmZfaWQoKSB0byBnZXQgdGhlIFZGIElELg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3ZmX2xpYi5oIHwgMjYNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc3Jp
b3YuYw0KPiB8ICA3ICstLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfdmZfbGliLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3ZmX2xpYi5oDQo+IGluZGV4DQo+IGE1ZWUzODBmOGM5ZTUzZDZlNWFjMDI5Yjk5NDJk
YjM4MDgyOWE4NGYuLmU1MzhiNGVjYzZjZWM3ZDhiZDI2Yg0KPiA3ZDE5ODE5N2ZkNWMzZWQyZTYw
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3ZmX2xp
Yi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdmZfbGliLmgN
Cj4gQEAgLTIzOSw2ICsyMzksMjYgQEAgc3RhdGljIGlubGluZSBib29sIGljZV92Zl9pc19sbGRw
X2VuYShzdHJ1Y3QgaWNlX3ZmICp2ZikNCg0KVGVzdGVkLWJ5OiBSYWZhbCBSb21hbm93c2tpIDxy
YWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4NCg0KDQo=

