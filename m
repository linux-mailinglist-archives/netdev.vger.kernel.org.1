Return-Path: <netdev+bounces-119649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D39567B7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02282833E9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BE20DC5;
	Mon, 19 Aug 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU/3ITCS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3433C0
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061623; cv=fail; b=GjdHB+FA2Inuim0AvQtHu2/L1MGE4avyqaFeMCqr1yCwPFZwn/sT/+goDxbG6UhlJ+vL0Q5OfXQIWzNWq/daboMIERCmCbPJrKDFpn+d+4QLqnCbSfHkYE74k9JCAqvCFu1lpUgIHA/KiW64DNhV2o4daiuE/pRL3NSkXPhhbBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061623; c=relaxed/simple;
	bh=yVKBrmnOi9lkajlfusHlE5Yd7R29gGM+fgPUcEI4AY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1PDY3q1LZ+2vPWiGnumzZFWbG/NKpaBdC3oJpjswBYlzwFQJUUb1utMu0io0i7ZX2FcJsIsqTppA74RkUGmjxHpDRwzfeR0f/VNyCqvooozZTPVOstWvneuYhE3hDd167zl+U7Csd6PYlsPPTYqruWgPV5UYbP2MTPqt8GnlUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU/3ITCS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724061621; x=1755597621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVKBrmnOi9lkajlfusHlE5Yd7R29gGM+fgPUcEI4AY0=;
  b=hU/3ITCSjiSYkqNam4BMRll5nU4Q4I9C837QZ+jbNWF6Aw+MOoo0rqBa
   N5j9JWk9Ja0QR7zJuJD5UjKgTNqOX6d8jtmQdOq5bXdg52JaOE2h2wMsy
   xN8FK3eyGi3U2ZN0RdBPrWdFDkpFFFL9TKNj/XteFB+TNioZJe5voW1TN
   a4E+0HPYBXXn9CBGz6f0NNPF59i3B5YB3SmPSa01M5GAHJ5bl8eqS7QKU
   eGBxsvLFld17yudCfKONywXVIT2RNS60h0+dZPUWW4LnnVzXNPsnMPFQn
   A3L/a3MsutXPkrSLejm5t5isDuXjJqFS3gY3BW/ic+0isHW+blc1wRiGn
   Q==;
X-CSE-ConnectionGUID: fwWXdQByRWKZ3jzCyddqfA==
X-CSE-MsgGUID: Jb9I2OFCQu+kXbW2cDZB0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47699137"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="47699137"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:00:20 -0700
X-CSE-ConnectionGUID: zAuNawIAQRyKUZWgzXldpg==
X-CSE-MsgGUID: QQq0MyzuTv2lYQV8mGMSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91094738"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 03:00:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:00:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:00:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 03:00:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 03:00:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmX+kVi571d1O2UM37zOqqfRr92pknRqS8HTdeSyG5ttGkH9oE2jt8rILpyWsBodAHRTACsxzGNwKYEBCN4QPjViYggNHmmAdLkp4gtf/DlOPdlm4RYfCCGJdiIdM+vGyiYw4qtY5TNMzy1kIuX3Ml3GP60HLmDSukrWPkXEivmZ3sAaKo4+7oo4arlxcqRSoU9fbFeVRJBGGGTm8fxE1D+nCEkOYVug93cnzT3anqqKIkakr3+UkWJ2v1hzs6HwGc38Yk2Cf2lAzimjG690tqW4tEhwUseaQJ34DedolkOVuB1LGyOGbJGpmpdbZnVow+pcOFejbnIvkgOVlB79Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8wDBB2VoiJ/dNgf0TOjmGa3K2gYCEr+01uXBM6lXqQ=;
 b=SVWsquFnGsu+aLedaymkfDA8d8rP/OA5Lh22CztxtZ4GQ9JpRB/pDD91F94CJ1zy+nK5BOV41wpfnzajY+CNhZwL/t0W9mLl6KfzBM9zQXJOMiq7FujadsyOCQUAQwuZ9C0kr0cETBvQXtVSSQ2WOBYiYqgNks1u1bIVga2ONL7ia6p78M0X2pTRFOx/Gq6OUvtzBXAMKMOCQdyF8Xrmej4qtVL+YVfXm6iv6kHk0hZwEjuVFH2hh+FnRi5lUq1EltS5Nv7BfcjPBb/snAylwKvBCbMQqw21uopolYZ8D7SqUG1etHz8CBSf8kGfPA4B1rrrNEDXE+uNUQbu25E7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:00:12 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:00:12 +0000
