Return-Path: <netdev+bounces-288561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC3YLObaB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:48:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3720559F36
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF82B30469B3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335732868A7;
	Sat, 16 May 2026 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FcGygvI"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8B405C4F;
	Sat, 16 May 2026 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899470; cv=fail; b=O6TFSfQQgisu1JH2bGImgItKweeOoBpobfmuxIRyXe1Rj/qeTEeew6bNkN1FZyrk5fVTYOOMzm/pSc8sg7RtG/Y90vie/4KUAdfMZz8h7PEEo8RhP9GsnPGFtjgeSQVTOqH4MgfDbSmFFtB5FjXVQWJ8RnAhGv7YgNLLIXwVob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899470; c=relaxed/simple;
	bh=OnTSwt+5vw1MudooUzOkqEnQKQRc5/k7KxNLlAnpPvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=orSKk3iZBvpD+W8QmK07K1YfZIQEcqhCMXDPrb44IRyMhLzq9RgI20fFY+tD30mj1QpgJ6FP6qkqPKonVC5yaHFXRq2PZre6u5G76fP+43Bw44H2PpoIBhmJjKTxx03DjdYUpHxj9y2jBiuQJHWkV/QvU7BzDBVcclwaHEbsMqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FcGygvI; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Y9mb/vWGkBbwmwF+DA5AKUVqmJwsA3xljsVmYJLqa+X5t6C9JOqCO+LLIcx6HonhrjcBnu6TS6H89ZVhCQTI9ELQOY9QefVEsbb2VqMR8XnE11mrcptFeClfTpD8zf0gZHDs0QrUULOV4Gr/C0FxV6QXIEoKDgkuAlTULqGyDFNuDoyPFdZLIHatoAajia97nxHKbRmiLTnOTYX+wmhEfa+zm2Aqrs4pKGfT/ZgkVNhR6vT5bcd4mCvAkKWcWqOQMMkeDKI2GblT/tvCjASUbv89XxvuvJVkAvElRk3yrv+hgkiYoufc0Y4EGuaZ7lXVvyQ4G8b3Iun7FK/77HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egwBuiTM08UEXr5JDY+40aWMB5zrXLJYdFVro2g3vKE=;
 b=KGyZFRUpQsQKTMwXB4ME6kQjQjsHemqgnkak28dLpoWzpsJS/OtLAhEWMYPMshBntBuBKCaIYGaQQLm0GOwYszI/3wiDyc8nNc/pe1V4vpod2N+Wn3NQjT+TZBYoDxbwwMopzXbh+qQQAGpcjetIjEt7wTCQTAubC8t1BAUAoErM1WFmA2WSlrvI8rEo3/mKfh0dYqwEIFf2GdXxsG7GnfVc+zIS8hVGK4bXyqh8U7PJf9wiovGw36eiCB+R6E8IFHhZKbJW3pzHUCRUJWUyxTptYtQt6yZPD7uBR2q6Ln6eysKU/eEIBjiYhkqDsyc79LfaB3wh1vq083MMVUyjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egwBuiTM08UEXr5JDY+40aWMB5zrXLJYdFVro2g3vKE=;
 b=1FcGygvIqmDAU+nYgJYj+FEUmWDEragNPMPHQH0Ep991AalLz8HeEM17Udx7CoAoSpreMo9TuvaLuJLv26e3gPV1hFfWuYb+lTFTmh7cagLr5C3U5p1+C1JJYiE6zJiw3jMl1X5PH/BYF/mMr9IMLeu3wk65qjPS6/EQiPHsBH4=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 16 May
 2026 02:44:15 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::aa) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:13 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 16 May 2026 02:42:37 +0000
