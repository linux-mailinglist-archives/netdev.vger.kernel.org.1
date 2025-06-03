Return-Path: <netdev+bounces-194732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC1ACC2E0
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E7D160061
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479F280CE0;
	Tue,  3 Jun 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKpfmtVb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3112686A8;
	Tue,  3 Jun 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942558; cv=fail; b=hsQ7ANOOGgZdqJK/BVUjgdH66CQ8WlwZN7uN2puAYLRAh6nkYHFiGwe7ZyuPCFuYMMiDnNoWYg6NDUl14h14OfaZHKeHQ3jxLsgUlHTo173dkKGnKunIwW7olqNDOQCwK7mvpURaZlvUE6V43Kiju3fNAALJ8TKyR3os+sH4Bs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942558; c=relaxed/simple;
	bh=JbwYZrbN/ktFy0GiHWjLUTPavFmZOt6M+MwmGteZdgI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PyRXM1f4VCjZ/0gkZrHdhfW12d3fh71RncWMYsRTFC8lnKqUDuDqVfn0Fq57xZCZ5e7xJX5WApiR2Na4GpNe1upi1b8WR/Rmu/8n0b3sYqMhheJ/jatNQTfOUZhSg8D0VA3X1Yq00dU32+93Q6ttqiXDn1JtJMLKf5t9Uc9qmWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKpfmtVb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748942557; x=1780478557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JbwYZrbN/ktFy0GiHWjLUTPavFmZOt6M+MwmGteZdgI=;
  b=eKpfmtVbKUId1NT4cVgA1rR+8tVp3oNMf55IzcAQWOaZVq6DsJ678ltw
   xCgvHpLytdKSsI5YJTVEmUeftLcQT70wDMjjIg2yTWNP2YeGQB9ljjh3/
   6KjI2auSu7z4cdn5JtZAoeLtlKOrilOzxIXI4r+uWlU3GnJnjl+MXRJwL
   1gcLxdBRecJ1I34FXYkrQjLYX/uJnunh1qS/3sNsPJUGVOhSD/g94JpAw
   hN06zLA2+NWS3SGfIdN+Pq0OGcgMAZf+23T4C+gk2J73/VezgnTbyekj+
   q4U6Efh46Qgc++Nvu5CbHBD1sVIIeTHMxUyU4hPix+l4mb48nqnGHnKNw
   w==;
X-CSE-ConnectionGUID: pqw5ewnfQnGEOdpwhOM4+A==
X-CSE-MsgGUID: SCTwLqWySZSgGxEtWinxqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="54767864"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="54767864"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:22:36 -0700
X-CSE-ConnectionGUID: kZ6g1wzYT4WtlrlnUlhiUQ==
X-CSE-MsgGUID: HWI1K8nhSCOt4AWnRQQNig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="181981216"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:22:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 02:22:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 02:22:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 02:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7aXoWNvd8A47SVLg+aBls5ZdG5akofEoxVAuf3GdATjNHPi6ped05cxaQyOipKPZar+iT46iHP1a4MLOtRvQHOmVMkKafUAwRsD84zNZZX1AaMsPJ0EbO5IasRw8naT7gWuK686b4vYMpeXJ72w1wCMQS+yON5kq8WHRKwMJtuB2WOHYzdgVmpsNUiiIFeZ+K+Ox7D2WPcW4eenvqO9IR1RkOkvaGme1/X4YbNDbAYIdZafJ6niWm8PWvAZje8Ng8X+chBl7GN0mZniDT4t3PITNmx+PKNAZDgaAPPfghbVBgbDokKRcgj0uKkTSvDId7Rgc3eWUU8qZc02IKjdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbSxOXRnifCqSF65xQrfagOpsDf3jFZ5tu+Yj2QQgmw=;
 b=PNRCNzfahkty2VdOeMRlTCOL8vbAuvbSFmZpMbriviw041GWrjoyTNsAmCc+RBqWrQZdAQlqH79xpAu98f9VKM4S1jyOw7FhAACQwfg1UXnPTiJ3dBk4hc0OKk2XKjy4DwOYCAJVxPKN8Khe4N82CQLWk3Y2nksOtsFa7ZW4MEdr39EX1POmvLoQ0lC9dKJ6IGvOS6HyZ3XLFbWxPh/S0nOKeEvJhdWbv1wwK39L8D8GU6ttmH79EmfGTbvFHONOb9H89tGvw+mgMVKOFVhLrKB/BpM0UuFvnqakAlmvvXcc5VaHbYAjl0Rw3nCuZPM9E9lt5yJGxkOgJxKO9MkOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9013.namprd11.prod.outlook.com (2603:10b6:208:57c::9)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Tue, 3 Jun 2025 09:22:28 +0000
