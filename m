Return-Path: <netdev+bounces-185627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C7A9B2AF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491554A8448
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69C1B414E;
	Thu, 24 Apr 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNY4IuiN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CF27A926
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509371; cv=fail; b=R7L7wBBGxu5RUgjFMqTPRWX/KXMtJQYWa1uQfmbc576rJiA7Se4Kq3l125F9gvgLublcCDtR4uO+Rp73MDEuSHU3h1b0fydun9KjLFTPxxPytHP8UR6tWb/XvZi7p+27qEHSmGjFYQ24yHjU2puSrCTYblnRAYFaePAic2pxDnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509371; c=relaxed/simple;
	bh=+VXAJreAKK87i2COUS11FPXgzj3zYVww70/spytB4S0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YO8tMBnwbL8iVFAQMkVMZqmG6kQaqnqjZ/HL6Cl/R0heZyVzkebm9ElP6k0hFLYXuePHSCe9jV1/SlLOCTUX/qYaCE+lKTkCJWcLcvCVa/TarlobWRK5n3QzbQ8FGYDjEa/xl3fHudXeq8pSt3tfCqEg1JYoXGluQVMoehka7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNY4IuiN; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509370; x=1777045370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+VXAJreAKK87i2COUS11FPXgzj3zYVww70/spytB4S0=;
  b=SNY4IuiNNnsP0WFgI8cIWYH4pJrHVttdN56y3yemT16QqTMINF88qDJK
   zOl8gRx7jtLF0Zqi3C9R6tSopvpXbFMREWgimveKRRTdTQRTjWEjwpZk3
   nua6hm+97/wMWEVDzueQCv2p2HFTubvA4951RvWnTYMi4X+zgLF4X3LM0
   4VD89JcxVil8Cg1foNdl275b+eDjbfP/k5k2/yXfa6kfwipcOwATh58w5
   i0KNPPN8+cJCKQTBONqRsau6QmFHUfCSNNmv6lTl5FvKzGniug1HpNhfR
   HB3y6ZVWgUdFdb11U3qu1TAbcfsyTvv0sfhXA0NKvjCkQE2TKHjebVnzt
   w==;
X-CSE-ConnectionGUID: T2e3X0gwTxOCRqgFv+0t8Q==
X-CSE-MsgGUID: u7NuPuj4TrGbB7baAthBcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47283994"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47283994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:42:49 -0700
X-CSE-ConnectionGUID: W1oMB4Q6R+6GHMeiysTu2A==
X-CSE-MsgGUID: mBY7bfRkSZKMeHhP+VDKYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132543465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:42:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:42:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:42:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oucvenzlxJflPHniiFlFSISt6HiBHblvd/JSCd4xSXwbmiqQQu3eHE20o6ifDArfaFSstnaaOFKEkVPrnH6FeCt7UR7qR3DzSJusWsx2ETEssDU0RQJQmvgybbOUY7AzfIvSRQpvKnR6XjFfZKV5akOyD0paPDHmZinEKDUjTR0AxDUILBYUysGChY9AiBwiqukGdf4oBe4TTSr+rIYkkQOMC+2+ldsjBB2kgQX1tfObR1zgkEQM8oqnRp5y+Vn4tjAYA0amGOXYK6BoRwMsOPyjb6t1YTASo3KEdhkw7PBEyMrlBteO+Vh8N3hw/nKNqqqNwcrrroCYl7NRffxhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itv1UoCAqLGVCbjYOxpq81H/SonfzNPfhbe7w0OMSOQ=;
 b=t/SqqyHVFP3BE1o6wrKWqv2QumQlY5U6mzhQEdUtfodpMfzxAMd5wjWs3X76UWQRf+vtMyo5ZmylpO02KvhqrHeGf4g2Nq+a/mgTHO7246ym8It63TXm4Gyol2KtATw4VqdG47ZzsIGsXiKaNImqemVPnMPchdRx4cr9guRbzNYR1xNtGd9gouBeo8Wk3ORYlbyCzlcqEH5rZNlyDzZa1ecZsA32IGHDfJF+Tjr1XGZ0xPoYZv4HRcmVSMAdHSdBkN4RJ57PgdvuYHEu7fZu2fj7yQqwzOXm5Z5PIiCp60RVw3O4toeam20sF//P5AKmCeZOsMt+aRh9t2ogElaYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:42:43 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:42:43 +0000
