Return-Path: <netdev+bounces-97479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D938CB872
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D11B1C20A63
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54213568A;
	Wed, 22 May 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="o0kttKKw"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3722C9D;
	Wed, 22 May 2024 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341149; cv=fail; b=NcoUNediQn0SvpRIRBRtL+9xg95tiryVoH6KapoCjlxkcLGx84FsnHCFATh13W2eslSAh2Mz7hD7jWIoMxEI7pB92iw/9yQZBnNXOYTUpaHuBVcR/M2fprKUOE8KC1GdbxQQrmGo/EpdLewOX7S14s6PX63QpPkBHsZSuIf/KFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341149; c=relaxed/simple;
	bh=AmI/QH1JDBm0sNSSGC+9czsGdznApzj56hGO+aNzqBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QbGWxP3P297OT3gjsz0eVIJZIPFNNtT6Yss68e6qe1OBWeBfnrT4G39Y7FVxKwBRkd74nwMgORy2DvMH9raa3fg6kAxQqE4QxwV+dNi6uu18OCs5MLwoljw41XtYEtNem2/SMsQYRhfiSAi6IMmDY2EDaGRyHXJZSzbHMHax24E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=o0kttKKw; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAAC6wpHJVX2SxifNvmts57ShaW48tahMOGU9FJ8UynmuVTfG4pAkiW14DpC14jXMR+2VGLOL7glOTla0jXvJPRMhdlL8tyJ89/lGHw78vBntmUsJRGCX9jp/v2GXB6TQlc9/eg/7kS+3GHJ8QfBwLcfkZZpxR9k2QoUue+cN/uPYDF+c8yDFxx+vsYNSta85y1ksan3E0ygO7MLQNnuduIOdQM4Zeb/smBnOK+bgAJQst/J1cu0M7q5h53nwcF4z9PgQy+YXDOgxoe3SxjcOLphG1I+64mMqwa0MwrMkP/MvHPf2MBABfD83n12XfnQSZJxb7VmkqR2/QMhpriljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpR5vcox7qIrfrMuA1GVItiQ1YBg1Rdpf1mQ/akwuZQ=;
 b=k+JP/bHGl+9Ec8CfmijifvNMrKwugdctLdEBACw9HWBDy/tMHrXD8Nnilz/u/+2j4dO4YomD82HGK8qJqKAy3wO+rL/bF1VH+AkKbLQNOEf98M+JTur0GY/dvf88xN3dL26Z4LhRcsdnh7itSlnx1w8sutj/iqb6BDunVu+hQ4iB0jdprmPcYgCV6swSvS+HPHvMTaMtm71/co37wS36pvfdzxHvGM9jOnt7cYpqCt6DLY38tu1mpQLYT8ybwSt8m4eR/m7DKJ+R93vxUbiw0v60qSjO4gMiuTqZWOJn8OIsV3pSy5Gu/LMGOoR9aML4hX7ISkPWUgUIPrWvPhwY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpR5vcox7qIrfrMuA1GVItiQ1YBg1Rdpf1mQ/akwuZQ=;
 b=o0kttKKw+6pUlUXYQV9ins3NI2F+/tX2tfp5/sva+w3tZGNVbe1Me815VtjGQUJZqgVV6IvuaxgQPsefhj4MCgBbjy87FaaRSV2njInB01ClvpD73HFTE98LM34jrxPWN9nHqkJBvWGyoeU/jhv75qhIQQquZR5kKZ431GVHvx9JhBXsMRVzv99hkPnE8zwVnu9MBiBPogJalVnE329m92rvpP2hffdAjNLsM1XUqMrhNV0oYeCTuoVG/Aw0UY9pjRIPZGcIKaz7Tic83k1gDvgFdVsrFsaG65aXJq+QV78KUzkmZNOUns71WXtFDtWPCv+6RES2Sv2ZWhTHPeBk3w==
