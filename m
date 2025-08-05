Return-Path: <netdev+bounces-211819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC811B1BCB9
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E918F182E51
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD025B687;
	Tue,  5 Aug 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFNPd9H4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544E1DF759
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433629; cv=fail; b=SBtWBCZ7bE/TNYba2CTvLu2da6qu+3dzSYDi/6XoBJXpqX5HkLGJW9LQN+7ptwUBlJlTyPpSKGSZZSXtbYHyljTAnmiLmIg5xsdI1R2XSAodBjbYWg/z/82rq8thLKDoKZExCiuVfPVuhLoVpBSFDyiDaxJ+Z6/pXqaGgjSatYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433629; c=relaxed/simple;
	bh=gvwh9fkpZGrkBVlj16jG5xLVqXdArKKXLxPpWEDMWOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzG+ORWqGdSmVYiE4BJbk7lq1hqfMv7yjYlfyLg+tp0YeGckkstRrQ9JVgHwlZIRnSjoksDvOCzngHrtZZmK2gAZx7YSR8jpJ4Pl1UaiQY33y30DWIfZC3eHR0+V+GkxNcTZeEbLT7jq9i3yxFP4rrTjHA5gttX4/XcBS1dNc+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFNPd9H4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433627; x=1785969627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gvwh9fkpZGrkBVlj16jG5xLVqXdArKKXLxPpWEDMWOU=;
  b=OFNPd9H41fhhddPcvAz5+i1vwfogxSLIeDPw/gW58NEHSeb00GjY8OG9
   FDuauzgl+PYg/MIAeFFN6dQWVuwZc/LPnUh7l6W8D8lASzeBZzb9aBVXf
   /2tzehOwX8Fcf8pa6qZjRGwZ02IXAVi/pfcdM1rnvLIqoxuK5dwVXiAQX
   j9lNsrADlkgnYt0ulIKRlYV5Z4kbAUAFJIiGr5726tu4NfKSGEi3fh0tK
   9WaU8Wivb7BdCUvYXVAeEZFHYEerrSMaVVETH4uUf/votSwMrP51OXei1
   NjD6Vy+FScmQhAQHc0UEG6XcIGdVBt5laCAQhOxhedgrTEmaEmSsDRofq
   A==;
X-CSE-ConnectionGUID: 7FM2wmN0RGasEQpGx5V05g==
X-CSE-MsgGUID: 5T/a5agFQ2WhzTlM6mEwJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60555610"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60555610"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:40:27 -0700
X-CSE-ConnectionGUID: 8lK2eYGqRtGeFxIUFBqBEw==
X-CSE-MsgGUID: hLFJd+VsSWGNTwl8rKFdXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195579348"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:40:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:40:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 15:40:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUEtV8iQ+SVJ5ICh1CXoPLodgvcMKM5CdIvllOnPQJ+fU0l7x0W1bfEVVUj4aL+itXV60nyvMQyorFWvMVscRV+xhI9o8tFBC2+cJQFYhyhe64qpGhVxBmLLHLSXiLPyA1BGhCG3c3K6RkLd7CP+7+VBBfJW/RKe+OZ3esxiBH5DZEysRQh54l2T9l53BMiYcDRP4btMNNcWXBsy6nK4DwZj+5ifmqqil0rr2rFg+exMdyOUKCfyM7F0d1zAIbLXJSSUt6Ui1GfgCbv01mqWnpEHpStZU+g1ISuexCopdjvQhJUM5u99sGKxXk9/aDi5dwrQkEwXy+0WA+cBBRyDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvwh9fkpZGrkBVlj16jG5xLVqXdArKKXLxPpWEDMWOU=;
 b=xbtxlahy1VJSGxF0dc6HyTt1zElIz99wMvA16gaiKl1I/HVDIJMvgDeUOxycaIqxCfENR7KVkDGgQMVFJ4Fi7N6EvB8X0peC8jhakDbY0mLMKmmtI+EN7K087jQ2XLmcJtL342QyZ4aRsi18CVuXLvafea7X/MKIltLBYQ+BoCNnI32ktOXs1uKLfxE9hE79rI6hutGBytrmixpcQDU5qCtN1l+wzshYSfhNxqCktwZAnx85/YLOYTcpgDidNQ9u4Osi2hWEVhReXH/pLwxZ7CqZ6xAx7gK2PEdAp3s79d0jtyMWApeRawgx3zfu9+YkUEueLx351NlZLeMwfM5Ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 22:40:24 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 22:40:23 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Luigi Rizzo
	<lrizzo@google.com>, Brian Vazquez <brianvv@google.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3 4/6] idpf: replace flow
 scheduling buffer ring with buffer pool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3 4/6] idpf: replace flow
 scheduling buffer ring with buffer pool
