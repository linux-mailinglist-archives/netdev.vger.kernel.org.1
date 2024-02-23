Return-Path: <netdev+bounces-74622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DA861FC4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104B41C23B0F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219B14DFFC;
	Fri, 23 Feb 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVEWYgqw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60B14DFEC
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727283; cv=fail; b=ZCgKFd0NG3MKBRhROEdgjx0ZPIYmcCDiEMUeToUzgvk5/dFPHTKNuMR1fP71A51Y/cABsflNbAeIo8SMh5Yf55MEbsmwVlgCYD4A2jeuJqzuldHf6YRnBnPqXuxbW5tc0r/T7iG3VIBDpHn4Pr3yklZuvITppdl5QJaY1qv1kwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727283; c=relaxed/simple;
	bh=Qnqb1eBB29l4t9zPr43pNKPfmnLZ3sU7DLXEuMg+ZFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlkYJ1Jy+S1L+ahpBY82iGRcLW20RpMCjQYnMbfA98pnYo458R7uBEpQq/s/A+P7Fo9uT+OaqesR01g0WCDOluuKIbvo/npYMwGfffPzsmnI2Zf2MAAmffOX50vynXHVSiKSn+cGnPt9m/ibaNRWgqXe+uuy5rnZs51SHAZK9xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVEWYgqw; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHHssc2rQJ6HpciTbtIMCFEsW0E03/4Qe0rRZo6KTSOxtkw1/fkjpxUEeMlpN48CKIE9vh0OoXeRs03z/8aOEZ65zkt01O5CWUlHA62lJAidU4NMJ+URg/9GpxRyFFAl+ePyGU64VCHShGIjVoQB9xlnvn7569SFLTExpILtYhbDFszzcQLeeYtwKrb6zapmh3le4YVE3pJ9SPRBgRhTXdmXNhhxNYZ508wGoUKhofIa3o7plVkH2VtDx2/1nNbUbWGDBFEg/s/34x/wXg0nFF20hpE27K9Vkbj+z4EsdZR2bLF2OH0BQbUvnfbRRTk9NNjoSVOZmReC33BU18Hjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfOayPHFQ+al/6slIZzHwz1d+6H0z3DlaPE6J9y4+t0=;
 b=Sza4jk3WsSadOQalo9ivAv+LrOLcOQu/1w1I//cVxsyrtA3giyA39BhpYC7jlrTZ9tdAvwgF5jw+njkA/KN48rhJpu4moZwSlkzZA4O9lX+ytkNqj786cPuhBRdxaGFK/BG6/FAlijdrmsomSMFNGHALbs8KIuZJcpS8y4quH6nLkzuI41/ylkUjYSfVP8iaiWrlwpoC3Y/quFE6VfTfH+nd8gdKharZ+IS7RfBlpGop1IhqYkAnHKNExN0cvbt+DEAin9LF9BsYx4bhJX/9Iro8JOFT4OsBOjjGsobtlT9MAp1u8OERwwsVbcNBRpGMClDsPImXECmxE3pGO1nwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfOayPHFQ+al/6slIZzHwz1d+6H0z3DlaPE6J9y4+t0=;
 b=RVEWYgqwqPCdF33NQkyig4yA+84yodr72KNsDT0PLVw5PAGR/OT5DWJkHgw63uZiHoU8WI/qyZkbPUeA66guO9ccInywGHPlfKoV2/CTUh/wxjD3p/DCQUqO0yFaFoTrigSCiE+SwPOQMZBj53kB2daJ70WVDm2rQfm9getSI1U=
Received: from SA9PR03CA0025.namprd03.prod.outlook.com (2603:10b6:806:20::30)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:28:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::9f) by SA9PR03CA0025.outlook.office365.com
 (2603:10b6:806:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 22:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 22:27:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 16:27:58 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 2/3] ionic: check cmd_regs before copying in or out
Date: Fri, 23 Feb 2024 14:27:41 -0800
Message-ID: <20240223222742.13923-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240223222742.13923-1-shannon.nelson@amd.com>
References: <20240223222742.13923-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2342e92b-7e73-41fd-bd52-08dc34beb109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fl/s/H65kMcKxtUsdtsHlxajDa5r9W5o4oJ1I9/A54pKH/QuV0BeD2YsYc9uz09xnjkNMLpDoRVQcml7ZNqsVOnx3VRg6aeMzoYdZXoLQXrFaAKAp+4ZGxaz34+fMQBsrZEAzrEpcIdnfBnoQoCyLd/VAlMEax9bWCNkFxEqpE5ThrSwBENuyt8SiwDNNVNU05V8p6t1fYbgf6TOrWU2crGKFhFSfejFnEwbiwg0YhycdEd9Y7QQ1dVdVGctIZ5KhD19pVbpDohPQ1R6sQo7zMw0jTNh4vKk1k0A6VsbgOnrD7PoTCzbf39J3RkC+D/k5YWcwRujFsRDat9/hBR1/BQ2OAwThdNQjhGB1uf4uOY34eUi6fRQ/2Z54+WiRUW4nPYCVdsPaYxY9ApKU8uLzyuKicUVOcIXiaehNnWVCuGtR4UyP50qRXPLLpMVAoU6z+EEIt4ruBF2E6tAAlsUlLk5NraZiF8Uv3l/0lLgzfku0+gWzB4md3tXN6TpB2TW8XyL2fXSMW4mAbemtt5DzPj0EZmPhz9drpbhGaIPSQDQR9DB4c8rWIyERZ+FiZuEIU5zf2GQ2QS/9ZO8Z1RPPWpClJB4EcmeoIkiR8V82vhcwONbE5tjbxPLb2ghZi87M10OVLSF0Xi8BtQLKVRN8y2pnWdfLMvCCeM93VZJ3uw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:27:59.7778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2342e92b-7e73-41fd-bd52-08dc34beb109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

