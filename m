Return-Path: <netdev+bounces-284683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N1GNiy8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295B4D604F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 05:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDFAB3020C19
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB02E11B9;
	Wed,  6 May 2026 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UUJos1O9"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4169463
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039850; cv=fail; b=UDQ2u3T1lLNanfPCa9fZwhz0y0lWyGT5bV6rUKoFQ9dnfWlqDRPwV0n9mij6t7VSvc6Y3D0ouaRSt1U8hqqkHDqQsoCDl+lmtyx7moUgFikCCRSTF3wBR7Qk+ciMJ53juoPebq8nNgxQo74Vkd+422XX5bc2s4AxK5runkgK2HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039850; c=relaxed/simple;
	bh=E1kdDu/WKey0dOcWvoLCjroD9jt5dxMJ4fB2V2MnkFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoauUYAeVqXSuOqO/rYOaAy2j4v5uMK4DUUgymOsNvILHwRoKmKf43dSDpNwNVVbf5n9gOBWzZ/Wwt7dTH5M9/6CUnPZzHTq5xuG3ftAFK8HDPQ9VjVyQPds+09Sfw941SU5DsLTN6ycB4OOsg3JLdM8yQSz+kiey1TkMlJZllU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UUJos1O9; arc=fail smtp.client-ip=40.107.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uforqNfBZRfyHd2sOtxz88HVNM3HEhg8WS0zA03s3U8BQea9K6vRaOx55+LcGqq9mCBUtq0AhkbN5cjEpEPfXXIA73lngP/+tOaO8BXwItDwNE4/tcsnNviHRnloRJMoYR8pZSyRISQZjhWQ2VHcnHPXot6X9upQV4FyYs58MoC4+cC7jrvLdwA5yxSFIriu+2ukSa8EdnQGWRP3gqKqPsDVtzfVyJOVa76v8eEFVAFlJEq2q3J8PryFO33J22MjbucD57Lczw6JDmzu0mkRXoPkibv1IQIZ+DoEmUYS2sbjM2YdvOQQDenAchEZeS0xxkSqs7C8LKyVRhi7nbZ+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VlA1huF8ZVAYJlKF3/o78udtV/Ytqxvm1raKd2qJbE=;
 b=MyXR+1JYWrxT1MeGIjNuQ3BVKmy4+XPGPFt1CBtQVPDcVtAViHTJ+PzoAHFOAocq6HH436AVWlZl+bOSVmnIFswqxSd9TvFTh/MM2DrAPaOfsT+LwUDH5M543wlZKYpHxDFcM/KgzheE9PtEWmo2hmgb3HIlYZAtWU+Fbpu5y8BCG+nHQKNRpe88gvOpen1UK8as99NCYRC5457H+hxLUSJtrQo1RxLS/Z+VJ5F5YzUdoBIulGWPr66XHM0S0bJ0WHPRCmfO8cAQvHfb1e3fJDjie0ECCsYQuoL5UrdVhfjuiy8IOChOWFYpmjCT8uDmjd4uRejTkGk4f8p+Ef3obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VlA1huF8ZVAYJlKF3/o78udtV/Ytqxvm1raKd2qJbE=;
 b=UUJos1O9CCr2afiGJXXkE4m+y46xrdYzap6gccu+4nnN7CzrQB3RCDvHMn0Cs4b5q2MVeLHXAA63L/3cAa9ykrRxcJDpJH9qvrhGQWhp/sROnlzt9MINXAnu5nuNNGIs3DmIzuHn7FLOp+lhwoBJWsWoMV3xDKhj6Nb6zYawpBs=
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Wed, 6 May 2026 03:57:24 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::66) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 03:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 03:57:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 22:57:22 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 1/5] ionic: Allow the first devcmd to trigger deferred probe
Date: Tue, 5 May 2026 20:57:02 -0700
Message-ID: <20260506035706.12373-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506035706.12373-1-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: c5131390-9de8-4a3d-642e-08deab2394b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|30052699003|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8oK69Y+VL/qEqYRRK9WkjBHEvKn3Ybsx+gJFCKqRbGfYiBAaPFEoAKo5Up9KETB0blvVe/mM9VlzT9GZDtG+XvR4fTO5Ed7q+EstFignXWT99uAkQ9gL/fCIxqwSkXefN+e1B2YEjsngNUj3MhokibUeerDXlzZrQ64sWDPc9auTK0vbLNm8hBle1K2LnmS/X3FTsd9tNkS5OTU7SnDn7uhhrp6zgDafp/ABosSndQklQhs56Ln9g8jGiTkHDzk2qqibX/4TULHOuZmZKHDhCvk5L17uIE7P+24YTkUX+65ioAtUEEDEY0nrZJr9DCjpL86zPtLDMcscT2pkTfqhhEJaD6T667lKPHJY3VY4+vNNwZ1wQ2nqSAYZmzxCNXu+zw2c6fZjmPGW8xuYUaaiKH9iKjxiVXLSG5DMWkkHZD47+xb4NCzh8Eu261ufdcZgi7umybxeOEkVMXPoTU0zu9QPyycLiDHubW6kbVsVvyGiE/NsE+2wahUHMI5R5qaDcSotRmEbnfufULD6716Hpi0UY/NPea5cRH7I1l3cRUqlgqpbS+txTBSQ/cY9crts7+mSrL1ByBJQp7cp8l6JUGTMwfY7uUuRq98Bkw5AX78f4EbndkZoL8fTbHTTYJqotWG/u/xSDGz/JmNxg+OVr8WV2GwK13naRx7xSPwdF8SKriAqx1qeI0wMHzDRkgMJNcfGi7T9TbqsYmkHvb6/RfZpJKoB2NtTSS3LGFWWP+k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(30052699003)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0d2/BxahlabulqPFZE3rI+xC/d8dZOjuMlb8RCUCQ3uwVR9RbxFOr5SC3AYjSXWB68gyu8jZjDOJWeGZMhKyNVtAKhNitjtOXHCU9blUoCZY8mRLWYB0gZiSELu9oxA9TmR7/CxMvXvEgYQ74lec7tiXd+3mFL3wgKXYssmGgwcsXEa3P2AwYpn7PTbngDgLxtkHY2ajMSbes6aOhEmmZ/xftlnycsWQcgJenRnzzhh7e+hvDfEJ7rFXteJRTxW4JLirLErPsSYigIZ23OhuDn5W8AZ/SiFGAjj4PpvpKp/wV7K+OIUBMhKGucWf9yZzFd/reb4cLtbVVTnYXVYH2WXI3swEtAUeiS1dmyMwNFQnXfwngXlgEaBVXYKCJqDcUbCcJTjJQvKVgS7T9hWB3Dw2OR9Whh8JPOmt1NVFDyj55rLFmoDVLYNrJz2BZBzg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:57:23.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5131390-9de8-4a3d-642e-08deab2394b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-Rspamd-Queue-Id: 8295B4D604F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284683-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

