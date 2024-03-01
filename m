Return-Path: <netdev+bounces-76387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903086D91C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4619B2387B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73EFC03;
	Fri,  1 Mar 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY9Rnnha"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B91FAB
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257583; cv=fail; b=mUydzDKhdBE8hGGx6qE6E7TAPt63kgEQPjH53UvrmRWDnGybMxAGQ3opCTaR+TohCdC6MVtHZKSgF2c+KHFg61htRIPbRhmsSlm6gZOnl1teCbx+8t06A1sVg6Yl3ISc4SVq3P0U6RuJHgl5n2fckh9sftiyHY+uZ4gsRRkFnsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257583; c=relaxed/simple;
	bh=O/S5YhQu/jAaQ14M1qfdvToBKWfYpSmBGFDEL2rNTo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPZ/h5AX4E3vuqvSFspKgy6VE5yi0k4OlCXwdtxo/5rk4dbt5u2RCYSFUzfbbxuAjbHQ0OG1eyDwhXHTOrve6k5Vnke9lWpJjUv+Yml0H40hRhhdZyz0cXnKUIPv2RUHNgOAlonmvH1SHcE1do121j1tivcbZw1WfqzH0z6zLVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY9Rnnha; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709257582; x=1740793582;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O/S5YhQu/jAaQ14M1qfdvToBKWfYpSmBGFDEL2rNTo4=;
  b=MY9RnnhaxgUuvFaHkdsCl+xXvI11vbWGV38B2d+nQNXX6AN87+Xa3g9o
   bN/n0dboi3aSYzzpxqPuqVF9vbn8PD+jPrZ0nF7ZN2lHfoyunsE2NzTm7
   7IU/NFqxNWycdzRFcmxHtrSejArXqk8I4WBmpifhPdqdD68So9KPTuMRT
   vrgmQnjdBEn4DfcObCJSA2ROUQp1bi8K1ZxJVdWwJCeAqjwK+TlX0dM2Q
   AbjIVKrEm/K3stgWc14Zejs13mjLv+9s30LSGxfEuYx354OoEjKxPg6mV
   ffKnCCsdOCqa9SJrUF2NNPQsdjplAqkGaOCYKLl472F+N0JLorIIUj8WO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26236056"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="26236056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 17:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="39048643"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 17:46:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 17:46:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 17:46:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 17:46:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 17:46:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8EeJ/WlKRFKbi7lBfpC3Hw17NEcmxiJ7vWM5064eSL/vYz0V3dN7iH53EyMrDBGMgb5zx9leFpX7Auk4iKUUY8HhKSk42xfpoDuFIDwZuadoDiY6GLQcORnM3c1bVAkRBaMmIY9Z6VFbX1E4jU30mkS9UNHeSwnep3IYdPgd5lODEh7DiA7Zmr+C3wVLVs3aR5BZLexOY+vMORQih6nhuWWtTmzRUfcnqPhA75N1DgwPfU5j9dKCbt3g+TLQosqBQm9oBAgzQgu+4b+PAstZj1AkOaMQji/YF9+pqEQX9TAzAie86yKLJx+iwhpQZUkoXd5gENtjtl8cI4aJn/IPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyOMR4rh9E52L0/JxXMxHWYhy4Lx7qUbtQia3dfLP6U=;
 b=JyAnFj0Z12b4ZkVdrF1JQ+GU4TJEjFmRSJc8y4ebQOO3EZfBvUKBOh1B+Vrk8u0IKPVqbnuVqYA1V7FF2jglvUWejiJeKUmePFACytSjawlXq97qDLkV+TYjEUq0FJaMuuO7JErGA4djGyCUzilDqOWHzndlIhXItDAks6bZG7FwXEeQ331NB6uxC6iP60x9lPinJtf3viMsjs0Xb0pacfAFiadBfVWB332ftcnEmC9QSft+9d+YOHK9xX5cIwbhlmjDUiO20n1SrXn6CaBdoWguCVYDf0ts9bW43w4x2qBuJWTQCOq2B0JB+8/NWmW6RpS5u3G7gkyCmc0PsXiISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 01:46:13 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333%5]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 01:46:13 +0000
