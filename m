Return-Path: <netdev+bounces-200435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEDAE5821
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E967A5281
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30A22FF22;
	Mon, 23 Jun 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlkZ7VHs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B322D785
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722241; cv=fail; b=qDxWZA7UwwpyJHHithWxWhmxMytXYvcIXJJYxFFhGWTqH0Ulp2W7s1NW4roJhg1dFi36BukIDz+/iNg/RvlDlBI4IYYHJay7n0BIPz1FY8abqCvx5iZf24kG85cWbFUZ+1b6pMFD828EszxVeKBNPbHDvd1FOeUDiCo/+2XQrcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722241; c=relaxed/simple;
	bh=KcyVfqkA10AUOE5Wme2EbxUbcAMzrPaopMW0naKtPyY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=layR7R9F2cWCumjlniVbXNwcTYPTyYBSQY8DD8ZJrJwk/ldrFgo+LiL3ripPG6vbLodogNBljk4sPgowatm/dfdBc4bVC90bLWyiq0RNe5Fmj7XwBylFvH7iIB6z3B5VMbZhBg9Zwl9EN1aMlBvnSIsj3gR/DNDNGDn/dkQFg9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlkZ7VHs; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750722240; x=1782258240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KcyVfqkA10AUOE5Wme2EbxUbcAMzrPaopMW0naKtPyY=;
  b=ZlkZ7VHsVQwyuFIGS04n4ZE5oAnNtdZ7AlbDJwgQYk51LAcT7gn1T4+4
   7G5TzCtrbxNE8trJs/WWIPGHR23F6d0QNaIJy+tTnyTtpmH94WB7M+SkB
   3MRCBo9a4rXEmY9CycSP/tcc55HA4iXd0T1BU1nmI0np6aQGNtCHnlk7D
   UMs+mjXEQTuBsXRFFOEayGhT3dZWyKTM0s7m9PsjGyhwZnj+U7f28ToSc
   ubk+dXUwAjKuMTFudNOshLqMNQ260S8FIi2ZfV+VEdV5oLIGGxD+QliKx
   OHAcKs+VSCO1AlKI9bPGn/s+ubWPYw6dwwEdNKT2qw+IIIUmafEIlko4s
   Q==;
X-CSE-ConnectionGUID: KA4Al908RUqu9C3tz4g1+Q==
X-CSE-MsgGUID: dKEmrlfmQzeZ1v7LLvrylQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52884136"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52884136"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:43:58 -0700
X-CSE-ConnectionGUID: M0sBgfzqRK6xf+fBNli3oQ==
X-CSE-MsgGUID: XjoXetGAQ8aRHWe8av4hjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152251435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:43:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:43:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 16:43:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:43:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWzdIB0Ozdl/lznZKVOg651Ui5/VLPhk4GmtiaIU9u/liYHkaFsI4AaiP2qVJEZZ31wVrUwXUdZljc+ocPnl2bRnhMo+jTOnNKmPy9jEZlOuATId+WZfOE0NLHVIl5cExU07rCP1ObHYP9OQcikTMMr278TK0oD7JijJGnY7xss7QilQatzu2GNVfBw6Qj9I4Sh0X47Q48YtwpvXsLvJ1qguxDFTxRfUFxRnZOnXSHY0m+q37N29KY+AQoaXHop2xuuRdwTIG1CvidDuBKxc9vrS/jHIBvCi9ibiLJWR2d0zGDz6G4GKwlpR9M+K2CCy961EwYEqNYjgAWfP2BVu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1JxPxGPdnDZNPSQYOtNV3U9Jr5OJ4pP2q2qgHqKJPc=;
 b=PUaA2SaKvgwRDGBWrOboEBcNhqtcm7mM9oV9bEdrplaXfJRCcNbH0MAdupnt85DGrqKkIJSms5ytICU46/tY0zc4LLtaayX1c9pPhH6JMGdrXbyZXfEpFKmNJDq8FwfQdS1qLBZUTXztNUi3EMU9cVZeasqaxIjVzbAZ6mwu1+sF3s2kNkQGcs/H1DbmVFBfjrsPfrPJX01Bhyv2SIFYl6DFmkcGazlgFFpCpbFu1M++mnDX7T7GcR2nJlWI8MZgGJpzSSuBbNqNrqYLhGJ1LypUnwze3+xdwlx1qlU64yogSunO/sdYntjZdDCResYP98cJiRyP+ymUg/J2K6sGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Mon, 23 Jun
 2025 23:43:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 23:43:26 +0000
