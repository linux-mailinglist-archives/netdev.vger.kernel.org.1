Return-Path: <netdev+bounces-53944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C05805572
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFE71F213D0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C25C8E4;
	Tue,  5 Dec 2023 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BaMQBimE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BB120;
	Tue,  5 Dec 2023 05:06:40 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5CngxR032564;
	Tue, 5 Dec 2023 05:06:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2rDup1rK28BIzol1uUQ+jfQcdpFyk9LG+2EZtkJphPs=;
 b=BaMQBimEQ6WSgGtR6ubmWd6KfTmYUjQtbsBslvG00pXH4qcbvULkQCUR7sjc8du3aj32
 2UlXiiOsJG9AoBmwDZmCIJsW3suBaqEjjeagEa0U3E/c1yi87icW5TeQY6VEhQZnvB3K
 uWlYnNQlPbsIM3VTS4eiR+KOYhePtnEiJit5mA82HTwUlRXiT7X+Sjeq2JspiM0KYQ10
 ATj/Jx0MK+9+IEtyHtsSzdKUdgZR2khmNEB21xNXcsXuo1sQboKWvuoge64wgpXXHex5
 UH3hDoNqyl7B7nubN5yVzv0mupZAoWFfYTcLLSiZyFrfhn6MagZA8vwAh2qA+G4QcUmX 6A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ut0e68rb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 05:06:29 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 05:06:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 05:06:27 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 951B03F70A6;
	Tue,  5 Dec 2023 05:06:27 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy
 Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net v2] octeon_ep: initialise control mbox tasks before using APIs
Date: Tue, 5 Dec 2023 05:06:24 -0800
Message-ID: <20231205130625.2586755-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NVyDbGDbPraZgKiXtghGi3WQdONDNsjJ
X-Proofpoint-ORIG-GUID: NVyDbGDbPraZgKiXtghGi3WQdONDNsjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_07,2023-12-05_01,2023-05-22_02

Initialise various workqueue tasks and queue interrupt poll task
before the first invocation of any control net APIs. Since
octep_ctrl_net_get_info was called before the control net receive
work task was initialised or even the interrupt poll task was
queued, the function call wasn't returning actual firmware
info queried from Octeon.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Updated changelog.
  - Handled error return for octep_ctrl_net_get_info

V1: https://lore.kernel.org/all/20231202150807.2571103-1-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_main.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 552970c7dec0..d400a221d82c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1193,6 +1193,13 @@ int octep_device_setup(struct octep_device *oct)
 	if (ret)
 		return ret;
 
+	INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
+	INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
+	INIT_DELAYED_WORK(&oct->intr_poll_task, octep_intr_poll_task);
+	oct->poll_non_ioq_intr = true;
+	queue_delayed_work(octep_wq, &oct->intr_poll_task,
+			   msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
+
 	atomic_set(&oct->hb_miss_cnt, 0);
 	INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
 
@@ -1325,21 +1332,18 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_octep_config;
 	}
 
-	octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
+	err = octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
 				&octep_dev->conf->fw_info);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get firware info\n");
+		goto register_dev_err;
+	}
 	dev_info(&octep_dev->pdev->dev, "Heartbeat interval %u msecs Heartbeat miss count %u\n",
 		 octep_dev->conf->fw_info.hb_interval,
 		 octep_dev->conf->fw_info.hb_miss_count);
 	queue_delayed_work(octep_wq, &octep_dev->hb_task,
 			   msecs_to_jiffies(octep_dev->conf->fw_info.hb_interval));
 
-	INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
-	INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
-	INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_task);
-	octep_dev->poll_non_ioq_intr = true;
-	queue_delayed_work(octep_wq, &octep_dev->intr_poll_task,
-			   msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
-
 	netdev->netdev_ops = &octep_netdev_ops;
 	octep_set_ethtool_ops(netdev);
 	netif_carrier_off(netdev);
-- 
2.25.1


