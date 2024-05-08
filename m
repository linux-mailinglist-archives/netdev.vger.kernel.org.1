Return-Path: <netdev+bounces-94474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234298BF974
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C832818E2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6C71753;
	Wed,  8 May 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f05Eu9mg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26517BCD;
	Wed,  8 May 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159862; cv=fail; b=mQA1AFOrgmVgdOr6UZtYsJRUKRVedfI1TEzvdhYLYD4WCxKPOzTl2S1jMVA2645ljcA8Fa9N6iJ9YS1owvy+92oQJFNxU5RxO0ueuX/S1tPIWoOuLX8FnVSrf5iihpihQDfrY11qY1S6SE23+wnrAOM7SxRuQ112F88ckGC8Dgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159862; c=relaxed/simple;
	bh=AtH1IIuhsQGajLh+FZ+bm1voHpj/M7Jb/jG6og0QjXE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJxTeC/xg76iNWjq5Bkr0bQCbLXvAIfKlefGZu7kJ8lFJuh2e/Py+QMhepaonS4x3GWIZGt9F0ML9plhiYh936yk4W/THgGm72aEuRBJER8hjxeD6xT/JacoIX4k+r9deoz1y8EJISHvWpgkf2bcU/Kwp1yNduuvYeF6AcmxmP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f05Eu9mg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715159861; x=1746695861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AtH1IIuhsQGajLh+FZ+bm1voHpj/M7Jb/jG6og0QjXE=;
  b=f05Eu9mgNHJUM/l1+t1g2Ympg5nVknK15bDB5tDsLeEvEXLtKFKR6Iq4
   lR+3zJnZ5+7ddY9/J7et2zUCUxPvyCaJfp3BxPxxlsJs8TnWgeC6ThETo
   7KWEhVx0z04wDhVWwCzbUsEz5wSMy1uTGrYYqN4zI093CkLe5aNieaPku
   UF9h+sL5tQ0qlHPbbIp7PFX1rM9tD0ee5fGrA27oLfyFPY8KbFNu/1zJa
   WW3/FceSf8jYDVJGHkgKgrwR41EBmfC9XITa3+g41PQYPz25m2R35+VGx
   bwGOQCrLqlNOEFz2RUyG3NLcsK/RTN0hev9QexlsizZziFbH1ZXPLALWl
   Q==;
X-CSE-ConnectionGUID: SgJzd/TfT5SyXylsr12bgQ==
X-CSE-MsgGUID: 7wmehy93T2evCRqQmA7p2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11162560"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="11162560"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:17:40 -0700
X-CSE-ConnectionGUID: AvYPy/UzQNu+HzvUOe23UA==
X-CSE-MsgGUID: hdnB1eOhTGK0hYon1X8z/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="59987357"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 02:17:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:17:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 02:17:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 02:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8xJVdYTRa8RJGA5Hk0SkQIBbCaiajsC3s6fbf3Dq18N01KffL7wJRFsBSnkufWHeAmUzYBD3oDh9iTy4AQoAHUh16nvpF2ymK3f4bW9j69Fyayn2kk18Y0MkKcDl/0wpj+UpsKK7cLUPbBVtTFJKT9W10p+WbftrsKE/J2PuH2LwIzaGfusE/NTrTG23GkkMHODglmDsECz+mgItb2UrELoxWJqoh6gGPfcwBluwTOADLpGKgmtkYo1wvlW5VrCDsEPMe7or514ApfUTiDM4Y0oTd+iXYVN+bgqC8DxHzU/vt7y5mwINbMJqBS06aran4SFGtUJtMi+1Tr0peMbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me4FWCgNcQ/O5TKIRsLSdbyHAh0d10ZLWT4AW/VWOS4=;
 b=IZMUDQtvTIsVlB+WBvmnckbzkY5iMpjgqrlm7gsRd9hkM4PYtpvwHuPYaVAPuYoSFnXQjbmL1SivFS0vg+kk5aTriIdNQ8AcH514D4YlcIj5Pnb83TxapzxaoF9cy6T0jVgcI9D1ErakeICIFavqn2JNVztDsD5fwXSpH39Px518eduYdLpXPrQWa7oXx7cdgor3LOVUxCETqYovEZax8fGVVYQeIHIi70dfZbE1m4ldxvs1C6PmE6mIVhk3NhEnxkCNpzpMb2c4/D81Q86yVfMnwpTetJLJM1IfuPjxnAwre9Ahz3bv8FWKo/1gWpey7sOUvbMi0HEzAKUecRvWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 09:17:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:17:37 +0000
