Return-Path: <netdev+bounces-211176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E9B1702C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A588F188C22B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE22BE638;
	Thu, 31 Jul 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxKDd7l1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A82BE03C
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960222; cv=fail; b=jBMSIQqQUqn+wRN80HmQlWj90Boh1AupioPmLWQqznE63LCKIp05nsu6i3w3sl3kJ+KGavrenw8WwF3upa/dn4r+0RsDDwbVASwS3iEsW2r1QD1BIWQg92ruttaHkDbDDILQLJ4hvsUwz0DlPcL6XJ8BLaGIOzal2s9V6hcfI/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960222; c=relaxed/simple;
	bh=ECnUBeCATaAIdHzE7amDZZTfpIe/QM/U4tzwe/fRIks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o6DQ7EYf3O75WYI5/ZarE8k67SQ8UUmJZA9z03il3aJQ53siEqaOC7EVKw91DHO5KCMybQQxFc7WNExR96oEkmsQEXZKgyxolqTgiPeN2h7gkaKnoTAVfo4E8sZQmL7v65gXnQThWRZxqoaor/Z7vmHPJVRTOBeMLenipdsyl5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxKDd7l1; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Opei2J2nWwA7MSphl+dNkfIGiRdqz1CyhUnRk1bAUJxvbRnteOjD9vG3BCMFYnuYGqeO/1YwNr+iYlZwATIcn1E79QQNcHacpQXAQGE75n7svFV2NnmTCRgspaO5wxHppphBJiLO+6CQiUz/sZcRPqWw12mqewUaUWzDSOUdMfpiAqs9F/3X3dKUBGjtFwX4MCQFFJhb3m3kDQ/VSwyvBwA5WMVN1gq3Gx0olY0P3cPwQ2Wd+G0LOJW/wAgtv3qYUbdW+fyYJfsgHwvSzNrrjMJTxsb/RC6zLTQimtZJzICMgvi+6NamkcS/jPIV/esUs1KD4KZxCE1j63TQkjY/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaRBYsvvvbYbYcDjaGMyCGR7pkv6D5WLO28TaOaWIHY=;
 b=tAUOGIhhSTeD/hXVCV+8NPQyOHXfj9C7w1H9RUbb2f43sT4rV1xilQM54tcTZpYiQI2mu0Sy3TX+iV+fTDd7zQQzz4BeGRCFpWlBlqRzc+hz7VPgAQb6v25Ap+EHyH8jrNn2PzQXUibIYC5jjsoc/BcdDAPEl5OStKVPhSx8wDGZeAQAhKY7/vzpQAi3GanVkM6rfdqKmJUkW06Jhy9J8pV0Hp7bf+rxjb+8gJcuR7sApIFJ34sK3jU+S1k6pbde2Ih5Zurt+eEsjuRiclCMwxtGGxA1j1YHe6OL+q9M+ffHGd27ShfMxIUOvRBYLwkhrvuzNG6vuhzJj5dcAqyICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaRBYsvvvbYbYcDjaGMyCGR7pkv6D5WLO28TaOaWIHY=;
 b=NxKDd7l19FFri3956LuPj8STqdbbZfSwK0uEkxRYY9OcHbnZCJ8YOmPNbG5U6eQU69C7omEDill2y3jyrnn/NAIQax7xbP0jiHUWcbE5VmyBXpFbtZa6K3T6cuyRReOOJNYSfHdj06BOO0IEYuqetYIS2YkLMsPuZ6xAK1wQQkFiCCw7Tz2LmNyvS4adYhFsDLkv1skEiuohZqtDVR0Bdtlc0/MKKcd4nhAod+6U/dZAB9W9Lce9rGZ6PAV7Xt7AhDdTTUiwmfUoY4sY4GIb99st7/l+2PUy8I9SUpvm5ZqDRFRRouAt54KA+jwhja4baM1qymX9bw2NZ/oaz/jZhA==
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 11:10:18 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::da) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 11:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 11:10:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 04:09:53 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 04:09:50 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] selftests: net: Fix flaky neighbor garbage collection test
Date: Thu, 31 Jul 2025 14:09:14 +0300
Message-ID: <20250731110914.506890-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c069aae-2f43-4f89-99da-08ddd022d4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6eEhhp+vvHNsTXusld1vGDIrl/yuWG+kXMt/RVf8f/vGbblHriPBcxVoY4sr?=
 =?us-ascii?Q?XrEFuW6xjI/42eiPxz68y43kcvfT4upn0S4m1IXDn3onH9FxpXpczoWe0xfj?=
 =?us-ascii?Q?pY/GuwBGQ5OOfRwhBKlqLlD9TpZbjO6f3pzjCVrpkmbWtQLHOB4xA0HbrEXn?=
 =?us-ascii?Q?jcG1lE7JiCW06piAPJFWRmtT2uoA/IBw0xqu91UmfkN/QxM50cq+JVjEui8k?=
 =?us-ascii?Q?Z/YD37QO+XNt9SmWM3j5BS9dstCExikdg3N+ZckBJT/9NKJIADWZCaGcVM7R?=
 =?us-ascii?Q?dOeujNy5lpm6dKeO8Yccdu7wSYP/S9mNhGtAVOz8p1Ct1Ug0AOsdZZdamyzg?=
 =?us-ascii?Q?lHICX52nU878mHGgI2WxmSMQFzj6CURwfCNCyXFIKz2nqRc+ar5GhtPLpvxF?=
 =?us-ascii?Q?8GWsVF+JYXjXuRhCnnJWzLkx300hf0bEtVamaDpyBHsUbUxZQ6G9wiAyf/gI?=
 =?us-ascii?Q?JGicw1WVKoNNnBHpRvwJQsHekmSB/SKAcLFDlc1QgaRUzyckWc6ujTcQ82Mn?=
 =?us-ascii?Q?ObXAJpVLbbYJ324mMewI3N+6qIWdyi5aanEOD8qO6tpNdIyV3ZGJGis8yfQE?=
 =?us-ascii?Q?Rlb3WDK99CStsVMbmBihBf+iqj5s+uTGfwgW4bx4Hyy+VCOPF4yNw1A57jDd?=
 =?us-ascii?Q?iqr6BvK52sAg/eDMSOABX09hu2MfVm9YVOA1MmFBgkQP8JybVBJ/I6sVTsi9?=
 =?us-ascii?Q?wTWNLlTPY5nnJuR4BXd/S4GwVYhMEQsgb6YKJjIPLt2je86TI3JySp0qfPTL?=
 =?us-ascii?Q?oX3Ssz2qJ2zRuOi9Y/lPMhKlWMh+ZJviK4/Hovy7UH+dY/9kRIS7KCrfkEBW?=
 =?us-ascii?Q?AsNmGxNbUmsL6sbhMGnSTVG3eo3qDTJhsMDExenWvxhtL6cRdkM25xgNlCho?=
 =?us-ascii?Q?j/k3m8BXgcrHfmlvnUGXHZ4ZcucC3G/gVc+w5rPB2EEBSElVH/hdhlxLP3BR?=
 =?us-ascii?Q?zYpjpAkyxnz6B25Bnr9rsOlY7WkM6X+ldho7vPxGX1XCgYPufOHE3ctdyfqH?=
 =?us-ascii?Q?saotqPCVXbBz17B+DZoTqJawhvcSRDkJ7KdZH7bvfuA+k41mkt+UuMdN5j7m?=
 =?us-ascii?Q?nlDLj9gKKlR4MXrA5D0rjtHlxH+XHj5ZpoQkg2VlonaXX9v1a1H4N0bdnCO2?=
 =?us-ascii?Q?s4CfWZgZyXr/f67y9fLJczcncac/Yd9Nf5uBDYlbMZwLtICYJbD5X7QnZkFN?=
 =?us-ascii?Q?IY6o12v503eiiod02xzimpKhwSu+JNTVBt8S7cENgHoMKAAaA3qsvsbi0GO+?=
 =?us-ascii?Q?OFXEAbFoUuI5II7ISG4DEt0GCHoMJRT6OOHTZlig+X4spqV2gKIgIgsc+v3t?=
 =?us-ascii?Q?nG6r/qvVFoAfiiiqmHA+1ydtSzcWVQ0AZPBoinvhyBqWLNBST9CFMFw44273?=
 =?us-ascii?Q?EvksZqXZ9nDrSbNWy+S/i4zYQog1QIuUxh0LPSwj5kfsoG9hmK/AwrxzMsvb?=
 =?us-ascii?Q?Q2eCFDao2XN5QpcOP6DgcOnrbGGsqhMoTN9H2hRBu2HuE/wl1X9KaJkmQS38?=
 =?us-ascii?Q?4Xa05YqkG3B+c5jxCDykfAjVYQcKwzynXqKfXUBIBLwwOkLojYn1q6AUVw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 11:10:17.4696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c069aae-2f43-4f89-99da-08ddd022d4e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32

