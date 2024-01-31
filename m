Return-Path: <netdev+bounces-67705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768C844A42
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AAC1C2460A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C039AC8;
	Wed, 31 Jan 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH9Vkw83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773039860
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737279; cv=fail; b=jQTgwxHb+jhScV+SXmtxzhswWopdfgb9WYdAC0DWVg3vAiFmLnTWnePEnIRiDZN2Ve6eCnueGGCIoxK4eSsdfvgZvUIInciLCVXI1rWG4+E2vP9DpP1bvALe9bz1Zlqj/rwf0YRkM4fatu5FjDaTMB1yer61Ke/xWUbiq0nroEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737279; c=relaxed/simple;
	bh=F0D/MNggXmX5ujq1RkPFpo8UwBoDim4aOT+uHRHBM60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PKY7X+FFbyrhH9OCEwj6MKkoNYuAAKsNi3Ar7sN3OSvv+c+J74ZUqUAr2sjwNYVTE3wpX+YJD3YnbEho3ktMsKvtCTvJ4rZ7YnwN/fRxvvDulBuU41s8YV86DMQfFXsKYjZsiNi8o4PXgazXy59aPFWpKD8naLWqlnfl680uMy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH9Vkw83; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706737278; x=1738273278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F0D/MNggXmX5ujq1RkPFpo8UwBoDim4aOT+uHRHBM60=;
  b=PH9Vkw832Y4Kw0wQFBh4L2+hGGaeq1o9ijIbekfS4gsu4Pi8W2KimhEL
   DNn3OUpiCcQsE7aZhpPC0U52IUuvRBd2yWX2xt+33AFMwu380YfTxL4iR
   tQcEN0AcJQMuJ3XdZGUZaDK2mXvnebXWt/OZttdME4+slKqN5ZhnZJhLV
   uPJ9UIjpdjpYSyTwADYSsUehSCjgd0VtK2zVAHszTsDXxIJRca731Swh8
   wy5fQB1u+552M0c0iE4/aeqbSsT1bcQv/gNIcVJ6O4GG3b0U+EI5z1zH8
   p6vXTFR9umLU+KNJDLC/LQlVL+SIGTmxFxVJKI83E8YynSpcTbtJPHEbb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10834475"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10834475"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878908369"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878908369"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 13:41:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 13:41:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 13:41:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 13:41:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 13:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijBv3HL9rfJ6bHRvmFhBGSWWoxDT1QCgI/8aThitdSq/rvb8VgKUjH1oqA2DJslPYM4vd4O+MN7B7VCeiiHqKnJ44XJE0WrX+O260IxyF2KzkSjQylG2fZyNdua59ROINbdaNyimiP/CPqt2kZQzP67ef89alhoL7sNyW0cecGSKgrcG/RICWjf/uax1Zz4f6+ZI8P6KIwS3Mpol2Npgu01DuvL7bBZ7rMp3SiSKK/VbMnBLbJaG69ufeXaziPENpT3gfFfmpaSaDgWCqMl7h300uYrrDxlZboFDyNAHig4jygcHdebqEum8FydK9pKN0Dz5s/kvhpfsKoQWHk3acQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE8nT4VxPf6Ft0AROW+3yOdGiP6L6GRS5F2WYcLmcOI=;
 b=ilWk5eIpATEYJjjBKDqqzarSDyQw1HP5+LiC6l0WUBV2LN/vmwJuSefE2iNfTfH+naASzZNCiwPIYd/2k8901NGYt2lFZNyeXZ5zyHPB8lhCjyWgkY2dOsDt67HHV3IxM7efT7eANBLzm5dZVsg8Gkj9IN0gQ6oBgKESHvIcQ98f1Y61ZeZAqm8A5lv4YkMlPC2JEELWgNMpnQWGVZjsq+DoWHEQeFYk+oUWiID11mfj3ETHM71Rq73ZWviuTXIR3hHre82dYqAt5WUjYlvhVZu+VBB+5A/yDGwid2YMh8jqrk+TPoLdQJX0uHsAIbVWC9WmTQfQVs5zXsmF95DQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 21:41:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:41:10 +0000
