Return-Path: <netdev+bounces-166373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC260A35C15
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8186216B603
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1E25A358;
	Fri, 14 Feb 2025 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDc105a9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273B25A64D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530886; cv=fail; b=TJ5T+wSiQiktPyrzapFOaTgcUm+J+o56EATx8ZmjgdvJF7du17sjJe0T7X30VyyFrKHWuLGEDaGaaaoeEGexTnrcdAfCwggU5f8H+6h3UbnFLF7yIxUQnHASArKYY6p9vVKSL+1fVLot+7cfsTrrN7ZmYnMZSLS3Pwf9vaBZqEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530886; c=relaxed/simple;
	bh=DshHhNPdXwQiMbgbOmovaCKfTmxH6LJvtEcxZowucSo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9SmXj7FuwuVK7kRYdQb36r08ZUEkVGaJew5qrMaLOgVbv67keUydRwGpc3U+81Wq7672dJ8lwg5zOGrIw2Vd9cjDD+vKhV90klXNKb8Y7Tl5FZmsnnX1NNrGS3xFs7Kyd5anIvzv5wLSk7EpJbzEEUlq/HhtQE+qKuXN48QAIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDc105a9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739530884; x=1771066884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DshHhNPdXwQiMbgbOmovaCKfTmxH6LJvtEcxZowucSo=;
  b=iDc105a9B9UKgaX79JcnEm1Ad7q+/jZeTvqm5esmRsngwQ6iUJDNBWwE
   e82ZRdtdhKdYhv/Gcj7y36mnkPd1jy6HSmwi6JjVcEYQE822g9v2r6pnB
   0i4y5l7bXpYcxIiSWes1M6Fcxw3laITDdz259c6CXDNBgakvRld3qhWmb
   Qi4Uf6eZvqPVVBDYBAd5fOerpkDhrFwRk1t2Y9za+m4pBHhSbfm1S0H+b
   Nzyz2OWoCKfhWU4SUz99hHR6xuJSCvic9AN6E9gfrJlU4U5V+SVbYKwWv
   tLm6qWdXQR22ydBh6mZHqjSdl3POygQKvsJTieCoSKxJRGouJBohC3Nmk
   w==;
X-CSE-ConnectionGUID: SPCVUFR/QjCHktk8y8UuSQ==
X-CSE-MsgGUID: LPJsAh+rTEe1s0JiDIHCHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50902046"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="50902046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:01:23 -0800
X-CSE-ConnectionGUID: J//mfhLbSIGYsplkkds76Q==
X-CSE-MsgGUID: kHPasPXAT7mYLUj8B5l56Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117556491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 03:01:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 03:01:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 03:01:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 03:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMEHCSxMCGhsBjBdG08hh8y/z/2TpZdG226O4dGgVS/N8fw9L1owjlcF2bp2e8pus9ZHVYHfTABPNWeH0XAhjS95JTl8L4SVwOJj2i0TbBiUGIebnxNi+OLHzHEPR3Ob6x69A72IraGrB9DHAw0hhDHPq/A70NtKZQzcMQu24hPlWbmNGybp8j0ZIIFhud5tlnBvBvQSf5IT010NgLuaCHBrDiu3EqjBjXzaMYP+5uyHo/auJVur84xctbLw1d+Bbn2nxpNsNGVd7cXipQ6KLfD8lfWtqX0/tH8/+XyCgfXVrjlLUfLuWvOALjU3o7ejeSeOz9L9WGhPAQaoHr6WhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p4qeS3AhONTajdLmWpgz83myBEm6eC6nNx4lK0VoMs=;
 b=aTX5NA0OaoXd+KYIYtM0UpvHWCzNw4Sr/2P4sFLpfaWNJ4UpoQKCkejrmEtrNjMqyHlCdolQEZsIduHDauowpgWhsxU2fu4MvzZbkuxc2p7e8c1z/TfUZTnUJoijYE5DR9pygAgYcOv18DZYGeDMlFLF8uMOoY49ex+9Zk6gl9CkFIFi0u0kgaqP/fFIv3kXL4emF6WbGX98mR+leBStGIGWpDjU/rwS611eLcUio+b/tDNRm6jImyOchZI2VLSIIhvb6HknnPFLTwQCqtbAW//BPxkLY0pQ7BgiHfSO+I8whySBrvBC7aqIgbNGUyASv/SBVHQFZFpkWtgVGbuZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:00:51 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 11:00:51 +0000
