Return-Path: <netdev+bounces-270594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH7QL7hywWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:04:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2592F9653
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7503574605
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37D3B7772;
	Mon, 23 Mar 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktEHEauy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB83B47EF
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279222; cv=fail; b=lfoOEoDWdWmJjMt/xMvD7WXgj5/isaZS4AClz1GcHIJwmVL4/NL+MdsM+iWXouw/UgkzkYLkNCFdvdFbFihhaAdtiiR+KeTsWcWKSB4GvN3T145VUA/MiVMo7XgAmBJuFEIF0AvX4JYC5rqqyNQsCj98aM3r3wLFj+HRhiZ15Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279222; c=relaxed/simple;
	bh=/34HscxVY4RkF2gb3RE8gMDrZq4wOJlHSXRn03VWeQA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBbhzaWCFr5Y2KkB3unkbr0muKmOmxzuBW0CViTCG5pkUERhDev+ApLfsF5Ks2ZHpOg8Z/+0lpUvrl/2nQGKUODCYxXI7L+G0DJ0wE2F4MoLGHPNv9RCf4VXUM2FMcOLJoUaHEDRnP8Pmy52BphHk1s5D2h5ZSnvdRAvrmgY3wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktEHEauy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774279222; x=1805815222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/34HscxVY4RkF2gb3RE8gMDrZq4wOJlHSXRn03VWeQA=;
  b=ktEHEauywmsj1oUCCBj7bkikUQjxz85I/nTfB74m7t41XVkTSB++vt2l
   NfvnU7rs10ER6V7+cTfQ2pvHN8MGZ9QoxNgJQ7bmfzpZFm+B0OA+o5FVN
   oLYArxYU2uH32yNYe3gtBxvsdFU1NMqn0M5V82B0dbvZWIuPBTYZC20dc
   i/8eIOs0v2P3mQuTO8LsU0IyLNSFnKw0Y2GdjNsQvzfXybrVY+DC0CCnV
   elFQ/qU3HyTLfaONCgnOsinuTucmVkpLcDoDgqXp+Lza+0BiAR2E/qpsO
   zeMiY6G492dg8rl8EsQtIu8SuJa585A/F6utF1AdiBMm7apvPXDM0lczJ
   A==;
X-CSE-ConnectionGUID: NJz41ei3SPCGzpii26HgWA==
X-CSE-MsgGUID: nd2n3YlzRaq8rVLgJdWPTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86752888"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="86752888"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:20:21 -0700
X-CSE-ConnectionGUID: kAbR3DmCRIWQ/rUhZc4+sw==
X-CSE-MsgGUID: u7CFRHG/Ttyir+uNe1IgMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="220775356"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:20:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 08:20:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 08:20:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 08:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL0+E2Lr8dJHbg8qMz9a323/MVocX/c4S+90Mny99IWKJxDhj+vVIEBert5qNnRz87GgNU3i9ExtFkQ8YGTeSt+/zQyWBm1C8p7qSJH1GQReAGQ4CTQZ4P6WWh44IKbXEWFg3A6fE1mZCrz1TeLOCpYNVc0ONwRmTbx0hFUWJvTuzCBH2ZjAoaYlvHuJZfZ2UXuGlGO01JI57hEgHTn3csIGAR2r8890T528dv3bLa/xXkkzpGfBONvQDfvhO8vdauUeBriYoorZlsAdaR+YM5aTQ/Lz1r7DzIVsIcMCeIPRHEpkH3JU6/8mnANsb/DQrnCT+zWLrtYgeP4Ig02RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8apAbVcUULbS3iQQzEyUyK8KUwjpLG55l7ceQj5BihM=;
 b=Bs9B0vpMnoISrOMhpRBYZz3IWvgxbneUh1gQqZvy8b+BIqFWA8TQhV9I/GZ0+nNtYfCjxQBrcGviFTm7ani19qTZKV9pqNrtcguw+BMI2Wx4Cyexn2TASH8Sl6e7fd+JDtHAAizpGapO3aB3YlVmqwdgINprWNVh32mDTA0wWvXyZpr1Xpk0kxnDER0/4VxgWRsaJAEk/8ZaH7x0CA//1fOqFdKR302MCYc9Tcu2XMKosVhAcmY3ydrUgR61drfiixSi8r73mOIHcD1jIW6Mwu3NxaJh3M6A1eHX2xy0YdS3+NDZIqacbphjBhSTEmzEUWo6k8QaxUfXO/tDO5630w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6274.namprd11.prod.outlook.com (2603:10b6:a03:457::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 15:20:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 15:20:13 +0000
