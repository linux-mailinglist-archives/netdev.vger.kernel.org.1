Return-Path: <netdev+bounces-156255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF11A05B84
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B6D1883969
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C71FA826;
	Wed,  8 Jan 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rn4WX+7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA81F9F7F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339124; cv=none; b=ryM3jDWVdQ4s8KgPixnAx2bcK4mk+TKm9AGIGmhuWNbN7InuFM4Q7J4agDOG394omUZBudtSFU+sykSUiJS7hwe6G1p9pBXMmRRjAzd04OJf14La+Oa1n9J06sstyOdYCsjLKLAcfF4ve/pNtVifQFgaEMwdMoU9a//3lBW4N/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339124; c=relaxed/simple;
	bh=6kA8g+OSc2ljb6KsKmB4k2YSfp7PdMRqb0spe+9cA/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Utkraq94rs5ofwaSup+PaHCQP7F67r12Y7izQ9rhsXoCMkiy39KPIuipUW84KmldJfqT0X2o8WICElzHDlLTf8/EYeCvXuB2LcX6utrIc2jZqdtzYuxcBZtggggiivUVxJ5ReYKdKUdZi+ByT46AAKZZ3ZfMY4Zsz25Pqxacf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rn4WX+7L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21650d4612eso103400715ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736339122; x=1736943922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbsIPENaTak5ngKp77odq0MaZnsc1/fTORrBGc6hWGk=;
        b=rn4WX+7LHAm4fZ8VUM/PMP5pLkiMbeNcVICR2HrXnpWfwAoSqzkXi6uj0LLqDOUdmz
         c32lNGoEmFnqHP0NXOAXqGply74hHRqRCFBVecwrFPGinRYDoHh2xze4EPx0RnESDU5k
         VU1Ip+GxAM8V5WXh77ldoRZYMSOFIFbNug9/h4509+SgnLCwBwpsh/M9JH6XjTSND8K5
         yMSg1d3TvuZyAqf+JOl3AnyEKhptzpvVKhr0v9en9QOmmvj7vN3alTbYg4ilGcpL97Wk
         kFes4mXCQ5b1vPqH5STtnquUKpuXhvFxpYB5P9FK3reAnehQa/fb7KuZxAPJO9M+VdTO
         hTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339122; x=1736943922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbsIPENaTak5ngKp77odq0MaZnsc1/fTORrBGc6hWGk=;
        b=HFKblIzXbFOiABc84TJ5vV6CTS0KkQvrv7g2SoSMmhavTnTVybCVd14l0hbTFgr2gy
         1bjx+KTluG5bJoVsk9zGSPCx6BZTQjGkvBArmiTRyLuQdyZGBpuVksBizoFa3QUJ3O1R
         3rEAWyJ15IJS+Go7lV7sLQLqw36a8IpZInmas783ZsncYSG0/u4BU2HZ/KEdClZKQ9p/
         egmFhMaK4eLg+TwmU0dvXHJpovUF/M9Vd4Df1LCGZZ1bkhDNmH79tcfWgzMMI2haXMNZ
         UqzTmv2hueJqE0VX61xsI/FLeILdFNTHm5n3h7WmrDiD6TaVZa8JOLvie1OfWqE/mwt5
         J47A==
X-Forwarded-Encrypted: i=1; AJvYcCVY7YkHX14PjzWebuwVaQ/fEKb/vXHJGvViKLQ84Ij1KmOOtEoH1qtEwB0R9nZrICaluBxA1Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElYmQqsk6i1rt6y5Wy75xu//MXGpwkkLVwa57X/z6EoudouuM
	mun1Od+8n7JPGAjIcC/ZJJbLgyJHYVRo2bsGLMEt4olxIoSWJl7hlDsDg9+ORxcMC+K1n7aSo/B
	XG6eh7w==
X-Google-Smtp-Source: AGHT+IGjq+hYgA/Nz34xPugyz/a/Dm4vp6VflM9tKHIXxupKqgfhPnTStP9ZzV5y0kH9n9lSI3SqXwa8NYsB
X-Received: from pfxa4.prod.google.com ([2002:a05:6a00:1d04:b0:728:e245:6e93])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9144:b0:1e1:d22d:cf38
 with SMTP id adf61e73a8af0-1e88cfd2144mr4760292637.21.1736339122405; Wed, 08
 Jan 2025 04:25:22 -0800 (PST)
Date: Wed,  8 Jan 2025 20:24:43 +0800
In-Reply-To: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108202442.v3.2.Icd16ca64a5d7e212c2801b3b39f65a895fb3e9b4@changeid>
Subject: [PATCH v3 2/3] Bluetooth: Get rid of cmd_timeout and use the reset callback
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The hdev->reset is never used now and the hdev->cmd_timeout actually
does reset. This patch changes the call path from
  hdev->cmd_timeout -> vendor_cmd_timeout -> btusb_reset -> hdev->reset
, to
  hdev->reset -> vendor_reset -> btusb_reset
