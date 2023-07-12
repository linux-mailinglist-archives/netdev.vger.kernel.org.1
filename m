Return-Path: <netdev+bounces-17265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E77750F13
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FB11C2100D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B6200DF;
	Wed, 12 Jul 2023 16:56:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768214F7E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:56:35 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5C136
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689180994; x=1720716994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=olyG2/tGIsHIfVRrcbU2F0hfUuTBPXFd21ireZPdt+g=;
  b=FKeoz+edNd4B+0wuT6oYUP1+zaidkirfpPqps5njSW8N1GlZk353zxsO
   rPj5/w62/V09tigNJ95tMOkzoW+2vlrAMM5+bxma80TW5+PCuv9NHIHdp
   XhmdE26klOn1GXEvsxTQPUsv7IfXU79G2pcT8bu99y+kneXmytZSD0H8R
   Q3+pZkpuDTpAH6WBZK3pBdvFHLhNtu9Fv32QTswdC33YPIHX4G8hibCJX
   okCcurjZsL8YwUh5opt1sfbkiNCNhf/uXSDHemdiYAsvctxC2thdd7wue
   khIouR6d0PkbYsF/WD7sipB3Cm6/B5vom8k/QgH0BGpsY2JYIwdLfgfl6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="364976667"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="364976667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="671941184"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="671941184"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2023 09:56:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:56:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 09:56:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS51U+D5U6ymsFFxwhbU+uuBrPmzRBtM5MLczjwd6Gd0CYOe6Iy+LKyjIDzDy0ujJop44AbawbIhp2B5ZlADV/51SRvwM+e34hSYA8K73BgV78V+1pxcLfK7vJNWKCveqq8MAZz9ou+WK+n1lGkDuohToxEPfdC5JzhflFn/eIusSL9jNNnqe9NgxYwT4gt5EmqzgkicHhygfsqc8WYzIhbr0GB3fCsNzZlw4kSLhH3lD2yKhexSLokOYbDcl1T64FHlDKEUJ4tPEmStPTUT8XDPKgpTHgBGQKwLWYKZBnDLYnKCI91l26O/k9sP8JcAaShhll/ZIDfbptSMiDboSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCXW8igSW/8rITUdoQFcYcHZVNOM9xu8cmQYcHJsRAo=;
 b=Dje2zEZyU10jTZiwAfZrJMQiEBOkzcRXH3m3nqAw2RMH2ABTsqMTQ1KQY+utZ9+rn5h7NAwnn1cL1M0GCY8nAe8j8hcES3xpiWmtFWKeFnUMRB6dSmYZo0IVCwfCXIG41Q+jfizfCKGXlVQYad3CsNnByvhYf6yfmiD05ADzmTtcjdmB3JuerfxI1rP/A+S/VSp7RQm1sXDRdqoSIgoX11xNrcWre3HSYUf9vLmmbTspUdpF0QsE7RHv6cAuLHXXSGbbd6HUJqqEd0kXcUjt2ifZ8lAnUuTiJv692MaRUEX9loJ5cuebMpgRNyz/G5TBaMW3tO0nX9KfPsFnBHN0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 16:56:07 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:56:07 +0000
