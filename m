Return-Path: <netdev+bounces-100099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F68D7DC2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D531F24A0F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D97B3C1;
	Mon,  3 Jun 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOWSKduT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782D78C9B;
	Mon,  3 Jun 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404387; cv=fail; b=eIaBOGf63pwiJ7HmoHmJt3sQw0GgJk9pK4UM+GBNIHGLMR4bW36anJKTgdu2Yisu+a0if9KV7C/tT4sr4z9WKoIpHTxonYUnRaeWN4qBi7okbfleEhSSRykRh71vg//dgbkHVMadgHYz5JSrORtAIgc8uDFLtCS0/d4S566yitw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404387; c=relaxed/simple;
	bh=bcvWno5Iv7Hpdc88xC6ul4nnqnOhCrsfzv9+xk7wacc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GsGw+9ASyfUb0Ub7+0durzhIiSGTLGXefv9GV3PirLu88wN7kZLRvaGIfCaVVHPUUMJWtdht94Km5wV+Kog7AssQCxmenZSQBWCAVphOHbhfuhvsx3tLaJQOn7zRtIx3RJa69bSsyhoL+oAKMBJQGsuSDiwioS3iMyxJM7+wa3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOWSKduT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717404386; x=1748940386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bcvWno5Iv7Hpdc88xC6ul4nnqnOhCrsfzv9+xk7wacc=;
  b=KOWSKduTMf2VOnbiHBLAacxiDnNDsTAOduLjXRejuwG46BR0f1PF7pF8
   bsiCETLq0c2xTpoiUTfgUtkQ6lqB5OZc5Elz29tslchbHF+UFkUHwmLRT
   WYcQ3LG1cI70hqgRFkxn22mheutVfcT69vW8ziVMcE8IrUn66hxp5JME8
   0NOfW5PwNUaNfiH84ppenVRV4pkH+2ZHJNBAbEpEdG3EI6BLjp6UesV+3
   jxLSr5GDIs+wmOwaGq4O0Fhq+2wTxu4f9f+Jhw+o5oyQKoo4kNTLoynvh
   nGb6H2qb8qJO4StTETOv0YND4mKw7HLmyX/4KeCOjwjNGKWZ/N/G3bVgm
   Q==;
X-CSE-ConnectionGUID: 4fillbyDSZqHGbJb2U53TA==
X-CSE-MsgGUID: c4PUrD+FSpi6eiZJtvJzSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13753421"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13753421"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 01:46:25 -0700
X-CSE-ConnectionGUID: DK36HEQASM6K4Wdqeat8hw==
X-CSE-MsgGUID: WcWwE5EOStCJ5xpN9XmzYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36892050"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 01:46:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 01:46:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 01:46:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 01:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odcSeOMXnCB+v2wc5+glrPOIcyfhIcO6sk1j0JC4BTBu7GAbWsGYQxW7eDHomcrUikc+4FR/5GcbgFySztSJ2W6+UD7DunHlHt/akwEe3+GNpADfJPZ77Q8fmSZzur9Pvnb+qlynVzYvqjJhIlIuBSfprFlhC1FI0uQaIqFZfInnN2MgE1CzSrbhOgQ4yPKCwJTBlvvUonYr1nzrJri00CeTS3mzXy+KXMS4DtwQup+BqQMFTPm2I8BFyPaR+Hgxdz/Nq2I/MC381Volu84lpVZZNwzVJGAN6q9Ql8mt3wk3P3PYvWRe69QkBNPtuonv0jHAjS2V2FEqN5kE/4J/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kbA5i7jvI6ttWiloE8pwnIgKpHMfQNvuUxcZfN/n9U=;
 b=bnY6hNbJgtZPnjBDf2ua0SdCL3ZksTUD4oDnrWnIKYlZXEUKfuC5p6/OQ+GWFtEBrXP3mq1/Ddge2s/jBPSWSJc2EK/OQm5iAbLMkXEkr2GzJzNDRHDL4x36atGkiY9PveGP8xhzqHirhn0QJxtmVwZKr2TZQTcVoBT5GtxGqcSGKOZ/q7NwMFfOaGfbxTdtcEd8epflNt36gYqqQ7lfOdbxKsEvuc24/dJGDJ8a6qrNHJKa9VNxzcoEjb7SVlVZzecDCsfz3xmTTgj1/5UgOMwBeqKrSc2yKzrATvyHZ+EOl1/vLfNAKpocTHBowKTmhWIGOw34AN6jEV1iUC4eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 3 Jun
 2024 08:46:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:46:22 +0000
