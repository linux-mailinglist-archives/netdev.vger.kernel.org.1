Return-Path: <netdev+bounces-56088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FB80DCDB
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A361C20D34
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688454BF5;
	Mon, 11 Dec 2023 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayCo8Jrn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FBAC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702329827; x=1733865827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ppJKL+9e9U0RojkUBVDSdaSmbfvPSj1vvszHYmokt3g=;
  b=ayCo8JrnUlgjfv2TRJX1AJWe5gDV6fwreD64Se01hpSabbsMr0PIHVdp
   aKs9M+nO6ZdgaMLtArVAgiFuyxHQnKno1erMctZEH+IejErWgoHGn9w1A
   oBgP9P36Fsbg8Ae10I5ZXWpBilvbQxbWlYlvnMrZsHWRt/3HSUyVxSnog
   mBZKFLDnSKuXm06VaaWzThsOpLpMcIbhC4m9R+0cMjlDqFJsbcIWfEsp9
   62nO7GnRIdF7ivr1APjBRkNuIB2d/9ARE3Jp+wtfdslH397rUrfIIYwqy
   OG0/djXt3cHrOaeDdy40ZYgXUWZtRMqQuNNB2ZeNzNKl1G2ld19PAu9uS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="459023584"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="459023584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="722960581"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="722960581"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 13:23:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 13:23:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 13:23:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 13:23:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 13:23:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgwI2PFGQwOTMX21+mtnUxrgEq+iWshpUeYBQDaU1cML5aiYvvnlKtyNsiuQ+jPDd1QWwOM/WD/fQ7XjWOwoyIFBERPcqSeO+H3vVPsVg6cx1aqzfzPeFaLBwNAk9Wi0l7/q8rb1TfEyAnc9A6/7JDAV14TlWI+AXUQaS1jb8h2HYgHoWwSquYZSeiscYPYzeol7l6Axjq2XmruQnXwrVaJD+1I68MDKvJhGVdOciR1Z04WBuaQIeC4Xkoysp6AjWlHTHN9dm7PLLsqtGVesq5mB7LyEpDAJiEuwzkRA8WZsdNVXvgZXg0eFGNlEbr30EnqYauZt0ClcnIPmWhhNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAi139yiMjvULtYZOIRQlajNvcuxt61Vgtho4hkoESk=;
 b=UZGJ+OqYlFdIb5eM5WlDr0AmQM/cwSiMCNNxvc8Au7xMiRU7YeJbLPhvHOIxuM6NuspRu3y/kevytkvpP+dqt3pb/5N1ZAV/lu+mgkT4bjz0V5WqNEJuMsB+Wb8PCML4ricrzNIeeUvGjoRN5n3lZ3DJDrxn4mvjWAgKDCE/v0M3eUIKVc6ZAr8MCRaXXmwf0T9mwUiO5WjzOBAiGeu/r/QJB5cAUWNGPD2kFcUFOtVWY3RMcEW/75onFDdX+6VOk8DjelkLRTrVhHRWq4wS8iGkPQdLoUxcCdtWdG8dejgE/O0R8F4VQAZvcN5njw0N5goSVnP1l3VSLOl1VX3MlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:23:25 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:23:25 +0000
