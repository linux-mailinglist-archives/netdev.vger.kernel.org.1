Return-Path: <netdev+bounces-156212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2CA05899
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFF83A15BC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BB1F8931;
	Wed,  8 Jan 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOxZWnHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C11F1309
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333316; cv=none; b=M9pPGjoSWoHKtytEAIX5MQNM/C9GaG4BDJkIXkv9SQOz7u7ubQaTrzh5kdHj18rZJVvc6u+bofCfyH2tx7rDti4hX1990nN/bU9Qal1TmAiE5ryOzc5RZ7rGPwoeJaTe+h7U26S443i12NzDEgju7RWv5FHZANL9/X8igU2deTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333316; c=relaxed/simple;
	bh=30niDkZX2VnpWuCkBMMQwiZcmEeqXer4m0XVR7b8Elo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OaAlcrkcdU6Jmxz6I2k4C0zyn3CE2CKuu3o427l8RVXg7Bd58yHrdgDAo+AUpjF4zqz2pSMKVbX4fEG4yxHNi4nbsKuQOPtRULCKZiTDiClrV5CO/BNimj8z0CNL+qDJfNuIPo0HgAHFM+eoW3IpISxHWbvTAWpRE94YEFNy3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOxZWnHR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163a2a1ec2so49786465ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736333314; x=1736938114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nf5n3fvOdCFzPePcys9PQIDnTcq3K0L56wNYb00CE7g=;
        b=JOxZWnHRUaQnz2t9HCg8IsVC1J8XzXQ9jQ0Tx05ABAR0PBDRIrLjAHnQoSMtjlffsh
         FfPcbtW2/dTQWHHWyoSjQeMC/KkQOE5sfGMbk0SAzRWE2YgEf2twZX+vhQtvmEul8TgC
         +EdWOgVqdhHztKgHMQvboNLxLs+K2bEOE89DshT7jfniTY8Kjg4ttklGvinsb9bcRHoE
         esJFez8FHnYmYcyKRWqezqtlGGnrRHguSI4VpXzEC+/q7vWHYgeFnw1aWQqpwFmbVgSz
         GsyIBQPb0pZeHFI+CC5EBT55GWHUavnqSQ987TW/EcJ7uwqxxws71IzGOnaSN7cjuwwA
         JZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333314; x=1736938114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf5n3fvOdCFzPePcys9PQIDnTcq3K0L56wNYb00CE7g=;
        b=o/zbccFa1w9WeGSyOrl0flGtWfETMMUbIKD2AvaqaJuPZqH53HMMWks7uG++PQ+vHL
         os2/21RkV9K1yzb6YGAqJylD1nsXBW18Jl95R/ba493eCOnwTJVCVm8cz3Risw6WwOlx
         1+uph7ndp8fWbXtApLqql5WOrKb/ZvwItjkuT6jd6QwJ6c51dbQeQGWqPnvAqegU1caf
         +i0slNHTNehiBLik932Rr0n9lfvZjIFDFOD0dBUALjBUVxbkfl0OY8eiUikwDWHWBg4L
         mz+8qbxC4HwvCvggFe+FoB2uRkh0q60XpR25UYabfQ7w7FmLcjXiN/EEt8bOJVWUt/DK
         de+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVIHezTpSeiTYWq3EtEydi/ON7qzO9N4wsjs/DP1f5J0vIh2uoUqIQCNj4HDfG8fAVgwWCENk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv0m7twGiwkHsLC5xtca7twYTpxPF5o7wGL0EbEex0AUwbUwi+
	EZcfuYHNjvwX7SZLHkGykjzKqMnnWQLNRTwGeBSK7yyD8uquf0jI3lyRfH+5UBCK8GF9AnTnlRl
	0suWXyw==
X-Google-Smtp-Source: AGHT+IEpZFlHqKumrq0hCJ2Zb7jCn4vyAtOz66XaXruH3R4KORwpFkEongE7FqoB8phFgSrUYPseeLW610sx
X-Received: from pglr12.prod.google.com ([2002:a63:514c:0:b0:7fd:4c8f:e6a1])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c89b:b0:1e1:aef4:9cd0
 with SMTP id adf61e73a8af0-1e88d139b44mr4156324637.3.1736333314283; Wed, 08
 Jan 2025 02:48:34 -0800 (PST)
Date: Wed,  8 Jan 2025 18:48:12 +0800
In-Reply-To: <20250108184811.v2.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108184811.v2.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108184811.v2.2.Icd16ca64a5d7e212c2801b3b39f65a895fb3e9b4@changeid>
Subject: [PATCH v2 2/3] Bluetooth: Get rid of cmd_timeout and use the reset callback
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

(no changes since v1)

 drivers/bluetooth/btmtksdio.c    |  4 ++--
 drivers/bluetooth/btusb.c        | 16 ++++++++--------
 drivers/bluetooth/hci_qca.c      |  6 +++---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  4 ++--
 5 files changed, 15 insertions(+), 16 deletions(-)

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
index 916e9ec7bc85..b53d0099a1cb 100644
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
+		hdev->cmd_timeout = btusb_intel_reset;
 
 		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
@@ -3911,7 +3911,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-		hdev->cmd_timeout = btusb_qca_cmd_timeout;
+		hdev->cmd_timeout = btusb_qca_reset;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		btusb_check_needs_reset_resume(intf);
 	}
@@ -3925,7 +3925,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
-		hdev->cmd_timeout = btusb_qca_cmd_timeout;
+		hdev->cmd_timeout = btusb_qca_reset;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		hci_set_msft_opcode(hdev, 0xFD70);
 	}
@@ -3944,7 +3944,7 @@ static int btusb_probe(struct usb_interface *intf,
 		btrtl_set_driver_name(hdev, btusb_driver.name);
 		hdev->setup = btusb_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
-		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
+		hdev->cmd_timeout = btusb_rtl_reset;
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


