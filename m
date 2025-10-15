Return-Path: <netdev+bounces-229750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546ABE0897
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53454586EFD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920930EF9F;
	Wed, 15 Oct 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvIFVeXO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AA30DED3
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557540; cv=fail; b=ghR2gjP9fHUF61GVcfBuYE0NTzM/JAscRleQXdesHkqFjT3APg/Pqt553Zxot2cv/ZiHrtuukWqEkgrscNb25jcNuzTzoWM3C9BjBJ9hKoxcNKgt5eRi8Z0Dw2uFROEU7lwYEghfd1XuHLkXSeD7pQwPGyLgN+REgVmM44krPy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557540; c=relaxed/simple;
	bh=ANBQvSKBz1+jMRze2cY3GusZrMiLHYpzg3tUvq4PO5A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NvvCCtAW+87Qyt7/03KFkZ3Fh9L8X4raKt2zVIkNuqPYAiHBt1NTD8CgaHHHLwteWUbpayFIQvKY55q1j38CvyZcA/gM4gNgPGZ2+3htXWeTzjc//lloQRkYyVW44ZDhW76gHqh9oZwrfxEl2VaQKT2mB/JyEdHIhM8u9YI/lvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvIFVeXO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760557539; x=1792093539;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ANBQvSKBz1+jMRze2cY3GusZrMiLHYpzg3tUvq4PO5A=;
  b=gvIFVeXOZgDs8bNxGOYAQM1R97u6OrshH2P6gL4dXuYEnvjEeMxuFKXr
   DmzCGgH/x8BAYZN0+t0siuFez8Psus5bZJay724t6Hu+pjj4G5fRF5tfO
   A9fpgM5otAB6ludy0QBUdowMFOgvzPl735CSEXf8y7BaLfp+uePz4svo4
   ebIHg72QncwfPFv1pqcw7hmzTBgqVJZuRpbMuPtG/YT4SHjk6gBe8Kj89
   8N/lZQrm2ihbF6KjhLkZfOJ/Md3cRJNl3v7toSVbyWcx5jaLoYlbsPk9Q
   z2G4z0tKAploAJnkPbTw33qamOFoyiHSSBco5he1zne9iIoRmS9ABTVz7
   Q==;
X-CSE-ConnectionGUID: ZNULOKR5SkiP/kjOLHgsKg==
X-CSE-MsgGUID: uVZ6OtnWRhmIG+EmihoTiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61773736"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="61773736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:45:38 -0700
X-CSE-ConnectionGUID: rzCFqG7hTDGC+U7w9y9mmg==
X-CSE-MsgGUID: kmFiuXyMTrijF+s1AtsT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="187352839"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:45:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:45:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 12:45:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7juX9r0VdkWXgb4EOd+vYwM+ecfCxAblgXgc41lBUkSWDsm/EFlb4mOtQ5uY+e2ZF0Rwa+BY7h0P0IsBFvhzVcXmdMKXzNyBlO1bo60+MWO7y3Iy2WCffHYlVRsqCUe5sgKcvKrKXrQ7IyqmlY2mxa7PyPF772xGB61UQQz3idfMwb5pavuGBae1RauREm/ajF/33qmlcHWSt7aPiGj45DWjrB2dlWJGuPfqNog9xE8zkOzmKDFSIPLKed+h9HWLjbYwG9xOz5MPK/qx/VdGGqJp4DgAk0+LQK8C1ttc9yD3kEs2vU/FY460SP7+01WivkrCX2c2acDO6Oc+t9HWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL3qEtCpVXAhB8yt0rjOKezB5iHvaj6ZPhDreyLqLzQ=;
 b=HVwRmRRfqKc+CZAfPYYivFyzh1mVfFJwRpiCcvzwWmxGE+eiNHdYsNfeKZnvFQs3oXzbyZipG/7v1/+MZXLm+6mO37zBD4qWjbHI0ayBuYX3blwtXB6Fl8ser3KH7uJE2cCp80IUDye1ML2wcySEzf5ESXNq6dJqV4QhQWaOWuTuxjQ17B81cmoOb9tu4fbH4vL3Qk7WfhlvdVge33/m1gGaY6K6Opw6FUoSS6DKSU5yhaQ9ANvyVSEVVKrk1EzU5+TFYZOo34ui51wtaE8KZWiERrl4OoZNvx36wNOSS0qi3l+iK1VzP5pdo4GxSgLsPFIZ4z8WxxvkCUSdaFfLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 19:45:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 19:45:33 +0000
