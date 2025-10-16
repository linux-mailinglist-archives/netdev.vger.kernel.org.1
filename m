Return-Path: <netdev+bounces-230229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A0BE594F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BF87356B4A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267052E1EEC;
	Thu, 16 Oct 2025 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpr0eWWA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE5155326;
	Thu, 16 Oct 2025 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650682; cv=fail; b=GM3QVdznGJw0YpfF/7sH6oXjmWjXY7tSTru/9X6vh/CW73PcmTsz3tUqp+FXZSaOLKSZWDCeVcGAGe3eYlX8qjhyguYHfTxtLp8I/QoAYSwtJU5COGghuIG/PKdBxceS70SM+h8tXHts5zhxeO1BTz12WlBtlItkdp21khnoJX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650682; c=relaxed/simple;
	bh=dCy3eyiQO58TVdPu3fHypTaBVlAk1T0meV72hatE54w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LwBXGZsH/50k7U6A//XE42yelUhTraWUv2/ZqrEX8qu1J3FAgJJ3y/5PcJngd9U4RQimUZIaCmppxBNEPoh1+sJZx/Edb3rTumpH/LQilu9KI/vcnuXcp4I2Fz0KFR36kuuV3Mh08NoXvmYWJ/zv77RVKFNZivr8DHCff9a5Ubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpr0eWWA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760650680; x=1792186680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=dCy3eyiQO58TVdPu3fHypTaBVlAk1T0meV72hatE54w=;
  b=jpr0eWWADywklGZOWPKhBj+Q7NFt7kKPrxxO9mX2jviTq5sjkHy1MZYx
   p0splA9NSJLcWsY4BOixW3xBufm04U1i3zxNfCSJ7BxnteyKBx5HFGxuC
   l1jmg0I7Jg3Kx3I2FbojHiZjaIGDRsVlhi1E3otghU2dMQECkrg1k+d0C
   oHvhsgHE/0NDdSRRKl1HH3t9L48mDdBqkAEOWZjizCuJ2Sg34FP1ALHt3
   LPKy1cHsx5SftJENpsoq7vGTt8xaLwL6BgeZlGhRoePFCpsy7bhnVnWj7
   +Zv1lL2tetka+GjAZrbUnK6VzZYu8RKYIfbKnyTM7a237b9qTGWZQBOOO
   g==;
X-CSE-ConnectionGUID: 58r3DbgnQp2jfHO2vFM8qQ==
X-CSE-MsgGUID: ykznaYvfTJKRRSeIQ9yv+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62784975"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62784975"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:37:59 -0700
X-CSE-ConnectionGUID: 4MHGGWnMTQqexUl2BrMrQw==
X-CSE-MsgGUID: QlHf22rRSIyvRjrNEEMiHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="181703487"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:37:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:37:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 14:37:58 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 14:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFQls6MMLWHy7/1H4PTzIhVNxChKnXdWMeTYOPHqkHorPdREmWMhxbv6TeZvO1hN2Erijxuds6KoKbxViRRVJskAgJ1mB4VAAr2OquJhnkrVEU2nlnqIVnfyetZOu70Gt0b/EZ0tsguID5uW0Fcx9Gbe4fQoW5Sk3kOS+tARfrKXqUycpGq+LSnvodP7nw7UV6IirBRJtrFFGjCwVdihYsbEjP1b+IWKGyhnmgPE3ZazTElwwGPvYvtOOGbjHDXSSHpLc97O0jAP+yRvCIG+coydsZxPlN/jC45bTV5lb6RuM/cnreMi2Dsa1WTZJMSuxa4lnFKwXsZGVn75lFzD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5hZoOo9u6VRldvpYwJGJDM/jhchbQcNqpZEBkbtzis=;
 b=ZLMjjzmS/grvEICNRA7iLxNccxjM1+w+Ll/8iJIxjUjEi72F4j83LTKhQfhoBC2Wy+Smmi7RovM44XT4vuMAv0Lyowb6RIDdbjaJk25d+86qTzoElhF5dPy8LLKDfY8qvB513n0mVDPcNychCAVVleh51ueIaUIP0eESAlsupjgyK35+z6+hDzPncZs2QL7MmM1/hBtcoQ87axyu14MIQ6iAiNp8HLalDMsAqQIrB3NRUCAmu15o5kvZ/JOqAdYWSmscg0ehhDtBdZvJJZtd9W9F5yp7hax2GoCKZCrHvBsx/1jm9jQKBwlaj7W+yLCrKES0CgoAqMuvOQDfFdo4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:37:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 21:37:55 +0000
