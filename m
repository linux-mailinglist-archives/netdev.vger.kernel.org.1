Return-Path: <netdev+bounces-122958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156D96347C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100281F22D21
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461201A76B9;
	Wed, 28 Aug 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXstKGNN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12F14A4D4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883455; cv=fail; b=fAXk9m+CV2e7FgWeaCgT8kiNsDaBSvBn7geBjNiqTaxmrYl3QlUh4MQuGy/moENKRrWzSl58n6ZTs88QxJECHr3XuQ/Xd4cWDXJ2nE81M5ZElmK3YAFAyEB1PtSr1oLj8WQNclCRGN3Xer0/8b+dFDTpFyosILJ0CRa35NFMqcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883455; c=relaxed/simple;
	bh=zSDaFaAYar9bC55k/FernQ9ISQ7KAi4/DuXtMto5cFk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lmJwWCVy3UXuKfxteoUYUw5xi9Nv56VQ4hH3cvoS1WXotO983L7jWbSwYt5L3/2PZFz28sx8pmvF47jxhne3a1y35WwhtH8Y1C33qKnouOQ2o+xJLb3E1QwHAJH/PzlPhQ6JIl6nj5Pu2A1+GHlLj5urxTP0EoTZC083gAveYVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXstKGNN; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883454; x=1756419454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSDaFaAYar9bC55k/FernQ9ISQ7KAi4/DuXtMto5cFk=;
  b=BXstKGNNePHI8kkgt0onqehiyeKVGSrpGtbzJPqJd3DfkwXXrf2KgULb
   ZKDUHU7d1l9s6zT2ewkONnvtIPekiLqCmrumCDF+Aw+t8JdMZgdQmufyV
   s9EM9EqPB2ycyon5hsg5SRqKXUiezM35og3nETtMFptN6lyEt5DUG64NC
   CdU5HEd/wm3AA0gRf1ciiTDJcRqcoAm51vUK9nK142RW/n2TVLVr8d4G3
   vZLGy4KVn+ZtsL5v5B/P7c+bfaUtIDM+QN4PJBrUq2iHJQZuk1ncbF4zQ
   ZNKBkUy3+5sUr38LOFMT6fO20JtD6Qvp24D8rLN8HtaEMCh+4kX7SBhEV
   Q==;
X-CSE-ConnectionGUID: 8gbsSuytS/eMOw3xUmI2nA==
X-CSE-MsgGUID: v3UjnkIkQX+zhiEBzBZg3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23589012"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23589012"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:17:34 -0700
X-CSE-ConnectionGUID: xE4DTQVgSN+b8/dkIVbJFA==
X-CSE-MsgGUID: /pmR0JKZQVmn73Xzwb19JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68195822"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:17:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:17:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:17:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:17:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzjGcD/ou6BOSCbjn71PncLb7k2tjxjvPUF/4RGedonpaqr4viz7BjfdS/n3BoAjUSIOe7qN83J5Yy2B5e2C9bzGjuOQaS1lLIjCv5EcDD1BbCU94Jwz2zzy/aFLbvmhw9HE75j0A6qeAiHLwWNd1Xoh4UvrRXA+n/AjG8ReR3DLi7hraOQ7jOmsGjZ5+XK7IsH+7V9spegPfNkmYd9NZZoRHvwv2bVrl6dsCXV95M7KfhTibY4MujU7Mo0Di8Z18rdkkB4K+Ee+HiP1H8hmTWo18Z9qI9WsoB2AWbkXfkSuY+41aaSVLIXzSykJrXnJSgZ5TSJEH8z11dTjG3SIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trn8sVKHaSEr41Z0Z7VilG3a99GV7yClGS576pw1euM=;
 b=rgOnkA+3mpFP8+4l/P7JjRzqJbk5gq+IQo5HbOet0aInEoSSJE5ZcDt3WqURwNkaEDp9PsFLakcK75/HRhffU42ophZIq0AmQWJkR7UsqQRmodhckK1kbtIDfYSQFZW4vC0EgFFb7Y4fz39DhGfAdDiTzlR71OrsxgMAIphkpap94F9IpstoycSvMYXhdH4CkMvYRdOAyg29mbX3RFIozR82DVNnzv0A6izkrkwCpt5tRgQQCU708pXBA2m1XXXT5sUBVA9zvPXOmDdfpknhZFVKdEGF7k/YcOpfk6p5MP7JGRhRtj/xbA+Hzwgm1jHXiHwFM1LNWfyhNBfDZVIXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:17:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:17:30 +0000