Message-ID: <aedd91ee-e84b-4d83-9feb-f87954dffb17@intel.com>
Date: Mon, 23 Jun 2025 16:43:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] ice: add ICE_READ/WRITE_CGU_REG_OR_DIE
 helpers
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Karol Kolacinski
	<karol.kolacinski@intel.com>, <przemyslaw.kitszel@intel.com>,
	<richardcochran@gmail.com>, Michal Kubiak <michal.kubiak@intel.com>, "Milena
 Olech" <milena.olech@intel.com>, Rinitha S <sx.rinitha@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
 <20250618174231.3100231-8-anthony.l.nguyen@intel.com>
 <20250621082321.724b65dd@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250621082321.724b65dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9e3ae1-0915-4d3b-8380-08ddb2afbffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzBlTDJudy9HTWYwcFh0T0FwYlI1RHVYdG5wQlo1dmkweExuOEcyTTQ5bFBm?=
 =?utf-8?B?ajBjdGJ5QlYvVFo1MkpFQlZJRHAraVczS3B5cDR4b3dPNHRMVFhLZnY5SHNL?=
 =?utf-8?B?YnE5eEc0SURNSms3UWhuTHIxTVNySnhBZTg2dWl1VDZnT1p2NGpXOTk1bGF6?=
 =?utf-8?B?VVdkMG1EZEwzMXFNWk02bHQ0TFJadGNVbkRnSGFhbzVuTnlPaE1Pa1hXdWx2?=
 =?utf-8?B?UlpMaE1iM0lKbnhMZzdBSHBBSEVINzRaOTlZZ1UvOVY5RU82WXZaMTgvYk45?=
 =?utf-8?B?R1VMU3Z2TlBObWN1VFlESTE5dlR6RmR1UGJTdGxoR0dRSS95bm8zSVFnSkFt?=
 =?utf-8?B?enhnQjB4UjNXK0Jmd2VjYnRJRUt2Wkh2Nnp5ODA0ODZPZW1ndVZQa3cxWUow?=
 =?utf-8?B?QjlGU0xrN3dZbm5RYmxNb3c0VWtpSXlmYVhDMS8yZEtPYzNvbXJiN3A2NlFU?=
 =?utf-8?B?VnppZkkwTlB6SjZjWEI3QzZ1OUFKa0N2R3ZQTC9hWVlWRXN4UVZDaVEza3dE?=
 =?utf-8?B?V2pTcWt0SlBaLytjMWFYQ29xN29wQjJQeHhEeXJVd0tXUEdtaWlYNzlXUzd6?=
 =?utf-8?B?VTN1bUhHQzZzMlY1RXpHNDEwZFFIRzRYRlVlUFpkSzRHYzQyZDd4a2VtWThE?=
 =?utf-8?B?R3hzcnRlTFMrRFgwNzJOWDl6RmZDczVMazcvOGVCdnJvWlUwYXBxZ2tSUndq?=
 =?utf-8?B?RFhTZ3RRdXFnUEY1Y3NMQ3lWRXhFemFyR1NXdU5QZTc4QWkydm1DRlF2dGd4?=
 =?utf-8?B?ZkVYazhGcDZ0OGk0L0xKd0NwLzlJaklLeVNzNktkdnlRZW5UdU83NjMxSGU1?=
 =?utf-8?B?SkxVTG91aVFFQlhBY3JUbHUyL1MyRE1ScGR6TVJ6bG1BTGR2WG8vY2RUNnhY?=
 =?utf-8?B?TlRzWm5ZTmpTYnpVQ09BaFhiM3hwVkRnaUdCRlUvdU9KM09SamVxTnFEUFdP?=
 =?utf-8?B?UWU2V3p5K2dJb1psWHlSbkVFeGh0UHdpbWRhWk1sNkxaVGM2cjlSNTNiY2xy?=
 =?utf-8?B?UUtqNzB5ckxGM1hGbmhPNzFRRjdRNVZMdHkrTG52NEtoTnB3MlJ5b1BqTWxL?=
 =?utf-8?B?VXIrZjM3KzEyOUdWcU85ODYrMVZib01IUVJINWIzZUdhWm9rd3JZb3pVaHgw?=
 =?utf-8?B?MjNxK1kvMk1xRmFreEc1M1ZhV2RnVVpVZlFMT00xUmgwRFZ6MGh4aW5sZ1M2?=
 =?utf-8?B?S2haQ2JiUGFiYkpBelJGWVgwMEVjMUhSNDJvQmYrMkk3T0VCOUJzbndlR3Ns?=
 =?utf-8?B?eGNORnpEUU1MeEVvUzUxVGZtUWo1dGoybjRQM2pGUzRRdGttK2daK3ExeXBN?=
 =?utf-8?B?RjJLK3VyU0xCS3dEcjNzRkVoWkxHVllZdEhXd0ViN1YrUjNwbGpLWGpVQjBB?=
 =?utf-8?B?blg2ZkludktROEJCQUswVGgwbEJMaVdLQldxd1ZHcFN1aEZ4RWxzcnJraDRD?=
 =?utf-8?B?RWJMWndvZzNBbStvd1FxelhncnhZdURqakxnZjFHQjZhbjlqdmE1dkF4KzI4?=
 =?utf-8?B?VXlVNjdvUExUZnZUVWUzbm16UXpxMW5CMFNuL2pHQitEUWZUaGs2UTFDUk83?=
 =?utf-8?B?a09NUUF4YWo4RXg3bVVnMUFsYWVuMjBzaE9nTDNIclgzelg5R1Y3VVQ3Y00v?=
 =?utf-8?B?YldBT3dhUUZjcDFWZHhJcnEyUmZheElxd3VWZlpySlhSVlI3dVBOckJpUHNx?=
 =?utf-8?B?UVlVbGwvbzU2SjdielRCa3prK2Z5elduQXZUZlVobk1jNVhXZFpuWTVpV0FX?=
 =?utf-8?B?YTJUSzBHczVvbWNnUDNmK1JWZHgvQjJSakxmeXc2MldjcWFxUm41cVVhS2R4?=
 =?utf-8?B?QXFpaExHejRlUUttejU1eXNPMkYwajF6OTV0V3h0T3dsclp0Ly9uWjNIelA2?=
 =?utf-8?B?eG1sb2l2MmdraDdBWjBTUmQvd0pzdzZQNkdDRC9nWUxRSU5raTdxTXZZNUpB?=
 =?utf-8?Q?S+8rvYtrs+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1nYStHYVZ3M3VGTU11TVNJVGowc01sR24vVnlsVjMzSmR2YW9ET3RlU0dl?=
 =?utf-8?B?aldqV1EzTHRkMWtkSVBRcy9zSVdMeTZWdGdEakRRQVV6YVk0RFJ5UDg2WGRE?=
 =?utf-8?B?YVJUSVJOQm5qdDVLclYrbUdYaHp5ZTdUT3gyUnZjQ3NJY21LV051dkQwUDJR?=
 =?utf-8?B?ZEFWcWdTeVU5b29mcUI1emtSWVZjVjdaT1pzcDlKVEtmNWdNZjkxYVV5WW8y?=
 =?utf-8?B?MzEwcjFlUUpQZXF6eUFTRTRZSlBMd3FKb0hoSjBndzRJM092bDFUUFdjMlBm?=
 =?utf-8?B?dkpwODNsWVdIc3hKZWRsc1hpV2JBT1VYM0lCN0ZVdFhpVk1zYzVNcWExNktM?=
 =?utf-8?B?S05qakxPb0hRa1hRSE9Vd2U4RXlZa2tWcEJyWm9nRjVjSUk0SWdqTENjcTgy?=
 =?utf-8?B?RXJJM1pKSnIvTkJXQW9ZOTNkM2hmeWhMRHhpUWswVUEyMWFwbG4wNmtqWDVJ?=
 =?utf-8?B?b3BFQjF6YmdwdnFTZERlZXFlVEEzckYzcFNnMmpnOTFua0k2RFUraWhyVmt6?=
 =?utf-8?B?OUV1b3lQU1VHdy9xTHU3SXdtQUZaUU5WdFBIVW5Ob0luaE9FZlgxVDRlN0hR?=
 =?utf-8?B?Vi9NR3c1QWMzZGUyWXM2VFBCSG9DeTZDYzVSRUtXYmhLdmhVVVkwc1FKRGRL?=
 =?utf-8?B?eURXd3BxZGxWMTkwVk1WTjlGb2t5YjVvUXM0dm13T1J5SGw2S1RMV2F6TU5o?=
 =?utf-8?B?bmtRQjJKRyt5R083N2dJaTdCRDRyV3BwQ1p1Y0NWNUVoNGlOY1hMdHZYL0s4?=
 =?utf-8?B?U09QWFBxNi9UaUtXTWhPdE1venF6Ni95SEdMNzY4YTUvckxOY213anRPenlq?=
 =?utf-8?B?VGR0dW1JbEo3RkZ0dUxOYkNYZFExaGRCSzRlbWxOQ1pCN0hUZzE2dTZzWW9y?=
 =?utf-8?B?bnhuazl1eDYxNERnWW0vc0xpTXhsaXNlUjNkY3ZnWEowR2J4NTFkL1BLRXdz?=
 =?utf-8?B?dnN5aStUb0xkL1luRTFKN1VqUU53V3dsbjRodE1jQ2hDNUhkdmhuN3dpWXJL?=
 =?utf-8?B?ZkdLYTRxTmM0Yk5HNFRqYThoTWs2MUZZS28zbU82SWJEUXFUdlc3ZGtmZmwx?=
 =?utf-8?B?aVNXWXRla0dDbXR0TElHaTNJcmhzKzgvd2hBRmtnYndDZktPbEFnL0lDRjR6?=
 =?utf-8?B?a0VjLzEySHBDby9lSVRxSnF4VHFYWW5wcndMQzFvSmo4cmx0RVJURWh1Z2VH?=
 =?utf-8?B?VXJ3QlQ0MTlObWhjSktmWVN2K3BlOXg4QmxtbU11YTNQTkEwRDhMVXhiTG1j?=
 =?utf-8?B?cGlndFRCbTZ2bExNRUtaclJJcHpKSWhFRVg2MjRkQXNtRUNRUlBCZnZCenVX?=
 =?utf-8?B?cHVRODVTU0N3MVAwRU43VlUybFYybnVzclFKbkZ0c3lPZ2JDYytJcEpGNmd0?=
 =?utf-8?B?UjZ2YzllV0NLU0JnSTQ1ZzJzMHhOWVFTaTJucVA3NDdEZWFUV1c5dHp5clIr?=
 =?utf-8?B?bVF6a29kTTRGZzJNMXIyYTZMMDYvdFM3RHZqdGRZL2lKTHBuZ2ZIRFV5YWV0?=
 =?utf-8?B?dDdYbFBxNnNEc29YVkp6Y09rMnFYM0taQ21rSTVBVUpkUnUvK1lSSVFQSVJp?=
 =?utf-8?B?Y3ZkRFozYXdMSHVnc3BWNXhNWlBLTnpwQy9pbVhqR2RZWktUT0VHSUY4UGM1?=
 =?utf-8?B?M3JVcks3K1BMNDVKb3J3NzlJVUd2QXJuRzNhZVY2WmgyWWVMVWpIWFRjTjdG?=
 =?utf-8?B?QTJzSE51Z0dDU2ZJajBlakNnZXN2bGRJK1JiblpwTlg0RGwzUEdxT2h1T3dI?=
 =?utf-8?B?elJqREFtQnJuM25KSUgvbFl5QWpuU21jdkg2YXFveHN1Ukl2K2prN2N5VTdt?=
 =?utf-8?B?eUtKdmFmNDlQTnVSV05IMm82TEFIREUxakVwdmFHeDVGbUZnbkZvWDdnVWNy?=
 =?utf-8?B?SUVsOEVaYUdNWlAyWXFibGxyYXRrR2M4TXZHK0puY2orTWhQV1RydTZiRk1R?=
 =?utf-8?B?WFBQeXBhTHY4dUx2Ymg4NlRNS1F4bWFScUZxc1hjMWk5UDJ1djhneDBWeVVW?=
 =?utf-8?B?K1J3by9HZVM4QUdVOUhqd3cvOXcvQWtNUWpRcEJ0VHcwKzVkd2RVbmlwQzVK?=
 =?utf-8?B?RVJoMm5tQ1cxdXlYUnJZanVQcjc2czkxMFRqWG1iWFdCUUozcVVHNUJnVkU3?=
 =?utf-8?B?dmUvMmRvYnZ4SDM3NEtWK1N4YlBtT3R5bVk5bDJGSE8weVlYQXBKNElPTGkz?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9e3ae1-0915-4d3b-8380-08ddb2afbffc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 23:43:26.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6jM0LlIBRosb29xwd4uGc4xG4YQj1HqFyY5eR43FpSQIt5ab17nN4ksWhn2bec94P3f4nzrmHssDgiEBcd7Vs6Z/1ckfg1lIkbGNe0/0MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com



