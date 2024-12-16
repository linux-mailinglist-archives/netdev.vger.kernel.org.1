Return-Path: <netdev+bounces-152198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDE9F3141
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16971888324
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACE205ACB;
	Mon, 16 Dec 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y88XVLyg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3A205512;
	Mon, 16 Dec 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354496; cv=fail; b=F70Wk+3m0p92wBRKeDsQJyNToGW5Z4pCo4W/tStMCAAImPGSvA5UjRnAK7LY1YFmouIaFWJH2h7DYtNh6mh2o5lwUVjROJNWfltxT3c83SZyNXHgUnTVkgfyiuxIyX3nc32A8QxaLtdvC4o1GXHedkOwk4882rMZ1014VE9iiLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354496; c=relaxed/simple;
	bh=bivuockByRtxsPidm39lT2x+sD8LJwH24bG5dLTV4lM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GvNn+0w7i/C/obM8mgbPLxPYqZNxNvMbW51tx5E4F9SdnR+bTlWG1AHkGJCAYHsaY7XIucWD8jjy83K4nzlM2bPUsVXPaYIc15ybs5+9ZxQEGUFFrtsmDNYvsNOEeyIIO4qpgOAhfc3XIBWDG5V3pWDdykLLGFohztmR8KqnqD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y88XVLyg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734354495; x=1765890495;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bivuockByRtxsPidm39lT2x+sD8LJwH24bG5dLTV4lM=;
  b=Y88XVLygPBBTDnZU/j30He8f3+tIw2BGTrEyzJKLjyim5JS9R0w96opN
   MaSptO+b2Ohzyl23RX7jIa/kBJZuIpKbhSdNeNyJogpp7ZfwEqbFFOcfZ
   tNTaDmY4hj0al60Gcv8+E0ceaM+JWQLIes+lc1BOcJ+hyIuxJGQ/WQrC6
   0rUzETnEWSPZYVHZjaAFzAnGCLgfHVvEefSUtIT4ydCiudhtIQzacSWiu
   XlHARc6F3++BIZbCtwIqSqOTAtpZOiI/PuZ3S48+v2Su1Szy0wWX6FLn3
   UFoVuKLPQTHTbE5/awwFjeQZvcfma9E3WkJBehfaT6SjptGqeGlNn5ni2
   A==;
X-CSE-ConnectionGUID: g09FfI1xSLKl8W0X/zqOTg==
X-CSE-MsgGUID: kw7YuWwKRD6OF2qKKJlU6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45740851"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45740851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:08:14 -0800
X-CSE-ConnectionGUID: iRtjjNuSQpqMTqTF1Ylx0A==
X-CSE-MsgGUID: y/SCgsKxSBCfbvCJwGc/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97622602"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 05:08:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 05:08:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 05:08:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 05:08:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atxP+8dwqoHS8rZ41VbLlGV/Rhki/ybAai0WZ79dg88uDs7VMQteXVOsbwuCUWnLJ7f3t+9qHIkGm3IN7lROe3gG74XaU51LDiGM47c97l6O27kq0jikcWjL8Am59/ZXhfxSV99kGhHqIOGyR4WpNk1iA+BTszulU8FcoS/5lBaHtiThvhY8be67cyYA5TY89YsWwvpjkdScqrXz5QPL3LKSCrM8CPzyjXcZTcNWZI37ZLCpKrYxVLMKSCE/EbLVOYX/FvThGrj2Cp/QId1ppr1gXmt12H1clCT7qoRNtK4dVVoeWedXieIHsMvX2wo6ooQyOMz+k18HUo+bnchJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsk8SgpN8mIsgXN7fc4JbXHURlHiyFFazbCwyLCUdQs=;
 b=eokcek61cpgDvfPUlYNlghFcyhoC/IIeirZSS5p0AfHaYRYSHjP6m080/Y7LisorW5LQnsywr3KYLgGOEcvrz6A9lzQINkJrn7vUgRPCLps6xOicOUUG6SuX2uclUQMN9IGh5rIquX9qME1lm+fhZqrZKqMC8xMmU8BQF4voD/ArK6807c/+jhB+BkV180wdCQ7NMz2WL1OngLO4d3ATlM+RISKUwxwbH+SbKO6M+AmY1tH7ZJ3ThoXDmJgbOLdVh7ZS0MKt9r5JEfFm0kSoXtJH3A24zCNQrfc07OlZ55RcqO+z7Nt94uWI4If0lXucOXfpW9zj1ygGda7Vn7Q9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:07:43 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:07:43 +0000
