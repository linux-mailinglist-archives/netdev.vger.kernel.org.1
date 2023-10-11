Return-Path: <netdev+bounces-40028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5B7C5752
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4FD1C20D92
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319815E8C;
	Wed, 11 Oct 2023 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abiIdkFz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9D1BDDA;
	Wed, 11 Oct 2023 14:50:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56890;
	Wed, 11 Oct 2023 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697035803; x=1728571803;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QuvvH6EI4Z8bMInoFTae7QaGm8DUhlfUgpTnk/CIoSs=;
  b=abiIdkFzW3BHOl8UDFAH/OQ/gM1ma3A3+sKQ7ytoHfZLg0z8MZDy17aw
   0OhYEsBq8JO2NLCs007m39tyfh0GMmo/XYa8XHStsMytbV/SwImkEd/yF
   spnyyrS03MtskXu1EJCg9/qPCfmY+XF6l3DUvU5V00Ny4Wq3+33xS6G2Y
   xzBs9O84xjhxY3Y45kZTYaHCMkty8Y/cANJVMacDjvqeX+IIjUvKcL+SG
   hiQ9QRN8c3YEjFK/osNj1HW6MxG0EcJmSLjZx3f7Y/3150mzykjJ7oM2v
   Jxx6VOA0hikUpd40XIwYZOuQUryNSJhqSNqbJ3U55PeC0xV8MNTyJOPyV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415727489"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="415727489"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="819745999"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="819745999"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 07:50:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 07:50:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 07:50:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 07:50:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 07:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtV7sBc4Rg2NtQcRvnz+Ew+JV7gGZKsFGRtSodixSTAGBuAymr7W83t5sURfPco1p0mOxubrpKIHB31SsJHLe1ib7WkBfw9/czyACP0+wC1pXjWBHbpEm/tuhN/EFI4An+ivs1gIkBgK/huyXimRvMlFjuytG4eZ5m9lw8HzsgY1erExNOMKLJbfamX6qxHDw96aYY3nXT/ch5DbWS0dexJFWbtmuIPEqNeM5bKooqpLcW4d9KUqauYo6NuytvSZiyeRxYfehXNAEz7liVv/HWTGkuSHqhGj9VJUaL+jj3uhFCtw62ypLokD3CnaofS+pe/blQuiUlnOZtF84XzPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLzZu6Xe/W0QTcGpHDKC9DJiphCwHAiBiGQdEK3WILk=;
 b=Py0ztFCozFNh07LSaSyGt9Au7cjO9Y0OlqBDw3/GPtX6w07okf93PA4PiIB2JKr6vZuRU+UEL0B+a57JoEjZ7icqeQenLdh6F7J7RuyM0qouZ31xiE0bHARpycA0cy8pBCOILvXX3abJxEw7OOWASvBD8DHuJuJMiDGLr0kN6uBAYL6FYhnteZmOCWOssEhiAO9qa0VciAdbRiv9IkbSvwydt6LZYqSLhPj2V0QsSVig+jCpqgJUD/t8KigqTLvRRRBlD9xdtBywruY6+vPgMGYXaUqLMuxR+OFI/FyCsNhn9VKnRKMZQykXbfybOoPJvnzkokuT4sH7OVvNlsw7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:49:59 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:49:59 +0000
Message-ID: <f3b10f76-4ae2-45b0-a5eb-57e5d41804c5@intel.com>
Date: Wed, 11 Oct 2023 08:49:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<corbet@lwn.net>, <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <mkubecek@suse.cz>, <linux-doc@vger.kernel.org>, Wojciech
 Drewek <wojciech.drewek@intel.com>
