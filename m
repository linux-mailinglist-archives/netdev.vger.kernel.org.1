Return-Path: <netdev+bounces-166221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87934A350BE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89016CE57
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97A26981D;
	Thu, 13 Feb 2025 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El/rcUKl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA322241673
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483814; cv=fail; b=Twv0kFqcrye5xL+c61QqhB9poMncZz4LQZRPPzLO0x9XK9hPeIgcJU+1mYsJF4kgqofLwewy+kU+Yzo4vrSsYzzhuYGmD7qdG5S6BqVQy5tlRTBpbue7xEbyO2AOF+I70/DvcCyk23d8CedEnwqkKDW+L9LE61YL1IVaOpYWNT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483814; c=relaxed/simple;
	bh=Dizqangdi2/dq6QahxGnJ18B8Ggo3CWMV4XCe3gehpo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iltbsn0sU5aWpDD4yvou6Dfe7vcT8+/YmjymGzcjjUhotK6IPIDzmryjI0BonavNLGJYOiUThhLSbFAK7saHDT0af91oThw+GZTasw43uX1Szjfg8GPhDjWNpfbGfONFkPIa3I1ZK5hA9Iicu10Sprmkt7+pU69L2qhntHFKS3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El/rcUKl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739483813; x=1771019813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dizqangdi2/dq6QahxGnJ18B8Ggo3CWMV4XCe3gehpo=;
  b=El/rcUKlupGBqGfOFXJGF+AOVqm6IJgqwUFFWT3agX+0T5gdICPrbAN2
   DqhkxI5GNHJxJpXImiJ0kXwzeR4bPOU3U36oc49RagJTJiZruZnz9hvvt
   MetIvWYm3juyS3dPLdA5psde3A6epBDdtAFyRjeeUgsG7svcuY8f93zOH
   sTPXkghTRdUXNSC+hBUd7JFIAt5WnH/Kjg7jWQNK0tKWuJV+9EvqZxIej
   SP6wSnZAEnjA3uzQs2UEqCHP69jZ2IOQjStAmuWGEhM8+JZ3HzhIsRdzK
   vVhGF/q+X+fCWcVxuc8Q7fz4oUSaQwYcDFtNHevRWgoemmYz+PKtVAUMD
   g==;
