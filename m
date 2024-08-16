Return-Path: <netdev+bounces-119342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B689553CB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C0928417D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15A145FEE;
	Fri, 16 Aug 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLRZdzUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45DBB661
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851452; cv=fail; b=KsaizCNdcX4TPgHHYnRB0punoqu5cJWRIY/WbrSyfloFI9aiGxQJTS3sxy6lwupB91c9mfguxRYAoP8t8EENeXKAx0gwAWHBzxFKU/3IoeQpZwEv7PTNc5D6CX9UfQTWVIcB8XEDYYjAExl320/x26cYv9+wgGDHnHpUxf8PuaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851452; c=relaxed/simple;
	bh=ots9n5R8osLy3Ar3rEYtcVIHoXFPYity+ym3rWvD2WU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cj9v39fuwAq6WAtEafWQQ/aLnS0aALHP9F26FYtun7LF752ot9yn736J5pfgTi8beh5vuTcFYOjKprdVV8VaLy9UqDwxLMlAzeXNNhQyRnAld2gXYuPmlVx13kvv8ghS+dUpJPFKcXhhgmm9TDtlpBPM28G/2m16sjoLP0BplOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLRZdzUZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723851451; x=1755387451;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ots9n5R8osLy3Ar3rEYtcVIHoXFPYity+ym3rWvD2WU=;
  b=cLRZdzUZ2etBfvw7d5ISk116jZEcUard7sq669wLEJrjy48EyAbrUsc+
   rjuuDevzMhKd/aklKFeln9IXinPqWpVCLFobR0RA9A9uKJA11C7EdytN+
   DPuzMxyOMhBj0onPjqw0wIpUSo2sUtOk5AHKuTiA4BKQKp5mhEvvDCONN
   oGfQTPJmVx4O1OOTcx7+DpBX+LZ+XcTKlxns9UQrBxCXwzCwZsARise8j
   29jgbrLNdEi4OFPKDT8epIMT8sY4UuDQLS94drjaBrzeL+DuPID35A+J8
   afcE1Hs8lXnt6Z+cV61IsykzbTF8sUGZQSGVwrkLNyngegLfwv49pScLu
   A==;
X-CSE-ConnectionGUID: VNOAXc+4TBmcD2Ua/qf1wA==
X-CSE-MsgGUID: tUCSL3ixQc++7D6aJFLYNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22038292"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22038292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:37:29 -0700
X-CSE-ConnectionGUID: 71iNSF97QCO77ciB5wE+dQ==
X-CSE-MsgGUID: 3jqv5w57RfCd07gBJIxlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="64207002"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 16:37:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:37:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 16:37:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 16:37:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 16:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Ic7NbDd3I+sIr35hoI9yFCoq738AQMzrNFK4fGQWUGh3Fv8eDUzZe9smTBox/9XQcy3lbW6/uV11coDlatJq/aClyy3YmD0jznEVnQu0dYZk133Plk3hKFHnixupoonaHRX7u13mYhPQ1JDEBoOifTqSPKLpKAAL5b7Ih+pBs/2w32EWDBGrf5EOwIKvoiP8YMAd/FyMHjTVktXmpYzBz5FJu77+6k2+pUQ3ZxKgldUtaDDrCqOgM30KIMNACYCr9AcTlRlKdUAWy857tWgbxgN/1gP2/jiqGC6uZeEOuR5Ztwjm1Pmxc5ywJXgwwa8fmrsTp3AYHVmAv/vD1zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pza1MLgwDSVukdp3vg7UaIN2a2ctazjudDRN8q07L5o=;
 b=SZZEDtAQ8XuQvQgsZdbBhDyFTkb23lVpZ7TFhj7qbbQyQQtJFcaJIFXO1fj07cLLAvRU9hmP2ptpQOA5+6l9nfbDo+p284VoTHOFmj6nKpmOuFBfLXH3/oLOFRGen0yXZgt+gINjmRZHpzhg/lMdZClVFlHlfyWTDh10fMVf7FtYPJAIq+W1b/A2m6KxaptvgD1SRhsPLGZRzggJpFaaZqV00L9iZgvVnVf9dKCGVAllXHtJPuGj/MMe2G1di1NPTNcxTvzDIwzE8p2lQ28eDol5Cr92Oy3BUOOqOBYbAgS7tgNk8i/vFtFGg15gEu+NPzoum3/V9QnZrOcDqBHGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Fri, 16 Aug
 2024 23:37:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 23:37:25 +0000
