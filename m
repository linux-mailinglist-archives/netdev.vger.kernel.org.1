Return-Path: <netdev+bounces-239464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE364C688C3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF736644E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E7314D0B;
	Tue, 18 Nov 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lloDqHDE"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B34313523;
	Tue, 18 Nov 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458161; cv=none; b=Ws2Ae3gwsgJy54Yk7mlm4lR6ZpXAxHIHuciFM3TF0RfC4xbgO2Uvf2Nq9iXO4Tp+q9JrXoB8/UnQTYvww4LOJW+fx1DauB3WMTZAd0aCUfFSxBZyQE/O2H5xSD7diRIz0NBVIiaiUUPHWQZOWELN+wTXSUOEuv693w/FeQN3RRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458161; c=relaxed/simple;
	bh=XtXjD5/us05FBBs2aNvNSAmALfBDhakcT0etFgo4DWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bqt+ZKFhzZH4IbmZ2yYyPVWdLP7LT3MiRcnyjg3f5q6hwZ+zFmi6AJcJY5qX4FCI2pV8OCGIJaONjKDEThCbWm1C4g0s0TXRiBys1l+266mp3+j9JDa7ujq/Lw8Pai10CoTVyTrkO8E0shpEUJ1g0cWY2aK+MwCyKJuQ37lz/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lloDqHDE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=po
	5utToS7tZbEM3s51Es5F5AGq5I+najj73o2GX8Ib8=; b=lloDqHDEE8iWilaZwQ
	qdJhaVyRG1z9GgiVz1O1DDcYN2kb4W9yJgW+n5ZByQbylNMrQBHRwP+PU+CmSist
	KRFJUjJWn3rbW1eX2FSh6YW+D0z8rZHeHvDa+K/YRk5xn9P/UrGG2MQP3I0s4PyZ
	YDwKwWIyiu+4xWC2LhvqWX7ck=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3H+JNPBxpth0NBA--.1772S3;
	Tue, 18 Nov 2025 17:28:48 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 2/2] Bluetooth: Process Read Remote Version evt
Date: Tue, 18 Nov 2025 17:28:44 +0800
Message-Id: <20251118092844.210978-2-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118092844.210978-1-13875017792@163.com>
References: <20251118092844.210978-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H+JNPBxpth0NBA--.1772S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4UGr4rCw1DCr17tw4rAFb_yoWrCrWxpF
	Z8u3WfArW8Jr4fXFyxAa18ZFn5Jrn7WFW7KrZ2v34rJws0vrWkJr4kCryjyFy5CrWqqFyx
	ZF1jqr1fuFyUtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAcTPUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXAEKumkcONVibQABs7

From: Gongwei Li <ligongwei@kylinos.cn>

Add processing for HCI Process Read Remote Version event.
Used to query the lmp version of remote devices.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1->v2: Add bt_dev_dbg to print remote_ver
v2->v3: Read ver in get_conn_info_Sync() instead of during the connection process
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_event.c        | 25 +++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 11 +++++++++++
 net/bluetooth/mgmt.c             |  2 ++
 5 files changed, 41 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9efdefed3..424349b74 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -750,6 +750,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	__u8		remote_ver;
 
 	unsigned int	sent;
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 3133f40fa..52078c58a 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -189,3 +189,5 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
+
+int hci_get_remote_ver_sync(struct hci_dev *hdev, __le16 handle);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c4ca14f1..12ed1fd36 100644
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
+	bt_dev_dbg(hdev, "remote_ver 0x%2x2", conn->remote_ver);
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
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a36d2414a..1bca97564 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -419,6 +419,17 @@ static void le_scan_disable(struct work_struct *work)
 static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 				       u8 filter_dup);
 
+int hci_get_remote_ver_sync(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_read_remote_version cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = handle;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_READ_REMOTE_VERSION,
+				     sizeof(cp), &cp, HCI_NCMD_TIMEOUT);
+}
+
 static int reenable_adv_sync(struct hci_dev *hdev, void *data)
 {
 	bt_dev_dbg(hdev, "");
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c11cdef42..36f713d9e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7402,6 +7402,8 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	/* Refresh RSSI each time */
 	err = hci_read_rssi_sync(hdev, handle);
 
+	err = hci_get_remote_ver_sync(hdev, handle);
+
 	/* For LE links TX power does not change thus we don't need to
 	 * query for it once value is known.
 	 */
-- 
2.25.1


