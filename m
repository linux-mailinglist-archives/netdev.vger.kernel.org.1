Return-Path: <netdev+bounces-180355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7FA810A4
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E151BC1AF2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC6022E3E9;
	Tue,  8 Apr 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LnNiMN5h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68BEEB3
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127001; cv=fail; b=sxJdzuMue8fWyjGKecjcNdtdVwta/+5fWaNJXoB+CnzL2A30J4NPmEvj9UH6XCOlWb7TJa89G5PRRc/cTWJn3pWDF4DEt2FTqh2tkL4mjlQsPcTXz78cmOkSertk+/fDOixT2ABex5im7UJYdGx5cDRVMI85uQ8Hx6D55DsMqoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127001; c=relaxed/simple;
	bh=NiUwWtS85gAWHfo9NRF6jVIfMIXO9HEwWL72H0vKyXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wh0r2L9QM8nvyjI5P/FeHIStjQzWPaW8mRsXVsToTHUNcZDquddjIL6iJMcnr/3fEM4DA4GMjULC7HWGidZw5IBBGY1CwpL1C2cPPs6r9/3EZVx+q7sOzqra/5sT99AX5Shn7hGZRHJt5PUEzDC+cOCb7CikpjQp1loWioSS/u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LnNiMN5h; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD3EqrY5e6MlNZcrCyrlswqKxKIo1GqGE7AVF8hQVF+L3Q1ZqbmkrTIZPhnMiJvGfVgOA6cZClAlhOA2x9FQGOGxKVfAr2/1PySfkDPI4rmbnwFPZDssaPUpLbEqu44m1OI7cwczAdDHb8hzz2os4SML3AEv9x2Bh+pZVdD4TWqCLBrDljYwi39tZ+1RxYtkZUfh723ru6Ix8/1WStD3rXTCyd8qsZMvzG5gnUntOi+nahTAY7BOwViEcDAMa1RAXIch2ugm18jV/uWpMutcBVIaLnj/K+EIVelZiNuftISa4AefT/2d3xu+ha4fO9L+3YpVxjLdZ9Et19B3vLC9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bwX3Tc1wr9MsqAJqYlZkXuk7g/6TYlTwKMgFyfqRp0=;
 b=ebanvcfYvl+JENPsGufeyULAjEnY5G60dlR3aE3YX9Zn9vOAp0ymrOK3mUjb+Mmf5+60W60C6tE+lftMplmouEBHLV8wXGpEzFwDPK5jxLPonLkc34GBA8GxuUt6+RONUPoCjpMUp8iHO9c8t6SsjiIJDnyVOwxJPpq4SfAIJQQ1uhhJifiRSPGHWnc8l+VrQEB4BtmtvBi8EhM7VjIuu9nbO3e/yitMr/qrHbKCloM9Mzbm3g9pmWikCtTfCexUV3SOQgCQBFyYZ5nR+kL6tSR1OGxgfU7ySSWbU84Ma0UXXpniCaWVsDvpL6wgLqrZE4hpo0+eduGvXM4yogBk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bwX3Tc1wr9MsqAJqYlZkXuk7g/6TYlTwKMgFyfqRp0=;
 b=LnNiMN5hO4LmDTm9MYxWdZ/7MhmPlumUvlpH548jzA5k1p+zneIfV3OADvee9CzNFeTHTKSAqef2jo2rE5cpnYCMaKsBb3QYLKAW+Gu0DbYw26EibS7eRDTp0zdIEkAbRtHaDwH0EvCXyZxPlCaFx1L0F9ZgC5b9JGqprgggnjujFBxb8sIcU0kiG37Ls4kId4tCOZYwFVmOFe4zQtboh+1KH3wTAlPPiNzxIjsVyOMWpK6/rZV6Q4VNg2/jsvqlLKbGVTlQK42FoEbojmuHhTNrJVf9mm182WNJG6ix25+1e1k0tw4hsIILh4cKQIX54EuUrVu6MYIOevxJUMzHNA==
Received: from BL1PR13CA0255.namprd13.prod.outlook.com (2603:10b6:208:2ba::20)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 15:43:08 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::88) by BL1PR13CA0255.outlook.office365.com
 (2603:10b6:208:2ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 15:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 15:43:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 08:42:52 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 08:42:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/2] bridge: Prevent unicast ARP/NS packets from being suppressed by bridge
