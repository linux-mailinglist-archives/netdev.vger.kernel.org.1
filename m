Return-Path: <netdev+bounces-171900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD1A4F3BD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C8B16F10D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47343B1A4;
	Wed,  5 Mar 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iQNdSz6V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715201E871
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138265; cv=fail; b=Dx5caThBubzFDgH14h9Q80z1MBvENVhgBixGl+6lOdebTRxLVgL8o8o/SCFtnn2c0/6X0NXh9WT5zE5TryHw3RDw61TqF0WboleoK1VY6uyn0yShmz1+BIp5NxqplSlVv3OTpQuK4MWOZgke+tnSAR3OR6Drgsgk9B+4DLRXHrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138265; c=relaxed/simple;
	bh=nNdCHEi8pXljcM5z60rJY9GhKBPN5x1ORmlz4jcrGDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GHh3W6Y5NL/icZ7FvsnN/+Y4+TxRdJqlmIyCN1ox6VI0XopBeI9OtXSa3bD8L/kiDJjqbdGpdlnBPh6qDCX7RVRqEwf/7IN9l5dl8rNkHV6Rf628VCEwlHqzfZvHk9jNMNUhGqSCY14bKNuKXKtzDGa7aD79P54FdxHVS0mri4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iQNdSz6V; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grTcyh27tN9L4odxQm9hZ0zrJVMT6hGFAny5hkAg+BNhbuVKZh2L70sm3fpVKcam55yqIE2fTSXuj/wuJUyd563UjxkEz34x8fUIwpa+rJWY/YBPK6+iu5AjEmnwTj60nXm1M3xuHcvnlit/6dv06MXzQE9dYxz1taLGkoh/3LVNO7x+kxCvqkmYE6kTiKGxEpTff+/C2hKKgwPRghRPr6OUrnf+WHyF2Jcjtw2oJDD4dhTSXbKkTfCFlAxhCxha8EhiRQHi+8GE0YvmN8Su1nUcf+vq9iIbBQQiMpQDbq/jFUqmSGcEmDf7Krf6l11v/WJWtl9tY3wsBLxakaZ3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLVKqvyKSLew9clmcq+l6y6ciZh541wJ6UPFJLZVrPk=;
 b=WwBRsIsJjvbzwCPIVVfISir0ThDj64qbfoLD0jmuVo4xRi3FjBuQjLuiUuqBF0VDD0PLkhRBkvgrn52/2AMLS4WqtH0nDMFImPIzBI82CTlZW/7e6PKFuN+6+UqSoB0pAlIJqRzQB2ngWDJJBuC1LtL0QCbIcAWxthRk61uAoYwDyZDep3wcxVYY+boQZw1V8xmHGs7RSnsnhz4mrp7BcMAxnYA3PkHSb9cEpEJmkQbmKNDeLwLklwWDluD9qyEnqKOJNilJbWgkfSPQh3EAyfc+HsYWh3e12msGNlueB1qP49AYPNbqcIs6fCcAI2hioPRWv0P6prWATG1BZHHIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLVKqvyKSLew9clmcq+l6y6ciZh541wJ6UPFJLZVrPk=;
 b=iQNdSz6V8D71mjaZKIYW70mUFqggkKtMLTznyTnnaZW1n7ITo56j1ecylXsfgeqQJbUG7vgZbRQvWjh5dgxKhyPxmqhCvVlgSJx3HxGt+4NAwDqhb/xmGwi7Ru03zNxwC3F8DoE4CNa7Fnk59wEj8vUYjbTAs7aVxeqfrqEkjGqSa9urNeAqGxFP6W8zP1c2K4DZmUSNqSqjnzb//rUA01ubmB5gpLSp6ylZ7hITV4YsYjeQe+DJe0WZMiETZlwDuFKx7zUf0jfrVIOxO9mVTNJXNAtHMSNmq6HyUUuumv2vkgMiuDmFSeGSrkJd7djw7I0+l7V+J/cKrgMEAI7NTg==
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 01:30:59 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::2a) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 01:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 01:30:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 17:30:44 -0800
Received: from [10.19.163.138] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 17:30:41 -0800
Message-ID: <295e2902-9036-46c9-a110-bf5bf27ed473@nvidia.com>
Date: Wed, 5 Mar 2025 09:30:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: avoid allocating labels_ext in
 ovs_ct_set_labels
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	<dev@openvswitch.org>, <ovs-dev@openvswitch.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar
	<pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole
	<aconole@redhat.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Florian Westphal <fw@strlen.de>
