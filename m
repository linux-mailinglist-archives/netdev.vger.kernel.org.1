Return-Path: <netdev+bounces-111631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A100931DC6
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5991C21D26
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54A143888;
	Mon, 15 Jul 2024 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQy+mSc5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22101143892;
	Mon, 15 Jul 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087104; cv=fail; b=m72qJHAPs89aONv+29A/THtd/Q8OMCl+jjv6AVxJAo88X/5CrizflLNrvYyhjuaXQ/HVBmp2avncvF5Zi7fkpAfCc8RgS7i2drwLsOp27WQ4KbzpKSnrUhxA0SFUMeKT+XVmt5hYZUR6cXp7GZHbNYQ1qNiTmaOMBxFeKsMHEIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087104; c=relaxed/simple;
	bh=iprTjpRKojH1jO8Ri55yNblAlsTR5mGwzcnLOOXCkoY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1ux7mHR11+vW7g0yjbocB+mjf69Zw33bYcmMvJ6bpqTJ62f4DEd1HzsrsC2NPHlK/5VNFOjosS/T6Qmwft/Ydh+02j8q6mZRutixFsaNP77i9hGg874joeZuxVzgZcjOkZjPdfBTLEy1XA+S727mNTAoDLFixp27bMwpt7d6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQy+mSc5; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721087103; x=1752623103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iprTjpRKojH1jO8Ri55yNblAlsTR5mGwzcnLOOXCkoY=;
  b=cQy+mSc5QmA7MSioYoXJg6alCIqzYNg6bvU9aBfa1qOdb53mfE47N3y5
   BSlBQBYXMQC/ZfhVTZGrRJuweFmMqtcgNVwplv/ec+qu4kY7orbO0xCtJ
   cjKqebws9wXomKMtngT8DH14CK4s6UXUlhmOeGK4hBeyFwnoWS5uJExz1
   yZyKCktRLROzKyDn+o/MWAGYejyGkMePI7NdW5VeGlGftnFI8cRvmGoVj
   4hz1SoGIAwi6BcwUMP1P/TSnbFKkx36JMtCtwX5oNTnDRKKkE5UP/ltTj
   hSTTNmlznvQkRQNlC1STSZ3ZxEnuoNVitapdkmiGfqR/vUuejoJ8hutBW
   w==;
X-CSE-ConnectionGUID: nwcVNhJIQ2Ww6ipMsB4utw==
X-CSE-MsgGUID: 53k7qbULRwSEpXdXdqW+Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18611571"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18611571"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:44:53 -0700
X-CSE-ConnectionGUID: Z0Im6XZyRqmqiqE2/9grgw==
X-CSE-MsgGUID: PiO4COKjRQGIyyZX+Zh9Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54156081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:44:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:44:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyAntkBB1GmNu9KJcQAY1pwCNKN1X+lXZqxkW6c0hn8Ear/Wez/HTsiYIWmeVi6MsOZP1I5vGtVuP9t20z16kmbiDVidj4G6IUB2GmbB7FrewT5S5PIr1nupwGTP+q0EoriBKMlzyL/+lBgInKl/AZi/2K5K9M410vivnTG7po8gfEKPFhdD2vvyiYCUGJ4UxMhcv2+rBXNMwppdha2VDx/gcsG/6T8fdw1SVTuiJHhIgWILqX/k9y/o2i3eNP4Qfb4v2GgOVBBOXc8QNuzwsgAcPYS+O1IJxpkWbNdXBObM9TQMpyBlpJoajQRlBWYeXtP2U9pDGOWSttQEav0R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntDJqAKvOL5P0uy/ik+P3wOfJKs66TPle6S6orJyTB4=;
 b=tnCpqlWEjVM5EHmxDl7/SwuDew1f3Royds7uo7eO5p5fGkpMqPTLhCXDw2gHlwui2+AignYbsyJ5Gycc8H0LsLUvSX9xPi5bUox3kdv/J9wVftuxqtqz4RiBgQEj9ENVYh7CJjNafIvMAVxMh+Ms810pGomUYxZw9GlCUx5rKRLG1TBDly9UlbtVxuJ0wc4K90M3EjznTUUMWH0DQdmy2s/dX9Y0WvhMEg+w0h/D/FxmpUpJhRl8fRTWcOwE80SOlTDJY+2TbOnez0IWdRo8Oo0i50l95JEjXcrKaHyJccJde+9uts1RCcl0kmrvpcDCInfxdFfVZUYgTWkNQw/q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:44:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:44:43 +0000
