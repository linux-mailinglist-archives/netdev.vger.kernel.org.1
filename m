Return-Path: <netdev+bounces-189867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF37AB43D0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F309189C6A4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7B25A2C5;
	Mon, 12 May 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYZIyiVL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599322AE45;
	Mon, 12 May 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075341; cv=fail; b=sHYGSQMOFHXVmcBQMkWHzFCK+DHojtPNtmuEIFi+acF0JjeMJRF/kKEav57YyvVUlIQ6gKi6gTaTzZ/07OeVA5mFn+fCWJsErzXLqscolgPhRW8V/pP0k43zPx3+RCQjOzHYe/J2v1HYi9xX/dNsAl1hRS02Gl3u4h8BTrnHRpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075341; c=relaxed/simple;
	bh=JC0/kb4RgoCN6PMluoG0t5/TyJVODUdHDTbhbX/B8W8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbY5dp5V2H1gzT5XMOd2ONknrdRU2QUTWBnJXHX0hx14qsCFGryBLc7bJsUHJrJDwyPotCCAd8SGAhU/HsaqfX0plqkdS//YPDarPnrwcjNg5BT1qAubkmFm0NGRGqgPG6oDcDWWN5vzEBOuio8dJWMGAh3hLcvcSdWHmGPUjeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYZIyiVL; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747075339; x=1778611339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JC0/kb4RgoCN6PMluoG0t5/TyJVODUdHDTbhbX/B8W8=;
  b=hYZIyiVL3cq+vZaieVOgyxyj18hjGEe8qLQD7+VN1ap1hQeY1zWVbuz3
   iGOBZiDPqYm4TDu3NcfXPII3p/P8RDy8TxcmZP3L03AEf1M4z+VCToyNc
   5BFxYJ34gUGZEgvtZFHx6V8Qc0oYkQhrjjJzDsE+5No9+mzECNjIxY327
   qKHifV6olImxERIZUhsMeUtS9UUQ7pOJMTwPHMqPESSTkW+/5uerFDOX7
   MvX7vrphSzspoPBF5FoUy2Hd3hd5RW5O3U74TxNSgNPc6r1Uly2o8+7bD
   i6TN1FeGkAR3V4LzvYsL60fOO1+R2AyzyzPFY+RuhI8ozxM7ZKptQ7KbO
   A==;
X-CSE-ConnectionGUID: AoVIvpk5ThGM77g5/kuY1w==
X-CSE-MsgGUID: xMoHzzgASIm/BLbOpFsgnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48001121"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48001121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:42:18 -0700
X-CSE-ConnectionGUID: dQnY5gzPSFy/F7YIMjI18g==
X-CSE-MsgGUID: 0q45OHeZQwmrH+v9RMGb4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="160720274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 11:42:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 11:42:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 11:42:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 11:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlBCiqIHMbTA0vpHSazxAtz6vL9LILC80RE1S9wWva+pEo92LeT8OdsrqMoB5HedyvlmfBXdm9FzaX5HisfkjR9dLS3KfBX9xLBWkLq+PFiERgfuncqtVcHNoXmALSkRorLaCmFdWK+YD7Hhyq9qsGua3ffHgAT84HaGbalJddq9hEazw4QWcngJPhrTfNusvctK05LCph7OCc+IYGiMUuFlULeyqDBprFUH+FcAKHuMpDNIzKmzeWj6Uf/xVKT5dtjKynD3fh5Hiar1aOfyapRUgpCHADRSNfq6bWJFQbJfvZ/mjkv33unguJTOC34zQ3zZiIOl/X37gY/Fz0/D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ0GXLTW1x9uiAyoA/KUBhR2TWFZO6TiFOK8V7TAN0A=;
 b=sX/TSZmwWkBz9WnqQuQYTNezgbZQhLoNwJpu6K5SeOILdvR7jr6zTeFYAauL6c3Z4HZktsKBS5g6bC2fnsRtQGhusuw3ogOzvAwKMMzCa418dZXt91Z3JPyKGlyS1rGSVKRJ3zyMV7hdyRS3JdhQk5lh7Ojk6pmhUyqhFUqjZHdqQjf7EYpoEbJd6GrF0Tgxkyr5QJaksfOmj5At04ZlCFB7LRiBPhrg8sjEUMbcPNraXANj/wpneWtun+rAPSqB1K0rgAU91nFZxIrOKSSmb+5orbT0JTe4V8l9pzfugR8LtL5KNhX6PAkCg8sD4vLpxCLeMaXqTT4b3joYSaSILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 12 May
 2025 18:42:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 18:42:15 +0000
