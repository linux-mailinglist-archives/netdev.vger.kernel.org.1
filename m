Return-Path: <netdev+bounces-101353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B488FE3B7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0F01F2139B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510891862AF;
	Thu,  6 Jun 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxq101Kc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADB1862AB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668165; cv=fail; b=uS5nbYX+cEgSHx5O3y9P34H3eBNiYoXJiopuvXUoFh5VasaReNVPa9Is4Dm36c41GogcK1Mjr3Nyb83AoR9S0jX6lwKqGpUdAVhO4WdIy+cnk7/lMXxBn4dB4Zto3TKahyjN9oSV+OnkTyLnyd6RB0jl/S9+CmsD8Bjd1wlUS9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668165; c=relaxed/simple;
	bh=Uw2DoafUNZ8HL9B+joat69LllTxEcs3N2yM3mZvCib0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aaz3T8CHj+owoF0qELemP8gFuIaZ9QdC+AzbLv77rdz+mmGJGYjawhTsGmUbxxzXtJzYs9BHHTf1kQIl61Ws+Xi6V5B1y5JkZqXz17IIBDRL7v0z69ozANwJ4XCBj3vy2xLuZg+IRf814GhT24mXalDOGVpMvOb8ag5+/8GfIMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxq101Kc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717668163; x=1749204163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uw2DoafUNZ8HL9B+joat69LllTxEcs3N2yM3mZvCib0=;
  b=jxq101Kcp+KX8O5eSUcW3VKcN4lq7d+rJJ6REZAtUMGtXGShPqiahrkV
   Nzm1qzPb/KvGGhuTB7pahMnuK8H/sBCOvUWuvd8CEo6BymL1HoEX4oZe5
   ga/0Pp9UFFTWbhh+vaNPSrsgXa6zX7HRepXFM0thof8knxytgHRRumyMZ
   VGLy4CDLMWZw6BNGIcOTQ99ycgm4XhWBgaMZwpQnHq3ugj1JV3Z9gPhc0
   5jAnmpR37V1IJgR8kSEjomFv3YrtqhXKv8aJCwOhHv6HddkcS11rVEsoS
   2e+nyvrUsHnCKWGm9l6ztuYPWK8iNRXOa+JUdc2h/OQYwdonx4I/FaxeL
   A==;
X-CSE-ConnectionGUID: xiSBGJ7fRUu3i0LNRr7KpQ==
X-CSE-MsgGUID: CVaoZyaPThmNCOHwycfORg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25729096"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25729096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:02:42 -0700
X-CSE-ConnectionGUID: urG/A3EmSNu5wHgwVBUEyA==
X-CSE-MsgGUID: Hyiu+xgaT8eVU+bqsETMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="43008632"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 03:02:41 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 03:02:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 03:02:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 03:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdTP7bpmlXl9nUyS/wPoOGjvr9Zkr0RQx9rS1NVFXY8oaZCji38o1EC1OLfHdavyg3UKxc9gZBSJTbhkecmXhwcqhgJ59sUGzdSJgN9t6FpXn0yQ41chLIUiF5QlJgmIBDCiugRAD94v+r8OvaMbHjipcjwZamX+CX0vaa3vdUKR0XyZNGkaRMCV9CO05bAwl+NfXFqacld3IOf1KsJx7nxkTkXWlZRonsmeM46qlr6GgcseeYXBPbehi0BDf9kkn+e3YFhwi0vTtTL4AKv5RteNN7RnkW5oX7loKjgXYtDA1tqhIcjQQ/uNSAsTR2oxsFQgt8jKRp5RmkAEInmnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CkhCofLdXhbtvTAj2onzd0sk2xJ9XByC/ewL3nRs9w=;
 b=gNP1MfLSEmsdeiDzKjXtVjfzVElbKHYaD4C2JEBFoiWhzgpjNsN7jkRcOy/67OT+X7uVm1ZcZA9DLRfOUCrFnqGBDovep7cTHa2tPubwoLV+340Pu22LkCdv/6RwVozdTEP06dEDbheFa8BS4yfMEk3X9cJxGu9fdlrjTnd4YX/4Nog85Yzcs6+eeycxdTOAlAxriNTuQLhWD++bjgOoAik5Em2oirEkoXSfyS0xV2oIwvy310m+OA3R3WtHfqcRxeDayWfVpV4WuT/2EwvZEj6wFx9WgqO13vj7w/Lw+wCjcRtKr8jDLnycDLtuFG7pS5cTxcUheeDhLtk9/7P5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 10:02:38 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 10:02:37 +0000
