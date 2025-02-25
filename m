Return-Path: <netdev+bounces-169434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420CA43DA3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E59D170B4E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515F203709;
	Tue, 25 Feb 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJpEmArC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B691E4AE;
	Tue, 25 Feb 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483062; cv=fail; b=a5rNbo3IGwWB33DMiYzGUv7fVY45KacHyI6mhZYKDoD+UoDOxVEb9z853B3WVSbemto7RG5GkKSG8O8YA53irJ5PChz7i+DCe5UOMlIvSUBM8/HB0G+rJkdNyTDJ/I32+wmeXdL80WdyGTcRkOK2hBwFBy6LkIx2CIrBQyTxa7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483062; c=relaxed/simple;
	bh=xLby1N+GE/VmnBpZcDyMsCXbHGDABRnI2055KH3p9bU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MuezGIhPA/JJPTxq/3GIeH0VxYs7Jp6sCB8rPwxuCrVkg+eafj7IJd+yAymwuha3ekbw5L06RP4bMhmic3Yh3Wd/sV3cHjELAip9Y2o+OvIuxlGKm76STjbOD76P2X6Kl5sKpJQM/bSjwJ6Ew6T6gmxedyEs4qYtsgyKE3GVih8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJpEmArC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740483060; x=1772019060;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xLby1N+GE/VmnBpZcDyMsCXbHGDABRnI2055KH3p9bU=;
  b=IJpEmArCcPkuHXfWj40pX3+DOcUQD07v52UmuE61QAmGKK3mzEldv52z
   JBjBITHFVjBYjhLSgrvXXUzejEcS5OBGVIGyoNfIaeo8b1WAqorgZnflW
   hWIzFSIxJC8fLaVmiY+WQIggylwmpEAm9oKf+raIJ73tAsudh7Nvbzy8Q
   SPQLIG7xBzcNam+TzaCAI+2j/D2ERryiCiT+6YGpxnGKis0pecwiCphc1
   xV8wf3HM8jxqg5OuVXnrIqrbA/vWwU9rpVXofY6ulfuwuoZcNq72TQUGG
   zI7Sim0QBM0ItakNmKbctHooyD1PNn0uvR9wYBH8jUsexJlzNssacTjbD
   A==;
X-CSE-ConnectionGUID: 7cBcpXPlQHyFK4sqDclM+w==
X-CSE-MsgGUID: JfT1lezzQqi7j1rsFdl/Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41198922"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41198922"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:31:00 -0800
X-CSE-ConnectionGUID: xwOSQ94uQmi7nUOcpK7rvg==
X-CSE-MsgGUID: FHVdLhAKRruk8Af5EuDlpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121615442"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:31:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 03:30:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 03:30:59 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 03:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfubIaFho2nFlMqnLw7cVdLlEA9xCYkGSCkVaI4BQx/guqNrkRt19egUa6SMEXs6qrvWlWOsuVUVArHEWvxpH+eMuUrkgYeMjzkHzYqr2OlGM4n1x6/6YYsZw5SvGxcaTiZR6hiENfPR2uq1sZx6vmDa0cWN+vXKynaLTayrcTyP33gZ4lmwjPxpjcdmfDLyzO81Lc9DnIC8xCUD7xs3Oh0zkMNJF8B6mIJY8NyltN+ssTx76Xr3y3qqk4spSpIw0g3HotQFF5ckvOGFCso9VXvZ70owog74F8lA8XV7SVsK92aqOoAW+QC0nANNkeWWnfknT69RiyVgkyj4iz+LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gIPG8Tif0i56AjYMqwpwyi8rpuPOIF/BWPwOGYdKKw=;
 b=FBieTf15St1F+xRC5ZiYB0FGWQBrkfVMemqpUph+GA/bIiFfZVXRwp2sK36AjAJ7ToLwKHLXuHrRFulrjsuPlfbLZ9yFIozksP1Y1oZMs1I02yFjZ9hxdpz7tD7hXMHmNzwiIRZz3T8svYT+Kt2Nbnn40eohBfufnSaBQXWkXqcIgxw4ITgZHmMN0x8snamQjELMutQhzrRvm9voTfb29koM0KaN0VCfrc3xdXZsw1kHt36ay2Sydqm/SofajVOYj+btDXmTCCQNc1to0gWTe1ytvnRxP1V6UqbXFF0qoiPwgsnnmj6WRvQsr2nVMOFSlA6MGfVpVrlXwavJFuvKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 11:30:56 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 11:30:55 +0000
