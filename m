Return-Path: <netdev+bounces-180491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE672A81787
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDF64A837D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18D253331;
	Tue,  8 Apr 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKd0ZfYm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3092248B8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147261; cv=fail; b=RWSlyM/szFjQ1dP2wn5EdmxKs0luv7SRBx6DClBaYcPqUycd6V9dYwuFeeQiRw321A8/BjverCOy3/ltdbeUjqVKala61ZhJnModA31wBpwo/sMBG7cHNgxXqc+W3jwYBicGU8jI3Qd+WMqoeAx4vUxevehIDS4wE2TAyqlYE9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147261; c=relaxed/simple;
	bh=4T1mf+B4unyeplwBmtZjJkUscpD8eqeReWb77wFUFTw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ey3U9qARsh74Ew3MhamvzQ9KLapsJmRZZjSbMVVDUnKshJ7uRoHP8XdxzX7pWRkdZfu3yFUTYpsJ6VxohTCJl4Q7Rwa+fbKLinl5ut1/1tZ3IsSlqCuiDDNeDSXodORLaM0pAEfFHRqPN0wypiaLBvd4xBE2qsCSA9Pxj7jSUyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKd0ZfYm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744147260; x=1775683260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4T1mf+B4unyeplwBmtZjJkUscpD8eqeReWb77wFUFTw=;
  b=CKd0ZfYmsgTLHfE0/q57SbOgAzKTHABhy5zzn8NCaCUQc4WzhAlVGPMx
   qJIr9BlDM8wEylWfR1w6QYDY2IlpxUWzDJ41kS03xEShNBTFJ7qxpkeA0
   Ng/iH+frsEZkXZVDhlrdnoAoEbzpXcmXLRQE5W5Tk8HcOkixLVBTX4TAv
   Mxd78K5X/rTbUfjpEftg6ySwUOda8Z4X77u9FNiORnrN1HeYTfUoVDOvc
   VsE60Jpq2pn7srwiN2HaymVUZvZPkBbX349EXFoQhfsRz81UHxl/7/aVj
   4aOXXcrbTTZE9ARIl7xhiywW0E/dG5q+xF+SAwGNvjMFzINAN5zLIGHS6
   Q==;
X-CSE-ConnectionGUID: WPmh6PCNT+qwXJ37Pg/F7Q==
X-CSE-MsgGUID: zfPlS2OYRpK8Fez9tyN12w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33206915"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="33206915"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 14:20:59 -0700
X-CSE-ConnectionGUID: fPXGAFQHQYOfDtxefjsb6Q==
X-CSE-MsgGUID: 7AXVzXAURSCzA8eB/zmPFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="132515003"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 14:20:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 14:20:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 14:20:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 14:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcdnForYWZJeCw8yWILMWHc/PFYh/vC0y/4XwqUZ/ydNjHzIpdiP5UBTZlwPa9h6ZskA4TF+euYr70o59xNg3Jtbn2GvynKYCGIKa6eM8RgG3QfdEvBAWYSCEl8PWSJNBAKLA0fZM1/2OpTf97Av+uWNPMyMe7WvNvMeEfFaiDwggYtWZhFh51EXOjFiiUKD6cr04ZldVrXAbSyJvv5rFRu09nLi3zIQS7ONKnkL2+ZHlgO81VctlkqP/etWoPm+Wp2IkJFwRr3lM/FOtS2Y60oml7msJL7U35SGvhochGcW1Tl38jSrZsuzTwn+BgzdhqoozbRyVGbZ9z7lLr3qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K9SWqqgAjyIHKwNeIgnBS/tIfCSKhoXQWTQOy0uVlU=;
 b=XKlhM/CWklX1zTiQHjDuP06nroLi5ypcWSyASwzsAgyD9ViBOgFqbEdxcAKGSm6g6iVYOiWIWDr7H6siimSfMUjVSvqhImWnLDHE8X2mKpMEH15JL+HkGdXDc+2U99AS7yDzmOHOJpAHzGBN8DLgpgEso8bvtBW/oHnzNJKvDKZEJDhpUsAT6a8Wv/ycPV0+zcSJoJSzL4Bm8uZQJxONVgVVQEHl4gaQP3mQJtzMl7FpkiszQAfACl5T2jX4gt31tSApLt3QhJlF7gHzQVab8oS/dJ4Ipv9t4ZMyysQ8sPnHhObcVK/cSQtaEcEbV+duVzVw4Lvlb734OgezYF/AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 21:20:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 21:20:48 +0000
