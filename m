Return-Path: <netdev+bounces-157857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1494CA0C102
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50BA3A2C04
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BF1C245C;
	Mon, 13 Jan 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLLzkq3I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B7240243
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795309; cv=fail; b=mUXzXHT0qdPgXxx0rTdg/QeJ2jhJpQepL++PDGF67d7bGhiMjL0EmCU0pNAOmDOZ3pTrFkKXpVoLlcS6CrL7IXLPNm6nNOv29Z3/DWX0msaBLn8tW9Y+Sd6NfPiSAIKurhgCjvvd8H5rBoqb0aD0lMoCo8vVqIrbBsWtQLaRXHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795309; c=relaxed/simple;
	bh=Oo6usvGOXeZxGsSuS5KnBxBZBoIIMIORxhtWkwQphOA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DXvNd9DOmyD5udZ3luFEYgrpjN7MV67A+GvLgoi8uwC9NJzi55UYg3RXaqeuAPtxQGr0MsHkSeute/5hbAbsa/s2jc+6E5LGSONeeyhM4euUxAMMAg1lOPjHCgY7+8iNFzCgLpXqw8HB/91wPWj9hTV8uRjDBXm4u52gb6Tkhrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLLzkq3I; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736795308; x=1768331308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oo6usvGOXeZxGsSuS5KnBxBZBoIIMIORxhtWkwQphOA=;
  b=eLLzkq3Iw+wnlFm7NrFQJ+klZPiUFWz6qXbVoJQlQc451KhV8ffefi2Z
   /gTcb5QzEOUNovM7CrMyr1iEQVbK7AtpfSNKGqcSk3kcTaM4P0hOyWi2b
   9Vx6GIEl/VXvWy6Z6yOZHPhxLIUemAtlOs3+MvRucu7v2nh0I16IPC0e5
   fp9QauPZkjDJ0u2AWPNXUDR72P4dv80S1uAm75IDFWFRganK8q1c+mUVk
   F5BfHOTbTG9L6tOWfwRq2fjWtuPTy/skHCaoTRYbmjkG3mYKzfKtN9FLr
   dgCxTxm4AESnZnBdcjiTIG1n5IX+whewcTtQFq5jKFrRkcO8XAwzm71tb
   g==;
