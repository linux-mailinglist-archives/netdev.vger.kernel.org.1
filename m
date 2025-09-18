Return-Path: <netdev+bounces-224623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69247B87364
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868637B4C47
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D42FCBF1;
	Thu, 18 Sep 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPmj9jfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB92E0937;
	Thu, 18 Sep 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233589; cv=fail; b=TIl/ehBH9SXke7BqsmixZ7ys9eSplQ4duhaks9TWquajxoBlip3x1D3kC3XSLwkvP389b9Cp3lU/VP+plieZCqr+mEuGPqPfMTwW0nuA3QSqL5+C/ZQMexf4vhBDqeeJBBZVokNpVhJ6JGLYIqBJJDG66LPorq83R8YIW6qHYIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233589; c=relaxed/simple;
	bh=mAD5nSP5KE7MjPqd/WoFSkYD7SXECNx+M2ITpzcpU9U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HnjOt7NwQGpaDaSVsJquJ58H1dp/UD3FUpr8JqH6fBih0E3xbOYXkcZXq0Fus59iUOW2bDYbjTJOobUCs5Oiv06T3g5likoB0AEIZb5iJ4IMRzmy4RuhmsJcKh3yfqibBTz0P0l33rV0Mkgi7qexZiPYFaVAOl9Ps09oTqthk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPmj9jfZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758233587; x=1789769587;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=mAD5nSP5KE7MjPqd/WoFSkYD7SXECNx+M2ITpzcpU9U=;
  b=cPmj9jfZcCr5Tx+cmxefdQfSCxEojRDwEDcCt095TZPN346wmQ/SquIE
   dxCIqZMlFowDvPNA3HGZnWpUlFuIi07WrHnqXcQynx5VfOjU0VeNC/h6T
   hPbjOJ0vIIG4L30HwzguXMoajmYAaTCyutEpCxfyIObh7jtuQfabWYR1e
   jNi+gbq6FzV8FlpmT00NSU/D4eXc5YTdD4fbWuco6DqrxgmSrOtFItDD1
   Kw3WoZ+XpQwWYwDMmhClQ+tC7uhRC2vL0mUO36Lv06LcCkOnMhYiEXKaY
   yp/+S4y9MsZKg3aFeVZcEPCGBLTkk/kMcghme3AEfGU1jrr0vpAbM0hOt
   Q==;
