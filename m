Return-Path: <netdev+bounces-292850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n3luOMewGGr9mAgAu9opvQ
	(envelope-from <netdev+bounces-292850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAAC5FA535
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B02F30860F4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24935CB61;
	Thu, 28 May 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="FzsckexI"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAD318B9D;
	Thu, 28 May 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002239; cv=fail; b=kqimHl3FNDaFMJrVvkd9JMjg5Uifyj/ctwK21OuntF7+nNSAjcpMwDRfYNUX592GHFqk48P0nS34IU5Obaf+zjnv5LyVdgaENh6kpV4bHK22pcJkknLqR8VvdydaLhvn6Jminubpkuwwt6+f/zbdEQB4GOhVsPJ4IQjB9f9Mano=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002239; c=relaxed/simple;
	bh=nBAaUSpVm/m+5MwRv+AW6bEm23upR11wFN3l/u+drhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG6gl7n9WxzEK2TAb1ihL4bKQRgQNiAq4xH8trvytFhx0L44A0+AfczymOfSgbSFXUHaNvuAgFPMfqnaLw8GIzg63pd0M/Cx4w+Fk8SKRsddYBgMdpDjlFmWcqQ6mc1ww1UfD5yorb8blW1udFQ5OzTxrxyN3N7lin+YMAFjYU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=FzsckexI; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRFTPv9XtWFQb0sT/TKTSmPIbqVL6EU0Mfe9jHsPVPMkHMVsL01n9qB7U3vK61Ptonks75omkN/kcO7kb9jdKooyKhqECAuv8cm/LxfQFv97H/7PgAmGHg36bkcUMeHjPf24DYlFtxJJFWlJABL1z83X6YuF9EDjWtz1KBE+flIbcncKSI7CzXt3kHQcUIblHD0z8xaTTTV2e0wcpzs/d9Yv/iNrVtXMCGO2WGnSQELBtHjGeYa3JNeClIQUsCLzGd24l74tMwNVIOmSNEF8n9qP9sQck3xSdHQuFSL08/TjW56WsyqBhXryeIsk32a5hOPf5/ATyZmpn4uheweXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRbReeqUNpdr3nxfHt30zxTGTckCgnySi7PIOpeX8/k=;
 b=g92YYc/CHWC/6QB6AGkHjCzPfoxbW/p7kuKst6McnCTu6gMMsns0R6/4Ngw3GnDC/acdYBbgifmGblXp4k428LqfVIkrO6LBvqIYdeOrNmsYlSwzS6cB1+plk5bWXjdIQGkdW9LWgqvvuOvIw77coa5ODIP0nJTRZx1MyB1WTtwbNkAhZlpy/JMghlR+Aa2/FbY9eK8lSVI7YxOD+MgmKclRGnbbVxnCdRBAdigf0LnZDBMovBoKiwapwTycosCT1oMUgRNCXCkmIgudUobALmyLW8TyClaA7rWq7iDiLBFc3MfgSPXnsIzkMpKNkiDAYLWjCPsHZZrzZPKnlMMvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRbReeqUNpdr3nxfHt30zxTGTckCgnySi7PIOpeX8/k=;
 b=FzsckexILQy3QToLnvZCGI39nTetMlB6FP7m2J/Agt7MQh6SCLul0I5Bed70ayVaBcqpZt6VKhAbBI5YT7cLXN7R6vrsj7Ib7hL5CxV4pEsgaASIJ0Z+9Rr7dsZjQsLEv5HIMIaFbkOghGHT6FkmVQvN35HT2eBtE7M5b8hcaC5X7r5Gef5aOgo7KLFQ+FwUbfS45vKTD6j1hCR6q2aPHeLYSzRD2B+kUviv4nbRI7WKI5On9ehFaOHS6Am51c7aCjxrCBiVcPo4IWqNi0cPk+8tRx/nwGQLruQrdDXG5V/1LVt0QoxXKQBPjz61NUwRs0iqjpusXm3TPF32u5axoQ==
Received: from DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) by VI0PR07MB10840.eurprd07.prod.outlook.com
 (2603:10a6:800:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:03:52 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::71) by DUZPR01CA0300.outlook.office365.com
 (2603:10a6:10:4b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 21:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 21:03:51 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 23:03:50 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 1DCBF4020B4A;
	Thu, 28 May 2026 23:03:50 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 0B15E1005D6A; Thu, 28 May 2026 23:03:50 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v3 3/3] mv88e6xxx: Add SERDES Support for mv88e6321