Message-ID: <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
Date: Mon, 11 Dec 2023 13:23:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
CC: <jiri@resnulli.us>, <andy@kernel.org>, <wojciech.drewek@intel.com>,
	<netdev@vger.kernel.org>, <idosch@nvidia.com>, <jesse.brandeburg@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <simon.horman@corigine.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<intel-wired-lan@lists.osuosl.org>
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL1PR11MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fab96f-d5c7-45a0-a565-08dbfa8f68cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSiYlrH0PTME5x1wXQDopumUGz//x9Tyg4MAIL5JVweZU2FW2W0dcrB5JlxylH9kSlGmZBySCtnmZhcQtC6tmm7ctAEfY1lAR3hF7GZnTlg9WZ+qyHkE6T90pKO7jtkuqKjmyyiZKVkIDfOf3BMNdMcEidmy+iX5bWUwqyw4PpdVdhuMomIbOXBdeSrcQohYnXnRAclaGrK43j89CFEVUR2rByw0fWPcZ2x/w5B6LFCJpILnemycAIERtJ/grOqUUlhH4530FCQQ6BtXs3qcamzci/Z3ApuS917WADrNQ5saCg5dgofz1Jw5ObZTFf+3koGs/LJZRfaPlMeNn/4fRMXQnRocSRDspgZDi3yEqhV8fjmYapBqdbvpJlMqCF+AGXh8yUGUiRjfsNsg8k+yqu/BO/Pb7EPR1BoLnYaOMP7vjXxrb15YlL8/1dRnD05LWCTmysFrhz4FGaPBN12u9AWPwnxROnzLRaoz3nbENduBKRESYaQNclojyVwDF6pZK3+upBVybpUpVYMPSeK2E2717aefGoK3pPOsiwiZC9P8ZjDuvqpzjTOPENemTr6j6UIUC5UlRWx9sccluUKDa7Q0x/B3Ck8k38HH+78s2dJSANjq0VfBqSTreHDgPEbdYdsOjI372rTYterKed7CLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(2616005)(82960400001)(36756003)(38100700002)(86362001)(31696002)(5660300002)(7416002)(53546011)(6506007)(6666004)(6512007)(316002)(66556008)(41300700001)(966005)(66946007)(8936002)(8676002)(6486002)(66476007)(2906002)(4326008)(478600001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhqdTBVU1hHblNyV1FLUTFEMDRYQ0w5RzV6RS9CbWd3M0R0Z09mdXI5T0o0?=
 =?utf-8?B?Wm5aaDdka25LMVQ4UnZib245anZOeGk4RTI2eUhlUTZFOTBwRE5uUStpVWEv?=
 =?utf-8?B?N3R2TkdKbERwcXpNU3dITmlPbU43Ynl3S2hYajNqb2E1S015eU53T2tvQ1ZO?=
 =?utf-8?B?c0Jld3JkNEthS0VVNCtuSVJldEp1eFF0K2VETXVqeWlNYzc0L0t5a1c3Z3J2?=
 =?utf-8?B?a3dTMURqLzg0Zkxzclh5RWo3RGJodSsvcnp2REVIVjdqMmlOd3RsOUhldzc1?=
 =?utf-8?B?Qmo4TnJRbkJqYUM1OGcvQVRCRVIzQlZ2NmFGeUlEbTkyY0pCNlBoWTZKYmRU?=
 =?utf-8?B?eDRpREtrQXFtRXJ4TktpRUVrVzRXQ294SnZocjJrejZOMFc0OW1mdCtVQ0o2?=
 =?utf-8?B?SkQyVXdocmF5UHJDbFdYcXNJWk5mV3EvRndWR1Q5dVdzVGViMEtaQjlNRldN?=
 =?utf-8?B?N1AvWGx1dkMydnUvVWk3d2xISVc2WHpvTk9xV21wZkJNc2pWYWxjSUhVVkFM?=
 =?utf-8?B?NjVQSk8xYkFlUHFxYXNZWlR3TjZ4a3V4cG1GZkRWYS9WVXFud0wzYXAvTVVl?=
 =?utf-8?B?OTk4RnA5WHZvMzRWdStxa0Y2RlEwQUxONFFhcThQSXBRd1dGc2FnS0xkVzNw?=
 =?utf-8?B?NWcwdUNhSmp0cmg0cUxJWUpuWWJjYmFMODkreDJzcm9vUjRuRTRwTHVNeitv?=
 =?utf-8?B?RXJmbmRzekd3THlyVjBobWgrUTJFQTczNXBVRlRNb3ZsZHJESU1DekdBQW1N?=
 =?utf-8?B?TjVBVXdlcTYwcmpCSndHU1dDV08rbXJLbHNoaG9BdFZ2SzlERVNQbHFidUJT?=
 =?utf-8?B?WnNqalM1L3k2VE9PSkg0VDlBenAwWjU3WWJqYmhsazdIcTJialdWSm1HaU4z?=
 =?utf-8?B?Z2tsZlJWbjhUVXo0OE1Oemd0RGVMSjJNditxQ2hqM1BNWU1nOWFhdUo4REpY?=
 =?utf-8?B?N2V3a3UrcGw4TWw4UllaT0lQQUl2eDNLV3RCc2FPYjZ1eHZtS3FoTW1NNmRL?=
 =?utf-8?B?eFNZRFdBMTY1OWRjQ0tQQVdPZFBsTit6akRvdDZTK0hhQWZoU1hUMVFIY1VU?=
 =?utf-8?B?bytKVHB0NHJkZ05iVVFiODFtWm5Ma3BsU04vN1NIdlp2Y0tsa0x1cStobmRU?=
 =?utf-8?B?TzBkQ21qa1RzTjdPVHZ5K2tudFJCNzd0YUpOZWVkVEUwdkpQUVlVSzkzQnpV?=
 =?utf-8?B?RHhIS2dNQnN2dnpRc21Qek0vQ0hiOFVtNFZYRzZWMHBmUm1VeUJmRUxpdkdu?=
 =?utf-8?B?c3Rwb3puNGhMOGxCcG5KUnlJRlR1T0tkNTZrNm82UmcwVDlSRGoyMWJMcG11?=
 =?utf-8?B?N1pubG1sWGJiYytEWTVORzh2L050T3lacis4RS85RnFrZWR0eVJoMUNNWFpP?=
 =?utf-8?B?bEkwRW9zQUV3ZllTbFJJeVZhb0w4Q3VJWC9jWld1SjJ1VnArV2VkSXRlUlBH?=
 =?utf-8?B?eWlDR2JGVTdZKyt2cWNEOVRrVU1wekR5NUx4cVhOS1BOaUZGR1A3cmEyRTU1?=
 =?utf-8?B?Q1FSODVoZkdZL09jK1NheFhnUDQ4ZTVXV3VXQ1k3MUhhdnFaeVB4cklmZDBN?=
 =?utf-8?B?YW11V0xadjI0YXovZ0laMXN2OEZMTTJIS0UrVUlHTFBlRVJ0SDdJSEdJUUhD?=
 =?utf-8?B?YzJZNmo2MTdZVGlpbG80d0ZtMUxnbUhQUzYvT3NleDhTdTdGUHdhbGorNHRk?=
 =?utf-8?B?dWtpNUliKyt0V1BadVN6VGVIbFpXb2huS2lnRG16RDhpQ1pxemF3bFJGOXhS?=
 =?utf-8?B?U1dRdmMvQm9Ha2JKeWZZWHloN2c4N3FCN2pINGQzOG5JdTBqVmF4SFF4UlJq?=
 =?utf-8?B?M3VIR0hEYysrb0xTQ1JsTWp5TG5nQkp3citaYmpPT0lNVnEwNU5yOWVpdDZp?=
 =?utf-8?B?K1lYQzBDaDlFaVhqVFlTWHU3SGpnT1Q3Y0RrQ0FWb3JLK054M1BFeDBGQmh2?=
 =?utf-8?B?Z28vQnF5RlNhYmp0akxKa0VZRjhIM2pqenBia1hacmVFNW56QkVOM1lrUGw5?=
 =?utf-8?B?d1pzQjNQY0REZXlCUHRSYU43b1JtYXgrZ0JpRFB2c3RzTmc3YjRkSmpQdFdU?=
 =?utf-8?B?L040c2dORzdQd2lPTUNGc3dSaFFOaDgvUXpCZmEzT1BiVmhtYlhJQUdDZU91?=
 =?utf-8?B?cUN0TG1ERkZXNEVvNlJuUVNIU2l3T0FOZWc0b3BWeG5xUDIxanpwdTdHLzll?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fab96f-d5c7-45a0-a565-08dbfa8f68cf
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:23:25.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrRdsiLrIHLud8w171XNAhIdbQpuAjggZpnLFdhuIcf76JBkTsCm862/Dhz6qoMnsK54pubuEwoKHKQ2IpgiJIKFCeCmoaI4uCaNZ3N/Sow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6003
X-OriginatorOrg: intel.com



