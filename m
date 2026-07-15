Return-Path: <netdev+bounces-307693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8D6WFEY+V2oPIAEAu9opvQ
	(envelope-from <netdev+bounces-307693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:01:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A875BB0B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:01:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SK5zdLos;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307693-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307693-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF6A83007F66
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609F3C3782;
	Wed, 15 Jul 2026 07:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA33C3C0E;
	Wed, 15 Jul 2026 07:57:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102241; cv=fail; b=sYCzXQMCQCZxBzl19Gg2hAfk2Q0m5B6hZK5PDUYESn7ZG1V6qnBoyQzq6h7BXhwDiyStlhKmikv+6SGK//66124KJU9+hNmIVTs63bE96MpC5twO2E9hBShvOdtDFQ6jSwiuscvkxUjsDDcjudUiqgGyM/AIua/TENT9VxQgD8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102241; c=relaxed/simple;
	bh=wRWzVLqxSRgLtAaO3pt4KuXuAfd5sqypPm/OYFo+wm0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hzk3WiTyXyj0mKNJe4EAFiNOw4trQ91aCQbl9ayWcPTtHFuVmlw0iP5hf4YLflrPJU4N5IoQfbXrLx1CyWxy0YnmJU24rhaNxDBcO7L/DtQq1fpZGLp/YTW0AB9nPngnpkl706gcyDndNrMjZfLQmrZFvJ3yBRDcWlXREWClMWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK5zdLos; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784102240; x=1815638240;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wRWzVLqxSRgLtAaO3pt4KuXuAfd5sqypPm/OYFo+wm0=;
  b=SK5zdLos5zXHdGqKtyoK9330f933WW6rP8cerOUNFN7ryctorweipF+l
   Hs1KgeXnZ4f6qdaexNEHxn0hpLqrz3tIcf11MXsYeXVK6I5Xi4vNT2iNF
   rr+POJbRFWEmnrByPr8Vx+znHi+FQW2VmXJjq0R8WabH5D0adWcdBdlwd
   D4iO80jgLHHJ+aWKNzwDRqmRf1mhouPu+pMsSbS0zG+Grj7iZtYG5H5Yj
   ofw0te4KT1xjlKgrKSLyOQuE0BzexBIk1AnVCUC8tlWwaBF4oB2sK+SAC
   +P1VS14m4Si6Q38F9Cs07JEIhsL4aRApFx0MD1sZFGu7bfn+rn4kCkELq
   g==;
X-CSE-ConnectionGUID: F11rafLWQjWgUg384kyrVQ==
X-CSE-MsgGUID: 1ipmH8fdSNir8pX4ToACug==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107527614"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="107527614"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:57:19 -0700
X-CSE-ConnectionGUID: rFrqptZ0TJmtYRE4YMxAog==
X-CSE-MsgGUID: nc2rKPqhTz2KoFSB01yyqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260400968"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:57:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:57:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 00:57:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2kJ2Jef74CjVWUJ8Pqqn7OT6g9HMWC5lajY3bxWzVSF3vZT6XNOcVFITY9t8IAp5d60/4G6CFcEBLtaoPp3ZxA7gsyXa4wvFv1oVLqOkpfHNncWO30trg94O+06oscnqPWjoRW3iYnKELvVQUvwaoy7Azv+hAViOswVXlb9naqOTxa5c7XL8iCVVGHuq9JKmRAp1o0jdQyAgBnx18vCSKJlppmbSgi4JQF+W+BsljpoMfg2rmbkRcX2as3j2MfBY6tQvRlOQXILpElG6tK3pZfqIzAMNOBsqLnTBVs1ClWT/gyOGJAu+ZX2jRycXo1D/46gh/CDxU+22O5h4oRZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41N8npMdO32fBzd238ytDnh4ZTaWpqbLJt2ZneEylys=;
 b=W37SKxRSI0IMDvW31rRGtS7lDxL2gYdXyXKz7bgSfM8IuBGwLs2m3CZ7gni6ekmNQg10Of+4uuDkGm2xbqkL7xa52hISgBHjaX/7TSmyFumSTxh3mnP3H/7RhQNtCbKSPJUvrDB7SkciTakKhG2grZwjG0fxCGbExfU2W3oQ5hgV6GtUp9gwdmHPCl/o3wpPyD4rF838QXoyndou3TS5qdaqGXQVdLQr5nGMfP/Df9h2CypCvPpwL/+f9WC/tVALpmC5A3fAodZcqVG3OxIAbjfL8VVTm165EMHloOfdszWIaCUKwJZ2Ae1JOmB7xeT//2Cd/uXNvCEk6Ur5JnQp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:57:10 +0000
Received: from IA1PR11MB9519.namprd11.prod.outlook.com
 ([fe80::a3e0:3591:1c17:3b19]) by IA1PR11MB9519.namprd11.prod.outlook.com
 ([fe80::a3e0:3591:1c17:3b19%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:57:10 +0000
Message-ID: <0e28b9d1-ab9e-4934-b939-81557f6495b5@intel.com>
Date: Wed, 15 Jul 2026 10:57:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough after
 reset
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
 <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
 <c3030882-55c8-486f-8ff3-571d001b99a1@intel.com>
 <ajiHH-RaHUjgraMh@acelan-Precision-5480>
 <1d6c3aae-c9b1-42da-b5fa-6f8ee9ebcae1@intel.com>
 <alcd_FnUdrQug5cm@acelan-Precision-5480>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <alcd_FnUdrQug5cm@acelan-Precision-5480>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To IA1PR11MB9519.namprd11.prod.outlook.com
 (2603:10b6:208:5d6::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB9519:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2c3bd8-8308-4a0a-ece1-08dee246ac34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|921020|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Vw0gplxz4ovTAaUoU0K6j/TGPj4OljjA3wTnYT1BBm3jSQ5zzUB6y+wvkccELG8NojUcYeShrs6RhxNEvBeWrz8qIRrVfG0TycGs94jSplXsgc6RiikHSjlslSCFO1WCO1SQZ8n/a8OuOZv5dt7eV18SXTxV5w9Yry0jFAfMNirMMCtre/KIT3EKi+UuxLnLQ9lAQNYMNy+d1wiwgndmAb2e2AM5aaMIXPBtYLalvPUGTqZVhuJEDT1+KBI9ewyywAlH2KUFeIStm1X8pUxdSLOkHqnb6WK0uhpG3RaSyploblC68nE7pua276PfQMaWTRrBvBhkNLvy1ahHkuNDwJsz05lxN911nerfhRR/WJlwgFq59jrLqSGOKqyc16pa0w76CBCH5HRfq7GYNTlrySPqTaaZnJrv91dZ1ggWQzxRLxRN6YCAtQKdVop4hySN1xgLhvl/tnfe4p4NYeFEh+zpjSeaGjWLF39lovS1Kwe68a1OKzqoaUKKmgqiIuLctuiNA8ml+cA43x2vymdYHDfy6l+sDGQ35kiEbhC2EDko83pBqXd27HmINVHUj8ShHP82g8xWuyYzLneVG0X55+NTf04alyAppU4sx6jUirpc0GidAivpz1g9/Rtvdean9jTDXejwbhNr5T1trpFfPEiL+hWZia0fTMZeX84nOZA47PixOU4a/FfDUgD0aEPAnQgDbSGdzGcICXRhGZp5xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9519.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFlYkFpbHF4dVl6c3psK3MyUWx0T1pqSDB2aWJlMkl0bWt1NVhaMmVLakU4?=
 =?utf-8?B?b29CVnpYM1djRmFpQ3l0eTBPczNvd0V6RXFoL1ZMc2w0K2p1RGt2K2JqM21h?=
 =?utf-8?B?YVhtNmZTejBxVUEwVy9mbXZWM3RnVlhyVi95dTMwc2VHTVB5YTU2WTkvZ09H?=
 =?utf-8?B?RndZVktJTzU3cjlDQitibEs0OGVwTTlFRDVQcTkvZ3lSYXJEcGNRRnVUUnpB?=
 =?utf-8?B?UTAwVTc5ZmR6cGtFVk4xaUJ1dDd1K0I3Z1I1VHg3WTcwNmhWSWJzcC9FZjdr?=
 =?utf-8?B?VGhNNERnbDVvV3FHNXVpN0Yyd2UvZTZuLyt2YzBnS2kwVVR3c0NSL3NsMU1l?=
 =?utf-8?B?S3p1aVZaRzF1bC9FYVQzN1doSEhQNzVhaWZCMkJITW9pZm9JbUZHb2pRR2Jq?=
 =?utf-8?B?L2xOT1BiMnRxQzU1RkgwWmZGT0pIY1dIQTVLNHF1a1ZpaTNXVEpTVGwzVDJu?=
 =?utf-8?B?TTQ2RnVabDRpMUR6Q0tLYkdZK1YySmh5UEJHejlFaUVCS1lCMStrSWMrWHdt?=
 =?utf-8?B?VFUzaGp1eEVkb3ZKWFVtRm95UlR2ZnNHUjdQRVJWV3ZXSE0zcHk2VitBSEln?=
 =?utf-8?B?TXRGK0RrbkxkYThiVmliUzRGTUxnZHA2QnkwOTBZTS9sUldpNEQrSHZIdS9I?=
 =?utf-8?B?U2psa1YyUWJzZGd0TzRaaG16L1hON3RsTnBiSG83M0s3WUJlWHo1bEdaWlZj?=
 =?utf-8?B?K0lWaVVVTE5lSUl6VGI2dlJHTUNuYWJ0czJ0VkU2MGxQZFd1SUdwMVJQVkVB?=
 =?utf-8?B?Y2hqOE5uRWNnMXNHTkRwSEM2YXBFeWQ3WVQ3UWtQS3VjRnFMdmZZcjY4WlpW?=
 =?utf-8?B?czlicnNmSEdDOWxidUtUcWphbEhQTVlJQ2pLVllTYkZ5VXZXVWh5Wm50eUhZ?=
 =?utf-8?B?cmgrSlorMkxLd0JVemxkam85YVZYN2tlMEdEeENyTXVtcUdrczV0RVd1UGly?=
 =?utf-8?B?SkVFQlIrRFUvQ082aFZOUUorZThxY0Q2MmNHTm5DQzJ2eTlnTGdIV1JVSEox?=
 =?utf-8?B?MVU4NDIrUFFIYlFsdGlKTVhnUkxraHY4aUxzbCs2M3R2ZVcxU2hoUThHUTZQ?=
 =?utf-8?B?ZEhrc2xsVktUKzRwT1ZkWUxQd3NEc1RpTnQvZlNvTkhsYWxjcVZQZDFsNE0x?=
 =?utf-8?B?TWc3N2doUWxYZzBUZ3F4LzFwaVFFalczWHlmUnF5ZW5wR3RDVlRqcEVUNFZQ?=
 =?utf-8?B?MXFyTW1TdXlJOHAvdXpoblBzNUwyZitnQ2lKVEJ6RHpuU2krT3BRaEVwZjJz?=
 =?utf-8?B?bG05Nk10dEpBd0VYOHFGRmJ3OUJ2d2ZEQWdSMTRCV3dJckFUZ2RrZDZSSDZK?=
 =?utf-8?B?b0RZajBGS3RReThoY1RsWVdzQ2xCVGRkZVlvMnB4WU5XdnVVUXZwa3Y5VVJr?=
 =?utf-8?B?M29DVDIrVSs5VWs4NEtWMm05L09OUnI0dXdlNHJJUTJrd0lvMWwzall6Wm1w?=
 =?utf-8?B?ZGM3RDcveEplYXh6bUQyQzlPVzFUSXF3eUp4RDdOYUtjMUwwcDB5UjNiRG13?=
 =?utf-8?B?aFJvVEFaTHE4d25VbVlsRTNxc2FvL1BSL3p6SGg4ck81azVzMDVic2QwSTMv?=
 =?utf-8?B?bXUzOWFGNGxJYVZ4RjdFTS9odHZMV1QvYWI2MTNkS2VLRDgrZ0laSFFOZW53?=
 =?utf-8?B?NGF1a0h2WHNwUk16cGg5alZBUC9kL1gvRXdPU2dMVHlOeit3MUN2WUtFQ0JX?=
 =?utf-8?B?alNjcWhUK2Nralp0SCtUN2FZNWVQTUlrSVdvc2I0bkg3Rm9GY1JKTUVURXRs?=
 =?utf-8?B?b0htbXcyKy9xZ3I1cERHUmdVN0U0YXAveVVneGE2ZUR5azFsMTNrSW8yRVpQ?=
 =?utf-8?B?SE9QYXNiUE1JSGZ4R2hZV3V1Uk11d2ZXWFUyZGtiOGZCTk44YTV2SE5BUjZx?=
 =?utf-8?B?VFYvL1BzaU5OV2Q2ajlEQTVNMVcyeUpOZnRXYWtKMDRwUkdodk5kMHE2Zmpm?=
 =?utf-8?B?VmlKcHhUc2pKMzBMNUlteTh4cU55K0g3S0lEb1dEK1ltcVBoK0ZaWmhZd2k3?=
 =?utf-8?B?YXE5clJIS3YyUGFUak9tRklvUDJFWHFuM2owdzFVVjNvZkwrRks1UkthU2kr?=
 =?utf-8?B?RFViaXJ1cWI4ZjJaTWxIUXNRdnFhS0l1dHQ3Ti90bXpwWUVGVS94Q0tyWmVz?=
 =?utf-8?B?NmhtdnFURlIzNm9od2w0d3NHemthYUhhM0lEb0Z6R3NpcWROdWQzUDdib2hJ?=
 =?utf-8?B?cjFEblNoRUZUTzhWdlVXSFFJcHBjVFF6aDBrV3BQYjBIL21odGFjNitzeGpR?=
 =?utf-8?B?U3A4ZkE4cDJBL1dYMW4wcUoxSUpuUm1Zeko0Q05ORVNBeHAvR084aXJBem01?=
 =?utf-8?B?ZG9GN1B5THM2TFFpc2tpOUx2eHpkVkFHeEJSK1RWYkNyeXBQRStZM0hEdlhX?=
 =?utf-8?Q?eju5tLFZm/3uiwJo=3D?=
X-Exchange-RoutingPolicyChecked: GmUkKAOs7wTB13MZy6+6aE3nh902mQ44VtTxGve2U8UmeXqXdt8PXl18cJDRHNRH76JDLPbb5TuOnnTboQwZwoVnrfLXsGe6uOAq3f2IzhLVt7+TCUakSMi9FrhAVlzHJJv4g9w44aLYX+ESdMB/d/YEHFxwgfF94tqLBE4fBabr+gwveiKhwSGLdIXntH1O0If7D2Cghjfx8zCU3Chzp/MSLG1yOqjju8sBMaJ+gDeGIT+y6OWKLOl9cnGzV3AdqeC4+uo+GE/wGJonjaZMI+AiBgPbyT8stDkznqcjVaF757VO2QQrCWdWLdUmY56jGE+LYGUKcZVGXZOq43+a3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2c3bd8-8308-4a0a-ece1-08dee246ac34
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9519.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:57:09.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/T7LvRayXPxbZHmEA6LwD/aKvQGTRESuRHuJqhsK+v3WjkwF+uLYKB6gV6BgOGc3nWx6zG7CVlFmp6Ba9W1tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307693-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:acelan.kao@canonical.com,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:url,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[netdev@vger.kernel.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE5A875BB0B

Hi AceLan,

>>> I wish we can detect if the MAC passthrough is enabled, so that we
>>> know if we need to poll for the MAC address.
>> Unfortunately, like you I am not aware of any way for the driver to know
>> whether MAC passthrough via FW is enabled. Because of this we have been
>> exploring a simpler way to support this feature via ACPI objects (which are
>> set by the BIOS when MAC passthrough is enabled and are easy for the driver
>> to query). I know some vendors have already implemented it, and I am
>> currently drafting a patch to send.
> Any good news about this patch?
The patch is here: 
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260706/055944.html

I tested it on my setup with MAC passthrough enabled in the BIOS, with 
good results; no community feedback yet. I encourage you to try it. 
Lenovo and Dell laptops should have the capability.

>> The mechanism I have in mind does not require BIOS support - the I225/I226
>> FW already supports the required interrupt, AFAIK - it merely needs to be
>> enabled in the igc driver. With that said, there still remains the question
>> of how to notify the network stack above us that the MAC address has changed
>> post-probe - and whether it is even supported.
Looking at it again, this may not be as big of a deal as I feared. If we 
can call eth_hw_addr_set at any point in time to change the address, 
then we should be able to do this in a response to a FW interrupt. I can 
try to draft a patch for that, in parallel to collecting feedback on the 
ACPI approach. These are two different means to the same end, and some 
solutions may implement one but not the other.

--Dima

