Return-Path: <netdev+bounces-23237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9076B63E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35EF28194E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9822EF6;
	Tue,  1 Aug 2023 13:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036B111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:50:34 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A05F1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690897833; x=1722433833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2kxOvNcsEvMUsS8ZH/W3ItcGRDxVx5e0xyX41ZbaxU=;
  b=eTxbf7D6qwz9ZZsr6vf9Lmg3xkYm9z6wkovifTq3xEG4EO0oTZ1qxTXU
   7cClF+mp3Pr7AiPVuKOJghbjOE3BARJvkLLRDam2xdgal4R183RBo494X
   nDuFOWw+wO4zGRqmjgPuPKQagaxdGMNIrfcMNmLhcESpq3+JQNtD1b92Q
   5Vx0ICfhlqqZySQs9MCRBPw3qeqxS+cbHxlFGU6K0R6+dQEuZdWueHP/B
   /nUgRxaaD7/5gAA9scGeP7PwWCRVH1MrJEaTro7ZmsixaviDfnztTFGO7
   KzIp7oRROscFhq2kws2XPfvUQ9Jk8cRUrboRLKnUqTnXKs7Lx0ChK8RdJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455676845"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455676845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842732845"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="842732845"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 06:50:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:50:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:50:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goBbQrK94ShayJEDXMQM39qpOgzTDeGtHtC2RL0Aq13gAv/5NquSgnyUbBvhvyJk7VaYTWOPYsanDg8tH5Etyaa9kK4a0t8cHhG4DuCt56Lr9vkHmfEIXXKdjH7sCWQpGDE9LsmdOUARj/tz1PhwTR4mVe8mQyRFRtMVqg6dXYVkjwsWMumQUiZ7iFNI+z4dWqAqbkeit//gATDv/AXVK8OSi3o7pa0Gdp3K1yNh16/oUidgzO1IUTfwe1e2DQo7uGYfeiipTwjeNa7kWVvOc7XLnSsv4JbYBlAdgSGGn+I3ZmdAKjj1RM4Vv9YOhRGhwHZDqLKsyODmTRAwbuuzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1iXyYbHzikgN2TVe2o8Yb7aKlbalJzDg9Wvca9bhyo=;
 b=HW1CQEeSv41l5rDqUwyNZGfnfNVAWPApQgu02Yzd0UZtojcU6HL3NIiTLwQzoi5vMesi3qAbKQtYpIoUQ5QbdbL3lVA4oM7WY+3ae+y0xRQ7my9BdI3XgfOPhpX6IBCVxkTMphIoRFDQy3/UM7OvW6yrfZe+nK88XYZZmZ9JLvRht7RsxJ8tAht03NsFFBio1WMuU2/0HWu+fFdcNWWw4pNIixLikXp2HpiI3Pk9Tsq+QHfqPaoUkYjZn8sPX1ulLTd4wh+i/s3wYzrBvh1dX60jKBjXPKgk/EY7y1KdC7Gnfz+rBi/AMDRzSh0BW1Z4iFUGdFcRCNRO5VW3zzWYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 13:50:31 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:50:30 +0000
