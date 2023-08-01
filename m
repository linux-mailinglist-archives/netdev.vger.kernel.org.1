Return-Path: <netdev+bounces-23243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F676B676
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405BC1C20F31
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58422EFE;
	Tue,  1 Aug 2023 13:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F5111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:56:42 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4021BF8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690898196; x=1722434196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yqz//kpPoU+IWjJtAG8uIq9wIfq8ejcIewmqRrqlzn0=;
  b=nzoYjYF4W8dAKL/Zwk5fVnpVGA1gRP4o0IqCdmNfM4l9KrPaAqgmYzgO
   GOd/T5hEADiuzXbCTM3tjfqjkMtFumv5Zv3kPJ2kARGuJlMsxmvSdrOq8
   fZJC+Q0meHs3WYoA2xWJoB6T8hkvfl3idNEUffB6r6G+b5BP6HeWulHSf
   PXnGRia/oPxTBZ+EjdW1f4Tl/XV9RJ7oQ8+0jZ7qVv2umjLBFiC4pOZwE
   uqFsnlXLIaGBVCoOFAK58+Rh/aC7faah6iDUj5Bxti4IGV1gQ3pPJXVyx
   idF3zfk2FInijXRqTNe/K6v+FL/N5EnKYS7f5LZCx82cjFskkJORl9RNf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433139418"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="433139418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872084409"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2023 06:56:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:56:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:56:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:56:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVq9c2pBkH07j/70CHgKmuDsfS62PNSKJ+QIHkrT1Pbx3YNgOgwfBRlmNtifhwPpjy/hs7Pee+sbIh94yTwfSzeu+ldNU5VPFDchTo2NeDt8fi/j2CrSswctuBBTR37dzYx1OfkH3gRuPcs+dSq1kWafarnZYqCanh+nSRFT6jKZiH6Sgkbd8mHS6ucDY5CHeMxCUrl5bH4KcmioEh55SH59wcrMPkd50Ygu3dx2HW85wP03lWmGpeJ/vCnIt4bB60jL9QAv8IBCc6UhimCWMJXH46L4stqqqNFb+rfCjVk4d5NYg3Adz9ZbbodLSbEtxjM3Oj5yWgAMkqu++qwHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zb/WmFpJGzVRPt4fAxz9wxKJhh1N8NI0nWv456oegY=;
 b=Dan71OZSg6DsO3LfpUgjF7102lEkMKkEkI32suNCXLZGmzKgAv8+YuwPAEWypY2JYYVXnAlAkVP4/tj7O8lekwSAv4OySjL3S9/VUMkqpawIjylrKOxZEkZxKeg8kEstITakiW3itQ5raaF7w/6RDCTMvSqNFu9XuW+dztwLEKToPCZqORrsf+Uw8CGkZ3VngJ+nRn09s2uxydmWGKizJoSZZz0NnjYpCz90VJ1yByNygZq0k2dcfQnHaJJD8bCOL5tXfbxJUJrkQEWWqJOsqv8HYf5vG8GxLq9OuZOrxkFv4rDyjQlReh25JlQcweoiQWX52mKCpwnQUh0gQyoFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 13:56:15 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:56:15 +0000
