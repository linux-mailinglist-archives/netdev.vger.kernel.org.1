Return-Path: <netdev+bounces-40335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB67C6C52
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175651C20A25
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B6241FB;
	Thu, 12 Oct 2023 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWsfxnse"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC71241F0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 11:31:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD55C9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697110263; x=1728646263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hXT+kXZt+1owSdsLPvE2KxnfTloxWQNxx4HzuviJcv4=;
  b=SWsfxnseQ7XC11XX13u0ma3BbKXL8k1e13DND8uZSb22C+2FYtKoZrgv
   mSBY6k7N1AOnGORov8Y8fdchAiab2KKmipRvZtxb3lWmDPVNsa0cX1WlZ
   ty99CeLGcBXfCGG83XVGm4TcxW5wuB7GR3MV/PsGaJrje1xxfGUJTsgur
   qW+g79Wt0mMz2ktTqrj/trBohzMBuxDwc0RM3Z696BERFqdr5u7KjYcTD
   WJgiBQYYtTFVzkTNLn8UaLI4cfGSKI61fPtpj8jgRAzEnZrXs2qn1Ayp9
   JJOe0baMiw3HqNiNM+E4AVX+CAP4KrC0LQjFHa2kYnqdFcxuHQw3J1JeF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365169893"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="365169893"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="927957584"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="927957584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 04:31:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 04:31:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 04:31:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 04:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/7eQYnbofi4TQTSuR1weKs1y8Z58rNc4kp32PLalRsyOdNKzVyvAdVho2dJFIg/UIE9wk+GKl9tbbelvo3Q66Bu3Nyv65z1Q5mh3paZ3CisfUk5mdrzPoza3sIQ8haiwXLx7EeOHG8JrGbL2tFv6mg1UT/dX6VSFnKLq5EZSvfCUhnPBSEvcd8o5f0ceO8vsh3YQCPQNwSoivVG6q2bnQLWdPn5S+RsnfUCLFNi3hYcc1D3QQ5hJbbTelNt/SFv8u96ZG0ivkUD2G1WyaxXKLVFX66z7KSBNRWxDOza2WlGfZNCfgLTV6geGiFk0NlblZigCIuvemfgxH/r589XmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+0DUCpKxueTv7B8CnbrVi2hl4tN927iwkBRxS4VkO4=;
 b=nxIR67gTj95S1ojfSrvJI4FKiKdESHhfHQSXyzfn61ttaJpCV8KbMqgI9Tbb/rsC+hNIUIJV8N/WS3KnrOarL3FtKotf9C/Xl08BghYvEOix28dfXoXTP487CGfFQh852GO6JQ+Y+exZTL3YG/s0KIPY/ttju686MQIym6/hOGd1tMUe2z2z4Rcg2HS1htbdFng/vzRug/FRNHj1NDVCPyFjYU7IcH/rpogjiWKX2Ehy4bKqtgjzF17uDf+cncfNWxFYZx1AWCHypg+me7fer6xMozMyrRn8LKsI12F9SGWuHPI8upJMi4g5XRMejuWe84WTV8xRaT9KGu2gtRXgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:30:58 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Thu, 12 Oct 2023
 11:30:58 +0000
Message-ID: <6f0474f7-343d-9601-d4e2-526f144dec56@intel.com>
Date: Thu, 12 Oct 2023 13:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v1 3/8] pds_core: devlink health: use retained
 error fmsg API
Content-Language: en-US
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Luo bin <luobin9@huawei.com>, George Cherian
	<george.cherian@marvell.com>, Danielle Ratson <danieller@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
