Return-Path: <netdev+bounces-113762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9C93FD20
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C721C21F55
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3428181328;
	Mon, 29 Jul 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+s/Rhqa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8016F278;
	Mon, 29 Jul 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276526; cv=fail; b=ocT/0QvisGxF0wXbHPRoHSNfF48wk/ttsK/H0c8jUzB3pnQNXbrnbAhXtlSV+U231sJVsCuwf1LTsxuYQmxRF9MLuSAu+m0Ib7eNCjvASgk0Z7vV9lV+1DYnbgV32AAmPoioK1taWbcojyWnevMuKFfDUlAmhJd5ybRHFS8yJpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276526; c=relaxed/simple;
	bh=8zLDlthDerpHuDt0YNjf7d79e9aRvopB5csUc9cIYmo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5kKg7M4jkFcGG/wG8bTUY4CYJYKC/RK6ccgKApXLrK7eYfFEj8ch5CcqFXv1URFO1XumHSbrxdwYgp23uNeqkhCuyj02qgPYJGvTYOH/9OpTS9MxXIT5NSbuPz39o6xuBWl7lfLKlAcqMUsKqr38w3VWyTbNw5byCgYigam440=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+s/Rhqa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722276524; x=1753812524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8zLDlthDerpHuDt0YNjf7d79e9aRvopB5csUc9cIYmo=;
  b=l+s/Rhqat+xbY3WM+s4WkmeboskVoVoEXiBAqB4eUFrwKirlTZUACVBN
   qmqt8CLcZ5mfpWymyIrZTgGCzTVPPStO6V/rUSGFtEHcg7FzD0Qm0LhHE
   iBHF7sXpOwcOrqq/wornaNruowtUjCsQgisrNLVhCkVWGdmI7kSAMbSCv
   fAlT8iyKUntTSW7YdsmVMAqnwjuTQmijpaXCsNQyKhkZB5pg5QxymhFr7
   bNAPDpvyVe+Tol2c/8AcnR7eX5TSHlXWTzoAgaA0MkkKwPP2zibDHnzit
   /MFJ04h9aJNW9HlLlRHq8Ttj5fcXpnA9Srd7JqYjL80ZRs8V0dIlAEFZC
   g==;
X-CSE-ConnectionGUID: Wp6sv2JJR122JZNAiufQYg==
X-CSE-MsgGUID: ymcIVS9vTs2iUK33Xh6dTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20199696"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20199696"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 11:08:21 -0700
X-CSE-ConnectionGUID: IEiVkzFlQQml+s3Nf8Fpxw==
X-CSE-MsgGUID: M3iXe82MQbC4fiS/ZWCdLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="59150755"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 11:08:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 11:08:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 11:08:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY8Nw5cuqqxs6By9uIcNkdE1cAXV99CfB8VlfbpyjH9oeE8uHHzk7BjCWfd9eWW16YwnzLZ8UBAKqb95LVD2lkp91+IpGEUGlG6m/tA1J0VVxPqOgOnSuc6QbkdTUp/rf4+llmWF+ojup6lwt/tZD3oOjKSgHE3esKrmuRCYKNW1Iz7Tn4eSymaZRfveB0zvBivkhwxsjWljL6cyFZSYdbUkfcuF07AVNfHbH7sj7WQE5dbt1pM9UBHemSOe1KemicIids5AEMB2TSUZt1d43Apm5hsMdSkGj2jPuEIu/KLjm/nbJrJs+urv4O1XscPpD319Pw71BfBLIwhwTxtETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE7WDPfz/hQ2lqGwgPbam7S6BgJL6qUpDJiVYwoHlCI=;
 b=aNvWzMAjxVkfxxmAR8gPQhfwIPK3EE9vJphXSkd5bfbpQ9UtcYnczen2z6+YpTKzFyh9VKEFo3Le2LMlCkXXwPeX3IvX7shqHjFv8K3nP6In+MhXlR6uUoVg0PuisjVl/XzKr1xfwMwj4/kICv0aWfmSD9netLDFBhrtx1IFk2xAqImp3P4rYim4FMtbWiRh6j8Ui1xxJglPV7AlAALtGprcz3QaoCf/CqbuoFOohbAWZYmQD2lQ5cqcyEdPBUirIiGmAI67xsmVvf13mqjD9W9h94SlfHQ359LBaWBearakViuVmxmIIccaK3BOAn1tGAe8qT+BMjC3IByJxr1OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:08:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:08:17 +0000
