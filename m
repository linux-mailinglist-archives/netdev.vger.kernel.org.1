Return-Path: <netdev+bounces-218617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA382B3D9F8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ECA1899F9E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777A237707;
	Mon,  1 Sep 2025 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRzr6X2u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8241BC58;
	Mon,  1 Sep 2025 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708324; cv=fail; b=eSZoETT/uCUQia7KwEXV0JIjHc4+jJfAmS8vtQY4yGYxE0WXv5VFzAG8gijtPNXmX+euk93IATwxUK0dqqmolg93Kh75P2TS24c6t5HzLgbJp6q8wZbNKKAJK4TW0wGlnBJ5Q9Z2Mhj3daqeOyDnvv9sBSNstGuEV6JpbN/fF+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708324; c=relaxed/simple;
	bh=4jjAmYZp/5cmCs5P17Q/r1o8wdz824zlel2ji5SHLEY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ZqyKzRdd2xyL1hfRY6fCfssSXXSAchfXpn/qYL4BM9V2pdkOeRHYkkB0i4dpbYIjn4AuYwKmJHRrhTBr37u1RNt6I+SlK8wgiXWiqPI4wKZUktqtre/w4tbSSIpqBarhv9R2q7mLIIplvVkRtKjj1EYY7/6FxeVXVzb98jaP4DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CRzr6X2u; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G59oUHsZ0338UdjLM6HIBRrxFNegBktHHHgjgVort6+fXGglUd4tTJJRq8WZiGtjCF5U1vxb3n8dfxjVicoR8v2UplImFvlhaAqZuXcQERPlNNxb2XpSV3jLylNvsIiRMRl1bmlLwoJV4G+x+OtnmNRPjwqSzSv92BZenLa5sLh2/Iq4VlpocuVTi1m3QoF2oJk4Sr36nqGVjdjff3lROQIBEGV6/i2b9mY9VGhbfrqout12TrS8q/S6IxesRCQwoHOyJNPpNDECAh14fzlXy/Cxz7lVz/V6hf2eOo7wcGUDP7226wW/88QqEtulhnYMgAZLTOribxUwrLGp1YI6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRHDlOyPtMq2OqiumpJhW2m/hRHRqTBxPvslk9bfs2I=;
 b=GKaGCZRLAh/girN1GcWd0KxSIBD2FVQ0xhQT8fDPrZqGs6lr6tPjATrHnnYN53Q9wrZZQyc0H3SwcWzpYhzmaDZOh7tyJeaaqiEu+8EluZg9mKMq0u1hsAuVuCbkuFraY/Ud/TINZCek114UXoNJXxsbMYQxhckvuAsd5s5SQyFkioNkOOjSRV9DDiFdA05I++1IgBSsi/tDhCi/uTwBn0uGLBTEfAKjY+3HSALf9bjYQHOG767lEsBbTewzqw2/urTpvytNWSU7rLJ7y+FwPzU0ALLoe5eG/MQl+m+zgnZFM5avw3/CKMmlsFGHb4WyNNm2+JQLMMU4IFnPCPTo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRHDlOyPtMq2OqiumpJhW2m/hRHRqTBxPvslk9bfs2I=;
 b=CRzr6X2uefg1lz3Z6U51pqrkpu8lkLTTItSZTCuVnuejxM9o6zx87hvrUwINDQjEhnzS9tm40yWjMEJSLpvAUHlOh0PuhVpHukORD2mPAMz7hu7Ovwu0SLGqZNN6TBrjWxIVW1m5QGsZVYgk7k2+kxVSR91aAcVV7fIlqcg5mc+DbDcXT1REZxRdB4ExHa0ZIFLqArOZhId+eJ5+ktpsHfXacGgePau666HjAWJLiBpvel9hFO35keojcVTh1GHvSbPjQa/CbLRt5CJ1T6w4wv2cbKcEo4xK5Xv0Puwi/hDXSLiwMImwYIQXPgn4jZGh+Cl+2RNleJQlUjuB6DrOqQ==
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 06:31:59 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::cd) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 06:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 06:31:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:31:40 -0700
Received: from [10.221.201.148] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:31:32 -0700
Message-ID: <31b76f9f-d115-45d4-80d3-af7a8c626b58@nvidia.com>
Date: Mon, 1 Sep 2025 09:30:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shay Drori <shayd@nvidia.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_net-next=5D_net=3A_devlink=3A_add_port_funct?=
 =?UTF-8?Q?ion_attr_for_vport_=E2=86=94_eswitch_metadata_forwarding?=
To: Jiri Pirko <jiri@resnulli.us>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ozsh@nvidia.com>, <mbloch@nvidia.com>,
	<tariqt@nvidia.com>, <saeedm@nvidia.com>
