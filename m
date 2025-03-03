Return-Path: <netdev+bounces-171161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A822FA4BB5E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE861894AAD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C111F30B3;
	Mon,  3 Mar 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8aCmz4d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF551F193D
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995686; cv=fail; b=cDvA5tKsorNwrAAkisLyNBZUcmXk/z7xVMTo3NsmXrPnAB43DgbxoRTwG82KXsUzRDkZu4Cg7T41XN/v1sIjqreWzFx8OkGuxu/2ACVjotE8cpAOxEtanP/q6xPLaLItBA1s9DZxv5ir937KSN5aM69+PoiXrBDbAAnjiOZ/hSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995686; c=relaxed/simple;
	bh=LP/W991KwvVjZxLNerbhUQxJuxSIJzhoG82UwwstnYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxugA9efSpRVWmJfg7zHQX9VwR1Jj2p/ZnuNJL8R9/uV6ZiT3P15uhtUS2xnVmrtu0aqh/jqR2RqqFf6mN6y80IuUeTOjDJL3umqVuYR6FyQwxIcXFUwIpqH36dx4jAN6cc767NthPNVW3kC1N4vHA27jrYoKk3MgoAOX2YVc4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8aCmz4d; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSvei+UQj6EFe5ox01Xfrfaq9ncJ7Hf56RAKY5orMWQFfVZ89D9uFCocmprXDOwVcoKmYcp3adb9lX332FWwR8cwtJ5Z1CMXyLEEqvoA+622PRx2kLAPI9pw97LpOZZkXWqAs2at09xlr/EMduGMUzQA1EN1RVWWZma4jCP5CyQb7K9ljfxAqzI+EkSLKdJrTt9gXZNRQ0UDxluwzUVKyGq8Uar/4Old5A2TmTCKAOVwMdpYKhGtLqycsJc82+fMA9e/r5lED0ddC6v0wK7tE5sZpBxQATqTCWS5cu0ktHfGBJSPIhyOPtriWbGnLMZ/XpElRUyyezxXCpv5wqtkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=vWQS+7I76bHrZIgJZ/BzdUdF5Em5rFl9QwZSKEP6JKAZK3XsNwHNXefSW7RYEH3XCgIwT535WDVa/VbfiKHNYHJCwSVhtgKVLRNtEUbKPqTk8/HJfpKaAQujrMPHtK5TWf1fwTLOcWeDNPuQ6pg3CytJiu85Bh6BZfZL57vJ5bCqNvEc/UK5eX7lQjl68K314Grpqf/uk3rtYpGFTNLqPYLAwCnDePA6m0qO/zxdaJ7QcqaaNedu+yMMKqK18lKLceE/WjLbnFyXbnqXKmSRhDyfiJgabLo8rM0WGSx8WRwvKn18APYHDf5uOb2gA36RM+nLTXI1Iys4ACwluI/33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rCKYRRRrJMNZWsE2RAfL87JWgvboe1iLyEwaottWMs=;
 b=i8aCmz4dXr6mXKYWGzS7wiDauAJ9G0kE0mtN+6kWqh93tR17HYzXIi2BJPo8TiNt0T21yUm7YFX3bazz0dmR/GdHpbe0ULEdSku5zOAwgKl2x/Nr+I7S/aqmG49WxfXdsVkdaJaQHTXSqdW2oj/SEGos6ooBcqtPeam4H7Le41Xp8YWRbNs1RdRwUbO9NhYQkTxqoPhm0L6ArnhlSKHIRkdFrb9FJBO+6dbycQHQ9ASU17/ZQVj4qOneYXvh5FZD5K3iU0A7FsVTx7GJtAXMeyKd9HHn2EAVHi8/DfgqEQ7HsWZ6bjnGCuxj1GM1a5ilElb5CQmUXV/z0Janose/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:41 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:41 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH v27 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Mon,  3 Mar 2025 09:53:01 +0000
