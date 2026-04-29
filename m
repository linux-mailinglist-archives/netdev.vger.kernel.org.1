Return-Path: <netdev+bounces-282296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3BLCrC8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E649138B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683BC309CC8E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35063B4E9A;
	Wed, 29 Apr 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhwIY40S"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27B3B38BE;
	Wed, 29 Apr 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451319; cv=fail; b=WA/t83s98uxVXbR5WX21tE0mT+YQhR25plPD+QRZyri7WHcMXNpma7oKWryakZEIZA6d13/Pq/VCYnd/wQBrHFhj7s7BMHYw8WF/FrKEEly9hPC/8ocsYWy3Dbinwo7cQMyb94fUArIJztmoUdQE8avJkZR+XcNt5RG/Y1RLEIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451319; c=relaxed/simple;
	bh=um4WLFVrwDgoU2VKc/3wvQW8Co0Ji4wUOD5AiIMJBuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ydw+w7EUtO1kH5ZzhLh3nZYT3JSqcZkPCje0akH8lEqWdO2AeyUO+Keu2Ea270/oob7U0cboIzWuuMuldh3QSP6vX717F9uY0ZEJcuOC3cb/2PDvAEjhlgHjoUibpGaNv1Wb2pYa1dw+PGv9Lt0hazsdxcFblptGGG0zJWjdrn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhwIY40S; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2wMNe+qvPPKv2sOdAg9ibs4BATbWq5+HNCao+Ynp7icuVVnnVDIfwn4bEJa9AJcbJMe61SFsCpqgZVxV9Pue0pfKCHe7Y9K4XzStAyEi9xJIWxhnA3oG/bA0A1V4R8HU2406J8rKDNRutcKSwgmk0G/3LWOVSeIDyjRdUjcXNoXlA/LWQlruH5dastuVbtVftSmfd0MdT2fHufG008SEHVZW1bOvV1tCznWQmtaQvtw72jXZktEztJI7IX9/d2ed5zXxG+Zwz94X9GnG1IOwb+T57h3FpNYMZBHOSQxJZQt8QcxeJM6BjWjX6Ax9nmOqHIPvM/sTVVfZAc8MLxVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x23hehrKiM8NIyZIMJTH7Ruuujg7b53WQ7E6k8JiXcY=;
 b=cvy8lp9Gq7NZX5IQ1J0fTawdJ05LXXBzMcuhs5FdVIYCXHcHh8WJqjL9wuVoKPzH5QDry9SIS1y7ejUK15vzZg157bWAKif4MluKZL8O0x/G53wKHD4A6pttG7YcdxJcgewAb35zGnhNPjOiKT/qwvHOmdW5oM7FQVmKwmRSuoqcKXI2opkmNY0Okm97zly9ZqLatADh5osaBlIYTPl5xWwlYoBoUj9SuZEo817cy1WuVe0fDqzqxY9DPZRGIf3/rhTumD8Xr4nQsWT1G6HZQAwA9ZJxZWuo92zn3+i1qvcs/ctiCAFVESwpNrrxiplgMslpHcqXcsv2VLRc72HHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x23hehrKiM8NIyZIMJTH7Ruuujg7b53WQ7E6k8JiXcY=;
 b=vhwIY40SLsAirTDPRAFcxWgmQFVLMXuxYiV1BByqWn+9aF6jHxnFHItWR8/vDzTLU6m7ma4Vr9VbuU9AKzKGcutemnOdzZHi7IjQM8lfeNYXKtfheyZYwiTqVjmQfsCBbs5cWMZdSe+f72U0AYg1GV3xi/wDaLesg0+V7mcwny8=
