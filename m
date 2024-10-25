Return-Path: <netdev+bounces-139150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F049B0708
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AB1F232B3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD616A94A;
	Fri, 25 Oct 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cq2dz5pQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B08290F
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868517; cv=fail; b=agF7YsCYII0f1DJKYQzN/x1iMs69ljhkmUqbESecuTtwSha6/s7BZ5dFZisYJLWHn7QGrMRW6nFZ1461d8roGTn37wmjfekavc1K5RlmGP31CoIilwkbjCjlbVJ4vfnpr1iqyjqgJ9++BytzxWihUHkNkWnGUlB7QbIsmtN7cFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868517; c=relaxed/simple;
	bh=DkmrjvVtJMd573CigIhU3Y12Qgl9g5jvBLZLAX4FEYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvZUgqFqUWeZ8S1BiR43DE5IMpSmZiKKHPg3SFKVx8FRB/ZFFz/A1mYFqYDLhaUtQqa7rRHaSqF8tnyDcG7StWxkGuep2Fq2/o7XhDfIe9/LUg4AKSiCA2ir2eDKNjEtCRiDJwrR73cNNnzq5AvG6orHvVadvDP5TiOVJzyvMJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cq2dz5pQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868515; x=1761404515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkmrjvVtJMd573CigIhU3Y12Qgl9g5jvBLZLAX4FEYo=;
  b=Cq2dz5pQXEZARYPxixyyQEkNMN7wblF9ZeFN/gqGufaymaG49ajxQfMC
   RIAElwwSelR+p4yroE14T/7VAHkNUmSfyiz1jjfXrMUJLA+7T/91XE3wH
   IWcHcUQL0Gj1XyTpMDTrGn5/K7wENESjxD8a3YytiBgW2+nX2kL1LrXVP
   KRMXXKm5s+bhE2/H+E4kWNOdQBV0B5O7hZhEs53YlP76GE8vlJLTIPcfp
   K1Ccko85dTai7lAGsxETmS+C5Zv7GRietWH6ZeltzPcWTbcmEydbywLup
   VXTgmqD5paGw82mLvv/pTNh7+miR03ngPxqpYc8AdUy7iMxRcaUctAKNV
   Q==;
X-CSE-ConnectionGUID: WzZ1anP2RmqtOkhvvFD+kA==
X-CSE-MsgGUID: NLfa82UhSu6y2o46WtZpRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="17171626"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="17171626"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:00:52 -0700
X-CSE-ConnectionGUID: FnfZ0YL1Tr+2KQ32knZ+pw==
X-CSE-MsgGUID: 7lGTbKloQsatL35yMZj7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85487007"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:00:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:00:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:00:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5gl6256BarpP/iVFEAGm3uRuSOnNzzFV0npQ2n1NVolSjwX04KoOL71Kt1BMtbvJldTGjK9BcA8e+uSyYKJgJdwqX6cLJwiWgb3fag36Z7+gKyncpYI46M4fP3BAsGVvEmBynPsBO2N7aEeR8J15GEhuO/b1BlLd8Wu76ArPoIDbNqdUrDALRZd8dPx+stBb64/MLPngt5NzMnGlaCX9/t/KQTVV4ljtqDAbJJ3GuAwXSBwsFsADUG40ee7eWfJiKuSXRwc+o/P4VLno0yCU1cFvu8FEvz1gn1fvIepVr0VtQXJmP2zG2h/bX+NjS03OxUVPnJr2DFjingsQvN7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZWw38opH+/IzFQPLt54+PVxdsWaG8+Mb4QeYB3xcdw=;
 b=Du19/O3zS4njPz09EwAzS1IqQoi1gVbHWxV6BhCqBppnL3GxhKemzMdKSZtUp4UTPmIoMxNi6HdBaSPs6Cc6zJ4Sgh00Bc+6oqYDq6MKXysKgIi02S8VuLYIoTzjjRw0f/IFvLi2eVbFJRdAgM830su/RElSVyK6r/czjoUaJXKIweDLlQNLpdaWczvq4omBK3NWlGqIVdyQ4LaEVHRDtqkzlozVQlHo3RCCuGYLI9hTE1ARxLZ/7HxgyKYFJZAOUOSKnZJDrviTm30ciCyJb+pDtxzef20m6npAlpD6LdU1wVlFq+oJzqRG2twAHwqoWkgmZpUP148VU1IL3hqoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 15:00:45 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:00:44 +0000
