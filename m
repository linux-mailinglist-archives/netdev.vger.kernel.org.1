Return-Path: <netdev+bounces-238925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14053C61196
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF34C4E17ED
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621521CC79;
	Sun, 16 Nov 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWIlgn14"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0331184540
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763280704; cv=fail; b=pYGC5fSVzsZ05U2wUpb4kKl3tTCmub9B2moiOCT93O6cA/7VJkLQXasvhcBryPnuaNU1rIQfui7/XxZhCT1b/rwborQe8rsflqnkQv++bgrYi/IUWDno6KEOP9JpU0C4NUlB/TKt+bJPh6aSJT+6M14YaD6asXvwkmIE3a2v4zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763280704; c=relaxed/simple;
	bh=PXqLnEFwxv3jXBluW89FFkb6a4HCHgxot3TDvrwyC5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=heY7WoN9CXzNPpNx1GgASwlfU2voTOsQ1TDZmCTR0gDfzrCLxzqvUkPnm/4nhXqTiMPpuNaQo8JHjsPXSXcB5EC0l2qivYXMr57F6xKV52+vPZrC7/pqo/PHiX2pR7Qe5BlpRHrEx726abDoixSCy/LhNgf85eYMcWJ97mjSXJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LWIlgn14; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcW4qiB64xUiQP1HWgViTCvlx0Utmy7/nK7E8kxE5PXxdEyrLlZgxU/iiD5qNhfyfYNMkeDnnIfr7tz0OTntn8OYdCgLyABMjWpDy+lXgoFQ8dXC5jiOcBbXXaZ/ohmSknJzXtEJfPJOEahRSMgP+Ix3Ygdxldp+6AEjdg9NxyELAY1h34hr/nlk2IKcwJptGw+y3K2ds1L4Oz2jETFMSxbMgz648qusKe4RmYLTE8qBgmJL9J6Z/RsS0QZk/+aO8e2xYi7fyr2o8iwVxl62wMaooN0li/yQtR7Ta6MMdW9PQqugwnqNe1VZ9ksa2J85/FeMyLrVX2Pp+HyjCOvxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbQz2TUMC43LwA/JJqbKKv7krjA1jsA1IQ0eHUpyFHw=;
 b=DHXO1PdQbbChH+i/Gsx5x66beioTDb2IyAZNgNedR2m38M8KTssMmV+Tw9mpLRqLNGSp0K2vg8NLcq5txZXEQ1QDf7yXPUiFHmGFHLhDsSQp3Ut2FMw9d91K2HtH2E/0IA5mmtKPW2AnltnYj5rKgLw6JO10kyfXRfcQ9DvJCQXH8yhtfrvbBA+lH3P+vX4ZmF4lSp5PLkks4BTVWZi5BwhsyNR8ZgT5tTucNtKbzfpJxN8/hPMekg3PUmOPgVypX2easeaMIWuisFYPgg7Oy4SgBzPmCcZ1D+fvIO228wXTQcSBJGBmyt2lNnGopgmGt/Bxe10tZXuUYrK8GPi32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbQz2TUMC43LwA/JJqbKKv7krjA1jsA1IQ0eHUpyFHw=;
 b=LWIlgn14NcGD99HglThgjZZyMABE5Ac0q6qsnqotfYSmtlVc2DHqHz8bKms/LsIwfSQ7Xah5S2CqCZt6IzUFQppol6YNSEuagMDlRoBI/o8MlCPhiS73Xwhc3C9RttxiLC66WGOUrwW/5ynKsU1B60ZA5l3v5WpoLhilfF+Mg+QvW1Uz02O5PuxcT2pOeCPcHFseR6l/vgmsJ61Jp0Q9GJEoEL4wAefDk0/oNYQ8qmcF8/gpJ1j7voBgLAfBOIrNCQVn+K3g+xP2pyj7uPRH9E3c3TN5qtt1kq4l0NCSG4zxXyl4dSxzvk2ARfBKBEGDH90rwyZ3oONwHS3+2ZNhLQ==
