Return-Path: <netdev+bounces-148361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF79E13E7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818D316487D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E421B0F14;
	Tue,  3 Dec 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LPgRMpzw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57718FDC9;
	Tue,  3 Dec 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210518; cv=none; b=a4PBAqTilwyF7dSbXXxr4BPm/Fv/TbHFkLB3TmRLNXU/onXncNne8g3MNkOWJzOEJIV1z0W0iWLyZY0lAVrp4ClGvCyrKl1uo5c3z4T2zDQiCYiIRMuK/Y/3gu+MJB5KG1pOr7cxGejLKYfYlVV2HlkjJ9hkHbD4DyIdLwsiiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210518; c=relaxed/simple;
	bh=piuztm2JC1bAKcnC1hwkkT/67MNkUP6SLFTwxU1O2xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdHBJMR2TfeQqpvpjCiR3yuAYGgvF4BKjPT28x4URroT9clOv6hliUAcAZQ7MuN60E5acpPBjvW9Q5YfQeErsdFgJ0aBVAFmtvmd74vyU+rR/sD/GnCK6w9jSq9y3dzknU2Cvp/hsNl4o/C21ZgzN0etLK2OTRC4fYiDqN9okFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LPgRMpzw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B34Kp8e026622;
	Mon, 2 Dec 2024 23:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	7KcRipFCxqXuMMCt68EFtKaOtb5E+BZHExMXeYNFN8=; b=LPgRMpzw6LuEMU06l
	atWnmNICIZeDR2Ny+HAe3tpgRh+k3vqZ9QhQP/Gjh9rcFGRJMInTilWnuzdNFYW+
	Txl6ts6BPtQ7UNIe/KJ1JhVJog4K6AydjcETwFwHzMu9LMxQz60FrTQFMe7EHIOx
	gdB0Hs8fMdjwfoHx6J8Z4aPXVKpg2RG5chga7Y3lTro80l0/dEnpnxJWFhfeL1t1
	xe5vBabucl0T6TEyzbLqA8On7nFxKhcKLsSOhXtTi101MzEHa6XfGopTEa2VkhLg
	o4sa5WbVhSOSNOFxBSzOdR1draSDyggC2ufduQgO22ogn03C+MVPHZX4QOUaC9lH
	3VeOA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 439b8qa76x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 23:21:39 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 23:21:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 23:21:39 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 83C3C5B6952;
	Mon,  2 Dec 2024 23:21:38 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v1 3/4] octeon_ep_vf: fix race conditions in ndo_get_stats64
Date: Mon, 2 Dec 2024 23:21:29 -0800
Message-ID: <20241203072130.2316913-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203072130.2316913-1-srasheed@marvell.com>
References: <20241203072130.2316913-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QuasgP3i_da6lSIwMYnHlqC-06b1iXzX
X-Proofpoint-GUID: QuasgP3i_da6lSIwMYnHlqC-06b1iXzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Implement device state variable to protect
against such resource usage.

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 29 +++++++++++++++++++
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  9 ++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..12b95fb21e64 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -497,6 +497,8 @@ static int octep_vf_open(struct net_device *netdev)
 	if (ret)
 		octep_vf_link_up(netdev);
 
+	set_bit(OCTEP_VF_DEV_STATE_OPEN, &oct->state);
+
 	return 0;
 
 set_queues_err:
@@ -511,6 +513,11 @@ static int octep_vf_open(struct net_device *netdev)
 	return -1;
 }
 
+static bool octep_vf_drv_busy(struct octep_vf_device *oct)
+{
+	return test_bit(OCTEP_VF_DEV_STATE_READ_STATS, &oct->state);
+}
+
 /**
  * octep_vf_stop() - stop the octeon network device.
  *
@@ -525,6 +532,14 @@ static int octep_vf_stop(struct net_device *netdev)
 
 	netdev_info(netdev, "Stopping the device ...\n");
 
+	clear_bit(OCTEP_VF_DEV_STATE_OPEN, &oct->state);
+	/* Make sure device state open is cleared so that no more
+	 * stats fetch can happen intermittently
+	 */
+	smp_mb__after_atomic();
+	while (octep_vf_drv_busy(oct))
+		msleep(20);
+
 	/* Stop Tx from stack */
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
@@ -782,6 +797,16 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
 	int q;
 
+	set_bit(OCTEP_VF_DEV_STATE_READ_STATS, &oct->state);
+	/* Make sure read stats state is set, so that ndo_stop
+	 * doesn't clear resources as they are read
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(OCTEP_VF_DEV_STATE_OPEN, &oct->state)) {
+		clear_bit(OCTEP_VF_DEV_STATE_READ_STATS, &oct->state);
+		return;
+	}
+
 	tx_packets = 0;
 	tx_bytes = 0;
 	rx_packets = 0;
@@ -807,6 +832,7 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 		stats->rx_missed_errors = oct->iface_rx_stats.dropped_pkts_fifo_full;
 		stats->tx_dropped = oct->iface_tx_stats.dropped;
 	}
+	clear_bit(OCTEP_VF_DEV_STATE_READ_STATS, &oct->state);
 }
 
 /**
@@ -1140,6 +1166,9 @@ static int octep_vf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&pdev->dev, "Failed to register netdev\n");
 		goto delete_mbox;
 	}
+
+	clear_bit(OCTEP_VF_DEV_STATE_OPEN, &octep_vf_dev->state);
+
 	dev_info(&pdev->dev, "Device probe successful\n");
 	return 0;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index 5769f62545cd..692b3bf94722 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -213,6 +213,12 @@ struct octep_vf_fw_info {
 	u16 tx_ol_flags;
 };
 
+/* Device state */
+enum octep_vf_dev_state {
+	OCTEP_VF_DEV_STATE_OPEN,
+	OCTEP_VF_DEV_STATE_READ_STATS,
+};
+
 /* The Octeon device specific private data structure.
  * Each Octeon device has this structure to represent all its components.
  */
@@ -282,6 +288,9 @@ struct octep_vf_device {
 	/* offset for iface stats */
 	u32 ctrl_mbox_ifstats_offset;
 
+	/* Device state */
+	unsigned long state;
+
 	/* Negotiated Mbox version */
 	u32 mbox_neg_ver;
 
-- 
2.25.1


