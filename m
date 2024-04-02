Return-Path: <netdev+bounces-84053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B956C8955EB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8891C2238F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86585283;
	Tue,  2 Apr 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="muimURm3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4986264
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066277; cv=fail; b=a4Mo611diTFaQmWDLws4kYX4Xb9l+hu2YAg0Qg1efOmVL2aKf2yQA/PhR83BX1YPofe3WLLHccQStl7KTBkyG8pAnuHi0XWAWOzlS0c/LPukDdAYIpO2zBFEUNLguRc72ZCWQEa5ZPFeW51pD8tdpb/z6oRgNfXrhJgHZFhCOEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066277; c=relaxed/simple;
	bh=xfI8achkoHTZD197SIN3sFIkkG4HozKjChveRjQGLtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cO36Prdisyx3YgGbCYkXDUgyahW/UjLPGDLsg8tscZ9SM3XXEJ0itvTcBftH2lcORYLf7wehiffxhVLuzOeARbA6Bu5PkOyeWgptk79qL9x3wE4jKIzrm8Eh4pc/B4RZOBvypZovX6W2O8Ee/ZZfcprZTqKX4w6UPUKCEkSU+fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=muimURm3; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk03bkFNSGexI3hPeLecTNnIEyhju2QbLcoN2c+Rso4Uj0JF+Xgi4qxFZQyiD+matTF1p046XtMdubRkTuzMGi8IJQZPrGHNn7tyoM0sTyRhveAnFTxmeXRoAdAeiX29PsI0dZXpOEw+PgblU6755rnlwwdur0vXLe1HymxP8/mrG0V8oXNCtmDlnSW2Mpls4MYMcdyxdysqlcmYJ03gytEjHbrLv19QPzGS+WWpx0E3NAaHaDEDLxJX6b7Ka+fEiuhnYWQG0u5FQmlobkx56R9RKHllQtOtTCHT/sUUsp3iEV6pNvbQunZj9uwqmuXAnDgfO1ASmjQkeN2WQb45ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2vJturHBXV2yuDozLPNRKuwMeAJfmHofauGZAkZCZ4=;
 b=CQzHpSCk69DkZeS2shl7Q62fvX8N7cd0WIVEBPl1b5IiZrIj8NCgqjaXEqFSApj8RzoRsSJgz6U3rLMS1L4C6dRfWIkTcWT2mqogyaSJ5Hl16zaC8yldJg36EwbWFjjSco40ok3MthgjgX439KKwVSxJIjfivnNBHmaIvycMFL5m8TbofC0twzT78AZiGZ4bsoF7V6trovW/vRSU0lltsZR8VknXgtrkgYAP7FfZsXmpVOScNYrPyy4k3AD/s9iMUtLCSx6erP77VIVfMqn/A4vyq4T/5L/QwMUXdY4kD0vbmZN6wtgPheYmsUKLPLSE08AsHzgvDp6rsIVmt7r/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2vJturHBXV2yuDozLPNRKuwMeAJfmHofauGZAkZCZ4=;
 b=muimURm3DOGmV+zZMWWrvRGPltfHL1RX6zwcsOR3eMdrkoXuwW4i6491xSnUimbFaIUXmfgE3VaXMabyno1sYaZQe6ZUlGvQOOAGWvpzy3vDgF4tF+jtQTxco5RyCBXAa4CrWbvlmczcF5YuWDxNzideObnedOrXsKjR5StSKxupkz3KnfZvOq+TtF9S0Eof/OpOzyAaw4n7Dp9k8NZbWH0oivNuh0PRaqspzVE+D513avTEOypFSs3vF6chs3/q9EXKb7TVlCSq5Yk0/QxkkNhVSLZJE0I7REiA6NERm6A9TcsaqhKChvq2vAT23boL8lWwqIBhsSisprK73Z5gwg==
Received: from BYAPR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:74::44)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:49 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::29) by BYAPR05CA0067.outlook.office365.com
 (2603:10b6:a03:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:34 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/15] mlxsw: pci: Remove unused wait queue
