Return-Path: <netdev+bounces-153002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE529F68FD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CBB1897A96
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C61B424F;
	Wed, 18 Dec 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lnozdg7z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530991ACEA3
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533232; cv=fail; b=eYsTNBPJ6iTKj8xgI0LPdW8O6Q542ypb9moBvY3o1/3zbNrA8K74tAnH280VBmBuXqwjhsAGf/rFo7H5vhpw1Wg7AsofASsKuJG2JEXUVApMpOjIxOIoWKN5HqTabuT8GQG3sUNb0rV1L6K9Isz9XQHozkS0c+djezsOlslkEwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533232; c=relaxed/simple;
	bh=qFZcXNoCi4QsgPvdcoqfgS1p+LShGehOK2jV8oiAVlA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+me7ljDZqbNoPjwMfU16eDY5l9rmZZHT2mHZknfekqy7u0AXBjERXSJ9+++X6ll6eVj8ZItdpQGRBS+PK2DhR23rgC/fC2NGtseVrW9yEAQ8GgHAambpRjtp3HVl5A63hpjxaqQObBjFJhnTAmkn2uuj5WeBSUGV0iEDtun880=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lnozdg7z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734533230; x=1766069230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFZcXNoCi4QsgPvdcoqfgS1p+LShGehOK2jV8oiAVlA=;
  b=Lnozdg7zzCiefAwJdL/bnRkaoZ/I7+xK/q2vY12hPVtKS27l6w5+Mweu
   GO7DuUmrqVmXQAEDP8wkVMAOrUubUcqbF/EmTdu99lbY6/e+mV/Xy35zH
   P8VZn0Zm4Vho2XY0qiKdpJBShK/KlhDuhqxuJNixIzB+PYlFd4PHyf2rG
   n1RuM+n5N/RUdE4m/JNhi7H+6yoN+KAC1SeulfXv/VoXkUh3jPJOYeHXo
   nan5tS0HS760Zqt7/fr6+sV9lY05ylvYh6VWLb63FScM5kprajiMWD0c8
   PJKhyIFjglcsOcg+14OSHKBLHg1cTdVXCr6MZLoU4h1XhdsPJFQsk9iB6
   g==;