References: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <b7c05496f8ead33582eb561b55d3e2fcf25bcf36.1741108507.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ef5fca-0421-4e27-de4b-08dd5b856221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0N0Z0VsMENDcFJQeW1QRDhjaVg5cUozeHhlT3ExRUpiV1VsVXI2RjZQMHJK?=
 =?utf-8?B?SFBTamV0TzdsbzVidU1NREZoRUNhcng1QmxOTGYzNWJyNnBnSm9ITi8yLzVU?=
 =?utf-8?B?WExLMHZ5Yzh2bFIrQW56d3hCaGZacldrTjN0M1JsTlV2RW5DSS81aU5LbGVU?=
 =?utf-8?B?U1Z0alFDZTFwTmVhc3RGMmtUS2tVbWxsZUEzNTJwN1dHOTk1bk01L0FtZjNU?=
 =?utf-8?B?eEkvdmgxWXJzREdtWDFwRWtKRk9lR1dPUHY2ejliaDBzVWFtUTF6UFRrTVlX?=
 =?utf-8?B?TUNyQnYzQ1hINU1vS1V6a3dhMUFGTXU0SitYcVlYeVlWSVR4VHIxSElBclZH?=
 =?utf-8?B?TENhUkRZQjJkSjlmbXM3czdrditaeFNyQVVuSVdXSFVRVVRCM2MyRDArMmNV?=
 =?utf-8?B?QitoblppMjV2UStlWUdHTmZJek1uODg3cEltck0wN2FaWXl3OE44aXMvWHdX?=
 =?utf-8?B?YWdXSUo4Zjd3WTlFZmgvUVlxNFBjdVhjcTdCS1dsRkp3UEJSNFkxWjlGR05R?=
 =?utf-8?B?Sll1NmVQZVorZDI3NEJwTG12YndUdFJhOW5xbHNhdTlGdHh2MXBXbG9QTUN3?=
 =?utf-8?B?NUtQUTI3STd0NG1sNUdQVzVwM1AyaHFmMjdoM2dmblRJZ3RPYzRUeUxObmw4?=
 =?utf-8?B?WGlWdlBzMzcxWXVZaWVLUTZPN3QrZVlLY3dkZTZkMng3VzdqUmVoa0dXRE1N?=
 =?utf-8?B?cE1LcGsvVnVUMk9oL0hHYWYyT0w2RkpJU1cremNwU20rMzRnWjMxMjFrY3Jh?=
 =?utf-8?B?VHk5VTNPZk1kUmVEUGJJQ042SjlMZHArcDRtSzYwbkRMOGJJVHRNMTZQbnRY?=
 =?utf-8?B?MlJNdDNDYjZzazBaeXYrNTdGS3kwMTVBSGRhSnduL2pPelp0a0xDcTV1cU5O?=
 =?utf-8?B?MlFBYkdYbVQyaTdUTTV0S2xvZWR3REJYZU9Xakg1dkdVdFJjTTB5TllZU21j?=
 =?utf-8?B?OHJYQzV2WGlYaCt6Y0h2WTZXU3V2alZiYzJmZDkrRU1zY1BMMW1uUEppS1Np?=
 =?utf-8?B?M1k5WHg5NmJZcm0xN3ZoUlRiUG1EMnBaUk44L1ROalhCVXBCa3NQUUpkMXQz?=
 =?utf-8?B?dFdoam5FY0Jrdzc5bWs4RXhFbUp0TE9rUXA5c0dKRnhvQXNFOUpsL0lxOVZy?=
 =?utf-8?B?eVkxZ29BRmZLSHhtalZhV2lEVU9CUHRJVjlzYjJHYkdhdG42SHJ2SE5sYlJY?=
 =?utf-8?B?NmZ0ME5CR1N6RFkwYlppaENkS2RpdU4yWFJHbHR1QmIzRVRWVGFzT0llVjN1?=
 =?utf-8?B?akhkYXhhcFFadXV0T2ppTE80MXhFYVQ5QUdIT2tFK2Q4Sld2NjllWENocE5E?=
 =?utf-8?B?THVYekVGaHRveU1NdHozaHBzV2RFTjNXNHhwVk1VTUh0SnU3M0pHWkRtcytQ?=
 =?utf-8?B?cnRobEFQVjZLQTVZSkZySFExdTYzMlhIRnhMZHFSTFZ6OTRpTEt3c1JjU0lK?=
 =?utf-8?B?UlZMOGs2RVR3V1lZRTVKamxabU1xTHZHa283bTl3V3BqVnliZWw0eWJ5T3FX?=
 =?utf-8?B?UUkxNkdqMkpLaEdjWXZzN3JLSlpPdnpxeGlHUHc3KzFQbkEvMk5CN1IrWkZx?=
 =?utf-8?B?a0JkRHRVNkthNjN0V2F6Q0wvYkNjWWFwbjI4YkR5bFRQV3ZLQ29JU3FHREc1?=
 =?utf-8?B?WklTV3R6Q1Uvb2hHSmdDclNLd2V4QU1PVFU1eU9VV0tTTitrOEJleVJ1MDlj?=
 =?utf-8?B?dmZvcHFsWFRxcmdKenZFSUNOQ3BCWHYyNjgwbWtpanJWK1g2ZmZsSDYrU3Yy?=
 =?utf-8?B?QWx0TmJNTFNGZnN6QWhCRGdWTks5bFNUME5ZRUNTRVFoQThqbEx1aHhFL1lx?=
 =?utf-8?B?WmhZZmE2cWx4TWpOOWsrVHRtalc5K2JiV2RFWHZYT0hZSnN4cUhiMGZZZXRB?=
 =?utf-8?B?eHQ0UGxDV0hqU3d6M0tBbGt1bGFPUlZoTXF6cy9kWGNCT0hMNno5SnZtM0tL?=
 =?utf-8?B?T0R0VnIvVHdBaXFqVHBTMXYvYzJua21uSDlNd1oyQWlsVUpDU25NdElTTmk0?=
 =?utf-8?Q?C/yrui/EOUdgHM9MCqi5Z3N5fjLuuA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 01:30:58.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ef5fca-0421-4e27-de4b-08dd5b856221
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104



