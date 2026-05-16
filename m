Return-Path: <netdev+bounces-288559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJguMJLaB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4B559F1F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801BF3038A73
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9622868A7;
	Sat, 16 May 2026 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fS+l+4gj"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C025025B087;
	Sat, 16 May 2026 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899466; cv=fail; b=IJNM04feVFZHNHTw16yOeaAJK91jvBiNKuFICefaKQQKSgFvRQgiOMeRpVIMdBcNGwKx1V+9l92IRt75zv5/KEdE6XGt9MzqGNVdeOIEC9xf7vQdqUQPEk2EJjkeMfE2+oPcfzHTNgBKjrBn2w09Ya8+iOpXju9JYDjdzgTmpTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899466; c=relaxed/simple;
	bh=m8yARpr220UPTklXFkOB3JiSX//yTssgVV+v/MkVxXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rdU5atW+ldNwfZMgus01qNuK43cIe0fn/NahqJjBAMRRMeOKHo2u7kkK6hnoHpJRvV61R+OhU/X2AoE61nLdpTnSZbr0Fmiw2m541Zvp74vqiaQiQE8jdwUyvFDDegxFJSAwrsL02+N8WPG5w8pjVvCO8Xmlox7+e/zBJH8kOkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fS+l+4gj; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOBXwOSvRJachRKh1QSmy59rPTIASTqoScPwPGr9TP+n0E4OqrD+2w3Jxq1D6qWQH5KrJgQOBYl3DQsNnTjekrdIueDCujO+zU2N3ZGQp22fplPa/trH+6joREplvsrIUwT+Q+zdWzbC+FuGpNjrksK97jU6MMJlQF88QyUw3HaY9UH8+H4IINy0XzdHrv7T4MpvRxBvmJUngIjO/IGiumQEes5TXQVRnrDnBkwe5BGzrv6oHMtAyKyqDzD9L0+FhC98d+iI4V8dBo00I+8JYUkneUt5WZkIO4kVAjmBXc/IQRowQapBx5VVGIrB25Xmnxx2ptZ16FU8nS0WYGyNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixbu52fe5Bc+2VPDdboXn7L11/N6YPzWXlqWfGR5tQw=;
 b=C5qsFlw/bKtdxZkw3wuJ+YWa8OGX/gnS6rSqJlTbzWr6TjvtifZ0vSojN4useDCSFbJkdI+m7/5EDyxmEDe8XegzMZja8slVDK+fHVCdF9gBeLNWWiCLcR0tKwmxZ+JtXbx+LMKhFBvCXfv99AEfh05yFFms+BIqkXi4T7MK0q1HK4rKKn552gdPRlL8Fr5EO4idfu3ATDHhBDQMCBAN8UWAlbr5p74YQ2MuKzjW2Kv3uZ7v4uid+HMlVFWvyZroEGqclgB7FE7jGbq9MdCwjmlyZKlptQnrnBP+Tza4aXiSc+rVGTwHFHdm36+nZ4cS+LdXt0fhQC8GUvNeT+5NJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixbu52fe5Bc+2VPDdboXn7L11/N6YPzWXlqWfGR5tQw=;
 b=fS+l+4gjqNl+d8OCNOliMrvkFDqL5xrHuhA/oRsWEkfBEAtuGabDufDeZrs0yFDFQntwivezBYvcrnI4E34Ar/7J2J2lE4Qbr0xfnXDci/Y0L1tOMDM4lLPxEbfMA2FTtI3QnObXkrk2xpAqiJJj/xNulYodvBBqnSQfxjPLBZ0=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sat, 16 May
 2026 02:44:16 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::77) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:14 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 16 May 2026 02:42:38 +0000
