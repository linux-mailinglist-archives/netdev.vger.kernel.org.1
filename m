Return-Path: <netdev+bounces-236908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337FC41FCB
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 00:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D684203E8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 23:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC2731619C;
	Fri,  7 Nov 2025 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6vLHDUA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0E314B93;
	Fri,  7 Nov 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558690; cv=fail; b=Gu3sQxciKDqfC7PWpYNlZ2hoePpwXJeuahk3IK1GjqnaqSmlEFuVcLPT7qvDaSRs8rBnliLwfTa0ZQ8jW8/n7CkdFGFliitBqGlpBwUlfPky87nLCu+1Qq3+RfUpRbElVADU/UkP0npCpjYWqjAUPQPKPo99SiYAeqiBxhQpxAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558690; c=relaxed/simple;
	bh=nkkb04yZD3oysscFHB7kQCC75JIKhjSU6QymWDo/hy0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9ADhQFBK5QV+dggVc7fufhQpokxb6eX3LsO9SGgppg0g/WCImxRWE6mLOesTmgAz/O6+7nDY/xEKUj+HzTHo2lYHMKY1CfjjmW/4jffVeIT65A2NV6o05/R1KBAKLBbY2d8s3VsT9/YX7Iyo8FWIuhXTRc+7OcGZqieW2lyobQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6vLHDUA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762558689; x=1794094689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=nkkb04yZD3oysscFHB7kQCC75JIKhjSU6QymWDo/hy0=;
  b=g6vLHDUAL1WTLKv6FNDXWajAmFVXlxNlIhGOGBwzN3i6FygOV3QkOpqV
   x3ZYG6cjC1qY9Gn9nv5p199EuZgZChhVwva0C391czrwkdOVHUtE/Rrit
   ck4hF2nWeFTPEClfXw3C4ytW2V1MBMZ0/V9wXAugkAwtKx8bQXyvYugz3
   /YdBwkh+83/eed/yZeqalNPGgkhxr1Q9H8uxSANpR0YFLUHCB8c3qIrgq
   G9FIpypYRG00eZ9Mfjd4ZMg5OhTdxNsbURcYcP7LPeyNvu53I4YNeITem
   e8+b8BMRPWQH/7uR3ZlpiFY6Uvm2WTk1Z2aWnan7aNOqyywu44I4YotiC
   g==;
X-CSE-ConnectionGUID: Sjtja8+iSni0kDwRmkq3Zg==
X-CSE-MsgGUID: Al8lgIQlQpaX9yPIIbqXAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="63920824"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="asc'?scan'208";a="63920824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:38:06 -0800
X-CSE-ConnectionGUID: 3Tdz7aUoS4iJP/KBqlTQJw==
X-CSE-MsgGUID: DTccW1KQRdOgKyeQ9QL3/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="asc'?scan'208";a="187464302"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 15:38:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 15:38:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 15:38:04 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 15:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4Fr6sPr6oPzympH6Mi4hYMyrsaLeEPxDJ10J2J/ygH3pYIO/QM9/XRaDVUstlpPc+eDmzojdB/9y143TeZY0kDpiM9HTWrzwVILgCmnyuukpCSmsWocYnPMRqHfzLXUguYI4pTUJyEJfG+ugi9aVeoEOC7yjHwSff+yU7Uncc/frLzNqrRhQOPuv5TRVWg6QQKatdAb5K//ysAyImmftyU41Ziis900IrC5MrFPzGZ6BvoQISc2Gey5lIaDq/pm1WGHhNHD/ze6xLHGjHDYy/5CgNbmQd0OMjfip3y/wjuEujX9SH3sr8XxnXdRk0Xx6n9CQuFPBTpCuZxwNSpsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjydaEjfBi82qzEc0YqJp4EbwXVdRmMrDge1OnbHIQM=;
 b=PghswtezwN1EKL+0W7t5pU5+jYftAla/y2APVxQD5sBHGdZxZICf2UFMJUJ1fBy2n3KZZOewusImtGUursrdE2PoaK5lXQgNzp2g/32BrdqK2vwM4hSAOEl1IwaLdBy2pFrKAe+vZwNs8lHmkOTjTDOFwV2Npju9tZUyaONlTFvabB+JbM/TOXZ7dzQ0UiN3Pot8V6ebboSh4I+JbHdz/H4r6MOErBC7U4IgvqE5tDuXkpwiZuusa0LVjzPci1WOyOXVA3WlU6AaVyWC1szoVdbHR/nFJCWksna87sKePbT2Kv+2iyHj8GAR3241wWAwffipmRYjZQaL0aYxiZAl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 23:38:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 23:38:02 +0000