Message-ID: <c3946cf2-c89b-46ad-85d2-1df5d8c4db4c@intel.com>
Date: Mon, 19 Aug 2024 12:00:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] bnxt_en: add support for storing crash
 dump into host memory
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
	Vikas Gupta <vikas.gupta@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-2-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240816212832.185379-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee5e169-bfd5-43ef-89ce-08dcc035b739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2w5YzhpYk95SDg3RmxYTHEwMTBoQUVvMXFDWGpuSlJUWERYREllT09xVyt6?=
 =?utf-8?B?Ly80OURsNFEzSkd3R2wwaGxBb0xQVURnMlpCc2QxeDNFK1NzKzM5ZzFDSGJF?=
 =?utf-8?B?SWFTbzJERlVvWStpSFZiZDRYMUlpZUFiTmtTaFVwUHlVaFpBODk5b1J5M1ZV?=
 =?utf-8?B?YzlTQ3drYzB4Z2wvOHM2clRXKzZHOFQ1NENMRmpBR3dnRVdjbFFzamloN3Vr?=
 =?utf-8?B?RVRiYk5uMHNMaVN5dzNoYU8yT0VlYldkZ2FwY0oyUUl3N0U1Z2FDN3gxK0h6?=
 =?utf-8?B?ZG5BVW5sYVZwa0NKbkZHajRWNE8rdndCSzJLYXdqYXJpS1JyTVgwY09ac3Ey?=
 =?utf-8?B?b0xwc1ZNTlUwS2RCU1Q1a2RjQVdwbVVXcEdaNTRkcysrcVFTVzlBQTA2cENH?=
 =?utf-8?B?VlAvV3Vab0Nqa2daUkwyVlp5Nm1ha0R1OGFETWFZSGtRN21hb0VSeTEwTzlT?=
 =?utf-8?B?dXlMcFRDeS81WmhBckhweXd0a0c5WmlUMS9lQU9wckk1ZER4TFRSZkhFejNF?=
 =?utf-8?B?ZngrM0l1SGNBdlJFTDJUOTNXRzg5UlNSWDZIR1Azb1NQTnFWSGFmZjdOVVRs?=
 =?utf-8?B?Ry9BOUwvYUtkQmNXOWFvY2N4OGtMdzhLMEVDSE1DdWJ0K1c1MjZkM0FqL0dt?=
 =?utf-8?B?VWpHTllJV25vbFYzRDlVcWhJZ3lkdmtRa1I2blBubk9Xa09MbjZjUWlMZm5h?=
 =?utf-8?B?OHp6T092S3RLM1pPb1ZwUW41YzcvYWpZRW96UWtTVnh5cXhzV1ZheitRblZ0?=
 =?utf-8?B?Wkw0cC90bmQ0aEViOUVIK3RmT0pvTFpqRTh6S29ESFZSMkNJbTlPQkg2Z1Rv?=
 =?utf-8?B?bTB6T0FsbXlFcjlnWTh4MTkwVm5TSDhMSlA3a0pGeUt2TW1IVks2WXNMYXc2?=
 =?utf-8?B?eE4rYVFTb0FTNmhSbWdYNXMwOVlSUTBSV0RhMWVpUnZWU3NnOVhiRFdNU24w?=
 =?utf-8?B?VVo3eC9JdTlnbkkxQ1cycEVVbUloZWwzNWNFS3BSMVZTdWw4b0FvUkE1TVQ5?=
 =?utf-8?B?bjB2MXQwbWJyZXRjYmlkMk1IOTl1SnVYYmp2dzRWZVdycHNtYWt6MFMwWUZm?=
 =?utf-8?B?YytqRVIrWnBDNkpROWhWZDVPUmFYMlBOeVMwWFlyS3EwVVNYLzNwanZ1M1I4?=
 =?utf-8?B?RmpuQlRPT3p4NVFjQ2tubnh0Z3ptMUVkczJKdXlwZXprUVBWVG90aG1DbU5I?=
 =?utf-8?B?UVlXaXV2Yk1QRVVwSnMyazhIaHBQRGh6d0VOU1kvYThsNXVKMVJDYXBJMkpD?=
 =?utf-8?B?WkxxdTNLSUFyYWJZWXZmeExpMHN1cDg0cmlxVnAxNXdyT1hBV0RHeEROZlJk?=
 =?utf-8?B?N01oZVcwVEIxWGZvU21DY3hnd3NJTnNzK1piVHNrYjZyTG9KSmw0SG5BT2dW?=
 =?utf-8?B?Tk10YWE5WWVkMk5ERHZHSEN2eTAvQ2RVT2dxcEc1OUd4ZjU3eDMzVVFObXBI?=
 =?utf-8?B?RHpZZE8yMkxaak9McDhlY1RuVXhTRzlDWElPWHBiYWxSMEFqbWdQOXBncHQ1?=
 =?utf-8?B?Y3RCTStkclZwZ0xmMXVnVlV5NTJBM0dib3Y1RXFZMjYyckFNQzUxN0hZMHZC?=
 =?utf-8?B?UVlZYWExM2hxLzZHMHpoa2F5UmNtS2JwblFlVTd0UjAwcVRvNDR1M1pXdHd5?=
 =?utf-8?B?clVKcHl2ODkxcVZhaWdIRzNQdldPU1FvZnJtRkVlMVZkQ1l5UXpOWTFFTTdI?=
 =?utf-8?B?dHlRRktsR1gydDBxb3B5K2JkNkdrb0JUajRRQnkxMzZ6bGhSemdscXkxTFV5?=
 =?utf-8?B?TDZrTmxtM3Z0bVlibGRiREdwTFNob0xNbmVWQ05kRHk4ZHVqbi9KTEZueFND?=
 =?utf-8?B?OTUvQ214eGhhTi9kektsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXFxVjc4UDR2VWhqTnZtYzBoWjNVNExtR2ljaXVrMXd2cXdjcndMT2tQTG1a?=
 =?utf-8?B?Y3pNbk5aSzRnZnRHNFJMMEpTVExmaDZLR0htM1A1ZFVWbExvc1IwODRvUzhJ?=
 =?utf-8?B?U2hReGhvZVNSQzRDRzVzRHprV0V5UmFuUGRZK3N3Z1ZCSkN1QTlLdGhITmU5?=
 =?utf-8?B?VGhiVUIwL1ZsS295RUtWYVRlVDFkMm0vSktBRnJ0ME5YRVl4T3ZMQmdpTTl2?=
 =?utf-8?B?WDlVNlY3Y2ZQRVlncjJLNHNjOEw0ZGdvMHNmdzZUbEFWc2F6UkVUcEEyaFly?=
 =?utf-8?B?YzZDUlhwTWQ4K2k0VHMxTDNCTEl4OE1HZWpwY2NYOUxpOGUxRWNwb0djZmwv?=
 =?utf-8?B?eFFCU2R2cWM1am0vcE92OUY4OUVadFh3Wm1BcDExLzcvemJSVndMV2NaRXFt?=
 =?utf-8?B?R2xRbnVwbmEwWkN3a0NhM2owYS9keTJnMFRyTTFOZW1GSXpKVWw1WVl2Z3p5?=
 =?utf-8?B?MEEzZmtvRThYYnZFdkRBUWI1M1c5eXZFM2Z6ZW8xaWdValJ3YkZGWUJ6d3ZJ?=
 =?utf-8?B?TGxhUktVRktMYUdDdFFBTWcveTBJRHBkYVA0ZENWZ2UwODJSYUtvc2Q0UVpF?=
 =?utf-8?B?STVTbEZXTHRsaGllWkIyS3BObDlmeCtrOEE2OVV5NTM1MktOcFlNRTlYeVBF?=
 =?utf-8?B?Mk01VjZzUjFlSDdScSs2c2E1RmtQZXFqbk4vQkcwZXQwcjdjaTEwL3Y0NU1r?=
 =?utf-8?B?dTU2OTNEUlhiNzNnTWFkWXk3cHEvbGRkbzdhQmRoc01PWWJBZHlXMEI1RFdi?=
 =?utf-8?B?cjUraXFIWHN3RU0vUklscTB2SFc0aFdCY2daTTJYWHFuSFNlQUdGTzBYSDdz?=
 =?utf-8?B?S0ZOVTR6cTIrRVJvVXpnVExTMFh4NE9XTnFXbHZoTFF6QXFSek95dFY1TUxI?=
 =?utf-8?B?dm5Cd2hrYjNZbmE1VUZpVis2ckpheWgveENkQlpUd2JjM0NydERoYUVTVWRw?=
 =?utf-8?B?bGRMKzJhNm9XME5rckxMZXRHMGdPenRLN3F2aitGODRIQUF6V0xLUytldmtx?=
 =?utf-8?B?VHovUWVSY2pSZHozSzdvVnlYc3F5LzBCT00vbWZWa3FYZFl0NmpUSkd3ZTFF?=
 =?utf-8?B?ZWl4cCthYmc2Qk14UWl4VktOZmhKc256ZUtMc1ptVUk0Q2xHcTVUTWxra1Zs?=
 =?utf-8?B?RStKa0E4ekgyTVdsS1h0NTlRM0RISHgxK0xZN3NSK0NsdFFYdUVZTkpqRjF2?=
 =?utf-8?B?QXU3UTdDYi9JUTArcEVReC9VSFhnVGFRSTU0TUR6dnMvUVJ4b2NoelRLd0Uw?=
 =?utf-8?B?K2tTYm85UmhnR0l6RHloRmpldk5FbXNrZWFVeG5Na3dtYjFjb0tpZWdlWkpr?=
 =?utf-8?B?UytNUTJUaXZaVklyKzdEZ2ZsTFM5UzVjWVJONzlhRWJUT0NuMnRaREEzMXpK?=
 =?utf-8?B?WUV3Rmd3THNuaXNQNjN4bmdNSDNKUkw3KzBTU3FZeHBhbUF5WjBsZkY3eVhQ?=
 =?utf-8?B?azdFUzlRTS9qbFQ5ajBZVGd0SlQvVG5zVWJKN0ZGSzZ0cjlqaEQ4MUNrWkx1?=
 =?utf-8?B?a1hCR0diZVRlM0lBSU1rRFlMczhMSjN4ZmZ3TlJGLzF3Q0tQUDhsL2FvOU03?=
 =?utf-8?B?N291eVlRT0tldEpRTUk4RUtMNitOME9CNHplb1VuWHgzYm9lRmY0RlY1VlNR?=
 =?utf-8?B?Q2QvQ2lUOWdqRmh3SVJpSWpZMXBoS0VPNmZTaG9ZMHFyd2E5RFJPbHZQeDlo?=
 =?utf-8?B?R1pOTWdYYXJiNDRkK1p4RitxV1VSWE8zNTVDWWFza1BnWTJBdU1xK3pLOTZ4?=
 =?utf-8?B?TGZ3bTAxbWNVZkRjZ1FuVGRlcVE2MkNGakZ5RC9zT2p3bUV2MGNzdldJS3dC?=
 =?utf-8?B?bjFab2UzUlRsUHZ4NnYraEV3TWpzQ0FOZ1IrNDk3blFuUjdDc3RBdW5nMGdV?=
 =?utf-8?B?SVluOVAzbTFXTXRZaGVHbitXVXV2dFQ3VEFWWEZCRjhodmhnUk1YRVFBdG5S?=
 =?utf-8?B?NzZld1FkQUVyUDd5eTZWVkJvMTlqczFyK2tMMVAyWHR5ZmRKMU41UjdTOC9C?=
 =?utf-8?B?SFpzQy9kaWFPeW5CM2R6Zko2LzBTaHg1cjlESm03NEZPZTBONGhUQmVES2c0?=
 =?utf-8?B?bHpZYnpSbjNuYlIyUllmcHlqRjE4RWdraG9Dd3ZaU3NyQ09uUElsY081ZzBn?=
 =?utf-8?B?SnYxd1AwOVlORXZUbTRBL0szbnJTM09XazBQa1pqeFJidW9HeUFYUWtpdUtl?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee5e169-bfd5-43ef-89ce-08dcc035b739
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:00:12.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKF6EIRvG4BCKyESQYKvkojxwgAAf7rrgI3C6Vah9VJtSqfI1DyFVD8KJEsseiOF9VNrJx6BRBrOGMXwgG9d6U5S+Koe648ReZuG2NM4XiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com

