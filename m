Return-Path: <netdev+bounces-41564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBEB7CB50B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9ADB20EB2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36837CA7;
	Mon, 16 Oct 2023 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tcf2+eYg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF327732;
	Mon, 16 Oct 2023 21:09:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B9A2;
	Mon, 16 Oct 2023 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697490551; x=1729026551;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DpqzRQs5vhroyYvlyUkKRpDO4FCDnt3SUAiaSIxfB0Y=;
  b=Tcf2+eYgedp7KqQF+S1BpXiS5WMRDBYPW+coSnaJbSGDdtKz7epbxzmL
   nOrPVdHbNzI/AYSjOLiapPhFlUuRcP6DFCHUhoF+pmGUf90CgUE3ieBKL
   pj/eb73FB5dCW6l4sdeVdf5FUScB0GMWl96f8Gs4928WVb5ywQWRFmsWh
   iE1vJhEhjjabpOdLrJMp+N4jzMR4Vt157h/a8C5kNM6JGhbNLwJHGjRrh
   ecqxrwyszD+BiPaPvyAUfzDl/RXdsyn/+OjYJFqVfumvdjp6s7LHiYpnK
   S/AbJ0akt3gwYabXWgo1wkLzFUvtWQXE5YfzKl8e6ty2WTfLUNi5EAI0U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="449858229"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="449858229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 14:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790953507"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="790953507"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 14:09:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 14:09:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 14:09:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 14:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVFfYW999+2CcfZJgHk4qfT0M+aKKhG71zwmPpRRJNHENjkyVlzLpLtsK7alTfHQRaqGI/bv1nSbYQp50ZnmIFll074yTGXPUDHCdFhM62Hs/QVRDWZb1Luey5CC824zbChuu4+wGOK+PN2qn1qR9IDGg679n5h+QGMBmX8YJL36zm9WE1Ea50EKzajN+VrQ/8HLFVEAV3c5ImlX8GKbO5J8y8inPkIbkycdRw+hxiwEsPsmRuJNuciOp+cYmmIZz4/1+47ocYR92yyJvOBvQVEzy5qWUbBnBx48opgWWNDAaMnNgAooyQOaZRzYLw0bps/4/LYqpDjX4ODp1eyfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7yD1udvURDvEJDfR6IMSvNHfRpcBhYko0WkVfuQ8+s=;
 b=k+GH9gqB6+yAf+U1RCqWh7BJSbaJQHdzSsGlY0f47xulytsZNm6vhh3lyJu55U6ZBtyARWpnp1uuXEZ5t5sOBts353/u3G9Vn72z73Q0VhmJ6/3xQ7Z2+wg85l7VZ8rCkZqEIvNwRxeRGA5SglA8n1qZ4+s262V601qoXNWqnWBVtzP33/2BgCJt17Dd/gpu4GVQxfIXXZVNjJJ0IMtsCmmH2FcElj/B2t6I0AtPxRpc/pXJE5HVri+HBazKBoNdgfYVKkSsH7v+E9mFPMOYeDomIynIb9fyQiXv4N1IY2uja+C0n8eZv3+00G/+LMmSv1BWc9KgDqFzx+K8as2+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 21:09:05 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:09:05 +0000
