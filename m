Return-Path: <netdev+bounces-84051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5CA8955FA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8738B2332F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF385925;
	Tue,  2 Apr 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFhvD/I0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6682893
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066268; cv=fail; b=mNpIteEoFYNbG3jBf/ArfFMCaPqYwr9CCNdwDftZqw7uuPevGbc8B6MrSOol4DrGm8XDBYsCHaLbnZy2AJaur8V6DO/8fEeCQURmLDMMhQQkUpIt3b5v69gI2jAOx2TICRa0Q6cAAPBIZiQVh1+5Zjs1iCNXUyMg1/QMcyF+mVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066268; c=relaxed/simple;
	bh=fOrN4hCYaKGyqH53NTMdI7HdpkRsp8kASknvFM99NQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udcq97F1UXshXQ98a6BGDOIOqYVONn2xvbBrMZUkqkXn/R374hXsGN7fOEhG8r+eF48Hikzt3Mga9ri/qLdWelLIsS4sb6sC8i/xUbUmn3GWcFl0KvB4wXw1wfUVe19RLbxFpbdb4I4Q0WLISaQX2sJea+4pXi19Ka/q/XYVvTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TFhvD/I0; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abuHbou9dd10Wm7S92GeOKUH8/XM+XWFq5Lxa0yzecKQTYPgCu01KDHBp9qtcwQ+ZR/fjky1Z0sp+25/mOOuiMCHLyZeo/c7Ikc1veNfmLq7ZNvfepAnL7/aYo3uRf0dnG0/UyrFCdrEGzgCh5FqraYewhE/RN21m8+3wgPY+0P+Xc5fPKYS2jWE07RTXooCOIH6oGiW51zRdbNrPzTT4rfQbJ1djZlypEjLnemlQtu5nzpQ9oBsxCmBedOtzfHQKa8qzomG3MDY7ZaefSKOuspS3t+uu+cN2WQZhfYIjj6GBWsuVLQrSyDq+Tm+fwC/V+R0P7Jr4PEA6yxszd7toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrAoGk87e0kMO3vrEGw1ohOvppngE0fVYrxkaMcFvAc=;
 b=CcpP0SpObl71db5/KPCQr49yrEPNyZ0h4pCz6ANQPw25y5glneh0CEc4FhKG7LHZm/jis32IfcLii/wDImJo42Rh1yGNW0MRxwZo9ltg6QfTTsHJ9D1SmsT7Pi+lPdVmUJq01dZffZZMcqtF7BJMKh1EjM4w5/xPbxL5Lbq/RLmxAWHuXoqiJEF7acGmO+UfTV18yyydOa0XGlCXivFCyQ97izGo8gImzPEBjbJjxYwg0cjuWcYzKZbn/TXr2pD0meBOH9ERHZewQK+FPFo/sBLSEkkF9Or/s32RNEHDfltpyJQHi6RSSjxxGG3VFh4ZSGyv2esel4hXs8qyiTn7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrAoGk87e0kMO3vrEGw1ohOvppngE0fVYrxkaMcFvAc=;
 b=TFhvD/I07hbLzRKCozQ9ZyGFRE4Ve+jj06A1KUUG40g+cmOFrKaRx2TXTHex4dQsYJony3FGFuTWCPzOVfAdtPaZr02A2HTD9+pW0S/y/2/vbKQ3wwjnAm4DE8EbXWy0vKQOZDgqr1dg7aPeMrZCfKMPuHZukIhCmP+VdA+4JD6DA+iuU4wmVkuMCmwj0RNf5FYm0ka+8ER1WFK0l9oQsOc2uz+CCIGAlQqDKogRd4XfrPmq3Sol3Q/LBB6FYv9JVDmOwSGRqiM9hCro5g6NxgBgm6hLNJoLJksIJg61DFMaNGd+h6huiKsH8PbG+ky9SpRFAGn3SIBy5o3JCy7Crg==
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:43 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::8d) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:26 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/15] mlxsw: pci: Rename MLXSW_PCI_EQS_COUNT
Date: Tue, 2 Apr 2024 15:54:21 +0200
Message-ID: <b08df430b62f23ca1aa3aaa257896d2d95aa7691.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 954ff046-a3fc-478a-d32d-08dc531cde33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AJlLW4HnJJ36WKedoy1m+yRkhGUXj9ZnyNoFnxY8k1IlaHR1w/0HGWeuYa/CHlA/CkdDlki0BRUEvi0FAG86rKMhf9qJsuRfvdG4Fc6sBnSo/joZCj9icG1zkAxgBjM5ML89huBVWGXq9IrgwkOnAecXqM8ZIqXqJomm9gSi5FF6cElG3RuVUOkls3pJmSvGDrN8lIxsoTydMvugZrfQMfLTjoIsWBHW7Lpf4/HkwLjxhA4sHB2MqIi0NPVraGZpRWdME6rw//EwDh4zb/eqLtGa0Lb76DdIBmWgrv5d3/A8tTnngKqkj0dFpuYVJgqv5t3EXG8lr15Gb6IvbgfgrYMoERv1JdfSh+4shVirgwKoMoHteHIG943U5px8tH3Py6IgoDHQ+FfrgyntqhLtkqWgKpwwo80/mf0SSKOI+mQ8j9gHKvXSxeXcGd8ZZ0/VqOpYdZghDH4H2REKkFsG3sP0sNUGq1HW6SASZ2FgDihv9OtewDNhem4WpB6LiGr0QDCT7QeQEUXCMw7v5MEVbj0S/rLfvKoaMMABLxF9v+hHv2mnZyHT6C6Z++qOHtFLRzXHrRHeG2a6vv7xPP+KIf8EiiDFPKsAZbfw7sksUD9nzlgSBMk4AWvznoutKQFQ8IeK8W0783TnpAYCJJDP2biAoyJ23uAFLv7hQUDesewENsSFzHW0F+lModY8j0KVwOzjfTTYVqa+hSfqP/a8jEGaLWGohgFEOK86eCd5QXCpy7wO9GXOE4sjyCGCJkde
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:43.0333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954ff046-a3fc-478a-d32d-08dc531cde33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

