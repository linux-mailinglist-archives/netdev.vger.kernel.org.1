Return-Path: <netdev+bounces-220519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A227B46780
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C310A189D091
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489D482F2;
	Sat,  6 Sep 2025 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+pBP6q3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AA2E63C;
	Sat,  6 Sep 2025 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118249; cv=fail; b=agLI7WIHns/b5z6Ft6W/04IjHjl/tlcAEPmqiUhPoNDwFSl8T/x/cZqS2Mu1CBWP5aKXeSzOn/njcu0QLJ1g7BW6rPfs4i1zP9wKAPM4JrgOt8N3x9R81Zqrgx9drK2sv2/SNc5NWkkcvdD/bpI4Sis9KpGrI/+mI5dnaMa+dyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118249; c=relaxed/simple;
	bh=OyXuEPmuetewKzaBFUkM8053Q0rhrf/CQRYVQH6XluM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PfVLivarylTpbfgMyGyUSiZHJczsaFWPygdRG/8oQkXKe0DsWI6qzcFARdQzRRv45XHvagclE7421/KZZpWvz+bMUDpgnbl7lRvio8rEh1dX8xa6PHrgT0BvDluPXzTOu22k+VOFcq+9gdy4nowW31GjF1ffzPuJkjlS0XOkjqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+pBP6q3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757118247; x=1788654247;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=OyXuEPmuetewKzaBFUkM8053Q0rhrf/CQRYVQH6XluM=;
  b=J+pBP6q3RZzhIYFVq/FYYpr0LFEtcUxIUIL4KYpGFTxPjgq1N+l51tuZ
   CRMbRxPQ39BQ4nKvWdQZbs6gcK6daB+FP/+H4SOIUWqFu1GTx1EEgE+mO
   TqMgf7CgHkTXLTJ4so2WTsCf8VxsSvIWXpDcQ8phYN6ziiLv4kResIey3
   Y4zAxecm8EUwo3b00p+bb4MPsIrLYCAOUnAnYXu/F+NAW/liBSZJVkDcD
   Mg+H+7QpHtbMIP1DfmsQ2dBKvMY35tXP/Gv9q7RnUx8QMoTJBDsoSXtVO
   /6LZSlFmBdwstqqMupMBlqS5HLfU6rK4E0pKH4YRZId6hxl1cqWlGGBDH
   g==;
X-CSE-ConnectionGUID: UOFvdggHQzW9g/BpGV/7GQ==
X-CSE-MsgGUID: Q8hUcpIETlWez8GzWOGfOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63300846"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="63300846"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:24:07 -0700
X-CSE-ConnectionGUID: iuF/sthMTNKTYONyJeOCdA==
X-CSE-MsgGUID: 2n/LsPyeQ+aaAD/Ert1h3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="176612963"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:24:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:24:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:24:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP0ZIU8UhUmQPzfxqINNHksV400pDsUvRRU2SkKTLks1V/tLAB/DLyhFhgX3GV8seLcX1CuKwlyr15K6MeYvD1UOVZXAFVE8PozxYrk97DO64cEp8rQPVpQIaJz1Q7Fw437Zsx5rESrMdN226J3lze6h6D7outiwI202fMSUurxbbbt691aNSqHYNrbOHkfso/YrO1jRPPHmzJzUIglOMYvhNpmUtIKKKg1fMMBrIgqaetMKFEWw1U5qFFMggaFzPUrLuDSYRGmdgpy/hkWsEUDF0ASrAJzhJBD/IP0JgbyUh2g9HNxdu+7L2YGAC7Bp5RlB1bpW1EntcrSYShDq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDkDVmo/qROFOjCgvD7k6b5GDi/kYKgX3mhh1eGN2/I=;
 b=yMJmHb6/LmQZpoOCxQZi9wAu7s6tUa2Lp70a21h3i73rRWPjUTO4x7c7nfZBSF0S3Ubu2lyTk24inXOLsY8bz7J+gHcOiXEjiPAtKdDoIgbpyOLIF11W4rYSiN5zHD3q36cZjiwn2OFxBB6pSqtU340+Fdkn8ULV5DlbrGcLu65e5h3cb7ibojggf/RB+ryeNPOSow4qeGg+Ng6GPgJDiLvRbh8ZKS3jESVtwiFeqdWTEllyRvND6dCpDzVGvsTekLxBuvUXN426paAknOGkC9HgeuEsw7A3YxLsKMpSI25jh5lLzBJA4It0VaxcW1DP6qh7np70ak6F1/IVpe99mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 00:24:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:24:03 +0000