Subject: [PATCH net-next v2 3/6] pds_core: add PLDM firmware update support
 via devlink flash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260516-upstream_v2_clean-v2-3-7e0d66bf4020@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e03c8ee-37b9-4f0c-bee1-08deb2f50510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|3023799003|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	KE9HtUwxPFvsciNxYltfjKHxgPD9r0lo8j1Cnqm1d0XPQRGZf/ZUZkGEv9lg8L9BkRTp/7rS/8d6TXQPjzJ0fjLWfRVB9ZqRgnHxDvLEm+TboStwXxigW+QPskx6qzCvqamNDW1Ym9z9QjhgKgEcdbitB3VGsX+R241f2FynQLUVszjCr57V8Qm1TxHsqb7w1EGaLA6Sfb46CzuSRmNrZt+mh+wiJFWYRiXQw0tDWJ0ufCwV7rKX+9fY2E8Pd0YoC9EBoBYrHd+0/OscMR0k69LS1VBVOZEx3n0w7rTi1SUWeGyvQnXTR+JF2GnvlSLP8H04fVhgOgYYyeryrrzxw84kny6yn3WzFAk0BH67ouNyNRkTMq11aFoDncZ153zzphKVftQASDaL34VyRkzBMt1HcwDyLYgWNr3BbGFBHET+K7+kzKuS1Qz0feNJqnIbaD8BcEK8gjeq3Dn/PpJsiC3KU24omlpXyEy3jUqRvYSxYk/jvAwTK4vJ8CWG6JDBOkKWJana0ZPv/AN4lHkDUEkuDfoxHpDClAFWTGm+fO8V/DgbRDnMaC8ouCVPn2VWcDPXKwj4bEdO4LP0MJqUC7FwjI/tChb5Nzuxbz+9W96Hiw2osj/AF7+0spB4vf3UYQWKUA9lU4thkyNhzMjMVdrdZ0YExgCusKtUXXsP5w9V6zTMVCsQkA6djoz/dTe1uhJa8JQzG4Cc8YIqp21Bvs7P4JBaVhvb/eZU3Pn1f28=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(3023799003)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gRXzO5t53yfeHBzZItDgnS+R5QLc5SAZrvfSPwtv5zmilEjUGo4xU+v9F6jRruJwo8uUeAK6BF0oLwJzcco4XCEqiuH5pq8gFzTvTTef2MT9Wvmmn2AQchwt630tsxAm9wwDNEFcG5CMvKzXlpgIWF5pu4tBIGWvYRNQUaFj9B6yS4V0OU6gRe5uT58vHUQKCpOyJFym6QqbacOfP5oH22mD+vRYh+bxQ1puUVtgvMqy9M22zL69bHTowPC71TWr+6alYo+6z0ZbsD54xaEl3fjdcytCHvD75kATF/o45FFIXb7AywO4dScHcCtYGcETdIw4SMtq/6pxgpRcb9C60j4Y26G4zOJEC0k0l/vxdkaENdUOeA+N5imTcxbLTS9Qj4N9/vZGOHiTWK02lX4c4d0cVkI8ZSj36rvHM56rAZ6Cv3BvmSbk4GJaGsX+Mdgk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:15.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e03c8ee-37b9-4f0c-bee1-08deb2f50510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Rspamd-Queue-Id: E3720559F36
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
	TAGGED_FROM(0.00)[bounces-288561-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,context.dev:url];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
 drivers/net/ethernet/amd/pds_core/dev.c     |  40 ++
 drivers/net/ethernet/amd/pds_core/devlink.c |   2 +-
 drivers/net/ethernet/amd/pds_core/fw.c      | 727 +++++++++++++++++++++++++++-
 include/linux/pds/pds_core_if.h             | 373 ++++++++++++++
 6 files changed, 1152 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index e35991141a1a..743e3d4b6b94 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -171,6 +171,7 @@ config PDS_CORE
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
index c9abea9b2eb1..bb8c01a131ee 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
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
index fa626719e68d..f091a753bce9 100644
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
@@ -195,3 +203,716 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
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
+			dev_err(pdsc->dev,
+				"match_record_desc failed type: 0x%04x size: %u, err %d\n",
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
+static int pdsc_send_package_data(struct pldmfw *context, const u8 *data,
+				  u16 length)
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
+		if (dma_mapping_error(dev, dma_addr)) {
+			dev_err(dev,
+				"Failed to dma_map package_data at offset 0x%x copy_sz 0x%x\n",
+				offset, copy_sz);
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = pdsc_devcmd_send_package_data(pdsc, dma_addr, copy_sz,
+						    offset, length);
+		if (err)
+			dev_err(dev,
+				"send_package_data failed offset 0x%x addr 0x%llx len 0x%x: %pe\n",
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
+	dev_dbg(dev,
+		"component name %s classification %u id %u activation_method %u ver_len %d ver_str %.*s index %u size %u transfer_flag 0x%02x\n",
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
+		if (slot_id == PDS_CORE_FW_SLOT_MAX) {
+			err = -ENOENT;
+			goto free_component_priv;
+		}
+
+		if (component->identifier > U8_MAX ||
+		    !pdsc_match_component_name_to_ids(pdsc,
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
+	tbl_sz = struct_size(component_tbl, version_str,
+			     component->version_len);
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
+	component_tbl->comparison_stamp =
+		cpu_to_le32(component->comparison_stamp);
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
+	    comp.send_component_tbl.response_code ==
+		PDS_CORE_COMPONENT_PREREQS_NOT_MET)
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
+	dma_addr = dma_map_single(pdsc->dev, list_info, PDS_PAGE_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(pdsc->dev, dma_addr)) {
+		dev_err(pdsc->dev,
+			"Failed to dma_map component_list_info length %d\n",
+			PDS_PAGE_SIZE);
+		err = -ENOMEM;
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
+		dev_warn(pdsc->dev,
+			 "Incompatible get_component_info version %u reported by firmware\n",
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
+		 * EAGAIN while the command is still running,
+		 * else we get the final command status.
+		 */
+		cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
+		msleep(20);
+	} while (time_before(jiffies, end_time));
+
+	if (err == -EAGAIN || err == -ETIMEDOUT)
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
+		u16 id = component->identifier;
+
+		component_name = pdsc_get_component_priv_name(priv, id);
+		slot_id = PDS_CORE_FW_SLOT_INVALID;
+	}
+
+	total_len = component->component_size;
+	dev_dbg(dev,
+		"component name %s class %u id %u act_meth %u ver_str %.*s index %u size %u\n",
+		component_name, component->classification,
+		component->identifier, component->activation_method,
+		component->version_len, component->version_string,
+		component->index, component->component_size);
+
+	buf_sz = sizeof(pdsc->cmd_regs->data);
+	info_sz = struct_size(component_info, version_str,
+			      component->version_len);
+	if (info_sz > buf_sz) {
+		dev_err(dev, "component_info size %d too big, max size: %d\n",
+			info_sz, buf_sz);
+		return -ENOSPC;
+	}
+	component_info = vzalloc(info_sz);
+	if (!component_info)
+		return -ENOMEM;
+
+	component_info->comparison_stamp =
+		cpu_to_le32(component->comparison_stamp);
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
+		copy_sz = min_t(unsigned int, PDS_PAGE_SIZE,
+				total_len - offset);
+		component_data = kmemdup(component->component_data + offset,
+					 copy_sz, GFP_KERNEL);
+		if (!component_data) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		dma_addr = dma_map_single(dev, component_data, copy_sz,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(pdsc->dev, dma_addr)) {
+			dev_err(dev,
+				"Failed to dma_map component_data at offset 0x%x copy_sz 0x%x\n",
+				offset, copy_sz);
+			err = -ENOMEM;
+			kfree(component_data);
+			goto err_out;
+		}
+
+		err = pdsc_devcmd_send_component(pdsc, component_info, info_sz,
+						 dma_addr, copy_sz, offset,
+						 slot_id, &comp);
+		dma_unmap_single(dev, dma_addr, copy_sz, DMA_TO_DEVICE);
+		kfree(component_data);
+		if (err && err != -EAGAIN && err != -ETIMEDOUT &&
+		    comp.send_component.compat_response &&
+		    (comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_IDENTICAL ||
+		     comp.send_component.compat_response_code ==
+		     PDS_CORE_COMPONENT_STAMP_LOWER)) {
+			err = 0;
+			devlink_flash_update_status_notify(dl, "Skipped",
+							   component_name,
+							   0, 0);
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
+	vfree(component_info);
+	return 0;
+
+err_out:
+	devlink_flash_update_status_notify(dl,
+					   "Erasing/Flashing Component Failed",
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
+	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
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
+	if (!pdsc->fw_components.num_components) {
+		err = pdsc_get_component_info(pdsc);
+		if (err) {
+			dev_err(pdsc->dev,
+				"Failed to get component info: %pe\n",
+				ERR_PTR(err));
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
+	/* Invalidate cached component info so next info_get refreshes */
+	pdsc->fw_components.num_components = 0;
+
+	return err;
+}
+
+int pdsc_firmware_update(struct pdsc *pdsc,
+			 struct devlink_flash_update_params *params,
+			 struct netlink_ext_ack *extack)
+{
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
+	    pdsc->dev_ident.capabilities &
+		cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
+		return pdsc_pldm_firmware_update(pdsc, params, extack,
+						 params->fw);
+
+	return pdsc_legacy_firmware_update(pdsc, params->fw, extack);
+}
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 619186f26b5b..d15ddd1c8ef1 100644
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
@@ -450,6 +469,346 @@ struct pds_core_vf_ctrl_comp {
 	u8	status;
 };
 
+/**
+ * struct pds_core_send_pkg_data_cmd - Send package data command
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
+ * struct pds_core_send_component_tbl_cmd - Send component table command
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
+ * struct pds_core_send_component_tbl_comp - Send component table completion
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
+ * struct pds_core_send_component_cmd - Send component command
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
+ * struct pds_core_send_component_comp - Send component completion
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
+ * enum pds_core_component_info_flags - Component info flags
+ * @PDS_CORE_FW_COMPONENT_INFO_F_RUNNING: Component is currently running
+ * @PDS_CORE_FW_COMPONENT_INFO_F_STARTUP: Component version on next FW boot
+ * @PDS_CORE_FW_COMPONENT_INFO_F_FIXED: Component is fixed and cannot be updated
+ * @PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME: Component can be updated
+ *	by name
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
+#define PDS_CORE_FW_COMPONENT_LIST_LEN	((PDS_PAGE_SIZE - 8) / \
+		sizeof(struct pds_core_fw_component_info))
+
+/**
+ * struct pds_core_component_list_info - GET_COMPONENT_INFO completion data
+ * @num_components: Number of valid components
+ * @rsvd: Word boundary padding
+ * @info: List of valid components
+ */
+struct pds_core_component_list_info {
+	u8 num_components;
+	u8 rsvd[7];
+	struct pds_core_fw_component_info info[PDS_CORE_FW_COMPONENT_LIST_LEN];
+};
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
@@ -466,6 +825,13 @@ union pds_core_dev_cmd {
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
@@ -484,6 +850,13 @@ union pds_core_dev_comp {
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


