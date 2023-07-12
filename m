Return-Path: <netdev+bounces-17292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8175118B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5892E1C21051
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7D2417D;
	Wed, 12 Jul 2023 19:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52824171
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:55:28 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C041FDB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689191727; x=1720727727;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAY+FXpvRkqHAN66sfWlMNaQppCj/mtr5npR3e98/J4=;
  b=OH6kJBYqrscRtVKxLMpX3ZNtK64BXAU1PgZ90NXyDzb07tFNKCMCIwNC
   c4z65DmSAyry1/PTC2kqC0AjO38XPq5vH63RpFhB7/zXnNZdK9xALR3Zj
   rMQdgWG4DOUqoVQCleRVV4PliV+N9Euwh3WrBJ1UfP0sRmy6RGaD+czwN
   C5cf1XpMmFaGS+rOQBRQHZlOuc/yMWQuv5zZ0kHNfJnChaAilv82lrVko
   /AiHMO3bw+Gm7Rn3u8x66A2re0cy1hfeLJrqnEIYbb3Ree1k4bKDmqvmC
   8ch+kc5tyuENRi96MoS96NRSspRJSfMWfUdLnTba1fUDFZYT93SsdXrIP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363857473"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363857473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811713483"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="811713483"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2023 12:54:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:54:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:54:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me4P56jxGxdeDrujTn0S77HZtC6fbqMehoKiHEfSrS/XPmr+8ercUhfxp4O1Vs7daXz4IfvCg0an0YykJk8JOAXEg44p3PujTLs2oOh4HVvKdzu0WzMy2ZiNa2z5WjeHHVb00whJMI7bSLmJHZTb8SPQzsDYK3E0ESjFV4J+Px9QZ/5kfTRuhkEPAlgJn5FLgaaH98Y8cKHa/JdQOrKg8u/Ey1grrOdF491UEUrx+RvB+XB4cIxesO2MUbhCN0DeJ+PmY31WjgjsQ2j7OGGq0OwUkSD1DNGIpzHHSvU4ZMoqF09+ajWm4P1tfJU/wQjKOGU/QwqouOZ/eIFdJhzUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSWHUvPggtwXVE6VDiUnwTyjwtn3I4fPG44B+8OCQjQ=;
 b=OmRGGuPgb9k3tc4zrLnPmmNchfQt3ZPqwDqAvNAo4nc+mfnCNMgSFcLQ8jL7RDhbhQ3eNVN+Qqmch+T8Rm4u08YSO/coMJ//Q65c/zejBrK1xSOOsSIvtc5mbC3HFJ/6S0r0fTlqcpaFZMmagLLUKSL9DR8BgBhFgnZsHxTkTBdJaD3T7vq+8QpBEybev8/do5FUOuUvhMkVwUFXLt0YxXOecmjZic66anbJlpGJhZeM7Roe+kbjrt9CgW29A6sSyvLslNW3GkkvoPReoQJ45yAwWGcddB7kN4z7MAwnBhc257wj64Pi61cCjbCKu8kYITYshc87wvu14JYcoTdaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 19:54:08 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 19:54:08 +0000
