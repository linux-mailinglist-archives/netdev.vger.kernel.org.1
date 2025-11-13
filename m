Return-Path: <netdev+bounces-238205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6686C55E61
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21D34E52A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782F318125;
	Thu, 13 Nov 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dws0MKa6"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2A248F78;
	Thu, 13 Nov 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014315; cv=none; b=ZQrMrkB3/xD3dXZ14eehjETEgIhH8kI9YyYh6rA07f/P5MQLrRtUcHjslj0sXKMbPCE8ZBDfz9zJ747vPUufMUUvQNHHLrrhcpMEdQr+Zq6sfUrd97UTA/XIXoiv1l5UbZoTrG4grsBuemphuXN/kr4E+FxBEcgQh/YBwuJ1h14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014315; c=relaxed/simple;
	bh=p/TWKniXxrIJZEdQhWm4G+LdvQgEhk1yxaIw68uJ9wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGg2kaaILIiqZglyDMGL02ctMVCxP3nJ/WIQUpONFqu0FJyYqOFfI8NfpSKHSgiAzQvDa850DhTka4gZu3o3Oi+LuHpdp/9N/emzs10Cwqh/udjIRNSGKj4QG5D/aflqd4/GJfmS77jhXcg0mB9m6IxOyX/Y6wSc8712zSt1cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dws0MKa6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5I
	hcpL6xwu4PKpV5NAlY7RI9Yz2lAk4ESMN0JSYms5o=; b=dws0MKa6RFeLyPmhGW
	h0XColyo5kivmIEkNbl2f/LzhtreLRFGVGRv05kggsZuT3Do9QF65VPOO/8lLJ9q
	51KtQw8YH0cXdQ9CQ51CoQnnFWqhwywC4Owx08sO9aaZ792xeEQbKn9swPKerydb
	NdL6rTSd1rHw5e+2vrqmdSOIQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHt9uHdhVpWwU7DA--.291S2;
	Thu, 13 Nov 2025 14:11:20 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 2/2] Bluetooth: Process Read Remote Version evt
Date: Thu, 13 Nov 2025 14:11:17 +0800
Message-Id: <20251113061117.114625-1-13875017792@163.com>
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
X-CM-TRANSID:_____wCHt9uHdhVpWwU7DA--.291S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1DZF43ArW5WFyDXFy3XFb_yoW5Cr48pa
	98uasakrWrJrsIqr1xAay8Xan8Zwn7Way8K3y2q34fJwsYvrWktF4DCryjyry5ArWqqFy7
	ZF1Utr1fWFyDGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvjgxUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXBkFumkVcAudwgAAsi

From: Gongwei Li <ligongwei@kylinos.cn>

Add processing for HCI Process Read Remote Version event.
Used to query the lmp version of remote devices.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1->v2: Add bt_dev_dbg to print remote_ver
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 25 +++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9efdefed3..424349b74 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -750,6 +750,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	__u8		remote_ver;
 
 	unsigned int	sent;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c4ca14f1..762a3e58b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3738,6 +3738,28 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_remote_version_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
+{
+	struct hci_ev_remote_version *ev = (void *)skb->data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "");
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	conn->remote_ver = ev->lmp_ver;
+
+	bt_dev_dbg(hdev, "remote_ver 0x%2.2x", conn->remote_ver);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 {
 	cancel_delayed_work(&hdev->cmd_timer);
@@ -7523,6 +7545,9 @@ static const struct hci_ev {
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
index c11cdef42..9b8add6a2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9745,6 +9745,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct sk_buff *skb;
 	struct mgmt_ev_device_connected *ev;
+	struct hci_cp_read_remote_version cp;
+
+	memset(&cp, 0, sizeof(cp));
 	u16 eir_len = 0;
 	u32 flags = 0;
 
@@ -9791,6 +9794,8 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	ev->eir_len = cpu_to_le16(eir_len);
 
 	mgmt_event_skb(skb, NULL);
+
+	hci_send_cmd(hdev, HCI_OP_READ_REMOTE_VERSION, sizeof(cp), &cp);
 }
 
 static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
-- 
2.25.1


