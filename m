Return-Path: <netdev+bounces-38609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABAC7BBA98
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CAD282269
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F31C691;
	Fri,  6 Oct 2023 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jwz7BFP6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8D79C1
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:44:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C158F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 07:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCOhYSCSf1y/tfIeShuo/7uA1L37Mrr2Iav+iHgZcPxaOyKjJTDo3KI6ky0cD1VeM7s7MLgdVZKttQJOQorovl6I1KRPsjpXK+lVCJ52qwVJ+8Cdp3pUxmmAqLUXEzfaa71e4RCEjgyHMISFM7Mi/dgDxB6ScC6LSeBtZ/WMPEOa5eYy1D47mf3jwIJeDJ73LPgXKP+LsmHG7flrMHW8I2PJQf9qtzXAaILjw6B370ShrHOsAlWMF7fOVTzfLoBKb7OILstmzjAMcvC2ngMWmGEo7JcH17+B/QqXpyt3aUFivZm5QcEeM97sb0Z+8vNMAhDBssDf902Jdf5d1sdrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiSS3deap47N/jGyE/XwPtniCZouR9jBHePTKo07oeM=;
 b=EgfVUjcMG7MFwgpZSge+XpuxhoMhOafLZk1tAzD6CidZM/Mh9oj04T4wIH0OwQPZMkRFgsPMcyVFd+1982pOcM9SZWzKrOlamyfd+d9aWV65mgK4XNhl+A/000JfGXOTisVMnblCTxixBNSkNHCBQqjAuS3G4RidER80TTkcrhY5cE9p5OkZzZS8cVc+680yporAXRg3eiVFQ05L4RIO/nUdTvAmyK/yzl15gn/vifGrepNOiwt0a2ETKTXDa4lIl95NAOBHDxkDqfFzk1jsD+yzRgQSLRTqAXj7eQUV29kGvB6xTFIh5yixP9Jy6U+HDYQAjTQ5rZ3rG/ZmUaeoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiSS3deap47N/jGyE/XwPtniCZouR9jBHePTKo07oeM=;
 b=Jwz7BFP6YANAfM42KZ5nnGNBoHO5JYT04ePpnkyujNrvhrD2rBpF82FfkjKQTZm7TrFZFrsSnbtDxCK/o/djC/yHo4gm3Ammf5cCcBslQX0wemO/NOQDVIEtZ1DvJFokrDnaMjXaezBGaRFLCZUE+PPd6O2iD99AToISE1jtImAMprxG665OVU7myBane6I9mOoewJvSj9KO4gmPniMCKUe/1Ss68pri3XcnXOHwlgAUBVQA99YNkQ2rl/41uf/sEIGGvDypZPYtUHndX/6fi9MEM4XYodEoOr26aH3ddeI6qI7asAwrjCvqlBALp1GoLr6eCwMNUc2lE8+FLDAKNg==
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 14:43:57 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::10) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 14:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 14:43:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 07:43:42 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 07:43:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 0/2] mlxsw: Fix -Wformat-truncation warnings
Date: Fri, 6 Oct 2023 16:43:15 +0200
Message-ID: <cover.1696600763.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: eb41b80f-4ed3-498d-117e-08dbc67aab72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	55tiDguSjZNwtWTIuRm9k3kd/IyeP9HtrqZAKi+f8nV0fufa18HGbkl8hmjBBPkdQLM5QbqhSQkBYa3Hi0fmuFBHXkPeDPrJMVxZQh19H3583u8AcMX3KNQhlFErdSHZA0q9FfovjisQ2MjDifbSZ6Sx5XXKfXknRKvZ1p5l2RGQoZ034BulNGGtjjI99l5BdE/lqpFM5dxl7rZS2dE4X5ysrIFB4QwotSaWLNBCOJDKl21MLAgO+BLONUHW/V2tRZODnh66LqOY02web71/YyqM9nvQ60BvGWK0K7fRE2nPFh28w/CnBkUmYpYPQzratAlJSXMFCl+95iWf0qEk+iRFGRVZ5+fh2k/aB34H1MbEu2ZQ+TtcJSc4grsLgPLT2yH9AjgAxNJH9eJz6HdHM2lkoAs1TyjDnl8htV9NIjOTVrTChzsJAtZVLUeVHoCVb73dzc9RIJ0gEhrBsEgG8DD1mWdBaUTTkrLUOOdzx1cqYmS+b7Jf+GSH5QZuDo0nBkfzhCRd06IPENpE3xzEfU4Bv+sKrbZuAW2abtC5vg1ALXlMUd3Be5gejj8cFrrKqT3VcryV/O91/E5gKF9hjKiA2LPy+vfrKot9krfMn5CKaIvQe6AfYG0UUe7Li8zsjZveciHOySMThsa1liOIxvpFAs2xXam0/eyEilBcVjznlI03vE2gCY9qr1ARYzczmK29qfPHquujQkVeY9f5u2dpealHK2yf8MOG29wC5mgj/UGkcmiEqBJq+6kV3+Xi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(47076005)(316002)(83380400001)(8936002)(8676002)(4326008)(36860700001)(6666004)(478600001)(7696005)(110136005)(54906003)(16526019)(2616005)(70206006)(426003)(2906002)(26005)(70586007)(336012)(107886003)(4744005)(356005)(7636003)(5660300002)(82740400003)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:43:56.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41b80f-4ed3-498d-117e-08dbc67aab72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ido Schimmel writes:

Commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow
warnings in W=1") enabled format warnings as part of W=1 builds,
resulting in two new warnings in mlxsw. Fix both and target at net-next
as the warnings are not indicative of actual bugs.

Ido Schimmel (2):
  mlxsw: core_thermal: Fix -Wformat-truncation warning
  mlxsw: spectrum_ethtool: Fix -Wformat-truncation warning

 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c     | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.41.0


