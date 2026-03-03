Return-Path: <netdev+bounces-263067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YInFD2yVpmnmRQAAu9opvQ
	(envelope-from <netdev+bounces-263067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE11EA7E6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39433040202
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8F38238D;
	Tue,  3 Mar 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S27LxLiw"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046883750B5;
	Tue,  3 Mar 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524723; cv=fail; b=Q1WpCgz5BN4Dzxew+svsEcCJxcWXjStDojPD3PGElG3MPlZjQ9Mb4WrpdUYwCN13q+2P6mZNLDCvFoZTOULn5ivVL8m5FeCayHjUF0jeipLgsMvwAQwM2uMtz0QaLrQiqD8JWNswTOAl0XFKzTtCouQl80zk6c3vbUAt0sA27F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524723; c=relaxed/simple;
	bh=xkeckIsLTTuXmCwUTGdu0w2oBb3nQQ52CjK/5Ehx70U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fqcJlY+m9P7oOeRthE79AUArDVqlrJSNE2NDMna0cppAQ9KlZSIDjUsdLyGQjTv0c8SfIKnYE05VnUVodJ4Nu0h+CFcovvS+O+mvgy9XhCkBukMcorFBMw9Q6FMIl7sA5LCdCA+loxl0q2eQ3vmHQW1jjY5518830Dk+mxyp8wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S27LxLiw; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa/Tdtz69XEpa/VrcGhj+zX0h9swY5ObUL+dnZnqFHQvT30bBzeU/w/Tw+Qzjg7iYqcC/zIrJPW10chzdxCiZFkTTnOaNt1HgfiX82Fv0d8QzwYqwtrxtVkQHfAqA37LN1z5fjaKB0TCTRbpCRpEw5BVwZZN2yekRx/cy+3Y2sDen5tn/o72vFkm5m64hh2bg9LxTiAQs4S8TlGhPYKsFDMWtxPVPUMPpAKQHlhouttcliNb606Xl+oNEJHkYQqofHU+gHDEVemqA29lOkAEHEANbBYfpRVLIbSAJiAoHWtC1A15q+lWCky2sERvWU0nDFfAkpNNRrmmZs1q/GZ/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLaYJOIPhc+rGQeBsSnnAEC6ltVXttvS0+QCmKkg2kI=;
 b=K2RWFuaRQDU9PMklSclexacsdNPhA30BVqRPlQqzptC/x2ueaObC7ug9740+LJu+Uyd6sb7eUqtPGzCafAmFyC02z3f9siAIUohyenNT1uBipejnh6sRToduSupuQCAWmvEkp+/Yv+7U6dzg2thRVYPp8uAJ9k7Qssju/mdZfgGVQu/2BH4JM/IXhhkl4JMrIg5TH3WQTDw6YXrRNAzNM71mYMaiFzEGeDCF+WIunZP92FNTIP+dfrqIidejos/HRKvSX40++KeChamONNT2CvGebAigdYkxNVxdDBmjvpj0AzBp0URZ9uqbEap5E4KdlaW+0hSFEAXEkKKrIYj+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLaYJOIPhc+rGQeBsSnnAEC6ltVXttvS0+QCmKkg2kI=;
 b=S27LxLiwXjbSFwe3K/RSXII7gK+t/lBpRHqiZgxCfbw3Rwv8HhuE4iya3IeS+/x2FpxKuDPtqNq02Xvl5Jv6VCOroLI9gRG14c89+WXfvRa+p9HZxP/Ot92ypikUnZ9aSsWvJcSNa3DS8LqlZaBieYl4VVpJdHPz/Wq2uKlDd5s=
Received: from BYAPR07CA0084.namprd07.prod.outlook.com (2603:10b6:a03:12b::25)
 by MW4PR10MB5702.namprd10.prod.outlook.com (2603:10b6:303:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 07:58:38 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b2) by BYAPR07CA0084.outlook.office365.com
 (2603:10b6:a03:12b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 3 Mar 2026 07:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:58:36 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 01:58:23 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 01:58:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 01:58:22 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6237wLNN2243073;
	Tue, 3 Mar 2026 01:58:22 -0600
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
Subject: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value for PTP support
Date: Tue, 3 Mar 2026 13:28:19 +0530
Message-ID: <20260303075819.3246032-1-c-vankar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR10MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e6668b-9373-44d8-b239-08de78faac81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	8WetrwOXWehpI0QSFCi9eiKeeAE1cmKPaKiOgxfslEgnuRSxiLTB9tbOIjMOgGZijSOpstIh+4QV+ACiRno7wzMhD5NxFbyOfeAz+9/QRahF04pyppWMEUpJVdyLwivxzkKu7dRLHZcxE8bdhcR9SIoPpl9ztJdK1lIZCx3snS75BGnc0KjMlI7UVuz+KZaJ8ntLHbnOFbQQKLwy3VDZ169L0DzkRzaUlchtbMsB/u0Fv3DoBcAiHG4ZdUDlGvQILao/gJ2uE0x6fITmvlAdHQioEBdNGYw5dNzA5CvDS2pbqBxVpy3vELoDM83xNABKaVptrUF2Jyol7KowJMnAKDyoFuvnHNRktT792aIYtgFtD5NEkADaOmNDsOP8wsuK3lXIiiFpWUt8+3VIVqe8cAfuNly9TdXr1iAAa83HXel2aAi0hHNAnea90WaECQTpSE74krrHA4gQgjgcbk/QOZTojQnXJko+JVQJTtYRj3HmU0+oYEAhbPm9o5zkz37760E9fvO88kywKUz7mWyXbgNgBccx4s9bwVtzb6HyOyOq6WzNJ0tpal2PJdBUO8V9ycHx8ng334kLfbrod4Kpz1fVlwiQyOhk9n/8N/s8ZCdvtb/Fa6r9rhupEOkMvnsBpftA9s2NK0vjHntioKkUNYrNbrFJtDWgi7gFe0XC7x2o7u4E4GlfXD1deggeRsBSIH1FN+arb6fLg5VB5+ASjXobzjqlmisSL+rgwLYHBO47hMuVgmPPVpTt+nkpiqBZIlbrfuclH7GkdOyA1n7L+nv1p9FOVavLw63M4Q8j8sQO6kOlOCEUtThV5E3Z5OsgI55W2O3026urCik29IfNzA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/dfwBe5ZHRl1g/Qgs0nYcZq79zCJjz6MphIgRk9lg9a+G4jV2L1MAGxZzEXwvs8rDDroPFPEMVmYUnBB/xuAEhor+DotyxHjjt+jZbeZAUvqf1JQroXkzEI3ELXMggb0XifraqMLNrSx6/bWX9JqTtHolq5Pd+K0tKwoKSIGxc8Xz2OtobyQQwurRl7YcgIyAGTs5sXfIlgc1myb3e662cH/cO6oipBO06VzUo2Sfi24S64fUp8RaTZSxJKDdsOhT3hGuccBsejHRZyN3kWkO9kVzVQ/7Aa4yJ1Xe5cum/xLlVMgY2aooKilH81N/A5LkkX9EDEfdTNv6nQK7X41MnPepyJ87zVWuTODThhRVE/uWy2gjdbH66LPtr1N4TvS+PwP+/iAUj1B9sXCptdYJb3oxM9odVavyczCaeiFSky/RrpQf/TG8c7dtL1F4kjx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:58:36.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e6668b-9373-44d8-b239-08de78faac81
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Rspamd-Queue-Id: 4CBE11EA7E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[c-vankar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

The "rx_filter" member of "hwtstamp_config" structure is an enum field and
does not support bitwise OR combination of multiple filter values. It
causes error while linuxptp application tries to match rx filter version.
Fix this by storing the requested filter type in a new port field.

Fixes: 97248adb5a3b ("net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit "1939d9816dbf" of origin/main branch of
Linux net repo.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 12 +++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 967918050433..a10b055b0262 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1812,10 +1812,15 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		port->rx_ts_enabled = false;
+		port->rx_ts_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		port->rx_ts_enabled = true;
+		port->rx_ts_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
@@ -1826,7 +1831,8 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		port->rx_ts_enabled = true;
-		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT | HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		port->rx_ts_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	case HWTSTAMP_FILTER_ALL:
 	case HWTSTAMP_FILTER_SOME:
@@ -1888,8 +1894,8 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
 	cfg->flags = 0;
 	cfg->tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg->rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
-			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
+	cfg->rx_filter = port->rx_ts_enabled ?
+			 port->rx_ts_filter : HWTSTAMP_FILTER_NONE;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 917c37e4e89b..595123c155db 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -53,6 +53,7 @@ struct am65_cpsw_port {
 	struct am65_cpsw_slave_data	slave;
 	bool				tx_ts_enabled;
 	bool				rx_ts_enabled;
+	int				rx_ts_filter;
 	struct am65_cpsw_qos		qos;
 	struct devlink_port		devlink_port;
 	struct bpf_prog			*xdp_prog;
-- 
2.34.1


