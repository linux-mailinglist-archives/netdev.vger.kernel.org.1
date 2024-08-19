Return-Path: <netdev+bounces-119663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98808956893
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0C91C209C2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108DB15530B;
	Mon, 19 Aug 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR7vKaTy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460A14B087
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063484; cv=fail; b=nGNhpVrQKL2p4uawUAFBS+TShpVWh1Ead94cE8gWtHYpgs9iz7QgqOTm2RDZ3jXmqKB40JRL9dEranb4DvxKkHpOr0eFGVrHOA/N+9I4mIQfmk6Di6xBfFBSO9A8YO/ZH2ylyj426ozx2eX0o1qMiJyg5tcPE+1SyW75h3m7PKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063484; c=relaxed/simple;
	bh=XvY8+/zan+eINJjE8lzPC0VHpQiy0mFspPOBXyTSJkw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R879820Xl8SkisfDeHsQqvWxsMM+kNU5B8MzXd9dfYzO/GRixp/H581LsHIIl4A0oiPI+BUx+JiE/CJbd/+C9Ujqx72y+UmQyw6zxeimYyDtSszQLwsiVEmta4kq8uY8ok5xt3IjFMBUtmeDCZ56YKZVaRzjm1ak8SFpIeqEYJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR7vKaTy; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724063483; x=1755599483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XvY8+/zan+eINJjE8lzPC0VHpQiy0mFspPOBXyTSJkw=;
  b=DR7vKaTytlFxLhBJxfuXg+hGE+jV5yK+/9Ipg6cQN2Wo19BJYKbCszPo
   J9hA4f0QfWEyvX13ojflJM5awj9ennSj+gtsS8PKNTpirFoWK3O3ITFPF
   Dl7ZS5lZBOnZiwSE9oGyumqjRH5hWL/avHwkuA/QLEGGSBqzjCapU7khY
   ajbHS+1AzOYfhB1LrW0ZR9xfpPaaAL/+vL4BPhHCxUxJ9gAANa/lLwpRh
   k7YctIE7jPnw5oD7jhd8mJGchdpeEz/NnEiC4Sy0opYs5LJ3rQx4tBJlS
   K0K0y8w9UmCoL/cPzulJpNF6LQ89HuFkQBkVI/bbu/ic3EaBVHHRN3EPF
   w==;
X-CSE-ConnectionGUID: n4/i8qEsRFu50rRiKjTCFg==
X-CSE-MsgGUID: U7mcj7wzQ8ufSvndYTNyAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13090726"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13090726"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:31:22 -0700
X-CSE-ConnectionGUID: yyaE2ixkTly9exLbhTK30A==
X-CSE-MsgGUID: 5Ikm1vNXRyi9ZG8cJdPqYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91102265"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 03:31:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 03:31:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 03:31:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 03:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgejKOr+43xZwLMMyC/5m4jO3C6AXkvy7GtiCroKqZo8ezSo0bTmJwY1t4EhAa1cUOrr5phL7xUSOYrGWBYsWXF8gMpnIajMat0hRxDa1YnfbwPYBXKlN6ysh8zA2ssXWpxQ/FIu3ixZe7DO7fopINMrYRjAHcHTRRMYmhiLeIrvT5XCGStsPBgT5c+LEitsqEb+Z+YCeKfRYszLdlyb/8T6YdTqCQL0D6Sgq58JLMu2TVs8Jc12TIj2OuZYH+dWbI1pRK4gQkOzCBCQjBejV/bVDZIoxF6DyXzdGurG/YolNH2urnRsRpTTpnMGLrIhqlMW/nwb54m2dY34m/w9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PRVGDmVk7MNC9JI8zUgkR05VZ2CLqX1GL8iY1o3xAc=;
 b=hllVSD2tcG9VUILCsdEpfzO7+JX1WgG+pg2wEVF6RGFeMj41a5i6gbdYFxrZod3Iuh3m/w29PrjzFJ288k12U8X0oGe1h9iGf29f2byofXk/9ff6tHZiXZYj4/VwjCqATAx/0wdQu4HwNOX5Dnx0KVGql2H3fRVN0l556vdrlNrI0pG1FKsSX7EOSlzFF4nOqD9fXGP8iNH2xOhC1o42td/5PkELDmwgckYoVlJLVSjgzSUeeCL7voWzKr59ad5aruWY+Iz1m0Pr++l5cTAn8gakArA29RCLLqJuHSSrYEFAMMvRv0KEgzLKyCDSf/3a+nsjkaD0ESndWIDaY9NOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 10:31:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:31:19 +0000
