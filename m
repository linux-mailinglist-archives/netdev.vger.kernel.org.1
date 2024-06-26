Return-Path: <netdev+bounces-106810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA11917BB0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25178B20E7E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C981684B4;
	Wed, 26 Jun 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Arg87+B4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED415F33A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392751; cv=fail; b=T2aspbdKn5EgxPGm4DAexs4Nq3fCPg65PJ25xoEgle2CElnJXFQO0ScMdmZmk1K8bqlRpN2CVl3dtNL9O5VLApd2Zl89A2GNo5mHI2Z8LA+cnrL8D3sPthHuBw8M+VcYp5xNWkhpavXKz2DMS9UpSk3rwKkGAwNuh3cEJjb0bsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392751; c=relaxed/simple;
	bh=vZwYf/UqYUHN2cRtjOGgtvlLZQ5Hy215PxaBAEgHATk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kc7AsPWHJA1rUr6wVSZDcWIzpVMTGbiDUL/j6hznVcRrb7F50nubDfZAVdBhOpVIIJlyt+NSdHG8PNnx4k1hAvAYYXre+ZNp5ULgsi2Di4R0kDApWQdmmoG1+ZKbrwhTIkY2xU4tRUcXYf8Z2Do1doj4lxX0GfHGoKGSxeoKg9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Arg87+B4; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719392749; x=1750928749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vZwYf/UqYUHN2cRtjOGgtvlLZQ5Hy215PxaBAEgHATk=;
  b=Arg87+B4gn1bQJSub6OrX9ECIcCuZyWgr2hxoxXs0OUQ7qhMgE6rJirf
   Xzy3RNmT3lkkvNuBL0SFvW/HrFPmJxVTOCltjPmW6YJroLhc+wauprc+E
   iIeBECxNkDVZELCnXx3X4ok3f3Tms1i5v8+hsOOzVMmuIhJg4Ukcvty9H
   8lWvnt7O42Vg1lRZdEQCSmP/qop6/8FbVfvFsDli949sJrmybm+t8dtIL
   rw+937x1WKTuvdRStFI6796+GTThqRP9KsYzsirTuiUKHrGQXUXOJ02fo
   p0M+Yyrxpk8F6bkMibQcsZWEVtoYOHvxDFiIJrdNuVV0LU6QQvHBwG+73
   Q==;
X-CSE-ConnectionGUID: hn6NlyiYRzqa1MMyXTi+aA==
X-CSE-MsgGUID: YXLPSf5UTW+ekJGkzHsYlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20261449"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="20261449"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:05:47 -0700
X-CSE-ConnectionGUID: uk1eXTYUQGGKrjIZQu5Riw==
X-CSE-MsgGUID: 7Emo1RieRjuDhimkuiXzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44042169"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 02:05:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 02:05:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 02:05:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 02:05:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 02:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZtyFtaMH6keLnvTn6686R0KfcDVNMlWFcxZztUV7mrcZLmFGNwrk3caSF5NNbsKUQXhU82BdVFfvDiNBLegl0PRs1m513UshHzv+38RzCLOm1s45Gm7FAn/7kF5bnhpnnNuV+OMPRXfH8P6UQd+sh274rUGh43mMBbSmKhjro/nF4aphgpl5obuH9hG+87c8KCt2medFnhLU9pFuDwc1uCwVJPsrmQVq3BYu2nvAayNxMUg5U5zugURAs7qd/z1rfTgw9dSOGpXtDP38MuPtGIQor9p6KAgU5eQqI0PMowNcskNGtqNAiBj+x3/V5CMX7bvKIamV8zEP69SZKY1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQzVBnGozpt1wO3+I1tEILz9sm4X3ttRC0c1eOazTP4=;
 b=F0K5KMudVPMFodfA9VJTF52MLrM6RHHLuLAcC/f4dgmR83DYx1BoAoG3pmcLapf2vNBCisrAX+dKW3GbKR1D1M3F86TSP6qOZSrkEuwtYaLKKO3L0U9QI6ic12/5r/j6p0fj21lMU5t49tzJ/102+3Z6mYgsaRNKIzpRQed60AivSN3Xie5X5GwBo4jHhS53raKAfQh2i+75GhCyMdDm2/PN8jDzmBnYFLjVNxFzaYPoA/Lee+b+oQrTzkllzGqk8P+TaVjGC3vQesRaRhl4wO/BtEjS+LE1tdiC6qwDsVyJW35OOfkCLqgLi+x2UDqdi9jNcYC4C2U2i3CTXzG3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 09:05:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:05:42 +0000
