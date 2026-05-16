Return-Path: <netdev+bounces-288558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK0eEEbaB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:45:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ADF559F09
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5474B302AC37
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9C29E117;
	Sat, 16 May 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ujk+YEF4"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2125B08F;
	Sat, 16 May 2026 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899461; cv=fail; b=klSXIRteTeccmr0iO2s/EZRzfURnyFCfH6NZIg/mPStG6aR2+HYA7+mFGWSOKorwmyVzDiFlKbNTorMIPHeqrf6VaqzkqgfvZaB35ldezrVsyebuYheh9oJjw3ZCjguuM3dFTZ7098Zquqpnvm6RR/lavjgNzasZloE0neFDkms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899461; c=relaxed/simple;
	bh=+3Tbwb/X6gGrT+4jR9t567b8UGsWhUaDO5baIS2V5AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X1xsUO5y+JuyQSimYmT7sHVwoq0tduVQm4DrijW9NV/WISardSU0CFmLv6fLKiuenzRC7jDpvT2XLlj5meKH1xQv2Pl3Y3ILWYSPOD5pp9n9zkJaVTFK8iUINcZBODugY/DRmQT3Ss5kfJTkpTlfby/2XiokfRyys40uoqxL3zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ujk+YEF4; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYyD/pZDW3RfuobgvjBz1m6eCShnZ3bC4eg9cXjQ85MW0Wd1Xe7pyM6TmThuWV6vtDy82NS0KTJsI8UG2WDl6JaoXUZTl0j/DQQelnUNJtIhtSynnki96pNnG7y1fymuypOYJ6CQDG1Ywwy4GocuFG0e3kC7AhY4WAmQLyeLciCLFzBzQEJaekRpXkcNwV7IGgBANdpqIr3lSB1r/eTpjrvflZxR74B6Z09l7WLIeTam/SDATUqGp7UE+bivifr12ey3EKJpqQ1Zv7TUkTQ1bQ8cQbOBl96DP77xZjE5nsmtmPbTe5ylILCGAIjgGczEFAczqPyRppwNoXIL94Khgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZooS1qxE8RBgDYLhkkmZtnGHEoXFHVjM2TCZ428c8vU=;
 b=gHb/YAD0/+WgVevBE28bLK+g+QpeSNXXK9LWGv6jppEMnfwcYL3Tgo3a8kE19xc7fknR3gmL0u2KlzqRF9MnAk2mz6GiJSrzsA0JJhY9GDlG5GF2fCOHX8fzlVlRh+wDtynfMUPADeMZ6rGZ6uC+TYUB56jnbmvAzDb0jJZ3+obvIMd4qypwcaEr58gmADKt0KRoVd24Etfm0IBFkkiotoG7zR722KCJD8BDt0iZMHrbwp9rgCj+xrmaRr1XJvwnsils6RZTPCb0yY1NyH/mtsSzor0OYNCXxGfoFSTN3WVuBf8iyszYMFl28Jijzod/4bQKSh+HN51lVfDdnSHfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZooS1qxE8RBgDYLhkkmZtnGHEoXFHVjM2TCZ428c8vU=;
 b=Ujk+YEF47XvmzMVGB4R3qa7GnYcMeecP0WHl4GSaGYTN3Wg20nXcvROuhivD6DVIDU1sZ6fFVXmcyJPa1EIVuHzPEyT0QThJztYiJZQ8yjxWDLWUXI4v870n1+QPQ73OlHga0wJ8MBKX9XVfTgeQSdjwfKNh6pjeXt25RoM8KDg=
