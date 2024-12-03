Return-Path: <netdev+bounces-148360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B406A9E13E5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F86164603
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133F19F462;
	Tue,  3 Dec 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YMm2+u09"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E0190068;
	Tue,  3 Dec 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210517; cv=none; b=EVGmoQKoktXVSFm34o2b7ao0CeQuit8mQGu1srnfc/W/vFXJByKTuZxNWsOhqUxq54iw+ZkqGv8LgO7MwA3wZo397xdgTPPAUH3jOfHcHmOr8gmAV3GxHge13iD8bKvCEBB9dZLClhxrUW/mKsXU5UC49o1lwgOI75214dSsBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210517; c=relaxed/simple;
	bh=iylAhosW77w2u9xAeYd/1FbXH+I7TjDY4QEVCoIu+tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm3dhFiPAZR5/QC4E0aYQqI836PCrXJPH7mmFCFSQoCTzOgJu+GEbfNKNp5KvAoDvhrYn/e5Y6t6l93tcYDzmdDPv57bCYoAPy2RWo+T24Rl/koYmzURz2SvxZ67+tSq3eXhKoLjsigfBCNuQP/9XZbvWyKhN9SfnXTm7D2/rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YMm2+u09; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B30BHvG032757;
	Mon, 2 Dec 2024 23:21:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	0v3XGHnrUCbd0Zjf9nphx1E5qKnd4Kf5ev2MrlxOU4=; b=YMm2+u09r2tf3NZZJ
	X41VW7MuIwRALVdHhl4n8g4KqDjR+jXgv+wNXHOMYX7njnb0pCOTsGlpl8YhlbqH
	6PcnfrIeOwxxKoJ494EEiQhvrzespPz7H+KkDX9goKQZ2LtCKg8tDQOXqeM80GWs
	DJ1JIC+248mzs+wfMohZ2iYkbTttlGp5K9mPypqPhCNS30GS1uJKwcZ5iY5Wzv1E
	OJcoh7W1FgSo6WiDGbXbntg/WLEOR21aaJqYVAhQpzS0etU7h4kbpynqQCWPZ6NO
	OyIre5KQrZcUJaK/CXsGMr5J5+1zk9ETxiNaemsZE92WLyH1rIFFr2rY/dLjdyE4
	9l43Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 439q7cgpec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 23:21:35 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 23:21:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 23:21:34 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 003615B6952;
	Mon,  2 Dec 2024 23:21:33 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: [PATCH net v1 1/4] octeon_ep: fix race conditions in ndo_get_stats64
Date: Mon, 2 Dec 2024 23:21:27 -0800
Message-ID: <20241203072130.2316913-2-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: 7nZToYQvVJaFCJxhTuX00LWzmER69LIk
X-Proofpoint-GUID: 7nZToYQvVJaFCJxhTuX00LWzmER69LIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Implement device state variable to protect
against such resource usage.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep/octep_main.c   | 27 +++++++++++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  8 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..872b4848027c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -733,6 +733,7 @@ static int octep_open(struct net_device *netdev)
 	if (ret > 0)
 		octep_link_up(netdev);
 
+	set_bit(OCTEP_DEV_STATE_OPEN, &oct->state);
 	return 0;
 
 set_queues_err:
@@ -745,6 +746,11 @@ static int octep_open(struct net_device *netdev)
 	return -1;
 }
 
+static bool octep_drv_busy(struct octep_device *oct)
+{
+	return test_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
+}
+
 /**
  * octep_stop() - stop the octeon network device.
  *
@@ -759,6 +765,14 @@ static int octep_stop(struct net_device *netdev)
 
 	netdev_info(netdev, "Stopping the device ...\n");
 
+	clear_bit(OCTEP_DEV_STATE_OPEN, &oct->state);
+	/* Make sure device state open is cleared so that no more
+	 * stats fetch can happen intermittently
+	 */
+	smp_mb__after_atomic();
+	while (octep_drv_busy(oct))
+		msleep(20);
+
 	octep_ctrl_net_set_link_status(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
 				       false);
 	octep_ctrl_net_set_rx_state(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
@@ -1001,6 +1015,16 @@ static void octep_get_stats64(struct net_device *netdev,
 					    &oct->iface_rx_stats,
 					    &oct->iface_tx_stats);
 
+	set_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
+	/* Make sure read stats state is set, so that ndo_stop
+	 * doesn't clear resources as they are read
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(OCTEP_DEV_STATE_OPEN, &oct->state)) {
+		clear_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
+		return;
+	}
+
 	tx_packets = 0;
 	tx_bytes = 0;
 	rx_packets = 0;
@@ -1022,6 +1046,7 @@ static void octep_get_stats64(struct net_device *netdev,
 	stats->rx_errors = oct->iface_rx_stats.err_pkts;
 	stats->collisions = oct->iface_tx_stats.xscol;
 	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
+	clear_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
 }
 
 /**
@@ -1526,6 +1551,8 @@ static int octep_sriov_disable(struct octep_device *oct)
 	pci_disable_sriov(pdev);
 	CFG_GET_ACTIVE_VFS(oct->conf) = 0;
 
+	clear_bit(OCTEP_DEV_STATE_OPEN, &oct->state);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index fee59e0e0138..78293366e7de 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -223,6 +223,12 @@ struct octep_pfvf_info {
 	u32 mbox_version;
 };
 
+/* Device state */
+enum octep_dev_state {
+	OCTEP_DEV_STATE_OPEN,
+	OCTEP_DEV_STATE_READ_STATS,
+};
+
 /* The Octeon device specific private data structure.
  * Each Octeon device has this structure to represent all its components.
  */
@@ -318,6 +324,8 @@ struct octep_device {
 	atomic_t hb_miss_cnt;
 	/* Task to reset device on heartbeat miss */
 	struct delayed_work hb_task;
+	/* Device state */
+	unsigned long state;
 };
 
 static inline u16 OCTEP_MAJOR_REV(struct octep_device *oct)
-- 
2.25.1


