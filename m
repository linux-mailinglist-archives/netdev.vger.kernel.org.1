Return-Path: <netdev+bounces-126814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724E972978
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06C7B20E84
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC05176AA5;
	Tue, 10 Sep 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzmb4ilx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5A175D37;
	Tue, 10 Sep 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949510; cv=fail; b=BmJnsXaAtNeiGsax/RsyIKNsX95rCc0HFF3QIjWTxBo51oDuBS3dA/9ybkFIT2PCtfPMQ0BCynGD+SmqSM4tgD3dyGX8NUM7AVnM07eXwhgheUGPGNA+facvblUSkI2VQqF9ie6NE008HshbYwVTBXeZOXqhNl8cnH44i6PhGi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949510; c=relaxed/simple;
	bh=dzU8AodxM/5Cfm58dk4aDASnme9m3P067DuiKakb9JY=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zfr2Vul/su/eiHYnylRc07ry5hxPb3ok6lPNed99dlidfdjhGbdBGRG/dos73VtU1nwJL5kybm3JfN78RpWZgAD3PKWiC4Ra+2GBAMyspOhnS2fIhT1EWQ2lO7iVobP0Znvu3nVEzEWOKPdNIR9PWp8yhl5rqFRNd1vlNuOouGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzmb4ilx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725949508; x=1757485508;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzU8AodxM/5Cfm58dk4aDASnme9m3P067DuiKakb9JY=;
  b=Mzmb4ilxki/XQxqZgp4ip9ypbasFPUwqbgszi7BtVNdtTX21tIfGc9aY
   /vy3UOJLCbR89A+oBuymSo9n6Z1R1cKcE0D8//JQIC2EZCYY3otM5KesT
   g+eLHrfFP3Z3RSpOXwPn7SEfKm+wt5BoKCaIhKAZMqiD4Fw+M7d7B1Su7
   Oq3bN6cdwgFsqpIULvPMIhuJ/Ni9P0PCmP+igtBGNgmc2s8kNCNqiUN6W
   YYLDMe+OvC1blmoNIRUZjRSC2DBFEUm1a7OGj1o+jSjmRcLL9odMzgInq
   ZTbDEF3+iED/0fDiqWoAh2nvYBSYVjl8nhVMTERya9zNOUWlfkQxgxUpX
   Q==;
X-CSE-ConnectionGUID: fmc/PEL+RCqENVZ6XqUSgw==
X-CSE-MsgGUID: yQcddxvpTTKqIvZJs1g1FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28567733"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28567733"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:25:07 -0700
X-CSE-ConnectionGUID: rMOw4PW/TaWlJ0w8xTDOEA==
X-CSE-MsgGUID: 0yZC/aDlRZySJoX5h/qSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71050343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 23:25:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:25:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:25:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 23:25:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 23:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSulpk5R3P1lm1nQaA17qQbzdtLak0M+6NPoufUPz79rQge7xSVftb/jWkhNuRgkmf3xQMAH8X8OyTMLF0nWspxkTKuR6wx2e7dzG+Ye1DexLpufxg9A8dQeNQY5nQo5DyUdg9z2Yh1RrjWI7VJQ4wV3c46UTvLH1kv041Dwvv0As39+f1RtNtU1TL/zYQA0WC1SzvYp0TQ/wx0XJQfPpkUnd7d7Rhgh3Lk/+rjjLipbsPfN4sfc/3zMELHK4W42Y4WV2cnHSo72vNEIqKdRfCxjqj5/SBtqbWxbywDd7MYzmS6mCU4RMosqCwgSdYvUEd5x/mVbeibwwtif6fGZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vzMs60JmNCO7XXeR0wmVMt+khCuN4D/jGQ0CD47M5Q=;
 b=hG3zAOTOCarMwcyKo3TNRUKk5jEAQrHHcBwvqU8pT+x61ScqHBF/+YGzOazhEf85qMGhY0E0WA2RER6bRpJVZVv3Bx9kg6taEn4JIuyf2g/ps5QWnMPdWn569fWulVuRQU/rlo/4ViM/oCG7STg6FxXsCfO+YIrONDoQIknEklAG1/GCrCtwlw5EyeI3si+WroZUuuoDJXeT9qKCRl2NYhBMeEEeKk6QyX/vFEc/xzezgkv3kg7qaa0QQlfxWJWxeglC4ZqzdvhymGprN1DVIEHUvsixczy0rIcw8CQHCVAchvcq+CBay05kGybTZz/2jAKsSBzdfga7zBhO7t0Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 06:24:59 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 06:24:59 +0000
