Return-Path: <netdev+bounces-263284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIi7BPMBp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:44:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1221F2DE8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5214E3022042
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C573AE6E9;
	Tue,  3 Mar 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkHviKAw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6757350A1B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552270; cv=fail; b=Q26CVRKPShuqxdo1TLWu+UCRCq4l4mb/9v1O8HPuHvzy/zisgp3lNxbUGu/BM+bI3surQa2jSVui+vmDQIs8WCW5O2f4ziRIV9Eo/axnw9RFlnnMUj66HVcDCWgf3aVNnOf0KYtH7Xfo4f2/vqyDjas6QlparZS2HAqdK9ZgvQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552270; c=relaxed/simple;
	bh=pp7NZGi96zhFD/R4leUwhqOQ0qVVNURcAzs4NnlnjmQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oKn6VMFuFiI/VIEyjkIX8Yo99kqS4kPRmaD4hc9uJuVw9/Zjx3Y3LUDrsXnorYwRDhg8wD+8vbbR4KEcgW71N2hm9h2z1vwRId+aPhIgdCbFd4Jn4kzYxvUJJ8P1tsM1h7cyD7VJP3z5OEJr9z5vDMacDIn+MUqqHZuZ1AN+teI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkHviKAw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772552269; x=1804088269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pp7NZGi96zhFD/R4leUwhqOQ0qVVNURcAzs4NnlnjmQ=;
  b=MkHviKAwykP6BK6dLrnc3fO0WRlpUZF20Q/9B1eEOmCvvVA1Mlf/ZBwe
   x94QneaUVZygK91FbT8g0U+Puts2l+o7cKGOa3VMHxobsQ7prA6A0SqLS
   ixouFm+1NBOdR3B5C4UPDk0e5gSK+3SXZNhXLN3QY0oGNNvAPj/pup3rp
   Eebj9zH70pVLY8Q5bovK1+/melMGChA9EamgRaRx++EPZH9Ap/36+J4qS
   ZfSlDAOCl8jVyQ0Z1J/0bFyK57/V49+A6Wbxle/tkwmoEdFIza0MJTpdR
   +1vVIAhOuO8feOK3a8szRVU1Wi8T+oudVwGJIZCByUcCIthmH+Epncvjc
   Q==;
X-CSE-ConnectionGUID: PIpxDRE2QD+LPbAqriKSAQ==
X-CSE-MsgGUID: aMpapSRoSEaKZH879rLOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77436595"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77436595"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:37:48 -0800
X-CSE-ConnectionGUID: 8mTE5S0fSkie2SfiRT5xVQ==
X-CSE-MsgGUID: 228bfR6QTmOgUDDrg5MVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="215100196"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:37:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:37:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:37:47 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvcny5Wj8O40EA+7a2lHB/ACEtx7l6xbVmAA92CcNeMzX5ft2o3tcFMMlSwD/z6xmTWcvjxLMoNrsLRYuZF5VnCvfiAGEcjy5UN2xpIK3nFcCmMUCK2+n2ADTuJxqqiLHbwaGZ03l1eIQbea3868GfsYbxg4ai/QvzqLxBN58ExJlrY0Pz+MdTQOgX7kfDs2d0nf505Lg7nALedn8td+qEs2yvd1IeXzBpuFhcWy6zmy2+xK1CuoOg+vkFvXC+djiHCSIM9Xpbp51JtTniQxWAd3KDAWIg2uF775Pd9MPdbltsY9CWxT20U4hn4CYvDRciUMK9aGeX35vx8FMWDOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0j2asu7rsA48BpXqOpuVvOenwAIVfAtPcljFvhGPl0=;
 b=Lj02nfYUHfSrc9YcA0Za8nWHqmgkuWRA7rElhBXyCs8v5sUD3+EfoRjSfsd14K632HYY5s6FAEVxXkRyhBBIQ3mx/MRy8WOFoqnllkEsQKBi6etD36avg01IvRUDsNv7dzeyXHM0NevQeVDvrg2EEbStz+gP8/2NTjaiWURSxSyonMMhyT9LVc3q1xMx735D7TYxgSGL3zSuUO1WPkZC/zC2TW18mrCpaIzeYPPVNjlEvsAnZxeUUZZRDjje6iZRzQC0e2oOeTj7ZXzRAnppSrfPtjjT1bWgzyIulCtPY0UyFLcy6TPg+ynQBLmFOwWqtplNjzpJg8WMv39zyJKX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:37:42 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:37:42 +0000
