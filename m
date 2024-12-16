Return-Path: <netdev+bounces-152200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE99F314F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16F2163C18
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4655204C02;
	Mon, 16 Dec 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8LURqDe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645B1119A;
	Mon, 16 Dec 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354801; cv=fail; b=hqA39/Fg+jYmRobQ3dvevlivqkair3q/YRM46Tw1kFfx6Abqk9TyJRVCtVE7c+b4LsooCz4zZkCPdd5/JXynYs6F4x8C81DAhTMAp+KvfovGx8j7KoTFp5z9S4lNcbrhCGCHws+hj6O6LY8P7NZxIft/o54c75jU551J/39059I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354801; c=relaxed/simple;
	bh=Ev6usaArfPjNE8L0Sk8x0jJkESwp6BuwoxD5U0THkD4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6v7D8M5gjO7xB8w2mlpFH78J5UcP6eIUXJAS+3vkg3/EnNHmJO8LdGuLY6ejhTKsypkvsQiQEJXhtRE+82BOu0LQIoPGnAo3SBXhpUX1/Sw2rW1/DCu4xhhb443nvNJyZj7GEzWeLvNZGTgqxHEgDtOJn7sJs673QWIPIwrn+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8LURqDe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734354800; x=1765890800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ev6usaArfPjNE8L0Sk8x0jJkESwp6BuwoxD5U0THkD4=;
  b=d8LURqDe3P3K5E+2G6DxGvmDYPa0k8HcTAAspq85RHxxpJ2OKYixjJqG
   RVc2Ya9Hvp86g4DOPAJWQlVjqBsbeO9bo4YdRgEoNZAkIEIRGC9LftgB/
   4KQc4Hv4MYvoljX2/0IlZRavepLzDhmfUTH5tiwO1ILSNlirimBuri8vb
   ASZfaMWqMpJgq1y1NarWb0jpKdpXqMue05Jd+XPAv56zZ1QPINQ6KHNEe
   +MceQRb/06o8lKs57mMHArTAg4wyhFe9Kdd3zu6kSLUiuOJbVRbtMsOMc
   pVnv2u67bJ8QRJZGKREYlKCqNykD9eiYXetC+puhkkq+4PatCAksElIvz
   A==;
X-CSE-ConnectionGUID: hAgo+QZuSpaahpX60s9liw==
X-CSE-MsgGUID: CxwhxFAYTeWD+g2lytiqGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22322022"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22322022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:13:15 -0800
X-CSE-ConnectionGUID: wckDO/YcQYiZHFjEQ4pLjQ==
X-CSE-MsgGUID: y4N/JGP3QfezHT3oSp0QBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="97102232"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 05:13:13 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 05:13:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 05:13:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 05:13:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTkrEMAMpFd3iHKJqcsM5MT2/JLh3/lMnHlsAX98UQsHrppWZgxrx2mDuaZplTu5MFfbfOyTJ1DzL05Ko9WjJ6nmVCgLqTC21NolZ+9PAcQofgAC5AHxH7cJFSr8uqjzHqVq9zX6W+BD88BSWy5CMIi2qm4GQMDUwFxmwPh71cyMNqFCGDKTMicjDjIE/MVZ7KC/O6X3x/OFK0Yoo62aUN76orTaOfJj/9oe7dxdjL10JqKVa/l2DICvVITVgwmt4SwwjD9mAoXyxDn8VxOoiRjmdwKDVfZGkvDgvyk7/XEIiXvI5anZVfF4vQIym6JexO/XnSIdcVPXXwe7WZVNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eny8d7MQa0glps53YrIjGpgs0fO+OLIc50Eld/D+X38=;
 b=GpE13snc1OembG5y91I/GLemBgQNn8r1Ld7LJIEbBqDg/mjAayKFZ8GADYeG96URO6QLm9ST55ZWo4Y41BD4LuPxlIdtEcvFu0fMRj0oDGOend4sILgxM/z83ZpU6MU+BoyVujwBqlseQiYE8unOGZf0DTJjZo/7egrAu1BSwMXCXgXblmFib+benEM0dDX+BlZSXL+cEpCwXi0zw9cptGnlqgGe1VZHcw343CAjlmGM1ncQ2FTVmhS99ei/2ZsBTf3vTRvxzNlVrj85r+8XeSfS1oHqoO94CSW+w2I1U/Yyku8D/zhhFrk2CX6CN06C1xEZjNh3H3EXac4nLZLkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Mon, 16 Dec
 2024 13:13:10 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:13:10 +0000
