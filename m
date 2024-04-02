Return-Path: <netdev+bounces-84050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2D8955E8
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09DE1F22B81
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126185C4E;
	Tue,  2 Apr 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPVz/G+W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C382893
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066264; cv=fail; b=Kmxt981CP0JtkBnoQ13ioNRZ/rsXie4i6nDVRDRUjRxnVjwl4vTFVpOGZ1d5WtaAV33MdHhbrvkaYdutznLq5UhHWdp4i7N22NOOLcnYlp1xHU27O/IS6lfFWflEi6yygWF6pTWoeeaUZuAhl5e2eHE3EDwwSn3gmingBAXmj1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066264; c=relaxed/simple;
	bh=qlos1lF6tQPmSIbJvmp87Jk36IVRfXN4xpvi92i3tPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQeQfllc362U9T2w2w20wCZcPBLmuxikbijTEdjN+EFAXLN0a/zx2DDrmEIm5oZi3DUG2bLcSWdshLBE53ikeorq9ZcK5axnHSuGiZ1/ltT76kj7ckHj72Arq+S913iRQo790ETwqptQmDJmxqdN8vbkrg/utdKFDaiy1H3RQ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPVz/G+W; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku0hpEhs953j6fxDOyh9i6UsyUcApZf7EjQBxongf7KnkredCBVhtkdtfMRIvJz0xllPb/uwjXZ0QB+Ti7R4BCs7uj5/UZu2ex3VKRc7Ufov9S+95+R58hxKZBisyIXKvgAMlYxA3mrS3PSyx9JG/QIu8reMoxwlKZrbhpIro8F3CtrCA20Pp2qJu3MRDh0bk49yp6PBoFQIn+iOcKjCb/78Z4e7FGYqq9mSlAO1T6bB8V0hop/SRlL53x4cr98/d2dccIRQs7Tjp26qKwPGGBYC4yny9UvSOTjqBoX2povdSNQ2Oiu2lnBYdu2X6dd/5HlqY2k9emHn76JXvwnFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veHuaV3/pY/MqA1u1UTI5CjsClXztM4HCKlOiwt0UQw=;
 b=ACEPleWjQOi1wCPXd+PbG65LsvSWzhjhqpvIMg+/B//neqcdeqybVBCrZgiqs4fgKJWxD7r4gCdv/p/6ChQRJUufAMOuYJVn2T4AtkVbJrzLcsHrfpwbkgtTg1gMnU8liciRoa68H59iZnsC4YJzRn0jnjoXRSAGdsILbJEdAE0zBXy4wXyYzPnGy9pBxYlslDZlB3zNQDRKAu0PU0+ThvtusCTxVDJ3r1BkbNtZ+7E78+00EoB4O1CZGTzJ3bMT8sxedvQRgP5TFfsu7n5FcsBVxc1dm5lTZZBiyEUkYyzF8nUBtePaxufM8A8daF96eUUwTH/YrAPHW0FgStTLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veHuaV3/pY/MqA1u1UTI5CjsClXztM4HCKlOiwt0UQw=;
 b=aPVz/G+WQpiRwiyiARgjE9NInQujMofhqZPxU7hskKCtBNWfCF4W2ggbeqdF7+rjZWLjfmpU4VScpxQFMFArk+mkkao/KYfC+nnhP8RpYVw8KUezumTYg/uBdr7f1Ngo7ax264NO+3KtrrEcmxdna4Pu6MJbxKHu35GRGZh8Q8QCLqlN7KLkiGButaApxXCjWOXTOuzuBiIILx5UpfUkgqsgq6nCmiS53jVTZkvg82cY58BZLvOgWdOv0Xx1ybu3Us9LwpYU96LAtaQZpoU4EQ1AqNzpUiwmEr8JQZUFIJuAez8nUSbR0LhPWxSKM/DOUQgbhmdlqhK3eDaY+GN/Xw==
