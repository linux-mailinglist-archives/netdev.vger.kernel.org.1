Return-Path: <netdev+bounces-200987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDAAE7A9D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B77B2A93
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683A28314E;
	Wed, 25 Jun 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSh0yxt3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EB27F187;
	Wed, 25 Jun 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840973; cv=none; b=jRB4mZP7yj7qbrbKTbRKPPSxlf1B5X+OjQMTD2tRkCVYxOM3SQ7EZMti7VTcelyAlTu3Miq6md/Ziq/LlzpwzITngOuUc1sIVplrF0VYxNF7W3HbL2Cb8hMLDrLY/8iPkTQKW3mSp1EcYZaWX4rD8NBTyhsVdCNkAXUeUUjBDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840973; c=relaxed/simple;
	bh=8RyD8b+dB6zF43UCsVGSQk0jUPuIhhPSK+qvKJ7Em2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J9oLRC0nxyJfbGcuzqWagmqnBq+4v7Cdu2866qylzz10kueLLt5igKjrpuq/V/0gla37/rJvWv1GM2f4rO/uzMkHomc6s4jylceD5U60XxvVE+8/iuvNxoAWqN/t3rRfIsjQeEN6LAfETzBBqqWkTAjZ652CCt9HH0ttiaI3gGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSh0yxt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0E80C4CEEA;
	Wed, 25 Jun 2025 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750840972;
	bh=8RyD8b+dB6zF43UCsVGSQk0jUPuIhhPSK+qvKJ7Em2A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sSh0yxt3Bl4Lr9AkqrAkd34sEsrpkvyQGaD9owIXHN04JGR6xAwClsAQkoKiIxKso
	 pRdjBbM0n+2wOb1Nj2sVPzFLOEgBCY7UCnLJss9lkw8UH5bok5usFozt6swIZNgYH7
	 3lIWcVhD5BhvlXCw0mdLFLr3jowqboxN3Ln0WOwkdEDCLvs1YbvWX3JGcOmci/lPh7
	 cVy+UmoAc3qrraWtuMrKamzTdGnT40/Iyq3urtMoukIPZUf+JkdZhHlKIp5y9eVvsD
	 qDLj1tlYYkSvxVorvIg99nwCRHrF53Q2Ndc5UGv4OkhBRZ5n0/2TusyF0cmjm/Wgua
	 q33L0WBCFCy/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F9C7EE30;
	Wed, 25 Jun 2025 08:42:52 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 25 Jun 2025 16:42:49 +0800
Subject: [PATCH v2] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIi2W2gC/33NywrCMBCF4VcpWRtppjd05XtICXEytgNtIkkJl
 tJ3NxbXLv+z+M4mIgWmKK7FJgIljuxdDjgVAkfjBpJscwsooSlbBTKPdiL94EHH1aGefFw0JXK
 LrLGz2NbVpTQgMvAK9OT3gd/73CPHxYf1+Erqu/5YqP+xSUklsQKkqrO2Nc3NzJMfGM/oZ9Hv+
 /4B3kTbpMYAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750840971; l=3131;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=+z+dUqdDyldE5nsJD9/hOCyoQSkymotIIMTtOBNS5rQ=;
 b=adqKAGMBBzMjHlYTHEQ8EceIJGHCS/cRUiqWAz/PvVVp+OFw2uzyYJdzKA9vYV14Jf4AZLuai
 j6eY1JBCXx5AdJKvtPM892IgAmUYV47Cw+z4SiHEKQ2th6MAvm5nKPK
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
Changes in v2:
- Matching the BIG handle is required when looking up a BIG connection.
- Use ev->reason to determine the cause of disconnection.
- Call hci_conn_del after hci_disconnect_cfm to remove the connection entry
- Delete the big connection
- Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com
---
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d..d0b9c8dca891 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
+					    struct sk_buff *skb)
+{
+	struct hci_evt_le_big_sync_lost *ev = data;
+	struct hci_conn *bis, *conn;
+
+	bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(bis, &hdev->conn_hash.list, list) {
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &&
+		    (bis->iso_qos.bcast.big == ev->handle)) {
+			hci_disconn_cfm(bis, ev->reason);
+			hci_conn_del(bis);
+
+			/* Delete the big connection */
+			conn = hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
+			if (conn)
+				hci_conn_del(conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
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