Message-ID: <834c72af-09a7-4c73-b318-1be6d8576808@intel.com>
Date: Mon, 19 Aug 2024 12:31:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/9] bnxt_en: Allocate the max bp->irq_tbl
 size for dynamic msix allocation
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
	Hongguang Gao <hongguang.gao@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-9-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240816212832.185379-9-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN0PR11MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b654e8e-7661-483e-612c-08dcc03a103f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1NGa3d4ZFk0WGxCVjdkdHhuN1RBQzhLYjk4RkN0Ni9tYkxXUGRrSTVYTnJO?=
 =?utf-8?B?dzZ3KzNkK0NKSnVpQzRnOVZRK0tKMER0NE1sN1UwY09QVXVHM3NPbm9YZERI?=
 =?utf-8?B?U2wwbDdvNEc2T2laZTNYSzI2VnpiOGhyeW5LSFVTek1mdkVPS2UrZE5uV0JF?=
 =?utf-8?B?MUpaaU5WNDRmS054M3JPaisrQUYvNkVJakl3bzJ0SWVIbDA3R2xqQ1V4Q1p1?=
 =?utf-8?B?eEdOQ0YvSFd3MklCRkEyLzg1SmpQa0NHOTdpNHN0bmFuQk94VWw1Z1lFb3BR?=
 =?utf-8?B?cjc0RFEyYWxVa2VsN2hhMDZNd3c4SHZyekJVNXp0WFdmWUtyUllGWVBoUlkw?=
 =?utf-8?B?bFVXVGU0T1VOQ3RGMm9kUi8rSlRIUjFQR3BJTTkvL2l2S09QN1BibTd1dEF1?=
 =?utf-8?B?UERkUzlQZ29XYlBVa1JKSzJoZjZpRERIclRFSlpCajhjVEluczUwMkFFaFpY?=
 =?utf-8?B?ZWx4Zkl1enhpMHZrVmc4dTJxTEZZRERvSE5JZHdCWWVGWktwallkOHNzZE9h?=
 =?utf-8?B?cDVyZ0hlWXZiOFpMbmlPOG9ITXl2WGVVaU1jK3pOdEtMUTNlSXVSSFlQQ3Bi?=
 =?utf-8?B?aVhTMXlEV3RrZzlPY1ZtWWVYSjNJVE1VWU9aNXozaGEzVVpXL3JIekNQUzdR?=
 =?utf-8?B?NmsvOG5nL2tvSUxDOTRHQWRSR3gxQ0dBUnZaZk9SZ2xydkxBbC9RMTFjR25s?=
 =?utf-8?B?NERHUk5wNVdTaFdSMkgzMVJwMXJwdWtuTnlVL3hqVmx0TWhVdWNEWWQySlF2?=
 =?utf-8?B?clBQRDh1cmlVblFjbUszRGdtSnRWelJJdm9kTmNzR3pSRUhLNEZtMHBrVTI0?=
 =?utf-8?B?RDhpOVlmNHJGQkxhRDdJTStWVWtFMDVmeHgvdlFWTTRJSm9xTk9BMllXaTJU?=
 =?utf-8?B?dEVBWnRiSlgyL0VwRXpBUjNTaHl5SE5hL0o0RGk5TXU5VE50Rk4zUzlydnc2?=
 =?utf-8?B?UnBVMHAvRTN0UVhBQXQxMmpEWHF3ZlQvdU0zT1VXK3ZSeWk1NU55ZkMvY0JH?=
 =?utf-8?B?T2xGeVhtMm11dklLbzJjbDJZNHdhaEsvZzVoblpwNGtadWRQLys3ay8rbmJm?=
 =?utf-8?B?d2NMYUFlWlZiSy9ac3diS3ZmalBHTWt6SGxqUUt1Tm9lbHpHa2FEWm5neUZY?=
 =?utf-8?B?UGlkTlp2NXpUQXVVbXV2cHFpMUNiQW1OQ3huZm9OdlMwT2lvdldTbkQvaTZD?=
 =?utf-8?B?M1dQazVOTXNTNHFsMUF1Y2M3Mmg4Z2hCcStHdGJVNitsWWU3ZGEwaFV4L2dx?=
 =?utf-8?B?UTd3UDg1UW9CSEJzZFF5TzJmcWVGZjRIUE5Eb1I1MHBESEpOZlhtNlNidFdP?=
 =?utf-8?B?OHlPY3Z0UDg4N3l6UU1tT3NpaWRPbUlwVFFFRDljc0QvbnpFaW5HbnBHWCtP?=
 =?utf-8?B?a0pqdDBvejBrZzcrdEdmZ0VNQmZWZUV5cjhnajZTdTZRZ21pb2U4Z2RVUmU2?=
 =?utf-8?B?WmNveVo3OEJwRFh4UWtSVXFlRFVOZXNjWml0S2hIZ1J5ek1GVUYxTmZWUURK?=
 =?utf-8?B?UE5VYU04ODFRZjhEb0dXTjZkYWxhTHRGaWdoM3lFY3czTi9kNGkwOG9ZOUs5?=
 =?utf-8?B?RUppL1BSMWF1eStNV2ZScmhxREpJcHMyT1QzcUlXTXBGcldGQ00wcm4zUGJR?=
 =?utf-8?B?RUNYODUrUkxaMGdhNzI1UjVyY1M0OURwL2FTRGloWk9nbVBBOWpPWnlRK3c0?=
 =?utf-8?B?SGhRWENDVkdSSTRRKy80ajV5MFZSOCtwOU5kRXFpRFlISHdLZzNueCtWT3Mv?=
 =?utf-8?B?aFpET3dBeWdTMHluaGUyU25SQUJPcWg2RlU3NDlZQ0J4QlFKR1o4aUh0Zm1q?=
 =?utf-8?B?QXVmRzVJWVNNRDFja2poUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJrQWk5Y215L2ZmZWlJRFhvd1I0WWhrOVRYSjJDaFJSdnk3UjBxVW02S2Rw?=
 =?utf-8?B?Wm1uUnljL1gydTRuSFZOZzZ0MThlT2pTc0x4SGpjRHFwZEJ0aGRwNlloTnU4?=
 =?utf-8?B?WHYvR0YyUXdYYmhGb1VUa1J6RlhmSEl0TmRqZ29jdFRBOGlqN2FBejhHUzBj?=
 =?utf-8?B?bkFzY1M1UkpTdk5SdXpLeDNSVW1zSUI0TzAxN3hsenpKanI2STEwOFErVklH?=
 =?utf-8?B?OEZieFNVVG9LV1l5K000dkhtK1dwYXlzVTMrZExOdmJrRHdMYlppSHVUaTZN?=
 =?utf-8?B?S3J6cmRsUktKcDJ4aE1YWGZ6ZFQ1dTVqTEFmSU1ocWJ4OHdtd2xsOHhycGpy?=
 =?utf-8?B?Q2JrdjJmdmNDOWUxVjVWekJSd21MNCsxcjQ4ZlhZUjdmMkZuZWthKzltR3Ey?=
 =?utf-8?B?M09pZmNTTUtkQWFvc29zT2h0cUxLeWdtYmd1N0gwMzVSQ2R0ZWtGNjMzQUM1?=
 =?utf-8?B?dk50eHovUkJCYWw3Vkp0RE4zOHRYNlNvMVhvOEVCdjlTakx2YlYweElRRHRD?=
 =?utf-8?B?MCtzSHo4eHBFMnkzK1pZWDVJeGRwcXVwNlljNUR3LzI3aEdwWUpBT2xMS1BM?=
 =?utf-8?B?WW44anpFM2FNTHVxcU5OYjdHQVZjMFlGL2VoVUoxVUFxYWdBSW9pbzlTek9Y?=
 =?utf-8?B?NGNjUU5LaHF6VXYyWnlYQ0lhaXdZYmJURFd1a05YK05PSWZ6aUFiQVJ1UkNj?=
 =?utf-8?B?Uk9zM3hHbXMrNGNnUjk2Z1lob2hDTEpSbS9xRnpRRVJQVjlvUDlHY0FaWWJV?=
 =?utf-8?B?NzJSY3VJNlFXbHhZaFF6WUVUK0ExS3NCT0hSQkpGcm13YSt6WS9LeHpVNW5F?=
 =?utf-8?B?RkNUZWNrV0FWQ2pKU1RBeWZlTHVCcWZZZTVYTE0rNlYvNEQxOXluZUNtWCtJ?=
 =?utf-8?B?VnNZNFhXcHFRaGdHU005NHlFYnVsMjlIS0Q0SXE1Rjd4ZWlseHlsbC9FMHRF?=
 =?utf-8?B?N0VaTUIydzBhRFltTHkxWWdBODltczhYYW14R2N4eFQyUkU2WFg3d051cEhm?=
 =?utf-8?B?aGsveFZzRWJZU2ZlSzMxU01VMmVlejVMU0l4Vldzem9xRlRzL0sra3hpdTdl?=
 =?utf-8?B?ZVkxNytwZ2E4dUpXMkdvWUdaM0ZYRnJRNXJYYlM3cGFLNHRaVHNlbkJRRTc3?=
 =?utf-8?B?bzZaV0lIKzBkMjhDVkJINTBmcFZYUTYvdUpDZG55ZE5TdzF4VFRjNXQ1M1hR?=
 =?utf-8?B?c0NHcTBZK1JyYS91VDRtM3pDTWFsOVVza01uL3N1TTJ3VSthUkYva00vZmpY?=
 =?utf-8?B?enpOVC9hUFY5djVVcExYN0JFTGQ2K2NIbVMwd0RnZEhGbHovNjRNSWszdnFT?=
 =?utf-8?B?UkQ1SEJzRWEvZXVuQjV2VkxTbWttTzdidzUxdTJ4cjhJWXRnWkFxbWl1ZmFH?=
 =?utf-8?B?Y0VIa2N3eTVkamJPWlRIL3doaEU0Mk5aSG52cjBxWWhnaHlxbS9hTUJiVS9w?=
 =?utf-8?B?RXlvRE5ZQ0syL2VyckVXN3V2YXRsL05OVVJvR3kyTFU3Y0lrWlcydTI0czh1?=
 =?utf-8?B?S0hnSUxFSFBKSE1aVmYxY0xTSmZDanlnam5GTlRyUXVpTVM1bGdpZnlxMERu?=
 =?utf-8?B?L2lEaXNFQlFuTkhvK3gyZ3VyTnFmS0g3c1ZFenI5RlRDc1B4ZVVGRVY5eWRk?=
 =?utf-8?B?TFVZRGNNbFg2clZZQ3NiUzVEbDhvenROT09lSXNPdmFQTG5SQUtNUml6T2FZ?=
 =?utf-8?B?V3RrSms4SUJSK2E0MjFmL1hyU1c5TUs3WS9lQWhLOGFENjNpa3FGY2dZTTR4?=
 =?utf-8?B?ZjJFSFZYUHdTdWtWUXVNWTgxWWdNYmdReUJueHd0b3p0eUdQWHZQZXVDakZr?=
 =?utf-8?B?bW1vZndGY1VVK29ldGRzQk1qb0M5TDZMK3YyMGRoSThVK2Z3aVRXRnE1d2Fw?=
 =?utf-8?B?anRPK1lIL1NEMXVYdlU0aXlHUFlQSGVBbFhkSGJrUDBENGFld0V6T0E0enM2?=
 =?utf-8?B?WU9KNTF1ajN5U2hlL1lLYXArMDhXeU03dkphVFlYNTVtYzZaQVc4cEVyVHlS?=
 =?utf-8?B?ZVkra1djQkpGMkdVVHkwNTlGMllIaGk4OGNDREt4RnBja0IrYmhvN21US2or?=
 =?utf-8?B?U0VYVXhXci9vRjZ5Ly8yRUZuYWc2SWxRNUh0Rzl4QXNRRlp6ZnUwd0hHdWdl?=
 =?utf-8?B?aGJpNzBhMU9VOEE2MDJzckJxRmYwV0o3TS80Y0xJRS80NGNjQkpFUjh2T1Zz?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b654e8e-7661-483e-612c-08dcc03a103f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:31:19.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7d4B1zrho6jmHpVoRLPO0tkBUdA8aR3jlZsujGKKgbVegdSg8FJSo3dg1Z2F+hdTtZYpxNoRipXvv3jXTHU1OzDKF3bFrF+l7CbQSgXMiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com

On 8/16/24 23:28, Michael Chan wrote:
> If dynamic MSIX allocation is supported, additional MSIX can be
> allocated at run-time without reinitializing the existing MSIX entries.
> The first step to support this dynamic scheme is to allocate a large
> enough bp->irq_tbl if dynamic allocation is supported.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Fix typo in changelog
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 5d0d40d78c37..b969ace6b4d1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -10724,7 +10724,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
>   
>   static int bnxt_init_int_mode(struct bnxt *bp)
>   {
> -	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
> +	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp, tbl_size;
>   
>   	total_vecs = bnxt_get_num_msix(bp);
>   	max = bnxt_get_max_func_irqs(bp);
> @@ -10745,7 +10745,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
>   		goto msix_setup_exit;
>   	}
>   
> -	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
> +	tbl_size = total_vecs;
> +	if (pci_msix_can_alloc_dyn(bp->pdev))
> +		tbl_size = max;
> +	bp->irq_tbl = kcalloc(tbl_size, sizeof(struct bnxt_irq), GFP_KERNEL);

sizeof(*bp->irq_tbl)

but otherwise this is fine, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   	if (bp->irq_tbl) {
>   		for (i = 0; i < total_vecs; i++)
>   			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);

