Return-Path: <netdev+bounces-30113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB727860BF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B385528133D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B11FB32;
	Wed, 23 Aug 2023 19:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81936156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:38:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049F10CF;
	Wed, 23 Aug 2023 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819500; x=1724355500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OgSTOG3eSu4uCD9uYkDr3ALcBGs7fu8Qihy9tdfGOA8=;
  b=KJQd8+s0uFMj2nda20dQPUvJvSAsJlm/lmd1gZusicVAKk0hb39bD/7L
   tOK+urAYPe25xwBJ1sfTPo7IXc5nOgN7tO5kebmbv2cWZTf69UNS2MdpM
   Ox2zKkcmuj+GKNKmEcZh8TDfkC7pkvnlFgctPICQ7xe0nWxaWomWPqXE+
   ILkk0ledo8dn8CMnsyYXWtj2cNK0fqbRbEDHUb4nAsotWk96dxh6EqMXV
   h6rxaEE8htK3gz01EcLIGkKEIvc6ZiE/iSxM9W1pqlR0hAo4XImAkOag0
   QcHZRBroQcudx9ycZmlTbBuT4+2K5y5xCHOfmeSo7rM9lgBPY1wneRIoa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405257861"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405257861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802257781"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802257781"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 12:37:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:37:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:37:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCbtqM+M0hy5LyfNE7mwX6QshJDRYX7kngTOqOohBHJ+JXtpl/qylHXDrLMK4/82YmGdqTTYYmvghBss1EnOFrMg9uc5PqMgIO+DvHff3p07KLZbRSO2/Pzy5Bm4JTUzfObatYwP/+/DYXaSKgRRzebk0rheN5OxIQZuCqgBR9Q/plsD5Z5gdCB/NLXwIqxTVjG5zDLkl6JbuDPS+B/+dvILE9qz4+upnPNR60h0vJNnBtBXwh94B/p95VPQZ4BMpYwwcq5rQuvBF20H1Rw5Otg0DMPS2yYyrG2iBJQlN+qV0yjGlGjP4ElvIHxbJSnVlxrEg0OqrAPyxbJ/xwswqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Iey+oxeCGsH4vbKli+MS94M6jAunR0OEk8FoKMUb4k=;
 b=LNzmL9UtuWAnOI2/TqxPvzVGSjvxHTsiBg4oHC6JQm3QhbCFDxFpqB/lExBw03bTJBtbrq6Er6K8ScGxhFHYd1lpsIz+weifwaEq80QxaRmW99Lpb+byAdgekwJMJcr+fHNCNdvam9oH2S9aq7qkuWK6I3h9exJ501J77xay2qWelIZ0JJE6HwFUBq2qszXYjrh7HXkKxFPKyz4/XS/g3Vb099wF+/E2iuEJGtt38nROsDM1y81I1NAskQr2B+0jx2WMWepireGXv6lcD3bJIUoTXkj2Gqub0ohh2T1FGyxASJEyujNusM1YjcrsLoYpmomLFwhDlfMKZxPx2hj9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:37:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:37:52 +0000