Message-ID: <c7ddac7d-debc-44eb-9c43-7746ad3edb55@intel.com>
Date: Mon, 16 Dec 2024 14:07:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/6] net: usb: lan78xx: Add error handling to
 lan78xx_get_regs
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, Phil Elwell
	<phil@raspberrypi.org>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
 <20241216120941.1690908-2-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241216120941.1690908-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|LV3PR11MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd56a52-0ee3-4e23-0294-08dd1dd2a09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlI2eDRsTTFWdmk1eXVkVkNJLzRzOHI1NFVQYzVFblMrUXNac2lWZGpOWmY0?=
 =?utf-8?B?ZFQ4dGZteE9iMjVWaDFPYm1lMURCcHBuTEs4b256alF1d290MysyWGpTYzNW?=
 =?utf-8?B?b3MvUFE3bW1YK2xPTnRSdFFpSkpCOHlyZlBEaFYvNUQwRTlnVlp4SFRVdTRV?=
 =?utf-8?B?cXhjSWtNNU1mYU1zWlM2cWtteVVKQXJmNlpRSzcxemNYZUpWV2xaeHBpZXli?=
 =?utf-8?B?N2VZeG5raTl0Q0NFWEpEYXJmQlVibW80R1dzWm5EOHFKdlBaalhadkpnSlAy?=
 =?utf-8?B?MUlzRkJWQ2hZQmVraDlCT2lPQjV4VHdRYkhPczFGUnllemtVNXJZNU9XSzEw?=
 =?utf-8?B?VGNXNStiWGdzN1liMUJ1bjJBbDgvbUhQM3ZwakRQV0F6Z0dVQS82cGRNZHFD?=
 =?utf-8?B?OUozZ0tXUEJkNmU3UWY0TTVja3A4YTFjZUNkT21TUEJBeUVkcDl3Q1Ftbmdp?=
 =?utf-8?B?UERKTHBLa1ZmcTAwNVpXc0JaSnM0UkE1VXQ2YTMyeEp3Tm5taUExSDJ2R1Iv?=
 =?utf-8?B?a0tkRFZKV2pqc3F2WlFubjl0R3dXL0pNckMzc090WFA1K21vK2NTR0FjbWpQ?=
 =?utf-8?B?dU1IMElaRFVVNTBiWG9uMFB3TE5DKzVZQlJBQXRYbzBCMnFNWGowR0h2Y1M5?=
 =?utf-8?B?QWN1eG5CZHIvV2Y1RUxlTmhZeGRCMjlNeHBkanlVM2ZPUUlHeFM4TW03aURn?=
 =?utf-8?B?N2t1NndsUVVUQjNNRWNhSEJzWlF6Q0tzNkJrVzcrRG1xTTBBK3NrTjNSV0t1?=
 =?utf-8?B?cjBWdjZ0UmVhVG9qOU9xZDJQUkw3U3RHZCtIZitLUUNmU0JMRnN5TjJhQ01Z?=
 =?utf-8?B?TklKazE0WjRTeXhQc0F1ZUlKZzd2T1l2VnV2V2svN250dHlJb0RNb3BpbVBD?=
 =?utf-8?B?amlvU1VPVkVKdTBXeVI3dUxhdXFxSEpzZ24yODZOSUlpSis0ajhsYXZoSWRl?=
 =?utf-8?B?QjVrRUp3NWo5WEVHQXcvZEh1WlA0WEx5ek5jQ3c2WmJsa3BuL2M1VUd2NVJ5?=
 =?utf-8?B?cjNVakhsT0F1NzdhaWNhUVF4Nkk1NUJjQkpTMWlEV2dxMWtRczRUbzZSOUFJ?=
 =?utf-8?B?RGtjeU9QazF2QXYxSUE4dFEyOFhSMlgwQW55Nm1hV2dTaStXQ2pOa3hwWlZl?=
 =?utf-8?B?U0cvQlZCeGU1VkpiT2JCOVdMMlRabzlCVEMyeXI2ZkRhb1hKYXpEZ1BqeS9I?=
 =?utf-8?B?MjhZTkNQVjA4RlFaaEM0RUczMmcyeEJxN2lPeXAzaCtJa2ZyNWxHQzFCWTRm?=
 =?utf-8?B?MklBYmpDR3dickJVUDUvZVJoR1NzMnV5Z1JOM0JxU1JnUnpmeWhGTG5Oa0th?=
 =?utf-8?B?MzY3dTJHYzZDWElzUExkaU15TWUvbWIvRytad1k5M3RTRHZxSTlBQXpuaCtu?=
 =?utf-8?B?TWc3UFJ2T3AyajZubEFFak1rZDQxN3dDbGY2U1VzVUN0dDJ4YkE3M09HR2pL?=
 =?utf-8?B?dmpuOWZnQUQyc24xaStvNHdqcm5YU0xEd0FiQ2cwY1JIZEF5MFRXUjFGRElG?=
 =?utf-8?B?QU9MNTVTVVRQRHZGUGRUb0tjMy84akQvTXJrZEhid1V4aUdIaytXNUJVUHNr?=
 =?utf-8?B?d3d4bnM3enkyYWRaN1IrZlExNEMzZHVQT1kxQnRRMlVpWkJ5eG41YTU4UUln?=
 =?utf-8?B?a0Q4OUI3ZGJqb0FQUXg2MU8zdGIzN1VXMjV5R1lWTXF6Wm5SZ3UzTzNQam5G?=
 =?utf-8?B?OFVTTW5iT3plQmI1amRoNlZVVW0rUWpic09YUkVwY2FFRmI5eFh5ejZzNUo0?=
 =?utf-8?B?dHJkRUhqMHk0dGkwTnRqTkRaV2FCR2M1SWt4WjJQOWovR1BnVlZDRTZGNEhJ?=
 =?utf-8?B?Q293V3poSWUxWEtIVEVwUXVTekIyeWk5eGpOUE9UNkxuR042ZmtGR1IrRmZF?=
 =?utf-8?Q?T4AR+GjAYnMOq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpCZG9tUzU1aXNoSWJ4ZTVyT1kySjc0QkF5UUw5QUhLZ3JHazVoMnhQMXJo?=
 =?utf-8?B?c1IyQ1B6cjZBbWo1dVl4TmVqQUpGclVOQjFONmJBSVJ5cHEvSnJQTVdqR0ZH?=
 =?utf-8?B?OVU3UUJvbE56bjJBd002N0FZamJhdVMrVTR4Y1c2azRCbjdnaG9YYndXUWNL?=
 =?utf-8?B?SzVFdXJtSTBuNzJGZ2FaTDJUTGdLNzVmODM3NGZIK20ySmFVeTlNRmxBYnow?=
 =?utf-8?B?VEFpdzBLWlA2SVVyeDRVNEJTdFZzS0JXeFh4VktqajdpUGFaOEt5aTZJMjgr?=
 =?utf-8?B?R1dqcCtqdVVFMHNFOXJpQVRYSjBrSUlqdnlXbmZON2VUd1RBVWZVUklEMFUx?=
 =?utf-8?B?N2drUFo5VXFGU090WTBvdjNSSSt6UkI5K3BRODE0YmhYbWRUa241WFlacjAx?=
 =?utf-8?B?QTJBRWRsQTM3c3JETVY2RytLNmQxVCtYSG9ZVEVJQUNhYVRzeUVoU1ZQWXAx?=
 =?utf-8?B?dUhMTUx6WmRYK2h5enBCd0VqczVkSzRhUkpCMSthV2IwWlRoZmJlcGZhSG9N?=
 =?utf-8?B?RkU3MjhMS1dXbkdJV05iN0JHWklTeWxHTzdFYW5sRlFFUEpXdmhRcytpSm5D?=
 =?utf-8?B?dmcxTnNkOWVrV2RxZXB2NVdCYXRtNGtPVC95a0QzZmRTUEhxNGI2TjlZdHhX?=
 =?utf-8?B?WncxNnlhdkFIaVBNbVA1NlZBN3FiNjBLbldsOTRZaU9uMTFCaWY1d2FzOGdO?=
 =?utf-8?B?TUdLUGJ1dlRkbXlDd3oyeTFYKzMwMkVEWEhBTW9QTC9CMnJ0VUw2UFlzQk1v?=
 =?utf-8?B?aE03cnRaQm1KbjZwY1Fnb1dVaEozWEZjVDIxZFg2TDZGdmltcE15eWdGT1Zu?=
 =?utf-8?B?Nk5xOWcraVdzcHIxWHkzM2xqK1BlaXhPa1kvY1JHMzhJM3R5czl2SUd3TCtR?=
 =?utf-8?B?RTNhU2x0Y0l4RVRzd1RXdmVZbWxhcUpoWnJYYXBOZlF3cDUwZWRFeWdPdEds?=
 =?utf-8?B?Skxia1hnQy92Vkk5VkUwNkI2VGFjS0NHS2hsQUFUV0FzSU9UQlgxaFBSYnZy?=
 =?utf-8?B?WVFRUzFUZ2RBUnRkUnRmaFVnZ1JyUWkrd0x6YnQ4NTBZS1pSTTBHVDRZT2w2?=
 =?utf-8?B?V1Z0cHFFNDg4bmRWL3VMdlYvdWc0anU3L2VnWGNPTzlBQWdONlF1WkE3Y3lC?=
 =?utf-8?B?eXVab2QzSzVuR2M3eUh6QTNORTh5ODBwVXJsaUIwSThkWUdtVDJKU1YxL2xn?=
 =?utf-8?B?OGhpVlk4VFBmZjB4ZHV2YkJLTU9seXBSNTcvS2tlRnF4b21QTXJUVHZSS3hX?=
 =?utf-8?B?T3RzSWFOUGRWVzR4VmlFSWhqVDhReWR2UlVEcjI4VnkzQ1o2Ky9kTUlxZTBS?=
 =?utf-8?B?aVhwMHJKV3NxdXBPTXpvUzdSVEg0bkVsMnZQSDhDYlRPVGZOUmNXY1QrZ0My?=
 =?utf-8?B?Zkg3eHF3Z0pFTlF2bEdyZ2tXQWtxOXR5anpkeC92MHdaRlpKMGhhODNIUUI3?=
 =?utf-8?B?aVc2aytrUHpmTnE2bis4eTVwTSszQ3prVEhrUlZCOUxIbFZvNC9xYXdlSUdr?=
 =?utf-8?B?M05jWTBlamwvQ0dLdnhPVlIrc1Y4ZzFlQmtCWHFUVkhlZ3FTc2tnb3NQcXlm?=
 =?utf-8?B?alNvK2p2Rmk1Znd0U0xJbVZnbFlpMmZmUXNGM1VILzVjSm1DZVBaR2M5bGVw?=
 =?utf-8?B?WWY4SkhGNEtKSUtMZEEwNU5OQ3dEYllaMFBGOFU1aXIvVWJGa0R3cnhVb3Zr?=
 =?utf-8?B?dmJvTnhPanJ2VVFrakl3eHZJRVkyZyszbDhzbjJzdERyWTdOQW9Ha2s0bURu?=
 =?utf-8?B?SFd2OThPUmlEczVmVU94TnZkWHhxUjN0bGNRRjNwdnBDelJKUGwwUlRvcEVN?=
 =?utf-8?B?eTJyOUVWdWpFV0VHNmxFcVlSc3c3NVVobDlwTHNOUkFBbWg4WnhiVDhTWTFh?=
 =?utf-8?B?elVvMjU4amdRMmZDRndneFlpTzNUbUFVVWVGRGozREN6eXFKRXVDZngrOEJW?=
 =?utf-8?B?YXRFbmZrbHJmMVQwR2FmZjI3V21IWm5laktONXlWRERJUGY2ckNLSExDQzl0?=
 =?utf-8?B?aU4xTDVZL1lIS2hNZmtuYUZYMVNHU2hMRmY1a3BuUXdUR0RRSkY1UjkvNkc4?=
 =?utf-8?B?UHR5TllldWxNdjJHd24rcWVxL2tZdVRmb0thOWx4VGNEcUc5WmtHNC9KK3VP?=
 =?utf-8?B?K0JJM0NJUDA2Nlcrc3dYdXAxUFlMMWNNUnlEdkQ2TVpwcWZZc3hSMnRCNDBS?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd56a52-0ee3-4e23-0294-08dd1dd2a09f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:07:43.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRSusOd7x4yjeY9N9nonZTXCPPfCnZXPA8/N/cs61F7g/FcQ4Ud2RIx0dBfhopJK1VhzeUAYAgOqw+Vy7l3W2ztyfPhZiayAp9aRXxf9wsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506
