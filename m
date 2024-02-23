Return-Path: <netdev+bounces-74563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D53861DBE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98438B228E9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F514A4EB;
	Fri, 23 Feb 2024 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZSoL+m4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93759149387
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720821; cv=fail; b=ongDmLid8tf3ZOgIb+hNy4njuvgaoS7aWYTFzQMyPN9ei4YaA25ruzXF2+CDZcV3xbDDXbiM0tl64HdnG7NePZZbhuMjpotR+8Y5IG6MWe7NiBgcfLnTkhn9gRCIK2plz69ADwQINnQfc1VCyFAbZp9RWrU012zAjY+eNcuCL44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720821; c=relaxed/simple;
	bh=FepLmpg7MWtgzWlFtEBgyTmtrDsxuSbtSLOvh3Z76Q0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6qFYSPUNL1L1FRXbkZPyieSuyL/68USEvwMae6MmZ+3OySwWZu1czvQ3dA9P5HtUXQ5w0X8cwdRYbmUx4P3B5JbKOee+QfpvNeJsrA7iipHYYRW+JbeKMw5lgdKqSaULCTBtuhi7uU3XCvS379qlDDFHdvyeIqGpYnvHExCaiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZSoL+m4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708720816; x=1740256816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FepLmpg7MWtgzWlFtEBgyTmtrDsxuSbtSLOvh3Z76Q0=;
  b=SZSoL+m4drtB2x5YYvr3mNo0uu7dRnA9tW9h2nF9petXZ2ujJUCO4EYe
   J77IJUXm2OO3kRlnBSRuArZpifPxee5umtM/JbULpuShtGlE81ZbYmciO
   /EjytBxMrabIL9roWntsLSYTq8CNzEXPKjZ93V/xv+H4B9lw/Sb7wfg2H
   ohMiWU00/8mk6jKSychouZge4drRREG1KJh+hl0vCWZbNx/CzOSjumRCi
   ltweM3g0CXuW3MppDI5coRVBir8Zo69D8iHTnkk+1nwjJ2kNVgAVSiU5e
   0gBb+BER8IKfhwARXbjIvfhg+gnf2Z1GFYYzpU8guyD+2unI312Stt3rC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2922583"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2922583"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="37032914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 12:40:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:40:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:40:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 12:40:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:40:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPn+ErScB9H1ctbVzUy4z94ixfEbBzWtw0agMIAEDcf28jdTNWgZjQlU9O0YhWryIRy4OnqKEFDOj4tPcQZVD87SvTz1uzQzqHf7lMMEbJjaal1wWxx+yT2kBFfGs/d2qhwBwyKfuo2NBe4lMNsqb9At1cePQn4Uh0N+ok50ecNf5n67gCYrBtFr7usOjl3ywGT7E4RdPYhm157EdJEp4s/VmjpkZ9up8GcV5ULkau+MkwOcMkWQwq3c0U9I4N4PMlmo4zCXdFRf0WdzNyctZW8RP0ueIUVp2UM2lZ1Mlj1BnrwYuWIoR81Sj21QrqczK2TRW1eH1JyA0gADCQbhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wckisCAn3e2kAGmEdMmlWT3l7vDMWmt4SLXP0YUz3Rg=;
 b=hvFFrhxnB5eDM8ySo44BgaCvU+faWe4f4tvEZYcEVo6M6KUeyoQnvXX/3wpRNbiD9nuqS2ai5mjMtw3O+hNSsOyPxeR7bB6vFFFptdX5GiUPu5jQR4CL5H751SGXuuLXu4DFfqdbbLTZr87JNlt0jDKRO9FxMlJ7UblcAEKxcAAKKtvwf61Pm4DC9RcUvpAsV4yMdGgkwSsKOl7yYD7QDNp6HKyhovYRcT9oncS7OpUMQoWeqNXq6Yn9Xp17CFXu8sdSPXnXHW8F1rc7L0LBb/EqGcIQb+7XlXuQtOpezOsy6b4VM5aBTaY1jliClkZEAVMehVlhgWxm/P6sruYEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 20:40:10 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 20:40:10 +0000
