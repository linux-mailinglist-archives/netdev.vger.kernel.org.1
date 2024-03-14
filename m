Return-Path: <netdev+bounces-79897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D189B87BF59
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEAD1F21FF8
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087C70CDE;
	Thu, 14 Mar 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dPnKBNqC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0F3A8FF
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428173; cv=fail; b=TR7aEtcdiPe06RJuAr5ToONAcsYZxDlFrCLZZj1lc4dZPOcA/k9y2PlhrjzZoZiGp7ea4M13U/EPb4wFprK1/VNBtXyBfLWp80NrFY4c7fsNi49EZmbkFuZu60ImFe39krmkVuNZ7i+yYDMJkKQknbdYn0YefPxiJySANoRpMGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428173; c=relaxed/simple;
	bh=RxwDHk4OpSl7UC96sEZhBGCKtnCPxDPTIqgnu2wawOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKTDXvCjmZRxv/9fQxsKJDMsuyBqH3bU0sximBx3MCySI3FcVVji4uo9b1A5+A4DB+Zx4jRJuqFeWI67qZeHx0jMsU1B3+z8RNxiLckWpkf05ZOUTbN2aYt2yoxaNj0YjLRSfI8UAjchwC6yixtxXJZpQbOAX3J2IF4M2HGPoos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dPnKBNqC; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iom/WgWtCs2QNbXUpk4UycRh6qgRPP3JJLhRoZS2Rp1Ax8nVLyftQ35wAxA6pNGQCKcrIPR87nJMGPSS8AkfKY21cAkJPvoiiUqXHnlBmEj10k3ecBKEaGGNXhETXalSvkg6jkXZ3PdKdI989ZKgC/JYmI1VPQ/l2pXTi7EPas3fafhh504PWaSmPF1q79UEs4ubVtqTyRirA6NvXwqbo6seK6k+utNj32oMDP0wWjWJcpUZbZsEmmR0NLzr3B5CwZQPyV3N8HHW7if5IM3iYBPsvmH5Iut+kcr1KPDdqW2X4GDk9/aK8HeGLHL6VBfw/oAbifTVs+zvevko348Mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2c7wdZyiOyX0TZM+GqKgTcSKk2v+VjifsU3FmrllTE=;
 b=HcN5QoCBE40SO9rzLpuox1U0TuDaOZoV14JFf52EjkAXWUw9WKw8w3nVMMwWXcCYZ9lKlQ4K8tJSjGPXnP5d1Nv+2Ci2cNy8/rBXG0l89GGh30hrEpOdBrX+aEKRFfa63z2guM9g9OXXUnkAmbbyRIuUoA2tx3+RzSkxgzJcCbGnJl+VY393CRQhA/5uFsGnoEHs5YQiZJowIE7iku/6jJsf8Ubn+zfB+UKWZsR8MammOvgABgYHThlsZj5sQ1kjT2EhVzZocYvStWtUJ9z4SQDoGbrlgewLfAmtQmufvP2sCZu8bCaBatO8F14t/+MRUz6lTg8BtI+b/VE0jGsI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2c7wdZyiOyX0TZM+GqKgTcSKk2v+VjifsU3FmrllTE=;
 b=dPnKBNqCo34SpKMFuWrmyX9kpYI7dfSihyCitbQffcxvpCZTHppZvUoJfmOmBQeLs060aop9qVGVObR5k2so6K0zIGk8aRnE0Llk1Bdytd0sA/R/x885DrG/D0T7yhaoSsinP0yQufu8o5VS4om2WuoRrgBh/HkN4lqhgo0WNePKhfZ8WverdMAymSe7+oUWjRrdzkcrGwmR8lrzoTBSZV4DFiJZ1V4ByhPGE8nHblm2N9TBxez1jQovoeUjXWVoPWCp+EI7cVCJ5M5X7t93Xl60dmUWUiuVUEllUxp2ZB2iIO4qH2GrDPKMmp4Io4exQr4aYepuywh83K2nGRIKvA==
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 14:56:08 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::8) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 14:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:56:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Mar
 2024 07:55:52 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 07:55:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH iproute2-next v2 0/4] Support for nexthop group statistics