Message-ID: <49b0247f-f2df-4b28-abeb-520901a3a153@intel.com>
Date: Mon, 3 Jun 2024 10:46:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] mlxsw: spectrum_router: Constify struct
 devlink_dpipe_table_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
 <6d79c82023fd7e3c4b2da6ac92ecf478366e8dca.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <6d79c82023fd7e3c4b2da6ac92ecf478366e8dca.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0028.eurprd08.prod.outlook.com
 (2603:10a6:803:104::41) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5770f0af-3dab-47f3-edd0-08dc83a9a4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3lXMWVNVFNZR1BNNVhtMTVQOERGbUJrYmkrT3JWMFhIVkZyWitzcStab24x?=
 =?utf-8?B?bGdUbllwbm1QK0NKQ29NZnhZbE94eGtIUjRKV0k4N2s3a0NMTzhXbWRBQ1Nn?=
 =?utf-8?B?YmJlYnhaOWQvTERyNEFDY0c2bVFBUkJxd0dDdXhHK09maGhCME5COW81bFdV?=
 =?utf-8?B?Q3IwbEJid0Z0YU1NZ3JPYjZDRWllTW5PNnRnVWtRZ3pjMkU0Q3ExMHBrTnRU?=
 =?utf-8?B?T1VFMlpsWC9Dc3NBRE9hNVhIeGVZWTJmQUgva01yYjc1Y3NZMmwvVHBqN1JG?=
 =?utf-8?B?T1RxaHdHS2tCTFlZR1JrcnpmV0tkZnNxM2lJQnRacGN6bS8vT2xIam5ad1Y4?=
 =?utf-8?B?QmVtTEdlOTJ1VHJYdkV6MGpObWhIRXVGOUVrTzdXY3B1V3l4RWpjek45Zjdy?=
 =?utf-8?B?bDQweThXK05DNlF3ZnIrZU1VQUFldUhNLzVsK0xVVmc4V21qTm1VOThGZ2R6?=
 =?utf-8?B?d1dnNS9Yc2ZnUDZ4a2EzSm1jc1NpMjNmZW5iNEh2Q3pLWTFBS2VwRVlnTWFF?=
 =?utf-8?B?WlpuL3JuR0p5VG1VZ1YwY01PN2szOU9uU1M5SXI4M3RHOE1CQ2ZOeG5mV25D?=
 =?utf-8?B?MDFad3k2VmRUeEpodU5CcUJtcFR2ZEVEMXo3R3paZnhYRFRIc3ZmalVNLzV2?=
 =?utf-8?B?eUF1cXFXNGFBVGgyMTAwWkhWRjFqeE1BNFNURFI3cEpwSHQ2aURjVW54SVh5?=
 =?utf-8?B?SWhkQW9Eb2pRZldmOGJoOW1aUVpwNXFYWXc0M0l6NWVvU0dUOHJmeVNSQU1I?=
 =?utf-8?B?cDBtcVlVMkxoK3RKd2N3ckdza2grTG9lbXN5TjBpL0RJWVRMM1RUZFZwQlFG?=
 =?utf-8?B?SEpMZGtwbDdrbVlhaWpqSlhGUERyalhRbjF3WGRyUHJtV3ZYRnNKb0ZxU1V4?=
 =?utf-8?B?bnd0aE5KcnY3WkNGZUxxTGxMQ0hwZ2d6MG0wR1p6ZE54aVUvZTU3QkxtWGti?=
 =?utf-8?B?aWtSekxwMTFJK2xNWVZ3RE56QWhJdm0zVHZTNW0yYXY3a05iYjVXUW1BZ1dJ?=
 =?utf-8?B?cjJ5WEgzaUQyUEZ5TkJ6YlN3NlNUcEliV3RIYUxlUnNXbm1DbzBlb1JpOWNq?=
 =?utf-8?B?WXlLNlgzTzNBTzRmRFhiS3BQMC9sWkkvVUorQnRlditMdE54UDdOL2lxWDBx?=
 =?utf-8?B?ZEtEZWtZS3hXL01mUk1keFQ5QXIxN2FvazhIZW11Tmx2dFkzMlRlc3RRbGVo?=
 =?utf-8?B?QWVPYkVrc3FVVzNYZTFIM1cwTlNNbzNTekk2aU16Y1V1dHplK0xXZWJkdEh3?=
 =?utf-8?B?VzFWVzdPazdta3g5VFcxWkIrR1ZoUkNlQWVjL1ZkWlJ3QmpPU05uUFprTFlR?=
 =?utf-8?B?dGdXc2Y4N25IQjE3WU1SemYyUGpDL3NjRjRkb0pzalRLaFlmbTJ3Zk5XSHY0?=
 =?utf-8?B?UGhDTmxza3dKOWQ1dW16MUNTcE5IRXB0bWNWbUhxRS8reTlrOGRSdzlTTzAy?=
 =?utf-8?B?WkFINXpVVWhQZmZtUW9QRXpLWmhsQnVwSEtRNlA3ZWhyQ3RWVGk3NEdKL3Fm?=
 =?utf-8?B?cC9LWHpXaGtBajhNY3pBaGdtalBqT1ZLQ25RZkFsZmNTQTJVR3pyaEc5TmVP?=
 =?utf-8?B?UmVBOGxRNjBqTlRCTFgrZUpLcGI3Sy9tUkx4VWJtYnMwa1NsUUMzRXZDSHI1?=
 =?utf-8?B?RTVraWdUV3ZBMW9TMllrSlhmY0plWE1RajAwcUlqMFNXZlpkbTJ2K3FuUkNk?=
 =?utf-8?B?c2xDQXJQcm1Cc1Irb2JxUjNIdW1SNTFIN08yZmluVUxubGJxbW1hYzdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNldFdGRGVDamlpdzEzeGt3UWttK0N4bFJXUXF1THFMWXVvZVJsRXpsZ3dT?=
 =?utf-8?B?OFAxL3ZTMzNWMEZpZmNWNmNXV0VXN3hySUMvSHZiUldIN01rTVBpaXZiWEZm?=
 =?utf-8?B?TlFTMzlOYkJXYmhZMTBldWpVMExPS3NrNDkwWU5QV0EvQmJ0Nzk3dmdMWjAz?=
 =?utf-8?B?bHhJcUg5TU5FRm5CZzVrVWZjSDA5ZTI1VTA0dmVxYkRjeGFQRUVyUzBtdjNs?=
 =?utf-8?B?QVJ6R1hieVRuOStJbGlGd0tNRG13N3BXVUN6RU9jaHhvRVJ6SVd5ZS9kMmV5?=
 =?utf-8?B?RWErQVQrb3g0Y3h4MGwwclU2endnNDlGWWVkSERDUUJnS2ZRTkE2Sk0yWHJN?=
 =?utf-8?B?dWtObzJFdmhkV2pvNGUzWkFOTE5OWEMyRDJnUjJHYytaUk80UHlISVBLMjBp?=
 =?utf-8?B?TURQL25FS3BXRHNYN0VQOXAyems2bDVQVWptdjVyd1JzemEvOE5XVngvOFY5?=
 =?utf-8?B?bHU5QjF2SlRKbmdORWRKaWRZcndOdTU5dXlYcEpxbE5kOHphMEhDSU9VVGxx?=
 =?utf-8?B?L1VjODNydllManYrTVJiU3RoeThPZnY0ekFKRTdybWRtcG1HNFZLRVMvdnNC?=
 =?utf-8?B?QTBOU3ZBRkU2U2JJNzJ1WE9wNTNSd1lNd3RPUEFVMlQyUjdkRzhld3gvcFo0?=
 =?utf-8?B?N3pNUGRKWGtrTCtkWDJGbGU0c1h3Z2NVdiszL1VGMkRWWWVoYzdNaWgzUG9X?=
 =?utf-8?B?M2dWNTU0d3IxNXhubFkrcjQwQnpHR0VSRUplakxxNkhpV2JJYjlrU25GZU1p?=
 =?utf-8?B?M0xiSDRVak9iMDRoRGtIWFNBRC9JNTBqOURjRDBCa09jV3JBbCs3M1o4UDdj?=
 =?utf-8?B?Z1ExVlcwZWxXdzhSWm96Q1paNlkyWHJwMzJudGd3RFpVUDVPVVZmYURRTDlq?=
 =?utf-8?B?NldwbGtSeFpuaFJSYXg3djZDMlFOMnEyaWVyeXc1N3RoaWhHQ3YyY3dIWFVq?=
 =?utf-8?B?N3lObVh4SGZtZlBZQTRCUUdiYW1KVjNaOHJvVzNwSEpIMnk3YjduaXN5NCs0?=
 =?utf-8?B?V0Fndjk2STExdkFQSDZhWGtkRGpjY2pjcE4zdTFTR2h3Z0tEbmFEVUplS2h0?=
 =?utf-8?B?OE55VURDWjZWM1ltNjdJZ0x6S2h2WC9MRTN4NG93SWpDRXp0N3FxS0VmU29w?=
 =?utf-8?B?VUdjNEpQNnNSSmZSanJZblpxQk51OWZIVjdOanBTbGpraHhpS0lZbE5adWJO?=
 =?utf-8?B?aGQ2dnllTnNPczJISnlCL2FPeERFakFrZTdkK1A2N0djUjFEa0tuc2d4MjVz?=
 =?utf-8?B?ZnNxd2hpeHRqbmxMLzNhMzZNWVBPbEd3a3VmcVNpVmNCMGJXdmlOU3JWRG1j?=
 =?utf-8?B?SWZUdEVsbHIzbTJMSG13NmZnc2RHMDdFWndzVDZBUlZFTG9udm9vVjhmaDcv?=
 =?utf-8?B?VUlFcnUzR3JBbk5oOFp5ZEE1R202c2Q4ajhFNUx1MTdGcXowRU1sV3dXTHhG?=
 =?utf-8?B?YlYwYWsyYnhuSHZuQ1RrODVodTk5enhMVG53eTE2eFJPRkNXWGNKMnVCeWZu?=
 =?utf-8?B?bW00anRRa3I3aGcwZm9wNGFFTllzQjc5SVZkbm5ib2dZbzZrbXl5QUs5SHc5?=
 =?utf-8?B?ek1Yc1BscDhEZGJKZHhJV295aUQzdFZCTHNoT0tmZEc3L3NCK1I1NEl0Y0Zl?=
 =?utf-8?B?OWNkakZGMkNjV0liZUdNTGk4aVFyMTBEQmhxQ2FZSndpZU1XOGxJdXgzbzRp?=
 =?utf-8?B?NkNhRzI1TktsREhTZllDTTdEMDRQSnhaL09MRlJUeGtQOGJ1TEZpVFIzTEpt?=
 =?utf-8?B?MG9ydjVjaDg5TXU2c3JJRUVoemxvdjVqakM4RTdxOExRczFWbDZZNERSUlZK?=
 =?utf-8?B?a1g1RHlSRVNCMkhXVEd6ZUhsdVN4a0lEcGV6V0NWVFFWTlpnbTExMWJ6OHlV?=
 =?utf-8?B?Qjl0UkRyOStZTXI4T01scmxuV0xodmtSUGZuamZmMlZZOGlrbmxFMWgwQ3lO?=
 =?utf-8?B?OWFyRE82TE5OMk9rUE9ucTJFUUVuSDBWQ1NKajJpeFNmVHk5WEhoUHVBaVBQ?=
 =?utf-8?B?eVFRWlNGR2NjV2prUzNNOXdJQnBtNkgwdWdmOTFBdEd5aFFNT2p1L1dsYWtm?=
 =?utf-8?B?b0xmR1pOVzVrZFJ1Q1lpbmhWazhDMlg0REdjblVZbTlmVHk3WFRPdzRWQU15?=
 =?utf-8?B?Z1BDOWlLV1Zzb25WMmI5Q3dTY2xIYzd4SzRzbW1IenBITTd0RmZlVXpDL005?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5770f0af-3dab-47f3-edd0-08dc83a9a4f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:46:22.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyjaXHQBE4IhSOqQlGztuPoGKb7qUXpeUzsAGkpKrJEQE4P13EmkGcLvpcKWAtbWV5LuCUr3OVbJyuHqr+jIoxGROHYH6DiVRYNCu1UeZ78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-OriginatorOrg: intel.com