X-CSE-ConnectionGUID: abaeZxZuQ4KH9zcZ9nJrSg==
X-CSE-MsgGUID: npxYm9AjRcSNJiLHEQcriw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22598586"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22598586"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:47:04 -0800
X-CSE-ConnectionGUID: fVGOj2opSme+nCKOHl+xwQ==
X-CSE-MsgGUID: hQKa3/bpTgiPY5hycP3llQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102975919"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 06:47:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 06:47:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 06:47:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 06:47:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCv2Wyen6KkuGicNGJEzkQlfCSjrv4c/DIEOfshptsB480/hmlS9ZkcCWvBWSyYIcdSdQEvoW030ajs5joLssiTTd6VzKa5z0yn2XMgPibTkeQSnbs3g8CH/uaStGMMtgYYDivb08VAgqGC0IHSCKpEUWzPHsKjPvhc00tgIXMplsOnxU395Dn8GPt7a+lfMyEjo7CfwbunKE6i13hMhiEtxnB4LMjt3QpLMxYSacOpFKfHHCOwFJehSLjrlABfPONjOeWSyUsycse1ubJZS0ioEhzNY5n5aJaGEEeTVCYuIXCgOcZTdl/ewAxbZz7XT7wNSecDiletuM7YF2DlzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfO0Hbv8mapaP9ALeMXJ+ckGDpZ/bjUHis1XAml4LeQ=;
 b=XG3mgKYU6iUgj89mHH0U/4K2deu2uLhZ5Fpn7YnVXNex3c1AfMAwc8kXdpIyfRiwW7wQm6HsrbrPEx4uPF/OM1cCVdXfFVYoscojAHxDdrPfXPOnLxYIDdkGnoQmo1LdkpDEw8/NpsfqLOLtoQaI7fYqvbninYJ3gSmm+ezuQQOPBUUccK1CKmCN22zqx3+ops/f6j+LMJEfB28MIalC/2aNj4EJjgQGotSnsVakplm+2Hcs0FZRLAy075jgOe1tZxGrIjcX72mkJWKq/knFOigd4azx/eQTZWXs35z1VknWyfHKz8JiHrSDl6C06CQUFt5yqSM6BgAf/QVKm/uWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8096.namprd11.prod.outlook.com (2603:10b6:610:155::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 14:46:33 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 14:46:33 +0000
Message-ID: <173cb6c9-18d5-4e5d-bf52-5e23653f27d1@intel.com>
Date: Wed, 18 Dec 2024 15:46:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/16] net-next/yunsilicon: Enable CMDQ
To: Xin Tian <tianx@yunsilicon.com>
CC: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>,
	<wanry@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105026.2237645-3-tianx@yunsilicon.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218105026.2237645-3-tianx@yunsilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbd137d-79c5-424e-d233-08dd1f72c429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW5nckNKMDVaMGdCMHZ3U3R3R1pXYWtuY2dNV0xrbHZySHhlUmtKb2IyUkZz?=
 =?utf-8?B?MWEzVWtDTlI0ZzBSMEFTVGdIQ2pDMWd6dnphMlR0UXNQVG9SZVFyRk9PS1JK?=
 =?utf-8?B?UWY5UXl5Y2c3b0c5eFN0TTZJQ0NZR2VuQ3ErRS9wQitlL0srQ1hvNGNvNkYr?=
 =?utf-8?B?d3BZNy9xb1pyRXIzYXJBajZnN2dXUWhVTERzUTd5NzFxTVRpWVQ4bEtjaU51?=
 =?utf-8?B?SWhCS1hXLzJCTzNlN1NTbWpsV2E2bzJmb2FoWEhrM29PR2hWdkJUZW00R3hq?=
 =?utf-8?B?SjBETjFSdEYwLzBWd052OHo2eWU3bTFhc0tpcCtsYXZMbGQ5ZHVsYW83MUhI?=
 =?utf-8?B?OXhzQU9SbCsrQnV3dnI3UmxYc1MrZlpPKzVaT0V4ZjRqMnAzSTh0aVdnS2V4?=
 =?utf-8?B?OEt0bFJrL2graGx6VkluWnFHL2RtYjdJS0tWQVhORHAwRmt4dGVxTnpuRjNn?=
 =?utf-8?B?WkdEV2I4QnhkMHFERk5TMi9HRW54TzhUN0wwR0E5YTh2VEE5eGE4d1dYZ05l?=
 =?utf-8?B?RTEwL1dtWVN0ZzlzWWxRdjdwVzhZSVp6NUV1RDB6L3N4OUo1QkxGUmZMb1Z5?=
 =?utf-8?B?UWl5bXEzYW5JU3FyUm1NRCtlMDZlQi9nQkp6VmdOUW1ITnNlaEMxUkdoeU9n?=
 =?utf-8?B?Tk43UFdMQVZGbHg3WXIxUUk0ek5kV2Q3VW1Fc1AvVk1uT0pGSThwZlJCZXNT?=
 =?utf-8?B?aVJadnN0RG9UZm8wb0FON0xOSmxaOTh3MnppTE8zbERCK2RybmE2TDFsK2NJ?=
 =?utf-8?B?SXdpTlVvbXk1UDlCemZNLzRPcjYwbEtRcWtmL0ZpNFNDSW1mY25LRStSOS91?=
 =?utf-8?B?VHVNYmMzL2hCOWNVNTU0YTdBNzV0eEE1YW1ZeW9EdHFCbW5nL0dqVFBRYitx?=
 =?utf-8?B?c205bW9XMWNlQnREVlhFRGxQRjlvRTZsMmkwaEVhVEVOOGVoWjZIMnhOTmUz?=
 =?utf-8?B?Nkt1TThod29KNHlqQ0o5czBZc1RNYUFMOXpWajdFOWh4SjhLVC9pTG9jTXJS?=
 =?utf-8?B?aEpvTWFoNm41dXNOWHRZc3h1a05yenA5dHBZYkZkTVZidVYza09SYm13T1VQ?=
 =?utf-8?B?MFVNL1RmVHBtQXdhdThhNURNdmlHQmZNb2dIL2t0eUdFSTByeWpGY1NNUGdz?=
 =?utf-8?B?bFlCekZKSjRXdHhQNWdpd0tUT3R5cUVBajlFU2E0dXBhYnhCODBQSXNxQ3Bv?=
 =?utf-8?B?bEZzWTQweVVQVUcyZjdIQmxVaHdGUFVxdWZWODJmMVJLWWVjbjQ1U3FpUmw2?=
 =?utf-8?B?c1MySDdBYlpPNHQxMXR3ZGhEa2h4eVpidXg3Q2dwOHhFOUttNXRraTlHcHBw?=
 =?utf-8?B?Nkt1bEEvZ3JsaHd3OGxaTUluZEFNK0ZQSlRRcWUvaytRZm1NaFZialBqeEx2?=
 =?utf-8?B?NFhITjcrTFpXWjB5aHpuVXJhNGt5OHNoaGZLZWxhQk9XYTdyS0NnNXpaY3lK?=
 =?utf-8?B?TjNrc1JmU3IxTllxb3RGNW1oSFh6OG5KWGZkc3Fya0NPdmwvd3NDQVgxdFBO?=
 =?utf-8?B?THdhNytNNmpsc3h2WllGN1RMWDI4empCbFRoTFk2cDZEZVZwQ0YyQ0hoOWFS?=
 =?utf-8?B?US9rUHF3Z0w2TEYveFNGSWszVUlVMFRmQVd0K1BjQno3M01jR2N0SWk1REo4?=
 =?utf-8?B?WG12VnpsL2NPYmFvVEY3RzJBNFJvN3BDQ3JlQ0VJUldUN0pqT3p5UkhleW5u?=
 =?utf-8?B?OVNadVhMbnE3cjVsNVhkTnZNZC9zMXR6NXpmcTh3M3F3T2ZYNnU4TUxYQWJP?=
 =?utf-8?B?NERtQkQ3WTlZdUlucERKMzRRb2pXdmNoSGdSWDE2SUlsM1g2OFZ4SVR2R1Zh?=
 =?utf-8?B?VjNSNnowejBhbDVINVcrOS9OQUdzcGx0S3Q2SjdGYXF4a1E4TnlSR2FmWm9O?=
 =?utf-8?Q?4L4+69ltDuoCz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5hd3E1d3lxSE9Na0Y3Z2llMmtQcmtSMEs1MHBBMEg5RlFVQ1NDTXJiYmR6?=
 =?utf-8?B?ck9VMzdpaDgyVGRsRU5EL0pPcjNTTk9na2JmTkx5c2lmdHJGZCs5Sk9xSXNv?=
 =?utf-8?B?T0NhOFVYdDZYNU5KbmsrRVNqM0NLVmVtVDlvd0RodVN3d014OS90ZWZ2amFo?=
 =?utf-8?B?QUlWUUpldU9HdmNJaG13dTlkR2dOWnRuZmlqS203eXB2UG9SVHJsc2hUQVdu?=
 =?utf-8?B?VTAyRlNOOGhMTmZjQ0dsSDJyZEt2RnpqSlpTRzlnTjFwSWJFNS9SV21PU0My?=
 =?utf-8?B?amoyU2lXbFlJSElZVlVWNVJMbTczMVFlNmQ0Qk82bVU2RFE1SnVTMnRpSk9O?=
 =?utf-8?B?V0E5UkNqdXJnV3VuQkxlZm1WSjc2SzdidjVha2FYM2FaWUpMVk9EbGhybS9i?=
 =?utf-8?B?bXNGNlFER3RUQVNpTEUveFFoeTBiNHh4L3pDMTl1ZjA1WjdRQzNUVks5YWlZ?=
 =?utf-8?B?b3dRRndZRDNiZTI0ckFaOEJBUTJmTzhROTNTZ0QvME1NT0pGNlFTbzJ6M3di?=
 =?utf-8?B?aGJZTUo3eklzVnFiQmhPZGxnbFY3ZTNrRVByc3N6OGRtY1hsSzdnNG9KVkZY?=
 =?utf-8?B?RVB1d0dMeEpRRG1ieTJFQi8wd002aWF4VUpqOVo1YkdlMThvWVNWS051MGMy?=
 =?utf-8?B?VEo4N0FjZXhaRkZ3bUxyRVU2ek9MVXcvNEszWkwyV0VJU252Qm16aUNwaG55?=
 =?utf-8?B?SStZU0hmWUp6TWVlVjhabzdQdHdWSDlZUUJGVmpnRkN4N0xsOStnYW1QWEt6?=
 =?utf-8?B?a1BETmN6MkYzOS8xb0NHeTZwdElnTkZiaExPM1ZiclNMektIRkptUHVFR0R2?=
 =?utf-8?B?SFlSRkIrUmFJTlZMdkI1a2czb0diVlQ1eWNsNlZjbWIrMy82bXU2MWtZNHJX?=
 =?utf-8?B?VFFKMmM5UW15a0hoSjNrejBMUS9VL2RIaTJRMkx3MldQc3VYVTN2UFd5WWZO?=
 =?utf-8?B?eTFGOWRvTW5PNlgxRDY3aWVqeWFEVmp1bWtxMXkxUE13NGJFN0gvcTU1dnIx?=
 =?utf-8?B?M0ZhdVJnZ2tGV3hrRzFhUmZFelROZUJxNk9oS2MwRFdtdG56YXVFY1EwM1p4?=
 =?utf-8?B?Uis2Q0oxQnc3a0tJWTEvZkNDU2NsSk16WDJ2TXRjV0FNVHF6ejFzR1RIWXFE?=
 =?utf-8?B?Mmo4UkhwU3RmTTNkZHlDOFBlNVRYQUFLdkJTSlpwSE9YZDcxaTZSeUdiTElq?=
 =?utf-8?B?K2FMN0h0WGFmOTIwNWx3QzJwZ05mYlhVeCtiT2dDT2hVK2ZLYjU5ZWxMdEVk?=
 =?utf-8?B?Mi9LRjdhaG1BMjV2U2VzZlhOMFAxZ0pTcmdjTXhPOVdKRWdZVDdqRUdLaVht?=
 =?utf-8?B?akxYRm1IRm9OV0I3Q2I0aGdYeGNrUGQycmdhWDQ2UThUeEFmRnFqZ3JwQ2xN?=
 =?utf-8?B?YXJVaWFXYjdPY1RtMTAyTnRMNXYyWGJQQmhWcVRlUzNlUzNqVmhqQnR5M2pO?=
 =?utf-8?B?ZXFUaXJnVUhRdVZYcjNRZHNjanpiSVZzN2hqYlgyRnkwY1FUY0Z6QU9JYXFP?=
 =?utf-8?B?UmJEbDZQV3JHdmllUmE0TjVTclRTZE5aQU1OR3FhL2g2azRMNXBsc2QvYTBy?=
 =?utf-8?B?WVN2Q1ZCeGE4U1g3d0YvYzJyTGR0NS9ZSGdnMUZmZ0RHTHhlQ0Q2ZTY1dC8r?=
 =?utf-8?B?NmRleitXZ2ZyWVM3RlFUUWpaSXRQV2VCMzd6ZGVJNWJ3bEJVWG1VN3pKaWhM?=
 =?utf-8?B?T3BqNkxXSFZxV1Z4dDIxMEZaZDg5MDJXMVFGSGJySndFVUUyVk1XNUJFekkw?=
 =?utf-8?B?MndEN2RieGpTNStJY0xnZE5rbUV3d0hzUTUrVmRqVW9pTmRDQVhsLzlxRjVl?=
 =?utf-8?B?Q1h1MzRQQkQvdnNWRzkwNmVJYm8vVjVidTR4bGJoZFVOcUdFNXZvNTNLYmp2?=
 =?utf-8?B?OWtHaGZIcEw1c3Jxa1Y3L2V5Ynp3Kzkzdnd5UmVhaWFkd3grQnA1YjNzRWpp?=
 =?utf-8?B?ckRjMjhoMjNPelAwVzQyMzNMalYyQWdQZSt3N2ZCSGYyaDVPN1l1TEphSU15?=
 =?utf-8?B?NE1rVHp5aUNpRUJIbjNiOElmekVxVGdJNDI3VE1XRWQ5UmVGSHp1TVB3aGND?=
 =?utf-8?B?VHoxWlkxSXJmc2NraURNSkhOb1QxOVBTZ0llZWZ5bnlHQlN5bUJKcWRTUCtk?=
 =?utf-8?B?SWZDQmVoZWd2ZlNhUjA1S1lwZkVxVVVPYlptUERzbDgrMkZ2R3d2Q09PdHZx?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbd137d-79c5-424e-d233-08dd1f72c429
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:46:33.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNKn/sHDFMCwtcMJVSfw6nCmZFTKEvFRSmCutlj9OfJoRaSR/+5k11Iw5cEF1uw2yTvDwjIUXZyBLFQvErgDlcEgZQfZ3MxR6/VQ8wUip+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8096
X-OriginatorOrg: intel.com

