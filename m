Return-Path: <netdev+bounces-232668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF8C08013
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850181A6281B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0382E7641;
	Fri, 24 Oct 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSBOA/k9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5302E6CC4;
	Fri, 24 Oct 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336827; cv=fail; b=qo/MdiqYn0qa260qENE/N0wVCnj/m7XfKSEfJW//HRENlw+Q8wfonPO9p2oJrbiJ1w6bySoVb15k0LdxWv26/uKT4rhZ6KOmvYHxrUj9W2F2xvVw92Ez9+U12xQ+cvGrJs7TtIKMvJ5tzPUyX9hYbhEqlZJw+MNczMW3OQqapYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336827; c=relaxed/simple;
	bh=lpidy9f/Xj23fTjAX3u0rI8Q4NvFKn81E/MA3w8DByI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kq3u5d7Ttqod3AbHEtylYrnaSlQXUliUYXllEwpGU5K4tgosrK2PNPKWz9bM9LG5xqi1EYr8pWLdUB+RqQLd6zJd1+u7HuUdt6e+rkZcCA0J8tHvXpC6Ousq312DjJ3+jce0nYq0K2ElypDEzOsH2eCCQRdMOlIg8u+wfjLT6F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSBOA/k9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761336825; x=1792872825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=lpidy9f/Xj23fTjAX3u0rI8Q4NvFKn81E/MA3w8DByI=;
  b=BSBOA/k9DP2DLPD3Q+N5eVLqLYAUfTygjMudg8hENcA5CU2U2zimjUG4
   EVvbbxkSKZ7M1B/hKF3REfiwZn/4AmAi2KWw48HtH9fegBtx0HYMwuxgR
   JfRRjUrLCrPaWAvtqZlw0zM91kuHIUbYcn48lTF65ge9WyVnT/E+68QZI
   SyLl7moe7OUGkJ/NK4Rq2N/Ft7iWuM5KxsqPf8vhAmL4iE+OH1btiwlMP
   +Xv40R0VBPUlxQWAhuMkVWl2xZaP88d1/R3zbcOlW/qMCQd4BsZaCOiGu
   JWHRqXn44uF1rVKenX394KW1yH/JdmhpLTxYkK/YS1LZImh+x95PB0Xd4
   g==;
X-CSE-ConnectionGUID: Tfq0bkrcTaKC69UQzojEcw==
X-CSE-MsgGUID: s2TXBzgwTt6btO/nQoS+8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74868658"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="74868658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:13:45 -0700
X-CSE-ConnectionGUID: Zs4bOdUFT8mhPYcHJIjmgQ==
X-CSE-MsgGUID: Unv3VW4aRGuTd++jp7+r8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="184424268"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:13:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:13:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 13:13:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 13:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUPpZ6yJvbaMDfrbd3thDFHsdM+dsCPGImV1YQOtuW1rD1oYag4LdRSWb5YdqRdk7MJuYQBss+0jJmLGSnhnVnizsv24zUsADczyMMkSqU3Y7fhf0UujH0eLOmxrXmAjY15mpeh8t3jDZSxgdisicGeXwB/LQmzurMWfXwLmyN2VvWxbDsN1N7Gh9o82mXMjoFYP/zZNxv0WcQpihNZRCnJCtbXCrmztD3Q1TQgk6lV5qkg3OX5R8JqUwJbMFe0M6M9GywGiEY1WXFaS0NKArJIiYsf6KdPQurYqepAzGOiOBdZ40K24aqfL+2yLpFUbchjE0+fostbss0D8B0pnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bNUn585zz4vTQVpAALwVhx3htf9/WSvj4QOBfpnijw=;
 b=lZ8nz/IGxxMQU66QJEpzer7qBVquMfhgu47Ntm2yYlnZoC8zj1meBzVjxQxHvY+jBocMcaqHCzXyN1CPcqvITutgYtP6hG1Qg7rok7k3YugDZifBM0jo/BW8066vuQ1qD8y+Ibt/pf4NftZj15ixqX/FaSVyc0qg8tSdNU6OWMpb0+vGAfot7lXbEqooSF5n1/oXTy4ybRITkZqz16xWZrGRlzotYcCFxIvy5QbkM+p7UifzNDj04cyZC+ueirKfeGnUr966LxJRO7cwQZF7bksgjzIbI2ZQeCi6fhq5d10bDZeZk7vt2iYqLvxKDFCvDyPOmWhbtVk6enM8Sx9Rlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 20:13:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:13:42 +0000
