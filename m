Return-Path: <netdev+bounces-180585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B1A81BF0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53716885560
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4121ADC7E;
	Wed,  9 Apr 2025 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtNZziK+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901E259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174226; cv=fail; b=f7DO9W04Z/Z+NDOy36mSgTnOs0oRl9HQ5VCgyz8wmEwRuMSF/iOM9HJwqnpmUinGjw3smqLs+s1BaPUKOpmbXhyNpp0cb/byoXDWsqyAUw1FAJcL+5L1muHmNH02xW8IE76MmowqJ9vd3Z674toV4SYlDdIXjxodliEZyvfMpkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174226; c=relaxed/simple;
	bh=lkm36V9nGSw4Lu/sD/Zf8G44nDGWZSQKDfVIFMhlkns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWerA8A8T7xwA6IEtmOQSm9a6olBbl1OIuMgvEgiHCVdfBK62WUd5lE40e9yLicySWXtz85qcwUVlxkcAf9zNkyuRxvZUvIHyM4gSvVrKgku2CzxibH7fbHD5P9yv3Rb5AidoXCetH9hygwzCOLJ966j8jOI2imDqw8sfwJSjGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtNZziK+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174225; x=1775710225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lkm36V9nGSw4Lu/sD/Zf8G44nDGWZSQKDfVIFMhlkns=;
  b=jtNZziK+WV3tnsO15IbpwNWadhq/aLX2dU9v9wmtRI51nASw/7Lz6Cr8
   LBnnLYbRtTIBteXrTHgvBnEZgaiJoBZkpV6OS/bcVcHaroSvsMVkAvFhB
   3d1wgRF+ZPSC53IsGutyryDNb5SkrLGxEbQmuKGhWN20F9likIfANJkne
   piEF1rMpxR/qVDx6i3EAlnZi3FyR/056xamFJ7cYS58IzcK6KHKoybTSP
   Vt0Rhexr45YT//BKmR1n/0anUYM1bzBR+u8QTBRrCgtR570USoSKZ1301
   fBXU3pC9vIAWlcyeGECRCEFwFr9R5LKS4dRZ3CoSXT66uA0uw8fOGex62
   g==;
X-CSE-ConnectionGUID: XIHlJkjxRdiR3fazQiwt0Q==
X-CSE-MsgGUID: Mgk7qGu8TZSi8FH8xckvFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="57002843"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="57002843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:50:24 -0700
X-CSE-ConnectionGUID: 3+jdj3qxSLqDRXIcJWBlMQ==
X-CSE-MsgGUID: q2YlFgWqRMabYop7bF3iBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="159457939"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:50:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:50:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:50:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtKrFUzIV6WWzblQxWmN+BZ3ddaLFD8VHY/2xmfr0+kOv/Q+toteiKdLnlCg0Pg4O8WRdnoWsIAUB5p4y5Em3PZqQIk9+ipLF20Mid9PK1GnAT+JwfhCeRwxEv8BuZ0915YxgL5HzdfC25AstsNDCXv208etCbLVw32zu2Vciv6zOd9CmAbTEfc9awFHgRBpT7VMax5Kpk/Nzk8N6Nis1yysvZV1b5D2+TkM7pm2iYKsXLXZWpHDrWz7h9uzAbHwZh9heEBTu5GDjRkBWZecOz1xNBWvY+TtJL6Ddfo+ztgt1w4sp3+iitYxNI7q4ssJXZCpS6bekLfRxhIhBrJuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNqWL3O6Zopio1NNBnMrnP2sq1Hd83xlrbV95ebXLes=;
 b=YdqNGXZ+anidoSoebz21cetaOpsjFvn2goH2givtAHhlhiAl92Q1D410+k2Dcown8ucTeDPW5jIQYYsKQzCV9Bl4RY05DYnBoZGc/pfCGMRGllvZr7PyjDIZVa0zGz8yOCNmbE03DAo2gKkeBp8H9nCMgG+Jd5yR8f3YHZNHWt6FAhQl0AttoMid/AZRzqJyjY2xuBV36UCP5AnQ5dA/Vygs2myeg9sHDOKw7UcuCYevhhZRj1XDMApW2/XOnI0dpl0XDSxu6tcsbSSAaPV/7LQRnR2g3Pw5m/4N26clYfwdHCt+np4cqlFzdL+vAtiBWcnhtUb2ocmJrbpr4fGdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 04:50:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:50:04 +0000
