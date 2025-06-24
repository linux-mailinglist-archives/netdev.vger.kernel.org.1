Return-Path: <netdev+bounces-200503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A71AE5BD4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70571B63FC3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4621DED5D;
	Tue, 24 Jun 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl0sBDn/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD62AEED;
	Tue, 24 Jun 2025 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750742456; cv=none; b=DCk71IuVsajG8elvIVZlxknJ6mgPgXXdmacQWR7jyR1cInkAgbnky6IJ63zMKISwt08e1Tw14hU20iYvMz081zimlx47JRdCwK/TBTNRxQHURJ7M+U06VDRHXWybOGlp0zkm6n2r+BFhHmIr6X+mAFo5fIjiuDWgv5+wmy9S/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750742456; c=relaxed/simple;
	bh=NbMlPU76pDn1qjfo5sXua11VvUTm9H84TOJbZoaoR4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sN25zmw/Cgi+VimLECg/cJQLPU5wO1CBbCWscOXjoGaezkKlysRtaQUn3K0kZgSnJonwIdhe9RyX6Tjxch7WM5/wW/Z1H6SPjmvdkeXc+eX68sShbkNaMSKfnd+GsKep+zvC1rLloY+XjVignv9xkp4VQsKnUWj15lwp2TBNxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl0sBDn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 521A3C4CEF1;
	Tue, 24 Jun 2025 05:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750742456;
	bh=NbMlPU76pDn1qjfo5sXua11VvUTm9H84TOJbZoaoR4Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bl0sBDn/pqAbO/7vIzlkMYg/9zUVcgBPwZiTbwjrSQ3cBjoaPm5er8QByV5MrDLA7
	 2EQ9tFebW9ISNw8ubnmi4U2CegsjCw56Dx7wVnvcV9Rwk2iCUnfk5up2DdI5IwAGO2
	 OBbL9qtWUawUS/S8F+aWcYoieMc1jpNtZcV1JwIXlvN/4NBM6gLXJnIpzQfpSUWYkf
	 TBcrgogRc0EFVxnqqVZDEk1XeNp/8KiUdFztkLzuSp1iWBI7MNP2VxaVwJfT85eRyY
	 uv6sIOFmvl3ZQ5vgLnPPXzqtAEKMtu/OtRg/CjeyhHNG4AP4j34BHS93VcgQX45s4z
	 J8ZJr6UScp1YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49889C7EE2A;
	Tue, 24 Jun 2025 05:20:56 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 24 Jun 2025 13:20:44 +0800
Subject: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG Sync
 Lost event
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKs1WmgC/x3M0QpAMBSA4VfRubaaGeJVpMV2cEqjHYm0d7dcf
 v/F/wJjIGToshcCXsS0+4Qiz8Cuo19QkEsGJVUl60KJFN2GZqLF8OOt2XY+DV7oT6Ft42yty1a
 OCtLgCDjT/c/7IcYPVSYaKGwAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750742454; l=2539;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=3xOWybT0hvFSOiNGPz4vVsSCR2isMoJtxxrE8KhFyic=;
 b=32qzfmyTCP2aM6DgE1emIRrsb577fcGy9Zd752E4k1VUKQgvSU5vECllJAWiESugLEAJre9dX
 db2PB9JhMGYB8NfmtCzmzs1PRBu1I5oMxPdATGC1snm6pvrCx1BJyRz
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
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
index 66052d6aaa1d..730deaf1851f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7026,6 +7026,24 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
+					    struct sk_buff *skb)
+{
+	struct hci_evt_le_big_sync_lost *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle);
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
+			hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
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