Received: from IA3PR11MB9013.namprd11.prod.outlook.com
 ([fe80::112f:20be:82b3:8563]) by IA3PR11MB9013.namprd11.prod.outlook.com
 ([fe80::112f:20be:82b3:8563%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 09:22:28 +0000
Message-ID: <1e92a26e-1fb9-44bb-86df-8007cf9ee711@intel.com>
Date: Tue, 3 Jun 2025 12:22:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
To: Vlad URSU <vlad@ursu.me>, Jacek Kowalski <jacek@jacekk.info>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <23bb365c-9d96-487f-84cc-2ca1235a97bb@ursu.me>
 <03216908-6675-4487-a7e1-4a42d169c401@intel.com>
 <47b2fe98-da85-4cef-9668-51c36ac66ce5@ursu.me>
 <8adbc5a0-782d-4a07-93d7-c64ae0e3d805@intel.com>
 <20f39efe-ba5b-44b2-bfe6-b4ca17d6b0c1@ursu.me>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <20f39efe-ba5b-44b2-bfe6-b4ca17d6b0c1@ursu.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To IA3PR11MB9013.namprd11.prod.outlook.com (2603:10b6:208:57c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9013:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b882afa-b2f5-4713-daa2-08dda2802905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHMzWHJTczBGc3pSMFhyU09WSnBWSmhuM0c2STU0U2pRVjQwN0k0aFg0azU0?=
 =?utf-8?B?YndVY2ZtcmFkZ0ZpMUZUOWx2eTZHL0ZIY2JNaUlhc2dNT25TY3hIb3lpQVV2?=
 =?utf-8?B?dEFqVkRsMWFOZFNtOU5oN2VhNEpkUllTWGhET2FoZ2I3RGNHbWtwYlBjaVNj?=
 =?utf-8?B?TTNNT21QRnlGSzNLU1NMR0xIem1JZ1dQcENxNXlORDlqd0E0MTVFZFhRY1Fn?=
 =?utf-8?B?dGJpUTE5TGJZSllZVDR0TW9PUkM5bVF0SElTRGtwekhaaUhOaldNSmduUUY5?=
 =?utf-8?B?ZHl6M3hOQkF6bHhRUXFOcXQxZmF2cll0Q1JETU5LT1MvWGdCZ2JReFJXdDBP?=
 =?utf-8?B?UDhRZXZmSmtvSFZxRk9jMHRualhHZWFQTncwU1JnVDhYZVo1ZTduWG9mNmxw?=
 =?utf-8?B?eFhoN2c5Smp6NFZxWWtDb21mZVFpMFgwQmZ0KzIyalRjYS9HOGxnNTFsL3li?=
 =?utf-8?B?NUFVS2dTZDl1c3BwSVl3bG1qNFBuUm1rUnhVWXJjZWhpRTk5T2lpQXJOTU9Z?=
 =?utf-8?B?RDRXNzVjRE4vUGFZVnR5RXU5L29WRkliUDdqNjNDMmtWMFVjN3R4UERrSndm?=
 =?utf-8?B?T1QrQkJKWklnVXFmcTd4M2w1ZWw0QXNRVmFDTXpTMFIxVTVKMk1VUm03R2Q3?=
 =?utf-8?B?MDUweDBQRzVYbnVDYVVTNjNzVTBEMlcrSmQvd1FQRUd1bHlWMkFDVFJEeUpv?=
 =?utf-8?B?ODAxZWc0eUZKOGZ0RmpzY0lPMDgzVWhjeklqVXNtSFNhc2I2d2VtK3pVU20w?=
 =?utf-8?B?SHhJNHNWNFAyZWNLVXIwd05QWkJ3M1NHMTlNbzRIeS9RZE5vQndVWC9KZ1lu?=
 =?utf-8?B?dG9yZHJ0MkMzU2NMM2t6WHhOSWNSK1VhdXhmU292cHcvdE9vSURRdXI1cFFF?=
 =?utf-8?B?YUMrODJCTUkySVdnaGpJSkNGVUVLcStIakV5bXE4d3pVSmsyeXM5Y3FOS0pM?=
 =?utf-8?B?SkN0WUhNK0NZdnoxc0ZVTC9RM2hVYVFtUUpHZFNITUxTRW9MVXVBN2xoQXBF?=
 =?utf-8?B?MkZ6eXhmaHVQV000eDlwZmc2cFAzdEw4WEU3WVpTQTkrV1dWN0pxZTVzdHpI?=
 =?utf-8?B?dUtoU3o5SmQ4ZUsrSzg5OTE5UlQ2QmIvSmE2MzZrV0JDZDg5WU1nWTJqbnZz?=
 =?utf-8?B?UzdtbHJlb2pDTDljdHZMaXBZOWJzby8yNExGdHdNK0g4Vis5cmFwVGNOM2Yr?=
 =?utf-8?B?SEVmVnMzVUVjQkl1M29UcU5BR0dxKzBqbG5NenkzejJXcTdsbmpicDd3VGlZ?=
 =?utf-8?B?cVJaQ1NjODZ0RjU2Z0lzSUNYQWpEam5McUV3Zit5T01zQWRUU1J1bkEwTmNu?=
 =?utf-8?B?NEw4OExsK3QrTHNGdkkxV1JuczNnQlZVOExwbHVjKzhBYWRpcWEwZEZQL0Uv?=
 =?utf-8?B?TmQxUzlFbXZjcjNuV1k3MEJYQi9veVZUekNrZWZxWmF0M2VESWlJRElqLzVD?=
 =?utf-8?B?UnMreWRBNnYydXRVUnBTSGpxVkh6OGJmRndmTUN5NWQ4NENRR1A5cGlLQTM2?=
 =?utf-8?B?d1JlNTRQVmxCTEJWQk1NU0pLNndTOFA2aFFOaFFyNjl3RFFLMjgrd1ZXWU9i?=
 =?utf-8?B?SFhTRGIwcVAvNDM4dFVleThPb05hb1hadlIyeWlQYmI5RUIwb205N2lxS080?=
 =?utf-8?B?MU4zYUpPZkxiWGpUb3dtVlRFMWkvTnY0azJ6cm95elVpSU9NZ0t4bzlOVnZx?=
 =?utf-8?B?WWN1eEtjYk1iUWRYdVV6VGxKRnpjRzE5NEpiTmtDRk9CcGpxN0tQTEp3SDJG?=
 =?utf-8?B?NDlyY1FmbmZSb09kZDB6Z1RmWVJEUG8yUFVmOUtHOEo4dWN1U3g0U3l2OUs1?=
 =?utf-8?B?b0o2QitWZGs1R2FPMkxLTTZRSDhNdEgrQTh6a1JPYzA2RXRMS1BRUWNBSXBs?=
 =?utf-8?B?ZGVGTlpaMUFCNUtTU2dUQVUvVW84WUZsZkVzaThZdUZrbm9RMXZVQUZFVmtk?=
 =?utf-8?Q?bx7G+KvIHQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NITk9ZRmNRNzZOcG1DVWNxRmhvOWFCVkE5ZGxzaHVkMmF5c1BKamg3RlhF?=
 =?utf-8?B?cm5SdjdPUHVpaTcybzVKNjJPMWF3c2JneFRCT2szS1ZvQkphVWtnb1EvM3Ny?=
 =?utf-8?B?aWdIZzVuNHlWSmpQRnZPSjlxUVdhM0tpK1I0MUlkdEszOXZ6ckxFdkl1eHZY?=
 =?utf-8?B?YlBtaGhuMWxySHU0K3ZtUzlzRWFsNWRxSk9ObUxtMHozT2JKWVZzQWowU3M0?=
 =?utf-8?B?aTByaGN3Tm03OWQwV0R1QVprNlZ5d0FSWklvT3Q5ZjUya2RvTkNnZFNGenFN?=
 =?utf-8?B?L21yNDJ3U3p3Z3JkZmNzNWNxeFRicU1aTlY1NlJseURiQkRCOFROMkRVR1hY?=
 =?utf-8?B?NGwyZUhOQUExTTdWaXVaaXNSWTZrSUc2dDMzWURDOW5uWXhNSU9yNWNiTUt0?=
 =?utf-8?B?OUc5c3VNY2xBbFdQeWRnQXd2UUF3ZHdhZmlJcDBTVGhIeGZuVklQZm55cXY4?=
 =?utf-8?B?WkhyWHBqU2llRXovN1dGVnYzSlI4d0p1bjBlS0NWbCtrSko3MytrVjBMUXBS?=
 =?utf-8?B?MXhEczN3YzRhamZiV1VVNjUwcWZORHRiQlY3QkZZK3pCOE1TNnIrWDVoNUYw?=
 =?utf-8?B?bEQvYmlPcmRIeEVpaGMvc1d3ZkFNWW1TeWQ2SlIraVEralpBM3Nkd2Z4OVhM?=
 =?utf-8?B?My9GS25zb2JyVWwxaE53WXN2OWpqb0NwWDFwVWY2K2tzQUpFNFZsa1hseGp6?=
 =?utf-8?B?K3dRcHloVUxrUlNKNnd2VVdZV3EyTElZeWhtNW9DZUVjYjdpZld5M2FYSHQ2?=
 =?utf-8?B?cGRuUHpGdkljb1FwNGp2cDJLMkt3QWQza0RaS2dMOWZoSDREc24vRjlFYnhy?=
 =?utf-8?B?NDE2bjZrd1lQdHkxM2l4VXhCSm1yUWpjYTg5cWFLTmRIN3EyNmZBTVBQcXpB?=
 =?utf-8?B?YVpyM1ZIUTBpVmd1aDhxeGkrZjRHdExyNzJRL3NSeGxld2dwVUJ4NWlRNW8v?=
 =?utf-8?B?Yk5QdGozUk9PcFlwTzZaUlVUcXp6OEtZL1RsMHg2WC9yWUVseWxDcHRwUENn?=
 =?utf-8?B?UEhJZGNFMFdrRklJSy9PVy9wdldOcVRhbDYzdWNKWEFDdWQ2UjFqMVIvVi9w?=
 =?utf-8?B?RjIzbHR1K0dmelRvRWdxTnN2TlY1Y2RVbjhGbkFpWm5FL3VMclQ2bSsyV1Fo?=
 =?utf-8?B?aVRHcUIwNWxHN3puV3cvTVVzK2U4VCtIck9VcVEwd2dCN3hmN2w4WlJxTktO?=
 =?utf-8?B?WGxQbEw4bVQxSW1acW53ekc4VVhKSEh3djV6WndIUEpjSm5QVW80SGo1KzFn?=
 =?utf-8?B?NmJ3SXhwRFk0SnExUFowai82SFpkbWdZZXhHS0lnRlB3djRjL2lGMWIxbU9E?=
 =?utf-8?B?NVR6aUw5cjk0U2JPeFJpS3RiakhoZ21aeWNCTTVKMVNLQVZBVldOZThORDVa?=
 =?utf-8?B?Nm1lYkcyaklrTXJTNVVXQWs3ZzU2SW94Y1ZRQkhCeVY1SEt3WlpvcUoyT0pL?=
 =?utf-8?B?RXkwOG5LS3Nmb1ZhejJiZmtTdHdKb25tVzc5djkwMldpUUhMRnlBZUNLNTlG?=
 =?utf-8?B?ckNHRlpWN2toSGE5QzhMN3dVYzY1Nkg5S2dKWXBzWXh4RnZtOUIwNUhTaTlY?=
 =?utf-8?B?NG56WTV4UTkreGVyTHJNd0xPN0lSL2Q1YktLQXZ5Z1k2c2ljcUdQdG5iUlJl?=
 =?utf-8?B?d2lnVnlYOXVGYjFSRy9BOXpnbWtNUXRzaG9USU1tblZ3SVlZTFpIRmVtRWZx?=
 =?utf-8?B?NnY1RmpENUc2SEJxUFlNZmw4ejB3R1hlaWFmeSs2bDZ2Mk1QMUZsS2pDaUI3?=
 =?utf-8?B?UGdIREFtZ01jVGZnWmM4cmtFN3UvdGw1bTIzSituazJXWnZQdkMwYVR4VVEy?=
 =?utf-8?B?NEp0akpYV2xwNi9iKy8vNElZYjZ5bmVac3JEQTdheUlFL3FxeVhDMlY5SXov?=
 =?utf-8?B?MU5NcW04ZWNWV1pMZEJzclVYeFNidXlFaDBSdSt0b2Y4UmQ5UWp1TWUyMTBi?=
 =?utf-8?B?ZU55Vmc2RFpUV0c2WEJWWmVZazJUdmlsQUx6WjhtZFY3R3pCUE5CaEhGUFRK?=
 =?utf-8?B?Y1NlNFpiZGJOY004bTVyK3RZWnBTNG9KTitnbTA2ZVBjRG9WYXJuakFkZ1h6?=
 =?utf-8?B?cVlYZitvWUZVOW9xclp0UXhteEh3SUNKV0M4Ri84V3NxNGdkRUJpSktYUFVQ?=
 =?utf-8?B?VW4rdVk1L1dQMW0zdUdFVklwVDFSMHJxY3JPUzUxVlVvdlJiR1RFT0xEMU9P?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b882afa-b2f5-4713-daa2-08dda2802905
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:22:28.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XryWvySopRe2okdnkq7TuuvL6eVv6n0f5N4vo4E/MDgkF0UYmxuELx3oUV/OG+IBNYvy3PCQ2fVHtR7pvLb3VO3CJ6J+ygYUkHsu5oeOL6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com



On 6/2/2025 9:44 PM, Vlad URSU wrote:
> On 01.06.2025 13:19, Lifshits, Vitaly wrote:
>>
>>
>> On 5/15/2025 10:07 PM, Vlad URSU wrote:
>>> On 15.05.2025 07:39, Lifshits, Vitaly wrote:
>>>> Since the checksum word is 0xFFFF which is peculiar, can you dump 
>>>> the whole NVM and share with us?
>>>
>>> Sure, here's a dump of my NVM
>>>
>>> Offset        Values
>>> ------        ------
>>> 0x0000:        d0 8e 79 07 78 c8 01 08 ff ff 44 00 01 00 6c 00
>>> 0x0010:        ff ff ff ff c9 10 54 0a 28 10 f9 15 00 00 00 00
>>> 0x0020:        00 00 00 00 00 80 05 a7 30 30 00 16 00 00 00 0c
>>> 0x0030:        f3 08 00 0a 43 08 13 01 f9 15 ad ba f9 15 fa 15
>>> 0x0040:        ad ba f9 15 ad ba f9 15 00 00 80 80 00 4e 86 08
>>
>> You're right — I see that the SW compatibility bit is set and the 
>> checksum appears to be incorrect.
>>
>> Since the NVM is part of the system firmware and typically managed by 
>> the system manufacturer, I recommend checking whether a firmware 
>> update is available for your system as a first step.
>>
>> If no update is available, perhaps we can consider ignoring the 
>> checksum on TGP systems if one of the following conditions is met:
>> 1. SW compatibility bit is not set (current Jacek's approach)
>> 2. The checksum word at offset 0x3F retains its factory default value 
>> of 0xFFFF.
> 
> I am already on the latest firmware. I have also tried downgrading to 
> earlier versions and they have the same problem.

Ok, so in this case I think that we should go with option 2.

Jacek - can you please add this check to your patch?