On 12/11/2023 4:38 AM, Alexander Lobakin wrote:
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> Date: Fri, 8 Dec 2023 13:34:10 -0800
> 
>>
>>
>> On 12/7/2023 8:49 AM, Marcin Szycik wrote:
>>> Add support for creating PFCP filters in switchdev mode. Add pfcp module
>>> that allows to create a PFCP-type netdev. The netdev then can be
>>> passed to
>>> tc when creating a filter to indicate that PFCP filter should be created.
>>>
>>> To add a PFCP filter, a special netdev must be created and passed to tc
>>> command:
>>>
>>>     ip link add pfcp0 type pfcp
>>>     tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
>>>       1:12ab/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
>>>       dev pfcp0
>>>
>>> Changes in iproute2 [1] are required to use pfcp_opts in tc.
>>>
>>> ICE COMMS package is required as it contains PFCP profiles.
>>>
>>> Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
>>> stored in a __be16. All possible values have already been used, making it
>>> impossible to add new ones.
>>>
>>> [1]
>>> https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
>>> ---
>>> This patchset should be applied on top of the "boys" tree [2], as it
>>> depends on recent bitmap changes.
>>
>> Is this for comment only (RFC)? This doesn't seem to apply to iwl-next
>> and if this based on, and has dependencies from, another tree, I can't
>> apply them here.
> 
> It's not an RFC.
> The series contains generic code changes and must go directly through
> net-next. 

Should this be marked for 'net-next' rather than 'iwl-next' then?

Thanks,
Tony

> The dependency on the bitmap tree was discussed with Jakub and
> Yury and we agreed that the netdev guys will pull it before applying
> this one.
> 
> Thanks,
> Olek