Message-ID: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
Date: Wed, 31 Jan 2024 13:41:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: William Tu <witu@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: <bodong@nvidia.com>, <jiri@nvidia.com>, <netdev@vger.kernel.org>,
	<saeedm@nvidia.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN6PR11MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5c8931-7f10-4188-7b8f-08dc22a556a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfDiaYy/ydMYhG9b+RGdGCvbnS86f6BdU8FmQKYIU+sUVkmXDXSptIfndij/4s2m3Z5eYTbgRzDjUONmzGXQv67dDViOcEyEDYO1qmSIq95hHHQPtlwLJreTE9wI2Wace7HHUbotsMoOBOxSwDPB7Qes9IXjAZ593GYdbpw1TApsyzFCysQnrXbE2k9hdzVy76NqAPB8gzNorwBUtT21N9pvNHYzvjoIvUDD44SuqAQICGGWQIg93ElY5/fYm4/gQcKWS4e/vVMLlIw1We9835iUuD/x4kmH83YtyEY8J73nwUiO0qOIt3wo0SSsnqnX+TZ9jlj94VAOmQeB/wAyfYgTPaxF1bJJt2ZpLfNFtAwPjpJ+wUJnNbBUGg1Jc7HCkYuTNI2+Os+NI8X0rQDkEBM44qOoDI8vIGODF5hhjYM97vIjs1dMVI4HSIv5uB1hNETjU7+ZOOwiQjIRQKnQLcC5DSW1lz9XU6fgukFjvNn5DEi9Upq+TXjjZKFI6swNk4t95K9s07c8JysPXwkfBUUmEsfNWWPP+mJ5D/9TdOk3zg8dL8OazFdE/q9Ydqu8VYPnRX7pJL1xf0HXsJF8jK2hEYbFzG2kl/kqROiP/eyW6Y7FEKJZdSNgBQJhOmFFAHX1e9XcsVAAm1tHwt7vRv/5mK+pzMLMYiYsn0RZIS2I1Lu/oYmSOkUClGieZCCf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(6666004)(66946007)(86362001)(316002)(110136005)(66476007)(66556008)(38100700002)(82960400001)(4326008)(8936002)(8676002)(31686004)(478600001)(2616005)(107886003)(6512007)(6506007)(26005)(53546011)(5660300002)(6486002)(966005)(83380400001)(36756003)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURwallGcG5FTUJQZDBRd2g3eEVnSFo3OFlQdjVxT3JWL0ZkMW1QaDVjalJj?=
 =?utf-8?B?S0U1bVFhTFBNQ0d6cmF4OFRUMERWbkZ4M0F6cGtncUw3alMwWnpuRldMSXBQ?=
 =?utf-8?B?ZlArbFF4MlZhbStmMkxENnVFWDJGNmxRNzI2TlVmRGZyVVM5QzJVQkc0YVVn?=
 =?utf-8?B?TDVBR1AyNVVLcmZubkhjbTRtUm9tK05nU2tlNGFvc1BwRHN1UkE5MTRObWNx?=
 =?utf-8?B?bDNGeWxPQll2Sy9WT1dnSXptVC9KWW5DUWp4d2p1TjZra1Z1bm5aWGRuSm9l?=
 =?utf-8?B?azdrVkQwd2NEZ1M0WGdXMEU2ZnNaWVNaRUIvdkRGbWp1UFpvVnVVNStJdWJl?=
 =?utf-8?B?MG9WZHdvZUtkekt2Rkt2ckM0d3htMUxQbkxxWDJQc2ZBQ0hjYzRoNHhqQzlv?=
 =?utf-8?B?dEZLenBsVlFJdzI2Mit0WE02aVZwZEpSN2lWZ0xleDF4RjRSOStKRFlyTUNM?=
 =?utf-8?B?SEdJUjdWQ0FiKzRYNWtsTTdaTFc0Mk9mQzJ6OXBtWUVtNHA2c0FzeTRtR0hC?=
 =?utf-8?B?eEhabHRPS1Zzc0ZDZGdYYjNOUGRvY1BLTkZ5VXhqd3l3R1BhQkdlQmIwdmVY?=
 =?utf-8?B?VXNhNXFpb1c0ZmNaT0ViZUhxVjVrNzFTaG9oazNlWE1jbzliS2VrOTVxMVVC?=
 =?utf-8?B?SnhQT2lPRVZtY0I3dGxLaEJ6enhDZHBXL3lMeGtLWGhPQUVMay9YWDJPb29P?=
 =?utf-8?B?RUZjQ2Jud0tHem5IWHE5TUdQWlJzRlJlaEkvWldVRkMremtrRjRWbE9tcUFl?=
 =?utf-8?B?RHBOUWprdE1sclQzbWMvMXdncVdUMXpIWTdFYk16WU1rY2FtdXJ0WFVLQkhx?=
 =?utf-8?B?MExTR1JnYzZ6UnFBdzZ6SGYzZTRsekNzRy9OYmkxUXpkcUNEd0g3R1ZZTXVG?=
 =?utf-8?B?aUVBUVRxYlJPbU1MRFlxREFXZVcxMDlnSWNFTGZYVm1TYXNzWVdJUUNYYncz?=
 =?utf-8?B?eGdxdURiNXJva01nRE0zSy9IaW5ZUFlML1dLWHNkc3FmWWNKOEt4REhva3dq?=
 =?utf-8?B?K2EvTGdackNOdC9DRTVpeEI1cVZWSUl6UEg5MFFpaDBNN3ZjTit2TmlaN1dr?=
 =?utf-8?B?RmMvc0VXcnBXeitUVkkzeDhiUllvRjd6NndZZXUrblJCMGdjWFI0dnkwaTVw?=
 =?utf-8?B?QmpiMkZhTVJlc3NDK1FvYU0xYWVuSVg0dVdDTUtXVnBqcm14Mk83cHNxd1ZH?=
 =?utf-8?B?by83VDczRWRSdVczQzU5bTRQaW9hRmdPL3RneEZqN2UzYkpmaXdzN1JkVC83?=
 =?utf-8?B?VE1iT1JjUkRFQjdIWmR5MWVUZmtBZmdaNWh1Sk9nT2lKWVpBTktxaVBiOFgz?=
 =?utf-8?B?OTZOZ1RTOG04dy9TWWtWZ1lkUUpNbWx5K2ZWMUhRYmJlMVIzcFl2ZHdaSjA5?=
 =?utf-8?B?WmpQWHFMcXZ1RWZBQ1dpYU5zSFYxbHJob1hCM09sK1dRaVdlc1VVSVNhVXRn?=
 =?utf-8?B?OGJnTWpSa244UWVldDFMclpmdldvdHNyVEpqc1Y5UlppdHVoMUtiUCtSNy9C?=
 =?utf-8?B?SnJJaHBxa1JsNnhRUDJLY3ZYMjFKcFNWOFdVWHdVdHlpL2JEVUJTdzZWRU1q?=
 =?utf-8?B?WDlHNG5sREhrMmJSUkRPZHdsREtCTUREVmJKdjhSS0N0am91dFNqenJLaG03?=
 =?utf-8?B?VnhCbmNDb3NKRENBYWkxem9hbFJPbVg0czFGWFdzSG1Nc2xtWnpKd0E5cWpF?=
 =?utf-8?B?SHdCZ3ZXeVdjVEZTVExkTHdtRld3WWdORVVBNWFhaDFqZS9Nd3d3YW5KdTNH?=
 =?utf-8?B?VHorREFheUpMUmQ2eUErSmRRa1c2b1BreTVyb09CTmxwU0t6eWRkV0xoR3BV?=
 =?utf-8?B?TTY2THBLNEd3emx5QnhsN2pCNGhVendjaUhhUUE3VW53Szd5cHRUMkFuMGFD?=
 =?utf-8?B?TzkybDZQcGtPeTRxYmk1U1JUa0ZFUkhGekJFK1NTWHAyQWdVK293UEhxSTMy?=
 =?utf-8?B?L0oyc0xETmN3dmN3UGVyVmdNWVhKbVpETlIzYTZCZjE2dnZQWlcvZVc4MHhX?=
 =?utf-8?B?Mk5yODlsNlVmcFFVK0QrM2NoenQ5dnRPbERad3RsZHVUbkFEbElkK3B5OUJo?=
 =?utf-8?B?WW1pc3luKzJDWkszdnNhN2VoQ1R4bTNQMlNRb0JjdWtYdVVJclhaUlVycHc5?=
 =?utf-8?B?akx3djNJeTl4RVdOZnY3bCtGQlhkZWpwS0lRMzM3OWJEUkxBa2ZaQ3RRQ1Z4?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c8931-7f10-4188-7b8f-08dc22a556a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:41:09.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY+se7hcsvAujHJKHgrWRN9YGQhOuIR9ILv+jZGjkb7KtMjHSkQstA6v39h/30URwCWmXSVQqILxr4iMidgddjl91mqJHGvK+Al1jm/jDT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-OriginatorOrg: intel.com



