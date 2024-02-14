Return-Path: <netdev+bounces-71837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A785544D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE20285446
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E113B785;
	Wed, 14 Feb 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QH/UmNRR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48931B7E2
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943711; cv=fail; b=n3dL6isV57EqbCQyeRZbviY54w9fC1x4S9+5WxHoiJUVvTetMbEL8fVGBuzHvyeRzejoDpwCDkWeu6qj1FBYg6PDAPXPmuns6t5NxqsHqwR1PIWyPEO8ojb3Ohj7ZSrzpjAXnGvFPBQh2Aeo3ioEZZD1aTbdvFfPRSbOCrMiDEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943711; c=relaxed/simple;
	bh=gy0iysc5Da9R0DB4N/I2bqAEIU6fDGI+UDTLHiVvtiU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jdt3cC0rGIWEFspafaaBHoAXKgA91r6EoWU+OhWujmDZzmOrclcYBzmSqEZU5rmYAeoJhqYSsjA0bI9UKliiJLzagS0iYeXOEeRBD23leOIRFsMjtlNrq0VjsvQPQXRoPeIbPH8ByYbraO4Bl3FmYj3GuJn+q24D/e8Ob0+kbqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QH/UmNRR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707943710; x=1739479710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gy0iysc5Da9R0DB4N/I2bqAEIU6fDGI+UDTLHiVvtiU=;
  b=QH/UmNRR8xlI7Dfwjb874IIiq8PuIDdtBDYNyze3hnJ/DAUXvFWYo01Z
   pkX9cpMAWj16dWYoVlIsFls32A4InxSJuqEOi4B1vaaYXMpNC/AKcD70C
   qkZgwfYLgfwpeUWDYJvAfNHOC77ZCn/TS1B3FKRYk4+IirQ20ZVyiXGPo
   GLCQoS24K6rJfVgwaMC62vj7ZDlnoltjo23LabZvxeltz9ZhxvDxt0C9t
   v9o5oZS+NP99YQYKULNdIb842eOXtxruIw8bLgZ68T9lnOA6nxOzQvGLs
   6LyD3mIgA++yBG75UwVeMOPMj6CxVhpNAtorkXCtkHMCcUonlMovnt2ad
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1922194"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1922194"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="8060794"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:48:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:48:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:48:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:48:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuE74pNZoLxkdIKYDegYfhjMVPaav/FwNjwTYWR4HvY2FXm1dtR3n2+JWs+K3oY3Tvy82fD9FjvLDUSrw7q24KNDraN6SjhBe41BLcgiDZ3zqm7wV29H6+GmAB02L62caGJPo5Bc7i+5qnuJuFuiE8hjb3iMiJiEalLUEvRxncQxQ7AD5WV4CvN3RnuNPD4WnLwhI4OW3/mDKzyfH7VaqpIX8Irh7Z+VnSp4vikk8omYlQQ88mGd+fE4Otg1DG8CIV9bP6EwQJL6Je0H3+ELqIDvF8PN++Vf3NQJ/fpVkHU66hpJsY5K5RUAGPsNsesTrSkmh7cPkbYbozSZ8DxyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzfc/eAvI3Of2h7RNgadH4b+39IDIc4as2FvkxKgoFE=;
 b=hMjq07ckprHrsJiAqixmGhKmnW/Si8LEzyYAvA64jb6yzd+Z2RmVwBMWl1/rWzVdotEfn9ArL7/GeMCsU2Wqmv4iKfzRzeIJGafzXW5J/o4zFXkSLUcjAHKPNcfseFt/dJUi9mvotYLcem2amCauISJp28H4eEbP6wmTBTguWXI+svkpNGne53qOh/19hkHXtTCT2/Yp9BUKW7Sa0C8EDyasOekd6U6Bt+huNJFTzCdfyDfCGQfiNJqWp76KLbBQDn5foLAlpHehvSM1Bjx0pKgcFyZe4ErXxEV+TQAiLqniTsyrTSgzWriviWxqrmoFS0GNtmzgXWo0wm/eu/0KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5410.namprd11.prod.outlook.com (2603:10b6:610:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 20:48:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:48:24 +0000
Message-ID: <ceca2088-10c2-4a7e-ac4f-50a5338187ac@intel.com>
Date: Wed, 14 Feb 2024 12:48:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] bnx2x: Fix error recovering in switch
 configuration
