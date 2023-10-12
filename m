Return-Path: <netdev+bounces-40505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27BD7C78AB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E9281472
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FEC3E49F;
	Thu, 12 Oct 2023 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6YS4HCS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF63AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:36:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50677B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146564; x=1728682564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dUrF63SuorszJm81KD6fJZoM2Sy5Sr/2FdPPFkTSIKs=;
  b=m6YS4HCSBZQg2JjuTfRXuQfNLwugidR3PuvDh5ww5wn68WihSZgUJcbz
   54TS2UfF3W+5Ehd9aoo7dXqOZSvbmylNCLXn8V5FjfSZ0LH/VmWDJAQzL
   EN41krv40D7cMElEnoGC8jR0+gMwRy2B892nZ4MjJYwzNSKXKt3A3ZRQ4
   Y2HXdKlagffuR4UuDgGl0ppM4ch/vVcrTY9TLS/rm/Jq0umiJrT8Fe8Vs
   ig/dafpSMo0/SzUa0wgcKWm1MaKbkqg+seTL7iCBzCQ5c4HWwbCg2F0IT
   44uWyAxKFNh9EST5WMmKn9jVyXExCeMBgu8VXwL2w2eoIuoiNWEKvhJsv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449238646"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449238646"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731074135"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="731074135"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:36:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:36:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:36:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:36:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkXLGRrJW+kHkG9XDm+Z0YAes0sz0PNCZYxROtAZGw1IK7Yu1L7oleyHkvKnBpAyjwYVBW0YSGakPfItEcCEZ1z1Yq/HZT6BSkyRLDWLuMeLuwvzR6ONTRwWY8GwNsovR5tZ+tKc9uaRMmM3QRF+2oQdrm28CEYZRYn7LrwHdXqzvzA8sKHZR422usUSgcQItrB8Dge9FsYHuREAxtHXftYQURsPa3Wbk1UKsIyM3CByj/4Y3aqkUdc6ICCXMqTX1mmGtZRdGhb3KfLOYkjeKD6+rhVc5es1zgXbH9tfA99gVnaG075lVPYlyJzdY4uVCq2JHnbgZRYyAUlZPqHtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izPqCxTts50U8siN47pYlCzXJiQECV/6BZ3gE/53tS8=;
 b=JA7Ji1V1dhWzAq/Q6/P8UDME3pbZyGChXV0UirxujnFR1yvUY5fx4ooIE08dKl/BwqKD+bPzv7HQuPuu/lVHuhvHi9KjerOsI3dXR4OBu8Yr/Bvp2KssRWfk8eqnEGd8HD2kYh/ayvqWhdpjxyF/n5bmIBq3TlkT5s69otX/snwPBeSh9TI8l+smPPHS4WUcRs9XHleMLA2J4t3ppIAckrL6ivz8gB6qNTc2TUAL4AyKunddhSEG7/BK21qnYNB69pIQkdIJmNiNtRjeAd+3KyygOHDh+BhCxTNrgI6kSbZBElNqbivYdDMzeYBESqGjgqBR4JJGNYgmfjkZQyw3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 21:35:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:35:52 +0000
