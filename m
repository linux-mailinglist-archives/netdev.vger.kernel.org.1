Return-Path: <netdev+bounces-218653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C320B3DC6F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF0217CF31
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04C2F6588;
	Mon,  1 Sep 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhLDTHN1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75B2F5485;
	Mon,  1 Sep 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715579; cv=fail; b=bnJ/gQJByioJjr7PN9EJf5YL887mheJA+ZBnPnK2RSBbN1h1LV0LRAZK1O7QfGv5JXvjOfuhAMKSLk+o/LDXT+Y5k7taqDr1g5RRrTVYjDMSQFSiO0zLSdvduMY8GWGaFmC8lH3xSprRiu/8pEqR0EFXd88p5w6E5Nhp5eaaaDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715579; c=relaxed/simple;
	bh=qOjQHqU+9FRrT99QajWRsi3Oc5KX5ybsdBAJM2TXdKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIQPDck9N8hvOkANwBOtakjtQRCapUTYXAp4WZL50Bhq47KP4IDlFXOsKXgKoiZDGHDebO1B/V2jTdfwBM8QAGJ/DtnYuvlVNmaQbyRKWUBwVzorJY3OqHei+8bW9Ez5zpDRzWUDg06nAyEN33UEMLo+zJIfnSiBKO6qtNpnXl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KhLDTHN1; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTB8Ji/WZazhAHV6OspsSgWHaHw4dFjjtZzJX3FkGNcM/L1rqzy/W0W9pR4Omt36pJPfgNDqn0GvqvuaZU44Wz//lCQFUR+uZMApwCTG2PxIRsA9VsobPNztTsT9WSoGOQV4RLNYtFNKnS2LJ0iQe6gMkcNDKETBSUON5y42yVx0oEJZ3VhFn//OAgQQF/gDjXdFbANS4/6e9baVBnZENOSvcTFan4LSNXIlLhfo8HNHA4znUVDp88Bc15goijWWaxmyLaEb8P5PWc8M3oUw2GlAO33ry3jhFTR40TDW+N+U+Ebc/B88v07kXuDM9JrRPw2YfRhHNb08MtdPkaNckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HX/cUUEpih2eyRb+i4fImdjyp9PbfPXPAqb8Ga0slo=;
 b=q7rS7GCY9cj8hwMGdYmEMqNkzh+PVB/oCdJjnsXAJ+YNN2u7vRQJBPR2ih6CiTQF1rkpPFPKqDHXfHGZOvEiYPN5SR3bJwGQ5ELGEvK8jjiz7zeM0J3MbeAyyT8pQF6rNgodc81d2StzcG9E4O8wJtXCTvwKx4ONn7zpaJ+uh23nkzb0p4b/UPahKzBJz06GiRdNWD9Ftxsqp1gq1sj1JlqhZRs4wLV6KReOIvfkvP+fARBTdUSIN2VNVtXzFWOIAhpfJnzi0iVVnUWCJRNE9mgm8u1L4vfOc2P6uaeQexKKTjTnkoT0f/7FZjuSJpBi9rnFdQPef82f3rtNRBuTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HX/cUUEpih2eyRb+i4fImdjyp9PbfPXPAqb8Ga0slo=;
 b=KhLDTHN1i7oCV07GVtt53XjTPhPXAI1lyKOKZnoXLgzUTjf/oE+IchOgD2bsBgCcUHcXTHDp5XB7rpsZ0UswZi+q7RZXsrKPHmXFRAs09KnPTcJSP+SHhcnNscTjD4ahxdbn4LYmREyjn1R9ZzNUozNDR2LjFtEfLSZGcpRC16V0llx7gQ3+4KrK/IJq08WFr0+E0C7LxQK1wMjd4f/H0vdFKu48cmr59nb7k2UEF7ILR2EiqP/FIH+cazyvpfJ+VEEivAHCLAiYWphAIeLwz1a2totHvKZ2zzSOJxhLF+BKxYysbTHXIboGKV9iOYAoQL6YE4HKQQryKf8JFSskkQ==
Received: from CH0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:610:cd::23)
 by IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 08:32:53 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::7c) by CH0PR03CA0108.outlook.office365.com
 (2603:10b6:610:cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 08:32:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:35 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:32 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/8] ipv4: icmp: Fix source IP derivation in presence of VRFs
