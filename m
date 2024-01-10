Return-Path: <netdev+bounces-60973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B68220EA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A3728369E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500F168A9;
	Tue,  2 Jan 2024 18:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304F1641A;
	Tue,  2 Jan 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4Ljl5CxWz9snC;
	Tue,  2 Jan 2024 19:19:55 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: Queue a HCI power-off command before rfkilling adapters
Date: Tue,  2 Jan 2024 19:19:20 +0100
Message-ID: <20240102181946.57288-5-verdre@v0yd.nl>
In-Reply-To: <20240102181946.57288-1-verdre@v0yd.nl>
References: <20240102181946.57288-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a lot of platforms (at least the MS Surface devices, M1 macbooks, and
a few ThinkPads) firmware doesn't do its job when rfkilling a device
and the bluetooth adapter is not actually shut down on rfkill. This leads
to connected devices remaining in connected state and the bluetooth
connection eventually timing out after rfkilling an adapter.

Use the rfkill hook in the HCI driver to actually power the device off
before rfkilling it.

Note that the wifi subsystem is doing something similar by calling
cfg80211_shutdown_all_interfaces()
in it's rfkill set_block callback (see cfg80211_rfkill_set_block).

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/hci_core.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1ec83985f..1c91d02f7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -543,6 +543,23 @@ int hci_dev_open(__u16 dev)
 	return err;
 }
 
+static int set_powered_off_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_set_powered_sync(hdev, false);
+}
+
+static void set_powered_off_sync_complete(struct hci_dev *hdev, void *data, int err)
+{
+	if (err)
+		bt_dev_err(hdev, "Powering HCI device off before rfkilling failed (%d)", err);
+}
+
+static int hci_dev_do_poweroff(struct hci_dev *hdev)
+{
+	return hci_cmd_sync_queue(hdev, set_powered_off_sync,
+				  NULL, set_powered_off_sync_complete);
+}
+
 int hci_dev_do_close(struct hci_dev *hdev)
 {
 	int err;
@@ -943,17 +960,27 @@ int hci_get_dev_info(void __user *arg)
 static int hci_rfkill_set_block(void *data, bool blocked)
 {
 	struct hci_dev *hdev = data;
+	int err;
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return -EBUSY;
 
+	if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED))
+		return 0;
+
 	if (blocked) {
-		hci_dev_set_flag(hdev, HCI_RFKILLED);
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
-		    !hci_dev_test_flag(hdev, HCI_CONFIG))
-			hci_dev_do_close(hdev);
+		    !hci_dev_test_flag(hdev, HCI_CONFIG)) {
+			err = hci_dev_do_poweroff(hdev);
+			if (err) {
+				bt_dev_err(hdev, "Powering off device before rfkilling failed (%d)",
+					   err);
+			}
+		}
+
+		hci_dev_set_flag(hdev, HCI_RFKILLED);
 	} else {
 		hci_dev_clear_flag(hdev, HCI_RFKILLED);
 	}
-- 
2.43.0