Received: from CH0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:610:b3::21)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:39 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::ba) by CH0PR03CA0046.outlook.office365.com
 (2603:10b6:610:b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:21 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/15] mlxsw: pci: Poll command interface for each cmd_exec()
Date: Tue, 2 Apr 2024 15:54:20 +0200
Message-ID: <e674c70380ceda953e0e45a77334c5d22e69938f.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 816de610-0e49-46db-4855-08dc531cdb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RzfUaHW3q2e8FkFxKQWxjSoJU8PXkJ5I+8RneMbs0ULHVSJLnExvAi2OixKJ8b9reP3j+LVZkNDJ9MXQVO8ue2lX1is5ZoQU1wbHEEi8jWRG/C+JI7tqenCzewwxrhixC7BHPKfZvfoMeLr37RrzlME1MHUKmB+HBULJVjooH477d+Omit0ATrLnxAN2yzGqKCPEzyh7jwhp/MJDNs1gWTYckl60YLJC+RfTVNS23QGfUiJM+Xk8qMLDSH/zPBO/s3zfw3fUlH3nLj/r15LriGZ3N/9rJHbN3a7rIIpSQa6AV+i9ILP78NPhnU240SLcQgpfp49OvAgWTT7cWsKs7At8NSnJUI9/CJTjHVqoziTTQCcDTluCuzzBQezgR7pTFClfY7nLH2sJm2iw5kB8qd7Y/CUU6XjnXJ2T0xSvqTRovegDU5NXaNVEt+nSZC+lgJy/dLfoRWVV7Xjqe5IMND3TlBtdwKbEoHqWDnNvsD1n5uwjSxfWEWDRdNwMMMiEcoMnSfO8N72sLwB9TWH1mWbkrd32qYxP9BHsaSy2quvih88DjC4wWLvHr9s0qkeMVvDLSUJVOymWG7ZIHdIgMIk1o54/ADx/fAUUi0fmriS0dqzk0J4OBTiERD9rSeeVjoUvV+It1vNrQ0TfXmCEWSnIB41LH6+uYKS8rMy0aLTbP75Si3ly+vSNdt8jfuJEgjyTxgrxOI3fIupDvGdpKuzE4A6lswcLw1B6ITMJu1DEjpUixarB2XCcraA0o2fC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:38.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816de610-0e49-46db-4855-08dc531cdb8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040

From: Amit Cohen <amcohen@nvidia.com>

Command interface is used for configuring and querying FW when EMADs are
not available. During the time that the driver sets up the asynchronous
queues, it polls the command interface for getting completions. Then,
there is a short period when asynchronous queues work, but EMADs are not
available (marked in the code as nopoll = true). During this time, we
send commands via command interface, but we do not poll it, as we can get
an interrupt for the completion. Completions of command interface are
received from HW in EQ0 (event queue 0).

The usage of EQ0 instead of polling is done only 4 times during
initialization and one time during tear down, but it makes an overhead
during lifetime of the driver. For each interrupt, we have to check if
we get events in EQ0 or EQ1 and handle them. This is really ineffective,
especially because of the fact that EQ0 is used only as part of driver
init/fini.

Instead, we can poll command interface for each call of cmd_exec(). It
means that when we send a command via command interface (as EMADs are
not available), we will poll it, regardless of availability of the
asynchronous queues. This will allow us to configure later only EQ1 and
simplify the flow.

