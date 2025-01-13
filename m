Return-Path: <netdev+bounces-157858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFDA0C104
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F9163C34
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FD1C5F18;
	Mon, 13 Jan 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPnm25IP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA321B21BC
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795372; cv=fail; b=OT5hYG3o0uUVLt1kEjigf7cRK3fR4s7wAu2Wg1rgaa+O38lPjXH6CeyJl7dP9ZS6PtZmOYa4qqX+H54/wE161+NsU++KQuhHGKBCjBiD468TrsdsczFuaCzxx1XHZO00kHJf9oX4U9siIAe0Jib1C4K7QYfLomFszKPQMUbAuJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795372; c=relaxed/simple;
	bh=XgUE/zC41CH/iK4bAVsbQ7/fBIQkeVKDwX056kkB7KQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LYTn7zuHXyN4u1GApULO1bCrI50Po5x5kH8UX0yNIDz5x7JUT0B7hZmA9awMBwKjpgoKS8jGlaPl9gAimI4jKUaZFoIEfgTE5hf06D3QGCzzRVZwdT7MDOWAWK9SYTwuAHbf2YwVeVuvDCnzsBwMrOsWUl/tOz/4HdEYOv8eCTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPnm25IP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736795372; x=1768331372;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XgUE/zC41CH/iK4bAVsbQ7/fBIQkeVKDwX056kkB7KQ=;
  b=nPnm25IPSofl+7Y+EAZ4ZD+ZBRTObxPq+SNwcZGjtIhAoPWfwvRwVQRd
   PZk+pGX7OmrVzJo7PUP+56vLv911ejMCIpiUocl3FBP7TMo5jPBaybGPe
   YWZOO/KYc+q4d9f7jJDXzIkjQfeMWOT0Y37Z/8UgiC0Ox6AuVwn1j2pxh
   b7Ifs61thUd9uZUDvJIG0cInwAl3qC4ryUx3njZziyZUdie+73cxlUyEK
   Gw4JJdZGM0IG1NdkQRw41cwMWtt4KVizhyaM7tpwsqUjJVuzz0NiOWrXo
   fDzu3k5qhsuosmoPt4bOhk/THzoVeegV7kjyyqfPJmfEzcr3qjAthOz/C
   A==;
