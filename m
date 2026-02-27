Return-Path: <netdev+bounces-261937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFEABcLXoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:43:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B821BB92E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 824EF30518CE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082244BCB7;
	Fri, 27 Feb 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HC69O4Du"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazhn15012042.outbound.protection.outlook.com [52.102.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDD44BCA3;
	Fri, 27 Feb 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214196; cv=fail; b=B3iVNViX2XaudFSCoMRYupZrhGh6XP4ZB+yw432Ypn7m8yid8zGLr+Mv/MwGrJsf8yHKNLRN04NjO2nXfiP0jdS907ea6lx8OKf1MI7QPhoFXqufkzbeZoJjjxf+KAeHPslC73Pu9/meFxGJ9zcAHfpByy9tLZDYOJ3xdkMDdRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214196; c=relaxed/simple;
	bh=/qADd07IQbyjRFT1fZ642bfisUCWwkO7VQw5JzeKeM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qnpLURNILUMHxw6evHsil9FCDpuZEq87djlAphFfhtLBck3QKCzYBzi0/eGcysJvGzkbIKwCmYiW1QIeRIf2QFIGLKbGy3OASRXnpnvyl3gfs8jCon3wK7L2QEZ4IaMV9HfPq5xkyfWqABRTjFdJLIYt6gv1DveAE7Zk6Me7bWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HC69O4Du; arc=fail smtp.client-ip=52.102.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnREBcAIGdDKXbO1SoftSTXwOaOLv+jqUhgANyGkGQAY7QWE+hhAwiidEpV42Jjqc3aXEr8EhzKKothjdbGRm+5edhJbGumvpVBDnh8wX0E9G7WoLRUjXFgDLT3mWVmfPprRp2HRQ/NfQwwLxJka4djrnrA3vmUT1BToE/Q/r7dDB4oMTD9/gCiS6qcOYonz9ijRy7QJ0M6f+yrgBFw5d78E5B/iB6xLHUdWWGQyi+2wa6Jzl+n45srbzp5oRx9XAX2RtTmDuyE1hWDJqOhxkK2EGzU+Aouxmq0fkqXADoGudtC9n+e1LatdCRrO+v8+SUXvktA2i62L4KkOshDF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrCCQaBYgKQGcTp3C0fxlRQhhqPKhxAZfjgNw6tNvNY=;
 b=e8i4YKd8eA97mZetfhxQatm77JQx7CDU/x/30K9dGx4J7MlAq4Nvh0o6zXD9csO42Agce5360Vviq5/jNTQRFxEZFjPW3rSgXGhPz2SGAOdzrOufSsdmQDXHCpmcfUb4hVKHBXXdY5vWpOSt5WaIQCL2w2LIyr4P5lX93klMwmX4Ddh5HgEukPeeX4eUPEfCDWcXbLd9tTzT/nKTu0Av4KAOYrGfpcXB7Wxvomij/tiK9sAElX0xq9PwOybRN/7ZMHQXINa88WrdvOnMhq03zmNct2/KqRPq5tH1h7+OqctXOYsq8PN/VrPzWJTSY2EpeHJxh1s/c1eNAclJJ5cUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrCCQaBYgKQGcTp3C0fxlRQhhqPKhxAZfjgNw6tNvNY=;
 b=HC69O4DuUDBYq6ADEcZlt8x1IwQRJ9tMSvZW13O4vTMPx35QkKJUPHYL0N/70nsXka5QDu38Gf+nPbQaH8yHoGWaN55PAFgUhtgvW4a3un/DefpWYilZdlcK2o0cFrue0/syXVil+C8u2ZJ1tQ8I0ISqJ651RnfKihK8zdpQVyY=
