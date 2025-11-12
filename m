Return-Path: <netdev+bounces-237922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEFC5185D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2362E421F88
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D29303A0A;
	Wed, 12 Nov 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P2ZNkyqQ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D01301495;
	Wed, 12 Nov 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940950; cv=none; b=fpOCTfk6Xq/8pUn2eTMca/CbS1eU3A27Wyffl4jHvSunceXPHjPdZu3+BpZohSJb9T6JX8nyHE5gTG+TSPDz9AcKrRVEbqmVx3UCZhdEWrG+ru1mR4ZDXo9m0AA0x69Ibk+MitB1jC9+rgIWryUyM+4uFoVumt8b3+2OZgpoh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940950; c=relaxed/simple;
	bh=IVSH2xqSx4ZtJ+I/r4yLqScRkrp1DmsNvMIZ63e1GYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMpJmO8ovcjT7plTm4NYgicc6A7aovLpX8WTJE/HYjxYcthY+V2miyYm+KwuLR72yY+fRImoV47tkPDyqbVFQeHkqmq7bnAOH4EMnIOS1bW5EC+Oscvs2oOazQ1x6jakuBPB1q7wRlB1iEqy4Ci8TACx+Rjl4fO4Hx2kK+4OQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P2ZNkyqQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=u8
	dQO4QxXLIAZVZsY6tASVlXUa/tVs5IGeJKJ/SQs1o=; b=P2ZNkyqQeKHDagulv5
	0Ks5vYrXW+GllJ7t1duvx3uhz57jNmXj7EllhcMNJFTrakHZSX2G+XrsZdDBx68L
	ATM8BwILyVKm/iOYMXblBkwLTYhpFgv4pG8mg8j+4CHSJGdJ2+rzzraWpw9b+c3U
	/XxsonZ/mDe3HVrseZk1nG6cw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA32a_8VxRpCkthDg--.4901S3;
	Wed, 12 Nov 2025 17:48:48 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH 2/2] Bluetooth: Process Read Remote Version evt
Date: Wed, 12 Nov 2025 17:48:43 +0800
Message-Id: <20251112094843.173238-2-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112094843.173238-1-13875017792@163.com>
References: <20251112094843.173238-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA32a_8VxRpCkthDg--.4901S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1DurWrCF13Kw4UtFWrZrb_yoW5Ww4rpa
	y5uasakrW8Jr43Xr1xAay8Zan8Zwn2qFWxK3y2v34fJwsYvrWktF4kCFyjyrW5ArWqvFyj
	vF1Utr13WFyDGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtYFZUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXA8EumkUUXeHwAABsw

From: Gongwei Li <ligongwei@kylinos.cn>

Add processing for HCI Process Read Remote Version event.
Used to query the lmp version of remote devices.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 32b1c08c8bba..bdd5e6ef3616 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -749,6 +749,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	__u8		remote_ver;
 
 	unsigned int	sent;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f20c826509b6..7f8e3f8ec01e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3737,6 +3737,26 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_remote_version_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
+{
+	struct hci_ev_remote_version *ev = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	conn->remote_ver = ev->lmp_ver;
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 {
 	cancel_delayed_work(&hdev->cmd_timer);
@@ -7448,6 +7468,9 @@ static const struct hci_ev {
 	/* [0x0b = HCI_EV_REMOTE_FEATURES] */
 	HCI_EV(HCI_EV_REMOTE_FEATURES, hci_remote_features_evt,
 	       sizeof(struct hci_ev_remote_features)),
+	/* [0x0c = HCI_EV_REMOTE_VERSION] */
+	HCI_EV(HCI_EV_REMOTE_VERSION, hci_remote_version_evt,
+	       sizeof(struct hci_ev_remote_version)),
 	/* [0x0e = HCI_EV_CMD_COMPLETE] */
 	HCI_EV_REQ_VL(HCI_EV_CMD_COMPLETE, hci_cmd_complete_evt,
 		      sizeof(struct hci_ev_cmd_complete), HCI_MAX_EVENT_SIZE),
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 79762bfaea5f..c0bab45648f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9728,6 +9728,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct sk_buff *skb;
 	struct mgmt_ev_device_connected *ev;
+	struct hci_cp_read_remote_version cp;
+
+	memset(&cp, 0, sizeof(cp));
 	u16 eir_len = 0;
 	u32 flags = 0;
 
@@ -9774,6 +9777,8 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	ev->eir_len = cpu_to_le16(eir_len);
 
 	mgmt_event_skb(skb, NULL);
+
+	hci_send_cmd(hdev, HCI_OP_READ_REMOTE_VERSION, sizeof(cp), &cp);
 }
 
 static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
-- 
2.25.1


