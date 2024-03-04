Return-Path: <netdev+bounces-77036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860DA86FE2C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38711F21D8F
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D324A1B;
	Mon,  4 Mar 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cq6ejebC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443623754
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546238; cv=fail; b=c1Pr+f0fAeEgrHlVvJAJPcfTRaohJAcEkHtSWea58J1lRYQqFu/5+8jKlWTB38C9TXB4ggEx/1U1l4loCMtBINf9zB3ncxgBjCQHBzm/MkpuPxuMrOEUVt2h/BiU7kBkV7NQ/5kdtxG0my5sHl3dB40vVTEzj8GLTayEab5yhyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546238; c=relaxed/simple;
	bh=3iNnPdHTnHEct85SkB1EKKSPDnTe4So7OKD6vpdFbk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrO2PlL+w6G5/VbiL2Mr5fLtGeNqBuVeulZB5qdWwSlA27rQ9uogvWyinuovlZfphZ9hayxQ5wWZpVC0GbK+LcOvHiGCYSEKLhBdvAv5C2s/14Jr5cf0BI6Xqra0OISxEHTgfC82RNtDxTksqwvJU57392pyKGkgFZMHnnXplwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cq6ejebC; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDZuaAhJoXEjxjPsmrUK//MbYuqwMP7YVBzZfv4QA+58x+Z9+qwfbTDzO+fQAPRPxEw5S3Et6e0i/9BabXEIO/tokhsbkSOq2Igeqc6nj6BThg0ExUWxicjAwNhySMvVKHErqawUM4AnPJ0+HT/XiH276xkN6TID+oGA8uFvbC+jszwAbZSiT9KFfbPrkHym8ZUAqGkKOW4zLTSMmRcTQS66cDFFv4+KDU5ZUlEaEtffi0rfOlQILXPLej2oSgQjVwJbldQhOlqbilOwp4ljyuIckursSCzH7nYTF6Ei5zUlXAHWAw6Cc0Ta+jaGA9R/HgK/4Ms1VtHjGFQ5FdeO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynuWtYF6ZxJUyPuJDuLmFYuCHx5Ft4Lo3YUFFcK/QXM=;
 b=RVR4r5VHEMCtifhC7uws6olOIYzpwt0whMyvIPXD40qF1M+czuYYtcb5GSrYIwSblyE2SGo8GsNXOhq6xezHUBlXyStkCwzC+Bb1q5tlKUHuFAkhAqzn3d85zWrgcr93Nf+chWfs83JuINQ4lx8fNT51f3+1bCoAtssHAS9JDgLKOsSV4ntCZip74SAnI8N6iLLTkgxcpG2PDhpUs1KQJ/PhjOCJFBc8t3mTITFTecypUvXibIwp8JL54gCx2/TGQQvbsF0/E4jnafRTdfGmSQbBbuhbHdsCjUPsYYhQ1jCG5QpwygBSnHomhfj1ADHC6eFg5PyxdpUICPPy9iEOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynuWtYF6ZxJUyPuJDuLmFYuCHx5Ft4Lo3YUFFcK/QXM=;
 b=Cq6ejebCP2YOHi4Q2/Q2PVy+azwh0xDozBJMTZxQolFcoEHNWRIoaP2K/ctWb7Rux9wJmrmWpdK5zfBaRhpbZT+GT+xECpA5gpi0VojSeWCXLfXZP0AaQWpanrWx22HXHy6muIHVamhP7hBC+BrUMOd5ZArJwHCD++KLZv86fCL63+4BKjd89+2/GNtnYOEQ3uwVr4FCDmiYCyzl3h/TFwGNjZ/XoB710QDiz1qhfpa3aKbH8nD45WV/x5gxrITyKXKmfCjVWNJu+OsejVDSzCvv2WAR07GJl3+rZfPSpsrGI13+YyTs7WF04XJFPZKe4EJPXVdi+GkTMvK8LGkQNg==
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:57:13 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::fd) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:57:00 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:58 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 6/6] selftests: forwarding: Make {, ip6}gre-inner-v6-multipath tests more robust
Date: Mon, 4 Mar 2024 11:56:12 +0200
Message-ID: <20240304095612.462900-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
References: <20240304095612.462900-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: f27ae159-fdc5-49ff-e4dd-08dc3c317717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9kbqONs0sBaqOqXXpVMxgcrgm6RQ51T0qAgs4Eew5+z6Jk3OGaAG49ro4QAzLw5m/kjx+Pwu8gkujpA2QGFm+HINtRQUmdcYY1l816XgiBnpk68wolijMosmv3MHMhzwnCO2QfMU5WdcSyBsPy0BypKKYAztU8dQIMPyNZlDgvof/vLIW46VVnujNIBrxBqss2LLJJmGybtdUvDLfm8Vjrpq1iLwwJ1zByO7mNcoFnv29VegNpObPteGroqCaZ86nvsCyEHRhRNs5oSEkvJwKcZBlYXV/1UxpZ88VZZhniPpRIZMjWg6h+tBewFUwt5Nevb2go6OKhJUU9XSBPj5782g38FI2zbh3ygdh+7V83pPSYWuZbtCwNNHOisfwGfv/QonTtTpiA9f8VaCT0hjhbaRQVIwYJoFRdfwtHbXDKii0ozDn+PJxtpq+nwHKipqV1z5nLlMLEilXVooslcMVS9/U3MsA7jX8V6jPtYBCHcNplfVwSyQM1OT+94lsT1FxtM88u1EaWoanqCzuKuIYuearJbiNhlSPrKK8/D2l8LRUlKYvANfOajewg1i4n3ynwqHZO7Rxle14ndaLlL59c3r0bnYxdIFUyooGaJs9lWYVpqhVfEjkitlkiG/G7S5+G/c29g/7OkBTj6rMsoB7lS/lYLgbd4YIG3l1mZwtTYa0jn7rVUBJ+06kd8cBkBy4wt9lnYNdg/dJUQjlWwZn7hoHvE6HH3nAL8j8tl3biMXAGn6gZqGOpO7ivc4gHv
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:12.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ae159-fdc5-49ff-e4dd-08dc3c317717
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

