Return-Path: <netdev+bounces-151076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D09ECB8A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16671885F68
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743DF1A83F7;
	Wed, 11 Dec 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0WPAWOf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF29238E27
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917715; cv=fail; b=hkqYjsvZc84wribaRR1gGu/N68L47fRgl87o7e6K0IhKLgbaonW0C3tAdrbQpburIAoq0JuKSC2PMb3ZLL6LzTheuuOABPtcgoMGmrOAF+nrUwP8XNJodB0tExxblhYjQIl5vp6ZUpNXrYdVfLq9UjuR+Ew7D2iDkMRK4bxAQAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917715; c=relaxed/simple;
	bh=b+zWAA+FD0drO873aHDrXk5ZHzTnPy7FkbNYo93Hp98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dcFeD2+m9UIe6BsPvFQ9kaCZY8YrmyxgLZM5gXTqqqQTw9X7qMg66QfWm6YC9AqtHGGMzepCihfyWiA5PUvgsbHqNDSlbFGrcnFQShbzNa5NDfGDVMBWIU3e8x1FeCTDbVBMdm/3EtJZ+gD3TyvubkmdHOlZwv2mrDpswiWHy34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0WPAWOf; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733917713; x=1765453713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b+zWAA+FD0drO873aHDrXk5ZHzTnPy7FkbNYo93Hp98=;
  b=G0WPAWOfBjfZDFSIv1YfaU5lKS9/rQe+XLnHL5mhYHAfszW11mWdybf4
   eGuv9W66+nsNpJQpt/kExD2do45WkYoQX/8gMg7DwqLiy/GkTmRqPX9Jf
   sFslsA4DAfEzrWSI6576jLFacy307+zUfL3McdwKZCvoshwyqxI4zHmim
   OHIaAezE+cphbv3HT9ktU4zD4NJfsaPPmQdRZ4DbljbN0EKGMvEko38u0
   FbLJEkknyPK/hlKgm6gI+b3i9ujYEn6Q78gTLR607rwEMwt2Y8ARN/fSp
   84gkm5rWeHZ0p4YTiRwB7dShCFIVhLQt4FPTz99lZSTXcElc2yqcbxxZf
   A==;