From: Amit Cohen <amcohen@nvidia.com>

Currently we use MLXSW_PCI_EQS_COUNT event queues. A next patch will
change the driver to initialize only EQ1, as EQ0 is not required anymore
when we poll command interface.

Rename the macro to MLXSW_PCI_EQS_MAX as later we will not initialize
the maximum supported EQs, this value represents the maximum and a new
macro will be added to represent the actual used queues.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index b7a83b9ab495..cb960917e462 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1059,7 +1059,7 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 
 	if (num_sdqs + num_rdqs > num_cqs ||
 	    num_sdqs < MLXSW_PCI_SDQS_MIN ||
-	    num_cqs > MLXSW_PCI_CQS_MAX || num_eqs != MLXSW_PCI_EQS_COUNT) {
+	    num_cqs > MLXSW_PCI_CQS_MAX || num_eqs != MLXSW_PCI_EQS_MAX) {
 		dev_err(&pdev->dev, "Unsupported number of queues\n");
 		return -EINVAL;
 	}
@@ -1416,7 +1416,7 @@ static irqreturn_t mlxsw_pci_eq_irq_handler(int irq, void *dev_id)
 	struct mlxsw_pci_queue *q;
 	int i;
 
-	for (i = 0; i < MLXSW_PCI_EQS_COUNT; i++) {
+	for (i = 0; i < MLXSW_PCI_EQS_MAX; i++) {
 		q = mlxsw_pci_eq_get(mlxsw_pci, i);
 		mlxsw_pci_queue_tasklet_schedule(q);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
index 7cdf0ce24f28..32a4f436d24d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -42,7 +42,7 @@
 	((offset) + (type_offset) + (num) * 4)
 
 #define MLXSW_PCI_CQS_MAX	96
-#define MLXSW_PCI_EQS_COUNT	2
+#define MLXSW_PCI_EQS_MAX	2
 #define MLXSW_PCI_EQ_ASYNC_NUM	0
 #define MLXSW_PCI_EQ_COMP_NUM	1
 
-- 
2.43.0


