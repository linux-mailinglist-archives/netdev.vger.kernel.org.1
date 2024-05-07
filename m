Return-Path: <netdev+bounces-94119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7248BE342
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D7428523C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FD15E204;
	Tue,  7 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1eJWOeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98115DBC0;
	Tue,  7 May 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087611; cv=fail; b=Wmc2pRJ8tnmgDZiq4nRhyEip8bDCuQdqrjANyw7RpdnMdybqiM93/zKt4ieccPR3q2SfsVjQ6cMyNLGHi4jozdHesPCZPmgPjzFL0BlYuiCRr3KxHfLM6wp53N8D19bR65evx/jmvNjgOqbZFrvxuwtMOA4lomJgvsXtWXXOkzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087611; c=relaxed/simple;
	bh=aAUMwA42omV3y90MX/nVNIwiYdqLG6YeGDf1TDL7EYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4rH7Qa/bZwVvKGcHF1OY0YutjdlolBeZGVtaYmGhAFpbZeBubCUK2OR0Y7slXt1LtfF9XqoTpXVgaJbWqgJFdKPLrkhjCHLbXx5EXO/COR2i6VfS1DyT/YhZ2yxFoZfEyrENlTr484DfkCRBjiWtdO/Eo6umxy1UryYmlWKJkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1eJWOeZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715087609; x=1746623609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aAUMwA42omV3y90MX/nVNIwiYdqLG6YeGDf1TDL7EYQ=;
  b=W1eJWOeZhSEYsIOe3v1i/Le8Fc1e/901mNToYrFcvNHhjX31nvnfGs6r
   vi3IWoZSM7e7IFjX0xiKwFzYMhWA9zgPOQE2GdYL4fmnz/PXofBxRjgj6
   72t47ocWPeDdwCF9iJYbnCM5s+EZUo+VELRsusioMzjkp+JswHZiOk5OF
   A/+c+EI9vsdWFf2LqXJ6dszIG0Wr12sYylEdYyYIKf04DHImSsGpuHpeL
   gTYvA4itElFoOp0RJBOagSGqRrr+1AGfozqSF78MfseA7wAZjarCjDwVd
   Bx++WIcuEuIPYIsNufCCVOsphI7Ep5+LaE0unZPnhXROXGKcPIKrQDH0n
   g==;
X-CSE-ConnectionGUID: ta70yotJSpC7lyZirDwI+A==
X-CSE-MsgGUID: gI1pQbgOTje9xKYAzUXVVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10747422"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="10747422"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:13:28 -0700
X-CSE-ConnectionGUID: FvOwHX1oRFGwVsLh+PpsBQ==
X-CSE-MsgGUID: 7WXR+wIlTCCCYvDrQnD/Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="29040072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 06:13:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:13:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 06:13:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 06:13:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 06:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pce9WexaUoj+6xDVKw24Z63aCIez0O/fM60NsM/Zip5/SmLnBG+kvCeKUoZdd8D0YPXdDWCkv3/HrepRUpL0IBWuzDDwmjgYPgrno0D9lKqpK9tmQzoADrfw2WGn6T2dcm0QegUdGNf74BG2c6X50tEo2eDXgkTZUwpeMyMfI+NRod//ng7p3muwi7IiXnmbpBi5B58sfLCsY4oI6m9hY3pviRa4F7kqxcsMlhI8sejA966hbwv5RwjR87fvE4To6KdmHNqRr4PPcfTiLO9VkrIpasFokZR1yk75/Da3ZB9bHDIKtdeXk0K734Ybs7ZgFKqNpP8KIWxl/2keZZJhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx6A/LZkBqVG7LGjaaGZNG/HE3R9ueKrvG1ZrMGD938=;
 b=b03Hxi5HQaGo17iZoSvwoRQQ0vP4FNRIpE4pdib/Wpsed9DTxJ/OLiofS3HP9J6ax4YuzgKGuq6SQ0GGnqs0A+N72YMLKM/Ky5ZHSkGOfX1UfBNVypgH7y+oSx5KjXh2srRZ9lEP4JBVQHlMF0ck/WLDoi+UKwl+ROeDA2SvS6/hoRhLWhEw8XfpYD8HHDsWSX4SiscqLNf93LpxZJGX0LCy3vG+t7yjEINf8QEhH9OCRV11sKgzWxviDb2l5T1WjYc4504gLs6KdIjpusNklfo7CCP96hXt3KtfTw/MUrCnR8Hs1NXJt9INKXpJdNNycV7wfHrALYtjDg7ieL/BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 13:13:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:13:24 +0000
Message-ID: <dfc2d0b4-3ff4-424f-8bdd-3e9bdedba914@intel.com>
Date: Tue, 7 May 2024 15:13:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] lib: Allow for the DIM library to be modular
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <jgg@nvidia.com>,
	<leonro@nvidia.com>, <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Tal Gilboa <talgi@nvidia.com>, "open
 list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
