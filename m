Return-Path: <netdev+bounces-77035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B786FE2B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014728303E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC7249EA;
	Mon,  4 Mar 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBH7Ev3k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D3225A6
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546237; cv=fail; b=K0UD1Q+iGX8+JeFQR+KXglbd0m6aPjaVQp66pYzNUDQ8nih4Y9gctmUSS9zIPWO3e0OV6Ssp3v7J9lrM5pfMXw/2yLCXqjIY309KBNl2fiDZtIFwOoJkhFJpAXdA7Ik1LOXFYXPzLJu3SlkG3V0idk9OOenUljKZNuFaHecxPpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546237; c=relaxed/simple;
	bh=KYA2Em21jamBfTuxFJmia7dnAVc2hr8wioh54mEtJrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obtGS2ppa+tkk22BuVKbVPT5CC1+SgYNZmDMYX+v4Xf4hqGyQjoiHCs9FzUio9H8u7+djntqCL/xKlH/2MDWUpVWtRLMnasKe/IwkFzEusO9srpg/gOhfx8Se9DvUvQyHoNssJKf4SRnbSjMzAdm5YLNILoXTRrtbmzZbKFjdOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBH7Ev3k; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy87PH1j9kQgUkzMYzOTaBEO+FYxpnvtbnBS0nvVvzq8ujl4QlAlfkxChFu8l9trbsIBJUJZQ9Ar/NkhCgqQRj8wYRN7mrh36MwevJIvOAgxyEqhyxH6egdohcofuvm2TpstCvpM7C8utmmByJGV/zth4cK9PYF0uKM9ylkbVkNARA3aald8Aj5MlapGQHstcxhnZVO9qUHkskZPSqVb2YLXSYRZLSVd7/IU+j2etGBVHSqu/5g5zWPtWu2X4kMl7qkgDcRR2t3aPk+OpC5vcuBRyfJDcBdaXiqifelu2WJ13I/9HwT1yXdgHzwmBBKCRiw3mm7+wQM2fvAbpqIdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1ZKHthDUl3sESiNVTLINnWXQK/Nletqc90KcTUfO34=;
 b=bJi5l7qi4AvIQDZNCTiTKOXfxslUVjPhiLmMyyVyjfRlqGkbq6HhYux8I2oX2RA2JxoXdJn/vMYj1r1infus+3bVKmbHvU41zKj5sonaFgYRoD/FE4Cf0hpJvnyteyRPDlDtuiQkyPeOTySL7ITyD02n9G1sOoOmM8kAsAE5ES02VY713g5gqPJdGvjs2HcdrtpGgBqQNvcPICFXZpYmv3AVEYLcwHYTO23wSTV7FPJg875DyH7vb3jgwVappoK7NPvgIL2YWhtrXEVEvMXdECNtylU6cQf7IdBx5DMucxSDxW1XMfSIvMu2p/8qPz5qTJQSYkL7CoSDgFherKNBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ZKHthDUl3sESiNVTLINnWXQK/Nletqc90KcTUfO34=;
 b=BBH7Ev3ksAXOWdkeVAtqoKRqnCEufRVbXc8mxB6JZ2WQ+LWp2K6SuyzPDK+W9tKj0SRr8Xr9IY8LLwgwheDe+g3vQitJXCBiBlcrq6UNhD5cSYWTrFl0wlnG9F4ALWxnko2icq6hP1twjXWaMBtRIppIKLJRdBLZFHvU4mKKTTYwfy4AqpeyQW03E5cEk6IbjaDuyS2+Y72s5QTHl88qIb+RGnUwVUOty8NR6elKAKkYHd76WB2dKDZpZcy75Buz/1OaGFsGi5UGvCEc4r3w3NgV+DPOJMKvHPBwxt15Ruus174FHJco7jOwxy1VWiLqL6mbtwWwyFvwC3vHfAZOTQ==
Received: from BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::33)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:57:10 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::16) by BN9P222CA0028.outlook.office365.com
 (2603:10b6:408:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:57 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:55 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/6] selftests: forwarding: Make VXLAN ECN encap tests more robust