On 12/18/24 11:50, Xin Tian wrote:
> Enable cmd queue to support driver-firmware communication.
> Hardware control will be performed through cmdq mostly.
> 
>   
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>


> +
> +#ifndef XSC_CMD_H
> +#define XSC_CMD_H
> +
> +#define CMDQ_VERSION 0x32
> +
> +#define MAX_MBOX_OUT_LEN	2048
> +
> +#define QOS_PRIO_MAX		7
> +#define	QOS_DSCP_MAX		63

weird formatting

> +#define MAC_PORT_DSCP_SHIFT	6
> +#define	QOS_PCP_MAX		7
> +#define DSCP_PCP_UNSET		255
> +#define MAC_PORT_PCP_SHIFT	3
> +#define XSC_MAX_MAC_NUM		8
> +#define XSC_BOARD_SN_LEN	32
> +#define MAX_PKT_LEN		9800

you don't want to collide with future defines in core kernel

> +#define XSC_RTT_CFG_QPN_MAX 32
> +
> +#define XSC_PCIE_LAT_CFG_INTERVAL_MAX	8
> +#define XSC_PCIE_LAT_CFG_HISTOGRAM_MAX	9
> +#define XSC_PCIE_LAT_EN_DISABLE		0
> +#define XSC_PCIE_LAT_EN_ENABLE		1
> +#define XSC_PCIE_LAT_PERIOD_MIN		1
> +#define XSC_PCIE_LAT_PERIOD_MAX		20
> +#define DPU_PORT_WGHT_CFG_MAX		1
> +
> +enum {
> +	XSC_CMD_STAT_OK			= 0x0,
> +	XSC_CMD_STAT_INT_ERR			= 0x1,
> +	XSC_CMD_STAT_BAD_OP_ERR		= 0x2,
> +	XSC_CMD_STAT_BAD_PARAM_ERR		= 0x3,
> +	XSC_CMD_STAT_BAD_SYS_STATE_ERR		= 0x4,
> +	XSC_CMD_STAT_BAD_RES_ERR		= 0x5,
> +	XSC_CMD_STAT_RES_BUSY			= 0x6,
> +	XSC_CMD_STAT_LIM_ERR			= 0x8,
> +	XSC_CMD_STAT_BAD_RES_STATE_ERR		= 0x9,
> +	XSC_CMD_STAT_IX_ERR			= 0xa,
> +	XSC_CMD_STAT_NO_RES_ERR		= 0xf,
> +	XSC_CMD_STAT_BAD_INP_LEN_ERR		= 0x50,
> +	XSC_CMD_STAT_BAD_OUTP_LEN_ERR		= 0x51,
> +	XSC_CMD_STAT_BAD_QP_STATE_ERR		= 0x10,

I would keep the list numerically sorted

> +	XSC_CMD_STAT_BAD_PKT_ERR		= 0x30,
> +	XSC_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR	= 0x40,
> +};
> +
> +enum {
> +	DPU_PORT_WGHT_TARGET_HOST,
> +	DPU_PORT_WGHT_TARGET_SOC,
> +	DPU_PORT_WGHT_TARGET_NUM,
> +};
> +
> +enum {
> +	DPU_PRIO_WGHT_TARGET_HOST2SOC,
> +	DPU_PRIO_WGHT_TARGET_SOC2HOST,
> +	DPU_PRIO_WGHT_TARGET_HOSTSOC2LAG,
> +	DPU_PRIO_WGHT_TARGET_NUM,
> +};
> +
> +#define XSC_AP_FEAT_UDP_SPORT_MIN	1024
> +#define XSC_AP_FEAT_UDP_SPORT_MAX	65535

