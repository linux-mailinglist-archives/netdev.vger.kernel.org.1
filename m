Return-Path: <netdev+bounces-168453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF0A3F10D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76052423BFA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47320485F;
	Fri, 21 Feb 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LfGxYQQ1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C22046B7
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131645; cv=fail; b=WFbM0AZ2O4Qr+PlH4DdKtKnVidOKqHOHJAWwGzrTIyhqatDh1leYiLnFz27732vunr63GYogz9Uo9jqfQZsgHxifscmzIonDvaPhdgeplSoCZjJAyyAzEs6d97BdXVj3vqOkVMCyIQWZWIbunDHXHN1oVS3GPtJR84pJKg5xGKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131645; c=relaxed/simple;
	bh=NV1LcYHNvbllkGTYHUd3MVqfHC9jTigOmAudTq+C4Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKaON00vylPPn3nHpnVGyT5ZjnID9r4LRpEIc/fNnpItvMtsC4CgXmOLiydTK71RLuHZ90jTdl0Ws0L++9CyNIzGuPQEmP0sPpRHy8oFuBvJnxj5JK7rd/mQsYYnzTbqocQhyqR3Wu45DwtlkTlyQxZnfiM/c6qCCl1SZOb4tu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LfGxYQQ1; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX90KBSu7BnmV0KzKlVPBbLcxh8hzPs6GkIDT3tfURoGl3a7U4KOeKpyoBTkr2H2rNoGDXTjrUKdr4kPsgMHZx3lhcKQHvysGrbLypsDF7gwu1ErZ5kj1ye4zGHgJUo0ki9LXF3g03N5U6paqu75ymVTg7u5vFQTuXJaOZKDBmZ4u13VTBKBQEJfZUGZq1WAgnOeA5WJBCPQBLdQmmLMDKnGgdL8mYOG3YnUC38w1wBHIRTKfCSxHeh9x/ZLDhgAZptm06s/4mh2AWLoUxmgB30SwI0DKS5vObgjA+2I1Zihx8aBu9L9CC2Sxn3vgUWwFwgM3b7e3AvEN33KIU4Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XJIPUiCnTJhLqXwdKt2xcO7RJyvr97kGyVQSLEVIDQ=;
 b=YNgdWMoCM8GbHgwYDJgbsQ36U5JviVdjg7XZnIuy3fQyq5/l6+ICUcb0oJlMhZG8wEDAuH2F/tp/k0/9Y9Ch6x+uTsiV5exkmgEepJSbVmX76iY3LYxoXyNSUTtzwCglL5+BYhqp6NaR8Q1N/cnTTI8zQMS4P6zj4jzgtyFIX1iNdlgMEcf9R9GjavBybgRf/b66uexdGe09cAgS+3GEG6pSsEN/ZXp6aHmUyptvFhFkBlndSml2b5YNAB3J8MiN3+3+Tg2pNjEM1tMeNPn9+x/KH96Kn65unCXMQtnYznkGDRVps4yvrwE65nk+sjKFuUMoE0BgdrLOZCBdaHMwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XJIPUiCnTJhLqXwdKt2xcO7RJyvr97kGyVQSLEVIDQ=;
 b=LfGxYQQ1AhJZ3Ie/z3YyqttoWHirP39cVezjGgFj2tx/LDveyc/7PsssFB52cMnE3Qn5k8DkTYQSrWOxZCdF9PLiQEgS43vaEpg68DAciDuPWFcf16mLwLCIY/NHBtrYSljhhdx7U/1BfWy6hBUI0Q3IZiQUTCf0LDVdBRpVGwQWrjjC7KAVLatLXMxShm27l0wtjp++XrUPI4LrcNad9d4MEwZj7/TPzMr2AbYtwhlsXxgm5Xm++eJyW7WroSl+YVZUnBCNKZUzcW36oSYD/fpJAXfuOQe52qPsRp+Px4Y9Q2LrIi4rPLNo3JHlSiUBpLUp1iPUN/Yvn1dIxZAbCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:54:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:54:00 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Fri, 21 Feb 2025 09:52:20 +0000
