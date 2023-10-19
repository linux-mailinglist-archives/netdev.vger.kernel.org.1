Return-Path: <netdev+bounces-42554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388157CF526
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E32B20DD1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3618658;
	Thu, 19 Oct 2023 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEu1X68G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC0182C5
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:27:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B869119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjtzG4JVQV//EQVEnWnsf52juDvSJqJOCluzb1/UU+MLZnjoAZ7m2Yd10nSx7DshkD0h6aTahJrDbMs8GrptQ8QiZjELDu5WnxaKH/x2Hw+3yfOEYuiYZqQY9aiCbFYRVgye2LFuId0GqbS4+Sg22ELig3ytvkDP4mcJZCy2rJZkmYE4kE+RRc8kd1DiCUsakY9d0XEC7AVh0AcnStMjWUy6h71RRRmp3TzcX5OMMulJFs20mb1L9nMMfeNlvpKhW1zK+4hN2PCjWVeuGF+vM3J9BK6nC3his4LDOEWCqXkIBQhlJAMFix62Il1GJywlyL+2/PmHQ6MfyykNpzyInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5uQUaWe9MJOGk6SWw4W/BhObwrq5+kcOeMvQtzJFRo=;
 b=SW5kd4mAf8kcC1DEGG0bOdarmZZ9xtoRbygjqZhP8emIywnDptlo7Q3YacYBsvhH4honz7XfWFMytq6Ntj4aOWofqMeDHiZxPFxxs+YZk8l36JA6BhR5QityFHyie6pTdXk2sJdpwKhH3T9CNftt4pnI34HeQ8MzU7R64g6jVxW8RQprmwd8pNwj00hl9A0CMRptrQa0i8hhjI5kBi5N1ifsllL4JGCV/Y9w3TMVbhPq53gPhj0EjuArNNqKImFsDd6iznrSjLVX/Mnbe/LrbLjB7sHtw5jeNPs7IyfzMP/qPmsGLhRtY/zbJOP2E8vkEK4msSPHZEAcMePxGX8gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5uQUaWe9MJOGk6SWw4W/BhObwrq5+kcOeMvQtzJFRo=;
 b=WEu1X68GtfqI59n1+vOnii9K6/v6ZyoSHpKKTFlzXC/RJcqF9TFV/xnvlh01I+VEQgaQ0geVyMNAw4XvtgBgYx6mu4JhKgxqqfgXupAwxbwntW0yaD/Q4/OvXLHGr1OIEvcUQlbH9h7BfiNn1fPJTjv2gRYRjoH1v5NsVlp5H10VM3FX6Y9sVk7fAPlLfh1wd+1S/C85Df7a/FBJxtnP7DsxpUUBsUITlu9W9/ll3/6bBphG7nZDRY/M2bSYFz+WjnbJm0XTAn4TF2aNqkKfR2s8K45b8LPIX2XMmo2TC+ZaiI7FF6b2Z72GK+JwcSGb4dSwKQqACiliH8dVviZCkQ==
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 10:27:53 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::9d) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 10:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:27:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:39 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/11] mlxsw: reg: Drop SGCR.llb
Date: Thu, 19 Oct 2023 12:27:10 +0200
Message-ID: <26e24aa08c174286ab96080fb783b066e19fc7d3.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 50498584-2d65-487f-7e90-08dbd08e0d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KHh6eAXppBTY9bvN6KexsNLwuvaw601XoCQgiYw92AOqtnwtn2bnHl5I9V7emC+tHygqmNl2Fhd8xQ13eAqrf84JZPER0blMRo9oYL6lczYUdwmUMAkT3TzPJDw2ZXM6aaIJplbLkJbJtVky8g+asT+9otDA/zKTalxEhMD4TsA2k7AOish7iI8sMoyIBgz9gbgHTtAUZp3P/70YrauaOPBDofruqfPUIqSQHZbWrmnPDSvbZBATh8FfzJGasc8z3M7gkeveGxeAVfYXxu9xpwE7DiwwVBtXFAziLAUS2dQiYUHUf77SwZ3IgVVtuXBeze0nuXbuAHbqDQ+xToDnhSNEFa9UQRRrG+MAB1dVNDKp9b/AH0teqXEpUaSNrxSK9GrWLUIlciWpvA+QpsBn371FKD7hIEU3aLFGtYRmT+phCBjfy6TvljgYUtNVZdb+BJzWRpuVKhjWLPEtMtJD1JCrqwTmagI99OFZsz95lI/sYvujakOQpbfS7BZ4AqyJ+bO32P7/PL+9KnrrmrYUPShzkuU/XIq5pHt8MtYb0uX8laKLnu9svdGt5JOZ8W4p8VAgVj57RRDnEvDuUkAtmip8fxE8+Ta3tsOPiPjC4yIew6IXlz4yUYCQkUEzKGhMtsNXXKkRxNPmEF5axuV2TeKy/cd8H+/OT3sQutk15LUT9yX2Ic9r9S4d5/B7QYHwUPO8H5sPMiyoh1s0K5+yImL3lf8hoxPj1DmPXUV9JXWzq2LX5CoutyBlttZaMWdD3S/CazaeEEsWAjUWFBg75A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(40460700003)(107886003)(2616005)(36756003)(86362001)(316002)(110136005)(2906002)(8936002)(54906003)(5660300002)(70206006)(41300700001)(70586007)(4326008)(8676002)(478600001)(7696005)(6666004)(426003)(336012)(7636003)(26005)(356005)(16526019)(82740400003)(47076005)(36860700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:27:52.9029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50498584-2d65-487f-7e90-08dbd08e0d51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

SGCR, Switch General Configuration Register, has not been used since commit
b0d80c013b04 ("mlxsw: Remove Mellanox SwitchX-2 ASIC support"). We will
need the register again shortly, so instead of dropping it and
reintroducing again, just drop the sole unused field.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index c314afd4a8ff..ba00c68211c4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -38,18 +38,9 @@ static const struct mlxsw_reg_info mlxsw_reg_##_name = {		\
 
 MLXSW_REG_DEFINE(sgcr, MLXSW_REG_SGCR_ID, MLXSW_REG_SGCR_LEN);
 
-/* reg_sgcr_llb
- * Link Local Broadcast (Default=0)
- * When set, all Link Local packets (224.0.0.X) will be treated as broadcast
- * packets and ignore the IGMP snooping entries.
- * Access: RW
- */
-MLXSW_ITEM32(reg, sgcr, llb, 0x04, 0, 1);
-
-static inline void mlxsw_reg_sgcr_pack(char *payload, bool llb)
+static inline void mlxsw_reg_sgcr_pack(char *payload)
 {
 	MLXSW_REG_ZERO(sgcr, payload);
-	mlxsw_reg_sgcr_llb_set(payload, !!llb);
 }
 
 /* SPAD - Switch Physical Address Register
-- 
2.41.0


