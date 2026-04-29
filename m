Return-Path: <netdev+bounces-282490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHGsBCVy8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352D49A54D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AD1307C875
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980513A7852;
	Wed, 29 Apr 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CyPZt5IX"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59826ED5D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496468; cv=fail; b=HfwOrQL0QDSIz7cg1aR+ALv6ieo/qk6QdJBn77NX8/RAvdFhSljvxXhKo1wGBIL/8XiSCa2WvWJhbdcZSH4llbNZGOZFvvXIT+96oPImfxIHYcLL9+3Y+mMasI5YmIHBZHo9wRqhWB9+q1D3mEFjOIy9YM9mTIbHdyarHt70hM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496468; c=relaxed/simple;
	bh=8GmD4ZDkFRx23siyHgq23cSgpdTrmdU5DJYpVz3e9Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spm/PrtE8GPcTRs2uiYZrvZC+ZXzeQAcFyGcB/KP9f/c0G6Em4/ZJYAc8I+vO8zKPw5E1s4slS+7iB9zbJxaSQSWXWTM+y7oYv5VRWgSH2Ld+j2ZEBZUl7w6PdyHetF7m/2zcDRu+k4zolrWs8sXuBO8olKEQ1YAMbkZhb/W9sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CyPZt5IX; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNAHb2HrGk1zsXP2NJcFvmuoZUBSUJeOvGG4a3wBRYKxYkD65Xs3WdHcNMjgXSVo2+49w/6KgS4+RQt65Gytkv0WbWHlCw7J2HQUe9F3vOYHW9T0FDmDY4fYBgfcQIEUqa9C1z/8oU9Tu6ND/7N8k04a/4C16RfLTQzCONQefbEVrYHQNP0ehIl4w74FNvj3f4ZkPUybLmZPInCppU8qwXhCzPc20ckqV8E0XZdUQC6BgVtVBCCSD6eu+m9o0E+M6B7Un2Oegn5vSwJz1d44euNjtglbsgJHpTKynoeyfBX3dKx3rRKekgmb2AcqfpJsdmuH8JKPB48yZtPZx1WNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vwsn4ORUImNAiBVWtGkbFn7cPerau3Hkkr+4hRGVF8=;
 b=VxsiEvjAy7VHH3Me60tUXx6YsTQwguwJLkGi4HTkv14+uaYCuyfsOsl7QAlZY6hwrDAebLi0x3GlljMuR6do9pZuyTCvoYU7HwnL+/SRCG96lL1BHHlPE1Vjpji8rjzZKeQH8CR3A2QeFPXAlE/fQtRJIGVm5VOowJaHxT1M2gy+W/f0wGmcONqshTedlJ5NG+NxoYysXu8FPjvDmQXOlS+sS1f6Jo6zewBTPBeaQsjqk0KEpELgBXCTlG3JejvKojbfuYos1m3pnJX9bebVH3T/7rfqiJrS5MH4bQOkopOV4kr49XTFtkrOtHjnBVh0Ap1+RwuNtkN/wEpKW6KHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vwsn4ORUImNAiBVWtGkbFn7cPerau3Hkkr+4hRGVF8=;
 b=CyPZt5IXvjaV0scdi8b7h/al6pBLRUX5YbN2RsDz+N4LNCN6fHbFbedLhDlt6pekm5j5ERYD+/rby0ZgHP6eccyzYIZAyICJ8PQZnrsAL7ULXAxF+zAJESwJZ9LxLv/i2HMosv677QI6fieq9N2TlvvGR8xeSJHRpJ/WiNlY+vI=
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 21:00:59 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5a) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 21:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:00:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:00:51 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 1/7] ionic: Allow the first devcmd to trigger deferred probe
Date: Wed, 29 Apr 2026 14:00:01 -0700
Message-ID: <20260429210007.40015-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260429210007.40015-1-eric.joyner@amd.com>
References: <20260429210007.40015-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: aba75ed6-1ca2-44cf-0b6e-08dea63269fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QXwYIenI4S+587tyNhd7Ogh1xtogeLDkiaHK3p/UIPOP6iVzmlAdHGhb1q1eSF/bCw9X0P3gsVSbKbiUI7yMs1NlqCzC0tE2618HT1xmerfK6jd0Ad2d17AKF8q/NujwilyOm2dAX4XOj5Sfyg8rsWSJ/v+TJZ53ePSZtM9mUj1GIcXjsMvP9FukN/YjOmxbLks7SUXQA1luKh2p6rolbCBd4Noo4yteNm0zKWvyE7NnyjVFXJ6gjAm57kycjeQwJ73YQX4qYXUrgzJw6Vsir8JqxSy+4FXDYnzb7I4m8UNYN/YdHGq6gNxxOTwRESMjPSNRWwP+jbqp44tc9qdTI6HtUgFKGFhDvAo2hnPbjMOT8va6o+UBGGD+9F3orzViqhiO2qRvRQTlbzHmNV7t9eS6Nkh5KtOmZWH8Na8wlrncvrfdXmj9mFy1jiqRo876HgAuVvqlbxVxIltfKONYG/yns0jYtcQrQ86NdpbkGthPRlzQ7kO3tyn9fmd7TMU+EhbLpZW1gq3ONjTTCn9ucatp3yDtQxixX82b77vCcBI27ze00hjZUmMDTigk6h9D6FPcFb7MJYVWcRZYf1fAw3T01vRTpxAbsCxYfDeT2Es1WjBCjdUJ9TU3Cbex9MrDZeonNIc5SzZRyeAIcef6iSEiZELktWlOYgflkl3Uuly8YfBixzQNQx6FXfCcr9LPrsJIjB7HZ+F2R+I0bAYkNzesp85ZYkrvFjJMd/TRbfLWBsRD9zaWFltwO9GNU7f01dDcHmUGeOLuiaf6wSLryg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wrdy2kWu7Mp65blwYWt9UzLdgtv9LUmyyMPBRg/dgxA/H6dLoeTXdOqWlUuOtrP/qR/5VSw6VZP42K/ufqdXRvsxR3xFuKskZGyNG5UF/Rs8F0KANQ1TcEuIMTdFyZ0/9hR59UHMkOjftISd/n3/C46vgEKH/JNJEpaN7dMexny9VMOsGfpdaLfz8YufsblP91sqLc9aZ7W/kfRhK1vyZ6z4JTRiKNNVal8kf4cAThLjGzvVgCFMf+tmA8Y8P652C1dgsB3J3UpvgucwmoZjZIND2W8MWT2sl7+JcvQ1SCsu3iX31gWrlw66Cyqcu/VjlHyw6rbffS3FticCwuRykWpNzQlD9DDabBYyW1mTkn6kCbq+ccoU1BDWwog3J/21DT4X2R+wh4EYcfu1ViydQjgK6oHZ/GgN7LnJkKTnTwxlXvescnnJsILYGkOxZN5w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:00:58.8510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aba75ed6-1ca2-44cf-0b6e-08dea63269fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
X-Rspamd-Queue-Id: 2352D49A54D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,amd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282490-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

The BAR signature can become visible before firmware is ready to process
device commands. In that window the first devcmd may fail even though
the device is present.

Treat a failure of the first devcmd as deferred probe and return
-EPROBE_DEFER, so probe is retried after firmware initialization
completes.

Also reduce log severity for reset-devcmd failures in this path: these
early failures are expected during firmware bring-up and should not emit
the standard devcmd failure messages.

A possible follow-up is to rework ionic_reset() to retry on -EAGAIN and
-EAGAIN/ETIMEDOUT style transient failures, but this change keeps the
current reset flow unchanged.

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


