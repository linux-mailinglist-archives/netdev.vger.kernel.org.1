Return-Path: <netdev+bounces-191748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7473ABD08E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672393BA7CA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5B25D906;
	Tue, 20 May 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zo7ObjRo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C225D8E8;
	Tue, 20 May 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726640; cv=fail; b=X+f6eBUG/Bxva3RSPHFcm5komFIyuxbAkbG5addIMvPcw276GsWs7t3cLJL/4J33EdVv4qPj8DfKerTDr3u3r8GbNN6GswtrbeX6tlkwuNkOLQ/daTRZSQm1LlRnd7zi3se8Hl2VNGv20nU4dFlI9Y4FcaBRTOY3ugJYQIzkSqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726640; c=relaxed/simple;
	bh=mrLMAAk3EdjRiOFLGDb8+caRccMpNCAhSDXmOrRkpFg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=SA5q2FCo8WabsisirZI6JzLzIWnQ03jyC6KmrEi5PyT12ShEJ4IF3IrRWaFFj5OeU3zLjEkMjWvaeMAL3Io6NXvEZC4Ia5aKVdx9c4Ft2LmAoVl+cd8Zwz2dlMpyfVhdXho56vSmK53L+I/jAAqutnWNGQDJSXUaRt3OPcWvLl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zo7ObjRo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747726639; x=1779262639;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=mrLMAAk3EdjRiOFLGDb8+caRccMpNCAhSDXmOrRkpFg=;
  b=Zo7ObjRon0gFp6uzlQqlm3ucbobAlmrXctpfcMYUNC0oZFPX6m+qKbq8
   g7BC66zFAa09M3s1qXgL7T7DGD6jHK1Zfxk0b9bOCQf8x7ABA59O1DkZD
   wdEAaVi02ECyD7T0GsQoXHj7BumZLuqkHpq3rHVqTWucnGhkm9TdJsQml
   ng1ocebG7e1D/rw24BpyoVJjz2g5RtK54ZCQIL1goeKR05eK9HPVlxxTy
   nt+2upWLzQ8ZHKVnFszjipeDBxTIT3Kb/yRWozhqMkuuHE/LplMUDWFU0
   GiTTaJW2u2XEeTNh3tKzFU1865toysgB9I27PhgEjSFY0nYmGFxlh8XK7
   w==;
X-CSE-ConnectionGUID: zXjLFL/zRQKMycZ7PG9ucg==
X-CSE-MsgGUID: 0UtmNsAmSg+79UxZdn2vfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49799572"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49799572"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:37:18 -0700
X-CSE-ConnectionGUID: sTBLCUztS6W2ndFp/DsH5w==
X-CSE-MsgGUID: 1wBZAcBlQte15L8gOSMINA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139339085"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:37:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 00:37:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 00:37:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 00:37:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivjn082n6cftnVwf1R7Ij3ewOBDymzCqemM8RoKeW2buKbkQIMfBg8LnYDIa2PLHos1jeb/J2d3Huqp6FYtJbTiJ0PhcryoZAAITY06x1W+Ymsw3ByhUddIhyLVNtWlIctZ5842pDIXDsJ2ZAtpT57AQwDWEd+78XwAl/rLBMjMLmEBUwJwE2ZZoVgjjglnIy5RkApJy0tsk+sU2XS0D8ij6+KnLfUJNYR1aQsS9KGvjnx9eLZdpIp6XGEorspmzGGaG28+FoqFVzva4Blp+BG7HXrTaKOq4cvqOE9L3ob99Jur2wO6TIauC3PYzglAxR4E7NPy89Z60P5mIpxCSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5QwSVRUuDFM8mRE+q6DkHuKHT7nVXeuST4PuRz1M2g=;
 b=X01t+Jre8arSNrCsRW0X/DkTxm+kCKWFir0uuObCdAe2goRvrfU8ST6rBlKZdz+qRUVrr3tKEqO/ZAFdo8KoPa2s6H8/xKrXblhuan1Zw7tjxycom1JVoe5TTaJjV3hOPAb/HWCTbQ3AuCeskDuiiLjFYg5FcFHz5Bja7PDy10M2ZD31bYWCi+DrAAdGrKeQOIbFdE1breRqORrw/jisIIDnO5AfbjpmkA8bWkk8jYvkwGudGt+vSUt5Bu9Z/rUu4eguQwAW/JXCVg2tQqB16+IqfMOgNI2eGw9NpmCJOt9MX6qJsRiO43EXiQSiYj3rx1qD4U4ZxNDLUrpIcJWKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:37:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:37:15 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 May 2025 00:37:13 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
