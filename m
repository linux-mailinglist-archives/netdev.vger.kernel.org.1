Return-Path: <netdev+bounces-90659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DF8AF6DA
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7581F22540
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541813D503;
	Tue, 23 Apr 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXFyQXJz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8A19BBA
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897975; cv=fail; b=TQ7gFFQok9ycFjgOcPy1lKzprFSKFlEwzc/FlvxPtxwogTaInW4cimLddaWWZpQIAPed9Fxy1olnt1Ep6gAKMV2b9oKqh8k6xKzVuVb6C9RSJCJtZ6WZw+rKIgVQVX6WrGEep6kv2c0RxoehdhAPmPyjQv8aOB/YX+DesA3MG1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897975; c=relaxed/simple;
	bh=YADr7ml9e6tFpbcX/Y4Dvl7QjhPmT3ofIB2JKNLzqz0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mp+gwGZyIDIfr0i1vffSjDVf3ydJbHXUmB/iTzw1aIfsIWyfQ1fVe2nKocJ0GRUM5xrjXsvU9qEdBSAC9vHNMZG5sQ9kMigF70os7dAcSFTms6ziY4jA6Ofx0uApgVqXa2mvCKCYqndUBxnZKjCOHhmjO9k8Xf6yiLoYUmBEHLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXFyQXJz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713897974; x=1745433974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YADr7ml9e6tFpbcX/Y4Dvl7QjhPmT3ofIB2JKNLzqz0=;
  b=FXFyQXJzLHUxX5x1e65GWNSeMkBkttHLUdk+uCgTnyG0PMq3kYMg8SzJ
   uEFWU8lDyCtbYmzTF2m+9vqAx4kJCqT5DSTj7X0mWEVmRUhkH2VEW2dus
   6TQZnhmYSNfXQAT6l8NafRwGLAZmg6RPDKdYXvNGVxl5Dai3Hs1+Yen2k
   0l2HNnaMcL6kRRsnnzvUViApgRetcxyWNOa/vcu6nJjXKO1cGEBFySmmp
   4K6GPGOx/X3RMRbFxqvc9VEGqtHsu56bZpMhiKHPrsmphB6B6VYEaM9gj
   equaxWuey618bv7uf93yY+yVToDXAIornuEH3LbTATrCZ/l/F+6ntn9iy
   w==;
X-CSE-ConnectionGUID: nxDcFe4gQDWysn98fEwcZg==
X-CSE-MsgGUID: A7YGflSpSUGfXugX9zhrEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26959175"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26959175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:46:13 -0700
X-CSE-ConnectionGUID: Le3bJkklRxGTfNjL+jvduw==
X-CSE-MsgGUID: X3+lgfWhTIKOFfvvvf9cqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24490687"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 11:46:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 11:46:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 11:46:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 11:46:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 11:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3rdXgJNJLEcKS0bwlHlCaACTq3Mh58qKqB6Gbi1p9bw2fM0LtjgOTXSTuBVYr9yDsuzGWr7be2ZOMTvkTTx/Wf0um+tWuPLn1UtRGhKrJ80G0+qvybS8xzZfhg0CMbuaVv6JuDbX+0WF67QUZlJ1TxJrPLjl/G68tC4CR7JlS+SMQmGDX+Bzm8sSiJrP4gcDW1lKuCcIh7Js6K2+D6JrVv9g2QI9MdRxWDkhn2K1euSOhTAn/9JzCIIxenfWW1bbR9jv01Y7E3CJhgRZY2a+HMd9snQWL0U61fvfhict7Dd6eZUwdj/sMY5hBBlbEPwmvLTYmxWDgqMMlvYCliG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vly0jpLkFDgD1IGCliWqlJp/JAqhYUNfgh8eclv2T8=;
 b=G9R5Bi/wZrwN1NB1YftYt8akc5W+ddkDlFaqQPl/wsTopoG5DfzGPgyBHg7FoTV6nmwGFgp0IlKSPHijJr4S0hvQVblp43aH5h8v40zwsn4UTdmSL7sf6IE/y8PjI8pkKaenNC1ecp7Ms7OGSHRXB4KLbCXN7lN4pKpiS/VBH40hO1+LLLyA9HYD2LDUL3UCkDOO3dPro2Ucu02VLEXkZk7sGZnSBlgyrvcviIlemH+DjhHKnkl1b4RQzcRGmrTQzDna6zp0tuIwO/uSAbnVDEBZ678Bgr3S6YUF60J163itga9XoMiwuWc0OkPWAyF1LS5kTFfEXTaGtbx7pITMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 23 Apr
 2024 18:46:09 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 18:46:08 +0000
