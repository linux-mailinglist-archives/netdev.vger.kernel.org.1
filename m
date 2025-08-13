Return-Path: <netdev+bounces-213324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEFB248D4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5645F1B688B9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45B2F83A0;
	Wed, 13 Aug 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hwk+6iKa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4712F747F
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085761; cv=fail; b=DYnmHcDrmOh7cR5kuDSMK3YdbGRUOjczHpWjup5JClMoZY5Y72IrM2oyWlOXO6v7I51RO2rdDfO9tQnNkWKyiPNoJ/eNRblh09itT/8QsADwpKFN6OS9RYvIjEk7sPlcCVrzS8XSfyi/hNxTJEdYxB9hXigJhn5p1eyOBNSEFO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085761; c=relaxed/simple;
	bh=cWmE4ik2t33vHqD9S4WvQKASAqoRb9G/Ki3Iz4qW7dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSpKr49JxrwzJTQJBQtfESk+GFwS8EL+Pqy1FJ0KiKYDBdTDCwRskhkHSDkZUE7TQvUzJvIP7an3m1BVXe/ST6NrAg6cRq65Gm4KthdTp2etKg98dtpZXs7VEsWuYLkI8iYzU3in3Okrhm9SZUOUxdvY1FEHE/lnjVHq6QTA7JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hwk+6iKa; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Y7NuwrMFZ+C0fyol9ydCaSpmK2jwtw5F7Ir44HhE07+CJ6wmYPYMp0jnxpE4RM8b8HJ+kJbu7djcDxbFC7nqHGpRxXQ8/xa7x78ZxyM0rt5tNBi5TMzUqI/C2X7IvAt96bc1+vETSASenoeo0GguTFgNMW7yUQN0iLAYag5Pd1IhEt/4HCCDRNdc8VS+VrV/asPQdLLASJNccuVqyPrDv8lQLjsBXAeM5UwHq1u8MiEu8DZLMBi7kgvYPDC7+XR3VOBcGDdr/yhnNI1kSf2jYmxZUi9DvyXdEWe2/vg3A0kLLnllfhP/iUP51w15NAXh+1QeenoxlH7t1yaPwIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc6cz6m1rQzZDLXVkH16DvFQ6ppiJv9A5Qke9khXO60=;
 b=e7BxFSgOg5GoYVgHKzx4JdVFC3sIuve/Gbdd5FQv15rtE+6Y5sW18lTMzpijpW8mtp/Dljqmjoi+bY82eMe2ux53RoyA8CupHkkjxfQ3TlglnCuY54I06+Lzhl+ae/0TdN4cUwKUkZqSVgQIx+iGL8EkClRR2LQSd1px4DjpOC4LnfKU1ib1cRUMt2U6bVaKxc2m2F1ez+McWOVKCRnO1icJ9DxJGHzyCU5nA+WBNc9w9BjiP9j8mfVv0DEzvA24jcpEGkyEWLQSXn7w3LdFml1caCRGiZuGtiDu/zxYXvChWU2TY0pwcTS52NEsXpFvqDEtJUzISuTiDCmps7zj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc6cz6m1rQzZDLXVkH16DvFQ6ppiJv9A5Qke9khXO60=;
 b=Hwk+6iKaoBOspbrGI+c1cd0VjEBQ74MmBhOhXJ16p8+pYplNRtrYRiKVcPKZDARlHrgoTdpdkDylIZyL8SdkRQklLQSV+rhArZEu+ERvtvxikAu660Rco0XcbbehcxaBhmvuLItUXk9iph+JJc2p4d0GuamE1S5d5+7ZTzrWknFMUUuWs3arU9acDHgvtWHXeAsrQWXIxbraVsBuvZiQDBPLy3o2nxajn/svaX5h+w/gO+kmzBI1a6LLqnbGix+J13in5cX1KIMiB06N9sZbzD//JD1o2LHhW28HwgzPw7zxKylYYD0BNrDzpD8SQYHYYPuPu9OwsI5A2Q023hC1fA==
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:49:12 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::57) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Wed,
 13 Aug 2025 11:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:49:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:56 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/2] selftest: forwarding: router: Add a test case for IPv4 link-local source IP