Message-ID: <0364cc46-6960-4927-8ab0-23600304d445@intel.com>
Date: Fri, 7 Nov 2025 15:38:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: protect shutdown from
 reset
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Emil Tantilov
	<emil.s.tantilov@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, "Josh
 Hay" <joshua.a.hay@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250410115225.59462-1-larysa.zaremba@intel.com>
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
In-Reply-To: <20250410115225.59462-1-larysa.zaremba@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------LkWrSAak60zmqSNrMrorNPdo"
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 96714fa4-caa2-4855-1883-08de1e56b11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTk2MkFQM0xMVGlGL0xya3FWKytpUDJzRGYyQnRMcGRoLzd2WE1pUEVTOGRV?=
 =?utf-8?B?ay9LVmlEK2VHdGNiTFFuMlRpWmRUekhpT245T0dWaW5yYy9hdUN1WmVFUWNn?=
 =?utf-8?B?ZC9BZE9HSGYva3Evc1Bhd2dKSkxnaTMvakdkbWEzTFMzWWpLR2M4VWVoN21H?=
 =?utf-8?B?TnY5N291dUxPeVMzaW5PYkZFVXR3Ni9JNzdwZ0VkRjlmTUZzWVVISjB5ci9x?=
 =?utf-8?B?eXk3RENPLzJyYVJxVU04V2ZzWFNHSzZzNTRzWGN1UlVVUkxWUXgzVnF1aHpp?=
 =?utf-8?B?dHNza0huVjRrcGJEQjloT3IxUXJKNm80NHhnL2ZPQlNmSGRjLzFwOVNlbkE0?=
 =?utf-8?B?UVpWUS8xcDBCZjhkM3BEM21PRlpJOThlem5vb1FzNDUvNU5ici8xYVBxYThq?=
 =?utf-8?B?NXV3QS9NeDFxRTZORXRBQjdEdWF2S25TaFZ6UWhRTEd6L0VpUFJPUU5YVE8y?=
 =?utf-8?B?REZsUjBvbTU5cVVPa0VUdUptZ1FkQmx6NkpwWlFUTU1MWVp5NDl3ayszRk8r?=
 =?utf-8?B?aU5kd2ZGOGIvV3dWOFRwdGpsMHhwcFl3RWJJdkNzcnZRZG1KVU1QenBKK21K?=
 =?utf-8?B?WElRcW1DSUdwN0NWWFNjV2U3bWRZWCt6VkZDVjJuSWh3ak5leHVUWXVyNXd5?=
 =?utf-8?B?aU1oTVNuS3lURjVndlNEOUFqaWEvN0FsUnBNTHdMajIxR2Uwd2huRGNnOUND?=
 =?utf-8?B?T2NzNzJMZ016VUdjWlJHcTNHS1M2c1ZweGc4dGtDWFJpSzR0SDR6czJVZDRU?=
 =?utf-8?B?REFTdnp4azlwV0hYczBxQUY1TmdmcWEzbk9INlNzV09UekExUm1LNHBzTFAw?=
 =?utf-8?B?a3hyV0JvQnNBMlFVL0MvdHI3REFjN2U5MGFvZHZYVnlEY1FwM1Q1UElqdWRa?=
 =?utf-8?B?akVaQThPYSszcFNGNVF4R2w2aDBxZ1FWemxRcllnald3SEg3MjczQXBVRDE2?=
 =?utf-8?B?ejVJU1BjQ2txeU9yV1dzNklma2twWVg1UWNBaGNVZTJNVm5FWkpZVG9pUjJL?=
 =?utf-8?B?WC9Lam91RDVQNWYwbmRNTndvcU0zQkpIc2pDZjZxbzBMcG9XSXp6Y1NsbkNh?=
 =?utf-8?B?d295UjZYQTQzSE5LRUxjSFBaY3NOd2JFVVFQSHl3R0VzL2JUc0RMS2tFMG00?=
 =?utf-8?B?M1hnTlZEbmhBWWhqbnVYM004RTlYQUZUanExazgyb1JFQmR3RTJDM2tMdEc4?=
 =?utf-8?B?Q0VzNXRCTGVZUEpScmp3M3kxelJzd0xGM21CNmVIVnI5YjRtZlMzTEtObzlF?=
 =?utf-8?B?ZTIyNlVHZXhZSHVTWHJlbHFoZlZ0Nzh3MjJBTUJNUWx5U1U0Sml3d09yZ1Zw?=
 =?utf-8?B?RVFzd0N1RlBKT011Wko5WDVHVjA1d3FuTzRhRERBOG1mZ0FYN0hxMXlDaTY4?=
 =?utf-8?B?NnM0MXJUYlBwM3B3SGRMWlF0NHo5Vy9JWlU2dnNzald4UkdCQ3Q4dTE3bFAz?=
 =?utf-8?B?em9ZMi8ya2RtbHBMamtjVCtQakFnbXpTQ3JXR3JHZVZTSlMrc0dyWnRTZSsv?=
 =?utf-8?B?YmkyV2k0cFNZVmJOekhXQ1BwdlNpWitHVjJMOFNVQW1SdjZ1bzB1WnBJZ2tD?=
 =?utf-8?B?VEt1c3dsK01kVWlZRjV5M0tmdVc5aGdid2NtV1ZaNFk1Mjk5Ti9tN05ydERZ?=
 =?utf-8?B?VDZ5SHE3M1h4dmRFa0NOMHcrMjRnZGNEOVc4eUErRVlGMG0xRmtVcEswclZi?=
 =?utf-8?B?NzFGeUZ3bXV4UFJudzZzUC9GQTRUbU1HMzhjVEJTM014Q0F0NHkySDVvSHpE?=
 =?utf-8?B?MTNFLzZhaU5lZnZwbHJJNzc0ZUxseVlnSFN4emxHR2V2dFQ3UDhOUGphbHBa?=
 =?utf-8?B?bUdoNjdwTmtWaGdNT3l4RFRIcURVZUN0UWcwT3lrZFVweGxyekdTY3pOZjl4?=
 =?utf-8?B?cjliU1FBLzF6WU1wamdHQWszSUIwY09qRjM4ZVNTcFNkd2FmVVpNK0Q5eW0w?=
 =?utf-8?Q?Gq3EI0DzvBfFfcQhmXjdWco4+0vIm2eR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkE4OHhwSGVLM29yVklFVWFBRUJqOVQzaGtJdVgwcGdCdE5KWjhQa3lMOFh5?=
 =?utf-8?B?VSt5Q0Vwc3NqRnRQS1Jsb1YzVnYvV2ZVUnhxRVFwdVlWYjBicnIyTzZLZnov?=
 =?utf-8?B?ZG1wMUVmcFBaK1JDU3EwcVlTR29RbTVCRVZiSjFXalB2SUkxSHZHaXh0RmZR?=
 =?utf-8?B?OHk2QmlWS1F2UVdXazBHQXJkTkhqYlUvZ3BuQkxFV2hvM21aM2s4V05YNUtL?=
 =?utf-8?B?cjhQRStCanF3TDE5a3pyKzB0SWozZVJBTXNaWTdMQ0l3Ymo0S1lyaDZVZmt2?=
 =?utf-8?B?bXp4NEF5RHhHemFROTJ0aHdEdExzTTI2SlZCSWR4SEg4Q2NaMjcwaFI3NitG?=
 =?utf-8?B?cXF4WGtnTjJWU3h0REx5Znd5K0V0b1VXNFkwdi9rMWpTNVBhcVZHTDFhcDBq?=
 =?utf-8?B?MjBQTjVrVHFqUGdBU0g1WXBXbnVLWHVIUEZTR3I2MFVSNGFaT29NaytOVkVB?=
 =?utf-8?B?ZzJ5NmZHY1Q4ZlZ0akhBOEF2VjAzQjhCZ0FGZWErYzlsTnVHQmdBZ3VXZmxp?=
 =?utf-8?B?bTZVV3Bvdnh0RGJBUWtXZ1g4cmNyMHRrV3ZPZ2VZQ3hhMHVxVG1JNGNoY3FZ?=
 =?utf-8?B?OUNYcUdnZGI1S21HMCtPcllEUytOb3Q2UzE4Nkh5bGY5QXduZlc0Z1UzdGgy?=
 =?utf-8?B?KzROMjVLMnRQWmFpRnFYY0ZqaGlkS2VRckg5dXVEN1VpK1ptaHk0eHFReUdS?=
 =?utf-8?B?Yk9UTDVScnIvYzRJd1l2MGhONUJvekZmbVJMMkFQQ0thQ0JjQ3R1ZGhQMlA3?=
 =?utf-8?B?SXJQUkduZEo1REhzbU1PSnBvWGh4M0QyT3pOenV3akRSbk5YNG1pL2hCT0d3?=
 =?utf-8?B?bWlmelg2UDZEaGthWDE5Z0IwZU1NNklKa2RTNU1xSGExc1VCOVhPdEUvaUtU?=
 =?utf-8?B?TXluRGlYaG9mNjhpeGVTT0FqUjhPM1hWenZKNUgwRWpkN2JGM2czNVZSZjRK?=
 =?utf-8?B?K0xTKzI2amxEclhoc3VJSGVIclNHcWxvQ0k4dTFBbGhRRHRrYUgvQTZSekdt?=
 =?utf-8?B?R3RMdkpVcWVGU2tyV3JHWS81SXlaM2RzT1pZWlJFeENlTDZRUnhOczNNN20w?=
 =?utf-8?B?d2Q1MjBBbU9XNnJ4Nkx4elBkMUpFbVFLR1VOK1dBSmtHQ2JDN3M4dHJQd015?=
 =?utf-8?B?NjcrUWszN2M1MXBLS2hMazFuVjcvdFducVRZckNhdmhGSlp1VTNEMjhkaTgv?=
 =?utf-8?B?cnF4NXNnR3B4VVEvTmt2RjhTMnRQVzJ0UUhjSnc1a1krY01Vc2piVjhPVTFk?=
 =?utf-8?B?WTU3cjNxOURDWU5xMVBwdGVKRlN4OEJKNkwrK3lIQXZiSURjb0hQZEFnQ1F4?=
 =?utf-8?B?dk5wZ2NzUWsvK0NUOTVBcmNwdGhkTTBreDFxTTJtSm9Dbm02d2hxdDRFYkha?=
 =?utf-8?B?RzNnVHpKci9ycVFZeGYzTk84VW1zamlnaWRlblVOZ2VPUEtoUmo4enNlaU9m?=
 =?utf-8?B?VGE1dzNyaEUxbm9yZTVSdUZQZVpMd0JqeXVybUJOVFdMWklhcHlqcjB4UERG?=
 =?utf-8?B?NWtqOTl0SFpMbXZPMTNybW03TEJsVnlESmZpcEpqSkZRQ0puMzBEWTNvaVg0?=
 =?utf-8?B?SkFaV0huU2duUnYxV2liUDlZQ0ZQZmJaaFVManozay8xYjc3Q3BCRERrQmJG?=
 =?utf-8?B?a1BiTnJoVUZUNFpya2oxRjFFMFN3MlB2VEhKY2lSWWp2L0ROY2xHNWVKUStK?=
 =?utf-8?B?QkQ3ZEM4SGQ1bTNLVnZ0SmtlNm1kdDhxZmw3N3BiM3V6QUdtaTdSVzU0K25S?=
 =?utf-8?B?Q2IyaW9meVR5RFh3ZXY5MmVVWFY5Y1FnVWJnOFJ3UFFIZVhrZWhscnBLSDlx?=
 =?utf-8?B?Y1FvZ1BVRk1td0ZVZTlhMEFETmxvUFEzUm5MVHFsdVp4TXVYU2VrL2Q1TTVV?=
 =?utf-8?B?YmRma2x6V2cxK1Z1VVNnYVFLMStIeEFSMk5MeG95U3ppb2lXZ2dGTDA4OVhO?=
 =?utf-8?B?NUcyYlNXSnpxa3Vra0k3eGtTWDJCYUYrdVNKZnF1SjRBTWZsd1lYeVNvQ3d3?=
 =?utf-8?B?UnFCa3JSbEhVUUZidEpUV1ducEthdm13SDIrV1pFbUNZZ1o3aDdMR2RGQnl1?=
 =?utf-8?B?K1NUZVlyZGdzOW1SZkdBRzAyTE1Od3NDSWkvUXRhL0FLVlV1cytSMW90MUpT?=
 =?utf-8?B?UVEzbjV5MTJsdlVUMDd6R2RKTEx3VWFYNmd1UkxmQzRrWkF4OGlkYkwzTnBV?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96714fa4-caa2-4855-1883-08de1e56b11a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 23:38:02.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS56fFp2Y9uEQNk3Wf2EtrMP7to74nLvzpiHrraQCUYCIoWHE8PvSca6kMhKqwFeUOaW4ypPc7/zUUDwuiQ9wI2CT9Mll7XJGQ5E7q0d/+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com

