Return-Path: <netdev+bounces-71882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E0855776
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC0E1C219B0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA11419A2;
	Wed, 14 Feb 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNR3szlE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF6604DD
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954471; cv=fail; b=RKb9LpKtbOPXaue7N24dzPpO+NkpvrJd22rm8NgTDLtPESDjQu5gqJP+p3VjHAkxgk02fhaw3AyBHeyjSBBW7RCXPHeSZpz9Igc+Gc+fU8oyraTcsPn2ECZUGfin5OnE7TUPTfk2G+5T/SzG4sd8ZXvAoyoXcMW4yAkBsspl+ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954471; c=relaxed/simple;
	bh=pWOmvOtc/CaSCNOAFCA9Yz2WQFhrc4qfJzqKhir7Z5I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jghXO8UjAb9bXFYrwG8yTFxnN0wvoaDRpTbLk9dHkRwOZoXnQbSM43CaqXb2mBt1URuL7c7uN69iUb/Et9UhSwp9IdFYXNNuFg0ZPoeJgcIBJZXK4gPY8J3DjRpBbeLrg41csCrOaqHBvc/sd+v2hguy5E7a5zpTO5HJcxi4Iyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNR3szlE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707954469; x=1739490469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pWOmvOtc/CaSCNOAFCA9Yz2WQFhrc4qfJzqKhir7Z5I=;
  b=VNR3szlEb6Kkt9w4qcAyMPdtbemk4UUYT29VmsBWJhtvEXgGxBo8b+RE
   4xkKmlRehfSSxkIOsG0vuV2lAGY7kT+ro/6UZKs/4h+0NQbcBNVcy5fP0
   x07z6YS5z4uT598P/ZocSsAK201T2zpR1Vuygd9JE/iyr63Nn6ATCa61r
   XYn+qHAPuZ0QzgAl0Ob9pPh7InSqBfwDFpeWlLMsQ0LRAgiSCQ6ebwBR7
   tQzG3IZD5/PDvgPR5/zQZNIvmIErtPqzON70FtFNS5v/s9Be3VhQC7pkY
   ogiSWSpomWBua6qZqkdRodYW8DGE61p5oPIwPmBzhkexnhvfNPGH+VB5A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13416227"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13416227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 15:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="8098984"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 15:47:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 15:47:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 15:47:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 15:47:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv+WfdjoG2UjCE/Zm0s5kZF1y7n8jmsTPHzB+2+XPhnT0U7B/MMfCn3cpfPAlpssyVXfSDqEGFxvU1eZgXeeVrB/67E+KS/DUqtuk7TuqzwDAHQjTRmiWhUBpLY64W45aN4WmWh5lU8rmBS5ubnXm5KwkzJ1ICGtg7S+VSWc9JU26Rp6JostRM2myr5s/82O/Nefq000nXRGqXx2B0oUY71Nnl0tkbSWpuTE6zVJPZ8ksm3I4olx/p8hFmsX5G2//39MaSbGW9riX1WU3TYafW4GdAUN4tpECCAOj6jYheOGGxiAtKAFfQBalx0u93CTKaaR47Da6WGtCW75zuK6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cEto2ufd+/VtZAKc/WxsaivtyLbsSqC6hiIUSRP6ic=;
 b=ZLr4EnHi0mLRDw2Sv2GpwbiBMH2T3Y6PIwyHzrV+NLoAZ8hqJSHFTaZpV7LApPzHUU1sXX166wVqa97Gm9Cedd4CL0hFmhKt+V08p6Y202ZWmBStzXiVDPwb1mov+WHCa5J9od0ZWQCV7q4vkB8eJyMbRlvTTdhliJLtCoTVOq12M2ItoZhKx+9OmAAl9A16YHGN+FEkTfIfT/ptkLURu3av2IrEy0XuqYslhTsAFWfx80Vz7Cprrd2AWFZT+iCpdhovHWNjhONbTw7VhHCjPGXRsYe4Ytz/EmfyFFrm8PBkmTjepsCSGIv6fzBJ/FI98mdQGkBKmsE9ShpmgzXdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 23:47:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 23:47:41 +0000
Message-ID: <06e2b0ae-d531-4778-8e26-c3558514bed1@intel.com>
Date: Wed, 14 Feb 2024 15:47:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 2/2] ice: Implement
 'flow-type ether' rules
Content-Language: en-US
To: Lukasz Plachno <lukasz.plachno@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <pmenzel@molgen.mpg.de>, <brett.creeley@amd.com>,
	<netdev@vger.kernel.org>, Jakub Buchocki <jakubx.buchocki@intel.com>,
	<aleksander.lobakin@intel.com>, <horms@kernel.org>, Mateusz Pacuszka
	<mateuszx.pacuszka@intel.com>
