Return-Path: <netdev+bounces-122962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752919634A0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2901C286193
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68A1ABEC4;
	Wed, 28 Aug 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoL+8+Qo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C91AC89F
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883741; cv=fail; b=jbL3HD83XYHEK6nrjg3Smw90iJVD/EFWDIavPjdlPSL2kR3vrqe+B9i5wSd1+he8Huk5koBNuTkvbbwmMJvl6n6THyak+TvesI5ZpemWJJMMtqrgzEtQlKAzxR+LQlspNxcbV3ZtJ4sNvDzBDH6VHMDz7Tc30mFPN6qEN9ZPl0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883741; c=relaxed/simple;
	bh=B597mMrI6ZR1OEcDbSm68UDx/ezHYeo+ytVb0VJAKlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dy/+B7Q+jS/gi41fckijVV4luh4/1cpzT03oum0RXh302Ux510WyjoyvwYY3OdwtMIESv5dGSraM29+zte2Szh9L2qXe0reTU0fMwlOJ7tTd+Wa4+goIQYWjQeQjo/wD1cGK1BUi3hNhf5ta1QfaQwFlOf2nRyjyMS75b2dBstA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoL+8+Qo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883740; x=1756419740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B597mMrI6ZR1OEcDbSm68UDx/ezHYeo+ytVb0VJAKlo=;
  b=RoL+8+QoPeKeFvCD0fpjsxH04Ko1yF6yGm5JE59vZsxqTi7qfdal/K+v
   OWZIEI5RgbeZI7wunQrB5l9F0B83MRazvbMh2ESRUOXy3GBv9dM+aIltN
   nl5d/hUdn4bm6btjemEi+1QvlSpdXu4AF+s69HmqaXp/WtIENSQaVO8lD
   mNWKW2TXjjhXbXTjBgNyau/KbBjUkz99JnBGF9zCxftiZM0sM40/tWSmS
   UY0YTM3/KRdJF2PW8I6CLvNYwVJXawffZ7oWOWpTsKe5vqQxzY0CeZa2Y
   yYOfb2CN72newoBpl+RhdvAvkmW4QrELd58oRya3NVo2rQbe9F3iLlGO4
   Q==;
X-CSE-ConnectionGUID: 25zw5g7xQOa5m4gLAHhb3Q==
X-CSE-MsgGUID: 6bvG5CO9Qgatq5lwvGDXCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34600024"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34600024"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:22:19 -0700
X-CSE-ConnectionGUID: 3t6Pf2T4TjyZyMWL+TvwIA==
X-CSE-MsgGUID: n/5+wIL3TRKVO09QZ7yKvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63366408"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:22:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:22:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:22:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0AlArUN3i9W6B8Tlj9C9cCxhqIKATmL6LHuU1GRYzjdtgcUDnM3mNqzdhkfjCQg7AzFP1TBB8XwU5BHCc7NK/rjxQFqYTGmtTUaVNTd4KmpEhqL4eF0XGHQofVOoWlHVIEcdO3sQeipkkREW+OuREz9jSZr2KU+yFEzcRfxH5Vh06jVov320Ce/4RRk3ve5xiS2ZIav6kuuoMWZTw/gWTin7WUdPc8CNftF2H7AiszbEyHTpuEwmDF7NPyecKTB2oni5/MDUYKdUa382M+jR+xBM7H1Y44YMAryaPSanGaa80Jl6uhXBFhORH08zjdVqqMthYimXUhCSIU+8AE7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPWBTjuWnBVfuzUZJEJdIcszBGCBKXTDrJl5vG+De7Y=;
 b=uK5ShpJg9JByLL1t2P4tG63guFLsiMTIBWRkNf2M3dRrhtgbcRJ8OkAjrh4EoMxvBCx32ayLya2mQwCoBuA2eA7ZyCStyr7ZWBEUQ/gedawDEMpdL5KJu4MHssjD9AAzZuaQf7jnblwXO7c/Xs+lomZtAovm9ASK0Gj1dIj90h+DE3Byv9THXfNIsQMf6QzJs1YR/3Z5duojT8CmnubE06jz1JgxzhAD6VvkuhrxmYpBk7godQMoF/0VkdphFC3Yx+BVu06/j/HgK2r335he47JzIaSJpL0l2ya4sk5bBpf1CLsuDnuOWeq0KKMemQQv67pIoK+zjscZ6whvneh6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:22:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:22:17 +0000
