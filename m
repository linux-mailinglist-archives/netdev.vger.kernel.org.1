Return-Path: <netdev+bounces-266236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJtlOPZDsGlLhgIAu9opvQ
	(envelope-from <netdev+bounces-266236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:16:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945425473F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15663311D23F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A53BFE35;
	Tue, 10 Mar 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HRRJiVRY"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87F3B6C04;
	Tue, 10 Mar 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159074; cv=fail; b=VMfKaRW3gOyb4YhRj0E67CkWydHvJMAepphB2YVBcgRRAa+J1QttwUzkYeY/I1hkkBSj3Q08OJnvrBoKcUQCf4HlSPIKqz1qWppG3xgRzyDD8XDPaWGOElSrGezvvv+TC09LMh6id70K5LlklqovYeSIKY191sJKOitgMaJA5Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159074; c=relaxed/simple;
	bh=T5unsrFQkHGJ/Gff9Z5RAYIHlhQDYB16A6DU7nRmID4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ur0aO/ZXVdC1iPtsYx7444J++Y2uqkcZ/gZhrMLn9ITJ0ZWVaFSUL+ANkqzJ2MXDD+zhaV7w9pxkaVAhTmNTtUuGnt/1fMT2cdpCHl7MFNj++5Lfck8D3saSeBx4Hn3CvXQ/KO4EVBt49Is1pP+KX+5uKQCMX1t/gqCcpi1zj7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HRRJiVRY; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWdRbMRo/Lb8f3xgWR14SCOT5/bKfV+ITtMWLmymmoERlNOzEXrtr9akGz8Wot9Sv5WipFvTYEUry9WkLLxKFMIX4zMKHkTI1Kxb9KMsBoZaN+qyI5Pf6p6yenCnwK0pxvUkzCCDxJ3GxWTNQ9Mvj3lOYFcC+usNcUnTG3xNCr6XM7DL6q+fkspGRs0q2WZ2DYmN3fAUgmYMJkTZ6YedcAcUzuVGxc3BMwnqCL2qGMLAq6sBIKc3DSHTRuInUWHR3hKluQ7pYhUPpiibtDOtK7iNUqRVH0y9JHAwK0c/W2iAjQZngzJn4eNzTatkXFjLQvsZhi66poefvXkrkCxHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1qF1AqEwHnhxzHeyLG6Yuwzl1HA8II0IuNrMU1YHsA=;
 b=dXjyyNNHYVihbkdXhxHRTd/hHOmSIUDaoDPd6/nobrHqWYTBH/zW8ChTPVcClBXBrG8MjJMEXGyG96zRr+5DKoStpO1N7d7N2+1EA+NvmgvcRKSkfvrgE857tblzdLttriYuuQxR8bpmUvOEu1l0lAAeH2lFzAcb5CMWLvx5uO9jwju3cNjtnUbPvD1vi4FX3VUxTKQJe1OP/qU+p+r9YEiERFnIBU3j/WMwmiBRWL5E5RKm3ll5RBCHK2o5AxosIOPzqSegI1GYMC+YTTVaSdSC1T3ynr1ntaOMfRtkUn8w7ZxpqOITOE2g3W27TUHst1nlvctF8RR9rni6Qh5+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1qF1AqEwHnhxzHeyLG6Yuwzl1HA8II0IuNrMU1YHsA=;
 b=HRRJiVRYKh8G/r4tC+FQQD4nKaWww9ZGXiyLLojBgw1N29UF1mazb9Hn9NnAaCIfGfD/NwsBx4d35Ko6CAqXYOvXg7vJ/PytnKMTyo6jFOQalHm4/Wx+7acs6he94NBXE2EP++YyAnt9IMYwMlvQo3eUw+CKgXno8IBVI9ik880=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by BLAPR10MB5026.namprd10.prod.outlook.com (2603:10b6:208:322::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:11:09 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1d) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 16:11:07 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 11:11:04 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 11:11:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 11:11:04 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AGB3BR2867444;
	Tue, 10 Mar 2026 11:11:03 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Chintan Vankar <c-vankar@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Michael Walle <mwalle@kernel.org>, Nishanth Menon
	<nm@ti.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vignesh Raghavendra
	<vigneshr@ti.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, "MD
 Danish Anwar" <danishanwar@ti.com>, Vishnu Singh <v-singh1@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value for PTP support
Date: Tue, 10 Mar 2026 21:39:40 +0530
Message-ID: <20260310160940.109822-1-c-vankar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|BLAPR10MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 6966cdf9-0175-4f4a-3465-08de7ebfa347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r4UgYS8ic2YBjFjEacFn5RHUVRmnFNA1yu1nFcJBKtpwfML78cql1Ubih4u1oRoJydQkJdaxB3xfkqN7iBERy5Xn95cuHzZ/9w/R+V+wXgWXlNn1VRXN6L0hP3bkiPREi892+9DhHEfzZr3UKY/iD7x44yCmfL3JstCR4HKQnEa5CjrQDtOLEIQzdiKLijtTGH1N2Otzg7Ig6uQXqYKqPik+Hz3k4tCEYlSeVZWQzftK7bO8cjE6wv7SAQ603XsaPbaYmocv6fiUQV6Ab9OqFA5bJ831FatqvqtWQ2qumGVhxHPvUIyz/nl3mX1VoOaSbW4dGR6alY1U1yWQOsJDfc9SCtzlCZe+CKFXWkrWZ7QTlz/t6XZNCWOYDQjkfM7r5Mv4WY5EwzvolGfhQOf/GoO3lggW8uCjajCvUJnIcHJzQrruQmER2dVMwaBbAHMN+C+76vXWAEdyYWq4gYloChcVOl3SwHFEZLFT4FgfAdth6DAcFGvLBsqQIOwH004cymOryVjgIWfsf2AJnBfFva8D6JbYIUvY2sswYKFuIw1YTsdVW9LSvqdG8lHT+UsnU9pCC/mfZibLPLmoeXCNhhYUvnRfVQEjE/vS0HQdyafaY7zRW45IQROAEKH+3heUsrkX8Ncy9nZtYmC2MXxR6r0tXbXZBFiTvkykpNpehg/fX9ccbTZOBLypFaRuXHi8VWzzOz9lt1xlBM29bFEsyiJOIBFPNQ+kb/n7bHws5pfLW5tfnp27NJu9m6yxDiyWYBcI+KPZ0KwlSI3aruw5o6P62SG05n3tnT0UOT+yBOWImfE9NX9fWhqB2UzWk3GX
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/2J+Xw6PL9pqHamzLzoR8db5l9q7RAE6gIwUjckjQn46/Dix6IQ7I4f+E04z+pLxB8gTLK+K8v3P6pA3YBxEe3eZj3sVEsrOAA5PquGJIYJVniXWMGlNZ2k98O1jnLKu3QzgFthvVTQHiHMeT4tafwl+BGpn06u/OGVQZV+lkNXOPwshCHvK30sJWzUVbPcnOFUkrfqb8j0mJ0TOJC4KAkd2Idb6f59kbH1+hQe6s62sKUM7r7uuXM21tlM0PqTxOOTtp6Gi6JcSV/2rkf8DfNmOb3FFhzJEWjZmA96iCC05tFfUJ9Ytm2sGsqNCKokvXOJwCIldv06+Ed5yDqXoQ1RHfRR23n5jYVAW5eRjwojylY9abpfpk743s0o3az6S2HjAjzVlrrr2OFJmZyFCC4TsrWKe/nmzaf4ycexPXlcYykFK9L99Tl54UEXKGjpa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:11:07.5031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6966cdf9-0175-4f4a-3465-08de7ebfa347
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5026
X-Rspamd-Queue-Id: 6945425473F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266236-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[c-vankar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

The "rx_filter" member of "hwtstamp_config" structure is an enum field and
does not support bitwise OR combination of multiple filter values. It
causes error while linuxptp application tries to match rx filter version.
Fix this by storing the requested filter type in a new port field.

Fixes: 97248adb5a3b ("net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit '0d9a60a0618d' of origin/main
branch of Linux net repo.

Link to v2:
https://lore.kernel.org/r/20260303075819.3246032-1-c-vankar@ti.com/

Changes from v1 to v2:
- Updated variable name to enum to avoid creating new redundant
  variable as suggested by Jakub Kicinski.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 16 +++++++++-------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 967918050433..265ce5479915 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1351,7 +1351,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	ndev_priv = netdev_priv(ndev);
 	am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
 	skb_put(skb, pkt_len);
-	if (port->rx_ts_enabled)
+	if (port->rx_ts_filter)
 		am65_cpts_rx_timestamp(common->cpts, skb);
 	skb_mark_for_recycle(skb);
 	skb->protocol = eth_type_trans(skb, ndev);
@@ -1811,11 +1811,14 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 
 	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		port->rx_ts_enabled = false;
+		port->rx_ts_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		port->rx_ts_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
@@ -1825,8 +1828,8 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		port->rx_ts_enabled = true;
-		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT | HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		port->rx_ts_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	case HWTSTAMP_FILTER_ALL:
 	case HWTSTAMP_FILTER_SOME:
@@ -1863,7 +1866,7 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 		ts_ctrl |= AM65_CPSW_TS_TX_ANX_ALL_EN |
 			   AM65_CPSW_PN_TS_CTL_TX_VLAN_LT1_EN;
 
-	if (port->rx_ts_enabled)
+	if (port->rx_ts_filter)
 		ts_ctrl |= AM65_CPSW_TS_RX_ANX_ALL_EN |
 			   AM65_CPSW_PN_TS_CTL_RX_VLAN_LT1_EN;
 
@@ -1888,8 +1891,7 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
 	cfg->flags = 0;
 	cfg->tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg->rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
-			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
+	cfg->rx_filter = port->rx_ts_filter;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 917c37e4e89b..7750448e4746 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -52,7 +52,7 @@ struct am65_cpsw_port {
 	bool				disabled;
 	struct am65_cpsw_slave_data	slave;
 	bool				tx_ts_enabled;
-	bool				rx_ts_enabled;
+	enum hwtstamp_rx_filters	rx_ts_filter;
 	struct am65_cpsw_qos		qos;
 	struct devlink_port		devlink_port;
 	struct bpf_prog			*xdp_prog;
-- 
2.34.1


