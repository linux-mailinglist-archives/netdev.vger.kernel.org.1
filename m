Return-Path: <netdev+bounces-286962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Da4IpzDAmq5wQEAu9opvQ
	(envelope-from <netdev+bounces-286962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AD51AACD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AD683022BA0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4643D4EC;
	Tue, 12 May 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fgw2kkNe"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2442B732;
	Tue, 12 May 2026 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566018; cv=fail; b=UcmoIoldFtj68uqnNGUlwX4UF6Y44Zt4P+HB0CxsI9UGtIGMs/Z7v8BPQN+2LCrBdqhjOcppwbWYtZ08nkeY0LRxd6PmfV4Ba95fGWAkJViqYRYaJzwjBs1ohE+IGD8MxD3fmNiEeBOpB5Yz9NHJWtXjx1Ul6wOmL43Hw/0m0oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566018; c=relaxed/simple;
	bh=8qt41ORbi5mnMozIhMHKyhj52qabdpC3w8lMjUomJz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIsLOPbbhE8CzJmRI42XCVjCyRrCkCpFGhKNRXTnHD2Xa9C7ydAcGAx5KAoYmb4HZx3XkpoRDxTAVgr3MUx4PXjkEKXqAn0tqvjekVS3p2cAlEOimXuYo9F61TruRKPfFBNs2iu7w7EnO0ETvpUGFLQyrHCZawTQUtmTe4nFaM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fgw2kkNe; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJys44lwBMon5CwIeXMWpE4q25SFZIzOtOGA+M7+z3Pmngt86gGTM7i4oEOwn7DWPY9IP3eEgVVyB8cLEmhocjCfEyvnmC4TFJyEHbAhQuKIfvtQ3Ypt1nXBzcJzy9SXi2c5v682Kcpio1JL40ngWgieK+nUqE3NmfIYqpM5ux7j6ALrC0fYa+sr5IALv3+Py8CaRkFZiDuzzC9afS+lZe3NJyox3KnS07sGKpBbYf1DwaiwtGE8perTY99jiShBmyFd3PPsdYsGnzi3o3ZcG0l35UnPt8KfQLXm+rmL/p096zA5aCusFP81nzfxrhnAcczw0+i9wB0vXy2K74idgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fcrJadT7W6v+hMSnEjgUHAK9SZBnbuQcyT+WI+mDsQ=;
 b=ftSM7tfnByd5DOLDDmct+59kwB8WT0NcK/LHu0XMi5az/r6hhrQgiYhnQ759Dj4kXMnHmBkeINDsuOXvDlnbEJBd8sERBYbHHHuw+KJmbd0f6BXX800Q8z1g97s/ih3QHJlJHthu1Uns2JUGWsBKrGdKbzl0sUqrfG8pmigeeafbe/eMvYvRYLo+Y0XoFoleGDfv8a/XL0vizzhlTwPHvv3FYY0rZPvLCsT478na23X0puvj/pLSOj1tAmGO9TaOlW8vNqUlQVqdwG2NnsbnUbUQlRz0qvaHaqDYCZvL4akRDkSihRsB3ms+Sfbwfwo/B0WE3+UwN3RFr3qqX8cMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fcrJadT7W6v+hMSnEjgUHAK9SZBnbuQcyT+WI+mDsQ=;
 b=Fgw2kkNeIcHrs8xl46RaIhU6KyLQw9RlBd8AwYtQahkTVFmZR5XU+Um3m+JlWIxDB0o/j9ebxdZkWNA1Uprpq16Xl8tmHvC4yj0zSeuP0IkkblCOQa2YAuploWzHaaZH8zrt2VnDuljPvd+isP6nKv+a2m9sDKoEbhQQgJJi7JE=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:06:42 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::71) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 06:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 06:06:39 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:39 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 01:06:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 01:06:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C66dDE1179576;
	Tue, 12 May 2026 01:06:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 64C66b51032010;
	Tue, 12 May 2026 01:06:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, Kevin Hao
	<haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 2/2] net: ti: icssg: Add HSR and LRE PA statistics
