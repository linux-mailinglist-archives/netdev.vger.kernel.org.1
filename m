Return-Path: <netdev+bounces-25576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DA774CAD
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106B12816E3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B251171D1;
	Tue,  8 Aug 2023 21:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE562171BF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:14:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF72D77
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691529266; x=1723065266;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dsd2r9GTn/nIdIbXBcHD0iVKJaae9BawkwQzCiMG2/8=;
  b=Oa4okeXZV4byhU4Y5E5T3py8y78mqIOoIC8ElNP676lu8SeG7QNEzc8q
   j+EKg2r7ZepDhqteNKClK/qJg6chUOaDFy99MVrQEBQ0seHqNvcfxWAg6
   kxqLxrEDwwpXK+MppnNm0EFvag9j4LcbNkYQwR1oAhijGQqR94TYlYb2f
   NGktRTCxDD0ZTtRyO7IMe2yw874w/pmqO3VYEanl2pExM0M7dfLUiKDal
   u7dlAKBmL2YthTvJ2ySIPYE/5cMb9bl2jDAG7a/o6CrpYg5RO4m6pqAPS
   6RUZYtPc/eAtdjvPXl9eZY6bvvZMgQDYWzDCM6C7VGirI6mc+v0hbMoZc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369858729"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="369858729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725106854"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="725106854"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 14:14:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 14:14:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 14:14:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 14:14:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 14:14:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjFDwldIO70UMyWeJn9BxoJfFEM+2Ble5blyJUPISmsKj3rTFUsaowUTwc+CeNgISveeFLyJVEylwC0m2jP68+tkn3zCY7MjBmTL4T1G72m6sF2vVNLB94NQvhWoWuOX3N4ezdtOx0y6XNOH3J21t6btwGzDFEUpQJmbyBI8ZWBLyowJBHdAhl2yGO1GRhLor/pbecQXRcMMusoAFN3YInZulF75Zxfp2EWgmuUqaczAzRByBJ5rD/I88EhX/enHJ0KC4HSggii6bjiWHI2O4JTn7VA4+QQYL1vJLQr8pEgB/fvDMtceQTC39E5BX/5J1wszVsnXDcJc8Gcxdv6xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynDwyRvhFP2MRtjSXbwz2ew48VmYORjZqVFH0qdYego=;
 b=WWqeUbewYjWfsZGesz5VG2dkfZ4hwGXgMOqOAMlEcX9m80hnRSQbCg+06OVAearQcUjWf7b4BKP9F0bY74VgMSQaX1iP0tx5ZRBrhh2Zl+zHR5yzSPo8mhbHUij+8Um1nEZJruzr1QPskBRdG/dokznUwkqhbn5NoRWnsabjT2eZfM0qHH205X60jyZwQVX+wiOe/JJeoXWQx5PKXOZaleXH8rG6URUE/uR5sG7AOKXyCqfdMCFf0wtyFFBSGOdpVaiY13WQhxi61lV6SiaD4cwRYN+Ck++fXPBwOsz2tn8ybDQLCvCYJoJFv6lgIRqDsoACeRN0OT2BZ+NxsfQyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 21:14:21 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 21:14:21 +0000
