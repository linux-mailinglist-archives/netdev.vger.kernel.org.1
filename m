Return-Path: <netdev+bounces-282280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KCvM2q68Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C6490DDA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 777EA3052439
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE463A6B9A;
	Wed, 29 Apr 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nAYusj3O"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BC3A3E84;
	Wed, 29 Apr 2026 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449519; cv=fail; b=esbQcZzz5l5BgkBzp+GJxewFLwHgX1/nATfy68ja0YzAAXFn+xibHCWYeyfagyCq3J0iehV5ZK5+HSPnPE2g1aGs1T9MyezbxL24rL5WtJNg56bgC2sFezPMUk39+eUEpujcxqEOxiJN+B0xFgjWHcHtGwReMI5vvBgK9e/1ZNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449519; c=relaxed/simple;
	bh=CRObv5d8n+F61m0z9A8nt27CJeMYWzqGQ85hopzlRLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JBvl7FOq7nm8+qcVvoF/e5RzS/eJOs67tOUR/tKZ/gF7rI11f35dx+mQGScS26aNvEZKEWP9Nwdogk5eDXMgbSHg4FX74T29KnfKMug8ZWct0CA5HrsMiNHH2l0JYfNxR9GriVb5onae+tcBV37XJgRtyeM1s2TDyb4Om3/hfZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nAYusj3O; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSUbZQIGsZYxcgH4GKssjUjYqcsh79i0colqzwzPZbSYYE+l3tM0y/7RtRGARUuh8cguuKy6sMVfgme47SZ2BKj1pNV7ZBDojnzCrjOqMoWqjRoiTYI7Yt5M60zwFzgspwIRMFx9jKSSNJHzzZNNlG32Dtm46aUITwT36HRhNUgAvKrL2qPBuNqmu3hbdeQ4DYGNj5n5HGrfj0TB0zrX1LDrHAyZ3FAJjX0dUd2NUkd4xPrGLOu3AER5EjHlTz6HeXsxbJwGGe8S8POK51ASJEQjWQ7c58PQMLAj9HiIpPACdyeZz6Y5jMpamD3U+fvMrLErUPDEEvI2XklIuQ7n+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4540JnOz6liRsvJF/pQk9rEiU/Ak87Tll5XmyYPMy2E=;
 b=TK3wJRg4Y85Bld9UATWqyuZ/ZBFAPTPYg2ygw8dl/u4om3XkpujRd+YwMxrbR7nchqZXAPoGZdTrZdd0hVbn1MaDa2wLt+eF9AOlF66iwYTUrkvdnPcfi4u3rwKdorgGTGk2w15AncgVj3NTAuBhckIaOT3mjJ94x+yxygctEyDaSfpCdReWHPO/rLLBePRsMQBJLW+QWMvj+BE7d2dxVwnI0Gq7YlBPTtbwAldMPtl8OcrFLzL/yxBxkMwDuJOfZUwpbt7t7xKxJzmA0eM4NV8maHE2Qblrd34JYrk6w7YF7oTYas0Unkmiku2YdXSDlPtk5s20JCKo3KX9oygEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4540JnOz6liRsvJF/pQk9rEiU/Ak87Tll5XmyYPMy2E=;
 b=nAYusj3OItUC9UEh7zRCKdnwLLsl4+CbGs3Qru2pKU7+KUB/bJ+VICaWK1dMWrS2iYRN0IPDjz+YQtVdocC9DiUTTPBNQMKSXtJaxkCTcfqegXx9irE1eVkajxvlNAP2eC0gDCLY40t7tSU2MrLYlJw9fa2yPvcv5/azoEb9c3k=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 07:58:20 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::3d) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:19 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 07:58:07 +0000
Subject: [PATCH 3/6] pds_core: add PLDM firmware update support via devlink
 flash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-3-e43b6c92e46c@amd.com>
References: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 909deba4-35a2-44b2-202a-08dea5c51442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eiQHNOUTe5XPhKhMicG2z8ZIomU2PuOj4tdB6WrBxYcx0wI5oi6yyTfknpUyS6JKqEq2v8qXWxTxr8wFBC8TieQFG19UB8vnYYJEiai7TN+pC+XX/0xQnwqHSLFJ0foapbNxXvkVUxolOZyluBYupum+Ol8a+5bWg3s1hVaweQPhVx7E+vP5/uVjBXdc5PHezXAKcheFJo2Qi55oC3ZrcgDOb+bTcfftAgZIdAu9kdIr1tChPLdPZfrrPiKnYKG3ZYr07AhecyJfj/taYlmfrZKN012v7urCfnPb/2GRqTncYXBASYQXKI/i9dzm3O7wXdPtE8jEriFNB5KhJpBWKxWCIapaZcuia728byWoLM8ofhncco73I2PJaWjEGzmJ6gXWqwqU+nwGja9JYz5Lpwi0UNBQPLazKv4Ien2rAIp3Ccx7pnfNtksGmIDlCkrzty+oXwNtqS/J/ScjJ1YdT3oUj0ptCYvrAxq/GoY6owhJAlqR16I98t52f6UdyJTZ12wf4eOgJO7DCyf762YPLDWlKpGYCVrUQ3LvSdPNp9BqqPgvtTv1EX5VvVukAtHpLgi30oS8DZFzaN71CS+VVuE7ec5YZ+GiT3mDDJ+LqTtly4GHVmTXw4J3OY2P9HdCnzFiH1lP0ohIugAn4xw8nHbV9tMS98FIqilGLn/UWNtMgWGz8h+hE7+Wkq1p6q+8/FVvGWWlP+Rzv04L/wr2GfZSRQQWAyL+RNJUXRheIp3tAG9MmVY5go0JVtYz0x/l6wGR9/xB5jdiSbWIV/Gq/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S0bBsa/Pqi7psx5nZ1CVYvEAkc1jpTs5HlN6yf26rdnJ082FpJgSLnJRdDj6i3e0ExsU9uWgiQQXI6tVY/ACrTOGGhcSpocVzFUMD7ryxVMMcCqRUr1OBV5f+pflDOHPAZTdVSinAgv0yDY8M2nAD8/H+aroxedcXSW964OpMDKUOmDC6bEZXzaqC+5gOIPgrJrte7ojbvmb/FBXPwkyWg2kdXzVd6BfvBEHfDJdFEhBPPPMdfKBA2KbWBaeIJFRa+uLUNIwIvbGHjD8RaxGugmJ4zA1UVVVujaFtDWHyI4kjCFIzGKn3ZNo/RdDQIiUleBiahIPdTytt6qGsXL4iHNnOyQvolA3DgkjNZLbOiHx9wtwggBtzLY8X263nCv1CZDPooRuahu0/VZ/fRdqAdDYQFs2Zjg2wqL9FZvtXV+zSioRD63W6tHUEKSJp6e+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:19.9750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909deba4-35a2-44b2-202a-08dea5c51442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
X-Rspamd-Queue-Id: 225C6490DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282280-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Brett Creeley <brett.creeley@amd.com>