Message-ID: <0d79c0aa-0e48-40f9-93eb-7bf3a0f4c1af@intel.com>
Date: Tue, 8 Apr 2025 21:50:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/13] netlink: specs: rt-route: specify
 fixed-header at operations level
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-3-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f056cf-a253-4f92-7173-08dd7721fea2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTNGUlR2NHEvSkhTN0VTalZYRG8zMStDSitqWSs0Wm44Qno1QzBCR0xKTmZU?=
 =?utf-8?B?OVJFUmhhR0RPc25NTTZJa1hmK2NmRWV2VXJIMVgvYmJ6aDVFN1p3SlkrSWRX?=
 =?utf-8?B?ZlJrOU1ZU0pvVVV6Sk0zY3BaN1JBOGhKdHVxTGtRa05qaG1YWVk5eUV2dWlq?=
 =?utf-8?B?U1hpMDM0VXhTNmZPeDJMaVQ3ZGZvSmcvR254V3hIcGNjdjJTdWdmRWE0T2xD?=
 =?utf-8?B?NFNCSTZsNUFyN2lFVElmWHZOSGE5b2wydTZQVk5qZnBWckJ4enB0UTRoT3h6?=
 =?utf-8?B?VWtXRGJsaFpWb1o1Mlp2bzhHcVFwV2NVdTdCd3ZTSHR5dkphRUMrUU8zU1F6?=
 =?utf-8?B?MFdGejF3dmpkcXNlSVN2a0lGSS9tRlhlOFhLcFk0RGhCYXVaTnFNNkZHNnFw?=
 =?utf-8?B?TjlxTUhjSXdUOEN4c09jSHFGYVlBaWp0aW1oam9GR2hXVU1oM1FxbFpjYTAz?=
 =?utf-8?B?UkF2amg2aitYU2I5MklHbVprdkFybWpQb1FlU0ZkR3pRcDBUQVZSZHNMcWZV?=
 =?utf-8?B?d0xOV1hqdG1kWVhIa3dmenNkVmo3L253c3hBMWhTN2ZlclhQQ3lPNmo5VHU2?=
 =?utf-8?B?NXJQanhzdkZ1NnhZc1VpLy9qZkZmS2FtRlphMzFCWnd4THpFV25VQjV6cTN0?=
 =?utf-8?B?OEdhWlNmeWVGbTNoRmdQWXR0THA2c09EcTNRWTdIVFJSbGdqRENUQW1IZkpr?=
 =?utf-8?B?bFd6SGxxVjkrTm4ybWZiSTc5dFk2YkpQNVA4K25MdmhXemc4dms2bGpuTUdO?=
 =?utf-8?B?S2o4QjZBSkZCcGNRbTU0bWV1bjhXMWZPQmFsZVBPbXg5WHdvZHMveVdBYXVv?=
 =?utf-8?B?VHpqMHFzWEU4Qllqcit3a2pvV1lCSFdQTjFybHVqYjJPVWc0M0JOM0JHRlBs?=
 =?utf-8?B?cVljeXJNRjQ1MUdqOU91SUp6TjB2WG1Lbk9NQW9VR1cxeitnTGtSOGt3L0tL?=
 =?utf-8?B?Ri9PN3JFYVJHRDE4QjdqSzlmUng1ZC92azg5b1dvTE9iSm1qVjJUOFBHZVB3?=
 =?utf-8?B?VVBCdVdVaE5zRWlIM285RzFBeWhXa1hZcHdJOTJzUHZOSnpXN2pGb3pmSGdH?=
 =?utf-8?B?S0lnVG5vM0JGSno1aFBSWTQ4THlHZXphZ2FCTUlTdmZoME52cDZTaVE5c20z?=
 =?utf-8?B?MndseTl2S285d0FnVzlNekFSWmIxZkgwckFmSWdSWVJWRmxzSGdXQldNakc3?=
 =?utf-8?B?Ulh0dDJNRHgyazMwUFdCeUpOeVJGRzZsWmw2S3IxZkxKYU9NQmJPeWJxZzl3?=
 =?utf-8?B?bGpqVVpWbjRVdGFmaFFDbGZhQXp2RUpYSFEyb1Nzc0I4MUtTWEdIVjFlaUtt?=
 =?utf-8?B?R1BDN1pXbS8yZUx5WWlvZkJEOVJUNWh5cGRDUVFMNjJSQXRINlYwVUtQbVdv?=
 =?utf-8?B?d3hsbHFyS05STVQ2ZjNpay9OUjhqeEpFdk1GN1FuN095R21oc3U3TXhxc1M1?=
 =?utf-8?B?TjVvNVA4Zmptd3ZsRDA0QXRFOEFwQTVNVmgyL3J4dkY4WGpWZlVvYmF6THZI?=
 =?utf-8?B?ckxCZkMzVG9VWXUzQXJubElEbkNLQllreTQ0Y2dEUG5DS2lxVjk4RzUzYWN0?=
 =?utf-8?B?c2EzalFKeW1LTXBMSVpjWkxZdzlFU0tFVkxQYzUwQlJyNHhPeWx3OHkyOVBu?=
 =?utf-8?B?dmw1Y3RFaG5NL1pwRThlVFFxTmdrYWpNRUpCWUZ2Zlh4aGl5RytaU3BSU3Nz?=
 =?utf-8?B?YmRPVUxlTFlNT2pQdHdiZXRacmhmdFpta001bGNZY1Y5MEwvL1VIUmJrVk9W?=
 =?utf-8?B?Rzk3ZkxoZDA1MTVMSnIyUGE0bU1JYVpKbzRwUFhrVWlWSS9IaHZQNlNVR2ha?=
 =?utf-8?B?Z2h6YWNpZWFvNEhtWlYzM0M3UUhucEVWUDQwNlZZUEhqZVJ5S2ZSVml2MnYz?=
 =?utf-8?Q?kZo+RPM7bP5Fh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJyaTFadENpQVdRNmJxU1RYS0djUVlRNkFsL2NmekdyKzVPdlhnRFBtMVMr?=
 =?utf-8?B?WFBRWmxXYkQzbExnS3pqSitwM3lKaE03UkR2eWFicDlvNnNIcy8rdzdhb0Vq?=
 =?utf-8?B?L2k0S2FJb2RQRStTSlpOck56dmF4bkN2cUdZRXEycS9pMEgrVUNHbWh0d2hw?=
 =?utf-8?B?VXdSc0FUWnd0NzE2TXQ2eGlCVTRnMXh5VlA0ZmMybjJSVUY3dEJDaklRZS8y?=
 =?utf-8?B?cTlJUE1xMEplWVB5bldDc3BpQ0d2N1ZybkNtbCtuY0F3Y3VRdVlkZHVYdThj?=
 =?utf-8?B?eFFWcXVxby85Qjg2UlhvcDljTFRrMkhwWHVaRng2R25zMGQ5RmlocmtVZHFS?=
 =?utf-8?B?RTlEODE0TWVJZEY3OG55Z0xPVTV2K21VMzA3Q0E3eXhFRGJQeWtHVzlQMnVS?=
 =?utf-8?B?dFJXUVN5akQ3THpXN1NLZE83N3h4bk9td2o1bWt4VWhkemxhcjBpUWJIUVhk?=
 =?utf-8?B?eE1jdzlSVUZtTXZTRC9TUXdtS3cwaVo4OWVYeDBNOUR3bGhLVDd5NzFIVzFp?=
 =?utf-8?B?MnE0U21BaTkyUlFwTm5waGVTbHRpVElxSnJFZ3UvaXVKNktGcjQxUGxqNmpJ?=
 =?utf-8?B?eUtMRENmdU9lYmdpTU1GMlA4c0NVOVd0R1psMEdyMmNyMmJEN0pVUmhVTUtu?=
 =?utf-8?B?WGpabUZFS1BhdjZoRWg3ZHlwYzA1dlNCcUozYVMwRkZkUlFQdE4wK3ZKaHky?=
 =?utf-8?B?WDJOOVB3bkJ6RFZXTzFPUE9ydFZKVWpDd1VkdFJJK1ZGZWloNnV3UXVVZTVC?=
 =?utf-8?B?clp6S1RGb1krdHhjVFdoL2UyT1kyZ21pRmdFbUVyZzg5dnlhVW9PMUJUNzZY?=
 =?utf-8?B?NkYzWlhJZ2tPVFMzZ3dJWVRZckZoV3VaRlIwZFRwZ0NHMFcrS2xUdU50SGFE?=
 =?utf-8?B?ZE1FWHZnejU1eDhKWTI0UVJpeEk3ay8yemJJa1NpM05xakpRUGpNYktTb1pq?=
 =?utf-8?B?ZFZNaDJHUWtyblV0N3c5NXVjZVFjcW5GTy9ELzdUNEdBRjU4MzZwckI5Y3p5?=
 =?utf-8?B?bmNyaUdLSk1SeXN6bjNxY3NBSUVjWUUwUUg2bGxhRXV5SjdtOXdTcU5ONHI2?=
 =?utf-8?B?UGFuVG1iZGM1QUNnYW51VUpnckYrWUZQR3hMRGJ2QUppY2NDZTQ1STBhbTFJ?=
 =?utf-8?B?T1A4VnhuZkdDWkNTMmdnamM0bU9rM2c1TE9FQmZoZ0txTFYzdXFxbmNJdmhS?=
 =?utf-8?B?aUY0cG5KRzMvaXh4a3JEL1VhVVYrMUxIUFQ0eVk5dXZGUXZTOXhXUmw3cjBw?=
 =?utf-8?B?SGEzbDZtZks1L1ZqVlk2dU9HdjVoajJCRW0vdnZrc0xjL3hjZ3VsWGN6MnBP?=
 =?utf-8?B?UHJETXlRYk9Xa29aY29BU1Erdm92NHNwZjVwQThML3NNVER1VFRXV3dWSXVT?=
 =?utf-8?B?aWladVNJbGJOTTNteFRqZHhtZnJieFRVTmd6NmtnUGI2NnFKTk5tM3dadXBn?=
 =?utf-8?B?RnVtMkZlTEtUQ2kwenZKMW4yK05yM09aQlZxTWswWXVMeVVGQ2d4M1k1dElD?=
 =?utf-8?B?ZWM5R29lZnhrNWcxdC9LVkE5M1N5R3BhNmtHZlphMlpBaUJEd05PME4wN1dZ?=
 =?utf-8?B?ckhWVmNzT0NhMXh1QWRCZGpOLzdyR042SUlSTE1EM28xUVg2OGU0anFFQmM4?=
 =?utf-8?B?b2FueHJ6ai9ucGRucDVlYU5rS0VCaVVVTFB0VlNDcVRQMW8vU2UyUFc3UVF6?=
 =?utf-8?B?TE8yZFNuS0NoSGprcEIxbmxYU1Y2bG1CeWRveGF1T2MySHZSRU1ObXhIeWJq?=
 =?utf-8?B?TG4yVjNlUHVUcTZMaitzWE1ZajljUi83MDc4RTdxaGE0eFFaZWVPZnBUWHMw?=
 =?utf-8?B?NjJDQUFVZFAxbmJMYVhOYU1rK3NzRVB3TlBUVmVWVG14OVBxMXpkMmtXRkhX?=
 =?utf-8?B?RTRoUHN6UHVhSWp5OThod0R2UmRKOGZXY09IYWUvM0dCTFowUG01blc5UFlL?=
 =?utf-8?B?T0Q0VzNVeWtZZ0ZyeWQ5MGthQTY4aW9lV1QraENJMitKNkhSUmZKMVgzcGt3?=
 =?utf-8?B?Wnd6bXU4dHZsK2M0NUNYWHplcTl0empORXVHb3k4RVdSb0xabTV4L3U4R2s2?=
 =?utf-8?B?M0FiaTIxOHpJWkF3MzhrUnpTYllDUVAvUGZjaWJTeU5NSG9lbVMzVDAzUUZp?=
 =?utf-8?B?UktCajg1eWpaMTYra1l1WE9HbkFHOFUzSmhCcTY1M0JKcUhYclBxNVB1QVZK?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f056cf-a253-4f92-7173-08dd7721fea2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:50:04.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5DJRm/3K0OAF1s2Bux+Rkx209r3RID3A5j11L6EkLvp+U5qCFCAZNLNejrCDbpwiFI1XejMetJl0q7Qsd6qXNu7wznVItskXq/0LYy5D2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> The C codegen currently stores the fixed-header as part of family
> info, so it only supports one fixed-header type per spec. Luckily
> all rtm route message have the same fixed header so just move it up
> to the higher level.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt-route.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 292469c7d4b9..6fa3fa24305e 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -245,12 +245,12 @@ protonum: 0
>  
>  operations:
>    enum-model: directional
> +  fixed-header: rtmsg
>    list:
>      -
>        name: getroute
>        doc: Dump route information.
>        attribute-set: route-attrs
> -      fixed-header: rtmsg
>        do:
>          request:
>            value: 26

Nice. This seems simpler.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

