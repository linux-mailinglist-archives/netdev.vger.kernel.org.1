Return-Path: <netdev+bounces-30118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEE7860CF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A18281359
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE861FB39;
	Wed, 23 Aug 2023 19:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834C156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:41:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC6110C4;
	Wed, 23 Aug 2023 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819675; x=1724355675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBpbHyJqCtYeR16qjzZELstj0EwzBMoR2Nrjrb/Aqh4=;
  b=Z6dN11Bc2w5uhW4AnpCxYU/lilRBWYBfkkOG5MVpBQAiER0BRfemg7mA
   74xyQdpWVggDizIeU5hIM/+mEgfZxi/YHSIh1YyJU5LMFy85s7GViktyb
   vH4DJs+EsDKiW8JQTuLSPurpV0ua9tCQtFsLVTF1uknLfQiDQW7wy6rB3
   v5d7REZcYQ0SbrEYwkpnGe8eq6u4QJSIgnXW02yarF5kdfjlmSJEDISo7
   GqZJJpTYMfWP57tf+0DMsvljS/HJIpRTvadGBjh/TwPTqwhWnuuQf/qdJ
   /qGep4gSELQdce5nhOTYtUPfOnyremF5x6/yn7X3tRGIzlHAcVUfDs5sE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378009106"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378009106"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910630574"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="910630574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2023 12:41:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:41:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:41:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:41:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIxtGssPmGXerOra/e68HXElTIcehhAZmbxN0EmWWAnppCv0I6jndvnp0Bmh51xZstiUjTx0a53QMi57oqih4qnHJ+HXfjaLSevCv2v4u/uj1fIenH0k982iyNuOb4Jk1n1V5ql2rrswltWOV6nnYogKS2oUH3es8uHX5AB3SqIKd7kQd3x61kq+36Wxq65SWnDG4XLG72OIOC31HysgeVOiD3oAw8bBjc3i7QTfR3tfJS8d/pR+47bxJmVYvs3ul41XBma8JNrEdeB988w4ySLiy5wAJuO9cdbwVjVVezDG7/TpXyvXsYeNYaIgnrhXPKoy1RaDJbpB51UWGfQtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up19v/Swf9v55HYb8Td8NcxLNU20mleLRAtHcDAE20c=;
 b=Jfj26kTqMnb+j56aQn5pSee3SaLSlImqqhvruiDpdwosWk6/EG6eSdqSHVzjNiWZiBkwLR9/RaNP4Np4u1cE9Qbb4vu8JV+ueUWER0eStKSlNs/2IRF7mToZCRcBvrFZcQL7fqurun21kSG252oQzEd1UOYXIEuLpnTkPVFvyf6+nJNRXsJwYSDU/SHLmprXyBjk7oKCPJXL/D/lyiLmYFG/Z6RyyBmesprXP7WuOJmSos2zEi0kffgj8g6lV2DjbLmHucktwy1ba1oDx/RkHreUk06k60Fp6vIgft2taYzuYoUoemL16jvx8fIU+JzvnQkbFD9BTLTWrN1Hpx0kDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:41:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:41:10 +0000