Message-ID: <91629dbc-8fce-4f58-bd9b-b37293c220b8@intel.com>
Date: Thu, 29 Feb 2024 19:46:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
To: William Tu <witu@nvidia.com>, <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>
References: <20240301011119.3267-1-witu@nvidia.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240301011119.3267-1-witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|PH0PR11MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: de953b64-670a-4062-c9fb-08dc39916095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmDCLyMHZTSq/hCq8OtxjVKcJp2DMczFa0jpAchdJKyumln2l51N8blNLSAtpjl+W1MaDDBmTBHpuLTR6KYi0ObUxcQODOgL/mNXbZvKwCFk54/OzSimYL8Fwhhns6u8mR6pZD5r7ZaiacFU/K3vqtMHRZgRQ5e6sn6T6j0rbdLA1tKqXA+fF19CG8r4fgUj9VIesthTwi9FyS31Px9lhhT5ym4kmO87f5s61RN6Px+nQ66Iui+8QgGeKCCEqJBCuFrKsh8C396qVAj5DyZCRCsM3gHw1lB+8hhTFKjtXnCGCreTEinWyZLd/dU6Hcx9+sEd2DjeNttQOWRqD9XlsIAgJpXDRRy3+btgdMplTG/n+jVsBfe/ki3LYqQ5bzonBsAci49JfQGqbfsjt7LNnqXdTYu1deHUyxEz3udma5nfowfkHRwU6iTxCBAzQpvk7q5fJR4m9kMzY1eyvpCQnGzGN4mdFo1yO2YRaPj1B/+GXf3e63pedpBSTQ0J4ap1wqsEgXKh2AWwRpgY2xSnSQ/QGr+eX9IDrfXI+c5TXaUM4V/c3z4I2D6JIO62jptk15qov4oAzqz9A5eI+NcgXVGey0QiKl2hpGcTRdnHoNud3dX9ELSGw2E2in4T02l2JD1OxGOVKnppktiTAn61ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZQU1lUMkFJaWJlbUtSTFRObWRreExRcG9kb011VmJ5QzdzcVF1cnhGbnQ1?=
 =?utf-8?B?RlR6a2ZiQVdkNjZDKzlaOHZNTnJkOGh6aUVIVFlkaGhvTlJkNi9VK2xsVVBu?=
 =?utf-8?B?Mm1MM0RicDQvbVB4WGllYWtNYXE5UkVKUUN2STlEeXVUTktRck15NFVtWFdR?=
 =?utf-8?B?RDdYV0pIM3p1Zy9QY3RwRGowRVE3OUtVc3FWTEdiYVBDR0RuV0pMemdZU0py?=
 =?utf-8?B?VzJwbnRLZWNRcDJ4Lzl6MnpyVGtlME9YRW9NbEtZMDFQTzRsaHBoMXllMjNK?=
 =?utf-8?B?YXdaeHFmdHVhUno4ZlBpWk1RcTF0ZmRDN01JZnUxK09uNkQvYVBZTExiYVVV?=
 =?utf-8?B?eDN4YzdreklTaEQ2SUJneW5UMG51SG5kMTNzcjVKSEd3ak9wbjN1OFdmQ2VD?=
 =?utf-8?B?QnUwZkxDaW5iczFTUllLMkthSkloMTVBbDRuMUhMZDlZRWU1NFMyS0c1bm1h?=
 =?utf-8?B?RDhYWkVMODk2MFhUOFNMeVVlRGtJWGhFakFtaHk5RlM3Zlo2dDRaaytzWUkx?=
 =?utf-8?B?VkI1aEdvYk92S2xLd3cyM1JGU0p4R0ljTzZwMzhFcExRNUVWM0dsMFdVYkNi?=
 =?utf-8?B?T2JZcGlHdmVIR0pQSk5laURrQnA4b3J5a3dReFZXRnVHQVBRNFBzYTVQUDdC?=
 =?utf-8?B?QUw2R092Yi9hdlpqdWx4bU03OWtxblZqRHMzR3pBZjQ5TFZBRXJTSSsrMk9Q?=
 =?utf-8?B?TjZ4MkppRERkRmVRZEVrVVhxckhTUFU1bnBkVER6aThGR3YycUNJbjRhR1pH?=
 =?utf-8?B?RS9zMHVLYmYzZG9mcDVCblBHa2UwaTkxOTc5a0ZPR2tlSlFDMFJreXpHVTBo?=
 =?utf-8?B?TEhGS1A5T3hjSmh6NXpQUmtGNVRoRWtVYVdIMDBpRFBwMm1Eb0ZOQkYzK3Nj?=
 =?utf-8?B?WWZxcC9jaE9BK1NzWktlTCtnbHhYdlRxa09tTGxrejJPRkJZTUxjSEFHY2Rm?=
 =?utf-8?B?OEdLSWNaSkJoRnFCWWY1QjJwMzBrTm14MWVnVEN3TTZxZVk5STBTUjdiNlJi?=
 =?utf-8?B?bERuOCtDTHhlcEFzNHBNNCtuREt1bTBMc3h5SE51S1NtKzZEeTlGRk9GdG9Q?=
 =?utf-8?B?eFJHcEFLUkxablc4Y3BMdHArRFVQckR5RERTekphY09tMVNjQ1NOYjdGZjQ1?=
 =?utf-8?B?aXcwZGhvU1F0ZjQwR1NkSk1ndC9EWGtSVUU3ejkyWG8rK2diMGN6Y0gvSlh5?=
 =?utf-8?B?RENJdlBEZmVadHI3UHJ4amo4WTN0Zm5rYmNZZnM3aHhmVHNtWjV0elN6YmVr?=
 =?utf-8?B?Z3dIYjBPc01FR3ZTZVBBdlVmRmxPamxZLzI5ak8yTUdldStqUFBsK0ljLzNZ?=
 =?utf-8?B?T1hMd1V6RWpJS1c1R0tOUjdFTWpkNkl0RjZBTUVPNVJRTDJ3QTM0VUV1elJm?=
 =?utf-8?B?T2RVbURFNGlEQkxBWk9DYWNxVjBkNjNJRklucE9GS2l3N0lCNTlMN3lwOEpV?=
 =?utf-8?B?V2RYbThNaWtnMllTOTNRd0U5cW9lSTJWMXBkZ21wMXpxWWVTOHo4aE1rOWtS?=
 =?utf-8?B?STQyMmpzcEladWgvM2lqdm5NNTBjTG1sYll3amVoNlZTU2pmbVJQWEU1aUlL?=
 =?utf-8?B?OUJoZE1JSW1TOHg0TUtkWCtqYlMvL0NqcStOREpCVzVrNE1pV1dnV0p2bnND?=
 =?utf-8?B?am5OeEE2TWpxc3hST3ZNdmloWjJJMmxQenJHcWZWdFRQbzBFTEhsM1RyanJG?=
 =?utf-8?B?M29OZDhiRmxLSVJTUW9xaUtGSjVWUUU0MDIwWEpPUjhpYU9CM0MwQ2NtdUJh?=
 =?utf-8?B?dlFmOFRabCtLMkhKbFJKZmxmVm1HUkx3U2FDQmF1OGZkalREQWR1cWdnNklk?=
 =?utf-8?B?bkptUUJ5YWdndWpLT1BlbEFUdStXVUxMWS9hZjZQUjFObjFtcENXdWluVGhU?=
 =?utf-8?B?aVNUYXVpUlRPa3hYS1BuYUFRMENGZGIxVWJTYlBmUnhKY042S1haT2FxZXFW?=
 =?utf-8?B?b0czdzlDZSs3RGJMK0Z0K3ZpT2x0Y3N1SXJFSGQwbjNkNGxKeHBzS3BoQjNY?=
 =?utf-8?B?UVI5NHQvNlY5Vm5zVklIbWRqcXlmNDJabEpYRXhTVGFaN3JRUjZPUmhFZ1pr?=
 =?utf-8?B?Y0lVRmUrTHkzTzVzVEdQcFhjYmQ3MXA2bkpScVhMaVY2aXJ5T0x1UTlXdHd6?=
 =?utf-8?B?UVk3OHEyOTNKOEhsNjBOb21KKzFMazN2dmNBN0d1UDhVdURVbzlRUXRrTEJr?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de953b64-670a-4062-c9fb-08dc39916095
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:46:13.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbbQFZkKeOepVfBe0afMwSYSGwb39FIersCcQDaBuqudNjAbB+q67dlgHVEZh+jpeH0yhGtjUNFo2gnhfENpRqGyQk9BR5t22xKMd9X00r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
X-OriginatorOrg: intel.com