Thread-Index: AQHb/ZLV+djvphYljkWtC1zkFZD+TrRSyBqAgAHpdcA=
Date: Tue, 5 Aug 2025 22:40:19 +0000
Deferred-Delivery: Tue, 5 Aug 2025 22:39:44 +0000
Message-ID: <DM4PR11MB65026B231AAA91BD5E8DF6ACD422A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250725184223.4084821-1-joshua.a.hay@intel.com>
 <20250725184223.4084821-5-joshua.a.hay@intel.com>
 <d8a1978b-ca4c-4912-acf8-bcb6c921a7eb@intel.com>
In-Reply-To: <d8a1978b-ca4c-4912-acf8-bcb6c921a7eb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|SA2PR11MB5084:EE_
x-ms-office365-filtering-correlation-id: ff604119-8bc2-445f-16a6-08ddd47110f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzdtYUNFaFV5SjRHMUJsVTFxVjBmTEVzZnVCRE5ub1p0UE96KzRhdDdDKzFC?=
 =?utf-8?B?VGNEZ211OFFQNlZmd1JsanRSVzlYckhVa3hERlpvcUJaZTIzWkcrM2VLcHNh?=
 =?utf-8?B?Tm1wUzlKV0ZHbnhpWnZXMTRFM2I5U0U5NGVyaXV5dHl1TlM0THAzY2t1S21V?=
 =?utf-8?B?bURRZ2lTRzBRZmExL0VHOVNjcXl2cXlBa29ISnpwWnJDK3c3MTZ5M0w3Ly9F?=
 =?utf-8?B?Mk1Eb0xMcVFQbWdTbXluZmNUcUxwQVIvZGF4NGJmTDJZdlYrQjJkdklzamJj?=
 =?utf-8?B?ejNydHJ4R01PLzk1VEVyWnRRQWtyRFYxOCsxeWM0WGFaQVM5RE10SGV6c0xL?=
 =?utf-8?B?d2ZXMkN4K0l1NVlrdGRBSlcybzVSbG8wTUJDN3BrN1U5TXFsdHQyYXg3Ylpw?=
 =?utf-8?B?ZWd3c3pncTJ4dFZ0TDBxcW1oTEdZYVdGTy9MMlUzYllwUE14cG9meFJxUWNp?=
 =?utf-8?B?Z0VjUTVRbjhRSjFtY0lWMDU1aXNPcFpPODhhY1J6clhiQ0ZENFNEQnk0Z01O?=
 =?utf-8?B?RkJUOTBLQnByVWgyTW4rMStQRVV5elRxNEoyL2pKK2hEQmxNMnpvRE85dk1x?=
 =?utf-8?B?VmluL1Jtby9KQkliTUl5dzUxYkJ2U2dTVGdDSWJzVnZRSm1hYzVsRW05ODJK?=
 =?utf-8?B?U29panREY0dCR2xsNGNDa1pEWHRZV3pXOG9XazRPQjhHOWZaRnhyUEN2MUtP?=
 =?utf-8?B?Ykd6REFvLzdCN3NrY3FUWTJpcDJyWDNzdGkrMDBYMHg3a0Y3bUxVYVorQzkv?=
 =?utf-8?B?MzB2R0cxb0pXc3pSd2pHQjFIdmh3bXVnYWdyUEJpWGMxeWtTczg1bHR0WTJx?=
 =?utf-8?B?TnFZdCtkSEZtbzc3WUh4VGhqNU8wQ0UwemdvelpOSmlHeEpwVGwrcjJuRXRv?=
 =?utf-8?B?YkNRd2ZaVjRVSHFvQTBVNHBiS1FmTEZxblR1RFJpZDZRSUo1V0s2MERkRjJu?=
 =?utf-8?B?VnpTb01zSFlXZGVsTVFqV0xHRVg1V0VZRS9xRHlyTFBlNHdOdnA3ZHpHR0R0?=
 =?utf-8?B?cWl3RGQzQmk1STM2UFdZQllpQmY1Z0hRQ2YvNVZJTldsZW50RmNhbEJFYWJW?=
 =?utf-8?B?QTgwTm83d1JKN0QzRFlZVVd2OEg0UWlXV2djM0EwT3lHaWlQM0t5aHhUMjFi?=
 =?utf-8?B?OFgvQlFLKzM1eGM5NjQ2dFBwWmtGcVNyalNQeEx3ZzliSG5EcTBQYWhjRWxY?=
 =?utf-8?B?UVBPTHpCQk5KZWVWbXk1NE95SFVlMjIvU1pFQ0NkUUk5ZXdiWHlwSU13MENu?=
 =?utf-8?B?Zkt5eHI1YlYvWERuM0J6MkRxb2Z2U3E2emc0YTkvWVB6MVNjQjVRanNSNHJj?=
 =?utf-8?B?R0lXcGtTNDRKeC9Pc1BqL1NKMCs2aVNpMXlncVNoUnlmQ2IyeldZMWhIZnRG?=
 =?utf-8?B?aldBaVVUd3ZXc3RscG1xMGdBQjhqS3lnQkxZWUd2bERKUEtXNVhVUkFBdVFZ?=
 =?utf-8?B?OXpOMzBKUTVKam5tMHpVN29GcWttc3kydDVSbEs4c3JkNy9PcHI3b2dWazYw?=
 =?utf-8?B?TFpZdlErbTRFUnlKMmlkRUdta3hzV1VjRnBQSWtjZ1dzR3JGa0pBWlpDZWs0?=
 =?utf-8?B?dlVhY0tUa3RVbEdYamlCNmhlWE5iQlErOFdyTHFuOWdvY2poa2NSc1UzR1B2?=
 =?utf-8?B?UkhLclliRHhnZlp2VDlOUXE2YWJlNnRweDROaHFaVlBObTl3eE9WYVp6RmJC?=
 =?utf-8?B?YzU2NTZJRzZxSnpSaUNjZTNXc2Q2ekhHUS9GY2VDd3Y3Vzd2ZFNpeGRFalZN?=
 =?utf-8?B?OE1zM0hGTXNHMUFzeTFkWkhNZ2E1UVlsOHlxZ216b3VPekJtd1BiRTEyQXU0?=
 =?utf-8?B?RVBRYUdkOXJiL3FGVExlS1U0bVBYKzBzaHg4MURMWVE5QTBkVEJmeEN5aEdX?=
 =?utf-8?B?S01aWExXQm8wdEltSHZ2TC93QW8rdUJodDRZOHd5L2xMMWZ1VFlXbGNIV1VK?=
 =?utf-8?B?TDdnNmZBY25CMUJRb3hiNEpFM1RsMXRZL09SVFFOZmZoTXduRXpTcnUyWSty?=
 =?utf-8?Q?6t9F//fc7OISX+XkU/Us5XRP/vfJSM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1hlUVdyZjY2aXZ4TnptL1NXVTlsSTM1RGNFd1ArNy9yU3J5emV5SGN2ZDlm?=
 =?utf-8?B?bE5vL0l5Y254KzVPbXVOMnpRdlIzWDlaSFNIZjNRMTNGM29oMU5JS3pNMEd5?=
 =?utf-8?B?eW1obzF5cGFacnBpV1hVK3c5ekJ3WVRPbGkzTytVUGpzd2orWXZSOFB6eHNv?=
 =?utf-8?B?YkR6UVVQSmpHMVlHZDFwTXVnTEFLRWxyclg5STgrdzFGVW9BYnJleXI3NHFu?=
 =?utf-8?B?aUhEZFF1MVplcW1sakcrUjlNNXlTMVoxb2x6eURRcUhMaEYxbmZqL04vcWJR?=
 =?utf-8?B?M1VZMjlEK0J5Z0k5N2RvS2hHMG1LQXFnNWY2bWNqVWRSc2VROTR3dGYwQTV6?=
 =?utf-8?B?a3R5TWp2MFd3NkxsKytodFFRK3hMNGQ0TktoYktlbmlXSWJuVmpHVGgweE5Q?=
 =?utf-8?B?d2R0WHV1ZXR1ZThWZWd3Y3JTbFNYbDVDMHh0ZTFZWEl6S0V3bjBLZ0R5azhq?=
 =?utf-8?B?OC92dVFYYVlHTi9oSnJwVG1xU212bmVvOUplNUtNUkNJZWhOTENFUlV5b0pC?=
 =?utf-8?B?QU5ibTJrakRITzFWWFBWTVFtQ3lVb2RZd05lbG41ZTVhSHdqam5TdzJWMEgw?=
 =?utf-8?B?cFBXZnlzNytpY0pZc2tPajlKTlIvU1hhQ0lPM0Vra2tYbHZuTmhHTGNJRHFZ?=
 =?utf-8?B?ZS80SW4rWGUvRUxnMGJITGdVT1RaYjlIRy9nZVBxT0VjWEFrK0M1OU1KNWJ1?=
 =?utf-8?B?dkdSQnhGQXVOMllhSTVhUi9xWkdkNjA1M1cwaHBMRjNPRVYrQnphVHg3aGhP?=
 =?utf-8?B?d3ZpN05JTzJVRFdSZUJmQUZ2NlQvNGlTR0FETTBhZ3VBanR0SWhZTjJDQVlM?=
 =?utf-8?B?MFV4dVFVRjk5enBBMHB3VGhlN0xONTM0Y3JGd2NMZ3JXWElGaTVMdU9KWmNQ?=
 =?utf-8?B?dTNzZjdOeFhvbzBkVGR4T0hqdnZBY1d3YnEyTUltM1ZNSGd3Nk9qTW5Cd0l0?=
 =?utf-8?B?cGVPc2w2QlNFQlpwRTZjaEEwRGRQeDBBN3Zlak51TVJCc1FxNWZKTDBWTlJI?=
 =?utf-8?B?Qk9SelY4YUpBNnRwbCtUSDRGcjdhblhXeVd2NURQbVpGeUdLaXAxczRXdzlk?=
 =?utf-8?B?RFMwZXc5Wlc0UThpbHp2RDlVb2U5NzI5OWRPanhmNEFkekp0c2tEQndEUFNS?=
 =?utf-8?B?cHhHa2tDN0xOTmNZdFkzcVRwS1gvdnhOWkJyMlF5TEdyKzFUUnVTSmUzdHg0?=
 =?utf-8?B?N1pJcXlXTTFRLzE2bi95cVB2MjNGUDYwM3pUQkk2Skp3d3NPeitjR1hiWk9W?=
 =?utf-8?B?RmNUOTRRRWNhZHJiM0wzS3MxY2R0ZWFidDlhZDdHZ09SQVQvSUcvTU1NOTl6?=
 =?utf-8?B?STI4NHFYNlJCNGp0RU1BdlE3RXlaWDJ2WjVQdDhmbTdkdkJ3aXkwT2dlRENO?=
 =?utf-8?B?Q1lNWTdKc1phbEQrcTdrU0hNUk94UkM3UW8vWk1hV0kwQmdpbXgzWFlmVUhY?=
 =?utf-8?B?ekIxdXVEU2J6Y2xXT3BMd3FvZEpMY3Fialo5SEZFS3ZRS3U0ZlBzaXVWRXo5?=
 =?utf-8?B?K1FZTE5SSEtGK0FoZG1kelpGNCs5S3NsUjVOZDBGMm5KREhUQ1laSzFSNjAr?=
 =?utf-8?B?UUk3MVFXTnZUWTR3bUJGaXZqN3dFQmM2SElMOTdBZ0VOMVpKRks3YjRtZDdR?=
 =?utf-8?B?UWt5L0pBNmZDNytwWWQ2YUpPNFMxdCt6RU42MjlCYVUvZ2xMUUtHUzRLNGs3?=
 =?utf-8?B?RnNRMmRNMnVtR2czY1hwcERiUGVtUkY1cnppbThZd1drMjQzMVNBSkw4enV2?=
 =?utf-8?B?V2VCZTFsRUJGbFV3enc2M3E0cmNvWWpPdGRjbVdzL2xuTVdoZ3cydENjbEVI?=
 =?utf-8?B?clZMZlcwTVFDTWV2UUZIamJkS2NMTkpkMUV1aHA2TGhtcTdlWlpIUU9KaGhq?=
 =?utf-8?B?RnpQWXVXU0VxOWZtQUJpVWQ3QU9GUUlScTlnQ0x1WTY2UkV4alROQ0NyRVRt?=
 =?utf-8?B?ZHJSVTM4Z3Zmb01IcUd5SGJKeit1YjhNSlBFekRlQmZFSDQzeFlGWXFaK0t3?=
 =?utf-8?B?cXloUjVBT2R0dGpRc1pGR2ViaGtsUDZjSEpoWVA3R0xNVit2VGp6S3Ixb3dl?=
 =?utf-8?B?aUhaWkJGR0d0dkNPNkFtazI3c09KY1ZmdSsvSGRqcFhiZU5oajFtcVphbjJw?=
 =?utf-8?Q?u/qeh8mj4PtjIVc/Rwrcuy5VZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff604119-8bc2-445f-16a6-08ddd47110f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 22:40:23.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTTsJBUtzFqwnJfWo1LZafrMCbBRvxI833Y1hxLH33s/cpn234zxKTlFJMKxmQNQm77bO5YqxPwnjpJsTcKr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com