Date: Tue, 12 May 2026 11:36:27 +0530
Message-ID: <20260512060627.3781329-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512060627.3781329-1-danishanwar@ti.com>
References: <20260512060627.3781329-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: f35062ed-80e8-449b-d336-08deafeca228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QQlRkfZIXY+fq5dTMtfgYuhZuU+wv8PA9/67GzYYCMbG/a6OPDNaQRX8B3V/GinHRMs6qUn+djyGxAYs5BIMsG8FjOG2veAjopbNKT1EvM+w4TUX9HO990drfMN1AXBf2iUueEgmAFZLHnYEW9CNAB0fscnw5EU01L23c56aq973YosV5j4A0/Z2J0fKy/hF9SN1qF3N+ufRP5tEy6fvGri+QglSzznq1G4dh27mTJLEffc2NdXIT6wqPSgjGYs2bN840R8Mws/65sjF1Z0KSp6OaLrIfg9pkc2/DUVKuAQdtEtzGcJQ+KWkLbezoVkMzj3N4dJMGx0MSwI0eJZCjwZSfIgIud7S9j3T9EbuZPl7KWyWpWLh3Z69wSKYfXvYZ/OgDfsDFI8t07ZDH8lbUb1JmNVB1Qdhe2KjWiMwN8UMA7NvhfQblg+U5StdVfB/NewgryFdN9CWaF6q822W9e8tQ48PQDXXftmWlxbU+zogappJaALsMml/D6yxZWubKyLz1KrSbWrwSwmgYvvgliq1bTdeTeP555NsIK3P4zhszDvAAtG6aS9Y7te+ZEJvpHSMNIl30lQerhjDStnfdHFccX2/OsjljaFP+NSF/IydgFf7Y/RisKlaoMAV9k1kTiARzrHlXQoGVYXcu02Hj9L3SjO5xm525C34LsZoMwjNZb3cc9ep70tIDc3byxPhwvWczgFnxNkTHH33us5qW0HRjvWGRYYRd97zCHhCxrkZEASEIIha6niHJHSuybx5uEcgUSq+ofFF5myMf+7diQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pUxHLWR9G/V6w0JEClGocjUiCVrzvbVBlsS0bkUo3/vH18UHOQ0Oz2Qcgih265bToktoCqnJp2mKMADxCU8JdRilwY5gsuNx/7E1n5Lzy51noNTbwh379ErognTuonkbLwsWsB+bzfa5lSgADFhlAGgX1COyd3FBLn0fFSa8XjHR3qzglEgCQxcXfvLAyyRihBz8VOwnB0yPfxxHCU88S6OTx3nvbpmYv/DRZ4CxZqeGA/aQnRgA2H6+7SYmfE8zCSVf6foemMqzj35qabPqcj5hq/NgfwOMDPMCAFtpchZhdc9pEOJasmXM7Yi1nhpTcZ9o3i7OqLy6xWf1DCodjPnBK0VKV+Fw1JmAeFYsR0M35Czak/mt8z2sT7dH7rFm3P8e+TJ/8DXV+l3CotHdER56xWq8sCDwNXYpM+VSB4LjXGREHjyKjoPyKYPAimq3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:06:39.9600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35062ed-80e8-449b-d336-08deafeca228
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Rspamd-Queue-Id: 480AD51AACD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286962-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:mid,ti.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Add new firmware PA statistics counters for HSR and LRE to the ethtool
statistics exposed by the ICSSG driver.

New statistics added:
 - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
 - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
 - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
   skipped
 - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detetcion
   counters
 - FW_LRE_CNT_RX/TX: LRE per-port frame counters
 - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
 - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)

Document the new HSR/LRE statistics in icssg_prueth.rst.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../device_drivers/ethernet/ti/icssg_prueth.rst        | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c           |  7 +++++--
 drivers/net/ethernet/ti/icssg/icssg_stats.h            | 10 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h       | 10 ++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
