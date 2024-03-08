Return-Path: <netdev+bounces-78871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C9876D26
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D031C2179B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D11DFE1;
	Fri,  8 Mar 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vaj5tKT8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58E1368
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937125; cv=fail; b=AHfMSGD89Lmpeo0ia/AZukjlU+gXux2fRBDB52/le7QslWmWENqMzZ2M247HcBw13NZXUBU0U8qohr1yBwn65ybmY2PYIBFbiaVAf7zwJr01WA84hKLDogRTWLbcSwjeD8JzoLGRGGlZpPp9rVgVSTHWjNyezZn9u7r3RcMDXr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937125; c=relaxed/simple;
	bh=8hfEe9wyT2/tTAS02a2pX0UVQMp4IOLRxgBA8bKCgoE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CINTDsl2S4RufwwocK5r0kgpUlF2ee5T2/Ld9s+827eohq3m6scsvMEkuGAlfb7jZcgGBmRLWvzzGOw00OQDEcMfpS/cvmEcnMgWwBsNLNgzhDQm76QG1TZ/r5nZDhODNc9SlGnXZqfqvZn7+Kxg9qB84kPsJFLSLjBRrhusRq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vaj5tKT8; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM6n32s19mveuX2sXfbWlGVgo591cd2xqgwWdoLBHe3Q79F5FEmxgCLzQYf6Ai1hJqeOELigTELXd1FhsJy7A+wS4AeA/nkePaHoDutA8nX+9x5Q7GD9Zzdg9Nb8OFeIM/rAiIy4e/v/zHVtpVPKX1QF0ujg09FOYwgSnbQBgff/IetrZlrxmOzXkg3oU4kis6HOUS1pMSES5bGcw2lKAQAthNlx+NpTpx1tGTL79ILMB0OU/v06PStTGttTbVoF2qaqsZ7hI3mnZKlJN6tMTBAAES5/5WLXdzEYmCDQ/Bwdu2yv7y1voNpe55nrvcgH//2p7xSlaitjo9xa4jEpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKWNy15h0s0ckTXgPO/vz3q7bswu/p9bezde2llcEyU=;
 b=jT8seIG38kZ2XB47cSgD49OadpI9O+dBVJrhORiAzH22rXQvpPvQt5vOmXZAub90WpdrxdfcqWoVp3I9v0zpO0tmTX5q8f4CxUEg18YhQkyx8J5Sa5z1HiTiNfxWx0snwcY9s6O/0EGMy7WKY/Mn6oHeaPb4HTC8DL72CWwKRhMzbkob2dTooTyA9IDtrYmGFPw1MsS/ng7qKe4S9tDrw6KDr1imWIHMST3Gi2yjrZs6+jS2s7f3WiCN0ABx0ITGsoskvORSVSYKgqoxPLRIgfrdOrTElM+zhaQ2miE4L84+7IHs4zVK7mgdMqKJRHeP2xf5gmLXkrpkaQqbG2/R0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKWNy15h0s0ckTXgPO/vz3q7bswu/p9bezde2llcEyU=;
 b=Vaj5tKT8CXATwEkquJND89yCY3ZnqYKu+6etUFalZ6Dg3bRLAP2a6cp/BEDxdIVHdmlsQQQH9r87yOpbMw1OvI+C8iPznRD/SKqQ7hppH3yez/YcnmfvHg7M37Z3wiSRbQwbXQheAFIZjyO3IGa239b4+4oYQAHwf1F+huAppAxFD/k43wh+Fgjj/UUpJy68TCszKULnRhTEL6r3nOvSlLyf2UXsPkIJVAAAeVNORrUu+PivQbOgBDJURHrEF0IuRlxik3H8sHanR36D11QZXfIjgoFAj3WNDCFU7PiZViJG6JuRn4MgIvbjLJcHURwmU74zkTun7nz+Yz+xWTafcQ==
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 22:32:00 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::8f) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6 via Frontend
 Transport; Fri, 8 Mar 2024 22:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 22:32:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:31:41 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:31:38 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH iproute2-next 0/4] Support for nexthop group statistics
Date: Fri, 8 Mar 2024 23:29:05 +0100
Message-ID: <cover.1709934897.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: d85afd2c-3f25-4fb7-44a1-08dc3fbf923d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UGp9hvupiKq6DaglD7jRk+M0AMDRzkM4W2WSYQwfEMx0RNq6UkWGJKj+2TP0bwga/vRBuV8i3+bxlMOqlvRsvZu2rHDElYYSLvR/+xiCnY1RDVxG8J+SyZlFieBuHu8qq7VIm6Qqlq2d1O8IEcDEqrL7ZAxtlTLt3XEZiSSHLC5TO1+lYgAHjyYnFw6q/xPi/zZeLQFP6Q6nqQXjH5yF0RPNKVFs//4DEOCNSg5oL2Fii9aQHhie+5ODMIRI7kxS4HFcjIPAnPswNd1E2PGEAm09vc7iKF72NelDeEkgmBl69zRyqtX6RmimcfFQGbQH1YUldEEjXKygDclo/v9mTdFj4/j9NYY0EcIGZp1plr5ZA0myf9SLvqW7RMUNIFDkx91DGQ25oKgFd6WoBxadfBhAC32KKyV7PlRdY/IiCbs4Psbuoo7omfD1NIf4ZH2eBGQCcgFMyy0kt/SONP8hsrK2BpBIX1tTYQv+x9J40f4iefs2KK69hFOVMNtrsQFauPeGIFiqRw6DDaRJxtIW3KCh1ZyWSt/7gwxkwaRZQljLDgdgrDSkpBYl7mK0+N8kpMqXHyb8py6/cDz7efxR+SW/ETSVMMCVzUOxSc1kZKC5KCben8Efelbt45ZtoQ/IjTZqVnL/1GAvu9YZ1FYVamui7ZOEbZoY10XnpbXvn2kK8H4T9VfKQ1oOnfVVgAZ3GiHlyOPiZcNb2ydeS3z56TpbAuyOVuWn7D3WXCOK7QUKtZdpSW9IlOkD0RQ8z4+z
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:32:00.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85afd2c-3f25-4fb7-44a1-08dc3fbf923d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

Next hop group stats allow verification of balancedness of a next hop
group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
'nexthop-group-stats'"). This patchset adds to ip the corresponding
support.

NH group stats come in two flavors: as statistics for SW and for HW
datapaths. The former is shown when -s is given to "ip nexthop". The latter
implies more work from the kernel, and possibly driver and HW, and might
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

Petr Machata (4):
  libnetlink: Add rta_getattr_uint()
  ip: ipnexthop: Support dumping next hop group stats
  ip: ipnexthop: Support dumping next hop group HW stats
  ip: ipnexthop: Allow toggling collection of nexthop group HW
    statistics

 include/libnetlink.h  |   6 ++
 ip/ipnexthop.c        | 127 ++++++++++++++++++++++++++++++++++++++++++
 ip/nh_common.h        |  11 ++++
 man/man8/ip-nexthop.8 |   2 +
 4 files changed, 146 insertions(+)

-- 
2.43.0


