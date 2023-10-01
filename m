Return-Path: <netdev+bounces-37231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D277B4575
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 07:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B4490282515
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215288F60;
	Sun,  1 Oct 2023 05:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175D17E3
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 05:50:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02394C6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696139413; x=1727675413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wJDwfzQBdOnCqbCHzTsPSU/wHVpR4c8schtlw5OgE90=;
  b=CeRTcQ5HPQtoG4VW3GJc7S1nJdGOQTBqya9qysZMAQpR3S8LTLDzwGlR
   cyqYCghjG7nnMt7zKWtC7UysUCsB+ZBpmmMIYavedSO5AdZhybf2Z9KT0
   dmUN7ZAXHhzf8MSlf2yMSn8LIcnYgd0R4RqftqeSNCex75+YqGOHYKca9
   U41m4d2WTJebFmWjTX58KUfVJYYfw3WMEn9Qt12YjgRf7PsNOqqvP48xh
   b/B7eB0w2Arm31T3pvAj+6IlVH2xOiA4y/iUQh0k0dBWggARPq8vGwE0N
   Qp5XXBOdgSESXiov81A+BGXozKIRtnb9HigcJXit3h6oWGHRKeMcDHC+R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="381374285"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="381374285"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 22:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="997305265"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="997305265"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2023 22:50:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 30 Sep 2023 22:50:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 30 Sep 2023 22:50:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 30 Sep 2023 22:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV893Y7sCBjSFM4tHGWC9761fKN6redmtCo8aacoPnV83sFOAZvuuUOCadrkCvtNzlUS5u07b/C3naGllO4x6U0XG5ioDU1ItuWl6+xjlZPnkXLmNWuzJ9hFbBIMfaY6XSQOiSGCjHQFDPNod/h0pDAtSo8Q3XQsZcr/WGsU05AzSu0ghv9fF0VgRNW2LdHhY4+1U345HxHaxlUR9J16kpME9P+TEsibo1RxorAYEDZTRxtuxJifVW48JWh9hbHVi9ThvJyZs5FIad1Ea9ObEnJBLK1rOcHjh2L3lt1ekxZLGthLcknutmrhpztR+hFqFMrRJ7Yi4qc71lSsmaudDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjGDMv7aBCioPXAAIYUfYPPi9u0MjNVvvokv3Zf0XJQ=;
 b=oNUWr6tvjwgEKL/J4haLm9WGUBYay7SiVywptcXfUOfTYTcH+ivkQP1avLxf4AjwJ6frYrnijdZbTGjXBnWlyzp6ot+YKOIE8zX9anG9H2MR/E1QesrQY9h1qHyKD1RMWvVDrg9ZUyGxMpf7CHvUUlHp5Q+bwcjhRksjhwNkDmt8lsy+OZ4St+H5EqTwkeMqau+KCdyOJrVbyBbsNka+yFOIu69DsDwO8dgy0x/iHv7yXtx7ptDbpd23b853Ed5Rxm6MLulhx9vblcT4xyfrVQzs3G21fnFBkkIp7ljma6iMbBcZab3r07hvumZkEBiWWszig3d9cL9SfD6Bduyx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18)
 by DS7PR11MB6079.namprd11.prod.outlook.com (2603:10b6:8:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sun, 1 Oct
 2023 05:50:09 +0000
Received: from SN7PR11MB6725.namprd11.prod.outlook.com
 ([fe80::a06f:fff0:8cf5:7606]) by SN7PR11MB6725.namprd11.prod.outlook.com
 ([fe80::a06f:fff0:8cf5:7606%6]) with mapi id 15.20.6813.017; Sun, 1 Oct 2023
 05:50:09 +0000
Message-ID: <8577c007-556f-4fca-8b74-075399223f06@intel.com>
Date: Sun, 1 Oct 2023 08:50:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Prasad Koya <prasad@arista.com>, "Andrew
 Lunn" <andrew@lunn.ch>
CC: <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <dumazet@google.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <20230930161748.GD92317@kernel.org>
From: "Neftin, Sasha" <sasha.neftin@intel.com>
In-Reply-To: <20230930161748.GD92317@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To SN7PR11MB6725.namprd11.prod.outlook.com
 (2603:10b6:806:267::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB6725:EE_|DS7PR11MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca662a8-d036-4309-0eb0-08dbc2424584
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9sNpMbewS03X/m0+6TNKo9c0H8fBb3ybBsP8lmKI8hYvcalvx6ipzAEcfK0HsN17wcalPi3MT6UhpZre/Fkn5q8zYOZqRlhOEyzPmMqn8DzLuBooXhkRaOrsdE16GmkT6ihDE6aAGdNeeyHKqqV/fbWwkCod098OwzG+xSRyNrBVNnIkPsN1kUj+Z7qLNMDEvtKCC8fdddEgM9MbvN+biSHDikv5zB7DpWAB0Yd2E47G3vQMEFWG9A0QZDdsP4d9k2g9COcar9EYtRF+t6ZdNMfOQw+rhrSb/ldb/74Wq/WwrB6xnW6pOyuVsOggIAwHZczd6XfIyI/CZbNuBz43APEe59hj+Jp4nGzoytIXrATYq0UgxyPIccKK0KroH82m186nzsldW1RZn+coUoi+SrbIPUvn6YtfECKiaKR6Ss9YCQF1XbJktIZjuLPHxJZ+VorbbR5hjY6aqMH8FlmPcpsegJEHGaM7G0A95ypPkPApMLnPST41t/AH0H9MGJQYkR/BzscU+69asdNCjriflij2pmU4Z1Scn1JQ5MH5HpkGSV2s+ayXahI5xQtwj5cjqOwUSsady3da9kWyfAvhZcnVHm1bXqr9xspaF2TK4NMjnneHRookIuUJZCwSuzTIBXAduy0yIbzwC7D/JIL6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6725.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(53546011)(6666004)(5660300002)(6512007)(31686004)(8936002)(8676002)(6506007)(316002)(66946007)(6486002)(4744005)(110136005)(66556008)(2616005)(66476007)(478600001)(41300700001)(4326008)(26005)(107886003)(86362001)(36756003)(2906002)(38100700002)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Q0ZnQ3cm9YRnNzcElNSFZPWVZqeTZ6U3hURnBlVFV6SDhiZ3ZxbHVLUDRR?=
 =?utf-8?B?anduYWRWZlIxOCs5ZkNISXhHZzY5aEpDaGNUNnR6cmsveVIyWWYvRUFrcXVl?=
 =?utf-8?B?MjdDTGRjS3RhVEVRMVFRc1JXV3MvdThGaitCQUQ4UElrWElCeU1naUNKcGlV?=
 =?utf-8?B?aEtmNE5SKzJHL3N3OXVOZDZYdWhQUEFtV1hrcktYRXhIT3BSTXQ5SDdJaW14?=
 =?utf-8?B?a0lGZ3VsYTlwTExmSVVoWkRuK2NjTllSSkNBRmpiKzFqVXQ0SzJNdGV2NWp6?=
 =?utf-8?B?TFJjWHNpTUIwOC9IMDVFSXc2eDBiWG5sL3ZaSFpPT0NYVExQMzZpeVZ3VFNC?=
 =?utf-8?B?VFNQbjRpMk1qejVEZGxyNVVVT1A1NG1HYm1QM2REc3JMYmR2OW9IQ1lVbi9y?=
 =?utf-8?B?WmJEZ1Q2THlwMm5tdDJjVmhhdGdaN3RCeHczVGQ0b0ZNMnBabEx2ZnY3NVhS?=
 =?utf-8?B?UUhsUmVteTNybWp6bjJvd0tMeCtFRW9kV04wY2QxMm9tbCtJRFFsb2MrTGNV?=
 =?utf-8?B?d3RMY3A0M3BKeWZ4UXQwYngxdjNsZDBORHZqejRJMWdRUGJDNHB3cVltY2NX?=
 =?utf-8?B?amlpUkhwazB0U3RIS0NLM0FTRGtWZXJwNFR6WnR6c2YrcjdkRXRNY1o1dGh6?=
 =?utf-8?B?Z0xRK2NXTWFpWVREaDZjVWo3djI4M2MxVzBhaWtSMHlFNnliOU9KaDZUMGZ4?=
 =?utf-8?B?SHZiWVBYd0VOTEZmanJIa0U1VGcyVjZac3Y1dGZxZmlSVHJFNnhiemlIeFNU?=
 =?utf-8?B?RFNOQVBwSWVSUDh6ZUY3MExmTmp6ZlAvRUNZS09sM2JjN2VGa3lyU3UzNmpQ?=
 =?utf-8?B?by80bTVFdzkvdERNclhqYUVCZkNoNjAxUy9oeVVCOHF2Sjl3b0Y3MEVFYmxW?=
 =?utf-8?B?NTkxZmVtWnJEM3dNQ1IyZkxkTWpuTG1RWWVpL0daL0EvVk1kWHQzL3UvRU1y?=
 =?utf-8?B?UmRzUUVkOU4wNVIxVno4VVVBOVlmeUJZMHZnM1duOTQrS20wSzZDUjlxbVZH?=
 =?utf-8?B?NjZHbEdXRXJscWN6UWlOc1VWL3hpZWV5NTNMRVY0bklGV2Zxc0lNS203cC9w?=
 =?utf-8?B?aEtlYmltSW9XbDdvMDcxekorbDBhWEZCUyt5eGR2RHRSMkd1YTB6Wm5kdVdJ?=
 =?utf-8?B?cGZUaktEOVVuRW1nUXJsbTFFMWc3QWs2MEdVbGVkNkthTTB5K3ZPaDJNb2No?=
 =?utf-8?B?VWVXbk9GT1JVdld3dG1LbUsvVzJmcmEvd2QvYm14Z0NRM1Q4M2ExRWpycW1o?=
 =?utf-8?B?MFF5ZnQ1T2xFYWgrKzhKdno5TksrVWFnV3lhcFVWTkhEQnF5aTY1a1lkUHFK?=
 =?utf-8?B?dGx1VWROTHhXdzRpN0xtenVxWWtNRnFaMnpvSkZESVVaRzd6NHZXWEl6WXAv?=
 =?utf-8?B?NjZXZzBlT2w2THA2M0wyeGhsZEFhWjV3Y2t6dmhLbTBtRDlKWW5GQTlvanYw?=
 =?utf-8?B?YmpSSmd6M3g0Wm9raEZxM01ZVDJzcks2WFpacnFUak1zZzlLNjRQWjM4YzZY?=
 =?utf-8?B?RG9qenlqRytjbVk4bE5xODlYYTlmUEhZcDRSTkhxQWkyalU1UC9EL3gxblo4?=
 =?utf-8?B?cDBEaDdEUVpETnZnaU9RRG5CQUV5eGlDZWhhNkdZUURwV2pDOEdPK1Q4dlRq?=
 =?utf-8?B?bUJrVi85TGNvOUV1RmtVNXFsVmlPRFo5dzhIQXVGNW1DTUNwMzd1cm9zcS9L?=
 =?utf-8?B?akFKa3h5ZmlUNmV6QUF1cm1TUzNjcnB6SE02R3NSSnVHS3hiU0JTTElFZ2hY?=
 =?utf-8?B?TlJsSjhVYzAvWGw4WFdnSjkrWVhCb2NDMjVCTHJOZ1VUdmFiV2xNZ2NYWmVH?=
 =?utf-8?B?amhIUjJsbWxoU0pBTlV6K3hpekhkSVExakVkanhwcloxRC93elFIc0VpeVgx?=
 =?utf-8?B?WHB0ZEtZU21iS1dBTittdTd5ZkduVlZlWHY2SGhralk0TnlGdEF4QlRzUjdz?=
 =?utf-8?B?U2puYnFnVU1QUndIcFF4aDBDcWgxNGpGakdZbGF4K1I3ckx1VFFkRUk0WmJw?=
 =?utf-8?B?dXBnZTJWYjdjSVZ1SC96REFCd3FndThtM09KR1ZWbGZMamNWdUFuSGJ6M3FQ?=
 =?utf-8?B?ZEcwbzZ6L1VuK0h1Z3YrVGxZa2IzaWdQWXo4L3A4Y0U4dUlUdXFyUlRRZGVn?=
 =?utf-8?Q?C5yOuCGGkbE8HpErQAqLDAG0O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca662a8-d036-4309-0eb0-08dbc2424584
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6725.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 05:50:09.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGm/9KOQO3nO2IbJCFnqFAhuw2YXAwyKEY8ZLfDswLi+tlE3OGr1qK7xT9EN6Pro+rplS3UUElkJ1PXOLHjmqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/09/2023 19:17, Simon Horman wrote:
> On Fri, Sep 22, 2023 at 09:38:04AM -0700, Prasad Koya wrote:
>> This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
>>
>> After the command "ethtool -s enps0 speed 100 duplex full autoneg on",
>> i.e., advertise only 100Mbps speed to the peer, "ethtool enps0" shows
>> advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
>> when changing the speed to 10Mbps or 1000Mbps.
>>
>> This applies to I225/226 parts, which only supports copper mode.
>> Reverting to original till the ambiguity is resolved.
>>
>> Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and
>> 'advertising' fields of ethtool_link_ksettings")
> 
> nit: I don't think it is correct to linewrap Fixes tags.

Simon, we decided not to recall this patch and will submit another one. 
(resolve 2500M and TP advertisement ambiguity).

> 
>> Signed-off-by: Prasad Koya <prasad@arista.com>
> 
> ...