Message-ID: <38b22230-01f8-4334-a8c1-dd3dde42fe40@intel.com>
Date: Wed, 8 May 2024 11:17:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] lib: Allow for the DIM library to be modular
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <jgg@nvidia.com>,
	<leonro@nvidia.com>, <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Tal Gilboa <talgi@nvidia.com>, "open
 list:LIBRARY CODE" <linux-kernel@vger.kernel.org>
References: <20240506175040.410446-1-florian.fainelli@broadcom.com>
 <dfc2d0b4-3ff4-424f-8bdd-3e9bdedba914@intel.com>
 <52bfe069-bff1-4f8e-baed-1c556e43a242@broadcom.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <52bfe069-bff1-4f8e-baed-1c556e43a242@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: f0efcfda-daee-4996-3cb3-08dc6f3fb3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpVQ0hxbFJmTHlQQ1EyZ3EyOVNpMzNnZ3MzVjlPcU1wVXpJMlJSU25TNnFL?=
 =?utf-8?B?RmxpYnVGRnpYZGl1WG1xS05HTUdodlgrNFl4VUhOMDByZHZzOUtPSHVtQllm?=
 =?utf-8?B?aXpyVFRjeFQvYWtReUNzNlM3SGtvZGJaazZlNEpGZ1FUV2E5V2M4QWVmbFpO?=
 =?utf-8?B?ejloSk1EbTBYenZDSDBtdFRFNkVPRWhBdHBGYjJyTjdOQ0NUTEhiaERJUUVP?=
 =?utf-8?B?cVpoNkpQM1phOWRodlY2NGZmNUJhREVYUjU4MGFBcjNIZWsvdFJteGx6TEYx?=
 =?utf-8?B?RzUwRnhZU3RObkEzSW1BU1JKYkFXQnBkNVJSS2ZBSkJVeVFKS2trM1ZkOGpk?=
 =?utf-8?B?M0t5K01rMm9hRWRqdllKK0NJNjBxYWtWdWt6VzlsbEtGUGZVTlZkWHVOZmdh?=
 =?utf-8?B?R0pPaVd2QTI4UC9sVjh1SWR3UFdPbEEzdG9YOElLSllVQmdjcUtla05XRlBx?=
 =?utf-8?B?WUtDelZIRHd2MDVPMTZ3YWxLdzRJbFlkemJXNXA5NjlJWjJGM3JKbklJOG9l?=
 =?utf-8?B?WS9wZEhzelVERVVWQTB1RVhaTFhMSXR5VmsyWmR0Snp0YzBlUW9QbWFBWnpK?=
 =?utf-8?B?UUV5M2E4akdrcXhvNVBYeTJoL08wY3pnN2VpcVM1Y2NibkdoZzA2YjFkM0xU?=
 =?utf-8?B?TXNiK2ZvTzhBS2NBWUJoWlAvRWlpMi9sMC9LZDUvdzkwSWdjN3hNeXZDUXZN?=
 =?utf-8?B?NEgrSWhuRHVkSWV2Vk5zSXRVUVlBSnZqN2VEUnNPSHV0a09aRlZrdzBySEJ6?=
 =?utf-8?B?U20vdnA0SzdLTFJrUFdLNEdsdHh0dlR1OUE5OXFCNjJJc2lrcUViVDE3by9K?=
 =?utf-8?B?RHZJVmM5L1Q0WDBxN0xydWMxNm56ZVZxRmVvR2ZLYzdleDJoaWtBK052TUxI?=
 =?utf-8?B?VS94dWlwNDZuRjcwdmFzNXl6WVVuMDNvRGYrN2ZYS2JEakUvckV6SVZGRFJJ?=
 =?utf-8?B?ZjlHVzh6bjlrUThyUGZ0My96cUI3TDQ3Z1VKSEZTaXVpY1BpdTV3anJFRlVx?=
 =?utf-8?B?WDdyZ3NzWHlLY1hFWlVaMTV2MnVuNHozUklNWjFlZ2NaeU50NnVIT1RrRzJp?=
 =?utf-8?B?Z21GMVh3QWhoZHJqUDRPazd5WC9tVWwxK1RvUEsvUjlsTjgvTms1MEM2UDlx?=
 =?utf-8?B?WGNwYzgveXlRQ21yRnNVbWQrbnFWMU9hbmdvV0cvUUxCYjRhTUNlNDR4QXFn?=
 =?utf-8?B?c0NUOU5PSGkzT05DdVIwOUM1S01BYkNwVHkyNlNGTkVRYy85SjV1anR0Tytn?=
 =?utf-8?B?b3hRM0Q4ajFjOTd5U2k1UEFFalpsOGNDcTRIdnhPcjVhTzhuRmRoTnN1dXVR?=
 =?utf-8?B?NTh4WGxGWU5HRHBvdDBjT0dLaG9GRHpPMFF6Um40aktXV0RUV0ZtTzdXQlo2?=
 =?utf-8?B?c2JscE9NdWtUQTc4SEtTYzNQZ1Y3RzU0MkJBbUIyYUNQMGNNbHd6WHZEN1Iz?=
 =?utf-8?B?YUFSRktPZlVRU0Z6WU5QaWlGSUJSQTdKbkxZSGlJRHM5U0NVU0REd3MrSTI3?=
 =?utf-8?B?aEVqTCtzY2dHRk43b3FZMTVLVUVhd0VyNW92emQwdDRyUzhmOEdZZUJRcmFV?=
 =?utf-8?B?UHpJUTNOVGk3Y2c0a2dPZ2VSdlRqekk5clpoMFlUT0M5S2VjOHVJZ0JUaERT?=
 =?utf-8?B?QzdnbzRkaWJLVFRaMHRFaG1TNVliRnZ0MVZ2S01TNUNJazdmVnV2aXZIbTI5?=
 =?utf-8?B?S3N3cXB0ekg4dTlzTHlrNEtYM1hsUUlENHQ3NGMyYWYxYkVJM2lvSGpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05CS1JiNkpyN21TalJPZi95SWZFMjhGYW1tWk9EVENma0dNZndrbmVwOGsy?=
 =?utf-8?B?bXRMaWNuQmdndDZySjFoN0RHdUtJMkFNVkJWYjhDaWlubHFrZHVPejlBY2hV?=
 =?utf-8?B?VU1JNTZsRzdDMktQZ2RCYVNaeGpsajVaYjZJcEordVlQWXhtTFAydU51a0w2?=
 =?utf-8?B?Q1JON01RK2dFY0VBakM2c29VTVpZL1NiY0J1VEZQU2szc0E4QmlMc3NXemdN?=
 =?utf-8?B?allHQTRPMmFrcExKVDdCMEtFSlVlVU5pMkFMVVpMUHpteHFhU045aTRwMTF1?=
 =?utf-8?B?R1lKN01OU1cxem9tNnhOclczTTQ1TmZXNnhpTVFySnVuRG5TSDBNcGN4cTFI?=
 =?utf-8?B?azgzZC8xUGY3dlRvYStwV3ppd3lmYjVocXRtaFBPUnFhdWtOU1dSZE5OUnJt?=
 =?utf-8?B?UXZLK2FEM2pOdHZ5UWI2a01VUE51T3FXZ1JHVGVBVHd6YXhRdWdTT09VcGo4?=
 =?utf-8?B?bW95eXl6dFVrRFRiWUsyN3ZKRzMvaytRcVBjcFNCWTU3U203dXhxbWlFTE1a?=
 =?utf-8?B?Z1VTTko1TDRmRlBERGM0bUdHSjhBOW1ELzZEaitzQWU1bmYzYUhSSmJoOTBr?=
 =?utf-8?B?NXgvMGVlODl4V00xQUEvSTRMQjNYNjcyWVF2UnVySWtacWNwWjlMVHhCRjM4?=
 =?utf-8?B?REZGWEIwSWFxSksvTEtMS1lqL1FnRTAwM3dwazdNMTAxUFYzMDlueWxZUFZ2?=
 =?utf-8?B?ODJGNVpISHBSZDJTcWJxRnRMKzdnUTVsVVlHWVEvdjR6a3FVN1BmZGhtK0Fo?=
 =?utf-8?B?eWVsVGJ6R1ZWZ3FDVjJ3SmNxNldWaFBScThUc0JJemNkdVJxZzErOVNoQU1n?=
 =?utf-8?B?Z1QxbGgrUFBXcUdrV3F0Z1dMWmNlSnVpSDZ0ZUJxMVRFM0JxbFZYQjQwN1Ju?=
 =?utf-8?B?VjZ1OUc1V1VURHVHQkNjRWhhb0dKU2U4dnJ3eEtuNjVuTGcvTE1aTkdDWkRz?=
 =?utf-8?B?aGYzbW1uL2wrTHp2MlcrU2ZNYjdaaTRYYk9VOW15WjdEWW9UdWlQK1dmVW9O?=
 =?utf-8?B?QmNyYlEvM3JuUTVlZVFLa2VvUWZzbW5nTjN5akRMWTRoa1FoLzZ0cnM0NEZT?=
 =?utf-8?B?Q1JSQ2QzTE9tR1ArWEpjTUhXRUpIZzFRUWFaVXEreVIxTVhMbnpOUUNkUzBJ?=
 =?utf-8?B?VTZTVklBNUZxRyswdjFCVWxzdExEek13UkVKd3VGUnVoZjIvOGpMYnMrUE9p?=
 =?utf-8?B?WXFaQjkxYlM0MktSWXZNVWkyZVZvRmFLeDAxdXZYejRkZ3piNGtjWDhaWi95?=
 =?utf-8?B?RitpaWhoUll6N1FYUGRJS05FOElVa2JtbGRvMnhjQkxHNGl5aEt0TVZURXdE?=
 =?utf-8?B?QTRpSk8vMzdOVi9RcVFQbnE5cmRoTW0vWWJibllabEZCOXpoV0Z2bWFtLzJp?=
 =?utf-8?B?MlBtQTZocGNUQkhTQ0VEeGVTZXpIWlJhV2RhcTgza2pmZlNvblpKRzFucnhW?=
 =?utf-8?B?WDlxYTJFRFVXS1Rab3dBZE9OU3YxNGJ3UTRSL2RiL0xVMW1lVEczclE2TzRD?=
 =?utf-8?B?U1puUzRRc0xDY25BY2NKazVFeURGU0lqZHVzMFVwbTFXYVBFajZlZ2l0V1V3?=
 =?utf-8?B?RTRzSHlUWnh6eEQvcTFwWWJPUWZDaFpIVXZXNzIzejlORkY5U1FKN0dqN0Rw?=
 =?utf-8?B?QVVZK3hlRFpnNURoZDNRQitRbW1OdVNTcGJML0FoY0dOb0FkMWdhNVE1dkFS?=
 =?utf-8?B?c016SGZtMVJ0UDAyY21VWEZvL1BmRk5IbXFXeTdaWXRJVTFVVWtTM3F0QW9O?=
 =?utf-8?B?N1g1ZlZvaUpYQTNEa3ozYU9YWjlKU0xmQlhCYU91QlRHMEROWDBGdmZSSHo0?=
 =?utf-8?B?R0hSbnlBdWtJNU5pZThwWVNta0NqN2h4OS9uU0R4RXNhYjNoR05vU2UxVy9w?=
 =?utf-8?B?Rlc2alIxVGVOUlVVYi93VE5YSWxBb2pTZkJTQnVvYk9rR1g1TzFMRWpGZUs3?=
 =?utf-8?B?TjhSa1psVHB4M3BYZW14bmdmZFZoS1NEaE5MNVl2QmJFbjVCTC91QUdHTVoz?=
 =?utf-8?B?ZjJEd1lMWGdoaDIvNWFOdHNrTk1ZVCsyNlhNaGFjVnZMYzZpeFl4dXNodE1B?=
 =?utf-8?B?M0o4V2tFSnBKZXRSWERtRFZOckZJZVVEVU5pZG9yKzZEZHI0OFVYZUpWWTdS?=
 =?utf-8?B?RFpwNGxTOXhDODJWSlIzUmdzbHRJZk5tU0EySzdCS1FzaTRTbFFoTmMzQjBJ?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0efcfda-daee-4996-3cb3-08dc6f3fb3c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:17:37.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B79Yf8Lvca6dnwrCyYSHpF0I9fQelmEvqyN1zL5ubnQtRilqH++FWpb5p8yxZTCiMlI5dxpV062Y+VavJfU1r7YSS0FN248ln1umk1263GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com

