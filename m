Return-Path: <netdev+bounces-120348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F14959058
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C54C28278B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD21898F2;
	Tue, 20 Aug 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKSMGCvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC31C7B82
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192105; cv=fail; b=m/ZLBylkVXstXg9Hxeer74ackFe9994j+dHlnFa9r/fxCvKRMer/RLIshYnvhqUapB52nWAsKnRx3fvvW55+OZ5fTJRTeVy5UoQ4eePHMSDZ3tacK6nYil3rzP5ETXKTGyomKWn8gumm+lzHsaJQsbJPZILb9BC8TPyrpLU/9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192105; c=relaxed/simple;
	bh=niJFJQpboTwWJBltp0SvdXnvopJFeGTpMEg37QOe7Os=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePNKk3HXSn0SAMvtbeIhPtw7XOymxtQg5wkIRrtbtpDoKKM1+tWADHEs3cfQFGpyO5LGr0IOGfrfdiMSxl5xUU0w+f510Seky43F5uFIR1CMmMdkVo5nGmIFl0MM9s4g41+YNtr4g77jOmrz7X6RiAx6IvP4OZp4a3ZKeDMV9ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKSMGCvZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724192103; x=1755728103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=niJFJQpboTwWJBltp0SvdXnvopJFeGTpMEg37QOe7Os=;
  b=dKSMGCvZb15p9WM7XkjHdLeurQloW8cspVYU0YimRFLN7FH0J1FEuXwP
   LhgApIb2KQZXlbP+Oefe4ixfJfxawAYSq7RyzZsaZUqJJro/E3nAmck5E
   5pCCvfQJE0sorxef8Dl2l0mE5qLSfrsujZjP95SKdatdBVbxWUseRcICD
   XB4MFvuXp/4YS72X4R81jMskhj2LEX1FKQZzzbH0xxtA3U3Zd4VbXbenD
   zu/arCUzeyWii/PSjuyOFVoexAZADG9Dptqc+kGtovjkY9FAK90dZShdF
   O8ggV10pNRiM81ApaGbkBlMkHPIptXFC6OE988Ktq3lXagoZYFUJfIaqM
   A==;
X-CSE-ConnectionGUID: swHtoea9SbeuwQ/jUX/lmw==
X-CSE-MsgGUID: /q7ZfmNvSi2hEIRRS6t3Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13120209"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="13120209"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:15:02 -0700
X-CSE-ConnectionGUID: LtOWmSIQRD6o5/yqXONeQg==
X-CSE-MsgGUID: Gs6m0eUqQTCXXuSH3dyXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="98350492"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 15:15:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:15:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:15:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 15:15:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 15:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvpFQ5CjvZaYCSQeKQpzCYEc0GPuemjEQTDpreHl7fAOeT56iNXP9WSCBFcuZLpflep2VC4Y1A9eeVVkhRD5v8AGGL9URcZEo+wDELOfqx/Oha/EIvbR/87MvlDxGK2O+u7DR6U8JnEPHGM0fch+f2niAzjiYzkh+wzLNJrJ8zkpGq5WRY8Mci1aQCz1zvL1qk3iLIiIKsyHfy7ccOuD+VeWjh7oe8z8R28qcxKqag3nQ3/qeAmLM0f3X97rl7fk/JslrnV6e8AzAp4YUJ2WeoedgqxkzYgSif+DJQmNFYSnQuE53yn5SOsr7tYXG4zqJzklazoH5JmTJ9T/4/CONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKXYgVO1M+Q5QHZIWFaFe8MwjqJvIabvZey/9fJ34eA=;
 b=iDno3ubeKvSkrkBFl4U+MgZ6K724rWWDlixOhFN1n+oqjlpQ35hbVApiaN3bhLaxq5ms82FCmNvxT9K0+4qbS1WEkvld80ZoC6TB32ugdUNOeQz7ojySdffi/9Wa9voE+9GkuqRUTZl5evG0xRFv9GChPDzJnSiIKp6KHBakSVum+V17NytLQlJFHxx0NxxmNNfSYxbBsAxNmz90I3cOV50DTe5+X4+F/Xh1uMFaC2NBMzEQBlhx1Sr30kUo9WDS/N3qrp+pS49YgCtiHCEkdEVZ6QEzeJ8BtdH+tPsfoY8BzYqQB3a3R2KOmf2VT6/0iTIlTzHkUKVm2kRtfmPTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 22:14:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 22:14:56 +0000
