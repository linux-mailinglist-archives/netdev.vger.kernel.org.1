Return-Path: <netdev+bounces-30130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C647861B5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCEB1C20D49
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818591F192;
	Wed, 23 Aug 2023 20:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEFAD41
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:45:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E4010C8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692823536; x=1724359536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BbeEbswuG0JQfKPtsZnDpegvIsLxYItGbNTgTSlimUM=;
  b=b2n59Fzy86qylHFCoEfvDRxRAqhYCdHFc8CVPKVtw2kMGD9Up7Sq4ukl
   MogJP0K5FK0/sye7egglbWAkPHmue+I7dtlrqmpTNT1hvDsKyvL8JGX2n
   kM+T5aWXowiiAoXgzv7cUtJUUKczsZ6b18AcaxyzQBMYPYkiwL2kHS5cR
   fsqo5oRJP/9RFm3iBjxYS+ysT126GchyEEDLu/ovHwPBRm5wy/QRv4vrg
   t+hNe47j+jG1U56MTAaqvRLMVxIF5G6AKsw83rbQCJSfR9CFLhRzS/8ov
   OXT9zBV6mnSVK5v7dm4VyhdUz4Hp5e/f8lNwZFTYIFHAnhxYG8YJ6sI0f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373152600"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373152600"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 13:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851189073"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851189073"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 13:45:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 13:45:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 13:45:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 13:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYoeRxUmGhAHmXokvv99fX6ncRgRBP8o4LHnU/9dwUE6GXLFdjyyFZmYWjd/pRFSspgRzlMp9ka3b/4TGK/6yMFgKrBFfgGpnsTBzapxHSZIkdDrPjHap6pUNmjBbhDFW0rjWXEV3kwxcSJ79szwER0xuMI7COzj5TCmBKo21yWyQq2om2Ba9c7rJSAeMOjmy7B8ALHWOmC1/CcRVx02Bl7wFO2SyyI+IcphPVPTi1nHGeVjh8RN0gr0/UU9p9uamcUiSjVW9lqBnAZsVhlPahVyNG7sXlditP+VJLRKJSm6cXvBLOvl0CZqhd8EgnhcJsqROOweU1DmoZhI1AB1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmc8mQf+vfGRsEo/0AgvBB0KoVTO9J0QLZVsPEktOVQ=;
 b=MwzGT6AbPGYUX95kIy+00JoNWuE9Kfbp9Pw4xouYSwdzQx87gM/oLsmCZYTMjUuWb9d0PrPu0rfC6EaU8MV8DHsx7T+UZOdpz07GR6tS8r6Nxa2adsgDjj7m3MUvGfV8uNJLpEK5QEMxDJvht1S3lwzr2NiogaY9uBZaynHhq/E5qU9ZX65fw+BvICbEFDpsg9mxCxsVUt0dLl8e/y9xPCaCghR59yCP6WSCpg8yNUieBC3HmCx9xfa6avUveLfNKi0diAIj1a0EKFu5qHUB9H97XWAeDUW+wzegCRtR7m00hoxlwUGkKxFvko7nAbY75i80OVrD7Ki8CE5LuDv7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 20:45:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 20:45:33 +0000