Message-ID: <4025f11d-a34e-4fed-b1a7-61c44ca67204@intel.com>
Date: Mon, 23 Mar 2026 16:25:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
References: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
 <IA3PR11MB898619DAC6BA30C2DBC65F62E54BA@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB898619DAC6BA30C2DBC65F62E54BA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:50::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ff6a59-4db1-49d7-a362-08de88efade6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: teR0lJwKBEnFKBIjQS5S46++Jy/q0jQN4VeLfeqmuTTt+G2xUy3tF8vuwEqK8yP/tCfV9Sdk1lBp3ELeN6KUyx5wc1cpjdleQUf7r1kaqDHxatcu1i3Xybnz9nxZ8SEemOKY9rctRnuyw3at7FbHeRHV6chIvCNbr+58AuB1zZerVyrm4gxgrwiKv6vH12OPyyodMmYVALD0aZiW6GCsXI9TshwTkVeFbi9ukMYKjGBeJBOdUzJTxa+fCLoUHLBKZT7WCeAnKoS97IgfZ1gr/OBcdtm37X9OzrA+HlWNxjt7wqpRhNnYFhJSzbs48wA4suljIVqhJrFY44wI4UrpxtDwL9/TyIlgAtiK+O2OgA7yR4AdPyFGr4tVvxqRanRkw1oS5F2vSDq8NzK7zmsK98uo99AsWGInLWSWWmGuufBB8BJcV89AR61zHB/3wkxoWPUiYkephSdQ2ETd2viLonlHUQqn/5EEclWThhBzP7tX+PvkqYMT7BcHOGLzoXo95pPWj2DOQXyNzuKM1u1nNWcc7Xhokn9XAFv8pIcgd/WFzgHYUZXqm/xEmVRZZ7XH5MXNPNymEhABm4JNfPob5749OueBUrgt0dNc3ThFlFtFlLJaWg9y5z4AeW4AwLYwH1iXu18yQxCCS9SRVgkm+kmJeATL8M0Ztd6l1fDZaM7+6f2x68IU2Q4CIZ3S63J9wR7C2yKw6Uj+tBRUyEKWBcy1cA0eHcxQDIOybXeovLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0s0NGsyZDVHRnJLT3dnOHpGRlBSVTAxakFXQXkzUmw2THN0Q05oTWhoVGNk?=
 =?utf-8?B?U3lSa1RHMlh3QjJ3Y2d5QU9UdnkzTG1zSWhuZS8yaWhKWGlwa1J6UVQzQnRz?=
 =?utf-8?B?WDVEQkVCWHBTVFdUN1JGVW9ramtzT3ZYaHcxdy9IUFNlZEVidVVUQXJQRlFZ?=
 =?utf-8?B?L3B3WVlOaDV5eHVUZXpWRlU5N1orTUVORGZEeCtNTjFWdStBcFFBK2VJNElt?=
 =?utf-8?B?RHJnR2JqYURNQXc0SnBiVlVZREh0bTQ4Sld2ME5nUHdWU1kwSHNlVHJSaHMy?=
 =?utf-8?B?Ykc3SUJxOTd1N2tsZmV5M0xQV0l0WEJEanVUMXQvQnZzNzZGWVVYdWx3MHhQ?=
 =?utf-8?B?Nk9lVVNLd1RBZ3V2UTQ2SFExTXp0YU5ESXROcDdNY2RGVXR3NDNMMDZsd09O?=
 =?utf-8?B?bHVUNStoSXVwVEpMbWZ4QmU1Y2ZBc0k5UlM2eEdBbWl6azVFQ0ZOYnZKaW9t?=
 =?utf-8?B?Y0tMdHdKVHVXUkZWWHVkT3FaYzdMWCtuelBFcnJLdHQ4T3BLcWM4ZnNqQlBN?=
 =?utf-8?B?ZDQ3ZTVFZGpQNG9qZVZ4cDNuWlI5dTMxT3BINjRGc0VPeUM0cEY0bzN1Mjg3?=
 =?utf-8?B?QUFGcHRuclpFejcwcHR1ZEhCTVZuMTR4UDAwN3IvWnRRTysyK1dVM3FYb1dI?=
 =?utf-8?B?eWlTZUN5dDlvSWpqWXc0V2RGSmlCQjl5YXZBeTFXSjNkN2JBRDY0WjQrUlBW?=
 =?utf-8?B?S2kxWG4wa0JBcUZEVDhEbVlEa1dhNnJ5L2s2NXZaaEx0NlAyVjZZKzhtamRz?=
 =?utf-8?B?bzdPVDNmMFF1RHV5bWlrV2lIMG1rQzJaMXJSc2pQYXB3am1TdmtXQXd1RUQr?=
 =?utf-8?B?d2kvYnV1WkMxKzlPN1JLV29mM0M5dU1xZ2hNcnpuZTRDUFNLT1VNZkpSOS9i?=
 =?utf-8?B?aVRoWDFVVXYwMXhhY3d6OHIxMk5rOEt5YTZ0cHBzNGd2RWlZdEZHMWo0MzF0?=
 =?utf-8?B?Y1ZnTWovMnRDV2E5V3ZtMHlpeWZ5OExUaFNmektReXhGTklRV2JsaEFGVjB2?=
 =?utf-8?B?VFZmQTJ5WlVybTNTTjZWUENJUGdoZFdMZ3NGbHdZRUI2NEpQOFE5WlFVZE9r?=
 =?utf-8?B?T0JQbmtVUDdpK2p6VktobFBvbmd6eTVJN1NXM1FWajFLQW40elNUUmp1L0I2?=
 =?utf-8?B?eUtHSDF4NHUvSVZQeHJmbEpLVGVCZWdaaWpmVXF4YUU0WTI2VU8vcjNGQU5w?=
 =?utf-8?B?TFkzSjR1OUE0RkFpUEs3SXcwZVVBbmhFMUhtRHhKeEJySlczWFNOb0dua0lI?=
 =?utf-8?B?SGxOVklFZC90VENTS2hkcnVRN090UUU0bW1aM3NhOG5pLzl0K3JmTktWMXlR?=
 =?utf-8?B?SXA0WnBxM0FzUnllWVd2VGFRZmtEWmRrclBwV2dCTTJqK1hDc3N3U0V5Q0xG?=
 =?utf-8?B?Z2JzeXFTaWpIblgwT1Fzdlptb2M3UWJydGxnZjZXS1p2QnpCZllVOHVvSGh1?=
 =?utf-8?B?bGJXZkJxTmI0eVdpeUt2OU5uWFRGZjhjT0JEcW0zeE5td21BbmtUMTR1OVpa?=
 =?utf-8?B?eU5pMHQrL0gxVUlDNDFBZVFBMW9KVzRqeitBNVBzSmJySUpDdVB0NWtlQ1JY?=
 =?utf-8?B?L2YybjNRYXpHdzRZTE02djh0RjBtQ2RJVjd0a0Rha3U3NkJ3bURoMi85SjZr?=
 =?utf-8?B?c3hYTUo2YmwwVkZicnc1RkRtcVBCeWUzYUxqWGZEanZJaVFRUmZ6ODhScTYz?=
 =?utf-8?B?N2lWU1Jhd291NU95dGN2c2N1SHp4RENzOVdXSk02ME9kQjJQZ1NTcldGUjlv?=
 =?utf-8?B?L0xpZlJPeHk4aTFGUHBhZTJCdDZqVHJGcmpwSDFKcEx1TGh6VXh5bU1ub0hU?=
 =?utf-8?B?NnU3VGRrUXJqbjB2Y0hSak9RNXl4SElUMC9LU1R3R2ZBS3dIeTVqSVpxaUZj?=
 =?utf-8?B?R0QxblNNM2VNNmwwOTcwR3pSOGIzdzQ0emF0aXNwd1hLY3QvQkRES2xoeEhQ?=
 =?utf-8?B?blk3YnZPNDZzUFJGTDdUQzI5OXdLZThxTkNqOVhTMzBFbzA2T0k0NGhPY0d6?=
 =?utf-8?B?eW8wcUFqcWRmcExrdWZxcyt6cXYzeGJsWjY2eWNQRGxtbXhOZEkyb2hLWEFZ?=
 =?utf-8?B?L1N2dzVJN2NSZXVmcjJWcUtCVEtua0U1eVEvWGEvTXhXMWhUT0daMUFFUTlk?=
 =?utf-8?B?MVUvVlFtUkZuOXZwblBwY3F3M2MrMVhNdUhUQklyMk5XZjNUYXN6aEZKV0pq?=
 =?utf-8?B?Q1F2eE43c1VUUDBLL3NrL2djWFFxYXN4ejlXZmFvdVBqUlZKMjVOT0hVaUMw?=
 =?utf-8?B?TmhNenlHMVVhSytBOHZJaXN2cmVHNVhPN0dOZVhmM1ZkYjhZTW1xaW5DRkRZ?=
 =?utf-8?B?UFFpci85R08wK2NxYTlwaFFhL24yMzZtQWxJaXozU09DUU1DbERDQ3h2algw?=
 =?utf-8?Q?31SD1TMDjB/7swkg=3D?=
