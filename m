Return-Path: <netdev+bounces-99515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F78D51A8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B152F1F23E27
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332C4B5A6;
	Thu, 30 May 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkH1wSjm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E121A04;
	Thu, 30 May 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092963; cv=fail; b=pgQGi8xtiSy6v6JqThpFJ3YFiCm9SZoCzyJqeYtdUpBWEU+lUpYn4TdqMy15yEVmyn2PmF9Xpe/bt8xvUSKdbkjk4Ewg802II7jC1BQl/3PGwJuS+Mji+ZMbS9bzwK6JtoVfwsjQExumJIRnD70rW4OWegzu/QpS74TgYB6Izzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092963; c=relaxed/simple;
	bh=bqFOQM+hVVL2K9UT5jJ9VqUU2Mw/KgAwZaMfVFVceBQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRKUFTC8HXBBFNKTmQdRqyK5wlsaxXwshdT5h5XNDgiy77U0/jYQmN/rC6sXCYyS+g6ZyLSYQQVmYCGNE8EcUYbAIp4gZo64bpcfjetPgF2aGQ+5YyhgsWyKZ5F8Nvi7l52YYHls6OZhLrFROp5kid0U18b5zzIUYBtBzab6JVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkH1wSjm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717092961; x=1748628961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bqFOQM+hVVL2K9UT5jJ9VqUU2Mw/KgAwZaMfVFVceBQ=;
  b=JkH1wSjmOnYP6nkJC+P33Rev4CqAsqNEKwJFfGijbV2j0sLdiD6uUPgd
   zrKhFjExwdzvVbOoX7scOX9ZdukNDHueULRhkDUC0fj37Zb0PrOSebq9e
   t3/54CiGAMjqVdn9294Xo98Zfu8kRiEC7OlfpDX8YXFovorkTXT1l6uZ2
   uvAuc18z4Ki1p0jlAjUdyZqKWI9MMiDr6Mlw0Z14FGuvfPR2Xy6OKh4xT
   ix4y9AP/O7XVnTsQSq2cSs44rmOfmkYc+mboVSERfUvYs5/WgjSBxS3r0
   5HWhEhXpRYlQMQp/U9YCJrsWDQ6MxyW3eGjnKq8Wp2ucCm7RU/BFUT1bc
   w==;
X-CSE-ConnectionGUID: t6/wNe78QdWgG3yQDc6dBQ==
X-CSE-MsgGUID: cyJc2wbXQeePkL2BdJniLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="11822929"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="11822929"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:16:00 -0700
X-CSE-ConnectionGUID: uF1Lb0ezRiKEIvSD9uxGEg==
X-CSE-MsgGUID: pLjnbzFfR+CRpMlygFOONQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36525737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:16:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:16:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:15:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:15:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRVIduDYAMGsvzSZaY2FF/cnVlkduh+Y5QXfig9AUR1AXzc/7fh9V50ivi0ErDoAYIqnJnJcgTJBOhQJarsq9hJcHMatBCf5qq1y+o8bc83V/9aCcrCCOENIxRBVrxtkz8lpEUhPXtMUV+qmMEDohDHFdKhtKiTdEpeDl/N+dLMbhn3Oo/gqbn2O5xRl6vVF+Urw5FJ3h9BD+FD0ntqAEr8rt73+GnTqAZUvR68O7gMnyLc7ywwdIFhf6t/8mSQqxF2XPOffwJW0oQJ6pNynK3ERTI1trFSEhd6ipOTEyI9xpDA33g1kT8gV7XvedXRSU9LeAt7NpULxYasdFNr+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTce+C/VzwHXLP9zsbV1T8RgiYJ7aEncBtS/rZHXkCg=;
 b=bO2Fy6Rtyujrm+7x41HK1JYdzpGcpXY85uDBJsgSsVOO9zmNLEzZSuzlzIeQMXxC1APeIqG3FB8EjbfmDpsGUOWcVZVc5L56h+2J4P5NfOX0hJqD3jmCioC66OUJDatekAkVttIR3EqA5ZLlxv3SXlMd91Dv0cajWuQxQFmNOhpdjPiTTgF54wq1143naKVCk8tBDwxWOBdWjTkgkFTR6OtUMxbpDRZOkxPLN6a6oyhzR2yFJtqNNUB5B+ejmql2+p50zEuZmQnMGChGKyxvHl35Xkz8eiDSuWd+SVu3vhG9EJ1GdL6oVOV2jkBbwVazLVsUIQDL8QGESlqp2IIL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 30 May
 2024 18:15:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:15:55 +0000
