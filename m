Return-Path: <netdev+bounces-117290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71194D7BD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E651C21FEB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329715FCEA;
	Fri,  9 Aug 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6hBw5Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58A1465BA
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233361; cv=fail; b=QXcHlkKVpahqUomTYgjrzrNJK43YdcfWcBQQUBBb3Xcn2wJFlwLeBqDuHdqPEDwVLOxtEVCsUDFcDLuF2R0nzmwE600fOSKOfGhzsAoSOQ0wpzqAogEv3PTXMIY+6FWb6DyXcqIxFvTBDuhywNyXq5m2JpVZXGZLNCEA6p0OWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233361; c=relaxed/simple;
	bh=P/C/m0oj0E/3nhDLJHlZzrVBqa+JAeNxhukM3Qlo868=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNQlwPrX8va0GXE0tIxg+/qm/ZL0qr1T8w/i/llO7ojUkzOjPsUo2e5KVuT8lv39feINffeSkNElbZgqF684MO1ezIv+cFvhJFN5INuNgYH5UvedXJAIL8TJAj0gyDrecXleOs+hoOA/E66VHo48PU5QBKJcXi4lVqvIjGx7hwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6hBw5Jl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723233360; x=1754769360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P/C/m0oj0E/3nhDLJHlZzrVBqa+JAeNxhukM3Qlo868=;
  b=E6hBw5JlLr3ctMqXjw2zlBElS7egex2tzIRtI17lLvHmPdy5T7JR2Dk5
   YNbv9Suy30jJhI0nVEUbLYqWRRL1fQBCo6xgKf2aNAJVikA2DvYC3E8V6
   ZdbOoFv/LFyS6BLQ7N4TJJqyrr+AE4coKvYTM6yMB6GZVWg9S8RJ7Yumh
   EWbdu0h9mCXR0zFXYYzdoQdhiAlHRZfZj36XwKynZ03U98RH3HL8C1EUc
   ZB0iIl2T7fRtrJcwL2Cpx8878G17zPWdZoQtDaQo0ndC7pDYpb+TdUgaF
   Zc/yX2Zdc9Qui4zrh9D8l+b06uAGW3FmU4UapNBb+ew+8JNw3s+LiqiDI
   w==;
X-CSE-ConnectionGUID: 0U3OB5zUSHmB4CkMJVNFmw==
X-CSE-MsgGUID: oXAIe6cMRGmZNKTNTLIgQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="20986888"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="20986888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:56:00 -0700
X-CSE-ConnectionGUID: m1ssjEVRTFaAsNthhKh1uw==
X-CSE-MsgGUID: G3haGr1FQMGpfSHgaruKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="88306593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:56:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:55:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:55:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:55:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC7nfBNjShyVWopUKpK7AYYj0DMYj/Djn9y3Xu/DjyFQoGzAkO/fiUdPTtRpYHdDdpfY/1UuuUq4h7SQbwSxun/QjLbBUyA8QFJJPaLWOyMKo1lvxACvpUwHontH4FipjR7m5U+mc5yQrxTUf7IVagohIRi3GLqPATU9oW1K8mMCmtoI2KL7K8ZIpfzJuWpVDaf5XGKNBUjs+DWxXMIcpYsIjEV/F/YeAJKATrJe2pDmg5G8+9Chieb+Tgx+r6B+/jb5g7yaL+3Z73gigJKHn9ZG5zZtVT7fNemRyfAHYxU/P96b4gSLhKaYkFERdca5Dwgftyj0SvbUupJnsIEWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/C/m0oj0E/3nhDLJHlZzrVBqa+JAeNxhukM3Qlo868=;
 b=OpLy/EZNBIgVOHAPJdXrSNtEJOYjj9SqVG92pPtPmMs13y1DiELv/25A8werOI1cjXmrwipfzaLgZCcofP2R5R4f5DTuWcd7ZBLzsBFtAv2tBqb/yRSP0ZPwIdUXQjZSMyI6rH6mvfrBqxMy6btDYvDTa2OSfoED94nkG/hT6roBQYpfDOMWEcDgeehxpvjqNf4B0dmMzjm6mK3hkSMwBx6vV1tbXng1f3KwfPmNlhMDewhYfU+bYDchRNcgPRNEFr8mQJFfJpJssywY+HsST0NSxAFekPWfvJfDxWDxcWDBrTbJASXll+ooDH94xQ+4oOOSAiUVsFAGcSlBPZrS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 19:55:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Fri, 9 Aug 2024
 19:55:56 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Polchlopek,
 Mateusz" <mateusz.polchlopek@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, Sai Krishna <saikrishnag@marvell.com>, "Simon
 Horman" <horms@kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 06/14] iavf: add initial
 framework for registering PTP clock
