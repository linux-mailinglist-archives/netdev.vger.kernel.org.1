Return-Path: <netdev+bounces-72573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4B858918
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5DD2825D4
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFD39856;
	Fri, 16 Feb 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMaTjney"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14917BB9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123571; cv=fail; b=OH24vtraZz4xmvsnZ2weLDFovA6DJ4HJZg1cJnSM+AhdfOy0DVhryf72fn4ss+2xt4edz8cEgOUZdXkZW8GlKyQaXnbJ6YgygMPRN/093LPQdGRtDYlZvlWh/rNomGy827P8jA7Ay6hHpa0HhIv65La7jND4kQDvLWmyTrAOFU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123571; c=relaxed/simple;
	bh=KigWAEVFGtAXdN7wHNCzFhXcnjQGeIMDkpS41xTISis=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rjjlql2BzRb37Qqc1WhOsvcQIVQ/y6v+/0CurdpXP0uF7p4SFctYbj7pH+JnW7cFBrJsNPHXy1t1JxjJauHT+At+H9qExCuqTPI0UgfoDT39fcEZCIMK2X1/tdLtgsOVFiVtNvOQIr0WefrGLhozetdvgjttNKKJTDFzSvnxjPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMaTjney; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123568; x=1739659568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KigWAEVFGtAXdN7wHNCzFhXcnjQGeIMDkpS41xTISis=;
  b=KMaTjneyFC/3S/S55hTrUZLeH5PAIooztKIzD9ckU9rQBV0Kh6OISvxC
   RR33jSXs4hX4hFmgUm+3goxdPdTxwxFP89fzPe3HZ4nK9dxMWaFEjgCfJ
   idbqr/WJDxmCJqgK0iLFLimcrKwInI4IsM3iH+X4e8lYuJU1lcWdL48XH
   7OAru7Vcdc43QfWaXnAwV/TzM5IvLE6tPUdJG1KGgT9kJRopfkaQRugva
   8ZfZ+PUCWf9QpO2VeGzEhq1J2F6rVvXTAXmoUJtfgD3/OQmp8XEvu5IkT
   WynGcgVqu3Rtfv3aevsQaXxpWXOuTt+vR189xEvgqUhZF1TbmjMts/zZB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13373073"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13373073"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3936886"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:46:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:46:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:46:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:46:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA5qtJahhjwc9kJpZeCYDLax/lDRoaCV/3uSx9JqvFAWRDCwQp5uKOKqBg7608uA9VUrHi0W8cYB62lBCqkPG+cB4Z9u9UxFwYeybFkEe1UYG4coWpDqUPklJ+PGj65mIWmau+NfyDdVWt46MlP5pXQC4vDYWedUnEy60zx/mdqWKvwvR3M0UOWtKIK7Hp8ywDuRm8Y3Uos7+qAl3y7wmjyXi3L5vBivseIb9aY+LyE6jHFrZ+v0pRU/jIUdbXmyyS0cJy1exIrlAZJznVZ8AijLIwesmCM7zui77FsnbnNbEGjRHqqo7FVLDKa//nuDW5w4cqS7hNw4zVYLEUujPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFrC4yVAAPCd82FuAPYucopx5wTJWJmCnmkrBh73gIQ=;
 b=gKDdB1SAtdMxcf5LHpoxCkPLjp3Pa0h19Rt+LiQMINSN/p+kF/pZPTNpsZyxRkwZSnCWdBVBbK8a9YXj0F1ZQgdLGiIZBr6pQvGnK2ZVVlCTYCQYETc0zOBIAWxCpNzaxwEjA1bk6XtRemFdrluzpntNY8uDXoINQJNXZIEhXENa0RHTg+ggsnCuTkm7x3dFhHOM0p8qj05DhOGqmw7dMezbi48mb1T/69yLq36js1kmtZZA1IqK6wtmCy77NPqKzz6Oldq3kcRQUI8H0wJAY6ZhbGY0WHtkYMG0hT0Er9LzkYymFGACPsKTMcq8Xz1pEcaBz/psPJ9N0wVwTRRzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:46:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:46:01 +0000