References: <20240506175040.410446-1-florian.fainelli@broadcom.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240506175040.410446-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfd3bf6-e178-4018-e70d-08dc6e9779fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZyd2tjdW5nOTV3Q0hYdDN0UWh6WEZvZ2IzWEdwb0d1c2d5cWkxMjZGV0M3?=
 =?utf-8?B?TGNUL09BMGRCdGFPZ0MxTFFUVXJkbUQwS1VyRUZGd25KVnBLZDlTakRaZFNx?=
 =?utf-8?B?dTRZbmhvaEFPMDVjcktKUVRCa0tFQVBRcXQ0emFaeldST0gwdEt5WEEyWkkr?=
 =?utf-8?B?TGErOXFnWEhhUTcvTGY1WHkrRUpDZ3Q1MXVxT2RGMlRad1lPWElkSTUrSlBR?=
 =?utf-8?B?Q1hkTlhLVE1JMkI2ZS83V2Zwc0pFSDRVMHZ1eU55V2V5bGJ3WlU2WGZNd0Q5?=
 =?utf-8?B?eWxPdFBld2MyT05DRHh2M2JtcEczZVJjSWE2ay9YZTNDVzVUNTB3dWIwN0VH?=
 =?utf-8?B?QkhhcTJGQ0hQUFcrNDlzUThqb1VwUFBYa3VBSHBGT3lLM0p4L1REQ1h6V1Ro?=
 =?utf-8?B?RE9mWndvc2tLa01SQlB1TUVSeWx4TkFGTEZDSlZPbkJGSWN6L3NvMGpPYWU3?=
 =?utf-8?B?OWtKYjNPTnJBN3lXUktlRUtCYXgraGZwRXhzU01ZY0oxZFVSeEUvOGs0Z3hB?=
 =?utf-8?B?bUhDcm1WWi80RytmYU1ZUU51SE1DeTU0UmFyY0wxK1lkS1F6OHZ5RXZ3QjB6?=
 =?utf-8?B?NkhQOHNNeEMvL25zWEJBWVRJQ0VGbkVMdFNxbkswQlBRSUpaeUs2L0tXdml6?=
 =?utf-8?B?N0QzTXhMY2RnUjlVVGROTVQ5UHNUZ0hBZFBNcldqSEJEUXdSUmtSVlg2N0lD?=
 =?utf-8?B?Ymg5Y1V5MVVpVzBFcGVzUFF1N1YwbXBHVTgza0pSeE50MkI0bTVWQW0zcTJE?=
 =?utf-8?B?SzhyUFNtbmhCUEEybVRndEhoR0tFTXNkY0NpRlYrUEdCeDZTTUVOeDAzS2d3?=
 =?utf-8?B?VG9NTEw1R2NvNloyWk42OGdrejlsNnBhekJGbDRET1BpeGtTWHR3Z2dmTzhW?=
 =?utf-8?B?TWFISzJ1QVBCS3RYdWxUd3ZIaktWYVF1MzNrR0NUK0Y1djZUbGhZVE1yaFMv?=
 =?utf-8?B?dWxocU9xdUs5ODBUcVM2aU1BN3RWM0duNzBrQnlRZHBXY1g0WjRZdVhxUVRs?=
 =?utf-8?B?S3FCZ25QSEp1SEQyTnpHalU3VitVck1oSTdhT2FjbGJMR0R1MnF2bzJPQkMz?=
 =?utf-8?B?dk0yaE9RNnphdUhhd0xaenRnSVpyVmF2ajV5MEs5SC9OUGw3VWxnSEVhZFJP?=
 =?utf-8?B?VDUrcVdIQXVwRGdrc05Dc2VHbktMRXdBZzh0ODF4QWc5Q09pRzlXR0IxN0Vk?=
 =?utf-8?B?VWRJc1ZDWDFHdE5SU3B6Mlc4ckluQ29OczRQc2QrTDhEam83RVQzRE5vUk0v?=
 =?utf-8?B?c01XSVZyZ3hhdmtyR1pGZnBoS3RPZG11dU1xS1dDbTVVL0hueHVzazZUMVRy?=
 =?utf-8?B?QlR3MWtDL1VoY3E5aS9ESVlXODE5ZUNkMktDd1pFUEdWMUVlV1EzUWwvSVpH?=
 =?utf-8?B?VHQrcWJXbEdrYmNwTCs3R2kvVVVjb1lXWXcxcEp6SUdyZHluZFBsT1hlT2dp?=
 =?utf-8?B?ek1PSE5lbktpWnI1VHBIWXE5NFpObjlDS1F6Uk55YkxuNFhmeFM3RTdhL2RG?=
 =?utf-8?B?TGJBVWhYcjBCZVlwc09aSm1KSnJOcUpXK2J0blphV2tnUUU3VWNVMWFMY3k3?=
 =?utf-8?B?aWRFZ2ZDY0lUY2I4QnY1dURseUsrcm1KRXNSbE5hNkg1V1ozVUdGSnRRL1cz?=
 =?utf-8?B?bFpCRmJPcXlDQ0d0UXhtNFhhNU1xdzYvdVBtUGZSajZnM2o0TGVFL0VEVUM0?=
 =?utf-8?B?L3o3QURLbEtwWllmcnJhY3pWTFY1Z3ZmU2x2ZkhNU2NXTTZja2sxOVhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUk1T1A3ejJZdkc0WXJPcHhjaGo0Zk1kaEFzQSt6VndiOXNOd210cTFrU2g1?=
 =?utf-8?B?d0NYREJqd2pKNW5vOUVsT2xqZ1Jjb3FMbXpGN1V2WmRHMjYrWGhSYkhQblFq?=
 =?utf-8?B?U1lwdXZxb1dlRmxDbmxBSUx0TTcvM2VHN2plN1BJaDNRc0JwVWFURU53bWlE?=
 =?utf-8?B?Y0JRamtzUHREaTh4cmovK09relZSR2pCVC8rY3lTeE9LdkJ4bE94SzNGaWE4?=
 =?utf-8?B?UHMzbFc0T3FudnFzUTB6K1ZXS1FVYjd0OENlYkRCaVd3UGlkZnBuTk1nYTY3?=
 =?utf-8?B?cXlyY2RoVWNBOTd5cEJYL2hMR1R5NVM5a1NsYm5BUzVoQ2NiejUwU3cwSWxB?=
 =?utf-8?B?T1NvdlBuNHFET0ZyUUwwMm9ORUdZUHlITU5FU0FMZlRPekppRCtSK2Izd2hN?=
 =?utf-8?B?RU9BZERVM1pYRWdtOTJDMEVLUUxJQ3ZNM3g4VTkvVUc5cFZPa1lyQVdyUmRG?=
 =?utf-8?B?NldnMi8reTY3NWxGR01MV1JMMERkZUhrS0F3bzJ5eWVXNUQ4TnpIbXVxSm1y?=
 =?utf-8?B?MW5sTGhYNjhCOUhvamVXTFVRWXJQN2JsaGNPU2N5K3IzZTBTcG0rK0JvYzZ0?=
 =?utf-8?B?TEtaY0pLd1JjYmtMSFROcUlqRHhOSFhKY2ZobWRMWWpvd2ZOaDlQYVNQNFBx?=
 =?utf-8?B?eFdHY0E1NW82dHNKd3Rkalp4SGk0d2FTODE4dndCdlZzUjdVYXFnYkp6QTlB?=
 =?utf-8?B?WktNcW9ES2R2eHJxR2VNdjVadVRzN2o1Nk4yUFJTcTZseVVXaENLNkNWNUVn?=
 =?utf-8?B?bE45akpzNzBUNUJkRlJaNGpJa1JkTjRIYlc5TUNGUW9TTEdmQVk3ZEROYUcx?=
 =?utf-8?B?M2lXUmUzOE1iZXlVMXVUZGhna25RTU02NklRQVpUTmF1MnIwWWlQWFhJRVEv?=
 =?utf-8?B?ZTVuWUpPU0JOa3NFT0hqaFJ3Umo0K1FQbUpMRzhXeS9VUytheUVUaEcvRW9W?=
 =?utf-8?B?WExtRTUrdFVaaXJBZ0d3Y3hmcUZjOGMyWDVDQTIvbUpSR21qN3ZFZ1NJeWN2?=
 =?utf-8?B?SjJEZ25MajE4MEJPbnR4MTdJaVdJVDRNaTZvemVmTWVLclFJQk9nSU1aYS9K?=
 =?utf-8?B?MWJMc3JNRi93U0lVcnlMN3REb1VNRXk2MTljcGRVeStESkdCTTJSZXdUYm9z?=
 =?utf-8?B?YlZSbGRRZzVVRE9vZmJPTkVwTVlIcW1QTldsNzdtYnorZ3loQ3NOWnNYV2RK?=
 =?utf-8?B?QzVFeTgzbDI5ZmxvWk1zQWp6MHBsVnFzaUNJUk01VzN1dVhuNHNkbStlVmtI?=
 =?utf-8?B?UDJyQjJNQmFQZmpTQ3V5QVN5RlYzQ1pDem5TRUhxdGhXVkRDa0N3UDMxcTJW?=
 =?utf-8?B?UERPdDVOMlptcnVkZ3h1Q0RLREdOM3BwL2duVFlKWUVFOTdBYTRNdDVDQXp0?=
 =?utf-8?B?Z3l3T0lvNTVBNTN2NFVwd09KV2svV0RXM0tJUWd6eWRwemRhTmZyQ1kzbEpT?=
 =?utf-8?B?OWhXVlg3a2NyVXRwWUdweVU3VCtSVXJXT0JldHJaSEVOaDl6SVJIejZJY2Fp?=
 =?utf-8?B?a1dYYzI0Tkh4bGI4dWRMdDNZYXpPeU5VQnNlOUdCK2tXTE9hYTlYS1RpMUk2?=
 =?utf-8?B?TmFMOC9ER1Jwa0VXK2ZYUU92WDVqbW9ES0lpcmJ5YUVreEFDNmNsOTJGTnV0?=
 =?utf-8?B?NFFDTGZGSlh6ak1GYURTS1RXaTJab0lUTXo3RGpuS0pzbUZMQmhTT213bmwx?=
 =?utf-8?B?WFNaYnNrSzJyS1c3eVUwcFpYei9jU0hIU2E1THBXMTh5VVJyWFlSWERmQWN4?=
 =?utf-8?B?M2wxOU1RUEF4enRiMVlDcGZURDRIWUtTN1ZMM0x1TFVLVy9rT1laOStZa1RK?=
 =?utf-8?B?cm9sb1VnQUNUWU1qRDZkcDdQdVAzeG4zZExsVHZHZGlaeXhkdDg4TnFVN29V?=
 =?utf-8?B?Q0R4NXQ2QlZWdHZyK2twdUVlak1KN1VlR3B1M0YrdGNXRE5rYllLM1RGemRC?=
 =?utf-8?B?YjByM3NMMkVKaHkwZXFabzNLT2RscFFWRnVQaU50NzhReEtCTG5HdFp6TkRv?=
 =?utf-8?B?NkQ0VVlVeE1TbEk5eWlMeWhOY0ZQcXJsRjdQdkE5ckpoZXkyRjhPQVdLdDFr?=
 =?utf-8?B?a3RGcHNLaTBRR0x0TnRscjVrdnVVU01DR3V4aTFiMHdQbS9xbDZHaTR5Tzlq?=
 =?utf-8?B?WVkrSlFySGZjRU1jSFFDdUtFejU0ZkhYOEhWN2J2MzVsMlhoK043M3ZIRDN1?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd3bf6-e178-4018-e70d-08dc6e9779fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 13:13:24.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7mDkP7hsZQnxpOMPzrgvnMgfxTLiB4l2Pr40fyiQL/m4I+uBQWXKY3lDj2TXLY5aA4qKLDRc1qzCcatooNlXyOtTkAPzKMZSQTuEMVSTIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Mon,  6 May 2024 10:50:40 -0700

> Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
> module. This is particularly useful in an Android GKI (Google Kernel
> Image) configuration where everything is built as a module, including
> Ethernet controller drivers. Having to build DIMLIB into the kernel
> image with potentially no user is wasteful.

Some bloat-o-meter -c vmlinux.{before,after} would be good to have here.
The library is small, but I personally would like to see it modular.

> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Changes in v2:
> 
> - Added MODULE_DESCRIPTION()
> 
>  lib/Kconfig      | 2 +-
>  lib/dim/Makefile | 4 ++--
>  lib/dim/dim.c    | 3 +++
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4557bb8a5256..d33a268bc256 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -628,7 +628,7 @@ config SIGNATURE
>  	  Implementation is done using GnuPG MPI library
>  
>  config DIMLIB
> -	bool
> +	tristate
>  	help
>  	  Dynamic Interrupt Moderation library.
>  	  Implements an algorithm for dynamically changing CQ moderation values
> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> index 1d6858a108cb..c4cc4026c451 100644
> --- a/lib/dim/Makefile
> +++ b/lib/dim/Makefile
> @@ -2,6 +2,6 @@
>  # DIM Dynamic Interrupt Moderation library
>  #
>  
> -obj-$(CONFIG_DIMLIB) += dim.o
> +obj-$(CONFIG_DIMLIB) += dimlib.o

I guess you renamed it due to that there's already a module named 'dim'?

>  
> -dim-y := dim.o net_dim.o rdma_dim.o
> +dimlib-objs := dim.o net_dim.o rdma_dim.o
> diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> index e89aaf07bde5..83b65ac74d73 100644
> --- a/lib/dim/dim.c
> +++ b/lib/dim/dim.c
> @@ -82,3 +82,6 @@ bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
>  	return true;
>  }
>  EXPORT_SYMBOL(dim_calc_stats);
> +
> +MODULE_DESCRIPTION("Dynamic Interrupt Moderation (DIM) library");
> +MODULE_LICENSE("Dual BSD/GPL");

Thanks,
Olek

