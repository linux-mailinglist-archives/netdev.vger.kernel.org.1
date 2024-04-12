Return-Path: <netdev+bounces-87462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059438A32B4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276C31C20D66
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318A85278;
	Fri, 12 Apr 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3wr6VdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A081487D8
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936414; cv=fail; b=rsxz5w3fFqJKqEceU1DHD9A9fsLSJU6dSKHiqnpYp7RuqLSJJusSKbhD1+42RTrXbH/KFxlXQ4byIeepf113FjTlNhrU8C240ygC8hUhS9mLK7uOQ8D7mYM+lVBg4f7Eg1YOFIqdsxN+3YHcQgnnVTgvZIzjqRThx0p55Pfwy14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936414; c=relaxed/simple;
	bh=JDGlHU6c6Zvy1GsSf83krOBzA/TICM5/VKAlNRp022I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwcfhxA+6xPzjFf1ikdOXoBYuygew4MISHFZScEhHJxs6oeT0Ryh+hCwOqzlpbzclgoW4WvJvdimP/+UKcGZOuqoRE7QS5IewRzO4xRK3z4smobMCT94B0K0uXrJlayyMRqAwDAp059ykCEUdRhr46Nkl/3XV2v3w/dQMZr2sB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3wr6VdQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712936412; x=1744472412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JDGlHU6c6Zvy1GsSf83krOBzA/TICM5/VKAlNRp022I=;
  b=L3wr6VdQxWF4nCEqwtJdxmZtGVyMNPDbtuXb2j6nuTbWS8FLi1BTBVHB
   6lRJI46JU/70O6Hh3dXNELcA7quCTaCfYLE1T9K/xjk37FObyOe0rlNFh
   LeRTcd558vSdJuQlB3dUC4BR1igWw6ae/5Gix5oPQ3d1do/F2o1yQptBY
   iFiquBYArzylHecs6Sgcv8S44Cprz+O3dMSGaklknEihvqAl8WExHQbjB
   djUrHKqftOhbj1m/9QNCLabeuxmgZ7Yh7vzg3BqAFZUJh2jbpwc2Nj1x9
   RwDqgJHe1d/TrpqVN/Hx9Bjzi0XRg1lSqGGKY6FTWLKeifBjn9/usq7KN
   w==;
X-CSE-ConnectionGUID: TTvRJU2ARbq+pfHi9MYDxA==
X-CSE-MsgGUID: B6OGbehhSAOOvuf28kP6xQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19108215"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19108215"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:40:11 -0700
X-CSE-ConnectionGUID: 0Qg02lrdQPSiCvzdyCEv3g==
X-CSE-MsgGUID: XTNZ9DvAR0G2dODIHCbCWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25810933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 08:40:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 08:40:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 08:40:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 08:40:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 08:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egp58tAtLPUT0uzYNIqar/7DvgNFtjC0sv5UVHWYSzVSaD1LHV1C05nRPUUlwjjD9pHFEDwIXYbThljj+D2eMiYqNNiDVggTs+dDjYMJcp4Eu6mI7ch29hvVTTOLbkoD8xuA2PQTJL98jZUhQ62PlYUm0LY6ZRCaCU4ffO/cxoh+Cf9YTuNtm1cYCKcdhPnMy1/bWOEuk2nAHrTc9IvoH7K2kzqLopZzFNl6lt3GHtJU5gno1/4yFe7zK3eu4I9KqEgY7Q0bsWWVqmDcuIxZZLNpcx4gg1JVNDisgJY8KozRkQqBJjOc0P8tiPWojr3jSl69X5JUvDuAjW9gePZWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAEnHuaEjgB8Na1lRJym9ceJldsKSYwlMpo29tlh93g=;
 b=gVEicJX9kd72lBoS6jP5KIkFakxI/hzQZdM1Efqkv3nes8Ogk/lVZC6KWiZVc7eEYbr4XtMKR6i6nrE0YboNHT6VCQicTU6ejRnP5TpR/Q1RSQVXiUDMHdzmHnrSNXw/KFaWmdqkx9GEXNkkcHX1CdUGcjpxAQcBFeaGO72ILliz5zInXqm/UPeOmesKH5OyJ2/f+GGyFM0FRefKy5p3hgU4gpum4qCKh11vW+thgVpZRDiJa1ESURJwfu3/ogMRb3M9lYBTMuwyKqssCe4o1nxxrg2PlcPxwPdYIyvkrk6M5SeaOndkd39JVibALpaaxv3UtBDtccIHq/uZ1Z8xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Fri, 12 Apr
 2024 15:40:07 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 15:40:07 +0000
