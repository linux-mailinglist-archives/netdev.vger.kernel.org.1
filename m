Return-Path: <netdev+bounces-216280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B65B32E41
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9766D1B64812
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AD25C706;
	Sun, 24 Aug 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5CH7sv9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E025C6EC;
	Sun, 24 Aug 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024842; cv=fail; b=r/72V/2exTYuw7AkKEeiQVHkbn60DQ591zKdlyjnRHpeD0MXcxmHTPh+zr3V9RCUHiEgHTtCpqlCTc7ht6QSPoWoD/SubK4aGzBlikTlGiJunPD6UG4XshT+FHn98Dir0tuNS0AAm4hnQIeUr6cZQB2OCAP0Ju3y9Q5wppV/cuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024842; c=relaxed/simple;
	bh=JE1eBLNmX3rogJ4DLnXySTyZtnQasbQx+L8iX7fMxAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t37Vext6X81AH57PeNsZLZOoUAu0vQ/iKcRag42ryi1nlNZb51VZ1ATkm8DJQMGbfr2fgDSfG/9LtufegrfFpVtd5fXRsDHHx5Gx26GQBPqBTrAP5erO1cEfSnFGZmaZBUe1GLoqwXFO/XIeVzbZFqrZku7iuvOHHY2+Bq2ZsIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5CH7sv9; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXbqovrs7GvWyZhflNW2Bc019MmDkyAJaMeQcIxZ+7bFx0jUiYiD74djOcA2TlHvWxJyShLppAJ9/vyBAHLmIkEYvs2pWisksQ4BWzPjJzT0b0YgVkRcRmCUwk2knS/TsbUcRdvRoCeQYeHA0esAtV0bSQkpzXTHpgr2YuiqY7Ticd7mtGFXVHTLaWFcPWDF5FW+CunbMuW+pfClPL+wiKiehfuZfS8qfRY3y2B7LSweejvpVrRDHiKTqXRnmxtCdFHW/5Bzjf+ELjqxEWApPg87o69nUX7G518ceB5fhpFgrJPJauGmduyerQnGBxmkrIsvFmkjpgEXRfgzt/pJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC6jKf1uXNMAXAqRNuaoFXzlguS77lxoOrcxLGKaz/Y=;
 b=qb7xeaCUc0DPKaLAtdbRUwpq95SPn1ZPEt5nH7c/Rgr5EVvXXusJHo9xnYtzCYP3vPbwgSFamgvjcO2msRS+EYa7xJgcrvfxhPHA3Aw01+HxpZB727cuwAUuVbMdZFbWgBI1t0e9mmRGs6H6Ib29arOR/X91HLREGyp3zz7aUaK0ky59gL2Qps23mG8PlGsdpVCOq4+/iwNkkp7+qnPyeK5X2ek7kueTPVDPQyTrqPwO22fHRybEAP4IzpfNEQP/mjecXDB1xnthcPBre4Ru88cB3wSHgCW2wr/davP4EAOD0OQxghG8bHgm1JsVkNsjGJS9Pz2DkzyOo3CpNczrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC6jKf1uXNMAXAqRNuaoFXzlguS77lxoOrcxLGKaz/Y=;
 b=E5CH7sv9oOM00EvDeL8M6TzX5y0dvZ8ST5ka9yrA6UNQcsW4+W4IJZuEKFQnGmtDLS5sKOamvDlIRJcr+g40Al1hcNaeZMRo/+V2pU/t9aVA8x8UMIR4ZuB/GlXeJKnjcQz5SoM+Xtyl5mykgEQkCA8irQR12DQT0l85YUUukFyZuqaVtdgK8J1EUxzoFVRCqpIt2tlmjTI25cCW65wF+fJ2GTPDMHrA/vafaa11a2udePxQTHQkq8Ay7SAgmGt2hq+ydxYGJIdp3QlVYuNJro23/pHGH2QIgTmj7kChAoshXYBfndb9b0ToW6VDdIGYmQ3EyD6IEitSvC7FEJ5ISQ==
Received: from CH2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:610:54::25)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:40:37 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::b2) by CH2PR11CA0015.outlook.office365.com
 (2603:10b6:610:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 08:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 24 Aug 2025 08:40:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:10 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net 05/11] net/mlx5: Reload auxiliary drivers on fw_activate
