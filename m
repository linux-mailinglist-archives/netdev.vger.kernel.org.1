Return-Path: <netdev+bounces-78139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49F87436A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA091F2658B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D71C68D;
	Wed,  6 Mar 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WA0zcjMC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C21C2A8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766293; cv=fail; b=lPg8044dC6xlP4eCy/ddXtuq5OKO2+Sdh17Cq9hHhveBieJeukmjRb4rTTTTxEGUbFMJ6XMNYp4OCf7EN++LENHSn1tFnTw5QXC6opMnlvNVmBs2BpjcnomTekco6pn5lE9uI0IBod7GIfWxRZdN0Fq/NeBFtrqaE8Zyqv4qC+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766293; c=relaxed/simple;
	bh=ryNbGUpeKEGDgqH+27ouvJ5e8YWd1Xt+Lkdv6kPFV5c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EXilpx29EPTMrguMfd3DdBCmSDfStOQHQY2mqx7vjLn8Q5sIa+Xa059KzrGpntERG/LS60977XOlULjKt2SQ4Gcrknq8KlC4UtZX2WF0q98Yg/UD2ZD6SICUJOduaEAEPc9pB9EzQzatFYtbWFcYgf8cZHN7Bq4rcxtIozDb0Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WA0zcjMC; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5GbjtY/JuUCrM6NNoSp0Kv+Xnl4dSmJQj/KdXJtF8HHNQfQBVC+0D2Hkb6sB9Lj1DCRaaCTxlIuvOCtoM4dRFYnYWyHOTCr1yW6kdI2tO+d5KZAU56ikcaV0pH4b1eeteznFpqoty6wvKL8C+Q7lweMmbRgM6aOaUiPkCsUr8jLzMyj5gNcrKIrcHUa6T/POW+9DP+sx/ZjwC5fF6Ji2MQ+aUUsI2vl5RDw1UNWHI4BK9vmxPI9X52dgBZxm7RPoQwq2SXBOQDZHmjKqqtE8dxBknzCc7Ns56NtqeWHaNeMQCS+sohdNbQcpZkERb94IfxZTgTO9JBUgITx7nQwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np1Gc+PWUgwWUDWbMj2u2C0qvxXjMPdHpeRwwSEjT28=;
 b=k8ehj073f15b6NEbIfiibyY0hnZrkZsd6fLZiJGmfhc+PAvy/bpFBXdSHz415BG6q+MhTOnSmPeuvz/vh0Mf6OXx0SRRO1PyFHmqWmnmTDId5laUv0BDWWhlow1gu9jTd0lL6UC2CHx3NHQyMeUU3+6gVWmr/bCTZQMQHlVLrgFrvMZv2t18t9eBrEg5t/H7Toldhry2zOsedSVLwwtdyO/xWcOXm5geXxmj74Kd4gaEJ5HM2Nhx3VuUlpknhvrb7TXVms8Ajr6X9dn4BMGU7MbARqvNXQQmMR03WKOrJf/g1/hPml43P4mcaMxNKwXItCeAFJYttJJQ3tJePLWDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np1Gc+PWUgwWUDWbMj2u2C0qvxXjMPdHpeRwwSEjT28=;
 b=WA0zcjMCtt55vwnhWtOmaVKxpJc2I3i3c5PxDcpDXZo05Yq+CcP/g3IlxavedOsc0L1I542P+ZKADEWXCCFEH6AfgUSCWv5IC1F9/IRDwc6/J1ZSsJHAEVU1WvBdKm/DyEweznQT0r+jQyw6gF0CWvK98h4SRXd37GYLfwsx9EpU0Lfr1XTsQy9MQ1QuXJXE8nqZioi0+8TLPJTUMD5XcVZFpQD8fFg+efEcLxeIj8NOKafKr+c6iy70a5G/+frAxRooqMdkWhQE2c6CDE7O6vq3/3TzOUCoAarAq7/AsG4EV4QGkZcTLqtz/Fe6dqiSon0shy9jvhw8w3SFHtpCoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:45 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:45 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 0/6] net/mlx5e: Improve ethtool coalesce support and support per-queue configuration
