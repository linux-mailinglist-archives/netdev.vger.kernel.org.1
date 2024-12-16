Return-Path: <netdev+bounces-152115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771B9F2B8A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9BF1882745
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0121FF7DB;
	Mon, 16 Dec 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF2kC/ll"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF129CA;
	Mon, 16 Dec 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336611; cv=fail; b=q4kppgUfZDjautUiuH+W8VSbQBQL3bHTTyUJKm/lvaTbwggTI1NZWaZhWeTqChWjLar7Rv//u2PZysDXRXMqX0I1wNyvAYEEi0eByz8rIpb85+YfKtqLnFvGoo5fF7gz2wsJzdUB2uRWI+gA17ORr6phgO2ECNkLobpE5wlBcSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336611; c=relaxed/simple;
	bh=LI9xjkzgW5RtRFL75mvvziO9Hkcu5KYemHYGqQNikzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edXK/m4dvYPcPCbX0+0+ZxXIY55xBwFXhQHrgxcAI4pi5H0PZQkFdkDl20F4QSd3R8Cb0WJ3S85t2723iTrUUpLqBxCINRJAH4j6RR+l01V5YHAcNWxWUa4iGtbqGt7FQwcgeQThEil+GI3ygZCNEViPVxLFaPg9C+Sdjcy06JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF2kC/ll; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734336610; x=1765872610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LI9xjkzgW5RtRFL75mvvziO9Hkcu5KYemHYGqQNikzY=;
  b=NF2kC/llOBa+HrTck9fRkg3O43MGdMWRkdWRh2KWBjKCho/0UsVUu4nI
   f9zhWL8uTdw/Eaj5eezX0zCojGO/Kj0cdMy4q3j8aLXexNc2W11Mpb738
   grme6lnqUNwTqacrxoAqkoUfnZ8opvltRKJimv/zjFUIXH9VdZLELOYjm
   MLjifkPPspmDKOhyHpW02RDjP2SG6HavIsas9nOyBB+f/KcJbTmPgm7at
   oMPgV50Q3luibCyMjiMSUj0eoGFkOJjlu78dzThiC6iPkKJFCFEE1lNH8
   UsfgOdStBtVzYq74yLnX3/7H6607wCdnSPGGfmq05tX2hsVmmv3sX9IGb
   A==;
X-CSE-ConnectionGUID: Lw2B3gpZTiyWozTzTWLqjA==
X-CSE-MsgGUID: SZ8ot4GLTFWn34Nz34VddA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45713410"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45713410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:10:09 -0800
X-CSE-ConnectionGUID: F7PfXqeXRcalvayreWWh3g==
X-CSE-MsgGUID: frOBkQ9qRveZcgLvYEVs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96980843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 00:10:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 00:10:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 00:10:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 00:10:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fisPRFy+15X8Cusmj6U3rF0JQN/iqO/UnOuhl1W44cn+OOinM+RUp179n2L6/9lPdumb4LP2zPK44xw60fesK4UeuFMlG/fXe6q/N00iUj6RnW/HEeql3gC84QhkNb2GlnmwjtqQ6hFgrLQtuCcNPdB4bh+tStunkWe9iOnAI6aYciki4zifJgSin9BOzrgw3KcvYz0yfUq0w7B2/akLrPmAfQpx3Uo7rfudLNSiTDdhl/aFr82+wHDIqNeOc+mRCYyzSoFhaVDO9vpi1mr22H5pN6OoIpjB7rwTllXCcnMzZpSnzhE6UOWL2OOrp3j7eQIQvxc4uGxltdTV4krKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiEX5844iIrf/YjSMvNFirwi26re8gTfXcnK7h979co=;
 b=SS7jG/TNkwdEykFnNecnFp6uG/dh2kirDfWRrw4jstngdfrMppkzqVOl3Gv7LGi89fNv5Vat55cb5HyVTuBT2WlPqk37z16YwfBxxsOSQCUVpGWW7EYLUDDD9WxIg4hWgwwo40nPqNIMr7gsPF5UK366mSnF0teepOMhEF+pFkjR7BxVkL2YQoZXBbMfLSeBlVfe/lIBXN9kmk2/LKHsUIYU09THj2NbCf7VPU9V/Xq4cCwAIPbYWMJ7OvpbSWh7FgWdok6LXUBaFPAXlozmCbAoLMVOI+0yg69kYPAydwpVeptmilkfRMO4u9FEuvZhHavhKJz/UV1wHq2TvbE1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 08:10:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:10:04 +0000