On 02.06.2024 16:18, Christophe JAILLET wrote:
> 'struct devlink_dpipe_table_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   15557	    712	      0	  16269	   3f8d	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   15789	    488	      0	  16277	   3f95	drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
> index ca80af06465f..fa6eddd27ecf 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
> @@ -283,7 +283,7 @@ static u64 mlxsw_sp_dpipe_table_erif_size_get(void *priv)
>  	return MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_RIFS);
>  }
>  
> -static struct devlink_dpipe_table_ops mlxsw_sp_erif_ops = {
> +static const struct devlink_dpipe_table_ops mlxsw_sp_erif_ops = {
>  	.matches_dump = mlxsw_sp_dpipe_table_erif_matches_dump,
>  	.actions_dump = mlxsw_sp_dpipe_table_erif_actions_dump,
>  	.entries_dump = mlxsw_sp_dpipe_table_erif_entries_dump,
> @@ -734,7 +734,7 @@ static u64 mlxsw_sp_dpipe_table_host4_size_get(void *priv)
>  	return mlxsw_sp_dpipe_table_host_size_get(mlxsw_sp, AF_INET);
>  }
>  
> -static struct devlink_dpipe_table_ops mlxsw_sp_host4_ops = {
> +static const struct devlink_dpipe_table_ops mlxsw_sp_host4_ops = {
>  	.matches_dump = mlxsw_sp_dpipe_table_host4_matches_dump,
>  	.actions_dump = mlxsw_sp_dpipe_table_host_actions_dump,
>  	.entries_dump = mlxsw_sp_dpipe_table_host4_entries_dump,
> @@ -811,7 +811,7 @@ static u64 mlxsw_sp_dpipe_table_host6_size_get(void *priv)
>  	return mlxsw_sp_dpipe_table_host_size_get(mlxsw_sp, AF_INET6);
>  }
>  
> -static struct devlink_dpipe_table_ops mlxsw_sp_host6_ops = {
> +static const struct devlink_dpipe_table_ops mlxsw_sp_host6_ops = {
>  	.matches_dump = mlxsw_sp_dpipe_table_host6_matches_dump,
>  	.actions_dump = mlxsw_sp_dpipe_table_host_actions_dump,
>  	.entries_dump = mlxsw_sp_dpipe_table_host6_entries_dump,
> @@ -1230,7 +1230,7 @@ mlxsw_sp_dpipe_table_adj_size_get(void *priv)
>  	return size;
>  }
>  
> -static struct devlink_dpipe_table_ops mlxsw_sp_dpipe_table_adj_ops = {
> +static const struct devlink_dpipe_table_ops mlxsw_sp_dpipe_table_adj_ops = {
>  	.matches_dump = mlxsw_sp_dpipe_table_adj_matches_dump,
>  	.actions_dump = mlxsw_sp_dpipe_table_adj_actions_dump,
>  	.entries_dump = mlxsw_sp_dpipe_table_adj_entries_dump,