Message-ID: <873623ff-ffd4-4dc9-9282-09b204066979@intel.com>
Date: Thu, 24 Apr 2025 08:42:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] tools: ynl-gen: factor out free_needs_iter
 for a struct
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-3-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|PH8PR11MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 933a19ec-8f75-4cb9-92bf-08dd8346a701
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDJBVzZ5T05XY2FEZndRNkRvdTJYQ0FpdTRzcXMycy9BM0tTM2xMRzk2dlAy?=
 =?utf-8?B?NWNYVUEycmY2aEoxdlAxT0crS0tpMzhUSFIrdDdZS3QycWZnYUtzNWNIZ0Q5?=
 =?utf-8?B?bFhYRHo4TDAxVlVYUE1mVGR6bENoY0ZrWmlRY3BCTE9kVStSTUF5cThWZTQ3?=
 =?utf-8?B?Q2piNmZpbDNaNHFtM1FHcUltME5GSTVrSGpQYXBBNzdZZVNmVVZyK2NUcW5M?=
 =?utf-8?B?ekQrUGVOMm5VeE5HU1Q3SUl6YTdTalBzcFFIcG50elp5cEcvb2J2OSs3YnZy?=
 =?utf-8?B?S3gxMHdUZVNjQWtDWURKQmdjZXFVR2hkOEtUdkJSUDNOWFN4R01oMkdiU1Vv?=
 =?utf-8?B?VnBxb1dZWDJJbEZjRVk0MlBzSEtzMXkrSVhyTW1iWEUxYkdaaTQzcDNHdjcw?=
 =?utf-8?B?UDFETVd0L3hWdS8vaUlmU1NmSmRDczFtU3dUQTZEc2tRMUVyYWM4eU56ODdV?=
 =?utf-8?B?MjFkakFSTmRJVTBQNUhNQ2IzYU1RT1dxTEFuK0FpZm9SRnFsRUZWbCtCbzJl?=
 =?utf-8?B?ckdQMS9DRUhuU1o0NThiZUZ1VXd3aHhLVDJWeVF4VFhrYVhBNXI3MDNFSmRV?=
 =?utf-8?B?VXdqR0tpMDErTG5pWW1oQ0hQVUJORTFjYWh3NmNweU16N1ZiNDFoSGdyeW9B?=
 =?utf-8?B?TFNHQUtSayttVnJobHdtT3RzZXJRNnVNZjhENG1BRTFrYmgvS0dNS2w3c2hu?=
 =?utf-8?B?bmZtVGczNEtQTmJpd21nTXVvdG03SENOWW53KzZqYkVJclowcksvUFlDaXhB?=
 =?utf-8?B?TEllcE5oaDgrVFJOQkdJWlYxNUdYaWpMWkpNdlQwemtVRk9oWDZiQmIrQ3Jh?=
 =?utf-8?B?bWpXWmdiU3AzaVJrYklXKytTS0QzMVRmTENLN00yNEIwNDlxbjl5VWxHSjB2?=
 =?utf-8?B?SUV0N2hXRFRsTUFEcWh6bkFDZlQwa0RINW9mbTJhZ2poZFRTa0k4TVRSMWs2?=
 =?utf-8?B?WGhNVUprclU2bitpQnVSdjJDazU2K1M0eXJ5bHUxT1p0L0xtUFV5ay9rSy84?=
 =?utf-8?B?eEQ4YUZ1ZGVSQWNBbmVMTEdid0xqb3pFTE5lK0RVNjI5ak5QSk5lbkQveHFT?=
 =?utf-8?B?MDBBQ2RwWUVZdENlTUszeDhVNm5CQ1hQb0pFbUw5cUM1ZHlmWWNvRnZTdXVE?=
 =?utf-8?B?eUZFSUlqZFlKQmxIajgzZjQ1VUJORGRiejE2N0tQMXVOaFVKUnVHR1FJZXFG?=
 =?utf-8?B?MkRnSFpra3pNN2RKSVNaVXlMRTRHZU9INUx4dHpDV2RkaWl3SWhnZW1RQVJE?=
 =?utf-8?B?RjNFWEw2YVRPdmZQTUwzd29wQmovSllzSUxCaVN3TDE0WHI3MXlZWG5neDRx?=
 =?utf-8?B?NkRobTBEVDlpbWdDR2lQdjlXUHkxOGVWcXlUTmwxS3IzQ2RFYmNYNVVxWDNN?=
 =?utf-8?B?VDBtamRwYUxFY0xNYkpJVnJJWnRPUmpZS05zazhBRXFKWWp6MHUzZjRVTzVu?=
 =?utf-8?B?bWxRMk9NR0lpa05zOS9CWU5PWUxxSEdlcEQ2ejFTdW5lVmVpTUh6OEU1bXpY?=
 =?utf-8?B?WUZZMDJFeURkVm1ZMEVRZDVwZEFUR2tSbVB1TGZlU2VlQVlUblN2WFRyS1cy?=
 =?utf-8?B?ZmdmYW96TkVOWHJFdnlqSHhPM0wyckVRTlpBK2VjYkhFNHBhQytnTWpUaWtU?=
 =?utf-8?B?MU1DK0orWGZLcnJFc2Mxbnl2emxsOHdZZy9HSEIvaUFXZEdjVTU4WksyZ1l6?=
 =?utf-8?B?L3VMaWRSd0dDQVcwNTA0VzROcVExVW1XV0pQOWxpYnlLWnR6UlA1UjliWTNw?=
 =?utf-8?B?THJqT0FSVXVSaW5XNGVVQXY4MDVUMFB4N2NoeDlSOG9KUzNlU3M0aDZkYi93?=
 =?utf-8?B?anZ0V1I4bjZZRFZWK1l1cUJHQzN5Q3plWHN0dGtSbkFOanRrczMvSVYyV05Y?=
 =?utf-8?B?d2l2SWhTUU9kaEdjVU13V0YyMWhvcTNOakNSYjNnQWxaRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djN4aC9mbHJqKzBzTXB2RXNyeG9waGswbjBMckltSVp5OWczeXpLTXJ0V0d5?=
 =?utf-8?B?a1d5bUJINFo2M2FuTUFCVTFlKzBqa01oYTdUa0MzWEZzcHR3S0QrZTlUMVVX?=
 =?utf-8?B?bGJXSkpqTkdPYzJlUkVrRXo3SFNvcmc4QjVUc2RaWUg1b1VBdVJ5K1huYU5a?=
 =?utf-8?B?bzhRUUZYa3p5N0VDUEIwZ0IrM3FnYWEyQlZxQXFLYWtDcmJBQy81NmRzWklm?=
 =?utf-8?B?b2FoelFFNkxCai8zSjUwa0l1MmhlSGdxUXA5WVE4ZklPdlRobDdGdzl4NnFV?=
 =?utf-8?B?T2Z0YlU1MHVwMU44WVVWRTVPODRUUEZqRm5RenROV21oN0Z5UCtSS0tFT3dn?=
 =?utf-8?B?cGxOVUdkVk1mZkVwVkFUeWUxSStXdkNGQ1JPR2pQeUhiMVUrZTFFcjhqSTRn?=
 =?utf-8?B?bGZmNGUzOHh3WEE4akhkdGR1VHBCL2gwdi9STm9pU1hCbVNtMmVPemxFK0g2?=
 =?utf-8?B?NUV1RVN4RGVTWGE3MHZ1VnhvYUwvWTBPMjhrT0d3QVhxRzVadTg0dlNLUFNS?=
 =?utf-8?B?UndFVXRBT1E2ejdtdWlIUDVUakc0bFNKWUpadnBUdG5tU3d0cm5YS1NYRVMy?=
 =?utf-8?B?d1RHKzBSUmdaNjNOUFd0VjZhTlFTbnRHT3NCU0haUTRLbGJNWDl1UHZPWDZ2?=
 =?utf-8?B?ZGQxSXhRb1lCNzVZbTgzUS8yQ1dpaHFtSGdBU3Y5bG5LZEFZeUYzZkZ5Q01Y?=
 =?utf-8?B?V3dIcEFCZytHK2lPUVNKVk04WUpjalVBYm0wdDNpOXQvWVNPQ0RvOW5zdm5H?=
 =?utf-8?B?QTI5L1NkbHd1MHJXWE05aitFSDhxa05JZXY5KzBucVowaExrTmp1QnN6Vkp6?=
 =?utf-8?B?RmxFU2xVa2Zoa1psUFZSSTZ2Kys1TlFZN0VMaEtmSzJRYWxDQUJNY1h3Qi9F?=
 =?utf-8?B?d00xdklJcXJmdmNnSFVrVDRBbWFkNUlLVGdER3BEbUZTYWRydDBZeWV6RGtF?=
 =?utf-8?B?ODBLOHlmOU1ZZGNQOFFjdUVZY3BBSGJnVU82NThEWm5LT1RSd3ZRU1ZyZkd4?=
 =?utf-8?B?OGpRMXMzZmpVOExVZllpUS9Hb091VnBGRXNaMnhHRUlOd3RzSFN0TndWdGgw?=
 =?utf-8?B?b05ZdWZXN2FYMkw2OUhHNC93Mi85OEorVkFiKzNQZmx4S2NnZXZBM0lhRnp5?=
 =?utf-8?B?UG1zWW9CQmp6dkJjT1pyUDdJV1VBNTM4aE1UV3R4U0ZVVG5aV0k5WU9uU2g0?=
 =?utf-8?B?UldSR0JyeG9PWGxLYUtvbDBmVzBvazQvdk5xaFVaY052aGlLMi9sR0lTanho?=
 =?utf-8?B?TExOUTFrWmZCK3VxY3NrN0pQelY2c2N6ZFkwWWFjZ1hpKzZIdzNOM0F5M3dN?=
 =?utf-8?B?WHR4M29FQXZLT1RVakxFZDBiU1hVVS9tNmo4VlBXS1E2SHZ1azZRTEpoaGFh?=
 =?utf-8?B?UWZvUHdhY29LeXVHV2VKSkhIdThxMlczVEl0NU0zdG9xc2VPQi9RdmF4dmw2?=
 =?utf-8?B?Snh6YWJCY0lYMmNaNFpYTzU2TXRONkVhcXo1UzI3WllORWFGQUV6ZUdsYWJL?=
 =?utf-8?B?Qm5XL0psT0lZc1piMUtJeVVQOE5aRllpSDAxbzFtdWlWeURqT2lsRWFOS0xV?=
 =?utf-8?B?bm9LWXZVdnNxWUI4MGpDS2oxL1hTUHptQXIwbG1lcWRMd2NZZ1IrRklvTWlP?=
 =?utf-8?B?bEIyQVBBR0Y4SDNqenNIelNNVW5DUjNpUURLenoyWDZJdkgyZzEwSUhqU0NQ?=
 =?utf-8?B?NlpnWWp6UUxsaWtsck1qQWxHbWlpWGlvcVdGdFVIY0RJOWZpc212YmRyL3U0?=
 =?utf-8?B?TDkwMGxxWk5tUmlTS014Ry8zU0ZrVGppamNvYUtpUTJLbjU1TFlHWWJzTFFy?=
 =?utf-8?B?RGNnTGp6a0k0VkFKUlBDWVh5anBTTGthL0Y1OVNtenJweWkzR0wxRFloK0Er?=
 =?utf-8?B?K05Nbkc5U29id3AxV1VmNTVQMVFuaWNGUUxlcW8xeFNCeHFYQ0JjOEtxVTg5?=
 =?utf-8?B?WDZmTWs1T0FVUlgzMHpZdVlUZURGTTE4VVdOWWo2aEhIcVcrSWRMQVFGSEY1?=
 =?utf-8?B?emE2K3JDek4rUmJHRjZoZURtMGxWZWFSdForN3EyNjZ4ZWpOdFljdENWT1o3?=
 =?utf-8?B?UTMzNGxtcTNBOTlkck5RZkpONjMwZnp4ZGY1Vnk5ZWkzU2N1eUNBdFovb0xP?=
 =?utf-8?B?L0tUaDFJaCtwcXE1ejRCOEVlUjZGdnpZcDdoYjlPb3YwTFI2R2RIeFU2TGpE?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 933a19ec-8f75-4cb9-92bf-08dd8346a701
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:42:43.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjZdewn+JQyfdNTG6qzDQw6q53b8QW8MzwM2hnMP1c09r6RcCDypKzUcUrB5cr4Wkt2ChqfFL/QxYcHyTwfP1R/JGU1rBzopsEZ7htYsNUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com



