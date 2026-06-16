Return-Path: <netdev+bounces-299718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cGwzCU23MGoxWgUAu9opvQ
	(envelope-from <netdev+bounces-299718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:39:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678C68B832
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=LC6SvFjT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8991E312AB48
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5A3C0A05;
	Tue, 16 Jun 2026 02:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5053C1090
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577384; cv=fail; b=tG0PT2Ai0zyUAAGZJTj8mCgF3lI/lEVhLSoRoHySFG9otsxTeY5hctaC7Yt5fSR9EISXWfdVYWdx56AGBsUT/svqgB8s8J1a4tDW+a7U7DbLBb4/zNKm/XcqLhhrRR5QzLwmf6AoV5Lud5D1KsBE0rzQsjK0dom9I/iQ4xZYumM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577384; c=relaxed/simple;
	bh=w2I1molMWkbcjeidl2UxxQD8MD1gWw2ZcgNNdF4jlKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEQE0UIKkWBBMynui8nl541Ywqu0QZgfjT48H0yMJgkgQsmcPCWvWEK4Ou69Jx1ZHwNxRg/x79p3C5saSK6VuuIssP445ucQIyqiypvqfVHM59oSiBUzBDU6lWNNXceIT9LoxluHoKN76HdyuY3X+1icXJen6q2sp3UHJvfa8cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LC6SvFjT; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcdRe0nmgT/jLktjtkBtS0/ilthbHG2q7FsP4MyhlDc+2FfnXA/vSu2DujR0IDZdT0+B5kvNOlDuAL95C6srVRwyv5MtMfC2pFye93QCAtvk5pyCSrw8PvYWU7WEJjGr/6mfbEp6EiWKmthFGl99Iu4gwJnorVgUD4XciipxzevwUg9bvnDgJQPgyPu6310Wmam7SyhrSUeoOVG0Zmz4iQmCivSROg6Tdm/j7Hwxe5Fs9f9wlHO+B9CEhucHfknNyJ6HBaYXxth/YZHwkhQ5ziCfne6PU/yj7HskodTtCDP2NOnV5Z3rVAFMBIEN1n7d6XP+HTa8ScQbtfG2Nmfy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=Yx/DKNDdfSFFNt0KBBajBDE2CjDpHxdH7mhQ3Zrq/6egI1U/UAtM69FgD0zOLGSR9asFHNwFXG7vYLyRBFYXV4r5ebSu+PdpIg3EXEJxECcqYR0Uk8ZjzaRxqRNU6d8DdpeDmu71rvnsFKPW5JNx8zwp8hoMdUw6ImqYi6XHLH8bL/tzbec7kqF5RZ6GDhYwWyQirNoLtjrrGQO7Tqk6azTwRb4dQNo/MSR4KydClz7288UqjNwbKOnXpyGldHZgD6f6N5a0Y//pSGM69XTJbFX8qsP5q9OhB1aCLO4xMy3XQP6gdBtTOxYqwXG/q6rBv3S+ZGq2kzGUNKzrX3Nw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++4A3REZ2cVr1wb2thlIhu574/VDTyFCg6Sc9JOdb8=;
 b=LC6SvFjTFIlcGRXd6day1JUgg4D2M5R4NFAZzU99S7MJL93hJH5MKKIkBCjzzpGeyFQa9iB1SmaUHhMvJZHsANdfPztcmWuyo1sxDBPeT+iDpW8/2HAYtaOwgCCWoQO68WX4oNQBLCFbzZDwlW2dBoL2X85gmqbvfDFVDjll8tI=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:17 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::31) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.16 via Frontend Transport; Tue,
 16 Jun 2026 02:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:17 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH net-next v5 2/6] pds_core: add support for identity version 2
Date: Tue, 16 Jun 2026 02:35:50 +0000
Message-ID: <20260616023554.258764-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616023554.258764-1-nikhil.rao@amd.com>
References: <20260616023554.258764-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: e22e293e-8c01-41e8-9cc5-08decb500b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EbPmVq1zPhMYu6tqgp67Z6o/NRQ6Kz4IJFMWUUQwbFxXCiCv7KtmHVYYfXuwNll1NRmbMYieyrVdnpBQe+MvQNObphqfn3tMhZ1BVHIRJHN1AQ6GFcLCmcHaJISB43Q1/u/Y5k7ZDlBor2vSvrIrRRaXGSK25zgn/rrzjB+/2PilVHcpD55kbRJBSg6MjZwRfVJAaKs3mhr3XUzDRayNQAWvhsPbGKYz9LyKLzO1Lzi2bWEo72D5ljodTuWE37MnDT3RLQYlAaRYSbugr2h0R1G8pT40oEUMg7dldgpr92uOSucomAIvFuWbaq0qjvU+NSIkhV933BHFcOKqWRalUkSVPPgPNU9yNuzfnaLaem9EuPvJ/bx/lAMWrqtukr8XidYXev/tZF0Ul9sKjYY0+ESfPNG71DZZBgEWRkYDIyqKarbo08jdaPqFxM6hjUe5nfc0BfNJhcvd9coShbPN6+bd0LV2PF2ay+8jwfBVAvY6qRafM6EsBMxCBTCU3XhI/4R36CqeNBzL1c8NVfPLCqi/YYwKCjKYAvkGAc0PBgpQW5faEGTvvqhskGPx8KbFm54EhwWqUyvWPawOE4n/7OWOw3A9QPwZoRoytabxa6a2qa97rNfrXBa1ZtaUyD7TkcUp3vYUBfatkljUCvEsJuY7CYz2gEM6ilDvKTnsNAZ4123r8QFPMGOZ91+xbuIpMCJBQdko3oiUkPA52v64u0iVLA17KEjzNkW5yrUTKOc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XjxYdjtgErYZhlxtIAPmBn+tgIcQQsaJ/SMXVuKigVk1T+eEYRhMs7fO2KprGvZmgACgzodmHtKVR+hTfnci8R/bNuaezZPjv1LYs4t1ge6ZTVPevPz6KFZKHW106MrlzVbl/5ceX5csPav23NpNg6CkWCBlNlGqONEY4rEfq7uVKLaAYbFI9lxJWnHZkDh9ACu/Gcuu1hv9wPDW62EsSMdAFzAtbdiTtQjZwQxZ1YyCVdTi40IZ1sluNsOw+8hyAfH+Y+36XC6r5XWNw1Aq7LolYUIHGm+9ucHyQ59AhQRsfm1BKyzwrCHJPZpbuw0o3cxuuqJV2CMucEYKV5TtS68so5/E4eaOTzY9Q1KT2nKOAl09lYBqwQY/o0Xa0RxGK2LXdUIXX/zEm6gUAO9ONsGqBh5/DAXU2Gk3gKH/tAg+JGCesTWDk40BHmztovnx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:17.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e293e-8c01-41e8-9cc5-08decb500b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299718-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7678C68B832

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
 drivers/net/ethernet/amd/pds_core/dev.c | 39 ++++++++++++++++++++-----
 include/linux/pds/pds_core_if.h         |  4 +++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index dd9989cfe6b3..5c0ca3d0b000 100644
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
 
@@ -334,6 +344,21 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTITY_VERSION_1
+	 * instead of returning the max supported identity version, so retry if
+	 * firmware doesn't support PDS_CORE_IDENTITY_VERSION_2
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


