Return-Path: <netdev+bounces-217488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B7B38E3C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BAD18896F9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CC310779;
	Wed, 27 Aug 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT5bEYhX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E31064A;
	Wed, 27 Aug 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332802; cv=fail; b=j0mPSZzz2oaqPMxjZGgxrsrG9pX0GIsQClJv7cJf8rcd8p+PkMu+0T5Glkj+MufbxOnW8VufcSMCz64vhbcSMJelyB8CG9NRF9XHVnDTJ3/l+x+w5tZpKS67XNeM+RLrCHF3UeS/iFi02uQMbq62GOGgpgp2EHYvidYKpT8O49w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332802; c=relaxed/simple;
	bh=hx7x6V+Xm5mAvsY4j67s1vbB8Cuq9qT6w/dEPJvpRoQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcHFXTtd7iaiw2es1MhoBSisCnjNS0tCYTkFsrARBeHbhNSGlweGTjzwWcoAL0TCCCrvuviTlHTxyYvrEKH8E2r5i28juMhNxOyd4FMBJnP781BvK+OnsxRZFJqsIElJqgfk06iaFte3S0oiU28EgKzFRGGuIeVYJlW8qciYtdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT5bEYhX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756332801; x=1787868801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=hx7x6V+Xm5mAvsY4j67s1vbB8Cuq9qT6w/dEPJvpRoQ=;
  b=UT5bEYhXFLbfN/ykGhbevMieEd5+C+MdE3Xu/Klbv2V0GC/dcDstAExj
   0orqg4KjovvAQfcMb4XiGcc2vHFoMrurKqubtILh1XkqSqX+cj14rtYAQ
   xu8nb53r4VKT6MxvF+ej/d8CPIQ1/Ypcg2RIZ1asEtvPQIAxtjJuYTNWD
   Cs3dHyfZulZBJckJYDpJ0rP096Axmph6rFP3lMs6EVFsa5HrjslcbZb7K
   rmyi9ZlZctK9/zP2peBza0VvvUG1jDsIwulEC3iFaNprrhGyQzFR35781
   ukab5IGNYYzUC5O1GfOh9KxCdpKD1yulNuhSDdSCwQxaI3bU91IJzi27Q
   A==;
