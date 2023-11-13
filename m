Return-Path: <netdev+bounces-47480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF797EA681
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0BC1C208E1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CB2D63B;
	Mon, 13 Nov 2023 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5X5Xo6q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334E2D62D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:00:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD071B5;
	Mon, 13 Nov 2023 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916422; x=1731452422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QnZKX7dwjJbHtu+LNs/FUaDwFYADBntY9EiVslQX19c=;
  b=O5X5Xo6qGhdXOmBJFH7TPagNcFhhPwVh8XMfE1T9Ej4hZI4SMjXeBCsx
   VKbMN0JFoYPGv9i9ySW46mMEAWqPAJJDq3tDU8dK3DCx9qFU3ATNi72qp
   VjvlfSL7SCEAaiTo2CU2tRBkvH5DdiqIo1vpVxiXqp3Zg+EGrlH/DdKGZ
   gsyF/vMqVrPC2U0jURQyx6HZUH9SnyRG6Q1ct9bxdc9XZu59QCKOR9jtU
   GuIWe7pB/Ayp7uY4lEpUaqm6X6fzOC6PHO7HPdMpY/tZArJKYrLuERWJG
   vNpKwEgFDkP5iJXor76846V8gzqq0cKlGixT46fe9B9Ia89eAqYpuDlgw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421632379"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421632379"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:00:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="881823077"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="881823077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 15:00:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 15:00:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 15:00:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 15:00:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 15:00:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHhX7LdPGM1kmNaSbsBTrCwJj+TaQLoUaZ/ktvcLOCJ2AUmOp7L78POlmYpMuiPXng/FN9Y0b8aBTgCXXwLPokPNPi6/JDNntzfq/YKlrnH4cXgECKJUUQ2FK3xG4k8+m9lNqOp+wycg5NmBa6O2j9s/dMyTnlQEF4m+2ka/YVYIjzvFc1bZ4ioZp7vBy5bjEPvQmcWKRvrIU5Fpg0AJ/vYA0VKR8w9pvdDHLseyTzIGUaLgS1LuHoZ0LmYr08vw7SNLW0Het1sGRB5zRqvb94RgzbemxupNYdIY+QZ4LrXyIXsbZAZHofhPAKlTb2Zq61Scn/gHVtADkKMn1ynR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bRiwCZQG8D4+4bSDdOrgVDnEOlNNi2ZzmAuSAl6Bg0=;
 b=XIK7cBfFnfDjV7KQva/y3Fgmcll77+drIqPR7xXMw+9wWKfmLYnaqyvwCc/74eZ3LhPO1Kx6jvciPycHe19K4WeEEvhHq33V3wk2kgzvjkDhYC1YYSfCUjehG6+hikvq+F623uUmKH9nvqK9QnVzhkHsEY8BQGBvwhwGF5aem0GiD+Ay31TgNTqlAvzO77MIsjrdlh8mMkkJWRWMpFR6TuNzDN4ydXoy0moEf519/Dagvj1BF3C/1uJzKPR15a39KcqFiwlyThKe2XpRmgj0V/LbtNzypp4+7j46lwx0oVtOfZ4taZoF3JFNdL3vrDvD0iDSGmdG6CrLAVt45mrUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 23:00:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 23:00:18 +0000
Message-ID: <490abfce-47b6-430c-8fc1-99536284c1a6@intel.com>
Date: Mon, 13 Nov 2023 15:00:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 1/1] ptp: use extts interface for the
 measured external offset
To: Min Li <lnimi@hotmail.com>, <richardcochran@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Min Li
	<min.li.xe@renesas.com>
