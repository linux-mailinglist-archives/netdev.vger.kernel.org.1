Return-Path: <netdev+bounces-14620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610E742B26
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3059280DE4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F15013AE1;
	Thu, 29 Jun 2023 17:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCA13AC3
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:25:45 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28D10C9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688059544; x=1719595544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5kK2nDVyXyq+VDSCImkTbn/oP9yoCt4ILXePdihBYCA=;
  b=c4RAfqAls574nzaMfEw4vv48KeTrCmf2q4jcEfqtdL1MedBOFCMf9vww
   i814l7DIsGCs6deigrdhbrXhYk/OW493XWonXDpKtJdP3LbyCHGx80Rto
   HFjECmBtyiyKwMlDvXOIIyyNlmC+MsUb2l77q9XwAECotMwahhpbIIPYl
   9Bw5HoGZ5YGjR+XO+3K6W3/Fm5xbVjuFOgc2+WueAD524iThFQRTE/NRj
   XFJpQVFzeNZaFnOo1q+/pU0VtgNqtjslcIe+i/wYZHlyYHHV67+CREpLT
   9dGw09Kfm+KeuYBf2O4OZepFfMbpTimhYwWOj5XL87zC87A16WiyLW0kw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="361019280"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="361019280"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 10:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="694713277"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="694713277"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2023 10:25:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 10:25:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 10:25:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 10:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvhtzBJUP7FnJV3eCziPeRLM6UDTUgX5gXn+DD4pSSBJoBOHVuweAxInVdeupt/+Tfc5EuZyG0cG86HtRhaH+8MJPWo6zuR39qLHpRyEu8Ie6Xdlt1rgeR9crmZYVgF1tchwTCUTcRrhj8PbcEmCABLDV9+R6IxOCaK4Vc7AyuaI8mT4K44Hi0st0oo8fa3lvdM8+9rU2koMEHfQkNxcQIg2jPIy7wUPCGISI9XzW1B/ZNtQ0tOxgzLRvuzt/2e0+EDAAeTw6ZXc6MXioAk2hqO8oVFt8Fjd9ty/lrKWWwibaK+JD3esJ17SqsXDHv4HFtpgDz1VyorqxSLYu1c4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XlZMUktrspS6zL9/cy1JI3QvlCkK2mDZ4j86NaevC8=;
 b=h7Aq7hCzNwF3SsscCTVVSI1q4ZU2IgylOk1LAxf739XerbyyaR9MKv9d5n7yrJB4bSD7nOj1e8N8pRjlblLZgDGfvrNUtEBhjzW2LZMtmS0aPkfjgJfmUNMgUTEXOyhgX49W+sDoLu5Z9Xq9/jfCQJW91/IbcZFZZeQQ7fC/MzytisxMLl0I/JJ5dspvRFjvxuEWhwQeWTjmCQV/H7FCLF00NqVLqB09fTtRrVXN5BlZC9Dra09yvQB7jWQSS1RzuY3qNRSNl4PAYDJ155O0zLSfFQGasFgO33Sh3KUL67gXik10RdeWBVCEXUIr/OZf4nrvAbUox68FxnZBc+qXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6017.namprd11.prod.outlook.com (2603:10b6:8:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 17:25:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 17:25:40 +0000
Message-ID: <7e2acc56-e8cb-14b6-be45-a6cc09ad9ae1@intel.com>
Date: Thu, 29 Jun 2023 10:25:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "brett.creeley@amd.com" <brett.creeley@amd.com>, "drivers@pensando.io"
	<drivers@pensando.io>, "nitya.sunkad@amd.com" <nitya.sunkad@amd.com>
References: <20230628170050.21290-1-shannon.nelson@amd.com>
 <CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1b33f325-c104-8b0c-099f-f2d2e98fed66@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 97112b9a-01d0-4ea8-fd1b-08db78c5dc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZYcNam7yMTjhg3wolFIPOqBlip7zJiS5AomHccHFf2y+ew0XNes0Dxvk9gz56+Nr0vA3yeDoKED2KbK32kg7To3XUqy73IC1HDxpT4JMGqg1eI+SzrFRxPMCmqqDthvo4u2blktrH3vxWnYLAgepy9qP9Vix4LRdsTqtzoOteDlyLQzdsuPZJ3YXx2352lByNiBEJHn4kzQpbEVZ1QQVYSRnh2fOlKiTU6kXZihmr4TiOyF/tyJljDTvMBHb9FHiBvlggR6bNSgBqx+sWYXLxS9X6JcYNzx/yeCsoEcB/vyyK+kLmI19bBo3OFUTwsMnYX28FuYU7224cWD81oQuzmplDdeT7Sw+2Pdw2S54G86yLFqFWCKv9hdxjmx3cGCx8xh30r319Ahrj2AzF/ZcThViyYgcrxlgKeuGnBr5sJiR3VY7Jh+0Ogyb40ogrKx/sYQoi8PlI1LskWuwrL7OwztHDXNEqRi+Ynd3cUktjVPx6TEqPMIg4IgtaKF+18Xz7b1VtCIMZ4ILxUh+NU0FwxFNRDniFm0xM9Ge+MCLSsDMeZfvuSSqVXL33BQ7fv1eo8V5G/XeUDNG25oSXFMSlqnQEJQR7vozO+2f31052g1hivp0I9tguP8vQg+5j+E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(66476007)(66946007)(4326008)(66556008)(31686004)(41300700001)(478600001)(8676002)(8936002)(54906003)(110136005)(316002)(83380400001)(6486002)(5660300002)(2906002)(966005)(53546011)(6506007)(6512007)(26005)(186003)(82960400001)(38100700002)(36756003)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnIxbjk0akhoamJMTG8yeXNEOW84YjV1VkdFUlQ4NjREYzFCelhjTHlrT1VD?=
 =?utf-8?B?ODlmL0JhTUFoWDFuTzArTlAwNEFsODhPZDZiRnBKR3I1RnU0YWVYN0pSNzJF?=
 =?utf-8?B?UVlHd0ZmOHd6RDZFR1E5VWthbkZYMFB6aVI1OWhoTnAxL2lzcXV3WW9PS0NT?=
 =?utf-8?B?T2FMMTNsZlNMMFdtczFEbCs4SjgzNlg2OW9vNUhqVHVOS2lEY2VUajN4MkEy?=
 =?utf-8?B?akU2b2FTL0N2UDY1Qk8wZXJ3M3o1eldLaUI0U1dhZm1ZWlpvZFY5b1FiWDUr?=
 =?utf-8?B?THZLTG9BL3JUZXJBK3R5Q2llby9YZFRjYVVVU3ZtdVZ5alB3WkZOR1IwN0lY?=
 =?utf-8?B?RFJCL2FOMjVwL25CZHVJVWt2YmRBTU0velByZWpTME1XVjdMZGg2ZFc0Qkx3?=
 =?utf-8?B?NjIxVjUyZEZuNEFVYjZiUDhBanZ6WE4wTjROSXdMWG9OZ2RGcC9BR3g1Um5x?=
 =?utf-8?B?cXArUjNGMllTdzl2VjltVDNPTlYvbFF2U3RQQ0Fic0tWUWZ0YU41amxkb1J4?=
 =?utf-8?B?dnAwUXY5SDRaZFlGamthZDZLNS9Qdm5HT2JHK3BNcm9VdFlyQjVVb3htUC9v?=
 =?utf-8?B?SjFwSGtkVFV0TUo2d0JpUk81dlV3a0ozcjYzZHVNblVZYWJERTBTTWQ4bi82?=
 =?utf-8?B?eXZTWm9hZEZiN0hyanBINDhuR040ZXliS3hpY3AxRS9Od3RHaUJrYmhJZWJq?=
 =?utf-8?B?SlM0VnJCYS9qV3lvYmkzZGhhbzZKQ09iN0twNUNMdlFrdjFOeWwzcWtEYkRB?=
 =?utf-8?B?L2IzSzJjQmNCUFFJSkxQSG5pZHEyK0NTc2NlVlh5MVBUYkpzdTJRVDBabEkw?=
 =?utf-8?B?Y053Y3BRSmd2MUVTUXdidGF2OU53TXNqZmZtYm5VSzc2QWNWSUFoTzVOZE5U?=
 =?utf-8?B?ODVJTG1UeUV1Q2hnL3BPQ2JDUEhja0ZFcnlIck55VW5vVUtQZjhIVktNenJw?=
 =?utf-8?B?VlFHS1g3TGI2WlFzNS94SVR1cytSUmY1YlBtZkhOaFpxK1QxMzBCamp1cUZW?=
 =?utf-8?B?N0hPanFmL1RzUWxPR1l3ZHpYR1duMWNGb2U4UkZIdENUbWtnUytqSnliYnRu?=
 =?utf-8?B?dUNnb2szSFdFVnhxVitTYmJ5TVFWRFI4dTJucUlTNjVFMzI5dHZBREtINXRp?=
 =?utf-8?B?U3RYL1JyVTFkTG9EbzBzcEVvajZUdEd0YWI1NGRNSW5hRGhjUmNPcmZTUENm?=
 =?utf-8?B?ZndkUEp4UG1BYkxwRUEyVGQ1QzZHRVQ2TnRhZUxzc3pBanZtbGsvTmpzSEF5?=
 =?utf-8?B?a08xeHJQRi80T0t1bDljeUljc1kvUW1SSGd4b3BXaFJ6WnpVOG1PSDBJM1lz?=
 =?utf-8?B?em0wNzZuOExFVEtFRisvZjhlc2tuOElpQlBYSDQ5b1ova20xd21JVm1SWW40?=
 =?utf-8?B?Tm5oenVRVXR1cnRvTGNGYVJpckJITTR6YnNjZnVoeWpEcS9mbmxMdVNVTXlG?=
 =?utf-8?B?QldhTVVVd3lNVTVMSnE5UDNOeE5QMFh1d0ZJMUthb2lFU1hQeEI0Um9ZTUlG?=
 =?utf-8?B?Vk55N0JKSldnRm1uOWc1NGpNQTJINlExcmFUbGV6SEVjY3laeWIybEw2R1N0?=
 =?utf-8?B?bXNkeHBGOWpmeTFaNk1DTmtrbkNxZDVWTVN0Y2E2ZXh6a3hMVzJlQkR5NnBS?=
 =?utf-8?B?MmtTaWlIZWV3dXFVVk0vdGNCNVB2d1A1d2hSVGlkVTZFTjZqc2hQUjlSMkFU?=
 =?utf-8?B?UUJ2cVdzY0d3b0JzNUQxYXMzZEpGSUdFRHF3U1BhRGE2WHQxb3hpZUFHQjVR?=
 =?utf-8?B?M0JWUExnYWlVY3JVWkpxanhqMDR0R1ZTRkl1bHE5NnlYVm5sdWpoYzlOdW1z?=
 =?utf-8?B?eUFEUHhub0ZlaVdBRDVxbWIzY3dWbllEdGQzVVZhTDlQNjdvS0RvbnZmMnN0?=
 =?utf-8?B?WVEwaUNKczN0TlpMVVFPOHEzenBEYk1ERUh0NEdYUUJDK1JsemF4eHFHb2Ev?=
 =?utf-8?B?U3Ruc29abzJxaGlzSVVJM1pEU3laSmo4c0w3bWw4eUp4TFZLR0JzZlQ2SW5D?=
 =?utf-8?B?UUlZbUQzRmhXUnEyVUs3eXJDV0RQVFpyUmVsMmRMTUwyaFE3dkZXQmNsYUJz?=
 =?utf-8?B?ejF4aGczZ3k3ZVpqVFBqK3d4THBJUHprWHQ3NUJvTHhtN1owek5tVDV4clVI?=
 =?utf-8?B?bnMrc3IxemlFbHg5TVZ6SEYxRHRkbWI2WTBCZW84M0dPV1YvdmRMWEpFbVd2?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97112b9a-01d0-4ea8-fd1b-08db78c5dc87
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:25:40.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Us5WCN/MtH/w3Cj9JEp3qLxrqlFHSzIY4Hepx6wfPMsEDNoTkMTmLFlWYXUTEJrFVyTL2hT4+PYtxlW3GqzjIvsjXbieJkDQN7D3Rq85+DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/28/2023 11:26 AM, Shannon Nelson wrote:
> On 6/28/23 10:57 AM, Keller, Jacob E wrote:
>>
>>> -----Original Message-----
>>> From: Shannon Nelson <shannon.nelson@amd.com>
>>> Sent: Wednesday, June 28, 2023 10:01 AM
>>> To: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org
>>> Cc: brett.creeley@amd.com; drivers@pensando.io; nitya.sunkad@amd.com;
>>> Shannon Nelson <shannon.nelson@amd.com>
>>> Subject: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
>>>
>>> From: Nitya Sunkad <nitya.sunkad@amd.com>
>>>
>>> Remove instances of WARN_ON to prevent problematic panic_on_warn use
>>> resulting in kernel panics.
>>>
>>
>> This message could potentially use a bit more explanation since it doesn't look like you removed all the WARN_ONs in the driver, and it might help to explain why this particular WARN_ON was problematic. I don't think that would be worth a re-roll on its own though.
> 
> There has been recent mention of not using WARNxxx macros because so 
> many folks have been setting panic_on_warn [1].  This is intended to 
> help mitigate the possibility of unnecessarily killing a machine when we 
> can adjust and continue.
> [1]: https://lore.kernel.org/netdev/2023060820-atom-doorstep-9442@gregkh/
> 
> I believe the only other WARNxxx in this driver is a WARN_ON_ONCE in 
> ionic_regs.h which can be addressed in a separate patch.
> 
> Neither of these are ever expected to be hit, but also neither should 
> ever kill a machine.
> 

Ok. Makes sense enough to me.

>>> -     if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
>>> +     if (n_qcq->flags & IONIC_QCQ_F_INTR) {
>>> +             dev_warn(n_qcq->q.dev, "%s: n_qcq->flags and
>>> IONIC_QCQ_F_INTR set\n",
>>> +                      __func__);
>>
>> What calls this function? It feels a bit weird that the only action this code takes was in a WARN_ON state. Definitely agree this shouldn't be WARN_ON.
> 
> This isn't the only action in this function - after this 'if' is a bit 
> of code to link the queues onto the same interrupt.
> 

Yea, I think I missed some context, and saw a '}' that I thought was the
end of the function.