Message-ID: <6e72fb4e-6f26-3071-995a-d33820d31aa3@intel.com>
Date: Wed, 23 Aug 2023 12:41:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 12/12] doc/netlink: Add spec for rt route
 messages
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-13-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-13-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a22f14f-ceca-470f-6ff4-08dba410e6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ7OzX35E39IIPM0UKJ5HJM6nzUU9VHcbgXUyQIh70XtnWY/22HtPhFRul+YLuWRTTCC3fWykmJRpYE9ZIgIUQ4sPIeJLoAZ50prJqAju+3Fq17MzsN6cbeopZTn41nc2zXniK83x0PRyW3ebnTCOu3TUI+LyjduViQ2VaWNm777k1FSVk8Sfm+qAv5pq7OjAQo95xh40c9O+qOqvie2OXMNmIClUmWqBSp1nzng5NNipzjHls4ceTqIqSj2PhV/WPRl8Kz9nHzMANG/WsC4c0YUFTTLDs+VIuUgWzUaXs6Z8vpJDNrJ+V2hLijHS4xHjtjQML6bVJh642vPiZFyXhSkp8EHar4DknCU8poLvkenlPxmRG/cdTFgVqgD10ksKRUn9F8US7K56mUbGnvr5CEDY/NunYxCpHAWwzWpExj4vx3/8vyN+KqUrTyvRh++mU5MaVqkSMuDIt28MTMbib0tADpHm8ZRBmZhiT5lHG7oowIjNZElZGcqgKnkgr2sddFZesob+7L+lsJvFUYCqExAaLrH4KNEZjAFEZnro9wWmDRfmObDao96hlyKnPranbzhsp/3iaAPf+xbBuLzD7/Z84NWLsHwi4XbgiZB1l1xvThnFc0eV3KMsQi7t+nzbqy8bVMcuaidt5nboHcvn19J0mtzYEKAs42VNzjhxhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(6636002)(53546011)(8936002)(8676002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(7416002)(5660300002)(478600001)(31686004)(4744005)(36756003)(31696002)(86362001)(82960400001)(2906002)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNPQ1k0elp3R2xlMEVTdlRNd0xyZkQyRG9sQjRKeEM3Lys4ZXhHV1d0R0tW?=
 =?utf-8?B?Y0pmR0lXNG1hd0VXcElJekRsTU5wUUpFMjc3ZWk5S005QmRkK1BvSkU3WklY?=
 =?utf-8?B?RjhRUDNieDQwWWt0L1RCUUoydFp3dWlGQ0xPZ3pQMkFhVjE1d3VjUXU0NWN1?=
 =?utf-8?B?K0o5TTZBbjVrTGZvZGxEVWZjZUpWbnl3amJ1dWJkcXFHSHBYbFlOOHdpYlY0?=
 =?utf-8?B?dzZtQlE2Uk5ORlJtOGdsOC9SSXNDSmdyWFhTcDc2UlVvczk4NlcrYkFKb01N?=
 =?utf-8?B?MFVNYitkaGdSMGVQNURIUnljWEMxaVdPeTN4YVdrdWNrdDM5VG5kenVkbmNB?=
 =?utf-8?B?RlJIb2ZVbTZJaGZWMENlQ0VGVS9TMTRCOUtjOWp6cHBPUzltMEdqYTI0TkNj?=
 =?utf-8?B?QnRiMG9mK0lTOFd2NlhiOVR4SEtqVVI2d3k3bjJTRm4vV2VHc3VncFMrWEd6?=
 =?utf-8?B?UlU2RlA3UThCckpCSUNISXIyM3lsS09CTkVzTm8wV1FIN0dLSDlvd3I4ZkE4?=
 =?utf-8?B?aC9DbUUzV2NSeW4rOS9Jei9mTlpDQ0QzS2N2ZDVUN2ZGV2tNRk9rMDI1Qmtz?=
 =?utf-8?B?MzlUdFZQc010MWVDVUFTYUVRV1R5VU9JRDYxQ1Y2Nk1pT1ZIaFFZSGRZaEh4?=
 =?utf-8?B?c1crQUZWclNvSFU3VVVGMXpMd1RaOTJ1Z0I5ZjVwUDRwYnNGVmdjVVNhdTV5?=
 =?utf-8?B?eXJDemtLUzNMclhnTGlKdmFPRGxqMkd3dEpsZE14V0JBVysreXl0OGhodGZD?=
 =?utf-8?B?YlJCYndZeUU2Ny9tOFNxS2p5Ym1sWkxmbGVpdTh3VXFLNzkzK3ZYdHRoTDlG?=
 =?utf-8?B?TVQzMmwyc1I3ZHpPZ2hSV3M0aXZmVitoMjJEM2lyTzdjZ1VtL1JieGNrTVBj?=
 =?utf-8?B?WVZsbzlDSjlTY2h6RVJuRzQ5VDdZdGp2aE5wL1EzMm42eko2WFFRczF5bDh2?=
 =?utf-8?B?dEYxdDhJeHNnUVVIKy9ZcTNBWnRKVDNyT3JwTXZVcnIwOFRhZVJBbGlZVmEx?=
 =?utf-8?B?USthaGppQ0xEdnpENmFKODJHUThkZkhMNDc0MHYrQ0ozSXIzR0tMUHFrT00y?=
 =?utf-8?B?dnpEVU9SZVRuTGlzU2hvLzNzWUxLS0hZTWhoZ21hdUdJK2VxQmhTZ1ZOWE1Q?=
 =?utf-8?B?THdyek1wTEJpdHQvOWZuOEV1UDl1OEtHMlg3QWFrNm5xOGN1dytXZmZaVDNU?=
 =?utf-8?B?TmlCbXk0b1pSN0h2aHE4OGZpRGJDK3RNOU9ndjZnTkdIVXZacHVxVU5XRnNa?=
 =?utf-8?B?NmhpUzJKTU9zVEtWVmhRckNERCtvdkpSU3FmUm5XaFBkeWtMU0VjM0JqblhT?=
 =?utf-8?B?dDJMZzRaUDVWOEVxSndPL0hnTUJydWNFOVk3WUFPSFhlZTROYStzR1NlalUx?=
 =?utf-8?B?Q005WjVRR1JTN01GNVJxUUtSTHZxM2lSaGJzem1MczRIUDJINUNvdDNGM1cw?=
 =?utf-8?B?M0xDUEhoQzM3eVRkOUN6emo3NmRINGVyS0tvdExrQ3BzUitRNDVkbU03VWxV?=
 =?utf-8?B?MXdxSTd6VEs0YlV6WldzY1hCL1B0Kyt1czhhVXZ1eXo3cjJrc3FWSzNiR1cy?=
 =?utf-8?B?bzEvZTNzV3gvOHd1U0tlMHlad0xuWm05TlB4eU5Cam1tYkhFWWFTdXoydGtI?=
 =?utf-8?B?OEJmRGJLUmhqTXM2b0lLV1gzM0VnZmhaSC9SYUgyVWRhbENJY3AwMEpQNEFX?=
 =?utf-8?B?NTdJd0UwbjhjR1IxSTFleG5aTkRKZVZHYTJOVjdoSG1RMjlOcEVTSDROakpw?=
 =?utf-8?B?N2g5b0ljN1BLc1luOGovSjF6ZXhyN3ZwMmN4MEp3aTd3eWwxb1o5ZUJsUUx4?=
 =?utf-8?B?YUx5SmJ4OW5OeTRIcEcrKzJyRnhoNit3LzdFOUEyUm9nUFBFNUhCU1ExNzVT?=
 =?utf-8?B?MklWU3c4ZHVISitOQTNkNlNVTllKc1pSakROV21kNDg4Qm9BMnl5S0hIN0Ft?=
 =?utf-8?B?OHN6ZFhVSXpsNHR0eHZRRXNESm4xWk9MSElHZ2xDUms2T2Q3UEZhTm1YT2NT?=
 =?utf-8?B?WTd0RFA2d1dna2FFT0dMQmU5M2R6Q2hiYnZpMW4zVEVtVE4wR1FMUGJaVThp?=
 =?utf-8?B?QWEveldId1QvYzFQNnJTQlNoVWhDdmwybmxBdDVSWE1BRTRrc0x4Qk44K0Uy?=
 =?utf-8?B?UjlBQlEwajNvUkFFZGI5MFR3Sk5ZcXFHMFZkaWZuTk5MY2NSOHFPRGF5OUk4?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a22f14f-ceca-470f-6ff4-08dba410e6a6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:41:10.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC9LhIKK5syLfR3c6b/+JX1pNoKqEzWpkjoaekEE4K5m4VBy628r5+YH0glCTcCl3MsDtRAubCQZ8hMQuT9Ihtqmi7Ql5G6czMdQbeP37BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:42 AM, Donald Hunter wrote:
> Add schema for rt route with support for getroute, newroute and
> delroute.
> 
> Routes can be dumped with filter attributes like this:
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_route.yaml \
>     --dump getroute --json '{"rtm-family": 2, "rtm-table": 254}'
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

