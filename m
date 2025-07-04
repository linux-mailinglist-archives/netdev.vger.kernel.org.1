Return-Path: <netdev+bounces-204137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7BAF9278
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E71CA770B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE512D63FB;
	Fri,  4 Jul 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p6TVxUsj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF728C5B1
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632106; cv=fail; b=Zo3wsVjT6kMi+O4cxUQZiD8VKrUHZMVnbRFfAXwYLCcK0hgX3sfeB9/t58ym7jKzNpAN4jwqdGDvDZO3NRh+lDYTUfbc2OQBgPwqT24zOLojmOLLV9+RDc1ya0e05uZoc7XaGJzSPuDRBFB7SVXeszuXt6A/EV0mOib0SsyQByM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632106; c=relaxed/simple;
	bh=ugHJnIVwV1NKAEXB2j/lEfn1Rob8Jrx8jWoHlMiSEXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFOFLM2vcpHZ7ZEktTaxf0Vnzrz7yx/8I3cggMbUONM6g3OLrjjfukjFk5jNkFwztc486KtBHIQPGDWt+ccPbplhRz2cLNy4nbcqQbzibxnhTjTSFTAv0YfbxExzAmxlvYbGgsj57dqvXKg1F43a9EQGRcvYtsjfYMizpRdCLMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p6TVxUsj; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N92QxXetliNW2Y8UeHzQWpu5M37p2axn7aRjr/UPSE1rvNMhUcBx8pynf+032Egen8xjgMBjAIvMz/siwIlIlSRE006wURfxdFfj4zGJQaHxCTTe6+XXHeLZFPcHnkXMlat7s+A5TiBAb2fykq8gUnVpOvCckcPm7oQUjd0EoJrets+/2fc95+9DiprZK1TcUi+oz407ezY13XBvpcLM3nZZDjIjOayke1/+ijMLvWra5kcrM+abLl042aa/NzbUgsO0mLtDe1As/eIKOFWOzmpF+K2bCMlb4t+HAplw3uKjWZRttyWYSYu+gZIfOu6RJT451gRRb6sUkSmRa1bOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrZVgDWoGQHGHeHri6CXLRWMzFORwjeIMkmlhyMaNIM=;
 b=juNj+8qgIh7BjWtOtUWgAxlQqFcONhL0o2VtiitDYpT0jb0TBoDeZbnowBqCPB1MOzfjaKSU7ygvSAPoL0vZKWcd5zYiDmZPYOInatTYqAN/5LrZM/7eQY8/76LIlE8WPDbh27NlgZ4K6jAFvmDEsEPyUKl58jLXz6XGCWYp0aFudyo6QNc0rUqmIprRRHmeaHP9GbE9dWbWhGyJJMiGHHY4GSBNmaibVpvLHCvAxmDOUl4awRpuxOvjcCb6VbXotw1S6yV16nuQw1hEnv9MLoZyuOvfN4Qun3VxBjOyzs6WGbBcXMmGewNnySGQDGjKSbLkGKewn6VdYWW46XhKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrZVgDWoGQHGHeHri6CXLRWMzFORwjeIMkmlhyMaNIM=;
 b=p6TVxUsjcsIjtGTPyuRnEuxfPP/w9NUbmbz6eSXDNHhWtt1CbniusTn9fKWMpTkyDZH/gqLOq2J9KjzFvndiyUWSxyI8z9cr2089PjrAEPxPxQSZ12H+m0JXeUucae+bteyyO3K2YsdZL8HzX0Lp0scZ3uQsSmCidY9gX243YHOvM9lkmHs6wu3ekzIkUTCA3cbrRNh5bPdjhtoRgPohMzNJoFuDVXizQsk6AjUjjiVwb7zRnMBzz3aHLhMx47ayMm2jK+dA2FUFjJcjBfQUDxneqfIwRvqtx8PYaDldX+R0O8lPe9WgSC097y383zq2gx63mZbcaQPZvO4jGd/SZg==
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 4 Jul
 2025 12:28:21 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8e) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 12:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 12:28:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 05:28:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 05:28:16 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 05:28:14 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: <stephen@networkplumber.org>, <dsahern@gmail.com>
