Return-Path: <netdev+bounces-151068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6689ECA73
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B2E188D558
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EF1FF1B0;
	Wed, 11 Dec 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eb3VAOX/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811B211A14
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913418; cv=fail; b=lR3kiAM/37U8l231Vz9cOPjmlXAPczPBaPzGRwept20NWpeaRZrRsgiBxipQJ+Sy15SflKN4n544SpTuT/6Ega0eYORo53kzVuJ83gao0ehGoCthwsqiQq7iRgwCrDvQ/u5XAViOdbxBTU/rhE690Ukj7sFm20dq5voc2IfoF2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913418; c=relaxed/simple;
	bh=I0b7+jrmguoGQWZ9f5+CLEZbSDxw/8r6/OTl7BQShis=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DP0QlNKB6azup3aayjVMYbPG6TmheVg400398NWW36HZ+Ddue6DaqG4HO7+iaYZR5NTWDr9jBi7QOj8XCbu8pBHR91qsJvevLyOsPK3EBrlGnR80THzjUJHfkjhlx1VcqT0g+IODe4urQh1hcRGN7STpBuouuSOmINoytQpYztI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eb3VAOX/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733913417; x=1765449417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I0b7+jrmguoGQWZ9f5+CLEZbSDxw/8r6/OTl7BQShis=;
  b=eb3VAOX/oatHpKyYUzTDsnA9iYrX7sbeNRLS5FQaMX2SYKA8GxGoECw8
   qoo1srbdhU16KIsSrEALxXAfBOcM/C7pdKzvUJ9BjQf3J+E+3MVwYtJAP
   1jz+c9457XQo5KzGA3efUydBnp1v439y9bEdt70MAHZDBXoAYKx2o1WYO
   84yxryqS8dEq1m27X4dGlEQf5XARwqsLJGUk9OiBYAHC3soBW5uUpw+ai
   FuFAkNaIVNd2vPDNfU5nfuzAouPJiPTjLNlcN1Co4CHYQKrq9xwBeUybq
   gBDjXYt6dTvRsbPe0LE9ezVwSUMCSVk0Tpn1bw7K8gA6znbUhjOyBCyBz
   w==;
X-CSE-ConnectionGUID: sOxWaakYSvmlc3jPF73uLg==
X-CSE-MsgGUID: Wk4jj7CUTr2TrMuYe/3hFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37974086"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37974086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 02:36:56 -0800
X-CSE-ConnectionGUID: i5SjFIKES2CaSyqQa0d+wg==
X-CSE-MsgGUID: uwdcOtHCRQqH12O50pVVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="100797555"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 02:36:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 02:36:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 02:36:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 02:36:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJWMsYV656DGUu7BKbvhhvE203UoH40z0xanRLhrDt6+HDgkjGN/21xmcRp9+8bCNHljAfkeHZ2tZw++Ul8UHvcAZlGslFTdqKST0/wD3+q1mwzx8y+36PJ3pXPucd05uw69rdLY7Q8LtxUqqoDW3k2b0TMe6Xx7ABxV1dz7aJ6Qq17ht1I6xHlxIvaaOFhwcV/19WGfZCcdNZZ4hPnwbKtS2RfngkTRWeRPE2O24gyOmLUfIh5VDrmjdfGQBhjE3XTSy52qMnW10Zc/Giwy0p7pHS+geEKHUQEIjv54NMurh3BQ/SjhlLbRdmeYpFOtHFnh53XH9MJdHTsCgdotrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgixUO0su9bipCVTehpO0My9ewYEqKazjbmsIoKiiUc=;
 b=uOJjELAPyMRnjjNRX4TM/k3Tr+Sw5C97+iYqFRqS3AYDWD+vjUl33HwBvM0B3YF/dgcczJEWNOMLGPvkWhIDmYo9et7k6Fhd8/6gi1y9DKKN10IKr9xjKFJCNTJRLdfDK4skd88kHObI3SdHHbmgSffs15tkAKkuLYrH5ey8R0nwXgBrjdoiqSdH84X8DTuuIkc0p3ktDGgQ3xpL+xY3eDIqrV+U/ZAIxhEu0b6/ZXLOrsYZihxG8JXt/iexwqgZBuU3f7jnBUa3sfQs5H9pB65zpKRH006x5YgETY0Mc/NI2GcZxlzfTYiyUMk3rWPyqpyECWoNbTChRAEOaZ2cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 10:36:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 10:36:09 +0000
