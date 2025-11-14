Return-Path: <netdev+bounces-238713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC3AC5E65B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F9653C64A3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81FF281368;
	Fri, 14 Nov 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCim+F1H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E626B942
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135762; cv=fail; b=JZHzhl3X1BPACis9qvaIAlLH9GZhg/NbTmNc7vX3ShCQq+BYaCvUhO4tqqUxjf8MDnP8AUFWJDZhZ28JX4ibye4qtoTp5RKgPKohFLCtBkZVxWcOb8uL5NR2afYWUoaZfD+eW0xrBDDX/0+b1ZayHvlayfJfzd4Q6J6o0dCId98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135762; c=relaxed/simple;
	bh=Qu6jwn7JTxYyredyt+MBChaUIi6FaiKIolSKmgeovOs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2QUacpXglNYeZHxUzO01O/cHE09q+FTWujf6d7v0+fIxTz2clwuq717v1ZLztSSsCioehGtBGc0V7+BLkU0u2jfrWURkfr5ugIUqeSmj3Wtx5bBICUzkk58uC/i0T9VQrUsFFZEhvwnSBr0KxN6V8NfaelcRYWRNO4XaamQ7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCim+F1H; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763135761; x=1794671761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qu6jwn7JTxYyredyt+MBChaUIi6FaiKIolSKmgeovOs=;
  b=MCim+F1HbQ6hfEddjSrKEgY1/We2mI2R1qrELm4XSSBh1TAb6Tv+onBV
   qpAVpBu9AMiW0mk3nmGxZmPy0h4Nk8WU8kIfYT0ipi9asL4a+BtYb39lq
   qWNvKlX8TW/BKpovt8BVsuRO3wsw+8YUWmsRwQL3rJ8QwMSRG5H72BNkK
   DAXkRYUKFGlIOIvh+Oyn12RZ/Wp3MOl6BxXeP8aHNTPMm9yzLdP+tNRi0
   v0diKuJ/RDeowv4+cM797kPT3/k7GlZoWE1yoC0f3rC4nddweseQckkrV
   6fuudXlr+oNKxb14I25nBpWtqA2RpPnUY1bsJrzZ1T3lQwK/bLTqzTj5+
   A==;
X-CSE-ConnectionGUID: zMLUWhp6Si6ITmns5J81wg==
X-CSE-MsgGUID: 6D93iotiSKWmvS1WT7kaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76693964"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="76693964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:56:01 -0800
X-CSE-ConnectionGUID: ImVwXm69QPqSO25r3AWmuA==
X-CSE-MsgGUID: P+LbqO92QB+YobpvY58ARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="220448678"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:56:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:55:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 07:55:59 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 07:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpnvyBIioSQIJpgd8KNOzgBrf2O+1CC3MblYJBGL9nU9ldl+IzjxqG4NPNelTz31Zq2vj8OLxTGO2gbFmBnLOag4szvoVJmGGkXRuaSK+8XOppaHnPUozGIvVH/6TZPvHzkqef9yskih10B15f4UQ/rO1kNZ06dUrStNWWQF7icSVtyXSx2gcCGnhzpsbYt2hvRBLPsgFrJtYzhaPKb7sYu+ADydU8Cc3l6ajsEFrmrRv4cntcApP6PfJZGRCKI4xiQW8kd0UjhSDHIMuMIx7ZVZIjrpjO2RCka5UGj7KHT6alfBTYiwc16HPc5BhaTSbNd/3o3Y5W7sWKKwBswjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8qfiPzLODVrgnOe64TOtcC8N3C8Y8JgzDTdIo+szOo=;
 b=mcfrXcJ/xZ44jZ9DAgv+cePABXA7utY1qQwNdN8zYHthRrconqzPdAspMOBnhEPfBjfJgN9UGqrnNjTyWEhDvX1nYVYTPUnWVokD/fgLFYBZ1Uk/0BcLgqCDKIOL3s9DUYt7uqHEN1QjHObwO1JwlNuSuRsC73n4KzvsD6RxL4yZAiZJPG7hiwEcNPTWbqkaIFRdR5Y0NN/ko1hFD4IPsDrmS6vWQ9XbRIALr7kt96ej5UHfa5Gx3IzwZMDds273zu+s2HB0SseodlSWqeSl9m+4JgF+bfWr74ilQEhNfjYInM94WXBCbEeyKgRXdB5hMAz+8bgn28yfvReZleNWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 15:55:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:55:49 +0000