Date: Wed,  6 Mar 2024 15:04:16 -0800
Message-ID: <20240306230439.647123-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 780367e6-8e13-47a4-78dc-08dc3e31d033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wm7bSaBOFn4P6Kj/MZBPpop/lK3XIDOB2nurR6OZHvpLslJ7bBoH87FRUsGHbLjNwgAXHLN9KwjsvmLUpP9XG5hATewYqFAL5xqQVp0N4PZtXA0EtT4sSOBqfgraknc7f0yp0PGVYxgDnxHqiBGdKE3+7O2NVyHjaDB5lSCi2zR/KHz8Y7/Ys8tQyU5DdKhmKKTlQiLVYg3zUojRps5OHrNHi+nWKno73zQiAXSju8BrXcVcw/+Z6s2oQMonkSWVZB6J7xtwboP0WS0HZk63g3RnCXZPI1Tawwjzo2EBWOYYbFt8dXecD6vWV0lnbLy6wyPpcAesmVuntjWiU5wXM/dysVkbKDhR922Lf58Wg1DANzijdybprl3VQAVNpRG9agjnjkdDyNdWpcnrlEnvCZCgeoLSXTEqm/cMP0mJ7BKAGgl9ksuoKU/wYcDusADSGnbbJ4VZhbB/b7rrCIP8JMQrbX8Jd5YibexSt2pME5tTNqtGV2ujgfRXkD8sQ3naDmdtEglk5lB58Oe4sRnSD6ZsnMPWo3Radxk+rWw+bTbPXiTqBMLq9kDuVKq9WTWf9huPpeDDE4kwuhSJSRJ/h7W8PAzq56ClrJDM1cKJTTwOmZF7ZCFVvBtdazrL2CeL9Spo6lidWo0le/xKKOhTC/r0qW5UCDV65tcjw1dUCGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnQpFwo5L2xS/N8TNIylVBFTD1T9zgQ8jrz6X32S88+TgaIp4NTyE0vPz4ZW?=
 =?us-ascii?Q?kfgxpZU036qWSCJxLSIb9VK2lFfSO7a/e9WJmYwI5/4aBmTTrXWVKn76WCFc?=
 =?us-ascii?Q?OuafSM1JULEWGhVASxbpAlaBJudJwgfe+RKZFUZ059BBR//W9aD07p397Wqm?=
 =?us-ascii?Q?fICwyxz/dMMHHzFR8PTdXtKkOQDo/1V8VPH1sXc64FZSVXi4FaSupjlOn/od?=
 =?us-ascii?Q?Bq8ksig4xITp3WjjCj3RzzgL8fD69ZIPDyltcbrfPmu66/7bculvIJkOBpML?=
 =?us-ascii?Q?JWyazrX4sAZFT6H7X2FN0z3+BYZvPj0HXvQsvM6hBulqbo0Ok/xkrPZlLQNI?=
 =?us-ascii?Q?3+sAExgsgRl3gKX7xsveAYdCb6zRYyUkc1QA9I5552ltkm/uUHWJXdj7f7gb?=
 =?us-ascii?Q?Eg34NfzgYnI9s8aPtVNRMOCHtZAss1reDmT68K6Au7JVgH+R6zxQg8DZcjen?=
 =?us-ascii?Q?7Z6E2rcQg0LwhIvgXGyYanVM/7Uy2b98tI8//rSi6gZfCLOnpH/oYJrxHM8A?=
 =?us-ascii?Q?HuoFdejPb/CyhdCiEfuAhmE/Z9eZ2x+iy+O1FRnWkeeiTUTVNjRbHlAV5C8v?=
 =?us-ascii?Q?ojWjOAvddgLf98cFChRPnGOahupM7/Utm4qXRJxjajypxTfEGkZC5uxWt7AI?=
 =?us-ascii?Q?ay1bGqB904lpjpehZL+YYq/cajL6Wl/7FNyZXG04KkxBJ8ZWpQ7TxTrHL7uN?=
 =?us-ascii?Q?0j89il83d+qdv9tZdjCGJyBY6kwueykf8UW62LkgNR3y+lGAF3Jv6dhwR4wv?=
 =?us-ascii?Q?LOPkk6PoGXn/mVktNfS+4OHnnlu5T+mTpgulq7mwynOs5N3ilCtej1xhAdUe?=
 =?us-ascii?Q?06eGWjMKJdVQXHucIJzkGe6qI/eg618W/3AZzIgnRQDudDZxRbmNGDb2OOiA?=
 =?us-ascii?Q?lI2SAUZMa3ve/Tfl0mcpMNzq+oYk1MA92iVlN0YyYESYcY7jLDLiXHtGaint?=
 =?us-ascii?Q?Pisym5RfLGhGYg8j5xO5xOIcWDZoD/6K8CaxhahHo5Fc86yjCFD+HzOxnhL+?=
 =?us-ascii?Q?uwVgEs1KymqWtO1DQjtJL6GkR/Yu1OIb9FsQGIJRNdDdR40DC1qGhTkqpmAo?=
 =?us-ascii?Q?5wCzdErG4K07DVz7fyuuCr3CIyr8KvG9kO2kIVE+QLOEVtesPAWUeN7/zFHR?=
 =?us-ascii?Q?ky9mXvZ7cvGGb3lEmqTCMRciMdF+24DWsMpLximWQPSsFt2pX6KODiNDC/1N?=
 =?us-ascii?Q?UT8Gue46SKBawC/BXfD7BO7CiISJFATJpsMvPJN9YnPyFQZEuuMpVNp2LpzC?=
 =?us-ascii?Q?CcE6VwVSz9MVwlgeE/uSl6ZS4DOQQSXF+FNrnDhFVTEnUxipYQNCHwKfA/QE?=
 =?us-ascii?Q?DfHmKCwWBPEwIfBmi9uRomUe2B2l4bFW8h8wJRlkmCU1HdTuGhcGDCiLThFj?=
 =?us-ascii?Q?0iWqOYvNgGY6a8/XDYg/FszWKfKv4CKFmR4I8J6nAVA3/SlXrCItCUyoPT/w?=
 =?us-ascii?Q?PUK6Qgdg201W+9dweNryRBC3GR4GRGS/SKlV4MI7QiTSnrqGDlFNnWZ+y6sP?=
 =?us-ascii?Q?6plLDLAkLdHqH4AH00WbwcW+XrA/sToAw8ZZa/ZpD0YAF09xjeIUf6DsRCaD?=
 =?us-ascii?Q?jMzQDTTzq4NyEM29tPdjTih8wFALXm7VzNhUh199WjLcMZwHbm/uDug7gP7a?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780367e6-8e13-47a4-78dc-08dc3e31d033
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:44.8592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUUHIk9X/rC1Gjz+Dnlg/JxD6p8UYXwSpMbSw8KmM/C2Hn6jz5cgVjJf4+D+xbwnOMeDRhv0BQENp97u2Q2U7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

