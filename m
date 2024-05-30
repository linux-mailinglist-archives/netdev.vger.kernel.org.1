Return-Path: <netdev+bounces-99512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BF8D5195
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C217E1F237F0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9D347A7A;
	Thu, 30 May 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3hVBq2i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C421350;
	Thu, 30 May 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091979; cv=fail; b=IUAfX/bnWszh9W1trDPtdcbwlyuRyYuR82qcvjDL9rtvXnbMtmrGFQWRNddBDuVPKuGNFeQa4p5qc6Zh+OzFuSaeZnW8zlHZf4NysN1zG3kiO+RMhaaKnK5f6PKEb7k4b3o2r2pxMHswu2reibzMfCAhujDoheTnKzDm8pdnKck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091979; c=relaxed/simple;
	bh=6YyX/LdigdEs+MbSu9d+yhVYCVwFibwkJSE138eYmgE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRDevOYZTJn6uDFkFDYzXZab+BBW8m+hQXBXO5eiWFCYsJkqh0/QCiS6+7lVTEraklMdel29kionsXp4sIK1zODXPO69GDRv7rnj3S4I8YNnKy3S8pJvLSmwyq6JYMFb8tocDMud1XU+t0A3oOSV6M1FJOVtHLGWchYc8Br1WFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3hVBq2i; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717091979; x=1748627979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6YyX/LdigdEs+MbSu9d+yhVYCVwFibwkJSE138eYmgE=;
  b=W3hVBq2iSW4grRIeGQvmsbEr0wYomqeUXlv2Pr5BTFDzu/PviXhoiRl7
   YdfTU0ThZZ7tlyit9UA2yah+Z2rzNS6xV2xl4GHXEurcQ7Z+zq+9Oqp0v
   WSWzNFYWtVgeE27QI4Cm3DHyrs6k7SNg57bcRARfNQu6wbDY7J/ODq+Qd
   OLRwI3mP8QIdT+HcEnatyBUgzLI3BEhREbttb7X4XbQ0C2mBjGL+ZRVm6
   dRFuIdGt2z/s7TxobabI558M7r7vLtzDQsIm/ZgISo6n10xDHgqf6WRKs
   /0/VaiwYj15e1mENVsN6hMjdTsxZTAVFaLmCgSnyumseGL0ZDZHSnR5Kw
   A==;
X-CSE-ConnectionGUID: khjOmSUwSmqlSwO/f+WhdA==
X-CSE-MsgGUID: gf0i0qV9QESCXTVNOttAxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24264652"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24264652"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:59:38 -0700
X-CSE-ConnectionGUID: gB3vjZCQQCCIu9K4qxb7mA==
X-CSE-MsgGUID: 1jR43VxZRMaMOZx+fVtL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35990750"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 10:59:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:59:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:59:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 10:59:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 10:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu44K3mxmbnaa2Zs1sv6ukuL8Ynh1in5dawUnXNVj9B5RhJ64/vPAvreRDlaAn94URuhl1pjQybqhsTbFBrigegCvJduyQve4jF0cCbkyhhA3o+0Lt9hBPh4BcaxP49lDm/ZlGRmTJGa32E1JS/Mg6baViTKG3xdFiaVWyHjVnW7+aeFSYtu1JiTONHdyHP/bEByvvvoq/PYYd/BBnUDARM/NotIsKAOmMqGzsLv8rOKHQxnw/ahBBnY/CL96m3YKLxk8+kteZ9Pb6SQnI5MnbJH28WvDs/jMPXksZD8ThvZ/jXfujR9YrWmd75L1vKXeBtlfYlpRPWWrouZeben9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVN/+a28tXssXmGteq2jM4oXEwt9EhMuTOHcMIsYKHU=;
 b=BaLUNzoelg2EWW9P3sUuLCo9Z3W+d9Q9thux2xiNMsBkalf/m0ajA561QxtrTCZGX9NKl0whYDiACBduUHZzeU6dRL8CLB4zqU3RUXClSnknF7qmO4Kdc9rSthDGP7IP6kXFhWNOtbjYY0ULmQZw01zXedBOGAaMq5RXYMIuB0k6ySWe23CaPrJ3KxtheZVek4uydZIOp01Gq/aMXdWRSqZgZHXg8XWWrMcy1qJuaItyUaUWi7hlZw/I7HQ2EPZ3sHlPcCLBEfIEenalm3WeDUPkYpI5w2PLcVjYE+nIk0U7C+ZQCqKBVEBZ7Iy+aEJOqt25zUzAFEuG6ZMc3rFsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:59:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:58:59 +0000
