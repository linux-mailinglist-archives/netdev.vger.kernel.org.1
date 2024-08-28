Return-Path: <netdev+bounces-122963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEF9634A7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F651C217D0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA32165F13;
	Wed, 28 Aug 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4deNwUG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C300161900
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883918; cv=fail; b=SB0vRG58D1ri//WAb5ypCSjHIs/1lBBfcowTH8FSQqYIpLOdA8eYASvR5T2vgQMnVu8ZXtoKLAHU7rWZwkRxhGZDghUeY9vtjYNz1mmIAhAQfhrPaPBrbbwtEHqtN4RwiuoFvK/emXA53RaNTEet7I0FfU8uR/vv9R8dyiUcGiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883918; c=relaxed/simple;
	bh=E7RB4XDhVE7t2v7VbeDCEuCVtf2qS9udR6kI7keglVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WfiilzEfKB88HQXXIt/24WR4J8fKQ2VFO/RZNFMubkvf2/9ApKtJ4gj+vmQMu3NLFTh5sb/Lsbc49ZL1mBxkul+IRfX70jGZc0JkYzuU+fFxiL19DqS/Le7sfvrnVWFak5WNmGG3oX9qDrr+2mIOcsLedJcJod++ROfTWRAQoGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4deNwUG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883916; x=1756419916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E7RB4XDhVE7t2v7VbeDCEuCVtf2qS9udR6kI7keglVI=;
  b=E4deNwUGLWV2n9o+pRNvL28lFpE/UUrKMtIPSIbsktwqrhlVCIA27Y/P
   D74DhZd7lvKiNPrPiGWpOG71cLXgoj1ow/ntfa6plHwf1HknsVzWNrmLN
   ZaGGtf1fwIZhyh5Xwk3QgT263868WNQnOq9wWoC5CdjeqnuZee/hKKZTe
   5wEJA/p5eUP7YYMLeR482QWg4CzlUaUHNFG0yc/Pw0vti1pNg7J7Z6Lh0
   UAEDwuVTi/x9G5PRyW9DuJJaoJAqd1CYgnD40oXMdxqhXhJcC+p6mGkjk
   mDpcP09JVdcOAG8/h5hjmNpvYwgEqQqiMYYfYmDNSXlo41U9jRV15jg5j
   w==;
X-CSE-ConnectionGUID: uacw7uP1Qem/m6H2xX4YtQ==
X-CSE-MsgGUID: WtoABGfJRC6aUwMM6VdsrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34018377"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34018377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:25:16 -0700
X-CSE-ConnectionGUID: RoqCq+OPQ9KXmSfRFoajEg==
X-CSE-MsgGUID: TrjOo/DnS86mab5R1wFTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63207903"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:25:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:25:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:25:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:25:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogv3QWIe8gn11MMx5X9k7qHg52UfmA/fKxOsC69zRNtQ86PB8Gr0FHwP3O5Z5wXKFmRVmxmKp1scEyuusOQDuSwu/p8hK+dacvyQ0JFcSGhhosfjUMs4oO02RVQDAvZ7+aRP0gWZdfafVuHEilD3/+fThqrwRWAo6Uv8ph2l8I7d5xXmSzwl0Jj34bvHcE39vSiD2sQe1976J0hVsdeowMREg3Cc3qSztZsp7/hUggIn4wXsENCmlNc4JTq89LVYeptJrP+65jsUuevB4JPoF18CJxgBi4YoXYpD97x7bioyYObBcbbyR78tomWWBVntNk8LORqOuKGVVVpW+Fr/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsC0EVDn9bB5DPK6qPRMZVl4SyQen/nxNz00sC7uAVg=;
 b=tBCGS7bVTSni1XLIkRHncjZlQ87j2/blZ2px+Wc7Ddwp1B35JKL+sDdosooxWaeGKVK5qOO2TPOc71KxgB0Kzo0ZX6IJ5WRAvtfv21FhUAK8CrtRVxBtYkUWujJrjfy2bBsokk9mWAdmU5mFFsZ542/U9pJ7rirgsBka8/WnybrvruXv9aZQGdPOSYWv+f/dU0iT3dwq9X+2wdNbaM+iKcRUS3s34HFaUmEg9RYcMH8Pj14g3JMI+LwE0iypsgt/mEyU6YMzHAPQ1DHaFnLhny1JZh0nW7M5pDfAckzEg1w59VT+dMs4mY8szK4a3W6LTLW/gERlfe2+5geDKpxa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:24:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:24:39 +0000