X-Exchange-RoutingPolicyChecked: CEe3iX5uAsRIHgCQHWifejiUtot21oG0U9byQaqMPCMmbqgmEawingpTTjjnNOBece/1uYSvvmcnctCRbYhCAH2ig0FNNE0NhWZeraQ8W/El+gQ8OutdTId9eDlJsSrYMKo6y33x86y4z4l7lpuFoLVsQnTYPdB6lIFGvZ+/Jspmp4BCqjHKKJq59qpmp5vAmGq1w+KIBCuo1jD+Aj8i60rrUvfAB5GsC+MGgDSXbfgENQzyLrzCgnWmcldLybZmhwuRADuzUjRil+VnpWVrOeDTiFuS3smAoIiKhHk8TdpnBjCmUMZXeWZOUgCYQm6DRQn9Fi8ww5YhXR3PFnatmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ff6a59-4db1-49d7-a362-08de88efade6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:20:13.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYm074o6jv7d4h2qm4hYJ7oqq1F66JRo+J5/NX8f02VPflhkB+ArbHzmBS898Hmz6GbVfk2xHAEDbudxb49F/2H4zH2oNqsgFJeJHIIzqso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6274
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270594-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1F2592F9653
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>>   void *devlink_priv(struct devlink *devlink)  {
>> +	if (devlink->is_shd)
>> +		return devlink_shd_get_priv(devlink);
> I'm afraid it can cause recursion, if you didn't modify the function:

right, thanks
I should have really send this as an RFC :/

> void *devlink_shd_get_priv(struct devlink *devlink)
> {
>      struct devlink_shd *shd = devlink_priv(devlink);
> 
>> +
>>   	return &devlink->priv;
>>   }
> 
> ...
> 
>>   	if (refcount_dec_and_test(&shd->refcount))
>>   		devlink_shd_destroy(shd);
>>   	mutex_unlock(&shd_mutex);
>> @@ -159,4 +165,3 @@ void *devlink_shd_get_priv(struct devlink
>> *devlink)
>>
>>   	return shd->priv;
>>   }
>> -EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
>> --
>> 2.39.3
> 


