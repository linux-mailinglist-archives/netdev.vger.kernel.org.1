Return-Path: <netdev+bounces-30111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B957860B2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3C82812F6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06811FB3D;
	Wed, 23 Aug 2023 19:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BE156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:35:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72AE5E;
	Wed, 23 Aug 2023 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819356; x=1724355356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jSJYVlCHsVl+UmW/YJXIgogPrBrtqpnzm9kiA+kquLQ=;
  b=Ne8FvXlnwjJmyo+t7yhrj0eklxp96mp4e5PUv8CMfi6AScJ0maERAb74
   Wzle828zFkMEnOb14uqgpzHoc81gG6XBGTPaViOQVI/8GPgSUY/WiJTfl
   5ZRh8HBW2skDiE4+UARfs81tTknJjJEYOkw8ipTtPdsQ3ZIst4r6Gj7vp
   X/gxVsoIlPklQ21arMNeoqLbNPJH1SEHqSXmxq6Pz0sv3QTJBUmqFSIMi
   EBLSMKfl6cCTiRH3Zb7gWErAhhCqt6tX+roRXiv0WuzesiSin44vM1ooo
   gntESVbaQ3PWxSGyhdr6RRJoF8k/yv8Gp/hAA7efVTSxkhuv3xabZR0Lo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373140014"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373140014"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="739895284"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="739895284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2023 12:35:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:35:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:35:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:35:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMAk+IsJswXTg0oRf3aB7sgAljXm21sAxtL1QFXo/BrWg3DYod+QhL6LfM52naFpC9NijUrfH8Urhhnkc3QqLCbvo3+CcKT73OEqqfgLzAZepzQbfgqgtSaaUjIhnxXyeYsxrPvnLCNN13kBSRSpHo2H5boj5o2Ceq7GpK0ZtvmicbgWg42097CN9VQATUyQHiOcsGHKs4qOmSrKFK2zs+07O9IX0LM+AMoaeTqowfBv7j23u6T7HmSpamnEczUkxLFO90a7cuPBdqWr09lnky7jOcU21cqmXqgTeFbvQRZB5s0rRno26CfuaBi83EoFywTKNLP+aCEQkrYr9l/5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZv2mXgOSCPhCbsUAkMA5/WRD7tmIrq5CYl5iVrAdyQ=;
 b=E8IRU5kcNLigL4SWetozx3I3/ciVb5WASOMIKzboivn5O5cHDlUUPX5+u3KfScFeRrHGEkmpPI0cNv0t0ei1UnpshNBhYoxABbVZiEiWjYkkJMVRw2xShupCsH+uJe2FtSusI0wNR9f7ZYnbVzvy1jotrdXm+qAYTnxE7X2U0lyFMFrHbTo4n9jHrCq0xUqcTStjoXHZaNl8Uf1pHsFM7cr5joHhIaMbLeAVAN+MVrRQYGVjCDIDDVrzbtWOBaxMDQVXbVU+GF3oPEYIfmp64p6m0ogpBoxqVk+GaWMQxfbhRi7EtEImsKWUxg+J2Uf5ZpT2N+VOCigmtxsZGAj99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 19:35:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:35:52 +0000
