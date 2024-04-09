Return-Path: <netdev+bounces-86255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9C89E31C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C517D1C20434
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5EC157E7F;
	Tue,  9 Apr 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ctf7z0DH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E158D78
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689793; cv=fail; b=mTnp1ih3cw8ip4ERf6vnad1BegMm9mTZNfwirtXPnDqZ3/tfSdtyRZydrTibpQqiolD+DlV/LtBY50cLucaD3QKMMjvKd4KFjaNusAEn4bw1uvfArTfz7MrKvV/F2yTuI9ja5LQAaSCrO0sjYAaVxceGrT+h6RDx7aBdVi7Q1qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689793; c=relaxed/simple;
	bh=HDX9pjAok9XIXZ7Iq7ODMV4HM4NuIGFo4Jc8ZWN0aYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkGFI6JqU37iK1DjaCn0WONJSJjkOW71t+O8kT/nuh6S/jQi+8ikUupzpLNcPBAS4/F0DAfSrZ6rTAieO3lORKLU2R3vwLdTn3+jez8QOVtb3W4QIU5Ka0h883VoDTivKqA6BIMmjvEigv2jNLrnNq1ascjkybmP6hB12F3YtJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ctf7z0DH; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixGiJXXO164t1HY/VS4Piq3est/RsV5Le+B5UIIwid4MufYbqHedHPNrBx9upp2n4oMqw6380pHPZtm3S64PGLC3wUCcz9u2FTFYb1ZXYjtNBDULz/sFJCYZFrloByHtLzmzvRtE888auDMPXs4tqsL19w7Dnk8Fty7JAhZ+BYPetQvJT7JkHXB5rQ9WLAJD1669CK936BTNDfVQXr1qhQ1HSb17mG3kPMh/+0Qw0P45vLWZpCfkQbTzcH+NNPRGGO7xz6VK561KVVCbWCzDo6twdM4f7GuG4RsMVEzppsAruVgp38fGWcaGrrI8zSt/AK3YPIw88xJz9ba1LskjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17sqJhLywAxXTX82fCizEnNWFW9nMykuUs/e0R+PUpA=;
 b=KP7gXZjNX6VJ1p2j4gWIMc6qQc9FgYQw/CalVYCxDgGgIQnLHpk2bKGq45kJwG0tbArK5kAP6xOyvolDdrsxfkW/IcGh9E914arqOcJjBLDDnLauxknVGCnQa2Hk8MPEd4064Xfg540th/GIu0wD83SvweFof95hTTJOvCFNs+Gh5JdEEU3rCg0YkFqJpNtI0A3pKGM38XxAND1M6W6eDJJR1nzIcwgJzlV0Xz8j+aR3C5LITmgcd0t+ujVPr4qASOx80z81Ll2l+6hONTcXEi52lr6F65ga9WG0Ed5ONL5IEQv4+egUkT5gfBEE6ga2CpuOXxfVOe7Tdq7WCO2vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17sqJhLywAxXTX82fCizEnNWFW9nMykuUs/e0R+PUpA=;
 b=Ctf7z0DHI1lOvj9Eb2HXUDEMskkg9yCCHChcCcVGPAuVBcSHNrktRdQLueZ1hyuecKHYBW7AqU2LO1mbuOCvreFiU9SzwooUVY7bjpCPK8WpAvEZd3Jw1Zu2AJnntnGFXojjg2irldmZhFcf+fzA+HrKcPq0sbpsmgmgSfCR0wcVQGWs/YCNI0WHym/SfOGP+BSo8Le2vnORD9YeUNTkYjhWUN9KPLVQgOwkSkzzmMBbfciaC+HXF2OYIqruEGstSj4kqSukJH3xM67oVnOC4Y9BCYD30I5qIk+YkXi7jnhCN1fwtPclAFoaOwQ7VLUwIeiqYtGw1vYXoIhgkPSfqg==
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:46 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::31) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 11/12] net/mlx5: Disallow SRIOV switchdev mode when in multi-PF netdev
Date: Tue, 9 Apr 2024 22:08:19 +0300
Message-ID: <20240409190820.227554-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: a3121653-54b3-4ad7-ee07-08dc58c89e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZeNtn8RM9pds+SgTHwPp9+SEyPqIXlMF5ZJnqEaQ2AB+x8VyXBnaJGyWSnoTw++OmyQsGhUNoRQ5kV+WrXO1QNSKLchzu+Kex9IMpYCsjXkIlfc5d4x4LuZFj5favkpzgVHE1Mh7NGOvpOuHnMRw/RzP7QtbpJFxkpK/cjCKmU7EqqMqCc1NGoyLr9szvovDGdQFJGSv+KccD64d0lKm3cb21V3jcOP/oIjSal71dDvGBALzPm/x2y37z2bhQp1/GGu18mRds6pT0qp9EXSAzCpIis7NDjvLFXmPJ+/CDnJqbChJqUUMWM1AjV0LUoaEzwHPN3YNqLtzTcLJTmaEsuArVlkuyZprta7SxSqmiVvr10qfd+ITX6fcbQTYbhZYVuJU4MDK7ZjF61LDNmTI6dLj1XFLG4ad4IRkxlrdXkwJLtFyFp3kst66bWJAB23MC8koiiUIbE5Dq6wbRF52aQJkdeHVwPeVXnRUKyeW3x4gmp4DXL7J0UVfaUADF4FYAE8xtJSYToIDhwpisam30u7sk/Y+ejG8pNCD5XIFlAWiI9eHlLa1nXafbUqvUC7KrnDwKXyRe/ofLJdx6M1ThCmdJYOyoCS+KpTYe1iakdPNiHZSuoEKl0Qtk/unzrABq148vebkgAwWRVGrKp/V0TTWSdg5cLC26t9XyWOLK3Njpdjwq/IKXafWooG/PiKlxNcTeCj5fZj+D5jlA3KT75iVRnOoMaKPXoChZTyVfajPPUsSHVZQKYfrK7QEU4XF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:45.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3121653-54b3-4ad7-ee07-08dc58c89e98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

Adaptations need to be made for the auxiliary device management in the
core driver level. Block this combination for now.

Fixes: 678eb448055a ("net/mlx5: SD, Implement basic query and instantiation")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e3cce110e52f..1f60954c12f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -43,6 +43,7 @@
 #include "rdma.h"
 #include "en.h"
 #include "fs_core.h"
+#include "lib/mlx5.h"
 #include "lib/devcom.h"
 #include "lib/eq.h"
 #include "lib/fs_chains.h"
@@ -3711,6 +3712,12 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && mlx5_get_sd(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
+		return -EPERM;
+	}
+
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
-- 
2.44.0