Date: Mon, 1 Sep 2025 11:30:22 +0300
Message-ID: <20250901083027.183468-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3bc2eb-fadd-47dd-6b76-08dde93224b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8FmzIOpeNNgbozV0OVWFRm1zTHaVu0LQYUuOY9qI0wjtgpVKCXjrYN1uUoJp?=
 =?us-ascii?Q?vYJY6Wjj81L+BjwfHioUgvOwIOQNhyVOKCAwPUkctIe+te0HMznrnFACFznL?=
 =?us-ascii?Q?S3wC2zz1SEHlGKZMoKqhuAMRCxMH31H4CGN4Cfk1dyXLheFvVIEnaQQSmNOq?=
 =?us-ascii?Q?oL0Lgo6kN9Y3VOHb+w4nCVjN2dXYxXrLkFxncB0pqgqIx3mlTsE0jY61CtPy?=
 =?us-ascii?Q?1qxy0OGJEoyQ+pDAgeNa0YOqK3ixNGk+XLELeSzpa5nApptWY3wNiL9Zkq0h?=
 =?us-ascii?Q?0DdBwvCgMYg3xfXn0rjW+XgIyr87j50LDJxsIZ9FYT2DOrrE9Een8/a8K5YB?=
 =?us-ascii?Q?W2PDyGODUcObpMY0nficaSUFgzQw1u2EV+gMjKx+HF1+m0pRCsw0Ozd6PQKD?=
 =?us-ascii?Q?1KTY0qmIJr21EAwu0thKgNC89N+6zN+Ppvt3e/pUSADdNzs+e7gQHdKObSU4?=
 =?us-ascii?Q?ZvL41apDY+FL97Y5LTWj+mnuAj8kwelShkFBMg5Hy9jnlvIG6TXXWTff4wnX?=
 =?us-ascii?Q?Y/J7oCa/CdqiacLI492WPZXPUQwoF88hKhqHsOFrKNXtB48EQ35tj6D5KMqG?=
 =?us-ascii?Q?MkF6G7Vp6zhdN84KDk+xlRtnP1FHjHIdWscyO8/ol5/pXXIpNu8Y3BIg1Npg?=
 =?us-ascii?Q?Ty9SM6J+FL7pfQaH/LtRa5+qVSA4TdOrYEpPgAbBm1IGBTDrTCOLoJ9iyoqW?=
 =?us-ascii?Q?ysn317lNyey2LpzxT8rx/7kH2FMXX4P7uPiM4Jjq7bsyZl5UJxhVE+bkVzSX?=
 =?us-ascii?Q?BDKsY0YG9GpsjhgyNPTLUK2qJHyQQiTLbWpLqRzabCF13WERs31prZpO8yk6?=
 =?us-ascii?Q?s0ekEqxz2KjcOgTDFUUZXN0TfVmmibKLrxFtxdwZAgWnkFEp5RN6iPXvcsTB?=
 =?us-ascii?Q?mUyHbWuCDbvJEjDhe1cXcBElBzCA2vUlqNGD5TTmst9ayM9cqtj/AfQB+0ze?=
 =?us-ascii?Q?Aw+/zOv6kGSNpr2T0FBn4NRINplIS8w95XYEOiurg+h55GheOZe8HczuSNtw?=
 =?us-ascii?Q?Egrkpi53sT3DsuRaqLjdSyjZReKCA5CW6TxOPY6yEcyHSWVKk+13+AOcN8Qs?=
 =?us-ascii?Q?ZwwaGyCZG18WyDudmnO9oPHP6bdIO160aBxL6wmyZV6AJEK82TvhHxOe18N4?=
 =?us-ascii?Q?qkC9oCw5oSzXfrbMFUtPtstzok8eeK+WLiErmx3bJOduZxIiEk1Eu0OvFzi1?=
 =?us-ascii?Q?k22Mz7v5pkpFfjmIahxndC6kgX9UdCJgjlDx18Lny5tZ/BqwFHzhnDt4esp/?=
 =?us-ascii?Q?Wlqw/ximcUl6Pw/D38nime4/w7N5GjcOByIE5Pcm87eY3IH6d4YEHjCzx++A?=
 =?us-ascii?Q?fJhxeY7AZCVe3fluylDPaan7CSAj2CMW5F/mv1dnqL5ThAI3IZ2bdVVknxlW?=
 =?us-ascii?Q?5AOuGEo6dBqEDUY4jnevWVDT6gOAMPQCooY/uRoGHUVHh+eBrbD5ZvPS0zuU?=
 =?us-ascii?Q?dn+mYywpc8SzYdKb6D5lv+0T4OISnzUCssXr1q6CSxnSphDQLfNwmVgiccks?=
 =?us-ascii?Q?LUNmHoHPsCWevmOcj7+kRf84mNeI4gQ8bOWM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:52.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bc2eb-fadd-47dd-6b76-08dde93224b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739

When the "icmp_errors_use_inbound_ifaddr" sysctl is enabled, the source
IP of ICMP error messages should be the "primary address of the
interface that received the packet that caused the icmp error".

The IPv4 ICMP code determines this interface using inet_iif() which in
the input path translates to skb->skb_iif. If the interface that
received the packet is a VRF port, skb->skb_iif will contain the ifindex
of the VRF device and not that of the receiving interface. This is
because in the input path the VRF driver overrides skb->skb_iif with the
ifindex of the VRF device itself (see vrf_ip_rcv()).

As such, the source IP that will be chosen for the ICMP error message is
either an address assigned to the VRF device itself (if present) or an
address assigned to some VRF port, not necessarily the input or output
interface.

This behavior is especially problematic when the error messages are
"Time Exceeded" messages as it means that utilities like traceroute will
show an incorrect packet path.

Solve this by determining the input interface based on the iif field in
the control block, if present. This field is set in the input path to
skb->skb_iif and is not later overridden by the VRF driver, unlike
skb->skb_iif.

This behavior is consistent with the IPv6 counterpart that already uses
the iif from the control block.

Reported-by: Andy Roulin <aroulin@nvidia.com>
Reported-by: Rajkumar Srinivasan <rajsrinivasa@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 92fb7aef4abf..7547db362ec7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -710,7 +710,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		rcu_read_lock();
 		if (rt_is_input_route(rt) &&
 		    READ_ONCE(net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr))
-			dev = dev_get_by_index_rcu(net, inet_iif(skb_in));
+			dev = dev_get_by_index_rcu(net, parm->iif ? parm->iif :
+						   inet_iif(skb_in));
 
 		if (dev)
 			saddr = inet_select_addr(dev, iph->saddr,
-- 
2.51.0