References: <20231010200437.9794-1-ahmed.zaki@intel.com>
 <20231010200437.9794-2-ahmed.zaki@intel.com>
 <CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d901d9-32a3-4633-6e57-08dbca69576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGHi4I6i8dS90JS5VtpCzJJNZBwexJTyTHDTx6cztiybk1m6BjD5pjyU3SAVI+PTEhCvIY2RfXjikT7g6bWy9dsVJx4JrY0XUqvjkNca6Ve10EYDUYt4MWYYq7+yTXO2IJP1kqm+Nic0hWKw+KXl0bdfB/7JG8iyAQQQIQrQ+8wyCGnRuTWruFbL6nzB9YmmLFpZRZ5sFLodfwS1vkAZRkA5/ZtoPy6cDcHoiMW/p/awTtQ0B6UbQ+rqiXHVwQf7O86C9/iBpMfuOMZL0JP7wXLLQZdHvlIOkY+LLFMy6+g0oY2aZeJ4HqQMulEJtwdf0i76Sn5OoO/7dgwty2BHxKx9WH6FxTPzGa9TQs2aqP91xencSwM54DytI80ajop7BTGu/jSndFs0vZesBKIXI94hIBeIewER39cDXcPcUNRH4XLV9+O6iMJO17tuzLuCgYiHMRGEBL0qPz7mQ0yJ7D417dZUuIt7E3UoR1NSbZp3/oj4WHbofWJ3Oxxez2MnVU4s8lU4YboftpgtRjJcVBauFGV/JdRhq6nNCNpn1UfVU6zhAF8SydRh7EyINKjBlEQAPVF3L3BxBKkwHhJCKcb4L1iSGm7+1jjhWiMbfgW4CVk2kEPqWM9lsIl8NNyh1JjoEC79rsV9pv646Npmzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(2616005)(26005)(38100700002)(82960400001)(83380400001)(8936002)(107886003)(4326008)(8676002)(6512007)(66476007)(66556008)(5660300002)(316002)(6666004)(6916009)(478600001)(44832011)(4001150100001)(2906002)(53546011)(7416002)(6486002)(6506007)(66946007)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVkxMDluZ05KMVFoR2JkYkk5T3hTc1cxU1dPbWMvcjUvTVZLSlFqQWFBc2Vt?=
 =?utf-8?B?YTlGTjd3TXNOY3Q5Z3dTejRUbmlzdEhrczVTVkg1Ly9mYUVuZExvdFRiamlj?=
 =?utf-8?B?aHBTSy91N2taTVZKV0xrZ2lLSUJzbWhnTklWT29VM1BxREZnQzVyNkF6Vi9l?=
 =?utf-8?B?U3ZSL2RmRjMwK2VDZzhuNDc3cmZuNlhhaWJhUXNkTGVnRU5uRmJmL0dNYThw?=
 =?utf-8?B?NndWN3Q2dWdsejVCUG11VkJGWHNBWHJiaVBvZXZlN0FmTHk2OVdHci9ueFpi?=
 =?utf-8?B?ZFk3NHVLZ29yblNVZWRoZzE2Z0JsdXNOSk92R1EwY2hlWklGNXJ0R3RaNjZV?=
 =?utf-8?B?emtrc0JZYlVOa2o0TVFhTitpMXFlUVI0UGdIbk5Ea3d6b3pxMndZMFpISGJh?=
 =?utf-8?B?L3kvb0g5andpemlFbUdhMmZNbVlwRHB4V1pudEh1alZVWlQzUnI5L2VSNXRy?=
 =?utf-8?B?OC83Kzh2djlTZDVielM4bFlYaGZMUU5xRk5uTzV1RHNHTlg1ZEcvVGRsT0l0?=
 =?utf-8?B?S3JnRzQzejdXYzBHczBkcDJqWDQ0SXN2d3ZvZ0c4aTVFRktYWGhjQ2JlM01G?=
 =?utf-8?B?b1Jub01zNzd6Q09GTGFQRm14M3lNSXJETDNGNDFOR3Joc3M2eFEya2F0L2Vx?=
 =?utf-8?B?Ujljbzdtd2FGR0JGditOR2dUemprRWdVajdwbFNRdEtrTmRFY2xzaFc2SW9p?=
 =?utf-8?B?VXpVTEd5N3gyT1dqbFdUZDArVUF3UEtROEx0V2pwblE2Ykx3Nnkxb0FjZ3Rt?=
 =?utf-8?B?eUlYZVBRV3cvVjVxT2JiQlZ0NnJyZy9Uckl0cHNqNk0yUU1vcEQxLzN6VGR2?=
 =?utf-8?B?MmR6aHZYMVZtaG5rTUJmdjNFQTVmNzdyQkkxc3YvMkNhRVpaYVczSFgxY1pT?=
 =?utf-8?B?c25OcDRpem0wRkJZRmVPOUptSVhkcmUvZDZTWE84UU1VSWxaQ2hDKzFOc2dv?=
 =?utf-8?B?MlA4UmF3cytWR0FCOTY5QkxWNy9hTXZIQjBaaVhna3N6NG1yNmF6MGxScFRP?=
 =?utf-8?B?TWM0L1R5Vlp2eWRzOVFWRWErMkJBWFZJUDRicHd4N2NpWmJya3JUSmkxQ3Ny?=
 =?utf-8?B?emdZeFdZVDNGVklhdDNBd1RiZVhzV2FtRlp0Y1ZrN3BZMWltc0ZXNi9peGFj?=
 =?utf-8?B?V2plZXFZajlXbHhTWDJ5NXJ0UUZjdnowSGZweGNrMVp5RCt1RlBHU3JJaUs4?=
 =?utf-8?B?cmdmb1Z3YUNHT1BnSDdXSWpyQ1RYZ1ZWNjAyNzduZGNsWTR0RnN2Y2FFdzhJ?=
 =?utf-8?B?QTFFeFpwL0ZXWk5GVUZLcVFPam5kcWhaazRhalBEN3lRYzlBVE1DeFFKY1lM?=
 =?utf-8?B?b1NUNWtxTFRiTU85Vjg0STRETE1rMC9lU0NtL3FXbXZaMUVWUUVRSG9YWmNx?=
 =?utf-8?B?amwrdEl6VisybDZ4NmlaQkJxN3V0LzBHeCtNcm9NWnZHbVZ2UHRhck9LS25l?=
 =?utf-8?B?eER0M3owblFISEJWSzkxQ0hJeWVIY1dZRXhmV1hKKzk4WmQxeWR1OUcwTzVM?=
 =?utf-8?B?YmYvbUM3aFFwK1VGVXdoK2EvMytzVVcydjdKeUtDSzVUUlgrNWNWSmZ6SHds?=
 =?utf-8?B?UHlZWENkay9oU1IrcEgyNWdaczgyY3pxelVJS05QeVFOK1piaGdPYVlMQ2pq?=
 =?utf-8?B?TzhNUVYzeFg2VVIxeDV0QkwyNndLa0JSNURrdml0VGRqZkJSZERwMHlxOGxR?=
 =?utf-8?B?ZDIybGFpRUEzY0VmUnVuMElldEFxdEhrRjFqTnppS0xKSEt3MFdrSW8ydXUv?=
 =?utf-8?B?bjU2V093RVl1MUhxOWZjZmEvSHVUdllxZXIxQ1F2NHBITDhkU2dtYUV5ZTBR?=
 =?utf-8?B?NDk2TnZxYjg4Zm5PNVo5ZXV0dWo1MVZiVmFmdU1qQ1plOFVxNG5uRmZsdGxj?=
 =?utf-8?B?WjdRRzhGY3BONWh1RUFscDhSbWVoaWFTMlU3MGZMUXJhems4d1FUQ2VmTmlT?=
 =?utf-8?B?NFd5VFlNUTZDMVJQQm1yYzlzQkxlNHMrMVV0eWZST1RZdWFkZUROOVlqNG02?=
 =?utf-8?B?OGoyMWN6SU5nRlpHTUloWHNDaC9yVEVIdGx3VHVIZzhGV2ZVMWY4a2NteTY0?=
 =?utf-8?B?eVl1UnFBb1VpSno1UkpKL2V3QXJ1SzU4aElPTFlqUmJ6L29VZjVQamZtK0pz?=
 =?utf-8?Q?IWTqbvhODZ8qPt/WMhtHOiky3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d901d9-32a3-4633-6e57-08dbca69576c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:49:59.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvkOmHWda5le6I9COpwoCv+lVDaADKIurO6ZxRbewkwjk5PuKjJ+yvGPZBj2jS9pAdpiGpDuUaSJLJrvXBZORQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ Resend - rejected by netdev and linux-doc MLs for HTML content]


