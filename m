Return-Path: <netdev+bounces-285262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKgMEJJz/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9654E747E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BFED30090AD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D23939B6;
	Thu,  7 May 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmpPC6Ig"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B638A710;
	Thu,  7 May 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152333; cv=fail; b=GqpZykdGWGoA3ZN+mHhiRC2U1efOo6AJr9xJMCvjER60WlY8kyHbr/xlQh1q16LJzltshRKYk3HIh/Tu3ui5HhY5ELjYZuronjozjT1rOkfFvtWdW6oC4XfscVkmcdpXJrFQ4sma4VazSXoSfweQ09axjVTF5MCf/V0EpoWdKQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152333; c=relaxed/simple;
	bh=vbBm+VDYVfXQR2uRS3YV09/mQdJtSj9VGr8leUXuUQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2KY58ps/M4RJ/Xj9tacx4wPtreEP+nD1dPM4sOLjZe7K74ByWMPcPSQgI3iVsyEjd1/PvRKkJk15XHN5bn+C8Lai5Lo+IxucJIaej+gEMWwST4CzBU27XxkrNUyGzEbvageRL/l2gw2wrNYDjOC44iHXy9oYvKOYxjyXNkt0Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmpPC6Ig; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778152328; x=1809688328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vbBm+VDYVfXQR2uRS3YV09/mQdJtSj9VGr8leUXuUQ8=;
  b=BmpPC6Ig3AqnmbuMtLXIx44VvwZTV3pKYVFlzb6LwHuuhnlhra8zNtEI
   c6sZpXVnthn0gTZ4PJYRo1FUiK9/JgBO1RDG78gqtxLdon9X+BQcfFN2e
   s3RLqhHItClJGH8m0hzKV0ZxSRvBB+cAcrKqpXupSnPM6+S95h4Y9VffG
   hCdTB2TgwGS4yOuCmjkq9ghsQWwYhCER8+aTHgGTvLsGKo9pyQgoNN4hE
   6HSHzuGzJCM+nugMGORek4vbM1hgJ/viHtAzvvA4EKQz0X+D5mIjrknHW
   1Sv0t9xfRaVDyHwqkNHlA0R+OOy7Xz6ZVzhBxflcO4a+UAhUwKKBtbYDa
   g==;
X-CSE-ConnectionGUID: fykZpvoJTEqufCz+Ov2UJA==
X-CSE-MsgGUID: oP7oPoQPS+uXk4Y6lWBDgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82720587"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="82720587"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:12:04 -0700
X-CSE-ConnectionGUID: wJpBUivnTgOu4+H3tS0nyw==
X-CSE-MsgGUID: peziy9wqQ8Oprxe0+AVsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="259862923"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:12:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 04:11:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 04:11:59 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 04:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMLCBaPmYtncZXDwKMch22ywvaFggmBr3aLLZu0nCOrSg/2miWST/VWIN9jjqJdKCQ5EtaDCWEbeJwCAWMF3xglP3P5vrHVyguL7XtMvXqSa4bAecJvqCwtxCibU+WamEzQEanJCcSvEmwGsCW0a7OAPOFv85yOwX8T6r5pcGTSC/7mERJsKKD4lozPgOfOvYf5aN+Gh6hhFBDuw+P+m0lUhpWGW7Yc5yLcqQP5kc22nHbLHa5dYARicT4fxDHWimT/4SPj/jq7DLqo/9Dpiq4G69AA3PmgVBPWBTKjJiHubA9f+/12fEZeAO6MHchOYMq08Vgzc4I3Xa3NtrgmM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbBm+VDYVfXQR2uRS3YV09/mQdJtSj9VGr8leUXuUQ8=;
 b=LfCYsX22d6OZuPBpq4eazHIonH1HxL9P4xSzl03UBZ/ryNIe8trrDTjTAaqKsIyHTm0p56piSjz30GZICWXm7TwuwBAaaKMTsVEIYltK3ouNZ8JNdRmFA6HGnznZktQRtkCnJixqW6LsDvG979uNAaZg3l7Fv6Z1LqcsUGjqo/0varxHCnXJRFBvw6eCQzGGga+ZKeF8+jvwStonx8rpuO+yS58XnCeQ1P0KJWdT9OrLGWLTG+ezcjYH/JE87vzFxWIOr1d5YIwcoBcyc9D+HVavPgkp+zPjE5AW7nXgJolCu6+8HMgfhLg1chVXvUPuaNzl9qWvRYwdczf7QWsp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 11:11:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 11:11:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, Johannes Berg
	<johannes@sipsolutions.net>, Arend van Spriel <arend.vanspriel@broadcom.com>,
	Marco Crivellari <marco.crivellari@suse.com>, Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>
