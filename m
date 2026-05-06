Return-Path: <netdev+bounces-284862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N2lFlhM+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:12:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A62164DBD78
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19BF9308466D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F5F47798B;
	Wed,  6 May 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYcVgVHP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4667466B73
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076220; cv=fail; b=IqzWe1HA0nJG4CtA074I/J5nL+S0X6V1eiXnr69cTa/JZFV1ZyrKo6sL45egSRClgkdsuxE6OXujbCtnqrRpycqDaldfSvruTXZI9iHu50GHTzGVfaBVmyUgR5zpSQIQtS7VMEvw9to0IE4gq9PI7ZrFTCI6T4HlT9+CPmhhr6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076220; c=relaxed/simple;
	bh=nKP8hBmuNLwkwKDUV2XDaCYv1zMrUJkgNxuCMX3LtSM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usplV9Qhkv3MhJDuHD2L/ET+H3uHh71TWJGTCOoe55meeP5yc5RvlWB6kmKfwAxWo6cCXPPyER4qRWHWTm9W1nUcPPWPFq4eyB3Kg+P7B1uJBVJ5WFFWoFHEa8ZoUtKyt1CmI362noV3WMhfp0+xQtyzn/yQW8CUZwbdYRsfXJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYcVgVHP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778076218; x=1809612218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nKP8hBmuNLwkwKDUV2XDaCYv1zMrUJkgNxuCMX3LtSM=;
  b=JYcVgVHPOSwlF8slMpOPOTJV9PVq6HymRtnMDd2r3wInlMvfkBBLB8ug
   pSCQ+0r9B/jdvYhTZb4z0W7sP1Iq2MDT3+3onk6KIdi+CA/2yUyNF7mFo
   1XU81pkbIP1xR6WNCqX0pbzsUMkXgPptlVok+Bt8ZVpq0ZdXBK7zvLGSX
   Snp3f+HVNPUVnD7KopQ25H5oVjFCGP4WCqAfOsylQmfhLXmG8f9kT7gQY
   JO6T5J+WNdZ3ToQqInIywOxiikWwv7inINrD6Eo4OWvZTVPrMQMr+R0bK
   w9Wo2f+VcicZ/CAEFdH+owGrbhcnIaQ0Elo00rXXDcQRCc2K53evt0c2z
   w==;
X-CSE-ConnectionGUID: mfvB5mtaQm6UnaeFW8MdGw==
X-CSE-MsgGUID: ieM4qNDVTUeCOSKsP/CGCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96576052"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="96576052"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:03:34 -0700
X-CSE-ConnectionGUID: ftX7kKV/QMGvcaOkCmWPgw==
X-CSE-MsgGUID: sO7QFEZ+QaCEVl78BYDrEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259579124"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:03:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:03:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 07:03:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAW6j6FKGkYq6WkXMeqRJcRMeRtOOU7wMuqKSKxGMD2A+ENYYIBXB/Q93Qy0EAPeMLMliWk5rEFeiCEw8XW/9vjfSOFT0OURQ/H8MH1EfbPHIWNviCq9kW71WX1D1YaFxr6u1vV81s6j1Sn7VuJummgw4+Kh/R7rg8GcjhjF27htnWK7zh0och1V5xSKrmCdYr9X4tlSnWDhW+40dMF0K3NV3qFRcupCzGi5ndEOcC0lQxMhm0ZVJasSiRRtRLvPSMDMyvpI3otvMIDuCsxcHibvjZp7TuGD3SCAS9czV8qXtls/EH7w8E1IWsBem+wh6oYF4QoJQgCoJ3rv9zdr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKjqysjpRhusQ9m0SqltFbI06d+le1siYeVKt8QtnHQ=;
 b=VCv/rKiE8N3wURuWllKrmriv77g2j2ZjDXRIIwzRm2tHNKEH+QePLQEoac2d0mTZJsa4RVZ9mQHwhNnQ3tH0vH20Rr4v2s+fswHp5PkCjHdoHiT7G8X0oBLN/IK8k5ifEKuKbhWSQwSmh/cClfWmRQlDpwcJs9lnBYSJJw8Fa8nCDBxAYcJt3EVfZHDdqdCKxIQdFBPuqiDdr1Jd8V33PFzt9nOV2RrtNDFLGOyzS0+o6hBM8LD8rn9CD85Mlgf9clET/ImzdHxJfZCDdjdFnDMp2ygda4uZupgZtT70/PYY+k+MYv3AEKimR5HkDcT761vABkkc5zdLjCvciZI4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 14:03:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 14:03:24 +0000