Message-ID: <a7b0cf34-4445-40cf-9a8a-b3c24be08fc9@intel.com>
Date: Wed, 11 Dec 2024 11:36:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] ice: Add correct PHY lane assignment
To: Paolo Abeni <pabeni@redhat.com>
CC: Karol Kolacinski <karol.kolacinski@intel.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
 <20241206193542.4121545-5-anthony.l.nguyen@intel.com>
 <04a216d1-6952-40f0-b7d0-f9d8b4f5a866@redhat.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <04a216d1-6952-40f0-b7d0-f9d8b4f5a866@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0169.eurprd09.prod.outlook.com
 (2603:10a6:800:120::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: e399ecae-e7c5-43a4-8ca4-08dd19cfa06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M01HckNqQnVRM2JvNy96QS9jNllVK0hPUWdvN0dpUTJyTHEwUTIxZEVUcDZn?=
 =?utf-8?B?STlhbnNaand2L3dlUHk3ekhhVG81R0Z5NitONytpOTJXMjQyU1pYeHVBTFNW?=
 =?utf-8?B?NEpiWXhVWDdRWGIvZVNCcC9aRDJGaGM1RTdGb0J2eS9rbjRIWjZseWl0UFhE?=
 =?utf-8?B?eWdmdmp5WmdWUzFwcHNUdkZybGlUSVRFWGdoMVlsYUx4eXNxUTJSeER4Zmlw?=
 =?utf-8?B?eXZjSTdReGpRZ2Z4enFkQXVBZVhzMFgxdWJwdVZwQ0NmeGVIaDRpNGlTMW1B?=
 =?utf-8?B?aGZ2ckhld004VWVzMzI1Wnk0K0hmMjMvbU5LSC9nbjBRdkp0WlhTckRoc3g4?=
 =?utf-8?B?ZGlsUllDQmM4bVdhYXdCQ2YrbzJQYW5jdnZWakJPZGJlTzFwY1dDb0ZpeFB5?=
 =?utf-8?B?YUJUZkhhWDRjQXBFeW1vVU5idnRvMUNOQ3VMUmhOcFA5M1RMSkJIYm1NcS9o?=
 =?utf-8?B?cStkVEswcDBGOXV5QnJuZ3hpYmN4QWlJMkxGbnhiVDBpTkgzOXI5YUt5eUdP?=
 =?utf-8?B?UW9SSEREdHFQZlRzaC9QaXFJM0w1aHBUcG53bW4yVTJJZm5LOEdzb2dIWjI2?=
 =?utf-8?B?QkN1dVhFcE5wNURmMVp5b2pXeVNvSi9XemZEVHJBdldhVjBFalRWa0xFaTJR?=
 =?utf-8?B?VGlPNFc0MU95cnQ5dXRudXdpQ1JlYXZrUkFEQ043b0Z2ZnBOelZNaVFBWUdL?=
 =?utf-8?B?SXp6cUcrdlhYc0lXc3E2aWh4emZlaHI0MHFaYkxNcWVZK0xRVDA5NmtaL1Jo?=
 =?utf-8?B?M2VHQ3R1WVBNK3ZhbmlWeUNmeVk1N2N0Uk0vb00rR3V4czlmTEh2MWZRaC83?=
 =?utf-8?B?Zm5idkdDam9Mb21FTXBQVVlVODlpT0RIU21FU2R5cndpcld1RkpqcEhGdDJ1?=
 =?utf-8?B?bGpjeENTc3Vla2JWR1hXUzUwRGZpUG16TVpLNCswdmZ6cnBDK016SlFQME4w?=
 =?utf-8?B?SmZRZlc5NkYyVGxkN05oeElweEpLSU9OUFZSN1ZxeHltbDJsaG1SQmxJYlV4?=
 =?utf-8?B?VHVPbWpldlFlM1BlMTJXb0E4Qm83cVIxT1RIKzZGY1VscGFBb3FkWks0RkIz?=
 =?utf-8?B?UXkzcU9vdDVKUEdqZW9ac0J0d1I1SU5DSlNYcnZXbVllbWlyV0Z5MkFHQUR6?=
 =?utf-8?B?UXcrUlNvYUk2bHcvZHFzSE9NSUxOZ2VyMWhGWW5YZU1MWUhyS2RzSXErRHAv?=
 =?utf-8?B?WklhVGY1VFVUOGhXVjJzc0NvUUV4dFU0NUp1ZW9jSDAwa29uNnZTMFFJWGQw?=
 =?utf-8?B?RHJDaXZ0SjhGTmduS255V09oRCtkZkhoNTcvbERpSElYMlk0NWl3a2NHQXk2?=
 =?utf-8?B?V0ZRLzRiYi9rKzlBOEJwVlh3bmVJRDlLVzlwOC9sclk2dllYMXdUNjFIdjB1?=
 =?utf-8?B?ai9udTNBckRWQWloZHQ0L3g2UStuSk51cXpzVjlxb0JzdUVNaWo4a3NJRVJ2?=
 =?utf-8?B?Ylc1bUZlVXkvZndJMUFzNFMzOHlqaVlncUVNRmNhZEQ1U0w5ZXVvUTZuczhJ?=
 =?utf-8?B?UEtYbVhQcXpoL1hZV0FwRjZMaTYyNHcyeThYMmpWVzZoMU1ZQWFRR3VFaTFF?=
 =?utf-8?B?KzJ2Y2hWcElKeThxaWNPRi9NOTdpbG9yWG5kdXljUi9BSGZCL2hqVXZyWE0x?=
 =?utf-8?B?QzIwUEFpUlRsZjdEU1RyK241N2c4WUNQNk9vTnk4WWVHQ0M3M2xNRkpPOVhX?=
 =?utf-8?B?cURWQWJCUTBkZk1hT0ovTE1BU0tQeFozdUFZMXNxb3h3UWdRbEYvdnhGK0NC?=
 =?utf-8?Q?BOJ58soeujLPrRstxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBVL3phU2dyM002Q3ZoM2dNWElqMXhTYzJkeVZ5dEc1aE91bm1ZYzYxbEw2?=
 =?utf-8?B?NUtiRmNCZlNWYWp3QkhicFRHdjBqRStFYU5WeVQycXpvNkNYUS9aZHZnWlBX?=
 =?utf-8?B?b0w1QTJnZVRrUmhVN2FXNVpCeGlPT2FjS0s2QVFiS1VvOFhFQ2ZzdGtrY05J?=
 =?utf-8?B?d0FnUG9xVFloOHBLdGx2TDdXVzlqeFFVSzdpQVlLenpCdVZRaE0vTFNXNmh1?=
 =?utf-8?B?RklRazVvY1VsSVNaRSszUkRsYTVkWktEUmlvMnY0Z2orbnc5cFlwOFd6M05G?=
 =?utf-8?B?elNhbW55K1hIYjcvMDhWVy9EbWxLUHdGMWFtK2ZMZXViT2hUZGZxZDRNdE1T?=
 =?utf-8?B?em51NjUxUnF0RnFqTkdUUnJmUmdjQ05kcHpFempPUHhtS2RjZys1aXhRdWtx?=
 =?utf-8?B?RGkzdUFOamVVd29kQ2NCdE81TDc5a2ZyRG02SUhUVFU1ZEdLbFJERisra0JC?=
 =?utf-8?B?T2xPV2RmYXFid1Q5SkVIVXIreEdiNzRZSTBrRWp1dkw4NEMwZFlqNTNGUEpi?=
 =?utf-8?B?S1VucGhia01EU3l1WERFc1JpUzlNQTd1QkRjN2hFc2ZrZHFuR2svVVFEeUMv?=
 =?utf-8?B?SWp2WklZM29EZE5YMXVnWXR3dksrMUlZc3RhU1lCbEpIM0twQ2FSMFFIMkxq?=
 =?utf-8?B?ODJ6SThZRlF6RzhWVCs5RllEMVhmQnRzM3dCSis3SnlvK0hrVy80bXJBYXd2?=
 =?utf-8?B?OHZUY1dPRjFkRW1qRVNqczI5TFJjNzdRNUsvVzZ6SEticFFXa3UxTG1GYXc3?=
 =?utf-8?B?OVU4QzNjd1gxRjBCb1VkeEdaejVTc0lhWUVrQzJINXlFYXZYK3JEOVFhNU93?=
 =?utf-8?B?SEdHUGd1SUNRSkVOcUhLeDNGWGxJMVM3c2tlVWRUanZLbUEzRmZJZWlmcXB2?=
 =?utf-8?B?RFU3bm9aVUhtQ1IxY042VTR6M3A1ZlBuZFVpV3hSS2t6MGhQOThWVXNFMnhG?=
 =?utf-8?B?VjdsdWVONTU2OGFGVTNQaVkzOGZWUkN0ampKMitna2k4YTRPQ3U3dWlWNlM3?=
 =?utf-8?B?LzdHZE5rRkVvYVVDMWdXN0pXTzZQMVYzcGJGZFI2MVpzQ3M4SkNYREJZdEtq?=
 =?utf-8?B?Q1YzekdySXdlb1oxNzBvTTZKdzZqY2JwYlNSNzAyNE0xV3djZDRFZWJwZFdS?=
 =?utf-8?B?eXY4SllFWVJLVlVtZThCdys1VFlxUytHVk9pSDM2ODlnSmhZUy9PMHZCNXlh?=
 =?utf-8?B?bEpWeWdHaUtmNTMrZnRwVUxzODJvYTl6cEsvbTNSWms5dVlIQXQxYzNuTEtN?=
 =?utf-8?B?eERiaTNFTjkxRkJsdlluaTdzMFYxS3dXdTVYS2lLTDduYjQzQlM5TTd3L2JU?=
 =?utf-8?B?N200THdENXozcUdVYnh5UHhuazVDSk9DY2NPQjU1NjJiVEZwQ20rbmVUVng4?=
 =?utf-8?B?UWZCV0NOZXUrOWhWb25MUWhGVm0wamVMcC9LUUxKcE4xSDJraDN3SXR2aTI5?=
 =?utf-8?B?cm81ZTVhRXJuenR3QmVHblV0MGQvV1h5SlVYalJKa1Erd1A1UHR1Q2d0aVNa?=
 =?utf-8?B?V2ttMmFTRHVsL0ppN3F1UzJTUnNoby92ZHR3MFlrcnhLVGx3ODdLYnFlWk5x?=
 =?utf-8?B?TEZ4L3hwRnVEWXJlWGhCdDN4cUV6QkpaTVhNMTZ2QUZieWZMajJ0K25UeW0v?=
 =?utf-8?B?TUhKMHJXRUVLT1NUMmdkR0dNbjg4emRoWjZvaEZObXlLbkV1S3NXY3kwd29l?=
 =?utf-8?B?Uk9OTXJqRFFEQXp3aHN6S2JwWmRoZ2JrZG1jMUlObm1qekY4R0xtTUd4SGJa?=
 =?utf-8?B?TFlmb0RLS0dHS3BCalB2RDkwYytLR3BiUU0xbkJEME9DYW9xRElaZ3IzamNo?=
 =?utf-8?B?QUpHakY2OFU2Vm55aEdNMVJkT2tkWndVdzJCMEUxWkJQMGVzOHBwSkNoZmE5?=
 =?utf-8?B?dGIrMFNZTVI1Vi9KNTliUThuaVRka1Evc0RCN1RKbWdTeUdJZURWREROZ0xD?=
 =?utf-8?B?R3JUaGJ0ZHRSVVpVWEhhNDVVWlVVdkg3M2FHYkNEOWErOERLc296djJOZGg0?=
 =?utf-8?B?aXliMEVnVWRoWFRvb3F1bTV4K0FjeFhtNmdLKzRmYVZ3QmhYUFo5QStlUVBv?=
 =?utf-8?B?cG9TZTkvL2VNLzY5ZG5oOEczKzgyRFloSHBXWWF0MnN4bE1oenJwNE5yMmpR?=
 =?utf-8?B?SG45ampud1FlZm8vNDZZS3FoQmt6bzNHNE1Lc2Q2R2N0Y0lSalBjekxrWTZQ?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e399ecae-e7c5-43a4-8ca4-08dd19cfa06c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:36:09.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eLppnUQMoMXZiJUuiChHE1x85Jgo6aqrOMJCm3iiLFyVfqoOVf9i8IeANdtCjD6wQiUzqlg4mN0MHKbs44VwvvmWk9Z1WdKswwk52EEAeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com

On 12/10/24 15:54, Paolo Abeni wrote:
> On 12/6/24 20:35, Tony Nguyen wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>> index 496d86cbd13f..ab25ccd7e8ec 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -4095,6 +4095,51 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
>>   	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>>   }
>>   
>> +/**
>> + * ice_get_phy_lane_number - Get PHY lane number for current adapter
>> + * @hw: pointer to the hw struct
>> + *
>> + * Return: PHY lane number on success, negative error code otherwise.
>> + */
>> +int ice_get_phy_lane_number(struct ice_hw *hw)
>> +{
>> +	struct ice_aqc_get_port_options_elem *options __free(kfree);
> 
> Please avoid the __free() construct:
> 
> https://elixir.bootlin.com/linux/v6.13-rc2/source/Documentation/process/maintainer-netdev.rst#L393

My understanding was that conversions to __free() (w/o any other reason)
are bad. But for new code, it's fine. I get the "discourage" part from
the doc, as "don't use __free() by default, for all pointers, or all
allocations, but apply your judgement and sanity to tell if that makes
given function better".
I still believe that this function is better with __free(). We develop
(new code) with such assumptions for the better part of the year.

I think that static analysis tools/Reviewers already got used to that
(after the first false-positive memleak reported). Developers (and
Reviewers for sure) know that those pointers could not be left
uninitialized at function return. The only concern that is unresolved
for me yet, is: "there is a lot of characters to type", but that is also
good in some way, as one needs bigger function to justify the added
"complexity".

> 
> Thanks,
> 
> Paolo
> 