Message-ID: <c5287223-1892-715f-a589-35947ce350d6@intel.com>
Date: Wed, 23 Aug 2023 13:45:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 iwl-next 4/9] ice: rename PTP functions and fields
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<jesse.brandeburg@intel.com>
References: <20230822124044.301654-1-karol.kolacinski@intel.com>
 <20230822124044.301654-5-karol.kolacinski@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230822124044.301654-5-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: bc381821-b178-4ffb-15dd-08dba419e57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPITI6New2avXbqFguFppYFLjjBnztafmo2qvDNGLwSH7vAoHsbjPC/TAKvoH2IiG98ov0VE8KRLn6WgQDgr3h4qXFeqxbeM1Q6x2ZWF4+/249165LkkhxRJeG7fyxCuDncjLs+eb+y1cHsO9yI5dPe61SKY5UfjfqmOrqYfGrupzCbkQl8HeHVTdJniqJFFu0V4KP+aXJKKEtzTcdaK1JKFRAvzBny+iVvOug7r3cZTKpo9Oo9Y2yr+OS9w7D4S8nmXRK0Jg3WM+8B/5oxITl58aNown1HauO7e8GR3cDaIkwH4LXC1EGoIdZaW/CPBvkTrD7mfoxBibDD0LlavSy7tV/UZBkjtVvcmcYkBK5E2DMWyzygU1Lc8SgudOlFUchpTcjnN6fgnM8QaZrUY3RmWVNUDihfdt37cIoO9moranf4V/74M3A4Nj9ZORSl4eqEthIw3hOaRKFVZPz1n3XJtd1e1PDlIY+p7RUaGj+LfpoihbwF/WLoVeDLZ8LVf8o7s15ozZPsNNf8IRzZ8PhLwc56y4q+zyXteR+vP7JmjnlB6IynZNrDMPUjtTAZaRIdJdantrW1OEd+wFKdxy3l5h82mt3NLr/mJ/ASSsLKIOoiew0fC/KtpvKjFnWCCXZ5QwBGz2lY3R24neA1v2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(1800799009)(186009)(451199024)(6512007)(53546011)(6486002)(6506007)(82960400001)(38100700002)(26005)(83380400001)(36756003)(2616005)(107886003)(316002)(2906002)(31696002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(4326008)(8676002)(8936002)(86362001)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkQ0R1YySkJmMklXWC9FYmRiZkxBUGVFZ0tETGxCVXR4dnd5M1cxUDhuU3FJ?=
 =?utf-8?B?Q0NSVm9NSmlJbktaQlMyWVl4ZkxQWDljSlgzNjhiY28xdVZKR3kvb1A1TTNw?=
 =?utf-8?B?bnBrczV1RFlXL29OU0dzbHFaLzRlLzhrQXZacWNMdklJUlI3clYvcmF1NjVF?=
 =?utf-8?B?TmQwTTljbHg4M3FpcVJtaEFOVDM0MHlsM3R1NFpFSllBL0cxbXZ1dlJER1hM?=
 =?utf-8?B?Q3pVKzZNamZKNmVkTUFWMUZ6QkFVUUdNNzNwblduNG0ybUlYcHV6dHRiVHdP?=
 =?utf-8?B?czdFSVZuNHdpRmphTXB4ZnBWOE1WWXhNdHYvT2Jha2tZekFVK0lMOVgrQnZO?=
 =?utf-8?B?ekJEVnlHeWZpZFd1ajh3MDF2Q3R5b2luekFuZWxDY3ZIVnUyM3V2ZWdycWZJ?=
 =?utf-8?B?MWwrRStCcW1GZXlNbGorZUlQSWFhSzNiTUNnUTdFTnlPWVBCNElTWmZTRmRQ?=
 =?utf-8?B?bXViTXdJZnV0QWFDTkJYSFQ3WWNVcU1YMTNtWjhjK040VlBVM3N2MU9sMEJv?=
 =?utf-8?B?OG9hekxqMXRZNkZGSkxEUzF1N0JIaXUxUFhkcjFyc2F6L295K2VIbGpUZW9q?=
 =?utf-8?B?QUNKbnlNOEFBQ3RyMzZUc0NVVWw1Z2RLK29IUVpITUJYaUZxOC9NRDlRdlE1?=
 =?utf-8?B?SDE3aWYxelJscUZXS0s4VlV2Vlp3ejJXMWFmVThOS3NmSFJ0R0Q3QmlGamJL?=
 =?utf-8?B?aVk5UDJJVWZBYXFZZlk5ZnNtUUo1VVg1VjZXTFpRL2dGKzBPVHVrWUpuTjVK?=
 =?utf-8?B?aVJTMmVqcDYzbDluRjY1eUNYSjNtVWg0RGRaaEU1Ym91SWJqeXhmWmdsUnVY?=
 =?utf-8?B?VkpqemlhcnFoT1cxdVJ6K2R4VnBFS1ZBTDZpOGNJTUQ1ZkVqWXJLdWgwYjJt?=
 =?utf-8?B?RmR0NVNvTTcxMngxMGRCNGp3ZnVhSkorNEJSeGVTN0NWQ204a0ZsTlpDMUdx?=
 =?utf-8?B?VHQySUo1K0k5a3loSlZRQklrQmJoRjE3amcreEc5MWdDZThuQ0N6Mlphd0dJ?=
 =?utf-8?B?L3RTdEg3bFZQTElaR0trOUVwRm9CK1VrTVRlYm5NSmwwOExIVGI3U1JDaXB6?=
 =?utf-8?B?dElVMGkrMUFLQ0o2V0RxREJpcHQvNFQ5VERRSEl2TkFrTGI0aFVRVmJxOVoz?=
 =?utf-8?B?ODVtYk9FNHhVVENyOGNOQjFhQVNZNnpZTExkSnVHMStRN3JMSEdDR0hiSzFj?=
 =?utf-8?B?QlZ1dWpBT2lITDJweEdqQ1ZveW9yMXBSTk9rSUFFUUhacWVkYXRUSjE1MkRN?=
 =?utf-8?B?b1RweUhRZmY4NFpsMm9aU2xuWFJhQ3lWY3dPNTI2a2RWMzlzb2xrYzB3R3FW?=
 =?utf-8?B?aVI4THd4VlJjTk43NFNwZmZQWjFhQ29qbUc3dEsvRmJNVDZ4Mno0T2pHTzJ2?=
 =?utf-8?B?NFA4cHJQazFZSXhWdWxjSXBjSVozMlB1WG9tWGk0bml0Z1dPM1NkN0xtTkV3?=
 =?utf-8?B?L2RRaHpaVzNDY001N0dNNmJnNWhHSWJVa0l0NzhvV0Z3TkphR1NaYUpFMCtm?=
 =?utf-8?B?NXJaNGNwc0VTUitWQVJmblAwUDN3MDZmUXEzVmg5NVJTTGhFOXBaZHFiaEJC?=
 =?utf-8?B?djM2ZzcxTlBkVWh6VFlwb3FMSXQ3R1J0QTVpU3RnYnlWQ2N4cUd1ZC9PZXhK?=
 =?utf-8?B?NHMzN2dpY0ZPZ0krWkNJUm0xL1pYM0NLRlpmNkszNVVKSmNkRW4wWjZFbkFT?=
 =?utf-8?B?bkREeUE2RnllTE1GK0I3YzdMM2s2RW5VSDdYc2QyZDYvZzBGUDJrMzlRSjlL?=
 =?utf-8?B?a0MrdTQ2UnZtdUpmMkx6cjJpNHFZOHBkZWJ5OEdrbzRvck9sQjlIdFdzSTRr?=
 =?utf-8?B?WXJHak9rS09uZ1o1ZFpHWVZQajRKdUo4ZEQ0N2ZLcU1GWWhicm5ZR2p6ZE9O?=
 =?utf-8?B?OHVtMzdvbjgrem5pU3FCMEJKSUFhREtHMjBYTVl5YlcyZnJPVUdRM0M1YlQ4?=
 =?utf-8?B?WGZJZlQ4ZVJxQ25RaGxqU0VkejhxdXpPbjRsd0RtUnhKeWQ4TG14SUtEblZV?=
 =?utf-8?B?Tnh2WHhnTWNYUlJnQy96MlJZbWlHQjd1bm4wam1iNlI0VWNvRWNXYVhBOURO?=
 =?utf-8?B?ejRXd0RhaUJCc1FJRDVabTAwb1YwVitralVnMWVkRzlKME10enU4dVV0dXVC?=
 =?utf-8?B?U0E3TnBJUENqWXB2aDVEUytkN29CWkRHL3hBd0ZjZ0dHcnJzYjZiUW9OMDN0?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc381821-b178-4ffb-15dd-08dba419e57e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 20:45:33.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8p+jy12L0UelEtW2ssNQdABSUIyezGHEfU5xigrtDo2/v6HrvLhq018hjV01QKu0jeYo29MSpyVW3tz+qvuknb0BPnR87xDdxNir9T6NjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/22/2023 5:40 AM, Karol Kolacinski wrote:
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
> has_ready_bitmap, inverting the relevant checks.
> 
> The ice_ptp_tx_cfg_intr() function sends a control queue message to
> configure the PHY timestamp interrupt block. This is a very similar name
> to a function which is used to configure the MAC Other Interrupt Cause
> Enable register.
> 
> Rename this function to ice_ptp_cfg_phy_interrupt in order to make it
> more obvious to the reader what action it performs, and distinguish it
> from other similarly named functions.
> 
> The ice_ptp_configure_tx_tstamp function writes to PFINT_OICR_ENA to
> configure it with the PFINT_OICR_TX_TSYN_M bit. The name of this
> function is confusing because there are multiple other functions with
> almost identical names.
> 
> Rename it to ice_ptp_cfg_tx_interrupt in order to make it more obvious
> to the reader what action it performs.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---

This left verify_cached in the structure, but nothing sets it. It should
be removed.

Thanks,
Jake

>  drivers/net/ethernet/intel/ice/ice_ptp.c | 41 +++++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_ptp.h |  6 +++-
>  2 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index bd94b42e19dd..393156b9b426 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -281,11 +281,11 @@ static const char *ice_ptp_state_str(enum ice_ptp_state state)
>  }
>  
>  /**
> - * ice_ptp_configure_tx_tstamp - Enable or disable Tx timestamp interrupt
> - * @pf: The PF pointer to search in
> + * ice_ptp_cfg_tx_interrupt - Configure Tx timestamp interrupt for the device
> + * @pf: Board private structure
>   * @on: bool value for whether timestamp interrupt is enabled or disabled
>   */
> -static void ice_ptp_configure_tx_tstamp(struct ice_pf *pf, bool on)
> +static void ice_ptp_cfg_tx_interrupt(struct ice_pf *pf, bool on)
>  {
>  	u32 val;
>  
> @@ -320,7 +320,7 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
>  	}
>  
>  	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
> -		ice_ptp_configure_tx_tstamp(pf, on);
> +		ice_ptp_cfg_tx_interrupt(pf, on);
>  
>  	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
>  }
> @@ -591,9 +591,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	hw = &pf->hw;
>  
>  	/* Read the Tx ready status first */
> -	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> -	if (err)
> -		return;
> +	if (tx->has_ready_bitmap) {
> +		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> +		if (err)
> +			return;
> +	}
>  
>  	/* Drop packets if the link went down */
>  	link_up = ptp_port->link_up;
> @@ -621,7 +623,8 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  		 * If we do not, the hardware logic for generating a new
>  		 * interrupt can get stuck on some devices.
>  		 */
> -		if (!(tstamp_ready & BIT_ULL(phy_idx))) {
> +		if (tx->has_ready_bitmap &&
> +		    !(tstamp_ready & BIT_ULL(phy_idx))) {
>  			if (drop_ts)
>  				goto skip_ts_read;
>  
> @@ -641,7 +644,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  		 * from the last cached timestamp. If it is not, skip this for
>  		 * now assuming it hasn't yet been captured by hardware.
>  		 */
> -		if (!drop_ts && tx->verify_cached &&
> +		if (!drop_ts && !tx->has_ready_bitmap &&
>  		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
>  			continue;
>  
> @@ -651,7 +654,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  
>  skip_ts_read:
>  		spin_lock(&tx->lock);
> -		if (tx->verify_cached && raw_tstamp)
> +		if (!tx->has_ready_bitmap && raw_tstamp)
>  			tx->tstamps[idx].cached_tstamp = raw_tstamp;
>  		clear_bit(idx, tx->in_use);
>  		skb = tx->tstamps[idx].skb;
> @@ -895,7 +898,7 @@ ice_ptp_init_tx_e822(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
>  	tx->block = port / ICE_PORTS_PER_QUAD;
>  	tx->offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT_E822;
>  	tx->len = INDEX_PER_PORT_E822;
> -	tx->verify_cached = 0;
> +	tx->has_ready_bitmap = 1;
>  
>  	return ice_ptp_alloc_tx_tracker(tx);
>  }
> @@ -918,7 +921,7 @@ ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
>  	 * verify new timestamps against cached copy of the last read
>  	 * timestamp.
>  	 */
> -	tx->verify_cached = 1;
> +	tx->has_ready_bitmap = 0;
>  
>  	return ice_ptp_alloc_tx_tracker(tx);
>  }
> @@ -1338,14 +1341,14 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
>  }
>  
>  /**
> - * ice_ptp_tx_ena_intr - Enable or disable the Tx timestamp interrupt
> + * ice_ptp_cfg_phy_interrupt - Configure PHY interrupt settings
>   * @pf: PF private structure
>   * @ena: bool value to enable or disable interrupt
>   * @threshold: Minimum number of packets at which intr is triggered
>   *
>   * Utility function to enable or disable Tx timestamp interrupt and threshold
>   */
> -static int ice_ptp_tx_ena_intr(struct ice_pf *pf, bool ena, u32 threshold)
> +static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
>  {
>  	struct ice_hw *hw = &pf->hw;
>  	int err = 0;
> @@ -2507,8 +2510,8 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	struct ice_ptp *ptp = &pf->ptp;
>  	struct ice_hw *hw = &pf->hw;
>  	struct timespec64 ts;
> -	int err, itr = 1;
>  	u64 time_diff;
> +	int err;
>  
>  	if (ptp->state != ICE_PTP_RESETTING) {
>  		if (ptp->state == ICE_PTP_READY) {
> @@ -2561,7 +2564,7 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  
>  	if (!ice_is_e810(hw)) {
>  		/* Enable quad interrupts */
> -		err = ice_ptp_tx_ena_intr(pf, true, itr);
> +		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
>  		if (err)
>  			goto err;
>  	}
> @@ -2847,13 +2850,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
>  		/* The clock owner for this device type handles the timestamp
>  		 * interrupt for all ports.
>  		 */
> -		ice_ptp_configure_tx_tstamp(pf, true);
> +		ice_ptp_cfg_tx_interrupt(pf, true);
>  
>  		/* React on all quads interrupts for E82x */
>  		wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x1f);
>  
>  		/* Enable quad interrupts */
> -		err = ice_ptp_tx_ena_intr(pf, true, itr);
> +		err = ice_ptp_cfg_phy_interrupt(pf, true, itr);
>  		if (err)
>  			goto err_exit;
>  	}
> @@ -2925,7 +2928,7 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
>  		 * neither on own quad nor on others
>  		 */
>  		if (!ice_ptp_pf_handles_tx_interrupt(pf)) {
> -			ice_ptp_configure_tx_tstamp(pf, false);
> +			ice_ptp_cfg_tx_interrupt(pf, false);
>  			wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x0);
>  		}
>  		kthread_init_delayed_work(&ptp_port->ov_work,
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 48c0d56c0568..30ad714a2a21 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -100,7 +100,7 @@ struct ice_perout_channel {
>   * the last timestamp we read for a given index. If the current timestamp
>   * value is the same as the cached value, we assume a new timestamp hasn't
>   * been captured. This avoids reporting stale timestamps to the stack. This is
> - * only done if the verify_cached flag is set in ice_ptp_tx structure.
> + * only done if the has_ready_bitmap flag is not set in ice_ptp_tx structure.
>   */
>  struct ice_tx_tstamp {
>  	struct sk_buff *skb;
> @@ -131,6 +131,9 @@ enum ice_tx_tstamp_work {
>   * @calibrating: if true, the PHY is calibrating the Tx offset. During this
>   *               window, timestamps are temporarily disabled.
>   * @verify_cached: if true, verify new timestamp differs from last read value
> + * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
> + *                    bitmap register. If false, fall back to verifying new
> + *                    timestamp values against previously cached copy.
>   */
>  struct ice_ptp_tx {
>  	spinlock_t lock; /* lock protecting in_use bitmap */
> @@ -143,6 +146,7 @@ struct ice_ptp_tx {
>  	u8 init : 1;
>  	u8 calibrating : 1;
>  	u8 verify_cached : 1;
> +	u8 has_ready_bitmap : 1;
>  };
>  
>  /* Quad and port information for initializing timestamp blocks */