CC: Brett Creeley <brett.creeley@amd.com>, Vasundhara Volam
	<vasundhara-v.volam@broadcom.com>, Sunil Goutham <sgoutham@marvell.com>,
	"Linu Cherian" <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
	"Jerin Jacob" <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	"Subbaraya Sundeep" <sbhatta@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Aya
 Levin <ayal@mellanox.com>, Leon Romanovsky <leon@kernel.org>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
 <20231010104318.3571791-4-przemyslaw.kitszel@intel.com>
 <0bd5eb16-6670-4f3c-b193-f83807a25bd5@amd.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <0bd5eb16-6670-4f3c-b193-f83807a25bd5@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|IA0PR11MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: e59b69b1-6afe-4464-1c38-08dbcb16b4d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPRaGh4cF6RWQ59sSjl/5MAQ/RakeujeX3+89zeq8F7N/IgguRA9k9QkG+EhcKlR6Zpw59e4GnQC6MDQVtC+yUiaCbvRC7vFILY/YmjeBW6GUTHfY6jLX6N8W/axvReDZpO0+uClV4o7i+maDXxPoePyyOzxtR+4TKkQbNpMGDl0fr0c9ymerhOyi5ALq0Bz6oA7Vu7aLHsMUEAmMleoiezktWoBwt9YoZt4xXAPQwMY2MP1AVCA4EiSffY9TwMMSjCO6Xzw0ZGPuhp429MnHxoS4VPnXoC782NLwNxu0wtYBwswodN9uutvmBygFMScIV8ssohMetb2z6rEszZtDP+SwbMgvWX3cZph+JfvIlMyknqi65TLZ2paSwYRVgiIRRQ0vDCTbe8B7koW8uZT3VyXpZ9Z5GTFc8HIhd2EJG6qhi5YJPgGWnCLzEWUU8cHUf2h8YEeN4BZqt8z63l2qEnT3qsxOewGHDsGUXbtHx06ELdI6Asg9VTWQBy2kAnIrH8HZdjRhUOvrz02J58aBBeuWBX6cmS+e32ob2w4Yk8/yX/5RAljxVZPR6GZds759qEbwlucuKbV7l1S0cpsW8F6uui7wrXDMm6KkvzWbvcLkIYFasbKWDdGNeLN4LjtPPG2UOTaBAtsu6klfyecGGp31hEA1snWxDJo9z0N9iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(83380400001)(66476007)(54906003)(66556008)(66946007)(110136005)(6512007)(2616005)(53546011)(107886003)(38100700002)(921005)(86362001)(31686004)(6486002)(478600001)(31696002)(2906002)(6666004)(7416002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czA3ZFcrSi95L2dSdm4xVjRUaWFJSDRNTXRCUnBjZDBvWEJQNFhYdWtka3dT?=
 =?utf-8?B?Z2pHNXNOMkZuSlg5MDVZTDlPZzVoVTVOS0NVbm9NZUxNVG0vNk02RlB1VVVM?=
 =?utf-8?B?Qy9LczV5aVhBR2FTVndQSlhpK0o4NkhyeHJpQnljUnF4UFhucGV3NWJQbXJG?=
 =?utf-8?B?YzJQaWt4OXovRmo2eTZGRDVpelE0RW44MTlLZXhRVHF1TktiNndoMFJTMlQ3?=
 =?utf-8?B?SHVHelBoZWt2UHUyTDNGUzU1S2c5UWorak1nYkkwbGZxbExrc2I5bWhqcGNn?=
 =?utf-8?B?MHozaGVLZ01HMmw4Wk1VU2EwSW1UQjU0cU8vaGpaUHlodnNxU2JUWVhzS1N1?=
 =?utf-8?B?b21PYlhQdkwyalQ0ZGZnWlJ0azBJMGpKNXFuNVd5djRpdGFyYm1HR2JpQkh5?=
 =?utf-8?B?VmxoK1k2emRVaVlyczcweTBidmhRemxSQnJjWm4ycjlEWkc4ZDdSNjZMM29J?=
 =?utf-8?B?Z0dtNDFtMllTalpaV201YTFrMXJ0eTR6VCtQTnR5eFhBd3dONDBqWFpkWXU1?=
 =?utf-8?B?dnB2YWNqS2dWNkwzbFJxVXR3cW5GSm1UcVFGMUtQVnAySk9nVUx4OWpmVEM1?=
 =?utf-8?B?UXExYkFuK3FXRlVBRlNqalBIcWhleS9maHVJN2psaHl4YmVsa2MyS1JNODI4?=
 =?utf-8?B?cUc1aU5weEpFY1dEb3ZUWUxHamp2aE5oZ2cxemZBWm4zUThEKzZnZEVQek51?=
 =?utf-8?B?RStFb0VseTVjODdLZkRuWHZJenU4QUF2WDJiT3RQUnZFREs1aEFGSXdqMEhF?=
 =?utf-8?B?SCtlNm1HWDBGemRCTS9uRFNHTXh1TmVtYTNHdGtCWkJKUG9URmd0YzNLalhH?=
 =?utf-8?B?SGh3ZmNzRUEvVE1ueWtHdnFsNnV2ZkFYdGpxTmdpY0I4bktEbVpkd3ZKU3pX?=
 =?utf-8?B?bFRBVUlTbHNrL0lFRVJUNmh4SDRyMmFaNFNvcWI1YXB6SVl4Ujk4OUh0dG9w?=
 =?utf-8?B?MHl5Wm5vTm00MEpRQzBkUm14cnNsODZhaVl3Z1hacHkxWkg4YVVobEpLWFp6?=
 =?utf-8?B?em96dXNWQWpqOGZTS0NzdFJpdUt4Y2xnYTRwaDlqclVtUzFCS1FFY1VKUDkz?=
 =?utf-8?B?T1lZTlpQY24ydVpRbG5aNE5vblk1aWpTeXIxZ1dOL2VtaDRDVnVwNXIzOXBt?=
 =?utf-8?B?elo5MWM4UU8zVWVNQUxRZHJJOXR5dXk0Q3pUb1RLUGl2cVlEUmRDTFJjYk51?=
 =?utf-8?B?WVg1VEI3V2oxeWY1RGU1djIxSjdIU09GaldtbFl6Sms2ME9WaDVObDRQaEc3?=
 =?utf-8?B?WnU1RFhGWmtteUhLRjI3UlJHZUVzYVhRNTdwUXhjT3lPay9mczM3QUFEZGpr?=
 =?utf-8?B?VVpEV3pORExLSzJ2dnF5QlNZSC9WcGtTWHd4R3E1NHdOUmlsU1lxaHFIVWg5?=
 =?utf-8?B?d3BYbUJIMEJrbzZ5TkFZaWlWWjNwU21WK2tPMndnQXp6RVFxbnFrVHpLNTF4?=
 =?utf-8?B?MlUxK3N1aThidVdheFBTU1ZSODFiemp1UFJVM1J1MEdTeEZpTnMyclREdUd5?=
 =?utf-8?B?TGtWc1FpRXUrT1k2UVJ4MjJRdUJQaHc2NTFLV29xMWNxUUt1dXBoS1ljOUJa?=
 =?utf-8?B?TVg1WWdBNmUzYzRVdmpJMzl0WXlBRFdzSzhXOTQ5TllQeFNFcTJSZHNCR3Fo?=
 =?utf-8?B?TmsrRktTM2N5Q20vT0ZuRlEzRmpnMDFKUzljNUR1dDQ2bWU5ODU3Z01ZYzNm?=
 =?utf-8?B?K3FRcWZHUWduOVRaajZPSWlZcEMxS0ZDRzU1bVlZblNwa3ZvM1ZjWHpoZ245?=
 =?utf-8?B?OHdwWERXaVdId3dWcGc0aXdweStQQmRoMXVqL0xMa2svK2RBb1I4VTlzcEcv?=
 =?utf-8?B?RFVveGlyOVFJZXpwR09qY016RFpjUElRQXp0S2VzaXV6SGZEbzJTSHFjYmdQ?=
 =?utf-8?B?ZnI5VFJkeXhvQTVRYkRIS3JuNjUwRzlicHNvZVRUaElRUGtHOWRsMnR5QW9Z?=
 =?utf-8?B?b2VmVVN6TVk3QjBYZUxBQXN5MVVYS3lvRmE3ZVNxSUFkU3lzZ3pqazNGQndH?=
 =?utf-8?B?bHNTYWVFbXVyZVprQjZmT1JZVjA1WG9CYURUdUR3OCtkZFJCZ0dtbEpYRG9m?=
 =?utf-8?B?dWYvVUx1NHVVK2psOVAvdjR1dm12VTcveStYRGxLa3EvUTFRVFQ4WVJwSTda?=
 =?utf-8?B?ZU54WFBsdEpLUzExaWF1Z2JMaTlvU0hkb1ppTFp4OU5iSjlZTmNEQzNqbUxG?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59b69b1-6afe-4464-1c38-08dbcb16b4d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:30:58.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBpouXVZMZz3EQnywA5tnyLanM7bwjCmVd8ie5spryCuP7woTxTh0prYdJrvq8/ia7r339jp7n5+1dlPqaopFrs35xg3YkAf8wmzc6l8eu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 18:53, Nelson, Shannon wrote:
> On 10/10/2023 3:43 AM, Przemek Kitszel wrote:
>>
>> Drop unneeded error checking.
>>
>> devlink_fmsg_*() family of functions is now retaining errors,
>> so there is no need to check for them after each call.
>>
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
>> ---
>>   drivers/net/ethernet/amd/pds_core/devlink.c | 27 ++++++---------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c 
>> b/drivers/net/ethernet/amd/pds_core/devlink.c
>> index d9607033bbf2..fcb407bdb25e 100644
>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>> @@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct 
>> devlink_health_reporter *reporter,
>>                                struct netlink_ext_ack *extack)
>>   {
>>          struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
>> -       int err;
>>
>>          mutex_lock(&pdsc->config_lock);
>> -
>>          if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
>> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", 
>> "dead");
>> +               devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>>          else if (!pdsc_is_fw_good(pdsc))
>> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", 
>> "unhealthy");
>> +               devlink_fmsg_string_pair_put(fmsg, "Status", 
>> "unhealthy");
>>          else
>> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", 
>> "healthy");
>> -
>> +               devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>>          mutex_unlock(&pdsc->config_lock);
>>
>> -       if (err)
>> -               return err;
>> -
>> -       err = devlink_fmsg_u32_pair_put(fmsg, "State",
>> -                                       pdsc->fw_status &
>> -                                               
>> ~PDS_CORE_FW_STS_F_GENERATION);
>> -       if (err)
>> -               return err;
>> -
>> -       err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
>> -                                       pdsc->fw_generation >> 4);
>> -       if (err)
>> -               return err;
>> -
>> +       devlink_fmsg_u32_pair_put(fmsg, "State",
>> +                                 pdsc->fw_status & 
>> ~PDS_CORE_FW_STS_F_GENERATION);
>> +       devlink_fmsg_u32_pair_put(fmsg, "Generation", 
>> pdsc->fw_generation >> 4);
>>          return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>>                                           pdsc->fw_recoveries);
>> +
> 
> Please don't add an extra blank line here.

sure, thanks!

> 
>>   }
> 
> Generally, I like this cleanup.  I did have a similar question about 
> return values as Jiri's comment - how would this do with some code 
> checkers that might complain about ignoring all those return values?

yeah, going full void makes things easier at the end

> 
> Going to full void functions would fix that.  You can add some temporary 
> "scaffolding" code, an intermediate layer to help in the driver 
> conversion, which would then get removed at the end once all the drivers 
> are converted.
> 
> This do_something/check_error/do_something/check_err pattern happens in 
> other APIs in the kernel - see the devlink_info_* APIs, for example: do 
> you foresee changing other interfaces in a similar way?

in principle, it's a good idea; personally, I will be fixing those that
I somehow encounter (like here, I plan to add some devlink health report
for intel ice driver)

> 
> sln
> 
>> -- 
>> 2.40.1
>>
> 


