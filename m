Return-Path: <netdev+bounces-40504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A617C78AA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC64A1C20FC6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720A3E49E;
	Thu, 12 Oct 2023 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM7aqqyF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF13AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:35:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32255A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146534; x=1728682534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kb2t1hhRTV5rKqCMSql1g4fb9PcUrF4Low++NzaZwHU=;
  b=VM7aqqyFMXxhOSuJAplXLPsH+u05nafr9Yk1ABD8q4OzFCaN3lFtD3Wv
   HWXKkGyhpqzUERciKMEK0iWgVVgNgX04w2HnKJ6g28WWW8b3jMUlsyVYR
   SI2RVloGvyp366J9JF3GoOcieKESgMgwEChrDAEvZdfz5iF/sG1vsPM5L
   XNFUye4DHSs5ZSPxIrq5RLJLKY6O8SLY8HxDtxuC2EagU09SSGgWG6Rc3
   0EUC/hu9Na448hWZ3rSporngV+1K9HEh7EKkpA1d9zoCHnDhYV6xbqzUH
   h0PMhvb7PQL7vh+ZARuyQSmbBeRHda7NiMokYW4eZc9uK2pS3Ga1MmGyW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471282384"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="471282384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="748060758"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="748060758"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:35:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:35:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:35:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn1jBC3IPyj00wkBSfIDhHbPehO+2j/9Bluk5h/dlG8Y6tobiUOeiOZnNY2Wql+oy7JRlAogF6rLwOtL5CTv22J1fSukVMyxLQTcmF91MuE4w/TMj5tndzrM7isCcdUdOUxv5NPeczv+3DOTfExx/atxDc67gsDublpIR9ScyLQ4aBSCedOQ0J2AItTfZS9hoCBrugNOxYqHSRWeuy+d5mhZt4L7u3LEGGa7zqM9RecBg69MhE1YAp8WWuUlzbve1sNA20NyKbEyLfsJL4uLSmSTK48chS+A9heCT1vHih567KcUlXSVf+weH2aOmgljEm7MuI3CagCOfRPFCnxY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBTslSScVaLuDwDppDVgOISShzsYWcq1MnC2Gsjyp9g=;
 b=kGPfkGViLiyMwFK5akZj0+H8KlnBjNHJUulpoRI1mrxhGLj+FECGm8b3CiYeWPIHIxjZ4a6gh7lasewSwVn3SahOIqVO/N5SUsXCaMy83WZDuc87P8DIbG8D3D0SHHygzwA5DBKxZpQtR30VaaYEf3PNxuViEfB2fC/gZ/mV3Pud2pDJEvOY7n3kPyl5TT8cNlq2kkoEoau4fPRk8Tv1IgjoCI05h7F02inC+J3kv8wbEHsw3sTbq48P9X0zDky8R5icGTDqMHCFPr3ALBH5i4rRhPi+Iekdeujcua5wnnsHEyJycgYo/+j31YoZpTBxPSczYZFqulduDs28zrz2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 21:35:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:35:24 +0000