Message-ID: <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
Date: Fri, 5 Sep 2025 17:24:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
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
In-Reply-To: <20250904220156.1006541-6-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------k23QaK08ek3XSWcyOlWrSSV7"
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 27946b92-9950-4367-ea36-08ddecdbaf1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjZIdVdEd280c2Zqa0NmNjcxa0VaTHVaRmtzMVg2RjRMcld3c1NDelZsTlFt?=
 =?utf-8?B?bWpEaHVHQ21mWlY2dVNNaDlsS1BCR0pGVEllWkdBTXcwUkZUNUtNN2gyMGo0?=
 =?utf-8?B?T1paS25ac1I4YXBFSkVpQzFvd2lxdHhyMXlhTUx0d0dJTE1VMUtlUUkzYXNj?=
 =?utf-8?B?Q2hnT2tSMzVJYVZQZmhjWlhHTDlrcUxrS0Fya1g3UnZVc0lvdXdVMDVFOTB6?=
 =?utf-8?B?NTNFZGljOHBQQ1hrc0xWSUFGYVlsalpUeVhjUVJTdnFkQWRkT3RHQ2ZWaG1u?=
 =?utf-8?B?SWxJSFJRZ1dpN3oybXQzMGsxUW1OdDBuWXIraVlKUnlpZVU1K3MrcWNFWktv?=
 =?utf-8?B?WU55ZzhYcG8wUzUwaDNsaTIxSU82Y1hlV2hoaERwaHlPN2RVeEVtZHZlL29H?=
 =?utf-8?B?aGpuRnRqYjV0RGlWMmFjMG5kMWFvSm5wdkNTSGt2QXd3SkJHVHd4ekJ0NWpT?=
 =?utf-8?B?MXRPdUhVcWQyZ2NPeVhRZjdlc01hZXhUQS8wczFQZzVwSUd3L1J4ak5YeXQ0?=
 =?utf-8?B?ZVVaUGNUY3RsVm5HRE1hRjI5eUE2dGxqSTFLbU9peVAvNVE2clFmQTlHK3BW?=
 =?utf-8?B?dFJXNThOeWY1dXFOS3dVbXlQSS9PdUNRNVFSZGlYOUU0QXdDNU16eFdSMUdZ?=
 =?utf-8?B?Uk8rWEN0SkRTM2d2SERHU0VYOFlkbFVSOGgvVlYwdmFRS09ka21EcEdrNG9M?=
 =?utf-8?B?cXpaTVBUWURZVHQzb2c3aGw4TWFiVVR0Sm9Ia040djlVS296WlNmeVlDV3JM?=
 =?utf-8?B?WHFVU1ZCd0dsSm5DS3NGdzlMc1JDS0tsWTRLL2hWU1Q4c2FkMlI3bjJyV1ZM?=
 =?utf-8?B?dFhQdVRqd05ES0dEV01jTWhPeTdaNzB5bXJrdVRTTXJoUWlvZVB6bUNsb2g5?=
 =?utf-8?B?bWtRVEw0ZTZveFpKem5Ia2NkY003YW40L2dCcHVlWWpIaERmSTYwMjJzdWJt?=
 =?utf-8?B?SDJTK1Vvd2x5OVpOSmFqNVl5aWlxbHpGQU5wMXQxbHR5OFMxeEVTR0NZWTNR?=
 =?utf-8?B?RldHK2pVWlJQSmtQd0hrTVJWSVRuOEs4eTVLZ3dCS3RxK0hYUVhrem9FVXNt?=
 =?utf-8?B?SmN1V2JYb0dIRzZIaTI3bDYvZUdSNDhFUU9xclYyZW1VRHhIMXBtNjYydk8w?=
 =?utf-8?B?a1FDT01RUzJtRlA5Tm9XVWhkd2RmYjMzcmR5djdkd1gvOGt0UCtxSWQ1SGlM?=
 =?utf-8?B?bHBUOGNXMmlUb1ljS0tiZ2pJaTd1OFZ4eEI3bGlGS1RESzhwSm4zUlpGTHpt?=
 =?utf-8?B?eHg3aWtjNDMydk1ZT3lXMVRhWkdEdWdsUXN3UFZZd2ExZmlUdlVSZWtybFpl?=
 =?utf-8?B?TEVzd2pFZTRacDNlMnZYb3BqaG9lYUpjYnJCT1dRb2djVFlnZVN3dS9XSDhW?=
 =?utf-8?B?SS9OZXRnWXNNQlhzb2FISXFsZDdHNURpSTFYcmJya2Fla2t0cmhtUXJBMys1?=
 =?utf-8?B?bGh0Vlk5TnU3bm5KTXFkdGhoZ2w4M3hwY2F6SU5EV0hyZ2ROVUxvQTJMczI0?=
 =?utf-8?B?OFN4VXFOU3picjB1dVYrOFBoTk1JdUEzN0lUdWpXd0pGQjVEZmRuTmNqQ0VJ?=
 =?utf-8?B?QUFJYmJuZGRpWk1OVEtMUnVVTEtCZnFDWG4wM2laZzBmUCtKbFRIZDl3K1o5?=
 =?utf-8?B?alJlMndrYXRkUFE5WVQwL29DeERtS1ZsaGk2Vlk3R0xORDRXQ0hCeEJodkVN?=
 =?utf-8?B?dXV6YzVpTUYybmdJT2loU1I4V24vK2twUzlJY2w0ckZ0N2VyeTNJa1A0cmNY?=
 =?utf-8?B?NHd2azNkaTh1V3BEWXpGRTU4TmpQckVrclhSSTFjalE1bHdsbFNkK0R4RFBP?=
 =?utf-8?B?UW10akI2V2FCOHhiYk1hY1RQODRVVlNRdzFWQ21obDRkOTJFTGR0UjA1Vjlq?=
 =?utf-8?B?VHdIbmd2OUIrZUxIbmlDYmx3VFpJczNhUDQ3anhaSjh5NFN6cUJHQUlFQWtK?=
 =?utf-8?Q?MPqv8wK2jCQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhyKzM1ajBvdlFUM1ZodU53SWRpTXF4Q2VieHh5Y21vdy9BMUNybTU5N2ti?=
 =?utf-8?B?c1hmV1RvZU1OSFdTL3dsL0tLdGtTR2tpYWRFWmNGRjZqS1hWVnY5RzBXc3hC?=
 =?utf-8?B?ZHpacmJXQ2Q2bm5FY0MrWXRUUmpRRkVnRjJ5VFk2N1N0Vm9rVXhtUjZHdjZE?=
 =?utf-8?B?aWttQkIrZnEzK3pvTVU1TGdnNE1NY3Ara2hwUUgxU3hNZUtSdnBBN1hYS09y?=
 =?utf-8?B?RXlZcytvVjZWamdMbFgrMUN5ZmFrb2tlNWQ2ckE0WUF5Ym4yNlN1a09kSzlM?=
 =?utf-8?B?SzFJY0lEc3N6YzlkTWsvNWhMUDRWQ2ExdWhmVXhPYU9qYytUdmpGRm1OdnNJ?=
 =?utf-8?B?b3lxbVFrNXUvbGcyYTlVSXNPeXNGbUc1RjYxcEUwUXRPcmxDdnRtbnNVazJM?=
 =?utf-8?B?eVVhWHNhUFNFcVpZdmQ1Rk1JUlVQSWwzOEZYank5NUJDZGtmRmVEcSsxRHo2?=
 =?utf-8?B?bkZDS2JMdkwwZklPa0s2MGE4NmpEWWJIaW1tWThFa0VkSnN3QkVXY0ZyNWxW?=
 =?utf-8?B?VDcwQkI4WEJ0UEtoa2xOY3RKaEc0NE0zZnMzOXhqUHdCZS9tbGxjbXQyVVo3?=
 =?utf-8?B?a2dUUGR0b2l4OWdUUlVERDNpaEdhRGtCbW5aODFUUWdHRGY2LzJsL05xTWwr?=
 =?utf-8?B?VFErZTdpRDc2bGh0L3h3VHJvaXRMakxIaGJGN1N5cHhaZGxRQ0VQenZkc1hx?=
 =?utf-8?B?OUJoOWlsd0puN2hYaUp2WHhRK1NudGpTWmNyM0ptWkF3NlRmeG5CZ0d6Vnpm?=
 =?utf-8?B?WUhuRGU5TFlCR2o3UmtuR1lxdVhYK3UyNjZoK2N2V0ZXbEJGdUY1LzQ1M2lT?=
 =?utf-8?B?TUpnQWQwQ0pkOTNkTVJFcUpPT1liWDBOUjNObmRuQ1F2ZlNKKzV6ZWxlQzdq?=
 =?utf-8?B?YWxJNkt2bkd1aHEwVVBPUWFqQmlJZmFlMDhNYm9ucTRXWEdMQ2lVTzhjS0JO?=
 =?utf-8?B?QnBQRHVxRmtCSTZ2MmhhZ0I1VzNhN3ZYeFBXN2pxUHlHZ0QwN1BDRnYvOFNi?=
 =?utf-8?B?QmtSOEpFYVY4c0lRUFVMdExZb0F0cmVyUXRpU3Z1RkhyRjdoM3ZDVGVEbnFL?=
 =?utf-8?B?dXB3SVlmbHRNeXpmRXVjcmJma3gzOWp4WUF0bGdlaGtOU2U5M1JJYVJkU0JF?=
 =?utf-8?B?WGVkNzhHbUhVV2lGNkJQcmxnV3hCeCs3c2lDUzNIRkptV25tMUVBY0xib2JV?=
 =?utf-8?B?dHpTa2V6T3gzY3E0WVdQMGREMG14QXZvR2VIU1RyQTFlSEdCY3NLckt4Y2E4?=
 =?utf-8?B?TDVRUkhNNVcwcWZ6SC9jMjFYYTN6Wk1DL2hkMnlaL3hENzYxVzlYNktsblhi?=
 =?utf-8?B?d092MUR0VDNXMW5CS2xyS1hKdXprU20rNEM2UUJ5Y1grR1V4QWN5VCs3YjNM?=
 =?utf-8?B?V0RnNWNEa0ZzcWVuNkRPWDA4bjNoS2x2RW80Uk8wU2RwQjhLYXgzRUVDZFN5?=
 =?utf-8?B?YnJ5TDhQdlpHVWk1MjFTQkNKQXE4aHBEdW1tZ3ZjWHE0T2JNSlBvVklZYS9Q?=
 =?utf-8?B?UnhPbFIwQW42eWpCekQ0bkhlNGZmTjdWMkw1cVdwZmVVQlB4V2ZaOUwrRUVH?=
 =?utf-8?B?cURxVnF5M3BhNkZ5K1BEaVZuOVllbml0dnVtR2xPV3dUSkNScUFmVlZYRjNy?=
 =?utf-8?B?RUl1OHcweWszc3ZSRmR2ejlSYkgwNjZ6VloyZUxuRW9iV0xMcFZ4eGV6QXE5?=
 =?utf-8?B?UnZqSEJaVThzaU5vajRtdlNIVU9oVTZ1dElMK1RJbU0rMjEzdVd3TTRySEtI?=
 =?utf-8?B?d2haUWtvUHhrdyt6S0VaWlB1dnQ5UytJQWgxbnFDd0I4bSt2OUlCa3IwZjlI?=
 =?utf-8?B?QitjZVhDY25uQUdRTTJQaFB1Ymorb2prNzR3YmMzR1IrOWtmZXRxcHQ4d2pY?=
 =?utf-8?B?N3Y1Zll4ZU5iMXV3ZjE5NG9vSmM5eTM0T0FzWDUwL1FxNTBOMmMvT0cxdkJO?=
 =?utf-8?B?TFM2YjVJbkxvVTdaTDBvbjBZWjRuY0lqQm1UOG1FSnhXc2JhdEpzSGVONktH?=
 =?utf-8?B?c2tOblRrT1JkbG00SU1WblNXcW01NnV5bjFFVkFhM28ycGxyQUVyNlYrYXhT?=
 =?utf-8?B?VnBEVkRIZklWVWVwR0gxSTdnTy9adTg0WjVuTjExOWFXVzJ0c0NpOEpQQjBB?=
 =?utf-8?B?WS85QURzQ2JCS01PeFZRYnpSVGZwaGJqL3hzS051TzdYdzVVajM1blQybEtS?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27946b92-9950-4367-ea36-08ddecdbaf1f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:24:03.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEClMFL8/yMa+dfyfvy8A88KzURfpRPOpTwI0aIRLfmcdCfqMdOJ0ycGRBaXYuF8IM63ItJkL2jgvnI1jk95Na0VVMyqYrmqkNjx6mKuCUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com