Message-ID: <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
Date: Thu, 16 Oct 2025 14:37:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
To: Simon Horman <horms@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Nowlin
	<dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Jie Wang
	<jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <aPFBazc43ZYNvrz7@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Yyk00JVwgMU0sGUVRQul01yA"
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: f373365f-4ea2-4505-2f8c-08de0cfc4482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlllQllJTUhmL0FrTVNhc0xiL2YxMHJOdUwvVEs1WnlpSVd4R2hFeHlPN1pi?=
 =?utf-8?B?U1hveXBIbWpHdlhyZXlqWk9mcFpZcGg0UTF1eGNRdWhYM293VFAyUXdvTDV0?=
 =?utf-8?B?aXQ0ZitzUG1LZmtKWnFwOFZ1NlppTXN0ZEdIVVg0UnJpMmUrUThHWWZJZStR?=
 =?utf-8?B?ZmpqYktxZUxDOXRxU1Q1a1NESGZhK2VJbHk1VVI4c0ZmaVVCamtybVQrL21C?=
 =?utf-8?B?NUhDb1EraWhKR2ZpTUpOM1RWUlNpZVFVRURqUGF1Z2pONktOVHMwNkY1UG1H?=
 =?utf-8?B?eXZzOUlBajB5TnNKQUJTd1I1SEV1TkVwdTRCVEw2aGtYNk96T1FoUmNaWDNU?=
 =?utf-8?B?Q2UwcWhieTZiNVRKclJKazFJclNTdEhvSUtJSnFQdjZxODJrNzRhMW1oREZy?=
 =?utf-8?B?Y0JyTVZocE9QWEJycDh0KzREdTZJQUdmcjdqK1J2OHhTTFArWlVrNGhTWjl1?=
 =?utf-8?B?OHdBbm4xQU1lSkc5cWVrdExMNm81dFhoYXdzYzJ2NWZyOXVaMWV4YWpGNlhF?=
 =?utf-8?B?ZmJOcVg4VVExN05Ic1BkTFdsVWRnUUkzQzcwam92eHRTNVRQR2t1TlpRVzhy?=
 =?utf-8?B?UkVpMnpmS0M5ZmJ3VFpadnpFMlpuRW1URG9RcWNmZzVkdGNCTTZvZTBKRWNl?=
 =?utf-8?B?cXVSQTdXWDdXaGtkUllrYVFkeXNRRVNDSmhuYTZVQlBVejV4S0gvVVdYcEtr?=
 =?utf-8?B?NFdtZjZoTHk3bUt4NW8rVUNPbnY2Z2lNVGx0VDlYN0tXVGg4MnV3dURLcDh1?=
 =?utf-8?B?UUkrQ0JYbWFWeUFKMEJ1cEV4MU1ZVDhtdy9HTkdLR0I2YUUzcXkrekg5Snpq?=
 =?utf-8?B?bnpNcE1PNEZYTmxmTllpQXdEQ2hjaGNIWnBhYjN2Wk9PWkIxalQ5QUFmbTdk?=
 =?utf-8?B?RjAvclpsSytmbEQ4ajB4MS9BZmxVeGpkM2V6aVhVWDFWckhQVVdTRlBPa3RI?=
 =?utf-8?B?eldCTysrdGlFLzRzUFhGZ3V3TjgvYlU2em84UHRCaFRIRFF5Q0dQVHErUHh4?=
 =?utf-8?B?QnppaTZxYTR2Kzd0eURqMllnTjMwMUQvbVlEaEZpWFhhbzBCV0JQMXBrbnV3?=
 =?utf-8?B?aXByd0l5dkVRYlJEV2hKaURtN0NTb2hSVTlqV2RvWHF6a3JiZEpqaFYyOW1F?=
 =?utf-8?B?ZmY5Si91MXdsODFNcVNjZXhHVWFISjV3RXB0WkZpbjh2S0tBVFB5OS9FS1gy?=
 =?utf-8?B?UlBLV1dVM1Bka01OK2tiWTdBSGJidFZDbVViWEdvNEZkVEo1cW1zN2lUK2Qz?=
 =?utf-8?B?SjlXTzY1Zm9kSUwxdmFBVHByVERJR21IMUFvNEVUZGUyRFU3WTZMeGs2Q3pK?=
 =?utf-8?B?WEphcVJ5QkV3QlF6eUlaUm1GN3RCVXR4ZDc1TVMyWHRrRE9NNTdpOURnVXEr?=
 =?utf-8?B?VG1oc015RkFCVlk2OVU2TUdEb3k0VEpmYVBYQzA1SDI4Q0s3aFJpQUs0UDYw?=
 =?utf-8?B?NER6UXI1YkdvOEZrV0hDaTcvc2xZajIzOW9Xcm9QTm01aUttQUE4R3lWU3VB?=
 =?utf-8?B?WDg3b2g3WHZhVFlNa1JOVkNjVG9zTEI3UzZWbEZKMGE2cEErNFB5aXZjNUFF?=
 =?utf-8?B?QjlCNlBWYkhINk5wUzRkVFhxSEx3dkRDWXZFQWhmSmRCRkJBaWpVV1gvRFVW?=
 =?utf-8?B?Rkp1SzZjYVMvdjN0bGZFZ3AvMUpNblZGRGYveVNOeHVvdTVYYVNNaHlSSkxi?=
 =?utf-8?B?TjgrZ1F3RUpGaTdiYk9heUIxNkF0SDBoaFk2ZDVTQUxCSlYwa1RraDJzbE1x?=
 =?utf-8?B?bEJoSFZIbDMxYUt5d28zblJLT0NNODRzajQ4aUpCRW9EMTl1Mzd5TGJoWnEr?=
 =?utf-8?B?Mys0aVg1VklpVnZLMzF1V2p0T01yNTNzOWhyTnpQUm1JYWpBNUxzK0ZyeDYy?=
 =?utf-8?B?WXg3Y3BJKy9IeXJsL0R1ZXFId3cxdXFWdlNWdHdVL2VJcGs1WDd2TXNxNDNa?=
 =?utf-8?B?ZGYwSmxJOXVPS0QzWkVrRFNoWkdQaUQ2SGtmL1c2d0l5TXJTV1JLY2lHL3RJ?=
 =?utf-8?B?Qi9lMFlyQWtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RIeWdSdzdDVG9wdGVHeWJVYWJXR2Z0SzFSVFFpakJZZWRaUlIzWGQzUGhp?=
 =?utf-8?B?UFpjTVBoVFl1WWJ0UmxFQVRhanFZVURRckdtUXM0UUcyMGtha1I3S0RWQWFz?=
 =?utf-8?B?U0tvMTU4TFU0WVorVitkOWVUSGd0RTN1MWlkR0R1L0RpV2wvUkpydklEL0V5?=
 =?utf-8?B?dVV0K25sazdYUTZGRW1SaVNXcXBnYTdiTHhKcnpzN1pjRE1ENzgwL2xrcFZz?=
 =?utf-8?B?Rmx3dXdMajN2YkRhcG0wRnhkVDNkVDF0WU90WW5XcnJwU2VuWFFWWWtTeCs5?=
 =?utf-8?B?NUJVMlJQS3M2ZUVkYVBTRDY5MkM3WWl2OWp6UllBeS82TlpuVnpBc3ZaYlRh?=
 =?utf-8?B?bGVPVmtVbjVIVVJjc280ME5XQUNZdHVUU0ZKUExPUnJoazFlRzlJTWpnUEZl?=
 =?utf-8?B?Mmx0RDFsNUl6eEtjbTlJUGFxcDY4TkdHYWI4RXM1NGRTMkdhRnlPQkFlRGNT?=
 =?utf-8?B?RGQvNGxNa2F3SmNvamxTN0N6TXE1R1pPeGRvdkRLeS80RzlwWUFOWnVsTzhh?=
 =?utf-8?B?RlI4TWcyRFduaUZDQlN2Q0lPb2xQSHdIZndhMTJxaFl3QldFMjN2MzIzaVFL?=
 =?utf-8?B?UjkwdTRXVnBGZmZkdG1MWmE4Z1p3d2NER1hjQTRmbTJZUjFzS3l0c2QzeDJH?=
 =?utf-8?B?VjV0Zk82RXF2T1dZNm1uelV1R3FsTmIwbFNCaUsySmFxTnZlczR0c011MWg2?=
 =?utf-8?B?MUYxUy9pUks5bVJUdm5MOTM1V01zTjRrKzlpZ2dLbkZ1N0ZMM1VJZkJzdEJ5?=
 =?utf-8?B?RmNmaitVT0dtQk1ZLzd0OGZRNFFyclFUTFRQSXFyL0sxWkszZCt6Q25mK2NY?=
 =?utf-8?B?VUd3M1NaUUNHUlV4dFhPcWZZc0RmaEI5S2ZzSXBNeEJOd2xoeTFLWkFJUUVZ?=
 =?utf-8?B?dGg2YWNvU2FvNXdFL3V3N3RYYXNYMUVLSWtoMXByYmZXeUdTVDhNREYydFV3?=
 =?utf-8?B?ckQ4VGlTVXhFczQ0WHMrSEhIcllUTGs4TkdtYWpRbEdWZDMwZTBMa1hrN2t5?=
 =?utf-8?B?Q2NRLzZYa2ZXdDZJbmhob1pBYkVxeWxoTkpqeE5WM203U2xQMGNVaWd2a3JH?=
 =?utf-8?B?b01hREg3dFo3ZlpDdWRJVnFwdlhVTlBxdTRmM28yaTA0VjIwcVBFSGpJUmp3?=
 =?utf-8?B?SEFkYmt1MStrTmhXRVNKWThXNkpSWFM2aFI3TmthVlZBcWg0TlhXbW5KUkJz?=
 =?utf-8?B?YVlQRkhUSnZGNmtUaXNPdWZtRkZOSVVrSXlZVmNhejJ3NnJMTHcvU3laTEtR?=
 =?utf-8?B?OXFUUDNPYmlLY1d6dmExTWs5d3I5b3pnZHRPaExlT25wYmJRNG8xVlhCUkdC?=
 =?utf-8?B?UEQ0RFpIdlA2c1NtWFdOMjNOWmFkazdlekhkYlNML3Z5OG40WFJTcFJDUGto?=
 =?utf-8?B?NmswOHd6YUM2bFRaa1cyOHBFMHBMZ1E2WEt6YW5mK3k1MjJ2SG15Y2JDT2R5?=
 =?utf-8?B?WTJxZzBhZUk4UFgxTHNSYWRjVTU2REVuL0owR0hzM2EzVEkyS09ONjRzcWc3?=
 =?utf-8?B?S3ZWY2JhMFBhZ1VqN0NHUithWVpiM0ZoWXpTVlQ5cFArWjdjZ3A4aHk1RmxD?=
 =?utf-8?B?S2Vab0l3Nm12SitKSFdQT3hsMGZqdHp1WVBSMk1xa0ZzSG5kREJmQlZ2YUxH?=
 =?utf-8?B?YmZSVW16aXA4RjYrRTZlL2I1b3hUSDBXMUtqY2JVUlB0TWExanpyK3NLVXVP?=
 =?utf-8?B?SWo1NkRyOG1ncnNVbG5LdVhSV3JxM1RDeVhHek1RMVhLRXlJdWg3U0dlVDYz?=
 =?utf-8?B?bWVqR1pjZ1hVUWdXODdtMVgwdU1tSzRJbGxUOC9WSEtSVmp3ZmVnd0lYekJB?=
 =?utf-8?B?dCtzQkpwSWE3bDFGcWFxYTIxQnNQSDc4bUM3VUxmenNHbnJveEwxU1l4aWxM?=
 =?utf-8?B?bVlwdTlxdmF0cGdpM0FnWitVM3NNNEZHbmgwSENsN05NMUd6cFpia0V5RTBW?=
 =?utf-8?B?THFSZ0FocFJoY2d0UVp6SXgrRmlqTXlCTUNHaUlQK0tJU1RpMXdzMEJQMEZH?=
 =?utf-8?B?MlhHTm9PcStKcHAxSW1zY2xGbkJRdi9PNWk5elIzU1B0amk5MHlLbXJ6SnZl?=
 =?utf-8?B?cVRjTTB4QWhhemhENFZFajhQa3VxK21NdlYzMk96MGljWjBBcEhrQXNCU0hp?=
 =?utf-8?B?ZUVUM1BNalV3WVJUQzk1cnJQall2MXROTmEyeVpaSUJwQldOREJSSks4cVBK?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f373365f-4ea2-4505-2f8c-08de0cfc4482
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:37:55.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qii6Da0XJ9GaNcgTXXZXIri+2OPg57ExO9TyON1EB1s+LyekYM0udo0RbVWms/lGnr6LdZuiepw0j5w9CbuoIe8P+xnBksTMyBauAFHvPzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

