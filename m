Return-Path: <netdev+bounces-157207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F095A0968C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215FB163F17
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA73211A39;
	Fri, 10 Jan 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwpeB95j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FB20A5FB
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524694; cv=fail; b=ATdlTsUyTxG1QJAx6y8iV9lsA9icUFEAsYaKe+ROkb85yrO5GG58AOAL8dh6fLz7xDqnEe7quVdnsZep9YTe4A/OybtPKUEgxsbm2NAPfOJYl5r/LiJY0vP3iDvJ/GhVooMPaa+DucO7VuEDA7W4DzSPZfTKbbsaqbHDnRtika4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524694; c=relaxed/simple;
	bh=GAJyVE/WKPk+g4Z8nqa/xfO+2yzGG5SfpNvFK7/ryyY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NkpF3HgJkZPwbYJBJ4StdnnqWLQM+DwQFCMLO9UQZb4lh/iyIO/LiXwkIJkbrFYMdqpYY/3tg9m/d40/cD/vuMHYL6f9/fsZHj4Xb2qL/6eyaWXZcYB4VujpE8VvLI5Wg1LgRhe+ZNhuuinE8GSBG9RA5glJZ7TJbw3X6DiEX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwpeB95j; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736524693; x=1768060693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GAJyVE/WKPk+g4Z8nqa/xfO+2yzGG5SfpNvFK7/ryyY=;
  b=CwpeB95jGKZtzgbiakDdbll5zP07NIQApr+abHj0QaJ2AFQw09IBUcYE
   RK2ZDrpWC1SzQjVacgaLnILVMnxIX6dscCkAJ4/RSY7pDep4Ef/zfcusL
   KDCWR6lx2lo8of2v4Q55iJ+1HwLZzH+yDWCr+vReFZhLtG7KMlap0jV7J
   aKBSOqTJSsWAyNbY+syCgMN8t773BA8cM46ppaAA8vfY9aBPB0uWB/T9Q
   8GIUeaXtngS71y4qW1k7IYOpiTMRGDEVe94N3VaKHhlHHnvnOHfKOqqr3
   uTVKRgAmSK4dVOyiywzcOF6SRqvAZBpWOTwxM7Hdx+yjSBu/DFUUL8V49
   A==;