This series introduces enhancements for ethtool coalescing support.

* We added support for on-the-fly cq_period_mode changes for mlx5 device MODIFY_CQ commands
  - This removes the need to tear down and create new channels for reconfiguring coalescing
* We also now support per-channel coalescing configuration.

We noticed that mlx5 devices were in fact in some cases not being configured
correctly based. Some cases include impacting tx queue coalescing parameters
when adaptive-rx is tuned on from the off state, etc. We end up fixing these
issues as well in this series and hope that now whatever state displayed in
ethtool -c <ifname> reflects the device state. The exception is when DIM is
enabled and the state can properly be observed using the per-channel coalescing
options in ethtool.

We would like to thank Joe Damato and Nabil Alramli for their submission to the
mailing list that inspired the work on this series [1]. We would like to get
their Signed-off-by trailers and accredit them as co-developers of this series.

[1] https://lore.kernel.org/netdev/20230918222955.2066-1-dev@nalramli.com/

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Rahul Rameshbabu (6):
  net/mlx5e: Move DIM function declarations to en/dim.h
  net/mlx5e: Use DIM constants for CQ period mode parameter
  net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
  net/mlx5e: Introduce per-channel coalescing parameters with global
    coalescing support
  net/mlx5e: Support updating coalescing configuration without resetting
    channels
  net/mlx5e: Implement ethtool callbacks for supporting per-queue
    coalescing

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  36 +-
 .../ethernet/mellanox/mlx5/core/en/channels.c |  83 +++++
 .../ethernet/mellanox/mlx5/core/en/channels.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  |  45 +++
 .../ethernet/mellanox/mlx5/core/en/params.c   |  72 +---
 .../ethernet/mellanox/mlx5/core/en/params.h   |   5 -
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  95 +++++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 307 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 209 ++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |   4 +-
 include/linux/mlx5/cq.h                       |   7 +-
 include/linux/mlx5/mlx5_ifc.h                 |   7 +-
 13 files changed, 685 insertions(+), 199 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h

-- 
2.42.0