Message-ID: <c5c67507-941f-4112-a6b5-822c126be388@intel.com>
Date: Tue, 10 Sep 2024 14:24:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
From: "Li, Ming4" <ming4.li@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
 <937b2409-c34c-4540-9bb8-3142d719a881@intel.com>
Content-Language: en-US
In-Reply-To: <937b2409-c34c-4540-9bb8-3142d719a881@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a93dca4-3657-4934-6038-08dcd1614b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFYyZGo1N3IrWmM1ME93bGxYZU9kNXNRamJBa2x5bVBGeEM5cG51SitDeHFL?=
 =?utf-8?B?ckdIN0x6TW9XaWg0R1cyT3hxeWFobFRCc0x4R0h0SW0wR3MyekZOcy9xY0dT?=
 =?utf-8?B?TmpEMFR5OHpmTVdNTTVJNmYxZFh4Y2tRU3hlWThBVm9hQVNaWjZwUi9vN1VN?=
 =?utf-8?B?dkZzOUZNdHAyRWo0Y2N5STM2Yzh4bTJDY0JYM3JKZVhOUy9EMCtDSVZ1OTV2?=
 =?utf-8?B?KzlHcVByeFpBZWxQR3d0U0pEZ3lPUjNiWEtUUlJUTlpRQTlJNDJOaVR1eHdv?=
 =?utf-8?B?VFRTUFJjTzAxRzREeHFyMURGaDRNdUZ1L3V4c25STVkzazVtVk14SmhaazZZ?=
 =?utf-8?B?MUl4c1llZitEcUErYUtqQmZMRkpzQ2RhbHh3MFFFWjh5emNlYWFkUDBCSnVB?=
 =?utf-8?B?YncwWjAwK0NUeTU2VVBSYld0OW5FdW1vb1I4d0pxY1hHWHRUSU1oMTZGQ2lI?=
 =?utf-8?B?N3o0WkdWTk5TajlOMUt0d3ZFMUh4cUN0aGFJQS9oYlVrQjNORGpFSE5xVjkv?=
 =?utf-8?B?cm9iU2pBdXNtb3ZWZzZtT1NmU1EvTG9IT0FhQTRhTGpENkgySmNzc1lLN2Z4?=
 =?utf-8?B?NjI3VTduUnpVdkgzaVhnMXBoZWhnWmZsNjdCYkw3Nmx2MG14cDY4K01yb2VX?=
 =?utf-8?B?cnNFYThjeEFqeUZ5YWcxNi92ckN5MjV0UktNRFU1TUZqeUNKUk9ZczdnMTJ0?=
 =?utf-8?B?Mi9hb1VLRXMrd05JM0ZtejhiUzVvbzl4L01lZ2sxcm1RZ2hGb0s4QnVmSWdY?=
 =?utf-8?B?NlhocFRKODRVWWZjSTBqek1MTkYwazdySTdXamExYU93cGQxRkp4RE9QVlBz?=
 =?utf-8?B?K0VmaWNVWVh1MjFjMFRVSGdvRmNMZVp4ek5EOGx2bGswejZONTBKNHcza0tP?=
 =?utf-8?B?SDVJZDdVampHRWlxSDJNNzlqMmt6MmhWQmV5QWVOZVhrTDVWOGEvMUREcUNF?=
 =?utf-8?B?WnV6MDk4QmlMT0REekVrSkpoOU8yME15YS9pajZ4aXN0WUVHLzc3cndIM25z?=
 =?utf-8?B?QXpKY3d0U3VlNnBjMXJSaTRRbldONUM1RHZqMzBxNjRSUGxhR3lvMHp3SFJ5?=
 =?utf-8?B?SXBLOXRmbGx0MVN1M2d6enNtYnlBUHFYSEFDZHlINkVhMFI3Uk56ekFQSmox?=
 =?utf-8?B?ZVlSMWNPV3E5Z0l5bUFXb3o0Y0VlcXVDTi9pSWRURUVnNUhhdUN2bkdFZWlh?=
 =?utf-8?B?WWxQR2szQktOSHdQU3kwUlpDZEh0bXNTWDM0ME9nU3hYNmIybmN1bzhuVjl5?=
 =?utf-8?B?Z3ZsakpVSFBXaEdNRlpVdTdFbjRWME1NT2dtWTQ5ak90NE0rQU4vaUc5Q09l?=
 =?utf-8?B?RXV5K3BoUXgyMnlOZFE5Wks2UzVBbTZ0S2JoWWNhdTNSZEs1d3dmalkxcVcz?=
 =?utf-8?B?Ym5LcmlaMklnbmFWR2dCa0luVmNTUGw4T1NZOENsck9lR0tRYWNLVVFMLzRJ?=
 =?utf-8?B?RjlONGtVdjhGUkh6UU9WZGY3dXNWK0kvaDVNSnRxSm9MTkN1dUJ5eGNpT21y?=
 =?utf-8?B?aENDVTZqT2dkQ2dESzFXa0Z4MmJwVzdNZGQ5T1BreUFPNDRtSTlwTW01c09m?=
 =?utf-8?B?bHpFcW9aSFc4Skx3cWllWG5TM1YwalFXeUZMMHNHVm1DUy84aWhYbGx2VDdQ?=
 =?utf-8?B?V3FQTGc0N2FmRmtraHFOTFEwTEZkbGFZUUZYN1EzeWZSQ1dROUNJYzZUUUxD?=
 =?utf-8?B?N3huQmJqMHJVZGlZY0tHY3RZbE8rcU0vejhtdnU5dE82anJHQXc3TzN4T3pB?=
 =?utf-8?B?Y1k3UmFoZFBETC8wMkY3TGhLWkVPYVFLRU0xM204dWVuT0lCamI5YWpFY25x?=
 =?utf-8?B?WFZVNzZHZ0VvMmpxMFVOb3MvQXBsTFZybDRnaFVtRHZnaWluTmxNcmZpb0R4?=
 =?utf-8?Q?TaoKP0IzJpzzT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhQZEg1V1oxNWdaMUdVQW02ZjFldmpPeUdSYS96dnlxUGpSbExQYUVEK2VY?=
 =?utf-8?B?dkxOcTh6L3VYSmQ4cXdLaG1RQ3BlaGtwcFRrdmVxTi9zSGRJQXptU1ZoeWFy?=
 =?utf-8?B?elFRenY5S3F3MThROGJWUC92MnR6cC9Kd2tJdytWUkljTTM3d3FCTy9lMjcw?=
 =?utf-8?B?c3ZDNlV6ajRubUIxaHJHajVtbkh4ekdleVNGc25CTGhxN1ROR29tMWFFOFNW?=
 =?utf-8?B?M01vbng5TC80KzF1ZmRmSmtvNThPVlhZd042NmJLRXRxYVBzWkl3QkFUUU5V?=
 =?utf-8?B?KzBkREFTeEVWZUw4a0ZtNGQ0N29lM0o0Ty9lS3ptb3ByU0wrNVpzMEljWng3?=
 =?utf-8?B?Um1OYk93cDBwQWZXeFhpc3VVSUo5Mis2NVd1UDUydTRpV0NPZGZKeTk3ZDJD?=
 =?utf-8?B?dlFwbUNKbTdLV1pZd2VaeEswSnQ3Y2t3NVV6dFdacG5CcWNzSFdzMGFtVkYw?=
 =?utf-8?B?UXhIeGhkQ2VqRmJZRk96eUduNzlEcW5QcU1hTmllQUJIUVhJUDEzdzhyY1FQ?=
 =?utf-8?B?NGQ5VVlsY3dYSitUU1F3VDRXeVZEckdmMnhqaGtJQkpERGRpU2xLVDZmcDZn?=
 =?utf-8?B?VXRwN2duaVlpNENUR3dybkhwcGEycnJqcjAvYWJjN21kWTNydkZ6U3NIY1ZT?=
 =?utf-8?B?UHIySWJKTVJUU0o4RnRERlNnSU5uRVRIQ0tieEErY1NZQ1BpLzMrdUdyV1FQ?=
 =?utf-8?B?YnRzcUFCQnYxM1lGMlZuL2VtMzdndGVSRENxcjVWbUZKdVFxUndxdGc1UGNP?=
 =?utf-8?B?Rlk3MnIvZ3NvMUpVdndLQjZJODRXQTQvaHhDQ1lac29WQVNad2VuQ1BNdTVr?=
 =?utf-8?B?MjB2dFkwWkQ3TmRtL0lubDcwWkxkZ0QzNkMzdU9ld1NYaWViS3dJTFRsMHhu?=
 =?utf-8?B?ZkZ5M0lZTERSei9nU2pFbzN1L3J2OWVLV3J1UXEyTlh0NHQ5ZFdaeXRlSUxZ?=
 =?utf-8?B?RzFmaEpzZHhSSm5vT0tzUXZDWWxFYWhDN2RGaDZlY0tFbkFWbnBlT05WUlBq?=
 =?utf-8?B?SHUzeFN6U3o1ZGlQNEVWNTJ4YUVhS1VQQTNjTW1Cci9iRlNRc3lmRXRCQ2d5?=
 =?utf-8?B?MTFCdXNodE5UUVFhV0lCc0RBTlIvTW1YNDVDT2JPSWFBVnpxZlJIemFVUSt1?=
 =?utf-8?B?blRqYWdGT2Z1b2NCdDZYWDE5b25mS1Z6UlhkTnNYNWtDcElBL3pZcE1kbW1j?=
 =?utf-8?B?ZGw1WXNBYTlzcU9meEhEcXRTSlVIK3FZYXZPWHEwNDlYaUM0WnJJbTV2QUUv?=
 =?utf-8?B?Mk9oMDdkRlM2UUpIVHVUYVI3L25yNzhOK09FU0lrRG53VjBnODlwaFBGTzFq?=
 =?utf-8?B?RDFxeTRVNVJHOU5YS0ppU2o4cjVjTDJlWnQ2ZVhFRThnV1k4VFhqL200a29T?=
 =?utf-8?B?K0JmZ2VMaWxMcDdiQmJoV2VDNTlESEdPRkVDR2pGQlk1WERVd0hsRjdqZXBu?=
 =?utf-8?B?dzdFV0dkckF5WFNnSkgyMXBsY21LYlVkME1TZHNEa3dTU3ROT2dVMDhKWFFz?=
 =?utf-8?B?WXY3K2E2TWFQaEUwZG81RGgvK1crcWtMZUttand4UjRzeWI1U2h5UWNwZEdS?=
 =?utf-8?B?ZVBDSVdXRC92SlgydWFpUjFWa1NNa2M3T0tlT3hWZko2RmJ6NUM0ZjRxK05Y?=
 =?utf-8?B?Q3dmQTV1SmpzdHgvdFZxYjVTWDN1VEEyQWVmREtaMmpvRnlQTEZQcDdtM1Jz?=
 =?utf-8?B?UnZDZmxqbktSU0wybVlHYWZlM3l3cEpOdVdSR0ZtdUh2ODFXUzlnWldQcko0?=
 =?utf-8?B?UVZzNUQrRXlGUmtQMER4T3VKUUNHY0dFUWw0WThJdEVBdTBQTTFQUkpQa3Jp?=
 =?utf-8?B?WHV2QktIeGtkL0hka2d6RGNkNG8vamlNRm40WGhjdE1KZ3J2U3Zvc3YrWDJS?=
 =?utf-8?B?SVp3Y3ZaM3c5R3F1RmNYVGN1WGxBaWFoQ0NDZmhhNm9wUUFGbkRHYnVrcVQ0?=
 =?utf-8?B?Qng0TStkV3hXa3pJWlBSY1BFK2dUcG51ZlYyWlVEeHRpYjlONzBBZ2g0RDd1?=
 =?utf-8?B?RVh6UnhyOFBzOWZETnJQYVZEM1YvWjl0TFN4ejlGd0hqQ3ZXbEx2dE1Fa3Jq?=
 =?utf-8?B?eE9qdm9NZjFwQ0tsVSt1R1BVV2ZnWnNQRTFyQndSdkJTR3Q2OEV1UHlzSFMr?=
 =?utf-8?Q?JQEKiDmVOKilEoEPJyKvRGuAp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a93dca4-3657-4934-6038-08dcd1614b97
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:24:59.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpK9RHWwX3Gp049zPW0NE/TrGQC0K/y+fqtMTF5g5QM/sh9YyA+QJbd2EmiXq7XVR+flh1kHfJRItu+8opBy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com