Message-ID: <8f71d459-85bb-87c2-940e-aa1c36308a11@intel.com>
Date: Wed, 12 Jul 2023 18:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] gve: unify driver name usage
To: "Wang, Haiyue" <haiyue.wang@intel.com>
CC: "Guo, Junfeng" <junfeng.guo@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jeroendb@google.com" <jeroendb@google.com>,
	"pkaligineedi@google.com" <pkaligineedi@google.com>, "shailend@google.com"
	<shailend@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"awogbemila@google.com" <awogbemila@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yangchun@google.com" <yangchun@google.com>, "edumazet@google.com"
	<edumazet@google.com>, "csully@google.com" <csully@google.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <b3e340ea-3cce-6364-5250-7423cb230099@intel.com>
 <BYAPR11MB34956FC76E48D37CF146A657F731A@BYAPR11MB3495.namprd11.prod.outlook.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <BYAPR11MB34956FC76E48D37CF146A657F731A@BYAPR11MB3495.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bc6a67-ed53-4742-3c61-08db82f8e27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x63lS8N1MueN872sObzKwhJmk0PQ7hmH+GNbQFcM7HNpg5XlQu09HG8YB44z1tezKXtgGhejxDTh3EfXsJS4IK7a/dTIvAyhBfMWFKwok23sasK2IJzSlTvg5gibJcgzN4B5fIvxsAqh3150tjP/3tP14sFqCuFSTTt865q1ZHdiH49QTLlsDGkYdY0Twr0Sn/1+VqQp9Ul9SG9DeCLwzWVzgqE7AU04XRFRhaTbGkrDyeqRVS5WgWJ9XSHd49GB9MamrTuF8wdFfA2HXNhrybCWmcLTC9EPNKSzwkXVnbvjNlW031KNKSczShBkzYpTrawVPTp5dTW5PTS+3XyhkHGvZRu0Szy82xTw9dNiwtk0zfTmzA9+1qu034Sv9ubZmWpN4Zdb8SO6Umoub0cBk74ZI10dEU+X8EVvIThOo+A7VkA4eYaq4I2PrG5dC6nCXBkZwAoGGqYGM6YsIusCXOGqkF4Obji2z9HUEsXv75X3KjuULHrM+Zqp1iZcsqbiU8zYZy//BN5A2jAJeGCXGqo0DQz3yaAI5Yj+Z/q2oCFkYAFmkRPdpDA+5z7YjVIH/pifDWUH6ItTTxrrNGFYN1n3wwY3FCJ5NH9k3cbEzE7UcAhMbfUlzbJ5f1k3A2Resw7wgX1KBM3U1n4DxRw15wIBMRPKE5zM3U5S+AklBEBSqMm/pA6ZWLaBocE6QHsN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(38100700002)(31686004)(6666004)(6486002)(478600001)(37006003)(54906003)(26005)(2616005)(83380400001)(86362001)(36756003)(31696002)(2906002)(66946007)(6506007)(53546011)(966005)(186003)(6512007)(82960400001)(8936002)(6636002)(5660300002)(6862004)(316002)(7416002)(41300700001)(66556008)(4326008)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhHQkJqMDdUeFp0dkRsMHJwc2VJaXhjb1JNT0VSZjIyTjVtdlZ5UGlEK0d0?=
 =?utf-8?B?KzFJQWRQQllwZE5qaGZaT2xkYXAxUVE0WUVLVEx1ZzFkL0tDem04eGpFQjlR?=
 =?utf-8?B?WjR4VXJ5UTFybXpOd2poYVRFVXAyQ1REZHoyTUYwaXZqNlNYaEQ0cUFiZEJx?=
 =?utf-8?B?SWtBZkcvWHBvbExkdTVISHMxMDFnUzMySExDbzl6MW0yR3h0ekpsSlZsQXJE?=
 =?utf-8?B?SkpjVFlDOUd6V0loSXRPQXo5Y3RRdDRqUFJSTFZKVFkxd1Q2ZHEwdmUzNlpB?=
 =?utf-8?B?bFBaUDh6OXpvTG9YWjduREdzVU81V0czR3ROQmVGb21vREtZNStnOVQ5YVNn?=
 =?utf-8?B?T3RDR3FTYTROVkVDQTNJVldaWTUvWkJjRlVVT3YvdTVhaWRkTC9qSFlaWUty?=
 =?utf-8?B?VlAvMTdSZDhQcE8wTlVVU1QveUJJaGs5cmZnQjUzZVNaTjFoOGljU3hYSFJH?=
 =?utf-8?B?MjY1dWQveERlWWQvYlVCcFpPWS9oQVI3T1d1OFhHQUR4dXBZbkVzNVdxWlZP?=
 =?utf-8?B?U3lPaFJvQW9iTHVlRkE2c0xRakQxVGxHQldTZmxmZjlzR0xFZ0pjT050Y3h2?=
 =?utf-8?B?eUU0MlRRK0FrWWlQbjdVRXdWVTBCRnhud0gvMis2RUVZc2UxZ3RXeTF2UzFP?=
 =?utf-8?B?WDhYcm9xMEZzRERBTS9lR1lhZ1RzTFVZQjMvTXVPY3JtZkJCb2hLWjNIdnBX?=
 =?utf-8?B?RFBodGxnbWpzK1VEd2gyMk1YL0k0VmVHa0JLZGhSL1BoTVBzeW1VWFhvUk5H?=
 =?utf-8?B?RXdpZThkdy9FOTVCNGlJeDJnbnh3eCswR1Fwb3hoek91ZnZKazVYWGZDaGxo?=
 =?utf-8?B?WFl4UEJ0S2RYU25jSW9rUHhaRmptd3g5VGpRYWl2cmlxWk5yNUQwR3JGVmRI?=
 =?utf-8?B?L1lpYTlIRldQd0wvclc3cDRTWElzT0k2R0FpYmZ5U2RISUl2c2ltN0d6eVRh?=
 =?utf-8?B?SDgrNEhTZ0Z1eWRDSm05Rm1EUTZQWnl1aVhTdWVzN0p4Z2JFaloybGFnV3pL?=
 =?utf-8?B?Q054OFZ2aFRyRkJDdUovd2lZK202TGI2em5jQXlxNUpWUjFoL0JEQlJxRkh2?=
 =?utf-8?B?ejJ3WHQ5WDNLbW9KbjlHZ21aanhrLzhTMTQrQ0p0Q0dBSWlSRmxqaHF5Z2ZQ?=
 =?utf-8?B?endaSHpsTVJvTXNQWkxQbU5wR1BLRWZwV3hQZzJXK3BSQktHV0prQ01pcFRH?=
 =?utf-8?B?R0pZMXNlNEI3WmE2UElQcjVUY2hoajFLUEpIaFBLR1l1dzJjVVJJRFQ4RHdr?=
 =?utf-8?B?SExETkJvSXVpTDROQ1FxLzJjZ1gyZ0xiTTh1MmtWWjJDV0JvZmRmWHdlckhj?=
 =?utf-8?B?TGtsVWNWWUdmN0hucHljRkRydDk4a2UyUkJIYThYa2EyWE9Hc0U4OElDSlFm?=
 =?utf-8?B?Q3piMzhqVGl5VGdZNkxkTmV4TjR2cEgrSUEwbDF3MjBlR3lGM3lsSnBxU1pE?=
 =?utf-8?B?S2tIR0IzOVdrbngyMVNKVS9qNnNpM0Zaci96M000NEhJbk8yenM4UkVLMWRo?=
 =?utf-8?B?Q3ZOa2xHMVg4eXN3MUluWnJFd0k1OFVIK3NXaDllaUt5RHN0SkN1dGxjZENF?=
 =?utf-8?B?Y2hXK3FEemZQUzNlUTlEMkZ1RitDV3hESzV0R1FtbjJJb01UZC9YZkRNU3Zu?=
 =?utf-8?B?ejRMdC96OS9iMXZxeEFZRWtWNnphQTduckZuRW1Genh4NVJuSWdPSDlISGh6?=
 =?utf-8?B?YVNSbGp6WXhjNENYTTBLcXkwZkJ2U1JXbjk0VmRHY0pwRk1kM3BSc3Vqa09J?=
 =?utf-8?B?eVUybDN5aHQ2UDNDVDFSM1E2eDBVWWVncDhNa1lLL0JmZ1lpcTBEMUVyQUxu?=
 =?utf-8?B?SFdIeWJNNnVYTWtaSTZUdDhTRmtoajJVZkpGdi9LSTR0T2l1ZlFxa1FIcms0?=
 =?utf-8?B?b2U5L1FiL3kvWlBiR2Erdzh2RE9Mak00T2N5cU1DeTVBNEFxT0g0a0tsWlVG?=
 =?utf-8?B?NUFlZHhwNkFndEV1TjlKWGcvckZzOVFKT0RUbmc4TkZDNXpNN01mRGIvcUFh?=
 =?utf-8?B?ZWxjeS9CRUoyb2RwVE5GaXU1YkxXaW13c3pIaEsyZHJhRCttTnZwN2ozaEtI?=
 =?utf-8?B?SmFWaGY4Z05lbjdhK09JWjRNM3YvVUtYSTVSTGxFczEwOWhaK2hKcGFOaXhO?=
 =?utf-8?B?TlI2NVlOTnIxWk9YUnBNNnVYUkVsdGZsSTRpakpyM25KZXRjWkRqMERnWFk0?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bc6a67-ed53-4742-3c61-08db82f8e27d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:56:06.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY1prXHB1qCplifRa5FHBLVAfzjX0s6vj2w1StGTf5B95fSFAArjDinyIRUcQPokVndRkZzyZEeZditxPbALzfOSM+z/hZfrGMbjvm9w91E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Tue, 11 Jul 2023 19:24:36 +0200

