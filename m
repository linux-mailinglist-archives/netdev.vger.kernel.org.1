Return-Path: <netdev+bounces-192823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD7AC14EB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF981BC532D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF52BE7AE;
	Thu, 22 May 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeqyVT9H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6021EA7F1;
	Thu, 22 May 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942947; cv=fail; b=fdavudgW8iDyVs3abOgtu2vQr6t0x7W+2tldsm4+TJv1jz45+5ubpdHZyqBa1L0qW7VOHcT1aBE3hOQxZVQznY/wqBINAH6h6LcoRgSghqmArqHS+3Yj6C4zXnmIccPQSMO8D3vDmAwkymbkv57gmJJ3LlgXxxZEnbZFQKpdkX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942947; c=relaxed/simple;
	bh=YKR1b/GIRB6aMI6mcLoI/oQzYdwa230JUqcotgc6WNQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HkoETH3+0IKFY0zNhxbk21nT3HqEF5eY8/HCKwOn5/DT3Amar7bP9jjs/xaHqBJ4eez+qpOcHTVyWnu7J/m+gsbW4EixBRIKn7Len0sBwHTbhcY6zZZoYmN0go8qXx7VGAK32/7HsvCDHSG3ZGhyzaWbL+dFh3gqymMVMnsEs2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeqyVT9H; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747942946; x=1779478946;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YKR1b/GIRB6aMI6mcLoI/oQzYdwa230JUqcotgc6WNQ=;
  b=UeqyVT9HJJ37Sy++ZrYTuPmdiieAASZvXZnDtZGnjicGaMHFZK0diaAw
   TSKBFMKRSHFfhfhGciJtW+TEm2sSdutuxJYzUpffoYJ8fdsyGWiMO0NS4
   Li3XkVR4L9D+sGj0JIuE54fSHZTwP3pZSShRnbMS6jH2TUWX12uY6MVqx
   8G/zT8ln12OozorWEbwsKvfWqUQR+22BQcNrnUGy9ow7N7Crj+7FuYdNe
   9vfYFjokX2TJLQUVRSrH+u7ji+VJv8pTKDWf/NhCz1g4Vuwv+10EYpnaK
   DZ1Vo3YWq7ONK9EdirS3So8KmnTf6yBKw6NKgk/gpHUB5U9JzI6iexNX4
   w==;
X-CSE-ConnectionGUID: r5J9NVclTAqSdxvWraqSwQ==
X-CSE-MsgGUID: dtIkJD8nR82awTPfp2ycbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50135188"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="50135188"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 12:41:31 -0700
X-CSE-ConnectionGUID: +tjLjxZ1ThOf7L6e4ZUjkg==
X-CSE-MsgGUID: tdwyaj2HTQazuxmzhPTVmA==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="140565446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 12:41:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 12:41:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 12:41:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 12:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7oia5seDDJeLZQxczA5HyEoXCVt3O1ZWAdgaPDj7H39JKCh+BfkrSoWFuvGzlf3maWUadlBBkDZq6IgvSo2bJLd+v+KbUIWiZDyO+iGM0iPQdwJF9eyYiofqKiDqRuOpQl7I8mfy2opImzkyzMhWGXggTb16zowpVrNyvx8copGPFvGUr6l0LUG8xHksF27BSx0gwMwQmew+/4MFpk8QN/fQ26m3Hbg4hmiMmR8buI7KsJJ/dQc+KBP4EzDqtHCSZmmPcAjKkCTX6zpysT3nvQn0lNtwspoN/QBKwitryWvAjzoxASs5RINkVmLOKppAStPMDFSe7IpEjNfI8mYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjvQIFnISG3vHhFlZVgURgg8rgiXNIYzFm3L/Mf4HuM=;
 b=UwxJfuIJw47Wn/MtkJxvCgo/vPEwwKV0Q7AUIHUmgjWvyyhI2j9ZH85o5VtEh9y5G/I/2jYzJkEWwqrmn6vQenlvPaqsg8M36r14+myWMzqzg7Zc8lRYR18XZwzIwdy2dFBOgyj9YbYMQWTGc26nKI0Nk6RL8CgLrfVJUYlJHtBx4nTGQKQ6QoI8JoCmlNNkwlupOUSVHqJ7wZ21W5jwo8Y5NJtiUjAgbA6cE3/HzWGBpCVvxzGlnHbP76uF/KN4iNCMoqxftEGKJFpU62E+5fkf0w2ZtI41TIMKg2wgT47NzJfW3d4ydOJNdWlBV6VuesPLtJN9GR09Z7rcKWXNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 19:41:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:41:22 +0000