Received: from SA0PR11CA0058.namprd11.prod.outlook.com (2603:10b6:806:d0::33)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 17:43:08 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::4f) by SA0PR11CA0058.outlook.office365.com
 (2603:10b6:806:d0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 17:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 17:43:07 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 11:42:59 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 11:42:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 11:42:59 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RHgxn54139956;
	Fri, 27 Feb 2026 11:42:59 -0600
Received: from localhost (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61RHgvst008410;
	Fri, 27 Feb 2026 11:42:58 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, Kevin Hao
	<haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, "Roger
 Quadros" <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg: Add HSR/PRP protocol frame filtering
Date: Fri, 27 Feb 2026 23:12:54 +0530
Message-ID: <20260227174254.3821443-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: a473df0b-0ac2-4de9-0838-08de7627aae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|34020700016|82310400026|36860700013|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	8VhGA8GfEctnHy2yjDr/a2BuQXFDV6prXZbikTbFbypYQifFT1yqrHw/Q7xS3Z+QCV2UG2r0OZkV67dVkm0vlvMXEjMtrCfU4rLYRq36iXw6zeHBOAGLcmu1/fBPq4sP28QNZ5XH9zp2ND4lv0JpBN85XFvpCxCqxSl2Ke6tshNn1yJNIe1soZZkYjGH6Y4tD4vaJODvZDP4subISIOMs2HU32BgxRryKXcnNaeTsDlg2CwnvKfrU2VVg6XapWTBBuhyeyF1qyQfvjCm8dfG1WTmNxRRjjrcJbAFiw9xYtKyx0CbM5npyo/3G12OcNVQh9MV/O3y5efb6GD087+amfcket7bLJm0obMeKENanlcuA/eum2V0wiU4XpsbUxaJ0ZKvGAdRt/1bWAru7WIpjhFJCSibguG+q/hhes6IZnzp8ZlOVV/ENpbZr4OiayzaIPNh0Uh6Qrz5MwOIwZFdJ/F1d7hoMR+y1+aInDSiEq4QZ58o/7ZusWCOMKBsVg4u9nZEUpvtKgMzBpKyz+iSVXHr+xlVU9UxUVuD0Dgw9oY6jutR8/7aTWdP1J9RgI2+YVQFhUIVf9l2RabthTjMCG53YzBNAHLu75otPloIbVPpXKk9PsPyHMLyihQnrLs5Q/PHiloDVOD2CGfMxw6RQLfXMmD0ZC6W6k1IJpxhD34Q/MzxhHzhwWwVpih1OQPSf8BOJKoYE/2E7wPdHyP8g1mdqKagzgnW8GRc+g/PpMRs9LLsJhw/z6IUd/qCvuqI7FPnzGAQcRtZvPg9sJOu6pacgE6z9OapyghCx+asBRxo3tdYrTSH3Mo9DRXbJliJoSiAmmATPZqWBFPp3MpMPg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(34020700016)(82310400026)(36860700013)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Id8n87TveFksCTIM4l04n6FHCuD+Q1Ec79BxoriydL1FMEMrzKpbCI9BwwDpL/fdkzwf8zdpNentyBxrWS3Ml1yLSRy8tRLunafiTr947vCw2WCMrEOhKNDTUUY4bW1bSaeYvXtUF05/1LQugXpnZy3qXo+EfqBrIbAXT9HfeSbbaSkumNGdBY+HRV7GfSETnGPkAcNg0WP1D6yrKEFHHi5zqD/ZZb5ydmORnv2dRTrs1CqTti8bt+Aynxox5jQorPe+8n6M+vmYNnXSKHlNqM/RfsZ7gazm7569Xo+Jm9e3kV7pCy4pHHFUyKmFwPvLJGGCulAS0Ysw1pbDVhDLJ5u2Ao0y7r6q7+MCXRnfJ0y3y1Woy63//1EvMHVUZr6JrFqaJopBIPxwM9jDx6HYPeyjYcvZumGhVxNK0sleE6n6GTEclQ9EAH7S2Usv9Dmf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:43:07.5876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a473df0b-0ac2-4de9-0838-08de7627aae7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,intel.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 62B821BB92E
X-Rspamd-Action: no action

Add support for HSR and PRP protocol frame filtering in the ICSSG
classifier by configuring filter table 3 (FT3) to detect PTP frames
(EtherType 0x88F7) in HSR/PRP tagged packets.

Also add rx_class_or_base to miig_rt_offsets structure to support
RX_CLASS_OR register access, and fix typos in FT1_N_REG and FT3_N_REG
macros (slize -> slice).

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../net/ethernet/ti/icssg/icssg_classifier.c  | 69 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  2 +
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 833ca86d0b71..cde53d9aaa7b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -27,7 +27,7 @@
 #define FT1_DA0_MASK	0x8
 #define FT1_DA1_MASK	0xc
 
-#define FT1_N_REG(slize, n, reg)	\
+#define FT1_N_REG(slice, n, reg)	\
 	(offs[slice].ft1_slot_base + FT1_SLOT_SIZE * (n) + (reg))
 
 #define FT1_LEN_MASK		GENMASK(19, 16)
@@ -62,7 +62,7 @@ enum ft1_cfg_type {
 #define FT3_T			0x18
 #define FT3_T_MASK		0x1c
 
-#define FT3_N_REG(slize, n, reg)	\
+#define FT3_N_REG(slice, n, reg)	\
 	(offs[slice].ft3_slot_base + FT3_SLOT_SIZE * (n) + (reg))
 
 /* offsets from rx_class n's base */
@@ -74,6 +74,9 @@ enum ft1_cfg_type {
 #define RX_CLASS_N_REG(slice, n, reg)	\
 	(offs[slice].rx_class_base + RX_CLASS_EN_SIZE * (n) + (reg))
 
+#define RX_CLASS_OR_REG(slice, n, reg)	\
+	(offs[slice].rx_class_or_base + RX_CLASS_EN_SIZE * (n) + (reg))
+
 /* RX Class Gates */
 #define RX_CLASS_GATES_SIZE	0x4	/* bytes */
 
@@ -102,6 +105,22 @@ enum ft1_cfg_type {
 	((BIT(slot) << RX_CLASS_FT_FT1_MATCH_SHIFT) & \
 	RX_CLASS_FT_FT1_MATCH_MASK)
 
+/* HSR/PRP protocol frame filtering */
+#define HSR_PTP_ETHERTYPE_OFFSET	0x12
+#define PRP_PTP_ETHERTYPE_OFFSET	0x0C
+#define FT3_PTP_PATTERN			0xF788
+#define FT3_ETHERTYPE_MASK		0xFFFF0000U
+#define FT3_VLAN_MODE_BOTH		0x1
+#define RX_CLASS_OR_DUP_PTP		0x4200
+#define RX_CLASS_OR_HSR_TAG		0x4000
+#define RX_CLASS_GATE_PTP		0x50
+#define RX_CLASS_DISABLE		0x0
+
+/* HSR/PRP classifier indices */
+#define CLASSIFIER_PTP_DUP		10
+#define CLASSIFIER_HSR_TAG		11
+#define FT3_PTP_SLOT			14
+
 /* RX class type */
 enum rx_class_sel_type {
 	RX_CLASS_SEL_TYPE_OR = 0,
@@ -133,6 +152,7 @@ struct miig_rt_offsets {
 	u32 ft3_p_base;
 	u32 ft_rx_ptr;
 	u32 rx_class_base;
+	u32 rx_class_or_base;
 	u32 rx_class_cfg1;
 	u32 rx_class_cfg2;
 	u32 rx_class_gates_base;
@@ -161,6 +181,7 @@ static const struct miig_rt_offsets offs[] = {
 		0x308,
 		0x408,
 		0x40c,
+		0x410,
 		0x48c,
 		0x490,
 		0x494,
@@ -186,6 +207,7 @@ static const struct miig_rt_offsets offs[] = {
 		0x8d4,
 		0x9d4,
 		0x9d8,
+		0x9dc,
 		0xa58,
 		0xa5c,
 		0xa60,
@@ -467,3 +489,46 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
 }
 EXPORT_SYMBOL_GPL(icssg_ft1_set_mac_addr);
+
+/**
+ * icssg_ft3_hsr_configurations - Configure filter table for HSR/PRP protocol frames
+ * @miig_rt: Pointer to the MII-G register map
+ * @slice: ICSSG slice number (0 or 1)
+ * @prueth: Pointer to prueth structure to determine HSR/PRP mode
+ *
+ * Configures FT3 to detect PTP frames (EtherType 0x88F7) in HSR/PRP tagged packets.
+ * HSR frames have a 6-byte tag, while PRP has no tag offset for EtherType detection.
+ */
+void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
+				  struct prueth *prueth)
+{
+	u8 offset = (prueth->hsr_prp_version == PRP_V1) ?
+		    PRP_PTP_ETHERTYPE_OFFSET : HSR_PTP_ETHERTYPE_OFFSET;
+
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_START), offset);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_START_AUTO), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_START_OFFSET), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_JUMP_OFFSET), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_LEN), 0);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_CFG), FT3_VLAN_MODE_BOTH);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_T), FT3_PTP_PATTERN);
+	regmap_write(miig_rt, FT3_N_REG(slice, FT3_PTP_SLOT, FT3_T_MASK),
+		     FT3_ETHERTYPE_MASK);
+
+	regmap_write(miig_rt, RX_CLASS_N_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_AND_EN),
+		     RX_CLASS_DISABLE);
+	regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_OR_EN),
+		     RX_CLASS_OR_DUP_PTP);
+	regmap_write(miig_rt, RX_CLASS_GATES_N_REG(slice, CLASSIFIER_PTP_DUP),
+		     RX_CLASS_GATE_PTP);
+
+	if (prueth->hsr_prp_version != PRP_V1) {
+		regmap_write(miig_rt, RX_CLASS_N_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS_AND_EN),
+			     RX_CLASS_DISABLE);
+		regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS_OR_EN),
+			     RX_CLASS_OR_HSR_TAG);
+		regmap_write(miig_rt, RX_CLASS_GATES_N_REG(slice, CLASSIFIER_HSR_TAG),
+			     RX_CLASS_GATE_PTP);
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_ft3_hsr_configurations);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0939994c932f..9efa39069c8c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -260,6 +260,12 @@ static int prueth_emac_common_start(struct prueth *prueth)
 	icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
 	icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
 
+	/* Configure HSR/PRP protocol filtering if in HSR offload mode */
+	if (prueth->is_hsr_offload_mode) {
+		icssg_ft3_hsr_configurations(prueth->miig_rt, ICSS_SLICE0, prueth);
+		icssg_ft3_hsr_configurations(prueth->miig_rt, ICSS_SLICE1, prueth);
+	}
+
 	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
 		icssg_init_fw_offload_mode(prueth);
 	else
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 3d94fa5a7ac1..df93d15c5b78 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -423,6 +423,8 @@ void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice);
 void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
 			       struct net_device *ndev);
 void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
+void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
+				  struct prueth *prueth);
 
 /* config helpers */
 void icssg_config_ipg(struct prueth_emac *emac);

base-commit: fd6dad4e1ae296b67b87291256878a58dad36c93
-- 
2.34.1


