Return-Path: <netdev+bounces-157733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFDA0B6CE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F11889C50
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2819D22AE48;
	Mon, 13 Jan 2025 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+I0+EHm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF302045B6
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771107; cv=fail; b=UeYC4ZM9xoxjGdNwcM7C9XlVa/BspuNbMIkW2drUARb8GNdCADXEZbUx8gx8bdQRsC7VurNo263kMWhqt2G7/Z+zo6tkJFw54F1ixhluCPYTmuVDVt8P22vOs20NVa2hHWpPCQva/s3Hsx/Qr8A9PkoB6BdWUPjfjK5wvubGxeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771107; c=relaxed/simple;
	bh=O7Ljru6+VUVCBwFvdnxGtjjEX4Uh9YO7DwujkS0cZ/U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGlesPu2cVmVFluoRmH3TT3UGv2Ep7H22CAt4cVgN22yAuafiC7m7OGLqiPXgC3QySg+WvPjC0sXkGv2UIExicM7ZFjzJec7AdoD4LsRCNu+9bhIB2eL9d7J1H0QFyYdk5oAuLHmIxOhEOLhmaSCOpub02m8FJ4pLGqvF1BoWoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+I0+EHm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736771105; x=1768307105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O7Ljru6+VUVCBwFvdnxGtjjEX4Uh9YO7DwujkS0cZ/U=;
  b=d+I0+EHmYO39XXREE1kLOT5NsBkU0yQ0uTkPgMbohlPSWlXCxKEH9QOl
   cb7673F8859BzkLabEdsprkkoeB4VcQmrQj/jRQd5Pln2tjXJsvX8Kj4/
   WSuAu0fFi86j4eHYrGsSsPYQZS0XMG4N1GmGTB4ACnE9VCpjTxziTAQ6d
   66V9eLZNxSOBYut4TSzoiAFAXrYyFYV6QxFceeMNFKtLv8L0tqA/PUw4+
   qIYcFRc7PKxVF5loSuCPUnhetZclRFJRVkWjfUKTYMF4AMSBBC03JUVrz
   iJeK7pTosIQHJY3MdZwWDHByyJXty7d/7Iv4C6j8/Z9ugXtzuvjsvrTzC
   A==;
X-CSE-ConnectionGUID: UZEGR2FLRVunWtpKaGe18w==
X-CSE-MsgGUID: jMw3NDPpRx6CyumQ+M8AWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37055371"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37055371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:25:05 -0800
X-CSE-ConnectionGUID: 5Cd9Zh0KQwGwxncZPy75Cg==
X-CSE-MsgGUID: HOoKhB6ITSeJ1XFaJ1fA6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141748217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 04:25:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 04:25:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 04:25:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 04:25:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcDL7lh1iR3HfwCSFXCqajo4+mqnemMJ4A3V0YdvkJZoifdsQuko3/Q+YnMSU+X4IkqkGcK3zjbdxyTjYyrXIH/DzQ0r4BWxkjAV7NyCypy2qZ5aOpfxWjYD5UjcjuDEZk8n3T+lBstCG7Nr3SVtEU4NKBBFiYBvyEoirII1/fz9D3rrrIWzjv84hIF7fvsRyzDxaAr8mRYIbFA8pglAGNrmsq9S+gC44SWEIf81RenbJceb/UzOL3nLQHTaKuiT8HKkCUU8xz/27n20ap3ummhwx7C4mSwUrw/0hH4cdpbPkjKGxJ9JV7asfmX+F2SnIp57dcrQZS1KRKoIKFNFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT/XyyCzhII61id0oMEdw10BQYNARZ4NYefnjLERTO0=;
 b=inq+3cJsU9My+j0FogyihlSnHP5uKtuWjk+W3GgIIXvkZFkjcdtvkpCYb7S8Rlz12tXhLyVU9CuLdC9wDGdDm7ygx6lxCQEYBq0PAmLlRwt5mTeVrsATvv0uxLXsO91IFkiudxv1TAt7kWMqjgVNpbPTYOSe89xNFS5xnhPmOAmoYpU4sbArAEzwVvHysTorhq4itmHBtdCEpmha4SkfaIX3koQCbfhETDnJ9wJuTXnUvm/J348RlaIYIK2XxOOUCVjDGMg9uajdz1LO/IqkdGVxINe13NkUc1v3pRCywiW+S7PKsTKVAtcF3WklhBR+jGuVmiroel1AE60kFv9b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 12:24:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:24:34 +0000