Message-Id: <20250303095304.1534-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5fb7f2-4751-4aa1-058b-08dd5a396ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jVs2fbOsXl66cxBo7tVwQ0/ADMqbl8pEcFku9Q78LxxxKxmRetWMnlIJwSeZ?=
 =?us-ascii?Q?/RfUW8kCjP1goKuVe6KepGBK3wKPh/IdnYmdwLb+tiIBpus4kQvPEV0PrliV?=
 =?us-ascii?Q?UjciajAV689SIPFWOLzn2tQqWoDK+D7nA32Vz7tT5crMpcSeFE7RFXHvl/p2?=
 =?us-ascii?Q?B7fQfZk7MYHjNOsun7S9Uy98g50fZ22f4YAsu+eDaAzA0dpPvpdlzORZWf0F?=
 =?us-ascii?Q?lvQIJ5g5JcEO2p9GnIOiuGN/XBk8w1ArY08jcrLwXAkChONLe0/DubKQaceZ?=
 =?us-ascii?Q?yN/1ZupcQlWnilL0OQzg6dujJQ8XMf3NCZFgoz8CaJx9tCOEALY1QYZXLWsl?=
 =?us-ascii?Q?uyXEno3OLCpEUHFhX6obzhuPH8zPN0ZDcy7hEbK6+hy8aP45iPohByQ20yGv?=
 =?us-ascii?Q?g1qjpz4qf1vcFzCRA7JKMN+Kx+WunBMdK9BZjEg9JTo+fACq6dSHCT7/wOAv?=
 =?us-ascii?Q?ZItQO8xd+NeO96HEsDO2ikdcgaxIQYn5I1NxieokrHGgo/Sk1A5ZbJzG0vp9?=
 =?us-ascii?Q?T5uYLNTKAIABsdLM2d4EomKC5vVRvutxQkgGlae/Bff0HrfPQEZR8C0DdFhv?=
 =?us-ascii?Q?lJnzaJbiaGC3Ltf8T9OVcLhXAdJhZTlVFah3JnffyqkC8d1vjTE29tojECvE?=
 =?us-ascii?Q?B0hXliEXRAXb5Df4+4+YH8tEfC0rRuTxcNG5UrMs4wFqqsc4p8f++ljtisNq?=
 =?us-ascii?Q?iECM2bOAmbPGPEIEi5soC1iJviCSHpXUVoyeZdnEhXB1ogwtzeQAZdeCWQyf?=
 =?us-ascii?Q?kk7odzam3f7BywHp75ZODqxC+N210+lRakLRLDIED2dwAIOHWE7+deilhEik?=
 =?us-ascii?Q?LXmv5gYxMDMKX6JRgw1oE9IcnXAoSPOS7mi98PhWrMCRUkM3x12YTMtCNiZJ?=
 =?us-ascii?Q?qleNA/7s2xvGgLUUo3M9EGsescxEHUXQre+w+jw7orG1QittM7F6RGMkmYtK?=
 =?us-ascii?Q?Y3izVHcuhf3umhRpAencYyV+VmcdGaS+K7HjPMXhXRPA1KtodcFTt8XiyWvM?=
 =?us-ascii?Q?1XcWbzlQCIqLHUvGwAqmGp1IeMmFojw3yFyzeyJD6hxJKlSUtUip3hQb5qQ7?=
 =?us-ascii?Q?GwakvnZw0XpRfzCet01jRl2kwe9SsTouYAt3+2p12L5Z19IWebCOpaCSmJut?=
 =?us-ascii?Q?R4CXaYZWhW4ipK+qHrxWNxpPB/6pmjXHUwehk2wcbvWWLwUQaYQoTKpANmAD?=
 =?us-ascii?Q?jVzXs/1OeY7lUQOkf1ZV8f8nz/8T9bfTV0Bav2BdCVhUbV8cnCGa2NwjQQxF?=
 =?us-ascii?Q?nRbUuOgeDGUSuNUvIg7XUhrccKc4DiR5+9yWV/IqtJD3bg/D/sHKq0HxL//P?=
 =?us-ascii?Q?J2KhTtebLHoRtZhft2o5urhg6o+L2TQkPpYw3JETuXFRWWBs0fGMl0AZlLgK?=
 =?us-ascii?Q?CCda9ANIRwUnWa3dMspE+VU5PIeo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLArUguLDdP8hHanNMSQJeRwWiyDwYp8iwHHkSzzWEWHXLar38HlkNoDGBro?=
 =?us-ascii?Q?8bV9QG2gWnD0lpIitKicgwDHvcERoqoTfyn7O4SeyPmMCiVSwqdFWPLmwfmL?=
 =?us-ascii?Q?ecaIJ2T9NS50p2Z2XMl0hOmozFBd3q7pljE59xQG0HIzx0kYQCNEBfNwMYs6?=
 =?us-ascii?Q?ErUf7qC6zxmHLfnesYAXMYKOF/Af+SfwamDpk37nX2s/hrKG3nq2ystE2fCG?=
 =?us-ascii?Q?TplxwhkhFDFgetPX4gz4d0Z/T9tKvj7ucaURF1dkWFcurayiT0TbrJP/zHPO?=
 =?us-ascii?Q?w3tfb5R0oqP8rDoZonpSgaADT/DE5qaI6mZEkWw8KVVgcd7jfWDZNmFjr6af?=
 =?us-ascii?Q?Xvr/8suEPkCM5lTTdTtkln7XsJI2fdrY6gy9lLLqNO41Fk6/exVcJjzlOzGZ?=
 =?us-ascii?Q?H60v2Hwtgg8r2Tn2/vb+llUw2cSFb8770+fXNHpm/Qz3eF9otJZiswdBp3xc?=
 =?us-ascii?Q?vTgcWzmytxaxC7XCiTt0TrKOn0FJ+eBAplILO1grXJs747PlgPPX//xx49Rv?=
 =?us-ascii?Q?ikQWWudwob9I0E9xD7K9CFXUWjdjtPkxwrw1gTRkchR1xAeZ2+PorM5UxCJs?=
 =?us-ascii?Q?fyZDrDSkxnV63hrLROAgz7JOzxbbqkBhccTph/j1DZKt43S6bE75x1GrQ+tX?=
 =?us-ascii?Q?fEYCI3x3dp8ZPYDFU7Wkf/HVHG5Is2viaigm10s01TuYHfEs2M+QfB4w13Pc?=
 =?us-ascii?Q?yzqHHKWwAWDfEZpwTipGZ4Gac4ssK7Jws/CCqenDl34bs2QADU4CBYZudAhp?=
 =?us-ascii?Q?g1XuEnduz3ow3Rfg+JLL0N7g5E6Gg92ZJ2dnx3pucTEixVaxuBOcp/ZeN9bG?=
 =?us-ascii?Q?9w8TKVlKFVK8xrUokQt17yCWJoXESS98WlfNNE2XyHkat4CByNDzK0RUavbj?=
 =?us-ascii?Q?hQpdh2T8nQsz1F6pMyZ3sgs+mIinYosKUX5kxhMcpSEGJGLQpyrAm3HiGKmR?=
 =?us-ascii?Q?LAc6Xb8i+Y/iNDuUKE5/Wr6M0uOwSMmLF94DBTwLiy2VyLL1I32UKb2D8VU9?=
 =?us-ascii?Q?0nhkhK6LtLCkyLUGsvtMYzxSl+teNTKaIHBamb8RcYAj62KdwU+G8KEeoHxn?=
 =?us-ascii?Q?4OVmN/16LIQHUvZOIqeUgEL8p+CxL9u482WE4lX2oE9Fidedrnovk3/JAS/t?=
 =?us-ascii?Q?+UaffTM4IuB8gRP0UL6KAT7Tn06DYj3k/XfCr/Aj0UD8bVSJsodK/W7MoXp4?=
 =?us-ascii?Q?LI1hpuceWRkzpkBmWUfNJXK2wt4eGz3oUFvpzlv9VQN0PRrEoers4whH+Yry?=
 =?us-ascii?Q?SZQWYZn8FtCEhe2ocDYga2/n6sf/Ws1c29S6IXVGQA73tg6QoGX72LQxUlrJ?=
 =?us-ascii?Q?qKMhl305HA6534r9UyJosuTc2hCxQAR8aXCnLXggVn5BS02bFDgl3JTPfL31?=
 =?us-ascii?Q?Fd+bTNlOaOSWL/XUZJqqLXX0s2uYWw/BXJqzDKsqHoZlAXlxLM5JzJU/hdTS?=
 =?us-ascii?Q?B0cN0GSo48y3nhid0T3Y2VyVd9QjOpiaZEQT2MEUqYpfm28vKAF6Mv40c/Ej?=
 =?us-ascii?Q?Q+RgvUh9zQ+2F+LBzke9zjyEzT4xODfqsXeEnBQIH0YEkGY+KSRI41nKDxoI?=
 =?us-ascii?Q?x8c3nTIIi2gRHLGuUQ3yoLHJ39zD816GLvIYDBEj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5fb7f2-4751-4aa1-058b-08dd5a396ae0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:41.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6dAh0y9Q6/1b347It0zi4NiiIhifYiQW+fdWLlp/6uDQj3JQF6vLREgNRcOXFe0tolfpmZE5NQmEWpAnSn+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 146 +++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 479a2cd03b42..9b107a87789d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -684,19 +684,156 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (count <= 0)
+		return -EINVAL;
 
-	/* Placeholder - map_sg and initializing the count */
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -719,6 +856,11 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