Date: Tue, 2 Apr 2024 15:54:23 +0200
Message-ID: <f3af6a5a9dabd97d2920cefe475c6aa57767f504.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 511733d0-375d-43bb-3cd1-08dc531ce173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5k6eq66fbYhjU3pEMUZxF3EbomC/1abR2m4c1ULO14GJ6kSSSt6JyDcLUCCvfsJXmZuX9GJYdE9gZayCrHtUJ61wVBNoqSSJX65ZAiUIZLEW/5/m+fYjSeDb3nyFPri79Ah99WZaWYmUzxthgIUfczmGlUVpRQaCztEMjffnxS7bBnnaSzm02D0bEBVT14bQ+TsyaBsYKIM40Bm1BTsE9tHUAmHnYIEaNPRYpfkwAfa5/1rF4BGUAnlGmjMNgYsWmPg6mlast31B50OF1sXSNzk4AnRIA8hWdiwNUsVok+BNhdFteQnh12HFiMvgM8KSEZDFq1M0okty77Dm6vFyN0alV3BhZ+4Z+uCN64ipdjnRTmjMtckzYL0NhjzCKgUJ8M6p2GNvcxBgVLMShMCgkzMcKHb6IfUwzfrIh1gYeg4k/MuHLEQl0dExYS6arghQyTQpv4WQ8B+8BragVAr2UwOvUQ/0CNYgaYAozyTCZxfzzB8Y35NkX6rypE4xEGz+5AyFtmndn439MbdZ6+hOc+qKOe/BLBItvele1Dgt4huS08PogWIVk/9qpBu2FcE+FrnXUQ2HjXvQEx18kpSNg9OEUCvapa+tgr1y8y13qZ0wolMqyPmGZP/bhPlsIFEVUN4Ho960uidtRyVSX9ykhFl2qGdoNpOsARdtNIMOLeQ2uAyhseDBapssn63sNWWYxH+zODpmE9ME830LrjFYANYAyEmKmIRFXDVnMsozlHc5cb2YTPKkEbT+c4LI5Hsz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:48.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511733d0-375d-43bb-3cd1-08dc531ce173
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

From: Amit Cohen <amcohen@nvidia.com>

The previous patch changed the code to do not handle command interface
from event queue. With this change the wait queue is not used anymore.
Remove it and 'wait_done' variable.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 3460a4ef7d9a..7f059306af5a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -8,7 +8,6 @@
 #include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/wait.h>
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/if_vlan.h>
@@ -111,8 +110,6 @@ struct mlxsw_pci {
 		struct mlxsw_pci_mem_item out_mbox;
 		struct mlxsw_pci_mem_item in_mbox;
 		struct mutex lock; /* Lock access to command registers */
-		wait_queue_head_t wait;
-		bool wait_done;
 		struct {
 			u8 status;
 			u64 out_param;
@@ -1819,8 +1816,8 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 	struct mlxsw_pci *mlxsw_pci = bus_priv;
 	dma_addr_t in_mapaddr = 0, out_mapaddr = 0;
 	unsigned long timeout = msecs_to_jiffies(MLXSW_PCI_CIR_TIMEOUT_MSECS);
-	bool *p_wait_done = &mlxsw_pci->cmd.wait_done;
 	unsigned long end;
+	bool wait_done;
 	int err;
 
 	*p_status = MLXSW_CMD_STATUS_OK;
@@ -1844,7 +1841,7 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 	mlxsw_pci_write32(mlxsw_pci, CIR_IN_MODIFIER, in_mod);
 	mlxsw_pci_write32(mlxsw_pci, CIR_TOKEN, 0);
 
-	*p_wait_done = false;
+	wait_done = false;
 
 	wmb(); /* all needs to be written before we write control register */
 	mlxsw_pci_write32(mlxsw_pci, CIR_CTRL,
@@ -1857,7 +1854,7 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 		u32 ctrl = mlxsw_pci_read32(mlxsw_pci, CIR_CTRL);
 
 		if (!(ctrl & MLXSW_PCI_CIR_CTRL_GO_BIT)) {
-			*p_wait_done = true;
+			wait_done = true;
 			*p_status = ctrl >> MLXSW_PCI_CIR_CTRL_STATUS_SHIFT;
 			break;
 		}
@@ -1865,7 +1862,7 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 	} while (time_before(jiffies, end));
 
 	err = 0;
-	if (*p_wait_done) {
+	if (wait_done) {
 		if (*p_status)
 			err = -EIO;
 	} else {
@@ -1963,7 +1960,6 @@ static int mlxsw_pci_cmd_init(struct mlxsw_pci *mlxsw_pci)
 	int err;
 
 	mutex_init(&mlxsw_pci->cmd.lock);
-	init_waitqueue_head(&mlxsw_pci->cmd.wait);
 
 	err = mlxsw_pci_mbox_alloc(mlxsw_pci, &mlxsw_pci->cmd.in_mbox);
 	if (err)
-- 
2.43.0