Message-ID: <33cd1607-499f-49ba-8b75-b9f30e219dbc@intel.com>
Date: Wed, 15 Oct 2025 12:45:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: am65-cpsw: move hw timestamping
 to ndo callback
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-2-vadim.fedorenko@linux.dev>
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
In-Reply-To: <20251014224216.8163-2-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------lmfXncUVZ0qLT30YEzFPPwKZ"
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: fd72fc5a-1989-4882-a98a-08de0c236786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ukt1by9XclNLNnFvaWRqMDVpdDdDWVN6azNIQ1ZRd3V6Q05DdGtOeE1kUXNS?=
 =?utf-8?B?TElBZXhuc3dlWG9iL0NtZUxZQVRBMkFwc2hSMExXYUdCL2VtcUIzK0xhb1ho?=
 =?utf-8?B?b0ZYQUJzOXk4VVprdzltS3JzTHllZXAyODRhRmkvcmYrVmI5U1VvbmROeStK?=
 =?utf-8?B?MUxmUW81aTl1OEZPNDlDV21xNElMNGwvNWowK0VLMWl3bFZxeis0bFh5djd1?=
 =?utf-8?B?YjJveFEwellyYjhENmsvTXRwcTNkU3ZlNFRJWTBNTnFaUGp5Wnp6QXhxbkRx?=
 =?utf-8?B?NUNEaEpkcW52SnlaMitUOHVpRlRYNHR5RFQ4UE42UFhUamt3ZTJsVE4yS2pU?=
 =?utf-8?B?alRkQUZ0SjdVN0d5dDBUZ2Z0bDIyTlg4VkRNOEd0SnE5VDNzalpPa1pCSmhi?=
 =?utf-8?B?ajBVYVJEMHlXWm1ET2hhOUFDcEY5WEtqaUJnci9FVmJQRmJ5VEFrZkp6akVw?=
 =?utf-8?B?WHlCVmFieElkZXQ4dHBZdk5IbzZObVo4QVBLcm9HZmQyRmVwampnUVZnQnJF?=
 =?utf-8?B?RGU5TWVzQUtHVzc1ZnlvS1puN0VEWXpINkxxM2UyMnZMd0U2QndBa3NtbjV4?=
 =?utf-8?B?QWVUNHQvOGZ1WnU3MVl0elZSVm5rd1U4a2pnQVVZNTc2QStLazBDajlLdTVD?=
 =?utf-8?B?RVBHN3M1QzA4MkJ1bGI4QVNYQUF4MUJoeThQYjNNbGVqSEJjc1kyUjk5ektZ?=
 =?utf-8?B?YkRkUlRrbEpGZm8xUDQyN2txUUtidVhvOVgrQWVoNTFaUmRwc3FoYTBvWFJn?=
 =?utf-8?B?Yk95SUkzby82N21pdVlxK1JQNG5jRk9xWmpQT25aaFl3ZHpIbDYyNGM3azJJ?=
 =?utf-8?B?aVd5L1ZMMUJFcEhBSzF1YXdubTNCOExOMFBIb2dBTDc3MjBlM2lYRlFxK1M4?=
 =?utf-8?B?WEFmSXkrTlZacnJCVTAwWU9IWGR6cjZOWkVTNmJPZ0l3d3FsNitzMHNOT0hl?=
 =?utf-8?B?ZWFXb0pYTUdobmRPeThRWUVEQXQxMEZyVzMvNXl3R0ZUdWRNaHhQWXczcXJE?=
 =?utf-8?B?V0hwOXJMTHdPZGY0cTUzQjBJRmUyZGcvcHdranl0SHpBSzAwcXNMSDJONXNE?=
 =?utf-8?B?Vkc1ZWhLTktnMGdOdURzQWs4eTVFbTlVQ0RrZk13aWpvWGtKbU9adW1TOVZC?=
 =?utf-8?B?RnZOb1Y0UmF5K1FPRU1kZHBjbXBUandrWmRwRldod3ZnZkMzQnlIOWRSS0tF?=
 =?utf-8?B?ZFVoKzIzdjdpcm9xZU04VWptd1ZJbno0WHZQTlp3VSt4a2VJRERKQXJjbzln?=
 =?utf-8?B?WDU1WWdadmRROFgrZmlrYlZTQWlmQ3lydnRjTUwyRDMxVzlla0VoWjNJOXlI?=
 =?utf-8?B?OWRWeG9OS3F6OTBTUFJIK2VFT3NnQW8rS2xSSzB0Q3U1OW95U0xQYTZud3NM?=
 =?utf-8?B?aThYYStxdmkrLzVoSi9HSEJHUG50WlAwdmNlSnNVMXhwcFI5MVVHa1VDV2JX?=
 =?utf-8?B?YUlaVEt6eHhrNHJqVWlxbEswa0YyUEl6VUZ3S3NOVDk4RWd0SUt3ZFN4dHl3?=
 =?utf-8?B?L3BXMG92T3JLbTdQR2pFSjVvNHFvTGdybFhFYjdpOGVlMjFLMHQrSG5Ub0x5?=
 =?utf-8?B?QWd6RlZhdGFOdmd4K2dJTkROdVhkUTRscmNvNERySmZWREZtZ0U2am5Wdzhh?=
 =?utf-8?B?OFd6YTFIM2dlWkR3M1ZzREcxVkI4WmZBSi8zdS84QVdXZUJQejVHWTJVTzBp?=
 =?utf-8?B?NEVuU3I2dUFxSmx5NlFMTG5oTzRRdVg5RFJ1TTBpNlZERkNUVGVLS3FhZGp5?=
 =?utf-8?B?a1BtYlhMbm44RnA3TjM4S0Z3YXBmNnVhYURTZHkzeEVrUGJ1Ny91SERLWDNV?=
 =?utf-8?B?ZE9YckxJRS9LOWhhakt6bjJ1dzlDa3hzQzRUQjA2eU1NWjgyMW5kRmlwOTRH?=
 =?utf-8?B?VEEzUjZKVldleDRXMDZjYkFacDhLVGxzMUVzNUoyV0ZmZzdkSGxMYjFiTWdL?=
 =?utf-8?B?cXhCN2t2eTF0ZVhpR3plUjFxWXZlY2pyeXNzVG9tbE1EaExSeURGalBkbUo0?=
 =?utf-8?Q?ZgeDNgnMfXL50io/eGtRcH/XQl3dHk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJsaW1uTHVwdjY0MWxJRU8vejBIRUMvQXdreFFHOEw0UFQ5azRpak5KRE9I?=
 =?utf-8?B?RnJFdkl5NXpUTmw0eGR6UVNDeXl3NHhvKzlFM3dPS3NmZVNULzNnK2tBRnRY?=
 =?utf-8?B?dW5JRDlLRVNiYStIWldPSXltaVhWcXdlbStBcmx5T0o0cDZyTzRoZ3NsdHJO?=
 =?utf-8?B?V1NGa0J6S3BIRkJ4WmpteEptVGUwbGVjcm42SWIydDNGWTNJb3pBbi9CdG5m?=
 =?utf-8?B?cVdYcExONktwRS9BMGRLL1g4NWJFWDFZTWo4TWc5eFJOU0Y0UFZZRncwR2FL?=
 =?utf-8?B?S2pBMDU2QlhxdCtwc2k3TmR0bSt5bjVDMEpQMFY1T091TmRlQXYzVDU1QmVm?=
 =?utf-8?B?RVllOFpKUEN5UGMwRzNKWXZiaFlsSTYvOWRDdTJZTWRheHBKYWlXcHY3Vjhk?=
 =?utf-8?B?ZEk1QWpSaUdFVTZrVkM4aHNLMzZHWVM1akR4b3Z3US9WUXZIRjZjV3p0b3RG?=
 =?utf-8?B?d0szUnFZVkJKWHRlM3RvYkJFVXlCNW5zaThRbEtFL1h3eWVHVyt1U2x2eHFT?=
 =?utf-8?B?WUYzNmEybkRlazdMcXlNUG5CSFNJTVJnbGhZRzdIQVFEakd3N0tFMklFMm9N?=
 =?utf-8?B?SnZHbzArK2lJRUtVTy96MzdvK0tzS01RbjZDMTdEQkhtRGw0anEvSUR2ci9Q?=
 =?utf-8?B?VkdzUEZDbmpVdDM4a09OZnFlRms3ZU92R2FqUm9lTUl4VmZWbTFCWmFnNDJN?=
 =?utf-8?B?cU82Z05mbzhzLzBCVHorVDluSGVkWSs2S21Gakl6aWxBYzBjV0lRWjg4WWpN?=
 =?utf-8?B?dmMwQWNPcUZRcEN4Y3FLQ2RYamFpODcvT25CUlhkTVhrcGtiREg2b1lpTGFT?=
 =?utf-8?B?clJuMC9uaDFOV1k3RmN3N3lMRVFoVXh5YUgwUkZmbTUxUEJoNW8wS0Nwb0RD?=
 =?utf-8?B?STNEbGdyZEE0bjhxamNDV1JLRVR5MjIxcm9iZFU5R1BvdWdmcFBxWS9Vb2tw?=
 =?utf-8?B?amtDbjQwdTBnWXFKcFRCTm9rQ3ZoMGhkL29YdXdNSkdRb0JoblJ4dmxFV3Aw?=
 =?utf-8?B?SW5CSnI4MHNjOEV1TzZWSytPTXgxMUFjOXMrOVVyN3poTGJRaCs4SVQrS1hS?=
 =?utf-8?B?eVUvcjV3NnNGTXJXa2JGVWhhT0NaUDlMN2VWTGE0cjMzWlN5R3pESnlKOHFS?=
 =?utf-8?B?ODBFUjM0RmV5bFNNRjRZMUU1c25CWEljcEpBUGpFWW1kSVVXWlBrenBiWEFZ?=
 =?utf-8?B?bTBoQkZKenk5aFdvdVczdnNzdjFCUTl5VkMrUUdGc3p1VzZNVjc3a2ErNWt1?=
 =?utf-8?B?OER3a2k0V3g3MXFQZjFWODJrYmo1eU11RlJtaHhMMTU4QThidGg3dGNsQ0ZR?=
 =?utf-8?B?MXAyVE9EYnIzWUdMcEJJMXNoVHJLNDd3Yml4b1pDeTExWndtb2NhRnN4dWUy?=
 =?utf-8?B?UmRsa1hmSU5CSTJFa1B2M0R5Q3NqcXQ2R1NNclR2Y3gzV0hlTkpJUHlOQzdl?=
 =?utf-8?B?bEQ1bkZROThtbi9iMDgzTmZ6VHg2ZXRVWjhNNTdrL3JDdVpmZ3QrR1NzaktN?=
 =?utf-8?B?S0grYlg4SHg5Um9qSDJoMXVsemRDeXh5cWtnSHVHbmRLTFE4YThSemJNTGRv?=
 =?utf-8?B?NUVJTFB4SmU4bmp3clVSUE5mUnhoMUpwM1JHQUt5QXZ4S1lLM2FabllLWk1N?=
 =?utf-8?B?dHl4dmpHRHZxZGtIWUZiQkJJYVU4aGd5M3hubnlwNkF0UUYvZzRpYVdmZTdJ?=
 =?utf-8?B?cVU5OFFhblkxUllrTmlvSTNNNWRzVXZLR2J3RzlXa1J5RzNkbHFUZFMycTVM?=
 =?utf-8?B?YXF2NXpZTVp2bW5mRmlCSjIzVXBhVWFCU2FCWjk1RmpaelZlUHlmeEhCc1B1?=
 =?utf-8?B?M1pCbVZmU3pEcWNQZ2szcFU3NWp2SVRtck1zUGxDK2lLVHVBL0xPMVFFMVV1?=
 =?utf-8?B?SE81bW15T0xaTW12Y0NzMzEvdEZzYjVkVlI4SFU3RWRUQW9TSmFhK21mR2U4?=
 =?utf-8?B?Y3NSd1lRUGluSG1xWGxKZnJLVVUyV2JFcnhtUjZTWGZxR1hsR0crdkxlWVcz?=
 =?utf-8?B?azhra0hBbDVzTGtsZGxNZ2FIUFd2ZnByOHV6UUxqcXBoL1JtNjNwNnVDRzZo?=
 =?utf-8?B?aWd4eVlQK3doYkc0bEdsM2ExRlpDeGVXYmM5bmlwblVJam90cEFWMU1QU1ph?=
 =?utf-8?B?YTROL05kNS9SQnlram9GNWVjNzRTUzg1VkNNaUxTVGk4V0lJaGdsR01pbk9r?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd72fc5a-1989-4882-a98a-08de0c236786
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:45:33.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siZKRrnn06JlxyTIFPWUGsf5rWSW3qTiwtkrA/mml7LdUZDtnY42Yj2mI/nHwc98QEITOk3iLOuhZG89ciH5wTUeGsWBLUeO6ZTJjLxKd/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com