References: <20250828065229.528417-1-shayd@nvidia.com>
 <ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
Content-Language: en-US
In-Reply-To: <ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: d21b4108-658a-4709-6722-08dde921411f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WElnSXAwNkpJTVpubTJNRVBrTitDYnZGS3dTVm9Xc1hVM3RIWDN4QnkvVGtD?=
 =?utf-8?B?dHF1TEZFeE4xcktHbTI5SHY3dzZMTEd2N1NPQ2VtR1J3K1JBUFl4QlVHSGEx?=
 =?utf-8?B?RmlZRmhaNjVXcXRncXFDdDFBWUY1L2JzVCt1RldxajE5RXdHcEZpOTdtU0dm?=
 =?utf-8?B?V0swRVd2M0xlL09BdlYzRXk5N3IyQkZTZHhkeUIyUEF3TlJMc0toclJTQWVp?=
 =?utf-8?B?VE5LdUg4S1ZDQ3JCVWl0Vmh4WlBESkpLNWJLWGV4SzR5aUExcFAzV1RNQXdt?=
 =?utf-8?B?RERiSVhDOTdleStST2duRUhHWDNPTXZ1MzhpcWpjQkJhWjZIcFk3OWxEc0Q2?=
 =?utf-8?B?cEpVNDZEOU5XeGpuN1ZnS25JemVqRDY2TVZJU0czK2pzQm5HM1VFK2RXWTlz?=
 =?utf-8?B?VytYVi9COUo5ZE1ZRi9vSFdXR0k4ZG1ZQXozRmgxcUorbDNiRTg4VkdNRkpP?=
 =?utf-8?B?ZzBvYjF1c3A2ejBZc2JuUzFldHFyWlJ5RFNEdGxlNnl1SGpGRlQ4ekNNZGM0?=
 =?utf-8?B?Q3ZudmR3eGdkd0JDaW1VcmdhWXYwNmozQ1lSYk91ZXFrZlUzUWhVSmhOYWVo?=
 =?utf-8?B?QVZGbzdFcDRpVkU2T3QvSWFyODNTeU4vTWJqZmhHS1lJcG5BcEpjN0N0U3Iv?=
 =?utf-8?B?OXVMM3JMbDFzQk5hbTc1UU1YTW9MRDJrdzJiRTgzMysxenEzU014OFJQVVFq?=
 =?utf-8?B?Vk80MzJWT1p0RmRWNnNnZkYzcHk2L1RBNW12SThnajZpRkNUSTJVazlUclhz?=
 =?utf-8?B?NTcwT2RSdHpkaG5uSEJtcGlLbWxyQ28zRDZyL3QwenA0Qmh5ZUY4WWZCakFI?=
 =?utf-8?B?MTdaV1pXY09LdGE3aW1vdWVVMStOajlkS2I5UlNITkhaaXQ0MVE0eWxBUTF2?=
 =?utf-8?B?ZU83cmVUaHVCVGFQWFZYNWZhUzE0d0VCSXpwaEU3bEhYUVFPRGhoem9SeWxt?=
 =?utf-8?B?K3JaNjQ1VGFOSlk3djh2QzV2MmcwVFVYa3k4Z2x2QWFmRE1jS0JvSmdFckdR?=
 =?utf-8?B?Y1pTVXJydnR5ZUg1Um81ZUhWYm84U0s5QXJUWWxzMnI2aE9iS2VWR2NocWp6?=
 =?utf-8?B?enJoaUFmNnBiSTZlcjNUaHdONzBRR0F6SG8zU3VCTmxZSTFvTkJHby9NaGNO?=
 =?utf-8?B?b1QydzF2S1NNRkhWK1lZeUQxeWk4UHJvcmM4YzU0b2lYQVQxV3pudVc2Y2I3?=
 =?utf-8?B?QXR2RTVqbFo4UkJnNFdRKzFWTmJWbExsdkxFKzAxbzN0dWVzNUtrL3R5S1dC?=
 =?utf-8?B?TzZXc3FpYWhkUjkwWjltS1RxQmtsbW52QUp0VUk1bG9WUkN1U1VqcFBxQ3hr?=
 =?utf-8?B?NjhjcFJhWjNWWEV6WE16QkxrTHZHandlTXl1NDMvTUhjb2ZCNE1tZVhTOENk?=
 =?utf-8?B?NkhLVmRKM0VYOEJuM1lIY3EzcnJoL2Z5bzB2MGFsY1VCeHNaWWxPMUNnN01U?=
 =?utf-8?B?dmJ0WFZCenJ5MW0zQ3RQbmxOeHI2cUxsdmJ5VXlKSE1oV1V4aU00S2xjSW8y?=
 =?utf-8?B?czJsSy9GcFlFVmxQOUo4cWNwemVteXNobDh6WlIvb0o5MmN2VWlibEVaN2lo?=
 =?utf-8?B?aHhITFJDTnAraVptVnRMSmljZ3czbDJoejJxd1drcXlzSmZRTitLTnFnbmFs?=
 =?utf-8?B?VEpQUFVTOUdzQU1reEYwVTlFR3Y2bjNVRGZxbmVRUUUxZlRLNm9uRWV4VnRu?=
 =?utf-8?B?YzY3VU9vaHVTd0hVbkhhRm5WK0JEdXFpQjB4NGpicXN1SEZmSzhUUU9ZbEhW?=
 =?utf-8?B?RVlaenlXVGFmaGtYTU9nek56MUIzYy9NSDB3M2JYdXBBOTlqS2R6QmFmdCsr?=
 =?utf-8?B?dXRIbHozZ2grV2FuUDFoYmJZNGgrYzRKdmJ0UGhndHh5NnZkanZyZnZvN3hD?=
 =?utf-8?B?T3JSNXBxVC9QQVdLeTBZWENENjlTMXhCaHZlV0R6RkRKRk1TVEEyQ2xaZk00?=
 =?utf-8?B?amVFUzhuN2xwalI5WWxvZ2NjaGg4cmtOMkhhYkM4MFEyWG5EajlnZ1hOa2Y1?=
 =?utf-8?B?MEVCZnlJejdqdkFvanpHOUFHSG5YdkVTV2FaVG5YOVBjVkxvYWtxN2I4VmxX?=
 =?utf-8?Q?y6Nemv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:31:59.1925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21b4108-658a-4709-6722-08dde921411f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 28/08/2025 12:03, Jiri Pirko wrote:
> External email: Use caution opening links or attachments
> 
> 
> :q
> Thu, Aug 28, 2025 at 08:52:29AM +0200, shayd@nvidia.com wrote:
>> In some product architectures, the eswitch manager and the exception
>> handler run as separate user space processes. The eswitch manager uses
>> the physical uplink device, while the slow path handler uses a virtual
>> device.
>>
>> In this architectures, the eswitch manager application program the HW to
>> send the exception packets to specific vport, and on top this vport
>> virtual device, the exception application is running and handling these
>> packets.
>>
>> Currently, when packets are forwarded between the eswitch and a vport,
>> no per-packet metadata is preserved. As a result, the slow path handler
>> cannot implement features that require visibility into the packet's
>> hardware context.
> 
> A vendor-specific slow path. Basically you provide a possibility for
> user to pass a binary blob to hw along with every TX'ed packet and
> vice versa. That looks quite odd tbh. I mean, isn't this horribly
> breaking the socket abstraction? Also, isn't this horribly breaking the
> forwarding offloading model when HW should just mimic the behaviour of
> the kernel?

This feature is targeted at kernel-bypass applications, which already
operate outside the Linux kernel’s traditional networking stack.
These applications need access to hardware-specific metadata to make
forwarding decisions or offload acceleration, and they do not use
“representor” devices in the same way as kernel-driven virtual functions.

The devlink interface configures the hardware switch, and these knobs
adjust how metadata is preserved between the e-switch manager and the
exception handler.

> 
> 
> 
>>
>> This RFC introduces two optional devlink port-function attributes. When
>> these two capabilities are enable for a function of the port, the device
>> is making the necessary preparations for the function to exchange
>> metadata with the eswitch.
>>
>> rx_metadata
>> When enabled, packets received by the vport from the eswitch will be
>> prepended with a device-specific metadata header. This allows the slow
>> path application to receive the full context of the packet as seen by
>> the hardware.
>>
>> tx_metadata
>> When enabled, the vport can send a packet prepended with a metadata
>> header. The eswitch hardware consumes this metadata to steer the packet.
>>
>> Together they allow the said app to process slow-path events in
>> user-space at line rate while still leaving the common fast-path in
>> hardware.
>>
>> User-space interface
>> Enable / disable is done with existing devlink port-function syntax:
>>
>> $ devlink port function set pci/0000:06:00.0/3 rx_metadata enable
>> $ devlink port function set pci/0000:06:00.0/3 tx_metadata enable
>>
>> Querying the state shows the new knobs:
>>
>> $ devlink port function show pci/0000:06:00.0/3
>>   pci/0000:06:00.0/3:
>>    roce enabled rx_metadata enabled tx_metadata enabled
>>
>> Disabling is symmetrical:
>>
>> $ devlink port function set pci/0000:06:00.0/3 rx_metadata disable
>> $ devlink port function set pci/0000:06:00.0/3 tx_metadata disable
>>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>
>>
>> --
>> 2.38.1
>>


