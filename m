Return-Path: <netdev+bounces-102828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10758904F62
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0189B1C2155E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0316DECC;
	Wed, 12 Jun 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcEK2y/o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7B16DEA3
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184921; cv=fail; b=e6mh3rM4NzGIvfapyinAi6y6f0gBrKhXGZmEcqUUwqB+SktScJtsXDPT1+GZBpIsbIGl1h+okJI5nQnXqW4D9EwIo3CpCQOJFn/zrbSwlYPFhY/vJOgIk7XYl5NuIdfMe5Ydvdf8sELZgt1pIi0qVMbwGHJ4qIeOVg+eXMPBKlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184921; c=relaxed/simple;
	bh=yF6uKBlwz99QYwaWO5LByzWyuNuTvpiOSvu8vd6Qx7E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hVzi8JqIqVCAMhtavxx1zZmaOv9AXnuS932fT9Bgv2huVf7kO90GdmvQEPGQZgLeHtOkVs7j778db1MgkdmK+s6XxWmKJe8Q20xrpKmVj6F4MCCNX60acnBVhbcSeEugly7z3QK9ssyMhywGjKfflJeJQad2m/yobP34DAyL+8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcEK2y/o; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184920; x=1749720920;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yF6uKBlwz99QYwaWO5LByzWyuNuTvpiOSvu8vd6Qx7E=;
  b=WcEK2y/oAUQgL0O9YucgxCG7DBzc5cSuODe1y2tvij+m8QdHfO1a9L94
   +1ioF8wS4Jl8W2j+Bs+EHrKu7WjEHu4Vh3hq3uoi77S0owjjNEJ1LAwDt
   uD2FWT3ASbqI0jiaDdlAvZx7iqbOVgqNl6B3EXYL9TzhzoFam5remqO9Y
   IFFGnChCoGAVSaLvTCmhrIXzm8tzFzI9MhefQWxRrRnxc7auVSiCg+r+T
   apB802ZDS22r+E8QGjpeJWa74NRE9OphmCcZA1283aslnm7Dze528sD3p
   TGqHyZrTgFscsdC0pNoDvgBp5jT4nwyISGqyU1IEm7CRsBvOHtkIJmwI6
   A==;
X-CSE-ConnectionGUID: /4+e2OiGSgS0VJ8WnMj1SA==
X-CSE-MsgGUID: OPv/eNjZQx2EOrXxKdbqtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14733475"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14733475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:35:05 -0700
X-CSE-ConnectionGUID: VFRcrh+tRiu9rupZrFPdHA==
X-CSE-MsgGUID: aHaXKVpPRcWF56HBoh4D3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39618568"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 02:35:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 02:35:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 02:35:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 02:35:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 02:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk489JUP6mLgtL9GGc8L7TO+5o2EomEYShiQHk4bcHMoDwDzgSdqSnTmZOqxvDWLZoY/3ZZpUkRgmFr4tNxJuzU1pTMV1UBPkaeVC8P36zKFNY4rsZGth2e2hk2Zn201SSreCVG/YlwpAuY47LI1m4lmYxCOiGAt488cD+pAQZMJzFHHeUTeMThBFetZb0o0/uQUqQ1edb59Ze6sF+M5botGKGSQ5JVK1s4dP8mI1Q0GjbZOke8cP/+KbfqXTKI2x9aUos+eR02RdWQsgeVt7ONsCnn1uTVFSBIPNjQvocQMZO1FGtv95VlRrSNz0O/m5I0hs522aTbadhBD/5jJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEYNJWuvk7XbpcaMXQTfzPaD+qSfzacGvrbmoQCUU18=;
 b=gHCmPcUWVjBAmnIRVI933BTSHCkb/7Brs4hzvXkOn0XkXO/jpIvDqTsu/wl8BjvFrm2JcKZOm2tma1Dh1/vAk7URFVzxBL6WKzZkDSgqSytkpyjoG6QETVxJkC3g+L3gEYJOQzWmXkOevx9bp+y5oojGoS9/8LhmPcatG6WzOaHrPjE4+v2QaFz6v1lZa79wKVYri8DK4MykygN1MAxXbPbY2b+x9jWwP1BWMIjvGqzOn7C2XRAtj4cr9OCSvwG+unaBNcrvt6usT28oHXVADT8vMBrBbmUQkK08JJ6/GlYnKCaXSHIm98JpIqHxGtn7/cyrYroDZdnTvg2Q11pBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 09:35:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 09:35:02 +0000