there is really nothing to reuse from code networking?

> +
> +enum {
> +	XSC_CMD_OP_QUERY_HCA_CAP		= 0x100,
> +	XSC_CMD_OP_QUERY_ADAPTER		= 0x101,
> +	XSC_CMD_OP_INIT_HCA			= 0x102,
> +	XSC_CMD_OP_TEARDOWN_HCA			= 0x103,
> +	XSC_CMD_OP_ENABLE_HCA			= 0x104,
> +	XSC_CMD_OP_DISABLE_HCA			= 0x105,
> +	XSC_CMD_OP_MODIFY_HCA			= 0x106,
> +	XSC_CMD_OP_QUERY_PAGES			= 0x107,
> +	XSC_CMD_OP_MANAGE_PAGES			= 0x108,
> +	XSC_CMD_OP_SET_HCA_CAP			= 0x109,
> +	XSC_CMD_OP_QUERY_CMDQ_VERSION		= 0x10a,
> +	XSC_CMD_OP_QUERY_MSIX_TBL_INFO		= 0x10b,
> +	XSC_CMD_OP_FUNCTION_RESET		= 0x10c,
> +	XSC_CMD_OP_DUMMY			= 0x10d,

I didn't checked, but please limit the scope of added defines
to cover only what this series uses (IOW: no dead code)

[...]

> +
> +enum xsc_eth_qp_num_sel {
> +	XSC_ETH_QP_NUM_8K_SEL = 0,
> +	XSC_ETH_QP_NUM_8K_8TC_SEL,
> +	XSC_ETH_QP_NUM_SEL_MAX,

no comma after items that you don't expect addition after

> +};
> +
> +enum xsc_eth_vf_num_sel {
> +	XSC_ETH_VF_NUM_SEL_8 = 0,
> +	XSC_ETH_VF_NUM_SEL_16,
> +	XSC_ETH_VF_NUM_SEL_32,
> +	XSC_ETH_VF_NUM_SEL_64,
> +	XSC_ETH_VF_NUM_SEL_128,
> +	XSC_ETH_VF_NUM_SEL_256,
> +	XSC_ETH_VF_NUM_SEL_512,
> +	XSC_ETH_VF_NUM_SEL_1024,
> +	XSC_ETH_VF_NUM_SEL_MAX
> +};
> +
> +enum {
> +	LINKSPEED_MODE_UNKNOWN = -1,
> +	LINKSPEED_MODE_10G = 10000,
> +	LINKSPEED_MODE_25G = 25000,
> +	LINKSPEED_MODE_40G = 40000,
> +	LINKSPEED_MODE_50G = 50000,
> +	LINKSPEED_MODE_100G = 100000,
> +	LINKSPEED_MODE_200G = 200000,
> +	LINKSPEED_MODE_400G = 400000,

reminder about prefixing your enums by XSC_
would be also good to add your max supported speed into cover letter
(to get some more atteniton :))

> +};
> +
> +enum {
> +	MODULE_SPEED_UNKNOWN,
> +	MODULE_SPEED_10G,
> +	MODULE_SPEED_25G,
> +	MODULE_SPEED_40G_R4,
> +	MODULE_SPEED_50G_R,
> +	MODULE_SPEED_50G_R2,
> +	MODULE_SPEED_100G_R2,
> +	MODULE_SPEED_100G_R4,
> +	MODULE_SPEED_200G_R4,
> +	MODULE_SPEED_200G_R8,
> +	MODULE_SPEED_400G_R8,
> +};
> +
> +enum xsc_dma_direct {
> +	DMA_DIR_TO_MAC,
> +	DMA_DIR_READ,
> +	DMA_DIR_WRITE,
> +	DMA_DIR_LOOPBACK,
> +	DMA_DIR_MAX,
> +};
> +
> +/* hw feature bitmap, 32bit */
> +enum xsc_hw_feature_flag {
> +	XSC_HW_RDMA_SUPPORT = 0x1,

= BIT(0)

> +	XSC_HW_PFC_PRIO_STATISTIC_SUPPORT = 0x2,

= BIT(1), etc

> +	XSC_HW_THIRD_FEATURE = 0x4,
> +	XSC_HW_PFC_STALL_STATS_SUPPORT = 0x8,
> +	XSC_HW_RDMA_CM_SUPPORT = 0x20,
> +
> +	XSC_HW_LAST_FEATURE = 0x80000000,
> +};
> +
> +enum xsc_lldp_dcbx_sub_cmd {
> +	XSC_OS_HANDLE_LLDP_STATUS = 0x1,
> +	XSC_DCBX_STATUS
> +};
> +
> +struct xsc_inbox_hdr {
> +	__be16		opcode;
> +	u8		rsvd[4];
> +	__be16		ver;

this is command version? (vs API as a whole, or HW ver, etc)

> +};
> +
> +struct xsc_outbox_hdr {
> +	u8		status;
> +	u8		rsvd[5];
> +	__be16		ver;
> +};
> +
> +struct xsc_alloc_ia_lock_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			lock_num;
> +	u8			rsvd[7];
> +};
> +
> +#define XSC_RES_NUM_IAE_GRP 16
> +
> +struct xsc_alloc_ia_lock_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			lock_idx[XSC_RES_NUM_IAE_GRP];
> +};
> +
> +struct xsc_release_ia_lock_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u8			lock_idx[XSC_RES_NUM_IAE_GRP];
> +};
> +
> +struct xsc_release_ia_lock_mbox_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +struct xsc_pci_driver_init_params_in {
> +	struct xsc_inbox_hdr	hdr;
> +	__be32			s_wqe_mode;
> +	__be32			r_wqe_mode;
> +	__be32			local_timeout_retrans;
> +	u8				mac_lossless_prio[XSC_MAX_MAC_NUM];

please look up your formatting (through the series)

> +	__be32			group_mod;
> +};
> +
> +struct xsc_pci_driver_init_params_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			rsvd[8];
> +};
> +
> +/*CQ mbox*/
> +struct xsc_cq_context {
> +	__be16		eqn;
> +	__be16		pa_num;
> +	__be16		glb_func_id;
> +	u8		log_cq_sz;
> +	u8		cq_type;
> +};
> +
> +struct xsc_create_cq_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	struct xsc_cq_context	ctx;
> +	__be64			pas[];

