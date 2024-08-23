Return-Path: <netdev+bounces-121334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945795CC75
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15935283D5D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F5185947;
	Fri, 23 Aug 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfeBxF0d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3318595A
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416644; cv=fail; b=TeILUdgQUdTlu4juEddXq6yp8HdCGwixio2wgKpiLRjoKMYpb3EwqO7VGnvUIp0jTG9csddJJ87kc+at5H9bYdbTVPvtd4EGM5RYHRpfogxGNlA70i3vlhBT3jfM0tqr8H5qz6XcxGT2L2E8Z5Ql2A/LLN/htCklvXwJKboPuLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416644; c=relaxed/simple;
	bh=qy++9kigNFTiRCdykGxMe6WmVDJVPgtBjIN9U3DIByo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dr9Z8fZ8LueHQIT2T2cUSG1c/ot1OXMHZSeRE/0pfuvIkVjsCyGAwNM7rrivLcVq497qcDJrDvI9IzM2J2896vxbEpPFX2QiUAQ/AfXg4fwOYognzS88wiIP/HnLtH7E2PpG3nuY61yPZrFDdOS1lcRZzHxiiqJXxlNr9aei2H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfeBxF0d; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724416643; x=1755952643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qy++9kigNFTiRCdykGxMe6WmVDJVPgtBjIN9U3DIByo=;
  b=nfeBxF0du4vs5Q7fAhmaEsKJ/qLzZLGX0G3YIHIZrX+1D6ldLjVBnYOF
   SW15AZrdQujfj01RhCRcjWEC44yz1boCScEKtKKhkSnsDgMYei6/iHrFB
   236a/lQl/mPDc/XGzbbfb9REd/8YxVrU6zdDtm8AwKpznSZRboTUT8Hj3
   IGKMi6D9nFAHwwt8Wi0/DUZPB6Z9pgq59ujPg2xav9hecq0zz05ptrBS8
   DO02eOIrvwa7OfFdnZKK16ADvLn1uhlMWpEQGBbNjuO/5xp/Y+t+bkI0x
   PxaebHyFbmvcY1LIZIc7HRoH4pXQcPqD0prIKeSJdprgRBZdCslK7NRdT
   w==;
X-CSE-ConnectionGUID: Fn3SsBAxQNKtVIZekCKL4g==
X-CSE-MsgGUID: XFHY3+L2SoqMj3XFNZ4mWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34260197"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34260197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:37:22 -0700
X-CSE-ConnectionGUID: cuS36aJnTTm8MgEt/6kkiQ==
X-CSE-MsgGUID: ZEnR2hK1SBmesnbKjKldSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61806032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 05:37:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:37:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 05:37:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 05:37:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 05:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnHBHpWRYmWO3OVMUWvUJ9sRZ3BAmqlJBp3CtNZAe5USiZYCsqAHxzXZ3HSl5nWJYU8p1uOBLoVFV2+gEbJzxwNtAOcA3cz8HYaA/mOcISL0ut2vgxecCII11GviKRz+BRT7rZam80FVvCGbAIrexFVmRKwRFezCnKts117UZ+GXY1sVSt0leWRW73eF734Jw/2KTuX6+Ksv7YXPmDpDhD5gKGCgTaOJVNtbx0Oo7k2TdGdjR4xeoSDV4S8TUFRAa6yjTBhRY8+VHReD0G09BNJ2MR8mv0Zd4rsy/mlUKftSiwWFvvTnfYg6Q7pn3fYnZU61+ZpfOOyPMP49XPlrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnpK1n6ZtkMBpT5X9L/3JgUI29SHgL2DpNq1gAuTCJ8=;
 b=NJx/bW6jizzz8oQjo0KzcCrY8H7+BKjud4E8accJ0M503UjpqPYFJxGiDavDu87uD7yyiRiJVyTtRlvsSJ0ubjNbaSioytng3+B7AOP2i6K0iFUMey82FGNn6U8hoiUfyOAMsFgsnBYV/1ZPWow+4qCB4GrqAzs3m/AYiARb7I2iNzBKvZy62gv4ne+eEV/n5I9GR3OrdXCj5ZbPklQb+F7ZFMaWLMVm1ZjO/GxHCv3VoYQ60AzN9IaHliGqNVPsC7OfwS4pDMzexgO5OZB5QLZUrM/qAwHCy+XmmRdw5FWuquNx2psTSzrOME7nWMu4dUL/d5wFsXkUaIe3MopsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 12:37:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 12:37:18 +0000