On 4/23/2025 7:11 PM, Jakub Kicinski wrote:
> Instead of walking the entries in the code gen add a method
> for the struct class to return if any of the members need
> an iterator.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 077aacd5f33a..90f7fe6b623b 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -809,6 +809,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>              raise Exception("Inheriting different members not supported")
>          self.inherited = [c_lower(x) for x in sorted(self._inherited)]
>  
> +    def free_needs_iter(self):
> +        for _, attr in self.attr_list:
> +            if attr.free_needs_iter():
> +                return True
> +        return False
> +
>  
>  class EnumEntry(SpecEnumEntry):
>      def __init__(self, enum_set, yaml, prev, value_start):
> @@ -2156,11 +2162,9 @@ _C_KW = {
>  
>  
>  def _free_type_members_iter(ri, struct):
> -    for _, attr in struct.member_list():
> -        if attr.free_needs_iter():
> -            ri.cw.p('unsigned int i;')
> -            ri.cw.nl()
> -            break
> +    if struct.free_needs_iter():
> +        ri.cw.p('unsigned int i;')
> +        ri.cw.nl()
>  

I like this, its a bit more clear. It is easy to miss that the break at
a glance and think this logic applies to every member of the list
instead of just "if any member needs this, do it".

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  
>  def _free_type_members(ri, var, struct, ref=''):