Message-ID: <f18ad216-8862-4e1d-b558-de76088199f3@intel.com>
Date: Tue, 8 Apr 2025 14:20:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v10 iwl-next 08/11] idpf: add PTP clock
 configuration
To: Milena Olech <milena.olech@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
 <20250408103240.30287-19-milena.olech@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250408103240.30287-19-milena.olech@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 8341ade1-8422-4fe2-39e5-08dd76e33b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXYxUWZFb0VrVnVGMG93TFhMMHcwODgzU2RNWUhVWHJ5RTFiMUVMZ1FKbHJQ?=
 =?utf-8?B?ZnFsd2dFQWd6bDVoOUpYaGtNSHFuK3FCekFZRmJvZXlyYzVMVGc3QjZNdjh4?=
 =?utf-8?B?NjBuRll1VlkxNlZqakwvWFFaNVZieWp0aS9JdktxcmMxVzh1U1pnVEllYjg2?=
 =?utf-8?B?MmozZGZUTlRqQkRMS25WM0FZV3h3KzdYVDdkUWpFdGNGNUdFaDlRci81Y054?=
 =?utf-8?B?bmoza0d5MGozSHBFTmRhTkRzYk9TS1V6ZDMwSmJTK1E2MmNCLzl1VjN5WlVG?=
 =?utf-8?B?b2pWeEpsbW9lSHVRMzlmUmsyUitrZXhZb3hzK1JxY21DTllMS0U5L3NkaVNH?=
 =?utf-8?B?RjhsbUlWamhTZ0NvdjVwd1BDM2laYjJDUGxDZmU1SmxWVGY5Um5BNXdJeTlu?=
 =?utf-8?B?RmdEQ1pUc0d4L3VwL1prUkw3a2trSDl2NDJicklnRHVQcnlLZURqRUFYUThr?=
 =?utf-8?B?Mnl5U0tpOWR0Z3VPb1pBOFc0WndXNUlUQ3B0VGRyVm1DM1VxQmRtejV0QlNE?=
 =?utf-8?B?TFYySFFZbW50ZjU5VFZnNnp3RDBGdmZCRzM2WlRuVmFHUWR5a0FMQWhQRTJG?=
 =?utf-8?B?cE5HSWJNY1l2SC9pSGVQemJla0xORnM4VVRLVVFTZE5wa2dCcnl3cGU4VmVz?=
 =?utf-8?B?cjI0aG11bGdOVzY1R0NLT0kxMnRrdVc4SUdOdzR5UHFLT3UxeEtmZVBQckY1?=
 =?utf-8?B?TzdLNTA0VGltUVZWYjlubHlvL2t1OVpqa05QSzJDQmMwRGlDbllEdGt1YXpu?=
 =?utf-8?B?aDV3S2p6TDBZd0ppa3VpcW1kc25yRGhaTmM0SXpVeW5wWVZ3T0JiVzB6VS9p?=
 =?utf-8?B?UjNGcTFlbnQ3bDlPSit2Z0pUeUFzNVhOVXVhd091ZWsyazd1RS9IUndFeFBC?=
 =?utf-8?B?MWVMa1FEeE5QenJiOFkrNE03VmtWS0JzQjRJaUh5UmVEcWk2ZEM3VU9tckpL?=
 =?utf-8?B?SWJJSzAxUVdzYmhYTmd5RXJ1VkFxWjZKSXNjci8wa3llTkNxaWtxRkEvUExJ?=
 =?utf-8?B?WXEvc29sTmxTODI0TjU0ekJGVWFrRVo3b2J2WDdvMmJweVloQnRmc3hDK3hp?=
 =?utf-8?B?N3h0bzlodFcrMTdnNzRPcGQxbEhBd2NUZW4reC83ZDhBbmo3UVlaQmVBYU1L?=
 =?utf-8?B?a3FUcUxJOFdDSmcraGVqQktWWHppN0tVaUVPcWNEQ3ZTTm9oMno3RmpJRTZL?=
 =?utf-8?B?MkI4V0NtMFUvUUdhVlRES1NaNzFJUHEvNDhWT3gxQzhaQnRhMmU4Z2F4V0xl?=
 =?utf-8?B?LzFiSDBCK28wQTdhMitQb2FLNW9Na1BhQ2puL2hFZzh6Mjc5TDJDbzNOai9V?=
 =?utf-8?B?Y212SlVNc0FDYjA3MXYwN05oZlVNZ2Rjam5CU3dmRmZBMTd2cGZ6UHdaaFhS?=
 =?utf-8?B?eVRENms4UWZBQnViSmphYnlNMzAwZ2NJeHR2d3dmaUZkdGdNR3VjejNXc0pV?=
 =?utf-8?B?aXBST2xxeTZsQ0pJejN1TFp6dEsyUTlUdXZEZWxTTGV6ck9ORDB3aWZhT29u?=
 =?utf-8?B?SlhRd3ZjSXBhcko0OEx1VEE5MGRHOC9iQnNwaGV1SjdmSFgwalo0eXp6UWps?=
 =?utf-8?B?OUFaOHF0cHpMRi9ubjhmcFVwdlNmcldRcC8zcXM0RnVwZHlUWTRWdjJIWkto?=
 =?utf-8?B?OTNqLzUrRk82ZmZIOFk1Ny9idVRnTkl6TklCT0MwUUl4SkVrZTRiUzkwK2hj?=
 =?utf-8?B?WUU0NDRpcEpMcFE0YVNIMUthSVFlYTBRNFNPZ0JLVjlrek85NzYyVVVTY0tL?=
 =?utf-8?B?ZEI0b0EwRGFsUkF3b2hHbTFrcVZ4c2hKU2FoeDRvd3lrOUJhc0duVXJYNnlm?=
 =?utf-8?B?QmN1cTNVaVdPV1RDcjdpZUhxRG9jN3RVSTZ2WUt1L2VRdEFkS3FOcUZ6bnZH?=
 =?utf-8?Q?DeGpVNj1F0svi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2RscUxEK2hJMnFBVWxDMzBqUXJ3WGltaEVWUUlWUTVKMGpNUTdoUjFlVVlV?=
 =?utf-8?B?d2pRYXVCOGZrUTJmWTg0cjJteGh1REc0QTQvRzBobVA3WkVhUFNhbVhpZE5C?=
 =?utf-8?B?VW9WOGlhOUYwYnFyZnRyRVJyZFJheTczZU5xd0JyMFppZzg2NmdwMU15ZSt6?=
 =?utf-8?B?dlYyOU5OajA5NjhPZXZiQ0E2VTVrMW1LRDR2TnN3Mlh0eGgybWxiK1dnR3BU?=
 =?utf-8?B?dDU5N1crVkJnWi9TbFhGVTl4V0s5Y3pTdGRjL1p6bEFtUzVUM0lXNGxXQXVY?=
 =?utf-8?B?VUhrMml1eEVDQ09mdEF4K2FabEQxNm9KZjM0RlVVRzRvWFd5aklKaU9zVndr?=
 =?utf-8?B?SnVoQm4rU3I0K1FRc2MyaWdXL1llbjRxeXlYcUdaaHZIQW9GemtpVS9EUjVY?=
 =?utf-8?B?TW1XZVp1S2dMTjhmb3hiVFdOc3dlTGo1N05KWWYvcWw3QUtzQmJmeG1IMzNX?=
 =?utf-8?B?cnpYQmFFVUdGZ3BiejlOQTRHWHU5dlFzMStKVlR0WjBiTWdVdWxENVBjYWMy?=
 =?utf-8?B?YytFN0tKRWRoUHdyZDZHQ29BeEd4YVBzcTNrbkRzaGR3VDZFVjVvN2tId3ZJ?=
 =?utf-8?B?NXFCd2cxa0tsVHBDRE5VY2tja2k5b3cyV0JaTzQxUTFCejdmejZmRTRHMEFu?=
 =?utf-8?B?d3dlVGJUSnNmN1NyYXhuNXcvRURxdmJvUWRnblRod0VxcER4TE5IdUtMQjIw?=
 =?utf-8?B?Y0haenpUd3hvaWhaZVIyZldkR0l5VmZBeEUvT0ZWNjEwdEN0VlRDang1cUdJ?=
 =?utf-8?B?aktUUDV6Q2M3amZmQmYwb1JPSncvdW80NDBtbkt3TnduSHhYalFPOVJBdDVm?=
 =?utf-8?B?bjBBT0g4MTVIcTdKTmdEazVtcUloc2xiNVN6eHR6a253UGRrWXRNRlpwbUdG?=
 =?utf-8?B?V0NibDhOM1FKMHExWmhHTndQYW93blg3RlFaL1NIZ3NXVFFGVXZMS1QzYUJP?=
 =?utf-8?B?eThXTGE5aUdWSVVRUXlQRkwxQTN6VldzQkVNR2YxQTZoRWRhWFBrWmtqQXZM?=
 =?utf-8?B?aTlpL2tTS2N1RjRhVWxEUDBHM0k1R29RUDZUNVpSeXZxRjVIbE9MQVZnMzFO?=
 =?utf-8?B?UFhXM0hzb295bWtOb1J3MUdOZFo3NUM1QkV0NFVLTjBuK3pqb1ptTG5aaERq?=
 =?utf-8?B?Tk5WcEpkU3BaVXV6V3FZcUFudHJTRHM4cjdmTXBUblZZZUVORFVaVjZXZFU4?=
 =?utf-8?B?MnFEWWJkdk5WU2ZBZHkrbEVDdVQ4bk5CM0tlc01uL0JrYyt2NFlMR2lTandq?=
 =?utf-8?B?Wk4yeFZCQ1MxTDh3RlRuV0YrdTQ1QXBBSEZkcFhqZFpHbmRaUzhqb282UzJM?=
 =?utf-8?B?bzB0NHpDS0tDbU50TUwxVkhONUtDMHBZc1NONVJBemNxWDh4N3k4RjhDOUxS?=
 =?utf-8?B?dVFHTGhrQ093MmJscmdpazJsSEo5UGdXZXRFNFFSRjFqQmIvd2Y0QlpUUlY2?=
 =?utf-8?B?b2tCSEQ2KzR6REJCbkpKV0dJZnBOb1BpRVBmY1ovdUJXSmUxU0I3ZURXNjlq?=
 =?utf-8?B?NkgvSWZDMkJ3d3dKVTRjQ2tYTU9JWktvOTlRTnZ5Ukd3OWllMmFlOWx2RlRZ?=
 =?utf-8?B?aXZ3cUhJcHlYTzVwMFoxTXhVZmtQckg0YmZSS0hNdWd1UU9ZOUVwbmR1c0Jj?=
 =?utf-8?B?VHZIUGRNYzBzbUlZSCt2bThIckFDcDRDL0h4ekRDdDlTVXdxOXU4Q2FYVDA2?=
 =?utf-8?B?SVNXUFFLcWRNeXRYa0l0Y214cnVIZHBxeXhXWWh2NXdhUXBWeGhzdG9kZG1S?=
 =?utf-8?B?Z0UvQUdWaUp2TkVuemVxd2FqcG9LOEx4NFRCMnhHcGRSaE4zWENPUGhNMEpJ?=
 =?utf-8?B?VFptN1hFem1JU016NmcvSGZBTllhU0RBL01FT2o0L1FWL3g5VkRMUXZIRmV2?=
 =?utf-8?B?b3JxVElhSG1kWGxsLzU4Z0hGeHZURWhFS1RQRFRIZFl3czJMZ3d6eDhmWnp0?=
 =?utf-8?B?V0NKTkdQUU5CZTU4aWlzNGlkcmpUaW1oT2VPSWNJS2pDZVFUSEJPNlhDQlpS?=
 =?utf-8?B?ZVFBNG1kc1BVWlNVRjA0YldxSFY1dnlYQzlyNDFLNC9yNUhjWW1aZDN3NTZy?=
 =?utf-8?B?UU9nb0R6WjVyMmxyWTdOeE9NOUNDSTRGY2dndDJpbFZlL1RjbGFJdFNQV2th?=
 =?utf-8?B?dDV3R0FYOWZpYUpBRjI4ZWF3blZsMVZ0T291anRkK0g3NFJuNUFwbGIrUThD?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8341ade1-8422-4fe2-39e5-08dd76e33b72
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 21:20:48.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQmk6mLnlbqmbdUuwRtjsjoRWJkcEjq4ymfE858dDU2p0KaNNK7M2Ex5rgIiM/IWx2YiXDPNQtVWw9QWFcnUtCmKVDo83WvSRr+ftwZfxFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com



On 4/8/2025 3:31 AM, Milena Olech wrote:
> PTP clock configuration operations - set time, adjust time and adjust
> frequency are required to control the clock and maintain synchronization
> process.
> 
> Extend get PTP capabilities function to request for the clock adjustments
> and add functions to enable these actions using dedicated virtchnl
> messages.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