Message-ID: <01552dfd-a537-4d7e-ae09-71eea7356d5f@intel.com>
Date: Mon, 15 Jul 2024 16:44:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/14] ptp: Add phc source and helpers to
 register specific PTP clock or get information
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
 <20240709-feature_ptp_netnext-v17-7-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-7-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd80cef-7f81-453e-bfd5-08dca52819e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0laVkd0RFFvdFFGZnFUa0hqcUprOWxHTWpMMy9kNVl4aHhmR0tITVIyZDI0?=
 =?utf-8?B?QXl6aWxSTW8zQ3BBOHVpSXdLSGNIdG5zY2VuVnkrYnRDR3RLL2YvUW1heDRr?=
 =?utf-8?B?M1NFQXBiTU9lNnZRZE15bVI1TGdvMjUvZGt4WFFPZkFWN0J2Z3NyQjRkMEsz?=
 =?utf-8?B?K0RZOUFPbHg0bHZWNTNxSzQ5VVdOeFFrQmdaTmhlUGVZbFNOQlNFQVlMZlJa?=
 =?utf-8?B?WFVIT1B0RVVKR2hlVDQvNzRON3hsblZPL0l6T0ZJNzVRUVBLTW9YUlI2bmY1?=
 =?utf-8?B?QlpwQUdrMFg0cHpvUkhxRGtSRzdwZzE5SEpHNkUzMDFpREl3RUYvbTd2clZl?=
 =?utf-8?B?RDlXYUNhUDRPemZ0cHhZOSt2ajYwUTNsTFhtTElkU0IwUWJKOEo3NkR1MWFJ?=
 =?utf-8?B?N2tlMnRFWXhJZklZUHlhZ3R1VFBlRUZXYWUwNDJNWkFKaFFaWU5WeGkwVnVZ?=
 =?utf-8?B?TjhzYm8wSG9sRTZZUGtyWTZqOHpRUjlMd3Z2UFNna3RpMlRaci93cWhBS2pn?=
 =?utf-8?B?QzdmeFRSTGU4ekkrckhLVjA3S0wvWVMvU0xyL3A4dUpBRHFDR0t1Skw2dzNk?=
 =?utf-8?B?Zzg4WjMvNnNlc0NIckFSQ0U1VFk2ZkFXbzJnUlhLdFlSbGVqSXRJVjluaktP?=
 =?utf-8?B?V2tscGtmelBrU0ltcUVyT1ZwTndLcWVKZmVsVlJXMVJGb3V3ODBsNHkxSEVh?=
 =?utf-8?B?d2oxbndMMkQ2c1hzRkovYTAyU3hDbS9CUll6Z2VNRDU3YkR2QVBEdXNWdFpW?=
 =?utf-8?B?dUJaZ1piUnYweGpERjAxb3ZuNXdnSmd0OW0vY1dncWhXN0gyMC9pb0VJSm50?=
 =?utf-8?B?ZEJNQktXd0JIdHRnY00rTi9sZjZZc3d1Vk14SXhzVVU3b2RpOStWeXMxVXNJ?=
 =?utf-8?B?VWtDYlJpL2d5dlFIMlhMbDdLQmNJdE4ybVFyZTdsR2ExT0NrdElEa1RQTWlB?=
 =?utf-8?B?N2lLZ0FqUG9FMU9EQjhsYzRmWXhNU0RPZUNvY093cUMyOTYwR3FJMkJGLzBQ?=
 =?utf-8?B?L2lOTW9OY3pjUW11bWJXM3VQVnpEWEw5c2hrL2xZUnFOUExnMWc1ZmwxT2pB?=
 =?utf-8?B?TjFSNEU0T2taMWZtTDhZR29ELzNtVkYreWRDT00xd1c3OFhWTTFGZ1lyN2Ji?=
 =?utf-8?B?Qitsb0hMZFB0aTlqUUVkTkZwaCtFYkU2Wk4yNDFBTVdtVkFUMWtieitHTFJU?=
 =?utf-8?B?RUFMdHNOazBQaGlhRWpBMEp3OXdwemhpRXA1VW5BcThnVHNYWTJVRnY0eXNL?=
 =?utf-8?B?OWh3eUdnQ3pZL2p5aGRwakl3ZDFOandvc2VmZ3UxanV1TnM2YW5FN2VIalky?=
 =?utf-8?B?RThaOTlLc0RrY0FPdXIxRVZNQ1FlMlc2bTEwT2k4bTEvZ25ZalE2Ymp2cks2?=
 =?utf-8?B?TjR2MkFDUWtZWmIwT3dMMm4rN3VMTWV3cGVYK1BKcXpmL05VaHVxcHZWNG5U?=
 =?utf-8?B?WGJhME1qb3ZBQXFzb0JrTC9qR0dkWldHTlovd1pZSmZnNHdWL1EyUzZNU0NI?=
 =?utf-8?B?ZGtqMkN0SjlIWUNaUGhMZTFMTWRlZXFtRmhhY1ZIczd5OVE5Zld1cTZXVmJL?=
 =?utf-8?B?bVNrZFBvaC9qeDhCKytNL3BBbHYxVXVyN1ZweEEwbE9NVDdTbXJ2SjQreU9S?=
 =?utf-8?B?cCt4Q0wrRDU4WG5WYWxjQ05xMmRLVFpKWkFIT2VuSkdjWk9oV3JCNndzeXJ1?=
 =?utf-8?B?VGpnWTJiS0JBZzJybWxCNTh6TjFzYksybEFxdVZXQzAyeVdoRmJub1FydG05?=
 =?utf-8?B?TEQ0cFBWNVRFbnpZVnFEdlJ3Qk5OQmpiQmFqcFlTOTFvSnQyT2xFNU1sWTIv?=
 =?utf-8?B?ZlpYZExqcWJzbXUvWW5lUFRpdEtvN2tiUXBCVXVQTDhZYjJoR2JRU28xVmFi?=
 =?utf-8?Q?RGPzHVpjz9Ohn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlZbVhNS0hTUlpCVjdxd3ZNc1NzaTB6cDBHVmNEMThBdE5kaWQvNnBLdzhy?=
 =?utf-8?B?YVVraFZhK2QxSEMzQ1g0L2kvbkpVSDBTNXNzWW13ZVAxV09aUE9KZ2Q2TjlG?=
 =?utf-8?B?U2tOeEJkZ25wZ2MyMlNmSEVFOGhUYzllTkZLRm5mcDVuUjNFa3ZqOTlualhO?=
 =?utf-8?B?cERBMXJPdm0rd1lmdDBocGhSQk9paXRLeGJxZWhQSlJoM0Q3dENKdkRxTnZP?=
 =?utf-8?B?ZkttaGUxVFFqSmNKaHBBdEExcEwyM2g1OG1VeTVncHNxWEJkb2VVSFNVM3I4?=
 =?utf-8?B?OVg3V0FOZG82UTdobnN3aG8yWS9xMjN5b0hvcWwxc3JrdE8yQVNzN2FQVHFm?=
 =?utf-8?B?SWJjb0hIVzhNT3pPano4QksrWU5ydGpkOXVUdTJxZnhLbHVsWFZKcFEyMk4r?=
 =?utf-8?B?RGtPTlZrVUdFWGNnNFM4aUZuVnlnMEJkT0dXRTl6dmY0ZXJEeTZmTUIzS3M0?=
 =?utf-8?B?anpQem5XQ21SQzhsWXU0VjBtSGlEcDQ5MmtPVXVVUkxwbnAySGM2WlV0NHhs?=
 =?utf-8?B?SE15MG0rdHRsZHJORXppNm5kdlBzeDdVZWYyUEE4VWxVMEUzdnphRE9xZndl?=
 =?utf-8?B?OVRQSEorOHRLVG1Lc3dZdWZhWmN1Wi80ZDZBZHRVL1A0SHN5NFNvVm5qU1or?=
 =?utf-8?B?dkVMWXRNQnNZRWJLV0dxTjhQT1c4eDI5cmdmZGFIcG9majNqY05iejVleEQ2?=
 =?utf-8?B?YzFzN3ljcVFZWU9TdXI1RVlscVcyLzQvd3hmWVhtTmNaS2paM1ZIZDV1WVVD?=
 =?utf-8?B?dG5CNXhRRWRkTkdtRTJZeFgyZFYrNEJzRlR3bjZBQlhHT0JsbjRxY1Y0UE1L?=
 =?utf-8?B?V0tNeG9jSnFmQVhOakNsbVpHVG5XeXorbngxMGFWYmUyclkydm9ZelRUWW1X?=
 =?utf-8?B?Rm1CUnoyekNuVG9vSGFvYUxVN1k0UTV1eDB4eDRENURCR2dReVI0dnI4QTBW?=
 =?utf-8?B?N2JJY0s5VmF1VUVrcVk4dTJZWGVkeEs5TEJldHRxQjZWUzhKS2tLK05EY2VY?=
 =?utf-8?B?TWU0cTNSWFF2clBKc25QRUpjNkRDNlhxdFZqNVBXWDc1Zk9OUU9ROE5ucS9w?=
 =?utf-8?B?N3BHRUVRQVRQL2ZpR0s4N2VEN29MZUl5WXNWYmR1MGhDTGxTNW10bGIrWkpZ?=
 =?utf-8?B?WDF0MGhObXNQWkpDM1M0azg2V1lVT3M5R1lLTXpzTGZFamVMbStKN2Q5a0l6?=
 =?utf-8?B?VHd3U1pxdjBHazFlTE9uK1JsMVRrNlVuMG5pTFgvd3RDNzhCRkl2K0J1VHFr?=
 =?utf-8?B?bGFkdXVRVEdiWjhRd0ZjY0ZsZldYTXh0a0xSeEVBaXN6ZndaaHV3ZTlrejUz?=
 =?utf-8?B?a0NlZGxqdzdJcGNudm05Q2JtQ2tYOTVncjNXS2JCakJXUDYvOTFLWWgwSzc5?=
 =?utf-8?B?TUx5REVZa0xmSUQvYThwdGJKT2Y1encxMWhSTmxkVEpJbmYzeHQwQjJVMDNo?=
 =?utf-8?B?VXg3ZWpZc3E0SnlNYmdSN2c4dzl6ZEV0TG0zMkhnZEI2MW0xNkR4OStUaVdz?=
 =?utf-8?B?am1YU0NVV1l2OVdSSXNsVmdrOGFzNkloQ3pIdHIyQ3hCVXBIZlRFTFRUd0Vn?=
 =?utf-8?B?K0VOeVhCUlVMa0k3M2NPRGFDSkg2dldJN3pWUUcvTWdaeUgzS1BGOVM5d0Ni?=
 =?utf-8?B?aytaVHU4cm9xMG5QcmpMcFFwM2xGalVOWDVJWm1mMlU1c1ZjU1N5OHN1dUJV?=
 =?utf-8?B?RXJ1Y2trdG0wdG5SYUVQSWRLUmdsSWRxalNBbWJnRVFWYm5ZMzNKNDZadjZR?=
 =?utf-8?B?OGxyenFkTWZ0MGZhZGprV3MwMTFQdTM1SGp5ejZJT21TSGkrZGZnQU9temxS?=
 =?utf-8?B?Y1JNeFc3ZGlpVWZIYWc5RmVNakxpOWF2cEd3WkhUR1g1d1d4WnNWcjNLZlQ2?=
 =?utf-8?B?WXhHQ0FNYnRkV2lXZEYvVVNEbTJ4by91SWZEc1YxSkVJb2x2VGZ5dldYbU9Q?=
 =?utf-8?B?bk80RTdFYVpNN0ZzcGlMUGR0eTMxRHloODRPdW15M3FFMFlrdmljK2RwUlNQ?=
 =?utf-8?B?T1dMYUtJK3RXa01WQlVVSkU4QjRpaEN6MDkwL1dUSHFSVVZaME1Oa0xVenRk?=
 =?utf-8?B?RkxxUytlcjFka0VMNWFsUzBXblk5VUNnVGdaNXppcEJNRE1CQmlsamRKeVc5?=
 =?utf-8?B?SGJleHRycFlEZ1FRU0hzbXphSnZDTGtabzVhaHVvajg1VmtVTGQvS0djMURL?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd80cef-7f81-453e-bfd5-08dca52819e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:44:43.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itNvYuTUiRKyIQjtbWo1l1aWp/4PPsDTOmlulrMwCfFvpak1wtDbTCyYGdpkBwAILfT3jYs5iSC4SxTIwbZa5VqJyYF8YxgnUPqLdq1NP6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Prepare for future hardware timestamp selection by adding source and
> corresponding pointers to ptp_clock structure.
> Additionally, introduce helpers for registering specific phydev or netdev
> PTP clocks, retrieving PTP clock information such as hwtstamp source or
> phydev/netdev pointers, and obtaining the ptp_clock structure from the
> phc index.
> These helpers are added to a new ptp_clock_consumer.c file, built as
> builtin. This is necessary because these helpers will be called by
> ethtool or net timestamping, which are builtin code.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

