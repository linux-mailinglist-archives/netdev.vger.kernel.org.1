Return-Path: <netdev+bounces-47970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6D7EC210
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD060B20B4A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8951862D;
	Wed, 15 Nov 2023 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UbM0Rka5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1D18046
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:19:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422610F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1vZ0I8g4mVL6xtk79AwkUGZn7m5Vd5NA/pr2DoPJ/+VMcMCg1POYw0FjekeHXNQfM7kPJqG2867DH1zVpaH3geqvcDMCZie/jw4D69IGjxte7INhsQoLrGqCyVtQ07DU13SVoXUqec3n5EwBAF6xXe2k0o0KnbcAzKEq73JNNMDJYcWXX4uZLtpyJejcmUWewt0EoomUAdumZKjp2eibsKAP+S4lEnLu3ApKJ0bbOEJA8B1WfDk1YEo+DtHGMU/cMyCe5jVBOTQwwFLOMwMgriZFpRESDiNZrypOs8cO8wlKsx9/S28pyaO+i4nJnL/qt9p5vp1mD2HC4lgIuVniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2q1ZLn82WCnaYYCTrxUXXHA8oO6H2zxra7tBXu+pCw=;
 b=TQKwhiVgK8FYCN4Uca9oh48RofBtnqYEOQPKjpFgcg+SuLKvinDUoOnMfzDoNctGbRoDequJs4QOPxGgh8shXyKERTR96XVsyZuDc+DyfxWCV5fgxKGSs2eWC++bF+5e64S/jUcEDPqzCOlkM4+ASUUMezekqd1mp+WhKz5663zlBbgOEV3ih9u/13mP0p5mz9qLj7t5D+gi8b3hBzzCAeXP3zMmbOgxjSUf0WPH5eGJIX8YQ3ZS4I5OBomxMpPaCOj39eQotHrYV+4x/rCEvpFUuMIXNics01kQNuinYQuittEQ4KVxNm2ApLQXxAKTdfDeGEYRFYaT1Z+Ue+R9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2q1ZLn82WCnaYYCTrxUXXHA8oO6H2zxra7tBXu+pCw=;
 b=UbM0Rka5ECXEScAJ0g2SkgONgs2byI/VLrf9ZzMx7uy1EMpw4wmZMZBfc/DOhq8HelGuLhZ0ZchXnbpAiKphmNMjIJ89TyvAaOL8TVlFBqZPSpYMrkJdY6sLf4UR01FbIQwnGSsXuFuR2y6FVYgdD4yNuT4MHCYcOrwU2cOOP1cgVeQMMFpbnlXdsucPCBiAtH2ZPACRZ6lcpl0M8CcL1iAIJVoVNzTmgLSJo1YUw5zMVbpz5ib+nSbJrEjz3I0uv2emf2surFboeNAE2C+aol7DvUDXKQq0tzK+zZ9YmcfPF1aprX/pCDdrAGfCxz1QLa3J9Dwy55NLqYAmMIY2LQ==
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:19:36 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::14) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 12:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:19:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:28 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:25 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 01/14] devlink: Move private netlink flags to C file
Date: Wed, 15 Nov 2023 13:17:10 +0100
Message-ID: <d7728a0cd7e1643018306e8cfde0d4c0934ee2be.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dde8808-d26a-459a-ca10-08dbe5d521d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dMfInb9Hh9lSi3KLAVa4UTyYaUwjx/+CPHtMG0h8V8KLMaBWmizj4BOAa119ID5HWviDTqWopGX/Me0ePtJBizPopJ0zU76q4O4lms6Q15Oc8QY5xEbzzbcFnoKT9dWEEdgq6tVf72ihwnmWLifI9SJY9MUAyh+wRSrfBkIfZ3rKUNdSWEwDUPqstrr8j+7ayfXU1PihEgnTEz6+7wFmFuXP0/h2L1rb6UaEC5N7LtBgiHE37KNnAt4pOAJ/9+4svQVVBCueEuazQ9s0jNqJgB/p7FmRatr4NpahsmsyXnH4QgmP7rD5ZmYnVUOmT0XLTl6FPC7vgYdUprszGlkqUZ+A+7ns0yWqFKtaeDLyapmZpgynrMsuF+xhsTmkd6cFhi4CGFBSfjBthJJO3qSIJedX8RVPVDbYjbUoFeLYBFOIfI6fC6MEZqPyHNpFyvO2nyLAqIpZl7g45omDeg7anyT6dPELimxBjwIjhXeEjYGZcKZ+n6rvrfniuOSxtzlBhmPzvGmU2xEdfofid6toSyF7f6Z58VUwVPUbje+1UCo9zXNze7Am0GFKEiL8D+sAklp3Ea+vHY/RzMhFSL4mZPcEbME8vkRJhxA+A3tYL87h6sL3E7Xz7PMrLLxbqbOzdbXVGUNRnsd96ux7CRFCsUJm1b5erDCzIGXEOi1dak0lWogotaGYKLpjefGRS0nNJjTAxNnMAw+Cr1VsO3i9J9VGbh10EzoNKYlcYpVUWkS+zq49ucq4NsfnQwlg1nWr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(5660300002)(41300700001)(54906003)(356005)(7636003)(36756003)(478600001)(2616005)(26005)(6666004)(107886003)(82740400003)(16526019)(86362001)(426003)(47076005)(336012)(36860700001)(110136005)(8676002)(83380400001)(4326008)(8936002)(70586007)(316002)(70206006)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:19:36.0155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde8808-d26a-459a-ca10-08dbe5d521d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

From: Ido Schimmel <idosch@nvidia.com>

The flags are not used outside of the C file so move them there.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/devlink/devl_internal.h | 3 ---
 net/devlink/netlink.c       | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 183dbe3807ab..2a9b263300a4 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -111,9 +111,6 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 				   bool *msg_updated);
 
 /* Netlink */
-#define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
-#define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
-
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
 };
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index d0b90ebc8b15..7350138c8bb4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -9,6 +9,9 @@
 
 #include "devl_internal.h"
 
+#define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
+#define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
+
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
 };
-- 
2.41.0


