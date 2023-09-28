Return-Path: <netdev+bounces-36946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7FF7B28A8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 01:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7BCB91C2099E
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 23:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159818B02;
	Thu, 28 Sep 2023 23:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A4168B0
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:12:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2FAC
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695942768; x=1727478768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FeZEhI3PkPjsBUDSLXk/aKX3SBELGyQGUROacYjJnYs=;
  b=M0JYlQhkL+zoHKjzLFFGKnpbDsT8fDM7kDdHd7MKmesb9tQ33Ym5xnge
   2cbgq5rncqYJFts0P2iXH0MPS28adGU3dmSQzxKEb+U/G2TLAdPmoOMTl
   Hs4uBiN++j9AWMEzIQBsKinrm7heL/8TYeOSe3gN1s+cOgZ3Vc94XTy9/
   UhdV81F+79Yc+9jZDgqv1quP73WJFKpPzVuQfa3fxrftFGhk7ez7fR9u9
   zObJrux9vq3UEiJob7866yADSj5x5re70nlXuZc2Lo2B/O3qbj5xAhHUq
   ZCskYOcdDo/SMrd5W//2T+epEIO9OtydGduencJzDHjLVY98Q2y61oYaM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="802017"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="802017"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 16:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="865473919"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="865473919"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 16:12:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:12:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 16:12:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 16:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFVwcBecymz/r7eOJRo58fWo6o50uMGXfRC4kL76yxpjWaaFtexGyDmpNEJybelwctPSXw8onbirjqzZmTUOdvZZrUmEqRKkzdMmPGl+JYBp+Xj2yWjlbnIOsBHu0exnguu8mJ/SexSQG+HnTO8LmkiY0paUsiIqpAvJalfo0RAvXfuEjzIrB6tzKPbnfi6KuJb3nJnQ7Rh1c/d4I+WXdv25+4Yc3hZl7nB3TfHDIVwA9KWqujBN/FkFEJP1ZxgtJzANnv14qL4cPURsb939ZaprYkNgC621KJsfMDcNYrsOVNNCtSXUhc/SmknAANWBkHKgV+lyHMshWlKhWe4DoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKnKg0lNjXMv5gKBHb9ObWxCvstZtMfUqh8zHcDmsD0=;
 b=X9hB49kOkz5SfzQbSxwixoobhv0o6qJJhmrH4SviTB8iYEUAgS1Pu15XciZ0/KjcHHSaH1CQSRFJcd44FNR9ffjQycQhQtImDGZxkrJjAjz9WFe/rFpqNrSZCZFPxZs5F+jTSULGKdYYdid6jFTIIuOAaArUEFuetXJYV5XI3aWzjAojFlbcR7HAP0cR6P1Z7fk6UmoObrFgAfeYZxVW1lGkBSFiC0hTTQA+CtC8z/poJCTugWczWkEToQ+Zxwvt7/DzCpd/O2H/nv9uRy4sf49RXCoRguLlkL7/W6xd/KcyRkz1gP3Cm/FZsGx/w3/+qivNeKodIAXHhAV9sDuPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 23:12:43 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 23:12:43 +0000
