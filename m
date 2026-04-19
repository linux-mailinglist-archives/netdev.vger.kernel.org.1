Return-Path: <netdev+bounces-279570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDtbF62D5GmzWAEAu9opvQ
	(envelope-from <netdev+bounces-279570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A3423515
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59CE3027699
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836E33E379;
	Sun, 19 Apr 2026 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmdva0p7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF637474B
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776583491; cv=none; b=shGst0r9jB7agoixIJt/Krp6MOMDVmFidKzH1o72u+qBGZV0Gy3UO0WpoK3O56Rfdyq1v1k+3A4UJIDoW8QPU0WK07cuhSY+lsGlHD1AIheW6xXu3EzarD54LKbA9WVi3LZz06ciFJxFC/j0a1HhqgdWBxWGCV8ajYql2mimwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776583491; c=relaxed/simple;
	bh=J14UXlGIcYcigiWAwLCstC3TmsB/OQZiIyPKbeH99yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idIvvTWNieXg1cjCu6OF4Bu0pp5KuAyq5DAhvFWK695pWNTHYAvL3cEJNs1QeLrHXRS9KkGrqz44VbbFIEmRXs/9sAxTN82cA0EYx4cauK9cBrCNIdaNwZdLtWdB56PRnLtX49ZTm9gDTxAd8XLiQ5E+Be9j7WIOCshP5ikowi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmdva0p7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488afb0427eso26049755e9.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776583488; x=1777188288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqTpJplCXuGTQVzh35cdkgwJEWQnN+JdRURPZVphV0U=;
        b=qmdva0p7rsZqmmrDslSOt9wAPp1E/JJJK9MvDFMxtsbeCZpwAhNd316jw1iFF+Ozkk
         iJnsbpvvmQ/iV0b74EH4kAGFPfwaYbR4AHLnU306DLiHVX1m67XpwdAfYf5GOu6D+xiV
         wrN7xzctaA0x0cTspDRgBLWzuUkyK5JfqI4ks/xIHkYNNl7G8U3X1h5dsf59fVJuxgDp
         T5VEWZvrVoDl3R8fYm1Mz1NEcN7pryK/gDCbLfM5upvjOhDgslJRBySJ+7oZW/Xl01HC
         1zq1Wgbbk20Fj1HExwwbdvzNbQUISm+Glua2VxmPt1RhlITqB6iZZIKn975HfNUa4I5j
         qEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776583488; x=1777188288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqTpJplCXuGTQVzh35cdkgwJEWQnN+JdRURPZVphV0U=;
        b=KhoZcAIq8HtpEQxSAAIO8MZzbWRSrGCC1O4V4Fvl0RJ6w9oG2y15JzmGIbgN2OLoq6
         23QT9Jae0dNgX8kFddYhqVGvOtulweSfN0FpfKZYhN6An0UwDvmeE6O+T494OUITu9Te
         sztit3vugDTdP+6ihkoF6LVaVfsIK5CVBMuuc3T/VMJxXi9F0p5///JOa9ZEPsx1jEOm
         rllr+lvC9Ru8ASodbtZ87cxtX2kJNSQqP6pxIdvdmQTVlwP+UAiVzc1qjNA1V6aFHZGE
         qJBGUjJ5EDib3cXH9givHKWg0tdSFrqPNZrm8XoKQV9k2kZ8tgKCauRgB7jFN+VZyxX8
         fyKg==
X-Forwarded-Encrypted: i=1; AFNElJ/cnF94d7kYi4/qPb89mb0gtRRBgJr94Ue9kTqkS9Ymd67DTnxD0umINlEaFanA0KGgYYkhhyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmw1DiINe+i5b/YfHtrvGx+wwvGlZtB92Rbhpoe2NspxLSPj7V
	ug2O6snvZe3MiwCYGUyMqREYER7DWPYi4hXqfa8XCcqPAmMMOWDMKCmo
X-Gm-Gg: AeBDievZv0WUFS6q7fdn+Tu04fpTJ7P/V7ofWM1ZjM2lh0ar58zHvLQQ1hWnK8fzlGw
	1edDOsil1yD3ni8iGRc45vsj8LsYfaXPpFThTHJfT342HRFRU/uwRpHidcT5J0IosioB1huq6Lt
	c2WfAVdsGzo5BJQQtxWrm9MXBW/mNzHm9x2rNWcUMJahCRknktUeHBvOxQFUhl5aGXVkUgOURb1
	JzCcJ1/QHXq81/+0FzHhfgvKTdSOiqfNqSGXE9OHDf4dMnbkqj8gSnESVFyGF2Q/DZtM0A8GsB0
	qob4wua3US8nDtp02hIJDuZ5cAdbHIQI8dykApmbdQDDK2znZ7oPkAxG0wTfDOVhpvhSJ9r3i4l
	cZ2l5YUdIUL/s/Pyz46VNra0oTY46YAYkBLk+9OK5+m/hwjxBiH0uD42Zh2yrv1sqKc7vqU/wDL
	+GIp8e2FkpcU+2nb9uwd555R3jskLd6gAU96nDxsMfTfUiHl7f7CE1Mqt10bNVhUf0C6JZNf7OU
	ZExTJHa42DwlkqgNFyyRs4xfFW7wLhZ1Rdd7Cxk5CblMUMk
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488fb78e7c5mr119713815e9.28.1776583487791;
        Sun, 19 Apr 2026 00:24:47 -0700 (PDT)
Received: from server ([5.14.142.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm169076205e9.2.2026.04.19.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 00:24:46 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for combo chips
Date: Sun, 19 Apr 2026 10:24:33 +0300
Message-ID: <20260419072433.55976-1-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279570-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[condorachest@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DF1A3423515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Realtek combo chips share a single antenna between Wi-Fi and Bluetooth.
Background LE passive scanning while an active connection exists causes
antenna multiplexing conflicts via Packet Traffic Arbitration (PTA),
resulting in audio stuttering and Wi-Fi packet loss.

Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive scanning in
hci_update_passive_scan_sync() when active connections are present.
Set this quirk for all Realtek devices in btrtl_set_quirks().

Also add device ID 0x0bda:0xc829 to the btusb Realtek device table.

Signed-off-by: StefanCondorache <condorachest@gmail.com>
---
 drivers/bluetooth/btrtl.c   |  6 ++++++
 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_sync.c    |  7 +++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3a4f..00dfba656970 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1299,6 +1299,12 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
 void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 {
+	/* Realtek combo chips share the antenna between Wi-Fi and
+	 * Bluetooth. Suppress passive scanning while connected to
+	 * prevent coexistence issues.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED);
+
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f57953393be..87972f5fc567 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8822CU Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xc829), .driver_info = BTUSB_REALTEK |
+							 BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d..8466dc52aeca 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -378,6 +378,17 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 
+	/* When this quirk is set, the controller suppresses passive LE
+	 * background scanning while an active connection exists.
+	 * This is required for combo chips with shared Wi-Fi/Bluetooth
+	 * antennas to prevent coexistence issues causing audio drops
+	 * and Wi-Fi packet loss.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
+
 	__HCI_NUM_QUIRKS,
 };
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..5e30e725efa2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	if (hdev->discovery.state != DISCOVERY_STOPPED)
 		return 0;
 
+	/* If the controller requires no scanning while connected,
+	 * suppress passive scanning when an active connection exists.
+	 */
+	if (hci_test_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
+	    !list_empty(&hdev->conn_hash.list))
+		return 0;
+
 	/* Reset RSSI and UUID filters when starting background scanning
 	 * since these filters are meant for service discovery only.
 	 *
-- 
2.53.0