Message-ID: <e4de7c23-ffee-42f6-aba8-b10f3d44f22c@intel.com>
Date: Mon, 29 Jul 2024 11:08:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 04/14] net: Change the API of PHY default
 timestamp to MAC
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Florian Fainelli <florian.fainelli@broadcom.com>, "Broadcom internal
 kernel review list" <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu Pirea
	<radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, "Andy
 Gospodarek" <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-4-b5317f50df2a@bootlin.com>
 <39c7fe45-fbee-4de5-ab43-bf042ed31504@intel.com>
 <20240727154426.7ba30ed9@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240727154426.7ba30ed9@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c63e5d-665c-48d9-a5c1-08dcaff96c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUVlL3AySHJSWXZKdVY5RHk3YUFOUGM0emN6THFGdUlscWtCQjlHNXVDZkpm?=
 =?utf-8?B?d3VlT05GRjI2R0VndkZZTlQ3Q3BzdDhIS1ZQblA4UmNZd1AvamVWekVGNGtq?=
 =?utf-8?B?azRXeGswaTRTbDNFcXgwMFlSODV4emdDc2lLMXEyMy9jRVBnR0FGUmwxQnVU?=
 =?utf-8?B?bzVLcnl0Uk1PK1NiK1BFc2VZWkN3OFo0OE5WMjhYQ3pINFVBajhyZ3FpcHBa?=
 =?utf-8?B?M0JNVTR2UkptbWNVVUN5aXlENEd0NHYzc1VFSnZkb2FHTUNNbWFjRFpiendN?=
 =?utf-8?B?TXk2ZVhjNklNVW5uckdiRXRiaHB5VDFTL3p0MFJycFp6eVB1clIvRnhBbFR1?=
 =?utf-8?B?K25GdEI1ZmJzRVEzNXV4Z3pFenVyTFBzN3ZpajFhc0RhQzVqMTBaS0tZTjk2?=
 =?utf-8?B?UWpZM3kxQnpXWFlLb0pIS1YzSHowaHRONnJ2UWZsdUxDYmxQcDBsQnNTSWNX?=
 =?utf-8?B?SmZMT2JlSlV2emx0N085OU5XUnd6OEFqbm5ZeS9GcGxuL0RXZ0g1TC9pcUdH?=
 =?utf-8?B?WVZHQThRYllydkpzUExWVEZHZHV2dTIrZVpWdnhCMFA4V1lOeHRZaVZrdmlT?=
 =?utf-8?B?a0FvVVpzeWdxdFBwc1o4ZXZTb2lzNzJmLzBUc29wTitVSkVnQnh3akJZVTlY?=
 =?utf-8?B?K3JSRDdNK3BLL2JYeW5LUUdFZUJpbFkxVlpTTmhMN2R4L0JHcyt5RHgrUVFs?=
 =?utf-8?B?MDJQWmdRaGhiamJlWmFsb2RZcEZERWt3dEZSZ0pkRU9wb0R5SlBCN2hFbWYv?=
 =?utf-8?B?SmRMZnB1b2ZNdnNFeGFXWEIyMGE2MEpWMU1oTzhDZFRqczBJMVpZelFZb2U2?=
 =?utf-8?B?b0tFS2pDUkhOalJUY0dNSGo0Y2ZZZWVNM0NlcWsxSlo1RHJpK0gzeHdCWXhv?=
 =?utf-8?B?bzlBbmxvYlpjSEU0SzFuek5GUFBOY0FkQVdQb2R0T0JtVWpXQUlYUFU5NUd6?=
 =?utf-8?B?SkZCanYrM3pSRE9wNUhib1pPc2tvRkkrWEhUZlhWRGNWM25iSWkwRlZ2SzN6?=
 =?utf-8?B?UTFzMEJEOG5UdVdadGNDMGtzVlFYU21xUHR5R1BuZ2tveWlEYmZPa2Q1Z1dp?=
 =?utf-8?B?RXlDOVd0Q09xNHo0aHo3WHJ1RU42Z3pFN1g5RzF2cUJkT3MyeDhEMTNnbVl4?=
 =?utf-8?B?N3pLQzJHTG1kaENPem1vblJqRU1NTlVDTUNPT0hqdGs2QUpZK3lIeGlQWnBX?=
 =?utf-8?B?N3EyWUR4M3JrWWFTRlNhZThwaWZ6M2VlbEMvbzJOYktiTU81WXh4cUF2MTJo?=
 =?utf-8?B?bnY1Yk1kTHdWYU5uRjJSbW1wUTRTMEpiUVRMZnFYSHV6U0YxcEF6MERFVjFx?=
 =?utf-8?B?cjg2bUQ1RGRUazZGd3l1R0dBV2trcUlLOHFQQ05PbXJsM01XM0FpQ2MxY3Z1?=
 =?utf-8?B?Qm5YSkFJSXFMN3BiTkpKK1p4YXN3akliQVVmUGxvS2ZIS2xYdWtkWG1DcVRO?=
 =?utf-8?B?cGd3VE1FVzlreTUvT1l0WVRxV1BBM3JyZGJMY1QzQi9TV0N1MUxFWGxSUkpq?=
 =?utf-8?B?SnJVN3p2UmJyalE1LzQyaWJ6ZHpRK0VQUmg2dnFRaUFHSWVYTmx3M1JTS00w?=
 =?utf-8?B?OWZ4K0QxL3czZEdERjBUNktLdXJ6cmN6TWRtUWFvSlVuWW5Fa1F3SHZUQ3VB?=
 =?utf-8?B?bEU0bWhyRjl0akxZTmlGMnR5Z0orbGhkS1VCKzdLRmFFaWV1U2hNTEVHMy9V?=
 =?utf-8?B?OUdEQmhMRlcvTzdoKy9yUkVTQ094Z3hsOUp6dkMvZ3UrcWlZVnlFMmk1bFVN?=
 =?utf-8?Q?E8MRM+eA8pkBS1+q6lZLDhdE0C9P6dF00HbECDV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdYQkxSS2luamVHVThKdmdHZytzVE4xcmlYczM4UmRvR2VxMUNLaXp5MGRU?=
 =?utf-8?B?dkZFNkJRMzA4Rnl1T05QL2Q4NHlYTldmYnkrYmw3aGg1dW9DeEswY01RWGJS?=
 =?utf-8?B?aXM4d1U2dUlRYTJmVEZ0eHVoSldrQlRrQXU5VGEwTjdrV1hzZ0x4b0RPVm5a?=
 =?utf-8?B?WDBOWU9WVEVjWVljMWFsN0pBazAvVWZoZFpzNytmLzR1dnVQbFdsalAxelRq?=
 =?utf-8?B?YU15RXk1S2pCQkZCclVxekwwdlRUSXNEYk5TQWRvL1JoZ0xZY1pqS21yS1BI?=
 =?utf-8?B?MDFvcVRsSWI4RDFERjVnQjk2b3RYbVppK1VoWW9NMC9paG5pMCt3aUlIb21m?=
 =?utf-8?B?RHo0YlZKVjJGNC8yVkFDUWt6aW5qSFdmWWJpV1orWCt5b205STlUa1Vka3Jr?=
 =?utf-8?B?RGZkK0dGY21sQ25jREpmb0ZuQ3F0dFR1WDRSK0N2RHBEcW55NSt1dkx5dkdk?=
 =?utf-8?B?bW8wcllPSW9jZGdpMU5hWjN2SVIrSi9nYXV2VzJzbzJoOGdBRlRrbXdicUpH?=
 =?utf-8?B?WGRLSnBCT2piam9RSjhSUTlveFNlL0RRMnFhb1QvRTk2UnhrR1VOWURLRXhu?=
 =?utf-8?B?L1BLZmRuTzVNZDZtWmkrK2dkdnpZcHZlY1JZclYxSEJtWnZMUGh0b3pXSitu?=
 =?utf-8?B?TEoyRy9hZUQxSEVtdno3dk04VmlXbXNEcVhaZDUwVUExd0Z3bk82ckFMa3hq?=
 =?utf-8?B?NSs1a25KNStNYmFVa0pxdWVXSmUzbzRnbWVEQUM2VVdHb2k5WktFVEg0MHRT?=
 =?utf-8?B?WGVlZzZhMjJIZk9uL2hJUGx1Q2VHM2c0a2NvZ3E3cE81VHdMcGRFZHJ4UlJT?=
 =?utf-8?B?Nkx1dG51SHVhOExNYjRmYTIrL2M2OXlERVZqUGx6RUwrdGczalFzZDgvNHhV?=
 =?utf-8?B?c3U2Y1djOWpoTEc3clIyNjlBeFkwZml6TGF3dlZUdi9HVi9adXdFdC9ka1h3?=
 =?utf-8?B?T1M4U1BEOXBaT1JwMmV5RmY5N0ZCN0RxUElTUVl1bUFaejNJajJLWU9uem5D?=
 =?utf-8?B?cEYzRkVqeWppaFdEZWp3NkI4bk0yUVNvdFh1UGd2NHNrdkptQjRhcmxWQWVG?=
 =?utf-8?B?OE9JajB0S200NlZUN1hQZWdIUmJ0eUpYZzFqMCtONE1Rdzcza29iRmFmZjlq?=
 =?utf-8?B?S3M2QXAvdlFtam1QN3RPSEtsTTBMVEJWUzY4QWtwQk45UnNMbjF3WnkzMnQ0?=
 =?utf-8?B?SWVzLzdpL3FNYWdubkFjZ09ocE9mTVNXbHk4UmswbklTRmlDSVJWRE1DdnNC?=
 =?utf-8?B?Qm9rOEh6aVA3TS92OE9ESWtZU1U2UmdKWlZyUWFQRnE1UmdPQ0hNUVJRYmxZ?=
 =?utf-8?B?S2YxbS9IQno1RUt5ZnpRdWpDMytxUFU1ZEl2QUorbVJFRFcwb2VvZWt6anE5?=
 =?utf-8?B?TERkcjFwT1FpWXFVUksxekpwNTB5a3BBNUc2NXY2SU5rajBkQ04rVmFpd3pS?=
 =?utf-8?B?YWt4Um4rQjIzejVwTm1mWkRrSWw3K3h4Y3dWOWR0Ykpxc2Z0c1AyZlVMN0NM?=
 =?utf-8?B?RXlxOVhWczhFUzZ1M2JRN2F5MWF5UW5jdmo0TEpyTXRYbEpIZEFkMzMvM01Z?=
 =?utf-8?B?cWZ1TGlhV1ZvUVRYcjhVa0xGWHlVaGN4RkIzczRZYzA2eXo3dURzT0tIYnhV?=
 =?utf-8?B?TjR0V2Q0cTlLY3FDWk9XcFB2em5VOFVTR3Y3RGFPU0VIZ2EwRlFTNFRINUFs?=
 =?utf-8?B?SXR5NzlOMTJzWTRIYy90bHBPWTE1MFQya3lPVmQwWmdGaSsxMEFLRUM3ZTVT?=
 =?utf-8?B?RWJnZGFLdEVibVBLUWJ4b1pIRzNtTVpRaFpNMmZEcGhJdkNwQ1RHSVh5NG01?=
 =?utf-8?B?V0RvOWtseFg4K1NCT1daNFF4dDVVenBGYStodVdQT2FIcGFKTVVGUGh2L2t2?=
 =?utf-8?B?aXBYVDRqMFBmaFpQOStUSjBKcVg3Qm9zTDlPSWg2RFh3NktNckhEZ0h3SlA0?=
 =?utf-8?B?aitmT1BVdlRnU1ZWSjV3MzBkbXFnOUtpNEtJS2Q0dVNTVFAwTE1qQ1Nna0kr?=
 =?utf-8?B?WGZMRlpWaFhLbkRBNVpFa2lOZTBydlowci9pYWk1R3dDRzA4cTluZWZtb05a?=
 =?utf-8?B?amNMeXgyMkx6TGFJOVRyWCt2N2xSZ1lKSnVNSE5ERkpIZCtPUlJvMFArTVFn?=
 =?utf-8?Q?GO1s4F+/MjDBWjYwSLk9qcEU3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c63e5d-665c-48d9-a5c1-08dcaff96c34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:08:17.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKAfxTlV9ryATrvtzxAI5voxBi0gICnPoCX3uGb5HB5258yM7Nfkk23d0rRZL+Huo+xNfI8RSxsvS5fPZO+385DwOA19043Q4rNf0DIGNyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com



