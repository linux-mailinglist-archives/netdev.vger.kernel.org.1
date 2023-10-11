Return-Path: <netdev+bounces-40187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7D7C6128
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76630282277
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F42B752;
	Wed, 11 Oct 2023 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emqg7IEF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B12B741
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:36:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AD9E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697067415; x=1728603415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BBj5MzuYbcKDaBMgIBLmw/ivDL+epnc1yLTWpc97b0U=;
  b=emqg7IEFbz6bPqy+QFm++Ftf0n102lz+3vwrHY9MjRtTMkAHm5Kwl45J
   Q4i5jqnaUmln0wG1Y3u5uYLgj/KPtmCt8yaEM28OLGwO8NBegIm8R7DI9
   xHvXtAqVWw99K8GzMeM4BnMYMzhO8hONXL7twfG7FvG92StsBCKzp2u3Y
   T6HC/MRedx6dZiQ87IPxKCEmxYnPsgTuaZNqkTlunADmUoXuUep1TOza8
   ik16KvvCzjIj7tO7Q/NN01aTDGqKVwxJOsARnaCRwwK7ZeVMf/Tl6qSud
   uTrH8RH5IMm2Hs5UBaDn1mDMOK9UByVGV1RagZRHaDlaV2RFYmEHyQncJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415840326"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="415840326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897852464"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="897852464"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 16:35:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 16:36:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 16:36:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 16:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdaiFmUSphvEAoHmOCs/X7TMahgWXfo7zd/d4aMVOiOJtIzxrS9A9KGnP6ZcAxsTgQeW7+wUmRl94NTZda6+Z9vh5JVk/b6jFIDBUYnbesfLh827PnHHnS+rcb/si0MUeQYTqTtSXTa12HzcC0o50XO6deTQIGRcofqOFj+oSOCxMoGS4WEWfKTGwr/aP+fUCV3hKrCApOaqQU7AgCS8NTVZo107TDZWQD+7zSCUpO0boqCE8AJuRzEnpfUhAUJMgehb+SSFOwa8By1sV1OGL6sl74KzrcWQE69g/ZG9XlVZPz4rQ3LiWqMXbP+rKPg3BICrc78OlHB5aE1WJnbSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcrryuiiz/6cLK9gjdNP7DDxc2eeIckGUGIZxYtdPg8=;
 b=k9qwwdZfdr8pzHnptRMC1WYMGR7xolgJZ9oHAOHqzf5PgJpPxYt98FV0X5901GMPuGjttDFN3xBl0YHm+vRu+eJb9VRr7RLorfK0g+bePzkjOl70Zqit5VmlA708QAW7+hTj+hSlcrCafuonGf32DRxCrnU8A0n4fEJ2Ea2kFeU3kgqXu6CoWYKrtM1Fz0Y2c7p5ANk+xsfTDrSa5p5XmrXqy0dTrG6kdFvUnIpfVOF/kmxm6giUbMZn95XpmUuLWOt4IoYCC5XohE+Mbr7QRw9qlIlv1Jx69Xh2I2H3sUSNFnQWUam56o08BEYyiLTtOxNhYVJEYhBhuBROioxCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 23:36:52 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 23:36:52 +0000
