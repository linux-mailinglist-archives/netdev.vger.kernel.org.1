Return-Path: <netdev+bounces-183490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ABDA90CFD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BBF4460B6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04B217657;
	Wed, 16 Apr 2025 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8LAGx47"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C21FF1B0
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834757; cv=fail; b=CNxcZWXwSZPHbMzwawcVqgQjlYLQ+iWsj43HK/QNtczoXvBwILpCMTbkxnvgj/h/r260n75Ehr8rlF66EbMb1OmBwgPSEMsVbQWIamM5Z2ivs7aU5vcM7cN7DFVgVVliosEeplYdMeC5Yf7ymsV8wEptpjymtwJGp9EdlYUYzYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834757; c=relaxed/simple;
	bh=oxW6y65n4EsvLgPgMbAZVGCHJjzpcZtKo8LAlPfBunY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TfwCjvxzNE6BE6kX3ouZ6eaIoJwF0dS5ExppcbOxN8QnbT/+qOLJLf/2XamYLd5eFTsLHeImiYEF3teh6ZF87SUVhDa5bH7FI8EJx8oUPcqJxfHBM8JSEjNah+ucfaNijFc5oD8mC5cYQpzSdUivpEzDvnTGzd3fZ1YBbyYqocg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8LAGx47; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834756; x=1776370756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oxW6y65n4EsvLgPgMbAZVGCHJjzpcZtKo8LAlPfBunY=;
  b=O8LAGx47RnF51dN40ZRjiEHyEmgH3p6KRrSfbfF/wbHOapOgeB0PqaOK
   hAxqTQYaIvY/qUUi7j/QMTkXmxGETBUtTalJpwmj1nCrO2KoNjDDTWoWz
   wMWECNmluuQsYgivLk6ytUgPWws+9GdkGORifV7CNapWClX4NrzQvDDhy
   ffKg01ZBhIzS0JskZi8ZUphtYwdI6sqh91upjzd8eQeQdPoixGzaAcEmM
   zWZvr5gvf8PiPu8nE/zLu+7qVfKx4awGPMDjIMoBU7I+DJPWkbsrhgsli
   c9Lh8s0HYi7adtShZqK3rTCnP/+i63oJfJjpdki5fkwPM9H13mP63UP6k
   w==;
X-CSE-ConnectionGUID: 41TQ81fARZiWnljvZYkDFQ==
X-CSE-MsgGUID: MnnMiJ+1SRShoC3GD2u0Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46532606"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46532606"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:19:15 -0700
X-CSE-ConnectionGUID: uJ9E1kuwT9+9jzyDMF4Gkg==
X-CSE-MsgGUID: yNR7WxPYS6WgpuausIHPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="161629880"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:19:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:19:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:19:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7M46dCaf0oOsSFH+3jse32fwZd46VRyGFRYd9Q8i9gzRw9q7O2icxPhSv7EJPgYQs54BSfBmNEgq4RpJBJXUsA1ZCF+dQLeNDoRCykDSO953CgTuA4YMIdgcMNOBV1Tvc+N6+iHcnekuF66G86hThaXOajZtPjjrO4Up0NwEzW7bbuTWbDPTdvfblRXaxZNsKqGCQGgSd8DW52gyPF888j/UKg6zfl12SHs8s901P6IzFQAycNFE9laszNLgrHCLIzX6fcBf0iUnvROE8fUo5pyTrKPAGICwXkDl6+yfmkDZu9F4Bi7BAW85hkZjsJCjnrOtfRvduzBW3KTiRTmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1upHGPSQaUIn3Hjst8zAme7VvwpPgp0AGe42Dn1toc=;
 b=XXQhEHScjVnFRD8hvCJYIeGUy8lFDd1IGhEC/CEWqnJkUTdXtNBPuHM4l9QZl8OETPYkCZeggkeoXGepNnCkDZ1FjW5pn5+rq+dASm5MOFpS0oc6BM3j36ULB6/GbxU6x2lU0YApQXo2B876WMZUP//PXf904Q1ceMXNFrM60TkWhLi43HNXcoCcvtbYMcwsFeEKO68wCsff28C5QyVqEBCuWhCXLMBESZzeXFXMiv76d8viwz/zcHOw3/Fm6LR1jrf2LeDdtQsP7SywrjDFMrugQgG08THRbBVUw9lcgtvMWLE5wO0hd9rPZ5auK6Pjc/UQ2Qn9SGN5EhKO78Ifkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 20:19:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:19:07 +0000