Message-ID: <05802372-0c87-47d8-83b7-28cadb5afe79@intel.com>
Date: Thu, 12 Oct 2023 14:35:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 13/15] net/mlx5e: Preparations for supporting larger
 number of channels
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-14-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-14-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 291ce616-43af-4e7a-f8e6-08dbcb6b250e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUWUDZSPFJff/T9pSz7WbEaCmwspytuXWOS/Pc8sy7LSzDwZt3jImYpbYKCNy/X9g7b6WF5imJjWJ7/tl/Paa5mhGNY87X07rdH7XgEeEAlsnzyX6J15oLNOxuvJsgaKN59bCSEzUNQMe3AbeGszcpV4U8HOfJS/HG6hUG5KwfLCtoYKoDE1H27sW6gBXQEAF6lp9oQ28sqDmkzEr3oV3RblVg27vjc5OvBwpeayK1GyygEVRXH3k4a4iVe64xa5gqAOt/iWI30XTMKQrIcmPc0GpFr51S4Pv0l26WubjStAKYlztzvj6OpGfatf3bXwHrsAANa6H+y63WH+4oYuYflQkIXi4k7RG2P1wd8h+o/g/g1/XFFSl5ipWp7gxeCBgewQN40vzfuJ9bHT6QYNOrCeqmsXX2Fqz5pl5Wh/+wViGBwlFhBNLlFXXfXSXhO9OZFWv1TXsM5XnOfjyqTPLtaOnilP65x0JTXrM92+fpPjbuirIIjLdB6vileUqtWfyMSoSe785JuNP8PxqoB6tWigyoBNHhUbyVxkQ5+Cqu8LxmUAuhdajqy0I90Ejp8dSke009+lFYBglBafoxeI+CWySkYzoVTsDTiJpl0ogqN5A6Q4AZ0HeoXt8IDlmQdmvKuHXPWnyFzAf/kFHGR6jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(478600001)(6486002)(2616005)(53546011)(31696002)(83380400001)(6506007)(86362001)(6666004)(36756003)(41300700001)(4326008)(8936002)(8676002)(54906003)(316002)(66946007)(31686004)(66556008)(110136005)(66476007)(2906002)(6512007)(5660300002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1Ca0FueHc0TDN5ZjhPWlE0bXllUFlwOWdRaVp1THpTYWxYTFhobXhlZVBD?=
 =?utf-8?B?UE5VeGhrYmZXN1JBM1dvV2RlL0ZzaTgva3ArMElUZjExVng4cXBVcFBLZ1R5?=
 =?utf-8?B?TldEM3liWnJpWTR2eGFoMmZpQWZaODY0YkhBcUR0Zi9DQ0pYbXNEdjRrNGhZ?=
 =?utf-8?B?WnFLQzZWQ1VVNFQwbzNlZVFubnVLR2xJNkJXMFo0RUdWWXIxcGN6ZHNDcFhI?=
 =?utf-8?B?eGdhbHd3WVE3RHBjay9IMmM3VE52d0VDVGk5aVVzTzZNS3FsMnN5YlNEcmZV?=
 =?utf-8?B?NnNpblRRcWpiZGJvbXVKTlhkS3o5VkJpWGsrN3hpejFuZzZaNUpCVW5zR292?=
 =?utf-8?B?eHVKUkpyVWo1RjNBMnEwL0pOZXRuanJvcnovMnZ0TjRWSU1DSlpBQ0lCLzdD?=
 =?utf-8?B?dlBiZnpReVYvU1N0Z2UxNUNFczNJVkRvUFNHUTc3NWMwcHMxd1RNYzNUbEhi?=
 =?utf-8?B?eGdERmp4Wjh6cTNUaTk1WitFVmNJSjlrNEZ4UnF3T3Q0ZHZucVIzYXpkMkRB?=
 =?utf-8?B?M212TlVzOWlpN2k3RzdmZ3VVRXh2WWlSa0VhN0tncVZtN2tiZTNCajhiQnJN?=
 =?utf-8?B?MS9vN1JDUjk0czArdUk3K3JPRWpUR1B5YkhnTW9HaStwTlRMa3NrQllCbnh2?=
 =?utf-8?B?aUNMT3JVVGQvZGhjVVJDRlFJTmJYekpaYzAyZVZVYlNPYWFMUkFQK1gyMzB5?=
 =?utf-8?B?bG56dkpiMStuRWpjc2U2YlBIcXBFVUtXdXZYRllPWnJieXZjeUNwS0R5UnNi?=
 =?utf-8?B?aXJmcXJLbUMrbTFVRy9aaXRIN3VPdUV2ek5tUzZFQzhibmRiUTVWTkkxZGQ0?=
 =?utf-8?B?dGR1OWQzUDl4ZG9OWExqd2RvUTNmZ3ZaZXkrMUttYWEvclI5OVluSDkveVlT?=
 =?utf-8?B?OWFScWdMVklrOTYzQkJ1bzZ6OEloYWFjUjJTUVcwajN4aEMzT0JmSEdML0Jw?=
 =?utf-8?B?QmNmWFBxcDFJWm9aaDhjU3M3N3M3OWdJblZLalgwOFBkajZPdzVmNUtkNTkr?=
 =?utf-8?B?eElvQUZONS9ZUEw2ZGVMT29kSGVleUpXOHlSbjljYXU2SzdSTXp1V3lLa1Rk?=
 =?utf-8?B?ZnhqZEYrS3lMaTFPV1lKcmFldFRhb0hKb0NJYWRFN0tJUHg3b3dHSE5SVDdC?=
 =?utf-8?B?QWhnaGFjMHRGSmc0TUtYK1FlUFczQ3dRa09TVnY1RUwzZnl3anNvdEpQdjM3?=
 =?utf-8?B?aWZkMzlqSmcyN3BtMUdEUFFYYnoyWkFsU0RLNmwzajlENXZPblpVTmQvKzRz?=
 =?utf-8?B?TFFDaHN4YmFwWjJoVnpGNWp5alcrd1NUR3VxTmtNaFpZZ1VBSmhqb2x0UXdD?=
 =?utf-8?B?bnR2ZmtIYnZmMVRhWmFlRmQ4SHJIeGtCNkY3V1NKSzdQQkNFNWErbTBQbkEx?=
 =?utf-8?B?S29DOGNoN1FZbnVUcFA2S2xqTlB5VTRob1REdVpnaVhEd3dLUlFpYmtEZEZV?=
 =?utf-8?B?aDlWZHVPRG54RUdjQnYwNWJuUjM0SzV5VXlUYXB3WHhqR1dPZDZSK3M0bjdX?=
 =?utf-8?B?eVp3WE5uVDFHYjQrNnJoVHFiSm51ai92QWlaZ1VPczVoNnVvd0lPazJVQzlG?=
 =?utf-8?B?WjMvV1ZUalJLYjdPUGJGd2V1d1pxSmtzcnllRlI3NmhtSzRqSXpCa2paNmt4?=
 =?utf-8?B?N0RnVjZ2NUVyMGJuNzl3UGl0LzlIQi9IQXpVbUpENkFERGhzSjRGVGdCWVQv?=
 =?utf-8?B?N2FqMG4rODJaaG1COHZzeFdEMHpZaEQ5dzl1eGZ2dzBiQnBYZ1JENGFPa3E1?=
 =?utf-8?B?cVJKZzk3bzlrd0lvaE1ZLzJSUWEwYUtCUnpydW53V012eURxTzd4TGRnMGxO?=
 =?utf-8?B?Y1FYcG4wM1hRUVh0d29ldlZGY2tGaE9IQ1JXdFEzY3hLbm1Oc09veG5Hc2Ns?=
 =?utf-8?B?bHVoZUpLbGNzcUZkVzFQWGNjUVRFYWtXWGtGQ2d6Y3N3R1djaytSNzA3VzAy?=
 =?utf-8?B?a1JoZkowSDdLczVHdjJLSFdXVGZZeTNGWmlLTjBYS25NaEFhK3kzaWdWbkc0?=
 =?utf-8?B?Wk9CQ2RuQ1FUR0tXVExLbk5NbDFVaFpkOWZVN0J2bHRMejE5NDFQQTVYOUdt?=
 =?utf-8?B?VzhwOVlvbi9TTFhGVlpORWxWdGJCTjlZY0E5N3BTejg4QnpmRmFNTHplRkN4?=
 =?utf-8?B?Zm5hYVB5Z2NLZWhBb1ZSUk80Wlg5alJmMFBVTmx3RjkwbVpWZ0hzYm51N0o4?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 291ce616-43af-4e7a-f8e6-08dbcb6b250e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:35:24.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8vegnItGa1nBOGf2AmY8iFemU0vUbu/9LZGsVraPyyQ2NV6cyjt6JpUnl6D/w1QyOjc+7Q9fO5Dpz0+HCAqOS4ZG9MHU14idT7r2HZpbI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Data center server CPUs number keeps getting larger with time.
> Currently, our driver limits the number of channels to 128.
> 
> Maximum channels number is enforced and bounded by hardcoded
> defines (en.h/MLX5E_MAX_NUM_CHANNELS) even though the device and machine
> (CPUs num) can allow more.
> 
> Refactor current implementation in order to handle further channels.
> 
> The maximum supported channels number will be increased in the followup
> patch.
> 
> Introduce RQT size calculation/allocation scheme below:
> 1) Preserve current RQT size of 256 for channels number up to 128 (the
>    old limit).
> 2) For greater channels number, RQT size is calculated by multiplying
>    the channels number by 2 and rounding up the result to the nearest
>    power of 2. If the calculated RQT size exceeds the maximum supported
>    size by the NIC, fallback to this maximum RQT size
>    (1 << log_max_rqt_size).
> 
> Since RQT size is no more static, allocate and free the indirection
> table SW shadow dynamically.
> 
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