Message-ID: <a0fbc513-4905-4567-4815-e38c6a543cdd@intel.com>
Date: Wed, 12 Jul 2023 12:54:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 4/4] netdev-genl: Add support for exposing
 napi info from netdev
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564136118.7284.18138054610456895287.stgit@anambiarhost.jf.intel.com>
 <ZHoPBYx2lZJ+i1LC@corigine.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <ZHoPBYx2lZJ+i1LC@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: a92efc14-06c6-4f2a-8cb4-08db8311c121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1f6KCnt0k6sxn3WyMjiVP+3IIY7fqOZl2IGFc0gQx54PyNmPmyO86J7qz6pnM/UF+IqDh0u6E2U4Fm3BjC/v7hK4nEaccTRa9wXLlZTqIVhmUpW1LVeZ4/eEHiAIp1/9eUmmY8Ta/vuqn1KL0RtXOVztp6Dce1NbBL9W4FMvZhMIjzPaf7e//15TclAE7S+/EV5SX1z2z1k+S6v2csfidWlDyfXE5ytktnoFwra0fmCLoy5FrAsUqiwS2BuGQ13EA51SWVCUg1s0Nhy81xadepVcYKZEy6ojtqoSqSql6aTFwXIaxZnW2K5VgXSVbybhMl/DmjxwpUIdyOSBKV9LdVmBY+QvSR2Cw4uqzc2X3juxPxKd7xkqnjNAhgg7bERoOXAT1g4DQ13pz8MPyo+5GB1VqyGz9zisGODN6lErEkGENj85UxnReSuNY90o9zZFEt2fgoZVVgpknmgDiW/BTTAt21/C+nnkbAZTDGWuZDroy2D9or9jrf1AfEnnxKBWdE3tVkCs/G06xcO+BvRgeqlk36vVNo00AMBv08c5AUBqCjsCABHdMj/jx2uBzOsfxZwlNEDzDQOrROpIYdLr4VMGolFCKAwlW+0vKbBPnUvr+1lNmGioZafwzpBPCEIUb9iBS85HlajWa+CAmICyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(4326008)(66476007)(6916009)(66946007)(66556008)(31696002)(186003)(86362001)(2616005)(26005)(53546011)(6506007)(82960400001)(107886003)(38100700002)(478600001)(36756003)(6666004)(6486002)(41300700001)(31686004)(8676002)(8936002)(5660300002)(6512007)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUt4YlNKRlNrdUtCMWp3d1lXcFpod2VpbTZhaDBuZmJTMUVhTlpkbFk5clNC?=
 =?utf-8?B?blAwTkhxeEY0YmcwNzJra2NzQlNRV2t2QTVVaFJHRFFzZ0cyN245ZFNnNDdo?=
 =?utf-8?B?S3d0TnZhVlZlWkViMEVOdHVVRHZQVG5ueW92MTVYejFxQnhaNXdFRGdrRFRR?=
 =?utf-8?B?YzhZV09QNSt2NE9ZREFxR0ltMm5DTVdMZUk3VDNHMlJLS0pMZ0pBeUJ4YzFE?=
 =?utf-8?B?eUZVRW9MS3B6dkdpcVJwcW9zalFhMU9sUHBXbWdkNTQwK1g3cytkRUphLytZ?=
 =?utf-8?B?U2J5N3loeHRnY0FXSktvRUxqVmpObHJndklMNGtqTmxaVlVXUzBSZlZCUUwy?=
 =?utf-8?B?Y2s4TVJMelBJOGJDWlFYek5lYkxiZ0tDQjVlY3VpNU5ZbjA1VXMweStvYktF?=
 =?utf-8?B?OXQ4Ym0rdldXRzRiQ2N4dkJxUTM3MmRhMFloVVFLVXdYdlpEZW9kR1V5NWJK?=
 =?utf-8?B?YnFJWXUzKzN5YXBZWFhwcmxWRUVGRlhWUUQ3MU1ZU2MyVW9STS80T2Npb2Ju?=
 =?utf-8?B?b2FtSUxGQlI1emVJVXp5RE1XcHRlcTRvd2FLekJOUWtVNlFFN3UzOEUxWVFs?=
 =?utf-8?B?eS9BQ0xBSjFUenRHclRoZkxOR1pGeVZxemY1RWg4R0RnRXdDZWFibjNLY2Jo?=
 =?utf-8?B?Y0NlaXF3Yk9uZzFUOURKZFFwUGRTV0JRcE9qdWdCQkkydVBRSDNhcVUxSVEr?=
 =?utf-8?B?NkhEczhwYkU5UlRVR1BxMzVNQVlJN3UwZjA5OGN5Wk56RWxnbW1MUjdoZjhM?=
 =?utf-8?B?dm1yOWVLM3JjdWd3RTEyRzJRSGsxMlZIaC9xUWc2RjdNaEZsM2lEUWR3Vk9m?=
 =?utf-8?B?Zm9RZVZUSWRTMkYrR2JBeGxaeDZqdHpDcGJWeng3MHVaMW11dVVobTM5S2hG?=
 =?utf-8?B?K1hpLzEzMFZXdVZ0aFg0Zzdhcit3eE9DL0VpWGFJd2RMU0lIK1NKTnJSRlN6?=
 =?utf-8?B?TVRZNWZqcmphNmFsV2NWSEovNDZjWW5OVHFCSXRSQ0RiY1lwME5YaUhXUys5?=
 =?utf-8?B?Y2M5UnFYS0dkNk81NkVLSzY2ektZdWxpR3pBNXRBY3FMU3paZXpQczJWN3J4?=
 =?utf-8?B?RTdQeXgva3EzanpBT2dzMFlkZXVMaG15M1cvOG9Bdko4RHFGMTRRUkloWXFS?=
 =?utf-8?B?dHlIcnM3V0pISkwvdDRHVG4rU3JlT3lPc1NLODNCRmpiN2tPN2hvbkIvZFA3?=
 =?utf-8?B?Vkc3THY4WmpCbldjcXFuMWxpRnVzem5MZjVCN2Nhb2d3dTl4VnVGeFZDSWor?=
 =?utf-8?B?V1BLa2oxZ3V5N2FpTXlqRGExOWN0ancwVTBkenkwbVlLYU41elA4b1p6aUVY?=
 =?utf-8?B?c3RPM0xEWXA2eUZvcmVKZ054eVp5a3NyZklzK3BFUkR4KzZQVnorVmpOamNl?=
 =?utf-8?B?MWM1Mm0xcTBEU0tZcDBrRnowMmNYTTdwSWJZa0NnSXVYNkxRN09XM1VRYVFj?=
 =?utf-8?B?QS9BN2YwN2NwN3EyVEFPbHNvcHdWSjdUMFBuMmU5NEswQ0hHK3dLNU9YOHgw?=
 =?utf-8?B?Z3VkTzVYWkpHaUdDQndJYU05TnRna1AzdjBrdDYzMkdTM1lpdktWVFg4ZkNx?=
 =?utf-8?B?KzJaTUVuREVXQjJCYnFnSnpTNkt6dU01bUM5T0c3SGkyOXptMElqaC9ibnV1?=
 =?utf-8?B?VmpNYkEvVm94RnRuWCtoK25RWDY4WTNkaE96dk1DL0Y3THhOQzVEbVB2WTda?=
 =?utf-8?B?Zis3UDdOSi8rQmhCbmhjTVZaRlJoamloRHJ6bzhzNEVqMkFBdE15R0dOemM4?=
 =?utf-8?B?NHlla0NVTDE1WVJ0ZlhNVGk2ZjhVUStaNHRmNnJoYnZkZitMZ0RObFh1L0R4?=
 =?utf-8?B?TzdnalhCVEpidXlCb0QrdHFYZEh2bDNtWGVKUERCeVc1SDlycmVKQ3dVR25Y?=
 =?utf-8?B?czZoUGhVTHhvMkQxVkcvWGk3RlMzS3JQRkk5bEJ6S0owa1RPeSt6RndQTEtG?=
 =?utf-8?B?dGlOd1VndUZERTU4N0tmQVVlTUNyR3ZrYWRoU2hpbnVqblJ3c1pydmgrM3Np?=
 =?utf-8?B?alhTVWVyMGEyQW9YYlRLeVc4T0d4UG9uRmtpa1Uwc3FZbVZ3eXorWjY1dWFo?=
 =?utf-8?B?cXVxN0txNCswOC9oTEk4K2pLVm0vOHRHQ3pkZG13WnducCttTTVpcWxzQkM4?=
 =?utf-8?B?Y21VMXRwRTVHUS9OdWxsNkJzZTRMQmVKYnU4SWNLK29WTnA2cFl1RzVncGhU?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a92efc14-06c6-4f2a-8cb4-08db8311c121
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:54:08.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m7y/wouvFqIdKp1BtRdmlkC2/FPWmSnBLKbpEjnvhQk1AeBt7hEjgFmaaLFuMuWrQ5CWX8FMPYwmY076el5TDzEiYVId7+0wcM/0OXT3nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 8:47 AM, Simon Horman wrote:
> On Thu, Jun 01, 2023 at 10:42:41AM -0700, Amritha Nambiar wrote:
>> Add support in ynl/netdev.yaml for napi related information. The
>> netdev structure tracks all the napi instances and napi fields.
>> The napi instances and associated queue[s] can be retrieved this way.
>>
>> Refactored netdev-genl to support exposing napi<->queue[s] mapping
>> that is retained in a netdev.
> 
> Hi Amritha,
> 
> This feels like it should be two patches to me.
> Though it is not something I feel strongly about.
> 

Thanks for pointing that out, I'll split this patch into two.

>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> ...
> 
>> +static int
>> +netdev_nl_dev_napi_prepare_fill(struct net_device *netdev,
>> +				struct sk_buff **pskb, u32 portid, u32 seq,
>> +				int flags, u32 cmd, enum netdev_nl_type type)
>> +{
>> +	struct nlmsghdr *nlh;
>> +	struct sk_buff *skb = *pskb;
>> +	bool last = false;
>> +	int index = 0;
>> +	void *hdr;
>> +	int err;
>> +
> 
> nit: please use reverse xmas tree - longest line to shortest - for
>       local variable declarations in (new) Networking code.
> 
> ...
Will fix in next version.


