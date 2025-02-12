Return-Path: <netdev+bounces-165445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FBA320FA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4915F3A2531
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CB205516;
	Wed, 12 Feb 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jA2ibiFb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9D205510
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348660; cv=fail; b=baUY4S1H83BKAQc7CIS2l2mku6h3JEHkErgGDAgnXPq1p3Nwuu1QHkXlZNXL3oILvP0CkY1lEOLisriqPOpnPcNbC4lo6vJQoOmiIapWgkSg7knhiADYXcMMztFtYRAAPrUUNDVj94IllnraajioF10xO0bAI1lKd1Ew2Pm7uL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348660; c=relaxed/simple;
	bh=7P9k2J6m3Dy9zKJ4Z+aBjbPqvkmr+aUn2c4dYfxbhI4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTEL+S3YV+UD//Y20n00ODzn5n8R0xzpoFAhqttZOcC8gdGik5fglU8A4zE2k7lIHAs6VprqNe9BqTxB7MjLce7cNRrFtwPVRAqYNurZVaNqkJq6UPapew6I1yeK+4Ul7E1s2ENssaK11OfvNIQVO91WYwnwgw8y4iWKhOdHB4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jA2ibiFb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739348659; x=1770884659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7P9k2J6m3Dy9zKJ4Z+aBjbPqvkmr+aUn2c4dYfxbhI4=;
  b=jA2ibiFbvjCw/aeDwCSnVqqOwYuvD3AbCEL0UkTWuug4+bqTe4m284pd
   uFiTybcQmacbktlDUI56H/Kt0Olmlu/QioK8aozN0zBBQ5XuMelCppa9l
   KmdsGsTMrZSHvWkLM/66oG5/UnRsqODO8LYpYsnw2Ff3yjFDn6umiZQsm
   qOAspS7nLdQlCxqw5PcjF0b/HWGR3R1F12zCpulSgIkjmNsLNwKw9F7Wk
   12FEK7eTrpdzlXTOgPanjCC8M/qybFyNolTCYfZObFlnao/e7MFk94Elv
   7wtFaoT7HbjnSmOjTG6UQDWVmu+5ajjSvu1rEz+hP9qKhpZB+LkZvk+DP
   g==;