Message-ID: <7da3a15b-c1fc-4a65-bdfc-1cb25659c4db@intel.com>
Date: Fri, 14 Nov 2025 16:54:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251113140358.58242-1-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251113140358.58242-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0b219e-e866-4aaa-6c92-08de2396480c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGRHL1ZTQkV6bFVWSzh3cnhXZ1hqTUR1TlRrVXA5M0ordDZxTnV0d2VBZ0Er?=
 =?utf-8?B?Z0VaT2I1WmIzVHVuZkVWR21LcnUwVU51SFJra3FhTXQwNzlPS0FHNDJtUnF6?=
 =?utf-8?B?OUZvaVFYdGt0a0s0UTB5SE5IUE9abjJMYzB4Q1d6UFNxSTVtWEwyM011K0cx?=
 =?utf-8?B?RVdZa1Y2MkxjUDE3dWZCTFF0SldORTV6OHN1S2JBeExuYnlwb1lrbEJtaW45?=
 =?utf-8?B?N3pycDZ1cVNMZnVPMlVDYzlUcXBqdmo4L0Q3MjdLYzlRTkp4NXVYVjlxU2RU?=
 =?utf-8?B?Ny9UR0FlQ1l3UC9GT0Vwa3R6RmJCUmpkSHBwZWZ6RzZlOTFFckp2Q2FieEMr?=
 =?utf-8?B?ci82TklodmNndlRjYmFVVytZbmpLK3NmV1pxNG8yelVVRGYwdHRUYTNoRStl?=
 =?utf-8?B?blB1V2pjZlRRYmNIbHdIL3diVTVYaWZ6UFJYdUFWRjRtcThVcEZUejhWQndN?=
 =?utf-8?B?Q01rMzdqd1NhMnJyS2E0bDl1QjB3Rmd5OE96SU5RZ25xLytEejFwVUNaOHlZ?=
 =?utf-8?B?RXJEOHFvb08wdkxNMk5LV1laa3pGaXFsS0I0cS9jbWVuU1hlT3NBZ3k5bk5O?=
 =?utf-8?B?Rmdwd0dMa0xqYTE2c3d0SDZncHVCY1lwM0xlR3lTc3hCbVI5Q0hNbERMeDdx?=
 =?utf-8?B?bG4xZFAwczBaUGEvMXUwbEQyQlRyanIrR1cyd2puSm5PK3hTczQwbnFsQ1Jh?=
 =?utf-8?B?RHJ2cGV5d3VZVlhMb2hOMXM0cGRoWHUwVlAzTnZHWjVPeFhYMHQrL1VDS1hn?=
 =?utf-8?B?eVJNdFN4Vm15eGdhN3Z6UDVzY1F2TW9KbGZPbVF0djhpQ2ZMZ0lLOTFidFpI?=
 =?utf-8?B?THhYaDhFdm05OWZFckY4SmtxOTJtSlZmZXlwSytjckRWelUvdUVkM0F0MEQ0?=
 =?utf-8?B?VCtRVFJBTnJmSEtBSUdGa0Q2ZFJxRk5mcG5mTUlxV1c5RnZqY2JHSlRJcEJq?=
 =?utf-8?B?SWJGOXZQbWdmeVdVaWdCbzdJaTkwM2ZOVUh2cytlWk8vZUVJZUVNcXRodHVJ?=
 =?utf-8?B?SjdueEQyZndwcUZnU2Juak5kVU0rRWc3dVAwYUZRNVVSR0ZkYVQ1SnhXL0hX?=
 =?utf-8?B?bE03dHFVSkFYUGpTM3VIYlppalNZTG5rSitycE5XOGpHL2F2WUlvdUdVSExI?=
 =?utf-8?B?TDlhRGxZS042L3duaUZ4WUNDYXJ6SGJGVmFjM2J6OXhpbFd2MUNYYnlLU3R5?=
 =?utf-8?B?TnEzWnFvQVNSY1Izd2grTGhXQ0NsTHZuK3lidk5yc3Z4dFI0T3Qvcm53Zk04?=
 =?utf-8?B?b2QzYUk0QXRCaGRTcWFWbFROQ3NoTTFnUUJIaHJGQ3lybGhwUmNMMFVoZDlR?=
 =?utf-8?B?aDVnQVN2NkFNMjMyVW1ZQXRJZHBER0lZMGFSZ2lnN3ZKdlEwRmNTUXNVUGdU?=
 =?utf-8?B?b2RPL0cxR0JRV3lyNCtiNWJqYVd5MkQrMzBJM0x1dGZ4NURuOUVTV01RY25w?=
 =?utf-8?B?UFhkWldsbHF1Y1k2RG1XKzMxVlBlbE1nSlYzWXJOM0RmSnBlMXB1TTRuUmda?=
 =?utf-8?B?STNsK3lvZUFJVk1wQkNQbjhsdzZpejFKdWF4KzkrZy9Kd1JqSzhuMHlXT1I3?=
 =?utf-8?B?K2M0WGJpWDlaQk03c2o2eWZ3OXdURmIxc00xc1dtVGtPaUtHSkNvamZaVUpS?=
 =?utf-8?B?dVN4aGZqSUJCSXB4b2pvTTIrSWFXckNjVEtoOGphaytCVmxvUW1oU0FYQUN3?=
 =?utf-8?B?Ny9Va2tXaGVzM2JWZjFxZ1Bsc0I4ZktFcnhmY0VRaGxxU0g5a0c4SWYxVTJ2?=
 =?utf-8?B?ZUlNNVNLVXJReUNOR3dHeFJ6NStDOFU1RC91dVUrTjA1VXpPa0ExWnZ2WTRK?=
 =?utf-8?B?TW56QkdxRHZpOGF6MTYvVHRwOTk0cGUxaFFwUE9iOVN1Nm9DTCthd2NBMmJE?=
 =?utf-8?B?TmkwWnBDdXFSVnc3TUZKdXVlQ3MxblI1dVJ6OFZMTnYyU2JCMWhJS1k0OTFQ?=
 =?utf-8?Q?woNIif9Xy1LcZFysB2mUlIhU+C4bz+Hi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUtOWUhPWGpXY3N5dzc1K3NnbGJOaWV2V3dTSVp5NFdNZWhXUHpQVmlZTUdu?=
 =?utf-8?B?ZUVxTzk5T2dvZm51OTNXUnE5TEFwWEpMTnl3MkgvN2krS0FDTVFiNm5QT0dt?=
 =?utf-8?B?OWtqY1ZSZzBTVnJ4UGxnZzNjRy9XQTYzcDZLbVRXVXl2aWN2SzFyZXFRTVpu?=
 =?utf-8?B?MmpNZlF1T2xSSWN4cWR3TXN3SlVrSkNVajUvellGU01EN05WTGxsRGZSVXE0?=
 =?utf-8?B?NzRHL2lZYjdIRTV4QkJ6V3htRXR6THQ4MmovMWFCN0pERk80cGZ4ZXlPT2dT?=
 =?utf-8?B?VFhaNzhnTTNSK1krTU94c0hNMUZOdUhQVmF0QVd3d0hBWnMvUE9IK00wbUNJ?=
 =?utf-8?B?M0RGNWtwMFB4UE41bHZwZGdhQ013UzU2eU1BdU9TN0NhM2hYa0tEM25HZzFk?=
 =?utf-8?B?QURpRzhTWjZrb2ZTOFNRMEpTZ05LRkRjK1RuSnZmS09qOTRmcU55UkJVMFdZ?=
 =?utf-8?B?OE1OaFVkbEJ1MUg3YVloeWUza2pqbFlsYThYcmhsY2pvZFRUdmRvYzVvWEdq?=
 =?utf-8?B?clJRTnZLNCtjVzBGK2oyRTZwbHhYUW9NdGExQXNTVWthR3BsejdRWWZvNHRN?=
 =?utf-8?B?cGhzWlMxMDcyaVl1T3JsUXpkMnEzUWtmajQvZk9vdG1QcXBEak9NNnhPN2Fo?=
 =?utf-8?B?RU44T3RmMmhJZ05hZDNVdGdnU1Nvb3FWRmp4RE5JaWh6RVJZTnVXZ2Y1ZldG?=
 =?utf-8?B?cFg4QS9CSDhWOWg5U3hpZGRoZE13UVh5NG5OUFdDU1IvNW9oR3hxOVdkZ2Zx?=
 =?utf-8?B?d1FZTUhvU0thYVFJTjE5cEFSV3NSUmVGWTkzSHpnNWp1TWszc0tpRjJKM280?=
 =?utf-8?B?bEJwdjJncmpKbU1VQXBHZGxLVEJpSnc1SFdRSjdmNUF1MVZ5bFA2MXYwazFj?=
 =?utf-8?B?NEYvakxkUVl5OTN3WUdmMUYzWVo5VkU2MFdPdE8wNVNKbENIVDNwZWlVNzdD?=
 =?utf-8?B?dk5MeVZOTUxBUWtDRFZrd282T1o5YXJhaVJSZE5FQitMU1BLYk5DZEpZbU81?=
 =?utf-8?B?NGRHT3pvaDRZQ3o3WThCRXkzc2k5eklvdU91bjMvSGU4WnJwblk4ZDhZLzRC?=
 =?utf-8?B?M24zQmtnYnd2VXN4U3dWemVaMUxvbDNJSjlKZi9xUElrV21ML3hkMXRLRkJB?=
 =?utf-8?B?V3l5Q3pSWUtXdkNDTUpzZWxDUXJqVDEyV2VvOHk0NkdJVnlIWGpScE1SV29Y?=
 =?utf-8?B?ZG5OQUI1Rzh3VzZWb0ZwR0ZoemNOS0dsM2pFY1o1QTF5OWNiMm00d3Y0eHFF?=
 =?utf-8?B?Y3JtZW1wbllncHNkOUNDUjBmcDlNSFk5dzc1aCtPRVdENE9EcmZUOURGcEdN?=
 =?utf-8?B?aXk5SW1nWmNVR3V4VTRQRStJVTRFWklzaW1ScGpzWThGa2R3bmlrSnhTVnRa?=
 =?utf-8?B?T1lvNWNDOXNaeEVNTjhRdHBkWkwwYlRuT1lMaFJpNnU5aHUvMmFqY1VHSUVh?=
 =?utf-8?B?RXc5UnBEWDhpM3V5V1ZnM1VCckVOdSszTDJXdk9VN2d3WklmR1BSSC9TaHVI?=
 =?utf-8?B?OGdVN0FYNHdPcWk0YmoxU0xHdUIxeEdBZHdWajdCK1ZhOG1qWHhOYzZsWUI5?=
 =?utf-8?B?N0NsbFpFTkZid0lqUUwzeWF5dFhZL29Xd3o4cVdTejExVXNwWEZyMERsd0sy?=
 =?utf-8?B?RmFJSEJPd3I4ckkxVDV3SmM0MVJIcUpFc0QvRFowa2Z1R2tQNFU2WWRvMHQ4?=
 =?utf-8?B?ejBFQVRXUlVjV1JQczZ3Wmh6Z1NpNCtaZ0JaQlpRd2ZjSmh0V0owZUM4NTFn?=
 =?utf-8?B?ajBIajJtSS9rWGNRWkRNWDVXNjFHUUozcmx1UUc4ZGhrSDdIRXk2SkN1bmNO?=
 =?utf-8?B?WDN2bVQyQjdBRmVQSjJsbWFybSsvTXZBRmdUc1NsNHU4S2ZIbWszVGZYM2hy?=
 =?utf-8?B?VG5jTzhacTB3Qm42eVRlY05CL0hPbVp4cEVvVytwd0JYU1hlYS9ScmZYRDI4?=
 =?utf-8?B?SVA2cUxObENSNzN1RmgyUjBjdGtHNmtnYklLNzNQeTQ5akVndmpmbU1OaWVJ?=
 =?utf-8?B?bmdQcmlQaUpIZnJkMWxkS0JpOHN4ZG15SVN1dEUwK2poN0ZNeUpSTWd4Q2dx?=
 =?utf-8?B?QUwxVFRsQS9TaHdXZG1Sci9xOTNvWTRsUDlqcEJSVVBtKzF5RWhjTDROdzZz?=
 =?utf-8?B?QXkrQy9WaStVZzlsOHR4dWRwRjFBd3VDbXl0MkFxdmFLMmc4UVBUMGtKOHVZ?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0b219e-e866-4aaa-6c92-08de2396480c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:55:49.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXFQj4fWnqNnM9Jo4k5kn9Nlq24PwQNS8/u6UCzDXQK95hxMD1yjYRAhwjKNpGS6u1pZkjfiFUvozlqKvCZn/TbBi4ZEUYzoMAQOMqQJ724=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 14:03:57 +0000

> tcp_gro_pull_header() is used in GRO fast path, inline it.

Looks reasonable, but... any perf numbers? bloat-o-meter stats?

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks,
Olek

