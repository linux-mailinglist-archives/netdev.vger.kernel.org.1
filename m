Return-Path: <netdev+bounces-28804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A72780BD8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBCC282409
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125F17FEF;
	Fri, 18 Aug 2023 12:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3618B08
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:32:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEAE7C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692361923; x=1723897923;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WQqTHBcZuflsIU+PUZCrGEwnnNSyKqw1Yk7YnmaPD/U=;
  b=AABny0DrNF0UkjLzKYjVEnZEFRuNljtHs9uzMM1K9MhTYUpnRT199JhF
   2pL4NYpvMGEy2FjW6GxgQaZ/DhPRDPdCkoQLo15TZ8/EBDpolZJ8Wrxol
   PJbESCtTimMiLlB1m+MbM3ToLruKKODXJr7jV3aE2RJP1/gmK5URH+RG1
   h8CZxTUUGdHfh8uFUO9TRvS4ZDRZ7bBMBQD9OjV0A6iHPQGPOoraeT0l7
   GJfHiix6P9H7hZcWvOZkqf8jiJaaHGCLBx7VZD6YYJMXEhD7bAfUJRDxe
   gM4KE/nk2aDCiDUDee73IgASvM2u1ojJUta9p4JUlXgPYRoAODvcZENoq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375870917"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375870917"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 05:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="684884749"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="684884749"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2023 05:32:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 05:32:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 05:32:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 05:32:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 05:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzwAdJozWVxzcLEY3x8mp4j0mTNhEgO9nmPUPEzD0vpxSxAGyeHo7Tv58DG688vBQ1EUuMdo1Wo0KQt410LxbnCiSRnfUTxcQnkUoNonotL+9JmbVkz1gY/WYZ+hDhSlbBefL2OZrAU2YYra6nBe3RBvIWexWA7iYkGR4IW5eAhc6d3LgETpe3NgpP6DwBY+CofiFvBpl2mWH2O9gQLaFsQsqQIT0x2os0mSVo8ZwZH9ix1FA6FEhrutKD7tir5jf2zIbCFK0kG4er/P2AsnsogoDnqLYqMPq/dsnyMJezPMfkHQr6LhTLL+6Rt8yUZEQ/gj4FudoEdzgqjZTPnhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9KygtaBiJbVeq1bDMlChGzTqYBxHEz7BWjdFqVqk7g=;
 b=BrsfGdI8ajoVGvRpVgXg2Z1TrQ7U9gG6YLxIPIriMpmZWgJCWOU+HEazkKlaEff7Ee/oVA4+V7a0Zp+dJ/YsDJXfsMvtb1wr7bUJTu57QHOfidsXg8dVpLaSlNyuue6y29ua5lLB8UKBeKl54exvjbrrER6TiuGis5V9biAshLK/AAJxnlnwBwoa842l/2RJ1wkdTeZo85FjgCunKB15Bra/ooNH4FmvNonUgnxnJDfYUOFYWG3t+CC572dbpIaPcXSSK9Kfvi1WcfjJb7Vo4VHjzWfXld7C6njZzudXhpGPOvyJEnZ8XxhXsyIyaPuyRV6LflmSvTZQv/Gia5PW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB6971.namprd11.prod.outlook.com (2603:10b6:806:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 12:32:00 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 12:32:00 +0000
Message-ID: <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
Date: Fri, 18 Aug 2023 14:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Paul M Stillwell Jr
	<paul.m.stillwell.jr@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>, <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
 <20230818111049.GY22185@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230818111049.GY22185@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bafa07-d149-404c-022c-08db9fe71e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rc7+mlsMOFB8rLJSOSfIdeZEde6QUamcJdMFdovWAtfZTqO7pNIravRg2Z4f9rffthiYw7f2YMkFJVZ5ql/VhKBwlB/DyB0fLmS6P6/ILZD0eHjOG+1CJyRghqPgnKogg1q+M47Zkt+7TCRYLCJI5cpzUfLNXK/pkON1bHPwJSRUUfWCbry+gAdpMRvvuKUmnvctYw55y5u85PFSYajOd/TCAGDw+3aPoG858WDnxz149BcPj2MSkqEkb+nl8rr6EmyJjMQqicZJubF9PAgzMTxnK3fSAvAyy/ZuVW2DX3nVJ4NoDyWCs0rhANnSm1NfY3nsOa+gPBzZjdvjiSGz6wRpQ4TmulFdyiW35jr4I5vdGKyfx8lxhghHTc47iAzTci+eUKfMe7Yk5S6boPFYaun4Nw8Cj6VGXRjEg9o9R0uaL/GLS8NfVoW+SX0Nm/54ffdD1f9XAA3p98EllxHMINYs2f3ofoyfoGIthwcwap/9qyaDqfY89mJIqSxGBQUFD/sOx00tKQ+n7UD64DiomKAgU0EPwoWlMX0/sGoQKtH2pIjwg9VkLjsxF1gOvhwgeSQOuiRI0f/rb93UlzixgXdM7pwgzNAehFbwTuq9k7n5qBr4/lWQWyQMqi/W0++qmyrkGzHPuZBPtDEmUBGDRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(83380400001)(66556008)(66946007)(38100700002)(82960400001)(316002)(54906003)(66476007)(6636002)(478600001)(110136005)(2906002)(41300700001)(8676002)(4326008)(5660300002)(8936002)(53546011)(2616005)(6512007)(6666004)(6506007)(6486002)(107886003)(26005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVU2SS9pUHBsVFYwS21iWmNsc3JTRk85K3U3R3JwRFZUdlo5ZFpLSFNQYUV5?=
 =?utf-8?B?emRHd0dPNVErYWxYNm0vOEVDN29lTmxSTmI0Q21GRzB4b3pWVEpaRjV1aEpF?=
 =?utf-8?B?WDVqcjBhMVh6YXFEQ1E2cU80aS9RMnhPUGQ3MStpTjZnSm90UURIQzR5Tm45?=
 =?utf-8?B?ZDczS09KU2djYk5mNW8zZFpSZkhmNUw0OUc3WmZKNEhaWW54bkI4My85bVYx?=
 =?utf-8?B?Ui9MbUZqRWNTMEdwREtYSEQ4SDE0Wm1GU2JZeGhoL1JFaERwOFdnRTdlaE9E?=
 =?utf-8?B?ZVNRTmkvbWhrN3JoUVhscXRSOTZCV012WGtDRkNMRVY3Q09TZFFydGFXS2ky?=
 =?utf-8?B?enB1bHNNVnJXRy9QVTN4VmJwbldjMGZhNCsyUEVGbk1NRzA4L2JFdmJGQnZy?=
 =?utf-8?B?QksxemtyeS9XeHc2eDlYTVB3SFVrUmRGWWI0YmNjbEJUaGxvdkxFNVhFNXhq?=
 =?utf-8?B?ZTdXMlFsS1UzN2RJT3BvZCtrS29pT0F5QXlkZjJTS010RUs4eWRXb3lpMnhk?=
 =?utf-8?B?anZUUG84Q1RSMlAzclF3bS9MWllSNDE3eHAycUpGWWVyUlBqYkpQaGtSWmNB?=
 =?utf-8?B?bjc0SENJS3F3dnExTkN0UnBYUXYwbjc2ZEdrbUx2QjZ3VnhDc1BoREI0d3hK?=
 =?utf-8?B?VEYwS2tDZHlzdmk5S1pWMTJGZFhUNVhGVVlZOVJFY08zRWp0S2F1d3lxc0pZ?=
 =?utf-8?B?cWJHRzFxdkNIN2JQdjhjeG9CbkJNUjNoeTdpTzNyeDBtMk5SbjVlYWI5eUFD?=
 =?utf-8?B?UWdURVYvZk5YRGZxOW9qZzRDUkVmL0NwNm9Ob2dnSXU4anB1dWs2VmFSc3d1?=
 =?utf-8?B?UERiRDJsMHN3M3ZEU1VMQjZzS3VwUVdCUkdOVTFCY1JQVE5ybCtXcUI1SURv?=
 =?utf-8?B?cVh5WDdlWnBxWmhNNmZhZExKRjBaNEZPYUFwZFJKL2tyaTBIV056UmtSMWJv?=
 =?utf-8?B?QjVPekFPSmpaM3VaTTcvQ1dBaU9hNGo0QUJ3WUtnWU1DbGdvL09uZldJSXEx?=
 =?utf-8?B?b1A2RlFVK3o3OG4yY2diaXpER0EwUC9DaDdkYzc1NWNwMGM5SUo2V1dYRjB4?=
 =?utf-8?B?R3pMZXZFbHZEdlNtRDl6MjkwM2JHSWV2VWxGcnJiN2JkUVdyZVRub0VqbG9P?=
 =?utf-8?B?VExoY1o4cUM4MVRJVkdZRzJjM3lHYnErNCtzOGRic0Rxb3FEclVTbEd0ZUI4?=
 =?utf-8?B?YVZCSm5yeWFTSU1LUnk5UUtjUmp3VEFHVjJhdU9JWkdJN1FNK3Z1bUlKclV3?=
 =?utf-8?B?YkNhaTBuM2pTTklRQXQwSEQrQ0FXNkdLc0JXQlM4QkNwemZLaS9SdU1wR0lh?=
 =?utf-8?B?dHJZUnNCMlE5VU1aN1Bud1RoOU5vZkZlYkMyRWVnNXVOK20zZWFGd1BteWVM?=
 =?utf-8?B?MTNWQ01PVHIveUczeldwVWJHZmVKcThQY1R4UjAvWEltT3J0UlYwMCtGOENU?=
 =?utf-8?B?MlBzd1FrM0dFQTNSZ2xGYkU2VmJZSlI0QTcySW9TQjlmRmNyRlNKbTh1NC9r?=
 =?utf-8?B?b1pwQ0VFeXlsREQvRHNKbUtLZzJCZlpaSmFPcThsY2xWa0pqN0dzeWJManNX?=
 =?utf-8?B?bVpKYStVbVBHNGYxWTJKWWw1WHJXbHo0SHp5MTd2RlA0RjY0cFlDb050Wng0?=
 =?utf-8?B?dDd2SyswRklpcFZud1FvRXcvMnVTUklDN2VkMUpjVUMwV2RSWFlzN1Q2ZVJI?=
 =?utf-8?B?b3RzL29GN1VyMDVBK0s4ckE0RlRacUY3NlhSWG5pbjBWQ0RabGdpYXhOelRx?=
 =?utf-8?B?QUtnOGVJV0pidWo2NHNFYVlCMnFVbXJvN3hHcmE4bVpiV0tuS0MzTkVUUmdo?=
 =?utf-8?B?cTdkdkVDNE1MdE5LOUtVQ0l1UFJwcndzLzJ4UXZEQ2Q4UlNubUVGdW9KNE42?=
 =?utf-8?B?RWhma3FxbFUybEFRblVVRitheWZ6WlhMTmZSQlFFcmdPK2IwVzVNZ2R1TmpL?=
 =?utf-8?B?eDVFTU5sajRLUUxFNEc4SkVjUHNhK1R0YWt0OTJ5M3RuYWk2TDFhWUhSMWNN?=
 =?utf-8?B?QS9IeXhPcUd2NDA0TEh0ZHB1Y3hCTVdZUjlzTE9ZTmIwdjBsQXNZdnM0VFYr?=
 =?utf-8?B?RFptZXY0SDhxZjJodHVtY2VySjVYemNTdVYzelBDYlFOeHdFNDhEV1BrS1I3?=
 =?utf-8?B?OTFOUkgvTHNubk9ZV3pOWkFtVitTUUE3aHFDMVVKZXFQRTY0Uks0Tm5SYStr?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bafa07-d149-404c-022c-08db9fe71e95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 12:32:00.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XwD31XPHacwqrDZoX3H+TLqB/ZBhodVi6xnvN2sYOhqZj89oTILgfcdlQWmSJ2YSYZxpVKf1NsByJawMD+pua+Djqmja/JlWO4myc5g6oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 13:10, Leon Romanovsky wrote:
> On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
>> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
>>> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>>>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>
>>>> Users want the ability to debug FW issues by retrieving the
>>>> FW logs from the E8xx devices. Use debugfs to allow the user to
>>>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>>>> Reading the file will show either the currently running configuration or
>>>> the next configuration (if the user has changed the configuration).
>>>> Writing to the file will update the configuration, but NOT enable the
>>>> configuration (that is a separate command).
>>>>
>>>> To see the status of FW logging then read the 'fwlog/modules' file like
>>>> this:
>>>>
>>>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>
>>>> To change the configuration of FW logging then write to the 'fwlog/modules'
>>>> file like this:
>>>>
>>>> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>
>>>> The format to change the configuration is
>>>>
>>>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
>>>
>>> This line is truncated, it is not clear where you are writing.
>>
>> Good catch, I don't know how I missed this... Will fix
>>
>>> And more general question, a long time ago, netdev had a policy of
>>> not-allowing writing to debugfs, was it changed?
>>>
>>
>> I had this same thought and it seems like there were 2 concerns in the past
> 
> Maybe, I'm not enough time in netdev world to know the history.
> 
>>
>> 1. Having a single file that was read/write with lots of commands going
>> through it
>> 2. Having code in the driver to parse the text from the commands that was
>> error/security prone
>>
>> We have addressed this in 2 ways:
>> 1. Split the commands into multiple files that have a single purpose
>> 2. Use kernel parsing functions for anything where we *have* to pass text to
>> decode
>>
>>>>
>>>> where
>>>>
>>>> * fwlog_level is a name as described below. Each level includes the
>>>>     messages from the previous/lower level
>>>>
>>>>         * NONE
>>>>         *	ERROR
>>>>         *	WARNING
>>>>         *	NORMAL
>>>>         *	VERBOSE
>>>>
>>>> * fwlog_event is a name that represents the module to receive events for.
>>>>     The module names are
>>>>
>>>>         *	GENERAL
>>>>         *	CTRL
>>>>         *	LINK
>>>>         *	LINK_TOPO
>>>>         *	DNL
>>>>         *	I2C
>>>>         *	SDP
>>>>         *	MDIO
>>>>         *	ADMINQ
>>>>         *	HDMA
>>>>         *	LLDP
>>>>         *	DCBX
>>>>         *	DCB
>>>>         *	XLR
>>>>         *	NVM
>>>>         *	AUTH
>>>>         *	VPD
>>>>         *	IOSF
>>>>         *	PARSER
>>>>         *	SW
>>>>         *	SCHEDULER
>>>>         *	TXQ
>>>>         *	RSVD
>>>>         *	POST
>>>>         *	WATCHDOG
>>>>         *	TASK_DISPATCH
>>>>         *	MNG
>>>>         *	SYNCE
>>>>         *	HEALTH
>>>>         *	TSDRV
>>>>         *	PFREG
>>>>         *	MDLVER
>>>>         *	ALL
>>>>
>>>> The name ALL is special and specifies setting all of the modules to the
>>>> specified fwlog_level.
>>>>
>>>> If the NVM supports FW logging then the file 'fwlog' will be created
>>>> under the PCI device ID for the ice driver. If the file does not exist
>>>> then either the NVM doesn't support FW logging or debugfs is not enabled
>>>> on the system.
>>>>
>>>> In addition to configuring the modules, the user can also configure the
>>>> number of log messages (resolution) to include in a single Admin Receive
>>>> Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
>>>> means push only when the max AQ command buffer is full). The suggested
>>>> value is 10.
>>>>
>>>> To see/change the resolution the user can read/write the
>>>> 'fwlog/resolution' file. An example changing the value to 50 is
>>>>
>>>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>>>
>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>>>    drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>>>    .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>>>    drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>>>    drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>>>    drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>>>    drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>>>    9 files changed, 867 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>>>> index 960277d78e09..d43a59e5f8ee 100644
>>>> --- a/drivers/net/ethernet/intel/ice/Makefile
>>>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>>>> @@ -34,7 +34,8 @@ ice-y := ice_main.o	\
>>>>    	 ice_lag.o	\
>>>>    	 ice_ethtool.o  \
>>>>    	 ice_repr.o	\
>>>> -	 ice_tc_lib.o
>>>> +	 ice_tc_lib.o	\
>>>> +	 ice_fwlog.o
>>>>    ice-$(CONFIG_PCI_IOV) +=	\
>>>>    	ice_sriov.o		\
>>>>    	ice_virtchnl.o		\
>>>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>>>    ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>>>    ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>>>    ice-$(CONFIG_GNSS) += ice_gnss.o
>>>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>>>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>> @@ -556,6 +556,8 @@ struct ice_pf {
>>>>    	struct ice_vsi_stats **vsi_stats;
>>>>    	struct ice_sw *first_sw;	/* first switch created by firmware */
>>>>    	u16 eswitch_mode;		/* current mode of eswitch */
>>>> +	struct dentry *ice_debugfs_pf;
>>>> +	struct dentry *ice_debugfs_pf_fwlog;
>>>>    	struct ice_vfs vfs;
>>>>    	DECLARE_BITMAP(features, ICE_F_MAX);
>>>>    	DECLARE_BITMAP(state, ICE_STATE_NBITS);
>>>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
>>>>    	return false;
>>>>    }
>>>> +#ifdef CONFIG_DEBUG_FS
>>>
>>> There is no need in this CONFIG_DEBUG_FS and code should be written
>>> without debugfs stubs.
>>>
>>
>> I don't understand this comment... If the kernel is configured *without*
>> debugfs, won't the kernel fail to compile due to missing functions if we
>> don't do this?
> 
> It will work fine, see include/linux/debugfs.h.

Nice, as-is impl of ice_debugfs_fwlog_init() would just fail on first 
debugfs API call.

> 
>>
>>>> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
>>>> +void ice_debugfs_init(void);
>>>> +void ice_debugfs_exit(void);
>>>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
>>>> +#else
>>>> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
>>>> +static inline void ice_debugfs_init(void) { }
>>>> +static inline void ice_debugfs_exit(void) { }
>>>> +static void
>>>> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
>>>> +{
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +#endif /* CONFIG_DEBUG_FS */
>>>
>>> Thanks
>>
> 