Message-ID: <87855c66-0ab4-4b40-81fa-b37149c17dca@intel.com>
Date: Tue, 25 Feb 2025 12:30:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
To: Jiri Pirko <jiri@resnulli.us>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, Konrad Knitter <konrad.knitter@intel.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, <linux-kernel@vger.kernel.org>, ITP Upstream
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, Carolina Jubran
	<cjubran@nvidia.com>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
 <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ybrtz77i3hbxdwau4k55xn5brsnrtyomg6u65eyqm4fh7nsnob@arqyloer2l5z>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 806d5698-76d2-4edf-8044-08dd558fde72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDJ6eWQySHZaSDJWT1UyNzFtSTArMkFjdG5aQW9ZOWc3Y2VFWDV1WW5OVnBU?=
 =?utf-8?B?K0NJNUxHS1hSYmxaSDU4S2lPNVhXaWJmM2VKSjZERjNiRGpQdk5pVUxqRHdD?=
 =?utf-8?B?SHBrbENXbThHYVgyaVNxcjVCaEdOK1pZWTJrUUxabTNKaVphS3VMWk9nQ0oy?=
 =?utf-8?B?Zk4zUHQ0dGEzd1N3YS9YSXZwNW8rRGdDZEd0cVoyS0ovdE1sY3ZFc2U0OVli?=
 =?utf-8?B?akhjMk9wWXlKMU12ck9tYi9xdzFMSnArSHZCZU44OTFrQkpqc1VPcGp4ME9h?=
 =?utf-8?B?V04wV3VtZnpPclpIdUFRYTc1RHhsNEdsNDNGRjdaRytWZEtVSmlCU1NReXlR?=
 =?utf-8?B?SFVXVnowaEpBZHJvM2t2TTBWdVBPczhlMzBJY2JjeWtkZjcrUElNamRRUkRV?=
 =?utf-8?B?WFpsZ1lJb2RCUlk4M2l5ekdTVlc3dlZmS1pmUEhsZzFrOVZWZDNJODN2d1Zu?=
 =?utf-8?B?cDgrUVkydWNjekZYSEVQM3hRU1JCNVIrKy9ZQU1LalZ0V1FZNHYrL2VJb3JJ?=
 =?utf-8?B?V3NZL1NuZnZjTkZiYUlEdmM1M0hTYXh3a2pCV0NtUW5OckVaam0wZEMzSmh6?=
 =?utf-8?B?QWM1ZHJrWDVqUU1WT2QyRVhZMHRjTDhHTlg3Z2NOM09Fc0tnL09ySE4rZDE3?=
 =?utf-8?B?U2pPMTNIUysrV2xKQ3ZWb3FFaWpHVk5vaDVKQWYvVkdEVllsNVRidG1WUS90?=
 =?utf-8?B?VkVESDgzK0F1Wi84d0h4TkZlMGxadEhoUC9vaVA0dTd0R0NhMC9pYVZxcU55?=
 =?utf-8?B?bFhucDF0VDFIRVdXMWJvTWRrOW8xNXFlcHdjY2R5MkxvMUkyZEU4clpUVEFH?=
 =?utf-8?B?Y0ZPd044V3o5dUhnb2FPOHB4SGpsbzFMd1oxOGRQQklVajNiMTUxajM2c2Fv?=
 =?utf-8?B?M0lKM0VkU3FRbEJtWHVRcDdXWlFjUmhaUCtFb3k3ZkxhUlAxbUZLQkF2Znpm?=
 =?utf-8?B?WEFQMlhlcmNVejFqVEdLb3VYTXpweDBPcGN6TVVHK2tHYkFIQTh0S3N3L0VM?=
 =?utf-8?B?RC9NWS81VE50WmZxV0Y2SWVWeDBsTm5saVZudzcrOElKTUFqQXlMOWpJaVlL?=
 =?utf-8?B?NEN0cXJVd1ZxaUxsU0RKeGNyMithU1ZGVHFKWFJ2cjdjYVVjM0U4V1FTUm5h?=
 =?utf-8?B?WnE1c2pkMDFKZTlQdEViVXZaY0NNVlBTQzIrc2VrWlRzWndKaHEyUktMclpH?=
 =?utf-8?B?WXRuS1B5MVBxd0JKUFZJcGpSbG9zZGFqZk9vWkNDQUt4em5Md3BhanJvTkNP?=
 =?utf-8?B?SDlPQUFLL3o0Vk42STVKWEc1cndQTG5EaHRKM0psQjhUb0k2Y0hwTGRvbFE5?=
 =?utf-8?B?WS9SWUZlMkxsK2VrMUVONmlYRU1MR2Z4UXQ5bUY1KzFOdy9TWlhRNXAxRi9t?=
 =?utf-8?B?OXpIMnFHcDRuTFpxNVRHQkxnVHdaQkQrakJrbUsxQktqOXozY3lzNC9Ebkpw?=
 =?utf-8?B?TXpSMzhJT0NMWXJPaDNXZDU0MFB1RjRRN1VDM0lmMHdqOE9Cb21SMlUxdGE3?=
 =?utf-8?B?SW13T1JLV1V4YjVYV1dFbVdPYnRIQ1BzZ0g3QmQvUzl2UFoyVzk5eWFMYXIw?=
 =?utf-8?B?SWxGL0Y1ZGpCMmR6U3k3UDFoaDlWZHVMN3k3TlVrNU5sd0QvR2JBZlFXaWZO?=
 =?utf-8?B?QzA4SFc4TWJSN3ZJYzZLZDRiekZCdVk0d0ZMbXRSWDBCS21sZElKYXM2cXhw?=
 =?utf-8?B?eTRxQzRTODRDQ1RGdm8vYmQ5NVQzaFRacGhMVGdRR1VHY3NsWGh3ODg4VUlI?=
 =?utf-8?B?NWZXMXZEL3RnUDZXNmlGVWF1Q0pMaEVHcTBXb2NyQ1E5L2lxdFFrbko1L0VX?=
 =?utf-8?B?alVGQXhWZkJvam9uamYyc080VXpXbFJjb01SRDEwajM1Uk8rZDdKWHZYUW9l?=
 =?utf-8?Q?9kOr/yxgNd6yZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUV2TEJFUVhuOTRFNzdVMlZWNHJmV21tbmcrWDQ1OURteGNYWmF6ZEliMmRX?=
 =?utf-8?B?WWF3T0w5dlova0t6dmVUa1NOazFQWTVGK2JuTVAzYWNiRm1ycmV5WVVxaW9s?=
 =?utf-8?B?V2ZrQ3ViZ1lIcDVvZnRSaHBwZ2hJenVna09CbEM3enk3a3NRUHpkK3hPbWd5?=
 =?utf-8?B?VVBKYzlNZWlaUDZpVWt1VkdicWNKSVphaUpUcjJ0Y0doRDhxTnJNdHJaV2Mr?=
 =?utf-8?B?TjFzNTg4Wmo0OWlBN3RvUGJQbWM2V1ZrQWxwQlFGTGJJOFk5dTI1RncrTGg4?=
 =?utf-8?B?ZE1hc1pKaWNLN3ExVGRuT0FPNW91R2MwYXRlZkUvOTNwdk8yVU1DUWltTHE4?=
 =?utf-8?B?N1lqWXJFeTl5MktyaDVrQ3I1S0VKK09xdHdmdXZZdFAxdjZNcjZjQ2RiR1Zu?=
 =?utf-8?B?RGVFTzEwN1U1OWVlMGxuajM1SWhnN3FaQXc0RkJ4VVhBbjRXQnBOdlBYbEtG?=
 =?utf-8?B?c1JEOGlNWjNhRk1iajBxNDRNOEdzamhPZ2NBNHBxZi9ZaHlXeDQ3M2tnaHRF?=
 =?utf-8?B?Z21DbjZ3T3RtT0VCTEdWbnBnV0w4RUNCRWRKRENTNUZnNGE2aEthS2pzUEgw?=
 =?utf-8?B?Y0R0SDg4blRjWWI5ZHcwQnJHT0JTZFJ0cVJPQTlXUXlEUGNhbTd4L0Fzb2Fx?=
 =?utf-8?B?MWNBZnhrYVYxa1VtN0V3K1Y0TjdaMWU3d3M4SS93Rk5FSmk2T2srR1BNME5l?=
 =?utf-8?B?cVVnbDlVS1FvbFM0R2tWVUhqbDY1eUlPZ254Tktia1M3UzU0RUYxZmZ2eURW?=
 =?utf-8?B?THp2Mk83MXFQSG0rZTdQdXVaL0FMc1dyTlN5WStBbTFUWUlGV2N4UGNwQmVu?=
 =?utf-8?B?S25RL2toUzFyOVNMeGIzQ0ROcmpDcWErRm94b2N4THFPa2hIa1puOEZYaklk?=
 =?utf-8?B?dlh2SVUwRHNUa0tqNE9PUy9OQVp5NXBiTUZob0FLRXF6NE1BenBxZEQvbEl5?=
 =?utf-8?B?dll2aGVseEk4WS9qTjBsOXFrNFVXUkZqejd5bjhLQjAzSzk2MGtzUlBiWkRq?=
 =?utf-8?B?YWdpUVZpd2N0R1U0TG10K01zN2hYa0xzbS84aGFRQlB3cXhNeGl0NGxRU2JL?=
 =?utf-8?B?YVN2N1NtS2lLb1VTa0lvd20yYXZsL29OQy9rMW54WWpXdmsyRWd3alNsYWEv?=
 =?utf-8?B?MnlDamZheE9weEJ2N3JZMlJVZmxMODdyZjJjQkU4bW14ZkVoTXIxdFlsM1U2?=
 =?utf-8?B?Z1dkYnhYYVozNEFJZnM1dzMyUU05bDNycVZmdVFSWHZ4dDFGZnpQcjkwSEU2?=
 =?utf-8?B?dzBtLzcyTlRZUHJ2eXl4eFI1Zm9yUFRJOTNsZGtWdVFjMWNWNCtuRmZ6YmlB?=
 =?utf-8?B?aWtzUnpDQStCMitpTXRFVlFCYm95VVVydXV6MXZrYWNWTmZQZ212QXk1SnlC?=
 =?utf-8?B?MDg4TTNSQjlOdjZjZ2xpblNvU21XQUpJUTZIblNGcTgxOWpXV0Q5eE02dWkx?=
 =?utf-8?B?SEFKUDdubmFiR2lzdnM0enJ5cTdzNUlKK3NiMzNTOVVtbnRHMm1ncCtpcGxv?=
 =?utf-8?B?UFh5K0l4QkFVbjBXZGloVFM2RksvTlBHTjdKZ1FEN2R6UmkzanVOQjU3a1U0?=
 =?utf-8?B?QXBReDV2U01ncXc4N1d1WFhxTmxHVUNZS1Z2a2dIVFl6NVVUcFpaNU9scHZq?=
 =?utf-8?B?b2FWOXJBd045dVJqNlJNRml3MGlnRWd1d25DTC9nUUNIWks4ZGx0eW9wV1Mr?=
 =?utf-8?B?U1B0VWVOckEzd2ZaM0tpUnRkL0kwOHlva2FFVTkvRHBzR1lXelc2TVNCZHB3?=
 =?utf-8?B?dTNMd0d0VWFFMGZ4bStHZHhkRnhaenl3MkhHWG8wSTZjajJQUElLMnlTVFR1?=
 =?utf-8?B?K3MzUDZ6ZEZVM3VTTlkzMWtlS2JTL0ViTVZ4aWdBQkdrL05RbnZOcEIra0Vm?=
 =?utf-8?B?VW0rRlRtdFZ4dzE3MlA5cmVqYVM2UUR6cU1lRWVLMU5iQlVOWnQxUFc4cnI3?=
 =?utf-8?B?ZGJXYkUrQ3lKTzZHUlhudTNBMUcyRTlrRWJWZzJudUZzRmQvWmxhWkdEMFlN?=
 =?utf-8?B?VjQxN2NXTURwQzBjKzgyVVlCeitSUUNpa3M0YzgrNzFjZkF3RXFCQVA2WnZM?=
 =?utf-8?B?RzVVaUFaYlhIQ2JxcURHSlV6L1pOY1pnaUNOSG9Ca1M5MjJhU1pmMTRvakVO?=
 =?utf-8?B?dTk4aW1mS2MvY000Q0dCWmFHZ0ZLSG1LTTY5aVU4L00ycWZMZ2JlMkNhNXVw?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d5698-76d2-4edf-8044-08dd558fde72
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:30:55.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVtwUikoKRmhQE2kXbSmfmFm8omIJrDZR8nDnPr5SCFPFFNqdTtokaZU5YDhDKcGkhbOHdTwGY8xx+kb1Exb8GtK3S9PugSh5i3bIGxKTYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com


