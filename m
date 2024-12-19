Return-Path: <netdev+bounces-153309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70009F7944
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD45167164
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BB2165F7;
	Thu, 19 Dec 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW1+VNft"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755B23B0
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603106; cv=fail; b=RW64cNm4IeGVLGN20pDdu9y6RGet0vnz/xWuQdPdLRMnjb61BpqitZAYM7wH5VwEw5qQ7gpJDzrdrRsIDMFkN8tJmqNZmw5iWl4emidzf793Cd7yiC54W0ATrOspTRuJnDHTJtzuF9y3V97G0c++aPJ0q09Y7Pm1TRHg0I1Y2bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603106; c=relaxed/simple;
	bh=YNHhqyYtp8iYxZ3tFw3rucqJAzDp7FAyjOECu1hAxpg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QA3ZBIYE+8vCP6Q6UEqDrF97PwbEnghspZu+30wm16zni4G0JXm2T4JBnDTBN4BDwusbQFfq82ccvCIoSkD3LsrR+gwEIxEaRFDwYl4fwzSyqOy48lYHAb19glRDwOUUIh9Z8LhvKlYsdAG4OqOUOrLUace8LjCBWer2v4TpmI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW1+VNft; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734603104; x=1766139104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YNHhqyYtp8iYxZ3tFw3rucqJAzDp7FAyjOECu1hAxpg=;
  b=CW1+VNftIIa8vP3B2b/82p656q4VADMTZIFGwFGDM3jZlcFDl7VPxO7I
   2mzWiev97rZJvwuakVGFklGKvEP2ixSa3JathGj8ARR7aBvO3tA2MtLjW
   GfLXeDowuLSQlKJmJPcEPIWCMRgOOElArfVjdTUGkYH1gvUTtJ8dplcLn
   ovH5lbM61ugRejKdmag5+55RR7jSI8qF7JZEn3ctgGfWWnRaydE9VrAcD
   9Q3ymWjZVMJxM2IZi9cCvF0E7TJ5T/tqdTSiLCdMabagY1JY6sJl/P4tf
   6RwYfvJrc9PJht+A6htbf+NU1OJhE4aHQVghclMC904lKlwd0YiflDFDI
   Q==;
X-CSE-ConnectionGUID: zeCHnKpPSce3SMaDsWypGg==
X-CSE-MsgGUID: PapvfvD0SKm7mYmbfXYUxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34430882"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="34430882"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:11:43 -0800
X-CSE-ConnectionGUID: 1WYkr6VjRIWqsiBRlgXIzg==
X-CSE-MsgGUID: MrFKwBAsReWETqE4nFqzWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98965834"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 02:11:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 02:11:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 02:11:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 02:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7xQk9Lw5/jCSobrUALEuMb+qMGv9IOAx3bjvF76I7kdczmHghkamdalTPM57jIDA34CJigFle0AFP4yrRzFhy8T9QxIsOig0ShXLk3aggGWpv3DYWEn0RGH+fwpHnPOYFKy4TcIaRc13CP+bKjSjsdFwcGxAV6YxgI35vcOQZMArrcaAbimTnm7FXtro2f5JaVK+RBIA86aT22bOJKSIV6Qu0bKioc2+qdBNo2mM5hZm1tbMdQVIePoIqGf320J+D9t656UViqcuaQo8BoS6ARaT9Px2e7mJANA5zjqmslPGG/jJ5en6HDo756yagT66kTnTfIcAnAoeAHylgsJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtQbo4lz+49RRr5AiWrbS1XISvn3RiqBPDfUBhn0tHg=;
 b=mmxAqsfnm+iXVKudaGO70f9cE6rAzXy70JmVGCt8itafSvAPMN+ALNQF8dyVM7P6bMfqUYN+hFlgdywe9oZ49gJJU4BgTqzduYNltBJJslzN2Nvb1QQTVfTXGFX7QtFGdJQMjFdmJLkaK2V7RhungP2IN5wnB4JJxPLxwOGWBdJaY7lPde7BUiIYZV8IBO1Wvn3dhphF+Y05HEfi9tYBtbDZE1JpHZuHGVml6wjmQRMD/dReElRcMqcbnKFVdKbAUM5WP51nWtYSpR2Lbqxso3OiXOfYtZvE6Ag6/RG4GbUzfrpoOqTB7mSx+qZjQ1Nnvg5X93ZDRsYp4al2mQYM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:11:40 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 10:11:40 +0000
