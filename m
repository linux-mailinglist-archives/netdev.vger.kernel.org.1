Return-Path: <netdev+bounces-72550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D1B858826
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B023A284356
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942B12FE28;
	Fri, 16 Feb 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1VTqteq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10474145FFC
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119780; cv=fail; b=oSq/iiFdA5UZyPyzCuj58A41fZZyFQhMkQj8v7ZzdS18WFGD74i2W6Kyfx3sR0PTvpF+B+eQljGSP6Dsz5xsSWaqDtzZ842RMcGPMitcVRXoP+1Q7A1/zTmGMq2c/kIUYx3a3CpcSIFOe5ye3GzEVnYpJ9XCjjG7ceZ26spQVYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119780; c=relaxed/simple;
	bh=Tm+lWh1/6PNo5/Eh8sH3pi227ibuy8PZMXckoM6OIVk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eDJQE54tIpZ+bMpeXD116hBhRMZhuDvjNN+hK9RMMQV30V5seGr/5PgwDoHQVbm82WwA99vEWldSzdNGUJmzaq+yNfliXM3R3LKBS5r3JQYWb6TWS6RBk53uGvD1LKW7aiviGu5sLUe4jpZNi3/fMNqE6zxF2Ax1qkpxCMcc7Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1VTqteq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119777; x=1739655777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tm+lWh1/6PNo5/Eh8sH3pi227ibuy8PZMXckoM6OIVk=;
  b=l1VTqteqXlYepRzLx5CIfwoz2LvTHd/XklSLdgg4GUdHgjJ+c7TMWpC+
   o715TrRuE085adMScm2Q7EU9Td99msvfdcd/jtBFT8A7mnhRDAy/PA/5b
   gOEawTjJLf0Yb4w/26l7vvgEOELyuXVRlTmzChmDjj5GrVzBwLdkAuIS7
   NwIXle9lnG3mdbXoafT5NyX7wLOCd6wdDuG2qs2gEUoJr9rBc12f/9Qd7
   gWBc3z56k3y+MnsFJw1WPAwEyLr/qeoI8Map5UcksKa57ZS1vukh5hV66
   moN/NUSJgfH+bYKsrkfhkSQOn11v0XuaIbki58zPmNRhHJlAqjhkOE7j2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2169484"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2169484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4237316"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 13:42:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:42:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:42:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 13:42:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 13:42:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt/pepxOrccrs9IFYxjf1p8QXDmCNqUXLoN8UhUsu3xJLvBYrmKmosatDz/W8aiG0d3auFIBOrL+BFfZm60uNGTwQd3p5ShbcAEQzkI85kRXSMujvxTlcke5ZG32CbcjCuL1u+lGjC7ZtIIkwfb0DAyEswNBUW/9lZPee9pcemiivB8Q9j0Zgdt8Xe+4lfVZjji1wqR7FdRrfj/jEPKX8H3DAOQySAfTeVyFEcZE2IViSdZt0WBbWQLA4QpZm1ft9lpUD/w+92FiHF6TxnrOMXyjDGXvz1ELOFkcOT3N4oMXZS17FE6ADXpBZM2f5Y7O1RQpwaP+DHgAhFdFfJZo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoQ7bhhNRx0YAvdeGdIfClnbmffF+1r37cAU8KHqdi0=;
 b=lf5a9Xvxh/mioyRF8WHbxBCIlzLU7BltlyLDuj6PDhuNqhfdd3GH1Tc1EhpSbgBljYTOq0ewkc7S4cSMRWgCQPSJiQXqg6YQD2eOuUHtOnMbXKJd05Aqm4Mu3LEwngzuS87bFOqz4vh6Kk499zBdjGul7XLxWdW/i62BuD1t0IJmK4orFmQCUqhfYLjrA0w+pL0W/sLbBidZLlD6g5lxGuiO4OVcS9Y6I3IeA84+jxg9kBHjhcl6l0SdfQq6zLio9CNi7IQRDvkKznIPJYqMu0Qo8CbYiIF2/lKa6nFyHeEgDdDpq90pHSwCuZk7IxqFL0kvJi1MI9IcnrDB6gqsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 21:42:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:42:34 +0000
Message-ID: <bae83d3a-662b-4bfc-ae64-1913d677bbdd@intel.com>
Date: Fri, 16 Feb 2024 13:42:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: William Tu <witu@nvidia.com>, <bodong@nvidia.com>, <jiri@nvidia.com>,
	<netdev@vger.kernel.org>, <saeedm@nvidia.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>
