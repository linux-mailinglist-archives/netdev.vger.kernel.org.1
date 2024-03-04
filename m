Return-Path: <netdev+bounces-77032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2C86FE28
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6417C1F21DEF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823C225CE;
	Mon,  4 Mar 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A0got25k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B204225AA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546230; cv=fail; b=I1UG7M8VXOz1wOxxsh+QSMax/XHK3dNQKILnX1DoQeDaFRe0snZuL0P2eZaJA55ke8I/JMfRNifiBCNRP7HTOznMiH/p3UbAbMET862VWYDXmcHFaxcYeZh/EZCMkC2Ld68w/mfDSls7BeiKX2QuGgz8UWo3VugPu6yP7JOralA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546230; c=relaxed/simple;
	bh=lHRgzlj0LF3R9O/Dne2BSYklSURAecIZhLsJdVJqBcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEZY61Ynre9VmWOUE7DbdOSQfT8N/cZP91ahIyV7xUhSc553qsPOYNaaxu/t6I5iBX0/CRZ4Z8JtlZG18PxIMQ6BUj9UJnQLE10huDDh5YGRKEV7/SzVGsmsosc6rcRuowsjmigfFQbyk1PPi52sQDF4OP8L5M4z2wtXZL+YylU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A0got25k; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3wJYZdQ8gC4ZXXbYHDwDdlbfTdFzNKKpJO3hOKN+UrZEYkzFZy4k/G3Dr0WcwrJp9ubWdTusPYMvBAsknlSCGxTOQ4T/gbvPEsT8nS/2G2fqFdiNzS5zMmPazLdBrBhaKwkxdOQezJ2VPF5CSDUGWbdO0akZfCySeffHY+RHX46J2in1sZVVk2Rw4eBYJ9Sg3jrMqOIyJDuKSTXAK5LnicTbhDwWFAd6ICFjIoZ80hBV+vSP1d2oqGLP9CGciqwX5F74i6rNdMTRcd7nqUOjLxrFvHCb+ipUJpWnWZtYl/R4yCeFKrWmByoiBsoRMQ0NOPQ4zYqKFYfrRbu3qPPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9bLnIQDvAYezug//eIHee4c+tzG004AullBxxsw7WA=;
 b=M9/oTjS/uGjoYFEobzZiTIHABKpHS0bUR00nync2rPL3M+wVdwBF4GfM/UABFpDy5JrHbCY8lKMSJKDTlTdatuyUJMQM08RvEtvCN6FJ3OltFH0DXN9W9BbI2Wkl5wrUkX6MyLORsRqSOuELvAfCCgYVeUBb6sdAU3E+WXih+VMiOBAGF2MVXAXohYlLsPvKT+RkQwW1FQZ1sSexvB3kySIoCInmTMK21+cNbquzirktz1X5zVICI+Z7+ZpdRBj8IloRasC7H55FTLIlmwD/leLWFBF1wWNDQAvQ8mXoqzrSZi+QT4G8lAyJTirXIdYfWvi06R0W5ljV58yj9K4P0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9bLnIQDvAYezug//eIHee4c+tzG004AullBxxsw7WA=;
 b=A0got25kRKmp3QxWtMC5ilIEba4NqLULYP9wL+NPvQjVMWSsa+xZ8p+Wn8uwWcAuceVxkVvADwvX1EUz8z0QdyKTus4MECtxvs2DUPTbV47sSXcGcit3EsTqJNhIFT1pU901mgXIhHSBT7kWTbKwq1xmbGMQkXhtJib4BiMF4y8zzSLw+fxk1b7QnBLrQffEDo866m9hZtB/aU3nP6MX8A5o+HohNPeP8yRE5RWzDwsNeDIEhOaMhXStrg57o2OBCKwurow7OXkpH81C38V8Rg22hzeKk2Aqk0ZAh5WwfxbEzWalAVlPkG83LdrJhJhZrIcDshHrEGVPm4fuirIfaw==
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:57:05 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::e1) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:52 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:49 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/6] selftests: forwarding: Make tc-police pass on debug kernels
Date: Mon, 4 Mar 2024 11:56:09 +0200
Message-ID: <20240304095612.462900-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 426f2a42-31b7-42af-d67f-08dc3c31727e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mkiMD29oMprbGQ3GbYG8jCojXFv1IgBsCF8AGy3BBjjTk9W5LV7yd3/Bi83q6ckhaORtzRjVNgI5P4kQ7EtxYqYrZyukIG6BHS45Ldl0puFw/yUqEw/V80MiBNbChzvK3zUWD6e6GuGEVHknQhEpqD3Qy0G+AX2v5iwoWRbpB2HdFE/+0PeMvrx+Pdt82JHSuUQYqMruGqmBhzSL1Y4zU18KmNlBnUdjwGCk28XGBbhpEkKYPvCMAAd4INMkxPPUDTAtQ2sQJawP8lkb0G21POYiPVmGW21FhUtw2s1IF8V5jgmPtSgg3Q9SSK1GlbrToYvdzxFpbTuf/laWOOR/hYpr/Zo3Bg47hcM17Dj8fpiN3ejjIDeX0VMEmwHRqPaFRnzX5pstSilEbuKHTR220kZuADRk0tJKknji8LxB6K1anEiP2QDpc255Go8kYL6WdLkk46iUuc/swmdWMLPfUmYe8dyD3rxsn+TxXGADu66hqhhJNMCa0ARXX7/pFY8jI27j627UIOdFy1Ge7FhO2OI9ca/PzYqfX4NhxRtYeUVLai5TzFqkC8CsZ9aMIJ7oNPwcJBNdAUe6AQQNpRZbNaz3AICurJfXeAX9awVxUxk+jx28mOkNRoSEvgO7frRrqsiGVBdOJ1yAD++egpLXCT8n165OivtMzg7wK3/N+vv1DlAnir3wcIdBHqjZEWjmu6NERvjhs6sCn5poGqADSXzzYDJxVz77rubil6oY3AdcvTIgqrAyBDaL+gT7r8eU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:04.9715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426f2a42-31b7-42af-d67f-08dc3c31727e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737