Message-ID: <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
Date: Fri, 16 Aug 2024 16:37:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
Content-Language: en-US
In-Reply-To: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8474062c-2b2a-4933-86c1-08dcbe4c61e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hwYnRDVFUvR2JJdUd4aHVtSWdEMTNmQUtEc3pJdkR0Qmo3bTZJOVZHRWhJ?=
 =?utf-8?B?Ly8wL252QU5qSTJ3WldHcXFhUDVEVklLa0Z3Q1NhTTNPOGE4SVYyMGZaN1Zo?=
 =?utf-8?B?eGVNNVRRTGhwelRVWWhXYlpYZk1DUHMvWHZqaHhNZzdjUTF4WlBxbk8vbXY4?=
 =?utf-8?B?Qm01K2w3WG9jVkRLdDdTeGNOV0RMZ0VhS3krWWd4c3BhRk5zekp3ZHRKY3Ux?=
 =?utf-8?B?NjM2eTZLeFN0Rk1wVTJaVXZWUzlDVTgreC9qMmdGNmVWTStyMWZlVG4zSG5i?=
 =?utf-8?B?V2txKzZqemlHUGJTTFJUa0hsVXhRNjd2MnlkRFA1aEpuNjhMa3RJN2RMd0pX?=
 =?utf-8?B?TzBoODNrVDJpSVgxOU9kbUorN3VnTVVxREJDKzFvakthNjFpeGhkMFR5UTYv?=
 =?utf-8?B?Z25NekFFSXQ2cXdCeWhPSklrRUpsS3lZYytaU2FzejNjS2RJVjNidElyaFVB?=
 =?utf-8?B?ekZSQTR1bXRrNVlaTnhsVndUbVhnN0VGV3FlOGh4VWh3dFZINkdFSThrQ3Zq?=
 =?utf-8?B?Zms2eTRzTVdoS1l6K2YzK2xHV3FVYnNtM0g3VmVYejVoWGY0V3c1L0tnY1hx?=
 =?utf-8?B?WFlrNUI0bHJlcEpYZEFySE80ckZTTDZpbWxjVUJrSHVwdTRSdEczNmZnV2Ji?=
 =?utf-8?B?TGFkb3AxZEU5K015T2M5TUlWMWZSV29tK2xTcTcyV0U0QW5QbUx3UzZIVU12?=
 =?utf-8?B?dW9WT2pTa3Jwc2l5ekhXQWcvMFFrY291bERXMjNvcnQybFEzUjh6TEVxZWVr?=
 =?utf-8?B?NG9zVUtOUXNDbGowMzVyZkhnWkF3ckllL1NKcHc0M1JyVjU4MU0wUHpVejZw?=
 =?utf-8?B?dWdmdWQzbkhDUFYzVzRkRVU1WnM4Wlh3amZBSFd6N1lMV1ZTa0pBUytqaWhF?=
 =?utf-8?B?K0tFQUIzdXQ4RW1yMWU2R3NxN1JJMGwzOGY4aCt0YzNkbUZtN0NkZ3VZK3Ra?=
 =?utf-8?B?MHBOeVMyYXg5Yk9ia3k1UVhqaWt5VVFoQXlVeWt3YVV1VGtDeURzMVFtWnpo?=
 =?utf-8?B?Qml2TzRQSzVSdTIrV3oweFBCSVpyb1oyQWNxamZTZVJmeVg5MUNpbEdWbXRZ?=
 =?utf-8?B?ZmdIaW10NHRsUlIrNnhwd1krN3Fhd0pzK0ZHTXhBTk01N1VZOXhqSGl3TlU1?=
 =?utf-8?B?ZGhPZk1CT2poZkg1V2xxRDRiT1pZeUtObmtEV3gwVkE1MXRlU0ZMT1RpcllS?=
 =?utf-8?B?VnIvV3BVWUl4SWV5WnNRU1JOV1d2MHZLZ0FKTkdGQVpEbjhKcTI3OXhkR2ZQ?=
 =?utf-8?B?REM4aUNEY0VrOWFZTFRLNWFlMEdaTzgzc1JMRThCSGprZ0RHZ1NrOTZPU3dt?=
 =?utf-8?B?WWJCYnhnT3RPbHNDbWROYnliZ0VHRWtPQk90NjF3bWtFMlpNeGsvVHR0YnRM?=
 =?utf-8?B?ZWQyNXp4Z3dmeGcvUFNlM21wV05jenc5MEhhUE9aWTMvdVBLRncrVG1ZTTNm?=
 =?utf-8?B?STFVMDhKT0EyUUxKNlJuWEZTdlRIV3NiUktDUHI2b2VvbGQzdFdiY2t2OE9v?=
 =?utf-8?B?NHdrZVJyUVV1cHNlMVAxbXltMVpVbllFcFRZT2FaeEJRUEJKdFFybVJQQ2FV?=
 =?utf-8?B?Snl5YlZkSCtGS2Z0ZndSRVlpR2xDcG8vVlJ3dlpMNDUyeXU2TGtHU0NWVnN5?=
 =?utf-8?B?VjhWK0Z5Ym11MzJGN3ZYd1VGLytoMldoZzArYjNzYmpVZVlveFFIQzVZTkky?=
 =?utf-8?B?T1A5QzlzRHBYU0NqMHdZeEphRU42cnlnbjJsL3JyLzdzejVhSS9Od05JcHBJ?=
 =?utf-8?B?TjF0bVFER3YyNnhaSExUN0hmNjhFWWtDWkRJMDlyQ3pFNkJzT0NiazVYbkxj?=
 =?utf-8?B?TUFVNElVZnFFa3pkNUpodz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdWNkplM1ZLWXJyZWM4a2M5Wnh4bW95RCtSZ1h2ckI4U1BNcUNGc3dTeU5n?=
 =?utf-8?B?SVIyZjdOUG1BNVprdHE3NGxNb09UcTQ1M2JwMGZhaGNOSnY3UFhQK3pMa0xW?=
 =?utf-8?B?eVgrMHBVQ0djOWc0MlIrMHJkbW1WTEFkb1RPNjhnU0tOODZQdmNuSHU1ck15?=
 =?utf-8?B?ZVVITUl4b0FkR053K3pacVdPcmdNYWpHQ0VBSTI5OW92WFg5UUZoZGlPYzVG?=
 =?utf-8?B?OEd2MnBIV2RzdGJTNHlCL1FvdjJOeHhkSU5CRkIwUVZ5bE5oRS94aEViVjZu?=
 =?utf-8?B?Wk1RMDlTemM5clFlOEt0anQyVkdjL2EySFBBaExPZkEzcXVSMW1rNzRpc2RJ?=
 =?utf-8?B?U21BK3ZQOWlya0xCTDJjUVdDMEozWE9QQWFyNnNZcW81ZmRTZlN3QTZVdUtI?=
 =?utf-8?B?bEhqTktSZnNUUGlSeXRzUDRhUjgvVHBmMTJaK2g2SForNGM1cEtNYzFLMTBO?=
 =?utf-8?B?UHA3TDFwbFVwZXJueUVodFVJcTRaTmJlQkdMYVNNRnQ3K0QvZUx5VnRwaVJC?=
 =?utf-8?B?UDRWUXA0bzh0cGoyc1VFeEhrZGtxRFFYR0JFZVJqVS83Uit3WGhHMkovT0tZ?=
 =?utf-8?B?amk4emR3dTEzZEdHUlAxNDA2TGI4ODdJZ0pFcnRjVlhQbk5PdXFZa3djd1Az?=
 =?utf-8?B?NmcxOG85QWFEU3VNNjJ2c0l1bmJySVFqZ3FlSmVGTU92a1cvd1dDQ0tmbitC?=
 =?utf-8?B?cTNLSkhnd1NFNm9CaHl5RXRablBUeUs2T2JNNWJUeTNlSFVlVnl2ZWsxdkdE?=
 =?utf-8?B?aXV1bmRZWWliZVluQzhUZlFPZXg3cFc5M2Yram1NaldVY3NENHJCdlRmRzda?=
 =?utf-8?B?dGRGWlJpN1A1SEpLQWphR2RyMEpObzZ5dGM1TXVKb1ZPeDMxUEh5WDluZzNj?=
 =?utf-8?B?NmtxZ04vTm9HVUNyMzE3QW5sMVN0NGUyR1VGZVlDYmFIZTVKZ1Q1WW5RV0J1?=
 =?utf-8?B?Yk1MMkcxaU1wTGdUeGdVWVNyNDRIQjNmTGgrNUoxbmhzcENMRVFQaTg1VWRN?=
 =?utf-8?B?WVlNUzRQckZSYTVpdFI2bFZ2bkUxakRWK2pmNnFPNTkraHd4WGx3OXVRbXJn?=
 =?utf-8?B?NjA5V0ppNTJKeXgzOTRxOXhIa2xIRlVKZjNLMWNsMk9uZTlpazJoaTRLOHAx?=
 =?utf-8?B?R3d1YXdVcitDUDYwa1JDZUZXNnJnQldjd0NpODlQMkp3b25zN1dQdkx3WWJM?=
 =?utf-8?B?ZDI3QndCL1c3bjVHL1VMQjI5MzhacEJ3V1g4S2p4SW1CcE15QWdZdzRTWnk3?=
 =?utf-8?B?U0ZTSjlJaWVMbjhjei9hcE9MTGY0c3ZqMlpIUk96UUphUGdBMFFqN1UzdjdP?=
 =?utf-8?B?cTE5djc2UTJDK05oYzdQMEovTVZ6VFp3ZHNPQ0VsZ1IxZWsrRFlkVFkyZVdj?=
 =?utf-8?B?U3YrSEt2bjNxU3lJOE51L2NtWmVlQ3dUVE16WGtvazQzSFE0bGVpU1Fmdjdh?=
 =?utf-8?B?bmg0WityL3lGc3dOcTNuSDJUSjJramVlb0wxT0txQ213OUtkTTZMR0lBUFF2?=
 =?utf-8?B?RWNaMnhqcmdEcW8zSklBUmkwWE9IYllQOHg4QWRsRzU4N3RaZFE5Q3pvaG1i?=
 =?utf-8?B?TlJzMEZTUHcvY3dvS3JteTlKMnRBTEw4SGdSQUdRYTVpeCtjSEhvb3RXRnA3?=
 =?utf-8?B?eWZRdTYvSjhOTFJUbmIrWXVJd3ZNS1NYeUd4VzhhTVFLMW4wUFhNYTZucmNE?=
 =?utf-8?B?MFpRWGhIeXRYcFhJRURmNTJmeDNPM2ZIWE5jNER5UXBTV1N5eGRuZGpkMkt6?=
 =?utf-8?B?ZkFzSmhQZWxWSk5XMVprTVVXWWZGNVgrc3dtaWJPRHlkRFNibnpFejNLTWdx?=
 =?utf-8?B?QmJZUlQ3ejVmcGMzSk8xcjY0djhKbkpzOFJPUnRicWpYQWxlcCtsSjZENFpU?=
 =?utf-8?B?S2taS0w0TlZCUERaUWZQMkYxT1hURGRia1VHdS9BZjVEVno3d0ZyWEw1OCtS?=
 =?utf-8?B?dzlUcHFQeTRjNi83UVhkTEhnMlZFUWs1VlFKV1pyRlVBL2xlcnBOUUhMbE44?=
 =?utf-8?B?Yjk2Vk54elI2L0dIMGxEOU9tZ09TK3MrNDQvQmNLRktTbkJOVjl3SWhzYW1F?=
 =?utf-8?B?bTV3R3FFUHFQeHRXeW90bmRRVWU1bDhWbGtnWGdHUDgzd3ZTdTRDdlBKMTk4?=
 =?utf-8?Q?vMpWrMGVO/On994qqkvDY5jaP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8474062c-2b2a-4933-86c1-08dcbe4c61e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:37:25.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44Sl9OkStnIoQPR734UL4Pmb5OghH71m0AqNNZslJEv1FMH3j2hlaK+C4tvgxs866BYp+pQVbGsaKsAc0vvR0gJvABVv/UYlNKw4Cf0blTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com