X-OriginatorOrg: intel.com



On 12/16/2024 1:09 PM, Oleksij Rempel wrote:
> Update `lan78xx_get_regs` to handle errors during register and PHY
> reads. Log warnings for failed reads and exit the function early if an
> error occurs. Drop all previously logged registers to signal
> inconsistent readings to the user space. This ensures that invalid data
> is not returned to users.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/usb/lan78xx.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 4661d131b190..270345fcad65 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2108,20 +2108,44 @@ static void
>   lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>   		 void *buf)
>   {
> -	u32 *data = buf;
> -	int i, j;
>   	struct lan78xx_net *dev = netdev_priv(netdev);
> +	unsigned int data_count = 0;
> +	u32 *data = buf;
> +	int i, j, ret;
>   
>   	/* Read Device/MAC registers */
> -	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++)
> -		lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
> +	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++) {
> +		ret = lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
> +		if (ret < 0) {
> +			netdev_warn(dev->net,
> +				    "failed to read register 0x%08x\n",
> +				    lan78xx_regs[i]);
> +			goto clean_data;
> +		}
> +
> +		data_count++;
> +	}
>   
>   	if (!netdev->phydev)
>   		return;
>   
>   	/* Read PHY registers */
> -	for (j = 0; j < 32; i++, j++)
> -		data[i] = phy_read(netdev->phydev, j);
> +	for (j = 0; j < 32; i++, j++) {

Maybe during this refactor is it worth to add some #define with
number of registers to be read?

> +		ret = phy_read(netdev->phydev, j);
> +		if (ret < 0) {
> +			netdev_warn(dev->net,
> +				    "failed to read PHY register 0x%02x\n", j);
> +			goto clean_data;
> +		}
> +
> +		data[i] = ret;
> +		data_count++;
> +	}
> +
> +	return;
> +
> +clean_data:
> +	memset(data, 0, data_count * sizeof(u32));
>   }
>   
>   static const struct ethtool_ops lan78xx_ethtool_ops = {


