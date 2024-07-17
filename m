Return-Path: <netdev+bounces-111917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3472934184
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643061F21B75
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE661EB31;
	Wed, 17 Jul 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3C03GrN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B1469D;
	Wed, 17 Jul 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237731; cv=fail; b=rXsoNXmqP1YOfE6sKOcNhQwv1wf1lqEjYtVvoB5pDKRXCxhnYoIu7udVpF/w7vJtIh9Ty8UF32mijlkWaOO3b6A8pGgt4Q7blFjvy8Up/nc04cuEAnIp4EjEtg0GNZVzzhxAzb0M2XhGRKHa0gegSLuHhwapPuauowrULn6pVF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237731; c=relaxed/simple;
	bh=6/vs9Getlbt0JVhNpUXJtpYpRo3J3mXsYqAvRmKbSfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lkiMQG/H+ROLS6ZFosQE+dMPwfGe9eQP9q0G9qo7bhC0TmtsjR6K15jdiC4ZyA/JRsIx5GBl2bBNfEac0dt18KmZ1uGSphp1/l1Abr38a1ScB/kJRzvAWU3JORsq5SPr28Y6s9eo6AEOxnicta4ztyxvhJkInguTPDY/n77K+dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3C03GrN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721237730; x=1752773730;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/vs9Getlbt0JVhNpUXJtpYpRo3J3mXsYqAvRmKbSfw=;
  b=X3C03GrNGyEGjpAkLTxi4jDiCsOQcd5xE8JMmdxkA750PwdCCrSfsTqn
   ikxSLoFHimL5QE+glNW0ywWfrmEBXQnyxa+IIPxwGusTRO7VGG6Nh2uLG
   jU4+aZLQrQTzyIVXVWV9OtHilrEOonMyVC/McT3ySWGFDBJ0O6r1K6448
   ecMkZMQowmxcSMLQ3u9CXPPuq9v8/Rvp9kwv4+ZkBKKxiB2ZRIB785iaG
   ZmgSTUcF+/yqws9smB49y43DjbQ7R6uRMX73U+2ztEVSpOOKlYlrTH5EQ
   Gx1Z1N4Zl0UAHIdwdl8BV1EF8kJXSkLPtt07kOG+0g4WHqGvlZUaXaEwb
   g==;
X-CSE-ConnectionGUID: F4neYarxT5iXLGrvS5lfNQ==
X-CSE-MsgGUID: JFhm8jdIQ/qD0vo8c8I/Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="22571566"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="22571566"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:35:28 -0700
X-CSE-ConnectionGUID: w8Py6r8hQCSD/0HYYr/S0g==
X-CSE-MsgGUID: vnHxCZmLRUGKV+DfMx5btg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="50350663"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:35:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:35:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:35:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:35:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnbBuxsiV/GLVDoJp/Zr530K1//xneIgwwpfz1jemR70Mbo9JYunBRUL7ZOUCmyF4rAKziWqwl+Ufhy3zcpVQ2STY98PbkqJ5X2O0KymHah61Bnd3a5D09QYtYCczMPkiLyZLziWGzYKe1RQrUlxzoCVnJMxSUGW1wjiUjkC5NjD+3iUwfAbAIZKdxLT1L/kMGJQmnP5CmthMdHgMwTAtr9ueTcTIe7fuf7RDLrGX6CP/YP0ZZ1u1onxIUvL32oYSIOVEgr7c/xDr6p/G/OpfyQDGSOrNscvlwS+jj09sBF6nMObPu5FzIIfG6tNG0GsKEQDa89Mb+oIkQcrIjaDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm5vPEvYB9pSbgSGu5Bd6OZQfBbJHtmLoqR7Ju4zExg=;
 b=EZxx1pBbN4B2GE/6XSeJStaMliJv9joHfjrnp9dl3bsC6gQvHcApmJwdmAmVEgw9F18azLKzrcH8HgkqnHnHst9R3qMkLEz3LZ5L9J0G2kfTfZCkw8NRCE2cABlYaK9RTjjQM2IXasV0sIjsSox1aW6xbZTF7+Q4umVRxLzkapgAoAnvM2xSH4Rz/CtBHxBpgQUVT9fTHO8xOh+SLVyxAaFc3jZBOmOmFnXeknk0fAOvhrV0Q4LKIKvCHdYglAYYhwuNgdYj0mok2yGv9yCs79VmHauyHqMPz+MEE7HfTzJjCz34w7HxMUwXRIGee3CqGZKaCdBzeldjNty0+pU8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 17:35:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:35:23 +0000
