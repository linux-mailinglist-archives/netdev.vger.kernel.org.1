Return-Path: <netdev+bounces-254940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FqoH+ble2n8JAIAu9opvQ
	(envelope-from <netdev+bounces-254940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28576B58E1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E2B13004D2D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDE36C5B6;
	Thu, 29 Jan 2026 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPujSDPt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F036C58B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727458; cv=fail; b=Xj3VRVMjqMRfRuZH+YXksO7KS8MmwSfQPwXT9CJckqfCMZwgRo+7cLNV+sCTWtJmIpg8KNqihB4tA9q48qKFwMpG8iPHGU6krRFGMn2HAjREJQB/vI1CQaWwUt1Gtyjy01YG+XIOpAbt786JvkREnjVhtfkggpKCL9YyZawk98Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727458; c=relaxed/simple;
	bh=vTzcen49+LHhbf51qbUCVHNl3NcQkTyd7ZPsOu6xoio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CSSw7eNdQ6OqGzWfiFaCdQvmJsPsMECDNRTtQKdfcvrW2E6DtabMYnKHwAmZaguel7J6ls0WvWCukB+GgXeFAVmnrimYu4/tsMkKeZ9FajJqJRhRObQsoRLnxWsDizjRGT8Zhzu+WoMvj+zQTS2LSWu42BA+OevT29O47eH+WZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPujSDPt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769727457; x=1801263457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vTzcen49+LHhbf51qbUCVHNl3NcQkTyd7ZPsOu6xoio=;
  b=lPujSDPt6h8NmwakQg/FVn7hMeNE4yb30ZuZirXA07vsxpgx4F083lRz
   11//vRtsmvefQF6oyr10oS4P3CANUZmwSQO+5+YY0h0hSQdtx1gN/R0xk
   0l6whtsj45wrSMQh6KW9fF0v1dXNWV5yqk3kzeG464yzeMWPKI3SVhjG7
   x5XpySmhLIH/qXndbMx26RH5SXkcaFNxfQs+JQHZXughPz2KkfxGo6QuY
   yE2Qll1wHaSuCbjO1CBSTqjIUklK15frKn5z0uTv1o3TEiitZs5ij+gzB
   d3uhNdaFSiDrvrO+x3gn1h5TI56JBSx5Jm8tguy2wqYlYfLGWP/Shk0ho
   w==;
X-CSE-ConnectionGUID: dOQGMRsmQg6UIs/pddGmVA==
X-CSE-MsgGUID: jviqQZQnSf2si4QuX9I+dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71017184"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="71017184"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:57:37 -0800
X-CSE-ConnectionGUID: V9Uc59XPQwuZXx1HWRA4wA==
X-CSE-MsgGUID: Bn3MvdJ1TNyC5l12/ZFlRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="239423545"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:57:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 14:57:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 14:57:36 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 14:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiTeF6842TfhfouYAiOux1Wtz48WGf2X2OU1i2YB8cIEyWN4b+L20d7PXt9OufBdJAiOO+b5TxngxDoEhvC3tnmmZE7D4Xvn05J7NsP2tFo6rVjy4+UgsU2Hh6gnQ8b/mOYHhijwreonM5lD8vRlnmDrRhFSUojvcQJRipxCWVxRtUNyOw9aW+yzl8zzX5hbLCS1ZGLgjV2CxFHFQdY8Vcb4LPxJ/cTufKeI5SKSJs/IzR7nDwPNf97SV6JgYOnxCbnIV9Rq5GWCCxvnHqdikHooCessJpTgdsmJ3thHabI0M+pPm6Emhs+i9QfvpUBWOKeUUup5C+xxXvvHOySsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBKjmsBwSOq2nuoMPkGEcioSBY7cBU++Wwpf8hmFtxI=;
 b=IMxrgCNvTMe+esuedhSpqM8wolx0lLRoyiWKOVo55CLqEZydAzXfrkScU3eFEJ8RSw6gyWxcJXc0IOXAsx3UO/naYN/MMd/Wn7UY5wDZXmnS88+le9QWMjbve/A5PN3GsM+yUQfSuvokhEhI47HbRHy+7Ow37fvao0+30zVxKjuPEEZb+00XH9IcfGhdwCVX+4xijp5afrutt3iCLH/6TKzSjbSi6cUHeHL3Y8aDv3TWC02gGWKVeTkcyusVL87F0pax5JRPKUkk6egFk4TYkbxtQ+iqR3B2vNKd6LYtAUDmx+30EMgkyj5oK++lSpovBBCAd02HACcff4D506i+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6405.namprd11.prod.outlook.com (2603:10b6:8:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 22:57:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 22:57:32 +0000
Message-ID: <1cdc323a-543c-4406-87f0-5f829370dda8@intel.com>
Date: Thu, 29 Jan 2026 14:57:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2] amd-xgbe: add support for rx alignment errors
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>
References: <20260129111520.1567097-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260129111520.1567097-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad97c74-13dd-45a2-926d-08de5f89c96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDB6NytJN1RMNGR0TWEvdjV5cm1ZSTd6aWM0L2ZHQ1Z6USsrYzhDZmpMNVBk?=
 =?utf-8?B?a1RLNHVKd0crZWZHSlZJc084eXl4SVhxNWoxYnRpUVh5ekc5N3hBQlBMdEJZ?=
 =?utf-8?B?U3ZpK0VYQXhrcks0emptM3djd1Zwa21lWWlKS3RaakZmOTVwQ0c4cEplWEln?=
 =?utf-8?B?TTluVmRsN2lqdWU2RTNMZ21YUjFidkRuaTdreUtDR3dNVk5DaFFIc3hWWFNa?=
 =?utf-8?B?WFV3SGg0aU9kTVFEaFlxWVp4VXdDMXlib25hcndHS1BrdnhxVTU3R3lCQjgx?=
 =?utf-8?B?TFF2emI1SDQ3UlJKUG4xL2c2NjlGMVZBejJETXZaaTdsbnNyTTZpZ1grYWI1?=
 =?utf-8?B?UWRKaE9sOE91aE5zaStFMnpWUDhPb04rQ1ZjN2NBSmgySzNXT29YbmhpSW96?=
 =?utf-8?B?aVhPKzRSUmdGdXFYaHFObjk2MU9OODBTcHNBdkRxQjE1bUNYQjREREs0amg4?=
 =?utf-8?B?OTBtajNRdWhibTN2YzdpaVVXWGlMWlhWYklCMkZ1bmVVTUlId1M4aXRZNHo1?=
 =?utf-8?B?TmRuMDI4Y2JxNDdsNk0wWmN5N21UL1UrTk9OdWRyYzRPYnRvMjRlb21Hb2ZT?=
 =?utf-8?B?elcyNktYV0VSdnJWMnFQSE1xTEdrbnV3WGhSd0RwZWxFM0ZqR2hjRFBMK3Fw?=
 =?utf-8?B?MGF6ZXRRT1o0aXIvZXhKWE1tTHQ1YS9mRThPZHdOd0dpd1VvQ2dCSFZvRGNW?=
 =?utf-8?B?b2EzTUxnaldWL3UxNWp1andtUDFhZmVWMURVZDdQWEhjZXlhV3hqSEs3eFk3?=
 =?utf-8?B?aTU1WURvM2g1bXZyVCtscVVjMHhVWE9rclJGcVpWRjNMMkhMUUlKTWMxM3lZ?=
 =?utf-8?B?VkpwaVZLYk5WRTBIREhHU0F4dDJzYVZSYzdzME5lT1NwUW5MM3lMdktySEJu?=
 =?utf-8?B?SlpndGhPWjlqZmY5OFdTNE1sSU1qSTFoRHN6cW5wQVQzQVBGUjRGQit1ME5W?=
 =?utf-8?B?S0FvWG9yMzZRYjlLNDVNeGtJYzMyQkZZeFVoU3ppL0c0cGpWdFBnek00Q01O?=
 =?utf-8?B?RGhaS3h2Q1Bmdk91anlETlI4cVVMNzV4dTFKVTh4MS9KRlZvOFpJZG9SWEJ5?=
 =?utf-8?B?ZHBhWnR2a01seGxSQmxydEllYWx5K1g1L2o3UHZSSUJKUGh1SHIrY2s3cUJX?=
 =?utf-8?B?THlqdjBtemFSVW94cDk3MEtrOTY3M3dWQS9XVnlYRUVXRkJsSmt6SkhKcmRM?=
 =?utf-8?B?TXlTZkpNQUlKaDFxUkNuQ2F1K1hLc3dIa3N5UUt5RE94a1NCZ0VzVHVrd1Ez?=
 =?utf-8?B?TXhwNEVpMjA0YVE2K0RCZWwvQjVsV0RWdXRSWFdHUlZnZzVKbVlVNzI4aTRR?=
 =?utf-8?B?K2hkdy9KVXU5d1d3b21MKyt0WkJOOTNrZzZQREtTUnBWRTc2bExsYVpmQmh2?=
 =?utf-8?B?SGdwSFlrMFg5K0htbnliYTJKVVBtaDl5SUk2U1Y1QnoyMkpFNDhkMWZCQVhJ?=
 =?utf-8?B?THBzcGtEblQwbkpxOHBwa01vNm1wUzV2SlBkQ1p3dkw1Rjh2QjdzTDhnOWo0?=
 =?utf-8?B?c095ZFIwVU1wZlZncjNTVnpKdlRDY2RRY2g5dXFnRW1TMXhISysvbVV1cWVw?=
 =?utf-8?B?cHVnbnZnY2dkTWY4SFVxUXZnZ0hZNjNsOHVRUjh1cEZtSG9PSldtUFVMNVZv?=
 =?utf-8?B?VGVaVG9xL2htdU1CZk5OWVBaL0N6SC9XbktRK0hzdXZlWGdUYS9UQk1hWDZo?=
 =?utf-8?B?VHI5TW5veTgwdmNJb285M1hOb2U1Uyt6bkR1R1BuejczWEp3TlJiK09HaDVK?=
 =?utf-8?B?b2ttb2xxRmd5Y0l2MEVvK0dkY0RwTHlxWjJPWDVzdDkrM0NWZ29QV3dOelZr?=
 =?utf-8?B?REVyME1keFgybGtRcFIvMitkNXFxZ1JPajhuZVFscmpXcFNvMHMxZ05lMlEr?=
 =?utf-8?B?bXVTN1hQWU91dXRrWWExdFNtZjZ6bkVqT3JMUWZxRjJWRlFKcFVpa25SSEhC?=
 =?utf-8?B?YnhTTWVFZ3p6RkN2SWpYcGxjb0NMbjJFZUtXdHorWkJDVHVmTHpiNWFyanBD?=
 =?utf-8?B?Slh3UVU0NSs4YmtJcm03c3VTN0gyTGt3cEdpK09BcVg5c0k2WHQ4RE1ISnhG?=
 =?utf-8?B?MUhqZUdmU2dROHE5c3dLQlJpTUV6RG9iZFhrZzBkQmU2MHN2WDlHMnZZSTJB?=
 =?utf-8?Q?60jA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXVYN0pkTUx0M0Vnb0JaSlFnT3hWV1lxK1dFNFRCSFk3eHhXenVqWlRIVnB3?=
 =?utf-8?B?cWtodFJqMWZsN2NIMXNUK1NvR3FQVmRKdEZ2ZVNGTE9mODZXaVZnN2hCNDBj?=
 =?utf-8?B?ZS82Zk5UTTJMN25KQVRVSXFuVUFOeVlkQk92NFUvVFRwSklWV1JFc3VQN3VF?=
 =?utf-8?B?bkZ5TktEamhna21ZTDJLeXAvcDBudFExTm16TTh2a1hNS0kxQzlNb2FuVVZi?=
 =?utf-8?B?ODBXK1RvY2l0VDJHTktBY1dOU01GcVFYRTBiclhCM2FMMmU1L1ZXQ2VBMWRM?=
 =?utf-8?B?UlhCK2lWNnRDbi92ZHlhcHlJNkZ2THN0STA0UGZMWk80b0gyWWhtY21tcCtC?=
 =?utf-8?B?blJ5dkF2R1ZIVXJSZ0lGd21vb2N0dG55WGU1Y1JRU0l4dElaZTVvWmhQaGlO?=
 =?utf-8?B?NG92Tk5lUGM5SVZsOWN4SFFmcktZd3Q3Y3JTck50d3J4RUVQZFEvUzdmTDRI?=
 =?utf-8?B?MjlmNk9nZjRwMlllNkE3R1liSWxKcDVCemIvUHVBckoyNzA1Vm8rbkw3ZEJx?=
 =?utf-8?B?US96YUM2dXY5QWJ4ejcxR0IwRmVlL2JlOXNaRFhuUVp4NWVjZk9MTmw3dmxt?=
 =?utf-8?B?RmN1TVVndTg0NFZrWkxUMGxoN0lpWnJpY1ZlTmluTTRldWVjMy9lLzBPN3Ns?=
 =?utf-8?B?TTJ5STc0YTRXSWFVS1RVeHBzN1o5SVlxZTF5Vm1TMVpZTkNGR0pjVTJEWTJ4?=
 =?utf-8?B?VDIyakhITm1VMWV1QWJPUzFsR0plVTlKTnVBV3lkRTRrbkMvUHhLdHBKZGhT?=
 =?utf-8?B?NmxZOHFMcDhrczk4ZDl4OTlGL3dmbWRNV2lTZnlmbkpva3BUUWZ6cCtMWi9S?=
 =?utf-8?B?M1BFRUl0K2pGdTRwRlg3Qk5nQ1pxTHg0czZuaElhMC9lTWxVUUNIQ21YSE5l?=
 =?utf-8?B?TTQ3SHZxWkhXRTM4K3RKampWV2Y1Mi9lRllGUXFaVE9VdHBHZWQ0ZmpVVko4?=
 =?utf-8?B?WmVCQnhpZ3QwdE5OVTN3UENza1hHMERxUEc1TE12WDVyK3BOQzR6QlFHNnJk?=
 =?utf-8?B?TnRJVEJhclhIQkJORjVwRXVyR2U5MXBGRzZtMnRRRnFLZ1c5cG5reFJQSURv?=
 =?utf-8?B?d2VOUE5sNUtBTzVCN2dxV3VzWjhCaG1TNXN6QmFpOUxoZHRlZWtnRHQ1SFdx?=
 =?utf-8?B?VkpYcFlpbjVxUjdEYzdtZm8yQ3lDcTYrWkNyajh0SHI3Vk5zQ2RHTEtFU0ZO?=
 =?utf-8?B?WkM3SG9oM2FBY2YrUWE2djZHQ0M1RVNtTERrTEh2VyttTlpMdUUyUDJER1NN?=
 =?utf-8?B?VmsweGd5TVJ5aEthN3NEL0ExbTlVM2NIYi9FWDZNZGpySW1vcDBvUnhzbFlt?=
 =?utf-8?B?d1JuZ2czbEhvYTl1N05CSUZ6NlZIMittZHBZVE9wUGVEcDBFRkcxcXByZmRn?=
 =?utf-8?B?OHdFcHFHa1lueTlXalVHQzFQRVdKbG81K0pRU3gyc0JWOFl6VU5Scld4TjFI?=
 =?utf-8?B?bjRTZ2V0OXpiS0xuWGVUaVAyTndvRldzeUwxS3ExcnRJbE9Qb25kM0xBZ3p3?=
 =?utf-8?B?NHZVbGpINzNaWDJoWW01NEtUcXJ2UGNMd3dNQjhuVzA3WTdML0ZpeXJXMVVt?=
 =?utf-8?B?WDFFLzJrSS9vZ3U0RXliNGJaREVjV29QdlpRMGxucWdFeE1qaVU0T0hJV2Fo?=
 =?utf-8?B?ZFM2VGdYOFdmb2RYUmwvRTV1MVA3N2NIcERQRXMxbGJrWTJUWlRESWR4T2FD?=
 =?utf-8?B?RzRCSlhpb1lnK2xYRW9kR2FVWThWa0JjdXJwUkxadElNaFkyRlRiNUsrbjZ0?=
 =?utf-8?B?aFR6NzJ1THhicjJXZjNac0JES3BVVWVsWnhIYS9GaTFoa0dqLy93MTljRklM?=
 =?utf-8?B?R296eUVkU0NjbFVsMUQ1cExpRkJzb3FNRFk4dlQxUzJ2TjA1NnNhcndDamVw?=
 =?utf-8?B?dTE5Vk1nUU83ZTkvallPdTJadElqZUpBWlN2SStTR2VsdlBTRENSV0pmUG1B?=
 =?utf-8?B?N2orNUVxTzNaM0hCQXB5MDFUckpzRUE1c05lNVdLN2dxMm5hYmVKcUV0K3Vh?=
 =?utf-8?B?WEMrY2doYjYzSUlXUkE1Sk5sbzhKTGFMWGxDR1duNkFoVDl0TFcza1VGSXRv?=
 =?utf-8?B?czZoemkycXJvZEFqR3U5amF3ejlSallhWC9BVm1NUTY2Vi9RNHBnajBtc0h4?=
 =?utf-8?B?eGV3UEE2SmE2c2sydnY2dThUUWRmSmtUUkhtODVFMXRnZW1ibTZUZVhPNHVD?=
 =?utf-8?B?Q2wrZkwwMG5BbWhrNURpb1VTbFNSamxPb0tnV1ZzMzFXUExiZXpPcG12ZGV5?=
 =?utf-8?B?Q3hQNkNjcUp5eTBDL0tnMlpmbU1rYkhzUVBwWExuS05IcXlQRGUyT2EwVU1I?=
 =?utf-8?B?RndGWTJJMXZhQnJkQ2tZR1Rhd0xjU0E1MFdyRkU0NzZObG9neFNuTFlHMjht?=
 =?utf-8?Q?Ig8aDqJ2Yhu6AMIc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad97c74-13dd-45a2-926d-08de5f89c96f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 22:57:32.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkbggJF3ISeyz/7UvzPAlC1geiVOP5ELrNp9g154QxMy4zQqqkKBHHX3OJylL6sa34P0mxO9uWYap6+p6SVW4NOAd2/E1KeYPGX1ToGMLHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6405
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254940-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,amd.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 28576B58E1
X-Rspamd-Action: no action



On 1/29/2026 3:15 AM, Raju Rangoju wrote:
> Add the support to read the rx alignment errors and update
> them in the standard rtnl_link_stats64 structure.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v1:
>   - skip the duplicate instance of rx_length_errors
> 
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

