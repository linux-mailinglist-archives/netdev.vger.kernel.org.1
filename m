Return-Path: <netdev+bounces-176039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C0A6872A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EEA4200D2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35391DDC16;
	Wed, 19 Mar 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME9CA9bM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740E1B3937
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373970; cv=fail; b=VjWxQkNoTnIppzmc++CTl+WIYU87FKtG5kAbd/QPHl5WR4jKV3rsdf6ddPAQ8Y/QIm3Gzb7G6wJYcqO7pXMw7+GrgYpoG0QyU1wZ396J+07GlJCaHaslTUnNMBylLcNtHfMQmC3Y88Wh0CtTJei6AgBhyC/8YVa3wkE2jk9a8Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373970; c=relaxed/simple;
	bh=Pb763dBDQPl0ypupQki3DYInpIAiHQSfG38Eb9xfvzM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W48wqCWftKZjj9MIYxoNFxxuTZhCmBKTfgcSlJKwgtGyjRYX7uzKm02HllnTz/fYHRG9IGUoyvEKRI5Wn8RC6Wc7rYDlrHfAfoTtsO0Fk6CJRzV8UvS3QnBUFVwFUvlnynv+N8vJw+5DOh3uA2d/8iZ5l66vPmvzYeR0rRkJs88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME9CA9bM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742373969; x=1773909969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pb763dBDQPl0ypupQki3DYInpIAiHQSfG38Eb9xfvzM=;
  b=ME9CA9bMKp8GG9kfHyNFHmRpKfI0220El1JVTjO60s1Pouy57+FZZ56F
   DZqSHwHxDWvOh3ca44Kzg0zw8iG8/DKQMSdo3McAFClhH6391RkiUz0Us
   PSR3HgZc6B6gsNGTSUfVhpMWyk0AtJjCtm9sx1/LOh4gy23US1JWORu9W
   AUf1t9ccz5kwi8PeC+qafTC/hg0gXirAaT48IwJliMzD9eItYoRTcdp2J
   SIS6lEhSoybH1MinwgGW3OC+0Dell4soL9beBbcvXqCGNeUfdCYk0npQ+
   I4h/o8HWduc/qv3A3eaiSnrkfvxGn6/LtZ32+lhnJq+boCRlMV0T6asgT
   g==;
X-CSE-ConnectionGUID: yE6ZzrijTdqIMvtOicTF1w==
X-CSE-MsgGUID: 0T0LOlQER2C4E15TEC592Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43651895"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43651895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 01:46:08 -0700
X-CSE-ConnectionGUID: /gK5q2+zTZWoqDSkHEfcPg==
X-CSE-MsgGUID: 8FCggaXHQO6NbmDZOZQ4qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159678768"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 01:46:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 01:46:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 01:46:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 01:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEHcVPWm1lhJp8wIxqGFyi2Xjty5SzJwmEZLkUzxXKAznePpltMNhwHEfbtZB7PtCxVlhWhEGxdW8w5fEroLV2xSMOv5oKbcVNLE+R0ytcKMF2lQmJ94XElzeNZrplwu6YVFzy3b0fWUsQv9a3XL0bDgKkOvogiuVeCO2WlrWZdxKsmpEdu0yYx3Owz/TEik6chEKdaIMEJ5SBKzdTnhp8WLoHpuuks4V1o5t42nsX0fMMLpJ+6Wh+A/Qkylbho7EjCRuTH3Xq8T1xGJdWuR/wHl7LzQ9PZwlbFGXArHJ9S1YHFwMUo/ouaBT1/Gwg1r8CXcLkutBp5CB88ywHPx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEhC5PhMBOUTJXlcOvCtajaeS4Sn+nHVjXW97uwNgFY=;
 b=GJU7a4p0IaWyTbfEO0fxSY1EoGUCYZYwV8atxByHWMUb72WKoI3sykXX2X3FpJIskfrYfoUVT9zll8u8x73P5U6bcVYQvUOZN7YgltldRE6ai480it2Cl6iFUMUkZWCePm0vjVwWY2v6pJclISXrUsTPd4SyYFGRQWbpzGccrhriaqBaJrCd2dUGy/VapLDxK3GcEY0l9gmZzUOmf0ddXIYCILnVWxszTy7I+RuYDU+X41nSE8mhg5mfUeVVKc2K0OwL4ASxb0s2ZF8tqrqt3QGQLxLk+tEZxYtTinn9KMkJnPA+z4hGRqUMTQcGvnVRAfjiMdGg7qS9az7fkSOx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:45:51 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 08:45:51 +0000