On 8/15/2024 2:16 PM, Jacob Keller wrote:
> Hi Vladimir!
> 
> I am recently attempting to refactor some bespoke code for packing data
> in the ice networking driver into a bit packed hardware array, using the
> <linux/packing.h> and lib/packing.c infrastructure.
> 
> My hardware packed buffer needs QUIRK_LITTLE_ENDIAN and
> QUIRK_LSW32_IS_FIRST, as the entire buffer is packed as little endian,
> and the lower words come first in the buffer.
> 
> Everything was working ok in initial testing, until I tried packing a
> buffer that was 22 bytes long. Everything seemed to shift by 2 bytes:
> 
> Here, I print the initial details such as offset, lsb, width, then the
> hex dump of the u64 value I'm trying to insert.
> 
> I do the call to packing() with the appropriate quirks set, and then hex
> dump the 22-byte buffer after.
> 
>> kernel: offset=0, size=8, lsb=0, width=57
>> kernel: value: 60 9b fe 01 00 00 00 00
>> kernel: 0x0000000001fe9b60 -> 000-056: fe 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> kernel: 0x0000000001fe9b60 -> 000-056: 00 00 00 00 00 00
> 
> It seems to have failed to copy the first two bytes in to the buffer.
> 
> I discovered that if I pretend the buffer is 24 bytes (a multiple of 4
> bytes, i.e. a word size), then everything works as expected:
> 
>> kernel: offset=0, size=8, lsb=0, width=57
>> kernel: value: 60 fc fe 01 00 00 00 00
>> kernel: 0x0000000001fefc60 -> 000-056: 60 fc fe 01 00 00 00 00 00 00 00 00 00 00 00 00
>> kernel: 0x0000000001fefc60 -> 000-056: 00 00 00 00 00 00 00 00
> 
> It seems like this is either a misunderstanding of a fundamental
> requirement of the packing() infrastructure, a bug in the
> QUIRK_LSW32_IS_FIRST, or I need a new quirk for the packing infrastructure?
> 
> Essentially, I think the problem is that it uses the length of the
> buffer to find the word, but when the length is not a multiple of 2, the
> word offset picked is incorrect.
> 
> Using a larger length than the size of the buffer "works" as long as I
> never use a bit offset thats larger than the *actual* buffer.. but that
> seems like a poor solution.
> 
> Essentially, it seems like the default indexing for big endian is
> searching for each byte from the end of the array and then using the
> quirks to swap back to the inverse ending.
> 
> I think the fix is probably just to do a round-up division on the len/4
> check in get_reverse_lsw32_offset, since its calculating the total
> number of words in the length, and effectively rounds down for lengths
> that aren't multiples of 4.
> 

