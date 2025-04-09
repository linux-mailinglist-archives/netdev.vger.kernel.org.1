Return-Path: <netdev+bounces-180590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1EA81BF8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906A83B57B4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7711D5ADC;
	Wed,  9 Apr 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbsLvmeD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23FE259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174699; cv=fail; b=NvAASMTqwAeDLo/MHQsAEgT05rHtkIcbD3fpYUADwpMokhDQ/QAKvvpxqALv3gq8tOTEg39sybymau2bGoenDzBi12TdLDpy0z1VHDBJ79O6xX74Qa+iKYdxhgZq2DMAPxpzBm2pZBhZmjgjCAb1DDt2HSdRrtJDVVhvoFlblaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174699; c=relaxed/simple;
	bh=+HMfIqtRNHk/A/Dm2S5nV9sBv5KM6SbIJkrUD9eFaIQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oPGN90XyJ4z6vcQomRFHizDsXlx4Zgk8/bUuEOReDm2Yx5P9INRAVJgubJauH5jxvOX2QV2T0WGaA8f2+lRxtwSAU2YAMZj6g5um/E2u9BJSuTfMSz9aT3/Cbm0FI1j04wNhPpX//sDWD9oU0UdmUi+3Yxqh+9T1wNQy2OFV/14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbsLvmeD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174698; x=1775710698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+HMfIqtRNHk/A/Dm2S5nV9sBv5KM6SbIJkrUD9eFaIQ=;
  b=DbsLvmeDNy9Tq1CkquM7690QP25l6d7DNYeedvlWCw71acQ+URKANvgR
   87WNDlDsK8lrsUIem4AZW1BjpbtbfMg05My0djGrd0/IJoqE8Y3Cr/ZXz
   JFic8kj2EjbjScKIZLuqTiMrBHl8gs9LdHZ6D5hza5NbyjiBy2vIiz2UX
   TizzI/4ZDnW0TV60iLJjFA5oL004P2W5q0tpOVOZ4qw/ELkWTHPFzvGkw
   xtMaSmSQ6N1erTijtyEm+gFMg3EwtoSAt0oHaCD5yGOm352/eYm+bfN9K
   5wbAIZ/ac2YLCXmK3zpE2HPWXg6xeDO+Fm06z01u/WiEN6rbmKIrGptV6
   Q==;
X-CSE-ConnectionGUID: YQL5uuA1QbyHv9dvooYZaw==
X-CSE-MsgGUID: ZfwGgkHORuCUXsf7F8d9LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44774128"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="44774128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:58:16 -0700
X-CSE-ConnectionGUID: rHJFFMfcT0KgUnp43yj7YQ==
X-CSE-MsgGUID: H+9lDbDgQGWwIECbI3Uv/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151661140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:58:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:58:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:58:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b05s9OtZY6fFYGMyG5xMjzuxDNa6tYpPCjovEsmRzbRFzdPwhjKc2IYhyijtHlK6tDq9LBqf0U4v+/KZpz3QvebwsqqaD2JpfNwaKFwz0sDgNP0/cWy4GRaAhqV/mNlt3NEcLkNV2Pv5YDKDFPZsx1ZinwPTeaQxhpffPS6+MuULFkWqrhBA9cm/JT3uBz1p6M4s09uIc4IntUnuypTmfqd/9as0EN1fwvSFg26d1wF8t0sJyhkudBBaH/VHmw+NPv6HS0d5tFD94pAcrbr009yQ13zVDx+AcCkVGtMmbnZIiqp7Dp3Q2UoymbxTaGCR6tBp7AwN/fZDeihk4UnCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REMxJrzNxAqWOJDSDE8O76LUGZ+4AZEOsKNw850O3fA=;
 b=qYDmMRZpe3efrrEO8JnLSmq63dS4DbUqoxYmfOOLaaTLUHTh3vUOVk3fHulsrEXIQg1rbAJuZtEroxUB3rTR+9iEN8LdZtvRBaptu2AkHPiMatLZO6IlXEM/2HYABjrOpJm3gysDzsua4hl6UlpBQJhQukL4g9u9kY29aLXH45X491wCPdTy/9v7a+X1n+gB1PHGeV5rbN+OGQvEktI9a30x4QbIee8vF2jf6qbDLF0VxncsMXJzxmgeyiI+096Rp0VWewwZGABAasPbWSbCbBMUsGqYkwmeZ18xAwPnr5tO39Ghhi0AN/Sx1dG6sZdYvcMs/c1Sbh7DVj1rnspyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:57:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:57:34 +0000
