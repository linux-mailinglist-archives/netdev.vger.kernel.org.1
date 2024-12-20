Return-Path: <netdev+bounces-153737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1D9F987C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DC919615B1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B1D231CA2;
	Fri, 20 Dec 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI0qxBKE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16573231A5F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714816; cv=fail; b=OWjbRJiNkRWYKoKlMiq3iu/J6cGMkRe8icKhTpG46X0ExEgXV8gkkBSl1XOnuHXWhILAMxdFvh/UGKvPHPZ0ADArRBvugkoAG4tnCnxlTmRO+gUYrbyqYXQ+KAPCVTW0R4oFbAHd8YU41kjV/uQIaAMRg8z00vXbjlPx2hKdhwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714816; c=relaxed/simple;
	bh=mVqPLhm9aFGMzTyeGDHVc7yrvJRxXQyoJnr7QiGnKvY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hHJYooGzLvVSojr4ny5iGBWaNV7LiMg+YouKAqxGU4UyzQu/3EcxE1pKh+GcliOh3CguI3LoO22lm0H5p3JTS1Tzf6VnCUq1U2sHgX3v3GkLxMEB5A/K0AadxOMje0xGlLoKUMZbyVP2dWyTLVnKCZ/5wBhRBSIwzBW9ElpxkHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI0qxBKE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734714815; x=1766250815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mVqPLhm9aFGMzTyeGDHVc7yrvJRxXQyoJnr7QiGnKvY=;
  b=WI0qxBKEXMfSCiUqDHyhKyzs0S/Z7X5R/LBhEPQknxz1F9FQrTNinLfU
   8hXU6H0+cQwBQ7Uop4lSApxc1t3g7mhgu2NiDHE+xJ56sJIHUo0ooMjYQ
   hemF+s3WxWoshybQ0qiRQ1PUFIheuQtqbk+v4gTZgJ02sZ//KStuWlsGp
   yw6WVpPf2myLTPvhzsVu3+zLFd1hJOl97HpsP2pKinVNFTrl+kZe6WmVh
   aFTxOutcO+qaMRwDfiSbUtRJZo3F2Waxv89YBSW6WJO1uNHXB6vrpYZJI
   k0WpKZKzmPVVcI3rZWCeat8zl7XrfhdNCR2y9rYN8xSS1nDWSwd97vbEJ
   A==;
X-CSE-ConnectionGUID: 3u/ioVuFTFSV3AUc79s9IQ==
X-CSE-MsgGUID: dyjxzUjUTCCXRQ5XDNgewg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45959047"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="45959047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 09:13:34 -0800
X-CSE-ConnectionGUID: vmvqZUoaQ3SwYhxzVaN2dQ==
X-CSE-MsgGUID: DXV43OKTQMm61iTHxYcBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98616515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 09:13:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 09:13:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 09:13:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 09:13:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt0F+UVQoz3BCQeMEFHsaYRPpIuRf4H6UOCHWjNgujC1boP7YkVlzvX27gFsZioySvNncDC6y1FoWhitvhFoBH4YNycTQKJf2nY655iRHxE+x4EtQ7shtJEn5tRLD4V7EWuQbThpE27Q68Q51F2fhAevpkKl9mxJ7LNZwyKmIrRV4voBtrAHS1TagYd+CTiZLOD9bOnIsFXPDegDYbr7QvtG0rJ1vE0KkCkW+k0OmdLQ8Zag3r7lxhBJIf0csRtsCO5OlGf1IHvKwOdIfm8KbYc9DGmKHNdJ8xxxcFnzLvuVRG3OBqSWitn5h7VcdQ57SlTtHBIsSVDYxy9anAWcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rBT2E4jq2f2tVL4P6YojliMjHp8tZOIc79IYvbVIAQ=;
 b=KpgUdXjCXhl/syof+egTugObl8L/WYPxEJ0lGFi3X/kZgeUr3x4leMmwGt5CA3acnQY/c0Lc1fzjCHEHpYsnN41PBvuxq3G7LsJQUTZWSpzxOFVwX/aKc0Fc1kMxUI7RH02kIm9jO13hCXQewspQBR6L2TVODOY4eJI8l9Y4etLZjFdDR6k2HdlQ/mgd3ImSkKyGKqpXfrlZmoTz/BPMwV8yGnfFxgOpI9us7DrRRMeD+XyUrVbatj60z1BITkoVTKh6dqXbilwdhaRpf9UdnxkIRc/kH/lrLy59s+Xd4zR8Szh7jikSnFm3/udxMRaa0R6SBthFByfDxmghqmBV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 17:13:26 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 17:13:25 +0000