Message-ID: <b348c8e7-4c27-4e0f-8e0f-0679082d51e7@intel.com>
Date: Tue, 3 Mar 2026 21:07:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/5] drm/ras: Introduce the DRM RAS infrastructure over
 generic netlink
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<aravind.iddamsetty@linux.intel.com>, <anshuman.gupta@intel.com>,
	<rodrigo.vivi@intel.com>, <joonas.lahtinen@linux.intel.com>,
	<simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<raag.jadav@intel.com>, <anvesh.bakwad@intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>
References: <20260228080858.3063532-7-riana.tauro@intel.com>
 <20260228080858.3063532-8-riana.tauro@intel.com>
 <20260228080414.6f1256cc@kernel.org>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20260228080414.6f1256cc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::6) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SN7PR11MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ef2738-73b7-42d7-6336-08de793acee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: aMBSf9Z+THDiEjxGtlCb9P2cpq8kNW4z1tutaGcEReHJtSopODiEZTeIvYudEYyUfL0IOBXTS7V/3Pd/zD9n5cXIudC5mZ8hd5Usn8LAIKH3R6rh7PUHrDR4IGUuq+Yju0QGgnZXblyfz7DVG/pj/wlfJ/erME6e1iT1K3dwZFfsLKDs7pIaAjQj5/3vC5h4/Yrt56rRR0XU0JaMnpEoPwtOqn7ZXfiKpK179dIklS44BzXdfzDg/AyhCkFAd9oO1vTqBeDSro8jSTB340ewppH+wmZ00NeWkd+6L/7m/Vj9qUJ66VDnjpnbgkgzJcnpKKbmP7ylC9Ci8WTiDTJ0x7+LetNBYBQX+JfUEzxCpvbfoTVCjoj29FEUfQhy0hMOlHTOG8nO1TAwatRJug/CCdiurhVTDXlwj1ZKiV+c7RKVpzFv46AtoSJ528wnAAjD1dLjY10MUz5BSBRlHUaeeaORESKblXoybeNXsJN5of7QQzuolOScPVM8IZ4VxRmu5ZgH0lwLKw4aRtxgkyTQ/bKt+6MUrsOl4KA5e0IiekmxtIKvxVoaoJAcPobHnE7HT9fgkLM+XwSqHqFZZyRZHImVFqPckShZTaedRR+HPRH8xQmAHw+6Jv0iXxccWOX7xwLcFUZ/1m2h3e+1Y8cwFArk0+8nmE19eZF6Mto6joaf9sGSniaqXSh6Vr8wS18Ry1817nak1bTdlYpNhv0hkjoEvE5DjgXSjrgaI+lySGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05TTVRyTzRPTXVnNnBBYUpDWkpOK3dHazdQWmhacVJUV2pBMDhRZnM4ZHZD?=
 =?utf-8?B?VVVETHNza2RCNmpqS2lSVUNaWVNiRVczUDdKQUlOanVKZ0tpT1pFNUVJVTAw?=
 =?utf-8?B?aFBQZFh3aDhaL1k3V01BWFBDQnVFL3pRbktBcVl1M3hkSEFMZXBwSmUwOGFw?=
 =?utf-8?B?SmdGd1BMN0x3b3pWckc4elQvQjdHVU1lcU9aQ2dkUERFSlBicEhhSDIrV28w?=
 =?utf-8?B?czdNczJnaWs0RkhrVlVTcHJGNzdJeHlSblBPUE1nN1Bydi9ad3cxbUpTZ08w?=
 =?utf-8?B?QzZuTzFaNDJjNUczV0RPSFE3WEdJWGNmSFJKOWpEOE9nSSswdUxUTW1nYkJv?=
 =?utf-8?B?YzRHVWkrOTk3dGZldWdtVldTZTcxSTlaYmMzMEFsTFJWVm5SbVVtNEgyS08x?=
 =?utf-8?B?N01oQkwzTm1jNHZnYjRPU2l0K2RCTExGZnl0aGhDKzcrb21Wc2Uvc3I4NW12?=
 =?utf-8?B?NTV2ZkRDRnUzZEU3WHp1VkNPbDJpUVBDNW9MTWRua0FreGF3bGEzQVBSZENV?=
 =?utf-8?B?SjdxR0Fycy84YmZKMjNKVmFZdXZzLys4cWtHcFNLWW9VZkdNR0RCdThXaURp?=
 =?utf-8?B?bVlhMEZ0Tm1KVHFHeUR3Qkh4VHk1Y0U3TE9GaVJOV1NmY3FUT2ZIY2hZSWJQ?=
 =?utf-8?B?ZmNIYjEwc3d1OWRkZmlOWjlTRjlBTDJ3QnpYUEFqQjYxcGtBU0VCRzE0RUE3?=
 =?utf-8?B?T2JzakFFUTlENnBNUUZVTFJGU1F1SFJJcXo0eFdzdWNmd3k4L1FraHFMV3R0?=
 =?utf-8?B?cGVqODd0RFNBZHZUYUM4cmFDc3R2M3pyYWs5N25WandqNlV2SXkrYm8yT3RU?=
 =?utf-8?B?WkJwY1VoTUJQaFNweW9iL2oyaytLdFFkN3VYbUlCMUpDai96bmlSdWxGNTlk?=
 =?utf-8?B?b2NlU2VtSWtJSXVGNDAyTFAyaURuZDl4VkI4d2dLZ0lDQVBEc2tlTzF1NGhH?=
 =?utf-8?B?UFpSOVdkWFEwRDduak4zbk1qMVNwYng4Rk43Rkd0S3ROeWFKNk9kcWswUUdt?=
 =?utf-8?B?RHZCeEZZUEFNSUx3WFR1SnN1NUlrSzVmdWcvdDRHU0tsbHZLejBsR1NWeXJR?=
 =?utf-8?B?Sk5scExmRE94Y284K2o1WTNldE9OVTEvSVJYTjIwVzZpVjlONUpVL2V2V1FS?=
 =?utf-8?B?N0cwcXJxaDA2bTlVaXpPYXZYSkt5ZEg1d0hqTGhLL29OQTc3ZE9iRDdtWHlm?=
 =?utf-8?B?L1h2bytrbTlWQ0c0ODUyclhNV0tLNWZKbWpjOGVZR2xHSjV2VWw0TzlRaXRu?=
 =?utf-8?B?MVU4UUgzaklMcXZuQlJjVHY1TmpDV2NmZ3VQMHh4TldSZmJIVnZPMEQ1QW5X?=
 =?utf-8?B?b2FNVm5PcFZpS2Zkb0FCeFBaYTF5TzJ3Zk83ekZBeUJ4VXlzem1UTm91UWF3?=
 =?utf-8?B?SW1uUUIyZWhOcFc5eVZuV3hsNEFXY3BSY2U3b1JMUDF4aGQ3ZEVnbTdaSGcy?=
 =?utf-8?B?d09Bc3FRUDlCODIyQ01GSTJQcGpCZEhSdGUvckRpTGtxUm40MU9pMm1BY3lt?=
 =?utf-8?B?Skh5VHFrOUNKWmtIUjdWUmpaTnpmZk5HZzQ4SVRUYThkdGFYL0VVTGtPM2Ex?=
 =?utf-8?B?YVJteVJCTmY1RmcyZWt6K0p6a2s3MVZuYTBQZkZrNU9wQmZBMU4zY1ZWcCtw?=
 =?utf-8?B?NGJFWkNmUkEzbnBOYS9zQVhISmpRY2VHdlJRbHhaL3MzMmluczhSNGN6WGFo?=
 =?utf-8?B?N0FYMGozWmtxVWpIaUlSckpOZVBYZzJtRm1qQkhEam4zdWsrbklZMEZ3M2Z3?=
 =?utf-8?B?eGkyMlpKY2pjbmxBbVBLN1hDRVI5RFk4elhJWjFGYWdQZGEwSVFNZUlKdmw1?=
 =?utf-8?B?Y0xmdGJ3cWg1NXpaMWsva2pMVHVseHRxc3RMWm52MEJQV1FPKzc2ZEh5a2kz?=
 =?utf-8?B?ZytDb0t4SnpSWUdxb3FBTGYxeWJMNnR1SkpselVhWjduL3NML3pBT1F5REpl?=
 =?utf-8?B?M2RETDE1eEQvSVJrUXRxWWc3TEx1RDRyZDhYVFJtSHQ1aGJicFAvS1NpZTZM?=
 =?utf-8?B?MFFycnQ4QkU2VjYxNHJFYlVFZW10THVsNW5jWTFJdW4wRHdoT3RvMFQvelBr?=
 =?utf-8?B?QUN2Q0VhMFQ5aTVXNTVzYmt6RzdIdzl5UDFsQ21vODhSRFZxendjbW9CQ2lO?=
 =?utf-8?B?RXpXOFE1ZzEraVR4elN6VlFXWFhnRWJ4VGFjTmZUMUJqdmtSU3NhcU02c1hp?=
 =?utf-8?B?RmEvWUticXhwZWRGanlRUE9BUGJhWnV4aDBxWHZvU3pTeVFodEsxL2ZsQXNx?=
 =?utf-8?B?eGFCUVd6MFZudlRjZVlVN0JkYmFIbU5xMkJZQ1pOYkgxMnZkeFZsUGVuYmp4?=
 =?utf-8?B?NFAwbEZsS3dza0VNaFRTYStPakhVR3dkbDZJcW0zTVFnZEtUUDFWUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ef2738-73b7-42d7-6336-08de793acee5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:37:42.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mk8G+Xe8I6Yq2D1vdHYg0fUc0RyK6lBF6aZPGeTSzbO60dnMb28qb1Qp9qPCkIulecGeWH77/L8MekpTRpJjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8E1221F2DE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-263284-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 2/28/2026 9:34 PM, Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 13:38:25 +0530 Riana Tauro wrote:
>>   Documentation/gpu/drm-ras.rst            | 103 +++++++
>>   Documentation/gpu/index.rst              |   1 +
>>   Documentation/netlink/specs/drm_ras.yaml | 115 ++++++++
>>   drivers/gpu/drm/Kconfig                  |  10 +
>>   drivers/gpu/drm/Makefile                 |   1 +
>>   drivers/gpu/drm/drm_drv.c                |   6 +
>>   drivers/gpu/drm/drm_ras.c                | 354 +++++++++++++++++++++++
>>   drivers/gpu/drm/drm_ras_genl_family.c    |  42 +++
>>   drivers/gpu/drm/drm_ras_nl.c             |  56 ++++
>>   drivers/gpu/drm/drm_ras_nl.h             |  24 ++
>>   include/drm/drm_ras.h                    |  75 +++++
>>   include/drm/drm_ras_genl_family.h        |  17 ++
>>   include/uapi/drm/drm_ras.h               |  49 ++++
> 
> Doesn't apply to my local trees any more but _looks_ right :)
> Assuming ./tools/net/ynl/ynl-regen.sh -f doesn't result in a dirty tree:
> > Acked-by: Jakub Kicinski <kuba@kernel.org>

No it does not generate any diff.

Thank you for taking the time to look at this patch and for all the 
helpful suggestions.
Also thanks again for answering all my tool queries.


> 
>> +	if (!info->attrs ||
>> +	    !info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] ||
>> +	    !info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID])
>> +		return -EINVAL;
> 
> Sorry for not noticing earlier but you could use GENL_REQ_ATTR_CHECK()
> here. It will give the user a nice error pointing out which attr was
> missing (assuming user space uses a competent ynl-based library).

Tried this. Does print a very user friendly message.
Will send a new rev with these changes

Thank you
Riana


