Return-Path: <netdev+bounces-210416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4CB132CA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8E1890E5E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4619006B;
	Mon, 28 Jul 2025 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhDUhhyr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED8136E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753666721; cv=fail; b=WkWYOUKKHdV5iaV4DsWZEHQN8RLw4wsPSC16t/OvqbG4kE68RaIEP77MK1rgZGYD4shBz5SW9MtP4mIPGq3RHLrOQoS4nnvWzcr23vSwUIx/OFHGLkIjHJpAVnugejI7HZN4fxDo+ANWnAzKYOMYVVfaX5oUdxjHhhs4ZsHoMO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753666721; c=relaxed/simple;
	bh=MkRVhm2sOe7OklF1Aek0hS4ZK6OqP5zKBiAH1EkuDPw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PEjf6x52EAkrAAAAqCT4VGnGlKGvn9JJo5o9rwdrnbfpJMwT2uVbZTUyIY9JbZS/U8kPqN0KYIQm12dt24ZT/OhYQVoYedKj8I6Kll63ElD+yJTMT8fN2sLZlXk0QeGm6FV36EsRzo5z8/4m1TLDJYh2kMMdNcVaXDVrYc/Sp8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhDUhhyr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753666720; x=1785202720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MkRVhm2sOe7OklF1Aek0hS4ZK6OqP5zKBiAH1EkuDPw=;
  b=HhDUhhyr+inRy21ge8RwB0HycmyjeXpsxyf2/ZjWY+2z+kLHrnfGtmWu
   CDk5nDTK1AhxIGq7JOiwqnsU0RVKayQxJxONBhpokAoKSZQbxxZlLxfOB
   PWp4HjvLcK0XicJlqxTzP+2lj5Vchx1gB8D3gPI2fIXBgFXKMiONdQBR0
   QMp97joT+a4z2OYMLxzVPccqeqD2Fe9dov21QGsKP0jS8MA+SEbz7qoIJ
   PXVvpH4/4gGAwv5VPVrTmp1CpVlOxCgCGYDmGhPXBsIQMZW2pzPAE/IVp
   cPHHtWLSHleZ9/nuIC3+JimMkbZWGTX/Z9479SuKKsDkh794xIrf9OHYo
   Q==;
X-CSE-ConnectionGUID: fnLVkKj5SNCBsJX5wY/DAQ==
X-CSE-MsgGUID: 7q+CSmgvTB+FqhGmREH23w==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="54987783"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="54987783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 18:38:39 -0700
X-CSE-ConnectionGUID: 3loBNdBiTe6Tdi2jOcBzhg==
X-CSE-MsgGUID: KTiu4AW2QbKhy3rpBNX6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="193264308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 18:38:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 27 Jul 2025 18:38:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 27 Jul 2025 18:38:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Jul 2025 18:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS425SXQE2ZAJiV74UReOvNUo+BDCD85+rJeJlQlfbhsQlf03xhkkZfr3BSTz64mSUQ66dvCovotD4IxgXzA81uY4owIjXveY5Ewui0i4C/mKWvFyP37ZcB0F93tnAQGbJB4e9qUseEtKRyvZukSa23aX63cB78dLIfVsPM2UiyqHGjKgG3Ppm7gOJXTb+0feSuRhs85+oHIbQi104S+bW9wBHNLvCogSLKH1l4qiADiW5RIz04FmNHiQzgJ6tXDqP4hzW+cv6aUS3hXDnEqUElSpyDAr2dMWjeW9oLtbezWEdpV69659dqPMf0itOmvubmNy+t9ZvD9sht0SiJkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpr8SJaFOeq5mh08J6KEbZpIu/xd9eovni9MrjLclk8=;
 b=JJA695YXVdL20T2mlhzrY3g8bGekEQZA1EFOuVtA7RRmZC/Xi6zvilsIDnclPU+rQylONUNl91ST/Fc+So8rFc/PifaXiEsEHs6VxeYMakOxQ10zZ7Bu6/Q3kYPYMp4jqsEC04qNF1Nn1p3dCRQN+nMa247DTw/hizPrfiun8tncfDt6NCF4oGjw/4ijPw49y5QsFzxMnxjUfnhvLCa1wM3aITr6/cCxP9N1UE09Ctjb+9lVFQpw6TiISkfMXurt+aanuPyVEKDM9tnaWo+bDrmjMVBOG6tP6OCabXyt0bGR/GeRAak9Bf4tpaLr2voo7hHhhmON8ihzIZRLujMX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 28 Jul
 2025 01:38:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 01:38:35 +0000
