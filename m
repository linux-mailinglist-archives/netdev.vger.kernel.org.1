Return-Path: <netdev+bounces-186840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89540AA1BD1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D651B67F9C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE325A2DE;
	Tue, 29 Apr 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8QGgtfF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F6253344
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957317; cv=fail; b=CNdTJI/Y0k89jEVoo7x0jsc3hCNs9tt9WzD2TvKG4zhT0JMsvg9X0UIrgc+/jlWGRpihqxBowz5PustpFi12NyVzLEtRF9iwPOjybZWVbGs4QP6OzRTG5CMD1fxXBfdYCRKMHSTaxH9ruBIdr7E4ctQVtVxhB2gJwimGC17ynWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957317; c=relaxed/simple;
	bh=Jd/sewhkYGoIRXtBIb0W0I7mSy1R8qJL6yvNXKYJsLg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qOc2XIfbvOrsfAIWWb54dIM6iqyR+8wCIAwqJggm/bOKUWOavm6Mxn9bXTrUgmTqTJjUBTyx6FX3mnpxgiI9AFqmlJQz+X35eBayGguYh/KeEpG2O5PvNV6g6cAgK9esC0RyuAFAYpK+L4gozECY7V3hqLM4UJ0+MIadEeI8RDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8QGgtfF; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745957316; x=1777493316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jd/sewhkYGoIRXtBIb0W0I7mSy1R8qJL6yvNXKYJsLg=;
  b=K8QGgtfF/VboCuiQNVmd7BNoSlgBzAovn4khJpfHeDP/hFrehJ+G07mr
   imhQbveI9/pPcbznuO11+e0EnI/pkDap50N4E+E0eOx4JkvTzjQoyIwKB
   4PAdqq2kfYRNqazKka9o7pwiwkaAmf0jOHMMfa6MV/U+1mtDeTnd4AMNu
   IvtKv6P10uKnPUOxbkV6j4CgwOw0L7v/rAY7ByLM+ZPym25NdE+Vuf3c4
   s8tzazRg4vDgYzS8DE3bLAe6NoNR9kYbsD3GSHzXDc8po2aalgzdzr5CI
   e9Ne/CBhuRLQJqMPoqVL2L+Y91RxOlvRJG0Ry0uIXukPJ2yI3GbU4yPsN
   w==;
X-CSE-ConnectionGUID: E4+/ULIiRpyPtUfIOKNVxg==
X-CSE-MsgGUID: /w/2sDZwRk+AEIgbmYaZjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58974336"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58974336"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:08:35 -0700
X-CSE-ConnectionGUID: Dt6GsDx+QKW0GP2X7jzwNA==
X-CSE-MsgGUID: 0QmePnF0RC+knPBmXuvn6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134874828"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:08:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 13:08:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 13:08:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 13:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJlSBZLQPkhKfJP5F4QJQuGz7nB4X8HcSUnTcz//x+K3xOmotZPRAD7LJk9O4plEMK1lVD8FnCAfgSpxOfqiqh6CrxX3GlqlY/ao5Omd+U7zj0rdAZ+hIUCDPUL74FhmAuZptLd+XAmg3iozv2+eu//bO94Ux3ozUtXaEy6Yjn6KFPL5DQ3GGDr50d3AtYZ7pksinV4HBoeZkwovnlRHyqSNY5BK8aEb/jH/6aHo2jVZD1HzrlAGgiWWIJalD2+vTnAhCHSNJgiJlDbRyjxAx4+LAyF9iByD0QBj6AkbYq3oR1YiQGnOwDIAAOBfoCqBUglC5Y6rcUGALImDpTCb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAIjod92pyRrPKPwL7T1EM0R/gi/r/w+xWSB8KKkbTo=;
 b=IHPLwTgpzhdSw4l/3y0wJISGkCBE6skC4EyabP9J4BJ4cxQM+SuGx/yG92tE2STErrlE0bbJXTZfBgf0udUpap1z6Kn5I11OjdMrtXdEJkdDFpjHzSWc9tuZ14AFV4Vk614dskdI9t8Cpe1qqHIsnAKySb/nKp4c1ljgPSw95qbEQoUE51f+b2Q+6OjmEYbPNM1rPE9+IrdYjoi8Lr/vETC+FyRBh54C/CGXue+kTN2qQ/OljbCtciMCMpv1gCi78fmdUQIljlr372jFEUtko0G6sSdT1rJhRDr3f++MSPUU2LTw7frc1WKHcQNJ2jOaUkagzjfeycssfIRxcQerzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 20:08:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 20:08:30 +0000