On 9/10/2024 11:26 AM, Li, Ming4 wrote:
> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>>  drivers/cxl/core/regs.c |  9 ---------
>>  drivers/cxl/pci.c       | 12 ++++++++++++
>>  include/linux/cxl/cxl.h |  2 ++
>>  4 files changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3d6564dbda57..57370d9beb32 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <linux/cxl/cxl.h>
>>  #include <linux/cxl/pci.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>  				     __cxl_endpoint_decoder_reset_detected);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps)
>> +{
>> +	if (current_caps)
>> +		*current_caps = cxlds->capabilities;
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
>> +		cxlds->capabilities, expected_caps);
>> +
>> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> Why has to use this 'u32 *current_caps' as a parameter? if user wants to know the capabilities of a device, they can get it from cxlds->capabilities directly.
>
Sorry, I missed something implemented in PATCH #1, seems like you can not access struct cxl_dev_state from efx driver side. right?


>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 8b8abcadcb93..35f6dc97be6e 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>  	case CXL_REGLOC_RBI_MEMDEV:
>>  		dev_map = &map->device_map;
>>  		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>>  		dev_dbg(host, "Probing device registers...\n");
>>  		break;
>>  	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 58f325019886..bec660357eec 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	struct cxl_register_map map;
>>  	struct cxl_memdev *cxlmd;
>>  	int i, rc, pmu_count;
>> +	u32 expected, found;
>>  	bool irq_avail;
>>  	u16 dvsec;
>>  
>> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>  
>> +	/* These are the mandatory capabilities for a Type3 device */
>> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
>> +
>> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
>> +			expected, found);
>> +		return -ENXIO;
>> +	}
>> +
> Same as above, the capabilities already are cached in cxlds->capabilities. seems like that the 'found' can be removed and using cxlds->capabilities directly here.
>
>
>>  	rc = cxl_await_media_ready(cxlds);
>>  	if (rc == 0)
>>  		cxlds->media_ready = true;
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 930b1b9c1d6a..4a57bf60403d 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>  		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps);
>>  #endif
>
>


