Return-Path: <netdev+bounces-212305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28CB1F146
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 01:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01B18C7723
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E2273D85;
	Fri,  8 Aug 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hj6EBwtj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0B3FE7
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695550; cv=fail; b=kD3OCjT4kqucxRrD1x+G89XZI7+ZUcDzW2ux/yMvkp18WXQUPGLwOSEVm2oy+zjhmd+T3mgU1cmupXoJy3K4o0IhPYheI728ICoIButwf2lS1z414yhkhpMBJ+Z/UAkGh0TKWhORNh7MHPlBJ3AfUE9hgQURhJ+1KKJlMYqkmsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695550; c=relaxed/simple;
	bh=4c1ID/bWPLi8h0kGsMbohOa6W6L0lXSwHQ2p2brF8TY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBYkjSwSy9Sbw4j1JjpJ0xA++4V89DbQ/d0+cEFnw2TBrbxZKYlVtESU/WAuHXemm5CNrf4PKdR1kOciFciDq+xKcOtwXrtDY5YNvuVY/Q7TLg6XjpGB5Q81jrhLCbClj96lbKsDHfpwAwf49tJGtpZlotPhj5cEoMTYkV0P9LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hj6EBwtj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754695548; x=1786231548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=4c1ID/bWPLi8h0kGsMbohOa6W6L0lXSwHQ2p2brF8TY=;
  b=hj6EBwtjRw9kTYuVY5jTx34fIBv9zkmfUqioU5SGuV6CJnLtR8XnwGh9
   4PxlCKwZsz/tVEvtUhRsHvtBpHYjuyzjcgwCbxvEJ+qNRrGi7FTQuuLcw
   PGwG3TVCeivJKiYmtegVjPsOalbFThWhoVRlCHpepqH8MM6xO/F02My2X
   8VgLC/3U+V8ld0QFfWNs2hnP9uME+1PLhWC6NH8X5y2EaRDwfk3fVgoKm
   1hcRz1+gz3TVQ56yVxuGQs7AMV6tXe1bA2ZvIgaj4D4h+QUkhDYNEfkls
   o32kVCvzHc0GBXNYQ/r6YFIpqJME+PUoKqWwjNVo1q7eGMWytgi4w4vYT
   w==;