On 2023-10-10 14:40, Willem de Bruijn wrote:
> On Tue, Oct 10, 2023 at 4:05 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
>>
>> Symmetric RSS hash functions are beneficial in applications that monitor
>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>> Getting all traffic of the same flow on the same RX queue results in
>> higher CPU cache efficiency.
>>
>> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
>> by XORing the source and destination fields and pass the values to the
>> RSS hash algorithm.
>>
>> Only fields that has counterparts in the other direction can be
>> accepted; IP src/dst and L4 src/dst ports.
>>
>> The user may request RSS hash symmetry for a specific flow type, via:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>>
>> or turn symmetry off (asymmetric) by:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>>   Documentation/networking/scaling.rst |  6 ++++++
>>   include/uapi/linux/ethtool.h         | 17 +++++++++--------
>>   net/ethtool/ioctl.c                  | 11 +++++++++++
>>   3 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
>> index 92c9fb46d6a2..64f3d7566407 100644
>> --- a/Documentation/networking/scaling.rst
>> +++ b/Documentation/networking/scaling.rst
>> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the computed hash for the
>>   packet (usually a Toeplitz hash), taking this number as a key into the
>>   indirection table and reading the corresponding value.
>>
>> +Some NICs support symmetric RSS hashing where, if the IP (source address,
>> +destination address) and TCP/UDP (source port, destination port) tuples
>> +are swapped, the computed hash is the same. This is beneficial in some
>> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
>> +both directions of the flow to land on the same Rx queue (and CPU).
>> +
> 
> Maybe add a short ethtool example?

