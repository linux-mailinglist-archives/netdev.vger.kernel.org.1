Return-Path: <netdev+bounces-64886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BA837588
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CD51F2BA6E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8C481B9;
	Mon, 22 Jan 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVT4OUwx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705847F76
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959559; cv=fail; b=V3em8/1sxjVz5XFbkEbiv8fE7TZW97MrlgMYn4923VNBJ6t7Rkzi1HbJjhnb+rxjXJdrMGMVc+V8ERN1VORsvHpxpl0JQexho9ORWP0RdgA9X39T5iStzyUDbIUf0nrYCGIxgFLNGzqaz/+JJ3uJjzMBN7OvovFbuNmlYeC15Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959559; c=relaxed/simple;
	bh=hx6MnKwyyr+fielU7fcHZS4mZJtsB4VOQMW169C2zSc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NYujtX+AUaROItgjf9swnBzNftgs4+laWB51U0+4JdUQrZyN5lWbl8LE1Qha1qdgXpxno4kRBaEBjic6FoHOE1YmZX1CJM7bTh25bPBwq6lYFhQQAKG7fyTy2q9/fE8lTV2b9ItvF/fII4RqDJ5qe4T6o/2Y+uZpK+fgkGwF+Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVT4OUwx; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705959556; x=1737495556;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hx6MnKwyyr+fielU7fcHZS4mZJtsB4VOQMW169C2zSc=;
  b=aVT4OUwx8zJNKcZlQS5PeIWI7zfVqUu2fGivV/E8z52Cx+p+BF/HhPh+
   +kShDAh20EuNMkYVLLcwbZoH4FmGZCrn62gKTk6jXqysWjMT/LU2NFyHb
   +gpDmIRz6LIyAswJ6zY+9LqpSho9qK9dwqDiuMsTa49oFxGgLR6S9Tbxw
   YzhUf9RSZrpr362ov1UNx5laiHVJ17YYl75YGYZOM3mep/CasNL2M5xk0
   3TfY0l8Z3fM0POd9/nGUTtUC8Av9Gw1HsUn48+k5rhdmme18M3iCV3RVu
   OqgwE27Ahqccx6yZaScwcGqHGJBo2gOADV7KTyHkUXLyisxDj/O7IbFk5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432492464"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="432492464"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1442152"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 13:39:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 13:39:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 13:39:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 13:39:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 13:39:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmH+9N1gBbCV6/jLqjtIASpGpD+y69WFpu1JS1boevf+46Fcnox5RF0LOexuNtSoBy6Fwly4d0tUeP/97BpnwVOJ/uaf2lTVqVetT5J3OufyxKrz9fSzkC1D9R0DE2+ELjjkDlRrGbi95gULuBGNHUjLC2b6h6QzsjNixorC7Oj963++++gDcN9Ckb3hHov8DtdzuVnl3tCvGyhTlTd/Cfv05PRq6iNy9qAxen/KAgsK6ooF/JI/eih61d3fqqvs8T0VVlXz2/YpvROY4TWLq/pwQQ8gT5zJX/QnWgXSjWImR5fLxTZDzXxiJ/Q1ed/DnDyp3wFBpZbwCVwKFTnOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTKZB2BClAgOuR8aafd6ycnxkAq1a08r1hgEi3FQ080=;
 b=EO/0/y8ugsmb3z5opNR1/Ml/IVWBlsrTgaHoxinQhquQ7pLupqi2syObawo0SBo/t9E9+/p/x++EbptsrsnATGDrioeF9qMde+VOkF2L6W/9hQ4NaNmOJgT+B4RUrYD9yP9535AkhmLLE47eU6fRq2JAX9PEf5nZk7O6UGvl/nZT2pujxpAT5UGLGfbAtbttJbGr4q9LxnRlm+GepHP5gDG5x5DqoqSCi3PQ76o0mfNibCUN1o7Tk0xdQAjXyFHYOQ0q4nvZWRJQHUVBp26w/tLdxxzGYBjao1M3y33ITbOzof5hEOX+ePS3yLBdPlIc6bjJyA3R4iZRPqeyAU5ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 21:39:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 21:39:12 +0000
