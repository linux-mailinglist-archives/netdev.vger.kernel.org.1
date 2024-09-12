Return-Path: <netdev+bounces-127924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1B9770F6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17CD1F217C1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465911B654F;
	Thu, 12 Sep 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAGn6m2G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0B186E46
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167274; cv=fail; b=O9s1ljx0sWXOLZ0Ievn9Uow/mlO7C1rTpdKMckEJDtCb4ZHtALZnpSo8mptRK+aEzfhFv4oCCHIPgImQ0otfSP0ZgSqFXaUncnfrinn1CY6IgA21/c/wRaIzJfGgYYrEiVYEd+HBrClqBNTpuz15ACnFv5AylcNM+oKffY/4V7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167274; c=relaxed/simple;
	bh=8DTDe70rVEu3DpkNxy3kZaWrSo8VRNN01fQCjK5hAX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XZfr+tK0ZK45pSlZdhNrrZgR+GERkUfpZZrumJJdLVpE3mtU4S8dk7tvi0pmeAkmbeoSZttP+JdvnsOIqtk7DcCOMV5lisWJ/uUOJQh+GF/Vg3PEqaWcJU9mAJbwSzqlU/P6hbrtTQEfvlqgIO9ZFvzKZpzsQ/jhFjSZYREfPxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAGn6m2G; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167273; x=1757703273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8DTDe70rVEu3DpkNxy3kZaWrSo8VRNN01fQCjK5hAX4=;
  b=JAGn6m2GNptSZCNaDOcefUS0HWvfOp7dLIH3UoGwr6Eu07nxRqWfRdbl
   M9WcCmJTo8m6zcW1f2N3oe9kC5EVMEK4/tlD449hZPzrHO56kYZqWBQ93
   7c0TBJMlyDUAFYgjTNwtf1aN4zQbKMDDLpDRNiZgFcIKwHnvHM6/849bN
   4gSWLV1rFC94efb8hTQ6LVniCvJP+uKPmBoMh32vbZ8ADw1kuHxoPO8Ck
   DqAN3LBib26I26g4ic2319n8IShcKi4er7dp0A/Pvv0jZGWjxxqg5XnqZ
   I4qxry3XY+P5K8sDe54BWQ7ahatoCw/IjixEOy81T3dQ7LEO1TLPtpJgu
   Q==;
X-CSE-ConnectionGUID: 8IeMQMvHTuOtoE7lmf5UTQ==
X-CSE-MsgGUID: TZOT2NXkTJKqlFfKCckwcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="13501048"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13501048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:54:31 -0700
X-CSE-ConnectionGUID: KJxItSXDTDKibgV93l3gJg==
X-CSE-MsgGUID: /EAlZXZhTVCZ1Gl0GHUDgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67735565"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 11:54:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 11:54:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 11:54:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 11:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEt9f+2aOVhCmZgyyyggtI3FaYdj9YLTwj7a1rCIjWTH9U/iTmng3dS8tt85lZ6H6kiy/F7w1eUI9bGMH7YCy0mPGPy07sXuWNV9w0WVX3Ldn+udAt5PD3ipi7xu2B24CvHBcyXt2L6oWuOJAn0wuOS/1U9n5wqmSZkSz3V23EkL5Mnff9M+QEQuydduh+tf690sTVl+41MbGEnm1oNx4nDA+yXcvgcGljTid8bXwB6jSSZ3fkSCC8kLIjf8I8SuLIQrXsaG+uvmDMKg1t+wOjJ1kUyOup2p52jluOIJejg2r+lvlI/Bj8E0K5dnXXmKJxHoa/KDGGimXt5486S8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBE+KfjSAhXHsv7oG0PEGWw7OA2sGYHxip213I35hro=;
 b=xZjS2pKCaXEih3xq1obltYc2HfnIjhxD+97SM2HmtUXZNriNclanWA5J7WotRqDAQLV5L07UCJ6fknUGNeALnHKQ+N4sn5IBF7/gtbdaXj3kCuO9uWskim4EyDg4UHsbWVdWtYBjnnKCAHbrQiXlFEWWBWWIyR2ZIJZPW7mCPLpMX3RKGt6ieaqSJDR2vhhkRC6MXo01GYlS1Mpsg7TXw68nBOL+jklkFBeel6vSErMJ0uKr+GrsJyTVLBxtni/GHOiAxF2NLCPV/5asqNdW3A7FEhCzTU3Yg0YX3VCaoVGMFA4LAF0rW7BoVAoNvh67Rt9uUYXuenNes35ZIkbuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 18:54:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 18:54:26 +0000