Date: Thu, 22 May 2025 12:41:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Message-ID: <682f7ddf1f0b9_3e70100fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
 <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
 <172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
 <682e09813a374_1626e100e@dwillia2-xfh.jf.intel.com.notmuch>
 <8a993411-26db-44c6-954c-e58eb12f9d82@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a993411-26db-44c6-954c-e58eb12f9d82@amd.com>
X-ClientProxiedBy: SJ0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: c359ba1a-a649-4a10-fcd7-08dd9968a14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0Yng5WwkSzVO75bU53C/m5fjSMat4J5rHiozkpZTkCT67kpzs/+M9GP/Ia?=
 =?iso-8859-1?Q?8U+JAyjedz3/wt3HHo3qXDDYOYopyS8+6HvDuapYbRMrW1H5pBz/zQzkcR?=
 =?iso-8859-1?Q?UzvFzux2pigvh7QquVUqcTf8Y5HJwvK5TCAh/9dMIZGHh2oLqMmZrKCTPV?=
 =?iso-8859-1?Q?RBYj8Gy444EBNbWyW2ZVSczVAN4DTEc+8EsMFo5wY6Vt4LpOHwDGm8uPU6?=
 =?iso-8859-1?Q?cTjpzsLMczPyP/YnU0eoHutXsNtyoBHbLinUun3R8SleRZJIs7XYykGiqM?=
 =?iso-8859-1?Q?t9wAzaoEpGbAaBuGaWJ29m+pDl2W+Hsu3qQIJbGTX1l3Z+RoNaM/UAGqj0?=
 =?iso-8859-1?Q?YpF2ZncX8Z0yBGXCuGSDFS1ab86ZJ+HoOJTYdadrSyBh+nkG2S1rBVxJaE?=
 =?iso-8859-1?Q?wdDA8dFWVlvM80rwmA4pR/kmSdEaxqrWqp6urINtQYKiJfAyPlGB60V7DF?=
 =?iso-8859-1?Q?v1vVw5r2UEeIMJ2cRUwnOEGZnYl44uJQQy+ttqRKII+RtjDl/5E8WJImYu?=
 =?iso-8859-1?Q?Jhu8kMdUX7WHzKPR1FEn/FzY6TwJo/07Ls0c+KVBKaZCeWvGR9v3h+X7+r?=
 =?iso-8859-1?Q?VbUdFoIBkdbyD2IkYtVL+oGl6nmCuoBE8jhbMSvyqAs2459Q6I1f7V9T/B?=
 =?iso-8859-1?Q?hl7jhvLeZWafqkk3Q4PD4NDNM7lqlO0tEh6nwAXSFHmDJNKAQqgbxFQBer?=
 =?iso-8859-1?Q?3acE5GidhK1QPnH4rPuLG1gwIf0zJucVb7j4CLLSn6IGRIS+NiWlsxYPhs?=
 =?iso-8859-1?Q?xO58uDJ56R24LNu91LPFtP/XIXqkIYFnGmwXGHu8aECItRKdUWw7yioz4X?=
 =?iso-8859-1?Q?GNSVLWc7dXuCMrKJYvccQ5qU43NtzTpZ2PKnuZuyQaLRh47t+4gDa5uEgg?=
 =?iso-8859-1?Q?6f+JfrwZXsM6xT7KdInfB8LwokahDLOMd9nUnqmfO/0Z/yrm/uEoM87AeM?=
 =?iso-8859-1?Q?dzW3PkunHMXBYM+7kMQlmO1KOwFGiz9XhpaFUFuI6lWtjGxXt6Q6lN5QjV?=
 =?iso-8859-1?Q?nWB0qU9PUuaXPBmWxi7fvajW2P+gVTuAuhv31nycxftTTGv+NVOnXFP+8G?=
 =?iso-8859-1?Q?yEsNWpTUvi4BPH8UzUyZzOYASVuJ68UVRNZheX5L41PbX6yS1IeGoRpH/4?=
 =?iso-8859-1?Q?YrDGRG1wKRPzckn3zwooA3hnbytztT5sI2u8tuZYtVPdesOvKEjz6nyolP?=
 =?iso-8859-1?Q?eMtcnXGZ4yVN8P/RL1othyJQv4djYeq6MCLVLJCR6c9vCRGETJBeE/B6Jj?=
 =?iso-8859-1?Q?2fiR+HOPVsR643P0iFsr1UyETns9SxWjGqq+ejOFRnm37SnYKuR+p8ikLa?=
 =?iso-8859-1?Q?YY3H4EiLZkYZb9d6Mq7wbsEWfyagvQqIGR8YYOZviSrfSVQMkuYfykHAdV?=
 =?iso-8859-1?Q?VGcnqyqfu0SqVFkRL8gsFCFu4px76zsWCSM4KkH2osnwFE6H79vaki05jP?=
 =?iso-8859-1?Q?cJV/G5rcoje/xyNJZfQZ+1nGbh0cri0Wa1DPhaldtuD7kTfZITkaV4gl44?=
 =?iso-8859-1?Q?NIfXTkvsVpCRlqjf4B4o9qbmCC+cxTfR7bWqeDetgc0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?79mJ0uhVZcfYBt0n9lKni5Z2ViCQAPftL7SmIPZSe5hJX0jJcT4ac5aPEm?=
 =?iso-8859-1?Q?eFsI/mqG8wo3gIQkYlPMTL6Gi4IjGZzi2euHbmn3Br1/VqSHXHE3HURtr9?=
 =?iso-8859-1?Q?pShavC0QXHheLtAUBucfqlSQVPGk/IukYui1C9eRg2ey21rs7MCsSGaD0l?=
 =?iso-8859-1?Q?KA3n+7irpi3paRSa7xPOqNM1VDh1hPzfz9hqNz8NDd9fZOV3InKQ5Bv8m3?=
 =?iso-8859-1?Q?qkbBnw5CAX4eBUMhY44OoP5nd8mDX6IhrC7QC7Nnwg3tjLSFcQGZYu64mI?=
 =?iso-8859-1?Q?QZZkqyouzuKyQkGGGHmW60eZLdJu93Vm31ejNacUBa9+qLEOBseObP2rTS?=
 =?iso-8859-1?Q?/HPLg4gAsdKDAfFLr6z0Gp6mzI5zpGT/XHDkeXbyGuq24y8XF+j7XCthxL?=
 =?iso-8859-1?Q?KhAF2XOi0/EFkNn8q3Q4Y1iiC0KJf5UHCGAcovLoPA8TZjFJb09kVjYp9U?=
 =?iso-8859-1?Q?2gBZXjJ+N2Q6jN/iedckeS/hovjJtbRtfv+HL/c7TAVKPIf+Vv0w8CZ+by?=
 =?iso-8859-1?Q?Q4/EbiAm+BglefNpuSNtjggHBPEMi1LbVaE989NEu2v6KJ2uVuAjROJJRi?=
 =?iso-8859-1?Q?UY9TnyeKRvOa1jNQm19jiVgFc9qwbkOTUYHjLx2gdPZyrkEeVYOCk9EyWW?=
 =?iso-8859-1?Q?v/kTPpFwph1AEQhOZUknkCvZm0xHdlF4lN61SgU5FEtjv6K/vemPBaRPt6?=
 =?iso-8859-1?Q?eIECAs8I97+ETHT9y/4QmyeXFDB0RuozejnumGKENGQZGgfwUf+bnTaajs?=
 =?iso-8859-1?Q?9wpAS3Ll3sJLgG8saNZbj6jcQbqiF2w4ew4DFgcYYlqE26rdF2WJ9t6Fe8?=
 =?iso-8859-1?Q?TnKmUup78fbRbmaphZ45TisyHU8PgKx7aMpZdPNsN5RRyaOAv2FkPtko+u?=
 =?iso-8859-1?Q?hmUGBQvRWPibWifo1fxUwBwR+xQEvh8kt8Ef1AdBxKsO1fvGdcIpaOwZO7?=
 =?iso-8859-1?Q?5ALUwJZSYnrVXnPZ/IYgXDlU/GbD367W5rNnYJ4BmwfEbUKdvQQwnQcOZR?=
 =?iso-8859-1?Q?00uXfYF9swj3bWsqzShx9T+eDDmFthgCllVK5hzDS/ijHFEIvLLFv7XmBi?=
 =?iso-8859-1?Q?8scYDKMjF9OkVlrPfsxuAZtBChmGHKxfCuqwK9cIcLYum/JE6R+pfr/Km5?=
 =?iso-8859-1?Q?YbTEX2HsM+OVrZrsspeFNaqQEoqGpdykjBDnj+OKXNSbu7bFEuBIQ5RHGC?=
 =?iso-8859-1?Q?PuuTGVQwOK6wyneD64Sr8DYhj9U4mF8cdTtnEHy9pUD17kz1bNZUJ2nsyA?=
 =?iso-8859-1?Q?dvqhXaitIEgbwWQ/GVhQE9LmPUgpirhhG3qUu9TxFt52UHM9sa8nlvaoYs?=
 =?iso-8859-1?Q?FYrds0VponV7YfscUoZxeXgyNv23pXLYqmUrucX7PL6bmwaLB5t8mkr2rh?=
 =?iso-8859-1?Q?yl42vDRXKG6qLzQ1rSLQ/PXWeDN5A1R4ZKLGTq8le/WGLTnqY/0Up8DjKv?=
 =?iso-8859-1?Q?Yo5K2IDhXai6RLg/AiJXExb5eXeLqeh86aH/iIgC58nqj3+RIi/M3Y1B5r?=
 =?iso-8859-1?Q?DVr768YJFrD29wHhOfYAaRtmZktK2fvR2EyumZBL+PcJQtLtc8PDtfqlkV?=
 =?iso-8859-1?Q?bN1VAQLnnLhiYpB4wncCGtwqyjGMoiXoHF7rr6TGWA3qkNWQTsbWM7VNyn?=
 =?iso-8859-1?Q?dG1IGnH8PBU3S5Q4ZW8gL8xqDHYQQgvlpCdun8kfvybo2Vgdu68H+hpg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c359ba1a-a649-4a10-fcd7-08dd9968a14f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:41:22.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7NJH4asKKpN41QlXpBbBJLFvoB+6kwaeQjgxQmiUAbqbnbn74RDlG9y39IdD/lu+0asFzr2/EmcsDS8+cGj+1N+iVLwSRGeB7H8kdqnhVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 5/21/25 18:12, Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> > [..]
