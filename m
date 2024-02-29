Return-Path: <netdev+bounces-76310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12786D366
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DFB1F25A81
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEE1428F1;
	Thu, 29 Feb 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V1isUp0A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858881428E2
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235623; cv=fail; b=PIr1sqpC8ZWL1IsGB5ty5w9PC0SzThOsvvd8k1aPLTeMRwdGNFA1APMSV9yyUibNn0hO5tgJT0BvBR62FudpUEfwD9Qi/Ycss8JnB208+rri3tMRt8qcQvcmtvN30UKeXcwKgvaS9K5zVSCU4gLXKlUpvCxpf35h/V9WP2VIUO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235623; c=relaxed/simple;
	bh=4LbKgwdpuaXnkDWgx3PucuA8Nsp3Ghy/Oj/68CNAf9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kew7eAgiGcvMlbxJe4EWiY+IZChzXOqqkpI6ZsuKAkVJpv3BRwbk5J19VlakUxmv7pRLY/QF7ajiBQrHa9hjm6H8edy2nzgw9XSszu66HXm2l0cfezlzShyrC4PwGfnGs03vuWU2nSzmlGokD3upTmQR6BeUq3xUFsjY3cxKh7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V1isUp0A; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpLfLyneKHXvB2Dq/E3ziGYfVSlNB4tBReTICHnF0noriMGXq0smL1fVjXR5/LkUGvCMlJMaLxdVvWf9ImDc2QiowyTXPKGuD3m8f2w3dyBPNYGqndFKic4+mIuNIbzDc/xzXZoGk+dPXPYQovgHu2LjIVBu29ZRZCZNZXuoNMYiaO9caJ+S0qhL4RnQ5qiueldQ5fHZf3RcJMRcVOUfN5uG19yz97T6H1H0suMXruF1GHcZSHTM9xVRdnF/65fgvqNMOqeyp0dgbve35bm/zBjrfNlAVGEcm4r+Cp+ayYs2Qsq+zxPdUEbUKp7DRLIkByMQeeUCfEJlmGe7FAEIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMGUAyH0G5WjhSJieUp1NGj+VwOPq31WygzJOCGHuHs=;
 b=Vq3NDkcHjSudH2eHzabtdJDDErtDETW9QhJCJYIMOkj9MAJv1rqnkPkqqu30F+eboiPrJRN9l9adYyE4u89hRjZJBjn82TptI4I/9ITiSna13U99o+eX392jMNDiGtiBe2q3O3z7izPzmSwni8EIKdVS0TvEbqez9d3oEhqx396EDfPfcK0fNJQZDhmofYxYUikCyReljd3wMHv4IFWuVXcVJTmehyQcC4ORqDYaww75tn4KDrO6HnH5dGFJphxDAZ+dIJhbGuz/CzkF7BmCPmpbrZNHo8O99o0+J72VuIe93Ye28B5N17xa1ubY4OJLCTEsAspuiSF/uPlWdk7R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMGUAyH0G5WjhSJieUp1NGj+VwOPq31WygzJOCGHuHs=;
 b=V1isUp0AF4mU48pX8n6xk9TRsllo0DPd9CyQmOZJ5V0GQp3HnbQSKxnmg7zWOQrntxI/yRNo9Bd8PFdgPNHrySgueleygEF8wKatjl4VC8F2zEZpW6elchoOR5m6Bd3P6jG0fd7NaGTSTny1RrPwIekPNewmXr96Ib40o0388ps=
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:40:19 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::58) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.30 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:15 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 09/12] ionic: change the hwstamp likely check
Date: Thu, 29 Feb 2024 11:39:32 -0800
Message-ID: <20240229193935.14197-10-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 533802f1-6207-4662-f0ce-08dc395e42f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mlxdTXw5htbzP1vMXKSEVdYSv8+ZPfzeCS44oLf0zNYHZUxO/6eCYOpd+ws3lFivNAbEktOJd6F3n1bFjAVetXLjezcWMt59yv48Z0XrxibiZxswzG09wipSB1/Nvw2QUM8BJt1p1Ds5rtsnHK4D8BoKLIUYDujnG7Sdq8E/jjHskH8JjHiwgApmxCZgrdwCl/wgnjt85M4y3AG9qAYR3ySr8UUio18suFhWjJUYx/Kd8ZYDV3W5STRB5+CoP3doKQZbDE5zij1SZjtRPxpQWk+ndXPeKglofWxEE/4hfiZqjnZngM04L6P3NGZmkYmKKbhIYVr4OlTQtX9n+VtHqfJ8Y3l+Fn0NwoqgG8zsNNzMk6ru+TgbNQ82PDDc3/UOYjlIXKxIxZ4lPIelPKd/95aM87EMV6G+hWDNWckb7T0naiTgVswmqnNBMrRTWxbo/fWc2541/kkGvh72+7FQTU/iNMxCP+kNY1/fo7q+nSmDWaoqyDZAPks73nbYTYpI6ckrLVQqhPx4l0j/9ba0ET+LSoFrRx0xPmQjsEamICdcdyWGfkvUN8zFtY4KwAf+djcOzVJvae1WOYFHPL5t01Vizgd9lt9nf9V/CVugBDIwJtu9oCFWb6zLqei6k+HoOfosU6bjZOxOys3YgeK2Zvf+s++Xtm0fkCncVwqonFtUFVAMx0/EvkijAgQGk3ceaNXouq1cJCGzTzKlmCYoD3YupM2eEk/W9nRTYxXEMo48rITdhlZXcSo20ysIX5L0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:19.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533802f1-6207-4662-f0ce-08dc395e42f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

