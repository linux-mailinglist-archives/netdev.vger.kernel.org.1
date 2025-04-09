Return-Path: <netdev+bounces-180592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D036BA81BFA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960C31B67065
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B71D63F0;
	Wed,  9 Apr 2025 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgVg2hrf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACA259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174783; cv=fail; b=UH3Qz1hyDOVE/vpwr/1D3a3jFmpLLmD1JjjQxprIEsqyLaxvEfu/Iaz2duPxj0iW+mo/7Xc6LyYM0ZNSpSHvSDYg3NdnRgacICYXv2BsKnR1Vgeb/Q8l/GW00Z0gvI1UZ3STF4FKgvJRNouzpbAbCzxZBovfxyxe5XgT9vcPxZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174783; c=relaxed/simple;
	bh=o8vDFcrEINZf92JGjqeUYavGrYWFKt0GbIvxTyXAaQE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeNRDhAtfxpVxWgEkhaOUHf8afaBC0F+D6RXSH477wCz28RURNoycfx4lJw5kMcx2PQWeDOarULLzMlKu4PB29mW0jFLlG4rDGIxEAfRhxPfLXehQWr7jOHzOJ3WBy9ZAQOeK12gGcMvsAfKiq066JzGQgPnOqnXmRskzhyOQp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgVg2hrf; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174782; x=1775710782;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8vDFcrEINZf92JGjqeUYavGrYWFKt0GbIvxTyXAaQE=;
  b=UgVg2hrfkZ/xI5ExRwrwDnQhtfByRxdfDyxxejXibjRjLbjQCDROhMhw
   yM3bAeIPXVoyyzZwiRdmvOMUoJgdukkiS1JdWniS6H8WVw9DUYourpBUx
   zmk0c2exr3PWlYiL06unBGbdm2n4F/4eB7Xjb9gRbRVulzL7wStgKSMkF
   MwgaQO555s5Nn9beuAhhyegY07P+F00CvkTdDY/o1LmLn8UAAWFqESsh4
   6fX/HPk1PIhHC2J2O1qz/bvU6FNHDbklugNqgcGVRnxV1xu0dqlNc4UU5
   IzGi2fYLE6jEB6EkBBhjTmoIKlX+0dH8jlyWD+dGu9tNDWAxGrkNcPHjH
   A==;
X-CSE-ConnectionGUID: nJt3CTSWQfOWoSzCiFAZCw==
X-CSE-MsgGUID: ZM24DeEkTk2z2Zrk4gqW/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45722111"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45722111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:59:41 -0700
X-CSE-ConnectionGUID: 13TP7DaoRKSHHo7jRr04mA==
X-CSE-MsgGUID: B3mY9A6CT8+xMfpD0TuAhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133675225"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:59:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:59:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:59:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDHjJOBmtfsgqF+WuKxldwB2/2L9/xH1oYTPwkv4cqMuOw1XRHttpM0j6DYIposR5pnlZoQXOE5JwMIbNnHJKaPIj0xK40xCkBri8bo3Nq5vPkaE9HbZhxMs6rEnkv9XntfaZ3q8z6T/D4NNp26NlcU8ilA8uC1Dy1ejL1cqXhlETpVfKM1C1nYnSk4HBCTnmtmIlHb0D4eoXrKfgkIgQ8D16aUONsPX9W10H0fLnjcJdxli1t1cqLEkOQQxkGCexeewbZ4L8QqfadUwjSUtLDW6fbnT6iEkhLTKglw/qmX8VGCpn4IgDWl55bhi8s+AbyqxecXWcd1+QdsfRcWSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6UMpY8SnJ0DhCcWN9XeFDVyxVBFaw6TOwzpBZk/4q0=;
 b=BIKmln16VpdO+NsGNdWdK6DyY592I6f/hE9q9nnCHLxiJ7kexRbkz34cJy/r1H7whSldMZUMnrN66yWZE02oOPcQmod+09VIwuFoczI5bp83/blurAL2dyUPPoG/FXSaGUU4gZUFiMioIme7hz+QsxRmYFngaZUHxLfbM0tg8e9sp4L4lnlFuJMMc0sdtQJSUrT+cEaIuAY0l1oO7Frv+VcgwKHWWVjcYdVZ96TYcgM/VhKaQ8aWpCN//R1VZwNJHlhxNtww69WJNURGE2uYIqTuSN7plk/1rAkQZjeXFVJmOJIDaaoM+zN7WvMCYr79st/opZiSiCO34awvG266/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:58:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:58:54 +0000