This doesn't fix the problem. I printed out the logical box number and
its mapped box address in the various modes with a length of 22 bytes:

> kernel: default: 00 => 21
> kernel: default: 01 => 20
> kernel: default: 02 => 19
> kernel: default: 03 => 18
> kernel: default: 04 => 17
> kernel: default: 05 => 16
> kernel: default: 06 => 15
> kernel: default: 07 => 14
> kernel: default: 08 => 13
> kernel: default: 09 => 12
> kernel: default: 10 => 11
> kernel: default: 11 => 10
> kernel: default: 12 => 09
> kernel: default: 13 => 08
> kernel: default: 14 => 07
> kernel: default: 15 => 06
> kernel: default: 16 => 05
> kernel: default: 17 => 04
> kernel: default: 18 => 03
> kernel: default: 19 => 02
> kernel: default: 20 => 01
> kernel: default: 21 => 00

Here, you can see that it correctly maps in "big endian" order the
entire array. Basically it just reverses the ordering. Ok, this seems
reasonable.

With LITTLE_ENDIAN set, things get weird:
> kernel: LITTLE_ENDIAN: 00 => 22
> kernel: LITTLE_ENDIAN: 01 => 23
> kernel: LITTLE_ENDIAN: 02 => 16
> kernel: LITTLE_ENDIAN: 03 => 17
> kernel: LITTLE_ENDIAN: 04 => 18
> kernel: LITTLE_ENDIAN: 05 => 19
> kernel: LITTLE_ENDIAN: 06 => 12
> kernel: LITTLE_ENDIAN: 07 => 13
> kernel: LITTLE_ENDIAN: 08 => 14
> kernel: LITTLE_ENDIAN: 09 => 15
> kernel: LITTLE_ENDIAN: 10 => 08
> kernel: LITTLE_ENDIAN: 11 => 09
> kernel: LITTLE_ENDIAN: 12 => 10
> kernel: LITTLE_ENDIAN: 13 => 11
> kernel: LITTLE_ENDIAN: 14 => 04
> kernel: LITTLE_ENDIAN: 15 => 05
> kernel: LITTLE_ENDIAN: 16 => 06
> kernel: LITTLE_ENDIAN: 17 => 07
> kernel: LITTLE_ENDIAN: 18 => 00
> kernel: LITTLE_ENDIAN: 19 => 01
> kernel: LITTLE_ENDIAN: 20 => 02
> kernel: LITTLE_ENDIAN: 21 => 03

