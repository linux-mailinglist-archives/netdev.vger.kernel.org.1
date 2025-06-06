Return-Path: <netdev+bounces-195461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF8AD04E1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAE13B2267
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61A19D07A;
	Fri,  6 Jun 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6hA+EAQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CF28981C
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222476; cv=fail; b=f6fmq9B83t0r49dBSrdkiqzCif9HxbX2yuorts6149rBh+pZn5sDxNc+M+4X067gHUQNQ7/mfrCev0VkexRsVGR7o9SpuCboi60X56I407MYR+o17Dq0FrB1X3JYi8D23lWumk4Y4qOaTpZND3wN73Q8Mw02sZO4F5D/rd45/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222476; c=relaxed/simple;
	bh=ioyoVPKlfv/1u2g97lfroHpOFjJwVtFX+QXmerfTcTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWN3xkWh7ckCPKQmtQnldFdcvVDpOsSm4V6rC/Vt3Y4hhd3gZ6fN/w9Tv6T4x46P6AdRwS5ajtubAl7TjK52VOYZEhEaUjjFgDFm3cjULL9EMITok8gAXSqzRXktS4YLqSf6sGrV82w3XOEiQP8mn/fZMI/byQ8ThZFhXl/PDfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6hA+EAQ; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p485h5y4sTWMtLJJwassVON/1a1S9K/FXYsFv2+Wr8m5TxcYVvgUyviHO+4lbAUO66/GVid3vx/zg2KXJ/aTPw4+N+ahCUmyB44bHUX8ODDo+mszvlGd7JtcnPFMFCyJMuHKGvsumThsukuAi0cHZ1jFXeWLvyyuX13IDmpPukfLBHBw6qmfWv1CdAT4CqdH8lvZo+1WaNWmZia85CccmqjfROtzSYekLyPN9hvh/jZO9IgS0y0bbSUw6SjC4I8tJHu2+lLOIuvzRkb7P6O62Gi5rBzaW1WX9QGlx4zylGap6wN5MQXjpUyWcTWfMjQjkr8G1Uo6TQs9XEND0Wnrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhjypEibqqhWTZH6yrCZdfLFonyWwbFenm4CnLHpcSE=;
 b=DBMWL54lE60LDCUxbCgX1IQKsUa2M96HXaO+MuBIzIf5IbflpD3l0mJvOnl/nGoI2EkaoKg0qXoZVf9aselFr53+IMm5Up94oAZnAKghoH2C916ryxTJbMWNgiEGseT0d9j0c7F/+svCaM4y2bs27+gNcBbS8fKYqyUQ99iLKICzstaIKIdYf09NOCfZ44jihdFNKewrEi3VX1chK+feTGFlLcWu87fgWrAtRmN76LwF21SS2NmqXeYUGg8ejUdtEHuhO/ZjaduElM4J8g1yGofCUJ6/KShIbHrEZPUxoD42LbNfgNU9irQBnfmj05a+AlC+yv2q2hLBY5fS+zquog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjypEibqqhWTZH6yrCZdfLFonyWwbFenm4CnLHpcSE=;
 b=W6hA+EAQ3cEz7znJXCqKDjMNQIt9F7rZshjz0PWqXcsgueK0aQvlo2xC537to9s6wXjpIANxj8ty3rS1zf9v9A58+WKWOUHc9TAS1AWoZzTIXz07F/EFmhg5bQGp6kTBrPBDqA+0GZdk//N9v53sYjKYE7A1uv95fobZ36yvgWdDNWkEoKtfSYWlkZZqf5lX4zyl+xetbvouWrvo1cnTCMJQdRlweROta/IJdYjPfhtWUWfJK0TSEH5c6aciphmMH6FkQATyTQ7icTxnScvabDXiEsE7yi8pPZYkkPHAIDwh1/1J4FIiTJovq0Dk5jiHfRS04lMqybsX+OK9tUKviA==