Message-ID: <d8c8b315-6419-4178-8fc5-370d7b875c68@intel.com>
Date: Fri, 24 Oct 2025 13:13:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Edward Cree <ecree.xilinx@gmail.com>, Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <habetsm.xilinx@gmail.com>,
	<alejandro.lucero-palau@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
 <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
 <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>
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
In-Reply-To: <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------NiyYQrakHSnghdRep2H0UzWU"
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e45f1d-3f7e-486d-10e9-08de1339d3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3NvVEFVZ2RTMlNTd2Q3c0w3UEplVi80TkxFMU5aTnFFZ0tkWEtXYTBSbUN0?=
 =?utf-8?B?SXErSWV3YU9NcUFKRzdXV0IyUFdvTFl4enBJN3JiaUlZWHBzaXFkanJWNjht?=
 =?utf-8?B?ODVFbEJGTUwweUNkZVVmNGlsQTRZSzB1K0grWkNWbjgzeHpVWXh3Mi90YXln?=
 =?utf-8?B?L1NycnE3aDNaME52aHdpRWhFUmJNd2RKQXE0VXhucUhxMTNtd0t3c2kwcVNj?=
 =?utf-8?B?SjNvNlpzclJnaTZtWEoxMlhDcENpMnMyUFRSSVZDM2E3dHBROFEza3ZaRW1S?=
 =?utf-8?B?KzVQVXNzQjhRLzBkeldBV1lBaEU1dmNjdmU4YXRyUzBNZnhIS1pGNWlKWldL?=
 =?utf-8?B?OWkvV0tWa3NUUzM3dmc1US9SMlpzcm9GTEFDc0NYOFphUVE1dndIT1BZb0lD?=
 =?utf-8?B?ZmQ3Z2YwWXRsaWZsbXZ4TnhDcU8zWWthZ0J2MnVFT3NscUJjQUg3ckY1NHl0?=
 =?utf-8?B?R0ZyYzNrWmpsSnNLdThkaHN5Rk93WUpha092a05kWHczYUZ5R3lKNDVucERZ?=
 =?utf-8?B?b3pNdnZMU2xhamV6a0NXTVduaXZuSi9Bd3g0QUlVd1ZZZGQwVDFSRFZpVjFC?=
 =?utf-8?B?ZzM3K0grdGpmUkNqejg3anpGekk5S1pzMXhDVW9vbm5NcnYra1lBZUw0enJt?=
 =?utf-8?B?anZFVXI4QmQyV1ozRFQyOHdaRXMydUhhUUhRRzZtVTIveFBqaTZHbG52Y2hQ?=
 =?utf-8?B?Y0UyL0x2cmVxaXc4SUgwSmFOODdyUHRIb0owZjc3aHh6SDcrVC9xazh6bkEw?=
 =?utf-8?B?Wll5blcxMkY5TldrMHlJSzdyQ2FtUlFrbklmS2lmUDJKazNxVW8wZTMyRG8z?=
 =?utf-8?B?ditUcVowTGVEbENHYVpxVGQ1L0ZuU0FUSzFjbXlsNzNNQnNJckJVL2VLQnZ3?=
 =?utf-8?B?THNlQmVMNllkMHN1MTdPc2RPTFF5TElWSWwvN2xjb1ZNN0pKazJ3Zk5yeVFM?=
 =?utf-8?B?WjQrMUJhbUxCYVVnWG5VdEpJK09iNVJkeGl4T0V6azI1WHZ1c2pFUzNQbmlw?=
 =?utf-8?B?WnRncGg1Mk1uNVRyOXpwRVFNVy9VaXI2OGVML0FqQ091b2FyM3RGeXVDeXF3?=
 =?utf-8?B?d0EzQ1RJOWJxQjd4dHhKZ3M1U0RHMHVlM1kvTVhpNU53QndxSVk4TlY1WjVa?=
 =?utf-8?B?U0haelk4ajZUSFk2NldNUnVnTXlIVmtueFhUNGVzaHViakVITWRjYXNBMDJM?=
 =?utf-8?B?Y0Nyc2xCMVl5NUNCQ0NycnFNOXBLMXVmOW5xVWc3WWVWaG4wNjl5QUVKRHV1?=
 =?utf-8?B?MFNMbXEzRzZFQnN5amQ3RFhEcThXdFlyUWE3ajR0QUkzRS92ZlJpY0x2eHFt?=
 =?utf-8?B?M0I5U1A1Qmp2ZEZ6VmVCRGo4SmtBSjBnQXZDdWF2YlpHeGRMNnFWL3FxTDNk?=
 =?utf-8?B?U2tYZEpLMVlFR3l6ZHZWdnIxdDJKZlhnMG1FdnRBVHlQaGJkTHA4Vmd6aHpu?=
 =?utf-8?B?d1BPNTM2aG4zWXlCK0NoWlo3RHVCYmozZkRDd0ZsT3BXUVFjL3RrcUdKVDhU?=
 =?utf-8?B?STJxRUJPYkJXbWM2dVRXVWdQNG15dmV0OWV3WEdraFR4NGZFRDZJS3pqcEtD?=
 =?utf-8?B?bytyMCtqVEh6dkpNS3BqTk1kY2kxTGE4MkwwNTFDYXNvd21NekhOcXhkS0th?=
 =?utf-8?B?emY2T1dJQ2JidU9qN2RDOXVOT2h2aWVkT3FrSzhKODhiNDliQUY5S1RxSGJ2?=
 =?utf-8?B?Wm1NMG5qOFZSeEduRHhKenduRWRrb0l6QWdOa3hMYjFsaUlvU0QreFNtc1NW?=
 =?utf-8?B?K2RlNUJ6T1dkeldiSkIydHMwOWc2QWt0M0xUZ1VkYnRqbndZbUE2Q2pjQUFv?=
 =?utf-8?B?R1ZxMGY2VndQSDkvY3M2K1pmUFg5K0M2dDUrZE1EMFovUjd3SFBCaTlGeFIy?=
 =?utf-8?B?MzdQclRLNFhKNUVOaTk5aXBTVFZrSUNZeE1zWTErMUVvaFFUazhIOXZTdWxv?=
 =?utf-8?Q?y21LYEQibmFm/jNDnnfF8ijgV991moLC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJaMHorbDNJb2FRbnlTdHBCam5INEU3N09VR1EwU3c3aVI2TnVQRjcweVl4?=
 =?utf-8?B?bDczSEo3VmdpM0U4cU1hV0JOMU9xaHAwRVh4YWh6V3hMUEMyVHU3ZzJtaWh0?=
 =?utf-8?B?RFVmSWlHT2lncHlmc1o5NS9XN2JPUi9wZTI3TnZvL1N4ZGNyRWpILzlhUVc4?=
 =?utf-8?B?R1l4SmxvRjkvdisweXdJSWtpYlF1S2x0OVY5ZUVzVEFQOVJMRlZVOER5NEJK?=
 =?utf-8?B?aFhnVEROcWFqMHdnZlE0RzliRzVHYjZmanhVUWJINDFaSFhhUmpFOVUzTmJL?=
 =?utf-8?B?TmZlNUNndDAzSWVNRUdqYjhJb3FvRmczNVpHTjFVNDlHb1h6RHNWY0x0dXBY?=
 =?utf-8?B?RkhnaGZJL3VNdUlNK3FabGVqZmhpSXFHSlg4UmpJQmp3ZmxsUlY0ZHlqS09P?=
 =?utf-8?B?aWVzZEdnWjN5c2w1WnhDWmszSGFBWTdXN1lyTTk1bHNlUHZkVXZxZ1JEZ2pw?=
 =?utf-8?B?YkJMYmZJR0ZsdFF4TmxZYlJUeFV0Z1ErV2xCdGN3U0tyOHlVWkVXeXFTWGww?=
 =?utf-8?B?QmplVUhwQ2xOd0tQTGdwNXVERXNRd2pmY3RLOFVPM0dRQzVoMnB6R2laVDZt?=
 =?utf-8?B?czlyQmRxSndJeTdGRUVMa1I5VGE5Z0d3NTJpZmY5SnExVHdqNlphaXdUM2hu?=
 =?utf-8?B?cGZvT3RseE5HVDk4bmhuazRSN3dRT3Y0N2RXS1Q4cEY3elNSMTNRcWt3SXh4?=
 =?utf-8?B?dHlLQ1F2OG1uNXN3ZDB0V0xGWU5NdStkWHg0eFUwZEM0Y25XL2orTUdqS0hx?=
 =?utf-8?B?bTBQLzVyL3ZDbWJKN2NoRlIwM2dSYmJsSVhRK2thT21aQ3N2T3hXc21lMlJZ?=
 =?utf-8?B?SWI4Y2o4djBtaDl6YndIRnNadTQ1ZU5FdjY2QzJ5NlByOHE4MjUwU01ZV2lp?=
 =?utf-8?B?dE9rN09nZFpoQmlVSFBsRXp6VkUzdE9BT0p2UWhvai93dk5YTXVPaHdiV1VU?=
 =?utf-8?B?M2VlWUhjS1pKM3pTYjNXNDRLUG5EMFJDa1Vhb2kzQ1pKM0JVR25YNnhESHdX?=
 =?utf-8?B?VjFOUWYvalhwZ1UrWEg4TDFrSk8rZFRBempMVTlPQTM3WkF2ZWo0ODFGNStJ?=
 =?utf-8?B?Y1JJdG9qaFpBYzRjKzZ2VkZRb2RET3ljWVBUbGtYM2tQd0UzK05KSHdHdTQv?=
 =?utf-8?B?TU5yZkpEeHJOTWF3Q3N5dWlSZnZ1TzVHaWlJSDU4VktRSEU4bVJyZitMNEY4?=
 =?utf-8?B?YklscVQwNzgxZUIyellkdDFMdHF0bG1sNmVHeW1YZWFFa2piT052Zko2ZWhq?=
 =?utf-8?B?QVBMTTNOc0U2QWVjaE5uNzJTaEZQelJmZkhLbjdtcTQ5b2lEalMwMGFVTnR5?=
 =?utf-8?B?eXBsUjJiejRTY3RsWnEyZjNYczlXRkdlY0dITzNwOFZqYTU3LytIWFRQdHdG?=
 =?utf-8?B?L1lnZTUxUVFRc1E4ZHBUNEpHeUhsZWUxaVF0K21pVTF4aEx1TjV3c2ozMnpH?=
 =?utf-8?B?TlJwcU5naXdwU3hyRzF5R0JRanFCdDhoVXZ6Y2doWlIvVWNLQWRwdVA1R09N?=
 =?utf-8?B?M3VNS3B2aEZSUjhOd1dKTXVkUnhDdjU0Z0ptQzRmazZ5Sm0yWmdIQ0x5Z2FE?=
 =?utf-8?B?RGRXTm9qZkUrQmtHY2hmeC8xYkpwNTBwZmZMSFAyS0lZVzdNVnRkc3gzR1Bk?=
 =?utf-8?B?VTk4WDg4U043UUsyZnFlaUxqUUNFTGMvMTEyNis0MDFMdEZWNGpBaVhoY3Nt?=
 =?utf-8?B?RXR2QWlMSDM2WEx1cnRveDdrVXNnZnRkaHBJWEJ4U0JneDN4SjJJTWlJVFgx?=
 =?utf-8?B?ZHk3M2JaTC9IWkRrWG53MWxmT0JSclRYeTFueGpsZTBEcnFYeHcrVjNFdDh2?=
 =?utf-8?B?QXRKMGZ5MlptS2lLNjlnbHhRNXA5MXM2eG5UQVdSdWlKbTFjVDFqOWF5WGxl?=
 =?utf-8?B?VC9SbTY2ZCtER2tGSkxCRjJNYjNhb0M3cUFxbTkvRVhXVWplZ2pSTENYZnlN?=
 =?utf-8?B?TFJmdWs4dVh0REs5SkRvKzZ1Wi9IZjlyN2FsVnE5NDZpUlJQZVNmMjNNR3Jv?=
 =?utf-8?B?cUk1Zml3TnE5Vis2Qmx4K1pzN3Z2WHk4OG1abnNCYnNUMnlmS0FvWU9GS1l0?=
 =?utf-8?B?SmFsbjlORmpOeEZPczRQaEM1ZjM0WEZhcGVSb2c1STJiQmYxTlc3dnJNMEYv?=
 =?utf-8?B?Wk9mNEpvYWpYMERKbXY1eXlXOEVoRjFJSFFGdzZSM1VmcUdXYnJsWlB6dW80?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e45f1d-3f7e-486d-10e9-08de1339d3e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:13:42.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5yYvI6mPAqVbIT7yltw+OE/TT9i05N6GypknMTFGPjrHYARJJ/K4+iQtV/gIzGb4nVatQAu3o1bRdRxof+qej6wAnqiD0OWZrNYdrQbllQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com

