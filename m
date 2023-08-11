Return-Path: <netdev+bounces-26802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F9778F5D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1352F1C217DA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A412B96;
	Fri, 11 Aug 2023 12:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3412B61
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:20:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF535AF
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691756397; x=1723292397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qKLsGp+/zzY7Hp81Rv27R2NRKevsXmNrdwbYGtKBPkI=;
  b=HNG29kEjlOKBq17eu1oG6JVyNf4gYd/iKb94a6oLOGhBmCYkhCCWJHn7
   MHK8eH8eQ/DRcgXwrsZy9XoxqEJta21DKPrd/laKq0HIyyRSOHIGVhBTi
   gvUz6SEdYLG/AvCqZmS8F5EwpYsgRUwnb9GBbrouCaF8RoMtrVhP2WTQZ
   5lCoK3P8hxUmn7scOVHlankU0Tq1ZBh3YCQQQpKaVqddFuzbIidtL9mCX
   bCdeNJAhmg8XrTcu2EloQSD/Vza3adkgH1rLHwtNeokFz2Cj01y6+7Uq2
   6msr4RqdeeoGeHXYM26ROz+MQsJR5eW7odZte6+lHpgSBFLQddvl+zIvy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375378670"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="375378670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 05:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846785872"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="846785872"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2023 05:18:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 05:18:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 05:18:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 05:18:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 05:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/86xi0HSclKtDRlkEL9+1dTBJPEBY1XUBXcVv82eKQ58QR7rQNJqLz6W9zoeQ50FymWmpQlCDGISYTtC8C5bVkRO3GvGFIVYmTIisPMM5D4OwIRYhz/mmANfieqtNg+IbPUKfpf0FrFzhFouEhE+TJVujcbD/8zrfDXr3Xq+Puf+q6cUfC48uB5WmnH4hkA8XxhoXsnsNtSxJVthcriPg9rsZGfZ6Y+d/BBLb/jNMiKj6JKg1FEotfZ52sKwEqBW+YXvpAjc+siGcG0WOY19w5tfJcHJd1HDvi1LlX635bCT/8VgpBWSm3V41Dmpx1hyMUyBQkUfOVoaLZ+nnGilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu8OKgUDVL2HxZYqN+LR5UqCi33I/2myTdreIDGsxIo=;
 b=LzOvqChkG183fMqgQrh8+ADVWyxjUS4hF+dwWSAbcjr7omeZAcsuPUt5IzqH5SAQfgYG0PHyesrFYQ77rFuv6vVByGaSsf9wstUcFVgIHmdp2c+yWYCvoLPPokuBO1ix2MYwb9qRGnssymhijaD4L8Cwses0RD4aaTBMmZElM3p3CkCXE21kqCPX/EoExqWu2HxK0RqUCZt40bq/U8Zhb3+1tFVkZnlVLYEacYiFhoQr82tIHlJHfOIRvVhOYMn9kgNFzqJ+rz1BBTEdVMCNYD4a8T6s+kpLgD4RVyMiOvtt123dPClU3UPXA8Enlh8YHWuX2O5gU122Wml4W/z3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:18:28 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 12:18:28 +0000
Message-ID: <a703b919-65db-1500-6e65-5e9acb5f00cf@intel.com>
Date: Fri, 11 Aug 2023 14:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 0/5] net: Use pci_dev_id() to simplify the code
Content-Language: en-US
To: Zheng Zengkai <zhengzengkai@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<mark.einon@gmail.com>, <siva.kallam@broadcom.com>, <prashant@broadcom.com>,
	<mchan@broadcom.com>, <steve.glendinning@shawell.net>, <mw@semihalf.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