Thread-Index: AQHa4mLKMrRnJ3+eik6qZCLJt21qerIPRzYAgA35foCAABZgAIACEDkA
Date: Fri, 9 Aug 2024 19:55:56 +0000
Message-ID: <CO1PR11MB5089864325798E18DBBA9815D6BA2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-7-mateusz.polchlopek@intel.com>
 <390393c3-b4ee-473a-8055-813130876e71@intel.com>
 <ed34373b-1afe-487c-bb35-3a62e4cfe4f9@intel.com>
 <e562774d-162a-4b42-b286-28a1feb77b62@intel.com>
In-Reply-To: <e562774d-162a-4b42-b286-28a1feb77b62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS0PR11MB7458:EE_
x-ms-office365-filtering-correlation-id: fd1121a4-909a-4d4f-c3a7-08dcb8ad4884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzhIZkNRTCsxdy9MSkxRaVZEY3JXM1R1eE82T01LSzlvdnBQa1VGS1dlTzZy?=
 =?utf-8?B?ZFVhU2tzSnJIRkNlZ1lvaDg2SVpiUzdwTGNMOW5SK2FFbG8rZXRRNTFwL3ZQ?=
 =?utf-8?B?Uk9SVUV5R2pJK3JndEFwNDQyQXNYdXMyemdZZGRZWjhwd1ZtTE83eXo1ZWdw?=
 =?utf-8?B?eEM4WldJaHVWTmlld3ljOHdoQjFqMFJPNWZBYjBFSlFKU2o0SEhna0haZnN6?=
 =?utf-8?B?czExNjc3ZjY0RnpKV2R3T3ZUWVp1d0tuKytpMWR4bkdBcGhjNFhmUXRsSlpD?=
 =?utf-8?B?cEszZDNOVUNERUlFZmFPNDFyUTJtVHdwTEkvRk9EYnNDZnlIcCtHQTB2UmZT?=
 =?utf-8?B?YzVtazJqRGs2RDNRNzMwS3FjNU5wMU9NZmIxVUp4UGx1ZTd4QjBYTk5CbkhO?=
 =?utf-8?B?bUFpZUFBR2NrMG85RitnNnRtREZGdWhoUnJreDBURm1KaUlnVVhIR2ZJc29S?=
 =?utf-8?B?VlE5UmhpbU1oU0RKQ2JyMGhLZmVTbWtHU3lJSDZLZXhBUHVFVTkwVUlXM1Vl?=
 =?utf-8?B?RGpDL2tqQ3pYQ2dKc0l5MEQ3U2xrcnBINXlTSVhqd2d4Q1VtZDR1SVpnbWxL?=
 =?utf-8?B?NHc5YW5TMTJHUnhRVjZ4bjI0Z3RMV0ZrbzNqNng4YVdWcG9lSGJaVnA4KzY5?=
 =?utf-8?B?dGM3UEplSUF6cElqcjA0OEFDZnhia01ZUVFEQ2ZvVEF2NVhIRjdjb3VMOXBC?=
 =?utf-8?B?NmhmUCtXTmZhNTNqYytTVlh5Q1drcFdFbDFKaGxVRUFQL00vd1pZSjJTeStK?=
 =?utf-8?B?ODJzWHNlOTJ1cjYzUWlBZ2JUUTBsUzlnTGZqOEdGOE4zNVUwK0hiK29CRjVR?=
 =?utf-8?B?WmxaRHVwYkxWc2lSNDl2ZzZJWFRGN2g3SjF2dzBRQ093cGIxcEdNaGVMMTRq?=
 =?utf-8?B?dTNndk9EdEpYdHJwWGtObFUvTXBRTFp2YnRsYTk4VnpvWkpzbTJ1SytiTG1j?=
 =?utf-8?B?YWd5WEpadkJUbHd3alVZQTBxQ0hicTVRR1dlVWl2Y25EblhjSFZ4bTBpN3dn?=
 =?utf-8?B?WFNCSUtoYmR5MkdWYXcxN1Q2NUx2QVJBVE9oTERucm8vUFpJUFBzYmZGODNm?=
 =?utf-8?B?MzYxdlU3bEhJVEpnRGJUbzBkbEF5a0U0UlE3OFkyTC92MG1ETndYelg0V3RT?=
 =?utf-8?B?ZmI1NW1NMVFNUXF2clVnUmZSNE5UV0YwaWZTNWN6Wm5aTlUySXB2UzIrZVg5?=
 =?utf-8?B?OXVsdFRWNXhpTjg5M2ExMzdkRHZiY1ZUczBiMVFsdG5XMFhpeFV4VzhKR2dq?=
 =?utf-8?B?OXVYeTJSVkhza1N4bEhOSjdLWEpjakZOdGFmL2RlYlB2TSs3QU95Ylk4WExS?=
 =?utf-8?B?dkwrNkJoRG5UVWhRVElVY0VHQUVYYzZtYUxDdVB3NlY5UzA4TTZVKzVaNmtS?=
 =?utf-8?B?VkRZcU1aVmJLK2xycTdQOFFGLzZZVzYvMmdHY1VMYUhSbGxUNEVaZFVHRzNu?=
 =?utf-8?B?b3l3TkZSVUxTd0FRSXlDL0VsNVN1T1NoSHVtcTB1cmgvRFNLcWJZZlpXQmtn?=
 =?utf-8?B?a0pPVkNSMDQyMVBDTDJCN3FhbTdoRGtVM01jWElIektNSU9OQUF4eUlZNUVO?=
 =?utf-8?B?MUdJSEhQSi90RjFVdG1Tc3EydHlTV2VoSEhaNElZZGVhVXNTbUV0WEJyd0Nq?=
 =?utf-8?B?UUVSRUV5aVpDb1RvaHdITHRZRC8xOUc2OUdkK3BGcFlZeFRtN0FMRlltcVJz?=
 =?utf-8?B?eHI5MmJFMXRNbHk3VzNMdnFMS2NSd3R4dmQ1MGtIekh6S2R1UGhiYUFISlNV?=
 =?utf-8?B?cWNLaTlMVHNLMUV1aEtISjdjUEtHRFNNY0YyekdnTFUxakliMk55QmVOWVph?=
 =?utf-8?B?NWg1elRTVU1IVW5aaSs4LzJWdnE5MW1XVHA4T3VWL2p4QTMza2g4YlpoSWNU?=
 =?utf-8?B?N01JNVhkcFBpdTY2UXNGeTR5bkNKY1BFbmlHdm1Tem9jYkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkExNHpjbkg2ZlFEbTJSUzRSMExHRk96dUJnMHI3SU1pdzRwZXpqSkJ6L1Bj?=
 =?utf-8?B?Q09DbmdSRG8xTG9FYjBvQUJ5UE9aa2lMM3lIUnYyQVNuSHVDdExQM1RERzlQ?=
 =?utf-8?B?R1RFdUgwTzVaR0FNaXNQUlZqSUZrc2FmM3h5ekZsZElncWZhcVV0U1lGSU9z?=
 =?utf-8?B?WWcrZTExY0JVZ1plU1ZocHZlT2hYQWV6OVJQd253UGdjZlk4bGY4SE5LREk0?=
 =?utf-8?B?ZTBqa3BzbnBsenFqd3F4a0dhczBKWFp3KzlHWXRyUzNqZU1BV1JzR0ZMWitL?=
 =?utf-8?B?dlBNT0VmZjRqbkJBdmpPL29VRk1mR2d2ZGhmZjNFLzU2TEl1QUNVNXZyNHY3?=
 =?utf-8?B?QWFFRUlhMTlMM2hZTFBhSEFyTmhQTnN3VHY0Wm12c0tyQjZ4eW5tckRydGk1?=
 =?utf-8?B?YTVZclh5WWNzY09EMmFQZS93MDVFTytxMGtHS28rRWJSL0dKdW53UnNPZGFn?=
 =?utf-8?B?T21KUzdVMWliQmxhN3IvYVlhVUFyem1uZ09rV2pwN0ZHSk5DdzR6elFQNXpp?=
 =?utf-8?B?WXdyNklpdWNncDAvUk9JZktudjliSVFSTmJvNnlYVmI5NEQ0MGpvR25SVXVq?=
 =?utf-8?B?THM4WUZKSC9wM3FKRmp3YUxkM1RWdmowQndzZWcray91Yy9TS0ZPSGVoQVFE?=
 =?utf-8?B?MjNGdUdPL1NjR1pidHFla0tQSzEyMVhhbGJWWWRsb2pYMlNlcVFvN1FGckt0?=
 =?utf-8?B?MzYyNnZMMjdIblRKeXFZMDRBbXZUdUU1V1lkUUdFZkZpQnhOQWg3UkR2TlEw?=
 =?utf-8?B?MzZMemNPd1dFMGtabGVtakt3VXRXOUdibHN6UWJiV05TUjNOMFNrUjBmWjVY?=
 =?utf-8?B?S3lWT3J1YnFWQlhxU0Z2dHNpZzhPUFhlZThHMStIUnN3SXJKTkdMNEs2Lzcv?=
 =?utf-8?B?SWwzRWkrcEl3bkc1UFdtN1JsT2RtSVlGU0JnN3lGWFprYUJ6QnBiTUJDaXA1?=
 =?utf-8?B?Mm9DcEhvaGFIZGllRW1VcWM4UGY4V1lEYk9oSndSSXBVcjFVSkdwY256NXZj?=
 =?utf-8?B?QUsrQzlnYklNR1Z0QllrbEJLN25nRlZCbnJqaVpWblRlUFV2dXluV2t2V3Z6?=
 =?utf-8?B?aENYUjduN1l2RzFsOEdkRDJpNy80S24rQitlVGliMFUrWi9ZL3ZqZ2w2MklS?=
 =?utf-8?B?SlZzalQrYTcrWDZPQk1md2dBekl1MnZKTEt4bzhoRjZna0lGZzNCaEoza28v?=
 =?utf-8?B?T29KOEhRK3VjYk5UWXR3Y3FIYjd5ZFVXYXZWQlJnY1VNSmxxTjZUYmpYbnMv?=
 =?utf-8?B?aExDblgyRHBEbjZEK0pYdE1oTDlYT0pPQXh4MFhtY3V0aUtHM3ZOTTV0TE5u?=
 =?utf-8?B?dkhlaHNKNCtXZWthb0o1aTN5SnZnbDVwWGdPcDFSM0ZEcXY4a0VLSGh6ZzNO?=
 =?utf-8?B?Y2FTaXAwYTdVSVM5a21qcVNaajZWYmZFU0VDUXRhWkNHM1RnUERwRVJEUzV2?=
 =?utf-8?B?SWozSGpGZUtNMURJMGhMM1NXemt3Tm5PNnU5UVBwYllBWC8rRmVxNzBDL0xG?=
 =?utf-8?B?NjlqN296b0gzUHAzUUtpc0g2dC9JU0hSR25nK0JUWnFwbTl2aXZ0L1hmOCtz?=
 =?utf-8?B?czVwSUxhZ051TkY3dHhIS2M5R1ZNd2NkcktxVng2UjVyYXZsSG41RTFJd3VM?=
 =?utf-8?B?Ylh4Z2VCMk9Bck1EVFg0WjZOV21OY1d3YjFuZ3QzTFpnblBzR21MVXBVNDRB?=
 =?utf-8?B?cVlRRjczK09jR2xkT2dodWRaMFVQNmtqbjlOeXJMWTBBYXVQeU12SmNJSjRF?=
 =?utf-8?B?SDZsdERFNUduTEp1Y2dLSzZuNUJOSmwxRkprSlVYMDhyZUowcEhrSDl0SHUv?=
 =?utf-8?B?RFdZMG16YXIyRDVNNnJmcGRiVDhpSldFZFk4Ny9WUDF4ZHNEaDhmNmYzM2lW?=
 =?utf-8?B?Q1F6eFg1RFA2azNpQ3VxTkFBRndER3MxWXVQTHRLYnVRUG1JWTlZVWxkR1NC?=
 =?utf-8?B?UGMxRWtIRUVNaDZTWExWbkdRMStKMWZBOFV3T0lGUnNRcG1qTkhNS2pIczRo?=
 =?utf-8?B?RmpHNWUxcXN6dlp3ZFpoRG1ZV1kxK3VjMXlieGFPV1lCZytvRFU3L3FBSVZT?=
 =?utf-8?B?N3JUaTNHUTlkejBrb2I5RlJRZzZSTTNuNlpURFNRZzhwV1ZEYWRpMHVpUXc0?=
 =?utf-8?Q?0n/dHYXfzS/JsYUwUZhtWtdIB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1121a4-909a-4d4f-c3a7-08dcb8ad4884
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 19:55:56.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLJQdh7xQyxkODeBZJZHkR+v91Oa/fe0ROQOwLPw1hh+K8FqSe3tHMbbRlC2IpXv7HF9mjZcCFgKV9s7s/+cgb/Xt5BgGc1LMNl+FlSHle8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9iYWtpbiwgQWxla3Nh
bmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1
Z3VzdCA4LCAyMDI0IDU6MjUgQU0NCj4gVG86IFBvbGNobG9wZWssIE1hdGV1c3ogPG1hdGV1c3ou
cG9sY2hsb3Bla0BpbnRlbC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgS2VsbGVyLCBKYWNvYiBFDQo+IDxqYWNvYi5l
LmtlbGxlckBpbnRlbC5jb20+OyBEcmV3ZWssIFdvamNpZWNoIDx3b2pjaWVjaC5kcmV3ZWtAaW50
ZWwuY29tPjsgU2FpDQo+IEtyaXNobmEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPjsgU2ltb24g
SG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgWmFraSwNCj4gQWhtZWQgPGFobWVkLnpha2lAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0
IHY4IDA2LzE0XSBpYXZmOiBhZGQgaW5pdGlhbCBmcmFtZXdvcmsNCj4gZm9yIHJlZ2lzdGVyaW5n
IFBUUCBjbG9jaw0KPiANCj4gRnJvbTogTWF0ZXVzeiBQb2xjaGxvcGVrIDxtYXRldXN6LnBvbGNo
bG9wZWtAaW50ZWwuY29tPg0KPiBEYXRlOiBUaHUsIDggQXVnIDIwMjQgMTM6MDQ6MjkgKzAyMDAN
Cj4gDQo+ID4NCj4gPg0KPiA+IE9uIDcvMzAvMjAyNCAzOjQwIFBNLCBBbGV4YW5kZXIgTG9iYWtp
biB3cm90ZToNCj4gPj4gRnJvbTogTWF0ZXVzeiBQb2xjaGxvcGVrIDxtYXRldXN6LnBvbGNobG9w
ZWtAaW50ZWwuY29tPg0KPiA+PiBEYXRlOiBUdWUsIDMwIEp1bCAyMDI0IDA1OjE1OjAxIC0wNDAw
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+ICtib29sIGlhdmZfcHRwX2NhcF9zdXBwb3J0ZWQoc3Ry
dWN0IGlhdmZfYWRhcHRlciAqYWRhcHRlciwgdTMyIGNhcCkNCj4gPj4+ICt7DQo+ID4+PiArwqDC
oMKgIGlmICghUFRQX0FMTE9XRUQoYWRhcHRlcikpDQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGZhbHNlOw0KPiA+Pj4gKw0KPiA+Pj4gK8KgwqDCoCAvKiBPbmx5IHJldHVybiB0cnVlIGlm
IGV2ZXJ5IGJpdCBpbiBjYXAgaXMgc2V0IGluIGh3X2NhcHMuY2FwcyAqLw0KPiA+Pj4gK8KgwqDC
oCByZXR1cm4gKGFkYXB0ZXItPnB0cC5od19jYXBzLmNhcHMgJiBjYXApID09IGNhcDsNCj4gPj4N
Cj4gPj4gQXJlbid0IHRoZXNlIHBhcmVudGhlc2lzIHJlZHVuZGFudD8NCj4gPj4NCj4gPg0KPiA+
IEkgdGhpbmsgdGhleSBhcmUgbm90LiBUaGV5IHdyYXAgYml0IG9wZXJhdGlvbiBhbmQgYWxzbyBJ
IGNoZWNrZWQgaXQNCj4gPiB3aXRoIGNoZWNrcGF0Y2ggc2NyaXB0IGFuZCBpdCBkb2Vzbid0IGNv
bXBsYWluIGFib3V0IHJlZHVudGFudA0KPiA+IHBhcmVudGhlc2lzLg0KPiANCj4gSWYgdGhlIG9i
amVjdCBjb2RlIGRvZXNuJ3QgY2hhbmdlIHdoZW4gY29tcGlsaW5nIHdpdGhvdXQgdGhlbSwgdGhl
cmUgYXJlDQo+IG5vIGNvbXBpbGVyIGNvbXBsYWlucyBldGMsIHRoZW4gdGhleSBhcmUgOkQgY2hl
Y2twYXRjaCBkb2Vzbid0IGFsd2F5cw0KPiBjYXRjaCB0aGluZ3MsIGJ1dCBJIGRvbid0IHJlbWVt
YmVyIHdoZXRoZXIgdGhlIGNvbXBpbGVyIHdvbid0IGNvbXBsYWluDQo+IG9yIGNoYW5nZSB0aGUg
b2JqZWN0IGNvZGUgLyBsb2dpYy4gQ291bGQgeW91IHBsZWFzZSBjaGVjaz8NCj4gDQo+IFRoYW5r
cywNCj4gT2xlaw0KDQpUaGV5IG1heSBiZSB0ZWNobmljYWxseSByZWR1bmRhbnQgaW4gdGhhdCB0
aGUgcGFyZW50aGVzaXMgZG9uJ3QgbWF0dGVyLi4gYnV0IHNvbWV0aW1lcyB0aGV5IGNhbiBoZWxw
IGNvZGUgbGVnaWJpbGl0eSBieSBtYWtpbmcgaXQgbW9yZSBvYnZpb3VzIHRvIGEgaHVtYW4gcmV2
aWV3ZXIgd2hvIGlzbid0IGltbWVkaWF0ZWx5IGdvaW5nIHRvIHRoaW5rIGxpa2UgYSBjb21waWxl
ciBhbmQgcmVhbGl6ZSB0aGF0ICYgaXMgbm90ICYmIGZvciBleGFtcGxlLi4uDQo=