Remove 'nopoll' indication and change mlxsw_pci_cmd_exec() to poll till
answer/timeout regardless of queues' state. For now, completions are
handled also by EQ0, but it will be removed in next patch. Additional
cleanups will be added in next patches.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 48 ++++++++---------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c9bd9a98cf1e..b7a83b9ab495 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -111,7 +111,6 @@ struct mlxsw_pci {
 		struct mlxsw_pci_mem_item out_mbox;
 		struct mlxsw_pci_mem_item in_mbox;
 		struct mutex lock; /* Lock access to command registers */
-		bool nopoll;
 		wait_queue_head_t wait;
 		bool wait_done;
 		struct {
@@ -1105,8 +1104,6 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 		goto err_rdqs_init;
 	}
 
-	/* We have to poll in command interface until queues are initialized */
-	mlxsw_pci->cmd.nopoll = true;
 	return 0;
 
 err_rdqs_init:
@@ -1120,7 +1117,6 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 
 static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
 {
-	mlxsw_pci->cmd.nopoll = false;
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
@@ -1846,9 +1842,9 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 {
 	struct mlxsw_pci *mlxsw_pci = bus_priv;
 	dma_addr_t in_mapaddr = 0, out_mapaddr = 0;
-	bool evreq = mlxsw_pci->cmd.nopoll;
 	unsigned long timeout = msecs_to_jiffies(MLXSW_PCI_CIR_TIMEOUT_MSECS);
 	bool *p_wait_done = &mlxsw_pci->cmd.wait_done;
+	unsigned long end;
 	int err;
 
 	*p_status = MLXSW_CMD_STATUS_OK;
@@ -1877,28 +1873,20 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 	wmb(); /* all needs to be written before we write control register */
 	mlxsw_pci_write32(mlxsw_pci, CIR_CTRL,
 			  MLXSW_PCI_CIR_CTRL_GO_BIT |
-			  (evreq ? MLXSW_PCI_CIR_CTRL_EVREQ_BIT : 0) |
 			  (opcode_mod << MLXSW_PCI_CIR_CTRL_OPCODE_MOD_SHIFT) |
 			  opcode);
 
-	if (!evreq) {
-		unsigned long end;
+	end = jiffies + timeout;
+	do {
+		u32 ctrl = mlxsw_pci_read32(mlxsw_pci, CIR_CTRL);
 
-		end = jiffies + timeout;
-		do {
-			u32 ctrl = mlxsw_pci_read32(mlxsw_pci, CIR_CTRL);
-
-			if (!(ctrl & MLXSW_PCI_CIR_CTRL_GO_BIT)) {
-				*p_wait_done = true;
-				*p_status = ctrl >> MLXSW_PCI_CIR_CTRL_STATUS_SHIFT;
-				break;
-			}
-			cond_resched();
-		} while (time_before(jiffies, end));
-	} else {
-		wait_event_timeout(mlxsw_pci->cmd.wait, *p_wait_done, timeout);
-		*p_status = mlxsw_pci->cmd.comp.status;
-	}
+		if (!(ctrl & MLXSW_PCI_CIR_CTRL_GO_BIT)) {
+			*p_wait_done = true;
+			*p_status = ctrl >> MLXSW_PCI_CIR_CTRL_STATUS_SHIFT;
+			break;
+		}
+		cond_resched();
+	} while (time_before(jiffies, end));
 
 	err = 0;
 	if (*p_wait_done) {
@@ -1915,14 +1903,12 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 		 */
 		__be32 tmp;
 
-		if (!evreq) {
-			tmp = cpu_to_be32(mlxsw_pci_read32(mlxsw_pci,
-							   CIR_OUT_PARAM_HI));
-			memcpy(out_mbox, &tmp, sizeof(tmp));
-			tmp = cpu_to_be32(mlxsw_pci_read32(mlxsw_pci,
-							   CIR_OUT_PARAM_LO));
-			memcpy(out_mbox + sizeof(tmp), &tmp, sizeof(tmp));
-		}
+		tmp = cpu_to_be32(mlxsw_pci_read32(mlxsw_pci,
+						   CIR_OUT_PARAM_HI));
+		memcpy(out_mbox, &tmp, sizeof(tmp));
+		tmp = cpu_to_be32(mlxsw_pci_read32(mlxsw_pci,
+						   CIR_OUT_PARAM_LO));
+		memcpy(out_mbox + sizeof(tmp), &tmp, sizeof(tmp));
 	} else if (!err && out_mbox) {
 		memcpy(out_mbox, mlxsw_pci->cmd.out_mbox.buf, out_mbox_size);
 	}
-- 
2.43.0