--------------LkWrSAak60zmqSNrMrorNPdo
Content-Type: multipart/mixed; boundary="------------yVhI0H1fXg3ISat31fChQg9q";
 protected-headers="v1"
Message-ID: <0364cc46-6960-4927-8ab0-23600304d445@intel.com>
Date: Fri, 7 Nov 2025 15:38:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: protect shutdown from
 reset
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250410115225.59462-1-larysa.zaremba@intel.com>
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
In-Reply-To: <20250410115225.59462-1-larysa.zaremba@intel.com>

--------------yVhI0H1fXg3ISat31fChQg9q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 4/10/2025 4:52 AM, Larysa Zaremba wrote:
> Before the referenced commit, the shutdown just called idpf_remove(),
> this way IDPF_REMOVE_IN_PROG was protecting us from the serv_task
> rescheduling reset. Without this flag set the shutdown process is
> vulnerable to HW reset or any other triggering conditions (such as
> default mailbox being destroyed).
>=20
> When one of conditions checked in idpf_service_task becomes true,
> vc_event_task can be rescheduled during shutdown, this leads to accessi=
ng
> freed memory e.g. idpf_req_rel_vector_indexes() trying to read
> vport->q_vector_idxs. This in turn causes the system to become defunct
> during e.g. systemctl kexec.
>=20
> Considering using IDPF_REMOVE_IN_PROG would lead to more heavy shutdown=

> process, instead just cancel the serv_task before cancelling
> adapter->serv_task before cancelling adapter->vc_event_task to ensure t=
hat
> reset will not be scheduled while we are doing a shutdown.
>=20
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reb=
oot")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/idpf/idpf_main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/=
ethernet/intel/idpf/idpf_main.c
> index bec4a02c5373..b35713036a54 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -89,6 +89,7 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  {
>  	struct idpf_adapter *adapter =3D pci_get_drvdata(pdev);
> =20
> +	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
>  	idpf_vc_core_deinit(adapter);
>  	idpf_deinit_dflt_mbx(adapter);


--------------yVhI0H1fXg3ISat31fChQg9q--

--------------LkWrSAak60zmqSNrMrorNPdo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQ6C2AUDAAAAAAAKCRBqll0+bw8o6CN0
AQCQpj6QhHIeuY5xpuNuzN4E4lnxdv346ZQruQsvXlOrOwEA8PoiMTyA8rWa0p2whDZYijOaak+N
eh+JaRraD0y/Jwk=
=BkhW
-----END PGP SIGNATURE-----

--------------LkWrSAak60zmqSNrMrorNPdo--

