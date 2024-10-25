Return-Path: <netdev+bounces-139151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B29B070E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D056B287D5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095F185B46;
	Fri, 25 Oct 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRSYtDyK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C81547D4
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868603; cv=fail; b=IlNDuJJ2Pyu6L05zKzXx7UrwGDe4/82U9/GssYVEF44JoEfUU8LlK3yF7WCDDfbUL8rFPJEWvLwoDyMXJQJkz8s9mGdgH5gq2cJ3USM3TLtfCGcyOyiATUHPyVNGJPWa03qgbR+zzJVtm43KkcDlX6EDDGXMNZpEuWy0CzS0UrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868603; c=relaxed/simple;
	bh=OtzNa44m9SAyLHbZibvd0WqH0qrlBp/qeNLdNfHgxPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4Qa9vh28i2JcdyS1BuB09E0c2BentKwdV/gFu4VuH1LgFpLfcxofmgrqw8hF2cFWifIQ01/Nuu+Ca5LHnyLTAyvG12CaqLEf1sdcPWe5MNjJtNbB3/2oMoW5xeETkmG8KeqXFwXX2vccw2FbHYR6Tivpvfbmfs13Z3SuhtQ3f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRSYtDyK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868602; x=1761404602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OtzNa44m9SAyLHbZibvd0WqH0qrlBp/qeNLdNfHgxPA=;
  b=HRSYtDyKfsZyZ1YhywmF3VQDjUR0nDEFvOvddTdvTLjpQhwxo20GKLQ+
   yHknAbSzIEjaiyrmz2twh5EW7Vr+gz/dWxBo93BhYGSfICd7wNbhKR2YI
   MVRF2r/T35Iib+Eg+1MmR8JyrIkKeI04f7NaYVpZkH/1yf+Ce2pAyk4qU
   bnSkApv3CQV8dast1WKThyzNozFLwpIej8skAB5hl3XrmIJJlTXfRiUj1
   YDJ6/f8mLp6K6f078NLbPSWe/YAgU7UlFnJvVYBjQtc5LKJliRTYPgPf4
   XNCtEJ0nxUCsXE4uILVFvfGWEWIEpoNq0rRs1YPeQWB8R4qBqgE1VMCM0
   Q==;
X-CSE-ConnectionGUID: z9edj/mZSrqshpVJSshBpg==
X-CSE-MsgGUID: smZYJfnlRQ6s0pIxwfK4cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29657812"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29657812"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:03:21 -0700
X-CSE-ConnectionGUID: hTddNjvPTgObFOT++JEbZw==
X-CSE-MsgGUID: YxQJOnHrROOJ7T0D0mBQsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111767718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:03:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:03:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:03:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4NptxY9iNW8afGm20ska3rOMqpCuV/YTN7fz9IIWA/9L5G30qYRGxJSzir8aOOj0TAsWEn11fNdB0xxc5KOF3fnXE8J9WvtJ3faYuUq28a4LQF45pdXPDfJh20KXa1ai2NjyHRde5lmUxClqc8/S9o0TUveyz/GEOu3UCP8F1wiG94u5DaiRaV6+hnMKroUyAjomAtYn6K4chuEWbDGs7TbAKvjUoINGuV4cC4oo9NNzVSEXXWHWOU1BaqmhMFhD+pEYsU4mGldLYn2J/ApisEf2zdzSSMgpJ+UXGrQhMqRZFPK05o31t+/kda+9LZC7tRyTubLUgEoaD9ybmXIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZCj9c7OGH+aYNcM6QHBivTcJnXt76pHkTVOXFy+VQ=;
 b=pN95GYmPBgbAfhegjM+mD71IWptSnuE56yfpsGfOo1AfmnN/mM78hYXYl0qZiMSMHA3wGiQ28gI4E5xUtxQWMFZaI7toMfYM1YTDw8TylG+BV9N8QoYWY/yELtmbpsyRLHHdgDHNS0IDd6PAuP6iIhDBjd4+R2EhoQ/6Ld0Ha+KhfY7xuW07tFjgawZBi7LZf3UpNu2DlC56BELsNaH//HRK5jw63ngsxye/Lt9vX1hDZMl/7lTSGpPeYeqKEmzU6+HndjiGw2Yb5U7RogyPpxbCJ6rqlnMi1rCv0qqJolOrcoezGUMNUr2FNVIXYNgsJWruT4EQDxbLIVTeWY7wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 15:03:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:03:08 +0000
