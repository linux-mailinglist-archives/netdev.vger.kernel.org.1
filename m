Return-Path: <netdev+bounces-97276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED48CA6A5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 05:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57C2B2164B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248617545;
	Tue, 21 May 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Nnj1fXRR"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B501078B;
	Tue, 21 May 2024 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260974; cv=fail; b=CqDr2wxtb5ZMV/8YBAHy4/Nz+EOc6sS8oZHRfYAXltibMUMKLKwVT5tiX2SrR4+dpbSesm9xybTt4lhm5w4hUh6Vd+lqfcje6wOwM+0r01dCQ6q2VT8gRV8YR3im0MSxmoD4/CaJdgn3DjnmP3rBraSKO9Nacc9KeGfCPKJ71mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260974; c=relaxed/simple;
	bh=HpPJxtvSRd2MidkJ+CvJEsXnkDHl9JEwBnw8hESO53U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UhD90fKyB7N8pVs0lY98Fr+9z5v2xle3v3pdDnvHRGcC/y4zzv0R1qJTagG6sG2PSGTn/FKAUqxJOtkCjkUGgncF5s/DEQ2TegZk+w9K0VjAZjtR92TkB+dN83GzNmUeDAnXevA256Nxf/dgWhxI4xXq8H+dscEtY7XLZR6NBDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Nnj1fXRR; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNfMYvt1QOMbUeAEoX7pHw6d6Iy2vOyNz00whu0lZFZ0Y1MjpQbeZaEiLX0zByD0eedPjNMRyjlBF0dUUCvqAmv3Ww15Ja7FZFA88WNP52ctwttA7rUPmxsU7+VStzkgSN0y4KHTAU9wXzTC5T+XV2TEA643HhNPNGE0/n1clJBMV3Zup1QXO9ZcVL+1M8M0zPBxxyzIciAZm4xp3NUNDkiNpeSiVYGL1XB5ILFj3oUciiW1A4Wogsdo5wxhDpMPrT+pay1YHMJsDPq1K8VjfhOG88GJd5fiNfOrXJJTacSvU5YfAHRHPEMCmGmfZEMTKtcNwOBIb0f+UbZaBxxiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXdsrX0cYGZL/aomMDm+5gf/T0QwsuL2dkgtYbCiIjU=;
 b=fPXR25neoyXn3ZyeqBjNZigaTUIEANrOZTSH9WxAK4f+OTsQUZcbXqZxAjYSSV9hg9L6G0Pylvwqao5nLA+/Vaa2qZUS39EPtkTlGb0qwxB/c/OeELxkQiy2wn+TyDQ9pbRSMjsIne2KPGOarHhlZnz2EOJ1UFjlbW74UXfap3/PjUEA9ObreQwz5QqqMFZIF4iz7DfUoD/f9TgXkjKsNc+nb7L+fOgAPzlVl7jtT9aRqI6Bb5XEW5YNVz7M+88v38CFl7+6qLZTjwPlyW80OsV6OhscfkiMemcuZq85Ppr3fuEWXWBHs60rRP5SzrnFu7beoXafjHV7bax38C8gWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXdsrX0cYGZL/aomMDm+5gf/T0QwsuL2dkgtYbCiIjU=;
 b=Nnj1fXRRAdS2m1qdg1a8NH5/PJc2+VbxaP4XN8MItyl5sW1LN3BltP07rhsShx7gnvTI6oR1K9OhHK0dotgg/6ANib7C5DtIewaIyzFfgRk9w1VJ/e53M4C0fSG2NZioJ4Zw/TfbEYFK5yL2oYa5i850vHcL56SVYR+Vt3pW4XzW1keo3uDT/OsLuNqP1hlbTs6r14v4bpVG05ufffNb2g2Mqn5B0rdqLjAnxx23i5iI5tX1OEvEcQajVhrbtYKKjKIYupaY7yRKuuGLUZBuO9j7eCIGppRs5EZbXv25Z3jWCAk5xRa9/uRRFqbxF85dxH6tsCOc1aCqQFFvFAbpsg==
