Return-Path: <netdev+bounces-230162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21FBE4D37
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E27581575
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633F21CA13;
	Thu, 16 Oct 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKy8kFCU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1771FF1B5;
	Thu, 16 Oct 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635235; cv=fail; b=EFB000eFPtXx15w3IP0TmP6WH6ZO289enJxkp23km/+v3cBZZpIXcAVcApHnuRfloZ69T/5c97cpiGsMi3jxAr2aIMEuE75Fcy6kTlhJtK0S7ANs+A6o70JO4PB2NQ8iU/tJD/SdxU816RMLrLaLNET/uQ/dnzKTs4l8ech1+aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635235; c=relaxed/simple;
	bh=nn1oroA+cUdB9kMBamxrnRU9PpgZJp0mpnjITDe9j98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iha6AzvJwk3erKokVLKpzEepPou0mAF7gOAiyEeUdkDC2WnvJHMm5oNqvzkrjdHtWl986mfkPfzQm6u8olJpUt7YtRDEaUYmnWsLIW6DLzcIjAG8Fy2d6JfsaEzjJ03i7XeIQaiET+j/qV/tA6p2nlqSVBm/GAaa2aLLbMWKvvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKy8kFCU; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760635234; x=1792171234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=nn1oroA+cUdB9kMBamxrnRU9PpgZJp0mpnjITDe9j98=;
  b=bKy8kFCUXlacx6rTIemQdopRmdHvBvFDp5Arii87eTD2eXOaYaSO0T9f
   +G3t0Gbl+D+gcroqTm0zRdBB8sGGZB9/eUpSb5ZEF1h+6Bl28QSxhGMFm
   yR5qPoXOqHfOLU7AwtAZqFhWt4YbdNbxHN0441VUI/CvL2TVBpDXGACye
   EngaMkxdgvMIut4TrYfCKiDHfUny0ptp5vafq36/OtuLgHcVhPNL63VRB
   3meS+lL3vBBAteq852Hxt9kK/CHJNRucL9fXnSWeJgxaSQcygclAIWjc2
   1EJ7fStmx7WBTzRJGjPsgf2344tqXQ2+tE3vZfcqKahFik7MmVCL4j1SK
   g==;