Message-ID: <e4376b2b-febb-42e4-aa7f-16cbb5ecfeec@intel.com>
Date: Thu, 19 Dec 2024 11:11:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 06/11] net/mlx5: HWS, no need to expose
 mlx5hws_send_queues_open/close
To: Tariq Toukan <tariqt@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-7-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218150949.1037752-7-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: c1799aaf-a5ec-4e39-796b-08dd201587d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWd3TzFqdmJQZXJqY3VONnE3Vldoek1yV1lsKzV6bkRaeUFKSE9ZK1dxdXdJ?=
 =?utf-8?B?QXVDcThQOEM0TlhxdDllUGhIaVNQaitZL0twQUx2cUNyTGVOeWh4Y2ozN0Jo?=
 =?utf-8?B?VHIvcnphZ1B6ZC9YN3pzUXJab0ZLNXZueno0UVVOcDR0ZnFxT0xFaTF1aXQw?=
 =?utf-8?B?a0dtZGFqNUJ4OXVwd0M2U0FKSjRvTlF0MjliOFRocy9WWHYrK0tRNzV4V2Zs?=
 =?utf-8?B?OUgzRjhUdGdZWTVUZDFvOGh2cTdtSjJVYXpNamtKeVFKWlNFUHNYWnJNRTdC?=
 =?utf-8?B?Tm5sN2VRWEMyOElQMUpBN1JaTms2Zmg0VGwzRjYxZnBLdjBnVmtuMHl5QnM1?=
 =?utf-8?B?UzNnMW5qM1cwRVVkWG1Zbk5PZktWZHh5R00vbVg1MTlBblN1OFZURnRHb2li?=
 =?utf-8?B?cUF3YkdJUTZ0UEU4TzFPZnBpNitqc0xxOU51RTZqakx6U3ZwTisxWjBjbXhp?=
 =?utf-8?B?NHhNc3VNdUJXWjVJWGFNMnMzSTNWUUcveG1VL2dDOGg4aXZPQXUzSHYrVGZY?=
 =?utf-8?B?RnlZYzVnZncvNTFOSGFvb0RXM0wzYWE0RURNK2pIVGFnR0MxQ05MRUFkcDNs?=
 =?utf-8?B?Y2RndDVaYnVWR0ZqRFVxYkl4QTZCbjR3VHVIMVUzZzZHOEFhSjh0WVk1cUpQ?=
 =?utf-8?B?OG5VeGhIdEJTbzczUEJtT2lSSGFVbGp5RFZqZUFJcWxwVzVTK29SZWo0Z0lw?=
 =?utf-8?B?cHVDcTdlRWFUYnhiR25WeWZFNEFjNCt1Y09WSVI1b0o5cnZnN0NHQmRjMURZ?=
 =?utf-8?B?ZHQ2cnJ6SWJDQmxGaVBEeHJaNW5OMDRyL2NyQllyZS9XWDdhWnMyQUV6TUln?=
 =?utf-8?B?MFNVQlhUSUd5VlBkMzBubEZLdlN0aU5DYmdkNWVJbmRXd3BzSTR0VVM2Qkdt?=
 =?utf-8?B?Q25jOXpab3hDYStYeHEwbTRmT3E1Y2d4RVlZSlpjMFpQVmFwSjFMWGdENkF3?=
 =?utf-8?B?S0VTTTFpVm9nSWZDMUh4Yy9wMnJPRXM0UmhqU1htVjE5cEc5SGRxZHlSZWxp?=
 =?utf-8?B?OFdnVDg2Qkt5d2kwWjRPMDltNnViYVZyM01DT0NBQXQrN29FaXVYZE1GMTVt?=
 =?utf-8?B?LzlLRmFIVnN1ejZmSTF1ZVFNNm1WaWQzbzg4cjg5NUxSM3RCOTh2RkthaTVV?=
 =?utf-8?B?WE5MRjBxV2YrK2oyK285VjUwbCs1UnRRNDdRa0MyOXFnakhFSlF0V1JiSDBy?=
 =?utf-8?B?WUZOSHEyR1NBMlROYlErbmxhYUEvSjZBM2hycUo2VkZ3SkRyaThZS0xXZU0v?=
 =?utf-8?B?aWU2S242WmpxbHFQeFRGbVlzNzJFQVZVbERTNitzQmVWcWJ0UFNqN2JITkV5?=
 =?utf-8?B?cytpL2xucEtnQ0tjb3dvMFlNdFZwSkc2V2lDN09mcUUyOU5xL3pNTDdRL0Zq?=
 =?utf-8?B?K2tvK1Z2M2tLWXhMMytoeHZLejNPNHVuc0xCVnNwS054VG5nWVEvT254VW5m?=
 =?utf-8?B?eGlILzE2M2wyUHd0dklJcTlTT1duZURlaUVpa1hGTlNGRHpDZFhiNStnR0VF?=
 =?utf-8?B?aDFmd2pnZlQ2b01sZHZKcHljNWFabmtJelBCK0dZWmxSYTZyWHVwdXhCaHFS?=
 =?utf-8?B?dkNoWXhiTDRXenlLU3YvRlJFY2tWZy9tQlhUYXMwWTlZRVl4VWcwSXdtUVlj?=
 =?utf-8?B?eGhoWmp6UXIxMFRSM2lBaDVlV3dBS0Y1Y2Y0c1JOeThrQjlIeXdSdlMzQUxF?=
 =?utf-8?B?eEtNVGYrM2dtbGdpYnRmTUVNTXRxVFFYR3pvWkhpd1RCQjhRdG4wOTFQR1Jn?=
 =?utf-8?B?c3ZWOFRwdDZwYWJJN1VXVlBwdzBQUGw1YlhkMUlOSEMybHptM3h0OUYyUjNp?=
 =?utf-8?B?SEdiaXhpaU1ETlNrd05ISVFQTTRSY2FRREtNeUl3QXNBZHBCb010dHdrdWs4?=
 =?utf-8?Q?OpD0ZlFwjws6O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm44djk1Z3dDbXJOMk1pWjArZndRdmJDbm91RGtrRWwzSG52TmtVMW9FcFE1?=
 =?utf-8?B?WVZCSm8vOHNkR0xDbjQ4Z1hwUlZCWmdwRnVKVElFdGtCVmx3T2NPdWV0ZzdN?=
 =?utf-8?B?OXlWclBXbjlIdHpBcXBncFJUd05WSXZsWHJadkNiR0pJVVBnQm1EcE9mTlkw?=
 =?utf-8?B?UjB5a3p3Yjh6VnJnaUZWZUxrTkpqaElGdkUyV0pSV1B4dmIxdWNCZ2tBK2p2?=
 =?utf-8?B?d25zbFpRWnZpVE9jOEQ1SlBMQWtwSU9OY05ZT2dvS00vUlJQbVhZTFkxcGpm?=
 =?utf-8?B?c0VtZUtGam0ybm5uMnMzdUgxMVhjb000U2dwM3FwK3dCWWhLblVsSUluUi9k?=
 =?utf-8?B?eWJacXVKMjRGenNjaHREaVBaVkRJK1NKbUU1MVVOMksvRm5jUHoyN1RJR0dG?=
 =?utf-8?B?Z25UMXVtR1k4S0wxVUxGQ1dPMmEzakZFMzNjd3IyS1hqMEhGRTNlYU95TnhX?=
 =?utf-8?B?Vk9EZWZlOXdYZEdFTEp4SzZOVURMSC9ObnBwb2d3cTArSEwzZElKbE9DU2Zx?=
 =?utf-8?B?UWxtaHdnbDZrUTRNL3Y0aFNvNzhMMmgzaGpMalVLSkVKS01WKzYrNTJxSkxJ?=
 =?utf-8?B?cW1rSXpDSnJRRkVrSDVaaUFWRFp6QzhEK3cvaFN5a1hJTmx0dmFJTis5MzZ2?=
 =?utf-8?B?VVZscE9LR1IrZ3dPQnM4cEw2Z3JrenNnbXZreHc5RjZMNTF1LzRRYVNyS0wy?=
 =?utf-8?B?UitONTRhYlMzY0VBM0hhb0M0SWZsSis5VHMzaGFvOXJ2L1BDWVlqaEpRc3RW?=
 =?utf-8?B?SkgzaWJ5d0U1ejkzRXpxbWZJR2ljdll3dlkxQnY2UnU3anhJd1dSUHhkNmFI?=
 =?utf-8?B?Z3RYN2FaUVhnbU1PS2VOS0ErRW43M0VJSC9tV0ZjejM3N1orOGYwZVZtVW9r?=
 =?utf-8?B?YnZvQ1dRMXFINklSQm5tODhUMkxyS1RrUjhZbldDdE90cWFsZTcra0ZNUy9w?=
 =?utf-8?B?dFk4M3pHa1ZkT09JcFZtUC9FRkdMcHdKUzl4cmIybVJCYW93SmxCc0VrRUtB?=
 =?utf-8?B?R1ppQitrc2JiRmM0MVFkYklaOW4yOWRtSGFOdERNNzdNcDBEaldQZ01kVDJR?=
 =?utf-8?B?N1IzSFVyK0wvcERZV0RJcFpvaGNnLy9ZVmZsakNmbGxIQ1U1QnpmdzVqQlFW?=
 =?utf-8?B?RXdhbXlmNVc3bXkrYzhsRVdVMkNtQ2U3U2tiU29VcjhvWVRKUlhkZE9saVVM?=
 =?utf-8?B?WGdObEx5Qjd4Y3JyblZ5cHdYbDZNTzk0U0VsaVVna2czMGVLcThOeVJydkhF?=
 =?utf-8?B?dTc2UjBtRnlybDNTQU83bzl3cVRSMi9KSjlqYkNGWmNvNlZOelpWSnpSbm03?=
 =?utf-8?B?WENkN2xCVGd5VUx3cHpjQ0ZibUJRTHdJS2RvZ01JdFoyVXVUcnJwMTlDdUdk?=
 =?utf-8?B?bkVKQkZ5bnhhRS9xcXlkUVF5M2ZDcldyMld0a1hONDN4MzZBd3duTlRwV1ZE?=
 =?utf-8?B?MXVaK2dtUllHaitQaWpZYjFZc3VtdVlVU1dtbHhQYVY1bVRUTkVnTXUrdzNp?=
 =?utf-8?B?RFliTVZ5OEk2M3JZcGNBQXdNVWo4NHdTdEgwTWtqUjY2NnFMbmtia1d0Nksr?=
 =?utf-8?B?NHlwbTV4dHNMQ1hZV1ppVTlrL0hjQ3l3NHJXbmR1UzFNejZaSzV0SXRqM2tZ?=
 =?utf-8?B?UmgxNUcxYjhiWmpiTmhVU1FoYWo1c2NaVjdMTm1KaUVHVkhOSDhqbW5RbW9O?=
 =?utf-8?B?T1BRcnBDMWJyWXQvVENRZmd0WkYrNUdMWlhjM0Q1TmxYbDNOWWtIeWU2Tm9O?=
 =?utf-8?B?bW9RbzVUc0Rnczc3b2JwOFgvd1VXZ2FEVTlHYjBvVkZPYkRONTlpc243eFJL?=
 =?utf-8?B?eEcwazZNTXY5b3VkUVpwMzNLMzBScFpwWWltNWtCMlg3bHgzeXcyNjREU1pT?=
 =?utf-8?B?ME1JQnJ6ZHowZGQralN2QWpVR3BKbEhITlFUSkR0QmNDYmJ6YnkrTk0xWXEy?=
 =?utf-8?B?SDg2Ti9uL0gwRjVEZTJQaTVYWDBUWlhDcUxTM1RBTjY2Y1haYVpWYm93Q1Bq?=
 =?utf-8?B?KzZPdm5FaUJ4Q3gzMWI5b2owYnNMcGt6NXZ4WmpLVWxwUnFtdVpMWnZSNHUw?=
 =?utf-8?B?Q295ZEp0RXduTjN6ZjhhWU1wUUR0czU5aktYTVB3MnJXb3BhUjdhRGI2Vkh3?=
 =?utf-8?B?c09VSjRmNjU3cHdkc3Z1NlArdGY4alFHOGtXUFZKekRuNng3bnB1OUJob0sr?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1799aaf-a5ec-4e39-796b-08dd201587d4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:11:40.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGR9V80ew5nmMRTr99z+NBcKVmVXYWzj96blg5ifax0W8dynE/Cov9cEjGrnd05EtySmp9EExf1FlD37M2UTzNe+pFZYUI8XQhbTwZacjrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
X-OriginatorOrg: intel.com

On 12/18/24 16:09, Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> No need to have mlx5hws_send_queues_open/close in header.
> Make them static and remove from header.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../ethernet/mellanox/mlx5/core/steering/hws/send.c  | 12 ++++++------
>   .../ethernet/mellanox/mlx5/core/steering/hws/send.h  |  6 ------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
> index 883b4ed30892..a93da4f71646 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
> @@ -896,15 +896,15 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
>   	return err;
>   }
>   
> -void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
> +static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
please go back to mlx5 prefix