X-CSE-ConnectionGUID: 8EAC/4+nSZK+4WkjfFpWvQ==
X-CSE-MsgGUID: 3Hv10lKtSkiPz7AagZUIWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60526448"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="60526448"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:13:07 -0700
X-CSE-ConnectionGUID: zaeD3diiSBCVKDJvWjpdQw==
X-CSE-MsgGUID: HWmhjjApQM2/LT1A8hyHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="asc'?scan'208";a="180952578"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:13:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 15:13:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 15:13:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 15:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI6jqhW03/LSMwyko9d7mKeOm2U98x/uo3vrCsYVyy0M1djIwB7S51uUjyjGBZjpq8ZWzZ9Bc/IBMwQPyWxfjVrCVEGNw9GlE3lgVHp3M9AIO87XYowaHdgH0Nip3QK1GNyFKDsYJ/QiQwI8ZGienF9eLjlTmC44pN4yqCf7EX/pPzOEqlHcOzgA0aEqTpQ6bp4SublCz8Z4afuSKHfu4y657XYd+6vd5bxokyeexvXT38jsKGutG5eFJNGmYLqOLV5+JF5hjrxvcisVVnDyszEykbTpxEOd3zTXXfTikhHLCttwO/KAtzFDzzS6i70PIOzriLC2iA3W6D66tZuKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAD5nSP5KE7MjPqd/WoFSkYD7SXECNx+M2ITpzcpU9U=;
 b=XL3ZsE0a1VEM1X2DLbvCcU46ugsCn9wbKh2Wy3a/h6PPpfVC8E4evYf5jftGiTMoVxyBvluQA5dAQyR7EJBpDClwvpC0hCjWu6wslN4xQDdzOhKzR4W/NKEmZOqBXm49bcRCPhwQv0yRedw1NmA52zhcf2+Ait/cI2z89t8a4Crl8umh9FF185RJKnvRRPMdK54Bogn9c0MNpmuDlZF3yeYK4y6LoriCtDB4dqP6MjOOiQKmf23hzMaxU/dMsI575PVCGduZdmqQv0Lh5WXGysTMK5CzFhxaZ4uxOrZ0OfJFzC1u/glcYbATFlOHpEpLkpJe88kn9XwohqCUbpyM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS4PPF409BB8CE8.namprd11.prod.outlook.com (2603:10b6:f:fc02::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 22:13:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 22:13:03 +0000
Message-ID: <212c7008-0053-432e-8bcc-c0b94b111a78@intel.com>
Date: Thu, 18 Sep 2025 15:13:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/5] net: docs: add missing
 features that can have stats
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Jesse Brandeburg <jbrandeburg@cloudflare.com>, Jakub Kicinski
	<kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, Simon Horman
	<horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-doc@vger.kernel.org>,
	<corbet@lwn.net>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-1-ec198614c738@intel.com>
 <f80effb4-0c91-416f-a7cb-4c9a7055fa13@molgen.mpg.de>
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
In-Reply-To: <f80effb4-0c91-416f-a7cb-4c9a7055fa13@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------xKy2cisfNPg1IK22tuL5Q1bx"
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS4PPF409BB8CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4649c706-d20f-4367-c946-08ddf700893d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWxmODRXM1dUbHg3VGl1R0VNL3ZRQklMbis3R2RNZ1lsOXhGTXNGbDR4T2hC?=
 =?utf-8?B?RTdSWnhQNyswZWpXeVNRYy9JZXdNd3NDbHNHMjRCZUhXSGdYWmpjNDJ4WkJF?=
 =?utf-8?B?MjUxZmNxSmhVUTl3bU9vcU1ZT3hYVTNLcjVTVFIvVEYxbHN3WEJ0M3V4UjVt?=
 =?utf-8?B?bHVjVlNtN29XdnZNZzlYMEVOVkMxOEthYkNOQVREMThUdkhyekZpajluZ09q?=
 =?utf-8?B?SHMwdVBUTnBLdXMyb1dyVzUxZUs0dHhsM1VWUkNQV29kNFhCREJBRVlieE9i?=
 =?utf-8?B?R3A4VnI3a09sdW1PQ1BvSERBdEpuWXYyZzh0M0p2MGZDZnZYV1NyemJWQWV1?=
 =?utf-8?B?SlVPUDFQaGpMYkZxdG55Qnk3cyt1QlF5ckFqS3FXSGxTc2F3ZnhlSkVHbGcv?=
 =?utf-8?B?TzJJaGdHdE5SNFBGenJ1U0F0Vzdvc1dhSFRyMlhSY3NvNEdyWm5zRlhtSzhZ?=
 =?utf-8?B?bUdGRnRTeVJaSjdQVG9wYS83U1hGRnZhOHcrK3lHbGl3OW5iNEdONC9rUnFr?=
 =?utf-8?B?WlA4YTU2OGtnTE5pT1pTVjFnUGxNaE5mZVVHc0tKeUhDY2ZlNTdBcVBJQnFR?=
 =?utf-8?B?eStXY1FYTGdoKzRaT3JsRFJ5azVHc21UWmxmKzljSk1jQWt0WWxaTUZoV1dF?=
 =?utf-8?B?aHhJNjlGOGRxL0w5aUxMTUFZL0Qza05BUlN1QVVabVZ2R1Jpdm9vaU13alc0?=
 =?utf-8?B?Rm9FaWl4WnpNaUU5MmJxZDJadlpTakVjdEpTMWkxc3FOOHhxazNxN2dNaVR5?=
 =?utf-8?B?aUNTeFpyY3ozSTM5V2pVa21ualZ4TTBick5QTVFDSG5OMG00dTZ5MEZNcHpi?=
 =?utf-8?B?ZzRPYjcyRDBsbWtwQ3lndkZac2pVWThwT1N5R2k4YThRbTRiMlJSbVJqNTlk?=
 =?utf-8?B?THFHY0FjUGd5bkx5ODR5aHFuSHVjVGRpQlhZcUVGa1B2amxvOGpjVHkvRFMw?=
 =?utf-8?B?c2RlTVZkSjF6WG83UWdLSTdHaWlKSXdOeHVKK0pXVFl0dVVlREVZMkFwWVlh?=
 =?utf-8?B?QjI3NnpDMklseFJGRTJpYVB5dVNGV0VRUzRtNkk1VGo3anJUcTRDM0Q5Q0lo?=
 =?utf-8?B?WUVLOTJaK0ZMR1cwamlxUjFNallielFZOGJ1THpmcUdrNHU2WHovSkhRbUJz?=
 =?utf-8?B?ajJWV2lQUE1DNk9ySXZxSWJjMUVVK2xhRmFLOVdjNkxRUW81dlVDalp2VGtB?=
 =?utf-8?B?TjNRcjVjRE41NHZheTdrMk45Z2cxczA5WFlsczcvSWZDMFRQZGNuS1pqL0VZ?=
 =?utf-8?B?RVJSU1k5VlFTWUo2cmE2bHI1UXQ0U1hQY1V1ZlNjOWxNbE0xNGNmWWpZNG1R?=
 =?utf-8?B?U09jL3dMcitaYVBwK0NqQldDbVJvdFo5YzlIT3JoVHdESVptT2RlVGt1c2tF?=
 =?utf-8?B?SXdabGpOQThWMkhxYVViRmFveTlCSkk1aTB1cTlpeTVpZVlkdXo4WGhyLzFi?=
 =?utf-8?B?dkI1MnVJTDhxdjA4K0hhQkR3dUNYNUNFdHY4VmFzTGZGT2Raa1pYYVVIeEQv?=
 =?utf-8?B?MGtjamdiZmVFRU5GZkxiQ0ZPU0xQOUVGSWd0OEhkak1maGFtWjZqZVkvNjh2?=
 =?utf-8?B?UGNVd3p5R25NWk0wejdVVjNsS3hQZjhzSXcwdFUrVVZWenBTellycEozaHVl?=
 =?utf-8?B?anEwR1lLU2Yvc2RhWDlFQUVRckdNYU9ROFE0L0RBV1NrRGxXQ3F2ZzBqZGI3?=
 =?utf-8?B?ZkZuN1BhRWtCWWxNSmQ5Y294UWdTUy9VYnR2RjUzY1N2SUxTMXdZbkc1U21j?=
 =?utf-8?B?WnhZL0RWZ21rM0J2NkRDUmhHRnFvUlhjcEZzNXlqZXYrWXQydkowNzBxWWM5?=
 =?utf-8?B?bHJhZTFZd3c3QlN0NDJvY0Z0QVZicDZCSnJQOWFiblBEMW1zY28vaW5QZHcz?=
 =?utf-8?B?enB2MjdnZ2UwNUYyNmV1cWhLdmcvMU4xM2xFVTZIaE5QNnJzTVJTVllhT3JY?=
 =?utf-8?Q?vcQY297dCAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VRMk5KMnhEWVFna1I2ZUtHbVozZTMvd0FnbDdVRVNNdVVRNkVkSDlGanNK?=
 =?utf-8?B?UEdvK3lJU3VHSy9SSEU0WVRxekMzb0lBdTN6NFJCUzlHNWJrNCs5VEEyekpx?=
 =?utf-8?B?clhaelM0ZlBOTWRHQ3VpdnJuUmE4SWtWZkhvejVKUVJLb29HS3YrRmxkYzBi?=
 =?utf-8?B?S3FPN01nR0s4MXlGYnlyUVpGZG11UW0yQU9CWUJZUld0WXRiWG1IZ1YzRk1v?=
 =?utf-8?B?YmI2K3lEMTZYcVpBdm5SN3BzeHh5dmNLc1NQN0dobXc3SWdySzIyalB6eEVX?=
 =?utf-8?B?SGV2NUViOFp2NkkrMXhPbGlyS3BWMnprS2wreU8yd3IvNng1TEk5eWMrYXFU?=
 =?utf-8?B?UjdXOTNDZEhxOWtmTUNTeTJ3M041SXJnN1ZGajBYaXplbTFJUEdQMmw5Zzlj?=
 =?utf-8?B?V0Zia3F5b2NudFl4bWxKSUxtcE8zejFkUndVdmljZ253QW0vWGxuOFJMaGJP?=
 =?utf-8?B?RkFFSHRHc0NKakxzdjdYbC9Pdit0alpyZjlRMFJlTnk3NTZRbFZ3bVdXYlVq?=
 =?utf-8?B?NmhJZmNuTDgzem8zakRlNnRWUnlvd0ZKTGFoUWgxM0FDWFErMjF0bHBiZ0Zo?=
 =?utf-8?B?SUhWM0FYU0x6VWxqdzBsTmJYZ0FtbjdwdUZNN095eUo3eXBtcy9KaTdSc284?=
 =?utf-8?B?UlNMa2F0aFovMERrL3BmdGlUcSt4cmZ5N2lucnllczlsdzZGNnhmcUwwY3NV?=
 =?utf-8?B?SDFDa29iU0Frb2pxZk5qRmNPY3BOYjhiQ2VwQ3BWNGQ4UVlSTzU5QlRXVmlk?=
 =?utf-8?B?Rjg1bGNjZW0xZHJvWW1JOUM3bEJsMTBkWGUzRVFaTVpoOVdIUytTcXM5Zkox?=
 =?utf-8?B?MXV0cEt2TlpzWnZGVWpGUFMwc1RhWVE5eUlpaE1qL2lYOXhTSzV3RDJSSGsv?=
 =?utf-8?B?dTU4S21MOUMvc3dVWkVDOFZzc0UzdnhYTSs2QVNtemFENFdZaUJJTU43b29Z?=
 =?utf-8?B?SWFQN1N2UHIwMlZyNEFUbWNxSmM1WGxxR1NvMm9UeFdWQXBMNnFXTWJxV2wv?=
 =?utf-8?B?L0tBRVU4aWRnR2twYS8wYTNTNE45TEtZTDM3QkZmWGtkeFFWeWthSm9qUmJ1?=
 =?utf-8?B?OVloTU9ocjlHRGxadHhRNVUyazJWNXhFak5Fa3VrcXIvMS90WVNZN3dCbjRa?=
 =?utf-8?B?RGk1bW9ZVWxucm1rVVRzaU5zWnkvcjZPT0xsT2VlSjcydGdyNnhsTFJRby9D?=
 =?utf-8?B?V3FTTnRzZ3VxMWhHZnBlZjR4N1J1MXpJTW1WeXkzL21IN2cySHU0Z01GM29B?=
 =?utf-8?B?b2hQK3ZHMVdwQUkvNHVZRmVrRzdWd0hrZHlidEZ2S1MyeUlFOGZyV1JTcEk3?=
 =?utf-8?B?d2NhOERWYWJ3cU9vZXBoS05wQk1rN284ZUJSNS8zbmFzYkpsWDdWbTdXZWFX?=
 =?utf-8?B?YlhLOWRYKzh1MGJFVDBZaCtVMWdmdWxzTlFTOXdnZ2VmTnlZZVV0UWNoT3Rp?=
 =?utf-8?B?a1J2b2VLbCtEKzlCSEY5NmN1WVlYb1ppaE9hZW5lOHZEeVRPQTNVTkFZbTJ5?=
 =?utf-8?B?WFdCajVlaXlLcElpemgvazI4TXYxSFhSeGErRjlHd1ZoK0R6UjZ1Um1Bamg3?=
 =?utf-8?B?QVJGdkpyUGV5UkpIU29vS3B3aWE5U2RpMm9HNU5GMThnL2RXU1V0WkVkUllJ?=
 =?utf-8?B?YlNjTVN2VERzdnYvQjlvcHhRODZneEdRcnBMZ2dxWHhQNXc1a205dGJZSzBt?=
 =?utf-8?B?V2h0VU1SaHdOVkJjOGJITVFXNE5BUzlvUVJWRGhqc2EwUnhCVVRZOWZzOWx4?=
 =?utf-8?B?R2dmaHFrdTBHK2xIYUpZMHdoaHJMZXQvdDRBaW9HL0syR3Z4ZlV6dmJxQkgz?=
 =?utf-8?B?YXZLZWZGYStnbjVRdE9kNjU3aElyeFV3SGdmU09hL280a3puME1zdkJGTzkr?=
 =?utf-8?B?bjRiYnJpRmJxeHl2M2l5NkNDbzM0Zm5Pd0ozRHRINFFZY2VlUXZaU3NtbnYy?=
 =?utf-8?B?OGc3enZ2cWJLQTc2RUxPalJCVzE2RTJJMEZoRmVnLzNsNEM3KzdoK2YyR0ow?=
 =?utf-8?B?UHlhbmtIZzRMWFY1N1N2aUpwRjNXZHByODBaQ1dGTFFsaWg2RktxUTlOd09x?=
 =?utf-8?B?clpMZkp4MEU0N200QnRSNFlaQ2NOUjJsZ0tvYmp3QkhoUkU0NVFtSmNrMkls?=
 =?utf-8?B?THBHZytJcHcrazRFSEFyY25ULzlNN1llUWVlVWo3TnR1UkNNTW9PdWp1K2R2?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4649c706-d20f-4367-c946-08ddf700893d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 22:13:03.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0bAejGDAlnoHrUg/wl/iMtEQFAFTWAR4XUFZh5DBnew8VnkGGohybAhdoQaeHpoNDF49XjOK4s719GEoz95X6pXKHejN2WCqgBfyTNXwrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF409BB8CE8