Message-ID: <67d36c7b-bd0e-490d-a058-e4d8c8596f9e@intel.com>
Date: Fri, 23 Feb 2024 12:40:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
 <835c44da-598b-4c33-8a4d-14e946a8f451@intel.com>
 <20240222173703.08c442e9@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222173703.08c442e9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ded555-149b-4c81-7e43-08dc34afa109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D50X1ZA8hG+cGpODdZwIe9+MmSZxl+0acB622hJAnMPobWBB3BMlFGHbFBTjQeX7hGPidO9LyaHbVLpBzkLJo80uGHsEWytxRhKqiGN7L0F6/cALdopIvL7YZtXzj6zCfFy57IxuTHwu0Lljp0aLCmEudzLKnGtfLd6Tjxx/G3vGEJ+2+xh2LOi5+iGLgLCQ77GTl2IZGoay7ybLZ7YBp6rhUvQHbqqOoRRfyRpMdBQArFJGWECcagf5Fad6NX1UprpMNfuST1d7KyvQcxWT7rbpF7gaCXLM6hHKG0vPDVhX8LnIO+eOOS3cJxBB0MJL2RI3ZBQOJC71hhEiMNVvPeJsJWiXthoLYhNVs8IwkVTzn49H6iGeYd2/SJbTaJm3KFBa5ooYflYTd2MoWdcM1q2Ak0686VNR5YIVman0p57Wfd9nRx+dLKlu6aHVv8poRXkDNC2g4oiRMquOTGFoXxg2D37GwCzcYuxQpHiJsnIv2cEkN+C4TM1dnhZgK7QJjIKMR2Ha7zJqZAW8c68ILSB9RzzQ82NEnFtw4t4dBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy82QlhoOTFLT24xdVZxck5ZaU5Ua0s0Q2gzK2lBV1B0OEt5ZTZhaXQ0Q1U5?=
 =?utf-8?B?Qm1yWVpDMElyRjJFR2MvZkx3b1pDeHVXbmI4QzJYOHgwaDVXYW44Z0k5U0pq?=
 =?utf-8?B?UjBHMStyanBsOTNLYXBwWWlZdFNoVjZLQWVCYXBOSWwvb0pJMVVxcERxa0hJ?=
 =?utf-8?B?STh2K3Z1M2NsUGJza3hCYytnVXMwcWxCdUN2MWJnT3dFcFFjYzZjTEpVd3VL?=
 =?utf-8?B?a0lZazEzR3ZQZ2ZJSHhsR2VmbjgxckdZNUFpVGZCZFhsYzhOQ3dNbSsrTU1C?=
 =?utf-8?B?N3dPcC9MZEU2WnBKRjdFMTNnNjMzTEdSckNrRVBHWmRLd3ovZXhZOXZ6eitm?=
 =?utf-8?B?ZDhFcjBYUzFsWUloeVFrbk9MeHNSYWkvUVAzOU9LNDJnYm1UdnpFNjUvQmMw?=
 =?utf-8?B?UTFEUkJMcEEwVDByd0taaGZMRnM1cCsyeXpxNGxkSDZQaGY1bUxZVklNTG5I?=
 =?utf-8?B?SE40MGlHRHZiS3ZFZTU1Z2RxKzBRNHFLRmx5ZUx4UUdPTTFWMU0vNmxISEpl?=
 =?utf-8?B?WEtFMFA5RGtEK0FTTi9JZ1I3bEh6Zm0yU1hYT20vbjRCb1U2OElVVHNCYzhz?=
 =?utf-8?B?aXQ2ZXZ3MEZCN1ZXbG5pcGJSV29qMmk3eUJOMXYvNit3aDltaTdXNmc3Qnp2?=
 =?utf-8?B?WFhWY1JSVzRNYnA3dVhGOUVwYUZTNm94VnQzc1YvRVhaRlczcktSL1lBMXZX?=
 =?utf-8?B?cmNudVRMZjEwR2t2cTBIRlVHZThiYTZlY3ZyUTV3TmxTTnM0Tm1IUmw1SUZX?=
 =?utf-8?B?UWtDZUhWV1lLZFVUWWRMVUhGWWlpcEdNQW9LTVhnQjE0dmY3TlFGOXNsNThz?=
 =?utf-8?B?WWZmamZveEducHdiUS9iMW1BQjFOdFFWU2hvT1ducEw5c0t4MGlVQ0pCdVBH?=
 =?utf-8?B?MURncEhHTkxKNTJMdDZkMjBCM3EreWhIcDBJK1BkbGN3WFl6bTQvaDZlck9B?=
 =?utf-8?B?WCt0bjBHeEZJQUdMT0FEbUtldFl5emh2emdaL1hSTy9IcHowRXJIck14ODZC?=
 =?utf-8?B?Y1pxZktwakt3ZjBDcnBwRXlGaktaaWU2QmYydUFXcWd2eDZEZHEzUUxWdFN6?=
 =?utf-8?B?ZXFMTys3ZkRSZ0ZmRDFtSDI5VTZnaExoK2laM1RLMXJWdGtCckFPZ0lkY0tH?=
 =?utf-8?B?cEExdDVXV1VKblZjSncyU0hRMzlud0w5WXNlMlhLdzFNTU1EenZUYXdJR3l6?=
 =?utf-8?B?Rk1EZmlHMWJ2U1BKM1B1aHQvYWxPazQ3SjdxYTRqSmhORDFxQkpsQW5JZ09U?=
 =?utf-8?B?UkF6M2ttOVQzUUJuek1seXA3WkF1Z3lhektKblNMYlQrdGw3WVVsNUZpR0pY?=
 =?utf-8?B?ZUplMXpwRVpma1NsWkxpSXFKUVNySE90T2FURkl5YXo5d1d5NU9IMHBnNEtw?=
 =?utf-8?B?R05WSjVGVGtIa2JLbDJXaTJGWDJCZ214Q01QTTVualIreXh2bHFiS0FEYlB1?=
 =?utf-8?B?YXl6eTQxRG1FZG8wR3BHaHNpaHE0RHhUMXI4c09qc05jRGFONDJlUDdYeTRx?=
 =?utf-8?B?UEUyT1RtMVU4VWpmRmpBMG5LY21oQldhZ0dWV1B1bmY1MmZ2ZEl3bUJZY3Jj?=
 =?utf-8?B?czNxdGZ2VVpxRmZhMmVyalVZOW4yMytTc3JheUZFLzYvTXJiQzZqU3lEbm9X?=
 =?utf-8?B?UUU4Sk9CL25tZFVabnl6Wk1QMEcxUk5uNGp3bHhUdGN3UlFPL3pRSjNuWGg4?=
 =?utf-8?B?UlRtNFlwL3lDWHEreTJZMTFLaVVVNXRWUi8ydTEra0VTYWw1SG1HZzJ0bEth?=
 =?utf-8?B?MWJ3dnVZWFNuQkVhV0padko2MUVuYTJxaVhzT0VYREF3ZjJKUDZGb3VMQWFs?=
 =?utf-8?B?elZmWkoxUDA1UDRiL3dQZkkzQWJ0RFJmTUNIK0I5dnI5UnlZREwyQTAzQlVR?=
 =?utf-8?B?bHl2emVTblJNUnJENGtZR0VKKzNPMDVJRlk1RW1GRlhmWjdLdjMwYjlrcVZa?=
 =?utf-8?B?Wk4vQTE4TnpSZEJrT2h4VHYxR3dpdmlNZnBmVGhidDhFMU1zVzdoTmlIQWt5?=
 =?utf-8?B?MFdHdVRLb09KdXR6b1FnNW91RVN0OHZRVHo5ZWhRSmVSTm5OVW5rNGV4eXlV?=
 =?utf-8?B?Z3ZmY3hiaEJreG9idjZubytjUVcvcFh4K1g4cUNoYVpSSnFBTFlyUzVmY1NC?=
 =?utf-8?B?UkVyczV4ZFMvbU9OcFJER1czcHVSSzYwVU5oNE84bWdIYm5FRjhTdSt1RFFz?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ded555-149b-4c81-7e43-08dc34afa109
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:40:10.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4j0ur5jz8X88Pnburnjr9pqajKJkGREqsPlwhTK543a4pbRMSlTRsv/TKc5OhyBeGR9GBUbUbf0AwHg5tEeUmiW8sI3e5GXvlCEPzcNUMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
X-OriginatorOrg: intel.com

On 2/22/2024 5:37 PM, Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 16:23:57 -0800 Nambiar, Amritha wrote:
>>> +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
>>> +			       struct netlink_callback *cb)
>>> +{
>>> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>>> +	const struct genl_info *info = genl_info_dump(cb);
>>> +	enum netdev_stats_projection projection;
>>> +	struct net *net = sock_net(skb->sk);
>>> +	struct net_device *netdev;
>>> +	int err = 0;
>>> +
>>> +	projection = NETDEV_STATS_PROJECTION_NETDEV;
>>> +	if (info->attrs[NETDEV_A_STATS_PROJECTION])
>>> +		projection =
>>> +			nla_get_uint(info->attrs[NETDEV_A_STATS_PROJECTION]);
>>> +
>>> +	rtnl_lock();
>>
>> Could we also add filtered-dump for a user provided ifindex ?
> 
> Definitely, wasn't sure if that's a pre-requisite for merging,
> or we can leave it on the "netdev ToDo sheet" as a learning task
> for someone. Opinions welcome..

Totally! Ignore the nit-pick.