From: Brett Creeley <brett.creeley@amd.com>

An earlier change moved the hwstamp queue check into a helper
function with an unlikely(). However, it makes more sense for
the caller to decide if it's likely() or unlikely(), so make
the change to support that.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h  |  2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 42006de8069d..b4f8692a3ead 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -327,7 +327,7 @@ static inline u32 ionic_coal_usec_to_hw(struct ionic *ionic, u32 usecs)
 
 static inline bool ionic_txq_hwstamp_enabled(struct ionic_queue *q)
 {
-	return unlikely(q->features & IONIC_TXQ_F_HWSTAMP);
+	return q->features & IONIC_TXQ_F_HWSTAMP;
 }
 
 void ionic_link_status_check_request(struct ionic_lif *lif, bool can_sleep);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index ed095696f67a..89a40657c689 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1201,7 +1201,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	if (!skb)
 		return;
 
-	if (ionic_txq_hwstamp_enabled(q)) {
+	if (unlikely(ionic_txq_hwstamp_enabled(q))) {
 		if (cq_info) {
 			struct skb_shared_hwtstamps hwts = {};
 			__le64 *cq_desc_hwstamp;
@@ -1296,7 +1296,7 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 	if (work_done) {
 		struct ionic_queue *q = cq->bound_q;
 
-		if (!ionic_txq_hwstamp_enabled(q))
+		if (likely(!ionic_txq_hwstamp_enabled(q)))
 			netif_txq_completed_wake(q_to_ndq(q->lif->netdev, q),
 						 pkts, bytes,
 						 ionic_q_space_avail(q),
@@ -1337,7 +1337,7 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info->cb_arg = NULL;
 	}
 
-	if (!ionic_txq_hwstamp_enabled(q)) {
+	if (likely(!ionic_txq_hwstamp_enabled(q))) {
 		struct netdev_queue *ndq = q_to_ndq(q->lif->netdev, q);
 
 		netdev_tx_completed_queue(ndq, pkts, bytes);
@@ -1419,7 +1419,7 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 
 	if (start) {
 		skb_tx_timestamp(skb);
-		if (!ionic_txq_hwstamp_enabled(q))
+		if (likely(!ionic_txq_hwstamp_enabled(q)))
 			netdev_tx_sent_queue(q_to_ndq(netdev, q), skb->len);
 		ionic_txq_post(q, false, ionic_tx_clean, skb);
 	} else {
@@ -1669,7 +1669,7 @@ static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
 	stats->pkts++;
 	stats->bytes += skb->len;
 
-	if (!ionic_txq_hwstamp_enabled(q)) {
+	if (likely(!ionic_txq_hwstamp_enabled(q))) {
 		struct netdev_queue *ndq = q_to_ndq(netdev, q);
 
 		if (unlikely(!ionic_q_has_space(q, MAX_SKB_FRAGS + 1)))
-- 
2.17.1