Date: Sun, 24 Aug 2025 11:39:38 +0300
Message-ID: <20250824083944.523858-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: e12b351b-6385-44f6-0d15-08dde2e9e614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPffF0IBWuesDjbLTUoZLJzmCvZ/CBEdkfkuuwNlCHH0DF/LY4vSp9YF9yH2?=
 =?us-ascii?Q?k9YeNG3hKfq64f3i1MgEnjIL3K7jMUh+R0DWaJ6azLwl6Uel4tSm851nKLU0?=
 =?us-ascii?Q?iIB1JfHnHG9fLDH/iHMl2ImHiopczRDsjkqA4q45XoVtJWfSTEDek81PFXzF?=
 =?us-ascii?Q?P0043wKMrG6SUIccqemXHmKJGwz0DDYlHT/QJFKcK7HoVv0PiP0U7ikBC0il?=
 =?us-ascii?Q?/DHIPAYibAF2jGCGseer7Btg/87GYJFqPlsrX1Wd/zb6XvC1qVQamDfiwQPr?=
 =?us-ascii?Q?n9h8tsoJ8+qRUD3x2AR910fNhenIJ6beew3hmrw4BB9EBwOZdsF3AqozBOsz?=
 =?us-ascii?Q?8DcqYZ4g0VcSDUa4BbbWxPlKNbmp9ww6ga+yVw1Kx227DupJDRcMHz0gxDcF?=
 =?us-ascii?Q?CUtyLDA7WaZQRb1wWd6F6kyW42xrnJKeXm0IgDBojhHs7AViTMIAzgVV/86O?=
 =?us-ascii?Q?/jKzqFWLFcMACk+XXT5qXY/eC8yYK7SYpQEtO1b3EmuJy6RnRxcAGMSXhirN?=
 =?us-ascii?Q?QTI/7f5eoXgZYK279GbcKqF0vI0uAD4hiuGovnXbdL+wQJC7CGhjoZgT0eyM?=
 =?us-ascii?Q?84vYlsEQo20M6UCuH4TWCoEujcPRuMQrlzC5iIuO0K2Y7emdKhNeFqUemUSe?=
 =?us-ascii?Q?fO7tFXq9pYsnPOPxEkzZPT2egBHsD8+AMjcFPGW6TuiTlG2Mr+gfpCGFXajN?=
 =?us-ascii?Q?gPa24gsqUpxwogIAjrpWJsSlYjxt7kaYaY9oLL7d7UljH3u+F9BLzPN/82Wd?=
 =?us-ascii?Q?9ulYKb7v5C8Db+k6P/GVOFEtP0aqQ3L4vfXjjOvUBsg2i++Tzk4v/AgUUoIo?=
 =?us-ascii?Q?gJUw+U3JfzLFbA5Xccog7krrl8+PD/r3Bd9aD2d3CtYEZXN1X3OnxTumdHgO?=
 =?us-ascii?Q?r9kB7nEAe16MUx0CvsT2B9NzbDI8aMLjujTTJrPiukOXF+R56Ou9xOdtdaPG?=
 =?us-ascii?Q?JUCnJKiba+2DuBHlvmxSeZKxpmwKIL5PAvsebZCG5a0wbPlYIhbje2hkqmQD?=
 =?us-ascii?Q?t8C1+sFnAqEhl9WCLNaRVDFEnuIHyWw58KHYIcOscSW78uqw0UhKRh3Nn0xE?=
 =?us-ascii?Q?isop5K/5TKKX/MNxWAvPNxA8QTkPA44Ukx8UHSB/Xxwk2mZpiqCMx+8bvg4w?=
 =?us-ascii?Q?X4ZwDHnbWORJPW4zCnHi8GDdEGnTskXifXkNWtRDfoITkyw5AMB1xEWRUwOu?=
 =?us-ascii?Q?JxQPqFH0rsXMhZ5c/6Qpml7zvcc75L+DbZlIYKlQmljbr5vzofjEZvvMCLwY?=
 =?us-ascii?Q?3+cnFfl1RCgG88/aJ+ZpUG9hIbLAtOGV0SPVCoONtQ+Mq1CCsiwPCi/t+AK7?=
 =?us-ascii?Q?deexjmjezTBV7IseTp/wSuu2FKxvaImiaZ8JoK3yGKN5lERh2pQ5eS9Etrmn?=
 =?us-ascii?Q?76P+PRCvt630cSUt3l41P8K1EWzZj+zyBn5TsbRcBcu01ZhPwIyPznUlMNbA?=
 =?us-ascii?Q?e+jvY49XfwHFH3GU7t2jwonMuhx9qLjOeLkZa7B4jMU4SPDQq/3pNb27/RS4?=
 =?us-ascii?Q?guXdyX1QOBCrMj5vep+XBxTFTRUfJ8gyXzPg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:37.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12b351b-6385-44f6-0d15-08dde2e9e614
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

From: Moshe Shemesh <moshe@nvidia.com>

The devlink reload fw_activate command performs firmware activation
followed by driver reload, while devlink reload driver_reinit triggers
only driver reload. However, the driver reload logic differs between the
two modes, as on driver_reinit mode mlx5 also reloads auxiliary drivers,
while in fw_activate mode the auxiliary drivers are suspended where
applicable.

Additionally, following the cited commit, if the device has multiple PFs,
the behavior during fw_activate may vary between PFs: one PF may suspend
auxiliary drivers, while another reloads them.

Align devlink dev reload fw_activate behavior with devlink dev reload
driver_reinit, to reload all auxiliary drivers.

Fixes: 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in case of PCI device suspend")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3ffa3fbacd16..26091e7536d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -160,7 +160,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev, true);
+	mlx5_unload_one_devl_locked(dev, false);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
-- 
2.34.1