Subject: RE: [PATCH net-next v2 2/2] net: nfp: Drop PCI class entries with
 .class_mask = 0
Thread-Topic: [PATCH net-next v2 2/2] net: nfp: Drop PCI class entries with
 .class_mask = 0
Thread-Index: AQHc3g9l2K/Ws8mYikGUqORXRu+uKrYCaG1g
Date: Thu, 7 May 2026 11:11:56 +0000
Message-ID: <IA3PR11MB8986B1F024FB84A606C093F0E53C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <e853a41d232ca831a93a84545dab322cbe5d49f9.1778149923.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <e853a41d232ca831a93a84545dab322cbe5d49f9.1778149923.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: bc036ecb-6b74-49f7-ad27-08deac297393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: IEsUeeCwPvOuDaxmgulRMA11BKBYmMTiyFPVYWSOnNq/BCi0prUWVeBTwJHGjqc7rG/HPk6AJ7nXjrSuDENDzVZU6WpPJhC6+WzclHy1wGS4paGAJZ1SN5+kCz8c7e+m/8A/lJ7TzUmDEgI+kPhWHU0AdS1+gkvkjlHttvOJnChQTmFMqUhQcDbefbt/Y6UKvHh1WuZK7gdi1ONOwXSahrOB6Bn8UFrSWq2xdIcyk8NKqgdqLpCB0HFJfeBU9QigrRRESCP2q877IEJB8CpziZEhogTmmfjI1NMuKrKuDdi8t7HVxCfy6GjVqdc/MSo2HmO1FwuDKtdnk/77YMeridRlRNazMrWQ3AghNDn6XVmGpcZI8RuU+ZAVPAD/UKgkm48K3c2f3bOxk6InaWsRNoaEEstc3x80Y4MbM6Q+fa33jjSUYOFCgIoo04pTioS0049IrOvcEUwparqrPsU3XApiVDTuzqWChbGml7MLFJ5QR5SyQe/jxPgg29elljDxr2S2gVdxbpmRwtWukfuMlPxb6kbiqIfdITsjO6rwYZdUr9CxXYp0fq61JTyw1eeGtMMcwiinpDPmQHgo4WQJdeoYCQJCSNDXOKwkCIbpCmIf2VGP4Ou70+YnO0jKSOZ7OxP7ZeMuprm1HaHbXtuh2uQYd9/VDKUhIlD+BkOLOwR1pbueQZgctOrANV5R4fcVWYxkR/+6HxgN7JhVYYMeS6cUtt7QJYB2LMTm1oBA7SlNbT58DvyESn2RoRlWR+89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVcydXpyQ1BrWEh6WTBTMFByd3dnVDlHcWJ6NTVCaXJFNk1idDlEdkl3R09W?=
 =?utf-8?B?NmlJVk9uR2YyR1FndlVsek9GaHAxRGtRTGxVWGpmTjIxbWNSVUlIZUM4MlI2?=
 =?utf-8?B?KzVveStydk9kRFV2RzZPa0k2eTRYNXJKM3VOdlZWTzNvOHdDTzd3ZlVJZmJD?=
 =?utf-8?B?TzR4UWFxY1JTc1RwVUNVelkrVUJOdFZWcWlkejhPVTJQTUdlcVV6eHJwN25l?=
 =?utf-8?B?OG05Vk1NbUl6dUZaL0FqcTRLd3F5NmJkQmdrbG9KMUY2cGJDNmZGU2p6T283?=
 =?utf-8?B?eEtTNGpRZzAvMVVGQ2VydVc1UHpDY2t2VTJJMlpVSkxrWWZTbmRDWTRBcHFZ?=
 =?utf-8?B?dllFK25US2pyN2lOOGNhZFpPM3BZbUVDZExHcGVwWkNXZW5oQzdTNXZHZW10?=
 =?utf-8?B?TFA2TTZpTzIyeEtmc1hvVlBBaVEzMlhzSTVMVlFlSThrM3RpendJeWdWbnJJ?=
 =?utf-8?B?QjhleTJTNFVmSEVRME5lNnhnZWdza3EzV0daZnhFMGdzalY5djFUMzFyT014?=
 =?utf-8?B?NVp4eFFJYmpPTktzcGFIbHU1ams3MWhMcC9nTy9WWk8xbUxTdTluVkpMNThu?=
 =?utf-8?B?OWlLUkMxQThNWFdHUHBTM3dMWXpvdEtFMGFQalpTSmV1ang4bVJkOEM5UDR6?=
 =?utf-8?B?VnJSdmhCcjJRME45ZHREVXVKOWVUUkVlK3NuUElINVpEWDZwVmxQaDJqdGQw?=
 =?utf-8?B?ZXdraVFOd05QdHVvT1luZmRVVTBFbFFGZm1URkR5NUxDZFUvYWJhWVRYRVFq?=
 =?utf-8?B?aFJFb0JGUlpFYmRmVi9xdmF2aG1WeitRUk9lQ3pyRXZaZDdtQlAzQUhUcHJx?=
 =?utf-8?B?cG1VVkpJYkVoLzJ5UW5pWEk2ZnZONm9YRTYrcmFFWTJUQURoL0FyTEk4SDQr?=
 =?utf-8?B?QlE4ZXIyTTByY0plVDkzZEwzVVJ1cytvOE5Ic3dxSTZuYzJtdXovM1I4bjds?=
 =?utf-8?B?aG16RGJIUDBxQzQvVU1aUzVjazVoUGxpSE9JZDBtT01HOUVHT0dOTS84SDNC?=
 =?utf-8?B?V3A2VlJ1RDRQNkxIcnJTYjhQWWI0QnRnSS9tT0wzU3lMYWo0MVNrckUyVFFt?=
 =?utf-8?B?NW1wV3pLV09rbEgzNkJQWEl3NzdTb2x5U2FiS1hKaWs3REpSMlZtb296RzBv?=
 =?utf-8?B?cUlkWkY4ekNvcFJLaE84emlwOG84YTV5VlFnMENvcHE2cm5rd2hDNDVPbzlN?=
 =?utf-8?B?OWlhMVBncm5KeVRUYVRMMktpcDd1QjgxMTlSazZ0cTZYV0hrYk1xT01SdTR0?=
 =?utf-8?B?V0pTZlFDWS9XTFZyd0c4aHV3bGQwTTN3TEZKd3BBaEtYS05ZVHg5OGljU3hF?=
 =?utf-8?B?ZGl4ejk5TDZldEZBQkM4THYydGwwU05xajF4R3plL3hJSlBVdjV5KzdLS1Nl?=
 =?utf-8?B?c3pIK2VLMFJkMlAzeFBwcmNIM0QwVklhcGRqRFZrcncyeTBpK3dyTkRuOVRv?=
 =?utf-8?B?YTB3WGUzY2N4amtGaExTV0x5QlZkTHc3QVE5bTJjNmhHS2VVbi9vMHc1aHBm?=
 =?utf-8?B?THZqUHFkMXE3WXFoUHNyUUY4ZVdXckJ5aFBaNk1NSXJQc2s0dHhycWdQTGxN?=
 =?utf-8?B?YzJzRlgvbG9RbFhZRGJrV05lME5uTmYvOFFIRHRHWEwrOUErb0JjdTBqSUJK?=
 =?utf-8?B?RmZReW9RRVlvN0VQMGxqSUNQMHp5RUt6dnhEODJHbitOaEJjYjFvNkw1aTRx?=
 =?utf-8?B?cEo2ZDh6cWNGMmdJR3U4ZldtT2UybG1HcVpIVnZyUHVrUnY3WitRSkRmSU9n?=
 =?utf-8?B?UzBZVDhaaysyME1GRG9oNnhxZzRZN1NESFo4aWNRcDQvQlZuenBwZ0FZNlJY?=
 =?utf-8?B?Y1RMbmp0MThpc1lTU1ZOZU43Y0s3YUg5Z3VIZlVhdDZ4VUNIcXdUeUZHREVO?=
 =?utf-8?B?aHgxeFBWNzMwa0JaMkh5ODhWWHRkU2ltaVBVZnJOYTAzVVNyL0d1bmVrL0hT?=
 =?utf-8?B?ZXRLV1V0a0k2dTVIWVZUK0RKUGpnZGl4YklnbHZudnI5ZkNVdEtRdU1ON3hM?=
 =?utf-8?B?TVlTeXhkOW9UUHZIZUdpNytYODJrMFlCN1VZeDNIMUhFQWt5S3doRzdHakh0?=
 =?utf-8?B?MWRLWFF5TE5PV3A5RWVab0QzMDFNT3VYTHY4WE9oZ1J2cmZxUlUxRlFlbHpt?=
 =?utf-8?B?Wlp4WFBYK1JOcXZNVjluaTRvSGFKbm5aMW9URDBkd1Z5SUdhYlkwWm9TTWZ3?=
 =?utf-8?B?NHlCZVVOclZZcFZGNFBwZlhYT1BtRGZ2dHRYeG0weFFyWjhxcnZRbEdia2tG?=
 =?utf-8?B?ejlUdE5CODljTXd4ekxpR0drQjBqV09XMk5xT1ZqVm45bUFpU2hma2NJL1NE?=
 =?utf-8?B?eUJCR1VXY2dQWjFRQW1TaCtJYzFRYXVsbDVZd09henFUTWFGcUZ0VXZYSjNG?=
 =?utf-8?Q?ex4Wtv8fN8U8Cjt4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BEJUNxL9Pmifi30Wg5tio7EuUon9W4VGSui4ywr8OMoQeGtq54PvgE9qrRO/YVSDhAp3Kkf2j2EFRwn0k9VKlvMYhp5+7kBvyZEsJzLlpDC8nEVxWpw7oncmXmvh1+qEjOWmwAYwQSBifmOlIjVKE+i3gGnuO9SYwipmDu2IGRlb14u0df9WjazVUFsxvhAcT6jIaloIVy/9cXqYCwxn4pJuwOWpQ6UogiD0LrG1muhQlOdX8JMVgpWVClUo4Yzz4G4p4fxM9CF6HJgfLD0SiwXGgtoATnjzLiHSP37iGs/0ZJ4mx1I2WEXvcNW9L1ZzSinafFjo4LIZtJ7LYgodHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc036ecb-6b74-49f7-ad27-08deac297393
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 11:11:56.5835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Mi3Q7MFaFfk3K40VFaxLSvLQ5WUT2xHcwseHQNCKpaEa7dfOS0Ou63s5igGPDpMLb652KR+L1cdY4XzoJYZPJKeG8q9mO7lLLvxV41LTO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DB9654E747E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285262-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgKFRoZSBDYXBhYmxlIEh1YikgPHUua2xlaW5lLQ0KPiBrb2VuaWdAYmF5bGlicmUuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgMTI6NTAgUE0NCj4gVG86IEFuZHJldyBMdW5u
IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBQYW9sbyBBYmVu
aQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IENjOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBQZXRyIE1hY2hhdGENCj4gPHBldHJtQG52aWRp
YS5jb20+OyBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PjsgQXJlbmQN
Cj4gdmFuIFNwcmllbCA8YXJlbmQudmFuc3ByaWVsQGJyb2FkY29tLmNvbT47IE1hcmNvIENyaXZl
bGxhcmkNCj4gPG1hcmNvLmNyaXZlbGxhcmlAc3VzZS5jb20+OyBLZWVzIENvb2sgPGtlZXNAa2Vy
bmVsLm9yZz47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBTaW1vbiBIb3Jt
YW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBvc3MtDQo+IGRyaXZlcnNAY29yaWdpbmUuY29tOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFy
a3VzIFNjaG5laWRlci1QYXJnbWFubiA8bXNwQGJheWxpYnJlLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIG5ldC1uZXh0IHYyIDIvMl0gbmV0OiBuZnA6IERyb3AgUENJIGNsYXNzIGVudHJpZXMgd2l0
aA0KPiAuY2xhc3NfbWFzayA9IDANCj4gDQo+IFdpdGggLmNsYXNzX21hc2sgYmVpbmcgemVybyB0
aGUgdmFsdWUgb2YgLmNsYXNzIGRvZXNuJ3QgbWF0dGVyIGJlY2F1c2UNCj4gdG8gY2hlY2sgaWYg
YSBwY2lfZGV2aWNlX2lkIGVudHJ5IG1hdGNoZXMgYSBnaXZlbiBkZXZpY2UgdGhlDQo+IGV4cHJl
c3Npb24NCj4gDQo+IAkoaWQtPmNsYXNzIF4gZGV2LT5jbGFzcykgJiBpZC0+Y2xhc3NfbWFzaw0K
PiANCj4gaXMgY2hlY2tlZCBmb3IgYmVpbmcgemVybyAoc2VlIHBjaV9tYXRjaF9vbmVfZGV2aWNl
KCkpLiBTbyBkcm9wIHRoZQ0KPiB1c2VsZXNzIGFzc2lnbm1lbnQgZm9yIC5jbGFzcyBhbmQgLmNs
YXNzX21hc2sgdG8gbWF0Y2ggd2hhdCAoSSB0aGluaykNCj4gYWxsIG90aGVyIGRyaXZlcnMgYXJl
IGRvaW5nLg0KPiANCj4gVGhpcyBhbHNvIHJlc29sdmVzIGFuIGFtYmlndWl0eSBiZWNhdXNlIFBD
SV9WREVWSUNFX1NVQigpIGFscmVhZHkNCj4gY29udGFpbnMgdmFsdWVzIGZvciAuY2xhc3MgYW5k
IC5jbGFzc19tYXNrICh3aGljaCBnY2MgaWdub3JlcyBpbiB0aGUNCj4gcHJlc2VuY2Ugb2YgdGhl
IG5hbWVkIGluaXRpYWxpemVyKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2
bmlnIChUaGUgQ2FwYWJsZSBIdWIpIDx1LmtsZWluZS0NCj4ga29lbmlnQGJheWxpYnJlLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9tYWluLmMg
ICAgfCAxNiAtLS0tLS0tLS0tLS0tLS0NCj4gLQ0KPiAgLi4uL25ldC9ldGhlcm5ldC9uZXRyb25v
bWUvbmZwL25mcF9uZXR2Zl9tYWluLmMgIHwgIDggLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbmV0cm9ub21lL25mcC9uZnBfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbmV0
cm9ub21lL25mcC9uZnBfbWFpbi5jDQo+IGluZGV4IGU4ZTRiODRkNTA1YS4uNWE5ZmI1YmFkNDA1
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9t
YWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbmV0cm9ub21lL25mcC9uZnBfbWFp
bi5jDQo+IEBAIC0zNiw1MCArMzYsMzQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkDQo+IG5mcF9wY2lfZGV2aWNlX2lkc1tdID0gew0KPiAgCXsNCj4gIAkJUENJX1ZERVZJQ0Vf
U1VCKE5FVFJPTk9NRSwgUENJX0RFVklDRV9JRF9ORlAzODAwLA0KPiAgCQkJCVBDSV9WRU5ET1Jf
SURfTkVUUk9OT01FLCBQQ0lfQU5ZX0lEKSwNCg0KLi4uDQoNCj4gIAkJLmRyaXZlcl9kYXRhID0g
TkZQX0RFVl9ORlA2MDAwX1ZGLA0KPiAgCX0sDQo+ICAJeyB9IC8qIFJlcXVpcmVkIGxhc3QgZW50
cnkuICovDQo+IC0tDQo+IDIuNDcuMw0KDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlv
bm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