Date: Mon, 4 Mar 2024 11:56:11 +0200
Message-ID: <20240304095612.462900-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b856db-4c17-46a0-70e9-08dc3c31753d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EdkcDE7HRaDsgOgzTahX4Xk2be56Wfe996axQGUjfJIDi14SAXqh9qAzhBQdDlz5dPyiBDe9sPnq6cWWWz0dTRowLBnJM0FwaV+qgV4SmtLRuFK3I+qZFTXSFT6DTlo6eBtAeK6eoUFlzJXL8ZPbcN8lVQGlQbB/tD7GDB43oc3i00qlow/epdrrWr0tA5SfkWK3sUDy695j2hhgNMFMxmwBli5YgbxOlgtOmhrliYrjMKCQzdZ7m+qCucY2xGhOBF17FDYps1YOcZ5FmFu9iBxzOv+rBPENFlTVOhTmXhbCvDwBORSiqnJmLUl6dNoh5rrodLGX32Q/Vrv6/aDOV4LTJJFQ1FWCcpjlohs0Cg5vZR3iHOvlTdb7hXFKy1mAn436c/xxnNjEUV+MZSi7k45NTHIXWdjvtZnGpx7Mm9z38VEJ8Y3YoXMeByTKyYoedKxMjeDlk9qIz4ilDNS7Y4lmfHh0E0QWf8Uoy93iXwHjQCZZpguj31vQ2xT04HnVIS6ots9N+I1H4BKXDhlG1hvw5/kKJGAIsHYt2l+tmhU6h/RXcONB14RKID68Cfl33TQu382Pm5hwcsUpjUfr+dXs5CYfTj41I1pOnwmg8fk666/337o2/XFKP3J4K3DtHJ0Vub4HE5UTtEpsGx/rSGMx7L3jEiZxrroRcdRJ7NE5AMcKaLHZ6qASGZR3uH9u4tW0koq4C/+vvwO+B307dIXh/v6mZQeH/y9+RzQq7UtF8nfVvhfBQgl3nyPvFMc6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:09.5761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b856db-4c17-46a0-70e9-08dc3c31753d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

These tests sometimes fail on the netdev CI because the expected number
of packets is larger than expected [1].

Make the tests more robust by specifically matching on VXLAN
encapsulated packets and allowing up to five stray packets instead of
just two.

[1]
 [...]
 # TEST: VXLAN: ECN encap: 0x00->0x00                                  [FAIL]
 # v1: Expected to capture 10 packets, got 13.
 # TEST: VXLAN: ECN encap: 0x01->0x01                                  [ OK ]
 # TEST: VXLAN: ECN encap: 0x02->0x02                                  [ OK ]
 # TEST: VXLAN: ECN encap: 0x03->0x02                                  [ OK ]
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh     | 4 ++--
 .../testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index eb307ca37bfa..6f0a2e452ba1 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -495,7 +495,7 @@ vxlan_ping_test()
 	local delta=$((t1 - t0))
 
 	# Tolerate a couple stray extra packets.
-	((expect <= delta && delta <= expect + 2))
+	((expect <= delta && delta <= expect + 5))
 	check_err $? "$capture_dev: Expected to capture $expect packets, got $delta."
 }
 
@@ -532,7 +532,7 @@ __test_ecn_encap()
 	RET=0
 
 	tc filter add dev v1 egress pref 77 prot ip \
-		flower ip_tos $tos action pass
+		flower ip_tos $tos ip_proto udp dst_port $VXPORT action pass
 	sleep 1
 	vxlan_ping_test $h1 192.0.2.3 "-Q $q" v1 egress 77 10
 	tc filter del dev v1 egress pref 77 prot ip
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index ac97f07e5ce8..a0bb4524e1e9 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -616,7 +616,7 @@ vxlan_ping_test()
 	local delta=$((t1 - t0))
 
 	# Tolerate a couple stray extra packets.
-	((expect <= delta && delta <= expect + 2))
+	((expect <= delta && delta <= expect + 5))
 	check_err $? "$capture_dev: Expected to capture $expect packets, got $delta."
 }
 
@@ -653,7 +653,7 @@ __test_ecn_encap()
 	RET=0
 
 	tc filter add dev v1 egress pref 77 protocol ipv6 \
-		flower ip_tos $tos action pass
+		flower ip_tos $tos ip_proto udp dst_port $VXPORT action pass
 	sleep 1
 	vxlan_ping_test $h1 2001:db8:1::3 "-Q $q" v1 egress 77 10
 	tc filter del dev v1 egress pref 77 protocol ipv6
-- 
2.43.0


