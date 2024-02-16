Return-Path: <netdev+bounces-72574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE517858919
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392681F21738
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CE133423;
	Fri, 16 Feb 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvNkoG9m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5717BB9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123627; cv=fail; b=Uu3+hwkbMnpWl9cjgnx9kfK6b/krwRXlY1qtgaDzgq2q8kSmYLCdd7S/OFASzuhB2Sq+FHzTfEsy6svatZZjRH6w1QPVTIAgO43zBFoDk8lAEw3w8o8E1HWTGVpNpnDXrwmMpFuTKIuatm6cTijJzBFLyEk6CbCeIrhEDCNY+LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123627; c=relaxed/simple;
	bh=BRjMGGfhNoAfCLv6yublNOTs8q/ttY3Qy4RZlTwTMm8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGhuUP3Nowkkdm8LhN3bLDC5C0PcRo34/gVJXPaRjnbmy7qkYiEYovJGC7aDwde5UV/FrkYBvIxJGpoSpA+WPJ/jyyALFw7d+U4HaLTlh7ktXHk1W6kB7BOerp8pVtQeIsvH4q4ojA6YfMfUr7rMU3W3Suf2JxpaaNASGcffyVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvNkoG9m; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123626; x=1739659626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BRjMGGfhNoAfCLv6yublNOTs8q/ttY3Qy4RZlTwTMm8=;
  b=LvNkoG9miJNJ9ILGMK1hHIGGvMAjw14SUKZMWqRNPLZkUCKq2fTtZEH5
   2Wt1LH1uXB5Io2XdbW0V+8dRE0ZNc8IzdoLeKqHsMjVR83rtscr/7v3bt
   7Q6E0znwGMvgZ369ckQ/fTpqRqmK84fn9efFIa0/7cMvLok6vfYYptd1+
   2kTCWlM3Y7mzZa/r+h/1xO7Kzw6JxAC8C3IPZBOW4skmISWVVv1E4Lenh
   AVB+Kd1EFUflkzogiqglNAx4UAsD+GSW/VlTNNVmmvaXiTLLRwXgxtmT/
   MLhxSpejvAfGfxRUfu8SEooCkEZGF8TR678VQCMTL4DBEBma/+fJGV5A7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19689691"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19689691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="34748211"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:47:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:47:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:47:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:47:04 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:47:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuPTTvWZGL3PxdaFpd4cMb/qRPEUwFyYv6eKHngBjQ2u8veJ0UMIbDsNPeIhUWsaN0tEBV2RLz63qhEJyLFyg/lWXioBmb/dmHfIXMDugf2+3kbJPvzgWTkcMfJxSJ+r8hx0Gk2VdrxZjuwP3iLAOOD285R4lJOtunUnXAZN25UgrbILUDduzwQ01pUectatsQiIzlH7Jc5lufd+VFUbvInC+nuI/vxKY7NIq+tIXjTWIn7xTT+NdYY8x5nkKn919FT3tryNnWCxYZmL0Fm9b9KUJbmDZ+3AqjXZFkSOgk1hY4aG3FjHSA+9NLWx7Hb4ouC5wkORFF3f7ar70UvGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4V6POC5oTPMOHfnL1bCtfL2g1ydZW1xkQgtNkNxGHo=;
 b=LhmKK9AtyZ+3BTML5h1J7DFr/qF8JRz8LcJzo8yh2qDMMksUpNSgEGA4tIn+AnvcrayEEOOxRs4qyCtxcgH7CVuEF3t3GynXWxMWlLNh8eW6RAltvMYT5+q8JAzSY3xVt9zTRO2EEi8o8JfAXtc5OBCGRGVQR9TjTErFDH4BxuhMl0imF5FXbVP5OBKKl6sN0YCTj6+1UHD7ryWTrh/VfCZkhsk1j8ct5PvbVa+h21BhTOFlNmBmg4w5QqbKbG4sSuboNOeSSImto9uDtjNP6PjghMJl4nC83i7JF7477D+59z7/Wwoe4BHMP4KZp6+kAoUy0FMpYYSqiyWgX8ZDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 22:47:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:47:01 +0000