X-CSE-ConnectionGUID: pHitS6YMQiuIENTNEpmuYQ==
X-CSE-MsgGUID: H4J/UBQWS/2SPZmFHfVVzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37189701"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37189701"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:08:28 -0800
X-CSE-ConnectionGUID: Pb7l1vZsSS6VNyrPlPC/HQ==
X-CSE-MsgGUID: UaqL0g84RNOy5i8LZXwNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104438944"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:08:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:08:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:08:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz0QY2X2i9Wcd7SV5EdEzXGKrE8bKyXPK+R5vd/aI7ANumFGeikY9Hnwzxj/I3C7W7AiPFgufz9j63QVKVHM93Bqk3S+9P3zdJNpPf421H6rTWxpFPUeWKLYvrRtr8i96PyS8AP18Vt+tgDGwKPfaoqsAI7suTk+Murq5ayFefs66W5tV0mpMHAWV0yc5PdrT73/LwSjZ0y0Hjgj9hC4CNnNhaNpBuIDvGeN8q5F80BpIe3J1cocG3+2vULL/GKHv7kdYD2Ca9w4zCZL4dXK/shPSZi5oveLsMZAYtBJLKzdbeH7JRqBc9cWY6MqluF4+psLoSWb6AYF9DS2JoSF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ZxBM0pm0K/N2YDtJOBcfJmt7GFA1Vq9Ejqhdxb+Xg=;
 b=FmvOkSNBYXqEN40BxuRXo6693Nlfa5pqZ1vZzF8NYAOT2AzlPEbIdorjxeX+c8P5J5tf/QaBq/hEfoJPE4v67CMoWY0bfLz8XF2C/jnx3iLct+zF5BTTViEjNp2gI83s8k93ivXffxRyBIpxcEVEtrtpb38YLaZUdC3mtn1NJR1HeEO5f33FrZx5TOUGnggP9HJO6sls3MzbF6iNRPuz/FP8Ss7z6RLDFmIij3oYFqT63gaT+TkIfKzhTTj0a1JrwEzHujn+IIz3xccJNwU5IzyhAMcCCXmjnkrfSgjFKV4UyxMUqWGJZ6+tUB2EVANMGPo3a0U0Vs0lrvafNCDvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5763.namprd11.prod.outlook.com (2603:10b6:303:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:08:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:08:25 +0000
Message-ID: <729dfd39-cb1f-4067-bf61-a3d1ca0b70e3@intel.com>
Date: Mon, 13 Jan 2025 11:08:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/8] net/mlx5e: Rely on reqid in IPsec tunnel mode
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-8-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-8-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd31863-d575-4184-965f-08dd3405a79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek8vUGRvakpNOFVuN0hKZ0FyOHFnbnpmMTNPTWFzL2NSVFpHZlZ0UGZkM3B5?=
 =?utf-8?B?azZBK2ExcUg5ekhyZkZHa3NmUjhsOE90VGo4YWt6dlFKUjBZSmVnR1ZuRXJO?=
 =?utf-8?B?emROTkJxWEJLSEhjYWUyQVNON1NQUythVkRrcmlPUVl5MjE5MUc0L0pFUjhS?=
 =?utf-8?B?R1FZL2RVcGpBZGpXcEd2QmhBRnlPNkV3akxRZ3pySUM4aU9iSDY0SGZiS2ZB?=
 =?utf-8?B?U2JCKzRnMSt0b0NKZVdSdS9INEgzc244L1I4bnZwQm16WjVEZVpwOC9iTzFo?=
 =?utf-8?B?YW9OTUZyeW5VTmEvdG5nMWxZbXVrOEc4RlY5NENvTUI2dmFCU2xHUG9lMzRj?=
 =?utf-8?B?cjVDTTd6NDd0a1c5c3dWWE93RktYSytrV0hJdU5Ud1BMTEFLazgvV3ZjTTlM?=
 =?utf-8?B?THRqZ3dhSGxiOXFiLzVFUFo1eXZjSWZaZjI3bFFHQjBMcjlzSXVINkVmWFI3?=
 =?utf-8?B?T1BTLzNKanIyekJpNnNaU1RSQUhFam52OFY0WEZ1NzFtcjVwbHJ5b1NhdWRl?=
 =?utf-8?B?emhvN3d5R0NKeGxkT0tDMDlKeUtWTEE3Q3JYVmJsNTd2cmYvZmt6anRPdTRR?=
 =?utf-8?B?WXJxT3JVUUEzUG8xNnZaSFFITmhnL3l4a3ZaU2dTRWViZnpGaS9oenZnNDFr?=
 =?utf-8?B?d0M5b3Q1Y1JkeS9ZNHRsSHlsaW83cnd0eWs2SXorMTdCeFh6dTJLVTZrdWQ0?=
 =?utf-8?B?N2doZXliZXJYNWE3ZzJWUmVDbElsekdFKzhGYmFFNVVxS1hUV3FMaGV6amxv?=
 =?utf-8?B?cnJzc0ZXOTNoc0ZINjRUVHJ5dVBNWDJaOXdzcC9pbWFvdElUMURLdTVUM1NF?=
 =?utf-8?B?WWtGYU45Ykdsa0dkSTd1c0FYZnhvTGREazFhYUlCa0NFYkhpKy95Q3M1ek5C?=
 =?utf-8?B?NHRTaWRhS2JhNklmNXhudUdaa2ZEUkZoTk52S2FTZHNmeFlZSC80SklhY3E3?=
 =?utf-8?B?dXdiejRXak5FUVhGaUJETDFUdmFUMkVIbFlqVGVFeExIeDA4ZVJSSHZZWWFS?=
 =?utf-8?B?U0dhcXRQWVBDNDBFL2E4YzVNSzdLMDlSNWF3ekpaTXpZc2JLdERsMmlBRHFp?=
 =?utf-8?B?ZWdHaS9Qdllhck9BK1EwcW1iRlA1OTdUcmVXdVNUWDNjSEVYTTBUbWZpVzFP?=
 =?utf-8?B?UjdGeFJaeDRoUWl1eDZ3cFdZWnl6QkxhQ0w3ekx0QkFEeUt3RjA4amt5dit6?=
 =?utf-8?B?SlBhWmV0V3FIdXNKbHVFcjFtd0JsL2ZIQzJ4SE54MEVWTkFjYzRpT0dieGox?=
 =?utf-8?B?RnppLytua3ZLZ3JIYUdYOXFuekRCbkthZWlXYXZmVEtNSmNjb04yY1V2V21m?=
 =?utf-8?B?UHg3RUNDN014VmxHUnhWeFhYMGtYcmR1MU9LUmlkWkpHdVZ3Uld1T2JYdFp4?=
 =?utf-8?B?YVRyMW1KNVdGaUswM1JEYmJSaXFmTCs2TzI4TzM5bWxzZis1WXVld0dKVyta?=
 =?utf-8?B?NENjb2NqMVdVbHZTMFRxL3V2S01USnFrT2FBaG0ybDZPTE9hRFRZVGRQeldj?=
 =?utf-8?B?OTRDelhleWtSdkZaMWNnK05pWDRrYWM0TVNBaWVOZkNZcXAyemRrd1IzandL?=
 =?utf-8?B?T2VzRVJGOXdYS242MEFjTHNHRXl0ZVpGV1NuWDZjRnh0c2hTWUJIMG8yRktR?=
 =?utf-8?B?ZjlVdHBLNGErc0VVa1U0aGpRaERqWDNhQjE2aERlUDFRcWZEOEc3ZlZiZzd2?=
 =?utf-8?B?N0VQOWJYZVUzWUVZMlpjOXRsRUJDa0lWaUwvem1zSk5OSGo0M0VyN1phanBz?=
 =?utf-8?B?cGJRK1l6S3lHWVdxUmhTdjVZdHlpd3BiU1czVHVJdlVObUhmYm1Ha3lPK2ZE?=
 =?utf-8?B?cURzYWQ5c1E1bE8yZmVFeU5QTStEMVRVRFRQK0tKWlRxMEZ2RkhxZHdCTFdS?=
 =?utf-8?Q?sYnB6ajiSA1Mr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJLait2VGZuaVZyYWd4N0N4bVRsK0pRaTNzM3ZCeUR1cEh4ZUdzdTlXT3Jj?=
 =?utf-8?B?TDF6NHdNOWpvR0hLZ1hQMGhGbytOWGREY0haNEI5aGNlSWZCZlQ4a3paZVlU?=
 =?utf-8?B?S2RmVzVmZDNXK3N6WkpJVFc2RU9qQzI2Z1RZM1dlNnM2VlJzTFUxdGtnWm9p?=
 =?utf-8?B?eHFqc0Zocmk4VUVxZnNSYmRDRkw3N2VWcTkwNVYxOTlwRVNvK0ZmTmFxNThs?=
 =?utf-8?B?ZFBHbHVrQXRPZFd2N1VnR0o1NlpvVy9yQlhDeEhPN1Z3OWFXM3d0M2ZHWFlB?=
 =?utf-8?B?clhWbFRNSThGdElvQnRjVzhhWFg2cnpOSlVKVUxNMU5XS1pneGtDelZZbFZ4?=
 =?utf-8?B?OXNGeWdXeFA3eWJTM1F4ZXBvNkUwdDVSQXp1cU96QlBMYWlpOWJnZDhtU1FC?=
 =?utf-8?B?MTlmNjU1WGhWOXJaOXNXMXlDVUNJTWF2NE8zM2FSQldhQlFoMkx3QmFhZDRN?=
 =?utf-8?B?ZGkvc1VJci9NVWFLTEsrbXNWcEVucnk0U014VWRLaFhTQlpOZms0ZmJBbDU3?=
 =?utf-8?B?K2VZSXlMOVB4OHVsZmRZU2h5R2VSM01FaGNXM0tocU0xSVBVK29SSS9zeWZT?=
 =?utf-8?B?TWFTcXlRZkhXZ0VVYXMzbmFodUdCQkpHRVRhSFBpU1ZxRVBGbzZxdEY0Smo0?=
 =?utf-8?B?UEhvRkdwajlJRFdXeWM1bWpMS29ZOVNnZW9SVndZeHpEWkRDK0JrZWFyU2Mz?=
 =?utf-8?B?ZmpVWU9rRFBIbVpqZW1obzNKVGpIbTZocjJLVkJHUlVGTWtITjlvR0F1cmgx?=
 =?utf-8?B?K0tQQlkxT2ZOOWNmOGhleUlQRW54RlpwMUtRN1JIZVJKQmNpK05CVWpJbGdm?=
 =?utf-8?B?RUI2eWdxY2tBMUFuaG5WczRBVmk0QzA3Qk9OQU1jZUtGV3lqLzhnM1VnQm9N?=
 =?utf-8?B?SDBmWmVUZFdwckpSQ2MzaWhmZGFYWXZnRWcvZ3drSWxhSjUzQ3NPb0xqMDdE?=
 =?utf-8?B?N3dmR3E3ZTBPYjlZVGNjRmwydHhFUURtSDhndklPZmlYRnQwSitpeEJjQUtW?=
 =?utf-8?B?cUdRUUU0Q2lMMVliRERYRk1wLzI5bVIyZE1QWmNJRzhrTUQxMTRXU2Nkcmdn?=
 =?utf-8?B?Qm1MejRabGpNdzhKTVBYQzlVUEV5SzJQYkd4MkZMY3EvbmFrM1pqbEx3ekE2?=
 =?utf-8?B?S01La0tBTVR2anFsYVN3aS9wQ2xlNFhqeks4WEJkdFhxY0dESHBFVmo1NDRP?=
 =?utf-8?B?MllEUWF5dHFzSE4xQ011Sjg5bkhJekpKOS9ueFA5b25wU2Fvd3JmT1BSVUNa?=
 =?utf-8?B?KzR0UjZ3cWpUempndnFLbXRYOFhYSHUxZ05DZEIyUE5rajVzWkV6ZkxSRXFY?=
 =?utf-8?B?OTMxZyt1cWdXLzljZ3pyOUQ3R3FpckhXMndFYk52elBRWXBLMTJuYTJPeUlt?=
 =?utf-8?B?c1NtUDgzU1VRVjVtbXE3eE0zcUNtOU9zWVRaL284OW9YK3lyMjZudHVLSUQ3?=
 =?utf-8?B?RmhmL29ZSWxrWENjYUdoMXNqdXJtUWlhQXVKMjd2cjhQSEFCSGJzMTFDNUQ3?=
 =?utf-8?B?dWlRZ0hTZnQyS2QzVGprTDZEY3h1bk01SDNJd2s5aDloTHFtYS9BUWtaUXlE?=
 =?utf-8?B?Nk54Rzh4U3ZVc2NFT1NKclVOb3ZtK2dKdXJOUWY2TExWR0VSeHhaVEd6VjBE?=
 =?utf-8?B?Z2pSTm9jdjFwNTRhUUl1cGs3Y05QWkhIcERVL3hKWVhwQlJ2NndNb0RTZnh1?=
 =?utf-8?B?QUczK2s4QkYySDdLRUtVMEpPTDBLVXkrZGwyQUVyQnhZYUtlZEdxRkdnUXNN?=
 =?utf-8?B?NGF4eTk4Y0VvRmp3eFpkWXZ2aXFKV0VzaFlBcVFvVW5YaWVnd0Rndk40Tzdm?=
 =?utf-8?B?eFBnQis1c0YwN24vdE5WcXR5RW9WVHdGbG5XTjRYcFg3MTBleG9JMWpQcGRy?=
 =?utf-8?B?Qnp0MHUzTzdYL3hkaXhvQXhZeFExdVh6aEFjSHY2THpKTEtyUUZaRFMxQ3Q1?=
 =?utf-8?B?S2YyN3R1MnZ6eEJlbjFCbEJ1OE43NUxEd3M0UWsvcE13YmY1MjJwYndtNTFi?=
 =?utf-8?B?VXdzSjBOWDhiMU4ydk5WM2FZZnM5emlBVWorWjBTeS9Xa0lHWUJjekRWdm9I?=
 =?utf-8?B?OUI1SWw1WnlrSGptRlIrV1FKZ2V1VjNCVGRHKzl1ZkR5TUh2Ny94dXp2VVRk?=
 =?utf-8?Q?STCB9a6sDbeXBLdAokJR1D5o1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd31863-d575-4184-965f-08dd3405a79d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:08:24.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72a7/yreEqN6a5kc0GJJNiJTHsHfM/Y+4jifZvckmbTPedc/VAOBVmLQMJBe9RXXzUjaMN1RLF4TXr8TB3xSholGdffER32vCvsVHLfcLb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5763
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> All packet offloads SAs have reqid in it to make sure they have
> corresponding policy. While it is not strictly needed for transparent
> mode, it is extremely important in tunnel mode. In that mode, policy and
> SAs have different match criteria.
> 
> Policy catches the whole subnet addresses, and SA catches the tunnel gateways
> addresses. The source address of such tunnel is not known during egress packet
> traversal in flow steering as it is added only after successful encryption.
> 
> As reqid is required for packet offload and it is unique for every SA,
> we can safely rely on it only.
> 
> The output below shows the configured egress policy and SA by strongswan:
> 
> [leonro@vm ~]$ sudo ip x s
> src 192.169.101.2 dst 192.169.101.1
>         proto esp spi 0xc88b7652 reqid 1 mode tunnel
>         replay-window 0 flag af-unspec esn
>         aead rfc4106(gcm(aes)) 0xe406a01083986e14d116488549094710e9c57bc6 128
>         anti-replay esn context:
>          seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x0
>          replay_window 1, bitmap-length 1
>          00000000
>         crypto offload parameters: dev eth2 dir out mode packet
> 
> [leonro@064 ~]$ sudo ip x p
> src 192.170.0.0/16 dst 192.170.0.0/16
>         dir out priority 383615 ptype main
>         tmpl src 192.169.101.2 dst 192.169.101.1
>                 proto esp spi 0xc88b7652 reqid 1 mode tunnel
>         crypto offload parameters: dev eth2 mode packet
> 
> Fixes: b3beba1fb404 ("net/mlx5e: Allow policies with reqid 0, to support IKE policy holes")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