Message-ID: <22518742-0ccd-449e-ba6b-676ab899dd76@intel.com>
Date: Tue, 20 Aug 2024 15:14:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] ice: fix ICE_LAST_OFFSET formula
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Luiz Capitulino
	<luizcap@redhat.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
 <20240820215620.1245310-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820215620.1245310-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c73f35-8320-4f36-e118-08dcc16585d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkFWRnArb0pyZDYzRUVtKzYzMlNBZ05MUEFxOTl3Y2dVcllUYjFKdHdLUll0?=
 =?utf-8?B?UFozVktvNnM1SmVxYWJZK2xXMWkzOStzcVd5UDhnNTU2ekxaZnEvL3Z4NE15?=
 =?utf-8?B?R2tYVjh1YyswU0FZQ0tUSC90eVErVGh1b21ha1I4ZTZoYXFJZEVodFlTM3FJ?=
 =?utf-8?B?ZysyNkdQSG1KZnJJclJtSUtvMjVmODNlWVBWTzJtazNCbGhMeTlEb2FRK3h1?=
 =?utf-8?B?WDdTbHNwSTZpMW9DYkxGZjdzb2RsOWx4VlU0UGViaXE2RlRJVVVRWkNKY21E?=
 =?utf-8?B?NnlaZE1GSGszS3RWOU5KVzFOUFNpRXNBTGVUUEpDa1ZtWWE4ZlVvSEIrTU9q?=
 =?utf-8?B?REdmQ2VWaW5uUUN0bWtHQ0N0TXZzUThEanNhN0t5bi9tM2RmbmN2VGViV1h1?=
 =?utf-8?B?REZ6UmlYRGdpQ1VibXNuZDg2S2NzVGdXUDFjRFdIWUtJbjMwRVJxS1ltdzdu?=
 =?utf-8?B?MzR5NDNlQ0V5aENLemxqZlJ3NXhRRDBtbHZqTlBoZTNTZE9vUTFPcE5YL3k2?=
 =?utf-8?B?eVE0NFY1NXRudjk0azRnSEprMzZkQ1FMbDBZY0JibXFxNUN1ZnNCalF1LzEy?=
 =?utf-8?B?aHNkSWRuY2JjMENzZjYyMXo2amtvSjcvRTVFN1lxYjBTb0xNYXJWR2d6YmNW?=
 =?utf-8?B?b1BUUk9TUXBMazFFUkYwOC9PcUNJZE5QM2swSnk4czZvaWozMFFiSEt6VWhs?=
 =?utf-8?B?emxHZlU1R1lTM2NVWWVsWkdKb29aOU4vWnAzZTF3Ty9HdEpuZW40T0ZvU3VP?=
 =?utf-8?B?OG5iSkt4OWpJY1FsaDVZSm9uUDNaRnA4dnE0UVdzc3YzbUVON0FHOElyQUVx?=
 =?utf-8?B?TTZvQ0VLVkJJS3cvdGZpL0gwQXRDcUc0ck1oeG8rN2xKb0pYNzAxTlpicDhB?=
 =?utf-8?B?RDNud2l6cVphcEkzclpXbEpZdXhvYmRrdFlSdWFXMVhXbE9SeEZHR3ZrbXBY?=
 =?utf-8?B?YTUzMXd5WERIZi9zdHZRV0l1Wnd6S25jNE8vZG9TYWFyZ3RzRTBoZnhJdjNk?=
 =?utf-8?B?SlJMbkRVVEJWZnhHdzY4UWpIMUNjUSttTmU3d0ZIRXVKT01FZUk4N2FZdU1n?=
 =?utf-8?B?VzNHMjZsZVB6S3kwMVpXdXVjbWFkN0NLdG1JTjJjMVZDTjVmU01LUWwvamxu?=
 =?utf-8?B?a1gxb25MdUVlYWdiSFJHNlN3OW45M0FaeWY1Z1h6ZGt4c3ZuaE1sWHRrdlA0?=
 =?utf-8?B?TWUxODgrK0FLK1h6U0d6TFI2NU1XK1Z6S1lVTE5UWTVLcXp2Y2d2Y3JkaGUx?=
 =?utf-8?B?MkN2ZVp1YVdjUWRXYnI0ZmZ0dVBLUHlVdEVINVZQRjRrbFF4bDhCMk1INXNM?=
 =?utf-8?B?RHc1MU9jN0Y3MW5IS2JIcDN0cisyVEJiNE1lb3V3Ung5OGpxNkI1N1Fmclk3?=
 =?utf-8?B?WVRvT3hFN201eEF4MUhpbXJMb21QVEJsa0JIcXdPSWVZUG1sOHdIMjE3Y080?=
 =?utf-8?B?SnJ3ZFkxZ005a2NJaE5ib3hrVW8raklDS0kxMXFQN3pCQVhRVHRKWFpWNWxm?=
 =?utf-8?B?akQyMEFoT2l2SVRtNWtkc3p3K3JzdHE3bnVncDhOS2VBN2V4L1hTVGQ0SENJ?=
 =?utf-8?B?UDI0V04vQWY1S1ZaL0RLMFZXSytkR1JTSWdKRmFoNjVNY0hCUkpjSkRSQmky?=
 =?utf-8?B?WVhEUCtoT1lzTFNqMUpoSGtkTE9VNTg3RU5yNGs0VHpYTnhWcVg1VkdwQkFN?=
 =?utf-8?B?dVZDQ2dCMmFhTDJTQ3FNWW5TdFU3b1I4bzZpUHJyV2NmblBHT3hpSXdFVU9y?=
 =?utf-8?B?VnZ0VmhMMlMxc2J2ZW15NldTZVRBYTNtREZmOU9jaTlLMmhwZ3FhWjBmOXho?=
 =?utf-8?B?VmxiT2s3RExaNGoyaWVpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9ZdTJxQ2hVUEVydC9ReTZOenRaUm4rN2p3V2JIc1FFdlVKMyswT2twWDg4?=
 =?utf-8?B?ZmNnYlYyMlpsZTdBS0RtS2RodHFBdnYxc0pmQ1RMSXJzZC9sRFpxL3NTWk9q?=
 =?utf-8?B?MU5zcS9zakVuSVZ3QW53eTB2VVNNUEVnWHZ4Ry9OeFRmcklXTGJqeFdOQ1NY?=
 =?utf-8?B?MHZyOGQ4d0RHa0NSNDVGdll6V1k0dnJ4NzZ6U2FpbG94bGw1V3Y1Y0gzWFNt?=
 =?utf-8?B?eVJ6REVBY1JVTzVTMlVQL2FENTdNN2ZJaGdnQVF4N21SV3lIRjZrdy9UbWdt?=
 =?utf-8?B?TSs2RUpxdDg4L2ZsVjIxczE2eHRiSjRVMWdObzdTQlJFbFl5QmE2NXdiaCtM?=
 =?utf-8?B?WnhGVmlyVVViK3ZwWWkrRTV4M2RtZ2w3SlY5QTcyTXNZMGg2dDBFR0NSVE5Y?=
 =?utf-8?B?UDNScGFaTXV4ZUpUT3BCVmtiSGpCakdtY1RLQzZPamttTW1yL1JoN0VXNmtO?=
 =?utf-8?B?ejIvbmc5TWR5aXJOOHYyOEhCcENsS1FlMVBtTDhkWlNmd3hWOWg5S0N1OFdH?=
 =?utf-8?B?MUFnaGd5Z2c1Yys4Smt1N0pmMjhnMm9sc2k3Z2xtUkZySHRReGE4M21MZ1V2?=
 =?utf-8?B?UGE5cnpWaEw1MUpBTUwwQ1VoU0p5NDlQeVhHVU5DRzZudGt2RTNrTkRnMGN0?=
 =?utf-8?B?NXE2UGlkNjI1TGg0SHVhMjJkZll0MHJhanNnS1RURjdlZzBKUjB6dGtERS9V?=
 =?utf-8?B?U2p1RWU4ZFplU3FkZGljM1VQK0htZlVVb2VaVW4ySTdWbW4wbWliajZLUk15?=
 =?utf-8?B?aHgzUy9xT0ZJZWxxVTJPMXh4WkxJVERHL1J3MWwxOWdyYnpsTitpR0xsMUpS?=
 =?utf-8?B?c004TzhLVW10OXNOOGI1ZU5CZHptekpvLzQ3WHk3elpOT0xURnA0NWkzQTlW?=
 =?utf-8?B?ZUplWXlsY3lJUTNDK2lVNCtWcjhaYTRDZEZ5MGZIQnFrWnpzeWNDanFNRFZx?=
 =?utf-8?B?ZDZKeit6YUJrOEFvc3lXYlBGYWVxUkVwTWtoV3h3cFdIc3BwMlVjeDJxMW1k?=
 =?utf-8?B?OGg1dHQrSkttSkU0blAyMS9oM3NpTDd4NEkrdDdvcklNKy9pUzNCWld1eVRu?=
 =?utf-8?B?cDZmNUQ0RUVMSjllTDJHbVRlWGh5VzNsQzJjb25pWDdKTC90ZmFKYlpDWHo5?=
 =?utf-8?B?UlhzSHZRYnYvS0tTYVc3MVFObTFkL0xqWldRT0VkcWttb2JWenRFNmpDcndQ?=
 =?utf-8?B?bUlnV1FGS1puV1R6ODB3WGZWbWorZE1aVldpei8zK0l3eTQzMDVRY1RuZm0w?=
 =?utf-8?B?ZDkxekhBWUVEZHBiZ2J5QjJpY1IvT0k5b0pXNEpBdGtzNDFjZ3NDR2pKVFZr?=
 =?utf-8?B?UVNxUDFxYXBWK1dmaDFURmd6REZmdkczK2pybnBDSVRVeVdJSHM1dm9yOFZQ?=
 =?utf-8?B?MkxvbHZDczdQWlJHRThSUGV2Y25uQWN5WnpVVDNxMWRSSWNEQ3EvL2xoTlRU?=
 =?utf-8?B?TWpMbjBacDlrdldWNlI4bVltZW5LcHgzV1FoN3BhVXRjWTJuTWorS1V5amZM?=
 =?utf-8?B?SjRQY2ZrVjVjTlRDVEVMdFllOGVnb1hoTzNTV0xGdjlzRlJuTElXdDdmRzdy?=
 =?utf-8?B?aEt3eUJlTzJhYXEvbUJWQzI0N0luZjBPVWllUWZCTVZwLzAySlYxZXFsaFZ3?=
 =?utf-8?B?MUpkOVNHNXlVODh1bTBtK1BCMU9mNTlzY3dLUTdtd1p4V3BuaEVCSldEMXFI?=
 =?utf-8?B?OWVRczdXU293eVdDTGxxTjRoRnp1Sm9XaGFNSVkwMjhqRFVwU0wyOFJyaURO?=
 =?utf-8?B?ckJKQlYwanN4NXdjeDlHdWdLUGRyaDB4T0UyN1Q0YUxjSXl2ZTVwS3UvaVIy?=
 =?utf-8?B?QlV4bTNmay9xYWh2WkQ5c2RBYldDVDFTb3Q3VEM3R29LM1RJMjNTeDhIZ0VS?=
 =?utf-8?B?SmxLWTFDM3RCMU44NjhEd2VnQWxwSFF3ME02cXBQZStadUh0c0tNSHlsZU9k?=
 =?utf-8?B?dTY0aVVSRVIxVjZkQXcxSndvQVJRM2o0bmU5TDVHcHJOYjRaUURJRzZ6UmpR?=
 =?utf-8?B?cm02NzRuV0RXRmJ5UHFXdjBVMzlnbkdkSCtSbmZ4aS9xQkdYeUpPOGl6NE9y?=
 =?utf-8?B?dHJKaGFTTWFiUzZ3aHJJTXNoU0UySU4xQXFLYnQ3N0daSWoxQXhyNktGQUhZ?=
 =?utf-8?B?b1I3dlZvRVJubUUvZlJOQ1BRZ0VkeEdSVlZwVlNvdDZ2cVdzY0ZyV1JvWTVp?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c73f35-8320-4f36-e118-08dcc16585d8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:14:56.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ+NHEYLBZz5A3EuhM61HxSOVWji3UD5ARZkEMa2u5fc4r/GZZKPyOHFVODtVVN4FIey/5/HUY7v3suCBwNiRqfY4D++cCa/UT4NrCEn2nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com



On 8/20/2024 2:56 PM, Tony Nguyen wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> For bigger PAGE_SIZE archs, ice driver works on 3k Rx buffers.
> Therefore, ICE_LAST_OFFSET should take into account ICE_RXBUF_3072, not
> ICE_RXBUF_2048.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