--------------Yyk00JVwgMU0sGUVRQul01yA
Content-Type: multipart/mixed; boundary="------------K45Ft88050HuHrVjBMedHsUK";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Jie Wang <jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Message-ID: <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
 <aPFBazc43ZYNvrz7@horms.kernel.org>
In-Reply-To: <aPFBazc43ZYNvrz7@horms.kernel.org>

--------------K45Ft88050HuHrVjBMedHsUK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 12:03 PM, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 10:20:25AM -0700, Jacob Keller wrote:
>>
>>
>> On 10/16/2025 5:21 AM, Simon Horman wrote:
>>> On Wed, Oct 15, 2025 at 12:32:02PM -0700, Jacob Keller wrote:
>>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>>
>>>> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
>>>> across multiple flow types in the Intel ICE driver to support GTP
>>>> (GPRS Tunneling Protocol) encapsulated traffic.
>>>>
>>>> Enable improved Receive Side Scaling (RSS) configuration for both us=
er
>>>> and control plane GTP flows.
>>>>
>>>> Cover a wide range of protocol and encapsulation scenarios, includin=
g:
>>>>  - MAC OFOS and IL
>>>>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>>>>  - TCP, SCTP, ICMP
>>>>  - GRE OF
>>>>  - GTPC (control plane)
>>>>
>>>> Expand the PTYPE bitmap entries to improve classification and
>>>> distribution of GTP traffic across multiple queues, enhancing
>>>> performance and scalability in mobile network environments.
>>>>
>>>> --
>>>
>>> Hi Jacob,
>>>
>>> Perhaps surprisingly, git truncates the commit message at
>>> the ('--') line above. So, importantly, the tags below are absent.
>>>
>>
>> Its somewhat surprising, since I thought you had to use '---' for that=
=2E
>> Regardless, this shouldn't be in the commit message at all.
>>> Also, the two lines below seem out of place.
>>>
>>>>  ice_flow.c |   54 +++++++++++++++++++++++++++----------------------=
-----
>>>>  1 file changed, 26 insertions(+), 26 deletions(-)
>>>>
>>
>> Yep these shouldn't have been here at all. I checked, and for some
>> reason it was included in the original message id of the patch. b4
>> happily picked it up when using b4 shazam.
>>
>> See:
>> https://lore.kernel.org/intel-wired-lan/20250915133928.3308335-5-aleks=
andr.loktionov@intel.com/
>>
>> I am not sure if this is the fault of b4, though it has different
>> behavior than other git tooling here.
>=20
> TBH, I am also surprised that git truncates at '--'. I also thought
> '---'. And as this is the second time it's come up recently,
> while I don't recall seeing it before, perhaps due to some tooling chan=
ge
> somewhere: e.g. interaction between git and b4.
>=20