Date: Wed, 13 Aug 2025 13:47:09 +0200
Message-ID: <78e652584c82d5faaa27984a9afef2d6066a7227.1755085477.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755085477.git.petrm@nvidia.com>
References: <cover.1755085477.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b938098-f8de-47e2-a9a3-08ddda5f6be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpXcIucVvD3Ch7P31OkqF7XbFugephXu3FwkR0++3eSNtNHU0NJvqS3KtjAS?=
 =?us-ascii?Q?oy8YcqcZg+LRyiMDdG86ylLiFxK2zLStRteqSHI3duFu6IzXFhhvQ6WOw/wv?=
 =?us-ascii?Q?SqgAfAqIFnN59Oh8/N2viFCKLOS3nJNvfOmpO+dUHguMWjCN2La2BTaxTf7r?=
 =?us-ascii?Q?V56Ci7Xrp73ZIYwEbpDFDN3GBfGU/X066aPovwa32mp+E7j0Db0JVo9LAA5r?=
 =?us-ascii?Q?8k6pWPmSXpMC2aTGnOmt2LCZh7HNUeISWB4UTTUChPd8ejZsiK/MPwL04xuw?=
 =?us-ascii?Q?EM4tmb7fgzA1joPY3qtWldkch2/WQasaxAqhdBKDZdhXHHOdbdpPpMvGHY1v?=
 =?us-ascii?Q?bot5y33Pfd9l9YNjmrDxFe8RCVyqq+rOPWPVg3X2ZS1gbBXK6zBoiw2ittcT?=
 =?us-ascii?Q?yilck+C8fgQYheKUApzOrhTDXCpIxqMc9Y4cbdLjleRPjByq3UJbPcYhkv0K?=
 =?us-ascii?Q?NWv9a6w6MmJBDDJK/6k5TdUAJT7zv9ChG49dWBYN8S4DPyF/5uzeRQMHz/qc?=
 =?us-ascii?Q?DOUNCrYvhBBHZXLr/l8HtRel/qDoiH22l6LxGY+8YW81cX4UJLlhdvZ5Dv+4?=
 =?us-ascii?Q?9umgkue6sI06oA7ykJnvHnVABl9isxMWBu+Na3IZ9zHBoOREdM0f9FYS2FJp?=
 =?us-ascii?Q?xfMi+TplEu8dHMGlZLoGPjnCl2UwdIliJJC3v9KpqmO5RIDGS1na6sC6fYXY?=
 =?us-ascii?Q?MIq48dJreMePoM2oOz9dntcaUuLhpqHBuhT4GQg5L7kqVdhKIHd5BS7yXcyZ?=
 =?us-ascii?Q?c/E6O5B3AHQOzvnU6M2yu5oRQiWK8K65A+9s0G8CCDA6kWxQfShpVzRdhBW0?=
 =?us-ascii?Q?Z60loeGgYKqZpRYhclqhEDU6bElaO5aA81iypblLiA0xvHzha1VyvSCmyZU/?=
 =?us-ascii?Q?BVa11SwhEm5fc+12lvJoR/6EbkKd+3ekd12HT6FAnEh5KEISEzLuV/D/1bdg?=
 =?us-ascii?Q?EpqPoQdiyDBhqZSKN1gtRFjbThCPqjysLU4U6lOaVW13Fv0QxZKzlHgSND85?=
 =?us-ascii?Q?f3VyCJueCCfugPGDnYbnR20ehPbYr/PBlb0Yfdb7/5vwvJI/Sy5QwHBjL5wK?=
 =?us-ascii?Q?Rpcr0c+9yj5e/BhyHQmIbWIqKytSe0SzYAVhIH/RDYuj7QvbgCgLpPAwiFzE?=
 =?us-ascii?Q?+dBkgaJjHzy153yIkIXqCWw2o36RW5RX74o5HE4mk9a4dCEy4S0Y1HoNZ7E4?=
 =?us-ascii?Q?304A7lnFw59IhdS99IvwrMjXioDHmPlEWk/kvVpHCTmmget57CNgIyr7t1YC?=
 =?us-ascii?Q?y/iCX/lrIfndNBtNEPc/pEL1wj3btJ84qXnVdFpvVA1axwTy5/PH6u0osE74?=
 =?us-ascii?Q?zYFf31LskGOJTeFrlvXSYEPkxEXboED6noXs6WUu2oDww2Y5gmpMsrkM6aSo?=
 =?us-ascii?Q?2WtBHtQ2YCqNs6FkjNtL9d8H7cKP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:49:12.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b938098-f8de-47e2-a9a3-08ddda5f6be4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

From: Ido Schimmel <idosch@nvidia.com>

Add a test case which checks that packets with an IPv4 link-local source
IP are forwarded and not dropped.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/router.sh        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router.sh b/tools/testing/selftests/net/forwarding/router.sh
index b98ea9449b8b..95ded264328f 100755
--- a/tools/testing/selftests/net/forwarding/router.sh
+++ b/tools/testing/selftests/net/forwarding/router.sh
@@ -18,6 +18,8 @@
 # | 2001:db8:1::1/64                             2001:db8:2::1/64   |
 # |                                                                 |
 # +-----------------------------------------------------------------+
+#
+#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
 
 ALL_TESTS="
 	ping_ipv4
@@ -27,6 +29,7 @@ ALL_TESTS="
 	ipv4_sip_equal_dip
 	ipv6_sip_equal_dip
 	ipv4_dip_link_local
+	ipv4_sip_link_local
 "
 
 NUM_NETIFS=4
@@ -330,6 +333,26 @@ ipv4_dip_link_local()
 	tc filter del dev $rp2 egress protocol ip pref 1 handle 101 flower
 }
 
+ipv4_sip_link_local()
+{
+	local sip=169.254.1.1
+
+	RET=0
+
+	tc filter add dev "$rp2" egress protocol ip pref 1 handle 101 \
+		flower src_ip "$sip" action pass
+
+	$MZ "$h1" -t udp "sp=54321,dp=12345" -c 5 -d 1msec -b "$rp1mac" \
+		-A "$sip" -B 198.51.100.2 -q
+
+	tc_check_packets "dev $rp2 egress" 101 5
+	check_err $? "Packets were dropped"
+
+	log_test "IPv4 source IP is link-local"
+
+	tc filter del dev "$rp2" egress protocol ip pref 1 handle 101 flower
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.49.0