> >>>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> >>>> +{
> >>> So this is empty which means it leaks the cxl_dev_state_create()
> >>> allocation, right?
> >>
> >> Yes, because I was wrongly relying on devres ...
> >>
> >>
> >> Previous patchsets were doing the explicit release here.
> >>
> >>
> >> Your suggestion below relies on adding more awareness of cxl into
> >> generic efx code, what we want to avoid using the specific efx_cxl.* files.
> >>
> >> As I mentioned in patch 1, I think the right thing to do is to add
> >> devres for cxl_dev_state_create.
> > ...but I thought netdev is anti-devres? I am ok having a
> > devm_cxl_dev_state_create() alongside a "manual" cxl_dev_state_create()
> > if that is the case.
> 
> 
> But a netdev is using the CXL API where devres is being used already. 
> AFAIK, netdev maintainers prefer to not use devres by netdev drivers, 
> but I do not think they can impose their view to external API, mainly 
> when other driver types could likely also make use of it in the future.

From the CXL perspective I am neutral. As long as the parallel manual
interfaces arrange to undo everything it "should just work (TM)". You
would need to create the manual version of devm_cxl_add_memdev(), and
audit that the paired cxl_del_memdev() does not result in any cxl_core
internal devres events to leak past the ->remove() event for the
accelerator driver.

> >> Before sending v17 with this change, are you ok with the rest of the
> >> patches or you want to go through them as well?
> > So I did start taking a look and then turned away upon finding a
> > memory-leak on the first 2 patches in the series. I will continue going
> > through it, but in general the lifetime and locking rules of the CXL
> > subsystem continue to be a source of trouble in new enabling. At a
> > minimum that indicates a need/opportunity to review the rules at a
> > future CXL collab meeting.
> 
> Great. And I agree about potential improvements mostly required after 
> all this new code (hopefully) ends up being merged, which I'll be happy 
> to contribute. Also, note this patchset original RFC and  cover letters 
> since then states "basic Type2 support".

It would help to define "basic" in terms of impact. How much end-user
benefit arrives at this stage, and what is driving motivation to go
beyond basic. E.g. "PIO buffer in CXL == X amount of goodness, and Y
amount of goodness comes with additional changes".