index da21ddf431bb..b0bda7327b2a 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
@@ -54,3 +54,13 @@ These statistics are as follows,
  - ``FW_HOST_TX_PKT_CNT``: Number of valid packets copied by RTU0 to Tx queues
  - ``FW_HOST_EGRESS_Q_PRE_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
  - ``FW_HOST_EGRESS_Q_EXP_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
+ - ``FW_HSR_FWD_CHECK_FAIL_DROP``: Packets dropped on the HSR forwarding path due to failed checks
+ - ``FW_HSR_HE_CHECK_FAIL_DROP``: Packets dropped on the host egress path due to failed checks
+ - ``FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES``: Frames for which the host duplicate discard check was skipped
+ - ``FW_LRE_CNT_UNIQUE_RX``: Number of frames received with no duplicate detected
+ - ``FW_LRE_CNT_DUPLICATE_RX``: Number of frames received for which exactly one duplicate was detected
+ - ``FW_LRE_CNT_MULTIPLE_RX``: Number of frames received for which more than one duplicate was detected
+ - ``FW_LRE_CNT_RX``: Number of HSR/PRP tagged frames received
+ - ``FW_LRE_CNT_TX``: Number of HSR/PRP tagged frames sent
+ - ``FW_LRE_CNT_OWN_RX``: Number of HSR/PRP tagged frames received whose source MAC matches the node's own address
+ - ``FW_LRE_CNT_ERRWRONGLAN``: Number of frames received with a wrong LAN identifier, PRP only
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index a28a608f9bf4..e7a51a9eee24 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1633,7 +1633,8 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 			    emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
 			    emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
 			    emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
-			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN") +
+			    emac_get_stat_by_name(emac, "FW_LRE_CNT_ERRWRONGLAN");
 	stats->rx_dropped = ndev->stats.rx_dropped +
 			    emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
 			    emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
@@ -1643,7 +1644,9 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
 			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
-			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER") +
+			    emac_get_stat_by_name(emac, "FW_HSR_FWD_CHECK_FAIL_DROP") +
+			    emac_get_stat_by_name(emac, "FW_HSR_HE_CHECK_FAIL_DROP");
 	stats->tx_errors  = ndev->stats.tx_errors;
 	stats->tx_dropped = ndev->stats.tx_dropped +
 			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index b854eb587c1e..af3fcecac403 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -204,6 +204,16 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
+	ICSSG_PA_STATS(FW_HSR_FWD_CHECK_FAIL_DROP),
+	ICSSG_PA_STATS(FW_HSR_HE_CHECK_FAIL_DROP),
+	ICSSG_PA_STATS(FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES),
+	ICSSG_PA_STATS(FW_LRE_CNT_UNIQUE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_DUPLICATE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_MULTIPLE_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_TX),
+	ICSSG_PA_STATS(FW_LRE_CNT_OWN_RX),
+	ICSSG_PA_STATS(FW_LRE_CNT_ERRWRONGLAN),
 };
 
 #endif /* __NET_TI_ICSSG_STATS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..bd2d54dd7f45 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -266,5 +266,15 @@
 #define FW_HOST_TX_PKT_CNT		0x0250
 #define FW_HOST_EGRESS_Q_PRE_OVERFLOW	0x0258
 #define FW_HOST_EGRESS_Q_EXP_OVERFLOW	0x0260
+#define FW_HSR_FWD_CHECK_FAIL_DROP		0x0500
+#define FW_HSR_HE_CHECK_FAIL_DROP		0x0508
+#define FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES	0x0510
+#define FW_LRE_CNT_UNIQUE_RX			0x0518
+#define FW_LRE_CNT_DUPLICATE_RX			0x0520
+#define FW_LRE_CNT_MULTIPLE_RX			0x0528
+#define FW_LRE_CNT_RX				0x0530
+#define FW_LRE_CNT_TX				0x0538
+#define FW_LRE_CNT_OWN_RX			0x0540
+#define FW_LRE_CNT_ERRWRONGLAN			0x0548
 
 #endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */
-- 
2.34.1


