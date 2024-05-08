Return-Path: <netdev+bounces-94418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD28BF6C2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C77B1C20C0F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12522EF8;
	Wed,  8 May 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZAyKmc+N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C115E86;
	Wed,  8 May 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152190; cv=none; b=WiPtpVHcLKxpjLUm5N2hFGuF1TqUk+FUKWTNqRxt1raiPpX0MOj6Rm2FB/QToqPvvebS8KuAlGRKtnEYdOEkbA0xkNwQWH6LmxaXu/YUhqoZVUpns3H/Sq37v8yKoA4jVE+zQ8y1AuNrpf7QHKM/2dX3nI5SUdMTMKX4Qbt7ltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152190; c=relaxed/simple;
	bh=4I3/b/RWdKDsqAWaFoI38koUjVEP35TxOAyx2gUrEbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZbYw2IYFJiYiGxlFBe8q75d+kG0k+dO65FaW2raoR24bEk4kks70FBMOXHjtGGVztHw+sArfLT3RhIrF/8vQ84XBxzjhLtm1Yln6yeoz/nOubi1uuOteOaOpVZJ3TU3suQ/X2r+OJWOp0iWP0Q1dwyniTQVlWbmKf/lmYMLrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZAyKmc+N; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4485RT5r001818;
	Wed, 8 May 2024 00:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=Z43sw7wJKj+AEUjOjRBr3+5NfAhSnoJw42gJbDaeRzs=; b=ZAy
	Kmc+NQhqIRY3EuATqwa85y7ArWFLigIe6uTlxolCC4/JHrL6ZyTsLHOfSd0oLNsw
	HoPvR5ybQo5rmuh0emLABqCsaNoqWixVh7zZ+G+63bvCc5ZQnv/Q9c9yWM2hVpzy
	Zo84rnm/3dffBCVfxTlyQEjerQiAP3gHFNjYW4I0dBIOczH6u9RbdmdjlFZwEvU9
	Z7xB1wRpetLvOaqmK9LngumPZ7Ocdo3dJkelvnbLZmi3tmh3crmOmae30o8d5L0c
	sQJ9CNQTDfiiqTBESkDdnMvzzUx0jScNGsEpcvnKfImCwwXtfzqDJy0MA0KULwDy
	ohBNCWgsn5jes1f6w5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xysfmjabg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 00:09:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 May 2024 00:09:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 00:09:39 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8378D5B6942;
	Wed,  8 May 2024 00:09:36 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <sbhatta@marvell.com>, <gakula@marvell.com>,
        <sgoutham@marvell.com>, <naveenm@marvell.com>
Subject: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue index of HTB class
Date: Wed, 8 May 2024 12:39:35 +0530
Message-ID: <20240508070935.11501-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Ao6lBRG0M2fGNjaTUJZ7AYl2fbuGofun
X-Proofpoint-ORIG-GUID: Ao6lBRG0M2fGNjaTUJZ7AYl2fbuGofun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_02,2024-05-08_01,2023-05-22_02

Real number of Transmit queues are incremented when user enables HTB
class and vice versa. Depending on SKB priority driver returns transmit
queue (Txq). Transmit queues and Send queues are one-to-one mapped.

In few scenarios, Driver is returning transmit queue value which is
greater than real number of transmit queue and Stack detects this as
error and overwrites transmit queue value.

For example
user has added two classes and real number of queues are incremented
accordingly
- tc class add dev eth1 parent 1: classid 1:1 htb
      rate 100Mbit ceil 100Mbit prio 1 quantum 1024
- tc class add dev eth1 parent 1: classid 1:2 htb
      rate 100Mbit ceil 200Mbit prio 7 quantum 1024

now if user deletes the class with id 1:1, driver decrements the real
number of queues
- tc class del dev eth1 classid 1:1

But for the class with id 1:2, driver is returning transmit queue
value which is higher than real number of transmit queue leading
to below error

eth1 selects TX queue x, but real number of TX queues is x

This patch solves the problem by assigning deleted class transmit
queue/send queue to active class.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 80 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 1723e9912ae0..070711df612e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -545,6 +545,20 @@ otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 	return node;
 }
 