We map *outside* the buffer! 0 goes to 22, 1 goes to 23! Nothing at all
maps into 20 or 21. This is extremely not-intuitive. In practice,
without having read the docs I would have expected LITTLE_ENDIAN to
directly map 0 to 0. After having read docs, (where it mentions that
LITTLE_ENDIAN only does by word), I honestly have no idea what I would
expect. If we try to just do 4 byte blocks at a time, we end up having
to swap bytes from outside the length.

With LSW32_IS_FIRST set, things are even weirder:

> kernel: LSW32_IS_FIRST: 00 => -3
> kernel: LSW32_IS_FIRST: 01 => -4
> kernel: LSW32_IS_FIRST: 02 => 03
> kernel: LSW32_IS_FIRST: 03 => 02
> kernel: LSW32_IS_FIRST: 04 => 01
> kernel: LSW32_IS_FIRST: 05 => 00
> kernel: LSW32_IS_FIRST: 06 => 07
> kernel: LSW32_IS_FIRST: 07 => 06
> kernel: LSW32_IS_FIRST: 08 => 05
> kernel: LSW32_IS_FIRST: 09 => 04
> kernel: LSW32_IS_FIRST: 10 => 11
> kernel: LSW32_IS_FIRST: 11 => 10
> kernel: LSW32_IS_FIRST: 12 => 09
> kernel: LSW32_IS_FIRST: 13 => 08
> kernel: LSW32_IS_FIRST: 14 => 15
> kernel: LSW32_IS_FIRST: 15 => 14
> kernel: LSW32_IS_FIRST: 16 => 13
> kernel: LSW32_IS_FIRST: 17 => 12
> kernel: LSW32_IS_FIRST: 18 => 19
> kernel: LSW32_IS_FIRST: 19 => 18
> kernel: LSW32_IS_FIRST: 20 => 17
> kernel: LSW32_IS_FIRST: 21 => 16