There's a chance the register signature value is set before the
firmware is ready to respond to the driver. This doesn't mean the
device isn't there, but just means it's not yet ready. If the first
devcmd fails, then return -EPROBE_DEFER so the device can be probed
at a later time. As part of this make sure the reset devcmd, which
is the first devcmd, is not so alarming when it fails by printing
an information message instead of the standard devcmd failure
messages.

Note, that the ionic_reset() function could be reworked a bit to
keep retrying if err is -EAGAIN or -ETIMEDOUT, but for now I chose
not to change this as 5 seconds should be enough for the firmware
to come up after the devcmd registers are initialized.

Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 8 ++++++--
 drivers/net/ethernet/pensando/ionic/ionic_main.c    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..59ce35404e53 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -260,7 +260,8 @@ static int ionic_setup_one(struct ionic *ionic)
 	/* Configure the device */
 	err = ionic_setup(ionic);
 	if (err) {
-		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Cannot setup device: %d, aborting\n", err);
 		goto err_out_clear_pci;
 	}
 	pci_set_master(pdev);
@@ -335,8 +336,11 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif
 
 	err = ionic_setup_one(ionic);
-	if (err)
+	if (err) {
+		if (err == -EPROBE_DEFER)
+			dev_info(dev, "Device isn't ready, deferring probe\n");
 		goto err_out;
+	}
 
 	/* Allocate and init the LIF */
 	err = ionic_lif_size(ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 3c5200e2fdb7..91f89b9ff807 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -603,7 +603,11 @@ int ionic_setup(struct ionic *ionic)
 	err = ionic_dev_setup(ionic);
 	if (err)
 		return err;
-	ionic_reset(ionic);
+
+	err = ionic_reset(ionic);
+	/* firmware may not be ready to respond yet */
+	if (err == -EAGAIN || err == -ETIMEDOUT)
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -687,7 +691,7 @@ int ionic_reset(struct ionic *ionic)
 
 	mutex_lock(&ionic->dev_cmd_lock);
 	ionic_dev_cmd_reset(idev);
-	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+	err = ionic_dev_cmd_wait_nomsg(ionic, DEVCMD_TIMEOUT);
 	mutex_unlock(&ionic->dev_cmd_lock);
 
 	return err;
-- 
2.17.1


