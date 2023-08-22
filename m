Return-Path: <netdev+bounces-29539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B729E783AFC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FF01C20A8F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8B79CC;
	Tue, 22 Aug 2023 07:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884188462
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:33:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B065133
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689611; x=1724225611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKmC/8EFROJ0mvU/ItRBiNNjb3OxX3hdcra9AapCwZo=;
  b=iAKBPYqdexlUsQ/vEvRRvB4m/Sdc9DRtNH2k9N6d8RzSDcB7LUbOeZsK
   qy33jLy+VIefL7XBDOKFH+qxiiMzeAroc0hJk85Ek5nVJGLFxDuQql5jq
   bc82A7c7lA+c/2lbRVhjyJFaqOP9BTq3bZFGf4RXj32Eq8eGGWwzmTXvP
   ivfgGKSDDcKPHdGzDpsdu4B8elTtwkzp8A5nLhnhuwuAVRNMyyi7CIdaK
   fjTG3FyuIq0lD/T2cc4q+L82lPH6k443vowhMtReT4ms9N8ZE8dcmNrSi
   JBsuoGatshQBgNoA0JEMpJ0XK2xGMiWMTJSjd/ymVtj83ADbhLCxScj97
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353376524"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="353376524"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="909997447"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="909997447"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2023 00:33:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 00:33:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 00:33:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 00:33:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 00:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPYaYcm4XswCkBGqPWfC1qh2em2cO/T5yINbOOCjxFhzeWy0SXdoB/UbbCz6t94h6MI4WRlC9uEJj7p0zj845P8d6+ilCV0Ln2uVCPEIsiyT2dAumNrDvcZVW5WnwQ2HY8ifVzU9nOYp3lF0a0EtdsSOZr7zAYOb1o1pzd7nDsyrMEW7ZPRtJ30bSKoj4DEN1baPBfVsKSIN74ksOw0b+5DqwSgKuRgrRpw0iOLfNwzXnZX2/53Guz3IK17MeFhHFrk2VIzybO1KdmU4UK7RwH+14d5kNX4L4q8XKbzS52LASGy6x5Nr1nI73OdIeiam+4RVtjpYKOy6xt9ZXl9sUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gdofYuhGc7Vq6SXn2xi4i5eyl9+jlkX5EdANCnPobA=;
 b=Pmo2l/Dy8jE/Tmsi0nPrKf71DxqLog3hFglRln1OR4WjAGS+ikW/YOclZp0kVftCtN+Rrq8DTUVWrBCeEQm1AB6dyiF/1CdpX67axYZPwh52e08kZmWw/5MIjKmM/X9IGsou1bZqY/eG7SHdDGFsKLUDYSCGxhTaB1EPDGS7o5oNlzGQElC8IFlUsOw87Gjx552UR7lm/wi8VOFw5DnMQFnT+uAJYhThAMC/x2H+Q3K9OxZ4ieKGkL2EGVDm4fDlbul+XleK9YS8oMyuVclDffF/rIwIo5J1iZl2denNt3lUgL4oyvyzYMQvxOYCHw17Ahe2uyQgPHBtqdUwdf9NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 07:33:24 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:33:24 +0000
