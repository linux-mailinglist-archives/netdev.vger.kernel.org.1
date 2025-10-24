Return-Path: <netdev+bounces-232306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADEBC03FE9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C731A6836D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F81632C8;
	Fri, 24 Oct 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMswc2y8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B08405C;
	Fri, 24 Oct 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268210; cv=fail; b=O9JgMucK0ooXZuas3BizQzNXTeJqNzjxZpFAlfJ+8sP0tx+93l/Yog7GTRF3MqeZXrNLZvtn+OMrUj0ucehQuLFcy/KRQx4mm6KycTFEovnnz1Q25oyBW8AldziOfxLN0/uE98IrOCcd2i2Ee8qjtCy6dD4yYB8LZjfV6qA7/J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268210; c=relaxed/simple;
	bh=FpSy5UkqdK2i8auLwbs1joWbbnUglmbvc1UkY6he/5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qlRGiM9TFM3EUwArSke6IcSracKC+BcQTvLXxWkljyxlno6NrpDrL3P61iB+GUVLis7DoqEfxK90YmXawGhGftygXaw1/Xjjxip4x85VakYaE5u17MjBwWCEzYhTaBq49PImaqo7qA7m6nf4mJqESOeFM7BpNl4v8iPcRb05eMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMswc2y8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761268208; x=1792804208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=FpSy5UkqdK2i8auLwbs1joWbbnUglmbvc1UkY6he/5Y=;
  b=TMswc2y8/V/a0s03VroeAfkF3gMR+DT8iUPZt3gLHoR1c517tBIR8ol9
   u9prkaQ4Ru2kx9mVdBFZpvYVcxcGW8oENreyj5fyOKt8Rh06iwTxuyxIJ
   BdQ/JYiwIK4AfTaDSN6/c7mTsTrG73WMtiOX7M56BrK1E2uG8aLyfCHXZ
   UVDiEZpyKcWKHF8iG7M1awy8jiBlJUGx7UIGn3j0Et/7qPFe1ZxXLliee
   vHwUJHSvWsGAgLnu7fRlubT+xEhBqYikoG+Rqe+kL5rReo+q4PxMv+BAT
   F9kUJJGYcmw/lqzzGR9yij44ee3f+Pj6o157NQmJtNFKkKQVtkzx0mSI2
   Q==;
X-CSE-ConnectionGUID: bXAUK2ecR2i3qLA3Wc+TEQ==
X-CSE-MsgGUID: RrbCe8Z2QhikR/qgH7vNKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63352788"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="63352788"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:10:05 -0700
X-CSE-ConnectionGUID: if4fv6yfSkWAcK5ki4BvDQ==
X-CSE-MsgGUID: t4gpR6JYSk+w8+gn3JvCpA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:10:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:10:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 18:10:05 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPWoXjkKbqPIOy/BC/5/xgWK1itIK22rXsBG676Ck+YlN/eehVDH3EoJo84N+/srSMAY6uIVnUTrFjQwtkOuYkpZiy2Z5MkTb9veNTu2jMNkppZAYFgzdSs8ZXIuA/6yPbAApQamJCb0ayECjPaF9yahxnHxRDYoHb0bO0Eh1yZpGdtHKj2EI6UpZMKfxy6sIDyeMOSAdXt/GMy9Z4xL0D7RxSTLof0ZDaIBGZ0ahCbZTkzJQnyqYRWXEhhyZIhK64Cw9yNq1AuvDct/p31yNJB9FIbQJNu8WthBrb+hvXJt7DNZs9Hd3fpHV+WCekpuTPl8EF+CDj5lztC2bqKYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeOO2yl3+YQ1q0h+6aRlg15fcT3w+gOeNBxrWk9nBBw=;
 b=AWuUfy1zYrrDKEzUALF4P/uCayfBCuTseV/zJjV1KS368/y3h+SxCuDRoIXZR90588Z+wiY3pQcE2cnVBmIve+Y3Muw7HF6oAtMy/PuJ00BAI9s/hZq11MJgfIaDNzBnpt/kipt3zE3jNBBG/70t25yQ4b94WcDJNhjwzZl+lb0n0v39V0JKIKSO9ZOJSlp4CICmOYe7n3Qe6vOvulbKJrQvEY9PvN1NrS5hsDw2hNzb1r8lc5SN9Vl5UqCxkB4DwGQ+HzsQi/rceK8I4iICZh3AiuOvx2Q7v/wjvfdxbafz9ztFHtOOQS4tBpKuwcOz88GahNo1hI1DJV0KGMC+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 01:10:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:10:03 +0000