--------------NiyYQrakHSnghdRep2H0UzWU
Content-Type: multipart/mixed; boundary="------------DD0sRRamtF4mUEiFHtz4mL1U";
 protected-headers="v1"
Message-ID: <d8c8b315-6419-4178-8fc5-370d7b875c68@intel.com>
Date: Fri, 24 Oct 2025 13:13:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Edward Cree <ecree.xilinx@gmail.com>, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com,
 alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
 <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
 <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>
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
In-Reply-To: <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>

--------------DD0sRRamtF4mUEiFHtz4mL1U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/24/2025 7:48 AM, Edward Cree wrote:
> On 24/10/2025 01:48, Jacob Keller wrote:
>> On 10/23/2025 7:18 AM, Abdun Nihaal wrote:
>>> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is=

>>> passed as a argument to efx_mae_process_mport(), but when the error p=
ath
>>> in efx_mae_process_mport() gets executed, the memory allocated for de=
sc
>>> gets leaked.
>>>
>>> Fix that by freeing the memory allocation before returning error.
>>
>> Why not make the caller responsible for freeing desc on failure?
>=20
> Since the callee takes ownership of desc on success (it stashes it in a=

>  table), arguably it's cleaner to have it do so in all cases; it's an
>  aesthetic judgment call but I think I'd rather keep it this way and ju=
st
>  fix this one failure path than change all the existing failure paths a=
nd
>  the caller.
> Alejandro (original author of this code) might have a different opinion=

>  in which case I'll defer to him but otherwise I'd say v2 is fine to ap=
ply
>  as-is.

Fair enough.

--------------DD0sRRamtF4mUEiFHtz4mL1U--

--------------NiyYQrakHSnghdRep2H0UzWU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPvd9AUDAAAAAAAKCRBqll0+bw8o6JnY
AP9OPHGE5P+ZJ5/dUIDOGhxEYe7ykessqISZ1DxQS5Uc8QEA/PIOq6NbF4gsAlHelXPy5W/9Qj+Z
JyGVNPpuGBKO6Qs=
=zy4Q
-----END PGP SIGNATURE-----

--------------NiyYQrakHSnghdRep2H0UzWU--