Message-ID: <e6eff1f0-97a2-5581-1a86-22d863578c1b@intel.com>
Date: Tue, 22 Aug 2023 09:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, Leon Romanovsky
	<leon@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>, <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
 <20230818111049.GY22185@unreal>
 <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
 <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH3PR11MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbc19c7-5795-4d5f-578b-08dba2e2117f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChWT5IYW+5rzMhAC6Of+CrUlMp4W7ysj81jAwc+IokH5fVhVSbXDiBQhLDH3tE5eRlI03vHppjqmlIY2wiaNCsg37s0mOka7ba2qhSp2j+irmt7CTfMB/ZTyA6uc1ss70izOA3BNi9HtHVaG4ZxJTolmNcMPXqrZJU/z/KOURhypcdXWi36f5qJebHzDgwgNxopZwQDNgoLZBQgNw9pJ1M2/b7feDYzKlFSQ0qvCoIQCuVeMaENwiiVAr3Ye8Wl/n2p/MyPKEKWGhYbBFa/zE27QEa6HN9LfznPxZFXXYz9Dub8wG9FSGk6u+IYtYJgjFCDI9nixlGGqRBms8to2GMyoM0wqK/nNzl4HONwSNRqH6nTS9AfkX2whY5E7EL6sU/RQpWJttNktsPRH9DGNYR/JKXfQGjj5LkdSSIcTqdgV0X7zCYCqhlSgJvdOCb5RWain8/mn5SFRjSYKCzXaNmHZlr52Zfy3W31sC/6V/PAUETwkE4HF3Pr0Bq5TkPRE0dmbnXYuFcxJwvUMR4TPj3m6dZd7N5ipUL0H860iLzIgsnmFE9vzlZwkP+ZlOUhJqSZ2mLfKnqQhjaQqIKc9hp6mXL+dSo2geaGjetDlSu9BHsiigSvHRrZ3XS+9zUu0+bKBfIry8MQjARHd/0X0jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(316002)(66946007)(6512007)(66899024)(82960400001)(110136005)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlOYzZaWUx6VWVTb1QweGJjS0VERHNreStmRDduUWJYSlg2b2JpbHJzMGxW?=
 =?utf-8?B?NjM5WEhSNzhsMlhaYTVuUVh5NjFaMVlOZjRVQnVvdmNRWTBzY1FRQWoxZEJD?=
 =?utf-8?B?UDA0dWQxNCtQakxMV2ZvQU5EdWlVZUt0RC9NbVVxeEtGMVpRT3FVQ3BKSkVY?=
 =?utf-8?B?eTQybmwvL3hnQy94a2xSZFo4anpqbEViM0RMRllQaVliY2psMVg1UUp1M3gz?=
 =?utf-8?B?WmYweHNydjNMYnRRa0JOdmljZU5WNlQ3TnNRTktUUWZzaDFiRGgra2JkbDlM?=
 =?utf-8?B?U2lyeXJWZ0dwZVZPRkpXdEdsQTVEbVZZcE9HYUh3dEl5RWUrSnFGdzJJWjAz?=
 =?utf-8?B?SDg0RFlLRE80TjUyNWw2ZytpNkdGMXBLQ0xPaytLVWFKTzkxV0ZYcDl4aWxk?=
 =?utf-8?B?dkQweFhEaDdpbHZJcThaQU1GOS9wa3pPRXJKQ2pKUHE3eXFvT2JKeUV6VTBG?=
 =?utf-8?B?ejU1bnBmU091MUpDV2crQzFHYVFQclhoSVdNcXZENkEzWXQ5bnVvM1ZOWmsy?=
 =?utf-8?B?U0l1Q1FzMXZ5ZkdxcXkxZlJPYm9ObE1kU216QnFzck5neDdoR2drTUFIY2ky?=
 =?utf-8?B?N3FJWmY0YlBoUWFKQkcxd3BqQmFaL2drMjFPTWhVNmErZEgxSllDeWU1TFox?=
 =?utf-8?B?UUhuSkdHeHFjZ2NGazgxM2lmbWo4ZVp2cmhuaVBMVnRvd3VJNXI2eUxLMXZ6?=
 =?utf-8?B?SjV0ZkZySXVXWVhFQmJhVGozRmdxYzdhTHJNVDVvT0wzWjIxckVkM280MGRy?=
 =?utf-8?B?azUwU1ZDWnprcVNjUjBKWVZ6LzhNUDEzcVgwNjlWeU1SVTQ0UVRYMnJVLzlD?=
 =?utf-8?B?bzVJZWN6Zms3ZnVscjdpWDZwSnMxRURFUkM2Z0dUU1lQd3dZVXU1SklyS0pR?=
 =?utf-8?B?ckVLM28rd0FGalV5MGFMUjh6MCtYSVZWZE9GVUFOOFRjWHVVMm9CN2p6eHRw?=
 =?utf-8?B?UEovVTFWekNDQ1JlZ0tKQXpKWVZhRkE2emNLUmEvVkhvZndYeDhzdWsxZnZL?=
 =?utf-8?B?YTV1aGRKTnlpblZNMEpMYnpqZEFsS2Vqc2xmNmROV3J3K0lvZzR3N25mbEZP?=
 =?utf-8?B?WXAveUowcm8xNHZYVkFqVTNDOUc5R0Q2V0R5NDh4OW03QkpiTjdQVHIyMy9R?=
 =?utf-8?B?RVk2MUFKNjNhWlZwaUx1L3dyYUdoOTdjZzRpRUxIb0hTWUFXbjZsYmJ1aDRU?=
 =?utf-8?B?cHk1alY3ekY3U0FQUDkvc2xBK1FYZ2M1U3VpZ3NnUERrWU56SU1qa1JtMzdm?=
 =?utf-8?B?NUxFTUM0SUZvT2dXTHZ5TmdmZU82SUZqQllReWVxbUcxMmkvdTUzb0VHZm80?=
 =?utf-8?B?d1pnb1hVZUZnRjNJeXJXWG5Vc0MyZ2pSdXo0OEpqcDJNRmUxdS9zUGk2cC9P?=
 =?utf-8?B?VDIxWEQySVFISDBKaEJ4OVhZbGsrZzgyMmY3em5XUi9ubnlqcmdJaEhSckN0?=
 =?utf-8?B?a3dlbGFKQ2ZUSERKUFZhWFR0Q2I4TUUzK3RIQzVURjlyU2xmNnJZUUFtNmY2?=
 =?utf-8?B?bVg5aVY2VkZMOFVRZjJWSzdUQkRzdmxuNjV4d241dTJkalJXeXk1WkQzQjhI?=
 =?utf-8?B?MWwxTHBPVkttV3JpVHBtR0JNYUlnemdJRExEaG00Qnh2RllDZUhaTkhWN2ND?=
 =?utf-8?B?R0RLSCtpVEI5UzhKSHdYaUtTVmYxRjQyK0kzL1A3WW1oS3FiVnR1N0wzcTJC?=
 =?utf-8?B?cjZtYmNZanhjU1I3cjJsQ0srYTBtWi9nbWxtSkVIam9rZVNIRHBBSW03aER4?=
 =?utf-8?B?cW9OWkxCMDBGRTIwa0RCVDlkdEM3NHhOZGNJZy9CaFdoa3I2VG5wVW5TOGJG?=
 =?utf-8?B?Q2szS3dTOEttWVlvN2ZhYVVDSU1jTzVqd0NKdFBDTHE5WWU3RG5jd1FMeDd5?=
 =?utf-8?B?TThhNlc3SStmMFdycjJsNTF6MjNBd3FkUVZQMXBVbVczRzliVjZ1VDZGd0ta?=
 =?utf-8?B?cFZwbWk3ekJoK2dJa1hvbXlOb1lCZVRmdWdGTzdDbWc5TlFWbHhLcjNUNUxV?=
 =?utf-8?B?ZlAxWlp0UHBnSFB1K3QrcmZPWkJzUldVNHJBeTBCVG1EWk55bUY4Y0J0UThr?=
 =?utf-8?B?TnJnbkdxRDJZNTVoa3VJSmVsMU9sQjkrdXBGTHIyRjVWNi8rMHNoaFE1WnRP?=
 =?utf-8?B?eE03YnRhMWNreVRHdlRxRTYrRmdwZHZoaEJqU05DSFRYam0vVVFxb2p0bGY4?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbc19c7-5795-4d5f-578b-08dba2e2117f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:33:24.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq7V479fk05rjX+u0IlIC0Km9Av8/+HI9lFQ8tj7+gCIeyEke04q7A1EPg2GSch78UzpFEjvOW57Kv3HM2YgQkUnLNWbJxOtQEmWng3SsbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/23 01:20, Paul M Stillwell Jr wrote:
> On 8/18/2023 5:31 AM, Przemek Kitszel wrote:
>> On 8/18/23 13:10, Leon Romanovsky wrote:
>>> On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
>>>> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
>>>>> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>>>>>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>>
>>>>>> Users want the ability to debug FW issues by retrieving the
>>>>>> FW logs from the E8xx devices. Use debugfs to allow the user to
>>>>>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>>>>>> Reading the file will show either the currently running 
>>>>>> configuration or
>>>>>> the next configuration (if the user has changed the configuration).
>>>>>> Writing to the file will update the configuration, but NOT enable the
>>>>>> configuration (that is a separate command).
>>>>>>
>>>>>> To see the status of FW logging then read the 'fwlog/modules' file 
>>>>>> like
>>>>>> this:
>>>>>>
>>>>>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>
>>>>>> To change the configuration of FW logging then write to the 
>>>>>> 'fwlog/modules'
>>>>>> file like this:
>>>>>>
>>>>>> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>>
>>>>>> The format to change the configuration is
>>>>>>
>>>>>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
>>>>>
>>>>> This line is truncated, it is not clear where you are writing.
>>>>
>>>> Good catch, I don't know how I missed this... Will fix
>>>>
>>>>> And more general question, a long time ago, netdev had a policy of
>>>>> not-allowing writing to debugfs, was it changed?
>>>>>
>>>>
>>>> I had this same thought and it seems like there were 2 concerns in 
>>>> the past
>>>
>>> Maybe, I'm not enough time in netdev world to know the history.
>>>
>>>>
>>>> 1. Having a single file that was read/write with lots of commands going
>>>> through it
>>>> 2. Having code in the driver to parse the text from the commands 
>>>> that was
>>>> error/security prone
>>>>
>>>> We have addressed this in 2 ways:
>>>> 1. Split the commands into multiple files that have a single purpose
>>>> 2. Use kernel parsing functions for anything where we *have* to pass 
>>>> text to
>>>> decode
>>>>
>>>>>>
>>>>>> where
>>>>>>
>>>>>> * fwlog_level is a name as described below. Each level includes the
>>>>>>     messages from the previous/lower level
>>>>>>
>>>>>>         * NONE
>>>>>>         *    ERROR
>>>>>>         *    WARNING
>>>>>>         *    NORMAL
>>>>>>         *    VERBOSE
>>>>>>
>>>>>> * fwlog_event is a name that represents the module to receive 
>>>>>> events for.
>>>>>>     The module names are
>>>>>>
>>>>>>         *    GENERAL
>>>>>>         *    CTRL
>>>>>>         *    LINK
>>>>>>         *    LINK_TOPO
>>>>>>         *    DNL
>>>>>>         *    I2C
>>>>>>         *    SDP
>>>>>>         *    MDIO
>>>>>>         *    ADMINQ
>>>>>>         *    HDMA
>>>>>>         *    LLDP
>>>>>>         *    DCBX
>>>>>>         *    DCB
>>>>>>         *    XLR
>>>>>>         *    NVM
>>>>>>         *    AUTH
>>>>>>         *    VPD
>>>>>>         *    IOSF
>>>>>>         *    PARSER
>>>>>>         *    SW
>>>>>>         *    SCHEDULER
>>>>>>         *    TXQ
>>>>>>         *    RSVD
>>>>>>         *    POST
>>>>>>         *    WATCHDOG
>>>>>>         *    TASK_DISPATCH
>>>>>>         *    MNG
>>>>>>         *    SYNCE
>>>>>>         *    HEALTH
>>>>>>         *    TSDRV
>>>>>>         *    PFREG
>>>>>>         *    MDLVER
>>>>>>         *    ALL
>>>>>>
>>>>>> The name ALL is special and specifies setting all of the modules 
>>>>>> to the
>>>>>> specified fwlog_level.
>>>>>>
>>>>>> If the NVM supports FW logging then the file 'fwlog' will be created
>>>>>> under the PCI device ID for the ice driver. If the file does not 
>>>>>> exist
>>>>>> then either the NVM doesn't support FW logging or debugfs is not 
>>>>>> enabled
>>>>>> on the system.
>>>>>>
>>>>>> In addition to configuring the modules, the user can also 
>>>>>> configure the
>>>>>> number of log messages (resolution) to include in a single Admin 
>>>>>> Receive
>>>>>> Queue (ARQ) event.The range is 1-128 (1 means push every log 
>>>>>> message, 128
>>>>>> means push only when the max AQ command buffer is full). The 
>>>>>> suggested
>>>>>> value is 10.
>>>>>>
>>>>>> To see/change the resolution the user can read/write the
>>>>>> 'fwlog/resolution' file. An example changing the value to 50 is
>>>>>>
>>>>>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>>>>>
>>>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>> Tested-by: Pucha Himasekhar Reddy 
>>>>>> <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>>>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>>> ---
>>>>>>    drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>>>>>    drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>>>>>    .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>>>>>    drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>>>>>    drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 
>>>>>> ++++++++++++++++++
>>>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>>>>>    drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>>>>>    drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>>>>>    9 files changed, 867 insertions(+), 1 deletion(-)
>>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/Makefile 
>>>>>> b/drivers/net/ethernet/intel/ice/Makefile
>>>>>> index 960277d78e09..d43a59e5f8ee 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/Makefile
>>>>>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>>>>>> @@ -34,7 +34,8 @@ ice-y := ice_main.o    \
>>>>>>         ice_lag.o    \
>>>>>>         ice_ethtool.o  \
>>>>>>         ice_repr.o    \
>>>>>> -     ice_tc_lib.o
>>>>>> +     ice_tc_lib.o    \
>>>>>> +     ice_fwlog.o
>>>>>>    ice-$(CONFIG_PCI_IOV) +=    \
>>>>>>        ice_sriov.o        \
>>>>>>        ice_virtchnl.o        \
>>>>>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>>>>>    ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>>>>>    ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>>>>>    ice-$(CONFIG_GNSS) += ice_gnss.o
>>>>>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h 
>>>>>> b/drivers/net/ethernet/intel/ice/ice.h
>>>>>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>>>> @@ -556,6 +556,8 @@ struct ice_pf {
>>>>>>        struct ice_vsi_stats **vsi_stats;
>>>>>>        struct ice_sw *first_sw;    /* first switch created by 
>>>>>> firmware */
>>>>>>        u16 eswitch_mode;        /* current mode of eswitch */
>>>>>> +    struct dentry *ice_debugfs_pf;
>>>>>> +    struct dentry *ice_debugfs_pf_fwlog;
>>>>>>        struct ice_vfs vfs;
>>>>>>        DECLARE_BITMAP(features, ICE_F_MAX);
>>>>>>        DECLARE_BITMAP(state, ICE_STATE_NBITS);
>>>>>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct 
>>>>>> ice_pf *pf)
>>>>>>        return false;
>>>>>>    }
>>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>
>>>>> There is no need in this CONFIG_DEBUG_FS and code should be written
>>>>> without debugfs stubs.
>>>>>
>>>>
>>>> I don't understand this comment... If the kernel is configured 
>>>> *without*
>>>> debugfs, won't the kernel fail to compile due to missing functions 
>>>> if we
>>>> don't do this?
>>>
>>> It will work fine, see include/linux/debugfs.h.
>>
>> Nice, as-is impl of ice_debugfs_fwlog_init() would just fail on first 
>> debugfs API call.
>>
> 
> I've thought about this some more and I am confused what to do. > In the Makefile there is a bit that removes ice_debugfs.o if 
CONFIG_DEBUG_FS is
> not set. 

That's true, and it is to prevent 450 lines of code, and some includes, 
so makes sense.

> This would result in the stubs being needed (since the 
> functions are called from ice_fwlog.c). In this case the code would not 
> compile (since the functions would be missing). Should I remove the code 
> from the Makefile that deals with ice_debugfs.o (which doesn't make 
> sense since then there will be code in the driver that doesn't get used) 
> or do I leave the stubs in?

other option is to have those few (that would be stubs otherwise) 
functions outside of ice_debugfs.c, I didn't checked if there will be 
any dependencies though

> 
>>>
>>>>
>>>>>> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
>>>>>> +void ice_debugfs_init(void);
>>>>>> +void ice_debugfs_exit(void);
>>>>>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, 
>>>>>> int module);
>>>>>> +#else
>>>>>> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
>>>>>> +static inline void ice_debugfs_init(void) { }
>>>>>> +static inline void ice_debugfs_exit(void) { }
>>>>>> +static void
>>>>>> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int 
>>>>>> module)
>>>>>> +{
>>>>>> +    return -EOPNOTSUPP;
>>>>>> +}
>>>>>> +#endif /* CONFIG_DEBUG_FS */
>>>>>
>>>>> Thanks
>>>>
>>>
>>
> 