Message-ID: <d4d5324c-8d4b-b2e1-78c8-5c3015b5c03d@intel.com>
Date: Tue, 1 Aug 2023 15:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Kees Cook <keescook@chromium.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c93195-6018-4276-edcb-08db92971254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9ys2swBa1eATKU1tjHUI9eS0/eU6feAaIu6T3ktTJFq1WA2tDT8eQqA4/XwlZ/DHN2dBeNi4Lx0Px8/C0DXraw9iztOsDTtFQFRLJIXPJ1VQMhuCSXL9NVBqEvy7Uuvl+eMrtQUbjJQ7yM7N6qooeEzcE+WVYsz5HnCPUMNymzB3nRi0vDz57FLFsdBopEsoUqS0LGI/09jDfPACsSwTiTClIqxqaVQqpiaQPm4NCJ/86FeUPIQtPRMsIGeIGl4keiX8LXyIDWKXukj1wgVsLbqjirGLVkUQAngQKKz6J2iUtaFykcsIs4bAvrhsuL+wkcXSV0ERMXfPmqNwwKEa6QlbFlh6qhQbjNWKdFQgukqZKjj1lEAL6v400fkHlHEwQi0bsgi/rXumQ2IbR4nf3T9eduYatmz2xVVmcAOATfa7zUbpQPh2vK+SckMLCGVh97ESK2U0biPV14zqdC+IA7UvdsghbkLpWGQ87aK1HKoSYqiJXWb5wPJ6GLyWN2X12X6CU+U7/d51IhhRjYaHQwQUseycCVpwhOKsf5umLrzXFfBUD8JaxdA49fM6zIjk3IT2gi7YBLxV9KwTGki1WtsBchZneH/tjRy4n7QAO9gbK25CcggaYAi6lIYgQU0/NRR7rZvzpChTzBgCc1s8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(86362001)(41300700001)(2906002)(8936002)(316002)(8676002)(6862004)(5660300002)(36756003)(31696002)(6512007)(6506007)(26005)(478600001)(6486002)(82960400001)(6666004)(186003)(38100700002)(2616005)(31686004)(54906003)(4326008)(66476007)(66946007)(66556008)(37006003)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek5wTHAzT0N4WHNmdHpDbTdJV0FISFNGb2NXTW9oKzdUSzlVUWQ1dEhlbmVY?=
 =?utf-8?B?c3RBZU5SWEVTQWxyaCt3WWRidVR1YkJmRVp4VWxraGpLUUsyTXZPaHNwdlE0?=
 =?utf-8?B?UTl6VmRRUjlESGZGb3hRU0hFcXh5U2RxYjE2bmhhaTJCem1saWZXbTlYV0lK?=
 =?utf-8?B?UUZKdUN0UUFlWnhMOG5rQjNDL0JTRHQrUjZCd2gxcTlnS1lBd2JPY01IWUhK?=
 =?utf-8?B?R2g0WFc4dlMyVElXajgzZnpDNFA3WlZPN2krakpZNnlvYm5TWUpCSWpnelpI?=
 =?utf-8?B?aUdSUmFnL2FlT1RHU3RVaW4vODh6bFJaSjZqdTRzUDdmYzdURUdJSkViZEEx?=
 =?utf-8?B?cUlGQTJPR2VkMGxlWThyZkJSaWhSeHVqUUV1UUN3SWh3L2JRWW5ZOUlzM3VG?=
 =?utf-8?B?R3dtSERzVzhjTGdIdDN4YVNndXFJamxxd3dXR1NXS1RSdktIRHBXOXZ2M2Vh?=
 =?utf-8?B?QWU5SkJTWHZIOHg0bnk1ZkV0RFNMRzljOFVaK2xJQXVlUHhCUWo5b3h2bmlS?=
 =?utf-8?B?ekpSRXFJejY4c1RtR1hlbTNCZ0tDVUIrWHY1ZDdQSXNoMTI3aFhOT0hOY25s?=
 =?utf-8?B?ODBSR2V3REdzMFE0ZWw1R2tPcFZsY2ZyTHFzMFA1ZjNCeXNvTVFUYWI0NHk1?=
 =?utf-8?B?eXZBSzF0UVMvYWdpY2xDZklHRWNycnE5aDZ5SzNVOGVJTUxIdUdUdXp3M2Ns?=
 =?utf-8?B?OVYrL3dJbEdXWHQ0bkM4ZGtmSzlxeXFUdklJa2lqNnhzYWRubTFsNmRrbm5D?=
 =?utf-8?B?V2NPb1h1Ymw1dHNoWU5TUzcwK0U5OTZJeHdxM2djTVpCZnQxbEo0OGNKa29x?=
 =?utf-8?B?MzZ1ZklLNGNVclUzSzRLYUJSQlV6UmlaS2JZOTQ4TGRFWVM0RDk3TFJCMzBw?=
 =?utf-8?B?MWJHRU1jYnZMaXJGK1VvQTBNTDJtMkpqaGRGZkFiUCs3T0VsaXBva1pJVW9x?=
 =?utf-8?B?ekdoaE1TaWhhUEhXL08rK2poTjFiQ0p5MFBUalAvSmxqUi9VYXluMVpGYlRC?=
 =?utf-8?B?SEZnd0VBR2RBa0orQUdUMjJ0d0V5R0VJTm1ieWJLeWVSZ1ViaXF5aVE5U1RP?=
 =?utf-8?B?Q1VtcTVrbmJzQ09Qc0JmTmlJVDFIbHJLODlrZU9XQ0NtaE5zY0ppMDRsYW9o?=
 =?utf-8?B?YXdKYnZIQ0I4RDhYaHI4aUt6MFlraDErK3FhZlloSGRpSW1oZlQybXIvdThZ?=
 =?utf-8?B?bHk5NEFZSHhPMVozd3RvN3ROQkp3Ky9xelBTMmYxMmVUQVJLMUZhdFRqVkNO?=
 =?utf-8?B?MERYOWRjTW9wZ3NacHJkd3hyZzR0U09xcjRVeFoxSk9Na25XRkpCcHEwRnlL?=
 =?utf-8?B?a2poQ290ZHU3bWozNnZkRlJwS25oWkkyV2hyS0RFMG5QMjVXME94eWdGc2s0?=
 =?utf-8?B?Z0VGQmlnVGdmWm54eGVubDZQTmlEOFpIclNTT3ZhQno3c2ZYMnA0dWxWdTF4?=
 =?utf-8?B?N25ScWJvSjRxQ0gxcUNtWFkzK2l4M0R2WEFMRHBZUXFJcnp6MUdMSnNhUk1t?=
 =?utf-8?B?WWlrVnB0QWE0MEhwaVRtekFqK09mYWxhT2FaSEIxU3U5eUI5QTh1NVg5UTVW?=
 =?utf-8?B?TWVGMUsvZUppNEJjM21nNXdzTFZybGF0MmtCUlJRZnZpRnljNlplbmordUVk?=
 =?utf-8?B?S2RaWmF5cmRVVENubzV2OWFMQVZuTGFsKzJoU2M5LzFIdlVCckFyeXJIcE4y?=
 =?utf-8?B?SzdSWVV5Ym1FRWNWMWZzWTlQNGRsZ0hFd3BaK1dsUDkzeW1tZVg5dFQ0eFgw?=
 =?utf-8?B?L2pTUkJuS2Q5STBFaTdjUTJkTlFiN3BWWFFpSWZCRW5LZkJ3d0FwU0lIWU9X?=
 =?utf-8?B?RXJ4K0o3cXZPM01ic2hMYjMzODN3bjk0TjhQT2FtQXMrRXpmTnJUb0wyM0ZR?=
 =?utf-8?B?UzdaT3F1eFdRbk1YOHVtRFdBcVZmMXd0N1AzcmJ2ckZvWUdBS1B4UmJVM00z?=
 =?utf-8?B?OHo4ZUw2TklHN1hXZDF0SEJadEkzaWQ1TEhNWkZmd1o3ajdWaUQrZmJSYkU5?=
 =?utf-8?B?ZG5xSHM2ZmRkVGZ0MFJITnVTeWRiREdFSHBXVmx6RVIzRW5rbFNLdmVjUFBv?=
 =?utf-8?B?aWhXaXdJSG9iUFBKUjRBSW5ZMldydlhJdXVzYktzTlFlRm9YZGJudVpyb29X?=
 =?utf-8?B?QUs1R3VJaSsxay9wUUFJUnA4UC9yTldBenRsVlZWYWdKMkh5QmxGNis5ZGlT?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c93195-6018-4276-edcb-08db92971254
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:56:15.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P37cWscGKQAg9ceU21SV21S+EgBT0yIz+RYUyiuNLiyXaPMdQYmgkLDAGl7QU4X/+g3gA1yJuZnXF7uWeXsPeC2X3dcM3ZDgTyGee5p1RDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 1 Aug 2023 13:19:22 +0200

