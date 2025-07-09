Return-Path: <netdev+bounces-205566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DEAFF4C3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87975884A8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21D2417EE;
	Wed,  9 Jul 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fcwhd2a8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152324169E;
	Wed,  9 Jul 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100534; cv=fail; b=TIw2Xv8WomSgoXAUCY6V2xQ5X9B9zgT6toGltf/RbbiyR5wCf2t03z2ayJWfUgstBIV3+fy7oRPeBipPzWj/kxp54d95LE+RL50zU5TkrvF3Jq7TD6bg5kxQIe1ymbaBOAVcELTnG7RihoTGArqqIjQRsU7+uTm7MajAEqnK7v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100534; c=relaxed/simple;
	bh=xD7neJ3hvKVkN4f2wVmRlB3lkd73UGB/INBl8C4CcpA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LjWM11etVvCJUSZj+6e2wFYJrMU7wxed2EbJAN/cQK2bjyNlV6N4pAeyiyXvaUQn16zGBN2HU9XhrXEJNrRdEMkF4+wxaDIQQiGG25ItapezewFTI0qnFnr/soO94SjPEZ8Msb9dj8PE3uQqqVEmLrOPqXKs/YjTUp63Rl25YuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fcwhd2a8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752100533; x=1783636533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=xD7neJ3hvKVkN4f2wVmRlB3lkd73UGB/INBl8C4CcpA=;
  b=Fcwhd2a8zb5xqibigg/grY4Q3jlX0dpeGH1MgkQ1OeWvqVMM8t1QUU5k
   mx9bz9F/GxB43CL4VHVDrwqInKN2rlOWMZZJjP8yhplUt7puuHZg/I3d9
   BTqT7Igt2e5AGZA32cfYZhv1s0Hd5ifT95nZtaROmjBI1Jn4Pd4YdlER/
   WdDFLJ6bN4ml3kt7pYjzpzYGpt8Ly5HVGR51DakjXljHCZdSRXIc5MsnZ
   DeXueuIA4VwV4oPJSBCtAy5wnWvE7OzzJBFZLDI7zWutIefw8UXAV+ct9
   Y7nxkjf1aClnpZF+rrTaqYg7hiQqBI7rXxeQTPdnR/lDmdqpEwsb8tiM2
   w==;
X-CSE-ConnectionGUID: IggUIIGJRNudn96HwxQapw==
X-CSE-MsgGUID: yc7dNlrjRAu+Wp50LUUGhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64630725"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="64630725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 15:35:33 -0700
X-CSE-ConnectionGUID: GITwxBqbRKOX7pWZxp0PdQ==
X-CSE-MsgGUID: ES2m1FF+RYWsrKSu3yYH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="asc'?scan'208";a="161554291"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 15:35:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 15:35:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 15:35:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 15:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfMHwZfRV3OVmB9v4ceaoT6YV3TFLdy6MNY9pN0ABXObIQQSAO4tHWIY21yAZaN9SvNw9n2qLnAwTP0Q5BLLJSWGuPb/ya/9y0yMFbyw4z0uflA5fbRKXoEo+4HPJNr44ih6o0EHjfTMvFXtLC7Yt3YqqANOPQhh1DB1Jup7F9sJgfrZzxw3vbOR38nmKF87FiKNporVGI9M+3jzPObviDycqkgg2YJfstxtD6D0Orvygv/8VIcj/6T/nfyqZCqVZ2FrbJUMVT8KgcovYhD/6nfavptAxEOLqPd+3S91cQQVVMJ7TZudIGolP4vm+ZV3p0XYrroicISl4bSwjAb8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5z+lKNSfZSxOA5X/AtXB0F0u8lLvUGMhMklYRJh02I=;
 b=MhRWCs8YmrlplyObrcoSC3N5ssHZ4HzcyYV90B5la1WgfJiQxnoDHe+sXQpYO55LoDjnFb5OF3bpO1caFqtTDgZH8Y8c9FO2ysIAhFD7OMXcHaPj7KkC2SILhr6/8aOmcqMuEgFhnta6ZufKFFL8OG87V7mBpsfn6FMMQhqQuuA2G/q6TkbilS2mPRPuPmALO5NRmTYLdoS6IeGIpIKRWLiSC9o/tl7Oj33+lgX7F0geo7e+oe8AWC9zpkQQHHiPqZ/+bTqGZSkoA8rHBzMo6tfxirxtnpjT2mMlSoHPOjuh3uF/uQYc4hLoC3jPhmYYoNtpxTQyWQ8r1uZMVfOgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 22:35:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 22:35:27 +0000