Content-Language: en-US
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <manishc@marvell.com>,
	<pabeni@redhat.com>, <skalluru@marvell.com>, <simon.horman@corigine.com>,
	<edumazet@google.com>, <VENKATA.SAI.DUGGI@ibm.com>, <drc@linux.vnet.ibm.com>,
	<abdhalee@in.ibm.com>
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 168a4521-c381-44d1-c7b1-08dc2d9e4990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vhf5QjX1fWJ+lucIssQ5noCG2IHpJwAUAdatacWjyVrEh2Hft4ng5ogZDn6ntUMQGV3eRC2BQbVnfASh5rHSi6MRQCXIiuo0h1P9OBlWxO0/nT25DHPkpqBxsFv5S0nAsZ0A6Qur53R73ExbsLgtkfEiwt3iN2qEnWBTqgU2uM/zdvJC+ooum+dxExzm81fdbSGI+SXDHi2b47ZSMXxEDon0FeoWVdViZAcir++vRxNPgYDvnROi/Ha2g1DMCLjKJhbSUp14nSZz4nQMUydbaiIXxrOOyv/A99gUoxW/FaFQbjfYvF/lO4mv/lXuG8X6+ktcWNE63kFtOJTb5sIrLoi5rXEzSIWNcf6zJaKv0o787bAl3jWol7DdmC9gPT9RAJRtlBryYAm0uohIb1Gmx6+NodSKEJ7nl25307n0BTDVX7IgEy+x9r0CVWxO9K1Z5D1Bpccqpb7vehCtZanytNrZmD0+77+vWW3tQq0vX/+F68ThBc+fV74VfrdAXqcYU8emqB7vO2Op4B5ulMGZTp9WJcmVCqZENiALD1+lSZJPMMntKajdTaZkyWye4F8IRN8SaoCEjCdOJnpF+MfCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(26005)(2616005)(38100700002)(4326008)(7416002)(8936002)(8676002)(66556008)(66946007)(2906002)(66476007)(966005)(6506007)(6512007)(478600001)(6486002)(82960400001)(41300700001)(53546011)(316002)(36756003)(5660300002)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpoeFVUc2x3Z2ZyYXhWK2RjZk95SUNTZ1dBN2tZa2YwMTV5UThLTktDUFRZ?=
 =?utf-8?B?UFRZc3IrOFRMZU5FTkRGdGFabjdzVXMzVFlZelRlc3cybVIxY0h1TnN0eG5T?=
 =?utf-8?B?VkVQKzhzRUxvdWk2blpZRllHazdIZnIwWnFDbnZiaEhCYzQ4S2RBUXBZM2ta?=
 =?utf-8?B?UlFzRTUvWlc2bHhoUTdoMnpmdlRmRGRBTEQ3WVJyMjh5WSt6LzZWN1NoRHNl?=
 =?utf-8?B?ZnZiYmNwRi9xSmN3Sm9neFFlS3pLeERKTG9SNlROcGk4Q1p5djR3clFaRFV6?=
 =?utf-8?B?TkRudmtEMHZvTm9BUlN4N29idGJqL2xZaGFkOVZUWFBwOGhJbW4vODJLdzF5?=
 =?utf-8?B?S2hrNEVSSmJjemthZXI4eG91WndzM2pOd3dtVkhJcUF5RzYzR2w5STR6eDZF?=
 =?utf-8?B?aTdHYjhvYzZXMXE4a2lPa1hxb2FXbDZpOVk3RlAyRUlLWHJqTCtFazRLbmR5?=
 =?utf-8?B?dFNKZW90RnNCSVRIbmh2a3RLVFhJcUdDN3VZUlBpWGo2UFFIdndiV2FJaXVv?=
 =?utf-8?B?WFFrOWRkaTF6dkE1cExoU08xTkJDYjZVUjNtcVozTGEzSjhhSGU4aEU2OWQz?=
 =?utf-8?B?ald3WXc0dTNsaVJXa0pxd3BZOGxmazdVaEdkNTdyQnhucHltNFIwN2tCSUFY?=
 =?utf-8?B?T3M1WEI4NllPdWNIdXd6dVlPR1JMV0RKRUtHN2UyVWczaGpMZUxsNGMvbWln?=
 =?utf-8?B?Z2xQREJwZHVqSXVjWHZCOVZXbWp3S3lyeWhIdytxWUY4cXpZa1lOSDlHUGFU?=
 =?utf-8?B?NzdHRzhtZXA5TEZFeFhFZ1crSGdqak9URGU0N2YwV1I4a2EzaDY0VEFpRlA3?=
 =?utf-8?B?d2pLdzJVVDJ0ejZBZjhGVDBxakRNUXF5ZWsrMUVtWXJYU0c3SzUvbkNPeU5y?=
 =?utf-8?B?QUNDS1prdisrZFIzM1I3RmZNSDRiSTVxVnE2NkRzTTlwaU1IcDAzUTRJcHYz?=
 =?utf-8?B?V2dOMGNQYWdtUnlCcGxtMVB3S3c4dU9zRUVUdWN1Q2kvOTRLTXZNaHdoRXNS?=
 =?utf-8?B?cWVzeVpKTUdSamV6TVcxNlpZRlYzOGFzWklXU0RBQjVrSmwxM1lQMGlLWVFL?=
 =?utf-8?B?YzE1SFZqbVdlVE1rb1ZVSk42TEVWNnY1TVhVbnVEL1ZNdHdXM0VtL2NMZmd6?=
 =?utf-8?B?MllhNklGcE9UWDhTVGgySnVsRVNMeGxQRUFPWllPMmpZSC96RXN0T3p6VmJU?=
 =?utf-8?B?bFlDL0RRT0R4T0ozUXhudE8zY2FvelQ4dEJId3E4b3ppR2J1Z1QrelM1Q3la?=
 =?utf-8?B?eHRHZVJHQ0tmU0lZeDROSGRacGk0WU45OGFNZGJ2NnN3cnFiWkRUZ3NJUC9i?=
 =?utf-8?B?SFlOVU1KU1FuNWg0TTJOWHlCNDlxZVVVY0RIN3k3eVRucXM1WmNMQmlCYTU2?=
 =?utf-8?B?N2IrV2hhZnhkNHlFZGpuQlpnenNkdkFsQjkvWXE1Y0l2VmNpRG51ajFDZUZB?=
 =?utf-8?B?M0w5ZDh6enVJWU1sN0NiendQM21qekwxS1dYZEJCVlRRNEZDRkVSazhIMlNC?=
 =?utf-8?B?bHRUVi9DNVRXM1puTWJlU1Z4elJOUmhqclpZQUg5ZG9qSGtKclpvTElva3F2?=
 =?utf-8?B?disrQjRQWDE4SGYwRVF6L3FwdjFtdjFpQXpJR0g5Q2pjTWNLMGx4NnR6angz?=
 =?utf-8?B?WkZVZlI2dUg5ZG5NaVozRG5pWTdyeXNyZ0pwU2tMWFNCVng3aDJJV0loZGpO?=
 =?utf-8?B?eE1KTzBxVG81aHZBaCs5V1FzRm5ZcmRsN0dia2k2U215K3BYeDdUSGhDcHBl?=
 =?utf-8?B?ZGQxZ2REREMvOTBDS1hEM0dYbS93VHViSkU1RDRGQ0h6c082eFdWOUcxRFVZ?=
 =?utf-8?B?UHU5clRmb0I1dkgrbnJENUtsd1c5UmlpT0tOWGdOaDVpSHRiMG1DSmMwZjlz?=
 =?utf-8?B?S0NYeit2c1F6eDd6TmpOd2hDb1VNNGNMYnNPd0NWTk0raG9BbTdvZkJrYW9i?=
 =?utf-8?B?RDU4aUVHWlV3a2g0dlRlaXR2RXJjeUttcHlYejFXQyszcGkwZFgzRGJuTnlK?=
 =?utf-8?B?NURDOUEwOTlPdGNLU0t0SnNkdHUyTm5aN3pVdU5MOW5zOHBzQk1aczlGTFBN?=
 =?utf-8?B?Z3k4b0tnRW14NG8yTUovTVNaSmEzQnh6Q1d5Y1pmUFdsaDRGVy80S04xa25k?=
 =?utf-8?B?UjdQR0daMmdFem02QUZlSkVwbk1LUllVeDk2N3ZTd3V4S0RpQlgrZGtlS3F4?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 168a4521-c381-44d1-c7b1-08dc2d9e4990
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:48:24.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0ghr+gXYGiiCoSrjCwOERWRjjd3mAYRBO8Mxj27PnhJEkEvfbSUKKHMDpnytzlM6d+oXoROpVxacY+7FhWuz7Pdk7aoEF0dDfk8JT6UJ6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5410
X-OriginatorOrg: intel.com



On 2/13/2024 10:32 AM, Thinh Tran wrote:
> Please refer to the initial cover letter
> https://lore.kernel.org/all/20230818161443.708785-1-thinhtr@linux.vnet.ibm.com
> 
> In series Version 6, the patch
>    [v6,1/4] bnx2x: new flag for tracking HW resource
> was successfully made it to the mainline kernel
> https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9
> but the rest of the patches did not.
> 
> The following patch has been excluded from this series:
>     net/bnx2x: prevent excessive debug information during a TX timeout
> based on concerns raised by some developers that it might omit valuable
> debugging details as in some other scenarios may cause the TX timeout.
> 
> 
> v9: adding "Fixes:" tag to commit messages for patch
>     net/bnx2x: Prevent access to a freed page in page_pool
> 
> v8: adding stack trace to commit messages for patch
>     net/bnx2x: Prevent access to a freed page in page_pool
> 
> v7: resubmitting patches.
> 

The subject didn't clearly identify net-next or net... but the contents
of the series seem to be one bug fix which would make sense to go to net
(unless the bug itself isn't in net yet?) and one refactor that doesn't
seem reasonable to go to net..

