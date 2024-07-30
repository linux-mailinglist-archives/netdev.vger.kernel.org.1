Return-Path: <netdev+bounces-114159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE1941355
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE63F1F20ED2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37FD1991A6;
	Tue, 30 Jul 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjTwTM5R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69919F471
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346832; cv=fail; b=HY0lL+55C393M5oQH2Tm207gdWODRaMXWAq7N3ZhJ0wvDMOhPxRXR/OUws6GZPJEoYFmadZT4A600+4PdjZLG9c7yPzODJ+XU4F8Yae00tX+11r92ZQfSb+zyAWUvx8HSsmmzUmA4B6mW0sg7DJbaLTocy3cyjevrTgrXbBzuoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346832; c=relaxed/simple;
	bh=HDX6IkMH39AWZC/YBQ4J7XxsloD3XNKNvVo9PeXaGnc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jjh9nuHDotpPubolOPNc3fLxsdDlE8WWFqTpvlcIYnl3DPz2w9BP5u4tZtp8325N61xkmAdIupxHbrxGTkQNlnMdSPDbypjeQ7ZtRyPc6kCp/YNBFqsVIcKv0x70jzLLockgdl2Fg312kpv+lNriklBxfBTE2EZJNd4oHAXAlV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjTwTM5R; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722346830; x=1753882830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HDX6IkMH39AWZC/YBQ4J7XxsloD3XNKNvVo9PeXaGnc=;
  b=PjTwTM5RscuLAr90ztMdhK3/L2BXe2vPPX8qinYK5s+Ibu5AFriu43IN
   h02XtNOMmfeSXsVIagYnY07PP9xXd/vefqsWjIQVu3OdBGDJqBja6Ye2V
   LskMw68rvK8Rh2VhWAhPLfFRWEEm0a6LK7x85ZEJZg+iJRn4PhDShwcIH
   l8qhVjQ9nrpgL9gXD2SCmjCfSrTGpG5XbQ4ym3oFUlVUyGHU/Uu44x37Q
   a5hEVsZUpsrRhWpKJnUVwOw3dcglkN/xdhOCK7hmBeerC83Qq8wcIpHQG
   62te0YS9R04gldPp3Rbyb7cveKp8B2Bp6TGIZrXh/o15SjDzs5KDPAzcR
   A==;
X-CSE-ConnectionGUID: 5bIYnd2oRQqOpylhsZrSlA==
X-CSE-MsgGUID: I1ig2CYOS06cQHtK/mWPiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20288593"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20288593"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:40:17 -0700
X-CSE-ConnectionGUID: U8bKdRbXQveBkn43jDPZLA==
X-CSE-MsgGUID: dquKO1pTT8yqN+d96tEI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58978024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 06:40:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 06:40:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 06:40:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 06:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMjhDzqCzfcufgnWfbzPZ8O/AoLJzl3Sxf7GTwdkjCLu3MaFYcpTyQ5y134r8fUHpk0c8opGJ+S5tSpSNLiDIJs0nXcvoslbYyjMEyIdqHHPvrk2omlA8lyNfZYUBfMBzyvNesWa0gZxPoRoZe4AIIfNqfNkFrLr9shwe9FKUxTzbPmT9Ywg8Y+LLsuR3NGr2gDTKA8Typ/j45tcLCAWQVrgh+N2sQLsPKFEfbJKwzQOvMBaaqPKkIuFhBx8/asbciUFdScR7my/cFtg/pxwpAKVnO2Zc25fsOTrcjvQ+btNqzKbvH5VL35TkpbeBBN/LO/u5kl8WR/m6IiGTCGxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DztQ6KyTmYXMFnyypxiLupPJdHczdGTs59HXqVGqxZE=;
 b=GqqhJTuK4nr/7cudY7lRYlwKUsMk18Md/TrbkDwSrARP77/WEGxpqudkw624AOzzGlIdvIMNPmAHJww7s9f2461nSl5HfgHZpVGx/uFHsDoTt9J72zt12R1tPrc4ZCDHj4Ms48pZIWXVhX6GN+44hljW77bUfrTVviLkyKdOWmfuwHxoKFNLxE9CfHmh1/CbravGyKnjIyQ11Hbioyw1qw8ZyLn8DUh6yK8FkT1FxgqY2/e++HAW3TkKJbKPXAPpgW745++Mj/nKsNrMf9lmKGNE2sbtR6sg1D1CVA7fmZwv2NaMFvSoxHAjYi4oJB/EmKbZVG9kNhGmqOAi01PE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Tue, 30 Jul
 2024 13:40:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:40:13 +0000