Message-ID: <94e05493-4f34-4a34-b96a-63bb69aa3b9d@intel.com>
Date: Fri, 14 Feb 2025 12:00:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: phy: stop exporting
 phy_queue_state_machine
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <16986d3d-7baf-4b02-a641-e2916d491264@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <16986d3d-7baf-4b02-a641-e2916d491264@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0162.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::13) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ca2fd5-5208-4c9f-9342-08dd4ce6d81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkVXM1RFSWp5UkxVM3kxSWowN1Z3bzJlQWFNTTBXa2pSVlRQN3hoUUlRKytK?=
 =?utf-8?B?STR1dWh5UUc2RE1tWFRoMzYzQTdMT2JEQXk3dkZOdld1RjBxT04xaittUStl?=
 =?utf-8?B?V3JvR2l2Vk9ody9OYWQwSjRocW1NZkRxb0t0OUkzOFMxdWEwMHFzSmEvTnBR?=
 =?utf-8?B?MUQ0Q0F3cE1peDZqcVQvdUMzMnhsU203UkZOU0o2emYyQ1FpTWhtVTkwcitJ?=
 =?utf-8?B?NkdVTkZaRHZBclNmOExMeFNzR2hPSFJyUC8yTU1CZVBOTkxSaldwaGVia3Av?=
 =?utf-8?B?NzN0WEptQnBobFZvc0VaNnltTUlwYjJicWVPNysxWk1zRHlwSS9JeExyN1N1?=
 =?utf-8?B?eXdiOThyejYyUS9DUmh3WUhYRG4xVVRYQUZoM3JoUDVpODhyeUhpd25UK1hT?=
 =?utf-8?B?SmkvWjlaZGxqaGlkaGhWcStkbUsybFdtN0QvUEsvZHFuc1Y0bFRRWEhYUDAr?=
 =?utf-8?B?SWVrSXdKb1BIaVkvV0FGZUtEWkh5Qk5BSlJSZ3RYZHcvbG4xMkd0MEJFK0Nu?=
 =?utf-8?B?TURoRksyM3VSY2NHbDJ2cEkxTThHb3RJbGpuSXg4VGY4NS9GSnJ6RmpXdmEv?=
 =?utf-8?B?WmwvY3hxNUdxVEVGZjhGOGpjS0Y4cnFvQ0hLQmtJSGJvbXNYbEhOclJRSnow?=
 =?utf-8?B?dHpxWldWTTVkcmdIVHdWZXg3RE4zRjF0dXFkR1ltWHFoOWx0cjlSQWVyUHQv?=
 =?utf-8?B?bS91aUp1T1Z5VlBvUUp6WVpQNllsTDd1dGNVWGQzTE1ncXFCK3RCUldXeU1E?=
 =?utf-8?B?eFpvNGM0ZGdOc3ZlTEx2V0R3V21PaVhwUThpOE8rVlBjL2JzcjYzRi9HYlJN?=
 =?utf-8?B?YXZlckZnZFhqTTJVYTZTbTNiZDJDVHllcVJ1ZWlkeVgzOVVMRzRDeTlueisr?=
 =?utf-8?B?ZnFub1NhakVESTNaR3lZeG5ZQ28wdWUvTE5JcHgwdXZSYWxQMUVsUHVDK1hP?=
 =?utf-8?B?Rml2U09vbXdWeklQK2dTbml0eGtGOGdkZzVXZFJ6Z2RjQytKbXVoZ2ovdXho?=
 =?utf-8?B?UkVXUUkrWnJkR3gyZlRJUzQ5UVQ3ZkoweGVQNUxwSXdGWng5MGFOUWFXVWdv?=
 =?utf-8?B?UW44ZTUyRkJBZ2U3NmFxZzk4dHQ5d3Z5NElCMmt2YjZJQzVuMFN6andpekJq?=
 =?utf-8?B?ckpleFJXNjFEMTU3WUJ0dkFLZ3BUb1lDaWhKSHBnbXZ5RVlseWx5OGVjRTNY?=
 =?utf-8?B?Q1FWaEQ0Yy9BdXBJeVhWaUM2SjJSWWNRbWhnV0o3ZWhJd0NjRE84Qk1LeDdr?=
 =?utf-8?B?T0ZqZWsybUVIV1dhWG5qeFp5TFJxV1BBcy95cW1ZSkFPMkp3M2E4YnVwQ2xC?=
 =?utf-8?B?M1RwSVFPcG5LZkRjSjVzc1NseU1vWElyRFpKcWdaRi9EZlBqNDVYdUlvajAy?=
 =?utf-8?B?U2hVaytUckZSckhNYmhFT1hlZGJkdHBvWE44M2ZHeDYvTFE0eGprbjk3NElr?=
 =?utf-8?B?b3cvcTZWQVQ3ZmFSeE85cHlTME56VkFLMS8wNzBkaVFTVktmTXBPSTd6V2hv?=
 =?utf-8?B?WUNucllSbll6WXdPWXlTbUNVUXpTMjNTN0Q3L0M1eHBNVXBaUStxalE4Q2xu?=
 =?utf-8?B?Q0FxU2RuYmtPdHBvSklBV3IweGNyVytGKzdBYjBsaHRYOHc2M3prRVY0bExL?=
 =?utf-8?B?UDIrM0JKQlQ2NjhGcHJuK200d3dKR3JGUXh0b2wxb2hCV3h5RTJoejNNMUpJ?=
 =?utf-8?B?emtYOVV5dkxCVElYUkdnRTRCYWtUWG9tcWRteDJ1K2hsTCs2M1BJblRhcmtn?=
 =?utf-8?B?cXBUYlhFd2lhSWUyK3pYSjJnZnJ1eHkvL3Z2QzNLZCtJSWk3MDN5UjBROXpQ?=
 =?utf-8?B?VlhKMFVVWjA1UXdzSTJRQTU4Q0txOWZsQ25rRzdGeHpSQllKTm9XazR6VCto?=
 =?utf-8?Q?q80g78hrmDwOz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05jRjVXZlVsR2FOb25CaWpyUUw4OHEwaEw3OXZUemZlTXNidnhzOU83Q1JU?=
 =?utf-8?B?K09HOXUwT2YyVDVwc0F3dXRLTGY4SnRYVzExb0VMQ3ArSjJrNGVGckxOOFBI?=
 =?utf-8?B?TmpwSzYvdlRTWmxHREpZcXViaGFzYUJWVjVQaHU3QU5jUHJOVHpveFRnc01R?=
 =?utf-8?B?cXZ0V3ZSN3p6TzBNd2pVdXR5UHdWeXEwbmppbFBMUmR5dUphRXdrVloyV3Z1?=
 =?utf-8?B?eWt5QUEwOHF2dC9VY2FVeEswTzZTN0RKdnNjNkJmekU1aVZPYkl6eFBlQndp?=
 =?utf-8?B?Y2JBVTU0aVFxbjVaYkNpWWJBdzg3Nzd3T2t0MEhkbFF0QWYyNU55NUJwMVVn?=
 =?utf-8?B?UDBvcU01L2dtaEg2L3hyaEF4dGtLWFJtTEFDV21ScGpjODZzTUdlYmNsSnR3?=
 =?utf-8?B?c3F6NUl0R0pYNEZ6aFo5S0MvQTVQSGJLTDhwNmlCaWpWL05VbVJ2VEQ0b01i?=
 =?utf-8?B?b1g3VFh6ekRFVXBRNGhndnZuVjFHMS83cGNVcWlDRllXSkJnaXRhTVM2eEVw?=
 =?utf-8?B?UDh1cVpDZFhXaUJoNDVBUm96OFJvc2xZVHZwQTQzRHhsK1QyVlA2T2xIREt0?=
 =?utf-8?B?ZW00dEFyUngrRk1YS2dSMS80QWU1Tm5hR3FTcFFsYVZPSm1xUGNJeUxUdzY2?=
 =?utf-8?B?ZEw5VXBBb1F6b0ozVUxSeW9wYVA1SGtCWmdTUU40eG9ZVm9kL1RZK1ZqbVRk?=
 =?utf-8?B?RVBXTkVaSjMrbXFQZ2FrNlhvMDZQVmhrelRpMEk4ZlM1MHVpS251d1FaVWhG?=
 =?utf-8?B?QU9NKzd0WmhwY0NnNjYwTTdxaE41Q1kzdGlXWkQyc1BQQnRUSnhrQlZ3ZFA4?=
 =?utf-8?B?NVpTd1luRXRNL0N5eXpXWVc0Z001S1V6aVk2ZXZWeHdDMUZkdFhzRTBHTEU2?=
 =?utf-8?B?NXpKem1qUklhV1JlMkpFdVRzR3lBUk9IRllacnBUL1luN2R0Qm9MRmp5VmRB?=
 =?utf-8?B?V29aZFFROTFhWXh3K3VOOSswZ0d0M0Jnbjc4eGt2bThEK1BmWUtsUndhZWQr?=
 =?utf-8?B?YlMrQWFOM09lYXE4TmdCSWVLM2gwNWJCMVFlQzZ5MDgrZlRyeVIvWVhJRjla?=
 =?utf-8?B?anNHc1FVejNSSytFRkRsaDZmMGxpbk93TGw4UUpwYXdKNllEWkFoOTBFaEh1?=
 =?utf-8?B?QWdISlRPSkNxTTJvTWNoRWNoQ0lJdlgxS1pDc3ZZa2R6UEkxYTBOSkNZS1dX?=
 =?utf-8?B?QmM1bEUvdEdGNCtHVStoTUNKN1FoNnJQMWV1VHd0Q09wSjkvOUQ1dVdTNXA3?=
 =?utf-8?B?U2pzQ0JKcS9IR1dJNW03MmJhU2UwdnlscGc2S3NBZW44ZzQycDQxV0I3YW1X?=
 =?utf-8?B?MVdHU0YxSmkxc0hKcDZ5Sk5WMWVsRnpyWnQ0NEhjRGJRSjNXZXllYUd3OSsy?=
 =?utf-8?B?dDVXQW1Pd1FtTEJocWZkSFdleHFLTlYzZnZrZWVXbS95NEsxYmtyK3Q1SkZv?=
 =?utf-8?B?SWtDODRiK21NRTBob3l5NGdOZmRhVEV6d2dmdjkwVXA1RkxWZ2g2T0RvOS9k?=
 =?utf-8?B?NkFvUW9kTVdZejhaMExtVHFIMC9qL3NMTVZvQUdZR3hhNk9WWENXVlpWWkU5?=
 =?utf-8?B?WFNIOU5qMEMvejVZcHpaOTUxUmZ4OS93N1hlYW9ya1F5VDBDR1U1UHlkSlhB?=
 =?utf-8?B?R1I2aEFDRVQwV3YxZUpEMDU3U0tYYVFyTHZBbG9XczJFQzRmTlpvY2YramtV?=
 =?utf-8?B?Rng1ejIrcDZEeFJ0M1FDMXJOeFluYmJpMVVtYU5KR3JkY2JsV29JdENjRDJX?=
 =?utf-8?B?QVdiWXlwb3VvSmk2UENGeWdqYWZXaVJLL01UcDR4N0Vla3hRK0ExbG1lWXQ0?=
 =?utf-8?B?SXZPRS8yc09sQTNoUkQ1UGxYV0xZWDNSQ1JZUzgvVENNVVJjSVh0eXU2cmJx?=
 =?utf-8?B?WmtjdXRaNU1MYi8xei81TzJsWkhldlFlL0lwb2pCS3RINVMxZTBIT0pWNHlO?=
 =?utf-8?B?QWdBM3ZGWjV4QVNRWHdsS1RWamFGb2E1TTVmTkVOQWxFQmZqTlBXNU1jSTFw?=
 =?utf-8?B?V3phNVRLeDV6YkcrQlBkSWhKc296emswb1lrR25qenVQRXc0Tm5OQmgxWTg4?=
 =?utf-8?B?QmZLSXRycVVhNFBhQ0pkSWt3RC83NC9JbmRwTDE2NFgzaGIwbnduTDA5c2Nl?=
 =?utf-8?B?K2IyQSt2Y3RTRFk1eW4zU1UxUnJ0MVowZ2lVWTJNbGRDUmpvZGRDRjAwOElU?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ca2fd5-5208-4c9f-9342-08dd4ce6d81a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:00:51.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ab1XQycGxKFpSA65AAWPORxQQF+y9/fgoXmUKUsKNnSoQud7OJH7zUEo/Q0hOHbM+bI68IieMkwYKkP5MVpK4nSiftGf6VcrWYchgw8TQRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com