--------------k23QaK08ek3XSWcyOlWrSSV7
Content-Type: multipart/mixed; boundary="------------Iq2MABpsy2pnGUUa50oAtFm1";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
In-Reply-To: <20250904220156.1006541-6-ast@fiberby.net>

--------------Iq2MABpsy2pnGUUa50oAtFm1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> In nested arrays don't require that the intermediate
> attribute type should be a valid attribute type, it
> might just be an index or simple 0, it is often not
> even used.
>=20
> See include/net/netlink.h about NLA_NESTED_ARRAY:
>> The difference to NLA_NESTED is the structure:
>> NLA_NESTED has the nested attributes directly inside
>> while an array has the nested attributes at another
>> level down and the attribute types directly in the
>> nesting don't matter.
>=20

To me, it would seem like it makes more sense to define these (even if
thats defined per family?) than to just say they aren't defined at all?

Hm.

> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl=
_gen_c.py
> index e6a84e13ec0a..3c0b158c4da8 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -834,11 +834,12 @@ class TypeArrayNest(Type):
>      def _attr_get(self, ri, var):
>          local_vars =3D ['const struct nlattr *attr2;']
>          get_lines =3D [f'attr_{self.c_name} =3D attr;',
> -                     'ynl_attr_for_each_nested(attr2, attr) {',
> -                     '\tif (ynl_attr_validate(yarg, attr2))',
> -                     '\t\treturn YNL_PARSE_CB_ERROR;',
> -                     f'\tn_{self.c_name}++;',
> -                     '}']
> +                     'ynl_attr_for_each_nested(attr2, attr) {']
> +        if self.attr['sub-type'] !=3D 'nest':
> +            get_lines.append('\tif (ynl_attr_validate(yarg, attr2))')
> +            get_lines.append('\t\treturn YNL_PARSE_CB_ERROR;')
> +        get_lines.append(f'\tn_{self.c_name}++;')
> +        get_lines.append('}')
>          return get_lines, None, local_vars
> =20
>      def attr_put(self, ri, var):


--------------Iq2MABpsy2pnGUUa50oAtFm1--

--------------k23QaK08ek3XSWcyOlWrSSV7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLt/IgUDAAAAAAAKCRBqll0+bw8o6B07
AQCOTQb8Z7IBEcmbiXR0yfQlwMWcgApwy+UDcXwmhoeoGwD/bCsi+hE+fB6/hVL1uX5BekT4c8GP
KnEnu+018Hz+eQk=
=fQkn
-----END PGP SIGNATURE-----

--------------k23QaK08ek3XSWcyOlWrSSV7--