Message-ID: <c4e959f2-726d-4b00-a75b-c6625f5b5442@intel.com>
Date: Tue, 8 Apr 2025 21:57:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/13] tools: ynl-gen: don't consider requests
 with fixed hdr empty
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-9-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-9-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffb480c-a62b-4ef7-7c47-08dd77230a85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVlxT1lBellvMWQ4NnZoMDFnRGtUYk1uZkpvU1RjNkwwSzVhQkg3cXBFMEs1?=
 =?utf-8?B?TkRBRUw3ckxPYUZLZ3plRUxLb3dVVmZhaS9mWlpCNnlyWWVXR2cvL3dFNC9W?=
 =?utf-8?B?KzN5eFowL0tpWDhCNVhhRU9yejNyaFplQU1WUmxROFNrVm5NS2t3OXg4OVZZ?=
 =?utf-8?B?K2xYSTVyM1lqeXZ3c0NUY0M5bVlSUTdGVEorNk9CK0JJWVZ3OWZqVWxnRGtn?=
 =?utf-8?B?RUpqMFFhc3BZUVFqQk13QVkra0N1d25IaGU0YXIzSW41K01aWTlTUW9Cbml1?=
 =?utf-8?B?UHN6S3BjeXFnek5mdTFzNnpwQjFzamVkb2FMK3NCUUI5eU50UXhhTHZVeHFE?=
 =?utf-8?B?ZXpIOTZUalEyUDBrVUlGL2d0L1d2aGdiZG5JZGk4N3Vyc1l2N0JFaWdDdHdn?=
 =?utf-8?B?UUhvekprem50bXNYU0QzeXowSm1qUTdpZVhJbEtWZ1JGdWhGaEhTalgxWGgw?=
 =?utf-8?B?M0xFZVp4NHZ5eWtPdDF4bDB0enFQZ29wVlJNT2xEcGtzRHFFY294ZDdURTR3?=
 =?utf-8?B?T0JQMlg3aFFiUm5NOThpM2wybGtTNGpXK1ZJUjIrKzZ1eUFqeWJDY2ZOMnNK?=
 =?utf-8?B?a2Nsdi9HRDZOVDA3b092QkYyV3VidENFdlg2cTFyNU53V2pSaDk4RHlLTDB6?=
 =?utf-8?B?UHNuaEowMzVncFc4SFo0bkwxTk93Q2J0QTlqZ0lDRnpzRlRscmhnNzhtalV0?=
 =?utf-8?B?UDRCNjNYR3BWbi8vWGg5Z1VLTWpGMFFPRStjelJEVHBmSG0zeitZMXA0dmN3?=
 =?utf-8?B?eXNtekIvbkRld3Q2WDNUbFplMnpHS1V1Skt3eFp4eCtHYXdXRGpWMjdsY05z?=
 =?utf-8?B?aTY4UWZZdlQvV2dEWHZaWk9YOStieGtHY1Bmc2hqQS92Rnp2RjNWTUJ0Zmo2?=
 =?utf-8?B?K241WHBMQ1FoNXV2dEpXMGJDTUsvVmJoSm9RSEhwNjVCVVNyN3hReXZ1VDJ3?=
 =?utf-8?B?ZG5WaDR2THZHaW4yckNmM0Izcm1Pb3ZDcktWeWpXeTBLTG5IYytRZ0h1MjlN?=
 =?utf-8?B?QkMzdXBMTVF2Q3l2YithQ2t3MEp3eXVFNnhOM3lEQ2FFaXIycElNN2JIMlVw?=
 =?utf-8?B?aXgwR2hOTW1lUDhwQS8wcTN4cUppcnErNmczWVBONk1wMG41SFJyWEZhNlk2?=
 =?utf-8?B?ZDhpOU9ETk1HUW1PQ2J4dFBsUUhFYU03UmtFU1Q5ZktPYTRPbGRIdEJ2UmUx?=
 =?utf-8?B?UE5MMzFDYlFtb2Y2Y1NwMXYyMHlkcjFDUzlTRFpjMkV1TTM2YWN6Z05ZV3I3?=
 =?utf-8?B?dG9IQTdUeU1YeXZYaUxTb2FpRlJ1enl5eWs3VUlWemJ5WlJUVG9YWjNOZkJl?=
 =?utf-8?B?RkExdmM2SFA5dDlqcjJvOTUrM0FIb1ZmVWJkOXJ3L0M3dFRIZWtKZDBxQUpa?=
 =?utf-8?B?U2Q0Rmk2NkdUeEdLNnp5ekFJOWQzWGM5alBIY1R1Qmg5L0RhWUNIN0xORGFK?=
 =?utf-8?B?L1VYT0xsYjRBVmRRb1VxYUVjbE1XS2xvNm1pOVRhQzZFMXBYbXV1M2Q0OENB?=
 =?utf-8?B?Yjl3aFBZbXJZcFFOdzVsRnhSYzNLdU1rL1hRbWxSeVhJbTE1UXZyalJWaVJB?=
 =?utf-8?B?cE1maFJ2Sk83REdwa2llRXZsejJaOHBpdVZyU0ZtM0lWcU83aVRlSGpmMGp6?=
 =?utf-8?B?R1NDNE1BNCtXQkJJQmNYdXVQZytVam9oai94MlZNbXVjOGorMWczQjRFeDNt?=
 =?utf-8?B?cmh4K2pqVHZ1QmVEeXJLWFBjanl5UGYrVHBxTmp3bmxPVWxoRFBnMURkZE9Z?=
 =?utf-8?B?bENWQW41VnZrVmg4U3hoOVMxTUVaTDRNWFNxNWM5a0ppeTlyNnVOMFJLK202?=
 =?utf-8?B?bHVFeks3a21PY3R3QW1kUHpYNWRya0liWDFDd2xrV2QyYU9zSjdISUg4bVY3?=
 =?utf-8?Q?r0xzI/CYxU4ni?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZhYXZsQkQ4R2sxOHFRV20xSjhtWUFOaE9MTWdtVjgwYkdUUkplNzlIR1gy?=
 =?utf-8?B?SkJGbHo2N2N0NG1mTTZaQXk1ZVo5akFsNUNnbHBucFZDQ2VWMkhubkJUcjFq?=
 =?utf-8?B?c0FqM3VJY0FiaE5wZk4rdVloM1RBaXltY2h5UnlKSVZ0V1dpNDdSdC9zRlox?=
 =?utf-8?B?UVQ1Vzk3MUtLdEpBQkdxZGNHVWVuQ2hFSjdtNTRjYlZWWDZkNTJraEJSL21P?=
 =?utf-8?B?Zi81QWVYbUo5ZS93SEhPcUtCcnFKc2xtMG5SdHlocDZBMEFsM2s5T0Rzdndv?=
 =?utf-8?B?UFozNVdFVG9zTnBkWmFGMFNZSzFuZnlzNE9wMTliTXhiZTc1VDEvOTFRYlgx?=
 =?utf-8?B?eDIrRkkvSllMaHR4K1ZpL1NIQ0RRVC94NGpYdWFVcjdudWR1UFJDRVEzc3JY?=
 =?utf-8?B?S2ZqbDRFSmgyN3lFd0tLOTIrS0wvTElHcFltMTFObHVDQWk1K0o0blVYYUN2?=
 =?utf-8?B?T1RGQzRlR3RDZ0o3aTA3R2NKWGNFVVQ3dG5QUjdTVjQ0QW5HL3RHTnFnTDZi?=
 =?utf-8?B?WVdxTnVMeE5hRk9KdnVqa1gvUE43VGFOdFBvak9ZZndvMlZmUDYvYUh4b1Ri?=
 =?utf-8?B?ZE5jZFZMK0d1MXFmSGFpZDVZUkloZm5Gak9yd202QVlRYkdSNGVmc2lsaDBL?=
 =?utf-8?B?SGZ1UWdmdGRsajAwR2Q2c2dkSFMvZzJtTkxnSnFPdE80NlVHeVU5dnF2T283?=
 =?utf-8?B?UEJwY1VOQ0VNNmpQTTJlMitiOFpiRTF5ZUF6Yi9sSCtXQkhXa3FqeUJialZC?=
 =?utf-8?B?M1Q0dXVqY2VzdGJaMTBwZytZTkFlbmRqUUYwbFdnMG5RSFdlb2tITUVQVVc5?=
 =?utf-8?B?ZlVJRFd3ekNPNFluUnA0ZXZxSnJibWwzcWUrUmJ0cjBLdWRaMHg4R1Q5aFlK?=
 =?utf-8?B?eWhrdlY4WFUvbXRzem1tTjVobTZTdCszQ0V2bjc1dzc2Ulc0WTV3VkNJUlI3?=
 =?utf-8?B?T29NcDJJU0orVHcrZURQSE5FVnNzcHhRaVk0OVJoQ0pSYWt2dTRhWDduTmRM?=
 =?utf-8?B?MmVCYVhMUEIvS1UzcW5OVFJ2UHpLeW13QjdOMTc2bW0vWXlheVJWS2k1U1Ra?=
 =?utf-8?B?Vkx3aUFPM1RSQm5pTTZEU0ZPTVhsWTVCZTAzNXh0TURrVENjMlIwcmoxZVQ1?=
 =?utf-8?B?Y25kUUJjLzNuRGJuQTh2Q3l5TThDNFVFMTlhNDFTY3pTMUhQd3pEZ0kxeVQy?=
 =?utf-8?B?RmxGaHo4WXFCM0hGeE1NWjZXL21GOEtzMUdtdEJGOGJDbnE2V2RxVkQ1T1kr?=
 =?utf-8?B?dW0vMjNEU2RtWEF2U25pTTFvYlF5S0V6OTRoWWJsRDVRUzVLamx4bkNpcDJK?=
 =?utf-8?B?RGN5SVlPQ1FtK0Y1K0huY05XbW50R1B4alpCRGpET3k4ckJ1aVpjNGxOU2xo?=
 =?utf-8?B?SDJOL1ZqcnJOeWxVT0xacDh1S09wWUlsYjExRHEyZVV3NGIvdzJPQ3ViVnBU?=
 =?utf-8?B?Ylg4TW5XcGM1Z1dDMVc3Q0twTnF3elFOSjVBZlJOQ0t5eE5UTHplYXBCUHRW?=
 =?utf-8?B?QTQyQk5TTDFwb25qV1NHZE44WEFacFMyOFVCUDkxOWhGVlFyUW03UjNCSUNR?=
 =?utf-8?B?M0ljaUY5RHdMdUtjclNlZk9KditPZXUybSthMEtsa3drR0pnRWQ4NkkrcitT?=
 =?utf-8?B?RDc2K0RCN1B0VWdFSDFRb0oyL0RnWEtONGRWUWROclZYTzFJeFhFUmZDenJG?=
 =?utf-8?B?WkRKaTYwWisrejBLdlJ5VlFlbm8vRVVKNUpJSi9oQWZ0UWZ0RGI5Yll4QWRU?=
 =?utf-8?B?QXg2RnVCY3hhejdhbnltVkRaaDBTazYvN0dIRVAwRGpmUlZPUDJobDArbjhK?=
 =?utf-8?B?bUsvd25jMHZVWTM1NVlyMTk5ekEzclIydUMwZDZZSmRuQXU0c1hZV1ZzWDdw?=
 =?utf-8?B?eEJYRE4yeGdiVXlmVUlVWTRkV0dWbFQraFBseGVJdDhrTjV2bW1LSWRsSkUr?=
 =?utf-8?B?VHlha1ZJMzJBTFNFUE9GeGJMODRCZmlNZkdUWm4vb3djbTFzd2hHdDJmSG9S?=
 =?utf-8?B?VkZPVUl5QWo1alVCc201UkhUME05dml0WFl6MmtuYllGSUw5VmlsYjVKVmw0?=
 =?utf-8?B?cmp3MG1WQUgzT2lodG9TMFVWZldkT3JpRnhhamR3Q0pMTHJGVkxWc1BSdU8y?=
 =?utf-8?B?aG8yZzFjQWNXYy9VWW55V3UrSTlHYnUvVm5CWk5QK3BKS2Y2eXBmK2tEaVJ4?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffb480c-a62b-4ef7-7c47-08dd77230a85
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:57:34.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgB6Lj8H+PbVVBLZr4rPuT7aLtCcHG2vdZhcthLbcPUBy2/B6TSx3Tq4+0P9R66OuxnChpUPGPlGd8tGu2qYSHaiLmfkxKbiKD8yjarip4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> C codegen skips generating the structs if request/reply has no attrs.
> In such cases the request op takes no argument and return int
> (rather than response struct). In case of classic netlink a lot of
> information gets passed using the fixed struct, however, so adjust
> the logic to consider a request empty only if it has no attrs _and_
> no fixed struct.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 9e00aac4801c..04f1ac62cb01 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -1247,6 +1247,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>          if op_mode == 'event':
>              self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
>  
> +    def type_empty(self, key):
> +        return len(self.struct[key].attr_list) == 0 and self.fixed_hdr is None
> +
>  
Ahh.. I think I see where my mistake from earlier regarding the
attributes. classic netlink has a fixed struct + sometimes attributes.
We don't need to list struct members as part of attributes because the
header will always be there. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