Received: from MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::9)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:28:31 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::60) by MN0P221CA0023.outlook.office365.com
 (2603:10b6:208:52a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.29 via Frontend Transport; Wed,
 29 Apr 2026 08:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:28:31 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 03:28:30 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 08:28:20 +0000
Subject: [PATCH net-next 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-4-394fafba526f@amd.com>
References: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
In-Reply-To: <20260429-b4-pldm-b4-v1-0-394fafba526f@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 159965eb-d481-4ae7-279c-08dea5c94bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pI8atkWiF/NWL4t01Lk40YGZzrEe/IziXp775r2fucM+uvcG8LyozimrSgUcmT1NVPXOQiPVOV0MLgN4M5hhfnSWit3U48Q6Di0If6+KEBDYD/RLkiv59bF3lQe77zk6yveK/QMh8zY/Ec9zOzW090N7hV152p2RDByb5Joe+m2nnX5/yDBBt5JLPWpxS9R7+RRxaG2HwRTm36WuYVylHosf73tadpaOCKPjJp9ncGwKf8PNQLaewuPXs4UPDR6DsjiRnuAOe841hfVeogxGgUTQ6cZEpvgW/30A19URT6peZbql7RnV1+VzRTi+t2r62veavdjWsNttVGYDWN5p27kqgdPYeAYjVTgomF9/QfGOyeZrn6W+vLPpbNdFEj/+36M7An84nSgkBMPRcQyzNmNM8/0VVuc+eO1mIKvwDA4swAVUmHHhFuarl/0S/ARW0fB12zIU9VuIacB6M+szN3d4+NU1gdCHLOCXCbNMBK5SBAH9+QIH/L0kmhLyuDj7MrOVBVGVAf7yJZYvxaQNp9R+YshbsK7ge2+JvmrNf1Z2y5nnm8yvNjWKeDVFxkbVq0uB4yJN1om3TqskQGq3XxOREMtGN/v1hGzza7SeUC64WxW/7MG3BsxyhIHBy/wnxgBZbPTTL+J0H2OxK0K93ZE38SOW6EOTVTQHftkwFXIXhMZNC1Tv9PvfhvsvbQSLZQpgDc1i7E6O/X2G8Fvo8HwsXdXAGCu0DnAYArqsPzXsD9Vymhulg/536LuQilPRm5181B+beE6uBg0T3JZ2xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q/MwIvzeZOd00UuVdLT0bwSFBtAX7s+SqZW7VUgdKJipO1/OFUsSVcFJ7+awrmqpbyH8TyHmST1LOsEs4WwuYp04dCyJNRjMxKM6OSC9orFfyk5Svy3c8gB2OWc8af91sfZyS/b9p9QmmV++mHiu2LsOZ6/BP4OasIoKS02hDq7RoE+WpVBSFBYDIEHt1SW7kuL56hiyBfRbACM6dRG+qlT3LMFr7C0NzGkwScMg6aWEzU+WvBsx1fPPoDKPbe/7P4hEEDGIBWbvjanHNSnVcFNqZfWTsuvnnuDGyPwESnJGyU8SSG4hc0k+lL2svZHXjwt7TTSFt/ypfm6FLLj1zRee8/uWAa2pdySl5I45KImMYUnktYuaNiIsI0Edz9eqVdAgq5A2VUX+QriimzUec7fHnsR8jp1SeLWhi7+wn5syFSXNOOmDplCmZuYM1lwF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:28:31.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159965eb-d481-4ae7-279c-08dea5c94bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
X-Rspamd-Queue-Id: 0E3E649138B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-282296-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

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
 drivers/net/ethernet/amd/pds_core/devlink.c | 75 ++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 7f44e1a8d4fd..c519fde45d71 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,61 @@ int pdsc_dl_flash_update(struct devlink *dl,
 	return pdsc_firmware_update(pdsc, params, extack);
 }
 
+static int pdsc_dl_component_info_get(struct devlink *dl,
+				      struct devlink_info_req *req,
+				      struct netlink_ext_ack *extack)
+{
+	struct pds_core_component_list_info *list_info;
+	struct pdsc *pdsc = devlink_priv(dl);
+	u8 num_components;
+	char buf[32];
+	int err;
+	int i;
+
+	err = pdsc_get_component_info(pdsc);
+	if (err) {
+		dev_err(pdsc->dev, "Failed to get component_info %pe", ERR_PTR(err));
+		return err;
+	}
+
+	list_info = &pdsc->fw_components;
+	num_components = min_t(u8, list_info->num_components,
+			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
+	for (i = 0; i < num_components; i++) {
+		enum devlink_info_version_type dl_ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
+		struct pds_core_fw_component_info *info = &list_info->info[i];
+		u16 flags = le16_to_cpu(info->flags);
+
+		snprintf(buf, sizeof(buf), "fw.%s", info->name);
+		if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
+			dl_ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
+
+		if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED)
+			err = devlink_info_version_fixed_put(req, buf,
+							     info->version);
+		else if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING)
+			err = devlink_info_version_running_put_ext(req, buf,
+								   info->version, dl_ver_type);
+		else
+			err = devlink_info_version_stored_put_ext(req, buf,
+								  info->version, dl_ver_type);
+
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
@@ -132,11 +179,27 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
-	err = devlink_info_version_running_put(req,
-					       DEVLINK_INFO_VERSION_GENERIC_FW,
-					       pdsc->dev_info.fw_version);
-	if (err)
+	return devlink_info_version_running_put(req,
+						DEVLINK_INFO_VERSION_GENERIC_FW,
+						pdsc->dev_info.fw_version);
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
 		return err;
+	}
 
 	snprintf(buf, sizeof(buf), "0x%x", pdsc->dev_info.asic_type);
 	err = devlink_info_version_fixed_put(req,

-- 
2.43.0


