Return-Path: <netdev+bounces-188947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F9AAF889
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F34A7117
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D3211484;
	Thu,  8 May 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtaZKSur"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EDB1F582E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702829; cv=fail; b=GL8zGtdcGxX7lFZaPCbbWyBtCbch9v5Ck3lvgEyVOOKgM2fGauH0LklVO7Wov+B3v7yrPel1GHe5Zn6zrklB3PeTD72hkh+1baITfHO8BefFsmfn3eE085vtBOu8Q+IWHLZhvtxnc0aZZID18fS53SWYLGzG4RSwH1rJyM4F0OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702829; c=relaxed/simple;
	bh=qiQBZtd2xFwCXWN7bCeGmyVLyfU4VrqGYbzlSGJPHw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/8ZB3DewZ9FggI0wHIFkUVr18Zj3iUP2YLrZdy+MCYaxBR3jbtA42u7VoZV1fjWia6q+1HdAv2eoSKJ+VDEhPOw5EyjqMuxsdtl4GFYqJiHv8l0Qw6uC3mGVGXbdqy0u15xKXt81ZG77/ag/0uOI+npg8CUG7p8vqxg+N0p6PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtaZKSur; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoMDqrqi6lP0mUMBlUpxUyfcxHqpjoAQBd9LuHO8kOAmFR2/vUTkr8rC3DUlDwt7VIPWYTzaOl8Dzc9NPN1Qbu8IA372ZClAr8Hgrbp00tXV2wNr7hxXNMNaqn/PhBbgfYv3T7Xg5YyWtzA/NWJnkPKi0PAueZlVgKId7SPk0liwvS6vix8ghqnMKgYCTN34fQHXVn2lk0wWmAwGRUHWUJZG977/0rT+Se5J/hlQnz8Fxang+2WpP6m/RObyM87Zbv+/RNj9DxpQ88myaeHJgg+LPLvlK/06mvvKYSHd2aIaA3SPdO3pEgPBlwWfX/ntsVrauF1jFsIhq8FQ9Hy4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrD8mgnjlABlxYGDLeFZWCuA7rIYKQlcg3iLXXCoNyc=;
 b=oeSWi+iG7xNNrYZDdR1+1qzciZQiUpEW8Od3tj3VYB/E/FgThGhewRU1uK/eM+p9TiDSsXVDrsfFAlQxeJBTs3rZ7XAKwGfNlazEzKPzU5/90korHxZ4L6KJbTTCfkFvWrWqGNQyBIHaP0dY8DRLAEO1y2qWPXwBPAd6mG+JmzTwB6AHTitS7ClDww0ilMQy/lIHE45+KRcIdKA2+HGawsi+rIdr3P7jtexzYwJ65S1zFebLtHE0fqydSKuQKKX1M0K5wf2YYnJy3KayBs6p+JZkxQHC/7RTPMO0CNzRmOxfdpKXDfLugQGCK3pTQspPUSmC5AJxZ2PounK/vYTESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrD8mgnjlABlxYGDLeFZWCuA7rIYKQlcg3iLXXCoNyc=;
 b=LtaZKSureOKQZbwiWAgLmIt9+5Z+1pfxDHwpvB9HEbomp+cWe/+MoAqV0nShcW/W9xRNH5Ezt2uSdJJFPkFCQNUQQfANaYvO4M5+ah/jivTdT1OZivLGHLIA3t2S6bykRYcO8CHrwDqPjvH1cRf+bZlCX5EbUoppWJWtolf3fFEl8MRuXnH84llIdn6cnu+2cng0eLL2CPfvv1YCk4osJ1P+3HW3pY0/ZWC5TXZYoGTQ4LgUZLciBN+XyyCj+tpVyVW3Lzw8YoHpPUXS2VHkM4c6bZMRxVPpPd0bJn/iUOk0UukPwG2YyPwHHE4IvCZyisnHuilO9Oe37nLdKB751Q==
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 11:13:41 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::9b) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 11:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 11:13:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 04:13:27 -0700
Received: from shredder.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 04:13:24 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	"Ido Schimmel" <idosch@nvidia.com>
Subject: [PATCH iproute2-next] ip ntable: Add support for "mcast_reprobes" parameter
Date: Thu, 8 May 2025 14:13:01 +0300
Message-ID: <20250508111301.544391-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: bce63f0c-c3aa-4ce2-b640-08dd8e216374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BarJFdjUyABc3srk44IoPvNEpYe/iAsgEu22yKAcbTNB/SbEm4t2j+6jAXbS?=
 =?us-ascii?Q?qFxFxWETc2xwrkDcmHZnkLQ4h0nFRxNG0uuUlqxfpD8I7jXsrzhrdYbhJZiN?=
 =?us-ascii?Q?42NNB1q5C4/+htFIR7xRXWucJWKCjfx8zssO+fvZyrf8tZREIO65cRAxhddx?=
 =?us-ascii?Q?vw6wiqUAryksa6ddzubHYyNk/Cu4VAVeLTlz7HOzUEAe6OMBOObyZFQ3FWMH?=
 =?us-ascii?Q?icou9s64geo276JhexusasEa+IVLOhyyNrULqT8r+GuS5bJpTFHSEIZ+9G6y?=
 =?us-ascii?Q?vcq9WhpQwuOzO9NNX4gxgpS9gXWLPDCLML6diXA+53FLci9K4zlGwn8MYrOp?=
 =?us-ascii?Q?OOI8BpD2JUbjlXwDUbGh3W+ra+r/PtQtlaYCgVBqloZY6MXDg5bcYbntyAwQ?=
 =?us-ascii?Q?IE3UIiQuThduu6jsrKjs7APpad2D55rYYLcG8k0x/PyjQUe4pyld50Rf+oEJ?=
 =?us-ascii?Q?WZPVjVnEOCueAaIDJqo96ZbgKZ7OUIkbM01YoffxN6DVrSFyf4cQ4D4kfyek?=
 =?us-ascii?Q?zrdlGjguvE3yjDtPH+itP23zogHqfCJ+zoYqgktArJwBBZrMh9jTOkLtXbYi?=
 =?us-ascii?Q?8oVrupVQrwh+TLlqULSqw6XzRbM1ZdNk5ZhEFJ96OGsUDU4KGQuksPD/gcff?=
 =?us-ascii?Q?JKCI2kN3DOMmNlyJ/czEKNk7hfZSW1AfxqahTbdtWna/C94EFEH4rP71+TUg?=
 =?us-ascii?Q?C7XHntbqbBfoA3tRbLJvbAysH+9o0Vqv+ZEvnbWxMBoJbaRXy57fYKMhrB7p?=
 =?us-ascii?Q?u4q4iP07BwHNWrx8nqcNZc0mDh7YKXtKimWGZRFcgC4rOuP7OSeLxMK3izE3?=
 =?us-ascii?Q?RS/IiKr6dw9Dd8iaUwBNqFe5hqK23W1D1TYYARkBgGcvD2OO3Ltg+3QF4+Ou?=
 =?us-ascii?Q?9EqIEiNwC8UzolVzJki9FoZ5DO6IuRZAKy06nNdmY0TtT/NiyHQXa2rvfHfS?=
 =?us-ascii?Q?/HRiCDcj8mlEtrUOoFF00Ruv/Njv94BPj3cX1hxBNOh/dXOjnYZMsSwSKbcs?=
 =?us-ascii?Q?g6z0TVP9P53095fg7nupb+sNf7OhsInwioSK9f84J0Eis4hIn/xkbHjtuk6b?=
 =?us-ascii?Q?UCVDCawIUAJtrIyU12eb7xy895n3aO4AaV/Py5/70JNG9H2ZCARlctlcbzVA?=
 =?us-ascii?Q?9dPMac0v6kVTr6rrXjeJqPCOLUPnVTRDpHHxG2WlJrE5ZOiAWkw1SadBeFoC?=
 =?us-ascii?Q?lNgNrSQ91LUuoBaLV3jkhnOM3APzS7wpHHOwryr3Chj7pSJShVikD1Yay+cM?=
 =?us-ascii?Q?F1dBkR/MMCZNrRllN/mKonJ0nSUafG9iGpF/xErg836BhmQC6w+tBaLDlj45?=
 =?us-ascii?Q?VaaYPcqOWDx3XCsfHwkO4k/l2Gq4cn8w/fK7tnV0zWwySwyDJSpFo90Hp0LM?=
 =?us-ascii?Q?FrqtASTy3UDLOIQBGdd9ZdPObwOnMiT9juu3rSU5SKdiLmITPHemRQbQK4BY?=
 =?us-ascii?Q?ZhiNKubX+kV4EJ0EPoXIYQdUJbrnzkL6zXXdpLlps6EZwQZ7WunC1HrV8auR?=
 =?us-ascii?Q?rcqp4fPtEuwLdrKErxRyWo6DewCkwmbrv2VA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:13:40.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce63f0c-c3aa-4ce2-b640-08dd8e216374
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