Message-ID: <38d36f24-4c27-4af6-ba17-550ee13513f1@intel.com>
Date: Wed, 19 Mar 2025 09:45:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
To: Matthew Wilcox <willy@infradead.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <netdev@vger.kernel.org>,
	<jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<pierre@stackhpc.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <christophe.leroy@csgroup.eu>,
	<arkadiusz.kubalewski@intel.com>, <vadim.fedorenko@linux.dev>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
 <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
 <Z9Q7_wVfk-UXRYGl@casper.infradead.org>
 <a901bf8d-d531-43b5-a621-b2e932f67861@intel.com>
 <Z9gUd-5t8b5NX2wE@casper.infradead.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Z9gUd-5t8b5NX2wE@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 575abfcf-44fd-4644-e40a-08dd66c273d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTJIY05raFlNSG9RZWJJNER4L3drZEQ0YTk0anQ1QW1OSVlaNFFlVzdKSnV0?=
 =?utf-8?B?VGNCR2FRK3BBZGVQR3Z4ODIwaHNOdDFObEdQWmZGckcrQXNlM3RiRUZIK0JD?=
 =?utf-8?B?QnpHTzFPRjRnNmdNM2EzdVZJekZQdVczbnFPcHFScVVrRTdmM3VOaUx0K1Jz?=
 =?utf-8?B?WGRlY1ZPM1FTQjZYTnlvclAxRXBIcEJZRGhPM1dFbEtWQWFNSFlnWDdqNUJQ?=
 =?utf-8?B?c00vWDhTa1VJVEVkZFBrWGp2VjZVRDQ4emJJZWtlWFIvZ0d2eEVnOWRGTzYw?=
 =?utf-8?B?UkNyNE5SWFYwaE51VWxOcEM1bmtCQkQzSi9PRG9uMVBvbE10dzExK1B0dnJv?=
 =?utf-8?B?MWU5NVVOeFk1UWRlSDFDZlVoU0V6MFpNdmVHaFFKVnhPZnpiS0xsQU9vdXQ2?=
 =?utf-8?B?T281U3Y0M3RZTUxSQVp6S0lDckxzbWU4V0lGOWlHUHphZHh1NE5MUUFaV3Nq?=
 =?utf-8?B?L055a21yTUhtTS9GUXlYMUY1RXYyVUYxMUtEdFlRdGRNSWFJendVb0g2MHhx?=
 =?utf-8?B?dGM0eGM3UlZvZmx2S3MzbWxSYWxtSHRqaWZZUkFhaytvUkFNUytWdVI5ZUxF?=
 =?utf-8?B?OXRiQlF5ZDV0bXRDNlcvU0xPMkFmT09OVEdSNklLc3Z4MEVJSjBNV25VVDRl?=
 =?utf-8?B?QU4welBTWUhENmFDNThFcEVKS2RmcEdjVkkwNGduNkh2bGJvanZXWlZudUhr?=
 =?utf-8?B?Sm5sRmNYK203dDkrTFQ4S1FTZkN2N2FzcE40L2lmOGpUNXBwdFJLVFZjemRS?=
 =?utf-8?B?UkRVcUhsTThrMHdjeTBnNmk1YTk4M3R1UUZGVmdQNlhJc1MwK3pUNEpSNExN?=
 =?utf-8?B?ckgxTTdJOUZGRGRxUFFOVWxhWm1Ic2tnWUQ3V2VxdEhiVjdqc0dDUE9HRnhF?=
 =?utf-8?B?MFJ0a1VKN0ZFYTRRV1lXaVFLQ3VYQitNVEc4ODlUaVJQUCszTFlMdzY1cGZF?=
 =?utf-8?B?NjRSS1R3MHg0R2tjUG9KSmJyQUlZMlRxdUt5Umw1Q1d2aVBzeW82K1BJRmdq?=
 =?utf-8?B?VEthTTIzVkNzc2hnYVh1R2dSNjFMQldpd21JRHJXRFN6K01aSjU2NU5tUkF4?=
 =?utf-8?B?NlFKdHJqMUpyTW1CR2Jid244MlZCN2hHT0dIUmVWYTBjMnRzNW11VWFoVHo0?=
 =?utf-8?B?YldndzVCZTdBTStuaHpwNHZGMGdwRjBnVWNlc3dxRGZlbGdzRDhjRnVjd1BW?=
 =?utf-8?B?OGFsZ2s0VWx1ZDhZQWIvMDBvMVowc0F1cjV4cS96bEljZXgxLzhZdFM2RE5Q?=
 =?utf-8?B?ejZwSDV5Z2IxV3hlbDJlRnFUMzkwRkozRnRNeElaZCtkbEhOR2hLQmM3akYr?=
 =?utf-8?B?eS9SYTJweTJQc1Vyang0V1RSVkhOM1puTXFxMGM5QkhyVTZhZ05UVG52REVk?=
 =?utf-8?B?cjlQWEtrMm5MNnpISE9WS3lkaFpBVEpqMmV4UWF3VVRKcnEzZGMwaDNqbzNx?=
 =?utf-8?B?VXFuYTdyTHBHbVJLZmJZMzhQbXdUS2k5ZGk0MXJxVkFUUWN2M1hTYWpScWg2?=
 =?utf-8?B?LzlwSEN0OVdvbGxSeUFBd2F1SG9PQnBlUWd3YzM0ZnZieHRMb2VDa0IwZkw1?=
 =?utf-8?B?SlptejZKYlR3b2REUmUxb1RsdDZJdW5rcXp1Y3BnYitXcStRZmcvTEdrLzJq?=
 =?utf-8?B?Y05GU3lhTitRNGRPSk5EUXVnRk5UY2pEemNvWVJHcjMwYXg2ZCtORjR0RWNj?=
 =?utf-8?B?TE54N2dZTGtWNng4cGFNRUx1dmhEM1RoYk9LcmVZa2xrRTN1dHlyL0MvUUVN?=
 =?utf-8?B?NFRuWFZqbHpxWDl4Q2RjT21qUW5JU2ZkWDJwK250V3RwR1A2REE2OHh6VE4z?=
 =?utf-8?B?eFV0YWZrUEJSOXNGK01qSGozU0hnSjZwU0VKRE5EcWgxZ1lnTUtISVlRcUlM?=
 =?utf-8?Q?NrQ8iJqJOY1Zp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVPeDhwNmNKMm9sNFJSY1d5TnE2bklUVVBkMUQ5RDJ6MFgzVGxyTUVuNUlx?=
 =?utf-8?B?cmhzUnd5a05kS3pFWTMxdEE0VzluRWRGU0VxaHo3MzJHRVFpVUN0bjNMa1Rs?=
 =?utf-8?B?NlNqVFQ2WVlDSkNSZE80ZEREMFNSZVpqMFhyTGJiZTFxZGFGb3Jac1AzYm5h?=
 =?utf-8?B?dTZGa3NsTVNyT2J6bGhmZHE4SlN0Y3pJZTFjZlpCRCtFNlkreTZrc1hpdVQz?=
 =?utf-8?B?NXJXcnJ1TWFST2pEZUdzWGk0SG9VbHJtNnkyMCtQVDEyRERGbUREUm5sNjNz?=
 =?utf-8?B?WFRHVXRIaS94eTM2WGhjNlg2aEN5czRNT2VoNk43TnZsSU9YQTVkeWRxbmV5?=
 =?utf-8?B?cXMxTWxIWm9YVXQ2QjJnRWhTaFZROTgvYUhqV2VEMFlTQ0tZMUk1NEpkZ2gw?=
 =?utf-8?B?TkN2emFGbEIvUk5vVjA0ejNNWVJKRFFySFdMOHJOVU51VzVYbGtINUNWeEx4?=
 =?utf-8?B?T21kUnlERUZhV3pXQm1PVXA5QUZIQnFiRm1jMlFsQjkvT3k1ZXFLQmsvYVhO?=
 =?utf-8?B?OUpjY05hdkFNSzNFY3Z4V3ZjTm5SV0p6MXJmSzhTTVhjRENESDdGajF6NU50?=
 =?utf-8?B?ZUpabFEzOXc0STB4YjRTVXdrU2R0RUZCVTAwaTIxUXJBWHQ0SE95Vm16SU1K?=
 =?utf-8?B?QVluQVp3dTQzWENlRTJrVHVKUlF1c29hcWlXV0NoVWVLV0c5VktQb1BWbTdR?=
 =?utf-8?B?bjBtRDBiekVGNytvbkdkZG9yZVcrc3BLdVRubkd2bGtwTWwzeS9kL2JaY1dC?=
 =?utf-8?B?ekJVR3RZeGFrWWY2TXd5bFlqT01KT3E0YTdLWUZUdk1reDhDK0dvRWtXai8y?=
 =?utf-8?B?cTFvVFBxUXJNaGNXaDFWZE9sQjBvdTZiTmJqNVNqN2w1MVllcHdZenc2NnBR?=
 =?utf-8?B?SkZsZVl3YW92ZVI2ZlZYR21rV0hHbDN5c0dvdzdDMjBOL04vVkp1UDZ2U1hG?=
 =?utf-8?B?NEh0MUNpcGN6TlpnN0xYMkRiQW9nN2ZQSEUzNlJoQ1p4VWJNRExubTI1Mnpo?=
 =?utf-8?B?cUFTcUJSbkFJbjFzRGRPVXFCeGZoaytWNFRiOVNxSXY5UWRLckk0R3RreUM1?=
 =?utf-8?B?djlLNlFZVHU4bFE2WkJoWFZzSGR5Uk1qNkRiTklSMU1ENVZSc0tnTk1yWUlW?=
 =?utf-8?B?VGxDUk12UXlNUVUwQUtCUW9LK2VtQXVwYW9GVVcvdTE5UzBURVlXTlpyN1Ax?=
 =?utf-8?B?a01uRTJwVHZxc0c4QisvdUlyY0RBZnlsNzlWWC9TeUt6Z0JjSEt6Y0VVMjdm?=
 =?utf-8?B?Qk1sanM0VzliL0RQbzBmYnNZYkpJYzlCZE0yQ1JLeUpnMkFxNjVreHZ4SUdI?=
 =?utf-8?B?ZGdJd01SdmtSaDI1RUs0NlFnL3lWSUFBdGtDN2FJNnV0MXRGUjRpc1BTV0NC?=
 =?utf-8?B?ZUYxYXN0Z001L0s2aE5RbEJ5eGtwa2M1dTZKMW1UcnpXbFZ4ckNFZ2pBb2t5?=
 =?utf-8?B?bXB5NFE4eWl3MXZKYkRKYWtZbUFHWUVxZU1zVjhsL01sVjU4TjZ1NC9HNEZF?=
 =?utf-8?B?N0RxOGNCNktyeFNpaHFZWWEyWld5SVlXTTRpVHF6U3Nja1gyVTVjOHRheWpj?=
 =?utf-8?B?T2JWYzZkdEhRd1BSZ2lIWk9SbDNWUmoyWmdnNTBUMlMxcm80VGxkYnB3SXUw?=
 =?utf-8?B?TFYwajFFbjBBVjZRUFA2OXZ0clpQdWwvOVhBSG9wdEFmck05VnpNTldZN2Vz?=
 =?utf-8?B?WEZlSEw0LzBIaU84U05lTE9Fbmh4bzViNFN0eUFuZXVPRlRDVXl1akpsWG9F?=
 =?utf-8?B?a0YvYnJsbFlmQlJWZlYzL1ZSdTA4YVhyLzFQOFc1WGI0T3RBS0k0NEpRT1Q1?=
 =?utf-8?B?MkpKMjdPUVUxTldNQVNncnkzcEVsaXJjV2hFQU5tN2V0b0lSMU1OVERsYjN6?=
 =?utf-8?B?Mld1UW9tMlBtSWtnUWwzM3dKSVZiUUhxVjIyVTlsNHRLTnAwOUNMbUFHcGl3?=
 =?utf-8?B?Y0FrWTBiMnZaK0hSNHpISjQvdTJDSm5ucE5sM3lieVZNblhoRlVZdEhuN0Qz?=
 =?utf-8?B?MWc1ZmFNZ0lFOTJkTGR1MDlQUko2YTR4R0V0clBYbFRZWjN6M3hrV0VmNUg0?=
 =?utf-8?B?VUFDQnhxRUtQb3RwNXZkSDhqcGJRYmhncUJjTTNCOFRDcTYwY3pyUGtqMXdx?=
 =?utf-8?B?NjMxNGEzR01JMUZRV1Z6Wm51enlZZWlEcVZ4RWxzb3BrdnNUN3FPMzYvRVh4?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575abfcf-44fd-4644-e40a-08dd66c273d4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:45:51.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U56XTPhisG2B08ZcbDydmmioem4lDu58O9veT3AkavXm4KNDUC/6E6Wl7/WPgtZKK8tgIBOfbOYAf3Eg7sWMiOPV1TFTcfglMKo6G2DokWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

On 3/17/25 13:24, Matthew Wilcox wrote:
> On Mon, Mar 17, 2025 at 09:55:44AM +0100, Przemek Kitszel wrote:
>> On 3/14/25 15:23, Matthew Wilcox wrote:
>>> On Fri, Mar 14, 2025 at 01:52:58PM +0100, Przemek Kitszel wrote:
>>>> What about changing init flags instead, and add a new one for this
>>>> purpose?, say:
>>>> XA_FLAGS_ALLOC_RET0
>>>
>>> No.  Dan's suggestion is better.  Actually, I'd go further and
>>> make xa_alloc_cyclic() always do that.  People who want the wrapping
>>> information get to call __xa_alloc_cyclic themselves.
>>
>> Even better, LGTM!
> 
> Is that "I volunteer to do this"?

sure, why not :)