X-CSE-ConnectionGUID: P/SfTx9TRpOi5wXZdUleaw==
X-CSE-MsgGUID: 3e7xIez2QpKhl92Fb1zNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56771634"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="56771634"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:48:32 -0800
X-CSE-ConnectionGUID: eT72ggheSHKJdOvjUbeZ9g==
X-CSE-MsgGUID: JUSI9uKLRFCml9l4pue5pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95838934"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 03:48:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 03:48:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 03:48:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 03:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j53MRo6hCdzI+fYas/8AxoGRckI6qKkBi22Fbv8RVqL6xl7fYliNbhfgiYfpynzmFaE98Ul+LjfqgJ06IrTLq5wzvGO1/2iwTvASJ/m8QqUfJa/MQFl74Pdp7ig/TXGYgvJKeI4hfKN7duz6qHBnMNuijfOC02KhJtpS0YaNPlsGkn1EwmWekRG47ueuBgqXZZIuGo/HGtGPKcxtYs05/FV9oKI4RDZLAbEnGCGpWt2iaiVN7nYSGIf/G0DCpFeeRc3C86Qdj6QsGfijEfGnNWg/KxzO13m4DlWL54LeS7UK57vq2E5ImuqFU/i9CIIBSu6IL9Uk5Y6tHtu355q3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig1tduXRKJy/RUTKxYEOg8GYx/w797/c+dbo7WmqxwQ=;
 b=R/yPUt1HsG6mAj4wucmPlrO2yRma/QXbDMSApYy7pwCzJ0/ZeHaCI4gmeMGhm2+ILV/OlAIOUqvMYSNZ2h4ZcDVChQaO2eGhaTK1raxeSFpMW5yzHE9IzUFMu/lUpzzq1fg0iKOwp1XMLx3EE824tZ08Vm1bLR9ZOVj76aMkx+OS19XZzwjvCUp0P3kpR54mZl22IAFEV9L4EpDz82VF21eInhIqWuNNdv5BYYmJbm/nVix4K9AHS8PyQmVbn5wIIu0O7g7BpprQAkPpvxtnAw7Mf42kito+fIcsFsznIPIq9VhnE4U0d+VXQag8oopn+Q7fzaLKqcTSYppY2o4NTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by LV2PR11MB6071.namprd11.prod.outlook.com (2603:10b6:408:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 11:48:26 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 11:48:26 +0000
Message-ID: <07eeb151-008b-4b92-8db9-31cd51ec3e77@intel.com>
Date: Wed, 11 Dec 2024 12:48:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mvpp2: tai: warn once if we fail to
 update our timestamp
To: Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
CC: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>
References: <E1tLKNm-006eTd-FD@rmk-PC.armlinux.org.uk>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <E1tLKNm-006eTd-FD@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::19) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|LV2PR11MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 582f45eb-8f81-4150-a6fc-08dd19d9b908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym8xWS83cHRBcEFoVjNqRlh1a09uNCtueThQNG5PTUVUMTVkWEYybStSWmFt?=
 =?utf-8?B?YldwYngvUGJUV1lqUWZHZW8vL3NZc3Exc3Vralg5NSsxRjNOaUtKSE5zd2Vh?=
 =?utf-8?B?VmRoQ0xSSENGQ2Rub3FaUzdhQXhWMWJnQzJ0Y2pMRGZkTDBuZGx3c1R6b2Ro?=
 =?utf-8?B?eDBHTVNtZEZVbGorRWR6bWhIZlpzOG56SmNubC9yWTlZNUdDbFJobTg5MkRw?=
 =?utf-8?B?WHIwZlJIbUc4eTlPOHVvelhQNzFFTTBCUFhzUU9EUW05RGE5cldydWdBcEFF?=
 =?utf-8?B?b2VnSTh2M2FYdDBRN2I1VElWbU9tdSs1R01YbCtjZUV1aGhuT2xQbFBOalNU?=
 =?utf-8?B?Mkh0YU10cTYyWFltbWVubThiUjlDN2ptVUhBdTY5M0xNOU1haEVsdWp3azJ2?=
 =?utf-8?B?L0ZBeUYwc1BMNnBnVGx0b0EyUiszeTB4OW9FNWMvSU5RVHJSNjdVR2ZZTSti?=
 =?utf-8?B?L29WTVJOMXFxZEw4OCtiOW5TN2JnV1dSQnVYM0xHTUUwSStVWVQxa2I5OVlY?=
 =?utf-8?B?WjRmdlg0RGs4ekt4S3MyWE1BZkdxZGhWbndoRjJ1RVV1ZUhFTkJDR0JTMGE5?=
 =?utf-8?B?WWdzZUhDUkVuQTBrOFVKbTVvdm12YzdvMTcweU0zaENLd0RWUU5odkRtb2ti?=
 =?utf-8?B?YS91eFRRMTZMVmlYMnp3MXBsN1YwNjFuNy9ZNks4ZFBoTjJ6SU5FYXE3U055?=
 =?utf-8?B?TVVReXZGSTBuZXRreGdocldPL1l2ZFMyRG85aWFuenRVOENqRlFqalRkbCtH?=
 =?utf-8?B?c2k5NXd3MVdLWitwR0UvWGl2NVlBdG4zSUwvUU9aY29IaDZyMGhtOUdGeUxw?=
 =?utf-8?B?OUlDS0RPUVVKMmcvQkg0THpDNFNyR0RvSWNnN3JXZzlOMVIvaW1pcjk2M3dH?=
 =?utf-8?B?Tjc2bHNPL2pXTjA1K1FhL2dBeVVmN0Q3eE0xc0llWlJTM1A4ZGNQc1JjYUR3?=
 =?utf-8?B?RWhVdllJalU2c2FTY25oU2UvblduZmVQVklVK25hNnN5VjJTZTUvK0hTb1dp?=
 =?utf-8?B?eVNWNDl6SWNrN0dXSTg2SE9zUFhFb01UMVVndDI1dm13VGp2NDRjWmcvSHoy?=
 =?utf-8?B?TkZkRGpzVTArMGgvWlFKLzZ6MVlPNkFIc1UyZjdTc3JNTHFUdnd2aDRyMnFY?=
 =?utf-8?B?S2hSbktkczNCVkJFaTV0SzZpTjdvNlYvN2lLSFYxcXg5M3I4OEREWWJWaWNZ?=
 =?utf-8?B?bUVCTCtueDZKeU5td00wcGQ2a24raXFHVkZWeWo3MzdCckEwYmNwRnREMVZs?=
 =?utf-8?B?U0ZKUzRlQ3VzVDNjalIvb2xNazdQLzFrQnVreWRPbE5kTDFWaXY2UnFhTDlZ?=
 =?utf-8?B?WHZDWHMyQk0vMnk3aWQ4NTNHR0dvaE1jRVN0LytTejNlV1J4K2Q1WXNGdVZ4?=
 =?utf-8?B?QnZBWUt3ZkwzeXF3NzJ1QW5aSVpMWGJmWUpGQ2lTZytxWDZVTmpRNldlUHNj?=
 =?utf-8?B?a2svcXNhWjYxd2tZWkZKMHVGR3BWcVVGQXZadmNTYlExc2ZIZ3o4a0ZmTWdI?=
 =?utf-8?B?ZGdkeDJlK1VKRnZTdlhxN3ltbzU3Q1RadTh3UVgzWXFnalRrSkpOVm1HdEhk?=
 =?utf-8?B?YmRFZnRyMnd2d3hVN3hIYXBVTjhwcTBlSnB4UDlpVkp3QWJpakE4eHJTTGlt?=
 =?utf-8?B?MEgxdkhGVEZUVnlkMEdDM0tJWTVMRHE3NnRxRyswdjJGWVZhcHU3VXJxZDQ1?=
 =?utf-8?B?eDM3Q0RqbC95Q0VRY1VMOU5FRDgwNkxZSjlEMzRRV2dKUi82OEQyUzlDZ2pD?=
 =?utf-8?B?anNFd3ozcVRra0ZhNzdHYzArVHh6ckZ0S2dTN3JjOUZtOTczRm03bC9NTG9M?=
 =?utf-8?B?cENiNFdmRy8rSUVkaTNDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1teTc4VWNOTUxYVXJFUUtiZ2ZxRGh2UHc2TjZjUUxWQkpZa01PeUVYcjdQ?=
 =?utf-8?B?T1FhUVFJN2VSUjUzT2dLdTI0VUQ4eUxkNTY2cVNtQXZGa2x5V1Y0SWdFRExG?=
 =?utf-8?B?dWVUNlZQanluVTFTTitRb2RuQVA3V05rbG43a3R3UGJWMU16NUJnaG1zZXVE?=
 =?utf-8?B?K1hJalFvY3ZVMXYwV1NzeGJmekZQdlJrcVpNakx5YlNReWxyekRFSU5Zd1l6?=
 =?utf-8?B?eUxiMHlOVWNQRVVOVGJ0YUpkYWNWSGsyYXhtbHdoMVpaZzgrUG1tazNtazg5?=
 =?utf-8?B?R1VYdVJySktMbUhwR1VIZ0xVMGxJV1NZSmwvcjIyQzZXR2JqVGE4NVpVWitq?=
 =?utf-8?B?QllRRHB1bXliNnNOZjU0Tm1BRzJWdUh4clpkeFBhWjdkQjA2OFgvanZreUxn?=
 =?utf-8?B?TThPQUtYVGJma2JJZjMwOXVBR2tpdlJOSm1ZaU9TRHY3STgyeDl3dy9taHZM?=
 =?utf-8?B?SFRMM2Y4cUhWSUJ4SDN2eGxBQUhRY2lCMEEyTE5oVUt2bGVzRUlWK1l5cFdk?=
 =?utf-8?B?MmdOOFgzbjdMTk9aUjg0ODB6YnB5N094MlJxYU9oY1FLamp1UFZnZi9uT3pz?=
 =?utf-8?B?OWVBbldBR0svb3VHRUZzMFZHWkhEMVUvZ3lFdUlkNDVCVnRmdjFQZmlUY1pO?=
 =?utf-8?B?ME82NlE3ODc0SWNDa1IrOVlnVlpsaURrK0ZRNTNaTXIxdWYzZGxiYWxZOEF0?=
 =?utf-8?B?bENaOHRRSFh0UEthb1pTODQxc2RJNWxoeEpleFhLK3plRkVSZHBZR0FWdEl3?=
 =?utf-8?B?UDNxa3BSQ1hudWtoSnlLZUlxSXpFZ29Nc2s4a1dDeFBYZmJONWpLYlF1M0pF?=
 =?utf-8?B?eHB1WWViR0RSaUdiU3NjNERGK3ZVUkNDZEJHMmdSajZVZERBNUR5L1dNaDgv?=
 =?utf-8?B?ZW96UWtvMjJMYXI5V3ZYVTdoS1dJdCs2dHpoalIvME05OXNYZVBtL2dvcGR6?=
 =?utf-8?B?di9BM0kzOHU3aXRlaXp5aTlsaVBHV0RtOVBXem94TzBJcjF5eEhYa2kvb2Vr?=
 =?utf-8?B?Nm5RdFV5b3dyQzFmbnp4cjdUeGdJaDI4M01Ubyt1WEttd1JlWkFFb0R0ckdv?=
 =?utf-8?B?cVI3eWQ0SnIzUkJkSEVlSkpRalhtL1MyaFlnUFFwOUZtbVZEbGQxUzhSZ200?=
 =?utf-8?B?UE45Tjk5YVNLbU9BRlRpM0FyUlhhZUZtZllYeWNGS3FhMlZkRkNuSHJBeTI5?=
 =?utf-8?B?WUJ3bzlMcjVYcEhpWldzS0pKdDBwRzhQMmVvVWlHbGQ4UG10S2RIeldDU1k1?=
 =?utf-8?B?bU5yN0JlTUlPcWxXR0t3OEhEbFFPRHZVMlRQejF2QlF5dmJpNEl4V1d2SC9w?=
 =?utf-8?B?RDY2QXozSHRoY2N2N1VTeG5WK2ZValF2NnkyNmJuR21yK3JXanlkVnJDdmMz?=
 =?utf-8?B?Ulp3NUhyQW1MeVVQSWNKdG9JVGNTTXByZWw3a05vMXFVTEt3ajcxd0FubGF2?=
 =?utf-8?B?SFpjTXprSzlva2p5L3NQNHYrazdTQkszUXRuMmF0U2NHbTRKcW5IazV1UFpp?=
 =?utf-8?B?b1JjSFFHWEFzWExFalhzcXJ6TnNYSUxxMVRsbCtEWExKNzl4NWsvQ0kzSld0?=
 =?utf-8?B?ZGh2YXhndkJVVSt4SGgwYndraXJGdmxWUXdHTnZQOGRnSUdtMEJxM0h3bVJS?=
 =?utf-8?B?bXYvM3FRbElXMTBQMUt1ZWIvVyt1b2hQNlNKazR2TUJoS2g3NXh5Vm5MWUdx?=
 =?utf-8?B?WEpLZzdrMFhzNS9vK0pBQmt0b2hWaGduSFU4MGo0NU1acVVaTm5qR1VQZkYz?=
 =?utf-8?B?MU52RDBSZzdlaWpuRkNpNmJMSVQ4ZEpySk5JYUJPMGF3TzFQUWg3SHF0bStk?=
 =?utf-8?B?V2s5SnE2bUZoWlIwTW9BaFRvYmlqSTMxWkd6L2Rnd0RxYzAwVkMwdng2eFJU?=
 =?utf-8?B?ZFNlM29CUldrUjdWZWZIWGN2QkVJUUpVNUF6eWtxbFozNGIrZkxIMDlZZUox?=
 =?utf-8?B?OVNPejBMNjlFeTIzaW1YazBUWU1ELzBJQ1ZKd0NHS2d1NGFEc2ROM2QzSmkx?=
 =?utf-8?B?TWhJSmxnLzJVbkRRK2djYWE5c2d2Qk92YXdSYmlmNnY0Rnowek9hcEU3U3RP?=
 =?utf-8?B?T1lNR3pqdXRxZEVhRHYyMU1TNmV6QjJjNENsUGlsZWRkMnA3K0NRTUpGMTRS?=
 =?utf-8?B?VExYeHVJMWZFM2l5YmtVWkdxT00vdFhhaXBleFNxOExjUnNKMXcyTk5ma2xy?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f45eb-8f81-4150-a6fc-08dd19d9b908
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 11:48:26.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGZoV0HhoEjeR1SQMOsN8F8ggfsXEup08xpXXS+NgcwkLfblfb4mhDnkLn0uVFpxSJiWxeJ6KGuUCJyoluaUvd6KeBVha4oJpyIWZZD8x1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6071
X-OriginatorOrg: intel.com