Message-ID: <7143f846-623d-465f-a717-8c550407d012@intel.com>
Date: Thu, 30 May 2024 11:15:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
To: MD Danish Anwar <danishanwar@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>, "Wolfram Sang"
	<wsa+renesas@sang-engineering.com>, Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>, "Vladimir Oltean"
	<vladimir.oltean@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>, Richard
 Cochran <richardcochran@gmail.com>, Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@ti.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-3-danishanwar@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529110551.620907-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee8f095-add9-4437-e554-08dc80d48c11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDFxNi9DeHBxd3M0NXRTUGJzcEVRMnA4T1JhcTdpVVEzVXc1bWREU2FYT2Ez?=
 =?utf-8?B?Slk2Nyt3MkphenpwelE0RnA3R0hZSCszdG1hZlVlWXljQlB0Ty8zSGI3SEFj?=
 =?utf-8?B?aGVkZVQ0ZjQzdDlDODVhdC94MmJnZEJRQ0NwMmZ4cHltcGx2VUdwN2NYdG4z?=
 =?utf-8?B?VlVmeHl1MXYvMnA0Qm54eGRxclRlQWZQaDZ6dFlSS0tKSEdMT3lCNjNBdVhO?=
 =?utf-8?B?UmRqMUNYTGR3NjFFc1pqNmVwMFZuM3FHUysrTTNlRzV0STc0bzBpUkpxeXBx?=
 =?utf-8?B?R3kyTWpxT21zVVNUVzNBbURRU09DV1QwWlhlUk1BSUUvKytkNjZwYUt2TGlY?=
 =?utf-8?B?T3VjOHpjTThYb0tBLzB0M2syVUZzNFVLUkljQjVuSFNhbjR2OUNiMFVUd05l?=
 =?utf-8?B?RzJLRkppa3pTWXdWT2VRVlNBUTU5b3drL3hxYWpOZ21JZXl2NGZnWFlKOVhl?=
 =?utf-8?B?UzhNWHQwL1lYajRZbWt6Z1dHVHc0d05KSENUWXdsVU1yZndSdENOdHFnd3BW?=
 =?utf-8?B?Wkx1eUdLWUliaWRjUFZCUlJKQVJSUnlza3JYczE1WUFpZkZRS2laT21Gcktq?=
 =?utf-8?B?UUxudGltVitVM2pmRXVmS2VYTlBub0s5TVRyZXNhRUs0VzR1Nnkvd2pwNjlK?=
 =?utf-8?B?T1JFQkFoMkpqNGlBdFh6enJBb3hySHUzM2MyOGZIbE9qMmtvTmduT1dlbG90?=
 =?utf-8?B?WlJ4ZExlMDJWeW9OcENZMDkzRlJuTWUyNHpPRXRxSWVWNzRmQnJyclFWTnZW?=
 =?utf-8?B?bnloUHhrZDJKY0MxUmJWdmRJVThLQXhiMFBUbUNNVXViL05Oc2dibXpZWlZm?=
 =?utf-8?B?a2UwbzArOTFVMGFLQVlWTXFyYjVaenVUVXpQUnFLTEwyMFNFN0tPVUh2Z3hs?=
 =?utf-8?B?R0dtc2lZbm5ZU09qWVdLZENRV0ZGZyszSkFYalBNb2dZKzJlNWFlR3dhM05y?=
 =?utf-8?B?MDFIbGN0MnV2RkNyd1g4OXUrQXk2N203cnM0RVY0QlUwWHRTT3NPUUpFZVJl?=
 =?utf-8?B?eUg1YXBrZXFIR3ZXUkljUkU4UGtQTk43UjlmQjVwU2VxUi9TLzNUTkVTZnV3?=
 =?utf-8?B?VmtSVTMvcU51a01DTVkzUis5c0hkS1FOWVcrWnh0SW5wZVRyZC8wbWd1MWRB?=
 =?utf-8?B?RTViOFpMTGtlOXA3R2tMYlROQ3YyUnJvYnpJempGSUc5SEFtblhnbExwQWZo?=
 =?utf-8?B?dzhod3luK3U1UDRVOGlyWTYvY3dCSUNKV3BCcmdkY3pBTXJkTGVOeithQ20v?=
 =?utf-8?B?K0dub2d2UTQ0MjE1K0hHZ1FhMG8wOTZYLzBUTzZyN1VmdHF3d0NCQzhsUUYw?=
 =?utf-8?B?bjFrWFBMRGpWWTAwS2gyRmxibWsrSE9uRGNMOThLem1qM1I4TGUyQ29Waldi?=
 =?utf-8?B?SE80U3ZkWXhKSUFZaFZRNGw2cHZvRldjQjVpOGc3S3lsYXFnUjVmSy90eTlj?=
 =?utf-8?B?WG94NG1KMlpUZlc1SU5IYUdod3FBV0dqN3Q2eDN1Zm1NNzc2anpocDAzaUc2?=
 =?utf-8?B?NHZ3azJlTlFIalBwWElHYTFxK1ZyMEFBTDlnQitoV2hmdFlwaGZoZkpwY3Iv?=
 =?utf-8?B?b2lmYXlQRllvWTNnNjN4cGxMdGREbURPbG5zT0NMeUUva1FqOFEyVVAvUzJy?=
 =?utf-8?B?MVkvUGZ6SG5Dc1B4SFFKMlRQdjBvclJiYlFMR01DL2lRWitqYUpIRnV4NkRU?=
 =?utf-8?B?OVdJSzJrdEFuWWpJTzFHd3JWTVREa2pESUsvRUt3YkQzWnNRckRyNDRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNJbEVLTXNSQnlDTy80d0ZBekVVUUxNQW1KdG5jMzVvcGpFRXNtYlZIYWRX?=
 =?utf-8?B?QWxkcmQ4RVpoZ1o3czZJRUZUWlFpTkE2NUorc25XRGtTRFVEWWxIWDVoVy9Y?=
 =?utf-8?B?RHFhOUhIRng0UitwZXFSZ0FBOHR3aVZUMDJaTERxRitYRm5DU0dxSzY4RU52?=
 =?utf-8?B?MksrZENMdnJPVTgzN2V0Ky9XL0Q1NWs2S0RlM3luT05nMG1DY1JyREdSS1dj?=
 =?utf-8?B?cXVVb0p4SVh3RG1LNGJvUXBLSWFkZ2JKbEh2OU11NytvclM1NjAzdkpHQkFU?=
 =?utf-8?B?MTBXOC9GYmlhSmpkRzI5b3NnbEdaeGRUM1JTc011YWQ0aEFvK1RFRVhIMzZi?=
 =?utf-8?B?R2s3ajdKTDNBdU5KM3Y5TFh3empCY0dLY2gwQTIzeVJXbjdhRUhYQ0lTS0xO?=
 =?utf-8?B?amV2RUVnUkxyTk5mazRwWjBTcnFPbEhpTkJJRXVrdnAwN3VsSld3SzF4U3Zo?=
 =?utf-8?B?dnpWMTdZQWZQWVVHYTlJU213ZU1hVFM1U1RkZlZSRy9RSE0rK0pSdytpYjVM?=
 =?utf-8?B?SkZDM016N1M4dFUrWUdTMjd5Vys3SDJkTlp5WEthamtXNDk5ZjQ2WXpKRWJM?=
 =?utf-8?B?SThwU3MrcEU4VVkyYjRqb0MrT3BTREVZNVZlN05yUUpFWkd0UUhvc0syS0hn?=
 =?utf-8?B?MnphRk5ZL1BqZGJ4MGFDbFBsYk54VVBCcExuUHlGb0dsUzNqRXczNVFnLzZL?=
 =?utf-8?B?Z0RNcmFpQjNHNVpwZzVYRFFHWGR1dXZZcG1VU21jTnVKM3F5Wm5LMVMzdkdh?=
 =?utf-8?B?eHQ3eHV4K0IxYWhyaWd3ZnNmLyt4WHRaZHZIbVVwKzRlVHZFV0lDbGtCOG15?=
 =?utf-8?B?N3hXNk9hTVJab1FWOU84TFhpdXZEK0FvNllYUThCa0l5UlhGZkF5SkdSZ1ha?=
 =?utf-8?B?c2pQM2drYjNlVzZyRTBHL3BJbDROWFgyNDYzeFQ0TU5ZWVhaWGFzRC9uUEJv?=
 =?utf-8?B?STZyOGF1dEQxK2F6dENWcUl2THBEVVlQWFZ5L01yK1ljMnRVQU9EUEJyRzlw?=
 =?utf-8?B?aDBHSTZCN1NpUnBhc3IyN2FCeDRZOWt4Z2E1MmJlZWRNTXN6cjRib2VaVERx?=
 =?utf-8?B?TFY5ZDI5UllrZEduOTFLdThYNVZJUDJXaS94TkdZQ2ZWT3JzQ2UzTERSVnZI?=
 =?utf-8?B?MWRFL1I5aWVFaFpScDFTRW5WMWVseTVjZnpVWjZFdFBVQW9ETDVtV0VTblhU?=
 =?utf-8?B?amoyc2ZGWm9YVFU3WjJldyttTXZBTSttZHJsa2x1bUE0M0ppcm5sK2E1TWZw?=
 =?utf-8?B?TTU2bW5mOFcrYlljU1NOL1h4bEQwUGpnYWFuS1p6RitkQnVYVExVbHV1YndO?=
 =?utf-8?B?MTZsa2VROTV3aEpoSG9tOUlnV290MzczVUYrY2xMc3VMbEJTSWVvM0dmdmx6?=
 =?utf-8?B?RjF1eUJaQU5OeDdjS0ZMeDlJNWJ3RHprdm5kRWR1VmRlMWN0WFVzZTV2b1k0?=
 =?utf-8?B?L3ZvVkptdmx2MUsvYWxoYWw4RnRHdzdLSlArdnE4Q28wT0hsQ0lEcWI5b0Z4?=
 =?utf-8?B?TE5CTjIyNUNPVHNaYXFPRWk3a01lMWwzZXZHY1RCc1Q4N0RvTXk5eUFubmVF?=
 =?utf-8?B?QVg4dVplY25FWGJvVGRzMFhwOUZ0dSs4TU5wbmhveVlFQU90Vnp3bDJIcUFF?=
 =?utf-8?B?YnVFZjY5dHE2VWxUeFFGMGdkQnJ2MXZ2QjdGT21mNXJvVWh6U1U1YkF6OUNv?=
 =?utf-8?B?L25LVzQvdXVFU1plNDBiRHlVRXYvV3lvWGpXNk1QWFM2Nk9vZVZnUklWYU4z?=
 =?utf-8?B?VUV2dmpFeVoydG0zd3NTcTMyOU93UWhvM0UwTHNIN0ozVmlOejRNVFRQakRN?=
 =?utf-8?B?cVh3dzlTR1l1UjJraW5LTzJ4dHFUN0o4YTNOajQwN2ZyelBoUjNud2tCL1NF?=
 =?utf-8?B?YXJzeEpsNFpJYjVsRnV0SUVUWUdhdyt3U0pFdEJCbWNjMWRKYVJPNVBodGYy?=
 =?utf-8?B?T1hIVnQvdVZZRTcrTllPcVcyTDBWTzJYT3VBby9USDg5TFVKSk5EeVdtWjcr?=
 =?utf-8?B?K252aFl5eXRUOG5Jb0J3N2lWeEhqTkowQVdQQVB2Q1JHc2pQTm5hdEwySkNm?=
 =?utf-8?B?bjkxQ2RPVHl2enVHdXpISlhDandyaTQ5TVpVTW4rRk53c0pKbGZPdFZCRVFu?=
 =?utf-8?B?Vm40WGVPc3lyNWRGTTQ2NFlqZ05oYnI4SnFmR0I3N1pCcXV1MU1vVHFUSFVj?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8f095-add9-4437-e554-08dc80d48c11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:15:55.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHnPKYgrtwBOjgwOMPnJqO0vHy9ynMzxlM5XvhRkQ//v9YnjiI0Je4Wt4x52XKnby3CCxYyjDYqfx9kBtAQIQmFUleP2U0I29yKaGnNz39A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com