Message-ID: <485d3612-388f-1d7a-f6e7-3d94d46bab16@intel.com>
Date: Tue, 23 Apr 2024 11:46:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net 2/4] i40e: Report MFS in decimal base instead of hex
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
CC: Erwan Velu <e.velu@criteo.com>, Simon Horman <horms@kernel.org>, "Tony
 Brelinski" <tony.brelinski@intel.com>
References: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
 <20240423182723.740401-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240423182723.740401-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a4c99f-6afc-4739-4301-08dc63c5a3ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGRUR0xmc3cxVUVBVVZBRGN5Vk5KZTBQelRXc2ljUG9yS3lHRlN1dXcrZFQw?=
 =?utf-8?B?N1EwV3hVeG5zZXlUUHJyU2ZVTWZleWc2b1pCaWYwaExHQi9iVVNxQzlCNllP?=
 =?utf-8?B?ZHpXQ2lEMkxjR1Q1eUNqY3Z2VEdjeHRXMUl0K1IvYlc1NlNESENZVW04MU5G?=
 =?utf-8?B?ci9jTGJyb2ZHKzhCVzdGVTNNTWZYcnJGbG9yV0d4Vlh5NVc4Ty9KNW1kSmVS?=
 =?utf-8?B?dCs0NzBrVk04QXZXa2Rhb1ZkTHJlZXJQaUtKU3JoMXZKU0lXTmZQSnB0YjBT?=
 =?utf-8?B?RitxaU1JNUd6c09zMXF2eW5RNGtmN3BrUWRzN2FKeGZjZ1Ayc05zdGRzb1FO?=
 =?utf-8?B?RjhyTFhQTysrTUgyVnVBUFI3V3JWSHpQOStuRUZDbVRjeGJlZkxsMFNXQTJ3?=
 =?utf-8?B?TFp1KzhrLzBzR28zdUFmOWRiT1FkNkx5UXdJeVprdW9vcmhwMEFpcFAxVCtH?=
 =?utf-8?B?a0w1VUUzVzJ2MU5FaUkrdVJUaTFYZVBVa1RNczFRYzUwZ2E4NXloM2lxa2w0?=
 =?utf-8?B?SitFQ0E5TTg5dkdYaENneUllNEoyTWZoK0FHNkpsV2J4UzVBemZuam1xakI1?=
 =?utf-8?B?eTBQaHNjcVVFbHZUUE45QXQvVjNvMTllTU1rVXVWTFNQZVhIcVRScm9lbnpn?=
 =?utf-8?B?Wmo4YWRwdDZOY1BzY3M0emZuN3cwZWhTbm5QbnkxNzZBeGlKVW04TVVSSnd5?=
 =?utf-8?B?bi9pZ05TSkxsUmh1UjVWLytIUnhFK256Q1dBeE5XRjErV1l5a0orUWRaL0xr?=
 =?utf-8?B?ekhoWVJ3T0IwTnRsSDA1aWdRQ2EwV0NXM2hCc2JIcG9zR0oxZ25WL05waWp5?=
 =?utf-8?B?Z1NsSWNuYzJadlFVcG1RQWFmMWcvMmFaTFQ1N1FJTnBucWk5SmQyUW9xT2Rq?=
 =?utf-8?B?czFvbWdHVmlTQ01CTGRac3RMR2JZbGNtK2dMMVZwYnlzeXl0cElCWTBWNDRE?=
 =?utf-8?B?RDFPMGx0ZTMxc01yK3VKUUpaRStKRlZrQm42Q1k1ZERRTFVzNTFlTncvb1J4?=
 =?utf-8?B?TVdkOGpWV0gxejVkVGRHNTlCRkxTbDZoUzJWZGNSdGVJNldWTWhXaDZ4YjVD?=
 =?utf-8?B?ZGNranNOd01SUnVPWTNNSEtDRXJXU3VQaFNXOXRxc1ZnSHNEK2k3aTVITzRu?=
 =?utf-8?B?dFp4UmxOcTB6RExZb2FmZzViaG55YVhLNWJqMDNJSFhhblI2RWVUK2lGMDgx?=
 =?utf-8?B?ZGpWUnp6cVMyZUdod0JxZjJzUUJKcVRwWjJ0a1MvR1ZXSnF6bUljb2hoaFdi?=
 =?utf-8?B?V1I3V3dyemZKQmdxcGNCNDdjUVN1L0RSZ3NWNHVMcVZoSVVLb0hpREh3TnlF?=
 =?utf-8?B?SkIwZkdadWdlSTVRWFJoU2tPSk5FRWxXRnJkdGhuMTZDbDhLTStuemxtdW5S?=
 =?utf-8?B?VlM5Z2hOSG1TZWJRZEJmYkdNL2RQTzlSN2s3ZkNuNTIyM081ZXIwVW1rZURC?=
 =?utf-8?B?d3lVOWxLNjIrSDcxZUgycUhrL3RWcjBaMDF4bmhDTWRrd05FOW1OY1ZRZHhj?=
 =?utf-8?B?bXVoeXB6L3BmNGNERlh6RU5Tb2ZFTzhhdWRrY3Z1bVRuT3JRU2hHaFoyUTVy?=
 =?utf-8?B?Nkg3Skoxck04cnRoUE5BcUZqejZQdnBKTllwS3hsREZlYUxxbm45Z1dvck4y?=
 =?utf-8?B?ZHhDYTAvOUFkOGpIc0xWdktTdUdrWEhLcXpzZ3hwcjVoTzM2SjQxQUZFWXFK?=
 =?utf-8?B?dXRWQUhUK2dTL0lSVGlINHlHeTlvR0RtdHBRRFBLcXc0YW8xVjltNWlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkQwNXpnc0RDVUoyUVNXZ3VpYi9UaE5VWnZkdjBWV0JBOFFWT2ZOQlFqU0tw?=
 =?utf-8?B?T3hGNHpMTmJqK1d4M3ZQOHlxMXQzT0hEVGNxQjh0dFp4WWYrWWFzckNCbTdK?=
 =?utf-8?B?Tk1mNm1zVjE1V3BRdExDeFhLdUljMEhZczVYSzFhWmYxY0tTUjVJZXBwaVJY?=
 =?utf-8?B?Y2RTRnV0SzdBUDcrZTFzYlJmdXNqQS9iWWQyQkpVUTY0clFaZTBEdjVpS3ls?=
 =?utf-8?B?Q3kyekRMbFF5VkpxTjdGOHRuTUJDOGhzbXNWcU4rNTZ3U3VxZ1ZSOTdwWmtO?=
 =?utf-8?B?cHlVK3RVM1hGVi9peEMxdzI4cDlWNHROMjBZSzBzYWRzaUVnNVVNQ2VxRHhH?=
 =?utf-8?B?dU5nMUFSQkY5NzR1RS9Wd2RIaHNRaFJVQjBnSjFGQUZtVlh4UFpCUklIQmJr?=
 =?utf-8?B?a1FtWGMzbTI3MkV4cjVOZ1FhNmJ2V0tMVTJmeVJGNWpMZGRYTThEZDdTNitW?=
 =?utf-8?B?NUdSYnhZTGN1ak1DREtTZlVyUEl0YlRJbjRPc3phUE5WNWNnTWV4TitmQzBQ?=
 =?utf-8?B?Y0VJc29JNlhoT1pJWWxJWkEyTVAra2RVelMyMzdsUDFCTS93YnRuTTVpSVE3?=
 =?utf-8?B?dTFuU3dtVzUzNHdtRzNTZFFzYkl3QUd3MGdUMmNhUVNPMEV2eUJTaTE0VDZ0?=
 =?utf-8?B?WE5ENkdtTmxHN0hEMm5MZWFDMTNvM24xNnhvNUdhWG1JR2FKbUJldHY1cm9p?=
 =?utf-8?B?ak1icEtyZ09IU2JBemx1Ykc2ckNWMmxXRmxZenNZRk9aQzluZXFmdDZxY3pQ?=
 =?utf-8?B?SkNqM2NVaEk3OEV6N1dwNCtjRGdCUTc4WVkvRDZJTUlReWN2dE5CTDFQK0hv?=
 =?utf-8?B?OUYvRkM0UENSSmwwaWE5azZNU2F2cUJORFZ2U2NTMXFJL0FzQlFzSmI5Y0d6?=
 =?utf-8?B?c21LQnZlVGhaYndWS2hINUFha1NTSEtGVytOL2ljZ1NkNFZjMkJJVWtzTW9E?=
 =?utf-8?B?enovNVlaVFBZYlBMRWZCSVdSTUJJZlFXakhONGRmT1FzaEJhNWFRVVYwZDR6?=
 =?utf-8?B?WklOTkVHdGdvSXNmcEhIMUg2bXZ0b0p6MzZ6QkkyYlo5d3NUR3k5eVAzWWhh?=
 =?utf-8?B?Qm1adlA0SjFXaThlWlEzREJyUDREQlR4S3JjZ2NkR2hHVFl6TXpMejAvQ3hO?=
 =?utf-8?B?VHU3Zmo2aHFOY1V2NC80WjNGNTlBU3JwMC9Qb2VWbVRMRGdZZlZFTDNBbEtT?=
 =?utf-8?B?UVl6RjUwczMxa1Eya01IeG1pREVha1pVcTl4cmkvS1ZDNDlBMmdFOC9vT2lo?=
 =?utf-8?B?NCtQcmVjUDVBa0xLa3g4VmlxM1JvTGl2eUpuY1ZpcWN5ZU4wYnh4NzZCVmVm?=
 =?utf-8?B?ZVBZOS96NmVMTXRyRkp3OGNsWXQ0RjBWU0pDTk9pR2FPVFo3Q1N5a1RnMVNn?=
 =?utf-8?B?WUh3d1NZZTNuYXBCMXhrTHNPb2h4TjlubDdFMHlHR3RHWkNBc0kyTGd6YW54?=
 =?utf-8?B?RkxaTkNEb0FGK3lDZXU4bzEzRVYzOENOeGdVNUwxQUllMGhlamFsWHRqT1pk?=
 =?utf-8?B?REo5blNLdTBGQ2FRa1JybmhMa1FBdzJXTTd5eDdnMHlTY0IxWnozSjhyMWNx?=
 =?utf-8?B?Wis5aFBzYU95a1dQSVoydWxKeGYrdXZ1OXZiN3cyaWxQKzYrNnRYZnVGY0o3?=
 =?utf-8?B?ckJyVEJLdWJoQTZUVDZUVndrZldUSGxaNVBNazlaMU4xYzF6M0NCQUxDL2g3?=
 =?utf-8?B?NTErc0MrcCtzc0NndEFMOFMvUm1IdHdOalFYeTRiNXNVY0dsalVlWmtMYnBF?=
 =?utf-8?B?eXRhTHRXM2JvMUhyZEU2K0thaFcxT2I3R3ZSMjhqYWNCZXU5NXFRakZES2tH?=
 =?utf-8?B?YjRYakVPV3VOeFE1SE1IKzQ1RXNXN1NHcEU2T0xha1FHOFdoWFdRajQ0b3k2?=
 =?utf-8?B?UTlmR2p3TWNDRkw2ZGh1VFJBdURWNHM3N2RjUFUwOU5FYi8wZjRoZS9QS0pi?=
 =?utf-8?B?UURVaGdTcmxSV1ZCdEQwcDVtYjZzc0lqT3BBaTBjKzdaUmRrbWw2OXNWSFdY?=
 =?utf-8?B?UENzTHRHdkdheG8veDVQTUVnaTRrdGl1MS9YMTlkM2JxNk5MVUNmbTcwdW4y?=
 =?utf-8?B?SVhTcFFiKzlBbFVhczA0dmZBanl6MFNMaVBGZWxBem1aZ25JSkhrUUhWNGwx?=
 =?utf-8?B?VjlvWVh3RmlEMWRHMmxIQkZKOU95ZUJybTVVYm1PR1JQRXZ3UFF6bkFGb3lG?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a4c99f-6afc-4739-4301-08dc63c5a3ca
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:46:08.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XFn7SUzqUsVPRRzlVnIVDWhNTVisdAsoxbsxTXjSjXv7ReaXilH6fQtd6WVfAL2+YB/sloL1b19NqBOgdXR83tfNIBaJ9BRO6K2/NwcM6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com