Message-ID: <ebc90ce4-382b-4a0f-891a-5305599f9ae2@intel.com>
Date: Thu, 23 Oct 2025 18:10:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: hibmcge: remove unnecessary check for
 np_link_fail in scenarios without phy.
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-3-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-3-shaojijie@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------hx1lpqD0xMlE1gFHVLsCdWU6"
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f201fe-3e0b-44a1-c239-08de129a0f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXN4MTkrTDdQSWltZFhYSVdTL0lQRkJCTVcycktVUlpYci9tYXRXUEdTbWtQ?=
 =?utf-8?B?OGppaVZWZm5SdHlRQWZxYzhVcXg4RHZRQ1JwZVFhcU9CZEhvVDJTZjE0aVE1?=
 =?utf-8?B?RytycjVJRjdDbyt3akwzaGI4VFNrSitlUzZjMU5FYWovcUYvcFEvQkpndUc2?=
 =?utf-8?B?aDM3clZ0N3RERlFHSE5RcTdlSGtSalEzZkFpNmpoV3BrSEE2a0dNeTMzODVx?=
 =?utf-8?B?akJESDE5SjQya3V5S1dzSVY3ektyWmV3WFUyKzdUYUp2VGdEM3puMU45cXJU?=
 =?utf-8?B?NXN1cEZmQzJjVVQzNE9lbEpjdlBOVFNubVR2U09NamFzUFhUVTgybGUxZlFh?=
 =?utf-8?B?ODVNd1BQZGs5OWV3UGpxd3FRL25kcUw5Vkh6OTVIMTdYdEJ3LzhlOW4xK1hI?=
 =?utf-8?B?M2hZM2E5Y3dXQStrUElOcFBxRjIvYjFiVkZmUnpZS1gzTzRzN1FMY1Q1d2tE?=
 =?utf-8?B?UEZJTzdKY2Y5akhrSEkyTGdCWGoxVkI0ekdRblQ0S2szTkNMTmtwc3B0OTdP?=
 =?utf-8?B?Y0x1R21HZnAvWHdqUU1MOUFpQ0gweUpsY2l0WmVvVFZvS25uOHl3NzZpbllP?=
 =?utf-8?B?WGN4SXFDUU1YQjBQQnJHVVpsb040bmdkK3pLa2RnSGF4RWYyQ3oybWl4NXdD?=
 =?utf-8?B?K1M1Wmg2WEF0Y05vcDNsVmdFbGdlQjBVS0pPMzcvSjg3aHluWlV1czJLbjh6?=
 =?utf-8?B?Y2V3VThiTVJRL3dLdlZjdjZOSS95d0Y4ZGUzNmdqbGVkbGxhUzdkSUdqaHpI?=
 =?utf-8?B?TlBMRDNIU0UvRW44K3paVEh6YlBhVmxSRGpvWkx5L1c4UkdJTUpzZGg4SHVk?=
 =?utf-8?B?ZGdDYkNINHNlRXdveVFwdzV3NGREMlZlWmNtdG81U3lKM0JQTzN4ZEU3STVt?=
 =?utf-8?B?K29PSmNrWWYvVkltOTBuWld0UHBlZktBUU5aSUdYcWZaMXRteVdrV28vTGph?=
 =?utf-8?B?OFJ0bXdDbGZsNHpsNFVvbE90THgwNFF4OFczUm5RVDVtSUd0TlJRTk1lMm9J?=
 =?utf-8?B?cURQbWtGNWd2bXJ3UzIvenZydU12bG1NQ1RoZEsrbkNwZnRVVVAxd3dGN0RJ?=
 =?utf-8?B?UXdYSjhsRDRVVGxJNTVoVjkxL1M5WHFrNCtVR3kyUzVZL3psZktSdk5DckRi?=
 =?utf-8?B?Wmo1Zk5WMTVvMVdnZklEM0ZZNUlYTkFpekU5V1MxdnlreEtGWEpMMnlZTzUv?=
 =?utf-8?B?RXVENWRWRkM3eEhuTUVOSU8vZ2NXaFFONW5ldFVuU1czY0hRa3U1WTh3TXhF?=
 =?utf-8?B?ekZsbHQwVGpLUWZzWWFVN2dRakhYcWo1bWFMem5MWUZLT3c4T1I2bTFlRmJG?=
 =?utf-8?B?cVJVTjRRaTBrbzd2dGQxOWJ4aHhBZ3VBK2w0N0tCNWxndUFGeVg4VW1QSkhV?=
 =?utf-8?B?ZU8zMVl3SDNYQXVsOHJWLzc0aVJhNFI4c0EvYk1wZnEvaVFLVnk3NVVqV2Vl?=
 =?utf-8?B?TnhERjRhcXV3dmFMUDhYZDJSMkxjOURpWHQxbEtlanh1WEUwbFU0ditrazlx?=
 =?utf-8?B?U0R2L2xxY0RsamVYVGl1bVRRSkZMZmwrZlNsZWtHR041ZFltZUI4TG5oa0Qr?=
 =?utf-8?B?dmNMZlE1RWQrd2ZSdXE4cFl5T1crVm5UY0VqdklQRlJQT2gzNlRUOGxnbDdY?=
 =?utf-8?B?N2RMRTFGUTVUczZjQzU5OGlHdlZmZlJDd1VZQUVWcnRHOWZ4dDc3TDZCSlJM?=
 =?utf-8?B?UTNjZjgzdTQrY3JDcjhKOS80YmJlSXQwOUIvZWlKdWFiL2JMbzVwM2FpVFBh?=
 =?utf-8?B?bU0xWmZZUGszNENEOWtvQUp4WHV6ellkZ2h3U1FzTmZoVHMxTlh3R2ZNZzhW?=
 =?utf-8?B?bGhNL1A4dm9lbXRuaGwySTFEd25NWjVya1I3eGFGTiswaDJBbmNESTdXRDRj?=
 =?utf-8?B?VTlqTEhuNGVrVDFKNlB6WkZQcVhscU0vMFJGbFk3ZE5KR3o1RDJMeW9GSXF1?=
 =?utf-8?Q?RBeU5R/kYUUWKiOnUUYhZRx23YlNRAc+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhneFowdkRKdnV0aTBxbitFaTNqblVodG5pWGViRzRKcnREVUtEQ1BkQUVG?=
 =?utf-8?B?ckh4YjV4WWhJbW9PLzNScndBVXRHZlpBajJZSXF4WkttQ2pIaVhtektHMjhp?=
 =?utf-8?B?QTZLWE5nK2xSdVNMR2FiQ0YwN2tXZlBZejk2NFErTXZ5TXdlK1FjdHAzRUtS?=
 =?utf-8?B?V29hUU41aEgwZFBuK3pFbTNJM0diZURtSVdDT2NkaVpNbEgxVCtXdlBKKzNa?=
 =?utf-8?B?M3Y2amt0djArUWM4dFhuaDVNNGt6OE1lR3FXZUZhWUxLeThJMjIvcGRUd3Bm?=
 =?utf-8?B?Mno0N2RFaXE2Q2JweVF5ckJqVlloK0kxT3djSEpnRE5aaWhKbEhxL0pKaEM2?=
 =?utf-8?B?MUFqU1ZqZ05LODJvVzBBM3JQbWZQS3kwbTFSbmVjL1BYZUNLa0xGd29IRmVV?=
 =?utf-8?B?MDhRWVFudXJRTWxtcWU4a1lzelBRK1AxUU12NUZycWVWc2x0NGZSRzFwMVpw?=
 =?utf-8?B?V2E5MlgzMmh1N1lkd2pkUDlRSkhWWmI0bnRJWjZKcXowR0ZURi9ZYjd1cmkz?=
 =?utf-8?B?MWp5NGVlV2dLVFBZdDJjWWZUcXVMcnBmNWx5WmRVTjhDTXg3QmVIQTEvaGUz?=
 =?utf-8?B?amxramZQanNIQU11N21hbkhEUzJiNlRzSkJDNXlNbHQrZXB0T2tKRm5ybVpJ?=
 =?utf-8?B?alh1OFZhcUQ3b1dYVjA5VzhIZU1MNVFuQ0NNQzVjT2RDWm8vcTN4UjJ4aVBL?=
 =?utf-8?B?ZDZST1hmNi82MWZETldvWDEzMCs5cGl3cVdZanRtM2ZRWjAvbHdkNzBjRGFY?=
 =?utf-8?B?QjI3WjRCc0cweHFDaWhKdlBZUE5kOFBtUDk2UzA4aFFpeVcrRVZKdzBwMFky?=
 =?utf-8?B?SHVleTNtTEtZc3JLQWxadzZMUmJFdDFLTjBlU0pTWlRBakpGYVFGOFRFdEpF?=
 =?utf-8?B?bzQzWUpiRDBNb3pDR1JHdmE5cmNsd3liSWVNYTAwb0VJcXo2WVNOYlNoK21q?=
 =?utf-8?B?MGE0dS9hd09NbERPVmlaekZ3ZFZybnRRaFhCV1kyTFduUXdDSENBMmplSXJy?=
 =?utf-8?B?YnJ5QTh0R01xdVNVMmFmMVppTHVqR0N3N3JzekdZeWJ3clpNUG9MMXo1N2Vl?=
 =?utf-8?B?dER1R2pqT1I1Y3d0S0oxTXlWelFmQ0dVL0VhLzlSR0RPVFFqdFdFV2s5T2pD?=
 =?utf-8?B?Zmk0MnU1dzhVQzhNMW80VWFTZ3RHQm55blV4MmVBYVUyd1JDYjcxM3pxVnZB?=
 =?utf-8?B?R3hab2d6dTJXMXBKK3Q2WVIrSHZkeTZZM21XWDJxdnlDek11SWRTQmZZTGcw?=
 =?utf-8?B?dHRqUmdsRldHejNicTVZTHlGQjRWWGM3ZXJuY1NhUDM4Y0ZvbzNjaEZEeGs0?=
 =?utf-8?B?M01zMnpnM0JTTkZOZi93aWQxaWY5RGlhKzlucGFDc3hJYUY0cTdnUjBJMDJS?=
 =?utf-8?B?aFFTQUR3eEpxaEswZkJyN05Id05sTmJoa1lXR0xIQWx3SDRPY1BMUi90VlBq?=
 =?utf-8?B?SnZqL0ZVekx0WERBb0NWYmhTdzdMWGtaQTlTNzJHTkEzZUc5aFVJc1JQYnBk?=
 =?utf-8?B?emZLMGw0czVkcmxHWnJmSTVJZWt2Ry85K1RYT2xKb3YxMjB4Q0QxVyt3Rng3?=
 =?utf-8?B?VStYcmdsR3VIdFNyYWJMSGVmbDJkTEtBUkwvVDlGakhGRmRwQ2lEUjRwK05Z?=
 =?utf-8?B?aU9ZWmlIREg4QWYwTmV4WUd6R2cxWFg0UCtBZXdNL1djcUI4a2w3WGJITHRH?=
 =?utf-8?B?dnFQUHFidGo0ZUdKWnBhTzgyeUZEb2UxWnZLQWNhVzIyT2I4Smdtcnk2OVZB?=
 =?utf-8?B?cmlZR0ppZU0zcFUrVUhqZDhmMllBZ3B1YUczR2UydzFrbmVROXM4VUN5YzM1?=
 =?utf-8?B?dEJRQUVPNkk1bm1sTWdQUzArMStudTl3V05USkdpSmYzci96cUVVOTIvWmQ3?=
 =?utf-8?B?ZllzSVBoNXM5RHpaeG9yclVmbk54ckRUL3VISW9CR28rVGllWEtaVW91RDNi?=
 =?utf-8?B?c0NmcHhEeWV4c2VOcEpubmMycDZ6VkZLK3ZIVFFXdXQ5dFJadktzaU1MV21x?=
 =?utf-8?B?dSt6b29Td3pXRFVUQkYyVXkyeDFVTFNQb0RaZFI0MnhxSGhYQitNQXhkVFVQ?=
 =?utf-8?B?U2UzL3d3NFdLNFV2OGNTdHBvaGVPSEFQR2pONjRZd05WTnNLSWErUHdFZVdm?=
 =?utf-8?B?NWt1ajE2NXBhYitSU2orODNJL0hMYWxTVXVXWHAxcEd4TmZvM1VSdFRuYUdD?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f201fe-3e0b-44a1-c239-08de129a0f8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:10:02.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vENkoB/YNLqREtYy6awjx+GjvNt6lTz4RALyfwyGXxRaV39GSciT7mffV/0fX/jwFoTEMSLkJXNrkfVQZD0zvg23JyLSymWf2T1IX5nj0mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com