Since we now have potential cases of NULL cmd_regs and info_regs
during a reset recovery, and left NULL if a reset recovery has
failed, we need to check that they exist before we use them.
Most of the cases were covered in the original patch where we
verify before doing the ioreadb() for health or cmd status.
However, we need to protect a few uses of io mem that could
be hit in error recovery or asynchronous threads calls as well
(e.g. ethtool or devlink handlers).

Fixes: 219e183272b4 ("ionic: no fw read when PCI reset failed")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c     | 10 ++++++++++
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |  7 ++++++-
 drivers/net/ethernet/pensando/ionic/ionic_fw.c      |  5 +++++
 drivers/net/ethernet/pensando/ionic/ionic_main.c    |  3 +++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 1e7c71f7f081..746072b4dbd0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -319,22 +319,32 @@ int ionic_heartbeat_check(struct ionic *ionic)
 
 u8 ionic_dev_cmd_status(struct ionic_dev *idev)
 {
+	if (!idev->dev_cmd_regs)
+		return (u8)PCI_ERROR_RESPONSE;
 	return ioread8(&idev->dev_cmd_regs->comp.comp.status);
 }
 
 bool ionic_dev_cmd_done(struct ionic_dev *idev)
 {
+	if (!idev->dev_cmd_regs)
+		return false;
 	return ioread32(&idev->dev_cmd_regs->done) & IONIC_DEV_CMD_DONE;
 }
 
 void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 {
+	if (!idev->dev_cmd_regs)
+		return;
 	memcpy_fromio(comp, &idev->dev_cmd_regs->comp, sizeof(*comp));
 }
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
 	idev->opcode = cmd->cmd.opcode;
+
+	if (!idev->dev_cmd_regs)
+		return;
+
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index cd3c0b01402e..0ffc9c4904ac 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -90,18 +90,23 @@ static void ionic_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 			   void *p)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_dev *idev;
 	unsigned int offset;
 	unsigned int size;
 
 	regs->version = IONIC_DEV_CMD_REG_VERSION;
 
+	idev = &lif->ionic->idev;
+	if (!idev->dev_info_regs)
+		return;
+
 	offset = 0;
 	size = IONIC_DEV_INFO_REG_COUNT * sizeof(u32);
 	memcpy_fromio(p + offset, lif->ionic->idev.dev_info_regs->words, size);
 
 	offset += size;
 	size = IONIC_DEV_CMD_REG_COUNT * sizeof(u32);
-	memcpy_fromio(p + offset, lif->ionic->idev.dev_cmd_regs->words, size);
+	memcpy_fromio(p + offset, idev->dev_cmd_regs->words, size);
 }
 
 static void ionic_get_link_ext_stats(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_fw.c b/drivers/net/ethernet/pensando/ionic/ionic_fw.c
index 5f40324cd243..3c209c1a2337 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_fw.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_fw.c
@@ -109,6 +109,11 @@ int ionic_firmware_update(struct ionic_lif *lif, const struct firmware *fw,
 	dl = priv_to_devlink(ionic);
 	devlink_flash_update_status_notify(dl, "Preparing to flash", NULL, 0, 0);
 
+	if (!idev->dev_cmd_regs) {
+		err = -ENXIO;
+		goto err_out;
+	}
+
 	buf_sz = sizeof(idev->dev_cmd_regs->data);
 
 	netdev_dbg(netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 165ab08ad2dd..2f479de329fe 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -416,6 +416,9 @@ static void ionic_dev_cmd_clean(struct ionic *ionic)
 {
 	struct ionic_dev *idev = &ionic->idev;
 
+	if (!idev->dev_cmd_regs)
+		return;
+
 	iowrite32(0, &idev->dev_cmd_regs->doorbell);
 	memset_io(&idev->dev_cmd_regs->cmd, 0, sizeof(idev->dev_cmd_regs->cmd));
 }
-- 
2.17.1