Message-ID: <0009b666-5ea2-497e-b67f-c77bfc5455c6@intel.com>
Date: Fri, 16 Feb 2024 14:46:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] i40e: Introduce and use macros for iterating
 VSIs and VEBs
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
 <20240216214243.764561-3-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216214243.764561-3-anthony.l.nguyen@intel.com>
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed2ef8-095d-4583-011a-08dc2f410cb7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkZVyQWQzrZbxVlQRcvfKnB9eG96uExu/uDaRzjrmWn+u6axpyAriRB9tZez303tTA6TngFhHv7+TfrhBoWWbt9qhtioTL7PiZp0Uj+S4zOi9HoVP4as2MjIo6uYhcxl4OQVsuFTtij76/s3xmT4OkumYWX2zjxaVLxSwDJXmV+sy3ZNsRkUC/vYkFSPlB4GgfelzG6gLZbAZWAlULYMnpqOCB/0qZiLcD+DUsJFgNc5vF6FocEvbvZRb30XnHlnQ+ikl5CKUiKLVfMvwADhj2maI4QOUQ+C8lrsyeJnYUapsx6EDDFYgkHoh+wRbXFpzvhix/XsehmDlNFAH1+A9i/az4Yu+3TncWHPXz4ilB9Xwo92pF+fB5AORqs9BdnPBV7OZKbWX7vOiJSNL/fxKPHoojSvG4MtpygF8pXw9/ETE0wy9tumWc1KNisKiO8zkFMyotR8ZmWpZ0Ar2Sqzoc6oYgcB4RwSaTONrkhMgowfTcCStNpeg8ntLcn+K4t8z+y5l6ysrPxriTNGC2cr9NEI8iA+vaglS3wCKJAucZfamEHtnm//TNZ4x7bRyrDN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(30864003)(8676002)(66946007)(5660300002)(66556008)(31686004)(8936002)(2906002)(66476007)(4326008)(31696002)(86362001)(36756003)(82960400001)(38100700002)(83380400001)(26005)(2616005)(6512007)(316002)(53546011)(6486002)(54906003)(478600001)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBjRFNmNkpyQTNSUXl3MU1NU0ZwK1FKaU5hQ3VnU0YvVk93MnFjUlRXL2Nm?=
 =?utf-8?B?U094M295WndmbytDNkRMUmNOODVyeTM2cVUyd1FmZlZ5Uk10dHdSR1NhbEkx?=
 =?utf-8?B?OVBkRHNaeFNQbUxCM0lUSWFvRG52Q1ZKYXZVbE1jYTVuV1RlU0I0eHZkOHk0?=
 =?utf-8?B?b2N5RkNlU0xMVG1wbFZLRFFvL3ZlLzdRYlpZVk9JQjBQL3dibVlQR3E4bEg3?=
 =?utf-8?B?SkRGdzNwQnczYzlGcU5CM1lCVFhPY0NaL3ZUSXpIYXBEZ0NTOTd5dWlzS09N?=
 =?utf-8?B?cWdqRE1sZ0prajlpMGRreUwvMi9qMmdHQXVDalZzN3FmNDJRV0dESThJY3Jl?=
 =?utf-8?B?UExRdUFLeXFBK3FjbjZKcEZsalFHSjh4UVRWNFFIbWs4VWM3Qi9CSm03aVg1?=
 =?utf-8?B?allRbGE4eXJNamYyY2NGZjVqY1k5RWk0K01wT05qTVNsMTNlYnlDdXdWVEli?=
 =?utf-8?B?Y2kwWTNVbU5QaS91R1BFRmxpMGVOZ2ExQU1nR3VVaUpnMWJIRkp2STBpbTNV?=
 =?utf-8?B?alZKQWRIc1lJODY5UGlUSityVnJoNVQvWUpQNXAwbk92QkorbkcwRy9VT3RL?=
 =?utf-8?B?YWphbUF5SVo2ZVFKTGxlVU1URzJDY2NZc2VKRlB4M0xUM2hkSmZJRVc0R0dS?=
 =?utf-8?B?Z1ZZZmNDMzVMQ2RVMzhaK1VoM0FoeVdZQ3RsY01DMlZZbEdUTlo3TW5DVytv?=
 =?utf-8?B?ejN5S1ZyQko2T0RnZ2tIOEMvRVRSKzYrY2NMblJjK3ZtbkpyQk8rNXlUU0Jn?=
 =?utf-8?B?cVRrd3VJSU1SLzIvanMvOFZPbVczQkIvWDB3YWx5T1B3TlRjWkkwVTU3dndn?=
 =?utf-8?B?Uis2dThnVGxjZHc4T1NxUWVuYnA0SFMra0k1WjRsU2pZaU04TlQwampMbHpz?=
 =?utf-8?B?dkVvYmJwWmV3LzAySzdqcVQwMGcwS2h0U0hMZ0V5eW1GS21lUXQ1SjFmR0pW?=
 =?utf-8?B?bmY0VVhNc3lER3k4QVprVkdZQjdxL3Z3UFFFelI4M3VkZDMzRlpzTDE3K2pa?=
 =?utf-8?B?S1p3OEdpTEVrSDFsYW1kaXdMdkVKcHd0RC8rUkZLazQrb1BqZjdVSDk0MVJu?=
 =?utf-8?B?QjhXeHQvZU9QUDNPcE9hOE1xRDBUVHpZN3lUeGJ4MUNuR0djWVJNZHcvd3NE?=
 =?utf-8?B?ZVp3THpXbFp0WVpXei9XTUFLWi9TaEVDV0dnemhnTldadEZWWDR6TnZHUjRT?=
 =?utf-8?B?S1Z2SHFpcS8wRlZkNmMwdklTNjEvdFk4WWRzbS95cGdxanJWS1dVUWl3NEdt?=
 =?utf-8?B?elhjTWVOME1Rd0tJdWZiYkl3Qis3TFl2MzN6K0oxR1ZUNlZCbG1MWGVlWTV1?=
 =?utf-8?B?d1Q2b3dQQ0xkcUFzTUZHalR2ZDZWN01maFRIV3JaclRLOEpUek4xeGtjT29z?=
 =?utf-8?B?MGlPbC9KSjVlSVlCRytNUytFbEhiTGw5TmxwdzZUVHZEaTBCZnBtaC9oaldY?=
 =?utf-8?B?bkVqWnI0Sk00Y1BvZ0ZRUmZybmx6ZEppU2FGVGxIcmhkUWJlQWcyVmUvLzNj?=
 =?utf-8?B?aFJBWEczSGhGWFRGazhCY0tsYUE0VWxkd085WVBIOElyQmkzZzUxeFRqTHZW?=
 =?utf-8?B?Mk9qTmdwRklVQ1lrWFRDN1A0c3FvSzhOZ2dFOTVYeHJHL0ZTMTFKczZ1N2dv?=
 =?utf-8?B?MncvV2hZT3h4bUE3VXhrYjE2dGlpYjZtbjQ2MWJtdkI3ZFAzZXk5Yy9YNDV4?=
 =?utf-8?B?SDlSajVveUlzZUlZWmNQQlNObklYbmJ5dExkOS9lNDVhQ1RlcC9BY0lZVDIz?=
 =?utf-8?B?UEUwamtlS2FTTE1LMVpFZUFWb3BWYU5XVzczb0ZUaXZIRmQvbU5qSURRVDcy?=
 =?utf-8?B?eVhURXp0YkxUbGJkaDhQajU5OUMrNnorOTFhNHAyc2tHWHRMZ2FBY1B3eXVB?=
 =?utf-8?B?STE3WGlyM2R4eWFIQ1dESkJ2QzAyVSswM3BiL2wvblNCaG1EbVgzVEMySXBi?=
 =?utf-8?B?L01HOGRLRktwcUgxZVdXTTlPZGdHNHJOUUZiR0R1ZzdVM1ZzaUpmMHN1dnk2?=
 =?utf-8?B?bEY2YzRBemtJcEJ4S3VQbVRTOStsNE5NLzVpcXpyKy8wNWdHbU9BckpxTS9u?=
 =?utf-8?B?MDhUNThWOUVURWlORG5aYVNwa3VzaDVrU3pqTW4wMFVLZm5hV01EL05UaGpq?=
 =?utf-8?B?RFZ5QktnZzNlaGM1Y2pqQjNJRElwQWc1NDJPaS9vMnJuSC8vcUpsY0V2WkI3?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed2ef8-095d-4583-011a-08dc2f410cb7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:46:01.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVP781OResyFwhNImdm2b6fFM0j+lv1KdjQZ5aoOQ0qi6YwXEHekDgYSYVY2whHnE7Fy2WVC5dxXy40PsQRO+QPzXbGb1iaQ+E2Bu4oxX04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com