Message-ID: <22de594e-2e2b-4659-b88b-3d0e4c99e4fa@intel.com>
Date: Thu, 30 May 2024 10:58:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hns3: avoid linking objects into multiple modules
To: Arnd Bergmann <arnd@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, "Masahiro
 Yamada" <masahiroy@kernel.org>, Hao Lan <lanhao@huawei.com>, Peiyang Wang
	<wangpeiyang1@huawei.com>, Jie Wang <wangjie125@huawei.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Guangbin Huang <huangguangbin2@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240528161603.2443125-1-arnd@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240528161603.2443125-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b045a0-56c5-4457-8c65-08dc80d22ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1M5TUN3cmhhYjc3YlZtazFCY0p2MHViTkxlZUVIaHdFalVrckZ3bTcxNFg4?=
 =?utf-8?B?M1JvTWVYTlJ6LzJaVWRncWR0OE4vQk9JVUpjZlc5aFRiOGhURkQ5Y0NrVUZr?=
 =?utf-8?B?aWJPUmFVQ0lucmJjelhUSHBQSFVmRnIzZVp5cG1rT0tYdHdRd2l3M0ZQWEFk?=
 =?utf-8?B?MFVubFF3cGluWnAxNzJaQ21QWjBSd05SanVNYm42RGY4Ui9ncFYwcUJXL2Rw?=
 =?utf-8?B?NmRNa0U1b0RBZ3M2YTB6SERKamxTOTFqSHNYb3V3UnQ2ajdnMm1BSG4wb21r?=
 =?utf-8?B?QzdKR3RMNWRwNlYwQno0NTUzR1F1WGFMVEQ4ZlE1SjhTVDJRc2VkUU9WTVRu?=
 =?utf-8?B?c2RtNUh0TTFLYWlGOTBHTjBFcVdjamZJZ1NidDhFNGlXS1RVemZRWXlJR01C?=
 =?utf-8?B?QnE2VDFHUkt5R0FFN0xJOEJBNEgrL2pYeXBZajBMNFlsL0k5U0NSalVJcU1W?=
 =?utf-8?B?RGVjM2s2aW1pdmVQdHNUbjZKODFUSUpwbmVDenJHL0VvbDd6YXgwQWl4VklI?=
 =?utf-8?B?MjdaT2VVL29KV2M4L3UwZ0lEM3djZWhCSVk4NVpvUGtub0lwaTFEcDBOaUYw?=
 =?utf-8?B?N0NtcU1HamZzbFUwV2cxRkNzcG5FbDRnN0NqcVNObTBMQitPbGRmTjZ2MkpS?=
 =?utf-8?B?YnY2ZndPS1hFRGhSRjJxUlJraUdtS1Z2Ri9ZRlB1dDhRSXV1Uis2LzdQMkVK?=
 =?utf-8?B?N1V0MVVDNC9nUVFna2c2VTZ1emhiWlU4NjhRc0FEN0FqYkxjejZSTmh5Mndu?=
 =?utf-8?B?R2N0NS9VM3F6bTlSQTZ6Y2Z1R1A5cVBBdlZmWGU2OXUwSThWMk0yRUtCS05S?=
 =?utf-8?B?YzJOLytSTmplQTRHclE0dTliMDNDbzJLbTJIOERwUWxveU1wQ054V2dXOEhi?=
 =?utf-8?B?UmRBM21MTERDRyt2Q25mb09CQlFXSXJmRUEwNXNYY05UZVpVcXM5akR2djM2?=
 =?utf-8?B?bWVQemUzcTZNbWd5SUtlM3diVTA4WXl6K1QzZUExZng0N0ErYURoclRvOEZP?=
 =?utf-8?B?dzc2RklXanFaQTdJcDBqcExsL3JuYVVYNWxnWjAvVXdYWFBYc1hZTVYyZkJ4?=
 =?utf-8?B?VEtrY01TY3FZS0o4RUtaNDgrbE5TNGZHaTB5WXY2alJrTmhMU2ZYSEtLekZO?=
 =?utf-8?B?YU5JMW5RVzdXb3ltaUwzQWxXSGdpTExSaUhHNjFOWDJNWlZmWm9Nc3gzcGF0?=
 =?utf-8?B?eldiL1k5V2kwN05ZdVJObkVOaHFmdEQ4b05GMW5JM3FuM3NQRTdTaEtUdWFO?=
 =?utf-8?B?dGx6aVk1aEhVY3VMUHllWlEyZU95N3U3REJha3FTWVZLdXlNWVJydXJ1dExx?=
 =?utf-8?B?ZjRiZTZNSjlxQzJuS2d2TnZRN2ttTGtKNjRFbUMxZ001VWlxVTkyYjdDTmF4?=
 =?utf-8?B?Mkk0MjdEVGFmMTJSakdaQ0FvQU5uUXl5R2VrVGpzMlVzTFVZSzBNT1krWDhJ?=
 =?utf-8?B?ZjBtTGtNVzhFSEthK1lCdEh5Y1FZK1oyTkE5a3BJRWRiaWh5M0E1RkdsR3J0?=
 =?utf-8?B?bmYycFRBeCswY084YVdMMHdyQlpQdVFzMU9jTFJJaTB6TVFZaTBQbzhFRFZI?=
 =?utf-8?B?VVpWWFpoSERsemhnSjk0RGQ0cmdWS08zRGpienR6WmJNemdWZmMwNG1wVy9F?=
 =?utf-8?B?eHdYM0M5QzlrN3VuT2c3YXczU0NOYUQ0YW1ZVzBHclZqdHl0aXpFTE42Qk1p?=
 =?utf-8?B?R3phY05FVWFrTTZESE1tRG5oUXFtbDd2TTFIUVVyQlRDZFNDWURFUkpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnUvenl5aE1kZGEyaDQ0TlZTZ2NwUEpEdEYyYzRycnVGNWxYS1M5SFV4aFUw?=
 =?utf-8?B?ellYaXd6WXlWSHRISURmL3ZqZkxXT2d3U2RTTWlZWG5lbWw0aVRwY25uVjgw?=
 =?utf-8?B?UG42UlJESkk4ZDlXdnpxZXkrMnBsQ1pXMWFLN3d3TjlMblZpYS9MaTY1TUVD?=
 =?utf-8?B?S2tmNmFFanFBRjRTa2V2RkRpWVBwaC9QUVdWdjViYXZoTCt0NUhNTVBVWmFW?=
 =?utf-8?B?S0xKQjVlTm1NbUZNS3VSQUlLa1FEN0YvNkRxbEEwOEREOEsvWnEweW1hWWc4?=
 =?utf-8?B?MXVjNEl6NmFLdk15eU1PVDRXNnMvenB4azY4ZS9OdUs5MDJWaWpyRDBvWlZ6?=
 =?utf-8?B?SnQrb2JjeHRQY05MbUt4cmVMNUxEM3VKdDhPeGNLd2FZc0dtQ0JUbnhJWmll?=
 =?utf-8?B?SVV5TjdyZ0FIdUx1T3I5NDN6R3hXSVZGU1ZxSDdxSEVUcGFSY20zN2hwTXZ4?=
 =?utf-8?B?UGNWbHB6TEs3UFM1TjBldzRFTzh3VUMrWXRlRi9LeEd0WnZtcU1nc3FEUjNY?=
 =?utf-8?B?cmdJRWlkYk5RemZVK3RmdDlIYlVuQ1c4R0k0SjBUQ2JheVc2WlFFSEdLVXhi?=
 =?utf-8?B?UXE2a0kwcUFYM3d4M0dyMis2Q2NmcDNORW1od3Z2cHhmZ3JmNjNFQ2dCRjVR?=
 =?utf-8?B?Vk9HS0NIQlNtVFhjVkl1T1V2OURqME92QWM0QjJZbkZoQ2lRMDFTdUFkMndo?=
 =?utf-8?B?RDFnTVJDSmpja3dScHZBUnBCTVZWc2VWMmNObDROMWVOOGNad3RIa1U1bm5n?=
 =?utf-8?B?QzRmZ3VRNkNTemd0cncyNTFCYTAvK3lWYXp5Z05Vc2lDd1NING93NkRlbzV0?=
 =?utf-8?B?NWM5amVWaGs4a05vNDkvWjFjZ0gvQmEvZ1QyUmtYVlY4NWQzc1U4VmFnNzBs?=
 =?utf-8?B?UmNGWm5kdFdSSjZFRzZMVnpadnBiU1ZaenREaXdGQjd4aWVYbytsOGRlT1dS?=
 =?utf-8?B?NkF2OHVaaEhYTzhjMFRtMEhtTnNuSXZVZjQydUhtNDdmZHRUTnJzN2hveVlE?=
 =?utf-8?B?OE13d29NYkU3bFp3SWJpUGJjVzdWT1AvbVlOS0JVZ1FTWHN1Z1lGODJ0bzd3?=
 =?utf-8?B?OU90U3RiaHczUUlxNjNpWm02RjdmSTBIUnFYQm9Sb3hDKzk5aktvdzFQQlYz?=
 =?utf-8?B?L1I2TW45eGoyOFlKTE1pZW1ITS9hVWluSlFVRytORFZ5QWtBeW9SQkhyRU9t?=
 =?utf-8?B?bHNZbEtwRU5wZmxJU2thY3c4VnN5MkpRalJibS9Id1JaMUFDZ2hqNVVKNG1l?=
 =?utf-8?B?akl0OTg4aVhJdndLbURHQXlhM2FnQWM1cHNua1hPSThHcHVLRm8zaVY5NzB4?=
 =?utf-8?B?WC84YTJLUDVVUXk4WGhQRUMxcHI1cU16Qno3OVJNaDFFWUlGUG9hSEhNUnFS?=
 =?utf-8?B?ODIyYkRENG1oWEY2aWFDemlXcW54S2ZJeFE1R1FZNlNPbXFRc2N2aHNMT1hh?=
 =?utf-8?B?Wmp0SFZYdU5lMVhmUlZkN0RuMFBSZzg3NU9uV3hlWHJneEtwRlA1SnlPM2dJ?=
 =?utf-8?B?WlNZOWxVczZnMHNMQXEwTWFVZGZkVHRFZmlCd1pTZDFNRnJQNzdTMWdVcFEw?=
 =?utf-8?B?Zk1LUWhRbGk4K1o0Yzlva0ZicllaVGR2L3g3dmhKUnFuOEVtT0JYNW5PNWFu?=
 =?utf-8?B?ZmhtL1dYbUQ1bmZJYitwM0U0WHZXaksyN0xMcVVqTDR4RlVxRStjZlhxb1RE?=
 =?utf-8?B?QTFVMVplbmhycStDV282KzVsdStSR3NmODRkYXc0S2NjRzlFTVJQT3NkMDFx?=
 =?utf-8?B?Ry95bVhESW9sUDhMUEllU1JZV2dpUCtIYlFlQlZOUXBSODZuckRMbi9JZXJE?=
 =?utf-8?B?V1ZhR3ovRFk0V0dkbm9aZjFsbWpoOUYvaXgrMi9wbmF2dUFKSHNwQ2poRkRo?=
 =?utf-8?B?a2o1SEtsb0srMkVqL0hQYlU0NllsMHEzY29xUjZmR0hPQlhZRUEyUnVSY20y?=
 =?utf-8?B?c3pjYlZvQlQrU0RkNEs3TU5ySEZraWVCRU5reUVsQWxJcC96UVpPVmhjcExl?=
 =?utf-8?B?S2w4S21Ndm8zNHFKcFByaGMveHc0ZmVNV3BPa2U1anI3Uk1IeHlnVldPNXpB?=
 =?utf-8?B?bURNbElxdklJT0RWRTNNVldnL3FMNm9uV1lld09tNUlzUnVYQlNqdmhvb3FM?=
 =?utf-8?B?ZmFzblR6MHA0akFPWnhFZW84NXo3VWsvTzRnVUs0YnFiZDUycDkvVVR0Znkw?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b045a0-56c5-4457-8c65-08dc80d22ed5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:58:59.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XBunaK/sX3YWw5i5WMD9ndcMM4t1VG5w9gLPgrACV03vhQo7DLShLWTBLPNIqYTMry0Kvog0621v3WURJjxXWqmA4+u/UGTnj3VCD+o9eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com



On 5/28/2024 9:15 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge hclgevf
> 
> Change the way that hns3 is built by moving the three common files into a
> separate module with exported symbols instead.
> 
> Fixes: 5f20be4e90e6 ("net: hns3: refactor hns3 makefile to support hns3_common module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This one has a savings of ~72Kb on my system.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