Message-ID: <e6152ac2-47b2-4ddc-8adc-bc4279c21d40@intel.com>
Date: Wed, 9 Jul 2025 15:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: thunderx: avoid direct MTU assignment after
 WRITE_ONCE()
To: Alok Tiwari <alok.a.tiwari@oracle.com>, <sgoutham@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <darren.kenny@oracle.com>,
	<linux-kernel@vger.kernel.org>
References: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
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
In-Reply-To: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------x0o65s397z3d6TzzlCA22UGl"
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: b90b8cde-2dbc-4822-2841-08ddbf38e73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXVFK2RvMjJrSzRsQ01CbTZzUWUzNkpHV3dVd3BYRjhybHhWUEVtZVk1bnd2?=
 =?utf-8?B?R2h3OEhxQ1RYVDg5VFFqQzNFYkFETjIrZUl1cmphTWxJWkVsTmdQT2lrUk91?=
 =?utf-8?B?QUMzZEhXSHJtZzdJbGM4eWcyM2JnY2ZtQjF6S2JkSUtQV0hxOHIwaUxzQkwz?=
 =?utf-8?B?M0E0dDVJd3hUbWJmekQ0dVBjYUU5ZFN1bDJjcEgySTczeVVmWXR2WHJIZTRo?=
 =?utf-8?B?aHZ2WXJHanZMSlZ3MnVVdFpnUmFTUUI1Q050R0k3S0U3UUZKN2pIMzV4LzV6?=
 =?utf-8?B?MkIvcVlFOUErOCtRSGhhdW5kaVMvalVKMm14a0xqMldiWm4zdFQ5WXU4Um5m?=
 =?utf-8?B?a0pxRnNBZjJrOEx3M3h6a3NmVGRrUGh4Yy9ESG90NUFaVThUVUVRRDVmRkxH?=
 =?utf-8?B?cWhHN2lrN0NhVzlwckNZREwwTHZ3ek14MTl4bTE2WFh3VUFjTnRaV2JrNGJC?=
 =?utf-8?B?eDdFY0xwUTI3YlRIb2hCQ1VsaU9rUS9hcEpiSlVmYWovL2Y5WHdWakNNbFNi?=
 =?utf-8?B?eDdZeUg3YVBZSmRFU0Vnd3BUd0R4WTNRalFNMlVnUDVTWC9YblNWMTN0OXpz?=
 =?utf-8?B?M1FrQ0JOc2VwQ2pmSGFBUzBlaXR1Y2NXTVpJUnkvc3lZd1ZjOXlrWVBoczh2?=
 =?utf-8?B?bFhTNEY5ZEwvbzRUUFdkL3hMUzlKcisrdWlhY0tTNnFqWkh6VjlwWGRkN0xW?=
 =?utf-8?B?YlVjQTJNL0NMRVlNSVVoZVFYNHVDaGNPNlJ0ZTBYNzFvN0Z2N0xoRGNtU3VV?=
 =?utf-8?B?VUNkZjBIUkxhZVBvaHorck9uSkRzTjI0Q3JJZGlORW5FMjV1clZReVNXL2c4?=
 =?utf-8?B?WjRCUURtZXhsc0F5TTFBYXB5SVVabDgyU2c2VnpVM0oxNXNoUXdoUEoreElz?=
 =?utf-8?B?bVY2U09VbldGdkg2YkxXY1hodHdSYjNZc2hUZk45VlIvcG9BK01NRHdsVFlz?=
 =?utf-8?B?KzBTV3B4RUJROU1TZVRPSEtZQnU4WUsvVWVOaXlCUlZpNGg3ZnFrK25rRWxz?=
 =?utf-8?B?NW5veStWdTNzTUJnMjNtU0UvOVVLKzgyK1BMNmtIem42cHI4NXR2Rmk4d0JV?=
 =?utf-8?B?TjNnclZ3eWQ2UHBFUlBaaGw2T3NQQTNkUzVDZlE2aStyZGJtR3ZQbGlRVnpi?=
 =?utf-8?B?V0NiT0NyZGcwN0FCeSsrYTNMbEM3cW9qdEhmMU1LSUJpMjBaSnI5WVlkU21l?=
 =?utf-8?B?Q1VCZXp5eDUvYjlCU2hGaVpKRjljcGx4Z2pZVzNzalhmeDJGWFZjbkZxbEhv?=
 =?utf-8?B?MTR4Vm93ckQzdjRKNUM5cHJ4M1JGa1NiRGE4RkxtVTZMVEFRSHJtRTF6Z01n?=
 =?utf-8?B?aGJoOWpYd0IyUi9hNzVWM3B4SmxDc3JNZHFmK3JrNU1sVzdDUkc3S2JNVlQw?=
 =?utf-8?B?bmFkcFNYcERraXBrOHlVN25kUlVoUUJsU0IzaGVqa2k0QkZ5dk1UNEhLeXU2?=
 =?utf-8?B?VHVMZXZyWFhaU3FyWXdzaGtPdnJiZ3IvenZIb2I0OHVHN1kySjFHNFh6cURZ?=
 =?utf-8?B?dlRvTTYwai9SRC85TEdtT2R0T2RiMWVDOGt4S1BXT25ibit6LzQ2R1RoUDZa?=
 =?utf-8?B?azE2dUF2STBxWXo5aFB6dk5tU0Y4MVU4U3BwempISGV6QTdCU0RCVW15U1ZG?=
 =?utf-8?B?QXhKT3NSUFg2aUdjYThnaXlSbjhjak9RSWRUdWxINGJoTzAvNVZiNVlvOGR0?=
 =?utf-8?B?U0QyQ0YrVXdlbHlsR25mTTUzS28zckZhVDY5Mi9JWEtPc3EyNDhDRXpudVEx?=
 =?utf-8?B?WE0vMXdWYW1FbEpidzkrY2I2N2hnVVVOcmU4THRVbmJoajFLT1V1MXA3UjY3?=
 =?utf-8?B?YUROUU95cWFoVHR2c2xCcTNLNENKL3EyVi9UUTNIVWkxRnZxV0xwZGhCai9E?=
 =?utf-8?B?eXJsbEFHdHZtZy8wWm1DK25RdWliS29uVjZkY2xEaUVpZzZPc0xWb3lxVkUw?=
 =?utf-8?Q?9gJKbFtYzIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJVK21NS1k1UTZ4OG9RNUNqR01GeUIrMWtYQzNud28wRGcyeEdjMUYvNTVk?=
 =?utf-8?B?bXJ0bVlodFIvTVF3L2Jrdm4yTkkrOGZLcklxZ1U2bi9JdnV1NnBjSjBkN3Z6?=
 =?utf-8?B?NVMxajdKSFBuWEtkY0I3VytTcnAwUUhtblVBM0JRRHJ0QjlmTU16RHk0RlBG?=
 =?utf-8?B?NFN1Qk50Tjluc2IxSDYvWTJVL1U1bjR1YkhTUmZVZXRiaC8ydFpDV2pDckhp?=
 =?utf-8?B?aU9iNlVMeWJ1Z0JaUzk0ZTUreVVyK3JYRVdJK1RLY3RHeTBFSm5QaWo4NlNp?=
 =?utf-8?B?dy9BSmNwWGhBV01WQXVnMk5iNEtMZ1lMTTk4QXpqODhRL1ZSZ2ZpZ0pEYU9J?=
 =?utf-8?B?a1dGN1dvNi9CWVZXWUNUdkhwcHdWNHVlSW9mRWUyN0Y3WWswbmpSQVlza1Zp?=
 =?utf-8?B?Y0dLK095MEQ1RTg3OFIzcHlZOVVIZUN1Um5zTjdDZDA1YjM1Zm41bnNveHB2?=
 =?utf-8?B?d3kwK3pLR3l3eVk2RGc5dXlSSkVVbndJMHh5a3dPNnJacXNJL0Uwd0hVSGFh?=
 =?utf-8?B?QVBJcGZMOHRYU1NBZXJkRWFOcHJCVkZaVzUzQm40WUl5Wml1bWhoTEUzR2lp?=
 =?utf-8?B?dW13L3FoNU9xQmlZdy9xcUF5aDNQMUpiTmtmN2czVHhzVDVvOEk2MS9LVWJ6?=
 =?utf-8?B?YmswTXllWGE2eVRwMm5zemNoVnFUSUN0VzlIb2RJUkF0S3g4cjJxTFNUY0M5?=
 =?utf-8?B?RnZHSzI0eHU5cldEbys1RXVNVFZhNUNaRkdKZFo4eUtnd09WWUIrOEUvMHBI?=
 =?utf-8?B?Q2VzSEFOQkFyY1NoOExuMHU0MFc2UWVVOE5qRXJVUDdZUzh3RGtnbEhTQ01R?=
 =?utf-8?B?S0t6UTdqTHVEODFaRHhjQ0dheTFHUkIyQnBEQ2xXVjcyM25ObEtCalRLMjlh?=
 =?utf-8?B?ZlphdGhGd3FWU1NCVmM1aW9YYjhoRFErQzFhcUpNTjJYTWxjWnFqak1BUi9V?=
 =?utf-8?B?czJTNUt1bUhuREFML21FV0ZoVy90MFBhbVRqU2hYN25sbWZ5Z3RzajRCTmFO?=
 =?utf-8?B?Ri9neFEzd2x3bUkyamxtL1VoQjB3YlNidWtLSDRwWkxtWWVnNExVZ01oVVYv?=
 =?utf-8?B?NFVqM29VbVVWOXl4UnRpN0xlSzF0WWVISXFDTDBOTERPQzBVK3Y1SmpkZnF3?=
 =?utf-8?B?clVWV1pFMXc0dWdKZUZQWnZyNkM1M0RBQ214ZExyRVR2SDZRZHRjckxxSmlo?=
 =?utf-8?B?KzVuUURBU3NVdXAxa214MGxLOUlOck1NNWFOR1NsQWZuZVR4R0NDbVplNEJB?=
 =?utf-8?B?MkE2bWp1UFBEcjFURXFiWmxhcVZCd1BpclR2cHVhRHBtQ3JraXZMbjJvQXdE?=
 =?utf-8?B?b3c3dW54WXdOSlRiTWZubTZkR3lFUnJ3WDJsbENqWUc0cTVaMFkzd0tvRlNI?=
 =?utf-8?B?eVRScHFGalFOYTcyZVRCektObkZYcC8yUHdqeVowaDhOM2xxZUZWZDZVOFNN?=
 =?utf-8?B?UzlYODlzM3g2RW5ZYnF4S3RBNkl3NkVBV2ZOWFp5bldyOTh6eGRnc0VnV2x0?=
 =?utf-8?B?OHZxMHVyRVAzMnhxbGQwSmlYeHNMTnBJZENHTTF1c3huUnNjSzgzMkZvWHAw?=
 =?utf-8?B?TURNalhOVlRaYzlvZ3NDcURDaUlZU2ZZcm5rUGlwOW1LNGNucndjaFhZeXVS?=
 =?utf-8?B?L2pXUlhzbzFzd3JXaWxLN1hJZE42MitHU2R4ZENFNkcwajZtaWg2YlFKZEN1?=
 =?utf-8?B?WTFUMGozdEhuMWw4N2Q1MThWMkFZN2ErcjNES2ZOUU9WRXVwK2ora0lwODdv?=
 =?utf-8?B?Nk1DSzBxYUQ2RGlsR2FnY0VuS0REL3dRVWlSaGJ4c28rQ25hNVVSL0JyRStK?=
 =?utf-8?B?UDhoZTNLdTcrNHBTL1BlNWh3UDZKOHo0TWQxbU1IU2EzYVFmL1llVkw3SlVo?=
 =?utf-8?B?cWxVRVMwU3MwWnpyWllFZ09GT29wdXNUNmZHSE5neGhraEpvUXJnZUQydUV2?=
 =?utf-8?B?Y2J4TjlhNEUzdUQ3MW9zZmdDcUtackNsS1NqcElWOUFmdW0zRUJqYWhubEdV?=
 =?utf-8?B?dWprRG1yLzN6am15QUtNc292R3ZmT0N4Z1RIMEErbUdFeFdWY0lYOEp1OWRJ?=
 =?utf-8?B?a3g4M1FKS3lFd1U0dG40MTVZUnRtdTlxMXdiR2xwQkhvbzBtUzBPMG9HZDFX?=
 =?utf-8?B?L3ZJd0hHdC9vZzRLVnU3R3lvZ3M0ZjdVZWkwT0RYL2tDV1JaT0lGc0Z3dURC?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b8cde-2dbc-4822-2841-08ddbf38e73a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 22:35:27.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJf1dVmzCybbmbXJLQX9WGynsQCOuRWrn+A9IPN04vumGTJBYussEEaHEAoOEIF7fjHZE6iVYu0mu8QcWoIn79+d2Uz46Pr4K30qZ+i3fNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