Message-ID: <1c855f1e-8d7d-4c01-889c-533733d54174@intel.com>
Date: Tue, 8 Apr 2025 21:58:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/13] netlink: specs: rt-route: remove the fixed
 members from attrs
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-5-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-5-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb4450e-ba96-4702-5d48-08dd77233a13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blRWeHovdmphZk00WU9WWDY4aE9VUHZxZnVZdnlwdDFpb3ljRHQzV0IraWIr?=
 =?utf-8?B?VHJVaWNubVMyN0s1WXVJWHZFWllyRVVrOVRBRXVYSDc1SDRLRkNQZFdkOEMx?=
 =?utf-8?B?NElhSTlYYVV4UHdtRFhDaU9aODZVY3FxWFpsT0xiZXRrWmlmdlQwelNnNzlT?=
 =?utf-8?B?VGlib3BlVkEzQnNtVkZMMUtyaGxVYy8vQjJjNEg5d1NZUXg1R0JzMkRVN1kz?=
 =?utf-8?B?SjlMb1k0dTJTMXF1NnZRVy9rOEZUZUFQRGF1N25vS29rdUp6bERobnVtUUJE?=
 =?utf-8?B?UjJYN2xKTm5IVThIWXhydU9SVTZXdzF0eG9iK0UyRmQwWDZBTElTRmRXY1dr?=
 =?utf-8?B?SmFxL3dlV2hTaW93WlRrM2xXb0dkNjNOK1dXelhpSU1laVJNUEdmSVRqeThR?=
 =?utf-8?B?MUZCRjVUQktJRDArZEpXbWVFQ0R3SU1xc1dCYkd2K2ZLQ2hvNVRwRU5iR2Jz?=
 =?utf-8?B?R1RVcHkvdTRWVERMNG5PSTE5RjN0TFhSWmdKZ3prSUNsY1BoRzJTVUl1cHVu?=
 =?utf-8?B?czRKallFbjJNTWVZc1djb1d2MzBaenVLc1ZZNzBwU25OTXRpdllQVjA1cDZY?=
 =?utf-8?B?WENZdktGaXJKQlhaWDRWbFYyQ3kvM3IrUUhPSGplQmEzWWlkSzU4cXBaaktj?=
 =?utf-8?B?WFY5d0FudFNFbzhwWHNjZ1QvUFFhT3BGckUwYXRxWkdaYk9kdGlVbk5xZlZm?=
 =?utf-8?B?dWordkc3cWVlS1JRNlZUNU1IcHFWRjBRZjNmb1JCV1VuRzg1a0hIYUYxdVRi?=
 =?utf-8?B?MUl2ZGlVSkFJa1BJZTVpdWZQb2o2WVZiWFhhR1hUQU92RXV2bGsrQ2pYbUNt?=
 =?utf-8?B?bWwxdHo2QVFPZU5CUUdGd3FtS1kycXJGQ21tTTRITUdKdVlFYm1NZUN0bmM3?=
 =?utf-8?B?SXAwUytjNHU3Y1c0aFpLRDFYeWlmaDR2dE9ScCtZTHhoM0lYeHQ0a3owd1d3?=
 =?utf-8?B?Y3gwa1BJWmNRV1VZQ1JaQkE1UGozZ01OREtJdHBpb3IxWGI5cFp5SmRzM2Rz?=
 =?utf-8?B?OGp1d21XNnh1YkRJdjBIMGpMb1hiNE9aVDRLREpoZjBSR21idCtLNkVlMVZa?=
 =?utf-8?B?c3V4ejRIQVlVYWliQ2gyaUJodTdOakFUSVlRMmtlak1iK1pCTGwrUHF5cy9R?=
 =?utf-8?B?U0NtU0tKaWVtVVErQzlkN1JGbUpPY1c3V3VSM1pkcUJWS3BTNW5SbGhrUG1T?=
 =?utf-8?B?eTNFcTZmVTRYUUhUcUViMEJHNzQ3dXNOV0t3VG9ocXhCcXp5Qjc1Y0xUeFBC?=
 =?utf-8?B?cHcwZjdHVG8xSVB2QnFPRGw1eWNLUzNPS0huT0ROcFhlWkRKQlFVZUFCWUV3?=
 =?utf-8?B?aGpDVHN0NmNvemhkdUg1cjVmSVBXVzdRQlBxTXQvRWpKOFNSN0dQQmtIZkI0?=
 =?utf-8?B?M3JTYzFUcGV2TitZVjNQaDVTUzZhTUJra29PR2tPTXFzT3RLanBMbW1XK1Jn?=
 =?utf-8?B?ZDNoWk5YSzhxQXVFaVpxS242c3AxdnNQYnpCVktPdDNNWHdxOG5OWkVwQml0?=
 =?utf-8?B?OHFzb2J5d2c5TWcvSGdJR29HbkRkTklDdFM0NzVncW1rV3o4a3pFQ3IrbzFJ?=
 =?utf-8?B?ejFHUmdhYXZNdkFlMVpIWlQ1eWUrMmNQc0NBcUUwTG53aVZxdlM1c2N3S2ho?=
 =?utf-8?B?UklSYWxlK1pXMkY2clVkc2hURm5ndWJ2Y2ppRnBNNyt4bktPSTZ6MWNXOXRF?=
 =?utf-8?B?R1pLOHkyS2cyUHM4NkJBeG5ybVowNzVocnY0alozWGNtdWxWT0E0SzlTYWFI?=
 =?utf-8?B?c2YvWDJQWDhrTXJPdUJxeFV2OVE0dHN6RVpMMCtTbS9ERnVFck5MK2ZadFE3?=
 =?utf-8?B?TWIwTjc4ci9DSmJUbEtKRERNYVZrR2lGZWdwRE9JYmdUZmVNM1NqMG9zcmxj?=
 =?utf-8?Q?Q79nqgZdtTVtW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhSa3B4QTE5NHBMY2p5ZUpmTTdHaW5PNWpMajdiMndnbEw0WW02YTNrT3Vp?=
 =?utf-8?B?bXp6MFBwcStVdWlMS1lJVUVMdlhOZzlYdTNyM2RScEt4REtxTVNxNEt2Z0sy?=
 =?utf-8?B?OWN6dmVQSEl1dlZ3aHlMWFdKa0NqK1JyMEppblpKN2FteFhHZjJuVEVWQ1U2?=
 =?utf-8?B?V1RRNndYK0t5aGIwUTc4YU41K0xJbEduZGhQeSthZUxFeWdzMVpEblRyQ2tY?=
 =?utf-8?B?ZDZJUTJKM3NwdnZoSlJCd3UwUVExYUJXUDdmYVdtYmp2MEd5dXZKS3RpRnVQ?=
 =?utf-8?B?czdmWEFJWHdBN2lSUFJHa0kyMmNidGlLWUJPbkJNZ01IVk9EdDVxTWx0Y3NI?=
 =?utf-8?B?UUt6cjFDK2hPbXpRTGRiaVY4eE5BOHl0SDZsZnA2bUdUZ0lHYktsNWZGRWlQ?=
 =?utf-8?B?ZGVhRE9pUVdYSWM0QzVhVU1VRllhOFM3WkRNOXduN0VwSzJMbnJFVUJUZ3pW?=
 =?utf-8?B?aXhvWWZseXdoemRUVXZQeWVnMHEyV0ZSWlhmNjcvT3JxdFR3Ti8rMGlzYmpl?=
 =?utf-8?B?QmRwVWIyQUtESDBZaU5qdk4wQmJtSUo3ZWxuWXltYmhXUmlzNUtJWG1zUjZH?=
 =?utf-8?B?OCtpT1ZxZStSbGI4aHRxcXBCN3pXdlRpejRnTHc2SURrWk5JVzJwd1E2WW1C?=
 =?utf-8?B?V2lMTzNjTHh3N05JUTFIczNyUDRFd0VKbGVBTEZ6SENEN1kzS3duYVhDSTJ5?=
 =?utf-8?B?WFpFQm02Z0NjSW42YzJEM1piRXd1NVBuUGd3Tm9JMGU5REV6S1lUbEhrc1Nm?=
 =?utf-8?B?NmN0c3VxL3VSbnVPT1QyNmRhMVpqWUxrNlN0M055Q0ZqdlVVc0UxRWNabXlK?=
 =?utf-8?B?TlhUcTFYRHVWOXRjVVlCanMrWDViUkJ0UFNJQ1diRTd2c0FYNXhIUlYzZmZG?=
 =?utf-8?B?NXp2SHc0TkRDMFQxTEN2aCtPYWtINGV4U2I1TU5oaXp2TzU3M1FuRHVIaWVF?=
 =?utf-8?B?RXI3LzhqVi9IU1Q2eHZpZ1RWMHJ0czBPc09vZm42emVzZG1WdGVwSVk0d1BU?=
 =?utf-8?B?djlGbFc0ek54YkF1NmFPalB1N2pJOUV3OU5CQXExNjlHT0pYMk1Sb2RCL1Vs?=
 =?utf-8?B?NGEyQjd6SmFRcjkvT01CNHhEUFlyaDdFTmdTQVVGQldqUXg2YU5DWFdYWXE4?=
 =?utf-8?B?MVlmSTI0bDczWGVGcjdXa3RVWEZzZWxodm9uZTVBM095eVVoU3lIT29haCtC?=
 =?utf-8?B?a2gvQWwvOGE3dER3bEM1OGhydHBDamVJTEsyTm9FSVN2anUzanBzcFhyalZa?=
 =?utf-8?B?clBFbHpSU2FRZmtxSzVEWGJnR2dJOGcwTHczQnRJTitISWloLzZjVENpcENp?=
 =?utf-8?B?ZTU1WmkrL21IR21aSE8vT0d3V0MvbjdvL3VzREQ2Yjl5V0ovRFRJOWV4N010?=
 =?utf-8?B?MGFMdklQQThPVXpyNVQwUUJzaUs5eTl6dUNTc0NwQ2hKeEJRYzc5R0VGWU1j?=
 =?utf-8?B?WTdLMDdRRkNwVXc0ak5Nakk2Z3c5OGE1cmFIdzUzYk1taDlwZ3JwNzhET2kv?=
 =?utf-8?B?a1Zva2FuTS8xa2xyb0tNNXpWbDRObFhtWmtMQzV0QzhOWjRnakFpdlhsa0Fp?=
 =?utf-8?B?V0FHRTZsU1E5aXpKUDlOMzJPaWxVYmlObUxKcDFpbHBLcjhmMDhGamt3d0Fv?=
 =?utf-8?B?SUxiR0lNL3o5UE5zU1BKUHAyUEVaWWFlcThNRDVKZ0ZoYlhXYy9nZ2Z1dSs3?=
 =?utf-8?B?dXp1QXFLeVc4bFVLWDZaTVZieXlkL0w3ZFB3UGpBcC91cjMwbXlCb2VtL3FS?=
 =?utf-8?B?dUhESkhYN21Ga3VjemF0WWVGN1BFbHlkTWNUY0xSaFZBUE4xVHVDLzNXRUo1?=
 =?utf-8?B?RmkrVE5EMzA5a01yVkxHZGdGT2dZMng5bjZDOGU1TkdFZWRtT1pVV2ZuRUVL?=
 =?utf-8?B?RVpBYUxmdXZlQWE1ZkxsRmwydGQwRlIvbG53T09KektkWnpvSVBpcVZDTDNs?=
 =?utf-8?B?aFZDei9IWmxjYXNzaXAwaENkOVJ6MWo0aU5GN3Yra2xFSjltZnhkVUh1QzEr?=
 =?utf-8?B?QWR4bVl2aUhJOERiUExETGVxekdEZkVwMTh3U2EvWUYwdEQvL015OVZhQUcy?=
 =?utf-8?B?SElzWTlzV1BzWDJVbFZqaUJRcmMzUWZPa3BxYVJvL0JMYlV5em1GYVE0ZTQw?=
 =?utf-8?B?My9FMFpyWTROeFIrZWFIMmtjMForMnAyWUxPZzMrNmJycGJyQUlXSmZsc0gx?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb4450e-ba96-4702-5d48-08dd77233a13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:58:53.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOXVR/H/3Ba3JlGS87zA2mmziwMsUiuzwFjToUSXbD3J6gUD6FJfe1utWt1AcHAwiCREPqLzPrVQDt5BDE7FuMZLPQ5K1GieE115CxtiHJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> The purpose of the attribute list is to list the attributes
> which will be included in a given message to shrink the objects
> for families with huge attr spaces. Fixed structs are always
> present in their entirety so there's no point in listing
> their members. Current C codegen doesn't expect them and
> tries to look up the names in the attribute space.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

