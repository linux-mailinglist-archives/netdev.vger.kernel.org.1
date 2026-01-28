Return-Path: <netdev+bounces-254482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIBvHyGIemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:05:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EEA960A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0DE30214EC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DAC341AC7;
	Wed, 28 Jan 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvEeK9Ay"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AB341056;
	Wed, 28 Jan 2026 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637907; cv=fail; b=TMsNduZHwlZk7Dt7FdOq2jC1R7c9XVKmfarZ10FOBTT5ejPZK9vbFux8rm6Oee1vpVRK90jgzhB+r8DALw82UOhRzodt5sWjNMcpZcCTZx8fgLCFykLHG6Tooc/o5bVHm0Qk9R15TjkQA2kD4UoeYGQq5Hi8IJJOeovV1ROoDik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637907; c=relaxed/simple;
	bh=g5VWBSahEtijrJcRaxoieyWcsIlwjK4YQRihPTmbBnM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRcs2gpc6rJgtvZiaKAIS9ldX/kyPTJ5xj60RZnWxmsgKgRDLU4JNwutPP+U1kt0yGP0U6jPdLVQC/F0HqfZ07U6vVLCnt7RPRJp+5yoZX5/ESndeuEfhVfd81WqNPEX5QPV0yqjHe5+SJqFBdU6ULDdLSGu2YIB/K8sJM+xdzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvEeK9Ay; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769637905; x=1801173905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g5VWBSahEtijrJcRaxoieyWcsIlwjK4YQRihPTmbBnM=;
  b=jvEeK9Ays3eY0sq9nE6jIxhEsNPvFF+PhS5cmbGy/VJ4hciO9KYHjdTH
   uYxrp/QN+AvIgOGOibTavvr2xJximgMZaT/HhwXgCJRwCuQkvTR1fcqAT
   gUMbQ4TmMNjmLNMX40aE9crgyK7scAxb8f8D4r0NXiBYbLiNgnZzBtgFm
   sJFQCX1m068uUk+4732EX8BhBR1jnIOKVZhv7MNXGMDig34PCxy3BYCIh
   xFsOKHkj4Qu74+WvWCpV5DkUxQHvHe4DkSWwPNy1liYcdbgQ9eINl2DaM
   eyGQ30Gm3U72W4TJbN4jLhWbMkZA9HQWkV2keztsqUyAaLIWOcf4vQ4GE
   A==;
X-CSE-ConnectionGUID: s8OinPeWQSCPXENMNF1GpA==
X-CSE-MsgGUID: +/Onp//USUG7BqynC+jaPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70954356"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70954356"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:05:05 -0800
X-CSE-ConnectionGUID: XclgFGivThyAIZRPS1lcyw==
X-CSE-MsgGUID: zNbf1rC9T0ulIrJrj2YtrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212892036"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:05:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:05:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 14:05:04 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:05:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDbPEwPS8fhlhpg3/YhcUwsr8yU8VtepiBdgli4h1tBGHpeac82relI+5JDqkTLdmlnCBspoM9itqEbBBw/bizIlAkh/SQWs0KqQ4V7NUXs0VDGTy1Xw/GXvThkiLyLX1Ktkj2f+D7tqJmQX6vcTeRxO2mU1Wy39+H3POt3nnhM9IxK0mXCn5mZyviVf4YlQeONS5Fky0jfOb+LgOqvCvg/A3KptdDlOP4aHXHzpLeENkT5YT6h3JvH/n5dgQxCJMjLWKclilM0JzkFmvFOxWhPdRSrhHCn75REbAMsopDp9Inf6HtgSscc4aEv+TyUCPu+maqaoE19ZEnmamWDY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQKQTsc0IshiO7uO/QTNm9Fx/stNM2z5aUk3/w/zmMo=;
 b=GoQACqtYQ8xsxn6/sW79xr5FBzo/S7pujMHkjyRAOxtDj+9hrbfv6EX5pXh/h3Q40q3roRPotZ15DRhIDdniROIwbZIq99rgkAoHNfFX7VkhHKIQZ3Ek43PraJ2bTm66kuylaBjuIKUWpFQEsbZ32NLLz0vzlPen5Smc6UYQ6gBAX2JdQt66+t73ZeneMxZJTNdQGNVs+fFcMmCHJGLcmPNJGWmlgSSBOgKehZhpBtsX/ns+kF+C/LNN/F7HH0GBqFKXPsi7olTQFd0tApBauPcWAGc7M4obvyP34olrZy0JckTGuhtWC7urR9zAZZPDfvGmEjHwIBWXxjIllsLU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 22:04:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 22:04:56 +0000