Received: from BYAPR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:e0::44)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Sun, 16 Nov
 2025 08:11:38 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::45) by BYAPR05CA0103.outlook.office365.com
 (2603:10b6:a03:e0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.8 via Frontend Transport; Sun,
 16 Nov 2025 08:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 08:11:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 00:11:26 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 00:11:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] selftests: net: lib: Do not overwrite error messages
Date: Sun, 16 Nov 2025 10:10:29 +0200
Message-ID: <20251116081029.69112-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fa77c8-492d-494d-9902-08de24e7c425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bm3/vhJltyEXu+LvAE/yjKH88P4KohufWwYrogdroLXZP9J7Qhx1xoAntyfh?=
 =?us-ascii?Q?Y2MaBg+MR7WI9VfishXlxwCzn+G0/lNBAjv/GsckOL3g6AMXbxBCLpD11hwG?=
 =?us-ascii?Q?d/hTToeeEiXYiRcqd6E5HOtNywUgIXUGcVHBgFedaj/ObyO+zIjKR2e0yPD+?=
 =?us-ascii?Q?aPahyJmrwlwxQmVDPFE9/+BgjKjtx7UTbsbdVziSNQ43dhPuE9R49o15TtkE?=
 =?us-ascii?Q?dE900MoIsT3t5FF29HoXjQYvdS4oP6H69fyzkMHHu9I+bo1n/zWWgTYoi+bj?=
 =?us-ascii?Q?MD6OZ/NaYSWsFgHOL6dRP9KZswsBVNP1oR+JtXbOBQZfwIIXHD8NJcacvjQ+?=
 =?us-ascii?Q?yKTng+1Zhy2ZsQ4Slv9djTBL7yfhGIR2f68Fty08RWfpKz9XKbRpw7N6L8je?=
 =?us-ascii?Q?eSLMq9urV7FKvGFjJcV/41pJTBRvfPiH9tuLe61EYx3kmA+7hWb4aER0f++V?=
 =?us-ascii?Q?d2riFtY72TX9jizJFVLjEinjdss8wR/1+RUeRPJc5BVohupQW+yf4gtArmw9?=
 =?us-ascii?Q?YC4HZ62e7Q3mX19SxECSlXkgXwMNCkyq+CqjF+R1HmjDwJzXxMro1zG5wW0r?=
 =?us-ascii?Q?59X3LjaHcjx5EjzKcDjWURFtZGcq98looXK87BBlcyl/1ArPAJJ2DGPuxIm9?=
 =?us-ascii?Q?hqFChbit2wPAN7sLxc0mPDJcTt+xP6TARKCaaGI/Uek3gt/VLDgAa1a8Dxmx?=
 =?us-ascii?Q?KTNVcA+ggqPFNBmkrhwU8IfP/P/55+Po7SSIuzhJcwpaqP+JUu287hJF1ky1?=
 =?us-ascii?Q?jQFBSVdDLcezLctVyF1On6T0zW6RM6klTZuOGXcMSA+KpW1KJgsLj8RATGQT?=
 =?us-ascii?Q?fhjBsX+035CLUh2spWoErImYZTetJ8MKs0BzspDvPBlM5CCXrP34D+XtoHVO?=
 =?us-ascii?Q?vFzx+mLlvu8x1xStkvpjQixZ78hmGGrqLll4eG/SzYbQ+cV+0W//CWj7qlK7?=
 =?us-ascii?Q?HXuRXd6vNCB6SDabKHdcdu82kfbZMUh5PTEW0DUFMe7gIIBtHQjNqDeOamQp?=
 =?us-ascii?Q?U7IGtMmcLYXHEviMM9wgAcAwnWxdOJAyZV2xpmeE6sZCEoGd2Gqi4M7aQFKt?=
 =?us-ascii?Q?+ae8mJ4QJ5VdGWHurDhNKPlCISnz+HeL5PDfMG6cgPvUCAFy7Zbc5GT0nwaF?=
 =?us-ascii?Q?9r2j/VItJ7+Bb/eYaom5dp0KFQFRd861OAt+DD1WsUo6hwLODYx7+kF1dTL6?=
 =?us-ascii?Q?IFtKZoGCxG6C009+neT8kvzQH2rXud+bvWU4NzCk5EyBE9SD+f9acnOIsyaP?=
 =?us-ascii?Q?U8jcZrh6l/FffLLOWBHK749xg+aZdZwmyzZAQ+AbIemnkN+bTLpDkkIgsmjW?=
 =?us-ascii?Q?LrJlADQ3IRW4upkq0WL0JIP5iKPrAiHq96DDgm35/KjMtf9sTUouzyuTH1oc?=
 =?us-ascii?Q?1JFRrtz/kCXHG0d+j2cEumVqhQz8DjhCPjOETyuvPXbj+CDk1XfcgK8+2G1t?=
 =?us-ascii?Q?X3ggobPORigi2GqG9wWQG554Xkj6XNqfhIdfCHyecQ6KxguDjAWFwDezL9fE?=
 =?us-ascii?Q?l1Xed/8SxOJf8p/d1vWZTAbZ8D1Szfq/2rIsb7sIrl0J0iureZgVVgxGX1M0?=
 =?us-ascii?Q?MTFp8/yGgN0YP4U5ExA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 08:11:37.8661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fa77c8-492d-494d-9902-08de24e7c425
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