Message-ID: <7d777a2b-f7f0-49c5-86d2-9ac36a351ab9@intel.com>
Date: Mon, 16 Dec 2024 14:13:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/6] net: usb: lan78xx: Use action-specific
 label in lan78xx_mac_reset
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Andrew Lunn <andrew@lunn.ch>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Phil Elwell <phil@raspberrypi.org>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
 <20241216120941.1690908-4-o.rempel@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241216120941.1690908-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA2PR11MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ee823a-05c7-4779-26e8-08dd1dd36399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0JDZW42WTRRcGpkcnZaTW54azh1aEN5TXRaaUV2ZUh5YXN3QzBmTUdaZTFD?=
 =?utf-8?B?SlBpdjRTeXhobk1IUVcwSjlxWW4zdFhlRzA3OVBoN29OQzFhd2NhL2FFcUYy?=
 =?utf-8?B?M29wb1VWR1FnRk01K0tNUkdObTkwL0hQRDRzdWpKa2FCNVFlUG1OSFFRdC8y?=
 =?utf-8?B?b21LSnBGNXdCQ1hZWWhEaEVLMU5peHFPeGc3cWtiSFJxZnNaS29QWXZGNm9L?=
 =?utf-8?B?MFdNYW5rNDRaSWNQRmpzb2dvWWZhUkhObmttQ01CVlZFSW5XNkdFcDkvT2V4?=
 =?utf-8?B?cElWTVBDeXl5cHhBNmNEZ1ZlbTFyRUhqMFpnNmhaME4rdGwzOWxMVk1JZ3li?=
 =?utf-8?B?eUwzSm9tNzhKc3ZML2ZoRllLMVFqc3JsaytwNGZVekhqODBzT04xNVdsanQr?=
 =?utf-8?B?VzJwSHo1RE9rTVVPbXlzSTBEelJucmlGK25hR3Q5bDZjVkJ5Vk1tL2Nuc2ox?=
 =?utf-8?B?cm1GSlFITklYb3ZMV1dvU2V0ZDA1Q2plV2VhOGRoSW04enlWdnhZUFVUQTJN?=
 =?utf-8?B?RGhoaVJvTGNSeDVlT0JSbmdkYys1VlJKdWJjdVpNM0wyZHN5L01mY3lWUVZC?=
 =?utf-8?B?c0ZkMkxDdWUyWFk5eTRDMDZRZGZpODJ3RERFYVpDdXN5WlZ2SURkdlp4QUlU?=
 =?utf-8?B?SmxUSE55bk9mR2lzTDVWR2VVL0tOeU9FL0NFWVVoeFF2TmRNQ1BhaW03Zllp?=
 =?utf-8?B?TFJVR3Y5SEowMmlEdjJtMlh5bzZtMmFFeDZzeXBLS1BMNlpsRFc1TmNkZXlk?=
 =?utf-8?B?V0FtaEIrMDBJVFN1elRsZTFJa3lBNHBYTTNleC8yS2Yxc3lDWHluQzkvV0VO?=
 =?utf-8?B?WEUvUEZBOURGTjdZajRUYUp2RGpHbXk5cXZhQmczc0k2L2hwZ2pzVCs4OG1D?=
 =?utf-8?B?TFN1UkNLM0Y3Z3VOS2pjdERaYzd4c09UWlNnU3BBUkp0UDg5Qml6eHI3K0xZ?=
 =?utf-8?B?UXhIcENhbmRKYWNzWkNjcTRibFM3VUgxYkRNUm02aXdncTd2K08yWXhVOFVh?=
 =?utf-8?B?amxRRnp4VnRqczFEZWNPOU1lRk9xemJkN2VHa2lIdW1BU3grQ0ZkaW9NL1JD?=
 =?utf-8?B?emtPUlZRbUIvTHkrM0xmckRIcTFubXUxWXRKKytHalNLazdiaWpIdGlSVm9O?=
 =?utf-8?B?L01aZTZHekJURkYyaytsQkpuTEZ1OExqRWsydm8wV3pVZDZ2bnFObzNjd1Ix?=
 =?utf-8?B?cS9OS2RMcGxJVERHc2J1QkYyeDhwUjFyRkxmSGRBR1F2ZGp3d1hPa3laVDJH?=
 =?utf-8?B?U2NJN0JEdDJmaHNlenFoNEgrK21pTFNqSEx0ZUFUZWQvRTNJSWJFdzZmc0ZB?=
 =?utf-8?B?L210NTlHclpUTVNMWjVNaHc3dUk4c1VaRlRVdWdxdW11bDdrQVlHVHJuMURu?=
 =?utf-8?B?RjZENTR1a2habXo5VGpPZFV6bzVNclE2Z1d1b3lsKzlHQVhmalA4OHgwaHQr?=
 =?utf-8?B?T1V6MUhmT0NuVkN0NXAxTDlXVjl1V0pmUFdySDBtR095cHBPcEVhSEhlUC9O?=
 =?utf-8?B?b293T2x6Q3YwdFNsU0FDQlJKUWZFVzF1R0VaVkUvam0wWVI4dUYzZlNJeFRn?=
 =?utf-8?B?TU5EdDd0NytZbE9BUXpwc3NDWVNrZVBUM1Zkb3V5VDYxcFdHRDVGdUtGeFUw?=
 =?utf-8?B?d0V6TUxTSFhKVHMrOWRTQXY1TUpqYkdrVTAvNlMrUS9IamNVRUZFeDBWWDRs?=
 =?utf-8?B?WUMwMXk3cVhCSEtVOUh0Qmh2WGZFS0pySmRmdlhVKzQ0cU5VbjB5VWxHZVdG?=
 =?utf-8?B?dHQwaldyN1VnakJ0ODB2RnNVdFRFSC9rMDJ3MFpnSXBJNzlyc2t2MnRWTXNU?=
 =?utf-8?B?WG1YM1AxOGM0aGkzTlVaWVNVQW85ZnBsOEZUWEVrQnQxREkvM0k3N3BjeEpX?=
 =?utf-8?Q?thkYoGxMCDNxZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBEV1BtY3FNRE9BcVlWa01iSEVJZVVzSTFJU0hKZEIvNGxBVDBwRlMvT29n?=
 =?utf-8?B?SmJkdVpqaUtkc1VNaGh1dnlhc05pRHNReE1aS0RyRG1FdXpkZHJ1VFdaRVQ5?=
 =?utf-8?B?ZU1CdzFOM2Y2bkY3SlhDcFlORDNOSXJmMGp5SFF1WVowbjhjY2d1WWtuNEtj?=
 =?utf-8?B?VnE5QjRLQ0NBakh5VXJZczNvUXRMcVhxK0ZhQlRXQ3V0ZGtJbzRQanR2UUJT?=
 =?utf-8?B?ZEJTaE5HUmJKMnRWR3RoN3BrQXYrK1ZvTHJCZkxSUUMxWTlqdk94RDVUKy9X?=
 =?utf-8?B?bEY0ODlTQ1VyNXd5eENuL1d2NWIzeHlYaXFXeUNiaGFJdzl1N0pONkJDcHRP?=
 =?utf-8?B?TXZ2OS85YnBZRXlTVGtZZHJ2cVVmWjkyUzhzazFiUThNMTNjbDBQdEhOeXBv?=
 =?utf-8?B?clQvb2V2UW9DMXNSUzJ2Qm5uckRMMGZ4a1NEcVFGWXloNmdmYm1HUW1zTThQ?=
 =?utf-8?B?Ni95Yno4YlhBdURtNnFHWXBIVVB6eFlJeXBXYXhMcUNHMVRMQ0V2WFZOb2dO?=
 =?utf-8?B?VTdtK0VuVTZRQm03QURHNzVPb0F2QU9PRFc4R2xkWHRtUm9BakFZMFQyNHV1?=
 =?utf-8?B?bS9LOU05RVpuK296bWM5MlJqMWFRRmM3V2xiZ3hVcFZVRzFvN3FpcExJK1Yw?=
 =?utf-8?B?N3hrYlJhNU1PalZEVEVXSnowQjIrWXFZemczVkgrSjVMcVlUa0kyMEt5LzNE?=
 =?utf-8?B?YVNhRXIwTGE4ZmprdVBaR20yWHgzNE5Md3IxUElyYU1OWTU0dnRSNk1tbDJm?=
 =?utf-8?B?SnJiVG0ra0FVdnlMTWNjTFBSeCtNdzFFZzJkYkFTMWlKUVM5VmR4VE1nRXpz?=
 =?utf-8?B?M09DN0tNUURWZ2I3dnMwZExrQU5KeWVOdWVkQlFmTmtjdmhaVm4zOFEzeWdN?=
 =?utf-8?B?eEQxd1BYNkNveVpoZXVhNDBod2FGSVF4NFNrYkdEM3BVR3FXcXRRUjVjSVlR?=
 =?utf-8?B?Nlc4TDRZNDFFendoWGxSOXBGb1BhZHhZaTRmYkxqbzJQRkF0S3lMNjByem91?=
 =?utf-8?B?cFdKVUNndUJCTmNzT2hlQnB6Z0Z1MmFHc0dOQUc1Ylo5Y3dwQUFobGV1QmMx?=
 =?utf-8?B?RDBpYzFMbjhUb3A5aTMyaFNrc0tqdUk1TjNIYmJtYlpBMnhRSkZ0UnpZOEtK?=
 =?utf-8?B?V2tydnRpdFZiZGN0VkRBczg2VUFZbHdIM2haRThqT0xwQVFiUEhuaW5LdnFH?=
 =?utf-8?B?NzB0NlY1NERPby96eS9FcjJpalpJNVkyd0VuZjc5cWpMTE1lNlh2WkxoMDUy?=
 =?utf-8?B?VjJRcjFVUForaEp5eEhlMVo0Q0VFUVNoZVZEMUorWGdqSW9yWHQ1aitIQ2lZ?=
 =?utf-8?B?dUo4cVNCdm9NcWhvNjdnU1V4NVBtVmFDOERDRlBOemVoNjFGYThSSHp1b1Ra?=
 =?utf-8?B?NHcwWnF3YUFOYzM0bGJnVFhIYWpsZml2Um9meHd6Y2gvelNJSmhKQUdJbGxl?=
 =?utf-8?B?dGYwQW52dTJLdFkxek1PMlNKYnNLR3FtaitxQmJOSkFUbVl1RW1CWE12Z0tw?=
 =?utf-8?B?OHJyUk8zRnFDcnc4Vnl4dERpZXI1cnVoOGZtb0RNNEVDZDMzT2YrSXRKeE94?=
 =?utf-8?B?NHB2NVBpS1E3QnVvUWpkUFVpQkJaQmxuVUhPbXdKa2RIMmF4Ym5URzhteXVM?=
 =?utf-8?B?cFdHWGptemtYaW01WXRtOUtmc0xqUE1jQWFnWmJRZklUV2M5ZWdVYzVrS2Nm?=
 =?utf-8?B?R0RUMlZ3b0lhTWI5U1NNTW9jQUhxNWp6aHQ4bDgxQVFDUXJ2MW1tQ2xRTmVE?=
 =?utf-8?B?TUx3MEYxM250dTFyVE52VUh3bVpac0NUQW54Z2JFdTVwb3FPQ0RiQlNSVlpK?=
 =?utf-8?B?NjdQM1Uxd3dVQWF2MG5LdVVyc01YWVMrbDFqUnFNTlY4MXdKRmtZNXpBMEwz?=
 =?utf-8?B?SFI1Z3VYQUxhb05CUmpRNzNtZktTcm84azZGc05uSndhdjNIdHUxc1d1a2ZH?=
 =?utf-8?B?QzBIOElZQWNSQkNOdTQ2UEU4RHc1Z1h6alhmcHJTUjNPRUpyRXJDZU1oeGg4?=
 =?utf-8?B?dzBQQXRVWVR1eCtzYzBSUEhRYytvQm5ZQVhZQXRsdTIxMEpFdEsvZ1lZQml4?=
 =?utf-8?B?MmZ1cWtJelhuM3VNTFJqM2tacENneURiVjlKSmViYTBkVlgzQkFycVBKUnc0?=
 =?utf-8?B?WmZ0cTJtYW1hcjNwRFJ4TU9mV3JSUGJva1Frc0g4Y1ltQU9Kb2w0S1o0d0pX?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ee823a-05c7-4779-26e8-08dd1dd36399
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:13:10.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83NpNsg4ZfWrBWbtoXVcbAixwvOa4zRn349AXHGCQ55t8f6cnjmviO7dVJCPgeLjmJrgrAj14rkcGUUy3+glBCYBMSiYH+/RbRQcifJt5x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com