Message-ID: <b6f4adee-76c2-466d-9d0c-f681fe32baf8@intel.com>
Date: Wed, 26 Jun 2024 11:05:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Edward Cree <ecree.xilinx@gmail.com>, <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
 <5ac63907-1982-0511-0121-194f09d9f30a@gmail.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <5ac63907-1982-0511-0121-194f09d9f30a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bbe82d-af56-4053-dfbb-08dc95bf27c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDRSSWJOVVJhbEhhWXYyVE42VXgwRmhKQmZ5YkYyb3YrRmZVd01IVHJxdnBv?=
 =?utf-8?B?b2RCeXdQNGdQSnZrYjJURWZxZkJCTnNnRktIMGVnVHpzZnUvbVFaZGRZR2RO?=
 =?utf-8?B?dW9VTW1KcjRXOUxGUmhEQTJlOUp3cGZBUTBmN0o4UWw4RExQbVdGQmtMTEQw?=
 =?utf-8?B?MmZEZkEvN2czNXlhWk9QNUg3MHBYYlpxQW1CbXhnTWUvekEvczRoVDJ4cXAw?=
 =?utf-8?B?TDVTbEltUUdCOU9Wd2dFWGdIZy9QTEFHN01EbFE3U0ZKeTBESHpQWmVIa3hl?=
 =?utf-8?B?MzlkckQxejhJM1lSL24vak1hUlJXb1NRWlU2WXNVY0Z3VHZ1VnM3RTl5UW0v?=
 =?utf-8?B?YnJzcnNZdzBUeXJXakNKdDg3bkdWVFZmeVI4UWdRR1NqbGl0WFR1YTY4N2ZG?=
 =?utf-8?B?YW4xZ0dIZ0taTHVyMkw3NVpYSmVKY0lrQ1dleGNDTlBJUzFIald5ZHd1eXdO?=
 =?utf-8?B?Smg2UXpFakZMSi9FUWlSUXNtaGpJREwwVTl0VWt4RXlpWXVYOVRQZjR6WWFV?=
 =?utf-8?B?Rm55UDdNZGJrLzdib24xd2F0SVdXMTR5TlZodEN3VUlzbkxtangxMkFrejBE?=
 =?utf-8?B?ZHZXUTJvWTIyaSs1bmRlNmMvMWlHYkRWczY4WGxuM3YrU3A2U2VaM2VsU0pw?=
 =?utf-8?B?b3pRVWNOY0h0a3ljbStIVWdwb1NsU0tZN3JVUW5qaGlDZG5NRmxVU05aZFFF?=
 =?utf-8?B?TkEzTGFwRTd5TkdzczRPeFM0QTQySmVEWEN3UFc5bFhmVmZNUDQ2ejI0OUZ1?=
 =?utf-8?B?dHM5WVRkcXFDSStnZjNmRkZZa1N4U0EzN1dOL2xLM3RIOFhBWHJGbnI5eUps?=
 =?utf-8?B?T1FUaTVUaEFsY2kvNXRCeTRVVVJ6SjMrQlJxOVdEbFdXV2FGTmw3Y2pGQS9u?=
 =?utf-8?B?YWswYUhpWjN2T2l5eHZkOUkrR0dyZ2NsZFZkMG9GM0llb1VvQ0E3aGtZUmFw?=
 =?utf-8?B?UFpwbGs3aXJmZjZYZFJaWU1Hc0c3eDVkcGo3NEpDM2RQVmFRMHMyM21raDht?=
 =?utf-8?B?QkhCdGVzd2ZWZVhYeHZBUU1LeUFodHNkeG1xV2llQ09SeTVCY0luN2thNDVs?=
 =?utf-8?B?cXp2SGdWYmxHaEd0TjdRL2xHRGFRcEtiaVdDUXZvTGNuWGt1U2lPVDBqamhs?=
 =?utf-8?B?anpiM3lDQWF6VGJ0d2lyWGZBcTlLdUhtR2dNb3Y1RSs2VTFscE0zdUs1VS9o?=
 =?utf-8?B?SmtWbzBkZWM2Z0EyZStjbTFjR1lGTmg4ZVg3Tm03WVlGczEyN1pSWEQ4ZmVo?=
 =?utf-8?B?bmJmblpkTnlPV2dEOC9tWW95d2x1OEtlUms4SVF0cjBhREF1WGhyaVRRTFlr?=
 =?utf-8?B?Q0ZDY0tDcU9FMWhzaEJySnR3MDE1dWgzOVZBL3ZkbTdpWVprTmVCcmdWc25M?=
 =?utf-8?B?cWdMZVVJN0FXVU5lUUpscGMrNUJMVnlsUjU3TXpkSUV0SUJjQSt2YkVNQTI3?=
 =?utf-8?B?OTNXOHFLcDZrQTVSaytJTFhMamxBbFhrVmRqK2VSeVdiVDk4dWhob3Vya0tJ?=
 =?utf-8?B?THhsZmcvZzZubEhPVmFOTkZ2QzFyZmhVTjhKV3pCYllqRE5vK21pdFozd0Y2?=
 =?utf-8?B?enlwMmhoaFFtRnlvQ3Y1VlA2KzhiZktpbzNTVDY2aXg1UXZ6QnBiUzMrbEp4?=
 =?utf-8?B?RVo1RXZLQjcrVjdqUFhEeUp6MXJyVWZpc0lpY2c5Qks0a1dTc3lWclZ3SGw1?=
 =?utf-8?B?MTZ2WlR3LzF6eVJTKzRZQTgvK2FFR2MveWo0TFlDWWhVcHNqdnlNZW55a2dw?=
 =?utf-8?B?TlpRTmVBREpOM3dCYi96bHc0SjVUZFArN0ZqenFNcXlUTUFnUTFMNm1kaE1X?=
 =?utf-8?B?NUozdUtibHpxaWxxeThwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXUxOW9RR0Fjd1FaWGg4YmEzOC95Y3lhRC9kUUM4UmhtNEV4VnhVaS9LQURa?=
 =?utf-8?B?VWRER3JtWldsZHlkLzNJeXZtSnZpN3doNy9TNVNtS1BZQThqQk92cDMvTzZt?=
 =?utf-8?B?a0wzVlREMEtOSmRta2pjdk1SL1RxczVha3VpUVRTa0xHM1FuaU43blV0eC8w?=
 =?utf-8?B?eTQ1UWpJRlRtd0c3ODJXdDRwY1B0Q21manZRcU1IWHdRbUV5VGJBUHdoQnpP?=
 =?utf-8?B?QkdyaldGbGdzWlhrUUJveTlZSHVuZmFuM0xUUGlNZVRXSUhkWjJRZllkWDg3?=
 =?utf-8?B?bk9PWDY4QkgwNWtjblJ5RE93OVRjd2xZV0E3bVBZaGp5Rm93WFNwK2pzaHMz?=
 =?utf-8?B?TjV2V0VFa2tNZC8rK2RyYTBNZTlreG01d2hENjVtNFVTTzNBd2lxVGwzTU1X?=
 =?utf-8?B?QlJ3OE9rZDNGWEczck1aTjU5cDNTT21tMGNka0FxUFM4N2hIODduTG14cjlX?=
 =?utf-8?B?QzNsZEgza2ZEYnNqcS9xNC9YdUk0d0RacmxoYWkyaGV4dEdXWlVCSU90VzFL?=
 =?utf-8?B?bS9qTlViNC84citaYlVGR0Y1UGEwRW1GZlhzZkxDcFhtVUIzenFXUmdJK1dS?=
 =?utf-8?B?bnlXMGhXSUMyWjdKbU5pdVV4VUVkUzBCU3gvYkNQNWpoTTBkUCtvVHJsRWJQ?=
 =?utf-8?B?Z0FrQjJ1NC8xVUkwbVpzcEJ5MnkwS1BOWVVxWUkvTURGLzYvVE1JMHpFWm1O?=
 =?utf-8?B?SVpOM3dzQmF2WkhVRURuZTNMdDNzVG9VbDNzRk1oSThZanRaN1NSOW9naURB?=
 =?utf-8?B?NEwyK0ZvQ2lTNnVxQjJSOGg3RThvYkc4QWw1cEQ5QnFKSHdTSzNlMUFWNG5i?=
 =?utf-8?B?b1NqdXNCMkRWQm9qeEN2UVZabVl6YjdqMDA4RW1BdS9wN0FUY05oL0pqelVK?=
 =?utf-8?B?cC9sWlh4R1hhQ0JJNTh6UDVYa1FsNkdlYUZwck9tZXFjT0h3c1hvU1lmQTFE?=
 =?utf-8?B?Qmk1SDUzZ3ZrZm0vdXcxd2JwTk93bWtWd00za2tIV29xbGlnV0dyeXQ3MnN2?=
 =?utf-8?B?Vk85a3psYWFFYTlGd2hkOUEvb1NWdnpNNXZoWFRPN0x2L21TZEZ6Q1FQaTZh?=
 =?utf-8?B?bCtiSDFqUnJldlU0d2g2Vlo1MUlhTkZGbFV1aVBkcUJMNEhoWE9SVlJ6RGhr?=
 =?utf-8?B?YVNmNllCVkN3YXVIdEN5Tkk4anVVZkR3T3JMWWU3WFkwcUhzTzA0VTVEcmkv?=
 =?utf-8?B?bTFRbDJHT1J0Q040enZmZnltWDZWNlJoTlBaM0FTcWdKekRxRml1bEJ0VjU3?=
 =?utf-8?B?T0tIeE1VeUdWV2JFU0ZVNDc1WnNoYmQwQlhQajZrOTlCbW9YTjhEeHR5azdQ?=
 =?utf-8?B?S3g0WmRhTi9JV200cXdKRHhYcGtaRGhheEd6QmpZUXo2SUpsTFNZQUo4ZFdQ?=
 =?utf-8?B?Q3ZNL1QrMmVZcTU1enoxamt6Z2NRem00RTBNamJ1cld4RzNFRkpLMkN5WHF3?=
 =?utf-8?B?dnFDeS9acldwSXVRUEdmZGZkQWNHUS9iMGo2ekZacnkrWXJQZk1sNC8weHgz?=
 =?utf-8?B?MmFTWnp6d0I4dFJmR1JhYUE4SVZXd1FTYXNPTVVUQk1CcDY5WHVIYnRiRjBF?=
 =?utf-8?B?clhhUzRraVBzZHoyL2NFUkpQVGZzQUxLSVBuMjBCZUwrelFoWGV3ZXArYitD?=
 =?utf-8?B?djRCTW9JeSs1R01ka1hJUlJGQ2tRYzVEN2dXZWhKQjVvRUY0SkZmdnllVkhQ?=
 =?utf-8?B?SmJhb3ZRSUd1b0V2WG9Vd3NGTGF0V3VtUVFnT0dQMGxxbG5mUldWcFlEQnQ3?=
 =?utf-8?B?UVR5bG9YdTBEOU1MOWthVStqTmNlVStnTG84UDY2VmdZdGh2MTdDbFMremYy?=
 =?utf-8?B?eGI1WnJrRzQrd2RQSVMveHBZc1F5d2hDWEVVb21IQWl1bTZ5NFlCWmcvTERv?=
 =?utf-8?B?bEp1bzlRVzY1UU9tTmtsSXZMWVFEOUxxeFdiMENBK2gwajI5V0RnKzQzUlRM?=
 =?utf-8?B?WUhTVjhReG12MXRaSTUydTByMTBnNGdQZXBjRENZM3U3VWg4Zzc1SFphNGhK?=
 =?utf-8?B?WHdERjFqN0RFU3pZYytvbUxVNHUxcEdhWlZiNzhqVXYzUFF2eThJSUVTcjVF?=
 =?utf-8?B?L2RRQWJ0dXBMQU12QUNqY09iMGEvRjgrSHlQU3BhTU85a0tCOWZIdWpYem9P?=
 =?utf-8?B?QTYxRHluOC94dlJpdG9ScWpPVE9SZXNOQzZTRFIzQU1tNjlPY1JzbGhFcnlP?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bbe82d-af56-4053-dfbb-08dc95bf27c9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:05:41.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1PejPa3q4cj4MztnwAiy9yYS9xHg2f7M0IhQ5nJ5sUyOGyMEAxHWsGYFMDAErwQmAMsO2fUCnE4TvZz28zxIRP9RcRQ8ZCavnfhq5Yee6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com