Message-ID: <ea9eda77-7c94-4342-aca6-1a4fc3446cc6@intel.com>
Date: Fri, 20 Dec 2024 09:13:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] devlink: Improve the port attributes description
To: Parav Pandit <parav@nvidia.com>, <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, Shay Drory
	<shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
References: <20241219150158.906064-1-parav@nvidia.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241219150158.906064-1-parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SA2PR11MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: ac480244-3b0f-4bc6-ec3c-08dd21199d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzJpQ3B3V1o1QW0xSWo1SitSQkh5RCtSVW5FdTZxblV5U3A1NzA0UkJyOFdO?=
 =?utf-8?B?VTFyUjVjYnoydXRlZm5uZ1hxNW0rQk5QOEtqMExtaURwYXI0a01mUndvQWgw?=
 =?utf-8?B?SEVsT2xEU3d3S00yY0JSRGlkenNSWUdLcXozOUt2YUNlVkJUTE1IUGt1Ulpx?=
 =?utf-8?B?NGFVMjIxcUhZemhKRUtzVU5Cb0dWYk1ib2lieFVRamhGb240UERJUGpTeHd6?=
 =?utf-8?B?SlBLalltOWpJbjhvUHlDVTArK1cyWlRpanJPdFFDK0owam1NT1FsakRiSmVX?=
 =?utf-8?B?RDdaclpCbzdRdTJuM0d4YndYdDg2L0tMU0Z4SEN1K1VKc3RIZXRTL1A3eGx1?=
 =?utf-8?B?YThpNGlNWkZ5ZFB2dnNYcm03dHRNQWR4dGlFUEpqVERHVlZ6TzZQZnJrRTFE?=
 =?utf-8?B?dkhPbU5RYVkxYlRyUGpqMVd0VVdzUk5rWlNWQnpWRUdUbjFwcGlQNThrcDMy?=
 =?utf-8?B?Rlptenl1L2E0L0Rjb2YrQ1pVT3ZpZnhDNm9vR3pjYU9naE9YUnF3V1ZoV0tT?=
 =?utf-8?B?TmQrZk03eTdFamNWK1JINE4rZlB2SUgrSkU0OVlRYTcrdlRxbFU0QjNhd0VT?=
 =?utf-8?B?SldiemptMGRXL2RIYzFBZXRhUTN2V1NGZHFQNkxJRmcrTDltMCtkcVJCbnNE?=
 =?utf-8?B?cEpRc1NFcW9ZQnpjMjJ1MkJTdlMySTVzZkVhbGJObEtSTUp3MCtkSUhZSU1a?=
 =?utf-8?B?U2p2UzFoRVA3L251SS90dkZYSWlRQmhsaGJwUGtLWFZTdkZISnFJSGNRenFo?=
 =?utf-8?B?eXpsR2t6TmU2MGE0MXRvbk53aUo0RjhlQjhLK1ZJQ0M4N0l1dXYrWXMwWlFG?=
 =?utf-8?B?TERZd3MwTVZkZm1lWDVSR292dWJGZXpCRUhEMlpJbnc4RlBDaGRacG16RW9q?=
 =?utf-8?B?U3ZJbnVLS1Q1aFJuYjAwcjFMZmF1MlpDSWhRL0F2Qmx1K0VnNG50dU90VTIx?=
 =?utf-8?B?VU1QUnAyQkRLL0NYTG5lcjdHVnNUMzB1WVltWkY0YlVCdmFQbE5CaCtwSnhw?=
 =?utf-8?B?Rll4Z2ROYlpHUnlicUtibERRSnlyVXlNVElLQmt3Z1ZpUkdlbWRDT1piRlFS?=
 =?utf-8?B?bnI4a2Z3NDFwSzRLa0pNT294b0VSR2k1TjVJbjRRNTFENFFITkZrb1ZycnFB?=
 =?utf-8?B?TUFKUURtdStlekk0UWlQN1FxRTc5bHBsWFdLY1A3eDFkSXRlSTg4NzNZdVFF?=
 =?utf-8?B?S3F2S0hoMVUyTG40VVg4ajBSOE4vbFZzQVA0TFBWWUx0ak1XMHRQRTF2Yzdz?=
 =?utf-8?B?NG9Hd3BQckNMRjJHZFc4ZWN4TTRuMVU2L21hcnlRZlZYejNBVkk2S2lTeDUy?=
 =?utf-8?B?SC9wcXhxZXVVbTY5dUQ3enFkdkRycXNnLzdEQ0pXY0d2N0V1eEF5VVRiZjdM?=
 =?utf-8?B?cUY4WTdjYW9WbkR6QU0xdTVqeXBZcSt3aFA5Ly9nbWs1OE1pdE9vcFFONm5x?=
 =?utf-8?B?NmdWQ0RONlhBN00zL1NsTEVEZ1hrMzZRSmdpazlLZ00wM2pRWXp6eVE3V0RU?=
 =?utf-8?B?VDZreC96RExjL2ZDNmg2cmJPcmJOSktlZjhhdEFHRlN4TlZnQ0I1OGF3SUg4?=
 =?utf-8?B?L1RLWkNtd2pMTDNtSUV5S3lRTS9UV3F3QXZGckI3Y1hpQnVLeUJsMFF6SXlT?=
 =?utf-8?B?OVUzM05rTGM3SmNqYzVUaitCdENtcm4xSlpvSFFJV1JwZDNEQy8vaXNBeTFD?=
 =?utf-8?B?TzdOeXY5a3dyR2ZLVWIydjdNeTJnd1R0ckdreFBreG5DMnZIb1JnOGhVZzNI?=
 =?utf-8?B?RUpONmRQdmFhNGg0MzQ0TklML3BBVnRZS3hyaDhPU3pzZWV0Ui9wOFBkN080?=
 =?utf-8?B?OXpLOHI5NUpqZlZhbVlaRVUrOURaUko5WUR6WnBYQkxFU2w5bUNCNXFmRy83?=
 =?utf-8?Q?lYRQ5/KWeXnzb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JrcXUwTDh1dWFnVFhuSVN6b3RLMVl2SEM5T0xMVHlnaXlSTEUxeE1wQ0xK?=
 =?utf-8?B?Mm44bWNySzd2VXEyRFlDbldhREcyNHRyQ1ZDdU5ISUZUcUxXbWJDVlpTK0o4?=
 =?utf-8?B?UXIrK1Y1R1J1WjArUFlzOXJjc0ZrN0V4REZjcjR3Tjc0R1BrbUVjMkd1SFR1?=
 =?utf-8?B?alBraWdiS205OUdLV2N4SmM2bWhhRCtiNEZoM1ZSbExXYjVCNGNIWWpSWnZM?=
 =?utf-8?B?NFNkV0JSQ0x2YjhhTytMTzByemFRRkVnWDVsT1hPWjlUUjhHZm51Smk1REgx?=
 =?utf-8?B?QjJaM2kybnRONUVCRlplUjcwZDRuUGh6QXNON2VLTXBvWk1VQTVuQ01HbnlV?=
 =?utf-8?B?SkpGbGNnKzNBcHUrLzAwTkpYU2NDN29VNjA1aTNiSUZDY0w0NDc0b0RIb3Uw?=
 =?utf-8?B?c0xCS3dlY3JSWFF3L3diMVBYdnl3UFZTaUhWQ0JKWGJkWjFXRlN6K3U3cWky?=
 =?utf-8?B?Rkw2LzRJVUt3Rk0yNHZrUEsySjlBTXd2dUFHY0tJUnh4K2ZEQU5lczJ6VXNt?=
 =?utf-8?B?Ym5DNXlRZ3B3WWQvM2VZSFljWGxjKzdsUktlZk1tTnFOaFloTnRaOFRsRHY4?=
 =?utf-8?B?TWt3S1VaVVlZMUQ1QXdMZFhjdDlmNmRaZjdvdHpVTVc2NVdhYjdOMUEvOXZp?=
 =?utf-8?B?NW9QTW05NS9qaFpIbUFqaDgwV3dXVFh1eHdyQS8rR2ZTSW9OUWVUc00rSy9n?=
 =?utf-8?B?ZkxvTnI0UzZJaEllK1FhbUVvaG05RnZwSWo2Q29lSUZJVEdpcDVzUU1NQXBq?=
 =?utf-8?B?b1pURzNMNmJVSVNpbDlJcmEyWkl5djVOTTJSOENyZUxKM0ZqSUtBMUdQZmVL?=
 =?utf-8?B?aHBWNEhPZmVISmxkZWd1M1VRQVBuSGl1NVNJdWI3RHRUWTl4ckl0WGNUQXE5?=
 =?utf-8?B?VVljUzZKZVA1cW1mOVNHcFo4dHVDLysyN05aL0hKZmI4bFU3bnRBV21ld3Qw?=
 =?utf-8?B?WThCTml0N3JzYTh5UTM1dXhwWk5wcFdrSXphdVloMlRycjZZMGUxaWcwMmpy?=
 =?utf-8?B?SmhKbTdHVmhwdW4vYTlCczVZTVlldW50K052a2MzeTBNdDhhbnByUktpc28z?=
 =?utf-8?B?cUsxSGpJU3pjekpaRkJ0UnRRcno4bklFdzVhSWlEbW0yc09XKy9BOER0TUl6?=
 =?utf-8?B?VmM3YzNIKzh2ZGZndXFaRjE5UVhUWVVSc0lndGx3MlBpRXVMakk0anNHYzV0?=
 =?utf-8?B?WTNsS0h0MVVNM05QQVBWblhIdHFFVXRaT0pLVHA0Ym1lOTloUnFrdG0rcEVF?=
 =?utf-8?B?bmVUYzZmekh6bDFOK3B1cmRBZU9mYmsxWVM0VmdIVzBSZ0lOckk3UDNrZHF1?=
 =?utf-8?B?akhCMmVMdUpQQTNpckJIaStXRTFrWitQbHJ0U1RRT011NFEvNlRIa2lrMWZo?=
 =?utf-8?B?WDZhNzJSbUtMMnhDSGoyaVRCcjE1YkpKTTVVQzd1SnZlWEsvbVI2QXp1UjhZ?=
 =?utf-8?B?aWdqRXZNeW93czNmWFY4UlJ0K3VBR0xKOHdPVFlmZExtMS9zcUhMWHR6Zlpr?=
 =?utf-8?B?M3hMMm45N0ZXM1RHZFpsdStpUnF4cXI3Z0ZVTVFNWEhmc2ZwSEdXeUI0UHZR?=
 =?utf-8?B?eEJVaUNzUW9XRi9PNk9UMENRRHJ3SWUxaldFdVFTWU54R3I3MVNuUzU3ajgy?=
 =?utf-8?B?Y2pTczV3bW9vbUlEMG0xZHF3L2JRVkl0RzJ4bWdVQWJyQ0l6d29aRmRCK3A2?=
 =?utf-8?B?NnN4Nm1PTGpUUWYvOFVvbEFOR1QwYVlKK1NPQ0dsa0FCNmxyMEJTLzdMczJ4?=
 =?utf-8?B?ZS8yUXVQTjJMUW5kOExTcHF6enA0aktNSys0c0ZDRGVpQ3ZzbmppZlJtRFRw?=
 =?utf-8?B?NjhqWURyRWtKSTZpc29BcVFHeWV2SGZOYWQyQzQ2WC92NG8zSTVWNzRVQkRV?=
 =?utf-8?B?ZVFtdWVRang2a1FxaHpFcm45ZGpSYkVFRjNPcUtqZVhNdnZWcTdvbCtMdk1n?=
 =?utf-8?B?TmJWbC92MHB4WVg0QTZERk56RUsrY3FvcTJrTklKMFVIa3pSZkw0MzJZTjht?=
 =?utf-8?B?QXBqcDd5WXcyOGR1dVVSL0g1R1VtNEFlUHE0WFBpaXRXNGtOR1BQd1gvRVVB?=
 =?utf-8?B?TUt0a1dxQTladENjZVFIaGZPaUhYbmJuU1NCVnl6aS9MaVA2ckVuZGhvYTJB?=
 =?utf-8?B?UXBiSnB1TmNPSWExT05jU01WUE1qWnJZcUlwTGNwWkRtaVM1OHcvMVZaNUZ6?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac480244-3b0f-4bc6-ec3c-08dd21199d7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 17:13:25.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRwBMnOc14vFjQRkEFe33noFKYeCPFPdpwCqKziqJYB3dpRna40C0U/MWIOZPRsXw4emxh4dBup2S4vmjBS6ogbvqnlKH/cSCs+v/2HEVyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com