Message-ID: <30427916-d123-b180-b64b-314d0e81cd63@intel.com>
Date: Mon, 22 Jan 2024 13:39:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 iwl-next 3/7] ice: rename verify_cached to
 has_ready_bitmap
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
 <20240118174552.2565889-4-karol.kolacinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240118174552.2565889-4-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: a0502245-6c80-46eb-a520-08dc1b929318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KehQtUJBvR5zJ6SIyzT0yRcvczPYJx9hduUh40hGreCtvec1KCs3nlMSowA0P9pTfI0Y4Rga66TStqQmRtsavpWQYzo01hlPIWRLOGVvVemeOx2xGQuN6o33vvL1Kr+bUWrxFLFE062b41NQwfN0ARhKDSzpd66C7lvXPWXaaJBHP81T6DPK7QTIq0hQYYXWfeKpNIZxExF/0gQdPYGPxPVKmvlNViMKmWmlvioF7V4S5EVnCQV5l2/5ffJOaGjO7qudgxHh9AzHPhUzbQV95FBWqz1clcqujvMzph1BC7L7b55HLoCGcggTDO5B9S0qvvZ8x0MzTzEX38cjV1hgbuWHWeIBTVS66zeiA86cg4djr/+A+T7ONC+OWUlR2ABtFkH3AzzXKaalOvxdIAc7I2hEVkkhETN8e/SVzdTaC1Ddg5BnyHu9K7cfz1nKEvaYyw0Po4NpstmVXHFsKwQQCUMBiBo4Hs9CjzXTu74vwxl2qL9iEoFZYxFjF1AKxa37NmVJDyaJx9qqiK6LJRXrOUPxb0eyqkLAz9Lqd7rlGHM3avBivgJTr/QuVJC4+0dGdUx0LXDQq+UkGqwGsUNt9b2ehZ8qNVKXNjypbbWnOqv663ZMupVhgyf53d9BNasCvozVXY7MB0eL8iN6erztVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(6512007)(6666004)(53546011)(107886003)(2616005)(6506007)(86362001)(38100700002)(31696002)(36756003)(82960400001)(41300700001)(478600001)(5660300002)(15650500001)(83380400001)(2906002)(8936002)(8676002)(66556008)(66946007)(6486002)(4326008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pOZnZsZVN6Zm03R2ZPb004TnNhT3JPZGROY1RuKzJEM1p6T1NOajJYWVBS?=
 =?utf-8?B?cjRxVG5tNDQ4NlBmdFhXNkM1R1N5WThSRE56WEl4cGs2cG1qNmZkMHR2QVYx?=
 =?utf-8?B?dTRzbFM1RW8vU1AvYmdWbmNEKzJEdmVJMVlwRG5nN0UyNWVGdGdnRC9RRmM2?=
 =?utf-8?B?TkNuYkNrelh1WU9vV3M0RXhaOWRxMnhGd20zMEg5MG95b3pWSFY4MVJQMjFJ?=
 =?utf-8?B?Um1SMGZlbjd1VFN5bGNuUVJWM2lreGhpZUZxNU4ramJuUndGOWxsaG9NbXJS?=
 =?utf-8?B?Tlc4ZWVhODJRM3RidUZjWVFKSW5zNEJtdk15clJxRTIzaUlacE1VWFl1NGgr?=
 =?utf-8?B?RHlCL1FmSXY3TUE4eGlnTndrR3p2aEN4b3NNTlpoVTdvc1NhUXZ2cHJUeDhE?=
 =?utf-8?B?STh3bk9KVzlmYXlITnUzUVlMY2pnM21FUW9HZ2FSU2swbWVwWDQ0bGdZd3lX?=
 =?utf-8?B?emh5bTNFaXlCNkVDMlFtazA3RHhaMDdrbFJYRUE4LzFnczR2eHpwWVJQcXdK?=
 =?utf-8?B?M0JSOU4wTmxqNElCaUFzdGhHZFNMc3V3ejFVTlhKdHpnbWRWSncxaHdRNDJ5?=
 =?utf-8?B?MjZERm1OK3RhSytDZTNWOGFwd1lUdS9VbmErc2c1eXRjQXh5QTZQRUc5bU0y?=
 =?utf-8?B?QzA0Q2NpQXQyRlI4SXFRbWEvaWl4MittNWdHS3ZNNUV1T1V5YXFmNUZ1N04v?=
 =?utf-8?B?emo1Mng5RWRXNEV6R2tYcWhhNVVFNkFoVHNCYWhsZlR3SFFCME9iYklZUzIw?=
 =?utf-8?B?SmFwbU50MlJ3YkRDUkRSU1E5VGZNbG5ubnlZcXpGUE5DemJCMXFZYlpSRFhh?=
 =?utf-8?B?YkpNamUyUSs3b1N2L1d0aFlyMS9yL1p2alRoelV3bkhKZkh0QnZSL0JUdDhz?=
 =?utf-8?B?WlcwaUtOODJhZG03L1BWSExYMUV3bkJ2b3pBcm5LZFdpTUE1VndnbHFtY2Zm?=
 =?utf-8?B?aHdDTzhxblZWMWd6RmpjcDFwTlZBUUlWWUFSNWFiTllMRFRVVFdnUlFFUkFr?=
 =?utf-8?B?ZG5sdG9SVU5xV0gzRmljWWZIUkNxaElRbFhNbVVseEFuVFJpb0NzVVNlUnVj?=
 =?utf-8?B?TC9OTjVGNWg4bUt0MDZreWxtQ0N5N1EzWjFiUWxadXV3ODdQeWhKa3hmaHJa?=
 =?utf-8?B?a253QURJSFA5RUwxNVB2ei8rMXNYWXFTejJhZ2xQVE0yR2FvRGdPcHNqbThK?=
 =?utf-8?B?LzBheEsrQUhUZnoycDkyblhSWkhNTXhEaE9wWHdrZ3FOd3dyZ0JaMlorU3M2?=
 =?utf-8?B?QVlWWmFtck9zV3pva1gxQ3FRclF3T0FBOWVYN3hKcHFRSEFrdXMzL3NNbitC?=
 =?utf-8?B?NVhCRktnSllYVkl2OU9wckFRZ1llZGIzYmlJNVBKTXptcFo4ZW8vdDBYSHVw?=
 =?utf-8?B?WHd2NXpWUjROUFdVZzAzUll0Nmdyd1l5b1czc042Mk9xb0pJY2lCbG1lTFNQ?=
 =?utf-8?B?ejFaSDdRTDV0YlRBaytJNWh5d0F1RzMvcHpITTBGRHBnK2dLM3R1WnJTeWJV?=
 =?utf-8?B?SFhxRmUwUEhwbFh6K0tIb0JiUXE5ZkRkVFhIbGxjUXdxaUhMeXJweXVSVnZV?=
 =?utf-8?B?N3JoK0xyVnBRb3kwWHFUTm8rZWs1OFQwWE05ek5mdUhpMW9OaXRJdnB2SzBk?=
 =?utf-8?B?R0lDR0NTd0FZZWlEU3U4YjVNOC9UOExEWVpLTkcrcUpQTnRuc0wxTklmMDUw?=
 =?utf-8?B?REl2ci95NEpNUTd4N0hBY0RIZlQ1TEtMdkhsNzR3Y2pKbGJmYjFwdTI2dmVr?=
 =?utf-8?B?SlZ1S1AxVHBhbWlvT0RuSlViNFV1VVBQV2pnQVU0YTdIc3kyNGpIT3NmdU1N?=
 =?utf-8?B?L0o0SzVmc1VReVgwQWovQ2tEWFVYSllyWlJoODRTM2dpR2VGaUpJWW5welhI?=
 =?utf-8?B?WGQ5Y1owbUsxWmtrbWRMVGRjSy84aUkrVkZPZ25tU0l2eVpZUmtRdTJvOFMv?=
 =?utf-8?B?SUM1d0lMbzF3aTV5amcxRGlRYnpoaFNSSzdwM0c0WmN5NjFsS3ZzblhtdWJD?=
 =?utf-8?B?QmdPZldkTHhzbGMzM29UVXVTOXQ4T3I3Mi9YUlZQYkRDamhPSFcxVHNkbHRU?=
 =?utf-8?B?R0dkRWdYTmJKbHpFSi9EUTFTeWtiYWljcC9aUlhWNUJpVU43bkExWFU1d2Na?=
 =?utf-8?B?OE9hZ1p4TG5wMnBnTkZ6UVNaSDgydmJDSUEwWWlYWWhsVTBWcmY2VlpoMXNX?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0502245-6c80-46eb-a520-08dc1b929318
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:39:12.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxFDrHAenMCjnt+8mKAdAq91+mpR6euQkwiR2xLg8vOpr3ERCjeYWfKH6VQPU1cCxv3ORlfYdvHBdYB61hbf0YKLphlDaSqlo8q9Tce61Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com

On 1/18/2024 9:45 AM, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The tx->verify_cached flag is used to inform the Tx timestamp tracking
> code whether it needs to verify the cached Tx timestamp value against
> a previous captured value. This is necessary on E810 hardware which does
> not have a Tx timestamp ready bitmap.
> 
> In addition, we currently rely on the fact that the
> ice_get_phy_tx_tstamp_ready() function returns all 1s for E810 hardware.
> Instead of introducing a brand new flag, rename and verify_cached to
> has_ready_bitmap,

Looks like you missed one...

drivers/net/ethernet/intel/ice/ice_ptp.c: In function 
‘ice_ptp_process_tx_tstamp’:
drivers/net/ethernet/intel/ice/ice_ptp.c:754:35: error: ‘struct 
ice_ptp_tx’ has no member named ‘verify_cached’
   754 |                 if (!drop_ts && tx->verify_cached &&

Thanks,
Tony

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