On 7/27/2024 6:44 AM, Kory Maincent wrote:
> On Mon, 15 Jul 2024 16:37:01 -0700
> Jacob Keller <jacob.e.keller@intel.com> wrote:
> 
>> On 7/9/2024 6:53 AM, Kory Maincent wrote:
>>> Change the API to select MAC default time stamping instead of the PHY.
>>> Indeed the PHY is closer to the wire therefore theoretically it has less
>>> delay than the MAC timestamping but the reality is different. Due to lower
>>> time stamping clock frequency, latency in the MDIO bus and no PHC hardware
>>> synchronization between different PHY, the PHY PTP is often less precise
>>> than the MAC. The exception is for PHY designed specially for PTP case but
>>> these devices are not very widespread. For not breaking the compatibility
>>> default_timestamp flag has been introduced in phy_device that is set by
>>> the phy driver to know we are using the old API behavior.
>>>   
>>
>> This description feels like it is making a pretty broad generalization
>> about devices. The specifics of whether MAC or PHY timestamping is
>> better will be device dependent.
> 
> As explained, except for specific PTP specialized PHY, the MAC is better in
> term of PTP precision.
> This patch was a requisite from Russell, who wanted to add support for the PTP
> in the marvell PHY. Doing so would select the PHY PTP by default which cause a
> regression as the PHY hardware timestamp is less precise than the MAC.
> https://lore.kernel.org/netdev/20200729105807.GZ1551@shell.armlinux.org.uk/
> https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/
> There is also discussion on how to support it in older version of this series.
>  