+static struct otx2_qos_node
+*otx2_sw_node_find_by_qid(struct otx2_nic *pfvf, u16 qid)
+{
+	struct otx2_qos_node *node = NULL;
+	int bkt;
+
+	hash_for_each(pfvf->qos.qos_hlist, bkt, node, hlist) {
+		if (node->qid == qid)
+			break;
+	}
+
+	return node;
+}
+
 static struct otx2_qos_node *
 otx2_sw_node_find(struct otx2_nic *pfvf, u32 classid)
 {
@@ -917,6 +931,7 @@ static void otx2_qos_enadis_sq(struct otx2_nic *pfvf,
 		otx2_qos_disable_sq(pfvf, qid);
 
 	pfvf->qos.qid_to_sqmap[qid] = node->schq;
+	otx2_qos_txschq_config(pfvf, node);
 	otx2_qos_enable_sq(pfvf, qid);
 }
 
@@ -1475,13 +1490,45 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 	return ret;
 }
 
+static int otx2_qos_cur_leaf_nodes(struct otx2_nic *pfvf)
+{
+	int last = find_last_bit(pfvf->qos.qos_sq_bmap, pfvf->hw.tc_tx_queues);
+
+	return last ==  pfvf->hw.tc_tx_queues ? 0 : last + 1;
+}
+
+static void otx2_reset_qdisc(struct net_device *dev, u16 qid)
+{
+	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
+
+	if (!qdisc)
+		return;
+
+	spin_lock_bh(qdisc_lock(qdisc));
+	qdisc_reset(qdisc);
+	spin_unlock_bh(qdisc_lock(qdisc));
+}
+
+static void otx2_cfg_smq(struct otx2_nic *pfvf, struct otx2_qos_node *node,
+			 int qid)
+{
+	struct otx2_qos_node *tmp;
+
+	list_for_each_entry(tmp, &node->child_schq_list, list)
+		if (tmp->level == NIX_TXSCH_LVL_MDQ) {
+			otx2_qos_txschq_config(pfvf, tmp);
+			pfvf->qos.qid_to_sqmap[qid] = tmp->schq;
+		}
+}
+
 static int otx2_qos_leaf_del(struct otx2_nic *pfvf, u16 *classid,
 			     struct netlink_ext_ack *extack)
 {
 	struct otx2_qos_node *node, *parent;
 	int dwrr_del_node = false;
+	u16 qid, moved_qid;
 	u64 prio;
-	u16 qid;
 
 	netdev_dbg(pfvf->netdev, "TC_HTB_LEAF_DEL classid %04x\n", *classid);
 
@@ -1517,6 +1564,37 @@ static int otx2_qos_leaf_del(struct otx2_nic *pfvf, u16 *classid,
 	if (!parent->child_static_cnt)
 		parent->max_static_prio = 0;
 
+	moved_qid = otx2_qos_cur_leaf_nodes(pfvf);
+
+	/* last node just deleted */
+	if (moved_qid == 0 || moved_qid == qid)
+		return 0;
+
+	moved_qid--;
+
+	node = otx2_sw_node_find_by_qid(pfvf, moved_qid);
+	if (!node)
+		return 0;
+
+	/* stop traffic to the old queue and disable
+	 * SQ associated with it
+	 */
+	node->qid =  OTX2_QOS_QID_INNER;
+	__clear_bit(moved_qid, pfvf->qos.qos_sq_bmap);
+	otx2_qos_disable_sq(pfvf, moved_qid);
+
+	otx2_reset_qdisc(pfvf->netdev, pfvf->hw.tx_queues + moved_qid);
+
+	/* enable SQ associated with qid and
+	 * update the node
+	 */
+	otx2_cfg_smq(pfvf, node, qid);
+
+	otx2_qos_enable_sq(pfvf, qid);
+	__set_bit(qid, pfvf->qos.qos_sq_bmap);
+	node->qid = qid;
+
+	*classid = node->classid;
 	return 0;
 }
 
-- 
2.17.1


