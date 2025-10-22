Return-Path: <netdev+bounces-231899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1EBFE61C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B77894E0677
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE2303A34;
	Wed, 22 Oct 2025 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV576OEL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6C2F8BCA;
	Wed, 22 Oct 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171073; cv=fail; b=ZbUq8ZQu/cIQdYZpAmhRVxyZHwck6wUMnizxujUfvkaHfeF8FK3P3ApIid19qshw/34RY1SU/v/pug8VcZg0DrfNk4JUnKWdVlKBhKejQFHl5NSwLRjh2JiBqB+nwQCApch68IIgapVV1wqa5UAvKSs+dY19urNkiPqIazsKiWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171073; c=relaxed/simple;
	bh=UBO/DE2Zm9PL7NDJb9ZmpbF1Qh+gq5HjgkOLGzC6LfA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRhA2i7avi1jcW1n2XBqxh3zvm+cyv+r8wfA2IpXloU5IrYazKZFihz+ulfdhT5B6dad+pdfmMfbHv9RwO85308FZcvEDix8KE7lV0iB4/n81eHsbee7LbNdRf3IW0MOTWemee4jBIlpRLtiKVWR1QLDR4PEiebB+HqEO5Qbfpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV576OEL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761171071; x=1792707071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=UBO/DE2Zm9PL7NDJb9ZmpbF1Qh+gq5HjgkOLGzC6LfA=;
  b=IV576OEL98vsqUNajMKuFNnuB+M9qShVNzC3FqUeL/zf8jU9xyr9nvz0
   zRJPzdZmbSjb32cOfgxcTSrWpnpc3rUXBLrwsm80tgme3OUN1S9g9G6Rm
   7Sk4Il627i5FksLMbwwXv/rDDTzLr49GcflujcEz3F67yao+xvkXlBDXY
   w7ZmxeB9Mh3WiOztZF8FZMLM+z5yQdsPiuh+jpJ69JQp9Gt4aiCvw0W5x
   BYOnikjCA1VnXgBvsjpZEO4bFb8HB4rlqxq0btVDvJV0cdeoRkzTN0v73
   vzTUPpl8L1y4wzuCxlfOmSuvajhoM76iuwO6dOkNvREcYEoX5cZzalCJk
   g==;
X-CSE-ConnectionGUID: +0sMy/2STFa6OIyexek9jw==
X-CSE-MsgGUID: sLdLLvWTRByfzWUxrYmiMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74679141"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="74679141"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:11:11 -0700
X-CSE-ConnectionGUID: KlNSkWkbRnG0SL9LeQLlBQ==
X-CSE-MsgGUID: ewjfb3IXTmqRiZ8xje1aoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="asc'?scan'208";a="189112523"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:11:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 15:11:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 15:11:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 15:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBbIXlybnN5mEHWIHJEIY+0YbIquKRspVQdjnCj8jqOI9uHh/hXl9mueSYzIBAPsE4aSS+Kpw37rPU02Db7ZtIQYd8Xv9fx/YEFei9PnGCkrQKIbd9+lvomVlQbKXmjGNYmetm9WkC1HTMUv1BzeloClM1iVCQ4TtkIWeU4bTc3hwuXU3xNO4m6A3MNS9dQVv6nTMSfCxK0MBU5SmT0+e05f1X1Ld0JxMYGP2s8fWGg47o4FgCEDmqWdADP4DqtvYJIFWoqWl6I/CKcYSCpajBSFWMUbmLDFPC0DwjrkZn/JAjb+iXEBsa/hOiWUNPy92k8vfVgDL3rlWsVJ0snZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA96u3jY6GFnktWRSvmEVyt9kvjt5rxe6FkbtJnbCg0=;
 b=QXbUIx3hV2/fjZajhtSThOoDSEua0MqjOav5eSWwTObH4bHdkPWSRspk36/ATjay3zc83fhhg6mqjsANYGtTti2Yot/iLEm9tWo5V6G1eDX2pQEO6AoExFSWbaKs6/FyBCUehIOCqsXVMrvPu+XVGy9rFeE536OWwEGJkrP6I5nmXZuQREiceGl4pj/6E1whjrIMWtzU37VOlujnM2rLg8vdnAeijcGUlvyTjDY5FjYtxuG2qJluGJahBO5nansRJ2cbW+muixnIQyGNOlyF/s2hhtw2Q1SqSIl7/MU+qFUl7Cz4nsuPTdf4BvnN3WQyunfMYBCnYZDJQkEy4tMWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 22:11:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 22:11:06 +0000