--------------hx1lpqD0xMlE1gFHVLsCdWU6
Content-Type: multipart/mixed; boundary="------------ylHqFuMzhbS1IybXzlNQNkQo";
 protected-headers="v1"
Message-ID: <ebc90ce4-382b-4a0f-891a-5305599f9ae2@intel.com>
Date: Thu, 23 Oct 2025 18:10:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: hibmcge: remove unnecessary check for
 np_link_fail in scenarios without phy.
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <20251021140016.3020739-3-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-3-shaojijie@huawei.com>

--------------ylHqFuMzhbS1IybXzlNQNkQo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/21/2025 7:00 AM, Jijie Shao wrote:
> hibmcge driver uses fixed_phy to configure scenarios without PHY,
> where the driver is always in a linked state. However,
> there might be no link in hardware, so the np_link error
> is detected in hbg_hw_adjust_link(), which can cause abnormal logs.
>=20

Perhaps I am missing something here. You mention the driver is always in
a linked state, but that there could be no link in hardware?

I'm not sure I properly understand whats going wrong here..

> Therefore, in scenarios without a PHY, the driver no longer
> checks the np_link status.
>=20
> Fixes: 1d7cd7a9c69c ("net: hibmcge: support scenario without PHY")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h | 1 +
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     | 3 +++
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   | 1 -
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/driv=
ers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> index ea09a09c451b..2097e4c2b3d7 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
> @@ -17,6 +17,7 @@
>  #define HBG_PCU_CACHE_LINE_SIZE		32
>  #define HBG_TX_TIMEOUT_BUF_LEN		1024
>  #define HBG_RX_DESCR			0x01
> +#define HBG_NO_PHY			0xFF
> =20
>  #define HBG_PACKET_HEAD_SIZE	((HBG_RX_SKIP1 + HBG_RX_SKIP2 + \
>  				  HBG_RX_DESCR) * HBG_PCU_CACHE_LINE_SIZE)
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/=
net/ethernet/hisilicon/hibmcge/hbg_hw.c
> index d0aa0661ecd4..d6e8ce8e351a 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
> @@ -244,6 +244,9 @@ void hbg_hw_adjust_link(struct hbg_priv *priv, u32 =
speed, u32 duplex)
> =20
>  	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
> =20
> +	if (priv->mac.phy_addr =3D=3D HBG_NO_PHY)
> +		return;
> +
>  	/* wait MAC link up */
>  	ret =3D readl_poll_timeout(priv->io_base + HBG_REG_AN_NEG_STATE_ADDR,=

>  				 link_status,
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/driver=
s/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> index 37791de47f6f..b6f0a2780ea8 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> @@ -20,7 +20,6 @@
>  #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
> =20
>  #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
> -#define HBG_NO_PHY			0xFF
> =20
>  static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
>  {


--------------ylHqFuMzhbS1IybXzlNQNkQo--

--------------hx1lpqD0xMlE1gFHVLsCdWU6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrR6QUDAAAAAAAKCRBqll0+bw8o6BJE
AQCKNO0ahGfHnTpLPsrkzqvhpcYUjV/8Zj1Ls0Gm8wSKJwD/bzq12PkgfR1kXwjDj9iJM29qqjK8
GEZ31Zhjz784rAU=
=RYwk
-----END PGP SIGNATURE-----

--------------hx1lpqD0xMlE1gFHVLsCdWU6--