Received: from SG2PR02CA0025.apcprd02.prod.outlook.com (2603:1096:3:18::13) by
 PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 03:09:27 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::59) by SG2PR02CA0025.outlook.office365.com
 (2603:1096:3:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 03:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024
 03:09:25 +0000
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
Subject: [PATCH v1] net/ncsi: Fix the multi thread manner of NCSI driver
Date: Tue, 21 May 2024 11:09:21 +0800
Message-Id: <20240521030922.3973426-1-delphine_cc_chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|PUZPR04MB6316:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d222ee36-4805-4beb-68fc-08dc79436bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxO/X8fPTtPssDfK0J7XIzHvtCQi7dyIg2gTeSFrYDlJK+Mpf0IS4c4eXLKU?=
 =?us-ascii?Q?yjYk8xdqClm3SaQGIOMH7gaUc2TFZA3WhxmeVxTEI4JOey3zw6/VFzXX33ik?=
 =?us-ascii?Q?o5b+SRTOEushrQNOxUrqNIByULRmz6VPIBXzHl6cJudfv7WNPPGGT6jjmtqn?=
 =?us-ascii?Q?uZYryOTk3bwebYfN2jeendiLs6D1mrzzOQUgOnFJTZ8GY20KV7yTDuC3ErRl?=
 =?us-ascii?Q?eqV6M1wdweIPZ557TpKKfvleVkRHkGpZ5+QZW3+A0qcOj5j2+c8Pt+pEeSnL?=
 =?us-ascii?Q?KPJtApo4247v41hbT9+802pM+JyTeJ8+JAvpq9Aoum3IA03BJgkwoSMd8haA?=
 =?us-ascii?Q?UyV4xLGvTmuSvZ3lYpTyMUxX51WbBgM4BrDL1SYVl16cwps9EER+ktRpk1Hy?=
 =?us-ascii?Q?DFW79MfNgqG4CJ3RKyGpUTTHKGJsUClgAt5PuCyTmaZixn5VFHf2U+0w6ACp?=
 =?us-ascii?Q?W1fEYWKAMQ+MBDt2jb9FiixNC6et/boy8vwBEQ+8oPsV2sYYU9q7V/UBEIyA?=
 =?us-ascii?Q?QJ0MfSVB32tkxkuorsMveSvsEVppSyjRUTcEd2MXmCl1II3ibMT3Kf2R1430?=
 =?us-ascii?Q?mwNJIAYfqNAf3EeB3hoL2ULsftElJNAcVG9rmIZ3RoGd8z5d8zA1LB7D4NX7?=
 =?us-ascii?Q?R5uGVFiGr3jaHqSulpcLeaDnwzXPt2DRrxdDvfe+S1ITDOTfWSylAKWt0VVO?=
 =?us-ascii?Q?RRPVSOTpAGulIK4EfnTuBjkA8BxZ5y66tspORu7VNppOX+hh3kwRppwhCEJe?=
 =?us-ascii?Q?kvPBIesCRQ8ilq97pWWr9v3+sdGYozdD1pLeGh+sUIRIDTL41VhsxTjclEl5?=
 =?us-ascii?Q?9nqJ5JVIbTNBKDCxXpsWrcpAzy3CH09Bu8aByhEYLxtBUdDGElgsLk8vFMml?=
 =?us-ascii?Q?FT8j/rXUTFD/4Y3RhGcWSvBCR0eRJdtKYWM39rtd7zGQl4sMRpFPBs8PnBYM?=
 =?us-ascii?Q?K83kMkRHk9/QlMEAVgEXiYCYg1IEdd+OhtPwPaxA8tgY6IwMOLd4PuuNE889?=
 =?us-ascii?Q?BrhU++gwA/CZm/O9lGQosKyEeEMGEki6zVYDUARgGwIyvOaJv6nN6TpHuW1v?=
 =?us-ascii?Q?UrHajdvGhXyZUJqOWjBYBWLO3VkqsPIQfZ3P/0/gfAZ7THIFRAes8gxxaJ3y?=
 =?us-ascii?Q?Fj7g16OzvkUebUNOaAhesVfNcN6cEmyVRnsF5L5FiwIKkUwlQK8rxtgfLzvI?=
 =?us-ascii?Q?T8lI6sEa+LsRIFuymni2jhWO3op2T3RCOmvRYhlwcapft7HxRDXYflJ7DZpO?=
 =?us-ascii?Q?C6oylWQoMDZxVDR5gldDN3Xs7xTgWX39dRIAzcONFdEtUJxx+jL2F/wpvttg?=
 =?us-ascii?Q?+dVIfSjXLmaoZ6AuYYROYn/WAPugrVZEoH791By+hl9PJBQbtfBVZUT+hQGN?=
 =?us-ascii?Q?NmeI9Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:09:25.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d222ee36-4805-4beb-68fc-08dc79436bfd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6316

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
 net/ncsi/internal.h    |  1 +
 net/ncsi/ncsi-manage.c | 80 +++++++++++++++++++++---------------------
 net/ncsi/ncsi-rsp.c    |  4 ++-
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 374412ed780b..ea641491cb01 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -343,6 +343,7 @@ struct ncsi_dev_priv {
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
+	unsigned char       max_channel;     /* Num of channels to probe   */
 };
 
 struct ncsi_cmd_arg {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 745c788f1d1d..57e2518ab8ac 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -470,6 +470,7 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 	struct ncsi_package *np;
 	struct ncsi_channel *nc, *tmp;
 	struct ncsi_cmd_arg nca;
+	static unsigned char channel_index;
 	unsigned long flags;
 	int ret;
 
@@ -510,17 +511,19 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 
 		break;
 	case ncsi_dev_state_suspend_gls:
-		ndp->pending_req_num = np->channel_num;
+		ndp->pending_req_num = 1;
 
 		nca.type = NCSI_PKT_CMD_GLS;
 		nca.package = np->id;
+		nca.channel = channel_index;
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+		channel_index++;
 
-		nd->state = ncsi_dev_state_suspend_dcnt;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
+		if (channel_index == ndp->max_channel) {
+			channel_index = 0;
+			nd->state = ncsi_dev_state_suspend_dcnt;
 		}
 
 		break;
@@ -1345,9 +1348,9 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
 	struct ncsi_package *np;
-	struct ncsi_channel *nc;
 	struct ncsi_cmd_arg nca;
-	unsigned char index;
+	unsigned char package_index;
+	static unsigned char channel_index;
 	int ret;
 
 	nca.ndp = ndp;
@@ -1362,8 +1365,8 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		/* Deselect all possible packages */
 		nca.type = NCSI_PKT_CMD_DP;
 		nca.channel = NCSI_RESERVED_CHANNEL;
-		for (index = 0; index < 8; index++) {
-			nca.package = index;
+		for (package_index = 0; package_index < NCSI_MAX_PACKAGE; package_index++) {
+			nca.package = package_index;
 			ret = ncsi_xmit_cmd(&nca);
 			if (ret)
 				goto error;
@@ -1423,23 +1426,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
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
 
@@ -1452,14 +1438,17 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
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
@@ -1467,19 +1456,29 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_GLS;
 
 		nca.package = np->id;
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			nca.channel = nc->id;
-			ret = ncsi_xmit_cmd(&nca);
-			if (ret)
-				goto error;
-		}
+		nca.channel = channel_index;
 
-		if (nd->state == ncsi_dev_state_probe_gvi)
+		ret = ncsi_xmit_cmd(&nca);
+		if (ret)
+			goto error;
+
+		if (nd->state == ncsi_dev_state_probe_cis) {
+			nd->state = ncsi_dev_state_probe_gvi;
+			if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY) && channel_index == 0)
+				nd->state = ncsi_dev_state_probe_keep_phy;
+		} else if (nd->state == ncsi_dev_state_probe_gvi) {
 			nd->state = ncsi_dev_state_probe_gc;
-		else if (nd->state == ncsi_dev_state_probe_gc)
+		} else if (nd->state == ncsi_dev_state_probe_gc) {
 			nd->state = ncsi_dev_state_probe_gls;
-		else
+		} else {
+			nd->state = ncsi_dev_state_probe_cis;
+			channel_index++;
+		}
+
+		if (channel_index == ndp->max_channel) {
+			channel_index = 0;
 			nd->state = ncsi_dev_state_probe_dp;
+		}
 		break;
 	case ncsi_dev_state_probe_dp:
 		ndp->pending_req_num = 1;
@@ -1780,6 +1779,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		ndp->requests[i].ndp = ndp;
 		timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);
 	}
+	ndp->max_channel = NCSI_RESERVED_CHANNEL;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index bee290d0f48b..246b120ad3c1 100644
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
+	np->ndp->max_channel = rsp->channel_cnt;
 
 	return 0;
 }
-- 
2.25.1