>> Thanks to Wojciech Drewek for very nice naming of the devlink instance:
>> PF0:		pci/0000:00:18.0
>> whole-dev:	pci/0000:00:18
>> But I made this a param for now (driver is free to pass just "whole-dev").
>>
>> $ devlink dev # (Interesting part of output only)
>> pci/0000:af:00:
>>   nested_devlink:
>>     pci/0000:af:00.0
>>     pci/0000:af:00.1
>>     pci/0000:af:00.2
>>     pci/0000:af:00.3
>>     pci/0000:af:00.4
>>     pci/0000:af:00.5
>>     pci/0000:af:00.6
>>     pci/0000:af:00.7
> 
> 
> In general, I like this approach. In fact, I have quite similar
> patch/set in my sandbox git.
> 
> The problem I didn't figure out how to handle, was a backing entity
> for the parent devlink.
> 
> You use part of PCI BDF, which is obviously wrong:
> 1) bus_name/dev_name the user expects to be the backing device bus and
>     address on it (pci/usb/i2c). With using part of BDF, you break this
>     assumption.
> 2) 2 PFs can have totally different BDF (in VM for example). Then your
>     approach is broken.

To make the hard part of it easy, I like to have the name to be provided
by what the PF/driver has available (whichever will be the first of
given device PFs), as of now, we resolve this issue (and provide ~what
your devlink_shared does) via ice_adapter.

