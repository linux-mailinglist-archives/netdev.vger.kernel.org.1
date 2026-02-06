Return-Path: <netdev+bounces-257369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLUpDGkwhWlV9wMAu9opvQ
	(envelope-from <netdev+bounces-257369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:06:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B33F87D7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 267B93015D28
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 00:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9FBE5E;
	Fri,  6 Feb 2026 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfbfVBLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED4DF76;
	Fri,  6 Feb 2026 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336358; cv=fail; b=btUBCX/WOrSsoJNMsyPkSKSsm8Dch1+Hu0IKW+YbGe9gu5jycYj1ejRWWNtSGropb+e/FQOiwIKPF7U1BAh3nctJUFI38tBUt0GwVjO2iMnkLF1JJI1kDuPheGI5a+tQA5yVs1SqqBfgNpndv5Bglu9QxE1qraernXqbpAlMAaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336358; c=relaxed/simple;
	bh=7UZ3UMtrsgdT32SGkQ3GPdFXevkXulVCFEwfQkgC5hU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eaqW6PyjJibsktUfU6px4Eb4M5s1Nb8gX3QQywgfLJEq80VI2w+qo21MgI0Z6XFVmWSp49GFiRjYAlt1nDe8g0NCWZhmThpUieTB+iuefi22CRbIrhRrg4C9XvkaDp6RLV1YgfxizCNBpxzanrHvNvyYsS5RJFpbuoHC/lgWUVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfbfVBLJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770336356; x=1801872356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7UZ3UMtrsgdT32SGkQ3GPdFXevkXulVCFEwfQkgC5hU=;
  b=BfbfVBLJldEnE2nNARfLzSHm4c/9c637Z0xii1Yzd4LVKU59cUi1tZjY
   NHGyQfTSKyJmZAcY2xh9HynMN5O9AuZLVQEcSZFLvRzpPTPGVSmDuN4no
   s3Xh7siy4pjhHLp7Jmk2+Z398IQdJcuUpi7PM7J5g8UM4ao/Y97FuYMay
   iPPkrV0B+o/YvSHLp7vUBY/VJCLe62uA/bMus5poEfh6/55RCP+oFdTzQ
   3NWdbSpycDAemHleFQtCbA5k9aYQunrUunAhm1n6bCvayuCCkl1iU0Bfy
   bMdQF5G+f9Bf7MhAgGhKfHZIbEoQO75tQkGhvSIqT7hg8IIE9/exkbBAC
   w==;
X-CSE-ConnectionGUID: fKIw15w1TxWyCo6BlFC3Jg==
X-CSE-MsgGUID: L+oJCT6+RcWfZ1WAnIlvbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71611721"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71611721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 16:05:56 -0800
X-CSE-ConnectionGUID: BHO5ebA3R8u2UKIAULylaQ==
X-CSE-MsgGUID: QpRxXXETQYi60MC88IFk1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="214874887"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 16:05:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 16:05:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 16:05:55 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 16:05:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHgMu7YD6Swvb8g4seLtNvp0PZLYbpGpECnb5VQxZyR059OmBuwu2DSahoate9TJjlh05btfDs0u1MoVEKz9F+zuuCmTpSsqvMNF3ZmMlu9CbLFzxoOeuA7cpne3ybkpJywekNkFOf9uwCygPZtUIzUbuThUEuALTk3l40+LV3bGmOgWlpUcoafnWCj5RzNPg5aPXw139jst1h3w67NR9vD1tfiJiCB8/6Jqb/RzKo1NJ+jRDjLHIdNivJBFYxN51i+tE3t7keoFBb9u7CVh17N2Gj9vvWYHsHkTFN3GAtBP9h7ORyJi7BqPhDgQmNaMYQiOtqUO3LoBvEv9BBIhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbI9LwPqSuP5aENAvAmSsarFFnFnWFS1QFQFh5yd2wg=;
 b=VINZMCWY2qE+OgCzOiap2JKJ4rEplHlV2ZpmoU8cho89cTWsXxMMLiNkh7pZtqSFMCG0j72VXWBZ4FSqS1WUZbPdGBG1dqjgmbza2B6wZkf54HYQ03Sw8uxq1AfTzz9/kbu5xmstARHWcYSKssPJWxxRmx29AdEp/1DtJjahAVBkcuctaFW4fsD2Vlyl8jKlIMKZAvINEx1h6/IjMjU21fVk2rDN/5b7SbB3sFdsyyg5kWcAi0fdsfUQs0fYz+RerYSeadig7yodxw81Ib6qSJYtlPnYbcvRiALLhe3S8eOjtJBruhpsD5AFywu1sxTzRjS0SiSk/tiDUz79N0KQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 00:05:53 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:05:53 +0000
Message-ID: <a22f6805-a92b-43b6-8029-6b467f7f4b36@intel.com>
Date: Thu, 5 Feb 2026 16:05:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <87ikcbwgf3.fsf@jax.kurt.home>
 <IA3PR11MB898682AE39689F854F3BA178E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <IA3PR11MB898682AE39689F854F3BA178E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|BL1PR11MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 221acd15-04b9-4dc6-8cad-08de65137df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTFlQ0puYmVCWE8xbzR1cFIyQmlGc29sQ2RISXVhZG9VSzhxK3dtN1Mzckpn?=
 =?utf-8?B?ODdsTUxXL3FOQ0RmOHpXeUkwRFNUNytibWVCNWNzeTVaRmRwb0gzR0U5L0Zs?=
 =?utf-8?B?b0pUbXhjN1FyOWI3Q2RDRW5iT3dGRHoyTnYvSS9XQnRGNEM1d3ppUE1wYXRL?=
 =?utf-8?B?bkFCQlYyTzBoM1ppWDkyUlc3NnRWRW5Lc3k3YzZ0TEhMdWZ4SEM3Z1A4b0sy?=
 =?utf-8?B?TGxETitIR3ZQa0FvSWlCd3F4OWEvMkpEYkJIU0N0REJPWVNHS2xaT1VNa1ZR?=
 =?utf-8?B?YnBveHFNMVZvdDJBUm9lbnVNQXg3eGRPeE5neXdnZjFFZEg4RDFjdXcyNkpI?=
 =?utf-8?B?UHlyaldJL09lNHQ5OUhEcS8vN3J2YmgwUzBGazFuQjRvVVM1U2JTNGNSVlpR?=
 =?utf-8?B?WnE2S2I1TVpWKzFuYXFjRGhibG90N2ZobFpYY1cxUk1vcjNublg5RTh2TW1F?=
 =?utf-8?B?YldzYVY3ekR4TnlGSUw5Sm95NkNzdklreW9HeWlreDFGSzVMOTNCYXVOaU8z?=
 =?utf-8?B?UkN5Z0wyYStqRHZ4ckxadGl4WUF3T0MrYXVkL3ZNT3d4UFQxNUFEN2pBci9h?=
 =?utf-8?B?UjM2YWw1Vy9VNWtzK045ckNQRHJ1b0ovYlNLaUNzay9UVVpyekNzVmNueGFq?=
 =?utf-8?B?WE52aEN1U1huZHRvTlhYOXI2MnZxeE84YnlmcDZzdjY5LzJISVhJODdIWWJG?=
 =?utf-8?B?bEhqemVEcGszQVBPWTV3UDlPMGU4TnYyblFRQUNiYnIzWk9EVHZDbUNCWmlx?=
 =?utf-8?B?dDVvSG5DamR3UkF5SmZ3THUydkJmVWZhbE1PNHRTaVc2L2RMQXR6V2huR3BW?=
 =?utf-8?B?bUJGdDRQMG9reFB5N1ZwY1dmcE10SFF2ek0vWXJrSmsrZ2F0OWJTaGVPRk5q?=
 =?utf-8?B?Rjc1NzhQaTIwUThoN3ZVT1cxMEZkTEVrdEZFdDRnTmw1emdzUlQxOXA2VVph?=
 =?utf-8?B?dkJXdXUrSFRoMHhBRUw1VWhHbUs3ZWNSTm9NL0NMMXljekdiSHJtOFdzWmpG?=
 =?utf-8?B?anVTdXUvZks1NHhXUUFmaFMzL2N2Rk5ySnNQUTFFN1I3cVREZEV6bzhiSzNJ?=
 =?utf-8?B?eWdSbkdQUmxLYkVPbCtrQm5PaEEzNnd0VGV5N3ZiUDk4WG5ZQ3BOdWpGYTZU?=
 =?utf-8?B?NU1yWVJWR0NtK010VUg2L0pjd0JtaFo3QU9MRU5uK1Raem5KblZWWFFkd3Zk?=
 =?utf-8?B?cDRRemlZNWxZS1ZqZnlZTkMyMlhqUC92alVnNTNxU001RjBlNUN3YUoycW1X?=
 =?utf-8?B?dlNNRVRGK1pvSG1KZ3MwRlpJVjVvdUFueVdGYkFDRGJ6OGRxYWhCWWQ3VCtq?=
 =?utf-8?B?U0xUdDR5cHpKZE5yZDNaekRKMFZxWkp3MVltUWkzK3pjVGRrYmxkQWxuZkpG?=
 =?utf-8?B?akhUZWtEWnRoaUt5L1lwUTYrNkNGRTVyNzIvVENTd25IMFlhRW4ydG4yRGpk?=
 =?utf-8?B?Qi9LVlVoRnlGMzZ4STBoMUdCWjFTZ2g5TmVuU2xwZ1E1VjVzZFNFbXlZaHI2?=
 =?utf-8?B?WFo3cGR5bWVDN0Z6N3hvUUhZRlUvNG9RR1g0MUdRWTF0dFpYMGhjZmV6TjNv?=
 =?utf-8?B?NEtmTWN6NUNjV0xXNXpFUXJVWXRhSVFVa3A5eit1WDJMempMTFNnTkRUSmJx?=
 =?utf-8?B?YmRpdFFFUFhMSzV4VUlpRmxuT2Z2bWxkRWNCbUkrWmNRWXdNV2wrVkFRRXhm?=
 =?utf-8?B?ZkRwNSs4dmR5emMzbm9VZ1hPekZCTUhZQ2czMWJ0dE0vamg3VTdQU0pqaFdx?=
 =?utf-8?B?QXhUWHpDUjhJWjVqc053cWNIcFFLbkdJb1FtK1A4UkNtM2lubWdGZWYxazQ5?=
 =?utf-8?B?VXBndGFYa2M0Z09JaDc1eDcyU0c5QUs5a3hZKzNVcDIvdHQwd1RZSllmZkNL?=
 =?utf-8?B?VWZCZkZZYkk4L2RSd0JmTnh4SGgwU3NkZGxZUm1DdzQwZVdKRkdwYVdCKzdl?=
 =?utf-8?B?YVBXQ3QwV05NTkpRNlNaNlNxbUFYeGlKcjh5ejFHNEU4OWE1SmpYdVBET1V4?=
 =?utf-8?B?UVEwbXB2MWxQUDVGaEpYM3NlTG1QSHpiUEFFaE5TUUJnajlJUTVlSlE1R3Bt?=
 =?utf-8?B?Y2FzR24xOHdIYzRxeitXVDY5SHNmMysrbFNrTDRPeWRScjFWcmhaZTFvb245?=
 =?utf-8?Q?9xus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NC9qRldaNGd3UHVDVlBDbE94ZVVBVnAyUXpzYzB4SWR5KzRpazhjbmpFRzdh?=
 =?utf-8?B?bkRucHMwUHNuUjFzUUZSVmU4Sll1ZStOYU9BNjRsWUZidjhJN3pDM0IyVE9I?=
 =?utf-8?B?aEtzTDUwQWt6OUpqV012dnlvbzlxSGNnUU9LTm9pVGxtZlBXalZnVHpEVWpa?=
 =?utf-8?B?Zlh0MFVpcjFNWjlJQ3Jqb2JWelFQWTdzZnJ4RG1QelVZeS8rYXNjZklmMDlo?=
 =?utf-8?B?VmZrcG1DMThkaEREK0x4TWtqeENPcVJMUHk2RHRhN2hIRTduVXVIVnZkWWM0?=
 =?utf-8?B?RjBOZWxzVzJQVnpzMzZsMHBlQUNBNjdTVW5YSGRWd3pTSm5DbldYYW1tWEhR?=
 =?utf-8?B?b2pkSS9OMDdDTnN3bUVKSEF6cVkrcEtjVXZCdWc0MHZPTWVvUHJERGpmYkNt?=
 =?utf-8?B?eVNJVkdFMFBWOWJJYXJCWmZucnc2bElpMUxTN3RWL2o4am9uaVV2ZW54SXBS?=
 =?utf-8?B?cVgxeWVRUWVMcHhaNWFGTUNXKzJScG1LMk4velVvejJGcEdMejV1cnhGVk1v?=
 =?utf-8?B?ZUdueHZMaHNFSVN3UVhoWVRIdHNrbEhyTEgxaysrb0VHdmpNWW5FSnN4TzNn?=
 =?utf-8?B?UkN0NlRoSnZ3eVk4bzhFN3ZHaTlPZkRFUGJVRHpMVVh1Y1dSRy84RmxwZVps?=
 =?utf-8?B?eGZZRFlUOXlwQTM3TWw0RHQwSVg0RHlqeE0rcEs0clJnQng3V2pXOExVOGpD?=
 =?utf-8?B?dGN3Ly9ncThVWXQ0c2FBY3JLaE1yZWNvTXJsTnFtaW9ac1dndWF5UE1KSy9q?=
 =?utf-8?B?WXY3WUZqZHFyWGE2V0o2UCtOakoxS0VTSVZhaDBmSnVEVkg4Y1JITHd2QTRQ?=
 =?utf-8?B?RnVxYUVBZmhSVm1COFo4NGlQd0h5MjZDZlJabmt6VnFxNmdROEp3d0Z2dFlZ?=
 =?utf-8?B?SkZBclMrQklZaU1Td0tqdHlnL0UyR3c2ZXVSNFBNTERnWXZCY0pvK1U0Y3Ax?=
 =?utf-8?B?dmtENDI5ZllDZHFGRzFrYTdqR3hJK0p0VW1JVmZUMGRiZEJINXRVbnQvWkRZ?=
 =?utf-8?B?dm1IT2dhdzA5K2c3VTFFSERqaDRNSHhWWHRBb1llZjl1NmJRZ1ZMS1oxM29o?=
 =?utf-8?B?NE1NTXQxaFpDRnZobUdtU0ozL0Z5azhtRE9iR0Vib1NoQ2gwN04xM0EyV2xY?=
 =?utf-8?B?QkVpQmM1bk5iaVp3WUNyT0dzekdLa0MzSTFiYXB2amZnU2Zvbk9UVXZEcEJl?=
 =?utf-8?B?NjBTMkZ0aDl0dW1md2FUZXltUVNnUmtEVVlyS05kL3dISjRBQlVGRFlhbDdx?=
 =?utf-8?B?TjdXMHJkZDlVREtabENza01LM1pqN0NIQ1FXeEJJRyt4NENOMjdOWi9XcTAr?=
 =?utf-8?B?c2VKT3pVY0pjQ2ROZ1QrVVphK3Nodk12dVg5L1FqVzdweW9sWXc1Sys2Vld5?=
 =?utf-8?B?WUc5NmhOK3grdmFINkJndDBFNGZ2MzZ6d0IyK3ViRWZzWjV4UUJLbnBRclRp?=
 =?utf-8?B?VWJnaE9lTUNzV0VtUk5UM1FyanhoRWZXR3FLV2lvTllMa3FUZkViMmhCK292?=
 =?utf-8?B?RjYzM0NIM0kwYzJOVFdMbmEyU25jQ0t5TWxpbG5WL3pFd3hqR2RKSk5ha1Qv?=
 =?utf-8?B?UmVqNDZIOGdlS2cxcEpOYkRnc0NiTWZyVXJHcDR4VDNwZE9VL1JOMlByanU4?=
 =?utf-8?B?cHNsL3FPREJvZXpRQVVOeGIzRzdpZGFYZUZDN21ZaHNwaUdiWDNvWTJscXpL?=
 =?utf-8?B?YytPcjVTUTJ4UWxOVGY2WHpYa2RUOUszYUgvdHlTZ1dLbFRlaUs5RUl4czBj?=
 =?utf-8?B?YlFrRkZYMUdwcDJsSG5lMVFwRmpFekNFZGNYSERYMWt1S1ptUHQ4QVBlSSs5?=
 =?utf-8?B?UFhCUFMxdzJZVWVabmVtc2V6NkZCTkZTcklpazNnMkhFZzUrSjBGM09iRENU?=
 =?utf-8?B?ZysyWTdKKzVkdzhWaVZlSndNK29JL2U3dFpoWmxpdWNSSUZXRHcxVnJEK1Yv?=
 =?utf-8?B?UFlRdFVyaTloU3JHdHUxZzdHTGU3RWw1TTBtdno1OWlXOGhqcThqczF0UHFW?=
 =?utf-8?B?WG00d1NIZUs1N2RsMEpXd2M2akJBMWFQQ3dpQW1jZzZnV1BUYzVoWDY4cEFI?=
 =?utf-8?B?YWQ4cTBxeml5QlVOVFhWQ3RlcjJnREM0YnV5TlY5eDh3N2xzRFIrSVFVV0ty?=
 =?utf-8?B?SDNMU0ZIV24vMGxqUEowOWdoVFBZWXowNlFlU1FlT1BUUGVjdksxR3FSL2Er?=
 =?utf-8?B?NzVyeTZvVVR6R3dMSDRTMXNYMGtLZDRRL0pLM3lrTy85Q0VSS0NPUHJtM1lq?=
 =?utf-8?B?ZlN1MXdVZll4RWR2NGtSRTQ3YVVzTDRnRUtydVlpTXBZOG1MeFdSSGhhZFBG?=
 =?utf-8?B?SnhpbWJ0TmV3cE55UENycHpPM0E5cmRDOHRaUWZaTG1Pd3ZweE9nUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 221acd15-04b9-4dc6-8cad-08de65137df6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:05:52.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QXchDxXWFOr8sKr7UBoPUMdqS0WPjnQccMB9AKi59RQ1ZB5ozovn8vFi/IlifmCF3+KhAmEWJ79xYPf0pmk6PO3QQAQ66D919mpUzyS0yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257369-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[molgen.mpg.de,linux.dev,intel.com,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net,linutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,lunn.ch:email,mpg.de:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 77B33F87D7
X-Rspamd-Action: no action



On 2/5/2026 4:20 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Kurt Kanzenbach
>> Sent: Thursday, February 5, 2026 12:58 PM
>> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Vadim Fedorenko
>> <vadim.fedorenko@linux.dev>; Gomes, Vinicius
>> <vinicius.gomes@intel.com>; netdev@vger.kernel.org; Richard Cochran
>> <richardcochran@gmail.com>; linux-kernel@vger.kernel.org; Andrew Lunn
>> <andrew+netdev@lunn.ch>; Eric Dumazet <edumazet@google.com>; intel-
>> wired-lan@lists.osuosl.org; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>;
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
>> timestamp directly from interrupt for i210
>>
>> On Thu Feb 05 2026, Loktionov, Aleksandr wrote:
>>>> +/**
>>>> + * igb_ptp_tx_tstamp_event
>>>> + * @adapter: pointer to igb adapter
>>>> + *
>>>> + * This function checks the TSYNCTXCTL valid bit and stores the Tx
>>>> +hardware
>>>> + * timestamp at the current skb.
>>>> + **/
>>>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter) {
>>>> +	struct e1000_hw *hw = &adapter->hw;
>>>> +	u32 tsynctxctl;
>>>> +
>>>> +	if (!adapter->ptp_tx_skb)
>>>> +		return;
>>>> +
>>>> +	tsynctxctl = rd32(E1000_TSYNCTXCTL);
>>>> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
>>>> +		return;
>>>> +
>>>> +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function
>> designed for work queue!
>>>
>>> skb_tstamp_tx() can sleep
>>> Smells like sleep-in-atomic isn't it?
>>
>> AFAICS skb_tstamp_tx() is safe to call here.
>>
>>> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep
>>
>> In case you're worried about PREEMPT_RT: On -RT the IRQ runs a
>> dedicated thread. BTW I've tested this with and without -RT and with
>> CONFIG_DEBUG_ATOMIC_SLEEP.
>>
>> Thanks,
>> Kurt
> 
> Thank you, Kurt for sharing your experience. I don't have so many experience with RT Linux.
> For me calling a function, not designed to be called from IRQ context is a SUS.
> So, I rose the question about sleeping.
> 

My understanding is that RT is only safe to convert such spinlock_t to 
mutex *because* it also converts IRQs to threads.