Message-ID: <9604cc84-4268-4964-a4d9-2d37ea095138@intel.com>
Date: Wed, 22 Oct 2025 15:11:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohammad Heib
	<mheib@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
 <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
 <20251021160745.7ff31970@kernel.org>
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
In-Reply-To: <20251021160745.7ff31970@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------UpNwEaqRpaBjfpkPAKBspkxP"
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: b53a4135-9b08-42c1-17f3-08de11b7e57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlcrdGZ5V0NqT1orZGNHVTd2NHF0WVJLQlJFWWtBeWgxRkhBWTZCUm81dWZH?=
 =?utf-8?B?NnV3THhnL3lPYWRmLzlMR1ZKeUhGNkJCMHppNjBpdWdISmlaZWhlMDM2SzIx?=
 =?utf-8?B?UmlyS0ZRUGJEYW92REZBUzYrQ0JLcytJYzVoQ1hlbWkrczhLTFhDMzJWUThN?=
 =?utf-8?B?NTNEMWtxdGxVbGdHNGxHRko0VUFFdXhYYUNtODhZa2Uvakt3SjRwNFp3a1dj?=
 =?utf-8?B?d1NKeFJwaUtWYXNaMWxuT3lMWnQwWmh4WC9WdHJUZXRtZXZXVEVaaTVNUjNR?=
 =?utf-8?B?VGxEU2xPRmdTemY5clN0dlRFcFE5SllkNTZIN1E0WFkxa1oxZXBvM1dEbTE4?=
 =?utf-8?B?b3hhZ25PL2c4eEJEK2pIelpOd3Q1RTRqWEF0dERVVlVBeitDR2QwUzRkcmlU?=
 =?utf-8?B?cXpUZ0VtQjJTVkZYWWRvUytGdVBxa2dRQVU3ZkRBWGNwUXZKYlpuTENCdmNK?=
 =?utf-8?B?b2ZiczhCRlViQlV4d21EdmZPQkQ5OXVhMHJvbVFTQXYzemJ3VzRjVWRydGZo?=
 =?utf-8?B?M2JDdjJDZC9YczFyL2tLVmYrQVZjVG5VQXkzTHVlV05lQUljV0EvUjk1aTNG?=
 =?utf-8?B?UWpvU2xnMGVrZGNhaHI5Q1pkbTlYRyt2aldFM0lLOFBKN1BZZThJZDJCMW1V?=
 =?utf-8?B?azMrRytSYWdCd3pBd25kcHBUeFRFMzFkc3BsSmF6NEFoZW1HMEZRMHZ5YzFh?=
 =?utf-8?B?UDdMV1FiZkFMOHBNUm9aR2lYaXJYUHVaVlNiNDZVM1RERmQzNDZjcmx6V3dz?=
 =?utf-8?B?TTlPczRsV0tvYmFxRzBHRTZsdk4rWEhNcm1kNXBmSmxTNDZSYUhpZUFzdmxZ?=
 =?utf-8?B?eU1yY3JxZ2xheUhNa1oyRTJXVmJtSUhPb0FhUk5jV0FmWm9TcWR5MFlROFlU?=
 =?utf-8?B?VkJHclkvQTdIaWJ3YzRaZ2N0UStCdVIwbUZ6ZEFpdG5YSis2aERhQnFuWExn?=
 =?utf-8?B?N1dDaThWNUtVcUVGRXBaQ3FjYkVtSjZwZW1XRXNpaStpampqK2Z6ME9Xb2xD?=
 =?utf-8?B?Z3oxWWhkV3lxenV6ZU9reml0ZW1IK2Yrb1FxR2tiTi9xQzZYZDA0Y25vVkY1?=
 =?utf-8?B?OG1UVzBWckVsT0t1Q1FQVTgzTGt4b3ZJSUJGSkZzelJYekhKM1I3OVphbjhs?=
 =?utf-8?B?SHRtUHpqRGJtSms5MmIxYmppNWQ4aXh1eHFxSVh4YUNhNmtFZW5mYWQ1aHNw?=
 =?utf-8?B?aUlFZFUrQmZiVnhrMUJ3ZWttcm0zdy9aenU5RWpqNHlIMEJqS3FDdEZKY216?=
 =?utf-8?B?WXdPYzRBUUljYnR5NUNXQS90R2daTUxJWjRKazlxdlV4M1k2RkdpbVJoUXIz?=
 =?utf-8?B?K05pTDJCTVFBcVZ5cytLS1RKS1g0NFhFTzM3M0lOVnd1NzVNZ0JiaWtrWDNs?=
 =?utf-8?B?VHRKLzdCVUVNSWFjZTlma0tKeDFtMlczVmhsd2FBUDVLZE9ybmNjNGR6TFZo?=
 =?utf-8?B?VTV1eFp1aWYxanRyNk1DRUc5MzUrZGJ2RFI3SnpWcDZpVFlxRm1DS2hPZFhr?=
 =?utf-8?B?V1U4Tm5hWVVKbm1xZnRYWWZUQWRIZDkybzF6WFZBazFSYmhQTW5CSFAyRCs1?=
 =?utf-8?B?a0p0U2NHY2loVVBoWTBYenk1QlY0Vks5Q0laREJsVGRiSmRmZEpUanE3MkJ1?=
 =?utf-8?B?Z2kvQndMZGkxc1FBTmpieHdxZkllQzFzUUdyeFE0aDVrZzM4dUY3Z3RCaCs5?=
 =?utf-8?B?NDR2VUw4dzVEOUd2N0tOd2tRUGdtSW5YNUJLemVzbS8rT1RwNEZaSURveDN5?=
 =?utf-8?B?ZURXSTZWdWlRZld6YWtTbW5JOHhSODRFODhWb2xIWkNQME91RytQMmxwVCtD?=
 =?utf-8?B?czhIV1FYd0RBeFVyVnlHWGxsNzV6eTFBbFBCK3ZrdFZpUzVNMEJzYTRzLzlZ?=
 =?utf-8?B?NmcrTFFGclhVYktUZnBTTFN4b1gySUJTeDlFOVNZazloLzZNTXdQSjZxZzBo?=
 =?utf-8?Q?PGUlXc9cWM66XS2ZGbvZCjh+HOGcZb87?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVmd1hUOEJBeFg3NmZBTzRZU1V6TnFwZklwMDJ2OVNzVnNOS2RCVTYxV3Zl?=
 =?utf-8?B?bGhWM3BHV1NEK3ZSMjNaeHgyczYwTE0xSldsejFlN2ZJN1dKRU1vN1JoKzdY?=
 =?utf-8?B?SHdPT1Awd1V5Y0pmUHJoeDdhU1ZSQWFKdWNQVnZvSWttRVFCSk00c0g2Tm10?=
 =?utf-8?B?RUp1c2kyT003dG4xdGpxaEo5bm1VK2k3SkhUVkI5WnczTW43N2x6dTdsL2ZS?=
 =?utf-8?B?aWd3dm5JeVpNV1NHc1VGeVlYd1dRVFgvbUUzaHU3d2FPdE80bStnamRJT3h6?=
 =?utf-8?B?V3laNUxLaE9lOXoveDhrNVlzM2hKcjJrQzZDcERSOFRpK0ZkQ3BpWmFRNG82?=
 =?utf-8?B?TFlqWWdYYWFoUTFmbjN3MEhvNHp1eTRkMjQzOWQxcnRQd243QzdFQW9nSVA4?=
 =?utf-8?B?azZnZVdlVjlCZ1ZqVzN4eTl2QlYzSm5kdUxGZkFkNm5VQ0U1dnh0SGtZaGtn?=
 =?utf-8?B?RDZYeVpHa3JNMnRnN0hXWUN0RzZoelR6eTRwRjhQWldVeFpHNWVLRGJGNWU4?=
 =?utf-8?B?Zkx1S3Z5cDRJbFk0YkZiVUgxWUFjb3J0R2lCYjE3YW9FT2c3eVM5NHMzUndB?=
 =?utf-8?B?ZFdPRU9CS3hOWEJGRm45LzNzRWxJSzVnazBZVXJJUUlDaHlrbytRMHNlZHc1?=
 =?utf-8?B?aGNGOHlvSGs4K2xKSG03ODdMc0l2ZmI5U1BGYzJmTXpKb2ppYWdKekVMOGR3?=
 =?utf-8?B?QTFQZnlDTHNMTWVyeGVZNDFBdStNSnNjUjQzRUkwWFVjZzFCc2ppLzEvSitp?=
 =?utf-8?B?d3UvZEw2R2puVGZpK2FUdWZOMEhRb0RFUWhMYUFWeUtCNlE2RE1SNUhtSldk?=
 =?utf-8?B?bFFQeXpBM3VqMlhHenFEK0JCblNOWWpWaUwrQkJkZ2l6dTlJMnM0ZHlEQzVK?=
 =?utf-8?B?R1JIU1hHYzZQcnJxRlZ0dVo4RDh1OFhUTTFGU2VOZXZXSkRJM0owdCthTlhG?=
 =?utf-8?B?Y0ZpWGY4cTRvV2J6OWU0dFlYckdBUXNxTzNFMCtoMTFEb2RYUkZoMUtSYnhl?=
 =?utf-8?B?c3dHbE92b1BrbWtFbkEvdHNwN0JvbzdMMjloZi85VWFqRUNuTUZZZ3gzMmVI?=
 =?utf-8?B?T2R2azZVZHRhemNRK3IvTk5qbjhzeGVaNEdWRWZkWkZQNWRramF2TkMvSmRt?=
 =?utf-8?B?cDBmbG5KQm02UkJ6bHRaRkV4RWFocm0wc1ZSL3ZkZ2JFd2RoVEFvd2RkeXZL?=
 =?utf-8?B?NkwwWUhKbFc0aUEwNG05TTB2aUQyOUFxK0RUU0hya1FMd2VScWFwTE8wSWR3?=
 =?utf-8?B?UkpNMXdPS1R4SXM4WllNREVyWi9JVFEvS0xVVkRFZXczV3poZHMxNDNQYnNm?=
 =?utf-8?B?VnY0b1JlV3EyaldQc1pqMWQ2RWNSdFV3UHJ4Z3dLbTZDRy80eEc1dkxObmwx?=
 =?utf-8?B?bjVjTTc1RjdrK2ZtNWhNYWZHM2dxZkR6QUNQeFpGeForWExLaldUOUtlNUxv?=
 =?utf-8?B?VXdJK3pva0JpZmlGMGdHSVBzODVjZDRDU0NONHNTT0U4NWlTSExLTnoxV0xo?=
 =?utf-8?B?bHJhQ0hwVzNtTTBLWnZjSVVUZWgrcGpHb2ZjRDdacmM0OVBqWE51bHpPclFt?=
 =?utf-8?B?dDdWRTdFa2JyMmZUS2ZWeGdqK3FiSlpSSzcrZzRBd2tmZG5TSUhNN1lVMlhJ?=
 =?utf-8?B?TUVvWTNyelRwVGg3NWlpR05PL0MyTjN0cGJPYXFOMFVmR09EZDBpak0xQ1VF?=
 =?utf-8?B?Z2s3NmZSSy9kaDk1MHFIYjk0RHJnejBnRXBSSVpPQzJSQ0VJcFpydzJzSUZ2?=
 =?utf-8?B?RGZHT0o1TW9QZlUxeDh5M1I2NTFWTzlPT05qL2J1cHNPNHRQczRwQjBUL1FW?=
 =?utf-8?B?U3dQNzhJbkFtR3p4d3BpQU11TnRyYlhIS3Rkam04UjBHL3dUUFJpSkFrQ3A4?=
 =?utf-8?B?d2VRV0F2QllqYnBXS0lqY2NqdmpDZ2pxc3hNL1RsVGlGcEhNM3JXcytBWEc3?=
 =?utf-8?B?Nm1Ia01STXl4aTJvNEJpbGpTd2tVLzlZMDBRanRQSFVFOFNJTS9kaklDWnJ5?=
 =?utf-8?B?Y1FMRStRYnJIZHZLdStFa0tnVkZzMS95WDdsb1RaanJUZG5vRGwyNXh2aWlF?=
 =?utf-8?B?U1dXdy85SUZlYTJncTBYV3JtS0d2SnRpMmsrSjdLNGdlSHQvR0FlSFlsR3RB?=
 =?utf-8?B?M0VjTHAvU01VMG1zYU93aFlZV2NNZkJCQ1IrMmh4MERNRTFHQkk1ZUllNllo?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b53a4135-9b08-42c1-17f3-08de11b7e57a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 22:11:06.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj3oZ3bh/2sTX4H3U8Dq1RalW+PI1SxaIlR64nPOK4SvQ7YBmzM5jGbTAotVX/KuqYkVU6HrM06dV+rw4yMm8xlZgOi+c8DPTiHxCcXuQoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com