Message-ID: <0834d6a8-5caf-4511-ac41-2d4c27ca9037@intel.com>
Date: Wed, 28 Aug 2024 15:24:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] sfc: implement per-queue rx drop and overrun
 stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <379cc84db6cfb516f8eb677a1b703cbacfa46e02.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <379cc84db6cfb516f8eb677a1b703cbacfa46e02.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: ef24982a-4a38-4c3a-acd7-08dcc7b03509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2lIS0FaK2kvMVJ2YjYxeDgyUWZ2UkZlVkozVXptRUhwTXMzS1R2NmdMOGlL?=
 =?utf-8?B?WlFQVHZGL0pYTkJqVGhCYTZTUzZSZk40dWpXa1RFOHZjSUtIaGt1c29VdUdO?=
 =?utf-8?B?NVN3S1VObDNWVXgwWk5hMHR4YVYwUWpnd2xrdVQ1QlRaVzRDL2MzdExsQVJY?=
 =?utf-8?B?SVhqN0tGdTNCZXg2NEczNEhidDhCbEY2a2h5T09xTStSdEQvN2EydEFwck1M?=
 =?utf-8?B?Rm5ucllVaVlsTHY0Ynd0WWRvVFREanJQeW1HNzRaQUh6MVRPZXVmZVFtMFZO?=
 =?utf-8?B?OTFYeE9oUWF0VmZIOVRQbVJGbnY3MUhobmcyeU9Ia3J5UWw5ZnU5OVlaQ0ha?=
 =?utf-8?B?N2R6SjRKaVY5WEk0RXc5RWFpa2cwT3JKWUtITWtpWHBhY1lzVjNGMWZ3NW9V?=
 =?utf-8?B?QkVabUJMd3RhbEJzQnVKOGpFZnJDVkRaTkY4dzYySDE1a1Q3bktRT0FMelpv?=
 =?utf-8?B?SkR0NjRCbzBKM0RpVExvUjVNbWQwRHc0K2RqSGV2OTZtdmJEajU4SDRiY2FE?=
 =?utf-8?B?QXJkelpUaHlTaVBtMmd1SXViWEVYSGNkYjZ2SUtXY0p2dHBzNGtnY01oc2Rn?=
 =?utf-8?B?a21kSVJnNnlmU0Ixd2lndTRNZytoQm9uYU9WeVZJMVhrMUREOFVFM0ZjME9u?=
 =?utf-8?B?SWJJcVBQaGsrUHhJTEFQQmFoaG5JcFUxZmJ6ZE5VbXJSa3lNMUtwQmxwdFdY?=
 =?utf-8?B?aEFtcEQyVndwaTYyTzIzd3ZaU2NPNWc4SWl5Q2t4UXdidlNKV2daR2Q0VG9n?=
 =?utf-8?B?dVJNcWFZSnd0UEpEdWQ0cjRFbnp4alp6RmtadzZvU3ladGpZOFU1djZtZUlD?=
 =?utf-8?B?ckdkdXZvSlpMS2lramZ5WFNLaENNbjNXQm44c2FrVGlidnQ4cFZ4ZHUzcFBD?=
 =?utf-8?B?cnYvUllDSmJqKzhMTjRiQ083a1RnOWZCL0tHVHVicnZtMW11TTY4c2pCZDV5?=
 =?utf-8?B?aEJNQ3Mvd1BCaDMzdTZQMytSLzNNanBEdHRRbm5Wc0YxWG55RWR2V0trQjla?=
 =?utf-8?B?SnA4VWpXTzcvQWoySVhLTHJwK2Iva2hTdjNFV3pkN0xMYUhpZHBoQWNFS3RU?=
 =?utf-8?B?SDVqWllXMmlzQ0I3RTFlalJOK3lIWXVYMEMxRWs5ajZFQWVVcWY4VXRxTDdw?=
 =?utf-8?B?V2F5WXFPQUdIRmcxeWQ2Y0dGNmkzd2dCZVgzQ2ZUNVJMM2dOM09mM0JWcWZ2?=
 =?utf-8?B?ZjF2dDlVTXg0YTYrejBjQWVkdnU1UG5QdGxvYmsyNDdIOTBaOTZ5bytzVUMx?=
 =?utf-8?B?QzdFajZ6dnVNRHFFM3BLWWFITUFCRFdNbzZOMkthSWlCOEhRRWZtU3FtZVhx?=
 =?utf-8?B?RjlYQzk1MWVueCs2OUcyc0Z4U0tnOS9IZXhsN1FqRlJ5dWJvTUR4azZQVk1z?=
 =?utf-8?B?QkRZVWNwU0R3TTBvOU9MSzA5M2hhcHpvS0RKYlk5YlduVHh4bmlRSjVSeFB3?=
 =?utf-8?B?VDZ6cTNHNkF6M2JsdjZWVjJxNlY1cllwcVpML3FyYWluODZFdlFwUlA3S3Qx?=
 =?utf-8?B?VUpIdFpuVkhweGlKU1ZZZjNpdWtEa0l2K0cwME1uQTFnSFZkMERpRHJmeExS?=
 =?utf-8?B?MGZENmlRc2hqQWgyK3Q5T1BZS0V1TmE4OEVub3oySkkxSFpZWE9nZkh5Y0hi?=
 =?utf-8?B?dXJzOWF4THRHbmJsMkNJSHVBZ2dSRXdoa0M0Zjg2eVkrbFRnNXVkeHROMGFU?=
 =?utf-8?B?YldxVmNjOXVDcVQ5ZERQeTdPNHRIZEJPZEI3ZTRqcXJoMWwvNEZKU2YvZzNP?=
 =?utf-8?B?MWdCWSttZEhFWXh3b1NvRXpCZnRpcDFzMzhVbU1WMGV0a1pYbEhnVHQ4Z1Fm?=
 =?utf-8?B?MHUxQUJySFVUUWgvTVlWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JaY2JGRUdISHVwSTFUQUQxZldTRy9IcWNXajFjbFJSbWREWitXU1NFWmt3?=
 =?utf-8?B?VEhBNlJudmhJZU5lK3djVU1RQWkzd0daR3FzcmZTbzkxc2ZqWmtUb2RBU0Rt?=
 =?utf-8?B?L3RtMXkwUDJ0cFVWV2Z0VzMyY0xnYVMrYTdqV2cwS1kyMEVKdmg3RGk4MFBH?=
 =?utf-8?B?dFNPQ1daWTZBaXV2R21wRGFjeGV5QjR0T2owNkp5Y0UvdVN2TkVlWEZ5dDc2?=
 =?utf-8?B?MFNZdkJBSlpWaHF6U2FRTENpK2d1WExvZFphNlRiVmpWbUZ6eHJHVE5Pekd0?=
 =?utf-8?B?d3E2REpLTkg0aUNXSXlyWlEwVUlkOFRraWJuREZEUitzZyt0akRsV2dMRHNk?=
 =?utf-8?B?OXBmclVkTEhEaWMyWGEyWVNqSndabGwrL1FEOG5DTHRGaFVreEJmeStINU9l?=
 =?utf-8?B?U3ExWldoRGl6UjVlQ0RMMzlZY0JYa0lnUWJiWmc5Qk5tVmJjUW8rUlhaSXpy?=
 =?utf-8?B?Y1pUbGxGeHdNMWw3UDRiaTBJQ1JiSTg2MmRPVUFiMi9ZMlRRRi94YmYxNUxh?=
 =?utf-8?B?SklTZi9WbEs2TC8zYTFianhmTzlLM3ZIMTJXSDNFZUhJeDhkQUpjY1RBcGI4?=
 =?utf-8?B?Y0J1L0p3R1lZajFvWkg1TVByb0pCLzR2QzlKZzRPVUZ3UmdPK0pxQU44YTJj?=
 =?utf-8?B?OWorVm8vc3FPZ2FxZUVqNEdaYjlxMlFRQjNPMnhkbGN2MjYwZXRXcEJSWkph?=
 =?utf-8?B?eGhrUnNvMVVTZVRsSDF0SVdrb1FmelNWRmc4SUZpdTdUQTVMcVJtU3ozRVNK?=
 =?utf-8?B?dkphaUlVUGp6eFZ1TkxGc09FZ2ptN3Y4YVhXWVNCQWx6SGNDQVBXZCsrTFRy?=
 =?utf-8?B?L3VrRkIvMFpFK1RuZTBlMzZHSUhpMDZIZHJPZGVHcGUrQVRSaXpQeTNhYUpR?=
 =?utf-8?B?THhDZFNzS3FWY1RxY1dQUnMrNE05MVk4dXFaS2M2OG1zc3hIdnl3dkFzZ3Iz?=
 =?utf-8?B?WnUxcklKbG5Sa0hFYUxGaHFPbURPd3ljY0VGbEdMajFyR2ptV2tNejd3OFdC?=
 =?utf-8?B?cVN0NE9PS2M2aWhkVWlFeWJTZjRWaEtEQWZ3V0FGNXhwa3B4b1JES0VJc3Ny?=
 =?utf-8?B?a0hrbzYvMmtENlA4VktWblU3TE5RZHdMemF1SnlQTnlGN2dPYzhPUHdyNTgz?=
 =?utf-8?B?MUJydzJBSHB3TGJtcHcvcEFnV0QyWU5VTzFKK1llL0ZxQVZiSk1POHNjQlhj?=
 =?utf-8?B?VzdsdDNFUlFzQTU5WSsyM3FVVEZxalc4bFBoQ2Iwd21NTnJzc1hXbHNPT1V0?=
 =?utf-8?B?Yzc3QXRFV0pxUXhyQ0tJV3dQeVlVYVZ2S25kaytZSG5CV0NxM2hQcnRMc3dm?=
 =?utf-8?B?NlA0V0RyVC92UVFZK1plZUxueXE4bmVYemRHTDU2R0ZhYWZmd0lLSmVGL1lP?=
 =?utf-8?B?MTBNOGdzNlA4dUt1YVRETm1sY1ZWc3dBdFR6N2NMSHFPWWZaTVdiVldROStL?=
 =?utf-8?B?WEw2K1dSSnJhUUxjSHVXSXBRSTBvaDYrcCtIVUlBdlNQL2FPQXBGVmlCczNm?=
 =?utf-8?B?RzBpbVRUa0VzTG53UFowaWREQUpaeVU5Z09ZSnhieDZFUmg0d05jbmVYKzBJ?=
 =?utf-8?B?K3FwaitQRXE3azU0RjNNS0ExMHFDMEhYb3dlcEV0cEFBMTdUbzloU1JwYVg0?=
 =?utf-8?B?U0laaG4zT1lYY1M3UW92VndtODhUNzV1R2wzV2pCMlQ3T3MvOEJ1eHFPZEVM?=
 =?utf-8?B?RTNES1BkNTJudVhDTlcvTnJsaDVFTWh1eGhmZXY2TVlyMWhlblU0dGtFYVFR?=
 =?utf-8?B?Yk41WU9DaVdOejg4WHJzZTBoRjdvWlczd3QrRENOVVhOT0w4UEpYNDNwTFJn?=
 =?utf-8?B?UDFGMFpiVE1sMFZmRVl2SVRkTVBSanF3RHVVZ3hXT01Ia3pFYW4zYi9RWlpU?=
 =?utf-8?B?NGVRc1lLendoeG1hVUtuTVRqelRGeks3MmpLSUh1VmxGUk9lTDlYN2dLQ0Vj?=
 =?utf-8?B?aGdpY2R5UFBlZ0tJYkI4MlhaSjlldVVxanFGQzJ4d2xXeTdlbHhycTd3OUpT?=
 =?utf-8?B?UFkzNzRJVnVhS3lDak1FZXpNN1JKUzNtbFdMMzYrSFJFU0pDc2Q4UFdqeDFs?=
 =?utf-8?B?S2R6MWpUb3Y2Y1FwR2tSaTJyU1FuRWtzQVJSbjFxdXZIcjRsdU9RdXdzMll4?=
 =?utf-8?B?TWwrdGtqdkpzQ3pGZmdTN0RpTVBtL0x2bndXcmY0S0V6NEhQV2NwME1td21T?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef24982a-4a38-4c3a-acd7-08dcc7b03509
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:24:39.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiHZxKJwydf5sJnbyRZLwH0+jV7Cvy2FBLm/ZBYFHJp8+dy87mGP/6VLjGd1agqut/Kliwn4udiUTaQUl+lnZlzEH/3i9OzeEAqfh62sEC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/sfc/efx.c          | 15 +++++++++++++--
>  drivers/net/ethernet/sfc/efx_channels.c |  4 ++++
>  drivers/net/ethernet/sfc/efx_channels.h |  7 +++++++
>  drivers/net/ethernet/sfc/net_driver.h   |  7 +++++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index e4656efce969..8b46d143b6c7 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -638,6 +638,10 @@ static void efx_get_queue_stats_rx(struct net_device *net_dev, int idx,
>  	rx_queue = efx_channel_get_rx_queue(channel);
>  	/* Count only packets since last time datapath was started */
>  	stats->packets = rx_queue->rx_packets - rx_queue->old_rx_packets;
> +	stats->hw_drops = efx_get_queue_stat_rx_hw_drops(channel) -
> +			  channel->old_n_rx_hw_drops;
> +	stats->hw_drop_overruns = channel->n_rx_nodesc_trunc -
> +				  channel->old_n_rx_hw_drop_overruns;
>  }
>  
>  static void efx_get_queue_stats_tx(struct net_device *net_dev, int idx,
> @@ -669,6 +673,8 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  	struct efx_channel *channel;
>  
>  	rx->packets = 0;
> +	rx->hw_drops = 0;
> +	rx->hw_drop_overruns = 0;
>  	tx->packets = 0;
>  
>  	/* Count all packets on non-core queues, and packets before last
> @@ -676,10 +682,15 @@ static void efx_get_base_stats(struct net_device *net_dev,
>  	 */
>  	efx_for_each_channel(channel, efx) {
>  		rx_queue = efx_channel_get_rx_queue(channel);
> -		if (channel->channel >= net_dev->real_num_rx_queues)
> +		if (channel->channel >= net_dev->real_num_rx_queues) {
>  			rx->packets += rx_queue->rx_packets;
> -		else
> +			rx->hw_drops += efx_get_queue_stat_rx_hw_drops(channel);
> +			rx->hw_drop_overruns += channel->n_rx_nodesc_trunc;
> +		} else {
>  			rx->packets += rx_queue->old_rx_packets;
> +			rx->hw_drops += channel->old_n_rx_hw_drops;
> +			rx->hw_drop_overruns += channel->old_n_rx_hw_drop_overruns;
> +		}
>  		efx_for_each_channel_tx_queue(tx_queue, channel) {
>  			if (channel->channel < efx->tx_channel_offset ||
>  			    channel->channel >= efx->tx_channel_offset +
> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index c9e17a8208a9..90b9986ceaa3 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -1100,6 +1100,10 @@ void efx_start_channels(struct efx_nic *efx)
>  			atomic_inc(&efx->active_queues);
>  		}
>  
> +		/* reset per-queue stats */
> +		channel->old_n_rx_hw_drops = efx_get_queue_stat_rx_hw_drops(channel);
> +		channel->old_n_rx_hw_drop_overruns = channel->n_rx_nodesc_trunc;
> +
>  		efx_for_each_channel_rx_queue(rx_queue, channel) {
>  			efx_init_rx_queue(rx_queue);
>  			atomic_inc(&efx->active_queues);
> diff --git a/drivers/net/ethernet/sfc/efx_channels.h b/drivers/net/ethernet/sfc/efx_channels.h
> index b3b5e18a69cc..cccbc7d66e77 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.h
> +++ b/drivers/net/ethernet/sfc/efx_channels.h
> @@ -43,6 +43,13 @@ struct efx_channel *efx_copy_channel(const struct efx_channel *old_channel);
>  void efx_start_channels(struct efx_nic *efx);
>  void efx_stop_channels(struct efx_nic *efx);
>  
> +static inline u64 efx_get_queue_stat_rx_hw_drops(struct efx_channel *channel)
> +{
> +	return channel->n_rx_eth_crc_err + channel->n_rx_frm_trunc +
> +	       channel->n_rx_overlength + channel->n_rx_nodesc_trunc +
> +	       channel->n_rx_mport_bad;
> +}
> +
>  void efx_init_napi_channel(struct efx_channel *channel);
>  void efx_init_napi(struct efx_nic *efx);
>  void efx_fini_napi_channel(struct efx_channel *channel);
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index cc96716d8dbe..25701f37aa40 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -472,6 +472,10 @@ enum efx_sync_events_state {
>   * @n_rx_xdp_redirect: Count of RX packets redirected to a different NIC by XDP
>   * @n_rx_mport_bad: Count of RX packets dropped because their ingress mport was
>   *	not recognised
> + * @old_n_rx_hw_drops: Count of all RX packets dropped for any reason as of last
> + *	efx_start_channels()
> + * @old_n_rx_hw_drop_overruns: Value of @n_rx_nodesc_trunc as of last
> + *	efx_start_channels()
>   * @rx_pkt_n_frags: Number of fragments in next packet to be delivered by
>   *	__efx_rx_packet(), or zero if there is none
>   * @rx_pkt_index: Ring index of first buffer for next packet to be delivered
> @@ -534,6 +538,9 @@ struct efx_channel {
>  	unsigned int n_rx_xdp_redirect;
>  	unsigned int n_rx_mport_bad;
>  
> +	unsigned int old_n_rx_hw_drops;
> +	unsigned int old_n_rx_hw_drop_overruns;
> +
>  	unsigned int rx_pkt_n_frags;
>  	unsigned int rx_pkt_index;
>  
> 