In-Reply-To: <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: e205a3a1-9549-4011-a083-08dd97712469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWNuM0I4NldobnNLNHpPTGNCT3hndGhJTmJIUXlsQThYUEgwNmJrRnQvcXFx?=
 =?utf-8?B?QU4wUUJSZys2UHNsc3p5N0RnOVAwekJtVStLRGJJVDZWY3NmMEVmMTczV1Jm?=
 =?utf-8?B?VS9yUzY5bkZtNWxRN1N4WWExS1NFYnZWeHhXa2NxV3Avc3B2N2tjUUljTW9s?=
 =?utf-8?B?UGZpTTkreTk2YXIrQ0lQUWN0clY2SnZqb0lBR2hSTUZpRGxoWWtTaWVjVFFL?=
 =?utf-8?B?ZWQrMXZiOEJDN3JuM3JwT3BhM2Yzd01JOEZBNmM5NlJBMEJ2OUc0RTJ1U2hI?=
 =?utf-8?B?cmlpd1ozWVBFYmVNSTBRUWlxYXBtNXpCS25PM0xSalBBWmk2T3VRa3BXVnB5?=
 =?utf-8?B?Zi8rUFhpeXlFejM1OHkxanpla0psbUxURjB6bGtVd2x6RmVMczh1K2tqM3Ez?=
 =?utf-8?B?RlNRdU1selpYb0grb0ZkeHlVUGpLeVRmVGFhMEwrWlpzL1cwZGk1RHZKUkdF?=
 =?utf-8?B?OHFQSkRHTm12V1ZCQWV2REhERFBRQ085clJiUFRud2FlZXM5aXJ3SUExTTY0?=
 =?utf-8?B?TjR1UnBJUFNsRGRxRlBoWWluS0traEJ3RVFEdWJ1OFJwZ1FxejdacmZuSG5S?=
 =?utf-8?B?a0NUamR2L2FlcHpVRnhLSlNuSTMzNkRHWHhRUEplZ0Q4cGh0OGlPVnBTQSs3?=
 =?utf-8?B?ZHV3dkxwZDhLYlBPUzFZS2IvQW0xbXJxU1pCMVlHQi9jZ01yR2s0ZTRER3hm?=
 =?utf-8?B?YWRUVFdMbGxWUFVpQTFsNDJrRGp4VFJEYlhmUE5wdG9kakU3UmJUNDIwbXRj?=
 =?utf-8?B?cHdwbnlPMWdQa0xhMmI1NzNpYXcyKy8rYXYyWS9PR3ZpOGdNWmZvdS84VGNx?=
 =?utf-8?B?RzlQK0kvTmZGeFFhNXprTGFzNC9iODVZODNLaVJsd093clJVZWpVZlBkeE00?=
 =?utf-8?B?Zlo0d0FOZW0yMjhWQkc5WTNVRERWUkhnWUtYaDNzL3lhUTgyVmd1bzhoS3l1?=
 =?utf-8?B?Wlh5S2UzS3MyMTI5UUQzM1J2emZFUEwzQUI0K0lBVFR3TTJ5bzVTOUFQZml0?=
 =?utf-8?B?bGgzSEhqMU1vQThJUnFPV1lPMWRvMFpIQlJrM0tIVi8wQWtoUE9UQ0E2bW1u?=
 =?utf-8?B?L2RqcWh4blNtd0pkNmdOKzVNaXFUMDFMdXEyY3NoNkNqUWpVVWRFemhBMG9D?=
 =?utf-8?B?NEZ3YkxhQ0NIUWhHRkZ5RDlieEpMa283QXMrRXluVjdIaCsrWHY3V3Z5WU0y?=
 =?utf-8?B?Y0NzREZKdzZXVE9sOW5rOFZMU2M3dm82bExMMTIrTzJINmdURmttZHBOcTZj?=
 =?utf-8?B?VWE0dlFTb0U1czZRY1JjdEs3ZzE0WGxIeXZYUStCNWFWSmozRmtTMDVVbFhS?=
 =?utf-8?B?K1c2dG9JcW51ckgwOGxvY3AyZDJGbm9VQU5yeEFJeEhoalJDRWhteStKdGFC?=
 =?utf-8?B?c1JrWFdBeHNnSXMvdStOUlVuTHdQWjJWSjFmcTViUnZUSjdJeXhqdmRYaFRu?=
 =?utf-8?B?UHZvdmdoUHdTb2txVlNDTlpGVjZhdk10RVlaSVJ4MFVIWDdxWXJlelkrRkhU?=
 =?utf-8?B?R1NSbEJqbTJQNEFhVVRKR25tbytJWDQrdnNWTmpaMDhrN291bDA5Rzh2OXFE?=
 =?utf-8?B?MU8vZDVhOWZTd2hQK2ttVU9aemkvZ1B4emhZNnhpaW1BZDljOVVyYmYxTzIw?=
 =?utf-8?B?bmRaK3ZRS0JoTTlpWFNiNStXYjNmZmxIZW1kRGwzdzY5b2V2MVRYUWxaSVZF?=
 =?utf-8?B?dTlCOHZHZXI5eTlPWDFQdkxtVEpzUytEZDhac1Zab3NiRmFQdWsxZjVJa1BM?=
 =?utf-8?B?cVl6c2FKUjFKbndTNk4zQTlwQkpuZUViaCtkc0w1dC9ZbEtHVEE2TktuQVRE?=
 =?utf-8?B?Ui9Lc3lLS0ZKSjE0UmJOT2hRUkFBcU5IVWY1TGtDOTZ5RHBiMHFnOWM0K3Nz?=
 =?utf-8?B?VC9EQk4wdzdpa3Q2djlER2hERFRGSzRwRVNDd3ZRVlBMVGVMRVlsaWh1OUdB?=
 =?utf-8?B?QXlpTzgrY1BvT3M3dVBabnpXRi93TEJNUGdvTmtBa1I4eENGV3hDdk9VUlZy?=
 =?utf-8?B?VkVOemRLclV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUh1U3o0RitCc05JVi9DMk9oaFFNQWRlaDZoN1NuS29qbzhvc2hOYUQzWFpu?=
 =?utf-8?B?eG5VVVpwbFZFTXpWUG52NTNmUVRHdEpjdUNFRzlEOUsveDMvd2RreC95Qm9E?=
 =?utf-8?B?TTJNYVliS01VbUwxWCs0MkdZR3lGRlFURnRaZ1V3ZXYwQU8rQnptMCtmVUM1?=
 =?utf-8?B?MmNHKzRwbGZTZVIvUnRYQUdxYlFFZUZ3ZDM0Y3B0Q00zbHVnSFJ2N0Rnc0xo?=
 =?utf-8?B?eGJiMEtXTXJaRXhwTElmNEhSa3E3enlXZFg5dFZrWGMzTkk5anRCL2Jta2RS?=
 =?utf-8?B?Q0E3TElHSS9xS29LZGRGUEZka0NnUTM2R1BRZXArbkJWbDl5R2NTbjRVY1Vq?=
 =?utf-8?B?SXNROHdwMFlhYis5RUNLaDZWa3lOQUViR2xsMEZGd0JHUlBTeUFvQTdVNGh3?=
 =?utf-8?B?MEtJYXRWdjRzd3JCWDA4OHY3bnR2dHhpYkxTeTkzUFU3VkhQZEdENE80ZG4x?=
 =?utf-8?B?RUJvMThSamt3VE40MW5OYlpBdVBqbkk2S2U3R1Z6eHp6cTVDYm1lQURsL0Er?=
 =?utf-8?B?YU9Zb252eElBR3ZoejhhYUNhVWJiY3dBbW0zWTcvQnR4LzVJSlByOFJkWXdz?=
 =?utf-8?B?Vlk2YWJYSDZLUFZIWnpOVitkbDdkamp5R2xuSTFiSXgzK0x3dGllY2NDeUpY?=
 =?utf-8?B?WUkvY1VNUHljZGlhODI3L3VKWC80TEZjYnRIWDlOS2lQMkhOdjVOeTBJaTM3?=
 =?utf-8?B?SzBUQzd6SXZjYXVrL2tabWtyZmg0NWVMeXpaaFhmcU44VUdOSU1yVk90WklC?=
 =?utf-8?B?Q2VROXZYNGJ6c1IzT0FxM2QrQVc3Mk0yVk0vY3E0K1JBTUtUdjJVVWFNWURa?=
 =?utf-8?B?dnZNWUZiTngxdzBvZTgrRkNLQVBVZVlVcm1tU0hWR0QxNWUweUtlNjhaa1Mw?=
 =?utf-8?B?SW5OQTdndmdraytNblhYN01lZ29FSmhXSFN1VWg0MFJBVDc0S1VXUytxNmtR?=
 =?utf-8?B?MG1VVzVEZHBpU0svc3pSSG42amc3Q0hSNUFzYUlSMmJBY3pNSktmd2pMNWpH?=
 =?utf-8?B?WWxPZVJvaXA5SVE0Ui9wbnhyMThFb1NDNnl4ZWNNaUJlZTVSTEt2YzZTajVz?=
 =?utf-8?B?VGc4bEpnT0NEekJwN1N1WDEwcE5YWU44aDBSSi9CNGlTTi9UVW16TnNpTUxt?=
 =?utf-8?B?bHVLVUl6ejdUSGlqS0JTQXc3MUlPaG5ESjN5eTM5VWxLMDlWdExkMjU4OUc5?=
 =?utf-8?B?by80RlJMNUtHZm5tMDdZeUVoMkZWZ2loYlg5aHBiU2ZDSlFwV2NjOGxTRXB4?=
 =?utf-8?B?eWRuME5BczZIOE9IVHl4cHo1T1A3and2Nm96bGFvN2h4d01LVnNKOFRQTTRV?=
 =?utf-8?B?YjhmUmg1SDkyeUE0dHhwcEdVRWJVTEFUaWlyLzhkUStVWHdVZWlqcEUzUzd5?=
 =?utf-8?B?T0tTNERtZW1LU0N1aFVjeWJKbVBqbHY0cUJiSXVnVFIyVUNXYU5tZVhnNFd4?=
 =?utf-8?B?SmNMRE1oS29XRzAraktEQU9UaEREUndjdGxDNVVrcUFSUHNIcVg0WHlxcFc0?=
 =?utf-8?B?U1ZzdmZBZ0pkU2s0eEM3TTFzcEZvR1VEczAyMmhKOG5WSEUxMjg3Zm1CZURM?=
 =?utf-8?B?Z3BjV1lPT1B2TFI0TTY1bWNxaGlMaGg1N0ZCYTlIWVVUb3pscnpwazlpcWpN?=
 =?utf-8?B?b0VTdTdUaFRtRzRUcHhPOENSRHZLYUNtbExFOU85ckxSTkRCVFNxTWZDRzZl?=
 =?utf-8?B?RkkvS2VJVFh6QmgvY3lZaVFYY013VTB1dUN1cUY3L085cUZoQTFhUEUwQTRa?=
 =?utf-8?B?RHpxTjhvWnZXWUFtVmM3KzRBSUdTTTlxR1NCL1pKVDh2WVVIQ1phQjl6U25L?=
 =?utf-8?B?ZG5xOE5NL2JrZGtZVzFEQ1lJU00wbEZVMkYxbWtCVURjMFJZQXR3Y2xLRjZK?=
 =?utf-8?B?NmNMUEMyWWJIRXZ5MGswR2ZsckJaNFZnWHZ0a3NsT0RTWlkvUTVsNzFrZE4y?=
 =?utf-8?B?ZjVacDFGR0ZjeEdmaWVOMDk3cTc1Q1ZaYjhGeVl5NDFrSExqNEUzMWZHRVVP?=
 =?utf-8?B?dXVrdDhZTzhyUlk0dWJLcGVDbW9PN3ZXN1RNYS9URHF1SEJtSE1KdjBkTlBK?=
 =?utf-8?B?dnV5TFRDYk85S2JSWEZIWHA4SjZIYTJtaHNhUDFHYU9oemN6NU10TWZ1YTQw?=
 =?utf-8?B?QUJGSHlnN1FUMWpsVGUxNmtDVkF4a3hFTld0b2dGVEhrbzNnMDU0eXFORHRu?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e205a3a1-9549-4011-a083-08dd97712469
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:37:15.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxP2IibrK4X2LC451+OtSqwOiD4cPfo1tyOiLk2FmJqlp6Cey+DJAyQThXUbubPmZV4bpchqU95Zw8rqOlRZKQvl6mIZ9/0eetjDO+mRL3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
[..]
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +				   pci_dev->dev.id, dvsec, struct efx_cxl,
> +				   cxlds, false);
> +
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{

So this is empty which means it leaks the cxl_dev_state_create()
allocation, right?

The motivation for the cxl_dev_state_create() macro is so that
you do not need to manage more independently allocated driver objects.
For example, the existing kfree(probe_data) can also free the
cxl_dev_state with a change like below (UNTESTED).

Otherwise, something needs to responsible for freeing 'struct efx_cxl'

-- 8< --
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 112e55b98ed3..0135384c6fa1 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1149,13 +1149,22 @@ static int efx_pci_probe_post_io(struct efx_nic *efx)
 static int efx_pci_probe(struct pci_dev *pci_dev,
 			 const struct pci_device_id *entry)
 {
-	struct efx_probe_data *probe_data, **probe_ptr;
+	struct efx_probe_data *probe_data = NULL, **probe_ptr;
 	struct net_device *net_dev;
 	struct efx_nic *efx;
 	int rc;
 
 	/* Allocate probe data and struct efx_nic */
-	probe_data = kzalloc(sizeof(*probe_data), GFP_KERNEL);
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (dvsec) {
+		cxl = cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					   pci_dev->dev.id, dvsec,
+					   struct efx_probe_data, cxl.cxlds, false);
+		if (cxl)
+			probe_data = container_of(cxl, typeof(*probe_data), cxl.cxlds);
+	} else
+		probe_data = kzalloc(sizeof(*probe_data), GFP_KERNEL);
 	if (!probe_data)
 		return -ENOMEM;
 	probe_data->pci_dev = pci_dev;