Message-ID: <c731ab3c-f9cc-3fae-519e-9a1bf816446d@intel.com>
Date: Wed, 23 Aug 2023 12:37:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 07/12] tools/net/ynl: Add support for
 netlink-raw families
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-8-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-8-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: d862e900-a432-41d4-24d7-08dba41070e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9ZI51bVp2eGn97JcO3yB/TN28hoPGTlyvlZyLIX8xDJeZR5ob6kEnqk8w/rgEPqwbwi0N8Xl7ZWLk4JiliZwbsJuh72yzSbZNX0+CBqe0mPkWxx+YZ2M/myMMGXCGzmssR6c7kPPAhVxlYBEEI9zz+YDOo98SBRAi2pi7STy39SIqMnRCaGa8Vnjnlu/6p4A5/eTRaLu19WHqiM8XzzCnyxUXF9tNqwnlVuX/e/iJsOds5rGILkuFW7s4KCWOngpp+pDfuU/NNdme6HRd/n4oqI5K7YhroywA7c5xaz71gQuK/4rLFdmZ/SFwmCP+xIQ1Ypd7ZAIqaXxQUiGadUfapKYRHBtwftWDiX24QVZJDyZVAAOe/eg53WcIsHfc4o3vW1Q7ZZnjvwI9DAJ/oz/Yv/GZ4+7lk1JwKdF+A5ES6lypXrRhf3Vniiru1e1SvC+eNu2TsDvbXXGYRkyxasHQrzQc7qzcVpVAYySXxquySl2SzMqBskIJs+Z+JY8aZkTP8NbXalF5PEqviObZKdK2rFBM6KumYg9doLdKxkLyZpfw1eUuCXzw3ebK6v8QQ956CvUv2KhfZdyJl8rMhsKPU76Cvraf9ABf8nkTjZqVAy5Nz9eIWo3BUvGRki8YwdyEWQPJhcPFkVIap6XUDlSIeAC/8pt+YHdlzf9X7Mn9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(6636002)(53546011)(8936002)(8676002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(7416002)(5660300002)(478600001)(31686004)(36756003)(31696002)(558084003)(86362001)(82960400001)(2906002)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R29OeWkvemF2ZUFrZHMzWlJaa1RJbDhCT0owOUV4cThzbzA3eTlwSDNmZjAv?=
 =?utf-8?B?Q1dLNkt4VEkzUEwyUk8waVVwd0tTbVJHS0xGY0lqdEdHZlAwdWUraFpId2xa?=
 =?utf-8?B?aU1EczRKNC9wYXY4ME10WXFGSWQySEpoOXErcGJZbW1ER2xFTW44Sjl5ekZz?=
 =?utf-8?B?SjYvY1RBQ2psT3oxTm9aVWdDSDF3OFZzSnJrckFKb200eklSRTZFRE4wMEw4?=
 =?utf-8?B?RVdVZDYwWkFDSjlMeWtJWVB1ZzhITFhLbGlrT010VTVneVY1N1JOc0xVVTZw?=
 =?utf-8?B?TnBCZTZIcWF3UXZnK0kwbW9RVTFiOUxxZDA0NVdIejg3dEd4MGk5K0VZdEUz?=
 =?utf-8?B?bDk1VUxrNiswODRNRnN6TTdZeFJpemh2d0hXZTZYVHM5TTlFTjhPZ3oxajly?=
 =?utf-8?B?YjFnWUJZMGxpREVPNkFvc2NIWlRWbDdoVmc2a29sajVmS3JTbGNLa2ZTVG1u?=
 =?utf-8?B?TzdPT0J3RzJvcWs3ZTZRd3lwSjBuMzNZWHpDMlFyT2ZFNjIwb0UyRHRxY1hq?=
 =?utf-8?B?cW1HTVFVc0F0eEFFaE8wNWtjRUsvUU03QWpaR3pWWkRLYytmckZOR3VWMEUr?=
 =?utf-8?B?N29FT0pHK0hTdlZnVUN1bHlqNlVDbm9LVDg0VjRULzZWU2hDUVJMODhEbWNK?=
 =?utf-8?B?QWNMZVFHUDdDWUhrN0JSSU9XcWdNbm0zYkliejRTYmhFS1RwWk85KzRQd3cy?=
 =?utf-8?B?THFNb3JlOXhTSElkeWpYakVQbGJLL3hDWlN1ZjBZMnc2M3Z0cjZGUmJtczQ4?=
 =?utf-8?B?SURWY1RMYjVTNXZDaTg2SElGNWZ0VlZJMjNlaXh1SXVjcFVqODhoZjZvQTYv?=
 =?utf-8?B?Uyt2djJZS1RDYW1KaHlabHl6MnRxVWNHK1kzdEtEQ1lwa3NINFdpanNsTi92?=
 =?utf-8?B?VkdIai9sMVZ4YmhIOVpVbDhaczRkdVN3YVBBdi9Za1dZeTZhbGZpNElQdnhG?=
 =?utf-8?B?RFhmbnF5UTdOY1phNVI0bTlnYnVJL0JNK1FGRFo2OVMvWGQzRy9QTmk5V3Ja?=
 =?utf-8?B?a1lVcUpyREcwaThudVRkb0l0Sk1la0xWeDQ2cVVveVIybTVxYnRHeXRMeDFU?=
 =?utf-8?B?TFZPY0lNRVRkbTF2Nll4NzlER1JTbFBxUVFpV2JPVFFaQ1FTV3VJeU52bEZ5?=
 =?utf-8?B?TnVQa0Y2SVN4Ym9ZWFFFdTlqcnFlNGJqSElrazY3Zzg0ajNWWXloMVJtSnpj?=
 =?utf-8?B?NHFyUkxGTlBBdEM1WVlsMmhkaHpLekY0T01DdHBmT0YvczE5NDhhQUhqN3hT?=
 =?utf-8?B?cU5LN2ZvL0xad21TdkFaNGc5c1EwOVJDd29vbExkNVNpV3BsSVk0UHIwM1lI?=
 =?utf-8?B?OWxNMXA3V0dYaGtza1VJNjlxNDlJL2lJRjJaWWpTYmhLV1dtbU01WGVJNnh6?=
 =?utf-8?B?WkRnWnhZWTdkeEJKdlRIOG92ZFgwMG03ZnNjbkpRZHNBcTBoRmhXUVJNendt?=
 =?utf-8?B?SlJObkI4STBmVVFQbzZ3QkduUS9Ick9qR0lwMTdvaTNGVUZCek1VOGlLeGNs?=
 =?utf-8?B?dXdudjYzaUJWa1RYK0ZQY3ptY2Yya0czNURyeHVpWEErY3JpOUdNUDdQWUwy?=
 =?utf-8?B?dXdjZ2o3dWFZOXlCWUNKa0tMYlh2U20rK21JYTV3bTg4S2N3bWdhNFYvSWNx?=
 =?utf-8?B?TWJtaGRwM0Q3TFJhMTlaWWo0KzhJZmpyU2tSZVZ1L1BSa0JhWUlvcS9DTnVo?=
 =?utf-8?B?ckZoMVVhSTRQd1VJZmEyQUU4L2p3WTRZcWdDOVRIa3htSXI5aUZlbHA5WEl5?=
 =?utf-8?B?R2g5T2JlZjBuMUJYMkt5UTdhZ0NxbUJZZnplblBPOEZFZjRZcUs0OExWeWpB?=
 =?utf-8?B?bnhGUUQ5R3dHSkpQWHVwQURpUjNPd0RucWVMakJ3VVpEMkNLVzBqSnZJOW5h?=
 =?utf-8?B?MktFLzEwUmFPeTlMUTJDMWJNK1lXaGpJM281a09rOXBzaGRvYlBaSXBSVDFR?=
 =?utf-8?B?MjhOQTY0dWdYbHVjc1BCcW1BNi9mWk9QeEdWaDh0ZHR0MnZRNDRtV3Y4bExa?=
 =?utf-8?B?VWNvMGIra2Y2ckJPVy9OYm1FZXNtVjBhaTVWWENEc3MrMnVDOWYyaDJEWVF0?=
 =?utf-8?B?bVBYa1Iwd3p4czNveXNSRVMrRmpCdUR1TUlJTUYzKzdPOUxVRTdkcWs3aEJD?=
 =?utf-8?B?Q3JRS3g5WlVsQjNmYWNtVjAvVXFZUlBjdHdpNUJlOU50WUZhUGFMamNxVGFR?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d862e900-a432-41d4-24d7-08dba41070e8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:37:52.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1ZaTqvsq5v9Zb+F2E0KduGIhxKwTfWrxl/XaBTtuN6hDYtee+nR7fyuFvR+MzwGZdnimjFN3RCAYUwodNBnPQXvIWoMN/Nt1oueaqQUwQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Refactor the ynl code to encapsulate protocol specifics into
> NetlinkProtocol and GenlProtocol.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> --- 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