Message-ID: <74d65f76-5e3a-44b6-b857-42b6c8cf7789@intel.com>
Date: Mon, 16 Dec 2024 09:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
	<error27@gmail.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0064.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df132ad-df08-4a03-5208-08dd1da90c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFJMQVhjZC94dm1GTm5pKytJNGxHM3NXYW05QThCSm50ckVzbzlvWWxHdzRL?=
 =?utf-8?B?bnlyTVhhZWJicC9SaDFiOStxNTFHN2F4Y3ZkNWdZL1RHSEw1ZWMyZ1d5Vk1y?=
 =?utf-8?B?Yk04eVFFb3p0UEh2TDc0TklsT01EeFhwbkszQW0yRlBEaENVaTd4aWFNRUFN?=
 =?utf-8?B?S3cyWnpvK3l4U1JqdnNTS3NLRjFWeG1JWWQyQTlOaWhybkxVYUpad2dTSXFB?=
 =?utf-8?B?eERPYU02VEtqeFZva20xNmdOSHE2R0xjdnRoTW9qNEw1b3RwR2tweEFDYTIy?=
 =?utf-8?B?RXM5a3J5UUVEUkJYREhVTE1lWU0zVENvTnpvd25Zajcyd1hFNUNWVUU5MU9X?=
 =?utf-8?B?MWV1VDREd3JOSjlzY0RPbHVCVmNScGhJaytKbndXcy84a2tEYkZTdlU5NURk?=
 =?utf-8?B?ZTVuYllUZFpBdXRkaGJQL2QxNXUxYkNBWlo1MVprUjU0bDdWdkhSaVJTbG8z?=
 =?utf-8?B?VC9kTkVsdzh2YmU5aVRUdE1SMkR3R2w1YUs1dlgyczJnN0RwODlEQldlMWZo?=
 =?utf-8?B?L093VjRPUXpWUXZteUhQenlyTFovRUtUSlpLVmdlU25pSHo3ZlY4MlFKMzVQ?=
 =?utf-8?B?YTZRajV6b2NNRE9SeDJEK3RDazlzc0dhZHJTQ0xhS1J1RVpsZGFmaG9LRUhE?=
 =?utf-8?B?MkcxSUdmaUNFekFEeks2SjJpTzN4anpPb1dHbWZhWFgvK2NVUWNEbyt0YnBK?=
 =?utf-8?B?bWJRNjVaeUYrRHdtR3A5SS92Q2RsNFFZL241ZEUxVnI2Q0k5UFlkU3huZ0NT?=
 =?utf-8?B?WUZoT3NVY2ErcDN6QkJiMUxPR3dTcEM0aHZXcnFVUlE3d1YzYkZscG9kL1dD?=
 =?utf-8?B?VXZ6MmZaVU13cDJ0R2hyOVord0ZJc3hjTG9kc1BDWmovZ2dtZUZHdnVRajdI?=
 =?utf-8?B?QUVNZnpBMjZrRDBoMkpzL1JTMWFUcEhtVk5yU1ZVblFiV1VIUGlFVXRqb0lD?=
 =?utf-8?B?cnZ4QnNyWG4yakxEbnJQYXVqamVOUndEeEVtM0FONlYzWThPbFVjb2FPOG9J?=
 =?utf-8?B?WU1Sa0JIOVBMMkxMRGRudzBDRUw2WjBGR1gvZ0xFajVXamZUK3V3VTdJTXEx?=
 =?utf-8?B?dlU0ZlZSRHZzTmVLcytSZkpqaCttQUs5ODhXcGxOdUZCYWdGc0xXRE8xRkg1?=
 =?utf-8?B?OWVPTDF6b0ZhQ01VazgrUFlYWXNCMDRNZmFMMDJTSE1hRkNiUUVzZzljeEd5?=
 =?utf-8?B?OGI3WmFVS0FQZXI3NnZKWkFGSHRYM2F2V21YU0xCd3B1R2JpNUI0YTd2d29V?=
 =?utf-8?B?MG1Obkp0RHgwRWxjampYSU11YjBlWVR5aHI2dElFckJNeEpIZmVMVXNYVzBJ?=
 =?utf-8?B?Tzh4K3crZ2I0RndHQkpDU3h4SWV4NWlYdDY3Q2FpaGpDRk1FT3ZsaWN6U2VG?=
 =?utf-8?B?Q1gxeTZNWXhwN1NDdlVuYS9tV015aGlpWjhoSzFOTXUvc1VORzNBd05lWVNj?=
 =?utf-8?B?WDhrN0lvZnBjNERyNnFCK2dOdTBxU0dNWk5XYWVTS1kyeC8rOG5qS29iQkZY?=
 =?utf-8?B?TjZlRGdXMnNUbnR1WStLRWdjSDRzaU43b2RWak15TzlUYWpJRy9PSGZ2YzRK?=
 =?utf-8?B?RnhVWG5BdlY4V2lRdkVldlZUWEpwbE11bzZEb09HdlNVdjJNb2dKZ3pZbXdB?=
 =?utf-8?B?MEVFMUpkYndhMkpYVUdjNG91YitQR25QcDkxWG9NRHkvNlNxVTJWRTNsSlVU?=
 =?utf-8?B?cVNXaXN5NVFiQnhuKzJrWHN2Y1hTVkQvd25mZ0VHb0pKc1prMmZvR011a3Y4?=
 =?utf-8?B?ZUZnNzRHTHlvT1hJQWVMTHRZY0syd2RjWnJndFVtd2gxeTV5THhoVkVVVk5n?=
 =?utf-8?B?TFNoSG1DOVduNDFFdVYvY2pZVTVIeTFFeFE2VkYzRXRMK1cxSE9qRFg2d0R3?=
 =?utf-8?Q?IcvazJmxqUlwd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhGWFlhdy9FK0ZEc2FPMDdBNzJJVERTT29BZ3hkUXpESE9UNE14VHJzUFF5?=
 =?utf-8?B?b0F4UU01dVhKcmRTRzhjd2dzNEZpYmxwcXlhQllULzRGNThSL2NLcjl2OXNE?=
 =?utf-8?B?YU80M3VuY0dRVzBGU09RbFJQR3A0aWs0dTBlL1dqZGZ5R2FlRDF6eURIcFZY?=
 =?utf-8?B?R3hnNVoxNER6elA2RGZRYVNpdUExN3VUY00rTS9Ya3IyTkNSOEE2UmdKZDk2?=
 =?utf-8?B?aXUyNCsyT2E2ZTN6eTAybjF0aDBzdW9MSzhsUzVHcUt2aUNzK2NRK0FKVlpW?=
 =?utf-8?B?bzJlZ2s2NmhGL1hHNE9SSngzZHErWTFndEVPUlNFMGM4aGVRMmdLRys1bG9F?=
 =?utf-8?B?c0Vmb01GY0REMWZsSG00bXdTdXFzRUhXcHNyL0diUVZWc1A0ajVoZ0lraGhE?=
 =?utf-8?B?WGZPc2ZTUFQrTTdvT1lxT2NKRUl0M3BoUGUydXVVNlJSeUo5Yjdzb1Nudno3?=
 =?utf-8?B?d25VTWlCRFBHa2JRUjhwTm51a3FIYXBUbWFteURrYUJWOHpaR1lyd3BxWEVn?=
 =?utf-8?B?V3hvQXRDd25yVEc0MHB3SHljc1Z0WXdjY0xlMXA0SFk1bmdmR0ZGenZvYUNI?=
 =?utf-8?B?cmRQLzYzM1FxRzMwQkRxYU93NEZzRklna1BvbFIzNnlEZ29MZmx2cTdlajRl?=
 =?utf-8?B?RFMzWURuOEZITWgzUE8rbXlHR25KTUpuZEp2Q2xLdjdVaGVCSEdrbkpmaTA4?=
 =?utf-8?B?Wlg0NU9BNmwxNE5lMjNGOWdvNmlXa2ovbWUycWNpbFg5TWZlZXZKQmluN3Rn?=
 =?utf-8?B?THlTVDE5UUY1QzB3MjJjVTV2T0VpZStWZmRwbkFYenkyZ3JJbUhMcmtIZ1Y5?=
 =?utf-8?B?elgwVzdXSmVhUGpzZHhjTE0waFY4eDN3Z0VqdkhmVkFac0hudU9UZ2xYbmt1?=
 =?utf-8?B?NmhjTEZsZm9Cb0Rwd0RYV2h1ekpkYXJZdFViWDdLYlJZa3MvUVVNbUlFNmFl?=
 =?utf-8?B?V3FiQVZPUmFNeVFOQy9ha1ZmREI4Q3VnVnZpZFphN0gwb3U3L0lqbTJWZS9x?=
 =?utf-8?B?MEw1V3Vla2tqbk90c255cjVKZmxaRHYyd3FrYjZhbjlNbTkxSUt1UVRWTWln?=
 =?utf-8?B?TFZ5bWNqdEhJeUdGQldORGd2NVN1dUV3Z3FoKzViMjhWZ3gxc0gwdmE1QXQ0?=
 =?utf-8?B?N24yaE15Q3EwdkVPRE43OVBROHBDbGtCMDZsQzZwTmtralRkV0NUdmczTXN0?=
 =?utf-8?B?TExUNGpXWFNRbmdrM3FMeE14TXo0UGpWaHRsT0kvUXljdWRRNmZQdDdjakcy?=
 =?utf-8?B?NHM1OU1LUlhwZWJOM2ZuT1NpVzJRY3h1c3FqdnZxb2IyTld3c09mRFlET3hV?=
 =?utf-8?B?ZTFFM1VXZVRHMDZmNFBqdXU2NExWSWo4RTRVei91MGVzRmRRcVRXeUhVempM?=
 =?utf-8?B?R1ViZmE5c0lhUWVIam5ENWZvS2lWSXlhaTB2cU9mZ0txZzV5ZkNPaGlPZlRw?=
 =?utf-8?B?VVAyZjdTbFpESHF1dFU2STRWVldlSHBpaXAxRmQzRk5NbTRZQTRhWGt2a29o?=
 =?utf-8?B?SHlTcnNXWjk2OFhMS2VTV0NsRU12ZFdxTlB6R1Q2aStFSXI2dGd5eEpXNE9I?=
 =?utf-8?B?S2ZBQVE0cy9YZnE3UU1DcERPd3V3NGlmenhxZmJtbFcwaUw0aXk2bzhzYlJS?=
 =?utf-8?B?R1QvbElaK0dqQW5SQ1ZzRjBIUjk0cVRBYzZEa0RzVHI0azMrUFZVQ01hZU85?=
 =?utf-8?B?aU5qbUJRVDBZdXgvRzRsUHh3VXd2eDdpTjArTE0zY1V6T0tJalRjN21GSVNk?=
 =?utf-8?B?bmZMc1JtK0crWFoyR0VJL3ppUUdET1p4ZWRRUHdLKzZWMVFqNW1RS3BJUGJz?=
 =?utf-8?B?eGx3KzMrdWNkdlFma2hLRk8yNDgyNGNNblMvbGdwWENsby9tTFhtdm1SSkl6?=
 =?utf-8?B?a0d1RXErYjdIMm5kdGI3RjE3UHpkb0ZsNDg2WmtQbVFlc0lnU1JMSGhPZXV2?=
 =?utf-8?B?UjJqUThhc082L3VZZ0dDTW9ZcG10TjFqYzVQNk1QR0FSQzFROUdnS0tZVVhv?=
 =?utf-8?B?cGVzZ0FQUUNUaW9Oc3MzOVpxbWVSTkcvUjdWUFlsQ0NmQXo5dVF0MWl0bnhw?=
 =?utf-8?B?SXYxd2lhQW13MGdUSFZ0UkFNTXk1ZTZaQXI3enRnVnhURXlqRlVjcHJ4VkVq?=
 =?utf-8?B?RVJtVUxaZmFoM1pyUmp2Z250WDE0WE5vNUxZeXRxUEdpTEh1N1NsSkRzZlNq?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df132ad-df08-4a03-5208-08dd1da90c30
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 08:10:04.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGJ+LiPYn1pW7oqM5yY60sy+/9O6Z+Q3ebCewecKlK49Q9u8Ab+KnfZ6vdf+9anHxh89qS0JCdwxPctgEVlvG6vthypTBPOhpNIoO/qe7/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com

On 12/16/24 08:05, Harshit Mogalapalli wrote:
> When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
> incomplete iteration before going to "exit:" label.
> 
> Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")

I would say that you are fixing:
Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")

this is also a -net material

code is fine otherwise, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found by Smatch, based on static analysis, only compile tested.
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 232b10740c13..9e3fcbae5dee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -680,8 +680,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>   		ndev->features |= ndev->hw_features;
>   		eth_hw_addr_random(ndev);
>   		err = rvu_rep_devlink_port_register(rep);
> -		if (err)
> +		if (err) {
> +			free_netdev(ndev);
>   			goto exit;
> +		}
>   
>   		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
>   		err = register_netdev(ndev);