Right. So it is a bit of a generalization, but in practice it matches up
with the available hardware on the market.

>> It looks like you introduce a default_timestamp flag to ensure existing
>> devices default to PHY? I assume your goal here is to discourage this
>> and not allow setting it for new devices? Or do we want to let device
>> driver authors decide which is a better default?
> 
> Yes to not change the old behavior the current PHY with PTP support will still
> behave as default PTP. The point is indeed to discourage future drivers to
> select the PHY as default PTP.
> 

Ok great!

>>> diff --git a/net/core/timestamping.c b/net/core/timestamping.c
>>> index 04840697fe79..3717fb152ecc 100644
>>> --- a/net/core/timestamping.c
>>> +++ b/net/core/timestamping.c
>>> @@ -25,7 +25,8 @@ void skb_clone_tx_timestamp(struct sk_buff *skb)
>>>  	struct sk_buff *clone;
>>>  	unsigned int type;
>>>  
>>> -	if (!skb->sk)
>>> +	if (!skb->sk || !skb->dev ||
>>> +	    !phy_is_default_hwtstamp(skb->dev->phydev))  
>>
>> I don't follow why this check is added and its not calling something
>> like "phy_is_current_hwtstamp"? I guess because we don't yet have a way
>> to select between MAC/PHY at this point in the series? Ok.
> 
> skb_clone_tx_timestamp is only used for PHY timestamping so we should do nothing
> if the default PTP is the MAC.
> 

I guess my misunderstanding is what about the case where user selects
PHY timestamping with the netlink command? Then it would still need to
do the skb_clone_tx_timestamp even though its not the default? Or does
phy_is_default_hwtstamp take that into account? In which case it would
make more sense to name it phy_is_current_hwtstamp.

Either way this is mostly bikeshedding and probably just some
misunderstanding in my reading of the code.

Thanks,
Jake

> Regards,