Message-ID: <ef8057dc-28f9-483a-9885-35879ad84b56@intel.com>
Date: Wed, 12 Jun 2024 11:34:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: extend tx watchdog
 timeout
To: Josh Hay <joshua.a.hay@intel.com>
CC: David Decotigny <ddecotig@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Sridhar Samudrala <sridhar.samudrala@intel.com>
References: <20240603184714.3697911-1-joshua.a.hay@intel.com>
 <b30f34a1-48d6-4ff4-b375-d0eef5308261@gmail.com>
 <cc76768c-d8d4-4c07-93c1-807f3159b573@intel.com>
 <641b439b-2bc0-4f2b-9871-b522e1141cd1@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <641b439b-2bc0-4f2b-9871-b522e1141cd1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e05ca6-2045-4a35-9ed0-08dc8ac2eef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHNqejg4WStSbnFmeDZjTFNFdGxJUnhPZCtqMWJiUlVRYjRxbEltUHlCQkky?=
 =?utf-8?B?Yk9VVlVXNEZUK2Y5eGtVSzgycVZKSVBhcmJjOXhYR2dnVzVXbm5WdUJncnNY?=
 =?utf-8?B?Y0dZNVM2ekNHY3FvaEJIYW1teVZWdVVWUDB6QlphQmY2THZSS05SSGRmSG1n?=
 =?utf-8?B?RVg2ZUo3NEwxSkxHQjRIaC9KMzJRRlhNSEV2M2dCaEs1SzJHZHRWZEMyaE1v?=
 =?utf-8?B?K1A3ZWIwQ1lHN2dweGh4cFI5eVZidkh2Q3hMMFEwSlh6ajJ5Mk1UeUJuclNU?=
 =?utf-8?B?MmdPT2JibksxYlNGM3lVeER4eUE4MS82cU1uU0Z2eWlnaklocExldEZZeFhP?=
 =?utf-8?B?UjhHaEpMeWxnZll0Uy8xUFNOeGRycDFKc0JXeUdjZ0kyMWsvM1lBZlRNL0xq?=
 =?utf-8?B?TDRRcFdUSmtXaGNUZ1hyNmJGRlowMzNJcWJvTDNQbVN5S2gwcE1ZcSsrNGxj?=
 =?utf-8?B?aHl2K0x2ZmtPZWluSTdKaGM1b2Zrc0ozUXdPRjh6WTdudndsNDVoeGhUNjYz?=
 =?utf-8?B?RUlyMXk5TkM1U0drUHVNN01nbWpwWW1CbmdmaElVTlJzRnZsUlIzYlIvVGlw?=
 =?utf-8?B?Skc0UnR3bDlMWWxXR0Y3Vkhmb0dVamtNRE9YenRiYUs0YTNqbzlEY2hHTWhl?=
 =?utf-8?B?eVErUksrTzhVMU5KbGRUZlBTZ0d1U2ZkQU9nY1kwNkExOEJ1cCtGdXFvUmk1?=
 =?utf-8?B?K1p2Mi8rKzFYOEZ1N3VaMWhFd2dpeUxBUExmc0Rjc0s1OFJzckpUMWFXVnpn?=
 =?utf-8?B?cGZSQXhuZi9UWUJXSXhFczc0ZEU4dVU1T09BZWNoTWRkb2k3U2UwbGtuTklY?=
 =?utf-8?B?ZjJsTDhpUlpySWpnK2VJMkF0Y05oUDc2aDFGbXoxQnM3dHcrN01GVVdER29G?=
 =?utf-8?B?M1k4OHVKS0pwWGUxT2NPNEdHNThyZ0FaRGFLWHBIcFRGQkpVMW1neENKQkgr?=
 =?utf-8?B?OHEvOExtK3NZOGlpUDRKaWdFZEE2Q3ZvSUNUVHNTeE12NnpGdEkwWklpbmRi?=
 =?utf-8?B?d1Bsc3pLYmx0OURZbWNvcXRsVkVHNnZCbjJZQ1lJVEEzTmZsSWlJWm1qa0tO?=
 =?utf-8?B?ZWtIaWlOUTRVWGcwL09GYlBHVjlzTGozaHQvcTRtcU1URGIvZ2JIaDczNVdW?=
 =?utf-8?B?Snk0YVNDdTVYK1J1U21HcjZGQXdTU2p4N3hGUmhYNm5CS083VlQyS284QUI0?=
 =?utf-8?B?dGxpS0pLbllTZnVBZlUwQkg2bzg0Z1k5ZmRRSWd1SFhiRk50R0xlRDJEYUdq?=
 =?utf-8?B?M2RCOSt0czFqL1VaQTIxWDBKYWp5eTRQV1pEajNyY05MT0YrQkhlRGxXZ0hp?=
 =?utf-8?B?VWxrMzE4ckdRTDVZNkNYd0YvWjVOR3F3TThRa250ZGxjdHRMTC9memVZT2FK?=
 =?utf-8?B?K0lXK0xBRDlXMVZ1bTdIdDE1eWhEak55NHlSOGJsSnpRSnAvYXRXVW1wcWpz?=
 =?utf-8?B?MWVGemlYWk14T3JReldJc01SK2swSUN2MWVCbGpqc21yaFlzL2dwTHZKNjdw?=
 =?utf-8?B?M2FVdUp2TWxaZENEdC9YUDBVbTlsTndzWWZ6ajA4YjhTTDF3Uy9TVmdoM3VT?=
 =?utf-8?B?T2Rmc2ZJL2NLWHRiUXpZS1FRSENJbTVoaktEdEZVNHpjWGN1d3NrcklxbWFZ?=
 =?utf-8?B?aEdsSlVkZVk0ZUFlaGUwaHA0TkgrdXdLWkVSVzR0UWhSMjZ2RFdrdVBxUjVa?=
 =?utf-8?B?Y0U0c0ZaZUlETnRNSVpQb2FUUGlNUzFqQ0tQeFpYK1BGZGtKWHNsRHBCeTNH?=
 =?utf-8?Q?evSo44pPt/cQeZl2TxdN/xFpx9+Iv09F/MLHP8S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFINjJIazU4SEtGVWtkdlJUc2RnQmtzQnh3UGs2K1p2QlJGeFVkQnJ1SXhE?=
 =?utf-8?B?TUFZenM3NWFVMzl3NnZmMXgwdFhqT0tydHRIT05USkdkY3EyNnhTRWxlU2lp?=
 =?utf-8?B?eHdSZEUxMkF2UXFLaG9yckI0V29JdTBhcG8rTU1PVXNTdS9ucjBxcXdrN3la?=
 =?utf-8?B?MTRvMXRHc3poTnBIV3BSejBiZDRlN2M0MUhwUFlsZWY4MkRtTkNXQTFXSkhD?=
 =?utf-8?B?RXlsN0YvTzFYSFhEdXVLLzlHL1BHUnFWbDRvMllsZ0RtMExMMDgxZkwyVnlz?=
 =?utf-8?B?bkdpM2FweEtkeno4ZnhXSExwOUZRMU01aFZab2F2MXZlVEZRRzFSVW9VVHNj?=
 =?utf-8?B?K3I4NGdSNGUyWmtqckhSUXhEc3NNYzdDUVUwaUNva0E2aVg0Z1g5VVV0Vkdq?=
 =?utf-8?B?Tm40NUF4Z1c2Y3k3amQyZ212M1JQUkZCTTVTbjdrTHd4MEExM1R4OXVXS3R3?=
 =?utf-8?B?RmRva09XZkIvdHowUVIyS09QRU04eXl3Y2szWnp2WjNlWE52eEdVTlNnZ3Ex?=
 =?utf-8?B?QmJhREJLdVNuUlZLOGtBSlNIc2JzSjBQVDBFdmlPSExPZVRGMUNPV0tyVmxm?=
 =?utf-8?B?Y2Q0UGxvOVh4WVNiZlFZVkkycVp6MHA5RzRHQmdWWDlyTGIzSStGTVlRcmZV?=
 =?utf-8?B?azFBbGhINHUyU2cxZWhWSmw4Z2p2LzRCZW9hQ2lvR2NRYkpDaVcxMjhQYUR4?=
 =?utf-8?B?TW1hSHJ6NHJUZ1hudUQzSU8yNldCTnVBUXIrTmFJUjg5U2VQS3FVYUtVV0Vw?=
 =?utf-8?B?cStWOVlLOWFGZncyWW5MZ01GMnp1aGhsY2o2K082NG9hMTdvUWZ3R05RcGFw?=
 =?utf-8?B?aHBma1BFQnhtQnFvR1o2bUxDM0ZuZTc0RmR6Q29lZVltYUxKT1N0Ty9DTlZR?=
 =?utf-8?B?d3VIb2ZaNDBoc2RHcEFyTWNqcU41NElTQzZ5Nkw5aWFjczBnZzRidUJMKy9n?=
 =?utf-8?B?WTNyemtYQ1Zma1pIR1gyVDlCR0xPVGIveHY1NjJQTUdIRnY2ZjlaZVBiZXdL?=
 =?utf-8?B?T1gyS00rc3QwQUtEclFIZmRXNE9JZmJNV085YlRnWWhBeE9zNWhJSThnb0NQ?=
 =?utf-8?B?bG9oOTh1NmEybDFNUkErYmI5aHIyM2RNVzRzem5hQmNiTmQvV0hBQlJMY1da?=
 =?utf-8?B?TXBUL0xPbTBkamN0ZVZBMXNML0tJa3JYTjlTb3QzVnZYaW1zdXhDdlFFbXlV?=
 =?utf-8?B?Q2l4WFNmL0YrUTRuZjF6MnQ5aHUrZGswa0VnK2dESkRCcEl3d0FSSlh3REd6?=
 =?utf-8?B?akhnR0h2cER1clVrMm0yU09VeVo5UGhGVU5uNDJuR05ZRS9sNmNvbEpLR0hS?=
 =?utf-8?B?MWliMk45OWZydXRVRGU1dVJsd3RmZm5tNDVwWEdJNVcxVEd6SmlUenUzekQ1?=
 =?utf-8?B?SXVSa2F6NHZuUDBma0c0Q3YycnJFM3Y3TXNpSkJTc1BRU01rMkdZWlh1bmVu?=
 =?utf-8?B?cFlFdGVidnk0SjRuc3NwZjdKQllzSTJReTcxaUtYQTVVTjZUQUkzRGJtM1Zx?=
 =?utf-8?B?VXRzYzFLY1pONFZJZTRId0lvN0hIZytDVURueERzQ3lib0E5MFI1dGtUWmFB?=
 =?utf-8?B?anVFWDd0YW5GOWR4dVR2WFpVTisxdy9LN3drQ2hidjdrbitSUDcvRGcrK3R4?=
 =?utf-8?B?Q2xtVEg1a2Zva01MQWFsTVVlbFBVN29pV2hVeHh0ZkY3RmJqSGFyR3Ywc091?=
 =?utf-8?B?OW5yc2c3L3UvenlxS1JsZTlieklpbUp0bkgveEVsVStqWXZ4bUpWRURxMFFM?=
 =?utf-8?B?bDhGMjF2UnNpU25PT25CMGhxcHdOb0x3UnpXVWJHMDh3Unh0eXBEQXptcmdS?=
 =?utf-8?B?RW95SjJncG9lTzVqQVg1ZysvWTIybkhOWmRRT2lqc1NlOThQbHVlR1Jza0F3?=
 =?utf-8?B?VGIzNVhHVU15emtlVVNKZjdXT2ljRkxEUjVkZHAvQXhJcWpscHRiSEpGbUVz?=
 =?utf-8?B?MXBYUlg4UUlnRTNmTlRHSm41RkUrbVlLZEVhWjBtY3NTaytCUURGaEY0VnlI?=
 =?utf-8?B?bVdENlJnSW5BaXBJQnNPQkJNSTE3NWtadk5ERUJsQ0JRQXBBZ2xYY1Y2RXAw?=
 =?utf-8?B?OGVoNFlETHVTSER2czVDYmNtK25uN0Jka1dOMHFiVzdRcW56VXZWa0ZhUjR0?=
 =?utf-8?B?c2NOamJFRjVQZnpTWDFBNmZ4R0dwZFBiNGJYTUVaeVlPU0NsRmhDcy9YYTJH?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e05ca6-2045-4a35-9ed0-08dc8ac2eef5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 09:35:01.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbWodus/GTkrSJEZJf2RcnEqQdBIEz//sf9f+xrEPA3Dn3go//7USrlW+pmggcP4FIDmjF4WzEtjSByYd9WgLIj+wv81fJpriEPVe2meww8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com

