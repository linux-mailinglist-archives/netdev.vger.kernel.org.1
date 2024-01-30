Return-Path: <netdev+bounces-66934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E1B841851
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE79A285B16
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DE364C8;
	Tue, 30 Jan 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NtFsXGE0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E9364AB
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578275; cv=fail; b=Kq1B5w6Tf2wc3MCf71COlC+VXYaDqfF2lFrdYu+6osEwI5pApphsPk3A8PKbzpievugxzQnsKPfI7Sm+nXYAaGzs3E5AxqgESb3khJppKOVZcHGJxEHlV4QksCrVoOWN2Jv4BVjPQvuePsJ/zsUD9rXuDUbr0mR0m25BqlP/QDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578275; c=relaxed/simple;
	bh=2g8GMJdRZHv9xdYAgNM/7eeUlVcCVapJh7bNUFKmyDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCSS5d1FiKSWF9fg037uXQwKP6iiznCFc1Yny5FIwONAPEoB/QFYS0kE+84FwW2Nmxn/oASaR5zPGCDk7iL/MWqxHnIkRAISDCPpcRlPWBCIiYgDzEbnD0nls5MUJGDTf4Coek8gkBlns7jWbd3YUs9iPM2gylim0cybvxI1Wbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NtFsXGE0; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6ZuZNaUE19XoXQgtdUuM5lLW8+chcwuKqBxYHQ51nGIVBpNb0aa5NRvvhTUgGJvPhsHMnjtRgR7SbNSTda6l4biGfUOjJ+9hZOYVFs8/N7HRjOIJRLc59GKj5DTtgq3CvziTXTQNS/EzELgIipUyz+WuyeGG6NlLXknZnJ3yOs7e5uQc5Y8lKtj4z7jcpMEeH84tcM5/z9gx627JqS/BmlmZSgw+iBuYlwsB1cMsYrGbQf1+NYGvVyPyXFA7NJT71GKGmizt37ZJStu6f/AQq9jYodPdYdBB9A5/0/84RNUq0g0kwP9v5enE4tmIKI7WXN1cbwT5iwWCcZvma3W7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RVok7rC3gV/gSSSVgsw8fEa9vrFF1HHJgTk+BLvU24=;
 b=RUMo1mSC3mcowl9W1Cx2rT3XG/9TtzgqbmSNAj0pN2Tpk9WEC9qZtL2IDfsLS/VTKoi7iaQ7bv/NVT6PHK0OB9K6mgOQ2B8/UmQiICcyUZw3cy8KZh6NBtiHjT7GHc8+DZwv1Ji7Dh4YYffWk+i9W5OE5eEOsj1ZGP9I4Sb6z27b0s1LMoXMNBp/vy+9THFD9pbWza/1Ss19p4gur5Iz8SAnA8kmCOK3XJ2uPw431lEK29pz5iLKHe697bT1Kv8Cq7JivQkQjjHCpZAPScVsVDOBe8CINUep9nawf3o7sNTZ8Vqd07BErvHUwwFFbY5BTkkOKIUv2m0WZk9F7UItWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RVok7rC3gV/gSSSVgsw8fEa9vrFF1HHJgTk+BLvU24=;
 b=NtFsXGE0H0X1vT3LPMxGqlwuwRElQCn3oyOf0wK92ciMQE1mR/AUgmgj0R0oUsGnzR3V1TJMqEJXjWWVBYT8tUvRqRw/Gqzm94s/WnZhrI7r+7ztUHRGtr2iUxrY6qlvF2ZZw+B4pxlkeQ8as4V8yetWjhUskC025VutsZvu934=
Received: from BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 01:31:10 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::15) by BLAP220CA0015.outlook.office365.com
 (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:10 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:09 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 8/9] ionic: add ndo_xdp_xmit
Date: Mon, 29 Jan 2024 17:30:41 -0800
Message-ID: <20240130013042.11586-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c7e1ea-e2d1-4c2e-f189-08dc213323c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g76MlNKc1RdX/Ghsnc3SSxLnuqRPM4g+X8ksdGhW2UOkPW3X/cKchER+PLP+o0O42evSuvgQuDEmJbh8sC4f6KkNy3+UOPMa2kWbeKvpNxFtqKzblg3TA78X3GlnTY285oTCY6M8P686canWDzvIwCVrmf9p6wbLBIitt6YNEucZhuSqUi7o3oNIdJHX3XtyVDtJxcL9X0CZB7ewMoqeH5EaKbMvaL93WCc8FpBRV1oORbgatiImGfNemY1Hzp02CN89zlTTVq68w6MV1T4KmScfV//x4/ieNvgQOo+1W5wqIxVXA7hoJD+B3RMQP2zyhfwVSygjAna3FfbLOxtfloLkVnIQa6+V63kl6+CGkd3ieMx/f/+BwkpOEIhMcr5mgg+IsABBD+0iGKJW0IeXFaGaSMBSI93q6VB+SfQe/x4ijBazm5ij/VqNYBqhl3MBt/J3I4lD/Axt7qLQ0WqSIu+0JsCwOSxeMCICo6KaTTCLXPzs+5YpvURcXllQVLoLfNRX2NjTBbOVVLLcKaejWPUJ8D9DHIgPlKIwByVqCoEKMReAOHXc2knRC64dQ6WQ9SCikjIqL3hI+zIBHHary9hu63YlIGRvbyGFoTvS7s9jNoOqTPbvbzZ7rPt0XrHf4SeGECO5Tu5EUXCAqM+i6XXjG5T++3g26GRb5v6F0HABnwfaY20B88NqhRUX5k0C+Qg01bLuJzTAtGV/V9sDlfnVpM6lsyyVEQhYbOThlGSFGq/VH0NBFi4d7DMXXRpaxTEX3ZuJ3YwdIabOASsgGQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(47076005)(316002)(6666004)(54906003)(336012)(426003)(86362001)(70586007)(110136005)(70206006)(82740400003)(44832011)(4326008)(1076003)(81166007)(36860700001)(26005)(478600001)(40480700001)(40460700003)(2616005)(16526019)(8676002)(356005)(8936002)(83380400001)(5660300002)(2906002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:10.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c7e1ea-e2d1-4c2e-f189-08dc213323c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420