References: <20240212110307.12704-1-lukasz.plachno@intel.com>
 <20240212110307.12704-3-lukasz.plachno@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240212110307.12704-3-lukasz.plachno@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0034.namprd21.prod.outlook.com
 (2603:10b6:302:1::47) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a540173-c294-440b-aba1-08dc2db7558f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bym05ZPzLCNUBl3BzUblUFWx1D7CaMHHin8rU5hfqZRYXfB7NgX7kidhj2TStl4lF+4YchDCOmuIG+2T9Atw0/cQ7HcOTIZvIKLV1lJ9K0ONrYjgB9SMcklj52nOodkATdEnYxTeTJPsstJ5v8sdcOuPuiaAjLHvJ8bPSndXIlHRTD0Uv5ggU5SaGs4O74QGkBdQ4P0vubCAhiVK3ijJ7F7xb2jbCjwiU8DoSUPOMaJdlq1GVg3Zr2STHbHpn2Pnnog0EcAchmeIA99no83s184eupEFJkuO8leWO3KiYW2KIJqObnbc9P1EKhZyaz/IzOvcF+YEeyR3wgzir5TEHh+qK1fZrdG2AvdXRiTmoG/K3Q5Cmlh/idznHmqXV+CatsIVKGpGCKUKcVxpykAf4YFke5U19GGhamWzm5gVXCJtH/jdCFYpEf+IAvvh56Gy52JbFFPvufNBdQ8832jv6nuzCUGrvgw142q4jiNyAbtwPfmtXBP3uwIvyHc0PS0q9geAJPQEcZIT0qkyAWoDcv6uBuGfW3rHkaVdhs5ljVkKJAzgPhXMolyd4fvK1hkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(5660300002)(4744005)(38100700002)(6512007)(53546011)(6506007)(478600001)(6486002)(31696002)(86362001)(36756003)(41300700001)(83380400001)(107886003)(26005)(2616005)(4326008)(54906003)(8936002)(8676002)(66946007)(66556008)(66476007)(316002)(82960400001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9Tb0dyRklzc3BUWEd4bFBTdTljQkoyaXFxTUlWcVZUQkNjK0NOQ2lsWUJr?=
 =?utf-8?B?Z0R5VHFwN0tKeE9pb1Z2c2NDMVlqOXVDYXd3Q3FlQkZXYytMbjF6S2ltQkl5?=
 =?utf-8?B?VUl3d2I3eXZnREZPMUZiUWppcHhPa1lhZ2pycytqZnAyYVZtU2lQQzJjeSt6?=
 =?utf-8?B?K05pY3hrRFJiSmkrVjlIcmo0dmxpWTI3dlJFOGhtL2MweGwzbmk4VjBiOE5F?=
 =?utf-8?B?WVBMVGRpMzBUTDFlRTZSRmNSRC9KVmduS05FeHN6K25zeUNyYStVdEYzeTB3?=
 =?utf-8?B?OVpVZVJJWlNGaSt5Z0hzZ3dWaGVMU0UwMEw0OVRIeW5oRUZPcXJGSTdwVWpN?=
 =?utf-8?B?SldsVVQ0a3dOd1F6dWZ5OUo3SDZsRDZsTWdLanRrd29HYllkVEhwRkxFdGV2?=
 =?utf-8?B?bEtWeGVPNFpFYmVueEZ6RXR2Z21uUDA1cExtSWZsTjJDSkYyck8xSkJsQ0JE?=
 =?utf-8?B?TDVBbDM0MHd2Zm9vRUdvWjVvTlBRbmM4TUc3M3VMNzFZaGNKMTh2ZUV3eHJx?=
 =?utf-8?B?ZFAvd3NvZkVnTVIzR21neUF0emJjK25JUk0rdnM3NTBsOWRyL200aWFpa01w?=
 =?utf-8?B?ZWZXcTVvUGlnM3h0VFdFMURSc1hZOTVFS2hUTlpXRWhsQ1dWVEVGb1BHUlZy?=
 =?utf-8?B?TE04UDcwc0ZGTjBiOXo4aDRlTmFINkF1T0VsSElOQ2dXUHlURUx0cXRwV0lR?=
 =?utf-8?B?eGZKRkFDb0phSWJsV0grdHZmbk9aU0RsZnBKUTFSM2g4cWpjTDluNFAwZEVP?=
 =?utf-8?B?N0J6dWMwTnNZbGpPd2MwU01hY3ZIb3EzWkw5aC94ZGpWaU1mMlVrV1NXb1VT?=
 =?utf-8?B?N2RCWlE4bU1qb1pkTnRJb05rNklhRzVJYlE5ZGdJSk9CVHMzT3VPY3VXZW9t?=
 =?utf-8?B?NDVEenI2ZDJPNXFiUm1oWGJEK3pEN3VRdVgwQUpxK0pUNDE4b2IwckZraUhu?=
 =?utf-8?B?dTRrRVRpbVUyUHUvbTZQeXg1cWlieEZkOVlCZFZxUkI3ZERQcU54dnFJR0NN?=
 =?utf-8?B?SnBUREhjVGdpem95MDB6R3libEhWd0h4NElvZ3BldklUL0RXQjdzTERxR2hE?=
 =?utf-8?B?ZElCVjExZDBVRkJxcUpnOWNTcURObVRUU0hRbXZSWThXdGxGV3BCd1lXY2Nu?=
 =?utf-8?B?c3B6TnZDdVIwcmppWjAxY0I2b29GVStLUHQxeUF4VUY4dGNVT0o0Q1Yxendy?=
 =?utf-8?B?ejU4MEo4SU1vUElReHJxVTA2dHoraWMrMXRjTHZ5elhKQVRqK1Nyb1VWb0Qw?=
 =?utf-8?B?MktmZDNwV080RWFXZXBuV3RrYzVTcm9Yd0RFTGRkWWR5Q0NJSkdXc3lXWmw4?=
 =?utf-8?B?bHpLLzlORlNPSGJ1ejVBSEJhdURTWlAvY3BvemszMUVsZk02UXhYUVl1NmE4?=
 =?utf-8?B?NXhHUGI3bGRHeEVwRnU4UVBFOHcrRVI3V0FZc0daaEFsTnVmcGJBaEwxRFFV?=
 =?utf-8?B?QTNrM1Y5ZzhOYVZOOS85aUVQVUdYZnRManJuYmpGN1VLK2o2d3hIaVgveFc0?=
 =?utf-8?B?ckNnK2MrenVUM3hFRENiZ0poRWh1dEpwcVcvTy9zcFJFazRHU1hPYllFME1U?=
 =?utf-8?B?NmRSM01sMDNaWEk3aGFsY3gySkdWTzY3V2NWTG1Xc0RIZkpaMHdnb2haMjFZ?=
 =?utf-8?B?RklEZERDcmMvaTQvbTFyNHNZWUg3cE1DUU5yZWNLWHBtaUZINExaNnR1Tm9B?=
 =?utf-8?B?aVJsUm4wL24vdCt0cjVHZ0k1S1JuWThSN3ZQNVJXbkh6L1AwNW9rb0MzZVFL?=
 =?utf-8?B?MWs4T0JLb0c1TzVRS1U0UGxZSUlPeWw3NDdHQ0ZnR3BGQmJpc0VRaDhoN2Fy?=
 =?utf-8?B?WXd0QXNuS2VZeUZKbnd6eS9IOEtENkFuRlpUcjFNK1ZtSUhacTBMUzIxZW91?=
 =?utf-8?B?UlZselAxTjBzUHNzai9LcTlhZXh3WElpZCtraEVrek52ZVFhNHhNV1BHRTg2?=
 =?utf-8?B?VUJzOHBQVFRCa3EvUTduRktmUXArd05nTWFjSkFBVS9HYmh2d3BYcTgxemFH?=
 =?utf-8?B?WUEvZXBPWGJlc0FoNnZDd1NacUhKWW1nOUhUVmFrd3pxdVVybGxBV0RCNzNo?=
 =?utf-8?B?ZlRRVkVyNnVFSWtsdXpIMmdvR1ZWVllJQ2Z3WjczdVpiWUdTaEtKcm1DQjY1?=
 =?utf-8?B?SzU3TVkzM1diNVBHemJDS250dFVMT1FwQ1h4T0xRVTNKdXpEMzMranI2ald2?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a540173-c294-440b-aba1-08dc2db7558f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 23:47:41.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYTjEWQe+0q0attUgvgP3hmagLYtt5YlREsTYAcmVr9BGrgYnsW/zZgRjWIKM8nnKESHfPw0BZVLhRzRHHOnJdIBOkr2HHHFBm0gY+YwLkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com



On 2/12/2024 3:03 AM, Lukasz Plachno wrote:
> +err_mask:
> +	dev_warn(dev, "Only 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff MAC address mask is allowed for flow-type ether");
> +	return -EOPNOTSUPP;
> +}
> +

It would be nice if this message could be reported via extack over
netlink...

Ah.. well never mind its still only supported via ioctl.

Thanks,
Jake