From: Josh Hay <joshua.a.hay@intel.com>
Date: Tue, 11 Jun 2024 11:13:53 -0700

> 
> 
> On 6/11/2024 3:44 AM, Alexander Lobakin wrote:
>> From: David Decotigny <ddecotig@gmail.com>
>> Date: Tue, 4 Jun 2024 16:34:48 -0700

[...]

>> Note that there are several patches fixing Tx (incl. timeouts) in my
>> tree, including yours (Joshua's) which you somehow didn't send yet ._.
>> Maybe start from them first?
> 
> I believe it was you who specifically asked our team to defer pushing
> any upstream patches while you were working on the XDP series "to avoid
> having to rebase", which was a reasonable request at the time. We also

It was only related to the virtchnl refactoring and later I cancelled
that when I realized it will go earlier than our series.

> had no reason to believe the existing upstream idpf implementation was
> experiencing timeouts (it is being tested by numerous validation teams).
> So there was no urgency to get those patches upstream. Which patches in
> your tree do you believe fix specific timeout situations? It appears you

[0][1][2]

> pulled in some of the changes from the out-of-tree driver, but those
> were all enhancements. It wasn't until the workload that David mentioned

No, there are all fixes.

[0] is your from the OOT, extended.
[1] is mine and never was in the OOT.
[2] is your from the OOT, extended by Michał.

They really do help.

Note that there's one more Tx timeout patch from you in the OOT, but it
actually broke Tx xD

> was run on the current driver that we had any indication there were
> timeout issues.
> 
>>
>> I don't buy 30 seconds, at least for now. Maybe I'm missing something.
>>
>> Nacked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> 
> In the process of debugging the newly discovered timeout, our
> architecture team made it clear that 5 seconds is too low for this type
> of device, with a non deterministic pipeline where packets can take a
> number of exception/slow paths. Admittedly, we don't know the exact

Slowpath which takes 30 seconds to complete, seriously?

> number, so the solution for the time being was to bump it up with a
> comfortable buffer. As we tune things and debug with various workloads,
> we can bring it back down. As David mentioned, there is precedent for an
> extended timeout for smartnics. Why is it suddenly unacceptable for
> Intel's device?

I don't know where this "suddenly" comes from.
Because even 5 seconds is too much.
HW usually send packets in microseconds if not faster. Extending the
timeout will hide real issues and make debugging more difficult.

I suspect this all is for OOO packets with an explicit sending timestamp
passed from the userspace, but as I said, you need to teach the kernel
watchdog to account them.
Otherwise, I can ask the driver to send a packet in 31 seconds, what
then, there will be a timeout and you will send a patch to extend it to
60 seconds?

> 
>>
>> Thanks,
>> Olek
> 
> Thanks,
> Josh

[0] https://github.com/alobakin/linux/commit/aad547037598
[1] https://github.com/alobakin/linux/commit/50f4c27ba13e
[2] https://github.com/alobakin/linux/commit/4a9b6c5d0ee8

Thanks,
Olek