Making it a devlink instance gives user an easy way to see the whole
picture of all resources handled as "shared per device", my current
output, for all PFs and VFs on given device:

pci/0000:af:00:
   name rss size 8 unit entry size_min 0 size_max 24 size_gran 1
     resources:
       name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1
       name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1

What is contributing to the hardness, this is not just one for all ice
PFs, but one per device, which we distinguish via pci BDF.

> 
> I was thinking about having an auxiliary device created for the parent,
> but auxiliary assumes it is child. The is upside-down.
> 
> I was thinking about having some sort of made-up per-driver bus, like
> "ice" of "mlx5" with some thing like DSN that would act as a "dev_name".
> I have a patch that introduces:
> 
> struct devlink_shared_inst;
> 
> struct devlink *devlink_shared_alloc(const struct devlink_ops *ops,
>                                       size_t priv_size, struct net *net,
>                                       struct module *module, u64 per_module_id,
>                                       void *inst_priv,
>                                       struct devlink_shared_inst **p_inst);
> void devlink_shared_free(struct devlink *devlink,
>                          struct devlink_shared_inst *inst);
> 
> I took a stab at it here:
> https://github.com/jpirko/linux_mlxsw/commits/wip_dl_pfs_parent/
> The work is not finished.
> 
> 
> Also, I was thinking about having some made-up bus, like "pci_ids",
> where instead of BDFs as addresses, there would be DSN for example.
> 
> None of these 3 is nice.

how one would invent/infer/allocate the DSN?

faux_bus mentioned by Jake would be about the same level of "fakeness"
as simply allocating a new instance of devlink by the first PF, IMO :)

