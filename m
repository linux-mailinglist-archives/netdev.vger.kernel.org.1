Return-Path: <netdev+bounces-202793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D2AEF03C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134893AA166
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0423507C;
	Tue,  1 Jul 2025 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX5gZq/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F11E51EB;
	Tue,  1 Jul 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356588; cv=none; b=NNhoCnpfRuAVpHOpRP1CiWSe4Kw80b6wJ1deuZf660gC/OttZvSgsWj8sohGmhb4yxiRh5tdPHIkcSb2fv9rf7/x2Bg8eQfR1NoXNizlMdUGFy0jJ0mqVOSwd26xLUJB1VfXKuEMane6lg2LIt2VpBrBuoPYReUy7Sr2yZ4nCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356588; c=relaxed/simple;
	bh=ghofPNa9c7NhRKlEjAFogqLFD2G4KZ+5gCkEvh+/XdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tKNV/cSi59YM05l8hdncp5KzEWtRVh2eaonSa2EUAAsddPu0aOpUX0K/cxzaUUNbyNDmBl9apLdL/WDbx9hiCp7JAxKUf1OdDNvtsCvTqED9xIH99KU6gWs2Fxkfe2xL4pIn4qyfBEyO9JzlrvdWFgAERtI/O7JdcyPa0eyC+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX5gZq/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E120C4CEEB;
	Tue,  1 Jul 2025 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356587;
	bh=ghofPNa9c7NhRKlEjAFogqLFD2G4KZ+5gCkEvh+/XdM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GX5gZq/cvzr4VxiKPHcdYjUdRTPMkH9s4cG/QsZZh/iU5+7yA+MfoaVxrjXuca445
	 N/ArwdXAsa3mJVb2lFRg9+FVmQ6IOSIeP1pkb4bX6GHafbA17zXKOd29TK0980ao+j
	 dwF7bvCeiWv4owruDCLhG6FLGITwiSzDhbFZ4totwBOhJf35tpbNjR+6HauJ6ZlP3e
	 ENDkvkKKjjZkhEIuF1ylQigXa9sALarmI6Jvwg3RX/z6oyY8GwiDjYYMV8BCHOI8rP
	 d7bFNZCUpAqdaHZWxXDO4l6GVaN3z/OrL5SwJv+BA1MCO2Y/j6oTyD1A71rr44DlXB
	 RNK5vvmruRlVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683C2C83038;
	Tue,  1 Jul 2025 07:56:27 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 01 Jul 2025 15:56:22 +0800
Subject: [PATCH v4] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-handle_big_sync_lost_event-v4-1-f0ed2d77c203@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKWUY2gC/33NSwrCMBSF4a1IxkaSm0fVkfsQKfHmtgZqI00JF
 unejeJAETr8z+A7D5ZoCJTYfvVgA+WQQuxL6PWK4cX1LfHgSzMQYISVwMvoO6rPoa3T1GPdxTT
 WlKkfucbKo9VqJxywAtwGasL9jR9PpS8hjXGY3l9ZvtYPC3qJzZJLjgqQVOW9debgrl1sA24wX
 tkLzvCNmUUMCraVjbRKmMqB/MfUF6bEIqYK5jQ25txYwi38YvM8PwGJKgjOYAEAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751356584; l=5953;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=g1GzVxQHwngpNT6ZeSBkKOq4Yr48SHOPUOISO/Exh7Q=;
 b=ASkTPKkn++TcIRapJtQuWCDLKYl2l9dJb5WEnxeK+okAqqmcRmHx7mNDDUc3Momz96l5ZRNpA
 Ozxtcq8WMOXDtCmkgbyGUw2/yOEVo7SNeTI223Rr6SGik+lbrM/+k8X
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When the BIS source stops, the controller sends an LE BIG Sync Lost
event (subevent 0x1E). Currently, this event is not handled, causing
the BIS stream to remain active in BlueZ and preventing recovery.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v4:
- Rebase the code and improve it
- Link to v3: https://lore.kernel.org/r/20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com

Changes in v3:
- Delete the PA sync connection separately.
- Add state and role check when lookup BIS connections
- Link to v2: https://lore.kernel.org/r/20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com

Changes in v2:
- Matching the BIG handle is required when looking up a BIG connection.
- Use ev->reason to determine the cause of disconnection.
- Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
- Delete the big connection
- Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
---
 include/net/bluetooth/hci.h      |  6 ++++++
 include/net/bluetooth/hci_core.h |  8 +++++---
 net/bluetooth/hci_conn.c         |  3 ++-
 net/bluetooth/hci_event.c        | 38 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 82cbd54443ac..48389a64accb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
 	__le16  bis[];
 } __packed;
 
+#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
+struct hci_evt_le_big_sync_lost {
+	__u8    handle;
+	__u8    reason;
+} __packed;
+
 #define HCI_EVT_LE_BIG_INFO_ADV_REPORT	0x22
 struct hci_evt_le_big_info_adv_report {
 	__le16  sync_handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b47c74080b9e..d555042fc39c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1342,7 +1342,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *
-hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
+			       __u16 state, __u8 role)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1350,8 +1351,9 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
-		    c->state != state)
+		if (c->type != BIS_LINK ||
+			c->state != state ||
+			c->role != role)
 			continue;
 
 		if (handle == c->iso_qos.bcast.big) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4f379184df5b..6bb1ab42db39 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2146,7 +2146,8 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 	struct hci_link *link;
 
 	/* Look for any BIS that is open for rebinding */
-	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_OPEN);
+	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big,
+					     BT_OPEN, HCI_ROLE_MASTER);
 	if (conn) {
 		memcpy(qos, &conn->iso_qos, sizeof(*qos));
 		conn->state = BT_CONNECTED;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a66013418488..c1c870c19e13 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3869,6 +3869,8 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	conn->state = BT_CONNECTED;
+
 	switch (cp->direction) {
 	/* Input (Host to Controller) */
 	case 0x00:
@@ -6877,7 +6879,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 
 	/* Connect all BISes that are bound to the BIG */
 	while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
-						      BT_BOUND))) {
+					BT_BOUND, HCI_ROLE_MASTER))) {
 		if (ev->status) {
 			hci_connect_cfm(conn, ev->status);
 			hci_conn_del(conn);
@@ -6993,6 +6995,35 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
+{
+	struct hci_evt_le_big_sync_lost *ev = data;
+	struct hci_conn *bis, *conn;
+
+	bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
+
+	hci_dev_lock(hdev);
+
+	/* Delete the pa sync connection */
+	bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
+	if (bis) {
+		conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
+		if (conn)
+			hci_conn_del(conn);
+	}
+
+	/* Delete each bis connection */
+	while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
+						BT_CONNECTED, HCI_ROLE_SLAVE))) {
+		clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+		hci_disconn_cfm(bis, ev->reason);
+		hci_conn_del(bis);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7116,6 +7147,11 @@ static const struct hci_le_ev {
 		     hci_le_big_sync_established_evt,
 		     sizeof(struct hci_evt_le_big_sync_estabilished),
 		     HCI_MAX_EVENT_SIZE),
+	/* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
+	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
+		     hci_le_big_sync_lost_evt,
+		     sizeof(struct hci_evt_le_big_sync_lost),
+		     HCI_MAX_EVENT_SIZE),
 	/* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
 		     hci_le_big_info_adv_report_evt,

---
base-commit: 2a0ae2f6cd36497496b71b83b1af55e8eb5a799b
change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