Message-ID: <a6319e40-8782-490e-8506-3ee71fa64c15@intel.com>
Date: Fri, 23 Aug 2024 14:37:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-2-anthony.l.nguyen@intel.com>
 <20240820175539.6b1cec2b@kernel.org>
 <66b571dc-19de-43ab-a10d-13cffdd82822@intel.com>
 <20240822155946.6e90fed7@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240822155946.6e90fed7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a586b2-8488-43f2-421d-08dcc370533a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUVEeVllNlZiaXFSUDBPNWsrS00xYjYwaEZ3THg0K3NIcFhmNDJ5UHRCb0t6?=
 =?utf-8?B?SWJNYVdtRVB0NG1zSDVmVTU1d1hUcHVrS0d2Mkl6VUhKNGpYWWdxTVZIcTJz?=
 =?utf-8?B?QXpRYnZUL2RwUVp6OEdNZnpZY0NOL2swaEFjWitJbTNTeWlSRnZHMHlXeGxT?=
 =?utf-8?B?ZHFsZEd3YVZSdXY1c0lkRDFkV0NOOGhNVmhySmliVnZ5TG00MWliZU8xYnFr?=
 =?utf-8?B?eHdWOUpTZmFRYmM2MGxZU0dKb01GZkh1TEhzRzZZL1NVVTlXbzduV1RDVGc1?=
 =?utf-8?B?VHlnRzF0dnlCejdYQThQY0ZhNjhhcE1xZVYyejY4UVJaS0llcTFnZWpHSEhy?=
 =?utf-8?B?QzhIcm1oUmxhcXI5dS9Nbll4T0JYejNVdHp5eERYSjNCbVRxK3pUUjNmcVFk?=
 =?utf-8?B?Sk5Nc2l3bWdUdXpkemc1T1RUa1dHdVpEdEZwUjhVQ2dWMGZSN3lVNGpnSTFI?=
 =?utf-8?B?eUtuMkZWazZVNmF2RFBaR1Q5anlvVVhEWFNjdHk1TExHU2tFWXBTOVd6dEtG?=
 =?utf-8?B?THVZdGl2OVYyRzhPRGIvVzViekxoZ0ptdTZHTHE5R1BmZ2MwNXZiMllkVzlW?=
 =?utf-8?B?RlBqTDVkQjBuYmxMamVrUjl5TmtyM0lXUy9QMXVWb3lpYmFYSkJaUUdLYWdU?=
 =?utf-8?B?ZTNJRXpndzE1TWt1cjNLQmtOYkpPMG1Zdm11SExyVzRRS2lZOE1UdkJ0elAz?=
 =?utf-8?B?cG1scnZqaStsSW9leVZWVHM1TXRjckJvSWMwdmJtZGlJcDhIb1dueXZtNTc3?=
 =?utf-8?B?OEo3Y2l0Q0F5TkJHUFUyVkJEb21qZWlFQ0dXb1NkUG55cm01WmFlUGpEMFhC?=
 =?utf-8?B?cDV3alE1OWVvTGZOa25QaFJXTFUyWlFYTFNsczhMamwwL3JUTkplRDN2Um9p?=
 =?utf-8?B?bTQ0UG5SdEtZaEJXeXd3QUZDQ0F5WHJVeGxUUnFxS0ZOY1E1VTdPc29td2xj?=
 =?utf-8?B?VEdaM285ckVhUHRscXJUVldBNVM3cUlGaXNPdzlONXp5T1dLeVplTzNublFx?=
 =?utf-8?B?R3U5SHNHWW54aTdtVUdKR2hZV3BVRTBQcHRERnp3MDdIalQyVjR1Q1BuTExa?=
 =?utf-8?B?dXozM0ZIcHpUV3J6UktJeUt1TGtoV2xKNng0eXU2eDJiOXI2WVZHdjdKRjlr?=
 =?utf-8?B?Sm4xU3RRY0hRdmxpeUFka0NCaTNxMTluVS80Ym5nSmdWV2lwNEx4bURNR25J?=
 =?utf-8?B?Y01PWkV6Z0Z5MEFZTWVPRG1iVnRYMXUraktUODlPT2lSMkpQeHVYVXJ5Uzdq?=
 =?utf-8?B?bDZrYlVvVVBoQStUL0NNNUtkbndmRERBNnJkRkd2T0JhbkhWZGwrd1JxYWlt?=
 =?utf-8?B?VnBaem9aaUxsL3lwWjhQZ2dDd1cyUE1halc1b2RSWjJPbkhwNDNjQnErOGYx?=
 =?utf-8?B?aSttM0NoTXBWVm5pU0tuT3BzUW03NE9PRlkvVDUvQjFDdnJ6dS9GVjNvQkFH?=
 =?utf-8?B?MXFHTGZWQjdCSTVreG85bGZaMVJ1c3JVQzR4MytzZy9ONGlmaGVFOVQrS3FJ?=
 =?utf-8?B?ME5zcHVZQ2Q3dDEwMlFRZGNhRTJ3Wm1xVzFPcmRSLzEwMktGSXhITzJsUFho?=
 =?utf-8?B?Z1RQWTFZN1U3eXBPeHBjUEFuek02Skh3VlIvcnhOM2dPTXFEUHErREtObXpC?=
 =?utf-8?B?Ry95amp3UTBGRmVHVUk5RUdGWkRUZmdaaE83YzhZSk1jWGtmUGRLczlnRHZk?=
 =?utf-8?B?Y1dUOUs1M1RPMkcrSGhGT2RvUW1wa2tZUkR6Y0xBTmkxNjFYZzR6NGd3K0NI?=
 =?utf-8?B?eGt4WkJxRWI4RjlSSkF3SFU1VE1UVFc3TW5JUDh6QzFQTVY4akFrNjVmZVhI?=
 =?utf-8?B?aU5LWXIyYmZqMUg2eEwyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tGajhReGdsbEYrSWp1dnNBVmZMUis5YlFpZG1BTGxuK25ocW8wSWdKVkdF?=
 =?utf-8?B?UmJmaHBvV0FObStyekh3SFhHWWoydlFyQU5kMEUyR2RBMHNRYVAzU3E5K0tQ?=
 =?utf-8?B?STQzSUhHcVhMRnU4V0FxZTA5L21XUW9zcTZsd2p3UUNMQ3hYSHBjcU9ZUVh5?=
 =?utf-8?B?ODlEM0xkWFN1UnoyZ2Y1NWl5em9PRlMyMmlDbVlYMndGRXBuUC9ZUGpXZ1Bm?=
 =?utf-8?B?Y1cwdDgwZVlWRHpMTStmYnh4ZVgwbk83TmttOXVaTmhDV0tycHU4U2RLaGVm?=
 =?utf-8?B?VXZWc1FHbmo1MHFmME5Ld3NjQ3A4Mm11ejhIenRVK2w5WWYvdFFaOTErakpI?=
 =?utf-8?B?OXFWTUpSTXQycEV5U2E5RXhFSGU2dDBVNWx3TTBTVEM5RUNVU2Q4emJlZkh4?=
 =?utf-8?B?SmFXNysxVUEvSVp1R2xvU1hpT0lzMUZNb1RoZnVpV1Z5c3hKQWQ3MXZ5NmM4?=
 =?utf-8?B?Um1VTFBiRTYwT0xEam9pTWpwNkVoblJMbnpVb0RkQnpEUkxtM0FTQnhOMVdI?=
 =?utf-8?B?ckxMZTdIY3Y2VkFHQ1BqUmxzZkF1SGdYc095WDhuYlJ6NlI3Vk0zYVcyZ3BM?=
 =?utf-8?B?a0FGRkJ5R2dUa2dlU0dQb0lCQVR6YXpnSnZvMkdKRU9EU3R1ZGd6OStyU3JC?=
 =?utf-8?B?OWszcEVqM1NqM0ptRnZDQ3RZZ2NKQXh4VnZsV1FJdWlDQTJ3NGFleUpEeWs0?=
 =?utf-8?B?elI3c1ozeFA0OFczdFFUbSsrRlhpaWZyUmM4LzBYakJpWlJ0bEUwdFozM21E?=
 =?utf-8?B?ZHJjZ3hjVGpHa2U5VXhIdHRITmpnckExWVJyeG43ZWYvQ0tGN0ZUM29HT3dM?=
 =?utf-8?B?Z0p3d0pYVThEd0Nrems4N29tR0Vhd0txS2NSL1JaRWdzSkJFWEZOMjB0bXR5?=
 =?utf-8?B?RlZrNzNtYk5adTJNTGVVOUVabzJNVURjR2lxaHQrbGJUcDluRDhxM2FqdCt3?=
 =?utf-8?B?VkFvdjRWRFF2WE9vemYxQzlGOHEveDZvaTFyYk4zb3pwemdNMG5pUkFqZUFU?=
 =?utf-8?B?TW0vWEpnZEYrN3NEbFpkaEhOdCt2SWc1VjZwZW0vbFp6R2lpRGhPWlIyRnR6?=
 =?utf-8?B?enNScFFMcWl2cDBrTURsbzUxM05LRTNlRjhLUWhPbmhLTGoxZW1OZUdacFc3?=
 =?utf-8?B?cmgzMVVyaTViWTlFOWNWRVpsZ3dyTHFHek45ZlZxMmZBZDJjMlJTaFluMHVE?=
 =?utf-8?B?UHNMdG9sN3c4YUdYdXdxUktaTkdFTGRJcU9la1hSczdQdVJnWFFyOEpzb09H?=
 =?utf-8?B?MEJXUElMOEZ5bW1STkI0RkVNNHpLemhxbExTQlppY1dRalJlTjArR3h6M25H?=
 =?utf-8?B?Ym1JR3ZEdUF5Z3I3ZklSWTVzTld5SFdWclIweUNveXdieFV5THhvNnBtWTd2?=
 =?utf-8?B?WlhMb1ptVC84TmhFR0FOUlFDQW1WeXRFZitPc21LS1lPWW5QcUxkSTRsQU53?=
 =?utf-8?B?VGducFEzcHhWVjFWbzNWMXBEdm83ejVKdEdIWHkzTk1qV0FHWTZpTU1rREhL?=
 =?utf-8?B?YjB4UVNWNUt4aTVBdEtDWm1LREYyYVR1bUdQM2VVRXdOSFZBWjl3bjlaZGdT?=
 =?utf-8?B?RGNJME5PU1VndlpWVVdTSGJKMFJWN2FkdGJmUE5yeFh0UFhXaXRTSGtJL253?=
 =?utf-8?B?ME1GSDQ3aGVWaG45aXlmNVEyS0hUZ3BxUUlFeERUdGdQSW16L1FyOUN3YzM3?=
 =?utf-8?B?bDl5VEI1WUd1M2w5ZjUrMnA2SVF2SUVDWis4eU8ydUJERjVEUlh2V1BCb2VV?=
 =?utf-8?B?dmtNNUNjbElCWU9XSjd1V0tCbkZON3M0d1lLc3ZCbTRnT0NLSTc5ZzZCOU1G?=
 =?utf-8?B?djVvYWNlZkh3THAzZWZESGFIZGpqZ0NwZzE5L3FrOWEzRGtyMHRXTFR2R3Qw?=
 =?utf-8?B?Qkdpak95OTgya1o4dkpTcmZaSXV5S3ZBTFNramFnMkp2ZUt1QUN5RmxLazY5?=
 =?utf-8?B?ZEwyem9Ub3hVMkdoa3JlN0pvVTlvdXhtbWlEL3JkODRZT0lHNEtadTJ1azNJ?=
 =?utf-8?B?Nkc5WENCMjNYeTI5aE9yaGZqamd5Q2xSMDkvWG53L2pxZmJ4OG1oUGNQQnVL?=
 =?utf-8?B?T3JzMVRWR3p1OXZreHMxVFhlU29KWUlraDNhNFFpa2QycGJGQ1M1Wi9yaGFO?=
 =?utf-8?B?WnhEWEpZbXhrT2RwTzFtdVJSTWxhNGY5ZllDNlRMOXA5SXhJRkIwMlpleC9j?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a586b2-8488-43f2-421d-08dcc370533a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:37:18.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUOZsc6aj9h4qYqt1g7oEP30yW9G29l2blAGAzKg48o3WWjoHjEY4GTr1ESE/KXjqJZi4sOgpr38Eq/f8XhJ4YmBzov5lT9irYi6FfHtJfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 22 Aug 2024 15:59:46 -0700

> On Thu, 22 Aug 2024 17:15:25 +0200 Alexander Lobakin wrote:
>>> Please run the submissions thru get_maintainers  
>>
>> I always do that. get_maintainers.pl gives nobody for linux/unroll.h.
> 
> You gotta feed it the *patch*, not the path. For keyword matching on the

Oops, sorry. I always do that for patches, not paths, but here I wanted
to use a shortcut not thinking that it may give completely different
results =\

> contents. I wanted to print a warning when people use get_maintainer
> with a path but Linus blocked it. I'm convinced 99% of such uses are
> misguided.
> 
> But TBH I was directing the message at Tony as well. Please just feed
> the patches to get_maintainer when posting.

Thanks,
Olek