Implement PLDM FW Update in the pds_core driver using the upstream
pldmfw API. This allows an entire PLDM FW package to be updated
and/or specific components if they aren't fixed.

Flash the entire image:
  devlink dev flash pci/0000:b5:00.0 file firmware.pldmfw

Flash individual components from the PLDM FW package:
  devlink dev flash pci/0000:b5:00.0 \
    file firmware.pldmfw component fw.mainfwa
  devlink dev flash pci/0000:b5:00.0 \
    file firmware.pldmfw component fw.mainfwb
  devlink dev flash pci/0000:b5:00.0 \
    file firmware.pldmfw component fw.goldfw

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/Kconfig            |   1 +
 drivers/net/ethernet/amd/pds_core/core.h    |  14 +-
 drivers/net/ethernet/amd/pds_core/dev.c     |  42 +-
 drivers/net/ethernet/amd/pds_core/devlink.c |   2 +-
 drivers/net/ethernet/amd/pds_core/fw.c      | 699 +++++++++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c    |   4 +-
 include/linux/pds/pds_core_if.h             | 375 +++++++++++++++
 7 files changed, 1130 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index 45e8d698781c..e7346837dad6 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -192,6 +192,7 @@ config PDS_CORE
 	depends on 64BIT && PCI
 	select AUXILIARY_BUS
 	select NET_DEVLINK
+	select PLDMFW
 	help
 	  This enables the support for the AMD/Pensando Core device family of
 	  adapters.  More specific information on this driver can be
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 4a6b35c84dab..c9ba63878927 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -199,6 +199,8 @@ struct pdsc {
 	u64 last_eid;
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
+
+	struct pds_core_component_list_info fw_components;
 };
 
 /** enum pds_core_dbell_bits - bitwise composition of dbell values.
@@ -281,8 +283,16 @@ bool pdsc_is_fw_running(struct pdsc *pdsc);
 bool pdsc_is_fw_good(struct pdsc *pdsc);
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_with_data(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			  const void *data, size_t data_len,
+			  union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_with_data_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				const void *data, size_t data_len,
+				union pds_core_dev_comp *comp, int max_seconds);
 int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		       union pds_core_dev_comp *comp, int max_seconds);
+int pdsc_devcmd_locked_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			     union pds_core_dev_comp *comp, int max_seconds);
 int pdsc_devcmd_init(struct pdsc *pdsc);
 int pdsc_devcmd_reset(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
@@ -315,8 +325,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
 irqreturn_t pdsc_adminq_isr(int irq, void *data);
 
-int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
+int pdsc_firmware_update(struct pdsc *pdsc,
+			 struct devlink_flash_update_params *params,
 			 struct netlink_ext_ack *extack);
+int pdsc_get_component_info(struct pdsc *pdsc);
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index f77bd5e48b92..4bbf299a88dc 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -127,7 +127,7 @@ static const char *pdsc_devcmd_str(int opcode)
 }
 
 static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
-			      const bool do_msg)
+			      bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -208,6 +208,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
 }
 
+int pdsc_devcmd_locked_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			     union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, false);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {
@@ -220,6 +226,40 @@ int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_with_data(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+			  const void *data, size_t data_len,
+			  union pds_core_dev_comp *comp, int max_seconds)
+{
+	int err;
+
+	if (data_len > sizeof(pdsc->cmd_regs->data))
+		return -ENOSPC;
+
+	mutex_lock(&pdsc->devcmd_lock);
+	memcpy_toio(&pdsc->cmd_regs->data, data, data_len);
+	err = pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds);
+	mutex_unlock(&pdsc->devcmd_lock);
+
+	return err;
+}
+
+int pdsc_devcmd_with_data_nomsg(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				const void *data, size_t data_len,
+				union pds_core_dev_comp *comp, int max_seconds)
+{
+	int err;
+
+	if (data_len > sizeof(pdsc->cmd_regs->data))
+		return -ENOSPC;
+
+	mutex_lock(&pdsc->devcmd_lock);
+	memcpy_toio(&pdsc->cmd_regs->data, data, data_len);
+	err = pdsc_devcmd_locked_nomsg(pdsc, cmd, comp, max_seconds);
+	mutex_unlock(&pdsc->devcmd_lock);
+
+	return err;
+}
+
 int pdsc_devcmd_init(struct pdsc *pdsc)
 {
 	union pds_core_dev_comp comp = {};
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index b576be626a29..7f44e1a8d4fd 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -90,7 +90,7 @@ int pdsc_dl_flash_update(struct devlink *dl,
 {
 	struct pdsc *pdsc = devlink_priv(dl);
 
-	return pdsc_firmware_update(pdsc, params->fw, extack);
+	return pdsc_firmware_update(pdsc, params, extack);
 }
 
 static char *fw_slotnames[] = {
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index fa626719e68d..4ccf90f25f75 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2023 Advanced Micro Devices, Inc */
 
+#include <linux/pldmfw.h>
+#include <linux/vmalloc.h>
+
 #include "core.h"
 
 /* The worst case wait for the install activity is about 25 minutes when
@@ -14,6 +17,10 @@
 /* Number of periodic log updates during fw file download */
 #define PDSC_FW_INTERVAL_FRACTION	32
 
+#define PDSC_FW_COMPONENT_PREFIX		"fw."
+#define PDSC_FW_COMPONENT_FULL_NAME_BUFLEN \
+	(sizeof(PDSC_FW_COMPONENT_PREFIX) + PDS_CORE_FW_COMPONENT_NAME_BUFLEN)
+
 static int pdsc_devcmd_fw_download_locked(struct pdsc *pdsc, u64 addr,
 					  u32 offset, u32 length)
 {
@@ -23,7 +30,7 @@ static int pdsc_devcmd_fw_download_locked(struct pdsc *pdsc, u64 addr,
 		.fw_download.addr = cpu_to_le64(addr),
 		.fw_download.length = cpu_to_le32(length),
 	};
-	union pds_core_dev_comp comp;
+	union pds_core_dev_comp comp = {};
 
 	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
@@ -95,8 +102,9 @@ static int pdsc_fw_status_long_wait(struct pdsc *pdsc,
 	return err;
 }
 
-int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
-			 struct netlink_ext_ack *extack)
+static int pdsc_legacy_firmware_update(struct pdsc *pdsc,
+				       const struct firmware *fw,
+				       struct netlink_ext_ack *extack)
 {
 	u32 buf_sz, copy_sz, offset;
 	struct devlink *dl;
@@ -195,3 +203,688 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 						   NULL, 0, 0);
 	return err;
 }