The purpose of the "Periodic garbage collection" test case is to make
sure that "extern_valid" neighbors are not flushed during periodic
garbage collection, unlike regular neighbor entries.

The test case is currently doing the following:

1. Changing the base reachable time to 10 seconds so that periodic
   garbage collection will run every 5 seconds.

2. Changing the garbage collection stale time to 5 seconds so that
   neighbors that have not been used in the last 5 seconds will be
   considered for removal.

3. Waiting for the base reachable time change to take effect.

4. Adding an "extern_valid" neighbor, a non-"extern_valid" neighbor and
   a bunch of other neighbors so that the threshold ("thresh1") will be
   crossed and stale neighbors will be flushed during garbage
   collection.

5. Waiting for 10 seconds to give garbage collection a chance to run.

6. Checking that the "extern_valid" neighbor was not flushed and that
   the non-"extern_valid" neighbor was flushed.

The test sometimes fails in the netdev CI because the non-"extern_valid"
neighbor was not flushed. I am unable to reproduce this locally, but my
theory that since we do not know exactly when the periodic garbage
collection runs, it is possible for it to run at a time when the
non-"extern_valid" neighbor is still not considered stale.

Fix by moving the addition of the two neighbors before step 3 and by
reducing the garbage collection stale time to 1 second, to ensure that
both neighbors are considered stale when garbage collection runs.

Fixes: 171f2ee31a42 ("selftests: net: Add a selftest for externally validated neighbor entries")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20250728093504.4ebbd73c@kernel.org/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/test_neigh.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
index 388056472b5b..7c594bf6ead0 100755
--- a/tools/testing/selftests/net/test_neigh.sh
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -289,11 +289,11 @@ extern_valid_common()
 	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
 	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
 	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
-	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 5000"
-	# Wait orig_base_reachable/2 for the new interval to take effect.
-	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
+	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 1000"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
 	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
+	# Wait orig_base_reachable/2 for the new interval to take effect.
+	run_cmd "sleep $(((orig_base_reachable / 1000) / 2 + 2))"
 	for i in {1..20}; do
 		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
 	done
-- 
2.50.1


