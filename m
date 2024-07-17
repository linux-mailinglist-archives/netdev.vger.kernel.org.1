Return-Path: <netdev+bounces-111911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614F934169
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E0C1F21162
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70B1822C0;
	Wed, 17 Jul 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5NofSM1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3917E902;
	Wed, 17 Jul 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237031; cv=fail; b=Sv4bRPmu5yKZyQcOTlEy0n3SZl9/xzEOFXCuNjtHE46l5DhCjoGMHQHWwG4EVyEHYVD/hb6W/5LO2ywhQdjFTjYE6kOa6MsPj5ieS0VdqXkiI2pp134DfNbkRYgGQlvICH+lpCGlwl/a5MXfZEVeVbhyNd3hLiMqJwq6gwfwAls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237031; c=relaxed/simple;
	bh=Z2qV+r90UaXh2BAiUWiou6aYdN22bz6a3uAF0s8UYJE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SsGAdB8a65jtVfRtRZ1YtqSy8lashpQx/dwBJkb3OAlUGj3ekEB8YJGRxkmt/i2WQmUG/taOjz1dErTZAgbo/Om921SBmzK6LJsaVS265ZbScjOWv5Ejy8x60GRC33rBRyQ1QkRAtt6J/WeyGGivGOsHq2Ntzv1ccOjoELWt9h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5NofSM1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721237030; x=1752773030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z2qV+r90UaXh2BAiUWiou6aYdN22bz6a3uAF0s8UYJE=;
  b=F5NofSM1qYP4UXFQaLGlZyw36xQ0VqPZS1vYBGugpAJtRsqe928EqXJ2
   DKUpp72TU2ZdP66lj890Mggm3qHDF+4Pinzb+3jHl07j3RQ0UjurwoxRk
   mLPUbXl1mu1WXAt81hFDs0lDkJwEb5h8qS4xAGRNvx/ALJu7GcYQhhJdG
   ynxlQbpbGU6kJJ4PJ67qGbHVr23CpRrXMbkj07bLzV7nRvb2q6XibgHs8
   38d6kOjhFR/4pjScEWUhAl+iSiX+bg9zzWOs847VHH3W9rVcytwQUQZIG
   tW3vLOZp0zJDldNBOln+4GgQZG/0qQIBpYrJXrgPWu4LMIHcyrkEURJmw
   w==;
X-CSE-ConnectionGUID: BPyq/yllQHeFG/k8OEykjA==
X-CSE-MsgGUID: jxzNOp2KQRO7WDWAyX2+qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29908796"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="29908796"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 10:23:49 -0700
X-CSE-ConnectionGUID: a2R2w7dtSyGXNySkookuWA==
X-CSE-MsgGUID: 9bUJGYmuTQixYgqqgpTlAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="73704023"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 10:23:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:23:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 10:23:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 10:23:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 10:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVk45wXpSboDzoK13NEaBttaHfKiQKwwcVfU8Im00g9ZBf4ceHSFfZokAlDzT4yyxP5pwBg1RE7gFK9ImrqSvFGBaQG0YwIUpEmOd3OK+MIBFA2smzUWcWIJgzBStWKUiN0FvmH3mh0yE3kVWQbbEb0e8yrcH1NQzVVikOySRI0MB/+qWaHCAvUFRnqNFEDg0hQSR3JdTlNbqeZDYauqQ9l/06OWhhGwWzr7WPuAhvyHMAMMFaO+BJmiyyQmXHo8K88huAotSfp8XUz7n/Q5RUGhUPILVlYYdDGh0zUALipVQqxme+iKVbV9hO5g0WAoaalMaihovfxkQB2MKzIUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h093UsDSMOxpsukjdad73mzmYG4l31wV77hKEh+Vxkk=;
 b=Kn07ORb11JgVfaFi9LfUngciTMQBOaeD+cvWB+PD8v/jq3FYhNNLIDyjk38DA7PIsmhFMYGLEuWnS9HhiMCTwt7Apq4fzw25NR4h5RXrGCglroTxQljXoRwAGUjOqYFX+6k0pkT+gLX9MAALPWbaAlPzvt4Fdc6Pq96a4RQvEJBrMTviIYXZXTz5erWTwfXEptd+5ZCSjW7Oo9h31riDHo4kAX0KVkVw6/Vw5JaPnWhB9/rP0gP5IJ9JKQEX4pjIQOULPjHdcWF7HOmjr8jn7S29aHDF03eKN0gSP//O73su6+1IYSKEZgV58i+Qp7HylWQFBRxP9A3bI2HSfJeuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 17:23:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 17:23:30 +0000