On 6/25/24 15:39, Edward Cree wrote:
> On 20/06/2024 07:32, Przemek Kitszel wrote:
>> On 6/20/24 07:47, edward.cree@amd.com wrote:
>>> +    return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
>>
>> struct_size_t
> 
> Yup, will do, thanks for the suggestion.
> Don't think that existed yet when I wrote v1 :-D

yeah, but it's just a nitpick ATM

> 
>>> +    /* Update rss_ctx tracking */
>>> +    if (create) {
>>> +        /* Ideally this should happen before calling the driver,
>>> +         * so that we can fail more cleanly; but we don't have the
>>> +         * context ID until the driver picks it, so we have to
>>> +         * wait until after.
>>> +         */
>>> +        if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
>>> +            /* context ID reused, our tracking is screwed */
>>
>> why no error code set?
> 
> Because at this point the driver *has* created the context, it's
>   in the hardware.  If we wanted to return failure we'd have to
>   call the driver again to delete it, and that would still leave
>   an ugly case where that call fails.

driver is creating both HW context and ID at the same time, after
you call it from ethtool, eh :(

then my only concern is why do we want to keep old context instead of
update? (my only and last concern for this series by now)
say dumb driver always says "ctx=1" because it does not now better,
but wants to update the context

> 
>>
>>> +            kfree(ctx);
>>> +            goto out;
>>> +        }
>>> +        /* Allocate the exact ID the driver gave us */
>>> +        if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
>>> +                       ctx, GFP_KERNEL))) {
>>
>> this is racy - assuming it is possible that context was set by other
>> means (otherwisce you would not xa_load() a few lines above) -
>> a concurrent writer could have done this just after you xa_load() call.
> 
> I don't expect a concurrent writer - this is all under RTNL.
> The xa_load() is there in case we create two contexts
>   consecutively and the driver gives us the same ID both times.

thanks, makes sense with the other part of explanation :)

> 
>> so, instead of xa_load() + xa_store() just use xa_insert()
> 
> The reason for splitting it up is for the WARN_ON on the
>   xa_load().  I guess with xa_insert() it would have to be
>   WARN_ON(xa_insert() == -EBUSY)?

you need to handle both EBUSY and ENOMEM, both of which you are handling
by separate calls right now, but it is just stylistics at this point

> 
>> anyway I feel the pain of trying to support both driver-selected IDs
>> and your own