>> -----Original Message-----
>> From: Lobakin, Aleksander <aleksander.lobakin@intel.com>
>> Sent: Tuesday, July 11, 2023 21:14
>> To: Guo, Junfeng <junfeng.guo@intel.com>
>> Cc: netdev@vger.kernel.org; jeroendb@google.com; pkaligineedi@google.com; shailend@google.com; Wang,
>> Haiyue <haiyue.wang@intel.com>; kuba@kernel.org; awogbemila@google.com; davem@davemloft.net;
>> pabeni@redhat.com; yangchun@google.com; edumazet@google.com; csully@google.com
>> Subject: Re: [PATCH net] gve: unify driver name usage
>>
>> From: Junfeng Guo <junfeng.guo@intel.com>
>> Date: Fri,  7 Jul 2023 18:37:10 +0800
>>
>>> Current codebase contained the usage of two different names for this
>>> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
>>> to use, especially when trying to bind or unbind the driver manually.
>>> The corresponding kernel module is registered with the name of `gve`.
>>> It's more reasonable to align the name of the driver with the module.
>>
>> [...]
>>
>>> @@ -2200,7 +2201,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  	if (err)
>>>  		return err;
>>>
>>> -	err = pci_request_regions(pdev, "gvnic-cfg");
>>> +	err = pci_request_regions(pdev, gve_driver_name);
>>
>> I won't repeat others' comments, but will comment on this.
>> Passing just driver name with no unique identifiers makes it very
>> confusing to read /proc/iomem et al.
>> Imagine you have 2 NICs in your system. Then, in /proc/iomem you will have:
>>
>> gve 0x00001000-0x00002000
>> gve 0x00004000-0x00005000
>>
> 
> Looks like, in real world, it is PCI BAR tree layers, take Intel ice as an example:
> 
> err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
> 
> 3b4000000000-3b7fffffffff : PCI Bus 0000:b7
>   3b7ffa000000-3b7ffe4fffff : PCI Bus 0000:b8
>     3b7ffa000000-3b7ffbffffff : 0000:b8:00.0   <--- Different NIC, has different BDF
>       3b7ffa000000-3b7ffbffffff : ice          <--- The region name is driver name.

