Return-Path: <netdev+bounces-25494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8777454A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C15281768
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681BA14298;
	Tue,  8 Aug 2023 18:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0F134BD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:40:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340DA16F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691518004; x=1723054004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3KTFfApKpw4/I7UBmfaAq3RN/a2lqfTDLdK2tB2YNbw=;
  b=KpIXFuh2B4auW95JwgufPCMMIVIdzCnXL/UaR13iB1dekWlHsVxouHMd
   bdEtiCoL2z06l9NqaoATAmRNszyHWq4GZepBGDdu0RfkVCnSTov4U6C+a
   Mr/TOZzpOV5XPKykk7fxJoD2MhErXNDyP4+7cFqhw00Gqlc5ecUH073bI
   zYXCeRWTy3OlmuzsNEUfUcCE5vfdUj8pjgts6wogTNcSYdCxOHS2Z9Irv
   wUtJft4V++0Um4azkwLWhLfSJKwOhQJL+zUFNkfP2IQusgdmEv1roKvH4
   L/jLKggc3IIYFE8ZlUmNCoRh6rNUSptOtBoWp4GZ8FJrBwXX0yM1tyOl9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401872850"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401872850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 11:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874874319"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2023 11:06:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:06:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:06:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 11:06:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 11:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkJOClhiwFi/Hbpcg1ogiyUz3efzbJKpG8HOW+kfKhO2vTTYnD89ldfve3Hxkfm77dfPabr1npmq9gpJtVtNlSJrDVQjjRj6nDu1TJzQ0tWMNs/m1Lit18NVM+C6eif0qTwKI6OLx2cZ8gF4yNyNZEwSDCvMFmpSINqTb3RsaRw+0m896jOpU8NmWdkGWiU+qDsfUWojCKwe/BlUXOct1j1knqiMe5BJovbpv1eeUiFsM2WSCDmlWC1FJzlHCyEl7oze6QR/oISd2zAj2E9cfR/uZrF7FPSfDqRV+t4IROUHkk7S1f0aIO/3wdL3Auub0cEfIwT1yX9ciDhBNWHqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/kAb/MTQAsMa2JrN9GlohArD1NvH56BZup6HTKLzEs=;
 b=kKyKyrncLRShJDNfwyVGCLFhy0j7p6YLvt/D+URO2ZKKGb2FOQiK2XKqd/FaMpgRmbR9hLwHqZLErQ33gOkuNkHn/Pe8YAS3H6NeFZ8iKEIEwXuDmvE4q0WjMn2fT7KOq8YpNRQ9KG7IGi0S6zIZaHJD5w6vEtCfUoSHPcKEuy3LHPIO4WmreWKVxoc4zGgqf+uMKoPgqi7wFYSkJT3rSaWbxjly65XKkpMzZtaftrJAuz3mcr6ujDFB2WWs6kUOwvGFkG4v1Fhfk7mAjYk6K5tTREhifUJ0AakIsynsQyRlb3d+SQfDCvwoK8/NVH/vMcjoGvtrf0b3h5FxPXOK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by IA1PR11MB6442.namprd11.prod.outlook.com (2603:10b6:208:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 18:06:41 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:06:41 +0000
Message-ID: <9dc74634-9c06-de5a-b1d8-537943c29e86@intel.com>
Date: Tue, 8 Aug 2023 11:06:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v3 1/3] ice: ice_aq_check_events: fix off-by-one
 check when filling buffer
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>
References: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
 <20230807155848.90907-2-przemyslaw.kitszel@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230807155848.90907-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|IA1PR11MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: d3039b51-7b1c-4911-c2b7-08db983a376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSxv9rm+4Jzc2dfnqLbrLVVlyq/JYG/iF0UWfOz+oflxfOAoZjSST9SNMUUKlP0ijekzaGDCiFf9RaNmL087Z8+r8G6f0tgLeFg/2X1oMIby6HT+d1+3P1j6lPAaadcjwYbJ+iAVyls7hd8wI/9fQ87Hg+glmXEqKPVfpcp0UaPRNkF1Ie1nuLKacMTNs0sHQ6PlTn2edRRvSyTV+UXHNKDWAwLNyYxcGtk2Ux6qR6f75o67nldgjoXuyzoWzHJVxVHztioQHnmbyy+1UYg0w/GUy8BWcspsVyudIdR5bz529kc0w2wAsgaBc5x7WJSXSHQiyt6PNWlNiXHeHyBv1biZeCS9JxPpTitGspR9Q9/7P4wkNFEjfwghNXWa2OBCM81V84d2GLnkC4STPftby8/idMFq3WlbLGxxAiZMHwWwHKzEwzekXU/VHgvu2gZN9ek2CyHAM4CbfkMqF+vfMFvJ5S+NTfhy2oQdK50BMYkjiv5kO+WyjNyt+yReg4DI0UxHTz/JB6P2XYHIs2jZ3n5v9WjnapfkwmG/OMAM/gRjvakgrV+Evt2ztW44C6tv81KSOFkgjR3UtFT0FMVO6RcptrU4HibJ55lURpqJc8jGPQ1kHM+7Og4S3qbluhg6ENgGFJ1qcEc0C7hZ+7qQRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(31686004)(2616005)(2906002)(54906003)(4326008)(316002)(8936002)(5660300002)(8676002)(38100700002)(66476007)(66556008)(66946007)(6512007)(478600001)(82960400001)(31696002)(6666004)(6486002)(41300700001)(86362001)(26005)(36756003)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXNiZUJjNnhJUHF5U3g2WVRmc3NtSmxDMVFGSW1SS2FJczdZZmZEU0JsNWJL?=
 =?utf-8?B?MCtHcklGVXh3OVRmUFEwMHJMWXdRVHBGQmx4YWJGTDNhOTJBTUVzeU9XcklK?=
 =?utf-8?B?bS95eDFmRnFqYTY3cWp5M3FzU1FaQnpwQXdGd0ZBVUtGQUVqODArT1Rqc3o3?=
 =?utf-8?B?YVF6UEVXaXVRci93RFlsdm1QOGZYWkRJVUk4a3Y4OWZlRG1JaEh5NGtjTkEz?=
 =?utf-8?B?cDhTT2xVNmROYStIenYwMEpWNmthMVhKZS9FRjZXYXY5ZU9uSi8vTm9IVmpn?=
 =?utf-8?B?ejdFNVNVTzlGMkwzdFFhS1l3YkwwSkR6cktheDVxSTRUeFUwZGk3S2hsNC8z?=
 =?utf-8?B?ZktyVzNOQnoxYythaWxHeGxDWXNJRGFJWTVIT1Z5YUsyV3RmdThXZlhkd1pp?=
 =?utf-8?B?ZzFsZXRXajQrS2FJVWV6ekY4ZW9TdVNieUF1Y0xjN2hWV1FZZG05VStqeDNK?=
 =?utf-8?B?WHNjWHA4WkU4cE5aTUNXTDJxbFRxRlRDNXhsb3ZjYTBkVjRaVnk4SWk2a1JI?=
 =?utf-8?B?Vm12YTVRVVJlVnFyRmRlcmtMdm5aQXJETXJ3eWU3a3J0K2hEUjJheG9VbW1s?=
 =?utf-8?B?NUk2M2hOYzNBRXVYSVZGZjgvMDNOU255Y2RSL3ZqaVU5VXFwTWU2K3R5UVBy?=
 =?utf-8?B?YUhDTDZjR2lITDR1eVBoaGgyUXZTZGsrQTFzUVViOUE5dGJqSmJOaWs4ZDJH?=
 =?utf-8?B?Y1FKVi9sQitZOVJ5aThVSVBQK2xuRDBaSVRTbXpES3U4L0dvdXFocmRUUGtS?=
 =?utf-8?B?MFJyVzEwOFFDSzQ4ZjNkbVN3UjFYU3ZRYzVBWHU4Qmp0RDJrY1RhdEVMcVVJ?=
 =?utf-8?B?VWZBdDM3bHQ5RVczcjd3OUpoVVN6NitrSk1DYTd3a0VKUDhVZU9RbkdKVXQw?=
 =?utf-8?B?ZGd2MTl5VHg3NGRTNzVLMDhmVnVNQVQ2V0crNU4zbnBvN1FxK0Z3SDdLd0Z0?=
 =?utf-8?B?Vkt5WFhUT0tHbFlqQ1NmTkEvZUFURXcxRTdhVU1lUFhydmlOK0M5MktPTTNY?=
 =?utf-8?B?TlBQa3dsRkpCOVVCQ2VRVHU1VVpOT01rOHhtcGlOQjRRSjVXZFdCS1oxNHhN?=
 =?utf-8?B?UjBXQ3lEcUFKN3hjdjRNdGZtRFgzWjNqNEFOL0NRTnAycXBLNmVpak8wNTFt?=
 =?utf-8?B?UC82b0pWRmRDQmJkZVNKTXJHd0tpR2RQTEpQTUdidnY5WEFwQTU0YkEvWmw3?=
 =?utf-8?B?Qmt1bE0wWW15QU5MNkhhZmd3bmRkYnNwWXNiWjJ0Qmx6cFlwZVpYek15K0tS?=
 =?utf-8?B?c1BRMWZmNGp5dWdaNVExc2pNNEdsY1ZoWHR6Rk1YK3luZTZ4aTZ5Zy9IV3Bn?=
 =?utf-8?B?ZlpGRHFNcHcxSUtWall3bWQ0N0pPc2xOVU1TU29Wc0xmOGVSQnBQRENqTWph?=
 =?utf-8?B?WldKNEUvNEpReEVnZ3FsK0dBU3hFQmFYZnhtMWV5d2RYcjBsWmU1T0x0TFZz?=
 =?utf-8?B?WVNRVlc5dk94bEh6MDFNNDNZejdGbk5uK0dITGRKMERXTE04Sm91Z1lpSHJJ?=
 =?utf-8?B?c0lkdmJBQXNocC8zSHljbGp4enl2TC9WUnFybnU4ZUFTWGpmNVJXM1BRNTF2?=
 =?utf-8?B?bTJ3Q3Z5VThHeGl6NXFxRU5DNEphbG90RHlKWENvNnNQOXY3MjZGekg4Y0Jv?=
 =?utf-8?B?VWZEaWd5K1djcmFPd1Z1c3E4blN3NnlELzcyOHpxSnhlVElSUHBybGxJNVVE?=
 =?utf-8?B?WGg2RVJUVGVJSFNSZVE2Nm1OdHk4dzhVcy96VkJsZ01rUGxxeiswS0xOd3hY?=
 =?utf-8?B?clVCZktOSmRVY3JXcmd6RkpwZk1ZbDE3YjFpNEEvS1VhN0RVcElBRnY3b2Rr?=
 =?utf-8?B?RjZ5Tit0UlpmOU13TU5sOWRIY0lPQkpJMEJZemlMQXZPLzIwd2x4WWpQVmV2?=
 =?utf-8?B?b1dvZzBXYkwzRkpyM2lSK2tuYTd0UitQcWRGZ3pwamxvU0JaNGRBVmt2bktQ?=
 =?utf-8?B?UDkyQ1VHTlhRMGg3bVFQTm5KUlJ1MmdaZGxkQTNLUEtwU1RFelFvWGlUaGJu?=
 =?utf-8?B?V0dZNkRzbkhncWtNdno2Tjc5aDVPdlZKd3dOYWpLdlVxYjUxQlBoZkVCYS9O?=
 =?utf-8?B?SUtqZTRkYmdSQi8rNnNzL3NIRmJoelJkNDh6dHlkemgvMFdSYVNwZ3hMZGts?=
 =?utf-8?B?WlVHdjRYSkJVaFVpeVhXWHNRK01aajRXdVFtbzM4d0dwa1EvaTdyaDBXUytH?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3039b51-7b1c-4911-c2b7-08db983a376f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 18:06:41.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV4t92gG1fwUe0IrFN+o94zfnNwc9zBEWNngJQMgm8A0FI4tsJK0ya61klI+BjGb1pkDx4yQTmwgwKILZuBrL5/niFmf2ijexa/HIN6zIM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6442
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/2023 8:58 AM, Przemek Kitszel wrote:
> Allow task's event buffer to be filled also in the case that it's size
> is exactly the size of the message.
> 
> Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a73895483e6c..f2ad2153589a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1357,7 +1357,9 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
>   static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
>   				struct ice_rq_event_info *event)
>   {
> +	struct ice_rq_event_info *task_ev;
>   	struct ice_aq_task *task;
> +

Accidental newline?

>   	bool found = false;
>   
>   	spin_lock_bh(&pf->aq_wait_lock);
> @@ -1365,15 +1367,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
>   		if (task->state || task->opcode != opcode)
>   			continue;
>   
> -		memcpy(&task->event->desc, &event->desc, sizeof(event->desc));
> -		task->event->msg_len = event->msg_len;
> +		task_ev = task->event;
> +		memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
> +		task_ev->msg_len = event->msg_len;
>   
>   		/* Only copy the data buffer if a destination was set */
> -		if (task->event->msg_buf &&
> -		    task->event->buf_len > event->buf_len) {
> -			memcpy(task->event->msg_buf, event->msg_buf,
> +		if (task_ev->msg_buf && task_ev->buf_len >= event->buf_len) {
> +			memcpy(task_ev->msg_buf, event->msg_buf,
>   			       event->buf_len);
> -			task->event->buf_len = event->buf_len;
> +			task_ev->buf_len = event->buf_len;
>   		}
>   
>   		task->state = ICE_AQ_TASK_COMPLETE;