On 3/5/2025 1:15 AM, Xin Long wrote:
> Currently, ovs_ct_set_labels() is only called for *confirmed* conntrack
> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> does not have the labels_ext extension, attempting to allocate it in
> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> nf_ct_ext_add():
> 
>    WARN_ON(nf_ct_is_confirmed(ct));
> 
> This happens when the conntrack entry is created externally before OVS
> increases net->ct.labels_used. The issue has become more likely since
> commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
> in conntrack"), which switched to per-action label counting.
> 
> To prevent this warning, this patch modifies ovs_ct_set_labels() to
> call nf_ct_labels_find() instead of ovs_ct_get_conn_labels() where
> it allocates the labels_ext if it does not exist, aligning its
> behavior with tcf_ct_act_set_labels().
> 
> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
> Reported-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>   net/openvswitch/conntrack.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 3bb4810234aa..f13fbab4c942 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct, struct sw_flow_key *key,
>   	struct nf_conn_labels *cl;
>   	int err;
>   
> -	cl = ovs_ct_get_conn_labels(ct);
> +	cl = nf_ct_labels_find(ct);

I don't think it's correct fix. The label is not added and packets can't 
pass the next rule to match ct_label.

I tested it and used the configuration posted before, ping can't work.

>   	if (!cl)
>   		return -ENOSPC;
>   