Message-ID: <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
Date: Mon, 16 Oct 2023 15:08:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Alexander H Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <corbet@lwn.net>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
	<linux-doc@vger.kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::17) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5da3f8-b33d-4b44-0e78-08dbce8c20fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGun5meRa6o72qRmCXkX0+p9zhn+rI9KZ+wqb8g35yqbbw/FpQOn0PKpo6laxzPSrA9Q3S7tW5l9N8f3poh3lIk2Pr/86zm+qTL+08SZEod9ox56c56MkXSoC1wOEqR+rez+u+SeI7SvYJt/BdNmJ0HbBHRbR0TalRCuZfQizfohTlsWfAHugyQyXUgD7JoZDIaoS5qYdHjAUawg3kW2G4n0xqjSHsFlxYB3ZpmVfoYo5l4nSr9T80/RqK7mVhpHKxroL98L9tEvTah2laAhm6RLEtjDeolxXStH4xT8k1hinJyV/ycsudv9k9mL9v00qT66xC9nCOyUWJCX4pQE8RDs78zE7HQLXK00w9GT+LXkGl6uzv5lpm1tiVdaUHtdfBXmcmhOLyTlyUrXu9q8YMrBsSCDAvXJMcSFZBA63G9LfBFNau9taZMCBL2P8f1TZtm2Kbm6Ed4JzjJ4uCu8pCogH4B8tQI9JP4lDVlWBrcIBf4wLuXzB8b4ROZ1JQ22LnIsY+lGbe1mUOnkxoyIrjjuVwTLb18pdQZ4dJkNPZpWc+LUiPJejV4UeDvIMOom5dNPR3fqMWDmYDQHCvprkwfDFNm0/xJGNaVpvrVO//Oypi7P5VXqd3qNetW+xPm8zCuz/l4QF85y7bEWWQL0Y21y9L3e5r3LTMGUq0zyRXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(6506007)(5660300002)(44832011)(2906002)(26005)(36756003)(2616005)(4001150100001)(107886003)(6666004)(83380400001)(82960400001)(38100700002)(86362001)(31696002)(6512007)(7416002)(6486002)(41300700001)(316002)(66476007)(66946007)(66556008)(31686004)(8676002)(4326008)(8936002)(478600001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG50NVN5MVFOSXAwTXppMXd2cTJuZTBGSnplZ0JkSE9TbUNPaEV0eVFKRU44?=
 =?utf-8?B?eUVRN3Y1M0NiTE44d0srR3pEWm9PVHZDYkF2OE1MbEJEUGhIL0tRTTBTVTQv?=
 =?utf-8?B?dGMvYzZFb1FCN0RudTV5dHpCM0NSWWVFQzJDV05PVjZ0WVNaU2FvN2JTWEdZ?=
 =?utf-8?B?cCs3bTI3c1JraUJ0U2RBSU4rSTRxV0VmM2hoK0d0OXlDYTJlS20zd3RaNjFs?=
 =?utf-8?B?STVqbGEzYmtJRUJXeWdYenhncVp2UE5ja0c4SUNzQ1VUdkE5Vk0vMUdOdVRq?=
 =?utf-8?B?aDBnNWJoSHRheUVXdElyK25tSUdsVEtVTjdWNVJ6RUc2bDBDQ3U1SVIvSWZD?=
 =?utf-8?B?QnByVkpuVEdQM2htcURNOW55eFZkUUM3MWErTkNDU2NZcDlEOEpoWjJlMVF6?=
 =?utf-8?B?K0FCZ0pJUHd3ZityMmlHeTlESHFrOGowTU9VTzJRMEZmQ0xrWHZIT244N1dV?=
 =?utf-8?B?VkJHQ2ZpdFBoZGJpMTcvYitZcXZrc3J2cWZNUFJoTnJhZmc4QWhteUwvc08y?=
 =?utf-8?B?OFIwM2VjN2RhWWxrWWVuVVR4MVNPcDJ3R3lzcG9DVVN3TytOYklRUytjZk4w?=
 =?utf-8?B?UTgyWkl0REwrOExzd0JzQ3ZlM3lRMFRzMytvWTJ0M3p1KzFvQnRZeFljZmdx?=
 =?utf-8?B?MzRqNnNsMkk3c29kR0dETThsZ3BpMGpKRFA0OTVwRzFYOUhxSWtoV205QXBi?=
 =?utf-8?B?OTk0Yi9rT1VkcFZwU0MzamdsUzlNc2ZQcERtY3hGeXNFU2psNDJacWFCa0Rx?=
 =?utf-8?B?MThTNGs2bit4MXI4VmdZcm43TXlaZVFpNUZ6RlM0WVFNVnNXNFBzZFpmN294?=
 =?utf-8?B?STZIeDVJK3o4RVVrT2R5K0hSdkV2VFp4bDNvRGRpL1JQK051dXVoenAvUFMr?=
 =?utf-8?B?SFJSNklJVGJQQWRBSkI0NjdRQWYwaVhuZ0o1MzR1OHpZZ1JGY04vMU8vNDZp?=
 =?utf-8?B?MGluTzRYSHJQQURPTXE2NXJqa3YrWit0N292NWxNOWFhSlFzUTc2cFFoaTFh?=
 =?utf-8?B?Vm9iaHNwb0l4RHcwUWJmdUdpTUpGaS85QmxYcGI4S0VJQ0gwcXh5ZmVXYlFL?=
 =?utf-8?B?dkNUNndBRURRS0o3QVZTeFRPZGFWQWZvY05lMDRFSVg3QkIxK09sQU0zZWRB?=
 =?utf-8?B?Q0VsR1piR1k2Nks3SjJPTlJGUC94NmNvTCt4VElOMXNPM3JNUGxRQzdIbmRy?=
 =?utf-8?B?T0F2bTFQOHlyVDZCWVNpTFZLYTVMdEh2WFUyNzZ0SGNrdmhEYVYzbmo4aVRD?=
 =?utf-8?B?YjNDdzJjY3M3MmNYNkU0RHo2dlEySElaeHNUenY2Q01lMkVZVVNyUzBkV2dD?=
 =?utf-8?B?eFV6czRNT1hEWXk3THc4alMveGorQ29IUjlqSG1idmVhYnNQejZWSGtENTN3?=
 =?utf-8?B?U0RlRmQzV0p6bCtWUTJaN0NrVUR0TDNEZ2xzNzR3TTM4eTgyTldNK2FYbDM4?=
 =?utf-8?B?RDdxQ2lmOFpYc2ZFRkFLSmpqVC80cU1UaUMrTVdOVWJoZld0UnlRb21IV1VV?=
 =?utf-8?B?cStQZEJCdkF1SHROUlNhNStEMGU2NkhESFNrdzQzUkw3T0NMZ0tGcGJXNHFN?=
 =?utf-8?B?NUdRN2RLaTZuM1pZcUhpWm0zRmFLZVByWjdWaktpQXhURDMxL3lrbWV6UXBV?=
 =?utf-8?B?UGxXQXJwQm5vbjB6UHpLdWtRVGp2NTdoSSt2aWNnTDhBU2psUW14U1RRUkxC?=
 =?utf-8?B?YTZ0eUhMN0ZGbmVsa0twYVJIc1VGUXF4MGl0bTNveDlITUJFWEMyZkI4blZJ?=
 =?utf-8?B?T1NoN2U4N25ZMHNBdXBMbzQxZDdrM3Nna0VUbXBMdXhPdmJ3SFNHeTZvR3VU?=
 =?utf-8?B?MWNlZlhqN1N5aHRIMGVqZ2ZXR0hIY05udjZOb1dMeUVCdlBqVmNMbzl1V3Rp?=
 =?utf-8?B?SkpuVFdGRDJ5NSszSS9YZnBVSU9jbFBDUExlUGw3WHg5SUg5QmVYWmtSRXk2?=
 =?utf-8?B?c3BCdTRFREgxOXdzMnBXYWpGU3BFMGtISGVuaHBERXBFZ2V4UVRoZmh0Tlpm?=
 =?utf-8?B?RzZ4QUZORmErQ0JZb1l1NjJTckZ4YzR0dERpQm8reUoxQ2VlVFZpM1BvRVlK?=
 =?utf-8?B?UUhieU81NlFKN2UvWUdUdE9iWmNYSXB2R3J1ZGFxNEMxMVhoY0FCVUM5QU5K?=
 =?utf-8?Q?0cBV3XJ8LKyAevX3IpKE3nZof?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5da3f8-b33d-4b44-0e78-08dbce8c20fc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:09:04.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0B7X1yuvduBXOsDEiERjfyfiNgE7tiKpHO/rQhxFhdNsuwFeLlixGzEQnYuqC96ON+zXqfmRwLKO9l7C0FRGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-10-16 14:17, Alexander H Duyck wrote:
> On Mon, 2023-10-16 at 09:49 -0600, Ahmed Zaki wrote:
>> Symmetric RSS hash functions are beneficial in applications that monitor
>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>> Getting all traffic of the same flow on the same RX queue results in
>> higher CPU cache efficiency.
>>
>> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
>> by XORing the source and destination fields and pass the values to the
>> RSS hash algorithm.
>>
>> Only fields that has counterparts in the other direction can be
>> accepted; IP src/dst and L4 src/dst ports.
>>
>> The user may request RSS hash symmetry for a specific flow type, via:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>>
>> or turn symmetry off (asymmetric) by:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>>   Documentation/networking/scaling.rst |  6 ++++++
>>   include/uapi/linux/ethtool.h         | 21 +++++++++++++--------
>>   net/ethtool/ioctl.c                  | 11 +++++++++++
>>   3 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
>> index 92c9fb46d6a2..64f3d7566407 100644
>> --- a/Documentation/networking/scaling.rst
>> +++ b/Documentation/networking/scaling.rst
>> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the computed hash for the
>>   packet (usually a Toeplitz hash), taking this number as a key into the
>>   indirection table and reading the corresponding value.
>>   
>> +Some NICs support symmetric RSS hashing where, if the IP (source address,
>> +destination address) and TCP/UDP (source port, destination port) tuples
>> +are swapped, the computed hash is the same. This is beneficial in some
>> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
>> +both directions of the flow to land on the same Rx queue (and CPU).
>> +
>>   Some advanced NICs allow steering packets to queues based on
>>   programmable filters. For example, webserver bound TCP port 80 packets
>>   can be directed to their own receive queue. Such “n-tuple” filters can
>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>> index f7fba0dc87e5..4e8d38fb55ce 100644
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -2018,14 +2018,19 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>>   #define	FLOW_RSS	0x20000000
>>   
>>   /* L3-L4 network traffic flow hash options */
>> -#define	RXH_L2DA	(1 << 1)
>> -#define	RXH_VLAN	(1 << 2)
>> -#define	RXH_L3_PROTO	(1 << 3)
>> -#define	RXH_IP_SRC	(1 << 4)
>> -#define	RXH_IP_DST	(1 << 5)
>> -#define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
>> -#define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> -#define	RXH_DISCARD	(1 << 31)
>> +#define	RXH_L2DA		(1 << 1)
>> +#define	RXH_VLAN		(1 << 2)
>> +#define	RXH_L3_PROTO		(1 << 3)
>> +#define	RXH_IP_SRC		(1 << 4)
>> +#define	RXH_IP_DST		(1 << 5)
>> +#define	RXH_L4_B_0_1		(1 << 6) /* src port in case of TCP/UDP/SCTP */
>> +#define	RXH_L4_B_2_3		(1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> +/* XOR the corresponding source and destination fields of each specified
>> + * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
>> + * calculation.
>> + */
>> +#define	RXH_SYMMETRIC_XOR	(1 << 30)
>> +#define	RXH_DISCARD		(1 << 31)
> 
> I guess this has already been discussed but I am not a fan of long
> names for defines. I would prefer to see this just be something like
> RXH_SYMMETRIC or something like that. The XOR is just an implementation
> detail. I have seen the same thing accomplished by just reordering the
> fields by min/max approaches.