Message-ID: <a68cedfb-cd9e-4b93-a99e-ae30b9c837eb@intel.com>
Date: Fri, 25 Oct 2024 17:02:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
To: Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
References: <cover.1729866134.git.petrm@nvidia.com>
 <92e01f05c4f506a4f0a9b39c10175dcc01994910.1729866134.git.petrm@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <92e01f05c4f506a4f0a9b39c10175dcc01994910.1729866134.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ1PR11MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a58432-7370-43e0-dd4d-08dcf506227f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3hmQVRCMUZONWlNRmhNVWFRRC82UUM0Y0ZKUHFnMWhlV1JVVVpMTE5kTm0w?=
 =?utf-8?B?WFB6VjBrbGp1QnMrS0ZEdXFoSUppWEdsUlRnL0g4RUcyZFNIalZpOXFJVnhu?=
 =?utf-8?B?YjZVVitLWmV3dE9aNlRvZG5pU0RkUlpFdnkvVVFhOExRRnh0S1BSM3Z3OUYw?=
 =?utf-8?B?Z0dxTklNNnRiYzdjMkk1M204VnZhd203NWttZnYvK2ZKVzFKa1B4dkpLNWxz?=
 =?utf-8?B?WVZ3ckY1Ti9nUUk3dDRTVzJjem9Pd09PalRZTEg3SFZNMUVMMldQd3hBVCsr?=
 =?utf-8?B?bmtSdkZRQ2lmcTRGNTVGbEppeG9icS9qeVp1cHJHRk93WjF4d3FzRWRCcC9q?=
 =?utf-8?B?czlWSHQ2aXJKWFgwazVoTGFZd3ZCbUFYc0grWmFwdlU5TlZRNUdFcWJTcWF4?=
 =?utf-8?B?cElnRm90VXduQzdCUTVRZWg0RnBJQXVYbFcwa1loWld5Z1QxT1dQNk1MTlVV?=
 =?utf-8?B?M2w4RC9tS0FxWkM3NFhISktrVmtraGp6MzFHYmc0Z2IvUy91bnJRNm9XUFda?=
 =?utf-8?B?MDROUjZMelE0RnBONzdoeDVUZ3lyQmxHeWxlVUJyOEpRTTBMUVBjYUZyK0pB?=
 =?utf-8?B?VzFOYmd6aHBYK1QyYWRNRmxpMWU5YS82RzZwcXlvR1hoOFNYaEczY09LTCtQ?=
 =?utf-8?B?UXlKT25xUWFaUUI5T3JreEZwQVRxYm1qVGtoMStXWVdmbE83TlZzWVBZR3Nw?=
 =?utf-8?B?K05jSkNUbWNOOE83b2pJSURJWVNPbUFiZFcvaWFkSFJEQzVOZVNLNlRibEh6?=
 =?utf-8?B?clVUc1lNWlpRSDdDZGdNSFhRVm5FbGVCbEVSV2R1V2txd3ljMGF0RkxtdUtQ?=
 =?utf-8?B?TWdnbnJka1ZlNlNXY1I5ZSs5dzB1Qkl2NXpacWFLa1RuUERzYWZMcUtYR3RO?=
 =?utf-8?B?TXk3WkxzZEtSTCtDSDdvdUloVnBmSjc0MUhWTnlTbURnd2hJQmNmZk5Pajkx?=
 =?utf-8?B?Wit2cFliSVhSdTBYSVJ5cUxyVHU5QVpJRlFWRnRjcnJGNGVJTTJSMWFFZlFh?=
 =?utf-8?B?U0Vab2V2b1I2cmVpZG96TFAvODhEQ2k5Rmh1TksyV24xOFgzRW5SdnplUlBa?=
 =?utf-8?B?SjhmdU1wcUNpOXBVNWszdE5HcTBGMzJseHJDRkt2TC9QSjZxUzlDQW5PY25G?=
 =?utf-8?B?Z0phVzExMCswQ2pVckY5RFNnMTdmVU5pNkx1bnJJNjVBaTY0cTJ1T1VpWjNy?=
 =?utf-8?B?UnFod3dpbER0bHlGUXFDYXdhVDlORDZoL2YxVjExRm4vSXdpbHJGblNWRCtH?=
 =?utf-8?B?VXBqZXNaSFRWcFFSQk5STjNpNUQvSmRaalBrdjNNMzVpbE5HbStBbkRmSmYy?=
 =?utf-8?B?cUlLSVlLaHFmTzJYMnNyWVVPdDNWL1J6QngvRXd0THVRaWtlRmFXNFlYSUtt?=
 =?utf-8?B?bFZvOElpdEtzeW9vSXBhRlVrK0w5ZHNoNmJWM1p2Q1A4cDBnM2VmaWtIdmIz?=
 =?utf-8?B?eXRUQk9waEVsVko2ODBWK2IxTXBpSzM1dXZPckMwSndweXVxTURML1pmWVBs?=
 =?utf-8?B?ZW45Y3p5Tks2blBWbzVSSXZsNEliVERPN0RsdmhzaWN4dzFRNmNBVTNmRmNH?=
 =?utf-8?B?QXFid3FtdXBOZGJKTzZPb0JGNWZMamlVc0dJZkxhVWtuZmptU3RvUHhpSmh0?=
 =?utf-8?B?UC96bGVuMU5JQnJMQ1R6bGJlenVtMnlESEpRMVhLL3NpWnVPend3T2xva3pn?=
 =?utf-8?B?dGJLaFMwOXdyVkRSZmlLSzd1T21TdnNuaDdPZVdIbGhMUnFQbTBNbSthc0dP?=
 =?utf-8?Q?QCpvs6uxzn/eud4EO1fdkSh4sA6WqJ0zYdlO45h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0IrdElSSTMvL1ExaUkvMEg4S2p1c3RkRTZQUnk1dzlrS2xXNklGbUt0dU9o?=
 =?utf-8?B?VFJpYUp5U0l3K1NPLzdITUg3bU9pd3lwaEdUcXROQ2FVanNmejdRZlRBano2?=
 =?utf-8?B?ZVlKOGN2emlOQTNIQUlOejFmUXJ6N0VZL1V6ZzVaOFJFRklTQXdjM1RWTXVB?=
 =?utf-8?B?THhkRGFLTDRhdG11NUxxQ2J6bG9kYVZIeDlSNGIrV1NNQjdPeG9laEtpVFhi?=
 =?utf-8?B?OWZFZm1vUmdrQ2FEai9VUVg1NENMNmlVbUNtR29qRVFVcldjZU93THhJSDR3?=
 =?utf-8?B?Y2xzazdsemI5M2hVay9kaGgxMnhVakxJNjBGMjNOVWkzQWg4eGU3dFR6YjZx?=
 =?utf-8?B?ZGxYREszRzNpRzBvajJXam8vTis2bzNFdEd6SjIrcEpSbTRoTDVSOU5SZDRP?=
 =?utf-8?B?NWJiUnREZlhRdk96SVlWUVBXbWlScnF3dzlvdm5HbWw5QUVJd2pnblA4SUZV?=
 =?utf-8?B?MnpLbVRrR2RSeWtNOGZXY05ORHVMWFFESE13NjBLRGVxY2Z5ekxiU1VTYWky?=
 =?utf-8?B?U2pWRit1RzB3bTVCdEtlamxwZVp0alZNTng2VjhSMVBHYW91alZZVnBRTEEy?=
 =?utf-8?B?TnVEakcrdmQ2MmNBcWNtUytORS92LyswOXZrQTNEejFFZ0l1Z1pvNzhXeDQ5?=
 =?utf-8?B?TVFpVVAyQ2RNUWsrRERoZjE4YUFkald5VURBaEt1RUZzY3JOMDliNngwNE02?=
 =?utf-8?B?MlA3RTJJRDhqOTN2dDBEbldPVjZxUzdQUTdxNVZ3c0pNWW1Gc1plTXRTdG4z?=
 =?utf-8?B?bmZ6ZHlqcnBRaU5jdVpicExpZnhzM1FyTHNueHFzT2QrOTExcDRtTW5lMTdD?=
 =?utf-8?B?YTNZY2ZBWTU5dU9aVGgydGZKTkI2ekpHZ2ZOREhkWVJobkZqVDk5dUlhbHpM?=
 =?utf-8?B?TTU3NEZTSGpkeG56U3NrZTdTZmN0d21YODJJc0xMUEdSUFVGVFZmZ1ExNERG?=
 =?utf-8?B?Mk9QRDg2UExBU2o2TWYvcnNVZkI4YnVQWFRFN0tTT2hsUkpPanZxcXNGTHZ1?=
 =?utf-8?B?OEkyN0V4UEZKWS9kN20yNHhQVkVrSlFJNlp6MWtZQVNQS3JIcjdyQytEYkN6?=
 =?utf-8?B?OHdBaTZUNm54bVB0Yi9iOUkrNHpkVG1MS2VYKzRyc0xBQVlCMjBHSG9Zaitl?=
 =?utf-8?B?NkxzUDNsbGQzRlp6c25mWU16SUFLSVU4eTBFVjNnaVJlTXFBNlVJYmo5SjlT?=
 =?utf-8?B?QVJOczNUU0VQSmk5ZEN6ZTU1OEwrM3JCMUhFSHB1bWJ5bUVvQmJ5Q0FGNlJ1?=
 =?utf-8?B?bFRTMzF5dTJLYitXZm0wdU9ieWNyK3o1VytIRHVqeW1ZK01pQ1JMbm0xUkM2?=
 =?utf-8?B?eG0vbDVjb3A5UVlzWkNpbWJCb0ZHYmtMbUxyZWdGY1hkTFplYWJ4WVorMHRi?=
 =?utf-8?B?SFZuWG91U0NjNVJaOEhOYnZoTnBCRWhCbVliM1lpOUVMclRzbjFzeTR4dFFW?=
 =?utf-8?B?eS9BeVdWK3RzTHpnWHJIdmJCbmJBZENTbldWdnFwOGdDVlZwY1pTdis4K2xC?=
 =?utf-8?B?YmtHU2RXVHFOMUpNNkhUMUhxdHBQclhuUkJKZFo3bkZLcVZLYjgwT0paK1d6?=
 =?utf-8?B?VlhMd0JYZHdSWFZjVDhjWHFMelFDV3dtMWpHTFdPQzBDV0F4NHVtcjZaUXl4?=
 =?utf-8?B?U3V4WnllMEF6ZzE2THpTZmZUREdOdi84WENhMktKSURLL3RVS0tBZ3AyME5H?=
 =?utf-8?B?dmVjbjd2Q29wQzAwMTFFazhybWF2dHBCVWptN0ExRjRaWmZGVmJEWGRNVHVt?=
 =?utf-8?B?VkJrNlllb0dZY3MyRWhiNFRHSHVPZTFDdjFYUHBkTkl2QUFVWlY2VEZUNk1y?=
 =?utf-8?B?Y2tZNDZmVDQrTTV1Q0VITjhaYjV0K2JNNVpnRkFtTVFaaHRZeFpGeEJWS0Vn?=
 =?utf-8?B?UW8rTFBUMC9rRjN5aDZNQ3ROTTBsVHY4eFovWU5hdVhlZVhCZ1I2cVpCc1ho?=
 =?utf-8?B?V0tCQzFrTldHRjJaTEJkT0VNVjFqdGNSVDBFWGF4UGxXT2o5TjA0SkppVlBC?=
 =?utf-8?B?K2o1TnRNK3FKdDJvRGgvNklCM3kwVVdwbUx4R1U4dkVHUmxIRHFiemM4eExy?=
 =?utf-8?B?ejYxZHJ0T2NiaFk3TzJnZWdGeVZyVEpweEJpeWhiQXhCclhKZjkycTBoTks3?=
 =?utf-8?B?TWNkRVZIUHNybUJVR0htK2t2d0V5QnQ0akh4Tkl5NGwzMmlhVDlmSU1rQ0lo?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a58432-7370-43e0-dd4d-08dcf506227f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:03:08.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um81QFtK2/8ycgrlwVTbLvp+uYMdp1kGOQxloABzFreDZZVN+VKEbFgtXE1qbi8VmqmcUDXyLKOI28cFJQuldznbpw3FW2nOFXdZ2dR7Oyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com

