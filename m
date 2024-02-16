Return-Path: <netdev+bounces-72575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC3858928
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505C51F25EBB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE21139567;
	Fri, 16 Feb 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBLTUbMV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C24133423
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123755; cv=fail; b=V9B1Cw4P0M9KJqo3Jt4ui4MkOMlC9PT2q/4xWJJOzX55O1zDaD63lrS4XZUON98edlpt8T2CdFM9gdOFJtgMDExFCt/E7LfH1owoYty+k4Eb4k9aDlJOld4uPAi3AebNCCeiMp0TJKV1iLpWs0l+Nnj+Ky58tD+w9/I1PU2VW+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123755; c=relaxed/simple;
	bh=/6pDYGFk/LkC3dJ9ehv8sLdURYRJR8FaOpEaJg05hek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pE2ucLR8sYFvDeNzg4g92XK4iQW0fwJGji1HRznKMm03ZISAeNBXCfsOeWtTYimxUTMhaSNoQKGWQqoUDTnZizmMBq3DaquT1ocsBuFSCQg+hVniCYXlXCMiipj44agNRziT6iiDBkCaZihr2arQgRbkFVby8onYe/mfMCP2PDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBLTUbMV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123754; x=1739659754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6pDYGFk/LkC3dJ9ehv8sLdURYRJR8FaOpEaJg05hek=;
  b=DBLTUbMVmhZYQkLf4ECKX0BLXfNNdCRh6DnmDoTL0yT3R4bedF36cg4t
   GJNdr0hP+3jxENTHgZhXTtuF0ym6KoBAYy2Mec93yg7PzQSxJ05GsdiA2
   qy3sIWNNlnsucrrKLfSdKUt524AHTUn8ZRg4sr26CX874N+cvv2rVH8Ld
   QhppQUjArBf/tQnt1bTU7H5lBZeP9z44/MdzjkeiOfofmvToONWEFthlG
   qUQYisCwEfSUgCcmL3Vx+5NOUbkFfF4D2JJYXSwxboQVYBra92OcbU2zb
   jxPXRvpMpD2/NzIIxVoLYCvwKCENs5ElaEUC/th2cC7TVg8udEw4KRN6g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2383694"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2383694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="35003818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:49:11 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:49:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:49:10 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:49:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSOaljj44Cwk3RDSOoYoSg6w9JC7myb3YylMx8k0l2Tb7bTPMi5cCGCKC9qu5B3mgVgwe+bmTHTWdkzw1kFOZd0ag3YZq4Lf/Fkx4UQlt01zbu+gMAsdkxAuxFTriwe09xm9qjzMZr8dmBtO6IqbcPLBh7UVJU23bvxVsKqsiTWxHkJ2W+0WMMhpNDjCTPXjDzNpivUlASDAhFoODK9KZwD8B6e8w74t4WuZvp4TV1itn4vGAXs9vOTujzRb0BcjZzlpyR3Sz3MTwXGuR4Eu+I2scQCp9/MVaejCA5Vn5FFqOWCRD/bRimuMC3J2uPYoIYaDl/AB+hvec647IuVV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnoH+nRZxOIZRsaHN1eoBnvd4hK84MkMdHiOhJVOCGk=;
 b=f6/telewUhoTAosvYJLP1GnVBcd0nHCHQKaSw4SBXo9NOWp+7hk2ePZe6Soc7QSau3eJbwjvYlndfdTG6GC66PT1ox4irAxCEMEHuwKJWoe6duCN2yn33NJ6YuEp/RH0Q8OB6TNOyB5RYnR/NJtzJ+K7BHwRNsbSmPESYNnc39DwwHbtfugnCma/PMSIQUUUq9JBVnrIGjA6ixZzfPgsuqkWECZleuXtvgYHSSHBXEbRitIcifGVpLHKt5SVeqlLMkZ411mhRwrddLaZSWpQSfoCj+H3HVoioBOV17H2jhGPaBlVbbM7QEzmHihpoXMTnJLY3DpgQVSt3zNDZzsovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 22:49:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:49:06 +0000