> Add DECLARE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Using underlying array for on-stack storage lets us to declare known
> on compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in next patch of the series.
> 
> Note that "struct" kw and "*" char is moved to the caller, to both:
> have shorter macro name, and have more natural type specification
> in the driver code (IOW not hiding an actual type of var).
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  include/linux/overflow.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f9b60313eaea..403b7ec120a2 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -309,4 +309,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define struct_size_t(type, member, count)					\
>  	struct_size((type *)NULL, member, count)
>  
> +/**
> + * DECLARE_FLEX() - Declare an on-stack instance of structure with trailing
> + * flexible array.
> + * @type: Pointer to structure type, including "struct" keyword and "*" char.
> + * @name: Name for a (pointer) variable to create.
> + * @member: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + *
> + * Declare an instance of structure *@type with trailing flexible array.
> + */
> +#define DECLARE_FLEX(type, name, member, count)					\
> +	u8 name##_buf[struct_size((type)NULL, member, count)] __aligned(8) = {};\

1. You can use struct_size_t() instead of open-coding it.
2. Maybe use alignof(type) instead of 8? Some structures have larger
   alignment requirements.

> +	type name = (type)&name##_buf

In general, I still think DECLARE_FLEX(struct foo) is better than
DECLARE_FLEX(struct foo *). Looking at container_of(), struct_size_t()
etc., they all take `type`, not `type *`, so even from the consistency
perspective your solution is not optimal to me.

> +
>  #endif /* __LINUX_OVERFLOW_H */

Thanks,
Olek

