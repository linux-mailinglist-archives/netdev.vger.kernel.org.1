Return-Path: <netdev+bounces-238250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FACC564C1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 750A035131F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080A331A45;
	Thu, 13 Nov 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2MAcATh"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A82DC78F;
	Thu, 13 Nov 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022820; cv=fail; b=nPWhiP+jrZlBetZj4ABbcpD3rU2WRVQWW9oK6cHj/zKX/vVxnTNbU7GtMNO8iPtuGaT4lcC2PK2Fk2sBHlSVZVo8mz6Nj6OFJnTXFbJCzYTFHf7/q5PbD2YQgX/3XPnZhy465aUKcT09Xb9vdaYD9sYYCNKDIQNlaX3U1RxLCQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022820; c=relaxed/simple;
	bh=UKzN8sWZcuuf6d3vzwOeK8nPkpR317JEtHZzmq6/jYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tv/rHQHvaQkkGfIYvKtxiM9ZsHX3kl7Ki4urHOjfAER4hKEqGhOiiMpoh+W9pp6pGizMkXQfRih8Hx8lk2kDY3iBIXmXa71BfzbawiJHju5rCHhf8HBnQV+YhFHfLq5CCb+qY1JgYM8nJqB+d+PlIEVgF1lpEuxQDL1TrVcTKI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2MAcATh; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJi0sepfcsmObxR+CNP7Y7/EpdAWZcXhcBKUaDgm4Jm1ykLKdgKczpZMtRh7GmouD9rZgjXye2BEn7j0eSIbnpHi8LcUV/IfFv4PPfe7vDY3JYd0jRs7DrKhMp8ip23Dsd9gpjHMOV8Sl+QbGByW4NSzTT5dn8oteYNitH8OXTHo8VVIJABZ1P5pk1eEK4CDx+NhIJnB1Ta1rkW2LITj5VZXmBPf1RME2emTHSrxX0gSvzlh553O48v1Dr5q0oo0r0hFwG/UBfRnXeT4N0WvXqjCZcJloI/oyCVAkIWj8f27+a6LgcdnUkuobUCCwKKAAB2fYWkOWiMIhuk8RE1U5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raIMbGNO5XDJVqET35IfP3nmH98Blv4kxKAOPLGgcnI=;
 b=pve6W8MEAcGAEcA7Xd73rLtg8sskzuaMed+oC+KRKYEQMcNUJBnSxRFrOOX7DQj/hS4F3dNsJtkW7PcsE0X/Z14unRYya3yCMZVXjIMbJ7d5ENlF8cLibqKfD97UnUEY1DOsLJqWeA3ITp54BwXzdnbRw2j9xPy2VGJSZK14ew+S763VEqvoC2cMKSFUOdAsqRrcWAPPMd3ZQVEjMZKIL90zMO/MGVgJhixTfmw1wuTo/f1FL6b7pgU43DOR91GNmzj+aNQa08Taow4UU9qYmplp+ghfi5gxSsSyGNgFIuDFhBK9oDFkBm+HzG8DPQt/cNW/PM15Y5HK9I2V5JelMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raIMbGNO5XDJVqET35IfP3nmH98Blv4kxKAOPLGgcnI=;
 b=N2MAcAThrDHclT8Gcthq+xA4I0q0j5EltwrvMEQy+Kc6nv8YJjR89lGRWGPS3MppGNOqUtKWW881v0Cx+6CBk4RFTc3aDdpfdE4mtOa1w85cMZSRtk/QBIgujB8+/0MLTJD7fh4JqRNvIW4j2cLqj7O0P8NdheY2CcDPjZOHh2W1xgA40JoCt6TRT1vOe0AMUMekJRGTPfqWJ3/kUNYYslB7w98mDY8RUYWN+Wpq/VLdxcDA7dE2muovcgwz6EkWd4rEb/wW14DdViNZnbtG5A6PCUKcGHDX1AYMe6i8pVzRYLxppYakCxXuBDHZjSfHNWeO/eH82h0L/BWqfFq2FA==
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:33:32 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::5d) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 08:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 08:33:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:33:17 -0800
Received: from [10.242.158.93] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:33:12 -0800
Message-ID: <d751e671-9b73-42ce-acce-c98947b632c2@nvidia.com>
Date: Thu, 13 Nov 2025 10:33:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] devlink: rate: Unset parent pointer in
 devl_rate_nodes_destroy
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
References: <1762863279-1092021-1-git-send-email-tariqt@nvidia.com>
 <20251112181248.190415f7@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20251112181248.190415f7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9382af23-9d36-4d0b-262c-08de228f546a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk9KTytFb1ZubDRFRS9JWHh2SUhXV3JuR1drREE4eFZoZlY2RVMxQ253K1ll?=
 =?utf-8?B?VnliV2toM24ycVdJQTQ1VmptbDI0L0xabWVPNkcvaGlYaG5yTXdBaGVzakc3?=
 =?utf-8?B?UnQ5RVZ5RDllcmU2citsTTc4S0lGWUpUcVRSTHhFZnBWaElCTlBHQkFBLzFq?=
 =?utf-8?B?ckZxRTQzOU9nTWs2dHNqYUk5anZYRGt5cUU1a000cEgzdDFENVZXUXdUTG4w?=
 =?utf-8?B?aDcrNFdOQWx2dkYwb0lmMDVYeVlncnJwWFYwRFhzSVo2ZDI0cElGZGtjSXUv?=
 =?utf-8?B?NEVxSlRsZ2tIckV5Ykp1VkVSQXFnN3VJRG8vSlpESkdmbndQTmZDVHZjTFRE?=
 =?utf-8?B?QUhRMzJEZDNuZmQ3ZHNpNnVXQXhSdHd1U0oxbElZc0thbnp1ZFhQalJmSUdK?=
 =?utf-8?B?RDZhVjY3NThVS0VWczUyNjVHTU9GLytmcHE0OUlGMmNzMUljUEQ1ZWR4c1Rh?=
 =?utf-8?B?Nm14aWhFNGJxcVpYdzFCYW1VbUlCVlZ2ampVYjFZbXBwMWN2aEpETk1OOVUr?=
 =?utf-8?B?ZXQ0NUF2QVZqK1V3ZldiemZpVTFTSzhhSUFuWUIwcGNXaWJFUmQ1aVBOQkJi?=
 =?utf-8?B?c3c4ZEhyMmd3TDVFaHFDdzhta0lNbFd6aTRvMGw3THVpNlhMbW1WcFFsVFd2?=
 =?utf-8?B?QUdJandCSVdRLzJDSFk2RC82S0tXK2d3WVViU051eUg3U3RtcGZTLy95NGlL?=
 =?utf-8?B?dW1DSUZWV09PK2FLUUtKSEkvQThTNGsvaW1iMkM4UVBOSmxCM2N1K2Y0dXpL?=
 =?utf-8?B?SjdVeTd4Z0FIaDcrNU05L04veW1IcVBDQ0lKMGFHTWt3azJEYmRQTjNJWVJi?=
 =?utf-8?B?NXlaNzVMU2dpVVU3WnpGWHpySUx0Qmw0VDluRThzTnJXUFgwMlkwbldyZ3JU?=
 =?utf-8?B?VHB1L1MweGZiS2dHRDVJRkdiNVBCRXlmZTI1aHdnNS8wZXZpU2J2VWRzenh0?=
 =?utf-8?B?eEFsVE9JbkpwOVVVWldrZHRsMVBZb0RyREg1ZVJJZHdZTzFOYWFpeWoxWnJz?=
 =?utf-8?B?eUV1SUlSSVdCU2JiaTlvei9rU1RiMVh3SmI3UVJpTkNkUStJWjZ0eDlTdXZP?=
 =?utf-8?B?SHhPV05VWHFVclJjbURIVUt2c3hwckhueTVSbHVqNXBEelRUTjgrVmpsTmEx?=
 =?utf-8?B?UklVbDNPYVpITW5BdUtRbGYrL3lwaDRxWHNBOWE1dXYrSGozMXNMMXhLMDkz?=
 =?utf-8?B?YytuQWdBVHRlTDhyWVc3Zm5OdjFndUVOWXFKSjJlZmpVaVhsNE9sUnY0RlBm?=
 =?utf-8?B?ZEdXUGxScHdZUDNuZ0toZjVmSFlnN1AwR0FIQWhtMnIzT3hON3lvci9JbERo?=
 =?utf-8?B?cGdPZWNLM3VucVMyOVErRTVhcU9zdGJPSzd6TFp5VHhjc05UQ1VKYkpqbzBW?=
 =?utf-8?B?blYvMVIwN1hId3d3SU1EOGF4R3hqT2dYQU9nNFJqdUhXTERRQUF2QWFuRi9o?=
 =?utf-8?B?bVBPQndtcVNmZzBabU1VQTBsbGZGQzJZYSs4KzJ4SVFWVml6MEdEZ1RjZ3Ay?=
 =?utf-8?B?L2tybWh5UElINXZKMmlXVjZyazBzSEYyWFh0L2dpREJXZWpVVEg1TW8xeTVh?=
 =?utf-8?B?SllSOGZ1bHpWVStVelE4Wi9pb3JvaFlCVlVwZUdCVm9iektDNHF0b0htbVhu?=
 =?utf-8?B?U1ZCcjZaNEhaY0pNcHRROFZ0RGNjMHRraER2ZHI1ZlZxRDh2ZU9heWZVRnBk?=
 =?utf-8?B?S0gvOUFKd0x0eDRUN0FGc3EvREZLa0pzTi90MW5mTFBLTmhuaDJwb2RxM0sy?=
 =?utf-8?B?NER5clRRUVJndzV3WGdOSm5jVXY4QjdKaktRdHZBTXU3MWNhT0NTaXgzNEcz?=
 =?utf-8?B?V2wzakhRT3RDWG50dTVFd0NjQlJjZTdNWTloS3FIUmQ1WXBRdThndFNSeUNi?=
 =?utf-8?B?RWQ2VVhQblNINXlDZklOaTcydkRYL3RlT2dMcHFCaTJ6Z09kS2FEcy9nTkps?=
 =?utf-8?B?ZlpRQ3RFVjJPRS9UOVhLUTl4eUVNcEtjdDJSU1hXZXc0cFBwNHhpSG1sZ1lK?=
 =?utf-8?B?UGlaMmRYMnkvQVJWT3dDbEZDMm8xQ0drR0M5SU5yb3hUazluUmhjeUpFY1ow?=
 =?utf-8?B?LzBEa0FuWlpVU29WWGI5ZnVWR0VrcTFzKzJYb1lYSGJLalh3YTU0bWt2S0tZ?=
 =?utf-8?Q?4gUs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:33:32.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9382af23-9d36-4d0b-262c-08de228f546a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C



On 13/11/2025 4:12, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 11 Nov 2025 14:14:39 +0200 Tariq Toukan wrote:
>> The function devl_rate_nodes_destroy is documented to "Unset parent for
>> all rate objects". However, it was only calling the driver-specific
>> `rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
>> the parent's refcount, without actually setting the
>> `devlink_rate->parent` pointer to NULL.
>>
>> This leaves a dangling pointer in the `devlink_rate` struct, which is
>> inconsistent with the behavior of `devlink_nl_rate_parent_node_set`,
>> where the parent pointer is correctly cleared.
>>
>> This patch fixes the issue by explicitly setting `devlink_rate->parent`
>> to NULL after notifying the driver, thus fulfilling the function's
>> documented behavior for all rate objects.
> 
> What is the _real_ issue you're solving here? If the function destroys
> all nodes maybe it doesn't matter that the pointer isn't cleared.
> --
> pw-bot: cr

The problem is a leaf which have this node as a parent, now pointing to
invalid memory. When this leaf will be destroyed, in
devl_rate_leaf_destroy, we can get NULL-ptr error, or refcount error.

Is this answer your question?