X-CSE-ConnectionGUID: cVuR1nTqSfuuJB5KlXVnng==
X-CSE-MsgGUID: EVfH4gDyRxeIJ9ddGKxEsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70035297"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="asc'?scan'208";a="70035297"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:13:20 -0700
X-CSE-ConnectionGUID: qj8WfopSQ+CPrJiUseQCsQ==
X-CSE-MsgGUID: W1MMvqfMSfenXjJNXTlcWg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:13:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:13:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 15:13:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 15:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2YUsFsw62zSBDF/eLZ9cifegG7Em3fC7Z1xgvX6GURq8nDi6UxrYbG5s9RhVEcTWd4q4zhqmD+f4kpyR1HnM718jIcFPO3wMMSK0p/yb28uOFRDBkJC86Q6Zil3EsY67Zsgk3nXy2JIQONGbBNkrL6Ehlxf4Q7Ew52xSp7QzXDFh1xYSxKO2lgscVPcCOnsihAC5HyhEreVXa45yACuH7qDE5VpwxJVfZTvqdfYRH9VsMNrpNOqKnuQfX1sISlMlr6GlpuvSXnP0/oOSXVnU6NW3mHitLeJBj38FM7LBi+pugjQLRBi0n6ZI6sB4PQR1WGjaGIiDEFN5t0+OkjUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No4prdudqGzSBagUn8Y+d5k+Ns2mB9mZGEBX4vdHNVU=;
 b=Cg+JDc34p9aXzpv1BO2RUDtNnMo1Zz/6cgtkLJqZmmqjW1PVqz+RgYNvgGbthSJHSDs0iMNFg+UzGO/34jg1bQlZRkrEmbLLvSB2eOgTvFCe/FboSxyWUA0sEFGZcnS8p1iQOzIZl6TuaOC6lwiSAmC+vZAKNM1BNcAIVaEh+4jENNtQsvvKemkF7DvTKtRW6j7JEuIcBl/YW1DHqK6Z3qkpkq4JrEJxey0RoWX1WmRw4sEY/FUJz5PADUjXZIL/XNetKVWUH4GA5mVcvlAHpV7tUS+lJuwUnAjNZja9/FfuuP8ivuewtGOaEGHp1iXuWYCFxlQPRM2pNa0Eq0gmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6197.namprd11.prod.outlook.com (2603:10b6:8:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 22:13:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 22:13:15 +0000
Message-ID: <e6faebe0-6946-47d0-b925-8d2fc38a1d09@intel.com>
Date: Wed, 27 Aug 2025 15:13:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: sun8i: drop unneeded default syscon
 value
To: Andre Przywara <andre.przywara@arm.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>
CC: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	"Jernej Skrabec" <jernej.skrabec@gmail.com>, Corentin LABBE
	<clabbe.montjoie@gmail.com>, Paul Kocialkowski <paulk@sys-base.io>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>
References: <20250825172055.19794-1-andre.przywara@arm.com>
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
In-Reply-To: <20250825172055.19794-1-andre.przywara@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------WjBELPf3F7uabgmB8y6VMZz3"
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e476726-9ba5-4f41-d78f-08dde5b6eb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjF5NmFRd2JmeFVwWGFXTWZ1SUpXV1RqL0pxUjlPWjVkTlV1Uk1ncDFzY2Vi?=
 =?utf-8?B?ZWJKbDlqVXE3azF5SUhDVDMvR29kVHVaRDFJcnpnSEhRcWM3dHlMQk0vN1Zk?=
 =?utf-8?B?akpYOEl4VFFxdHRtRTBWRHV4QUJMRjBCd2xmQ0FVRUM4RkMrd3lpanhoODRP?=
 =?utf-8?B?bitIbEJPSmRaSVFYeUNEZmpxdzBMcTkycDhSS3lXbndwTUxzTDhqWkxhdGhz?=
 =?utf-8?B?L1VIbnQveFUyWm15ZUNpcERlUkc5eExPUHJYaGwyK1pqSnBhVktmVkFMUngw?=
 =?utf-8?B?cmFPMHlVZlhLNHB6bWNmVTJXeUFYbHhsa29xeFMzTVYyazFEdVErSzlFSHA5?=
 =?utf-8?B?MjVnMFVSckt2VkV1MGQvUzBDc2dLSzMxbHUveUNma3RvVFRIZWVDeDdZVi9E?=
 =?utf-8?B?dFhoOU1iTisySVhUUzRjRXRWNEc2ckJHRG5iMCtXWnAyZ09Qb3BqRkxvYjly?=
 =?utf-8?B?MmRjeVRCRTdmTTByeC84SWVPNS9JQXd1K3h2MWpWa280WDNYeUlLRng5VndG?=
 =?utf-8?B?RjFNVnNINHJFbzRUQ2lNUE1pK2lieTZzU2ZhUEJUSVd1OCtWUThtdU9sZzMx?=
 =?utf-8?B?RHJhN1kwWEZLc0s3enkwVzk2dUY3aTdmVHNMY3hpT3AzZ0U5enpxRGd6bGYy?=
 =?utf-8?B?R1N5c0ZZWnRwdTNaNUlqMTVUdE9SVkRhN2dVU1B5dXpURHYwQk5jMWc5WlAr?=
 =?utf-8?B?MTVqY1FBUWk0VkpXbzJMaTBRenVoR3l2bVlaa2ZURjZTL1daWjV3cm5TZXdr?=
 =?utf-8?B?RDhVTy85UHJER3JKc2JpTG5GWDhiVGtTMmdMZDhKSHIxYnI3WXl4eVhvSXor?=
 =?utf-8?B?ZWN3OGk4VVZqdGtxVDR2VXMxdjREWkp5VHA3c1Vmbk1QU2xranNWT0VYdUw1?=
 =?utf-8?B?TkpGc2d1aUNCNkdHbzdWMCsvNU9XY3ZnZTdGOExrbUtuTS9reGNKekxrM1la?=
 =?utf-8?B?c0VEdkduNS9kc0ErWTAzRUhIVEhaYTRqbytxRHEva1QxL0o2Qy94NWZJM2o3?=
 =?utf-8?B?UVNRc1hYZGVFNFZ2S3pJN1hpaDU0WTFUYTcwbW1YT1VGR2RPMmFrdHo0ZWtZ?=
 =?utf-8?B?NDFuMGVOd085VlAxY2pxTjVXZ2NIUEJCR1NwSEhKN3NFYlJhYXVzYmNtTmF1?=
 =?utf-8?B?dHBjU3l6ckNJYUxrV1pibWt6SkZBV1BaQjgza2RmOVNJZ3BaeXFtQ2dPdW5T?=
 =?utf-8?B?Tys4akpxbGxTc1lKUms0WHMyUG01bmFyLzRsYndZMWlwRkZJdFArc2pjUWZl?=
 =?utf-8?B?eUMzOUtseFBTUDVYTWpHRWNJUm80NUlUZ016cUwwVUVFaE8zc3FxTWxCTSs5?=
 =?utf-8?B?U0NMTmlkK2NMZmZMNnFJZXQ3Yld6SXczWmtCNitsa3prYm5ncUI0L3QxNDMz?=
 =?utf-8?B?bG1ZQVI0ZWwzQUtLRUpVNjFFK0pkUStpN2dvYkdVNHVQQVFNd1RpbmZlOFpR?=
 =?utf-8?B?K3lla1ltWUNZbThlQUwvQVdYbHlPdjRjaGRiS2JNTG5IaVVUdU9XVEJnSTE1?=
 =?utf-8?B?VVErMXlzSnFTRUoreEFBK2JhS0dSaHZFQ1JhZVpnSTE2YXJrU0dsNkN6eG1M?=
 =?utf-8?B?bXJHdXpQNmZRd1gveHdIVm9NN3ZJeXdwR3NwUC9TUDZwWVNKZFAvK0lEWHFv?=
 =?utf-8?B?clk3RTBPcHA1NGNpMm40TUJxa3h2MzQ4ejF0eVhubWw4bTJKMnM1VU13MzY0?=
 =?utf-8?B?QmwzcTVLWE05VHhESmRKdEZna0dSQ2FkYWZvOE1jZ2R4dE1kdnNTMmlFNURN?=
 =?utf-8?B?M094dG1rWXhNSC9INEFOZ1pFWGRGWlcyb1lCYi9BRXkrTkVJY1lPMGVwallk?=
 =?utf-8?B?aHE2WkF0elQ0MUp2Qm5kdU45OTI1SWE0OTVuaXJDdWxJZS9YenZEc2pMNm1a?=
 =?utf-8?B?aVk3ZjY0VE9RSnlGTm9SdityREZIQ0VYak1MV3pjWDc0KzI5NWV1OHQ4NkZx?=
 =?utf-8?Q?iN7ZZCVkVec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVweWNwWXNKaFRzc2dxTy9wZit5amsrby94UVlWQkFqMDkyZUNMYWI4aXc4?=
 =?utf-8?B?UVp1cGxKTDdlcncwd2F6WUFrRTg5aURVOThHUFBoRXpJUDFMNXIwVW1jVHNJ?=
 =?utf-8?B?eDFWN3pmdHpJTkRNZEJoTFN3VVVUUXBSQkZmeTVmVFdSUmZlaVZkeVVFdG9t?=
 =?utf-8?B?dmNlbER4RnJaTmpNZi9CNG0za0M4UDIxS0RFZi9UdzlwdUlKRE5wZENVL3Jj?=
 =?utf-8?B?SmdScGUxblFUa0VsbW11MnBJOWVhS0NXVEtJQm03TFkraEE4U0x2V01PNndP?=
 =?utf-8?B?WktKRGhFbEgvVWtLTXAvVktqMVhCZnJtOWZYVnFjeGVocXp3WHF1TG9Rc1I4?=
 =?utf-8?B?cDR2R21IWXdkaU84anZFalpUczUyNGV6ZndGMzQydVUyL2I0bWI5a3N1Qy85?=
 =?utf-8?B?SWo4Wnoya0JCQjZUSHE4bnlsOWoxWEZQeEYrQVVqTXRPTWdZYjJoSm1PMUxl?=
 =?utf-8?B?dkJNRldJZEJwWEtZT1ZNSDBGWStFcC9hRy9UQkdkUU5DMzZMOFRiVHhaZy9p?=
 =?utf-8?B?ZjB2Z3dIZ21tcEFXTjc2OVFqZ2NBbnAxSXF5aHIxUStvQy8zeFVaZ25uUjJm?=
 =?utf-8?B?ZXp2QWRnUFEzUHVLOHI5WjRZNmowUERqTFFKOHdXNWczSk5hT3gzSDFIVEI3?=
 =?utf-8?B?NDZKNllwYThpVUZtSUxqUXkrazgxZ1I3UGVGQ0p2eTNmcEFnNk1UQy9INDND?=
 =?utf-8?B?bUtrQUJ3RUUwZ3ZZV3U4VlhwTTdoU05vSVVwMUpIelV1dVZtOTFUQXBHQUFB?=
 =?utf-8?B?WEk0eUdjVHNjbWVralg2Z2FGdll2VFVNNmpjSXJ3QlAyTlkzQnRhK3huOWty?=
 =?utf-8?B?VzRUZDljS3BaSFJ0ZlcydHZNdXZJUXhHOEhBRHppYmc5RWZqQVUvL1liM0lv?=
 =?utf-8?B?VTZuMUE2djZnNGxvWVJLc3I0Q0hwMHdDSmM3dGpubW96Wi9Cc2VlUVJqb09G?=
 =?utf-8?B?QTRkUjZMSnZBRUxKSkNhSVE3VGNqY3Y3dUNMUEtXRjRXNTFWcHozSk52STRY?=
 =?utf-8?B?YWc5OFBoNzdPT0NOTVdjb0tKQUh4NHhIUGJabXQ4VmhWdU94b2FFMWM3ZDVo?=
 =?utf-8?B?cTNhbGNOaUxTVHBLcnFHMGx2M0JLYThkYXhjTnlqZ3JjU3FxQnZUMDVlZmJX?=
 =?utf-8?B?eWN5OUptelozWVcyUklKV0pNQWlXd1pkSlJLVnJnM2J1T1piSFlReldXbVBN?=
 =?utf-8?B?bGJ1ZmVGanNXQVh4b2RSbkUzRGhpWklWbzFKWXVFZGRkZTRTWGlvSHBycTNp?=
 =?utf-8?B?ajhzaFdMalQ4cG1OVWdlWW9vd21Tc09seEkzRm43azVuK2VNcE1TVHNpbFJi?=
 =?utf-8?B?L1NXaUs2cUlPblc0b1BYSjYyd2V3ZnJtREpWOFBDWWtmcFJ2ai8yWVhCS3VL?=
 =?utf-8?B?aVh3LytuK0c5TnRaN1lXYWpSKzkvYWU3THZPdWVNZWkvVlA3cS90S1hLdHJV?=
 =?utf-8?B?aDBiMUVSZDJJUjJ2OXZQQ25oQkFEMkNkVHp5U1NMRngwUGh0WVZ1WmpTRUxh?=
 =?utf-8?B?UWhZZlZTR0U1b1E2Kzk3b01jNGhpYU9VYmdBUkplV3p5d3lpa0NSZlJDY2hV?=
 =?utf-8?B?TWdGWmJoTlAzQ0JSVitLMG5oWWdiUStqN2RiTFIwaytzTFJCU3BhS0JZelNa?=
 =?utf-8?B?NEhtS05SWS8yclZUT29lUmd4K2pJVmZIY3FxNTRveGlsUEo2VnlaMkRkZ0h4?=
 =?utf-8?B?MXdHM0ZQQ3hWdVF6VWUvQmowSGV1N3QvbVEyRjRWYXZGS1pjek1VRmVWck80?=
 =?utf-8?B?bUVCYXQrbXBoNjdRZDR0Wm54RkVPTE1ESHpFdm9scWFCekx6aDczcVN6ZVls?=
 =?utf-8?B?MW9SRFlpYVRWTmpBay9KNldaWWt2OWIvRk9CZGZwTG4wYTkrd0h0Wk1UMUZ0?=
 =?utf-8?B?S2tCR1FWTmR6Ymkxa0dFSUtCZEhCQkZKOGIxdENwZmFodU1RcTNucGIwN21U?=
 =?utf-8?B?MndlYmRPU0x2SkF0UDh6OFFYVmRESWZBMWJUOEJTU3VuY28wL1hsRVhZcXpr?=
 =?utf-8?B?UHNmOVZRZXp4dklKYyt1ckFDNnJyUGdpeWFBQlVIeXorTk9yUWVybDBhZlcv?=
 =?utf-8?B?RysxNklYVkFyRCsxdGZmRTFUNnd5d2RXM3JZSjN0ektsekVDL2xJWVAzalBX?=
 =?utf-8?B?ODAwVFc3MDRqeHVIVzZxbEhKQlpHSDY1dDFENmdxbFpSc3lER25CZWJxRkdC?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e476726-9ba5-4f41-d78f-08dde5b6eb81
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 22:13:15.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZEKPqVM7ZaPi4EFmB75ra9KbBB/BXUunOIPuvUojzaX5Lt/zx6QnJUvSL3rkLXD5f8SM13BN9ZlupHpMYiNy/u7kq2qnmzPxsA/UPjE0Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6197
X-OriginatorOrg: intel.com

--------------WjBELPf3F7uabgmB8y6VMZz3
Content-Type: multipart/mixed; boundary="------------2phpSMfOdv9bZhHJID9Gxv4D";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Corentin LABBE <clabbe.montjoie@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Message-ID: <e6faebe0-6946-47d0-b925-8d2fc38a1d09@intel.com>
Subject: Re: [PATCH net-next] net: stmmac: sun8i: drop unneeded default syscon
 value
References: <20250825172055.19794-1-andre.przywara@arm.com>
In-Reply-To: <20250825172055.19794-1-andre.przywara@arm.com>

--------------2phpSMfOdv9bZhHJID9Gxv4D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 10:20 AM, Andre Przywara wrote:
> For some odd reason we were very jealous about the value of the EMAC
> clock register from the syscon block, insisting on a reset value and
> only doing read-modify-write operations on that register, even though w=
e
> pretty much know the register layout.
> This already led to a basically redundant entry for the H6, which only
> differs by that value. We seem to have the same situation with the new
> A523 SoC, which again is compatible to the A64, but has a different
> syscon reset value.
>=20
> Drop any assumptions about that value, and set or clear the bits that w=
e
> want to program, from scratch (starting with a value of 0). For the
> remove() implementation, we just turn on the POWERDOWN bit, and deselec=
t
> the internal PHY, which mimics the existing code.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>
> Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>
> Tested-by: Paul Kocialkowski <paulk@sys-base.io>
> Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
> ---
> Hi,
>=20
> this follows up on my RFC post from April[1]. We figured that the old
> approach (insisting on a certain reset value) was never really needed, =
and
> some people tested this on various hardware, many thanks for that!
>=20
> No real changes except solving one conflict after rebasing on top of
> v6.17-rc1, and adding the tags from the diligent reviewers!
>=20
> Cheers,
> Andre
>=20

Makes sense. Its simpler to build up from 0 instead of trying to build
up from the current baseline with a warning that was unnecessary.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> [1] https://lore.kernel.org/netdev/20250423095222.1517507-1-andre.przyw=
ara@arm.com/
>=20
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 47 ++-----------------=

>  1 file changed, 4 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 2796dc426943e..690f3650f84ed 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -31,10 +31,6 @@
>   */
> =20
>  /* struct emac_variant - Describe dwmac-sun8i hardware variant
> - * @default_syscon_value:	The default value of the EMAC register in sy=
scon
> - *				This value is used for disabling properly EMAC
> - *				and used as a good starting value in case of the
> - *				boot process(uboot) leave some stuff.
>   * @syscon_field		reg_field for the syscon's gmac register
>   * @soc_has_internal_phy:	Does the MAC embed an internal PHY
>   * @support_mii:		Does the MAC handle MII
> @@ -48,7 +44,6 @@
>   *				value of zero indicates this is not supported.
>   */
>  struct emac_variant {
> -	u32 default_syscon_value;
>  	const struct reg_field *syscon_field;
>  	bool soc_has_internal_phy;
>  	bool support_mii;
> @@ -94,7 +89,6 @@ static const struct reg_field sun8i_ccu_reg_field =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_h3 =3D {
> -	.default_syscon_value =3D 0x58000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D true,
>  	.support_mii =3D true,
> @@ -105,14 +99,12 @@ static const struct emac_variant emac_variant_h3 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_v3s =3D {
> -	.default_syscon_value =3D 0x38000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D true,
>  	.support_mii =3D true
>  };
> =20
>  static const struct emac_variant emac_variant_a83t =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D false,
>  	.support_mii =3D true,
> @@ -122,7 +114,6 @@ static const struct emac_variant emac_variant_a83t =
=3D {
>  };
> =20
>  static const struct emac_variant emac_variant_r40 =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_ccu_reg_field,
>  	.support_mii =3D true,
>  	.support_rgmii =3D true,
> @@ -130,7 +121,6 @@ static const struct emac_variant emac_variant_r40 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_a64 =3D {
> -	.default_syscon_value =3D 0,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	.soc_has_internal_phy =3D false,
>  	.support_mii =3D true,
> @@ -141,7 +131,6 @@ static const struct emac_variant emac_variant_a64 =3D=
 {
>  };
> =20
>  static const struct emac_variant emac_variant_h6 =3D {
> -	.default_syscon_value =3D 0x50000,
>  	.syscon_field =3D &sun8i_syscon_reg_field,
>  	/* The "Internal PHY" of H6 is not on the die. It's on the
>  	 * co-packaged AC200 chip instead.
> @@ -933,25 +922,11 @@ static int sun8i_dwmac_set_syscon(struct device *=
dev,
>  	struct sunxi_priv_data *gmac =3D plat->bsp_priv;
>  	struct device_node *node =3D dev->of_node;
>  	int ret;
> -	u32 reg, val;
> -
> -	ret =3D regmap_field_read(gmac->regmap_field, &val);
> -	if (ret) {
> -		dev_err(dev, "Fail to read from regmap field.\n");
> -		return ret;
> -	}
> -
> -	reg =3D gmac->variant->default_syscon_value;
> -	if (reg !=3D val)
> -		dev_warn(dev,
> -			 "Current syscon value is not the default %x (expect %x)\n",
> -			 val, reg);
> +	u32 reg =3D 0, val;

Ok, here is where you used to read the value and log a warning if it was
different from the expected?>
>  	if (gmac->variant->soc_has_internal_phy) {
>  		if (of_property_read_bool(node, "allwinner,leds-active-low"))
>  			reg |=3D H3_EPHY_LED_POL;
> -		else
> -			reg &=3D ~H3_EPHY_LED_POL;
> =20
>  		/* Force EPHY xtal frequency to 24MHz. */
>  		reg |=3D H3_EPHY_CLK_SEL;
> @@ -965,11 +940,6 @@ static int sun8i_dwmac_set_syscon(struct device *d=
ev,
>  		 * address. No need to mask it again.
>  		 */
>  		reg |=3D ret << H3_EPHY_ADDR_SHIFT;
> -	} else {
> -		/* For SoCs without internal PHY the PHY selection bit should be
> -		 * set to 0 (external PHY).
> -		 */
> -		reg &=3D ~H3_EPHY_SELECT;

You used to clear this value here for SoC without internal PHY. This is
ok to remove since you are building up from zero so this is already
clear by default.

>  	}
> =20
>  	if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
> @@ -980,8 +950,6 @@ static int sun8i_dwmac_set_syscon(struct device *de=
v,
>  		val /=3D 100;
>  		dev_dbg(dev, "set tx-delay to %x\n", val);
>  		if (val <=3D gmac->variant->tx_delay_max) {
> -			reg &=3D ~(gmac->variant->tx_delay_max <<
> -				 SYSCON_ETXDC_SHIFT);
>  			reg |=3D (val << SYSCON_ETXDC_SHIFT);
>  		} else {
>  			dev_err(dev, "Invalid TX clock delay: %d\n",
> @@ -998,8 +966,6 @@ static int sun8i_dwmac_set_syscon(struct device *de=
v,
>  		val /=3D 100;
>  		dev_dbg(dev, "set rx-delay to %x\n", val);
>  		if (val <=3D gmac->variant->rx_delay_max) {
> -			reg &=3D ~(gmac->variant->rx_delay_max <<
> -				 SYSCON_ERXDC_SHIFT);
>  			reg |=3D (val << SYSCON_ERXDC_SHIFT);
>  		} else {
>  			dev_err(dev, "Invalid RX clock delay: %d\n",
> @@ -1008,11 +974,6 @@ static int sun8i_dwmac_set_syscon(struct device *=
dev,
>  		}
>  	}
> =20
> -	/* Clear interface mode bits */
> -	reg &=3D ~(SYSCON_ETCS_MASK | SYSCON_EPIT);
> -	if (gmac->variant->support_rmii)
> -		reg &=3D ~SYSCON_RMII_EN;
> -
>  	switch (plat->mac_interface) {
>  	case PHY_INTERFACE_MODE_MII:
>  		/* default */
> @@ -1039,9 +1000,9 @@ static int sun8i_dwmac_set_syscon(struct device *=
dev,
> =20
>  static void sun8i_dwmac_unset_syscon(struct sunxi_priv_data *gmac)
>  {
> -	u32 reg =3D gmac->variant->default_syscon_value;
> -
> -	regmap_field_write(gmac->regmap_field, reg);
> +	if (gmac->variant->soc_has_internal_phy)
> +		regmap_field_write(gmac->regmap_field,
> +				   (H3_EPHY_SHUTDOWN | H3_EPHY_SELECT));

But now instead, you set it only if you *do* have an internal PHY. Good.

>  }
> =20
>  static void sun8i_dwmac_exit(struct platform_device *pdev, void *priv)=



--------------2phpSMfOdv9bZhHJID9Gxv4D--

--------------WjBELPf3F7uabgmB8y6VMZz3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK+C+QUDAAAAAAAKCRBqll0+bw8o6HhO
AQDNTwKxbdFOO3HBR7ov+DTnw/uXnyjNqaaVWFaJuQOiOQEAzhxewYt9mzSuZAttEbHzGcz5YxJI
uu3YHjKL8lP7rA4=
=O0VR
-----END PGP SIGNATURE-----

--------------WjBELPf3F7uabgmB8y6VMZz3--