Date: Thu, 14 Mar 2024 15:52:11 +0100
Message-ID: <cover.1710427655.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: d86bbfcf-75f4-4315-6243-08dc4436e17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r3294S4ld58NNs7OlDY4mNtXoBhD7dBxzggpRVGJaeeaE1mYfe6HcugiUAhU6K0xiOH9mUR/I/pwpYGL9dfCvQM7JGQhwp/TSQnUgwyeDgfPJ2hgFupmAOvqQO32FUTFGOJtj2PBF3F58tBZR2xSMSquNIWXB0JtTInSlw4JN45x3PinnYJ4ra6TGgV+KBB2m+Q/+EojeWsyMgUWACOUK7qtWtGO0J0Z+pSn2vIuZN5qRLZRBtzLkSJV/WzY8KPVO0UX7qHD4LN1XNuJvDHkeiNP6bZ9KoVxUBhOfJEHKId3stdaXa8h8CXt0yzAxRG2rxKJKUkapZktqXlsULrYxjoZ5NtYEarP6xFcdshZOn1zAidK/S/xRJctWVi53xEFvNeNKNb4TK33kFtyi9QmyLkLmSTlST3Q/CBgTEcvdP4r/PfX7US6KzV0A5P0EwN/Pkgh0ZRsqgluhSIuzXcV7TY7DoZ7VjCPRd5hTGZ6IvDDsnQ73y8LYIl+WCPymzBZ8rcd6I9Fxe+Ck+71EvjIFaJa6VRkuLCZbWn9HXrbSkzYEDuv1YzwM6HylanonyVH3bNwa3UOZn10uj+ykGbyZZKdGL+zQE5yIXFbdGRqCWbmiDraa+R5lURFNU8HZJgAb8n5sVYlnYMjcsREA9okLk6WDSfPsme/T8KMZ531vmvQJtXTPvlrugut83GZe/N0HrL5jI6YhZSCUPXMrt5qS5/NEj0JSYwEw2mwg6u2NHaOaB6EIpjL/EVGHWI6f/HK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:56:08.1534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86bbfcf-75f4-4315-6243-08dc4436e17e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

Next hop group stats allow verification of balancedness of a next hop
group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
'nexthop-group-stats'"). This patchset adds to ip the corresponding
support.

NH group stats come in two flavors: as statistics for SW and for HW
datapaths. The former is shown when -s is given to "ip nexthop". The latter
demands more work from the kernel, and possibly driver and HW, and might
not be always necessary. Therefore tie it to -s -s, similarly to how ip
link shows more detailed stats when -s is given twice.

Here's an example usage:

 # ip link add name gre1 up type gre \
      local 172.16.1.1 remote 172.16.1.2 tos inherit
 # ip nexthop replace id 1001 dev gre1
 # ip nexthop replace id 1002 dev gre1
 # ip nexthop replace id 1111 group 1001/1002 hw_stats on
 # ip -s -s -j -p nexthop show id 1111
 [ {
 	[ ...snip... ]
         "hw_stats": {
             "enabled": true,
             "used": true
         },
         "group_stats": [ {
                 "id": 1001,
                 "packets": 0,
                 "packets_hw": 0
             },{
                 "id": 1002,
                 "packets": 0,
                 "packets_hw": 0
             } ]
     } ]

hw_stats.enabled shows whether hw_stats have been requested for the given
group. hw_stats.used shows whether any driver actually implemented the
counter. group_stats[].packets show the total stats, packets_hw only the
HW-datapath stats.

v2:
- Patch #1:
    - have rta_getattr_uint() support 8- and 16-bit quantities as well
- Patch #2:
    - Use print_nl() for the newlines

Petr Machata (4):
  libnetlink: Add rta_getattr_uint()
  ip: ipnexthop: Support dumping next hop group stats
  ip: ipnexthop: Support dumping next hop group HW stats
  ip: ipnexthop: Allow toggling collection of nexthop group HW
    statistics

 include/libnetlink.h  |  14 +++++
 ip/ipnexthop.c        | 129 ++++++++++++++++++++++++++++++++++++++++++
 ip/nh_common.h        |  11 ++++
 man/man8/ip-nexthop.8 |   2 +
 4 files changed, 156 insertions(+)

-- 
2.43.0