On 12/19/2024 7:01 AM, Parav Pandit wrote:
> Improve the description of devlink port attributes PF, VF and SF
> numbers.
> 
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

> ---
>   include/net/devlink.h | 11 ++++++-----
>   net/devlink/port.c    | 11 ++++++-----
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index fbb9a2668e24..a1fd37dcdc73 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -35,7 +35,7 @@ struct devlink_port_phys_attrs {
>   /**
>    * struct devlink_port_pci_pf_attrs - devlink port's PCI PF attributes
>    * @controller: Associated controller number
> - * @pf: Associated PCI PF number for this port.
> + * @pf: associated PCI function number for the devlink port instance
>    * @external: when set, indicates if a port is for an external controller
>    */
>   struct devlink_port_pci_pf_attrs {
> @@ -47,8 +47,9 @@ struct devlink_port_pci_pf_attrs {
>   /**
>    * struct devlink_port_pci_vf_attrs - devlink port's PCI VF attributes
>    * @controller: Associated controller number
> - * @pf: Associated PCI PF number for this port.
> - * @vf: Associated PCI VF for of the PCI PF for this port.
> + * @pf: associated PCI function number for the devlink port instance
> + * @vf: associated PCI VF number of a PF for the devlink port instance;
> + *	VF number starts from 0 for the first PCI virtual function
>    * @external: when set, indicates if a port is for an external controller
>    */
>   struct devlink_port_pci_vf_attrs {
> @@ -61,8 +62,8 @@ struct devlink_port_pci_vf_attrs {
>   /**
>    * struct devlink_port_pci_sf_attrs - devlink port's PCI SF attributes
>    * @controller: Associated controller number
> - * @sf: Associated PCI SF for of the PCI PF for this port.
> - * @pf: Associated PCI PF number for this port.
> + * @sf: associated SF number of a PF for the devlink port instance
> + * @pf: associated PCI function number for the devlink port instance
>    * @external: when set, indicates if a port is for an external controller
>    */
>   struct devlink_port_pci_sf_attrs {
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index be9158b4453c..939081a0e615 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1376,7 +1376,7 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
>    *
>    *	@devlink_port: devlink port
>    *	@controller: associated controller number for the devlink port instance
> - *	@pf: associated PF for the devlink port instance
> + *	@pf: associated PCI function number for the devlink port instance
>    *	@external: indicates if the port is for an external controller
>    */
>   void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 controller,
> @@ -1402,8 +1402,9 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_pf_set);
>    *
>    *	@devlink_port: devlink port
>    *	@controller: associated controller number for the devlink port instance
> - *	@pf: associated PF for the devlink port instance
> - *	@vf: associated VF of a PF for the devlink port instance
> + *	@pf: associated PCI function number for the devlink port instance
> + *	@vf: associated PCI VF number of a PF for the devlink port instance;
> + *	     VF number starts from 0 for the first PCI virtual function
>    *	@external: indicates if the port is for an external controller
>    */
>   void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 controller,
> @@ -1430,8 +1431,8 @@ EXPORT_SYMBOL_GPL(devlink_port_attrs_pci_vf_set);
>    *
>    *	@devlink_port: devlink port
>    *	@controller: associated controller number for the devlink port instance
> - *	@pf: associated PF for the devlink port instance
> - *	@sf: associated SF of a PF for the devlink port instance
> + *	@pf: associated PCI function number for the devlink port instance
> + *	@sf: associated SF number of a PF for the devlink port instance
>    *	@external: indicates if the port is for an external controller
>    */
>   void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 controller,


