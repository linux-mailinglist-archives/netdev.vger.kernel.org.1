Return-Path: <netdev+bounces-258323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDUFMey4jGnlsQAAu9opvQ
	(envelope-from <netdev+bounces-258323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637D126816
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A9C63006787
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D6348458;
	Wed, 11 Feb 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAkUJPqr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED22FFFA5;
	Wed, 11 Feb 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830055; cv=fail; b=uchvMoSu21YoxECkOZIigHCbberRfOlJNZPoYZ5Y9V8ZcJREE8HPVEBJlghOpEkZWuVmE3UaD7iPWgz0Oj3K+G/AfPUhtt/skfASnrYVtSfOP371zc67yhtfMj5FkvRWZMTc974SVJCabueEf4kcns7rdos3LvGjGa+NPUsRhl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830055; c=relaxed/simple;
	bh=7+oPKR+f83rHm3bLLQt+/RgMbqnfatl0axYa4ne0OJs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMNlPYvC6B73Zkh9bWfJXFGomZVJP7ya3e1bl48dk/oyqSO2doI3q9Xy2sQOzdfoJ6dzQXnEU7Cb1pUZsWZicjegSA2f40WvjmWpZjV6gI0aUzqMthWQ5zXytUf8MS/pIVtaezvX/BREzcVNrqRb3lwDNt5m/OOZdGqk+BJSDoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAkUJPqr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770830055; x=1802366055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7+oPKR+f83rHm3bLLQt+/RgMbqnfatl0axYa4ne0OJs=;
  b=OAkUJPqrS+4Wxgt4XrM9e6/4W8px4M5x0kkYUbmrwycv9laYztyqt4gn
   pfFNiHDgu97+N388HIoL8Ok6lVh+Zl/UmCqTgRpHDM2DxX78Ha0LFABj5
   yC2CIeRGJMk7Kg/3z+Cj7DGbRL/Bb9CDOww0QN7NN9yq0BeYPW26eG7o2
   CHJVT9rKyKVYgmFQ1wtfYVp3tr8F9WxWo9k4RSSF+Ksq5c9yPXj95GjID
   CJz3Oa8QkyBYQnoH5V4mibcqj3Uu0Wm9r5MEA6dZGvs209Ly9jYksMNpv
   gnftLRG2YWSkQnCWdeT/NCLtvF+95t8wofOkiO5uCmVHQ9E1bR/7zjGHM
   g==;
X-CSE-ConnectionGUID: 3h5KZJHQRz+KEnYDFJKawg==
X-CSE-MsgGUID: qAv1WZIgQTCWc/dUe1DFTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72170992"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="72170992"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 09:14:14 -0800
X-CSE-ConnectionGUID: KGOqMLsoQMSjb/EgaOhE9A==
X-CSE-MsgGUID: FqDY9dGmSgaOBEvUle+szg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 09:14:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:14:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 09:14:13 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 09:14:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co2LCHiAj9sbVCzE19CjjAdtFylHrA6uYxc1cDSU5e2NM9XIn42pttOTlfN1K+aB37i6ae/0894o3xF5iJC3uf56h26XxweLpOB3klTVFEAU5g8YvU1fkmuvC02e25ZdT0/SQMm10o15iBLJdEfyugP2EN0Zntv84dn1jBxGZVKWhyAGO5b2PcUv31FQkn4iqfs/g2lL9TyA1Jw4zJfnsoNi1h/NXE4iR24+zxdTNGBFYvlBqO6YDoRuS/SNsD+5j0QZRkWJvAgQrMsZ9mtm39XXjAcsn/GYgydkifl3AmCcyxxNQC9jd/RbEErf59tKhVFA+SZTy3IvPN3eYj/x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k+FMQwggJVpnJ1l20CvkJsBfY0X84EGvpaeDOv6lhY=;
 b=SUDBXBcoeIfnVGSxUeD1fTx0doY3MrvYnDFeCv3m0iRWVbjY9ETuoUDQsJLKCiG6QmKZMyoh29jGRTdHrClL59nQHWHJj2ZqTu5zouvC3QBpysfsa2Fw+S21MtlfiUZyfjpib9mt3doxP5kpchAIZibft9AlkRrvceOdL3jHvV2GCLCC3fTQsDLNpAaPWGYSXkelU7U00rtUy3RHv3X+z1teELfo9Gu85mp1r1PwOvoSr3baRmqERuqu6KJ/NSkOfsMGfaSB04jXMyMHsFY1kv20sfqfTTU2IgZsnzCjm/hsdqqFPNP+MgtvRV79v0l62AUoaJwjpSNgYtVsIeUlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 17:14:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 17:14:09 +0000
Message-ID: <3b134d22-30ec-4532-9b89-f96761d3abc9@intel.com>
Date: Wed, 11 Feb 2026 18:13:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<andrew+netdev@lunn.ch>, <ast@kernel.org>, <sx.rinitha@intel.com>,
	<horms@kernel.org>, <yury.norov@gmail.com>, <john.fastabend@gmail.com>,
	<kohei@enjuk.jp>, <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
	<alexander.nowlin@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<edumazet@google.com>, <aleksandr.loktionov@intel.com>,
	<marcin.szycik@linux.intel.com>, <hawk@kernel.org>,
	<jacob.e.keller@intel.com>, <magnus.karlsson@intel.com>,
	<pmenzel@molgen.mpg.de>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <andriy.shevchenko@linux.intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
 <20260211042458.555701-1-kuba@kernel.org>
 <2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
 <20260211085514.428236b7@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260211085514.428236b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:803:104::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f625ff9-f67b-4c43-20a1-08de6990f7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWxUUTd0NHorc3BHM0ZDVklxOS9iMVlNYS95QktIVGxhWWZMY1pRSXQ0c0pp?=
 =?utf-8?B?VlJrbUZVa3I4ZzlFZkt2Sk5VQjZrZjB2YXc3UlRsbzdrMjB6R0RoZEFZb2sr?=
 =?utf-8?B?dzRic1NwNXdtV2oycU4rR3FmTWNhNDNRR2l1QzJ5SHF4TVVFQ2NhVlltS1Vr?=
 =?utf-8?B?YzZHdlo4MFpLbHUrSGg4NEJkSHYyRldRRzgxZFpqV25jd2JzS0E1OS9nRjRI?=
 =?utf-8?B?RzZoY3NESkRtZ3lWeFNqc3A1TmtZMjVPVmxZSHFZSlhRenJIRCszODhzUjM2?=
 =?utf-8?B?UmF3NU5WNVhmdTd5Z08yWmhOUU95ZEI5SytCR003YTgzMThOVUMrN2krUUxE?=
 =?utf-8?B?cG5pVXh6TTE3Nldhck9CcnRsc0J2dXE4bGx2c3p2VTB6Z096T081NWk1Qmtt?=
 =?utf-8?B?ZzRyQ1lhK2s1Z0pSWlNVTUVBaGZmcHdaVFdFdnVmNVd2ZVJLOEVXYm5qQkNP?=
 =?utf-8?B?ZE9LS1FRbDVLRkRsaUR2Rm1MZlVaOWl4QVRxdUZ0UnNKbk9McjhmYThKMUNW?=
 =?utf-8?B?clZVc3NUaFozdU14NTRUY0hJWVBjUm4rWExXTFVCTkZWUjJJUDFuVkpCVkFu?=
 =?utf-8?B?QVZWU1RLaThkd1dFOXpnTWNtK29EVE56N2g1UUk0NlNmemxDeUcvNkZxOWRR?=
 =?utf-8?B?RkNwYkw5cStoVmVpMDRRSWQwK1RJdnlqTEV4UEI0ZWR1RmxaTzZqU3ZSTTVq?=
 =?utf-8?B?WXJHbnhFeGVHTUxiaDRwVURrdUdlNWorc1pFb3QxWjNRMmd5VTluMmNGNUIr?=
 =?utf-8?B?SWRRT3k0S2x1dmdiRnpwOElQZ2EwREFuaWZKZGxSMzdPZ1JTZG0yYTlqeUdY?=
 =?utf-8?B?UDNtOCtOc1cxanNnQllSdGpLMzk4TEFpRkR3VldNaE5LVWlMT2xKWHpEcHpN?=
 =?utf-8?B?Rlk5bmg1R0xHY05CSVRSMmtIT2NNaFFQTnkyYlBkZG9EZDU3MFg3SFBXZTFX?=
 =?utf-8?B?c1EveUlSRXl1ZUdtQ0FzclVoOWFZVjhxSk5ZdkVabENHbTVTNy9zVnFhbEwz?=
 =?utf-8?B?Sy9mSHB0Qjk4OU8zWDIyVzJKa2ZpNkJrbnpiSk1zSWt4R1QwL0pqS1ZVOCta?=
 =?utf-8?B?QlB3Szk4MEVTcFQ0L1YvWm9zNW9Gay96NGI5T29ZemkxMXBTUXEzR2xUaThW?=
 =?utf-8?B?TURxNmdKelVZV1Q5MGcvZTRxOWJ2aDB1OWl6WVJhdW4xZVdFcWRhU2w0OGc5?=
 =?utf-8?B?R3U3WkNPYkNMd2NIckcrY1l0THl0MDlRRGRERTdFWjdpbjlLU3MwK0lIQUJO?=
 =?utf-8?B?bTNuSk1UQTQwRDRvSk9yclEzb2pTZTN1bDhRZjRwbEhJYTNmOVM0bkNmTFYw?=
 =?utf-8?B?dUdnalVkMFBhWUduTnF5Q1ZYWVFTeVZSdlQwK0l1ZlZMWSs0RzB1RGdvSHBB?=
 =?utf-8?B?ZGpVZTAzbnhCZDRGYzVCTEpOZnp1a0tiakd1QW55elI3bXlkSmxxMTgwUitP?=
 =?utf-8?B?UWxHbjBwK0xrZlNiQlE2dTROeEVBalhhY2xPeGRLeWJLbEtCdXovdXIzaEQr?=
 =?utf-8?B?Z1E4WWwzQ01TM3MyN1hMYXZVdUpmYUQyQ01hRUZEZUtmSzgyWlRza0dVZEJ2?=
 =?utf-8?B?VWJSOEdDQ2NqNGZLUlJvU0N4NlN1b2JEZE15WjdVWk5YTmNoSFA3SjczK1g0?=
 =?utf-8?B?OHJ1eWZFTnhBbW9kUTNpcWVWSEZxMmN2bUxjNGZDNytzS2JCUE82bDQyVGJX?=
 =?utf-8?B?ak1DVmRiRysyVUVLeGtlTVRUbmtMQzhLL0ZjVUdjVHd6OXc2K0pmcUVVYkEv?=
 =?utf-8?B?Rm94OC9IaFVoaDZKSDBQNk5ybDluUXh4OFJKakhGaUx0MmRER1NGVmZTZE1l?=
 =?utf-8?B?aFFXVjhGWjFObmpSdERHQVVnSHBCK0Mwc3krSVBVZDdlL09BWUF6TCtXOEl6?=
 =?utf-8?B?R0NVQ1BncjNFNFdQSjFpL042cFZKUHZrMHFWdzJDQTcvcnE5RVNTSU5xVjF5?=
 =?utf-8?B?TDRhb3hpMG5Vbm1FUjhsTC9jVXBkVjVvbG0xRVdZT2ZybGpIUU5teUorNndn?=
 =?utf-8?B?V0o4T21KVGsyUEpidW51dmFJMStWblh3QkNaTEVuWG4vdkpaeGN0Q3pvcVFl?=
 =?utf-8?B?bVc4MWp2WFFIWjNPYUR2cmNQY3BRZERNVUMrOThLcCtRN293cVdyaUNFYUFZ?=
 =?utf-8?Q?gIdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFkxSWMzbW9JRzFTTXp5d2JTNTUwYldmblZzbm5zQmZ1NWxsbFkzeUZYQW5Q?=
 =?utf-8?B?NzM2VlBPVCtMdGVVVXpDY2JrTUxROG83QzNHeDJjd1ZwV0VyUE9IbG1QYjBv?=
 =?utf-8?B?UDJLV2lHc1h6Rkpqd21JbWxMMVhGMFlKb29UcDJvb2J3ZjV3eUtpRzhiYXk4?=
 =?utf-8?B?cXNRMit5dUZsU1VZdzIzTTJmRVBVa3QwZ3Y4MC9ITnNua3p3djZoaTcxQ3Qy?=
 =?utf-8?B?eElzeHRJbzN5UUZNRUZreXlaUTV3WnQ4TlMxYjRNdDhBdm5DMGpiNkJSc3Fs?=
 =?utf-8?B?R2grVkk3Q2pnaGpIem1hQTVRWThZUWlvTW11U2NEY3hFcDFyTGdmN3ZmTjl1?=
 =?utf-8?B?cms1ZXVoRUY1WXRVS3N1NzM4RzdKa2R5RW5SM2hHcFNMQVZuaEVsNFo3TVVJ?=
 =?utf-8?B?NWt3WWVIbVk3Y3dyZnlIb1M5TktiSWMxZDFpZDFyOVNSbFFnWnJmdmpnQ1J4?=
 =?utf-8?B?elk0SWJWSlpWWktzMjhzSVBpOEhzS3NrSXdmOWxWc1RFUEF6N1UzN1JFbDJE?=
 =?utf-8?B?Nk90MzM1Z2JTWXkxYTF2TjFqSlp3aFpQVTJOR0RXVmFFY1FiSC9ySUpxbU1T?=
 =?utf-8?B?R0k3QVJlako1YjljeEhzWWJpdWp1SExXeG04RERKTWNTVUd0a1Q2Nno2a0w3?=
 =?utf-8?B?ZTdmVnZ2RWs0ZGlRRVBUQ0FCZ2tYbFVzekdpL3ZSL1R0SkdEVU1Qa0kyUEdU?=
 =?utf-8?B?KzVIaEpNNTVuT081cTJKVkE5L0xIdTFaS0FBdVpMcGRSbVBrR3I3Sm9sWDM1?=
 =?utf-8?B?RUFzMnVRTThFQnZQUWRBV2krSFNFRDZ3bkhuY3lYYnptYUtxTjc1SFNGRXVF?=
 =?utf-8?B?a0JlM21qeHZQd3A1eXRJWG5QcHRMNUtIcjljSWRNS0t2OFJXR1JtbWpVbEx4?=
 =?utf-8?B?UWZkbEpnbDhvdFlqY3dWQkhLNWRzUmFnMGJCajk0ZnFITTBFY0JUQiszZ29m?=
 =?utf-8?B?S3pKYmVHcGI2TU16aVlzMDhwbFB2ckcraklkMlNjdlJHRFNOVWxlWDRRckZB?=
 =?utf-8?B?QmJ6cDk4UXdvaEJ1d0Y0MmNwNVd0VEIyYUk1YmFJTHNjMEhtZExBT08reisw?=
 =?utf-8?B?Q1pBdWJSTmpLbjFQblF0R1dOTTdDbzNoZDNBcWNCVlBkNTMyTlF4UmgxMjds?=
 =?utf-8?B?RUcycWpWRndJWVBSeW9SQTUyQzMvVnBFS3o1MVNoTjJzdVIzT1I1MjM3ZUw0?=
 =?utf-8?B?cDdPSE9GRTZ0Z2Fkc2M2cHZ3Q080YnZhdFhHQ01GeDhWOFpGUzZWaDdwT2JQ?=
 =?utf-8?B?NitaK29PVkV2dkxFSmdPc1FkZlNPY3ZoWFoxbmJqTVRLdGVLcGZuN25hTlpJ?=
 =?utf-8?B?dUswOW14ekdqdTBZcUNhTFlha05XSXptcW96T0VpdUZIU0tHVjZyQXFUMjFF?=
 =?utf-8?B?UW04bmxoTUhjNDh2L2tjUmR1NUI1QkdnT2VwUndUdG5YVXZ1dUp6L1RKV2hs?=
 =?utf-8?B?Z3R2eDdxeDVMM3pYTUlhOXkrZS9GY0IySDZqbjA1bjNsakZVUzNVaFdvVms3?=
 =?utf-8?B?ckJQOTIwZEcxbmpTQk5pM3ZwMlRrV2tFbTVleTd5RXlsMldURDhWOFFMbzZ5?=
 =?utf-8?B?MkpzY05TRSs0Q25zeGdGcWcwaFJIRmRNNnU3eno0eDk2bEdVeTNHa0EvOXds?=
 =?utf-8?B?Qy9oZUdBeEpsZ1ExQ0o5eWsrYzRXTGsvTGJPUnhFLzJKckc4ejJPTkV6UDBv?=
 =?utf-8?B?VWtEdjJ0cklNS1NDOFNSSXFZaFNBMDNOVTdKT0xBTmdBV3VtM0VYMEpSb2tj?=
 =?utf-8?B?MVFFenhCMDBzV3dHQmhVcEdTTFpqLzFtaU94SytLVlpaaWtYL1ptTWFIMG9T?=
 =?utf-8?B?R0NmRmdTLzF4S05SVzh0a2wwUFY0OHlhcGR0WEVocW1NOFNLcEdCckVBQmUw?=
 =?utf-8?B?NndZdlJBRWl6Vi9KZ2d1Z3l3TGVrWHVJRXI0VVV1RmRaUTdUUVlOMDhGR1l6?=
 =?utf-8?B?alhRTWU5aHdpVXFkdWVxSytUK1lMWE12dzFYVlVXTUFvellHSm5FMk56ZVFt?=
 =?utf-8?B?dEhyR3c1dDJXWTJkL0xMZDU0V0J2VGY2RStVblR5RjJTcWkwcEFzcXpySmZC?=
 =?utf-8?B?YnhBZ0JraW1jbnhPa29EWFB4bi9jMVhjTHUvRVVyditDYWxxcUJ0dHd1S1Jp?=
 =?utf-8?B?NlVOMFYydWE0NkJlK1hUY0cwT0FxcVZWQU9jcGtMSVdPVS9ORGIrcmJTM2tj?=
 =?utf-8?B?VjVlN2UyYXhZZVc4TjNDK0lRZlVtQllsbFl4WGRVbDNOV25wbitpcTcwY011?=
 =?utf-8?B?LzB5ZFlNVGJ2L1cwVzI5T1N1cG4rMHZmWUlYajhQOHZwRGlzWkNCdlhQM2ht?=
 =?utf-8?B?N25NVTZQczV0ODFSZkJLUDdoNjJOVkVLY0FLMnlUcnFtZlBjd3RqVC9Wa0gr?=
 =?utf-8?Q?Obizxt56IuwZCEHg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f625ff9-f67b-4c43-20a1-08de6990f7ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:14:09.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJX3lGWh1Zq3XZL/PluCbeENMQ/ZPHdYTuOpvDO+WtZpIA9IswomKLW2qbEwf3xvbF9nb/BdYuj+4Bc0toAElXi8W3wihT/NMTJieekn+f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258323-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,lunn.ch,kernel.org,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6637D126816
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 11 Feb 2026 08:55:14 -0800

> On Wed, 11 Feb 2026 14:51:56 +0100 Alexander Lobakin wrote:
>>>> +free_coalesce:
>>>> +	kfree(coalesce);
>>>> +decfg:
>>>> +	if (ret)
>>>> +		ice_vsi_decfg(vsi);  
>>>
>>> Should this be ice_vsi_decfg_locked(vsi)?
>>>
>>> ice_vsi_rebuild_locked() is called with the netdev lock already held
>>> (either by the ice_vsi_rebuild() wrapper or by callers like
>>> ice_vsi_recfg_qs()). The error path at label 'decfg:' calls ice_vsi_decfg()
>>> which tries to acquire the lock again:
>>>
>>> ice_vsi_rebuild_locked() [netdev lock held]  
>>>   -> ice_vsi_decfg()
>>>      -> netdev_lock(dev)  /* deadlock - already held */  
>>>
>>> This would deadlock when an error occurs after ice_vsi_cfg_def_locked()
>>> succeeds but a later operation fails.  
>>
>> Tony also fed the series to AI, two times, and each time he got a
>> different answer.
>> The series was on iwl-next for 1.5 months and only one bug was reported,
>> which I fixed immediately.
>>
>> I can take a look into this, but wouldn't be better if we take the
>> series now and then have 2 months to fix bugs if any appears?
> 
> I understand the frustration, but unless the review is a false positive
> I don't see how we can ignore it.
> 
> Looking at the PR rate from Intel I suspect you may be better off
> pointing your frustration at the internal process? There seems to 
> be a net-next PR every 2 weeks in 2026. It's not like the 1.5 mo 
> was spent waiting on upstream?

I'm not frustrated at all :> I mentioned those 1.5 months only to say
that during that time, none of the users of our tree faced any bugs,
except one case which was fixed a long ago.

Anyway, this last PR was just a try to squeeze in at the end of the
window to compensate that it took a bit too long for the val to test
the series. It's not a problem at all if it won't.
Maybe I'll even add support for zcrx large buffers in meantime instead
of sending a followup later.

I can't say it's a false positive, but I can't confirm the AI is
absolutely correct here. At least a couple places mentioned that
"shouldn't work" in fact works. It's not just me being Sarah Connor when
it comes to AI, I just don't want people to trust it too much or authors
to waste time proving that AI is wrong.

Your call whether to drop it or take (this PR also contains several
patches not related to netmem, I think they shouldn't be dropped?).

Thanks,
Olek