Message-ID: <35be1648-65b7-4002-b979-97fbb5be1235@intel.com>
Date: Wed, 28 Aug 2024 15:17:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] sfc: remove obsolete counters from struct
 efx_channel
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <f56eebfebfec5b780ef89e1da095cbce5cbf240a.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f56eebfebfec5b780ef89e1da095cbce5cbf240a.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9f2479-b7ec-4f0b-834e-08dcc7af34d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ZXVmoyMXkzUTZRU1d5aWpvcy9yaXJobFhZK0NZME8zSHVUa3VnckpxdUp3?=
 =?utf-8?B?d1cza0pNRmpYQWRNN3VJTVc2c3h0Zi9IU00vbkw3YjNzaHpOZHJpdXlKanRv?=
 =?utf-8?B?d1FZN080R2RIQU5YY1Z6Yk8wV0NhSHMwUUgzVEdxZ1VsbWh6NUFmdHJPOVU5?=
 =?utf-8?B?U3NMc1ZDRkFOMklJM1craUQyMlV2YTJkRVVMSVVIUUN3SDgvUjFMNDVGZ0pB?=
 =?utf-8?B?bE4yQVZvY0U2SUcxL2F1SXZXMWwxVGx3MCtiT2g4UWU1eVBrTVVYK3JwOTk4?=
 =?utf-8?B?Rzg1bGtBU0ZPK1RreVFvOXZ2dkJlcjlWeDJFdzRvckMzQ3pYYmxha1NtMElz?=
 =?utf-8?B?aHJ0RCtXYlRBZmUvSXJkRnc4Mll2cFk0a0grSVJBUW9GY3kvQXh0MkE2OVlR?=
 =?utf-8?B?T25XZmdCaVJ1Z1Z2aURNT3JIZlZyUnN1Z2F6clBTNFJzNDZZMkZVQ2p4VmNk?=
 =?utf-8?B?cld6UXZnM2NGNXkwa2ZJNkxKcGxaZkROT1JYcWNUVHk0QnoyRGQ1S3NkUnhq?=
 =?utf-8?B?YWN4dHlMN2tsdTNUTDhMQ3FSZmhmd3dtNm9PTzV3ZzMwRm56Y25weUlWVU9o?=
 =?utf-8?B?dGpSeXZvM0hxMTN0Rnp2Si9uZEZ1VmphNDZIc2hocVBnRFd2ZXpmOXZwdkFx?=
 =?utf-8?B?ZmxPV2NuZUJ4dHJWSVk5Tk9wcWFHQ0dYQ0QvSzFQem96Z21udVBrUnRVRkdW?=
 =?utf-8?B?M24xNmhzNEZqZTBtVnlqcHNnN28zZHNiS0xoN3l3T1B4Q1lFek9kYlJKQ0FF?=
 =?utf-8?B?RTNYQ29UUmgxYUQzUDBxZ1dIQk1vV1ptSjFxSXJGMGRhRENQMGloSFdzZGxH?=
 =?utf-8?B?NGZqK2lweVQ0SU9lTGtFMkhrWnhzclk0MUIrVG40azZDSy9qZWxyZ1MvUjNK?=
 =?utf-8?B?bmphM256VWR5cTFCV1FwbUpmSEtkL0Jpak5yc3B1T2hHVGRaUEhHVU8zWjQ1?=
 =?utf-8?B?aU83ZXgvZnlIMnp0MnVBemFaWXFSdi9oNzc3ekxEb2J4MGsxR3A1ZGhWMlRX?=
 =?utf-8?B?eUhkVTIxcHdPVGZ3dGFod1I5VlhwNy84Nlc4eDNYTTNDK0pzTXovWWFoN1No?=
 =?utf-8?B?a1E4TWJRR0VYdkNlYndqQ2ZKcXYxeWhIbGJSSFRQQW1uT2dFb0dqNHgwNEhY?=
 =?utf-8?B?dEw1YXp1M20yNjUwZzV1SVpFTENGVS9lTzNpaGRYZ1JQSlh2VjIxOVI2SzVV?=
 =?utf-8?B?SUd3MUF1SWdUNXVHOEI4YWt5alpEcnZhZ21VL3NhZ2pPTDVVWFk5RFE2N0VO?=
 =?utf-8?B?a3lqK0Q1dE5ITGt1Q3lPOUxsSVVoSis4L040MDJjdXh4ZmlzaURITmZJeXFB?=
 =?utf-8?B?emo1ajhVMzY2NGMvN1B0YjErUFJEemJnZFJrUGdwdi9pTnA5TkRndFZkcjBT?=
 =?utf-8?B?eFhtTmlVenJyc0w5dlZhZ3B6R2RrTUw0MG5VcDYzZzhuOXFmQ25Fam9BbThR?=
 =?utf-8?B?V2FnR2FoMUZSamlZUzVGcVBGMWk4Nnk3ZkxyU1ltb1Bza0U5SEkrVkxqamgw?=
 =?utf-8?B?QktnV2VPdFRkSWl4ZHM5OFhKc2dhb2hIRnVDaWFKbTJTODJtWlg5M3l0UDJz?=
 =?utf-8?B?SGVTUmd0QkczdWhvUHlscWdEbC8vbUgvZDNWWHpiZ1FtcFdodmIwbm1sUWw0?=
 =?utf-8?B?YytpTmlDeWtGeVlZMm1tMVYvQmtzV1Z6WDlSWVJyeDFhLzdxNmxjbVA5T2gr?=
 =?utf-8?B?S1Nna1JCNkhuZXdFcExGTWlEcC95NVJ6NnZRV1o2N3NFYzd0OUtwTHRTVEVP?=
 =?utf-8?B?UXZMbVJCeEtIYWxvWlMvVmZDUlFxWFNjUTdNNzdleTVUMUV6eWliUGk1ZnBu?=
 =?utf-8?B?SFlqRFBPSFF0b1VGT25XZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNPWVBHNWJURkZETm1tclcvQ2hoVk8vckNvTkp5b2prWUhYc2wvRnF5bU83?=
 =?utf-8?B?a3dkdmM0UW9VcnN5MGU1bXd5elkzM3JTSXlDZ2FXRHIxeWVlUERNZWd4ZUhj?=
 =?utf-8?B?YmptaitPRHdleXU3b1d1S1YzWGF2ZDB6a1pUUmxlWGR1Z1BCNHRGeExqZUhv?=
 =?utf-8?B?YTdsRGJ0MVlDa0lPTEw2aVlpOG5walVJM2l1YVlUOXJubXlEUlRma0N5TFAr?=
 =?utf-8?B?ZHV3aHpJUFlMdjc1MHA1azIyaFZSUDNNV2NUTE5odjFRd3F0YVZDYTZoNmlk?=
 =?utf-8?B?Uk93TGFWQ2NldzFSQmJmbnZyNVVneVNXTURrTW9WYlBETXppa1BDdndqSXVX?=
 =?utf-8?B?NFd2cXpCRlhpWHVTQkh5VlRaQ2l0elhrVzlza3NJQUNlRkd1a3orRVpGTDJU?=
 =?utf-8?B?Ni93YnpVdmVObXZvSC81emlOckd0aGNuTHpUcVVwTDVrY1RkYVNXWGZ3Lzcy?=
 =?utf-8?B?OG9DaUdab2Z0S2NtbDNBNXBZV01zeUNDSCtLRG9NbDRtUHY0Mk1YN1B6S0R5?=
 =?utf-8?B?YmRBYnhmNkxRN1dEdEVsZ2QvQlVYc0JOT25MQ1dBMHBmWnVFd1FoWGJzR0lr?=
 =?utf-8?B?VGVFVThJaFg2RjRVSGpvbXBqdkVDTTAyQnhKVzlpckJpeFFoVzV6Z3BZNm1w?=
 =?utf-8?B?Yi92WHpwQVd4Q1J1RFU4UHFDSDJHek5GSmxxbzBnakpWRzVXSjkyNXQ0Mi83?=
 =?utf-8?B?YUJEdyt5blYvVjlHYnVMaGtzMUs1d1E2dERiY2MrS1AyZE1Yc1JpTnNZeHJi?=
 =?utf-8?B?WHQ0ajcvUVk5L2txclRrWExoaDFTQ2lIWkZnd2FxN0dBWVZnR3BGV3NRdWVJ?=
 =?utf-8?B?M0pPSEZOSmxyeU5WSE1oV3I0WFhWNlF1U2dNZ3U2OVdGbFRzMnNaUlo4bTJT?=
 =?utf-8?B?VHNNdXNJTyswUi9aZG1DSXhxTXVUMFhRN2EyYnZaWEt2UE8xaGdYL1UyZHZs?=
 =?utf-8?B?c2loUU12V0p2WXkyY0FLZVB5TFU1aTVObDBBVDZaOEpzSW1neVNUL0Q1ZXRt?=
 =?utf-8?B?OVFMaGhRV3FkV3BGSGZQMkFmbnJmU3htLzV6dDVEK3hMTjFnZDJNaWZZQ1lI?=
 =?utf-8?B?bUN4eTNUNXVtVWJkWnBXTjBYNU1mQkI4V2NxZDErb2s1VTdZeGhXY2h3VURH?=
 =?utf-8?B?SFFXREdXdWxwYVpwVE9kWjAwSmNaQ0dqOGRadXFZZ1IyUVBlSk5CMTgvYi9x?=
 =?utf-8?B?ei9HMjlJaEY5cXlSckFRdGc3VHhMSkJWRlliRCtvUTFNajR0UWx4ejVzZ3pv?=
 =?utf-8?B?a2xXVUJWQzB0UXgwcjBoZkpKbVU4QkdhV3J1Mk00aXQ2bkFLUVpEcDlrR3NR?=
 =?utf-8?B?bWZDd2pHemhYaHdnZmhyZHlsUG4wRE1yOFM1UkE0Q2JaVE11OUxKZlRJUllJ?=
 =?utf-8?B?TEpzaENmYVFaZ04wMml6MTJybHR0aUJsY2xVcGE5OUtFTWxwTERoSStvYU9p?=
 =?utf-8?B?NXhpWEluK3pMQytKZ2V4UDFxUlJHKzluNjkrYU1iYU9VUHgwZmpKaUF0SGRY?=
 =?utf-8?B?QnRqbjhrOUh2bkszSGpTb1V1WHNSUnBDZGxnY2IzaWNxN3RXN0k3aWhNN2tw?=
 =?utf-8?B?TUlrVU5OeGZPd2lJV0cya1hYZXhQUjRGZEVCYk4rbitXRkJjanZzeE12Y0xa?=
 =?utf-8?B?Ui9oMjl5OCt5UCtHc3hpSVI4QlVTK2JWemVvaUVadC9ZWDBib1hhblY5WGVL?=
 =?utf-8?B?TlQvbDRaUGtDbHpKZTM4akwrc1lSOUtXa2cyNXdCVVVhWWZzVmFoRFlYZXJt?=
 =?utf-8?B?S0dNcmoyUlVNMDhPY0I2NXBjbmZVRmNCck1INDhtVVNpR05TZjgyWVY3a3lm?=
 =?utf-8?B?azh0WVVCOWFIaHB5ZTJxU2c1d0dpTkV5QXZBMHN2K0pTM2pNVHdDd29yZ2pS?=
 =?utf-8?B?NDlORVhoR05Rc0VwSG42YTRya1VLOWx3cnJoNzlGWnF2WkF1dVpJYVZpL1M4?=
 =?utf-8?B?Rm1zN2JpbnBHb1Q4cWRUa1pQK2FKdDMxOUZRMU9JQTNONGh5NkxOd3lNbW0v?=
 =?utf-8?B?RzYzR0dId09UeWRtTnpuOGg5VU56UTZ3VGs1WlRDekppbjNrbVZPV0puYUZ1?=
 =?utf-8?B?ZkpXTVBWZlNLODh4R2lnZE81Ky91cEpZd0FhdGRxOG1QMk9Dd1NDK2JZcjhD?=
 =?utf-8?B?eTNkTkRuZmU2U1FVNHJhT3BKMzduRElSRFNTVy9xNVZVS3JLQjliUXdiUkFh?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9f2479-b7ec-4f0b-834e-08dcc7af34d1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:17:29.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKviaqEbW8UCldTcfrxqA9izws1CUfzv6dbrHj0W4eNyRR+uYyvPoAwQpux9TMojM9MzumzTUvdmiOwIWG2ikIxwfdhoQHT4byhWMh2Tdj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> The n_rx_tobe_disc and n_rx_mcast_mismatch counters are a legacy
>  from farch, and are never written in EF10 or EF100 code.  Remove
>  them from the struct and from ethtool -S output, saving a bit of
>  memory and avoiding user confusion.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