--------------UpNwEaqRpaBjfpkPAKBspkxP
Content-Type: multipart/mixed; boundary="------------Tdt62SHx9sYRH7w045inu0Om";
 protected-headers="v1"
Message-ID: <9604cc84-4268-4964-a4d9-2d37ea095138@intel.com>
Date: Wed, 22 Oct 2025 15:11:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Heib <mheib@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
 <20251016-jk-iwl-next-2025-10-15-v2-2-ff3a390d9fc6@intel.com>
 <20251020182515.457ad11c@kernel.org>
 <d39fc2bd-56bf-4c5b-99a2-398433238220@intel.com>
 <20251021160745.7ff31970@kernel.org>
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
In-Reply-To: <20251021160745.7ff31970@kernel.org>

--------------Tdt62SHx9sYRH7w045inu0Om
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/21/2025 4:07 PM, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 13:39:27 -0700 Jacob Keller wrote:
>> On 10/20/2025 6:25 PM, Jakub Kicinski wrote:
>>> On Thu, 16 Oct 2025 23:08:31 -0700 Jacob Keller wrote: =20
>>>> - The configured value is a theoretical maximum. Hardware limits may=

>>>>   still prevent additional MAC addresses from being added, even if t=
he
>>>>   parameter allows it. =20
>>>
>>> Is "administrative policy" better than "theoretical max" ?
>>
>> That could be a bit more accurate.
>>
>>> Also -- should we be scanning the existing state to check if some VM
>>> hasn't violated the new setting and error or at least return a extack=