Message-ID: <ae9616c7-fd96-4d38-9598-89b9082baadf@intel.com>
Date: Wed, 11 Oct 2023 16:36:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 02/10] net: Add queue and napi association
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658368866.3683.5936758786055991674.stgit@anambiarhost.jf.intel.com>
 <20231010191709.1cc0fbe6@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231010191709.1cc0fbe6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SJ0PR11MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b8a806-e75d-48df-2c37-08dbcab2f1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtvn+4leOUxBkMq27lyvJDCj501p9rS6LyRE92Hiew4woC2L6ybAWDljnu51nelsT/M9aU9jUXDtZkJG9kEiaVTarpUlqGatPlHFmFfHBSufIG5U0JqzNOzZyzL6sF0lFDRrq6j3GqSh1sihHs7A8vd73vTU98wy9aEKaOIr1dNv4M0s7t1kbj2dVgI86ne+twdobAIvXkMYp+6S8vEX3FKR3OK8lF2Qnb5e/RNifx4Xe6P14rGKmGPTTMJOYpoAOi7g7wCBxYYCPM0aSJb670JcU8U9d9qUOmB0CdqL/k7g+OLPODQtRIhT/47XEtkcC+8DR2QiUV016+H64HHXgeg8ECkcBHVDjB7TCJyyHKsVN0rBL9xVyP1anHreRoLPDj7vZijEJ/sFNedpNVkleGyfxVVtC+yPeRh9JeQh8/zrogz9j7z+5+MLkASJRSSUejfqvv2A4/J1c0XhwHE6rO+DL81vmkO/ynjX0F/bkWjJkKvmQ7pCDtpCtV7mKGaVyOZ/QTh5szUjL0a8TIfpsrxpavUY/tF1lmSEAmSxE6KdqGaH0tTPezAx4Icew/M9n+IcAciwOBplXaRMIQGInWNSJlzxfxncl/HMJCr/cI4SjIjRDV0mQ4DSFuys3i7KXfHfMU+wxOVQ2q7WVQkDUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(26005)(2616005)(41300700001)(8936002)(8676002)(107886003)(6666004)(66556008)(66476007)(2906002)(6512007)(478600001)(4326008)(66946007)(6506007)(6486002)(6916009)(5660300002)(316002)(31696002)(82960400001)(86362001)(38100700002)(36756003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRuQVplV0NGSFlwc2Irbk55aklENVZ2OGo3cU9hS0pJM2k1dUhaL3c1Uksw?=
 =?utf-8?B?bmlZMXFTdjZXZllwZ1BjOVVtOVdlajJTZHNGdzlJdmhmTGtEenNyTTMxOXFr?=
 =?utf-8?B?aEpGWmMraW4wQWgxamNYSXFhV1gxSE9WeTRtenp4ZTlVL2swWDczVmpBb1dX?=
 =?utf-8?B?TXNTMm52OXE0UzZkZUp6UXlPZ3EyR2tqMDd2SDl2QzZBdHJoRi9tOCswbm56?=
 =?utf-8?B?c2ZOWm5KZGZEcXAxcVBtRkM0eUpWOEdwZE41d09zWlZremkyOUxtRzBQYUhS?=
 =?utf-8?B?WVd1d0xhU3ZmbDJLTFNFbXFvMmZnVU95ZHlPaTZDQVlWcHdkL3ZCRE1sSUhZ?=
 =?utf-8?B?ay9NNVNJN1ZIbFAxd1dGVUh2RVpaV0N5Vm82M25HMFVCT1djTncySE5VSktw?=
 =?utf-8?B?ckVieFhMZldMb1pZZFIwZUZFUHcybTU3R3ZrdFBxSjRicTNQRnpWSTJWOWFY?=
 =?utf-8?B?NzNzTW9lTjA0N0xWQWRlUmlxZS9VaGlRTitsNEVCbUVvUi9SbENhc3F6TFFz?=
 =?utf-8?B?NVVKWndzVXJZSG13K0V0TjJoV2N5eCt5MksvM2tVNzRLejI1QmRkT0VKWTBz?=
 =?utf-8?B?VEpDRFFITFl5U1BoSFM2Vk4zT1FrVXNWMEdkZ2lDOTd0UURGZ3Y0UVZwbG5t?=
 =?utf-8?B?NU9FOEIva3EwMWVYa2tZTDlCS05mY0FtOXduY3lwdHFYdE1rQUplSHVBaFk4?=
 =?utf-8?B?WnRiTVFLaFdFRU9IcFNvc2RsZHN0bktyL1IrMDJMVk5RNUkxR1VkNXJPUjZE?=
 =?utf-8?B?amRzK0ZHTHZ2dDZsZkQ0T1ZuVjFMeU9mMTFMTVNiZTZobFBsZE1MS1p6aDVp?=
 =?utf-8?B?djVjVkJRY1dLbDRiT1R1OTJzS05ldkxjemlzbVJleDlkVEYwR20rUHR3TjlB?=
 =?utf-8?B?MDg4a0JwbTBzNEh6Z05qZk1QSFRBYy9CcndEZE1lZGo1eUd0MTFGSGIzRjNo?=
 =?utf-8?B?OE95Vm9CcCtkU1U4TEhPSkZKbGk4aUxtL05uMk5TVXhTQS9BNDc4VEdHdHR2?=
 =?utf-8?B?RkJ6YkJNdlY2WENSQ080QjBQWE5FTWdHTUwyTm10UUp4aXZlTithdjRiV3VT?=
 =?utf-8?B?dGtwcjZORVdaWXh5K000K2U1MjBuSElkKzRFK2JGOVZ1NUVPUm1lejJRY2dG?=
 =?utf-8?B?K1E1Sk5BK1NnV1RxMlh6K3BFVE5oL2xMRDR4NFMvNERKZm10QlBXdDM1Rmpl?=
 =?utf-8?B?UTAwT1F6Y2xsVU52T1VuZVdTWUpxSkJBQVNrc3dIVGV4U2tmcnd6NGhVS0tM?=
 =?utf-8?B?Zk9HalQvT0ozNCtObE0ySGwxVmhNbVdqSG5xbEVjMk9RTko0QUxBRFh3a3lp?=
 =?utf-8?B?Yk9nREVMWDZMSXQxWjBQcXA2a2pFNVVueWg1Yi8waTdQWDlPZDBLYkFJQ21y?=
 =?utf-8?B?eVVrQ2Y5L0dpckgvNkJRc0hPeUZ1RVNLWUR0aFVTTlk3dGpDb2lZNHNkQlFM?=
 =?utf-8?B?c2FUeWdlWlJNblRFcDJ6Q1ZmY01JWEx0TVZ5MlA2ZFZXaTU3VUhSeW9sUDBp?=
 =?utf-8?B?THYvRm9laU5xY2R3aVY4cmFZKzJJT3BjZkt1OTZxWk04cDRjeDdkeHdob0Fo?=
 =?utf-8?B?TXNHKzRPZXE1UDFUMW16WmJaTi9zWEFoTEtYeFRrR2RTcERJOEpGK0U0Z2R1?=
 =?utf-8?B?WVgvZW5EdVdVMjZLakE0UFMyTURzU3hROEV4UGNrMHNvdEw2MmxYcGNQME1s?=
 =?utf-8?B?U0ViY3R0U1pFY242TitBVXdyNGZnN1RaK1d4NlgrbTgyR2dqK0hVRnBxN0g5?=
 =?utf-8?B?WlFyc2lnbHQxQktuMm1kTCtkVmRTbXE1Y0VHSERhaGEyeEZwSGFISTQ0K055?=
 =?utf-8?B?TkJ2YmVBaGZlaUthd2ppeW1XVDVoZStEMm1LUW9ZRzdkcVNSOXlUZWZpNFZM?=
 =?utf-8?B?cy82LzJ2M1lLNFpOSllrTEFsekpHb3I4cEp2UFo5Z04yWlNVaGk1bWs1RlBu?=
 =?utf-8?B?OUJTS1UxWmJ6bVNLLzRvUnBnOHF6MmNIcCt4ZjBUQTNzMlFGeW4xRm5sRUxD?=
 =?utf-8?B?K04rM3daeUxVMmRFejdoRnQzUnIvQ2dvR2FXNXRrZDd5dHFaUXpDalIzNG83?=
 =?utf-8?B?eTJrS0xOclJrSjdTcG9mMy9WaXFJTkJGNXVmT1VNMjdJZFRyYmFqMlR4R2JV?=
 =?utf-8?B?QXpaa1RsTjhZTElmYjZ2YWdtTlhvTEI1b3cxTzFHcm5TZkFRazF3dElaT1Y4?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b8a806-e75d-48df-2c37-08dbcab2f1d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:36:52.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENZuOckxLHhhHYPOBVFFQ1MY9YJinW/zev2GWrESN2GmbOFTSTrmgl0N1B4ybgG6Am/WUlVCR3n/JMVgFji908op9jrugCyZomCFeqKPs6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 7:17 PM, Jakub Kicinski wrote:
> On Fri, 06 Oct 2023 02:14:48 -0700 Amritha Nambiar wrote:
>>   #endif
>> +	/* NAPI instance for the queue */
>> +	struct napi_struct		*napi;
> 
> What's the protection on this field?
> Writers and readers must be under rtnl_lock?
> 

Yes, writers and readers must be under rtnl_lock. I will modify 
netif_queue_set_napi() for rtnl protection from writers. Readers are 
holding rtnl_lock.

>>   } ____cacheline_aligned_in_smp;
>>   
>>   /*
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 606a366cc209..9b63a7b76c01 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6394,6 +6394,40 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>>   }
>>   EXPORT_SYMBOL(dev_set_threaded);
>>   
>> +/**
>> + * netif_queue_set_napi - Associate queue with the napi
>> + * @queue_index: Index of queue
>> + * @type: queue type as RX or TX
>> + * @napi: NAPI context
>> + *
>> + * Set queue with its corresponding napi context
> 
> Let's add more relevant info, like the fact that NAPI must already be
> added before calling, calling context, etc.
> 

Okay, will fix in v5.

>> + */
>> +int netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
>> +			 struct napi_struct *napi)
> 
> Let's make this helper void.
> It will be a PITA for callers to handle any error this may return.
> 

Okay, will make this a void function in v5.

>> +{
>> +	struct net_device *dev = napi->dev;
>> +	struct netdev_rx_queue *rxq;
>> +	struct netdev_queue *txq;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
> 
> 	if (WARN_ON_ONCE(...))
> 		return;
> 
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> same here

Will fix in v5.

