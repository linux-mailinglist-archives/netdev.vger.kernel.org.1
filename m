Return-Path: <netdev+bounces-40337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C558D7C6C77
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B82822D8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053EE24210;
	Thu, 12 Oct 2023 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJsPDKJK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D9249F2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:34:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794DCA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697110468; x=1728646468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EcnupTD5ay3jZMbnLhOKWja7EjD5m2pCkP2OHQ2yalM=;
  b=hJsPDKJKBUMaPvyuU0BEaVeAUJ/pixrepwQirNo4Kh2BrlC90YKvu59k
   gPWjaA/ja57lN5yQya8CTbVIZDsho41qX+l57JhFioNX518CCSECX+yYC
   HwD8QASYH6eQ40hfUT8R4+7Vxjzi6tYuSP73bhCIgLVodlAFbLklXiVex
   0jQt1QJG6SRN8HmoFUTZxoAwPLn2Wg8OcFQRT0Tpyom97pl0RMfxp/Ffh
   3rD19VTWOUr2ugwFdC5Xxhv2wburv/sSMjwaItmBqhH9cX05T9eNAxVNN
   /F77oYF7IhP+hKn/vbSvRqDsKb0BvV8QL6eDVtB3DztLEWAGAeT9Xg1L5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3490873"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="3490873"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="844969012"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="844969012"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 04:34:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 04:34:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 04:34:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 04:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npc2sqOuIHrc92uJhiQ7Dpbyouq5E3uCfLgdDJndrUAh7OoCO2hs7qjZeqvM7L9HavQj15v2doMjxE5UCa1qSc4SOPu++N0j8visBGmomu8C9Wg083CdROCotpNn7LMfueEsZ/W7TsuGchXILW4S+plpxNfNcWEqKgitbuPbiiWeAAQTJL5/pb54CWYDORSMZ1dIReARj6EnJQZ4e9v/79XG468VD/kZprcDm2C7VGipQiU9nEwX2qq49K3DPDLwiDwjXBmBJbSz+t6fFK+G5AYpt6DNVjxlgaZwaNCEYWWZORtQZI96SWo6t07NFnAauJsmG30k5ZTcRkNbY7xnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39f3Kf2nJ7m2G2lC4VeRSMP8VDKxxXTLFva2vmEHHa0=;
 b=XjJFWWmfgJ7wfR32Crr1G3yg/VXqdSyNTc2F02IBX3A1MRcWSV1J6GexQOhXRplI+7mS+om51059qhij2WYixtefwyddT9C2jPQUaFEN580D27PQYG+d45AMttxGGJwJ33NfQggvOXIS2fwEQakG1S2RzdgZ0QKC5WkIyPcTPHoBVu9mYVRfaDmXMstaNg5Gqorli+6X1w/IPc5jT/7izmtONl2qDMnx4agUB4Ro5ihQTcLeyTZnAmSl5ahQRj+0L1XVeJZKB18Qt5jJjkoj6qX07//nZK+AIa7qzHzgev0tu07MFvLrTimVr0aXLWCNi2v2HIkmjpv299O4Gyd10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:34:17 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Thu, 12 Oct 2023
 11:34:17 +0000
Message-ID: <73314a75-9356-7381-41c6-087997fe9e55@intel.com>
Date: Thu, 12 Oct 2023 13:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v1 4/8] bnxt_en: devlink health: use retained
 error fmsg API
