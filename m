Return-Path: <netdev+bounces-74212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3E8607A1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B71F249D2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77E7F;
	Fri, 23 Feb 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbeW29PG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE619B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647901; cv=fail; b=hBVa4NQZTm5nPM5tUfQtf8Y3+8QOWngjOGTEz7e1eLXjDgB4C+7lznogokBdVLt/IHYyp/S69sGpge4zdvbsLiPG+z2nStPUk1zq1sz06bFQ8NLAjwY1FxFVlmRMCBCzbMcpdfOm03EqgMdEGQruOGUV12V5zayWF965HahGamM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647901; c=relaxed/simple;
	bh=RU5QTZsko6NTmEUSE4PCcTIq2MThe4uvJUEvu2c1fDM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LpCarMx8qs6YNmGxt7E0Eyk15CfGGa4IaC+5Y5le5vlpkouMfmf59HViWyCPHYPXusMtCJdqvH96F7mLSsg3OIxIOZV3KOeBQDJg1Z3SQCk61PvZQRNAhELxtnrgLVBR8zul4VIssP6F/XseqZZo8b+1Yi4bB8mTMpKnRr+sbZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbeW29PG; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708647899; x=1740183899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RU5QTZsko6NTmEUSE4PCcTIq2MThe4uvJUEvu2c1fDM=;
  b=KbeW29PG3j7ELXaaBwmH8cMCxshvGYyVQflWRI6dQ3C/b5eXjvufI4Mq
   q5452bWahdKOnN1ADklzWwLsMOQlr74JV2cGPQCDVY1kDM0F1U36mm1Sk
   MYTUcE4qx9xQbScAkPT2VEpxHbnL8MFtuXPtG9QovVHHA8eZmWQkLKdnx
   LRAAB0hBGOq17w50HJ5CgBEGwWCFQxxJLtucKVtjN0M6Jk528NP6fWlY8
   B8rtOimINJHuw6h+Z3ILs6kPW6kTepc0SA+OZ1U/kbES3dnc1C1NjhyqL
   4uVMy/SBBp90KQfW2b+Sz5kYhP01Nv9nGAS52mGFyF94lbazDy+cYkurB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2791775"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2791775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="43143023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 16:24:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 16:24:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 16:24:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 16:24:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMhDjI5PNIAvy/+RnODc2HY3ZIXZBvKRUcivGmmDa92GxaWINOWBvXFQ1Ji01+PQHAuM05nxJBkDL8QgM4L2W3JN7DOkt5jufmFPjQRRxTjrZ2Jsyp/UitXAd756+97SvmpDNZZ4vLlCGz3sxL83OwuJBXqjO4wRRlYzvdkSnsidw03Iph4v/eHPTqZY7tS8ftXKtynOd+/0vIjVwaCsK2Zx5gS/1oeir5Ovv7IbZ4d/YWjrifisIvESv+kc39bYMK4MvAMKeiZAL1URzRlL57PtTKCjF+kFajVg+WskLnhnRmI/8i7GEv8YGNfvKdHWo9QG0u5DDbfRTg9vhccBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFXyXYH/SYuuep/rjj09FsIZXdd2cZTHDmMMPkBXdF0=;
 b=lgZUKyOL3535sV7um4HEphrQswAgOv9oxibfL1j6FOPK44Gy0v9hwJ8BmZNqpP53DljcA/kToZGJWbkIVYfJpRzEH595K8kkARO5sTHjFWN4/LKhIyCVdzioavtHpyV0kyFoiryNK5tiYD3U1sexuZQWaWFXBrBSF1pJ74tYuGMsl24ZZLlYEduHNST6+AJ6o87VNaO53wGtt2SGPqRXKXb4ZWniqXYl6xan92w9Cpei+Mjoy0ZStROT3P3cqFNnsvFlPblqMUq70u56cOFnQwWQ0hG+F2KGf/CC4/bSTWbb5By+F4ho0qFDD2GrphiUBf9KSxJASq8ZsTuRJ339uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA0PR11MB7260.namprd11.prod.outlook.com (2603:10b6:208:43b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 00:24:01 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 00:24:01 +0000
Message-ID: <835c44da-598b-4c33-8a4d-14e946a8f451@intel.com>
Date: Thu, 22 Feb 2024 16:23:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<danielj@nvidia.com>, <mst@redhat.com>, <michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222223629.158254-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA0PR11MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c05cce-1e7e-4ae2-b6bb-08dc3405bc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eL61g6NMGXJgBm/oQmkiwj2EJ/ZlkDVjsAgMXvDE6wh7UFVukzU28t5zuXtUdB/4JVRFy2+/8Z4Y/FfrGwrauIv90E1/wnTkFD4N6pNzRtcVeE0mwDOE1dWxx47IjltMDyd7MRtDBdbJqqt2KAdCV/ejueiMtXQMFOAMMECpBnU+owzEfVcn/iOlMRC9ihcYo12vJefemMjA87gZuUmcwowFKv+dMsmALkGt2tCKTXOcrcKj6VYzKOlCAMV+dX+YSaSWEUcHNXOFZHXt0FET57t1xdw2PBulChgGzvgPXQ34yuCaXwh4zLeN60U0eTIa5Tl99Ftbc5Ax4wiFxkVtCsWSw1U/pIHf+p1HdHNbR15g3oNkrLIrqKBsnc1XTxvZcK8SRJUCnNExzngtAP24LXjNcSHe+LX37f1P32HnB6MXhiQxXl+aC8OvVmwWIaoDi4R8kluq9iUu2UGfbfeS+2sqVlz3s2JdmVqN8F00v7XlqlrX0AOIYCngCZdxz3A7wuIZoTgebfdoPRDDpqJY7QzqtD/xKmvB1L1WSmaN54A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFF3Ty81V3dsMFZIWWljTXF0TjlGU3lHVi93T0w0WGJIYXQrc0x4MGdSVDdj?=
 =?utf-8?B?Vlk2SUVXN0dNUiszTUV1Qk92YzJKRTlSbWZ1WmJMU0JuWFVDYjI3WU5xNFcv?=
 =?utf-8?B?WjlqYzBIT3EzTTd1VWNxSDdORHB6dEtJQVJtQUk4WUhEUWRiWS85dXk1UnlU?=
 =?utf-8?B?dEh1by82ek5lV0t3QlgramZ1YU5MMVlpajBYL3lZTVowVWF1RzhLaFBGaDRM?=
 =?utf-8?B?eTdwYWxaNHZUajBHM0Y5ZjF4RTFWR1JMMnk3c2F1QlZ6ZDVmUzlJRUlMNUN4?=
 =?utf-8?B?QzMyK2o2Kzd5T2d4ZVBjV2h5V3I2cGU2NDNua3dkaUxiVVdSTXFTZDJZOVd0?=
 =?utf-8?B?d2dZbFhIZTQ0dk5BREFES0Z0RTE4Q2RuQ2I3eTNIWWcxeUNFaWRSNFAzRG1m?=
 =?utf-8?B?QXdjYnBLUmxXN3JSTHNhclgyNEVyN0x0Y0tCc0VVeDVkc0lUc0VWelVSa3U4?=
 =?utf-8?B?M3hEWHNTZHB6c1kvQ3VyQUJURU84L2JaSS8rTzlFWjViWUpSZWFBWm5lRFdQ?=
 =?utf-8?B?emFFWVpJZ2NDZ0toZ1ZVMTB6cnpnMGJScmwyRlQva3pKeHNXQTlzWksxQy9N?=
 =?utf-8?B?YjlveElRbUJsTmZyUml3bU9aQmpvZXNXZHFuS2lzcTFKN2FTbzZDWXZxUmRS?=
 =?utf-8?B?Qm5ldU9LOG1MQ3lrcC9yWm0xNkx0NmVrMUxzaFpWRkI5TldRd0M4cEpmU21I?=
 =?utf-8?B?ZE5CaFpoU3JHL3VoUzcwa0ZTRWM3RGc1QjlTQ0daVWluZ2FsNDJKZzdmZGZD?=
 =?utf-8?B?SnEwaG5aUk41REZOb2NBbWY4c3NoYWYybEs4U1l3MGo3V2tCNDNJSUtuZFNq?=
 =?utf-8?B?TG9MR3JvSjBadzdyYXd3clFTWUlBYmswcnp2bXp6OElMUzlmbUJLOXlWYjlI?=
 =?utf-8?B?dG8zQU5xd0grWXdPT3NRb0ZCWW9XSGFWdU1UMmhyV2pWMkY5R0tRb2JkQ1hi?=
 =?utf-8?B?d2FzcjY0dnpGVVFPVHdYa0VOOHhxU1VsYUN2NWlLeHI0c2xla2EyeUcxQ210?=
 =?utf-8?B?SlJSRjZqc2M4L1NHTFZzNHhneFlxWkZhaC8yZUlITHlrUzRiWHkyQjJYM2NZ?=
 =?utf-8?B?Y3Z6emp3UjRrUlpaMDZ3V21IcTVqeUNwRXVybnBtM0VCVEthMFA5K21KMGNp?=
 =?utf-8?B?eEM1WHhJUDdjNFFjVm9UekdyS0lTdVpYZDlzSlBvam16NFNrcURMQXRGU0NI?=
 =?utf-8?B?T3pxZnU0Wm1Lb2UxQldVakM3UlA0L0ZwWEZ0M2RlMU9vTHp3V2IzZkJ0OWM2?=
 =?utf-8?B?cE1ib09RTGFhUGxMTE9XSkRxYldjVGtNYm1YV3gzeTdkS3ozejQ4UUJuQzBX?=
 =?utf-8?B?MjZPVFJBd3Z2VGVSTWZGK3Q0T0ZvY3NWYzdKQmlIV29WcTF5S1BWeUlDNHhw?=
 =?utf-8?B?T1pBWEdrODBta3R2L2FTZU5manJvZVd4TDByR0JJdDdaSkx6VGc4TGRiQWdw?=
 =?utf-8?B?RlBvV3A0b09aSk1FODZOS3V0dmRqYmdFRUVac2hxNnVUbFJPMlJJL0tqSExS?=
 =?utf-8?B?ZFVaRDdoT2EyMmIxc1NWVVpIN0cxTVFVaFhIQVVIWWo4ckkzTEtLTEpaZGxB?=
 =?utf-8?B?TXVzVXA2RFJuVXBYUmtoM1ZBMElCOFdNWU5NOTJZeERuN1ZYZUUvaFEySnlt?=
 =?utf-8?B?cU5IS3NSak1mR3ZPa0NTR0E4Y2ZWclcyRHUzbENSYkRxdUgrSTYvQVV3N0dx?=
 =?utf-8?B?N1pkOFM2L0tudm12T05penV4OHBLaUcvTjl3cExPRlVTTVFBQm9vNGpJUEhw?=
 =?utf-8?B?bzJyaWNUVmRIS2tKRktXV3MyTE5qZU1odzJWVitHU21JdE8zMUMwb09rQjZD?=
 =?utf-8?B?cXRka3ZCWFpFcXBxWXlLdEdoa2w1OTU1V3RDNkFYd05VRWt1YkxjN0xSMlpE?=
 =?utf-8?B?UEJpUjdpZlBjcTNaSWljbmJJQ01GSzVFVGp6TTdYVEFBaXA1RFA3elBicDM5?=
 =?utf-8?B?NzU5QnNzNW1BMXlIZ0FGakl0dDFrTk9UMXU5SVBmZWN2OWE1VS85eHRwVHdK?=
 =?utf-8?B?MFhnVGhuTENSWlkvTFVvU2RKL040VVIxekJkNzcyRUE1TWVwU05DaVVjRTJB?=
 =?utf-8?B?dUE4OHBnNTVPY2JrNU5EY1lGbENtMmFBQXBGT3pZRm9Md3JUYXBtQmxJTk1U?=
 =?utf-8?B?NFJtc2V0Z1R1QVQrRmVhRWMvcUVUR1k0c1pHWUhYeEdxWkN0bVFtNWdaQktm?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c05cce-1e7e-4ae2-b6bb-08dc3405bc2c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 00:24:01.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hNPPklaLl2kxavrs5ovwKv/YYkLEXPpXM/o11OECF8LONm3h1a7Xmv47D9RP034N31SEZfOCWj6HPRwv2zR5plXTsN9CZ75MZjejejPCf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7260
X-OriginatorOrg: intel.com

On 2/22/2024 2:36 PM, Jakub Kicinski wrote:
> The ethtool-nl family does a good job exposing various protocol
> related and IEEE/IETF statistics which used to get dumped under
> ethtool -S, with creative names. Queue stats don't have a netlink
> API, yet, and remain a lion's share of ethtool -S output for new
> drivers. Not only is that bad because the names differ driver to
> driver but it's also bug-prone. Intuitively drivers try to report
> only the stats for active queues, but querying ethtool stats
> involves multiple system calls, and the number of stats is
> read separately from the stats themselves. Worse still when user
> space asks for values of the stats, it doesn't inform the kernel
> how big the buffer is. If number of stats increases in the meantime
> kernel will overflow user buffer.
> 
> Add a netlink API for dumping queue stats. Queue information is
> exposed via the netdev-genl family, so add the stats there.
> Support per-queue and sum-for-device dumps. Latter will be useful
> when subsequent patches add more interesting common stats than
> just bytes and packets.
> 
> The API does not currently distinguish between HW and SW stats.
> The expectation is that the source of the stats will either not
> matter much (good packets) or be obvious (skb alloc errors).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml |  84 +++++++++
>   Documentation/networking/statistics.rst |  17 +-
>   include/linux/netdevice.h               |   3 +
>   include/net/netdev_queues.h             |  54 ++++++
>   include/uapi/linux/netdev.h             |  20 +++
>   net/core/netdev-genl-gen.c              |  12 ++
>   net/core/netdev-genl-gen.h              |   2 +
>   net/core/netdev-genl.c                  | 218 ++++++++++++++++++++++++
>   tools/include/uapi/linux/netdev.h       |  20 +++
>   9 files changed, 429 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 3addac970680..eea41e9de98c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -74,6 +74,10 @@ name: netdev
>       name: queue-type
>       type: enum
>       entries: [ rx, tx ]
> +  -
> +    name: stats-projection
> +    type: enum
> +    entries: [ netdev, queue ]
>   
>   attribute-sets:
>     -
> @@ -265,6 +269,66 @@ name: netdev
>           doc: ID of the NAPI instance which services this queue.
>           type: u32
>   
> +  -
> +    name: stats
> +    doc: |
> +      Get device statistics, scoped to a device or a queue.
> +      These statistics extend (and partially duplicate) statistics available
> +      in struct rtnl_link_stats64.
> +      Value of the `projection` attribute determines how statistics are
> +      aggregated. When aggregated for the entire device the statistics
> +      represent the total number of events since last explicit reset of
> +      the device (i.e. not a reconfiguration like changing queue count).
> +      When reported per-queue, however, the statistics may not add
> +      up to the total number of events, will only be reported for currently
> +      active objects, and will likely report the number of events since last
> +      reconfiguration.
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: ifindex of the netdevice to which stats belong.
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queue-type
> +        doc: Queue type as rx, tx, for queue-id.
> +        type: u32
> +        enum: queue-type
> +      -
> +        name: queue-id
> +        doc: Queue ID, if stats are scoped to a single queue instance.
> +        type: u32
> +      -
> +        name: projection
> +        doc: |
> +          What object type should be used to iterate over the stats.
> +        type: uint
> +        enum: stats-projection
> +      -
> +        name: rx-packets
> +        doc: |
> +          Number of wire packets successfully received and passed to the stack.
> +          For drivers supporting XDP, XDP is considered the first layer
> +          of the stack, so packets consumed by XDP are still counted here.
> +        type: uint
> +        value: 8 # reserve some attr ids in case we need more metadata later
> +      -
> +        name: rx-bytes
> +        doc: Successfully received bytes, see `rx-packets`.
> +        type: uint
> +      -
> +        name: tx-packets
> +        doc: |
> +          Number of wire packets successfully sent. Packet is considered to be
> +          successfully sent once it is in device memory (usually this means
> +          the device has issued a DMA completion for the packet).
> +        type: uint
> +      -
> +        name: tx-bytes
> +        doc: Successfully sent bytes, see `tx-packets`.
> +        type: uint
> +
>   operations:
>     list:
>       -
> @@ -405,6 +469,26 @@ name: netdev
>             attributes:
>               - ifindex
>           reply: *napi-get-op
> +    -
> +      name: stats-get
> +      doc: |
> +        Get / dump fine grained statistics. Which statistics are reported
> +        depends on the device and the driver, and whether the driver stores
> +        software counters per-queue.
> +      attribute-set: stats
> +      dump:
> +        request:
> +          attributes:
> +            - projection
> +        reply:
> +          attributes:
> +            - ifindex
> +            - queue-type
> +            - queue-id
> +            - rx-packets
> +            - rx-bytes
> +            - tx-packets
> +            - tx-bytes
>   
>   mcast-groups:
>     list:
> diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
> index 551b3cc29a41..8a4d166af3c0 100644
> --- a/Documentation/networking/statistics.rst
> +++ b/Documentation/networking/statistics.rst
> @@ -41,6 +41,15 @@ If `-s` is specified once the detailed errors won't be shown.
>   
>   `ip` supports JSON formatting via the `-j` option.
>   
> +Queue statistics
> +~~~~~~~~~~~~~~~~
> +
> +Queue statistics are accessible via the netdev netlink family.
> +
> +Currently no widely distributed CLI exists to access those statistics.
> +Kernel development tools (ynl) can be used to experiment with them,
> +see :ref:`Documentation/userspace-api/netlink/intro-specs.rst`.
> +
>   Protocol-specific statistics
>   ----------------------------
>   
> @@ -134,7 +143,7 @@ reading multiple stats as it internally performs a full dump of
>   and reports only the stat corresponding to the accessed file.
>   
>   Sysfs files are documented in
> -`Documentation/ABI/testing/sysfs-class-net-statistics`.
> +:ref:`Documentation/ABI/testing/sysfs-class-net-statistics`.
>   
>   
>   netlink
> @@ -147,6 +156,12 @@ Statistics are reported both in the responses to link information
>   requests (`RTM_GETLINK`) and statistic requests (`RTM_GETSTATS`,
>   when `IFLA_STATS_LINK_64` bit is set in the `.filter_mask` of the request).
>   
> +netdev (netlink)
> +~~~~~~~~~~~~~~~~
> +
> +`netdev` generic netlink family allows accessing page pool and per queue
> +statistics.
> +
>   ethtool
>   -------
>   
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f07c8374f29c..afcb2a0566f9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2039,6 +2039,7 @@ enum netdev_reg_state {
>    *
>    *	@sysfs_rx_queue_group:	Space for optional per-rx queue attributes
>    *	@rtnl_link_ops:	Rtnl_link_ops
> + *	@stat_ops:	Optional ops for queue-aware statistics
>    *
>    *	@gso_max_size:	Maximum size of generic segmentation offload
>    *	@tso_max_size:	Device (as in HW) limit on the max TSO request size
> @@ -2419,6 +2420,8 @@ struct net_device {
>   
>   	const struct rtnl_link_ops *rtnl_link_ops;
>   
> +	const struct netdev_stat_ops *stat_ops;
> +
>   	/* for setting kernel sock attribute on TCP connection setup */
>   #define GSO_MAX_SEGS		65535u
>   #define GSO_LEGACY_MAX_SIZE	65536u
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 8b8ed4e13d74..d633347eeda5 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -4,6 +4,60 @@
>   
>   #include <linux/netdevice.h>
>   
> +struct netdev_queue_stats_rx {
> +	u64 bytes;
> +	u64 packets;
> +};
> +
> +struct netdev_queue_stats_tx {
> +	u64 bytes;
> +	u64 packets;
> +};
> +
> +/**
> + * struct netdev_stat_ops - netdev ops for fine grained stats
> + * @get_queue_stats_rx:	get stats for a given Rx queue
> + * @get_queue_stats_tx:	get stats for a given Tx queue
> + * @get_base_stats:	get base stats (not belonging to any live instance)
> + *
> + * Query stats for a given object. The values of the statistics are undefined
> + * on entry (specifically they are *not* zero-initialized). Drivers should
> + * assign values only to the statistics they collect. Statistics which are not
> + * collected must be left undefined.
> + *
> + * Queue objects are not necessarily persistent, and only currently active
> + * queues are queried by the per-queue callbacks. This means that per-queue
> + * statistics will not generally add up to the total number of events for
> + * the device. The @get_base_stats callback allows filling in the delta
> + * between events for currently live queues and overall device history.
> + * When the statistics for the entire device are queried, first @get_base_stats
> + * is issued to collect the delta, and then a series of per-queue callbacks.
> + * Only statistics which are set in @get_base_stats will be reported
> + * at the device level, meaning that unlike in queue callbacks, setting
> + * a statistic to zero in @get_base_stats is a legitimate thing to do.
> + * This is because @get_base_stats has a second function of designating which
> + * statistics are in fact correct for the entire device (e.g. when history
> + * for some of the events is not maintained, and reliable "total" cannot
> + * be provided).
> + *
> + * Device drivers can assume that when collecting total device stats,
> + * the @get_base_stats and subsequent per-queue calls are performed
> + * "atomically" (without releasing the rtnl_lock).
> + *
> + * Device drivers are encouraged to reset the per-queue statistics when
> + * number of queues change. This is because the primary use case for
> + * per-queue statistics is currently to detect traffic imbalance.
> + */
> +struct netdev_stat_ops {
> +	void (*get_queue_stats_rx)(struct net_device *dev, int idx,
> +				   struct netdev_queue_stats_rx *stats);
> +	void (*get_queue_stats_tx)(struct net_device *dev, int idx,
> +				   struct netdev_queue_stats_tx *stats);
> +	void (*get_base_stats)(struct net_device *dev,
> +			       struct netdev_queue_stats_rx *rx,
> +			       struct netdev_queue_stats_tx *tx);
> +};
> +
>   /**
>    * DOC: Lockless queue stopping / waking helpers.
>    *
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 93cb411adf72..c6a5e4b03828 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -70,6 +70,11 @@ enum netdev_queue_type {
>   	NETDEV_QUEUE_TYPE_TX,
>   };
>   
> +enum netdev_stats_projection {
> +	NETDEV_STATS_PROJECTION_NETDEV,
> +	NETDEV_STATS_PROJECTION_QUEUE,
> +};
> +
>   enum {
>   	NETDEV_A_DEV_IFINDEX = 1,
>   	NETDEV_A_DEV_PAD,
> @@ -132,6 +137,20 @@ enum {
>   	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
>   };
>   
> +enum {
> +	NETDEV_A_STATS_IFINDEX = 1,
> +	NETDEV_A_STATS_QUEUE_TYPE,
> +	NETDEV_A_STATS_QUEUE_ID,
> +	NETDEV_A_STATS_PROJECTION,
> +	NETDEV_A_STATS_RX_PACKETS = 8,
> +	NETDEV_A_STATS_RX_BYTES,
> +	NETDEV_A_STATS_TX_PACKETS,
> +	NETDEV_A_STATS_TX_BYTES,
> +
> +	__NETDEV_A_STATS_MAX,
> +	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
> +};
> +
>   enum {
>   	NETDEV_CMD_DEV_GET = 1,
>   	NETDEV_CMD_DEV_ADD_NTF,
> @@ -144,6 +163,7 @@ enum {
>   	NETDEV_CMD_PAGE_POOL_STATS_GET,
>   	NETDEV_CMD_QUEUE_GET,
>   	NETDEV_CMD_NAPI_GET,
> +	NETDEV_CMD_STATS_GET,
>   
>   	__NETDEV_CMD_MAX,
>   	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index be7f2ebd61b2..a786590fc0e2 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -68,6 +68,11 @@ static const struct nla_policy netdev_napi_get_dump_nl_policy[NETDEV_A_NAPI_IFIN
>   	[NETDEV_A_NAPI_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
>   };
>   
> +/* NETDEV_CMD_STATS_GET - dump */
> +static const struct nla_policy netdev_stats_get_nl_policy[NETDEV_A_STATS_PROJECTION + 1] = {
> +	[NETDEV_A_STATS_PROJECTION] = NLA_POLICY_MAX(NLA_UINT, 1),
> +};
> +
>   /* Ops table for netdev */
>   static const struct genl_split_ops netdev_nl_ops[] = {
>   	{
> @@ -138,6 +143,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>   		.maxattr	= NETDEV_A_NAPI_IFINDEX,
>   		.flags		= GENL_CMD_CAP_DUMP,
>   	},
> +	{
> +		.cmd		= NETDEV_CMD_STATS_GET,
> +		.dumpit		= netdev_nl_stats_get_dumpit,
> +		.policy		= netdev_stats_get_nl_policy,
> +		.maxattr	= NETDEV_A_STATS_PROJECTION,
> +		.flags		= GENL_CMD_CAP_DUMP,
> +	},
>   };
>   
>   static const struct genl_multicast_group netdev_nl_mcgrps[] = {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index a47f2bcbe4fa..de878ba2bad7 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -28,6 +28,8 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
>   			       struct netlink_callback *cb);
>   int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
>   int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb);
>   
>   enum {
>   	NETDEV_NLGRP_MGMT,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fd98936da3ae..fe4e9bc5436a 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -8,6 +8,7 @@
>   #include <net/xdp.h>
>   #include <net/xdp_sock.h>
>   #include <net/netdev_rx_queue.h>
> +#include <net/netdev_queues.h>
>   #include <net/busy_poll.h>
>   
>   #include "netdev-genl-gen.h"
> @@ -469,6 +470,223 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	return skb->len;
>   }
>   
> +#define NETDEV_STAT_NOT_SET		(~0ULL)
> +
> +static void
> +netdev_nl_stats_add(void *_sum, const void *_add, size_t size)
> +{
> +	const u64 *add = _add;
> +	u64 *sum = _sum;
> +
> +	while (size) {
> +		if (*add != NETDEV_STAT_NOT_SET && *sum != NETDEV_STAT_NOT_SET)
> +			*sum += *add;
> +		sum++;
> +		add++;
> +		size -= 8;
> +	}
> +}
> +
> +static int netdev_stat_put(struct sk_buff *rsp, unsigned int attr_id, u64 value)
> +{
> +	if (value == NETDEV_STAT_NOT_SET)
> +		return 0;
> +	return nla_put_uint(rsp, attr_id, value);
> +}
> +
> +static int
> +netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
> +{
> +	if (netdev_stat_put(rsp, NETDEV_A_STATS_RX_PACKETS, rx->packets) ||
> +	    netdev_stat_put(rsp, NETDEV_A_STATS_RX_BYTES, rx->bytes))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
> +{
> +	if (netdev_stat_put(rsp, NETDEV_A_STATS_TX_PACKETS, tx->packets) ||
> +	    netdev_stat_put(rsp, NETDEV_A_STATS_TX_BYTES, tx->bytes))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_queue(struct net_device *netdev, struct sk_buff *rsp,
> +		      u32 q_type, int i, const struct genl_info *info)
> +{
> +	const struct netdev_stat_ops *ops = netdev->stat_ops;
> +	struct netdev_queue_stats_rx rx;
> +	struct netdev_queue_stats_tx tx;
> +	void *hdr;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +	if (nla_put_u32(rsp, NETDEV_A_STATS_IFINDEX, netdev->ifindex) ||
> +	    nla_put_u32(rsp, NETDEV_A_STATS_QUEUE_TYPE, q_type) ||
> +	    nla_put_u32(rsp, NETDEV_A_STATS_QUEUE_ID, i))
> +		goto nla_put_failure;
> +
> +	switch (q_type) {
> +	case NETDEV_QUEUE_TYPE_RX:
> +		memset(&rx, 0xff, sizeof(rx));
> +		ops->get_queue_stats_rx(netdev, i, &rx);
> +		if (!memchr_inv(&rx, 0xff, sizeof(rx)))
> +			goto nla_cancel;
> +		if (netdev_nl_stats_write_rx(rsp, &rx))
> +			goto nla_put_failure;
> +		break;
> +	case NETDEV_QUEUE_TYPE_TX:
> +		memset(&tx, 0xff, sizeof(tx));
> +		ops->get_queue_stats_tx(netdev, i, &tx);
> +		if (!memchr_inv(&tx, 0xff, sizeof(tx)))
> +			goto nla_cancel;
> +		if (netdev_nl_stats_write_tx(rsp, &tx))
> +			goto nla_put_failure;
> +		break;
> +	}
> +
> +	genlmsg_end(rsp, hdr);
> +	return 0;
> +
> +nla_cancel:
> +	genlmsg_cancel(rsp, hdr);
> +	return 0;
> +nla_put_failure:
> +	genlmsg_cancel(rsp, hdr);
> +	return -EMSGSIZE;
> +}
> +
> +static int
> +netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
> +			 const struct genl_info *info,
> +			 struct netdev_nl_dump_ctx *ctx)
> +{
> +	const struct netdev_stat_ops *ops = netdev->stat_ops;
> +	int i, err;
> +
> +	if (!(netdev->flags & IFF_UP))
> +		return 0;
> +
> +	i = ctx->rxq_idx;
> +	while (ops->get_queue_stats_rx && i < netdev->real_num_rx_queues) {
> +		err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_RX,
> +					    i, info);
> +		if (err)
> +			return err;
> +		ctx->rxq_idx = i++;
> +	}
> +	i = ctx->txq_idx;
> +	while (ops->get_queue_stats_tx && i < netdev->real_num_tx_queues) {
> +		err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_TX,
> +					    i, info);
> +		if (err)
> +			return err;
> +		ctx->txq_idx = i++;
> +	}
> +
> +	ctx->rxq_idx = 0;
> +	ctx->txq_idx = 0;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
> +			  const struct genl_info *info)
> +{
> +	struct netdev_queue_stats_rx rx_sum, rx;
> +	struct netdev_queue_stats_tx tx_sum, tx;
> +	const struct netdev_stat_ops *ops;
> +	void *hdr;
> +	int i;
> +
> +	ops = netdev->stat_ops;
> +	/* Netdev can't guarantee any complete counters */
> +	if (!ops->get_base_stats)
> +		return 0;
> +
> +	memset(&rx_sum, 0xff, sizeof(rx_sum));
> +	memset(&tx_sum, 0xff, sizeof(tx_sum));
> +
> +	ops->get_base_stats(netdev, &rx_sum, &tx_sum);
> +
> +	/* The op was there, but nothing reported, don't bother */
> +	if (!memchr_inv(&rx_sum, 0xff, sizeof(rx_sum)) &&
> +	    !memchr_inv(&tx_sum, 0xff, sizeof(tx_sum)))
> +		return 0;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +	if (nla_put_u32(rsp, NETDEV_A_STATS_IFINDEX, netdev->ifindex))
> +		goto nla_put_failure;
> +
> +	for (i = 0; i < netdev->real_num_rx_queues; i++) {
> +		memset(&rx, 0xff, sizeof(rx));
> +		if (ops->get_queue_stats_rx)
> +			ops->get_queue_stats_rx(netdev, i, &rx);
> +		netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
> +	}
> +	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> +		memset(&tx, 0xff, sizeof(tx));
> +		if (ops->get_queue_stats_tx)
> +			ops->get_queue_stats_tx(netdev, i, &tx);
> +		netdev_nl_stats_add(&tx_sum, &tx, sizeof(tx));
> +	}
> +
> +	if (netdev_nl_stats_write_rx(rsp, &rx_sum) ||
> +	    netdev_nl_stats_write_tx(rsp, &tx_sum))
> +		goto nla_put_failure;
> +
> +	genlmsg_end(rsp, hdr);
> +	return 0;
> +
> +nla_put_failure:
> +	genlmsg_cancel(rsp, hdr);
> +	return -EMSGSIZE;
> +}
> +
> +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb)
> +{
> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> +	const struct genl_info *info = genl_info_dump(cb);
> +	enum netdev_stats_projection projection;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *netdev;
> +	int err = 0;
> +
> +	projection = NETDEV_STATS_PROJECTION_NETDEV;
> +	if (info->attrs[NETDEV_A_STATS_PROJECTION])
> +		projection =
> +			nla_get_uint(info->attrs[NETDEV_A_STATS_PROJECTION]);
> +
> +	rtnl_lock();

Could we also add filtered-dump for a user provided ifindex ?

> +	for_each_netdev_dump(net, netdev, ctx->ifindex) {
> +		if (!netdev->stat_ops)
> +			continue;
> +
> +		switch (projection) {
> +		case NETDEV_STATS_PROJECTION_NETDEV:
> +			err = netdev_nl_stats_by_netdev(netdev, skb, info);
> +			break;
> +		case NETDEV_STATS_PROJECTION_QUEUE:
> +			err = netdev_nl_stats_by_queue(netdev, skb, info, ctx);
> +			break;
> +		}
> +		if (err < 0)
> +			break;
> +	}
> +	rtnl_unlock();
> +
> +	if (err != -EMSGSIZE)
> +		return err;
> +
> +	return skb->len;
> +}
> +
>   static int netdev_genl_netdevice_event(struct notifier_block *nb,
>   				       unsigned long event, void *ptr)
>   {
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 93cb411adf72..c6a5e4b03828 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -70,6 +70,11 @@ enum netdev_queue_type {
>   	NETDEV_QUEUE_TYPE_TX,
>   };
>   
> +enum netdev_stats_projection {
> +	NETDEV_STATS_PROJECTION_NETDEV,
> +	NETDEV_STATS_PROJECTION_QUEUE,
> +};
> +
>   enum {
>   	NETDEV_A_DEV_IFINDEX = 1,
>   	NETDEV_A_DEV_PAD,
> @@ -132,6 +137,20 @@ enum {
>   	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
>   };
>   
> +enum {
> +	NETDEV_A_STATS_IFINDEX = 1,
> +	NETDEV_A_STATS_QUEUE_TYPE,
> +	NETDEV_A_STATS_QUEUE_ID,
> +	NETDEV_A_STATS_PROJECTION,
> +	NETDEV_A_STATS_RX_PACKETS = 8,
> +	NETDEV_A_STATS_RX_BYTES,
> +	NETDEV_A_STATS_TX_PACKETS,
> +	NETDEV_A_STATS_TX_BYTES,
> +
> +	__NETDEV_A_STATS_MAX,
> +	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
> +};
> +
>   enum {
>   	NETDEV_CMD_DEV_GET = 1,
>   	NETDEV_CMD_DEV_ADD_NTF,
> @@ -144,6 +163,7 @@ enum {
>   	NETDEV_CMD_PAGE_POOL_STATS_GET,
>   	NETDEV_CMD_QUEUE_GET,
>   	NETDEV_CMD_NAPI_GET,
> +	NETDEV_CMD_STATS_GET,
>   
>   	__NETDEV_CMD_MAX,
>   	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)