Message-ID: <5ba4580c-a1d3-474f-b2a8-86be108ffd3b@intel.com>
Date: Fri, 16 Feb 2024 14:49:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] i40e: Fix broken support for floating VEBs
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
 <20240216214243.764561-5-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216214243.764561-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 753138f5-9261-44f4-b31c-08dc2f417b1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19V8ilDXsWu/gVqsJOKMtzwObJSmmeqDTfSU0fqvsj7+KUUoVCZZ+qP73VHrWySMBgz+4iLMX0gAYsy9B2sB+bZ9IiWtLjbSmW2zYOxq2wN6F9PRVaVr1aWkFReWLDJmUP5XoF4/e3kLL4MPVlgfuDuPZq+EYdS2HRK8shPdJ6rRhjzH3ij05NT28sv4QXPDK7/Sra0OeQhRC40JZ3WMTkbryzc7VvQkKMgNo1hv+oYGZb2kP9TYR5e/yKc/XZ8XzYyuTxuoOWOjoCGvKHpAloLBmdPzpNDrBFTSIbnGhWdQYyQiu/QUY5Yp98dEN82PH3/yrHuh6N40EhFvl0e2JDDFa1TD4Dn0ViQequYUr8v0lLlVo+IlQG3hWnXnRnCGMhW5Xew/s9olP4kJL4ZhQuYvUVd3ArR4fjTWV7HXUodmpz5daZW4vLwlhkLifomAVNbeVze02bsaXpc3IibFIp9NZ7hObWwk5EArVIx59cwPyTefjBsnO42RB3Kf/Av9UKb2oNBuzvIZHq8886fpiPw3DgEOtW13c6zAHdPAuASkJ18Xi+MnRKvtjBOoM/Hy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(316002)(41300700001)(54906003)(4326008)(66946007)(2906002)(86362001)(66476007)(8936002)(5660300002)(8676002)(83380400001)(31696002)(36756003)(26005)(66556008)(478600001)(6486002)(53546011)(6506007)(6512007)(2616005)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhwNGFtaEVJRXREVHE0YTRqVkhiMmd3eG1LQStRamhQYkw1V1pJZDJXbWFN?=
 =?utf-8?B?WFhBcFArQ0VtQkJFcWl0eVhDeEQ0SzlKQmtGU085ZTQ1ZHdVb2s2ZTRZdUt3?=
 =?utf-8?B?b2VKRGVTMzJEaUtxVDlJbVVRSmV6dW56b0U5L0lTM2Zrd3FYMjFCYk5PdVVH?=
 =?utf-8?B?dlBLeG51MzlaRWFReTVocHNWajFGT2lxdTdnWGpjdCtIdHprZGJianBpMExM?=
 =?utf-8?B?bC83NlNZUXB4eklaeGFPVkxMMDRCb2N6eXI5Z2M3WldpeEhJdkM1OHkwYTFz?=
 =?utf-8?B?R2V2TXR6U0FJNCtYelhtZ2dHWFRHWDFjOENXZ3ZrNnVnK1JYOGtJekZFZXZL?=
 =?utf-8?B?QlVvWU9WNSszbC9ZZEo0QWU3RG5MeGFBOXZJUHc1NXVvTml2TmFDczNSR0pY?=
 =?utf-8?B?Y0creG11N0N1aStaTkkvS251QjlQa0RRb0dvZ3F5QnFNUXR6U1h1M1VtcVg0?=
 =?utf-8?B?UCtNOWVGa2NUWWhuZFVnZWtudzlDb3B6V2wrYTZPQjNxbVExL242R3NURG5R?=
 =?utf-8?B?TDJ1UmdzWU1jdUs3dDhPT2drSEJialI1OHdvUDc1eXBnUU11OTAyczF6UWx5?=
 =?utf-8?B?WjdLLzhleU5yWnBERytKWWRMWStjRVRublhqS1FqWE1NaWEreVF0TU9VZlgr?=
 =?utf-8?B?cnBoOTRnWXlIanJXWE1qZnNab2NYb2Zyb2xQdWc0OEwyZHZCVWluS3pZTU1X?=
 =?utf-8?B?ZEFvUlA1aVNxVGd5VUZFbTZacXptajhpVEN6NHR4TjN6eFhPZlE1ekMyYUZv?=
 =?utf-8?B?Q3NqQUxVSktmc284bVdzS2JpbnhBY3MvRTEwK2IxSHdqYURpSkhTa0Q3RU5o?=
 =?utf-8?B?NG9vaEZ2ZEpvRG1hdzFuY1BFenhhcTdnWHRINEI2TEpoNkVpWHd0VjVZYzVs?=
 =?utf-8?B?Q3VnN1pnU29KMEdCUVNDTGpjOG5YL3dVTFJyVzZXVzdFS0pybHVvWG1aQjhh?=
 =?utf-8?B?YUhvYXpvNGxhcUhOaWw0MHJpdUdnNjB1dXEvdzFoajZGS21ZR2FPV3phNzEw?=
 =?utf-8?B?TjYxdCtnTTJXTm1PLzJpNEtvTGVVNmFhM29jWU93Wk81d0gzamRmbHRnQWVS?=
 =?utf-8?B?MkMrczNjdVE2TEVaamh4YkZ4cTl0aXd4SVNVVldJYThUblY1UlhCRjhxMUJY?=
 =?utf-8?B?enVuWWdycG9jTTRhZFp5RktFamhVMGhaUkZTcy9CN3B2dVVnR3hjYUsrUFF4?=
 =?utf-8?B?eUo1amR6eTdORm9CTXFSZzFRajJBQVU2cXUyVHlrSGkyQlBOblcrbm9TRTds?=
 =?utf-8?B?RHA0Zjl6ZkdTM2dlRDNGdE9BdzFMOWJmcmJ1Wm1xOE01K0p0V3k2bGZRSGRH?=
 =?utf-8?B?d0NDZTJKSjQ0VldXYWpuRFp0K0ZRZkpkcG0wWHo4RnRESCsrd1RnbERCaGp1?=
 =?utf-8?B?UVYxNkRmelhzcnJtQ3ZkVHFHRlZFNG1DUHZURkJkc3lkYkRUVTAvL0lEWXpu?=
 =?utf-8?B?OFpkb3pMSUZZQXUxeTEvbmhuNG9neWxFM1dpb2Y1VWVWbUhVb2R5S0lkYklL?=
 =?utf-8?B?T2pSYmpJdkpyeCtxWGxBU0pZekdVWVZhejdhUXY5ZzRHaUNTOEhQTHUrR0Fq?=
 =?utf-8?B?MGtwWjdWZmttTFU4QW5ncGJabzN6NFhnNEVRclBVclN3NUxHbW00QVI0S2RS?=
 =?utf-8?B?V0JwcTZKQnltdFY3V2hlcWNCNXZBa0xINzVQTm12L2lPaHFmYTU3YlMrM1U1?=
 =?utf-8?B?OGhYRjlLSGFTVFQ5OXlBdUJQais5UkUvUVFjSEJYbTRMRTlOOFJ3Yi9Jalhw?=
 =?utf-8?B?bER0RVA3RXA3Vyt0UjBYdExmYldieVIxamFvRy93VU53RThqcnl4VlhRWERH?=
 =?utf-8?B?L3JsdzFPZ2xMVnEwdm12ZnMzWndBOHczdU4xM1BOKytzRXMzQjBUeFZGalF1?=
 =?utf-8?B?V2RZY0U0bVhIUTEwM0s2MEczMDY1T0NvaFJNUk1TWS9zeGh6TzBTSHk2bHRH?=
 =?utf-8?B?MGFjT3RCNndqN3YvYkN3ZDZ1dm8vT05jZHgwcmpMRkhyVjNkb2Q1SG5zU09t?=
 =?utf-8?B?THV5MExoWUhWcE9XYmZaa094NGwrK25KNmtYRWRHNmRLcTJobmpMZk8rSUlB?=
 =?utf-8?B?aVhqc1lPZUVjbkJTMXJaVjBFN2trelZBNHpmQmhuYldLai9FenVGMG5MK3A5?=
 =?utf-8?B?ODE1Z1hqaXc1eng4dDBEeVh2SXkzQjEwbHdDTG1xcVYxZFFDK3FoRWxPdTlB?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 753138f5-9261-44f4-b31c-08dc2f417b1e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:49:06.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6XEXVqsWsbxy8VmxYJ7e4fy1XU7xG8/MQXj/AzCLfWu9QPxMgxKKbNJRbO1Mf9T6tGG0FIorsxzPxUtZVP6H2ZSz/qZBfTWol0bjqfLLjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com



On 2/16/2024 1:42 PM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Although the i40e supports so-called floating VEB (VEB without
> an uplink connection to external network), this support is
> broken. This functionality is currently unused (except debugfs)
> but it will be used by subsequent series for switchdev mode
> slow-path. Fix this by following:
> > 1) Handle correctly floating VEB (VEB with uplink_seid == 0)
>    in i40e_reconstitute_veb() and look for owner VSI and
>    create it only for non-floating VEBs and also set bridge
>    mode only for such VEBs as the floating ones are using
>    always VEB mode.
> 2) Handle correctly floating VEB in i40e_veb_release() and
>    disallow its release when there are some VSIs. This is
>    different from regular VEB that have owner VSI that is
>    connected to VEB's uplink after VEB deletion by FW.
> 3) Fix i40e_add_veb() to handle 'vsi' that is NULL for floating
>    VEBs. For floating VEB use 0 for downlink SEID and 'true'
>    for 'default_port' parameters as per datasheet.
> 4) Fix 'add relay' command in i40e_dbg_command_write() to allow
>    to create floating VEB by 'add relay 0 0' or 'add relay'
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