When our ndo_xdp_xmit is called we mark the buffer with
XDP_REDIRECT so we know to return it to the XDP stack for
cleaning.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 62 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  1 +
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index bd65b4b2c7f8..ed5d792c4780 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1650,7 +1650,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 			      IFF_LIVE_ADDR_CHANGE;
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
-			       NETDEV_XDP_ACT_REDIRECT;
+			       NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT;
 
 	return 0;
 }
@@ -2844,6 +2845,7 @@ static const struct net_device_ops ionic_netdev_ops = {
 	.ndo_eth_ioctl		= ionic_eth_ioctl,
 	.ndo_start_xmit		= ionic_start_xmit,
 	.ndo_bpf		= ionic_xdp,
+	.ndo_xdp_xmit		= ionic_xdp_xmit,
 	.ndo_get_stats64	= ionic_get_stats64,
 	.ndo_set_rx_mode	= ionic_ndo_set_rx_mode,
 	.ndo_set_features	= ionic_set_features,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index c2be2215406a..618d15fb8d95 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -316,9 +316,13 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	buf_info = desc_info->bufs;
 	dma_unmap_single(dev, buf_info->dma_addr,
 			 buf_info->len, DMA_TO_DEVICE);
-	__free_pages(buf_info->page, 0);
+	if (desc_info->act == XDP_TX)
+		__free_pages(buf_info->page, 0);
 	buf_info->page = NULL;
 
+	if (desc_info->act == XDP_REDIRECT)
+		xdp_return_frame(desc_info->xdpf);
+
 	desc_info->nbufs = 0;
 	desc_info->xdpf = NULL;
 	desc_info->act = 0;
@@ -372,6 +376,62 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
 	return 0;
 }
 
+int ionic_xdp_xmit(struct net_device *netdev, int n,
+		   struct xdp_frame **xdp_frames, u32 flags)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_queue *txq;
+	struct netdev_queue *nq;
+	int nxmit;
+	int space;
+	int cpu;
+	int qi;
+
+	if (unlikely(!test_bit(IONIC_LIF_F_UP, lif->state)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	/* AdminQ is assumed on cpu 0, while we attempt to affinitize the
+	 * TxRx queue pairs 0..n-1 on cpus 1..n.  We try to keep with that
+	 * affinitization here, but of course irqbalance and friends might
+	 * have juggled things anyway, so we have to check for the 0 case.
+	 */
+	cpu = smp_processor_id();
+	qi = cpu ? (cpu - 1) % lif->nxqs : cpu;
+
+	txq = &lif->txqcqs[qi]->q;
+	nq = netdev_get_tx_queue(netdev, txq->index);
+	__netif_tx_lock(nq, cpu);
+
+	if (netif_tx_queue_stopped(nq) ||
+	    unlikely(ionic_maybe_stop_tx(txq, 1))) {
+		__netif_tx_unlock(nq);
+		return -EIO;
+	}
+
+	space = min_t(int, n, ionic_q_space_avail(txq));
+	for (nxmit = 0; nxmit < space ; nxmit++) {
+		if (ionic_xdp_post_frame(netdev, txq, xdp_frames[nxmit],
+					 XDP_REDIRECT,
+					 virt_to_page(xdp_frames[nxmit]->data),
+					 0, false)) {
+			nxmit--;
+			break;
+		}
+	}
+
+	if (flags & XDP_XMIT_FLUSH)
+		ionic_dbell_ring(lif->kern_dbpage, txq->hw_type,
+				 txq->dbval | txq->head_idx);
+
+	ionic_maybe_stop_tx(txq, 4);
+	__netif_tx_unlock(nq);
+
+	return nxmit;
+}
+
 static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			  struct net_device *netdev,
 			  struct ionic_queue *rxq,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
index d7cbaad8a6fb..82fc38e0f573 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
@@ -17,4 +17,5 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 
+int ionic_xdp_xmit(struct net_device *netdev, int n, struct xdp_frame **xdp, u32 flags);
 #endif /* _IONIC_TXRX_H_ */
-- 
2.17.1


