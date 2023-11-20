Return-Path: <netdev+bounces-49348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A928E7F1C64
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4351F25C30
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1639430CF3;
	Mon, 20 Nov 2023 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCwK9DuL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB4C8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8JcYGJQiSLHTK8QebI7wnjuZD/o0xqPdr0NWWq+iTYE5Nd8+vaypmNE+i4SgtvClhngMOHSVd9EBAk+zU+1aMfUEpb0fZz4QFZp1P7DQeRZLN72XeuXX79E3rLnvB0qeYW26mL6P2VRPLVy6x52zXsWcfNHUrvzV0urFoX9RPqo0iBtsS30Y2kswMBmdU7NKpUUqUHCOK/oSYl94PNc0iBnovPc6SQBsuGSsvUTzeA5NkEi8uoQ53E/vbhiG7QeTtjXPiktjkzh8gF6Ifx6aJtkeFOgTVZMfqjbsz+SHY76KeQ+n1ZTaUtDQfp8kicuBuiIpXBOsRj9dmbSMK0R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkAUDEaR9iKBk4iE4Y/I/yWxX5W01DfRMYxue2UWK7s=;
 b=c9+3sXdz4gf4wZa1R/B1Daag+sC+d5R/21JDkTZgbHkNlo+XsNdt8ZrBdQagzpyHz7NQHje2Zwqiviku1q5f9xOnsnHK1QFMwi/QqYkz40gVavTKyXiNs873VF/wCeKyTKnHiBvqnfpgZ9M/mv9HJ6NnzGA0vyfGluyLmBkKGmaYc94cI+lc3+fVJjcMJf2CnnzXpHaGO6mMn7PUKLZ8tD2flIvJa03/f3ijxZfe0zeCBnjljXH532KKubj55X+a+lYYGPKciTpbe+QvtM0sCzVf2liH9bCaGXoX9VL6WgRzSofD5+hh6Qtfn8HFL7AL2zS3Kzu8TtQqzaOeYPMvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkAUDEaR9iKBk4iE4Y/I/yWxX5W01DfRMYxue2UWK7s=;
 b=kCwK9DuL78SLSjfsZo/N+1HzzLpTF2OxJvPnV+fA4pZfzty9Ra7jkk2AZK9LwaHo5aWQuFKz+h2cYJq+ELfJSCgdI/CznCR2KTQ/N0vQ4UtrVGuSgwBY3kmp/Oo78DGt0jRS328k0HUuPs/Tk6i8c7kMi2D1XXxlooBQhAmKrjDU7XKEE7jdcpxauV4ix9MsDjjPG84zF9542FyXFXLk3exYfyp/eXCBLYzsPsqY3T88OYmsKlKa8O/wlYAyYzTsjiQMQ2NUy/+dF8WLlUY00dgWHuA4sLWrRplg6QPYIWSMQSm0RT79RX00tDO/tJdNFQvSZT9KTGHtZxnzekGvCg==
Received: from BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:34 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::ea) by BYAPR04CA0016.outlook.office365.com
 (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:14 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:11 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 14/14] mlxsw: spectrum_router: Call RIF setup before obtaining FID
Date: Mon, 20 Nov 2023 19:25:31 +0100
Message-ID: <f24d8cad7e4748b8e8e0e16894ca6a20704dea32.1700503644.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca967fa-f737-454e-3b9c-08dbe9f6816c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eRv5+LcqBVTEU+fnMd4hJ4D4uo5DdZJ56ml61Oq6WBmWYhTqlWRMs0VnRIXvuBDjlsAccYqviL7oSM2gc3dSDcKC4qEPPxsZle74HMz6IUWZ6Z/GFZ243QbTBTfMYqbrfXIh9IIavzU+RBKpRRGkrqoFivqFRupFqZBh+plnDGYh70RwAifJFBMSjbdSeuQTmc2pgl2Db9O0oKbHLhdodLLn+W9HJzPwdXxzNr1bwovo5RnjUqKvcZqJtTIbELfTtDzzFcuvnBvHQLhd6aPQ53MmXKnJ7iXfCeoU2DEjVE4GCdymhWavwBBXPIHXS9YenSMWAOkr5JM9Mo5XmVycjn585pwEnq6B/XDksP6AZ1NrHjyKyTeEM8499JWw2Z7xsCPgVeVypYAHUD0I98/zUylv2/824C1YoYk6vGTkrN+czhyhVGH2DAOHvWAZbGPkdSNwzEF+FRy8I8WqKuQN7QjSRuOHtr1PqCOFGlvjuUQie+Z7uB/lv28zHBEq7v430AubGu6400gdxnYDvnR1Da2loSK8GIWcrXZLljHRFZqLPwjO0aLPEf2kj+eGJmuDMFJImfUOAh9OMeA0tRu4MgOIn5SvbjTvVU8IxyxI3o6A/2V7Vu+i/JHPlxwuVccGoEv1CFD5X7hdQ8Air1vUGnzQYLdodn1oUFEISD5eOpO/KlfPxiVm8FyOA1SvlfQjFuhdf3lH05zOMqo9tisdyiZunQVC9M+Qk9p6GUtLdvMjyprEBI1MAnRH1mVU4CMi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(7636003)(356005)(6666004)(83380400001)(36860700001)(40480700001)(40460700003)(426003)(336012)(66574015)(82740400003)(107886003)(2616005)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(36756003)(86362001)(110136005)(316002)(70586007)(70206006)(54906003)(26005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:34.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca967fa-f737-454e-3b9c-08dbe9f6816c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

For subport RIFs, the setup initializes, among other things, RIF port and
LAG numbers. Those are important to determine where in the PGT the RIF FID
will be stored. Therefore, call the RIF setup before fid_get.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index a358ceb4e1d0..2c255ed9b8a9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8419,6 +8419,9 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 	rif->ops = ops;
 	rif->rif_entries = rif_entries;
 
+	if (ops->setup)
+		ops->setup(rif, params);
+
 	if (ops->fid_get) {
 		fid = ops->fid_get(rif, params, extack);
 		if (IS_ERR(fid)) {
@@ -8428,9 +8431,6 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 		rif->fid = fid;
 	}
 
-	if (ops->setup)
-		ops->setup(rif, params);
-
 	err = ops->configure(rif, extack);
 	if (err)
 		goto err_configure;
-- 
2.41.0