X-CSE-ConnectionGUID: +C7H3AbjTZudgqX0uUXSWQ==
X-CSE-MsgGUID: /4oCjzqDSDuqHT1T49K9Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62742764"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="62742764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:20:33 -0700
X-CSE-ConnectionGUID: xpCP2ul/Qq2srf8LPVwcug==
X-CSE-MsgGUID: 8ocyr4O7Ry6zEFSImv/xZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="asc'?scan'208";a="181724213"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:20:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 10:20:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 10:20:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 10:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3CXCidpR7s9P1ejeMEp25wE9x8wfRHXoNyR0eKOv3mgyIqp5EuLjdPHXHktHKaEfErH73/0J8+K3oxFKu9oX5WVjw9GwopPt2spgaBT4Fe8Oo5pJ5LdG/B8UwRKRcU0s5q4ZvEaBekrUypttRNeZynhvBYJ9zT+ATYfydSGOuafC8x1kOq59xl1bna1d0Fq6UxyMOZ48hrPQfloh1PDW01CJffRQmG1GwcDRxYjF+YT8ohdLMXhTHin0qzuv/MPpiPuKklMdlJGwgr9UzJnVeIPSGs/eKozaNBOwfLWxKohiv4wWxJkllDerV8V+SWfLwb1uOS/ifGvsF3zyPFQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrkY7A/iTUAyQ+Ec703/dO1FqYwZzwcStc6wAkfR7Yg=;
 b=xqJtgYcj5JQW8lrBuRVXt25xLoRKQbFoM9ZIiQDc0D2pu/f6aFDnHVVkp/Nqla1YqEsLd3tPVLj6o59uPNElQB6d0MJnzPP164WRKkM14lLhompptTpfHLCbYMmSsSp+u1pPKZ2OlLwbJPxN9FnMXeWy1gVj/trsosClP2zO5dOpYEqT5Hf+7Jseg0IcNns6DVlEjCGJyzjxjuXf/ZS/3Su/E6SWw1uCe7dcYf1V9j28ca15pnkbon7swCrB2XqcxAlffNB2RFTLEfz3P/Sum0wME4zYyacFkX9TTIBiTgjx1JjxQxoYb2kNVwbXIyfBbo9QO9xB66+Rvq8UPxgopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6709.namprd11.prod.outlook.com (2603:10b6:806:259::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Thu, 16 Oct
 2025 17:20:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 17:20:26 +0000
Message-ID: <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
Date: Thu, 16 Oct 2025 10:20:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
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
In-Reply-To: <aPDjUeXzS1lA2owf@horms.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------elmJDiCTlKTWWQrBym4MYkwx"
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e9959e-c868-4251-412c-08de0cd84c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEx3eFYxNzV6aXRMdDM3eG83eFp5UUVjZ3dMaENlWkZ1VXBhT29jRDh6ZGRP?=
 =?utf-8?B?R1VnTnZ1ak1uR3hLbUdMNHZOZEZ1a3VwTDBUOW5oRUtDZy94Y0lyc05VR0N5?=
 =?utf-8?B?bFpwbmwxNXAwYit6ZTFPY09DRW1jL0o5NzJVMk9wa3MrT29MbUhINmI1YVpt?=
 =?utf-8?B?YUVLWEo3T1YyWXZtTnZUajE2NjgrWjl6aVVsYy9DQlpnSG13T1E0R09MRUlM?=
 =?utf-8?B?MEY5Ry9acnlVb3RkWGdEUTJBOVdZL1l4YmJzSmpsRE9MNlpFT3ZkZlpDN1M4?=
 =?utf-8?B?b0M5UXZlZ0hDWTRXRnlveExwS1JkdXB6UHoyQ2J6N0RNUE1jc3dXOS9VV0Fs?=
 =?utf-8?B?cHh2Tk1BNy82KzBLYlZqMmJkTTMxSlY0MXRkZlpJcXZrRisvdTV1eVpRd080?=
 =?utf-8?B?WHBNbERLRGVwUFhFQkVIWmlKWWY4VHNjcWJvRDZLWW5mbEpZWWh6alZUdWNu?=
 =?utf-8?B?U1psN1lsWS9EaURnaGpUOTJSTmVGbTlETG9SZit2UGh5T21CR2g5TDVuYkFL?=
 =?utf-8?B?bnNxTmd1YU5lMkF3ZDY2eG1hd2FNMENWUWpQbmJNVUM4OEUrRmo0OHN2b1gw?=
 =?utf-8?B?b05WY1kxSlVIUDNnemdUNDVraHlwVTI4VnVBc3Q2WUhIQ1Y0MmtSTEp6bFJD?=
 =?utf-8?B?c1hDRFM0Q3NHbW5vMllYUkladGp1Nk5UU1g1VzZCU0dRbW5XMWRHOXg3MzhN?=
 =?utf-8?B?VXhQZDZ4Yk1HdXEvOEt2LzdPQ0RIZll3T2s4cmpBb0o4NVg1bUZaVThxd2R4?=
 =?utf-8?B?a1BJQ1Vlc2dlcUFLcVVkTnlQR3NpUzJ3V0NwbUJJS004azh6dG5XVHRVYjBl?=
 =?utf-8?B?Z0M1S2QzdWdNZnMwZExoeTFMRkpIbG9LblVadWFIUjFlT3ozcmdVbC93MWRw?=
 =?utf-8?B?QVJLczR4Mm9GTm5DVmkxclJidzV6dVE4RWJyRXJ1dTZGeHkvd0xJRlZRZHFT?=
 =?utf-8?B?OHZtQzVlWSt4L3JKUkYwUGc2SkUxQ0U2S1UxNW5sS2h2QVpocDlGT0x2Qkta?=
 =?utf-8?B?aUtoRTBFRkJBYWxJQ1FGeE92dGVkdHpJYmdZRmQ0L1ZYSC9IVjVrYjBTaHUy?=
 =?utf-8?B?ZkNHdW4xRUpMY1NDeElRam9XSGtYNUZDci9SK2sveWt5R2dQWEExRGp5RlNB?=
 =?utf-8?B?MitXaERUR3oxd1JoMSs4aFh1TGJCeHBPSnUxR0ozWnBIUjQxM2U4NXNCLzQ5?=
 =?utf-8?B?YmR6OUlzRndaL2l1U211UDFMSnBxR0RSSTluWWJEc3IyRy9IVTFteGpNVEts?=
 =?utf-8?B?OEhMR2EyYU11RUlsaVJvOFRLRDRvRGxQenhxcUFuWXlKRFExMDFrQXJtSnh6?=
 =?utf-8?B?bmZqMDJ6ZE5yVWMzaTFXUWN3bysySU5WYTdnMG9Zc0pZQVU3dDhHUjhZQVlF?=
 =?utf-8?B?RU9GZzJKWStsdW9TME1zMDdORDd0c0t5OUUxUEJRZndzeE52VnZJeFB3TVJj?=
 =?utf-8?B?SmtiWk1hMDZYRk9YWWw2dmpDWXlUY05aakR3M09jaXNyQXdSQjBWTm1PcEVF?=
 =?utf-8?B?elBIR2JFMEtmSDZDUldUS3gvVXBxU1U0aVZubmx0OTgzL1A1TXdTQysyL1Jw?=
 =?utf-8?B?anJidFpYeGdCdXg3Nkt6b0tqNEY1U0hkazJWdlczTi92SE96RktockJJLzdV?=
 =?utf-8?B?RVJvYTM4bUVJeG4yNGpqSENXQ1JWalhyKyt0WHFpUXVnaUdqNHFPdHRoYkNY?=
 =?utf-8?B?T2hnbmxmTUNRWDV0L0E5ckhMVDZ4UDZpTndoSENXSUhPa0F0TGhvcGI1bGhi?=
 =?utf-8?B?M2xkQ0FJMzhIWGJoNlVvNnRuTloydWtLa200V3QvTDdCK2MvdHEwSFlLS2Jn?=
 =?utf-8?B?NGdMcU5nc2ZZWG1uK0JhQzIwaFhWaEJDZldJenR5SkZBaUdGeWQ4Wi9CamVv?=
 =?utf-8?B?bXlBa3g2NlFFZVVGdnZrRG1xZGcrZkkxU2hXeDBuaXlpK2NXRGRaL2pYK1JN?=
 =?utf-8?B?aG9YaUNVRm9lRTFXMGR1VmhxbjZERjNsNVJJbE9HbEdWUHY5V0hxbytUVml4?=
 =?utf-8?B?UC9XQVFrTTFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVudzdVVENHSTIwdkkxcHZXQitmUXhHeDdUSzd1L1NWK09YRjlReFUzVmE5?=
 =?utf-8?B?aUNHUXg1UmpiUmZVOW5yeWNwTFpkdXNKSGplaWVGM1F6ODBUb2ZBT2Jsc25h?=
 =?utf-8?B?K0N3TGtlRHFlOVM0WTVVVnVKQ2V3OEdEbDNrNUxiOHFrMk54b2hKL1Fnd2NH?=
 =?utf-8?B?UXY1a1g5dlFTb3o4MmVHdHpLaVBoamExeU9vZHY3MUZXdFJ1WXJod2JuYUZr?=
 =?utf-8?B?ZVhtRWpmWERjT25ldGxlMU42QThsR2JsQ2sxYlk5TmdSaW9OdEVTQ2dEYTZS?=
 =?utf-8?B?M3JwZHVjN0xacEhlMVF6THJsOGJRVlo3SmhONWNUWVd4b0VGSU1mTUc3SWtE?=
 =?utf-8?B?ME5LVzQvR0Yrb1UzRk1iNFhOZkszSEZGaURTK1I0YkpjYjFXK29JN0NuUjJi?=
 =?utf-8?B?Q00zQWU1elNOWURqS2pVUG9NYmMvWHBrKzd5bWtHN0xoZnd0YnQ1a3RtZys0?=
 =?utf-8?B?cGJ5clo2dVBOZU93STlZZnhNbHdmU3hTdzdwcUZHcDJIdDVtSXpJbURRK1Ns?=
 =?utf-8?B?RjFrdnZXRnh0ZTdqSUh4WVFBQUY0bWFpbzlJU21oNUFSbjB4dVh5aXlkZklU?=
 =?utf-8?B?cWI2azBTSmgwMFVHVWVIZC9FdEVsZWVOK2t1VlB2MUthTGZXb0JqbHdXNVJk?=
 =?utf-8?B?Rm51SFFjRlZleEs4eHk5bjZ0dXFZSGIzSzFCaUQ1RlpQWnJXUlFtbHRnYVBP?=
 =?utf-8?B?SEZSNTFqY0ZJNjBiNTI5V0dERVhSRGtEbmxsZXZORXQ2K0JHYyszMzRSUGdi?=
 =?utf-8?B?ckpXVTZoVWROZk5OcVE3SGlxTkhaU0N2eWR5dUtmbzNHZW1xNGJVN3ZXNlJJ?=
 =?utf-8?B?eHdhZU1lSytpcWxSM3ovRml5ckhIN2VSRm5PU2NtL1lSUGxkbk0vbGFHUkw2?=
 =?utf-8?B?cEtibXowVnZCRlUvb0d6U05zU3IzZ2g0QkFqOEp1VTc1RHYxdGEwcklOVGdr?=
 =?utf-8?B?bXhxUzUraWpLWm0xNjh3TUhVaHhPa3JDWmhneHlHNHkzVDAxaEFpaTFQbytx?=
 =?utf-8?B?ZGcyR0tleTNJQ0JPem91amphaHpES25nQ3oxNzFERVJpOUhIcmFQdjRRaUxp?=
 =?utf-8?B?YlRNS2s5NXA0QlNTM0tPc0RvQysyZUNWSnlDczkzblduVUV6MXdhTUw4RGIr?=
 =?utf-8?B?UVR6akJtb2ZwM2w5cm5TUGJabnpET20zRGZTSFlhK0RMRE1aR3JkVkFYWGVL?=
 =?utf-8?B?T2srQjNSaTdpQzU2Yk1wY1ZlZmxWWWo4VzZFb2d5Y240Q3JoOVZVQ1VHZFQ2?=
 =?utf-8?B?c1pTRzBTakhXRzJNKzRtS29wME4zZTJLZUF6Mk5hR05Qak5YOC9MZnFWSmRC?=
 =?utf-8?B?WitySk01MHdQS2VSd20vTVFBWGRvWWFFU1c0TjFRcm5mdko4MzAxZlJUdWtm?=
 =?utf-8?B?QTFXSzRCQWZpZklFdW52dlRqdVpmeGxQMVdSMDFrNmplbENnMlFtYXdOb0Zn?=
 =?utf-8?B?SEJIajk5c1Q3NlhiNmVJNTdENFliVEYzWWZ6MWxJSWs4OFdVL1h0YzJURHdN?=
 =?utf-8?B?TzVxazVCejN5NHkrOXlqNEt4VE5RQ2p4MWFhbmVYL1dmdVVZYU8yUVNuVFZa?=
 =?utf-8?B?ZEVuU05TMGtKalNEMmNuV3l2RHp4WEs1QjY3akJKVlNVT0czdmV2Z29xYTI4?=
 =?utf-8?B?NDg1Q0pocDhhM0pmZXNidDI2YzF1NEEvTUJOOHBlOGp6YURId0JzNXlZVlRY?=
 =?utf-8?B?U2Z6ZVlUYk93MjRuMGxIOXhoUE9idm82QmZvZm9CeEt2U05UaUkybWMvMi9w?=
 =?utf-8?B?SFgrWkhxanZuSjBTQUR4RUtzd0xUa0hCWHpoV0JodVlNZXdSdWo0N2gxNVU5?=
 =?utf-8?B?bjNaZ2VkSEhyZTluYXBvTWZUeVRicmU1bHNaYmtiM1BubzAzb3JGblhneGhl?=
 =?utf-8?B?K09WWGRvbFE5UzdiQXMrcWxjU2pNR0RuNjJlUzRlSlZzSnJic3cwY081elpw?=
 =?utf-8?B?ZTFJM05kTWQyRmR3N1p6VTZBUko5dFczbG9iQ3ErQ3lRUEZLaTR3OEVHR1Zt?=
 =?utf-8?B?OWVicVcrSWRPWklKZFlncDZzR2FQWEpOOTlReU5DMmdKa0h3ZXZpL2RWSi81?=
 =?utf-8?B?TjErZTdjQ09lTGNqSVRxYXViTStCZGtCNWtEb1g2ck9XUFBRVHFNeVU0czBR?=
 =?utf-8?B?UkYyWVBwREJ0TGs5ejR2WEFiN1lHdWw2VEtRbnRZRXZxTjVTZ2RqcytxTlN4?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e9959e-c868-4251-412c-08de0cd84c5d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 17:20:26.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IUJ/63jtdPunkxkkDrTBii8xB9Lp1JOskegCJqmHQ4hs387jRrSiouNJjmEJ+jHc9k5bXqurRYSdP+RL7Cvz8zkYWmlX1EEVnsru7+dQ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6709
X-OriginatorOrg: intel.com

--------------elmJDiCTlKTWWQrBym4MYkwx
Content-Type: multipart/mixed; boundary="------------e8jCMXRjPn4K00WibbIBMEBn";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
In-Reply-To: <aPDjUeXzS1lA2owf@horms.kernel.org>

--------------e8jCMXRjPn4K00WibbIBMEBn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/16/2025 5:21 AM, Simon Horman wrote:
> On Wed, Oct 15, 2025 at 12:32:02PM -0700, Jacob Keller wrote:
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>
>> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
>> across multiple flow types in the Intel ICE driver to support GTP
>> (GPRS Tunneling Protocol) encapsulated traffic.
>>
>> Enable improved Receive Side Scaling (RSS) configuration for both user=

>> and control plane GTP flows.
>>
>> Cover a wide range of protocol and encapsulation scenarios, including:=

>>  - MAC OFOS and IL
>>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>>  - TCP, SCTP, ICMP
>>  - GRE OF
>>  - GTPC (control plane)
>>
>> Expand the PTYPE bitmap entries to improve classification and
>> distribution of GTP traffic across multiple queues, enhancing
>> performance and scalability in mobile network environments.
>>
>> --
>=20
> Hi Jacob,
>=20
> Perhaps surprisingly, git truncates the commit message at
> the ('--') line above. So, importantly, the tags below are absent.
>=20

Its somewhat surprising, since I thought you had to use '---' for that.
Regardless, this shouldn't be in the commit message at all.
> Also, the two lines below seem out of place.
>=20
>>  ice_flow.c |   54 +++++++++++++++++++++++++++------------------------=
---
>>  1 file changed, 26 insertions(+), 26 deletions(-)
>>

Yep these shouldn't have been here at all. I checked, and for some
reason it was included in the original message id of the patch. b4
happily picked it up when using b4 shazam.

See:
https://lore.kernel.org/intel-wired-lan/20250915133928.3308335-5-aleksand=
r.loktionov@intel.com/

I am not sure if this is the fault of b4, though it has different
behavior than other git tooling here.

I fixed this on my end, and can resubmit after the 24hr period if needed.=


Thanks,
Jake

--------------e8jCMXRjPn4K00WibbIBMEBn--

--------------elmJDiCTlKTWWQrBym4MYkwx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPEpWQUDAAAAAAAKCRBqll0+bw8o6GyN
AP0Ur6I+WUApsPRIk5VPqXfg0xQVAOdfsxda+x/gJlJ9ZwEA2CocF5TP66d1lepZDeD7mP5GzmHs
GI4oyzUZmCGwjgg=
=/11Q
-----END PGP SIGNATURE-----

--------------elmJDiCTlKTWWQrBym4MYkwx--

