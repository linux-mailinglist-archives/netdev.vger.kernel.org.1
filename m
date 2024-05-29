Return-Path: <netdev+bounces-98880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192528D2DB9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB701C21E14
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66E1607BA;
	Wed, 29 May 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="YOebDCXm"
X-Original-To: netdev@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D8273DC;
	Wed, 29 May 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965946; cv=fail; b=du93m4lBGIwMwjf2nxQXAUf7LNGcnO+tS7O8m1bSZBT3bu1ShpSZJQZhIsarkARJiJa7ywi+07EY+P5SsoVZBCas/QrIZbkiOhwfnKN7VGHvMI9JjDfu0HcZidn4OReO//8kZMfIyRcAaS7qHK7+2Zz0OtEyztujd74XBd5cBw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965946; c=relaxed/simple;
	bh=p2ti3bERSaxq1+DBZOYqaY3QZDMNENTVjBjm1pR9/34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D1KW94hkdIPt7CZw+IBfSHCdIpZGky8Rg7QBbmCDkeW62nXwZGFmGFZTOYA6dgk5GqF8U0u9y9KuIX5lrpxjPcrZPLJjXwrzkjbxw0+e3utgsY4NdV2iDUrBg30jDSs5bEDNfs/0pDNE+ldXzSleEH3epVk2LawOezlS4iVL23Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=YOebDCXm; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGioeFBRoz/iCVUwR4HRwoo9PzOV/7g/hvOz7wnM1gjV4eoi7pxuT0QDfNeD4E9QKZHci2OorTV+Ef1P1Y3uABzCv9e4FZqUY0XbAIN8xUjanUax3ccMHn1OSO81LNm0FyKRrMZVprP6fnVGvu59BK0RoznmyCj7CWqeq3tpGLtFAL+/z1kv2lDWDVPXyZBfIVszZi//QSGI+EX125y+hp3qk/YVsVQ4Nz+pB7o9MtpF/tQN0LDwIY8xJ3O0zEP5Y05N6LydT7NbBoTHKSBJeNYsxP8rfqVLEQA27lNbdadvNrXslMc8M8rPptijOEahowXnRupt3EdPuldsXTAOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd73hugEHrkwRgo0STaQ7W+q/VZq4iM79NDNP/Ezukg=;
 b=MBzCabIcZ3DZFGhlpJAgTIxoW7rszPlpHztoy10wQ9cNeWtE8fPFQDnVwvRENg1AbaQK/5NzlCmtd8+I7BdLvIwtAPc/3Iwiozp+qDtgj14Etsw0BGORtttU7ehk1Cyvy3/YiTZdyrpuMJ6ZODJl5pW6FY60x6NN6mMdhlF6lEsBwN75MP1Fenc3NiQeZbehT7QzCKl1c9q8YS/HdSA6+aeUPIOIO+4MNkVGyhPhGGy+gP+HF5gSFnAfhlrMLAnI1cET+k7C59HbqmDM5j4GHON6Y7GILzTctuMgxoxvPEdjLzVUR8/gu9b6cdSO6I28xfn4ggWRqh8UMsG5H37kNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd73hugEHrkwRgo0STaQ7W+q/VZq4iM79NDNP/Ezukg=;
 b=YOebDCXmL5LA83EFkYw4LB8b8gYLycC35b5XOZZd1K3sNkVPohZmEGQ+svbjxwk8m6qFGHtT/ytGdpri9cPvqwOb5+OUyMOOCt7aAIDhwrWEUO70BtK+OQEqEStPQqugpCTHWwlou9F0FnkwB9PJyiwbNMCtiYlX6hjVBYvRrlTFcJqMLZjaVyi1ifPZAiE0p+cgxE/iyloGeWxz0BdteQJwhs1txhCMJBodMeuIhNouFLSajioF3/my4wCRZNcu5LW5W3yXwsZz3z3QFwoErA6Tur+jFASr2dMN3oLx8M3XnZ4PWTwgiesoknoV8VDClNLsQL4SMGNGwM2zHE8qKg==
Received: from PS2PR02CA0020.apcprd02.prod.outlook.com (2603:1096:300:41::32)
 by KL1PR04MB7417.apcprd04.prod.outlook.com (2603:1096:820:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 06:59:00 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:300:41:cafe::97) by PS2PR02CA0020.outlook.office365.com
 (2603:1096:300:41::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 06:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:58:59
 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net] net/ncsi: Fix the multi thread manner of NCSI driver