Date: Mon, 28 Jul 2025 09:38:25 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Carolina Jubran <cjubran@nvidia.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [selftest]  236156d80d:
 kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail
Message-ID: <aIbUkbxK+urvmg8+@xsang-OptiPlex-9020>
References: <202507251144.b4d9d40b-lkp@intel.com>
 <20250725080818.3b1581c5@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725080818.3b1581c5@kernel.org>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 84998fc7-5797-475a-e9be-08ddcd7777d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lvm4Hsl5zceqyUAqcZPgMts0SqeJK2BKW1zd4rKCSZnq2I/vJQTFnaQkb9u2?=
 =?us-ascii?Q?akW0UQ3cFjeGlyf3587Layekz7zkUxwTSHauVTvyH+A596Fer4TvkMxi+gfI?=
 =?us-ascii?Q?N0U252VjzFnp4SyaIZT1jCCM8I8TlK0G5DUWCzvQKcDFcf2KE1daI7DsEXWI?=
 =?us-ascii?Q?jfpHaarzVzyF4xc29wMIpFs3mdo0IOgjiUZQa112mfqKf+wWhZK9VxWxwfT/?=
 =?us-ascii?Q?z/WTDEd0LqIotMHOybP4EQLdRl5Q6mvjqbHdM46a+17IPNlvmIpgVGlnFx3k?=
 =?us-ascii?Q?pLA+SWNA+rcHZd4qTdePDMSuKjV2jU3oyKAMWH4KprvszHIlUgpbnC6Q3I9X?=
 =?us-ascii?Q?GthUVUo0hJ3bfSkkf3ogRmAM4LxI7JtmKWiq1O53B+AmZ2NS4Pg9885sNf2Z?=
 =?us-ascii?Q?h+2whgtn/wFiaXJ9RuBsWF0N5yF9YOfpqp7zZpfQn+Z1YYSnclEYOHR6nx9a?=
 =?us-ascii?Q?xPy3+aLL0XwTjr56bUYIQV2QxdUSvCL6wX99cKwdQdpHLGOmeWAOVuwxiexS?=
 =?us-ascii?Q?WxHZd2k6lWeVTiQ25UstG4TSZGneWwWjo3haEgO/ke8SCQRU9PwbhPdh+i5K?=
 =?us-ascii?Q?QHX0hY1jVtREu+1ElxuuawPNIDSm+bHoUa7OE0NocMVlopBv4U9qhdCx5U6e?=
 =?us-ascii?Q?Xkd+f63rsalCcIgF7hAAi47kxdIaXcHDKzfJjQZa8YpF42pP+K0hPHIXVfrk?=
 =?us-ascii?Q?qnsHME8AM2uPTgcpODQ/iwMeMx3KEEccvFtRl0VsUO7Rj8fqSXf2W4aFz2qq?=
 =?us-ascii?Q?LWKgFGNSwFxngEbbnHBy3cQnjFoWYZNyOeK8gguZIrabdjjQ3G6vB6qrzqLc?=
 =?us-ascii?Q?CJKQSojgwBCvNtjl5KE4AmTV7We5ujjr3Rlkb7/LZuRGPadsorDsKpYG+U48?=
 =?us-ascii?Q?fO77WlQfkfrcSu6vYo6VLxU5w5UJr7DFPYXOOvEKdbRaUYcQg2DTgAbRZE/c?=
 =?us-ascii?Q?V/G7O/F4dB8oCnt0Kwiay5uuuvpaMajukfMDPtnwdw8ao24Hf01pLfQzgjyT?=
 =?us-ascii?Q?DUCfMnQFbxnSVWNER+Ix8CL/7sDjPUTHTCywT6dXAOgfmYxcCJJgXCH/t1Rs?=
 =?us-ascii?Q?NzTTNzyTpG5yP+1n19VdGqbInByz2HOGwlyi+bLZlB/jmBx6Onq5vQDJbDln?=
 =?us-ascii?Q?oi6RAY7dWAOfkt17tnY4HX1LLBGroo4v2WUuuTZlyxmo6wRvRtRwLTaQDDdr?=
 =?us-ascii?Q?852TylPfoSnMGzb8qK5TkPlFdLYYEQqtGshcTQkHzBs8JXZuRVuk39erR/LS?=
 =?us-ascii?Q?kW9NLXESkHmjyIxfTpRJWciG3lgncsGoEkzIbRElSFplr3xnW2Y2iTST0SdF?=
 =?us-ascii?Q?MmTC4NKoNhSWIh/9HZuIIGB7a/3ilOF2EFwoG67u5ZrQgVsD1wqbHbJi+jNN?=
 =?us-ascii?Q?Hcs1HBj1rFi5b9CinVWQTZkT4oCW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNWU0pYeX0SG31Ybl1IOgyof5DfuscUmKjS9HX9/OJF9zIPdZrHFLaI/3KFk?=
 =?us-ascii?Q?oYtnfsyqA2rg0BaX/P5mb3dIg9ZVn/jL1kTMgS2iCN3lhqLN5XE9ki1hmQNG?=
 =?us-ascii?Q?UwF3U7A3vyDxc3wEvg+YpkGqOM8m+qzQwxazW1gnJA4RPq4C7o4Skz04Bcte?=
 =?us-ascii?Q?c65RFiAYdgfbjO48iW9fjTjpZvqfNw/XDP530rHFDd4YQMUaLjingzTgZ13V?=
 =?us-ascii?Q?4HmGrkqOG3TwvzaxXNNL8yY2KS2QP7VPbzoD/R3GSOheqAY51Wo+6P4pWi/P?=
 =?us-ascii?Q?XfhIz5I8A9hAp3UpyD5rU10JPKGXUv2wozLpmB1ckk4ymntsO8ur3t4gmhX8?=
 =?us-ascii?Q?aZbMNptl5TQiLIEhU8xwV/OnflEF7URKW01a/UmIomC/QP+MStMD/ce1YSjF?=
 =?us-ascii?Q?2u4YnJARdv2ZNRUpJ2EEAvwLRj4LcRD0Br9+dBFSBF08hQSexItfWRdlqHyf?=
 =?us-ascii?Q?Klv1P7toKIrUx1c/znBRGsYpi0kHq/qgYlLh4KoBGBLcvYr3FXms09LiFnqD?=
 =?us-ascii?Q?ZCZrmz04VS7oefW19WBRnCyqUhUQh34IJ4KWS7oqIOZfue87bNm1ln2+GT/A?=
 =?us-ascii?Q?+dxR6lPxhPIP0B7s6GjCRyx3vMFOnjGoZdb8BoU5el1xpR8wkjmrw05mvxnw?=
 =?us-ascii?Q?Mn+2kPIvIProhyMgXgitNcwW/1mKDVQqHt8WDgv+1xP1UA9E9bM8ZD3vTY07?=
 =?us-ascii?Q?yARZLcVzTJunrPcofsg898sCr0L+ri4vD3Tafj2GiCKxCg3LYCzPY8U3n2Py?=
 =?us-ascii?Q?E5C+zX8GZ9RLWENKBUgWxgyy2wakSjYTHnJhQi2X9zRttMVGEVxFPMPqn6kb?=
 =?us-ascii?Q?y7Llc28kV2MGHbWBYjIc5QEtzL59eYogL89UN4lD93HGrTvhb2K1u3b214sf?=
 =?us-ascii?Q?zpCdE5+YmS1cr28vU9Teu7j9z2t9RnyB2+oB+czLx8Q25v0LtywjpDsfLZ60?=
 =?us-ascii?Q?qvkZqumNJgLDUiXf9s2pvb4Ai6LfjRyN9eBQWT1doXsYFL2K1dTaSUet0Ppt?=
 =?us-ascii?Q?QJEQDPGCrtKU6+37lKg998qOJb1dutkQ8BW6IhsgAs1biF/hnNSFiXKFWFY/?=
 =?us-ascii?Q?UwH0Dtg8OzPSZR+BMWRf8d2eeGr06eurbzGSiwXJK14vVPouXpu6e1sEjHzf?=
 =?us-ascii?Q?BkmixswrhZIL+BY8p4UcAWRQepLJ1q84KDIFl5R+Fd1qZbpH26oIfGnLbR3X?=
 =?us-ascii?Q?9trt3G/cWsv+jDmAkVH4kC7M7Ts3kjOxw72o6w7JHYQwE/95ELN0GWjzDym5?=
 =?us-ascii?Q?2tpoubvVCKekEMpJpGSToOL0aLxm24YdZpfwW/so3ujBJu6GV+BzDysTp2nA?=
 =?us-ascii?Q?4pjxhdqt9YIBaoaKYWvlh7CiTpgcz/swF74RgVl1xRa8N9jdht6DKFOyrJrm?=
 =?us-ascii?Q?d2WCm4ENn3OC3TfMMOLYEv0/NqMJITmt/h8FW7p3kZ739RGGG90AXAhVFPPv?=
 =?us-ascii?Q?u9uu0hwb5MM2+5wkDz2YfNWejOTsHWxPmHUU7a/kGtB2YrR/BRUmZCWCaOl3?=
 =?us-ascii?Q?inT9vTG7cNBeAbYYh8Hc4rrI15yZZchfyg60cqM6j/WT9Wd3d5gZXhWh6Y96?=
 =?us-ascii?Q?cWsKRoO0kFd5l6KxZ8ToYKLicE4Gw+ltZaXzHvZd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84998fc7-5797-475a-e9be-08ddcd7777d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 01:38:35.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnpSOQrLuMYJMFS7GqqL7ErohSwW01lnjXSTjTwVhYfAtzV3XU+hcyn6TOEBDLWIepoQ2SgSS3Di80nDt1ZXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com