Message-ID: <390393c3-b4ee-473a-8055-813130876e71@intel.com>
Date: Tue, 30 Jul 2024 15:40:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 06/14] iavf: add initial
 framework for registering PTP clock
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, "Sai
 Krishna" <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>, "Ahmed
 Zaki" <ahmed.zaki@intel.com>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-7-mateusz.polchlopek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240730091509.18846-7-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a46b0-435c-41a9-afef-08dcb09d23cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlEzSU43VUJsaUVjY3RZcm0xcERTYUwwTXpmbk1mc01URGtmditzTUxLZWtO?=
 =?utf-8?B?TmZpbmI5QjR5cFIyQUhCc1doVXFNeTRvWCs1UVg1ckJxNFR5dlJ3Uk5DRkRQ?=
 =?utf-8?B?b3pDN1J0Z0xRd0l6WHRoMk1LZkd4ajV3RVRWODJkK1FUajExSWJlaS9KWWt1?=
 =?utf-8?B?eWpuYUdoUHVEZmR0ZkRoaitpVWd5RGc5SzVya3NsdytKN1g0T0xNT1pCRXdq?=
 =?utf-8?B?bzJncGVXTUZqSlNYNVQ2aWh5SUlvQUNoZTZSRnRCZzdhaEZEZFRhYjN6M2ds?=
 =?utf-8?B?SmtVRUJXZzlkdHpWVHpvR04wdWMvM3JRais5OFdqa2NEQ0c0bGUwaGVzVFNv?=
 =?utf-8?B?TEtYbHp3RE9hZW8yc3BuckJJRmdDd3NyZE9wZzgzTjhoQkxvNE0vYWJUT1ls?=
 =?utf-8?B?bUN0VDVpeWJpVU1iME5adFQ2MmdYMzU4N2xSbTZobzNCVlJwR09ET2xFOHo3?=
 =?utf-8?B?TmZxaDQ3QmI0UFRVemtoaUFVdEt1TUVrSUhFWXdxVFFvV2tCL3EwR0lYa1dI?=
 =?utf-8?B?UEtUeStHQXYzLzVOZTlmQ3JqNjJhUmVNSS9jTGJrejVnZE1IV2oxNHZ4Mmw1?=
 =?utf-8?B?SmZkZWxJdVNXN3ZCbng3TnBpTXRhZHNFUlJGVmJzeG4vbUh0L0V6am4wRVFh?=
 =?utf-8?B?cTlVc053VTM4WUhqWnMrUXR4Mm5abHVLL0JRMjVYczV1ekhOSVdVN1pRUDJ0?=
 =?utf-8?B?WllZUHp3d1N5WG9aeVRFbi9tVm9ZazFjYmNHWUQyRGE3alI5aTQyUjVUVWlF?=
 =?utf-8?B?ZWdkMnBMQTBocXZvMHc0WThjSDUwRVpkZEJLMjFwS2pteksvdjRGT2JnTGdL?=
 =?utf-8?B?Z3BGSTBuMjBKR2dQOTRSalRwbEd1cDRrcUpBdklvWndkdjRCM3lpSDI2R0ht?=
 =?utf-8?B?OGpoYzdRS2tIZG94MmYwSjgxQ2FlcExCRkt1bEpWRmw0aWlKNzV1dGNMRnlG?=
 =?utf-8?B?d250ZVBFZjFrZzdod0JzV1hlajZ4YTdNN1lRNXVaeHdwVlQ1K2UwYzlzdlQ2?=
 =?utf-8?B?L042b0xLZkh6S2JLS0gzVC84RlBhM2hwaWh0SUl2MEh3Y1BjUXYzSUlHdTE5?=
 =?utf-8?B?Y2J2cktTT0tFV2JQODZzZHJQUHJIcmxubUppd0dnOEp0ei9Iclg1QVJ4UHk1?=
 =?utf-8?B?MzNTRUZ0blllQlhrU1NLM21lWWRZL2lZWUJabW1hckdHZFBPZjRDSDNtRzlw?=
 =?utf-8?B?U1VIeStQRWNkdDBFYWlEOThwWlhFM1N0Uk5xQWNBRzI5bzdBcnVWUUJ3T2NS?=
 =?utf-8?B?VkFrZVBYbWNSTnZ1bUI1NlBtazlJZEcvUjlqSU5aOWlPZ09vMlJDVXNpZ3Zp?=
 =?utf-8?B?NkVKaXVsWjRGR0lHclRwS2haSDQrMjNlaDRWY3dkZ20rMDBjSUFtUG9adEh5?=
 =?utf-8?B?Z1N6aXZHWTROV2d3K0hjWHkrMHBtd1BCcUdVUGhRSm10RjZER2dIN09sazlZ?=
 =?utf-8?B?eFJjYm9tempmSTQzTlpGZWtPK004ZDA3N0poN1lueWdsK0pBakxPaXJpVlQw?=
 =?utf-8?B?VTFRWTlxclZNejEyQUNxR1ZqUzZzTU1JWTVSbmJaUjYrbjN1U2REYVcxbDRj?=
 =?utf-8?B?WDlUTE5PemduWEk3ZUE4RGR6a0dSaExGMFlDeFUyeHhSZmhCMUlPMG9pM2pL?=
 =?utf-8?B?UGNyRlZ1eVVReWhiV1NzK0pqcHphOWxJNU54a294ZmFLTURxQ0VLRFREUHM4?=
 =?utf-8?B?OEJ0azNZMjVFcEpzNkpoZWRaK1oxMklqaW9aR2JOZVJXblNDZ28vcEtDVmxs?=
 =?utf-8?B?RFgvNC9jVlNsZjBnRWdXejlBKzZKRTFKRG1VdC9TZFMveU02WVVVcWZxT1JZ?=
 =?utf-8?B?aHpMUEJCSGRyUjlqMVV5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhOcGJIdEx5c3pSYkx3ZHRVdHFXNDl2Yk9CNDJaOFkvWlVvcDBZV0hzV2pH?=
 =?utf-8?B?dUZZN0t0TzZZZ01VeGkzWktmc2tMK3JZQVhFQXRvQytBaGdhcklUSkl1WnJt?=
 =?utf-8?B?U2V4bC9vL1NKeDJ5Q013bThZeTQxVWpvSzVNNGVSWDJ1eHZPeC9PRFRYUGlU?=
 =?utf-8?B?YW0zaGRzNlFtVjVZZ0Z5UjZkTEZodDF4ZnlMWERWVzd0Szl4VGJCM0xJVnR2?=
 =?utf-8?B?QU8zclIxblNQdEFnYU5oS3BIYko4U0d3YjVHWlhCUnRDL05XYWZ4U051Y05u?=
 =?utf-8?B?cHFXMkZRVVJJSStSQWZMYmVESlcyTGRNem12cHVOMWx1WU1UdWswTldsRnBQ?=
 =?utf-8?B?aDBiOXVGSnFQTm5Hbmt6VXMzRHllTXQ0bnlwaDdCQVVlZDRxM0dzNGRtMVN5?=
 =?utf-8?B?SlZsU0FYcnFTbmZjMmVpcm9tK3ZiUW9selcxaDIxa1BzdWMwR0l2ZWQ0Uyth?=
 =?utf-8?B?Ukp0Q2xsQkJRV2RNVjdMdWxydFFreGJtOHlCUGFGSlJxcTN6bm5xUXl0dVRQ?=
 =?utf-8?B?aC9xOUFiN25CNkI5ZWVVSTBJUitWdEZtMC9qNUxyZml5OEtwUTc3T2lvamdE?=
 =?utf-8?B?c1VoVlg0MFh1VThSWVl5Z2NnUXVWeDB1WlpQR2YzcEt3Y2lqSnBXMmQxdkFk?=
 =?utf-8?B?QlExbkphc3p4cjl4SXRiaEd3VmpZVXYySEZoaEtoSlF1M2k3THFWQjVhRHc5?=
 =?utf-8?B?YWZta0tXNG4zVWZOemdEWndpZS9mRjJZVnQ1eC9iYmRGaXo5WkJpOGg4SkZE?=
 =?utf-8?B?S2hiV2loQmUvWnZSWnlSSGNBSmpSQXVPUHVoM0FZbzJ4TzU3U3RTMkdBRmIr?=
 =?utf-8?B?MldCaDhJRHJRVE5QYXJROEZPb3ZRT1hyS0xHckFDQWl4SVF0YWZwTGJJOEZC?=
 =?utf-8?B?U3FOYXFjRFExY0xEWFV5aUx5aUFpdHd4UmdFbEU1c0pJbnNZNVJaVW0wSCtj?=
 =?utf-8?B?VTdKNnF3a0g0anArdHU3V2hhSlhtdEd6THRLVU9GRUUvaml1QVZqTC9kVHdz?=
 =?utf-8?B?aUVLdVEyVENSdTlhRFhkYTNWeDdsTUtmeWQrcFRVeHFhMTdNOEwwcEJSWGx0?=
 =?utf-8?B?TkJQNnBSWCtEWFpQdnBXOC84STVJaHpNZUtVK3hlUjNGVHJBK0VydVZKeU10?=
 =?utf-8?B?M3FjMnZRNU5vL3MrcmJpZmd3MG5obnZNU1NiMGdMdEtrVmdxbm9rc1hvRmQ0?=
 =?utf-8?B?VWc4QncxYUlYY2RZYlBPMzdobS9OYU82bzNUSW1CejFmSXdUV2cvRUxBS0Qw?=
 =?utf-8?B?bmM5SGwyRkpEWGpJR1VTMTJuZTZMb2pWUUZMREtjeWtjSTVWbGtHZXh5UXZW?=
 =?utf-8?B?TWppWWYwWjBJb09iQ29vY1V5MWNNaEFqdkJyZE1WVURwZ0VTQWQ1V3pjeWk2?=
 =?utf-8?B?eUI0NTlzbEVXYjlBTlJMTXhEN3NYVitaZCtXaVBkT0l0OXV1bm5lQ2x6QkJS?=
 =?utf-8?B?T3NuMzRIN1ptbDVUOFcvYW5DWjhsUE9ETEVzOE5KaTEwaGJqWUJ0OEE4NEE4?=
 =?utf-8?B?aE5tRFFjSS9oNFlPQkI5ZU15ZnNmQW9LOENLNGVIWEIvTVVUZFBVdWRpVSs0?=
 =?utf-8?B?K3dHN291dlRYVUR0dGdWeXJJdGtHcG93Z3JMRTY5S1hHSWVVRHNrdm1jNTk0?=
 =?utf-8?B?c3JxaGsyUnk1Y2Y4ck9tei9vKzV3bDFyRUFaS3lNVHRKMVpmcm1DQ1lxZDc2?=
 =?utf-8?B?S1E3RGN1bmtmcjd4QlZXV25vVlZoRmdUWmxBNWd4RkplaE5iVWEvb1FPOVF0?=
 =?utf-8?B?QUtUblhHYU84SkdTVWliZzhNcjdkUnd1R3RDcS9ZZFhNL3VzZFo4L3IybTBh?=
 =?utf-8?B?UFNsOEVsT2x3U0tTM0doV0R1dStNc2xrZ3ZRVUtVT3pSeXVJRTMvOWN1MTRw?=
 =?utf-8?B?Y1JoWmRVTEV1UjRUM2tYanlTR3RhYUNQZlZDMDZ0akdkZnh3RnN0UFVmb0tT?=
 =?utf-8?B?SlB3SHh5Rlc0cHRHRXZiam5PVUh2bFBGemMwNnVjVWZCNUxLN1BwdlNjZWNv?=
 =?utf-8?B?WjNFLzF0Z2d3WW1xd1NpZzV2eVVBR0Nhd29DdWdvTDNISzVIR1pSQWg1SGk1?=
 =?utf-8?B?V0tPYWkzTTlUUjdadElLOHpac0hEKzBoU1BBajRRQ3NNN1JiTG9ZOXhrZnlE?=
 =?utf-8?B?Q0ZUMXE0dEhESXVXVmUzcTF0dlgxMXFYVVI4QWlwSVFSZEo5NFpqS1dDcWF6?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a46b0-435c-41a9-afef-08dcb09d23cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:40:13.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pxO3rjPVqWCyXQoO3S8GjAg2Sl0uvvDq/k+f0T744w+0Vpz45jdCBdHGwBprOJ3ysLC3whVgce8eBMlefCB5OptL4vcLXlxJ/B/zfQyVfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Date: Tue, 30 Jul 2024 05:15:01 -0400

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add the iavf_ptp.c file and fill it in with a skeleton framework to
> allow registering the PTP clock device.
> Add implementation of helper functions to check if a PTP capability
> is supported and handle change in PTP capabilities.
> Enabling virtual clock would be possible, though it would probably
> perform poorly due to the lack of direct time access.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/Makefile      |   1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |   5 +
>  drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 126 ++++++++++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  10 ++
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +
>  5 files changed, 144 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
> 
> diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
> index 356ac9faa5bf..cff88cb49540 100644
> --- a/drivers/net/ethernet/intel/iavf/Makefile
> +++ b/drivers/net/ethernet/intel/iavf/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_IAVF) += iavf.o
>  
>  iavf-y := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
>  	  iavf_adv_rss.o iavf_txrx.o iavf_common.o iavf_adminq.o
> +iavf-$(CONFIG_PTP_1588_CLOCK) += iavf_ptp.o