CC: <netdev@vger.kernel.org>, <wangxiongfeng2@huawei.com>
References: <20230811110702.31019-1-zhengzengkai@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230811110702.31019-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ0PR11MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 001fe5a0-5bee-4a0b-1d80-08db9a651158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf+uh59G4+iR1zkdPNNjVIb78ycFENyZaJ9NPgQbsSy8fhZU8kitHiuRXrWKGuCIcTZe22qL4Zxvp8vOY2EXZkA00PXu3jdPZL+/F25w5ejJb3XYQ81CTecqkTFhzmD0pMw9W9oAPPDUe9y2aKOk5VbNpoWRa2OxIhoIVvVe3kIVTApfgn9gK9nExV5hFoetqQ5BUCHAX8kzguBuX6fr5aaZASUa3W/SgK2X1uuEyhMtIKXgRro52kuoAdNLQqH8Vuzthwoo7NjRIBQwmxOjPnsfMFI31WsAeabqrEAQbtpxNODL+/b73DVEM5MVAz9LBB1qj4ygq1UkJWZgpJ6sE87poB0ZgjwHE/Duqb+BUBitGcNcCxFCxcRAsa93k2d/JZRjQCc1TlzgHLOVVcZ0/ljEDPJBIC/NNig3DfF1vNaX8GvOub4LzP7811XRuAKSBJasir+A8RtSdGh7aY4Aix8RYDYRMPxSygBgmtDh9leI4CTZEhAHgPSslhoicHrYV1J2C6MFiSbwp4srGwphUBna+oKlbMfQs2BhIS8tRtvgmPA9n6RvHcfUhbiN1uQosaz4wmjRzJv0srVDLLWtEHC9utfTJ551zgbZkXY0dvpeC0j0QTE2s/PANt5u6xzerBw/t92v2e/x1vplg4H5wio/+c3tHP5aexRYDvl9fPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(1800799006)(186006)(8936002)(8676002)(6506007)(26005)(53546011)(41300700001)(36756003)(83380400001)(4744005)(2906002)(2616005)(921005)(38100700002)(82960400001)(86362001)(31696002)(7416002)(5660300002)(6486002)(6512007)(66946007)(4326008)(66556008)(66476007)(6666004)(478600001)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdvYlpHNWdNbFBQOE1LM1NDN1NXdGRnRzdZUnJtYUtEY3gyaFlWRXhBRVMx?=
 =?utf-8?B?VTBTT2IrcjNnWHdXRmt3M1RkcnR3WFNvcXY2MGlLeUtjL0tQWGp5VVlGMmpi?=
 =?utf-8?B?UTVDVGlhdE03RjR0dkJ0SUVNWXRVNmFVUU4rOUZaa0ZqR1Z2d2JVdlJnQThl?=
 =?utf-8?B?THg0Sml1RkNCUko3RW10ZnA4cktxanlLL01KNzRBQVMrMVk2MWxTbXFzdjdw?=
 =?utf-8?B?TXJUT0ttNERRSG1oZG5UQi9COW5sK05hbUxjY1JSMUVUUWlBTnpIN25taldK?=
 =?utf-8?B?a29SamdPMlVVam5zMUtSRWdtWDFENThxV0RqeG9zRnBZVDQxWGsvakg3c3ZH?=
 =?utf-8?B?WXhHYlVLTHlOK2cwSjN0VFAwdFQ0b2huMlJEUm9tRnQvSENFQytBM2F2bEgr?=
 =?utf-8?B?ek1tblU2NUlOSWhKdCs1WEdvek9BM3N0U2RXbkpzR0kwQmNKV1VmWUlpNlpK?=
 =?utf-8?B?aThMbldjWHFOMHljTms5d3ZhcitjLzRuNHJlbTFDbit3OXdmU2FhSVhxbVl5?=
 =?utf-8?B?cXpqdjUxTlNOaGN2TWVzWE1aTmo1bGRDVjlaTHFvY2tpbVovNXQ0eHpHTm5E?=
 =?utf-8?B?NDV6YXEra2xCdm5manplZ2ZtYXhMZm5zQzRmVFF1dnUxellrem1MRy9nMlEw?=
 =?utf-8?B?dU1IalF4Wkd6cHJOUE4yeks3RGw0R01UMmxaZFBXNHJqbkVMUWF3NXFWM2Va?=
 =?utf-8?B?cUN2ZzEyUFJmNys2dVJrbWFLNlZ4U1pzM095VDI0cGp5VWFTbkNIOWVkVC9u?=
 =?utf-8?B?WmpmRUFtMGdqWDNETWp1NU10eFR6K0RkRnU0OW5lZmxGZXhnUGlUa3JnenFr?=
 =?utf-8?B?Uk9TMGZBTkF5b0xLRWlYN0ZvZWJoUEplR3dldW1zUEFZby9nQUlsSFQvZkw5?=
 =?utf-8?B?TEdWZzFoU1NlbVI4TVRSb3FMc2pSd1NrRTlhZm91bmpwL2g4Ky9ta3VxcDRS?=
 =?utf-8?B?bzQ5K2RJYmUxcTJjSkdOUFJvd2JIRDNTcjlQRFh6OGlsZmdzMGFEakhHVVc0?=
 =?utf-8?B?d2hiRitBdXVRN0NFZlc2dkszSGU3eWg4ZTMzVzVIQzJwUDJSbWlaMmdLaXly?=
 =?utf-8?B?TnNnbnhaU09LKzd2aitjRmpnWFN1R1RzclkwamlTdXBYay9KN2JCS1lSbEJE?=
 =?utf-8?B?Wkwvc2sxUHhzVTVKdll5V3U4bTNyTDBFTXZiK09Bencydk1OZVByclpXZ0pT?=
 =?utf-8?B?TXJ6NlBPTnkvV1lDZ2l4WE90dk5CeDRzL2Mvc0lTcGZOSFkxeGM2QUlyd2Er?=
 =?utf-8?B?dCsycjErdnhYNmNHQnRzdElVR2J1RWNiN2RLL3o1MnZWWWdzcXRIbWppdU42?=
 =?utf-8?B?alJueGE5eXN1ZGpmTDBaSkc1aTJ6UnYyY3BHVy9TZmZXMk9jWFg3MUtrSFc3?=
 =?utf-8?B?a3FqeDJHQXRMQ0tRMlAzam1uZzNvdlBEbWlTRVpNeGx5aVJTdXJsdWhMckJq?=
 =?utf-8?B?UTI2eUU0cDEvdHV0bm4wZS9DdEhGdzRjb2k0Q2ZEWjRhUDZuNjErUExoOFd5?=
 =?utf-8?B?SGd6RU5CYmJJZEZwUU1xVHF5cWdaMmMxYk56QnIrK01PNGJac1dBa09zZGhJ?=
 =?utf-8?B?SEszY2YwU0tKNmxGTDN1VGhvSXpQREJjV0ZNQW1vN1Z2dnJveUxzb2N2WDlC?=
 =?utf-8?B?OUx1YmlxV0h0TEg0MVcrV2ViYkNuVFhOZkZyNjVWVHdJRS9jbXhKRGxhaUg3?=
 =?utf-8?B?TGp1YStML1laSit4Z3lRR3VzMkc0NlJOa0NML3JQM2pmdVY1anVxSGd1MHQ5?=
 =?utf-8?B?OU5wdWVrV3ZyQlNCOTNWUEZVTzdSQmRNUXdobTZjSFU4eFhCZzA1TEIwd2pZ?=
 =?utf-8?B?Y01ZYVlTK09hdFpJdFR5OWFERVRDSzI0bVo5ejJWdEdvTzNOcXdEOVk4RHA5?=
 =?utf-8?B?MGRXRlFpTWxYeER2NXA0dXY0alB5SzVyQUhhdVpnUUNyUU1aQzg4U3YvSVdC?=
 =?utf-8?B?aG9DK2ExUW9YL3dWd2VZbTRPWHNkcis0TDM1QnIxQmdhOTAzOWZNWWJ0MkxW?=
 =?utf-8?B?Sk1nZ0Q3TnhwL096WHRkOTZBNUNYYlBlb0tTZkZvdlY2WHM2Q21DbVFSaEU0?=
 =?utf-8?B?NHgyZHhDYzJiT2tISktDeU1mL1JVc1ZUOGdOVVplREFFQTJCc2huYUVZRkhr?=
 =?utf-8?B?dUprSGliRXJmZ0NmRjZJaHpUR015ZDJxdkdaSWxQQ0c1VnBXMldWRUhWZzN6?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 001fe5a0-5bee-4a0b-1d80-08db9a651158
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:18:27.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rg+1Qz5MhVcK5D7+ZlSYu6KXQvf0AeD+nRnUO6/lSngv1CanD0zAXWJ8EWobg59G97gz/uf230x51i60WlysPPAh0M6sGpYIKrSUUXSVcOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 13:06, Zheng Zengkai wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. Use the API to simplify the code.
> 
> Zheng Zengkai (5):
>    et131x: Use pci_dev_id() to simplify the code
>    tg3: Use pci_dev_id() to simplify the code
>    net: smsc: Use pci_dev_id() to simplify the code
>    net: tc35815: Use pci_dev_id() to simplify the code
>    net: ngbe: use pci_dev_id() to simplify the code
> 
>   drivers/net/ethernet/agere/et131x.c           | 3 +--
>   drivers/net/ethernet/broadcom/tg3.c           | 3 +--
>   drivers/net/ethernet/smsc/smsc9420.c          | 3 +--
>   drivers/net/ethernet/toshiba/tc35815.c        | 3 +--
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 3 +--
>   5 files changed, 5 insertions(+), 10 deletions(-)
> 

code looks fine,
I wonder if it would be better to have just one patch here?