Message-ID: <151a8cbe-3b97-495d-849e-a5a2574c9457@intel.com>
Date: Fri, 25 Oct 2024 17:00:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] mlxsw: pci: Sync Rx buffers for CPU
To: Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
References: <cover.1729866134.git.petrm@nvidia.com>
 <461486fac91755ca4e04c2068c102250026dcd0b.1729866134.git.petrm@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <461486fac91755ca4e04c2068c102250026dcd0b.1729866134.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:10:52::39) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM6PR11MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: d49e31f8-c0a7-45c0-86e5-08dcf505cd33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjI4MEhTUlNOTWt6ZWtpaytQN3VIb3Z5TGhNTjRMY1JXVmNYVVpZSCthb2Z0?=
 =?utf-8?B?d1ZrYXJHNFZOTkVHK3d1NEM0ekJ0cXZwalBobVYzMEUzcXBwa29rV1c3ZTMw?=
 =?utf-8?B?aytKeWhLZTYySWViMVhtVFVVV2p6UWZEMytoWUdrWmJXSWZLS0ZzUlFWN3p3?=
 =?utf-8?B?OFp3aENDN2w2dWlCWFp4aU1uSVN5TDh6dnRzYmM0TXVmWHA1SEpUNXRTejFJ?=
 =?utf-8?B?SFhuOEY1OXFxVmtrVmVOMUNJWTY5ZXMxMm5XaW56TWlDVTFOUmVaMmF5VjV0?=
 =?utf-8?B?TE03Z1JLclVpRHJRUnhhRk1PNnhDMjBCSmFEc1FSRUlKa1RDd3lOZlY1NUFN?=
 =?utf-8?B?VjJic3lkU1NRRVYwdE53QmpjU3JWTDV5NGtzd2dmZFc2Wi9lVmNLRFc5eXRi?=
 =?utf-8?B?UkF2dzR4dUVLWkQ0TnhJNFNmQzdDNDkvMjNSM0taMVRrQUZUWnljdUh6cHB0?=
 =?utf-8?B?VERNZlFBYkRUN29jS1FheC9udTROYnloT3dYTUJhN0N2TE9yUFJHNVNPQ2ZF?=
 =?utf-8?B?OEU2ZHhWZmtydjNMck1xcFljeDNiQU8xUVdWa09vNlpMNjIzbHpKQk44VzN5?=
 =?utf-8?B?Nm9NOHJEOTMxajE0c0JFV0dXcVJrVC9DYXpuTDBUN1Y0ZjNka0NjYlFlQ2tY?=
 =?utf-8?B?c2tpcjBPbjloTGorUzFFVEpESmtBbFVkTDQvckswaXlmaTJUdEhJcG1iNTJT?=
 =?utf-8?B?UTY4K0pNUHhTS21lT1llOWNtV3g4aUdoNjVhcUMvUWRUQ2V3TldNWGt1UER4?=
 =?utf-8?B?Y1dycThUQ3BrdS9QRzdtSnVXeGY1YkxSaFRjMktDajJXblRoM1pOb05EY0d2?=
 =?utf-8?B?ckNCcnZHY09QbERuSFl3c1RUU0t5RmpGQ2hXVk1kb3NaU1VPQng4Qi9Qb0hB?=
 =?utf-8?B?Z2p6UG9xcytrSEZQNXdDblJJZ0dNL0JPWm02SS9ZQjlTYlZ6Z0Mxb0FTY2VZ?=
 =?utf-8?B?c0J0dmt4eGIwWW1ka2h5a3dIelpZdS9hVWZyNWk1YXEwc2RROFRna1ptTEFx?=
 =?utf-8?B?aGRxdmQ5dUJNQnNoaHhIbFVDV1E2VGRZbnpmMHR2OU4xSkZ6dTl2dnpLczNO?=
 =?utf-8?B?VzZvUUJrRFFCMDVUb3U5VTRMTjVJbFprYVZXTGEyZzlIdmNnK3dvQkxLRmhM?=
 =?utf-8?B?MEloNDRLSldTRlovekNoRkpIOHhRQllFZUFhTnlZaFVhU1pNdUFETytkR3M5?=
 =?utf-8?B?aU40bjBxeFZQcnlXRERGaDFKMThqWE1BUXdrZmQ0MFo5ak04a2l3YlhldzZh?=
 =?utf-8?B?OHQzUVgxcWYwNHpkQlNGQlRxSDBoY1BFMEJUZ2p5Z3lhMEIzQk9TRnk3RDRm?=
 =?utf-8?B?cEtORzliQW03c0dKdVpnUXpZRFZIUnBNVHlBK1JId3c4SDNNd3hFMG90eUxm?=
 =?utf-8?B?VWRIQVA1ZFhwOWJwdklpYU5pRGg1S0FhbW1GNms4YjdRNDRBY21ETWVRTith?=
 =?utf-8?B?NWpOOWhFWXFaNjZ3Ty93YWx4WEtwb1o1dlU1RmZOTTg2Q1hucE56M25CemxI?=
 =?utf-8?B?Z3NMQmxJZmowaFNlMVByNWVWbXJvc1lLbndGOHlOdXJyVmFoby9jTXpYc0Q3?=
 =?utf-8?B?SWMwbS9LOU12MEV1T25ab2oraUN3Tzk5VGJONWR4SSsyc1h3Y0dHaVgrWXZQ?=
 =?utf-8?B?YVZUMHJyRUVGNFM4SCtlTFk2RzJWOG4ySTRjTnR4OHR5ZFdObDZSNlQvSExT?=
 =?utf-8?B?ajFnbXBqVWhSTFdodDl2UExkaTIxRStOTmhUb2JuOTFsQWpTU1pySmt3OFBa?=
 =?utf-8?Q?CIn4qbVVFtVxTYZzVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVd1cG9mcGU4RThqczFXMm93NGdyQUw2YVZDcFNseEZaa2Y1SzMzaDFBN1BU?=
 =?utf-8?B?SDN2OGx6UlR6QkVnOUFFRU53aVhLYjVDNlVKb29LUzVRaEpyQnRiSGZNUFZ5?=
 =?utf-8?B?TE83RlpqY1FZcEZoaWtRWjBDNldVc0pUeEVnN3lWMlVWT1IvbHJDU1k2dVRl?=
 =?utf-8?B?VHExaFJRT0VRbU8vY0pIM2o0ZUlpNVk1YmpmalZpY2tFeDc5Q01OUWFqUkRk?=
 =?utf-8?B?Y0h2VXBqdzRYY1JWNlAySk5HbHk0b0lMYXBGenBXSWtZWHVkRk5vWUR6SjlD?=
 =?utf-8?B?NlpjTG13K05ZT1dYQjBZRWFVU3loeGlueE42dmNqc0RTcThPQjM0RUlmVGQv?=
 =?utf-8?B?Q1dnS2Z5amlXRXBGMncycm14cWptM0o1bmdDSStWaGFkQ041S1BJWkhtYmZs?=
 =?utf-8?B?ZE1RUlljZjFDVjlOT0gzRUFoL3AzMHVGTUlkbkRnWUZaUVhvUVdEcmhtUGND?=
 =?utf-8?B?WnRGK0E0ZWlKci9LajZCTHhtS3hoa0hiK2syQ1BhaVJKeHZiZC9YL2VpV2d1?=
 =?utf-8?B?dDhLOE9HYjI3Yll6MitGWWMxUWFOaVV5NTkrcVdBQmpoQ1lGZEJjdFJycTVR?=
 =?utf-8?B?RFpFSTBySFJITUxnMTZkL3I5MGlWTy9SWWE3RElYV2xkOG9CMVRMbVM0Q1BR?=
 =?utf-8?B?a2M3S0NjRmUyenl0L1VkZGtlb2l1d2N5ZjZRS2I2ZXdTRnhTWGkxeXBJeWxN?=
 =?utf-8?B?VkxaWjNJaWhVZnNwRDVkWEhab3U3RFAwakRzYVhCTmtyUnk5MFBYaFRtNytH?=
 =?utf-8?B?WjJkb3k3RDlNcFMzZVFHQ3llU29HeEpkUmVKZHhmL3JTcCt2OU1tbGVOTnN5?=
 =?utf-8?B?bmZLQmpsMTUrS3dZcmVyQlIzUnJHaW8wRE5RQTZCaVlLTW9BRjFiWE1OZlBB?=
 =?utf-8?B?V1E2ck95M25OeDFqTlc3UWpndkxhWjR4MmRnb2dYMFJhb2ZWTnl0ZGhhTDNU?=
 =?utf-8?B?NDBTeWxua2pTNXJYSTU4NW1vaThVOEp3cTlPRVlycytlMmlOckt1eU95NVVP?=
 =?utf-8?B?SkozM1ZxZU5Memx5a2l0cjl5cXBoMS9zZ3krejk3ZVA3dWVEWm5GdzlTQWVH?=
 =?utf-8?B?OUczR1hxdjl6YmM4Mkovb1pXWE9tRFJlOHNHckVjTEw3NHFuNytjZm12VSto?=
 =?utf-8?B?bkRDeGtxeEg4S1FRY2JBR0s2Zm92V0tiVmk1V2MrUVpXcVJvSnlZNUZkd2Fu?=
 =?utf-8?B?NENEbkJkSEhoeVdYSDlXUExralRrZWw2SzZRTGN2U3RqS2EwalNobG1TZzRF?=
 =?utf-8?B?UXJ0S0l4akVybVFUbThMdDkvTGJNRy8wbGNMWjRyZ08zNUxvYld4NnVORXJC?=
 =?utf-8?B?eEFJeWhFNWhWZ0lzR2ZuVlFmMWtvTmhSaGZjMEtKQmEyMXdBYmRza2xDT2Zi?=
 =?utf-8?B?aHlKVzBrS1F2cmM1cWJpYjNMMzdkQXc4MVlRWjcyTityV0VmVUYvNnNISVBo?=
 =?utf-8?B?eC9taVdTZHh3dzZQWXRIQi9UWHlFOEJWNWJvdm94RENGREhsVWtvQkVEanhQ?=
 =?utf-8?B?TEhGYURRMCtYZjR2b0FQRTN3R0FvTVdLeEdKdjdnZVRtUUNFaWhHNm4vWDNs?=
 =?utf-8?B?dG5RZTBiTGJBMzhQaVdqcWlyQ2lTMVlOWUFJRTdBOXNTQTlKckRjNko0UjFV?=
 =?utf-8?B?RWVYSHFlb0xvcldaWEdzM2k2dUhGeC9VdWVvM0FiRGNzVHk4M0RSQXR3VWlp?=
 =?utf-8?B?Y0VWdTNxNFNlWWVEb3ZNejZhSXlCSHd1TWdVaVVCMFhFZDZBUG43NFhZZVc4?=
 =?utf-8?B?MUtsMHE2YVNmKzljclJOaFNsWTd5d3dnYVF6aFVsWm5RVENKODB3eCs5MFZK?=
 =?utf-8?B?ZnFFdExaaE5rVjBaYTgyZU9WWnBrNkFUQitjN1Q1SXBDcGdmNVFjMFljczVn?=
 =?utf-8?B?bHBDVU9QblliZ1U0eG9waDg3SWpJY3hXNUc3MVBJTG1HSlBkb3VNUHJFYmlP?=
 =?utf-8?B?bmdvMWxsTDJBdkhQbytWNWlpQ0hudmtoU3g2SVRINlZ0dlZiTjBHMDZPYzg1?=
 =?utf-8?B?ZC92U3BwS3plOUNVVTJBbEVWWVZ5VUlOVnpTNSs4ZzVlOUpobXQ4RXZ3Ris1?=
 =?utf-8?B?eTFSaEtZNmpWeVRzRVUwbWZjWkt2Z0FrYTRDRU5HTVZ5bm9VOE5XNEtGckph?=
 =?utf-8?B?VVg0NWhJK1dtTjg0eTJFeTZQUGVPWDcyekNDVkw1NTVyKzV4c1IydkpkYkZ1?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d49e31f8-c0a7-45c0-86e5-08dcf505cd33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:00:44.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWHfx5rZHw3VG+RH1Mm0G4SMWetzR91svzJm47lV9CaHVhbYXgrEw6Nb3VmmqDamWIDHKOIKUPE3TYthHT1jHf51rjb6JodShQoBAXgRoNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-OriginatorOrg: intel.com