Message-ID: <be004d87-8da3-2caa-8a47-3983c60e16d6@intel.com>
Date: Wed, 23 Aug 2023 12:35:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 05/12] tools/ynl: Add mcast-group schema
 parsing to ynl
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-6-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-6-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c19370-50c8-4156-7d8c-08dba4102929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDzKr6kVvfgrmqHLjdah/6El84hC+A5WgLYoKE02kZlJugEmcLSS/yL/P+wbvRJSeNcbj10wQShDlOjlvwZ1edDIHf80QDeSd9GB7Ag1cDAVARFfEp4s3myUG/tOyrt69EA2H+RxWeyx98ocQ76xwA05SARtnPTyJBw65KrnXXKO8Wckvvxs+ZzYw6+bNmoGemAB53aJWw61mRL3d9Onli2y+nXuTlpqUhtZYGEFOcZAaBw7wxtEk1n6WrGYGkWIVOBhpun3TH5eXWu62CfJ2RE27/x3vHxiSVJ4vIdidWH4J+ftfyT5uby2XEeHB86PPtZDdAAoq+fjNwXJ++rSAgpnUlJfZ++ohDDTtFxrqAcl3rdPkLve7ivqAsxTmYFDDeUlcmqdv4N1kyBvJ0ecoOL3hwh18rewnGDGvtCEcTQs01yGqgPF2/sucQOoZY8r8Dzn4Vcs4VeFi07/nma3GG5EcagNO8WIHFNYUDAxToR5KFUp4roEF5RTSiFtRnn6knW8yiV64okxvQX26tGUfGM5QycyFZLR1Q7VRxJ+MjKlXDFv0tP5PJHkXAiPImuldWr4unQOIMrtSAxy5jazmKVe+mcWQ6QmKcg96NtEN0nwCgg6Qitqhi4MqxqNWaUk5/O+kuLQh91zu3kW0Ycp2jxsfRHQI+2jVci47yeT/m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(186009)(451199024)(82960400001)(478600001)(6666004)(6486002)(110136005)(6506007)(6512007)(2616005)(2906002)(41300700001)(7416002)(8936002)(26005)(4326008)(86362001)(316002)(5660300002)(53546011)(6636002)(8676002)(66946007)(36756003)(31696002)(66476007)(66556008)(558084003)(38100700002)(921005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1xOU1TY0lMNTlXbjNNQ3BQVkpCN0VidjNBdWVOK2hGRWZ1OXZoWUhzeVAz?=
 =?utf-8?B?NEdXcWlUbzFWOUYzMGhwTUVVUERIVzh1aUhMR2w2Y0VjNmN1cU9mdWhHWWN2?=
 =?utf-8?B?djFHQkxmWTlLbFRVZDRFVGtZMCt6YXZYUXUvaVhUSWFTR0E3Unlkc1VqbkE3?=
 =?utf-8?B?YUkvdUpqL2lRUUpzNmxKNGJxWmdhUnl4UTJPWG5RYWRUd1oybHkxSjRXMVV1?=
 =?utf-8?B?YU01dmxmcFBCZFExMUttNEdkRWpCNllTN2VlQ2xZM3JVWDllTjZCOHBoc1Jk?=
 =?utf-8?B?OEdFYWhDMmNvLzdmWGhYSmVIVElrMFhNeHBUeG9uOHFtS01EU0Z1YkYydnJ6?=
 =?utf-8?B?Yk40d2E2aG5rN2RVMklMbU5SdGk1YnRwemhOMGZXVUlEclNsL3V0RDd3OXFN?=
 =?utf-8?B?RlRBc3E0ODlpNzVMTFZIUzM4QmNOM0FvSTlicWs2TmI5T1hYemg2Snk4SVRH?=
 =?utf-8?B?WGRSamhKNUVXYjIvcmo3NEpnTUxsbnF6bjcvNktoMThSd0JPbFpIcnh6NzRo?=
 =?utf-8?B?ZTYzSEZMS3dRbmZ5K2x6UkdvSk5BdVVtUFc3TDI2N1pmeVFacjBlVlNoTTdp?=
 =?utf-8?B?NFQzVC83QWRYYldma0l3dHFZbjRJTEpIdkFmdEl4U0F0TjF6NURwYkdlZTNE?=
 =?utf-8?B?WTR4ZjY3L0dJZE9BUktES1NpM2ZrdU42dEtrUHBhckQ3Uzl2dlg5V0xFVklR?=
 =?utf-8?B?R2FCQ3ZudHRUTnN1QTBIL3hYRXJHRkIyaFcvYVRUUnJkbUtnUUxaQUxaTXNB?=
 =?utf-8?B?amU2cHFQVmFWbmNqL1gvSmpWWWJLNk0xQ1VXVzY4c0M5MDV0aWZRang3dE12?=
 =?utf-8?B?V1FlVkQzaWlDNlJZOWpvdzJtNnR2QUdYOHcveDVadmwyTVJ5MzNZeElXMU9M?=
 =?utf-8?B?bS8wM1dER0NwTE1PWHMrT05HWWtOK2QyeSs0a2F4OTJvODBCUSt3MTNmMDlG?=
 =?utf-8?B?Nnp6SUlVWHgxZy9LcUJWN3kvREJlbVpNL0RlUjFhTE9YeWxnTjVsb0hTQ2pJ?=
 =?utf-8?B?MGZld0tuY0tNcFlHNTh6ZCtNbzkzR0hPenlEMlB1VnB1UkFUZnl1V21qMWk3?=
 =?utf-8?B?dVN6Si8rWm9HUnpNTnUyY0ltb25KcmNDL3U3Y3JlbkVscUVhMlMrUVpBN1pB?=
 =?utf-8?B?c2xHNk9UKy9VNFNwMmM0eHFEdEdrNFBzeHVNWUtBSEkrZko0Y2ltU01weC9j?=
 =?utf-8?B?ZDNrcTdhZDdnWHBLcjRqMXlqSDFoaXlKRzE1enc3K1RSODVDUzAwNjM2OUww?=
 =?utf-8?B?aktSQkUyNXB5T0IzM0orN2wvS1dUeE9hcUtiZEVvZHdpRXZTL0hqcjhvcGNr?=
 =?utf-8?B?aUdNR3YzdW1vb0xtbU1jdzFTaFU3TkF2ZGlUOUwzUm5BZ2pGdEV5bWRXdFZw?=
 =?utf-8?B?UElnelVJN3dmQlVHTDd3NFRlTnM2R0YxcUhOSVo4eEZkQWlabEJpN2dwczhL?=
 =?utf-8?B?bkIydzZxcDloUVJPLzh1ck5lS3R0NUluay9PTlR6QU9tVzl5WGJzRVl0d0JR?=
 =?utf-8?B?dVYrV1VKY2VhMTNBYW0zMW1vUlEzWDNyOUcxY3VhRENZQkZ2aDdWVDB2aSt1?=
 =?utf-8?B?dGNDV0dtQldXYjNGMlFldkljT05PQzJKRVY0cFN1bFMycExXQ056NS81R1ZH?=
 =?utf-8?B?VVk1dTlKNy9EQ2RsNTc0UW5sNENnc3VMSFFzVHlBMGNoYUJacWR4ZkI4NG14?=
 =?utf-8?B?b0VxcHp1U3g1YjdrczROSE42TjQzWTlpWURMR0VCYTVzQTZHdngreTdYaVl0?=
 =?utf-8?B?QWdPSHZXV0gyMG5mVjhhc2s3Y0tUcEt4TllCN2ltZ3Q4ZGdEQ1d4cTVHenFB?=
 =?utf-8?B?NGdhQUtLQ0Y5V0VYU0dDN1JBUjdFb3cvQ0JNUUxUbUZGUHhQQjg5VVhyTWxM?=
 =?utf-8?B?WjJVelA2dTZ4SU5zeE54VlFHSktoSXBtenpSMTRjdGVSRXF4T2tQd1hGdDFE?=
 =?utf-8?B?RWgrbVBwbXhueGZzM0xaR3NMSWh4clFMMk95dCtzNndXRFpnQ2FyYUgrSUh5?=
 =?utf-8?B?RUpvL1R4K2ZxU1pCcFo3RWRIMjl4TkxDb2RRaURMRzFmSi9Kb3dUSW0xOHlH?=
 =?utf-8?B?WFFCOWlhZUUrTUNqYk1yRUlEa2ZiV1B0dlp0bXp6MzZqQUhCMDI3VzRhOEd0?=
 =?utf-8?B?cGZKZXNMWkcyM1pwYURlRWl0VkZuakltdFc0MDRCUHlFa1V2SS9BVnZ0cUlG?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c19370-50c8-4156-7d8c-08dba4102929
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:35:52.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsKtz3a/OXOfLC/pScWn7aAc/nTScoNgelpnc8gUEYhlSE86jaEteWFnmYGKq31aGnWaDM77ffvBrKQuS+2gwPyMurJRpxCpVB8RPDAA3L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add a SpecMcastGroup class to the nlspec lib.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