Message-ID: <487444fc-7de1-4b57-9733-23e728b85f72@intel.com>
Date: Wed, 6 May 2026 16:02:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: cortina: Drop half-assembled SKB
To: Linus Walleij <linusw@kernel.org>
CC: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
	<mirq-linux@rere.qmqm.pl>, Li Xiasong <lixiasong1@huawei.com>,
	<netdev@vger.kernel.org>, Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
References: <20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: fd653da9-951b-4868-07ca-08deab783ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: H3j2Cn/OC4HWID6U8anQ4V6enayIsTIV3PancUToTjMCLkuzP93G19VPgg+F//VEjhL+IKQbvaMrUew4Nfild1lJqFWEDyPS/zMgZ7Sa4pG4B+FdElwbaKwZQV7+5+ujdk9P/BlnXNu2DnAZhTd7fqSQhQLqlFuY031urzxSaBR6TMPEErN0DG6/1YCodrYgfLjDNX2s2Uv0PIm0+IG8iZK0eMC+ryQlETDpOBMdJ1Tv0liTii5IulncfiEEHMXP/OEFuwEFzt89y+kRj0kYhmAALlkReqd7BgsLzcuq9HXI0Ki1eoEcYcWQPkgdZlQF7tYn4hKzUu4guvMwa321HkF9kjDz2P431UeEKILVLLxwJr0Mi0GoTvV4W0blsULWvJzaZzgiW/YE7t+knppNw5yHiuU+J3wazpTmALEeDfI55/l+trcl4rLtkU51J9bTv0h4/gX20IBN4pq3Wjv1AaiZwCgksb6k9mEmO2/WWExHIMUNsCfn5YreJJaf6Sxx0KaXF3KM3qPQaI+oXyhKEl7oZOqdnPf3lpVjMs+hzM98gJDDhpLncCnDUNsRwKa+a29WI/FrKtrqz9bLVjkkVo7PfWY+woHJH/V7nfqAZCCbpPVVlxQSOzNIGYEl3f7R4rgvSwGfhFT32DTU26DhZOhrMzCX78inqDWtBEEQoQgMrbT650D+Bu0plHeYj0vMjXdUduG87fSWFvN1zMde+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXFxZ0ZMOXdWNmZHdS9HdlYyaEdXa0NRTTVvdjlKamtQQU91TGhFYjdCZ2wy?=
 =?utf-8?B?M21LNTBSR2haLzY0a0hEUmh0VDhlSTNWaml0OWVnT1FxNzBUSXJXVEg3K0p5?=
 =?utf-8?B?dnlyME1icUN4SENVdGFxU3dSVFkwVWNHN1dMLzNyclN1YjBacjh4VXVqRUI4?=
 =?utf-8?B?Zm5Bc1JKVEp2Z0NBZjBpaC9ZSVk5WHZBSDRweEh0bWo2ZWJKWVlidVQweU5B?=
 =?utf-8?B?clN4dWRGTVhsQVgyN3JFU1BhR1haZTNjYmtiWVRWSnFhWHB2K21HaWpqcXNJ?=
 =?utf-8?B?Slh4RjIxOGhqbjlhUEd6KzljRThlcnErL1ArS2xqR1EvVWNKSDdmQlJYc3pG?=
 =?utf-8?B?SFcwM2NuK0hWMVFtY3QvTlkwLy9meTdvZEFPZFNIRTZvMExoN1g5L0M4NjBE?=
 =?utf-8?B?Q1R2bVF4M3pOZGZZNVhNSXMyVi81ZWxqek9UNEMzd3hPR05Ic0Fta0ZXWG5S?=
 =?utf-8?B?U2k0NHBrU2hMbmZOQ1FIdDNXaThJeWFWMGVGRWp3Ym84Y1VoOW5hL0pvQVpF?=
 =?utf-8?B?MW9UZVYrZFA0OVR4bXNIU1BRZ0VPL1FDSXVZYkgvMFhhdFdMNUV2c1Rac3pE?=
 =?utf-8?B?bWprMzB1S3oycVdrcFRQUGhyZEoveUx3c0tJWFlVcGNzakljd25JOHlWY3VG?=
 =?utf-8?B?ZXZqc2lYTGl2aHE4Y3VuVnZiRjVsMVRwemtJaDNOampocW0yTkprS2xiNDB4?=
 =?utf-8?B?eGkrSGdtdVpGRUIzVjRERExadDBadDNUMGMxT0ZVSEtXN2pDaTRtS2hmVFJP?=
 =?utf-8?B?b2NKcC9CQ2VKZFFTc1FFWXdvRm85S2VRRThSbkd3YTRDaldUZ2dQeHBZam5O?=
 =?utf-8?B?TnFNRjlSVitlY3JLR3Y1ZHR6OC9yaUU5bkQzSzVnZnVndnNYd0lrT2M2ME1a?=
 =?utf-8?B?U0dyMS8yWUs0Q0s3RWhDcDRHM1crSHlWbDFvSExSb1pYRk5BUEpDQU45cVBm?=
 =?utf-8?B?VU9jbGxMclQ5WjdTRkQwRlN1SHo2YWdBSWpyL2Z3UEtpZkczVmJkNU1uZ0kx?=
 =?utf-8?B?UnlMUnFmb25vZ0F0bzhKK2pNMXVEakFPRkE0UldHRExPb3lrWGppY0owRG9q?=
 =?utf-8?B?eFNVeDhxeWxvVEFCSGQvV1pwY1RNckJqdjVXaXhucEl3WjE3TmUybzdBV1h3?=
 =?utf-8?B?M2RwZitKeFVrdkdRZXI3VUxyTklsb3owa2xWOWtRNzRTaHRRSmlPajd1OHZ5?=
 =?utf-8?B?NStkaThHQzhpOGw3OVBPV3pZTDMrOS83QU8zamdUeWVTQ2tjSmI2NHVYWVVO?=
 =?utf-8?B?MVZJa2pxa2xqWUl1T0J1djgwelVKbmZsRFNuZDU4L3lDSlJGM3VTcXRmVDRM?=
 =?utf-8?B?UVcxaFlncEQwVk1mNWZPMDNZalVVMUR3akgySGU3bnh4UWZCMTB3aStENEsz?=
 =?utf-8?B?TkNaenZ4bWFoNUg3bzhFNjRpU3JONjM5Q1Q4QW5neEIzcFBGa25nR09mRnJq?=
 =?utf-8?B?STNMaEZXRXJrTVc3a3Z1T1FnWnVpaFhlcnMvZUE0MEhLbE93MzJKNURjVkkr?=
 =?utf-8?B?WWtxYXVvSU5iRmZVd0MrbzBmOGE2a3ZZU0lBeU1XeUtybitSSVp2OWZHM04x?=
 =?utf-8?B?YmtwRUhBOTkzdWNjRlR6MFowQTlKVWJyMWQwOWR1UU9FT2dzNXRCNjJ3Qmx5?=
 =?utf-8?B?Z0p4cFpkQkdJNGNQRHdyc0ZxSkZBNEdVb0hJRzg4YVdLZkIwTiszQmhNRHV4?=
 =?utf-8?B?b1l6b0pibUMzS3RFN0M4SGRnMm4xUW04ZThVenhFSTh2dzFpRDFGRmRiTzE0?=
 =?utf-8?B?UDd3eW9qVnFDSC9STzdoVnNjRzlRQ1VBZFhEL0VwNEE3ZXNBU3VERU9za1g1?=
 =?utf-8?B?YWpJdERGLytxQUxEQkJ4SDNiSXVLK2kzMDYvKzBxMVZRM0ttYVpqM3lIL2Rz?=
 =?utf-8?B?eUtqV1ZxTHROS09qUDdnejR4SVBMVzBtYy9Nc1ZaTHdVSlJmZmkxYm1SOUFJ?=
 =?utf-8?B?YXJkQThOcHVFK3doS05QM3RvTHRoeGtwYzFIVTcxczlYM2ROWFRsU2ZXZ0Zo?=
 =?utf-8?B?SnFZWFQ4MWpJc2FvMUlyY2tBM0kwK2ViTXV3STQ1NWttemJva0E2bUZRL3Nr?=
 =?utf-8?B?ZzdkVlJZNjl6Q3pEeEdpK0lvQzZyV2ZrZjROMjlmdWRGTkJEZUlYN0dyTVFR?=
 =?utf-8?B?SEl6M3VRVXdHQW5ySktZT0VLelkvTkRCRmJ3aVV0YnZzY3Nsb1VpMU9QeGlv?=
 =?utf-8?B?TnYrTkM2V0cxOEJSOWd1cC9kUVZwQ3VUTkJ0NnhWWTdLaG90YzQ1bnFYbU5N?=
 =?utf-8?B?V0RIdWUxNzhhMGhhZGlVdEJaakRYTEVQR2xUOG1kSU5nLzBlaDlERlhjc2Ex?=
 =?utf-8?B?d0RVOTFvaE9KZWcxeWU1ejRrQzlUOG0ydHA1YWFKYUhZZk9oTWlvNjE5Zkha?=
 =?utf-8?Q?v7r40ZLyXiM/Hrak=3D?=