X-CSE-ConnectionGUID: LHsj4dXWRg+RoclZjaBOqw==
X-CSE-MsgGUID: V0ZWKL08SIKwmORMJycqBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51387045"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="51387045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:24:10 -0800
X-CSE-ConnectionGUID: trm87VLMR/++A17ajGwBvA==
X-CSE-MsgGUID: tdlliBx8Q3eOi1XiiK0Uig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149946488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:24:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:24:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 00:24:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:24:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY7nMKx5wkVpiAtkx8d1PGRPz3ToItf/WSNNiLPb8nNaQjM7OJ3kVClRPr6R9fYZglKWsUrD6pgDDwbjtlyIm/b4JdI1me1jkQOPEw2zAhCqErG8VZLfu7DiO9irzU26HFbNS5Myd9IPbwFpOHdaOWyuAxajJHleapat1PeEfiPDsLqnszCVHFVPVLpwrNJOKgN4jjyO3bOdp8C+qU9s6O73Rg1oA/fSC6YpsgYDET6LjYHTe5GU3Z9C1n2SjG1riY6AgWafiXvC0Q2VEUIGA0BQw4j9c/oVVVKTCoz3Vzkq1b5CvlTHVdh3uLWuS6pN6VDN0pufZkMfOSKc59Gj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MvxZWxyE/3cXS2Vlm3on4aK7sCAfvkUj2yxAwovuzQ=;
 b=WlZ6AR6ibOlL3UkqXApgqztMvJl049Zz5NgHLNPTR3tAOUGQ1dlVU7lrEQjBStsLldfyYnv4fGipFJE2SZjwPas/ohqcKh2NKHmtM4dCQEKwwv43wdzsApz/q1nX0rHnXG5TZ20GJa8U+N3xPJyBO8pxllKJTw8rzOCp2vjMEzI4XP+Ca344kTIl1DV1FwcTnipOZkuDn1qBhbDSAGv3jq8iFBHtqNQfv+aKqkn4eLT5RBHqxTshXb9D3mDaDC2O2y2bDePN/mp7x5g35naHid2GZPHGNZ5o+Fty0hw5eunqKHcVBX54jQeIFGu9bBIJl2uz9HY0lt36GlWqq+zaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB6564.namprd11.prod.outlook.com (2603:10b6:510:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 08:23:52 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:23:52 +0000
Message-ID: <8b3472b1-0697-40ba-b2f9-a1ad100f9177@intel.com>
Date: Wed, 12 Feb 2025 09:23:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: airoha: Enable TSO/Scatter Gather for
 LAN port
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20250212-airoha-fix-tso-v1-0-1652558a79b4@kernel.org>
 <20250212-airoha-fix-tso-v1-2-1652558a79b4@kernel.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212-airoha-fix-tso-v1-2-1652558a79b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0201.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::22) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: cc27b914-d292-4f67-6c8d-08dd4b3e9580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlg3MU0xZ2Z1bVRJdFRVVTdOQXpYMFlxTGJ1Rzd6ZkpodSs0bDVCMTlaa2FG?=
 =?utf-8?B?MjYyU2VhNVc1ZTdDNjc2WXBFdEFES29LVkZDbUtFcHdKbUNKNzcrL0ZHMHk3?=
 =?utf-8?B?TUh3aFUwWXl3QkhjaHJLWnhzaTl0WU5YZjFyQUxFemNET05MT3dtc011MmQv?=
 =?utf-8?B?bjVqVFJId0gxN1pGOE45dElwRlpiZE5Yb1ZudDhvUk0rR2JoM3hrMzZHaVJq?=
 =?utf-8?B?aGNyZU12QlQ2dXZUU3JNcXI2SHlCQ2MrR0dTVUN4UmVQQnY5dVZFSmcxWHlI?=
 =?utf-8?B?OXdZTlFpd01JMlhXb2lTdHVaOWVQcFJYSWhEUkk1dncyRXM3ZEJiZnRGcVNZ?=
 =?utf-8?B?YmVTaVlYK1N5OERRbCtEckJwYUlyTTg0a2FaNXg1a0dDV1VuT21sNW1aYXhE?=
 =?utf-8?B?T211NkRHNjJpNXVVWWJRRTRabzRoZlJhRTZZRXk5YXgrRVd3VUcvdGp1c2Jk?=
 =?utf-8?B?dTVUZnBOUmRxd2VJVkNWSGtxOWtSd2ZNSkFGbWZSRVJTK2JySmlaUENFZnJK?=
 =?utf-8?B?RTRoTytaU3ZQT3dNTDhyL09wQlN0OWh4UnY0aWtrNU5LaU03SWtnWlB3aGo4?=
 =?utf-8?B?UWZnWERXa3dGNE52UkRxTmlpVkhrOWRpOXZncndWRXdXSnovWVgrVVhtekZa?=
 =?utf-8?B?L2F4VGtpdWs0Vnh5cW9zYVRBK1lGWlVKazg5REYvMlVvSXhPbklDYjl6SmRO?=
 =?utf-8?B?NGVwL3JWZk9sWHR2amVuRVo3d3B5WU5qWUZLQUtQSEVGcFJaSFFTUDhHL3NV?=
 =?utf-8?B?ZEgrRGE5MFJoVnJRaGhNMVpWQXlyUitsWkZVeDFCT2NSaFh0Ri83dEt2S09Z?=
 =?utf-8?B?VDVrYXp1ZDlpTVdhdndQY1ltUy9JcHF6Z1NVbHRNU3dRUWZJRXRSSjRueWhx?=
 =?utf-8?B?cG5yOXE2WXVUcmRoYUtrVnc5cFk2WWpZanEzaG9NNTlNV0luQnJVeGdxeWho?=
 =?utf-8?B?eCsySTliMXBVaFZvYVlnTTJFZ29XdlhyMUU5cGsxZUZQNFdBbXdtMlFIWmRr?=
 =?utf-8?B?MWR1RVRGL3dnd1dFaVdKZE9IMTJQV1JDQTBnNzJzVU1aSnZVbW0rODRDblkx?=
 =?utf-8?B?dnZheUZjaTFZUGtTQ0l2NU5zcWVzSVVUZDRrSmpsM0IxNVFtNVBjcTlZWnFt?=
 =?utf-8?B?ZlkzUW5ROUZKNFd4QWhnRnhKVjVCMXF1d1prSHA2ais0bGNVcndRbWcvUXpX?=
 =?utf-8?B?OVUwbUJQazBPWVh1eDRqeFJZZlFqb0xoTmhWa3BlWFZWY2NNRWliUFo2b3Jl?=
 =?utf-8?B?enFBb0hhKzRMNCtrYy9oeExkL1VMckhzejF5R1plVkdTSklWSFQ5ajdwbTg3?=
 =?utf-8?B?NEJmc2ZDemhXRHZJejVYaEdTM0tjeVAvN0c2WCtMTDFtMlBobTB6RFYrUDUz?=
 =?utf-8?B?OUR1N1pEd25Od29wRS9nNXlIMEZ0TEVPOVBDaDREODA4TS9UbzI3NmNYWmtS?=
 =?utf-8?B?MDJKbXdDYzZ4YUFNSXRBNXQ4VjFNRXBILzVZendxdE1UUW9mV2tSLzB4SWV3?=
 =?utf-8?B?Z0JlR3JFSWx1SmFIN2FuZ0RrSnZIZlZjWTNLWWFORCt0TDRBY3dDcDJhckJw?=
 =?utf-8?B?U0JxakRDcDg4UldHTFlmL3ROQTUzeDZzRHJUS21SREpZRVBjOVhWOFZVZVMx?=
 =?utf-8?B?VlMwOGxEblR3d0xuSXNqenppQlhBRjNHT0hCWUFSUTNuTkxtZlhleGZLY0Z3?=
 =?utf-8?B?eWJCT3d4bTB0SDRTTnpYZ1BmbHkxZXd0Ly9QSVJNNkdDcDRPeWJFL2JFUkZp?=
 =?utf-8?B?bWpKWkQvQk5CRDFWRHhvL2tRTys4V1RpZDc3M2czZkJNZzlWWkJhbElTS2F1?=
 =?utf-8?B?SFZ3TU03SHRsOWkrYUdGSWNkNWQyUUl3b1hPa2FVb3VaZHRTUStCZ1dHRGl3?=
 =?utf-8?B?TVErM2MzM2RpQWFNQ2VlNWlWakcvbmt2NHZ4REgxN3lCK0V5UThuTkhFMVZa?=
 =?utf-8?Q?rK/kdSRAAUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjI0TE9NMzZJanVEOE4vQ2ZEN3FidUlEOWtTV1lib3pBbWZaSkNuK3ZBNGNV?=
 =?utf-8?B?VFRIbjFEREF6L1AyaHdkQzVaakxGRmVjTGUzQlNaUFZwbkZMZk9IQThGemtD?=
 =?utf-8?B?Q2RDOTBUelhGRUdsSG9paFhDRVNZNzZkaWtLb1REK2YyQ2dvV2lxcG9uVVRs?=
 =?utf-8?B?NXZNRlNWVGU5RWtMQWM2SHJnYzVadXY3V3lHellWeWJqaXVQOXV2V09Ldkpt?=
 =?utf-8?B?VkFLdUVzMWthK2N3bnArdExvY3VsemRKdjJvbzdESDBuaU8vSGJGK2JWR2RR?=
 =?utf-8?B?c2EvbUdBcEJRM3ZnQkRiZDYrNWg5NnZPdXBKRnphOFUvbktySVUyRkwxZ1Qy?=
 =?utf-8?B?OWszSDRiVGoxNWV5QVEwRGcyWXBRUU1uZElIOW1TUW5lVlZmMC9vbzUwMnlS?=
 =?utf-8?B?RkpPZ2Q3NWxKM0VtL0dsUUk4MStnOE9pTVRXNjBKUGhyRkw4SG1ja254T1JB?=
 =?utf-8?B?SlJNN2tiSnJESzU4bWFiallOaXViRjgwb3lFM3BUY0ZMTVlzdmgweXBuQjR1?=
 =?utf-8?B?b0EyeXJ5a3RudmM0c29ORDNRYTdaZFVhNlhBVzdwSk1YR0M4WmNOQVhZTldH?=
 =?utf-8?B?LzJpRDh1bWVsV2hONi9yR2hXVlp4OTdzL3NCUHpHUnlLZ00vUTlpSkIzSFdo?=
 =?utf-8?B?Q0VJdTdpU3dkZCtaL0FhV2ljRkVLNHVqRFJxRS9QeTIwdkhPWnVXU0s5SG5v?=
 =?utf-8?B?OWtOSHljL2RmZEhVLzhEK01FZnUydnkxTWdaT2ZURGxWRFdFb1NybTBTZVJt?=
 =?utf-8?B?cExOVzVua3VOWURhVUJvTUxneVIvYnRDRzlVUTVIbUxuT3dNaEtsV3g5UmpN?=
 =?utf-8?B?b0RWMHBIbEs5aWRDOHpIUFZoTFlCVEtNNFY2dzRaS2FIMmFMdFpmUkZSN3NB?=
 =?utf-8?B?cFU0bE0zRFVGUUtlNUp2Y21MTGpVWnRMVXF5ZU9sQ2NjeG5uZDduREU2MmNI?=
 =?utf-8?B?eHl0RGRBL043NGVVb2dPSFpleElmcHZzUmxvMytuMmhnKzJKVFFkd0Z6c1hJ?=
 =?utf-8?B?VEl3aXJVWFl0RklsM2tOYmpFdjNKS014WFlybHlRcVYzakQrWWtHZ0tuUGdG?=
 =?utf-8?B?NGpyZUkzZWxkbWdZWkN0VktwVmt6VVQrQi8waSswaXhUWEw4dStkTlJjMSs2?=
 =?utf-8?B?Vkd1aHB6bFhhN3QwS25KdVJMUmhSbmVCUGt0N1lyejhsd3paL0FDYmNUOWNJ?=
 =?utf-8?B?VWhhUS83dkd5Ky9hMHVINThZbzd2YlpWdEIvRjBZM1lWZHlHTVBEV2dHa0JG?=
 =?utf-8?B?aW93OXA5VmVJbWVzeTgwdzZscC9rNVlBYlh6Y3pQWEszV1ljckJCdnlVL2dr?=
 =?utf-8?B?SnlQek9KTmQ0ckduNXZGUk5FeVJNbyt2d2NWT0R4QVl2WUs2VTc0OFZINHps?=
 =?utf-8?B?S1dDb2NTRWdMdWx2UjFUV2pLdCsveVNsY3BEQUdibnVQeEF0S0RKNjl2bTJN?=
 =?utf-8?B?QVF0NEE0QWpUbDFxR2drNnV2WGtYd0YyQXBWd2tOaFdTY25BdzJQcHNaZElm?=
 =?utf-8?B?ZUFzbi9zM3pqdDdLNXR5WHdrbEVPQ2c2dERVb3VCWDA1QjBjQjVXK3Bob1JR?=
 =?utf-8?B?dG1GcGxmVTdudVgrQUYwZExYS05MUUVnaHNVVGpIS29Sb2JkNUMvR0k3Vjd2?=
 =?utf-8?B?MjEzdnZkLzFTbTZaN25kc0RZRVlzdnBOcFdHRXl2emJXS0hLSHRsc25aaGE4?=
 =?utf-8?B?dnYybkErcldwOTQ5NHByRzBFVFZBZEROUWdJc09pZW9UR3JlN0FuWjc0eDIw?=
 =?utf-8?B?d0tFb1hnRHIzYzlweDgxMkJmMytMWmhVRTdDdm80d29kMkxQR05zblpBbWky?=
 =?utf-8?B?UzVlZUtjcnYwM240amxEeXRmU2JwalRhYmJsRjl1LytSVitsZmN3V0E0OWpk?=
 =?utf-8?B?UWppSFdvN1hCN2txNG1OV1BVMHpMU2VMUTYxc3NRNitxTDFZbWxFQW8wL0ta?=
 =?utf-8?B?cTkwTUZRbGNrbGtCTnRuaTNiWVF4NU5kclM0UFZOeUYrcmtnVWY2MG9xdnc5?=
 =?utf-8?B?L2ovM1dlSklEM3Q5bU9Sbnp2MG9ndzQvZmdUYzVpR2ZlWTJjamZiQktMaUNF?=
 =?utf-8?B?am00cURFZnpQOUdHcy9EUllrdlEzTDhLUWR5YWlPT1RXeFJDN0FGUlZxbjJj?=
 =?utf-8?B?QktudGZBaWxVcm8rS2RqWGNFcWQ4Z0tjMit1WjRxcXc0a0MzTmlvTkR3ek12?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc27b914-d292-4f67-6c8d-08dd4b3e9580
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:23:52.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++awhiiNTvsw4DSb8qCCiI/KELdaoZ4mfAf+eFLJSyWDCpXodMlMQePvjGrLalAzfcQebTcgZ1v5/bDrTtKoa5uH2ZAw05jgKqSDodxlDpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com



On 2/12/2025 7:51 AM, Lorenzo Bianconi wrote:
> Set net_device vlan_features in order to enable TSO and Scatter Gather
> for DSA user ports.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/ethernet/mediatek/airoha_eth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index aa5f220ddbcf9ca5bee1173114294cb3aec701c9..321e5d15198c5ec6a0764be418aa447e8d9e4512 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -3188,6 +3188,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
>   			   NETIF_F_SG | NETIF_F_TSO |
>   			   NETIF_F_HW_TC;
>   	dev->features |= dev->hw_features;
> +	dev->vlan_features = dev->hw_features;
>   	dev->dev.of_node = np;
>   	dev->irq = qdma->irq;
>   	SET_NETDEV_DEV(dev, eth->dev);
> 

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