Subject: [PATCH net-next v2 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260516-upstream_v2_clean-v2-4-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
In-Reply-To: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: f93720e3-3823-46f8-4651-08deb2f5058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|11063799003|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	pimmGyrhqL1V9QaPG4UTTh8beM5WELyvLtqJrqJdu4tSt19zQBjxo9UdXDjj3VMdxGYkhh+5asIHgCJ+qepANP0N3y48Rko7jxV14ssuc2aZMoxvayLh4zmGoGQ33qxngS2ZIJUT4bxG1cFunBCpFYUCvhgjjpxeCl5Zzjn2SImfox4N4JsncAmbd9Kgo6tFuAis4p9L/BNkGErh82bFD5Pa20VmmOnaEJ5CH8+vxIU+8iRXgm/ooOAjd/ho+21fXbg8MQzc4/qbSOcqBXQf5oxL54ulb3BndHeD01n9HK0fc6+1nPODiZvp4hiRU/bwafm0OxjB961Ue3GktzweV7fdaGPnIGKjpnxOVL0X6KZZ4ktuNJaTdbYsBCNAJKQDlZMlflLVlrxlhYSnqUyAlt0Hyc7UuzuGgEU7GKjgZ3qnonpggkdZLpCUvKs0PsMF3ZUv9B0hEp7zLtS6miLiLwI0eaxio7rEhsF/Ku8kJC2k9TbG1AATKIIsFoA2aNPEOGLXMJlJXNUPR5LMR17725g67yZao0WjrnFQBxgijJAN1rySwiyyYzl1b50zbVKP1hVCqIK9IReCSBon9DvJ6uF/wElzmgU1jCHKPeIq/22NdxM6SAFXP4k8Xjaj91UtZMGnbnjUkUE2Rda7SPpyYY9YB2ftN2HL+h0bK53lCQ7aQXhXU4qg36w5TQLgDEfGPTrfyxoj1dUdCr2cX+3NgVK/bz17agEBdspxeHGCfgI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799003)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZvKftYMg+A874HUZUGNRog8+uMYgBbnFxcxkMqGMZ5i4/GGX4V17FylUHIieGSSCefmoZqNizae/s4HB1UzoYAU0YpVsXLLdroeHWSCPPI9POEAx5NOk0I8jxmveqWGiLsbQfwH2HYtI5CsBQ8BHpToUKJoOaRmQQGetHHKqiqbOaYqaPZTbIL2JAOXFtmP0wJ72ytQorhxKBuc/hyZMliigWPYOEOuO8uYWYxtNXeY0A1h5LlxFeEfVqIDB/CIFNzzId65Io5hPzyzMp6SKdXmJ+Mg+e9cluvQdC/SqvjChzGkxuIMI5WrT2BfPua2V5k8kTbUdTgvQ9hEFeDiOKnAiRCYbfTNE2iwDAAoZjrKyL13MVm5VBF9lSeWICscW1v2N20zurEbgGTXvOPPh+ESWbP5rQ8f4q4wAaAv2NQj/V7SF4j7emBYRHjOSt9qE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:16.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93720e3-3823-46f8-4651-08deb2f5058d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
X-Rspamd-Queue-Id: 3DB4B559F1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288559-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Brett Creeley <brett.creeley@amd.com>

Add detailed component information display. This allows users to see
individual firmware components, their versions, and update status via
devlink info. Components are marked as fixed, running, or stored based
on their flags.

Example output:
  $ devlink dev info pci/0000:b5:00.0
  ...
  versions:
    running:
      fw.goldfw 1.2.3
      fw.mainfwa 1.2.4
      fw.mainfwb 1.2.3

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 88 ++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 7f44e1a8d4fd..95c3d2531ef1 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,78 @@ int pdsc_dl_flash_update(struct devlink *dl,
 	return pdsc_firmware_update(pdsc, params, extack);
 }
 
+static int pdsc_dl_report_component(struct devlink_info_req *req,
+				    struct pds_core_fw_component_info *info)
+{
+	enum devlink_info_version_type ver_type;
+	u16 flags = le16_to_cpu(info->flags);
+	char *ver = info->version;
+	char buf[32];
+
+	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
+	snprintf(buf, sizeof(buf), "fw.%s", info->name);
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
+		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED)
+		return devlink_info_version_fixed_put(req, buf, ver);
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
+		int err;
+
+		err = devlink_info_version_running_put_ext(req, buf,
+							   ver, ver_type);
+		if (err)
+			return err;
+	}
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP)
+		return devlink_info_version_stored_put_ext(req, buf,
+							   ver, ver_type);
+
+	return 0;
+}
+
+static int pdsc_dl_component_info_get(struct devlink *dl,
+				      struct devlink_info_req *req,
+				      struct netlink_ext_ack *extack)
+{
+	struct pds_core_component_list_info *list_info;
+	struct pdsc *pdsc = devlink_priv(dl);
+	u8 num_components;
+	int err;
+	int i;
+
+	if (!pdsc->fw_components.num_components) {
+		err = pdsc_get_component_info(pdsc);
+		if (err) {
+			dev_err(pdsc->dev, "Failed to get component_info %pe\n",
+				ERR_PTR(err));
+			return err;
+		}
+	}
+
+	list_info = &pdsc->fw_components;
+	num_components = min_t(u8, list_info->num_components,
+			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
+	for (i = 0; i < num_components; i++) {
+		err = pdsc_dl_report_component(req, &list_info->info[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static char *fw_slotnames[] = {
 	"fw.goldfw",
 	"fw.mainfwa",
 	"fw.mainfwb",
 };
 
-int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
-		     struct netlink_ext_ack *extack)
+static int pdsc_dl_fw_list_info_get(struct devlink *dl,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
 {
 	union pds_core_dev_cmd cmd = {
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
@@ -132,6 +196,26 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
+	return 0;
+}
+
+int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
+		     struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	char buf[32];
+	int err;
+
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2)
+		err = pdsc_dl_component_info_get(dl, req, extack);
+	else
+		err = pdsc_dl_fw_list_info_get(dl, req, extack);
+	if (err) {
+		dev_err(pdsc->dev, "Failed to get devlink info for identity version %u: %pe\n",
+			pdsc->dev_ident.version, ERR_PTR(err));
+		return err;
+	}
+
 	err = devlink_info_version_running_put(req,
 					       DEVLINK_INFO_VERSION_GENERIC_FW,
 					       pdsc->dev_info.fw_version);

-- 
2.43.0