X-Exchange-RoutingPolicyChecked: fIvxR1u6IHDA3wL33n7xPSgW5fcM7mpT7TtZ34hGlPa+o63c1ZWrdgr1ozPBnH8ngDa2jOkZjn+/256SKSh4qKtN26JSmNEt6E8m1ehdo0qv/rT6AqteDww+uKCgoHm372OzPWJMUu6mC5QAg7rqBe4t63587jRMDLC71RVcO+0frAfCqi4/gr8WjlGlbhvtc0vDo05mHS9G+snM7CXqSUFkn3CuK0ouRKuvCPqU9n1BmARKMLWm1zWfmnGmO6w4HjxH/APiMDnU0Fq5of0ttT26taJD2F5NbDi3b2toY0/Dbp1Pi2EScQdnmeVnf4+rlmc5q7o8/J3gjo/XwbNfwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd653da9-951b-4868-07ca-08deab783ccd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:03:23.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxPPMEKGT6ZXatLj9EhJpqUM/MAkS7LOJFWyYQpvCAzCGYPDX5ez2q3e8xc/0lto/fmB+jXe2VYapBfzD4DeLRVArTUoxlCAMP8SxV9zxGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A62164DBD78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284862-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl,huawei.com,vger.kernel.org,nebelreich.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Linus Walleij <linusw@kernel.org>
Date: Tue, 05 May 2026 23:52:17 +0200

> From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> 
> In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
> gmac_get_queue_page() returns NULL for the second page of a multi-page
> fragment, the driver logs an error and continues — but does not free the
> partially assembled skb that was being assembled via napi_build_skb() /
> napi_get_frags().
> 
> Free the in-progress partially assembled skb via napi_free_frags()
> and increase the number of dropped frames appropriately
> and assign the skb pointer NULL to make sure it is not lingering
> around, matching the pattern already used elsewhere in the driver.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Changes in v2:
> - Fix up the commit message so it is clear what the patch is doing.
> - Also increase the number of dropped frames as noted by Li Xiasong.
> - Link to v1: https://lore.kernel.org/r/20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org
> ---
>  drivers/net/ethernet/cortina/gemini.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks,
Olek