+
+struct pdsc_component_priv {
+	char component_name[PDSC_FW_COMPONENT_FULL_NAME_BUFLEN];
+	u16 component_id;
+	bool skip;
+	struct list_head list_entry;
+};
+
+struct pds_core_fwu_priv {
+	struct pldmfw context;
+	struct devlink_flash_update_params *params;
+	struct netlink_ext_ack *extack;
+	struct pdsc *pdsc;
+	struct list_head components;
+};
+
+static void pdsc_free_fwu_priv(struct pds_core_fwu_priv *priv)
+{
+	struct pdsc_component_priv *component_priv, *tmp;
+
+	list_for_each_entry_safe(component_priv, tmp, &priv->components,
+				 list_entry) {
+		list_del(&component_priv->list_entry);
+		kfree(component_priv);
+	}
+}
+
+static int pdsc_devcmd_match_record_desc(struct pdsc *pdsc, u16 desc_type,
+					 u16 desc_size, const u8 *desc_data,
+					 u8 *match)
+{
+	union pds_core_dev_cmd cmd = {
+		.match_record_desc.opcode = PDS_CORE_CMD_MATCH_RECORD_DESC,
+		.match_record_desc.ver = 1,
+		.match_record_desc.type = cpu_to_le16(desc_type),
+		.match_record_desc.size = cpu_to_le16(desc_size),
+	};
+	union pds_core_dev_comp comp = {};
+	int err;
+
+	err = pdsc_devcmd_with_data(pdsc, &cmd, desc_data, desc_size,
+				    &comp, pdsc->devcmd_timeout);
+	*match = comp.match_record_desc.match;
+
+	return err;
+}
+
+static bool pdsc_match_record_descs(struct pldmfw *context,
+				    struct pldmfw_record *record)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pdsc *pdsc = priv->pdsc;
+	struct pldmfw_desc_tlv *desc;
+
+	if (!pldmfw_op_pci_match_record(context, record))
+		return false;
+
+	list_for_each_entry(desc, &record->descs, entry) {
+		u8 match;
+		int err;
+
+		switch (desc->type) {
+		/* skip types checked in pldmfw_op_pci_match_record */
+		case PLDM_DESC_ID_PCI_VENDOR_ID:
+		case PLDM_DESC_ID_PCI_DEVICE_ID:
+		case PLDM_DESC_ID_PCI_SUBVENDOR_ID:
+		case PLDM_DESC_ID_PCI_SUBDEV_ID:
+			continue;
+		}
+
+		if (!desc->size)
+			return false;
+
+		err = pdsc_devcmd_match_record_desc(pdsc, desc->type,
+						    desc->size, desc->data,
+						    &match);
+		if (err) {
+			dev_err(pdsc->dev, "match_record_desc failed type: 0x%04x size: %u, err %d\n",
+				desc->type, desc->size, err);
+			return false;
+		}
+		/* all record descriptors must match */
+		if (!match)
+			return false;
+	}
+
+	return true;
+}
+
+static int pdsc_devcmd_send_package_data(struct pdsc *pdsc, u64 addr,
+					 u16 length, u16 offset, u16 total_len)
+{
+	union pds_core_dev_cmd cmd = {
+		.send_pkg_data.opcode = PDS_CORE_CMD_SEND_PKG_DATA,
+		.send_pkg_data.ver = 1,
+		.send_pkg_data.data_pa = cpu_to_le64(addr),
+		.send_pkg_data.data_len = cpu_to_le16(length),
+		.send_pkg_data.offset = cpu_to_le16(offset),
+		.send_pkg_data.total_len = cpu_to_le16(total_len),
+	};
+	union pds_core_dev_comp comp = {};
+
+	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_send_package_data(struct pldmfw *context, const u8 *data, u16 length)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	u8 *package_data;
+	u32 offset;
+	int err;
+
+	if (!length)
+		return 0;
+
+	package_data = kmemdup(data, length, GFP_KERNEL);
+	if (!package_data)
+		return -ENOMEM;
+
+	offset = 0;
+	while (offset < length) {
+		dma_addr_t dma_addr;
+		u32 copy_sz;
+
+		copy_sz = min_t(unsigned int, PDS_PAGE_SIZE, length - offset);
+		dma_addr = dma_map_single(dev, package_data + offset, copy_sz,
+					  DMA_TO_DEVICE);
+		err = dma_mapping_error(dev, dma_addr);
+		if (err) {
+			dev_err(dev, "Failed to dma_map package_data at offset 0x%x copy_sz 0x%x: %pe\n",
+				offset, copy_sz, ERR_PTR(err));
+			goto out;
+		}
+
+		err = pdsc_devcmd_send_package_data(pdsc, dma_addr, copy_sz, offset,
+						    length);
+		if (err)
+			dev_err(dev, "send_package_data failed offset 0x%x addr 0x%llx len 0x%x: %pe\n",
+				offset, dma_addr, copy_sz, ERR_PTR(err));
+
+		dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
+		if (err)
+			goto out;
+
+		offset += copy_sz;
+	}
+
+out:
+	kfree(package_data);
+	return err;
+}
+
+static void pdsc_set_component_name(struct pdsc *pdsc, u16 component_id,
+				    u8 slot_id, char *component_name)
+{
+	int i;
+
+	for (i = 0; i < pdsc->fw_components.num_components; i++) {
+		struct pds_core_fw_component_info *info =
+			&pdsc->fw_components.info[i];
+
+		if (component_id == info->identifier &&
+		    slot_id == info->slot_id) {
+			snprintf(component_name,
+				 PDSC_FW_COMPONENT_FULL_NAME_BUFLEN,
+				 "fw.%s", info->name);
+			return;
+		}
+	}
+}
+
+static const char *pdsc_get_component_priv_name(struct pds_core_fwu_priv *priv,
+						u16 component_id)
+{
+	struct pdsc_component_priv *component_priv;
+
+	list_for_each_entry(component_priv, &priv->components, list_entry) {
+		if (component_priv->component_id != component_id)
+			continue;
+
+		return component_priv->component_name;
+	}
+
+	return NULL;
+}
+
+static struct pds_core_fw_component_info *
+pdsc_find_component_by_name(struct pdsc *pdsc, const char *component_name)
+{
+	struct pds_core_fw_component_info *info;
+	size_t prefix_len;
+	int i;
+
+	prefix_len = str_has_prefix(component_name, PDSC_FW_COMPONENT_PREFIX);
+	if (!prefix_len)
+		return NULL;
+
+	component_name += prefix_len;  /* Skip "fw." prefix */
+
+	for (i = 0; i < pdsc->fw_components.num_components; i++) {
+		info = &pdsc->fw_components.info[i];
+
+		if (!strncmp(component_name, info->name,
+			     PDS_CORE_FW_COMPONENT_NAME_BUFLEN))
+			return info;
+	}
+
+	return NULL;
+}
+
+static u8 pdsc_get_slot_id(struct pdsc *pdsc, const char *component_name)
+{
+	struct pds_core_fw_component_info *info;
+
+	info = pdsc_find_component_by_name(pdsc, component_name);
+	return info ? info->slot_id : PDS_CORE_FW_SLOT_MAX;
+}
+
+static bool pdsc_skip_component(struct pds_core_fwu_priv *priv,
+				u16 component_id, const char *component_name)
+{
+	struct pdsc_component_priv *component_priv;
+
+	list_for_each_entry(component_priv, &priv->components, list_entry) {
+		if (component_priv->component_id != component_id)
+			continue;
+
+		if (component_priv->skip)
+			return true;
+
+		if (component_name &&
+		    strncmp(component_priv->component_name, component_name,
+			    PDSC_FW_COMPONENT_FULL_NAME_BUFLEN))
+			return true;
+	}
+
+	return false;
+}
+
+static bool pdsc_match_component_name_to_ids(struct pdsc *pdsc,
+					     const char *component_name,
+					     u8 component_id,
+					     u8 slot_id)
+{
+	struct pds_core_fw_component_info *info;
+
+	info = pdsc_find_component_by_name(pdsc, component_name);
+	if (!info)
+		return false;
+
+	return slot_id == info->slot_id && component_id == info->identifier;
+}
+
+static int pdsc_send_component_table(struct pldmfw *context,
+				     struct pldmfw_component *component,
+				     u8 transfer_flag)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	struct pds_core_component_tbl *component_tbl;
+	struct pdsc_component_priv *component_priv;
+	struct device *dev = context->dev;
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	struct pdsc *pdsc = priv->pdsc;
+	bool skip_component = false;
+	u16 buf_sz, tbl_sz;
+	int err = 0;
+	u8 slot_id;
+
+	dev_dbg(dev, "component name %s classification %u id %u activation_method %u ver_len %d ver_str %.*s index %u size %u transfer_flag 0x%02x\n",
+		priv->params->component, component->classification,
+		component->identifier, component->activation_method,
+		component->version_len, component->version_len,
+		component->version_string, component->index,
+		component->component_size, transfer_flag);
+
+	component_priv = kzalloc_obj(*component_priv, GFP_KERNEL);
+	if (!component_priv)
+		return -ENOMEM;
+
+	if (priv->params->component) {
+		slot_id = pdsc_get_slot_id(pdsc, priv->params->component);
+		if (slot_id == PDS_CORE_FW_SLOT_MAX)
+			return -ENOENT;
+
+		if (!pdsc_match_component_name_to_ids(pdsc,
+						      priv->params->component,
+						      component->identifier,
+						      slot_id)) {
+			skip_component = true;
+			goto add_component_priv;
+		}
+	} else {
+		slot_id = PDS_CORE_FW_SLOT_INVALID;
+	}
+
+	buf_sz = sizeof(pdsc->cmd_regs->data);
+	tbl_sz = struct_size(component_tbl, version_str, component->version_len);
+	if (tbl_sz > buf_sz) {
+		dev_err(dev, "component_tbl size %d too big, max size: %d\n",
+			tbl_sz, buf_sz);
+		err = -ENOSPC;
+		goto free_component_priv;
+	}
+	component_tbl = kzalloc(tbl_sz, GFP_KERNEL);
+	if (!component_tbl) {
+		err = -ENOMEM;
+		goto free_component_priv;
+	}
+
+	component_tbl->comparison_stamp = cpu_to_le32(component->comparison_stamp);
+	component_tbl->classification = cpu_to_le16(component->classification);
+	component_tbl->identifier = cpu_to_le16(component->identifier);
+	component_tbl->transfer_flag = transfer_flag;
+	component_tbl->version_str_type = component->version_type;
+	component_tbl->version_str_len = component->version_len;
+	memcpy(component_tbl->version_str, component->version_string,
+	       component->version_len);
+
+	cmd.send_component_tbl.opcode = PDS_CORE_CMD_SEND_COMPONENT_TBL;
+	cmd.send_component_tbl.ver = 1;
+	cmd.send_component_tbl.slot_id = slot_id;
+
+	err = pdsc_devcmd_with_data(pdsc, &cmd, component_tbl, tbl_sz,
+				    &comp, pdsc->devcmd_timeout);
+	if (err)
+		dev_err(dev, "Failed sending component table: %pe\n",
+			ERR_PTR(err));
+	kfree(component_tbl);
+	if (err)
+		goto free_component_priv;
+
+	if (comp.send_component_tbl.response == 1 &&
+	    comp.send_component_tbl.response_code == PDS_CORE_COMPONENT_PREREQS_NOT_MET)
+		skip_component = true;
+	else
+		pdsc_set_component_name(pdsc, component->identifier,
+					comp.send_component_tbl.slot_id,
+					component_priv->component_name);
+
+add_component_priv:
+	component_priv->skip = skip_component;
+	component_priv->component_id = component->identifier;
+	list_add(&component_priv->list_entry, &priv->components);
+
+	return 0;
+
+free_component_priv:
+	kfree(component_priv);
+	return err;
+}
+
+int pdsc_get_component_info(struct pdsc *pdsc)
+{
+	union pds_core_dev_cmd cmd = {
+		.get_component_info.opcode = PDS_CORE_CMD_GET_COMPONENT_INFO,
+		.get_component_info.ver = 1,
+	};
+	struct pds_core_component_list_info *list_info;
+	union pds_core_dev_comp comp = {};
+	dma_addr_t dma_addr;
+	u8 num_components;
+	int err, i;
+
+	list_info = kzalloc(PDS_PAGE_SIZE, GFP_KERNEL);
+	if (!list_info)
+		return -ENOMEM;
+
+	dma_addr = dma_map_single(pdsc->dev, list_info, PDS_PAGE_SIZE, DMA_FROM_DEVICE);
+	err = dma_mapping_error(pdsc->dev, dma_addr);
+	if (err) {
+		dev_err(pdsc->dev, "Failed to dma_map component_list_info length %d: %pe\n",
+			PDS_PAGE_SIZE, ERR_PTR(err));
+		goto out;
+	}
+
+	cmd.get_component_info.data_len = cpu_to_le16(PDS_PAGE_SIZE);
+	cmd.get_component_info.data_pa = cpu_to_le64(dma_addr);
+
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout * 2);
+	dma_unmap_single(pdsc->dev, dma_addr, PDS_PAGE_SIZE, DMA_FROM_DEVICE);
+	if (err)
+		goto out;
+
+	if (comp.get_component_info.ver == 0) {
+		/* Don't support backward compatibility as version 0 has
+		 * alignment issues, so give a hint to users to update
+		 * their firmware
+		 */
+		dev_warn(pdsc->dev, "Incompatible get_component_info version %u reported by firmware\n",
+			 comp.get_component_info.ver);
+		err = 0;
+		goto out;
+	}
+
+	num_components = list_info->num_components;
+	if (num_components > PDS_CORE_FW_COMPONENT_LIST_LEN) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pdsc->fw_components.num_components = num_components;
+	for (i = 0; i < num_components; i++) {
+		struct pds_core_fw_component_info *info =
+			&pdsc->fw_components.info[i];
+
+		memcpy(info, &list_info->info[i], sizeof(*info));
+		info->version[PDS_CORE_FW_COMPONENT_VER_BUFLEN - 1] = 0;
+		info->name[PDS_CORE_FW_COMPONENT_NAME_BUFLEN - 1] = 0;
+	}
+
+out:
+	kfree(list_info);
+	return err;
+}
+
+static int pdsc_devcmd_send_component(struct pdsc *pdsc,
+				      struct pds_core_flash_component *info,
+				      u16 info_sz, dma_addr_t addr, u32 length,
+				      u32 offset, u16 slot_id,
+				      union pds_core_dev_comp *comp)
+{
+	union pds_core_dev_cmd cmd = {
+		.send_component.opcode = PDS_CORE_CMD_SEND_COMPONENT,
+		.send_component.ver = 1,
+		.send_component.operation = PDS_CORE_SEND_COMPONENT_START,
+		.send_component.data_pa = cpu_to_le64(addr),
+		.send_component.data_len = cpu_to_le32(length),
+		.send_component.offset = cpu_to_le32(offset),
+		.send_component.slot_id = slot_id,
+	};
+	unsigned long timeout = 300 * HZ;
+	unsigned long start_time;
+	unsigned long end_time;
+	int err;
+
+	start_time = jiffies;
+	end_time = start_time + timeout;
+	do {
+		/* prevent noisy/benign devcmd failures */
+		err = pdsc_devcmd_with_data_nomsg(pdsc, &cmd, info, info_sz,
+						  comp, 60);
+		if (err != -EAGAIN)
+			break;
+
+		/* if required, subsequent commands check status of
+		 * PDS_CORE_CMD_SEND_COMPONENT command, which returns
+		 * EAGAIN/ETIMEDOUT while the command is still running,
+		 * else we get the final command status.
+		 */
+		cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
+		msleep(20);
+	} while (time_before(jiffies, end_time));
+
+	if (err == -EAGAIN)
+		dev_err(pdsc->dev, "PDS_CORE_CMD_SEND_COMPONENT timed out\n");
+
+	return err;
+}
+
+static int pdsc_flash_component(struct pldmfw *context,
+				struct pldmfw_component *component)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	const char *component_name = priv->params->component;
+	struct pds_core_flash_component *component_info;
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	u16 buf_sz, info_sz;
+	struct devlink *dl;
+	u32 total_len;
+	u32 offset;
+	u8 slot_id;
+	int err;
+
+	if (pdsc_skip_component(priv, component->identifier, component_name))
+		return 0;
+
+	if (component_name) {
+		slot_id = pdsc_get_slot_id(pdsc, component_name);
+		if (slot_id == PDS_CORE_FW_SLOT_MAX)
+			return 0;
+	} else {
+		component_name = pdsc_get_component_priv_name(priv, component->identifier);
+		slot_id = PDS_CORE_FW_SLOT_INVALID;
+	}
+
+	total_len = component->component_size;
+	dev_dbg(dev, "component name %s class %u id %u act_meth %u ver_str %.*s index %u size %u\n",
+		component_name, component->classification,
+		component->identifier, component->activation_method,
+		component->version_len, component->version_string,
+		component->index, component->component_size);
+
+	buf_sz = sizeof(pdsc->cmd_regs->data);
+	info_sz = struct_size(component_info, version_str, component->version_len);
+	if (info_sz > buf_sz) {
+		dev_err(dev, "component_info size %d too big, max size: %d\n",
+			info_sz, buf_sz);
+		return -ENOSPC;
+	}
+	component_info = vzalloc(info_sz);
+	if (!component_info)
+		return -ENOMEM;
+
+	component_info->comparison_stamp = cpu_to_le32(component->comparison_stamp);
+	component_info->image_size = cpu_to_le32(total_len);
+	component_info->classification = cpu_to_le16(component->classification);
+	component_info->identifier = cpu_to_le16(component->identifier);
+	component_info->options = cpu_to_le16(component->options);
+	component_info->version_str_type = component->version_type;
+	component_info->version_str_len = component->version_len;
+	memcpy(component_info->version_str, component->version_string,
+	       component->version_len);
+
+	dl = priv_to_devlink(pdsc);
+
+	offset = 0;
+	while (offset < total_len) {
+		union pds_core_dev_comp comp = {};
+		dma_addr_t dma_addr;
+		u8 *component_data;
+		u16 copy_sz;
+
+		copy_sz = min_t(unsigned int, PDS_PAGE_SIZE, total_len - offset);
+		component_data = kmemdup(component->component_data + offset,
+					 copy_sz, GFP_KERNEL);
+		if (!component_data) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		dma_addr = dma_map_single(dev, component_data, copy_sz,
+					  DMA_TO_DEVICE);
+		err = dma_mapping_error(pdsc->dev, dma_addr);
+		if (err) {
+			dev_err(dev, "Failed to dma_map component_data at offset 0x%x copy_sz 0x%x: %pe\n",
+				offset, copy_sz, ERR_PTR(err));
+			kfree(component_data);
+			goto err_out;
+		}
+
+		err = pdsc_devcmd_send_component(pdsc, component_info, info_sz,
+						 dma_addr, copy_sz, offset,
+						 slot_id, &comp);
+		dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
+		kfree(component_data);
+		if (err && err != -EAGAIN &&
+		    comp.send_component.compat_response &&
+		    (comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_IDENTICAL ||
+		     comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_LOWER)) {
+			err = 0;
+			devlink_flash_update_status_notify(dl, "Skipped",
+							   component_name, 0, 0);
+			goto skip_component;
+		}
+
+		if (err) {
+			dev_err(dev,
+				"send_component failed offset 0x%x addr 0x%llx len 0x%x: %pe\n",
+				offset, dma_addr, copy_sz, ERR_PTR(err));
+			goto err_out;
+		}
+
+		offset += copy_sz;
+		devlink_flash_update_status_notify(dl,
+						   "Erasing/Flashing",
+						   component_name, offset,
+						   total_len);
+	}
+
+	return 0;
+
+err_out:
+	devlink_flash_update_status_notify(dl, "Erasing/Flashing Component Failed",
+					   component_name, 0, 0);
+skip_component:
+	vfree(component_info);
+	return err;
+}
+
+static int pdsc_devcmd_finalize_update(struct pdsc *pdsc)
+{
+	union pds_core_dev_cmd cmd = {
+		.finalize_update.opcode = PDS_CORE_CMD_FINALIZE_UPDATE,
+		.finalize_update.ver = 1,
+	};
+	union pds_core_dev_comp comp = {};
+
+	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_finalize_update(struct pldmfw *context)
+{
+	struct pds_core_fwu_priv *priv =
+		container_of(context, struct pds_core_fwu_priv, context);
+	const char *component_name = priv->params->component;
+	unsigned long start_time, end_time;
+	struct device *dev = context->dev;
+	struct pdsc *pdsc = priv->pdsc;
+	struct devlink *dl;
+	int err;
+
+	dl = priv_to_devlink(pdsc);
+
+	start_time = jiffies;
+	end_time = start_time + (PDSC_FW_INSTALL_TIMEOUT * HZ);
+	do {
+		err = pdsc_devcmd_finalize_update(pdsc);
+		if (!err || err != -EAGAIN)
+			break;
+
+		dev_dbg(dev, "retrying finalize_update: %pe\n", ERR_PTR(err));
+		msleep(20);
+	} while (time_before(jiffies, end_time) && err == -EAGAIN);
+
+	if (err) {
+		devlink_flash_update_status_notify(dl, "Finalize Update Failed",
+						   component_name, 0, 0);
+		dev_err(dev, "finalize_update failed: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	devlink_flash_update_status_notify(dl, "Finalized Update",
+					   component_name, 0, 0);
+	return 0;
+}
+
+static const struct pldmfw_ops pdsc_pldmfw_ops = {
+	.match_record = pdsc_match_record_descs,
+	.send_package_data = pdsc_send_package_data,
+	.send_component_table = pdsc_send_component_table,
+	.flash_component = pdsc_flash_component,
+	.finalize_update = pdsc_finalize_update
+};
+
+static int pdsc_pldm_firmware_update(struct pdsc *pdsc,
+				     struct devlink_flash_update_params *params,
+				     struct netlink_ext_ack *extack,
+				     const struct firmware *fw)
+{
+	struct pds_core_fwu_priv priv = {};
+	int err;
+
+	/* If no component filter specified, devlink core didn't refresh cache,
+	 * so we must refresh to handle stale cache from previous updates.
+	 */
+	if (!params->component) {
+		err = pdsc_get_component_info(pdsc);
+		if (err) {
+			dev_err(pdsc->dev, "Failed to get component info: %pe\n", ERR_PTR(err));
+			return err;
+		}
+	}
+
+	INIT_LIST_HEAD(&priv.components);
+	priv.context.ops = &pdsc_pldmfw_ops;
+	priv.context.dev = pdsc->dev;
+	priv.params = params;
+	priv.pdsc = pdsc;
+
+	err = pldmfw_flash_image(&priv.context, fw);
+	pdsc_free_fwu_priv(&priv);
+
+	return err;
+}
+
+int pdsc_firmware_update(struct pdsc *pdsc,
+			 struct devlink_flash_update_params *params,
+			 struct netlink_ext_ack *extack)
+{
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
+	    pdsc->dev_ident.capabilities & cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
+		return pdsc_pldm_firmware_update(pdsc, params, extack, params->fw);
+
+	return pdsc_legacy_firmware_update(pdsc, params->fw, extack);
+}
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..f0d0993f9d91 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -340,7 +340,9 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	is_pf = !pdev->is_virtfn;
 	ops = is_pf ? &pdsc_dl_ops : &pdsc_dl_vf_ops;
-	dl = devlink_alloc(ops, sizeof(struct pdsc), dev);
+	dl = devlink_alloc(ops, sizeof(struct pdsc) +
+			   PDS_CORE_FW_COMPONENT_LIST_LEN *
+			   sizeof(struct pds_core_fw_component_info), dev);
 	if (!dl)
 		return -ENOMEM;
 	pdsc = devlink_priv(dl);
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 619186f26b5b..b8052985dddf 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -40,6 +40,13 @@ enum pds_core_cmd_opcode {
 	PDS_CORE_CMD_FW_DOWNLOAD	= 4,
 	PDS_CORE_CMD_FW_CONTROL		= 5,
 
+	PDS_CORE_CMD_GET_COMPONENT_INFO	= 6,
+	PDS_CORE_CMD_SEND_PKG_DATA	= 7,
+	PDS_CORE_CMD_SEND_COMPONENT_TBL	= 8,
+	PDS_CORE_CMD_SEND_COMPONENT	= 9,
+	PDS_CORE_CMD_FINALIZE_UPDATE	= 10,
+	PDS_CORE_CMD_MATCH_RECORD_DESC	= 11,
+
 	/* SR/IOV commands */
 	PDS_CORE_CMD_VF_GETATTR		= 60,
 	PDS_CORE_CMD_VF_SETATTR		= 61,
@@ -100,6 +107,14 @@ struct pds_core_drv_identity {
 	char   driver_ver_str[32];
 };
 
+/**
+ * enum pds_core_dev_capability - Device capabilities
+ * @PDS_CORE_DEV_CAP_PLDM_FW_UPDATE: Device only supports FW update via PLDM
+ */
+enum pds_core_dev_capability {
+	PDS_CORE_DEV_CAP_PLDM_FW_UPDATE = BIT(0),
+};
+
 #define PDS_DEV_TYPE_MAX	16
 /**
  * struct pds_core_dev_identity - Device identity information
@@ -119,6 +134,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @max_fw_slots:     Maximum number of fw slots/components
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  * @capabilities:     Device capabilities
  *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
@@ -133,6 +150,7 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le16 max_fw_slots;
 	__le64 capabilities;
 };
 
@@ -284,6 +302,7 @@ enum pds_core_fw_slot {
 	PDS_CORE_FW_SLOT_A	    = 1,
 	PDS_CORE_FW_SLOT_B          = 2,
 	PDS_CORE_FW_SLOT_GOLD       = 3,
+	PDS_CORE_FW_SLOT_MAX        = 0xff,
 };
 
 /**
@@ -450,6 +469,348 @@ struct pds_core_vf_ctrl_comp {
 	u8	status;
 };
 
+/**
+ * struct pds_core_send_pkg_data_cmd
+ * @opcode: Opcode PDS_CORE_CMD_SEND_PKG_DATA
+ * @ver: Driver's max support version of this command
+ * @total_len: Total length of the package data
+ * @offset: Offset in the package data, non-zero if multiple commands are
+ *	    needed for sending the package data
+ * @data_len: Length of data stored at data_pa
+ * @data_pa: Data physical address for DMA to device
+ *
+ * The package data may be too large to store in a single buffer, so multiple
+ * PDS_CORE_CMD_SEND_PKG_DATA devcmds may be needed.
+ */
+struct pds_core_send_pkg_data_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 total_len;
+	__le16 offset;
+	__le16 data_len;
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_send_pkg_data_comp - Send package data completion
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_pkg_data_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_component_tbl - Component table details
+ * @comparison_stamp: Comparison stamp used for component version checks
+ * @classification: Vendor specific classification info
+ * @identifier: Component's ID
+ * @transfer_flag: Part of the component table this request represents
+ * @version_str_type: The types of strings used
+ * @version_str_len: Length of @version_str
+ * @version_str: Component version information
+ */
+struct pds_core_component_tbl {
+	__le32 comparison_stamp;
+	__le16 classification;
+	__le16 identifier;
+	u8     transfer_flag;
+	u8     version_str_type;
+	u8     version_str_len;
+	u8     version_str[];
+};
+
+/**
+ * struct pds_core_send_component_tbl_cmd
+ * @opcode: Opcode PDS_CORE_CMD_SEND_COMPONENT_TBL
+ * @ver: Driver's max support version of this command
+ * @slot_id: enum pds_core_fw_slot
+ * @rsvd: Word boundary padding
+ *
+ * Expects to find component table info (struct pds_core_component_tbl)
+ * in cmd_regs->data.  Driver should keep the devcmd interface locked
+ * while preparing the component table info.
+ */
+struct pds_core_send_component_tbl_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 slot_id;
+	u8 rsvd;
+};
+
+enum pds_core_component_resp_code {
+	PDS_CORE_COMPONENT_VALID = 0x0,
+	PDS_CORE_COMPONENT_STAMP_IDENTICAL = 0x1,
+	PDS_CORE_COMPONENT_STAMP_LOWER = 0x2,
+	PDS_CORE_COMPONENT_STAMP_OR_VERSION_INVALID = 0x3,
+	PDS_CORE_COMPONENT_CONFLICT = 0x4,
+	PDS_CORE_COMPONENT_PREREQS_NOT_MET = 0x5,
+	PDS_CORE_COMPONENT_NOT_SUPPORTED = 0x6,
+	PDS_CORE_COMPONENT_FW_TYPE_INVALID = 0xd0,
+};
+
+/**
+ * struct pds_core_send_component_tbl_comp
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @completion_code: Component completion code
+ * @response: Component response
+ * @response_code: Component response code
+ * @slot_id: Actual slot_id of the component (enum pds_core_fw_slot)
+ *
+ * When alternate firmware is requested via PDS_CORE_FW_SLOT_INVALID, the
+ * completion's slot_id will match the actual slot_id that will be flashed
+ * on success. When specific components are flashed, then the completion's
+ * slot_id will match the command's slot_id.
+ *
+ * On failure the slot_id will be set to PDS_CORE_FW_SLOT_MAX.
+ * On success the slot_id will be PDS_CORE_FW_SLOT_A, PDS_CORE_FW_SLOT_B, or
+ * PDS_CORE_FW_SLOT_GOLD.
+ *
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_component_tbl_comp {
+	u8 status;
+	u8 ver;
+	u8 completion_code;
+	u8 response;
+	u8 response_code;
+	u8 slot_id;
+	u8 rsvd[2];
+};
+
+/**
+ * enum pds_core_send_component_op - PDS_CORE_CMD_SEND_COMPONENT operation
+ * @PDS_CORE_SEND_COMPONENT_START: Initial operation to start transfer
+ * @PDS_CORE_SEND_COMPONENT_STATUS: Subsequent calls to check on status
+ * PDS_CORE_CMD_SEND_COMPONENT
+ */
+enum pds_core_send_component_op {
+	PDS_CORE_SEND_COMPONENT_START = 0,
+	PDS_CORE_SEND_COMPONENT_STATUS = 1,
+};
+
+#define PDS_CORE_FW_COMPONENT_ID_INVALID 0xFFFF
+/**
+ * struct pds_core_flash_component - Component details
+ * @comparison_stamp: Comparison stamp used for component version checks
+ * @image_size: Component image size
+ * @classification: Vendor specific classification info
+ * @identifier: Component's ID
+ * @options: Component options
+ * @rsvd: Word boundary padding
+ * @version_str_type: The types of strings used
+ * @version_str_len: Length of @version_str
+ * @version_str: Component version information
+ */
+struct pds_core_flash_component {
+	__le32 comparison_stamp;
+	__le32 image_size;
+	__le16 classification;
+	__le16 identifier;
+	__le16 options;
+	u8 rsvd[3];
+	u8 version_str_type;
+	u8 version_str_len;
+	u8 version_str[];
+};
+
+/**
+ * struct pds_core_send_component_cmd
+ * @opcode: Opcode PDS_CORE_CMD_SEND_COMPONENT
+ * @ver: Driver's max supported version of this command
+ * @slot_id: enum pds_core_fw_slot
+ * @operation: enum pds_core_send_component_op
+ * @offset: Offset into the component, non-zero if multiple commands
+ *	    are needed for a single component
+ * @data_len: Length of this part of the component stored at @data_pa
+ * @rsvd: Word boundary padding
+ * @data_pa: DMA address of the component
+ *
+ * A component may be too large to store in a single buffer, so multiple
+ * PDS_CORE_CMD_SEND_COMPONENT devcmds may be needed.
+ *
+ * Expects to find flash component info (struct pds_core_flash_component)
+ * in cmd_regs->data. Driver should keep the devcmd interface locked
+ * while preparing and sending the flash component info.
+ */
+struct pds_core_send_component_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 slot_id;
+	u8 operation;
+	__le32 offset;
+	__le32 data_len;
+	u8 rsvd[4];
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_send_component_comp
+ * @status: Status of the command (enum pds_core_status_code)
+ * @ver: Device's max supported version of this command
+ * @completion_code: Completion code
+ * @compat_response: Compatibility response (0 = Component can be updated)
+ * @compat_response_code: Compatibility response code
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_send_component_comp {
+	u8 status;
+	u8 ver;
+	u8 completion_code;
+	u8 compat_response;
+	u8 compat_response_code;
+	u8 rsvd[3];
+};
+
+/**
+ * enum pds_core_component_info_flags
+ * @PDS_CORE_FW_COMPONENT_INFO_F_RUNNING: Component is currently running
+ * @PDS_CORE_FW_COMPONENT_INFO_F_STARTUP: Component version on next FW boot
+ * @PDS_CORE_FW_COMPONENT_INFO_F_FIXED: Component is fixed and cannot be updated
+ * @PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME: Component can be updated by name
+ */
+enum pds_core_component_info_flags {
+	PDS_CORE_FW_COMPONENT_INFO_F_RUNNING = BIT(0),
+	PDS_CORE_FW_COMPONENT_INFO_F_STARTUP = BIT(1),
+	PDS_CORE_FW_COMPONENT_INFO_F_FIXED = BIT(2),
+	PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME = BIT(3),
+};
+
+/**
+ * struct pds_core_fw_component_info - GET_COMPONENT_INFO entry
+ * @name: Component's name
+ * @rsvd: Word boundary padding
+ * @flags: enum pds_core_component_info_flags
+ * @identifier: Component's identifier
+ * @slot_id: Component's slot identifier
+ * @version: Component's version
+ */
+struct pds_core_fw_component_info {
+#define PDS_CORE_FW_COMPONENT_NAME_BUFLEN 24
+	char name[PDS_CORE_FW_COMPONENT_NAME_BUFLEN];
+	u8 rsvd[4];
+	__le16 flags;
+	u8 identifier;
+	u8 slot_id;
+#define PDS_CORE_FW_COMPONENT_VER_BUFLEN 32
+	char version[PDS_CORE_FW_COMPONENT_VER_BUFLEN];
+};
+
+#define PDS_CORE_FW_COMPONENT_LIST_LEN	((PDS_PAGE_SIZE - \
+		sizeof(struct pds_core_component_list_info)) / \
+		sizeof(struct pds_core_fw_component_info))
+
+#if defined(__has_attribute) && !__has_attribute(__counted_by__)
+#define __counted_by(member)
+#endif
+
+/**
+ * struct pds_core_component_list_info - GET_COMPONENT_INFO completion data
+ * @num_components: Number of valid components
+ * @info: List of valid components
+ */
+struct pds_core_component_list_info {
+	u8 num_components;
+	struct pds_core_fw_component_info info[] __counted_by(num_components);
+} __packed;
+
+/**
+ * struct pds_core_get_component_info_cmd - GET_COMPONENT_INFO command
+ * @opcode: PDS_CORE_CMD_GET_COMPONENT_INFO
+ * @ver: Driver's max supported version of this command
+ * @data_len: Length of data at data_pa
+ * @rsvd: Word boundary padding
+ * @data_pa: DMA address of data
+ *
+ * FW populates struct pds_core_component_list_info pointed to by @data_pa
+ */
+struct pds_core_get_component_info_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 data_len;
+	u8 rsvd[4];
+	__le64 data_pa;
+};
+
+/**
+ * struct pds_core_get_component_info_comp - GET_COMPONENT_INFO completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_get_component_info_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_finalize_update_cmd - FINALIZE_UPDATE command
+ * @opcode: PDS_CORE_CMD_FINALIZE_UPDATE
+ * @ver: Driver's max support version of this command
+ * @rsvd: Word boundary padding
+ *
+ * Driver sends at the end of updating all components to finalize the update
+ */
+struct pds_core_finalize_update_cmd {
+	u8 opcode;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_finalize_update_comp - FINALIZE_UPDATE completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @rsvd: Word boundary padding
+ */
+struct pds_core_finalize_update_comp {
+	u8 status;
+	u8 ver;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_match_record_desc_cmd - MATCH_RECORD_DESC command
+ * @opcode: PDS_CORE_CMD_MATCH_RECORD_DESC
+ * @ver: Driver's max supported version of this command
+ * @type: PLDM Descriptor Identifier Type
+ * @size: Length of the Descriptor Identifier Value
+ * @rsvd: Word boundary padding
+ *
+ * Expects to find the Descriptor Identifier Data in cmd_regs->data. Driver
+ * should keep the devcmd interface locked while preparing and sending this
+ * command.
+ */
+struct pds_core_match_record_desc_cmd {
+	u8 opcode;
+	u8 ver;
+	__le16 type;
+	__le16 size;
+	u8 rsvd[2];
+};
+
+/**
+ * struct pds_core_match_record_desc_comp - MATCH_RECORD_DESC completion
+ * @status: enum pds_core_status_code
+ * @ver: Device's max supported version of this command
+ * @match: Whether or not the Record Descriptor matches the device
+ * @rsvd: Word boundary padding
+ *
+ * When status is PDS_RC_SUCCESS, then @match is valid, otherwise it's
+ * undefined.
+ */
+struct pds_core_match_record_desc_comp {
+	u8 status;
+	u8 ver;
+	u8 match;
+	u8 rsvd;
+};
+
 /*
  * union pds_core_dev_cmd - Overlay of core device command structures
  */
@@ -466,6 +827,13 @@ union pds_core_dev_cmd {
 	struct pds_core_vf_setattr_cmd   vf_setattr;
 	struct pds_core_vf_getattr_cmd   vf_getattr;
 	struct pds_core_vf_ctrl_cmd      vf_ctrl;
+
+	struct pds_core_get_component_info_cmd get_component_info;
+	struct pds_core_send_pkg_data_cmd      send_pkg_data;
+	struct pds_core_send_component_tbl_cmd send_component_tbl;
+	struct pds_core_send_component_cmd     send_component;
+	struct pds_core_finalize_update_cmd    finalize_update;
+	struct pds_core_match_record_desc_cmd  match_record_desc;
 };
 
 /*
@@ -484,6 +852,13 @@ union pds_core_dev_comp {
 	struct pds_core_vf_setattr_comp   vf_setattr;
 	struct pds_core_vf_getattr_comp   vf_getattr;
 	struct pds_core_vf_ctrl_comp      vf_ctrl;
+
+	struct pds_core_get_component_info_comp get_component_info;
+	struct pds_core_send_pkg_data_comp      send_pkg_data;
+	struct pds_core_send_component_tbl_comp send_component_tbl;
+	struct pds_core_send_component_comp     send_component;
+	struct pds_core_finalize_update_comp    finalize_update;
+	struct pds_core_match_record_desc_comp  match_record_desc;
 };
 
 /**

-- 
2.43.0