Message-ID: <2b7071f4-d986-4104-9fa6-6e04be34614a@intel.com>
Date: Wed, 17 Jul 2024 10:23:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 09/14] net: netdevsim: ptp_mock: Convert to
 netdev_ptp_clock_register
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
 <20240709-feature_ptp_netnext-v17-9-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-9-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:a03:54::46) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9fd89b-81a5-4ded-b30b-08dca6852d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlkdGd5OFJNbXpraDNnL1R3SzlXRkFLMmx6QVRUTTE0WkdDQ0IrdzVNWnM4?=
 =?utf-8?B?a3AyYS8wQmtkSG9QVXMwakhsTEZJbitYcmY0S3NWSXRacktRWURyK28vZUFm?=
 =?utf-8?B?b2RTcUNMemd5YTJCdCtPY01DUjUzQlVBRkV4OStNMmdJa0lxVlpMVHdOUUVw?=
 =?utf-8?B?Y1o3czZweG9NSUpLRlFXekJ2ZkxTNUNLVktiTnpBKzl0WHg4TVF2aEhHaC9B?=
 =?utf-8?B?R2w5MzA3M2lTS0RPL0c1cm1RbHZqbDE1QkxxSy9LSm9sQ3pVVWRnTkFiOXht?=
 =?utf-8?B?N1YvMVF5L3RMUkdhdjBZL3laZEVPdVA1ZWk4aWFsQWtrOHhQTHpNOXRDMEdD?=
 =?utf-8?B?bWZlN2hBdGplOHFXcEZNNVAyTnorSnI5MDNJaGRSYi9tOGVpNWk1VGt3UHp4?=
 =?utf-8?B?VmpnSDNVcWNWNFZTay9yYjZQc3p0YnFzSTZUdnMrSDljNkVVaXVsdU9IeFQ5?=
 =?utf-8?B?bGE5emNDSjNvTnUwVVBaWW5UYnJTZTVyRjRYSktieGgwRUNldEs5RXJSWTZo?=
 =?utf-8?B?REpVTzdCM3Y4M0t2Q0hucXBOenhkWURHR0ovaDg0QkZTZTZtM21naVpyV3Np?=
 =?utf-8?B?T3RCcGI5dGNxTU1yNGFKUmVqUjA4ellpY0Q1RG5ndi9WTm1KM0FtMWx6dEhY?=
 =?utf-8?B?ZzRzRGw0LzRSZkc5bmd2MXVRM3FyUys5WWU5UlI4T3RpS3o4SDRkZE9QN3FY?=
 =?utf-8?B?Q3cwNCtNME0xZ1JYQkUzbTdsT21oUXBnRGl4RnIvNGxUdVVGRWE5cDdCdHN5?=
 =?utf-8?B?STYxbG95R3VoN1VvWlFWT3Y4ZjhBeG9tcktiQTJyY2VMdnV6eXlkb3JDWGVr?=
 =?utf-8?B?clRTNVBoMjBhbk5sWnIwTmRXcWRrZ2FYWStyZEUxTXV3aDlmNDNYUFBhdDhm?=
 =?utf-8?B?WVZYK1dvVVBMbmZDdkRadlU0cXh3R3ZBemNKOGZXU3ZGSEg1ZTBaSUJORERS?=
 =?utf-8?B?STNtZ1dGRG9QcDBNcG5FVFBObzFvaWFzdThKbDRSSWNJWEhiTERDNFRqdmow?=
 =?utf-8?B?OXdJOXdXVE01QW1mTm9VOTlDV24zaHNwRG9mc2t6dmUzT0ZVNTU2Z1REdGZV?=
 =?utf-8?B?LzdKTGhLN1ZxU3UzQWhDT0d2N2JOZVpZdVo3Y041MkF4enFXam5RZ2pOakdv?=
 =?utf-8?B?ck1mUXJMQnowNXY4b3ZacHNYMmRqMjB3aklid00ycng5UG1uZkpVd1NQQWlI?=
 =?utf-8?B?RWhYZ3JpaHdOZVl2VWlXNmtBQ1NKQ001KzBZeS9yNnppYm9hZnU5Zmd3UlFq?=
 =?utf-8?B?akFXVHM4WEE5M1FaT2kweW9JcnNlczVSeGpiRkRNbHAxczBtODAxWTNlQmhB?=
 =?utf-8?B?UVl6a1N6YkUwb0NBNWszQlpMS1F6NFVYT1NkQ3JjZmFJRFRvQkZxTGVkVEZS?=
 =?utf-8?B?d3YwaGpwWUZITGRtZ1lqRzYxcDZaemJFa3E4ZlFNN2RsK2dGeHN1MXZxSmhK?=
 =?utf-8?B?d0lJakl1NmtsOW5aNC9rZm1NMVVaVTRSQXhwclp0Zk5ROEsvdEtVUWlub1pL?=
 =?utf-8?B?anFtK0k3SzF0NVIrS0lWeGRTKzA5SnZzeC9pRzQ5Rm9FOFc1TUFwZEZ4TkMw?=
 =?utf-8?B?WW9pd2pFaEsrVGY0bTNGM0lkYzdlT0hCTzNOdHIvRll1Q29UUU1rK2lZUUV3?=
 =?utf-8?B?cklybUpaUGpUSVlKc3U4Mit0TmNkamRIMi92REJPNEh0blRwajhEYlhETnN1?=
 =?utf-8?B?WjhCMjFYa1U2R3o3a3N2WlBNNHlBUGZJZTI0dEcyYXNTRXVzdlAyZFlpdUtD?=
 =?utf-8?B?NWJyMDlMS0Njd2ZRRklEU3VvVXhhTFZHdUc2OE1wM296WWNjYVZNTWNqVzVP?=
 =?utf-8?B?alpzeStFS0JwTXE4SzVsVXFtOTJ0OWtHMDN0QW52QUR2VFltRzFpUE9ZUFp6?=
 =?utf-8?Q?AswxxCJFQfiD9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGJML25HMFprdWZBUnJScndjYUlvVk9KSDJyeDdHREhaV1Q5VDZRQlZualBN?=
 =?utf-8?B?WThuWVFKeFZpUzNUT2FBK01hNE1qeFJYNnJWbW5YV1FTS28yNU43QkFWNjR2?=
 =?utf-8?B?eHNjejlPMkJLZXIxblFkekxGdjRpQ044SnhxZVEwZXlZeVZFVkx1NVdvbjFy?=
 =?utf-8?B?VWVvbDdlMFp6YkcxTnQ5ZFo3cmxzR1YrMEJiNnloWWlYODZUQzNnQWYvM1Fq?=
 =?utf-8?B?dWp2bkhJNlVTci84RFNKZUlFN05NTklkUGg4cnhPbGt4WGpSVW92VEYyY3Bj?=
 =?utf-8?B?OWQ0ZTNDQ2IzYmpsN2tPYTVxK1A2TW1FNTZBbldTdTJpWCsrb2E3TVVmREpp?=
 =?utf-8?B?eEQ3STM0SVFYTGVGZWRkRmZCUDdnQ3N2MTVlWVNLWElud0o2cXVFSkFycEpz?=
 =?utf-8?B?SUNFS3hNemxsS2x5TE9LRmlIQW12Z1F6TXFUUVI3SXBPemlnTkZDZzZuUFlV?=
 =?utf-8?B?Yk9wa1MwaGVHWStSTnp5QVpYTmxwMkoxVXJydlYrbE5sb2ZpcEpoS3NiVkdB?=
 =?utf-8?B?M2phM3NUZkhCQklVQWpzNmR0M2pXZ1ROa3BuSWVlSFNhTS9XZnNtMENEc0ZF?=
 =?utf-8?B?aGRkVnBzZHRCUHBLeExRSUZGMGFOdHFmcVhuM3Rlb2w1Rml4MXpnWHJYakdV?=
 =?utf-8?B?Y0VQekR4R1hZK3E5QnZ6SmRRaFY1djIwbDhwNFhDSnh4L1o2TnZoUVdlbWVK?=
 =?utf-8?B?dVdvSS9ONUVDYXE5VEQ4bGJpdktzRitKSzRNODhHZ0RuZ2owNDlZcDIyNWZk?=
 =?utf-8?B?NmUwWXZRUkUwa3lna3I0WTJrVm5obWFWQ3JvV2tBdE1HYUloMG5abE91TGcv?=
 =?utf-8?B?VFQ4Z2F3RlVZRFhweVpla3dnUmo1MUpLOGFBa2ZsK3dYV1QvaG5QbCtTMWlK?=
 =?utf-8?B?R2JnbmNvNjZFdE16QTdvZ0c2SldOMUJ6MWQrZHlSNkdHRm5aa2FtQ0QzR05n?=
 =?utf-8?B?cnBxcEtFaFByKzUweDlIdnoyYmdlM2p4aEZvaVBPRXRrdndUekMvd0hjUDRP?=
 =?utf-8?B?aTQ1cjlwRjdtdzI5Rmp0SkdZa2krNGhuSW1GZjZWZlNLWGJxY1gzUSt5NHhF?=
 =?utf-8?B?aTlpM0dLWEZ2Y0pDc0Z1WkxnMTFaMVdzZEh5NTFpM0hheU91SjdUdmNwQ3I4?=
 =?utf-8?B?WkIzUXl6Wlp5bUQ0M05WekJ1Mm1iT0NYYWc2OGZYR280c2J6dzlPTFpKeElC?=
 =?utf-8?B?a00wQnNLVXZnL3dzZWh4emNkOXI4enBwRmlRbmYrL3FuSWkveWRRYVJVU1lV?=
 =?utf-8?B?NUxHMnRITStGTDNpWnp4K21aU0hxQVQ3R08xYTc4Rnl0bG5pYWZoSGx1VHJH?=
 =?utf-8?B?Vjg2YWRtKzlBSnkvV0hldlo4cGtwR01SL0xnWjBCZFEzcWhoR1RYRG1XYjF3?=
 =?utf-8?B?cXZ5SDJkTXVvT2hEWk1LemtCWnRZbXhOcG1vKzJBMEdVREpkL2JVWVhXb25V?=
 =?utf-8?B?aHVSemJGR3F2YTFIWGN2OGgybnRmVUlWbFdmaXRmSnc5am51MmVIUTh0YW9p?=
 =?utf-8?B?dEl0Szl6NkdwSGdRbFdzcnFEOVJMOCtZTURjTVJnUFM2QzhWUXc1dTBQWDFy?=
 =?utf-8?B?cW0yUUhhK2FWUTZiZy9WUmxIaGxTOURwUytSTEZZbk04UHRRazdRM0ZwTkkr?=
 =?utf-8?B?RUJ4cUpVaElxU1pYZ2RRaXlFL01vUmFscnZwUXVJZjhINUM5YkRiTTFQcCtB?=
 =?utf-8?B?SzVxcEFzUzJtaG5UZlpOVmlWMEhXaDZ6T3J2VS9RelppM2RzK3IyZmZuK09Q?=
 =?utf-8?B?dmtvaTh6ei8vMkI4S1k2WW9kM0NjMk1nbWYrRkFvYmVaTVlOZjZDWEZiVjJO?=
 =?utf-8?B?b2tHZWs0WGg1ZUx3NHJZUVlRckttT0VnL05sc2krWW92ejhWTmxIMkdtKy9L?=
 =?utf-8?B?d1FmYTI3TWp5aFlrb2QxWGdHS1NPeThRN2t2aktCa0l6cWV4WHdDK2haQjlI?=
 =?utf-8?B?UzJsaGIrT2xkaURnYjAxbFNYREExeGNpS2VQV0VHMHVuQUc2aDZYais4ZVJ0?=
 =?utf-8?B?ejdwMityUWxxdURBKy8rN1ZQNWMrZXozRmR1OHM1OEpPYU9YbWVpamNZOU9O?=
 =?utf-8?B?cUVVODB5eDZaMHM0eDZFOGFoNFgyck1MOXdFYndOenVRVVhCcWViYS9lTktT?=
 =?utf-8?B?cXNKMFgrZDdvVGhEaGwyYzhrYmNPUFNzWEl4ZUxCc0I1Qk1HTVllZkM3S0ln?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9fd89b-81a5-4ded-b30b-08dca6852d75
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:23:30.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu8s7eByCNoRUm0BgSTtEgjTZRFrm4LJV7i4uf9YidFCJrtLFX2t1mFs2lJzbH4zejXI3uIpxAu/c5v1h+hC6I1UrzDwPrVOITWL5nnkUJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> The hardware registration clock for net device is now using
> netdev_ptp_clock_register to save the net_device pointer within the PTP
> clock xarray. netdevsim is registering its ptp through the mock driver.
> It is the only driver using the mock driver to register a ptp clock.
> Convert the mock driver to the new API.
> 
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Changes in v8:
> - New patch
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