These tests generate various IPv6 flows, encapsulate them in GRE packets
and check that the encapsulated packets are distributed between the
available nexthops according to the configured weights.

Unlike the corresponding IPv4 tests, these tests sometimes fail in the
netdev CI because of large discrepancies between the expected and
measured ratios [1]. This can be explained by the fact that the IPv4
tests generate about 3,600 different flows whereas the IPv6 tests only
generate about 784 different flows (potentially by mistake).

Fix by aligning the IPv6 tests to the IPv4 ones and increase the number
of generated flows.

[1]
 [...]
 # TEST: ping                                                          [ OK ]
 # INFO: Running IPv6 over GRE over IPv4 multipath tests
 # TEST: ECMP                                                          [FAIL]
 # Too large discrepancy between expected and measured ratios
 # INFO: Expected ratio 1.00 Measured ratio 1.18
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/forwarding/gre_inner_v6_multipath.sh        | 4 ++--
 .../selftests/net/forwarding/ip6gre_inner_v6_multipath.sh     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
index e5e911ce1562..a71ad39fc0c3 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
@@ -266,8 +266,8 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::1e" \
-	       -B "2001:db8:2::2-2001:db8:2::1e" \
+	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
+	       -B "2001:db8:2::2-2001:db8:2::3e" \
 	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
index eb4e50df5337..e1a4b50505f5 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
@@ -265,8 +265,8 @@ multipath6_test()
 	local t0_222=$(tc_rule_stats_get $ul32 222 ingress)
 
 	ip vrf exec v$h1 \
-	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::1e" \
-	       -B "2001:db8:2::2-2001:db8:2::1e" \
+	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::3e" \
+	       -B "2001:db8:2::2-2001:db8:2::3e" \
 	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
-- 
2.43.0