Message-ID: <aaf6147a-26e7-2da9-4973-e7dbf4605029@intel.com>
Date: Fri, 12 Apr 2024 08:40:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 2/4] ice: Implement 'flow-type ether' rules
To: "Plachno, Lukasz" <lukasz.plachno@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Jakub Buchocki <jakubx.buchocki@intel.com>, Mateusz
 Pacuszka <mateuszx.pacuszka@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
 <20240411173846.157007-3-anthony.l.nguyen@intel.com>
 <20240411200608.2fcf7e36@kernel.org>
 <f0ed2d9e-99f2-4739-a2a7-62de488db35e@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <f0ed2d9e-99f2-4739-a2a7-62de488db35e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c589412-7062-4fb7-439f-08dc5b06d4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijdNDx/tWl1OV0oqdfCXxO6/C8uaA4HGKu9jSZI/WtYFZpGXQk6IrrQn09AzryIDQCaenLGMm7lfKF6olX3I8n0ekzvDg7Y6aPtE4pNvfyu2sQPIawyA4+SnaEJ9L4FpjTlXf5YQkQ+Dw4Q+HKBHI+XK473F/zOc8DKxJZFhJmmOs3te3UPIOYOzupt8ZJx4UqWhoHTWFt2djBWUMF1N2UDYJqocwEJVh3WksuWlhEUCu8i4uVp+BMFbkGAn6ynLDTwSMKZmz8fyJtbl4gK5bQ723E/8VbtEAG+zWWzMiD1vkuOjLjELG5k++BRLpFcnzZbleboAmsKOCVxXRV/D7Nbrm/qxtoS/UJZgPKObnOIZ8SsKEAS5TEJN/uzr0EMxXJA3xjewBHcG8NJObnvcH+TKulIJJSYezexF+7rUUI6XdqZyPpfgs+MWZCf56aFmfBX18ga54MtEnm46K+ETPIa4rmSk+OsY4PY8NOfYEd6mpiKVtVHK8fxDzxd2ygQt/yl5m2AG9c6Iq0Zh1OZe1G4kozqp2giQ7Hbbza8LjvnrSOUKVMV2R81wA4BXuIsPtTTctXZCz4qZNhsX7UoK9p7oNw6V1HKwL3fiWycgUZb1k3RJmb3Gf+rZ7Xj7/UUTkUbDMD+My6brWP2pRDFL8z3W7Bj/3cScqFOJuLb8mWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjF2d3A0Yks3UDFWR3JwVGJQSnZFSnRhWUVYcUlMZnJnQzhaZG5JMWlwWXBR?=
 =?utf-8?B?bUg2OUVTRlJHVSsxdzNzUUtudlVvSTFaK2kvckpya01wMUxUWVZkSlVDZmFB?=
 =?utf-8?B?NWZUTmxNUmgzYm0waGluTVpZYlBSUCtPdmNJL2VjNER1K1h2MnhsUHNrdVpE?=
 =?utf-8?B?RWxKakRJK2FCYzI2Qmk1MG1COCtXWmhOK01wUWlteW5aak94a0lRNldueFFB?=
 =?utf-8?B?Tk5hODFEZFZNbE9WRTd6RVNmbGFmM0xOc2VPOEVsOHhGWG5meGFIa3VjKzJo?=
 =?utf-8?B?RThSYVRpSlZFVDJnc0gxNFZ3cDQycWF6NGorekdqQTI4WDZkTkxWSzN0d1Yr?=
 =?utf-8?B?YzhvK2xDam10ZjVmM1ZxNGw3bkpmTVUxa2NqMWI2cVRTYWxRV2NZY0dERDJz?=
 =?utf-8?B?alFZKzRsMHUxTGZrSEFnUG9lanIwdHhnNkI2YmtxZmtxN2dVcHNHanYybnJj?=
 =?utf-8?B?UUZTelY5ekFrd0ExZkJDTkMxY24wWG1ITWVmOFFXam4vamVuREpVODh5UWhw?=
 =?utf-8?B?eHc3Q0JyYUVqKzhsUnE0R3g5VFhMb1VkcEZ0RkdTWWtsSDk2Q0ZrR2JxcXQ1?=
 =?utf-8?B?V3BVb3RQNkthVDJSWTNzemZOK2RVQm5JU2k5YitZV20vU2NOY3NYdUUyZEVa?=
 =?utf-8?B?Y1RYK2xCZWlocUNCR3RDN24wQ04vbWZhY3BNdW42ajBwek5pWFMycmFiY2NV?=
 =?utf-8?B?UWtIWm9hTUdqamhEd2xYQUxUZU9wWnZlakVuTUNuUXhpNlJCRXQ4SmxGRFVH?=
 =?utf-8?B?bkFyanZwQUVINXZLTDNoWFBXN2I2SElyTmVyL1hwRjZ4WTRENnJrQk9XZjNG?=
 =?utf-8?B?dXVsMWpPUENlMlBqek1penlQSkQvQmIxYU1zVnJpUGZYbXJPOS9oNFlhcnMr?=
 =?utf-8?B?VEtZYXNUYnNHejQrU0F0dXE0Qyt5U0NNY1JJQnFMWUZhY2JlcXIydW9IN0JN?=
 =?utf-8?B?QzNNZFhZb3pzY0NNcm5YMTQ4YzRPTFExbkFpWFVhakQ2SFI1T1QraTZGNGh5?=
 =?utf-8?B?MDE0dk9BQ0F5MkJWdW9xT3BwWFp4dTVwMmtGWnY3SlQzMWpoR0swcWlESFBF?=
 =?utf-8?B?cTFjdFpvempmM21acjk0cE5lMklKNVFtU2RtMmRyLy94elFoZWxqOFRCdjFw?=
 =?utf-8?B?MStZcjdnN2kwbE5MMmNJN2RobUVEMThVVnA5SjFZai9VSEhWZUhQTlNlc1l1?=
 =?utf-8?B?QWM2ZFB6MXh0VUhGL0Vxd2JaUWFyM2s2ZVBFRXJrMGtHME15NmRJNTJXanB3?=
 =?utf-8?B?N1hhQlFCY05Ja0tlT3pNMEMrVXZySE5TRDkrT3cvTkNyL1NmaUkvQkNRandR?=
 =?utf-8?B?Q0ZsNHhEeUF4emYwN1BXQVc1RUF2SnhCR3N5SVkwa0ljdTBGanFhSWt3ZkRV?=
 =?utf-8?B?SmtkT1UyN0tuNXNyeVR6UmFrOG1ScXRSeG5zUjhhN1pmNXM3RmEwNU4yTXpU?=
 =?utf-8?B?Q1BPQ3JoSjBzd2hlWHMzWHc2NmNwRDBFcy9NVEF4YzFHbzBzRklIYWEwSXVx?=
 =?utf-8?B?ZWhrSU5RRVlmNldPdXp2SmJaYUNwQWZ1TldGbjJEa2VwSmZVNk9BSzhVRzVv?=
 =?utf-8?B?T3kwbkg4UjYyNXVGVGpFUFhFWEFZdHRqNFVuLzlwLzFQam1BWmpuSHp3QUZi?=
 =?utf-8?B?UklGMy85c1RvVXJSVm5ZSGNhN1V1YitLQXBrWDFzZkxCUkovNEk3VWZidCtM?=
 =?utf-8?B?ZElkQkx1Q2VqVGlyamNZMVVDc25JTVgrRGJIZjlISGI5aHFsL1VrenZmRHFn?=
 =?utf-8?B?NlhwODBmZ2FKUEtSSEMvMStnMGFSMFRGY2M3M1ZLcGNKeXl4RC9OREVkMy92?=
 =?utf-8?B?aEsrM2NINU9rVDVVMjhjemJRU2dyTVc2ZFVYR1NSYytLNGJSUVlmc1NPOVYy?=
 =?utf-8?B?YkFaa0N5TE1JKzlqcER5bWNmbFR4KzEvMzFwVkNZZiszb01xZ2ZUUnNoMjZw?=
 =?utf-8?B?NThKRGw5WEJxREVqVzdGelVneU94ZXdFLzYxejBZMDNvL2tyNkVTT0pUR0o5?=
 =?utf-8?B?dUUxcFkxemZhNHlja3pQMEZ3aHJtR0N0aFg2aXlZa1dkNFJiWDJsaENCV3Vm?=
 =?utf-8?B?U0xITHMwQ2JZWjI1UmdvNTczbnNKMjlmR3NBVyt3ZCsrdTlpU29zby9zbzZY?=
 =?utf-8?B?VmtNUy9PUHVYbjhPa1JnRFFISmdBRG9DT21jVzA3QUkzZVRBd0pjWnd3OEg5?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c589412-7062-4fb7-439f-08dc5b06d4b6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:40:07.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYSyv+BfUYupgnWrQAQgfWOgq6UjAdJpf/k7/mWujKpixI4pMnFx4f8NcxcYuu+nfhHy4yChcrStfq3Py61npk1xHpTl+CKILxjnLgWd0vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com