CC: Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH iproute2-next 0/2] Add support for traffic class bandwidth configuration via devlink-rate
Date: Fri, 4 Jul 2025 15:27:51 +0300
Message-ID: <20250704122753.845841-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f1d32d-e659-4ce9-bb98-08ddbaf6434e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSEZQVZaovjUrtGZe4Sjvjv8v9Z+MLVqp+3IckOsOws9x1L37kyl1GnEqphc?=
 =?us-ascii?Q?h7ssTi14YanErCsJK5We+hObghPrfqA5/WE8NknmKEO3rRlcnqAVd7KSpkfv?=
 =?us-ascii?Q?hHfeAlMQDQWYbSq0Z2+llbX5bXIN0YktBCGHsTlTmE5NdTWADzhtOVB397EZ?=
 =?us-ascii?Q?kiEgN7apmkg/dWiOLrbLNyieaKY+yBTLDtYscSXFLT+ENBoupA45AkR7kzyR?=
 =?us-ascii?Q?89hm1IA3g8aO7UxIsJp1EZg0MHtvsb/3cEy6XsRlAxd/r5vx6t/iSDgc5lJm?=
 =?us-ascii?Q?0HOYDLd1WVtuqMwemcjb9S/a9qU2XTm8KcSweuit+ezE6reJibJY5d7IiXb9?=
 =?us-ascii?Q?zQQRVNdllGl22Zd+MeLydN3gtdOFXTxkXWSRuNHq40AxXDN1mOQC40t/lA7z?=
 =?us-ascii?Q?sBtdz9ds7IafdxXzjJy1Qhjcnu8AgVIA/JyBnoRl0xpVyjNLWVRIQIeT6P3j?=
 =?us-ascii?Q?dZmk5hyojI8+eE2wjCNR6LHzwQEUjyCTZ9y1eyL1+BRPpKEhotqfjkDQmNL+?=
 =?us-ascii?Q?Io0jFsmfxh7b2tqebAfwqVxQI1CYXwsguP2W9UeNdlvujunUtzoOzhu7TUc1?=
 =?us-ascii?Q?e68D7tR/bkrg2ZCHzsX4iZIVTXk1e/qUc2YnOckSOGd9G0RKqLydQE6zn3zY?=
 =?us-ascii?Q?dBrFGT18alYynlpoP+gR0TeWCCWNMnfb1GX3CdZfSkLKdNRKaaVh6nt+qLHs?=
 =?us-ascii?Q?jkzhhwSiIulIb7rhn0p9mEFNhLML4vnYClJhuNCfnwpIZm9XwyE+7D6qOPUn?=
 =?us-ascii?Q?iWGwbzu2vgY54GTYlBJ7E/TF6mEKMIdJzbQv9HladRPT9TacOZtKjuPNu9N/?=
 =?us-ascii?Q?N2TNqJhH8QV7qcZu+yIe9xWD94f3BHeGIK3uOEFnROh6UbhkcgjcuFA5Zfel?=
 =?us-ascii?Q?YziN1bgQybAHEnJEjhNpKRNTTP1gKaA0gwIQZqf7K7whXnS16J49ReTMHNGx?=
 =?us-ascii?Q?ArLp40RD7UAs8vOASqfU7y7ObXBrez9QA62zAHYTGEytro/ZLoqi6nCNfWqw?=
 =?us-ascii?Q?zNmxsNkvPDvmRt0IZ3wqgW7QD/617z879s2IZiV7XhA1QUn4jk31RbiqjVQo?=
 =?us-ascii?Q?Gl1Yg0PRXuFYxT2s11tmZS8GgCQrq8uLD9vcR/Nh955LO/7PuPrOn4Y3iJR1?=
 =?us-ascii?Q?lFosfTLwiplGtlgLWn/MU4qW9UONVSK//sG4Q/6Ae0BU8PQpLg/kp8XZlNlb?=
 =?us-ascii?Q?BhVCdImXM8tGW1+CkWZJ7CHEnmrCpIBNYn1Ux7cVkleBR+ocXWv7fCfjm9kQ?=
 =?us-ascii?Q?7FzCjv62Lc4ZEpa4AMJXB8W5fCCrv5QzqEVL8BHTYKi/771uQq5/HnVKDjI6?=
 =?us-ascii?Q?j/UILkL91jN7+lzs5f9at7VLT25W4f5acJbX/sw/hO37JP31BiyGXgJyQQtB?=
 =?us-ascii?Q?DoL+NSYOgh9gTldrSNHmG/J4PThIs9U3uUZdhkcaymYKvWoEhRUqsNbkutmr?=
 =?us-ascii?Q?awdK9SQ0X+UxVlGDKBPZFy7V0VflPtzHi4gatLGFjx6MzuXrE/kcCcZJTidC?=
 =?us-ascii?Q?1693VDvcPy3uXjwATQeasxLh/S9idLcEWWBV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:28:20.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f1d32d-e659-4ce9-bb98-08ddbaf6434e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

This series adds support for configuring bandwidth allocation per
traffic class (TC) through the devlink-rate interface. It introduces a
new 'tc-bw' attribute, allowing users to define how bandwidth is
distributed across up to 8 traffic classes in a single command. This
enables fine-grained traffic shaping and supports use cases such as
Enhanced Transmission Selection (ETS) as defined by IEEE 802.1Qaz.

Example commands:

- devlink port function rate add pci/0000:08:00.0/group \
  tx_share 10Gbit tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
	Sets tc-bw on a rate node named 'group'; traffic classes 0 and
	5 will get relative shares of 20 and 80 respectively.

- devlink port function rate set pci/0000:08:00.0/1 \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
	Updates traffic class bandwidth shares on port 1.

- devlink port function rate set pci/0000:08:00.0/1 \
  tc-bw 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0
	Disables tc-bw on port 1.

**Classification model and queue behavior**

In setups using traffic classes, classification could be performed
based on VLAN PCP or DSCP bits. These are mapped to traffic class
indices by the hypervisor or device configuration.

Each transmit queue is expected to carry traffic for a single traffic
class. Mixing different classes in the same queue can lead to
head-of-line blocking and scheduler misbehavior. The hypervisor ensures
that traffic flows are mapped to the correct queue, and the hardware
uses that queue's identity to assign the packet to the appropriate
traffic class scheduler.

The 'tc-bw' configuration assumes that this model is respected: each
traffic class should correspond to one or more queues that carry
traffic only for that class. Bandwidth shares are enforced per class,
not per queue.

Thanks

Carolina Jubran (2):
  devlink: Update uapi headers
  devlink: Add support for 'tc-bw' attribute in devlink-rate

 devlink/devlink.c            | 191 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/devlink.h |   9 ++
 man/man8/devlink-rate.8      |  14 +++
 3 files changed, 208 insertions(+), 6 deletions(-)

-- 
2.38.1