Hm. Looking into this more, since I wanted to figure out how *I* got
those in my commit.

I checked the original message posted to Intel Wired LAN, and the
contents are there.

Git says:

>        The patch is expected to be inline, directly following the messa=
ge. Any line that is of the form:
>=20
>        =E2=80=A2   three-dashes and end-of-line, or
>=20
>        =E2=80=A2   a line that begins with "diff -", or
>=20
>        =E2=80=A2   a line that begins with "Index: "
>=20
>        is taken as the beginning of a patch, and the commit log message=
 is terminated before the first occurrence of such a line.

This is only 2 dashes, so it shouldn't trigger the 3-dash rule. Indeed,
if I use b4 shazam, I get these lines in the commit message. (That
explains how it ended up on my tree when I submitted).

If I use git format-patch on this commit, I get the lines in the file.
If I then use git am to apply the formatted patch file, I indeed still
keep these lines in the commit message.

What version of git are you using? I'm using git v2.51.0 Perhaps this
isn't a b4 or git issue but some other tooling that is causing an issue
(patchwork?).

At least on my system I do actually preserve the lines below '--', and
it is not until '---' which it will start stripping data.
>> I fixed this on my end, and can resubmit after the 24hr period if need=
ed.
>=20
> FWIIW, I'd lean towards reposting after 24h if you don't hear from one =
of
> the maintainers.
>=20
>=20

Obviously, we shouldn't need these lines in the commit message, so I
will still send a v2 and drop the cruft.

--------------K45Ft88050HuHrVjBMedHsUK--

--------------Yyk00JVwgMU0sGUVRQul01yA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPFlsgUDAAAAAAAKCRBqll0+bw8o6B2u
AQC6O0SDuMeD68o6KLk9xLYz/VD946qno7ehGZgFn4WapwD/bedF3hkOYEPS4d4EWbKe4ecnX9WW
gvf4qiDIMlojZQc=
=AKvN
-----END PGP SIGNATURE-----

--------------Yyk00JVwgMU0sGUVRQul01yA--