Same example as in commit message is OK?

AFAIK, the "ethtool" patch has to be sent after this series is accepted. 
So I am not 100% sure of how the ethtool side will look like, but I can 
add the line above to Doc.


> 
>>   Some advanced NICs allow steering packets to queues based on
>>   programmable filters. For example, webserver bound TCP port 80 packets
>>   can be directed to their own receive queue. Such “n-tuple” filters can
>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>> index f7fba0dc87e5..b9ee667ad7e5 100644
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -2018,14 +2018,15 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>>   #define        FLOW_RSS        0x20000000
>>
>>   /* L3-L4 network traffic flow hash options */
>> -#define        RXH_L2DA        (1 << 1)
>> -#define        RXH_VLAN        (1 << 2)
>> -#define        RXH_L3_PROTO    (1 << 3)
>> -#define        RXH_IP_SRC      (1 << 4)
>> -#define        RXH_IP_DST      (1 << 5)
>> -#define        RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/SCTP */
>> -#define        RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> -#define        RXH_DISCARD     (1 << 31)
>> +#define        RXH_L2DA                (1 << 1)
>> +#define        RXH_VLAN                (1 << 2)
>> +#define        RXH_L3_PROTO            (1 << 3)
>> +#define        RXH_IP_SRC              (1 << 4)
>> +#define        RXH_IP_DST              (1 << 5)
>> +#define        RXH_L4_B_0_1            (1 << 6) /* src port in case of TCP/UDP/SCTP */
>> +#define        RXH_L4_B_2_3            (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> +#define        RXH_SYMMETRIC_XOR       (1 << 30)
>> +#define        RXH_DISCARD             (1 << 31)
> 
> Are these indentation changes intentional?

Yes, for alignment ("RXH_SYMMETRIC_XOR" is too long).