Date: Wed, 29 May 2024 14:58:55 +0800
Message-Id: <20240529065856.825241-1-delphine_cc_chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|KL1PR04MB7417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7da1b5ec-cedc-48b2-aada-08dc7facd0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w275JfBSY6PE5NbHsmD9sFdb5G6D9BfU4qhbleyfPnAC3akIRTYkduR2vgIK?=
 =?us-ascii?Q?a8b20K58taLecFxQb+pS1Og0zp16hXH+CrEbEluUGO37cLkEvdyKZni7L2Sm?=
 =?us-ascii?Q?FgIAksUmZRF4gxcm9D8WVHEW4d+w+zjnils5wgmLvcRGDLvoQ0CbaVDzTUu2?=
 =?us-ascii?Q?IMPUbUoXJJ9Vfu7CWi2hb7G7/8Z+3CqkvmkLol596rBVSOnm6IKzhISYhl/Q?=
 =?us-ascii?Q?kkhS8TjG+h1K3I2OHkLb0KX6yWj3i+PwBI6WkU3fsQFegRPt/hnf0KhAdP0y?=
 =?us-ascii?Q?Jd093Ju6HStbnFmlhXp5C4z5CPGEbQoOK4XvP5n2POj8nDn6ClduArYM8Uaw?=
 =?us-ascii?Q?dFPLb2ozFBGsCXGiyRaH7PmkYsh5viFfmeID5FMDBQo15DBc5+FuzeBzBQHi?=
 =?us-ascii?Q?NylLuTeDKt45H2WNIDZh6VHApI/HaThfIpjuP/erPReYOgfgo/lBbFZhL/XP?=
 =?us-ascii?Q?9uc4XRfnbHvygKdFkmGMMcOu4eEzxcrLntjTo1uYHyiZvsTEHFhJlJ8DDjDT?=
 =?us-ascii?Q?taq1Xl/bjLdm25LRvzb2nVnbZafMUq37iusCtIrfk7ByYwyLjfgxCRnjlTau?=
 =?us-ascii?Q?wjC7SYajuFRLbfSm42krZinGMhABgPnD55b/0dJ7Szw2IF+40k2jZoz7JPYp?=
 =?us-ascii?Q?+m/s5pyM8rWS7fkPQJxvBBvFYRmA9cu23R+lqN41TRW7MpRjIdgiPnsATDIW?=
 =?us-ascii?Q?NwDc6ijSVoHbrOtxtpFkPNdkCZZDQTsRtrAohjwj1iQEdkMWBmJyLAggQAdB?=
 =?us-ascii?Q?yLXTjgVjxChbUNP3II7reI2SvLWJSJg4CzE6uNUHtuk89hPGSG0Jsnagr5hi?=
 =?us-ascii?Q?aQ/AfGr6ST+fuKDkA4dHDsUjmDcfKLgU399DR81T2UvTVvdyF2EfUuzivpmI?=
 =?us-ascii?Q?v4uWly9gfED2YQao3qo3E/g8v2SDsA6X3sdaVvJTab3uDnnAfQqs5RvwdkGC?=
 =?us-ascii?Q?5zd+OpBcvKMMTrjmwOgOJoX4aGR8gGZl05MTSCIJSusodSgpeRGThjOnpmrm?=
 =?us-ascii?Q?Gx7lVBy/O5BC6hd1yuiqh21+cYind2rn0jY6ewGuPXaC6tHdVpQMkVBroFqD?=
 =?us-ascii?Q?Bfx/StRm5UCCjpzaR1gzM8PtycBvJDsTbiufnWSva5k+91cbhmmaUextkqcz?=
 =?us-ascii?Q?3+WHDRFIpk/A2WD7XZJ+wMzkfl/HaNZCUuQoWewZ2Uejl+aHyG+LMM5OwTDe?=
 =?us-ascii?Q?UUWKHCgro0WcFJcKi0KkJ9KLDDjtVont3gzRyGG5+C8VDJk22yHyMsOWlM6s?=
 =?us-ascii?Q?pZGwmWUpqsS8kKKyC+yhmbOU9/xeHUUiO5Nayt+y2KRQSXMZRrSHuMGlorUa?=
 =?us-ascii?Q?3Ey/UmI/rQdHGPeF5sErlH9yAh26rIBZD7gbc1mQIKP5Sg7pStY3AryeecPf?=
 =?us-ascii?Q?s4q3OLE=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:58:59.4090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da1b5ec-cedc-48b2-aada-08dc7facd0f2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7417

Currently NCSI driver will send several NCSI commands back to back without
waiting the response of previous NCSI command or timeout in some state
when NIC have multi channel. This operation against the single thread
manner defined by NCSI SPEC(section 6.3.2.3 in DSP0222_1.1.1)

According to NCSI SPEC(section 6.2.13.1 in DSP0222_1.1.1), we should probe
one channel at a time by sending NCSI commands (Clear initial state, Get
version ID, Get capabilities...), than repeat this steps until the max
number of channels which we got from NCSI command (Get capabilities) has
been probed.

Fixes: e6f44ed6d04d ("net/ncsi: Package and channel management")
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


