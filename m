Return-Path: <netdev+bounces-40847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091127C8D53
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CEE282E96
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068F1CF8C;
	Fri, 13 Oct 2023 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/xlfrY5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053762135B
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 18:50:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F195
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697223001; x=1728759001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NbbkJVlg85Q3TebX0MEODfYuiG2byWR0enWxMJCKB8k=;
  b=S/xlfrY5buUpDdM5W/Fe1Dsf2xY6RFWbQutWcqLvk3nBCEhmfRzbJ4Xv
   WuHVt9cUPlspA9oIJ+dd74wbNAkRjiMb7ok2X/3ZlpE132gRALRAusIHz
   ozx22b1AJY28XZXI/JJzxbqn8PaaTH6sbP8Me316Y3o83cq1ukGsuJ1MQ
   aFLa4cdU+O/QdRZ861uy4ZPwp/gCRLAOc0tW7OlSxFce2+6wgVPZp/xDd
   ioFHeKGl4eZuIZJQUC+RUIU/34Lvmdy6D5SVKhxQW3nuefWwk/KFy9qGr
   oFiAWrMEIFJGHkEvfafgXgKUPO3ZJtet3CDl2V5hA0IGlDLUt8WeyCqqg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="416296392"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="416296392"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 11:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="871192230"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="871192230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 11:50:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 11:50:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 11:50:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 11:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpLquqem4DpUD4KSq4nabQ0jLpTgBrtNfzRvo4Q02egQPbm1m6Xu5IZqAXGYhtDzCW+FpUz0vluwfqPRRjKk66L9SmyNukU9/XEbkmYVSkd+XXuik/nxE6gRjz5xavhrqnr3+sR7bE8SJgomJeJh+NVI+POMtiRdKP78ggL5d8mfeqh8sfeNjdsuuBlH9q7bxuhT6AqJ/RMDoE4JNUngZ2Z2Byca+fhhMLzsdthecme+dink+AJl0QbrEBHXYSAafp3RbItfC0mnQkz7unOJLtfEtQOvy8aX0cNkmEKyv9v9bYBtH6Q5AbqRpuGMc2q26eQAF0RhAJlZJY9AbOeWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtxuCFVQ3V1+eYGEs7zSsfLyrxC3qFCq3JHz4BMCdFk=;
 b=B9z+7w+UYNE9J0qbffvhcvDk28kgbrFhiuvqSbQSpR0smTPJwX+J3ObymNVa1L03RI6QrKapd+hPB3uo34x6k1mpCGhAhqm1DWrDnxKEXY1febEUl+lH8UTO1kovTn40HX1uT5J1G+ssfxmeHUkJ8OqpbxKMe532S3MGOtc+t83OOHkLj0kMkg0WP9V3Ly/KweVx+S+5R7futibIntxUZHLFXhzoXNg4u1b0H3wZrgTqozM9cyG5HdaxETU47hMcsVHIr5f57NR5UIu27vY5/9Ys08RSKSf41v+6+CgwWYh2Ag5giAKMstyTPZPn3VI0uyu3g4ZnLaNy4g0O1fe3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8555.namprd11.prod.outlook.com (2603:10b6:408:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 18:49:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 18:49:58 +0000
Message-ID: <30e453ff-7d40-4a34-8017-e5c02b0c6e73@intel.com>
Date: Fri, 13 Oct 2023 11:49:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<johannes@sipsolutions.net>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010115804.761486f1@kernel.org> <ZSY7kHSLKMgXk9Ao@nanopsycho>
 <20231011095236.5fdca6e2@kernel.org> <ZSbVqhM2AXNtG5xV@nanopsycho>
 <20231011112537.2962c8be@kernel.org> <ZSe8SGY3QeaJsYfg@nanopsycho>
 <b8705217-c26e-454d-a7f7-d24a4d8cbd0d@intel.com>
 <20231012171532.35515553@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012171532.35515553@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bfbc3b-5b23-4193-a64c-08dbcc1d32a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7hiVva9wIWRdxgmVcF0dQq8tSj1W/20m0g15bb64HwNRGVgfg5wu+cQTfrEi34Bipk7K3C0Mc6d3QAzIvoDdQFAOARzPcca6eiervMX+gS5bwJIPg4RrZ9PRE9tzmga47nvQuiMsJnlM6/DuURCANaYb3S8X7kYJYubyHzn/+2m9B88j7gXy/WBSawsHCSV713OlhTaN4fQct7g5IupEXj0GXojlNGcG4qvP/rEz6Ft+Y41fCoiVcUUwbbqqG644/CRTzVwXTlL3B2moL1/TZPf/xuxAu9/t/LyD6+eGSx8ocryxJ573QzFkSX6j3X3KUgWxJZfFXZ5cfTXFAPMV+8Rg4Td4/UrjtCIbhQAFJGHluwsO7HVuIGb9Uf6dosU5Nhrkxhd1e+LkBICPG4E2Xf/L2e7+kAdN3pvj2v6vIh9q30VLOZ8+klQLxwOcyuDw+5lvVNduSOK1ByarSYK0G7hkcIqqN3KVNXYTxrNkRTGOyvBlAzw2fUt0GW8Gmh12tMMnSrgP7VMkjzOspwwz0fFAexnZm5wJGkTqK3tCbHydVzpiDi8lxbCnvhStAXEHyY3zywJpaI4GdpUPHdzfKQUPOteIdCJvgh8cRlo096R2y0UmiTHhvRNKmFcOkXShwK8LDX+i0zpb8I0P34IKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66556008)(316002)(66476007)(31686004)(6916009)(8936002)(4326008)(66946007)(8676002)(5660300002)(82960400001)(41300700001)(6512007)(4744005)(38100700002)(2906002)(2616005)(6486002)(26005)(478600001)(36756003)(6666004)(6506007)(31696002)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZnU1FPZUxpeUVqRkhtNVFVUktIRk1hdVZVVlR6eFl1aFNxL2h0bVJHTVJt?=
 =?utf-8?B?eXJkbGo5aXZERHVaTEdzTzU2MEcwNTdDTzU1b1hVV1dTbmFDczNGZ2VzVlQx?=
 =?utf-8?B?S3MwUU1mby82RjJpcGtvV0FkUHVDVDZ5SXZmTGxVUmpOS2JKdlRyekltYXg2?=
 =?utf-8?B?NkxEUzlMbHNYdjJRVk05TWU1V3pyRklVWitNSThQcTFLSnVtbmI0YXFGaURD?=
 =?utf-8?B?eEREOWZhcXZvQmJmVFpLa1VIT1J0cWcvMGkyU3o3bXNodUZmcER5QWhrZDky?=
 =?utf-8?B?Ym5vcnpMY3YzZXl5VlJmdHpVMk1PQ3NsZEM3RG1Dc2NoWm1DWEZpQU9CSThC?=
 =?utf-8?B?L3MwL3hWUW5adXg5OGZUWTBESFZaNHJUaDlWZmZmTlN2Q1JYMHNkMDM0czE5?=
 =?utf-8?B?aGh6TlhUMkI4djQ5anduNDQ1U3BzRDk5c0VDaUxRWWNOVTlWYzVZUHN4SmNy?=
 =?utf-8?B?NmVKQ0pPZE93VWZZcytKN3R4L00yVXVVVUdUakVkNlQ1M29OaGM3UkJvUnhx?=
 =?utf-8?B?SklsWld6bi9ZRFdCOENSMDRLSFJDMWlKeFI0dU00TURwYTM3WFhDdmlGaGh0?=
 =?utf-8?B?WDNHaWEvT25qcHV0QkZWcVRQeC9ZaXBYam5STlkrRWlGR3NOWkF3MGdVbVdO?=
 =?utf-8?B?ckEvVW94b24zaW0zTzh2cjBBVzVSOURQRHlmVjhPek9ubzA5VFN4cDJUWVNI?=
 =?utf-8?B?Y09kcVd0Ritha3krTnd5WkIyWWwvK2h1QmlXT0o0bCtkNXZYVnlLYzkwcFFw?=
 =?utf-8?B?aHUwYU5vWGt5S0dXeXNGbUJKbzVRS0Y5d1NDM3VIV3h5eEdVVlZ1MkNZZHB1?=
 =?utf-8?B?WGkwY1l2Yk84QXp1MTJLVGJBeERWMGVxZCtSZnR6cTZJNUphTHlaanByUzVh?=
 =?utf-8?B?MFl1cXc3YmtzV2QvL1lkaHNxOFNVeEV5WHZDMDAyRDMzU0hpMVNtaURjUmVm?=
 =?utf-8?B?WE9nbkVRYTRVZVpTUE91eVhvREtVeUZyMDNpQmF0VzRKMlN1RE1YUjBzck1D?=
 =?utf-8?B?bCtPdHNkYkpCbC95Y1hTcFhaejBVckphMUZScGNDa2t1dTJHNGsrakREblNk?=
 =?utf-8?B?RVdvSFUrWmp4a1pYWUlKZGtOSkVwMFZTeEZIYWJXYkMvNDBjeXRDT2NRWEx5?=
 =?utf-8?B?R3MwT2dzMVhiTEM2VmtuQ2dvcTNXSGUzbTZweldFSy9LZk4yMDVtTW1UMUNT?=
 =?utf-8?B?V0tRdU1MR0w4Z3VNK3V1bnkzenNIT1FBekN0YU9yTFdzOUJXeW9KSFFQaWUr?=
 =?utf-8?B?UEthdWFJcEkyQkZUMUdOekZ6WkZ3OGRFUGliTHE1REJWTUtTaWJvdWVsdUtn?=
 =?utf-8?B?bUxsZ1NBd25DUmtoamozR3BHTGZQbS9pTElXWFM3dW1RNmRWUVFHTHFNdUZv?=
 =?utf-8?B?dk9RTDNsVUdIUTk2T2EzT0ozWENkZk40RjhLd0RvZG5UTEpZdGR0RFVjT2Ns?=
 =?utf-8?B?QmVtYlV6RlVuczMrdjBpRS9CQWxlZWlJRmlMVStGNEM3ZnEyTHBVcldXYmtX?=
 =?utf-8?B?bE1DTlV0dEkvV2FFTUFZUldQbFk0L09Lb05aa0ttSUMzUlNHUFNUYnJZZzRW?=
 =?utf-8?B?RkNsUytqRFRtSHRhSDlkb0hvR2ZZMUpFajZCT2NhK0lzditqZ0liRmxuVFla?=
 =?utf-8?B?dVJValF1bWcwSUNvbFRTWnlMYXR3bHJ5ZThocUl3ZFNwc1FmNVN2V2QrT25K?=
 =?utf-8?B?MW9CRFZQeE9Tb2xyMU5BUE1CNTZOeE9XQ2xQaE1BaTlicUNHK2NTRjUwNjZm?=
 =?utf-8?B?MEtkU2ZqYWVZQzhhKzRHbG8zYjlWbkZlOW1vQ1VjTlNWcVl1SlZpR0xxRmcw?=
 =?utf-8?B?NzduU2VDNkwzZUFpT1J2clJLalg4SUZLSXIwemJndmROdWlWZHlueCtSM0tD?=
 =?utf-8?B?Vndrd1hiUkxVU1NuNjVhRUtmTmlZci9CbEpBNjI4WmltSjd1TllZOXpyM3BO?=
 =?utf-8?B?NnJPTU8vYVlNVTBwenlCZU0zUEQyYlEyTDVITWMwWDRYTFEzbFc3QWhuckxr?=
 =?utf-8?B?RTU2eEVwNXd4YUxNby9vV2dFZXRheXpaT0hZdHFEZExVMXg4aWxuL0lDekhn?=
 =?utf-8?B?NEhHcDB4N1dObi9WZFBYQnJzdW5jb0ZSWVRzTzRhK3ZyYVNSZVh4dkxtMW1h?=
 =?utf-8?B?cmQweHJKdERERWJFWEJLYVpFenBIZmNGRnhNQTM3Ry9zNDQvQWR5Zm56Vm5y?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bfbc3b-5b23-4193-a64c-08dbcc1d32a4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 18:49:57.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Muk858HKo41UM81rEjDVvdpycdtBuHrE1L472NvJQGJCFms39hQvANrE5ueqmgzTfRyPcItOjrtJHBh0Uc55VbSVPuDYNi7xrxMZBhn1yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 5:15 PM, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 14:06:57 -0700 Jacob Keller wrote:
>>>> - it doesn't support "by name" operations so ethtool didn't use it  
>>>
>>> It follows the original Netlink rule: "all uapi should be well defined in
>>> enums/defines".
>>
>> What's the "by name" operation?
> 
> Instead of sending the full bit mask sending the list of bits and what
> state we want them in. And that list can either have bit numbers or
> names. Looking at ethnl_parse_bit() could be helpful.
> 

Ah, yep. Thanks for the clarification.

-Jake