On 12/11/2024 11:55 AM, Russell King wrote:
> The hardware timestamps for packets contain a truncated seconds field,
> only containing two bits of seconds. In order to provide the full
> number of seconds, we need to keep track of the full hardware clock by
> reading it every two seconds.
> 
> However, if we fail to read the clock, we silently ignore the error.
> Print a warning indicating that the PP2 TAI clock timestamps have
> become unreliable.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> --
> v2: correct dev_warn_once() indentation
> ---
>   drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> index 95862aff49f1..6b60beb1f3ed 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
> @@ -54,6 +54,7 @@
>   #define TCSR_CAPTURE_0_VALID		BIT(0)
>   
>   struct mvpp2_tai {
> +	struct device *dev;
>   	struct ptp_clock_info caps;
>   	struct ptp_clock *ptp_clock;
>   	void __iomem *base;
> @@ -303,7 +304,8 @@ static long mvpp22_tai_aux_work(struct ptp_clock_info *ptp)
>   {
>   	struct mvpp2_tai *tai = ptp_to_tai(ptp);
>   
> -	mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL);
> +	if (mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL) < 0)
> +		dev_warn_once(tai->dev, "PTP timestamps are unreliable");

Only small nitpick/question - shouldn't text end with '\n'? I see in the
code that most of calls of dev_warn_once has '\n' at the end.

>   
>   	return msecs_to_jiffies(2000);
>   }
> @@ -401,6 +403,7 @@ int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv)
>   
>   	spin_lock_init(&tai->lock);
>   
> +	tai->dev = dev;
>   	tai->base = priv->iface_base;
>   
>   	/* The step size consists of three registers - a 16-bit nanosecond step

Nevertheless the code itself looks good to me, nice improvement.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