Date: Thu, 6 Jun 2024 12:02:27 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, George Kuruvinakunnel
	<george.kuruvinakunnel@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/8] i40e: Fix XDP program unloading while removing
 the driver
Message-ID: <ZmGJM1hHOX/dvSYY@localhost.localdomain>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-4-dc8593d2bbc6@intel.com>
 <20240529185428.2fd13cd7@kernel.org>
 <778c9deb-1dc9-4eb6-88d6-eb28a3d0ebbd@intel.com>
 <ZmB9ctqbqSMdl5Qu@localhost.localdomain>
 <20240605122957.6b961023@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605122957.6b961023@kernel.org>
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c7929f-21b5-4b2b-ace5-08dc860fcb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i4tm/ay4qaIZHQYZjJ5tdUeEsVaYaKqK61NGc8N9BbrQs42kNOeC50nbf2b+?=
 =?us-ascii?Q?M/sXXZFgUFkORpquZ4FYJ+OeEFlFH1s993iQLtVxM0YEF/+O6DU2bhIQpSw7?=
 =?us-ascii?Q?Gou7IDLm96hPqyZxn1xvLUoeViYfcRcY/aY1DAGcN7UyniniNpUmwEs6FakT?=
 =?us-ascii?Q?pXxD/jq3XfJBfkI9NzNyYR+KQEBB8c7h3iY1qS90GT9dnNmYbjs+st1Qy3tg?=
 =?us-ascii?Q?vflAzz2FT3IOiGZyaL0mj3fwTgJRL1ibW0r2pZmoVbNKtlFhl5M1Ydr2jJej?=
 =?us-ascii?Q?wDHONGH8hnPetevJP2kq5Ru0BgqLx5QriqegXD59n39xv5DKpYuIRyhjBlkE?=
 =?us-ascii?Q?dPrKQ2x/cucysa8Z77ISxi9NVpi9+BmqzvusjANInC4orp8B1ieezvXZGqaw?=
 =?us-ascii?Q?cIAZR44xGmtfUeiHic4HTUyhcyFvUOgp5CaJhlsrWRIzy8tEivTf+2XDTahy?=
 =?us-ascii?Q?mbXcVpuo5n42bxXjmNX1WqdzAtZ6+1m5En7USFj5j6OC+u+IvAz3T6CLdOwz?=
 =?us-ascii?Q?NqooXxZWB6W7ccZnT3iFFL5tkZFH5ySjiU2cva4HJtCJIniqeisgB3jSKWdb?=
 =?us-ascii?Q?TLDGWQe5nP6Q3EYWZHuTTTuJp1vkXovVPoO0VN+HHU9kB8RNQaA6EnuvRokn?=
 =?us-ascii?Q?LcsvH3Tj3PEu+42JH1wR3sn/GfO+qC+lyP2ENpl0HjETwhsUIQt5KVy4XgyZ?=
 =?us-ascii?Q?YOkbRzR24qL6ssghHhbSxsQ2PSZmi3GqT7O5ImKD8FD0D1GwfbXURClDb0sd?=
 =?us-ascii?Q?84fBtaN8xw9Gpz458WpicaD6+vGL76ZxBK1sen3TNtPAfKkD44phZcQL2rbx?=
 =?us-ascii?Q?FASZ7gPl97Rn12z21xW5GTz2ZoX8WBSEoDJrTxWTxiVirfjdBuOPWD67gkPb?=
 =?us-ascii?Q?dUvwVq8XPSWV0TEmGkQ2pFjKIz9D8Wt7ppr3HTXqli1QneyNXoPca20jWNGj?=
 =?us-ascii?Q?OcAnCEbUkX60yz96FqBvmfndNeh+XzJPrCDb7o8az4GodG3Vj3Nu/LYPoGR+?=
 =?us-ascii?Q?K6F5mTWj8OBQCPAoyb0CUzBtYX4Eztc1vSNxUh4nHB1SIybQv5RknvWIJrMM?=
 =?us-ascii?Q?Bj+KoEgduMeH29dCrWhqEHpT3TYMcg41NaED26oSQ0m/VV3oyb6M/2eRwWYu?=
 =?us-ascii?Q?h2BfWbZ3sytWHIUQAQ4dLzjSPS4rOPYARX8e4hyjrg4NYiZULvBlHqMQoQL7?=
 =?us-ascii?Q?dsnLKUqbr1fP8p/sRu+pP7hsi6UWLhNduKel0JC/Wb/GD/FAlB6UTqqzJ/M7?=
 =?us-ascii?Q?kHB53w5YLgmFt+SThP/+tPLybOtMEyi5upG9ZO3Occo95D7TnSIKUxC48GQv?=
 =?us-ascii?Q?kwmrBBebqTc7cp9mK7dpjGfF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8hHVgc/y12zfj5Q3Ac+BTR1Y/b4h7AvVtoWjwzh8rVwvqbtKvpGok4j1qq0?=
 =?us-ascii?Q?jLVe3WMrAxuOkM4kzlkhaWskQanbNMT94pcYcVImih5dvpConHHKq3/nR+0g?=
 =?us-ascii?Q?ydSkkSaT4dx/R2QnR0jAAKNkJSY3BXdVa9eXRBanVlWOUux0Go4TKwJqU7Na?=
 =?us-ascii?Q?lgA3HTOgbwf189CxOZlDBjP3K2KJSU6Qk9g8xgJbXRW2bhhhVans8C5eCv7Z?=
 =?us-ascii?Q?EJiY7ZzQ3000651G5HJ5TJp8tuywmzjtNtRIs+Qs8Hlbw5agJTcg1+1/TK9D?=
 =?us-ascii?Q?HY7mM9Kj2j+0Z/CEFUAGw+/Yy5dLJ7fS5j1aFzYM4i0f/Qsl76NJdQtR+4lz?=
 =?us-ascii?Q?iA1tvqor1pDYVUFle4475UX7GyIapLsFt9oW7oDhy44KT2KliN5FLx2OkXCc?=
 =?us-ascii?Q?4nCSd0BX7JRBUfkg9ET6CiiBKNrRaQA7obQzdKFdgZTCb91epxo2NYs9lIED?=
 =?us-ascii?Q?1M+yGGb+zmHcfGFtUV9LBYDXzPc67UtkYaw+Xdjf9KW+58awTsOcpW7ZCKOk?=
 =?us-ascii?Q?VX7of0Gv8GObJ0IsPN4Cir2uA8SiZ2iZDDkAQAgc+zP7iLZgeq0vumhudT1y?=
 =?us-ascii?Q?WcwdkY2veX6XpweC4mA6YYZHIo0NNaU1sRTTc77HwhdZUBS+epxTx7I2g6hV?=
 =?us-ascii?Q?XlH9yxygDzsCIoHacHSTj/yo5R/drEGt2h2Ak8uOjkiyXpx4XxO9LQP9L7K/?=
 =?us-ascii?Q?cYLIfAUPts9pan6dMElXd9abN4Lbkz6Wn8x10gMpQI8j8LnNBhX/o020odhX?=
 =?us-ascii?Q?8jnh53W/wUzTMqIDa+fZo5zDxmJ2o3R+iws50ifweO1B4NxvjRVL437YqBA2?=
 =?us-ascii?Q?pV4O6lLH8y+HVZ9OF4Bvpc66GvNzFoS5hcB1L/FJF8EIBLcnKytbA8mrOrcZ?=
 =?us-ascii?Q?HUCPLYDQlkDtzJzyxgLLWHJ/wRLw9b+0QAhxde7AViOGjtc5mvMMYadQ/KZT?=
 =?us-ascii?Q?9YAY0IcUH9yW1NOknMj2hhBiQk9COJ8cEzxNIeKyYgcrMRUeqK+PKvE7UDwx?=
 =?us-ascii?Q?O3kqaVnrp1d7eVkj5xCzkDDjMLcL4J006CT3URMCqVBxpcvenpAm4jisYQHd?=
 =?us-ascii?Q?RBeLsgA5hhohgoWMf/7uIjdeAXaCHSh9hd0XQzx2Ecq+fBMRtRDbgpSXQCyj?=
 =?us-ascii?Q?9oEuxQ6FQUfUm9tCIYmjxrgrEr1cxv/kIx/E+eWgxo1h24wxomgMUD/SzMwE?=
 =?us-ascii?Q?MOst1bOL+L/bZOKz/l/iCD7gKinzn5lW6NHItI2B++rqy2kcKGliRUoyceFp?=
 =?us-ascii?Q?87pIZkbAujUIdkzoAAWRdp48SVSsillP9EuPh27URCONl0O7Ww6FC/0qC3TR?=
 =?us-ascii?Q?e074of4NrnF0uK6PsulAIFgxpWSq6RYWesGB14JcfW42Ldz7/FTCKPGeG6ZL?=
 =?us-ascii?Q?U77aU55FqMIQiTAIkFEyPTfJn237JKpGVpCeRxZFvBjwmFMbuQ7KeJ7HB0zU?=
 =?us-ascii?Q?ajkkGcF5HwM70HtuOvwTJ+JwoXbQDVc4ivBWv/hNhDocmLpY+mMkC/dhqwMz?=
 =?us-ascii?Q?RfPE/fw2Kq0GaakvpNZUx+iid39vXRridP+sLvBXK2IYR5h9D1mTDb/WwnRu?=
 =?us-ascii?Q?/ZVfuzCYiCMlikjst2169dn1mBG4Z3lomTmpec/N4oR4VKmlzPlux/r+UBPU?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c7929f-21b5-4b2b-ace5-08dc860fcb8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:02:37.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqzwTGjCTk3U5MTDw5YHw1TgYRkoJAAnFzFr2SMcwODAfgIT8DmJip9sVZLSUdNbQ7qQyIC1MLWXbTe2FYyKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com

On Wed, Jun 05, 2024 at 12:29:57PM -0700, Jakub Kicinski wrote:
> On Wed, 5 Jun 2024 17:00:02 +0200 Michal Kubiak wrote:
> > I am afraid checking for NULL won't be enough here.
> > Normally, when ndo_bpf is called from the user space application, that
> > callback can be called with NULL too (when the user just wants to unload
> > the XDP program). In such a case, apart from calling bpf_prog_put(), we
> > have to rebuild our internal data structures (queues, pointers, counters
> > etc.) to restore the i40e driver working back in normal mode (with no
> > XDP program).
> 
> Apologizes for asking a question which can be answered by studying 
> the code longer, but why do you need to rebuild internal data
> structures for a device which is *down*. Unregistering or not.

Excuse me, but I don't understand why we should assume that a device is
*down* when that callback is being called?
Maybe I didn't make it clear, but the ndo_bpf can be called every time
when the userspace application wants to load or unload the XDP program.
It can happen when a device is *up* and also when the link is *up*.

Michal