would be great to explain your shortcuts: eqn, pas, and all other non
obvious ones

[...]

> +/*PD mbox*/
> +struct xsc_alloc_pd_request {
> +	u8	rsvd[8];
> +};

really? what this struct is for?

> +
> +struct xsc_alloc_pd_mbox_in {
> +	struct xsc_inbox_hdr	hdr;
> +	struct xsc_alloc_pd_request	req;

this is the only use of the above

[...]

> +/* vport mbox */
> +struct xsc_nic_vport_context {
> +	__be32		min_wqe_inline_mode:3;
> +	__be32		disable_mc_local_lb:1;
> +	__be32		disable_uc_local_lb:1;
> +	__be32		roce_en:1;
> +
> +	__be32		arm_change_event:1;
> +	__be32		event_on_mtu:1;
> +	__be32		event_on_promisc_change:1;
> +	__be32		event_on_vlan_change:1;
> +	__be32		event_on_mc_address_change:1;
> +	__be32		event_on_uc_address_change:1;
> +	__be32		affiliation_criteria:4;

I guess you will have hard time reading those bitfields out

look at FIELD_GET() and similar

> +	__be32		affiliated_vhca_id;
> +
> +	__be16		mtu;
> +
> +	__be64		system_image_guid;
> +	__be64		port_guid;
> +	__be64		node_guid;
> +
> +	__be32		qkey_violation_counter;
> +
> +	__be16		spoofchk:1;
> +	__be16		trust:1;
> +	__be16		promisc:1;
> +	__be16		allmcast:1;
> +	__be16		vlan_allowed:1;
> +	__be16		allowed_list_type:3;
> +	__be16		allowed_list_size:10;
> +
> +	__be16		vlan_proto;
> +	__be16		vlan;
> +	u8		qos;
> +	u8		permanent_address[6];
> +	u8		current_address[6];
> +	u8		current_uc_mac_address[0][2];
> +};
> +
> +enum {
> +	XSC_HCA_VPORT_SEL_PORT_GUID	= 1 << 0,
> +	XSC_HCA_VPORT_SEL_NODE_GUID	= 1 << 1,
> +	XSC_HCA_VPORT_SEL_STATE_POLICY	= 1 << 2,

BIT(0), BIT(1), BIT(2)

[...]

> +
> +struct xsc_array128 {
> +	u8			array128[16];
> +};

both struct name and member name are wrong, this is an
u128 type basically

> +
> +struct xsc_query_hca_vport_gid_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u16			gids_num;
> +	struct xsc_array128	gid[];

__counted_by(gids_num)

> +};
> +
> +struct xsc_query_hca_vport_gid_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u32			other_vport:1;

most other things you have in Big Endian, and now CPU endiannes,
it's intentional?

> +	u32			port_num:4;
> +	u32			vport_number:16;
> +	u32			rsvd0:11;
> +	u16			gid_index;
> +};
> +
> +struct xsc_pkey {
> +	u16			pkey;
> +};
> +
> +struct xsc_query_hca_vport_pkey_out {
> +	struct xsc_outbox_hdr	hdr;
> +	struct xsc_pkey		pkey[];
> +};
> +
> +struct xsc_query_hca_vport_pkey_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u32			other_vport:1;
> +	u32			port_num:4;
> +	u32			vport_number:16;
> +	u32			rsvd0:11;
> +	u16			pkey_index;
> +};
> +
> +struct xsc_query_vport_state_out {
> +	struct xsc_outbox_hdr	hdr;
> +	u8			admin_state:4;
> +	u8			state:4;
> +};
> +
> +struct xsc_query_vport_state_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u32			other_vport:1;
> +	u32			vport_number:16;
> +	u32			rsvd0:15;
> +};
> +
> +struct xsc_modify_vport_state_out {
> +	struct xsc_outbox_hdr	hdr;
> +};
> +
> +struct xsc_modify_vport_state_in {
> +	struct xsc_inbox_hdr	hdr;
> +	u32			other_vport:1;
> +	u32			vport_number:16;
> +	u32			rsvd0:15;
> +	u8			admin_state:4;
> +	u8			rsvd1:4;
> +};
> +
> +struct xsc_traffic_counter {
> +	u64         packets;
> +	u64         bytes;
> +};
> +
> +struct xsc_query_vport_counter_out {
> +	struct xsc_outbox_hdr	hdr;
> +	struct xsc_traffic_counter received_errors;
> +	struct xsc_traffic_counter transmit_errors;
> +	struct xsc_traffic_counter received_ib_unicast;
> +	struct xsc_traffic_counter transmitted_ib_unicast;
> +	struct xsc_traffic_counter received_ib_multicast;
> +	struct xsc_traffic_counter transmitted_ib_multicast;
> +	struct xsc_traffic_counter received_eth_broadcast;
> +	struct xsc_traffic_counter transmitted_eth_broadcast;
> +	struct xsc_traffic_counter received_eth_unicast;
> +	struct xsc_traffic_counter transmitted_eth_unicast;
> +	struct xsc_traffic_counter received_eth_multicast;
> +	struct xsc_traffic_counter transmitted_eth_multicast;
> +};
> +