X-CSE-ConnectionGUID: Pj7hMEhBRGmUG6pR8txBrQ==
X-CSE-MsgGUID: +MasRK4sRB+l2Y1th34KQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43868844"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43868844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:56:52 -0800
X-CSE-ConnectionGUID: DHLxGTKjRi62nQNULEKCNQ==
X-CSE-MsgGUID: mUn+q7eTRn2X9N1uavHj8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113763734"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 13:56:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 13:56:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 13:56:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 13:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNSeyJTLEJ8uNUMg/EiFGaaHmIChPKV+e+HgJTWrqG4YC0UL8X5+RMGWm5gTbZI4AsXe1ISsbfTUR8MTOEtk3eqbTBpf4uZJc/8dTGaQ3M3SidLjYibx9ouvz9ymYpnj+Sct2+djzPyLRLSzmMEElm3NM/7xR9RVVIxQzGx9wtaSO4bYCh0ydXADiDYx0UE88Jp7X0BV8FwM+3TSkXNhxrNJGsXXjR+e7mJrNz+J9wQevEt9KRGilTNtyef+2arMxfWAKRYGGhb7VGVTKWQVkaz2ykTMlrvYjaBmguct7Y3x2Z1PNMxTmjQvis1hi7GC1jBecUS5MaS2SgEUjYe6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQJkgrCXV/lyNBFcqoyr1cUCM3SLKlh1qan0IudVf34=;
 b=Hj8bwjYccTeBiujR5eKqzCW1PE5QMYzLUNtVqmTzyVgcz4yjJM1Z0tF2p9A52sS92Vk8F/W6EZhBjyZrlIWunb0D/ROg+AdsZKnFBsonKBEYuZoDcsl2IHPFSVmmHQqSLZfOkgRuOK3r9JjbdyBMgEp1P2JCTgnXp7KJoU5EO2uKtN6aJrOrgZ7wB2LPjPcgUpcKNOqcKLXBGYN7xDrdUFPFdq/Puo2QsVbi5jzEcxe6OoyD4xKurEwMQ4jOh2dzaTuQsrGPz58GMT/hH06tItUIUjS2tsprSJYTwBo4mNlYyDvG+H5YSjdxNhrss/nZ0Hneam0uXlk8TbgpRdBJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV8PR11MB8677.namprd11.prod.outlook.com (2603:10b6:408:1fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 21:56:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 21:56:48 +0000
Message-ID: <44e83e1f-85e8-4485-bbe6-773214b9a264@intel.com>
Date: Thu, 13 Feb 2025 13:56:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
To: Richard Cochran <richardcochran@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: Jiawen Wu <jiawenwu@trustnetic.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>, <mengyuanlou@net-swift.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
 <20250208031348.4368-2-jiawenwu@trustnetic.com>
 <20250211160706.15eb0d2a@kernel.org>
 <03a901db7d22$24628cc0$6d27a640$@trustnetic.com>
 <20250212181744.606e5193@kernel.org> <Z63pXJKUNJqZlwdu@hoboy.vegasvil.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Z63pXJKUNJqZlwdu@hoboy.vegasvil.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV8PR11MB8677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7f78ec-36df-4acf-57c1-08dd4c794f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUtUaDRtYnYwd2FncHZtZk42eHBuVWNpVDg0SWpuL0ZLWWVmL2pXakFXbEZO?=
 =?utf-8?B?K28yeThzUFlsNE90UFF3QTYwRlpQMmlmbUJmM2l6YUU5Q0hvR1NkS2Z6bjJU?=
 =?utf-8?B?MkF4d1RQNyt4RkxNcW5TN0hSOVg0RWZCV1E2c2U0Q2d1WkFkV3lpb0FHQmUw?=
 =?utf-8?B?aFpnazVxcC9ZaXp2OWRiWEp5ZEk3TG5kWk1JMFRndmFNQXRaNVNPS2NPMm5E?=
 =?utf-8?B?eEsxbFI4TVFVYUFXMkxwTzdRYUdHTG5qbHdxNWlDOTMrQ09iL21XVS9iZmV4?=
 =?utf-8?B?Z2lBT2ZhT1pPSlRGNGRrK2pub1NNeVhDeWtOV280bGQwU2tZc0hDdG5xbWcx?=
 =?utf-8?B?clZHM25XRVoyWXF5V1N5b1Y1R1dPTGxvaUY5L0N5WnNURGlpZXYzNW5FT1lh?=
 =?utf-8?B?Q1ZSZ1J3aUZ5cWFZbmkraXZNREh5QUVJWTN0aEVBVDNFcEtHeXlrWnVnZktr?=
 =?utf-8?B?RDI0SUw0RGJlaVk3a09mc3FZNUdGUlVwcEhvckppaDdZRmExb1Y1czBKMWhn?=
 =?utf-8?B?cDZxdlBpcjd6dTkvZG1zNDQyUUZhdjdaUVk2MkRZYkRqdlVsb2s3WmFLb01i?=
 =?utf-8?B?TVEvNzFsWDZJVGlEVEIzWW42Rm0rZUZ1NjBwdjB3aHhXUWlaeUJZVWpwMTVY?=
 =?utf-8?B?aU1OSHhxWTgrbDRPZVNIZGYreFZPL0RRLzBTWVROS3FpbU9kajFhZVA4eERo?=
 =?utf-8?B?YVVBRXFpOUl6RlJtZDlrNW9sTjNEaVBSVVpHbFhtMndpNWg0OUxUQWY5c1Zk?=
 =?utf-8?B?bTF0VEFUSlV3QzJxZzM4N09xT01KSmhOWUVLY08xMU5HNFNNd2wwVm5KcUx4?=
 =?utf-8?B?UVE5V29JeGF4U2ZHUG4reUhwQ0VCbEtFdWljQjRhcXp2QXppN1o3MVo4U08v?=
 =?utf-8?B?UzcyVkJWSlBYRGpFckV3UjdjYnpNeS9mNzgzcVFjNUhkRG5sWGNwcEM1VnBi?=
 =?utf-8?B?UEh0cU15SHMwdTVTOSt6bEN5SWFlRjV6UzJkcmNvYlRTMEg5U1I2UUFIUmIy?=
 =?utf-8?B?eEVhaFlBQVFnZmxzS3BVazlheDVhbkhTUlMySUM4SEgxRkVqeENIajZwYlFE?=
 =?utf-8?B?MGk4L0pka0hVdkVVa3NSQnJ6YW52c214NmZrZXYwcS8xQUFYbjhUQzlNTlh6?=
 =?utf-8?B?THFlYUdDSjBDdXMrMlhreWZBNnNUZ1RvV1MrK3E4M1UrVWw4bVFzd2wzOTFQ?=
 =?utf-8?B?RStTUk5CdFVFa2JuRzBCUXNTUEZyak1DdkV0a3dqM2NpRW0vOHlWLzZYU0FT?=
 =?utf-8?B?SlEvb3RMVDhBWXNLdGUxY3JCYm1mQzFMblNQUFdHZ1NSQTJ1dUUwRDRjZ3B5?=
 =?utf-8?B?b08yMk9LaGVMbmk4L1hDRkhSMDh2VXhMWXFoYTA2V1FiVmsvZ2RKSEFoNk9Z?=
 =?utf-8?B?cm83bU8wZTF4UDUwR3NGTXlMdEtzSmNPTE0zeWV5QkhWdzJPY3JjWjBYS1BC?=
 =?utf-8?B?Q3Y0MDBlWkU4b3JWdXFlRno4SDVrV2MvaXZ4UFlNSXZXL29TNVZvOFpRT1Jk?=
 =?utf-8?B?VFJya3BHcC9zcElYOEJMb0xzRlNNMURMMXN0NC9XVHp5cW9EaFpvcCtDUG5H?=
 =?utf-8?B?WDdSaDZFVHJFZ0V4VG81TFF4cmo5YVlUdnRQWFlpaVZzLzhNcEJ2Tm93YXR1?=
 =?utf-8?B?empoaFludG5ZdnVMcjQ4U3NGRkdjOEloc2tYcCtMRFhUT0tNY1l3cmY4eDgy?=
 =?utf-8?B?Ni9LVC9yZ3ROUDFXcW9VWU1VK0Y5VnVKMXlkMHRWOEl6Qk5VRGZZTHpFVXJK?=
 =?utf-8?B?K0ZZblEzVkNsZFdqOVpyL3prUTlsY3IrU1kvMXVhUVdtcDV4RFFZMXFHY0Zs?=
 =?utf-8?B?R01IYWhLSUhicFh0NnlkMnJGcHVFdHhIaUQ4YlRLR3J6NEhQcUY4YmM1MmZG?=
 =?utf-8?Q?hbtRWUHpqQxsN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzV1NTN3OXVqSHE0UlI3WWhVR2dmdXNIYzhrN2VoZmZlOGJWUnpVV1h6ajdL?=
 =?utf-8?B?eUNmMFZ1OUJBWGpYbU1tTnZZOFdrY3lLY09VNXJDejAxODY0MjhBTDFxMkJD?=
 =?utf-8?B?MzV0b0VkTzYyTTVyRk9QN0p3eWVhck9WSXQ4R0g4a21mSnVuSUpiclhmdTlT?=
 =?utf-8?B?dUIvbCtORnh1Y21lbC9QS3h2dEFVRCtQOG5jWFkxKzJTT1Vtbm5DaXgwektT?=
 =?utf-8?B?aUJyTFBNbFJ1ZDJodS9BMnlqcnlMWGRTVzVrNEx0aXRmY1lIUHNsYzc1Smxj?=
 =?utf-8?B?ak9mTnZaSmt3Q1hhd0lIRDZFOXdleXNYdnBweXFuMmhacVBtYkI5R1VWNUNv?=
 =?utf-8?B?eDdieEczd0s0QnExeXJ3MThvY3A0eStaaENCUUJTVVRRcmMvY3pWR3BFTEVD?=
 =?utf-8?B?WXd3YnRZZENvYk1oc1RiVldsSzg3SEtaMTY0UWxjc0pBZWdhUFp5YTQvUmNY?=
 =?utf-8?B?VWNmdEtsbjljNWsySUI5SVc0dXhOQzNneENXR2NtMEd0Z1BxRnh0bjQ2dzha?=
 =?utf-8?B?ZlJlSFdyUkVENCtUT09tVlhWQXk5cTNuQkR4eUtIYzR3ZDMzZ01WcjRUbThh?=
 =?utf-8?B?YzkyRnh3R0VweE5weWl3ZUdpM3M1T21UZHlKTGl4MGxFdHRLaUovSHJFWkxi?=
 =?utf-8?B?VHVtR3F4L1pGNUZ2OUFCWkg1eWNMU2RuZ3ZmdWlKVkxTN2ZiU2I0YjhUWEly?=
 =?utf-8?B?WVVXbXY5WGlFYjdmL2VwSnhlWkZPTC9WSVNLakFhSkJPY1lXZ1NxaUhMUHBv?=
 =?utf-8?B?RmlOb0pHdEljTmErczBCZ2NNVUgrNXE5ZC84M2wzSmptTXhJSEFESTVVVlY1?=
 =?utf-8?B?RGluWWxxdUxqS1l1c1B2QktxTmVQVW55cVoxSkN5M1pqYTQ2eUhlQ2FhYTBS?=
 =?utf-8?B?SG1kTnZMYldlUGZadmwzU3FjYm9TVVRXaDdyOHVYZWV3S2JJWVlvOVB1bEpq?=
 =?utf-8?B?N1Qxb2ZGTmxIWFNEbmFHR2tRMFhlcmR3VE84bEphSXpxbTdEZ09Oa1FlaDdL?=
 =?utf-8?B?MkQ5bmpIa2x2OUYvSUtPZnhIR1NrNmw2WmNZVDBRRGxNOUNUSktBdFNVSWgr?=
 =?utf-8?B?bU52Mm5qeXNDWFhWc3Q0dWk2QVRTSFdTVU50VjVxbzBMc0ZpZitWcEgwTXd5?=
 =?utf-8?B?d29lVWtaeWR3d1h3TzJjT0RTbHhEdXZYbVE3dFpubGMzdmNUcDhraWN3bmJs?=
 =?utf-8?B?TjlyVERwdGxSalVDOUFkVnFZRlZ2ZEVScExFa1NnaVdhaU4wemE1LzEzVzZt?=
 =?utf-8?B?Y3pXQXphRDltcnlnbjVlNkxpc3JsV21zdUVUQXA5WEFQeVl1cGFBM200Z1VR?=
 =?utf-8?B?UTZTZk9NSTl0dGRuSUJnWTg2SEhTbi85bDM0SXhmMTlZcmlwb3lNUXRHN2lj?=
 =?utf-8?B?VFRtUVRzQVprU3Y0MnNoUTNKanBSczA4dnNtWDFSSmVtZ1VYZXVYY2F1SkFt?=
 =?utf-8?B?QlpZbW1kNXQwQ2ludUs5SXZ5STBZcGhsY1M2RlF5bnIyNlE0TnF6dGs2ZmlZ?=
 =?utf-8?B?Q0FiRDJFRVp5UnVHSmEvbkIrS2svTkJDM0RNNE9oS2w5eVpCTytWeTFZamVX?=
 =?utf-8?B?TG14QXFxbXZ1dExEUk5RalY2RWZVRy84eUh0cUdxcGJ6WXB4UjZKY1NhQzFG?=
 =?utf-8?B?WHdPWGEwOXhPUHNFUUlja0Q2U0dFZkNqY01nbjlMVWxQVEdjWDZPU0FLQjNp?=
 =?utf-8?B?UXNkV0JCVFJudXJ5NEo3dGc4cm5wZXgrQmN1eFQwNE5XTFFlQk1RZW5NUXhu?=
 =?utf-8?B?Nm9sTldONjZpRCsvbUdqL28zT0tUTnZTaVoxWVBBczhYT0NRRXVTbFB3Qy8x?=
 =?utf-8?B?N3J6Smk2RnRyUUg5RkpRZ1FxVTdhWDJVZlpuVFJXNmxFUHp0bzB5OUs4RDBQ?=
 =?utf-8?B?ZUZ1OFEvWGZCRlNleFdjenlhLytTN3FadENaL29JMXBSRTJZWlg0dEgxYlFp?=
 =?utf-8?B?R0dnOC9uZHVleUhob3Vhekp2aHc5MzNxcXdOdW5QZk1JTDA5ZnVpa0kyZXhh?=
 =?utf-8?B?SlNTekUydHpmaTcxMFJYNGNzTkxtUld1WnYxU1RWMmNZVWJ5dmRLbHc1ckZs?=
 =?utf-8?B?Z0Z3MnVtaDJSS0RqcnQvMXg4R25lcEhxcjlLL05sS04yWURKVnF0QmhObERq?=
 =?utf-8?B?SFU4TGlRd3lFUDUwUk00UmhFODdlQm9Hc0o1QnRPTTNGOXZSaml5eW9hMW5E?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7f78ec-36df-4acf-57c1-08dd4c794f77
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:56:48.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3XI0+Aoe7XPLdYWakkQeLj4Tjq3Ias6QmWtKSi4Bs8mQeAVZsoj/3/3I5BOOhDSDiozLuTX+X67XqRdjgi3DdwBZGL8q3s53OgO4VNmb+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8677
X-OriginatorOrg: intel.com



On 2/13/2025 4:45 AM, Richard Cochran wrote:
> On Wed, Feb 12, 2025 at 06:17:44PM -0800, Jakub Kicinski wrote:
> 
>> Give it a go, I think it will work better when machine is heavily
>> loaded and workqueues get blasted with other work items. But not
>> a hard requirement if it's difficult to get right.
> 
> "work" items are essentially uncontrollable.  They should be avoided
> if you need any kind of QoS for work being done.
> 
> Thanks,
> Richard

+1.

I will note that simply using a kthread (like the PTP auxiliary work
thread) isn't a panacea, as this still requires configuration to ensure
that the thread has necessary priority to execute as necessary. We've
had a number of issues with deployments involving systems where the
solution requires carefully tuning the kthread to ensure it executes
reliably. Such tuning is possible with a kthread, while targeting
specific work items is not.

Thanks,
Jake

