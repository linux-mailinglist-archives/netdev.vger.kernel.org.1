Return-Path: <netdev+bounces-202321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761BAED4D9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649363A9681
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3831A257D;
	Mon, 30 Jun 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDz48jpE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B72036ED;
	Mon, 30 Jun 2025 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265914; cv=none; b=TirQP23sXgsDnUf/3sDCg0S3B/eN5ODM2VIIecPu7WUde/2G02bdlgZivGFN0Yihme9XTiTUmJyolAxSQSBlzw6sBs6S0nTARd2VAMN3Mis5V/e1/MlyUcznnyCY8+TZ17R1PCspXfGK2LjKhWdlrQw7fz7bsJtLHfXcPGP2G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265914; c=relaxed/simple;
	bh=XUFiVpxKlK+wD+KyggI/eawF4MoFmp23D1qZF+oPfpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uJUeqTBflEI0UleKyFigPxscpEbsM1BdO97OXP6ui4+tDdcR0rUofY3A3dgQ4qoSOsj7Or6rGjCQxyp0UTIUppIfBzJnmy15iD0Z+sInYPkGaOeytd5qxPD392rAEFEXeObYKOXwSCF6aOzyJvn7HYjYEf3Hk+c+9CxJespp3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDz48jpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6645CC4CEEB;
	Mon, 30 Jun 2025 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751265913;
	bh=XUFiVpxKlK+wD+KyggI/eawF4MoFmp23D1qZF+oPfpU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UDz48jpEBBf2Vr7ZhJzVeNr+izJCrxu7tqobH+dYCmrXkk1Ahs+XNrjois6uqa/mv
	 h7KSqyihMq1NGNCRlZ4wibYRoUUvyReR4PMwLJwHV2owXGRLOv/llHrLkapMjlnFmf
	 VgSpbBEfDceUNM6Sk4ePOGsaBcE2UrgSFlk4MBniwIbdMLUigaltAU+iDBHQTR9K/E
	 Di/kcR5NeXhrsn/K+w+e5VfbjvL2EJCb9hn07YFhGEhoDaM4/32JunBZx9XJmeja0h
	 IGGgWhKq/apC8oHMUiaA6lh9dWGsX0U5guNy3ndIhez4bd40OffXLd1W+vgtN/sO2I
	 +QPZJBv0iLnmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D15C83026;
	Mon, 30 Jun 2025 06:45:13 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 30 Jun 2025 14:45:10 +0800
Subject: [PATCH v3] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-handle_big_sync_lost_event-v3-1-a4cf5bf6ec82@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHUyYmgC/33NSw6CMBSF4a2Qjq2htzzUkfswhtTbCzTB1rSkk
 RD2biEOdMLwP4PvzCyQNxTYJZuZp2iCcTaFPGQMe2U74kanZpBDmVcCeBr1QM3DdE2YLDaDC2N
 DkezIC6w1VoU85wpYAl6eWvPe8Ns9dW/C6Py0fUWxrl8Wij02Ci44SkCStdaVKq/qObjO4BHdk
 61whF+s3MUgYSfRikrmZa1A/GPLsnwA7EQyyhMBAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751265911; l=6290;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=hd2J731iIuIotatLug2vmpMnVpPpDXpNF9inZ5U4hT0=;
 b=5dZKeucKuuFJr62uUw25C8Veatiw9E6VYmhqqRy9cGZ8xGyDLXD65tzfu/x7jT8NoeN7tfg5r
 /+cNZ9wSp1YC1O29aCnQbe1oFsi+tnO941S3B53XlpZHW/giU7pOwEr
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
 include/net/bluetooth/hci_core.h | 16 ++++++++++++----
 net/bluetooth/hci_conn.c         |  3 ++-
 net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 6 deletions(-)

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
index a760f05fa3fb..5ab19d4fef93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1340,7 +1340,8 @@ hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *
-hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
+			       __u16 state, __u8 role)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1348,9 +1349,16 @@ hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
-		    c->state != state)
-			continue;
+		if (role == HCI_ROLE_MASTER) {
+			if (c->type != BIS_LINK || bacmp(&c->dst, BDADDR_ANY) ||
+				c->state != state || c->role != role)
+				continue;
+		} else {
+			if (c->type != BIS_LINK ||
+				c->state != state ||
+				c->role != role)
+				continue;
+		}
 
 		if (handle == c->iso_qos.bcast.big) {
 			rcu_read_unlock();
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
index 66052d6aaa1d..f3e3e4964677 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3903,6 +3903,8 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	conn->state = BT_CONNECTED;
+
 	switch (cp->direction) {
 	/* Input (Host to Controller) */
 	case 0x00:
@@ -6913,7 +6915,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 
 	/* Connect all BISes that are bound to the BIG */
 	while ((conn = hci_conn_hash_lookup_big_state(hdev, ev->handle,
-						      BT_BOUND))) {
+					BT_BOUND, HCI_ROLE_MASTER))) {
 		if (ev->status) {
 			hci_connect_cfm(conn, ev->status);
 			hci_conn_del(conn);
@@ -6968,6 +6970,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	}
 
 	clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+	conn->state = BT_CONNECTED;
 
 	conn->num_bis = 0;
 	memset(conn->bis, 0, sizeof(conn->num_bis));
@@ -7026,6 +7029,35 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
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
@@ -7149,6 +7181,11 @@ static const struct hci_le_ev {
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
base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