Date: Thu, 28 May 2026 23:03:10 +0200
Message-ID: <20260528210310.1365858-4-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|VI0PR07MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: e66e2164-cc44-423d-6a44-08debcfc9eae
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I5VmZoig35dSQo3vypQfBGOVpwlMUT+ViRt0Gr/ykPO5/GuxT2Jnd+LCJAoR+ZDaV8XZWKXuNljG3s5KJOF4OGfcfXw03ZHByfGRo/SJVNJCW6mRl9PvtxJVfePPil09GbToeyB5BZbqd2uic6Gzt9BZIDsLxGCUV3jlKwernhaemojKF0SGSjkky+te28qUQyPHoVgw23gTFNwZrw1B/JWbMtLprxggu4WBBYa+HRTyhp78Ya4acHLnrGvELwGRI2hYZh7dqARIHm9C3IpDeZOcH1x4lt4wZQn0Y9VG8fxlRKXhvQOnb6XFgOjWutZkoIbFt/oKhft+t4jli98DtDIr29uoDLN0+5Ant3Bnw5IP4yF9CybEJ0mRgKMQBNVUCmsyTPw7EixK6gfZhptbFGtlgmErotrfh771WNyT/FRwolsX35OoBwPFUymMrioNGceskAEXDeiDaaCDrypHnoQ8doPHwKZRRXM233nnzG2X46cgsL5PuExSX5YetgKI26wc1kwSGGl0uWsPZe3FalmR4BmJIY84S2l3vFtAdVl4+KQVd8rzBR1gDYJLEhAbpPGgr0c47AF8/RjHAeK5zTv7bjqbueLrxRVbVmhKur+1mbuj7KxjVmhIRv5dmE5yYaRRhGYuayubgE6Fquf8rLCKErdqQNHBzYAFANbd2anKNpF++Ee2Rfd8rnXp/SIkNv/Rq398rZptLV7jUHRjhL2M75cYRToUwDntLU4/WwY=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+NG3WoZuYs0KRQXfyeT588Z0Sxn/6MjlLX34OAqetBFItzJwG6ZkcwDH1eyL51+0aIG6BbGXjRyHvSEWp2kOLruzU09Ibgto5uujp1+zQjPjHFUxFCKmBIo87D6Lp/vdMUcQ+ZAzAQJDnnAnI1l/ccYlt+xniSpHstiD91/rWyxht03q3lunPgBHhlZvaF8Hj3J25Ow8j+PEIr1CGzgK7wYBaXi8ybm9YE8df1m1+R4hsx3UOWU4n7Pb+3JS6jz9MlacTmhfyqxEdEg/6UZxPvopiBdpjiEh9yuz/puwkH8RuIu2/xlumV5+uRnRp7pMQj74Fg0BXI/Wi/+v0Gh9IslGyDrWQ048b+pHMZ6K/CrfPkPhE+lla6u+Nkw6gMtXmRcDWG7w9UsTzxEfKnLhq2kpEQDkeHXzf7hKeX0YeyV4qgE+iw5zdGMEdJnSF1fb
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:03:51.2435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66e2164-cc44-423d-6a44-08debcfc9eae
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10840
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292850-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFAAC5FA535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add serdes and pcs_ops functions for mv88e6321. In mv88e6321
2 ports support serdes functionality; port 0 and port 1. These ports are
serdes-only ports.

Changes:

1. Add a function support to return the lane address for the port based on
cmode.
2. Reuse mv88e6352's serdes_get_regs* and pcs_init functions for mv88e6321.

Tested on mv88e6321 switch port 0.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 18 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 30c8f6e1b367..6c48a99c3b7f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5270,10 +5270,14 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.serdes_get_lane = mv88e6321_serdes_get_lane,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.pcs_ops = &mv88e6352_pcs_ops,
 };

 static const struct mv88e6xxx_ops mv88e6341_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 48db9932b989..4a394d47923e 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -241,6 +241,24 @@ void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 	}
 }

+int mv88e6321_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	int lane = -ENODEV;
+	u8 cmode;
+
+	if (port != 0 && port != 1)
+		return lane;
+
+	cmode = chip->ports[port].cmode;
+
+	if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+	    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+	    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+		lane = port + MV88E6321_PORT0_LANE;
+
+	return lane;
+}
+
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
 {
 	u8 cmode = chip->ports[port].cmode;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 21e050b328cc..e8f254909d6b 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -14,6 +14,8 @@

 struct phylink_link_state;

+#define MV88E6321_PORT0_LANE		0x0c
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -114,6 +116,7 @@ struct phylink_link_state;
 int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);

+int mv88e6321_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
--
2.36.0