Received: from SG2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:4:188::19)
 by SEZPR04MB6171.apcprd04.prod.outlook.com (2603:1096:101:cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 01:25:40 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::33) by SG2PR02CA0129.outlook.office365.com
 (2603:1096:4:188::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 01:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024
 01:25:39 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net/ncsi: Fix the multi thread manner of NCSI driver
Date: Wed, 22 May 2024 09:25:36 +0800
Message-Id: <20240522012537.2485027-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR04MB6171:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8ffca375-8a5d-4f0e-3c65-08dc79fe1735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWD9vhW0mOp/77s8EumMdiEefIU3OL01KV5GAWRbsVneqRPAOzXOjh7j1y82?=
 =?us-ascii?Q?SBISBmap5fiokpGkbUwwIHY5AK3q9waep+JKpUwMFJu/tFRFzbClwYWEqYAB?=
 =?us-ascii?Q?tMol9fwhHuNY1Gr3KaoLWvpAPp9sleERQJiNgoYeoFO2tT+7T0rY9VqnGs5t?=
 =?us-ascii?Q?IhScCsOy1NwqzTpObiz2jqZqFRWRSGL4/+TibfOomAjCHzbM4V5kPl4qrf1T?=
 =?us-ascii?Q?gDMz6MCh9Lmkwq5JTuhp3DPYA7ZSQ/7RTe1VxN6e3INdkte2m1+xPvvKc5Vh?=
 =?us-ascii?Q?gjYMukdnFUe9D6qEtBLfo3mWGUcAsdx6DbdjLtZCd6VL1sulanajquC0Wxzt?=
 =?us-ascii?Q?z07HlpHxANhrxadGFMUuBI/E1TZXyagFpKSrO/hKt9tcW4hPK1pv8SmRdVRp?=
 =?us-ascii?Q?s0zbAG0w5iEzy7Rr9AurOYA8Q4rcQ4g+ZIBKeFBOa/FBTgUww/0kCShf4R4w?=
 =?us-ascii?Q?2nskOcQFmqWKrixIGfCdg3DeKTaf9/uW7JsjuwQsZixMiNcvN2vxIdJCjhFh?=
 =?us-ascii?Q?I7K6bpvFeSkMafNMY0dqknRLgGGNw3sSNd7jUjhxWR46EmNmnhnjTIcVR54O?=
 =?us-ascii?Q?GgQy3PxZcyf+Wpeec2KPAkpjy+PPEW2OekYSf0iMBrrYTSG9DyjhF8JimfET?=
 =?us-ascii?Q?YAue8KYyHkXl6qlKAQy86d4IZaXGClsmOdhlFVSqCk1cuB2N1aV0A0IaWvWn?=
 =?us-ascii?Q?3jQEw16Weu9hh9eSbsAEXtGvvTt5wJArwvNXwNXEWgGPWcjYzAC/hFv28The?=
 =?us-ascii?Q?CS1+wnSUss12emKKz69lTdigAWQ7jWjZZ/E4Q/a9pAQWUWs44gRCjPu/UrtQ?=
 =?us-ascii?Q?iblTmA9FlOFcNE3mckXA8eo/Lb/Af8m15CeMzK8nfUaxfc6qaHYL4UPOvHiY?=
 =?us-ascii?Q?Z8ab/zfz6WvpvB6S28nphZw/iwNEuuCKAFv3L2Q3l1KyuXBAG6z4No3vs3ZK?=
 =?us-ascii?Q?axVAy2Z6mu010LMXyiIRaEXbPgcoGWAqfIctcU7M/SON5rg+QRTY1nU6Al5S?=
 =?us-ascii?Q?JdaswU8Lj3uVRtjkCiSXqB1msSNJtunZHL+dGMSiOZsYN5Bg7MciYWH+WsJg?=
 =?us-ascii?Q?8VFUgsnFImCeBKtqAufvGnBoX5XDFHGrtYmc/1FXqmUJCP6dGaeorZKPmMY1?=
 =?us-ascii?Q?h+qN/4XHkPbhZLCQezG9Of1zICOct0pckjJXyHZCmwtK0NuOgFHcIIm2AqvI?=
 =?us-ascii?Q?nmbE5DvftOPaPwbmT2mqBQ+FN5HZhivnNmGp5Eo/Npuio6aw6IeIsFMg0ele?=
 =?us-ascii?Q?nVIdrVvhv97+tbXBrTORx2gd+C4Wh9G4m/bAxowoucySGOPShG8+0cyl0a1R?=
 =?us-ascii?Q?Z1nSohjK6EMMK/dP/1T2L/iz+SHZNfMEbkv4SDM08KAri7RAbaYIlMDIbkwj?=
 =?us-ascii?Q?eE3uayw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 01:25:39.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffca375-8a5d-4f0e-3c65-08dc79fe1735
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6171

Currently NCSI driver will send several NCSI commands back to back without
waiting the response of previous NCSI command or timeout in some state
when NIC have multi channel. This operation against the single thread
manner defined by NCSI SPEC(section 6.3.2.3 in DSP0222_1.1.1)

According to NCSI SPEC(section 6.2.13.1 in DSP0222_1.1.1), we should probe
one channel at a time by sending NCSI commands (Clear initial state, Get
version ID, Get capabilities...), than repeat this steps until the max
number of channels which we got from NCSI command (Get capabilities) has
been probed.

Signed-off-by: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
---
 net/ncsi/internal.h    |  2 ++
 net/ncsi/ncsi-manage.c | 73 +++++++++++++++++++++---------------------
 net/ncsi/ncsi-rsp.c    |  4 ++-
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 374412ed780b..ef0f8f73826f 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -325,6 +325,7 @@ struct ncsi_dev_priv {
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
+	unsigned int        channel_probe_id;/* Current cahnnel ID during probe */
 	struct list_head    packages;        /* List of packages           */
 	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
 	struct ncsi_request requests[256];   /* Request table              */
@@ -343,6 +344,7 @@ struct ncsi_dev_priv {
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
+	unsigned char       channel_count;     /* Num of channels to probe   */
 };
 
 struct ncsi_cmd_arg {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 745c788f1d1d..5ecf611c8820 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -510,17 +510,19 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 
 		break;
 	case ncsi_dev_state_suspend_gls:
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_GLS;
 		nca.package = np->id;
+		nca.channel = ndp->channel_probe_id;
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+		ndp->channel_probe_id++;
 
-		nd->state = ncsi_dev_state_suspend_dcnt;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
+			nd->state = ncsi_dev_state_suspend_dcnt;
 		}
 
 		break;
@@ -1345,7 +1347,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
 	struct ncsi_package *np;
-	struct ncsi_channel *nc;
 	struct ncsi_cmd_arg nca;
 	unsigned char index;
 	int ret;
@@ -1423,23 +1424,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_cis;
 		break;
-	case ncsi_dev_state_probe_cis:
-		ndp->pending_req_num = NCSI_RESERVED_CHANNEL;
-
-		/* Clear initial state */
-		nca.type = NCSI_PKT_CMD_CIS;
-		nca.package = ndp->active_package->id;
-		for (index = 0; index < NCSI_RESERVED_CHANNEL; index++) {
-			nca.channel = index;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
-
-		nd->state = ncsi_dev_state_probe_gvi;
-		if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY))
-			nd->state = ncsi_dev_state_probe_keep_phy;
-		break;
 	case ncsi_dev_state_probe_keep_phy:
 		ndp->pending_req_num = 1;
 
@@ -1452,14 +1436,17 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_gvi;
 		break;
+	case ncsi_dev_state_probe_cis:
 	case ncsi_dev_state_probe_gvi:
 	case ncsi_dev_state_probe_gc:
 	case ncsi_dev_state_probe_gls:
 		np = ndp->active_package;
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
-		/* Retrieve version, capability or link status */
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		/* Clear initial state Retrieve version, capability or link status */
+		if (nd->state == ncsi_dev_state_probe_cis)
+			nca.type = NCSI_PKT_CMD_CIS;
+		else if (nd->state == ncsi_dev_state_probe_gvi)
 			nca.type = NCSI_PKT_CMD_GVI;
 		else if (nd->state == ncsi_dev_state_probe_gc)
 			nca.type = NCSI_PKT_CMD_GC;
@@ -1467,19 +1454,29 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_GLS;
 
 		nca.package = np->id;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
+		nca.channel = ndp->channel_probe_id;
 
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+
+		if (nd->state == ncsi_dev_state_probe_cis) {
+			nd->state = ncsi_dev_state_probe_gvi;
+			if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY) && ndp->channel_probe_id == 0)
+				nd->state = ncsi_dev_state_probe_keep_phy;
+		} else if (nd->state == ncsi_dev_state_probe_gvi) {
 			nd->state = ncsi_dev_state_probe_gc;
-		else if (nd->state == ncsi_dev_state_probe_gc)
+		} else if (nd->state == ncsi_dev_state_probe_gc) {
 			nd->state = ncsi_dev_state_probe_gls;
-		else
+		} else {
+			nd->state = ncsi_dev_state_probe_cis;
+			ndp->channel_probe_id++;
+		}
+
+		if (ndp->channel_probe_id == ndp->channel_count) {
+			ndp->channel_probe_id = 0;
 			nd->state = ncsi_dev_state_probe_dp;
+		}
 		break;
 	case ncsi_dev_state_probe_dp:
 		ndp->pending_req_num = 1;
@@ -1780,6 +1777,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		ndp->requests[i].ndp = ndp;
 		timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);
 	}
+	ndp->channel_count = NCSI_RESERVED_CHANNEL;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
@@ -1813,6 +1811,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 
 	if (!(ndp->flags & NCSI_DEV_PROBED)) {
 		ndp->package_probe_id = 0;
+		ndp->channel_probe_id = 0;
 		nd->state = ncsi_dev_state_probe;
 		schedule_work(&ndp->work);
 		return 0;
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index bee290d0f48b..e28be33bdf2c 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -795,12 +795,13 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	struct ncsi_rsp_gc_pkt *rsp;
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_channel *nc;
+	struct ncsi_package *np;
 	size_t size;
 
 	/* Find the channel */
 	rsp = (struct ncsi_rsp_gc_pkt *)skb_network_header(nr->rsp);
 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
-				      NULL, &nc);
+				      &np, &nc);
 	if (!nc)
 		return -ENODEV;
 
@@ -835,6 +836,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	 */
 	nc->vlan_filter.bitmap = U64_MAX;
 	nc->vlan_filter.n_vids = rsp->vlan_cnt;
+	np->ndp->channel_count = rsp->channel_cnt;
 
 	return 0;
 }
-- 
2.25.1