On 4/12/2024 2:41 AM, Plachno, Lukasz wrote:
> On 4/12/2024 5:06 AM, Jakub Kicinski wrote:
>> On Thu, 11 Apr 2024 10:38:42 -0700 Tony Nguyen wrote:
>>> +/**
>>> + * ice_set_fdir_vlan_seg
>>> + * @seg: flow segment for programming
>>> + * @ext_masks: masks for additional RX flow fields
>>> + */
>>
>> kerne-doc is not on board (note that we started using the -Wall flag
>> when running the script):

I'll add that in to my checks. Thanks!

>> drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1285: warning: 
>> missing initial short description on line:
>>   * ice_set_fdir_vlan_seg
>> drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1292: warning: No 
>> description found for return value of 'ice_set_fdir_vlan_seg'
> 
> Tony,
> 
> Change below fixes the kernel-doc warnings in case it is okay to amend 
> the commit in your tree.
> If you prefer I will send V9 with fixed comments to list.

I'll update the patch and re-send.

Thanks,
Tony

> Thanks,
> Łukasz
> 
> ---
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c 
> b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index ab3121aee412..e3cab8e98f52 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -1228,7 +1228,7 @@ static bool ice_fdir_vlan_valid(struct device *dev,
>   }
> 
>   /**
> - * ice_set_ether_flow_seg
> + * ice_set_ether_flow_seg - set address and protocol segments for ether 
> flow
>    * @dev: network interface device structure
>    * @seg: flow segment for programming
>    * @eth_spec: mask data from ethtool
> @@ -1282,9 +1282,11 @@ static int ice_set_ether_flow_seg(struct device 
> *dev,
>   }
> 
>   /**
> - * ice_set_fdir_vlan_seg
> + * ice_set_fdir_vlan_seg - set vlan segments for ether flow
>    * @seg: flow segment for programming
>    * @ext_masks: masks for additional RX flow fields
> + *
> + * Return: 0 on success and errno in case of error.
>    */
>   static int
>   ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
> -- 
> 2.34.1