Message-ID: <83edcba4-80df-4fc0-b482-52ed71763060@intel.com>
Date: Thu, 28 Sep 2023 16:12:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 02/10] net: Add queue and napi association
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <sridhar.samudrala@intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
 <169516244584.7377.16939532936643936800.stgit@anambiarhost.jf.intel.com>
 <52204e24f0578871e699a60bbe8186f27600c4e5.camel@redhat.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <52204e24f0578871e699a60bbe8186f27600c4e5.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: aac53f4c-f783-4303-9ad3-08dbc0786aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iq7SGq8z3NeLjOZIHvErzv/6YhNmNQNYn+R7oAGtqEN4XLwtgmRVQltwgUpFxGdoJyi2xRVhgyh4mxmnPzdnacMwRXWehoTmH8elo3KIoR81+scABHgb6zWN8n14Yvjt3tiUZWXFKEetBnswtlpz8Lx/IWn14DxgUHwqenNdb4+/68N0/tBvmbQFW+lECP3J6b6A39FCQCAO8epPC49sFaNO7G5VgcMKXTBc56jKknWxRRtLleHZjyR8nJGFbuDKuw8dcbiS07lJ+wI0r7SLMxmOUAKkZQgsm3V9oDJFlDGk5GKt/ljhn4rl7Rt213/m26OuV27NxHDR4QneiZSpSTAjwsSrwlwhmHkEciG2sOPy6KXKiOsqf9mChkX1yh7lCGjqBo3ZPNtcrF5Cxuuvnkzp6FZ4cZ+WTtkQHArUmh0jIADONhpR9pCz+rZouIEM7o11a+9W24jkOhy48TkyYQ2yl9T5n3h0k8uJ5EGvBn5UBk7id7zW4RCzPfnZEa4iYWISeJM3AZEXHOvC7tYeVXPcmSwpEmHKhwyDiDPDG3IL4EMtSNhxvihyQiq4Y2DWxuElu+Z1sYt62qJwk/W/bpygwGP6bhUm7NrT5iyF5O7YTcIaH2wVGp2+0aMb8QSvSAn8Jsosm0oqKj4XmXQAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(2906002)(31696002)(86362001)(36756003)(66476007)(41300700001)(66556008)(66946007)(316002)(5660300002)(4326008)(2616005)(8676002)(8936002)(26005)(6506007)(82960400001)(6486002)(478600001)(38100700002)(31686004)(6666004)(53546011)(6512007)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlscEhwVHREa2RLa01TQWhjQ2VpaytkSkk3cUd3VDhxSlhBc1dLWGxGSXNa?=
 =?utf-8?B?c0pIdm1VZ0JUbStnWEdJenIxS3czR2k0WGNpRjlBZEpYL096K0JzOEpXZGp4?=
 =?utf-8?B?ZkpLZ3ovWVlVSUwvTU1jcUhTY283QnhCSmplNEFUSXhPZ3B2ZytKREljQ2ZG?=
 =?utf-8?B?R0llY0RZZ2VESFZWT1hiQVdFZ3huVDhraGFvRDAvaFRDeFk2clZKeXV0UTZS?=
 =?utf-8?B?M0gxazZnd3RvZEVGbVBVcWowR043UDh4WWpYamY1K0hHZmx5ZVA4NFJlVGlp?=
 =?utf-8?B?SFhUNHI1UVVzTHBDbEVUdGdET3ZtN0RZSTIyTlkvb05YZjRuLy9JVGFtU3cy?=
 =?utf-8?B?RnpCRGRoS0V2ZituQ3JyeWlYclFyYXZtNDFGKzRiQnhqYlowRzB0OXR6REZZ?=
 =?utf-8?B?aXNPTVp5V1FXWWZzMit0UDZ2TTJMeGNFVndQSG02eExLakcyL3ZsUTV1QXQ3?=
 =?utf-8?B?aTk3ZHQ1RlpSejRQNklSSFJ0UTlhOTBPUDBLQmFkUHlNWnVJSVFRcmRWWTJN?=
 =?utf-8?B?ek84SDdDNlpZYjhKSFNmdWtXbERkNnRZOUFGeHFvUzJKZ3hteVhGdkhZbDhq?=
 =?utf-8?B?MXQzRUlvbVZmM3Y0dmVUMjZXVTM0eDFxN2dXbm92K3ZIeEZwVkwyMWt6UnE5?=
 =?utf-8?B?WVdqZ1hVeEI0V0VSb3ZESTdOditaNHRzNjZiT1lmQXNwczVmMS9OWFR2WGpU?=
 =?utf-8?B?a01zUUZ6RVpybWlVMUZlM0M3bGF5ZDdEekdRckM5QlhWNWRrYkxpdlc3VWJD?=
 =?utf-8?B?L0FhMXQ5MGs2dkdpbFNHRWhCRTVHNW5WQUUrRUhWOGE4UDdsUFFMN3NYakNj?=
 =?utf-8?B?MDJvdDJYVlZZQ0Jld2IwS01YSHg1N2lUTWpNQmdRQjUrS2FvTjdVWTJEcW94?=
 =?utf-8?B?NjRvMkUrNUEwM0tZWVRkbFQvU0ZkOHRhNEpNTXpZYjlTYVVzemVEMWt1elpp?=
 =?utf-8?B?ZFJHTE5XRUJPTzZHaWpFNnQ4V0xtOXhhMVZ4dktJM21TVmJHbURRRjNlbGVH?=
 =?utf-8?B?Z2FnYXBpMXl5TTR0VEgyRjJxZmJrK0V4MXBhcTJnU0dQTUc1MUxtOXlXTVZk?=
 =?utf-8?B?a2NCQmY2YnhxTG10VnV2cUM0aitGUUNtSUdCdExUV2ltOHN2UG1DY1JFL1Rz?=
 =?utf-8?B?b3JwdUx0TVFzbjZORkI1d0dIN2FDYjhManJFQ2YvNUtDTExmR3d3d3ZmV1VO?=
 =?utf-8?B?dmZ3UDJ3VEk1TmhldG4rZEhjc1I0T3BoS0pQakJ4OWxGNGQzVnVSUXpwbHFL?=
 =?utf-8?B?OUUvQ28vdVgrcTR6TElKalNJbGI3MCtKbVc1ZmREUnBxcU1XVXRzNTE3RlBi?=
 =?utf-8?B?bWp4STRaWEhZcHRsdE1NOUpHZXE1QlZBcnpLY1BEK2QvUmFsamdqNmdRR3FR?=
 =?utf-8?B?WHV5RzlDMStFc0d3a3RzM0VtWDNjd1ZMNUtjK0VydDJERW95MVJVYTlnU3M0?=
 =?utf-8?B?ZC9xcjdKN2xJRjZCSzU2TE96L1QzbnhkQWJNVWM4Q1RuWnA5ZzBNMm0zSUhm?=
 =?utf-8?B?ZTVGSWYxTno4VGpsM3hhRlVPSlRYWU5ScXlQaG1idWRoQ3F6SzFoSkpWZXRj?=
 =?utf-8?B?aE1qZThGaUlSenJHZDhGc240V0c2V0VDd3IvclVId0REOWRSMGdYMjBHWTV0?=
 =?utf-8?B?cW41bHF4RFh0dlp0bmxLRzZGd09MV00yaE5kY1IyTC9VS1FMUmp0aW40QU1X?=
 =?utf-8?B?cWtjZ1NNcWtmVXJLdkUwWEZlRWh3QXg5NExVYkVKMGk3SUMyTWdRWmxJdlRP?=
 =?utf-8?B?TGxmZmZrcmRINnBzYXFBTFFHdERadXRMS0Zaa2hKTXBJNHo1eHlQNjBSSDlB?=
 =?utf-8?B?QXZZUUhxRk5lVlpsUjUvM0ozY3FUSzdHbjJROXZ3UmdDcThyeE1SeUF1akhy?=
 =?utf-8?B?YXJTY2ZjM3pVdEw2UGh6eC9yQTc3dzFLVTR3bGlHUUF3ZmtQQS91ZVhwSmU5?=
 =?utf-8?B?NEEySmIzVVFDTXJ6VFpvaUNXT2dDSkJQMEFTQ2J1OHc2WWFYeHJhcUJxY3hl?=
 =?utf-8?B?S1FnL3o5ZkFHRG1CNVllaU0rcnlPTlNseE5NbUtLalhkZkxtZ1MxSTAzM3Jm?=
 =?utf-8?B?d0lBd1dmSW5yVFdnM3R2K0pMbEZSU0h4c01yOE5MaXVoQ1VBNndqazgvZkY3?=
 =?utf-8?B?R2dCZi9JTnZvbGlSUG92ellWSUtMQ3JLR25SVlVZUmRKN2lrSktpV1NLOTYw?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aac53f4c-f783-4303-9ad3-08dbc0786aee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 23:12:42.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItHDzZgPvh3InaubYg22PbHIrrm0jpCHQOgl9c/4TLkqZ99uaMXap7Gd84VUPWqHEVPRUhnNHQkxeWb/JFerO+ZvREhDwBpldLu5jzUFVAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/2023 3:47 AM, Paolo Abeni wrote:
> On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
>> Add the napi pointer in netdev queue for tracking the napi
>> instance for each queue. This achieves the queue<->napi mapping.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   include/linux/netdevice.h     |    5 +++++
>>   include/net/netdev_rx_queue.h |    2 ++
>>   net/core/dev.c                |   34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index db3d8429d50d..69e363918e4b 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -657,6 +657,8 @@ struct netdev_queue {
>>   
>>   	unsigned long		state;
>>   
>> +	/* NAPI instance for the queue */
>> +	struct napi_struct      *napi;
> 
> This should be probably moved into the 'read-mostly' section, before
> the '_xmit_lock' field,
> 

Agree. Will fix.

>>   +/**
>> + * netif_napi_add_queue - Associate queue with the napi
>> + * @napi: NAPI context
>> + * @queue_index: Index of queue
>> + * @type: queue type as RX or TX
>> + *
>> + * Add queue with its corresponding napi context
>> + */
>> +int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
>> +			 enum netdev_queue_type type)
> 
> Very minor nit and others may have different opinion, but I feel like
> this function name is misleading, since at this point both the rx and
> tx queue should already exist. Perhaps 'netif_napi_link_queue' ?
> 

Sounds right. Since, we are basically just setting the napi for the 
queue, and this function may probably be used by both 'queue-get' and 
'queue-set' commands in future, does 'netif_queue_set_napi' suit better ?

> Cheers,
> 
> Paolo
> 