The test configures a policer with a rate of 80Mbps and expects to
measure a rate close to it. This is a too high rate for debug kernels,
causing the test to fail [1].

Fix by reducing the rate to 10Mbps.

[1]
 # ./tc_police.sh
 TEST: police on rx                                                  [FAIL]
         Expected rate 76.2Mbps, got 29.6Mbps, which is -61% off. Required accuracy is +-10%.
 TEST: police on tx                                                  [FAIL]
         Expected rate 76.2Mbps, got 30.4Mbps, which is -60% off. Required accuracy is +-10%.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/forwarding/tc_police.sh        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_police.sh b/tools/testing/selftests/net/forwarding/tc_police.sh
index 0a51eef21b9e..5103f64a71d6 100755
--- a/tools/testing/selftests/net/forwarding/tc_police.sh
+++ b/tools/testing/selftests/net/forwarding/tc_police.sh
@@ -140,7 +140,7 @@ police_common_test()
 	sleep 10
 	local t1=$(tc_rule_stats_get $h2 1 ingress .bytes)
 
-	local er=$((80 * 1000 * 1000))
+	local er=$((10 * 1000 * 1000))
 	local nr=$(rate $t0 $t1 10)
 	local nr_pct=$((100 * (nr - er) / er))
 	((-10 <= nr_pct && nr_pct <= 10))
@@ -157,7 +157,7 @@ police_rx_test()
 	# Rule to police traffic destined to $h2 on ingress of $rp1
 	tc filter add dev $rp1 ingress protocol ip pref 1 handle 101 flower \
 		dst_ip 198.51.100.1 ip_proto udp dst_port 54321 \
-		action police rate 80mbit burst 16k conform-exceed drop/ok
+		action police rate 10mbit burst 16k conform-exceed drop/ok
 
 	police_common_test "police on rx"
 
@@ -169,7 +169,7 @@ police_tx_test()
 	# Rule to police traffic destined to $h2 on egress of $rp2
 	tc filter add dev $rp2 egress protocol ip pref 1 handle 101 flower \
 		dst_ip 198.51.100.1 ip_proto udp dst_port 54321 \
-		action police rate 80mbit burst 16k conform-exceed drop/ok
+		action police rate 10mbit burst 16k conform-exceed drop/ok
 
 	police_common_test "police on tx"
 
@@ -190,7 +190,7 @@ police_shared_common_test()
 	sleep 10
 	local t1=$(tc_rule_stats_get $h2 1 ingress .bytes)
 
-	local er=$((80 * 1000 * 1000))
+	local er=$((10 * 1000 * 1000))
 	local nr=$(rate $t0 $t1 10)
 	local nr_pct=$((100 * (nr - er) / er))
 	((-10 <= nr_pct && nr_pct <= 10))
@@ -211,7 +211,7 @@ police_shared_test()
 	# Rule to police traffic destined to $h2 on ingress of $rp1
 	tc filter add dev $rp1 ingress protocol ip pref 1 handle 101 flower \
 		dst_ip 198.51.100.1 ip_proto udp dst_port 54321 \
-		action police rate 80mbit burst 16k conform-exceed drop/ok \
+		action police rate 10mbit burst 16k conform-exceed drop/ok \
 		index 10
 
 	# Rule to police a different flow destined to $h2 on egress of $rp2
@@ -250,7 +250,7 @@ police_mirror_common_test()
 	# Rule to police traffic destined to $h2 and mirror to $h3
 	tc filter add dev $pol_if $dir protocol ip pref 1 handle 101 flower \
 		dst_ip 198.51.100.1 ip_proto udp dst_port 54321 \
-		action police rate 80mbit burst 16k conform-exceed drop/pipe \
+		action police rate 10mbit burst 16k conform-exceed drop/pipe \
 		action mirred egress mirror dev $rp3
 
 	mausezahn $h1 -a own -b $(mac_get $rp1) -A 192.0.2.1 -B 198.51.100.1 \
@@ -260,7 +260,7 @@ police_mirror_common_test()
 	sleep 10
 	local t1=$(tc_rule_stats_get $h2 1 ingress .bytes)
 
-	local er=$((80 * 1000 * 1000))
+	local er=$((10 * 1000 * 1000))
 	local nr=$(rate $t0 $t1 10)
 	local nr_pct=$((100 * (nr - er) / er))
 	((-10 <= nr_pct && nr_pct <= 10))
@@ -270,7 +270,7 @@ police_mirror_common_test()
 	sleep 10
 	local t1=$(tc_rule_stats_get $h3 1 ingress .bytes)
 
-	local er=$((80 * 1000 * 1000))
+	local er=$((10 * 1000 * 1000))
 	local nr=$(rate $t0 $t1 10)
 	local nr_pct=$((100 * (nr - er) / er))
 	((-10 <= nr_pct && nr_pct <= 10))
-- 
2.43.0