>>> to the user to warn that the policy is not currently adhered to? =20
>>
>> My understanding here is that this enforces the VF to never go *above*=

>> this value, but its possible some other hardware restriction (i.e. out=

>> of filters) could prevent a VF from adding more filters even if the
>> value is set higher.
>>
>> Basically, this sets the maximum allowed number of filters, but doesn'=
t
>> guarantee that many filters are actually available, at least on X710
>> where filters are a shared resource and we do not have a good mechanis=
m
>> to coordinate across PFs to confirm how many have been made available =
or
>> reserved already. (Until firmware rejects adding a filter because
>> resources are capped)
>>
>> Thus, I don't think we need to scan to check anything here. VFs should=

>> be unable to exceed this limit, and thats checked on filter add.
>=20
> Sorry, just to be clear -- this comment is independent on the comment
> about "policy" vs "theoretical".
>=20
> What if:
>  - max is set to 4
>  - VF 1 adds 4 filters
>  - (some time later) user asks to decrease max to 2
>=20
> The devlink param is CMODE_RUNTIME so I'm assuming it can be tweaked=20
> at any point in time.
>=20
> We probably don't want to prevent lowering the max as admin has no way
> to flush the filters. Either we don't let the knob be turned when SRIOV=

> is enabled or we should warn if some VF has more filters than the new
> max?

Ah, yes that makes sense to me. I think the best approach is just return
-EBUSY if there are active VFs. We could implement warning logic
instead, but I think most of the time the administrator should be
expected to configure this once during setup (i.e. a boot up script or
something), and not during runtime.

--------------Tdt62SHx9sYRH7w045inu0Om--

--------------UpNwEaqRpaBjfpkPAKBspkxP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPlWeAUDAAAAAAAKCRBqll0+bw8o6Orp
AQDsV/Tp/yMq1orJNj92bfC2RuvliBLjCawpEMgzL40iOwEAinDSIgYF0W+NkcwPnWfINdm7yVb/
gYHAgx4v+BmFbAo=
=b4Gb
-----END PGP SIGNATURE-----

--------------UpNwEaqRpaBjfpkPAKBspkxP--

