Return-Path: <netdev+bounces-305994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7EeiMjLATmrTTQIAu9opvQ
	(envelope-from <netdev+bounces-305994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BC72A833
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="IdEG/lOe";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305994-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305994-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C84B7304DB93
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809BC3C4176;
	Wed,  8 Jul 2026 21:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9B3E5A07
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545802; cv=fail; b=NIPyqreZaGwsjF6wShwwmsGRjs4yF5UFoJz456klkbcjOHEIW/JOvK+ESMjOQec1hmYYieIGtXqj90kqi5lhCQNtIkSO51Rhqp6epaQbcaxfpQ0J6nlyp82Jk/g1M5qZOR/Mjn1GxrYKyGI/QQCBU6O3boZbU8KFwz8BOzlnGSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545802; c=relaxed/simple;
	bh=mF3F9hfaaVwtpv60X3aVyBHhw95/OsVjp2Pdbg80Z04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atzL1Phgh5i5rV39RLwt5YiPlJGyg5SUBO+FRWIVOO37sPlqgGa2u3fpdjFgXLIohis0skXaUMwxGNJgw5ZfequaFP7QfbnqsiIQ3G/v8sTKE3OJ/pyJX+ZiNCM4FhmyDgd09eBzXUMGFQFdMw+9QfZMy3nAcQMf1bp0tFKddkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdEG/lOe; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzC+SgMvjA3vJvl64Y50jFXz78Y3O0ErGD9km6md4NeG5+GtF7VaIltg+ga8EFkUL3xoJJJRa4q6ua2xyEYfGaSlDTkE0Njcg3W0YvmGCbRfbz1ToGzneVgTnUgPVX6Lys02FKfo+N53YpXqqMDC2xXiKwgzcB2q18lrwm3JuM3kB3ND0FYmQ40r8PqOhQcDcaRZNsAxTln8X/FGjBLClkBA+MlzfGW/Y1LnknMkudlMNbfgtcJQjeI9g5TessCWjIgZTAC3OrbjkKKjfEBJxCAWfLlhKm+zeyXVeOAZicizLtn7BYZRUp+A8CCZQzTv0I3Qx1WFjjZ8dat48uoDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3fpMwvHlMW1fWlkKCmwS7dNJw0v60krqiNpC6r9lmU=;
 b=vD9wfCPL0gjbW7X3iXpdBlC/7yYUzgoxJYKwxBr55Kr18zKh+zKtgxhvpIIqr6Z4gw1pRpS9L1CqJjVnXDIl8rb/bgFMZ1k7+mH9TF7gqnaYA2tDi7MuV1FlWElHQPZkynXy0qqkoKLuaElNB16MjmJ2/sjWlEFfvGILvGj5f9AIHtzlc47R8UuB96eyGyWetqp3bqk1FNT5EqzLK5M5R1aELStp3Uie2/0lb3k6E59eAUmxshmMlDcBIArKvqMjwZFv9q/uMXtyN6NMiXXQvgIo5A1FBrybDG7eYLUf+Qd62bo0/a3VLOzxEDZF2ItWaEGTEHYqNg9LMZofsAsU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3fpMwvHlMW1fWlkKCmwS7dNJw0v60krqiNpC6r9lmU=;
 b=IdEG/lOeYADBaR/ChT6AI1o/ASSWOntI9S4vNcUg42apzHtt+70lfIrJho7rA1Yd5JXV6hwLTTgOdpsZ3h4xkGtMiLSu4d9QzN+VCz5GUeYJFhr1v5uuDroYpPPzM46D6PaLchLLnXoyPjpW9whIELslSQh3HZ9eWUW1cAN+fws=
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 21:23:17 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::32) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:17 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:15 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH 2/6] pds_core: add support for identity version 2
Date: Wed, 8 Jul 2026 21:22:18 +0000
Message-ID: <20260708212222.296202-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708212222.296202-1-nikhil.rao@amd.com>
References: <20260708212222.296202-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b2b137-1eb8-46dd-5f24-08dedd372089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1O11abYwxHrvUzEHkANmBF9q/siZHKU3wcPTlWFD0txiR2LrMxpxIHOIhLCvyNkI3kDNIiUfcEPuHdw9XO2Vz+ZINWj6MWQTY/zOPHoxQhKrDQNdpgUQe4j4wfVFh2hwNrlaFpclwvcix1jyqT6pnsDSojAmqCvre6StQXIE/JZwq4sBJ1ncRxGP5IE91DPc6nA6wjy27x4vdo4eyZQjd+jlC3LSCRSf1QydzsAqwkoaAHIE89YRgpmRwPepYSPZr/NPT2ws7k0uF5JW1ptCE03YY0ewuu8iSc7KkXdjlGY8bwq0n/+0xMDSYgiNJUs2M8N331Q8SaqusnTMOrtoM9woHX3NYH/6/ipQfcx1wGQcgMmI3KFFp0KieXzyGnEObSj/3tH3jrEr0o/i0bocPd5vpJFgY/jA/vLbMHbndEXlKv99OJRoSrrfi/v3ilIHBvGLnVGDVLSfMfMHPAENlVFtnys8IFuYr2OqV3xlMnaH5cNxS8Wt0DTWlNloSw+7Y3WSfXxD1Q6q1+vcz56bYioa7vGAwenzzJrmAb0oIcTns+/eef+5VgEhHVmrKiBBi7r2W1mMpIrsYi9zIK/kAeHbFlkn5h/1+s4Ozk84jWAKgma/+Bkhioog1novnaUKRbL9ca+SGwWKLONslboef4NU9DxmLJh7X1Lh7WaabgYwPa55TP9kgVMGmfhM4U+enUAFCw486UfJQlNtXygBLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dlss4cZ/b8j+CLVTjeUdwJZafYBq3HdUqm3gbIkVe3FWH3dtdIam/IwUSdrOWv1bByvYtHiOuGQYCMvrcsPAsZTYGLQBNw5OGs/6ypOvihaOWNFPmI7ClLpQouBuccFmPBGFaePUmv81yZLHC4c8qFxhwMViq/PGqtkBaxB5zzb9Ai0busd7Lzy38dQ+Tz9thqxgzCWznvj5z8wrhC/2XLLYf74TJi0JjMH7fXDA6wVeqLpdnZO8N1ZUExl7VvBr0ZKAaykHuDICRMYvwt+5IIGtR+mvG0E6Rx5zfCnFhHk/AzVqLZPcyR6PIU3p+6S7eZmwJcLUQE0NZ2Dqh5TKL7jG/oUqtBp0hmQ6A/dYjK9vJw2WCVTVVoz0QUNdG+fC58A2UGjMjHG2Y6vEgrp/5USoWmqBOCaEnckp+UIUSUz2dXJdWYjw4ptosJWL0zjC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:17.1440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2b137-1eb8-46dd-5f24-08dedd372089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 289BC72A833

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
 drivers/net/ethernet/amd/pds_core/dev.c | 40 ++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 +++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index dd9989cfe6b3..84ea502ecb12 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -250,15 +250,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
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
@@ -281,8 +283,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -305,17 +308,24 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
 		memcpy_fromio(&pdsc->dev_ident, &pdsc->cmd_regs->data, sz);
+
+		/* V1 firmware doesn't set capabilities, so the field may
+		 * contain garbage from the outgoing driver identity.
+		 */
+		if (pdsc->dev_ident.version < PDS_CORE_IDENTITY_VERSION_2)
+			pdsc->dev_ident.capabilities = 0;
 	}
 	mutex_unlock(&pdsc->devcmd_lock);
 
 	if (err) {
-		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
-			ERR_PTR(err));
+		if (do_msg)
+			dev_err(pdsc->dev, "Cannot identify device: %pe\n",
+				ERR_PTR(err));
 		return err;
 	}
 
@@ -334,6 +344,22 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTITY_VERSION_1
+	 * with PDS_RC_EVERSION (-EINVAL), so retry with V1 on version
+	 * rejection. Don't retry on other errors like -ENXIO/-ETIMEDOUT
+	 * which indicate firmware is not running or hung.
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err == -EINVAL)
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