Message-ID: <f68aa06c-c0bd-a614-914d-3e94ff8f4ba6@intel.com>
Date: Tue, 1 Aug 2023 15:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next 2/2] ice: make use of DECLARE_FLEX() in
 ice_switch.c
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Kees Cook <keescook@chromium.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-3-przemyslaw.kitszel@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230801111923.118268-3-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d9d72c-4d9a-4af2-0ff0-08db9296452d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xA97U6xzI4kDVKUqpNCZNcZ1PV26aTR8fcLsYQ+BlVis7cOpy2EoWX4gA/UpatjqcxYmzojbno1iDZbHErtRP55JFuSo7opWdsSx7x/wjL61JoJjmlEXziVkGI+Kvz2J6ATOYgB+7xOuMRn3oFDUylk95B7I9u+xiBIgwp4yycNYfm9lyPixavgG1cneahDHZlPCjEd1GOF5O4HjbNngN9uYpkwcOFEIah8OF+nl6YoQLQRK6okkPvFXQsHmoTUr/+sH8gQOQI5H41YrW7pTBg0HYu/3L3KUMmsL5x9goSEdfSjnNWe6JMdbGME4Hk8Hye1h6mRompqluBnCs+/EHPDIyxr/ZODor8ranjWRc/xQSfrhv2NtMSah0G3zF2nJ9vEEJpjzHEnxLKa7nQeacgGx6D/DdDQff1+vjBeH3cZvtvZw4poIlXnJrnWDvBa+VzikPr/+RIURFrt+YfBHieOuEc+acU2yyQMrS6fvYbsNwkj7UfvYsy74SAd/7SsMgj7Ho+08smSpQaVB9JDeDr6MEVcRhPS96R4bSJ+flI0YCKTRiELIANw1xKm00gyaw/yuMlmO13fGozdXoCyykBjxeQMHzOLpgYe2EyXLgkg48mnhi9wkHElEvzi668J8CO4poEtaOFjzbE/3vj/50Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(37006003)(82960400001)(54906003)(6512007)(26005)(6862004)(6506007)(6486002)(36756003)(8676002)(8936002)(6666004)(66476007)(5660300002)(66946007)(66556008)(4326008)(6636002)(2906002)(2616005)(83380400001)(478600001)(41300700001)(31686004)(86362001)(186003)(38100700002)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3hSM01KM3cweXdCVVhsTFEySkZhREZzeTRiTjhTRmg0OW9vTmpEYytUR09l?=
 =?utf-8?B?Y1U0Y1hoS3dNZmVhb01POStxNzBpNDltZmhKMnZFYjlSUnNEdGhtZkNxUzBH?=
 =?utf-8?B?ZVVUdVZCY282L013S0hITWhCd0VVT2ZlRTNTemlvMlgvRlhIelRTb2p3T1Ru?=
 =?utf-8?B?KzhaZ3JKVy9vclBRaUF6dnBPZ0Y2dXZmT2huYjRWRFhoZ1d1MEdVaEhKcmtH?=
 =?utf-8?B?ZjJEOG9GRjB5TWlIS3pPNGxOenFPaEl0ZVUrbnZKSXpVaDc0VDIrRDZwelNp?=
 =?utf-8?B?MUJFQjRTc0FYNnVHdjBIRldIY2VzUWQ1anNPdUhBWjZjbE44eW5YVU5INnZu?=
 =?utf-8?B?YlMzMGpIVDZSMnNTeDgzck8vc1ArVmQyUUNmSk1MaVl0Mm03azl4TDd0K1gz?=
 =?utf-8?B?NDlpZGtGOWxDQm5PY0tLM08yMlZWWTFCbjJBTTBFWlJNR1VTZjFjQ014VGNp?=
 =?utf-8?B?b0dsMWVlNklvZ01lT3BwZFB4MDdOcjgxenFQQ29ZTFRudk9hZ0NnU1dhSVRI?=
 =?utf-8?B?S1ZMZnYzRGF6VTNsRjRjcWF5NUxSYzMxeVM1NGRTb1MwVVRXNmZPM05GWEhw?=
 =?utf-8?B?bmVQNXFJNXZCdUpwSE1tUDlEZFRFWnBYSlp4NFhzMVNSRVlRQ1E4NmpzRVhn?=
 =?utf-8?B?aFNSUG9ZeFp5bzAwbTVxOUpJZm1PSVh0SkMvUk5QbjFVWjhPRnRORHAwTStK?=
 =?utf-8?B?NzVMTlVFOXFyalJ5bnVlZ1VCRXJmbFhjdE5UeUdHQjU2QUQvSk9pc09pUzRG?=
 =?utf-8?B?K1B2TktTcHVMYk5GSktERmdGeFhBR0RDZTgvdGVNZGQvcXEwMUdWQXlLVjI1?=
 =?utf-8?B?M0ViUVl1YTMvbml6QU1SRGRpeTM3VDhYSU85YlllV2E4QU9NeDhYNUUrNlhH?=
 =?utf-8?B?YURkNHN4d200ZEY1N2ZjY0tVcGU4Y1VHdllSZ3ovZjF0WlExcHZiWVRjT2V3?=
 =?utf-8?B?TkVIaUV3VndhVlJJZmZmcWlyNzRXYVAvaHFJM0U4MFhGU2FFdC8rejVCK2VT?=
 =?utf-8?B?bzBnanNONDFSMStaWHRxOHBaNHgrMTdFQk5BRE44aG9uY1ZKQkFGZVlKcGNM?=
 =?utf-8?B?a3VPUHY2R1BnM3pKRWkveTdxbmM5V3FsejExTXE1R281Q0hTMnZqTk5pT2pJ?=
 =?utf-8?B?eEJYOW9HTW5KSXdjNld5SUNjd1NBY0JxV2VUM2JkSzg1NXJ0bjFEVm13Mkk3?=
 =?utf-8?B?WkNLZTR1dzZRem9FQ3hUUlY5a21JZy9pT1F0UTZKaTA0MTVzQzdYWVd5aVdI?=
 =?utf-8?B?cXhzazZNcHE1SCt6dmo0TlROQ1JWeXpweFNZMWhzZ3R5VjFXempLL0l4eVo1?=
 =?utf-8?B?Q1lRd1NTWmREMnl0MWtvM0ZERlJrSkF5VWJ5YnpTMnhWWUdzRit1ZVRzZHFp?=
 =?utf-8?B?TFhZdU5JRVVoT1dEYXNqdytRWndMczBaUmhpTFA0Tm9WRTBxT3RoSFF4ejZO?=
 =?utf-8?B?cksyeGJRdUhWeXpvM2FIS2owSEdPK3BFSUNnV3FIT1lwcWgxT2pobDlxa0hw?=
 =?utf-8?B?MGVaNmJpWll3Vyt2a242N2VUNWJKa3dicWN5QXRDcTJkZHhpWDdQY2ZsL1BG?=
 =?utf-8?B?UVZNWmdsSWdXeHZXL3VzL3Mxa0s2MVRWVEx6eXhWcXFVZjNMaExVQjlCRkFR?=
 =?utf-8?B?N3c2N0hVS3N2eDl1TVJOQ1RyOTJSQjBaT1o5eGxTKzJnS094d3NaMGdXQUFX?=
 =?utf-8?B?YkZ1bmZuM1ZtYmk4aVl4Uk9KR3o2UXNyYWxMd0JMdWozKzZDWEZyclgzZXl0?=
 =?utf-8?B?dS9UanY3b2Vja0dGYUlEYi9Sc2JyL0xKQ1JaYnVVa3BycHNGU1VYMVdERisx?=
 =?utf-8?B?cXNXcElpZ09wU2djTU9tbTJQMG91MlR1Uy9kUTZLdk5oNlo1S3g5Rk1VU25M?=
 =?utf-8?B?aFhRa0dpTlJTbWNTMUhlcDgvRUkyMWhEa2lJaGY0STFQUDdDUFhPQ2xqb1Bo?=
 =?utf-8?B?K0dVR0liZXhWazcrVUtTMWVtOHVtWmFKbWJ4Z2FhK3FMZCs0WFpJV0N6UmVW?=
 =?utf-8?B?OVBQb1BLT1N6TVlLWDNpOGlDR1I4RlZ2am9ZdmtjQzZWRUpQSEROVjdMVjVF?=
 =?utf-8?B?RHN3dmxuZFRRc1U2K05PQnBLOXptUDFadkxRMFZXQXZWT3pvcmhzaXZlVWo1?=
 =?utf-8?B?ZThpTlJzSDFoSVMwVXNzdnNlTUplcVpqREVReWpOdzlUUUlsSkZDeWozSm54?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d9d72c-4d9a-4af2-0ff0-08db9296452d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:50:30.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/lYwFEWuEVkfpl6nzhBNWkVIfOw7uUsp9mGGovcmDDM4bTDXuWCjHL27FURL2uSbyjojQqY73dn98Or7jKSTp/89wE3AKZ2Fam9z2btbPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 1 Aug 2023 13:19:23 +0200