From: Petr Machata <petrm@nvidia.com>
Date: Fri, 25 Oct 2024 16:26:26 +0200

> From: Amit Cohen <amcohen@nvidia.com>
> 
> When Rx packet is received, drivers should sync the pages for CPU, to
> ensure the CPU reads the data written by the device and not stale
> data from its cache.

[...]

> -static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
> +static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
> +					       struct page *pages[],
>  					       u16 byte_count)
>  {
> +	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
>  	unsigned int linear_data_size;
> +	struct page_pool *page_pool;
>  	struct sk_buff *skb;
>  	int page_index = 0;
>  	bool linear_only;
>  	void *data;
>  
> +	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
> +	linear_data_size = linear_only ? byte_count :
> +					 PAGE_SIZE -
> +					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;

Maybe reformat the line while at it?

	linear_data_size = linear_only ? byte_count :
			   PAGE_SIZE - MLXSW_PCI_RX_BUF_SW_OVERHEAD;

> +
> +	page_pool = cq->u.cq.page_pool;
> +	page_pool_dma_sync_for_cpu(page_pool, pages[page_index],
> +				   MLXSW_PCI_SKB_HEADROOM, linear_data_size);

page_pool_dma_sync_for_cpu() already skips the headroom:

	dma_sync_single_range_for_cpu(pool->p.dev,
				      offset + pool->p.offset, ...

Since your pool->p.offset is MLXSW_PCI_SKB_HEADROOM, I believe you need
to pass 0 here.

> +
>  	data = page_address(pages[page_index]);
>  	net_prefetch(data);

Thanks,
Olek