Message-ID: <15f24a74-05ca-41e1-94c4-f905e20bc190@intel.com>
Date: Wed, 28 Jan 2026 14:04:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
	<linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
 <5b8fe4ae-25a2-4967-bb83-a52dd5907951@intel.com>
 <20260128220248.7a0d5b9f@foz.lan>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260128220248.7a0d5b9f@foz.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: a17650f9-6498-4d7f-45ce-08de5eb945b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Skg2clUyb1FpY3Q5L203ek5xWVovUTcxTHU2K1ZwbnkxYmtXN0Fpc0VPcjM0?=
 =?utf-8?B?NVgzUVZPUmgvVE94SU8rVFYwYUJUdUVHQkJNalptaUxaem9IU3R1eEJKd0Jl?=
 =?utf-8?B?VFZxUTVnbVRwcGQ2RVQrMFpFdjVHUm5DQWltSEpnd0ppWThCL3piSlB2V1d2?=
 =?utf-8?B?VDVhZWw4M1ZtcW1JZTVFOUlObkVWTEkvWWNLMDFaUkNiZWlHemxoTnhIcmov?=
 =?utf-8?B?YWNmcVlIcU1qd1BEbGNsUFB2cm92b2ZWUXlZZFdGb0Zrd1U1YUFXZndmT2lU?=
 =?utf-8?B?Uy96UndMQXRqM0xXcnJqck9weUxCY2pLVzlaWVRhNFVtT1RQT1FXMk8yTXIx?=
 =?utf-8?B?WU9zZ2tuZHpHWGlzZWtGbEhGQ1RTUmxROGQxcyt6Q0hIc0Jhc3V6WWsrUCtJ?=
 =?utf-8?B?ejZFYnlIQWpwazBzaTJ1NERUclVIaE1SMzVVeVE0d0QxUHBra0pOMjVIUW1N?=
 =?utf-8?B?blZ5Z09FRnk3QzZFNGI4elVqVUl2b0c5RVloUm1za1pFdzdNTkNCUWRubFM2?=
 =?utf-8?B?SktHYVVCY01yend5VzRMNTk1MUR2cXo0dUN3d3BtWE56VnpiRUhFRTZaMFZS?=
 =?utf-8?B?MlI3K2RLTmU0Y2k3empqN3Y3Vm9SNTZhcWNTNGcveDlZM0p1b1ZJa1JoTTZl?=
 =?utf-8?B?bS9DaFJMQ2hXcy9yazlqMDlWcVlDRWxLSm1SSGViMS82OGg5eEdqQmYrakw1?=
 =?utf-8?B?VE5TTDdWZm9jV0lzME9SeEM2Vlo4Y3oyM2tXUWpzRm84Ky9KcDBoZHR4aHoz?=
 =?utf-8?B?ZFJ2RkUvdzVlZ2VWcUs4eU1ueWNMbk00V1ErMENaSGtzc3dUNDg2MkVXUnd6?=
 =?utf-8?B?b2w1YUVibFVvUVJHTVFOcHhMSUU5ZnlKVHVBQjRyMmphcStVenNNSnh1Ykpa?=
 =?utf-8?B?OWZDbEtUUWR2MVJKY3RaQktMUU9wSnY2TThyZ3NrU2xwbVFaYU1Pb2o0VEpH?=
 =?utf-8?B?eFNyR3lDRDRvN2JsVFFMS29PUE9aUEVSMWxjWlFzczk3cnVPZXZRcHJSdUVX?=
 =?utf-8?B?KzZ2TC90ZlRYd1hXYkRRTWJBRGRJaUJJVTBWNXpKbVBLU29jZXRTMVZkTlRh?=
 =?utf-8?B?SXNzOVUxQ0laOER1UEgvTmZHWnJ2NndBTUplbTVnOUpwY3UwVVlmcCtLMmQ1?=
 =?utf-8?B?OW5IaEx0TXV1M1RnWjNBaFRrT1hZNURkSFppSlI4dS9OZG0zRmEwVUJvYURp?=
 =?utf-8?B?WTZnSm9SR1IrODNDVjdFMU9iTDNXUEp4RmFsOGhTRDNWUWxnUldTN25SRHVh?=
 =?utf-8?B?VForQ1R3bjFxdWlib0ZyTldUanZ6aTdxQStMTGVlSllsVlFYS0dqbWdha3NH?=
 =?utf-8?B?MnpPOUJLc1lBUEVMVDd1L2J2L1FTeTg4Ym1yMDRsYklJK0E0TWtKWlc3eVZM?=
 =?utf-8?B?cGp6M2FRNnRvZk5WSTE4WHN5TjZETFUzb29jSmtCcWE4bkIvWUNjTTJxcVpD?=
 =?utf-8?B?VW5VRzJ4eGRaTEFFK2ZjTmZhdytIQWg0NnBma2ttSVdiZTg3TlpObzFpYjhQ?=
 =?utf-8?B?Y2NhNFRQRHVpL0ZrbHM3ZGpVblVrdGp3bXM2QjEvRUhhM2lIMjhjVXJUOEJt?=
 =?utf-8?B?M0d0V3paYWZwc091WnFnWFZQeXVzNmNDTk1nRWQ4Z20yWFI2N3pIclNKaCtL?=
 =?utf-8?B?eGVWbk9sNGIwdUhtNmRQZHZrSHlUVUxiV2FFZC9qQVFpa01CVlJqalpaZld0?=
 =?utf-8?B?d2pWN2dFK2o0UWF6UU5OTVpySm9LU3JKbE56MHVqSTBLbzJMNlRYVkRLeG9N?=
 =?utf-8?B?bWJNNjFjL0pGS3ZYSlRjL00yaTJKbVJxV3NJUWRuczN0RThWTnZuRzhCTzQ5?=
 =?utf-8?B?akJRcktjenBja2pvallaeGl3Mko2VW5ZWVF1SzdINzJ4d3BRcURJekVRR0pC?=
 =?utf-8?B?VUE1ekhwaWI3cU4zcXNPK0U1a1BSTE1BVmQ1eFFqYW14WWZQUjdDZUVveUtS?=
 =?utf-8?B?T0RMZC9nNU5hVWpURU56TVFFMWFIZEhBLzVjM2k5QVJsbDlGd284dE83ejR5?=
 =?utf-8?B?NHFHTlloOUh3UnpzTHdYRlUwT0l0NjdIY1B0cDRuYkRIaHRYUU1QTjNoZk5X?=
 =?utf-8?B?VDRVM1R3dFFRNmVpb29CMm9JT0t3MVFYZ1BDaEtwY2JtVjJvOHZMMTUzMDVQ?=
 =?utf-8?Q?FXyw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBQU1M3Y215WmlTZnJUTVZxZElnRVVBSHNQOUJLWFJWeEVEZG1MR1A3WnEr?=
 =?utf-8?B?bWhMd2lnMitBbUhFTCtLaVZUdG5VVlR1WGp0SzJ3TWFrZ0o3aUl1eU9IODFw?=
 =?utf-8?B?eER0Q3pESTBZUWdObFgrM2JIY0RTM2FLQ1pHWVpETlBFNmoyUnI1dnZ5NktG?=
 =?utf-8?B?aXRYVDc1NDZRaWI2b2cxWlgxbVVpNzZkaEtrQk1uU3VWZTlvN2JURkFEeE5r?=
 =?utf-8?B?M2JDeFBKZFdmOWhBTU9MWGxZN3NTSVJyT2FWQlAraUYyOXZFOU00OGZIZFBT?=
 =?utf-8?B?M25zU014Qmp0Ui9iVjc3R1B5QTltY0hGbzJSZ0RKNERiWEtvZ3RzeGlucHo1?=
 =?utf-8?B?aFp1dEpXSFlaaG1QaitBU01qNUVPMnM1S1BCNC9LcUhOaXp1amxPT1RXb2xB?=
 =?utf-8?B?M1dtc3BsVWhRK3hzcURsUUFhckFEaHQyUFdTeDUvVmRhb0RrZmVSL3U5UHdF?=
 =?utf-8?B?ODF1QVFTT2Z1NFlVdTZxLzFrUkZvcWMvb1JFbmw0NGdmQ2J4TW42SzMwbXMy?=
 =?utf-8?B?bFB0T05BSmFkekJGVlRaRzY2VldIUTBsd0hmckFSdSsvK2kwbG4zaWYyUytY?=
 =?utf-8?B?VW1uYzB2eHpidGpqVnVuWDRNVWZMVWJ2Nm03QmRQYXlCQ1pWdWlBaDFBYUF3?=
 =?utf-8?B?N0prVXZDVnBMQ1BtZkhySnR4cEt5OFNmazV1T3g2RUMrRFFaNzZNVGlmUlc3?=
 =?utf-8?B?bFJqamlKeTFWY0szdndDcUsyZVBWb216M1RFUElXMVN2Z1pKeHhoYXFMVHJr?=
 =?utf-8?B?cm0zQjZCR0pqWU9QYzBhRzJHRzhMSFZxeUFkWjZkQ0VnandKdnprcTVselhD?=
 =?utf-8?B?MElLdkYyUUgvSlM2OTRxSE44YmtkazJxSUJIZ25BWHZLVmpOMTRYVS9EcnFh?=
 =?utf-8?B?V2MzdVlMc1F0MTVPNDAzd1EwMVR4QXRRQTVqb1I1a3B0SGdoTHhkdzhSS1ln?=
 =?utf-8?B?b3dHOFhPRkZkaDFmTTVhaHdKOWhjSFdLRmM5NkRqRHdCOVZpVU1ublBLamxj?=
 =?utf-8?B?Z3ZEd2orY2haVmY1M1FKaGpLRlZiTVV4YUdUeWlxUVVwZDFyNHpFZE5iV01I?=
 =?utf-8?B?bUE5a1I0cDNGVXBhbmpaTVBwaGFVTHdlUzlwTG0wcGpLenpNcnVEbENKcXpU?=
 =?utf-8?B?dUo5N0lERDJYVUl2eHNhYzZWQmNOSFZBVVhnV3g0d2lreG9jL2ZWcmVBdm9s?=
 =?utf-8?B?cEgzZW5uSFhaeTJ5NjJkMmxTdFpMMnNyWnhWazFqUnVoZ2ZvcFRJdzdoK1lj?=
 =?utf-8?B?Z0o0WDJadWJQdW82L2xsdURUdHpVVktuM3VURm8yaUROc3NDckhvQlhjSzdF?=
 =?utf-8?B?NnRzNklmNkZNRkw2UTA1UjE0ZXI1em0xem8rWUhlc3ArWXM2ajhXUWpvQ3lM?=
 =?utf-8?B?dGo2OTZROUh6Vm5pOE9PT2tvbzlibDEzTWxPRjY0TDM2YkdkOVVMUmpiNnlY?=
 =?utf-8?B?UndCbDBwcDBsU3hFdlJBZXV3VnZRV2YrY2FSUzZ1MzZGVEFWSDZRTkg1ckZx?=
 =?utf-8?B?cmFTYk8xejdQWmFCanV1Ym45MDRxcEJ3a1JjSDFRSVpLSEc5U3hGemswMjNl?=
 =?utf-8?B?RmJQRXg1ci94OG90Q29OdlJoWWpnYzVNN2pmN3RxalBJaHAya1RnSkNRZGU1?=
 =?utf-8?B?R1RtSUluWkJTdkZSSEp2VHNSbmt6RHBKU3d4TXlLQXZJSDFoV3A3UnB3a2Rx?=
 =?utf-8?B?VmF0Y1plSTg0UlVDVE1MTHpKTVNWZ1Q1b0czR2JqWElNSlAxS011eWV1c3cz?=
 =?utf-8?B?VXp0Z1BrM0VtajRqNTV3V1NVcUZaTnJaRUwzOEs1b2w0SE92eEtnb3BGa2lK?=
 =?utf-8?B?b29XTnhBdUlRQUdTdDk4eWJmKy96TzZBWFR5bUNRZmZpeERUaWlQTW1LT1V4?=
 =?utf-8?B?NGlCN0ltMStZYjFmd1VCcTRBakFWV0IxUVlKczh4NFFBakFhaExwMW5KdFlt?=
 =?utf-8?B?Wk5oaU9XdXBwc256Nkx4aDYvNzFsOFh1SmkvNXRMKytwajUxUWpLTEVQaHd6?=
 =?utf-8?B?cU5YNm5tVkJzaXJrYkM4a0tYamh2L3p0UEZiNFh6cnFxWVJpMWFERDJQVVFs?=
 =?utf-8?B?cFE0N2lYdFJoNzYrWi9RMTZFaGxXT3QwNmMzeTFhMklEVmtLUUZWWVZRZFls?=
 =?utf-8?B?ZzV2WlF5VVFZa1YvQ0k0VGVMaTRDQUNram1xWE1sNXRaVW1CdkpMeVdWUGI0?=
 =?utf-8?B?b3ZmOUNadkczMUpWd0laZjNzeEVsbWQxK1orRTJpTWQ1UHMxcktkSXJJS0NV?=
 =?utf-8?B?bDArU1V5dmZ3U3g1TkQ0RGh2SE11Z1ZQYzdUaTJuOXZYWDlpR2lVVnQwTWVw?=
 =?utf-8?B?dms1S1ZPZDI1bWNBRjZXQis1RUZiM1FDSVJ0ckdsLzg4dVNrQVN2M2JmQ2Fk?=
 =?utf-8?Q?IHfnYAkhyL07OcB4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a17650f9-6498-4d7f-45ce-08de5eb945b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 22:04:56.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYLbLMYvUp5pdEvbeljLMvryd8z3+wgNamBu4F7l2Xrq283Eh2KjRwqwNH8nDIwPE9LWuxjcazkNDs/4Pm1wZxKtLvBIyMIkd9bHIlk0ZEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254482-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E33EEA960A
X-Rspamd-Action: no action



On 1/28/2026 1:02 PM, Mauro Carvalho Chehab wrote:
> Anyway, I'll handle it either way at the next version.
> 

I also saw you had replied already.. but I hadn't gotten that far in the 
thread yet when reviewing :) Thanks!

> Thanks,
> Mauro