ret_set_ksft_status() calls ksft_status_merge() with the current return
status and the last one. It treats a non-zero return code from
ksft_status_merge() as an indication that the return status was
overwritten by the last one and therefore overwrites the return message
with the last one.

Currently, ksft_status_merge() returns a non-zero return code even if
the current return status and the last one are equal. This results in
return messages being overwritten which is counter-productive since we
are more interested in the first failure message and not the last one.

Fix by changing ksft_status_merge() to only return a non-zero return
code if the current return status was actually changed.

Add a test case which checks that the first error message is not
overwritten.

Before:

 # ./lib_sh_test.sh
 [...]
 TEST: RET tfail2 tfail -> fail                                      [FAIL]
        retmsg=tfail expected tfail2
 [...]
 # echo $?
 1

After:

 # ./lib_sh_test.sh
 [...]
 TEST: RET tfail2 tfail -> fail                                      [ OK ]
 [...]
 # echo $?
 0

Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib_sh_test.sh | 7 +++++++
 tools/testing/selftests/net/lib.sh                    | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib_sh_test.sh b/tools/testing/selftests/net/forwarding/lib_sh_test.sh
index ff2accccaf4d..b4eda6c6199e 100755
--- a/tools/testing/selftests/net/forwarding/lib_sh_test.sh
+++ b/tools/testing/selftests/net/forwarding/lib_sh_test.sh
@@ -30,6 +30,11 @@ tfail()
 	do_test "tfail" false
 }
 
+tfail2()
+{
+	do_test "tfail2" false
+}
+
 txfail()
 {
 	FAIL_TO_XFAIL=yes do_test "txfail" false
@@ -132,6 +137,8 @@ test_ret()
 	ret_subtest $ksft_fail "tfail" txfail tfail
 
 	ret_subtest $ksft_xfail "txfail" txfail txfail
+
+	ret_subtest $ksft_fail "tfail2" tfail2 tfail
 }
 
 exit_status_tests_run()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index feba4ef69a54..f448bafb3f20 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -43,7 +43,7 @@ __ksft_status_merge()
 		weights[$i]=$((weight++))
 	done
 
-	if [[ ${weights[$a]} > ${weights[$b]} ]]; then
+	if [[ ${weights[$a]} -ge ${weights[$b]} ]]; then
 		echo "$a"
 		return 0
 	else
-- 
2.51.1