On 1/31/2024 1:37 PM, William Tu wrote:
> 
> On 1/31/24 12:45 PM, Jakub Kicinski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, 31 Jan 2024 11:16:58 -0800 William Tu wrote:
>>> On 1/31/24 11:06 AM, Jakub Kicinski wrote:
>>>>> Thanks for taking a look. Yes, for our use case we only need this API.
>>>> I'm not sure how to interpret that, I think you answered a different
>>>> question :) To avoid any misunderstandings here - let me rephrase a
>>>> bit: are you only going to use this API to configure representors?
>>>> Is any other netdev functionality going to use shared pools (i.e. other
>>>> than RDMA)?
>>> oh, now I understand your question.
>>>
>>> Yes, this API is only to configure representors in switchdev mode.
>>>
>>> No other netdev functionality will use this API.
>> Hm, interesting. I was asking because I recently heard some academic
>> talk where the guy mentioned something along the lines of new nVidia
>> NICs having this amazing feature of reusing free buffer pools while
>> keeping completions separate. So I was worried this will scope creep
>> from something we don't care about all that much (fallback traffic)
>> to something we care about very much (e.g. container interfaces).
>> Since you promise this is for representors only, it's a simpler
>> conversation!
> 
> For the academic talk, is it this one?
> 
> https://www.usenix.org/conference/osdi23/presentation/pismenny
> 
>>
>> Still, I feel like shared buffer pools / shared queues is how majority
>> of drivers implement representors. Did you had a look around?
> 
> Yes, I look at Intel ICE driver, which also has representors. (Add to CC)
> 
> IIUC, it's still dedicated buffer for each reps, so this new API might help.
> 
> William
> 

Yea, I am pretty sure the ice implementation uses dedicated buffers for
representors right now.