On 2/13/2025 10:50 PM, Heiner Kallweit wrote:
> phy_queue_state_machine() isn't used outside phy.c,
> so stop exporting it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/phy.c | 4 ++--
>   include/linux/phy.h   | 1 -
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index d0c1718e2..8738ffb4c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -520,12 +520,12 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
>    * @phydev: the phy_device struct
>    * @jiffies: Run the state machine after these jiffies
>    */
> -void phy_queue_state_machine(struct phy_device *phydev, unsigned long jiffies)
> +static void phy_queue_state_machine(struct phy_device *phydev,
> +				    unsigned long jiffies)
>   {
>   	mod_delayed_work(system_power_efficient_wq, &phydev->state_queue,
>   			 jiffies);
>   }
> -EXPORT_SYMBOL(phy_queue_state_machine);
>   
>   /**
>    * phy_trigger_machine - Trigger the state machine to run now
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 33e2c2c93..bb7454364 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2061,7 +2061,6 @@ int phy_drivers_register(struct phy_driver *new_driver, int n,
>   			 struct module *owner);
>   void phy_error(struct phy_device *phydev);
>   void phy_state_machine(struct work_struct *work);
> -void phy_queue_state_machine(struct phy_device *phydev, unsigned long jiffies);
>   void phy_trigger_machine(struct phy_device *phydev);
>   void phy_mac_interrupt(struct phy_device *phydev);
>   void phy_start_machine(struct phy_device *phydev);

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