On 6/21/2025 8:23 AM, Jakub Kicinski wrote:
> On Wed, 18 Jun 2025 10:42:19 -0700 Tony Nguyen wrote:
>> +#define ICE_READ_CGU_REG_OR_DIE(hw, addr, val)                     \
>> +	do {                                                       \
>> +		int __err = ice_read_cgu_reg((hw), (addr), (val)); \
>> +								   \
>> +		if (__err)                                         \
>> +			return __err;                              \
>> +	} while (0)
>>  int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val);
>> +#define ICE_WRITE_CGU_REG_OR_DIE(hw, addr, val)                     \
>> +	do {                                                        \
>> +		int __err = ice_write_cgu_reg((hw), (addr), (val)); \
>> +								    \
>> +		if (__err)                                          \
>> +			return __err;                               \
>> +	} while (0)
> 
> Quoting documentation:
> 
>   12) Macros, Enums and RTL
>   -------------------------
>   
> [...]
> 
>   Things to avoid when using macros:
>   
>   1) macros that affect control flow:
>   
>   .. code-block:: c
>   
>   	#define FOO(x)					\
>   		do {					\
>   			if (blah(x) < 0)		\
>   				return -EBUGGERED;	\
>   		} while (0)
>   
>   is a **very** bad idea.  It looks like a function call but exits the ``calling``
>   function; don't break the internal parsers of those who will read the code.
>   
> See: https://www.kernel.org/doc/html/next/process/coding-style.html#macros-enums-and-rtl

I will rework the remaining patches to avoid this.

Thanks,
Jake