Message-ID: <4c2c2ec2-bc6b-4201-8e65-342a354c469f@intel.com>
Date: Wed, 28 Aug 2024 15:22:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] sfc: add n_rx_overlength to ethtool stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e9b85a-9c16-4dda-76fb-08dcc7afe000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkZrN29ZMFBnRDM3NEs0TG9hT2lhUHFhekVhb2d2TDNHZDNMTy9ILyt1bHkr?=
 =?utf-8?B?d3lGL0xPR1NVZjBPMzFjUWpKTTFUS2tpTFZabkhRaWh0UVFveVBXSkNNc1BK?=
 =?utf-8?B?aUx3TmwxS25PQ3lxeUZvYUhjaEY4Q0VvN3MvQXJrME5LQmpPU2RjS04rc2Ny?=
 =?utf-8?B?bVJLUSt6MDhEamNUWUFIY01DRHdzOHJ5ZzhURE9Dc3BlYTdBMGc2NUJyMlJ3?=
 =?utf-8?B?cTFOZ2RTRmVhQS96bDFkTjhnRTJKenZEaW9PV0NPTFREY2VpOWJ4aVh3VVlF?=
 =?utf-8?B?N1RTcTRuUncyNDV3dFRPdTVMcnlwNUVYa2k2QlpqZ1g1bjlsdjB5U3hpQ1I1?=
 =?utf-8?B?OXhidGNNOVdra0NCVjh4elJPNER0dU1ZWDFudDIzajNtRHd1M0NvSmloL0FZ?=
 =?utf-8?B?bzZjRWFFdWhpUWNPQ0lPR2tRMUxLL0RBcGpQMTM2Q0x6R3JQNWJaOFo0aTdo?=
 =?utf-8?B?QWpRV1JFRXljczZFSXFqMEk5bjY4MXZhUmhheUNQNzRNKzhYWUc0TXQ4ZjJ4?=
 =?utf-8?B?OHFzeUE3aEltbkRNNkZUS3grV0JXekZhdkVXRUlKK2ZwQ003dmh5bVpVQTdV?=
 =?utf-8?B?UWFyYmplWFhZVk1OZENQdzRoVHZkY2wyUVFyR3dHVXd6NlhhMlR6VTlZN3Zv?=
 =?utf-8?B?b2RwRE5nVmZRakQ1blhNYjIyOGE2U3kySUswM0d2T0xwNVpFd0xubEVtOGFV?=
 =?utf-8?B?NHkxeTg3MmpBNHlIbDd2eitESjBtYnNkZkkvanp6NWJ1T2ZjVUhGYUJIZ2lG?=
 =?utf-8?B?dThnV1pnUEN1cTZHTWV3dDNxbGJ2NWRaQWJTSmlGc0JkZWlvYWJOUXhGU3lS?=
 =?utf-8?B?QzhrZTJVRE1XQVk5ZmYrdlNNL2dqSStKY2FuNGpTSnhHVkREQ3pGcmJlUWNQ?=
 =?utf-8?B?a29EUmpDcTNNQWlRRGVtTDE4V2dHc2ViZythWGtEYW84em5KSHozbkJieGpY?=
 =?utf-8?B?dzhVK0lhV3hrYlo4T01SNG1zYk5IT0hROHNHbnBlWmJzRjVzUWJ1UXFaeFFM?=
 =?utf-8?B?MXFTWE5aZFVWdUJYY2dvSTBuYjZvTkNXOUpUUU1TTmNHblVEOVJ4MTh5Vzgv?=
 =?utf-8?B?ci93Q1V4WHdGeEM3ZERSeW5zUDJlOGxQVHhoM2VPbWRnd1o1ZmR5Um05M1RE?=
 =?utf-8?B?VnU0SHpzUnZwMS9PdmdJa3J0VzJyeXdhTXplZUNsOHdGUVVxNDNTM0JydGlV?=
 =?utf-8?B?T1hiaHhGN2w3NnRQZy95U0JUWU1rZVNhZFUzZTBuMzhWa3lmelg2b0RiSzYx?=
 =?utf-8?B?SWJuRU0rN3BGSHZ5UzhIbUgzbHlnNEEwMHFNVXlvZXFQbWRicElSd0lkQXIy?=
 =?utf-8?B?dUh1U0NqQTBlYWl4d2w1MWlCYTBNbzBzT2JTV1hsMm5rUDJ1Z0lFTzJZYktB?=
 =?utf-8?B?OWhlVXJiRmIyazhDYWFsUFZtZ2d1VEs3UGFpVDFQdXlPUHJlNTloMldIQjU2?=
 =?utf-8?B?TVJWclY4Mkg5WllVTGFGa2dhTjcxTUxOSXJDcjJKdENmU1N3dkFtU1RXQ3VP?=
 =?utf-8?B?clNzZ0R6eVcvbjJ5KzVVelhWbWVYSG16VWk1ZG9LTjZkaWRFUENaQWh5QVRE?=
 =?utf-8?B?LzA5aDZUR3ZsdU9jRkw2LzlOZko3NVdXVDYzZ0l1clBCZ3M0d0RpQ2kzMHZY?=
 =?utf-8?B?N0tkNE0vZ1JPcjFCcWhhcUpHczF4Q0NpK3ZiYldHejZFUEV3RzlaK2JORUNq?=
 =?utf-8?B?ak8xQTVrU1htbFdTd3dsN3JFWWZRR3grTHZUWDhDRmpNWitrRm9yejlVM1lw?=
 =?utf-8?B?YXFFek96TzJFaFdUVEJCR1dJWU9KeE5jbytFRmZxNklEUUZxNmt5WEFtMHlK?=
 =?utf-8?B?ZWZFQUxRUU1zK1ZIMGVFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXgxZ1hhSFBlK2xVWHU1SXlqbW5PUnVTK0RjaVNsSlBlNVhMcXdzbTljU25V?=
 =?utf-8?B?ZmtPekdRaFYxdzZtU2hBSy9HcStKVFZuK1pLSlFqV1NzdHFpMDkvLzNyZ0ww?=
 =?utf-8?B?MS9ZZnRXV2VjMS9VZ0U5dHRWS282dXlOaForMjg2dTAxQlJ6SmpUUnFnekk5?=
 =?utf-8?B?VlJzV1ZTOVViam0yc1ViaXdXcTdVUG0zNUxjeWpiOXhGb0ljWTI4VDJ5eVBl?=
 =?utf-8?B?eFJxZUFUZXJ1cXRpWXVudUwrU2tON0g2Yi9DNmZKczFoMHQvV292TDZldnZG?=
 =?utf-8?B?WlEraEM1amdRb1R3eFhweWFtbnBJbzlMTnBIZVA5cnY5ZHBDb041MVduQjl0?=
 =?utf-8?B?YXg1VkdEMTJmRElnekIyMDZVUG4zcGFFZ0FGVE5Ub2dGbmZuSkxMV0p6Ylp4?=
 =?utf-8?B?K0pHdWlPSzI4bWpGRW9NOC8zcjdkREQ4Q1hrekRxTmwzeTFjenFrM2wrWHZr?=
 =?utf-8?B?eGJSQWYyVjRkQVlveUxxemUybm05TTc2YUg3SGRVb0pKSnlTMHhaSGtld3Bq?=
 =?utf-8?B?cm95UE9FYSsxNjZsZ09zcUVwall5RzlBZlFwZUg3YVRHWnM0ZFd6UE5Hb1RG?=
 =?utf-8?B?bmEvc0k1MDhjcjhyWGdvNGRycjdGU21mZ3pxYUpYTVovYmpYZ3RYS0FYN2s4?=
 =?utf-8?B?ODhtcDIyaGxPdXNtVkJnaUlvVkxianNHZlA5VFFBVnRTeGRUWWNIdFZUTzdI?=
 =?utf-8?B?MUhGZGR2em9aUzg0TWdiNFlKV2twK3BrdGtrMkc3SFVuQXZwOVZwMTRkUDIr?=
 =?utf-8?B?SzR6bU41RGZNYUNKMHBwWms2bjFmdjBORGJ3YnVZdVpYaGZZd0dKRDBXb096?=
 =?utf-8?B?R3ZET0RKc3hpNngvenNKbkVOY1A1UHozQitBMUNpa3EvQXJ5eHZXTm1nc0kr?=
 =?utf-8?B?Mzg4dU5GT3kyMi9MUzVhNzE5djVXUmJVV1V1SFp1Zy8rSjlIMlZlblN0Tk5s?=
 =?utf-8?B?ZldhcEtKcnB5VzV4dGUwQXdCZDVwb3AyaUhZeENLNDVGSUtVTWwydmlFRUM2?=
 =?utf-8?B?c3JHK09jLzdmM3IwcVpmZC9FZDRpUDdrM1ExS2p1Z01oVmVxWFJXNWpWLzFQ?=
 =?utf-8?B?WDVBdlJTQWtuZHZDaStqSmNRUVFCdVpuOHpwS0Zic2NHaXRPSzd0VVB2U29i?=
 =?utf-8?B?UUlkY0s5MXdoZzJTMjRoVTlxdnFXV1kybnpKbVVIY1AzOGN1bjVSWHYyMWV0?=
 =?utf-8?B?dWRlVU41eUVNS0xyY3RoRitGaFh3WlpaUEF2L3NvNERUcXYzeU5RWEZJVUhu?=
 =?utf-8?B?bUpGWnVHSmI4dlBuN2F5T0QvWGNTbnBxQURQR09Sd1J6L3djeUNGU2Z6UXh3?=
 =?utf-8?B?SE5hMk1VTDQ0cGxjTGFKNUR3ZFR3RW5Zd29KQUJyUmtVSGdhaGl3K2FIRlpZ?=
 =?utf-8?B?d3RIZ0w0eDRqZTQ5V0h2dFVkSWl4aDU2RXI3ZVVNV2xpK0RtdDRWbFBKZURa?=
 =?utf-8?B?WWxGNW12NlpyR2dVZDBTbUlOcEg2Y3A2S1FxY0pJak5SQnkwTjZCRVlMdzM5?=
 =?utf-8?B?NFUwTnY5Wk1CNklzNHI5UUZBZTBBZFFpOHVEYStydGthRmphczdkZEhhWXF3?=
 =?utf-8?B?TjBWTHNYVXM4bWVEYkQxcVlsUkZQOG52RkcwL0tYS0lNbGZ5b2JNeGVHTi91?=
 =?utf-8?B?RzVDS3VEaEttV0E5eDhjdlFjU3FFY0hrQ0R2UHM1NE1tVGJUbk5JTmtONW83?=
 =?utf-8?B?YzdBKzJERHU4cFdxaGdoRzNobHNJY0hmY0M1d05XUzdsZkpKc0dlcnlMUG1T?=
 =?utf-8?B?R1Y2Uko5RUFlOTFSb09uRFpBOXNtV3ZULzA0TDJ0ZVEzMzBUQmlXYVliYVRC?=
 =?utf-8?B?M3dIZkZGWXJ4dnZIM2l4dzZhSjRHMXBaMWRRbG5jWXd3bitaK0M0cDlvcTJ4?=
 =?utf-8?B?cDZUVWNsUWZNa0hIWm41MEZDTVhncmJyMFJyWnB5S2RqS1QyWXNXZWpFRWV1?=
 =?utf-8?B?Ylh6bXVRb242M20xQm5VUG00OWZzVWx6cHFFSlBpbk43UU9HRGFDcTBCZitH?=
 =?utf-8?B?YXpDYjNaTDJUVkJCSk9vcUpyMWlnSG9LM2dBUmFKZ3F5SXJKV2lkRU54blAz?=
 =?utf-8?B?cy82NWFCK1d0TmhnajZvVU9rT1ArTk1vQUFCeGYzM291QzgxK1FHUEEwL0hy?=
 =?utf-8?B?ZGJiTlV1MkdiTXQ5bVFMQVpiZ0hvdC8xUFAyMVFqTm04RUlGVWJHMjJORUR3?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e9b85a-9c16-4dda-76fb-08dcc7afe000
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:22:17.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uad6PSWX8DjEW08bRFJeyM07J+6EB75uQwUN/zYd05H7tRxjIZzv0C5j18Oc1kqKD1kcwANSXxCBngAHMPIp7WDiT5U0LN7Q3FGSYXfQB0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> This counter is the main difference between the old and new locations
>  of the rx_packets increment (the other is scatter errors which
>  produce a WARN_ON).  It previously was not reported anywhere; add it
>  to ethtool -S output to ensure users still have this information.
> 

The description makes sense in context with the whole series but doesn't
quite work for me if I think about viewing it without context. Perhaps a
little more clarification about the rx_packets behavioral change?

> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/sfc/ethtool_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
> index a8baeacd83c0..ae32e08540fa 100644
> --- a/drivers/net/ethernet/sfc/ethtool_common.c
> +++ b/drivers/net/ethernet/sfc/ethtool_common.c
> @@ -83,6 +83,7 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_tcp_udp_chksum_err),
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_eth_crc_err),
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_frm_trunc),
> +	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_overlength),
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_events),
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_packets),
>  	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_xdp_drops),
> 