--------------lmfXncUVZ0qLT30YEzFPPwKZ
Content-Type: multipart/mixed; boundary="------------IFUR9qy0x2hoZoZBzmB0gJiV";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <33cd1607-499f-49ba-8b75-b9f30e219dbc@intel.com>
Subject: Re: [PATCH net-next v2 1/7] net: ti: am65-cpsw: move hw timestamping
 to ndo callback
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-2-vadim.fedorenko@linux.dev>

--------------IFUR9qy0x2hoZoZBzmB0gJiV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
> Migrate driver to new API for HW timestamping.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 44 +++++++++++-------------=

>  1 file changed, 20 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/eth=
ernet/ti/am65-cpsw-nuss.c
> index 110eb2da8dbc..d5f358ec9820 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -1788,28 +1788,28 @@ static int am65_cpsw_nuss_ndo_slave_set_mac_add=
ress(struct net_device *ndev,
>  }
> =20
>  static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
> -				       struct ifreq *ifr)
> +				       struct kernel_hwtstamp_config *cfg,
> +				       struct netlink_ext_ack *extack)
>  {
>  	struct am65_cpsw_port *port =3D am65_ndev_to_port(ndev);
>  	u32 ts_ctrl, seq_id, ts_ctrl_ltype2, ts_vlan_ltype;
> -	struct hwtstamp_config cfg;
> =20
> -	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
> +	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS)) {
> +		NL_SET_ERR_MSG(extack, "Time stamping is not supported");
>  		return -EOPNOTSUPP;
> -
> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> +	}
> =20
>  	/* TX HW timestamp */
> -	switch (cfg.tx_type) {
> +	switch (cfg->tx_type) {
>  	case HWTSTAMP_TX_OFF:
>  	case HWTSTAMP_TX_ON:
>  		break;
>  	default:
> +		NL_SET_ERR_MSG(extack, "TX mode is not supported");

We could use NL_ST_ERR_MSG_MOD_FMT and format the particular invalid
type here, but not certain how helpful that would be in practice.
Perhaps the unsupported filter type is obvious from context of sending
the invalid netlink command?

Either way, the conversion looks quite straight forward.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


--------------IFUR9qy0x2hoZoZBzmB0gJiV--

--------------lmfXncUVZ0qLT30YEzFPPwKZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/53AUDAAAAAAAKCRBqll0+bw8o6Cte
AQDeKM52gaZMJ9Qi1FMMxRNptX2VerrGK0fVm8GD7Y0xXQD/bdVriWMfRP3mdQ9duqMrkE1ChCb2
mm3rakMr93qj8Qs=
=bbtM
-----END PGP SIGNATURE-----

--------------lmfXncUVZ0qLT30YEzFPPwKZ--