Message-ID: <667b3700-e529-4d2e-9aa1-a738a1d70f0f@intel.com>
Date: Wed, 17 Jul 2024 10:35:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 12/14] net: ethtool: tsinfo: Add support for
 reading tsinfo for a specific hwtstamp provider
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Radu Pirea"
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>, Simon
 Horman <horms@kernel.org>, "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	<donald.hunter@gmail.com>, <danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-12-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-12-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cb9e9d-fad2-47b7-6824-08dca686d688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHFLaVYrN2xsU1ZGRS9rWFBlQTJpc3ZteFJNcGtWYy9nc25SWmlyZDJXdGdR?=
 =?utf-8?B?Q3JCN2pVMUtjNFdxUHZmckhPYWtKaTFNc1hWTFZJUHlnYVBxNFlYdnk5dmtu?=
 =?utf-8?B?RmVmdWFabm5jeWgxL1JXM0F3VXVwTnpoOWVXRVZ5b1Z6V0pRaEpTVVdMUnF0?=
 =?utf-8?B?RUVvelU2RjY4UStxd3N4TWRFY01BQzhyTnJmNzRucXBGOEFScGNIb2VLTXJ2?=
 =?utf-8?B?bXlMMWZiYjFqOHN1ejZlSlBaWFJJRndmR0FJbVlyZHp2MTZmVkZjVWVXRTZ1?=
 =?utf-8?B?MEN4UjZtQkowblRSZm1QNmRMQ0R1MXJBSjh5aERwWVVQMGh3Q1IrZk9SNnUv?=
 =?utf-8?B?RVFlakR1MjlDMmVFVC9ZUjd6cmNpNTdwV2lSaFhpUDBKZW5sYXZJM3hHVEov?=
 =?utf-8?B?RTVoTEMxSHpFdVI0N1l0ZmhCaXVhb2ZUUHFZN2Nua3E1NmtwUE5ka3M3T0Vx?=
 =?utf-8?B?SVBkOHBJZ21OSTNHSUlNM0FpLy9pYUEzNnVxd010ek1KY1FBRHVnQkRtQStt?=
 =?utf-8?B?UlJVWWRHOVZDUnA4d0YzMHVyMThGN0lnQmo4WWl0Sk1KcXVjcFZRWUpCb2tJ?=
 =?utf-8?B?SGFuNW9OcGtKTFJuVHl5amhvTERnc1dIckhJcmtWZ1ZSZG5MOEhLY2xldVFi?=
 =?utf-8?B?djhlbE8vRE5WZ0cxQXZjTlkrOWd1TGJoZjY2Z24rYUl4U1ZESVBHeHlWM3Jt?=
 =?utf-8?B?TGY5SGQzR3RsV3lMbWI1YWJQdXNzcVF5WjB5VHpjbGJZcFJDNFJQTXZORXd4?=
 =?utf-8?B?SlJNMEdaNCt5dFNuaVZYVlJORWhGU2NsZVlVYTlJQTA0a1dMb2pYNEhnNVVk?=
 =?utf-8?B?NHV6ZWszSHlQdWlLdlNBdzN1Qm8ybWwxZ2NNd25RVVNpaFM0SjZjRU9LcU5j?=
 =?utf-8?B?M3VGZzRCNzhuMXJKQ2lISXFiVkx0N0NQOFMrSGFKeldJakVBZUoyRmVJRXVF?=
 =?utf-8?B?di83TVZGN0xrTmREU09TU0RpcUVwR2NOS2NacmhHeG9Ld2kyVnpJUEJkNlNQ?=
 =?utf-8?B?L3BsNGRwU3g3UmtZclFhSUJWRWhLTjE4cFhrSElIN0VMcnVLRnNNNS8zTkw3?=
 =?utf-8?B?YWVoS2dUWm5NbHkxYXg0L2lnRFFOMGxURW5mU3FTMTdpQjQ2bUZNQ01KYUNh?=
 =?utf-8?B?cHA2SnpWTG52c1Noa3hCbkc3ZldMa2tYQXppcjMxVUNVVE9vUXRJN3M4a20z?=
 =?utf-8?B?Z1JybU5jSjAvQ3hXd0FHb1kwTHZkK1ZtZmJZMnp0TmY3S1lRTU92dDZNVTk5?=
 =?utf-8?B?SC9OUGY4OFgySlU0Tkg4dGQ0bmJheXNQNmN5M3U2TU5MbWI5bmtSWDBGVUVC?=
 =?utf-8?B?N0ZMcE9nVzJVZTJIVTltZE9xYUJWOFlLWllmMGFocWI1b2tFUlN2V0wyZlZZ?=
 =?utf-8?B?akJkOWZsUWlzZTFKNms4VjZUK2M4UlpUdTBiUWx4M3Z3dERKQWtkTE55ek1E?=
 =?utf-8?B?Mm9raDJKSmFLQ00xMDRMWEw3aGJBWVhYS0Q2Rzdnak1JY0ZoY28vMzU5SVBs?=
 =?utf-8?B?L3ovSFZQZ2Iza3hHMm1ycDQvcmZJVkhyZkJMYU5EbWlNRFI4ZXRSbVZaaDh3?=
 =?utf-8?B?UFZvbjBJMW0vb1g1bmVZYmpLdVNDbStTQ25KVUgyYk1pVDIzOFhHNUJVSkg4?=
 =?utf-8?B?Slh3WTR0emhBaCtISmo3L0tqb2cwV2lNM25kMGtyVnd2ZHMxVFhFbHFFRUpX?=
 =?utf-8?B?b1praVMrSGRTdFhKNXdWYjhUZFJvek9nbVpCTUtwZnRHS0NKYlJNN3VQRmZl?=
 =?utf-8?B?NFpWbzdyVXRwb21DR004WG5ZNmxVQ1dVb2NmZmhCcTFLSnpWais0U2NMcGFi?=
 =?utf-8?B?aWI2UXB0QVJsbEd6dmpLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm8yNUFaR2xNN2c0RzNMb20vcVRVZENhVGw3UkpERnVGQVNiaXptWjc3RUFn?=
 =?utf-8?B?SXUxaUxmbDBCVWg0c0Rpazh4eTB4TEt6TmlPVUFIUDE5N1dOOUNiamV2aWp0?=
 =?utf-8?B?aHlSR1VTZzBXVnRDcXc3STQrOUh4cWQ5TGJROFBBLzloZTF3WnQ2cERjWlpi?=
 =?utf-8?B?OGlocEovRkFkenRKN21VdmpkcXZTOGVaRjI5Q0ovOUk3UVBlN0lvNzJIUHdG?=
 =?utf-8?B?VllTdUdWWU9aWmsyVkJNWXV4Q1JtMUFzWGV3ZHAyOEFkamFUMlZ1U1h3OU13?=
 =?utf-8?B?OHFNdHVSdVZhb2k1M1d0cTZFY0RMMC9UWk1ydWQrQlFaNExtcWl0cmc0U2RH?=
 =?utf-8?B?QXNwRkNNZktsVERxRFc3YU9mSkhBQ3FINjNxM05lSFAwcFhKV2hHN3F5SW0z?=
 =?utf-8?B?dW9RL0NwYnVxS0NFWXFiNkc1cUlqaGk4bVV5ZitxeTdvL1RHV0ZOdTI0cVJa?=
 =?utf-8?B?SnYyTGJvWjBQUU1za2RjQzIzRkpwNE8zY1FpNDlaR0dTSGh2RGRZNVZRTEJa?=
 =?utf-8?B?TUUyV1JhcmVIc0E4NEFPZG91N2RGcXdXMkdOV1ZOQVZEMVduWTVTWTU0Rk9p?=
 =?utf-8?B?YVpGQ2x4ZisxUXZBOTViNWdlTW1HZmVVVVlKY0tMME9xYVZzd3JWbkVSTjd0?=
 =?utf-8?B?Qkd6QWJmd3htbzNPT3h0SldiSzcxZzBBaStNdUY2blFla0hLOFN5ZHlZUXFp?=
 =?utf-8?B?QXkwWFJQQUo3Ti9yK2dreGF6bGVuS3g1NXVmS0tGTk5TbzUxQkZuWVk2TTRG?=
 =?utf-8?B?WnFkVTJDcVp6QTRnSWdCc2NnbjJ6cTdXM0xWMVB3aVNUdkY3YUJUSkp0cjdG?=
 =?utf-8?B?c2JhUFBlL0RUVHFGSWIyeHZmd0RMZk03YlRzZzJrb3dEZ3VNWW5kck9MZHJN?=
 =?utf-8?B?Y3h1eDNSb2Zjc0N3TXFRUkFYYjlyV3JmekF4cXNpMEpXZW1OLzRaSWZBSytr?=
 =?utf-8?B?VTR5S0lTeU16Qml2RGFwK3l3ajZxNEZoTkpDRExTN3ozWkNmZTE1VkUvb2s0?=
 =?utf-8?B?RHdSSjRTVzZxd0NCeDZ2aDFlUm5GKzlmYzBYajZOUWF4aWV2SU1FZ3ptZFQr?=
 =?utf-8?B?bkp5Rjl6VEJjT2tRWDV3NERsRmthMnVURUtzSGFDRkl4T3lCVUM4LzErd1FC?=
 =?utf-8?B?T0k1S0NvZytSUWtGK2tvWFVxUE9NdnZrNGo4dVo5M1J0MXZVUk4xK2lXYUpm?=
 =?utf-8?B?eHVqM1BGOEtxWXRYeDN0T29mM090MXpGc0tPTGZPQ3dUL1R3bmdsZzBVR1ZJ?=
 =?utf-8?B?SnNIY2VXb2piTm5SS2JkUk9ORSs5bTlHbGtjUzB6UFoyeFpDdU5tSGw2U2xi?=
 =?utf-8?B?Z3A4YVo5ZkNKTVA2Z3ZtWlI2cEp5dFRVbnZwckphb2dVVnJDT0ZIR0ZHZzFP?=
 =?utf-8?B?NWVtREh2YXRiUDA2YWt1L1k3cnRiMGJnWnlTZlg3SWNDd0dqVWFnRnp2bVM4?=
 =?utf-8?B?QVdwVEhGa3l1Rlo4Z3BEM0xsVXdqQXZXQXhpK0l6Si9kcEIwVHJmU25mRmdJ?=
 =?utf-8?B?RlRyazdFb09HNmtVVVZ4WVNhYTExWmdINXgrMWRETkpiWHVZZkFJbE1ib3dB?=
 =?utf-8?B?eWhFTmVieVVNQmlLREJvdDFydkxTZ2ExRU1Rc1lwVGg0cTJQMUMxZ2dxbmV3?=
 =?utf-8?B?U1VqRURXSzVGSzl4YS9xbGF5V2htbXNYb2xpL2JZa0JtclpKYW9FOXI2VnJo?=
 =?utf-8?B?Nk10TXJLWEN3QWxHZFZsbTFCZUVWdW1nTzVoT3hwckh5QTJnS2VsZWpsOWFx?=
 =?utf-8?B?aFpnRVpuQVJNK0t0NnhvVlNJR0ErRXR0eTBUMU14bGd6QXpJRG1EUm1JUEpR?=
 =?utf-8?B?clg4dHFINnpmdDU0WmdkWTQ5RTZITWF4Vi9WYnZYTjB1T0R1RTZrVzhXL3NG?=
 =?utf-8?B?Z0Zvd3MzV1V5M2FVb1h5a0d2a3hyRm4yNjlYUzFCbENHenljUXBDdzU3NUMx?=
 =?utf-8?B?T1hSS1crOW1XT3VYRGJia2hZY05Db3NjT3dHeVFOaGRnWnhtZGIvMUJIbktw?=
 =?utf-8?B?UkxMTzI3enRjN1poU2pySVUwSUV6K1Q0akgvUks4MjhxN2ZkRDlGVjRVUjJi?=
 =?utf-8?B?eDQ2b3phY3lnRmlZWm9iRmRzSzZZVmQ0SDlZMDNpZ2o5MCtkYndjaS81UHJR?=
 =?utf-8?B?QlZUV0NUT0k1OWpWSkdGT2pKV2NFUStLTnhpeC9rVWE0UmJXWldickVPK3Q5?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cb9e9d-fad2-47b7-6824-08dca686d688
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:35:23.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTUzAqeZ8Wt1snkoo6RuT5MFNSVwhEhgrDMCsZ7pGMfotYr90U5VPXdK6Y4QcvL6vWTKShsCuhnucg2uOPmb1N2d0JbuyVdjm+AaCm+IbIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> Either the MAC or the PHY can provide hwtstamp, so we should be able to
> read the tsinfo for any hwtstamp provider.
> 
> Enhance 'get' command to retrieve tsinfo of hwtstamp providers within a
> network topology.
> 
> Add support for a specific dump command to retrieve all hwtstamp
> providers within the network topology, with added functionality for
> filtered dump to target a single interface.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Pointer attached_dev is used to know if the phy is on the net topology.
> This might not be enough and might need Maxime Chevallier link topology
> patch series:
> https://lore.kernel.org/netdev/20240213150431.1796171-1-maxime.chevallier@bootlin.com/
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

One thing which applies more broadly to the whole series, but I see the
focus right now is on selecting between NETDEV and PHYLIB.

For ice (E800 series) hardware, the timestamps are captured by the PHY,
but its not managed by phylib, its managed by firmware. In our case we
would obviously report NETDEV in this case. The hardware only has one
timestamp point and the fact that it happens at the PHY layer is not
relevant since you can't select or change it.

There are some future plans in the work for hardware based on the ixgbe
driver which could timestamp at either the MAC or PHY (with varying
trade-offs in precision vs what can be timestamped), and (perhaps
unfortunately), the PHY would likely not manageable by phylib.

There is also the possibility of something like DMA or completion
timestamps which are distinct from MAC timestamps. But again can have
varying trade offs.

I'm hopeful this work can be extended somehow to enable selection
between the different mechanisms, even when the kernel device being
represented is the same netdev.

