Return-Path: <netdev+bounces-114443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B539429D1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D65281A89
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AE1A8C00;
	Wed, 31 Jul 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBN/RwO4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D131A7F87
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416398; cv=fail; b=IXOQwRLSVTZDner75kpzFb7ah0Y6NfaD/hHfjUxiywSUc6wRo4x7lybaGrNxP9PoXFx/fKTCTbdmAixPsmCaDYaAjmGwagpyVQZmWU8V283vJOe0hSJOTwSCa51U0VZZ0sGcVXPSpForOiASpHwAnzfR82KJdktkZhmPpQaHLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416398; c=relaxed/simple;
	bh=Snq4Vh7q8A5RtxcikRB5emyAywemZzEVcxn5y3JgX5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvDyHZfMtJfITu3Jnv6roLKMXgIXnBniTPniyT7w2RmV/XX2V1yhJoWhJwm6f9wsXbkKg+DvbvxkVZ1hV+hw5qMq5rS0KZ/byMnoEFtcGZYKCzohMlo6CLJOqhlokz2B1Et1YdhuwMiK3vzISEcorCbZuwG/XOkjJGYX/n1Mx5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBN/RwO4; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722416397; x=1753952397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Snq4Vh7q8A5RtxcikRB5emyAywemZzEVcxn5y3JgX5k=;
  b=HBN/RwO41Tkpt46aHRLEgb8YOfd21ai0/DHNErKXZ1eLJFgNErtrjEoN
   1d0ZEZ+XBndIEIqWXrUxG8KkKUCsnxE2rN5fTDPMAvu5Qx7FlQ9h5i/fL
   DKzNzL20jDFPBT3Cu+mOCVgWr1lqg2SQBslK2XO5Thp3os0O4wq4OPsu4
   gjTkrcgraW8bcqmYDSGWZSzpWrd78Ql1Wwz4TjAuoW+E/5o+VkiUwUZ07
   9M1Pf70F7SwQoXYbvg4qUfcmV/HXbx2AZkZm0RhthbZ0nbQ1x66Vc+LER
   X5/hzBD5mNuvjYzu46r/BTAE/Gnx6V2eL8aO4D9Yd0PZDAFPIZEoT2Vr7
   Q==;
X-CSE-ConnectionGUID: U+H4Vr7/SbOkRAKOoZyBzg==
X-CSE-MsgGUID: qjTo9uzERYiiPugoEWIu0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20226536"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20226536"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 01:59:37 -0700
X-CSE-ConnectionGUID: l/Ujfsv8RPmKUd4LvHsmpw==
X-CSE-MsgGUID: 0BwnJPadRCe5iC9kmobc2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54670041"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 01:59:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 01:59:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 01:59:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 01:59:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 01:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6cWgnKOXGdRlM3tw/0ooxOXeXbSYjY0LoujCB8N03GNX8vbW5fwsMpKvspXp9QDv+2LpTk2GghTgcTxirKSfCNKlCdb5zhjNh+D119f8xxXi/d87npEStFL03o/WB7EPD35D3MbrMF3lCXzn6AVElQ+WxuExPr6ZGkWmYIuW15W+o964Csh9+qnZAM1kdcXCfj3TgChSWak9lFlluDEYFalOWcsFhIQzyuWDKoP6EW38HgesjIN5CP5Z7USa2CECPpgnWTzaerv2VW8bQyGlzBKg2T19rEkLwnFiLUC6oiGsmsy7S3V9k8ecG2WoA0xSvwH8jKKtmTvo81RzeEoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCo7kNI7qEoGoMHle+u0PV8SkO+KDYwFJhocOL0NJHw=;
 b=OR+jO23pnDkwnLQeMqMU9VE4bl2caKZEghPXYJu8++Ri6gSz+Y/hN6wCsaX54vqAoa7iNEhBPeG+xPTf/wHriP58X053/qTo37Vcm0FwJGhG5IX/yL+NRGOKwJFOdOPfJsrZn0E3AluEmHNTmegtlbpr5x/+md0wu4wFVIl2TzxDI/IgWvuBXPgKQXX/EvkXGpk6dvbG3Muor2/5Rlzp2ZS5gj7N4r2ek1PCUmuJNvDGdg2dB/COLkWllYl1NoeMpdk7rn8MQrww/EVy33ml+qFZbEcWByWdeQJPfl9z/NTIEAw+LfZE12y80x3kQzjV/LsVGhN24woAj8VjmsRb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 08:59:32 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:59:32 +0000