X-CSE-ConnectionGUID: NXcwd0EXQ2aL79Ff+kwTlA==
X-CSE-MsgGUID: vE9mUCk0QKi4r7XUzg1FGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60849114"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="asc'?scan'208";a="60849114"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:25:47 -0700
X-CSE-ConnectionGUID: lwizlk2VTp6iQeKSp7cUNg==
X-CSE-MsgGUID: TsN21XPVQh2FtbDLO1Q29g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="asc'?scan'208";a="164664616"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:25:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 16:25:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 16:25:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 16:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHTip7RgJsMexf7CVNuvJMMt9tm5deHuvjyY5ocqf+G0GbbjQoh6vyro1AaaHoWZvu4+JDH/uiK7/FfrmIJeR7i65sViW0cMxpwKxgejkUwkvl9tuwTCIWtxyOkdAkjoOYhfon46EIpRCbMa6O+qMrRogmFZSTvLKtvepySxPkp5fYTNHWxZuezRia7sYuCz/BAQ3MqgJKIHjfcV10cG2KOdcG7RPeSnOV1p2V8rTjmeJ7lkzQMnra0cZeRJGsAqO2tWUjDU4Lpx3+oFit+k9PE2Puu4hzOZHF1c0r2KX74CL2eAbhOVnc4FNVyCfrh7qEh7/V2E2TKb3Gx17ApTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uphyql0Zaeo8BGc0cuRoLpKg0Ne3kwoaspWrPw+gwZ0=;
 b=KXVBUn07OeZkWPsotleHEOTOUden2mQU5OKM9Ji+K8UAESLwyntRZOZCRMKgFhHaKB4rzb31c6QIDe6Gc9D8y+puTLMocGSaQoDlNmTwYGdrTWRp6plR+XMb/t0wRx+I/zgJxrbzuKGf9GvNIJ2FUSJsaOGFXsFrbqjAA4o87+LMtsn+NnOdhDzj3A2j/dH+eXOKZGSAmK8nw3rl3hpbPYQ/0rv9vFZIBpkb8fmTg5jX8sxGBXBwcCdNpKPN6Rg1HVn3nIWqaND2PEiUvyWv7QiCNDwsp1qWmZ/Cm94hsqOd4zJnvS4mKzC0ZRi6J19BchMRVJKnQrGSaPW22eQ4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF8B755DBFD.namprd11.prod.outlook.com (2603:10b6:518:1::d36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Fri, 8 Aug
 2025 23:25:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 23:25:39 +0000
Message-ID: <a3d19fa0-6e03-430e-b3fb-51864f902db6@intel.com>
Date: Fri, 8 Aug 2025 16:25:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation
 failures
To: Michal Kubiak <michal.kubiak@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<anthony.l.nguyen@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
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
In-Reply-To: <20250808155310.1053477-1-michal.kubiak@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------WbGSt30pfwTEtjNxx00qqsra"
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF8B755DBFD:EE_
X-MS-Office365-Filtering-Correlation-Id: d04c8092-dc28-4d91-8e0f-08ddd6d2e286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZ3TnNyeGNVZW5YVThxWSsvbFFSZFozVmpGVVp2Q3NPMHRueEVpL2VLRkM4?=
 =?utf-8?B?VEJKdmZGWnllVnZWNjlxTWtoaktrWERXWGY1ZlNkams4NU41SE1HR3cydWZ6?=
 =?utf-8?B?ZVlmQ2tLMFpYTjMxS21iSzNWYTk3TC9Mdy9jWjNoTGw5cHZUakVyM0ZOc1VT?=
 =?utf-8?B?R0F3b09nYjJCSVVpMkFTVlo2RjhvU3BpejZpa1VJek1lVEVWZElTS3htbmNN?=
 =?utf-8?B?SWRRczdrTTA3NkVyOHg2ZC9rMHZrUU4rTm50WWxLbFFIZ0NaQWpwdEJZRW5v?=
 =?utf-8?B?eVcrMWgybHA2OGxlRzhjZGdRSkR2Vi9FRlA1em1iZ2dNdEEvdGY0aC9CRnI4?=
 =?utf-8?B?RFVlck45bFZ2SGNSSDNlWG5STDAweEJzUUNUNEtuYTRTbEhJQXlsM2NNL3pQ?=
 =?utf-8?B?SU9kcmplSVhnbXE1M2cybGZCOElGOFBUMXZSK1ovK2tBOHd6b0JkNlYyYjlh?=
 =?utf-8?B?OTF0MXU2c1A2NW5yMWpaMnFOSCtyeHZIN0FabnBVWEZrRmpiSVE1RjJNSTd3?=
 =?utf-8?B?cmxNRHMwSy9sS1NQZ1pNN0djUkY4RDkxMUU3UnRFMEc5ejdhelhBT052TzRI?=
 =?utf-8?B?eWtHSjZHa1FLK08zQzhKVG9FcVovbHhYWElGTVZGZk04MjcwMG5OdCttSEtv?=
 =?utf-8?B?Y1l4ajJpZjdjL2kvbmNiN1JiQ1N5Ni9vRWYzREg5ZVd1Z2NWK2J6T2M3Njcy?=
 =?utf-8?B?YUZNUWU0MkMvWUxkSjdLRXlhWDlocjlDSmNhZE5TbVBHNTk5d1dmZklRZ2VT?=
 =?utf-8?B?b1c1aGxZLzVUcUQxbW1CM0dPaVlsaDhiQVpvSTZKR1FaeWl4anlxa3NIdXFk?=
 =?utf-8?B?V1JBRVNycEsxYlE2TnVHZVBtWnJZT2FSekJ6Q2JvOTgvOE5OL3hvVnlqdzZl?=
 =?utf-8?B?bjhqcWlMOCtlZEoxMjVNQU5YMkIySmI3WEFTbzNWWlM5L2xJeiswOER3NVNX?=
 =?utf-8?B?OTlCaWxTZERoZDlOTGRsMzZkdUZOdmsvQ0xmb2dmcjF1Qld0K09SUUROK3J3?=
 =?utf-8?B?MWZKUjZLUW83bUVaM3hpWFV5M2dPeWQwNkRBbkZFYURlNlQ0WmI4eGJ0WGNO?=
 =?utf-8?B?K25HZFovUEp6Y3FYcGFMNGZzT3ovdUIyQzRYQ3NtUkdTc0Q1M2tZQzhzd2Yw?=
 =?utf-8?B?YWpRamJyNUQwOXJudjVmYWZ6aEpBelZSNlJ1YU95Zm00d2VXT1cvNjN3TGpB?=
 =?utf-8?B?SzFqSGN0TGx4NzJrWUN2NFRzakZ3TFRZQXZ4OXdPYTdvenZ0TXBZejd6ZFhO?=
 =?utf-8?B?dWI0QzFYUmJmbzFwaEFTYUNyYnRPeFBmeEpxcXdPc0RlK1gyb1VzVmg5eVVT?=
 =?utf-8?B?SVFON1Bja0NyeUE5b3M5NTRLMFRDQ2hSUWRwdXJsSG41b2FoZjhyczZtU3I0?=
 =?utf-8?B?YkQwTGZFKzhlNld3K05pVm0zQnRWVDltMUc4U2ZuMjl3U3p0TjZaejl6K05q?=
 =?utf-8?B?VmROdTJYOVVxSEp1b1l2RnhhVTNnUXFpYXJJZUVGd1ZOeW1GWk1qUFlWaTJ0?=
 =?utf-8?B?cUZocyt2Zy9wbytiZlgxbERjd3VOeS9IcEY1R1N3WHNybVR0a1ZFeURTZC95?=
 =?utf-8?B?Y2F1ODZ0VUlvYUhHS2lYeElkdlh0SnhnbUZxRU1tWnd4WTdSYk1iVW9FMjlo?=
 =?utf-8?B?TjlrbU9tbm16QTRZaDNuVjRGckdmMkhvRWYzS01tcE5QSUt6U3BoUXhQMWhP?=
 =?utf-8?B?cVl5d24rTVJBclNTQ0JQZDVKWlRIWld5bXdKZHREVWp0T1lZL2ZQdjFkRmlQ?=
 =?utf-8?B?ZUNGQ3F6YVlGVklJRTBzOWlTWmpJYWNvTkVqTzB1a0tGOEphVVlsZzZyV1JV?=
 =?utf-8?B?cjZwUE5ESWxOSUpVS1o4Y3Uxek9ROE1Qc1FXWHJ2ZDF3TVNyc1JpcmxTRGU2?=
 =?utf-8?B?OW1RMzNRdXRETkRsckJIQks0QXJROEYzTDBxUWpaMnhVN1B5elRZdU81TURo?=
 =?utf-8?Q?3KtJH5J4ZwU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRwUkk5YzUycW5TWC8vWDgwVkdYTUpSb1QvbXR4ZkR3WXJ5djRyTW1hZ1Vt?=
 =?utf-8?B?VHU2eFJhc0FrK1J3ak1sMlcxcFQyTkNFYXFUQUVTdjlvdUd2VGxsc0FrdWRE?=
 =?utf-8?B?Tjd5ajFTZDNEeWU3anRiWWRBeVozc1hjZnBlMktpVGZxa0ZVekd2L2NZcXc3?=
 =?utf-8?B?cFpiQXVPOVRZNWdrT0RNc2pJc2pZdG1zZVdkVHVOZm9xUXk1MnZDUThYVDU3?=
 =?utf-8?B?NzArcUYyb1dUZGp0ODBWYUU5V3ZUR0ZOdExEREtVU2xacWQxVS9KK3lVRUQx?=
 =?utf-8?B?QW41TG1SRkRuanVjSmFnK3kyQmljMmNaaTdqMlNkYlJ5R2JsaDVPRHJvV01l?=
 =?utf-8?B?VDkzV0pJcFRHOW1jQ2VVbUhla3dranVEM0QvTEZGdEsvcEY4SGVORFdWQkpq?=
 =?utf-8?B?RDZwVzgzWFdnQ1Y3SU02TzFoaElZWWVsQVovR3F0ZnkrU3lleU0yYXRtQ1lx?=
 =?utf-8?B?RmRialhQdDR0UWtrYXVTZHBtN1h5Z0tDR0djSTV2RDBTTnhKZWdKL2hIT0hF?=
 =?utf-8?B?Z2pqRXlySW1qb1dEaityOTY0dDRjMzRhVGJmOWVsSzA2c3VnL1FSNE8wMFg3?=
 =?utf-8?B?c2tQaUREVlA1c21JWm0rRXJFeFV6bzZ5RURqQVo4U2IvR2VBdkRoYUcrLyta?=
 =?utf-8?B?ZnpYYzdzMk9tUXFhakRwT0hQM0ptdkl6eStzdUxXZlNjK1hHSDloVURXSVlJ?=
 =?utf-8?B?YW5vd3lielZ6NzZjaFNoUnJ1WEJKSHJERm9IN0lNazNadVpGaytWWkZobkF4?=
 =?utf-8?B?OUp4b1dXcmtTV25YSmUvbU1mRVcvcjBpSUxxUFpOeWRVOXhWUEZ0YW5BMnk5?=
 =?utf-8?B?R3VxR0x6bnBncmh5RUR2TUJJclBXa1UreGFLKzZzM2RPQTB0Z0YvNS9RTTh5?=
 =?utf-8?B?VitlN0xpT0g4SENjR0tlQTR0c1lFZSs3WjkybGhQSXk1NFF0Y0hSaWMwNFNu?=
 =?utf-8?B?QmtsOXd5Q3VzRzJCRmNoMUxScGhUQWprd1VMQ0oreEZNdTZ0NGFiSXRSc2FX?=
 =?utf-8?B?RlVPNkpWZXBxVFE1UldXTXVQZUJBZHJYRlVmSUI1TER1dTBlcFBHUFFCc1ZR?=
 =?utf-8?B?TEZ3bWRRWnZHbDVkQW83YjZrdmZGZkJFRWlyYzloK20waThlbTVTMXRBTmE4?=
 =?utf-8?B?NkliN09NUG81dU1wYm91YmhTamVqUkMzQTNvQ0hUU0JCUE9YVHE3cTQ4bnNq?=
 =?utf-8?B?UHhlYXFlTFVJKzg3NWRWSkJtWktZMjRxWmNwT3dBRGRHczJIYURmcjNIdnpU?=
 =?utf-8?B?TStiVzBPQU1ROWJyWXNmRW1weTVPemg2bGowNWN4eFBlMlJ4c3JCVyt1OEl0?=
 =?utf-8?B?aGhRV0VxZGxMQjI5bVBTeWFUL0lkSEpnbTVxZ01ORUVIQVQyTjduZnpoVjdk?=
 =?utf-8?B?VkMxeFQzRzJQd2F0NXdNRWlSdmVMZlloSXJNNVAwNm94eEdjeUo1Q1F4SDJa?=
 =?utf-8?B?ZEFBSkN2RGc2aGRpM25BbDFXS2pTZmdsaHFkMEJDeHlGNVR3WllPNGVzK1lH?=
 =?utf-8?B?MCtoMHFTUnhQWmVtM2xtVjF0RGRyM2FKdkdEVlZsbG5SMXp0SllNc1k1UTlp?=
 =?utf-8?B?RDNxL1lPOFkyL1JHQjJrMVRWblE0TmMxY3h5d0JlS20waFlKWXJwL2JLVUdy?=
 =?utf-8?B?QlRvelhHNDRKS3pkSXBLRVBRL290TkdCWHBnMEhSd0o0NWtscXBVWm1aUTdr?=
 =?utf-8?B?KzBpZXh1SFpyL1RjMGNFR0Z4S0J4RTZlNS9ZM0JQQ21OeUJRYml4WnFmNSts?=
 =?utf-8?B?TzdBM1N5akhBS0FSakd0U2FMb2J2S2dHMmR1Z002dmUzMkk2cWI1ZUduU2NS?=
 =?utf-8?B?bXBrdHJmayt6di85d1Azc3hCOEI4ekp0ejd4Z2lTUFJrTzdpaHFiRUVBbmtB?=
 =?utf-8?B?L1ZUMUpoczZHc1R0QS9lVE5DQlJ3S0hKYWdDTkVzTFJUdHR5Tmd6d1UyOEFO?=
 =?utf-8?B?NDdKYm1mZkZpcXpsNW1NcGJkU0hPSkhONkxuclovOUtNRmM1Z0VCOGVQTzM2?=
 =?utf-8?B?dHJmaFNyQUFHbi84T1loSWJFajBxK0dhOTQ4OGNIZmQ1OFVGQURkVVVXcGdx?=
 =?utf-8?B?ckNJSUQveU8vc3pUcjV5TzJpeXB1K0U3cmFJbDlpamdaMTZGWFpoTnNpVFFl?=
 =?utf-8?B?ZmQ3eitGQXMybHhvSTJtblVObGdGdndiVERCY2VlYUNFa01Xak11ajIyenU0?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d04c8092-dc28-4d91-8e0f-08ddd6d2e286
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 23:25:39.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+10cSFIVdiQq7KXJDPYfiHdEmV866/jz4OPLrHplaa1mU9xZ9/2tddUfC4cDQHtIekfP/Zs4ixY8YgA87vqlXLj0JltD7SEESYfatceWGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8B755DBFD
X-OriginatorOrg: intel.com

--------------WbGSt30pfwTEtjNxx00qqsra
Content-Type: multipart/mixed; boundary="------------Cbi3PgG4KkecICRAZ3uGtK2I";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 anthony.l.nguyen@intel.com, Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a3d19fa0-6e03-430e-b3fb-51864f902db6@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation
 failures
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
In-Reply-To: <20250808155310.1053477-1-michal.kubiak@intel.com>

--------------Cbi3PgG4KkecICRAZ3uGtK2I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/8/2025 8:53 AM, Michal Kubiak wrote:
> Currently, the driver increments `alloc_page_failed` when buffer alloca=
tion fails
> in `ice_clean_rx_irq()`. However, this counter is intended for page all=
ocation
> failures, not buffer allocation issues.
>=20
> This patch corrects the counter by incrementing `alloc_buf_failed` inst=
ead,
> ensuring accurate statistics reporting for buffer allocation failures.
>=20
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side"=
)
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---

Thanks for posting this. I had a version locally but never got around to
posting it and forgot... :D

>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> index 93907ab2eac7..1b1ebfd347ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *r=
x_ring, int budget)
>  			skb =3D ice_construct_skb(rx_ring, xdp);
>  		/* exit if we failed to retrieve a buffer */
>  		if (!skb) {
> -			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> +			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
>  			xdp_verdict =3D ICE_XDP_CONSUMED;
>  		}
>  		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);


--------------Cbi3PgG4KkecICRAZ3uGtK2I--

--------------WbGSt30pfwTEtjNxx00qqsra
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaJaHcQUDAAAAAAAKCRBqll0+bw8o6MOv
AP9+7lL9/M3jZswwfk1x56iMy9tia3+saUQu/niFZ4djGwEA6jkWAiPbm6unfd0NSBZQlmvTZxT9
JRsO9iyhWutwAQY=
=LIH5
-----END PGP SIGNATURE-----

--------------WbGSt30pfwTEtjNxx00qqsra--