Message-ID: <7b0df952-9269-4669-bac4-826384316e70@intel.com>
Date: Mon, 12 May 2025 11:42:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/5] pldmfw: Don't require send_package_data
 or send_component_table to be defined
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-2-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250510002851.3247880-2-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b0a8cb-e5c9-417a-9727-08dd9184b752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnBHTzJFZ0ZuV01yazBrVDlvQnczb3RFNHNsUGtIZVpRUjY4MGR4cjV6TmJB?=
 =?utf-8?B?NDVPa2wyamo4S3JzeFRaTGE5bG0vVThsand6aUo5OG1pTHlVemlWbjRZaExs?=
 =?utf-8?B?S0VNZDdQQ3ppV2E5TFE1U0l3ZU1JLzRnQ3lIU2dBcGIva25Kc1hXZFhkR3JY?=
 =?utf-8?B?eXJuS1d4alh3U3FkaTNWSzkzQnJqNzlDdDdEVXMwTXBlSUlGd0d4cDIrQWZT?=
 =?utf-8?B?M1hqMVBxTFpLdmRtY1RQakRwTU9yL2M5Ri8zcGcwcTk4ai80YkZzNEVTQUk5?=
 =?utf-8?B?MDRjN1ZScVFBT09rbTRqT2ZNTDBzNzVjK3VmcDZqOHFka3dhOVZRWXhsZDhh?=
 =?utf-8?B?ZDYvazdud0VUODJSdXpUT2pWR2s2UnhaVHcxa2RVcVdvY2tsS3JRdTFXTysz?=
 =?utf-8?B?QkN1MVFjYW1vZ1BlYkZFT2N0bjJWblZnUWxjNE5qOHFXTi9oREdWTGUzaCsy?=
 =?utf-8?B?QTArdjBXQWQ1N0dwL0ZCRXd6OFZ3VlZVQjJBNGZ4dDVmNm0vNDBVWkxYbUVE?=
 =?utf-8?B?cDVIbTN1bUVaeEVsK2QyMi81d1R2dEl4Q2lEbzBKeDZMRW9acng3eGlvbUxZ?=
 =?utf-8?B?enNDRTRZNEFOQnBMSDFiNDY4YTdCd3BxUEQ5OHhoNFdFQ1M5Tms0TlY0bUtw?=
 =?utf-8?B?SmRmTGJwM0RaNm8vbGFPSHd5QTBkWXdBbG82M3RvakVmb29vcDVqeGFRTUw0?=
 =?utf-8?B?NDE4M2VZMG1nNXhuc2NPb1J3ZFRXU3VKUTJ2RUtJYU1OVGVwZHVnYlRHSUla?=
 =?utf-8?B?SGY4b0Y2bWFDU2dqUEZFV2xmYnM3RXhxaElJbll5QTRKZlpPTnZzNExQMmpF?=
 =?utf-8?B?VFhlV1JLajVVSlN1Z3k0QjJtSDVwWTRuS1RoTWNheGdzSXdtaWkweXc0ck5x?=
 =?utf-8?B?aXlPdzZ1Q2lCREx4eEtLcnJSTkVqSUx6YlRGMWQwSmZLQXpBbzdxczJTMksz?=
 =?utf-8?B?d3g1RDhYN1orZUtwRUtKRC9GakJKS09YaDNkaE5ybk90NHlrcEJTRGc5Snp6?=
 =?utf-8?B?ZGdlT1lTYmpTMGtIV05pVGRxMFllcWYvNjc5YnU2MEk4Y1M0T0M5eGxtL3lG?=
 =?utf-8?B?VkxnSlRPdnhCZlcwNUtjdkNzK05LM0FQUjBaSmFBMm12UDNZVExLUDBaV1Ev?=
 =?utf-8?B?RUg0Skt2eTcva0tVSk0vNDV3QURMc05EZjIrVmZicFpNOTI1aEhLVlpWK0hX?=
 =?utf-8?B?cW9NMDJwN0kvWm5aU3VPS0VndkJMaWZzbnJnY3JIVHFmZCszQ0pDQjJTQTNC?=
 =?utf-8?B?RVVTWUhVS0liWGNyWkZ3Yjd0b2oxVENqaDRYSy9LSkpzcUJWSFJIais2L1B4?=
 =?utf-8?B?T2Y1VmxueFpJVHZZRlprVlpVNFFHQmNSVURLM3d6RGhXUEhrTGZXb0FkcW9D?=
 =?utf-8?B?S09tVkU2VjRYU21yK3pBQ0FWY041bzk1cVArQkd0NEY3aWJuRzdLeDBjNDlm?=
 =?utf-8?B?dkF0UWovZkdTR3hXVjB2ejJiTHBRTmlRNXVvRTRpMW02UW91NDRZN21tZEsx?=
 =?utf-8?B?Tkk2UHBNNVNaMjhqbWp4dG5QWkVUOHlQK3ZUYTM4dmxBWmdGTEVacEVId3hp?=
 =?utf-8?B?dDUxR3JFdk12T21oM3lvMHkvSS9kMXNvdXBLVS90OVEyRDRoK2wwcVBoK1NU?=
 =?utf-8?B?Z3VDMWZZeEJOM2ZuWHpHK3hmU0NzMW5scGlYc2pyUzFYVkoraUxCcGRIUzdU?=
 =?utf-8?B?T3Zac2lLVG1ISE1UR0xHTWEyWEkrVXNnM2tZdStZMXBWZHdaNHBOeEV2WE13?=
 =?utf-8?B?VTU4eFlNZlZUajQ2QnpSYm9OZDFycXdENGFxSG95OEVHTytqWXZyMkl1NitB?=
 =?utf-8?B?U2xTcENWMVo3Z01KUE5CWVgzd09pSVZjWXNsNGY2c0R6MERmZEgzSXJkU2pV?=
 =?utf-8?B?ZTdvRDZkOW5BOEZheERJeDFFWk83eTV3NUF1MDFPVUVaUVBnbHZTMXBjb3Bp?=
 =?utf-8?B?ZUdGazNzZkt3UXUycms1emJSdVpaUmYrdXRta1F5M2h1RUorWW1hSmNXRTIw?=
 =?utf-8?B?YlF6b056YWN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRwbmJUREhxeWltRW15NmxibXhUejR2ek9CMStMeHQ1dmQ0QnNzWnNvdFR2?=
 =?utf-8?B?RWdtNENURU1XSldIcXhGTmE1SmFQd2NqYk1VZE9rMVNyL01IMWtPc2RZU2NO?=
 =?utf-8?B?WW9rSnllRktlRnAzTWdtaWI2TGtTZENvTFJHNU4yemlsWXFPN3lDN2dMR28v?=
 =?utf-8?B?ZWZ5d0pPeHZ0bjRGTWpFZkMwb05vQUdlTzYrOWQwVWpqUzJTcGI0T0xwcWpx?=
 =?utf-8?B?VnY3S3JkYWt6UkEzS3RBUityME8wdHl5V2E2alpGbGlxRm0rajhHMzhwNW9R?=
 =?utf-8?B?VlQyb1B5T0YvcFBpaVRVc0NjWEJjZU5xSjR1eVJTLzVxTm5iM0xQc1VlZGQv?=
 =?utf-8?B?NnpuL3dXN3dITE50cGcvNHVwZWRGOWZNeHBKRTI1TWdXRC81UDhpZmZUZTdW?=
 =?utf-8?B?Vzd4MnhKOFU4cEpmN2ZpWHlNalZ4eU1ENjNlbnEvVlJWaGpQRHcwMjNTQVBu?=
 =?utf-8?B?citpTENzY0hLa1VNNHFPNTZvUXhpd1Q5SUhVWFgxOEp2cDAvYnBxY211OTN0?=
 =?utf-8?B?aDZmd2RId3Z5eXV0ekh1elpxRGRNYW81MjMveFNLQTljOE9MVWRRcXp4VWVx?=
 =?utf-8?B?K043d3l6ZGhMMXRCRDk5eFphWkRsaUhkQ2FUa1VRYStsRkZ0K00wWUpuYUYw?=
 =?utf-8?B?SVhSVk9sVlZIamo4M2szV1NSM2FtVVBIQXVEM0ZIYWV6NldRek1MZjNhYjN2?=
 =?utf-8?B?V3p5R1l4UWNMSXhhSG16VGN2NkZzQWJjYVhhNWhTdlk3ZjYzRTZCN0NsdUhZ?=
 =?utf-8?B?YmZqbjk3UHl3RTRMM3huUnFJMlc5QkZ6YTRnU3V5b2dWWC9mcXpNcUpUbkxK?=
 =?utf-8?B?OGxVczllc3hZWjljMmFlT0ZxL2IxbFE0ejFpUzVOa3JER3lEZnN6Snp6T3o1?=
 =?utf-8?B?Y1kvY3VmdmlkOWNLdzhWRHl2dFEvcWk3TWIwOUpxZm5iNEFtVUtzVUoxQWhP?=
 =?utf-8?B?WU0wR3RPMmtLZlo0NGZDQXpVSGN3MVY1QkExRUJxTXFoM0k1dGs4dy9IQzQ0?=
 =?utf-8?B?dk9lKzMxWCtjbzhScTc4cjNoMkJVRXhYVjljdlQxeGIxL0REd3VVTnRGNjZs?=
 =?utf-8?B?M0hKSGJEQ29lY2h2RzBkdnYrZlp1NFF1clhRa3pwYzYvaUJYajhoclJ3dzMw?=
 =?utf-8?B?U083NGRGRlduSVd2VXAvV3R2TlNmVWNhQzAraHhqcVFlRG1FWEJsN29hWDFS?=
 =?utf-8?B?M0NZZEovbTQwZVFTUlJZdWgzalRRUEx1eEYzcW5mck9Zc1JxcStKN052Z1c0?=
 =?utf-8?B?b0ttMGxHZ0VPd1BqT2c5OUxuWVBsMmhhZW5MYmZZU1d5RVpyMTFJMEdGV2VZ?=
 =?utf-8?B?M3g5eUVRZWNmS2MvWEhMSWEzQ0tRSlJSWWxwWkhySkplYlQvME5HcnFZZ1RU?=
 =?utf-8?B?V3g0UWE5UU5tYXI3TTh2S1FvY202UHJabW8wVndVYmpXQ3RYNTFlNktObGh1?=
 =?utf-8?B?SmxQSzMzTnVVdWRQNk5xN1N5MzBxSG9BQnExR2U3bDdkTXpuTmhuems2NjBG?=
 =?utf-8?B?dFpEMG5qeE9xSHJqMWNmTGFmelhWenhUUmg2WS9XeThMa2xzNHVvVmhMSnJh?=
 =?utf-8?B?ZEwrVUN6Qk13SjlwdGdteGEwVXdrYm1LSjNnbXhUVWwrbzRNRDY4YXBVVjR1?=
 =?utf-8?B?Ykk4OHNBUWJzMFZuTFQwOTJOd3RBemgzNUZoK2NDZHkzU2owMFB3bUNIMWlP?=
 =?utf-8?B?RjlpV29jcVdCN2FMeStySlk5Mm9INzRyUnh5UDN1cnNlbXdPaXZhNG9YMWlz?=
 =?utf-8?B?Ny80bkNCSklDZlBMalRLQTNEcm9NdjR2Q3BmMmZhQkY3d0t0M0pxLzFFRnR6?=
 =?utf-8?B?TWRMaVNUSDIyeDJxU3BJZ1dKVnBhRGxzd2RjMURrWTB5TWZjM1AydmxvcjI4?=
 =?utf-8?B?Y1V4ZnoyUFN1SC9mNE9iWlFlVTBGZFRwMzJNM0pjWjI0WjhTb3BaMlVXUmdi?=
 =?utf-8?B?Q3ozU29QbEpiZXkxdngxN1RCd3JEOHU3M3Jjbk5CT28vZ3N2Q1RBNDR0a2pS?=
 =?utf-8?B?bnhrOFkySGhjanFsM0VyN1lsYkZFUmVpV00wczFvK2FOT3lHU3dOU2lUak5u?=
 =?utf-8?B?NU9SdERSemFpZlhPaTRQeUhnOS9IemtKdHd6MjA1T1d1Uis4RnZkRlAyTStM?=
 =?utf-8?B?WjFpNHJ0OTVwLzR0Yk9MQmVkTGxPNElpdlIxdmdIbXB0NnZBakl4R0N1bFR5?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b0a8cb-e5c9-417a-9727-08dd9184b752
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:42:15.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaQkeRmooAweRFiaFGwNeOzftl3rUaIt75abX0ZNG2rgzCngc+zzYYYT7tGYxPDfyn2ioqiI7bx663AAVkx1+U9IBgz3DPZSEHXTADLltmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-OriginatorOrg: intel.com



On 5/9/2025 5:21 PM, Lee Trager wrote:
> Not all drivers require send_package_data or send_component_table when
> updating firmware. Instead of forcing drivers to implement a stub allow
> these functions to go undefined.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Makes sense.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  lib/pldmfw/pldmfw.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
> index 6264e2013f25..b45ceb725780 100644
> --- a/lib/pldmfw/pldmfw.c
> +++ b/lib/pldmfw/pldmfw.c
> @@ -728,6 +728,9 @@ pldm_send_package_data(struct pldmfw_priv *data)
>  	struct pldmfw_record *record = data->matching_record;
>  	const struct pldmfw_ops *ops = data->context->ops;
> 
> +	if (!ops->send_package_data)
> +		return 0;
> +
>  	return ops->send_package_data(data->context, record->package_data,
>  				      record->package_data_len);
>  }
> @@ -755,6 +758,9 @@ pldm_send_component_tables(struct pldmfw_priv *data)
>  		if (!test_bit(index, bitmap))
>  			continue;
> 
> +		if (!data->context->ops->send_component_table)
> +			continue;
> +
>  		/* determine whether this is the start, middle, end, or both
>  		 * the start and end of the component tables
>  		 */
> --
> 2.47.1


