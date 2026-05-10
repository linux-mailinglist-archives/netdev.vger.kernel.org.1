Return-Path: <netdev+bounces-286403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEqkCQz6AGprPQEAu9opvQ
	(envelope-from <netdev+bounces-286403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77924506805
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27FD83002E04
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F233D6ED;
	Sun, 10 May 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="gWyanYUz"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCA284682;
	Sun, 10 May 2026 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448903; cv=fail; b=Uh1ARBCV1d5RfIxZIzmWhhwaWqDR/6YRPkQJCcnlk3GP88B2dg8tsrkd2BYvqG4gnXZewVELFvZPl8OYmViUnQD4jDH+2IkAO8rK5IzG9zlMEFkjPBafvY2Piy0rNHmXRdGmAH4dNNd5Hy0mTIbUE/yUpx54FukvrgwP/FqD7cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448903; c=relaxed/simple;
	bh=m4jyT7Hq7iDRUPrJsPMUKgPcik/b0VVfY7ey/Sqxgs4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAfP88kvycGKE0KJ1kCStvwm0kqQ2Oxt8cWg32OpNSpePiMdcZJ90B9uWSMURGsZcqjfgP/oB25GcvsT9CSnZoZz4pURJHEMTfULNJV2B6PLXHfzkp4iPaGSlR/d9CPySIpGcDJNb63wnksT+G9VufbIP5UXOoNFftunZbXK5BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=gWyanYUz; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEZ/irdFTFTFTnir/cZiMMgDyxXT4GHfF5OjmOVfob0YfP59zfWkJKyUH/MQE04HQk3Ef8/OVi9iwkflCk9A9HpYPB87sn1OgwRLEaZNJWcTdKfQCU5Q6btkriT3uk5p1S3P8yFUlH9sMt79rOKBKggHba4guUebYTric7w3FFwOrS2A8G+Uwbhb4AeqRccTlPL3+KPqm6O4bQQbwwFGSeyE2ZyceB45REQ4YJzB0bEZVhsvP5B1Fc+4FqueOnPlyVIW9rS+GN4UhwBc9T/3OHXwsOfTzIc9RLyqnBeh/ty9z1bJb2KhFM3jpSIDJ/l7iBOCwkGADfZqDxdEVxK0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSfZ4U1aHLKn1mQiTw1CGeeYRLxBTxTcmjPuSpYMMlo=;
 b=VOtmypqRtvo77qNtOhVfHQZ2Olp5w47QSWowmNu6fMrIGJ1u2J5codKyEgGVbrcnh48kLFLz0siO4scyboDQJQzlq+7g1aGHT/WJz97J4wuaV7exIIvs8i2nCMRcGCbeiAqHQ2rEYQZVHAy8Ait5qTdCvO465Oyx4zRBbbiqBduYcVqAQfTPL5BXgz3XqeFwLyJM0ABp/MEvAjg4o0UlQWvkwuDN/qCIzflacz1kzWpT6SbvEvZNpVH4gd65d5E2xEk17D3Rf+Vl4/Ng4/3CZxOCFovYbqRtRCs6Y0PxGeW8v9MPmC5Oe0ecK27x8omJJ9UXeeEYkR1jKu7hCy51NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSfZ4U1aHLKn1mQiTw1CGeeYRLxBTxTcmjPuSpYMMlo=;
 b=gWyanYUz4L2grXOd0QkVfq32t+UCs8EL1GpsG/D6RfmHHj4o67C9hyulZtd3y3Lc2lCwgv0ddvFYX/xl60US4ZWTi/9YJooVMPZ27yGtCx+GRycIaL6JB//eT5O0IOKDzLSYjdVOGqYjeHlExltwGA0A/mJ6kwIm3LwZUwefj+TbNMktXIqEUqzhT3yEKuLOkVLOXa9L2EzJ+59AjJP/yoOoj7WREJispq5kfAjMqa0MgCnvwSzubxeFPIlNOuYt85oGjoml43FIMTiHUuOi2ZtKrx932s53x/K8aeGHsqW6d6G/XnO1lO7U8NlyCujXsUi/aA4tbS9heb4DIca3iQ==
Received: from DU2PR04CA0315.eurprd04.prod.outlook.com (2603:10a6:10:2b5::20)
 by GV2PR07MB12355.eurprd07.prod.outlook.com (2603:10a6:150:341::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Sun, 10 May
 2026 21:34:55 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::6f) by DU2PR04CA0315.outlook.office365.com
 (2603:10a6:10:2b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 21:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:34:53 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 10 May 2026 23:34:53 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 84E694020B4A;
	Sun, 10 May 2026 23:34:52 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 6F3871005D6A; Sun, 10 May 2026 23:34:52 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <fidan.aliyeva.ext@ericsson.com>, "Thomas
 Eckerman" <thomas.eckerman.ext@ericsson.com>
Subject: [RFC PATCH 1/1] mv88e6xxx: Cache scratch config of 6352 in setup
Date: Sun, 10 May 2026 23:34:29 +0200
Message-ID: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|GV2PR07MB12355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b16a264-7a7a-4976-cb05-08deaedbf957
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EXuynXFfIDG5qjjIQyPr6WuzQ/bDABiQuwg+uJYUUeX+aBMdhB/70BJXrKzwYwEsomjlyxAUlpWKBMVxFFBoe3dXBRb4r+zGmGrZH/0T5Me4Hh2xrfkIyrew7tjOLUsCmR6/Vkm1IXgaPnol2p90bcs8OK3Qqosi4LG9qBn7n0qYgz4UXA39RJSwLTiVDl1FRoTX1zD1+lAAz662Gef26F/tnlQMW5NtNmlxYU9AYZZ9GgkLHNhVrqF4NH+Jh4TTufOpAdivViz4L8t5XPp4ovcM2TUdI4Akk7hgRa7P51Hi/gNU2kOa8/MTP+xgn8IaTdr9T9FkIqnWIp3csZBBYqFZstvtOtZs+WmGc3tQ/eMaef51Kqx/vXdxjjd+ITU94BrY+NLJyEKFiT5qMAIHuzM9Qz+wOFZPjmgrEBpZ1RLN/UVYNAkuqdTNnBBGHYNNcqVuZsVJpwfiReN35sAkagJtrN7k/bldjG7NArxi9hrbBsn6g4zSe/xP9zlYarVC5TLG9I5hTW6ihxQI2yYDUE0RsIchD8HaZsVN+OKErMIu2tu/RbOwC+c1dU+cbl164LiL9q6vn6t2/GYQJ80ztwQAGFf1MNGb7OVSHrTZHH4mLV+NL6bLqEjCBlmDGYB1NhG0yFJn1liWzVITbAK+XdDxdEpdGw3SLkkQHZUaUs9gnCtnhy3H76OKY/CPa0RXtqZnHlJoglcoh2BcX8hLj7cYzTnmny98H0iwprc0wqA=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cnsEeLn+SlVyFRpCmeWEOwX9ZEq2a96jwDvLuwzj6xdFKygk/bC+lJ4pLmpbSOdt3IcnL7gqZioPruMCHA7D11x7UglC6t8LhEC9OB1P1NCI6rLfRG/X18In8lujkktDZzH7BQYWRJa6YkOtvuAa+5X9kDVm8ZqjIwAKmLtHVvStbSFKdzRMu7sT+vhUpBckMiDJoKenSjQmL6kKmWRegNhA2//6YHP7aGadRIxn/BVEerZVjBJz/wDI9gEf7/rh1xF2ycz2HsdERGbZx+OlBapzVaXPCvv8NbsC7bomrLcAdU/dS6KG9v3PoUmwpxpGgB5RhFwRd/v5krMOQiOnxVTICHRArcfDrU5qFb6BS0Wt9KXMugC+cEkMh8rNC4igFgpCtsSH/cyEI3AlAe/5VwrttGzBS1j2qPzQ9FaoCnZG28eIUC1uShMMdYRKzBYU
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:34:53.6699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b16a264-7a7a-4976-cb05-08deaedbf957
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12355
X-Rspamd-Queue-Id: 77924506805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286403-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

In mv88e6352 scratch register in Global Control 2 set of registers
returns which port is attached to SERDES. This value is set and
stays constant after the switch is released from reset; thus, it
can be cached during chip setup instead of reading the register
everytime when SERDES config is needed.

1. Add setup_chip_specific member to mv88e6xxx_ops and
g2_scratch_config3 member to mv88e6xxx_chip.
2. Add mv88e6352_g2_cache_global_scratch_config3 function as
.setup_chip_specific which reads the CONFIG3 value from the scratch
register and caches it.
3. Call .setup_chip_specific during chip setup.
4. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
value.
5. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.
Not needed anymore since no register access in the function.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            | 13 ++++++--
 drivers/net/dsa/mv88e6xxx/chip.h            |  6 ++++
 drivers/net/dsa/mv88e6xxx/global2.h         |  1 +
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 36 +++++++++++++++------
 drivers/net/dsa/mv88e6xxx/pcs-6352.c        |  2 --
 drivers/net/dsa/mv88e6xxx/serdes.c          |  2 --
 6 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..ab354bc2e2f1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -685,9 +685,6 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 	/* Port 4 supports automedia if the serdes is associated with it. */
 	if (port == 4) {
 		err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-		if (err < 0)
-			dev_err(chip->dev, "p%d: failed to read scratch\n",
-				port);
 		if (err <= 0)
 			return;

@@ -3997,6 +3994,12 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 			goto unlock;
 	}

+	if (chip->info->ops->setup_chip_specific) {
+		err = chip->info->ops->setup_chip_specific(chip);
+		if (err)
+			goto unlock;
+	}
+
 	/* Cache the cmode of each port. */
 	for (i = 0; i < mv88e6xxx_num_ports(chip); i++) {
 		if (chip->info->ops->port_get_cmode) {
@@ -4662,6 +4665,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.setup_chip_specific = mv88e6352_g2_cache_global_scratch_config3,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4765,6 +4769,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.setup_chip_specific = mv88e6352_g2_cache_global_scratch_config3,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5040,6 +5045,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
+	.setup_chip_specific = mv88e6352_g2_cache_global_scratch_config3,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5475,6 +5481,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
+	.setup_chip_specific = mv88e6352_g2_cache_global_scratch_config3,
 	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
 	.serdes_get_strings = mv88e6352_serdes_get_strings,
 	.serdes_get_stats = mv88e6352_serdes_get_stats,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2b235ac2c5df..683f5a626f34 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -454,6 +454,9 @@ struct mv88e6xxx_chip {

 	/* TCAM entries */
 	struct mv88e6xxx_tcam tcam;
+
+	/* Global2 scratch register config data3 */
+	u8 g2_scratch_config3;
 };

 #define TCAM_MATCH_SIZE 96
@@ -719,6 +722,9 @@ struct mv88e6xxx_ops {

 	/* Ternary Content Addressable Memory operations */
 	const struct mv88e6xxx_tcam_ops *tcam_ops;
+
+	/* Apply chip specific setup steps */
+	int (*setup_chip_specific)(struct mv88e6xxx_chip *chip);
 };

 struct mv88e6xxx_irq_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 82f9b410de0b..ff5adf7c9bc3 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -382,6 +382,7 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external);
 int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				       bool external);
+int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip);
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_g2_atu_stats_set(struct mv88e6xxx_chip *chip, u16 kind, u16 bin);
 int mv88e6xxx_g2_atu_stats_get(struct mv88e6xxx_chip *chip, u16 *stats);
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 53a6d3ed63b3..e57b25aa2a4c 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -322,18 +322,18 @@ int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 }

 /**
- * mv88e6352_g2_scratch_port_has_serdes - indicate if a port can have a serdes
+ * mv88e6352_g2_cache_global_scratch_config3 - caches G2 CONFIG3 value
  * @chip: chip private data
- * @port: port number to check for serdes
  *
- * Indicates whether the port may have a serdes attached according to the
- * pin strapping. Returns negative error number, 0 if the port is not
- * configured to have a serdes, and 1 if the port is configured to have a
- * serdes attached.
+ * Reads and stores config3 value of global2 scratch registers, which
+ * can be used to determine if the port is attached to a serdes. The
+ * value does not change once the switch is released from reset. Returns
+ * negative error number if the register read fails; otherwise, 0
  */