References: <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org> <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org> <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org> <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
 <20240215180729.07314879@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240215180729.07314879@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f446ce-67fc-4885-af0a-08dc2f382f67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIFGvRNtU6vt53j+QKieytb08n3eNmiQ1m7teVqSJDyQvihXEaQmtr6TVCU2gmynwWGHW6V6EwgsiftqzYOLKZf59l4fFCIQRmC+aJfT4jyjmXZEI/S37UGZZe24pOwwVbAyWe3/qGhuAnfFR47XZr4bzQIAZFoHpw2gQBtUq4rDVej9p2oSfOs2OSXEPeRfipU+j67JrDFYK1hX2JzDybb1KEBU1ZX6MMmtCz9gZ3OsjTxH45IY0w3WmV3l5RxzB0K37Ve5Bb2MBqOnwxJpZM38M2cvhnJ9eSmsizdOuSzZUbczNCdA091kiyyMMF2ZWtvMydwn3TbaggGGqalbKrhDVFrSciBn/ZvtA4udhMg8EiaTVmtF9OdOfNPORwHYGIhRnwPRqTWKh8GUJxEAQIdjULmTl5svYkhgtwsYKzxTyhv11Pt6dFsvFyhaXebibrhjTEAkETtXo5yhNXizdbX6G6kc8MwIXiYkxsbJlqaNQ7fwhA6fsSxHl0QtbJ78Lw/gKMtMHnCX1I7+4eXH8ni9uIlVKI9BGuBudZTmafOzJD4sfeMppmv6QMW6X4Cv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(54906003)(110136005)(316002)(66899024)(5660300002)(2906002)(8936002)(4326008)(8676002)(66946007)(86362001)(31696002)(41300700001)(66556008)(66476007)(6512007)(53546011)(478600001)(6506007)(26005)(2616005)(107886003)(36756003)(6486002)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnFJd1p2RVZUZHVJckVrWUZIVE1OYWVpWlNsbUEwY0hmZlZBV2ltNzBhNUdE?=
 =?utf-8?B?dk5aOEFNdmt3dzJaWkZRUDJvNCsxNnZnK3lweXozR2ZVM3o4V0hTNFRrTEhl?=
 =?utf-8?B?TTJSQnVHRHVFUldoM1c1b2g4R2V2T1dNVi9LWXNMb2h4b0ZKOW44NmpFcE5m?=
 =?utf-8?B?ckUrOG9KckYzNEw4emp4aTZoRmFzd3FzRHZJMnhkOG1SeGxvOWZsT3pMd0lI?=
 =?utf-8?B?OEY4RU1hY2dNS09vdmNNbit3cUlleGpZeUVMbFAwS0loY282WUt6cTZlU1gr?=
 =?utf-8?B?NjIvQS9pWCtJa25JYWFxTCtESkVIczByNGhPS3N4REwvYVoyNGtBalZUTTgv?=
 =?utf-8?B?cU11L2gyN1ZYZE1vZHpIM0ljMUR3VVlmTW9GajZhVDY1OEppSkZJQ00xdTlp?=
 =?utf-8?B?eHRHUFhhSWlJVVhGOUtKaU5lSmMzRENrN1hEM2d1bDhaV1NEcHBjUDIya0Vw?=
 =?utf-8?B?VFZxc1puWnV5WWloVEpjUWtkcURYOEltUm1ZSk5RcmFMellwVlcvenlPOGt6?=
 =?utf-8?B?b3JZck1idmpIUzFETTIyVjArUG9KalAxNnhhSVdieUoyY3ZOTzVGc3BneDdn?=
 =?utf-8?B?a3VSU2JkejVrMkg1blNLQjRqc2hETUdBZytzTktVR25rTmR3OWNmcEdFSUdm?=
 =?utf-8?B?V2V2WTZ4TU4xa2YvajY2aXpMYlZKS0xPcDR4ajBxbXJKZ0VZcTFyTUtMYXc0?=
 =?utf-8?B?a3dpaytGd0lUMnhCOVlWdmRjZnNRdEliamhGMG1kelNSZit2cFlpUkc0cDRP?=
 =?utf-8?B?RWduUW5uQ2RVZGFnUlhEY1pINEl5SmNkN1lYWlZzNnIxYmFtOGx6WkJrTEZn?=
 =?utf-8?B?UnFpbjYwZlJCZitBYlRpK1pBV0VZRlUyRG00U09aVU5GejRoVGtHZkpCUnQx?=
 =?utf-8?B?TDhuWTlVZFJ4MGdCUWFrcTBkMzl6WExHbzJiNkJJd3BXeVZ6RHlEaVBRTHBl?=
 =?utf-8?B?QkF3RDN3Z3RJNGd1M09lOE9saEd0VExuT2VLeTIrTGFFZWNlLzcvT3c2VnI3?=
 =?utf-8?B?S2NOK0R1ZmZKcHVNcXJkakZVd1V5alFUNVBNV2FlVjh1eThEMnRNMkYyY0N4?=
 =?utf-8?B?Y1l4VUFIOTdLVStwdzY2QWVtdEtpNC9ZbXFUUWJsbHQwbXR5S01rMmZibiti?=
 =?utf-8?B?M0xmNWw4NGo3YVhreU0yZWpVZjMxK3lFTnU5RzFYQ3AyemJsY1lYeVVCeUtC?=
 =?utf-8?B?WFIvRkU5R1VYS2gzQlhld3Y2dHlXWDlxUzdmRUZTQ3BlTkhoaXVrSkZmeGtr?=
 =?utf-8?B?RWpCTkxTcW05UVZqUVJLM2Z4Q1E1UERFQll3M2czY01WVkNWaUliNDdZeWdG?=
 =?utf-8?B?bGl0MWRkZDgzcnZpMjJYeVA3anNvTkg5eFZ5ZGFDZVlwaUFuak01MjNzTXpW?=
 =?utf-8?B?ZklaTkpBREdDdkJNeEZxc2h4SnBVTlJZSlV4Sno5ZzJ0eEdhQ1YxNjZNY0pa?=
 =?utf-8?B?NVpZWHVhbnRCRTIycW4xM1kyRWswTG1xQWlsb2I5bmUwNlVUaDZpRWVJK3dT?=
 =?utf-8?B?K1RMVlRPVFdid29pNGc1MWI2WjdZZEtTV2xvanhOa0krTnNnTG56QTZZMnNT?=
 =?utf-8?B?Wko2NHNST1ZrNXJWdE5Eejd5VUxWTkhXS1BMMXBmRmJBeUs3VlZKV1hBUCtJ?=
 =?utf-8?B?SDFvcHl2aS83MEVIUWRBRE9KRVVxRWpPNFhBdGE1S0JUeUl4UGhja3lNU0dK?=
 =?utf-8?B?dkJHM2dyK0FBekFUWU1PSkhZOFBTV1A5NjNQVWs5aHQxL1NSVXd0b3NURWMr?=
 =?utf-8?B?Z2VzRDFsR0ZZUllOMG1tRUN3Tk53T2ZrUzRMMi9QdFRoV3dxZ21jY1ZGYzVy?=
 =?utf-8?B?MkU1blZTQjFQODNNZGpabEsvL0U2VXJVUS9HQXBtd0pjNUg1ZE9KSmM2dWRO?=
 =?utf-8?B?bTV2a0lWUDRLOWxvUFZCU0NOaHllUlQ2OHN2NTRQUGQxNXExRFlMa0JBWjRp?=
 =?utf-8?B?K1IyY0JOaTdvR0VvQVlzOGF0T0xoSjhqYUJkSlVwVnoyMmFpcll5RkpKZkNK?=
 =?utf-8?B?NzVQaWE2SHluYTNMbVhaWVJmeC8zUTlYSU1TanlPSVhJdnVZZDdURGt3TWhi?=
 =?utf-8?B?YTRUMXFRQTVOMlJWRHFOM2xvTGMvMzMxcjNoM3l5OTBMVUdEVVQvaDhjT3Y0?=
 =?utf-8?B?ajduWU04NnR1ditURDIrdmtyWVNUQUxyM0tETWw5SklyU29KWmhDNTVVMERN?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f446ce-67fc-4885-af0a-08dc2f382f67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:42:34.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAie6zYiWo/qjnxrnZc4AfvJC2cAzXtjK00RuYs71dgt529cNyKmng89+hdDUMlCNu2PC1ZlS2Ok4Hm+esGxZ820h0yiybCj+omi4rgwu8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com