On 2/16/2024 1:42 PM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 

Much cleaner result in the loop bodies!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  56 ++-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  54 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 389 ++++++++----------
>  4 files changed, 264 insertions(+), 245 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 9b701615c7c6..5acb26644be7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -686,6 +686,54 @@ struct i40e_pf {
>  	struct list_head ddp_old_prof;
>  };
>  
> +/**
> + * __i40e_pf_next_vsi - get next valid VSI
> + * @pf: pointer to the PF struct
> + * @idx: pointer to start position number
> + *
> + * Find and return next non-NULL VSI pointer in pf->vsi array and
> + * updates idx position. Returns NULL if no VSI is found.
> + **/
> +static __always_inline struct i40e_vsi *
> +__i40e_pf_next_vsi(struct i40e_pf *pf, int *idx)
> +{
> +	while (*idx < pf->num_alloc_vsi) {
> +		if (pf->vsi[*idx])
> +			return pf->vsi[*idx];
> +		(*idx)++;
> +	}
> +	return NULL;
> +}
> +
> +#define i40e_pf_for_each_vsi(_pf, _i, _vsi)			\
> +	for (_i = 0, _vsi = __i40e_pf_next_vsi(_pf, &_i);	\
> +	     _vsi;						\
> +	     _i++, _vsi = __i40e_pf_next_vsi(_pf, &_i))
> +
> +/**
> + * __i40e_pf_next_veb - get next valid VEB
> + * @pf: pointer to the PF struct
> + * @idx: pointer to start position number
> + *
> + * Find and return next non-NULL VEB pointer in pf->veb array and
> + * updates idx position. Returns NULL if no VEB is found.
> + **/
> +static __always_inline struct i40e_veb *
> +__i40e_pf_next_veb(struct i40e_pf *pf, int *idx)
> +{
> +	while (*idx < I40E_MAX_VEB) {
> +		if (pf->veb[*idx])
> +			return pf->veb[*idx];
> +		(*idx)++;
> +	}
> +	return NULL;
> +}
> +
> +#define i40e_pf_for_each_veb(_pf, _i, _veb)			\
> +	for (_i = 0, _veb = __i40e_pf_next_veb(_pf, &_i);	\
> +	     _veb;						\
> +	     _i++, _veb = __i40e_pf_next_veb(_pf, &_i))
> +
>  /**
>   * i40e_mac_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
>   * @macaddr: the MAC Address as the base key
> @@ -1120,14 +1168,12 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id);
>  static inline struct i40e_vsi *
>  i40e_find_vsi_by_type(struct i40e_pf *pf, u16 type)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		struct i40e_vsi *vsi = pf->vsi[i];
> -
> -		if (vsi && vsi->type == type)
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->type == type)
>  			return vsi;
> -	}
>  
>  	return NULL;
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> index b96a92187ab3..8aa43aefe84c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> @@ -947,16 +947,16 @@ static int i40e_dcbnl_vsi_del_app(struct i40e_vsi *vsi,
>  static void i40e_dcbnl_del_app(struct i40e_pf *pf,
>  			       struct i40e_dcb_app_priority_table *app)
>  {
> +	struct i40e_vsi *vsi;
>  	int v, err;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v] && pf->vsi[v]->netdev) {
> -			err = i40e_dcbnl_vsi_del_app(pf->vsi[v], app);
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		if (vsi->netdev) {
> +			err = i40e_dcbnl_vsi_del_app(vsi, app);
>  			dev_dbg(&pf->pdev->dev, "Deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
> -				pf->vsi[v]->seid, err, app->selector,
> +				vsi->seid, err, app->selector,
>  				app->protocolid, app->priority);
>  		}
> -	}
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index ef70ddbe9c2f..b236b0f93202 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -24,14 +24,18 @@ enum ring_type {
>   **/
>  static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	if (seid < 0)
> +	if (seid < 0) {
>  		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
> -	else
> -		for (i = 0; i < pf->num_alloc_vsi; i++)
> -			if (pf->vsi[i] && (pf->vsi[i]->seid == seid))
> -				return pf->vsi[i];
> +
> +		return NULL;
> +	}
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->seid == seid)
> +			return vsi;
>  
>  	return NULL;
>  }
> @@ -43,11 +47,13 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
>   **/
>  static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
>  {
> +	struct i40e_veb *veb;
>  	int i;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++)
> -		if (pf->veb[i] && pf->veb[i]->seid == seid)
> -			return pf->veb[i];
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == seid)
> +			return veb;
> +
>  	return NULL;
>  }
>  
> @@ -653,12 +659,11 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
>   **/
>  static void i40e_dbg_dump_vsi_no_seid(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i])
> -			dev_info(&pf->pdev->dev, "dump vsi[%d]: %d\n",
> -				 i, pf->vsi[i]->seid);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		dev_info(&pf->pdev->dev, "dump vsi[%d]: %d\n", i, vsi->seid);
>  }
>  
>  /**
> @@ -718,11 +723,8 @@ static void i40e_dbg_dump_veb_all(struct i40e_pf *pf)
>  	struct i40e_veb *veb;
>  	int i;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		veb = pf->veb[i];
> -		if (veb)
> -			i40e_dbg_dump_veb_seid(pf, veb->seid);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		i40e_dbg_dump_veb_seid(pf, veb->seid);
>  }
>  
>  /**
> @@ -873,9 +875,10 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			goto command_write_done;
>  		}
>  
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i] && pf->veb[i]->seid == uplink_seid)
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == uplink_seid)
>  				break;
> +
>  		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
>  		    uplink_seid != pf->mac_seid) {
>  			dev_info(&pf->pdev->dev,
> @@ -892,7 +895,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			dev_info(&pf->pdev->dev, "add relay failed\n");
>  
>  	} else if (strncmp(cmd_buf, "del relay", 9) == 0) {
> +		struct i40e_veb *veb;
>  		int i;
> +
>  		cnt = sscanf(&cmd_buf[9], "%i", &veb_seid);
>  		if (cnt != 1) {
>  			dev_info(&pf->pdev->dev,
> @@ -906,9 +911,10 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  		}
>  
>  		/* find the veb */
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i] && pf->veb[i]->seid == veb_seid)
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == veb_seid)
>  				break;
> +
>  		if (i >= I40E_MAX_VEB) {
>  			dev_info(&pf->pdev->dev,
>  				 "del relay: relay %d not found\n", veb_seid);
> @@ -916,7 +922,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  		}
>  
>  		dev_info(&pf->pdev->dev, "deleting relay %d\n", veb_seid);
> -		i40e_veb_release(pf->veb[i]);
> +		i40e_veb_release(veb);
>  	} else if (strncmp(cmd_buf, "add pvid", 8) == 0) {
>  		unsigned int v;
>  		int ret;
> @@ -1251,8 +1257,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			if (cnt == 0) {
>  				int i;
>  
> -				for (i = 0; i < pf->num_alloc_vsi; i++)
> -					i40e_vsi_reset_stats(pf->vsi[i]);
> +				i40e_pf_for_each_vsi(pf, i, vsi)
> +					i40e_vsi_reset_stats(vsi);
>  				dev_info(&pf->pdev->dev, "vsi clear stats called for all vsi's\n");
>  			} else if (cnt == 1) {
>  				vsi = i40e_dbg_find_vsi(pf, vsi_seid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6e59a9509868..43e1b4f7f9dc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -310,11 +310,12 @@ static int i40e_put_lump(struct i40e_lump_tracking *pile, u16 index, u16 id)
>   **/
>  struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && (pf->vsi[i]->id == id))
> -			return pf->vsi[i];
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->id == id)
> +			return vsi;
>  
>  	return NULL;
>  }
> @@ -552,24 +553,19 @@ void i40e_vsi_reset_stats(struct i40e_vsi *vsi)
>   **/
>  void i40e_pf_reset_stats(struct i40e_pf *pf)
>  {
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	memset(&pf->stats, 0, sizeof(pf->stats));
>  	memset(&pf->stats_offsets, 0, sizeof(pf->stats_offsets));
>  	pf->stat_offsets_loaded = false;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (pf->veb[i]) {
> -			memset(&pf->veb[i]->stats, 0,
> -			       sizeof(pf->veb[i]->stats));
> -			memset(&pf->veb[i]->stats_offsets, 0,
> -			       sizeof(pf->veb[i]->stats_offsets));
> -			memset(&pf->veb[i]->tc_stats, 0,
> -			       sizeof(pf->veb[i]->tc_stats));
> -			memset(&pf->veb[i]->tc_stats_offsets, 0,
> -			       sizeof(pf->veb[i]->tc_stats_offsets));
> -			pf->veb[i]->stat_offsets_loaded = false;
> -		}
> +	i40e_pf_for_each_veb(pf, i, veb) {
> +		memset(&veb->stats, 0, sizeof(veb->stats));
> +		memset(&veb->stats_offsets, 0, sizeof(veb->stats_offsets));
> +		memset(&veb->tc_stats, 0, sizeof(veb->tc_stats));
> +		memset(&veb->tc_stats_offsets, 0, sizeof(veb->tc_stats_offsets));
> +		veb->stat_offsets_loaded = false;
>  	}
>  	pf->hw_csum_rx_error = 0;
>  }
> @@ -2879,6 +2875,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>   **/
>  static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
>  	if (!pf)
> @@ -2890,11 +2887,10 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>  		return;
>  	}
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v] &&
> -		    (pf->vsi[v]->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
> -		    !test_bit(__I40E_VSI_RELEASING, pf->vsi[v]->state)) {
> -			int ret = i40e_sync_vsi_filters(pf->vsi[v]);
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		if ((vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
> +		    !test_bit(__I40E_VSI_RELEASING, vsi->state)) {
> +			int ret = i40e_sync_vsi_filters(vsi);
>  
>  			if (ret) {
>  				/* come back and try again later */
> @@ -5166,6 +5162,7 @@ static void i40e_reset_interrupt_capability(struct i40e_pf *pf)
>   **/
>  static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
>  	if (test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state))
> @@ -5175,9 +5172,10 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
>  		      I40E_IWARP_IRQ_PILE_ID);
>  
>  	i40e_put_lump(pf->irq_pile, 0, I40E_PILE_VALID_BIT-1);
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i])
> -			i40e_vsi_free_q_vectors(pf->vsi[i]);
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		i40e_vsi_free_q_vectors(vsi);
> +
>  	i40e_reset_interrupt_capability(pf);
>  }
>  
> @@ -5274,12 +5272,11 @@ static void i40e_unquiesce_vsi(struct i40e_vsi *vsi)
>   **/
>  static void i40e_pf_quiesce_all_vsi(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v])
> -			i40e_quiesce_vsi(pf->vsi[v]);
> -	}
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		i40e_quiesce_vsi(vsi);
>  }
>  
>  /**
> @@ -5288,12 +5285,11 @@ static void i40e_pf_quiesce_all_vsi(struct i40e_pf *pf)
>   **/
>  static void i40e_pf_unquiesce_all_vsi(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v])
> -			i40e_unquiesce_vsi(pf->vsi[v]);
> -	}
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		i40e_unquiesce_vsi(vsi);
>  }
>  
>  /**
> @@ -5354,14 +5350,13 @@ int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
>   **/
>  static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v, ret = 0;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v]) {
> -			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
> -			if (ret)
> -				break;
> -		}
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		ret = i40e_vsi_wait_queues_disabled(vsi);
> +		if (ret)
> +			break;
>  	}
>  
>  	return ret;
> @@ -6778,32 +6773,29 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
>   **/
>  static void i40e_dcb_reconfigure(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	u8 tc_map = 0;
>  	int ret;
> -	u8 v;
> +	int v;
>  
>  	/* Enable the TCs available on PF to all VEBs */
>  	tc_map = i40e_pf_get_tc_map(pf);
>  	if (tc_map == I40E_DEFAULT_TRAFFIC_CLASS)
>  		return;
>  
> -	for (v = 0; v < I40E_MAX_VEB; v++) {
> -		if (!pf->veb[v])
> -			continue;
> -		ret = i40e_veb_config_tc(pf->veb[v], tc_map);
> +	i40e_pf_for_each_veb(pf, v, veb) {
> +		ret = i40e_veb_config_tc(veb, tc_map);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
>  				 "Failed configuring TC for VEB seid=%d\n",
> -				 pf->veb[v]->seid);
> +				 veb->seid);
>  			/* Will try to configure as many components */
>  		}
>  	}
>  
>  	/* Update each VSI */
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (!pf->vsi[v])
> -			continue;
> -
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
>  		/* - Enable all TCs for the LAN VSI
>  		 * - For all others keep them at TC0 for now
>  		 */
> @@ -6812,17 +6804,17 @@ static void i40e_dcb_reconfigure(struct i40e_pf *pf)
>  		else
>  			tc_map = I40E_DEFAULT_TRAFFIC_CLASS;
>  
> -		ret = i40e_vsi_config_tc(pf->vsi[v], tc_map);
> +		ret = i40e_vsi_config_tc(vsi, tc_map);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
>  				 "Failed configuring TC for VSI seid=%d\n",
> -				 pf->vsi[v]->seid);
> +				 vsi->seid);
>  			/* Will try to configure as many components */
>  		} else {
>  			/* Re-configure VSI vectors based on updated TC map */
> -			i40e_vsi_map_rings_to_vectors(pf->vsi[v]);
> -			if (pf->vsi[v]->netdev)
> -				i40e_dcbnl_set_all(pf->vsi[v]);
> +			i40e_vsi_map_rings_to_vectors(vsi);
> +			if (vsi->netdev)
> +				i40e_dcbnl_set_all(vsi);
>  		}
>  	}
>  }
> @@ -9257,7 +9249,9 @@ int i40e_close(struct net_device *netdev)
>   **/
>  void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
>  {
> +	struct i40e_vsi *vsi;
>  	u32 val;
> +	int i;
>  
>  	/* do the biggest reset indicated */
>  	if (reset_flags & BIT_ULL(__I40E_GLOBAL_RESET_REQUESTED)) {
> @@ -9313,29 +9307,20 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
>  			 "FW LLDP is enabled\n");
>  
>  	} else if (reset_flags & BIT_ULL(__I40E_REINIT_REQUESTED)) {
> -		int v;
> -
>  		/* Find the VSI(s) that requested a re-init */
> -		dev_info(&pf->pdev->dev,
> -			 "VSI reinit requested\n");
> -		for (v = 0; v < pf->num_alloc_vsi; v++) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
> +		dev_info(&pf->pdev->dev, "VSI reinit requested\n");
>  
> -			if (vsi != NULL &&
> -			    test_and_clear_bit(__I40E_VSI_REINIT_REQUESTED,
> +		i40e_pf_for_each_vsi(pf, i, vsi) {
> +			if (test_and_clear_bit(__I40E_VSI_REINIT_REQUESTED,
>  					       vsi->state))
> -				i40e_vsi_reinit_locked(pf->vsi[v]);
> +				i40e_vsi_reinit_locked(vsi);
>  		}
>  	} else if (reset_flags & BIT_ULL(__I40E_DOWN_REQUESTED)) {
> -		int v;
> -
>  		/* Find the VSI(s) that needs to be brought down */
>  		dev_info(&pf->pdev->dev, "VSI down requested\n");
> -		for (v = 0; v < pf->num_alloc_vsi; v++) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
>  
> -			if (vsi != NULL &&
> -			    test_and_clear_bit(__I40E_VSI_DOWN_REQUESTED,
> +		i40e_pf_for_each_vsi(pf, i, vsi) {
> +			if (test_and_clear_bit(__I40E_VSI_DOWN_REQUESTED,
>  					       vsi->state)) {
>  				set_bit(__I40E_VSI_DOWN, vsi->state);
>  				i40e_down(vsi);
> @@ -9888,6 +9873,8 @@ static void i40e_vsi_link_event(struct i40e_vsi *vsi, bool link_up)
>   **/
>  static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  {
> +	struct i40e_veb *veb_it;
> +	struct i40e_vsi *vsi;
>  	struct i40e_pf *pf;
>  	int i;
>  
> @@ -9896,14 +9883,14 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  	pf = veb->pf;
>  
>  	/* depth first... */
> -	for (i = 0; i < I40E_MAX_VEB; i++)
> -		if (pf->veb[i] && (pf->veb[i]->uplink_seid == veb->seid))
> -			i40e_veb_link_event(pf->veb[i], link_up);
> +	i40e_pf_for_each_veb(pf, i, veb_it)
> +		if (veb_it->uplink_seid == veb->seid)
> +			i40e_veb_link_event(veb_it, link_up);
>  
>  	/* ... now the local VSIs */
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && (pf->vsi[i]->uplink_seid == veb->seid))
> -			i40e_vsi_link_event(pf->vsi[i], link_up);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == veb->seid)
> +			i40e_vsi_link_event(vsi, link_up);
>  }
>  
>  /**
> @@ -9995,6 +9982,8 @@ static void i40e_link_event(struct i40e_pf *pf)
>   **/
>  static void i40e_watchdog_subtask(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	/* if interface is down do nothing */
> @@ -10015,15 +10004,14 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
>  	/* Update the stats for active netdevs so the network stack
>  	 * can look at updated numbers whenever it cares to
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && pf->vsi[i]->netdev)
> -			i40e_update_stats(pf->vsi[i]);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->netdev)
> +			i40e_update_stats(vsi);
>  
>  	if (test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags)) {
>  		/* Update the stats for the active switching components */
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i])
> -				i40e_update_veb_stats(pf->veb[i]);
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			i40e_update_veb_stats(veb);
>  	}
>  
>  	i40e_ptp_rx_hang(pf);
> @@ -10380,18 +10368,18 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  {
>  	struct i40e_vsi *ctl_vsi = NULL;
>  	struct i40e_pf *pf = veb->pf;
> -	int v, veb_idx;
> -	int ret;
> +	struct i40e_veb *veb_it;
> +	struct i40e_vsi *vsi;
> +	int v, ret;
>  
>  	/* build VSI that owns this VEB, temporarily attached to base VEB */
> -	for (v = 0; v < pf->num_alloc_vsi && !ctl_vsi; v++) {
> -		if (pf->vsi[v] &&
> -		    pf->vsi[v]->veb_idx == veb->idx &&
> -		    pf->vsi[v]->flags & I40E_VSI_FLAG_VEB_OWNER) {
> -			ctl_vsi = pf->vsi[v];
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		if (vsi->veb_idx == veb->idx &&
> +		    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
> +			ctl_vsi = vsi;
>  			break;
>  		}
> -	}
> +
>  	if (!ctl_vsi) {
>  		dev_info(&pf->pdev->dev,
>  			 "missing owner VSI for veb_idx %d\n", veb->idx);
> @@ -10421,13 +10409,11 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  	i40e_config_bridge_mode(veb);
>  
>  	/* create the remaining VSIs attached to this VEB */
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (!pf->vsi[v] || pf->vsi[v] == ctl_vsi)
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		if (vsi == ctl_vsi)
>  			continue;
>  
> -		if (pf->vsi[v]->veb_idx == veb->idx) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
> -
> +		if (vsi->veb_idx == veb->idx) {
>  			vsi->uplink_seid = veb->seid;
>  			ret = i40e_add_vsi(vsi);
>  			if (ret) {
> @@ -10441,10 +10427,10 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  	}
>  
>  	/* create any VEBs attached to this VEB - RECURSION */
> -	for (veb_idx = 0; veb_idx < I40E_MAX_VEB; veb_idx++) {
> -		if (pf->veb[veb_idx] && pf->veb[veb_idx]->veb_idx == veb->idx) {
> -			pf->veb[veb_idx]->uplink_seid = veb->seid;
> -			ret = i40e_reconstitute_veb(pf->veb[veb_idx]);
> +	i40e_pf_for_each_veb(pf, v, veb_it) {
> +		if (veb_it->veb_idx == veb->idx) {
> +			veb_it->uplink_seid = veb->seid;
> +			ret = i40e_reconstitute_veb(veb_it);
>  			if (ret)
>  				break;
>  		}
> @@ -10718,6 +10704,7 @@ static void i40e_clean_xps_state(struct i40e_vsi *vsi)
>  static void i40e_prep_for_reset(struct i40e_pf *pf)
>  {
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_vsi *vsi;
>  	int ret = 0;
>  	u32 v;
>  
> @@ -10732,11 +10719,9 @@ static void i40e_prep_for_reset(struct i40e_pf *pf)
>  	/* quiesce the VSIs and their queues that are not already DOWN */
>  	i40e_pf_quiesce_all_vsi(pf);
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v]) {
> -			i40e_clean_xps_state(pf->vsi[v]);
> -			pf->vsi[v]->seid = 0;
> -		}
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		i40e_clean_xps_state(vsi);
> +		vsi->seid = 0;
>  	}
>  
>  	i40e_shutdown_adminq(&pf->hw);
> @@ -10850,6 +10835,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  	const bool is_recovery_mode_reported = i40e_check_recovery_mode(pf);
>  	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_veb *veb;
>  	int ret;
>  	u32 val;
>  	int v;
> @@ -10992,14 +10978,10 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  	if (vsi->uplink_seid != pf->mac_seid) {
>  		dev_dbg(&pf->pdev->dev, "attempting to rebuild switch\n");
>  		/* find the one VEB connected to the MAC, and find orphans */
> -		for (v = 0; v < I40E_MAX_VEB; v++) {
> -			if (!pf->veb[v])
> -				continue;
> -
> -			if (pf->veb[v]->uplink_seid == pf->mac_seid ||
> -			    pf->veb[v]->uplink_seid == 0) {
> -				ret = i40e_reconstitute_veb(pf->veb[v]);
> -
> +		i40e_pf_for_each_veb(pf, v, veb) {
> +			if (veb->uplink_seid == pf->mac_seid ||
> +			    veb->uplink_seid == 0) {
> +				ret = i40e_reconstitute_veb(veb);
>  				if (!ret)
>  					continue;
>  
> @@ -11009,13 +10991,13 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  				 * If orphan failed, we'll report the error
>  				 * but try to keep going.
>  				 */
> -				if (pf->veb[v]->uplink_seid == pf->mac_seid) {
> +				if (veb->uplink_seid == pf->mac_seid) {
>  					dev_info(&pf->pdev->dev,
>  						 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
>  						 ret);
>  					vsi->uplink_seid = pf->mac_seid;
>  					break;
> -				} else if (pf->veb[v]->uplink_seid == 0) {
> +				} else if (veb->uplink_seid == 0) {
>  					dev_info(&pf->pdev->dev,
>  						 "rebuild of orphan VEB failed: %d\n",
>  						 ret);
> @@ -12098,6 +12080,7 @@ static int i40e_init_interrupt_scheme(struct i40e_pf *pf)
>   */
>  static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int err, i;
>  
>  	/* We cleared the MSI and MSI-X flags when disabling the old interrupt
> @@ -12114,13 +12097,12 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
>  	/* Now that we've re-acquired IRQs, we need to remap the vectors and
>  	 * rings together again.
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i]) {
> -			err = i40e_vsi_alloc_q_vectors(pf->vsi[i]);
> -			if (err)
> -				goto err_unwind;
> -			i40e_vsi_map_rings_to_vectors(pf->vsi[i]);
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		err = i40e_vsi_alloc_q_vectors(vsi);
> +		if (err)
> +			goto err_unwind;
> +
> +		i40e_vsi_map_rings_to_vectors(vsi);
>  	}
>  
>  	err = i40e_setup_misc_vector(pf);
> @@ -13122,8 +13104,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  	struct i40e_netdev_priv *np = netdev_priv(dev);
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
> -	struct i40e_veb *veb = NULL;
>  	struct nlattr *attr, *br_spec;
> +	struct i40e_veb *veb;
>  	int i, rem;
>  
>  	/* Only for PF VSI for now */
> @@ -13131,10 +13113,11 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for PF VSI */
> -	for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -			veb = pf->veb[i];
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == vsi->uplink_seid)
> +			break;
> +	if (i == I40E_MAX_VEB)
> +		veb = NULL; /* No VEB found */
>  
>  	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>  	if (!br_spec)
> @@ -13207,12 +13190,10 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for the PF VSI */
> -	for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -			veb = pf->veb[i];
> -	}
> -
> -	if (!veb)
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == vsi->uplink_seid)
> +			break;
> +	if (i == I40E_MAX_VEB)
>  		return 0;
>  
>  	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
> @@ -14143,9 +14124,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
>   **/
>  int i40e_vsi_release(struct i40e_vsi *vsi)
>  {
> +	struct i40e_veb *veb, *veb_it;
>  	struct i40e_mac_filter *f;
>  	struct hlist_node *h;
> -	struct i40e_veb *veb = NULL;
>  	struct i40e_pf *pf;
>  	u16 uplink_seid;
>  	int i, n, bkt;
> @@ -14215,20 +14196,18 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
>  	 * the orphan VEBs yet.  We'll wait for an explicit remove request
>  	 * from up the network stack.
>  	 */
> -	for (n = 0, i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i] &&
> -		    pf->vsi[i]->uplink_seid == uplink_seid &&
> -		    (pf->vsi[i]->flags & I40E_VSI_FLAG_VEB_OWNER) == 0) {
> +	n = 0;
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == uplink_seid &&
> +		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
>  			n++;      /* count the VSIs */
> -		}
> -	}
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -		if (pf->veb[i]->uplink_seid == uplink_seid)
> +
> +	veb = NULL;
> +	i40e_pf_for_each_veb(pf, i, veb_it) {
> +		if (veb_it->uplink_seid == uplink_seid)
>  			n++;     /* count the VEBs */
> -		if (pf->veb[i]->seid == uplink_seid)
> -			veb = pf->veb[i];
> +		if (veb_it->seid == uplink_seid)
> +			veb = veb_it;
>  	}
>  	if (n == 0 && veb && veb->uplink_seid != 0)
>  		i40e_veb_release(veb);
> @@ -14405,22 +14384,18 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	 *
>  	 * Find which uplink_seid we were given and create a new VEB if needed
>  	 */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == uplink_seid) {
> -			veb = pf->veb[i];
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == uplink_seid)
>  			break;
> -		}
> -	}
> +	if (i == I40E_MAX_VEB)
> +		veb = NULL;
>  
>  	if (!veb && uplink_seid != pf->mac_seid) {
> -
> -		for (i = 0; i < pf->num_alloc_vsi; i++) {
> -			if (pf->vsi[i] && pf->vsi[i]->seid == uplink_seid) {
> -				vsi = pf->vsi[i];
> +		i40e_pf_for_each_vsi(pf, i, vsi)
> +			if (vsi->seid == uplink_seid)
>  				break;
> -			}
> -		}
> -		if (!vsi) {
> +
> +		if (i == pf->num_alloc_vsi) {
>  			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
>  				 uplink_seid);
>  			return NULL;
> @@ -14448,11 +14423,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  			}
>  			i40e_config_bridge_mode(veb);
>  		}
> -		for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -			if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -				veb = pf->veb[i];
> -		}
> -		if (!veb) {
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == vsi->uplink_seid)
> +				break;
> +		if (i == I40E_MAX_VEB) {
>  			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
>  			return NULL;
>  		}
> @@ -14681,29 +14655,24 @@ static void i40e_switch_branch_release(struct i40e_veb *branch)
>  	struct i40e_pf *pf = branch->pf;
>  	u16 branch_seid = branch->seid;
>  	u16 veb_idx = branch->idx;
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	/* release any VEBs on this VEB - RECURSION */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -		if (pf->veb[i]->uplink_seid == branch->seid)
> -			i40e_switch_branch_release(pf->veb[i]);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->uplink_seid == branch->seid)
> +			i40e_switch_branch_release(veb);
>  
>  	/* Release the VSIs on this VEB, but not the owner VSI.
>  	 *
>  	 * NOTE: Removing the last VSI on a VEB has the SIDE EFFECT of removing
>  	 *       the VEB itself, so don't use (*branch) after this loop.
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (!pf->vsi[i])
> -			continue;
> -		if (pf->vsi[i]->uplink_seid == branch_seid &&
> -		   (pf->vsi[i]->flags & I40E_VSI_FLAG_VEB_OWNER) == 0) {
> -			i40e_vsi_release(pf->vsi[i]);
> -		}
> -	}
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == branch_seid &&
> +		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
> +			i40e_vsi_release(vsi);
>  
>  	/* There's one corner case where the VEB might not have been
>  	 * removed, so double check it here and remove it if needed.
> @@ -14741,19 +14710,19 @@ static void i40e_veb_clear(struct i40e_veb *veb)
>   **/
>  void i40e_veb_release(struct i40e_veb *veb)
>  {
> -	struct i40e_vsi *vsi = NULL;
> +	struct i40e_vsi *vsi, *vsi_it;
>  	struct i40e_pf *pf;
>  	int i, n = 0;
>  
>  	pf = veb->pf;
>  
>  	/* find the remaining VSI and check for extras */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i] && pf->vsi[i]->uplink_seid == veb->seid) {
> +	i40e_pf_for_each_vsi(pf, i, vsi_it)
> +		if (vsi_it->uplink_seid == veb->seid) {
> +			vsi = vsi_it;
>  			n++;
> -			vsi = pf->vsi[i];
>  		}
> -	}
> +
>  	if (n != 1) {
>  		dev_info(&pf->pdev->dev,
>  			 "can't remove VEB %d with %d VSIs left\n",
> @@ -14851,6 +14820,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  				u8 enabled_tc)
>  {
>  	struct i40e_veb *veb, *uplink_veb = NULL;
> +	struct i40e_vsi *vsi;
>  	int vsi_idx, veb_idx;
>  	int ret;
>  
> @@ -14864,9 +14834,10 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	/* make sure there is such a vsi and uplink */
> -	for (vsi_idx = 0; vsi_idx < pf->num_alloc_vsi; vsi_idx++)
> -		if (pf->vsi[vsi_idx] && pf->vsi[vsi_idx]->seid == vsi_seid)
> +	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> +		if (vsi->seid == vsi_seid)
>  			break;
> +
>  	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
>  		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
>  			 vsi_seid);
> @@ -14874,10 +14845,9 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	if (uplink_seid && uplink_seid != pf->mac_seid) {
> -		for (veb_idx = 0; veb_idx < I40E_MAX_VEB; veb_idx++) {
> -			if (pf->veb[veb_idx] &&
> -			    pf->veb[veb_idx]->seid == uplink_seid) {
> -				uplink_veb = pf->veb[veb_idx];
> +		i40e_pf_for_each_veb(pf, veb_idx, veb) {
> +			if (veb->seid == uplink_seid) {
> +				uplink_veb = veb;
>  				break;
>  			}
>  		}
> @@ -14899,7 +14869,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
>  
>  	/* create the VEB in the switch */
> -	ret = i40e_add_veb(veb, pf->vsi[vsi_idx]);
> +	ret = i40e_add_veb(veb, vsi);
>  	if (ret)
>  		goto err_veb;
>  	if (vsi_idx == pf->lan_vsi)
> @@ -14930,6 +14900,7 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  	u16 uplink_seid = le16_to_cpu(ele->uplink_seid);
>  	u8 element_type = ele->element_type;
>  	u16 seid = le16_to_cpu(ele->seid);
> +	struct i40e_veb *veb;
>  
>  	if (printconfig)
>  		dev_info(&pf->pdev->dev,
> @@ -14948,12 +14919,12 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  			int v;
>  
>  			/* find existing or else empty VEB */
> -			for (v = 0; v < I40E_MAX_VEB; v++) {
> -				if (pf->veb[v] && (pf->veb[v]->seid == seid)) {
> +			i40e_pf_for_each_veb(pf, v, veb)
> +				if (veb->seid == seid) {
>  					pf->lan_veb = v;
>  					break;
>  				}
> -			}
> +
>  			if (pf->lan_veb >= I40E_MAX_VEB) {
>  				v = i40e_veb_mem_alloc(pf);
>  				if (v < 0)
> @@ -16238,6 +16209,8 @@ static void i40e_remove(struct pci_dev *pdev)
>  {
>  	struct i40e_pf *pf = pci_get_drvdata(pdev);
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int ret_code;
>  	int i;
>  
> @@ -16295,24 +16268,19 @@ static void i40e_remove(struct pci_dev *pdev)
>  	/* If there is a switch structure or any orphans, remove them.
>  	 * This will leave only the PF's VSI remaining.
>  	 */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -
> -		if (pf->veb[i]->uplink_seid == pf->mac_seid ||
> -		    pf->veb[i]->uplink_seid == 0)
> -			i40e_switch_branch_release(pf->veb[i]);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->uplink_seid == pf->mac_seid ||
> +		    veb->uplink_seid == 0)
> +			i40e_switch_branch_release(veb);
>  
>  	/* Now we can shutdown the PF's VSIs, just before we kill
>  	 * adminq and hmc.
>  	 */
> -	for (i = pf->num_alloc_vsi; i--;)
> -		if (pf->vsi[i]) {
> -			i40e_vsi_close(pf->vsi[i]);
> -			i40e_vsi_release(pf->vsi[i]);
> -			pf->vsi[i] = NULL;
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		i40e_vsi_close(vsi);
> +		i40e_vsi_release(vsi);
> +		pf->vsi[i] = NULL;
> +	}
>  
>  	i40e_cloud_filter_exit(pf);
>  
> @@ -16349,18 +16317,17 @@ static void i40e_remove(struct pci_dev *pdev)
>  	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
>  	rtnl_lock();
>  	i40e_clear_interrupt_scheme(pf);
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i]) {
> -			if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
> -				i40e_vsi_clear_rings(pf->vsi[i]);
> -			i40e_vsi_clear(pf->vsi[i]);
> -			pf->vsi[i] = NULL;
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
> +			i40e_vsi_clear_rings(vsi);
> +
> +		i40e_vsi_clear(vsi);
> +		pf->vsi[i] = NULL;
>  	}
>  	rtnl_unlock();
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		kfree(pf->veb[i]);
> +	i40e_pf_for_each_veb(pf, i, veb) {
> +		kfree(veb);
>  		pf->veb[i] = NULL;
>  	}
>  