-int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port)
+
+int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip)
 {
-	u8 config3, p;
+	u8 config3;
 	int err;

 	err = mv88e6xxx_g2_scratch_read(chip, MV88E6352_G2_SCRATCH_CONFIG_DATA3,
@@ -341,7 +341,25 @@ int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port)
 	if (err)
 		return err;

-	if (config3 & MV88E6352_G2_SCRATCH_CONFIG_DATA3_S_SEL)
+	chip->g2_scratch_config3 = config3;
+
+	return 0;
+}
+
+/**
+ * mv88e6352_g2_scratch_port_has_serdes - indicate if a port has serdes
+ * @chip: chip private data
+ * @port: port number to check for serdes
+ *
+ * Indicates whether the port may have a serdes attached according to the
+ * pin strapping. Returns 0 if the port is not configured to have a serdes, and
+ * 1 if the port is configured to have a serdes attached.
+ */
+int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port)
+{
+	u8 p;
+
+	if (chip->g2_scratch_config3 & MV88E6352_G2_SCRATCH_CONFIG_DATA3_S_SEL)
 		p = 5;
 	else
 		p = 4;
diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 9ebf0f89f817..308655d72d52 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -326,9 +326,7 @@ static int mv88e6352_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	unsigned int irq;
 	int err;

-	mv88e6xxx_reg_lock(chip);
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
 	if (err <= 0)
 		return err;

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index a936ee80ce00..d3d3c121a32d 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -202,9 +202,7 @@ int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port)
 {
 	int err;

-	mv88e6xxx_reg_lock(chip);
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
 	if (err <= 0)
 		return err;

--
2.36.0