X-CSE-ConnectionGUID: mA6EAvPrT1a2579ILiPW+g==
X-CSE-MsgGUID: XKrtHelRSVKzshbNvQeYsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37190070"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37190070"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:09:31 -0800
X-CSE-ConnectionGUID: bv43w1+GTiG+/p6yke0Cjg==
X-CSE-MsgGUID: ToJik9GlRyCf9eAaskrmVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104439389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:09:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:09:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:09:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:09:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJxWFZ93BDaOpO4TTC1P2snhl9eP69+tpUSu2RJ+5JA0UPLppMYeLrUIcU8Rdp9+xDYgGi/S0+qFsE5iZQTcPLPZn3QRkIzU6mqFqvhJ5tG5b/4ii/QGJk4IuvdXZJaeGU/M1tibj39xfAj9hNaRs0+dZUOXzB98WpWsvdrs5ac9oeG3wVmY6lZkzE32mlCsb+RIwCAet+pHr939e4xXoCmg+9N3uezQX591UBcDtm94NDDjN4M1jw4zqiwCzkXqNwgSjV/1PAf0OyYsscun/qpGyTrD8/hi+LPCuYkaJJYTJ8CvLl5QAvt1mmbQMCUYnV347aSrHVzs1/n0pohjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNDwTKvIouf3mylPcebhbBa+sW/uRqYiB32PZY9iRlI=;
 b=fR0jYpgww0TmXPoggO5Np0ii1UuSD39Zjqzr6VXfI1nFP3tOck7GA5phwiG/64+0LMR9C3+XAKz4P3rEiK08aBYVSv80T7o2aHG8opApqthKn2FTlvArynLjPq8qNGAQA/W0GkASLNxDat0QzY7y8IfOEjNa9DrxzvSqbkYIjY+kiApyn1LtZp39D3boFRUaSE3mPw359w7ETsuYtOA2JICQWNT0kUKByhyrghJdZSgUDpwZ3FiLhVLGStCz9BA+XuBcSmcSgNPkAUkuw+5KLK+IF4jqQKeVT3kTY/MqXA3n0FbSUj6y9plhsNoz7zcIw9Y3hdgBw2meSDr0MKIZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5763.namprd11.prod.outlook.com (2603:10b6:303:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:08:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:08:59 +0000
Message-ID: <3aa54823-f548-454d-82fe-a91fe5dc29aa@intel.com>
Date: Mon, 13 Jan 2025 11:08:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 8/8] net/mlx5e: Always start IPsec sequence number
 from 1
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-9-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-9-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 741845ba-f7b6-4013-2351-08dd3405bc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUlzQnJNQkhrbTNNRlFBUlBkZDNaMXd5Q1dRaFJrNVBKR1lPbE9jYitHaVcz?=
 =?utf-8?B?QmVjUmtEcWR1VENRdGhING83dHR5RmwwTHBidmduSEUyTS9ZdjNGWEc1RVY2?=
 =?utf-8?B?OVBzWkYvcWh4R1JkaE91di9EaXdCNXE0SEpadnVEcldrUy8veXcxVzcrZERJ?=
 =?utf-8?B?ZVJHN0NvY3U3Y2ZueHJPWncvUXAvQjA2dkowbkowLzRJRzIrL3lhVXBhSmZP?=
 =?utf-8?B?K3EycVFEY3dWd3h5RGd6QUgwT0lNN0VHNUU0a2EybzNRTnVVV1pieGlkMmFp?=
 =?utf-8?B?RWYzU0FZTU5aOFY5WGt1aitWbTF6UXB1YlgreEQ5dlBGTzlYMThPc0F4b296?=
 =?utf-8?B?bS91ODJWck5vOHMxSlk5VXNUblREWkRCQU5rUFYremhwTGZVeXV5Mlh2Zk03?=
 =?utf-8?B?OUlSR216L2ZNUjluOHZHM2p2NkQ3N0NzVUE0ZVh0SWl4RU52aC9TdHMzTVk0?=
 =?utf-8?B?YmtRd1NZMWd0TXhHWEt3UUFWZ2hLTmp6VVJ4aDdxalY5d28wekhzc0xDMnJ0?=
 =?utf-8?B?dURRdDBNKzkycTZsYUhwWDc5bXh4NVVvdEhpd2NuRDNWbkREcWNzc2VJK25W?=
 =?utf-8?B?SmkwbU1ta0VLL2thd0ZRYmx4K2huQXhVRFl2aGNOTXZ3d1o1MGFzczRMT2xs?=
 =?utf-8?B?MFJIT2drQUFxWElieUM1amlocnNQQzdUNHQ0cHNNV2p3cjdzNzZ3QkZjaDdn?=
 =?utf-8?B?UDBvb1FDNlk5T2cxVTNueXQzSnJ4NDdzSXY1M0xQTGtvbGxSMTFucGpxN0JO?=
 =?utf-8?B?RTJEdkdPcmg3VkxIdmRnUUdjaS9ZN2N4Y2ZqczBDdXJNUmxhS1BYMFJxbGM4?=
 =?utf-8?B?L0lGRHhFRDQvVDNHSkpWdXcrNk9ydmIrdHpkQUl5VUhIa1R3di84bWRtbUNy?=
 =?utf-8?B?WjRoUHcwYk1ZaTl6QkU3QjFCMmgwK0lBUmt3aXNDZlNaVExMOXA2enpKeEU4?=
 =?utf-8?B?TkhaYlh2RmpISVdmSjNkRG1KTDlyY25sRVlFZGYxd1pKdlpKbHVGMmtuNnd1?=
 =?utf-8?B?QUhhOHN1N3I5MmZTWC9zdXh6RkU2R3YrUzhlNDhTZERTKzBscDFtUlVKU1Fw?=
 =?utf-8?B?c2UxejA5YldZUERFUThNaFhrMHUxZjhlR01sVGtVRDMrQzZXVCtFZ3QwSjhG?=
 =?utf-8?B?YWQyK0xlcGpsOXcvcXMyQ3NhQ0JSeURhbGNDNzhFdVBvRUxZUUtBQkNHZ0lv?=
 =?utf-8?B?UW9YcEM1SkkzNjQwQ3hOdCtobXd3dmpLN0l3VGE2eEpoRHhiamRqZmk2Sk10?=
 =?utf-8?B?ZkVvL3ZZT01ibUE0S2ZzeUtNZ3VKOUJkem5PZk5NdFE4NyttR0xYRmxMczhX?=
 =?utf-8?B?djQwNm5IMk9nWDVmY2tkZWRhVTZkMlpmVWhSMmZtSmlkK3BCRlZaT0l3Yzds?=
 =?utf-8?B?dkZxWnZhY2JQcnkrZEI5RTYzbGNTUzRCM2ZtQnBzUzgzcnYzY3Njd0k1UGlH?=
 =?utf-8?B?ZkFwdFJTVnZEaUYwWFI1Ty9zaGpJbnpzaUsxbEhrbFFCNVNFZEJiWTc3MVlp?=
 =?utf-8?B?OUt0ZlR6RW5wQm03dS9WQ1RQYk9aZ3RPbm5LWnp4Uks4TVlyTVRrdkc1UGhP?=
 =?utf-8?B?bjRUcnpaeXNtck4yMUVNVmRjdEVENEkyRWsrbVlZbzIwQW05SEZYUHhyK1Rt?=
 =?utf-8?B?U1Zoc2J4N2ZzYXZ1Unl3VFUvNjc2ZHd1QWFWSUZmTHhIZGoySWdyUVBzamNP?=
 =?utf-8?B?S3pISE9oT3djWDVhem4xY0NURlppNjZlWGQ4dFhVM0poQnVJdE9jSkpCTFU5?=
 =?utf-8?B?ckZkRVdLbjdpRlVlYytwbmRrSGRSaU1aRTdEaE1XeUdkcFBSTFBkQ0UyK25K?=
 =?utf-8?B?M3N0a2xCWm54azRVazIvcnVzWmk1NFEwRzdPdEVQVGtvZ1RxdjBIM1Zqangv?=
 =?utf-8?Q?3MmptP1U563cx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNTdWh4ejN0V3Eya2xUS3ErbEFjaG9PeE5nc3BSaGJSMm1panVOUlNROS9o?=
 =?utf-8?B?d1lpd0dEVTJJS2xWL0k1cVQ2emRaZ05CQnN2aGlzSnpoSWk2ekNIWUppdlhr?=
 =?utf-8?B?T2VnYUlZZWVUU0I1NjBXRTVySkYrQ1hGb05EMWZMUjNpakwwQ2F1VTVQcDNk?=
 =?utf-8?B?Nmxua0lMbTB5ay9MMHpMaDVJd0szQm9GUW5lRVExQ1hhSDZQTnN4OTlXUGhS?=
 =?utf-8?B?VmE5Rzc5enVFMEc5K1RMRXYzYTlrWWUwQk5mcmg4T0o4NzdURUd0cFlhSGZH?=
 =?utf-8?B?QTJ4Z0w3ZlhRQTlFanpvWDE4WjY1TlpPUG81UDArdEJUOCt4V2xXbGlJbHFR?=
 =?utf-8?B?ZEwxcE4vZWIvdHlicUkybEJQMGxzOHVDdTBzS25zb0lnVzdIaE0wZ2svNlpp?=
 =?utf-8?B?a2NKWDd6RXFnTFpLbmMwUkQzQUxkUkpXYWc0UWlqMjZBZHJNNmp2RjlBS280?=
 =?utf-8?B?UTcvUzVkQmR3VDV0Y09PdENacUhFZ0J5bExIWnJmY01rOEo1S1JCNWhJMmpV?=
 =?utf-8?B?akpmSm9HMmIyQXhVUWNNTFVwUXJpUk5XMU1IajFlOHlIbnJjUkNkZ0lDOXVT?=
 =?utf-8?B?YS8ySklFRHhmR2FySTNJcVNjWFhqQ29za3BkOWlYNXVNVUFLb0I2eVlpT3U5?=
 =?utf-8?B?NWRoT09LclFaeVdKeFhmK3k5VGlVMGpFazVYaEJTWm1vcnd0WjhFK3dMcmYz?=
 =?utf-8?B?eUdtdVRla3ZoVlJsSGZlRHE5T1BrNEduT25PMmhMenVnOEJ4T2pwOVAwQk1s?=
 =?utf-8?B?RFZoeDEwYldsR3RrWU9qYXBXZk1aUUJJb2lPTkwxWml0Y0JvNWlqN1gwek5F?=
 =?utf-8?B?RWR1RkZ3bFl5UGMzMUU4NDR5Ukg5eW9kUG1tU0NvVm44aDB1bnJ6SWVubWZO?=
 =?utf-8?B?bGVXMDh3NzdobkdoZXpkdWRUYisraERZUWwzUXU0MWVNNnRrY3RsQnp6TmVX?=
 =?utf-8?B?OUx1SElualdUNmZudG9WdzNuOVlPOHZJUC94QXNHamNzVDdHa3lkTGpDSVo5?=
 =?utf-8?B?SnhCOHIxTWpCd3cxWW95ai9pNUI4bFNENFZuT0xSemlKa2c3TEZNaVdRY25l?=
 =?utf-8?B?Qi9SNS8rTGZaTHhjMndJeUhiaVJzT0xKUnRQRTlNODZnVzF3dngvdGhoK3VT?=
 =?utf-8?B?cEJPZnd6WlA1WlZWdHg0YlM1eGVsUlpEMDJheVpGZnE1VDJxdW54MHlKTEd0?=
 =?utf-8?B?Q3VOc01laFBlL25RNEdvUWdkMDdzV1VpcGNKNXhiNFBYZUpkSUV2UjdQd0c4?=
 =?utf-8?B?cVdKcHZPTktQMVd6MzdGSEpWNXI0M2h6WGUraEVXZDlpNUlmVDZSSDRGZFEz?=
 =?utf-8?B?SjJMcVZ4RUpUdkpTNlJQV1NEZUppbUI1UDVIMEwxZkhDQURmbndyLzRFOUhE?=
 =?utf-8?B?U2dTYjBpTnNubmdIaFZTMWl5NmpYeTZxTjRzaDY4TjFpL01Lb1RwNVZYYk5G?=
 =?utf-8?B?REFKSzRuOUc0RloyODYzb1hDK01BN2hBRUt6eFZwOXo1N0svLzlkUTdBRmlG?=
 =?utf-8?B?YWRmYVZNQURtdnhwV28rb3pJZG4wYnc4UFhvVDhPM2JUdW9UNGlKdWlEVDNW?=
 =?utf-8?B?KzkzU0ROSGJ5OUJQT3NOVnRleTZkRVRqR3NVNzZzcitnVDFJdERWQ0ljSEtB?=
 =?utf-8?B?eURMRXFwVVNuYjVlQ1hUL3RJL2RtdGdRM29KS1dFVkJhNFFORGp2cVlWSS9V?=
 =?utf-8?B?SVEyakEyWDliQlh5Si9UbHNiU2pYaW1DNlZXclNSWGtpTm9MUDRWYmZUdVlC?=
 =?utf-8?B?bmRxY3pad0F5bkVLQStDL2FKYmRYNmFHdWhTMnVjUUxkWHl5ZXlyVnhmcU9J?=
 =?utf-8?B?b2FwUGpHVTh4NmhhZU00MTM5c0RlYTNDc21LbXpnSGo5eHhUNGpCekVOYWV1?=
 =?utf-8?B?cC83SExSeVNxRjdwT1ZLbzM1dFh5blpGTE9ZTVA0WngrdUU5QUtVSmV1MnB3?=
 =?utf-8?B?QXJXN1M5dWRLS3daTlYvYVdoYW14dHdFMVNmY3V2SkhjQitibjc1Y1pWYVZl?=
 =?utf-8?B?d0pKM3ZHY2twdGpvYUExeDNleDdRVURwN05nZjN2UVJIZlpCU1o4VDhqNkFG?=
 =?utf-8?B?eWxoVFBTQjR5V0JOajdBcTVpZWh1ajM0ekw1SGxLb2YzUXJReVE5bklnUUZG?=
 =?utf-8?Q?SoavnH0g9Mmki+/ZhUBuHottP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 741845ba-f7b6-4013-2351-08dd3405bc70
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:08:59.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHxTf7rVvS42wrNl4TjnIFQLfqiWB9eghBpPFQzvrCdfcX+/ol1reoPJ4wjrJ9TpTAEuCeGmyCgBavw/vdWTi88vGYRal68SiHWvj/58Xx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5763
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> According to RFC4303, section "3.3.3. Sequence Number Generation",
> the first packet sent using a given SA will contain a sequence
> number of 1.
> 
> This is applicable to both ESN and non-ESN mode, which was not covered
> in commit mentioned in Fixes line.
> 
> Fixes: 3d42c8cc67a8 ("net/mlx5e: Ensure that IPsec sequence packet number starts from 1")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