We access bytes with negative indexes...

And with both set:

> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 00 => -2
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 01 => -1
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 02 => 00
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 03 => 01
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 04 => 02
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 05 => 03
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 06 => 04
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 07 => 05
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 08 => 06
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 09 => 07
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 10 => 08
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 11 => 09
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 12 => 10
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 13 => 11
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 14 => 12
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 15 => 13
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 16 => 14
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 17 => 15
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 18 => 16
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 19 => 17
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 20 => 18
> kernel: LITTLE_ENDIAN | LSW32_IS_FIRST: 21 => 19

We still get negative indexes, but things are close. Everything is off
by 2 bytes from what I would expect.

I'm honestly not sure what the right solution here is, because the way
LITTLE_ENDIAN and LSW32_IS_FIRST work they effectively *require*
word-aligned sizes. If we use a word-aligned size, then they both make
sense, but my hardware buffer isn't word aligned. I can cheat, and just
make sure I never use bits that access the invalid parts of the buffer..
but that seems like the wrong solution... A larger size would break
normal Big endian ordering without quirks...

Really, what my hardware buffer wants is to map the lowest byte of the
data to the lowest byte of the buffer. This is what i would consider
traditionally little endian ordering.

This also happens to be is equivalent to LSW32_IS_FIRST and
LITTLE_ENDIAN when sizes are multiples of 4.