From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Tue, 7 May 2024 10:08:19 -0700

> On 5/7/24 06:13, Alexander Lobakin wrote:
>> From: Florian Fainelli <florian.fainelli@broadcom.com>
>> Date: Mon,  6 May 2024 10:50:40 -0700
>>
>>> Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
>>> module. This is particularly useful in an Android GKI (Google Kernel
>>> Image) configuration where everything is built as a module, including
>>> Ethernet controller drivers. Having to build DIMLIB into the kernel
>>> image with potentially no user is wasteful.
>>
>> Some bloat-o-meter -c vmlinux.{before,after} would be good to have here.
>> The library is small, but I personally would like to see it modular.
> 
> ./scripts/bloat-o-meter vmlinux vmlinux.after
> add/remove: 1/16 grow/shrink: 0/0 up/down: 8/-1980 (-1972)
> Function                                     old     new   delta
> e843419@0740_00005048_4014                     -       8      +8
> e843419@07b3_000055c6_5944                     8       -      -8
> dim_park_on_top                                8       -      -8
> dim_park_tired                                16       -     -16
> net_dim_get_def_tx_moderation                 24       -     -24
> net_dim_get_def_rx_moderation                 24       -     -24
> dim_turn                                      52       -     -52
> net_dim_get_rx_moderation                     60       -     -60
> net_dim_get_tx_moderation                     64       -     -64
> tx_profile                                    80       -     -80
> rx_profile                                    80       -     -80
> dim_on_top                                    84       -     -84
> net_dim_step                                 132       -    -132
> dim_calc_stats                               172       -    -172
> net_dim_stats_compare                        176       -    -176
> net_dim                                      464       -    -464
> rdma_dim                                     536       -    -536
> Total: Before=12668884, After=12666912, chg -0.02%
> 
> This is on arm64 FWIW.