Message-Id: <20250221095225.2159-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: fc95448a-3f31-4da9-cc23-08dd525daace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyPT7ZIuMt+ln2y+e7ld+WybLOzAP4OJQfP2mdCZQEOJZLxWi+WbABCImvJB?=
 =?us-ascii?Q?qxgMOOSdCiV6/F/lzrOJTans48xKdNsZYwzSN36KkvFaRxx5gi/GxZcW7E7T?=
 =?us-ascii?Q?U/ArfB5r4GYEnE2S5RyZE/Llu+T2lLrny1TDbXFZtrpjRlfWtzTavDEJMUjp?=
 =?us-ascii?Q?5ugV02OHBI+1cMbWKeuaLclFcbbYXrlwaY9ZGQoke9MsPVvDqmIk/0d6YP0p?=
 =?us-ascii?Q?u56nvh24QLbOJQ1WxD1JgT5mzlyvWJ8Pw7kB4Dd11s1HCh3KteqPdqzL+evH?=
 =?us-ascii?Q?OSwFIGuaBPyBAojmWn+d2/j/WxEAe8AeVxr+WdmSI3RtxPAZ6wq2V/lMXH2I?=
 =?us-ascii?Q?8Iddwg5HAXPPdvyhPOGGg15JPtCFjNViiCZdT/4Rx3gAetJkNPzmykKCIWVL?=
 =?us-ascii?Q?B5tyL0bTctOC4HrshcWyAKj8ihe6WUwWb/8gdTWe91Ztr0ywlhJNWwv9Tbo/?=
 =?us-ascii?Q?yehUq4e08bEd3LFX9itKNJjpFbmQusyzqEs7Bsa/UNVrcTRJcAfpSSGRNtxn?=
 =?us-ascii?Q?dqVhCh/FeQqHZSM3/6Bb+HgIVDNFcwI9SyHpmKT09TaqRCsGgP4RyB5tIWDa?=
 =?us-ascii?Q?1TH4JtgiL/UW6/U9TFiqXcmb/7CI1u3IB8ouNGSighSiiBlLQhP8woTa9P98?=
 =?us-ascii?Q?uveWu9czm3cvVbKp0UcuUgoPh/c98m6Oa4Xs81SBUQEPJ62EDMJQZsLbqTCG?=
 =?us-ascii?Q?A1hU/eHQlLulcXTzvo3Ud5/s0MBKziNRBdoy8gsRdlSVET2DmPuoH5pQ5ATh?=
 =?us-ascii?Q?rZIpPruurR2QVHLnR3i/qX/JWlzARMUxXXAbHMnnAUdQ/b5RpqTGKbh0EQVc?=
 =?us-ascii?Q?AOZzc/W35hj5gcKXJo7DWuC0LqJZrFKrdjtfBoYo+KKZ48KHdvbyF5d9wkSZ?=
 =?us-ascii?Q?JTfLmW6leikgxTmDWZO4YyznMDzz0Bvt3cnjPcQVBP+4rB5AUBVi06gB7CfX?=
 =?us-ascii?Q?o7+TtSuBjPQ790ucDs9S4aSnwCANqlkgE4L61U3ct2MlDMn3/Q/Xpi25Bet6?=
 =?us-ascii?Q?bAEEJgoZbOEJ2Hu/BS2JJlqGa46GDDNWi9q4/SJ2zYDH7bM+eWJ5oAXnfSsx?=
 =?us-ascii?Q?6M0uijFw/edu9zY3/7z7s/pIpN8+Sxxt5YC/tYKiB1KzRpQkrqzzAFgbAyOc?=
 =?us-ascii?Q?Ly9AgfxpJL538dikSixj6qT24fX3XsRF1EjyI1S6D9Ukdl3IWbXucrZrNw+l?=
 =?us-ascii?Q?7PX5hm2Z5k5l6J4OQMljJ6BMt1Aplb3A58LSPfhWcALr4kY4TK/JRd+bh3Fy?=
 =?us-ascii?Q?wKvjqsxq4AibhKZBApYvTWDwXVu8TLN0BcMKrhj/r81sJJL5yP/jekfLLX20?=
 =?us-ascii?Q?1vEv/u61sEhrT/ULj0Df00LjOVAFaARPiIJ0oERM1I+K5NsBPjpGLlVGaE8a?=
 =?us-ascii?Q?UvHPMhTFqhTOtZDoYYVo0WXlfBQq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2WF7Nqtt0DWWtcHey2gek4d4SoUU/+0F//lumeXIqXkQCBLcN5P0x6ly2Fa?=
 =?us-ascii?Q?oRiL4Gnau0WRb0ETrt9WIF+j6AmLeu8xGVIm/3RpjXKxDJy0FVcNXDpzZdvz?=
 =?us-ascii?Q?S7vOJeClSzw4M1ICjyEcM3eKr54QZoRylXxrcWf5IBaYSVNQa9qhJiJA7BuM?=
 =?us-ascii?Q?04r5Y8oZH+R4P6YLxxVn7kOfV0EBKkAz+YfNqY7GSl3R9tF96WTbcn7B/q9k?=
 =?us-ascii?Q?OjuPGCWk+I/C/Iw1Te75BnybUvGaPDI1l1qrg8cnwMnvZtwI9dLtXSWqdosw?=
 =?us-ascii?Q?3Ma/DnmXIvRtjc+CAD2/hk/4Kl6fiDlHH3KR20Qe0/XxDwLuKwzAES5mGKH4?=
 =?us-ascii?Q?13X/sBQ3d49tZQnOe5z7IAXVWh83ovBPsCWVEylYSDb5zNgWBgufI/OyaPaD?=
 =?us-ascii?Q?J/8+fm+VtJq++OVPw0DPXgUsa51Oj8rt9h2EXheKBNOoeJvuCTO3oPvhfOMn?=
 =?us-ascii?Q?BS69BC0nzIbQYfYVRV1lZ5QY94JqThbp8WJtVKGDEBeEVwWoqJ+mx0RIiIvC?=
 =?us-ascii?Q?P38mWPlUsIpwk5XBpYfwKKk/Y8uB77n1nl7EB8pSNqzhmEQfEojYbO+rbDfr?=
 =?us-ascii?Q?knramctZjbDQtgRfu2b3qo90DohxFAwTb9k639PnFe5JTgwl67rG7AG8txMU?=
 =?us-ascii?Q?SzHSpGhmINd6ohaP64iKsRTYpY3/dtklK05U6zhzC6zDFCwTOhT1jd8GUimU?=
 =?us-ascii?Q?y2eHbu6NWQFOx848Ru3YRWxOXoCNhTBFTllwN01/CCTlCpx6T7d1LqPM4ePt?=
 =?us-ascii?Q?kHR4MldFLSZVpYkZUCZPKHm3G6c/2TgzaPghuLZq0uh3e29NRO3eLa4P7VuO?=
 =?us-ascii?Q?vh/zIA6A0cTQLCUF1gTW30xsNEnlbn3CMXpJ6ATsytE/M37wTMccefQ8Gs3H?=
 =?us-ascii?Q?PSVC0IbYN1wIlQiDOKFA+h8NTeU3rlo6jv80K9Goh+OHr4e36Qoqvu5kzpiC?=
 =?us-ascii?Q?eBxv6EyhVDM0ntGQbyK2GNzwLtWVn5vaRa3fCFWV9BeJnZNOclmUoGj8IzJd?=
 =?us-ascii?Q?iXWIR4hoStSoPkGl9DYjQfTcqlnvI/UKTir9RTXhNut/oCEJ/FEWW12FCecL?=
 =?us-ascii?Q?/qqxKdAq/p4kXraeaATZZX+clyf4HP7aqLRNm7sYTDaQyyjjIGD1Y7qglzCt?=
 =?us-ascii?Q?hkwUtUU1UvOFqdnp2tZ/g1p3rl/la26HXpc2Nyc8ePjMu8o5P5rWnB455lr3?=
 =?us-ascii?Q?PF7zrNXChgn+nYsTjL/FIhoSmAa5kKBSJM4yZj6NnuA3+YSFMFxDniP8Jmi4?=
 =?us-ascii?Q?4Vt5acYqS+hwq/pRcBhsUe/8f+H6Y7eXbsd7N2jRyXeXxwnBBUMz50OGVxRC?=
 =?us-ascii?Q?vjqVA1X2wKLOGqFWMxNYCIjWgGSfTLlJpQ/z/xFowR1G/RqxyHgKzGHrx7k3?=
 =?us-ascii?Q?KFyLDl/bhzNUaIFQ42BqQk9mWF9u+X6uXrgUpxlbU5F13fG/l1/18jwiG0lA?=
 =?us-ascii?Q?8KnaiPMOH88JVKQBGpBlUp7p4loexabsotU/JFf8ZdNFrHdkNIL0DxZW6MoP?=
 =?us-ascii?Q?fy2a3u+jlrQ4serKPQZowEBf6JS8tcRdzTrd8WX/6s52cJ0/cogmId+w7ZFH?=
 =?us-ascii?Q?RqVUSyAutUFPZxeJvqc5HdkKcqXFT/YyQcr8cJyL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95448a-3f31-4da9-cc23-08dd525daace
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:54:00.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWM3QPnMXmteIsgUeIPNVY1UyUY+10F5a+7ccx2rhhCKPQT+deJoTj+CFS/Gy6cG/Sn8XGz2kqR5H8VFXhmYoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  19 +++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 5 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 493238d2e8e0..b24209ce65a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -146,6 +146,25 @@ struct page_pool;
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
 
+#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) + \
+	 (sizeof(struct mlx5_klm) * (sgl_len)))
+
+#define MLX5E_KLM_UMR_WQEBBS(klm_entries) \
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KLM_UMR_DS_CNT(klm_entries)\
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_DS))
+
+#define MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
+
+#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
+	ALIGN_DOWN(MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size), MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT)
+
+#define MLX5E_MAX_KLM_PER_WQE(mdev) \
+	MLX5E_KLM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * mlx5e_get_max_sq_aligned_wqebbs(mdev))
+
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index e710053f41fc..1453195587c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -71,6 +71,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -277,10 +280,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -294,6 +297,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9965757873f9..c36bcc230455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 6512ab90b800..8dda0eee0ab9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1056,6 +1056,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