> Use DECLARE_FLEX() macro for 1-elem flex array members of ice_switch.c
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 53 +++++----------------
>  1 file changed, 12 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index a7afb612fe32..41679cb6b548 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -1812,15 +1812,11 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
>  			   enum ice_sw_lkup_type lkup_type,
>  			   enum ice_adminq_opc opc)
>  {
> -	struct ice_aqc_alloc_free_res_elem *sw_buf;
> +	DECLARE_FLEX(struct ice_aqc_alloc_free_res_elem *, sw_buf, elem, 1);
> +	u16 buf_len = struct_size(sw_buf, elem, 1);
>  	struct ice_aqc_res_elem *vsi_ele;
> -	u16 buf_len;
>  	int status;
>  
> -	buf_len = struct_size(sw_buf, elem, 1);
> -	sw_buf = devm_kzalloc(ice_hw_to_dev(hw), buf_len, GFP_KERNEL);
> -	if (!sw_buf)
> -		return -ENOMEM;
>  	sw_buf->num_elems = cpu_to_le16(1);
>  
>  	if (lkup_type == ICE_SW_LKUP_MAC ||
> @@ -1840,8 +1836,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
>  			sw_buf->res_type =
>  				cpu_to_le16(ICE_AQC_RES_TYPE_VSI_LIST_PRUNE);
>  	} else {
> -		status = -EINVAL;
> -		goto ice_aq_alloc_free_vsi_list_exit;
> +		return -EINVAL;
>  	}
>  
>  	if (opc == ice_aqc_opc_free_res)

bloat-o-meter results would be nice to have in the commitmsg.

[...]

Thanks,
Olek