I didn't say Intel drivers do that better ¯\_(ツ)_/¯

Why rely on that the kernel or something else will beautify the output
for you or that the user won't do `grep <drvname> /proc/iomem` or
something else? Or do that just because "look, it's done the same way in
other drivers", which were taken into the tree years ago and sometimes
with no detailed review?
There are efforts[0] time to time[1] to convert precisely what you are
doing into what I'm asking for. Do they exist by mistake or...?

(the second link also shows that even pci_name() is not enough when you
 map several BARs of the same device, but that's not the case this time)

>     3b7ffc000000-3b7ffdffffff : 0000:b8:00.0
>     3b7ffe000000-3b7ffe00ffff : 0000:b8:00.0
>     3b7ffe010000-3b7ffe40ffff : 0000:b8:00.0
> 
> google/gve/gve_main.c:2203:     err = pci_request_regions(pdev, "gvnic-cfg");
> hisilicon/hns3/hns3pf/hclge_main.c:11350:       ret = pci_request_regions(pdev, HCLGE_DRIVER_NAME);
> hisilicon/hns3/hns3vf/hclgevf_main.c:2588:      ret = pci_request_regions(pdev, HCLGEVF_DRIVER_NAME);
> huawei/hinic/hinic_main.c:1362: err = pci_request_regions(pdev, HINIC_DRV_NAME);
> intel/ixgbevf/ixgbevf_main.c:4544:      err = pci_request_regions(pdev, ixgbevf_driver_name);
> intel/ixgbevf/ixgbevf_main.c:4546:              dev_err(&pdev->dev, "pci_request_regions failed 0x%x\n", err);
> intel/e100.c:2865:      if ((err = pci_request_regions(pdev, DRV_NAME))) {
> intel/igbvf/netdev.c:2732:      err = pci_request_regions(pdev, igbvf_driver_name);
> intel/iavf/iavf_main.c:4849:    err = pci_request_regions(pdev, iavf_driver_name);
> intel/iavf/iavf_main.c:4852:                    "pci_request_regions failed 0x%x\n", err);
> jme.c:2939:     rc = pci_request_regions(pdev, DRV_NAME);
> marvell/octeontx2/nic/otx2_pf.c:2793:   err = pci_request_regions(pdev, DRV_NAME);
> marvell/octeontx2/nic/otx2_vf.c:534:    err = pci_request_regions(pdev, DRV_NAME);
> marvell/octeontx2/af/mcs.c:1516:        err = pci_request_regions(pdev, DRV_NAME);
> marvell/octeontx2/af/rvu.c:3238:        err = pci_request_regions(pdev, DRV_NAME);
> marvell/octeontx2/af/cgx.c:1831:        err = pci_request_regions(pdev, DRV_NAME);
> 
> 
>> Can you say which region belongs to which NIC? Nope.
>> If you really want to make this more "user friendly", you should make it
>> possible for users to distinguish different NICs in your system. The
>> easiest way:
>>
>> 	err = pci_request_regions(pdev, pci_name(pdev));
>>
>> But you're not limited to this. Just make it unique.
>>
>> (as a net-next commit obv)
>>
>>>  	if (err)
>>>  		goto abort_with_enabled;
>>>
>> [...]
>>
>> Thanks,
>> Olek

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0af6e21eed2778e68139941389460e2a00d6ef8e
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=35bd8c07db2ce8fd2834ef866240613a4ef982e7

Thanks,
Olek