On 5/29/2024 4:05 AM, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> The ICSSG dual-emac / switch firmware supports Enhanced Scheduled Traffic
> (EST – defined in P802.1Qbv/D2.2 that later got included in IEEE
> 802.1Q-2018) configuration. EST allows express queue traffic to be
> scheduled (placed) on the wire at specific repeatable time intervals. In
> Linux kernel, EST configuration is done through tc command and the taprio
> scheduler in the net core implements a software only scheduler
> (SCH_TAPRIO). If the NIC is capable of EST configuration,user indicate
> "flag 2" in the command which is then parsed by taprio scheduler in net
> core and indicate that the command is to be offloaded to h/w. taprio then
> offloads the command to the driver by calling ndo_setup_tc() ndo ops. This
> patch implements ndo_setup_tc() to offload EST configuration to ICSSG.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

I tried to apply this series to review it. Unfortunately It no longer
applies cleanly since it has textual conflicts with 972383aecf43 ("net:
ti: icssg-switch: Add switchdev based driver for ethernet switch
support"), which was part of:

https://lore.kernel.org/netdev/20240528113734.379422-1-danishanwar@ti.com/

The conflict seemed easy enough to resolve, but I'm not sure if the
prueth_qos structure would be placed optimally. I tried to build the
driver to check what the placement should be and was unable to get
things to compile.