Date: Tue, 8 Apr 2025 17:40:22 +0200
Message-ID: <cover.1744123493.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e47da2-8f3c-4a9d-0d52-08dd76b40f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQos0L+xUerqS0gK+hPuHvEfeaY8WEgup0POsKh+ZFJY8n/VFLWzTnef614l?=
 =?us-ascii?Q?ZryPVilRXqy9FhVlaB2iPUllELPFkrIqQ4ZU1LemSo/S5EK4IsIcJZlzf0QG?=
 =?us-ascii?Q?aaBjeHLZ82EaUfXHjqHMvtABc9n8o4vgt/XUYhOfvfbOeAyuMpq2OgJu4dBX?=
 =?us-ascii?Q?i/8Bo1mMAoed9CstzwE81+F6OJKDjPWdJDxGPLG7zNe8z8QBgkO7LMcHu2ut?=
 =?us-ascii?Q?A4RD8E1ex7a5/9prgaSUgG/xzR/wl9x+aYqiIQdJEP5NePRVgBpkMLU05VLo?=
 =?us-ascii?Q?629a1V4vJx/yIw0oTXny8gbxuNTQkSJ7ade2Hw6tMLPmpvklC9jkck8WvRfg?=
 =?us-ascii?Q?XocZPX32knHLlyq839Oh/S5rVbyjRsq7Je39Y0A4pvOtNrmCGM0RrkYXkCgh?=
 =?us-ascii?Q?0hdpFqj3ucOWPd4JMUgBXivJogxDgzUjRq6qk5uZ7jR0YrsygBAXuICqQcZ9?=
 =?us-ascii?Q?drz4llt7mwCleXwqR3Wm3eyaurrba7zF7WHB3zkie+7KaVQCoYYZprAGpW4W?=
 =?us-ascii?Q?MgWg0L3kINWPQ7uWEdaoOoJ1B6snacfEFPL1GK8oo9BsAcjehiHKWrW8J8g2?=
 =?us-ascii?Q?wEecG0XJ6Xnkgh6iuAJxf2iXLUe+e+JIqLr/7lGUPRcXPJFfQHdyaBKg3Pcb?=
 =?us-ascii?Q?7KbDLuJq6RpuWX0VryrRTvaBv5J25JcoXwTxgQp7f0rR6/SLHhK/XTbNeeUY?=
 =?us-ascii?Q?Pj+fRm14aQTBjjJrPAXspGjbptNucLo18LdygByf3aVI0AsosaJtGq3dCxU2?=
 =?us-ascii?Q?yO8THeQhUwaz4Fp1dlgiyFUdWoVJeEbO2mfiyjufUEfnIjPAFAFBnQqlk8Jh?=
 =?us-ascii?Q?3DcsvoKuLnmYWTsg8oaGrab0qL6ZqC0E5ZmeChQG/0UrPX7+e0MnTU1njiuf?=
 =?us-ascii?Q?E2OTJeIO7UH+FdZREgQIjFTdzOQ62EYt1ZRKEy9Uy4MJ4MH2CvrhwD/YIllV?=
 =?us-ascii?Q?JZX6nvVw/iAZDLrZFIbBnFuiIA9UzXveyuWKNjhJBZdUdzGbav+xguHeE8Ac?=
 =?us-ascii?Q?Gnm5QZCIww/bHa4n4o686GXa+o1Qx8UshuaDw9gNp0afQ+uC89YGgM2+EOlh?=
 =?us-ascii?Q?53J4AUGtmhBQo3aSa8/XVOV/0dB66GdqzdgdmJ37kG1O4V7VM5cgmll4L5dZ?=
 =?us-ascii?Q?8DFHQDI6jLz/Wq07LmFK6NNASv/Y47WPF7idryxxzbfyWxp1xws8J027dBRv?=
 =?us-ascii?Q?1thc6dDp5KK5kFJdc5Ben6lfra6uQkWUC0jdHcorDDfsvNmC5Y/Jpjgs0VU3?=
 =?us-ascii?Q?kMH6jZRJLwActKiIVsFxhzYR4TA0jQ7HbTCtumGivIMPi3YHdJryMYgeAf8j?=
 =?us-ascii?Q?7rBccj0tYm1j+ayH26hfcA+r3csjw2YIHRS5kES6P7wj35BjuGSGapJnKp0P?=
 =?us-ascii?Q?GVRB/9Fm3SpSeDeVUFVo/M7obEKmkxhp7RH3Gu9tBi9G++mbzTN5IWvgrOye?=
 =?us-ascii?Q?54FGcd4hYy/bntrrUrTlNSL5tNaXLvrp/IRSqeuJzjjORbKzNS81fnw5WDEQ?=
 =?us-ascii?Q?Qsn73MAL5srub/7Am4w02ablKhWBQvrqkXce?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:43:07.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e47da2-8f3c-4a9d-0d52-08dd76b40f0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

From: Amit Cohen <amcohen@nvidia.com>

Currently, unicast ARP requests/NS packets are replied by bridge when
suppression is enabled, then they are also forwarded, which results two
replicas of ARP reply/NA - one from the bridge and second from the target.

The purpose of ARP/ND suppression is to reduce flooding in the broadcast
domain, which is not relevant for unicast packets. In addition, the use
case of unicast ARP/NS is to poll a specific host, so it does not make
sense to have the switch answer on behalf of the host.

Forward ARP requests/NS packets and prevent the bridge from replying to
them.

Patch set overview:
Patch #1 prevents unicast ARP/NS packets from being suppressed by bridge
Patch #2 adds test cases for unicast ARP/NS with suppression enabled

Amit Cohen (2):
  net: bridge: Prevent unicast ARP/NS packets from being suppressed by
    bridge
  selftests: test_bridge_neigh_suppress: Test unicast ARP/NS with
    suppression

 net/bridge/br_arp_nd_proxy.c                  |   7 +
 .../net/test_bridge_neigh_suppress.sh         | 125 ++++++++++++++++++
 2 files changed, 132 insertions(+)

-- 
2.47.0