X-OriginatorOrg: intel.com

--------------xKy2cisfNPg1IK22tuL5Q1bx
Content-Type: multipart/mixed; boundary="------------AJRlEETccjk8xckqCAzI7NKN";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>,
 Simon Horman <horms@kernel.org>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net
Message-ID: <212c7008-0053-432e-8bcc-c0b94b111a78@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/5] net: docs: add missing
 features that can have stats
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-1-ec198614c738@intel.com>
 <f80effb4-0c91-416f-a7cb-4c9a7055fa13@molgen.mpg.de>
In-Reply-To: <f80effb4-0c91-416f-a7cb-4c9a7055fa13@molgen.mpg.de>

--------------AJRlEETccjk8xckqCAzI7NKN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/17/2025 5:45 AM, Paul Menzel wrote:
> Dear Jacob, dear Jesse,
>=20
>=20
> Thank you for your patch.
>=20
> Am 16.09.25 um 21:14 schrieb Jacob Keller:
>> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>> While trying to figure out ethtool -I | --include-statistics, I notice=
d
>> some docs got missed when implementing commit 0e9c127729be ("ethtool:
>> add interface to read Tx hardware timestamping statistics").
>>
>> Fix up the docs to match the kernel code, and while there, sort them i=
n
>> alphabetical order.
>=20
> So, ETHTOOL_MSG_LINKSTATE_GET and ETHTOOL_MSG_TSINFO_GET were missing.
>=20

Yep. Theoretically I could adjust the commit message to include this
info.. I tried to avoid editing these commit messages, because the
patches weren't originally authored by me.

Thanks for the review :)

Thanks,
Jake

--------------AJRlEETccjk8xckqCAzI7NKN--

--------------xKy2cisfNPg1IK22tuL5Q1bx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaMyD7QUDAAAAAAAKCRBqll0+bw8o6Oo+
AP9811DBAXYFKQwcX2khlRS/pdiH4sbgaO0Dp7VB0hrU4wEAjjusSNMo5VL3sApDwx8U0L2F6XA5
bHEOA6fFJXv7gQ0=
=PEIX
-----END PGP SIGNATURE-----

--------------xKy2cisfNPg1IK22tuL5Q1bx--