Newline before this one?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 11599d62d15a..3961c540c1c4 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2847,6 +2847,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
>  		/* request initial VLAN offload settings */
>  		iavf_set_vlan_offload_features(adapter, 0, netdev->features);
>  
> +	/* Setup initial PTP configuration */
> +	iavf_ptp_init(adapter);
> +
>  	iavf_schedule_finish_config(adapter);
>  	return;
>  
> @@ -5474,6 +5477,8 @@ static void iavf_remove(struct pci_dev *pdev)
>  		msleep(50);
>  	}
>  
> +	iavf_ptp_release(adapter);
> +
>  	iavf_misc_irq_disable(adapter);
>  	/* Shut down all the garbage mashers on the detention level */
>  	cancel_work_sync(&adapter->reset_task);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> new file mode 100644
> index 000000000000..1344298481d4
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. */
> +
> +#include "iavf.h"
> +
> +/**
> + * iavf_ptp_cap_supported - Check if a PTP capability is supported
> + * @adapter: private adapter structure
> + * @cap: the capability bitmask to check
> + *
> + * Return: true if every capability set in cap is also set in the enabled
> + *         capabilities reported by the PF, false otherwise.
> + */
> +bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap)
> +{
> +	if (!PTP_ALLOWED(adapter))
> +		return false;
> +
> +	/* Only return true if every bit in cap is set in hw_caps.caps */
> +	return (adapter->ptp.hw_caps.caps & cap) == cap;

Aren't these parenthesis redundant?

> +}
> +
> +/**
> + * iavf_ptp_register_clock - Register a new PTP for userspace
> + * @adapter: private adapter structure
> + *
> + * Allocate and register a new PTP clock device if necessary.
> + *
> + * Return: 0 if success, error otherwise
> + */
> +static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
> +{
> +	struct ptp_clock_info *ptp_info = &adapter->ptp.info;
> +	struct device *dev = &adapter->pdev->dev;
> +
> +	memset(ptp_info, 0, sizeof(*ptp_info));
> +
> +	snprintf(ptp_info->name, sizeof(ptp_info->name) - 1, "%s-%s-clk",

sizeof(ptp_info->name) without `-1`, snprintf() takes care of it.

> +		 dev_driver_string(dev),
> +		 dev_name(dev));

This can be placed in one line.

> +	ptp_info->owner = THIS_MODULE;
> +
> +	adapter->ptp.clock = ptp_clock_register(ptp_info, dev);
> +	if (IS_ERR(adapter->ptp.clock))
> +		return PTR_ERR(adapter->ptp.clock);

Shouldn't ptp.clock be nullified when this happens?

> +
> +	dev_info(&adapter->pdev->dev, "PTP clock %s registered\n",
> +		 adapter->ptp.info.name);

1. dev_dbg()?
2. pci_* for printing messages from PCI drivers.
3. Empty newline before return.

> +	return 0;
> +}
> +
> +/**
> + * iavf_ptp_init - Initialize PTP support if capability was negotiated
> + * @adapter: private adapter structure
> + *
> + * Initialize PTP functionality, based on the capabilities that the PF has
> + * enabled for this VF.
> + */
> +void iavf_ptp_init(struct iavf_adapter *adapter)
> +{
> +	struct device *dev = &adapter->pdev->dev;
> +	int err;
> +
> +	if (WARN_ON(adapter->ptp.initialized)) {
> +		dev_err(dev, "PTP functionality was already initialized!\n");

Is this needed?

> +		return;
> +	}
> +
> +	if (!iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC)) {
> +		dev_dbg(dev, "Device does not have PTP clock support\n");

This is pci_warn(), not dbg I guess?

> +		return;
> +	}
> +
> +	err = iavf_ptp_register_clock(adapter);
> +	if (err) {
> +		dev_warn(dev, "Failed to register PTP clock device (%d)\n",
> +			 err);

		pci_warn(pdev, "failed to ... device, %pe\n",
			 ERR_PTR(err));

> +		return;
> +	}
> +
> +	adapter->ptp.initialized = true;
> +}
> +
> +/**
> + * iavf_ptp_release - Disable PTP support
> + * @adapter: private adapter structure
> + *
> + * Release all PTP resources that were previously initialized.
> + */
> +void iavf_ptp_release(struct iavf_adapter *adapter)
> +{
> +	adapter->ptp.initialized = false;
> +
> +	if (!IS_ERR_OR_NULL(adapter->ptp.clock)) {
> +		dev_info(&adapter->pdev->dev, "removing PTP clock %s\n",
> +			 adapter->ptp.info.name);

_dbg().

> +		ptp_clock_unregister(adapter->ptp.clock);
> +		adapter->ptp.clock = NULL;
> +	}
> +}
> +
> +/**
> + * iavf_ptp_process_caps - Handle change in PTP capabilities
> + * @adapter: private adapter structure
> + *
> + * Handle any state changes necessary due to change in PTP capabilities, such
> + * as after a device reset or change in configuration from the PF.
> + */
> +void iavf_ptp_process_caps(struct iavf_adapter *adapter)
> +{
> +	struct device *dev = &adapter->pdev->dev;
> +
> +	dev_dbg(dev, "PTP capabilities changed at runtime\n");

Is this needed at all?

> +
> +	/* Check if the device gained or lost necessary access to support the
> +	 * PTP hardware clock. If so, driver must respond appropriately by
> +	 * creating or destroying the PTP clock device.
> +	 */
> +	if (adapter->ptp.initialized &&
> +	    !iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_READ_PHC))
> +		iavf_ptp_release(adapter);
> +	else if (!adapter->ptp.initialized &&
> +		 iavf_ptp_cap_supported(adapter,
> +					VIRTCHNL_1588_PTP_CAP_READ_PHC))

You can check for the cap support once before the whole block.

> +		iavf_ptp_init(adapter);
> +}
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
> index aee4e2da0b9a..4939c219bd18 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
> @@ -4,9 +4,19 @@
>  #ifndef _IAVF_PTP_H_
>  #define _IAVF_PTP_H_
>  
> +#include <linux/ptp_clock_kernel.h>
> +
>  /* fields used for PTP support */
>  struct iavf_ptp {
>  	struct virtchnl_ptp_caps hw_caps;
> +	bool initialized;

Holes.

> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
>  };
>  
> +void iavf_ptp_init(struct iavf_adapter *adapter);
> +void iavf_ptp_release(struct iavf_adapter *adapter);
> +void iavf_ptp_process_caps(struct iavf_adapter *adapter);
> +bool iavf_ptp_cap_supported(struct iavf_adapter *adapter, u32 cap);
> +
>  #endif /* _IAVF_PTP_H_ */

Thanks,
Olek