Received: from PH7PR17CA0008.namprd17.prod.outlook.com (2603:10b6:510:324::8)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 15:07:52 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::64) by PH7PR17CA0008.outlook.office365.com
 (2603:10b6:510:324::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.34 via Frontend Transport; Fri,
 6 Jun 2025 15:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 15:07:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 6 Jun 2025
 08:07:35 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 6 Jun
 2025 08:07:32 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 0/4] ip: Support bridge VLAN stats in `ip stats'
Date: Fri, 6 Jun 2025 17:04:49 +0200
Message-ID: <cover.1749220201.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc17859-dae4-40ff-13dc-08dda50be8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UiZgPFW4isTzrjETR+L42YREdafzP1CkDKynJA5plDHHMtWmO8e/3ECuxHQi?=
 =?us-ascii?Q?E/6Y1drdkBrS2bU7e1E9XZuqF84eHW118fC03L9OUrlcWtZAi0YrLE9khZmH?=
 =?us-ascii?Q?bGdcL7uB5O+QyAfHK/39szvuf54+hvE4M4DttpbjQJh4n59d27wLB+b8ZNci?=
 =?us-ascii?Q?sgsr+EInF8IAftTsuEqcCDi3f373VWgTLGb4WLXXtxZv+jqSd02Qi5T67Y10?=
 =?us-ascii?Q?EJxyVHbqPDVR+cikg0fpXX8jULWcGGd59Ity5VyneWFtLP56CUyLXNJCOPT6?=
 =?us-ascii?Q?0+J4jgOkbMWAZ222tU39+HqgrGTGkjpPSxueEd8AtP92jwok/5Sjue4ixeAw?=
 =?us-ascii?Q?MDDFt1S6Z6zLMsQLgFSfRmYu7o3FuRgjyNHftz2q6zU2OcbdmknraeE/Btz9?=
 =?us-ascii?Q?qVTGJW9+cV4wYj9+W7YuojBoW6M0MbS6X1xfddXly4Wd5stwGk/vjoTmQURB?=
 =?us-ascii?Q?qJAoo6HUkablKpu2c+8agIYEAcgGVZanZUuwfzPDLvS/2+PyVH/PmQVhldXs?=
 =?us-ascii?Q?yJBnu6qKsFSSC5hpxdDLTQuH0HXs+KS0jkYac8b3Mzpx0kFVAVTrKpgllY99?=
 =?us-ascii?Q?A48M+AG3hgDNKJGfUCul0jKq/7kdol/tO7efpb6tSAkGS4qIaRLxALf7cfHj?=
 =?us-ascii?Q?un7RnkuxL/HjXTfu/fqntN/e9EoiphXKri1FwqJSMw7+fWSBG5RRJAxfVK9d?=
 =?us-ascii?Q?/7Uj+IPMJRSFyhkbDZO5B8e39gQGy0/iSDnL3RseaB9clsukMWoJONo4/1qd?=
 =?us-ascii?Q?zPPoGptKmhJZO6CL4/pcKC7XDb3YObwsFV6cMho92TtMpVJAPwGKKuA3AFRE?=
 =?us-ascii?Q?YKDQNup7Qzq34ydcUZuTeJW4kER7bHKKfEWi+2Os33M9W43pOaORa+4/5cY3?=
 =?us-ascii?Q?uKB+z1XObXftXWcNHnBmuM0Iot4nGttI1ZMfqtvCu7AVY9fLtlc4cw7Bgqv8?=
 =?us-ascii?Q?vOFKPOVtJo/WumnxylMa1OkBK63d9h1NKXqBP4KNDwMozZn4z8DDUnhvBd6F?=
 =?us-ascii?Q?eT1Kpvzqy7AJv/4uJuEF3hml8GDkN0UHcEPKEsUh82mH7Q+iiciicDPCBWdI?=
 =?us-ascii?Q?8tS2JcQuKg46PU8r023TJC/hKioLJm67XQfzoMYeMDpkDlsMhzNvpo/WPBhs?=
 =?us-ascii?Q?d/AgDIRomqof2BBmGjuXGz3Iuu/MGKVE60Y1sElTTQxQBz/UEUBnPBiWTfxD?=
 =?us-ascii?Q?NtPlf7fAnSgoxcMaIFkezkCp/ClZ0nIvlJcH6TeGO8svo6b9YUSdKDjHAokH?=
 =?us-ascii?Q?w/9mwF6B00ET1sUMLHHD06gXwIabCrxll74PgDHENlj9l3NoYjmpPciIpgH3?=
 =?us-ascii?Q?zump0aXNISo10Ke0iCMphjXZBjqFPjx6+pz5VE27imGoMKytdg7myBEmeNfo?=
 =?us-ascii?Q?9X7pZjp9bxsxYudDizxOl2EwW8GhvVOnZG97IRXxmcSVT1+GmCl5JXFuBb92?=
 =?us-ascii?Q?H1qMBMSoXbakFlAV3EoknP/E/PrZyVqAnDbOQ2flQZ1NKj4CUQqMdeF1uR0b?=
 =?us-ascii?Q?6EZDqQEBuvs0DjkjWMFGI+UrAqx8IxR7g9fn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 15:07:52.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc17859-dae4-40ff-13dc-08dda50be8e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

ip stats displays bridge-related multicast and STP stats, but not VLAN
stats. There is code for requesting, decoding and formatting these stats
accessible through `bridge -s vlan', but the `ip stats' suite lacks it. In
this patchset, extract the `bridge vlan' code to a generally accessible
place and extend `ip stats' to use it.

This reuses the existing display and JSON format, and plugs it into the
existing `ip stats' hierarchy:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 776 bytes 10 packets
                     TX: 224 bytes 4 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
 [ {
         "ifindex": 2,
         "ifname": "v2",
         "group": "xstats_slave",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "rx_bytes": 552,
                 "rx_packets": 6,
                 "tx_bytes": 0,
                 "tx_packets": 0
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Petr Machata (4):
  ip: ipstats: Iterate all xstats attributes
  ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
  lib: bridge: Add a module for bridge-related helpers
  ip: iplink_bridge: Support bridge VLAN stats in `ip stats'

 bridge/vlan.c      | 50 +++++-----------------------------------------
 include/bridge.h   | 11 ++++++++++
 ip/ip_common.h     |  1 -
 ip/iplink_bond.c   |  2 --
 ip/iplink_bridge.c | 40 +++++++++++++++++++++++++++++++++----
 ip/ipstats.c       | 18 ++++++++---------
 lib/Makefile       |  3 ++-
 lib/bridge.c       | 47 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 110 insertions(+), 62 deletions(-)
 create mode 100644 include/bridge.h
 create mode 100644 lib/bridge.c

-- 
2.49.0