PiA+IC1zdGF0aWMgYm9vbCBpZHBmX3R4X2NsZWFuX2J1Zl9yaW5nKHN0cnVjdCBpZHBmX3R4X3F1
ZXVlICp0eHEsIHUxNg0KPiBjb21wbF90YWcsDQo+ID4gLQkJCQkgICBzdHJ1Y3QgbGliZXRoX3Nx
X25hcGlfc3RhdHMgKmNsZWFuZWQsDQo+ID4gLQkJCQkgICBpbnQgYnVkZ2V0KQ0KPiA+ICtzdGF0
aWMgYm9vbCBpZHBmX3R4X2NsZWFuX2J1ZnMoc3RydWN0IGlkcGZfdHhfcXVldWUgKnR4cSwgdTMy
IGJ1Zl9pZCwNCj4gPiArCQkJICAgICAgIHN0cnVjdCBsaWJldGhfc3FfbmFwaV9zdGF0cyAqY2xl
YW5lZCwNCj4gPiArCQkJICAgICAgIGludCBidWRnZXQpDQo+ID4gIHsNCj4gPiAtCXUxNiBpZHgg
PSBjb21wbF90YWcgJiB0eHEtPmNvbXBsX3RhZ19idWZpZF9tOw0KPiA+ICAJc3RydWN0IGlkcGZf
dHhfYnVmICp0eF9idWYgPSBOVUxMOw0KPiA+ICAJc3RydWN0IGxpYmV0aF9jcV9wcCBjcCA9IHsN
Cj4gPiAgCQkuZGV2CT0gdHhxLT5kZXYsDQo+ID4gIAkJLnNzCT0gY2xlYW5lZCwNCj4gPiAgCQku
bmFwaQk9IGJ1ZGdldCwNCj4gPiAgCX07DQo+ID4gLQl1MTYgbnRjLCBvcmlnX2lkeCA9IGlkeDsN
Cj4gPiAtDQo+ID4gLQl0eF9idWYgPSAmdHhxLT50eF9idWZbaWR4XTsNCj4gPiAtDQo+ID4gLQlp
ZiAodW5saWtlbHkodHhfYnVmLT50eXBlIDw9IExJQkVUSF9TUUVfQ1RYIHx8DQo+ID4gLQkJICAg
ICBpZHBmX3R4X2J1Zl9jb21wbF90YWcodHhfYnVmKSAhPSBjb21wbF90YWcpKQ0KPiA+IC0JCXJl
dHVybiBmYWxzZTsNCj4gPg0KPiA+ICsJdHhfYnVmID0gJnR4cS0+dHhfYnVmW2J1Zl9pZF07DQo+
ID4gIAlpZiAodHhfYnVmLT50eXBlID09IExJQkVUSF9TUUVfU0tCKSB7DQo+ID4gIAkJaWYgKHNr
Yl9zaGluZm8odHhfYnVmLT5za2IpLT50eF9mbGFncyAmIFNLQlRYX0lOX1BST0dSRVNTKQ0KPiA+
ICAJCQlpZHBmX3R4X3JlYWRfdHN0YW1wKHR4cSwgdHhfYnVmLT5za2IpOw0KPiA+DQo+ID4gIAkJ
bGliZXRoX3R4X2NvbXBsZXRlKHR4X2J1ZiwgJmNwKTsNCj4gPiArCQlpZHBmX3Bvc3RfYnVmX3Jl
ZmlsbCh0eHEtPnJlZmlsbHEsIGJ1Zl9pZCk7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWlkcGZfdHhf
Y2xlYW5fYnVmX3JpbmdfYnVtcF9udGModHhxLCBpZHgsIHR4X2J1Zik7DQo+ID4gKwl3aGlsZSAo
aWRwZl90eF9idWZfbmV4dCh0eF9idWYpICE9IElEUEZfVFhCVUZfTlVMTCkgew0KPiA+ICsJCXUx
NiBidWZfaWQgPSBpZHBmX3R4X2J1Zl9uZXh0KHR4X2J1Zik7DQo+IA0KPiBUaGlzIGxpbmUgYWRk
cyBhIG5ldyAtV3NoYWRvdyB3YXJuaW5nLiBUaGlzIGZ1bmN0aW9uIGhhcyBhbiBhcmd1bWVudA0K
PiBuYW1lZCAnYnVmX2lkJyBhbmQgaGVyZSB5b3UgZGVjbGFyZSBhIHZhcmlhYmxlIHdpdGggdGhl
IHNhbWUgbmFtZS4NCj4gV2hpbGUgLVdzaGFkb3cgZ2V0cyBlbmFibGVkIG9ubHkgd2l0aCBXPTIs
IGl0IHdvdWxkIGJlIG5pY2UgaWYgeW91IGRvbid0DQo+IGludHJvZHVjZSBpdCBhbnl3YXkuDQo+
IElmIEkgdW5kZXJzdGFuZCB0aGUgY29kZSBjb3JyZWN0bHksIHlvdSBjYW4ganVzdCByZW1vdmUg
dGhhdCBgdTE2YCBzaW5jZQ0KPiB5b3UgZG9uJ3QgdXNlIHRoZSBmb3JtZXIgYnVmX2lkIGF0IHRo
aXMgcG9pbnQgYW55d2F5Lg0KDQpBaCwgZ29vZCBjYXRjaCwgd2lsbCBmaXguIENvcnJlY3QsIHRo
ZSB1MTYgY2FuIGp1c3QgYmUgcmVtb3ZlZC4NCg0KPiANCj4gPg0KPiA+IC0Jd2hpbGUgKGlkcGZf
dHhfYnVmX2NvbXBsX3RhZyh0eF9idWYpID09IGNvbXBsX3RhZykgew0KPiA+ICsJCXR4X2J1ZiA9
ICZ0eHEtPnR4X2J1ZltidWZfaWRdOw0KPiA+ICAJCWxpYmV0aF90eF9jb21wbGV0ZSh0eF9idWYs
ICZjcCk7DQo+ID4gLQkJaWRwZl90eF9jbGVhbl9idWZfcmluZ19idW1wX250Yyh0eHEsIGlkeCwg
dHhfYnVmKTsNCj4gPiArCQlpZHBmX3Bvc3RfYnVmX3JlZmlsbCh0eHEtPnJlZmlsbHEsIGJ1Zl9p
ZCk7DQo+ID4gIAl9DQo+IA0KPiBUaGFua3MsDQo+IE9sZWsNCg0KVGhhbmtzLA0KSm9zaA0K