On 4/23/2024 11:27 AM, Tony Nguyen wrote:
> From: Erwan Velu <e.velu@criteo.com>
> 
> If the MFS is set below the default (0x2600), a warning message is
> reported like the following :
> 
> 	MFS for port 1 has been set below the default: 600
> 
> This message is a bit confusing as the number shown here (600) is in
> fact an hexa number: 0x600 = 1536
> 
> Without any explicit "0x" prefix, this message is read like the MFS is
> set to 600 bytes.
> 
> MFS, as per MTUs, are usually expressed in decimal base.
> 
> This commit reports both current and default MFS values in decimal
> so it's less confusing for end-users.
> 
> A typical warning message looks like the following :
> 
> 	MFS for port 1 (1536) has been set below the default (9728)
> 

Sorry, I forgot to add the Fixes in.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")

Let me know if this is ok or if you'd like me to re-send with this added.

Thanks,
Tony

> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Tony Brelinski <tony.brelinski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1792491d8d2d..ffb9f9f15c52 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16107,8 +16107,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
>   			rd32(&pf->hw, I40E_PRTGL_SAH));
>   	if (val < MAX_FRAME_SIZE_DEFAULT)
> -		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
> -			 pf->hw.port, val);
> +		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
> +			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
>   
>   	/* Add a filter to drop all Flow control frames from any VSI from being
>   	 * transmitted. By doing so we stop a malicious VF from sending out