Message-ID: <09a0eff5-af6d-43c9-a648-b76708253a91@intel.com>
Date: Thu, 12 Sep 2024 11:54:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 04/15] net/mlx5: fs, make get_root_namespace API
 function
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-5-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-5-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e609342-e291-4731-8fbd-08dcd35c52e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEtDdkgyRkhCSnhaMGdvN21JajdGc2NhTE16cUg1ZnBIZjl4Zk5yRGlPNHZN?=
 =?utf-8?B?SEdFRFNkOENjQWx6b2FEUk41b2VZNVJhVVZXWlRnS1dBS21OS1pYbzRiTVox?=
 =?utf-8?B?VllIR3I5RDc0Wm5ocmwydHlLQmRkakNWYlpONUUwbDZPZ0VzTStnRFBEbUhI?=
 =?utf-8?B?MXJxVWk3UG5SWUVYb2l2QzZFbFVsYUpkL05Ud1JZMGxOS05BZFBFdzRjZmE5?=
 =?utf-8?B?ZXVLNm9HbXIrbWwwVHdzYXp3eWlRRVp6TG81cm94aUFZYTNTYitJU1pRSXhD?=
 =?utf-8?B?clEwRmQyNUViSzNlSVQzQW5IVlpWU0xmSWlqaTZpdWZoS1NrSE5WaGJ4Q09h?=
 =?utf-8?B?aXNsZW04S29lMW1uZ29JVi93WUZXeERWNHF5RC93ODQ5UWtlQVRZcUg4RDF6?=
 =?utf-8?B?bEExb05TejNzSXp0U2hucW9WTTd3aDd3aS9NN2Zocmc0NVlUZXVFcTN4RW5t?=
 =?utf-8?B?ajYrME9DSzFGV1kzVjFIT09iTjh0dUF6QU1PMXZ3Zk8yLzdabjhkNjFnTWdo?=
 =?utf-8?B?WkFyYm1jQlFQYkhIZXVVdkNSWFNsVGJuMHFyYjBDYzVOSENLMXZiK1k4WVN1?=
 =?utf-8?B?U3lqckVHNG5FUkRTaXFFdE9GUjd1Y2JLLzNmZTZxdlp1OUZISjdmMVZVa1ZM?=
 =?utf-8?B?NjFPSW9NSlJQcWdBUTQvTXQ3bnlVeVNoY3VOVXNvSml3QWFoTkRBelJuVzRE?=
 =?utf-8?B?WVJRZ1d1Q3BHbjMxaHBvNk1HWjdqV1k2cG5iT0t4anpkM3o1N250ckFubUpa?=
 =?utf-8?B?M2FiclNVV3dMOEsyV0NpQXhwZjJpeXZXYi9oYWhUSGZyYXc5MnlhRHpWUDlR?=
 =?utf-8?B?Mlg5aGt5K3ZvbFoydmwvV25qRFJvdXVuUFhUU2pCaHVwQ2F6OEEwaFlDb051?=
 =?utf-8?B?MnpudlJQeVJscGV0L0NIbjN0Mm4wZW8yUkNWOEtCWEhBK0ZES253Y0o3RFdV?=
 =?utf-8?B?ZlNwam5IUi9aL0JWcXY5R1ZYdFZEdk1LakZWeHpzU3A0OXVCZzY5QnlIdysw?=
 =?utf-8?B?QmxESXRSN2I1TFREZmJyZkFVMytMVlRKMFRHS3ZHeTQwSnc3UVVESDdsandY?=
 =?utf-8?B?YWF1aFc4RERNLytiVVZDK0hwM1NPWFBobTlnOWo3OGlMWnZBNk51U3RFWUh0?=
 =?utf-8?B?ME1YMjVyR20rRUR2bkcrQzFqLzR6RytzU2M1b3BWblU2Tzc5dGYzdWJxeml4?=
 =?utf-8?B?RmEzVW9lcnVrZ3JkM3ZvL0k0Uy85M0JxelFJa2p4YWIwSjRCUG9jSUZ6YU9R?=
 =?utf-8?B?OXpkNWhaYWtwQzE0bG5EUktJOEk2eXpsalFYWFY0MlBPY3doWkxZYmpmWkVH?=
 =?utf-8?B?aCtUUmxJWTFyRDNFenJma3Z2YnJRUUFaS2ZlckVGN2pBMG5DNlZORXltSjB4?=
 =?utf-8?B?N1N5VUFmY3lKaUZDcFZoQ1RKcjZLWWhNL1lXVWZqb0xxVVB1YTJ6Q3RkUFJx?=
 =?utf-8?B?djZaQ3AzYUQydWY0a0FETnB1WlRZYWRaTW83YmFUYnhoUHlNd0VlNWhkY0Vj?=
 =?utf-8?B?REw2UGVNVitPbVhSN3pKcnZ5WlJnQnRmQVBWT0FVK3FHZEpYMjJMTzdOWVFE?=
 =?utf-8?B?SG4vMnFuWCswYU5iS3FjRWczL21yenk4ZGY5cjNtdkwyQTlhY1NaaS9GeWdi?=
 =?utf-8?B?RVNiejdqbDIySjc0OGp6WVd1YXdDdG52Z3FoWitpaGJMMnpGZlZmMjVIaUc5?=
 =?utf-8?B?N3ZWaXo5eG5XQWhOb2tKSklnbXpNb0lZR0FJdTl2bUt2Q3FFQi9ZazQvNHdy?=
 =?utf-8?B?UjJXQmFlUUZqc0pRWmRCRUI5UURWbHdGTGEvUWxsdmFTRjNxRE56aXZndDlw?=
 =?utf-8?B?SXBpSkc2VzR6QXdCWmM0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllZQzFSUzFjcTMzMWprejJhNlVsUm9KZ0J1QzRFdUptVUhxekhFVm9keWZ2?=
 =?utf-8?B?MUhnRlRNdDZLRHA5a3hjSUd4dHZMVVpNallQcDZtUkwrZy9scjdVSzJMeDZS?=
 =?utf-8?B?c1ptWU42Qm92WWVPT0FzbDF5UG5jbWNNUUVuWDBBMVdJb1NLcVRCN2QxUzNs?=
 =?utf-8?B?NGZMb2k5blFwdkdrWUxrRExjbXpZSi9MM1BPemxCYktHUWhaZmFrcnBWSzhk?=
 =?utf-8?B?aVBpZlIwazNQUk81emUvV2ZkdUk2UmZjQlplU0N6dENJaTVJdlFvamgvVlZX?=
 =?utf-8?B?SXE2cGlpTTRSaEZaeWZGYnR5SktHOEJNWCtUMkxBK3hTSVMzdTBvU05UTXZT?=
 =?utf-8?B?OUQ5QzlZemhPeE9xUFg0YVA1NFhRNTJpSWVPd1E2cnRtQWdXYTcwT24vb3Vq?=
 =?utf-8?B?MjJJRllLN1BpWExUVG1xb1lneVY3QTRwZEF3NEpEd2VicEFGUjRnZWJYbkNG?=
 =?utf-8?B?SnNPUFdSZGVFNkNEMFZpa2NMLzFYREtGRFZweCtmNjFLWENNTTV6VkZwUEFC?=
 =?utf-8?B?QXBRUElDR3M1L2FxcldnNVBjM29QVis5TktzZHBWQUJGRExGa2pnY3VTR005?=
 =?utf-8?B?SGZ3UnR1eVZpbjVOcHVnOHFrQVVvNncrSXZuNW1QWlJ3MU1rTXlqdjhyU3hR?=
 =?utf-8?B?Z0RRM1NQdVhZTllzOS9icFk4YWl0enN3bHFFQjdKV2o2OXFSakQwZWY3d29Y?=
 =?utf-8?B?U0ZmZGUzSjBYV2lucnQrNlAzK051WjcwTjdXbFo3cnkxeFU0WTNDcXVlSUEy?=
 =?utf-8?B?Q2FpK3llR01xRzVIc2g5d3pjRkxJdlB0blMvWTNTdkZ5dmxtcnFKUUFCTkgr?=
 =?utf-8?B?RDVsRk5ySnQ2V2JaVnpKSDVsNlZYcEgzR21wWVhRK3hYUDNEczl5YjQ2dzVG?=
 =?utf-8?B?Q2JTTVEzSUtQc3gxT3dteVNza2M3K1hwUnFUUDZaRFJRUDlUTHZzb3J4V0xH?=
 =?utf-8?B?dHdUYk43aitoSWx1ak14bzNRYytpbU5EK1RFSDFRTE8yVlRNUG4raEY3ZENm?=
 =?utf-8?B?aTBNbkw3OWVra3B4ayt4QmszemQwazJJZm02cVNYcndxY0M3UDdQMUZ6aS95?=
 =?utf-8?B?WnVkOWRVdGs4MTFuQ1RjT1hPYlorUDhHUkZMU0M2b3E0bCthQ3pYclJaVWFN?=
 =?utf-8?B?STdpY0l5UVV6M2lsTTlzQnVodDhMMDJWMDVRNXZRbFNJU0xua2d0MHhlZHdZ?=
 =?utf-8?B?NDl0L3p2ZGlGdHhHNC9QZ0VnNGN6UVQ4SGl4NkgyMW1BOEVuazdna3h5NVpY?=
 =?utf-8?B?ODM2cHErYkVsRUtPN1E2ck10ZElqcUhzT1ZZalFncG1BNVAyaGw0Z1dHVTh1?=
 =?utf-8?B?cmlROGNRQjFaazE4aHFxR0hhNGlWSW55YVp1eHhNb2wrZXpQU2UrTHR1YWd0?=
 =?utf-8?B?QjMwVEtiT1RKZi9wc3J1K01BOUYrMDR4MTRwc2hJaExWSUxJcHNoSms5VWF1?=
 =?utf-8?B?Ym9GOE5HVEFKeld5ZnhqbEZwRTVrV2kwZ2oxVTdubXIxenY4SmVvSU5jZncz?=
 =?utf-8?B?K3BMWUdmSGNKVnpncUF1UUJDS2crYnZtb0N2c2grL3NhNnF5MkF6dkJSWUVl?=
 =?utf-8?B?OS8vbzBJdU9adlErNXNMYjEyQWY3dGh5aEs4WGo4ZzkwUnJoRWRHVmc3My9R?=
 =?utf-8?B?OXFrSHJ0bWptK29iMDNtUzQwU0ZoNVd2aVp0L0FuRk5wNG1SM3FrUXQvTG9M?=
 =?utf-8?B?alI2UTJTc1Zsd2JOanBiQ2FKZEJZTUpuRVB1N2E3MjZOMHh0NHM2TCtoSGlF?=
 =?utf-8?B?THkwNzRMT2lWZ3B1WGlDTk5UT3pqNzR4eVJsTThRSUp1R3VFQTczZnc0emdx?=
 =?utf-8?B?MlU1UWtlM0QxS1VMY3lvZFVLY20rdllFUjZqaS8zMUk2RnR6ZG5GYis1WUly?=
 =?utf-8?B?Q1F1TnVYam0yT1VCZ0UzOUh5ZkI2UnFXOGpKenlJYWtRcDl2SU5HWDBDS250?=
 =?utf-8?B?R0pWbzc3SVRXVStJTlNpYVRpQk1wNVA0enovMGFxSEtHd0JjUGpScDgvNnd6?=
 =?utf-8?B?ZTNPeHpUSDlBRk03aTNCRER6RU5YOEhNdm1CeVhVZE1lV1JtNFB4MEJvNGdZ?=
 =?utf-8?B?NHJpZTRtT0lERUp5YkY2dDBTS1poWWkwNTNTbU1Pdk5xb09IYnQrVld5aHQx?=
 =?utf-8?B?eSt5RzZSWWlwK3pCRUxNOHRIbU55WlZiL3RndTV1ZWhNdVpoM0ZuZm1qVGlK?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e609342-e291-4731-8fbd-08dcd35c52e5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 18:54:26.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPz8yh72tKxPc6PU0/16yxtd+eDkzN9Tvx2c/W3iB5flR4H3TjsW4+/6ldlMBGmv2Dq+mijYWY6LQOhm6eWVjk37kAEqDOzr6uEf8ceYh+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> As preparation for HW Steering support, where the function
> get_root_namespace() is needed to get root FDB, make it an API function
> and rename it to mlx5_get_root_namespace().
> 
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