References: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a8ee9b-275b-4666-f835-08dbe49c4e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZlO2zE5L9NIVtqBLGjOVbXBmTz+uqDBXKIYmieMHlpEwWQ50xdJk39VDB0MCQsu06SjcpHi+ROSBjAgkq+uBBc9GnDobiyC9p2ZYBOOa63T4Wdmu8tDK34K9ak1B3gh45qP/CzjqOmTRF5U10IP+Ce51YDKfZ790LmHSuRCNHppMO9IvDUCu7hraYPd5BWyddy2j9CJuk/CtoDQaOQcd6KlulYMb1fJnNLF2+fX6CKoJlm1HLG/wiIf+1C9376HEtsp+Qjjx++l9BsDm4/GZ5DI199B+WP/zjYFU71vFLAPmFJ/U4eL7G4uAcxOnq0Hd8AdsNTR8paUAvSY/DNcL/YU4uwOC3ARNyT1DefM1zFIKtgAvV4XZwuQuYnyIYQkE+O0SZLKnzuar0ueQidrnRLV8XW5PDkixTiQ2Tq9iQGu3s91jckqJQI/5DkmEcI7ZTHKWfUYiDRiPZKu/PHr0OwJGprG9RFGZ6olkVdLPCekHwC6uMKdZ1OfxwQEgPGfGaWV/ahxS/rardoZxMVuT3kdtvMuME2w3743OAkoo8ndgtFzQCQbTI6N++A9goEWyMtpS6rh6q/meuxfocq20SUTHf5Nz+LBUfS+NRPo7L2s7u8wcX36xlQcg/CPt0BsTm1v2EplGTnMUnvWXa8U9e5wQsDYIFP+RqxHDsFepOZ6cbK4AUEWYpUeyzx3qjAD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(64100799003)(1800799009)(31686004)(66556008)(66476007)(66946007)(31696002)(316002)(38100700002)(82960400001)(86362001)(36756003)(83380400001)(6512007)(26005)(53546011)(2616005)(6666004)(6506007)(4744005)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlhML1FJUGJJZkJjRHBNUEtGTGVsYU5JRTFIa2IrU1REMklCc0FlRjAzRkZU?=
 =?utf-8?B?RVI1Ymo3Z0V6ZlpFNHQ0aVlENTlDOTJIRk91VXdwbnlJSWpSaVpaam14UlhB?=
 =?utf-8?B?UEhrYkFZVUpyMnB4WWNNeTFyQnZPUEMzQnBjTDBjcW82cmtIYTR3emVRckR5?=
 =?utf-8?B?VTFuTnJaMWRXbzFWc2VTQU5OTjgveDB5RWpGSFliS0lhbUorSEJHT3hIUHpQ?=
 =?utf-8?B?Ui9WdHAxdVI1VVpDdFZjeW0vTUlWQXRVc3ZuU1NFQXE4UkZ5MjAxYWNYOVNz?=
 =?utf-8?B?OU8raHRhb2NyVzF5MHI1dGloOVFEUGdTSmRUTSt2YmRkaXYyVW9jUm5ibTZJ?=
 =?utf-8?B?WHR2eDdpSERTWGI3VDY4K0ZGcFhaQkJMSFR1anUxN3hQbU4yTVRHY25YZzhz?=
 =?utf-8?B?alFsTnptd09UMmlWQ0ZTMlk1RDJmMUJjL1IyUWdIbEViam9wZFJBVGk0WHdt?=
 =?utf-8?B?SmZvOUJ3czhjdEpUeVE3ZERONjdtMEZWTzVZa1l3OU1CU1M4NWR0ZEFZcGNn?=
 =?utf-8?B?MXk4MHZDOWo2Wmx0RUJhaVdjUEhGUDZ3ckZDTXd5NmJEUUNJajl5VzBaMHJz?=
 =?utf-8?B?UllVdnFscUNGNEFtWmloNnFNU3RXdWtYWGhrTjBFNGdRN09sUjhjeU15dXVx?=
 =?utf-8?B?bzltWnkyWkl1RjBNTkMzKzVKT1hONGpTTkc5UDljR1pTeStSZlV0QnVRZENq?=
 =?utf-8?B?UUQ3LzM2Wms0VlB6ZWN6YWZZbHZBajN6UG5VT2tadFlMNk9nckpQelFkMXB5?=
 =?utf-8?B?NlNrYW5LYWxGZk0xVnYvSks2Umg5UU93WU4wcllBc2tlSDEzRnYxYnJUS1ho?=
 =?utf-8?B?MUlGakY2R21SWFdsN3pCdDhON01mOC9BRDZTVWxvdEFqQkE2QlMvNzZDRnpC?=
 =?utf-8?B?M1ZCWlJudTE5ZUtEcVdvQnhjaHFtbVJNTStGQkw3OTFnYkRlWVovamtHQkND?=
 =?utf-8?B?WmdsRnFiOFV1OS9wUlBRY1hIb21tOVgvMkZDT0dSa2p6OTFJY0xWQU55UG1X?=
 =?utf-8?B?cnpZUHF0T01xeUtXOUs2b1prczFPcGJ0Q010dlJ5b3NYdlJMVy9jV2h1NVMw?=
 =?utf-8?B?L3dsZ0NQRDR4VDA5VGpaQzJEV0JTenNWd2RBdk11UWVoYnFPQ2FNUkgrNmlJ?=
 =?utf-8?B?ZlBLWGQvVW41dWNkMzNtWXZOakZIdEpWM0JxNUhNSFp2SDZ2RDByVWxaTk9X?=
 =?utf-8?B?Z285Ny8rSklYb3NSakVyNHFrVWV5d1RBTzZvbWFxaHJoMFFCNHpNNDRPU3dC?=
 =?utf-8?B?d3FjS1Z1bUlDQmoyK1hLa1YzaU90ekNaVEpWZjlFcnIzMVBPVlFnWHU3UnU5?=
 =?utf-8?B?VXJzT1BCSE04WnBXRzlnaVhKMTRCMkFQdlpaUUdOcXkyNml6amV6dSt5MkFX?=
 =?utf-8?B?b3RQejhJS2hMcXpkTkZnZFowWGNUL3Q0dzZPcDBEc2IzUDVuODVIUmpTdlRz?=
 =?utf-8?B?YzJTMnhoSEZKSnRoNXcxS1QyTGlIMnlod3RBZGtGYWV1UzRTV20vMVRnMU5I?=
 =?utf-8?B?b3RPV25MRitLQVZZenVlK3k4L2U1akh0ZmJuSkN0TUVMOERMMXlEb1FPeEFJ?=
 =?utf-8?B?T3JaVUZtUUFsanpRR09kUUdiN2tXRlVCRlFpVlhMdjNGYWdXcWVRdnFNdGFL?=
 =?utf-8?B?TE1yK3FmQ082OXRTTFEzMnpTa05GVzR4a0czNnl1WXNnV1BFbHBaZW9nclpy?=
 =?utf-8?B?czJVUzByZ1ZKNWU2ZnV2cHo5b2c0RW9aUmN3L3d4QkQvZkwwWlFsTGE4ZXcw?=
 =?utf-8?B?Qzd6R2ZuejMxNSszUjIyRVJUYzNWZ1hyUmZxNzRpMzZXSWYzTW4ySkFMRERx?=
 =?utf-8?B?dE5McGc5bjVycDdIdUVVcnExUG0xU0F2ZWswcXV5NVhMbkk3YnBJWUgyRFVO?=
 =?utf-8?B?bUpQM0VBc3VPb3l3SGc1TmpmVmhSSE9Mb1NSM2phOXFvUGdjV3pYb0dNU2p3?=
 =?utf-8?B?VzUxOGNRNG45NXBKdXUvek5LVzBEWUtKdThsK2dQWmhBWXlHRnFHOHNkSGJm?=
 =?utf-8?B?WGVyWGxaSkR3WW02UkNVM2pxZG9JN3MrbjczWEZvUWlPVEJGOExPdlp4UlhZ?=
 =?utf-8?B?WCtFOU1XdDN1cWlySCtQYnJiQW8rd3RDTDVlQ3dWZmVBR3JzWG03OW5UbWVo?=
 =?utf-8?B?YmxkRnJheDVLY2hTRDlrRTJNZE16dlR2cmE3c3UxYjVRK1hma28zNFhDbWxU?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8ee9b-275b-4666-f835-08dbe49c4e50
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 23:00:18.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+B4ES/VADHTxsJ3Sugg+jZgWJ9BW+5xdlxpos1bojOQqYIjoaHQC5KSHj5CWMPA0xG56TXU+sy6pUpFCU+7MybOQkPJp/G0Aew3Ds6IeWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-OriginatorOrg: intel.com



On 11/13/2023 1:50 PM, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the
> phase offset between PHC signal and the external signal, such
> as GNSS. With this change, ts2phc can use the existing extts
> interface to retrieve measurement offset so that the alignment
> between PHC and the external signal can be achieved.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---

Ok, so this adds a new event type "extoff" which is for eternal
timestamp offset, and it allows reporting the offset instead of the raw
time.

Userspace can request this feature via the new PTP_EXT_OFFSET flag, and
drivers will report it as a new event type.

You mention GNSS, but is there an example or a link to a driver change
you could provide to show its use?

I think the concept seems reasonable and the code seems correct.

Thanks,
Jake