Which makes it clear when we export the hdev->reset to a wider usage
e.g. allowing reset from sysfs.

This patch doesn't introduce any behavior change.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v3:
- Fixed build failure

 drivers/bluetooth/btmtksdio.c    |  4 ++--
 drivers/bluetooth/btusb.c        | 18 +++++++++---------
 drivers/bluetooth/hci_qca.c      |  6 +++---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  4 ++--
 5 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index a1dfcfe43d3a..bd5464bde174 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1249,7 +1249,7 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
-static void btmtksdio_cmd_timeout(struct hci_dev *hdev)
+static void btmtksdio_reset(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	u32 status;
@@ -1360,7 +1360,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 
 	hdev->open     = btmtksdio_open;
 	hdev->close    = btmtksdio_close;
-	hdev->cmd_timeout = btmtksdio_cmd_timeout;
+	hdev->reset    = btmtksdio_reset;
 	hdev->flush    = btmtksdio_flush;
 	hdev->setup    = btmtksdio_setup;
 	hdev->shutdown = btmtksdio_shutdown;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 916e9ec7bc85..c891da6483a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -907,7 +907,7 @@ static void btusb_reset(struct hci_dev *hdev)
 	usb_queue_reset_device(data->intf);
 }
 
-static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
+static void btusb_intel_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
@@ -985,7 +985,7 @@ static inline void btusb_rtl_alloc_devcoredump(struct hci_dev *hdev,
 	}
 }
 
-static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
+static void btusb_rtl_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
@@ -1029,13 +1029,13 @@ static void btusb_rtl_hw_error(struct hci_dev *hdev, u8 code)
 	btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
 }
 
-static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
+static void btusb_qca_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
 
 	if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
-		bt_dev_info(hdev, "Ramdump in progress, defer cmd_timeout");
+		bt_dev_info(hdev, "Ramdump in progress, defer reset");
 		return;
 	}
 
@@ -3859,7 +3859,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->reset = btusb_intel_reset;
 
 		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
@@ -3879,7 +3879,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->setup = btusb_mtk_setup;
 		hdev->shutdown = btusb_mtk_shutdown;
 		hdev->manufacturer = 70;
-		hdev->cmd_timeout = btmtk_reset_sync;
+		hdev->reset = btmtk_reset_sync;
 		hdev->set_bdaddr = btmtk_set_bdaddr;
 		hdev->send = btusb_send_frame_mtk;
 		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
@@ -3911,7 +3911,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-		hdev->cmd_timeout = btusb_qca_cmd_timeout;
+		hdev->reset = btusb_qca_reset;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		btusb_check_needs_reset_resume(intf);
 	}
@@ -3925,7 +3925,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
-		hdev->cmd_timeout = btusb_qca_cmd_timeout;
+		hdev->reset = btusb_qca_reset;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		hci_set_msft_opcode(hdev, 0xFD70);
 	}
@@ -3944,7 +3944,7 @@ static int btusb_probe(struct usb_interface *intf,
 		btrtl_set_driver_name(hdev, btusb_driver.name);
 		hdev->setup = btusb_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
-		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
+		hdev->reset = btusb_rtl_reset;
 		hdev->hw_error = btusb_rtl_hw_error;
 
 		/* Realtek devices need to set remote wakeup on auto-suspend */
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 37129e6cb0eb..c7ef38fd5e8e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1638,7 +1638,7 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
 }
 
-static void qca_cmd_timeout(struct hci_dev *hdev)
+static void qca_reset(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
@@ -1968,7 +1968,7 @@ static int qca_setup(struct hci_uart *hu)
 		clear_bit(QCA_IBS_DISABLED, &qca->flags);
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
-		hu->hdev->cmd_timeout = qca_cmd_timeout;
+		hu->hdev->reset = qca_reset;
 		if (hu->serdev) {
 			if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
 				hu->hdev->wakeup = qca_wakeup;
@@ -2202,7 +2202,7 @@ static int qca_power_off(struct hci_dev *hdev)
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 
 	hu->hdev->hw_error = NULL;
-	hu->hdev->cmd_timeout = NULL;
+	hu->hdev->reset = NULL;
 
 	del_timer_sync(&qca->wake_retrans_timer);
 	del_timer_sync(&qca->tx_idle_timer);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 84b522a10019..f756fac95488 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -633,7 +633,6 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-	void (*cmd_timeout)(struct hci_dev *hdev);
 	void (*reset)(struct hci_dev *hdev);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 899b6f81966a..67032d21540c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1457,8 +1457,8 @@ static void hci_cmd_timeout(struct work_struct *work)
 		bt_dev_err(hdev, "command tx timeout");
 	}
 
-	if (hdev->cmd_timeout)
-		hdev->cmd_timeout(hdev);
+	if (hdev->reset)
+		hdev->reset(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
 	queue_work(hdev->workqueue, &hdev->cmd_work);
-- 
2.47.1.613.gc27f4b7a9f-goog