--------------x0o65s397z3d6TzzlCA22UGl
Content-Type: multipart/mixed; boundary="------------UB4zrK79d36rzZ7UC2s8zMpl";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, darren.kenny@oracle.com,
 linux-kernel@vger.kernel.org
Message-ID: <e6152ac2-47b2-4ddc-8adc-bc4279c21d40@intel.com>
Subject: Re: [PATCH net v3] net: thunderx: avoid direct MTU assignment after
 WRITE_ONCE()
References: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>

--------------UB4zrK79d36rzZ7UC2s8zMpl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/6/2025 12:43 PM, Alok Tiwari wrote:
> The current logic in nicvf_change_mtu() writes the new MTU to
> netdev->mtu using WRITE_ONCE() before verifying if the hardware
> update succeeds. However on hardware update failure, it attempts
> to revert to the original MTU using a direct assignment
> (netdev->mtu =3D orig_mtu)
> which violates the intended of WRITE_ONCE protection introduced in
> commit 1eb2cded45b3 ("net: annotate writes on dev->mtu from
> ndo_change_mtu()")
>=20
> Additionally, WRITE_ONCE(netdev->mtu, new_mtu) is unnecessarily
> performed even when the device is not running.
>=20
> Fix this by:
>   Only writing netdev->mtu after successfully updating the hardware.
>   Skipping hardware update when the device is down, and setting MTU
>   directly. Remove unused variable orig_mtu.
>=20
> This ensures that all writes to netdev->mtu are consistent with
> WRITE_ONCE expectations and avoids unintended state corruption
> on failure paths.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------UB4zrK79d36rzZ7UC2s8zMpl--

--------------x0o65s397z3d6TzzlCA22UGl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG7urgUDAAAAAAAKCRBqll0+bw8o6DfX
AP9F2niFg1UKkE0Kisg6yWfHZT9XWhQykXdcOApfqpbEUAD9E0ULLoE4kSTx/RmXIOJmLMN+bo8S
3yZt04uFLBC5jgM=
=5NXy
-----END PGP SIGNATURE-----

--------------x0o65s397z3d6TzzlCA22UGl--