Content-Language: en-US
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
 <20231010104318.3571791-5-przemyslaw.kitszel@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231010104318.3571791-5-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|IA0PR11MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9d4552-a2c4-4644-75c4-08dbcb172b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytJpQpD/equxlP/aWu0owvuwdIz7SCBw5XQ7u/Na9w36nJF3XV4KadCZRXcuVVuAeuCeEXXUBWOAu8mtY/fE1T/ux5eu0wJ7v5Fje487ukL+ZNu2wkCABErgvIwA6yp0OZj9Rrv3RSrBn+trlEunrn25wKLuCxY46U/E1mdZZQvEPw5+QidWoxX40e/E/VVNTrF+kcLoWU8Bz8NUNMxgWz7JQJqKKk9iSgoIBpH7CIeFAagkJmPE3noDk1zadPU6WNpijfyhNWu20LjADT5bRMVgDKp+yFD3MW67/DJnZkjuVNLpDuch3SB2CCb6n1ntUPxEnWsIcG7qLPzgNvVKyPjTVYWnQ+0b/AugDlG88NOHUpPiVw2Pv3/Xj382a/+4o9Q8zjJXSN3HuG5w2EyO/qaT+8lE8f50+p/KioYznqhvsoCJfeD5Zikz5ijCU0kIA2DsVv+O/zoPYX4CRSKs+BYD98z1VIm4Ffxt0YJrzXPB5mcVd3xQH6ZgKVWWAAor8LHiplJT6bJ+RmbZ2QuAWD/3aJxXVTZ2hI8kkz5wGF5JlYtuKUmHJYK4kYnQ0mlCIrZDjxRQnKfOVyr5spYbBrfsS1zbsM765eUit79gTuYi+aFO+65ALkUkF4ySHhoHaGV0lkWChp+A6zBVIenKEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(66476007)(66556008)(66946007)(110136005)(6512007)(2616005)(53546011)(38100700002)(86362001)(31686004)(6486002)(478600001)(31696002)(2906002)(6666004)(5660300002)(8936002)(8676002)(4326008)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1KYmdTUmRJOWtRNkdPQzVDQktlVHFEMHVXVXpiWm1hc0dvRE8rS25ybWtP?=
 =?utf-8?B?Z1ZEdWtCRkRuL252UnBVZ1ZTMXhsMndWU2VKaG5QbzREaGxjcUQ5NVdNTWl0?=
 =?utf-8?B?QnQ4b1hlNlJjY1BuL1RoQjduN2dVQzQ3TnBwLzduWXk0M2JCUXJvWXZlWWVE?=
 =?utf-8?B?RGwxRHBrcTIwVGxvZ0pKdEhvUjJldkJMV0NTNFFyR3ZIck9qc1ZVTEV1d0hz?=
 =?utf-8?B?TjZENjlocGI4bGYvQ0d4U3Qzc2tXYmRCQzd3aWEwSEhFZG9iSzNYeGJzOXZm?=
 =?utf-8?B?c2lpWjBIdXhPeGlaZmJZYVF3eWptTGZUSC9zeEV4dVpFVFZabURST2QvWTlw?=
 =?utf-8?B?cXQ4aCtLQ3NqOE1YRlZKaTBVZ1lEdnFlUk5ndkJzeEpsdzJ0ZWNPL2liTlZo?=
 =?utf-8?B?eU1sRlZ0cjM2SXdnMUI3WHVrdnNqclRnVmdwQXp6WHVoSE53eXFNYytobTh1?=
 =?utf-8?B?ZFAyR3o4dThNVGtXK3Y1Nmh6endVUTgrR0VhYzNhZ0NzMitNSXV4OHpmaDND?=
 =?utf-8?B?OWpGSkVTWkk0bFhVOGFmSWxqcmlWc1B2WlE1UVlVU1hseE5kQzAvK1F2bEVu?=
 =?utf-8?B?dk9XQjJlUy9IMmhDV2VvV05vTnJLZU9pSkEydTg1VkVqM3p3YWJmZmR0S2R5?=
 =?utf-8?B?SzU1a014bUtLb3lucUZTMWR2RmFhTFBLcm82d2cyUXkvOEFQNGk5VEpoUUtZ?=
 =?utf-8?B?Ti9hcTcxTWFQVm45NktkSzBhV3E1dld3aXVNc0ljMWdMS3FsN1dyRmQwRnlD?=
 =?utf-8?B?eGdiNE1QTzNDL09UMnhzemx1UEJYNlk4QXNSbkxKR0pCamYxaHBLMXJlSi90?=
 =?utf-8?B?YlFHMndCeFNHRE1md0FVMk1VOUdxaGhXSGRoeHBRZHdpV3ZoSlNZelpDMnZL?=
 =?utf-8?B?T3RtellNTnhsdmNrcFNLMGJCdjFTQVNtSW5UNzJlcmhZR0l2Z0ZvbEs1aFN2?=
 =?utf-8?B?bWhWekJmMlN4VjdXdjlhblpOZEZWQ3VrYmpJMmZncm9Ob2RmYXJucUdZRG12?=
 =?utf-8?B?TUQ0emMzdUZPVWVLRFVkRzN2QW5Wa25Xc0dtUDk4ZVBHdTVWcENrZmQ5c2lk?=
 =?utf-8?B?QnQvT1NPU0VxRi80MlJUbUZadWRlZEE3OVN2REZxdkphYjlGOWpBR2pTR2NU?=
 =?utf-8?B?biswQnZNSVRPYm91MEJUQ2V1NERWSlVnMGswZWM1a0JYUVZVZjB4NWlEd2Z4?=
 =?utf-8?B?aWkvZ0tkQzdYdnVTZ3ZpQzJvVjBZVEhuQVVQNzZDL2RMSjBhc0VJNU5wTVVR?=
 =?utf-8?B?NDY3ZityUTl0TWdMa202UWdpSVNTcC8xSjZzYW9wSHZGa05MUzlyME5VU1Rj?=
 =?utf-8?B?aUNGMnA0ZVF1UVRISkJ0VHlJbW5nem1IbkpNcHlrb2hOSWk5azQ3VnR0VVdS?=
 =?utf-8?B?STFSRndYbjhoOFlHK2lzZm9iU1FOdC9aeWUzVkhwOWRqaGtGRFU5alVEQlFL?=
 =?utf-8?B?RDJUWGlaUWZnQyt2T2lNRkxYNndoTFhtZGZBL2JMMEF4QVRwMGVLSDBqRDcv?=
 =?utf-8?B?Y1hnWW5sV2NhYTc3VmVCdmpiK3hneFYyTDQxdnlvQ2pYTUFaQnBPS2RoUDJr?=
 =?utf-8?B?UDdZVU1rdXpoVlZVN0JEV2R2Q0FKN1NHZDE5dElOaERoM0o5aHJrcnhOMm1J?=
 =?utf-8?B?UlhRUy8wQVVlalJHUXJNYXdFcWxLSUxNQWJZeTI1RnhhMmlzY1JqVDY1ampp?=
 =?utf-8?B?RmFUQ3o4VWdSb0FpbDlhYmpIbk1KUnZkTzdZblVMWUp3Qm9OTnNwVWJRY0o1?=
 =?utf-8?B?b3ZHZUNhejZKS2l0QitwMmJ5NndrSkluOHV2NUhzQklhZmhtK012N1NGM3lM?=
 =?utf-8?B?dEFwQkR6MWM0NlVDb0VXejVWNmtjaTNiMHVkanlTR1RNOFhLWUJxVEtIMURO?=
 =?utf-8?B?ZjRXWWNZeWFBTmo1aUFEaUl2QnFKSUZNK3N1aUlEcGdYNlZQL1dsMG13aVFO?=
 =?utf-8?B?dFVZMXQrajhaNEllSXFpZnoxNEtxdTh3TTBsdWpmTVVMeVdGZitVTElCLy9k?=
 =?utf-8?B?WG9wZG1BU0xUUVFxQnUzZzdkT1FFZEFGeU9PL0JPaEswQ1Y5ZXFpbGxkN2pL?=
 =?utf-8?B?Q3lhRmU3dFlhNUQ5enVHVGcwd2pxUndVM1dwWm1HT0V0VXBGTWxMU3prU3BU?=
 =?utf-8?B?K1ZJVnMxMlMwcGtzVTlOUjBjVmdYQ0kwV1RPbWJEZjJSSHZDdlNhMzZnMEtO?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d4552-a2c4-4644-75c4-08dbcb172b02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:34:17.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yw15U4OHEjknKSo4pDA3TWy+gncWl1MQCKDGjUJLEII5V3/qX1b5tQE4as4ROWmjzI13bfb7qQTF/SmgCLoQBPka76TeddWK8wNFM1kgDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 12:43, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-125 (-125)
> ---
>   .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 59 ++++---------------

Two out of three broadcom recipients bounce for me,
should I add anyone specific for next version?

[...]