Received: from BN9PR03CA0214.namprd03.prod.outlook.com (2603:10b6:408:f8::9)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sat, 16 May
 2026 02:44:15 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::4) by BN9PR03CA0214.outlook.office365.com
 (2603:10b6:408:f8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:12 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 16 May 2026 02:42:36 +0000
Subject: [PATCH net-next v2 2/6] pds_core: add support for identity version
 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260516-upstream_v2_clean-v2-2-7e0d66bf4020@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 131380ed-1782-41d2-74e8-08deb2f50493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	IyjPVNeOD7h4LSrUDk/VzeoD7y3aYB7yIfJXP5wXKk/QK8zZOWjYFmPy68MhmNMCF59p7dQRAY04qtnhYWnxooQPbYnPsdlESlUYQqx2ifergyIXA9CGVfW1Zi+E4MCKJ54Gf/tMKOsBmoIuBNbBLdSAuccj1cQmgN5hAKOjhRJ6avjr/3BP43OaRUjZ8J5LGhio3yLr/+XxzXu+EQd/KNdU1dLOHgb8P/rqVftae+dWihURCqB8GSdvRBpQ0dRgbA4x8I/ZK4Mr5io6kVVjRjoH5SoPqb3rWOptaHJQ1dMAbJqs6F7gQNoM18U/K51BTZhR3AmPJVPjcxTZUoXFH8ChholLVFPiiSZHbx/ezayrtTthWbE58Y774l904hg5CABvxBcixkWpc4iwuGcES/J8jTCNVsIUsCFsJLvAnslNgocX97MQOcGKEWxH4H9FAm8wflXtVpYOr3Ktz2CtZlbRhpCPxGX/j7mUoPyYFp6Ae8y997R+QbdkZhbR2EBr5fnoVEh3wjEwCPnF64A+C4rSZDP2fMzB4ux98QOAQqGQpn8r74IOBngdtJcHkX5EPlN+mTfclChqza3hnPxHb+EhSY802ejesObB9BiAdCsNmH5COhRwzqKB910YUwmc9vgVf5cKi7stWARhr1TeuE2i1hZWcKC8fqUgTzaN7MupOFAn+jLQXKhmJhoImA6m0xmABCXbmM+DROEyllEYvvrR5OittbFnL3HoTa3MTnE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kN23ZH6mknXpJwFH7WDbjUciTjdvELRsjEE3dDfai10TbGFpxijQYbBZXQiD0l24jG6Sbz5i2HyY+n2e5k0RoqAzSmJEKOZ4jreZUilMTWzCiltyYEtNsyU7An5GSo4zJETrEi/nl2aYMuYHSYTHQI7IGhaMtAEwZRBrhO11RA7BFQHRBKq/8D2K1AK3rRa/Nx4ZkEyUuQ4fj6q1CqHE8OK5iZsWHY2qYNRF/GbhFnxR7mp9Q6wUpX0Sk8nmCdjq5g9DkKkUpGWgpz6OgRgYitY/WMH6qcg2S44hxfbydb+UiZlIS/Xs79XlkuReS6d5hbhEgkAt1vyk2jgLklGHWBUTGi+aAOfLFliZgremnzRIVIANMYSVv1G3qJHXcFtV+gU3UhRNkI8/uQchFzg+Het9cEds9pOq2SzVPUPy3wMkJRcZpOAC8kuO5SsKM5hG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:14.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131380ed-1782-41d2-74e8-08deb2f50493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
X-Rspamd-Queue-Id: B1ADF559F09
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
	TAGGED_FROM(0.00)[bounces-288558-lists,netdev=lfdr.de];
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

Add a new capabilities field in struct pds_core_dev_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 36 ++++++++++++++++++++++++++-------
 include/linux/pds/pds_core_if.h         |  4 ++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 5b86d6cd0ac3..c9abea9b2eb1 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -243,15 +243,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-static int pdsc_devcmd_identify_locked(struct pdsc *pdsc)
+static int pdsc_devcmd_identify_locked(struct pdsc *pdsc, u8 drv_ident_ver,
+				       bool do_msg)
 {
 	union pds_core_dev_comp comp = {};
 	union pds_core_dev_cmd cmd = {
 		.identify.opcode = PDS_CORE_CMD_IDENTIFY,
-		.identify.ver = PDS_CORE_IDENTITY_VERSION_1,
+		.identify.ver = drv_ident_ver,
 	};
 
-	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	return __pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout,
+				    do_msg);
 }
 
 static void pdsc_init_devinfo(struct pdsc *pdsc)
@@ -274,8 +276,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -295,10 +298,13 @@ static int pdsc_identify(struct pdsc *pdsc)
 	 */
 	mutex_lock(&pdsc->devcmd_lock);
 
+	/* Zero data region so fields not set by older firmware read as zero */
+	memset_io(&pdsc->cmd_regs->data, 0, sizeof(pdsc->cmd_regs->data));
+
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
@@ -307,8 +313,9 @@ static int pdsc_identify(struct pdsc *pdsc)
 	mutex_unlock(&pdsc->devcmd_lock);
 
 	if (err) {
-		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
-			ERR_PTR(err));
+		if (do_msg)
+			dev_err(pdsc->dev, "Cannot identify device: %pe\n",
+				ERR_PTR(err));
 		return err;
 	}
 
@@ -327,6 +334,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTIFY_VERSION_1
+	 * instead of returning the max supported identify version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTIFY_VERSION_2
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err)
+		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
+
+	return err;
+}
+
 void pdsc_dev_uninit(struct pdsc *pdsc)
 {
 	if (pdsc->intr_info) {
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..619186f26b5b 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -119,6 +119,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @capabilities:     Device capabilities
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
 struct pds_core_dev_identity {
 	u8     version;
@@ -131,9 +133,11 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le64 capabilities;
 };
 
 #define PDS_CORE_IDENTITY_VERSION_1	1
+#define PDS_CORE_IDENTITY_VERSION_2	2
 
 /**
  * struct pds_core_dev_identify_cmd - Driver/device identify command

-- 
2.43.0