On 8/16/24 23:28, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> Newer firmware supports automatic DMA of crash dump to host memory
> when it crashes.  If the feature is supported, allocate the required
> memory using the existing context memory infrastructure.  Communicate
> the page table containing the DMA addresses to the firmware.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 93 +++++++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
>   .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 18 +++-
>   .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  8 ++
>   4 files changed, 117 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 75e2cfed5769..017eefd78ba4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -69,6 +69,7 @@
>   #include "bnxt_tc.h"
>   #include "bnxt_devlink.h"
>   #include "bnxt_debugfs.h"
> +#include "bnxt_coredump.h"
>   #include "bnxt_hwmon.h"
>   
>   #define BNXT_TX_TIMEOUT		(5 * HZ)
> @@ -8946,6 +8947,82 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
>   	return 0;
>   }
>   
> +#define BNXT_SET_CRASHDUMP_PAGE_ATTR(attr)				\
> +do {									\
> +	if (BNXT_PAGE_SIZE == 0x2000)					\
> +		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_8K;	\
> +	else if (BNXT_PAGE_SIZE == 0x10000)				\
> +		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_64K;	\
> +	else								\
> +		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_4K;	\
> +} while (0)
> +
> +static int bnxt_hwrm_crash_dump_mem_cfg(struct bnxt *bp)
> +{
> +	struct hwrm_dbg_crashdump_medium_cfg_input *req;
> +	u16 page_attr = 0;

redundant assignement

> +	int rc;
> +
> +	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR))
> +		return 0;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_DBG_CRASHDUMP_MEDIUM_CFG);
> +	if (rc)
> +		return rc;
> +
> +	BNXT_SET_CRASHDUMP_PAGE_ATTR(page_attr);