Message-ID: <e986dc62-dea7-49f9-b65f-cd7e994c8e00@intel.com>
Date: Mon, 13 Jan 2025 13:24:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250110223939.37490-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN2PR11MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 061628af-ee66-4899-ca10-08dd33cd3d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T096Rk9icjdHaFlEL2Z6Wk1TT1p6aG5LM1Aydk9Mck9Qa2ovVVlNVXJUWkRk?=
 =?utf-8?B?YWwvbHdRYlFsdlNCc0J2S0IyS0dEVTFZT1lHTlcyUWlMMk5TbWZrMHlnNkFx?=
 =?utf-8?B?cmh1ZnMxa0NXdjI2T29PZXErU01XL2s2RTEvd1V1WnNZcGkzTHNFVUlNUkZt?=
 =?utf-8?B?MW0zWldkcDh3VzdXU2psQ29kTGJDbmlGTm82eDZiRTJxNTZVVHhadUtzWFQ3?=
 =?utf-8?B?QjZOVDVXN3JzTVN4UWoydXU0NzBIdjIyejFBak5iSVY5ZEhHaWpvY2dOaUFZ?=
 =?utf-8?B?enRaQkJxazZqTm1qQ3BsS0ZzTXlHMTJhblU3Mnk2VVRHMTM2TzdvdHZVUmtz?=
 =?utf-8?B?LzF4amUrQUFFOXQxWWIzMWJlckNqVjk5SGE1Um9OUlBnc1JHT2F5d0h2eW9C?=
 =?utf-8?B?bi9QUmZoR0JDaUpRQTc2eFpscE4zRlVJUjRJbmpuaXl4UU5sdHc0ZHFXMkZZ?=
 =?utf-8?B?dDhYalI5dkl0RDVVZTlJb0h3WXFTbnhHcWpEcWIxMHl3NHByU1VPUXh5dEdi?=
 =?utf-8?B?d3lwenB3NDZLMk9HREI1c0hCQzdPcVIvS29heDMzcERZZjdsbThLVXN0Y2dn?=
 =?utf-8?B?RDFVWDhnNzYwOGhHWGkyYkNGWnduQS9JUnhCVzd4d0VWNThCZmxOWDlCYk1w?=
 =?utf-8?B?T3BSdjFIejhmSCtZdnNVSjdCaGxCVDhRM0hBUWFmY2toRjFlSjVBbDIvdG5z?=
 =?utf-8?B?Snd2M3gxeHR5NmpUNzNpSHBza1dSS3FRQWpMOGZZT1RBNitpUy8wUTdicnZp?=
 =?utf-8?B?emZOV2dCU3Q4SEFUVkkxZCt0ZUpadlFsZUJ0RUx0K0dnVU9zVHg4VmFUWVBN?=
 =?utf-8?B?eWc5UkE0Z1YzMjRabDhHTTN1c2hRbDJ5dzljZWN6WUtZSXdETnpuN1YwWm1B?=
 =?utf-8?B?L0VWSmt0dTJ3MHJCNmtZd2dXWldzT2pvM0pJeC9mOUR6MGcwbUJBbllaUy8y?=
 =?utf-8?B?Nlg1eXZ2M08zN24wTm1kcEpjTHF1bkl3TnhyZkFnbWQ3TVdDL1ZXZDRqMHFZ?=
 =?utf-8?B?Yjg1ZktadmZhYk8zT2o5TkEzeXNFRU9OZXVtM0k1dGxyT3Z5Rjhkb21VY3Ey?=
 =?utf-8?B?RFBQdnlyYlI2YlJHZGVjMzFubnQ1M1lVdHkycHRCUC8vTmpMclNqcXZwdFNx?=
 =?utf-8?B?MUE0QW5aUi96cEJnZCtyUm5LVDF5Y05yRGJFRk1mSWhkQUFrL1lXeU5HN2ZR?=
 =?utf-8?B?bWR0ekJobmhSd0Zjd21KcVk4UzJsOHlHekxSVkU5L2p3MGNVUjVyQzRtbWx2?=
 =?utf-8?B?cTZtK1hUc2RLQ1NnL3ZGb0Jsc2RmM3g4Z0VKdjY4VWQ1RU5VTTF4V09Ia0pv?=
 =?utf-8?B?Ti9YYStiVHhxNkYrTlpJZHhVZnZSamZwSlhMZHgyTTdFK0p5c282UnpXRmFt?=
 =?utf-8?B?ZDlOOU1QdTRPSDFWTXFVTDdFMGZoV25DWnYzdExBT1l4VENhZHJTall3VnJD?=
 =?utf-8?B?VkYrU1RKZ0dOMUJ1bGdjb0VtNjVGTFYxTzU4dUxQZ0gvNUdDbk8zWEt6aHFt?=
 =?utf-8?B?azNTVXV5ZzQxVk9QbUJ1OTFBQ2tLTjJWRllPbzBOYjFlYjJxYWhRV2Y2UndE?=
 =?utf-8?B?aXA2dDFLTWtyTTFMWWhCNWJ5YnYxQlozNzlPVFdpdTFnMnFocTN1T2JtNFpz?=
 =?utf-8?B?d2dJbEt0ZnF0aERsSjVBaDB5UnJ1MW1JWnlQK0h4bnFpNEkzaW9PcU5HZUMw?=
 =?utf-8?B?amlMcEFLaHVacFNqalhPWWY4UHNBK0w0OEtWZG5oVnRkQ1UzV3E0NCtsSXJz?=
 =?utf-8?B?YS9yOElmQkVodGJrZlJiSjRQdGs4bEtldG14VjcyaFM2NjBPa0NIMDNvcXpn?=
 =?utf-8?B?dEM3VHVYVnRncURiQmxwUHkzb2V0S2FPRjRZUjhLajcycjdRQ2d3Vy84UEZ2?=
 =?utf-8?Q?CCHrTyY43A3D0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amREU29aRkFCV0NMYWhnUW15czdlZ0RWRVppMEE4WmNSd3JuVmgvclVYb1d1?=
 =?utf-8?B?M09xM2Vha3RlZ0Y3d2VYdkhiYjFKVVJVZjN0MDlRbG91bVR3MitxMkwxWmE2?=
 =?utf-8?B?K1I1dXQ0WFhaT1NGTnN6Nlc3dndhOVZkaytjdXNjWXdXenJYNXFUdVVWcGgv?=
 =?utf-8?B?M1krd0xsMlFCM1JoL2N2cGora3dIQzRZTnhPZ214NmRJNDB3eFNURGtoUFVi?=
 =?utf-8?B?ZWJqQXZ0cThFUFE3MTFNeDBYaXI4RGMxNk5pY05GT0Zlb2JsYSs5bjA4d0hP?=
 =?utf-8?B?ZXc5SFdxNVhtZUthMnJUQUU2QmRXUy96bytpQmM2L0tyY0RIRm9sVHlQdjRi?=
 =?utf-8?B?Q2ZSK3BlMS9pSWhTN3dYa1VyRzJ5U1Iwd25ERVQ5YlAwRm9FcUZieG5sK1o5?=
 =?utf-8?B?WUdlVDhxM2xNblJLVzFJQVRGM05aN3hwR2padklMaG5taE1waW5kOUx6azl0?=
 =?utf-8?B?eGVjc004bWE0TC9Ud016VGZQR3VHcU53MXJoZmtWemNnSkR5cUZKMG9Cd0dW?=
 =?utf-8?B?bEhKbHIxRFRycm9QV2kva29aK0NTd2hLOXUxUXMxUGh5U0t5WW5naWgyQ3RW?=
 =?utf-8?B?WXRsN0JxeFh2NFJKdTFvbkQwelYrMnNhcUVaZEg1UFF6dVJHT1ZBZHlrbHZL?=
 =?utf-8?B?UFZtZWtaQ3dqUUZKd3NLcjAzNEFIcHhMSDNXWlpmYjNtM0F4ZDBrWnhjTXpW?=
 =?utf-8?B?ZTZnbjVVQ3hPQzZxNEt6OUtvOEFxKzAreHRIU1IrVmFoRGxud0dIVjBhenRy?=
 =?utf-8?B?LzFwYUN2a0FWMUFoYTdrN0Z2c3J2Q1QyUGtSRlhQeXh6WkkzaGNEYWNPUGlI?=
 =?utf-8?B?dnE0TE5tM2c1K3ZTVW83YjZpakcxeUxhUm1oV0dsSnBJRTd5R2NZdUNmZDJT?=
 =?utf-8?B?NWtNb29NZEVnaklxM2tlK3V3dkZnQ0M5THlFOGFMWkFuWUVoTXlBU3ZNaStY?=
 =?utf-8?B?M0ZCdzhpRWt3cmhMKzJtWU9sQy9qSUxzODVudU1YeEF6SlpGck1Da3U5N3Ns?=
 =?utf-8?B?cUxMZ1llbU9uMGNORmkxa1VsMDEvMTZ1SXFJWnF2cUJ4U3Y3VEhjZE9SMHl5?=
 =?utf-8?B?QnBqTXFJQVp0WWR0ZnlKbVRaWkFPQlFtNllkVjEzSnZJWGt2RDZkZXI2MG1m?=
 =?utf-8?B?RHhGbXowOTU4NlEvMHlwTDMxUmRudlVqbHVoNjU5Y2p0bEVJZzdUYnhweElj?=
 =?utf-8?B?Y0JKQmJvWFlHSGUrVFpvTW1ZRjJCMFAxU3NUbS9IalpNeGRiNU5ienFvbjNM?=
 =?utf-8?B?MG81TVhyMlZVV3ZqNElHeVdaQy9JUEw5TFRydnRld2JISXVrVnEwKzdJc2pE?=
 =?utf-8?B?ajc2MUJpLzlkTEttNUlxVUpYZFFrT1lJNkxjVzBaRGxmK09YN0QxbUdiRk9h?=
 =?utf-8?B?QjlrZXZlQzYrZCs0TlBQQzEyVlpOSHE3VWF2UDliQjVYYk5jcXFIUHhpR2pz?=
 =?utf-8?B?aGtWZjNPMTY4LytFYmJUUkZNaDM1NndIZllnR3V2UDMwa3REekE5R09IOEhn?=
 =?utf-8?B?TS9qR0ozM1lSdzBLelV1ZlBoNFpCbEFFV3MxMVEwREd6R2xOaERtU2JKVXNB?=
 =?utf-8?B?RE0rTzh5VFV1Z2lmTmJFS3VnQUtZRlFzN2NoVkNYd28vMDY3SGx6N2hBQnVF?=
 =?utf-8?B?bVJJVXJJNksvOVNQenp1ZC9PM2RIZnIwL2FiLzh6eUUvbDJNTmJIRmg4ejVW?=
 =?utf-8?B?L0xtVVZrUjZldTB2OWJUaFdGWFFLc3VKbXREVWh3eVpjR3pGakNNMjNScW15?=
 =?utf-8?B?dDlxWWtkUFhsdVU3VGRyemlySmJ5dGFpaTFmRVVYOFc2QVBnTDRIUEpMMDVI?=
 =?utf-8?B?bUM2c3Z6Ym1QLzhORWZ3eTkrbGV1aGhDWmd6R0pGeDFaVWl4N2YwU0dmWXBH?=
 =?utf-8?B?Q2ZQWmVkcTlSZndxU3lrWkRLdU84TURpVlZWRnVoZzFFWFpzc0orTWxMWHpX?=
 =?utf-8?B?TWRrRlRuSk1zaHNqSnlCY3pMRzErQTdlVlpTQTQ0NDk0MXhZSmoxZzFOSGRr?=
 =?utf-8?B?ejR2TFN1VWJsanZJZkVnK241WDRiNndKQ1B1d2s0eEsvZFovRUhPRHErNzVX?=
 =?utf-8?B?aWpMVjRaWDZMTXRiZmVCZjFvZlI1YWVZeW8yN1QyM0JlK1BzZCtlazNmc25F?=
 =?utf-8?B?VXY5S1czQk80SDd0RStPenpIaTVsSnE4elBodFFydGJLUHZrZlpXOVF6OVQ2?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 061628af-ee66-4899-ca10-08dd33cd3d38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:24:34.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3jkmoqj2frfmMpvMYTP4MHUpGmQUJjYV9ilsYYJOmBrmr3hcuM2qxuZ0Ejl0DA6LWZZwPxmT1SaoUKFZgEmBGOg8NqbDu8OqQ1o47TWmDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com

From: Gerhard Engleder <gerhard@engleder-embedded.com>
Date: Fri, 10 Jan 2025 23:39:39 +0100

> Use netif_queue_set_napi() to link queues to NAPI instances so that they
> can be queried with netlink.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 11}'
> [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
>  {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
> 
> Additionally use netif_napi_set_irq() to also provide NAPI interrupt
> number to userspace.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --do napi-get --json='{"id": 9}'
> {'defer-hard-irqs': 0,
>  'gro-flush-timeout': 0,
>  'id': 9,
>  'ifindex': 11,
>  'irq': 42,
>  'irq-suspend-timeout': 0}
> 
> Providing information about queues to userspace makes sense as APIs like
> XSK provide queue specific access. Also XSK busy polling relies on
> queues linked to NAPIs.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