On 2/15/2024 6:07 PM, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 09:41:31 -0800 Jacob Keller wrote:
>> I don't know offhand if we have a device which can share pools
>> specifically, but we do have multi-PF devices which have a lot of shared
>> resources. However, due to the multi-PF PCIe design. I looked into ways
>> to get a single devlink across the devices.. but ultimately got stymied
>> and gave up.
>>
>> This left us with accepting the limitation that each PF gets its own
>> devlink and can't really communicate with other PFs.
>>
>> The existing solution has just been to partition the shared resources
>> evenly across PFs, typically via firmware. No flexibility.
>>
>> I do think the best solution here would be to figure out a generic way
>> to tie multiple functions into a single devlink representing the device.
>> Then each function gets the set of devlink_port objects associated to
>> it. I'm not entirely sure how that would work. We could hack something
>> together with auxbus.. but thats pretty ugly. Some sort of orchestration
>> in the PCI layer that could identify when a device wants to have some
>> sort of "parent" driver which loads once and has ties to each of the
>> function drivers would be ideal.
>>
>> Then this parent driver could register devlink, and each function driver
>> could connect to it and allocate ports and function-specific resources.
>>
>> Alternatively a design which loads a single driver that maintains
>> references to each function could work but that requires a significant
>> change to the entire driver design and is unlikely to be done for
>> existing drivers...
> 
> I think the complexity mostly stems from having to answer what the
> "right behavior" is. At least that's what I concluded when thinking
> about it back at Netronome :)  If you do a strict hierarchy where
> one PF is preassigned the role of the leader, and just fail if anything
> unexpected happens - it should be doable. We already kinda have the
> model where devlink is the "first layer of probing" and "reload_up()"
> is the second.

Well, a lot comes from the choices made at hardware design to have a
multi-function device but then still have pieces shared across PFs, with
no clear plan for how to actually orchestrate that sharing...

> 
> Have you had a chance to take a closer look at mlx5 "socket direct"
> (rename pending) implementation?
> 

Hm. No I hadn't seen that yet.

> BTW Jiri, weren't you expecting that to use component drivers or some
> such?

