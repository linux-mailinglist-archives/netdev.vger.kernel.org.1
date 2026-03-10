Return-Path: <netdev+bounces-266143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFCIB2AlsGl/ggIAu9opvQ
	(envelope-from <netdev+bounces-266143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:06:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949B25156F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9091E3328658
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355339C002;
	Tue, 10 Mar 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b9c82REx"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986B397E8A;
	Tue, 10 Mar 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148849; cv=fail; b=NHnEdJo7dITY8YMAD8ADYi5M0lX4ejho7QNZr+KIU5ExFqnVUl1fdqI2EXPkaOKPh7PYbOXShLVqXHs29pFpuFFopZ5zhksSGdJAbVbR3NWj1kvCfxI89i7cVhNOhIhZasJ2cdMOKQInPM7ULsPRekIVTo2qXVPQi8oUr7Ie/K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148849; c=relaxed/simple;
	bh=3MD6Szq7hPaX4UwbiLmvkORSoA+Y6nvaKmT54FWyLco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvj7vvBNfYp3Z1E74R/TIJlRU+MTo37o1iVBqzbnzgViC0hEh7mn49os/wZKiF+usHxWu7gA0qtJsnXnpdPD9cXapRAv4w5pSEA20QLb4nOPT13YdqGj6xnbFxOweQGtGaQzbcxcRXQaFFdVO8URntHBai14S+vZYaPteym2CAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b9c82REx; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReV1FiIwzh0PVHexE/TVCcZWDnWT8U0Ac7eIndJ1Aj07cfI4QB2RgwgmjbBxt3ejKttSCurhoKOew/q7vHHqMnmOyH6ZBOZvWytxQLUJYInFATbYIth+mklGkBJtfJvH5X4XsuhBt5FDgqoZENN1plSir1rzpoCGWtkHtbFgr2dP5TnjB1YIaJHumOshG2ygBwCIipOldIn58HhceeC3B0gYIx2+mpehconk2/Zwm5qkOBgeoBKQyjV9Sr8yYCKqKbnjjTStab0OjsplPQaZ7LkgZOvsgijUufVv1RxrJfGZrLnSezZHPZtd2Agdsz7m4KPO/HNzwjwjW/mSEItv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nfThJO5oXB7WZ5MAEjom4iH5WGBmI4Q+rtCNbUu5Yk=;
 b=jru9Buf0J3wMXBejUgZsCGHQ/0rZiBYe1DpvQoot+R0v/nfAAOV+6fqdN4F3lD+a0CoOp4SqYT1VfpVix8wxcoz6hhRwf90Rn0hi9en6fd9Jp6J2iL41Lf9lV3X4w2mjD1aWDZ/9KdGi2Qcgw6DEe2TWmvWlLn46txevF0XkhgRwNo23a0rT3NnU5fAXAXPiUuRQyaNZDCGeLC0UOOE/8tYra+E/j23qZdIiOIqx2QS0mq2EF9apaG/9voQMPi2JxKHAY2DQa0hYi8/nxJeBdBqEAf9m5zEHo55Lx7X7XV9XcKYSEvTWCz+Kjqx+sXWUfdV8t0rvetc5f9erk9YO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nfThJO5oXB7WZ5MAEjom4iH5WGBmI4Q+rtCNbUu5Yk=;
 b=b9c82RExcf1RnnikKrAQGMZcB4/oxSz734o/QCO37bVaxpG4WqGvFXtJtJdW8YrNJDdvZO2hjtngNScLnR0XZth03GMScQUQQ0yuMBm0Tn6FiAmrSmTTUGzW6orDysQ/5J9aJiAEhKdVhgZxKeUY8iQw0hPB9Ps3toH89fMztXs=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by DS0PR10MB7175.namprd10.prod.outlook.com (2603:10b6:8:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 13:20:44 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b0) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 13:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:20:43 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 08:20:39 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 08:20:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 08:20:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ADKcqt3128000;
	Tue, 10 Mar 2026 08:20:38 -0500
Received: from localhost (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62ADKccc013573;
	Tue, 10 Mar 2026 08:20:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg: Fix wrong macro used in RX classifier configuration
Date: Tue, 10 Mar 2026 18:50:35 +0530
Message-ID: <20260310132035.1299787-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR10MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3a51cc-bd82-4a4a-f05e-08de7ea7d55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	FsXUmvAFPWzA/8Jc/TsuH89vym1Zi0AJ5jstGTmOl6w62UPLbRuDDJVMSsmkdYGy3kxx5huvgPJ5XIDzxuzk62KpvBuQ1eLZTKOaJNAMkLxAbJ3CUG1Raaj+nsYpLEdqK99qyvmjsjdBHU/2tCE/CPbZH/08YU22/ydgc18INWSip4ELcvkQInpNY8HqB5Yms3IAWlvTQ2tiE3K/nigyOjztN+j70AZedcbz501Pj8ESoZwFOJ7EEJ+koRIUJM4Dcw4TgJRN9Hiky+XS/DSNpR/wI2uclJC60gLe0T8QOhPY7BzcdWRI3jx/6xDyENp8bZl5d4ka6l8c24fgmoSj3iRQ2JMeIcqvKnzmVdGX+G/VDy5CkweI4LulE394YI9jJkC/hQqAYCkP2E49nnrcf1m9LQCQ//e0RiQb+Vx5N5KTOI5xLMjPYqaBXPetTRac8hMKH8+ElfRVvQQgQ04pEaNCh2Su1n1DU6y0E2wn+zGpHz6Zpb7sjujj5MsyBOhx4VFWiWQSaRnvCvlJ4ZI0lgz4dCLYP2on7SipurbMOz3h53yWTz/09ex4qbjhNaIpNe2T/8/hST8XLcGFJNQe+HsCsONj+6Mj0QCZ4VXDBtpSRywuF1dSqBWWB8w0ZWlRihyd2eSnpkRTCJdSWpp9zT7INF0NKdeLIpCtXICyBV1IM0u90ZX1uESPTNC1YXWdXbnRjR0cI0W7WUGizZqydtpfsLOmBmi9EpQ0knxft71unxMFI5lXE0pRROEJz6xjSubgNJcWeDqZRTzxNiyAaA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H7zGWnmRO+C1XF5Ckq4O1nV17oHetCqgFq/Hm1iLqD+/3uHaoFWtNfCeUa59/G/c7ZvEV1PDT9QEsk2xE8RhCiiC4TXFgs5pfpBH5n1IRF2YGWTyfshPeFKhbjEBbBxFUhWG2sWaJO24QSU5Hm0ve0TUSPD/QiZt4pZI35i/6QPccfoYtGH0iX3WcyYUkg6U8KyaKUPjtyax52OkImJbVDoLdv+mecBDlkvt+OvMIVM4cUvdXM1ZgF1Zi2+BfKlNtR18DJfegZRGxskvbUIDdlAXlcLnUbg4zswegeHxJ0uFoIsF6+mjeSSSvTXL2K+x3lOefHKP3ewa4bEyXMeZKbzDAbgfgn6xpSBKhKWCfQgD9kkmelP9yVQ9boRBtAYDLu2dyVTuMW6PJ8RHoEv2jGVejC799gsRNZA8Ub/adr9FwEU6IZIF0XwHSw16p9uZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:20:43.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3a51cc-bd82-4a4a-f05e-08de7ea7d55e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7175
X-Rspamd-Queue-Id: 9949B25156F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266143-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_COUNT_SEVEN(0.00)[11];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The RX_CLASS_OR_REG macro is being used with RX_CLASS_OR_EN parameter
when writing to the AND enable register. This should use RX_CLASS_AND_EN
instead to properly configure the classifier AND enable register.

Fix this by using the correct RX_CLASS_AND_EN macro parameter for
RX_CLASS_OR_REG when configuring the PTP duplicate and HSR tag
classifiers.

Fixes: f56438a74d88 ("net: ti: icssg: Add HSR/PRP protocol frame filtering")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
This is a fix. Posting this to net-next as the guilty cposting ommit is part
of net-next tree and it's not part of net tree yet.

 drivers/net/ethernet/ti/icssg/icssg_classifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index cde53d9aaa7b..87a8577093db 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -517,7 +517,7 @@ void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
 
 	regmap_write(miig_rt, RX_CLASS_N_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_AND_EN),
 		     RX_CLASS_DISABLE);
-	regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_OR_EN),
+	regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_PTP_DUP, RX_CLASS_AND_EN),
 		     RX_CLASS_OR_DUP_PTP);
 	regmap_write(miig_rt, RX_CLASS_GATES_N_REG(slice, CLASSIFIER_PTP_DUP),
 		     RX_CLASS_GATE_PTP);
@@ -525,7 +525,7 @@ void icssg_ft3_hsr_configurations(struct regmap *miig_rt, int slice,
 	if (prueth->hsr_prp_version != PRP_V1) {
 		regmap_write(miig_rt, RX_CLASS_N_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS_AND_EN),
 			     RX_CLASS_DISABLE);
-		regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS_OR_EN),
+		regmap_write(miig_rt, RX_CLASS_OR_REG(slice, CLASSIFIER_HSR_TAG, RX_CLASS_AND_EN),
 			     RX_CLASS_OR_HSR_TAG);
 		regmap_write(miig_rt, RX_CLASS_GATES_N_REG(slice, CLASSIFIER_HSR_TAG),
 			     RX_CLASS_GATE_PTP);

base-commit: 89fe91c65992a37863241e35aec151210efc53ce
-- 
2.34.1