X-CSE-ConnectionGUID: CzNB+QH+TYmHAVOhg+0CXw==
X-CSE-MsgGUID: lcY1ZDvpSSmYea5ZKjOI1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62192308"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="62192308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 07:58:12 -0800
X-CSE-ConnectionGUID: TbJCFZRKROi67mDLrGH80w==
X-CSE-MsgGUID: Gc0kS4IzTxu5qfvkZG19MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108402977"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 07:58:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 07:58:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 07:58:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 07:58:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsBYpd3J6BvbXVpxwdqJ++EG/hSaM+0PiMIysJh6fKAZ+Gzgs1Rc+WHBX9mTubnJWKsMi/BMDi9toODpMsr8Yuz3XCoU1LZXk3XtF+0f0TEkVEdEnoWYfo7n5g0Ob5/lpozmZtVwWu96mcocebmnCeJVA2BINOnFrs35UUzdkguaJvQtgTYT2BeaPKnwfKuroce0ukEydEX4dJb9n5JZNpRB8Zugn8jZW5N3kcBtKGL2lRl9sPTPvS9w1xDNffFTFPCVGVNgkLNOXilLohmAk0Nrh+Lv+bbX4POXA1dcWhpJ8uK4AZfqjXAr3x8aE7w3M263uZ+2WVO+BXLbowKMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ircss58GQDsDJuiUqo0Bfqy0zKGG2lIt8vWkv3Dk3lY=;
 b=anVKy04fOzOwixpoSQCLn0CMJrieQdRPmdQQ/66MI0RgVq6LyDQHLs7wfFZW+egCiUTVacTM0RCVpnDj1EltBPR4rj/A/t4Ss9nNQl1GQn4PD8DAgNevJxGU0PmgWWCHhIWd9RxWo5arr5g9uRVcyP3HvxjcAjbD2ot7CjcVEt/Yl+0XPScySFftJuShCwWm05eJavTrQs3Zw4SmAKgRlotQM5g5WhhyPQQcZSDbowv5ITgxAyAxvua47BKJ3PZ1nYrES1VkD+O0vyT8kwQSJYSD833S/2cP8QK7TmatwD7592BbF7X4JqRj4qU4hs+sz8SNHEUr1iUmBngEgjlJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8249.namprd11.prod.outlook.com (2603:10b6:510:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 15:58:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 15:58:09 +0000
Message-ID: <7ccdec6d-ddba-49ac-b78d-035a33af047b@intel.com>
Date: Fri, 10 Jan 2025 16:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] MAINTAINERS: downgrade Ethernet NIC drivers
 without CI reporting
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20250110005223.3213487-1-kuba@kernel.org>
 <20250110005223.3213487-2-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250110005223.3213487-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 247c994f-f0f0-44c7-7031-08dd318f941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEFKSmlEZUpMWUt1S2ZDOGVWRXNRUTF1eE9IaExJbzRnWUxwUjVISDhUMDBh?=
 =?utf-8?B?dHJOVmhwUTlDeFVXZysvVGhZb205UW56eGkrNUtpVE0xQ2ZhSnFzb2pKdWta?=
 =?utf-8?B?RWoyT3FmZ1d0Z1Y4cCs1T0d6LzFuN3BKVXJoZEhyc0daM0pObU9MS3Q1RUR5?=
 =?utf-8?B?dmpsVml3Y3lGY2dqWUZHejRQaUJZWE9ReWRqTXhVR3NKbEg5dGRNWExGTUxD?=
 =?utf-8?B?Um1JLzJDb1Q5elJNYWljNlhsODA3RW0wSDdrVFZYR0lGTzBtdnI2YTRWLzFs?=
 =?utf-8?B?RHpRWU9hYzU3MFpUU0dtQ09rVE53RzI4TDVxTXJpMEdCZW9UTTRGV0NnaWtL?=
 =?utf-8?B?WG8rUnZ2d3BHRUNHdXZzZmVmVFdUUW5zWUVaaGZ6ZFJ3dzFBS1VybExaWHZq?=
 =?utf-8?B?YnN6ZFJNMXBwMUVpdTVGbk8vdExhN0kzRW4rZnhRTEQycHZ5N1lVUkVWZEpT?=
 =?utf-8?B?Wk5VQ1lsYUpLcTd6bG93YkFQZWZsSlQwL3lrZGQ2aFI2NXFJd1RTbG9mODdY?=
 =?utf-8?B?ei9id2RIMWlyRGRERkRoM1pwbzErRlZ2elZIVmVZQm1waHBheFp4NkVnaGlz?=
 =?utf-8?B?YzFHOXlrdzZhVDlid2JhUmJjZHYyN2hRLzNldFlNaklrQlFRMHMzSEhta0Vu?=
 =?utf-8?B?enlKOThXcndPMWFYY3N1WkhHYlNVdHhNNHE1bjB5SmJlV1VxWHBVQnN0Snls?=
 =?utf-8?B?STdoNy8yN2ljelROaEh2MEsrQ2pxSnYwd2dUWjArSjlIbDFjU1JqVTRqRkta?=
 =?utf-8?B?NmFEby9ZQU53SE9KWmxwSmFCUGxzRk5aeVhHbUNDaG4xZkRYTnprYUdYWEdN?=
 =?utf-8?B?WG1rbm55RUlselNCb29pM1dMYzNOM3BiUnNpK0YzNjZXamFTbDRQbE9La21h?=
 =?utf-8?B?ZTJMN0lGd2wxdzNkdjYxWmR6bWZjdHdyY0VMNkMrK3FEZVVYenpXWTFTZjNR?=
 =?utf-8?B?eWhpdVNyK0ljUmVQMDdvckxCd3Zndi9PSXpYZzJYbDZVbGs5QUJFNEtZSjlm?=
 =?utf-8?B?ek9vNVd5cW5JVlJmblRjUW90ajl6WFJVUUgxU0dTdEFqV2JPWk5RbDFnYkVJ?=
 =?utf-8?B?VjZmSko0RW9GQVhEVW1JN3FEYXpWRVZEeVdVclZHaVI5akVQZmppbkFyQy85?=
 =?utf-8?B?VmFNcVdqWmdmRFpKY2ZCeDNsMVpRTlNIblNJM1FZNkw3b0ZGdjd4K2tpeWZo?=
 =?utf-8?B?NFdCVytQd3FxbWs3M0JUQzlXVFh2M3FPTGJrTTBZdysyaXp2dXpRU0ZUajZr?=
 =?utf-8?B?bGZWT0ZxaFhya2RuQTVZRU1KK3ZCQ1E0K29PR1VPUW8zQXBtV2F1bC8vSDdo?=
 =?utf-8?B?TTltQTVPeGN4TndBaG90UGJLS09KTmpwQit6MkhqUXFRenNPNFoxaDV1b24z?=
 =?utf-8?B?akh2VTduL1RWZWl6d2oveDR6eHFPR24yUG1MUmt1d21yMlRSeWtuNk1OR2p3?=
 =?utf-8?B?M3ZHYXBFenB0cEJEdHJmRzl3K044Y21jajY5TU1teStqTVB0bGY2V0FueTM0?=
 =?utf-8?B?VGNHeE5qS2E3YXF4ZkhMQmkrUVRLc3JDYmJoU0dzcllZQVNjY0xEOFpIM1Vl?=
 =?utf-8?B?RmxxekpZOXJ4SytWSVhuellYRm1yaFRiVFN2K0IwNTBIYTd3aXIyUDhhR0RS?=
 =?utf-8?B?L0xWM1NXRnBBZWpkL3dpSHBmSkJzR04xeXJReGNPZGFHR3Y3WktYbVlaL3pI?=
 =?utf-8?B?NU53UjloaURPSWQyLzUvRzhrWTNLYmV6a2lBaDQ3V0FCU3lhTnlDNElUbC8w?=
 =?utf-8?B?dktOY1BFQy95Qkpma0tlNW1XdVFtcVA5eFllZi9BeVcwaU4vNkdTY3BrdDFU?=
 =?utf-8?B?anltRk5RWFdRU2twZlcxMmxUMVpEaC9ERVBuWE1Qb0ZMWExlL0xsRk1vNzYx?=
 =?utf-8?Q?Lcf6z4Rg6Nq7v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmlUY3VUb29hbGJsYXV6bXZYbUR2YStGZUtTb0VvLysyWTJIOHc3dncrek8x?=
 =?utf-8?B?aWoyaXJ0Zlc5REorcy9RZE5FU2ZWcG5lUkZxUjhUYVVIcWxQSVVObU9UR0Fw?=
 =?utf-8?B?dUpkWm05VEZpUGw3M3c1K3NleFZ2KzFtZ2tXemd3TkkxMjM0UDZkUmRHelRR?=
 =?utf-8?B?aWtxcnU1STdCTHJUWFRjMGNXWG1jempHZmxtRTdZSG0xdVZVVTlmSGh3RFY1?=
 =?utf-8?B?anFwUHR6S0JyUHpYQmlpRnJWZURnMTVHQXVpejVSVEZGTEUyS01RUDJWREtN?=
 =?utf-8?B?clJIVVlIVzBnNWNHYVZkRlNGeGZzZmxiNXZNVGt0VThxTmFYeE5OY1ZWaXNa?=
 =?utf-8?B?MVRkU3pRUERyWTdWUFlCWEVNSUx3bVFmZCsxN0lnMzByaEU2TW5NOTk0ODdw?=
 =?utf-8?B?R0dTUVEveFl6QzhhRExlUUhkNWpjZ1o0UTloYmk0OGtxUGFJay9RNFhVK1Ay?=
 =?utf-8?B?VnZvSzV6K3d1SHJMQ2Y2YUtyVklnZlRCVkVibURLdXIzK3RjbTVxQTAwZkQ0?=
 =?utf-8?B?Tno1VTMveG1nVnNibmVjK1pmeERQWS9aTGtFMWMrZ094ZFVmVG5tMVlMaDNx?=
 =?utf-8?B?Nm5yYUdCb2tUUnM0T2hFSXJxZVB6eE9FU1paREQrTEQxYVRlNDgxRHZNQVRP?=
 =?utf-8?B?aFNBWXROcHR1WnNzS01BZmpiQ0VHL1N3Nk95cXZvQzFWMXJYQkhWdHUzb013?=
 =?utf-8?B?ejNSWUZlL2QvNE82aGRjVHBsdGdrUy9McEFjSUhXc2todFpwVkVHUzBmNWRT?=
 =?utf-8?B?bnFXcC9wSEpsS2xKRU5GUldTUU45bXQxRjYrMWR0TGRDVnVaZjYzK2pxMDJm?=
 =?utf-8?B?cGtpMVA4N0hUQkpwRGsvZHRNcWw5Uk44a2tncHZJMmx3bWJYbUZOZDlobUlF?=
 =?utf-8?B?bFViQmNHMmlJa2QxWFlrMmI5TlFwRWRxM3I2UkZBZEhQRUJVZ0IvZnVxeWYz?=
 =?utf-8?B?Q3J2cW1SenBHZ0EvK1VrdlM5L1IxekRVOEh2aGZuUThKV2JnODFEeS90VTNj?=
 =?utf-8?B?VXhDYlhuUGlGbzI4eG5ZaVdWQUthMGVTYVVLc2ZPU2kwLytORlIvT3VkT2xK?=
 =?utf-8?B?dWIrRnd1cktWTU9ySGdyQ3hLZ2NoYkV1UHBZTk5tVU81MytSMWVXL1hEV0s3?=
 =?utf-8?B?aEk4YlAzaVA3OUNyWFNlWWg2dUNYQkpzK3FGRHdtaGpaa2V3eTRpMVNibXFP?=
 =?utf-8?B?YWxzeERFQ0ZXZzhoc1JWa1lla3lvM3g0cjlKSnBoZldmYm02NWNHdVU0YnJj?=
 =?utf-8?B?TXVjV0dBN2gxaU9GaTlkTFVGS0N1bkJFZjI3MVZxNUVmM3pWODZMMnNteWx0?=
 =?utf-8?B?WW9udy9TZUN5aHp0MVVaMDJGRi9wS3ZXc3kxeXdhMm1kOFYzRkk5OEtxNUdB?=
 =?utf-8?B?WGlBcG1BK2VKbWFpTElZK0JhYitOOGlpM2c0QmdWTHRyNmVNL2MwVlYyNFBU?=
 =?utf-8?B?WjRSR25KQ25uT05TdzBZU2hyd0t6TDlMTmFKUkNUOVBMcmZUQnBNR0xNaVNo?=
 =?utf-8?B?VlJYNDJJL2tjTUdmZ2c3bkN5bVRpNWNPakQvTUx0MnNaNjlRcDI5Q1k2aWpp?=
 =?utf-8?B?Myt5aDk4Y1hNVmZFZnVQOWNjcVNBNXErZGp4ZTV4Smwzb0YzR1NZTjM1bEVL?=
 =?utf-8?B?NlBONUZNK1djMXArUGM2cVVEY1ZYNVY5MnZEODAzeFFsNHdLRzRmMEpWcHFQ?=
 =?utf-8?B?VHhFMXpBQVdwcUk0cDEyWDZscTltbmVJZmFhdDl4MzMrdkc5MGRPSUNDb1Vo?=
 =?utf-8?B?dThBU2JrY2g3SkUrVlBvYWdzcHNteUVYVEsyS1VpQzladjF5NDJqeGFpSVUz?=
 =?utf-8?B?YWFuWksxQlF1NkxtZEVRZkFGWFMxc3hDYTQ1MGRYdUlMM2ZKam01dkorcnZL?=
 =?utf-8?B?T1dIUkVBTzR4V1poNW9IN2RBZmlnSXRhdVI2SzREa0swNFo3NXVaNVYyNHZ4?=
 =?utf-8?B?MStsQ2xDblh1RXdRZlJENlIzcU9NMnd2RXNHV2pzMWNNOFh2eHlJcWpwbGJv?=
 =?utf-8?B?c2hsd2U5RkhJVGlQYnVLcFR6QUIrRnhLR2w1OUlpMFBYQndsS1BmL3ZKZ3dQ?=
 =?utf-8?B?ZjlxRy9TNlQwbDRaN3NLTXp2QTVMc21telp2VDl1SHdFYnBQNGNKWHlVM2cx?=
 =?utf-8?B?a0tJbnlxbmtyTlFSbG1ydmtzdC9aYW1YOXVoUklIcTNXbFkzWmlpQWsvTmh4?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c994f-f0f0-44c7-7031-08dd318f941d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:58:09.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwJ3g3/eEFhscT1tDOgPYKiwHbJJ7z4wl2tY/DT0f7HcNcZMizdtL2zRJbZN/rUL7VpTTCYZmZT/TSGmbbeWJ3NWcKmT21kigqDUeDsUl2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8249
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu,  9 Jan 2025 16:52:20 -0800

> Per previous change downgrade all NIC drivers (discreet, embedded,

                                                 ^^^^^^^^

discrete?

> SoC components, virtual) which don't report test results to CI
> from Supported to Maintained.
> 
> Also include all components or building blocks of NIC drivers
> (separate entries for "shared" code, subsystem support like PTP
> or entries for specific offloads etc.)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

I really hope our (Intel's) CI/CD folks will wake up soon.

> ---
>  MAINTAINERS | 106 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)

Thanks,
Olek