-2 Kb sounds reasonable I'd say. This doesn't even require adding new
exports, nice.

> 
>>
>>>
>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>>> ---
>>> Changes in v2:
>>>
>>> - Added MODULE_DESCRIPTION()
>>>
>>>   lib/Kconfig      | 2 +-
>>>   lib/dim/Makefile | 4 ++--
>>>   lib/dim/dim.c    | 3 +++
>>>   3 files changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 4557bb8a5256..d33a268bc256 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -628,7 +628,7 @@ config SIGNATURE
>>>         Implementation is done using GnuPG MPI library
>>>     config DIMLIB
>>> -    bool
>>> +    tristate
>>>       help
>>>         Dynamic Interrupt Moderation library.
>>>         Implements an algorithm for dynamically changing CQ
>>> moderation values
>>> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
>>> index 1d6858a108cb..c4cc4026c451 100644
>>> --- a/lib/dim/Makefile
>>> +++ b/lib/dim/Makefile
>>> @@ -2,6 +2,6 @@
>>>   # DIM Dynamic Interrupt Moderation library
>>>   #
>>>   -obj-$(CONFIG_DIMLIB) += dim.o
>>> +obj-$(CONFIG_DIMLIB) += dimlib.o
>>
>> I guess you renamed it due to that there's already a module named 'dim'?
> 
> This is required to avoid the follow recursive dependency:
> 
> make[4]: Circular lib/dim/dim.o <- lib/dim/dim.o dependency dropped.

Aaah I see!

Thanks,
Olek