Kernel commit 8da86466b837 ("net: neighbour: Add mcast_resolicit to
configure the number of multicast resolicitations in PROBE state.")
added the "NDTPA_MCAST_REPROBES" netlink attribute that allows user
space to set / get the number of multicast probes that are sent by the
kernel in PROBE state after unicast probes did not solicit a response.

Add support for this parameter in iproute2.

Example usage and output:

 $ ip ntable show dev dummy0 name arp_cache
 inet arp_cache
     dev dummy0
     refcnt 1 reachable 43430 base_reachable 30000 retrans 1000
     gc_stale 60000 delay_probe 5000 queue 101
     app_probes 0 ucast_probes 3 mcast_probes 3 mcast_reprobes 0
     anycast_delay 1000 proxy_delay 800 proxy_queue 64 locktime 1000

 # ip ntable change name arp_cache dev dummy0 mcast_reprobes 5
 $ ip ntable show dev dummy0 name arp_cache
 inet arp_cache
     dev dummy0
     refcnt 1 reachable 43430 base_reachable 30000 retrans 1000
     gc_stale 60000 delay_probe 5000 queue 101
     app_probes 0 ucast_probes 3 mcast_probes 3 mcast_reprobes 5
     anycast_delay 1000 proxy_delay 800 proxy_queue 64 locktime 1000

 $ ip -j -p ntable show dev dummy0 name arp_cache
 [ {
         "family": "inet",
         "name": "arp_cache",
         "dev": "dummy0",
         "refcnt": 1,
         "reachable": 43430,
         "base_reachable": 30000,
         "retrans": 1000,
         "gc_stale": 60000,
         "delay_probe": 5000,
         "queue": 101,
         "app_probes": 0,
         "ucast_probes": 3,
         "mcast_probes": 3,
         "mcast_reprobes": 5,
         "anycast_delay": 1000,
         "proxy_delay": 800,
         "proxy_queue": 64,
         "locktime": 1000
     } ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/ipntable.c        | 21 ++++++++++++++++++++-
 man/man8/ip-ntable.8 |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ip/ipntable.c b/ip/ipntable.c
index 4ce02a315fe1..54db9b62c837 100644
--- a/ip/ipntable.c
+++ b/ip/ipntable.c
@@ -40,7 +40,8 @@ static void usage(void)
 		"PARMS := [ base_reachable MSEC ] [ retrans MSEC ] [ gc_stale MSEC ]\n"
 		"         [ delay_probe MSEC ] [ queue LEN ]\n"
 		"         [ app_probes VAL ] [ ucast_probes VAL ] [ mcast_probes VAL ]\n"
-		"         [ anycast_delay MSEC ] [ proxy_delay MSEC ] [ proxy_queue LEN ]\n"
+		"         [ mcast_reprobes VAL ] [ anycast_delay MSEC ]\n"
+		"         [ proxy_delay MSEC ] [ proxy_queue LEN ]\n"
 		"         [ locktime MSEC ]\n"
 		);
 
@@ -223,6 +224,17 @@ static int ipntable_modify(int cmd, int flags, int argc, char **argv)
 			rta_addattr32(parms_rta, sizeof(parms_buf),
 				      NDTPA_MCAST_PROBES, mprobe);
 			parms_change = 1;
+		} else if (strcmp(*argv, "mcast_reprobes") == 0) {
+			__u32 mreprobe;
+
+			NEXT_ARG();
+
+			if (get_u32(&mreprobe, *argv, 0))
+				invarg("\"mcast_reprobes\" value is invalid", *argv);
+
+			rta_addattr32(parms_rta, sizeof(parms_buf),
+				      NDTPA_MCAST_REPROBES, mreprobe);
+			parms_change = 1;
 		} else if (strcmp(*argv, "anycast_delay") == 0) {
 			__u64 anycast_delay;
 
@@ -440,6 +452,13 @@ static void print_ndtparams(struct rtattr *tpb[])
 			   "mcast_probes %u ", mprobe);
 	}
 
+	if (tpb[NDTPA_MCAST_REPROBES]) {
+		__u32 mreprobe = rta_getattr_u32(tpb[NDTPA_MCAST_REPROBES]);
+
+		print_uint(PRINT_ANY, "mcast_reprobes",
+			   "mcast_reprobes %u ", mreprobe);
+	}
+
 	print_string(PRINT_FP, NULL, "%s    ", _SL_);
 
 	if (tpb[NDTPA_ANYCAST_DELAY]) {
diff --git a/man/man8/ip-ntable.8 b/man/man8/ip-ntable.8
index 4f0f2e548a21..56108afe6586 100644
--- a/man/man8/ip-ntable.8
+++ b/man/man8/ip-ntable.8
@@ -42,6 +42,8 @@ ip-ntable - neighbour table configuration
 .IR VAL " ] ["
 .B mcast_probes
 .IR VAL " ] ["
+.B mcast_reprobes
+.IR VAL " ] ["
 .B anycast_delay
 .IR MSEC " ] ["
 .B proxy_delay
-- 
2.49.0