From: Petr Machata <petrm@nvidia.com>
Date: Fri, 25 Oct 2024 16:26:27 +0200

> From: Amit Cohen <amcohen@nvidia.com>
> 
> Non-coherent architectures, like ARM, may require invalidating caches
> before the device can use the DMA mapped memory, which means that before
> posting pages to device, drivers should sync the memory for device.
> 
> Sync for device can be configured as page pool responsibility. Set the
> relevant flag and define max_len for sync.
> 
> Cc: Jiri Pirko <jiri@resnulli.us>
> Fixes: b5b60bb491b2 ("mlxsw: pci: Use page pool for Rx buffers allocation")
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index 2320a5f323b4..d6f37456fb31 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -996,12 +996,13 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
>  	if (cq_type != MLXSW_PCI_CQ_RDQ)
>  		return 0;
>  
> -	pp_params.flags = PP_FLAG_DMA_MAP;
> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>  	pp_params.pool_size = MLXSW_PCI_WQE_COUNT * mlxsw_pci->num_sg_entries;
>  	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
>  	pp_params.dev = &mlxsw_pci->pdev->dev;
>  	pp_params.napi = &q->u.cq.napi;
>  	pp_params.dma_dir = DMA_FROM_DEVICE;
> +	pp_params.max_len = PAGE_SIZE;

max_len is the maximum HW-writable area of a buffer. Headroom and
tailroom must be excluded. In your case

	pp_params.max_len = PAGE_SIZE - MLXSW_PCI_RX_BUF_SW_OVERHEAD;

>  
>  	page_pool = page_pool_create(&pp_params);
>  	if (IS_ERR(page_pool))

Thanks,
Olek