Message-ID: <bfb11244-79a1-c305-9a8e-8f25a242e0e7@intel.com>
Date: Tue, 8 Aug 2023 23:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next v3 1/3] ice: ice_aq_check_events: fix off-by-one
 check when filling buffer
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>
References: <20230807155848.90907-1-przemyslaw.kitszel@intel.com>
 <20230807155848.90907-2-przemyslaw.kitszel@intel.com>
 <9dc74634-9c06-de5a-b1d8-537943c29e86@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <9dc74634-9c06-de5a-b1d8-537943c29e86@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5bc0c1-0371-4b53-0b75-08db98546f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcbRncLGtFf9wrkmj30MjqK/wsnbbkciat9gk5b0Ek0tEt1cYkoGw37bFR54E1UJTtyq83Ye2S9j4lsWdyOW+gCZF860L+5lds57Xh3MRG6QXFKOyAWEn0FMiYjUcqFOaRkrO7mkq8wlBENnD1FuyP/3vPMhQds+nHprj35OQDD63aYxG9rgR+V6PItuBrq9GARsNMvC++Bx1cnYkWGozsuIj66AGjmDZ3RS1UVSpMtsMhgACZCFHwInZJkA1bj1PXETVXgsAszsQjslgJuWGA9erLJDN6bofzLHVtVzfoucdmiIviOsEcqlOtJdY11K7VuHyb+XOuG75Uji7+jDe7D6t7JfN5NmFuN+JUJXRZJU+ySwlZoadmZhBJWMktBsuoNxKQlmqmIm4fcu2nCILohPwhIwslbBPquXMxWlscDnglaHNz9LtjZ2HiwIzUE8wyTk2TK7EqNzjUskXvpAHtEm8ouiXo+jzbeD6auP2kQcXi2TubbQkdOpaHOCtkqLItmkbemEsKo0Vmm7vlgKz6sIu9/kDHkT8EXsYAMNjEgisbg2COBQAkLjOaPhcc9YFZbbp3RWgYK5Abr31cRtV0DZmjAfudMrZTkDomHDKrTeId9Z2prAWcQujqvq1Qn81SFFRyNzbWYVKEg5KvlNbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(346002)(366004)(1800799003)(186006)(451199021)(2616005)(26005)(6486002)(36756003)(6506007)(53546011)(6512007)(6666004)(82960400001)(478600001)(38100700002)(54906003)(31686004)(66556008)(66476007)(66946007)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(2906002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1IraXc5MXZ3cmttaWZFbUhwdlZJWFREL24ybEJiV0pzYnkwMlBpRnRBdmQ3?=
 =?utf-8?B?MWZxS2taR1VuUWZPVmtGcjZldUJPdzZXV2lBUWJ3Qmc1eEl1OEEyTEx5YzJ1?=
 =?utf-8?B?VFA5NWRPWDYxcG1sOWpuaGd4T0tTblp6cjMxMVJIZlkvRFdkVFNTTGx4UkJ4?=
 =?utf-8?B?S1hnWDE3R3NvdGs0S1ZXcE14bWVFNVk4aE4zSWVyQm56L1QxTEMyUXB1R1ds?=
 =?utf-8?B?NW40U0tDV0JLOGRSbk1ObVlLc2hJeFNqSFN2d25rUmNNaWNEZ1BEaGVUaXh6?=
 =?utf-8?B?RDNYR3ptdkNHUWRHSTlaaDFDdmpteXc0SENqVnZFNHJVL3hndzhIUHJYR2l0?=
 =?utf-8?B?eFpYSVRvS2RjcGc3bnpsK1drTlk3RmhmcXBLNFo3VzRRUE55RGUwRlh6cEdu?=
 =?utf-8?B?bnI2WFB1M3VacXExL2lTejc4M0FkeTdwbkQwelgrM1pPOW56eFFNU2ZWYTdO?=
 =?utf-8?B?V1VzT0JORmtSY0psWHJTOG9NUWl0bW1Va3IwS2V6bjNlL2daVFRvVkNCakRK?=
 =?utf-8?B?bm40dEhxWkwySWZWZFEyMGNSODA2YkFPZlcyMHhkZStJdmRoRC9UWUFVYTlw?=
 =?utf-8?B?eWdrKzBaclpCM1U5QjluUUVjODkwVkRFUEEzdWpBYTIrWS8rZS8yTC9HMmpk?=
 =?utf-8?B?RzI0UlZwSnlHU3NaVjNOVTFzd2h5ZVFyNzJXMmpwRHpISmZTOE5FVHRaK3dP?=
 =?utf-8?B?WWRHWTl3K2c4Y29UUTh0Rm5qMGFyK0tlZ1BqSHIxb2JvdmJIQkZRWnNNNjNU?=
 =?utf-8?B?OWRjMmFySHRhSmM0UWNpRUVxYllveGpkMm9nTFk4bHNpM2Q2Tzd0MFVnU2NB?=
 =?utf-8?B?dnByRldWaUo2TFVxell3Umczd2Q0bUFvb0RNSWhkS3h0RHhBYVRoeVM2L1Qr?=
 =?utf-8?B?L2tMdXJ5TDIyTDRMaTErN2FQVS9HVFdBRmN2MExLajVCdzhEcTRVVXR0dlQr?=
 =?utf-8?B?Nm84SlloR1NtSUZMYk9WdlVYTWtFcmdwYnBMOUxnUkpielZwV2hqVnBIVytj?=
 =?utf-8?B?bldFbTFleWlBTkZQNUp6elczV0JDVW9pY0x4SXdBd2RSSUVQTlNvTE5wemFL?=
 =?utf-8?B?SU8wb0pJUWZPN0tpaFdTa0JTc3dzVitzcnJ5VnJSME8vbEo5Z1dBTjhUUkNj?=
 =?utf-8?B?TXc3YURjY2RFRzE4aENqTkROMlByUjgyRDlNZWZiaXpvOVQrem9yUWhSK29y?=
 =?utf-8?B?RkdqNWE4ek5lSUY2Unc2NWp4Y2NiZkNrTXFTSlZTU2tTQlFlb2hpWmN1dGlu?=
 =?utf-8?B?R1MwOFlJZ1BZYllYWDY5TTZQUFBVSUlJZTNONzVmT3FHVXc4L0RjR3JWby9u?=
 =?utf-8?B?cTNSaXp4TGp2d25yblZOMzl1Q29qMTEveUFaQ2NjdEJyRStXaVZOTHQ2Nnlj?=
 =?utf-8?B?TEFuRXdTRTdnWjRoL1lFZm1kVVBlTnVqVFdXRktmT1NGbk1uTmFMTWlYZ2Fi?=
 =?utf-8?B?cklkZkZOWlhlSmxOeFVhcitmZE1mR04vWHNSRzlUTGIyRVA5dEQvYTRwMG5C?=
 =?utf-8?B?Nnp2VUtwWmlPNkdCaUxVVTlEOTRYejdMcjRUVjBnWlZVK0w5eHdZLzBsaHpC?=
 =?utf-8?B?TWhCT3NuM1UxS3F4di9jV0VQMW01d3c3a2lRZlhjNjR1YmRZcjRINXd2THZz?=
 =?utf-8?B?azZVajQrczRJcTlzVURZa1JXQ3RERi9WTWI3VS95RjhqWkthT3VVWHFidUla?=
 =?utf-8?B?OXdaRFZ4UlQvLzBwTjlrdlJlVlJKR2d1N0RYZkhwRmpvcnlxd2JaMEMzcDZh?=
 =?utf-8?B?UGJKbDhLeHM2My9sYm5Ub05yUTBFOVdPNW1qMEhFU1c3MVlrVWF3QjcwZ3po?=
 =?utf-8?B?dno2WExIODRZQzBUT2Npc21vMm9kSTB6NkJraGJINGhkR3JVby9nOUxnUUxD?=
 =?utf-8?B?Y2JpM2RlcEZIVS9hSW1QVzM5K1J6dy90R3o4b01sS005bFR5RzdjSFV3SHhw?=
 =?utf-8?B?M2RidHU0bjViVVgwNzc5bEFPNWxndXNoSG52UE9sVHlSWis5amN3cFhtOVRt?=
 =?utf-8?B?VGJhZXd2VENLZ1ZITW5yVkdWY0Vhd1RZYTNYR0hrZXI3T1JrVGpCWUVpMita?=
 =?utf-8?B?WmFqSitUNkNzSExsKzIzckVPeHY3aER1eldFK1N1WEFmS2xrVHdjUFlleTE5?=
 =?utf-8?B?WUdGbDBidHRLTy84K1hwenhDNFhwRnZCZ2o5NUUzdy9WOHI1RHg5cUFrSmJQ?=
 =?utf-8?Q?KfFjrJjDCejlRGG6fDTpj1Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5bc0c1-0371-4b53-0b75-08db98546f20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 21:14:21.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1AWzhOJpaJCiwWTep4x2fhx2JU+CeRG7JXniDogyAeE0xafG3ficaXeWQuJ+wOTSd83MODov53crLwQ21rCDYXfMsHbo4yWYUdXWuxHzec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/8/23 20:06, Tony Nguyen wrote:
> 
> 
> On 8/7/2023 8:58 AM, Przemek Kitszel wrote:
>> Allow task's event buffer to be filled also in the case that it's size
>> is exactly the size of the message.
>>
>> Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c 
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index a73895483e6c..f2ad2153589a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -1357,7 +1357,9 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 
>> opcode, unsigned long timeout,
>>   static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
>>                   struct ice_rq_event_info *event)
>>   {
>> +    struct ice_rq_event_info *task_ev;
>>       struct ice_aq_task *task;
>> +
> 
> Accidental newline?

Ouch, sorry :( and thank for catching it!

> 
>>       bool found = false;
>>       spin_lock_bh(&pf->aq_wait_lock);
>> @@ -1365,15 +1367,15 @@ static void ice_aq_check_events(struct ice_pf 
>> *pf, u16 opcode,
>>           if (task->state || task->opcode != opcode)
>>               continue;
>> -        memcpy(&task->event->desc, &event->desc, sizeof(event->desc));
>> -        task->event->msg_len = event->msg_len;
>> +        task_ev = task->event;
>> +        memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
>> +        task_ev->msg_len = event->msg_len;
>>           /* Only copy the data buffer if a destination was set */
>> -        if (task->event->msg_buf &&
>> -            task->event->buf_len > event->buf_len) {
>> -            memcpy(task->event->msg_buf, event->msg_buf,
>> +        if (task_ev->msg_buf && task_ev->buf_len >= event->buf_len) {
>> +            memcpy(task_ev->msg_buf, event->msg_buf,
>>                      event->buf_len);
>> -            task->event->buf_len = event->buf_len;
>> +            task_ev->buf_len = event->buf_len;
>>           }
>>           task->state = ICE_AQ_TASK_COMPLETE;