On 12/16/2024 1:09 PM, Oleksij Rempel wrote:

[...]

>   	if (ret < 0)
> -		goto done;
> +		goto exit_unlock;
>   
>   	ret = lan78xx_read_reg(dev, MAC_CR, &val);
>   	if (ret < 0)
> -		goto done;
> +		goto exit_unlock;
>   
>   	val |= MAC_CR_RST_;
>   	ret = lan78xx_write_reg(dev, MAC_CR, val);
>   	if (ret < 0)
> -		goto done;
> +		goto exit_unlock;
>   
>   	/* Wait for the reset to complete before allowing any further
>   	 * MAC register accesses otherwise the MAC may lock up.
> @@ -1621,16 +1621,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
>   	do {
>   		ret = lan78xx_read_reg(dev, MAC_CR, &val);
>   		if (ret < 0)
> -			goto done;
> +			goto exit_unlock;
>   
>   		if (!(val & MAC_CR_RST_)) {
>   			ret = 0;
> -			goto done;
> +			goto exit_unlock;
>   		}
>   	} while (!time_after(jiffies, start_time + HZ));
>   
>   	ret = -ETIMEDOUT;
> -done:
> +exit_unlock:
>   	mutex_unlock(&dev->phy_mutex);
>   
>   	return ret;

Nice cleanup, now the label indicates what it does.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