Correct. We discussed this and the consensus was that the user needs to 
have complete control on which implementation/algorithm is used to 
provide this symmetry, because each will yield different hash and may be 
different performance.


> 
>>   
>>   #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
>>   #define RX_CLS_FLOW_WAKE	0xfffffffffffffffeULL
>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> index 0b0ce4f81c01..b1bd0d4b48e8 100644
>> --- a/net/ethtool/ioctl.c
>> +++ b/net/ethtool/ioctl.c
>> @@ -980,6 +980,17 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>>   	if (rc)
>>   		return rc;
>>   
>> +	/* If a symmetric hash is requested, then:
>> +	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
>> +	 * 2 - If src is set, dst must also be set
>> +	 */
>> +	if ((info.data & RXH_SYMMETRIC_XOR) &&
>> +	    ((info.data & ~(RXH_SYMMETRIC_XOR | RXH_IP_SRC | RXH_IP_DST |
>> +	      RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
>> +	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
>> +	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
>> +		return -EINVAL;
>> +
>>   	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
>>   	if (rc)
>>   		return rc;
> 
> You are pushing implementation from your device into the interface
> design here. You should probably push these requirements down into the
> driver rather than making it a part of the generic implementation.

This is the most basic check and should be applied in any symmetric RSS 
implementation. Nothing specific to the XOR method. It can also be 
extended to include other "RXH_SYMMETRIC_XXX" in the future.



