Return-Path: <netdev+bounces-263803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dk6E9ckqGl3ogAAu9opvQ
	(envelope-from <netdev+bounces-263803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:25:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56F1FFAB7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62213077238
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBEC3A5E82;
	Wed,  4 Mar 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WfQGzGL3"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995D370D52;
	Wed,  4 Mar 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627024; cv=fail; b=J4nrfrPW3NKYI/7IsncTT3X6+z220OoJOAo0a34NGR7tBNvH1wdWq8EW39Ehr0EFMPAp+qHXaHaUi8wUmQPkOtd3nuIRrWCIDA7VjfdHElTZvWI23gDzgEAWek0aMGNlmDu38WSUM4w1bG0KU9tFq0Y6LCrK9C1JvSXLJ8PsITo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627024; c=relaxed/simple;
	bh=lT+X3UVW2RqpTH77hECsplmkCQYa13nyTRO0QmTzKJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8IcBhr1pXdFADvHlZgHOKTbGJ0tTq5fd4Z9PCLSUFrTsCf70Nh+rTDUeBzrQphvVH/WUvRQ91dV+afM89E3PUlN8HJ2fSbTx2Y8c2nNZZ75yOxpBv+esOMsUDiFGjoZI2tDlX15VFQhob7JG6tQWXxVnyEyjiqJ9AcUyttQPg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WfQGzGL3; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOn4edkyO/7TBTYrT+01CuzFAPKJH/rpRXXVPoM9zgu7/ASIUFSJxLWIGaY/fXVKeH7u5gmMouYFdb1b05N5mveBQIpvu6zF/CU9h/TdEi9gmGiEDGKpPQNfoegvZprOiTJY9vNmiHyQ1yw1eVO2YYcXqNSshfRkZiLEnEaD8FUDjb5HYtzWfmMqfnxIOnfEQrv0A5dN686Jfv+iHvdf3nuZRc62o8857wNkuj31nJufYSms1lD4jbV2k5A940hUQS/67rEPuHJQRFOdpE7H3mMN9PfYxopOMdF+15Akn7boEHB5yEqqSc2RQmjPkQLrhbzveTlBmifinj2V9pixnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WhJ/DlysRMRlAqQ8KTfrnZOh4bC/H/L9iys24i4DgQ=;
 b=HVyK8U5o9x1Kca8yoFjKyh0Z2QZatfG2UG7trfdMIkpa1A9I7BXQcXX1QUFLpCmx4Csl9FQQO+dn8lk8hdY2upUSz7qzMGcmmGFaE95pNiv2ePAKQuCuWgZY1W+HGZRu0w0LATRV60Yu5xTOznpHWXUnI7rAHbiktV1m8PrS2WEri9B6Z4kvMpdyyJ3g/D34s7olby8siLIEAQ2DLsADnXYgx40WNAt9g5c718ZYlM4Q1I+QMVE5bX8qm1ezpzXyEQByTM2x3J2Tizt+LIR44ta9hF4T+PZRINs+D8wY1n4FUedWcdsvbP8w0FXZbGpD64YGtSIeocd7C11gwir5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WhJ/DlysRMRlAqQ8KTfrnZOh4bC/H/L9iys24i4DgQ=;
 b=WfQGzGL3ZyKvlyH837h3VUF6bsQk6viHXDRTNWUEABGT88YiKboCIGnEuXR3aSyVJNRPd3rP2elD38937HjNc6tKlR6bvU/Hi9EAhE8+2sOaEjNnH82vSqaxT41s7qqRa1d8/QWwnBOzQZtiq1QoSwJ005Q5OWwUu3zisag3fFo=
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 12:23:39 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::a2) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 12:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 12:23:38 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 06:23:34 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net 1/3] amd-xgbe: fix link status handling in xgbe_rx_adaptation
Date: Wed, 4 Mar 2026 17:53:03 +0530
Message-ID: <20260304122305.812541-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122305.812541-1-Raju.Rangoju@amd.com>
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d79ea6f-8e50-4910-7e70-08de79e8dd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	1Pu/CIftUD4e92Nz4/RGoNOGW4xJap5EUrlACSJgBuhF8qHN+QQuo+RQwN33lxv4VSf7w9kVHnCNPYwFf5Zh1SZKcAzEp+JxjoXoXu36eZ7s5tQ57a+uvEB1S7fIjand3/qE7TikQzYtgnsaUxwGMqk2E10+LACsEtNVoLFd9Fc/KK7b368vkPCopzgYf/eLav446RtguOAAQ4wEHf9OWocX+GXCRe1IWkrzewibZSx1aJ0ZP+bY7RkqYNcbPuxKp9u6DWvqmmSBSBv6ZG7jGVpp53uTg+J/PdwsOdVEZV/dsbbvf7LZnZV546HKxdwqc2PFZd2MYKoaOhPkn4ADY6lbK8zAOHdXuhpyIceTjcF2YyfPqEpw5QhX+RXN9SteUxQU/TyfTyEe+9N7mddxhUov5aAvQ1dy6jMD6gFXK366XjV5qaywb2t2Hpry/rjpAb9/swwTTG9zPz5yu+jPWTXkWAVZAlXNirKTBXrhXWrGFii+qSDAvJym+NQfNKW3qkhL+MViA/9Zq7f0ol2HfRwfvuO3wySOAUW8FpmD75FaGuf++vG23NhLC7FvF6lgF45cujbn/r+oCF2HWeM+mAmTl4S3NJ6egX5xHZXRYsw714yzfKL0mVgNDAe8GQJK5y774MQa/Lr6YK1D2S9BSSjN69+HAgJIY4v6Nx6JeYp7MLAgHkZX/Nwkqn37zZeaPpTFvUDYHn+UWTIqz7ufqQ+tzmtQmnywNPg19D0jId1MFEGt3J6g9BAlXvtPQ9kh890ALakquDR4DpiGVDdVTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eMq3ugPnaWZA0maPtoFrCg8cfcVkzCdGcM8Irf0XOsAqHoMN1ojIXYIVwyuVzyouyd17txTHeAuArHlyiN8zBdEB6xemtcKia2kLe7Q2benom3c9XXLGfh5ZFCM2i2H/omxhsP0krecyC2a2CgxdeMiU2OfqF41uXROOUAhvWhWuRF3uW07N2YvDDNCXkc2NQKqIEjZ1VKc3CmcQe1TKLtPFudWtlhxDpvp8I7HG39UjHVLmX7dt7m0BuE3g9BIW0aHKhZLnWpqYc5ldha4SP+v2BAaUjovO52XpmF8TgOvXk4Accen/Fdiah/yWe068ShDGc+SMYIk/tT0MWBYq35ADIcZgXGE07Ab0maQOU/E19MvFvSqLCdJhEvfzsaHIbwE+v5eIA9OkHKxaMYvytnrvFIEJ7s0CtL6dnk1IPBzi1hw77JsnnaeKbQKt0Tje
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:23:38.2572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d79ea6f-8e50-4910-7e70-08de79e8dd2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
X-Rspamd-Queue-Id: AA56F1FFAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263803-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The link status bit is latched low to allow detection of momentary
link drops. If the status indicates that the link is already down,
read it again to obtain the current state.

Fixes: 16ceda2ef683 ("amd-xgbe: do not double read link status")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 1dbfa9d4360d..457d6049291f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1964,11 +1964,20 @@ static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
 
 	/* Step 4: Check for Block lock */
 
-	/* Link status is latched low, so read once to clear
-	 * and then read again to get current state
-	 */
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (reg < 0)
+		goto set_mode;
+
+	/* Link status is latched low so that momentary link drops
+	 * can be detected. If link was already down read again
+	 * to get the latest state.
+	 */
+	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		if (reg < 0)
+			goto set_mode;
+	}
+
 	if (reg & MDIO_STAT1_LSTATUS) {
 		/* If the block lock is found, update the helpers
 		 * and declare the link up
-- 
2.34.1


