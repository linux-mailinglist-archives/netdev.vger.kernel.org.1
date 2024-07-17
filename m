Return-Path: <netdev+bounces-111919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD2934198
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153E21F20FF9
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97E21822DA;
	Wed, 17 Jul 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKHI57tw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18371E889;
	Wed, 17 Jul 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238292; cv=fail; b=a6XcRPIQKZLNutId6jpLvOFnmcKws1GpJhZWp0zFxh4HIuIbJ63NrxQr7GnVC5vyX/Bhrfxp7E9erGV63REJ8C9S1b2kXoU+u2b5sYUC+b1oUdXmb82jDONamAYQuBt1SfJtV86CDTAWaGu/iYd9sLDxXxlk/WobD7+51/+T9PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238292; c=relaxed/simple;
	bh=UnEYUDU5rdGh/Ong2x2XRjTxqg44V6jq3e8Zpd273hE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbxNHOyD+e46LP1dkyj7oxxGjs+wCP3dDxOZefvSXjQ7FLqdWTFp5Wk8oPqWYh4aQEDswi27M9ysMKGfqNv4BYH9PoH+e+0Bz/c4363rMMecNnZHKBEItHH/fV8z0YSB/8qHHAfDn6S1/QnDX0zzOXW+5YiSwZP0zMX6iX+FWJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKHI57tw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721238291; x=1752774291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UnEYUDU5rdGh/Ong2x2XRjTxqg44V6jq3e8Zpd273hE=;
  b=oKHI57tw7VNg6NC4Km5T2mqvbVekgYIC2RECXkOq/dW71l4r5l8oIsMH
   s6crdGUP3aR0yf0SJtj5heyMzXmC63s1K12jKD/UUFZs510sUR2mUKqOB
   TmA5PI3VB2oEBUDJA0FLOqD4WM2E9v1N2RBaz1q+h6cIkoVsDW3NMD7L0
   NpwfhaKEeGOqg88pen+lDaw9qX+pugzm4IzifjMxMTPUXi4uS+1yryDz6
   P0+Avc+pM/XUO1UukZK1ZidPE73yOtroZYH/8BNW3pIGI08fskHDTURBs
   kSmCW9l4z3qtH80bTvG91oAOp4UI237iSBH9iDn0L4AqXZ6CD6D9NRcOE
   w==;
X-CSE-ConnectionGUID: 4+Z7NQW4TpySH9Eh39qO7A==
X-CSE-MsgGUID: EfOIvdnHS+mfveCtFd74vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18609992"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="18609992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:44:50 -0700
X-CSE-ConnectionGUID: UUudfSwnQq22lTD1FAbyFg==
X-CSE-MsgGUID: twnZfwwVTZ2kksd2ZbVt4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="87936766"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:44:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:44:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:44:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBehKP0JTzWKk6ykhr8WFtx79pp2R52dKeuViWBBlL2L2+Lere5CO/cecG7FSZg15Qk6A97zKA3oVAP0kDz44TxxvQmpLYQjp7MxkfVPSjwTlsJaBPRQKTq59ksm/dTs7IAOzPVyd4bheL8BkYpmq9+ieRbo029o5CZQruAnbMC9ptoudxnQs6wuA8TJL8DED17JrBu8gN1T4HjX7vO6bHXebadjJRQSpqqpyvq7+3HHmFtc9IERG3pkkzFdg7EWtK5qHdz3CAa3FLsHBwNjBY6pdKh1veSgnDhklcCCL09D/kfDARQecq4ap8YwYxZ+KmlqwLs1OfYeDfFKmTBnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFKHvfdXtrp1Axz+4BA3BSvlQxy151RRBASIPURgwqk=;
 b=v4VNFesk2yiazHufI5TTi5FbzwCWEVKoadFv7ARb7vCIOalFdKGLK39qFc7E6vhOcV+lmxQIeYtiMkgxBq0RyUL73GP5HM39YuIk8LYTpM9hz0gUAWEWF/4LCeY/Vq3SACoYKtLGanhK2WTRWtfdaRhLYe6ujQgbBHE3Z1KEdIeI0UZ2nwKv1SucfWD4VH9TIse39EdudJEkwlDqUm8HzHEfWY5O7rBVTitiYAUN468S7lgCR/H9SmiPvA2rNv5EX3LXUAXGnhEqHxKWBFaMN/lhBSlkbS6FbA12i3Svs4oo8ju5R4ImeBU/HcLcsFYjMrLU9QT8VWAFV+zlqUykvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Wed, 17 Jul
 2024 17:44:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:44:45 +0000