I would avoid introducing a macro for just one use here

> +	req->pg_size_lvl = cpu_to_le16(page_attr |
> +				       bp->fw_crash_mem->ring_mem.depth);
> +	req->pbl = cpu_to_le64(bp->fw_crash_mem->ring_mem.pg_tbl_map);
> +	req->size = cpu_to_le32(bp->fw_crash_len);
> +	req->output_dest_flags = cpu_to_le16(BNXT_DBG_CR_DUMP_MDM_CFG_DDR);
> +	return hwrm_req_send(bp, req);
> +}
> +
> +static void bnxt_free_crash_dump_mem(struct bnxt *bp)
> +{
> +	if (bp->fw_crash_mem) {
> +		bnxt_free_ctx_pg_tbls(bp, bp->fw_crash_mem);
> +		kfree(bp->fw_crash_mem);
> +		bp->fw_crash_len = 0;
> +		bp->fw_crash_mem = NULL;

it should be sufficient to have just one variable cleared for the
purpose of "no crash mem allocated yet" detection

> +	}
> +}
> +
> +static int bnxt_alloc_crash_dump_mem(struct bnxt *bp)
> +{
> +	u32 mem_size = 0;
> +	int rc;
> +
> +	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR))
> +		return 0;
> +
> +	rc = bnxt_hwrm_get_dump_len(bp, BNXT_DUMP_CRASH, &mem_size);
> +	if (rc)
> +		return rc;
> +
> +	mem_size = round_up(mem_size, 4);
> +
> +	if (bp->fw_crash_mem && mem_size == bp->fw_crash_len)
> +		return 0;
> +
> +	bnxt_free_crash_dump_mem(bp);

I would say it would be better to have the old buffer still allocated
in case of an allocation failure for the new one (like krealloc()).
Especially in case of shrink request.

> +
> +	bp->fw_crash_mem = kzalloc(sizeof(*bp->fw_crash_mem), GFP_KERNEL);

kmalloc(), assuming that you don't depend on the pages to be cleared

> +	if (!bp->fw_crash_mem)
> +		return -ENOMEM;
> +
> +	rc = bnxt_alloc_ctx_pg_tbls(bp, bp->fw_crash_mem, mem_size, 1, NULL);
> +	if (rc) {
> +		bnxt_free_crash_dump_mem(bp);
> +		return rc;
> +	}
> +
> +	bp->fw_crash_len = mem_size;
> +
> +	return 0;
> +}