hi, Jakub Kicinski,

On Fri, Jul 25, 2025 at 08:08:18AM -0700, Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 20:34:58 +0800 kernel test robot wrote:
> > kernel test robot noticed "kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail" on:
> > 
> > commit: 236156d80d5efd942fc395a078d6ec6d810c2c40 ("selftest: netdevsim: Add devlink rate tc-bw test")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 97987520025658f30bb787a99ffbd9bbff9ffc9d]
> 
> This is not helpful, you have old tools in your environment.

thanks a lot for information! any special tools need to be upgraded for the
new test by this commit? we will update our environment.

> 
> Ideally you'd report regressions in existing test _cases_ 
> (I mean an individial [ OK ] turning into a [FAIL]).

yeah, we are confused by below,

from parent:

# TEST: dummy reporter test                                           [ OK ]
# TEST: rate test                                                     [ OK ]   <-----
ok 1 selftests: drivers/net/netdevsim: devlink.sh


but by this commit:

# TEST: dummy reporter test                                           [ OK ]
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# Unknown option "tc-bw"
# TEST: rate test                                                     [FAIL]   <-----
# 	Unexpected tc-bw value for tc6: 0 != 60
not ok 1 selftests: drivers/net/netdevsim: devlink.sh # exit=1



> 
> The bash tests depend on too many CLI tools to be expected
> to pass. Having to detect the tool versions is an unnecessary
> burden on the test author. Tools usually get updated within
> 3 months and then all these checks become dead code for the
> rest of time...
> 

got it, we will try to study how keep our env up-to-date.



