Return-Path: <netdev+bounces-25293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD8773B24
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21051281876
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4E134D0;
	Tue,  8 Aug 2023 15:42:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEF13FE0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7744B5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTXWCb/QvDFYs2f5UjfHXFecY9CtC/bWet4xhGp22ZsWHW/we/aXbngcLzEXFGvuvuldGMMqefZOy+s/EgncdVeLjDw8+NPOKvzb3lmN6cBE855xP6pJzL3cVP+iCLVItBAd+vBGIgY6L45qfOnz2GyJ20R49/gw3jvY8eDVCTebkpJmgVrvFOcmQMoSN6u7ypxAT89ZdAt9p1yevx8CKtA4VSFvvLDPUeV5FcJszS0XehOYMpjKnjQz4gsigVvO8IVJtFKRafFtU6o1HkamIGekh93aomypHGHOlAjvrVcleSZ4gg7LWrfLCdwGe1mWSHFh1N5ntVNvn59Hc6AVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqpxPQdvDr1ScO9poTTTnzPvMBpT8xX8RgMGOXa+1lA=;
 b=bYtA2MVr1sMm+37A8YZHjZuTnEqT28BXK1t2+WTS4yuh13DpCIv5Y1lFsYGpIMqLTlJOiE46yFolvHqohgX7U9l1zd1/IBNr6NSEgXajKPspxGiYkm6GKAKWXLww3U6fGomaVByDYZ3DRSADQn5Qoj7ZkD+akyGPmrNG/y9DsB51XWz9xeKam/InWOQ7w3k7jcNKNXUHGCJaenTSUFq2uiqkXkTGE5JL7mk9VcZiSkYOG0W6Rj0QvFbij4YHyvGR88e1ijKl0W2OLFN/NGX7aGXA094mT6cB7Ex2Xg1QWoT2zb73jbOAjUTb6C0YTKuMKRxuuvbGMUNv6jmmpSqhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqpxPQdvDr1ScO9poTTTnzPvMBpT8xX8RgMGOXa+1lA=;
 b=lFEmRBzFcgj8kdlf+wb7bgkEw3nF98aiwaCNYTLfciXHnTpxKYbH9llLeL7ncBgsVrV75bPuLx0NswaELOZSkUS6HVaU55QOY9rn3qZA+unqLCDL+v4H3B3MspIo4PbEKvDbGhQjpxk5Nbvbdgys09cbxdH7TqLOtHA4vUmEy/MZtCmAFpIOu/MDEUNI70fl1+6oBcZL7qwSp5kfb8FoOKr5pcnPx+NUXCha2wBfGiSDDy2JfJIZlEcD0sXj+4axHvDCxjDRXrOyf1o5iLRmKik7YbYslLqIXPldSWT4+wWgJPTBtsuBvLJMO9so3oD97kkOroSRq/oXX9GxsxNIJg==
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:13 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::df) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.0 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:01 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<vladimir.oltean@nxp.com>
Subject: [PATCH net v2 10/17] selftests: forwarding: ethtool_mm: Skip when MAC Merge is not supported
Date: Tue, 8 Aug 2023 17:14:56 +0300
Message-ID: <20230808141503.4060661-11-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: a37ba979-8995-476f-1e02-08db981a0501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u+7ZIDO2mmu8ErA2zheu8q6Flj26M0NDfEyICeDwrFWkSzmswyuktZQ+MlvPs0XJn+dJAme+h9/IFSYa+MJvqPIMXyuo0f/zwT0C3c8TRNLLra4aFxT+x28c9sWubZVTOuVCcfhvuv+94SsbzGdpZtDQIOqpdY0JJwjv5OJ6Rfmg1wVlBasPOPiRhK27pkkyjlRNo+FPKTNiGO6QrOwvjC/L9xG09HJoMGvs26L64PIsc+uu9vSjfKzuW2q4PC9I4gHEKDTTwG+pRgAWkQ/X3U2prTYkR3aBpLB6R3CcNK++RoJr5/nPYwq7SSGbEGo6PB/JxhhLokcPm0uD3W3NMFz8P8ZZbMNVDviz0lTcNifK/DBrt8Eel7fljzgIDCiVfFVwkhyxx0KpRWcQBEfmNYSqrqOBn4YLqtdcKzUqTs0oS52/EVKlgf8FFro02rNeDo6FxSSHgf385YWj0AdG4pSMq06lfMf6KFHKl7LzTsKOE0R2yRmuHO5/6NYnutkO2Zth7kE512O90NtSj7/nIYW+yn1SP61fO4FUAiTeHDVCAESL4UO4Q1ARl94fca5ZolfvheAs5zDJ5BAyMpAeLlEA80qn2jh6P0bZ3cZPXmwzu4vYUtcq3/NJ7Zt6sHCokStWXCfrB1c7wpaIY//NNJzQBIERJ5+nbY9KDPLSgoF3j7egn0Yxjb6pqwz7u2kh1g1HZYKE/eUppMPzrkttbup00Ekn/Bxq3T4hKTkucegWriM3Eu+LkoZuuSpIHiWGZc37q0OImtr4rPP4hV5akA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(1800799003)(186006)(36840700001)(46966006)(40470700004)(40460700003)(82740400003)(336012)(86362001)(1076003)(26005)(83380400001)(16526019)(47076005)(2616005)(426003)(356005)(36860700001)(7636003)(2906002)(478600001)(966005)(54906003)(36756003)(40480700001)(70586007)(70206006)(5660300002)(8676002)(8936002)(41300700001)(4326008)(316002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:12.2181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37ba979-8995-476f-1e02-08db981a0501
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

MAC Merge cannot be tested with veth pairs, resulting in failures:

 # ./ethtool_mm.sh
 [...]
 TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
         Verification did not succeed

Fix by skipping the test when the interfaces do not support MAC Merge.

Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: vladimir.oltean@nxp.com
v2:
Probe for MAC Merge support.
---
 .../selftests/net/forwarding/ethtool_mm.sh     | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index c580ad623848..39e736f30322 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -258,11 +258,6 @@ h2_destroy()
 
 setup_prepare()
 {
-	check_ethtool_mm_support
-	check_tc_fp_support
-	require_command lldptool
-	bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
-
 	h1=${NETIFS[p1]}
 	h2=${NETIFS[p2]}
 
@@ -278,6 +273,19 @@ cleanup()
 	h1_destroy
 }
 
+check_ethtool_mm_support
+check_tc_fp_support
+require_command lldptool
+bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
+
+for netif in ${NETIFS[@]}; do
+	ethtool --show-mm $netif 2>&1 &> /dev/null
+	if [[ $? -ne 0 ]]; then
+		echo "SKIP: $netif does not support MAC Merge"
+		exit $ksft_skip
+	fi
+done
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.40.1