not related to "getting counters from the vport", but please make
sure to be familiar with struct rtnl_link_stats64 for actual reporting
needs


> +#define ETH_ALEN	6

please remove

[...]

> +
> +struct xsc_event_linkstatus_resp {
> +	u8 linkstatus; /*0:down, 1:up*/
> +};
> +
> +struct xsc_event_linkinfo {
> +	u8 linkstatus; /*0:down, 1:up*/
> +	u8 port;
> +	u8 duplex;
> +	u8 autoneg;
> +	u32 linkspeed;
> +	u64 supported;
> +	u64 advertising;
> +	u64 supported_fec;	/* reserved, not support currently */
> +	u64 advertised_fec;	/* reserved, not support currently */
> +	u64 supported_speed[2];
> +	u64 advertising_speed[2];
> +};

heads up: please make our link speed, pause, fec code commits
clearly marked, so reviewers interested in that topic would recognize

and in general: please elaborate a bit in the commit message what it
does in terms of standard networking/kernel (not limiting to your
3-4 letter acronyms used for name of channel between your driver and HW)

this patch is so long that I will end here

[...]

> +
> +struct hwc_set_t {

add prefix xsc_ in the name
don't name structs _t, as that would be confused for typedefed one

[...]

> +
> +	u8         dword_0[0x20];
> +	u8         dword_1[0x20];
> +	u8         dword_2[0x20];
> +	u8         dword_3[0x20];
> +	u8         dword_4[0x20];
> +	u8         dword_5[0x20];
> +	u8         dword_6[0x20];
> +	u8         dword_7[0x20];
> +	u8         dword_8[0x20];
> +	u8         dword_9[0x20];
> +	u8         dword_10[0x20];
> +	u8         dword_11[0x20];

sizeof(dword) is neither sizeof(u8) nor 0x20
(bad name)



> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
> @@ -0,0 +1,218 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef XSC_CMDQ_H
> +#define XSC_CMDQ_H
> +
> +#include "common/xsc_cmd.h"
> +
> +enum {
> +	/* one minute for the sake of bringup. Generally, commands must always

outdated comment

> +	 * complete and we may need to increase this timeout value
> +	 */
> +	XSC_CMD_TIMEOUT_MSEC	= 10 * 1000,
> +	XSC_CMD_WQ_MAX_NAME	= 32,

take a look at the abundant kernel provided work queues, not need to
spawn your own most of the time