Message-ID: <ec58ea9c-8034-4133-acca-d4d06e6e1f48@intel.com>
Date: Wed, 16 Apr 2025 13:19:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: visconti: convert to
 set_clk_tx_rate() method
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Paolo Abeni <pabeni@redhat.com>
References: <E1u4zJ0-000xEX-TZ@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <E1u4zJ0-000xEX-TZ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: aadd7c65-572d-4b58-de97-08dd7d23f0cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3E4ZWVVa0VnVEppUkNlV0cxUU54cDk2clNkSVhBa0dWaWJjK3p5SVBXWTJJ?=
 =?utf-8?B?WWx4UnJ0VVlGOS9wS0Y2YzRLQTB5OFFJK3VDWE8vSDc2b3RtdGRMMWpXaloy?=
 =?utf-8?B?MncxNExMbm5qV3Q2cGRXWUswbEhHNktBVks0WWdoa3dGMFhxS2loTlIrVVk2?=
 =?utf-8?B?L1pmS3VwbUZpZkxYVXFKcHYyOFRMdHlsdjdJOUxnSkVCbW9RMTEraEZ6bndO?=
 =?utf-8?B?R0d0RXJiWnZiWkhRZkczRzdLNklUWTZHcnFhWmVHWE1QQzNicnBRZ0EwWGgx?=
 =?utf-8?B?Q2VsSThuSTRzN05lekV0MjZqWGg0OG1FRU0rcmMvQXVCUnJ2dDhOamt3Ykll?=
 =?utf-8?B?OWlXTW5kQWw1WkdmbklvTGdyOEt5U1MyQTRobDdXcjRlSmZqbVVuNndTdkVE?=
 =?utf-8?B?KzMrcENNeFhnVDdIa0lDL1JHaWxGWjRRMmNwTnVnZEhNQmJYUDMxZUR1TTQx?=
 =?utf-8?B?Y1ZrekhwLzliTG1sRWI0eENBZm43RUJqZlozWC9CWWNGVFpZdW95NkV3WEJz?=
 =?utf-8?B?L1hIY0JFRmtQOThiWC96SnJybHB1enF0VVB6L2VJRkJFbWNRbXV0V1c1cjdS?=
 =?utf-8?B?Wm5FeTNjM3piRFQ3ck9TMHpna05lZUJLMDhSUzdkRUZocjhrZEFBYlZhd3c4?=
 =?utf-8?B?Qnk3eGdzQTZNdm9YVW54SlpYU3NTd3lYdnhWVWxqWCtWQWJZMlN3MGsxQW5J?=
 =?utf-8?B?RVRIbTRBcnF3aGliUURwa2RWV2o1MnZuWGtpR0cxYmc4NFJGSWN2TVNOejJp?=
 =?utf-8?B?R2RXYUQray9xdCtEeENjTUZwR3FRR0xaRlQ4RVY0TWIyL0d3amE3cHp3WUY2?=
 =?utf-8?B?OVF3eVRxOVV5NzFKNzBsZytFUWVPaFpUaDRlb0h6ZUFsRWwzM09GNHZnSU1h?=
 =?utf-8?B?RGprMWtQMzdRREV3OHVVY05aajdkenFHaDdHWlZGQmJUaWdveWFaQ21XWDRj?=
 =?utf-8?B?RllaQ2RYeHVWdDVKMWp4R0kzRCtMK3ZKNWNiZkdzN054aHIyMjJrQVBuRS9w?=
 =?utf-8?B?RUZTR25GTGRCME41aVVTSWV5OGdtUVVyYmdsWWgrbFg3NzdieXFEQnhIZlVK?=
 =?utf-8?B?SW5NNHd6QWwzeGdUbGk3TTJWQzNiRnE3N2pjU3JibGs5S3ZTaktNVnZTMUk4?=
 =?utf-8?B?Q0c4ZFpzaGVqR1lRVnEwYzRpdGRkUVE3THoxVVgxMUVjSVZKMVhiME5RN0cy?=
 =?utf-8?B?QStuem5KUVhMaXJNREpGVXl6R1JZcnZpbFRWMFNKc3VNNGJXRWhYVXdEN1pk?=
 =?utf-8?B?RkJONlY3VlRreTRHQ2JpdWVKVmp3eW5CaGtxMXVmYmpEU09uM0hrRUgyeVJB?=
 =?utf-8?B?cWFDN1pnUjFVdGVIblBUWGs5N3QrYU1DajlteGZOb1dRQ0UyOWM5ODdDc2xk?=
 =?utf-8?B?MFNaWmFNclNhdmNBajRETFRSajBtaUxVdVJudzNBcDFQaGRaZFJteWVVM2RZ?=
 =?utf-8?B?QU12VGRiTUhXc0JtTGhydWtCY3dDZDdGcCtTbHdsRUc5ek0rSXlsTk9BZmt3?=
 =?utf-8?B?d0dRQ3dTeHluaTRQT1QxL21iQU94bVB3QmZQUm5jODQyaDZBbytteHRpRUVz?=
 =?utf-8?B?MGdCVyszOTRTVVBqUDgrSHViRkdha1dIdVhQK05jai9wT2RWM0JtMUZpR3FQ?=
 =?utf-8?B?UjJ1YWlwZFR3UU5yQWFHaUVEb0xnUk0wNUZmSy9hUnN3TkxtMERIQWJlSmo4?=
 =?utf-8?B?SkEzM1l6dGphMnBXTVhHd2dHcWZ0b3ZUSmV1WG5ZRG1uVGJlWHlqNXdYZ1Uz?=
 =?utf-8?B?VXltVTRzQmRSa3BqS0R3K2dJLzc3dEswQTlWZCtnYTRQZGRkeHJjb1Ria2Zw?=
 =?utf-8?B?Q09BRHRER21ZdzB6d1lsb3gxMWwreXZtUzhHWTN6YndrMHJjUVloeFZQcXU4?=
 =?utf-8?B?eWZ5a2NML3kyaXUrWFovSyswUGhveTRqSUpjRm1FUTlxMnMyVXNiZ1Y4bFJj?=
 =?utf-8?Q?D1J0RvadHJE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FZT010LzFhSE0ySDF5ZjZRUkVJZnJjSmFMcTgrQXZTTGIvN0JHYlVLMkFI?=
 =?utf-8?B?YzMvKzVaeXo4aGZwenhyOGo2WGpXRmZEaE1yN1lNN25TRDYwWmJTekdSbUg1?=
 =?utf-8?B?eTk2RVdXMXVCK210cWxsY2pFUk5oSkVlOHg5WHAyQTRxUGJoV3FKNG5MVUp4?=
 =?utf-8?B?SlZINHRRVS9CandCVlpPOVZPa0VtVldtUmpHcmdyQlhtM0UwWW9pWDd4ckV1?=
 =?utf-8?B?UUV5VlNUZHJjVHVNUTRLd0tkZTdKcGRuWE85bkhlMGE4S1ZYaENhM1NTNGxr?=
 =?utf-8?B?L003QmZhcDJZZXZWcjUyaVlrU3UvYVA5Wnk2VElMQTRvRVhwd2k2cUd5NGhL?=
 =?utf-8?B?RGtaYzRobURVbERqamdGVlJwWENYK01WRjVxZjZkekptcnIzM3RYRkJRN3BK?=
 =?utf-8?B?MEJrYnM5ei8vZ2JsbGVDWUJaQUZoUDQ5ekJVZ0xvZmpXRzlNcFlZNVZ3Mitx?=
 =?utf-8?B?N3hXTUNmeUJaMlhobVR1bUYzdm1nQ2J2cE9LYWo0NkNzUVZpOS9CS2QwVExo?=
 =?utf-8?B?V0laWm51cTlEemNBeTF1dWhHVEUzWDFqL1RqOVIwZnZtQVFNWVZueVVPZEcz?=
 =?utf-8?B?QXFZb1FEemZVVzByTTlnWW0xdWJjQWRtQi93b0Z1dmExYVpwWFdzbUdnckls?=
 =?utf-8?B?V3J6MlJzWDUzNDQ3Y0lNRzdPemc3VHozUlVISVpwb0txb3hXZGFmei93NmZ4?=
 =?utf-8?B?WW03SFozakVtWHprRjYyYlNqZHN3K1NvOWxIeE5NSFQrZm5GVkIzUkFDQ3RP?=
 =?utf-8?B?ZXpkbmpNRGJ0cDRDYkRQUy9vTTVPUU04OHhkSllqTkhLem5HYzVhajd2MWQ1?=
 =?utf-8?B?bmROTSsxbkZzcE9KeEdBTXZ3MEowNFhzOWhHZy9yT1pkUWRtaXVaczk5Y2dK?=
 =?utf-8?B?Y29hM0dnd05BcEFRZWpsQTdqc1pwdkY4THZKaEhnWGkwM1pNR21sQ09EVU9m?=
 =?utf-8?B?QjliQjRsa3AwRndBTEV2cmRoS3dtM1Nlai9XTWl4TjUrb0ErTDNGODU4S1Zl?=
 =?utf-8?B?Y1ZuaUtKR3YrOEpyaHNDNGx5dkhLeGRuWUYweU5XMFpsSGlIKy9iSTM1cDBx?=
 =?utf-8?B?SXJydnlaUHlOU1k5bmdIUzZxWjhYM0ZUUXFCSzFuRVFROEtsRGN5K0U1Z05X?=
 =?utf-8?B?L2RjRC9ZZ3dxVXMzWGFZL2QyOFdCaDlHbU5ISHVndXk1Uithc3pYS0dGWkZZ?=
 =?utf-8?B?Z1FDOGhQdHpFc1pEOFprd0JYUVVEcjZPSFRUMVVBRjQ0RHlYdEdUQ1V6cUZi?=
 =?utf-8?B?ZnN5VndaL3JWMUpCQVBWc1ZkNXhMVEtscEg4dGZKNkkwQ2tWNVF5cWwwVXNo?=
 =?utf-8?B?ejNwcG50R0JZRkt5R0lQS3ZXVC84ak9tSFhLSHNsbEJoMTVON1RKNlF2TUFU?=
 =?utf-8?B?VXJtUUxtaVorK3ExRVU2d3o4R3JLMzhsVW56N3I4T1pqWkl6VVJHaVBIWmh4?=
 =?utf-8?B?Wjk0SDFUdkEveUJVR29MZHBRc3pxalJQa1FyeW5IaGpVY01icnU4dFJPUnZ1?=
 =?utf-8?B?dFNUMXB5TVJZaTBwZEcxQ1VaOWQyaEpNK3Q5LzBPbVNOV2srT0lKVmVmd3k5?=
 =?utf-8?B?QnVsNHVtczZzeCtGNEx0L096YXIzVzhkUG1YY3N6SFBEajl4bUx1RWdIeXZZ?=
 =?utf-8?B?NXdiVHF1Mkl3LzQ5ZWlUdllud212OHlEbExoc000cy9MS2R6UFRTa0JiVVFT?=
 =?utf-8?B?MXRhUXdyd3pBeUVGeHJDM0FmMFlYSEdNbkZRZk1Tck1yUmt4N0krcUc5MHN0?=
 =?utf-8?B?WEpSNnNIS1QvVFR1b3l3M1IxdGZGelNialFsRTk5ZG9RQW5sMzRsdlE4RDNK?=
 =?utf-8?B?RG1vSGlZaUc4cDd0a3hidm9tOXkvR0FnMEVBMHBwcnFlekx0aTZCbVIreVNy?=
 =?utf-8?B?dUJqNG5IWFhwczljQkR3Q2RaOHEreXdzaHZNcURTME1FcUROckxFQm9vM3pZ?=
 =?utf-8?B?TUs1TFRpRFNCVUlLZHdsSXJZaC85dGFwY2MweVg5TGdHeVBEYnhndTRodEpK?=
 =?utf-8?B?VWdETVpwZEYrMmhaWGt6SExWamtSUHowK2JERmVaN01pYnJhbmVWU1Bjanlq?=
 =?utf-8?B?VnAxbm9tZndKWEEzQ1FrSWRVelVkTjdDUzhLc2plcmMyZnBoTHh6RXZpbHRL?=
 =?utf-8?B?NlJwZVNjSytnRnF5dHk3bUdNNmc2cmxzT2IrQlYwOElCMlNRY3BpMnMwRmVk?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aadd7c65-572d-4b58-de97-08dd7d23f0cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:19:07.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZE4TOVUYfHEbb/4jwuVLSkpwnlveCvU5leBMuOx/PFF2OZg6q0VVIVxvMLNpGd0H0uIE0u8v42I8I+lD1U89Ca8plORo3xpJ5GyR+dhJ/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-OriginatorOrg: intel.com



On 4/16/2025 2:43 AM, Russell King (Oracle) wrote:
> Convert visconti to use the set_clk_tx_rate() method. By doing so,
> the GMAC control register will already have been updated (unlike with
> the fix_mac_speed() method) so this code can be removed while porting
> to the set_clk_tx_rate() method.
> 
> There is also no need for the spinlock, and has never been - neither
> fix_mac_speed() nor set_clk_tx_rate() can be called by more than one
> thread at a time, so the lock does nothing useful.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> v2: add Andrew's r-b (he doesn't mind it being preserved for simple fixes)
> fix build errors.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

