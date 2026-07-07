Return-Path: <netdev+bounces-305292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ggaIDYadTGp0nAEAu9opvQ
	(envelope-from <netdev+bounces-305292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B23717FF2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MxOTZmCo;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305292-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305292-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B7AA3001859
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65B3A6EEC;
	Tue,  7 Jul 2026 06:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606523183F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:32:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405951; cv=fail; b=nnEfxLJK/c1FOC4DZwshgYQU9k07GBOdiQuNDeS5RmPo8t6VahnlpepuZ7ZbkL3ucmxRpX5Pz1wxJiWblpciokmAd8dSuK/ISTt2hLrOvJnYr8XKs/1pe9TXx2tP3efDVqERhBV32z1PMhKRfKXzX6Nm/IZ8z6PNfR9GpCsaV9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405951; c=relaxed/simple;
	bh=YciNUKcYYle9WBH93Nuiy671a7wS0+3GYDwKEQw5uhw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BsLc8X5qlhE5leTEZfvJFBwOYwLQ95CgMGCj614xEO4GOM0mdZDp60VIOFt7Bprc7R7zvvvo3prjUvE0tn12cuF7xgzvoogZa6BMpcdIT9O6rAXLLGrZ/a/Qj5LHvF8tqpNlrVKPzm5gXXUmiZShR54ZOd7r3rdTVtiNRzbIxZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxOTZmCo; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783405949; x=1814941949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YciNUKcYYle9WBH93Nuiy671a7wS0+3GYDwKEQw5uhw=;
  b=MxOTZmCoWKaxIUhwEDh6kaSPk/TW5LlXzSV4GlmkcBV1kCo5JjJEaEMG
   TaukrLF8MrsHB4ZOJgjrT8KMkI0RoibPAPX/TVHijgCGmDcRbO3m7iAyz
   abqxJH9vhEY6T2AOc73MgUdMZ10wpaA93O1OnfWNu3wA1MNKbITQ4Ox08
   Yl42iHNzq1506G1/W5MYQReBo+yf7F2JQPoZ7TpSXViVO4NemYhXUoSDO
   rs9v2cS6GS5b71Dn0q2weMGDNrQUp6lRr1YJTz85vMob0tnxrxcRdD4Xm
   DJ2Gd9+QcLnvfpBKtHFt+WCGYZ1OktJZaChJ2OmvYB144/mT34BZCXOax
   A==;
X-CSE-ConnectionGUID: LZEafVgxTBKwmBGhWie+iA==
X-CSE-MsgGUID: +RZZXfiMSY2O/vLXa7Kw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101470042"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101470042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:32:28 -0700
X-CSE-ConnectionGUID: lq6ET3t0SZewqF6dQLpc0g==
X-CSE-MsgGUID: m5N7tmPLSOCFtqTZwQlFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257782456"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:32:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:32:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 23:32:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE5Dqirvc7xRVtckEwauyrv43sEPpWBV3rS2tzXcVbZo8UwyTJCVVNNVBluTEWlXy16gBvp5ZQ5yCVtDHPURDCbL5K/3cSGBfVMPHg/Sr99Liw08CzCpWRHQRUrXQUAp+7OHqc2V451ramYrFhj9q5m0x+y9wS0SJ6tWvddzbmQ3BNFTtOMqUEc7w3D8wo2oKYdJoxTKqi5gkRkwPxIV1sXfRDsPU0BGSnMNhX4lilJOJJbFTFQB7ox9fddMCd18fOEvWL4o1HnW2VXMBbw17HURKuIwiJdDcNGEwO283jv7i3h4n5JsQCiqnU4L0NWsufp3967bBSnw8mLNfPGEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC3joOSm+wr9Q2dFhNZgmlIRSAGuGoOLFfMSnzCnG4E=;
 b=oXpGdHYhyHHm69zj/zmBwF6WyeoeeXVw/EdQwgRnDTZ/gaU3jWRhPIOIq8Qso2+Z8B4hbuTqX0lEf3w/cM9CLI4/dS9npRpyDgEeeeha+xf++fIypdiiJbeRClj5Nz7sHIRRIJOwaF3y/I1C/rMZU1RknQQpuRCuo15Bz+qjecXY3mY1omCLZESNt318TpxgFr+zkGzM8Bu27YwvqaoS60jhmFX6MPlZcRbvIBWPcxcBbv9O3q5+x/hMmSXhgPHiYhAkdl/MGrOydWA8Qb5GYTdAQ2UornABzLR3nH26RmrThxNR+HfQG7ebAK2jMHQCiTFapNYc4MtA5QI9+V/OAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:32:24 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:32:24 +0000
Message-ID: <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com>
Date: Tue, 7 Jul 2026 12:02:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
To: <intel-xe@lists.freedesktop.org>, <aravind.iddamsetty@linux.intel.com>,
	<kuba@kernel.org>, <rodrigo.vivi@intel.com>
CC: <anshuman.gupta@intel.com>, <joonas.lahtinen@linux.intel.com>,
	<simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<raag.jadav@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mallesh.koujalagi@intel.com>, <soham.purkait@intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260701094409.129131-6-riana.tauro@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SJ2PR11MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: b74ed545-736a-417b-ae1b-08dedbf18192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|3023799007|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TBFe7JGOBPtxyqC1ALqFXjR+rQuyesILMw8z4vnR9kck7j3tBN6ztT/liJws1ty+rdb7Utc2LMcCvPLIo70KwHuDIZqi3fU797Sr2zl+F6nTvg13cVKt+KyTJ2/cN84snsIYT6mSD3KoVUVi4Fi2vTjXYCojgKGZGB3kCFIG5TMxTcVo/jw65O7gxpNz0FPQHjkBBnRVvgi0RLGMg7sjuNgW3WrHn/BUqfbrFutEiZpOBYoHp+ljKhbaDg4CVHx5FrGJMI73LECv9HtjzlxNzdw3k1OZ4ozSY0bzb62I1jTC8rGDLtgkD2GGyEHw3/KhQHrliGzdEExLpC+RHcXxJ1E2ncjUSRvI8h1/EkK/NPlCLKVbZtVC//99pZ3iwvvY6fLt7inJ9z6NvXFeaUTmBn+ZRqFyJV/NU4JyFyk/M89x9vo514iM7GcG06ukK3a1Pz1NKZHDPRT7/Ki3A4e4I4svkKv6ZdUFVr6qfgc0NqOCKFSAiQX/2Q62/likW4aUm2tpMFC2G4arZSmqu/mXnaPOl1NrDw3O7fSPmA432fmjCwY+cx2mEURyUwt8wMhPr0hEIcSF083l94VVSBqMGQ5Jg0rrcFMSnq9gjPoP8LF8x9unKTk0Uep1pyoDHPS7zZ/taDnKr0EYpnrIruKCdwcvfSH+TGTEM06iboSj6mM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajA2cklaWVZ6WXNaNWtiVFNnQlRtYzdsejdsRC8yNzJvdnFsWC90YXJ5VU9C?=
 =?utf-8?B?cXVsSXVkZFNaY1JGdGR5Rm0yVVZvcUVSUFhkQnFFUDUwaWRqVkZCRTdnd2VR?=
 =?utf-8?B?L3Btb3VHdXhkRjkvR1QvcE0wTWNMYTJCYlBMM3J2NnlncHZCdmRMektRRnNX?=
 =?utf-8?B?ZzdlVzdmUkw2SmpkRU1jRnFLbE5ldXZHbkw4Z3RVNDZrVlNKdFNNTmV6dGIr?=
 =?utf-8?B?TEhSWGJ2aTcyU05Nd2RvMXljQXhKZjdzcm82NFZvL21GdXVLTmRwTlhMQmxP?=
 =?utf-8?B?NUUyazlZTmdUWUxhcXNhcDZTK0dBWnlYd0wwUXlDR3JlNmI2bm9ETS9mZjdH?=
 =?utf-8?B?RFY4MGpvSEpHY2EvajZhVE5UU2pLUC9rdlFMenNwNzRkelNzc0xnRUF0MmU1?=
 =?utf-8?B?K0JMSm1zRllKNnRRSUczT2J3eUJxSW96cWZpZ01tTlB1bEFpNExXdUptRjdi?=
 =?utf-8?B?TG9OalNFMXlZaEJZckpCUjZMVXV5Q1dBV0RraHQ2a3Y1ZnBvV2NidXZQK1ZI?=
 =?utf-8?B?b0F1aWtDNFpiYzFCNTdLWnVtbFRqaFpLcXpFYVQ0dVR4eXNqMWRrR1pkajFB?=
 =?utf-8?B?a2JCU0dmemo4ak1mTDd6NWhHVXozVEMyNzF6c0tSRGpRSTBvY2ZEWi9LMTJ2?=
 =?utf-8?B?M3dIUXF5RUZvZEZhVjJucGlET1RhdndNMlgzeWVvT1huRG9PVE5oUm9MT1Jz?=
 =?utf-8?B?WlQ1aUJ2NkhKckZuL252UUVDMFlTblcvby84em5Fa0NUajY0dUxSVXBEdUhi?=
 =?utf-8?B?QVhzenVjMHdMSnhhRFFlUkxTWnZkWmxHa1RSVVNPN1l1V01IT2FYcXNGb0lt?=
 =?utf-8?B?Qm4ySnpUelZTVTJIdE9zUkk2eUNmWmJjQ1dHWjdpVHpTck1iNkZETFZOaEtp?=
 =?utf-8?B?QmdmRm9IY0NhM1R0YmpZUiszVlZHK0NiTEpXeGZKdGR1K0MydFVFQ2gvV2pq?=
 =?utf-8?B?RUY0OWtHQk1lK3JJbkJsTjNyVzgzUEI3bnZEdmE1QUhoQ0RzYTNmMGFFYWRP?=
 =?utf-8?B?NHI2MnZENzBGdlhJWk9GMUdDTUdPQUxRNnRoYmVGUy9SbEFHb3pUbjdzd0M4?=
 =?utf-8?B?TmtUa2o3a0JaK1JGTTZFMzJrcTNIMWNDa09PdExMZEdOdGlMR3R2N0Z6aG95?=
 =?utf-8?B?S3A4Q05heENiMEdwYWRmSTgrQ2JQVm9aVWVzRC9XYVpabTNibVFYU0t6YUlG?=
 =?utf-8?B?MEZuMUlJbkY4R1hrUXhoWkZCS0JmQjZBVHpyTnZHQ050aHpJSGkvdUVRbmlJ?=
 =?utf-8?B?d0VtOSt6eW9lckd0VDM0d3hHVSttZmltNWhrR21DT0Fhd3RGMGZjNVkwdFYy?=
 =?utf-8?B?Z2p2VXg0bDQwUmFsSk5tS0pvVUdMYldOa003YmF4SmwwVlQybW1Fa2dYRG9q?=
 =?utf-8?B?Y25vZnI2NWNIWnVKanZWR0w3TGVpUlJhLzY3Rkdob1dKVlRBekF4RGx5bVEz?=
 =?utf-8?B?MTR4bUFUZTlySnFTa2xDK0xOeFdKQkRTSEdGV1VocmFDYk40aXRkQzZpV3d6?=
 =?utf-8?B?ZWpBV1RHdytHaitKQWJPdWcwakFzdFFsNXhsekR4MlNVc2xGeFF3L0dCTjEx?=
 =?utf-8?B?OVBZSlBmNS9USWNhZ3lGK2NoK2RXaFVNRkU0MUQvRTc0WllDT2tjUittekFh?=
 =?utf-8?B?Z290M1BrbkdBU1FldGFjMUFuVmZjSXlDdlNzbk1vN1R1RDlSUkpnU2c2RlQx?=
 =?utf-8?B?aFZ6NU9hM2FKTWFSeGhpZEcvNkM2U2VWSnd6SlRHclRCckw5RFk2OEx1VzNR?=
 =?utf-8?B?a2dQekphTE9HRjJGb0tmOXZNVWhha0RsQWRJaC9IbGhKc2lLZVZLdVFoZ1hy?=
 =?utf-8?B?eG9Gb3A0RmY2OGFhVWlob0w1U3huYlRJa2JBdU1zY1Z5QjNmNUI0bkJ2QXlB?=
 =?utf-8?B?VWZvd1M0cnFFQ2REa2t4Q3JHVCtUdG9kelFGV0hHV1MvZ0dGcVg3SkVCc0lN?=
 =?utf-8?B?bk1VenMxS1lIQ3docEN0L21Qc2FqTFhaVThOY3V2REdzSU8xVVBpRE9OMUZN?=
 =?utf-8?B?QTBGbUFhRFZuMGZ6Zkp4WCsrM2FQSkY3R2xwbzE3ZU8xTmd3UFBOWjh1bVhY?=
 =?utf-8?B?ZE80eG9aTEZCYVllWGVpK0lrUWVNak5rS0VhUXY3K1Jlall4c3VKUThvZUxr?=
 =?utf-8?B?bU9neUJhUHJxaDFIcEpITjg5L2JUbEFvU1FKYjc2ZURJcjNEUWN1TjUwS2dm?=
 =?utf-8?B?SEU1c0FrK1JKQlNYM21IaURiSWtOQXZSandVMFJ5bS8wbG9aOVBsVlhoTmo0?=
 =?utf-8?B?cW1uT1BCQ0Vob3F4RzZ0V1pvbmNDdWJsTmhKRVhZUVNuK0tLNHAvU2Y0RVhG?=
 =?utf-8?B?cDNwZDNUZVVpbW00bTVhV1ZQUzZQZ3F6Ym1vOElMRFpXaE5BKzZIdz09?=
X-Exchange-RoutingPolicyChecked: cmYwLVWSw8z3iRvBFz/hpZUI9PwxcfHU0TnMtkR0dzGyy/9TQcXEut3yk5BihF7LJDh23EWvOsPg0GmcYmf+IpVXwGydP00gKosHWyNpOot2pG8ox1LiE5roT60X2UhD1SbzsxJXuI1Kv/5EtRHNnQAe6oHnmeLX6+2rPXbuRgd5UmzQDsKNys95Nk9hQDvs5ZMcfuifpsQYMGJD1ObWE7w2aYsNMAC2VTWIAWdHl+Dkmx3xEmaKWDGFwWXErXnmHIMJtaQvvh0U0yqRmMaBvdObvFEQ05ZG5Cl2IZrv20ux64crw4TNruZXjDmlkmNOFOWdi0cK7CQ1ShWdyHNGPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b74ed545-736a-417b-ae1b-08dedbf18192
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:32:24.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGRqfTJgQdlp+cZaJq98vaFr2i7jzdm9uRTs568NsrIkgjwdBQimlKt5z1YlYBzEcxAJOU/w9m4cKzeyrZqeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305292-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:aravind.iddamsetty@linux.intel.com,m:kuba@kernel.org,m:rodrigo.vivi@intel.com,m:anshuman.gupta@intel.com,m:joonas.lahtinen@linux.intel.com,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1B23717FF2

Hi Rodrigo/Jakub/Aravind

Please let me know if you have any feedback for this patch or can you please
ack this if it looks good to you.

Thanks
Riana

On 01-07-2026 15:14, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-report' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
>
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-report' to receive 'error-event'
> notifications.
>
> Usage:
>
> $ sudo ynl --family drm_ras --subscribe error-report
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: remove redundant initialization
>      remove unnecessary space
>      use ynl in commit message and doc (Raag)
>      simplify doc for error-event attrs
>
> v3: rename error-notify to error-report
>      Replace notify with report across the file (Raag)
> ---
>   Documentation/gpu/drm-ras.rst            | 21 ++++++
>   Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
>   drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |  6 ++
>   drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>   include/drm/drm_ras.h                    |  5 ++
>   include/uapi/drm/drm_ras.h               | 15 ++++
>   7 files changed, 186 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 83c21853b74b..406e4c49bac1 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,7 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
>   
>   YAML-based Interface
>   --------------------
> @@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
>   
>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>       None
> +
> +Example: Subscribe to ``error-report`` multicast group
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --output-json --subscribe error-report
> +
> +.. code-block:: json
> +
> +    {
> +        "name": "error-event",
> +        "msg": {
> +            "device-name": "0000:03:00.0",
> +            "node-id": 1,
> +            "node-name": "uncorrectable-errors",
> +            "error-id": 1,
> +            "error-name": "error_name1",
> +            "error-value": 1
> +        }
> +    }
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..8aed3d4515e5 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,33 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +  -
> +    name: error-event-attrs
> +    attributes:
> +      -
> +        name: device-name
> +        type: string
> +        doc: Device (PCI BDF, UUID) that reported the error.
> +      -
> +        name: node-id
> +        type: u32
> +        doc: ID of the node that reported the error.
> +      -
> +        name: node-name
> +        type: string
> +        doc: Name of the node that reported the error.
> +      -
> +        name: error-id
> +        type: u32
> +        doc: ID of the error counter.
> +      -
> +        name: error-name
> +        type: string
> +        doc: Name of the error.
> +      -
> +        name: error-value
> +        type: u32
> +        doc: Current value of the error counter.
>   
>   operations:
>     list:
> @@ -124,3 +151,24 @@ operations:
>         do:
>           request:
>             attributes: *id-attrs
> +    -
> +      name: error-event
> +      doc: >-
> +           Report an error event to userspace.
> +           The event includes the device, node and error information
> +           of the error that triggered the event.
> +      attribute-set: error-event-attrs
> +      mcgrp: error-report
> +      event:
> +        attributes:
> +          - device-name
> +          - node-id
> +          - node-name
> +          - error-id
> +          - error-name
> +          - error-value
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: error-report
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..77f912a4d101 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,11 @@
>    *    Userspace must provide Node ID, Error ID.
>    *    Clears specific error counter of a node if supported.
>    *
> + * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
> + *
> + * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
> + *    and error information that triggered the event.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
> +				     u32 error_id, const char *error_name, u32 value)
> +{
> +	int ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
> +}
> +
>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>   			    u32 error_id)
>   {
> @@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   	return genlmsg_reply(msg, info);
>   }
>   
> +/**
> + * drm_ras_nl_error_event() - Report an error event
> + * @node: Node structure
> + * @error_id: ID of the error
> + * @error_name: Name of the error
> + * @value: Value associated with the error
> + * @flags: GFP flags for memory allocation
> + *
> + * Report an error-event to userspace using the error-report multicast group.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value, gfp_t flags)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int ret;
> +
> +	if (!error_name)
> +		return -EINVAL;
> +
> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_REPORT))
> +		return 0;
> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, &info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT, flags);
> +	return 0;
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_ras_nl_error_event);
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..9d3123cc9f9c 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	},
>   };
>   
> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> +	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
> +};
> +
>   struct genl_family drm_ras_nl_family __ro_after_init = {
>   	.name		= DRM_RAS_FAMILY_NAME,
>   	.version	= DRM_RAS_FAMILY_VERSION,
> @@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
>   	.module		= THIS_MODULE,
>   	.split_ops	= drm_ras_nl_ops,
>   	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
> +	.mcgrps		= drm_ras_nl_mcgrps,
> +	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
>   };
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..03ec275aca92 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
>   
> +enum {
> +	DRM_RAS_NLGRP_ERROR_REPORT,
> +};
> +
>   extern struct genl_family drm_ras_nl_family;
>   
>   #endif /* _LINUX_DRM_RAS_GEN_H */
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 0beede3ddc4e..8abfb7d2077b 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -80,9 +80,14 @@ struct drm_device;
>   #if IS_ENABLED(CONFIG_DRM_RAS)
>   int drm_ras_node_register(struct drm_ras_node *node);
>   void drm_ras_node_unregister(struct drm_ras_node *node);
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
> +			   u32 value, gfp_t flags);
>   #else
>   static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
>   static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
> +static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
> +					 const char *error_name, u32 value, gfp_t flags)
> +{ return 0; }
>   #endif
>   
>   #endif
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..eab8231aa87c 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -38,13 +38,28 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>   };
>   
> +enum {
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
> +
> +	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
> +	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
> +};
> +
>   enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_ERROR_EVENT,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>   };
>   
> +#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
> +
>   #endif /* _UAPI_LINUX_DRM_RAS_H */

