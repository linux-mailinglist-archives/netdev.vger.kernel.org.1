Return-Path: <netdev+bounces-282276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHDlAv+68Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:02:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F6490E43
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC0E830A0091
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719CA3A7839;
	Wed, 29 Apr 2026 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E78kemrU"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67C3A3E84;
	Wed, 29 Apr 2026 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449506; cv=fail; b=iW5dI8z5K1gDyx6btpTM3xUIL11cUPZoxYn+59S0JqJGszk+E33Kn4BHsBPIBmeR7Z9LW/yeUN956cN3JZPGNvAcec8YD6xN6XdeGFPoau5AUVRJIHZLoBfabt40G9teTdVHe3CkCudIsavZ/ux+kOqLWdFyFUnPYn2fawTgOJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449506; c=relaxed/simple;
	bh=um4WLFVrwDgoU2VKc/3wvQW8Co0Ji4wUOD5AiIMJBuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=P23kvbfYq7UQrtL+Wp8bIXwgGmvrIWnGTtT5TZS1C/J/qf6YuugGkD2QeQzm5OOftDDn8jfVdRqjUlh9NuJKyVx+jI+d5Oyisdjy42c+kiBgihdGe9x8ELg7u+rKYaHrHJ9lj46BkSK0oH2DHRVCw5vCaYM13FNpsntdGyzgess=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E78kemrU; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fijjs0Wiz4ASS3akU/4E6fN9//3m3VBG63QL5HtgEsbqvjmO3hQHgk/wPGjLP4yNxKrQmaIrXWDYRXobqdUNj5loQqeMv3XKHnbqPEXzFCBxIDjB3O7jFtPkJstOZMmupMYWzgco6GvF3NV+Qt6tTDdHpAN9/yvPrvIcXjtnm4itCco9gZw/+apzyld/VqLRQOIqFbIZ6gejBvrovukDrEluNgcQD+UwfXx0mCYWEmy/9xOdZ0VrZMVFUSmk3m80mZKNz4AoPRpSoduTrAKGTuKWcPqQw2OCNf4BarF0Beq4rrGeW+PL5MgJD+i+yRbVPoBQ1qFLh5cMuUt1O/c8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x23hehrKiM8NIyZIMJTH7Ruuujg7b53WQ7E6k8JiXcY=;
 b=DvLXhAfaSWKm7Drq3CCWeKB1TAbdcE2weCjgn1bvqrC74V66XP09n8QHPPiixUS6U1muBFOgl0xgGsriftYwyTACSCUXw2OuW08ZelQTgX7rCilctaWqsp/Ck24+Ry0c5pf06b37mVJ8CKHDbiNg8+UkXGHk7s/qmtj6bWNmo97I1TlxktNXAF11LOe5MDZVM7b0OThT2QU8J/7p+poEyJ+8vqq0orGbsnyjbNkTSGSTLuJ9t6YsutrDVGmbOyUwBnhx3nTahKeD8k3ZAVdR90hGwr/Lthb+2D6nniLGdhLYItC/QIJXBTuknN1pmCpUdMr2tZTVRB/51fQ3oRRDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x23hehrKiM8NIyZIMJTH7Ruuujg7b53WQ7E6k8JiXcY=;
 b=E78kemrUiawuC/RggN2YmkGx4oX0I0k/x99Aq+JCszk9wDbIfV1RrbGzOwV3RqluIhahxPDdkkwcCXO065ndPVNBApo1sD78Xx1gwtvjRRaRr0SCpjZME8rOi+WYBu6qQiRc8fr6IZPR/5u/E0FOsVm9vv2mFbizraVuLKaLgUc=
Received: from BN9PR03CA0279.namprd03.prod.outlook.com (2603:10b6:408:f5::14)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 07:58:21 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::24) by BN9PR03CA0279.outlook.office365.com
 (2603:10b6:408:f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:19 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Apr 2026 07:58:08 +0000
Subject: [PATCH 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260429-b4-pldm-b4-v1-4-e43b6c92e46c@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b43de0-1ad2-4a93-f166-08dea5c514db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RoYg95Ox2B1pJaA7szesohnor++O1thh2fP9X6/DmwCQIPgWdIqNdQK7serDjjIiJWAxC6dmzwPA2KT85oeRXEWe3JDoInoiyTFFM42C/WF9jx4sj+v4Ri7unFUUalzH2Tp/CBgZT/LdOhumipx9Qm8RFdql3FsdojLALUkYug+1OZHsTIXO7zV6hO+ly2jKtAN+O+j4uxnK1VGp33/ljEUF8FGeB/E3eN7DlvnxcDkQG4Y6/A7fyhL+Qm9eZnRkJEqKrm08tOlfFg+t+8ugFSvvFWpO43SJ+OzLFM8ozxW7q7XT2O5mvdTSR9T1TH45E0tTo67jSoYTd95gXXF6mhekvayg4yhDfxsGkOOkXcSoDm13NIoeAPVpBjxVzQ4t8W4Yz9Xuv/q5n1uVcVe0Et1m9uhWKzYZkHyvyQOCvzP/1FtFSLnrT9wKVJIoitkouYNv0+368cDUBB3w2FNxTQd7K05DAdClUPupi9pw2LfhQuzXK0i4llHfeZ3dxaDr9t+BwBSH7013Mv9kIRXeZywgDBVQRrC5vU1ITflEstkt2Ew06KLbTv/QAE582BUCeTIbAgM6usgeU5sTl4tLPQ8uf0sqQwWi1A4DmHAshUMWif5u8wVLKWECTxCOi6Yc/fQjdaBKVtUwOGRn4GQuhAR/pkntOgjKsZtfOSWjtuJ7dqFkGkThypWDl1sWZYIDh4a9Gbp2qZX4gGSnwMCkQtzqp0eW4dhC02F7ma/C3ucrJSzj11P+Utv31bxaZcsEB7+5xlgbSW9mL/i1WQ7FCg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lVo49bkU5XjOvk12tyKVONJjyaHLGfAMFpDC+0eifPkXDNYF77XKwp1XRsSLLEBzFSQzYC1wtinfLXPYqQRZ7WZXKxqFR135AO9MShNVqrrXEjf0YCNCWcW+KYBoZYDmGrk6Bv24pm6L/DulBduFcclB8xLXmgCHvpT6FaSB9qqdhEJgaHpBL0TIBgVS3KZuEOh8MuwATKjEGI/Uc+P6FbFywt+6j2zwwVjlHo9tPXgDPmKUDgNOuEzTUFf0DQewAvXT196IEG1Z1Yj43mfpXSw/EMOkIhCy/N//J+3FrHx12Yhdp1mVS+7PCFYWxKv5XY9fyvtxQXGHiGuTJCZydfmiZMyPoZLGnVb8f412IEzDgfustoPyLKsImBbhVcKOWdDlYPBuyBbXv1ZjzBHAPCd3+GDYMcEHmFCqSsx2QotCAMsw/H/+T7bMxNYxKlMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:20.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b43de0-1ad2-4a93-f166-08dea5c514db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
X-Rspamd-Queue-Id: 6C8F6490E43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282276-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
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