On 2/29/2024 7:11 PM, William Tu wrote:
> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
> 
> 1. shrdesc_mode: to enable a sharing memory buffer for
> representor's rx buffer, and 2. shrdesc_count: to control the
> number of buffers in this shared memory pool.
> 
> When using switchdev mode, the representor ports handles the slow path
> traffic, the traffic that can't be offloaded will be redirected to the
> representor port for processing. Memory consumption of the representor
> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
> ports are for slow path traffic, most of these rx DMA memory are idle.
> 
> Add shrdesc_mode configuration, allowing multiple representors
> to share a rx memory buffer pool. When enabled, individual representor
> doesn't need to allocate its dedicated rx buffer, but just pointing
> its rq to the memory pool. This could make the memory being better

I guess the rx buffers are allocated from a page_pool. Does it mean that 
a page pool is now shared across multiple rx queues belonging to 
multiple netdevs?  Do they all share the same napi?

> utilized. The shrdesc_count represents the number of rx ring
> entries, e.g., same meaning as ethtool -g, that's shared across other
> representors. Users adjust it based on how many reps, total system
> memory, or performance expectation.
> 
> The two params are also useful for other vendors such as Intel ICE
> drivers and Broadcom's driver, which also have representor ports for
> slow path traffic.
> 
> An example use case:
> $ devlink dev eswitch show pci/0000:08:00.0
>    pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>    shrdesc-mode none shrdesc-count 0
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>    shrdesc-mode basic shrdesc-count 1024
> $ devlink dev eswitch show pci/0000:08:00.0
>    pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
>    shrdesc-mode basic shrdesc-count 1024
> 
> Note that new configurations are set at legacy mode, and enabled at
> switchdev mode.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> ---

<snip>