Message-ID: <7a4d7c27-b16b-44f4-b2e7-cf7b3868ce42@intel.com>
Date: Fri, 16 Feb 2024 14:47:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
 <20240216214243.764561-4-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216214243.764561-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bd4c64-28a7-478f-3115-08dc2f4130ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BRpUaK9BVKtRcwohD4iDMj5qDI4SQxgEIYBkWmz9TWxZZYEi6iGk8dtlehw/YR46oPJ8p+ncED2kCymSLV+9HH+BgN+1u8D4LNuBk2Nnn7lZFrBfsgBBdWtaqhjsAAXY0yr+Vies8avRV4jlzA1BeGfJoKMhiOBUZ4VxQ+w7LxuckZ+eRGS0DB8zu2v89LtOAeQSLaD7h1UJ7EwrHZMn8jbBPW+bvQL8GqdOZn403CL3FKhSBlNXyitU5vD5AMnqS7uQg1QIcFK9bkHLizOy/ZTzM8Ut8+sgdQ0CUYyIfsZ3kAC6T78469PQwGvd2mKOtfV0anI3CIO5A5RyM4NXC5YTKoZ7GKVB3pXU0Js++yzDb+ex7J4UrlbQ1JsXf9KzEPwIHQqQkP1Ldu/S/1L0n13KKTUJd9HCAIpq1Oh3+sK++iMfbUimiy/3gYV4N79uJ9YH6Hsb9OMTX4FhbvS1Vz0br7Su+TWNA9XyasQtw6jr9Mx3NdDLpJNBDVRDcbdNgp6ULdK/PKtrUM/kQEdPkW7JCLNZ2kiTxYb67cEgzRxhhfBQjJLtLVS/ZKqTHck
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(316002)(41300700001)(54906003)(4744005)(4326008)(66946007)(2906002)(86362001)(66476007)(8936002)(5660300002)(8676002)(31696002)(36756003)(26005)(66556008)(478600001)(6486002)(53546011)(6506007)(6512007)(2616005)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pVZGJpdzRzQW5ZMEtOeWoxSWg5WVdHbEZVTG5iN0l6NnhzZi84TVFGa1ZL?=
 =?utf-8?B?WGRURFZ6NGJWWmVSOFZ3d2dYM21iMmE3SnpZbzlOWHhVUWZoYjlLcTlCRmp5?=
 =?utf-8?B?a2xFNWo0bWxQQ0FEamFpbkVUUWRHNDJPZlhhNHMxa1A4Nms5cUZGaGEwZnZv?=
 =?utf-8?B?UDVGYmU4b004QjdONGpjcDF3cTVkaGJqQVFmNVdWUS9rRzBmaVh0UUp1UmVM?=
 =?utf-8?B?NlVsQjh6QkNXOUVnL1RnaXgxaWN2YXJ5bDhxWGhKS3NLK2dEanpRM1M2cDdk?=
 =?utf-8?B?eEt4bktPWERpZXZRV0d5Rk55eEU0SEpsUWlSYzBJa1R2cis3ZUR6UEhRQXNw?=
 =?utf-8?B?M0h6R2h4YWlYYzRHOStxTXU4ZDVaS1F0UllYS3B3RVRDK1lSQTNCNk05TjlE?=
 =?utf-8?B?MDIrcnVtNGR6QlhRQUJ2SmpJUW9yVC94M0E1a2NySTVMQmhKek9MQUNGdC9T?=
 =?utf-8?B?VXVPZXNqNlo0N3lSOU1QSGkzMTk2WWhqbE9sWENxeDd4SElFcTFLVnpKMkZS?=
 =?utf-8?B?TkdjWmJVMitHRzVoZU54OEJGRks1SUhWaWt6aERUT2FRNTBtNWNCckN5TmJV?=
 =?utf-8?B?c1h0S2RxSGlxQWo4WXhOcHk4dkozY25RZWp4aEhaNHdyUlgwT2NLSDJ4amU2?=
 =?utf-8?B?RXlrbHlQNG5JWVJJRGdnNkJzSlQ4Mnd5eXNPUGVkRC9uMVFqN25zeFBJT0Ry?=
 =?utf-8?B?ZEIzditnMC8rOWgyOGI3U2JHL3BWQVJKZGhoZ3NzcnpFSkdyVDlCbmc3ejhS?=
 =?utf-8?B?QVlaN2xWU2piOG9NV3B5MlhkM0x6c01FckZPUzRheExpM2hwZWFzdFE4SWZk?=
 =?utf-8?B?bWxwZm5pY0FOeEMzNDNwdzRFckxGcHA1SGZyQ09sVVFsa25EZ1ZmMGtUZmhV?=
 =?utf-8?B?MHZVSWF5MUh6eFJJSHB2UkRJeHF3cWFmWlorZVRwTkhKYldOd05hWk1PNmNH?=
 =?utf-8?B?K0tuUmFKdEwvZE1ZVTVuTStJZTllc2p1Mmlwckd6VWd0dHNlLzZ5c1lkSnVS?=
 =?utf-8?B?cW5vL3djOVh2dmtDRG9YL3J5cm4zbUlhWlg3ZnJ1VzNzTnM4dTFNb2xJczQ5?=
 =?utf-8?B?MTd1SDJMdmJXNGVxYWNDMDQybCtocXJRRkZSZGdYR3AwbWluWndyVlZYWjlQ?=
 =?utf-8?B?VmVZSXNhY0tLWnorZm0va1h0c3d1VUc2NEdqRnNCckJsbUhVTXY1TU00OTJr?=
 =?utf-8?B?ckp1RlZQVEZUa1orNzRRODZnT1BsSGlPdzJoZWgzMFgvMG9SdUZESUN1ajFj?=
 =?utf-8?B?VGY4Z1FUTDNUOFUydnVPVUZ4ZC9hUW5FMnBkVFlaMlZjNnN0WDh1aVNyTlpP?=
 =?utf-8?B?Q2o1WFUzNzFZVlc5QUxLaWVuZUdXK1hmcUdncER0bmR6em1McUw3Q2dVamFG?=
 =?utf-8?B?dUdaa09tQ28xcVNIQU0rU3ZBMUNFcnFtV2lXV1FSNkx2d1YydVNQdXJHK1hQ?=
 =?utf-8?B?WWltVHF1MnlTOHBQdFFWd21JUFFDeklId2djbS9zMDhMSFl1MWw1RmQwalJO?=
 =?utf-8?B?MEVxR3VTQ2EvVWFoYmZ6ZjlaYVJ3UElpT3daS1l5WHlWNUM5UUMva1NuZlEv?=
 =?utf-8?B?dWh6Vy9KOVQ5YTl2bVg2N2ViWDdnSW8zTzk3Q25pdUhpR0UwN2wwUmlKanFY?=
 =?utf-8?B?bXBpOHJwTXIxWTFiOVVOZnk3bzJ2RUJFUTUyZkNRaU9ZcUdFVmxMNCswYUN2?=
 =?utf-8?B?dWJQeE1JV0Zwa0svdjR5RjdiaklWRExGTVNBQWg3cjFtM2VHS3ZGYS9KcEcw?=
 =?utf-8?B?eFVDUmZ2alUyVXpuUGZoWW13a3hHdmFleUZxdm9vVFNMQlBxb1g5RnFUNkdh?=
 =?utf-8?B?VThzOUR0T2tDLzkreWF1MnAyWHFiQ0xudzR2TkdlNXdFaFAweGVnTmZKMjRq?=
 =?utf-8?B?ejE1NTBJcHp4ZFZvOE9sNURhVEtPR0ZpUVdWNkhkOXVOVUl5YUtpOUZrQVBD?=
 =?utf-8?B?c2RaMVNLRk9GQ1I5M2xLT3NCQ1MvZk1HVG9kUWlCdVBDNXgvV3lkcHRNeWlh?=
 =?utf-8?B?dUF3RUtjRll0V0dNem5CeXhhNkY5WWU0RHExaHU0UlNzRzFtWVNNM0xWamtK?=
 =?utf-8?B?MkZTQmhidDNMUkdIc3dpWFEwZzJ6SVdYdldRWXBXbzJwNE1ZaTRoZUQ0MWZF?=
 =?utf-8?B?Yk43bmYwQXFMMnIxSWRWVy9WREh6QlZZYVJhcEZrblFKR044TE5sazZrdFor?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bd4c64-28a7-478f-3115-08dc2f4130ba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:47:01.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwVl6U2smNxkOofS6d02zO/WWzazt53344/4+OqUYXulXeLGqN7MbhMCMdv914kzJAbSRJPDmmXEHHLfA98derma+QbKrkPsM6S0RMOdrgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com



On 2/16/2024 1:42 PM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

