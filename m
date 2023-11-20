Return-Path: <netdev+bounces-49338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D356B7F1C5A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545441F259BC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06930F80;
	Mon, 20 Nov 2023 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oi8NKOAX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F2C8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDKyZvwMj1oJ6WTZh51ladNYQN+v7xt/i4MhDoPbkE/9z+3yda1vNjedF4LYGyXb5pX2IsOKDV4XRVoQt7KDa+oyyS9oWjRycJseR/j9sJ1AKOoidbQyZ0q1zQra/nytksP8VS/b7JL6qYLHvsYvgcYu+cuQvuXOMUSI0q0cOOHMNzSy/rBPG7yxzg50bj37uT3XvOsoNQbUd45qLBiaNNkGkotXUIifyAlcqnWB3tu+wRPMCn8TwA1kmubYwwjAppHz7GLjKxBm7XzDY732BCqNlJ58h2+wOc8nhfemEakHW6t0KBtwSlcJvXCzU21DTYbUATFKDSGkW2HKcVUi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6n3eU+IroW6EAURjlWGb7Qfea7ndamUVgOPoQwdUFA=;
 b=ROlMIof7xF+przAiDUVqcnqQR3so/cQDrZtXcjBeIeMgURonb73HQgm8OQXi4TkB+YNv/GEfIrYTWBEnX9HoGP6B2/Zl5n4xSn/QbqvlaZCIGEJF/4/ex/kQ+PnhNzR5GFh8YCaesL0Odt3Y2qEHdJsNBPeacJkx6AVq0kLK8pgmmMEt+WPV6o40JKfGMqIOe2xrDUytnD5aLiCryPRvq8xu96SG0li5mreUFUU+4hqnmHgcGOZhrU9g9zX+OkEJH+9v8V7tgUUyB8JW7X/4TAh2hgZVI9qSHskR3/P+3t59T0XBwltbzlO693kTntQ3+wzwJHIC0C9SjgoDx/8JQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6n3eU+IroW6EAURjlWGb7Qfea7ndamUVgOPoQwdUFA=;
 b=oi8NKOAXBVfD1mfXEGfEjh1rH4b8qPi7ItQZEN1sM00Ud0NX5caZH3D9MrBaLbXJJqsW2TclX3ucL9hkna1nrITKkGvEYrk2mL0jGvbSIYzVe3SHRWsijlZLhIi8jBJhUEM/z1IMlxH/HTj6QgBq693AgA8OwwxzRVrsOuJTDZR2Ca/EHZ7SseXl0TbM807cjlQ8H5X7QpNY+/2ciE/rYED8GQAy8Sc5x2YAitGqXB3iljt+C1p5q2hrW3eSr/JdwuCEy2eYpPjSLDfhTLoee+IvcnAxg6baNcAHKGrEJ5JZCR4SlBXz2T1/hP22mv4m0v5ikBhdsZSB6eR4KN52vA==
Received: from CH0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:b0::20)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:27:53 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::a7) by CH0PR03CA0015.outlook.office365.com
 (2603:10b6:610:b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:36 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/14] mlxsw: resources: Add max_cap_nve_flood_prf
Date: Mon, 20 Nov 2023 19:25:20 +0100
Message-ID: <064a2e013d879e5f5494167a6c120c4bb85a2204.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f536ba-b66c-4dc6-3a37-08dbe9f66890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ilniPtvypT1fEiu5H8c769pGsgNdvCdkRiovjEx805O4X9QHLMgGoIiYsDUBUmDZ+P5PCl3V1dQWNTxVf/sb5fvYKg8QpgFUvGDLcN1I4WyFRoX2TISkCY52L2EduQm8l025FAXmRswu4KWlTZ55V6xcYgKC8w8hH+neyWb9sGsKZbMikLNE2XRt6ruQWeZktEp6QPlZf5x4UVYHQuqQYTQj1Vcm7Qy+37TABKwf6OXlcyxkUsLGsCsf/8skIChG7WJRGDTovH4J2HFeYdqh0v0KqMtIIvQW+/CGy+GV7nVaWxfC8PM2pVGJsm9U3JzT6GjIYbDBA8GeOVmgRluCmNyERjfLZcr7uh6cJfjXjDUGZqakQ3roeZbIIVsgh5FSCUkArBFRpqTyorwgkQrcxmDxR6PZui1KDXP027gMiw+W9CqHSKuw410cD53AD3ZY+6uE0DooaYS7uLD74o3jUeYae4ly74IMfScO0kkoHQ+Qj6tLEDSNTXlJ9zxkHF1gK9lw9/r/atNVnhupBTW+xXLGDrQCAb3nPpb+AWVZhSWao2vxb0R9UayAlYJnngV96X8xYBnqrWoAEu17RRiPdCrLTMxD/Iwmew9MFztu+SZcogXX02/kWP06pj7aeKVXU6RZCkoRhDbQ4swPfxeNy2wWyg5Tm3ZrGglYHEsK8+KhkUwKrVLFJ/PhLc5Y5zwlKlaGk7xFDXHkk/b9EOMQAtptGjeujxgJ6LjKWfeHTkM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(36756003)(86362001)(5660300002)(2906002)(40460700003)(40480700001)(36860700001)(478600001)(6666004)(47076005)(7636003)(356005)(107886003)(8936002)(26005)(4326008)(8676002)(316002)(16526019)(82740400003)(110136005)(54906003)(70206006)(70586007)(2616005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:52.7160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f536ba-b66c-4dc6-3a37-08dbe9f66890
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

max_cap_nve_flood_prf describes maximum number of NVE flooding profiles.
The same value then applies for flooding profiles for flooding in CFF mode.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/resources.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/resources.h b/drivers/net/ethernet/mellanox/mlxsw/resources.h
index 89dd2777ec4d..9d7977ebe186 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/resources.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/resources.h
@@ -27,6 +27,7 @@ enum mlxsw_res_id {
 	MLXSW_RES_ID_FID,
 	MLXSW_RES_ID_MAX_LAG,
 	MLXSW_RES_ID_MAX_LAG_MEMBERS,
+	MLXSW_RES_ID_MAX_NVE_FLOOD_PRF,
 	MLXSW_RES_ID_GUARANTEED_SHARED_BUFFER,
 	MLXSW_RES_ID_CELL_SIZE,
 	MLXSW_RES_ID_MAX_HEADROOM_SIZE,
@@ -88,6 +89,7 @@ static u16 mlxsw_res_ids[] = {
 	[MLXSW_RES_ID_FID] = 0x2512,
 	[MLXSW_RES_ID_MAX_LAG] = 0x2520,
 	[MLXSW_RES_ID_MAX_LAG_MEMBERS] = 0x2521,
+	[MLXSW_RES_ID_MAX_NVE_FLOOD_PRF] = 0x2522,
 	[MLXSW_RES_ID_GUARANTEED_SHARED_BUFFER] = 0x2805,	/* Bytes */
 	[MLXSW_RES_ID_CELL_SIZE] = 0x2803,	/* Bytes */
 	[MLXSW_RES_ID_MAX_HEADROOM_SIZE] = 0x2811,	/* Bytes */
-- 
2.41.0


