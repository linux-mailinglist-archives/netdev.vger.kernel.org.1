Return-Path: <netdev+bounces-258341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDuyMK3OjGnbtQAAu9opvQ
	(envelope-from <netdev+bounces-258341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:47:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25907126EAE
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700DA300AB20
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05B34A799;
	Wed, 11 Feb 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNLo0OFI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91332BE037;
	Wed, 11 Feb 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835604; cv=fail; b=BQ2vb8Lx8kCcVg6NEuw34uIyo2mLlc182ZlUiNnxQKyN8j6flfiVwWmIS8N9c1yx/KJSNtQ/RejfT2RX6V5HpFAYNVUUaNJep9QG3AuTDOd6zH3TSzS/CNlMRUr3L9wS3zFSyR0aXe2QtSIffnlaCKUGJ1aEUvy5XnkQ4g8rH00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835604; c=relaxed/simple;
	bh=DBvRkmmbBjQ8gxN7KUs3fuIfGxIF8rFOWNsW4TZOCkY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bI97GRZUklOwdwytBB55R4zcVMlHwI2nigvFSPSvwty0Ah0pU4/TQ8Mytww3AyKTw9dEAExDVzs/85pNximwLRFe7FSU/KSUjDBZ1AMPz093+/fYf/BM0661KQa0d7zc8CWIk+lbNhC5n6mbIh36u7Tjnf66dAD9O/q29s+V/cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNLo0OFI; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770835603; x=1802371603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DBvRkmmbBjQ8gxN7KUs3fuIfGxIF8rFOWNsW4TZOCkY=;
  b=RNLo0OFIUFpnhD8t50S72tn6GvN8pzroRFu5ydg6RMc4ZripH6OgNtJd
   /jGnGnWHKVYnUEuQimyqjatuMYjYYTqjuh7IgN7gPKSFZf4iNSo2UUkxi
   HWody8ZP33wA79Et2sEOqArewP81wb7lE9vCHdR2DPZRWi6iyAzS3x9kV
   JerRQgxq9A9E9wti0jWzrit9230/uJ91vCGz6XY+9P47IIDPFRE0C3E+B
   /fAXEThJyvvHUuEWnxj/SqwreklImPOlAbWhGRSQLbplZR7I+fjNtyznR
   hYkeSilOVHFHfdGIDd+pcoMwZWJyzIFCz92TM4N42BX33+/O0uwa1ZXse
   w==;
X-CSE-ConnectionGUID: MkPfqVLkRRW6ADb5O2YNNQ==
X-CSE-MsgGUID: WOu3wnd9R3OGDlmwPIg5Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89400876"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="89400876"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 10:46:43 -0800
X-CSE-ConnectionGUID: V6PE8YzQT8q/CkjAwhG1WA==
X-CSE-MsgGUID: k8pnvv0aQj6bqUDL3BPzCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="216836449"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 10:46:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 10:46:42 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 10:46:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 10:46:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX6vZuulWUrmpNNnp0QMqIDJ8emkI4MvJCupyMmWeJ7En/6A5LuzNHziwjER++lh/WDzMw+RM5N9SUX3KHKIz5YSIh6yDLgeTpg+DOFYyluICb7tZGM1CtLnP/FL6g/IYKGQUMQJG8X+uFYYJfrTmomtRS6d1oveBUyn/dJrg5eq4X/zediZERt2e5Ndrmlmcw6Zt+5+iu9xgOHj9PeLznBQGFFudW9sJTYel+bkYbbH/Rxu0/9lKtuj4wxiAaEVv06s0maChjNd11CJZgLTxAGM/MtagwEj/A/GuvX9uyR5YL1UszYMiV4LrAdnE7u8v92J4AY7haNig8lIB2jRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvrCv7MjIY5YwihlCqSkKqE1lDI2uKjrK3+PxbXmNsM=;
 b=YO8PzkHrHzpoeYmAbAg5McMbUIsDW4RkNzu9QQhKJLyr8k4ReUpgT99q/Wsr8oHumrjpEyai2r3esiMJ4tcdwsDp9oUfVXq9yfUVvQqxO+8JvHp/Eful9wrL37HetrXjfOiRdtNPfgUWqCYPhaUhfwROR+R1IevIVT0qfvlDfNcA2ln4c9+jAWtvwpBaknd5bPJRPqPTdhIbBK34x8h97HY/+8Qf7wwCRAQ4euWHlD6FMGylZvIKg7HwUDGKMi+wDywbiTA9/Yz9Ao2RfEuONUOfICpyaPz9Wg/h+WwdAjrH3mK1/qzmeCH/82lAI/29LJzhVOaMki81gGEXOaxZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 18:46:39 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 18:46:39 +0000
Message-ID: <da2faa88-7d81-4b2b-bf2e-f7a4e4a22615@intel.com>
Date: Wed, 11 Feb 2026 10:46:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<andrew+netdev@lunn.ch>, <ast@kernel.org>, <sx.rinitha@intel.com>,
	<horms@kernel.org>, <yury.norov@gmail.com>, <john.fastabend@gmail.com>,
	<kohei@enjuk.jp>, <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
	<alexander.nowlin@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<edumazet@google.com>, <aleksandr.loktionov@intel.com>,
	<marcin.szycik@linux.intel.com>, <hawk@kernel.org>,
	<magnus.karlsson@intel.com>, <pmenzel@molgen.mpg.de>, <pabeni@redhat.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>,
	<andriy.shevchenko@linux.intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
 <20260211042458.555701-1-kuba@kernel.org>
 <2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
 <20260211085514.428236b7@kernel.org>
 <3b134d22-30ec-4532-9b89-f96761d3abc9@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3b134d22-30ec-4532-9b89-f96761d3abc9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH0PR11MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4a7369-0e35-4cf8-d08f-08de699de3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUhoM1dkcVVhcEQ1bVlySi8yMTBENnRiWHFHUGY4VUNFNU9Eb3lSMkdjZlRv?=
 =?utf-8?B?bXcyUjY0WmsyMjJsSUV3U1NRNlZLM1ZxaCtjUTdvSW1UVU9wVkpTYWVXUVBi?=
 =?utf-8?B?aWhoMUprT2JDcTZScElhMGp1TEk5Q29pRjVDRExEWm5FMWd6U1hYNU1pNUow?=
 =?utf-8?B?c3VzSDFPZ3ZOazdYZjVoelc1dzdHVTFqWE9raUxxWExrWEZPdm1RRUlIdTJY?=
 =?utf-8?B?SFZ4TUVkUDY1L2doSGRsNW1nUEhmRVNXNnIwRHVhdE5DT3pLaDFWZmc1OS9y?=
 =?utf-8?B?eTJNeTFMTXNuSG83bkxTUkVmMVlNbERrZFY3czBNak9KWUx5WGljZVVFbEsx?=
 =?utf-8?B?MkVKK0JFdUt2elNUcUcwWVJVNS9uRGxyelFNamFGR25FWDVSRkxTb0hGd3lT?=
 =?utf-8?B?My8rOUs0c0xOaENKMXAyenJkNWlKY2pHZ1YyUTdSVnFHdnhsTS9ySHdYRXRN?=
 =?utf-8?B?UjZiei9ob216NUZNVWh3V2pza29tT24zZFFOazVVd3RZWXVoaHRQcEY1dU10?=
 =?utf-8?B?YTNnRW1FVkJPS1dpK3ZYYm40SEEwSUZkQUJOb1grMzVHeHRMWDhmaGpNQ05y?=
 =?utf-8?B?MHhKU2EyUzIvR3ZtRFgxNG5MTTliOHl3VUZuZmhOeUY3aWE3OVBYV2lHRFI0?=
 =?utf-8?B?QTE3MWtHY21CSnlYNWVNbUc3WUZpNEZOS3NYejl3Wm5oQVNSOWprb3I4ekFC?=
 =?utf-8?B?N0Znbk1nR1V2RXZoSHUyeXB2b3A4eEUxV1pWZnV4S3NlMERRZVY1VkFyeEZY?=
 =?utf-8?B?bW1nSTVmME1Vem1IQXpqS2FiNEE2RzhuS011R3R0elZiblJDTFphVlloVm1R?=
 =?utf-8?B?WFZoakJaeVV4Um5tWlZzNE5vcFFPeG5IWm90ajF6c25mcWg0WjFtOXVBb0pM?=
 =?utf-8?B?Q3B1Q2NBNXBCTUo4aVFDRGFQdTRlZlpOaC9IcXdERWlLQzg4NUk1K0R6OE8x?=
 =?utf-8?B?SnpldW9qYzJ6Lzk0S1BleFFycGIzVzArcnFkeHVhWHFTbG9RN2FBMmdSNVd1?=
 =?utf-8?B?aTE5TUhkaVhCc0NPUGg0cWtMNmhabVRlZnFjQW1URXJYakZOeTdvYllIbUJQ?=
 =?utf-8?B?dGVrQXVVREUvazFKVy9YWTd2UjJlOWVSNWVNZXBuTDM3RVFLcHZEam9Sdkpi?=
 =?utf-8?B?YUM2OWpxcVFUd01oYS91MXBHc1dpOFRuM05SVGVLWnhMdWFWWFo3eDlOc3JV?=
 =?utf-8?B?OGlKSnRCUG9aeFRnL1BsVmpFT1BTOWpzVkZ6TUsxS1NhbEgwYUNaNDNXd0Z4?=
 =?utf-8?B?MlV4LzdDcVdSZnE1OUVYMExpWkF2T1NqSnZIa0w3UFR2V0lra0dKd2d0RnNo?=
 =?utf-8?B?RXgrVmhTTTlvanpTam1mUXpaUkduYVZpL2hTQkRNT3BtU01McGV4NjQ1QzRE?=
 =?utf-8?B?WUlFNzJLZXR0WENRM3I4TW9mUnZXaWZIczIzU1JOU0ZvaXpGV3FxV3VEVEc4?=
 =?utf-8?B?YzJ4TEhNb1krRTlaMERDSllNQk05dHVzajZyM2NEQkdtUFhBUGVldWJlTnpj?=
 =?utf-8?B?TkthTnpmVStXRmhHakZPeGQxM3FhNElRdUVKQzNpQzVxQTNUekZKWWwrWmxQ?=
 =?utf-8?B?U1BkdGVTN1VNeG5rbzRobUFCNHRmZzg4OXlzdWxnS002NjlzcEZWd0JOZ1Fk?=
 =?utf-8?B?V0kyZTlGbXpyT3lPKzBkb3ZDZkRTOWhuUHJSdFhXWitwVzRHNU44VEpaZVln?=
 =?utf-8?B?c2JpV0R6dWxGUjMrL0x3am1wNS9oVWVPRzRJSGFjSUI4RUtjODNGTmFLZEMy?=
 =?utf-8?B?ZTNpTEc5UWtqL0dwZW8wWWJGSlJiR3hwMmhTOWhJN0h4bVVzbkovS2RuZXF2?=
 =?utf-8?B?UjFyT1BEV2NaSEJ4LzFkVkRtNVpLSk1rS1pxU0dtZ0tHZmN1cng3dEY1enkv?=
 =?utf-8?B?c1dTdS9LcmtSZks1TmVmaU1YSEo3cWhzNnJEMTRReWRzTWxjeTQwK1kyMFlJ?=
 =?utf-8?B?elJXaVU1OVRpSlhZanlLUlptdmVXdllWSEF0SVMyUEVRblRZWElhZmdIZVhZ?=
 =?utf-8?B?eTNEdEFacHBBWVNmaVlvbXR4SmRtWlVraUM5cWVzTXhpcjZLQzVlQUZxQzcw?=
 =?utf-8?B?N0NETm9pRitzaU1Ua0JUbUFkV1UrbUtyUURDbHdmQnBWV2poNFJseFlRSWNW?=
 =?utf-8?Q?ZkJQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRzaXZwMWMyc3FIRVVLYWQrVFNTbm5haVowV0RnbGhqS2JmdUgzTlIveUZ6?=
 =?utf-8?B?elJ0eDU2MDZXYlZVWURBZE5tS0d4cWFXdng4dWV1NFRsVjVvZ1ZlK1hhZ1BO?=
 =?utf-8?B?Qnl1dmE0eW8vWVRrdjBtMlc3WUY0L2NDVVZmTEg4dlNveDE3bkZlTHpRUkYy?=
 =?utf-8?B?VlNUUGMzY3p1K2VSb2QyU1AwQTluWTQraWJuUnl4TXNGNzdNSUNVWDdZWTVT?=
 =?utf-8?B?cEN5bVpqQzBWK2tISTByeEFKcnBnaEVFN2Z5eVc4WEsxN1BiTy93d3hNZHN5?=
 =?utf-8?B?Zk42N1pDazNCSHBnUXoySzl6L3ZHVEtQb3pWMGx6WGlrb2huTzQzL09VK0t2?=
 =?utf-8?B?ZTh4YUZHdEZ4c3AvOTdtTTlFUUlvNlZWYnBnU2ZXcVhRRmdiWi9NWUZ6SFVJ?=
 =?utf-8?B?ZEVnbGNZOXNjbUg3aGMzdVRnWUtlU0NzWFJHQ3RobjlzWkZOREhRL0lwNGMw?=
 =?utf-8?B?QTJENXBOVGtMcjQ3aWxGcXk0UlZIQjFyQ21QYmVZV0ZITWd6WVYzVlpZc3VE?=
 =?utf-8?B?SW02ejJFbFJ5RUxFckp0akZNWldyaU8wVk04end5Zm1kYlp5akVCTTRHZG1j?=
 =?utf-8?B?WmpTUStVbTVpSVJDY0NiQVFGUVhsRE43elRHNjRLYnpFWHpoLzBBSGhsbWtV?=
 =?utf-8?B?UHpXRXRVSloyd1JubXNaWjhjSWc4UUNhUVNraXhjYzBONmk4d29zUWprY1hK?=
 =?utf-8?B?eG5aZ0dSZGpXUUc4MXl2UzRzQzNKWHBETFYydWJqbWszMEF6cDBramJwY2dN?=
 =?utf-8?B?Umc1a05iZ00yL1hJV01rU3NnMk5TbGhHZ2JjRTgwNUV4WVRmaEFDeUxFTVB2?=
 =?utf-8?B?ZG5aMnplRzc1WnhoRUJWdWZSd2FDL2NZUFB3Q1VRbUI2TVA4cXBrRmtrMXBQ?=
 =?utf-8?B?N3RLZzZKMEZtWmFGc2FxMm1TV2lUUUJKSGhyT2JDTjI0TFBROTU2YkwzUElK?=
 =?utf-8?B?Tm55N1orU1hXOXJDZndYZVEvQTVjWmlkR2FDQkpVQVV1eXpQZ3VuTU13UEtW?=
 =?utf-8?B?allxa0tyeWkrdnFYdnNSMFZZT0hoNXE5M3NPcmhMQ1lIZXBOS2NKaXM3NlhN?=
 =?utf-8?B?S29Qcml6K0hwU0wwMHlxQXI0U1c5bnVyNnlxdkdoNDgzY1EzRGhQZytMd2g0?=
 =?utf-8?B?OHZEKzMvak16Wll2VGFzODllaFN3Tk45MkJ5dVJTK29sREhuU0xyaFJyRW9N?=
 =?utf-8?B?amY2eGo2eGNMTFFIZVN3VitCTEZ0YkhWZEVZVWdtMTRSbm1PbDgrU3YzamV1?=
 =?utf-8?B?dS82OXBadUoyajFRRmZTcWdyYzQ0V0djbE5rWkRkTXFCUmdjMGRQUHcybVE0?=
 =?utf-8?B?M3NleVZUaDM0UmZPdlpSRWEyRHYzNFVlVVNKa2k3dE5lUmxnVW5IZ0Q4cE44?=
 =?utf-8?B?Y2tPcTBpWTU4M0JhUi9LcWN2RU1VcGhFRWk4SVNac2JydFdORlBtSW43U2s5?=
 =?utf-8?B?cEZCOVViTlJ2bDAwM1p3WUtvV2JTdVIrV2RRczkyaWNUN29ZU0NHUGFKTTdq?=
 =?utf-8?B?cXp5bElSNkw1eWdmb0tmbmkyVmJSMG5CQUhRb0lxS2d2UGE2emJiYVI4MWdR?=
 =?utf-8?B?TXYra2lLT0djcStsaVZYVnVJVHdpb01ZU2FmZFJoSHFmOUphNTVNamVHd3NO?=
 =?utf-8?B?ZlhxdXA3elZHZVJ4Z1loMExPbGNETk9hcVhRUWVQZEdEcm9zc1AzWkFLQzRW?=
 =?utf-8?B?S1dzdzZmVlVaTXQ2MjQ2NG9Bd1VQK1hmR1hWcmlRNGpjS05XMWo2cUtBTWtx?=
 =?utf-8?B?ckt6VFphbCtxeVYvR2xrc2g3TlQ2dFdoUFJua05rd092aDJHS0Zjb2JKN2FK?=
 =?utf-8?B?aC81QldFSWdSbi82ejIzaWw1L20zaUExQmN2TkEwZXN2TjU5aXk0K29icmFS?=
 =?utf-8?B?TE80YXJJcDVzWnpHcHdRRXJ2dnlOcmRuWVR5aGVBK1FBZ3pyd3ZnL3BVa1k0?=
 =?utf-8?B?NDVuYzd4R0p1a1lJT3BpMWhpWDVXSmRhSUFGV1ViVGZ6VFc4cWNncnFRcXZw?=
 =?utf-8?B?TEFuaE1mNTFtR2JrWEhwaUtBQ3Z2NEJkWVFJUUM0MGlLbGxzTXJiVW9RWWFD?=
 =?utf-8?B?bXdScTdDK2gvYVl0U3RyWk5TUzJnNk4vcVNHRHBIRCtpcVoyb1V0Tnd6ejdI?=
 =?utf-8?B?WHdvYmNDcFhVcTFZbzhhZ3c0VFdhNlpuRk5nNnFxOXF3MlNZQ2gwSHIxQWE3?=
 =?utf-8?B?TDVEU0RQdkZPazZULzF1TnR5OGJPMXpJVWVBUDZERXp0d1BSWFpobkwwbU0v?=
 =?utf-8?B?NWYvWk55WDlNb0JhYjZ3U1YwZXNXcFNHaFdIU09zaEVvSytTMlZlTktSd3lX?=
 =?utf-8?B?WXBxNFh3dFpidVJMYUlSaW9objFodDFvKzJJd1F0UHJudzRRRkJUQ2ZWdDIz?=
 =?utf-8?Q?P+MtFCk4GXk19th4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a7369-0e35-4cf8-d08f-08de699de3d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:46:38.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDRffZHm0Ue4f6KvWXYwkPRXerxcZrYD6q/F5aJbhxglNONNMj9T3CRpLVWaK26GijA+SqZw9mmiOLDZtwK6jTDdqX/bTuSg9srQFs883+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258341-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,lunn.ch,kernel.org,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 25907126EAE
X-Rspamd-Action: no action



On 2/11/2026 9:13 AM, Alexander Lobakin wrote:
> I'm not frustrated at all :> I mentioned those 1.5 months only to say
> that during that time, none of the users of our tree faced any bugs,
> except one case which was fixed a long ago.
> 

I wouldn't trust an absence of reports in the case of subtle locking 
issues like this. At least one of the reports here is obviously valid:

ice_vsi_cfg_def_locked holds the netdev lock but calls 
ice_vsi_free_q_vectors in its goto cleanup logic.

Its a mistake in cleanup flow which is likely untested. Of course users 
haven't reproduced this because they haven't managed to get a failure
that would trigger a cleanup.

> I can't say it's a false positive, but I can't confirm the AI is
> absolutely correct here. At least a couple places mentioned that
> "shouldn't work" in fact works. It's not just me being Sarah Connor when
> it comes to AI, I just don't want people to trust it too much or authors
> to waste time proving that AI is wrong.
> 

I agree it is important to take the AI report with a grain of salt, and 
it is incredibly frustrating when you see a bogus report that 
hallucinated some data.

Unfortunately, in this case its a real (if extremely unlikely to trigger 
in practice) issue.

> Your call whether to drop it or take (this PR also contains several
> patches not related to netmem, I think they shouldn't be dropped?).
> 
> Thanks,
> Olek