Message-ID: <d4479e0e-1df1-45ef-b041-7e16594dd404@intel.com>
Date: Wed, 17 Jul 2024 10:44:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 14/14] netlink: specs: Enhance tsinfo netlink
 attributes and add a tsconfig set command
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
	<j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-14-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-14-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adda07f-126e-4a7b-6209-08dca6882585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHVBWjNMMzVTcEQvb0RWVnR4TlM2eGNSVjFMUXhMWS91ZEJFdVFoMm9nZjlr?=
 =?utf-8?B?d09OcENZTnl1MS9uaDB6R2JjMSs4NkdKdklxNWdIZ3lOWUgwWlhyakVxTVU3?=
 =?utf-8?B?U0o4MEFJSldSc1ZnZkRPUEZxeDhZb3dQbGVBUzJ1OGFXVm9uUysrMDdWSi9N?=
 =?utf-8?B?SVA0YWhzb25YckJRT0pnTEFpejhOeXhBL1NXek1HN2sxTnJpc2NmTGd2SDlh?=
 =?utf-8?B?MmZaS2hBTlZHK3NYbExQUzBBV0hnVld3VGdvYjU1aGtNV3NtOVJaR0t5NEth?=
 =?utf-8?B?cTlVMHpPb1pKMWVuc0FpUm1JOG04WDl3M3l4SjIrY01MZHIzNmQyWVBvTm9T?=
 =?utf-8?B?dzhKV3kycVJOMnNzWElGV1RrWWR4VXRxSlB2cTlUQ09XR1VDVEd4S1dmYmxL?=
 =?utf-8?B?N3NUZXpuOWJZaXUxdDFzL2NIdm1lbDUxUk8zL2F0SUozZkg3YjlvSWZCbXFX?=
 =?utf-8?B?VkFOYndmQ2RsMnhOZ0ZyZ21mclR1SDlRT05TSWVuN2RGQi9EQlFMMWNUWDNF?=
 =?utf-8?B?TzNJSUgveExhQjlHS1IvTDBxaUVWYVNJQTVrRDRhUzNSMndQRlh4c1l5M2hO?=
 =?utf-8?B?c0NEdkozTlJBS2MrNjZGVkpjeWlhNWlvNVhOTzR3VmNSWmdKbGpUazNlbVBR?=
 =?utf-8?B?SE9kMTVvaElnVnB3UmJSQjlJWXZIUWJtOHRNWUgzL3lseTQ1NEFEYlQzVmZk?=
 =?utf-8?B?d3h1eXpsejhTNHR2TTFnK3hYeGl3cUZRNjV5em1hVXJqbTdKR29aS0w1YjZo?=
 =?utf-8?B?Q1pEVllFRHVFZ2c1dFV5MWxubEhCcStibnNhanY3eFYxbUhRZ1JUbTkrWlI0?=
 =?utf-8?B?dThDZEJZYitxa2VPNHpldjBhbjl1Z0V5dk4xaWxBeXlrZ1JtT3BKR1BsQkN1?=
 =?utf-8?B?VUs3eGs4TkcwR1NkWlI0WTA1bU5WTGxuMTRlN3pHQVRTek1EOHA5VzU0ckU0?=
 =?utf-8?B?Ti9sL2NTcG16SFBMSHc2dHpZVGJROXhNVm1CaGx3TnJuOTd4YXdvNmpPWFN2?=
 =?utf-8?B?MTJibnpnT3YrQm5sbDU5RVg3WUxtVWtNaEdqSDJ0RWdDMktHSGQ1TmpLUm04?=
 =?utf-8?B?ektPU2ZVS3dNSlFXS1ZvSGhOMDJ5TFJHUDdiWWdTUXJTczB5UTMwTFZua0FG?=
 =?utf-8?B?NXlJa2hwS2NGV050UXZlYmViSGQySytzRVFzclZwZlFxVDFBQnlhMXEwYkxw?=
 =?utf-8?B?SzRlSnA2UmRkSEF3NTlPTW5JeUZCeW9MK3F4Ri9EQlovSG1zaGlUamZLeXZU?=
 =?utf-8?B?YnhENFVCZ1NlWTdXR1NPU282aVJGVFcvL3BIYlZHcVB4NkhIK1p5WHEwMitF?=
 =?utf-8?B?Tzd2bTlVa3hPUVFtNEZOWDFlMDFuKzlGV3VOR1RBeTY1ODhDL0tLNmxmM0x0?=
 =?utf-8?B?V1VJWGpybENjRm1UWXVvTHlqd2IvU0xDR0RzYnhxZDhTd2RQK3A4ZGlJK1RX?=
 =?utf-8?B?KzVVa0t1K1ZJMmhGK3RhbXdQMGdaRUlZRVR4OWZkWnZ5Z2lYZy9IVzlNNVha?=
 =?utf-8?B?aWNQaGlQeFNBRlhCcTVhMGVqa1VudVo1Z01FQ3JJRURqcDRIaU04V2ttNDZB?=
 =?utf-8?B?RCtNeGNNNllpK3QzbVZONlF5YXN6WDE5MkVKWS9LdjZuNDdXZnRoN2V3Yitl?=
 =?utf-8?B?ZUpqRjdROU9HQUNBZUh0eTB3V1V4YS9INU1UZDlyL3NiSURncDY5a3ova0NK?=
 =?utf-8?B?WkttNzhwUkl3L3NMSUd5RDNtSm9nRWRIa01WMHZBTS9ONTVxVW93RHEwTFph?=
 =?utf-8?B?TW1jZjVldE5xNENoOWVJVy9nTzg4dldFTWNsWVJXVktmcUw1UThEWGE4TVRv?=
 =?utf-8?B?K2hYQ3RGakFYalkyNzBwTVdINVlzdkdQMWFxWHdvNlUzR08wU3Z4bUtuOFVn?=
 =?utf-8?Q?4UdfkNqcVwIbl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhtNWRQdG9mOWNnMGNLN0oycjYzbGw3TWhDMmJHdkNGN3A0OU1hR3plSDFV?=
 =?utf-8?B?dEZaSmV6b0U5R3dudStIUkM1WFV6TkhkMlBoWGlmcVlLYURsZnZ6Nm9TdElK?=
 =?utf-8?B?RkVyS0hCcGc3SGZROGlWZjA4c1lmSktoWnBSMkxkbkNYRTZnTEhvUFNySGg5?=
 =?utf-8?B?ZDZkRkVzWnArQkFyWlYxNGsydktLUFVFZHJ4NjYyYk9xaW1jcDZMZXNiakly?=
 =?utf-8?B?aEREYi9CUWowZVhreFY4OGdVZEU4WGNwM1o3TlJORDQyNGhQSmJacno1Y05a?=
 =?utf-8?B?bUUyRVVvSHY2OWx6SGdHN2NvN0RKTnJHVE4yRlJsVWcyTkpNS1RzYkR2bmtV?=
 =?utf-8?B?ays0bmRMTXZGTUxTaXRFUkNZbVorMTVKNGdOYWtpbHN6RlpkVVYvZlVpbTN5?=
 =?utf-8?B?bnRoK1pMcjFjNnVONXFrRytwK0RNNFVaZmZ3V1Q1ZTJmN0dTQm9CQzRwQ2Na?=
 =?utf-8?B?dDMyZ1RMbUwrZG83Q2VaTFp4bUV1S0w5S29jOFZSOE1TK3B6VlNpdEVPU0FX?=
 =?utf-8?B?YVVYTXdQb2hRZzhSd0Q0d1BlOXB6YjAzeXc1VUIyWXBuMmNEY0t2Rm1QT21x?=
 =?utf-8?B?R2VCdG9jbDhIOFgxNFhZalp0Q2Jyek1TcUNPVWRyVUJtUlJzbTZWb09YOVlV?=
 =?utf-8?B?Zkl0WkQvKzI3R3FpUFluZ20rdTRkcFFjaTY0Z05vc2loSllwdWt1NFZWbU9B?=
 =?utf-8?B?VHEvVUVwRE5MWHUrL1huSkxtS005aVFlZE54enMrMTVTUEtvRHBTTGpLZ2Np?=
 =?utf-8?B?cHJ1ZTFaT0Jrb1VMNkhLNGlWUUpkcjJZT2gyYnBCMWZ4aS9kbE1lNVJaUEVZ?=
 =?utf-8?B?N3IxeHdjbjkvRDJjbnQ1L1ZEaWlHRHlydHZoajlIYjRBRWhzdDdZRGlxZUEz?=
 =?utf-8?B?aXM3R3NqTGhZOUJ4VHJvQTZFZld2M1ZzWkVieGUrY0M0R1AwSUxZcG4ydWxm?=
 =?utf-8?B?Uk1qL3MvOFVQWDNtY3dDTVZoNUJ6SEdMQ3IyMnlPWkZXaU1VbklSTm1GT0lK?=
 =?utf-8?B?UTJseFNXcWNGLzZKTlNBK3lIeXVaZXlXVTkyNHpkNFhQUkhpTHFBWVZMcXBn?=
 =?utf-8?B?VVUrUWdxOW1IYW1jN2RxODhERW54b1UraUwyNHJ4TmFGMFBRRGJsZ281aFM4?=
 =?utf-8?B?WWh3dStqRUhyL1pmOFY1aldmVWxqc0VJek5hMUFZSXFKQTJBMGQxK3hNWDV5?=
 =?utf-8?B?V0c1bkhvNFlSaEpXVDIxVHdONklkT2hCd0lHWm1lR0hvbDNRZVJjVzNpUmFj?=
 =?utf-8?B?dmhsMFU3aGZROHBQTTNLV3A2Wko0OS9VT2NhMHAvZTljSzcrWkZaQ0Z4WHpF?=
 =?utf-8?B?L2svdnY3eWdwYm0yYWhCcFFzTVdheEI3MVJsRWYvTHdXdHBCWEExVER6TXN0?=
 =?utf-8?B?L1FVQjgwZ0Eyb283dUgyeDY5T2hUYWJXalhUWUNEVG53R21zNmlRUUpYMS9K?=
 =?utf-8?B?UDVsYVNyQUlxQkoxdHZ1RGU0bDNiWllIelYwMGV5Z21IYXZpa2pHTWtVbVBj?=
 =?utf-8?B?V2ZLZVovdXpUSkU1ODdQOGJTM0JNQVRNRGNXc09hMTB5SWw5bm9pOFk1WjNN?=
 =?utf-8?B?ZlZsZ3VoOUdvblZPblFUdXYrS3hYTE9ZR0M4c3cyem96MWlpV1YxTlVwR25v?=
 =?utf-8?B?Sm9QNnJvVW1MM0g0bEd0ZjBHdTkxaElBaEJLN2RoQXBhMDRLL2hBQmRuUzBt?=
 =?utf-8?B?ODJ5K3JUQlp1S0pIQ1oydi8ySkFYRkNPMlFESWJ5b3pLS0dadWhUV05iYlpW?=
 =?utf-8?B?M0RiVEhPVEg1dEJodEdQTHdZMTBBM0VEWmx0MzVQaWtvOTNwU0xibkhMSGZZ?=
 =?utf-8?B?OXhxYVlZYjk3SiswUDQyTHp0eWJVYzNjUFZoM3FXTHA5VkJ0aHVPWkdSQXBz?=
 =?utf-8?B?Y2lhZDJoSHhPRXlYempIZjR3dHM1ZHNiVUxFdEp4L1VrWnN1RHpHTGg3cjBS?=
 =?utf-8?B?R2JFMFhZVmpOd1d2T0ZuQXlnSUo3MTgyRml4NjlhNHF4UlgzbjlJa0xodFFi?=
 =?utf-8?B?RkZKYVdhZGYrQi9hL3orN0RiSzNpUnEra1BQWE1KeVZFMk5Pb3lFSlh2UzBt?=
 =?utf-8?B?YUt2cXJyZEdENnIvYVBERjZGTHIvZzg2eVFWK2w2WTB3VHBERW5ZMnpVY3Vu?=
 =?utf-8?B?bjcyUnZtMUJzN3BkVTBGc2JHbVZ1VHQ4d3lWRWtJTHJjZnIxVWdjNW40Q0FK?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adda07f-126e-4a7b-6209-08dca6882585
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:44:45.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovTykedZK0QAM/qkEiAnuQ65SMtCwUfLASc94+dnBHY1em7xkt4MZiHpff+WUmHXjr0bSJh2QlNhE/kvMd8w/2xg8J4IEzEuaOBGr5XSG98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Add new attributed to tsinfo allowing to get the tsinfo from a phc provider
> (composed by a phc index and a phc qualifier) on a netdevice's link.
> Add simultaneously a tsconfig command to be able to get and set hwtstamp
> configuration for a specified phc provider.
> 
> Here is few examples:
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema
>              --dump tsinfo-get
>              --json '{"header":{"dev-name":"eth0"}}'
> [{'header': {'dev-index': 3, 'dev-name': 'eth0'},
>   'hwtst-provider': {'index': 0, 'qualifier': 0},
>   'phc-index': 0,
>   'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
>                                   {'index': 2, 'name': 'some'}]},
>                  'nomask': True,
>                  'size': 16},
>   'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
>                                     {'index': 2, 'name': 'hardware-receive'},
>                                     {'index': 6,
>                                      'name': 'hardware-raw-clock'}]},
>                    'nomask': True,
>                    'size': 17},
>   'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
>                                 {'index': 1, 'name': 'on'}]},
>                'nomask': True,
>                'size': 4}},
>  {'header': {'dev-index': 3, 'dev-name': 'eth0'},
>   'hwtst-provider': {'index': 2, 'qualifier': 0},
>   'phc-index': 2,
>   'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
>                                   {'index': 1, 'name': 'all'}]},
>                  'nomask': True,
>                  'size': 16},
>   'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
>                                     {'index': 1, 'name': 'software-transmit'},
>                                     {'index': 2, 'name': 'hardware-receive'},
>                                     {'index': 3, 'name': 'software-receive'},
>                                     {'index': 4,
>                                      'name': 'software-system-clock'},
>                                     {'index': 6,
>                                      'name': 'hardware-raw-clock'}]},
>                    'nomask': True,
>                    'size': 17},
>   'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
>                                 {'index': 1, 'name': 'on'},
>                                 {'index': 2, 'name': 'onestep-sync'}]},
>                'nomask': True,
>                'size': 4}}]
> 
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-get
>              --json '{"header":{"dev-name":"eth0"},
>                       "hwtst-provider":{"index":0, "qualifier":0 }
> }'
> {'header': {'dev-index': 3, 'dev-name': 'eth0'},
>  'hwtst-provider': {'index': 0, 'qualifier': 0},
>  'phc-index': 0,
>  'rx-filters': {'bits': {'bit': [{'index': 0, 'name': 'none'},
>                                  {'index': 2, 'name': 'some'}]},
>                 'nomask': True,
>                 'size': 16},
>  'timestamping': {'bits': {'bit': [{'index': 0, 'name': 'hardware-transmit'},
>                                    {'index': 2, 'name': 'hardware-receive'},
>                                    {'index': 6, 'name': 'hardware-raw-clock'}]},
>                   'nomask': True,
>                   'size': 17},
>  'tx-types': {'bits': {'bit': [{'index': 0, 'name': 'off'},
>                                {'index': 1, 'name': 'on'}]},
>               'nomask': True,
>               'size': 4}}
> 
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsinfo-set
>              --json '{"header":{"dev-name":"eth0"},
>                       "hwtst-provider":{"index":2, "qualifier":0}}'
> None
> ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-get
> 	     --json '{"header":{"dev-name":"eth0"}}'
> {'header': {'dev-index': 3, 'dev-name': 'eth0'},
>  'hwtstamp-flags': 1,
>  'hwtstamp-provider': {'index': 1, 'qualifier': 0},
>  'rx-filters': {'bits': {'bit': [{'index': 12, 'name': 'ptpv2-event'}]},
>                 'nomask': True,
>                 'size': 16},
>  'tx-types': {'bits': {'bit': [{'index': 1, 'name': 'on'}]},
>               'nomask': True,
>               'size': 4}}
> 
>  ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do tsconfig-set
> 	      --json '{"header":{"dev-name":"eth0"},
> 		       "hwtstamp-provider":{"index":1, "qualifier":0 },
> 		       "rx-filters":{"bits": {"bit": {"name":"ptpv2-l4-event"}},
> 				     "nomask": 1},
> 		       "tx-types":{"bits": {"bit": {"name":"on"}},
> 				   "nomask": 1}}'
> None
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