Message-ID: <9819695e-f628-46c7-9d08-bbdd9d0b451a@intel.com>
Date: Thu, 12 Oct 2023 14:35:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 14/15] net/mlx5e: Increase max supported channels
 number to 256
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-15-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-15-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ee54b5-64a0-49a8-68d5-08dbcb6b3585
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sa9uL196ZZehSU1ljGLNaAgcr7/aXElGvRXHRQ/gD2xWBwbJRrm7iUSExrG1H7RKQSoyewnjyeuY0S/nvL3SPLSPTMclcnb4S1t1JzJ8PAczZyzPDwWn00IQankHqbgBsWlMbDdLwgPdSVIOqeRK3zDiYNjZxDWfLXyHdRWZSFMAakzTDdzmlEyuQ8zDEyEUFpnkad4OY61w3rcx0/OVrQdcjyzEJCK+OM3UWFvm1HA/AM2exvlY+kqANJc6bCuFo72YA4AT2jYGPc3mPzvrZ36mUn0lLuxWh/4Cj834+tfuPnN/OVeyxwNaQ0LqpvCTg5t0zULLkHlJiCf2I1by6I1+e6hz92ofIktKtc8Js1ke7UoEgOoOQGQLbWdOyCdhY4YGZDJs1gymi9kPpvX6R6DL+CcROcamX6fyWsOIBo5i1qiYlIPH5aIUD5RfTgX1FW34Itl4Y0hhN9SnZd+jGbhjOT3BIj7R1W1UavPiwsfcgibGaIbAUvcDKSmF12d6wIGKpBoYT0LyH1l5IiZW4ZG5CYoCTHNVepOMzCafdG93UpIaJ2GuFw3P5TzwUtXjsQSaaCy5YemIATuSUMb8wPgh6kYZovbKeljmqkE6Z5B/BQHQyb0007wOzSunv7SUiiA8tkMc2Nu8MFMIfxKZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(478600001)(6486002)(2616005)(53546011)(31696002)(6506007)(86362001)(36756003)(41300700001)(4326008)(8936002)(8676002)(54906003)(316002)(66946007)(31686004)(66556008)(110136005)(66476007)(4744005)(2906002)(6512007)(5660300002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBDTWpoUU9tUjFsZTJzTjVqVHJxME5CMlo3TThCamZ1VGpGcWRaRVoxQml0?=
 =?utf-8?B?VXI3c2VEQVhCenZYVklKcDBwTmZEKyt2M1pLSXNBdXl3NUhNVVpXMHl2UWhs?=
 =?utf-8?B?WWN1RE51d2kwZkpUMmtJQStmdFN1S2VoYzYvdE0ySmJMZmVBUFZaUXRxV2Zw?=
 =?utf-8?B?Y2F4eHhXdVhydUQxS0w5SHFxK0tqRnJJd0VIY09wTGhZanBnK01ORnNoSURH?=
 =?utf-8?B?dFJpSlc0VWZLSG9YeXRxck9EcVNqV2JMeGFxWGJNaTBYc0ZrSlBTaDFBa2dC?=
 =?utf-8?B?MVRjem9JaHl3aHF0SnRmUFM1bWZRMy84OEFtRlhhaW1nSlFvMG5zdHMrQ1BZ?=
 =?utf-8?B?Yml6allNMnkzdUN6ZU5kK250M3E0cTIvbGNXeVI3QjgwbTNkQlV6V1dweVFy?=
 =?utf-8?B?bzEyOG40ZHZBOFBUSndMMlNleDNoamFGa2FWS25TWTVpUWNQNjVvQ3RRTkFT?=
 =?utf-8?B?c2JBTWVjL1l0NEFGSnBvcVl4YTJWbXM2bUV2ZkdFaDBZMjFMWVJSbjNKSXQr?=
 =?utf-8?B?SlVRMlFMM01sMUNETWIvVVlsL1Z5MEJRL211WCtiWHV2bmx2eWNONFhrdUh5?=
 =?utf-8?B?SWNhR1RYKzR5Tm1ER0VnQndiQmhvT0lER0lDSnFvTW83RVRkQk05UGZWbnp0?=
 =?utf-8?B?OUFBZlFHaEtUWWVmenZJb0xYYjFicERzQUNmNlhnM3JTUEFWRTNJbFBJQWFK?=
 =?utf-8?B?VVNnNmlkNC9QNjBQSmtEZzBJZzRJUHVPUjhuT3RpRWo2cnB5eU1adFo5YTN5?=
 =?utf-8?B?VmU0SHMvVDRaRHRoay9xeVVPOE9YeFRqVmw2N0JXd0tXTmhmOE55QXNOK1FH?=
 =?utf-8?B?K1VEN1F4V1UyTXBBcm9DR2lDM0RSbTRjWWI2bzl5SWFBbmhlZ1RFQXNiQ2Fy?=
 =?utf-8?B?RzZzNkNHanNHSXZNNXRwSnJHQ25yU0JQQUlzMHVIYjF0ckhtd0FVU216eGxE?=
 =?utf-8?B?NENPQ0JGQm9tZ1UzOTR4amFxUk1tODU0cTk4cXRLZXFEcnQrb2NwZHYrS094?=
 =?utf-8?B?TmpnMTdLcDFPYmNGeUhVY29RSnZLanBiR2FiUDVOeXVqYUgxUFg0NXBRSWMx?=
 =?utf-8?B?TE0vaEJNbzVEaXMrTlR4YVRsZjdQcUl6b0ZsalM3YmNzWGJrRjFVNFR5ek5U?=
 =?utf-8?B?Z3dDUmVGemtEVmFNdmRZY2prMktoOGV2OUpsQXp5QXExSzhBdjFnR2lEK21R?=
 =?utf-8?B?cVlKY25WWUZpQ2FHL2M2WXZLaU9KYWZDL0hsQkFwZ2ZpckNuc2VibWlZdmQy?=
 =?utf-8?B?ejVObEtvZUtlSnBKd1B2RFJ3aS9QNWxRSXpGSDFpWFRGSjMrYWd1eEU2NTF4?=
 =?utf-8?B?QVAvL0pwYjhDUk1wVFZ0cHpTY0Faczc3UDlHOEE5UjFUam5SeWt6Z3k0b3lX?=
 =?utf-8?B?TUdQMm9tUnhaUTNDOW11ZGNaV2tTL1lMaFZrZWlDc29WSjBPSUVkV0RudWh4?=
 =?utf-8?B?NUVPQkJSaUlYR2c5dktDV2J6K2xMNmd1dzFWU0dXWjdrRGxJWGd5bHN4ZDdv?=
 =?utf-8?B?dU15OHdrN2pSQStORVNUWE5tN3lIL1k2bDNka2FOeEIxREk4YUNEZUxqRFJ6?=
 =?utf-8?B?eUVodlA2NnBudHZUU2xkaCs5V083dk1QR04rcGhaZCtHYjNDc1FGRS95OEtq?=
 =?utf-8?B?cHd2bkNtbmIwUHBudTBIdnEvdTF1azAvcFYwMkt2UktWV3k4VHM0ZjBXSzVY?=
 =?utf-8?B?M3J5dS9udXlZK2NBbHpkUWZVSmZsNUp6U2lHZUZtakJiSEZlaEVMT0JYTGE5?=
 =?utf-8?B?UnlTQUJYZjdTRDFieFNjSEhlQ2lEWEpOU1liU09vU25OcXMxbHBieitRZGVi?=
 =?utf-8?B?bFp3L3I3ZVVvRXRzRU1HZ2h0L2I4K25FQTRyb1oyN2NvbWdKNUg3NVhtNzRE?=
 =?utf-8?B?Q2EzUHdPT0dtRERTSEc3SGlKZkdVOHExZThtQ2VBTGZXa2N1NWxUbVN1dWdV?=
 =?utf-8?B?dUNqbzlNUmE0WkhXYWYwU3p2bWd2SHkrUy96MVlRQncwbWNFSVcrRFN4Nmow?=
 =?utf-8?B?cVlCbG5pM0lVZXRKM25nVlF2OHppMWJYNFlZZ0ExK05XVTQ4Rk9SVGloVzVx?=
 =?utf-8?B?MDUvWlA3bTRYbmkwdUl3WkUwSjhZYXZhS285bk5HTGduZ1NURmlZcEpCR2ZC?=
 =?utf-8?B?VnZqNmFRWng2VitSblMySk9mZDhkNVdodzEwQk9TRUJkZ3Z4RFJCUDROSWpj?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ee54b5-64a0-49a8-68d5-08dbcb6b3585
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:35:52.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4LH7G2dBkqkC5Mib729H+7WzYKQ3Qw5+KR9ZQ6vMMjxsU/80s1f8Wl8ve50OSQUg6XIlEPkW4FXaQnGwd6T3wG9jff5DLoQJqZokdF2kK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Increase max supported channels number to 256 (it is not extended
> further due to testing disabilities).
> 
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