Message-ID: <68e37f9d-0f75-4c59-83db-dfa51af7443c@intel.com>
Date: Wed, 31 Jul 2024 10:59:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: don't increment tx_dropped in case of
 NETDEV_TX_BUSY
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, David Miller <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <bbba9c48-8bac-4932-9aa1-d2ed63bc9433@gmail.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <bbba9c48-8bac-4932-9aa1-d2ed63bc9433@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 265b92a5-9ca2-4142-bde3-08dcb13f17bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzNYRC93UlZaZE9WU2NKUDJjVEJSZ2hmMzdFejJVdXRpOHg0NWNYMGE5RkNk?=
 =?utf-8?B?WHlUUXozK2ZiRFF2Y0V2aEhwMU9LaW56Y1BISk0vcnZsMW10YWE2cGZmSExP?=
 =?utf-8?B?TFlIZW5tRnlrc2d3T3VZaEFnS3I0d3ZzRHBZdlRSZkg4SmE0MGQzYWFlVEcv?=
 =?utf-8?B?KzJlK3orVVNLQmtLb3k3MXpHTzVDVW14QkhhWldDMVU5Q0U3R3ZYdndzYUlQ?=
 =?utf-8?B?d3FUeE81aFNIellzV05IL2IvZS9hblFhNlpQdDEzL0ZZc3B6SnRvZmsxenow?=
 =?utf-8?B?aXBOelpIWFUzbGp2UHpUV2cxeUo5ZEdQOU1NeUQ1MTJOR04wSE1yME9MR2l3?=
 =?utf-8?B?NlBRL1htMVkwM3hJZ1JBTk1TRys0endxelFKWWJBczhtYWFyVWtQVWdrUGRv?=
 =?utf-8?B?cGllVXhDbWVqbzZnNDR5ckh4RnRCSnlUUEJPK3d0OHdIWEJSMHY3bW5NbnNn?=
 =?utf-8?B?RzZBd25hdkdzTlZQVkVlb0doUjh2S2JTRVhwdm91dkVQQ1h6eUZLVUIrcFdt?=
 =?utf-8?B?K0FtQm8rdW1RNnEzK0xiV09IZ2UzbGQ1SWN4N1RVT2wrY2JyZjFGS29uUWZC?=
 =?utf-8?B?VGI0ejJ2MU1rR2VWbUExQ2VJMWhMdEc0MDYyTzEwNWNGSlZvQ1prbjBsbXBS?=
 =?utf-8?B?elJRVGUwVVpWcEtkZTlieTNXblBEZFNEQnR2c01oSWpQR3A0S3lyRjVudWQx?=
 =?utf-8?B?L0xDWnF1NFpPK0NseU5WZ3VIdGxiS1pEVWQvQWpqSG9LTDBMbkhxNndtTkNh?=
 =?utf-8?B?bFRCYzd2emw0TCttV2dlQkhjNDZjbS9QWW9NZkxvcVJha3ArUW80endtZTli?=
 =?utf-8?B?SDEyQ1drQSttVXlqaFo0cVRZaHdLN0s3R2lYUEhYNGsybGI0MDFuaUFhSGNE?=
 =?utf-8?B?RU5uSUxUVTBES0IzL1pwc3prekptejdOeWdyUndhMDZCUmV6SUcyU3Q1NUx4?=
 =?utf-8?B?N21kUlNvYjhlOVRhb0cydyt4eGpxaEV5RmErQVpuOTNONWpXOEVtZTF3T3k0?=
 =?utf-8?B?VHowNWJjNzZkUDRmV0E1a1BzelFpbzM1ZzBOQzVOd2ozVURFL3o0WDBRbEpr?=
 =?utf-8?B?V1dRNGxMVzl0YVBWWmZXMk9FUXdrRklNREVGd3VMREc3N2xydVlpWTE2MVpU?=
 =?utf-8?B?aXREZThEUGo2Z2V6czRrUWUveEg1N0p5R2RYV3NsQ2t6UkNzS1FKMkVQZmVJ?=
 =?utf-8?B?U0hENFNZQUtMK3BMUG0ycHVZYi81QS9DS09WQzhxZEdqcUN6MGZGTVg4bVNM?=
 =?utf-8?B?Z2lMTEZuNVlndExJVXJCOTdnZks2bnNRTHp2YTBUQ1JBbU1uMi9RdEpQcnl3?=
 =?utf-8?B?NU16cEtHblJ0MnN6aWkzbGZuOW94OE41Q2NpUHJqRmg3bDBZNXV6VmNCbGgw?=
 =?utf-8?B?TmxBbFJrYm9NRWl5dGZ4UGhPOHhKY2tHS1pGalUrb3FLTS9IdUF4WG4rZFZF?=
 =?utf-8?B?a0VNck5RZS9rS3o5QWtMZ3ZYcDdUbkNMUjZ3RWVKT0dDeHdCNUx3b2tLRllD?=
 =?utf-8?B?Mm52MFBGV0xQU0JHZ3dVYy9GZjdKYS9Xa3c1MGNrVGpBdUllWHViLzhuOVc5?=
 =?utf-8?B?VmNJMi91SzRZWnhNVWkrZEQ3NDl3QThVL0N1S2hWaExvVXFMWFBhazJEM2Nm?=
 =?utf-8?B?N3pYV0d1U2sreWQ0NDJWZFBYSU5ndXQxMUI4MTRxd3RvR25JRkFKeEJKTENQ?=
 =?utf-8?B?ZXdSLzBkNmVUWTNPTHNOS1ZyeGpjaHMwN0lWZjVxS1F2QkpsMGpsZUxJeHBU?=
 =?utf-8?B?SkE0aHc4cFRLaFpYaHpoR01EVk1CRktLQXVLdG11SU5zUUpjYmYxaUVKWVFK?=
 =?utf-8?B?Y00zaHNKV2MzZGprN0tEUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y21EQmJmMFdqaGJZdjJjbzNtSGowZjVEdkZpWVpPa2V2YkdUemRUQTVWQkhM?=
 =?utf-8?B?Q3o4OXJFU2Q4bjFKVkJqTEd3R1FoMWg0eEJESEtjYXh5ejBiMjRiRk44SFJE?=
 =?utf-8?B?NHgvcjE0T0JSVWMxWW9ZK25Ma3RnL0E2VkRKcE5DMFNYZmYrMU5hSFMzUVF5?=
 =?utf-8?B?a1I2V2tBaDZGd0U1QVRuWTVzNHNnQ2hjaHJYQzIyQTFIRTFZNml3a2pLcWRD?=
 =?utf-8?B?eWJaeVZrcUV0bStXZkhEM1hGaFl4Q05uSy9IL24xcVVCWTFneWIzQWJIcERp?=
 =?utf-8?B?TkNDRXlIWVc4YnVyRVBrREFGTmloV1FISUtqSmRKeHBxalg3SnRvQnpValJM?=
 =?utf-8?B?T0V4bjluYWlxWDhKbitianpkUWw3NG1NZ1NyT29mN2pPd05RTlZDU25HV1hK?=
 =?utf-8?B?bWk2RWk2MHpCV0RXYVEwZDl6djVITFNreVpCb0pPNHZOWkUwNEVPeTlld1VD?=
 =?utf-8?B?MWtJMWlzeFdNNHduTmorOFJKYk5kRkV2bWlhQWtrRkNMcGJlRVgvNE1RVmdI?=
 =?utf-8?B?V1lRQkNNekcrcDYwUUdqaFh4TjNhZ3FCanRwRUJGT2ZwZVFtMHdGUHdRaHY2?=
 =?utf-8?B?WDJGTVB1ekZUSTdnTFgvSkN5Z3RrcTM0dnJPdGNNc1VNNmtEWEI0UmlRNDAz?=
 =?utf-8?B?eG9oUWFLVWhXSDZjSWVpQ3o4SlBkZk42YTlqUlBHZE9QQ1VvcDdwTjZkMFVK?=
 =?utf-8?B?aXVQekt3Tkd5dDhPbkQzeEdpUHE0akxaSUhkZWkzWFBBL2VnOXNQbkp2WlZY?=
 =?utf-8?B?b0NlTTlTcFlab3RqcTlCTXdUc3o2OHU1OGRndG5xb0tOdHd4NTBDQlVRc3lU?=
 =?utf-8?B?RzNkNm5BRWJ5eDdEZ1ZTM0tMWTdhMWJMY2hYcnM3RFdJZWFsL1pDckJWRVk3?=
 =?utf-8?B?bW5xNExOa3RBR21GSGZvM2JlSUwyL3p6SlJEV0E4SnZKbUIya0ZveCs4N2NE?=
 =?utf-8?B?Zk9pSk44TDBHZFVnS29yNHBZK3UybmpXdEhQRDMwTDA3ZVlGbXcxaHRrdlUv?=
 =?utf-8?B?Ym1zOTJMTnNEZnNaNGhjMjVkNWFCclBaNm5vTUlweEJTUlJleGM2c3ZtUmI4?=
 =?utf-8?B?Q0dBcWVrOEw4bTc3cVVBcWhKNk03QkZ1M2dqK2VuSHBhK095dmp6YnQxejF3?=
 =?utf-8?B?Zjd6R2tCc0UrcFBQMkozbnBQNmVqOEJFblBXa0JJMkdIT09PRThCckhvTG1F?=
 =?utf-8?B?L2ZTNUlsVXBZck8zSm5tVldKb1hMVlQ0QXJMZGp0TW8rUjRKS25tVlVRcitP?=
 =?utf-8?B?WDNGaktIRitTQmh5T0FkMjVRbzJFNG5OVzRLS1BJUWoreVVVbHNKU2cva05x?=
 =?utf-8?B?V3VjYW1OYlNjbmpxaVBwV2lsUWlYd2N1TWp3U1VKQTR6dkpQeXlDMnN2c2pS?=
 =?utf-8?B?NWFtdTNKZGdodlFnWlE4cjNBWmNBWUlqVmJqWmduVWNOU3ZseW9SbHFpajVw?=
 =?utf-8?B?b24ydi9nYWxsUys3M0RBTnRBVmRybnc0Qm5GMjBLY2xnZVRWUXovQTNTYXVO?=
 =?utf-8?B?cEFuMDBLMFRtWnNLa1c2T01CMU9odEV3YkVXTUtUUTAzaG5YVEdweTh1anFl?=
 =?utf-8?B?cnlKQ0J2MW42UkplK2dEYkV0ZWh3Z3NOT2RtekhKdnlmQ3dOUjNzSnY3V01N?=
 =?utf-8?B?YzMrZHEvSzZLZS81ZlpnNEhJQ01oUnRpM0VTMTJCZk1CYkdhbUVYdTlwR1ZO?=
 =?utf-8?B?aENVRlhiY0dTcThNbGMvVVZjbzdNdUhIVDB1eGVkYTAzb1dsaktqL0twdE52?=
 =?utf-8?B?bnU4NlVIY0lUdU40Skk3MldtK2hjQjRxRHhYdTZodEN1citJd3NGTTYzeldL?=
 =?utf-8?B?OHJPTGdrdkNSdW9tcmwyQW9UbmFqTU9QK0twQ1hpbEIzbXppK09CZXpSK3o1?=
 =?utf-8?B?bExuK1ZHdlZ0djVrOXJJL1M4aWxPcDhQMzlWZEx6UlMydWE2T3BXWHZPOUVs?=
 =?utf-8?B?UWppT2hIRUhRODVnWmcvRFNjb0h3MHYwQWw4U0FYVDhHNThpSDZXMzFrbWFT?=
 =?utf-8?B?L1FjUUxDMEsyZlM4QTJ6Ukt6VGJDd28vTm8xZkxMOFduZkVoamNJbHJxcXo0?=
 =?utf-8?B?RWJVeStvSXR6b3hNMC90TU1OZmhDMUNhTFNHaU8xS29WZ3RKN2xqMHZIdTZ2?=
 =?utf-8?B?VDBsOHhqTWFmaUlnOVVBV0lQUlFZWFlJZDBzcUQ3Q0Zuell5a21ZVHRkQlY3?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b92a5-9ca2-4142-bde3-08dcb13f17bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:59:32.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO4iotQrXzx8dtA3F9CrCy/s9SRBOTZWHFuyO1mUpASKwSs7uNNiCkAtXYSuj33dLe7Lhd7UYGBjdVdLgv7CW6q35dE6ui6nswWWtN0gvi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-OriginatorOrg: intel.com



On 30.07.2024 21:51, Heiner Kallweit wrote:
> The skb isn't consumed in case of NETDEV_TX_BUSY, therefore don't
> increment the tx_dropped counter.
> 
> Fixes: 188f4af04618 ("r8169: use NETDEV_TX_{BUSY/OK}")
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 714d2e804..3507c2e28 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4349,7 +4349,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  	if (unlikely(!rtl_tx_slots_avail(tp))) {
>  		if (net_ratelimit())
>  			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
> -		goto err_stop_0;
> +		netif_stop_queue(dev);
> +		return NETDEV_TX_BUSY;
>  	}
>  
>  	opts[1] = rtl8169_tx_vlan_tag(skb);
> @@ -4405,11 +4406,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  	dev_kfree_skb_any(skb);
>  	dev->stats.tx_dropped++;
>  	return NETDEV_TX_OK;
> -
> -err_stop_0:
> -	netif_stop_queue(dev);
> -	dev->stats.tx_dropped++;
> -	return NETDEV_TX_BUSY;
>  }
>  
>  static unsigned int rtl_last_frag_len(struct sk_buff *skb)