Message-ID: <13277d99-9e09-4cf7-9726-7a763439d245@intel.com>
Date: Tue, 29 Apr 2025 13:08:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b0cec9-ecac-4bb0-da1e-08dd87599c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MExrc1R0NDVVekRhVVU0eXl6SnRybUF3L0R1dU9hOU5JVWZUVW10Sys3SG9B?=
 =?utf-8?B?SnZZTFhzVi93cjd5Nnh4eGFrR3RwdisxNldQNHg3MjkzeVJPdXVEa0pvdVZ1?=
 =?utf-8?B?QnEzdUUzUHlpRUxGRWlwLzV2UVRDYjlGOXc2NmFpaGtCSVEzQmRpNzRzY1o5?=
 =?utf-8?B?M3l0NC9ybHAxTnl2bFVuZnN1ZXRNemR3UFdqdlVzUnFxZnV3VTJIRmtqaGZa?=
 =?utf-8?B?dFdyb215UXRON3M5R1F0Mk5pREI4cHJzck40NzYyK2VWOUlhZ1JhZ2lUa1dE?=
 =?utf-8?B?VjgrQ3Z1SVp3cmhwNjBwdWZUajJGMTZzdXEySWF6MkVzNUIrY2s0c3pvaXhG?=
 =?utf-8?B?cytBSmk3Kzk5YmM1eWROSStYbEFxVjlFOGNHWkdRYjlaTEM3bzBDT21UbjZm?=
 =?utf-8?B?ZmNJTDIvVVRhaGpldklXQ3p3bDlYczZwWTRlV3lyZGl3ZUg2S0IyQ1pHb2RW?=
 =?utf-8?B?aVZwcmh4R3FZQk1udE9tdGx1S2YwVDJ2RFBoV0VPamd1QzNMRTFpMTlXakdC?=
 =?utf-8?B?OXR2em5FUFgwSHF1K0g1N3JpS0ErYStTWUVKL0ZOdUYwbWJBczl3a3RXZGRU?=
 =?utf-8?B?UDBJTWsya3VWWXMwbmpzRVZPaUdSeHQ4Z0lIdm9mc0hKeG14amR5TkNPaDB5?=
 =?utf-8?B?ekZLd1NMSmg4L1BCTmo3V01LNVpnV1BpSHVzWkw0RmlpL0RqUjNzUzRiMjQw?=
 =?utf-8?B?YUlnK0xPR0cxNnQya1pBaGZSRytXdDdJd2gwYjUyL1R0R3duMGkxVzdvSVE5?=
 =?utf-8?B?cU5hR05ua2hQTGwvNDkzTVZERkYzTG9CaWI3UzdSaG1wUVhGcHVqUnR6YzAz?=
 =?utf-8?B?aTRWeklwbVByK2VSa1BTZWVSVWxZaENiMytXdnpBSGZGa2l0Y0F4dDVPbGc3?=
 =?utf-8?B?NTRoUjZiL2U5YUVKdENLdDdHRHIrZmJycUR2SmVyVGtkMjJYMk5tNk1tdWxT?=
 =?utf-8?B?c1NLQWlyRjJqNmQ0VzBLV3RROGN4cWFFYWExM3FHZFZhVFNvaWJkeUpONFZz?=
 =?utf-8?B?K1NtZFAzak8wS0hWSTBJczhiUk1BaXd2azZ2MHJBZzRTL2drT1lqUHVrL3JN?=
 =?utf-8?B?R1c4eWhrd09EODNOek5DV0N4OFNyMU9MVDZLQU1qenRPcnRwQXNiY3RCbjY2?=
 =?utf-8?B?a0FrcGFLMWxCUyswZzh1eHlBT1UwWHpLSkxTOERZdjZxd1BobnZVcVhCMlBW?=
 =?utf-8?B?NFR2bXAzVUJnd2JMZS9nNWk2eXhTVkFkVTRFMWdjOXF3akZ4UXg3VXd3NDdx?=
 =?utf-8?B?L3Y4OWlpSlc0N2g1S1gzVW9oc2FEM0tKcWphZHdqcnRRUGJOc1VHWWR5ZjZU?=
 =?utf-8?B?dWoxWlhja0NKSG5vSzFnVU1TblBMWHVBeWZ6RXJwVEkzKzN3UVdGeGY2aW5k?=
 =?utf-8?B?T3plT0ZndFVrVjJsd1B0akVmcWdzSDZ0TjdPQWN6NHMzbTNZWDZNeGtqVnVN?=
 =?utf-8?B?MnpTZ2RKaExHVFFEbUZRdGVjZVlPM0h3ck5GMEc0Mmp2VUVYbmtIenpJNUxT?=
 =?utf-8?B?NlpPeUw2c3VuMzFiZFo1SjBIc2xlQ0FkWWJmWWt3STduOXJOeXVRRkVnTWRY?=
 =?utf-8?B?em9tNGc3dUsrWlZEZTFBVEJDRmg2dWJJdjY2c3g3MWV4THlPSTlsSGZVYW5V?=
 =?utf-8?B?UUszQjJhUndGTUkyYUNwTU1DVzJNR2kxcjV5aS9MTnAyd01ZOUNUZjdGYmdu?=
 =?utf-8?B?ZE9hQUpUL3R0WUVCQkpjSlRWdG5xZkxVYTFZeDhmRklIeklhMEhBTGFYN21G?=
 =?utf-8?B?UjVEU3VPMVE4bEU4V1pLRkZYcWVwZGRMY1VDK2hBNHJwNzhkZDlZM1haRldG?=
 =?utf-8?B?UEdndWtQeStyK3MrZXVXVm1MWTErSW9yeVdmNXlRS3I1OURVdE9tdFRZWk8y?=
 =?utf-8?B?M2xrd0FocHhuVU9FcTRCbXk3YlEvRjVza0dUWUI5OVJEOUxpUDBQMnlKWmtZ?=
 =?utf-8?Q?WKA4fH8PRwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVkSDI1WHJKMklHRnFYbThWSmdRUE5MRDIzMCtrVnNXUjk2UmFCZHZCbWxw?=
 =?utf-8?B?S0htSHpMT1pMVUsya3QwcnJFRmJ1WjRnR01oU2d1ZUlBUDJCdHgwVnFBTXVv?=
 =?utf-8?B?bXF3VlNuc1ZwVUhFUGtBUnV0R3hvanhxcVQyK3dvaDU3b01IckNSQnBMdUhz?=
 =?utf-8?B?OU42YkM3S29lRlJOSC9uTVA3Y0FUOW9JdEttbmVHTmh3QkxBYlhFS0JZbVNR?=
 =?utf-8?B?RkFxejZKWTk2b0x1MlRoQno4M3Y1REhKeVk3WmNQMXRxUjM5S1MxUndKbEtH?=
 =?utf-8?B?MHU2N28xa2RHY1RRaFpjTlZEczR6VVl4aG9TeGNLaWRFRFdqYzdIM2xOYlo0?=
 =?utf-8?B?RUFwVDNBaGVFYmpld0dmS0Exbk15WGVHSjArbHRWZ2F5bTZWaTZ1NThUd1Fs?=
 =?utf-8?B?Z2hWdFdMRXJFNXpIMnJjeUl1S3RKVXFiMElhMGZQcWlQUjl0M0FqN08zamJI?=
 =?utf-8?B?UndKM1p4MmVEMFl1cTNkeldUY3JxeG9tZ3RyQ2FIWEZrQ01NVXZ0aWllMVc4?=
 =?utf-8?B?Tm8vTkRKU0hPTzRxSGRSaFdVQVV3eHVNa3pqS3JOaGVQS1FrUkJidTA2WE11?=
 =?utf-8?B?RWpqRXpmYVdRL2Z0UFhjeUVlQm1oOU4zN0hsWDBoWVpCcVp6TU5ib0xHVytl?=
 =?utf-8?B?UGN2Yk5EWTZoclpYdG8xUkN1Y2EzRmluUS9xZzhxOFZFSlF0cDFMUjFKL2NL?=
 =?utf-8?B?bkxBcWFreld4SW4zSGYzOTV6VnA5V3lmcjVKeTEvZWlVd09XcS9YZDNNTGF2?=
 =?utf-8?B?K29wajZJYjQrY0VRejh2eUF0UkJ1RXhGRkxMYlI0b2VZcWNrV0x5TzF0emlm?=
 =?utf-8?B?RzVBRzJjZ1ZpM3JGWVZBOG5VU21GUXU2alFoR3RKSkk4MGJGdXVORkRWcXkv?=
 =?utf-8?B?YTY0dDBVbk9wQnFNSWc3UWsrNGFJSkdsWUpGZkhFZWJxK2FLb1pPc2Jwd2xh?=
 =?utf-8?B?dEVoTzE2TXU5L0Ryb3lsNXhab1ExNHdYcXVoUTBTK1FlU3Z4Q29TME9CNndo?=
 =?utf-8?B?VkhtSUYrTmZaeHhMRmlJK3Y1b2RNdzJ6Ympmdm8zRERzeHNjZkJ6MXVPdmJO?=
 =?utf-8?B?SEJFbXp6MzN2OFpleG1zbGszUFVFSEUzMkFOcHF3ajg2V1V6MUFzeU1CUHlh?=
 =?utf-8?B?ZGtVWWE5aXRPaXVDbU9UUk9GZ092c1dWK1lWNXBQMytsWEhENWcyRzRDb09S?=
 =?utf-8?B?b094YzY4c2VMZ29BYmpjeTF1Z3dRWHU3dDZXRmp4WC9xVDkxaFZqV3FKTG1M?=
 =?utf-8?B?anRsbXpBcWVycjdFaml3MGZjZ0YweS9WUGtGN2lmOTc2N2RVT2krQ3RIdmFJ?=
 =?utf-8?B?SmJFQTZReVR0T2FSQ0tsVzVoTWF5T0pyZzlWOGV3c3hVcEdiN241dU8vY3hY?=
 =?utf-8?B?NjBJbXZxZEFQZGI4NUxRcEp4dlN3MFVOZUY4UGxTL1B0cS9uUlRYUXNsVFIv?=
 =?utf-8?B?ZzF1eVQ4UmV5N2RQK0NPbnhtWmxUbjlyb1oxcWJ3UVBoMjlLME5SWGxMZDR5?=
 =?utf-8?B?VWx2L2dEMXJweGlCdDFpaDBkMk9oWm5tR3pqYW9tTjE3dWFQaEZGRkwrSGRW?=
 =?utf-8?B?N1JiY1JuTSs5bmxkVVNPV0ZVaXZTNW5JSjhGMGZmWWtHMTEzUldkUkJURVc1?=
 =?utf-8?B?Q2RJQ1RMcXVmN1h3QkExdHU3OEt1V3ZURWJNZFlvNnlUL1AyNG9KdHJWZ2ht?=
 =?utf-8?B?RmpMVTZGQVpwRWUyc2pEdzJOMjdJTmt0V3hhK2hBVnVlNlpYeE9wVEZEWUo5?=
 =?utf-8?B?RVV5MjFIY3NmRnBBSFVteVVEamtmdDZIc0tiWnJyZHFzQlZVUHBNei80MXQx?=
 =?utf-8?B?RUdOa0E0SDJlV3l1c0doQWJmM2p5eEJzc2JDYnBBR2xLZlFYWkVNUjN2S1o3?=
 =?utf-8?B?UWxrOHFCZkVBdFhKbHFERHlVaTFyVjdFNVNvYUQrM0VQeGgwTmNzeVdIRHhC?=
 =?utf-8?B?bUpWellkd3VLRkd5RjAvZCtRd0hncytyQ2ZKZFJQUHVDdHNjOGtPbnA0Sys1?=
 =?utf-8?B?V3FSZEtXaEVJTmxhSmx4YWVUWGJHdXd2bGg5QnJ6UFR3aWt5SjNwSkJCKzh4?=
 =?utf-8?B?M3BVL1ZmSWFKbTgrODFkUE8ycXlFZENncmlDU3FpSWdnalhqS2ZmUGVTUlJr?=
 =?utf-8?B?N1Z5aFd0aThrQTNKdDBLZTFWVnFXcW9WLzl0cFp2YmllbmczWHY1OERpYmlM?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b0cec9-ecac-4bb0-da1e-08dd87599c4f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:08:30.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCf6bSEBINLQxHTJkd4m3JOk0EtiAYwpUAfvhxynvffqG/swZbIEUxX5BHot+eV5VStYU/I93QnVbO8p4qamOCn1g5vL9eIjXyBfVynry9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com



On 4/29/2025 7:17 AM, Lorenzo Bianconi wrote:
> The official Airoha EN7581 firmware requires adding max_packet filed in
> ppe_mbox_data struct while the unofficial one used to develop the Airoha
> EN7581 flowtable support does not require this field.
> This patch does not introduce any real backwards compatible issue since
> EN7581 fw is not publicly available in linux-firmware or other
> repositories (e.g. OpenWrt) yet and the official fw version will use this
> new layout. For this reason this change needs to be backported.
> Moreover, add __packed attribute to ppe_mbox_data struct definition and
> make the fw layout padding explicit in init_info struct.
> At the same time use u32 instead of int for init_info and set_info
> struct definitions in ppe_mbox_data struct.
> 
nit: subject has a typo, s/filed/field/?

